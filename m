Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902DDD68BF0
	for <u-boot@archiver.kernel.org>; Sat, 16 Nov 2024 21:04:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E811088BBE;
	Sat, 16 Nov 2024 22:04:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="YLfqdbG7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09AC68937E; Sat, 16 Nov 2024 22:04:46 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1223F889EF
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 22:04:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731791080; x=1732395880; i=xypron.glpk@gmx.de;
 bh=Ml+l4IcS0rTYQ9RkWTcSC67GeaKu9bcW9fn16I0m04o=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=YLfqdbG7PvGY3m47ExUvrwccnv4sSlj7Q1knCoSevZRk6s2AajkbXnhQMgYupmdi
 xz06BvAIlaOIWSaZ2Vz/EVDYgTaq+djjWOR8p1ezgvwKxfBwA4UKist7tDVJFitjj
 JoeYNOyAItfu0319Wcce9m3yit1ccJb7T/My4Dn0Fyjh7G4knuPXJZhpln+c9Dytr
 FoCnsiMcP+EYHwEEjgnBldKIg6Mm9kqnkXePZGs7dvbgzxNC/BR6aGsAZ455RJBOc
 /9JSlW8PjLth3ChMuH00gVlqAvB9BQWcrW3WjbKaOEeKKGm1HsMEdsltoA6/cHXL4
 WdbDTj6seaNqRJkG1w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAwbp-1t1AcT0xPl-008pkr; Sat, 16
 Nov 2024 22:04:40 +0100
Message-ID: <4b41bf3d-2ead-4371-b59e-dc7ae1b7b5e5@gmx.de>
Date: Sat, 16 Nov 2024 22:04:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/15] net: net_utils: Move ip_to_string to
 lib/net_utils.c
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de
References: <20241111210959.560738-1-adrianox@gmail.com>
 <20241111210959.560738-2-adrianox@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241111210959.560738-2-adrianox@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1iwWOY8QAbG6PR4mSPTdfkFmdkiMGoYnKyuM0hqmpjVNFI5SF+Q
 Kl8xQQUi8A4JWp2xWT0PbM5s0dK4T3bUq8KREBkOzH54E52/LPWR9ndvXVLMth/DPqrwpWg
 12aIit0UtClN6cN/cvLpq7V8ui/GoGGgLCFGTq0PttFGibT1+vG/h6EV10Hwa5z9Rmuqupk
 3elCu911LH0rYP4G+4Mhw==
UI-OutboundReport: notjunk:1;M01:P0:bU6TdlK7f0E=;3s7xSry6sHOptPHqvERm1lAxR4d
 XakRFTHZU72zrG/l2apu3h+4YQoSgLZsokJqGfszA6qdIxy4kKsWPi8dUDd0NymncZ3onAeQO
 c9fCFemnVzYdDoG2KhFyilksa3h7URNoxwBhiPtXPrVv+UUy7bJKGW3INXl3PD69RgBaG1/6J
 6HcUNhF3eeaRGCZqUxCwUY/MKFr8UThFQ6+nu0Xm1RO1GzZOP/c4r49LLjmd0YN4TzpN6aIg9
 GgwAaPL1mA6/1VO0i3Gon2sZEfghS1X34JkhOkmfLZCAPuyRBRqf1MuZn/JCfpDP7/vb6j8cc
 noa14NWRDk2lgfxLxlJcl1IxukGBcBybmnLW3JsNf9aqfg7+syjyPFpBjBZAJbxgwjonB5yG4
 7e8uUvfk053nrjNHm8NWMp1ydBeCAhDsXx/D9cJNEC9Lip4sPDXOSyZkGHTG4aPmQzdcFtYMc
 AHVONaBy9r/QC9hutm86GtzsRYbybw3jXiurYJPikU0EplpV4siUjwyDrZjJEBdtw+bOKIof4
 G6YEgM5k9Fk01YuMMqW/8i7bP7dR/Zk9aAxLgpHm6R69Irox6ZBamzurJwXF5dFtXz3pA1BBC
 +9DKucfEVWodXHRMQHs09kB012V+bRLxLHdcRSo6Yav+BBIjjRsd6j5P0S9BNe87O9yfHD658
 uXAOmtZp7qmfKbIRn+UYBJR/Uk4vwrFpghiLdiy/5hmppTbDp1OxdhPl7islSrYkfAALaRpDd
 JfkMIMYo9HuTRce40FGNPBbYIvuYJncFgpfgi9QksZ0KhXmB7zgwWGiJ3smYt7dCE0bLF4p9P
 qWVOkSnZKt0uEXuovrOtelH0xqZLKxj1eHlbhvG+XaPKpuIW9s/uS+y/C4xbYZK4qhkXasglm
 pszbc6o+gntMXbSbMPLRSAyrTwlWsjWnk/pBt7MeVUknr8wJzzSKhcwOV
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

