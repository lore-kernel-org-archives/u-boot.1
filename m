Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E6DD6A221
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 18:14:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17E268964B;
	Thu, 14 Nov 2024 19:13:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ecOC7GKv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 579FA8965F; Thu, 14 Nov 2024 19:13:35 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66D1F89639
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 19:13:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-539f2b95775so1302098e87.1
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 10:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731608011; x=1732212811; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v4LQTWPiwqk69FhMkLKB3Z8N1xTnA0PsXLReIVKhdjc=;
 b=ecOC7GKv99tBsW9U0qx/gGnFBrKxL5pbVbHTu48pxKwYeIvy8/w2e8UISdZroBVHNg
 LwrfqTlrzlI7Fzck/UnGnsDFDfkSQNmxH6FyAKAqBGm82U55OHWAxZFW9G4gtneFnUjs
 R2Y/ljaCBNpGgw7zMfc6SFhwTrXc5X0xnRdS8Tk0y0Kb4KinxFISCCtBARQXepszuuIy
 SdkptBrax1O1lQjqNWyHssLinqOStCSksvuP9EO1TKMTi930m3cpSfysqtiroYKAFNDc
 Qmah1a55QyLvEvGRbDB2Ejh06Z7CTde8dP3bWR6Z8bfzIHdlIK0AKUSzcLrmusZF2dZb
 avYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731608011; x=1732212811;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v4LQTWPiwqk69FhMkLKB3Z8N1xTnA0PsXLReIVKhdjc=;
 b=tTM+LuM/qJsyxFLS5Tqm6U2CwD8W6gyCNRogiJfSL3E+R/69aEhuwrsfB0SurEez8F
 mJ3H/H28d2HKG2eZQD9L0qO0hzU1e2v73LAcfAK/NSAc7P+oHM/EgPaRVu/mmV6NDVvf
 tQEjhf7mAaX53Yk1NAF6rp0oMJhKhFKqpha4ORrc3xpyd+uTb8Q2evGfvsm7vQvqVSdL
 jRdk68f93RD1IIIy3SZeWfeur6F4IOq00IaBzdl8gdt9cH0CSlBqojiY7T8PC/8o6KJU
 fwgRZpnHlrFCj+yif+fjDvNcZsuOY9EHtUIR/dsGLP+Nswk4RE9Jpd8UrynyRH5ySs++
 rGFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0v3GqIEqYg4rTavS1qHU6VCpkj2CtZuwiI2d0GpYd2uO2aWoKkBUhpwFke3BzSu7DVgZfK/g=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/8GXgilYywC6M/dg8y1goVP98Fb2NRLFEzu08kZwjPV62Jh+J
 Etjy9J+QYux6wIFmfMCUDJb4oEbOZYDKuDvkEM1Bd7BKteJDaP3Yrd6hip+e3prq8EM5s4/jVoN
 v
X-Google-Smtp-Source: AGHT+IH69ACB5Ra0QDRCIeGwxfm4HTQGF9BXS3lrF/NhvGDsqh61frQLnEIuZDrxhQ3YLF5ei1sUTQ==
X-Received: by 2002:a19:9146:0:b0:53d:a87e:f77d with SMTP id
 2adb3069b0e04-53da87ef7b0mr1703945e87.26.1731608011244; 
 Thu, 14 Nov 2024 10:13:31 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20e0860d5sm89590366b.186.2024.11.14.10.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 10:13:29 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20241014-topic-ufs-qcom-config-v1-1-b33cf11b6adb@linaro.org>
References: <20241014-topic-ufs-qcom-config-v1-1-b33cf11b6adb@linaro.org>
Subject: Re: [PATCH] qcom_defconfig: enable UFS Qualcomm controller and PHY
 drivers
Message-Id: <173160800963.3344230.5247120657431594601.b4-ty@linaro.org>
Date: Thu, 14 Nov 2024 19:13:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
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


On Mon, 14 Oct 2024 09:00:26 +0200, Neil Armstrong wrote:
> Now the Qualcomm controller and PHY drivers were accepted,
> enable then in the qcom_defconfig file.
> 
> 

Applied, thanks!

[1/1] qcom_defconfig: enable UFS Qualcomm controller and PHY drivers
      commit: 78f8ea0e1f6757b5e92567a200f6d4ac5be27d70

Best regards,
-- 
// Caleb (they/them)


