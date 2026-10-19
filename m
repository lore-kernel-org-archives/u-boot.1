Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF4FCCF2DE
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:22:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA91B80FBC;
	Mon, 19 Oct 2026 13:22:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ebkNuavzFR_n; Mon, 19 Oct 2026 13:22:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1CCA080FB2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416137;
	b=J+N8llkCEJYOh5AC/O9cevXW0IdJOhgooeHabJKAuOBdoDwylrnuORRCtbp3CbZSEquW
	 dsbOStQC15nqyb05DwtpDgKMMTpezgzLi+A7EVcfMK4jRtrkoVAy966aqDekeEydSQdLY
	 hpjlNgOx8ljvHblexHSFCtF1DXJpx6O3arBLFgoOXmqjoC0R24XUscp1vbJbCGRUnosBl
	 OY2LTyqtVhbQQXheZMjdLyD5Ri+AkP56MZTuQrOWr9J7AAc4Npo1LnOrX9iMjWQU0ksCu
	 dl/04bHsdrYQ2uy8zhLfBPIQ3N34cebdOiXUcf8kZjgN2Zpv7YkpcqPxLuj8btt8M2Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792416137;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YXFlVb5pVmafD7vfV2lJoQX364k7EyA5sxZbjOx80wQ=;
	b=isqZZWmEGsdWdKdICagv2n9/kj/cDbR6XMxMTAwwCom4UOOS7lz+PS0wL557EBdVacUE
	 YWG2vW3jhEB8EvIAFKkYLMFKOADjEYD77IU/1Q/VZ4aR0E+Oq720iK6cGe7AshBAmurwn
	 E41SWcMDl9sxGRo8NvgjB5vy5VvGnWle/F3mR+SohQ5lkg4mAYnH0Gg3muW+mBDRSQG+9
	 hYLtTjFoSWFp49Xr4QTmZB5kDVQCZluILehp29Ash5K99Mh5LP5mylZKOTOB7qdmkr1L6
	 xD5R+HFuuqXN9Bjdw0CoXLIq4F5uO1ePSIUtjF7n0t6gp0uVyvVP8Z4zA6Id6w87Qwg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=TU7seFqT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792416137;
	bh=YXFlVb5pVmafD7vfV2lJoQX364k7EyA5sxZbjOx80wQ=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GvIBcB7nhFz0X+f619bDG3GECrhBY7s8+l+MQPVKxSFUGDOIjv6bdTvYjEpAYpGXn
	 GVXE/FPdCzv/o+ivPRMCRJQD1UwyDzacnHhnL8MmPm7fFUTGUcfaZp/R5P6FIOWqBw
	 5UeB9gEgEfEFoj71/ygoi8BkKhhN3asxK8gbwccEOkjl+NdPL/RWZQEPMT1hDPVqi7
	 6pr2ZVsElqCcMQJ9uq2C0zyW4oIf9n+iKb9vefRC41hlCDaLZ45J25p1DWf/EfaWxb
	 /tiszlLAhvn+a9DIR95s9OSf3El6FjONpiA7wqk04ulY6xaKUZIoiHgHf7NfZyn0V6
	 qWZOe4bNlOYEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1CCA080FB2;
	Mon, 19 Oct 2026 13:22:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1539A1AB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:22:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 03A1180FB2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:22:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zzrOs9mpAQA9 for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:22:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 08B8D80FA2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416134;
 b=IqW7mjfelD2gpLfugkw9l6CIhalgi5lTsAbeVcLmB8JrraelL5snS+g9Sy1W38aYQMhp
 +EwmA0c8f3VQd91gotix/xN1bacmmkzsiqLfKz69cdHbSx9vaoYKkeH3nBLUSNJe4ogon
 1sL04wN2kcrgRv+iVlicrTL4R7ckog6xE+xzSUiiRz2Yv8YMErZtcu04Ygc97UziZIKoC
 5mmygBf6Lq/gATN1xhAFdxz2jdDUKTFyoDH9NoyZdNLvwfMDgpvEXhPhv8sh08WZpW6e+
 4eZGrdiKb+m77wQrwdSrB5vB9IJIkfPBaSnUbekUlJ8GFe+ZTjod4eUHXWuDDyquUNw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792416134;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=YXFlVb5pVmafD7vfV2lJoQX364k7EyA5sxZbjOx80wQ=;
 b=kIKfeFpB4x7B+vktqO8hm+4guSguaJPWUBhq15JaalZNQRRdk3FxJAGX4qSiRy5cylvJ
 WqA4Trn5nskx7tZy5pso58zJS0LsB9jZ74N4CIc2pNTJy+zbWxoTMPcbE4l/VMcwt0W+Z
 0c9zsWZhaUEtWS7cCXfjyjkPEk2eXJp+ip1MUmQ6UlaQUb8umqvg11Sd4IdMdvqanV20D
 s11hVOIFUy8+i4gJTEjbj3+FxAuqF9kaDjJWTzmAaKNUFJKRd5lXpPCA6LxeIxJooOWTR
 BLYng1LRS0YryxaVM9U3FzbdQQDw38WX7z2H8GdsBh0QV5pZ4B9y4xv/BODoqNSfQ/g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=TU7seFqT; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::535"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=TU7seFqT
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 08B8D80FA2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:22:13 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6af8620a7d2so2441070a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:22:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792416132; cv=none;
 d=google.com; s=arc-20260327;
 b=GeQxQR5z2BGh7p9Rt4v8zN5jLZzu5ZTpmLvsQ7yK63m26+q3yRIPYQMD2TBglrsJgy
 3MtcV5tv3AfPZzKdktPDtMdQB4X2osNHzs8xYBMjYKZT/RlWID0vyiXt+barO3K0UN/m
 EoA1MdCQBNeqhO8yVLhQAt15M9xEwNzgZEYWCzCztmnpX/jdXR41xdnQCC5PtL/2rCig
 KaTsyJ+e/eG0IzVeQZf9Sqc8Ysjdi//sf23L1VPRJdUqcreQsvFZHepmTUViAJjKqHON
 fxCcuqjsO6GdWABX//em6ytPd4UlXnUzy5CCZbuEzBgMSxpf0X6uOzVGqNvcdZhMvrz0
 wwlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=YXFlVb5pVmafD7vfV2lJoQX364k7EyA5sxZbjOx80wQ=;
 fh=HNvyiKdY0EVXoOVdehOWSAhbBVIvKB9921VBkS5FvAg=;
 b=KQLwGw6BVHLXO77RDlzjNothiXflGuFsAv6s5gfvEqFmlkIqO4BwE3W00N+wJSx6gs
 3Rmx8GmHTKOlyAvchnFThyMR5Ua2WUHcL/EQSkxWdLHslZAKcNoRM9isat8JTtaj7nn5
 BMdNzb6YeOitOBkHTx+pOTeoIr/d/WLZqEDx5z443oQxYnA3uKYmUym81uxpPq9X0/Gp
 YhXFVavc3CQNMuXeIWEj17uwklaMewj5izgmHGn7sDeVOLiWYXmeDsUy+ANKsQ6njZ4e
 Lng2v7z8Cq/6ZSBeiTD190ghjgSWvQBzHxUc3r4QB9eJmftgG0YlRpyxueToVzF98tDH
 1Afg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792416132; x=1793020932;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YXFlVb5pVmafD7vfV2lJoQX364k7EyA5sxZbjOx80wQ=;
 b=TU7seFqTkfARIKt/eEWF0oWuWUi7iplFqxVUjsr1lACEUuKackjq+d9+93sIycsI6H
 h4tQQBYBMPM7oerOupg0zj9gZADLGPFJmdwev4syJAagOum1NLhedsPIjAwnEk4y4c2G
 T8so5ebbn8GNlh6Ykz8lsoajbRxgo0nv6hYYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792416132; x=1793020932;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YXFlVb5pVmafD7vfV2lJoQX364k7EyA5sxZbjOx80wQ=;
 b=1MYsWTUfZcocVZHlq69ALltLXqN+ifWyC/jbJv/u/ZjB1Di4ZHkoxtGMRg7fuASvUy
 o8nmsOD1Mbu7+rxVjyx4SUYYjnR5zwgJchfZ8GITpLWh5Fxg1yBoKSsaQfKztG6jzZKt
 afKTNNtRXkJ1BZS2swa8SRTSloslDJnUUxAa4TnqPMFFMdWQ7LDjQuQ3DSDF4AfgKrjU
 dHAciWNWhDe5FhfR2VViPpPjxwx2j7NbVEhxgUgnsonTzcVsHfyOQvDDbT4ZDpwCsONR
 U6uyknDHt31Dp0Upe/CPBu5tJbcT/tcIrZkRRsTUSUrvmcqJKRi8lkC1LtWy0M0UyqiH
 vQLA==
