Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A93D60CFD
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 00:12:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DA9889386;
	Tue, 19 Nov 2024 01:12:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="IXTcUAQq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0606C89442; Tue, 19 Nov 2024 01:12:42 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 665B189173
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 01:12:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=c52e=SO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1731975150;
 bh=7A5x5WViwKCW9df2AQ3/e/FXV1SFyMkRIm1fxjPHBtY=;
 b=IXTcUAQq3B/bv23RKn++VyKoYRqm9LDWoPYbe0u1zsxJlsCnSzEfOs8Hm8lIdVwZrtcVD7Dx/
 fnVpWfAO81dT/5ZHITLPEW7CVphjPtkM+IBWUSLmvx4O5J+wbrSjqG2vIcVSWdcrsSNzf5ZZWsq
 Mnv0sYz2NuchqCFlleK2Tak2jAgPsjq265nxvjA4CkWcU7CEGbeoE5Tp+7nx4oFKW9KEaefcy+P
 7ceIiADsBDK1GHILT2VEByGFuoM4rJm/CC7Ng8TA9hHj8Vm78thcHbj7ZBqI87rg8RUsPcp5xYi
 M0ghnRbmkN0Zy/NMqzxtIGRwtznDoZBPVRAPTA9Cpp6Q==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] rockchip: rk3399-rock-pi-4: Fix Synchronous Abort
Date: Tue, 19 Nov 2024 00:12:19 +0000
Message-ID: <20241119001222.3795292-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 673bd7ed0fa7f4b3c3e88357
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

After the commit 788cf33315c7 ("efi: add a helper to generate dynamic
UUIDs") update_info.num_images must match number of valid update images.

On Rock Pi 4 following Synchronous Abort can be observed due to fw_name
being NULL:

  Scanning global bootmeth 'efi_mgr':
  "Synchronous Abort" handler, esr 0x96000010, far 0x0
  elr: 0000000000200e28 lr : 000000000028adb8 (reloc)
  elr: 00000000f3efbe28 lr : 00000000f3f85db8
  x0 : 0000000000000000 x1 : ffffffffffffffff
  x2 : 0000000000000000 x3 : 000000000000000e
  x4 : 0000000000000000 x5 : 00000000f1ef0d78
  x6 : 00000000f3fb3b90 x7 : 0000000000000044
  x8 : 0000000000000010 x9 : 0000000000000031
  x10: 00000000f0ea3fff x11: 00000000f1f29e00
  x12: 0000000000000002 x13: fffffffffffff000
  x14: 00000000f1f29e00 x15: 0000000000000018
  x16: 00000000f3f44f7c x17: 0000000000000000
  x18: 00000000f1ef2de0 x19: 00000000f0ea3040
  x20: 00000000f3ff53d8 x21: 00000000f3fd0498
  x22: 0000000000000000 x23: 00000000f1edb960
  x24: 00000000f1edb95f x25: 00000000f1edb990
  x26: 00000000f1edb964 x27: 00000000f1edb998
  x28: 00000000f1edc1ec x29: 00000000f1edb820

  Code: aa0003e2 d2800000 eb01001f 54000060 (78607843)
  Resetting CPU ...

  resetting ...

Fix this by setting update_info.num_images to 0 when no valid update
images is added to update_info.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 board/radxa/rockpi4-rk3399/rockpi4-rk3399.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c b/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c
index fd827467b30a..856b434df36d 100644
--- a/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c
+++ b/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c
@@ -52,6 +52,8 @@ void rockchip_capsule_update_board_setup(void)
 
 		fw_images[0].fw_name = u"ROCKPI4C-IDBLOADER";
 		fw_images[1].fw_name = u"ROCKPI4C-UBOOT";
+	} else {
+		update_info.num_images = 0;
 	}
 }
 #endif /* CONFIG_EFI_HAVE_CAPSULE_SUPPORT && CONFIG_EFI_PARTITION */
-- 
2.47.0

