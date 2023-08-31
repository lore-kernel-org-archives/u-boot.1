Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC34EC83F29
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 03:58:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39E318655E;
	Thu, 31 Aug 2023 05:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="M6p1eOCX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA7B38655E; Thu, 31 Aug 2023 05:58:19 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C4698655C
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693454296; x=1694059096; i=xypron.glpk@gmx.de;
 bh=UX2QLbWtaOJ2CpQyqaPGIGYg8tohYdm//RViBB653cw=;
 h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
 b=M6p1eOCXhsO1K0iQ4dnQ1uG2HvROpdo08PNEB7Rw3qFMRM87e11nkro9+RwvTzX4CaA60Mt
 mPWpOfwxIjG+kGhivbPQcqn1IYwktl80FiNCufjENCxpNlPfr1pUgT6Y1azL4JAbxLXWEv4gK
 McYZ3Doh8B+1ZMwiV8QHLJ/IxhgW5J/jhAUHPqfwZ8moN55kKm/jiU1Dawxu6/TSpp1BBk61+
 3Gd4xu1O5+yXg0batIjyzXVPQQ5vIAeFlvFpXFC1vX/x2UReLUXGiUZBOMJVRfOWPp2OYLLga
 wZKdE6ZDBWm9QWpGU28g9axQo0xEI+PyoYWe6ucftz4Eg95cvB+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([62.143.244.162]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mw9Q6-1pm4680s3o-00s512; Thu, 31
 Aug 2023 05:58:16 +0200
Date: Thu, 31 Aug 2023 05:58:15 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [RFC PATCH 9/9] upl: Add initial documentation
User-Agent: K-9 Mail for Android
In-Reply-To: <20230830172917.RFC.9.I010f4a9bf3e17c8e8ea0c41a053c745d56ca9559@changeid>
References: <20230830232928.2590178-1-sjg@chromium.org>
 <20230830172917.RFC.9.I010f4a9bf3e17c8e8ea0c41a053c745d56ca9559@changeid>
Message-ID: <A6EEF68A-80C1-4888-AD27-3A78826559DC@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u7joWuBYdK5I/+hhdryz5IPGlQk8v3gefGR6B2YLiBjYbO8hNzA
 /Ink/IwIcFeO+Twkk2tLOf5wk3fsIK+4c7wEowSDQdrePr+WQbm1TgoQC80kUaABvRfmuhX
 GILJEycOTCZ9q6ocJJCNvG6pUQ48ziaZ6zfnu9eP7mqL7U2FMjD4OtMlZfBG3XkEElgNxI9
 q073hnzFIBgsjeMWbS80A==
UI-OutboundReport: notjunk:1;M01:P0:wvyawo0pFaM=;YVFvw6vTbU8fD9I2Ym3YScqBeFZ
 LtBxqUNrMnCQUrorg1+xo3k4k+hqavdf0x6m9IaPcM0WUqt29+qGbijhdW8E9kChyN5QaYuUc
 G4UQIDboUAFnAbjCPo5I/7cglHl4/nEtj95GqcDOOYqhGkGwlXhYJZMLzvAVMfHKZISaPDU50
 vBje/wtP/uy4bstKCG7e6wTtVp8Xlg/G3uUGZO0Idmz2BMlPnoxqJQxjNhIeFcx4qBcVU6Vjz
 y2BsvJyYIjKLYVP3jj6VSb4RCbqYph5KSUYdgUri7XItP+TaHx/wyzTx+llFKZZw5bmoB2S8H
 C5PvIEiYU0VrcSV3tmpvvabONf+8MEu8hlk63zt6DPRjKfuosjgCLeNeom00YOKLoH4oaUDY+
 rBbBX24qMy+hoME80NRm69jZwJhWlVKuuRTTPcuMXmKrutWbeYmvZn4aHoMmP86FT+wVU2MTe
 ed9crU3WrVVNSfZxiKT6Z+jL2Wzkbs6L+/oSfdtPSNxZAEgvfrE8p7bbYc3arHixGDTA8m1Wi
 mkw/vaeXRemJaqExBH1ALghnQQX6vFJlzou4qajeBhhvhPNZYxEqA7rMqsoHQad4TeJeDXx/I
 45RJeMMqYloH5JcLc3HE8gZCr33TCooCSzEsdTR3ft+mYwJwol95ub1oce8xRTRBHBTQ4NniD
 cgkjedDzfk0cO6XErozd86Kh/vDhV1rycAqmUcEzjIKcYqXL0/EywVaKmaPsch6qOwkiyXiqZ
 /gaBTYmE8DLOzsKANTVP9KfSMAgrlPXwvmxb9fIrV6wcxXw2VLHAGA+oh6RTJcHIMIN+v6kOl
 n0w4s36T9mDuD8mb5dA8uzQHVxiebjrbr0M3MTSyc6PFO9lh3CXiUzbmtK1y8HIGp++jQYNUe
 4qKDvCuUzVXckcEDlP9XAe3gFhTwpF32qKC7aWw6rzxHs39COty8R3WQg8NRNookErtiHoh6q
 fxuLjIRMd83Jsi/0ZbvPgWSQ2GI=
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



Am 31=2E August 2023 01:29:23 MESZ schrieb Simon Glass <sjg@chromium=2Eorg=
>:
>Add some placeholder documentation to explain the basic concept=2E Once t=
he
>spec is published, more can be added and this series applied=2E
>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>---
>
> doc/usage/index=2Erst |  1 +
> doc/usage/upl=2Erst   | 27 +++++++++++++++++++++++++++
> 2 files changed, 28 insertions(+)
> create mode 100644 doc/usage/upl=2Erst
>
>diff --git a/doc/usage/index=2Erst b/doc/usage/index=2Erst
>index ed896dfb3a0=2E=2E78665fd5759 100644
>--- a/doc/usage/index=2Erst
>+++ b/doc/usage/index=2Erst
>@@ -13,6 +13,7 @@ Use U-Boot
>    partitions
>    cmdline
>    semihosting
>+   upl
>=20
> Shell commands
> --------------
>diff --git a/doc/usage/upl=2Erst b/doc/usage/upl=2Erst
>new file mode 100644
>index 00000000000=2E=2E2ae4d4a1178
>--- /dev/null
>+++ b/doc/usage/upl=2Erst
>@@ -0,0 +1,27 @@
>+Universal Payload
>+~~~~~~~~~~~~~~~~~
>+
>+Universal Payload (UPL) is an upcoming Industry Standard for firmware
>+components=2E UPL is designed to improve interoperability within the fir=
mware
>+industry, allowing mixing and matching of projects with less friction an=
d fewer
>+project-specific implementations=2E UPL is cross-platform, supporting AR=
M, x86 and
>+RISC-V initially=2E

Please, provide a link to the specification=2E

>+
>+UPL is defined in termns of two firmware components:

terms


>+
>+`Platform Init`
>+	Perhaps initial setup of the hardware and jumps to the payload=2E

%s/Perhaps/Possible/

>+
>+`Payload`
>+	Selects the OS to boot

IIRC the UPL payload typically is not the OS but other firmware or a boot =
loader=2E

Best regards

Heinrich

>+
>+In practice UPL can be used to handle any number of handoffs through the
>+firmware startup process, with one program acting as platform init and a=
nother
>+acting as the payload=2E
>+
>+UPL provides a standard for three main pieces:
>+
>+- file format for the payload, which may comprise multiple images to loa=
d
>+- handoff format for the information the payload needs, such as serial p=
ort,
>+  memory layout, etc=2E
>+- machine state and register settings at the point of handoff
