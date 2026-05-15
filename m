Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74E1CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 18:10:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFBCD847E8;
	Fri, 15 May 2026 20:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EIw04gAf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E87E3847E1; Fri, 15 May 2026 20:10:26 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C27C5847C4
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 20:10:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nathbappai@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2bab82d75fdso843345ad.2
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 11:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778868623; x=1779473423; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T9S9Yf2lFQE0pxfBxVF5FdDmUIVWfpa8g7w+1ozz0Kk=;
 b=EIw04gAfgvcjbAA7rP3RiJ4y2adoxhFNh4q0PnAICspIeMUeMGk/TPaEXDz7v0Emf2
 cVIGDvioa076w+atE4obE7fiHL7yJJfrqMnGtYIhCz/DWblyLLDv0xROPL+7cYW49pk4
 MurfDN1cHsr4pXBnmctfZ6Tx9oU5Gg5OJRS0Hkdx8CKCMiyo1knzx7ZL9rwZb6VV0QAl
 meEIts59IB9ZxzSiaLfsR9wr2REgZ3Of5TszQtdwyRauZViSdBoHnZM2nNMqrSv9LQvb
 GEVDf5FYlssxY3EK+jG/MEVmne4SiofSjTo7LGfKEfichd/BHUkzw7d7Wpqpivmw4aFC
 U5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778868623; x=1779473423;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=T9S9Yf2lFQE0pxfBxVF5FdDmUIVWfpa8g7w+1ozz0Kk=;
 b=ORjY6B+Y4i3X3ZIKi6I8/Cbd3XSHAKk/YJI7p0lUnzgo3E8MwyHjZYElZ0bf+/AIJ3
 mM7D8dsTLDgvYOmV4Q01Df3/jEZiI+WRC/CiMR46mw/a09qwNzKkY1e4nbrnFaLIARxu
 1IrlN+53DvY3ZdU5hctUf1rJdDC7vvsJQqNWg7PSxSyPBGDoXJXc38Ica7utckWa74bz
 4tIEVHwHZgCFBFSP3/DcQx2bgHGv9hoiijhuVBDY92CDND3j9EQQIpPSPd6TRNIsHy7a
 obYE/ImaTjfQFeKy9qtqJGz7CiUgrlJJotJpW45EZ7bJHOvqGpdSe0XFPcqwpI0ozpPA
 J68g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Ch9a5ZvqeZPuhExibEZSO6jkPUoUwv/2hwMi0/8jbd2V+HRtbxU9z2V+ctsL2Kh9ppiQhmEg=@lists.denx.de
X-Gm-Message-State: AOJu0YyNbbt7OQeoVl1YHibmvP5/E1/7kRykzYA6f/AnVeldNg/uj63j
 QcM8bq4ACTZ9HVDu5BzlkO+BWsPg+QBe2bJY8CFpbu3Y1tuGmHz3rRe/
X-Gm-Gg: Acq92OF1YMWsjH0qRvb5ZYcDmJ5U8V8nYpu5GhBRGBAxQBuYF1QZ0ys2mbhT0ZS/s5B
 hJCByIhjKnWxY2wE+E7aV//w7zcEob7sx0i3TsbXOuoS1i0cY5R9AsBtG6RNI3GwoOxtCMdGgEJ
 9bKzsKteVTYFicr76iEZvLS9DnbDHebJBNBUlrHQhVLBPrA+4uai+bFpWAI++d0NDjUX0QahqS4
 4cbxRDhyB4A4SJxObPVtFQBtHjyJJjoS84QJxP3KpDeC++55oMZ9juXhKfd3jPnx/J1WkX51+s3
 D6J74KAjl9glo7r25lp0xA5voVQltjiWN1S1UUwxBnMEAz1915P/pgHWjI5NZwQcFmWBT7nONyM
 WM5U8xk5a1mVGZoJHxxyRqBJMjFG6fHpgg8aBOJh4xHNhlykI4bnqPlwb97zGdOmsTlET49MD1W
 SzgQRGkTAj8zbLuDbGbrs7w7e9pIvL
X-Received: by 2002:a17:903:245:b0:2bc:8f30:74f0 with SMTP id
 d9443c01a7336-2bd7e8b7afamr61274025ad.26.1778868623236; 
 Fri, 15 May 2026 11:10:23 -0700 (PDT)
Received: from [192.168.0.102] ([43.251.88.142])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2bd791e0b11sm42338535ad.18.2026.05.15.11.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 11:10:22 -0700 (PDT)
From: Biswapriyo Nath <nathbappai@gmail.com>
Date: Fri, 15 May 2026 18:10:03 +0000
Subject: [PATCH v2 2/3] clk/qcom: qcm2290: Fix vote_bit of gpll6 clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-ufs-sm61x5-v2-2-0a35d083d2da@gmail.com>
References: <20260515-ufs-sm61x5-v2-0-0a35d083d2da@gmail.com>
In-Reply-To: <20260515-ufs-sm61x5-v2-0-0a35d083d2da@gmail.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Danila Tikhonov <danila@jiaxyga.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Biswapriyo Nath <nathbappai@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778868606; l=764;
 i=nathbappai@gmail.com; s=20260118; h=from:subject:message-id;
 bh=GnXbRCxpnvc6qn1IfUwlmVEnf8kT77cPuzMvJxTeVyU=;
 b=0iSi5GqQceBDxAvxfqXCLZOk0Z3/wsWhRDMvTmFoGhZhW9GfCoSo0FuK/wCIS+gaDLv7QFzo7
 5BQzZmCzJTuDEZ/fT8bR5mkn/FM6HeBcfziScR4C03x1CVw9iH1b+ot
X-Developer-Key: i=nathbappai@gmail.com; a=ed25519;
 pk=slmb/9yXbet+KTiT3EYLCp0p0MEOYa3EdjUXP+HXfjg=
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

This changes the vote_bit same as enable_mask in Linux clock driver.

Fixes: 3ddc67573fab ("clk/qcom: qcm2290: Add SDCC1 apps clock frequency table")
Signed-off-by: Biswapriyo Nath <nathbappai@gmail.com>
---
 drivers/clk/qcom/clock-qcm2290.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clock-qcm2290.c b/drivers/clk/qcom/clock-qcm2290.c
index 5a599085b500..c38ff1a1e4a5 100644
--- a/drivers/clk/qcom/clock-qcm2290.c
+++ b/drivers/clk/qcom/clock-qcm2290.c
@@ -73,7 +73,7 @@ static const struct pll_vote_clk gpll6_clk = {
 	.status = 0x6000,
 	.status_bit = BIT(31),
 	.ena_vote = 0x79000,
-	.vote_bit = BIT(7),
+	.vote_bit = BIT(6),
 };
 
 static const struct gate_clk qcm2290_clks[] = {

-- 
2.54.0

