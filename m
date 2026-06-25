Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0CBCDB47F
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 08:52:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6AF9846F4;
	Thu, 25 Jun 2026 10:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HcqB97tf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C9BB847C8; Thu, 25 Jun 2026 10:52:13 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23B3E8460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 10:52:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bec43ee8ff0so188317966b.1
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 01:52:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782377529; cv=none;
 d=google.com; s=arc-20260327;
 b=eegH4+qzM8UjhpmlMzX4Ia10jk+gpQ98uyacNmn7Tcd2JAIxFBwOl+1IJwILDOayH6
 jusf96T9pLRmEyjKMyFWZmf/NuHVzkKI8vl1WfH+z6ITn76RndoA09RNohBP/2R42xWD
 lz+Tl8pHL4FOEBsSA4EHx+j2LQiYChVRfECCAohQIohX0dtbYykRhyWjpVXrfVViSQWc
 A38ZwGXJPPYolsFBD6UUWQvZ55mAAw+HLCsApV/k4YRERP5R/qSJp5PaYjCmnc4WWEy+
 1EHQrzmdAPq29OO25OCLPEumfD00sg4ybmpD7SySVOEeC77/SCSLi5Au4CO+L5Q0BQf3
 BA7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1Vc/BObNJ6R7BQyXVJRxnUGiWyX5mUFz0A1cayYFqqk=;
 fh=oik2cKbUefHtkvEZWL3qj4nW1fZik1DcKWq+k+G2QPo=;
 b=lOWNNCEeEJT9g2hdDlMH3kfBB6D1XM6S4mwjMZReim+iXeeSdLzCMXXPAX5AhvH7j3
 aC1lYN4CpmZwyBid7kgUhILfgYkX/722dzpg0PLXCOm0vB+kZfOCDdsk3tY3WZGevzXW
 ywH6FbSUWSsb1L2qlH6r1g0xnUF9wmLedgmVDa3u3unHb+ckQFFzjuxYnuxxfU5UVtCL
 JUVcI/PLFc/kf+oBtZfwp+qmoudWlPI8/57fcU+/+ovXfqPvmTR0Wa25eZOyoTtaibuv
 op1OvvEZ6EyLQ57v2AF/356ZZaF4es9ZXeuXVeueXaTgw7Rg5XMhUxkk5Efkz71iotk+
 sluQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782377529; x=1782982329; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1Vc/BObNJ6R7BQyXVJRxnUGiWyX5mUFz0A1cayYFqqk=;
 b=HcqB97tfptqZkP4bKpB+HgMcbDZSgTVXVdiML34Ua1cRwqL7eFKdsTSTX9vNFFl1zR
 WJGlzHIhNejl2in07uGsXRAU309WR645+RSlX6sBN0HzkHZGrlo/40gh+NScXJwveXdl
 6PwGUUaDEzLkzD0sIISvDoo7HrfYnnxyEZfzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782377529; x=1782982329;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Vc/BObNJ6R7BQyXVJRxnUGiWyX5mUFz0A1cayYFqqk=;
 b=iM1glMZdyb6lfaj6phJi8koNVu22dT2+FF4j558pqJmdOGzIB4JoxyUEMCK2XhjuWV
 Ny4IwMF5cEsdyH00UTbNTdcdwEB3dUVpKHwi4N2rjnquLnsxL1j0FO0+kKpFAz0JCNAj
 9xW1x1eq4Xwxg9YoJECy64wdW10dHEbFD5tT1JZYC6m7RegWVZrXkXIvVCpz4SOOVqAl
 iziq/w5MvAsh+BnT6pXahlfYBIE6SK4ruB8/zEpowo8r82K+3VdpN+rv++y7B6YfFvtn
 ZlOpf1ZH4eOr3Nxg3qOGbwPImWCWojDlUT7xjHXmojplRUuFlm2iyxGWUjeSubXWDtjF
 bmxw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqs/UZCxx3sLpo5W3+KIs2oY9fHQgJHk1H4UbXVpAje3TepkPjcp3eBCQZ5VFQ50UpuNAlQU8A=@lists.denx.de
X-Gm-Message-State: AOJu0YxtDMvbh+bWmoP7eWp4yN8fRA/1jMl0T5Yv3o+t1k70kDavBunI
 /NcbdhsXbOVivpDCUNxOUh/CfSmmZ2MCPvXH00Rt/LWN8lr9ICkjeZ+sdsCaJb4JXeWPednauAw
 I2uHY42fFR4py8K+auJPysU1l3Rt3SJdi9YTxOCjp
