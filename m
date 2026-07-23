Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DADC531F7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 15:14:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF68D40A3C;
	Thu, 23 Jul 2026 15:14:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gTNTJad8sbCq; Thu, 23 Jul 2026 15:14:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D3E8040A36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784819651;
	bh=v/s3yAFDPaPAb3LeKNfQyhd0xx/lvmouEzHOwv7Ky+k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HQoH4LVdsOX0vSBRCWP88YmgQVxtntT1MtUMzzzGTlimDusf9FVl5seWT04A+MOkZ
	 h8MEOg9lFBRbBsEGmaKjMGRBXgIxci4OGl2gmTshwqJN5sqNdCX94zFugosbCCgVXn
	 d1HdZGJM0mjkLPXT8CTwIu6jgzo59e33RVrbi8scYHfynVlA132s7Nb5iVKku94AHT
	 8jxmpRC+Ho+Iz1BNJCPpBnPtx0GhDXMUW9SuzDUVVeMk68wI7RKDt5WsZsVvdZrq6S
	 MKDRqMfUf5RbyMbhE/pfz4AXWWnKi5iSTM971dWlD/T/H2ygrUMemxN4mHDwMWghp6
	 FhF8Q3RhMq5jA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D3E8040A36;
	Thu, 23 Jul 2026 15:14:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3CEAA707
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:30:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 234EF403E9
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:30:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LUR5FG0NzPys for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 13:30:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=tan.siewert@9elements.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5A486403E4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5A486403E4
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5A486403E4
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:30:42 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-493f6de72faso4149585e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 06:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784813440; x=1785418240;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v/s3yAFDPaPAb3LeKNfQyhd0xx/lvmouEzHOwv7Ky+k=;
 b=iRUjyIcqRlMcHOMPpQ/g8BBydyhoD2rfKekMryxZ1oqAfOgbX9HUvF4tIsFvL2MCt2
 hWo8vGXcmT5Ugiqm7Tdqv7peYr0XX4Qyy6zCAxt9mUSVJOH+jLrle0otz8XggqfhmwrC
 06W8qBdRUX2p/J7TQBn73hZWA0cS3JFNaxYi14Q1ge3whmd2JA/pYUC0mxFQLJT8TbUM
 de/WDvek6l6ElAl+stR+T7h8QyGfwIBZ6QNZDdppZG3fEAItRBdCW9PQ2OzMkm1/oS7J
 TwBn85m2+F4iyGIiaIx7YZRXCC46usLKrgmDMPH1pPPsI6y2nqNBsM68fMj31iLipY8D
 Iz9g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp9wpi39/luWlWJyk+5hNCPRQ+fxAi4ilYbN2RZTPLw2L1Makw30kLP9iSYzaVVAuVyOHvsthg=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzAZl3T/uNCgAyvoPScU1AFcSGy8BeblDv+PUgHk2ofaWqxVEfJ
 Za/GY89qRuegKaUKqfC5SgZmWsjO2YcuioDk4zFUTweEnfplZZcydQD0OtAfb68tgQA=
X-Gm-Gg: AR+sD11UZqQ3cfUcNQzzGz+UuL+xxQySnksOQU/aMR7xKi/x5sIgKFxYGHEDIfhj4MI
 odd/uWALvahGSC6CH1eFON1HcVeTp68MsgzFOP0Vq/ClpH/uZAgpFQzzWYo815dhtK3rpFGR5yR
 +h6+ODiYh0TZa9dTvsDQv9tQ0Yv2nvC7YBG1lsWXOQIUbcOCoWGikwUpRZV9y8VdHsaO0APJu4+
 O/5kQrM+T/s8X74JHewgrRI6pHGT8MGsoBIyGw2wingFZLHeJm0HQ+4iHTLDLmPd+es1p0ujDj5
 CVtFzkbZeD06f8PteZmah8uaLZmZf/7SvCxUCLM8uoS6qbWhau9vMTPnCvU99nwpvD/XO04iSr5
 Pl7GFLv15QP06wR8KrurH4Xdnlfkx68+ostwbhFkPzG0idx5flUKTCdNNglxxPAGIAtS9ks2WF3
 irTVxz8j9HhG1NFSGnVdW9+q45
