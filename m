Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B8DCFB44F
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 17:49:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A96F28899C;
	Mon,  7 Oct 2024 19:49:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NsgiTokJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1BE78899C; Mon,  7 Oct 2024 19:49:49 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8AE8886B1
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 19:49:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-539908f238fso5279690e87.2
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 10:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728323387; x=1728928187; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7XX6POSZ1RRJ/9+4H7IMZADhWjjy2Rhl1HsPJJ263tw=;
 b=NsgiTokJDuNUPArNBEE1DvzrMCoeOObtlNj93xvtsGVxTpJ9woJpfRLNFgPuHw/tBQ
 qqRI5ujkd05cb/n//lYg4iPyRjK+T91dkjTKW0DY5DGAAgJ3tqHqhogpuTVOFtBcNyaK
 rOPYHpc8/2wBxvdxNsROJ6ie2asUIpIVkPMob7Wd1PDqEoCZrb4cR54YXMS8r09xlT9n
 UHArfkQsyslJFgbrAS0QG82vw73h1KqmnRJJLXP0ZOWz0RZlK+CPotcA5NjRZCHWjqve
 PVhBf3o/Mrm6aorYrmfm1UDKF05sRaflN+UTW1i604+rmgS4k1owNSKjQLSnFfOjIC8R
 juSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728323387; x=1728928187;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7XX6POSZ1RRJ/9+4H7IMZADhWjjy2Rhl1HsPJJ263tw=;
 b=eO+s7CwK6sITUBMC0kF2nORWYPyXHnszXpEPoR+IYxOF7G+P3eBz38D3yKJVtKt/vE
 BRGuIHYgHCBC1Zhh7IEhq4yKJJs9P7Bc4IX9scNOX0xXlbq9zRa7BonQ+tkTvTL+3jHG
 5RK3nqCFMoDLr2dltPlEfc8ptRzLzR/G9lRXYi+zDDE+kDENlc7Ez/hm+HtbGZxCP5Y3
 AaVmEBCHY51v48T4Ch/c3cup0zJhLcTVeHcnT51LONlb5WO/l+3lvnuWsz61fAsXpJgT
 W+we3nGTvB1xpBPZCcoDHSrOxb1D+UaEc+Kz9aFiW+wXSO5sLpD/i5kvB9XBDwvXVYUo
 XzUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVFfpZEDJ6CpzdTRZXRkNCXh3PSvgO+LIcL37qqmmi/06D5X6lGPrQqY48Mbv/dlFgmT28N0g=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/9LpEDqM6auJqhk5zetGauxq1DSuIlvfg1yvoCSyC8gWCsO+p
 3pHMyxaFeaHH4VBlLJzgRkufNqoZdM6FSfC4c90SlndPSW0S9m76tceTxZQYZXJHYQ91wqxJksu
 PiY7qqO3PIF2XDRjbsYEGxVUSJEc=
X-Google-Smtp-Source: AGHT+IGQXbffgxT51ah7zdrqPcaR7XKRRCBXQO3A5IEEwp1yN7R1q6lcBGedc6VpR6JMkjz5Fc+yufLN2Lzr5sl7akg=
X-Received: by 2002:a05:6512:4007:b0:530:d088:233f with SMTP id
 2adb3069b0e04-539ab9eadeamr5978462e87.40.1728323386775; Mon, 07 Oct 2024
 10:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20241006095022.2800641-1-alice.guo@oss.nxp.com>
 <20241007170449.GA4737@bill-the-cat>
In-Reply-To: <20241007170449.GA4737@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 7 Oct 2024 14:49:35 -0300
Message-ID: <CAOMZO5DdAgRAba_43aR4SrNto26R=SFwusJhG1C1z0LTNEvLOA@mail.gmail.com>
Subject: Re: [PATCH v1] scmi_protocols: Update discover list protocol message
To: Tom Rini <trini@konsulko.com>
Cc: alice.guo@oss.nxp.com, u-boot@lists.denx.de, alice.guo@nxp.com, 
 ye.li@nxp.com, peng.fan@nxp.com, akashi.tkhro@gmail.com, sjg@chromium.org, 
 marex@denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Alice and NXP folks,

> Changing a constant from 3 to 4 isn't good, please define something and
> add a comment explaining what the constant means so it'll be clear
> when/why someone changes it to 5. Thanks.

Please improve all the commit messages from the recent patches.

All patches need a clear commit log explaining the
motivation/rationale for the change.

The recent patches have poor commit messages and we cannot take them as-is.

Thanks
