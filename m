Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF8ECD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 06:05:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BD208466E;
	Mon,  1 Jun 2026 08:05:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="cEtGC4Tn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A98A3846A7; Mon,  1 Jun 2026 08:05:39 +0200 (CEST)
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch
 [109.224.244.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B4AC840ED
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 08:05:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1780293936; x=1780553136;
 bh=OV7qa7tssPwN9gpcCppwVh4nw41/MVSfXiNgwULkZC4=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=cEtGC4Tn1Yuj3R708dUsS177s+F2fabQrBm7k2kqpzFjbh4gSCKjhWc0pZ1P2WBtR
 Wnyq4wF+SsZVJD75DtldseDT5Ist4x1gpHHdWe9uPSErfDFqlE4bHGf6C/lOaHhJLw
 +Ct0o9gUUgH1bn13HCJDrgRWR81PpdGsNWGLCpIArmEmtjL0Wd8q47Tn2blAX2ssbb
 YzsFeXC/NO2lwWxGkkrVnRcD8IwcgPTwJXCjSB5cBBLqZXCGbXAMHhgIodLeQwI0p8
 NiH74YlkRdlCMB8mw5s4I8TwZ9vlSTB38n8QZkR7u/Aqz31ZFD4gWX7igkTdPcAowV
 UG57Nad8WXrxg==
Date: Mon, 01 Jun 2026 06:05:33 +0000
To: Rob Clark <robdclark@gmail.com>, u-boot@lists.denx.de,
 Casey Connolly <casey.connolly@linaro.org>
From: Sam Day <me@samcday.com>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, Sam Day <me@samcday.com>
Subject: [PATCH] video: simplefb: fix rot prop handling
Message-ID: <20260601-simplefb-rot-fix-v1-1-eb65d41ffffd@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: b8902c8ba0e06a4020e4059b3b82ab5c68039ee6
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

If the simplefb node lacks a rot property (which would be most of them
nowadays - it's not actually a valid prop according to kernel's
simple-framebuffer schema), then the rot local is left uninitialized.
This causes video_post_probe to fail to locate the vidconsoleN device
later.

Strangely enough, simplefb has been working fine on arm64 targets. It
wasn't until I tried simplefb on my arm32 device (samsung-expressltexx)
that this issue manifested. AFAICT, ARM64 doesn't have something like
-ftrivial-auto-var-init=3Dzero enabled, so I suspect this has just been
working entirely by coincidence until now. Computers are fun.

Fixes: 91e9687b49e7 ("video: simplefb: modernise DT parsing")
Signed-off-by: Sam Day <me@samcday.com>
---
 drivers/video/simplefb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
index 8d0772d4e51..ed8d4170cfc 100644
--- a/drivers/video/simplefb.c
+++ b/drivers/video/simplefb.c
@@ -19,7 +19,7 @@ static int simple_video_probe(struct udevice *dev)
 =09int ret;
 =09fdt_addr_t base;
 =09fdt_size_t size;
-=09u32 width, height, stride, rot;
+=09u32 width, height, stride, rot =3D 0;
=20
 =09base =3D dev_read_addr_size(dev, &size);
 =09if (base =3D=3D FDT_ADDR_T_NONE) {

---
base-commit: 30b77f6aa146c96b831cb4ece038130b655b6a41
change-id: 20260601-simplefb-rot-fix-7afa95d24118

Best regards,
--=20
Sam Day <me@samcday.com>


