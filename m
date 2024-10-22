Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CE4D1CDA0
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 06:03:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 378B088D9C;
	Tue, 22 Oct 2024 08:03:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="gjnVUYzA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A070F88E02; Tue, 22 Oct 2024 08:02:59 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADEAD883D4
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 08:02:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1729576972; x=1730181772; i=xypron.glpk@gmx.de;
 bh=QH1gHUDgWsw2CrKS6ACWAcdvmSLl9trbcWklnIX9a5c=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=gjnVUYzANNlfqAF+u15jr63JWbc3dj7eITik/qGXGBtQPxPP5NSNpVJ+D574sr0B
 R3+D9EelC0Cmm/TP8y1lpmbKFEOSZ8X286DIgyMnCx5vbW4oiX6k8vMmGerYmNPVv
 IGoEj+LUR1suaqwiTYB+behMyHzgYHc656TUkNUnpN27lEirC9o5arFd7vloJy3oY
 /0kqbZPwAAV2hFPqKXpA8tZsdMMCAhkCVEW7fOul1s2EBqBXV2JjkqjnHPj3tNS6L
 tcDg6ywHs/NhHxTaEJctt0ojI+wH93dean7XIknW8yUR+qq7Oimvruco+dtMNr2BE
 xESVtQHWmskUEo52fg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.150.8.169] ([145.103.114.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3se8-1u2pNz48K8-00zoCg; Tue, 22
 Oct 2024 08:02:52 +0200
Message-ID: <5fc1929f-c931-4c14-847b-6ea9333037d5@gmx.de>
Date: Tue, 22 Oct 2024 08:02:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] efi_loader: Mark a function static
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <20241021140546.2969356-1-andriy.shevchenko@linux.intel.com>
 <CAC_iWjL1nUaKGb2kDK=7BKn1xgS3CitQ3FHP94VcwObjcMuuAQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjL1nUaKGb2kDK=7BKn1xgS3CitQ3FHP94VcwObjcMuuAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xba/9qWxfQJDnnrC39jfx1NyZHAm8WQm/uOUKAzvdC/a3Fsy4VG
 D9Wg20+DlhxIxqX6q2dW5MymXQ0VCRTj24eAB2p85Yk3H39lOZH2N6O9zPivojLPE1VUbY/
 g5HInWtPNyqAH+wgrtjjpENBA+hiw+ZLOhlYmyoLZNgXsGLJM76+rg4vC1OhjkKxfbIMaf+
 7ybcUxokAtmfj5vK7ONYw==
UI-OutboundReport: notjunk:1;M01:P0:C5aIZvECuHE=;g/l6IjhZlCVEZ197OD4SY+H73eB
 ikFbSyEp5QpDA7JoNN2DIyTBZTA0Ee2zRr36GQO0ajGW+s+8KFr/+OvqesGNw4v3vCMDBF8Fn
 8vLbK8OGWhSm6/+sx/Sp7irNVEPxsM9v1Bd9Z1D0WlJy/pyvI4SrWoJG//07yPFHvNL98Z3ll
 ZAjIxHlNfYVhYdhHkNKSfffUVQSQWC1Du751nEJ8llx+dYb7spcUo2gKuXae7od//YhB4DXCk
 vtiPIb+0AuKF8dG+Hezw5FNXdhBMLiZS9fOs1ukoctnqwNmRrti75NM6ZbiXaApkjLX+Fc1RT
 2tgJY0yWF/pWxK4YB6EguyDRAzrj/KZ7BZ669ztKsyelX/9QsA3p43yAc6OYlfXWeOgcS/pf6
 AsF8sYGRc1532uvuo2Da5YR7b0m+G8596PaoXyu35ovj82ViJWtWTMSDbY8sFQ7cyRnI33yZd
 soRIsvm+X3IHSJG7UYkCUhnG9nqy8C2cYSDkV64brP2oAi4E9zk20dczP54kWJzYvpsFZZb5h
 eSVDUDCI5FrCW7LKDJKQHOPOhLvIFBpF9VV9f53wsLehmdhemK/3EV0jkdo8vyDdvrADLT8wf
 dHt31Mk28P8mtNbWok94fZl+D+qt55IgD2qnO9fSeAB+qqhKmkgC2J+WgvrKvxYimVlb2cYU3
 DI8Ye4fE8n0AujaF4kIA3fUasb8/mg1C+UiMvB/sak54m+IWu9qczxuWN59KYt7UeTfZl8Gq8
 UPMRTMunFzw19GDdv2LOw3EsCpv1V2Ql+k0iUcClwC9KqYMVEXhrfsj3TGAA1kKHhnkCQQIpL
 L25ovYAh317TEkbC2ZRNEUZA==
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

On 10/21/24 16:40, Ilias Apalodimas wrote:
> Thanks Andy
>
> On Mon, 21 Oct 2024 at 17:06, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>>
>> efi_bootmgr_release_uridp_resource() is not used anywhere except
>> the same file where it is defined. Mark it static.
>> This helps avoiding the compiler warning:
>>
>>    lib/efi_loader/efi_bootmgr.c:388:14: warning: no previous prototype =
for =E2=80=98efi_bootmgr_release_uridp_resource=E2=80=99 [-Wmissing-protot=
ypes]
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>   lib/efi_loader/efi_bootmgr.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.=
c
>> index 589d3996b680..79144962cd73 100644
>> --- a/lib/efi_loader/efi_bootmgr.c
>> +++ b/lib/efi_loader/efi_bootmgr.c
>> @@ -385,7 +385,7 @@ err:
>>    * @ctx:       event context
>>    * Return:     status code
>>    */
>> -efi_status_t efi_bootmgr_release_uridp_resource(struct uridp_context *=
ctx)
>> +static efi_status_t efi_bootmgr_release_uridp_resource(struct uridp_co=
ntext *ctx)
>>   {
>>          efi_status_t ret =3D EFI_SUCCESS;
>>
>> --
>> 2.43.0.rc1.1336.g36b5255a03ac
>>
>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Hello Andy,

The function is called efi_bootmgr_release_uridp() since 292a4a4c7b77
("efi_loader: shorten efi_bootmgr_release_uridp_resource()").

Best regards

Heinrich

