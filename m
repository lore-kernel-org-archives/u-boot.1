Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42210C3ABA9
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 06:51:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BF8A8070C;
	Fri,  2 May 2025 08:51:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Aj2ZhRw4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAD2180F03; Fri,  2 May 2025 08:51:03 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF5AE8059D
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 08:51:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5e5e8274a74so2602869a12.1
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 23:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746168661; x=1746773461; darn=lists.denx.de;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g/GXkki8CDJcG5HcNJYvETjAiI8Bot/5VZ4WjW3e2zI=;
 b=Aj2ZhRw4OI6IhDONXnBqd0oaBnN5eftNTR08BtghDOeJwmwpBTAO/sV9CPycfbQWeH
 Q6YaGKpNDqghqWu9Ce90u9Rsr9ejMtiSppgC1j8Z3avxFgXRFHF4Il4jXJTzpdjPFkyu
 PhvVaNSJmJIub2PQG+w+zkRdOMd7m1kY+BNGJFFfWMDmdQusOmS8bdS3Tvw1E4wmS2kS
 rm1+zHC9gW4j0ScfcVuvKTfc6xOZ0hxqpVuFoA921OkQXD1SwnWezoI7pvfLa/2NAJ3n
 7saUwHJlRkW1Fph0CS/hrOzob9uTwizwQRfBgviExmVogq5WzhEIhUQ69O2tfBxp672v
 JHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746168661; x=1746773461;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=g/GXkki8CDJcG5HcNJYvETjAiI8Bot/5VZ4WjW3e2zI=;
 b=ZFEyHq4aRDS0+6fUanyr2qbHUu6JMcpQrODUeK28IXr6lkjyVo+BaNOG765U9kqANW
 XGjELQOr2Q3Wsu+vCKp1bpO9ma+/bVp29mZeXquzLnWw/kscKkVnE/Pqr8Oznpm4V8TV
 oyPb7lbmDU2b7cO5aeZKwYf/+C3hX7Z2K6ubG/LbloGcobvX6RX3Jv2HIiFO7iox1b/j
 SgeSj7QMN3ZVinJgKXkLOEQsjg0BzK/kQXq/RNx08ceIMCIr830ZwbTuBVPB5xJsRM7k
 fHZiAIbQVrfFYD8lz5xmFaiHdrJumIe/q+uJlXUx1iKDd5724SbNFxYGPKj+qJrvtnkG
 brig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZhpwH+7F1iqMSVmNju3wrDe//MbzRWazEUxBCjYtPOMghtkZvBlj2//u6/FUX3aFmXx+Gd+k=@lists.denx.de
X-Gm-Message-State: AOJu0YzY+npjxuzXBJ9/a0LKCTaZDBFQGepyBMBzjz5nA8pnqM0QNOHv
 tyOBRz2feeORbqwyTHI6nC8HbkGgCnWEuC6ZePYWzuk1xm+6+CeAy6o+Tf1GT7k=
X-Gm-Gg: ASbGncsaK2MQgV+v86sAvmeoyo4Km2UN5YaRcfmBAGWiifdXxY5upQQLJEbZ+PaL+gX
 dVU7vSmeO0RMm1i4Klt8fjC6ZqanZw1ZQW/o9/cneY2GJW9r99lUiPsJRpnTeam6w3agIzFWL1H
 PjLNEwFP4hAbQukmsOQDV7o13F05U3fZN7R3guGvFs/nf1PMzn1PPWeXZ3G4L+92ZUTnF63pRm7
 k8hFXuKynzcOKhXek9RGI7TrE02MPM4rc8GDUPySADMmUHDitvu9qeQq2V8/bjvgsiFa9k6zjyD
 +Y28Aa9czmHYq6hf9819mQ+0LagXxEX7QpIhUKBPO2pet0Sw
