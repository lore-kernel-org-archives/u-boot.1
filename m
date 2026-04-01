Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CAB10F6FD9
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 15:30:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27A7C83CE3;
	Wed,  1 Apr 2026 17:30:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AyH66+A/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D0B984010; Wed,  1 Apr 2026 17:30:27 +0200 (CEST)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58D0380517
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 17:30:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6500040f172so9556341d50.1
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 08:30:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775057423; cv=none;
 d=google.com; s=arc-20240605;
 b=Umbls2qW2T7JcnDDmMSn3j5G8yIUGK1VYoKaTYF2szKDt/ABRUfPjCgTdvJIxVOU2z
 Iqw7XFHCEMhvRCPupajHBrJuhaC6AHRZL2uvj4FdCNoW/eS7EWozjoP6qsLAIqE/OZfk
 qYDq6T6DDZwsYK70AUsQTu7AcVRqAr6mqC80rMmU5q7cCAOYKYX7F+MXp6+qb5s3mbCj
 D6Wu7E03qZ0hinG2sBmWY+450Dpg0Ypv+z8PUBJDFgxVmIuo8KtifkFYeAsu4i57kpkM
 1lulLkY3dwiGqk+cBWvHHiTZDuS2V3Dw9VTcoVrwJCj7NXDhp2903OUAR9UnYswpGNvf
 UFCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MsIsAr8iCRMevWdT4a8fc3wMb6WpQMaZkyBI5XrgjDg=;
 fh=bar44rv0ewcnqusGuVKYWYMz14NnRUByunWCG2uEJzU=;
 b=Ct8ummu2PSm6sTBTvRFZBOuIZ/t0q3Vn3zVTiC+2blobF5k++Sm8CQ0qcNOJKtI0yD
 0lQiExebij/Oi2YyZu9565jnoXJmE6qWJXtZZ/jk3k0CLS/K/B9Wk1V1END4BPucUIuU
 G4o4gtwFSR7IlZUBxmjws0iIToQIyj2hQHJZYcARxanBTqF3ZB4+4c+CZPyQbXI24wMK
 TelpFU6/MQmVFocz+5ZRPkZmRBsCoyuxBmZ5m+cEwIWQ6DMGhaVIYD/F+QrG4bY21AET
 cyeiCt9eiqEnCW1WKSQLSPsjALZAheKBHfji9fzoalOvvLnodq+ugKZWT4BN9FSHaXHF
 PFrw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775057423; x=1775662223; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MsIsAr8iCRMevWdT4a8fc3wMb6WpQMaZkyBI5XrgjDg=;
 b=AyH66+A/WkzKLFmdzaPVFmhLkP1TDRbzYGenhUMw1+Iq95ZLr+TuSoWfnRUuxMmLWM
 X1KiMOMOMJooE28y/FtRUFL7IMvOE2fFrM4xGt+wfjIn7HDjeXYYZlVmN5p9/iuKw0ca
 FGyJI6Zkviz41uLbw4f6CfyUhDv1tPqje98ZOCyDjPVS+rlLO9PM2SKY+TVOp9qEcdVs
 OH9TS1av4r/zcQO7Vn25h6s5mfTg1ByB13+aBH/3UokRmb58ATtJyExNzKRiucBAkYco
 nwdJTPpCVenOuUmzj9Ll5YOGIBxfye5YsCPMeoL5puFrPedvEa7KpLOtpEF6dMCOi048
 4fiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775057423; x=1775662223;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MsIsAr8iCRMevWdT4a8fc3wMb6WpQMaZkyBI5XrgjDg=;
 b=kkkIzwLDXCKb36WNu1mWCzt3r1UiQTZM7/cxH7rkoj+8E5Oh5ahY75Ss0umFEv+LSa
 xjD1GZO9oVWSp7Lpc+TItV6hwlUPKnuMwGhZTysLiYQYYmI3o15wKaLdMVGXxcvLMBSx
 FkqpNj5uQJKNXlt65LCKY2bGE71jBCcSmxyABjW4tTscOXg2vNoZp2KOoyaor6mmlAj3
 SAQrryDt4ZfIvN++2JWGcb4TeYQIKjTddUJBQU1IxrcSuYJNlxfAq5rVBEWr0HxbjXCN
 AKqurK8TtsUlJ3KoAHux9iWJZAJjW+rQQumXlcpFqWBbNRswFVQAEP30k3rk86VeXB66
 6IaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4bAKzOZGgm7Q9ZlsUNmk4oJeYXsVXbiTrRlBlKGxUO1G/rpICeDjOkhKSiaYSNFnHjKmWCqM=@lists.denx.de
X-Gm-Message-State: AOJu0YyBIJfeBCITXfDtK+IUw3/c/YBKWWGSK42vxzyHWNoOFBLckYxY
 odsFb0LOd7eNZp2tpiMiffKm6PaROEpETdSp5fKuV0N/8ybbrmw4X+3axLLsQzfxbmWqQXh3+2T
 FBdbyip8tbiIm5Ax2ogid3NIq6QXdWTSWZ9TGpyvZmqlJu/QTVr6r
