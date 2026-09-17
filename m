Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE33C982D6
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 14:03:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BACEB60B18;
	Thu, 17 Sep 2026 14:03:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Di6av5_U0uaR; Thu, 17 Sep 2026 14:03:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 747F260B23
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789653793;
	b=MZkzUxklf8cSXlWbZSya0HZZ9oSb9eX8fO+JdE9s5VW/hgKxYw2xspx1k2iaSjSSwzYV
	 GV+L2rF/61WS+MrbDvsMTrGm614RmzWZnd0Ux6PtjqdlsiyCgsYVbs8wgs7l6typrihr7
	 RHB2/XxhXTBokclJbV7zf5Fn/yREZsyIzzoSUGX38/1GDosa+KLpF79Pk0NsWPOXTbydd
	 jrPhdsk7L3GLsSwaycOb1NhuPwtGDOq5iLn6tXKzm/fmVY0zBLzkXPV546FeTwfvNsRp4
	 u4e2vbP2N50nPqN08MBeinEJBed0nDKpCsh+mn9ADb6gvjr7gs6Ap9QARoz7pKbG+Wg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789653793;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ab8Gq5W5JjF/FSh1NB47cj+ZVgVeZaYUhquMc5tMcTA=;
	b=S7bjjdYoEVHvl9yN/rDmtRSkGaVVc4YsC5YA26H8re/4VU1GlJCV0dhu2IlRNKS/nVn/
	 YI58IrgQeZcNtuj4PW5uMvXu7Lc2erpSq8IlL6M+GTrLhslX4drhGcl1bvSI/DMkC8BUx
	 4UdO4rt1iBQxqY2CIR5CHILcJKtHHX/uuvUQ6o6pIiXz5J6UY9Xv4NCcxS1xvYyAmElO5
	 fAAii2sQZZEVMD6McGK76xZGu8YUQ3Qr2hP1o/6oxNDWYaRaYZhMwL3p0RdPtQT3gdPqC
	 yXGRo5KvlzIsvCu3fw5f5ayxMgu666J21yQabBEeW0/ljTsrEWNxAMR6x5lqx1WLrYw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789653793;
	bh=ab8Gq5W5JjF/FSh1NB47cj+ZVgVeZaYUhquMc5tMcTA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ot3jd6MRQEPHvpPKJlDoGliu8Rkm3xCCOTG1JHUnq2E6Cgkp8Teq495Z1BjLIWxyL
	 mIsZc0wnJwxk4l9KOrPLqFvDV9hduZdtVxwJRsC9EEOdw42XbsCDSDX24TOT/Ei+Jw
	 BdzNgt+VACQJjjg/WJWIDzc8TEAq5Idyqbn0PmDpZIFBVp3PxlvCG6xvA/xFzP0YQw
	 HbfiiCWW+uyWn/Wt6IVGsLd7m9n0vgft1iLIDkKU307vn33Q5/IbrURYIrOwyKDVvL
	 FgPkJv7xwClyeor2Yyf/MEey73gIqIWdK/Ck6qqUgrF1syC/YlZN25aL4+qei+PnH8
	 M5mkU2vu2qsDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 747F260B23;
	Thu, 17 Sep 2026 14:03:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3BD3229B
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:03:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EF9764009E
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:03:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gHt8tRfDQm8S for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 14:03:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1E4404007D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789653791;
 b=PqvDHFNonjpMlOg/YHoSD/nMaTHNmQqG9uuBizqYIyZ7v4D6F/fPnAKIp980O1MwMF5O
 elf/NsRoyfr7x1odwUOVbi86RklPsIl4gd0aULIhPyHkgGs+u5q0c7ms6OMcm1b4rG13V
 OQCsbcunO/rIsL9HL/UVn/8NQxyCGRxs/8N/7sBLZSxhbVXUiYYZlbPIoLa334NDuC3Wi
 H0RNpvsILbONW6XZsHALGHvF7EqJh91r26dXngKEy9QWZefVBNJ0DQC/cik7tUoSSKpJV
 +UReJGcWBGB89B2y16SFh9vmwt/kLgv8A+W8JjXRqQj2saY1BX+k3V5QRLWd5bjfezg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789653791;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=ab8Gq5W5JjF/FSh1NB47cj+ZVgVeZaYUhquMc5tMcTA=;
 b=N2nzoJ0A6QXeI5syIDM6PaNZt6lHb3eHVil1bdj4hbYMU3nhwB3H3m/aGpQHs5fnQZlr
 1jZ43WIoNKZWOu7kJwN5eo4LXNw3WnKfLn3/B8+LNuYDroQhw/03QlyilA9dyDdvYKk16
 yVK//vI1RHWy0vnS23zm2aSPMeRRd1Yist9ns5WVtEzeneIZM3z2cZ2uDzurNdOi86Cdj
 Jpc0GEYj+2F5JEedCOYper1jtR+vuLUjLux9n7VbymYXm6dSWNtbjhelzvnGj/J+QyCUi
 cFZi9BKrsu8/NR35xdw3PGkcICHi/DU4ttAjEje2AJWi1xwW+DJ2kIxt0Gxg2DjX2zg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=WnmPJemy; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=WnmPJemy
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1E4404007D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:03:10 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f633cd80so494899f8f.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789653789; x=1790258589;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ab8Gq5W5JjF/FSh1NB47cj+ZVgVeZaYUhquMc5tMcTA=;
 b=WnmPJemyrz+wJZatSSkbkzYx3rpAfrGMepC8NO3C8cEEVsMQpwYsF6IpWKWAUsynZT
 qXQ+LxJHvx4dEk/qKdBAmp/ZaWQXwp4xIcUek/ez3tldiM5b+iKuPFMS5m0j6NQwmjUz
 +PM2fQtQcvnxd3xZQjdvnEG7cOtMLrR0xiuxIZ76w3AIguJUBngf4GdcIcnUDU4tCnst
 cB1PWoinjFeKqI/X9/vjPXni8KrxgHmbanhx2I18as5LOF6yexaTqxgPw7GB5aNbU3+9
 P2zJzGfF10cFrWdqK5fd+XjKu71uqMsaQ4KTR+QdJY8kvkygXMTrFp1bTHIyVCUjFgRs
 ZEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789653789; x=1790258589;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ab8Gq5W5JjF/FSh1NB47cj+ZVgVeZaYUhquMc5tMcTA=;
 b=Vu1bte5c2r/fcDsV2sjRyFFTHj+qnnrN2c9MnnnW8nN7uVNjBhaZ6w0VDUBdmnNSzI
 AU/23mVkxq+01xDV7NmoMF8OP/vxOY8Xq279xd8/MaSgedTbAA80NFm9R2XpDdmk7BfX
 k8LFUMBedzxqSgnkSvry3pHjXtlsZVBeyhmngJkK5lsDfeYKQA0jBr7St3/VQcU/YEXv
 m6NPIo6fqU7uP2FZM50ONo9Gmt794XvW19x4+JbjUaawyU2r/1uvqv+g5v7acprXspoD
 oInZdfDivaVKWmchv0YUVlUqN6AQ+skjFPn+uo612RV5FX8hDZ8TzvJFrzCq5QeAZZx5
 Eh6w==
