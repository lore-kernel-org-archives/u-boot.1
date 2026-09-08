Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57192C79FA0
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 09:02:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E7CB1808C8;
	Tue,  8 Sep 2026 09:02:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f6gGDX3_cE0j; Tue,  8 Sep 2026 09:02:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 17F828089D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788858161;
	b=GQE1AsTTfjCJ0K7eeFmAXDyWuaFaauJ7kh8agAzgpVuhx/KV2kzFaPC6h9RIGE/3qnND
	 Bf4cpCwkjkHJBpGarWGqSQEz013i06l8WQt/aQENVaLNK2gg6bqvRpoodFvIcQoSCX7sz
	 ZBdfZXwelmkysQ6bi7F29yyaa5cMDpvWBr4MHfipPQvDurU8Re4FHd77TzTB8EzEGy15e
	 kRMjPudhMucddjcNbmQmuaBAhLFGysvQ+a+RsIh+K2zDgLncGBVHQiAcnNeWLLvRW9AMc
	 OyqatAKlVUpmzrm0qE0qN2q1ACnw1b/YLi0Db87wJOtvZZp4BKSQxhkbsC908EGZF4w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788858161;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SyCvMvagiPnUBNTAWNfNnld6kPUYr3tn6hbjGwb2nAU=;
	b=OWeyO9Z7w1WR8BYrI0nZq1tDlZgvyikfOcCyP/c88EM6wBSev0gbiJqNuNQ8dlK20k07
	 iJUiCaUY9Z+fNPxdileqZYlbj7+bqVgULZY2NrPbygN7k14ZBgxLQAfzxiinhFKDsEjba
	 g1ofpMP89ewwrmuekqqORowPdrO+WbkRABH377bykKl6ygBUnp6NC1Z5Cr5NldjpGLRxO
	 6XMG+PS3jQO/LNruvR0Tk5sqEb4KqQYNxdoDcKF/QkFIzIaFPAy3HMUx6HA8tsuYza4ZS
	 GpxQ0MT0NDV3EYKzfs2EBH1i5shaayvI5nxi5Qte70tacbsLUdraYeJlshI8yShJk4w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788858161;
	bh=SyCvMvagiPnUBNTAWNfNnld6kPUYr3tn6hbjGwb2nAU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kr82uWVlZGQINZVPFNftR06flwjBqk3Yuoy1uDcloOd02I4pRsRc9IM337DFHWEVd
	 kBVa6Ev67q6+lQDFTxYp2qNaEubMRXt8iXNF5Tj0WOPgcoKrCrMYcs3ERCtPFaYyl5
	 UtXhNDX8bi9P1grq2S8Muzd/y4hhiyMa5QniTyuKf5CYDr8TP/3f26V0MoOpkQo0/X
	 a0TRrEvlmtrWE2+Sjku+tQ9rgwHuq0V9n+xIEsang/v29E23O+qEx4u/YtFCcUbpJU
	 CJC28++YPYggHQsY+BGsjWnV2hZ5zQojZpyTIfT1qgdjct8U4eZ3mlCfti5Sbj2uR+
	 yS5hDkr7uo2Jg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17F828089D;
	Tue,  8 Sep 2026 09:02:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BEA2D5F
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 09:02:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 82C7740450
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 09:02:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uisNhb1Ebgyk for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 09:02:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6579E40445
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1133"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788858158;
 b=GjEmy7GElcYmqGKNBcDkE2jCbWw9ynmxnktydUbeiqnamGfOMu4uQ6KqV3K9icSg3/17
 A0NXZXwvU8ZBpWxfmebndtjnmjVfrVtubgRRw8VcAt9pBSNQLvviI8Tj4lJj/IY1hcBT7
 ZHIbx/06rneo0Ld+12EFq+DWWZVos+7YCKHsa7Uqnoqsy3lCT6Ethv+SJkSE2tbga2+LS
 PP/1+BDf2+UM58B8viUGe9dj3S/eqZGAqKWpWHqjpXslkIlBxUVZ14pC+fr+pSYwM9L3/
 rTAhzvNa9SQN9ganmcl5DY9pdx9BpgZdzALTZIlgUJvapZiB6Ac8TIGigTcvAY4zTQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788858158;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=SyCvMvagiPnUBNTAWNfNnld6kPUYr3tn6hbjGwb2nAU=;
 b=r0PaBDbrsOrKQ4Oc93TsI7odncI29j94KVFBcOWuNJg7owP7UIiAya9nbhEW2fBd74eb
 BlF1nQLTnPMZxMYb8ZOffDoForDOdn7XeaqzV6nEKKj287ots+qowMbsfBa8i3s3GWnHM
 xstuyqj0DCSxr3D4KkMKiBmbgJysDbqDfcUoZPfQho5izCqcp5oorXzgfhxqIWYKZWgqa
 4U7P2EvuHCO+HVYV3Z0JvKlizaVNIkMVRzX17z1pUoqZtGgE8gYEffe0pmBXrdfe9fLv3
 +FFe+I1f07FJ+/bqA4YJiH1idCsnxebPACxzZo5bk6VN/pymges5oUG6oWP7Ksom/UA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=atQqcKCr; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1133"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1133; helo=mail-yw1-x1133.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=atQqcKCr
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6579E40445
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 09:02:37 +0000 (UTC)
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-866e57f63a3so45454847b3.3
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 02:02:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788858157; cv=none;
 d=google.com; s=arc-20260327;
 b=R2+dlL/fP27icV4XTmznCQIo0iEKHU1BiaWQv/Q7dgCgtn8vQIg8obs038N1eLiazu
 f84gaG8pv62sW8ctKqwyKzrIyje7T6ruuY1O7f8mglU+JSWdNdiXipvkC88E+F2lbe27
 7ZhfORNfaAeZcgkLj3k9hr7+eeR3rNFMb2ydyjCflgiSoHMVEDEmN5iLbdM/d/XY+hSm
 xdQ8SejZg/1L02Kj0PkGq7BD5eWfNPrKiiT5x6ebhZRzcf5QnLP1nfK07GPzSdL3yUy6
 iGkkMKTgkgmUrvxuQYFwilkqcTT0/XrrYcKLWkHTMqyqAQ7nDHlStRerRo+tvPnVcsaF
 SrhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SyCvMvagiPnUBNTAWNfNnld6kPUYr3tn6hbjGwb2nAU=;
 fh=s0LFkSxwtok2iNWsx+o8qHRy4GhDJimX9WeuF6otGT4=;
 b=Vp68eOOLQVokTdmyMQyiUWeE798KQ4weT7dhjDkvxJl6moezn9svsVavA7gW0SFdDY
 FRzxWYwuIuyzqbYVOmxxwtZJTHIHEnoiiL6CM+kgwGvNlMEuvYhrM8yeGEsacoko3peA
 /xtOSuzKOBHQdjjr12PW8IGYkM73bACqUkQeHp4UCGPO+E84x+9fwoljjR0F0Djc6mH7
 zPuVoqxOmj6pWETZWDplYClwJCcOZUPkBvcGUgoUzWtr+QcgFY9TDWSJxi6LSDxNPQHE
 Uy/5UwlSvCkciR51u+pIWbBpTRMiH0KtvxjDoV8ksA1dknScR8e35bD7zYnjUEPSbm4B
 SYdA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788858157; x=1789462957;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SyCvMvagiPnUBNTAWNfNnld6kPUYr3tn6hbjGwb2nAU=;
 b=atQqcKCr1WKZDeZ2JNSrTriwGPTt/OwcHwVTI0Xv0SxTnFg2CEf4MtIHECwT3mx6lS
 +HFDUFgsQ8CWBHyzfrNfBnGx9//BXh+3ddIX65gEwyXoTv3LX1LcV5FNhTGbKgKprUCB
 /9TmP5U72IJ6n3oREtd0rPODclP3e5QNHqNUkWtHmOZRrJlAc0K7rk/9czkcW2cK+7Lq
 kCkWG5HA4sTqaWomFh8p2zJScHBBmXfUI1BV+noBzLoizNELUuz+cTDRJZ6nvQbEyTrv
 9cbYSISotwRIuNJxGlw87WrXG8qknTxyRprUlWSLhZBjmnuBgHIom6JIv3apZhMT6thz
 24tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788858157; x=1789462957;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SyCvMvagiPnUBNTAWNfNnld6kPUYr3tn6hbjGwb2nAU=;
 b=qzPuaEsFARu9jZxCAFWbqpuBirZrn+EZhjTvTSgC1gsNavtbx2mLfO/Qg2DqVZ0rVs
 A28X2tGzPYnmPee/eY69+jAoNM6pLXt3Q1G4JaPAb27JuawFLUXbv+ealKnqz6etryeY
 mwA9xDJeQULJhIdI7rFtYtIh7Ex6Jwd6XqlTjvQGiJh3mWaQ3MFwmjGbu/FlFM0TXJ9/
 4r747kNwozdrxDJ+f+i7yYFP9vTho7yMLbU9apZpA0gEecMuIyvMTHLlkYPU6AwhtoEd
 K5N91MrKrpy0jc0emHIPKjGMf4hWSyBEknTSIjXTUKJimOFn9fHfpBaqPEDi9dQbTaZ9
 aASQ==
