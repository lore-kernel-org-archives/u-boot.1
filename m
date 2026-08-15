Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE7AC5CFC1
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 18:45:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F217D80E92;
	Sat, 15 Aug 2026 18:45:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id InKHytT4Qn-n; Sat, 15 Aug 2026 18:45:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 593B380E78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786819517;
	bh=yPw/0SZlm8VA5iSV6TSQhCuVG4AdiHT152foWo+UqZs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qE5QZpJpsn1A5q++/+Askkjz4DKsH8W9X9uAl9EgivoqP+Gfppw8bEdZR/D2nbdRl
	 XWbdvZf4qPzm6aauwAbWZJaBZOsNq8f8Y8wSAfroEgOVW+R1KLsF45ADBrWUSxhAsI
	 7Ys1xtZhribrMCwr4ddUNj+qWfQNbblmworghxMKV2vGMmOBW55XwtH4TjXDObFv8c
	 eEF2kZxBN8pyf13ee/nZVGa+AhSCE317F692A0sxD20Ye0lIfVHitkPQbg5Ab7+Rbl
	 C4CYf0Huk2lsSrAzYy+r2z2UT9IxxE1+Z450845kUH4SGMUKMLalh5kqtANdWT5fOj
	 cqorhciM1LEAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 593B380E78;
	Sat, 15 Aug 2026 18:45:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4694B2BB
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 18:45:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 299E860641
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 18:45:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FIz4Q-lAkwBc for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 18:45:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2569A605E5
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2569A605E5
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=VD4Mevnd
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2569A605E5
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 18:45:14 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6a20319d030so2847633a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 11:45:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786819513; cv=none;
 d=google.com; s=arc-20260327;
 b=Heg8K2xEiPP4o5+gyWqsUJRz3UCoJgd1gvDvn939XgXpCyNyn3yr47RASxg3fE2iWI
 RnVgHRCccsO7ZCu72JrcEuwCnlLbLb2HpqfVoFiQSLNSwuo8IIGy+pOq++zlOnxitiPh
 GbgwsB93VruxjnA+humTwe2rXqUGTXc3uw/DZebtarN2CGKND3HAldX9XW+j1fHWGUzB
 xM2VFZhqLzqOOh1wwhV6QD3FImhd5Eujl/updw3AkYYLcEhLX3T5tHrkUL490K8L+vsA
 52Y/o/7ahMRb0t1c82YH9iRfP2EjJS05lA0Si3MrrlzuvcmoWnTtmFrlV0bczUe+S8Lq
 ijzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yPw/0SZlm8VA5iSV6TSQhCuVG4AdiHT152foWo+UqZs=;
 fh=lMu/IoIlTfGI1wvkQqdTjRQJTv1loZZGdihE0p1XJi0=;
 b=Dae1XmrEoXkcc1LOe64Wp+J4ZTjeynWXRJrAMzxPotPwofBj+FPqhLPkt7Ch9btOXb
 hoFXaUddqadIJ8wT9KQa7021naZ9/BdUVr/ZHbv2dycenTSB/HrakQr7YvBVtS/EiBCO
 eA3lXsGThdeQ9r6DAZjvfP69UicUDTB77/s19Dv4qo0hsl3UlxvKzxJVb6KBfATzclL1
 9H4f6sbW8WMvG0cEmIgiWJXnbV6P5S5U7LyHYnPeDAv+B4Waeg0C2TXpk/YBpuahscws
 bbPlok09HWJdrsC+cjLBJq6rODNktcPZ8pzd/oZfVjQGLzDDnqatVYLDRaPJW5KNA398
 98RQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786819513; x=1787424313;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yPw/0SZlm8VA5iSV6TSQhCuVG4AdiHT152foWo+UqZs=;
 b=VD4Mevnd6qnwSqLS+4VpEXd0PAODEl4rrNdkYarcyMC6nq3ixq+Ogh2B3cJxs8QA1+
 XJf8Kr2ey99Poz/QC5J8/pc8nLMLToHwpMvcgFUrxoh5Ea3OMnbvMX25fa61Zxigu2yj
 fHyuBjFLpURwIZpnH6W4Tc+7vwq7tFIRTJ+ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786819513; x=1787424313;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yPw/0SZlm8VA5iSV6TSQhCuVG4AdiHT152foWo+UqZs=;
 b=i7Rs9107yYV1u/heimrlc4BygC7vflUhb4BFrduUtjtLqLZnAQ8YOA6SW8Y9jdUL55
 xhvB6kMx35ctYKdIvwzxc/Ho6ZYdviz/OgohFoIdTP0/dTMUJmQGLfQmQwijaS6qV0Iv
 5nFLSliXu42VpXV1gWe6wqY14YNh6zzQpZktJ7njvM5V+Y+23kV7nuvOZbeCdVDQqyWF
 92k0pRl3mifTKw9MoKFLgp3woM/GSpWLCeiM6rkUzRLExKkWIASsYAxkktRANN+Ft5pN
 cRHnLCcbAT4FqvDT/PRWhj/Kz6bSL0wJmjQJnmDKJrZqs+/lTjAxUXETIzBZD0l0VEN/
 +/MA==
