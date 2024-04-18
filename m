Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316BAC04FF8
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 09:15:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75815885B5;
	Thu, 18 Apr 2024 11:14:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="QrGCeC7m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1E89885AB; Thu, 18 Apr 2024 11:14:43 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED15888120
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 11:14:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a4715991c32so61315966b.1
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 02:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1713431681; x=1714036481; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+XKgkd98RKODpwTSlfpxn2gLiY8RkN8bkCVQv5Zgbrc=;
 b=QrGCeC7mAIC+/Iwcx+/Fkxmxd4nKGvr96NDcKrUKjCvhhpZU6F3+1IG+aEWGRrhyHL
 ndHfK/3Ij8FzPvJcyc0BThIn0VUnrZdYpsUZ6N0rk0hMSNF8Lf8Kk3+LBYYBU7Fv0bPi
 ljVMgMGnz/QZ4x+h+lwZLvRuOOw1flscZx5R1AVrgKpzaAjeDTnhBuL0NYIC3eQSRK/e
 7v4Gobr1lJF4jCHAWIZwbv46g7qPNL+azEVeBGT5rzI3UDQq6X/ANGzsTOlCg8b1DbrQ
 B/13jTY3QrjA/BscExUGMdInMwi3c++Aw0tYuzaJhsW70Go+fLGNmjtVZWUzxIeYyFAb
 6m0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713431681; x=1714036481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+XKgkd98RKODpwTSlfpxn2gLiY8RkN8bkCVQv5Zgbrc=;
 b=eZoTA/SNHS4pfBk6kJNC1aRu7gbG/Qp2ylhTQ9QZuVWG9HPyoU2PnkFeHXTDj+OAKF
 vCKl/ngPYT/3tOKmPgutsTWucn7BHoUnQ1kIIr+ztDb4kak+Uqttbk68J+MysRRkb7Js
 sjFElrvLphl/LoT0hbSBY9vxS2Jwd2A0zRi/telVBo3+J03oU0HQjm9h9TpbBzNNavIJ
 ksk1pFtnhMSpLKXY0PD+hvauZxN8/SwtAM8UJvJUv54jCr/QkkceBRHkZAWiwJKYr3qy
 LzJLGlRsYhTCqP2foyUTolfSNazcJGlknubs72FsfE9ibJgE5NfEFKcsLh/NtHKs5Wul
 OeGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSD2f60MMokOProb97kmZivMHvS9YKxz3gtmGdvbkgPIXbliAo7tjVwHzM8c9jxP1L54lyMftroAROZqcHaAT0fz8w0A==
X-Gm-Message-State: AOJu0YzrahvCiK6jijvyrj9/tb+v7s61EMAdWzG4x2hc3j7sVbkYU+Zh
 C4EBnA8HqwtNV2n2dLALIvkHr0nyyBAZNauoQPueKY7OM94lcllhGPMkNkU5Wwk=
X-Google-Smtp-Source: AGHT+IHSEAMteuWnMdhKKY5EBnDU+RADC2QedK5O+QtPFR5t17ggJCmLIQl8MTydj882dIk0EENQPQ==
X-Received: by 2002:a17:906:4c4f:b0:a52:6534:3efb with SMTP id
 d15-20020a1709064c4f00b00a5265343efbmr1085686ejw.77.1713431681547; 
 Thu, 18 Apr 2024 02:14:41 -0700 (PDT)
Received: from fedora.. (cpe-188-129-45-161.dynamic.amis.hr. [188.129.45.161])
 by smtp.googlemail.com with ESMTPSA id
 c19-20020a170906155300b00a526a99ccecsm624322ejd.42.2024.04.18.02.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 02:14:40 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, u-boot@lists.denx.de
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 3/3] pinctrl: qcom: ipq4019: adapt pin name lookup to upstream
 DTS
Date: Thu, 18 Apr 2024 11:14:04 +0200
Message-ID: <20240418091435.18232-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418091435.18232-1-robert.marko@sartura.hr>
References: <20240418091435.18232-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

We want to use OF_UPSTREAM on IPQ40XX as its well supported upstream, so
as a preparation update pinctrl driver to look for the upstream pin format.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/pinctrl/qcom/pinctrl-ipq4019.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-ipq4019.c b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
index 4479230313..4fcc4b1810 100644
--- a/drivers/pinctrl/qcom/pinctrl-ipq4019.c
+++ b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
@@ -36,7 +36,7 @@ static const char *ipq4019_get_function_name(struct udevice *dev,
 static const char *ipq4019_get_pin_name(struct udevice *dev,
 					unsigned int selector)
 {
-	snprintf(pin_name, MAX_PIN_NAME_LEN, "GPIO_%u", selector);
+	snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
 	return pin_name;
 }
 
-- 
2.44.0

