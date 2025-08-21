Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0643CA0EEB
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 13:24:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15A6A80548;
	Thu, 21 Aug 2025 15:24:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="spswXO74";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2C2980B9B; Thu, 21 Aug 2025 15:24:41 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6F8980422
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 15:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-437727c903aso288150b6e.1
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 06:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755782677; x=1756387477; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PDcK3AKb8+OjYloNyqOmvHjTKsFJ9vW3H9nTmQ7Etrw=;
 b=spswXO74TYtJX+jqZIrGJd0Gvt877IjnI51OgusDOOGEmDpC75iufQqU8Nf+HOrPrN
 rHsKRctk6FSol1ZpU1aKt5J2tSSct839xwFyg33phZ3DbIhx6mO/d8HzuBBrhCeozV/i
 sWz7rkzYvRZEGFE1eZDiKdVSug/DcgPOj8TgE4Hat/CQsVQ5sM1IawQC1LdG6VOughln
 qRzUTLBO24Kgt46jGKPHEcGacrei80Xhwk7pgADbFn+44VaDHFgAl4xF/0stcbyFKR14
 eUKkunC+DYQzlopfOD6AjA53s8hdQcSDNSPv2ukmzWVf0bqHJ6vkx5o1+kChAEHoy6ld
 USmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755782677; x=1756387477;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PDcK3AKb8+OjYloNyqOmvHjTKsFJ9vW3H9nTmQ7Etrw=;
 b=KWgOHQg0fs3AP8qMwkkeDv5YMfivglf8K9Dn+ooZoXObDZlVHBjuu09WhpAYRmi+BU
 XSClT3biupc/CR62RqQlvTyoi6h0Wju5vFOcQhCHhP69+2f8km7k1J62HDNHs9tFsjtu
 xD0LghEh2f4LwFv6eWl+WnYJX74ZiV9pUV92o/tHTOoQwkqtNHI4UhPICvAjka2eBMmA
 awBbgc42mwJB4jaHYkND71po4OmzLLeSzyfWRIO7xYMG6D6ysXB1Vtaw2Y6Yu/X1sbNx
 kRnd6jCPSJFq2Tb4O6Gto5+VIdEfthr4k62KYj5hk0wyB+CK7FqRfYFRPvdmUCcab2jI
 fgZw==
X-Gm-Message-State: AOJu0YxobiG1zcBEEp2H/ubY4lZD0m4CoNmcB++H2UmpOy6FsRySUooU
 ybLThmo3ykTHCRtbiek1D1zsfTx2AJGuk7gZZbt7A43h4ZzrPlLipef4pFQnCu1mcs4ZnJpSVu3
 K6Qvw7aZRys4elE3H0AMaW3exbUXewArVZLjii/KJWA==
X-Gm-Gg: ASbGnctrIY47UK8EXO0N8sYNL0lVz4NKWJ6Bi8Zcy4HjRVv1vGpouxpc4FWVEP3Gpyw
 YBBVBxO9edlYWRCVllWcfObyTqK3CdRox0X4iOGhQy2N4RZQSZddP5/Xa0mY5ze9i7QbPmuUYBK
 rqUcijlxbX4zyxMbERs1XWoTQucWAFQXFIXnG70Bf/vVnrFELyKb2FXCS0QxGEVeSl8wDH2YEZ8
 2qI5iZH
X-Google-Smtp-Source: AGHT+IGuLlArOcweaz8Gm3XqGiPFGauRJCn6ycyF6Ojj0yPlG3x/LrpAY54JLTv06lITQ0UPWAWypB/3qAKOdv1kPog=
X-Received: by 2002:a05:6808:2385:b0:433:fd5b:ca78 with SMTP id
 5614622812f47-4377d796411mr1011638b6e.31.1755782677142; Thu, 21 Aug 2025
 06:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250711144917.1876948-1-abdellatif.elkhlifi@arm.com>
 <20250711144917.1876948-4-abdellatif.elkhlifi@arm.com>
