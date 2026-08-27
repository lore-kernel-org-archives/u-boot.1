Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F85AC61DC2
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 12:35:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A0EB940707;
	Thu, 27 Aug 2026 12:35:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vQSLjbcj8LSx; Thu, 27 Aug 2026 12:35:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787834111;
	bh=Zldxald/iYlF3kRiiNKPyosst/7gQukxYrPQ1yfY7lw=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YRSxMAtTXR6ZxbrHsWU1wU7JRkQ74Lfoekv2/ezu8laJeaLOMN8LiE9NO05APGHz8
	 28BWVNKiAGqNZwTlGZsFl42ZGt0Q3sCxB1hgfipF/pXHoV51KnkXn54WJjNzgbi8hb
	 mMPupGNBjY2VxYJWlHtu4t3fSkWG38HcJcQlEQiSwEmXP+P20WwL9ZGYtiOq+SZM/W
	 1xWMgknCdeuXIV9i65gIGgSiaTMQclWL3kPWB3Rw0bT1tVFws5MxAu+daCOSUiBVg6
	 XXqb/mipf4hgaYUFPxA8EeqVAbyR8354/Laut2om1rKml6zOnGvZ1x3qf58ALQK6Cs
	 D0u6ZsZrciG5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 335C7406A5;
	Thu, 27 Aug 2026 12:35:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 458D4105
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 12:35:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2B1F460789
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 12:35:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AVDl00Nt3Wx6 for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 12:35:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=hOd3jFC/
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 64BEF60623
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 12:35:06 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-49b0d8bc2aaso11943395e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 05:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787834104; x=1788438904;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Zldxald/iYlF3kRiiNKPyosst/7gQukxYrPQ1yfY7lw=;
 b=hOd3jFC/PHk/pTJ261dw2XEkQdGK3MUSn19vNLfVe2D1kpHO+1mjSQY6ZfHkSb9Zvz
 k1CqsCeXHYi0UFRLE5K78Z0+tzY2JhQMOa4lK8pphKAob0IrHsOqsqdJiz9LaLLtZFsB
 5JxI/9GNGTjvS1DWIUfAfko2Yqmw0aL1EdoPf+l5K3h+E8NJr+j6ebPVtT3F5OHe8/zF
 lky+menByLldWyCKn36pxGCqPj32wwOlvbghNTJSY61Ias2UKbVjlzFmjT9O+ywXPjmq
 SSfF6qD8H0XQTToR2ygPEN9xdVxFXXqnQvh6TmARbEUva8q0TuZH5uyQEhTo0Os8AfPp
 in9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787834104; x=1788438904;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Zldxald/iYlF3kRiiNKPyosst/7gQukxYrPQ1yfY7lw=;
 b=aTYLGhwGQd6gAVbPksQN5kZVVoJDJG5jpUKiatROaL51NnXh5nrggKK7qy3XQs7myL
 MTY+rHazI5GZIk05UCtrWa6o7TPOPJ/fixhZ/ROkwJg+gJd2AdxrFTgMAEM6NW+glCWf
 PuolzOe/O+u+/yo3QU3+Yxf1OjwINvpcRlfA7TT0dEQWhihW6US3up+VAmgiKQjHNWRD
 WAnpwIrp26mqwoQPkE5y7TU6//p35rr3XdTNtB4pzItdAG/Gdm7wBsAVahGrJYJ6YbdX
 +L5ghjQY2j+Cs3XpigR7dxEXwJC+BW0pBkgNnBLAKEl5cAOJjjCYIJ496aXQ0iMYS9zf
 Bt5g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpOBoOFrjrGKgA7ZxRs1lNtBmnQjHFemjtm6+MQ7RdZfRijdMgT+zc4A7k/4pDhg5CpYzvK75s=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mO6zES6BPquypkgMvf4bXS3THBigrULTvotqb9gxnef4w4TuYF
 +TgEZuUghZsc8Lneo0+jeyAx7wFt3Ea1kjQ9uLLri92hwFFWW+IMw3jKn7tMwk4V9WM=
