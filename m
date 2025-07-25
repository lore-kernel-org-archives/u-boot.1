Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3202C87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 14:20:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54CB0839AD;
	Fri, 25 Jul 2025 16:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="PqrLtT97";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7D21839AF; Fri, 25 Jul 2025 16:20:24 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A13E0839A1
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 16:20:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1753453216; x=1754058016; i=xypron.glpk@gmx.de;
 bh=R/HwtDd/7i/6G9NXKhlVVfsuSPeZPnx+KPLbrIphKQE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=PqrLtT97lWiCd/8a2uhtJlUs/IQEADt2vw/5bIz6Wl1kZi6zmU7/B64P14Effj4X
 tKWcbIPxymdyQBwdnkrZNP9RISYm36Jqb467aXdTdkaYFF/TVmwqwRGBJ26dfCR03
 hCpJMlLHYxeH333fFRiYkw5Ki6EfuZ31mCJ9jtorGUOfrfWfUmvaU12xFKnAQ0c+2
 JH9kJ8+wkrkIAVWftncjopt7J+MMXYA2RjnodbKl78JjYNfnzsxpsCC1f+hkbX7Z0
 R/K/wp9B4x5pwXB9GdNL5yzEaruZdrW8QC/kW9sO/3//GAvFP43kjq6D8ERkxg7Fd
 lRjOnrEFQbHdWCM8yA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1ML9yc-1uwQSY19Xe-00QGl1; Fri, 25
 Jul 2025 16:20:16 +0200
Message-ID: <1b8c2fcf-5ca2-4e76-96dd-35a8e37f9b4a@gmx.de>
Date: Fri, 25 Jul 2025 16:20:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] capsule_update: fix partition match to exclude
 uefisecapps
To: Casey Connolly <casey.connolly@linaro.org>
References: <20250724090009.569341-1-balaji.selvanathan@oss.qualcomm.com>
 <20250724090009.569341-3-balaji.selvanathan@oss.qualcomm.com>
 <786a2fca-d137-45ff-91d4-6f9e8cf95f75@linaro.org>
Content-Language: en-US
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 ilias.apalodimas@linaro.org, adrianox@gmail.com, moritzf@google.com,
 sjg@chromium.org, maks.mishinfz@gmail.com, javierm@redhat.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <786a2fca-d137-45ff-91d4-6f9e8cf95f75@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JYXKILOOLrasBaCtVB+By3bz8CqdFsPfivVOSpdZBgnIJwNu8x9
 xpGqSX/KL88TQky0aQiJ23oHjhJpW1599uqLwsES+MmPybYu0jl3XfnJByOiVh4bRwNEQhz
 cLBL8DgFXlpD6Be+i5AdSymCXkRW67Iqb5mCmTQBaTHQX5R74PMdqO7/CsWWOuJyqzgGA1R
 oeIQ9rHZB4fVle10iv3HQ==
UI-OutboundReport: notjunk:1;M01:P0:8uxPVXGWkSY=;snRoY9whEGNVIDTLx6OGt9rcuzf
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

On 25.07.25 15:11, Casey Connolly wrote:
> Hi Balaji,
>=20
> On 24/07/2025 11:00, Balaji Selvanathan wrote:
>> - Update partition name match to use "uefi_" instead of "uefi".
>> - Prevents incorrect matches with partitions like uefisecapps_a/b.
>> - Ensures only uefi_a and uefi_b partitions are considered valid.
>> - Fixes capsule update logic when identifying target partitions.
>> - Avoids flashing to unintended secure apps partitions.
>=20
> Please rewrite this in sentences rather than bullet points, this should
> only take a sentence or two to explain.
>=20
> Kind regards,

The patch does not describe why the change is needed.

Wouldn't the suggested patch break existing systems using uefia and=20
uefib as partition names?

What is wrong about calling the A- and B-partition uefia and uefib=20
respectively? Looking at the code it seems only important that the=20
suffix is different. The suffix value seems to be ignored.

Reading the documentation I would not know if uefi_ALPHA and uefi_BRAVO=20
are valid partition names for the A- and B-slots. I would have expected=20
a matching documentation change in doc/boards/qualcomm describing the=20
precise restrictions on naming the A- and B-partitions.

Best regards

Heinrich

>=20
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>>   arch/arm/mach-snapdragon/capsule_update.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-snapdragon/capsule_update.c b/arch/arm/mach-=
snapdragon/capsule_update.c
>> index 4dced4961b6..11ef4a0f4b9 100644
>> --- a/arch/arm/mach-snapdragon/capsule_update.c
>> +++ b/arch/arm/mach-snapdragon/capsule_update.c
>> @@ -136,7 +136,7 @@ static int find_target_partition(int *devnum, enum =
uclass_id *uclass,
>>   			 * flags might not be set so we assume the A partition unless the =
B
>>   			 * partition is active.
>>   			 */
>> -			if (!strncmp(info.name, "uefi", strlen("uefi"))) {
>> +			if (!strncmp(info.name, "uefi_", strlen("uefi_"))) {
>>   				/*
>>   				 * If U-Boot was chainloaded somehow we can't be flashed to
>>   				 * the uefi partition

