Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B90EE49A0
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 22:11:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4285871E3;
	Tue, 22 Aug 2023 00:11:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CunUw0s1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B144D86898; Tue, 22 Aug 2023 00:11:10 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26AA1871DC
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 00:11:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5236b2b4cdbso4817742a12.3
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 15:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692655868; x=1693260668;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7+8ZUoSX6nsrIK41+NDKAKpFOr4st+nPNRXQcbUnabI=;
 b=CunUw0s1CmGiJlMp4PhXSBIBNaB5R+BipAHJTYjUiFj9P28VPxKRUj5V60uFdduoEH
 dltTFZ13uX2KCWPkHpitiIvrKWPFN3c6Dlw/GcgbVXVE+tt62o3/DD79iKKBNmFWx+IM
 tgrFRD/56pdo72G7GTEeKtVbakDiQUN69/0SM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692655868; x=1693260668;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7+8ZUoSX6nsrIK41+NDKAKpFOr4st+nPNRXQcbUnabI=;
 b=DXhZItffBJr86PeFoE17DTx7+derjfSChZFI1s/MBA5tgpuFQDCP+F0QKttP/slTbr
 CpuT8GpKj9mai5BFz2HmUSaMkSojol7LKvsXXqfmwOR4Eq33UToc6KflOH9B1cjMeG3z
 n5NaEV/qzyW2p/boEJ+DHE3iP9+hRQp6gRUUVX+gsYvmICRvOwWQIoFElMrQC+F/3tc2
 v1ThpwQH806akNd2AfTr+1h0KmQERngEkDCfIQHGYwE5vaWklhjlVlOETRM/jROcaPu8
 M9U0esd0BeLUWzm4u2XRss7Lkg/Dm20XTUqYojflzR3CEfKBC5rBktOllLakvSRdYHr2
 caig==
X-Gm-Message-State: AOJu0Yxdn9iNWLwgdHwC3EUd/C/hNm1L3cfvyyS2oPxIBbHlXWWkSdcR
 fW5epbbwlkcXolAcF/f5SGjfqKnK/fFRus/vzG890g==
X-Google-Smtp-Source: AGHT+IGRX/ryvTmal9B+wM7fpp/ILn+P6dOZU6iyMQSso6Yh4EhltCL2p4/NigS0VjlM7t/7yjLKPsb3703QjNL2W2U=
X-Received: by 2002:aa7:de12:0:b0:525:65f7:60 with SMTP id
 h18-20020aa7de12000000b0052565f70060mr5968364edv.29.1692655867520; 
 Mon, 21 Aug 2023 15:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230821181339.4135800-1-alpernebiyasak@gmail.com>
 <20230821181339.4135800-5-alpernebiyasak@gmail.com>
In-Reply-To: <20230821181339.4135800-5-alpernebiyasak@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Aug 2023 16:10:55 -0600
Message-ID: <CAPnjgZ3224WoRVy42-ys-Pk8Jy-LkqbzuXGC79DBChObQk0kOQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] sandbox: video: Move sandbox video sync to a driver
 operation
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Anatolij Gustschin <agust@denx.de>
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

On Mon, 21 Aug 2023 at 12:13, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>
> The sandbox SDL video sync is handled in the uclass because there has
> been a sync rate limiter and a way to bypass that. Previous patches
> move the rate limit code into SDL-specific files, and provide a generic
> way to defer and force video syncs.
>
> Sandbox code shouldn't be in the uclasses if possible. Move the
> remaining sandbox sync call into the driver ops. Now that sandbox video
> sync attempts can defer without resetting video damage, force a video
> sync before checking that video syncs reset video damage.
>
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> ---
>
>  drivers/video/sandbox_sdl.c  | 16 ++++++++++++++++
>  drivers/video/video-uclass.c | 14 --------------
>  test/dm/video.c              |  2 +-
>  3 files changed, 17 insertions(+), 15 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
