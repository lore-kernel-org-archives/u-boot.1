Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89694D1BDF3
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 21:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC27288E50;
	Mon,  4 Nov 2024 22:04:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="EQST4W0j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BDBD884DB; Mon,  4 Nov 2024 22:04:44 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4203E88EC4
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 22:04:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730754281; x=1731359081; i=xypron.glpk@gmx.de;
 bh=g0Y327NpefcUpqD9VMj5oKaAzCvkiM4a5cxw4OdH6xE=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=EQST4W0jB0SgPoQyIy46i6x8Fkw2VJMs4PLeMtVbAIZwSQ4vZyZfdLtehwmDLsrK
 HA7mhFg9uY+X3ojFYkUOkNCEjZ9pkVnmMkE0R6TUle+/y/tBLwGt4DwXAxN9LQnJ6
 l12MALvB/eBTT3XpKgJHRLOWtQ/IQsjVz8M4E5sSTt6C//T1sC8HxdwlxFZ9HmkIm
 WAnklWL15X+FRY1di0Lh7e4o4k6we1RWYbU48dku9zTjvhVXSUsFkUCLT+n9Esrvu
 RtR6Ey8Fwg/Sw2HSwB3D1ewjsngo+6ubd6y01fnOK/FedqDoXb2H2DPuVHSVd1eGu
 LYSxnpMRMG6KiPjCOQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.108.63]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6bfw-1tu4Qg2R2c-012ooj; Mon, 04
 Nov 2024 22:04:40 +0100
Date: Mon, 04 Nov 2024 22:04:39 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 5/9] docker: Drop grub for arm64
User-Agent: K-9 Mail for Android
In-Reply-To: <20241104133954.840994-6-sjg@chromium.org>
References: <20241104133954.840994-1-sjg@chromium.org>
 <20241104133954.840994-6-sjg@chromium.org>
Message-ID: <E8B9AD50-9DAF-43CF-B512-165DB961CDCB@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sdWYTnKQK53o4/mnw/UtzS7ZFlNghEsW44ENhrmSyuqx06Z7J1x
 zSR0h0qU7QzH5Zl9fTnjh9L7H3YlTYUdFOQByA4uUawjImBHjd4rNWNoBXnYoJk9gxENUE5
 RP1IBFmn1aAOYaaJXlxzCwkQ/+Pq6JR01tCPlOnWOuL76f+HohpZ3sJ+zhVvr+7bxatEqxQ
 5Icgcv9DZEJZWVRr9NbZg==
UI-OutboundReport: notjunk:1;M01:P0:aVS4ysl+eqo=;LMXIzC0krFFiC12lyAFefTIFlbr
 oqOBoYnEir5ESS73SskZmGVYkMpC8sY+IhVhmphAJSRZ/0+wMGq2NKMcLzCpz6E/DDxYGGX7w
 IgVMZ0WT8aVBzLucCvdS0WAMkel+aAIPsN9e98zhQDvJl6txcDPC20FzhkKiS8B/OW0sr554t
 W7h5Gr9NoPk1xffO9bDIlHNcxWvfA7Jom2BUqncjfKPlYodtGSpyLhvPXx+hkV+u/WAreyxhb
 Ih7DWOSzqUP4m/QBU1ve5JJxnjxtkoMKHe26RWS6JUgCMrL04qbCpXSoDIW1Pe4XDoMd+ZxTR
 IdL2SYv3pqTwCofSoFPdAh+fA1F7tOxH98pL8U/KnnWTgZJECNUVcy4FSe3W/0Se7J1g/O1kx
 aV8ECo1cqdWBxM0inu2d+TU+QEnuOQKKIuXm77UA265BoayJS6qNBp2CVsRCdxxBuE8nghv5V
 lgyEmf+x7V9zJXkLYbIApilnSyhbCFYAV/6aFrR+Q/hMGKs836i0WgQSWvGYRAPTnKO9jJR8v
 54wEiU0jlkG78b/AvDJcn+kCulV263aRHTiCAfShvsoX8584r3HZHtQXlfPGPPSOdSsKMc0bd
 Qfs6qGFfoOUXpKe01KepyGb0QHavw7yh2FAiMDgG6ypSOEsHhcPtUp6u5NYHHaLAYADxGlEjC
 kiVq8VqIjKdbjFfzLCLZ7mASUqcqkvof1aebK4/SgcTfRF3UwiJ6SS0b350d6zOtiv/hzjChn
 WoCJMrCXz6qymIyaEqb3S0zjK4F0vN2O4arT+9PSZlshZlg0GC1da7u23JjLpN0sNnYFEoVAQ
 T5N3GpUyTWf/vGwbePq1IRgQ6tNn/zAD/t6FbDSRsAO3s=
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



Am 4=2E November 2024 14:39:49 MEZ schrieb Simon Glass <sjg@chromium=2Eorg=
>:
>This doesn't build on arm64 at present, so drop it for now=2E We only
>expect to run sandbox tests, so perhaps it isn't needed=2E
>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>---
>
> tools/docker/Dockerfile | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>
>diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
>index c4c3dc5a901=2E=2E60106a82801 100644
>--- a/tools/docker/Dockerfile
>+++ b/tools/docker/Dockerfile
>@@ -134,7 +134,9 @@ RUN if [ "$TARGETPLATFORM" =3D "linux/arm64" ]; then =
\
> RUN chmod +r /boot/vmlinu*
>=20
> # Build GRUB UEFI targets for ARM & RISC-V, 32-bit and 64-bit
>-RUN git clone git://git=2Esavannah=2Egnu=2Eorg/grub=2Egit /tmp/grub && \
>+# This fails on arm64
>+RUN if [ "$TARGETPLATFORM" =3D "linux/amd64" ]; then \
>+	git clone git://git=2Esavannah=2Egnu=2Eorg/grub=2Egit /tmp/grub && \
> 	cd /tmp/grub && \
> 	git checkout grub-2=2E06 && \

Upstream GRUB builds for arm64 and riscv64=2E

Please, retry with grub-2=2E12=2E

Best regards

Heinrich

> 	git config --global user=2Ename "GitLab CI Runner" && \
>@@ -184,7 +186,8 @@ RUN git clone git://git=2Esavannah=2Egnu=2Eorg/grub=
=2Egit /tmp/grub && \
> 	lsefisystab loadenv lvm minicmd normal part_msdos part_gpt reboot \
> 	search search_fs_file search_fs_uuid search_label serial sleep test \
> 	true && \
>-	rm -rf /tmp/grub
>+	rm -rf /tmp/grub; \
>+	fi
>=20
> RUN git clone https://gitlab=2Ecom/qemu-project/qemu=2Egit /tmp/qemu && =
\
> 	cd /tmp/qemu && \
