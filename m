Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B597C87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 07:44:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C33B882D21;
	Wed, 13 Aug 2025 09:44:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=inbox.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=inbox.ru header.i=@inbox.ru header.b="Dh12GZYR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E5F482F00; Wed, 13 Aug 2025 07:54:43 +0200 (CEST)
Received: from send104.i.mail.ru (send104.i.mail.ru [89.221.237.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7B6082E34
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 07:54:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=inbox.ru
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fido_max@inbox.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
 s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
 X-Cloud-Ids:Disposition-Notification-To;
 bh=W/kdVCWNzikmJdsaC8j6orOv9O+fXFxLZrbSULi6omk=; t=1755064480; x=1755154480; 
 b=Dh12GZYRhNpE7lwJ4U/4DpHBpIAzRqtvRs37mRm4iHzeLDgaLqdkMSN6znIOSXexE00Qks4+ICp
 4lWMRzYYdWw7tub5+XU2ywhweVeT+Ywv0nTwn/DCUej0WPXQ/6n50wXDxKJ5oMWfkfXTb0jQGAXLX
 BEy1Fuy71hcs7E8KBgFq3+3dYbQ8h/KHKlEzqqdpJzTlQX/EouoOqm1wm3SyZIZPRmEBzYMo2iHuv
 xqQEtP21/OThhifWfI68/27nXvJwgUzuMARtkZ06VUFhZR95k6GPXCxQQErxsHtTlp/j/cqZ2x+/X
 0D606pGhYzyO0l/bwvNxkefEOmso5RImn4Dg==;
Received: by exim-smtp-657df4cdbd-2z4lm with esmtpa (envelope-from
 <fido_max@inbox.ru>)
 id 1um4Rb-00000000Br2-1xOH; Wed, 13 Aug 2025 08:54:39 +0300
From: Maxim Kochetkov <fido_max@inbox.ru>
To: u-boot@lists.denx.de
Cc: ravi@prevas.dk, sjg@chromium.org, trini@konsulko.com,
 Maxim Kochetkov <fido_max@inbox.ru>
Subject: [PATCH 1/1] serial-uclass: set GD_FLG_SERIAL_READY only when
 cur_serial_dev is assigned
Date: Wed, 13 Aug 2025 08:54:32 +0300
Message-ID: <20250813055432.1095253-1-fido_max@inbox.ru>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: exim-smtp-657df4cdbd-2z4lm;
 auth=pass smtp.auth=fido_max@inbox.ru
 smtp.mailfrom=fido_max@inbox.ru
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9C53E288BA7BF03068C3A0A01B0AC67FD533550D2FDA6521400894C459B0CD1B94AEFD824A263CB0B33594132A326AF8B55B9DAE248640E7B580B387FCC2D8E8F52B81C99D67B1670
X-7FA49CB5: 4BFC5D8501E51E47CA8F6BE7C18995EBF17A87A2884587760ABA0C84A4078DC505CFD1E830D3A308707937C1A3B2EB35382A44476A7729E5A6333920E0F9D84FAA484E9BD3D4964B0190A62B4F10741F646C2A33599DE4AAE47410EB8219D4D82737C91DF52F51B5353A349B0BA86A69278E9104A262060CDB6D994A4E425AB87C49A8CCFF29528E35BE5DB706024672A3C43680391634B26D5C242D5CCE620A3AC42EBD2566779432D00B47C3DA26DF3A0932D714ADE7D902C84A09E7C3BC3A8CC2A23726E83CCBCA8F6BE7C18995EB71A1B796659512973AC42EBD25667794B034CE9F77FAD83B31815A44591C59A9D1ED3B757031819563A17EB2A382449571A1B796659512979E5F4869DB6CD4C26BCF00562456A40918BB8896F27FB42885659056A66B9957CD57035CC7A4315EADA47A90BFC3683F953E0C1C45D6C233BA8E58577899654A6741AF5F649F9888DAB9A681A4DB395AE4A3704882F68E2A
X-C1DE0DAB: B30BEEBCB9DAB3F0DCAF50CED1C2BBC0478DEAD3877DCF16D8C7BE2B4C1EBAA8122CB09A42AF3A13BCC2DF43DD22AB26DB841BC0FD54B826925697AFA735600F65C483732B0C61AE0404AC03FA789E4130AFED0B0E96279AAB8C77F2232E6289
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF71BED64CB5F0CBAD1D90636C4054AE490D8BCB5BFB629D84AB160D98A57CC6A53B77A83432DF81E470D7B6E813561555074DD7E547CA4BE2DFEB990F8D883421610D9D35AA3A32099F49EEF1215E7BEC913E6812662D5F2A17D6C1CDD2003EB8E03787203701020945C72C348FB7EED3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVUcWHxAuDCnGFfw7QdfVZps=
X-Mailru-Sender: 689FA8AB762F7393FE9E42A757851DB62E253E708DFCF8ADF2F7AFED49952887CB13C0517A2D531190DE4A6105A3658D481B2AED7BCCC0A49AE3A01A4DD0D55C6C99E19F044156F45FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-Mailman-Approved-At: Wed, 13 Aug 2025 09:44:38 +0200
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

serial_find_console_or_panic() may left cur_serial_dev unassigned if
REQUIRE_SERIAL_CONSOLE is not set. Setting GD_FLG_SERIAL_READY in
this situation confuses serial console code. It tries to use
unassigned driver instead of debug port and stops printing.
So check cur_serial_dev before setting GD_FLG_SERIAL_READY to allow
console to keep printing via debug port.

Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
---
 drivers/serial/serial-uclass.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/serial/serial-uclass.c b/drivers/serial/serial-uclass.c
index a08678dde4e..7b381ca12a0 100644
--- a/drivers/serial/serial-uclass.c
+++ b/drivers/serial/serial-uclass.c
@@ -191,7 +191,8 @@ int serial_init(void)
 {
 #if CONFIG_IS_ENABLED(SERIAL_PRESENT)
 	serial_find_console_or_panic();
-	gd->flags |= GD_FLG_SERIAL_READY;
+	if (gd->cur_serial_dev)
+		gd->flags |= GD_FLG_SERIAL_READY;
 
 	if (IS_ENABLED(CONFIG_OF_SERIAL_BAUD)) {
 		int ret = 0;
-- 
2.50.0

