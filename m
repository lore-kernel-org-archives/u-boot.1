Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30671FF887E
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 00:02:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFE3C84931;
	Thu, 30 Apr 2026 02:02:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jc4OFIT+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64C9584932; Thu, 30 Apr 2026 02:02:07 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7194084924
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 02:02:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-678a1642a81so509740a12.0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 17:02:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777507325; cv=none;
 d=google.com; s=arc-20240605;
 b=JqCNfH4Jz1tfDyI3akkeUhzxRbTkclCYEdBEj0/sR6ylTJWIxE7uboDHxtwDMpqgD1
 16DbQFsA8/ZP9y3Q/Da2tkUjD3BmLvoGkWOKEod56BktimWELPYJ/v5YzdzbmR7XyHy1
 K0rvktl8E1KAIrSZnx0qt0VGaAlBFdNTRlTabyyziji2/kwjySc586LOA+KdzJRRT9pi
 7aez84a64HATOrXrrD5FflRNTp1CFZZ0yGaVrlPU4aoG73qJWUeexIADWkee7qYdMYB8
 C5EytFKNqrycBAQzzStKrn9gy/znNyU77A+nkb2kfdoKClO16ZBXvjUiNIkYojrEVUDb
 lozA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xBIFH1Rj+PPPqdU7vExD+QhvjGvIOUy+JlvPGqCnJqw=;
 fh=Q4op913zAn3wjToihx27CXWV1xxeczkcmWNnN5iyeuc=;
 b=dJJ+p3PfgjOpIH9b71vJgtzxVlM1JdrsmSbLhstUgwXKQuaNk3FjmY4TT1qp+wsaVT
 Z//pKJTXuY0ASLeZE4OAJ23xK5nXqJrsdjBoRquIn4x51G1Jpug04mAojexCuD3IarS9
 VWzL3WedJgxgH5PjMqY6t19R8XwsqoVBCXzg85/7fa0RraHPq9uZuqNZ9gFlpgaokI0E
 xgjAZec2AFd453+zKgIhDsPHkomMdd44GbbRPkouEFCwCAfCRbWSuJGHwzpY6oJZMYi+
 J6cJ9WBlx4JzRnkf6sjiLcnhB0tiYkxtlPgtI5POC1r8597JpSLgCa/kBNIpzgDFZLH5
 8AyA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777507325; x=1778112125; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xBIFH1Rj+PPPqdU7vExD+QhvjGvIOUy+JlvPGqCnJqw=;
 b=jc4OFIT+8q/gh7z5NTN6kcfS4SuNN2v95ijNVGmhr30nyO8ccQ7BT8qyJNB5JA2IDh
 HfidfYevVa6QnThL2NS7eiVwrOz5xeSTZsNw4M6bE4Amz+2ouM9+IRUKLTnh1Gdr2o8z
 E1SKyvepYlPLveTiDk9/qFwvkKxPlUtbJCscg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507325; x=1778112125;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xBIFH1Rj+PPPqdU7vExD+QhvjGvIOUy+JlvPGqCnJqw=;
 b=NfX0PZ/ZRjb41XqqOmeTIWEHeDy3wNiPsPda5ScOhjZlWwIUwcbBYg3jHY1qBVzt56
 098oRvRYUkjTmqLIDzsH65LQCm+T+C/AWon+71zfe59ihAL/VtGxF0S/NooUUMy9mXnn
 SV7FW1hj5zQQ/vLGYRkkzQjORYMEqMJXn8R1sii30q+QTx6Dm5bPi7w8vC4cK45JVaCD
 bYUwzEgU+Z/9luJ+/O1DQns2thJZBLBU7wuDkfIQR3z9rqv3jOEx+SSPGjwl1FFgA6a6
 S7WiqUdkI8miI3KJsuS2w/Lio93qpevveobWzYg5ZlA9TW2y3wU+VGQSgxvvMKHbO5ee
 qe4A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/nuoTLRTZzamSmzKl6XyPv+ADu21rosP1W+31tMxdw8U4kvBvFZWh3IzGMv+IxgDuYbkwT1wA=@lists.denx.de
X-Gm-Message-State: AOJu0YzbquO6IxPsPoriZWuoG15+6NO9DpHGIwbKeM/MtXX8KBJWRChJ
 AM4sxZHegLr7MypEnGv3QRPLEU77nDt06pTBYVn1+N8nq8wrKOe81s3ZqCq8acFdB3bGFsPdZZg
 ZgPXr4zchoV+Wia9RxgxEcuRRpCDqRrOTFSQwqkWD
