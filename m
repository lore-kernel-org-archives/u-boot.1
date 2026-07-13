Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4848CC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 14:13:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D6DF84BF9;
	Mon, 13 Jul 2026 16:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KvIluZaq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 940EF84BFC; Mon, 13 Jul 2026 16:13:33 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D7BA84A5D
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 16:13:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-698bf053053so4998146a12.3
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 07:13:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783952011; cv=none;
 d=google.com; s=arc-20260327;
 b=JpA3nMVJ+861YNGtkykPRW1QdGcRpeUUG8lN7UdCd2cmtIRR4s6ZjNvnO4vYeZzC3L
 TRpnJF3vv8sCn19DfyItkKQ1GyJI6dlLVIPGvZnGA4WSa+7QdT2bJKqyIHNksz1EWn3v
 XAWx/NGB0PVRD9WQXI5dCJTGOIzR4B/wDvw1MoRjVF/CIz6eFd/VSRz08NcQwan7I/Yw
 sqjApGXZB2LYvqNrxZhZD4nZXeXLsuaMN/qXWS6YAIookSwLzJ3gWaortSP6O2Nf7Lhi
 khYrC8B9+4IJRLmJRYVbReWY7bfLAznudieb57XKm4VpIJse7W1bNVyOanwgDfDO9JCd
 UAoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=27en/zyBo7AyfnzbXnYOOGJKjsWAdxdb1/gZa24yLqk=;
 fh=abS37xQletEHD3hY8qePV2Mh1NRENyuYJFfBfAa54VY=;
 b=CZmpmh0yoVuTjyLVdhd2LvKIgJ3YCBGF2NJpSHe19aowc/fFYWnHOIBYYAMWKcGtsj
 /NS/dLHKG0ydCyGCpRoZzR4AcJkufHNolmdYGMDzRk2HOJ5GnoXbjeVPTd5kYuJC4yep
 Jm8aDal1ETEjGuDL9sC/K9n9buRIvAfcSW79IXnZN6w6jirR6yJEfWlFOHiy26wUywVL
 zp6Qvx8ItVfl6fd6zjFMcrxuzgQOl3V0iXrzJfE7hhQ0/IjaHy5quI2UGH01YZ6HYKG8
 +1zdf6VmwcCrMFySyeO/ifY1A2W2wh29FOuH4eAokVNWY8B5AcuMoGc1ZrfmN5HCeFGn
 Brjw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783952011; x=1784556811; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=27en/zyBo7AyfnzbXnYOOGJKjsWAdxdb1/gZa24yLqk=;
 b=KvIluZaq1HtHK4jbfE+sy71Pery29TxjLEaLTDc6kMgOPdC06+bigzxCBG1CVw7M9d
 cobAbnSeqVbm0CVX+6tLFMI14PjkI2QMGZRUTy6g8fL0RxUGPvpNYXiL+d9wi1CBsjZs
 e0kdi6r68AIMkP26hPrUWQhE7M6z3VjjWPJEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783952011; x=1784556811;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=27en/zyBo7AyfnzbXnYOOGJKjsWAdxdb1/gZa24yLqk=;
 b=Q/YeGZvXCRhMAd8Bqs+Yn2oNUQUqi71FC8E/Do5YvMIlvnq0PIXeTGKDvE5Z+Vn3hP
 sOgOHaNcbYrcM+EeHSe7/2HmgyVkgIJQAY/7yuzh3iXob9UdW6V3jNL/s6vJyvv2pDqW
 DBumLLDcvNCncYSTgaXisFvAxZQ3XRvJypZu6SirGlpBEMAnGoV+u+t3hmInTaa9Uedz
 kM7ZaOeitFrMZOldih0vZgPyS0jNnV3IqFJEYRR4v82Uehn8NDTz9jUazgaVjBFLzH0N
 ipbzgrM/VlS+31SqU/HQlUzi3nyeE0sxtEf8okuxKwozaA04OnYmtHPpqrgop9qAZV87
 jzkA==
X-Gm-Message-State: AOJu0YwKIbsO8CepOFLP2YRYgDtK5Hgzp+iEkOdENdBYG9vSXiVPOBBe
 f+qqOFUXrQpbIwMMlGcGjk7t905ZWwipEpiQS5xBhzz43gcZjKliOgBuEJcJby+2Y+hweTUmgrp
 eJgORRIhokpOBEL7L20VRkX9tcMn0Kh1XaiVO7mpBpn+AZddPCHOAJA==