X-Gm-Gg: AfdE7ckLyQotRS+tMPcbd4UzMUnRT5wWs8q4nsXZfPAJKBdw+IBrgYRJ6l0yOSsTUN+
 pkqE1PHtUTK7WS5sJDNOsPdbEJAGdi+jT+sYj6r6KhXppzfLyjVaGtK29KLk0gskZqPF+wF3nxN
 P42QU2SAriRIh8NF9uWYIbq7kza337LDMUYjSuuTpcvrnXPafifgIonR3ePDpaE5sRcLGNUZ4bx
 gkXkrC6F2+/Zaeaa8oyY6tC70fDXs/zzjCUymw/FCUo1gJpLwVk/m5DRFnqTMwk+3vRIfYFaw==
X-Received: by 2002:a17:907:72c7:b0:c0e:7f2a:ee96 with SMTP id
 a640c23a62f3a-c103158cdd0mr660682166b.29.1782377529539; Thu, 25 Jun 2026
 01:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
 <20260621081915.19154-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260621081915.19154-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 09:51:55 +0100
X-Gm-Features: AVVi8CdVz7RwCqHOyjEKjN9b2lydJiAFfTo8tgq9gZqXo_MSXAU9H2aURcd0CiE
Message-ID: <CAFLszTjWb+X_-Stz=e1ntGtA3N45kmakUbe-puO+WCr+snkzSA@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] efi_loader: use pointers in efi_acpi_register()
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
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

Hi Heinrich,

On 2026-06-21T08:19:04, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> efi_loader: use pointers in efi_acpi_register()
>
> Both efi_add_memory_map() and efi_install_configuration_table() expect
> pointers and not virtual sandbox addresses.
>
> We need to convert the virtual sandbox addresses in efi_acpi_register() to
> pointers in memory before using them.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> lib/efi_loader/efi_acpi.c | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)

> diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> @@ -37,39 +38,45 @@ efi_status_t efi_acpi_register(void)
>       } else {
>               /* Mark space used for tables */
> -             start = ALIGN_DOWN(gd->arch.table_start, EFI_PAGE_MASK);
> -             end = ALIGN(gd->arch.table_end, EFI_PAGE_MASK);
> +             start = ALIGN_DOWN((uintptr_t)map_sysmem(gd->arch.table_start,

gd->arch.table_start is an address and then you are converting it to a
pointer, which is fine. The confusing thing here is that
efi_add_memory_map() takes u64 arguments which are actually pointers
(in sandbox terms) and has no comment as to what the arguments mean
(in samdbox terms). But we have already had that discssion and I don't
want to reopen it.

I would prefer that you declare start and end as void * so that it is
clear that they are pointers. We should do alignment before the
pointer conversion (sandbox uses 4K-aligned addresses anyway) so
something like:

void *start, end;

start = map_sysmem(ALIGN_DOWN(gd->arch.table_start, EFI_PAGE_MASK), 0);
end = map_sysmem(ALIGN_DOWN(gd->arch.table_end, EFI_PAGE_MASK), 0);
ret = efi_add_memory_map(nomap_to_sysmem(start), end - start,
EFI_ACPI_RECLAIM_MEMORY);

Reading this, we can see that we align the address, convert it to a
pointer and then pass the pointer as an address without doing the
sandbox unmapping. This makes it clear what is going on - and avoids
casts in the C code.

> +                                                      0),
> +                                EFI_PAGE_SIZE);
> +             end = ALIGN((uintptr_t)map_sysmem(gd->arch.table_end, 0),
> +                         EFI_PAGE_SIZE);

This silently changes the alignment argument from EFI_PAGE_MASK to
EFI_PAGE_SIZE. The old code was wrong, but this should be its own
commit or at least mentioned in the commit message.

> diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> @@ -37,39 +38,45 @@ efi_status_t efi_acpi_register(void)
> +             if (gd->arch.table_start_high) {
> +                     start = ALIGN_DOWN(
> +                             (uintptr_t)map_sysmem(gd->arch.table_start_high,
> +                                                   0),
> +                             EFI_PAGE_SIZE);
> +                     end = ALIGN((uintptr_t)map_sysmem(
> +                                         gd->arch.table_end_high, 0),
> +                                 EFI_PAGE_SIZE);

See above for the pattern to use. The nested map_sysmem() calls inside
ALIGN_DOWN()/ALIGN() are hard to read. A pair of local pointer
variables would make this much clearer and avoid the awkward line
breaks. What do you think?

Regards,
Simon
