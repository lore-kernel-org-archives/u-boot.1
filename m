Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E19C54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 18:17:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60AA0880A5;
	Tue,  5 Mar 2024 19:17:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i/t+u5QO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64E27880AF; Tue,  5 Mar 2024 19:17:06 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD3C186F6E
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 19:17:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-29964f5c904so639015a91.0
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 10:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709662621; x=1710267421; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gUVqgI6sQxWZFW/l6r4njQyxheR3yTegLSHnT06U4Jg=;
 b=i/t+u5QObPhz0Kyk5wiaQw1IT3CTWFrbaP6VFkWRQ3xLyZ7Iq5u9GKCMB/p8ZYcCoY
 S4hwMGeEliWXiDFNj0SHxIdRA2aqYurvkTn1UONwH36CtIcg3iF79bT/YXzgONrAzGvu
 h4NuEFYZdNlZziIlfK3XgJIo4Fr5DB8ahLutAFQzqMg8f9POb12xJ0aZKUujT83YIJvD
 lzzICe5v4I1QjuXYTSMvWepFXPdksTzx7/praTD+PUCicZKMiXDtnTlom0C0Vq/JZzWT
 TORXWv8tKeue6bO00CeTzzjrlDjulLjVHNACne7gn2BWyUtVsohyLZU5l3VB+3HCR7cJ
 upIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709662621; x=1710267421;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gUVqgI6sQxWZFW/l6r4njQyxheR3yTegLSHnT06U4Jg=;
 b=QHWvoI6aLoGmGQW0xn2B3v1K56cx6unchRps6xyjgCrS1FhaEiWjySWKGxanr1Em6P
 TKAZwT4z9CUj/iwQeVzqQnpQPjabQGMPQnqJdhhEORTeihDjLMQaaX+z0qAKpIpW6dEZ
 Y5aBFPpP/k8vf4XENTjFrW3fCMb3wFN8jAbK4vdt65uLRw3GqJD0QOwFXznQRg8fxh92
 I8ybPkrqg8HSpCXPKhv/E5Q5MXufIri22rblfufQEeNDx5S1VPz8GTF7lvofmnBpWSLu
 uj9SfRyaRXcaUHc07SROqu/hyNJ18PyquZjcF58H0ObMnN7qNRBHznpMA30Cw5lref34
 rrng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgA5Qlmicc92ecUMES4BoJeX5EFO7w43k6RZTuOyUYcaOSjdx7lH/QTeDJ7zIzKyFbB2px0QCiSe6ypm4igCINhqGH6A==
X-Gm-Message-State: AOJu0YxiCsCTRdiUrVyr/LqZxw05gytvMP5M7VWd8DSm9ayNgbwtXvtS
 cfVTgGbussp47o815KL5rkY3i/tqDyqaua6UyWfRQN4qzC7qaOqdkTZZf1/fRe4GFtlaTjlKXxj
 A0rCavdeW8maoI2QmBLCByPkmzYA=
X-Google-Smtp-Source: AGHT+IHlw9KarHEN80rLjdcEchy+mZjOWluN90FGBDFvhzrzxNDt1Ztd+jf+I/ilH6XIlM0nROWdMpscJBf0G7upp0I=
X-Received: by 2002:a17:90b:38c6:b0:29b:71ce:af04 with SMTP id
 nn6-20020a17090b38c600b0029b71ceaf04mr431268pjb.1.1709662621143; Tue, 05 Mar
 2024 10:17:01 -0800 (PST)
MIME-Version: 1.0
References: <20240304-pcl-070-patches-v2-0-c534960c4b8b@phytec.de>
 <20240304-pcl-070-patches-v2-1-c534960c4b8b@phytec.de>
In-Reply-To: <20240304-pcl-070-patches-v2-1-c534960c4b8b@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 5 Mar 2024 15:16:49 -0300
Message-ID: <CAOMZO5D0sAWj03nozLE8r8+bdS9QaOPrUiSvnuKtBGC_kaC0Og@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] board: phytec: common: phytec_som_detection: Add
 phytec_get_som_type
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Tom Rini <trini@konsulko.com>, Teresa Remmet <t.remmet@phytec.de>,
 u-boot@lists.denx.de, upstream@lists.phytec.de
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

On Mon, Mar 4, 2024 at 1:04=E2=80=AFPM Benjamin Hahn <B.Hahn@phytec.de> wro=
te:

> +enum phytec_som_type_str {
> +       PCM =3D 0,
> +       PCL,
> +       KSM,
> +       KSP,
> +};

To avoid potential name clashes in the future, I suggest adding a prefix li=
ke:

SOM_TYPE_PCM =3D 0,
SOM_TYPE_PCL,
...




> +
>  static const char * const phytec_som_type_str[] =3D {
>         "PCM",
>         "PCL",
> @@ -67,5 +74,6 @@ void __maybe_unused phytec_print_som_info(struct phytec=
_eeprom_data *data);
>
>  char * __maybe_unused phytec_get_opt(struct phytec_eeprom_data *data);
>  u8 __maybe_unused phytec_get_rev(struct phytec_eeprom_data *data);
> +u8 __maybe_unused phytec_get_som_type(struct phytec_eeprom_data *data);
>
>  #endif /* _PHYTEC_SOM_DETECTION_H */
>
> --
> 2.34.1
>