X-Gm-Message-State: AFuF++n7KoUZEQ558vaqtFioNHCfGKnirQPuYQ997teu57tK7GhVVAkZ
 Zx+waK8qmKtZCqLU6vxjSJUmCkK/2zsIkUSAcC+Rw3x/MMeHiaCQvViqD9u4QPwQpVk=
X-Gm-Gg: AYBFou3SygMtoikroLid9Bc4PZ1EyMDc8nhI22deqVmZ1Yov4HZRiRK24NL3r8zaoeR
 o7wajcv1CofRiGKvSoNReOg68uDFMAnDqxqn33gZaln8UL0giU1IzBaDP5mNyA1CG50C5sfEVoy
 GiXUqs9aJzbdJbO4Ito4RBnF+TW7loNQDXTlPIK5QSy/Ft4cJdcXvykGk35xgHL6zdo+sGGnu82
 O3kaQQw82bdxMHPoPP6J/7EUaHZXszjzSMACNtcgKTgsp6y+qrizFZZTHbMcIiItROSyuc2EtZu
 8K60igu1jZavwGGM3Qv6itSb6rBxmKJV8t/6tUcRmn9DYuxZYuPA0wlo0h1UAOmzQh+snEyku0B
 ncxfz3cw2ZgM9pTL/WGPYaJHTzwpvrC9GATycBnId6jBamfDjzDCQOQe0hXydO5XIoLrajwou1Q
 l4v+aZIUyP2ESKPd75hTb5Uay3e2mgNDLPEy2Elg9wabLjz5UUdTrN6R0nkzG5EIxZtZJXG1obh
 G3WQbpuKuwnsONy2y116tINIcpiOgxscb/KY4t6IBDbVVlT0h7iiw==
X-Received: by 2002:a05:6000:188e:b0:487:6f6:29a6 with SMTP id
 ffacd0b85a97d-4870cf36c1dmr8733891f8f.35.1789653788499; 
 Thu, 17 Sep 2026 07:03:08 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf344fcsm16893905f8f.26.2026.09.17.07.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 07:03:08 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 17 Sep 2026 18:02:28 +0400
Subject: [PATCH 07/11] test: spl: Size the FIT properties for the image
 name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-spl-fit-compression-v1-7-7985ac56ee9e@flipper.net>
References: <20260917-spl-fit-compression-v1-0-7985ac56ee9e@flipper.net>
In-Reply-To: <20260917-spl-fit-compression-v1-0-7985ac56ee9e@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1367; i=alchark@flipper.net;
 h=from:subject:message-id; bh=ZG4UJp992ov4euj3JEpIYMY1E9fiRv0qw9MiMV1Gaec=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSt/vT77O4fmYp1Fvp3XCoif0dz81zl+fm2UCRpi8zHe
 ZFV4QLPOyayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZhq0VeMDFt9Lp/Knlk9YaVHTuo0pinlZ/esljYt+fN/6b/s+ZcVw/YzMrybxmD
 sskOeW7mL/0PT1x6hQKmad1N8mRms5ZfrNH70ZAQA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

create_fit() budgets a flat 596 bytes for the properties it writes, but
one of them is the image name (named after the test itself), which is used
twice and can cause libfdt run out of room and create_fit() return 0 if a
new test with a longer name is added.

Size the buffer accounting for the name explicitly.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 test/image/spl_load.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index 94ac3a16b863..34ddc49d2463 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -163,7 +163,14 @@ static size_t start_fit(void *dst, size_t fit_size, size_t data_size,
 static size_t create_fit(void *dst, struct spl_image_info *spl_image,
 			 size_t *data_offset, bool external)
 {
-	size_t prop_size = 596, total_size = prop_size + spl_image->size;
+	/*
+	 * The name goes in twice, as the description of both the image and the
+	 * configuration, and for external data this budget is exact: it is the
+	 * whole buffer start_fit() gets, and where the data then starts, which
+	 * the loader expects 4-byte aligned.
+	 */
+	size_t prop_size = ALIGN(596 + 2 * strlen(spl_image->name), 4);
+	size_t total_size = prop_size + spl_image->size;
 	void *payload = NULL;
 	size_t off, size;
 

-- 
2.55.0

