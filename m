Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10352C44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 16:29:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C2B284BE4;
	Wed, 15 Jul 2026 18:29:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hOmCcTSV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A26B184C03; Wed, 15 Jul 2026 18:29:32 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4576F84B49
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 18:29:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-455a61c53d3so2111903fac.2
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 09:29:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784132969; cv=none;
 d=google.com; s=arc-20260327;
 b=dKwfFmSqJn+ePj+ShRUaok+3QHyRfHV9RMQJO91wAU3TkniM2OlsJe3YJj5xN65HlN
 B2KiBbwwqiIGDFEuMLvenzDu5GurxZa81+r4gVhlniZnKb2Oz1lXD+yYMPl0OJYBT57S
 EaHCa6g1i5OJiNzB3tqmDHvnSS9QwzNdMXfAltAkBKBAd5tYfAFvzbV0hh+HW0mlGdCl
 U52jDAi1hykcswGjEhOj5ToqTd0oExV3QOHPx6GO8EDH76V2xiIRt8jcwe1j0ZDsX6bj
 UQWRcxaOiwlGw+pZNazBQE0XU6Oi4TZxOL7bq86dvFEWvs43FfplLp54ia+IrtTcuGp8
 wDEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=k65NJBhOS3+Y5bjC3PeUZM+mP6QId5MJFDVrEL4269U=;
 fh=wYXhoYpjb1+GwMlhOd1xSvEboUA9cmXHqWn8BuJbkmo=;
 b=mMqDIlMNjbIqpfISorrbqu3TvEGCIu+yTgBThcDovyBmdJRTHFUp15BuKVP0B0fJwL
 4t7DXL/P7xVX+btFc6IFsFIMgMui19LYDcM39jfQtc3TtmydqdJgz8v5U86b8fb0fE5y
 xjifbjgAU9zZ9C0SGviMXBZEkAOvVbm1L39ijfnSmuC+03QPzOMKxQ3rzUZPeAZi1OKa
 5gvT4g7rkM03jAoSsyIB19go10cSrEF6jOddQZKZZ+e4GyaHjcqIH4h6WWZS2k5THz+V
 Mz4pOPINAD2QgPSUFV+Ln1mhKy28eNy39Na7Yb1eM7yGAKvMl0/pb2dflloK2Zm2e+to
 Ps7Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784132969; x=1784737769; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=k65NJBhOS3+Y5bjC3PeUZM+mP6QId5MJFDVrEL4269U=;
 b=hOmCcTSVsU4bF90DmCjC+6mj1VVHAGcj0xSkz4nG29Uw/KB6q0HWJta/Z/V7sqTwWm
 La19beGYjwO0ceI5pYIfbcTXopN/fZJ/6jiPr2c6jw3cuygIzQ41SNM6m6ehvLV/28oX
 dWr2DhWHEX/U5WBzrS9l7rqMnLqheT/xKqfvdspLmx2MnsK4vVBxDxicmZnsiEK/zLGA
 I5o0hzUxfj8qFzBvS9cv/QNqAJlYbUpRNFM7BvA1HxXFI4BAKGnDnqJCyk3/QfFfHfIF
 rBrP6ox04ehZVCmtU8h3ENC1Z6ihhudMHMYN6Os3Vv84dyn5RvQAhGFyFZ42L0ztMCAK
 vluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784132969; x=1784737769;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k65NJBhOS3+Y5bjC3PeUZM+mP6QId5MJFDVrEL4269U=;
 b=YQlNwayC+8BG6iGSWuzxL3glFS80Q4vlqGTptI6woS6+m9UZecBjLV6VbuAV8JA9x6
 28M4YOJfFLxwIpCG4ye7BBJFyAjQwjqrOEa5zmuG80KyXrk3i7PjbanuRDMRnZQ/Qk0d
 V/iIsSivHwIHYl/BOKNdrCyfWUwOhgaYHsWfWtw+A74QYNoChxdYbokkxgb+ShN1Hgid
 FifK8vHS8fLzG6jZxz/8alVIH336FG1FEYhLgIoMeMzARrb3Sv08FGLw/amKLCKuDb99
 THW6q6Rmc0tx2bTxAzTygy5X/JNE+OMXR/qM8N0t7neJH43VJ7aq3OWMiycpsj9N1huQ
 jKmg==
