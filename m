Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52812C54FCC
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 09:11:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E577C83DAE;
	Fri, 20 Feb 2026 10:11:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uTrE3el6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F34D583DC9; Fri, 20 Feb 2026 10:11:29 +0100 (CET)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4804983AC5
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 10:11:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-64ad019bbd4so1789581d50.0
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 01:11:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771578685; cv=none;
 d=google.com; s=arc-20240605;
 b=M620nNwKUMLhP3rHOfUCV9s3RRdxF9rBa14ZjSflZ8R6xxGJpsnTetoO1eNhKB1Su6
 6nMNEQ5vpTlljIkCnBCv3OM6bDSgvfblhUenyuu9aw/E06h3rCfNHj2v9Yupgp2UcP54
 d3Mn5YA2dFcGgvT28pkLXoj/tgQvV58uIuaUMUuJnB/atncHQ3QK8GW66t6uLtNPFrB1
 vmQbYMbmSr8FxMXOJiAd0jA4CjWPJ3aQOwE+2gvG+lQoNCwx1AbMhfW10r9dgNn//hsU
 iTdOH+064ZtKhjv9buwIXUWA0wgfJlX8RxgAS6BfH7GQ9E+Ledppy8gqgQm4P4ZpBF3P
 u17Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aN6986MaRPvrIdVXqwRRmD2jCEL9z1QJAZ2JzpasCDs=;
 fh=qVPXZENsT8HTjc1yhpZmugGERdHloY1MZQ2O3ZL3iu8=;
 b=X+u9R/ekErqwgAjwCbW26rBSe96xE17J+v1AIbrE0HgvHt/bduzg4awP7rfu3kIekA
 cdWjCv6jV8wjIC0nRouwHBKZDeRVmj5zqEtS9UfkKBW8uHbgMDNI0kLkUqA6lqs1aasP
 0OvNdtduXpSZw7MkoIW5hlG1ZYgOQi+zx+2djNTCCwdGk8WSPkByqI8YV5q7HMh1hJ0b
 5ibdiy/9I0zdYaxaX2PLO+w847axi4u/L5G5g4xPSUvLyxKxo3eS7ZQYTAM3WI+g09QO
 shpmARW0ns16ZXcRHIj3OrMo9ouCHdBkSuguyaRA9e+x8kxVGkk7yEGJYSUq4Hw/TFrP
 ek6Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771578685; x=1772183485; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aN6986MaRPvrIdVXqwRRmD2jCEL9z1QJAZ2JzpasCDs=;
 b=uTrE3el60khmFn0fMaJbSPLkINwr1sPUOmDLPFojFYRIIfMfJXrtWTGHc/st8RMcvx
 1QpuMUy+RDwWfqJQp4d9vJYwk/jfePYE14Rr/kEJhtNIHqtwLOTl3JfqD/mfa9tRNETa
 6QbmepvhWwRmOu3gL7WtfDNB0emKSgG5UburV5SgwUUoHqlL2jfzCFzN+k76dVs06nYm
 l/YZEvGmhDmfiOrkjR+y+D7ixI7SJY/ANoZil6lOdmYx5YgUK8pL8Rfz7JoRkfZ5e30G
 /iI300uEJ8W58RRm32+cPGsypCE71xnhjSB8/VZrF+PwrIP5gdBhUrxcX01+98Vp50tn
 LF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771578685; x=1772183485;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aN6986MaRPvrIdVXqwRRmD2jCEL9z1QJAZ2JzpasCDs=;
 b=crvaPkhgBvqXUQ2kvKMuJtaNFdXeE1/t9fj2j41UyyQHylIO75FLV9Xu7TvK9X08OE
 BQHgiqfeeJ/jiSdYOzpwHt9eCPkQnZUBFwJ9JSDYTFItnBugSL6AGSHJlITs9MDhvmPR
 Mc2SbhHB5VYZbtf1NdxH5mxmdeD3bgSbK1C3LMNS4+TYDHGPqRkgEnYhRi36JXLQ3oM+
 CpTrXWu6fasSlzwJaULln0Vp1lUncE5R3oFspR2vrr8DmvTkJ6KrEEjuvd9OFtQjyT0S
 KouOw/trJRFOOoeaSxgvBV94qkNp9N2WbpWRQ9LLiovrI10XJmeI1z0gGKpWkfBmTSmz
 JgHA==
