Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70E9CCF2DE
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:16:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE95080F23;
	Mon, 19 Oct 2026 13:16:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vtk0ptoJwZYq; Mon, 19 Oct 2026 13:16:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D4E3280F80
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792415808;
	b=loo/FbfiWb7Lfbd/HzCa20SZXBFJ+5GbuKqymUZfUUw/nkokDfgdUbkppa0s7afKD4k+
	 CJnN8gwHhvXDeyoe+t+u8YAzHyGOt5sDMKFsSNNeleJ/N+lcI61cJBACh8nzAswf6IoxW
	 R5EmUUqDCPdTAt9L5pJqRTzinZ0PJfqogrQwkkhJEdlF/GRlM1L94vS3d8tpJDFFD19N/
	 HZ7jYV8o7VXNTMTffm2TW+EFcg5q99JmlGQ6XQUdK9cxrpnCA7L7ctDw9bEDHG0PQqVke
	 QowZF+VVYirI39XElNq+80dJl+3qAa3OO6728GJxm+514wWgrrnWY3am+s6TLdCExGg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792415808;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=wpeF2qugLuiKH/6g7j+7VQnGygWE4mSqTJhtStxwFAI=;
	b=OKxYqgwKATy6PGrnR4/NIRF9iqUJuQnhGdjNjjDwVLYRrBVe/EEGvznVJ9Ap3RC+/QKb
	 F8VNSB9bR7FdcYnm+aEHwWE1/RqcNhDMjyzPnD/zkUW07SIs0e4RkWog/iKiI5Tl2olsb
	 IZA1GhwyKiD0Z+cwJ8VPk3WjmK/l2y5QjJTeUqfJgtq4OAkIgGiwlHT7JBErH9Izhes2f
	 yFItMe/5P3k04zc+TELHpKUjnPgCAK5prHyawQswpvvcpT2bGt57PL1B0UK/LkdczgYfH
	 jGyvAmBM3D7YOfhRsfbdEG82NGCRAblsbxd0TLpcbqb8DvLeakICsWSDQW0vl1jtQFA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792415808;
	bh=wpeF2qugLuiKH/6g7j+7VQnGygWE4mSqTJhtStxwFAI=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vt9ZKwn00j8EHRB0HRqw+X4SpP1MHZzH7Ds+gCHM7yvlrwhcZiOPLp9TlIZ/shAFy
	 XC6DdEVXo5OTLI636WJ6eHhSjXW+DHKreixmPB9eVDFVCvM45ouYq6VyaMAtoEeyOx
	 nIUiFI2g5sV9XM/l0OgJXnr31TSC+RROr+BdXA2NYGqgRXkKRiCZF/Ed+GGSqXJmTH
	 SNXtwm9ho/aoUiQcq3lypB6VfgnQqSDsygMX+w/rFpyrpi34/YRe5oNHINi6rVKsaP
	 LJO5NtYCCCouhf4SD0wOgRFKsUhdOB1NtEUREfS1zFme7+eouI3Lmi/pNRig+2V2/d
	 zbcreG3BLx3tQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D4E3280F80;
	Mon, 19 Oct 2026 13:16:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A6ACDDCF
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:16:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8BE8040655
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:16:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T3z5JGITz7kL for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:16:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8491140656
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792415805;
 b=mC6CXiLw66k1PVudMZcWmwVo7rn4uBHP+WAf8uofZyytavDkLLd/KGlJSA1knivfJvMV
 Z/QOTCEXda5RmY+OIsr1r1OAg6hQ7UXMPQwhRw7wbPYsSspRkIT7WHtBUuaaS5BIjnO0k
 EX0WSzKxdhw/qea6tTNWO0WKL7TUlzpnoPCFyY6if0/xeioVLMcACfclN8oCNIeL9T6gH
 mQmD1PvvSECrpKkrlD3EFLRcNjHEihmseIqmg+Pbk7fdy/U+cIXLh2kbj+OJ+QB4tD7ib
 2jloo8DuAbgkSlzOAugxW1Mm6oQ/K6XzLxskGpLH2qscr1L97rZS9LnI/o62hVuQZPQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792415805;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=wpeF2qugLuiKH/6g7j+7VQnGygWE4mSqTJhtStxwFAI=;
 b=VQ16kJhAA/CugsFqiiJgUWsEMane8vINx1+UiN7ykKdzN8ytlvWVdQLIpk5mkCJ9rVZ/
 lCcxFJGzPYpVi6w+hgjo7AZBYXcbv0vvOHsIeqqyLiUb2RCNiB01utHVcEoaV/kpDLVUL
 7iT5O04GYRPJYXzlIQHtBt+hYTCqnRuKqX1afn/mXAne70QmMb7On2gwuU36oQh5Wfq7h
 lSouAMxiIOVWsA8oyK9VsKu33Jhb+RN20OLfOTWee1+6KvwD3Qw5mdE+v7dUhHMOobVEQ
 jwEW4sFTAG0GoMGwVOcmvr3JhwIVdsMscs+/1XKt5s6S4JCoJysoa7OtRnBLndhjx4Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=dTIgl6tw; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=dTIgl6tw
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8491140656
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:16:45 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6aa8d04fcddso3319923a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:16:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792415803; cv=none;
 d=google.com; s=arc-20260327;
 b=Uxj0bQU+FlWrp4Z7uMYNlLrAaq046iaTbhnlIpQPchY06pPYGBULJQHNjd1inKILYl
 fB/LWQtEDvUj68kyMrVEAxP4PEJYi+Q3j2/UtjszG6PiAK4q52YlDja3bDiWFgssKnr1
 fVDeXySZ7wfqqwFTVlGnZUEvPNdXJvZETgZYFUTbOdTw2+sjndvuBV1LRV4dVYMsuGFa
 rAInYKX9B9rW6EXC4I5tlUgrf6SAJCkKwksWNAA3dFF8con/3zQSEeCf/HJJIPEGCkjX
 arswNZuK8R/DYmsdLlmyy65oNKgHpqMQ/TtoLYJ9YO5uljb66l2MoQTEdtdatiLPM1bV
 WLpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=wpeF2qugLuiKH/6g7j+7VQnGygWE4mSqTJhtStxwFAI=;
 fh=CxHeubgwLaXQQIV2wNwbaFFWQ2iRgRa8gy/lsTqt5S8=;
 b=P07/yn0ocTvEmH3NFozmaBxEm/pWNBQ0XUA8PyNnXm9HtV7tSTMbzxMAzrdCtWIJEJ
 pMT8jA1B/pwWDofhud7YNFgW4xnPJj/o/pwxU0YHyDcig5mFu7lJNqth/r86lIRONstO
 ri3wAcum/B936eCk99HKk79FcMgDrYEe4tTzFUxMBNDMy/0/ZeV3FZio4tgZ3zyYqksZ
 VgMYiCGwDlVsGPTyse7QsQRA/1fdZBvCL1j9efJmx7K0eLMyaTkEYeucKYSE9hm4Ckk4
 0OMrmy3havtj03gIA24y7+kFI3t0w60o82gem7MHbT2A8z0TpXr8sfKInPZfF9N2tfVy
 guJQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792415803; x=1793020603;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wpeF2qugLuiKH/6g7j+7VQnGygWE4mSqTJhtStxwFAI=;
 b=dTIgl6twiZnGt+aXUcZi9mx1KoV0t5pKMBCGlVGk1aoOta9ag82lfhKjmjIytvQxWk
 OPlEQFgrZ89hQR6CWE2Aa99G9WDhsQCBqsL1ew8wjC5Bw2IM5HsWM7n/qV8D2Mw7UcQ3
 rFkE6igCcprfVfjGGwTpy/rH480Apa2ZrXryM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415803; x=1793020603;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wpeF2qugLuiKH/6g7j+7VQnGygWE4mSqTJhtStxwFAI=;
 b=HKfFCyi75MwJ0UKZ1Msw6HP/fnZmrNLIiQLGq+cANU307gpnsEgsAX67JvY9C0UKK/
 9LhnLoxCWq5jEV+Ltj8DbDlv9EqIHh/UEaBCpqPO3g2XjZiE87Qp8OAfnvtw0quoD9LK
 D21O+cDdoRDiVE9uVgkU7wDmniTk9xNy9gmmWn0Qpe7jqP0TY2BuW2cuTer6q2wqHsRo
 Gd9KPb/0PuQxi6io5HCdWMLJO2I2q9S9RM5aM2PCBAN5ttKrycq8anXLEON5uRYgDwxp
 LUlOJ1A0ISkahFaSI75dOlAYA9d3VGSxyfjfiGeepYKF7bgjX6IdTrECNuTdjJSuxgXp
 0psQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5KIfbs5a/8q/+Jc4pPBv8UH4dD6ne35TMC1h9EVtPaKiHx+nEYYxkI4xIVxIdY/nVuOjCxYc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKFoLbLaOr18NuMY9jwbS4/ph3jCmFivtG/7TQjW8MF3MMPNmIU
 hMZ2RhPONNSn62qoHYU6PfCy0NLyS0ndWBRzMhu39RMLLyAEfFd0qWhpGVL9X8U4idDWtQmo99H
 xkjrrDSkbhlyoAzYhl1GYY1sKSRFhUtsfedzX7JHK