X-Gm-Gg: AR+sD12pWX/wmufbDgIa1yC5d/RTz/foIjog9iG4VDpDd0SFg07MAeFMAKW2W40rUqp
 DSMxhbmk96qgsUlk/YRgbl+seqNPRsvawr56V0GjPSx/2MEKPqh5PHNnYTaq1wnzQdw8lkhY7gh
 8gCPppwQAx2s4gzNjRaXd+9X3wgF6waE46hJwTkGJMMRIB9j92r8twtPV0b4U0pmctInM6izMRm
 iUWhFrN/koSSdDCv9WNmSp33g0mNdBq25N6ZgR/fm6dUeJjWSCbnXGaMr3X3Yl89dFk/hZOWXT3
 bflhib2CRIwULVBuWllTeR5EmSowhipGfXxVsdUxQUmFPJ+kqXKPg/ysO78eh7F9BCiGLsxecax
 S+PI8MzoDIHartjiA+6GNNEf/21tVthoPiAkKTM7jMvfn/chAGQ04z262U4/+yG3bmq4BKoIrYs
 uzTGTMYopr4nd/vCJw28/NuUSLTn79J83fPvGWJAH8TN2DKUQ/8gfwI2V2mg==
X-Received: by 2002:a05:600c:1393:b0:495:48d7:f178 with SMTP id
 5b1f17b1804b1-499dc7253d8mr176693895e9.11.1787834103634; 
 Thu, 27 Aug 2026 05:35:03 -0700 (PDT)
Received: from localhost ([2001:4090:a244:80d4:4373:6c2f:4372:b8ac])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b4c3211e1sm50339925e9.9.2026.08.27.05.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 05:35:02 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Thu, 27 Aug 2026 14:34:38 +0200
Subject: [PATCH] simple-pm-bus: Fix clk -ENOSYS check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-v2026-10-next-topic-am45-ofupstream-simple-pm-bus-v1-1-1b16c8f95051@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAN0ukGoC/yXNyw6CMBCF4Vchs3aS0lQovophUXDQMfaSTiEkh
 HcXdHe+zfk3EMpMArdqg0wLC8dwoL5UML5ceBLy4zBopRtldYvLubBWGGgtWGLiEZ03V4zTnKR
 kch6FffoQJo/DLNgYa2zb2YFMB8dvyjTx+mve+79lHt40ljME+/4FLCrvVpUAAAA=
X-Change-ID: 20260827-v2026-10-next-topic-am45-ofupstream-simple-pm-bus-64848798be49
To: Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1202; i=msp@baylibre.com;
 h=from:subject:message-id; bh=9VMa8FPQL+To7Ts4cwwE14BRSyiqZnrCJ9Z25QCwdKY=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqwJeh/MS+/1P19/M0rm08HzpdsdHuos9YhZPp+Ts5fl6
 gvLfaZXOkpZGMS4GGTFFFk6E0PT/svvPJa8aNlmmDmsTCBDGLg4BWAiLHWMDJueLO28cCv+SMGX
 nAquG2kTN218WyGjukGdeYe5zmP5e8UMf3g1zzaqpZ0rU7A5uTAk26zgY4/+vwUaDRYTxAOfT1d
 ezAMA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

clk_enable_bulk() returns 0 if CLK is not enabled. But clk_get_bulk()
returns -ENOSYS if CLK is not enabled. So the -ENOSYS check needs to be
for clk_get_bulk() and not clk_enable_bulk().

Fixes: 4a3390f1d3b7 ("dm: Add support for simple-pm-bus")
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 drivers/core/simple-pm-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/core/simple-pm-bus.c b/drivers/core/simple-pm-bus.c
index 5df11728e828..de4d9f7b4fb8 100644
--- a/drivers/core/simple-pm-bus.c
+++ b/drivers/core/simple-pm-bus.c
@@ -16,11 +16,11 @@ static int simple_pm_bus_probe(struct udevice *dev)
 	struct clk_bulk *bulk = dev_get_priv(dev);
 
 	ret = clk_get_bulk(dev, bulk);
-	if (ret && ret != -ENOENT)
+	if (ret && ret != -ENOENT && ret != -ENOSYS)
 		return ret;
 
 	ret = clk_enable_bulk(bulk);
-	if (ret && ret != -ENOSYS) {
+	if (ret) {
 		clk_release_bulk(bulk);
 		return ret;
 	}

---
base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
change-id: 20260827-v2026-10-next-topic-am45-ofupstream-simple-pm-bus-64848798be49

Best regards,
--  
Markus Schneider-Pargmann (TI) <msp@baylibre.com>

