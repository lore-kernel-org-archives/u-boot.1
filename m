Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E76C87FCE
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 12:23:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28BF38393E;
	Fri, 25 Jul 2025 14:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="RKeb/FD9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D065283956; Fri, 25 Jul 2025 14:23:03 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB5838391C
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 14:23:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1753446181; x=1754050981; i=xypron.glpk@gmx.de;
 bh=wZFc8TYfenv9lwJwUxaC6NPIG8XEOR4CHZvG8KecPyk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=RKeb/FD9q9lvx3jMWpItZrlXCIYAZAl4jPkpTzjg2zaTAqqjpSWMtGiQZ8R2N2ow
 djgj7ORqBGvpaihWg4TnL8xIfpUqSvBb80BtA3AP53ex6c8bezU96xm/j/VwEAVvk
 YqYe5BkFzUAK9f7T96ZRgAnMH4E+Adpuz5xxPUMjC2sJ9eC3nSQ/57NHLYmBTjSAR
 ubn5MQ6cm6u12UJE25MbiGAwLubzUeqta49bQtIC2D6QLbsCzoY/XARYKZb07SSkx
 apXV2xL5Gp052NTrqb2QPTbD0e4msMa0k2RJxTlEqjL/XiNSq7FVS6ioaf8MOwqU6
 bR5r8nhS21dgoUi0/Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mz9Z5-1uRJ0Y0mw7-00rSvR; Fri, 25
 Jul 2025 14:23:01 +0200
Message-ID: <48b253d1-1ae0-4fa8-910d-b6ade557a5a7@gmx.de>
Date: Fri, 25 Jul 2025 14:22:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Smatch report for drivers/fpga/socfpga_gen5.c
To: Andrew Goodbody <andrew.goodbody@linaro.org>
References: <31ac4742-d516-4b5e-8f7d-6f8d23b77119@linaro.org>
Content-Language: en-US
Cc: "Simek, Michal" <michal.simek@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <31ac4742-d516-4b5e-8f7d-6f8d23b77119@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6XhMUKNAFkYujyIW+MM3Byo/1zEY7TUNf1egZT9XN3Fe077ms4A
 9s50ImFl70b6IyhevJLnnZYjWpty9PmDSpTKn8VJU6CLF/fkqQLwcxOsureSNDOVHFMN0T8
 ZaZM8Sr/S5xwlpV2C9RUk6+djP/qqKlmdbvrzS7j6PRx6rZA7zsyoSdNpuRMQEpSkpgCQc8
 Y6OasYoHTlAKfMGvSjE4Q==
UI-OutboundReport: notjunk:1;M01:P0:vV3on/cvgec=;DvV6RyVHtfJItP4x9mTNalJUtPx
 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
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

On 25.07.25 13:09, Andrew Goodbody wrote:
> Smatch reports this issue
>=20
> drivers/fpga/socfpga_gen5.c:135 fpgamgr_program_poll_cd() warn:=20
> duplicate check 'reg & mask' (previous on line 129)
>=20
> Looking at the code I am not sure that it will work as intended. There=
=20
> are two if statements within the for loop that test for opposite=20
> conditions so could easily be combined into if..else with a single test.=
=20
> But also both if statements result in the for loop being exited, and one=
=20
> of them must be satisfied so the for loop can only ever be executed=20
> once. This surely must not be the intention. It is not clear to me=20
> whether the error test is wrong and should be changed to a different=20
> test or it should simply be removed. Could you take a look please?
>=20
> Thanks,
> Andrew

As we have been running with a single iteration since 2017, probably the=
=20
for loop and the if statement relating to FPGA_TIMEOUT_CNT should be=20
removed.

Best regards

Heinrich