X-Gm-Message-State: AOJu0Yxsk/qLQyDYOte8RJPs+yjc9g79l0ssfRSu0KdIHxo78CD3UyM9
 7PHg0GKtlMxQPuuqunX1HrqiKNn0ACV957N6BsvCNmrSPma5GYESV/mKDJp9olbfYS3WblYBMjs
 +/nqoLV71laQQrIrz0HTs2p1yt7iIGxCqES4ApARQeg==
X-Gm-Gg: AZuq6aIxHTUL5r/cEEKnEUVv4qpwSIn8oSNPJdouBSqL7i8t2mfQ9upBTtAGye8bs1A
 FkfP95VQnbrK9P8yq4rC7mmKG3UGZfdOW5qa/PssmAJW9t/0Rqg9Uh/fbejo6Np6vF5fb8oKcj0
 i8VqXK0MGkVZnq86xcjG/4gPbwRJbPEYKog5rWKOikK/blLWB11akHMZx9/M/Xp5mKC7woU+vqz
 GP6h87Yna1DDdapfKDHxs9zPXDK9w6TnUNtBDzrkVDE7SxyJ5UyYzuo+pWUu9E2TwN/3nfrpt5g
 w9kZlC2SvS1mwVRPZPzTlhnQVghz1+IGeoNnK8NzPbQNBwRKhsIE5qWjWYaoAcOcRBffsEEVS2/
 sEA6bKsSsl3P3TLyiHZNK5qq83OE+qh+WZAVBSBuRhqvlhXyBcQ7XQBU0K4Afv7eMBW81x5Vl/U
 MEhfspNerTN2jjtr6o0CVdJhBW/xm0xhpxLuiaWpmFpekJ/GiP7AeWtB/jyAbvQOvjjviIK5r8d
 gDdiL5sf4pn+P/Q2978cVlFKCvtEwPRTU3Ki18raeweaScQ0Vlp9otpqQg7YJUdSiEloGEn/FN3
 hVinJTv/AzrWc8mnHXOgg7Jw31bxiw+kVa2kt3Jbe1HV
X-Received: by 2002:a53:ac83:0:b0:64a:e142:a099 with SMTP id
 956f58d0204a3-64c21abcacdmr13981818d50.41.1771578685061; Fri, 20 Feb 2026
 01:11:25 -0800 (PST)
MIME-Version: 1.0
References: <20260219184400.257008-1-vincent.stehle@arm.com>
 <20260219184400.257008-3-vincent.stehle@arm.com>
In-Reply-To: <20260219184400.257008-3-vincent.stehle@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 20 Feb 2026 11:10:48 +0200
X-Gm-Features: AZwV_Qiz-D_C0NStzW7rFDLAmZGGAnwisBjsaDqbbG8dQwO90MGPJrTydGJVgSo
Message-ID: <CAC_iWjJ_yrUx-ToS7GeFO_hD=845vEcf_P5xBtB5oe=JadDr3Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] efi_selftest: fix buffer overflow and memory leak
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
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

On Thu, 19 Feb 2026 at 20:44, Vincent Stehl=C3=A9 <vincent.stehle@arm.com> =
wrote:
>
> The test of the UEFI UninstallMultipleProtocolInterfaces() function clear=
s
> a buffer returned by LocateHandleBuffer() at some point, but there is an
> error in the size computation, which leads to a buffer overflow.
> The buffer is also never freed, which leads to a memory leak.
>
> As the buffer is in fact not reused during the test, fix both errors by
> simply freeing the buffer.
>
> Fixes: 927ca890b09f ("efi_selftest: test protocol management")
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


>  lib/efi_selftest/efi_selftest_manageprotocols.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_selftest/efi_selftest_manageprotocols.c b/lib/efi_se=
lftest/efi_selftest_manageprotocols.c
> index ccffa59095d..0334a074866 100644
> --- a/lib/efi_selftest/efi_selftest_manageprotocols.c
> +++ b/lib/efi_selftest/efi_selftest_manageprotocols.c
> @@ -319,7 +319,12 @@ static int execute(void)
>                 efi_st_error("Failed to locate new handle\n");
>                 return EFI_ST_FAILURE;
>         }
> -       boottime->set_mem(buffer, sizeof(efi_handle_t) * buffer_size, 0);
> +       /* Release buffer */
> +       ret =3D boottime->free_pool(buffer);
> +       if (ret !=3D EFI_SUCCESS) {
> +               efi_st_error("FreePool failed\n");
> +               return EFI_ST_FAILURE;
> +       }
>
>         /*
>          * Test ProtocolsPerHandle
> --
> 2.51.0
>
