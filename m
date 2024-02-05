Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC7DC4828D
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 07:25:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D0888777D;
	Mon,  5 Feb 2024 08:25:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aa2VvpHO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0E6E877CB; Mon,  5 Feb 2024 08:25:51 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B74C68775F
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 08:25:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2d09bdddfc9so16668251fa.2
 for <u-boot@lists.denx.de>; Sun, 04 Feb 2024 23:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707117949; x=1707722749; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qc1clMkaqt49TuSCPn8OSupblVs8qYtIfl4wcmGCEDo=;
 b=aa2VvpHOsxra/BEMpamFrJMcyp9X+1HCdCmheWXu2b7x0x3EdKCbBJphigdQ47WGcy
 N2wKEsNlU3C/XYpDKn1nXaq06Yc7oPabEq6dQMF1HHsoaYPMZPh1vj281qvj4jnnyYrO
 mHitR4OLRFfZKjkyCzy3xsGFN8jEuVNvg3fO4KMhvrnAJ2ya9RmnWmvQCMWuMxC+1c7E
 8MB6K+Q98QZm7yp4VzFEykMnC+ytOM+Ew9QMgdKM2RMTGSrPqKfmIDf0iHJH1IDaQn8t
 EJp9CMav8ljZaZH2w8pm0VCbjtCI1reJ93QIHr/Hft0b6sDdYMFkaB3p8GmxQ1OklWWD
 CWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707117949; x=1707722749;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qc1clMkaqt49TuSCPn8OSupblVs8qYtIfl4wcmGCEDo=;
 b=vHbu+k2+dyixeOl28lO6lKifStaqulkiIl8b/KWxi4uhU1FvbZssY03zf3BvXLe5gH
 5wRqKevLRDhHjePzX2aEeJx3vT7qKQJ6gZkkdcUoZPshiXp/WB6qjxsFL3pPdXrG+AN8
 OgbX3DKX82/QQ4AnpekSopO3oXwRuV6XjsoFj5kKtAD7Q4O/UvDBuz8kG5/gzGYFGyXv
 0LFXCXsDRlFs9I/uMhcvWBNLtm2DPmZpmprSEw0i22spkMcd33uOwDq4/gwkpwyBGhlA
 2ExutSr7jrgn7cEqkQV8kMD3LskAQlOV1Lf7nS4upsqUejFNTdpaPc+NzD+MCRWb3Tcr
 LfIw==
X-Gm-Message-State: AOJu0YyYp142oGhQIO8ZyUEdj1qfQkqOkVELYoefg3LCuKQjC+aofW7G
 MfJ6uns4Tyb33QAII8OWDCpHr8WMuhqpQY9IWAEg7zsJgtCso4UpVXldwcalBws=
X-Google-Smtp-Source: AGHT+IEFf1zChqyachkyTTOAYkSI9YXjdpcMDxzi0sNYM5Ul8x+cUQ7yWc0KsO5yIrGfIOJFpGGTIQ==
X-Received: by 2002:a05:651c:1a0e:b0:2d0:892e:c4e4 with SMTP id
 by14-20020a05651c1a0e00b002d0892ec4e4mr6063882ljb.35.1707117949038; 
 Sun, 04 Feb 2024 23:25:49 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWborNO8B1gi3bnM1Mwg9KfTrOEKfi97NmYrBkJW1CtbJrhMS5VnJXPOyKeJIXkbFTBB7np1cT34Ca+izApQhch8/S3f/e8Kvf8dy1xFOSV3B9UmSkUdkQqUHKSPGLpw80n6nO4MVlMJKPOhlSlU9630/g4BBo4hVfxiwFx+2145PTqHacHx3ELCo4=
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 ev14-20020a056402540e00b0055c9280dc51sm3467322edb.14.2024.02.04.23.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 23:25:48 -0800 (PST)
Date: Mon, 5 Feb 2024 10:25:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: forbidden405@outlook.com
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Sean Anderson <sean.anderson@seco.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] usb: dwc3: handle return value of clk_get_rate()
 correctly
Message-ID: <137f996e-4426-4079-8b61-227f734e22de@moroto.mountain>
References: <20240203-hisi-dwc3-v1-0-448050c7b690@outlook.com>
 <20240203-hisi-dwc3-v1-1-448050c7b690@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203-hisi-dwc3-v1-1-448050c7b690@outlook.com>
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

On Sat, Feb 03, 2024 at 07:01:54AM +0800, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> clk_get_rate() return -ve on error, not 0. Fix it by replacing judging
> NULL with IS_ERR_VALUE().
  ^^^^

s/NULL/zero/.

I'd be surprised if clk_get_rate() *never* returns zero.  The Linux
kernel's clk_get_rate() function returns zero and not error codes, btw.

regards,
dan carpenter