X-Gm-Message-State: AFq9FYJaZVTuzq0yGXrQHykVKfjMqPGlJ7+Tw6mYvBdQxDd54Bv5ieM+
 H1su+fyWDchS0Hm+QPj3+TKtMD+cwFC9mPiMR7QOwwEuFN0t+snlDAyr74qYtzMoAk2oT0MRLLR
 XLnCbnLViGoJR+TUAoBQeAM9TwKRDfNzOdD3AkBRQAIAdZIVcMukt8g==
X-Gm-Gg: AYBFou3uKMaC9iX+nx5c0et/WZdnYRvpXJWmGWqN5Pe9jGBs1YaD0HO5cRNWZr2WCAk
 9xm5bDJtciYSVfZI4ughCp+VTGvw50+vdf2Z5x8fTDhQBOANE0KjSNgio6whoAiXzZcy0g5VQfp
 8G+nvM3hClCN5XYsKVJgiz1MOX1CB3sQdMxiTfrpCCuqcQ4xHnlj+TGeJ+4jkAng6fLoWx/XOLi
 2XT2UROev3T8nBDcF4lsi1ssknBqDkNymUr5pEnEySXblsUKd6801dIVugJ0KnHxSjDUQIVj0hw
 ZOd3pshatpmSaOfBh1kVrrV76XBqr+mkPIMo8ldvbsO5Cexpq3qpmw==
