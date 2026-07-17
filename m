Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420FEC4451C
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 13:49:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9212784E3F;
	Fri, 17 Jul 2026 15:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ODovXN19";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFC0984E42; Fri, 17 Jul 2026 15:49:30 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94DD384DAA
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 15:49:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-8485bd28dd0so9199051b3a.2
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 06:49:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784296167; cv=none;
 d=google.com; s=arc-20260327;
 b=pvCEOr/lwL8umrEog5chS51L6Rw3/fB10JRgmfpqlicTRmwHU58x4BdS2+kXJEzaUR
 RfPBdo0Lc4G1HQa/dc9d4uBUx478bCsKaU1Q08czpYgx5fIGIXY9f7FVhf5XJDoXqs2z
 r69JazKhEu2HHO6eCJnprumnF6ncCS28q0ys4NpRQcUHgLfWK9AAYJVtzIajTsrkwVA6
 IBAVn8YSLVVTyqeWCt1/nON7nrdMA9YM3qFyCoBqyAlQo1ziRYXgzpttyKEIq0rkKE81
 08okq41e34/V31j0QnOBLHeay/BTRnJ+4FwjCSOcgvy3Cxc9oM6Zc86gu9LahG/8s6ne
 9RMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dl5VNIyh9FlWG3euNH7OBA9eLlgIpgtUq8aKpOEc9u0=;
 fh=di/tjh9gdyTl8BuYYPeR5CeC8Ml8xFjWsLim5p9otUk=;
 b=fi4+NTg+M0WC31IqM9iFuYfjrck8rofns3IYZpkyhtiidTVTdWsJPnTT0txpUOd/ve
 sJ6/qs5DspeVcMnFI7YNddaLar9vI20SvpZfcQjZiTKvVaE5+vOS+biT2iP59IeXHZhj
 niEFvCfFU6c3kKZNRusVLE/FhhRocEAgMp/Yu5OrCzbHTMrieHfaBL+MCHpY/kb06x8J
 Fd6b42UQ1DU009H/HatWTPFKVCveVICqcAzunF2pTtx/EBHFKkHjNuqIjBt4EHGWitvW
 rLNA1x7eY/LejymCxb0kMJdyeulFOsWD7I0v5L0CABt7qF03HB/gsoFlOWiaapVm++42
 XqdA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784296167; x=1784900967; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dl5VNIyh9FlWG3euNH7OBA9eLlgIpgtUq8aKpOEc9u0=;
 b=ODovXN19a5chau3Wf0P+9NsmTHXxFCPLrNZi0YrGs1tuPbEXnE92ZBv5KQajDdDYIc
 1D9mrOmOoYI+jSY/reIKq5lGsbau9LjiwLfeP1wlEcUkZs8xUqZgv7LFmo7fmbwQPU90
 brlETkbu8ZHjZwYTkdMoRRyC3jXMKwBw/3RI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784296167; x=1784900967;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dl5VNIyh9FlWG3euNH7OBA9eLlgIpgtUq8aKpOEc9u0=;
 b=tVey4JIApFzT7jQGwnKiR3QTqQFJSbhckzQiEcEGN7ufhQzvu4Htg7vKfEvJLpG35s
 vIb3c5vMyga8leA9eHVAx260Um+1UaYmIrD7iAdnr1rN/5u1hlvTqNnqseHe2xDWkngc
 fOlfAwZnaBXQHCRgbKMRlLaz6HuvMI2tS3mRoCDnuG7pnmieL1wDbX8IJ4dJ+qS9XGlP
 hbHIA4h0sOyBD3qaDxVzScyd9GaPhD9XuZvu0pW7A0UDyNn0f6f20l58ISp+Y6sGznI9
 ezq8Shr+VLFs4/8C7kT8phyfnUlxKk/ZSlOaCAL/TT408d160NJc1r8nk5s5n5IYgVTP
 zrCw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrLi3BY4wyEw46rTYkxMeekwXJ/3TqLbpV6x67S8zH7MObf5bpl2R16Z9zy6hd7RZe47rJLpfQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yypad4P6IRSGH5iycE70AZ5BsTwVRLzZuaY3LdJWPQ7yQQsdhV1
 tT1qf4UB8SgiPoZj4qemFobSDRv9qFV/M4bBcU9c1bB3Grt7Zp+N1uQ3R//V/4cSfXfUNHuGVXs
 wpAk/YXCkI+CTT3nR9/RvO3sfuQSwK1e+0d+70z3A
X-Gm-Gg: AfdE7cm9/pebsiQ+o/KQPKAz/hwG6Ip+9zzDX/sCCzuzXymn/zTGd4Q0aaXZjvtyHQV
 vzgknbvAI/75aJremabecyc0rwyfsgVUwNUDmdk6RY57L1ZEbTzDfbbjIxG6muiId9FX0YI8T+i
 4yeprpsHhcLxewrsvnc7edeHtfJgQ8CKT06CYF0kfigYHgu8PfiepGcw+bU5VA3wMc5Agk+d8hd
 xWkWrNBQ3XnqbwNa6gxIFA1fMDZ//mRy3nFrozyZwvFkrAIipQkYAQwDgEakoyCjlPoEjM=
