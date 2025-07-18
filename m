Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0347C83F17
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 17:34:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D52E83677;
	Fri, 18 Jul 2025 19:34:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=lessconfused.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=lessconfused.com header.i=@lessconfused.com header.b="A6SVq3Xb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A44CF8367F; Fri, 18 Jul 2025 19:34:26 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8155883612
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 19:34:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=lessconfused.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=da@lessconfused.com
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b1fd59851baso1620680a12.0
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 10:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lessconfused.com; s=lessconfused; t=1752860062; x=1753464862;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nMuZzyyeP/bq3o9ObPMtAQw37FUeKvMg54QG5iYzdiY=;
 b=A6SVq3XbOxYnK4AECskVZ3uisYtu27qbEA5e81yGY8YHvleVONLoMauXxkIOlS7S3M
 4GlVItZKlRxNEFVokNNzRtsGt0kdFV69koq5gAJ/4hJIaXQOXKXlb63HAN3vCsugxArM
 GqroNXDdJCJaRctZr7WxCxY0ousu09YJYEE9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752860062; x=1753464862;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nMuZzyyeP/bq3o9ObPMtAQw37FUeKvMg54QG5iYzdiY=;
 b=rpOmFcDlxaYO5f/YqrSET6xA4Je8y/q8Px1PpRkwc4kfGtGyusNJ9I5NwWFlRFyRO0
 C9yVwzLsioO36QBwcpuUfVRU6rJF/5KUVGM0cpXaMxIQpPxLkMZyP9p4u7FtEX+siT42
 mx5awOLMKhAmO+pupv3GwRwOhLn7kpQdzpQi3z/YsdJwCzt3Ovv2XjSEA+wdQGePc2X3
 jzVUmaysUu8ZR3F9kH8zN8BqXIvvWPeFoyNVGBQBjGCV2emgV+2ZW0vNmwWdBbOmrqVB
 WxL2lTBRS+I8cJC00CWhNZPcq28Lcn/HrugCDzDEMrDyhipY5yk77YqQnm9Ll+dm85S5
 TSRg==
X-Gm-Message-State: AOJu0YyWkKcRc17zONS6nWgDbd1d93feToUhooW6Wat8Y8DEKmp5tzR2
 SFldVI1uaXl+q8pzdqnhAeiX6bLoFUwnwr4nR2WK1pGdsnypcxeOZ3Zx6w4NYPghNKfBfnr8xVB
 RaVObRupCunPqyLUbihENykOTEsN90SAubRfhTb3yZuL/YE+lmH+K
X-Gm-Gg: ASbGncutqiRXDdTg/TS/bXAU+LBTk4KsyyfSgxmyCabjCw3UUwFmrOAZDHvX6fRTnkX
 o/RSOSaC5ZhH8GW2zk2kWoLOErTFZJ6Y/5VN5vqyjUX2Usj88H3mWZIwGNWiB2V/DrwqpgWK5mQ
 XMWPdAku6v5JBE3sYIUBV0z/itSbz1wyWIW0IektGnn4HhZqqJ4LfSJEFwsBInGhLimz5aVwSou
 bNURoLu14Ke/aINO+4hOPGm7ajILSea1riNmw==
X-Google-Smtp-Source: AGHT+IFwAaIlf2N8KoxosTzCttc9d9V8Gb03xyeDsZs35J+NpjsF8PpP8KtmpJuiZDg3J4HLED0Uz92brSHwfUvKdU4=
X-Received: by 2002:a17:90b:2c85:b0:311:e8cc:424c with SMTP id
 98e67ed59e1d1-31c9f446ab2mr15007923a91.25.1752860061920; Fri, 18 Jul 2025
 10:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1740672437.git.jerome.forissier@linaro.org>
 <CACdvmAjUwxAx2_r3Mvacn_4oG97uYUaKsTmTQ4F4KzaN7+aaQA@mail.gmail.com>
 <4843f58a-357c-400e-bccb-34810e779366@linaro.org>
