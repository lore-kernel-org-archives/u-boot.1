Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C45CD1284
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 12:44:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 777D588289;
	Thu, 11 Apr 2024 14:43:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ADmu8vCB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 066D9882F0; Thu, 11 Apr 2024 14:43:17 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3015288263
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 14:43:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a47385a4379so157500766b.0
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 05:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712839393; x=1713444193; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hYTkj4uQfPz+WYGtrV6o+CVLqYvyjgK3MiMNEhM7dBw=;
 b=ADmu8vCBgeK2oBRqppe2v5RY+kM1joA2hZH545ZIUewqt+lusyo1BWpze1oNo8W+oF
 g/QJ/v3E/0rKy9niC5I8r5ukvAgMjuMfp5FrwhTToMzMq2Y+L596UMnDA5LF7s/4ysTm
 rKCaJw21YdYH3tpeRXCiegb7xBywO/hL/Ppfvaj+qA0/E05FfcxfnNldpGLErZHXbH97
 RswvgUn8NQtZgkPZIgyDc2HNvBBjm6psF4u3giawUfY9iEGrUweyN3sDaG0K47xU2xeo
 Bf708ljMWB05pAqwgXVAQYWqxg15w3wQKah4uSSs2vTNLfyvQhOwWCyGZ71pQoQaPNPc
 gYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712839393; x=1713444193;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hYTkj4uQfPz+WYGtrV6o+CVLqYvyjgK3MiMNEhM7dBw=;
 b=RKjyZP+N0w1MmMUiGYzxieAsjtXjnrHijdyGSnwXHUbbHjaRIkCxj8Bitsi6/Kh73F
 EULPtFylZJ/Kf+Lv02qBiP+et56ZIPoAQB7HiUeHwtKEWiWkyjH7GWjJqJY3Zvs3D4g2
 GNnDVF9qGSRcg8swCH+ImmB+Qr4jEtLGedHBgHTGWIuqwl0/tprpnkCe9K4IGNmR3tQt
 99CqstO1s+F7BwCWVE9nJ3Ehx9ROL+wYq188prtdpHExi4oVLLGVXoC/JEy1GvX9dOFX
 iT17WOsJVcYMz05ljOEf9Vh2kXxoH6Ljg9i40SWyzoojSN5xh4dBLOxw20e5D7tofid0
 1SPA==
X-Gm-Message-State: AOJu0Yx0QMY9xqjTVJGImF+zOPO3UT2qr2Z1ZG7ykTnAO3yFhTnYVNnZ
 DHVQaZNbeQf3dsAeAeMz/Kt8S6aHAvwTZ0juI6UyGcu99Y2q8IUriDtgX4uPUVhIf9Pn/AWl5Bz
 1
X-Google-Smtp-Source: AGHT+IGVmYxolpESg9iPT8tLzi2juQ0PQnYCfRz7DG9jh2RfnGsxXb3L4u1jZdGftGT6A/+QyBoP4w==
X-Received: by 2002:a17:907:1c2a:b0:a4e:410e:9525 with SMTP id
 nc42-20020a1709071c2a00b00a4e410e9525mr2456750ejc.30.1712839393564; 
 Thu, 11 Apr 2024 05:43:13 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 e1-20020a170906844100b00a4e8a47107asm710491ejy.200.2024.04.11.05.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 05:43:13 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@linaro.org>
Cc: neil.armstrong@linaro.org, trini@konsulko.com, stephan@gerhold.net
In-Reply-To: <20240411123726.356173-1-sumit.garg@linaro.org>
References: <20240411123726.356173-1-sumit.garg@linaro.org>
Subject: Re: [PATCH v2] mach-snapdragon: Allow other board vendors apart
 from Qcom
Message-Id: <171283939290.622116.11354369414400233489.b4-ty@linaro.org>
Date: Thu, 11 Apr 2024 14:43:12 +0200
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


On Thu, 11 Apr 2024 18:07:26 +0530, Sumit Garg wrote:
> Qcom SoCs derived boards can come from various OEMs/ODMs and not just
> Qcom itself. So allow CONFIG_SYS_VENDOR to be set correctly
> corressponding to the actual board vendor.
> 
> 

Applied, thanks!

[1/1] mach-snapdragon: Allow other board vendors apart from Qcom
      commit: 68f98096c09734257e5218897500a7279c6c4ca2

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

