Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6B5EB5967
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 06:23:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96FE083A47;
	Wed, 11 Feb 2026 07:23:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZpuIZJXL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A99283A5A; Wed, 11 Feb 2026 07:23:45 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCEC782BF2
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 07:23:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-7963aa14dbbso8974927b3.1
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 22:23:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770791020; cv=none;
 d=google.com; s=arc-20240605;
 b=Q/3sSK8VEwfDdlDzc6ZIFSIQncJ8Q87/ebTpEsgLOMlWCZoHyvdSCC6/mN0DCcXMTE
 NJ2A4aVpl2Iujk+7udwQDq6/alXXGD7A5kEVOl0B+ca1XF5HVaTCUpdMitjAYDpqI5o4
 upO6ivvAyyr2sa1T9Azt22pUEuvDa7EhlzMf9WSqrUVKZdbAMMcB/nHQ/aMU59Se7d4H
 6vajNwVFi82BoV/JU3MW5ZMX/HanGgzc5DR3jHeVvNjON5L3EIOUXwTczIVuhHoIZGbZ
 NfACcvt4YJJzNRU0ai1DR/Hh9kk0lgKmw0lhyRjuD+NUbOpfbV5UaryID19sKeaFTwkZ
 s5vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9P2Kk8FkBOot5Ramb0ESa77TSXyCa1IGsgLNPPOdUls=;
 fh=sp6E9HVhTUAiEEWqHbKho2dPu9WIHpUiyF52VbJ44Bc=;
 b=ZHciHMjtH+QiiB1FaRY/ePy4ShaepuWtfnZlfDcvQRQarO9rPFVhOjaJhkQBymSqoK
 9WaXPEkH2I/aPuD4IegbZMrSAAroZ/Z+7bhKm9rqv5L3Dcy4WQ3rma6BrQo4gcxk5jV7
 6JMNVUkmLmVOTgRHTadWFaZo3cDjZBfJwDkb358rYiU/MHqCnTBunV9DDkFl/LEBVIsI
 1ez4GAdl9zQOeX81Ju7gd8tv+L8kCTciONDnzx5J4o9fxfO2gcKsEyZbBmL++xkpWnsY
 Cashbm3B09rx9GT0XpyBllA+J2Kk7KLDhLdD17fICz5G65A4ypBw+ElFjngT8dZR0Pk4
 NyOg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770791020; x=1771395820; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9P2Kk8FkBOot5Ramb0ESa77TSXyCa1IGsgLNPPOdUls=;
 b=ZpuIZJXLw1lRusCz64jLgleIvpYGiQDXNDeojsAk7PH9cm8RpgStdBAWu07teQ8usm
 +AQpZnYGqseUzHSgX9lQs27GxfLe1yefJQ1w0O+wQQqmMlGTxivZxWV0hbg1d8lJ+e16
 eoz2bpwtZBy6ThNtjTvu0MgxaK3s+w7hnYQ2Pua8+H6BaqSXEvzgjGplxfnnIkHJoyrr
 mgdWyh8yKECmUSe6n/d2hu5fV0YIcHnrABeaD1jBP46KkV5RxV+VIOld/KTfBD8dhZz3
 x7WgE4hP0Uzdj+RjsoW905rG1y9rJKhfG3VwaZTmaEyF38ZhVN68KzJc61OMD0z8cg8V
 yMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770791020; x=1771395820;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9P2Kk8FkBOot5Ramb0ESa77TSXyCa1IGsgLNPPOdUls=;
 b=RnrUaWxtTnNNSyAbjs/jVz9flgryPXImSjv8qwdg+7H6XMXiU7ZKTEhcBA2no6MtEc
 XJeCszru55A7wfXl0uDVp4kyaocI0CIKO8UhXTespghOUE4fUwuSF3R9DCmeDqZ8NVjs
 kvZVw1xa/+RpiIoprvXuoVicchKP4iIdl2+w2Oj9TLcgT6y1TPQVdGosMovvRcHoNTeV
 SVB+c5P6AKCj/iXLbpdlfuDnbc6sHzBTvVhOAsBgM02D52Q4rXepIjVGJFag65vNGw8i
 92s78+UF2F3s5Hkrm8WydyVE2od+sugez+5ppGQZiPXdFw6w8riZhh34z15hUA12Auol
 wSpg==
