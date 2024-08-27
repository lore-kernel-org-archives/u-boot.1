Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E82C54731
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 18:47:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B978888C1;
	Tue, 27 Aug 2024 20:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GeTYX/SO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AE8288A3C; Tue, 27 Aug 2024 20:47:05 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3566E87C80
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 20:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2f51b67e16dso9879331fa.3
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 11:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724784422; x=1725389222; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0PJVNt7dze8s9Yp/FW5SmYgRRkt5jtB/OHUk9PF+T3M=;
 b=GeTYX/SOxFicDfPGHKyY16mBNMBMHdIxgidGS18Nj4Hc0xzyAt2yvgU2RbK9amu0SU
 3Nas3d3G2qubPrBjJ4/uI8L22tIj/HFTyhCDjQG0XRWzrTE+wlMIuf1VEcsGeZ268zLb
 Y1oi1q5eJ4mXowW2Qv4w9h/o121FOEKaGhfEtqOIQweZkExCU8rbV4oWhkBp64JVp/aH
 3JnTa5HLpfuqey4JsfUNFHYj2Unrf3ZGiTNNUMh6pWCIa6VbExifqZ0NwSTfT2x5Wurq
 DpuVTidVJfuQJ4L4N5ssELiSbyBH0q/PCphY/YOPRsekVghgACulSDB5oA2K9Tsu75vP
 BQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724784422; x=1725389222;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0PJVNt7dze8s9Yp/FW5SmYgRRkt5jtB/OHUk9PF+T3M=;
 b=CT2PoyibQfQtuUGFsNpO7jhmEgeMrHxBP5O+pcN4t3hycCOEGRu9IyZgKgbm1Ulrhv
 X8GF9ZAZGpDOTCQ12OaQ0yq4LPRe4RaCABy4D37aVAQOR8CYnAIwmbAF0mWaKQis0/FP
 1ZTKFA8LKtPuZpeX2PtwS7PVhVxNA+b3Zsp7crq7DQ/+w56qqKY3Srr6iEKHJGzPczEn
 9twFVEgN+1udeo9wtsDwMGpoh4lFrTTthjuDrb2nwoSqqv9FTB0JD4Ykbyd+y4d9VfSI
 gSImBtpB0O1WqdVgWpObE4LuqtZgqOQHju/me1FCHxQLx5PHK1lI1uS0qeFzPje2eutf
 x9ag==
X-Gm-Message-State: AOJu0YyZ4pjQZe55AM05k4gCLWuVGcTZoaqPdRciPEs5anyfdQV9SDZ5
 m0HCQnFWmrqsA+bNqn9suXa5vza3RpOl4DgVC1ifdfHT300h23moO2L1kKkCpiMVey3IU1pSRVI
 th9agM9qJw8UulkGEdgd/YekdW4jfCg==
X-Google-Smtp-Source: AGHT+IErkZoou/z1jXocB1hSSEC5adNX9oERJ5ceIX2t4wGJ1laxA93y7dMIy0Q/4jSQPRdXmhQMccWJeNEO32omTAk=
X-Received: by 2002:a2e:a986:0:b0:2ef:1db2:c02c with SMTP id
 38308e7fff4ca-2f514a12e51mr26603051fa.10.1724784422012; Tue, 27 Aug 2024
 11:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240808110654.4215b129@wsk>
 <CAOMZO5A74MigLO0qkeXi04=7M70jaiEgk9zdFBjUV74vuZDP0g@mail.gmail.com>
 <20240815221421.61f64a17@wsk>
In-Reply-To: <20240815221421.61f64a17@wsk>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 27 Aug 2024 15:46:49 -0300
Message-ID: <CAOMZO5B-fkLQsQx205mxXQdmk3ij6Hxx4ErM84DtEtBg3mYa7Q@mail.gmail.com>
Subject: Re: [Binman] Question regarding SPL symbol offsets generation
To: Lukasz Majewski <lukma@denx.de>,
 Mamta Shukla <mamta.shukla@leica-geosystems.com>, 
 Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>
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

Hi Lukasz,

On Thu, Aug 15, 2024 at 5:14=E2=80=AFPM Lukasz Majewski <lukma@denx.de> wro=
te:

> Unfortunately not - this change is only for properly setting start
> address of the u-boot.
>
> The _real_ problem here is the symbol placement generated by binman
> when we try to define the image as a single one.
>
> Moreover, this change follows other boards with imx8mm processor -
> ./configs/imx8mm_beacon_fspi_defconfig to be specific.
>
> The "fix" (for which I'd been now probably opt) for this issue would be
> to generate two images with binman - one for u-boot-spl-ddr.bin and the
> final flash.bin with the former one included (as it was before SHA1:
> 37e50627efacd8dae18b564e9d8886a033e181bc)

Is QSPI boot broken on i.MX8MM?

I am adding Adam and Mamta who have tested QSPI booting on
imx8mm_beacon and imx8mm_evk, respectively.
