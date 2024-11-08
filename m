Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5028BD6406B
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 17:07:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B90EF88B0A;
	Fri,  8 Nov 2024 18:07:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="OHnNTJAI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8603D88B8F; Fri,  8 Nov 2024 18:07:48 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CD9B8860B
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 18:07:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731085661; x=1731690461; i=xypron.glpk@gmx.de;
 bh=1k6G3btTfLPcBbxXj5Ss6a9vos1tCAHBGz1iY/Ij3I0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=OHnNTJAIzVWFar1CMKgGHGwhMwcDJjtCwk0UBbHMUYWanZHqw5HDWFyYh/wtxfQR
 rP8JJKodGTDzNFlhNoECnpoz/gcX1aAIxhCnelhC6WpRNqubPJ36LetSt3X32tA5l
 Gp0alZisobvcks0ljDeeof1YWCBoOMJNOkxeKwXX76iqTkfeeHsXgfnSQcEeI8cOC
 APKJvgwG7VZx8IMLxtDrBx2a/W27jpTapfzoDrCgpnGlFD08O8cIcg/pHR2mYY2BR
 tCclGLgwadfDRXKHvoflNvmgvmNkn7hArjjQ0XPKsB/wPzed5SNfrJMb0YZpAVhb2
 9e7kSfk3omLTmJ4UOw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M59GG-1t8Lzl0zTA-00EfJC; Fri, 08
 Nov 2024 18:07:41 +0100
Message-ID: <afdca582-9533-43f9-a93d-d2c7a2cdb9a0@gmx.de>
Date: Fri, 8 Nov 2024 18:07:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] net: wget: Add a global struct wget_http_info
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20241106130337.211101-1-adrianox@gmail.com>
 <b519fb69-308e-4608-9e61-491679d8f94f@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <b519fb69-308e-4608-9e61-491679d8f94f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Tj05W/0O+S/r6Xqq3E2CJRwHHRyAl7URJ56WP1tlFrpM/EdAX5n
 33bCf/0yuBh6pKVicwnN7uvA9WSuiHq/Vvz8YlkEZxzEDyK7fNvqzrjWPHuqfvqQHY+wpEG
 Qwk/165iGLFLAux8HhvxZlzvTEUMGVICkKiWh/rnXslYW9jpixMXO1C+ixXPoylx8qbl6Vj
 N/mVjuXW2ldfm47QzpepA==
UI-OutboundReport: notjunk:1;M01:P0:Lrj5Xc7Gf9A=;XZ5EpDAe/xjUbwNVzuwV51XfyVx
 yDnwHsTWCFJirXNZalynQLEdLEv+ysQFEPLiWJf4xtM2zXMEAleiQEATi9yeWOsw1C/8D+zjk
 nFiM2xexiRqlXsSajrg+ltTISy+J0+toncZOdN7StG0r45rVXbOii7i1LV4Kvhc7cw+WtkipS
 W5oIOqABs+YY3RhOfwykRrdeOU0TxDLrY+Hj+rCd8mjDJ7DsFTBCX5sJyTa+sPcHIO7XqwFoJ
 Q+WZC9DilQSePpKYl9wZHN5+4A5vHTBHyo1YteORcStrSvk3bDNb3mAm26BqnreQKSFo9fNdM
 6/mbXbhFY1GLcEy6MnUz72NV/sWAG61+sLmX5cEAVbK/2AJ2NOt6gbu6Kap/dpUp3B/ycg344
 gk+xsZy+RioodiOUG6EZ+H/ZJXcva1PPCRCBgC8R9VB4qcLS+kZ2aMPU6WznlQL+FdmrptvsC
 vjWO1Bz8mJf4TxED62Q2ki9/LWs9KQyW8MsSLxIyCMf8HcF3sDUuFqLkuAzkqLQFdG04M0nqb
 VvdGc5pS3+Eovgq0qbIrmnaohWU2Jxf8bwh1tj/TvcsA7AwKwfNE+gRAHGwhnizMmBpOBR51r
 ETsYOronQRGLNYhD/ZB/G1zojkogz2xb/TiN3GM6dH6B4aLezw5qEx3GWz7z2gbkdxT7a9EYi
 /Bw4s8PWfJ48324JIegUuY8L8AnHZwDY527X7XhxMwYokOdPe34cxmf8HTh/lj4GcqiUCSRHH
 xHWe5RzR23zSZ2aLlL0s8t5Auh0jvE3RtbmUtzmmvw0Xzl3wO8AMWU92A9OIds9nhH7pJEud/
 k/qfCPHnsdsbbZJVTLd0QxzA==
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

On 11/7/24 12:21, Jerome Forissier wrote:
> On 11/6/24 13:03, Adriano Cordova wrote:
>> Declare and define a global struct wget_http_info. The default
>> values are so that wget works as it used to, but they can be
>> changed by an application before issuing an http request using
>> wget, and restored afterwards. This struct is common to legacy
>> wget and lwip wget.
>>
>> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
>> ---
>>   include/net-common.h |  2 ++
>>   net/net-common.c     | 10 ++++++++++
>>   2 files changed, 12 insertions(+)
>>
>> diff --git a/include/net-common.h b/include/net-common.h
>> index 38ba95cf60..3039dfdce7 100644
>> --- a/include/net-common.h
>> +++ b/include/net-common.h
>> @@ -533,4 +533,6 @@ struct wget_http_info {
>>   	char *headers;
>>   };
>>
>> +extern struct wget_http_info wget_info;
>> +
>>   #endif /* __NET_COMMON_H__ */
>> diff --git a/net/net-common.c b/net/net-common.c
>> index a7f767d5e9..e969d508cc 100644
>> --- a/net/net-common.c
>> +++ b/net/net-common.c
>> @@ -1,4 +1,5 @@
>>   // SPDX-License-Identifier: GPL-2.0
>> +#include <net-common.h>
>>
>>   void copy_filename(char *dst, const char *src, int size)
>>   {
>> @@ -11,3 +12,12 @@ void copy_filename(char *dst, const char *src, int s=
ize)
>>   		*dst++ =3D *src++;
>>   	*dst =3D '\0';
>>   }
>> +
>> +struct wget_http_info wget_info =3D {
>> +	.method =3D WGET_HTTP_METHOD_GET,
>> +	.file_size =3D 0,
>> +	.buffer_size =3D 0,
>> +	.set_bootdev =3D true,
>> +	.check_buffer_size =3D false,
>> +	.headers =3D NULL,

wget_info is a global symbol. It will be reused in every wget
transaction. The values initialized here may be overwritten in a first
transaction and the current initialization would have no impact on a
second transaction.

Please, move the initialization to the function that starts a new
transaction.

For static and global variables only used after relocation it is not
necessary to initialize members to 0 in the definition.

Best regards

Heinrich

>> +};
>
> Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
>
> Thanks,

