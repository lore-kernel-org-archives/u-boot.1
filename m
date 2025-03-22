Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEEBC36005
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 02:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1261B81DE3;
	Sat, 22 Mar 2025 03:50:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742611811;
	bh=xHN3Hhia5WzWdac5x95tWhLSGd7sUrW+8Iqb2VrqX4M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=emW3N7vjzoUZlMZgt5j3c4k4sFF+70YEC/1tWby4XwDNusBKFglVypQLZ2U8MhKdS
	 /TqrxhgA3Pcx4AQlcpHjwAx7MJjN0DDBwykLcKrt0vQnBdpUzlmQ2flg9ySPkJAe3X
	 jUBxPQqhNGKWpUVMQbMUtjtgAJIwJZTMc53vhPdWS+9ZjigLkeSsCs3qZiK0laZFRc
	 PHvfOW2DZFGEt1nR1IiyvUf1hCJipMZhsi520y5pl20O1IPHAiL7V2DZQCYY1+eltA
	 /HsAqOT3kK9iU6BFh8XLJ0LudzVG2LbZ7TgNhNSP+5GXta4TWXXg9ohs05SuYSYaJ5
	 ytwrTXWi69b+w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23DBF81219; Sat, 22 Mar 2025 03:50:10 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E264A81D0B
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 03:50:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="IY98XLw+"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9C08C101E8F4E; Sat, 22 Mar 2025 03:50:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742611802; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=xHN3Hhia5WzWdac5x95tWhLSGd7sUrW+8Iqb2VrqX4M=;
 b=IY98XLw+/TQm2TX9zxCJX5goB9T21IfEVJsqKFsRWGWLWpjq+3jwMxidRnObvvoM9hdPl7
 1TICsB6CjPjetzcfzdKPpDgAcGynCfkEsiH3anuVtU8hSvXLdlcGxF0xal+ON3Shrh3djQ
 9oYCa9CrB2+wejRR9UPbiomrgQ7HiSIyS9ngt7GGL4+xYaXj0A+SH+H5CkocYSd/h+w7y2
 jB62vC2oy2iYZVEenDqXBf34GcM7VZz4fU4mJMKFGqRKC3YEJwCBEf0iE6HpYE2faJ64TE
 sScihGpjikNoN35S17/yo9z4UxJSAxEtC0CzkO8Hq/etG9+YjfD4KnK0nxilYg==
Message-ID: <559a8550-5f36-46bb-a593-bab3c47c4758@denx.de>
Date: Sat, 22 Mar 2025 03:10:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/19] scmi_protocols: update struct
 scmi_base_discover_list_protocols_out
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, =?UTF-8?Q?Lothar_Wa=C3=9Fmann?=
 <LW@KARO-electronics.de>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
 <20250321-imx95-v1-9-f2c8ba815f89@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250321-imx95-v1-9-f2c8ba815f89@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 3/21/25 8:15 AM, Alice Guo (OSS) wrote:

[...]

> @@ -276,22 +276,31 @@ static int scmi_base_discover_list_protocols_int(struct udevice *dev,
>   	if (ret)
>   		return ret;
>   

This math here could really use a code comment to explain what is going 
on here.

I assume there is 1 byte per protocol in the struct 
scmi_base_discover_list_protocols_out { .protocols[] } member, right ? 
If so, why not simply change u32 protocols[] to u8 protocols[] and use some:

out_size = sizeof(*out) + roundup(num_protocols, sizeof(u32))

?

That might make the whole parsing using for (i = 0; i < 
out->num_protocols; i++, cur++) simpler too ?

> +	out_size = sizeof(*out) + sizeof(u32) * (1 + (num_protocols - 1) / 4);
> +	out = calloc(1, out_size);
> +	if (!out)
> +		return -ENOMEM;
> +	msg.out_msg = (u8 *)out;
> +	msg.out_msg_sz = out_size;
> +
>   	buf = calloc(sizeof(u8), num_protocols);
> -	if (!buf)
> +	if (!buf) {
> +		free(out);
>   		return -ENOMEM;
> +	}
>   
>   	cur = 0;
>   	do {
>   		ret = devm_scmi_process_msg(dev, &msg);
>   		if (ret)
>   			goto err;
> -		if (out.status) {
> -			ret = scmi_to_linux_errno(out.status);
> +		if (out->status) {
> +			ret = scmi_to_linux_errno(out->status);
>   			goto err;
>   		}
>   
> -		for (i = 0; i < out.num_protocols; i++, cur++)
> -			buf[cur] = out.protocols[i / 4] >> ((i % 4) * 8);
> +		for (i = 0; i < out->num_protocols; i++, cur++)
> +			buf[cur] = out->protocols[i / 4] >> ((i % 4) * 8);
>   	} while (cur < num_protocols);
>   
>   	*protocols = buf;
> @@ -299,6 +308,7 @@ static int scmi_base_discover_list_protocols_int(struct udevice *dev,
>   	return num_protocols;
>   err:
>   	free(buf);
> +	free(out);
>   
>   	return ret;
>   }
> diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
> index 519b906b4ce..9046de7e3e7 100644
> --- a/include/scmi_protocols.h
> +++ b/include/scmi_protocols.h
> @@ -145,7 +145,7 @@ struct scmi_base_discover_impl_version_out {
>   struct scmi_base_discover_list_protocols_out {
>   	s32 status;
>   	u32 num_protocols;
> -	u32 protocols[3];
> +	u32 protocols[];
>   };
[...]
