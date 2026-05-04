Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E4BFF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:26:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D46F83FEC;
	Mon,  4 May 2026 14:26:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ByacfUDq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAA94845E3; Mon,  4 May 2026 14:26:18 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ACA88394E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-67bb5ad91bfso5057191a12.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:26:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777897576; cv=none;
 d=google.com; s=arc-20240605;
 b=fCB5iO/ks0wWWrD6heVt4S05F3tT95vz02194pgqHBXWv2L/bj3Gfr6tQwsnijb8nK
 qip4eH11uONZuMlJHomvMtLAXX3vnl3KdBJgoAIbBfOQ4ZBD+6396FsoF2J1451TO9jc
 TiTr633iZ5P2J2rbouB1JM4tSOH/q43bj8mcAbc/mPc+hmuaZMWYGOV75tgMVjlsZsjq
 fO6ZQOIiVl1R05e1G/HS9U2xgriZPkNT8RCmHksOGN06OIgKd1h+ssUajtEl/B3B3+3n
 emExgLtOxDYx8zbp13haAYzJEwx9lNl52G0YhDLEWY0Ws0dGwXMtWxXa937SFrpojyxW
 LyLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LEnbRrBb3+qHQfeCNb5QkFUpDHc1uOGKJYyLT2ASgBg=;
 fh=s0oj3HStx+e+88N2sjUgJj5d8lWRPHFfsiQ2ENrHQdY=;
 b=h4f494uqe7hV8vqoKQHn+ZHWOHYo1Tzn6GNkmdIOJZX9o6sWmVqhqj7locy2WzLhJX
 OIpe4rGpKRs152XYtP48+pbg8biPP6jvX5lGZNH5uSrNZX38bmD+axz0Vv+n5YhftaVH
 70MtyXHkIf5s0bAW8VRPHfpJDCfKA3FmyjfFeyKstO+1d92u0SDN6aPV6PBH3Kx0qepj
 3ECzatLQco+BmXd2edYikdg10vXy8ZcUjKvYtOCyW7pOrio+/QWVcpXlkXZ4cC7SQPi8
 nVwhmO2jzW8cTgoXPdDkV93m20tadi/d90GK6ZOgOiN5FxeW6KuW0oDUJJcgO+8kOReF
 c6Dg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777897576; x=1778502376; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LEnbRrBb3+qHQfeCNb5QkFUpDHc1uOGKJYyLT2ASgBg=;
 b=ByacfUDqSiYbmjxrrgNPSbHEer8Udl+7wBpi5WSsPMguNPMXKF/MIgQ7rdspl2TmUS
 6sUAgBS2XWjUyVdtRPm1BlaC9vYg9mlJHzGxF+0IA8G7U0Dc8i4BqFCJPornpMhBta16
 KkuyS6IDvNL5aPxskUfI/lfRLuTCD/rTrC43E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777897576; x=1778502376;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LEnbRrBb3+qHQfeCNb5QkFUpDHc1uOGKJYyLT2ASgBg=;
 b=mmidgB5X9QUnvI9C9xsxumbd9oFRd/Chxs3nt+z3BD5tamOX+zyk3mC/6wjxFLG9BS
 zjCBlFFv7wRlBSfOow5KAkiciJt1sRv+34aM1NRCAZidJrj8sbl+JZBACB9CD+me+Bgv
 lBQuxp2e7Gy5ETLlLA7/19IShP0Oz4d9Y5NfDpgRWo1qTgDj2g2VGNFS3Hrb6yW2BXuy
 qUw0+IwSUQvB2eIKCQX7PhUprIMopvEGQxQqe48aLbrNmlZESoj+XMSnIxqAsG49CWNY
 IfVeeOIv+2Tl8zI97PftnzH3OmtTypmJmyvZ41wBiwhRGc+5rU3GwRB5GHvkpuQz1sg8
 hCxw==
X-Gm-Message-State: AOJu0YxW4dumxBdJ34psaCqWI8z7HSRfmpQEDvxEGh7MkZREv3jhQX6c
 3As5d+ntrPbXZb92mDsxC9AQEwLOq2OYLJDLbhpktaNTuhZJBoAypYcCs6/BmPm5a9m/z2HcI9S
 s/P7FKHCTul/mINMV/MtFRYh1yQMskFdvyTfmU3AY4a53LLdGxH4R3A==
X-Gm-Gg: AeBDieujxDOsNjKfXoYZ792OCY2WZ2KdHfXugpvUReZVMJVNxpVypHYn7+c1q2moUbY
 KBa8o307EvXUm2cnNo5L2zF1k8aXU9EFFNBWUnM1xcADDCdrgp83O0Fbx0xlHRUuDYDG0Yo/s9L
 sXXkHi6Nj0/IL+R1F06AXRi4fwU2BFQYmlm2QzCsgw64rVG0MfdUVL9ap6SnB7uTn0Jfi048hu/
 dShCUZY21J6u1t0Jg/H2HnWH5LLjQkCxzhSANtp3RwnOp+zeW0A7Lv3Bf8XBryLetpwKwAeS7Le
 9x4lNjuwh7QUd+Dk
