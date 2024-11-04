Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDCDD1BDF2
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 20:50:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3518188E1C;
	Mon,  4 Nov 2024 21:50:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="FcT1XqI+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E67988DE6; Mon,  4 Nov 2024 21:49:59 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D8D288E7B
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 21:49:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730753396; x=1731358196; i=xypron.glpk@gmx.de;
 bh=OlhGhLpC4K+TBJ6dJUmnDujtOIb3HolwU1MUPYVeyFs=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=FcT1XqI+VHFvGkKLCWgcpISrbQMFho7u06hbZNjetr3Rsns5Bc+UdNMEvmyHH0Qi
 CtAddVXmR51S/sCkpxttovqp6c+2ySJHuoHNOLTXhX+P2cF/REjvssghIjipelBMz
 BbttaVW4YGce8HoOlWoOddRsVjv2j9J/bjzg/v/tpMuHGATQn2vDjFL4dlInZ0XgS
 8aSMkx1IjAYkJfiinaPAaNaj+qW2yW6D5iUL34Fbd70jQM0XXWYHEkNdFo39gL8YP
 nslO3Rjjs61sw8YdOGMBcggtiUIs4rkcUYamRpgeAl2ynNYaVHzBYM/D2nxiLoTzt
 Y9zolWxEXqp2BYdDew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.108.63]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1fii-1to2eZ0x8C-00u3Se; Mon, 04
 Nov 2024 21:49:55 +0100
Date: Mon, 04 Nov 2024 21:49:52 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 3/9] docker: Support building for multiple architectures
User-Agent: K-9 Mail for Android
In-Reply-To: <20241104133954.840994-4-sjg@chromium.org>
References: <20241104133954.840994-1-sjg@chromium.org>
 <20241104133954.840994-4-sjg@chromium.org>
Message-ID: <3BF73C1E-1FC5-4332-B93D-32001DF9157C@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:54KVXQ5px7PJFJ4Uz+G+OROsg6Bis6WWlFZFrf+mMzmJKQvq4yV
 t1zuiBfmy4Tqnp3pe3olIfGUw7lPIuOytuCcODLI/nx6MPCclF8TK4d0Sbtz8x1gXL0saHN
 Ph5h2gb3N/Ls8GSoY+bWWig0YUsMjLhirHBPlxh6tQV+86gr5bSeocPO0z9Tn9UzytuDVqA
 qqSOjxYX/kfVQnFR5juSQ==
UI-OutboundReport: notjunk:1;M01:P0:HoHrXIN+qms=;S+/zYrgoS2PXU2pFWdZ8bV4rH+X
 KvNke44JIVLuBPvKOt9JNYfD8jwaIvBOCIQVKcOlZgej6g7zNcn0UHw4Gq3WenjVHHnLnJDeb
 /vT16un9QqDMdLPL9LPscV0tOP2hDWfjBarhBjLF+S+3td4Bv9U5Gljlje27jfFuePx9oxVQa
 6hvZLmls3zif8/OXdyHCDsiyo5W3TPE0+SQOEuS4QSfVXocEangbsy10LjqGGh+3O0QR7iFeq
 ghZjyvuGSvMrDiGFTPHaKarZDnhociBvoIn26asz/cYv8bpYOlpwv+V0/VrdOmoGI+fVr5Ccq
 91VgwdiXf5wZ/xcSSXSaJkI7GP1lmHL5scrgkeyqbo4X2KbmNgoz/szlQJs+5t/FOShYruhvk
 KaSJEAQ/DpxM8S/RqET4o0F1DpG8ktmEuQeyQvQdS+m0yOWAQfCb5WIsNlyFdpXVR1kYHpofH
 TNFrWp1+6vAIOOTfON+++u5BNTFj78ersiuuQpw7OhdLT/uI30y2UMQ2q2dKtLI18M42VTZ8p
 sJwQBSmvg9aprUtdVrjdl6MFdknh/yedE06pJKgDOc49JWaoQAhp8ybEgGpguQhoGShV0Rx2w
 R/hWFCoeoLJh/t7M+oeJamFyy8Y5qPtSEvpLXMDOrVA8bmkGhTE0XKXU7ViyzC2Y1PgUgPPRz
 THITuZvy4cW+CraK8uYZI3jzRAM5TmCJNWKda+3No1VZajt0dsqt2lWAAn4cpi85yAARqOFd+
 /tyNSvmCINjwyek5yzNnwXbP81d0oClNN8+/n/PgMd9b1PMm9zqrcqyjqDorAGB0RJ6NFncla
 dGXxqjhfSeQcLiO1EQ3bCKsQ==
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



Am 4=2E November 2024 14:39:47 MEZ schrieb Simon Glass <sjg@chromium=2Eorg=
>:
>Add instructions on how to build the file for multiple architectures=2E
>Add a message indicating what is happening=2E
>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>---
>
> tools/docker/Dockerfile | 7 +++++++
> 1 file changed, 7 insertions(+)
>
>diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
>index 967ac89fbde=2E=2Ec9d794082c8 100644
>--- a/tools/docker/Dockerfile
>+++ b/tools/docker/Dockerfile
>@@ -2,6 +2,9 @@
> # This Dockerfile is used to build an image containing basic stuff to be=
 used
> # to build U-Boot and run our test suites=2E
>=20
>+# Build with (for example):
>+# docker buildx build --platform linux/arm64/v8,linux/amd64 --tag sjg20/=
u-boot-gitlab-ci-runner-multiarch:jammy-20240808-03Nov2024 =2E
>+
> FROM ubuntu:jammy-20240808
> LABEL org=2Eopencontainers=2Eimage=2Eauthors=3D"Tom Rini <trini@konsulko=
=2Ecom>"
> LABEL org=2Eopencontainers=2Eimage=2Edescription=3D" This image is for b=
uilding U-Boot inside a container"
>@@ -9,6 +12,10 @@ LABEL org=2Eopencontainers=2Eimage=2Edescription=3D" Th=
is image is for building U-Boot i
> # Make sure apt is happy
> ENV DEBIAN_FRONTEND=3Dnoninteractive
>=20
>+ARG TARGETPLATFORM
>+ARG BUILDPLATFORM

Please, add comments describing what these variables are used for=2E

Best regards

Heinrich

>+RUN echo "Building $BUILDPLATFORM, for target $TARGETPLATFORM"
>+
> # Add LLVM repository
> RUN apt-get update && apt-get install -y gnupg2 wget xz-utils && rm -rf =
/var/lib/apt/lists/*
> RUN wget -O - https://apt=2Ellvm=2Eorg/llvm-snapshot=2Egpg=2Ekey | apt-k=
ey add -