X-Gm-Message-State: AOJu0Yw1UqIBJlrMcEiDhCqqSFUc5ElqHYIuQXABN+CjEBq4yxz65t+B
 CpXNPwmO4u8B96LylPUBB9GleZfRVBQ8BSvQb+qC5zxMky5RGA0iJiZNvdNba4g9pWJQXvH/p2E
 OFaMVcf2LK3lsuVH3ESC6D17DC2ZySn4EhRJeH/UdwQ==
X-Gm-Gg: AZuq6aK0QYDxIt3Mf0t6GJ9yy2JJA5l5KafXTCs9tfkjtAxA4G0UdLMsLWojDB1BOaQ
 y/Nxb6fT4wlzCdEDd1oeEje7GpRVMP0EugROIvnu+7gggDr/4gvCZNBNDtEMVtrS34pFNys9qCY
 VaWF8/DGCiGwIjKwL6Ah40eD/KCJUh6cbDz57WtP85cVBy1YuYjRRah3KPZio+6hCS+nwngNMFp
 VDglRv20v5+Yl7x+UlhdTIX2w0o4ezYnGKAccCB0NsuAqLml2uRijymuLaRmH+PkYd3ca2X07dK
 idpO3xFKKUEeGCVm8NHfdygfJU4qOEpWKz3+HZzNYg2CSbQ19SqEItoLnjGfKyTxbpGdtCj0lmD
 G1qamZcAUCko/VmmiCgn1cMm6FxCmdloJ6EyfkLNhZtYPnTktSfZavM460jZ6Ge5qYg8cIp8Xsa
 r7KRUI9iMbjSQObFzvLnYSkUxdHayMkW0d84SaCNVdzTubuU8fs6xPf4JYTrS/w6TLNyqY13dUr
 AnpGQljgycVeXBH0TCyfXHXMg2ety2PsfRJPmG+E/JrZFBIEiyJS3n0Qjih29VTWMOQb2s1JhdX
 koNuQXuZ3BQW5aeOlUKiMNh8jZqEMHbvx6nC6VloJUW0
X-Received: by 2002:a05:690c:ed3:b0:794:a8ea:f04a with SMTP id
 00721157ae682-7965e2457ffmr42379947b3.20.1770791019872; Tue, 10 Feb 2026
 22:23:39 -0800 (PST)
MIME-Version: 1.0
References: <20260123022552.100884-1-hs@nabladev.com>
 <23a76123-9fe9-16f3-7464-2d0b6fe4147a@nabladev.com>
In-Reply-To: <23a76123-9fe9-16f3-7464-2d0b6fe4147a@nabladev.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Feb 2026 08:23:03 +0200
X-Gm-Features: AZwV_QhmJtdJ8BSeRXsFCpKx0h2xJHyviYipL3KEK3QYEJESzP5LN6J2vbFeDdM
Message-ID: <CAC_iWjKT0_TFwErDss-jkdx0vxffTH=ayU3FV8d_VprohaLAzw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] lib: sm3: coverity fix and add documentation
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Heiko

On Tue, 10 Feb 2026 at 07:26, Heiko Schocher <hs@nabladev.com> wrote:
>
> Hello Tom,
>
> this series fixes a coverity issue and adds the missing doc for the
> new sm3sum command... I got no further comments... may I ask, if it
> could be applied?

Apologies, Tom was expecting me to send an PR and I missed that.
I'll send one today

