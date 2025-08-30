Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAB4CA0FFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 15:22:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF3228380E;
	Sat, 30 Aug 2025 17:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="sF0AUsYc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A8C983858; Sat, 30 Aug 2025 17:22:52 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 400EF836B2
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 17:22:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1756567369; x=1757172169; i=xypron.glpk@gmx.de;
 bh=BrSOxEMqkEK8Thcfc/bBNdGtGK6l821O8GX2HQXRSkM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=sF0AUsYcg+JMzVVrTt/2AR1qYVhQ6i2X7iLxYfrnpyyqEslM7xBRJUqaWYn5GMgM
 AxcvRnUngApdfLsJMYQ3E9kLuhnyBbl2fuRCuOmPP/1PLoU8J9Q9+BgVLizAu8/a7
 3lYpM8bcYvnvLEqtbmHdE2m+apNZ16jjrvNnFmzeC3NsfyNA9FFBiwesvcCdN2T4Z
 n/Xp+kQkFLNrL6RNK19uvojMrANHfhqIJS8KW32qTJSESI9daN5XPZ5VvhxHIwO2E
 XwBLMtLUw7XA6rm0e/WHq85797e1gGQ+nIUt3ZgmCPO30sXwkOddsPOfsyg7h9Kws
 2oGxShuXt2vLTSh3rQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Ycr-1utkzT494F-0028R6; Sat, 30
 Aug 2025 17:22:49 +0200
Message-ID: <4605b3ff-6499-4233-be0c-bd3a0898b1c9@gmx.de>
Date: Sat, 30 Aug 2025 17:22:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] doc: Use a em-dash instead
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20250825223251.674591-2-adrianocarvalho.pt@gmail.com>
 <20250825223251.674591-11-adrianocarvalho.pt@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250825223251.674591-11-adrianocarvalho.pt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9L4eG07FzR/urmsap4cuzKPGio99AGoJsMnu2ssKfLZ5dSKTk5v
 yHljRI2YvemM7VRHptDYDeklthzsowYQdFRs5/5ZQH4p30EmazP/iuonhZGDzhNUpQHN1Iv
 M+Mmtji5bO4Lb7SshPRPcUriy6lBmICmqOANG83cg28oPzmTY7o5qkHeqMUcpFBxhOumrRu
 Lqyd4K92rMy1mNyKubxfw==
UI-OutboundReport: notjunk:1;M01:P0:NzhfS8XQwm0=;tTnsqAfWQKE/IjybheX2icAS3LZ
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

On 8/26/25 00:32, Adriano Carvalho wrote:
> In the browser, a single dash looks sloppy.
>=20
> Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
> ---
>   tools/buildman/buildman.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
> index dee95847175..f6112c7f88c 100644
> --- a/tools/buildman/buildman.rst
> +++ b/tools/buildman/buildman.rst
> @@ -1373,7 +1373,7 @@ Using boards.cfg
>   This file is no-longer needed by Buildman but it is still generated in=
 the
>   working directory. This helps avoid a delay on every build, since scan=
ning all
>   the Kconfig files takes a few seconds. Use the ``-R <filename>`` flag =
to force
> -regeneration of the file - in that case Buildman exits after writing th=
e file
> +regeneration of the file =E2=80=94 in that case Buildman exits after wr=
iting the file
>   with exit code 2 if there was an error in the maintainer files. To use=
 the
>   default filename, use a hyphen, i.e. `-R -`.
>  =20


This file is also used as output of buildman -H on the command line.
Unicode does not work if the console is using an 8-bit codepage.

With the patch an error in the CI occurs:
testtools.testresult.real._StringException: AssertionError: 67348 !=3D 673=
50

For details see:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/jobs/1234573

Dropping the patch.

Best regards

Heinrich
