Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9771FC2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 14:35:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 915218857D;
	Wed,  3 Jul 2024 16:35:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yls1JbL+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6465A8881A; Wed,  3 Jul 2024 16:35:16 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FA988838E
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 16:35:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-726d9b3bcf8so4144001a12.0
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 07:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720017312; x=1720622112; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y6b8nyWG9tvF5G/NMRDHIWeCN+dNGpS9YNzPs6jkH4E=;
 b=yls1JbL+RJEAVcq+ZB0EaqC+sGcgfU+pIWIgTjA84KQF3JrIHjTZtyZSeQvYKPNidQ
 jv0CHyOWo1sjEyLiVJkPb8cDs3/Kk2nrKZYEk0s+SxAmBn/SDzjEWA0yjJgEy6KuLNnU
 IruRv2EBde+l/JaVRjAfKDAUkRB1sJxsbfWOff8R70ibqIU5JB/BbCh10YuHlXeXBDUf
 2lHLVl6pxfznJaPBsqt5gG4WDhKZSorgRR6+8JZHi5dTSYkXK03cZq/Ed8HD1xGXH7Ha
 RtxUThX9ldoOPx9v1uaqzp36U4VZ3msht6fiGSrN3dMz1F15NdGrCp0NGLODFBSa1+w3
 rn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720017312; x=1720622112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y6b8nyWG9tvF5G/NMRDHIWeCN+dNGpS9YNzPs6jkH4E=;
 b=corM/lefGk2/n7Pe7cG0O78NWu+lZq/ZOlbyBAHtcPEzpEeD9HQMycNWHAy/7D4lCk
 7CDgiSdQjh0fXU5IYWaskQBLrAq3bfEfukAyaGlZ4WWxX0UpSlmRYJyAQcGRR7p7Jwu8
 0R9lzdcchBwBWkRqMu3a0w37J+MEII2DRhdkPSj2D3HGBBRWjJd0qOp+IgMpfnBigXDy
 4bgxUTnJnmDoDd60w7JVixe8Ba0Kh1iyZLr3359vhf11QW9ewKUgX6Wjw5FFMwzUqO02
 RjU2brnfI2ysl0lfJRx2kWR8O1ERFhDuDiXnrsCukYMeOp3+ihczIr4Rzn9Tnoe3FuOt
 z5GA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy6fik8Dww6WagpxudhbiEDpR1DN5ZiDexaEqxeFDDSP7kNAwy1CLuopPb2R7XVw0OhMzVDtidmUZPZxi4NT8VPMsoVA==
X-Gm-Message-State: AOJu0YxhICICh3QogDawo/zh6Xjb/opM9xJ+el/m6Cs0WmgHXy6HTXkI
 NT3Swwqri1y4fYsAv+NWbTiD/dXeqqyOtLkUSUlSt+Oi0OMr4fensBz61VPGJ8x0ZrGq7AG61EZ
 nGWs5KAwYTGBO6yH3W7B8eCx448hBcgtz2gOUYQ==
X-Google-Smtp-Source: AGHT+IHzxDPdlYIkYknP4mrL+h28ZWR1BUEmq42xP5bjOrS56Sltqh25gy3CwQke0/KsLbX6vCGhIAmsgfFIyhKcN2Q=
X-Received: by 2002:a05:6a20:9144:b0:1bd:234f:ea6c with SMTP id
 adf61e73a8af0-1bef60e3f53mr13043146637.13.1720017312450; Wed, 03 Jul 2024
 07:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-3-raymond.mao@linaro.org>
 <20240702205658.GS38804@bill-the-cat>
In-Reply-To: <20240702205658.GS38804@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 3 Jul 2024 10:35:00 -0400
Message-ID: <CAEfUkUKqCaxaUh5yAQvr8KrJKwnHFLJiBJKiK7-iOxbdH3B4bw@mail.gmail.com>
Subject: Re: [PATCH v4 02/29] mbedtls: Add script to update MbedTLS subtree
To: Tom Rini <trini@konsulko.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Tom,

On Tue, 2 Jul 2024 at 16:57, Tom Rini <trini@konsulko.com> wrote:

> On Tue, Jul 02, 2024 at 11:22:38AM -0700, Raymond Mao wrote:
>
> > lib/mbedtls/update-mbedtls-subtree.sh is a wrapper of git subtree
> > commands.
> > Usage from U-Boot top directory, run:
> >
> > $ ./lib/mbedtls/update-mbedtls-subtree.sh pull <release-tag>
> > $ ./lib/mbedtls/update-mbedtls-subtree.sh pick <commit-id>
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - Initial patch.
> > Changes in v3
> > - None.
> > Changes in v4
> > - Minor fix and move the script into tools dir.
> >
> >  tools/update-mbedtls-subtree.sh | 47 +++++++++++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >  create mode 100755 tools/update-mbedtls-subtree.sh
>
> Given how amazingly close this is to dts/update-dts-subtree.sh and also
> the lwIP version, can you and Jerome please co-ordinate on a short
> series that you can then both depend on a pre-req that makes, I don't
> know, tools/update-git-subtree.sh and that script takes upstream URI and
> whatever else would be needed so that all 3 of our "update or
> cherry-pick from a git subtree" scripts call that and are more or less
> one line scripts themselves? Thanks.
>
> I agree. This is a good idea. I can make a prerequisite patch to merge
these
3 scripts.

Regards,
Raymond