X-Gm-Gg: AYBFou1p9b8+NII0pI5mDn/4hS//NNMxutAKohmxoynY6jSfgUIWXSHbU3rkHGcy6vB
 53Rdw1n7poXWPxBjK8WdGYQBHlwfTuSqDRqc+jOVNxn1YRy0WMzZbTrhdfDa20IodxpxY8fca3p
 B/HcvlFcSYeBT7krwyk4hKnFLX8Mopu9H0/oPbCUs1Dj12m1G1KVkdqxUHAmk9F6a/XXpX5HgMB
 /XZzNx3tRrKXTYAZf97pG8MYB/p1kkCz5wizKkYMNYlM+W4ZiQqkFu19vu3Yc0iuEQiHpTFtRYh
 WYuV5FyGHY4wIc/OWLcL8AxOo4YOjbnbXU35x8aYu/cwNY60HibKbg==
X-Received: by 2002:a05:6402:13c4:b0:6aa:8d3b:a70 with SMTP id
 4fb4d7f45d1cf-6b3a81b2160mr4153320a12.15.1792415803082; Mon, 19 Oct 2026
 06:16:43 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 06:16:40 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 06:16:33 -0700
MIME-Version: 1.0
In-Reply-To: <20261016065500.137544-18-me@ziyao.cc>
References: <20261016065500.137544-1-me@ziyao.cc>
 <20261016065500.137544-18-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 06:16:40 -0700
