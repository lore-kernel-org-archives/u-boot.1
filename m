Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCE0C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 01:55:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9012875F3;
	Fri, 10 Nov 2023 02:55:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GawqppRb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54FAB87504; Fri, 10 Nov 2023 02:55:37 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74CB0875F3
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 02:55:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6c431ca7826so1517791b3a.0
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 17:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699581333; x=1700186133; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VUfFTMtHPfh54Fh1pfr4rbS6wNBVDfaUw22gA3aImI0=;
 b=GawqppRbxWSUcLRuwKImwG9RJ166IpRGeGvPaRztRD8lQIKvNO36DHCtC0SyNQtgp2
 peR6kpdeZpdiHktyrtBfA6et1l5aNnqGwRvc92ox/nNYypsmfBUhHaDaeUQ4afI3W00t
 1bVnfDz5EzvAT2pWSV8yEHAmNSBJZuPTA/8T6GdQf5nRS4ImhJlWPs7RmO/a4UAQjdPb
 +Lnp0kDQwdiNCek144PF4SH+GoNeNUJ5UjIkoRQpEMdBIpru5dtCt7wWBvknpcZi3q0f
 Rj48yiuRtDsalP3pLf0EN/gYTFDQELWZQ1gcetKscEQiGNUXda1wTJmdyZKJwqHGS8Pn
 1a2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699581333; x=1700186133;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VUfFTMtHPfh54Fh1pfr4rbS6wNBVDfaUw22gA3aImI0=;
 b=iUNxvBvACpI8YR+s9SgZhJzI7MEBEWIfkcUJ3jr0XGNIzXcsbJgb2MQJM1u2kHcAvt
 qdueDtokonCFJI82b+hCeAwXM/Edg3o6vEldLipUOJ1XVDPbO2sZX+8hYc0ul38iF6jO
 9O8BQmPAHLGDRpXkE019zN2uV9AHmaBdLtsNlpaw2NQqK/m2nHmCn17d57isI4CTVRe8
 KCi8MBNu5t1zzUaPMpq1Cqw/bsT0bFa4aHQtDEnDdDEicVx5nuv5MXiVAdYIg52fmxFt
 K+jB0QozsUQ4aR4hC9dTaF0pGzjE6y67dntQtpenE3or0b2rSPCignzvmOcOUoolamgP
 mVEg==
X-Gm-Message-State: AOJu0YzSmrQNnth74ParGzDxKj2p55Aywof6Wsuy8rn+XKbAUzli1STB
 iVbd67ntDXLwtEvtM6lbJ9AIzuZCieTv3l7buly/vw==
X-Google-Smtp-Source: AGHT+IGOvJa4eHuaq/dpHMRBsTP2CimBhf4S1vcoTukQ2nKj2FBIYh79nQon94enxsFtqcrJQMyf6W0l+9ir6pud9Tc=
X-Received: by 2002:a05:6a20:914b:b0:171:c88a:891e with SMTP id
 x11-20020a056a20914b00b00171c88a891emr7242177pzc.55.1699581332692; Thu, 09
 Nov 2023 17:55:32 -0800 (PST)
MIME-Version: 1.0
References: <20231109223435.706053-1-igor.opaniuk@foundries.io>
In-Reply-To: <20231109223435.706053-1-igor.opaniuk@foundries.io>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 9 Nov 2023 19:55:21 -0600
Message-ID: <CAPLW+4=RPq1mQVo081JUsMyn+Zo=0AgJSH7WXMfoxe8O_DXr5A@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] poplar: use random mac address
To: Igor Opaniuk <igor.opaniuk@foundries.io>
Cc: u-boot@lists.denx.de, Peter Griffin <peter.griffin@linaro.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Shawn Guo <shawn.guo@linaro.org>
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

On Thu, Nov 9, 2023 at 4:34=E2=80=AFPM Igor Opaniuk <igor.opaniuk@foundries=
.io> wrote:
>
> Set CONFIG_NET_RANDOM_ETHADDR=3Dy, which sets random eth address in
> case there is no configuration provided neither in CONFIG_ETHADDR
> nor in "ethaddr" env variable.
>
> This fixes the problem:
> poplar# dhcp
> Error: ethernet@9841000 address not set.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>
>  configs/poplar_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/poplar_defconfig b/configs/poplar_defconfig
> index f0ab2319a4..b6e0c3166c 100644
> --- a/configs/poplar_defconfig
> +++ b/configs/poplar_defconfig
> @@ -22,6 +22,7 @@ CONFIG_CMD_USB=3Dy
>  # CONFIG_ISO_PARTITION is not set
>  CONFIG_ENV_IS_IN_MMC=3Dy
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> +CONFIG_NET_RANDOM_ETHADDR=3Dy
>  CONFIG_USB_FUNCTION_FASTBOOT=3Dy
>  CONFIG_FASTBOOT_BUF_ADDR=3D0x20000000
>  CONFIG_FASTBOOT_BUF_SIZE=3D0x10000000
> --
> 2.34.1
>
