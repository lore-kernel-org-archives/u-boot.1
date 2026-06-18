Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A0ACD98F6
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 15:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8671848EB;
	Thu, 18 Jun 2026 17:52:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PdpDXa64";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 005E9849BC; Thu, 18 Jun 2026 17:52:50 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E376384874
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 17:52:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-696bf12931dso122245a12.1
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 08:52:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781797968; cv=none;
 d=google.com; s=arc-20240605;
 b=XmcBLCSAjM3JrlD62hcF1eeh+g8YfzDCpVcj0Oe+04e0/dCzW8MkSB7TVsr5xGsdMK
 HgnJSKIYNdHMiOqcq0GRXrHFueqeYWWoSepq7sROACcNiFUrLHHIaBTLltcHmyRbedlh
 o6A8kPeymI1fh6xlBTL0TbifVOel3USaN05r6E3NdK9+LiJ20TaSNsTVUdiGZlI+gTNt
 t+apVOITDV88C6U7/71HmQpHDeiOot83BpUgk2gLM6J8GuUQqVVx1mF1v9WQhP7iJsM2
 K5pNFjfnpIXnsDkUMsqrCj/C4GKWMFgqsn9xiBHN+wVFE8DASFgvyi2iN0SIbl1a6psn
 664w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hh92r/odGlcnVVEscWLfwDQu9bLo2MmrJDs22fcDNug=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=UfdqEG/L0usstoYQor/k+FT98G7wLZlIEt+GQhXxcJ7mIrNgitJ3VfPd07ijUGJg4s
 8DtSgJPCXSrzgspCPC4d2lf3bf8i7d784p9pyaxCr/VRGwAb9JHRVNYSLfUWE+RAwvlC
 VUwvyFxwGOJQGJeAiz+OOBdZpi3qvjlAYAqHKNfMR5cwnBAEJJa/iLpzoj17ZDyB+kup
 ML9FjZf+Un8U6ZFJtZ4Wx7y2ltKlFqt+hVLCBnh1cxkIvqJVMllMwL+5oL2+gSdsqulf
 8hK06BtCFGkQdaZqK6JeVvgoe9nBnMaWxKspJO8/etggXvl17JUZSUBkR7DFOGNZLHmR
 1B5g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781797968; x=1782402768; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hh92r/odGlcnVVEscWLfwDQu9bLo2MmrJDs22fcDNug=;
 b=PdpDXa64wypWG7EFuFXD6kcPgCNwTYjfLKren3QLeB7+rDEna4KL95b2tAeSym/FAJ
 wgFAdVceDrjr0ZqPXkX6iNJaHEzdgaer7Aa6n39OBNScf2EjiemdYcShxmz7puKfvSv/
 Ob7g11IhtQfn4oBwjXprf8Bd+908ZROn3q428=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781797968; x=1782402768;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hh92r/odGlcnVVEscWLfwDQu9bLo2MmrJDs22fcDNug=;
 b=pTYBsyPkMgnjqhVllpOM+tuTxYOztL5PvGGXDuPpTTDQjqA8nF6j4hku4fIA6A47A5
 GtEUHCeOHeNkStDSZmTtLbSeCqb2zUhGP4wiBLD04Dijoch5Q8OdgdDAdvCwNTtein47
 9NF4OeS8omyrYCAE0KPAb/ZxbLGN8XcnZp/G+s/pV5qnSbLsn3Lqd7mmiW0TZbHOr1Pw
 2GZJTCWnIGX8jGKsRMtpymToFVFjTclnL2hoiivoH14h5AA1HWZB0gmEZRfLR2824epT
 jIfES+f0lDWIjUdbK0FoMDCyZsaLdpUUT8+T4GynYR13+tSyrQdbdnzimGU6sGOVolHn
 LQUQ==
X-Gm-Message-State: AOJu0YwYnAnHUq9m2iylLN9p2OVO6K4ZF8gnq8kaIOKYK23y8YYAg6Ua
 BMl5AyaFwYOKbivZrI/rMswWYqQjluOQVosqGtfp2Xv9IhEYRXaxGE5LiVR5KCc9APtEr1+/wXr
 HvozYTRKoEyeb0yS6n9mNJ+gDmMbOtyjltvDRN1ix