X-Gm-Features: AclHuK-hkUMdp41iYX3iqhKLF4h_dJeAR706jsuURc2RBcL2LyngTLFmaAs0Cx8
Message-ID: <CAFLszTgaSeQVDZWryR_dfPzwxqO1Q7YQ7y=3PRZ2-sTp0m2sFg@mail.gmail.com>
Subject: Re: [PATCH v5 17/20] efi: LoongArch: Implement everything
To: me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
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

Hi Jiaxun,

On 2026-10-16T06:54:41, Yao Zi <me@ziyao.cc> wrote:
> efi: LoongArch: Implement everything
>
> Implement crt, relocator, linker scripts, and handling of PE relocation
> IMAGE_REL_BASED_LOONGARCH64_MARK_LA. Wire things up in Makefiles and
> Kconfig. The relocator originates gnu-efi project.

Grammar nit: "The relocator originates from the gnu-efi project".

>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
>
>  arch/loongarch/config.mk                 |   4 +
>  arch/loongarch/lib/Makefile              |  12 ++
>  arch/loongarch/lib/crt0_loongarch_efi.S  | 182 +++++++++++++++++++++++++++++++
>  arch/loongarch/lib/elf_loongarch_efi.lds |  76 +++++++++++++
>  arch/loongarch/lib/reloc_loongarch_efi.c | 102 +++++++++++++++++
>  lib/efi_loader/Kconfig                   |   2 +-
>  lib/efi_loader/efi_helper.c              |   3 +
>  lib/efi_loader/efi_image_loader.c        |  31 ++++++
>  8 files changed, 411 insertions(+), 1 deletion(-)

> diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
> @@ -12,3 +12,15 @@ ifeq ($(CONFIG_$(SPL_)SYSRESET),)
> +extra-$(CONFIG_CMD_BOOTEFI_HELLO_COMPILE) += $(EFI_CRT0) $(EFI_RELOC)
> +extra-$(CONFIG_CMD_BOOTEFI_SELFTEST) += $(EFI_CRT0) $(EFI_RELOC)
> +extra-$(CONFIG_EFI) += $(EFI_CRT0) $(EFI_RELOC)

CMD_BOOTEFI_HELLO_COMPILE and CMD_BOOTEFI_SELFTEST both select
EFI_LOADER (which selects EFI), so the first two lines look redundant
with the third. The arm and riscv Makefiles rely on CFLAGS alone - was
any of this needed to make the build work?

> diff --git a/arch/loongarch/lib/crt0_loongarch_efi.S b/arch/loongarch/lib/crt0_loongarch_efi.S
> @@ -0,0 +1,182 @@
> +	la.local	a0, ImageBase	/* a0: ImageBase */
> +	la.local	a1, _DYNAMIC	/* a1: DynamicSection */
> +	bl 	  	_relocate

Odd mix of spaces and tabs after 'bl' - please make it a single tab.

> diff --git a/arch/loongarch/lib/reloc_loongarch_efi.c b/arch/loongarch/lib/reloc_loongarch_efi.c
> @@ -0,0 +1,102 @@
> +	return EFI_SUCCESS;
> +}
> +

Trailing blank line at EOF - please drop it.

> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
> @@ -230,6 +232,35 @@ static efi_status_t efi_loader_relocate(const IMAGE_BASE_RELOCATION *rel,
> +				/*
> +				 * Apply an offset to a 64-bit immedate loaded
> +				 * by four instructions, lu12i.w, ori, lu32i.d,
> +				 * and lu52i.d.
> +				 */

Typo: 'immedate' should be 'immediate'.

> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
> @@ -165,6 +166,7 @@ static efi_status_t efi_loader_relocate(const IMAGE_BASE_RELOCATION *rel,
> +			__maybe_unused uint64_t tmp;

The __maybe_unused is only there because 'tmp' is used in exactly one
case under an #if. It would read more naturally as a plain local
declared inside the IMAGE_REL_BASED_LOONGARCH64_MARK_LA case block,
which would also drop the attribute.

In any case:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
