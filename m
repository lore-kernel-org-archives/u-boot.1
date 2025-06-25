Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AEFC7EE2A
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 23:53:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B57D82E50;
	Thu, 26 Jun 2025 01:52:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LSYqPHs/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BF1D82E05; Thu, 26 Jun 2025 01:52:26 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADDE982E17
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 01:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-610cbca60cdso265535eaf.0
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 16:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750895532; x=1751500332; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FvBIe0x3zM2IDFFrRLp4IEXQ1bO7fal2nAV3zQJSD4w=;
 b=LSYqPHs/PgGVZcSGSBkepm5apQ6sjvjZ9tCboW7j7ZcmKwzNLlh/rHA0DjrOAC4xKZ
 fFEyYiIz3g5H8Sb2t9OJfsQI+rZdgHYieqghc9j201jeSunIvcLd9uf/VxIJsg8VluXd
 N6BABTbotZoI7XV8T/x6pRdNhAiK1fn2ss6tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750895532; x=1751500332;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FvBIe0x3zM2IDFFrRLp4IEXQ1bO7fal2nAV3zQJSD4w=;
 b=L7ah8Pwn+iu6F3ta+PGmpJUzgbENAH/E2GtgmPePYxAMqUxWtF20PT4BH8ukm25d3I
 5CwIokl3jfmAsHpPuhkkhs7IMBcNssO8bQTVnj5G+5aaIOXHB7SRLfo6APJUC0RTtZIe
 LcyzeVf8teL5tNLcTR2/XvT3Q1/JOZTu3fhJPjwessezZxpKIRQamMWicqohK0H/RgVC
 yHhu2kFizKk35BdxBDHB53pKDBKntpeOFRE7DvT3jEZuyw/wcyhws/mqN5L5v8dX3F7M
 FSidI0ksryzaetp4OA23UnRLiNPoEfbWAG+kgh9YZGaszKX58EifJ49N16v7k7ibgyZt
 yzwA==
X-Gm-Message-State: AOJu0YzrH5C+6zJShQ7G7jnEIATu3jasxGggOuHW3B6g2h0uZFZ+Ix15
 lLYGdMmHiKSEZKsOsH5btDPZdkyy3h/Gj2u31dE9/wJ7+2sZ+TYazRYyTRPyDxpKh+zL53U/qvL
 wFa1ryK8=
X-Gm-Gg: ASbGncu7NUfIKRAXR+SioY0c6yaC7K11JEtjfJB0AguJ4m5JZO/9do4deIPZSsQhun2
 MMNIaTlLB28OUfQNlPMRwDJd8/BsYaub1zxkknn5JuYdJbHhvnfKlE/vrNCzEViGArFq8q2PbtP
 /Cj0yLak+bJ2NP1e+IWxR2gw3226VFsIUnzkk7+qHP9J4Dxk1g2dJzA1+C7n9SP7r0inL+nXxDP
 TN522JyqeW/gAFi897OjAlSVVzVo8L11pN9wkfPsAhBGIqxtzL8CNsrk/YKe+rh/cqwfuL3I/WM
 wzs0ksIipRaVAorSzakl4MLiTsIo9RiydbcAAFlwTZKqzUolf+wGV2+wlB0T7PHFXFHn2/pMJGA
 C+cBTY5xIGJfInKDjzMrhOA==
X-Google-Smtp-Source: AGHT+IF66ScH6J5fdEin81f/Woh3c8Kd8X7QLmcoxk8DCTWGCOpKqLJekBzLvscMdgvNKYhcAdjD2Q==
X-Received: by 2002:a05:6871:78b:b0:29e:48d6:2e62 with SMTP id
 586e51a60fabf-2efb2545649mr3731566fac.9.1750895532437; 
 Wed, 25 Jun 2025 16:52:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6115b6b3052sm1751134eaf.10.2025.06.25.16.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 16:52:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mark Kettenis <kettenis@openbsd.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250602201009.90885-1-kettenis@openbsd.org>
References: <20250602201009.90885-1-kettenis@openbsd.org>
Subject: Re: [PATCH] cmd: smbios: Fix header for type 3 entries
Message-Id: <175089553128.1525333.7542867060921249882.b4-ty@konsulko.com>
Date: Wed, 25 Jun 2025 17:52:11 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Mon, 02 Jun 2025 22:10:08 +0200, Mark Kettenis wrote:

> Change from "Baseboard Information" to "Chassis information".
> 
> 

Applied to u-boot/next, thanks!

[1/1] cmd: smbios: Fix header for type 3 entries
      commit: f35f053755f98e077389517f80ad7da81b031787
-- 
Tom


