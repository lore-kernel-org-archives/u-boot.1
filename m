Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B36D68BF0
	for <u-boot@archiver.kernel.org>; Sat, 16 Nov 2024 21:12:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16A80892E5;
	Sat, 16 Nov 2024 22:12:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="TmcLft7w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E610589376; Sat, 16 Nov 2024 22:12:10 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6D5D88F4F
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 22:12:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731791523; x=1732396323; i=xypron.glpk@gmx.de;
 bh=dsLvrTHlG6zsdsqu3pNJm3bGWUikJQC5f8gT7BKe328=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=TmcLft7wK54wbT/R51Qvs3Le6VrrsVg8WDV54mHU/7lj/YTtsO83JiJp9rYAjeeE
 ohRcBmExUrBSUIuSawC2dK54G+7+1720/z9nGFgxtrj517DXBotGwQCK59N7M7aq1
 W3uZWbzT9+yae4MgqlNL5GFFyuNi6bgKhzJeITUE0PohCcdhiyhj88UUi0CafjlMT
 zfstitMdlDLUskD1NVt55nJX1PwcyPsaRYXZpYHHuvSAThAdwtfJyGXs+oY4TMpjl
 ejkbNQ5M/oQ0N4UXW3O2c9aQ6nooFTjsCJ5aZt024TRp6S3UpCKXY/7oIjIKmSeFO
 0F4kPRDwWJTj1TDaQg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MplXp-1tXEEw1pWv-00ojhb; Sat, 16
 Nov 2024 22:12:03 +0100
Message-ID: <eac8bbe6-8126-40c5-bab4-c4884e838f22@gmx.de>
Date: Sat, 16 Nov 2024 22:12:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/15] net: wget: let wget_with_dns work with dns
 disabled
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de
References: <20241111210959.560738-1-adrianox@gmail.com>
 <20241111210959.560738-3-adrianox@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241111210959.560738-3-adrianox@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tafLQleCBLTjK4iaeK0p5MG4Pnhgydgm/mfbO2S1/5YdHdFDnvQ
 LUQG+GxidmaplAT/Le/KrBnbBuNXVlTdxnyi9IOFvkOKCNrPwuNXEls97dBI9AA5+9UKFlD
 QMveZTb5b+P7+FZGqV+ha4PXEqE5GgJV8U4E9y5hRLy04R22BBZklMeL1idp1crQoO13vuR
 fZgs0Rlos+RO4hhJX1UnA==
