Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3886C5CFC1
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 18:45:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9055E408A5;
	Sat, 15 Aug 2026 18:45:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VcPoytNvwQhV; Sat, 15 Aug 2026 18:45:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8854140838
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786819525;
	bh=AC3bLtj4naxooA+6Zggm2AP181A4g5EdNV09+3mPJXs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cZJaOeJMP91uTvqfFeWzqs9XJQJce/zfQdy0kVR2jlB+tvrGdlhLygTOKw/3sjStH
	 12Kj/2vLwpeiCRSKl2+BGthYMqA4tM19+opmPixHHd5dAgBluUHyxd7GOCVUOLXUB4
	 xjK2Tt8YEXpESoRAdphSLaHNPp2bmsbMWMXBaMIrDnlqERqhjduMx3oqm6IOwZQpgI
	 fB4BVLGDEBZCX+w78ZSLUqYjCD3X9R8HLqAnh+ZCaOzqUarb9sgUyjmfVQX4W8RMI/
	 uN2N5KmZYuvtHGlK7c8Je7cGVmARZL7A/vaLUZOcWNIwMBwP2BI/T+c5/hd0aH1dmT
	 CxbjXj2h/T+YA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8854140838;
	Sat, 15 Aug 2026 18:45:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A78B62BB
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 18:45:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9687B400CB
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 18:45:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sGwTjNJyDjUP for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 18:45:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A916A4008C
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A916A4008C
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lpYS8LKI
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A916A4008C
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 18:45:23 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4a28cbdso3495207a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 11:45:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786819521; cv=none;
 d=google.com; s=arc-20260327;
 b=ASrc1n4AlDttXFebmZ/2txHyU5/Bg+tACvTQseEVCsZ0pDpFur5Gc6DVJuRX/SH9Cd
 6NPMwHCezlsyeZR+P2jrludEgaaeHSbd+4rB/NEcajLjXzeXGUcafUymheO1NmnSq4kC
 WT/SkwxNcq2wDR0Az68ViS7tLOqcx/UWlwtGuqVM8Sh2yiBssPMdHNnLjy0SubrkqcMn
 w8j7cI2cchMATYpW/vFYfEZQIAzFKhkOoL0Y8XnipsVq9DtSvVTHxCbbhgY7uGGHkxkj
 LajnTR6C+bexs7XtlO4vJs0A1AxUP9ugQVitOuZ+iw/6B1C3WtmI2w4U+lJkOQL7LP5Z
 PksA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AC3bLtj4naxooA+6Zggm2AP181A4g5EdNV09+3mPJXs=;
 fh=lMu/IoIlTfGI1wvkQqdTjRQJTv1loZZGdihE0p1XJi0=;
 b=avNfCdD5kc5La93S8eqRDuAC++oCGQ7A1xd+3sdZSNU47DI4u5bjuQv8r4hoSFrb+g
 QuZEZsU2NyHrEzcKCATz/gc6SCIU1XL04UBOOKJ8rGmiB2QzbbNF6LdBXB2Ta1BnJ8Wc
 4zZKZkpkJWdTssk16pg5POputl78BGi84mb1apQJJsBpTG/fjkgtDiqUc70/XGaTmKdb
 WderI5GJL7vMorpfEkSwKCxLZqVpnrxgzKLBC19LAu0+NsKWGviaziZRwEZV1jcB21r7
 luGs4StbYx71JtYi8e2awuWW7modwES6rpz3osK5iZXCYJKsMsbVdcmeUh8g19XkH3mC
 dEoA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786819521; x=1787424321;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AC3bLtj4naxooA+6Zggm2AP181A4g5EdNV09+3mPJXs=;
 b=lpYS8LKIWeleCcYbaTryxQ+hThPiztnpzfLFPgqgGVWHooLt4JC8QYsBXi/fsZZuJY
 lhb38bXPI9TPnxnkkXFkYhXq9ki+M1LZWVuTUnIEm7zF/8/aPgyiVmPFUQg1v434XcnL
 0ijWRUoeZPgVhUk9iMTdd6P7LCnTOVcOfi190=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786819521; x=1787424321;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AC3bLtj4naxooA+6Zggm2AP181A4g5EdNV09+3mPJXs=;
 b=OarEQc4SpTGRvVmgJJp+4wWY6lkAtKJpIn283wWWwGpWfXxztMvPtWvfJ7Wb85EbVE
 IivFRwM61PJaXIHmc3M8DYBqkG3z1t+2SO7GNt5IhuD6wEy/dvPqs8IINsLLjlPUNb+7
 HvbUrHkYX+1TytGxsceXWGy+TOciYEB+TOGAknvsz3H9jo1dOLkfwcUq/DLp+SYdzQok
 4z1LgI7MFvxP4zLnuvycF4A1SJbCTpbWMzs5jnJevg7ZIIgdQAb3ZFjYWj+zw+ce18JS
 NjfOrdVupSTsLnP1yJFXZmt/jzLg/A6I0fevcLhwt7a41bfIZER911DcLwKWnk9n3tTf
 l/kA==
X-Gm-Message-State: AOJu0Yx+6M8aGOUVO6nJRRcIn3fs+YbztPnP3T8dfkhofIj0lJLXf3MN
 rSHxjC0YzhRNvVjStfaWjmUICmfGdM+jxd6iAWVB3d+HWHC4RtcyyM73Cfor7rccnFZOw8L+mrs
 QfyT3b5LYjIaUFyGJLgL10Hp1ixHAN6DCx/B1V145
