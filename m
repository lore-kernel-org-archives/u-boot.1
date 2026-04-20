Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B78F5A8C5
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 22:03:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C08A4844AC;
	Tue, 21 Apr 2026 00:03:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="sKw+zkr7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0E74844BF; Tue, 21 Apr 2026 00:03:31 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72AD6844BF
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 00:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-176-199-115-125.um44.pools.vodafone-ip.de
 [176.199.115.125])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 7E07940D85; 
 Mon, 20 Apr 2026 22:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1776722608;
 bh=qu+EYhoQvd8e1u9o6kJhs6pwyVt/llp48a9tfz2pcfA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=sKw+zkr7ArtPAbbhR58ENHl75Hj70WnillCfdFGgfwIEIyxb7hK92wXETnFqzr7LL
 yBydcaDA8vp/HrEE0TXFNFRPhaopBxUPTZtuBbISogL6sTuL4l2PrhxJgwCyOomb2M
 aC0Psda2f+eX5O4RvQfgTtUjtsL18Lf5DKyP2f/+XO5KBeV6ycRbZChlSd/3/u/glU
 eJAzAZ+RWKP4W8lbSx4SNbXDAkFLesmXN87j/MQ2fRoA18eJo/kG5iBUrkvTsjfnIQ
 9i92o0mXbyzr86K/g9LKrqSyW63BdprR4B5Ah5KbIaf272+ino6bErqIwoQEBoWyfw
 xkZSpbX4nlzS9Xjzqz2aRKB40+qNOrJr/4xnJnBTwhNfnHqPApjh4S8DonRP7uR0ha
 Z1prnaxG5Lxy/vf4j3eU9GWRRJ+qd+gS80bkXR65nPA2nu5QyH3h7EYVnstneR/eox
 4ZKYm3irwc1/I3qE8KwlNQz60vgPu5rbOMPfytYRGSu5ArYWyWbPwqwV8cjNdau6sV
 G6qlMaYYFfobOkFRzvZ0ev4peULi4++SkCdVxlG6pmfyDr8PRvg1dWzJcCki5bPBdi
 gR5anNYFCKPBHspSay3zQiF5vGaEEg/iS732cdsqmud0Ek2pAMf2xbLGX4++t+6yvO
 YiW/cXMa2suDqTE+VVH/Gz2w=
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
Subject: [PATCH v2 2/4] efi_loader: correct return value of efi_bootmgr_run()
Date: Tue, 21 Apr 2026 00:03:19 +0200
Message-ID: <20260420220321.71147-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420220321.71147-1-heinrich.schuchardt@canonical.com>
References: <20260420220321.71147-1-heinrich.schuchardt@canonical.com>
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

efi_bootmgr_run() is expected to return an efi_status_t value.

Reported-by: Simon Glass <sjg@chromium.org>
Fixes: 0bef4b0123f2 ("cmd: bootefi: move library interfaces under lib/efi_loader")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	new patch
---
 lib/efi_loader/efi_bootmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index a687f4d8e85..52ccebab19f 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -1313,7 +1313,7 @@ efi_status_t efi_bootmgr_run(void *fdt)
 	if (ret != EFI_SUCCESS) {
 		log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
 			ret & ~EFI_ERROR_MASK);
-		return CMD_RET_FAILURE;
+		return ret;
 	}
 
 	ret = efi_bootmgr_load(&handle, &load_options);
-- 
2.53.0