X-Gm-Gg: AeBDievj5lb348c1XbZVOkJjG8S/RYNWeKncInrcqxMoVul67XvOVpD0EheztYtkwiY
 hpwTokdyXq+BzDvDn6dAWtOeTKOJQ0ucbz5FOKGahO1/gWdOscgRVJnR6tmjyOMlVc/3/PO6SbT
 YepORIOq/owkillUn+Sy8ALICBnEaYT9+UDW4zIDpGAGuKMk/I8q+YG6STxChz6ljjCGiydB/ON
 L78JvUF9WwzgI8Hhvnvr/lmtGacuLY852bxqLYbqeK8NrRaREf7pAzl8xJkRruxgn7EYfWQ4QCU
 KunzvhojULv0MOLj
X-Received: by 2002:a17:907:3d10:b0:bb7:eb68:514e with SMTP id
 a640c23a62f3a-bbac7b9a461mr37378766b.36.1777507324831; Wed, 29 Apr 2026
 17:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260425033742.1519298-1-b-padhi@ti.com>
 <20260425033742.1519298-12-b-padhi@ti.com>
In-Reply-To: <20260425033742.1519298-12-b-padhi@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 18:01:53 -0600
X-Gm-Features: AVHnY4KFQd-NjJRT2disHMij1V3WC5_awrH58VWCAaaPKog_47gK0b4HdqqUBTA
Message-ID: <CAFLszTj6_+jqBL_L_Bh2qYVFFcasO=2JbX329fGPEATFQQxEVQ@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] arm: mach-k3: r5: common: Invoke boot of HSM M4
 core
To: b-padhi@ti.com
Cc: trini@konsulko.com, u-boot@lists.denx.de
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

Hi Beleswar,

On 2026-04-25T03:37:39, Padhi, Beleswar <b-padhi@ti.com> wrote:
> arm: mach-k3: r5: common: Invoke boot of HSM M4 core
>
> The tispl.bin fit image is packed with the HSM firmware image. Populate
> the 'os' info of the image so that it can be detected and used to load
> the HSM core. Further, invoke the load and boot of HSM core at R5 SPL
> stage using the remoteprocessor framework.
>
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>
> arch/arm/mach-k3/r5/common.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

> diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
> @@ -158,6 +160,20 @@ void __noreturn jump_to_image(struct spl_image_info =
*spl_image)
> +     if (IS_ENABLED(CONFIG_REMOTEPROC_TI_K3_HSM_M4F)) {
> +             ret =3D rproc_load(2, fit_image_info[IMAGE_ID_HSM].load,
> +                              fit_image_info[IMAGE_ID_HSM].image_len);
> +             if (ret) {
> +                     panic("Error while loading HSM firmware, ret =3D %d=
\n", ret);
> +             } else {
> +                     ret =3D rproc_start(2);
> +                     if (ret)
> +                             panic("Error while starting HSM core\n");
> +                     else
> +                             printf("Successfully loaded and started HSM=
 core\n");
> +             }
> +     }

panic() is __noreturn, so how about:

   ret =3D rproc_load(2, ...);
   if (ret)
           panic("Error while loading HSM firmware, ret =3D %d\n", ret);

   ret =3D rproc_start(2);
   if (ret)
           panic("Error while starting HSM core, ret =3D %d\n", ret);

   printf("Successfully loaded and started HSM core\n");

> diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
> @@ -158,6 +160,20 @@ void __noreturn jump_to_image(struct spl_image_info =
*spl_image)
> +             ret =3D rproc_load(2, fit_image_info[IMAGE_ID_HSM].load,
> +                              fit_image_info[IMAGE_ID_HSM].image_len);

The bare 2 here mirrors the bare 1 below, which at least has a comment
explaining the DT alias assumption ("It is assumed that remoteproc
device 1 is =E2=80=A6"). Please add an equivalent comment for the HSM,
pointing at the 'remoteproc2 =3D &hsm' alias added in patch 9.

> diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
> @@ -158,6 +160,20 @@ void __noreturn jump_to_image(struct spl_image_info =
*spl_image)
> +             ret =3D rproc_load(2, fit_image_info[IMAGE_ID_HSM].load,
> +                              fit_image_info[IMAGE_ID_HSM].image_len);

Just to check: on HS-SE/HS-FS, board_fit_image_post_process() already
invokes ti_secure_image_post_process() on the HSM image (since
IMAGE_ID_HSM is not in the ATF/OPTEE skip list), and then
k3_hsm_load() in patch 10 calls ti_secure_image_post_process() a
second time on &addr. Is this intentional? It looks like the image is
post-processed twice on HS devices. If so, please mention it in the
commit message; otherwise one of the two calls should go.

Also, image_len recorded in fit_image_info[] is the pre-post-process
size (set before the HS-side post_process runs), but 'load' is the
original FIT data address - so on HS, the (load, image_len) pair you
pass to rproc_load() may not describe what is actually sitting at that
address after the first post_process. Worth checking on a HS-SE board.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