In-Reply-To: <20250711144917.1876948-4-abdellatif.elkhlifi@arm.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 21 Aug 2025 15:24:25 +0200
X-Gm-Features: Ac12FXxEdywJBvAFxyuJYeLfpBwsOCxKTXoi9jLpN3WdzATNDxeDgEqxt2tmRt8
Message-ID: <CAHUa44GFo2e85BKN_SFzC32KsS5sLAHbjYQVeoKOk8uyf+YJog@mail.gmail.com>
Subject: Re: [PATCH v2 03/25] arm_ffa: Add FFA_MEM_RECLAIM support
To: abdellatif.elkhlifi@arm.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Fri, Jul 11, 2025 at 4:49=E2=80=AFPM <abdellatif.elkhlifi@arm.com> wrote=
:
>
> From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>
> Add to the FF-A bus FFA_MEM_RECLAIM ABI
>
> The FFA_MEM_RECLAIM is a memory management ABI described in the FF-A
> v1.0 specification [1].
>
> This ABI restores exclusive access to a memory region back to its Owner.
>
> This work is based on the implementation in Linux [2].
>
> [1]: https://developer.arm.com/documentation/den0077/a/?lang=3Den
> [2]: commit cc2195fe536c28e192df5d07e6dd277af36814b4
>      File: drivers/firmware/arm_ffa/driver.c
>
> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jens Wiklander <jens.wiklander@linaro.org>
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Looks good to me:
Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

Cheers,
Jens

