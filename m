Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFD1D59F7A
	for <u-boot@archiver.kernel.org>; Sat, 13 Dec 2025 08:52:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEDF8828A2;
	Sat, 13 Dec 2025 09:52:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="bPzQkuX5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 410CD8307F; Sat, 13 Dec 2025 09:52:11 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B940E81D6A
 for <u-boot@lists.denx.de>; Sat, 13 Dec 2025 09:52:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1765615870; x=1766220670; i=xypron.glpk@gmx.de;
 bh=7GSZ3sRlQbJftoAgTFrUsj1+M/fuR5MuMGro2ueNBHg=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=bPzQkuX5H4jlrqp0qolBrN7Fjsa+1eP80QtZ5e+Ibqrc18xSa2io1QVgHt2Nix4L
 ai4XUF065bIMqFjhp1ftmXpjzZ9Og5qXmN+P7lsoUsPBQKHNRQ7sK8xkUWEKvufKZ
 XnjAQPBLeS6oCjlEaUzZuTe+0LVcsMnANJ3JH5khXonkLsqnp+avBMDCLSpb9MXAp
 VLcPl5bUtZKpMNdyOmSwdbuVEfIyHWpCx1yvIhB59IQ/cOOA59fyFUgnufMYEU6o+
 Nf0ILZoTs/O8Vd0G/RzQEHm5euDa/M4Q1PillsJfYJOaSfkfWM/68tyQxRC9zk8dB
 R/NcDL3802WijWfa8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([46.114.7.12]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJmKh-1vjWoG3MjZ-00RbEh; Sat, 13
 Dec 2025 09:51:09 +0100
Date: Sat, 13 Dec 2025 09:51:03 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: "Kumar, Udit" <u-kumar1@ti.com>, Quentin Schulz <foss+uboot@0leil.net>,
 u-boot@lists.denx.de, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>
CC: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Andre Przywara <andre.przywara@arm.com>, Ye Li <ye.li@nxp.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Justin Klaassen <justin@tidylabs.net>, 
 Samuel Holland <samuel@sholland.org>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 2/8] boot: fix prompt for SPL_LOAD_FIT_ADDRESS
User-Agent: Thunderbird for Android
In-Reply-To: <d46a7a85-7077-4b3e-84a2-2ce607412402@ti.com>
References: <20251212-kconfig-reorg-v1-0-72441d8cc53c@cherry.de>
 <20251212-kconfig-reorg-v1-2-72441d8cc53c@cherry.de>
 <d46a7a85-7077-4b3e-84a2-2ce607412402@ti.com>
Message-ID: <4EB14294-9C3B-4BE2-9E8E-995072DEA818@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5qrJSXvi8qrDSiJzz0ecrALC8qTN8sQ4FO+sB0yHapvvCawZi48
 4l3m3ByvONTdn6NqmmPTOmzyBnYdQoNYHd7EtMcyPzJHQ/+I8PWBKQtXT3p9liMLpdd1FQR
 J4CvkarA5HfZdwWKMd5MhHJ8ywoRi6I6xJTmYQx60ggViHx6tDXswdH4z3sgeysM3kLpKCV
 OkXTa13mUqTKUX9QBZkDA==
UI-OutboundReport: notjunk:1;M01:P0:vADXe0hDERw=;4DYK6C9Xi1bTnfBRse4nCsgRqCy
 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
 gPgcZb3o=
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

Am 13=2E Dezember 2025 08:05:36 MEZ schrieb "Kumar, Udit" <u-kumar1@ti=2Eco=
m>:
>
>On 12/12/2025 11:43 PM, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin=2Eschulz@cherry=2Ede>
>>=20
>> The prompt is missing the indication this applies for the SPL loading
>> a FIT image, and not any other stage=2E
>>=20
>> Signed-off-by: Quentin Schulz <quentin=2Eschulz@cherry=2Ede>
>> ---
>>   boot/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/boot/Kconfig b/boot/Kconfig
>> index 85f4d468069=2E=2E07ae6cc585a 100644
>> --- a/boot/Kconfig
>> +++ b/boot/Kconfig
>> @@ -272,7 +272,7 @@ config SPL_LOAD_FIT
>>   	     "linux" images are also supported with Falcon boot mode=2E
>>     config SPL_LOAD_FIT_ADDRESS
>> -	hex "load address of fit image"
>> +	hex "load address of fit image in SPL"
>
>SPL_LOAD_FIT_ADDRESS, itself indicate that this is for SPL, no ?

But that is not displayed by default=2E

Reviewed-by: <xypron=2Eglpk@gmx=2Ede>


>
>>   	depends on SPL_LOAD_FIT
>>   	default 0x44000000 if ARCH_IMX8M
>>   	default 0x0
>>=20

