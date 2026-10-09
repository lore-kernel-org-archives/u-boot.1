Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02887CA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 18:14:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC795813F6;
	Fri,  9 Oct 2026 18:14:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YgLh70ttHjtQ; Fri,  9 Oct 2026 18:14:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 17485813A6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791569677;
	b=g/61mwD3dRTEDviDg+T7OHFz2gtlOPrN4G79VqZsfTbtnPWxtL9yunCmXph9Q0Hcgl5u
	 ahJWlpjnqIcRPq7WMpePGKOFidIzYsOLjUUxiLsnmhCVNYjIYzQHgmKGmjktEt9VKnkyA
	 v8p/amglvf585O9OSBEOgiiJ9lXYEkQXKd46o61jX/VaBfoVAecjwvAlHVXBmMoD8vlJ8
	 G7c2kXJZ2c1ge+RtFmXG2igQLLnh8ZzNBKSMprNGtVNP7l8KjAC9x0GUMtzgIv8KtO7sQ
	 rO5wTDw+SGulwqdz+w2yKFyx3b21jflE/oRaSoudQHJ6w1JCy9gcc94e3m1Yn300uyA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791569677;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Vcn4NPPUw7msa5Ka/ooKHnLzEl9KExl9mTsGAowXuHc=;
	b=LCLVNRuXk5f9EGzUZG5B55SoS5j26tOZywLvvhXDKgEYE/3Iwht/MfHvVsholOjmVCai
	 6L+VVAhc4tp7HCrW2eSkjHB2A/tDijZ2rRjoTRNv4TglDTXkQvqhhXIBUzi0f8MJ3/gvE
	 piiDoULYIPaGZktI1hdhOXldsHGj2mcAR4RvmCMGGySBX7zwsPu0eXmevULp7JsHj+pNt
	 A7cZ0xrHUWmTE2FC8xLidfp6VuJz6YauXPjGtNaagUSACkKMoPfO+/NYDASYnP+GTVg19
	 NT5hs2nO8kHW2dGpxvr81dAIB0QX2E4vXaqCliTuFCW4TV7aFfnd5i1BUGRRI8umL+Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791569677;
	bh=Vcn4NPPUw7msa5Ka/ooKHnLzEl9KExl9mTsGAowXuHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kynpWIfkXmHnvvYiNYpklrfFa9+Yg/4uEpLuZqOc3hwZr+2/1w3UGjtLYQgiGVWQk
	 198vjcvY83ZbNyrPS/2UmH2SwjyiR7wvnD0XwjtITk+FctJ02r+ADhVG9A5/rOyeyM
	 3qb1I4FtGMQ4M2lgZZDy9aRyvwDR44qnjJYo2I1Uh/U20HYB7pMulQz1XiwDPIFPk8
	 1pMmozvLKHXGz0fFAXPNhpVZ5oyGmFNMLE7aP9TNUM+r/ZouaGY8gPw1cmwxiVR1HL
	 KToXCqDUYvqj5ejURIkUwz/vBEbvSODImMIToKPN40u47MrFrzzLK/rH/Hzk82jtZ9
	 qZdBSjrx5m6Bw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17485813A6;
	Fri,  9 Oct 2026 18:14:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BD637317
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:14:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A2795607B2
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:14:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KN2VGTNC-nAR for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 16:14:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DEA7B6069C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791562472;
 b=S/0KYzaPgTk9Xk3R4fbJt0BVGmyUl+gErY3ySf4TUn5zlN53KD+QYZ6XCWRIP5iCyvn3
 MKV0VvohNFwW0wtqag7Lr0PdJN4MINmbuw6rN6DRWoXzQ798xvyAD+uJAZwIyEXzpCr3c
 vxeTMpiIBzeSoFiJpkuM7w++gLqHcyQDeKJ9nB/ho5K9CdHr6BPu3F1Pc1NEvNy4dyUAI
 Q3BJbN7dYNphrdjn5M2od6XBQU6R+9fgRxn9TZPrp6T+kutFi71fSgx5jN0XgwoFeG2S4
 /vYNyWBNBGkC/AWOrlW44dcHEBiatUo/REKhGuVvXwNbfWaSw+SbY4gRywS0Z9IFzfQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791562472;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=Vcn4NPPUw7msa5Ka/ooKHnLzEl9KExl9mTsGAowXuHc=;
 b=QZ1AjTzeG+9cP7eQecrnf6JygY5qr7LoPzAWJ2nw+Km7q8atPh7xe/c6XfAvfI2gNOZL
 sWFQbA29lSdoejmJd+O4dzC7hxsy/Af6tFg9VWKp3qNq1u7uaSgIp7K233ng8RLqdFqDF
 l9559Ok0i6jdMZPlYUfRgsOZjD5SZ68a5O5yoiU6QGIx4bn6wJCPyDHfS3f7olPIh6W3M
 pwk4N04+ME2Nx4UmGX2qtx89DMC58BTwIwhkOzbaICNnfHSESXgZA/aOdtZUtho7GgR5F
 yZX3XDFuJ4iPOlXyGzGpqUlWj+4XeRfFfHeqzUyI3Pu7yIX9VTeXjYhyjE4AXpwQwig==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jrX21fSp; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com;
 envelope-from=vinicius.eduardo.pedrosa@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jrX21fSp
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DEA7B6069C
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:14:31 +0000 (UTC)
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-88b5f43cb8aso2351330b3a.3
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 09:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791562471; x=1792167271;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Vcn4NPPUw7msa5Ka/ooKHnLzEl9KExl9mTsGAowXuHc=;
 b=jrX21fSpCHIeXFcQWWHKAMt5hbr4gSkg2jaebTQMUkw7X8eUUiFfOcyixnFUL5Kznu
 RuCT2BctlGhEh4QfynpAukFk9M2+K/F3TAjZmFqjL6ry1aU8x3VLYE4PoPJnespc9XFO
 5V0BTdVWi4ETotsNdH806lOC+Lu+RuZsGWsxaumtRfdWPQSbDWI0FA/l0bWsJHs57e4w
 CE6yXSXsN2N9KRCxmatqWji5CCPIRxdympmgVwLXvx6D823kpx/tb92hjOl3yfEQSNn9
 SSFR0DtPxJMk17tYDzdoXAGD5KBlkZk5RCvS6ndoHAOeeugOMJSTeCzO9C214MrLpeBs
 DX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791562471; x=1792167271;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vcn4NPPUw7msa5Ka/ooKHnLzEl9KExl9mTsGAowXuHc=;
 b=hFgW0eUmpCTihTC8yNITvwTc98QYsquUNU/kEnRthEHEm1yA3Zo27LMC5WJ5k/iiRf
 ejpG/RPrKw6W7cIB4zDRDckC1E3jDjQjFa41Bwnme5onIWftPB9f5j4tNC+GOSdjAX+u
 NBCHsXMLP/JR8XaRwBomm+bCXS0ITO+Z2/Fx7YIwaU/2BBUddWXpuXwlmM26Euz7kGhR
 FXz6KN9ClWC+KHJSL724ukHNyohsrTzC54neZJmC+Htr8Kc83Tq/UbNLNqqCw+xTbOoV
 j0E4CkDyUaIDuT1F7HDKT+shblkXBQRV/thX+w5QaZKu2WAzZvxfxuwF8II/hU9Hbfzu
 GkPA==
