Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20A5D68BF6
	for <u-boot@archiver.kernel.org>; Sat, 16 Nov 2024 20:57:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D5F1896CE;
	Sat, 16 Nov 2024 21:57:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="hijXCXnG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D043896EB; Sat, 16 Nov 2024 21:57:07 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44A18896CE
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 21:57:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731790620; x=1732395420; i=xypron.glpk@gmx.de;
 bh=dt3VZQ4SfqttpXMKgWvZb/rz5/sJEKxcChpQcJJzsEQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=hijXCXnGNaYGGnEJ8ZyPK/yZIHxwOMl9gaXq7zemZ02aye5zeVN6+QqzNuTkUaLQ
 um7DinSBHme7s0TpqCss0UyQB9OnGFLaVb7GxxaCRyOVnsNPsVULEsqfxWSPPFBSd
 EKoEFrZe4qunXiRp6LlkBu/hqEVO8N8eDN9yNeS3rG1htfDV74dYOgVov2VwS8t4A
 15uZtHZYc2uZipKUg+k3aZscThEApn9GeOj9REHYuzfKIabSiDvrYALXzJknQ92cT
 64XgNz/T/mUfsxHUrl1c6IHOOQTppRyOccTcwKhQYJkao0nt37xZM8ysw+1JDweWQ
 9A/bmgbIR38kMMsZyg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7QxB-1totss3MFR-016PKW; Sat, 16
 Nov 2024 21:56:59 +0100
Message-ID: <6228efc9-a03e-4cfc-8e0c-14cc1aa5d4fe@gmx.de>
Date: Sat, 16 Nov 2024 21:56:59 +0100
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
X-Provags-ID: V03:K1:ruDM1+uQu9ZhnH7ForR8hnhUlafKl5o8UFAaMx3VX4m9n6LjTUm
 BOnq3VZd5LCV8B4qKvOQVfDw47tN9/+AI5C41PJ4pODZKL/yIZ7quTV4pII9LbEuhUCJ2zq
 DxGsOG8icjP7uqIYLpw4VTxQH1WThbuEkqblgRksXRlweRJ6DotyeohejUMO2RIEISbDm9W
 0+cVlpP1WbPX1S+ZIMplw==
UI-OutboundReport: notjunk:1;M01:P0:WGaFUbn02p4=;UWcSrsB5BsxDPNOQlWZmmHOEi9s
 S1XG4WmjdqrDmUwX1lZAXoCsfoa/bIiQceA5YElcZQLJgA3eu8Rfkqkds6Tb48/69691TWgE4
 iEj4L4f0kwHX5UpSHqZ/4kowDWo28ZjUaaGwOSwjpgII0PBAJAa4GDNTyWr3hMuaQNtfl+nyq
 n6QgL8AI4IyFy/1/CwTMR9FY9rDmlCoBm9dT+/ur3atW4w9dUpt5TWR8wrRj8nX5ijCG2nJYH
 w1XXHjdjmDEmp/EIpmauJWvtAt652y2H8rkd8lkOPIvu/yCR9Yax1mPw1Hshksy6arNRR+ZIU
 hWNrAdVFrbPvfLmMs6K1UNzKs6ji17/J0pbo5+KVePtj1/Tc5mRsvtQ2lciNqTj60rl66FEd9
 3y1/dDUTOMzKbKQBhF9wUfEIzzbqQMj6q5mf0wfmm9efUAg0uWLOYy+5pGgRUwZ3/hheMmoIZ
 HqY05dakKibUV9cdkEPxk6DzhW5rgpEu9GQt6SjXqONrDvIBUlmsVZDnDiM+AyDuB8HvzRTgj
 WMLL9D9EU14IHTwhySWGO7AHSjxHpYobLIYkk/a64zcnHNeYI+a/Rlnazj0yKYwhw08EEUIKh
 MSEfc760ztvEPk3KVdKMMdPmTKT3HGJblfWrouco08auaKwzgK7ssVolA5CRd9SMOJbJnBi7E
 9YyhV7HkQRPGyFOBIV98TJKcb8gnaxje76l9pWaDQtTmj816W/NT1HySf+SGc+5fayCYUirIu
 RSj/6yaYXXc4Xwchg/nPK7J9XFpYIOQpv16BHqBKqhXkpKVC/+V2ohq61kT+gSXusiZ5WELmt
 I39GoSfzG87DpBKcavu+QWXfwmiWJPnWDdCqmHlKilP+F4gj1RVnfysnb4tCsoOvIrIugAttL
 KmZE6IXyzON8ao7TtnMGHTciBD6k7R6Ulqi/8LHoS3A/Bu4s3opfPNxq3
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

