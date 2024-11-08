Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB909D64070
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 17:14:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 300B888FFC;
	Fri,  8 Nov 2024 18:14:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="H/1WYJgg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F32988D47; Fri,  8 Nov 2024 18:14:52 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C45A8900E
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 18:14:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731086085; x=1731690885; i=xypron.glpk@gmx.de;
 bh=s84FkC4Rt9MjQyTNF173Zfnl9ilxLecJkB/gs/shLt8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=H/1WYJggTRbSWoixASz2rI+IlENWLPF2NjOtVBJEpg2SUeTIE/9YLcbZM/8t6GDo
 WKtlD2JLr0csYJZLbTo31oQ72gV43jpQ9bV3tJgis9tyTKhlmFMCfl5m2OmSnns41
 Cq026O+uJhq9x90bFsVUtUoiK+3Bi6k/ezHvEiAa1e4dEl0q1iN9biYB0FFR4FKos
 nRXB3QuKV6F1e87qqvrgBCNggfKkUxFyT7aYIfchEMb3HoagOUEKErttnI6l+Gjdr
 GtVpBbBCKrfq5kpiKHU6b1q+I8S03ikJXbgdJlzAhzxJ4S91bGMjiosY45LAo4/5i
 To2hXcaV3thF8EF1FA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNbkp-1tSwCU16kd-00T9xb; Fri, 08
 Nov 2024 18:14:45 +0100
Message-ID: <ebcc6d51-1a5f-40bb-a24c-faef61706c04@gmx.de>
Date: Fri, 8 Nov 2024 18:14:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] net: wget: add definition of struct wget_http_info
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, u-boot@lists.denx.de,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20241106130318.211072-1-adrianox@gmail.com>
 <72eb2769-b409-47bd-8a06-d4e180096fb7@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <72eb2769-b409-47bd-8a06-d4e180096fb7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sx+kLCKknFfkHjNuSjIHUOPeGj2M1z4AAUc2kz7/VTlAsnaIdsu
 Fhyi9fmPGcMPa18SxHOMkepQ1ingzY85LfJlNkbo8NpdR4kSneFNimOHjYfdkumORebJnsy
 g15trowjsE6CQ78t8cZsM61Gtdk1H6ejImVT1cNkhsv1dnDFSaztMJIl1v1KplwiywpDUpL
 RM1zMnrhhif8JMhwl9Tnw==
UI-OutboundReport: notjunk:1;M01:P0:jZs12R0LKvA=;gQMy5l0x9BF2es2NL/WGQ8aVgT2
 Y4pIt8k+eVfofB2pdg7CqtGX9Dl6Ko0Co+lGbVYK969vGO0YwfpM79S/JwlGWmNvKIP0M5Eyr
 8EbSrhEC8BIAxehGT8eAgE0Fa4J2KPUKJ7/6Y1bAy4iuOzlB2jyhTuv5Tojy8Jjn9bpp59dKd
 ePA0u15luWkQxUXuHiiJv2wHSVx3fP/THkY+2Wn5dDW7X1A3RkaKz75OcI49ABXppeYSpEeWF
 C6N5J6b3IcAU6chi9zOoV97MDMeU0zl8N+j3hSa42qXicHzDMUC4+q21sHNwamNKlD2oYV3Yd
 PYkDdtsJiIM0jPA3URZwXr/aBfk+WWEb0ohtRnN3s23GDW56xXnBohVRoo5n+i71YmyWGCWbW
 l0rf/FsISCobaB2IHKs4JsR1x70nO/wxLL7Hp7dOvo7zaQ2plpuhAny7s5QFuA05JKAJw1R1t
 3YC1yyoSq6F6xf4oTpWapNTtYX4tuq+n5ny6hTdJF+NSYO05P8Thh+OptYuMxXokQb3PVSLGB
 iH3n3zvKVIEwNJxVYDK4n5lm4NDpPzf6vvybmOng0lAH+DODhU/+6Ho3LjLnHVE8yecHNHv3j
 8ezqera+RuZazGIrnT6tgY2H+hCNLteC6jNcT1AkeCU/gsRdygfrWdW0NqlysEuAI3Hjp9ss1
 suekfquwRGJH4AhayRud7d0Q9On0679QehTQ/UC39xo8hzKi+099CeiSbqxDRPzqFvmxt7y9K
 1Dgu8enppPvuOFz0QS8Ri0H0xOAo09NcdLpaX5WobYJp0A2Tf1OjpndLf/eTmyFQi04h6NQgC
 BhqbMKqc/E4zoqJV9SwjY2VQ==
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
>> The struct wget_http_info exposes the HTTP information of the last HTTP
>> request issued by wget, and it controls whether the efi bootdevice is s=
et,
>> and whether the buffer size needs to be checked (lwip stack only). This
>> information is otherwise discarded. The wget_http_info struct can be us=
ed
>> by HTTP drivers to have more control over HTTP requests.
>>
>> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
>> ---
>>   include/net-common.h | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/include/net-common.h b/include/net-common.h
>> index fd7c5e7b48..38ba95cf60 100644
>> --- a/include/net-common.h
>> +++ b/include/net-common.h
>> @@ -8,6 +8,7 @@
>>   #include <env.h>
>>   #include <hexdump.h>
>>   #include <linux/if_ether.h>
>> +#include <linux/sizes.h>
>>   #include <linux/types.h>
>>   #include <rand.h>
>>   #include <time.h>
>> @@ -506,4 +507,30 @@ int wget_with_dns(ulong dst_addr, char *uri);
>>   bool wget_validate_uri(char *uri);
>>   //int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const=
 argv[]);


Please, add documentation for the enum, MAX_HTTP_HEADERS_SIZE, and the
struct.

The U-Boot project follows
https://docs.kernel.org/doc-guide/kernel-doc.html#.

Otherwise looks good to me.

Please, CC Ilias as this series is the prerequisite for your
EFI_HTTP_PROTOCOL series.

Best regards

Heinrich

>>
>> +enum wget_http_method {
>> +	WGET_HTTP_METHOD_GET,
>> +	WGET_HTTP_METHOD_POST,
>> +	WGET_HTTP_METHOD_PATCH,
>> +	WGET_HTTP_METHOD_OPTIONS,
>> +	WGET_HTTP_METHOD_CONNECT,
>> +	WGET_HTTP_METHOD_HEAD,
>> +	WGET_HTTP_METHOD_PUT,
>> +	WGET_HTTP_METHOD_DELETE,
>> +	WGET_HTTP_METHOD_TRACE,
>> +	WGET_HTTP_METHOD_MAX
>> +};
>> +
>> +#define MAX_HTTP_HEADERS_SIZE SZ_64K
>> +
>> +struct wget_http_info {
>> +	enum wget_http_method method;
>> +	ulong status_code;
>> +	ulong file_size;
>> +	ulong buffer_size;
>> +	bool set_bootdev;
>> +	bool check_buffer_size;
>> +	u32 hdr_cont_len;
>> +	char *headers;
>> +};
>> +
>>   #endif /* __NET_COMMON_H__ */
>
> Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
>
> Thanks,

