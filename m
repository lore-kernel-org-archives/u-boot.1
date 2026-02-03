Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5D6E7C712
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 01:44:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A2DC83F86;
	Tue,  3 Feb 2026 02:44:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OJeGnyWt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27B5683F93; Tue,  3 Feb 2026 02:44:34 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EEB983F54
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 02:44:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-382fceabddfso40066571fa.1
 for <u-boot@lists.denx.de>; Mon, 02 Feb 2026 17:44:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770083071; cv=none;
 d=google.com; s=arc-20240605;
 b=IQJY1eacCxMs9JqfvWfsRv8+yiOdHqATKfSv85wtHoVKNPpudraJhE8IEPg6KE0BYe
 TCq108P//aE41tY7NkEpdt+fSHQB1PAMGV+Gf2ruv597JH3/qTCIERrTMVn4Olv8j6Wj
 n3W+8Zgv0NZ9sIx0kJFHjBVA3zIPwWiHjP6p8LTXk2m93MOWhr5g6qAE8rqK+Pj4+BkP
 TH6sBcr7QAMduuhdYmDW0M8pclCx86crchf3LPpaZtX5kgDcw7tMsHxsdulofLuU9bEo
 q1agrKgnhRV0VAZbi/xbkEdt3tEZjI79avdexb+Mut2O4HSowrb5HxRrKDPfI7zj/VxB
 CsQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=j03ku4j1zf7QdtWIYzgaBcW8eL2taulvlqaEQbv3ZQ8=;
 fh=2xEgSQRlgmkN0vjkLC8hN0dZOJFO9HwEkXzYdbM+Pvo=;
 b=gFOFL84zFH397G/csvP1wfVY2T+E3ow3La/nej2SqCUmCsvz3ZOJnBB4a+VwzsfIPJ
 WTDOAVBdeMrvTLz/kyI6irYqNSUqOW+3s6fnY5ENu37fTAhRPopPSGf/ieITU9FJ8X3Y
 HYmm/SDSRpJ1rUBvLksAZfSwRvAqZFlHldr3tjhCYXR4C1pQ95T+uXCe2JVMkVOdpLDN
 MjY8zzI1twxhgnnxhjUDbLdi8eGRpALJwkpBCjLU+nepyEqtsjxK2C8M/i3DGzWHwJNs
 4csBghD+QXf3WzYVgi+YArqR4Poj23WOnaFIQeWZ8dPqZMSsEDe+pw96J/cAYG5DruDQ
 Xf6w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770083071; x=1770687871; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j03ku4j1zf7QdtWIYzgaBcW8eL2taulvlqaEQbv3ZQ8=;
 b=OJeGnyWtrV+d8naYkCjfVji/9yTooYnFCm3UFEVquflyL1+hgxZxV+yzM86SSa/9gn
 PszESn9ad/fNS5DIbOEDWwhCqRYYCpk6DlXsly8s08DDR+/GNNkI8EzRXdCfll1choH+
 xCxNkpa+pF9QDLRvzjunuoHdjp4mi06EWxEgqC8gNvdnvKXOVcbvbNfZu1bnSjpVBqxq
 tDBJOVYtHm4HH5mdqabdIBzQe+GjA0sH4Dcc/yWHj75fqHitR2JpESxug4Hvx4QBQJ31
 okSPjPdNBFAHdMj57rwMner8b0eRoH5mMOBcNwANqOqWm3qkXZUd3YG79F+zfYaWutZZ
 itGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770083071; x=1770687871;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j03ku4j1zf7QdtWIYzgaBcW8eL2taulvlqaEQbv3ZQ8=;
 b=rNd975MN0/NbZaPWespkk4Rw+1fTiQ7uuqJX40bOlVRveVQWQFSandzRmdaXXVqyYB
 ga133JDYIGRVtQn4gd9oizPDNEjkDNcwn+ViGMVi1Nah/IevRUYnUFYCwMSgVTX6Ngio
 m+84rKAcvP1auxoB6ojBtjcsZUibwsfuG0NS+R3rwOeZGfnB77wnwigEP8hbMc92lapG
 2mICT4ca5l9Eg6vnmzs2MTbS3O7QPAnUYdufe8Mh0AvCpM2KKud14omYfQBrcrSY6uM8
 i/L6RzKNyV7AhMQCyzuj08DtrqZgZvKNRhWrR5qvdSRen8LlDs3u3B6HHuFSvAZiOfRP
 q9Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCViOz+TXcRy/Wg91m5IBULcyocXzNhSzZci0sUX9WOta3UBo1rMtdePYdUpt/vYXXF4NpUouGo=@lists.denx.de