In-Reply-To: <4843f58a-357c-400e-bccb-34810e779366@linaro.org>
From: Da Xue <da@lessconfused.com>
Date: Fri, 18 Jul 2025 13:34:10 -0400
X-Gm-Features: Ac12FXyoBZNvIkjayFJZ_DXzFswUTWrK5WZ-dvdWuNnMQUdwRcoHh1ixmcU1p3A
Message-ID: <CACdvmAi8_TDCxgkvZJq1_BkWUTnZMBZ+ad8xhX8hWfZyRWhQ9A@mail.gmail.com>
Subject: Re: [PATCH 0/5] net: lwip: root certificates
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Fri, Jul 18, 2025 at 10:08=E2=80=AFAM Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Hi Da,
>
> On 7/15/25 06:45, Da Xue wrote:
> > Hi Jerome,
> >
> >> Then new Kconfig symbols are added to support providing the certificat=
es
> >> at build time, as a DER or PEM encoded X509 collection:
> >> WGET_BUILTIN_CACERT=3Dy and WGET_BUILTIN_CACERT_PATH=3D<some path>.
> >> Note that PEM support requires MBEDTLS_LIB_X509_PEM=3Dy (for the cacer=
t
> >> command as well as for the builtin way).
> >>
> >> Here is a complete example (showing only the relevant output from the
> >> various commands):
> >>
> >>  make qemu_arm64_lwip_defconfig
> >>  wget https://curl.se/ca/cacert.pem
> >>  echo CONFIG_WGET_BUILTIN_CACERT=3Dy >>.config
> >>  echo CONFIG_WGET_BUILTIN_CACERT_PATH=3Dcacert.pem >>.config
> >>  make olddefconfig
> >>  make -j$(nproc) CROSS_COMPILE=3D"ccache aarch64-linux-gnu-"
> >>  qemu-system-aarch64 -M virt -nographic -cpu max \
> >>         -object rng-random,id=3Drng0,filename=3D/dev/urandom \
> >>         -device virtio-rng-pci,rng=3Drng0 -bios u-boot.bin
> >>  =3D> dhcp
> >>  # HTTPS transfer using the builtin CA certificates
> >>  =3D> wget https://www.google.com/
> >>  18724 bytes transferred in 15 ms (1.2 MiB/s)
> >>  # Disable certificate validation
> >>  =3D> wget cacert 0 0
> >>  # Unsafe HTTPS transfer
> >>  =3D> wget https://www.google.com/
> >>  WARNING: no CA certificates, HTTPS connections not authenticated
> >>  16570 bytes transferred in 15 ms (1.1 MiB/s)
> >>  # Dowload and apply CA certificates from the net
> >>  =3D> wget https://curl.se/ca/cacert.pem
> >>  WARNING: no CA certificates, HTTPS connections not authenticated
> >>  ##
> >>  233263 bytes transferred in 61 ms (3.6 MiB/s)
> >>  =3D> wget cacert $fileaddr $filesize
> >>  # Now HTTPS is authenticated against the new CA
> >>  =3D> wget https://www.google.com/
> >>  18743 bytes transferred in 14 ms (1.3 MiB/s)
> >>  # Drop the certificates again...
> >>  =3D> wget cacert 0 0
> >>  # Check that transfer is not secure
> >>  =3D> wget https://www.google.com/
> >>  WARNING: no CA certificates, HTTPS connections not authenticated
> >>  # Restore the builtin CA
> >>  =3D> wget cacert builtin
> >>  # No more WARNING
> >>  =3D> wget https://www.google.com/
> >>  18738 bytes transferred in 15 ms (1.2 MiB/s)
> >
> > Is there a simple way to convert multi-certificate root trust pem to
> > der? I tried packing it as a PKCS#7 and got "Could not parse
> > certificates (-8576)"
>
> AFAICT MBed TLS should be able to parse multiple root certificates as
> long as they are in DER form. U-Boot doesn't enable the PEM format at the
> moment, it is less space-efficient. Please try:
>
> openssl x509 -in cert.pem -outform DER -out cert.der

This only converts the first certificate to DER, not any of the other
certificates.

>
> Thanks,
> --
> Jerome
>
>
> >
> > Best Regards,
> > Da

Best Regards,
Da
