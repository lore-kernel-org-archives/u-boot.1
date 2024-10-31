Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A637AD767F4
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 18:03:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2046892F4;
	Thu, 31 Oct 2024 19:02:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aooONDJQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A18D6892CD; Thu, 31 Oct 2024 19:02:52 +0100 (CET)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7501D892F2
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 19:02:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7ee386ce3dfso1271659a12.1
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 11:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730397767; x=1731002567; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LTZn3fDdlPcieTjqWa6cKJN1rAsr2PmyHai0iy1vGE0=;
 b=aooONDJQY+q5kDyIR0Nod8FhLYdqpze37q83cZoe25HSliyGpfAgJeO/LAye+W2FjD
 8B0vI0mDPzTn9SXlv1vRMdxnqgz5QiYUgIw5Gac3BelBwoQO9VHHJbVYoxJkdx0zxbRx
 E1UveEnGAOGn2Fbkm6gLT1E86d3GSXYaMHvr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397767; x=1731002567;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LTZn3fDdlPcieTjqWa6cKJN1rAsr2PmyHai0iy1vGE0=;
 b=TwXT3/vFIwAkuOaFPmv0vv6AguGvIuMFieco1/oT1//gtzry4gzw34u5sZjd2dugn2
 axPJHzpD64vWhdtJ7bdbslVnO8SbdFKZ+nKgBEt75XJBWIR+VNQwcb3MWLeDwmtmuAFC
 h7cddeaABMce7NQNpU6rUsdDSYKCns/hTuVYVoK0eyx9yAsBNLA61E1JTicmWuqXrXny
 YsBjYTocdbh0jegKPWBGxSamcnJB0r9qHQb+jl0eGU6K0B+bJI+dfc+4U0mRHuWKMOcd
 i28Jm2eiCkmRxVhFpw633laGp7taqv25rwLP2zzOjTIaH0QKHKDai3w4Pt5zahh9A7dt
 EWKw==
X-Gm-Message-State: AOJu0YwgWHs4QQWQS9P5NVSENd7Yrc9jqpUq/2isa3FtUQNm0LKA5noP
 4ArGXAk3t/6sa9FpuNMZ+zbJvzZZmuzX9iG7kJmLjrdyzF3aSO/Sp202nFIu0ETRtxD2YG8a9GI
 ExDJ3Dei5JgfS1Eku6Wovo0/8RL+Pzs9IfG/b23IIgd6ZFfFj3A==
X-Google-Smtp-Source: AGHT+IEuqwo0SY31v7y5TmfNeR7hezA/JSdHwnCiZT3J/wRHxdp3Ds05LEtit8DOGvmE7zVTbv+MrYC8MPYtv6Wx5ks=
X-Received: by 2002:a17:90b:1b44:b0:2e0:7e80:2011 with SMTP id
 98e67ed59e1d1-2e94c21cd58mr1320431a91.16.1730397766862; Thu, 31 Oct 2024
 11:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <20241010015145.1977999-1-sjg@chromium.org>
 <20241010015145.1977999-9-sjg@chromium.org>
 <20241029235329.GH2558755@bill-the-cat>
In-Reply-To: <20241029235329.GH2558755@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Oct 2024 19:02:26 +0100
Message-ID: <CAFLszTiJgBgLzz6=XfWuUv0Sep6py-fQqBi8UA51-f63nTgrBQ@mail.gmail.com>
Subject: Re: [PATCH v7 08/11] test: Try to shut down the lab console gracefully
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

On Wed, 30 Oct 2024 at 00:53, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Oct 09, 2024 at 07:51:42PM -0600, Simon Glass wrote:
>
> > Send the Labgrid quit characters to ask it to exit gracefully. This
> > typically allows it to power off the board being used. Only do this when
> > labgrid is being used (detected with an env var).
> >
> > If that doesn't work, try the less graceful approach.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> I forget why we need this, and not just have the release hook power off
> the board, as part of releasing it.

It allows labgrid to exit gracefully, rather than being killed. This
allows it to do the 'off' part of strategy (which may power it off)
and release the device. Without this, every board disconnect leaves
the board in a bad state, requiring separate steps to recover the
board, then power it off.

For your lab, this won't be used, since USE_LABGRID is not set.

Regards,
SImon
