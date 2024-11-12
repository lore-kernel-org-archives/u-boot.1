Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4930D42BA2
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 15:08:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 229C0891B0;
	Tue, 12 Nov 2024 16:08:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="T7XMZ0Tc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD661890FD; Tue, 12 Nov 2024 16:08:21 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FF8489444
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 16:08:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731424098; x=1732028898; i=xypron.glpk@gmx.de;
 bh=wE2/iZ9lOrXfylniHm9HSuF1tbbpcpZiOfQWEP7tqOM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=T7XMZ0TcWLuG9Dm2fMpmORJkSwRjewBjdw3MVipUalWoEIBAIgu1YAcalc5/QwhP
 2in61o42n680n7fntnlWMOX/vtygS45uNB5qDourRJfrI8BL1CUDIPuHufo3eHHem
 Lgrfzn7W5KECp01OgoiN0rAoZ+zSTVg8eRFhVo/hcjUTnGtFozsauROxHkN+LtsY4
 ye3FAgXF4JHKer4MOKzr8glW4K32poMzcK0djxLA95SG+JARU7UROIDuZ7/dsrp6Z
 5o+WP1Q1qNVOkECOItCEW46dN7fNg1/pcHrTvaih2BSVFeyy4SvCf3xHAOO4aWyiK
 MhD2stdFEkiFv6+etg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N17UW-1tuY5z3nHW-00wVTh; Tue, 12
 Nov 2024 16:08:17 +0100
Message-ID: <5604ea68-5b31-461a-a4a2-22da37e64dac@gmx.de>
Date: Tue, 12 Nov 2024 16:08:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/9] docker: Support building for multiple architectures
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241112141105.640189-1-sjg@chromium.org>
 <20241112141105.640189-4-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241112141105.640189-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cLacMCxGur3PmRAnaPE03beEcVjBTzInsZDeLf4e7CA6aM2Ru0a
 PXkLjbuxcjjAsbFGTTOkXQV6X8UcO8CxJGkR56uxIiKrcSG02LS6YEHAWlvWMauaqTU7YF1
 wcYw1i9g7ccilj139Ih7+h5E/rC1sc1Qs+PBHpVuCAcupft2urF6PFaw51StvjkFqz3I3WG
 5GCJGZKdXWQT9+vILlN9g==
UI-OutboundReport: notjunk:1;M01:P0:xYFCWYYJ6cY=;VovyBxWa6m6zFrn8axZ1wLpDnS2
 mCIwAo3vFX9WE2k/LFsxlw6lFPgP3cMEL1mfEmjhae8P9Xz5SJY672dJ6h18x2jISMFGPlw/x
 vs5ZlUTHJHXq248MGaNn1+5O0kTvoYQFEIHzpXRKZplXEZgSBG48YUHz3YNuUsaURERkR18p/
 0EPEvRkzl5b2CCMDszynhW/MuPJ9+a6zE/StCcyuXWTniOtBrf2Skm4JfxZsmtFai6RIFLoDN
 d0Plemlj4A2qUqN4lCgCaleTm/KSnebOGm8BRqeuQT/L8RUpN7Otz/Bes3CrftFKfTn/C3b+l
 IfqJob0mifHRFjuRLiah2h59yW8MECFQS2ZoYVDdVMh+b36dxVgqJFXaYjHKJOVzLYyOwkN0p
 JzkYy8/Zu5zgV6Rz/RDsCz0l09tC8O0/h/fwgMAIQuGRDs5tArLoi+E4sbqzHApUYu2DSmT1O
 2VdHV4ThymBfnRsepd/YyoJWeK/zJTtzReuApS0r/ozWs76blvUiw62cPqjfZOXxA6fje2KsN
 5835YiEIFYrdkuSO3t2z47AwhnbeNGXL2lyc3NSPqDSbOOISYvhd/JceqhsE2RcRgrXf+sF1c
 GKQPFGSRgd5GwAvWe4UlvMWaoFChePe5Unt1MCiaONdFrw/2sYaiNEXL3ozOB43qi+bXB0lOh
 SCC86Yjb2eMMFvORKDLW7Y601yLNkXEr/75+j/cz6ZFLSFNeIvT1fDavNkKWL12rIALelwOq2
 HASOkaTTKN6ZK/DPhHgLwJz4MqpRP+0JqxFhn4SuR2icNar6rJtGD4v9LueLGzClJr5/cch1R
 34fCgjy4W/nbqNk5kj5gp+v3WWaHkVkX0k0QhBUPbPOfMzIOaYq+UYeWr5pp6J1rg4M3n1iXg
 vO0BjhF5U2YxJ9jkCJLsfn8wa9HWeuhm7JRZaAmEOR6li6bUqonyo4K1t
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

