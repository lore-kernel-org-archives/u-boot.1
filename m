Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDACBC5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 20:11:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B16F81FEE;
	Mon,  2 Jun 2025 22:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="harGOOyx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09E888205A; Mon,  2 Jun 2025 22:11:22 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0AE281E72
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 22:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1748895076; x=1749499876; i=xypron.glpk@gmx.de;
 bh=y3fau1a0OhNhpfkq7ap3cKvZ6vvAgFuoRwtDtxkFjv4=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=harGOOyxPBq5p7/pWi4k9g4d6fy0Zy7NEjzZ3WWSsFOG6hu9yNOlu6L4Mif8dMVp
 0Yukb1j8se64SCUhztWaTLjMNsFsW8VrOwuRFZuICoRaOnVOzZuWlC3XXTgrpJOk4
 E9gRZLuv79MykOKAsX7l8cseJP36SRrpfF4nwyu1fn2xyrqCxg9/YHfx5nLqLnOTq
 7/5JI/ZuYoO9CdrvExNRq37iPrDP5gZTPT7AjHKdc7/HttG/2aDIgpQyaERk7VQog
 JICLeSNoqwcpnxTTcCCD0larVAk4bDR/GBFtZuFelBWQd9JXlsU5Tw1+i73M8UTGd
 9wfmHQ2yEENBUK4nQA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MybGh-1v5me11Ycf-00wwBJ; Mon, 02
 Jun 2025 22:11:16 +0200
Date: Mon, 02 Jun 2025 22:11:12 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Greg Malysa <malysagreg@gmail.com>, u-boot@lists.denx.de
CC: adsp-linux@analog.com, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 03/10] docker: add ADI build-related tools to docker image
User-Agent: Thunderbird for Android
In-Reply-To: <20250602194507.15159-4-malysagreg@gmail.com>
References: <20250602194507.15159-1-malysagreg@gmail.com>
 <20250602194507.15159-4-malysagreg@gmail.com>
Message-ID: <EB8928C9-E912-4F52-B080-B7EACBA89740@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HrKuirwJOgmtDYBypZQk2N1UybTmCV2sBlmr2szx1GeTaiawDNs
 7mU8JyoeHIBXpuvame8GvnsasKEwLjVpn9IqinCa4C3LvwvIgj6qRAIcg7hCqHHREL+fMHF
 9Umyl1PxLrbrzfRXdNDXDSNq/9do1d/e6hKOP6b7F21rzq/nSL5Ga33h8P7H4BI2mG8S/09
 LaZKnb6RKw+wSxySanKzQ==
UI-OutboundReport: notjunk:1;M01:P0:j1eX09NmWcQ=;M9xuXmfdGTNyW2etGJ/E2fAFi3+
 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
 ivsG+cwGjrJNKDZ6w+F7sRudZZaGlDuQChgOAw==
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

Am 2=2E Juni 2025 21:44:41 MESZ schrieb Greg Malysa <malysagreg@gmail=2Ecom=
>:
>ADI processors require packaging with the ldr utility for bootrom

"ADI processors" is not self explanatory=2E Can we add a sentence like

"LDR files are the executable format for the Analog Devices ADSP-SCxxx on-=
chip Boot ROM=2E Provide the ldr compiler for ARMv7 and ARMv8=2E"



>compatibility=2E Normally this is available as part of our yocto-derived
>toolchain but it is not a part of any other premade toolchain, so it is
>otherwise unavailable in the docker image for CI=2E This patch adds a
>source build from the ADI maintained github repository=2E The same ldr
>tool is used for arm and arm64 for all of our boards with names adjusted
>to match the expected $(CROSS_COMPILE) for these boards=2E
>
>Signed-off-by: Greg Malysa <malysagreg@gmail=2Ecom>
>---
>
> tools/docker/Dockerfile | 8 ++++++++
> 1 file changed, 8 insertions(+)
>
>diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
>index ceb7a25ad4d=2E=2E1c4a169e079 100644
>--- a/tools/docker/Dockerfile
>+++ b/tools/docker/Dockerfile
>@@ -308,6 +308,14 @@ RUN wget -O - https://coreboot=2Eorg/releases/corebo=
ot-24=2E08=2Etar=2Exz | tar -C /tmp
>     sudo cp build/coreboot=2Erom build/cbfstool /opt/coreboot/ && \
>     rm -rf /tmp/coreboot-24=2E08
>=20
>+# Build ldr tool for ADI boards and install to match expected abi name
>+RUN git clone https://github=2Ecom/analogdevicesinc/lnxdsp-arm-poky-linu=
x-gnueabi-ldr=2Egit /tmp/lnxdsp-arm-poky-linux-gnueabi-ldr && \
>+	cd /tmp/lnxdsp-arm-poky-linux-gnueabi-ldr/src/ldr && \
>+	=2E/configure && \
>+	make -j $(nproc) && \
>+	cp ldr /usr/bin/arm-linux-gnueabi-ldr && \
>+	cp ldr /usr/bin/aarch64-linux-ldr

In the Docker image we tend to put such tools into a directory in /opt=2E

Best regards

Heinrich


>+
> # Create our user/group
> RUN echo uboot ALL=3DNOPASSWD: ALL > /etc/sudoers=2Ed/uboot
> RUN useradd -m -U uboot