On 11/11/24 22:09, Adriano Cordova wrote:
> The function string_to_ip is already in net_utils, which is
> compiled unconditionally, but ip_to_string is currently only
> accessible if the legacy network stack is selected. This
> commit puts ip_to_string in net_utils.c and removes it from the
> legacy network code.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>

If patches are unchanged, please, copy the Reviewed-by, Acked-by, and
Signed-off tags when resubmitting.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>
> (no changes since v2)
>
>   include/net-common.h | 10 ++++++++++
>   lib/net_utils.c      | 11 +++++++++++
>   net/net.c            | 11 -----------
>   3 files changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/include/net-common.h b/include/net-common.h
> index 3cd0f34374..b7a519e36d 100644
> --- a/include/net-common.h
> +++ b/include/net-common.h
> @@ -426,6 +426,16 @@ void string_to_enetaddr(const char *addr, uint8_t *=
enetaddr);
>    */
>   struct in_addr string_to_ip(const char *s);
>
> +/**
> + * ip_to_string() - Convert a string to ip address
> + *
> + * Implemented in lib/net_utils.c (built unconditionally)
> + *
> + * @x: Input ip to parse
> + * @s: string containing the parsed ip address
> + */
> +void ip_to_string(struct in_addr x, char *s);
> +
>   /* copy a filename (allow for "..." notation, limit length) */
>   void copy_filename(char *dst, const char *src, int size);
>
> diff --git a/lib/net_utils.c b/lib/net_utils.c
> index c70fef0d99..621f6512b6 100644
> --- a/lib/net_utils.c
> +++ b/lib/net_utils.c
> @@ -152,6 +152,17 @@ out_err:
>   }
>   #endif
>
> +void ip_to_string(struct in_addr x, char *s)
> +{
> +	x.s_addr =3D ntohl(x.s_addr);
> +	sprintf(s, "%d.%d.%d.%d",
> +		(int) ((x.s_addr >> 24) & 0xff),
> +		(int) ((x.s_addr >> 16) & 0xff),
> +		(int) ((x.s_addr >> 8) & 0xff),
> +		(int) ((x.s_addr >> 0) & 0xff)
> +	);
> +}
> +
>   void string_to_enetaddr(const char *addr, uint8_t *enetaddr)
>   {
>   	char *end;
> diff --git a/net/net.c b/net/net.c
> index f47e9fbe33..ca35704f66 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1723,17 +1723,6 @@ int net_parse_bootfile(struct in_addr *ipaddr, ch=
ar *filename, int max_len)
>   	return 1;
>   }
>
> -void ip_to_string(struct in_addr x, char *s)
> -{
> -	x.s_addr =3D ntohl(x.s_addr);
> -	sprintf(s, "%d.%d.%d.%d",
> -		(int) ((x.s_addr >> 24) & 0xff),
> -		(int) ((x.s_addr >> 16) & 0xff),
> -		(int) ((x.s_addr >> 8) & 0xff),
> -		(int) ((x.s_addr >> 0) & 0xff)
> -	);
> -}
> -
>   void vlan_to_string(ushort x, char *s)
>   {
>   	x =3D ntohs(x);

