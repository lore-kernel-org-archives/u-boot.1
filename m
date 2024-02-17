Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73252C48BC4
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 20:21:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB63D8785A;
	Sat, 17 Feb 2024 21:21:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.net header.i=wahrenst@gmx.net header.b="tD4PW1/S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EC7C87E79; Sat, 17 Feb 2024 21:21:36 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E998F87811
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 21:21:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wahrenst@gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1708201284; x=1708806084; i=wahrenst@gmx.net;
 bh=rED0s7pJ6SlNRKx9wExE4SjxqDviV5YMv6gdXNy6ewk=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=tD4PW1/SFSB0pDU5Khr+J/77FAVs1UJCg+H6QXhqrtXbmJ0fZm1wSlIuUlPLSxgk
 kCcMh3/vqn4/fqx/ZxoFrxLzWzKKOCF5R8S2AG6Mv42g+9FIiKpuByrn2WU3lhj1n
 aK/J/85/pD9xWBWQQF2YgYz9H3D08w6d75alvDYGKapBDsEXo2ndi54lxi7XX82TS
 WgiFY65hXD0ZmX2+mvhZXlPCkwqsAHwze1iypL1z0IdcyH8Egarcbyo5SQmoSsU80
 hSFQJ9W7lUhY9YBeeTCZXm4szKA6+p8je3JlGxV6Ku2dE7IaqJRc+Y4stJnviDYgZ
 dhQ1sFZe2ia0QHPC8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8GQs-1qpGSa3K76-014DqK; Sat, 17
 Feb 2024 21:21:24 +0100
Message-ID: <ade7bba7-bd59-4fd0-af85-c882b552c836@gmx.net>
Date: Sat, 17 Feb 2024 21:21:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Booting RPi5B with latest git
Content-Language: en-US
To: John <therealgraysky@proton.me>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <VhjYVKfXb22i7OLAE71TUsea5YoQHzRZl2a-pTntu6mAGWiAuixDG1380ukg9ag-1j7_JZUXh8mLYxId4j3mmvjopigOO6NgqVF0aBxC8Io=@proton.me>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <VhjYVKfXb22i7OLAE71TUsea5YoQHzRZl2a-pTntu6mAGWiAuixDG1380ukg9ag-1j7_JZUXh8mLYxId4j3mmvjopigOO6NgqVF0aBxC8Io=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xxsI0jHMjP2fcRC+G2f8F5F5Ag0cB2juk1SSt0JOEbXPDydX3tU
 5UotMSP4HltLqXAYacqCvRjIyrClmioSeQEY6qD0gTMNqVxw/2PTJmyx6heK6bb75KoWENe
 6autABwP2gCITP03IwDW251dDkqZuV2r40awoH5ZBW4Lfg7GyYmV7GVs5bGlKRuQNJpmWaE
 RTprcS340hfx3Qv6a9Y9w==
UI-OutboundReport: notjunk:1;M01:P0:55pVfo9dfCA=;zDalEbiUzmOWw0SmFmJVZkOqXsG
 lXM3oWyxFM3cRVwV9Rt/7pnXU1XcrsChcMLYx8d7y6mHY7JlmL5wMgjqC6e5rnB6Cp1iwCIP9
 xw94jW/ROVBiVis6apV6B2Z+/GIH6EqSgtgiF6IZVZdz5oCg15BI14YKSJ4diWo8uY28oJEib
 TQdFPIKCzakIu0pOFQMzDTP4mJwbacVlnCsmo6q5cMuTmS2bJe/RnCaQIM0eKOhygvza+BNG7
 koJe0Xf0K603qUBENSCllDoMjN1IGx2dVowWVt18MlSQlSVbf5JTfLzfbafpuC0DX4VXtnpcc
 YsRwcY0W2XX4GQLWTqQHfk7G9rWifurXJilb0hV5RDEWLG4izQA3UH2FpWKciO3SA/rOEULcx
 g+Bg0KkcvMncID4nYbuHc40zruWwFQEp/be7whtaEc0n1XpZ8krSs19Tqdbz17PqG/kzbOfwn
 728hSCVZ4bo+qpB7a1HNyaUOMMBy1r8+vDuRlwy1Y5SYAUw1pLNaw++7bhsFb3q7Coq4ePAGn
 so5ROik2VKM5ibO2qVVoJKJrbs/byAD094A75x77GdaaiwBDoZxgYC81vi2V43GHzGZoDJVTM
 UpazkAM7l3srJcuCFNx5iOt+Z/4lHWpPbBaxruMJO0i5NVeRLxSGTGEjzBGslQM479MVRbSiz
 nLH9O2BYbVGRYXBXsEYdkLmzWmsQNhpqMkHKufeUvlz/g3iwCU2tFoMoXMOjzaxLdPHEIzZ9Q
 JvJhw/UQR5veJG4Ie3FuxAFzTYdx7miqOd51jsklz45K8SDaGFVTViAdG3b+69oTH5vnepzDO
 +QHdHlyWufYyBlxtrPhp32GaYVwfYKdjug16LFANwqmVc=
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

Hi John,

Am 17.02.24 um 17:33 schrieb John:
> I am running Arch ARM on a RPi4B and also on a RPi5B. My RPi4B can boot =
the vanilla kernel package (linux-aarch64) with the latest uboot-raspberry=
pi (2024.04-rc2) just fine.
btw the mainline kernel doesn't have any RPi 5 support yet. So you will
need the vendor kernel.

Best regards