X-Gm-Message-State: AOJu0YybgRpS1J7iZcELOtTcESdd98MpUpE9HA0hsHRYEwpBVLhea13v
 VCRYqG1igVbbIUBCK+VpA8pxjjwRmWzrLK9drKowEy2oE5PQCg2ronwwLKjy2zAo5oJc0MKkTel
 VFSvohq6MTHS+NKv+gDRG392w68MYRd5URAA3/tVG
X-Gm-Gg: AR+sD10InrcDd+cx8W4dMFwa5EHJwOPxwe93eVMctE8xRZm6Vr35i8vzJv+9wkg2XbC
 W031YVlSxAFn4SZIxbLyi4d03a0VALbCovLZLWZdnc6teSQKuHyTAwQOHSGPLE+DvtcIY7nJATg
 vhQocyMFHT+ovMKYZ1/V2Ow1vKZLDGXHHv4lfu+VS3pV6hu2txFhsJuRAbEtKVreLkhAYHnKfwg
 z5lJGnxEo5a/ffYCp84/jpN3eqf48BKbL9XMHsv1c6GioEp2q8CpNyJOStljzkZlBsrPMd2yzbF
 St8Eu0KJLJzvVjC9QvKZMw3peK4738fuhddjfjZlB9k=
X-Received: by 2002:a05:6402:11d2:b0:6a0:9a26:976b with SMTP id
 4fb4d7f45d1cf-6a38a90c815mr6919575a12.8.1786819513165; Sat, 15 Aug 2026
 11:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260728-ccaione-upstream-ebbr-v2-0-4efb529140d6@baylibre.com>
 <20260728-ccaione-upstream-ebbr-v2-2-4efb529140d6@baylibre.com>
In-Reply-To: <20260728-ccaione-upstream-ebbr-v2-2-4efb529140d6@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Aug 2026 12:44:59 -0600
X-Gm-Features: AcwNN1W4Tb7zQhAk0bhqsW_ia7mh9nsroOAyYZRRbNp8dmOk2e0ZVCIva3V_EzI
Message-ID: <CAFLszTgo4Wq9=1yyVnwM0ObK4E2Rvy2WbW2mU2tEtNBQjbQ2+w@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] boot: add a firmware-owned devicetree source
To: ccaione@baylibre.com
Cc: u-boot@lists.u-boot-project.org, Ahmad Fatoum <a.fatoum@barebox.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Johan Jonker <jbx6244@gmail.com>,
 Randolph Sapp <rs@ti.com>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Carlo,

