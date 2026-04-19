Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F546EA7188
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 03:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0879841C8;
	Sun, 19 Apr 2026 05:53:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VQxobi1+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9B4C841C8; Sun, 19 Apr 2026 05:53:05 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66533842D7
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 05:53:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ba5b107eaa2so142269266b.3
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 20:53:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776570781; cv=none;
 d=google.com; s=arc-20240605;
 b=JbaI66PfplMfuBt/CVbFXPKAIJCln+wkYvx+KPWIIiyJ4knAowXLppLFCtnOQLB0jj
 6IUwwHwyw6rGfuBzWIxJXhTUKNsEwh6aJ8eJoewjFsY0Y37TD1ysGKqeeTWwS1K182I2
 pXoDmimV8pkupClRkn/oXnsj4VUWevNO5cqJ4U837WHlY06jB9CK1mVIq1145vdFiwAV
 Yd4zQoi17dHylQpGgSyyt1OciYnjCa4kdJlyxgSku5woxBzOJAEawA/8sb/eYoIe6xbX
 NL/0/WC5Z9GTAs7tawIZA0C9y1lQ3EWJk8V4KDNmZ9l0rUHuSgClCgxxyoE6mPb53dhM
 SSOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=inDHz6RKTjn4hP91kADnD4LDqJmia/+d2ZCLFfzpC+4=;
 fh=8qqSTyQIpkt5WAsMOHXcPAz0jBelXMsHRmTnpKOZMkA=;
 b=CPARThnHam457XHsnD47Q/tMtnojK1afJxbSfh4Q4dg5ukGhtR6tfx+M6+0JbrOyDF
 UUNG1KdbzCShN0ZTLPXAoe2hvN7oPDtOxGwtnF4BWgi++OUgHIvlD8rPqjHDE9C7p6yL
 YPpFgsOAfJL75EtITmXbSBJ3DbtYL5gJfjCBSijwV3si+AcZbjx/BWvtlhCuxV2u8Nxo
 woA57paaTMa/Y8REYa3FlqRgaMHmM8Vr09sOnfNPrBAPHwi6r4JGZ5dcQEnQQLxor78q
 eHNZRoAbwaESNtLp8kkwQuy3L16fvY0UaZO4Q4rdyJmWgU/FhTO8K7SlH6IIFDPrBAqt
 4ddg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776570781; x=1777175581; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=inDHz6RKTjn4hP91kADnD4LDqJmia/+d2ZCLFfzpC+4=;
 b=VQxobi1++LUFylmT4MZnDUhnXdqK2dF5dLDj4el9exRrNYhB3P/bfiKcx9FT7mxPgo
 3lAkhkWbWpiyQ3/Td4BPYt0H3ZP+JNpv/rq+zOEvnvqk1kRCR5w0QrCaCOM7SzDzAmLE
 yFvVJs2PEONcXKE2FX3f1FLUAByNvugxAynGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776570781; x=1777175581;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=inDHz6RKTjn4hP91kADnD4LDqJmia/+d2ZCLFfzpC+4=;
 b=QoJhq/GsezEMrXtdTCCNE7AR3XNBWRA93cxDVaQ/+JjGT5hYoqZeG1o4c5rXkvRsuQ
 e3DnxaXUNbRRMnXSFEjjfh0DBL4pKhKT5UTbRPDZCBN7PqGYMnDpYx11ADLQhuGuofg2
 ZYSaB4dplPFLjRxbusd5BIVK2QtAKPsoqMUA5Ws9N0Y2hqY0scv7ojZsAAbV63/4Wy36
 myitgx+BzFNrf3T8BGNFLyEFm3JFO3kRBYJUO+ISdym3KiMcOUnSCOuGe4nIHIRXPYWN
 2fLzWBJO6sHvFHvdp7f579RJUbp2on5K1HDc3B5VAM1xjMsvc7O4NkQgMbWLMd3O9XxI
 NuIw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8FUGHksezs6UG0uFldohASs3+vC2dF/WLXsmvp6toR1mBB2CsinG7hj3aeO22x9buK7sDQGis=@lists.denx.de
