Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DA6F5A8BC
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 22:03:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3AE884486;
	Tue, 21 Apr 2026 00:03:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="IHaShLCE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B132844CF; Tue, 21 Apr 2026 00:03:29 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A17984485
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 00:03:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-176-199-115-125.um44.pools.vodafone-ip.de
 [176.199.115.125])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 20A2A40912; 
 Mon, 20 Apr 2026 22:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1776722606;
 bh=hk1Sa6Kt1812TkO6ndUPWWKYwA+X9UC0ldfRU2SGQuk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=IHaShLCENkMteOW6AS6OfV/0EmhZjTrHukowh4BKaU2l3cCUagwAU9RHODA4BpT3l
 KTACoirK0YhCQ6K/51QLORnakFy4JDPBudpC7Hd2E3Ag+SkRjK2aR9d1dZeF1DXhpq
 x0QziuQzagZxyIJ1BHckvXb4eFONsXZE8vDuJqXSY1BR0iSUGZTGZRXYiXoyQ/FDd2
 x4KN8u1JwoEW4odJp7taFI26HftTQpvsb/OzipsX9JdarUL2QXk8qnQecI+R0T4Zjv
 EatrZFA4M1EmQ9rxT6qlNwrSqhRZIjyw6nMyHRUcRy2P2K7kWgSADEDLE7m1CNn1Se
 bxqRXjliRdZAhdDtHSkbXApMKCKSJg2m718g9ImlJThCLDkp3FQiyANPZeRdPX7nmm
 CLdaSrPzE5YveIWR0ZUzI2uujY9pSFd3CCJk7Gn5FRj3iRBOPcUkki6RDH0+nRBtr8
 wEBJisyqq4OQpmZlOa/bRgW1kRn+0M4bS3qqaA5cCK2sVy0g19HJxkqBqM+TfeCh1x
 H81h0EwH8lbVrcgpYjymf1FymoLBT3GPUYYZkUL6y1xVZou4W3qluhE8hVgPIpu4+/
 ChZe8s5Q/w3qasDWGbrXmHs9mYebS+DYMSb9QlvWTZSQy2GrLHBl7msvNyglUyIteZ
 i3ZLMVpb5TjLIg4GO6r2Czt4=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Martyn Welch <martyn.welch@collabora.com>, Javier Tia <floss@jetm.me>,
 Ying-Chun Liu <paul.liu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/4] efi_loader: centralize messaging for efi_init_obj_list
Date: Tue, 21 Apr 2026 00:03:17 +0200
Message-ID: <20260420220321.71147-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

If efi_init_obj_list() fails we cannot use the UEFI sub-system.

* Instead of having messages for this everywhere write an error message
  in efi_init_obj_list().
* Always use (ret != EFI_SUCCESS) when checking the return value of
  efi_init_obj_list().
* Remove the return code from the error message as it does not help
  users to understand which initialization went wrong.

In do_bootefi() move the check to the start of the function.

Correct return values of efi_bootmgr_run() and efi_binary_run_dp().

v2:
	Correct return values of efi_bootmgr_run() and efi_binary_run_dp().

Heinrich Schuchardt (4):
  cmd/bootefi: move efi_init_obj_list() to the start of do_bootefi
  efi_loader: correct return value of efi_bootmgr_run()
  efi_loader: correct efi_binary_run_dp() return value
  efi_loader: centralize messaging for efi_init_obj_list

 boot/bootmeth_efi_mgr.c      |  4 ++--
 cmd/bootefi.c                | 13 +++++--------
 cmd/bootmenu.c               |  6 +-----
 cmd/eficonfig.c              |  6 +-----
 cmd/efidebug.c               |  5 +----
 cmd/nvedit_efi.c             | 10 ++--------
 lib/efi_loader/efi_bootbin.c |  7 ++-----
 lib/efi_loader/efi_bootmgr.c |  7 ++-----
 lib/efi_loader/efi_setup.c   |  2 ++
 9 files changed, 18 insertions(+), 42 deletions(-)

-- 
2.53.0