X-Gm-Message-State: AFuF++m+fyTGtvxkDhiYXFJDD9vevJ7sM6N0D7M8+meuM2cCBiS0gwRm
 gNY6CfNYOAJcYnzMA4iDqxP8VItj2foVNUBtHBB9Y0YCrlnXgWUzK1O5
X-Gm-Gg: AYBFou1WqmdoSBpEnLkZpY1gsmK1dcpOM0V8JL6zFHoqgGciCXeUntJdDAer/zm8F0W
 mSFSDiKmEmjvHB3dVKI0fOudN75arxe68A/GhlxTIpbtaj6919gsCTv1KkarYcFjxDYvDRYOWgu
 orG5YTPODnTPueZT2y6U2B1FcQzw6JqSmkc5wU7FyH+kVzqEmjWwS/JZvdaZpcmS/wkcgFjrLJh
 mLAoNFXXIaE7uACviy/g266Z1+Swh2ohGDLCtWZwF2utoWerGxZp1fbNk5Yq/jmLMK3DGoJwsk7
 CSYbW/G9Dq79PYKAIWK+HCbQtu0pwL28GxO8ypI9DubhF6su2fS9OatXd9n08xPM6/NTyFD67+G
 LpBLhsMRTPdseHzkBeeM62VJWuO3APOUlItuB+jDPXhGc8bYjMoB9cxQYoH6irMNyGHAKB3tofO
 wBdpXNhVi3dBDj4q4oY6gM1TU6Tf5S1ChfQnf5RKIm4u6bUERKDnIPxxgAJzdHuo7XeIBrWO2mi
 hzcbiM7SPpneix48FPMTNd9ndpwxAjb4bI+lHaq+n9BtQgoffUvjBInkZIgHMDbMeJnwiJHzmDb
 8jsdJkQ=
X-Received: by 2002:a05:6a20:9c15:b0:3e0:bbb8:bbdb with SMTP id
 adf61e73a8af0-3e16be9eb80mr2032774637.47.1791562470854; 
 Fri, 09 Oct 2026 09:14:30 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.237.181])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c43ae1d3sm1355530b3a.48.2026.10.09.09.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 09:14:30 -0700 (PDT)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>,
	Yixun Lan <dlan@gentoo.org>
Cc: u-boot@lists.u-boot-project.org, linux-sunxi@lists.linux.dev,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v3 0/9] sunxi: Add support for A733 SoC
Date: Fri,  9 Oct 2026 13:14:09 -0300
Message-ID: <20261009161409.256732-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3f57db40-a604-4800-b15f-2d159a3a5ca7@arm.com>
References: <20260113-01-a733-soc-support-v3-0-f19dcd098f60@gentoo.org>
 <20261009120356.194364-1-vinicius.eduardo.pedrosa@gmail.com>
 <3f57db40-a604-4800-b15f-2d159a3a5ca7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 09 Oct 2026 18:14:35 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Andre,

Sorry about the wording. I kept repeating it to give context to people
who might be reading the thread for the first time, but I see how it
came across. I'm building on Yixun's work and yours, and I should have
made that clearer.

> Honest question, is it really *you*, or is it some LLM?

Yes, it's really me. I've been working with embedded systems for many
years, but I'm new to public contributions, as you've probably noticed.
I do use AI to help me research tools, handle some tedious tasks, and
improve my English when writing emails. English isn't my native
language, and I sometimes rely on it too much for the wording. But the
hardware work is real, and I take responsibility for what I send.

> Why not? Probing DRAM is somewhat the idea of that routine, and it
> should restore the previous values it overwrote? So have you tried
> running that?

I haven't. I was concerned about overlapping BL31, but I should have
looked more carefully at how the routine works before ruling it out.
I'll check the probe range and try it.

Understood that the FEL workaround is temporary, so I'll drop the size
header idea. If it's useful, I can test your U-Boot proper series on the
A7Z when you post it.

Thanks for your time and guidance.

Vinicius
