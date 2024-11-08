Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B5CD5C0FF
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 16:19:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C52788AAC;
	Fri,  8 Nov 2024 17:19:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="sz6qC4pN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8877D8900E; Fri,  8 Nov 2024 17:19:43 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94EC788278
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 17:19:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731082777; x=1731687577; i=xypron.glpk@gmx.de;
 bh=nkGrqdRDh7Y3fQfwlsTMWmigdcRsGSp/Z8r9fwUOYXw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=sz6qC4pNQvaJe00icDjpFvKYrHyfEzNWI1t3Iy3JzG6AKltRLFPDJu+HPxW9vedq
 xy+jbf7xoP6ktyhuxwiSCEzz8xiHotgtixJDvYCZuXisAoWpZhr93jE9mfceiGKUj
 0VHk1RI3FcDRxQ28YGs1Oa7z56qCtXT0WnQ9iFuiZfX5KiZFJrebS+uU8T6VxDQOW
 2/3KhYC8i6d3RV/cWzRVm6w+17ipt0yeFhy389ar19Tvn0RZ8UgfwskMow+rGLOeU
 Sg3/vWwKlNqwhJVP9PyrTEk56V2Dx2gj4Uarl1ktFWsHSvQQAoJCfRU/lGW6TdyBV
 CLB5brMkIrk7CDn+jg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MacOQ-1tg1Mx1PD8-00a9yZ; Fri, 08
 Nov 2024 17:19:37 +0100
Message-ID: <1c676e33-f171-41e7-9ccd-1e77a01fe472@gmx.de>
Date: Fri, 8 Nov 2024 17:19:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/15] net: net_utils: Move ip_to_string to
 lib/net_utils.c
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de
References: <20241108133850.431075-1-adrianox@gmail.com>
 <20241108133850.431075-2-adrianox@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241108133850.431075-2-adrianox@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l8QzqKj4ninQYnYf2EzO3IcznYsdDh7rX/RQbdVRLM19QhulFXm
 WhFs9/s9QPxUWmo63wmD5l2DUOl2JYq6k3JT6byiGoT72YStsizzFiR++Gqxr/Y+aMvCnrI
 lz8QWOQEMU/xe+R3u9zYWz66Milc6jB+Ty2+wYhXh9L8vzT9pUEVFJNvGsmobQ5bOiWb1Cz
 u4OSXfGcG/gkufzG7ptvg==
UI-OutboundReport: notjunk:1;M01:P0:J8emNehs6ZA=;5yLbfBm+Zs9HFxOrIv/e30FlBye
 iIqSFkjly25PCyvXk3j6FgShLP34RJEoeWphPOLedgUhzR/bDwfCQN9j4bENdr96vZKNxujUb
 mBDu33ScXKnjzs0yw5/hnFtqLlM7Xk2/sX5JIL44fQnUCNqTg8Ka2w8fJ3KrCLyJD8FyYXKZx
 3BiZX1+3xCEtiyNxnx+XjO9PBmSkCLnY8a6Rq+7PfaE45b5H5S8KvhUrvVXzDFvHaTDreGMqJ
 +Lo23ti8WcDbdB4ufag1obdRqq9594nGQBhcaUjFNmYD5DlufDd2UT34AEgEj5MtS3roHfQgW
 4y2z59XoZ8NAVSscEzwzH3obEYuhRigC6oX9EaoVuef2qH3/mjGaDIIudA4C2CdSdEk5h625A
 bDYKDVGcfNtU8K/KpRYwIyvYc+sVPrFuLt6Nkz3VewMAgYuZFPZzhtQtl86rEC/+ZWQXoS8de
 DAvwYKhtb4y876fxq9s4DbqFZQz2Bf+K6vqymxCt5N62k1nvQCCr54Rzu2teUXKVwrul4nvyt
 HrxpGzy/s8/NREga2UyPVdS1u1jY8M4OQ7+ps5AUqow73eo2d7vY+3UvFWmzAy4vvuJCEHr0Q
 B3mJSvLDJjUu6RAYrgfCnJxeRxZt7wbMlAHJRt891koLPT95y9UF2GrYW/n0Bxq/xB9KozFvL
 /upvppq6fCaA2lwpBEL7yofyTMPj2paSctnLdZL8cdyziYlxdy/nD6IubI7FgsFj2DTzMlqmm
 WR6ISy9IOonZbtCqAO8v7VQqGHrwkMuU521llNGGSGT9/eT0etWl5lZzeLdKm2wevGHm7b4x8
 fXKKArDW1WtspP+BImMCcqus97M+4WJilGg4vcJS1G78hjzwGV5WnxpUQ1Q/V4TaWnjrGUFtq
 Gji0k+EG599EVD2BKvVxtRcsZDAHhYrO9eWnL3s5q2PvUxEjFyoNX92aw
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

On 11/8/24 14:38, Adriano Cordova wrote:
> The function string_to_ip is already in net_utils, which is
> compiled unconditionally, but ip_to_string is currently only
> accessible if the legacy network stack is selected. This
> commit puts ip_to_string in net_utils.c and removes it from the
> legacy network code.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   include/net-common.h | 10 ++++++++++
>   lib/net_utils.c      | 11 +++++++++++
>   net/net.c            | 11 -----------
>   3 files changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/include/net-common.h b/include/net-common.h
> index 11c53766a3..5206b8346d 100644
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

