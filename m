Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2747CCD184
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 16:59:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68F7A807B1;
	Tue, 14 Oct 2025 18:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="cnsCRFlI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B84028312A; Tue, 14 Oct 2025 18:59:22 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8189980107
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 18:59:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1760461158; x=1761065958; i=xypron.glpk@gmx.de;
 bh=v3pTRUfgTZ6Xc/u7NqWxQxvibIetGM489QdMqDt8djI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=cnsCRFlIgQUqzkdiFu/1dbUZB6RGlRGhYf3FkMb3iGJi0MEI1/pbNzJipZzrk5tB
 hvkc1UkYa+LpPuTmqv09ko586xNS58fKWhcttpFoFRfHr7cMQXHhKmZANXqrb8265
 sbcokJ2dFk3iFUmO+tUqIR4gFqX0v8NIWDu3rxBsb3zxAevjfLjV9P+RZBIjYaMku
 XnqqgLV+ai/XIsc4qBCSeJH4YAd0An7jDXhotdOvM83CN3DnWMXcAVCceMF2wfHhA
 DAvGgEl9W+kS6B62/ifyIyIVpDwlFx5/bDe4KYZMPdhl06BLpF6TVfYgMh5TGM9zR
 xnKpoJMRx21gh9melA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrQEx-1uTf7449yh-00nC91; Tue, 14
 Oct 2025 18:59:18 +0200
Message-ID: <b9e025ec-6b69-4d8a-837c-07c75bf3131e@gmx.de>
Date: Tue, 14 Oct 2025 18:59:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] fs: semihosting: Fixup smh_flen against overflow
To: Sean Anderson <sean.anderson@seco.com>
Cc: Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
References: <20251014-fs_semihosting-v4-0-6f2bc490175b@linaro.org>
 <20251014-fs_semihosting-v4-2-6f2bc490175b@linaro.org>
 <ac6c0dc1-2be7-48f5-8c2e-f90401411bef@seco.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <ac6c0dc1-2be7-48f5-8c2e-f90401411bef@seco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gsb4smhegiz768rGhH8nqXwcg2PIj/stpz88bhR/BNgj+JxTY09
 CkAI/2pK1xeSCwYIUgKJAtzlK1DSRyCyQ1E1abakd6WsqpivSmf1SpDxMU1wD4QatxqAH+b
 tfLIQVyJvrjRYmT46mpLaims34bSwQJvYm+v4F5+rhhZTZAlQC8nxffrUHO9QAZ1e49KmAT
 xaeaseGVdSMOUT0lgpxSQ==
UI-OutboundReport: notjunk:1;M01:P0:wcD0N5NXx9I=;lU4SUeD9wamYVBS2WNesN6ARtpT
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