On 2026-07-28T13:20:42, Carlo Caione <ccaione@baylibre.com> wrote:
> boot: add a firmware-owned devicetree source
>
> Platforms following EBBR / Arm SystemReady IR keep the devicetree on a
> firmware-owned partition, updated independently of the operating system,
> rather than shipping it in the OS image. U-Boot has no generic way to
> source and assemble a devicetree from such a partition.
>
> Add firmware_fdt_load(), a loader for a FIT from a firmware-owned
> devicetree source. The FIT images hold the base DTB and its overlays,
> while each configuration names one valid combination through its standard
> 'fdt' property. Select an explicit 'fw_fdt_config' when set, otherwise
> use compatible best-match against the control devicetree and fall back to
> the FIT default.
>
> Describe the source with a standalone control-DT node. This patch
> implements the first source backend, 'u-boot,firmware-fdt-block', which
> reads the FIT from a filesystem on a GPT partition of a block device:
>
>     firmware-fdt {
>         compatible = "u-boot,firmware-fdt-block";
> [...]
>
> MAINTAINERS                               |   3 +
>  boot/Kconfig                              |  24 ++
>  boot/Makefile                             |   1 +
>  boot/firmware_fdt.c                       | 420 ++++++++++++++++++++++++++++++
>  boot/image-fdt.c                          |   3 +-
>  boot/image-fit.c                          |   9 +-
>  doc/develop/uefi/firmware_fdt.rst         | 112 ++++++++
>  doc/develop/uefi/index.rst                |   1 +
>  doc/device-tree-bindings/firmware-fdt.txt | 150 +++++++++++
>  doc/usage/environment.rst                 |  11 +
>  include/firmware_fdt.h                    |  95 +++++++
>  include/image.h                           |   4 +-
>  12 files changed, 829 insertions(+), 4 deletions(-)

> diff --git a/boot/firmware_fdt.c b/boot/firmware_fdt.c
> @@ -0,0 +1,420 @@
> +static int fw_fdt_get_source(ofnode *srcp)
> +{
> +     ofnode node;
> +
> +     node = ofnode_by_compatible(ofnode_null(), FW_FDT_COMPAT_BLOCK);
> +     while (ofnode_valid(node) && !ofnode_is_enabled(node))
> +             node = ofnode_by_compatible(node, FW_FDT_COMPAT_BLOCK);
> +
> +     if (!ofnode_valid(node))
> +             return -ENOENT;
> +
> +     *srcp = node;
> +
> +     return 0;
> +}

If a control DT has two enabled u-boot,firmware-fdt-block nodes this
silently picks the first, which is traversal-order dependent and hard
to debug. Is your intention that only one is permitted?

Also, wouldn't it be better to make this a driver so that driver model
can handle discovery, binding, etc.?

> diff --git a/boot/firmware_fdt.c b/boot/firmware_fdt.c
> @@ -0,0 +1,420 @@
> +     fdt = map_sysmem(data, len);
> +
> +     out->fdt = fdt;
> +     out->size = len;
> +
> +     if (len > FIRMWARE_FDT_MAX_SIZE)
> +             return log_msg_ret("bigfdt", -E2BIG);
> +
> +     ret = fdt_check_full(fdt, len);
> +     if (ret)
> +             return log_msg_ret("chk", -EINVAL);
> +
> +     out->name = strdup(fname);

Size and integrity checks belong before the assignments to out->fdt / out->size

> diff --git a/include/firmware_fdt.h b/include/firmware_fdt.h
> @@ -0,0 +1,95 @@
> +/* Maximum size of both the firmware FIT and the assembled devicetree */
> +#define FIRMWARE_FDT_MAX_SIZE        SZ_4M

4 MiB is a policy decision - some platforms will want a smaller cap,
others may need more once overlays multiply. Please make this a
Kconfig knob (default SZ_4M) so boards can tune it without patching a
header. The name also implies an FDT-only limit while the comment says
it covers the FIT too; FIRMWARE_FDT_FIT_MAX_SIZE would be less
surprising.

> diff --git a/boot/firmware_fdt.c b/boot/firmware_fdt.c
> @@ -0,0 +1,420 @@
> +     if (namep) {
> +             name = strdup(fw.name);
> +             if (!name) {
> +                     ret = -ENOMEM;
> +                     goto out;
> +             }
> +     }

fw.name is itself a strdup() of the FIT filename made inside
fw_fdt_assemble(); duplicating it a second time here just so
firmware_fdt_free() can free the original is wasteful. Consider
transferring ownership - pass fw.name out and clear it in the struct
so firmware_fdt_free() leaves it alone - or don't allocate fw.name
until it is needed.

> diff --git a/include/image.h b/include/image.h
> @@ -719,12 +719,14 @@ int boot_get_setup_fit(struct bootm_headers *images, uint8_t arch,
> + * @param ownedp     Returns true if the loaded image is separately allocated
> + *                   and must be freed by the caller, or NULL

The "or NULL" trails 'must be freed by the caller' and reads as if the
returned image can be NULL. It refers to the parameter itself being
optional - please reword as a separate sentence, e.g. 'may be NULL if
the caller does not need this information'.

Regards,
Simon
