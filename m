Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D66CAC581
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 11:39:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF0CC83045;
	Mon,  8 Sep 2025 13:39:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W+eaURyV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 817E083071; Mon,  8 Sep 2025 13:39:52 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 509AA82C84
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 13:39:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b043a33b060so670925866b.1
 for <u-boot@lists.denx.de>; Mon, 08 Sep 2025 04:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757331590; x=1757936390; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=edzwXg4mzmAQZL6qd8BmixFieRtrsRn+hOZKmYnxZGg=;
 b=W+eaURyVeypxBRrsNXCotToFsJuHnqJdFDx0oQCYLv81QXxhz8m/470vuWH9skMI4W
 nb0tRBvH3VJ1fJnCvKCiWNSmGSF5z+a3oK5MgykUsB6X0zt0JsBVG7B9bMqHvXTNKEN/
 C3gT3EgSRv9vgEXMg2cPBxBodl4m34JKG1PDw/xddZniKgQb3nA7HRwN/bVErUwcwcJb
 NhQo+CokaCeahbGPXpboL++P+gsCYIhbnH655lZGNktdeC/yYXNJr/4kxcDdWTqcftg4
 KSsijtJggPEdKOe8Vy22ndrwHSxEUCVOTa5bvHDXVe28soqop6jexIDh/PIdfNMrmL/e
 ozJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757331590; x=1757936390;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=edzwXg4mzmAQZL6qd8BmixFieRtrsRn+hOZKmYnxZGg=;
 b=wCLLIYOl/dhX3ggWES1LDkBRKSLClUTdGZYxFiVM84+7NsL0m+1Jnj8iDH1uacpvUh
 iLxILFZ6nX/kl8sFGiRDrVq5ONRIaR0d1LYgmaBctHL/aCxWs0AOrDMRkeShn5Xg8k3J
 h/sFktp+ys/f7g/bL9a22T+ESs3AcKiBZkgYum1B1xKhl9P0phAPI4PBxj2L63itv4La
 Vuyp1pCTrx9HkwfaDQRII1WlvCZ3OVY1mB2By1lFfOiHe1agjCuSvSFocO4q1X6DeDDV
 tS1AE2yoLvzgKXNNLFOEHE4Bf8TOrc6WorPET6cLfjsoNx8GLWD6VZ+evueqXUCn5SVk
 rN/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEPKjSj3CAG423iBc2Nwsi7ZVjCbk3NHpCT3tipSftoetkKqxl99VWuz9EzBSIqHh9QOkoO+A=@lists.denx.de
X-Gm-Message-State: AOJu0YwhxevJNKoDRVUuD4QpY2sy3LbJH8cIhNuvJA8DoXyzbe+Z4kXO
 hIfUEDW65SPSFZGWYQ6AdNcEWCe5jsDAacftm8YCcYJtyO10Iy8ZzCgTvR/+xaf9YRk=
X-Gm-Gg: ASbGncvT87AbtEIBllk2XEuBTOMFno2m1Frr1mtY+UqNFYVAme2eUcb39fGjqjBGpu3
 licYp3t2nDz+UHThhDSJM+eoz+7CXcg1aB8/Rs8CfuNCd1SD6H8JrDTQ6rFjoffEU165NO2gKQZ
 GZITEgdFe5XuVOxxrKabNJI8jCdBQYapzfVny7w9DNnBG3FjGOZFt542y7uZFtw77EfB1yUvNa8
 1W3k8zFv21t0h2NJzn9mZY4uDx+0KT4EfrjCY0kpTekIbcboHkW4etnKubIYgY/kkreepTIz7w+
 7tjBAn76ZfDBbSpHzoYLtiWdhVsnT61rGXhoUK0lt98EUd2r/wFWjCcPSEei4vdxiOkc1yUGzQm
 JIjXjgGc4CTngMakJhUJMgofTufsjdWTKMydzeaucGRk=
X-Google-Smtp-Source: AGHT+IGMnj7SwZD88+IhjEgCQvU4Og8JwWzZ65pJkKZC2QRFxyedslZpFWRBPpBqHei3YX4QfHu1jA==
X-Received: by 2002:a17:906:c109:b0:afe:86fd:2a3a with SMTP id
 a640c23a62f3a-b04b14916a1mr737107566b.27.1757331589575; 
 Mon, 08 Sep 2025 04:39:49 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:30:60d4:28a5:7729:b0b6])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b04279a59ffsm1921606566b.60.2025.09.08.04.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 04:39:49 -0700 (PDT)
Date: Mon, 8 Sep 2025 13:39:44 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Marek Vasut <marex@denx.de>
Cc: Sumit Garg <sumit.garg@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Jianfeng Zhu <JianfengA.Zhu@sony.com>,
 Jacky Cao <Jacky.Cao@sony.com>, Sam Day <me@samcday.com>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Casey Connolly <casey.connolly@linaro.org>
Subject: Re: [PATCH 0/6] usb: host: ehci-msm: Clean up and fix crashes
Message-ID: <aL7AgBHg6th2w1a5@linaro.org>
References: <20250407-ehci-msm-fixes-v1-0-f8b30eb05d07@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-ehci-msm-fixes-v1-0-f8b30eb05d07@linaro.org>
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

Hi Marek,

On Mon, Apr 07, 2025 at 11:54:20AM +0200, Stephan Gerhold wrote:
> The ehci-msm driver has several subtle issues and stale code. Most of them
> are minor and do not cause issues during normal usage. The last patch is
> the most critical, it fixes a reported crash when stopping/re-configuring
> USB, which has been around for a few months now.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
> Stephan Gerhold (6):
>       usb: host: ehci-msm: Fix pointer check
>       usb: host: echi-msm: Drop ulpi definitions
>       usb: host: ehci-msm: Disable clocks after all register accesses
>       usb: host: ehci-msm: Use clk bulk helpers
>       usb: host: ehci-msm: Drop redundant EHCI register writes
>       usb: host: ehci-msm: Register ULPI PHY through NOP wrapper
> 
>  drivers/usb/host/ehci-msm.c | 146 ++++++++++++++++++++------------------------
>  1 file changed, 67 insertions(+), 79 deletions(-)

Could you apply these patches and send them to Tom? These are important
fixes to make USB work properly on the dragonboard410c board and they
have been on the list for a few months now. There is already an ack from
Casey as well.

Or would it be easier for you if Casey applies them? I'm sure that would
work too. :)

Thanks,
Stephan