UI-OutboundReport: notjunk:1;M01:P0:DDFmqQwaCBo=;y5j1ue2GspfiUHvM8IfcwNW7d2E
 ThZKBcupA/0KncRkAkGtbNYqLvOntVSC88PP8EzzNiqJBYWpwo/eVRmJx4sebsSXVBA562xZa
 K4EBGygyqvX8JnB//t8FV8yX2xy1jYBB9N+q/ibDIHEd01FNb1iTprQXoT9BwatNnDpYJ9Ny1
 uN8JGYKfK66DcrXlJiyH+kGnkP8WrnsMQ7eBac7B/q0WP2x7mYRopRIYIWkXPBNh0zQKVoab/
 QBIXDd3SU9CUBf9T7eDGBSE0YO0Fs7qYtvLM8RgNVYBXRxjs56C4pZ61ftvDHzTbZDabwGrJY
 WKjtg++5JbGirYbU8nJ1qc9OiOaZkb068etad9pt85ejgU3uCSbIdgLtuExoIuUeV8xcBW3GJ
 MB3NZpdHFdPUf5Wy4H2g9A4VIpRYCxvj5+H7lC5fQxzYYOFtNMh9Uyb8fdwH+DAf8cnbcMcoq
 Qkd4UUjS31MyZ1e+NLMn/4Ue73TLyRu4y3XGkBuTfDrTnEdsJ9tqN5UEyWa0TqavG6v91EHAJ
 9gR2bfcOV65sLDEfedujwWQqBErMMysgUz7to/Jo1nvi0OTCxtz9gOOnFOVkZWZVnRB+qe4zz
 qMyQGl9WTuCkCvF+6Oysul1SajbCW9jj23l7VdmkCvwFRrY19bru8Z4hii+h4ZIPvrCbtHjFX
 kz321aXlQNUSbGzvXlHfysLbeXMfnmXaDxG0QbF+0Jnn+NFDjwqs+oX7Yu0WC+tsgU+z1x4Eg
 2kQQ15ZBvA5uDoH+w/rhUrnNhgADqvIFlepC2TDYWSDEB+h6eav/WU/X4H2HCGjHMMSpMVq/O
 WmXgw5/t/302t6POKjs04lLwCr15ylI/kzzOLGTfw4m5mKrtFXCxXWDfZFN48d7FnrW+BDa0G
 rjaTLPtj2evKOvRMVgMrz3lEZSkjHMBY3NvsQ7OacZX8DAnH9EkDXZfuE
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
> This was marked as TODO in the code:
> -Enable use of wget_with_dns even if CMD_DNS is disabled if
> the given uri has the ip address for the http server.
> -Check for port in the uri when transforming to legacy wget
> syntax inside wget_with_dns.
> -Move the check for CMD_DNS inside wget_with_dns.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>
> (no changes since v2)
>
>   net/wget.c | 38 ++++++++++++++++++++++++--------------
>   1 file changed, 24 insertions(+), 14 deletions(-)
>
> diff --git a/net/wget.c b/net/wget.c
> index 3bc2522cde..36158e0a9c 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -530,12 +530,10 @@ void wget_start(void)
>   	wget_send(TCP_SYN, 0, 0, 0);
>   }
>
> -#if (IS_ENABLED(CONFIG_CMD_DNS))
>   int wget_with_dns(ulong dst_addr, char *uri)
>   {
>   	int ret;
> -	char *s, *host_name, *file_name, *str_copy;
> -
> +	char *s, *host_name, *file_name, *str_copy, *port;
>   	/*
>   	 * Download file using wget.
>   	 *
> @@ -556,18 +554,31 @@ int wget_with_dns(ulong dst_addr, char *uri)
>   	}
>   	file_name =3D s;
>
> -	/* TODO: If the given uri has ip address for the http server, skip dns=
 */
> -	net_dns_resolve =3D host_name;
> -	net_dns_env_var =3D "httpserverip";
> -	if (net_loop(DNS) < 0) {
> -		log_err("Error: dns lookup of %s failed, check setup\n", net_dns_reso=
lve);
> -		ret =3D -EINVAL;
> -		goto out;
> -	}
> -	s =3D env_get("httpserverip");
> -	if (!s) {
> +	port =3D host_name;
> +	host_name =3D strsep(&port, ":");
> +
> +	if (string_to_ip(host_name).s_addr !=3D 0) {

In U-Coot code we prefer to remove the '!=3D 0':

         if (string_to_ip(host_name).s_addr) {

> +		s =3D host_name;
> +	} else {
> +#if IS_ENABLED(CONFIG_CMD_DNS)
> +		net_dns_resolve =3D host_name;
> +		net_dns_env_var =3D "httpserverip";
> +		if (net_loop(DNS) < 0) {
> +			log_err("DNS lookup of %s failed, check setup\n", net_dns_resolve);
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
> +		s =3D env_get("httpserverip");
> +		if (!s) {
> +			log_err("DNS could not resolve %s\n", net_dns_resolve);

In EFI protocols we don't want any message output.

The wget command may write a message when receiving EINVAL.

> +			ret =3D -EINVAL;
> +			goto out;
> +		}
> +#else
> +		log_err("DNS disabled, %s could not be resolved\n", host_name);

ditto

Best regards

Heinrich

>   		ret =3D -EINVAL;
>   		goto out;
> +#endif
>   	}
>
>   	strlcpy(net_boot_file_name, s, sizeof(net_boot_file_name));
> @@ -581,7 +592,6 @@ out:
>
>   	return ret < 0 ? ret : 0;
>   }
> -#endif
>
>   /**
>    * wget_validate_uri() - validate the uri for wget

