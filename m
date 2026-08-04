Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A55EC55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 13:11:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0AE280C85;
	Tue,  4 Aug 2026 13:11:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L-wl_i_atAcV; Tue,  4 Aug 2026 13:11:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EF43C80CA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785849077;
	bh=MCX5ys/j+yBiAmmRvWYDUY6ZnuCVxHHN9yLe5yQGtlI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RE0dGBj/Ru3fsCbKMBpxtyiXRE7C+ygxmlkKegEOyvhrS6I25v3RLDVDIRA7vWWQF
	 WYIXKIF7kYfTkse2skAYgWz2HoTYGn+pRptLUeNM7BG1tfi3pqn9ZTlOuK5nF5hlZi
	 XKYt/RbAnmH7AYd5KUhJOid9m7ULkUxPCGFg8gXhI8Rel95u/b4cdOdBO1Ygt/A0r/
	 sZ0UyB+inZJYCskxYg8hy+N8FMQ+6Fm4/doQKrKWyv2tWLPDWW9UGHsyHyxpAmVf88
	 pDsVlVa/a3gzrFBZOtAFSxWSQMKFn7CR6RJVW+ZAKIaYFC8jzS3fck6B12Dbms+9eq
	 mvWy57gG9tDRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF43C80CA8;
	Tue,  4 Aug 2026 13:11:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 32E7D2BF
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:03:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 24FFA405AD
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:03:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SbX6JuHvt_Au for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 13:03:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1887240189
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1887240189
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1887240189
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:03:22 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-69c108fee7fso6558384a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 06:03:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785848601; cv=none;
 d=google.com; s=arc-20260327;
 b=HHx7LG735kjsa3D0Fven6Zew10rBQBK77uim9zxK1p/PlgGix3PM0EavXW5Kk/vdMH
 uZvRG2bra+8ABl48vNzW5AZ/Tg1rA5ILMf+I/iitQ3gbOWRP7+LQCvhGe1PkCBvnxAxX
 Z50VZf/KYZcBhG4M3tSBTEhC0WUfd1mGRgDuqmjNcyg+CaMY1yD86KUIjMwoXY21UTzb
 FsrjLTq6bYBJxZ0WRLLa8OL0qRta9YiAxsZX798cri3HP4MDoWPrWBVqKSZpHZnwhbKJ
 qumtDgHZCHztUFAdStYOpTuvwpzqLwZ7jmwBbePQMRFEQnP5X0ellGG6kCZGnHpLyIvh
 V22Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MCX5ys/j+yBiAmmRvWYDUY6ZnuCVxHHN9yLe5yQGtlI=;
 fh=hsQzq9IYCmZwK0E7cVW3p7RZJMnlUShWANxf+Zzt34k=;
 b=nMzel6iJyYsA41JD89Ir9Mnfbj1AfI7CUUnh7+YgPGyCZ2Dr3AYBmJMRbgyK0PS+Wd
 847S6sLIdPo6YTd6MPtdrkI0Da9bPto4ZwaLGYRlAdUfW4pNYbT+HxUQoBnkzuUHBy0u
 0yiMVBkXN88vVHpVjJNqhaadt0trOOl4smweuDyhI88FPrJ25JJNWfEVF3+zCCXJ7AQD
 onIXGefeV2pK+YAv4uTbe9jLRmisnKMxIOtXLQAxk9E9j2xTutriyzmL4ahRAlMHtMuR
 slXo/swrye9Ayx/k688wRn/VutN61i9XcFVJtDg/H5USvcD2N8KlbfqUEXf8qrXhRlFu
 8U+A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785848601; x=1786453401;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MCX5ys/j+yBiAmmRvWYDUY6ZnuCVxHHN9yLe5yQGtlI=;
 b=Wd4XSbtYNFbY/vESp9n+YZB3CzUptn0sLUllln9Y2A8Csrq9LSH8n3M8ThyBcsmIr4
 IvMhZDNf+XmCXwqAP4MiBKvB58+IctVKe6aiKEUxvYFVPpPQBot9tovhrcAIIBcKHcov
 VaGd7TnaYxfAJwP30e4ONtAtbbtnMr7MUbE6YJP5cJZw/NV5xNTjh/YVeQZVpJvCAfFr
 cqMmoQneke81HLtRciTkgMQUy75YXtHjWKiS+pwjItFi3T0lZFqBxBCoIyfruvNcTcy9
 qgpGLCzpIjVojrJ0augBqg4Niopvmv4mumOVkjPFQTIXQmuhWkRXxNHkZ+Fln5EMPRzq
 Fr6w==
X-Gm-Message-State: AOJu0YzUnnqM1hI4SSrPKxDHEn9X4orXPpbzaY1w5dXU822uYlt8lgym
 xlGZq3GM6b4v83wRyvxWzrKpG6Xkcbseo/QK9vl6nmYlRKadOB9xU80ZxhKZD8ZL5Pama6IRL2N
 poNdI0NH4UKtyw0EWPvwJ8+gjpg6pJwXs694c13X9
X-Gm-Gg: AR+sD13elE8BEJXi5G4/s87sjdeohT2ArZ7tf/Z62YYBpVXWI4AbUGwzOnCdvz5NBzr
 TC9LgRSSZDfXUYAIuFBv2QnnXifZI6UaTnZO8RlZ1gmhZkk8q11egHHW/vwSw/yS18MBcQS9ZzD
 gFjhqe9nMgc2j/YtQV+/ujVEC+Ydy6FC62uIfhy1Rqc+7KXqDn3gbtiuFxL2f9DB+sxhHOgMvKV
 AmXMVgYntIZ4rHqZYyxUpkM6UqdCtGyF0x7G8L88j8ssHGpDvtW2eBgZbfvyKCGX4ep7A2F4+V+
 EOPDvQznFqqnXc0jd8oM3ITD5oqfmmPtox7rqDE4ZH0=
