Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E4BC36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 10:02:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 837A482B41;
	Fri, 11 Apr 2025 12:02:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mjQFNSp7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2066582B41; Fri, 11 Apr 2025 12:02:28 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2E3882B1F
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 12:02:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e6e2971f79fso1504439276.0
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 03:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744365744; x=1744970544; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nOoBMCX/E0d2K7mGzmyzgUikChEFvWaVRLNlYjWy9PY=;
 b=mjQFNSp76iWBKg9W6mb0WAT74oK2zAzrpk2iVaFFCEww1pxs3fL8D4/z+9LysplKtT
 7c4teDvMvPbbgKVNMH/UugFkQb0TVYqy+nLkwShJfUTU/G7jzCVBgo564AhVZHuTO2Za
 iU9MXHczS96Ytt5gyteMI1vh20Untfme5ChTUA0dJX2z0kHqFsUkw6XNh4IA0PSGAZRD
 oGCG/QEbA4jIaAovz23P0lLHiYzf3VHMjDfqJskh9TqRQFcyiBEySA0QmccQ3Hu+ARhk
 cTZJYc7PyVNgccuSeUpdsW4TCrg6nXARMBo4PvvlgURYLDsS95/+Zp3E8sgIRc0JY2zs
 RjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744365744; x=1744970544;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nOoBMCX/E0d2K7mGzmyzgUikChEFvWaVRLNlYjWy9PY=;
 b=beXTxeOCJX4W95MumdoEl0/d3dxbWHYzzbMVNyYrqT+ngDeQ9DAutBBhSUiw+sPyxo
 DlnNUGK0NME/X+PTLtk6jR0V55bXVSC12tzE7rV57FVI2Umgdv6zfm9AgQfjCcgxcEpe
 udGyegkLSmsKYKWsbh4ikMIIiVMaBfbrVqXRSzz1+k8HvP/onHD2Ux6+aUmrWF2DEzrh
 tro9h6VUoPIEGGw9ywR1ya/8c5bWOLXDBsajHMcBeqDAtGnm34b2nDF5WjQTuYXw0s2P
 mKHDrVcjvRv7+us0ZMWmQarUl7heU0oLbGDvLgpRroALkhxJBySq3NF5YPFt4mtDWhj/
 /scA==
X-Gm-Message-State: AOJu0YxmDk3Ee0B1yo3vYR/fabfC0oEtNqo5AE5MZzIHOn9n1VtsjCUG
 sd6xtF4L0TJaQJT4VYTldtKvhv0Wnb36Ux+aboM1u3PyA8b+1/VWW+jkMp/pfZJeLG3VPkcv3DW
 AjPRp029gOrktB6AjP13dha9Zr8UPgE9iARzL7DeaDNhQ295gojg=
X-Gm-Gg: ASbGnctvPx3I3UPKX8TAjegPGKz7TvPpMGhXbaFWY65oT1W4xJSHxfVhIJ3ZXcsEQsJ
 moogAk1wwfAdBdRPuORnS70TIOe5xK1eI4gU4jRwDe8ICDKw3Fxo2X7lpQGUeLXU/krtvgMNq+v
 kyFVfPPOPMmHDE6xqchAXNwG8=
X-Google-Smtp-Source: AGHT+IEVQqNkbAKLS0XfoR9gwdL8+36fkdGpTcj1ocKEUszHAP1hhqbpW0NC2kzDTZViYVgTS1FePCj1/xKpzjxcR8U=
X-Received: by 2002:a05:6902:e04:b0:e6d:f47a:f873 with SMTP id
 3f1490d57ef6-e704deee8fbmr3364900276.9.1744365744356; Fri, 11 Apr 2025
 03:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250411053645.17454-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250411053645.17454-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 11 Apr 2025 13:01:48 +0300
X-Gm-Features: ATxdqUHrIImKZa1cdlmXwQmdWQ6JiWEG2StD_foN8c5vqLSzjtUPe-IDA9wSZR8
Message-ID: <CAC_iWjLqP_qP4VGjZafF33sJYR=NbJtFtO-HQi01Aj-wwjvonQ@mail.gmail.com>
Subject: Re: [PATCH] efi_selftest: use do_bootefi_exec()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

On Fri, 11 Apr 2025 at 08:36, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The EFI selftest should match executing a real EFI binary
> as closely as possible.
>
> Use do_bootefi_exec() to enter the EFI selftest.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/bootefi.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> index c1454ffb948..13479248999 100644
> --- a/cmd/bootefi.c
> +++ b/cmd/bootefi.c
> @@ -38,6 +38,9 @@ static efi_status_t bootefi_run_prepare(const char *load_options_path,
>         if (ret != EFI_SUCCESS)
>                 return ret;
>
> +       (*image_objp)->auth_status = EFI_IMAGE_AUTH_PASSED;
> +       (*image_objp)->entry = efi_selftest;
> +
>         /* Transfer environment variable as load options */
>         return efi_env_set_load_options((efi_handle_t)*image_objp,
>                                         load_options_path,
> @@ -106,8 +109,8 @@ static int do_efi_selftest(void)
>                 return CMD_RET_FAILURE;
>
>         /* Execute the test */
> -       ret = EFI_CALL(efi_selftest(&image_obj->header, &systab));
> -       free(loaded_image_info->load_options);
> +       ret = do_bootefi_exec(&image_obj->header,
> +                             loaded_image_info->load_options);
>         efi_free_pool(test_device_path);
>         efi_free_pool(test_image_path);
>         if (ret != EFI_SUCCESS)
> --
> 2.48.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
