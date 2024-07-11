Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9117C3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 21:28:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 218188874E;
	Thu, 11 Jul 2024 23:28:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k2OzmvW/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD275886B6; Thu, 11 Jul 2024 23:27:58 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB73C88606
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 23:27:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5c670e5469aso684370eaf.1
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 14:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720733275; x=1721338075; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KhB//8CjtUZB7w/U0DA6hawcTa2uORLfbHPzLSxLIkM=;
 b=k2OzmvW/Sw8Q/+XYVbM2nSNdDJ374wGCtg7bWy8Qo13aUwAbAeevwINas7t28uxK1I
 0OWlue4Th5LWUC++TgJhCC8wW+B07ijPgAZIzbUNG3OeWaGVpSHTXSWwACPk9zBJbNK5
 54isWKlB4BmoIMoQIgDO5vveshqOvS7eAfQGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720733275; x=1721338075;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KhB//8CjtUZB7w/U0DA6hawcTa2uORLfbHPzLSxLIkM=;
 b=aEgk12Vmy0HXaB2ZUTTuSBMw2fFNAN9HP5z1wnkp1+vsyCWaS4jISWlq8XiCR3V/Hc
 /y+krWeTth/dPJEjW34fUHB+nxrvRCXOKj5SPSxC6vGcu2LQVKITmC/zcw5MEEyiYNIe
 Ce5ewxJgSwwJ7MxZRy9Dyw4louuyytsOrGAyizAFBnfg2517/qqZ4oUN6i53dfnCPTN/
 cA+vr6zCaO3dIxrgnX7/pZ8UOCwPj2dxsJMYJfFbinUN5n6qJPkUCC53u0taVW4Dp98v
 bUZRieYEZTFAZy13Wb/KkskbPc8TJb4Zd2l/e6nOyl1BCOv/rUIRjBTXco0kqa3AguQX
 OpNQ==
X-Gm-Message-State: AOJu0Yx7brJdNQx6PzU4FkHBmLAC66hfeqhaikuBxGV1Ssmt7M/L/I0L
 k9y++zPQoBGuD5i+e0Io1hLc19RpAyKtIBinCdO128fIxTTQOvgaOkM+ZzueVmM=
X-Google-Smtp-Source: AGHT+IHvJz108x6pls6NM3nndspIFeEP10QkMAqLWjZVjUdtUx+9A+Fdah17VxxJpRe6H6mPwRStnA==
X-Received: by 2002:a05:6870:4154:b0:254:7a82:cb3f with SMTP id
 586e51a60fabf-25eae8462bdmr8375761fac.25.1720733275467; 
 Thu, 11 Jul 2024 14:27:55 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25eaa29478bsm1824155fac.46.2024.07.11.14.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 14:27:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, upstream@lists.phytec.de, 
 Dominik Haller <d.haller@phytec.de>
Cc: w.egorov@phytec.de, jma@phytec.com
In-Reply-To: <20240702092240.34349-1-d.haller@phytec.de>
References: <20240702092240.34349-1-d.haller@phytec.de>
Subject: Re: [PATCH] board: phytec: k3: k3_ddrss_patch: Add ddr phy reg count
Message-Id: <172073327488.2744109.1462358855031641154.b4-ty@konsulko.com>
Date: Thu, 11 Jul 2024 15:27:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Tue, 02 Jul 2024 11:22:40 +0200, Dominik Haller wrote:

> Add and use the correct number of ddr phy registers to update the
> corresponding settings.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