X-Gm-Message-State: AFuF++mXNH6mZmS/9X26Jf851jkjO2wmyAV7QbFdv9EhGXu4mx2GiJd7
 zZlag/wT9yHBKbG1TjDwSXYNa5mGrW/wv1Zw23zelBun/k8j5aFcRL7qgYqIVhcvQxePjI6zdkY
 L+Y5N97qL4Tn3sjxUwrpEURxK26nrxstc/KUD6NJiTg==
X-Gm-Gg: AYBFou23hO2m/mUqknXZ0QaCaMsonEfReQoektxa8Fsr/hvisLwwUXMvRtZrj6wTbxP
 avkFx1fGOysoU+mEXkfqOCfP/HUf+Zd04rHW1fEIzPnrcxlDoXfOiIu7RP7Lg7SmOFxauaNZWrH
 ZaiyF3fdlCN/WmVCmh7pXp243bftN/vjkkBLlpunQ3cmnFvampeP/uUy8+NGrFXffXrXkFJrpBb
 936wGJ8syUcn0HIhVrt6RiogpsyQZRQH+cNOuYScR8VhT8vJArIU2HAxjDUFXoSKRTBvqODOJi+
 lBUsiUM74pHOU27Fyj0icQ0jnMR5uBpH1qW5Ra1dcchlxFVBsjWORo3jZn7rhPVlYgCGZps+1yq
 Db+LNmf9YIjxaOM+PExDIZjLlXnSG84HNjXY58cQ6M+qD2OU5NHgLeOQJAEVCoQFEAGu3+Q4TV8
 zKsdIuPsvwkhx+E8U+0dQQvpI3OLishxeicPBnwulqCj0m47UQDk04KRaFF6spamuF7pjF5YE+F
 2RUZQpEuTodW1V2E4PyAV0l1gwBtnnWLQsdnSqpy2YynKOFerx06a6RzCZcykVwQW1AmlKATLNX
 SdxBefyBvzLfkhOED4VVHHcN9EMxRn7I0rChaqgiZ7UDCtsTse5J/7CJ93Q9qZc1VNHijKnVtLe
 WQpJxnkHGp4e67uJMoX5y2l3WI/yZ3ybUBudij7MxEe8vC5fQRs8zrw==
