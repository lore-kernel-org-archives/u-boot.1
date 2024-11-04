Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7607D1BDF3
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 20:59:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC3B78855C;
	Mon,  4 Nov 2024 21:58:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="tqy5/YxU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62E0C88DE6; Mon,  4 Nov 2024 21:58:57 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FB4F88360
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 21:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730753933; x=1731358733; i=xypron.glpk@gmx.de;
 bh=7vPh1I051QsNi3/PJEeHLmH9p7N7QaoqbhN1UwwDxnQ=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=tqy5/YxUkCe7yjpOcJuyI9GkwVF3NeL13YKAQwa799EoZegoDVEv91vpHeBdkDue
 VpNBoK+KZNxbXBCm7Suc+3fDi3+pgTV1E0T2iuE1nmFcuywtdXbvt9mTrzufC8M2y
 mYtI1JzB+tWelm0FGUsjdr+hukMiM+3N0ZNZrtY2okDBMWD3dD7tRWs07b3JeEzeX
 g2g3rwr/XiPxysnnIQW1tEZ3hMsN/aBvbOGH3Eft4/Mma74UZIwe3ifZXyEnZo5jR
 JiluFIBc6TrV9O7IA08uzxlRhB/zYxdX9GXzpzDUSO5gj8We8ntmWfVQQqpw/hXtG
 gAbBHsQrghPXS/G1ag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.108.63]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMXUN-1tR6c610x5-00Rcfa; Mon, 04
 Nov 2024 21:58:53 +0100
Date: Mon, 04 Nov 2024 21:58:50 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 4/9] docker: Adjust packages for arm64
User-Agent: K-9 Mail for Android
In-Reply-To: <20241104133954.840994-5-sjg@chromium.org>
References: <20241104133954.840994-1-sjg@chromium.org>
 <20241104133954.840994-5-sjg@chromium.org>
Message-ID: <FAADE9B2-6D3B-4975-8A5F-F96CADCD1B65@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AWV4YxIpfWw+aSTmbUMhISih+mjhekX/qDOHx8MePiuIl0wFvNo
 rXSXPhoCWtSB8979fhuXgITOM5MIykv5M6YwdqI3AGQONwkt3L1kKSSCloBq14mp5Eth+Un
 viTo68I81RkjyvHJ4ZljzirhrqeMJ5P/b15YkcvW1VbWm3/2OwZxKYhP+k8uWP7PX84+ccd
 NjCl4W9gd2sWTxy2XuPow==
UI-OutboundReport: notjunk:1;M01:P0:29U3jdD/4is=;+L+2HFVz/DbDZsi3v+QmhKIW6H4
 VHpPvlS8/u+l9k1w8xyxuGEEEyUu/hQzGPyocCtLWtWUCkhgSdMFVi7ZRVljxZHsnFTRBoy5+
 m+0dBy955E26S0Pl9d2l5wcDZ0xSyJtvrpbbveqXKHvOu19y7eAf7e/8QgfJeTi3yBVqxOau2
 Zyvz10qaK2mF1YwHBfhQy9iixCDiBECcEACClgbux1rIVqESyYnOJ1oWRv7h0OmsH34df2lJ7
 acNbqKkc+nNogqKqNtSnpYmV/SAoiu3FvgHXCkMXPCerNLomwA5kQfayqm37QhIdQkVzQX9Z2
 prslwYMrJaZ41BO/3EvOr6KnaUUk07rcQplbBmIIXtqrlb3QVda6J9M6mBzqzuB5R1+dAKA2v
 8oedMRGniEDpXAGSaJFSZyAY4IHbiPdD2O1UmhBMAP7qGBqkQpqp3JVhKMGI0yJYtLdLdzLWl
 mSWlR8DGKWBbP2lfTpI3LIMq99tpRJSEXQceCedepnXMqcar4jZ6eqirQ/nc949aJBR58OsG5
 bW8pfkXMXbGRTw7dPPlmK34xFZTt5leDB7PaxN2hllpiKv1ZL/cny0lO6ku0aGAkuf7Sj4Ita
 Ihre8tX5Fv/gXWRx0x9YHPtG62Awlbom85ukBCTHLO9a1JFOpHg+QNaxrXKg1dQhEUVsoSAuL
 xlWuTEufE7i7b8HMLoEjUpFgGJStZXpUA0axhj8XTft1sKQ4/+2QAXZE3gGA+alNd8w9S7uGl
 GhJR+M6XYHaBGLbQmmQhk1YvuAZtblNLSP8C0jxZYWJ7O+MTS8RHswfwzFR0/GVXQq26Lf3dS
 whUV7GKbYvsXpzjk7Y34JoZthttYUsVPdcZd5dlHU3aj4=
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



Am 4=2E November 2024 14:39:48 MEZ schrieb Simon Glass <sjg@chromium=2Eorg=
>:
>The package names are slightly different for arm64 and we don't seem to
>have a linux-image-kvm package=2E Provide a different set for arm64
>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>---
>
> tools/docker/Dockerfile | 12 +++++++-----
> 1 file changed, 7 insertions(+), 5 deletions(-)
>
>diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
>index c9d794082c8=2E=2Ec4c3dc5a901 100644
>--- a/tools/docker/Dockerfile
>+++ b/tools/docker/Dockerfile
>@@ -39,7 +39,12 @@ RUN wget -O - https://mirrors=2Eedge=2Ekernel=2Eorg/pu=
b/tools/crosstool/files/bin/x86_
> RUN wget -O - https://github=2Ecom/foss-xtensa/toolchain/releases/downlo=
ad/2020=2E07/x86_64-2020=2E07-xtensa-dc233c-elf=2Etar=2Egz | tar -C /opt -x=
z
>=20
> # Update and install things from apt now
>-RUN apt-get update && apt-get install -y \
>+RUN if [ "$TARGETPLATFORM" =3D "linux/arm64" ]; then \

Please, use 'arm64' and not 'linux/arm64' as variable value=2E

>+		EXTRA_PACKAGES=3D"grub-efi-arm64-bin linux-image-generic"; \

Replace, arm64 by the variable, which may take the value 'riscv64'=2E

>+	else \

This 'else' does not work for riscv64=2E

The exception is amd64 and not arm64=2E Only amd64 has two GRUB versions=
=2E

Best regards

Heinrich

>+		EXTRA_PACKAGES=3D"grub-efi-amd64-bin grub-efi-ia32-bin libc6-i386 linu=
x-image-kvm"; \
>+	fi; \
>+	apt-get update && apt-get install -y \
> 	automake \
> 	autopoint \
> 	bc \
>@@ -65,13 +70,10 @@ RUN apt-get update && apt-get install -y \
> 	gnu-efi \
> 	gnutls-dev \
> 	graphviz \
>-	grub-efi-amd64-bin \
>-	grub-efi-ia32-bin \
> 	help2man \
> 	iasl \
> 	imagemagick \
> 	iputils-ping \
>-	libc6-i386 \
> 	libconfuse-dev \
> 	libgit2-dev \
> 	libjson-glib-dev \
>@@ -89,7 +91,6 @@ RUN apt-get update && apt-get install -y \
> 	libtool \
> 	libudev-dev \
> 	libusb-1=2E0-0-dev \
>-	linux-image-kvm \
> 	lzma-alone \
> 	lzop \
> 	mount \
>@@ -126,6 +127,7 @@ RUN apt-get update && apt-get install -y \
> 	xilinx-bootgen \
> 	xxd \
> 	zip \
>+	${EXTRA_PACKAGES} \
> 	&& rm -rf /var/lib/apt/lists/*
>=20
> # Make kernels readable for libguestfs tools to work correctly
