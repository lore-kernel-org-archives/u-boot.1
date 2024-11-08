Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E79D64064
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 16:48:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D05258921B;
	Fri,  8 Nov 2024 17:48:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="NNfCo5/s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C47A8921B; Fri,  8 Nov 2024 17:48:00 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FB53891FE
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 17:47:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731084473; x=1731689273; i=xypron.glpk@gmx.de;
 bh=TkdkP5o1KqrZFQssdycXNMAoTKVzV3Mdvfr4BK58xVk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=NNfCo5/s6974rZVAVcEdyH7dbQh1rLRtmU22M9R3Tpyxc5rrJWn8GqT7W82XWafj
 uir4UTj2eWH/eYaed4D6N3z0rgeshDj4LXZ07rueMhqurc24f/pnojGjlL3kxpqQj
 lWtH9km2GcNMovORQygmqa3h06zJJd5mAhQZQ3rAYBCfirtCMH9Tt2wNTaMulOQo5
 Hkh2FRqRygnIHQGnL7kcVRfx8M4YW+E807AhXYomTfdOOsurqXTDyfEZ8HCWtEsJB
 fBRL7yOgO2VXeSZKhbo6FbQQPS66/TjGLyBsG3B6aziFOFivl4UJ+yA8JL1XaQljM
 6jafiSXhbnhFOWhA8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2Dx8-1tniad09Fe-011lR7; Fri, 08
 Nov 2024 17:47:53 +0100
Message-ID: <8124c5bc-be23-4f18-bee8-52be77cb7fb9@gmx.de>
Date: Fri, 8 Nov 2024 17:47:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] net/lwip: wget: integrate struct wget_info into wget
 code
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20241106130446.211222-1-adrianox@gmail.com>
 <eb1e5c49-3a2d-4ac5-abae-71cf82b90823@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <eb1e5c49-3a2d-4ac5-abae-71cf82b90823@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BJFg22AZezMdWpOdi3R+45IpQpDF6869fVpyuOriInVlhGRBfdN
 pO3/O6DmoiKWVHKLiqPKyDVVErU1amv3FanYBEMpDpz/vY1A4r8nCbt9rg17fZEkBKeutYA
 N55BGTf7Tm9t1qd+1fNbXmwaf9i7EJcwlpBjlWWaFuGput4E1vE6NiozUJWGNmtGVIKvYSl
 pbSn3LWnf26zrZmGtDiWQ==
