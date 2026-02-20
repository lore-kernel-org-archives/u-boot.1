Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666B0C53216
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 07:42:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9C8D83D0F;
	Fri, 20 Feb 2026 08:42:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="t+0CdO5u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E80CA83D17; Fri, 20 Feb 2026 08:42:30 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03B4F83AA9
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 08:42:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4833115090dso16463175e9.3
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 23:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771573348; x=1772178148; darn=lists.denx.de;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kMVioKOZnTgcq1kDwVoGd9/gjyjtrrE7iGoz95n8lfc=;
 b=t+0CdO5uJmTgiRlT7mG2bMycrbFjlxM4Wqeg3iGLdUCgK2tnTjIEHl4VPcE9zJUb5G
 ny0LMWgEUdtapnhea8ZFLrJKE2muqtWQ1jb8tbbFusbT9mq3qz3uE8CL+NlmwyaeyYWz
 phXfTYHtujcUaGTEeePtgDytXXC0d25f3PONrGsHCNiN3t24tm3heEAVG5Ur/fc6nvuN
 HExqMe1jtj7udiqHsL/lCZdlAveACZltUTJsn76y/evd5647YXG+p2sRPLJj2iFoAwk5
 Hl05w9BGlce1mvzrk5seD75JOssxcCU+ci1xjqEoNyOAWogNNKwXqzayIZpyk09eUjjw
 OkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771573348; x=1772178148;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kMVioKOZnTgcq1kDwVoGd9/gjyjtrrE7iGoz95n8lfc=;
 b=T/DOz51ISxj8/ON50FhPOT4hFBL0ctcIUIeEdkGIocZJU6YwMxl/WWHiNWlxm/3aXY
 WenHvIsyDWU7gsUdFH8THgquIuTcIeMl6pXreRSb6LJAvTLCw2SURBNPRU+yWCHHqu3X
 laj9vi7r2auMNWWQb7BL7wuaK7bFEwe5oPyyEHjCL/cMqTVwjqlnBGJvpzXF9ipVyoMA
 oOwzmj6mu7e2TmQo3mZ73lcvNho5SWgw1nTSr6b+HfWeTFuENmGGi1/087u3hEqoZvWZ
 fSnfFRcHKoNlqT5JM0f/kFKT89w/yUPubN/TaWsW6XgxVLI8mcBXZ9LdtHFGI0XINuSH
 WweQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF9sv+5d7Xp/nFAT9rM3swQvMGVLw03tozsiD0aB+5tGybMJP2XZjCxFQk0jOZWKw1tT6kzyk=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6oafGR3SMDK4vZcQk/AP4c+q+37MGVRorbOw7ZfRhaVtiK5Ex
 7f+Wp7VfxZ/MlB1PI/2E80xgsjd5d5Ek8K0mikMwTM3bJVxlp2TtatVnyUyJMunqCu8=
X-Gm-Gg: AZuq6aKol8n/K5rqYMwPzUYy5pbHCednSScT8WpzBp7iSKDuY6KyQgICgxQmvXfMpHH
 j2jSSe0P6l0EH0YrzNhCnQOLayDJlk45If9R8OebaOMCTCK2lWbCF9YZtcvl+8TOy06Z04g7Lzq
 eNNVosw/O/t1RwBoFMnarG9mT3IgrM7bWapRqXkhOLVxtbBr6SJGNsJopjQRs2z0Ku1rxuJsoJC
 HM0Afixnayq+pi5weyv2sTevnhp/DMfhdpODsNwkAuxeA2SnJ2XmBuuWGUkrwwKgqbOy1T8Ohkn
 6sa/wtWn61LzaOxPgh+eNe2wzC4CgRgS7fxPbJL087MiGtIgYssW0ef9BQk0jknUjC6CN6ezjHG
 6h+ZIpXtQ1IrdrWT6cCD7uQhNHR2weNCTCGV6eHyb+/kdytj2jTnWcAl6GoLB++OmTIMwsJlbXM
 jQQy3adyme1WcqT6E1WX/CGpuw9OvXviVRgGXsAlABhxhfUT+LUyM+ugzkcAbxGdG5IgOp++EHx
 0zJpaNgHDhV4uikx2mJPy3JjBArzazOY9rIAuNosQY/NUVLEE1E0gf4+iURueZ1rfkPbA+rGkY3
 TTPqd/Wr6EMTXx1XkR3EcYc8YbrCgP/lZALkd4QqtM+/zcrVvUkifDFXL3r+/RCdrK/DTPiJ5Wh
 FixTeOP9MjryTDaVoo8aBLhI01A5YsixT+nJOx4oMxrC5FO7KzkZowAUJYwG/Yyy8kBcdAiEiY0
 h2UxwFaRJjai5KS3dm6RWHOP70yQT4y3TNc8weXgPNYZ2aaWCbsuKLt+xGALUGCCV6GbM=
