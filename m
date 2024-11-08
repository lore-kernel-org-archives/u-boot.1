Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEAAD64074
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 17:48:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 353AC88E00;
	Fri,  8 Nov 2024 18:48:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="LOkbPH81";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3AD3890CE; Fri,  8 Nov 2024 18:48:13 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB64088B8F
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 18:48:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731088087; x=1731692887; i=xypron.glpk@gmx.de;
 bh=gqD0vRhHguAmXejaojmVyRHUM6rh+fdeKN8wjV8QEGA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=LOkbPH819w6ct5KF4W+VSLTwDo3IfOjQ8p6zmzT5O9iEVBOR9FhXzu72iYcK8gRN
 isnWhQxbOaGLwNqBap0AeOTc4NfgHqexQKnnkvTPH88wbhmRxiLDS1711uW9g0MTD
 +CZ6sr1Xzogtk8ZnMf6Ir9YjAoA9Enl2sykj871FohhHR4Ev2DKYqS41fNMgixqg1
 MvwsiPT+7DiVnNN8pFmXxYhY0AJCyimZlzsyKq1xgEyu5CAvnlHzb/qwyyLUmyrBb
 hxyIAJSjRp6c6lpki4ww7T3M1Uf7gGFY9nt/8ZOhIyMO3vhE5PsdIaSElw2mgnk1G
 tF/WPChOcnLJUrJLBA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mk0JM-1tXpUd2DIe-00iRxB; Fri, 08
 Nov 2024 18:48:07 +0100
Message-ID: <97f1202c-1d9b-4209-98c4-23aac6baa02c@gmx.de>
Date: Fri, 8 Nov 2024 18:48:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] net/lwip: wget: put server_name and port into wget_ctx
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Jerome Forissier <jerome.forissier@linaro.org>
References: <20241106130428.211190-1-adrianox@gmail.com>
 <3aa5b358-37d6-48b7-ab10-176bdee1e05b@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <3aa5b358-37d6-48b7-ab10-176bdee1e05b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ezC3mNyp1KBvLeq7Bpe8FKDtZJ47T9oQ/HNfObw+HtGb8FRDkv8
 k82W/iPgXESrdU/03UPDLdcXM4TzFXwVAZ3aFC4cvNW8GRFOgJJ8uCPrhyG4V9Ejgby8XdO
 9FuYdKfraWYzb5CO01s8x0KxvnC9dc8uyq5wOuMe3XEZSMkthExf3YDGlyuc7XWpa2Ysmaw
 TpyXjlT+gVls/RrF25EnA==
UI-OutboundReport: notjunk:1;M01:P0:u5shWsGEFU4=;IPdfft3vHkYEjs+Z6zWgjGd44Vb
 yNea4et1J2LLAIx3W5r3EZXK+QHsUGsgUdDrOdA+6ykv9TUK9kgquu39L3BhJ3lodIQdAOckr
 GjsEua/ZowjSAbbzSrUP5H75h3QUIyrwefJD5VH1tlnHmpcq6I+Qqud+TpWRnPl4NWyu94Pc6
 AtrS0OzpPzjyaFgrmc006iyADYaZ5DcDett6gaxCsjI5d0tnPWDaUYc3BualB0J7paBHEiIRJ
 hv5HV6jlwAE/4KPhUmuj818TzhVMVCnsl4TKeGGDNEMvvqbT8mJPheA7GKTDo6R59E4JdQWBG
 NKQdF/BUBgVhKdFePoic7IATUvuaepXyFxKN0OEkw1M7Sv6eVFHHGY7YBj6oZnvADSOSbUd/1
 e08GTInWw8ym0U7Vj0uD1GtKx4/VJTQrvXe05h+HC8Co/LACMxNRFdleUT3FmswFegtssnLo4
 KqSGr28VHjh8FVrXNVSeUKaRZvsXUmdF9eapV1TkKQ76j2jWIx2TfSedtGXue251QRL7Mu6Av
 FxA60ev8d1BY8gkOJehfjx3QNNtXdCWEz777Z+a90pX47U1zkRulykz8kcARxzLjSY+GjiC3g
 zBGRH4M8lGQCER4XvsP6onXayc6H737aJ4PG7xitgda0YCwHHTVEJ5F2WT/gMyxkBEFVGmE+L
 /4Wpb3uxBXKxxmBzaJ685z19vE9NuvvvLg5qL0kUVyPzx2ovRGcms6DnLM7VjSUVuw7guVPlI
 XNoRodv6bHkPbRUcMtKYzhfazUBvHryUeXeP8B5sFIp3J2MQPasSFt9k6794zgLL2CRgatj5S
 QDJKXy0jhukase7FMFzI3Tq6E5hh1R609pqubn+DV0zUM7qfKyWVI7kPU2RkxbXqKil/HJWEH
 C6LmT8si5h7yxkUF3m6Xm95yeZptdcMoIMt7zhjuUuvSM2QnPtiW7Eb+u
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
> On 11/6/24 13:04, Adriano Cordova wrote:
>> Currently server_name and port are local variables in wget_loop.
>> This commit puts them inside ctx, so that they are accessible
>> from the http callbacks.
>>
>> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
>> ---
>>   net/lwip/wget.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
>> index b495ebd1aa..4add520045 100644
>> --- a/net/lwip/wget.c
>> +++ b/net/lwip/wget.c
>> @@ -23,6 +23,8 @@ enum done_state {
>>   };
>>
>>   struct wget_ctx {
>> +	char server_name[SERVER_NAME_SIZE];

cf.
[PATCH 1/1] net: lwip/wget: correct SERVER_NAME_SIZE
https://lists.denx.de/pipermail/u-boot/2024-November/571167.html

Acked-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

>> +	u16 port;
>>   	char *path;
>>   	ulong daddr;
>>   	ulong saved_daddr;
>> @@ -209,13 +211,11 @@ static void httpc_result_cb(void *arg, httpc_resu=
lt_t httpc_result,
>>
>>   static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>>   {
>> -	char server_name[SERVER_NAME_SIZE];
>>   	httpc_connection_t conn;
>>   	httpc_state_t *state;
>>   	struct netif *netif;
>>   	struct wget_ctx ctx;
>>   	char *path;
>> -	u16 port;
>>
>>   	ctx.daddr =3D dst_addr;
>>   	ctx.saved_daddr =3D dst_addr;
>> @@ -224,7 +224,7 @@ static int wget_loop(struct udevice *udev, ulong ds=
t_addr, char *uri)
>>   	ctx.prevsize =3D 0;
>>   	ctx.start_time =3D 0;
>>
>> -	if (parse_url(uri, server_name, &port, &path))
>> +	if (parse_url(uri, ctx.server_name, &ctx.port, &path))
>>   		return CMD_RET_USAGE;
>>
>>   	netif =3D net_lwip_new_netif(udev);
>> @@ -234,7 +234,7 @@ static int wget_loop(struct udevice *udev, ulong ds=
t_addr, char *uri)
>>   	memset(&conn, 0, sizeof(conn));
>>   	conn.result_fn =3D httpc_result_cb;
>>   	ctx.path =3D path;
>> -	if (httpc_get_file_dns(server_name, port, path, &conn, httpc_recv_cb,
>> +	if (httpc_get_file_dns(ctx.server_name, ctx.port, path, &conn, httpc_=
recv_cb,
>>   			       &ctx, &state)) {
>>   		net_lwip_remove_netif(netif);
>>   		return CMD_RET_FAILURE;
>
> Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
>
> Thanks,