X-Gm-Message-State: AOJu0YwqFtANBQJJtfr7zje1cistAaVmc8iAfuEHM01T6ymuHKa77X5h
 E7ZEXqoPYgNWBd909iFo5d9NejdCYTR0rIFkUGzCR3UlJfnPUPrR21NVDDx8ynUDUItDIPoGQpe
 vVTQ9kQpYX4m8OitdFb/jgOWb+3h5RiY8Cg==
X-Gm-Gg: AZuq6aIWBuzRiX50Qe5nUGNPGQBSc7232RGdbe8ia4UL7RmAPKLOR+d4TC6CnKF+tGD
 9sRphsWeNs1nJiRBeDi8Ku2Rt4KDBG8OimJAxLapO93X2CZPuy3U7vUFvHS5DDXWYrqV8UQ8M67
 9qF2WJCKRM2UZLqATuZXx+60KFjoDt8aR2oMoR0XVyP/OSM64+jjJAawcbezv3NFdoTBRlf65uW
 gvB4iyJixcoTWdBPhoc+E+QPQJSSkEVSqZWJ0h0XOLS+hAnZeDtGvzF94nJSjsN7KwCX4ITphh3
 YkgmFQiZrw1SYqc=
X-Received: by 2002:a05:651c:a0a:b0:37e:6031:4e5 with SMTP id
 38308e7fff4ca-38646629907mr44026511fa.22.1770083071146; Mon, 02 Feb 2026
 17:44:31 -0800 (PST)
MIME-Version: 1.0
References: <20250930-video_exynos-v1-1-c29d1bf0eecf@linaro.org>
In-Reply-To: <20250930-video_exynos-v1-1-c29d1bf0eecf@linaro.org>
From: Minkyu Kang <promsoft@gmail.com>
Date: Tue, 3 Feb 2026 10:44:18 +0900
X-Gm-Features: AZwV_QiagBNv8Gh_M5hcmSN-Ob4CA_HF16cJ0a4P8pjN20b3f8nEVYR_52BVdbA
Message-ID: <CALrBrZ29q6dm7E-ahmHtFnJfQB3kVgPAk5HQjjpjZXh4VFpSFw@mail.gmail.com>
Subject: Re: [PATCH] video: exynos: node variable should not be unsigned
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Dear Andrew Goodbody,

2025=EB=85=84 10=EC=9B=94 1=EC=9D=BC (=EC=88=98) 01:43, Andrew Goodbody <an=
drew.goodbody@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> THe variable 'node' is assigned a value of an int, tested for being less
> than or equal to zero then passed as an argument to a function that
> takes an int so 'node' should not be unsigned. Fix it.
>
> This issue was found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  drivers/video/exynos/exynos_fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/exynos/exynos_fb.c
> b/drivers/video/exynos/exynos_fb.c
> index
> 0407a3f51b0d0b3dbb43e2979055208540d5549a..1cc1bd92e5712a8d3b43ac6fac61a45=
43e4bcca3
> 100644
> --- a/drivers/video/exynos/exynos_fb.c
> +++ b/drivers/video/exynos/exynos_fb.c
> @@ -350,7 +350,7 @@ void exynos_fimd_window_off(struct exynos_fb_priv
> *priv, unsigned int win_id)
>  void exynos_fimd_disable_sysmmu(void)
>  {
>         u32 *sysmmufimd;
> -       unsigned int node;
> +       int node;
>         int node_list[2];
>         int count;
>         int i;
>
> ---
> base-commit: 9710d98e8942151fc0c62d54100d9d27e8263d04
> change-id: 20250930-video_exynos-d69056506545
>
> Best regards,
> --
> Andrew Goodbody <andrew.goodbody@linaro.org>
>

applied to u-boot-samsung.

Thanks,
Minkyu Kang.

>