Cheers
/Ilias
>
> Thanks!
>
> bye,
> Heiko
>
> On 23.01.26 03:25, Heiko Schocher wrote:
> >
> > patch "lib: sm3: fix coverity error" fixes a Coerity scan error,
> > which is a good catch, as this part is from linux [1].
> >
> > Running some hashes with this change and I see no problems,
> > or wrong hashes [2] (Hashes calculated with the help of the
> > webpage [3].
> >
> > Patch 2 adds the missing documentation for the new sm3sum command
> > which missed his way into mainline.
> >
> > rebased series to
> > commit 6b2d05748cf ("Merge tag 'u-boot-imx-master-20260117' of https://=
gitlab.denx.de/u-boot/custodians/u-boot-imx")
> >
> > Azure build:
> > https://dev.azure.com/hs0298/hs/_build/results?buildId=3D205&view=3Dres=
ults
> >
> > [1]
> > https://elixir.bootlin.com/linux/v6.14/source/include/crypto/sm3_base.h=
#L86
> >
> > [2]
> > =E2=94=82   =E2=94=9C=E2=94=80[helios-uboot] tftpb ${tftpp}/abb1.txt
> > =E2=94=82   =E2=94=82    ## ethernet@30bf0000 Waiting for PHY auto nego=
tiation to complete....... done
> > =E2=94=82   =E2=94=82    ## Using ethernet@30bf0000 device
> > =E2=94=82   =E2=94=82    ## TFTP from server 192.168.3.1; our IP addres=
s is 192.168.3.41
> > =E2=94=82   =E2=94=82    ## Filename '20260106/abb1.txt'.
> > =E2=94=82   =E2=94=82    ## Load address: 0x50000000
> > =E2=94=82   =E2=94=82    ## Loading: ##################################=
################  3 Bytes
> > =E2=94=82   =E2=94=82    ##      0 Bytes/s
> > =E2=94=82   =E2=94=82    ## done
> > =E2=94=82   =E2=94=82    ## Bytes transferred =3D 3 (3 hex)
> > =E2=94=82   =E2=94=9C=E2=94=80[helios-uboot] md.b ${loadaddr} ${filesiz=
e}
> > =E2=94=82   =E2=94=82    ## 50000000: 41 42 42                         =
                ABB
> > =E2=94=82   =E2=94=9C=E2=94=80[helios-uboot] sm3sum ${loadaddr} ${files=
ize}
> > =E2=94=82   =E2=94=82    ## sm3_256 for 50000000 ... 50000002 =3D=3D> 2=
f2e2c6e076ebff98112d96081a9714d783eb6d8ea46a16fbfdc3b589f1c374b
> > =E2=94=82   =E2=94=9C=E2=94=80[helios-uboot] tftpb ${tftpp}/abb2.txt
> > =E2=94=82   =E2=94=82    ## Using ethernet@30bf0000 device
> > =E2=94=82   =E2=94=82    ## TFTP from server 192.168.3.1; our IP addres=
s is 192.168.3.41
> > =E2=94=82   =E2=94=82    ## Filename '20260106/abb2.txt'.
> > =E2=94=82   =E2=94=82    ## Load address: 0x50000000
> > =E2=94=82   =E2=94=82    ## Loading: ##################################=
################  52 Bytes
> > =E2=94=82   =E2=94=82    ##      4.9 KiB/s
> > =E2=94=82   =E2=94=82    ## done
> > =E2=94=82   =E2=94=82    ## Bytes transferred =3D 52 (34 hex)
> > =E2=94=82   =E2=94=9C=E2=94=80[helios-uboot] md.b ${loadaddr} ${filesiz=
e}
> > =E2=94=82   =E2=94=82    ## 50000000: 41 42 43 44 45 46 47 48 49 4a 4b =
4c 4d 4e 4f 50  ABCDEFGHIJKLMNOP
> > =E2=94=82   =E2=94=82    ## 50000010: 51 52 53 54 55 56 57 58 59 5a 61 =
62 63 64 65 66  QRSTUVWXYZabcdef
> > =E2=94=82   =E2=94=82    ## 50000020: 67 68 69 6a 6b 6c 6d 6e 6f 70 71 =
72 73 74 75 76  ghijklmnopqrstuv
> > =E2=94=82   =E2=94=82    ## 50000030: 77 78 79 7a                      =
                wxyz
> > =E2=94=82   =E2=94=9C=E2=94=80[helios-uboot] sm3sum ${loadaddr} ${files=
ize}
> > =E2=94=82   =E2=94=82    ## sm3_256 for 50000000 ... 50000033 =3D=3D> e=
5e13e8215fe8eff7dcfd9375f3c3ff0674bd979dcd192539afc3562d45f1a5e
> > =E2=94=82   =E2=94=9C=E2=94=80[helios-uboot] tftpb ${tftpp}/abb3.txt
> > =E2=94=82   =E2=94=82    ## Using ethernet@30bf0000 device
> > =E2=94=82   =E2=94=82    ## TFTP from server 192.168.3.1; our IP addres=
s is 192.168.3.41
> > =E2=94=82   =E2=94=82    ## Filename '20260106/abb3.txt'.
> > =E2=94=82   =E2=94=82    ## Load address: 0x50000000
> > =E2=94=82   =E2=94=82    ## Loading: ##################################=
################  510 Bytes
> > =E2=94=82   =E2=94=82    ##      49.8 KiB/s
> > =E2=94=82   =E2=94=82    ## done
> > =E2=94=82   =E2=94=82    ## Bytes transferred =3D 510 (1fe hex)
> > =E2=94=82   =E2=94=9C=E2=94=80[helios-uboot] md.b ${loadaddr} ${filesiz=
e}
> > =E2=94=82   =E2=94=82    ## 50000000: 53 4d 33 20 69 73 20 61 20 63 72 =
79 70 74 6f 67  SM3 is a cryptog
> > =E2=94=82   =E2=94=82    ## 50000010: 72 61 70 68 69 63 20 68 61 73 68 =
20 66 75 6e 63  raphic hash func
> > =E2=94=82   =E2=94=82    ## 50000020: 74 69 6f 6e 20 70 75 62 6c 69 73 =
68 65 64 20 62  tion published b
> > =E2=94=82   =E2=94=82    ## 50000030: 79 20 74 68 65 20 53 74 61 74 65 =
20 43 72 79 70  y the State Cryp
> > =E2=94=82   =E2=94=82    ## 50000040: 74 6f 67 72 61 70 68 79 20 41 64 =
6d 69 6e 69 73  tography Adminis
> > =E2=94=82   =E2=94=82    ## 50000050: 74 72 61 74 69 6f 6e 20 6f 66 20 =
43 68 69 6e 61  tration of China
> > =E2=94=82   =E2=94=82    ## 50000060: 20 61 6e 64 20 69 73 20 61 6c 73 =
6f 20 6b 6e 6f   and is also kno
> > =E2=94=82   =E2=94=82    ## 50000070: 77 6e 20 61 73 20 74 68 65 20 63 =
6f 6d 6d 65 72  wn as the commer
> > =E2=94=82   =E2=94=82    ## 50000080: 63 69 61 6c 20 63 72 79 70 74 6f =
67 72 61 70 68  cial cryptograph
> > =E2=94=82   =E2=94=82    ## 50000090: 69 63 20 53 4d 33 20 61 6c 67 6f =
72 69 74 68 6d  ic SM3 algorithm
> > =E2=94=82   =E2=94=82    ## 500000a0: 2e 20 54 68 65 20 22 53 4d 22 20 =
72 65 70 72 65  . The "SM" repre
> > =E2=94=82   =E2=94=82    ## 500000b0: 73 65 6e 74 73 20 22 63 6f 6d 6d =
65 72 63 69 61  sents "commercia
> > =E2=94=82   =E2=94=82    ## 500000c0: 6c 20 63 72 79 70 74 6f 67 72 61 =
70 68 79 2c 22  l cryptography,"
> > =E2=94=82   =E2=94=82    ## 500000d0: 20 77 68 69 63 68 20 72 65 66 65 =
72 73 20 74 6f   which refers to
> > =E2=94=82   =E2=94=82    ## 500000e0: 20 63 72 79 70 74 6f 67 72 61 70 =
68 69 63 20 74   cryptographic t
> > =E2=94=82   =E2=94=82    ## 500000f0: 65 63 68 6e 6f 6c 6f 67 79 20 66 =
6f 72 20 63 6f  echnology for co
> > =E2=94=82   =E2=94=82    ## 50000100: 6d 6d 65 72 63 69 61 6c 20 75 73 =
65 20 74 68 61  mmercial use tha
> > =E2=94=82   =E2=94=82    ## 50000110: 74 20 64 6f 65 73 20 6e 6f 74 20 =
69 6e 76 6f 6c  t does not invol
> > =E2=94=82   =E2=94=82    ## 50000120: 76 65 20 73 74 61 74 65 20 73 65 =
63 72 65 74 73  ve state secrets
> > =E2=94=82   =E2=94=82    ## 50000130: 2e 20 49 74 20 69 73 20 62 61 73 =
65 64 20 6f 6e  . It is based on
> > =E2=94=82   =E2=94=82    ## 50000140: 20 74 68 65 20 65 6c 6c 69 70 74 =
69 63 20 63 75   the elliptic cu
> > =E2=94=82   =E2=94=82    ## 50000150: 72 76 65 20 64 69 73 63 72 65 74 =
65 20 6c 6f 67  rve discrete log
> > =E2=94=82   =E2=94=82    ## 50000160: 61 72 69 74 68 6d 20 70 72 6f 62 =
6c 65 6d 20 61  arithm problem a
> > =E2=94=82   =E2=94=82    ## 50000170: 6e 64 20 69 73 20 75 73 65 64 20 =
74 6f 20 72 65  nd is used to re
> > =E2=94=82   =E2=94=82    ## 50000180: 70 6c 61 63 65 20 69 6e 73 65 63 =
75 72 65 20 68  place insecure h
> > =E2=94=82   =E2=94=82    ## 50000190: 61 73 68 20 61 6c 67 6f 72 69 74 =
68 6d 73 20 73  ash algorithms s
> > =E2=94=82   =E2=94=82    ## 500001a0: 75 63 68 20 61 73 20 4d 44 35 20 =
61 6e 64 20 53  uch as MD5 and S
> > =E2=94=82   =E2=94=82    ## 500001b0: 48 41 2d 31 2e 20 54 68 65 20 6f =
75 74 70 75 74  HA-1. The output
> > =E2=94=82   =E2=94=82    ## 500001c0: 20 6c 65 6e 67 74 68 20 6f 66 20 =
74 68 65 20 53   length of the S
> > =E2=94=82   =E2=94=82    ## 500001d0: 4d 33 20 61 6c 67 6f 72 69 74 68 =
6d 20 69 73 20  M3 algorithm is
> > =E2=94=82   =E2=94=82    ## 500001e0: 32 35 36 20 62 69 74 73 2c 20 74 =
68 65 20 73 61  256 bits, the sa
> > =E2=94=82   =E2=94=82    ## 500001f0: 6d 65 20 61 73 20 53 48 41 2d 32 =
35 36 2e        me as SHA-256.
> > =E2=94=82   =E2=94=9C=E2=94=80[helios-uboot] sm3sum ${loadaddr} ${files=
ize}
> > =E2=94=82   =E2=94=82    ## sm3_256 for 50000000 ... 500001fd =3D=3D> 5=
3ce46ca129071694bac8007680573d83b941ea156ce46d9cc45a648c1b7e291
> > =E2=94=82   =E2=94=9C=E2=94=80Entering interactive shell...
> > =E2=94=82   =E2=94=9C=E2=94=80Press CTRL+] three times within 1 second =
to exit.
> >
> > u-boot=3D>
> >
> > [3] https://www.toolhelper.cn/en/DigestAlgorithm/SM3
> >
> > Changes in v2:
> > rebased series to
> > commit 6b2d05748cf ("Merge tag 'u-boot-imx-master-20260117' of https://=
gitlab.denx.de/u-boot/custodians/u-boot-imx")
> > added Acked-by from Ilias
> > Added comments from Quentin
> > - fixed typo in commit subject
> > - fixed a lot of style and spelling issues
> > - added in parameters section the format of the input values
> > - removed section "Return value"
> >
> > Heiko Schocher (2):
> >    lib: sm3: fix coverity error
> >    doc: cmd: add documentation for sm3sum
> >
> >   doc/usage/cmd/sm3sum.rst | 112 ++++++++++++++++++++++++++++++++++++++=
+
> >   lib/sm3.c                |   2 +-
> >   2 files changed, 113 insertions(+), 1 deletion(-)
> >   create mode 100644 doc/usage/cmd/sm3sum.rst
> >
>
> --
> Nabla Software Engineering
> HRB 40522 Augsburg
> Phone: +49 821 45592596
> E-Mail: office@nabladev.com
> Gesch=C3=A4ftsf=C3=BChrer : Stefano Babic
