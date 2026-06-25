Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B45CDE001
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 17:48:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 510FA849C5;
	Thu, 25 Jun 2026 19:48:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PQT50I/U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC37A84704; Thu, 25 Jun 2026 19:47:27 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B28708460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 19:47:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yordy1902@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5ad5e719157so67476e87.2
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 10:47:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782409645; cv=none;
 d=google.com; s=arc-20260327;
 b=ltPGqaLNuJ+LV+jWiY0htjDu4bVZ7SFI72XkyqFm4OaEg5ie+wODWlCNQmUijnVi9t
 kKt8naQUO+eKN5rc5cKFmFYPwrfTuyCw3llPH5PZ/W9j3HpKu2FOpV803h97IrTsEQDw
 NbFSZZcwn4ESdJ6iJEoyGEMRRYFqy14y4MGRgwk8JMIeZI3Y6YajeeCrM436H/2VmUa3
 NWqO3vic1QIU+SRvC8e2zPaBtj8WeXthu7uifIbsZiZzq9YYuJ+UpJSwvir/Day1zJbm
 HZzZtj0fteQTj8gGRRBHA3ATroWF0oghIkFy3Gxb9wwr5389ZEZjIE/h284ZWj1landn
 ZBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sRw5UjC4A4RX0XKC1UzYDcZOOaXxZAITAfrMnx/z2ac=;
 fh=FCmzCjCQ1MwpOEssjdJ+0XFkTIwVdmA93Y2/YC4POb8=;
 b=ijUjwA7vXUqjsfZKklrobHiCGtWZAQ3KA2wUe21O0anCDWi6uvAbk8E9tKaN7cAALp
 V24xL3IghsOOnHDR+pIO8MPzPQCvj8bgaG8QXzKYW/JHf0olhVJR4b+4RmkMw9PjG335
 3UGVP6lDPDaU5vaH4EPjn/7Qjgzq0Ckmlgb9hPaWc8GdFIhL85Qo6D78q69hJkrdsNPo
 B/YWOPeNFzVwD7j6C5kLx8hbxW49PCOOgglSfv/TLEbyss/y0/jZKHDQyYH7CZQQ6W6D
 QQFdyX9I14wv6xaQiD85wlibjq9WHZLvR2gY/o0WQ71zSaxLji9A1RKHss53rUHF1Kd5
 hOHA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782409645; x=1783014445; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sRw5UjC4A4RX0XKC1UzYDcZOOaXxZAITAfrMnx/z2ac=;
 b=PQT50I/UMS/S4mqUV1kGVLrM7NhnRZgpnhDSntCXXi4a2q05NQW1mSV8qRQyRSQETc
 WH6bkitfu5qxHAEG6eFAZx7baZWzLax+6DZBlS4M3AkA5bcf/lcDUitk3o02v9YDON6C
 OqoJTsPc3IwXhfZ4FnbEmoblLfiEEvvWZsTDoqEmcOiA+R4Co5yZLQqDjoXyFOhq806W
 g83Ikg1QImQqw5YoCOBtfzsT+uv5aQZUHqFSbXWVWg6U0lIqnmq8V8Y49pGxn+6iDZgm
 Fx+q+XHVKkWCbZ89usKOWabq8mUJvW5HzoHNVtRALOpuWrmlybWSX3dS8V/iQlmdFx6L
 ljxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782409645; x=1783014445;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sRw5UjC4A4RX0XKC1UzYDcZOOaXxZAITAfrMnx/z2ac=;
 b=ndRyFyWPb7GypsApnEetG5GMRMEago/9kSERkjZ/f6wv13ZhYVosrMHk62VlclO0DH
 N3fkhgh6X8rZnqSQil+7qtBtwjWr51wSCCj26c5WscC6jSAiH89ELKIvUt4EjUSAIfKu
 ypyPnOnaYtQGoohzAArfoWVo6pPHCWyomkcRrkG7VncK7WhYuKKf8UMFudxccWLaijjC
 uC6P0nGIG4M9Qt4UeUWHmT+6DR8OGmv8GGURWQOmMVuPNQmJxWMiJI+2NeKPiLyIMZWK
 MU0wXBFYRLPdV3GktO/rGXW13PZMflJUof76WUwfGwKMYFGK6lkDYxBR8ex8oDJGYPnx
 f4LQ==