X-Received: by 2002:a05:690c:d8a:b0:873:5ddf:d862 with SMTP id
 00721157ae682-8735ddfd9abmr73210387b3.45.1788858156543; Tue, 08 Sep 2026
 02:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260904131619.42621-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260904131619.42621-1-pengpeng@iscas.ac.cn>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 8 Sep 2026 12:01:59 +0300
X-Gm-Features: AcwNN1WjjPQZAcNmZe35NDEA5zP4TYyMXlkXjZFCZYSmbtErXP4WgzPNVdpPREs
Message-ID: <CAC_iWjJ0ZnzkdZh4z-BJgAi0p6m7K7HTh=jEZMCeFAmBQBPLnw@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: imply the FS_FAT Kconfig symbol
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>
Content-Type: multipart/alternative; boundary="000000000000f98504065af4fe59"
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

--000000000000f98504065af4fe59
Content-Type: text/plain; charset="UTF-8"

Hello Pengpeng

On Fri, 4 Sept 2026 at 16:16, Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:

> EFI_LOADER implies FAT, but FAT has no Kconfig definition. The filesystem
> capability is named FS_FAT, and FAT_WRITE and FAT_RENAME both depend on
> it.
>
> Imply FS_FAT so enabling EFI_LOADER can establish the intended FAT
> filesystem dependency instead of referencing an undefined symbol.
>

