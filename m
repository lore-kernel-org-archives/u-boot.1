Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D1EC87FCE
	for <u-boot@archiver.kernel.org>; Sun, 27 Jul 2025 20:56:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80D4F83013;
	Sun, 27 Jul 2025 22:56:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="BdKg3WeV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3122983015; Sun, 27 Jul 2025 22:56:29 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF92A8300B
 for <u-boot@lists.denx.de>; Sun, 27 Jul 2025 22:56:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1753649783; x=1754254583; i=xypron.glpk@gmx.de;
 bh=lAz7mm4Q6Cc2SnoYZqwAZRo0cDa5R/zs+bi4sviLJMQ=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=BdKg3WeVsqv1HzEQp1Ychk8ZgEtsTtX9WL1Fr6zKAQL5umn1LdErTcW4Zx3E1byJ
 lWL2mIOJTbAlr5F8ymJZXi5azICvT5lul4oPEYQUSlcHj4+Ovq7xZt55i4K1nWK9I
 uUZystxWgjW2zew8QkyHDiPGuM2TWi53rOhEu3mJnWmWZ2jJgUDNmowwmNF5J6wF3
 nNWe4RDCHcFfdu3p5dea9KD3af2epWTrqN+O+85FihjmOtF9oPU8wgdr38b4WsIq6
 Ws7WgxtMmV0lKSLg20w7skokGkXj5wnap7TMprLMhfSsoQ9sz9ldvQxZ9Hj+xk7We
 fzpNa77omtzYd4KhMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M59C8-1uf2UE3wHM-005ydK; Sun, 27
 Jul 2025 22:56:23 +0200
Date: Sun, 27 Jul 2025 22:56:22 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Mark Kettenis <mark.kettenis@xs4all.nl>, Tom Rini <trini@konsulko.com>
CC: javier.tia@linaro.org, u-boot@lists.denx.de, ilias.apalodimas@linaro.org
Subject: Re: [PATCH] efi_loader: Add support for .wic files in URI boot path
User-Agent: Thunderbird for Android
In-Reply-To: <87freiap8h.fsf@bloch.sibelius.xs4all.nl>
References: <20250725173534.247188-1-javier.tia@linaro.org>
 <46A97A81-B04A-4BCC-A5EF-2639593DD86F@gmx.de>
 <20250726154516.GG1807455@bill-the-cat>
 <87freiap8h.fsf@bloch.sibelius.xs4all.nl>
Message-ID: <0B60AF11-067F-4969-BECE-EE8A5847EFB6@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4OEdorb7D4qqBDzgbtpXFZdXBPnmj5FlyyrO79h6sZFquGb5XQa
 Tqx0BmGcbY6rdxoa3fV5jsmPxn0gWQjUzmYv86AsYW/Me+HqX5+spP5iSMeiZ60usGIj+U9
 cX4cNPf7SkwJBeMmXh1Z7PZ+wEQOc/xfu1aqPG04EpRL59+7MordcM/v01QFdmkldR8zBVo
 11EHDRQsEnZrAflZo2EIw==
UI-OutboundReport: notjunk:1;M01:P0:WUyMn7bwMXI=;zbHvQKRCd4vHtj2xQhxDr570zLI
 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
 4oKmv/yG5C0aUX7K4/j+9HBHiynVcGac=
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

Am 26=2E Juli 2025 18:30:54 MESZ schrieb Mark Kettenis <mark=2Ekettenis@xs4=
all=2Enl>:
>> Date: Sat, 26 Jul 2025 09:45:16 -0600
>> From: Tom Rini <trini@konsulko=2Ecom>
>>=20
>> On Fri, Jul 25, 2025 at 07:56:39PM +0200, Heinrich Schuchardt wrote:
>> > Am 25=2E Juli 2025 19:35:33 MESZ schrieb Javier Tia <javier=2Etia@lin=
aro=2Eorg>:
>> > >Together with current '=2Eiso' and '=2Eimg', the try_load_from_uri_p=
ath
>> > >function now allows files with the '=2Ewic' extension as viable boot=
able
>> > >images=2E
>> >=20
>> > Why wouldn't you simply name your files *=2Eimg?
>>=20
>> The answer has been lost to time at this point, since output has been
>> "=2Ewic" for over a decade now=2E

First match in Google:

A WIC file is a raster image saved in the Java Wavelet Image Codec (JWIC) =
format=2E

<https://en=2Em=2Ewikipedia=2Eorg/wiki/List_of_file_formats> does not list=
 =2Ewic at all=2E

It seems that =2Ewic is not a usual ending for raw disk images while =2Eim=
g is well known=2E

Best regards

Heinrich

>
>Note that other EFI implementations don't support '=2Ewic' either=2E
>WHich is why we switched the OpenBSD installer disk images from '=2Efs'
>to '=2Eimg' some years ago specifically to support EFI HTTP boot=2E
>
>> > Shouldn't we get away from the DOS age routine of relying on
>> > filename extensions?
>> >=20
>> > Just check if the fileheader is a PE header or if it is a known
>> > partitoning scheme=2E
>>=20
>> Looking in to a cleaner more general solution is worthwhile, I agree=2E
>>=20
>> --=20
>> Tom
>>=20
>> [2:application/pgp-signature Show Save:signature=2Easc (228B)]
>>=20

