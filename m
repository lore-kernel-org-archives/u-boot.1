Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7502BC4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 19:07:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98F138754D;
	Tue, 28 Nov 2023 20:07:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PgjIgfHL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E514B86FA6; Tue, 28 Nov 2023 20:07:35 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93ACD8758C
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 20:07:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a06e59384b6so753503566b.1
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 11:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701198453; x=1701803253; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+cE/kYAssNOsT90tIb1y4TkiKpgDj7v2Bd0jvFIJ/O0=;
 b=PgjIgfHLuF0TDYQhvrbbbU7+r1itvIPOaiyBbDYbyDXOvbzAP4zM6Pk4Uzdx4/AHBe
 tjf8wORNCAYByyiUcvixlMr0E/u74i/dUqEAHSlMs6xYNSYzzPgT++c9pM8iBvAmUGkE
 4b3CUmwK8ImwB2A904jHl7LMGGzniaLu+afS32nRUw25KE9sOqHd7jfhsiOCICEB8e8c
 DfglXyBYsScviX2xdUuzoEptjwcCLB5EbnYbSjzXX+wrTQmVZanQ1yFAT/0rvIceRkms
 IKSVWOKaij3YaaJcvvgQqkSip7Q8wpB6M1m1L4gcv7FrB3eRvhIJKD3GiN4iSgspvKGd
 icew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701198453; x=1701803253;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+cE/kYAssNOsT90tIb1y4TkiKpgDj7v2Bd0jvFIJ/O0=;
 b=sNYe0VfnJzSpJcTrAyQVvkAZd2/KG08tg3UYmQjReXeF1K6XMDhu+alsi3y3w3BEAl
 Tu0AtKvZ3cRLn+ARWk/O8xlockwxxQSGyQ6Q/typ++u8OUsWMzl1g5UPaQhwmFDsOFx+
 dcdYskE2rSBfOcc1hE5S03zxeVmO5mQhQagbPJTyW6EHvAoaU/2ATWVsUz6kBv3hVBFa
 1mjF0hjX34l2/YHu+402L7E54XOOKVYaMPxiioG+3dteZfESwqrOQgmC/xdedJDrYSp8
 cbZff1qRtNMxFfNJNiVT5+MBbdhPE6alLBWSfsYVbcRh2NMf3A/hCmfyJ82q6Vc/zz+L
 RZPQ==
X-Gm-Message-State: AOJu0Yz5yskIM+S6lB/ftkZkduEk69b/BySmI0DQV6EnKTr22Q/4/Xa8
 dIhfCsBlT62WLZo15gx2Fr6YsvA4RK/XDIpYHyCcHQ==
X-Google-Smtp-Source: AGHT+IFzb4NbN4xr2ZAh0aMAL6AFF0PHHkfWwgR+9s/fBddLLtRCN1qtM8BAalcyAuMIpJkZLSupVP4mDvbrqYP/Gr4=
X-Received: by 2002:a17:906:73dd:b0:a16:7b19:a570 with SMTP id
 n29-20020a17090673dd00b00a167b19a570mr1482265ejl.32.1701198453111; Tue, 28
 Nov 2023 11:07:33 -0800 (PST)
MIME-Version: 1.0
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-8-maxim.uvarov@linaro.org>
 <CAOMZO5AdtdHDnpNUkUieHh7_jhxDOtXp5Mtv2ybkTVLamuxO5g@mail.gmail.com>
In-Reply-To: <CAOMZO5AdtdHDnpNUkUieHh7_jhxDOtXp5Mtv2ybkTVLamuxO5g@mail.gmail.com>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Wed, 29 Nov 2023 01:07:21 +0600
Message-ID: <CAD8XO3bLiTsgaYrYUSJgiwfYQGn6C9+=VN=UhxmZOo_c3ox3xg@mail.gmail.com>
Subject: Re: [PATHv11 07/43] net/lwip: implement wget cmd
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 trini@konsulko.com, goldsimon@gmx.de
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

On Tue, 28 Nov 2023 at 17:32, Fabio Estevam <festevam@gmail.com> wrote:

> Hi Maxim,
>
> On Mon, Nov 27, 2023 at 5:46=E2=80=AFPM Maxim Uvarov <maxim.uvarov@linaro=
.org>
> wrote:
> >
> > U-Boot recently got support for an alternative network stack using LWIP=
.
> > Replace wget command with the LWIP variant while keeping the output and
> > error messages identical.
> >
> > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
>
> Do you know whether this wget issue also happens when LWIP is used?
>
>
> https://lore.kernel.org/u-boot/CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOp=
df1CNaZBw@mail.gmail.com/



From this log it's a little bit different wget output. My version prints
"#"  for status. So I guess it's original wget. You can spend time on
debugging it but this code will be replaced.
With my code I tried big iso download and check crc. I did not see any
issues.

BR,
Maxim.