X-Gm-Message-State: AOJu0YxNcROzQVnCtYpUIAFhPMu9be2lO/QqsKHoywPB+4gS8KrCejuG
 ZNAa6jh7ZAmw9V/qFMfeK2os2hc5BldcrEIA2YdXQJv5pw+6pytA6Em2euaQgLDd2btzq+XWq3k
 PwKIpqM9nEB3DQ8pxi7OL5KNNF6dVH/oBCXY+h8E=
X-Gm-Gg: AfdE7cngLpVtwKpTvEGq6cDBE8xQgfghRr1PUcVZteukPlDP+IcyygYcklDZy8AeZ1L
 4pisjS/eTJVcVnAQ1fVIBDh8UNgjN3LRgI3ZSipK7OVSoQHU5H/ZM5wCnI45A9CtCwIWccyAtCm
 +ckTDF9P+MO37LgKCDxTJU1QM1/q/WAG60uTmqwodD6J7TVEzFHdGG1DM29ewjG1Hf3m4aObNoC
 n1Y7+tQUaW+RJTOlN1eAcGSDhh0mfHdPm5w2OczRrg6hr4WaS2RTD9Yxfxoj18iRKGQnmVNK5Bs
 qbzrqgw=
X-Received: by 2002:a05:6512:8399:b0:5aa:5e22:5add with SMTP id
 2adb3069b0e04-5aea1e0c193mr795183e87.0.1782409644186; Thu, 25 Jun 2026
 10:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260614103232.3586246-1-yordy1902@gmail.com>
 <20260625174121.3633162-1-yordy1902@gmail.com>
 <CAKqxRA_cKJdQUwsH-s6Dte6AX0oDptDRtfEg2FuJYzeS5L-j9w@mail.gmail.com>
In-Reply-To: <CAKqxRA_cKJdQUwsH-s6Dte6AX0oDptDRtfEg2FuJYzeS5L-j9w@mail.gmail.com>
From: Jordi T <yordy1902@gmail.com>
Date: Thu, 25 Jun 2026 19:47:12 +0200
X-Gm-Features: AVVi8Cc3fMPgUgExJncaSG-h7cqJ9zQNyYyyUbJkcDsoc2aaxDTiZ7xEApSY9NU
Message-ID: <CAKqxRA_kjK2zhzi4OjS7NJt8YC0YfZMsfxGTmbAhS9QdA=BG1A@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: single: parse gpio-range as a raw array
 (O(N^2) -> O(N))
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, vigneshr@ti.com, nm@ti.com, 
 anshuld@ti.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 25 Jun 2026 19:48:16 +0200
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

Hi Simon,

Thanks for the thorough review.

> phandle == 0 used to terminate the scan; now it is silently skipped.

You're right, good catch. The original code breaks on the first
ofnode_parse_phandle_with_args() error, and a zero phandle is one such
error, so it ended the list. v1 turned that into a skip, which is a
behaviour change. v2 restores the terminate-on-zero-phandle behaviour:

ofnode_read_u32_index(node, propname, base, &phandle);
if (!phandle)
break;

> These two [args_count check, size-mismatch] turn a silent no-op into a
> hard probe failure.

Agreed. v2 drops both -EINVAL paths: it keeps the lenient behaviour and
does not fail the probe on malformed or partial data. args_count is pinned
by #pinctrl-single,gpio-range-cells, and a non-multiple size simply leaves
the trailing partial entry unprocessed.

> Did you consider ofnode_read_u32_array() [...] instead of be32_to_cpup()?

