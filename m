Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6D6C47258
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 03:41:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 265D787C43;
	Fri,  2 Feb 2024 04:40:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ErwMzqex";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 083F487C56; Fri,  2 Feb 2024 04:40:58 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C21287C13
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 04:40:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-55fe4534e9bso650384a12.0
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 19:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706845255; x=1707450055; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/3tHTcCN3MIp8LBSYugW4ibtJfSxTYY2RjoawTjdj4=;
 b=ErwMzqex1VTk+QzAuqAlneRXae59EFsDHxGMWS0dN+lAgirUiZgYGOgChLfIcnzGh3
 9RX3WNjRsBWv80HyM5vfXvjm4QkNSAUN+3oxoEPuirctbDW9FHjByPlEp/gDnht2eWlt
 ea5YMSuuD1A7y1VXQPbZEnMXD95wWos4biBBgNu0h9wae+nNVB9eSntcFbsQrTFs0Hal
 8rsegejIDyNtsG3uyiLe6eUdDhhLEuKI5+ZArnRX6VpU8CKHKEjFgmItixzJb3whouHX
 D/OilKt7CRf9v6ylTa9oNzewyKsfPlsbHJ4q1FTlp795WtmakToXxw2+uixB8Q5eGBkh
 Zm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706845255; x=1707450055;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R/3tHTcCN3MIp8LBSYugW4ibtJfSxTYY2RjoawTjdj4=;
 b=V97Zf+9SYP4c0qkoNqr4DIpDrjGV5BpwFEi9MqzBmzb+GiCQ15frL52iUffM2nBDAc
 WLgyW0Ypx2p4vz/YY93cqQEV28Be7aQ3RlqKe3/HHYonYxzJa1Pl2ydHMaqUbUEojnnO
 k1zf0ER0Dbdr44AIa91zbI0jf9bznoNcUGmvZcQ9Ur/BLVKcfkEsAKhvHvEZ065DTtek
 WeRFFc0cRLseMjaGrcxiosb8J/cJDok2ToMjHr5R1GuMr6odfYaLOijJfPQSbizWN38B
 R7RdX9v3HeREj9ciIqEupgwBZ4qzjZ+fmp9wfLQu6H9pc8kPMjwkAi/2UAJ19SltKJvU
 pB+w==
X-Gm-Message-State: AOJu0Yy2zLt3MycCRU/3kI4bQ8e/E8BsXDpkLBErpsM0F6rfKfZ1zLN9
 VxwhYf3PAQNiuWLYoXBj0kwpsIgPeZbulpcpWwppLlawHGA+LObBkOFa24EujkCLgQlMdJJ0/Ua
 dnVkBqVf87yNvDLWHKwQrlLwaOSk=
X-Google-Smtp-Source: AGHT+IFogxAuFj2879nqafGGtSrKCdefyWIAfCwa9Us02Z0x1h4UnxZXgkPxBG8qxOn6ZBqVI7B1Gswqs2KFTQ+HPNU=
X-Received: by 2002:aa7:c888:0:b0:55f:99:c895 with SMTP id
 p8-20020aa7c888000000b0055f0099c895mr376034eds.20.1706845254627; 
 Thu, 01 Feb 2024 19:40:54 -0800 (PST)
MIME-Version: 1.0
References: <20240131141426.34926-1-o451686892@gmail.com>
 <20240131141426.34926-2-o451686892@gmail.com>
 <20240201114030.GA112745@e130802.arm.com>
In-Reply-To: <20240201114030.GA112745@e130802.arm.com>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Fri, 2 Feb 2024 11:40:43 +0800
Message-ID: <CAHk0Houhd4q0Z9R-D8AfJjz3y5R8Ktx=HNB2+tX8XMo2H_YP4A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] firmware: psci: Fix bind_smccc_features psci check
To: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Simon Glass <sjg@chromium.org>, 
 Peng Fan <peng.fan@nxp.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jens Wiklander <jens.wiklander@linaro.org>, u-boot@lists.denx.de
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

Hi Abdellatif,

On Thu, Feb 1, 2024 at 7:40=E2=80=AFPM Abdellatif El Khlifi
<abdellatif.elkhlifi@arm.com> wrote:
>
> Hi Weizhao,
>
> > -     if (request_psci_features(ARM_SMCCC_ARCH_FEATURES) =3D=3D
> > +     if (request_psci_features(ARM_SMCCC_VERSION) =3D=3D
> >           PSCI_RET_NOT_SUPPORTED)
> >               return 0;
> >
> > +     if (invoke_psci_fn(ARM_SMCCC_VERSION, 0, 0, 0) < ARM_SMCCC_VERSIO=
N_1_1)
> > +             return 0;
>
> It makes sense to me, thanks.
>
> > diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> > index f44e9e8f93..da3d29aabe 100644
> > --- a/include/linux/arm-smccc.h
> > +++ b/include/linux/arm-smccc.h
> > @@ -55,8 +55,14 @@
> >  #define ARM_SMCCC_QUIRK_NONE         0
> >  #define ARM_SMCCC_QUIRK_QCOM_A6              1 /* Save/restore registe=
r a6 */
> >
> > +#define ARM_SMCCC_VERSION            0x80000000
> >  #define ARM_SMCCC_ARCH_FEATURES              0x80000001
> >
> > +#define ARM_SMCCC_VERSION_1_0                0x10000
> > +#define ARM_SMCCC_VERSION_1_1                0x10001
> > +#define ARM_SMCCC_VERSION_1_2                0x10002
> > +#define ARM_SMCCC_VERSION_1_3                0x10003
>
> Apart from ARM_SMCCC_VERSION_1_1, are the other ARM_SMCCC_VERSION_1_x def=
ines needed ?

I'm trying to synchronize with linux kernel, it might be a bit odd to
add only one version.

BR,
Weizhao

>
> Cheers,
> Abdellatif