>
> ---
>
> Changelog of changes:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>
> v2:
>
> * As suggested by Heinrich: The ops NULL check removed
>
> v1:
>
> * Add FFA_MEM_RECLAIM support
>
>  doc/arch/arm64.ffa.rst                    |  2 +
>  drivers/firmware/arm-ffa/arm-ffa-uclass.c | 73 +++++++++++++++++++++++
>  drivers/firmware/arm-ffa/arm-ffa.c        |  1 +
>  include/arm_ffa.h                         | 25 +++++++-
>  include/arm_ffa_priv.h                    |  3 +-
>  5 files changed, 102 insertions(+), 2 deletions(-)
>
> diff --git a/doc/arch/arm64.ffa.rst b/doc/arch/arm64.ffa.rst
> index 3eec735d741..d2c4fb49f79 100644
> --- a/doc/arch/arm64.ffa.rst
> +++ b/doc/arch/arm64.ffa.rst
> @@ -186,6 +186,7 @@ The following features are provided:
>      - FFA_MSG_SEND_DIRECT_REQ
>      - FFA_MSG_SEND_DIRECT_RESP
>      - FFA_MEM_SHARE
> +    - FFA_MEM_RECLAIM
>
>  - Support for the 64-bit version of the following ABIs:
>
> @@ -205,6 +206,7 @@ The following features are provided:
>      - ffa_sync_send_receive
>      - ffa_rxtx_unmap
>      - ffa_memory_share
> +    - ffa_memory_reclaim
>
>  - FF-A bus discovery makes sure FF-A framework is responsive and compati=
ble
>    with the driver
> diff --git a/drivers/firmware/arm-ffa/arm-ffa-uclass.c b/drivers/firmware=
/arm-ffa/arm-ffa-uclass.c
> index 9af574760d2..b9b66bf68f9 100644
> --- a/drivers/firmware/arm-ffa/arm-ffa-uclass.c
> +++ b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
> @@ -109,6 +109,18 @@ static struct ffa_abi_errmap err_msg_map[FFA_ERRMAP_=
COUNT] =3D {
>                         "DENIED: Memory region ownership, permission, acc=
ess or attributes error",
>                 },
>         },
> +       [FFA_ID_TO_ERRMAP_ID(FFA_MEM_RECLAIM)] =3D {
> +               {
> +                       [ABORTED] =3D
> +                       "ABORTED: ABI invocation failure",
> +                       [INVALID_PARAMETERS] =3D
> +                       "INVALID_PARAMETERS: Invalid handle or flags",
> +                       [NO_MEMORY] =3D
> +                       "NO_MEMORY: Failure to create the Owner's mapping=
",
> +                       [DENIED] =3D
> +                       "DENIED: Memory region state issue",
> +               },
> +       },
>  };
>
>  /**
> @@ -1114,6 +1126,44 @@ int ffa_memory_share_hdlr(struct udevice *dev, str=
uct ffa_mem_ops_args *args)
>         return ffa_memory_ops(dev, FFA_MEM_SHARE, args);
>  }
>
> +/**
> + * ffa_memory_reclaim_hdlr() - FFA_MEM_RECLAIM handler function
> + * @dev: The FF-A bus device
> + * @g_handle: The memory region globally unique Handle
> + * @flags: Zero memory and time slicing flags
> + *
> + * Implement FFA_MEM_RECLAIM FF-A function
> + * to restore exclusive access to a memory region back to its Owner.
> + * Note: FFA_MEM_RECLAIM can not be used at EFI runtime because memory t=
hat was
> + * lent as per the memory map during boot time can not be reclaimed into=
 the
> + * memory map during runtime.
> + *
> + * Return:
> + *
> + * 0 on success. Otherwise, failure
> + */
> +int ffa_memory_reclaim_hdlr(struct udevice *dev, u64 g_handle, u32 flags=
)
> +{
> +       ffa_value_t res;
> +       int ffa_errno;
> +
> +       invoke_ffa_fn((ffa_value_t){
> +                       .a0 =3D FFA_SMC_32(FFA_MEM_RECLAIM),
> +                       .a1 =3D HANDLE_LOW(g_handle), .a2 =3D HANDLE_HIGH=
(g_handle),
> +                       .a3 =3D flags,
> +                       },
> +                       &res
> +       );
> +
> +       if (res.a0 !=3D FFA_SMC_32(FFA_SUCCESS)) {
> +               ffa_errno =3D res.a2;
> +               ffa_print_error_log(FFA_MEM_RECLAIM, ffa_errno);
> +               return ffa_to_std_errno(ffa_errno);
> +       }
> +
> +       return 0;
> +}
> +
>  /* FF-A driver operations (used by clients for communicating with FF-A)*=
/
>
>  /**
> @@ -1216,6 +1266,29 @@ int ffa_memory_share(struct udevice *dev, struct f=
fa_mem_ops_args *args)
>         return ops->memory_share(dev, args);
>  }
>
> +/**
> + * ffa_memory_reclaim() - FFA_MEM_RECLAIM driver operation
> + * @dev: The FF-A bus device
> + * @g_handle: The memory region globally unique Handle
> + * @flags: Zero memory and time slicing flags
> + *
> + * Driver operation for FFA_MEM_RECLAIM.
> + * Please see ffa_memory_reclaim_hdlr() description for more details.
> + *
> + * Return:
> + *
> + * 0 on success. Otherwise, failure
> + */
> +int ffa_memory_reclaim(struct udevice *dev, u64 g_handle, u32 flags)
> +{
> +       struct ffa_bus_ops *ops =3D ffa_get_ops(dev);
> +
> +       if (!ops->memory_reclaim)
> +               return -ENOSYS;
> +
> +       return ops->memory_reclaim(dev, g_handle, flags);
> +}
> +
>  /**
>   * ffa_do_probe() - probing FF-A framework
>   * @dev:       the FF-A bus device (arm_ffa)
> diff --git a/drivers/firmware/arm-ffa/arm-ffa.c b/drivers/firmware/arm-ff=
a/arm-ffa.c
> index df904cae412..de36f5647d2 100644
> --- a/drivers/firmware/arm-ffa/arm-ffa.c
> +++ b/drivers/firmware/arm-ffa/arm-ffa.c
> @@ -85,6 +85,7 @@ static const struct ffa_bus_ops ffa_ops =3D {
>         .sync_send_receive =3D ffa_msg_send_direct_req_hdlr,
>         .rxtx_unmap =3D ffa_unmap_rxtx_buffers_hdlr,
>         .memory_share =3D ffa_memory_share_hdlr,
> +       .memory_reclaim =3D ffa_memory_reclaim_hdlr,
>  };
>
>  /* Registering the FF-A driver as an SMCCC feature driver */
> diff --git a/include/arm_ffa.h b/include/arm_ffa.h
> index b91b0279371..1229e6e3d02 100644
> --- a/include/arm_ffa.h
> +++ b/include/arm_ffa.h
> @@ -147,8 +147,9 @@ struct ffa_mem_ops_args {
>   * struct ffa_bus_ops - Operations for FF-A
>   * @partition_info_get:        callback for the FFA_PARTITION_INFO_GET
>   * @sync_send_receive: callback for the FFA_MSG_SEND_DIRECT_REQ
> - * @rxtx_unmap:        callback for the FFA_RXTX_UNMAP
> + * @rxtx_unmap:                callback for the FFA_RXTX_UNMAP
>   * @memory_share:      callback for the FFA_MEM_SHARE
> + * @memory_reclaim:    callback for the FFA_MEM_RECLAIM
>   *
>   * The data structure providing all the operations supported by the driv=
er.
>   * This structure is EFI runtime resident.
> @@ -161,6 +162,7 @@ struct ffa_bus_ops {
>                                  bool is_smc64);
>         int (*rxtx_unmap)(struct udevice *dev);
>         int (*memory_share)(struct udevice *dev, struct ffa_mem_ops_args =
*args);
> +       int (*memory_reclaim)(struct udevice *dev, u64 g_handle, u32 flag=
s);
>  };
>
>  #define ffa_get_ops(dev)        ((struct ffa_bus_ops *)(dev)->driver->op=
s)
> @@ -280,6 +282,27 @@ int ffa_memory_share(struct udevice *dev, struct ffa=
_mem_ops_args *args);
>   */
>  int ffa_memory_share_hdlr(struct udevice *dev, struct ffa_mem_ops_args *=
args);
>
> +/**
> + * ffa_memory_reclaim() - FFA_MEM_RECLAIM driver operation
> + * Please see ffa_memory_reclaim_hdlr() description for more details.
> + */
> +int ffa_memory_reclaim(struct udevice *dev, u64 g_handle, u32 flags);
> +
> +/**
> + * ffa_memory_reclaim_hdlr() - FFA_MEM_RECLAIM handler function
> + * @dev: The FF-A bus device
> + * @g_handle: The memory region globally unique Handle
> + * @flags: Zero memory and time slicing flags
> + *
> + * Implement FFA_MEM_RECLAIM FF-A function
> + * to restore exclusive access to a memory region back to its Owner.
> + *
> + * Return:
> + *
> + * 0 on success. Otherwise, failure
> + */
> +int ffa_memory_reclaim_hdlr(struct udevice *dev, u64 g_handle, u32 flags=
);
> +
>  struct ffa_priv;
>
>  /**
> diff --git a/include/arm_ffa_priv.h b/include/arm_ffa_priv.h
> index a259911d5b9..54196199ce3 100644
> --- a/include/arm_ffa_priv.h
> +++ b/include/arm_ffa_priv.h
> @@ -133,10 +133,11 @@ enum ffa_abis {
>         FFA_MSG_SEND_DIRECT_REQ   =3D 0x6f,
>         FFA_MSG_SEND_DIRECT_RESP  =3D 0x70,
>         FFA_MEM_SHARE             =3D 0x73,
> +       FFA_MEM_RECLAIM           =3D 0x77,
>
>         /* To be updated when adding new FFA IDs */
>         FFA_FIRST_ID              =3D FFA_ERROR, /* Lowest number ID */
> -       FFA_LAST_ID               =3D FFA_MEM_SHARE, /* Highest number ID=
 */
> +       FFA_LAST_ID               =3D FFA_MEM_RECLAIM, /* Highest number =
ID */
>  };
>
>  enum ffa_abi_errcode {
> --
> 2.25.1
>
