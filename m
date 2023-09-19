Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B37CCD54AA
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 08:27:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9878886AA4;
	Tue, 19 Sep 2023 10:27:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FeywP+Go";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23C9686ACA; Tue, 19 Sep 2023 10:27:06 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52AEB86A49
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 10:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5315b70c50dso1569525a12.2
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 01:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695112024; x=1695716824; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oD5gr2aq/1FhIatHgRym0dyYA0nkSf1m++k2HvnMy8Y=;
 b=FeywP+GoRR+USmyuuakHlV1k9hFX/51+ZiEl/WYAJJyrXGOZnXhZ/n5vssC1Ejkl8G
 evpHBFtEZGfjbLWNNI18RkKn4S8Zqblyeg5fnvAeBRWwK2D1EtrdCw++EbeubPZGGVG7
 ViiRqLpsGNuexcnk4Qjy/nBjMldvGo7x375w6MCjZf+9J88J/YApFAHFp+aabyNrqypN
 uNjiSeLw9QVqKA1G6D6q+oOFnt2vdmgRNku3EIU86+3rCMBTQIp0JmneR8qdvMRiQi7l
 jUTLJBB1jUgn3TsZH004sLxzevqQSZFOqxMsMsFMjnEYMwhafggTZYiJlwPNL/TYA+jH
 TM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695112024; x=1695716824;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oD5gr2aq/1FhIatHgRym0dyYA0nkSf1m++k2HvnMy8Y=;
 b=coPqujD/QK8vddz5VnZvfAf2datrStCHa8/wDR6XaCRqFpdPj4KPn/fJrOyg9dPClB
 Nk5XoDIPz99iYHUJKR1lM60wpTQivStDsysyZpq3qjCQ+FKrW09tany4qN2yVCMEMyOR
 5t008LqwiLblWDnXPAMV9OchHsIjsYMP7+KIKnnRrjjKdCRncjNTJu3Cmz91pGt9ROJq
 wmx2+0r+PeruJDelOX1I35Rig/Hs/Mhg2Xwwi57UgZ+eI2J39cGluGvB0MRSaxSA2apF
 0Ek5z5nPoVMmzaAnZe/nYUj365uc97ZZiRUlsZWpivqngejRO4llMA4CBfszbmMwGiyt
 c7VQ==
X-Gm-Message-State: AOJu0YymwHPLbBkmmTKH9EdHEd6bK2z7z9llDujcFBivvbtk0xDrTqNq
 wFn/tvH95Gb258nuJyyeebmhoFFlXE9hJKtZ8vU=
X-Google-Smtp-Source: AGHT+IFMCIqhrkZz2pom9uS4Kkcaj9WM0Va1ir/cnu5R/8rV1HEFAdTrH0NIeyc6eW4fE518RQbTvTXNMvkV8fLx5WU=
X-Received: by 2002:aa7:d74b:0:b0:522:3ef1:b1d with SMTP id
 a11-20020aa7d74b000000b005223ef10b1dmr7634306eds.6.1695112023698; Tue, 19 Sep
 2023 01:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230907155825.48056-1-sjg@chromium.org>
 <20230907155825.48056-2-sjg@chromium.org>
In-Reply-To: <20230907155825.48056-2-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 19 Sep 2023 16:26:52 +0800
Message-ID: <CAEUhbmXF5fEMA90SFWsLuORLmUSq4jFGVamFAUfzjMUpmMGd6w@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] dm: core: Allow marking driver model as dead
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>, 
 Pavel Herrmann <morpheus.ibis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Sep 7, 2023 at 11:58=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> On x86 devices we use CAR (Cache-As-RAM) to hold the malloc() region in
> SPL, since SDRAM is not set up yet. This means that driver model stores
> its tables in this region.
>
> When preparing to jump from SPL to U-Boot proper, we must disable CAR, so
> that the CPU can uses the caches normally. This means that driver model
> tables become inaccessible. From there until we jump to U-Boot proper, we
> must avoid using driver model.
>
> This is only a problem on boards which operate this way, for example
> chromebook_link64
>
> Add a flag to indicate that driver model is dead and should not be used.
> It can be used in SPL to avoid hanging the machine.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v2:
> - Add new patch to allow marking driver model as dead
>
>  common/spl/spl.c                  | 2 +-
>  include/asm-generic/global_data.h | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
