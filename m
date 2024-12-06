Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A015CE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 11:31:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C43E38953A;
	Fri,  6 Dec 2024 12:31:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="RrPVPLTX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1B1E89579; Fri,  6 Dec 2024 12:31:00 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1A5F893A4
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 12:30:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1733484656; x=1734089456; i=xypron.glpk@gmx.de;
 bh=c0RZjQ/OoBv8trpW9QRBMnXHvvxgr88B0rkKANE6kQA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=RrPVPLTX8tgvgHIgfPusaCjHvzwE3FWwY8w+9wv/D6jMdVFlUqIrDep1dHKSHpsi
 XWfGxyWchLj0hKrLFLEe2BoJaNbuMwSb64uT8qUesETDlUzOgx1TsJR7YPjLF9/ql
 i9OTrxQE1wQm9RWlR0GQ3Y+/BDOcXZcY8WEXpal4jQDnYi7Gttr3wtt6xwt6urf65
 gOmuCLphyxRalteRpIeUpamB7YT8W/GxvfWdlJmSL4rsCARq/UlBR4ijd5H0ud0fJ
 8xqlh3tavl4UIMhMfeuVPKWnx6MmzcqNpb5qdJiouZARB2/fw4oYnpWhe2CFJvG7x
 Je6KlN5k+xc4Fy99/A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MplXz-1u0YWb0Hd7-00dNJr; Fri, 06
 Dec 2024 12:30:56 +0100
Message-ID: <cfe9bdda-59d2-4080-9f04-663c77fb0642@gmx.de>
Date: Fri, 6 Dec 2024 12:30:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mbedtls: remove MBEDTLS_HAVE_TIME
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>, Jerome Forissier
 <jerome.forissier@linaro.org>, Javier Tia <javier.tia@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
References: <20241206105647.2548249-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241206105647.2548249-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fmd+naIGHrpbf2ZApSLXVcFCfIcB/6Si+7uVhYFdnoGDvbsBcLe
 +2NLoamQqnVBHcIyvVwCuTQCXHtn6aQkYqSzisFMvL2+RSmwPv1VgP2pkxwJxmn5e/R+RLs
 sYWTHt1HSAPdYyxKvTEJf5wHwNHS5Dru3ranNHszY8IUEiSeR2LxyWnI2UKLHo7653Vrdya
 DQQH3minbiv2U96841m/A==
UI-OutboundReport: notjunk:1;M01:P0:h/QmMzl4zCE=;/rO7BIbr80JX5vxkqANVI0I/thS
 dve6x+aTpM13CVSmR2u9CfTdISDmYQQXGQZLipQAg/IipTbEj33qrvlxJcs5gDgQWsTDnT+6C
 ldB6dl2wxZYbe/wCVscxq1wpSVI+HEUFwoTcNpYnsH1x4VUI8aK+ZrolJ+o+4t6JwePvmwz6o
 MhcYC1HclqjWMmMPTSbc/dLO3+/C5WhkBV6IHOL7tjWcaySpcu/KQtg6zmHs/YNnsG1uJk8+8
 Y8oBuXzehHAyZ/grD/qPEWtng4lrK34Rflo4CBzGGjie9MB2OqwjliYAdOIU1X2eENrZnrFPu
 o8O6Ro1M6corGYMJ6xPE++1b4G1iEiiVTNyebAT8ux0nm5RW4DSb785asSoWeNtyke8vlYU6/
 bsDEAsnqV93bSk/HQXb0VnFFt8MTpuUjHGR5+iAOtOpzrFrAs6zN8zB//1x+bs93pJJDeXFXj
 pkN9IzbSwNNx6ASTc4ra1J7Rxf9rW/6YhwpHxGZslkDQc//oPga6LfV8+ndZR9lRGWKiw3+sZ
 QLYkzBrxZaplA6Ta40XnTlGAxI60zK8ROJCbzi04a7TVwcD8DA1RYdfEU6J7HjmOeiS4Z/uZW
 tFKpMYU5seVlEXsXdn9wmgx4t1PmlJRyEw9ilotLTSOnjXC1aixx/YeGHS1MiU/IfgvoSZV1e
 0DZLhTU45O1lhBIbZr/5rFXUz7HFIDOilq8gOtVAQ5cmj2dofEgjWDvQgoWhHN6khKOGkBEDr
 3z7WGWhVD4Ret/W8d6qCYRMpE7Rba3u6u8/BEs4ibZEAFOUH8a13Pdt26Epu4rVmawJhby6Gb
 xau8FEQEWys8UA3jVgAvfJZkr8pN21B0eCPmN8RpLV/K9QxgazVXDVswl7rDRcjoDgW6QnsSR
 xHLT9H5yHhtJZu2qSfwYeJbx0X3SO9LewsHJ6/UKiuHBzDHqTFUBAARgUk38d0Abyxrfx87nB
 8DiJXAsy58e/JGv4y00uFQyTJEkmYZYdLbo0HdG+EcenCjJjHMatvijwPuzLOgRIMdq1Pann2
 nUqK42hSO88wqy0GPKe3OFXH0Ny2y+Nv1zA5/S4I/o4KXbzlesqnqs10v97LQvNWTEVdGcE46
 L1XHVx3NhhZpN7RBYV6eEQktdbNzRK
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

