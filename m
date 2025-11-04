Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98031CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 18:08:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 366B3808AF;
	Tue,  4 Nov 2025 19:08:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L6D3y+AG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 518CA8144A; Tue,  4 Nov 2025 19:08:49 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5945F8003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 19:08:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-594270ec7f9so3116001e87.3
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 10:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762279727; x=1762884527; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SHkIY0E3Mo91yFf/uhRhimQCh8+KYZk4IuIW/HuP0ow=;
 b=L6D3y+AGte9BHUJA64kBgNWyds0umOBCLLemhhpNeGpbyiF7k9Ilv8T5GMRmmZSMiy
 Daz1AlbemzatTj88++DCruovQGfz+quNTQ+6YaqmVWy3ZUKS8/OmKMxCyIjlpr68cVg3
 8SisXJWiaeUZ2O0BVGKAyvITRt5wPgCGoE/7KETaO1h+7V9Q30+OG6sz1pgmvdUvjZwK
 Km5Nj9z7G9KjP/B6SwaXoC1AxSW6B/nEyWDnRVfSsh585ymgabYd22c9dfO7veXgUBSj
 Vlic1FGzXkKxKZtRmBf20Pun5gmJLT2GZdWKJgKAxbFajJHTz2ecg7cV4SQcglXZa3AN
 nIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762279727; x=1762884527;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SHkIY0E3Mo91yFf/uhRhimQCh8+KYZk4IuIW/HuP0ow=;
 b=IanGOf0yvSNG2UTTnYsI/dZr7xhdDhw2DrTHbuMgGzJIEoK76UE2PGvZ/uQ7pHIwG/
 4jZHI8Y1hQxiSIfZxj7d2YVIV8mQVaDUGq/Vph2hY+7m5Mrs49jIhNkfT8SilvtYXWk8
 dH09ZhrNDZORHicIlBFmZtV7cVvjn0+eNCbMkf8M2zhsDIqX+hha1vZUIKZZyZfQ6/9R
 qOPQ2K8v/hiT8d5bcsdXf3Q/x8BrZv1l1WaMcVak4dZ2o5XWvf+t+QKh3ucotkn1uhGp
 9ixFTaCYt5Icq3W9DBvv2auD4H3brM+A+UH8Y740kvralq42aqAVFvdLOZa+mmYNVAMX
 jP5Q==
X-Gm-Message-State: AOJu0YyGB1zJlGVzXw0twwQmp9nCJwT/PKpCsdaF6PsIg7y5ceNYZyz7
 HKb9Ar/4v6sYXi2u12zDq/jdtj3O1v1kTlSZAmum+Kjw4/V/dJXUVsrOU/G/evIrdw2Yirb1Xlm
 b1tdAwQsveNGAcd9Hz2OQgSEFIZOgA/s=
X-Gm-Gg: ASbGncvtOZi8T8Yd7yz1gfsjYf0T4m08N8zVRRQgiR/eda1yX8rwgoC4LvJbpFuSx3b
 nvbFlswwoUk7uz+w4WBby60jtludM1SfLdw6arL0Qf7nfxmAWFR/elXMQzoqXNkQ9W3a0MLDgr+
 SDvFHndLxcdqpAk6tNEAmnVC4BP5tylk8IY3hoONe14PnuAjePRtowC13XELp3hcsPxSSY7qIze
 txdAejPDE/W1CvLWDdiea/JXPFxQR8GKJeZocVEdzyin7PQ9hYxVdcHbTYbBd8bSQBOlCTdQASF
 72fLsSAzj3uBR5Np
X-Google-Smtp-Source: AGHT+IEsvI5XPNmXGB86g+kyCzGBwQVfvFplwsulcVMZQkEdgocf58myTh5x1iMf4xKCo542o62PH5l/KKIhgHRHA2g=
X-Received: by 2002:a05:6512:2250:b0:594:2654:5e48 with SMTP id
 2adb3069b0e04-5943d55cd29mr28578e87.3.1762279726482; Tue, 04 Nov 2025
 10:08:46 -0800 (PST)
MIME-Version: 1.0
References: <20251013034128.1752157-1-ye.li@nxp.com>
 <20251013034128.1752157-2-ye.li@nxp.com>
In-Reply-To: <20251013034128.1752157-2-ye.li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 4 Nov 2025 15:08:34 -0300
X-Gm-Features: AWmQ_bma6Nr6ZzgudPc_pbiiJ93y4mtLkI9uaqLn0JsT6zzAUg1THemK5psKqUA
Message-ID: <CAOMZO5Bh9tZnRvV-SRmRNdLoruWUQQ2Gv-YJ9K8-CE7q3ZVU0w@mail.gmail.com>
Subject: Re: [PATCH 1/3] imx95_evk: Share the env file for both 19x19 EVK and
 15x15 EVK
To: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, uboot-imx@nxp.com, 
 alice.guo@nxp.com, ye.li@oss.nxp.com
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

On Mon, Oct 13, 2025 at 12:41=E2=80=AFAM Ye Li <ye.li@nxp.com> wrote:
>
> Rename the env file to imx95_evk.env to share it with iMX95 15x15 EVK
>
> Signed-off-by: Ye Li <ye.li@nxp.com>

Applied the series, thanks.
