Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8DAC87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 15:44:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C88D83F9D;
	Mon,  4 Aug 2025 17:44:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ePZnAbaB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEE9883FA0; Mon,  4 Aug 2025 17:44:14 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0496E83F9B
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 17:44:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3b783ea502eso3495762f8f.1
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 08:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754322252; x=1754927052; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VY5/FkdJqC1JIXV5i/gNRqMivIzqy1/X8baUIWZBqIA=;
 b=ePZnAbaBiJOtblv0mPVISmKXx9O8n8DhUXctEnTc6FzFZ7iWmKGwa4MVk0qrQkcxFm
 UDa/AK0KTvSgIdkiLOO3c866gmyDTkrkGx9lEpUrXK5womUdr9aNneOdOQZkp6kIi0NZ
 nnbbM+MRhqW4lgrpGErcMq2CyKXgdqODakj71PfLnBQk7wZNOYlUnma76oPtf4TQRaI5
 spmRZ/4aH2eqHE/IKYKovuZyqTS7MuFcgFftfTA4Q0ApnnybRzucA88El4t5ShdF/g44
 S6XJ7O/eHUrdl5KnuDQhnGkonwjk9/RLKAE8cK1rpWZoXFsjmeNrAzEe940UJFR2cwpb
 +Ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754322252; x=1754927052;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VY5/FkdJqC1JIXV5i/gNRqMivIzqy1/X8baUIWZBqIA=;
 b=Ar156ogpqKSYE0eeXpgJbjzxlalZicmV2u6bInni3zVpL5XThepErLKS6X3Cpw9Siu
 w5EzcKJov/Sbf6zdUufhPT+lrkgJu7UpbreA28PgzwAU+oRP3FO8vRNjbzvFnQ1PVPx1
 N8qYLNnh01tgO9vhq5bHQt/5lMZtH2889Tapq+VBzQL5zCz751FH61qArm2OoxmM7K4X
 Y/oCycsfZgTPEJGvU5fiQZzINyQd/RvOf8ioJL8UB+z36R79ndBZSfd57rIySyJqrOgu
 zBvkoQv4iWoy7+qn05KpxJt0Rc9NfYV/GuH8QEkV4vvdLTUVASBqC4mQ7rVDVwQOiS4J
 nDpQ==
X-Gm-Message-State: AOJu0YzB9kGrZBi5LWzpILfYwf2/EnummSC9ZebkUzacbuPrSpQunJJo
 GxeijlFLBphbHpIvc5Gm90FIoUxv3CxJeIaeC82y3bi73zaObI/b524bZ5E+5uXe+yayd1iYPCH
 fdCie
X-Gm-Gg: ASbGncv+R6EB7YW/wvgi8h72g75V31pfGfrlRlht1wCtOsLupJ/1JZUdxbHJd6QgAoa
 vwyIla1heersWblDx6ggvlOsaPdM+M2OAcE2i/yncfPnlSDnDhHD5m1dgEoIY0urYfh9vVOtnNE
 h4MLVCZk5C2KG7QCgRglzIm0njjL/fBFGymfiPxt6zhjX0osMjvK74pfguKz8O4uxfHfDJHosQF
 e0dqmYYxqd3kThBYLwo+2XCRZDB+xXJRkQbJrZnJ2gq/7NBmIakEo/U9Tc/Z4Br8EXI4W2HHC44
 TZkwX8qAEMWScPx3XFDf3Qntxbk/zR76rfCMmDgfKPBnhjqppj7fPnWgrxONojQJYPvQHP3FuhD
 MW/tcOzoXjl+KWbNQy28nmbf1w/L7XsWOG0NHfruWI4v/DAWW1P8=
X-Google-Smtp-Source: AGHT+IEDCXmJ1Sr9h0R9kuFX9hrP/4y1Kxu47URBFVOZW6XkYhxzlnFT7XHAoSeWS4iFRTdMUc4GHg==
X-Received: by 2002:a05:6000:2506:b0:3b6:5d0d:9826 with SMTP id
 ffacd0b85a97d-3b8ebed5295mr23591f8f.21.1754322252308; 
 Mon, 04 Aug 2025 08:44:12 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:1ba5:34a9:feb8:a948])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458b9159e00sm98818675e9.9.2025.08.04.08.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 08:44:11 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 04 Aug 2025 16:44:11 +0100
Subject: [PATCH] net: fec_mxc: Set error code on error exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-fec_mxc-v1-1-1ed9b5df2828@linaro.org>
X-B4-Tracking: v=1; b=H4sIAErVkGgC/x2N0QqDMAwAf0XyvEIrirpfkSExTWce7CQZQxD/3
 brH4w7uAGMVNnhWByj/xOSTC4RHBbRgfrOTWBhqX7e+941LTNO6k2tj1yXCIcQmQKlnNHazYqb
 l7le0L+stNuUk+38xvs7zAjA42VpyAAAA
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In fecmxc_probe if a timeout is detected when resetting the chip no
error code is set before taking the error exit. This could lead to a
silent failure. Instead set an error code.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/net/fec_mxc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
index 54b08482b91..ccd5589318e 100644
--- a/drivers/net/fec_mxc.c
+++ b/drivers/net/fec_mxc.c
@@ -1344,6 +1344,7 @@ static int fecmxc_probe(struct udevice *dev)
 	while (readl(&priv->eth->ecntrl) & FEC_ECNTRL_RESET) {
 		if (get_timer(start) > (CONFIG_SYS_HZ * 5)) {
 			printf("FEC MXC: Timeout resetting chip\n");
+			ret = -ENODEV;
 			goto err_timeout;
 		}
 		udelay(10);

---
base-commit: ae5711f881100f856ead1e76832c32b92dba93c7
change-id: 20250804-fec_mxc-5d77fca91d41

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