X-Received: by 2002:a05:6402:2b8c:b0:697:decc:7f9a with SMTP id
 4fb4d7f45d1cf-6a0a7c60eb2mr11388078a12.9.1785848600972; Tue, 04 Aug 2026
 06:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-6-acb97c172993@flipper.net>
In-Reply-To: <20260731-atf-falcon-v2-6-acb97c172993@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Aug 2026 07:03:07 -0600
X-Gm-Features: AUfX_mwOiFIoxNUbEU82mrZ1Ih6G64DS0PXbEdwAXrHtdTRF5aTJoS5NY4OU9u4
Message-ID: <CAFLszTh-HpSCUjT6R+daf57YDdwgWfNun4mddqZi+jU5LTwVLw@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] binman: Add support for pre-patching FDTs in a
 FIT with a /chosen node
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Ronald Wahl <ronald.wahl@legrand.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 04 Aug 2026 13:11:06 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785848601; x=1786453401;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MCX5ys/j+yBiAmmRvWYDUY6ZnuCVxHHN9yLe5yQGtlI=;
 b=g7KhjywygUFjKSpXviERMOlSD6oECyflUurr5dRmoWYPaTrsnKRfASbxdApLGopVP3
 RlUKi7BDx+z/V250hLupL8/06yBrsgoffbcvvusdOC2ygUEFxHr/lu6KLKmi0ISV7fyB
 Jdo4EtMNihXfLEILdkHvrQxCB6HB1M7NP6FhA=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=g7Khjywy
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Alexey,

On 2026-07-31T17:10:44, Alexey Charkov <alchark@flipper.net> wrote:
> binman: Add support for pre-patching FDTs in a FIT with a /chosen node
>
> When a generated FIT is used to boot Linux directly, bypassing U-Boot
> proper (Falcon mode), there is no runtime code to discover the kernel
> command line and (optional) initrd location and include them in a FDT.
>
> To facilitate easier preparation of a ready-to-boot FIT, add support for
> pre-patching the FDTs in a FIT with a preconfigured /chosen node including
> the bootargs and initrd location.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> tools/binman/entry.py     |   8 ++++
>  tools/binman/etype/fit.py | 103 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 111 insertions(+)

> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> @@ -745,6 +779,66 @@ class Entry_fit(Entry_section):
> +        if initrd_name:
> +            entry = self._priv_entries.get(initrd_name)
> +            initrd = entry.GetData(required=False) if entry else None
> +            size = len(initrd) if initrd else 0
> +            if size:

If fit,initrd names an image that does not exist in the FIT (e.g. a
typo - 'randisk' instead of 'ramdisk'), entry is None and the initrd
fixup is silently skipped. The user ends up with a Falcon-mode image
that has no initrd, with no hint from binman as to why. Please raise
here when the referenced image is not present at all, and only fall
back to the silent skip when the entry exists but has no data (the
"optional initramfs was not supplied" case the docs mention).

> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> @@ -745,6 +779,66 @@ class Entry_fit(Entry_section):
> +                # Use the device tree's root #address-cells for the width, as
> +                # fdt_initrd() does (4 bytes per cell)
> +                cells = 4 * libfdt.check_err(
> +                    libfdt.fdt_address_cells(fdt._fdt, 0))
> +                fdt.setprop(chosen, 'linux,initrd-start',
> +                            start.to_bytes(cells, 'big'))
> +                fdt.setprop(chosen, 'linux,initrd-end',
> +                            end.to_bytes(cells, 'big'))
> +                # Reserve the initramfs region so the kernel does not reuse it
> +                libfdt.check_err(
> +                    libfdt.fdt_add_mem_rsv(fdt._fdt, start, size))

Hmm should we add address_cells() and add_mem_rsv() to the fdt
library? We should not really be going into the private attribute.

> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> @@ -302,6 +302,40 @@ class Entry_fit(Entry_section):
> +    Patching /chosen into the generated device trees
> +    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The underline is longer than the heading title - please trim it to match.

> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> @@ -302,6 +302,40 @@ class Entry_fit(Entry_section):
> +    fit,bootargs
> +        A string written to /chosen/bootargs of every generated device tree
> +        (any existing value is overwritten). Typically set to `CONFIG_BOOTARGS`
> +        via the preprocessed devicetree source.

The docs say 'any existing value is overwritten', but the
implementation guards with 'if bootargs:', so an empty fit,bootargs =
'' leaves any pre-existing /chosen/bootargs in place. Either the docs
or the code should change - I'd expect the empty case to be treated
the same as absent (leave untouched), and the docs updated to say so.

> diff --git a/tools/binman/entry.py b/tools/binman/entry.py
> @@ -636,6 +636,14 @@ class Entry(object):
> +    def GetNode(self):
> +        """Get the devicetree node which describes this entry
> +
> +        Returns:
> +            Node: Node for this entry
> +        """
> +        return self._node

Nice - good addition. There are a few existing entry._node accessors
in control.py that could be converted in a follow-up, but no need in
this series.

Regards,
Simon
