Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F39D1CDC6
	for <u-boot@archiver.kernel.org>; Sun,  7 Dec 2025 09:06:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F1C3839C6;
	Sun,  7 Dec 2025 10:06:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="rZL1vIH7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0096C839DF; Sun,  7 Dec 2025 10:06:14 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11776839AC
 for <u-boot@lists.denx.de>; Sun,  7 Dec 2025 10:06:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1765098371; x=1765703171; i=xypron.glpk@gmx.de;
 bh=k9S/NdTlODLPMByHVz9/hlmwJJIbvEw12V3ogzTHb2c=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 References:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=rZL1vIH7okSnDKp6Jae8NWI26bznmlTUHwH4XuR4106NpvDOX0mMME5iiK6RPHeQ
 zwrYrCs48XIyHpRPITj72mXrtEdTSP4quooX4dqJVPgEsi5xnFLfazBZSbm4Ysc/U
 veodskrXmbP/Th84QtL74ofnSlaLKGGeCzBUs6QHgRjwN0WkKwSEO4iEw0/cm6VYY
 iW4oLYYjIdvF5IEHaBn4iJFFVANL9SJO/MM+H/GAlVnbSlSgn8lXW6wvgDYzOg2dI
 FZZuoSBPW34mgOVuronfLMlwM587R03zjcszGYZ9y2xzqzPinlDzGb09lh+wq1m+R
 WCAkutuFj9iESha65Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.124] ([46.114.3.139]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRmjw-1vdh4D2JwY-00JJDz; Sun, 07
 Dec 2025 10:06:11 +0100
Message-ID: <6879b570-57d0-4dd3-8c6a-29f15e830fe1@gmx.de>
Date: Sun, 7 Dec 2025 10:06:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: Update urllib3 version for building
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>
References: <20251206165034.2621363-1-trini@konsulko.com>
 <0DC1498F-9066-41E1-9B9D-CE45CC9F4849@gmx.de>
Content-Language: en-US
Cc: u-boot@lists.denx.de
In-Reply-To: <0DC1498F-9066-41E1-9B9D-CE45CC9F4849@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sRqbZGfENVZHREBmC8ilQMSk/v2QJENJHYhb0gcfggZGW8brkHr
 qBv714zZ4SLG8IiQQ/vVYaOBJ6Re0M0/Er37+kpJlGIwWVq1bRBDeMWIAk9bbPwFSUcoaOi
 0iW9wUfXcGOGhNoxdbfjaPY/6co96cvXJG2StX3jailI1DuTZG+rIXzQPVo0V0mOnyaw2sr
 jnrmv4qSnWK5GeTs/sg2w==
UI-OutboundReport: notjunk:1;M01:P0:DFdV52+6GYc=;G7sqfRrbm8jwgT3mPMkzS6TaVEM
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

On 12/7/25 08:17, Heinrich Schuchardt wrote:
> Am 6. Dezember 2025 17:50:34 MEZ schrieb Tom Rini <trini@konsulko.com>:
>> The GitHub dependabot tool has reported two "high" priority bugs with
>> this package. Update to the patched version.
>>
>> Reported-by: GitHub dependabot
>> Signed-off-by: Tom Rini <trini@konsulko.com>
>> ---
>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> ---
>> doc/sphinx/requirements.txt | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/doc/sphinx/requirements.txt b/doc/sphinx/requirements.txt
>> index 8572c15ef68f..dd433e2bb156 100644
>> --- a/doc/sphinx/requirements.txt
>> +++ b/doc/sphinx/requirements.txt
>> @@ -24,4 +24,4 @@ sphinxcontrib-jquery=3D=3D4.1
>> sphinxcontrib-jsmath=3D=3D1.0.1
>> sphinxcontrib-qthelp=3D=3D2.0.0
>> sphinxcontrib-serializinghtml=3D=3D2.0.0
>> -urllib3=3D=3D2.5.0
>> +urllib3=3D=3D2.6.0
>=20
> Please, add a reference to CVE-2025-66418 to the commit message before a=
pplying.

The other CVE is CVE-2025-66471. Both CVEs are related to excessive=20
resource consumption caused by downloading from malicious URLs.

>=20
> Acked-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>=20