X-Received: by 2002:a05:6a00:240e:b0:848:79aa:5d37 with SMTP id
 d2e1a72fcca58-84c294fc710mr2845438b3a.55.1784296166859; Fri, 17 Jul 2026
 06:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260715134049.85424-1-jayaramudu.desapogu@amd.com>
In-Reply-To: <20260715134049.85424-1-jayaramudu.desapogu@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Jul 2026 07:49:09 -0600
X-Gm-Features: AUfX_mx9NPrk9tNEku23NQCtxsGdJHmaNhVuFJBtWahBkh4elaeBkr2aNqd74qk
Message-ID: <CAFLszTjSDn+q2dWN+sXmi7T=hzsfxjQ8VO+SyZgasVs7nocvUA@mail.gmail.com>
Subject: Re: [PATCH v2] acpi: fix no display when serial console is disabled
 in coreboot config
To: jayaramudu.desapogu@amd.com
Cc: sjg@chromium.org, trini@konsulko.com, u-boot@lists.denx.de
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

Hi Desapogu,

On 2026-07-15T13:40:49, Desapogu Jayaramudu <jayaramudu.desapogu@amd.com> wrote:
> acpi: fix no display when serial console is disabled in coreboot config
>
> From: Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
>
> When the serial console is disabled in coreboot configuration,
> no display output is observed during boot.
>
> coreboot can expose serial console/debug-port information either through
> coreboot tables(lb_serial) in src/lib/coreboot_table.c or through
> ACPI DBG2 tables(RSDT/XSDT) during write_acpi_tables().When coreboot generates
> a DBG2 table,it is publishing UART/debug-port information (IO or MMIO) through
> ACPI for the operating system.By default coreboot assigned subtype
> (ACPI_DBG2_PORT_SERIAL_16550 = 0x12)for both IO/MEM in src/acpi/acpi.c.
>
> U-Boot as a coreboot payload consumes serial data either from coreboot table or
> ACPI DBG2.When serial console is disabled in coreboot config , the coreboot table
> contains no serial data.So U-boot fallback and check the ACPI DBG2 table for UART
> serial console using read_dbg2() to find port type and subtype.Currently u-boot
> reads subtype as 0x12.But u-boot in include/acpi/acpi_table.h subtype defined as
> 0x0000 this value suppots only port I/O as per microsoft DBG2. For AMD platforms
> [...]
>
> drivers/serial/serial_coreboot.c | 2 +-
>  include/acpi/acpi_table.h        | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)

> acpi: fix no display when serial console is disabled in coreboot config

The change is mostly in drivers/serial, so please use a 'serial:
coreboot:' prefix. The subject is also over the 60-character limit -
something like 'serial: coreboot: Accept DBG2 subtype 0x12' would do.

> From: Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>

The commit author is 'jayaram <jayaram@BLRJDESAPOG1.amd.com>', which
looks like a local machine account. Please can you set git user.name
and user.email to match your Signed-off-by, so this From: line is not
needed.

> U-Boot as a coreboot payload consumes serial data either from coreboot table or
> ACPI DBG2.When serial console is disabled in coreboot config , the coreboot table

Please can you tidy up the commit message: add a space after full
stops and commas ('DBG2.When', 'config ,'), use 'U-Boot' consistently
and wrap lines at 72 columns.

> diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
> @@ -668,6 +668,7 @@ struct __packed acpi_dmar {
>  #define ACPI_DBG2_16550_COMPATIBLE   0x0000
> +#define ACPI_DBG2_16550_GAS             0x0012
>  #define ACPI_DBG2_16550_SUBSET               0x0001

Please keep this list sorted by value (after ACPI_DBG2_BCM2835) and
use a tab for alignment like the other entries. The DBG2 spec calls
0x0012 '16550-compatible with parameters defined in Generic Address
Structure', so perhaps ACPI_DBG2_16550_WITH_GAS, with a short comment
giving the spec description.

> diff --git a/drivers/serial/serial_coreboot.c b/drivers/serial/serial_coreboot.c
> @@ -59,7 +59,7 @@ static int read_dbg2(struct ns16550_plat *plat)
> -     if (dbg->port_subtype != ACPI_DBG2_16550_COMPATIBLE) {
> +     if (dbg->port_subtype != ACPI_DBG2_16550_COMPATIBLE && dbg->port_subtype != ACPI_DBG2_16550_GAS) {

Just to check the semantics: for subtype 0x12 the access parameters
are supposed to come from the GAS, yet the code below still hard-codes
plat->reg_width = 4 (with the comment that coreboot sets bit_width to
0) and derives reg_shift from access_size with a coreboot-specific
adjustment. Does coreboot fill in the GAS the same way for 0x12 on
your AMD platforms? If the GAS values are valid for this subtype, it
would be better to honour them (bit_width, access_size) rather than
relying on the workaround. What do you think? This could be a
follow-up patch, if needed.

Also please wrap this line to stay within 80 columns, e.g.

    if (dbg->port_subtype != ACPI_DBG2_16550_COMPATIBLE &&
        dbg->port_subtype != ACPI_DBG2_16550_WITH_GAS) {

Regards,
Simon