X-Gm-Gg: AfdE7ckqsCHiwgIVHPC9wrL2eaWD7yeTOrEXAl5gPHtLgVSpY60Xh5favIuWNd0jpdx
 VWOfoLlLLP4G4alj9nWVfjFkB5uKTxesuE3Dgk0vsaDEZaYZqFsMgYI2AioQ/8nCToWmsCXlYo5
 nZcWy91lbGa0ud+qZ0BI4H/3D28CjgR5k4URIf4iI1W7aV+Fs7Uf9+3B4ipvoJ0iQbSIavkfaW1
 igYa6sBcCRjPA4ht1hWkOwlBn7nk9s2kUNO5BcmKT0VhaIbSqmXsZq/Vlx7dv+6XajIQY3Zr1kh
 lcJMHw==
X-Received: by 2002:a05:6402:5385:b0:69a:9355:ec35 with SMTP id
 4fb4d7f45d1cf-69c5f38b0a7mr4114461a12.41.1783952011019; Mon, 13 Jul 2026
 07:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260707-binman_bootph_fix-v1-1-3603996799e0@ti.com>
 <CAFLszTg5Qu3stt8AkeBpWibTyYxp1tXAern3aLE6MEHkHmVRyQ@mail.gmail.com>
 <DJXETQLM9PQP.C2LCLMD6LMI@ti.com>
In-Reply-To: <DJXETQLM9PQP.C2LCLMD6LMI@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 08:13:18 -0600
X-Gm-Features: AUfX_mzl2bh8fC5JOUIrKDyY5zlKDJb3X9GCmZU-D4k15qF44nLcRvVKTi_GNkQ
Message-ID: <CAFLszTg4hhLezFpkvkHY9qK_WQ8xfcRi8AWx2RcVkAeP+RPMvw@mail.gmail.com>
Subject: Re: [PATCH] tools: binman: fix changes not being written to source.dtb
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de
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

Hi Anshul,

On Mon, 13 Jul 2026 at 05:34, Anshul Dalal <anshuld@ti.com> wrote:
>
> On Fri Jul 10, 2026 at 12:44 AM IST, Simon Glass wrote:
> > Hi Anshul,
> >
> > On 2026-07-07T10:44:09, Anshul Dalal <anshuld@ti.com> wrote:
> >> tools: binman: fix changes not being written to source.dtb
> >>
> >> In the current setup the changes done to the dtb by binman such as
> >> bootph propagation are only made to the intermediary *.dtb.out but not
> >> the final dtb.
> >>
> >> This means the final dtb that's in *-binman.dtsi never gets the required
> >> changes applied. Therefore this patch fixes the behaviour by writing to
> >> the supplied dtb before exiting with a modified test to catch any future
> >> regressions.
> >>
> >> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> >>
> >> tools/binman/control.py |  3 +++
> >>  tools/binman/ftest.py   | 41 ++++++++++++++++++++++-------------------
> >>  2 files changed, 25 insertions(+), 19 deletions(-)
> >
> > Please can you spell out the concrete symptom? What breaks in a real
> > build when u-boot.dtb doesn't carry the bootph propagation - which
> > stage reads it, what does it expect to find, and what goes wrong when
> > it isn't there? The *-binman.dtsi reference is confusing since a .dtsi
> > is a source file, not something written to.
>
> The actual issue was observed while we were adding support for our a new
> platform 'AM62l EVM' to U-Boot where the missing bootph properties meant
> that the parent drivers were not being probed leading to boot failure.
>
> >
> > Also please rewrite in imperative present tense: 'Write the modified
> > dtb back to dtb_fname so that ...' rather than 'this patch fixes the
> > behaviour by ...'
>
> Yeah, the former is more clear. Will fix in the next revision.
>
> >
> >> diff --git a/tools/binman/control.py b/tools/binman/control.py
> >> @@ -677,6 +677,9 @@ def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, ind
> >>          dtb_item.Sync(auto_resize=True)
> >>          dtb_item.Pack()
> >>          dtb_item.Flush()
> >> +
> >> +    # Copy the intermediary dtb ('u-boot.dtb.out') to the dtb supplied to binman
> >> +    tools.write_file(dtb_fname, dtb.GetContents())
> >
> > This is updating an input file...really not keen on that! The updated
> > dtb should already be written into the final image created by Binman.
>
> Perhaps it's an issue with how we're using 'u-boot.dtb'. As I see now, a
> lot of platforms (including TI's) are using 'u-boot.dtb' as the fdt for
> U-Boot FIT. Do we not expect the final U-Boot FIT produced in those
> builds to have this propagation logic applied?
>
> To test things out, I built the am62x_evm_a53 platform and the fdt
> extracted out of the built u-boot.img lacks proper bootph propagation
> without this patch applied:
>
>         fdtget -t r build/u-boot.img_unsigned /images/fdt-0/ data > extracted.dtb
>
> It makes sense to not modify the input files so then should we change
> the DTB we use in the u-boot's FIT to 'u-boot.dtb.out' instead of
> 'u-boot.dtb'?

Possibly, but are you using Binman to create the FIT? If so it should
use the updated FDT. This might be a hole in how Binman works?

Regards,
Simon