X-Received: by 2002:a05:600c:1987:b0:483:79a6:e7e1 with SMTP id
 5b1f17b1804b1-48398a4839bmr145594605e9.7.1771573348348; 
 Thu, 19 Feb 2026 23:42:28 -0800 (PST)
Received: from localhost ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31c54bbsm56945125e9.9.2026.02.19.23.42.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 23:42:27 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Feb 2026 09:42:26 +0200
Message-Id: <DGJMC88FVICX.SS7SO674VQB4@linaro.org>
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 <u-boot@lists.denx.de>
Cc: "Heinrich Schuchardt" <xypron.glpk@gmx.de>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>, "Tom Rini" <trini@konsulko.com>
Subject: Re: [PATCH 5/5] efi_selftest: cosmetic: fix spelling in comments
X-Mailer: aerc 0.21.0
References: <20260219184400.257008-1-vincent.stehle@arm.com>
 <20260219184400.257008-6-vincent.stehle@arm.com>
In-Reply-To: <20260219184400.257008-6-vincent.stehle@arm.com>
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

On Thu Feb 19, 2026 at 8:44 PM EET, Vincent Stehl=C3=A9 wrote:
> Fix a few UEFI function names, as well as a typo.
>
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/efi_selftest/efi_selftest_manageprotocols.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/lib/efi_selftest/efi_selftest_manageprotocols.c b/lib/efi_se=
lftest/efi_selftest_manageprotocols.c
> index f07ff256ce1..a096e8c2b01 100644
> --- a/lib/efi_selftest/efi_selftest_manageprotocols.c
> +++ b/lib/efi_selftest/efi_selftest_manageprotocols.c
> @@ -6,7 +6,7 @@
>   *
>   * This unit test checks the following protocol services:
>   * InstallProtocolInterface, UninstallProtocolInterface,
> - * InstallMultipleProtocolsInterfaces, UninstallMultipleProtocolsInterfa=
ces,
> + * InstallMultipleProtocolInterfaces, UninstallMultipleProtocolInterface=
s,
>   * HandleProtocol, ProtocolsPerHandle,
>   * LocateHandle, LocateHandleBuffer.
>   */
> @@ -188,7 +188,7 @@ static int execute(void)
>  	}
>
>  	/*
> -	 * Test error handling in UninstallMultipleProtocols
> +	 * Test error handling in UninstallMultipleProtocolInterfaces
>  	 *
>  	 * These are the installed protocol interfaces on handle 2:
>  	 *
> @@ -238,7 +238,7 @@ static int execute(void)
>  		efi_st_error("LocateHandleBuffer failed to locate new handle\n");
>  		return EFI_ST_FAILURE;
>  	}
> -	/* Clear the buffer, we are reusing it it the next step. */
> +	/* Clear the buffer, we are reusing it in the next step. */
>  	boottime->set_mem(buffer, sizeof(efi_handle_t) * count, 0);
>
>  	/*
> @@ -287,7 +287,7 @@ static int execute(void)
>  	}
>
>  	/*
> -	 * Test UninstallMultipleProtocols
> +	 * Test UninstallMultipleProtocolInterfaces
>  	 */
>  	ret =3D boottime->uninstall_multiple_protocol_interfaces(
>  						handle2,