On 12/6/24 11:56, Ilias Apalodimas wrote:
> When MbedTLS TLS features were added MBEDTLS_HAVE_TIME was defined as pa=
rt
> of enabling https:// support. However that pointed to the wrong function
> which could crash if it received a NULL pointer.
>
> Looking closer that function is not really needed, as it only seems to
> increase the RNG entropy by using 4b of the current time and date.
> The reason that was enabled is that lwIP was unconditionally requiring i=
t,
> although it's configurable and can be turned off.
>
> Since lwIP doesn't use that field anywhere else, make it conditional and
> disable it from our config.
>
> Fixes: commit a564f5094f62 ("mbedtls: Enable TLS 1.2 support")
> Reported-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

This removes a tiny bit of entropy.

For making https safe we need to invest into finding different entropy
sources. Besides the hardware rng this entropy could come from reading
get_ticks() in different code locations like after receiving a network
package.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c | 2 ++
>   lib/mbedtls/mbedtls_def_config.h                     | 3 ---
>   2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c b/lib/=
lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
> index 6643b05ee94d..46421588fef8 100644
> --- a/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
> +++ b/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
> @@ -692,7 +692,9 @@ altcp_tls_set_session(struct altcp_pcb *conn, struct=
 altcp_tls_session *session)
>     if (session && conn && conn->state) {
>       altcp_mbedtls_state_t *state =3D (altcp_mbedtls_state_t *)conn->st=
ate;
>       int ret =3D -1;
> +#ifdef MBEDTLS_HAVE_TIME
>       if (session->data.MBEDTLS_PRIVATE(start))
> +#endif
>         ret =3D mbedtls_ssl_set_session(&state->ssl_context, &session->d=
ata);
>       return ret < 0 ? ERR_VAL : ERR_OK;
>     }
> diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_=
config.h
> index d27f017d0847..1d2314e90e4d 100644
> --- a/lib/mbedtls/mbedtls_def_config.h
> +++ b/lib/mbedtls/mbedtls_def_config.h
> @@ -92,9 +92,6 @@
>
>   /* Generic options */
>   #define MBEDTLS_ENTROPY_HARDWARE_ALT
> -#define MBEDTLS_HAVE_TIME
> -#define MBEDTLS_PLATFORM_MS_TIME_ALT
> -#define MBEDTLS_PLATFORM_TIME_MACRO rtc_mktime
>   #define MBEDTLS_PLATFORM_C
>   #define MBEDTLS_SSL_CLI_C
>   #define MBEDTLS_SSL_TLS_C

