Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29468CC6B35
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 09:04:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30B07839DF;
	Thu,  2 Apr 2026 11:04:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g4BmRl4K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05E9683CF5; Thu,  2 Apr 2026 11:04:56 +0200 (CEST)
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A57A280212
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 11:04:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-6501725d888so511928d50.0
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 02:04:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775120691; cv=none;
 d=google.com; s=arc-20240605;
 b=PO3FF3d7Q3IT9Xw3rOcOhxT7vzs82b2iaYiFHZTdt8LVyStoCdOybSFAFjz+XRbxRT
 tOu2JtTQZkzURyhdRpmLftnOsesBQedegAHzg2aOkwY/wkPXNcjp1oJi6k2ip61afMe0
 m0pwulF4fKRyLn1etKVngNi57EbbY5eUInPtuFgdlDwgCFj7+qS0cY/7r7PElIdjYyVh
 2ClyS3PSvPF3t2+gUMCxDnUdiV723MIF8wjZKLvHIGj8I5H0saFaA32ZQTlahr8q6/uB
 BA9TG0bpQWJjMvW/rSL51Gzw9exzJPTfSGU4miP9PFdA7vIYNjwbgSYTVYWM53djdAKz
 9Iug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KlPtGG27Z8TIHJBCC8bqnmdkPFi1ROhG+H01g4+PYxg=;
 fh=PMru3HCAagitSHttkn7gCVctqhCMf74RlLIZPxxmfF0=;
 b=WYrsiMMazgw78KttnUmBDAYyNzr57IMu0JOIW9Dz6m+zci17Rzly8Mpw4hu1f1rhnu
 PxxRK7+ejLn/gjZjPBKEBUY+NJVoYk10D+bf5H5awkTca16WC4TwrOj8Ua7cpex+kho3
 xgp+Pdg52PgW1BP489amw88hgQgpg5aj+6z5yzq08ATaYeCBMvEbNgEWDfTVaUFXJ/i2
 A/w2feXbuRShbbuUXMHpsTQ6Ghk3R08EYw+f++kEds+6imB1MAYVohnpJQPamDG+fCnI
 VgwaquI0mJ1kmjkOBlS+Jg7hgPVB/G6dgd0KXxB5xGUiZNqnLn73iLlTz6vTY1uVnnur
 S79w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775120691; x=1775725491; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KlPtGG27Z8TIHJBCC8bqnmdkPFi1ROhG+H01g4+PYxg=;
 b=g4BmRl4KR+o/9AaZfQpOMqRt+3VVnFauwmIQdcEMM66EqTehjv0iMlEZ4lJvvoZFZ1
 OeG1lAIybBQ8aWnAC7VLG6dxQVU6KrJOFtxQe+gMEWdoroDJmPMdOUhls8KUGIQV5hCN
 bm9HksBq8HLXSNeVIdi/UnfURDlwvHmsYGpI0pLZ1T+7Kwq3JPVVwsY37cSHZWFQhVdn
 5DUvR531mpTxHXdDnNN+oQ4OHgHTVTzHVvoDU3q4BLFQJQBrsg1j32FYmqALd8ObRq7o
 q79z5d17SxS1YOCSpSHkDBAGReRD3WVn+7AwMsOeTJlNkq+PWB4PWMW5jwCGbeh+qd9Q
 6WEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775120691; x=1775725491;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KlPtGG27Z8TIHJBCC8bqnmdkPFi1ROhG+H01g4+PYxg=;
 b=Yi6BKHinEAkzLx1JqpP2h4YQd7vkQ4d+EQ9ZCO5vEwpzRq8BVfroNlBHNrRNxzd5/C
 SJ+rRUYzdC3xFp60BabxW79AB4gvmYXwgBPrX6YdQrUBIiy7OGz5Rpv4yF08RcJqZe3J
 kHaDYYErbT3evldOdOHtAppeIk6EVxGVe1safV2uhXKDWawCo9o/1JjhdP1+JNbRgZl/
 sj+kTxufn6pFDUuyVY3ZECYlqtjdC67yAXDDVMjbGMeajtwwnxtDHejE6ve3q46S/+Ep
 Gv4sCFAaIotXoJcTrOzOoog7nSOPGUYeD27aBC/vDPpTV55dC/NLPuUzDRcF5Sp4Juhh
 ivTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8h3qmkJ3FJfzLT5wZkdbwqQPd/evbx8dpfOYVgheG4kr0BlceVxA8HdlqQVtqWXmKpAtsk8U=@lists.denx.de
