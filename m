Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63627D462A7
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 14:13:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6130891DB;
	Wed, 13 Nov 2024 15:13:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z7Go3BfF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C810489170; Wed, 13 Nov 2024 15:13:34 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB99B88EE0
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 15:13:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-462d8b29c14so43294921cf.1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 06:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731507211; x=1732112011; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R6Cn2XkEXHstEOKpbae04wVdlkWwUkK/bUFGChE1024=;
 b=Z7Go3BfFnipTXR+8kY+mLb+6WxQqAGLGiFbLgCq54ug+XBq+txYCqXgn6pAJG7mY1h
 RJF1X+Bq6N3fM2F74BH82KXDHi/1R/5l13x5FtQI7cKKUjH84sbncVNIw/8TM0aXORRZ
 5Qi0VgOLFm8JDGClF+sSbxUszcMyZOxhD57GI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731507211; x=1732112011;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R6Cn2XkEXHstEOKpbae04wVdlkWwUkK/bUFGChE1024=;
 b=wTRXCSDmEBaJRlIM8ubSNzBg51XmhdeSrOPTaXoz6MFEqv6CfGvcb1mutKnEWGmp0w
 l3AFjbR44E1M+MUJpYreIatdTGNr+ij5GFAabz4iNLG3Y6jLEgShR/gPUU6AdfY31BaH
 X8x3xhiAR5cGJdQqXB+375YCiycBv51aViiTk57+WPlHJRhsfRxjdVyQKmp6xgHRvIlf
 jS4On93ZdNtNP4/MLMPI/TjuulpheXc4nLXnuo5aE65doItK1joJuioBH17bTT5sb2sL
 jfjVd34oqa9R08WcA38pdxYf2rphggRg+aLH/ioEJNhQSv/KWTHTl2LBAlVeuqF4KPeP
 4Mpg==
X-Gm-Message-State: AOJu0YwLVRw33RSdmPbxW0CWvlW3f+rXctsFHqdGK3dzQLHfOf/27UwX
 bxHVWHpIFlHgZPsjGnCu7G1NvyXjOlaOKLNIrFJxdqfSeyTiu0GHDGc6g2XfU8w=
X-Google-Smtp-Source: AGHT+IE18Xgf+8g39LOkG0MZKGVMh58ARrRkgxxLG6f1yr9NLBysc2497x55+XxTVPmN4YFQuA7mpQ==
X-Received: by 2002:a05:6214:398c:b0:6cc:41cf:a361 with SMTP id
 6a1803df08f44-6d39e1f1dafmr309133856d6.42.1731507211663; 
 Wed, 13 Nov 2024 06:13:31 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d396208436sm84270956d6.56.2024.11.13.06.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 06:13:30 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241105110849.41348-1-jerome.forissier@linaro.org>
References: <20241105110849.41348-1-jerome.forissier@linaro.org>
Subject: Re: [PATCH] nwt: wget: drop Content-Length processing
Message-Id: <173150720974.1102530.8774122827336951940.b4-ty@konsulko.com>
Date: Wed, 13 Nov 2024 08:13:29 -0600
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

On Tue, 05 Nov 2024 12:08:49 +0100, Jerome Forissier wrote:

> We don't do anything with Content-Length except a debug print, and the
> strict_strtoul() call is incorrect (it always returns -EINVAL and leaves
> content_length to zero due to the presence of trailing characters after
> the decimal valuoe of Content-Length). So let's just drop this piece of
> code.
> 
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


