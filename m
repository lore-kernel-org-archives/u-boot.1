Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF009C46CA0
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 15:20:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13004870A0;
	Tue,  5 Dec 2023 16:20:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MzY3VViy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A096786EEE; Tue,  5 Dec 2023 16:20:31 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 719A6875FB
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 16:20:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-67abd020f40so19238996d6.0
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 07:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701789628; x=1702394428; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XpsEjuzyfCMsX1l+dsUWxn1FUbe1HxAXpZus0eirqS4=;
 b=MzY3VViyGwt6pCLXhdoHE6cOINcHRi9QZlQYS1Qn2mjgpz5Vw04nQpGV7k+7CCmpa5
 DOAB0O7182BUK8IL4aRtpGunrAli6ay02EomT7XIfa9ivhbWIiJkqCzqWla2PIujd2KO
 k/LqiTWYp2QwtdNV3zh3S4Xgh4pej0rHa/BPgJf7s5RrShwVHEWBNNUOH/qDKxx7L7u4
 W6byPOvUPUc/C/xxfOOl7fV6f6NMhZ6bjXuFFUr+MghC4A/9+3E3SUjPwoVo3OP45FPf
 t713ZhBLkU2EjKYJF12jeeHMsQc9/iEP2mJ5P8cBCZ6UPw6UZAQXUtbAT8Ard6e1MxlV
 Ny7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701789628; x=1702394428;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XpsEjuzyfCMsX1l+dsUWxn1FUbe1HxAXpZus0eirqS4=;
 b=O5KsAzCekWo5VxJYi1VYzQYu1tnl4Po1wZ/Cfg98r/NmZvU7IClfKmKvfyDfR+WsBP
 SEg4gqfZve/6Vuh+ZXR32ReRFvx25I21ryOSolHsCHIu+5JP554lkVnvFSlH2cWLqGOQ
 tLAUCemyg7eeEztqpqlRHa1oGnpkLOLq7KelKRex1/qIl3Vh0zuySoDuPtIM/LLWXVqO
 BGW1kJaWfW2nXomDjAmSewYncjzHVksRZ2rcWeEKcAdmIjZFYCGD4bR/an/o+XHdpnUC
 cz7zXvj70J+UQ5aUXbAE5Ont81wbKG9zeSJkPhvFrYGfQ8J1Wq0tagaf5CWIB0wP1ZrO
 zHAg==
X-Gm-Message-State: AOJu0YxSL3SMi2SbytPtNd/Ye+ByuWMfRkrUqhinci5rAb127BehV/DY
 SUGbmsPUGlztxsbxAEQT+/pTgCnDAztXZvWlayJafQ==
X-Google-Smtp-Source: AGHT+IGggSOBxbFlBzq6zGEmLg5NVaf0QmnSvYCPQ0Oa21fFE8QmY2RbPUEc2tELQSajdfLIsHKY/Bok0VgDZJV8eMM=
X-Received: by 2002:a05:6214:c2b:b0:67a:a72d:fbad with SMTP id
 a11-20020a0562140c2b00b0067aa72dfbadmr1568698qvd.43.1701789628080; Tue, 05
 Dec 2023 07:20:28 -0800 (PST)
MIME-Version: 1.0
References: <20231129123753.1906956-1-etienne.carriere@foss.st.com>
 <20231129123753.1906956-2-etienne.carriere@foss.st.com>
In-Reply-To: <20231129123753.1906956-2-etienne.carriere@foss.st.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 5 Dec 2023 16:20:16 +0100
Message-ID: <CAHUa44E+mz3E_=h-L+9+8oqNAWYPRpX=KSEprCGhyHjU12Wb9w@mail.gmail.com>
Subject: Re: [PATCH 2/2] tee: optee: don't enumerate services if there ain't
 any
To: Etienne Carriere <etienne.carriere@foss.st.com>
Cc: u-boot@lists.denx.de, Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
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

On Wed, Nov 29, 2023 at 1:37=E2=80=AFPM Etienne Carriere
<etienne.carriere@foss.st.com> wrote:
>
> Change optee driver service enumeration to not enumerate (and
> allocate a zero sized shared memory buffer) when OP-TEE
> reports that there is no service to enumerate.
>
> This change fixes an existing issue that occurs when the such zero
> sized shared memory buffer allocated from malloc() has a physical
> address of offset 0 of a physical 4kB page. In such case, OP-TEE
> secure world refuses to register the zero-sized shared memory
> area and makes U-Boot optee service enumeration to fail.
>
> Fixes: 94ccfb78a4d6 ("drivers: tee: optee: discover OP-TEE services")
> Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> ---
>  drivers/tee/optee/core.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

Thanks,
Jens

>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 5308dd58ce..47f845cffe 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -139,6 +139,11 @@ static int enum_services(struct udevice *dev, struct=
 tee_shm **shm, size_t *coun
>         if (ret)
>                 return ret;
>
> +       if (!shm_size) {
> +               *count =3D 0;
> +               return 0;
> +       }
> +
>         ret =3D tee_shm_alloc(dev, shm_size, 0, shm);
>         if (ret) {
>                 dev_err(dev, "Failed to allocated shared memory: %d\n", r=
et);
> @@ -185,14 +190,15 @@ static int bind_service_drivers(struct udevice *dev=
)
>
>         ret =3D enum_services(dev, &service_list, &service_count, tee_ses=
s,
>                             PTA_CMD_GET_DEVICES);
> -       if (!ret)
> +       if (!ret && service_count)
>                 ret =3D bind_service_list(dev, service_list, service_coun=
t);
>
>         tee_shm_free(service_list);
> +       service_list =3D NULL;
>
>         ret2 =3D enum_services(dev, &service_list, &service_count, tee_se=
ss,
>                              PTA_CMD_GET_DEVICES_SUPP);
> -       if (!ret2)
> +       if (!ret2 && service_count)
>                 ret2 =3D bind_service_list(dev, service_list, service_cou=
nt);
>
>         tee_shm_free(service_list);
> --
> 2.25.1
>