X-Received: by 2002:a05:6402:44c4:b0:6ac:bd84:2b84 with SMTP id
 4fb4d7f45d1cf-6b3a81984e0mr3578706a12.34.1792416131302; Mon, 19 Oct 2026
 06:22:11 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 06:22:08 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 05:10:45 -0700
MIME-Version: 1.0
In-Reply-To: <20261017-aspeed_vbios_fixes-v3-2-961124989594@oss.tenstorrent.com>
References: <20261017-aspeed_vbios_fixes-v3-0-961124989594@oss.tenstorrent.com>
 <20261017-aspeed_vbios_fixes-v3-2-961124989594@oss.tenstorrent.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 06:22:08 -0700
X-Gm-Features: AclHuK9gIuv46T9YGg5uTT3wX_9IyNfxfZH18Pv1W7reehd8gVO-JAor_n1itMo
Message-ID: <CAFLszTiEcWxkNW9V1=bu5B3tmNHY8nZQRd7fmd02EP_1ekLkGw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] bios_emulator: Don't free a caller's BIOS image
To: asrinivasan@oss.tenstorrent.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-10-18T04:23:45, Anirudh Srinivasan
<asrinivasan@oss.tenstorrent.com> wrote:
> bios_emulator: Don't free a caller's BIOS image
>
> biosemu_run() can be called with a BIOS image supplied by the caller
> (dm_pci_run_vga_bios() calls it with an image, so bios_rom is not NULL)
> or with no image so that it makes its own copy from the card's ROM
> (BootVideoCardBIOS() calls it with no image, so bios_rom is NULL).
>
> In the first case, the image is either at PCI_VGA_RAM_IMAGE_START
> (0xc0000) on x86, or a buffer owned by the caller. In the second case,
> the image is a buffer malloc()ed by PCI_postController() (which
> biosemu_run() calls). The clean up path in biosemu_run() should only
> free up the image in this case.
>
> However, the clean up path frees the image in both cases, which can
> result in the freeing up a buffer owned by the caller in the first case
> (dm_pci_run_vga_bios()). This can cause a double free when the caller
> tries freeing up the buffer again. There is a currently a check to
> prevent this from happen on x86 (vga_info->BIOSImage != 0xc0000), but
> nothing stops this on other architectures.
>
> Update the clean up path to only free the image when biosemu_run() made
> the copy itself (i.e. bios_rom is NULL). The existing checks for
> vga_info->BIOSImage not being NULL or 0xc0000 can then be dropped, as
> this copy is never at 0xc0000 and free(NULL) is safe.
>
> Fixes: 4c59f9532796 ("bios_emulator: Add vesa support and allow ROMs to be passed in as data")
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
>
>  drivers/bios_emulator/atibios.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
