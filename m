Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E06D44C66
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 15:25:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35B2480077;
	Thu, 15 Jan 2026 16:25:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="lnFOJ3Ir";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8484080325; Thu, 15 Jan 2026 16:25:49 +0100 (CET)
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B34B38003E
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 16:25:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=linux@fw-web.de
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
 by mxout1.routing.net (Postfix) with ESMTP id 4101A3FE7D;
 Thu, 15 Jan 2026 15:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
 s=routing; t=1768490746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xyuYJ/wr8qRfy2tcwsYViFFwFU4Z5YDcoK09sNgvizw=;
 b=lnFOJ3Ir2MUscwfuK4uYBDizst1vFHHgcjtdWScJF9/0nwBFMtAV3mXJ5ekoRdIcjpNdw1
 E8T/EtgnhjG9upKNp5UZzaBzoURnBFtcOw3sb6lujrxSe4qCF44XK2uT3lpV1MWXBWj8OQ
 syBEGsX5z/5YdrfqUdekfHodToZupUE=
Received: from ehlo.thunderbird.net (unknown
 [IPv6:2a01:599:a23:b22:7695:9e1e:d500:2c06])
 by mxbox4.masterlogin.de (Postfix) with ESMTPSA id CF9BE802A2;
 Thu, 15 Jan 2026 15:25:45 +0000 (UTC)
Date: Thu, 15 Jan 2026 16:25:46 +0100
From: Frank Wunderlich <linux@fw-web.de>
To: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de
CC: Frank Wunderlich <frank-w@public-files.de>
Subject: Re: [PATCH] boot/fit: print name of config node not found
User-Agent: K-9 Mail for Android
In-Reply-To: <082479d3-3b0d-466d-8749-552e60101fd5@cherry.de>
References: <20260111092338.16555-1-linux@fw-web.de>
 <082479d3-3b0d-466d-8749-552e60101fd5@cherry.de>
Message-ID: <7E97808D-FB0D-49EA-8DB4-3458140C4345@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mail-ID: 42c59385-0ee6-478f-aef6-464cf58a9cc7
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

Hi

Am 15=2E Januar 2026 13:36:15 MEZ schrieb Quentin Schulz <quentin=2Eschulz=
@cherry=2Ede>:
>Hi Frank,
>
>On 1/11/26 10:23 AM, Frank Wunderlich wrote:
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>=20
>> Show name of configuration node which was not found=2E
>>=20
>> current state gives no hint if fit image is wrong or the requested name=
=2E
>>=20
>> Could not find configuration node
>> load of <NULL> failed
>>=20
>> After this patch we see name like this:
>>=20
>> Could not find configuration node '#ov-test'
>> load of <NULL> failed
>>=20
>> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>> ---
>>   boot/image-fit=2Ec | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/boot/image-fit=2Ec b/boot/image-fit=2Ec
>> index 2d040e38d97b=2E=2E92675e98f2eb 100644
>> --- a/boot/image-fit=2Ec
>> +++ b/boot/image-fit=2Ec
>> @@ -2125,7 +2125,7 @@ int fit_image_load(struct bootm_headers *images, =
ulong addr,
>>   		if (ret < 0 && ret !=3D -EINVAL)
>>   			ret =3D fit_conf_get_node(fit, fit_uname_config);
>>   		if (ret < 0) {
>> -			puts("Could not find configuration node\n");
>> +			printf("Could not find configuration node '%s'\n", fit_uname_config=
);
>
>It seems like fit_uname_config can be NULL (see outside of the patch cont=
ext)=2E How does printf behave when this is the case? Should we do somethin=
g like
>
>fit_uname_config ?: ''
>
>instead? That does seem like the message could be confusing also as now i=
t says "Could not find configuration node ''"=2E

Thank you for taking a look=2E
In my current testcase it was an empty string, but yes I could do somethin=
g like you suggested=2E=2E=2Emaybe call it "null" or "empty" instead of emp=
ty string?

>Cheers,
>Quentin


regards Frank