X-Gm-Gg: AfdE7cla+mX91RPxfrXwZeYu3sDlKud+8vc+N7RtVmtXznIdSTKgzYXRLVm+tTZ+nwB
 jYTb9jcN2Ea/a4W5ou/cKrP0sKQnXO7I4HNJiX8YFJTV/4BsKIpCqnhSreDmoXfpNvUcGhvuBtI
 8phTlgjtXkU+weInSTJLzvK8FEY6ogsDWO52pzuLqSBaaDtIiOX7C4kqTUcMSKWYksZHl1d14KX
 soP0dE86HPagN3vlmCcHxi7ORMH+wBEIE2X3XhtOOMsa5nQIHWzoyTfWDJWIqi7FojoTQLq8w==
X-Received: by 2002:a05:6402:2684:b0:687:2181:90ab with SMTP id
 4fb4d7f45d1cf-6954747dcf8mr5322845a12.14.1781797968259; Thu, 18 Jun 2026
 08:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260605033907.1909319-1-dmukhin@ford.com>
 <20260605033907.1909319-5-dmukhin@ford.com>
In-Reply-To: <20260605033907.1909319-5-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 18 Jun 2026 16:52:35 +0100
X-Gm-Features: AVVi8CcestOMJKto3gEiI6uknAALQFg9X1Js6uMm5Xmfw1Yliy9zeCUhO0dfj_k
Message-ID: <CAFLszTjp=qOd_nU6r1fjuvRkMsawcAYA6tKu7ehz4dm3k7zNNA@mail.gmail.com>
Subject: Re: [PATCH v1 4/8] cmd: gpt: enable extension to manipulate GPT PTE
 attributes
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
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

Hi Denis,

On 2026-06-05T03:38:59, None <dmukhin@ford.com> wrote:
> cmd: gpt: enable extension to manipulate GPT PTE attributes
>
> Enable extension for existing 'gpt' command to manipulate top 16
> bits of GPT PTE attributes to assist ChromiumOS-style boot counters.
>
> Follow the existing syntax for specifying <interface, device, partition>
> tuple.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> cmd/Kconfig |  8 +++++
>  cmd/gpt.c   | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 105 insertions(+)

> diff --git a/cmd/gpt.c b/cmd/gpt.c
> @@ -11,6 +11,9 @@
>   */
>
>  #include <blk.h>
> +#ifdef CONFIG_CMD_GPT_FLAGS
> +#include <cros_flags.h>
> +#endif
>  #include <env.h>

Please drop the #ifdef - header guards make it harmless to include
unconditionally, and U-Boot generally avoids conditional includes for
plain headers.

> diff --git a/cmd/gpt.c b/cmd/gpt.c
> @@ -1116,6 +1119,64 @@ out:
> +static int do_set_gpt_flags(struct blk_desc *desc, int partnum,
> +                            const char *key, int value)

The continuation here is indented with spaces instead of a tab plus
spaces. Same problem in the pr_err() call below and at the closing
brace:

> +             pr_err("ERROR: partnum %d: failed to write GPT flags: %d\n",
> +               partnum, rc);
> +             return CMD_RET_FAILURE;
> +    }

Spaces again.

