Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AA2C4829A
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 10:48:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 969C287C10;
	Tue,  6 Feb 2024 11:48:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YsdB4SOE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C64D887B8A; Tue,  6 Feb 2024 11:48:46 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97B7387C56
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 11:48:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a370328e8b8so520858166b.3
 for <u-boot@lists.denx.de>; Tue, 06 Feb 2024 02:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707216523; x=1707821323; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3NWOTSEugpWXOQkEmUlh3u2KTzwZLw9aHqKJM8twJIQ=;
 b=YsdB4SOEgZQfGzPcs2pwf87nKb/t6trTqUxOsFdrWUmFyjbxqSW34hXFnrqkvPDHV5
 0oBo0pZFhjQodclv6BzGjfWwsHb0I4haGE5A6yEwzw/7jAfLsJbeJhM5eYLG5pU4NAN5
 5uV11rPgBSmdhbeCGnARNefpTrqLerQYYcuwm2BPwZPNvzMS7vxakCpDqri6W8wAys20
 exkyF3rSH84h0rzDDRLZopFuND4CoeE2GuGfwiJGv8c8HffZfajUIM3cgnwIHaE3UXnM
 GzPl4Rjd/rEWcaQU4K35ywYmQ/eVYFGrcg9wtsm8opa9lJkJeqrPR7G2ia4q7c73X8Op
 5Z4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707216523; x=1707821323;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3NWOTSEugpWXOQkEmUlh3u2KTzwZLw9aHqKJM8twJIQ=;
 b=JVpWAipQQrFSksTRIQKmTVWFVQQcRWeOVrvwjU7pfMPzIY5dFdtPU6J/NPrVQGTGgy
 P77g2D9jYGYLCkgB2QNMTmOAwb0NPCiNydoaC0Gg8P/3mFEdCMMRdmgSkUMbZd4G84aD
 8k5M+AFQRYe5Zi+EMj77+1/l1iB+545QecQO9a6C8Y2o32nBECgS4PGVcPg2nM5PPPO2
 JTx0foWhrtD83cTD8uDW/fs4VLs3HjKk6vodWMg3T5czMRniFgkmFtBsRMpnRGrJAkr2
 tjZNFqeKENZLPPPCWuq2weo+kZq6sVBsl7iaucyu35jc4sv10LajEPGpM5RVjUR+RQYQ
 uPZg==
X-Gm-Message-State: AOJu0YzI/RtN16y+8l+pAZiDHULPy6f+y1M3ZzYheOsU3cacFtxW4Oaw
 lndhsM6OT6t3MUogL3QJXOxEdvOHDG2UsSOqgcDfyJwe3cHbn5AsoRiRKzzRAvg=
X-Google-Smtp-Source: AGHT+IHnkczuv9REilXqN4SmPjR3jz8L5aBkZJCV6Kk0yIxuU/nQfFC5mW/2hf6I5fAP/B7jsAqDKA==
X-Received: by 2002:a17:906:f14a:b0:a35:c6b5:ecd0 with SMTP id
 gw10-20020a170906f14a00b00a35c6b5ecd0mr1497309ejb.13.1707216522992; 
 Tue, 06 Feb 2024 02:48:42 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUJo7EI4bUEinhemVjlroSR1Mfipz6VNC/nJaNZ3i2wgvPVgCPdW/Hr+zCc7PnjpDuyH31ffamLb9ZX74IA1HaPGZLcuLj0eZvSx4I70ynUg1Cs16Qa3Kf4C9DBluZGTYEzX0hKOa2qC0dqHwCCWQr54HHKEYbXGYviRLiPd+XrtbK/SPFYymUyrARkb0uTTMe/k8n6bfRc1ERgkO2cfLzTlm9QgzDWC6PwsOasckTNmQuiVG55jSh8M3vqca0K7bOX
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 tl27-20020a170907c31b00b00a384810f371sm36900ejc.190.2024.02.06.02.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 02:48:42 -0800 (PST)
Date: Tue, 6 Feb 2024 13:48:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Teresa Remmet <T.Remmet@phytec.de>
Cc: "festevam@gmail.com" <festevam@gmail.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>,
 "sbabic@denx.de" <sbabic@denx.de>, Benjamin Hahn <B.Hahn@phytec.de>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 1/4] imx8mp-phyboard-pollux-rdk: sync with kernel
 devicetree from v6.8-rc2
Message-ID: <0238062a-5f82-467a-a697-364f9a731c6b@moroto.mountain>
References: <20240131-usb_support-v2-0-7521c554b597@phytec.de>
 <20240131-usb_support-v2-1-7521c554b597@phytec.de>
 <613a04d818f8d8c6177f96311046437ababf7c91.camel@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <613a04d818f8d8c6177f96311046437ababf7c91.camel@phytec.de>
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

On Tue, Feb 06, 2024 at 10:36:33AM +0000, Teresa Remmet wrote:
> Hello Benjamin,
> 
> 
> Am Mittwoch, dem 31.01.2024 um 09:45 +0100 schrieb Benjamin Hahn:
> > Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
> 
> please add a proper patch description. Adding only a subject line
> ist not enough.
> 

One idea that I had is when people are synching with mainline they
could put the oneline summary of the stuff that's getting merged.  In
this case it's the 6 most recent commits.

$ git log --oneline arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
4a58fcdb1818 arm64: dts: imx8mp-phyboard-pollux: Add support for RS232/RS485
3bd7fdcc359e arm64: dts: imx8mp-phyboard-pollux: Add gpio-line-names
f5faa633daf8 arm64: dts: imx8mp-phyboard-pollux: Enable USB support
27c0dc128d04 arm64: dts: imx8mp-phyboard-pollux: Add flexcan support
fa2a1ec50456 arm64: dts: imx8mp-phyboard-pollux: Add missing usdhc clocks assignment
055e38c76388 arm64: dts: imx8mp-phyboard-pollux-rdk: Fix led sub-node names

regards,
dan carpenter