X-Received: by 2002:a17:906:9f87:b0:bad:3fc8:e88a with SMTP id
 a640c23a62f3a-bbffd1a82c5mr493463966b.28.1777897575822; Mon, 04 May 2026
 05:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260430122629.606153-1-ludwig.nussel@siemens.com>
 <20260430142602.v2.1.5f8ce2dc2b00328d29e64be2684b10d9f52c6a7b@changeid>
In-Reply-To: <20260430142602.v2.1.5f8ce2dc2b00328d29e64be2684b10d9f52c6a7b@changeid>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:26:04 -0600
X-Gm-Features: AVHnY4KFtsvkJIXLr-X7EuXj78c15pZBi9OLQQ6YIG47A664GQwFb_JxX_q1dQg
Message-ID: <CAFLszTiTCsLgdAasexCb5Gv1zkdAo6m47D2MEgYxqwpkfAZoNA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] qemu: overlay signature nodes
To: ludwig.nussel@siemens.com
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Ludwig,

On 2026-04-30T12:25:59, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> qemu: overlay signature nodes
>
> The keys trusted for FIT signature verification are supposed to be
> embedded in the device tree built into u-boot. When running in Qemu it's
> convenient to use the device tree provided by the VM which doesn't know
> about signatures though. So merge the signature nodes at run time.
>
> Needs
>   CONFIG_OF_OMIT_DTB=3Dn
>   CONFIG_OF_LIBFDT_OVERLAY=3Dy
>
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
>
> board/emulation/qemu-arm/qemu-arm.c | 33 ++++++++++++++++++++++++++++++++=
-
>  1 file changed, 32 insertions(+), 1 deletion(-)

> diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-a=
rm/qemu-arm.c
> @@ -147,7 +147,38 @@ int dram_init_banksize(void)
>  int board_fdt_blob_setup(void **fdtp)
>  {
>       /* QEMU loads a generated DTB for us at the start of RAM. */
> -     *fdtp =3D (void *)CFG_SYS_SDRAM_BASE;
> +     void *qemu_fdt =3D (void *)CFG_SYS_SDRAM_BASE;
> +     int ret;
> +
> +     if (!*fdtp)
> +             goto out;

This runs the opposite direction to qemu-sbsa, which uses the U-Boot
DT as the base and overlays the QEMU DT onto it (see
fdtdec_board_setup() in board/emulation/qemu-sbsa/qemu-sbsa.c). Done
this way, any node in U-Boot's built-in DT that shares a name with a
QEMU node (/cpus, /memory, /chosen, ...) will have its properties
merged into QEMU's, potentially clobbering the hardware description.
If this is correct, please explain in the commit message why the merge
runs in this direction.

> diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-a=
rm/qemu-arm.c
> @@ -147,7 +147,38 @@ int dram_init_banksize(void)
> +     if (!CONFIG_IS_ENABLED(OF_LIBFDT_OVERLAY)) {
> +             log_err("found built-in dt but CONFIG_OF_LIBFDT_OVERLAY isn=
't enabled");
> +             goto out;
> +     }
> +
> +     if (fdt_check_header(*fdtp) !=3D 0) {
> +             log_err("invalid built-in fdt, skipped.\n");
> +             goto out;
> +     }

Every error path falls through to out: which assigns qemu_fdt and
returns 0 =E2=80=94 we silently continue with a QEMU DT that has no signatu=
re
node. Doesn't this defeat the purpose of the series? - with
FIT_SIGNATURE_REQUIRED disabled, a board can boot unsigned FITs
without anyone noticing the merge failed. Please return a -ve error
here rather than failing open.

Also, please express the CONFIG_OF_LIBFDT_OVERLAY=3Dy requirement as
depends on / imply / select in Kconfig rather than a runtime log_err()
- qemu_arm*_defconfig does not set it.

> diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-a=
rm/qemu-arm.c
> @@ -147,7 +147,38 @@ int dram_init_banksize(void)
> +     ret =3D fdt_increase_size(qemu_fdt, 1024 + fdt_totalsize(*fdtp));
> +     if (ret) {
> +             log_err("Failed to resize overlay: %d", ret);
> +             goto out;
> +     }
> +
> +     ret =3D fdt_overlay_apply_node(qemu_fdt, 0, (void *)*fdtp, 0);
> +     if (ret) {
> +             log_err("Failed to apply overlay: %d\n", ret);
> +             goto out;
> +     }

Can you check that qemu_fdt is valid, like sbsa?

libfdt error codes are more useful via fdt_strerror(ret) than as raw
%d - please switch over.

Style nits on the log_err strings: inconsistent newlines ("isn't
enabled" and "Failed to resize overlay: %d" have none, the others do),
and 'skipped.' has a period followed by \n. Please make them uniform -
every log_err() should end in \n with no trailing period.

> diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-a=
rm/qemu-arm.c
> @@ -147,7 +147,38 @@ int dram_init_banksize(void)
> +     log_debug("found built-in dt %p merging into qemu's at %p...\n", *f=
dtp, qemu_fdt);

Minor wording: "found built-in dt, merging into QEMU's at %p" reads
better. Also please use one term consistently ("DT"?) - you mix "dt",
"fdt" and "DT" across these messages.

I'll also mention [1] here as I see that as a more generic solution
(but to be clear, we should still take this patch).

Regards,
Simon

[1] https://patchew.org/QEMU/20250405191352.2597585-1-sjg@chromium.org/
