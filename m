Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADB1E668BC
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 19:51:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FB3689584;
	Sun, 24 Nov 2024 20:51:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="tbbqBStA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 819FC89589; Sun, 24 Nov 2024 20:51:24 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D5EB89582
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 20:51:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732477875; x=1733082675; i=xypron.glpk@gmx.de;
 bh=A9rhejlh0seUErIxqTXHT1H1fpVPPQommuWV6R5xLYY=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=tbbqBStA00yn0ARavUsOGR65NB6iG3UJivw7AsoeryNi0Rx+TLxj7mTgUhWV6ttB
 Zbu464mmdb+esOcourx/MLZ54xmk3Gn1NAnnt4gI2B1GkwsP7DqLJCK4PGzKaHFNM
 8sZRqdi8b5mtTGcJbpVdI76rwr81vI2ueT3nE0BPeo9ivb82ixW9NIJr1E8yrq7JB
 qkFydJjaKiFV3iXVJkycdnrOY6Zfua6aj/vPYCLcp11hGNSQeonVLcnmeqsNC1DoG
 rwsny3fT2i+yy6awJtyKUHU7YSSkCrcqmlUzrQ4w4atbj9fPkhK20QKrxSw2FErV7
 qTipILEdj8QW/whXMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgesG-1tw5ZX0Qc0-00gFMb; Sun, 24
 Nov 2024 20:51:15 +0100
Date: Sun, 24 Nov 2024 20:51:13 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Matthew Garrett <mjg59@srcf.ucam.org>
CC: Matthew Garrett <mgarrett@aurora.tech>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 =?ISO-8859-1?Q?Vincent_Stehl=E9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 01/10] Add EFI handover support to bootm
User-Agent: Thunderbird for Android
In-Reply-To: <Z0N+kmEb9eYr8oBZ@srcf.ucam.org>
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-2-mjg59@srcf.ucam.org>
 <e1592ca0-03aa-4f83-848a-70c8979a9b2a@gmx.de>
 <Z0N+kmEb9eYr8oBZ@srcf.ucam.org>
Message-ID: <1BE9D668-50C2-4042-A144-3ADCFA9ED0DC@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HMNWdsD4aYO5+GwYvu6xCkIMRyZyP/UyH8EzhfRgRigVzladAQa
 ISyFzUB0B5QFrdd/oVmiOIFwzi3r55xRu7i1SfImoqB93tQ+6Q7Mpxk2Fuc86NBNg8GXP8O
 bGwNbqIK1mYu8SxfD48jchshTfleTnNAE0vI5siFvPd0KfLvN/RxU3RGUxX9qz58/VLMZDb
 C/2+iHWfG3q0uoEJHuYyA==
UI-OutboundReport: notjunk:1;M01:P0:8y3aHfJaW74=;ijrKrR8UyyeePhl8sudDt2JfHcE
 LjMjxLgM9yGLjrSNjk7ke+dQf3fHvTHSJ4VeEsiQLvFcNhvmETZ6BzJcCx342/CtZyZvYunDq
 VkLIQUBXRUSKjhAeZziDINrLcFqE/gGIG9oGxrmRdSnpXgIQA15IwV3xgZ7DeNEk84sTr5mkF
 GKTT+Fe+X9e3XMRW8qsTLw/76gU5FffxzXCjx4z3vMkkZ5s7J6FX6KxkhkKiHxXbL2A/PLdes
 XLyxCKs76XqXEyDNqeLE0EYhK3/4tplk/Q4/tY97oFDKCptuZhxRx9sU8h5TzqRXFhLCuCf07
 sBRmtd/GdoLtXYGVOidZUuNjc0fY6hKwdQyllT/Kg5x8858b0L3TzC+1l5fLnsLmmvVY8Egxr
 leJ+VzgoC9CQm13unAndZWV0s8D4opFy/ZIj+2He7bmlg0xonvlGrkSHWi/8n2o5Q6bW9waOM
 bbyow0V+5Bkq5Y9fjPVKSGmsSRshtNt1TS3o90OW2PAkh9rivfII3+I/5oFft/Smb0PqblF4A
 cz7vhHx1FRAMtEI3Hbl2qSM9czxuAufLsy/LmEIdF2opqgDil1PFnC+osMgPE2dDkeLmKAtCq
 fsSEBjRUZxMiIClNxcuqBOVkSAqe2J/UjZKwh06QyEl37J8rwWV9c2QTP4dvL36haPWO3Tdsf
 OH8TCaNIVS6sV51s4i/TRdIMZYxZ+GsmjIqQDgSpmhvUHF+imjmWB7uhRpx4jK9bURywQQP6/
 t4NGGQ/9pmQpsPgprFcsm3DRCyeIqXdsCYq1nKVKGu3/YuzGpBx55Z566lvSsMCvOPW+bpd0M
 Q9QzIQUJxwT68tchoCWYshTtewN7idBLeBLrgasXmi1EEf3eSYmIx8jE/98nlIuUgTDH8n1St
 f+oTodHdoDDEF3w8RrvccBjreR0fpGZT9E6JjV8EdjfkFAiX5NduwAFsR5GaQOc3j/dPkqp9M
 jxIpXY2AOL4YwToOEnNCcos4ah9RyLjpsmrRvESRAdGb7dbIhvTRJnO7He1JE1KOrYJJfXRI0
 Qx8wYKCa5Jwm4llx2J/B6pSahkgMD3ZaCxeD26B6dKcM2+wJKUXDPjQXf4iB/fEpGYzIVfMiC
 rJ2DIUphZzu0W/aZk1iDtzzdTtc1N9
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

Am 24=2E November 2024 20:29:22 MEZ schrieb Matthew Garrett <mjg59@srcf=2Eu=
cam=2Eorg>:
>On Sun, Nov 24, 2024 at 03:43:12PM +0100, Heinrich Schuchardt wrote:
>> > +	/* That failed, so try allocating anywhere there's enough room */
>> > +	status =3D boot->allocate_pages(EFI_ALLOCATE_ANY_PAGES, EFI_LOADER_=
DATA, pages, &addr);
>> > +	if (status =3D=3D EFI_SUCCESS) {
>> > +		/* Make sure bootm knows where we loaded the image */
>> > +		os->load =3D addr;
>> > +		return;
>> > +	}
>>=20
>> Why don't you simply call LoadImage()?
>
>With secure boot that requires that the kernel image have a trusted=20
>signature, whereas we're relying on a signed FIT=2E


Please, provide an answer describing your problem and why LoadImage() impl=
emented in U-Boot's efi_load_image() won't work=2E

Best regards

Heinrich

