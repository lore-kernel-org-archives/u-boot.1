Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE745CDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 10:49:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50A628460E;
	Thu, 25 Jun 2026 12:49:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YJZrC93x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E529D84704; Thu, 25 Jun 2026 12:49:53 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4DB880398
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 12:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c0be5e548a4so384882366b.3
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 03:49:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782384591; cv=none;
 d=google.com; s=arc-20260327;
 b=QpUsvvcHeUvaoXh/yBcHAAZPfzTDB1epv2qzqCsF5YKDAK2mN1EB2CrWYdGK3P0VvX
 RvVW5ZeZbLz4JfXnkbVGF5UNW05c4ZVqfKqz7NBJgAaB6pt47tdCgFoDQrycWGd2bYsV
 JHtMEy71269qLmevVu96jsPbqZEAj6L4aLVcypm5UyZgBjMTGjA6VUfpwXRQjnsEoxPe
 vsCf+QXI5BHw0/oQ2BrB2Yxg1jZlJJROTDrx0ihTfILRSAb5fF48VcnR7hgZXn9/HiQr
 RvMXb990BZr3az2CejCLy3Q9DzcGJIG7L90G5sxnq0YTaMCKm8nOjKDvSL9rRnlzZKpJ
 AuTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=f8ulMHoyO6vjJXHmC/VOgCoE3ll1A3Gh/A1qZXwnvoo=;
 fh=Iso1kD2VttzxCi3MZXLcZz1RXGwgVvhao1hyJUPVD6E=;
 b=re5oi3ePq7NK8xCub/93yXIXysaXLDJckbc2+kF5qSU/OxefabcbuIrj0MAorcAB3L
 PCiZVUtLEB8ld1fCb6eHwW5bbp+t9flTmHhcyZdD5lFlczDNVBYM72ZexNx48Ev1ewMG
 VMdhStp0cwcCI1PLmpZ5loK+rwZGw3MQUDP6vKlQkD3kSJUn/G7n6x6PSsAVwhmD82jQ
 SSPSTJywCQvOhfzFWssv56Pp67qadM4oXZAMbHxIptabRf4tb+3/d3AoaS2XDJBiRUp8
 WW1p3Pt0poax7bdAAlgo48YptQxCrKSeCEFYq1a53v556uqbSdlOJ+Gck21r2uALjqaz
 KY0A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782384591; x=1782989391; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f8ulMHoyO6vjJXHmC/VOgCoE3ll1A3Gh/A1qZXwnvoo=;
 b=YJZrC93xdJKbjh3uY2y6RKqo91TDrdgWqUaS2jfOZH5VLWBxCjvkvgfbJk5RV0Re1h
 85cfrW5vC6aUBDpDV6kXgR0cSomu0qvCwaUE6n0Pde9Q989wUVFs2Ser+OsjSnp4AYrl
 I3DAaov43ES4zbDk7VvtGjroIW4Q+3zJjdr/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782384591; x=1782989391;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f8ulMHoyO6vjJXHmC/VOgCoE3ll1A3Gh/A1qZXwnvoo=;
 b=h8fGLbm1oJdL5GKz6F9Hql2futZHbB43zJxzc3eyhIlmS3FXyAxz7+vVNgcp5EHnLm
 yXCjmgSfQw607KWCcMT1M1y6G9svVt1ge8wQETpFaqqMFduIPyo0w2GY8twUPzdFrUPg
 joW6lNk6voggG/PBCaCYP3DnkyehaaahZmRH+GJb7xAwzcSP4DVKWcr5z/dEPcSAjYjO
 Lhay4uZji404+/Wt3Fax7FNnwqtI0cDe9/zWqQJauYK2xp5gV/XJNgiWvNn3swTtMQUB
 MNC87mHtNiQM7oReZ6C3OJoFagMIiZxmFoTkhRFcCNxN0XqNNwUOjfPlbTtQVt37+NZZ
 MOCQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro05vxJToLrpOJBccOuYO5F9sTBP91cdsryqrETDhmXxvlbGl2TpMfkvWxG5Kbh+hhFZtlamzs=@lists.denx.de
X-Gm-Message-State: AOJu0Yxna6vU9xSJl6/J0QRRT60HUEuPMMNonO1ia5b312kr4e/u64Yv
 t0wiOb1w0ZRvEKGlCihKzrJZudmo3gAyg4lgPy/s+ZTIPow4V6YzOHewtuRNjUZLbV+AF6G8Aoi
 VNkINr5R0La6PQreN9hWK4thvhbu3rq6MVOYnm1n4
X-Gm-Gg: AfdE7ckbtD3C07y0qGp9kYhMaLBAoESMQk9WMtgGFrXcoJ51TBiWQEJ+qVTiv6wUonv
 7MrnJdQd8rN9sfXoNdq3nFFqxCLvLY/vpoNgAxU36ooVO9EIKGoWigGU7jndIX6TS+1AiK3jDzX
 VGrMvnVasnnkMrIa7Ts3kOe8DlK1uVYCvxQo74/pvWdMWgHDa4vrIdsqQcmj73VrW1PX3LeEgRf
 c7rln6be0R9ix3VmX2HJAA3RYpkwCgtgoHAfvOkiM6d2IZxC8/kWAb7kq+uNAs1xF30cWYm7g==