> Fixes: 93f6201af71d ("efi_loader: imply FAT, FAT_WRITE")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
>

The patch seems correct but lib/efi_selftest/Kconfig has exactly the same
problem.
Can you respin this fixing both?

Thanks
/Ilias

> ---
>  lib/efi_loader/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 4cb13ae7c8a..c4b0c2137b8 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -28,7 +28,7 @@ config EFI_LOADER
>         select OF_LIBFDT
>         imply PARTITION_UUIDS
>         select REGEX
> -       imply FAT
> +       imply FS_FAT
>         imply FAT_WRITE
>         imply FAT_RENAME
>         imply USB_KEYBOARD_FN_KEYS
> --
> 2.50.1 (Apple Git-155)
>
>

--000000000000f98504065af4fe59
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:arial,sans-serif">Hello Pengpeng</div></div><br><div class=3D"gmai=
l_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri=
, 4 Sept 2026 at 16:16, Pengpeng Hou &lt;<a href=3D"mailto:pengpeng@iscas.a=
c.cn">pengpeng@iscas.ac.cn</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">EFI_LOADER implies FAT, but FAT has no Kconfig de=
finition. The filesystem<br>
capability is named FS_FAT, and FAT_WRITE and FAT_RENAME both depend on<br>
it.<br>
<br>
Imply FS_FAT so enabling EFI_LOADER can establish the intended FAT<br>
filesystem dependency instead of referencing an undefined symbol.<br></bloc=
kquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
Fixes: 93f6201af71d (&quot;efi_loader: imply FAT, FAT_WRITE&quot;)<br>
Signed-off-by: Pengpeng Hou &lt;<a href=3D"mailto:pengpeng@iscas.ac.cn" tar=
get=3D"_blank">pengpeng@iscas.ac.cn</a>&gt;<br></blockquote><div><br></div>=
<div class=3D"gmail_default" style=3D"font-family:arial,sans-serif">The pat=
ch seems correct but=C2=A0lib/efi_selftest/Kconfig has exactly the same pro=
blem.</div><div class=3D"gmail_default" style=3D"font-family:arial,sans-ser=
if">Can you respin this fixing both?</div><div class=3D"gmail_default" styl=
e=3D"font-family:arial,sans-serif"><br></div><div class=3D"gmail_default" s=
tyle=3D"font-family:arial,sans-serif">Thanks</div><div class=3D"gmail_defau=
lt" style=3D"font-family:arial,sans-serif">/Ilias</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
---<br>
=C2=A0lib/efi_loader/Kconfig | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig<br>
index 4cb13ae7c8a..c4b0c2137b8 100644<br>
--- a/lib/efi_loader/Kconfig<br>
+++ b/lib/efi_loader/Kconfig<br>
@@ -28,7 +28,7 @@ config EFI_LOADER<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select OF_LIBFDT<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 imply PARTITION_UUIDS<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select REGEX<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0imply FAT<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0imply FS_FAT<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 imply FAT_WRITE<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 imply FAT_RENAME<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 imply USB_KEYBOARD_FN_KEYS<br>
-- <br>
2.50.1 (Apple Git-155)<br>
<br>
</blockquote></div></div>

--000000000000f98504065af4fe59--