X-Gm-Message-State: AOJu0Yz94uYCu6T6lrbF1T3xcbHZWj6DWHJ2TLgUtFMIJmAk4FtYuyOC
 v9NrRxZpGI1r1ahGyUv7XoQLRIrWsuz9IPPHf0EhZmEnCkJAJ0ivae/RT1gaFDsRofsigCUuljE
 fNak23kOhxzdhajP/cnJD+Ao4hsloF0giuNXDWanvCw==
X-Gm-Gg: AeBDieuODn0WcsVzovxWXd4PpKRJlWEaxR7/qOrqkuP0RunGKCT06flnv01oDPmUQv0
 JJzlveY0FDxiDIw1fAUg9b5u7dnz2HnfX7mHC72DcnKNmDpO1xkA9XoJMQ0OAmbeMjYGt8S5goA
 8q6ScFtKM7qsg+DAJgucxd+Sbel45XABy2LItHx1v7MPfASve/pZ/ka6AvpPQsqLNaJ4duC+D5G
 tgkfIXHnGz97sscTC2hC7ur3RQBJ8TU8ISGpbf2KdP+o0Ghiv9h/yRFlIF9wmNuxUd8RyLxNvxf
 tIx7oYOdrI4eeqLMedE1+Lr+tkcE4A97IoUYAiJSZ4yx1+Vh1p+lVpBj49F+oSE9fS3qgjB2u7D
 D+CNYMvKV5PhocABlzWpMTLaanp/XXoG7aZeXEIjtiHzTLvoB5X8V8rJGH2yVT9n09LEc5tqDMI
 lJiGDG+JzwDC+B/MdK5CANRNOZ0pE3moufdboG5YcF8FzfXu6OiNtI2pEkflCs7WGbzDgBis9Yp
 nwHRpDW7MPuhX8OvW7LEDjsbeaj7Ym+U6A9/Pb2GSP8NooIk6HoXyLmFS1sJyxZkg3puE0wZs46
 gP2z2RPImnXbJXFq87xvWchhfIZO7T9KYb4M6Pq6xrpU
X-Received: by 2002:a53:ab09:0:b0:64d:5742:5ab0 with SMTP id
 956f58d0204a3-6502fe54682mr4844788d50.43.1775120691253; Thu, 02 Apr 2026
 02:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260402001410.3736815-1-rs@ti.com>
 <20260402001410.3736815-5-rs@ti.com>
In-Reply-To: <20260402001410.3736815-5-rs@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 2 Apr 2026 12:04:14 +0300
X-Gm-Features: AQROBzAtbhduReeBGz8pFXUN9EmOeHEo6jVa_8ICLyLfQP25HVNIUglrJSJCO4s
Message-ID: <CAC_iWjK8BNOtyreZR6WRO98z673hthQENN9Fp73+igzaifUuLQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] efi_memory: nitpick removal loop
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, u-boot@lists.denx.de
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

I don't mind merging this, but why is the current code flawed?

Looking at the function even if prevmem contains a previous valid
entry the check will fail

if ((desc_get_end(cur) == prev->physical_start) &&
    (prev->type == cur->type) &&
    (prev->attribute == cur->attribute)) {

and re-assign prevmem.

So please adjust the commit message if you want this merged.

Thanks
/Ilias

On Thu, 2 Apr 2026 at 03:14, <rs@ti.com> wrote:
>
> From: Randolph Sapp <rs@ti.com>
>
> I don't even want to think about the possibility of this pointer
> containing a reference to something from a previous iteration.
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
> ---
>  lib/efi_loader/efi_memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index b77c2f980cc..882366a9f8a 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -129,13 +129,13 @@ static uint64_t desc_get_end(struct efi_mem_desc *desc)
>  static void efi_mem_sort(void)
>  {
>         struct efi_mem_list *lmem;
> -       struct efi_mem_list *prevmem = NULL;
>         bool merge_again = true;
>
>         list_sort(NULL, &efi_mem, efi_mem_cmp);
>
>         /* Now merge entries that can be merged */
>         while (merge_again) {
> +               struct efi_mem_list *prevmem = NULL;
>                 merge_again = false;
>                 list_for_each_entry(lmem, &efi_mem, link) {
>                         struct efi_mem_desc *prev;
> --
> 2.53.0
>
