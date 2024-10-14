Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BA2CF2590
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 06:56:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC7E288FCF;
	Mon, 14 Oct 2024 08:56:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z2vonKeG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3520888FCF; Mon, 14 Oct 2024 08:56:33 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFD6D88FEC
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:56:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37d50fad249so2434392f8f.1
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 23:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728888985; x=1729493785; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d6wtmNmPTFH+gCy/ph43KnfAks3+AKH0zYC05KuFF+c=;
 b=Z2vonKeG12g0dSwYdUJhV/rO+ISErKdzMpQgOlLMLezOSRqlAJCh/rg5LoaeEamQmj
 jetq/8XAw6axgAeyOZB8zMBC7hJckLPpRNR/oIDjp2p6dgZh+aQ3vq8kbnLSiFj2Btda
 s135gcCabHI1FSVjYqzrW/Uwx35LrfSe28BIW0HQL1Iva0MgIhYTDLCc5vyKqPxIS30t
 dhSrXjGKfAD+jegn6njsTYfwhgiHnYtqtXPLojRAFv976irPW7swops2cYzqMXBUf1lX
 s8eFPhCuntLqGEJVSkSg6HXrKngGl6H9mA7evYZYdvGql0McEkznmDN6cX+rBD998jfN
 0vwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728888985; x=1729493785;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d6wtmNmPTFH+gCy/ph43KnfAks3+AKH0zYC05KuFF+c=;
 b=GEfju94uR8mKm/u9U28Z+Oce/pwceHNl+x5W1AT6PxucDHGoj7Ql+W3A8MQZnVkJes
 c6MiD+aOhuo02UvOUM27DDhiALzc+Rzp0TnA0bCZp6K1DVG5LL0MxMvtlGvQxaBs1jku
 /34kiFOO5q6BgsF07Wc62pwNUC5iDl935wK0QYzAPLFACu726i/kCRdLCxG1cNYi6U4e
 iFXZikpGPYeBpphDM/wns3Dye1abPAgbCXa62tvp9hty8zBTYapV86PhfItUb4eDFRlt
 Q5/BpnyVqsNn535nsQbLalyzBhoL+sURMJs/C/85er9/7MiH1NZKhheU+i330tPxFm5m
 Ohcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/8Mx+yu6hyxam15qRaUOj15mjRFocOPeJrd9R/fnfFA4MlVEln7HKXK4+Od8Zg5w5RO+uyAc=@lists.denx.de
X-Gm-Message-State: AOJu0YwFOuHYrteJYZQ88Hy/QNCq9zYSWPaEWYG3EZoDuuWYEWzSL1DY
 lnMXycag6qcif4ocgAO/k7zkzgtox9OvW38tbtps7ll/8iuaAr5MuYszIwpOOlt6FzIHmYIG8Ut
 xdkw=
X-Google-Smtp-Source: AGHT+IGabrOOSj+3X6Y3mXRUHKfJWs9u3dCN+PqdPppUuns34HPK3NWaOf7KN9tfGtdULS6+YVvsug==
X-Received: by 2002:a5d:48c9:0:b0:37d:45ab:4241 with SMTP id
 ffacd0b85a97d-37d5518dec8mr6738523f8f.12.1728888985149; 
 Sun, 13 Oct 2024 23:56:25 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-430d70b4331sm145900095e9.36.2024.10.13.23.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 23:56:24 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Marek Vasut <marex@denx.de>, Caleb Connolly <caleb.connolly@linaro.org>, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20240719-u-boot-ufs-dcache-fixup-v1-0-b044fc9564e9@linaro.org>
References: <20240719-u-boot-ufs-dcache-fixup-v1-0-b044fc9564e9@linaro.org>
Subject: Re: [PATCH 0/4] ufs: properly fix cache operations
Message-Id: <172888898374.195460.12545738205075493394.b4-ty@linaro.org>
Date: Mon, 14 Oct 2024 08:56:23 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1
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

Hi,

On Fri, 19 Jul 2024 13:00:09 +0200, Neil Armstrong wrote:
> We experience huge problems with cache handling on Qualcomm
> systems, and it appears the dcache handling in the UFS core
> is quite wrong and causes all those issues.
> 
> This serie fixes the dcache operations, and fixes a big data
> write corruption due to a wrong data end address calculation.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u-boot-ufs-next)

[1/4] ufs: allocate descriptors with size aligned with DMA_MINALIGN
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/9c223d8d8b8fbad667971f36eabe203480a8c39b
[2/4] ufs: fix dcache flush and invalidate range calculation
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/c64d22b57d8a9fe4d08ab677ba33d6004b98a468
[3/4] ufs: split flush and invalidate to only invalidate when required
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/4139e5680bcf3016561c8830d914ee0b0ab741d1
[4/4] ufs: use dcache helpers for scsi_cmd data and only invalidate if necessary
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/589a7bf0febbe4d3ca319569a55f21cf06e85424

-- 
Neil