X-Google-Smtp-Source: AGHT+IFvtJ26pbbVfARfEkF812AmIkoDWvqW9um5swgSsN8HEzhUd53WHiLKKhq1lq4vxKt7pb9pIQ==
X-Received: by 2002:a05:6402:1d50:b0:5f6:c4ae:d0cd with SMTP id
 4fb4d7f45d1cf-5fa7881e12fmr1109612a12.20.1746168661051; 
 Thu, 01 May 2025 23:51:01 -0700 (PDT)
Received: from localhost ([46.198.180.244]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa7792bdbcsm786928a12.42.2025.05.01.23.50.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 23:51:00 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 May 2025 09:50:58 +0300
Message-Id: <D9LH4NBVTI6Y.3CQ2ICBEYXZT3@linaro.org>
Subject: Re: [PATCH 1/5] lmb: replace lmb_reserve() and lmb_alloc_addr() API's
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Sughosh Ganu" <sughosh.ganu@linaro.org>, <u-boot@lists.denx.de>
Cc: "Tom Rini" <trini@konsulko.com>, "Casey Connolly"
 <casey.connolly@linaro.org>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Mark Kettenis" <kettenis@openbsd.org>, "Weijie Gao"
 <weijie.gao@mediatek.com>, "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Simon Glass" <sjg@chromium.org>
X-Mailer: aerc 0.20.0
References: <20250501120239.199829-1-sughosh.ganu@linaro.org>
 <20250501120239.199829-2-sughosh.ganu@linaro.org>
In-Reply-To: <20250501120239.199829-2-sughosh.ganu@linaro.org>
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

Hi Sughosh,

Thanks for cleaning this

[...]

> + * @flags:		Memory region attributes to be set
> + *
> + * Allocate a region of memory where the allocation is based on the para=
meters
> + * that have been passed to the function.The first parameter specifies t=
he
> + * type of allocation that is being requested. The align parameter is us=
ed
> + * to specify if the allocation is to be made with a particular alignmen=
t.
> + * It is 0 if there is no alignment requirement. The addr parameter is u=
sed

Use 0 for no alignment requirements

> + * to return the base address of the allocated region. Depending on the =
type
> + * of allocation request, it might also contain a particular address bei=
ng
> + * requested, or the maximum address of the requested allocation. The fl=
ags
> + * parameter is used to specify the memory attributes of the requested r=
egion.
> + *
> + * Return: 0 on success, -ve value on failure
> + *
> + * When the allocation is of type LMB_MEM_ALLOC_ADDR, the return value c=
an
> + * be -EINVAL if the requested memory region is not part of the LMB memo=
ry
> + * map, and -EEXIST if the requested region is already allocated.
> + */
> +int lmb_allocate_mem(enum lmb_mem_type type, u64 align, phys_addr_t *add=
r,
> +		     phys_size_t size, u32 flags);
> +

[...]

> +}
> +
> +int lmb_allocate_mem(enum lmb_mem_type type, u64 align, phys_addr_t *add=
r,
> +		     phys_size_t size, u32 flags)
> +{
> +	int ret =3D -1;
> +
> +	if (!size)
> +		return 0;

Shouldn't this be an error as well?

> +
> +	if (!addr)
> +		return -EINVAL;
> +
> +	switch (type) {
> +	case LMB_MEM_ALLOC_ADDR:
> +		ret =3D _lmb_alloc_addr(*addr, size, flags);
> +		break;
> +	default:
> +		log_debug("%s: Invalid memory allocation type requested %d\n",
> +			  __func__, type);
>  	}
>
> -	return -1;
> +	return ret;
>  }
>
>  /* Return number of bytes from a given address that are free */
> diff --git a/test/lib/lmb.c b/test/lib/lmb.c
> index 3bf558f7f4f..f80115570e7 100644
> --- a/test/lib/lmb.c
> +++ b/test/lib/lmb.c
> @@ -71,6 +71,19 @@ static int setup_lmb_test(struct unit_test_state *uts,=
 struct lmb *store,
>  	return 0;
>  }
>

[...]

Thanks
/Ilias