X-Gm-Message-State: AOJu0YzUxZbJuKKLJEqhrcFHyBRSACg7vRpFRer+ilvyd2HkyflqKY40
 WPPGQUgEEroFcuVR1RkcUhOUwumODmXOJawy9g82j0jLN9dPmvbU7TIFKETjLAwUCWKEvfS7khO
 4MlM9j147PPgoo6Lk8Eaiyusa+SykqE3OFLi3JrF4
X-Gm-Gg: AeBDietn+jzonky5oGRJWFV1BKz/cXUnunNSeo5EPUM1TNoH3xUZ7c9n0kQll4ipFnh
 zY/za7/Qo/3xlGheqbYXZtBXThUR1fT/CadeHSRoB6ih2i0QUelaSMsucR8YTERRBPb90oRlNQM
 tKVD6fUyEbap29hBCdXu7jzAtORy1JeA9A6ZYsKdAnMKmFspSaV/f2V6D4XtmP1q1qPeC0KJga/
 GV8fT8DybxnWFL06Bp5orJqJWUExS0eeIAae72SP3sO6C+nMg325XcDZ74eLkD/ikYht0yj4q1e
 m98V4FUAU8w3D7qcXW75
X-Received: by 2002:a17:907:26cc:b0:b9c:6ef1:ed13 with SMTP id
 a640c23a62f3a-ba41a0474c8mr389731366b.31.1776570780661; Sat, 18 Apr 2026
 20:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-7-rs@ti.com>
In-Reply-To: <20260413203555.1990337-7-rs@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 19 Apr 2026 15:52:47 +1200
X-Gm-Features: AQROBzCvxv00Gv3_Ws80i49XEh1goaD2-JjM5kOAKMPSVW-shiJ27zti38M7DJE
Message-ID: <CAFLszTh0-1qCbN63_6Yr-jnmWQWYEa3epaLp95JhTJdMdVcPSg@mail.gmail.com>
Subject: Re: [PATCHv3 6/6] memory: reserve from start_addr_sp to end_addr_sp
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
 u-boot@lists.denx.de
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

Hi Randolph,

On 2026-04-13T20:35:52, Randolph Sapp <rs@ti.com> wrote:
> memory: reserve from start_addr_sp to end_addr_sp
>
> Add a new global data struct member called end_addr_sp. This stores the
> original value of relocaddr, directly from setup_dest_addr. This is
> specifically to avoid any adjustments made by other init functions.
>
> Reserve the memory from gd->start_addr_sp - CONFIG_STACK_SIZE to
> gd->end_addr_sp instead of gd->ram_top. This allows platform specific
> relocation addresses to work without unnecessarily painting over a large
> range.
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
>
> common/board_f.c                  |  9 ++++++++-
>  include/asm-generic/global_data.h |  6 ++++++
>  lib/efi_loader/efi_memory.c       |  4 ++--
>  lib/lmb.c                         | 41 +++++++--------------------------------
>  4 files changed, 23 insertions(+), 37 deletions(-)

> diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
> @@ -115,6 +115,12 @@ struct global_data {
> +     /**
> +      * @end_addr_sp: the end of memory currently in use by uboot,
> +      *               should be the original value of the relocaddr before
> +      *               any other allocations shift it
> +      */
> +     unsigned long end_addr_sp;

The naming is confusing, although I realise where it comes from. This
is actually the top of the U-Boot reserved region - how above
reserve_top or initial_relocaddr ?

> diff --git a/lib/lmb.c b/lib/lmb.c
> @@ -534,46 +534,19 @@ static long lmb_reserve(phys_addr_t base, phys_size_t size, u32 flags)
> +     if (gd->flags & GD_FLG_SKIP_RELOC)
> +             lmb_reserve((phys_addr_t)(uintptr_t)_start, gd->mon_len,
> +                         LMB_NOOVERWRITE);
> +     else
> +             lmb_reserve(rsv_start, size, LMB_NOOVERWRITE);

This changes behaviour for GD_FLG_SKIP_RELOC, doesn't it? At present
both the stack region and the monitor region are reserved, but with
this only the monitor region is reserved. Is this intentional?

Regards,
Simon