X-Received: by 2002:a17:907:d94:b0:c07:6950:4490 with SMTP id
 a640c23a62f3a-c1205f4a0c1mr127123266b.42.1782384591217; Thu, 25 Jun 2026
 03:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
 <20260621081915.19154-12-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260621081915.19154-12-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 11:49:38 +0100
X-Gm-Features: AVVi8Cc0Wgjbl6M0g5IXD1q6jTwok31vmEfYgLqqo5h-GnZ7y-FXnBRvNeWpHrI
Message-ID: <CAFLszTioYxpY==wAwmRqbSNAwJnV5usS08Tik5GhD_TynxeiMQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] efi_loader: add ACPI table dump EFI app
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
> efi_loader: add ACPI table dump EFI app
>
> Provide an EFI binary that can dump all ACPI tables to files
> <table_name>.dat. These can then be further analyzed by decompiling
> with iasl.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> lib/efi_loader/Makefile   |   3 +-
>  lib/efi_loader/acpidump.c | 563 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 565 insertions(+), 1 deletion(-)

> diff --git a/lib/efi_loader/acpidump.c b/lib/efi_loader/acpidump.c
> @@ -0,0 +1,563 @@
> +static efi_status_t add_table(struct acpi_dump_table *tables, u32 *table_count,
> +                           uintptr_t addr, u32 len, const char *sig)
> +{
> +     struct acpi_dump_table *table = &tables[*table_count];
> +
> +     memset(table, 0, sizeof(*table));
> +     memcpy(table->signature, sig, 4);
> +     table->addr = addr;
> +     table->len = len;
> +     ++*table_count;
> +
> +     return EFI_SUCCESS;
> +}

add_table() can only ever return EFI_SUCCESS, so every 'if (ret !=
EFI_SUCCESS) goto err_out' that follows is dead. Either make it void,
or maybe have it bounds-check *table_count against max_tables and
return EFI_BUFFER_TOO_SMALL on overflow; otherwise a malformed
RSDT/XSDT that lies about its length could walk past the allocation.

> diff --git a/lib/efi_loader/acpidump.c b/lib/efi_loader/acpidump.c
> @@ -0,0 +1,563 @@
> +             ret = bs->allocate_pool(EFI_LOADER_DATA, tables[i].len,
> +                                    (void **)&buf);
> +             if (ret != EFI_SUCCESS) {
> +                     error(u"Out of memory\r\n");
> +                     break;
> +             }
> +
> +             memcpy(buf, (void *)tables[i].addr, tables[i].len);
> +             ret = save_file(filename, buf, tables[i].len);

The intermediate buffer looks superfluous - save_file() only reads
from buf and passes it to file->write(). You can drop the
allocate_pool/memcpy/free_pool and pass (void *)tables[i].addr
directly. That also removes the only failure path between collecting
and writing.

> diff --git a/lib/efi_loader/acpidump.c b/lib/efi_loader/acpidump.c
> @@ -0,0 +1,563 @@
> +static void u32_to_utf16_dec(u16 *dst, efi_uintn_t dst_size, u32 val)
> +{
> +     append_uint_dec(dst, 0, dst_size, val);
> +}

Single-call wrapper around append_uint_dec() with pos=0; the only
caller is do_check(). Please just call append_uint_dec() directly and
drop the helper.

> diff --git a/lib/efi_loader/acpidump.c b/lib/efi_loader/acpidump.c
> @@ -0,0 +1,563 @@
> +static void build_table_filename(const char *sig, u32 instance, u16 *name,
> +                              efi_uintn_t name_size)
> +{
> +     efi_uintn_t pos = 0;
> +     int i;
> +
> +     if (!name_size)
> +             return;
> +
> +     for (i = 0; i < 4 && pos + 1 < name_size; ++i)
> +             name[pos++] = is_filename_char(sig[i]) ? (u16)sig[i] : u'_';
> +
> +     if (instance)
> +             pos = append_uint_dec(name, pos, name_size, instance);
> +
> +     if (pos + 4 < name_size) {
> +             name[pos++] = u'.';
> +             name[pos++] = u'd';
> +             name[pos++] = u'a';
> +             name[pos++] = u't';
> +     }
> +     name[pos] = 0;
> +}

If name_size is too small for the .dat suffix, the function silently
produces a filename with no extension. In the current tree that can't
happen...but better to return an error/bool, or guarantee correctness
by sizing name_size appropriately and dropping the conditional.

> diff --git a/lib/efi_loader/acpidump.c b/lib/efi_loader/acpidump.c
> @@ -0,0 +1,563 @@
> +    efi_loader: add ACPI table dump EFI app
> +
> +    Provide an EFI binary that can dump all ACPI tables to files
> +    <table_name>.dat. These can then be further analyzed by decompiling
> +    with iasl.

The commit message could usefully mention the two interactive commands
(check and write), the duplicate-signature numbering scheme, and that
DSDT/FACS are pulled in via FADT so the output matches 'acpidump -b'.
Right now the design choices are visible only in the code.

Regards,
Simon
