Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE278C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 17:11:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41AEE86EE5;
	Sat, 18 Nov 2023 18:11:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fcfioDaK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D696E86FD2; Sat, 18 Nov 2023 18:11:12 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66A0086EB8
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 18:11:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5b3b17d36d5so33184287b3.0
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 09:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700327465; x=1700932265; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YPWY9YGaHDJyBN2yoEmKIF2rYaRKACAnX9/2tDopaQI=;
 b=fcfioDaKdckh+2+YpXWOyRdEGphzgwqYLYMcnWthNNRqtdv52joSZUzoZMZXTiRlYv
 kQr30KGMfwQNqJbNvtkqqHGz/dg8bGRd3gL0yrq7th2+AiLjMS9oUu2PrQHmUtkXrkS7
 SUxK5krnOPNekm/AU83uU5kv7PLrl10HYL8G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700327465; x=1700932265;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YPWY9YGaHDJyBN2yoEmKIF2rYaRKACAnX9/2tDopaQI=;
 b=GzZ9s+bL//1GlvvZ4sZtrSbFnlV9XIOE4Dhb1MeINzZEHA/tbbCK5mlg3kFlfJtTl8
 xpuvd3PXFtgzcPFPZtCMj3iGOH9BT0NGJ99lQ3ZeU8cAQCeza6CBJOQJXUjjmiyXNva8
 Bkc8jHXuGgtJdBNnz/ZMQhSzcO6ZYE/PKJmPeXGxGIKRtg00kV16h5VNwGUQutQdLf0e
 qC49joK7780HOFth3e50XVMGadiMfeTceFwEyd1LZBg9Ny8ZQpeHfz6k9OQCd4uhr236
 PP9t1HlY2nxkRikneQChsXF9r8sxdBDPk5udfOQeGNAcxNa2rM3SH38LnxsTjBA+U1PE
 t60g==
X-Gm-Message-State: AOJu0YwhgfQxZdwN7j7LDFVVPiB7hKJVk/JgzFh6eltq2t2G2MKrszyu
 Efh02yt6/0YSwlpCZV6sw1kNHvxl231/C5i33IKufA==
X-Google-Smtp-Source: AGHT+IEWT9V8W/tbjQguk87hKgPNpBELCRG834KC2l7RKWTgWhVNH5ruqpLW6aO2CLi12xU+n1jYOkxL4eB+IRyP3Q0=
X-Received: by 2002:a81:4e94:0:b0:5c5:d186:16b1 with SMTP id
 c142-20020a814e94000000b005c5d18616b1mr1839546ywb.0.1700327464582; Sat, 18
 Nov 2023 09:11:04 -0800 (PST)
MIME-Version: 1.0
References: <20231117212039.1210784-1-i@shantur.com>
 <20231117212039.1210784-3-i@shantur.com>
In-Reply-To: <20231117212039.1210784-3-i@shantur.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 10:10:05 -0700
Message-ID: <CAPnjgZ19Q4RZMR080gqqzginpCNkCkj4OuVgJX6drRt+dJbLNQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] bootflow: bootmeth_efi: Don't set bootdev again
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, xypron.glpk@gmx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

+Ilias too as this involves a design decision

Hi Shantur,

On Fri, 17 Nov 2023 at 14:22, Shantur Rathore <i@shantur.com> wrote:
>
> efi_set_bootdev is already called as part of tftp while doing dhcp_run()

Is that in tftp_complete() ?

> Doing this again crashes U-boot and we don't need to call again.

U-Boot

The problem is that we might scan for 4 bootflows, then later decide
which one to boot. So we cannot know which one it will be until that
point.

The hack is needed so that it actually tells EFI about the right one.

The addition of EFI hacks when reading files (i.e. the code in
tftp_complete()) is a real problem, unfortunately. I understand that
it was a convenient hack, but with standard boot we really don't want
it to do that. We end up calling it multiple times for bootflows that
won't be used.

So I believe the fix is to be able to disable those calls, leaving it
to bootstd.

I'm not sure of the best way to do that. Perhaps we should have a
function like bootstd_scanning() which returns a bool indicating that
bootstd is scanning? If that is true then no efi_set_bootdev() calls
are made? We could have a flag in 'struct bootstd_priv' which is set
before bootflow_check() is called and cleared afterwards.

As to how this should be done with standard boot, we should create a
function like efi_start_app() and pass it the information we need.
That function should do the equivalent of the 'bootefi' command,
except programmatically, with no prior state hanging around.

As to when we might be able to do that, we need more refactoring of
the bootm code. There is a start on this [1] but it likely needs 2-3
more series before it might be possible.

So for now, I think bootstd_scanning() is the best approach. If you
are not sure about that, I can send a patch.

>
> Signed-off-by: Shantur Rathore <i@shantur.com>
> ---
>  boot/bootmeth_efi.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> index 682cf5b23b..5917458dc5 100644
> --- a/boot/bootmeth_efi.c
> +++ b/boot/bootmeth_efi.c
> @@ -360,9 +360,6 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
>                 return log_msg_ret("sz", -EINVAL);
>         bflow->size = size;
>
> -       /* do the hideous EFI hack */
> -       efi_set_bootdev("Net", "", bflow->fname, map_sysmem(addr, 0),
> -                       bflow->size);
>
>         /* read the DT file also */
>         fdt_addr_str = env_get("fdt_addr_r");
> --
> 2.40.1
>

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=382423
