Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EB7CFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 12:06:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E21D98432D;
	Thu, 27 Nov 2025 13:06:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LKc2PxGb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEDB584370; Thu, 27 Nov 2025 13:06:55 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A83AE84320
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 13:06:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5957db5bdedso916697e87.2
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 04:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764245213; x=1764850013; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PG+Wug4dYp8yq2KtMicfAMP1JuTVFpc6yL/2gtV3od0=;
 b=LKc2PxGb3cjVo4qqjnb7u79/iYZ2PC5JhEYIpXWYyc3UvAiz3ZPoEKXLoHqpMa6z17
 KOXzDN2RqJb+Ya09pcrHVNa7F2CVYDTM4dmaOD0uuCmvAIBCyvHoENMJUbXWQZF6qe87
 CEbII/YOHww0kQLTbzAbsrRv284PrtEQWFWwhkJsnWF0vV60I1cElLiUgAa+/uBtTg/g
 5vQfhGC/x0qx8Pij1GTCMb7ljNwrutiWavLhNlMkr+NJM83YyRyQoI2Ts2XSB3cezR53
 Y/Jw9i2o+LiOvyfklzRkQUH+DATRfsvRgR8pareIepZJVge1ka0Ss4MRT3DLCYfXFUD3
 DRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764245213; x=1764850013;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PG+Wug4dYp8yq2KtMicfAMP1JuTVFpc6yL/2gtV3od0=;
 b=M8OaK4uKF7rAEiTrF/9SjIBhPDJhWl+m7MQ1fyPj0udnn1GmpTAl+7WcY/eIIufBrp
 TaLzPGCkQLtKZorMOsJziee+OMUJbuU243H6FoP7+Rx+kr+Ad9M3uE9d6Yiz71bJGJD6
 okfotdYcKKqFDthh12hXQklkahi+K5qZKFVRa2pXsEqpqotllsRaoyiQOqOh2ufEbm0f
 VHnLEgwPreXg9wpKnddnkjqC7/ykF6m0B4fGsrXOuhsvs1Z3i2MqP6Do5E7YmRKDAcTM
 9152oaor43SYajHrbn+Sz8rqee70PUeODvEII3jO9v9H8prjtQC6iaWFyL8J2/f/OoJT
 MdmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXD18HzZIPajstEHaVhbYpmbSloV7CIh0Mwqm/nP1KPtvpJ+GQwk2efN4DaefbfVU6da/RIgDM=@lists.denx.de
X-Gm-Message-State: AOJu0YzLqWbh3rjZRjFkji0kPYYYL+fIf+iMYdlXmtWIyvBnK6vnR4Mt
 u3zXultJI3ZnCYVKpfKUEZ/Yds4zS1iECvP5WavNDz4MFo+hCD7/dRMw+yEU/efIsi5d3zDuBuQ
 RoPZpl8SS6f+/fA3osFFlJzDZthSkpfA=
X-Gm-Gg: ASbGnctQz8DS7+R02KsvLsviBk+9mYiDYDJY8wO4mBytUYg3eOH2xb1/N/g2qqsmI6D
 Uufl/MZZJ1jIzxg76vreeZGQvZ8bJjTIhnx1TVIe+mC6fbRpdYkZDcJ+N8qmlWoMe1z557SqzNV
 VZjrUdc7HSdHAHHmFz9M8ngWSo1iC9m90jn/HOK8eCK9P7SHFWZoXSSxfaAZ0Wzb1ubMN5Uf+DA
 nNa/XBTqJfY38A5sWWO6bjTreTxbvRHQA/vP7Mzi4MoePtgGmg28w0veDzNqTcyFYJxo/lxVezs
 JfwXXrHdvlcpFWUOZ+0x91a2PAc=
X-Google-Smtp-Source: AGHT+IGzYbLEP45zj9j8WqdoYM2XjsCcIM5XcS0KXsHzhOvjbPRgpIZMNmwBRwFiYU2nkMpPZV25EPZbflorN3ctvBs=
X-Received: by 2002:a05:6512:12d3:b0:595:8350:5824 with SMTP id
 2adb3069b0e04-596a3e9fbf8mr9191416e87.7.1764245212477; Thu, 27 Nov 2025
 04:06:52 -0800 (PST)
MIME-Version: 1.0
References: <20251127-imx91_frdm-v1-0-8f42646d89ad@nxp.com>
 <20251127-imx91_frdm-v1-1-8f42646d89ad@nxp.com>
In-Reply-To: <20251127-imx91_frdm-v1-1-8f42646d89ad@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 27 Nov 2025 09:06:40 -0300
X-Gm-Features: AWmQ_bn6O88VDexB7lqE4gPAZjLgqN5kjUjs08ODHiePc9T_tfLqFCKJmsdsg7U
Message-ID: <CAOMZO5AFdPrPR=gRuf-70k1iEzN1ZiMs7aKRtuT8BMkQDPvCQA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: add NXP FRDM-IMX91 device tree
To: Joseph Guo <qijian.guo@nxp.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Adam Ford <aford173@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
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

Hi Joseph,

On Thu, Nov 27, 2025 at 6:55=E2=80=AFAM Joseph Guo <qijian.guo@nxp.com> wro=
te:
>
> Add the device tree files for the FRDM-IMX91 board.
> Provide the initial DT support for FRDM-IMX91.

Has this dts been sent upstream? If so, please include the lore link
of the submission.

We want to use the upstream device trees in U-Boot as much as possible.

It is OK to include the dts in U-Boot first, but please make it clear
that there is an ongoing effort to upstream it.

After it hits upstream, then we can switch to OF_UPSTREAM and delete
the U-Boot dts copy.