X-Gm-Gg: AR+sD13rd1OMCl8tpnNSMwKdzHlkgrQM4ZjjT0VJIj59e5bC+M3kT9FFQGAi2+ANMxI
 I8aigICNZ61UoR09Yd0nj7W98Ged5l4oIeUBjuK8sd83FGCw0L7aDkwMjeWtXJb/XeLfA6IgIKD
 4EB9yjgEoVir1D40Do/w+/2rLdSRNRj1TQXBzvKNOWT+2luGWNVFpj0Iv8/buVDP7cJOgO14RDc
 2hKiCZd9UN2LPD3eppHKMcT3kHJDszgi544z6boe6FZvKWEcwF9VMerftj2ED62RiLX0RCjRHiI
 k/p1vTYsDItzuZ7rChffpN+Jg4d/jiCsuaAXfxReIaVKnOxqeVkAlA==
X-Received: by 2002:a05:6402:2811:b0:698:3602:d0d with SMTP id
 4fb4d7f45d1cf-6a38a9843c0mr5964726a12.17.1786819521260; Sat, 15 Aug 2026
 11:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260728-ccaione-upstream-ebbr-v2-0-4efb529140d6@baylibre.com>
 <20260728-ccaione-upstream-ebbr-v2-5-4efb529140d6@baylibre.com>
In-Reply-To: <20260728-ccaione-upstream-ebbr-v2-5-4efb529140d6@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Aug 2026 12:45:08 -0600
X-Gm-Features: AcwNN1UcObPG1shUahQqpXkQi4DPHcHOvmk8QR1Qsmjo3SHzOeEa-0SMHDaoYN0
Message-ID: <CAFLszThP6P+xStcoAk_OFmeczdSJ_O6kgcUV787YAt9iz+j9MA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] test: boot: add firmware-FDT source tests
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
> test: boot: add firmware-FDT source tests
>
> Add sandbox coverage for firmware_fdt_load(). The Python fixture creates
> mmc11.img in persistent_data_dir with A/B firmware partitions. Its first
> FAT partition carries FITs for a base-plus-overlay configuration,
> compatible best-match, external-data rejection and corrupt-hash rejection.
>
> Construct the complete MMC provider and firmware-FDT source topology in
> each flat-tree test, including the provider phandle. Nothing is added to
> the shared sandbox control devicetree, and the sandbox test framework
> restores its FDT snapshot even when an assertion fails.
>
> Cover default and explicit configuration selection, compatible best-match,
> owned and borrowed assembled-FDT storage, EFI staging and its returned
> filename, and the fail-closed cases: corrupt base or overlay data,
> configuration chaining, a missing configuration or partition, an invalid
> source phandle, external data and mismatched partition selectors. Verify
> that only a genuinely absent source returns -ENOENT.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
>
> configs/sandbox_defconfig |   1 +
>  test/boot/Makefile        |   1 +
>  test/boot/firmware_fdt.c  | 411 ++++++++++++++++++++++++++++++++++++++++++++++
>  test/py/tests/test_ut.py  | 181 ++++++++++++++++++++
>  4 files changed, 594 insertions(+)

> diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
> @@ -614,6 +614,186 @@ def setup_rauc_image(ubman):
> +def setup_firmware_fdt_image(ubman):
> +    """Create mmc11.img for the firmware_fdt tests
> +
> +    A GPT disk with two firmware partitions (A/B) sharing a firmware type
> +    UUID; partition 1 (label 'firmware') holds a FAT filesystem with the
> +    FIT (fdt.itb) carrying a base DTB and an overlay, with two
> +    configurations: the default applies the overlay, 'conf-base' does not.
> +    """

The docstring only mentions fdt.itb, but the fixture also builds
fdt-best.itb, fdt-ext.itb, fdt-corrupt.itb and
fdt-corrupt-overlay.itb. Please extend it so a reader knows the FAT
holds five FITs without digging through the body.

> diff --git a/test/boot/firmware_fdt.c b/test/boot/firmware_fdt.c
> @@ -0,0 +1,411 @@
> +/* A corrupted base fails hash verification and cannot fall back */
> +static int firmware_fdt_test_corrupt(struct unit_test_state *uts)

There is no coverage for the case where the source is configured, the
partition is found, but the named FIT file does not exist on the
filesystem. That drops through fs_size() in fw_fdt_read_fit() and is
remapped to -ENODEV by fw_fdt_load_source(); worth pinning that
behaviour so a future refactor cannot silently turn "FIT missing" back
into a fall-back -ENOENT. Please add one, e.g. by setting filename to
something not present on the FAT.

> diff --git a/test/boot/firmware_fdt.c b/test/boot/firmware_fdt.c
> @@ -0,0 +1,411 @@
> +/*
> + * Without a source node, -ENOENT is the only result which lets callers fall
> + * back. This also proves the provider alone does not configure the feature.
> + */
> +static int firmware_fdt_test_no_source(struct unit_test_state *uts)
> +{
> +     struct firmware_fdt fw;
> +
> +     ut_assertok(fwfdt_configure(uts, false));
> +     ut_assertok(fwfdt_bind_mmc(uts));
> +
> +     ut_asserteq(-ENOENT, firmware_fdt_load(&fw));
> +     /* Source detection precedes address validation in the EFI helper */
> +     ut_asserteq(-ENOENT, efi_stage_firmware_fdt(0, NULL, NULL));
> +
> +     return 0;
> +}

This is the only test which omits the trailing fwfdt_clear_env() call.
Harmless here since nothing was set, but worth keeping the pattern
uniform so a future change that starts poking at the environment does
not leak between tests.

Regards,
Simon
