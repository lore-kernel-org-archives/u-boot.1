Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019E7C83F1D
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 04:46:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED35382AC4;
	Tue, 15 Jul 2025 06:46:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=lessconfused.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=lessconfused.com header.i=@lessconfused.com header.b="eTxWS7yF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D68982B07; Tue, 15 Jul 2025 06:46:00 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0832C8277D
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 06:45:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=lessconfused.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=da@lessconfused.com
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b39011e5f8eso4296915a12.0
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 21:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lessconfused.com; s=lessconfused; t=1752554755; x=1753159555;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+Ns+B6F/z3rJvNSoInYmgctcaqYz8TfKyi4rpM2+vAw=;
 b=eTxWS7yF2pcJHN9Q5WpQRQLz6oQVEjSTVJz7fz1SUJ9TLGoDeYr9+Gmh8r5DoxLpJW
 Lzzh+LELe7VsEL1UGFHoATRBgmgegnLYrUS68gC6/Y7KkdH4Z7E+8rfdvNgIgyalp8bM
 IALRdgULjfEfjjXUw3BU+R8uRzhf65KPbb1dQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752554755; x=1753159555;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+Ns+B6F/z3rJvNSoInYmgctcaqYz8TfKyi4rpM2+vAw=;
 b=UMr2s0Din4rZ/3o5W5EfvZDSlYnEfRSxJmyR/0+V63zsL/lJsnDl/+CLFGCaigKhYr
 f/1AVzJrcVpZiWsyStkdkK+dBOHXB1Y8rGt4YjHD0ZMnB8nyU3MB9myb9HhvhshQd5dO
 u3cQE3guOh36XNKzBc/zcFvJUg8QpWvIucbGRz/O64prBdsAmeMZNcRbBjcDDUHOna1t
 3XQuo54o1PD5KhmD4aXkZh155mYtcz996lIKrW148J3/JN8s3VhlCpACIaCPtjY+L3QQ
 yyFFOBiVwtlw39vs6BqlX983W28qGt6x1AA49+r1ROKbL8O91gDBweEj8mkR4Dj9p/Ls
 WRzQ==
X-Gm-Message-State: AOJu0Yw097/+1w+2r7d09bS86W+/H00Jx8L8ym0Kh+yswKK8dk7DyzIC
 rdTrsHEdnhBK1+3IHaFSbbDkUKArKszuSTIp2dYLxdUtCqIy+JzFQWwTXfLtqUxmZID88QlCJrW
 OeTO8212zUuK6ZWYcaCXoeO0NZBqNuq8DjaTrDS16gA==
X-Gm-Gg: ASbGncu/giTVmV0hbaP6N2FrzQCpxf3eBWM0di7knVD9dW/n9Rgiq6uRob5IjGqLaQU
 535tJktC/I7JL4ZMd44XVp6XC6B25Hp4/wUytB3nLsCZqv8Zo1HMrDo7i2kZYbL8m+hSwpknslt
 jRi1vI0R9Bcyk5Y341A9RijwPTCpYU+fUEV+lpiKDLsewkcW+mi5qm+4t0qBI/GsbUC3Szyjj/L
 E+ZQN/ktgRGr4XmCyOvupN5z2SzwIwUZKXsdg==
X-Google-Smtp-Source: AGHT+IExgF0KLCMplvEa1l2buG049MnUVhUy0skW3uCBe9eG7OFCyuf+nsVOur1KOSJN2SEZWmdS0GbtaSmRDxMFvh8=
X-Received: by 2002:a17:90b:1fc3:b0:311:abba:53c0 with SMTP id
 98e67ed59e1d1-31c4f4ae185mr24494021a91.9.1752554755344; Mon, 14 Jul 2025
 21:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1740672437.git.jerome.forissier@linaro.org>
In-Reply-To: <cover.1740672437.git.jerome.forissier@linaro.org>
From: Da Xue <da@lessconfused.com>
Date: Tue, 15 Jul 2025 00:45:43 -0400
X-Gm-Features: Ac12FXz0k5Lucf98D_o9CLXi0cYSkPdMQK3EIxrw0GnjYPVs4blTmJehqVYoFsA
Message-ID: <CACdvmAjUwxAx2_r3Mvacn_4oG97uYUaKsTmTQ4F4KzaN7+aaQA@mail.gmail.com>
Subject: Re: [PATCH 0/5] net: lwip: root certificates
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Jerome,

> Then new Kconfig symbols are added to support providing the certificates
> at build time, as a DER or PEM encoded X509 collection:
> WGET_BUILTIN_CACERT=y and WGET_BUILTIN_CACERT_PATH=<some path>.
> Note that PEM support requires MBEDTLS_LIB_X509_PEM=y (for the cacert
> command as well as for the builtin way).
>
> Here is a complete example (showing only the relevant output from the
> various commands):
>
>  make qemu_arm64_lwip_defconfig
>  wget https://curl.se/ca/cacert.pem
>  echo CONFIG_WGET_BUILTIN_CACERT=y >>.config
>  echo CONFIG_WGET_BUILTIN_CACERT_PATH=cacert.pem >>.config
>  make olddefconfig
>  make -j$(nproc) CROSS_COMPILE="ccache aarch64-linux-gnu-"
>  qemu-system-aarch64 -M virt -nographic -cpu max \
>         -object rng-random,id=rng0,filename=/dev/urandom \
>         -device virtio-rng-pci,rng=rng0 -bios u-boot.bin
>  => dhcp
>  # HTTPS transfer using the builtin CA certificates
>  => wget https://www.google.com/
>  18724 bytes transferred in 15 ms (1.2 MiB/s)
>  # Disable certificate validation
>  => wget cacert 0 0
>  # Unsafe HTTPS transfer
>  => wget https://www.google.com/
>  WARNING: no CA certificates, HTTPS connections not authenticated
>  16570 bytes transferred in 15 ms (1.1 MiB/s)
>  # Dowload and apply CA certificates from the net
>  => wget https://curl.se/ca/cacert.pem
>  WARNING: no CA certificates, HTTPS connections not authenticated
>  ##
>  233263 bytes transferred in 61 ms (3.6 MiB/s)
>  => wget cacert $fileaddr $filesize
>  # Now HTTPS is authenticated against the new CA
>  => wget https://www.google.com/
>  18743 bytes transferred in 14 ms (1.3 MiB/s)
>  # Drop the certificates again...
>  => wget cacert 0 0
>  # Check that transfer is not secure
>  => wget https://www.google.com/
>  WARNING: no CA certificates, HTTPS connections not authenticated
>  # Restore the builtin CA
>  => wget cacert builtin
>  # No more WARNING
>  => wget https://www.google.com/
>  18738 bytes transferred in 15 ms (1.2 MiB/s)

Is there a simple way to convert multi-certificate root trust pem to
der? I tried packing it as a PKCS#7 and got "Could not parse
certificates (-8576)"

Best Regards,
Da
