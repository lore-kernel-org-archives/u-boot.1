Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8552CEA7186
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 03:52:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8941841C8;
	Sun, 19 Apr 2026 05:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dn546x4n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4813484258; Sun, 19 Apr 2026 05:52:35 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3FD1841C8
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 05:52:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b9910707d82so299609466b.1
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 20:52:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776570752; cv=none;
 d=google.com; s=arc-20240605;
 b=TvgsdrzgfAxk5GT/rFq1n7XATIJ8b34xPUjbZhPYvGOzAMYF7FTFzzrF2JnqM9/sL1
 v7Sy71vCE85EjDifYxyIuHttEHKVf5K1bmxNKQczxaJ5HhG8r4MVe2QqYdtSYZH0Rz98
 XyDQ8vm+AyeI6flBPqvfYmssoFca5uzcnoOj1UzfOCyKASzi2YyuujER0cANbrCuPhkT
 FssTQa2H5+TRLaGH+QwAxFxuVD2fyg8dsgHWsTz1WAOL9iuRyHeKhIQnRVP3Hd7FWjcf
 woHmsQ5qQmnJFq7g+ekeRYWXVV+MTC3JBfw6m6uBrkev7k5Skb8qs+HD//TPleG/2zyS
 6YMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tXEXdqTjlzeIRiv5ZZG1LCLaPOnMyrDIWClcwHksPcQ=;
 fh=+HDHgEKUjDUR12D+Vufl665Fw0oNeOV35Ov9ta0Mg8w=;
 b=Cn8BToXbvdRmMZ+xutwPailsf61SI8QMiwzjZ/3ER5vnG9ieSGK+Vh1oa2uXBPAGNM
 7BWnC/of0flE5tsp1TKBiUnG4PV+KdLF7UFWR778MJIgxYhBxbyP9jDOmNdOnLmagu55
 KfDGWx1GLfnHeCZKB5sND60B3BS9zqz34TcciY4Fv9EgHQBspLHZqEy2Vjy0toDOpdL1
 HdvJHwF7oHjsI13LvElxg7r95bTSnWt5oOb0tsMpwQBp+CNU9lh+d3etl9LEaBu6VT2+
 lrIki0koZ8IuCOESAwe8FPtLud4WiYxMzwfNWETcG8Td6huluImTf0fxRuXjNU/3HIg+
 fCow==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776570752; x=1777175552; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tXEXdqTjlzeIRiv5ZZG1LCLaPOnMyrDIWClcwHksPcQ=;
 b=dn546x4nBipHN7K47k4lD6Smjr58IFYtWNFTSPMqV0n41enQILnOeym+2cQObhPmlF
 2+JqeAzcx0oisiVV1mbFSeR01ZOsf8wBPPWKCb+XjQlIburcwwCi1zKStg8+yWOZybnU
 Q6ZeudMsnLPjLoux8VSRsQWIYYX9LZGHQkxfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776570752; x=1777175552;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tXEXdqTjlzeIRiv5ZZG1LCLaPOnMyrDIWClcwHksPcQ=;
 b=mmhx1n7sxyuCbdpGK+PeqLm/ZnG8ik3RlnkjOBj2zkK329BWUsUnBpryws31/Yf9VL
 bpNdvairS8FyK/buHJd4Cr5Uw+PKYOxjx7XVtyQbOszGKZ9P2VHc0zI3Jf3t4M1fuOLI
 vX86r4lU8AmMgofEF9a3KnaYr8Xfbj096K2/zLbuElxUZSbuXaiLSYjMJ2eQWdct1jQK
 CcEkj9BPjWIU50bbg9Jid38zUuCJ2pX39JqEznxcAw9483tcVS66s6mEHcnTQMU8kgDa
 B0lJv5Z5GAO7L0I0eZgaC3x47DlEJ59tcklaqf1XS444aloTDzs6KJlBebcmMXHAo/dB
 KOHw==