> diff --git a/cmd/gpt.c b/cmd/gpt.c
> @@ -1116,6 +1119,64 @@ out:
> +     rc = write_disk_flags(desc, partnum, guid_flags);
> +     if (rc < 0) {
> +             pr_err("ERROR: partnum %d: failed to write GPT flags: %d\n",
> +               partnum, rc);

Why pr_err() here, but printf() for the read-flags error a few lines
up and inside do_get_gpt_flags()? Please pick one - this is a command
handler, so printf() seems more consistent with the rest of the file.

> diff --git a/cmd/gpt.c b/cmd/gpt.c
> @@ -1116,6 +1119,64 @@ out:
> +     if (!strcmp(key, 'set-flags')) {
> +             guid_flags = (u16)(value & 0xffff);
> +     } else if (!strcmp(key, 'set-priority')) {
> +             guid_flags = cros_flags_set_priority(guid_flags, value);
> +     } else if (!strcmp(key, 'set-successful')) {
> +             guid_flags = cros_flags_set_successful(guid_flags, value);
> +     } else if (!strcmp(key, 'set-tries')) {
> +             guid_flags = cros_flags_set_tries(guid_flags, value);

The help text advertises ranges like [0..15] and {0,1}, but nothing
here rejects out-of-range input...the cros_flags_set_*() helpers
silently mask to 4 bits, and set-flags silently truncates to 16 bits.
Please validate value against the documented range and return
CMD_RET_USAGE on bad input.

> diff --git a/cmd/gpt.c b/cmd/gpt.c
> @@ -1176,6 +1237,23 @@ static int do_gpt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> +     } else if (!strcmp(argv[1], 'get-flags')) {
> +             if (argc < 5)
> +                     return CMD_RET_FAILURE;
> +             ret = do_get_gpt_flags(blk_dev_desc,
> +                                    simple_strtol(argv[4], NULL, 0));
> +     } else if (!strcmp(argv[1], 'set-flags') ||
> +                !strcmp(argv[1], 'set-priority') ||
> +                !strcmp(argv[1], 'set-successful') ||
> +                !strcmp(argv[1], 'set-tries')) {
> +             if (argc < 6)
> +                     return CMD_RET_FAILURE;

The other branches fall through to CMD_RET_USAGE on bad argument
counts (see the top of do_gpt()). Returning CMD_RET_FAILURE here means
the user gets 'error!' instead of the usage hint. Please use
CMD_RET_USAGE

Also, do_gpt() already gates argc at 4..5 (or 4..6 with
CMD_GPT_RENAME) before any dispatch. From what I can tell, with
CMD_GPT_FLAGS but not CMD_GPT_RENAME, 'gpt set-flags <if> <dev> <part>
<val>' has argc == 6 and will be rejected up front. Please extend the
early argc check so the new subcommands can actually be reached.

> diff --git a/cmd/gpt.c b/cmd/gpt.c
> @@ -1176,6 +1237,23 @@ static int do_gpt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> +             ret = do_get_gpt_flags(blk_dev_desc,
> +                                    simple_strtol(argv[4], NULL, 0));

simple_strtol() has no failure indication - a typo in the partition
number silently becomes 0 and writes flags to the wrong partition. The
existing code at the top of do_gpt() uses dectoul() with an endptr
check for argv[3] - please do the same for argv[4] (and argv[5] in the
set case) and reject non-numeric input.

> diff --git a/cmd/gpt.c b/cmd/gpt.c
> @@ -1176,6 +1237,23 @@ static int do_gpt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> +             ret = do_set_gpt_flags(blk_dev_desc, /* argv[2,3] */
> +                                    simple_strtol(argv[4], NULL, 0),
> +                                    argv[1],
> +                                    simple_strtol(argv[5], NULL, 0));

The /* argv[2,3] */ comment is cryptic - argv[2] and argv[3] have
already been consumed via blk_get_dev() above. Please drop it.

> diff --git a/cmd/gpt.c b/cmd/gpt.c
> @@ -1237,4 +1315,23 @@ U_BOOT_CMD(gpt, CONFIG_SYS_MAXARGS, 1, do_gpt,
> +#ifdef CONFIG_CMD_GPT_FLAGS
> +     "gpt partition boot flag manipulation:\n"
> +     " gpt get-flags <interface> <dev> <partid>\n"
> +     "    - read top 16-bit of partition attributes (bits 48:63)\n"
> +     " gpt set-flags <interface> <dev> <partid> <flags-in-hex>\n"
> +     "    - write top 16-bit of partition attributes (bits 48:63)\n"

Minor: 'top 16-bit' reads as singular - please use 'top 16 bits'. The
flags occupy bits 48..63 in the on-disk attribute, but the helpers and
the command operate on a u16 - worth saying so explicitly so users do
not try to pass a 64-bit value.

> diff --git a/cmd/Kconfig b/cmd/Kconfig
> @@ -1319,6 +1319,14 @@ config CMD_GPT
> +config CMD_GPT_FLAGS
> +     bool "GPT partition flags commands"
> +     depends on CMD_GPT
> +     select PARTITION_TYPE_GUID
> +     help
> +       Enables the GUID partition table attributes manipulation (bits 48:63)
> +       in a ChromiumOS-style manner.

Just to check - why select PARTITION_TYPE_GUID? The new subcommands
operate on the attribute u64 via {read,write}_disk_flags() and do not
appear to look at the partition-type GUID, even though I assume other
things would break without it. If the dependency is real, please add a
sentence to the help text; if not, drop the select.

Regards,
Simon