X-Gm-Message-State: AOJu0YxNG3cR0QIz4f4QTNerL1fYK1jc+OkKRkMaEprJXb6/xjlCkUlG
 ckC4adS/aTCFFrmn1FE2vw964sAnCxJm6j4a+nJiuDA3Y75SQvUYQa+1nCbH4iJNhVy5MAKYoqZ
 ISRcLRSjfzfEmUHCtP2iGeHT2dIzeysz9G8aQ
X-Gm-Gg: AfdE7ckefzRga8XkxUlFy/q3cpwEZJ0cjI7rACdBnmNfTpMW9MdwJzAzoZj+IywyJ8+
 10c3M+tOpEvZaprVXqttH8utzGlqCW7k52F1ozomfM4/eD09aAYZpMPnsrsB2yDaf0vqlG4nGIr
 TQR55S3jud7Z+5ojRo169mueERw2mDQg2om6PqTMnkuGr6g7A2Ybl+l4vSQG0zaKxcCQArQezwq
 jPLWYiXSeDlr9rAlelpjfJQFzP3jGIlmf/K0Z4Xvwk2TddnE48fTKWKFgOnFMtWJZLqH40krHA/
 IYCRnZ1kySznDUpCXWp03A0wi9rUhQ==
X-Received: by 2002:a05:6870:380a:b0:42c:49c7:a499 with SMTP id
 586e51a60fabf-4560b3eb145mr3777665fac.3.1784132968969; Wed, 15 Jul 2026
 09:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260712-avb-fix-memory-leaks-v1-0-51d6d5a42631@gmail.com>
In-Reply-To: <20260712-avb-fix-memory-leaks-v1-0-51d6d5a42631@gmail.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Wed, 15 Jul 2026 18:29:17 +0200
X-Gm-Features: AUfX_mwhZ0CL6Pm0UXASpzxr7EFq0zZerKZMu46Xq3_hLmMB2-XoHp9jokAiY5E
Message-ID: <CAByghJaRbP9Rx3VYRPFS+yfjKbx6y6c8wX3MyUE+HjnG_-L-4A@mail.gmail.com>
Subject: Re: [PATCH 0/2] avb: fix memory leaks in AVB 2.0 verification path
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>, 
 "Nicolas Belin (TI.com)" <nbelin@baylibre.com>,
 Francois Berder <fberder@outlook.fr>, 
 Sam Protsenko <semen.protsenko@linaro.org>
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

On Sun, Jul 12, 2026 at 10:50=E2=80=AFAM Igor Opaniuk <igor.opaniuk@gmail.c=
om> wrote:
>
> While reviewing the AVB 2.0 integration I noticed several memory leaks in
> the verification path that accumulate on every boot.
>
> In the Android bootmethod, run_avb_verification() allocates an AvbOps via
> avb_ops_alloc() and receives an AvbSlotVerifyData from avb_slot_verify(),
> but frees neither on the successful return paths. Every boot therefore
> leaks the AvbOpsData structure, and with CONFIG_OPTEE_TA_AVB the leaked
> AvbOps also leaves the OP-TEE session open (it is only closed inside
> avb_ops_free()). The AvbSlotVerifyData - holding the kernel cmdline and
> loaded-partition metadata - is leaked on both the locked GREEN/OK and the
> unlocked ORANGE/ERROR_VERIFICATION success paths.
>
> Independently, the AvbOps I/O helpers leak a struct mmc_part on every
> partition access: get_partition() returns a malloc()'d descriptor that
> only its internal error path frees, while none of its three callers
> (mmc_byte_io(), get_unique_guid_for_partition(), get_size_of_partition())
> release it. A single "avb verify" performs many such accesses (footer,
> vbmeta and the hashed image chunks), so this leak grows quickly.
>
> No functional change intended: the GREEN/ORANGE boot-state handling and
> the locked/unlocked acceptance logic are preserved.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> ---
> Igor Opaniuk (2):
>       boot: android: fix AvbOps and verify-data leaks in AVB path
>       avb: free mmc_part allocated by get_partition()
>
>  boot/bootmeth_android.c | 37 +++++++++++++++++++++----------------
>  common/avb_verify.c     | 29 +++++++++++++++++++++--------
>  2 files changed, 42 insertions(+), 24 deletions(-)
> ---
> base-commit: 6741b0dfb41dc82a284ab1cff4c58af6ef2f3f9c
> change-id: 20260712-avb-fix-memory-leaks-831cfd7e2115
>
> Best regards,
> --
> Igor Opaniuk <igor.opaniuk@gmail.com>
>

Just a gentle ping on this patch series

--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
https://www.linkedin.com/in/iopaniuk
