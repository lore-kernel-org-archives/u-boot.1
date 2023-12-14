Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2352BC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:29:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 885FE87505;
	Thu, 14 Dec 2023 17:29:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LZhxCHcG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1000687225; Thu, 14 Dec 2023 17:29:24 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81F2A87ABC
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:29:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6ceccf6d88fso1281252b3a.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 08:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702571360; x=1703176160; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fc30ZFwztOt5Qfo+35jjhTqZtIBpk1hLZk08OvCBbig=;
 b=LZhxCHcGqcAcv4wVLQtoa6tGHYG9wcBv2B+tBXBTWnJ3SHqYdkOr4IN/IZwusLlEqt
 aaakhr1mQrXQZ1NqZ3279W+ac+8sVewpSv9zmE6Y88CMToK2KY4Jpw+ea5EDPFQ6ymtg
 /4SB4RkPHzttMox3XhvIzpdNX8z1PtBHHPRZemlOfZKB5lwQXJAui0F49NH7FLYxFcjo
 8vUjHH20iOjt2DHtpNsWnmhqsb5O+e53styDWYqYLDNZjPsxBWl8li/SWA+4HH6LDtpV
 Yyt5/J2JPfN0Z8ddZuh/jXFZLEg/JiZmfKtj/SpVjs20j34K6dIr6oBenk3mHibjn91d
 2AdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702571360; x=1703176160;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fc30ZFwztOt5Qfo+35jjhTqZtIBpk1hLZk08OvCBbig=;
 b=N2jKb2qjjxzjQZv8UqibF1PPCcWsVAj0TYRyAvJGFv1Hk8at7My8dmuF9AMs22hha7
 prNJLlH8jkz77B0y17mM8TjsDU4uYZtPUJ5XUcmFrwek0T52FXa8dwa+RY7A1eqX1Ojz
 jx3VDlBc84ZBE1lY+G9er4s1qhluITufCCaQS6RGLvVI9E478CeLUFeki47IcWouoCEJ
 uo3OCf/kfAGpCuzZ9rOqNMi2UM68nrvPdv+3kNlv/ctw7qX1rFZkQzKqK6wkI8G02rAE
 /a9ZqLTgueOjQl4s7mbvKbCamm0hO/fumd2IsWILq7ec98TX4RKTg5ucF0HMsrHqMbvf
 APIw==
X-Gm-Message-State: AOJu0YzqMCy6s60jAEhR1VfeHMGGrt/Op4Q9hN/gqLWzQDHJL3eE5CEM
 X5e9PcWdHTpRouVWPYPmBsX2zP0+AIZsyBrv4HGyCVCM
X-Google-Smtp-Source: AGHT+IG6jkqHUdtBcYkcCbhpjXHIQSn0hVNqpjX04/nBuYPybvV3M1T5Wz3+9lYCoSYd/JEPxiJ57SKO3rDR/HE6sJM=
X-Received: by 2002:a05:6a21:998e:b0:187:4a56:9a06 with SMTP id
 ve14-20020a056a21998e00b001874a569a06mr23459819pzb.5.1702571359633; Thu, 14
 Dec 2023 08:29:19 -0800 (PST)
MIME-Version: 1.0
References: <20231214162227.1199831-1-tharvey@gateworks.com>
 <20231214162227.1199831-3-tharvey@gateworks.com>
In-Reply-To: <20231214162227.1199831-3-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 14 Dec 2023 13:29:07 -0300
Message-ID: <CAOMZO5Bx5Rb3oh2MCeh7ebuwJaLM3ZxUM7F3_2bP6TkPUrQY=A@mail.gmail.com>
Subject: Re: [PATCH 3/3] imx8mp-venice: update DRAM config for 2000MHz
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
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

Hi Tim,

On Thu, Dec 14, 2023 at 1:22=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> The imx8mp venice boards can support 2000Mhz DRAM.
> Update the DRAM config to support this.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Do you consider this series material for 2024.01 or 2024.04?