X-Received: by 2002:a05:600c:1385:b0:495:4f84:7280 with SMTP id
 5b1f17b1804b1-49574581036mr28758325e9.4.1784813440260; 
 Thu, 23 Jul 2026 06:30:40 -0700 (PDT)
Received: from [10.12.249.172] ([2a01:599:841:3b94:b6c8:2fa:40db:8ecf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b043727sm97075405e9.4.2026.07.23.06.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 06:30:39 -0700 (PDT)
From: Tan Siewert <tan.siewert@9elements.com>
Date: Thu, 23 Jul 2026 15:30:09 +0200
Subject: [PATCH 8/8] board: hpe: gxp: configure PCIe device ID in
 board_init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-9e-gxp-v1-8-f86e5cea239f@9elements.com>
References: <20260723-9e-gxp-v1-0-f86e5cea239f@9elements.com>
In-Reply-To: <20260723-9e-gxp-v1-0-f86e5cea239f@9elements.com>
To: u-boot@lists.denx.de, Jean-Marie Verdun <verdun@hpe.com>, 
 Nick Hawkins <nick.hawkins@hpe.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>, 
 Tan Siewert <tan.siewert@9elements.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784813429; l=995;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=nGDEXVCzCVCINJx2nqIjXfKOk0fJLUjEgHH4Re0+pIA=;
 b=++zuRCdzXXlPb/6oPM0HbBeaqfmuHQWgV8OGcIGiKFB0jFKAXmgxes3Ji7oObcm7HfNbAiB3p
 KulxFA1gbR+CthMdR04X45MeRGtWMpXwWFzHQGDfhKUY0tnE6/wgwPL
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=
X-Mailman-Approved-At: Thu, 23 Jul 2026 15:13:57 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1784813440; x=1785418240;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v/s3yAFDPaPAb3LeKNfQyhd0xx/lvmouEzHOwv7Ky+k=;
 b=bE/3jmZ1/UR/3STkKrwl4/eTuwsGtZmz9mDKTac/XE14YUT1WQJEamXKJH+JKAdEmn
 Y5f2JP65/ZMb+AVyelA67ezwmp/Nida3k1VqD4RQM5lr6wLcRo/K/K8d+R1kVurSBZlG
 84tlS/R9zfmyC1qNxAt2V3ne7WUMlz9g9X+o0He/eBCE9V4Lm5WHW9cHNJd6BsMvSMw6
 d+JBaWzui5d9QAV6Uko6T6tH8CRohhSXfs146o90xGiFrxDZAeueTQjHbm9UNWAopYwa
 JkTDFAt/xyEFXCUr66zd4qX+P+FKI86mUuUgKyOCKk9cfMBDydxtb4wF5HIf2ndCE9Dv
 5gjQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com
 header.a=rsa-sha256 header.s=google header.b=bE/3jmZ1
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Marcello Sylvester Bauer <marcello.bauer@9elements.com>

Write the BMC's PCIe device ID (0x03D8) to the FN2 pcie_dev_id
register during board_init.

Signed-off-by: Marcello Sylvester Bauer <marcello.bauer@9elements.com>
Signed-off-by: Tan Siewert <tan.siewert@9elements.com>
---
 board/hpe/gxp/gxp_board.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/board/hpe/gxp/gxp_board.c b/board/hpe/gxp/gxp_board.c
index 0cd05c00079..032554649b2 100644
--- a/board/hpe/gxp/gxp_board.c
+++ b/board/hpe/gxp/gxp_board.c
@@ -20,7 +20,9 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#define ECHI_CMD 0xcefe0010
+#define ECHI_CMD		0xcefe0010
+#define GXP_FN2_PCIE_DEV_ID	0x802f002e
+#define GXP_PCIE_DEV_ID_VAL	0x03d8
 
 #define GXP_XREG_BASE		0xd1000000
 #define GXP_XREG_SERVER_ID	GENMASK(23, 8)
@@ -139,6 +141,9 @@ int board_init(void)
 {
 	writel(0x00080002, ECHI_CMD);
 
+	/* Configure PCIe device ID presented to the host */
+	writew(GXP_PCIE_DEV_ID_VAL, GXP_FN2_PCIE_DEV_ID);
+
 	return 0;
 }
 

-- 
2.53.0

