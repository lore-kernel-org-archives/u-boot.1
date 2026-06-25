Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F3BCDE000
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 17:49:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3A9A849D8;
	Thu, 25 Jun 2026 19:48:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="NFUiZqVt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99E968495B; Thu, 25 Jun 2026 15:14:49 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C21384949
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 15:14:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c0868ca8738so486377066b.0
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 06:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1782393287; x=1782998087; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MHZ1EfG86XdYoyaDotnVy+nk+jR7f31zY7jlba4mvi4=;
 b=NFUiZqVti6+9xg3+76xAVP2OURhXrvmhh3ijZUOekRMQzxVCbHFkqb8whoNLEDs6Cm
 LFe/uOkTRtVsrK89xDtUOWkQ9nrQvKSasIEMy2DN6De0XfOz35cG5MP0tvtUA2VC4YBp
 wWzyYxuK7EY26bSuRjjo5Qlw/G8/9eb4gqdQnmQ8w7k2FC5i6PV3klPgc297ojuWX/gs
 2U1ZfgfoTRTmMoDpmAw7D9sheHnl/O5wm7uPZHN9+1G0IrItiaF81d02MH67yNtJY/gG
 tbKbCer6J/mr27f4TvwmFk7edEnN6yC36SR73yfvZYVBIRIhYGmOEu6pnCOWazVi4eVR
 cMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782393287; x=1782998087;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MHZ1EfG86XdYoyaDotnVy+nk+jR7f31zY7jlba4mvi4=;
 b=Fo7w1uCeoLRznIpDFO+nYp+FUHd8WB1C7+vRXeFvnTt+/RuYUnrlJZo2sIUFK8xRw/
 LiYIliFDO1/6g6+LTOmiWRFk2EQLvxeRI5exwO6aDXkStL6yM+sWT17MKOf8nAzfhkuu
 +tTuqjyqT04GAeajdtxrqX9FWP1Lk4Hij48i+mBMo6gnN4F6E4juznSCKirrg7ZQ7sBI
 2gGBIkczI8tEgeW/DE971fekeJmSXJvn1qYHJY2TlXb0BkzQzvxDHW2sg5b3FK6dJNf0
 oLiFnmWJ1+m9wzKLsZrB90X14SGOdchwQj5nT/OHEx2k1aFQZ+4omMTIExrjd0lVntOR
 pFmw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqRoKDsrW+QWH3xHnEBglUP0yRSWQuLaAl0ysnDQXmAWfyqmq1d4HtmI925aWlqVKesJW+oxYU=@lists.denx.de
X-Gm-Message-State: AOJu0YyBrHg35/w/TSbN3INvJ8QxMhtAiW6SjGmI4TWCwyfI/Dkub1n4
 hEZ9mfHHbBKTlZqyTzp8/0QBsaQJSVwfqgADOGRyvHBqujxL/bw9L8PjstSK+xLapSE=
X-Gm-Gg: AfdE7ckI4897depDbOVY000ywCemvLfxztJQ4anDPkFx7+2f0/pE9+OrBS6HfauuMeD
 0DhZ7wAHBlSvhs0TX6A7LWJ5iviSDrgmgrmYc7nxzp+i66zeGjHvanytiarklmEaEfVYRJQqcDQ
 xCb89LROj4FSgDkVaxCfYqFbYtL+viWQ61FmQnTdYt/JFlntDFjyEJtWlSNaTJwvn8THqpKCwir
 +bJHd4pLoUGkOY5cjZCLkKiqa+Jsrtawp9+Picbci32tR5TeuaxrPFw16KCmms2DGmlvAqJO24K
 eyb33IPfALyjpkjJ80a+gf6EssRQEzCcnAgEYLAFsoARjlOOp5bN9Q9I59ZSgxajFwW+qa0vcb2
 axp23RMyfKZZ6J/RWr7J77vUqWJ2g65noNGVlKwcQdr2vXbC1KDUiliCey7r+Xu3pre73Oe+AHI
 gCyW6UWUNB0eZt1Gdigs88J3porQ==
X-Received: by 2002:a17:906:e10c:20b0:c12:b31:65bf with SMTP id
 a640c23a62f3a-c120b3190e8mr98891666b.42.1782393286891; 
 Thu, 25 Jun 2026 06:14:46 -0700 (PDT)
Received: from [172.16.168.121] ([195.76.196.164])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c11fbe05fa8sm180365066b.38.2026.06.25.06.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 06:14:46 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/2] UFS clock fixes for Milos
Date: Thu, 25 Jun 2026 15:14:37 +0200
Message-Id: <20260625-milos-ufs-fix-v1-0-b0923dabc35f@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM3QpAQBCG4VvRHJtaG8KtyAFrlpG/dpCSe7c4f
 L763guEHJNAEVzg6GDhZfaIwgBMX88dIbfeoJVOVaoTnHhcBHcraPlEskmtmsjEeZyB/6yO/Pz
 1yuq37M1AZnsjcN8Pfe7Nr3EAAAA=
X-Change-ID: 20260625-milos-ufs-fix-ef5a0b1c4948
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782393284; l=573;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=VFD75GYa8Slwr1wCyakda9yCyK25p4nUrHRc848bags=;
 b=w16BGetw5QATT0QaqlXmPnG0N/Bi+ldUJ0GjgxTpHAPXG+c4eJTxMWXLYtz8EkGKc330n27wt
 S9LU/+36eQNAon5XumQh+gZdf87GRZfuSmKmBA2jvMH7zex1LJvX9UG
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Thu, 25 Jun 2026 19:48:25 +0200
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

With recent changes in u-boot, more clock support in the Milos driver is
needed. Add it, so that UFS works again.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (2):
      clk/qcom: milos: Add remaining UFS clocks
      clk/qcom: milos: Add TCSRCC clocks

 drivers/clk/qcom/clock-milos.c | 73 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)
---
base-commit: 2a571a94d18287ad4bd6a69b91bd90c3817f245f
change-id: 20260625-milos-ufs-fix-ef5a0b1c4948

Best regards,
--  
Luca Weiss <luca.weiss@fairphone.com>