X-Gm-Gg: ATEYQzyJmtsVDwt58kiWEi6hhOk9piIdUsHTcyqnm9urlAwWFrRuqrLc1MJXaVrikqe
 1vOoAa37FsbkyIBNJHzPkdZs08Rj3YVBQxO5MUnp+KoHcswzpYN8t8CJpgud3ElICo6wfmSI0b3
 76O3des+1iS67op/8AAJuANPhdy9BuUntX4KAgZKLBh8jLQG8rNFeyefTydSRgsXsXaEH9Kvtz/
 FLiOv2hEw9mauSgQfV2p1NkqJ3hO50igkbVE7ZOtqoz+5kGShtICNXPwKZNh9qOfGG71Zr+/d2G
 CIcTmp3yr/tJf+nVRy3Unt2+RriPwQI9W2NSg8zf3PkKW3cx7YJRFIduiFLSn8vwT6AL0KxEWQn
 nkcWhzCsW0HwxlVfYpX+dRv2RJPWTmUpSBoCgs9hujzdUfNyK88lRTc3PVE8p1evQUSvY0r9WJL
 hRk6mGCXQv4pjl2VWSzp/bU1UjXsTqweFyRISHlnNAVCTsLnNI3V+aS45HUagVPwEMjtrw7frix
 F7cUDAcmjmf8nEpf6trnHQnEMTkRx/CbCGIIE683936SNwL9OMlBcmDtId35JN3wYiWkX7BmVPN
 TfnfvGg+NPLhFoqKzWXGTLVzrZ5zVIGU7saI3lXVLxM=
X-Received: by 2002:a05:690e:190d:b0:650:379f:3580 with SMTP id
 956f58d0204a3-650379f38a8mr1699467d50.21.1775057422787; Wed, 01 Apr 2026
 08:30:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
 <20260331080117.2370092-4-ilias.apalodimas@linaro.org>
 <cbe4109d-7290-4104-8142-076b3296e13a@mailbox.org>
 <CAC_iWjLOJs-C4W=9EcY2DEVRde8Qqmmqb3b3h4+hGn1r9Pab+g@mail.gmail.com>
 <e8bcf2e6-9962-4c82-b38d-f803a69028d6@mailbox.org>
In-Reply-To: <e8bcf2e6-9962-4c82-b38d-f803a69028d6@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 1 Apr 2026 18:29:46 +0300
X-Gm-Features: AQROBzAntnQ-gygw-hVfyPJg05uf8ak6RNTHB_mGnvYBIHhJ_foQmHuWubhcqoY
Message-ID: <CAC_iWj+MyguKpRz7kcfSyaASiUUH2P=YW84zu5xy13pCh6zV+Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] fdtdec: Introduce fdtdec_setup_ram_size() to
 determine the memory size
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: trini@konsulko.com, u-boot@lists.denx.de
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

Hi Marek,

On Wed, 1 Apr 2026 at 18:24, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 4/1/26 8:43 AM, Ilias Apalodimas wrote:
>
> >>> +++ b/include/fdtdec.h
> >>> @@ -965,6 +965,21 @@ int fdtdec_setup_mem_ram_top(void);
> >>>     * invalid
> >>>     */
> >>>    int fdtdec_setup_memory_banksize(void);
> >>> +/**
> >>> + * fdtdec_setup_ram_size() - decode and setup setup gd->ram_size to the sum of
> >>> + *                        all banks
> >>> + *
> >>> + * Decode the /memory 'reg' property to determine the memory available in all
> >>> + * banks and populate the global data ram_size with it.
> >>> + *
> >>> + * This function should be called from a boards board_get_usable_ram_top().
> >>
> >> Is the board_get_usable_ram_top() really the right place to call this ?
> >> It feels like it is being conflated with ram_top here too.
> >
> > I don't think so. You are effectively calculating the top address you
> > should relocate to. You should also calculate the difference in
> > ramsize. Those two should not be separated actions
> The address where you relocate to is gd->relocaddr, which is ram_top
> minus all the reserved areas, see common/board_f.c setup_dest_addr().
>
> This setup_dest_addr() function does manipulate with gd->ram_size , but
> only to handle CONFIG_SYS_MEM_TOP_HIDE , which may not be the right
> place for it, I think it would be better to have a separate initcall for
> the ram_size calculation, which precedes setup_dest_addr().

Yes, but when you calculate the reloc address and use a bigger
ram_top, the right thing to do is adjust the size as well

>
> With that, the function description can claim that each function must be
> called before that specific initcall, fdtdec_setup_mem_ram_top() before
> setup_dest_addr() and fdtdec_setup_ram_size() before
> setup_whatever_is_the_new_initcall_name().

I really don't mind. I just don't see the point of making things so
granular. Unless I am wrong and someone thinks it makes sense to
change ram_top without taking into account the size.

Thanks
/Ilias
