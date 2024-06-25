Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75A7C2BBCA
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 08:24:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31AB6884BF;
	Tue, 25 Jun 2024 10:24:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s6WevBJ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FC1F884C8; Tue, 25 Jun 2024 10:24:32 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B79C1884BA
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 10:24:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-717f17d7c63so2604746a12.0
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 01:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719303868; x=1719908668; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uM87vvLMwRYEQ34aKlzPDiUaCcVVfwLkFZ5r1uK8Oyc=;
 b=s6WevBJ73EIfwRJrF/4RDakLOtE9R7+X7r6HPinl/AKG5WpM2pN4tTRl3JLwuhQArH
 Z939Yss0eo3D+imQAD+NDntn3SVDLZp7Vf/ZoSFa5rZ+k4YoDDkK8Hsdy1528KUFjZbp
 /P8ECqBrxB2FsLGgD4RCaBj0Upm8TKxpNjYRDlpQoO1QDAYWWfSpIuUKWTqs+2DHXFWF
 Hbd0Uh5Q9dPbcPKb8oIGavrZoR48ePYanXMHMo2AwfIK8hIy2STsBFAqMpdLDqk4l1If
 hral99BFaFsAEXfs4+Kzki9IYJpw0LysPXKR5CvBadBrAC9+qLU36RGY6O1dzzDQL1zT
 VEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719303868; x=1719908668;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uM87vvLMwRYEQ34aKlzPDiUaCcVVfwLkFZ5r1uK8Oyc=;
 b=mRRUNcKGdaV5ylBzlw2OzkvPL9WkmOJI1Yz9koX87J0VQZR7oD3HxUw3NOzIsLZn6c
 /GvfrgOnm2aPhGHDHTVD4JP7z3p3a2dKDaN70x4uk61Pzg7Dq2lOZjyOgdC0tUnNpQCn
 tO+VFq0I517DEeFWQXLRwgAhC+26azIIjCcz8cJr4MFCtgDm6Y4y1CDLEuCFWZa1GLgm
 YWGIQSakdr2AUqU3VXTV7J7C2PxsxePSck5OUD/y7MGefNZ6TeeBPAyZCs1erEdvjbGH
 xwcBmbr7sv5YyM8kCRGw29o/OlMSgt0EqPVBH14xQpo3DBUey5O1Ph7VwnHdqGHhHaEE
 cdmg==
X-Gm-Message-State: AOJu0Yxogpog8VBnrVuV4zo7pZxTb3Pm5eL6xUzhLcOL3FITrUd0pHqi
 Qy1hCmgppeTz194/NA6z56myzU6WEatMRyfFL4ULGv9VKUQM4ToYQXfnvnzJ4swjoy3g6UXHIOc
 s0Bdzu5gsBkT5gqEuxA/+X5+fAf1rU9Nb0rUZToCzAWrmo3VT4tRq1w==
X-Google-Smtp-Source: AGHT+IGmQk4OdqbGtD0tNabXww9XZkni5hcBXSnivFTAud4MQbJPFra5p9Ei1e96rhYjECOe+1x+896Za/DWzSVaVNU=
X-Received: by 2002:a05:6a21:33a7:b0:1b7:175a:6756 with SMTP id
 adf61e73a8af0-1bcf7fc210amr7532250637.50.1719303868081; Tue, 25 Jun 2024
 01:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240619212759.3456158-1-trini@konsulko.com>
 <20240619212759.3456158-3-trini@konsulko.com>
In-Reply-To: <20240619212759.3456158-3-trini@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 25 Jun 2024 11:23:52 +0300
Message-ID: <CAC_iWjJ5t_fa1o6Ngx9jkOyApGmenEd3pYzihTsjwZatpVPnfQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] sh: Implement a default flush_dcache_all
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marex@denx.de>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
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

On Thu, 20 Jun 2024 at 00:28, Tom Rini <trini@konsulko.com> wrote:
>
> Implement a weak default version of flush_dcache_all which is based on
> the ARM default, which is to flush the entire range via
> flush_dcache_range(...).
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Marek Vasut <marex@denx.de>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>  arch/sh/cpu/sh4/cache.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/sh/cpu/sh4/cache.c b/arch/sh/cpu/sh4/cache.c
> index 8c1839935ca1..f0cb39d6a923 100644
> --- a/arch/sh/cpu/sh4/cache.c
> +++ b/arch/sh/cpu/sh4/cache.c
> @@ -65,6 +65,15 @@ void flush_dcache_range(unsigned long start, unsigned long end)
>         }
>  }
>
> +/*
> + * Default implementation:
> + * do a range flush for the entire range
> + */
> +void flush_dcache_all(void)
> +{
> +       flush_dcache_range(0, ~0);
> +}
> +
>  void invalidate_dcache_range(unsigned long start, unsigned long end)
>  {
>         u32 v;
> --
> 2.34.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