X-Forwarded-Encrypted: i=1;
 AFNElJ92M4mYvukouTHjv/oVgewcx6hOxOOirntuoMEam8INKrIsWIN65qu5T2Hnlg2Hbd8B61HT6mw=@lists.denx.de
X-Gm-Message-State: AOJu0YzFShMC0nTHG/6CYQ6IiWQMU1Bb03qDysZgHFdMY8XQ30k4SDbN
 eEe4NuE2O8CxR18s/LkKZXAKsLgpqpqVP+k6WR05g+1LBHJW9UYHtAlxpUbArJii2t7H632+dgp
 7AQUI1tHm9jG4cgtuQ4SWdlJVJhIzP0v4yV4YqxyI
X-Gm-Gg: AeBDies8mf7mV0KY4DNGTq+4EtzEMOaOf9VSVcvcsss4k5Fmc9uBTbZs1s7rNPrDCh3
 rMheIa1gXfbXB3wpY1dF1Vbjs+4SYq894fg/FXbS17kcA+ADVLiZ2rneYo00TWrSYH1bnZI3AUd
 1QocVs0I/XOLuo/R38NNLnHEp62/2Q8r1oeqBWoALoPJEW1oyo8KmAa+1BL1uHSOdcQ757BheCn
 3RCDP6OkGu9ulDAF+40IlRIAfW5sc3Tvm664yV+xxmkSADqHh5hh2rOhwBWw2KNOG/3J55+6GUH
 qENc4ngKTkIRktYV/iCa
X-Received: by 2002:a17:906:c10d:b0:ba4:afcc:4a5 with SMTP id
 a640c23a62f3a-ba4afdb4aecmr363641666b.17.1776570751854; Sat, 18 Apr 2026
 20:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-3-rs@ti.com>
In-Reply-To: <20260413203555.1990337-3-rs@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 19 Apr 2026 15:52:18 +1200
X-Gm-Features: AQROBzAW-LuaeHh05z6FThDiOCFXtk3WFokWEX5Xk1hG6asEWJh-C1COpW3PgXI
Message-ID: <CAFLszTgXsz+=TBvx5+OMYneRuJVq8Jp3EMZPFkBHPjEfGwcVyA@mail.gmail.com>
Subject: Re: [PATCHv3 2/6] lmb: add LMB_FDT for fdt reserved regions
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
> lmb: add LMB_FDT for fdt reserved regions
>
> Add an LMB_FDT bit for fdt reserved regions, so we can reclaim them when
> parsing a new device tree and properly warn people when a reservation
> overlaps with an existing allocation.
>
> If we don't at least warn the user of these reservation failures,
> there's a chance that this region could be freed and reallocated for
> something important later.
>
> This useful warning mechanism was broken in:
> 5a6aa7d5913 ("boot: fdt: Handle already reserved memory in boot_fdt_reserve_region()")
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
>
> boot/image-fdt.c |  5 ++++-
>  include/lmb.h    | 14 ++++++++++++++
>  lib/lmb.c        | 33 +++++++++++++++++++++++++++++----
>  3 files changed, 47 insertions(+), 5 deletions(-)

> diff --git a/lib/lmb.c b/lib/lmb.c
> @@ -654,6 +654,31 @@ long lmb_free(phys_addr_t base, phys_size_t size, u32 flags)
> +void lmb_free_fdt_regions(void)
> +{
> +     struct alist *lmb_rgn_lst = &lmb.used_mem;
> +     struct lmb_region *rgn = lmb_rgn_lst->data;
> +     long ret;

Could you move 'ret' into the block which needs it?

> diff --git a/lib/lmb.c b/lib/lmb.c
> @@ -654,6 +654,31 @@ long lmb_free(phys_addr_t base, phys_size_t size, u32 flags)
> +void lmb_free_fdt_regions(void)
> +{
> +     struct alist *lmb_rgn_lst = &lmb.used_mem;
> +     struct lmb_region *rgn = lmb_rgn_lst->data;

Since you are adding a new exported function, please can you add a
test for it in test/lib/lmb.c ?

Regards,
Simon