On 10/14/25 18:21, Sean Anderson wrote:
> On 10/14/25 12:03, Andrew Goodbody wrote:
>> The sys calls SYS_FLEN was being used in a way that did ot allow for
>> file sizes > 2^31. Fixing this required changing the signature of the
>> function to allow file sizes up to 2^32 - 2 and also being able to
>> return errors that could be tested for.
>>
>> This issue was found by Smatch.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   common/spl/spl_semihosting.c |  6 +++---
>>   fs/semihostingfs.c           | 14 ++++++++------
>>   include/semihosting.h        |  5 +++--
>>   lib/semihosting.c            |  6 ++++--
>>   4 files changed, 18 insertions(+), 13 deletions(-)
>>
>> diff --git a/common/spl/spl_semihosting.c b/common/spl/spl_semihosting.=
c
>> index cff6f5351e265136b3effe483fd5d641fdd109f8..fb578a274d0d937b2ed5bd1=
3e505bcefd4491799 100644
>> --- a/common/spl/spl_semihosting.c
>> +++ b/common/spl/spl_semihosting.c
>> @@ -28,7 +28,8 @@ static int spl_smh_load_image(struct spl_image_info *=
spl_image,
>>   {
>>   	const char *filename =3D CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
>>   	int ret;
>> -	long fd, len;
>> +	long fd;
>> +	size_t len;
>>   	struct spl_load_info load;
>>  =20
>>   	fd =3D smh_open(filename, MODE_READ | MODE_BINARY);
>> @@ -37,12 +38,11 @@ static int spl_smh_load_image(struct spl_image_info=
 *spl_image,
>>   		return fd;
>>   	}
>>  =20
>> -	ret =3D smh_flen(fd);
>> +	ret =3D smh_flen(fd, &len);
>>   	if (ret < 0) {
>>   		log_debug("could not get length of image: %d\n", ret);
>>   		goto out;
>>   	}
>> -	len =3D ret;
>>  =20
>>   	spl_load_init(&load, smh_fit_read, &fd, 1);
>>   	ret =3D spl_load(spl_image, bootdev, &load, len, 0);
>> diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
>> index 15f58d578b65f7dbbadce19093546f5bdb46c0c3..6a4d0aaaf2fdaf8da154e59=
677839a5c7a4889e9 100644
>> --- a/fs/semihostingfs.c
>> +++ b/fs/semihostingfs.c
>> @@ -35,10 +35,10 @@ static int smh_fs_read_at(const char *filename, lof=
f_t pos, void *buffer,
>>   		return ret;
>>   	}
>>   	if (!maxsize) {
>> -		size =3D smh_flen(fd);
>> +		ret =3D smh_flen(fd, &size);
>>   		if (ret < 0) {
>>   			smh_close(fd);
>> -			return size;
>> +			return ret;
>>   		}
>>  =20
>>   		maxsize =3D size;
>> @@ -79,17 +79,19 @@ static int smh_fs_write_at(const char *filename, lo=
ff_t pos, void *buffer,
>>  =20
>>   int smh_fs_size(const char *filename, loff_t *result)
>>   {
>> -	long fd, size;
>> +	long fd;
>> +	size_t size;
>> +	int ret;
>>  =20
>>   	fd =3D smh_open(filename, MODE_READ | MODE_BINARY);
>>   	if (fd < 0)
>>   		return fd;
>>  =20
>> -	size =3D smh_flen(fd);
>> +	ret =3D smh_flen(fd, &size);
>>   	smh_close(fd);
>>  =20
>> -	if (size < 0)
>> -		return size;
>> +	if (ret < 0)
>> +		return ret;
>>  =20
>>   	*result =3D size;
>>   	return 0;
>> diff --git a/include/semihosting.h b/include/semihosting.h
>> index 42832d86c711ff04e91b6b739c80629253f6d30a..60535199b9532ce16620aea=
3ca1ea741c5b73766 100644
>> --- a/include/semihosting.h
>> +++ b/include/semihosting.h
>> @@ -124,10 +124,11 @@ long smh_close(long fd);
>>   /**
>>    * smh_flen() - Get the length of a file
>>    * @fd: A file descriptor returned from smh_open()
>> + * @size: Pointer which will be updated with length of file on success
>>    *
>> - * Return: The length of the file, in bytes, or a negative error on fa=
ilure
>> + * Return: 0 on success or negative error on failure
>>    */
>> -long smh_flen(long fd);
>> +int smh_flen(long fd, size_t *size);
>>  =20
>>   /**
>>    * smh_seek() - Seek to a position in a file
>> diff --git a/lib/semihosting.c b/lib/semihosting.c
>> index e49b16b0aa34ab04b6c8949a3e7cab539fdbef82..547a936e17f38204e840035=
a50f481e57d159592 100644
>> --- a/lib/semihosting.c
>> +++ b/lib/semihosting.c
>> @@ -154,7 +154,7 @@ long smh_close(long fd)
>>   	return 0;
>>   }
>>  =20
>> -long smh_flen(long fd)
>> +int smh_flen(long fd, size_t *size)
>>   {
>>   	long ret;
>>  =20
>> @@ -163,7 +163,9 @@ long smh_flen(long fd)
>>   	ret =3D smh_trap(SYSFLEN, &fd);
>>   	if (ret =3D=3D -1)
>>   		return smh_errno();
>> -	return ret;
>> +
>> +	*size =3D (size_t)ret;
>> +	return 0;
>>   }
>>  =20
>>   long smh_seek(long fd, long pos)
>>
>=20
> Nack, for reasons outlined on v3.

Dear Sean,

I prefer considerate discussion to NAKs.

Please, provide convincing reason for not supporting files beyond 2 GiB=20
if you want this patch to be altered.

Best regards

Heinrich


>=20
> This should just be
>=20
>      if (ret < 0)
>          return ret =3D=3D -1 ? smh_errno() : -EOVERFLOW;
>=20
> --Sean

