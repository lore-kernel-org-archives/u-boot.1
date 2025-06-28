Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0884C7EE32
	for <u-boot@archiver.kernel.org>; Sat, 28 Jun 2025 08:31:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BAE882977;
	Sat, 28 Jun 2025 10:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="AdV2gic6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E46F781D5D; Sat, 28 Jun 2025 10:31:24 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8D87806D8
 for <u-boot@lists.denx.de>; Sat, 28 Jun 2025 10:31:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1751099477; x=1751704277; i=xypron.glpk@gmx.de;
 bh=hheG5tzB9UN0JqsA+qotmw+Q6DHZCBtWblVj+9IrIJM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=AdV2gic6ARGvs5fOlIjvqajwNf3T4XTquQkKsWW1nEVn1/8P1Y7Zx6PYvfaEXHUk
 h16+G6N5xsKGLaO4Iwpw0h3AFETiOibhSS97oGAdZTHpli06Aw3mEK3rFpOXKva1I
 KXylaS+YlFTjKWM6n3Y1bua561IbyI1xzjUWkeM0jrORfpmgXnbWcu2ZkEpPj7btS
 UTt96wf+NLDB/f7jJAtSg3q1PUIin7WBUFNyGhDprilNpC33IvG8K+7EG7xDnLDh3
 fD1j/EXFUw6eQbrqD2NhnyR0SjB2P2l7s37h/jHS8uj3BIo7TFbT5a8leQtJpAdtI
 Yy4y9Y6i3ZHMTq2cfw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsUv-1uVgt81QzP-00EmHQ; Sat, 28
 Jun 2025 10:31:17 +0200
Message-ID: <4e59e5e4-9b65-4f26-a0fa-3f65e122a12a@gmx.de>
Date: Sat, 28 Jun 2025 10:31:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: efi_loader: Sporadic build failure: Error: file not found:
 <path>/capsule_esl_file
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: "Anthony Pighin (Nokia)" <anthony.pighin@nokia.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>
References: <BN0PR08MB6951841AE35F95A242553D91837BA@BN0PR08MB6951.namprd08.prod.outlook.com>
 <012ee7c9-6794-485e-8e0a-5ed0ff23c045@gmx.de>
Content-Language: en-US
In-Reply-To: <012ee7c9-6794-485e-8e0a-5ed0ff23c045@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Af2N72cmT2F0kS6N3/qsE3wyTHspB/mDQ9KopSWG45RqO0IMyUa
 uC6yU1Bd7r9MPy+S29GIC32K0hQwlVZa7Et8Sxkr5XG+d3saRJPy44FTYJXqRFvv8DBOJ06
 8nC1/7LGSai4Bn8oil2vbY7HnemD0dFXbqrXW2qNXKGtNPp7/ItsQ5mhQoT5mDdPWg2bwf1
 K8J3OMmO/uNGvGcowstOw==
UI-OutboundReport: notjunk:1;M01:P0:3iSPy88tXYA=;aCefLuO/IvBTYrT0Ewsoc4FIKlA
 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
 fabQa4KTQu8bryWPM+p5rW8=
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

On 25.06.25 16:18, Heinrich Schuchardt wrote:
> On 25.06.25 15:32, Anthony Pighin (Nokia) wrote:
>> Following the introduction of commit=20
>> fd58c275f6ba524101ba0990e53f5a11ac390bd0,
>> we have seen sporadic build failures with the following footprint:
>>
>> <path>/u-boot/2025.04/git/lib/efi_loader/efi_capsule_key.S:14:
>> Error: file not found: <path>/u-boot/2025.04/git/capsule_esl_file
>>
>> Upstream commit 739ad58dbee874a3ad3bddd116e995212a254e07 also touched=
=20
>> this area,
>> and we pulled it back into our build as a test. However, it still=20
>> appears there is a missing
>> dependency:
>>
>> --- a/lib/efi_loader/Makefile
>> +++ b/lib/efi_loader/Makefile
>> @@ -87,7 +87,7 @@ $(objtree)/capsule_esl_file: FORCE
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(call cmd,capsule_esl=
_gen)
>>
>> -$(obj)/efi_capsule.o: $(objtree)/capsule_esl_file FORCE
>> +$(obj)/efi_capsule.o $(obj)/efi_capsule_key.o: $(srctree)/=20

You should not remove the color (':').

Best regards

Heinrich

>> capsule_esl_file FORCE
>> =C2=A0 asflags-y +=3D -DCAPSULE_ESL_PATH=3D\"$(objtree)/capsule_esl_fil=
e\"
>> =C2=A0 endif
>>
>> Anthony
>=20
> Hello Anthony,
>=20
> Could you, please, provide logs showing the error and the matching=20
> defconfig.
>=20
> Best regards
>=20
> Heinrich

