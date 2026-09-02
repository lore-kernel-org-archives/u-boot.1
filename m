Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECA7C61DD6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 06:31:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 472BB80E80;
	Wed,  2 Sep 2026 06:31:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Culf-nP3J162; Wed,  2 Sep 2026 06:31:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788330687;
	bh=IQoVHg2laPR67vQmaxROzM89rfIflvnzZWOyP5/taDg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sUUEJKiEoB/vLPTjwTAo9AVdaFo8N/9mPF7OvBUIKTqgF7tYXNONr/dHjCctCtXMK
	 9QyzXkQANgHaWA6GOof39+0WAS9iqrE93hMjZ4U6IhGVsUxz59l7Qemznebt4DbYap
	 70NqjNlnfGvF2LRz1Mp0XYZeLko+nOD1+0DBQVwSsEXyQ8eL90nzi2iZtCyN6AYlTE
	 cFwqTfbOfwuGuQ6hJUI2f024m8i3Nxd5vwfMt2jKZZPodHhs1tQSkrWBAr4ZToXp1a
	 OOm61oFYQqh4IjabwMSICOa7NuoGlHnuBRPx3BSFrYwdLLLO0bWX6B8Pt1w7H7yL/r
	 /WhOnLp8d27YQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31F7080E54;
	Wed,  2 Sep 2026 06:31:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F79F230
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 06:31:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0198E60633
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 06:31:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MyxrwdUxNjDt for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 06:31:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.154.239.86;
 helo=forward103a.mail.yandex.net; envelope-from=nikita.shubin@maquefel.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me
 header.a=rsa-sha256 header.s=mail header.b=UeA4Vmoe
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net
 [178.154.239.86])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 32A14607A9
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 06:31:21 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c17:2010:0:640:2180:0])
 by forward103a.mail.yandex.net (postfix) with ESMTPS id 272E880B62;
 Wed, 02 Sep 2026 09:31:14 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id 9VdE69DeMiE0-Sgwq0kGr; 
 Wed, 02 Sep 2026 09:31:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1788330673; bh=IQoVHg2laPR67vQmaxROzM89rfIflvnzZWOyP5/taDg=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=UeA4VmoeoxqTbI0E6xkI3LQiFup1S+J+e8j7DP5/+WxBzdFYvyi4yyiAH95879aVT
 9ZHirOV/gX1B4qlvbpdfxwHJxNXlk0GN6VtPAaNai+rgYHdgERu2SzbTxmt20r8MBi
 4APpkun1ZJPnjzTSq/6+31IwbA5RpHP3Isc3CMJY=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Wed, 02 Sep 2026 09:31:12 +0300
Subject: [PATCH v2 2/6] common: spl: ram: Add LOAD_FIT_FULL support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-riscv-full-fit-support-v2-2-493e904a129e@maquefel.me>
References: <20260902-riscv-full-fit-support-v2-0-493e904a129e@maquefel.me>
In-Reply-To: <20260902-riscv-full-fit-support-v2-0-493e904a129e@maquefel.me>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788330671; l=1475;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=VPWuzOii35OeXbkPuLfADGzheGrgTMfgefI+vxr0ucU=;
 b=D3uX1rQ3TzE2Lf3CwRyXZCZtKb0IZXsEnpwcqBs3uhtvmWA7KHV7ZgeuKRNrmEUbqwRBQBSUC
 mV9sVNS+UIBCUJsGFgYH4tcIbLsGoxpn9G0axvNcPW25tZth/18zCJ7
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The simple FIT loader lacks support for full image verification
(CONFIG_SPL_FIT_FULL_CHECK). The full parser (spl_load_fit_image)
provides this feature.

Enable it when CONFIG_SPL_LOAD_FIT_FULL is selected. If the full load
fails, fall back to the simple loader to preserve compatibility.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 common/spl/spl_ram.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
index 0c501cf02f2..8f63a46373f 100644
--- a/common/spl/spl_ram.c
+++ b/common/spl/spl_ram.c
@@ -81,11 +81,22 @@ static int spl_ram_load_image(struct spl_image_info *spl_image,
 
 	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) &&
 	    image_get_magic(header) == FDT_MAGIC) {
-		struct spl_load_info load;
-
 		debug("Found FIT\n");
-		spl_load_init(&load, spl_ram_load_read, NULL, 1);
-		ret = spl_load_simple_fit(spl_image, &load, 0, header);
+		/* by default, assume failure and fall back to simple FIT */
+		int ret = -1;
+
+		if (CONFIG_IS_ENABLED(LOAD_FIT_FULL)) {
+			ret = spl_load_fit_image(spl_image, header);
+			if (ret)
+				debug("Loading FULL FIT failed, trying SIMPLE FIT\n");
+		}
+
+		if (ret) {
+			struct spl_load_info load;
+
+			spl_load_init(&load, spl_ram_load_read, NULL, 1);
+			ret = spl_load_simple_fit(spl_image, &load, 0, header);
+		}
 	} else {
 		ulong u_boot_pos = spl_get_image_pos();
 

-- 
2.54.0

