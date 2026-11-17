Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EA2606A323
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 07:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zwrwYu8o;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dvOABS4g
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C12C180FB5;
	Tue, 17 Nov 2026 07:36:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2mGJe7hoNLqb; Tue, 17 Nov 2026 07:36:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E111A80FBA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794900961;
	b=Kbc5DLSMB+eO6jcg4E9n5E8RjYCv6Jn7A5MB8w0cg+WPDmZxZvHjtHtfSClN8QBn2ZrY
	 ToLtsLG8xEw1CdL3qJFu/PFKPWUqggvK86hy8UFCHWl8A2sSi7K7YhCf5bfEXIdldfZBV
	 jh9PxYBdsi725o42Vxfk0gZdMGgqSXfGs1itYpJ5DT1j9C9yKGbRuuCcbjWhA0CRgKI1I
	 FRTJ2icOA191157mRkkRb+vCM/5KVqb6rMdU0V2XTcrPKAkdxDcA0iCaVSxj/JSz754Wu
	 Hng1GIRAHG8XDCKRrnVEXmSDHxzG8d5ntX26oIEY2StQQdcRrt60PJ8wZmqH/y0gIJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794900961;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Sx98axkIWQqjtC7u/wgflhmRLv2AhAJnccGpcYL/vqo=;
	b=IFwzHGPTpHB2qrMgtv33PZ88jtSL82JSM8z8P1d5tX0vJXnlgDMXLjb8IPLEVBLlmjNu
	 dFz3g47MP+w8UnjEvMGifvt2qIAZOIcMMF7TKyzUtJvWKfMbEvWhk0oN4GzOelIw/H1h0
	 W/JaR39Va+Aa9j44FttLF0lpfO8pvEXUlqCmOuG7RGHz9/flvibD14PB+RYjzWnifKS0v
	 ZhEyCYxVeXbbzFFeOPAWrf7Dat6gep2Tv+BowQCRq72eCpYv2tt1xxViKNs+TVDhG46ty
	 TLwjZ27/Olac7cd1GWD7/RWJQhlQRpHekHIJKwMjjDrH3jUexExYcIE5emWgUQJvDLA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dvOABS4g;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794900961;
	bh=Sx98axkIWQqjtC7u/wgflhmRLv2AhAJnccGpcYL/vqo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zwrwYu8ol2IIdvEORm2z/5dh8R5Bxjm6a6FEKCoXyXeclZn3TK59fdQgNuZ4cCM3g
	 uQEw0q7UshTFmKESD673qx6gIw2jnXguKWBK4CqXpKMJEgUsyZPwN6HFoz/k0JRN60
	 E9IIEQLOi8xezP8ZwgZUxowapLtbpCzLIKV+PBpEKHYuFtVTH93oKemA5rliWlokEk
	 NzQU2tv6Vcm1Gv/Ip24RHANY8vWoh0EOyX8ce41/vmHjI4Gj/wOQXZN/Y1aJbWdZGP
	 X08514dDWJqz8/KuaB1J8i9GYpb6puu7F78xmJhaAAoWwEke+LL87sFna4zNJMKB+2
	 iLYlWIiXiL3rA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E111A80FBA;
	Tue, 17 Nov 2026 07:36:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7ACD628C
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 07:35:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6691E80FBA
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 07:35:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v2o1RIUX-_6V for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 07:35:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 40EC780FB5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b12a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12a; helo=mail-yx1-xb12a.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=dvOABS4g
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com
 [IPv6:2607:f8b0:4864:20::b12a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 40EC780FB5
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 07:35:57 +0000 (UTC)
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-67db763cec7so2000197d50.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 23:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794900956; x=1795505756;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Sx98axkIWQqjtC7u/wgflhmRLv2AhAJnccGpcYL/vqo=;
 b=dvOABS4gy+PZBjDIAtVf8hIhG/pICOtwlW+4jv8q12yMKiRgnseMSVT30dB6CgDM/0
 WTznR/c/VmTKM0VSLlem0TTccwjIblGy/B1hf06KJvPsn+/DN6oeRjbUFueEmUIku962
 cO0OHUSWBs2rr96pSgS2HcKEB/R2S2oZ1xfH93i+lmF0mpJ1F1Itlg02N030Ut7DIrkp
 jnpFMWNyoW0269BY8HZ9FgkFcOFKA9WyWRQFuDqPPrBHYTM3Rx2FJGwJczP/OcHO9bQh
 ldtsN+yYF0kKc1KBjxazrJqm6A3oM3MhrDUOaFtAaAhDJxjHqtuzwqY2Hz4hjyupdML1
 +0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794900956; x=1795505756;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Sx98axkIWQqjtC7u/wgflhmRLv2AhAJnccGpcYL/vqo=;
 b=VXaeVkjX2GMwR+cEmiS9NcNDiP+kIYByEavzFt6mEz4/F9cY5uNEl7Wmd8K44fzjCm
 SCWNus95FOya7Ku4msZFF8KoPVL1wu8lfjqUbhavIfqDEhsD42HA8MqpYYhMuHluESyz
 NKhNRFo6DM1NzQzEoHlguKo7J0hxoVKyVXJgM+v9+ghiroN9PgEzLqS91ybVuPQysNLZ
 EPIgDB+iwVn6ZNlmLNJ9POR9DyuABBjZMJF6TlZLtlGTYUNUmhcIcytft4Q12HSyzubX
 ZFvw+QpuNGw6wtJtmxC/4LE7noNaU28hs4QC1ge2UkVNyHwzo0Leh8CP0Aqa49+PSuTb
 oonA==
X-Gm-Message-State: APuU4Z+oNmeN+MM8hnNbA7zXoYUnZxIndQyMPzRA34KmC/+6Rj2+Z7eV
 xaMxuBMDGMlpsQhnxNUskAwaFn4HLRBWV6E/sidl+kL1QEx0v2ncFIe58ZV5UmXY/sdydipfI9v
 1gde45mvIOYbOt4MBVyMd3ZAOI0t30r2uxfQbhoRTYg==
X-Gm-Gg: AZFdTZf6/A8T7rIWVJ+qnZu2Gn2yYizVs9nGSjoTojc+7pvhMnWpOxMH43gtSFZdsgm
 wNE3bpp75SD783WONfHVrdW99esE7GNFRODBSVnx7ZqYFR+2sgfLciWJnXQm36uXjU0gjRb1MqS
 lG52fAANiU0M2LPjVWbLDE2yoqTBHCDCq6NOEPFCf+hlwaBRt69lmlel3NDZmCo6z9VcyV7lt6M
 4N37+keHxhi8rwmBbjNj1EKxAy6qjzmeLl73ck5ot4h9M0eUMnLCPlIjHpJXlg/wr85unG+Frzf
 vpzTWAFJct2PnibDBJO7tS3tsQ4nE05f12iadwQi30kxAu2BpWqRRkKonXtoAi1s47tyGqkiLjO
 ZUU7Q4OmI6Iy9UFPjUEWAhVQ1QRVJlEK2mQvSUVGHYdPFp/D9SkM7TNJcvAp3kbu/6KSWT/xC2D
 AfqFiR32MGBD+DLSHFOsZiNC9/F1v2t5407b7nak6e2BUQ/Im+YOvS4xE+/sFwYzGk6Bk1q0xrx
 boLe4so/z0RIH2vIbO8Sp61AiF28fyubodlALhvXOAcEcorNuzjYiMDLi2qvfxrKHNNHaoRQYmh
 XAOE1XgnfXDukkpNsPCm1EEElsuxCZgBfXN+UewDpAHtydrB2q5DPELoXshQEY74xTGp1JrBNmT
 4hwuAA5VDbJQD1Hi2yZ8puQw8Sh9D4VP/KjtkwUdU2wHlPnebQSBPv79zEAVs5wi+tajCdF9Bnz
 CFpTgRL6zgCLE1GpAv6a93NNIfrAQB0tiSjkjzn/V/f1cDtBTijXO6D4FX/dN9m6UbPQk4S38yY
 3Dx6p6Qk4RCYd/s3A==
X-Received: by 2002:a05:690e:14c6:b0:67c:24d8:604b with SMTP id
 956f58d0204a3-67d89372b97mr5846292d50.21.1794900956266; Mon, 16 Nov 2026
 23:35:56 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1794221712.git.harsimransingh.tungal@arm.com>
 <e2d5fca8121bf452af978a2cef749b5add724d42.1794221712.git.harsimransingh.tungal@arm.com>
In-Reply-To: <e2d5fca8121bf452af978a2cef749b5add724d42.1794221712.git.harsimransingh.tungal@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 17 Nov 2026 09:35:20 +0200
X-Gm-Features: AclHuK94vfD4vL345EClADD_n2p6DTEsG-oFilgiykm_Vkrz7OjX_9uvHYGnjpk
Message-ID: <CAC_iWjJqjM1xs7BOh1c=HmKtojpGTJhJLxUEuSTF8KZRfb_H3w@mail.gmail.com>
Subject: Re: [PATCH v7 17/22] efi_loader: enable TEE runtime
 QueryVariableInfo() over FF-A
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: u-boot@lists.u-boot-project.org, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 10 Nov 2026 at 11:58, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
>
> Add the TEE-backed runtime QueryVariableInfo() implementation for the
> FF-A/MM variable backend. The runtime path uses the shared MM
> communication path after ExitBootServices() and returns the variable
> storage limits reported by the MM secure partition.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
>
> ---
> Changelog:
> ===============
>
> v6:
>
> Ilias:
>
> - Restore OP-TEE runtime callbacks when FF-A runtime mode is disabled
> - Rename FF-A QueryVariableInfo runtime handler with _ffa_runtime suffix
>
> v4:
>
> Ilias:
>
> - Split the runtime QueryVariableInfo() support out of the combined
>   runtime variable-services patch.
>
> v3:
>
> Ilias:
>
> - Rename TEE/FF-A runtime handlers to private *_int_runtime names
> ---

In order to call set variable at runtime EFI_RT_SUPPORTED_SET_VARIABLE
has to be enabled. Linux will mount efivarsfs as RO if that's not set
in the config table. How was this tested for runtime support?

Thanks
/Ilias
>  lib/efi_loader/efi_variable_tee.c | 64 +++++++++++++++++++++++++++++--
>  1 file changed, 60 insertions(+), 4 deletions(-)
>
> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> index 9bcdef5887f..5a887348c39 100644
> --- a/lib/efi_loader/efi_variable_tee.c
> +++ b/lib/efi_loader/efi_variable_tee.c
> @@ -1201,6 +1201,59 @@ out:
>         return ret;
>  }
>
> +/**
> + * efi_query_variable_info_ffa_runtime() - get information about EFI variables
> + *
> + * This function implements the QueryVariableInfo() runtime service for
> + * OP-TEE with FF-A runtime transport.
> + *
> + * See the Unified Extensible Firmware Interface (UEFI) specification for
> + * details.
> + *
> + * @attributes:                                bitmask to select variables to be
> + *                                     queried
> + * @max_variable_storage_size:         maximum size of storage area for the
> + *                                     selected variable types
> + * @remain_variable_storage_size:      remaining size of storage are for the
> + *                                     selected variable types
> + * @max_variable_size:                 maximum size of a variable of the
> + *                                     selected type
> + * Return:                             status code
> + */
> +efi_status_t EFIAPI __efi_runtime
> +efi_query_variable_info_ffa_runtime(u32 attributes, u64 *max_variable_storage_size,
> +                                   u64 *remain_variable_storage_size,
> +                                   u64 *max_variable_size)
> +{
> +       struct smm_variable_query_info *mm_query_info;
> +       efi_uintn_t payload_size;
> +       efi_status_t ret;
> +       u8 *comm_buf;
> +
> +       if (!max_variable_storage_size ||
> +           !remain_variable_storage_size ||
> +           !max_variable_size || !attributes)
> +               return EFI_INVALID_PARAMETER;
> +
> +       payload_size = sizeof(*mm_query_info);
> +       comm_buf = setup_mm_hdr((void **)&mm_query_info, payload_size,
> +                               SMM_VARIABLE_FUNCTION_QUERY_VARIABLE_INFO,
> +                               &ret);
> +       if (!comm_buf)
> +               return ret;
> +
> +       mm_query_info->attr = attributes;
> +       ret = mm_communicate(comm_buf, payload_size);
> +       if (ret != EFI_SUCCESS)
> +               return ret;
> +       *max_variable_storage_size = mm_query_info->max_variable_storage;
> +       *remain_variable_storage_size =
> +                       mm_query_info->remaining_variable_storage;
> +       *max_variable_size = mm_query_info->max_variable_size;
> +
> +       return ret;
> +}
> +
>  /**
>   * efi_set_variable_ffa_runtime() - runtime implementation of SetVariable()
>   *
> @@ -1281,9 +1334,10 @@ efi_set_variable_ffa_runtime(u16 *variable_name, const efi_guid_t *guid,
>  }
>
>  /**
> - * efi_query_variable_info() - get information about EFI variables
> + * efi_query_variable_info_runtime() - get information about EFI variables
>   *
> - * This function implements the QueryVariableInfo() runtime service.
> + * This function implements the QueryVariableInfo() runtime service for
> + * OP-TEE without FF-A runtime transport.
>   *
>   * See the Unified Extensible Firmware Interface (UEFI) specification for
>   * details.
> @@ -1357,18 +1411,20 @@ void efi_variables_boot_exit_notify(void)
>
>         /* Update runtime service table */
>         if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
> +               efi_runtime_services.query_variable_info =
> +                               efi_query_variable_info_ffa_runtime;
>                 efi_runtime_services.get_variable = efi_get_variable_ffa_runtime;
>                 efi_runtime_services.get_next_variable_name =
>                                 efi_get_next_variable_name_ffa_runtime;
>                 efi_runtime_services.set_variable = efi_set_variable_ffa_runtime;
>         } else {
> +               efi_runtime_services.query_variable_info =
> +                               efi_query_variable_info_runtime;
>                 efi_runtime_services.get_variable = efi_get_variable_runtime;
>                 efi_runtime_services.get_next_variable_name =
>                                 efi_get_next_variable_name_runtime;
>                 efi_runtime_services.set_variable = efi_set_variable_runtime;
>         }
> -       efi_runtime_services.query_variable_info =
> -                       efi_query_variable_info_runtime;
>         efi_update_table_header_crc32(&efi_runtime_services.hdr);
>
>         /* Record that ExitBootServices() has been called */
> --
> 2.43.0
>