Switched to ofnode_read_u32_index() for the argument cells. There is no
open-coded __be32 walk, and it works for OF_LIVE too. I read only the
three argument cells per entry, since the phandle target is never
dereferenced, so there is no phandle resolution in the loop. That was the
O(N^2) cost.

> The ret/ret_total split is unnecessary - just reuse ret.

Done, single ret, used only for the one phandle lookup.

> Please drop the extra spacing.

Done, single space.

> +1 to avoiding alloc. You can create a variable-length local var.

v2 coalesces the per-entry allocation into one devm_kcalloc(dev, entries,
...). The ranges themselves cannot be local or a VLA: they are linked into
priv->gpiofuncs and consumed later by single_get_gpio_func(), so they have
to outlive this function. The single allocation removes the repeated
malloc and NULL check you and Anshul flagged.

> Is every entry in the property always for the same device? I'm not sure
> where that is required in the schema.

You may well be right that the schema does not formally require it. In
every pinctrl-single,gpio-range instance I have come across, all entries
point at the controller's own gpio-range provider, so
#pinctrl-single,gpio-range-cells, and therefore the per-entry stride, is
uniform. I have noted that assumption in a comment.

If a DT ever mixed providers with different cell counts, the stride would
have to be recomputed per entry, which would reintroduce a phandle resolve
per entry. I am happy to do that if you would rather keep full generality
over the fast path, but I am not aware of any such DT today.

v2 with all of the above follows.

Thanks again to you and Anshul.

Jordi

Missatge de Jordi T <yordy1902@gmail.com> del dia dj., 25 de juny 2026
a les 19:46:
>
> Hi Anshul,
>
> Thanks for the review and for trying to reproduce it.
>
> > I'm unable to reproduce the delays you have observed with the J722s EVM.
> > Are you using a custom DT perhaps?
>
> You're right that the default EVM build doesn't show a large delay, and it took
> a board test on my side to understand why. No custom gpio-range property is
> involved - it is the SoC's stock 7-entry main-domain gpio-range. What changes
> is when pinctrl@f4000 (main_pmx0) is probed.
>
> On the stock EVM defconfig it is first probed after relocation (caches on).
> There, single_add_gpio_func() is only ~18 ms, and ~1 ms with this patch - easy
> to miss in the overall boot unless you time the function directly. If you put a
> get_timer() around single_add_gpio_func() on a stock EVM, you should see that
> ~18 ms -> ~1 ms.
>
> The 723 ms in the commit came from a product configuration where the node is
> probed before relocation (caches off). This happens during the pre-relocation
> console bring-up: setting up the main UART applies its pin mux, which probes
> main_pmx0 with caches off. That board also runs its LPDDR4 clocked down, as it
> is an early sample and needed that for stability. The two factors decompose
> cleanly from real measurements of the same unpatched function:
>
>     caches off vs on, same board   : ~17x  (723 ms vs 41 ms post-reloc)
>     reduced DDR vs EVM, caches on  : ~2x   (41 ms vs the EVM's 18 ms)
>
> i.e. 723 ms = O(N^2) x caches-off x reduced-DDR. On the EVM's stock DDR, a
> pre-relocation probe would land around ~300 ms. Either way, the patch removes a
> genuinely quadratic full-FDT scan per entry and produces an identical
> gpio-range list.
>
> On the code points, all addressed in v2:
>
> > Why rename 'ret' to 'ret_total' here?
>
> Leftover, dropped. A single 'ret' is used only for the one phandle lookup.
>
> > The size check is redundant
>
> Agreed, dropped; v2 uses just if (!list).
>
> > You could just do if (!phandle_i) ... is the validation required?
>
> Correct, a valid gpio-range never has a null phandle. v2 reads the entries
> directly; a zero phandle terminates the list, as in the original loop.
>
> > I wonder if we can just allocate a pool of ranges[entries] ...
>
> Done: v2 does a single devm_kcalloc(dev, entries, ...) and walks the array,
> removing the per-entry allocation and its null check.
>
> v2 follows shortly.
>
> Thanks again.
>
> Jordi