UI-OutboundReport: notjunk:1;M01:P0:0FEw0vQTGEE=;uUQjjIuaoGiuvTkanrpo/EmplDT
 WSJ36D6QkUBcP2nwunQInxkPfW9PhELR5pOcB5yu9SQnZqaLHkvxYKEFRxzLOcncTxsnBqTCE
 jf65gafpSXkCagt3VVFatXTb9WQXgC9A2xnjPnzjwm0aMRgLXKm0x47vaE3alvXePXyBx2Bhj
 F2WJQqoIX2CF677GGHGZk91Cm5l8wdc6e8iZU6z/8YzzEz1shrRG6zGftMCMw7Nc6Dc30lq0n
 /8nXVJEqNkR4JZm/Fw1D3CEHHfUTGME5Rw9HLupX5pPlQ/VOsqtmxmc8QZ5hEy6I+oKvaUjGS
 iJGOiCHODAw76t4zBAh5J+oOxKpTxvhOApTDWfSCniwBD8xoLplaDSoLIt5vBcs3y6zGbaN7q
 RQFav0kzUEr7RSLHJTPZIvG9sWVdy1qDHgzXfBkVNAaDhQv5A2bMT6qzzDQnzLBqelC7xuW47
 ep0xwHEU2WpjSbXKcHXhNdqlV5BhVbFjc/s1pSSLT+4P/6Wds1qTIfnQkSXCkux+7tuYoRr0L
 ooL4EmSjux/Wo05tZRY+R8s6W/AYkgjOm6qNiwMaw0wcPmBrgKYtoe2cnFMCNVfGVuy8MCkoQ
 OxkyaQvfPt3V1ld5ECmM8wPSEoyTOm8ubkIazhv/J8Os/0bz1DDR4XJxloVAP7YRCVQEsmjsf
 Bjxg1OjQJcoV5PX8Ljb2RIB8RWl4qf9r9aqNmy8LeGT1JbOZ2Snibpnz8xcMTagdst+EKs6JG
 tBtZuBbtLkP6brq5XqF55giz1meYM3dfvzHYoWMP+0K2ytYffaAx0Gumw2o16/IhxGhHP/WgO
 FvlwGnrGLHCmC1FRz0wgvCl3kz0H4IlfuceTc9v9eh50lAmrznJzx8x0+KoQ+SDI+e8Y/dGbG
 SkeNw1LWY8dKksIViNXX6BPv99slX7VKlDtS95oi1+Q9Pcyq/u7oBFcBs
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
>> Each wget request now fills the struct wget_info. Also, the
>> efi bootdevice is now set conditionally to the set_bootdevice
>> variable in wget_info and a buffer size check is performed if
>> check_buffer_size is set.
>>
>> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
>> ---
>>   net/lwip/wget.c | 39 +++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 37 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
>> index 4add520045..bc0ecfe5b7 100644
>> --- a/net/lwip/wget.c
>> +++ b/net/lwip/wget.c
>> @@ -34,6 +34,19 @@ struct wget_ctx {
>>   	enum done_state done;
>>   };
>>
>> +static void wget_lwip_fill_info(struct pbuf *hdr, u16_t hdr_len,
>> +				struct wget_http_info *info, u32_t hdr_cont_len)
>> +{
>> +	if (info->headers && hdr_len < MAX_HTTP_HEADERS_SIZE)
>> +		pbuf_copy_partial(hdr, (void *)info->headers, hdr_len, 0);
>> +	info->hdr_cont_len =3D (u32)hdr_cont_len;
>> +}
>> +
>> +static void wget_lwip_set_file_size(u32_t rx_content_len, struct wget_=
http_info *info)
>> +{
>> +	info->file_size =3D (ulong)rx_content_len;
>> +}
>> +
>>   static int parse_url(char *url, char *host, u16 *port, char **path)
>>   {
>>   	char *p, *pp;
>> @@ -178,6 +191,13 @@ static void httpc_result_cb(void *arg, httpc_resul=
t_t httpc_result,
>>   	struct wget_ctx *ctx =3D arg;
>>   	ulong elapsed;
>>
>> +	wget_info.status_code =3D (ulong)srv_res;
>> +
>> +	if (err =3D=3D ERR_BUF) {
>> +		ctx->done =3D FAILURE;
>> +		return;
>> +	}
>> +
>>   	if (httpc_result !=3D HTTPC_RESULT_OK) {
>>   		log_err("\nHTTP client error %d\n", httpc_result);
>>   		ctx->done =3D FAILURE;
>> @@ -197,8 +217,11 @@ static void httpc_result_cb(void *arg, httpc_resul=
t_t httpc_result,
>>   	printf("%u bytes transferred in %lu ms (", rx_content_len, elapsed);
>>   	print_size(rx_content_len / elapsed * 1000, "/s)\n");
>>   	printf("Bytes transferred =3D %lu (%lx hex)\n", ctx->size, ctx->size=
);
>> -	efi_set_bootdev("Net", "", ctx->path, map_sysmem(ctx->saved_daddr, 0)=
,
>> -			rx_content_len);
>> +	if (wget_info.set_bootdev) {
>> +		efi_set_bootdev("Net", "", ctx->path, map_sysmem(ctx->saved_daddr, 0=
),
>> +				rx_content_len);
>> +	}
>> +	wget_lwip_set_file_size(rx_content_len, &wget_info);

There is some conceptional dissonance:

You have declared wget_info as an external symbol in
include/net-common.h. But here you are passing it as a pointer.
It is unclear why you can't use the global symbol in the called function.

>>   	if (env_set_hex("filesize", rx_content_len) ||
>>   	    env_set_hex("fileaddr", ctx->saved_daddr)) {
>>   		log_err("Could not set filesize or fileaddr\n");
>> @@ -209,6 +232,17 @@ static void httpc_result_cb(void *arg, httpc_resul=
t_t httpc_result,
>>   	ctx->done =3D SUCCESS;
>>   }
>>
>> +static err_t httpc_headers_done_cb(httpc_state_t *connection, void *ar=
g, struct pbuf *hdr,
>> +				   u16_t hdr_len, u32_t content_len)
>> +{
>> +	wget_lwip_fill_info(hdr, hdr_len, &wget_info, content_len);

Ditto.

Best regards

Heinrich

>> +
>> +	if (wget_info.check_buffer_size && (ulong)content_len > wget_info.buf=
fer_size)
>> +		return ERR_BUF;
>> +
>> +	return ERR_OK;
>> +}
>> +
>>   static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>>   {
>>   	httpc_connection_t conn;
>> @@ -233,6 +267,7 @@ static int wget_loop(struct udevice *udev, ulong ds=
t_addr, char *uri)
>>
>>   	memset(&conn, 0, sizeof(conn));
>>   	conn.result_fn =3D httpc_result_cb;
>> +	conn.headers_done_fn =3D httpc_headers_done_cb;
>>   	ctx.path =3D path;
>>   	if (httpc_get_file_dns(ctx.server_name, ctx.port, path, &conn, httpc=
_recv_cb,
>>   			       &ctx, &state)) {
>
> Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
>
> Thanks,

