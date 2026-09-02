Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A131C624D4
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 06:31:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3BBB1407E5;
	Wed,  2 Sep 2026 06:31:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lJIm4W5ZE7dv; Wed,  2 Sep 2026 06:31:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788330690;
	bh=ehNO1SW4NYhBj24MIF0UR65naqU3RqdDVOQCXvKK6NI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cgJuKioo1WCci7TRHYAAtdmDCes5XIFCGrOhKMq7+oDR+fVLQHfyfh/fA48RHlGVP
	 x3RvT8KPeyQtaTMEPjJV+3ttHuKpDpNBoYVpS/9jom7chTMicwry/V9g+Kl4yFJkJ+
	 KaJhAEceqqgkwJkx7Q+UkUkdm8bzxCPR0Ao9uyyOU/jKxCcALUtuy8IIgcNgxqVIyI
	 1zsoBLcQWIklRK7xWTe90DRYq21xo4HeZ/EuW5vDOSuP0Dgt/vAIRircs0pRibkVhH
	 EMt1egPnHM1ZyLFY4933kGt1v+NqXzxLweKHcNXrgWG4IerpNAL+c28SNeIjBPMslM
	 cSA94N/QDY5OQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3EF344083D;
	Wed,  2 Sep 2026 06:31:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EFA3D465
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 06:31:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D560F80E54
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 06:31:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7I-EZMMVw-7j for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 06:31:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.154.239.85;
 helo=forward102a.mail.yandex.net; envelope-from=nikita.shubin@maquefel.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=LAU7woEm
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net
 [178.154.239.85])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 48D1F80DCC
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 06:31:21 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c17:2010:0:640:2180:0])
 by forward102a.mail.yandex.net (postfix) with ESMTPS id 8F9D8C00B2;
 Wed, 02 Sep 2026 09:31:15 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id 9VdE69DeMiE0-BL05Zrtv; 
 Wed, 02 Sep 2026 09:31:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1788330675; bh=ehNO1SW4NYhBj24MIF0UR65naqU3RqdDVOQCXvKK6NI=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=LAU7woEmieBbNi/EvPOILUKpgBo/L9mtlzLIxoHG12ZZpYMfGFXWz7YQtRwlYC8wx
 Od+5Pb6Rpr5FzGcuBErh1KKvxwlsGiVTygHgLQ3gEMIpFsaD6SayJGGZrBxf0qn9JG
 U88wiXSKvD60gixalyyqHhOqNEkVTB8pvetOyfKA=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Wed, 02 Sep 2026 09:31:14 +0300
Subject: [PATCH v2 4/6] test: spl: Zero spl_image_info
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-riscv-full-fit-support-v2-4-493e904a129e@maquefel.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788330671; l=920;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=eX6E4rG1ViIZYEBmeJmyTvmdfxfI7FU8Vbe75QGnPaE=;
 b=d70sstEEIAi5I9lFejsH6MOmikARWQEJxUpNk+2DR3fvZ++dm5A9mOii5IIm3TWSflclizM3z
 3OFLDHl0cYiBaiwWnL8yrMP5c/lbnUkBRLujbJse23ibCp9/JwPPsyG
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

Make sure spl_image_info is inited before passing it.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 test/image/spl_load_os.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/image/spl_load_os.c b/test/image/spl_load_os.c
index ba9d7979a09..7cf7ea6bc34 100644
--- a/test/image/spl_load_os.c
+++ b/test/image/spl_load_os.c
@@ -12,7 +12,7 @@
 
 static int spl_test_load(struct unit_test_state *uts)
 {
-	struct spl_image_info image;
+	struct spl_image_info image = { };
 	char fname[256];
 
 	ut_assertok(sandbox_spl_load_fit(fname, sizeof(fname), &image));
@@ -23,7 +23,7 @@ SPL_TEST(spl_test_load, 0);
 
 static int spl_test_load_fit_full(struct unit_test_state *uts)
 {
-	struct spl_image_info image;
+	struct spl_image_info image = { };
 	char fname[256];
 
 	ut_assertok(sandbox_spl_load_fit_full(fname, sizeof(fname), &image));

-- 
2.54.0