On 12.11.24 15:10, Simon Glass wrote:
> Add instructions on how to build the file for multiple architectures.
> Add a message indicating what is happening.
>
> Update the documentation as well. Drop the 'sudo' since these should not
> be needed if Docker is correctly configured.

Please, explain what you mean by correctly configured.

By default Ubuntu requires sudo to execute docker.

https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as=
-a-non-root-user
teaches us:

"The docker group grants root-level privileges to the user. For details
on how this impacts security in your system, see Docker Daemon Attack
Surface."

So adding a user to the docker group may not be the best idea.

Installing Docker in rootless mode is possible
(https://docs.docker.com/engine/security/rootless/) but as said it is
not necessarily the distro default.

Best regards

Heinrich

>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v3:
> - Move ARGs to the top
> - Revise documentation to explain a common error and building on arm64
>
> Changes in v2:
> - Update docs also
> - Add comments to the ARG variables
>
>   doc/build/docker.rst    | 25 ++++++++++++++++++++++---
>   tools/docker/Dockerfile | 12 ++++++++++++
>   2 files changed, 34 insertions(+), 3 deletions(-)
>
> diff --git a/doc/build/docker.rst b/doc/build/docker.rst
> index 45659b3b89d..b8fd12ead71 100644
> --- a/doc/build/docker.rst
> +++ b/doc/build/docker.rst
> @@ -1,14 +1,33 @@
>   GitLab CI / U-Boot runner container
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -In order to have a reproducible and portable build environment for CI w=
e use a container for building in.  This means that developers can also re=
produce the CI environment, to a large degree at least, locally.  This fil=
e is located in the tools/docker directory.  To build the image yourself
> +In order to have a reproducible and portable build environment for CI w=
e use a container for building in.  This means that developers can also re=
produce the CI environment, to a large degree at least, locally.  This fil=
e is located in the tools/docker directory.
> +
> +The docker image supports both amd64 and arm64. Ensure that the
> +'docker-buildx' Debian package is installed (or the equivalent on anoth=
er
> +distribution).
> +
> +You will need a multi-platform container, otherwise this error is shown=
::
> +
> +    ERROR: Multi-platform build is not supported for the docker driver.
> +    Switch to a different driver, or turn on the containerd image store=
, and try again.
> +
> +You can add one with::
> +
> +    docker buildx create --name multiarch --driver docker-container --u=
se
> +
> +Building is supported on both amd64 (i.e. 64-bit x86) and arm64 machine=
s. While
> +both amd64 and arm64 happen in parallel, the non-native part will take
> +considerably longer as it must use QEMU to emulate the foreign code.
> +
> +To build the image yourself::
>
>   .. code-block:: bash
>
> -    sudo docker build -t your-namespace:your-tag .
> +    docker buildx build --platform linux/arm64/v8,linux/amd64 -t your-n=
amespace:your-tag .
>
>   Or to use an existing container
>
>   .. code-block:: bash
>
> -    sudo docker pull trini/u-boot-gitlab-ci-runner:jammy-20240227-14Mar=
2024
> +    docker pull trini/u-boot-gitlab-ci-runner:jammy-20240227-14Mar2024
> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> index 967ac89fbde..7f4b17ab0a4 100644
> --- a/tools/docker/Dockerfile
> +++ b/tools/docker/Dockerfile
> @@ -2,13 +2,25 @@
>   # This Dockerfile is used to build an image containing basic stuff to =
be used
>   # to build U-Boot and run our test suites.
>
> +# Build with (for example):
> +# docker buildx build --platform linux/arm64/v8,linux/amd64 --tag sjg20=
/u-boot-gitlab-ci-runner-multiarch:jammy-20240808-03Nov2024 .
> +
>   FROM ubuntu:jammy-20240808
>   LABEL org.opencontainers.image.authors=3D"Tom Rini <trini@konsulko.com=
>"
>   LABEL org.opencontainers.image.description=3D" This image is for build=
ing U-Boot inside a container"
>
> +# Used by docker to set the target platform: valid values are linux/arm=
64/v8
> +# and linux/amd64
> +ARG TARGETPLATFORM
> +
> +# Used by docker to set the build platform: the only valid value is lin=
ux/amd64
> +ARG BUILDPLATFORM
> +
>   # Make sure apt is happy
>   ENV DEBIAN_FRONTEND=3Dnoninteractive
>
> +RUN echo "Building on $BUILDPLATFORM, for target $TARGETPLATFORM"
> +
>   # Add LLVM repository
>   RUN apt-get update && apt-get install -y gnupg2 wget xz-utils && rm -r=
f /var/lib/apt/lists/*
>   RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add=
 -

