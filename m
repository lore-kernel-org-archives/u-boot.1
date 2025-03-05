Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF41BC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 15:08:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35689808B6;
	Wed,  5 Mar 2025 16:07:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="fCISLBXC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3B0B80E94; Wed,  5 Mar 2025 16:07:56 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72E028083E
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 16:07:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1741187268; x=1741792068; i=xypron.glpk@gmx.de;
 bh=wLnWtofuj3TdRIqf5aFIIuhXHtc6op12EKeuOgH/1cI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=fCISLBXCXyi59OfMQ82jtZokPa49C7K2C+E0Gx2EZLFMiSOzb7qAZ78QipL5R/TZ
 +6X3Q9sp0XdOH4J4HglicTw7HtZm0DkLM3IW3+z7dpXzubAdkNqgPy4Ix06/5ZZ58
 54VxGZRucAAINmwsFi4YqZyVMj3tKqQuM7YwHxHMiVksvxpCkJTf1zkFfiUSnUBnt
 Q7jTfOr3q2wwl3fkTCnTbM9dbWNDwHLTdHLNpWX5tVWZ2LgWQS1Zf1us5/5cZ2qqg
 zfT61rrs1m30yzhZ5XrnRjgbIWTUl31gn0i+/E22bTJ2BN8AsCwmX9M86oUBWX+SJ
 5Gi2wBdNk42ifDFdCg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWici-1tj9JM01MW-00VS5r; Wed, 05
 Mar 2025 16:07:48 +0100
Message-ID: <cb301142-b76a-45ff-ace4-39e58d9a8de7@gmx.de>
Date: Wed, 5 Mar 2025 16:07:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] net: lwip: extend wget to support CA (root)
 certificates
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 u-boot@lists.denx.de
References: <20250305142650.2966738-1-jerome.forissier@linaro.org>
 <20250305142650.2966738-2-jerome.forissier@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250305142650.2966738-2-jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9DTCTnGks/r6bx1fwwr2Dfu6nmSms2TFp+VJn0Knbl3P+rzRFcJ
 Hh5p2ok64qOOi08urbjkgfkL/BEvfCcs5gaQGorRVWBr8t2bGZ4fi9eE0Rwc01OwbpNshlA
 a0bveQcSAXsdmi3gh3LljUcR4UCD+WeOOM4JqwTt5fWXpG7DEVqxZowfFp01hPbwhcA3w1u
 FAkCf5+Qj8oogyCpcpN7A==
UI-OutboundReport: notjunk:1;M01:P0:iFDMjZyVwJM=;E3EeiQaQ4m/E88m+Cvl05FlyrPS
 sAqCJaousEnV6kFVWdnMPfLUzEl1IJv4kIU+BLKqWERKRR16eZo8wd2bsYWmeVmNrbDWwB6qe
 tU9HTNHDdvqPG09hZRUMLygp1zZ46zbqVV6f13gqKrhTuvkEMYjHLZGWA/uvUXpvtYuHgzCid
 RE3Hb/uG2qzXwzBJJQsWE1zbT5QJOo2qt6l8OzmTFs0uADMIAV3Bd+vjvYlx8VcJh3aacs0R8
 Eh5WLB3GAqT14Ly4gn1pp+xoGp9hCd17Vh7pgxnO6Sd+xEK4ZSOe5VwHaLxmXYYyXXBxqu4tg
 B7Xu+n0riLu3MX9bk+4GAFEjAojEB7CYRUPM0YqvrjFeyQwd4fuCQ//AjMs4UTr79uJjNfme6
 XSIXJBUw905EUgfXCbuP6i287QZLLbEH8/lM+WorAkZbKGj2PEbNSEWs/suKAE0pDxyLvdnrA
 nJbkr2BcAM8T8XthnhCNksh9CNPUDN+aAoJPcYqH2qp87qUbCIdBl+5jgSuv3we9aGSBvD+hl
 EqUk9Ivw2g/vQD6MHuq+dp5CtjBdLF+4FMk4KbSHizV7cm3d+tvmxzcHzgf0/uMi4vkaoT8kK
 9+Xq4qusUCAq8kvbB+uH7p9ouptHbTPoUWz4nvXf5T0E8htDsfyEbBqT6Ce2ZjBs4AUKjdi/3
 BT57DwuLmvaJLyqXJ5IU+BuaID+XTwdBuFG8wDqwmWqbIW0RZLw9BcgKyfiZ4kztE24Ubpyhv
 D6OzyCEx4XdlBA1J9Jns5SAV4z/CdFj5fSaAqX+Ahh4P75TCike4itsWNBTmnGvWutWchevWq
 8g90FqrrVHq0yGo03cgRZkyJbZ7DJ4/stVyNgsQssVpG2VBGMxTcsCPNXs/Yzb+BNF+V1Ihmj
 RJQSfMRvxhdIIA/VuwdfoWd4tpktJ9/Rb7A1h+sFzZC68lUuvmkrdpJ5lASPgjB7iEA/B807t
 6b89AhrTLGZEkviC6BkpTan+BE+b7xPA/G4ZKpifTbthULxRv1cqI9+1SnjtTrcQGwkcZUckO
 XPCkZyN2UKPkGqpme4mUX9gdYzReKEU3i2iy+sAvV+h0GrMvt/4uPH3nerlCFUwPix3jyza4X
 gxsxZvRILdqoEINmoZqxwfum8qkZch/3EZ6EkfBTcH4ZPQXaUL+yXlT1WQaMOJ12KRtnfYRJ7
 Ynt4tSPPMcyrCQvr1UXiS8f+UGgOXaQ3uB2z+JgE6WcDJzKSFePSKrdehON42Bhod7LoTMbRD
 dksc+06yRoA7MlYwCR5IbXYmCitD6r/XXLUQAieTuAhzx7c1j7K2hoLFzKZK7uPNseZki7rDh
 tW3xUrgrGxFA9U9E7tMdjkt3YzeaSLvhxy0aW+O8dtH/R3NnHgFTugRFy5AvchqD6tI1G00LA
 8wF0iTZcHIJhlYNeTU3ThXXfRUXMy2Qvvgq04bfxvMjwO9H+PwVJx0cGVt
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

On 05.03.25 15:26, Jerome Forissier wrote:
> Add the "cacert" (Certification Authority certificates) subcommand to
> wget to pass root certificates to the code handling the HTTPS protocol.
> The subcommand is enabled by the WGET_CACERT Kconfig symbol.
>
> Usage example:
>
>   =3D> dhcp
>   # Download some root certificates (note: not authenticated!)
>   =3D> wget https://cacerts.digicert.com/DigiCertTLSECCP384RootG5.crt
>   # Provide root certificates
>   =3D> wget cacert $fileaddr $filesize
>   # Enforce verification (it is optional by default)
>   =3D> wget cacert required
>   # Forget the root certificates
>   =3D> wget cacert 0 0
>   # Disable verification
>   =3D> wget cacert none
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>   cmd/Kconfig     |   8 ++++
>   cmd/net-lwip.c  |  17 ++++++--
>   net/lwip/wget.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++--
>   3 files changed, 121 insertions(+), 6 deletions(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 8dd42571abc..d469217c0ea 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2177,6 +2177,14 @@ config WGET_HTTPS
>   	help
>   	  Enable TLS over http for wget.
>
> +config WGET_CACERT
> +	bool "wget cacert"
> +	depends on CMD_WGET
> +	depends on WGET_HTTPS
> +	help
> +	  Adds the "cacert" sub-command to wget to provide root certificates
> +	  to the HTTPS engine. Must be in DER format.
> +

Shouldn't we build CA certs into U-Boot?
Downloading certs from unsafe media is not a good replacement.

Best regards

Heinrich

>   endif  # if CMD_NET
>
>   config CMD_PXE
> diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
> index 0fd446ecb20..1152c94a6dc 100644
> --- a/cmd/net-lwip.c
> +++ b/cmd/net-lwip.c
> @@ -27,9 +27,20 @@ U_BOOT_CMD(dns, 3, 1, do_dns, "lookup the IP of a hos=
tname",
>   #endif
>
>   #if defined(CONFIG_CMD_WGET)
> -U_BOOT_CMD(wget, 3, 1, do_wget,
> -	   "boot image via network using HTTP/HTTPS protocol",
> +U_BOOT_CMD(wget, 4, 1, do_wget,
> +	   "boot image via network using HTTP/HTTPS protocol"
> +#if defined(CONFIG_WGET_CACERT)
> +	   "\nwget cacert - configure wget root certificates"
> +#endif
> +	   ,
>   	   "[loadAddress] url\n"
> -	   "wget [loadAddress] [host:]path"
> +	   "wget [loadAddress] [host:]path\n"
> +	   "    - load file"
> +#if defined(CONFIG_WGET_CACERT)
> +	   "\nwget cacert <address> <length>\n"
> +	   "    - provide CA certificates (0 0 to remove current)"
> +	   "\nwget cacert none|optional|required\n"
> +	   "    - set server certificate verification mode (default: optional)=
"
> +#endif
>   );
>   #endif
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index 14f27d42998..c22843ee10d 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -285,9 +285,68 @@ static err_t httpc_headers_done_cb(httpc_state_t *c=
onnection, void *arg, struct
>   	return ERR_OK;
>   }
>
> +#if CONFIG_IS_ENABLED(WGET_HTTPS)
> +enum auth_mode {
> +	AUTH_NONE,
> +	AUTH_OPTIONAL,
> +	AUTH_REQUIRED,
> +};
> +
> +static char *cacert;
> +static size_t cacert_size;
> +static enum auth_mode cacert_auth_mode =3D AUTH_OPTIONAL;
> +#endif
> +
> +#if CONFIG_IS_ENABLED(WGET_CACERT)
> +static int set_auth(enum auth_mode auth)
> +{
> +	cacert_auth_mode =3D auth;
> +
> +	return CMD_RET_SUCCESS;
> +}
> +
> +static int set_cacert(char * const saddr, char * const ssz)
> +{
> +	mbedtls_x509_crt crt;
> +	ulong addr, sz;
> +	int ret;
> +
> +	if (cacert)
> +		free(cacert);
> +
> +	addr =3D hextoul(saddr, NULL);
> +	sz =3D hextoul(ssz, NULL);
> +
> +	if (!addr) {
> +		cacert =3D NULL;
> +		cacert_size =3D 0;
> +		return CMD_RET_SUCCESS;
> +	}
> +
> +	cacert =3D malloc(sz);
> +	if (!cacert)
> +		return CMD_RET_FAILURE;
> +	cacert_size =3D sz;
> +
> +	memcpy(cacert, (void *)addr, sz);
> +
> +	mbedtls_x509_crt_init(&crt);
> +	ret =3D mbedtls_x509_crt_parse(&crt, cacert, cacert_size);
> +	if (ret) {
> +		printf("Could not parse certificates (%d)\n", ret);
> +		free(cacert);
> +		cacert =3D NULL;
> +		cacert_size =3D 0;
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	return CMD_RET_SUCCESS;
> +}
> +#endif
> +
>   static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>   {
> -#if defined CONFIG_WGET_HTTPS
> +#if CONFIG_IS_ENABLED(WGET_HTTPS)
>   	altcp_allocator_t tls_allocator;
>   #endif
>   	httpc_connection_t conn;
> @@ -312,11 +371,34 @@ static int wget_loop(struct udevice *udev, ulong d=
st_addr, char *uri)
>   		return -1;
>
>   	memset(&conn, 0, sizeof(conn));
> -#if defined CONFIG_WGET_HTTPS
> +#if CONFIG_IS_ENABLED(WGET_HTTPS)
>   	if (is_https) {
> +		char *ca =3D cacert;
> +		size_t ca_sz =3D cacert_size;
> +
> +		if (cacert_auth_mode =3D=3D AUTH_REQUIRED) {
> +			if (!ca || !ca_sz) {
> +				printf("Error: cacert authentication mode is "
> +				       "'required' but no CA certificates "
> +				       "given\n");
> +				return CMD_RET_FAILURE;
> +		       }
> +		} else if (cacert_auth_mode =3D=3D AUTH_NONE) {
> +			ca =3D NULL;
> +			ca_sz =3D 0;
> +		} else if (cacert_auth_mode =3D=3D AUTH_OPTIONAL) {
> +			/*
> +			 * Nothing to do, this is the default behavior of
> +			 * altcp_tls to check server certificates against CA
> +			 * certificates when the latter are provided and proceed
> +			 * with no verification if not.
> +			 */
> +		}
> +
>   		tls_allocator.alloc =3D &altcp_tls_alloc;
>   		tls_allocator.arg =3D
> -			altcp_tls_create_config_client(NULL, 0, ctx.server_name);
> +			altcp_tls_create_config_client(ca, ca_sz,
> +						       ctx.server_name);
>
>   		if (!tls_allocator.arg) {
>   			log_err("error: Cannot create a TLS connection\n");
> @@ -369,6 +451,20 @@ int do_wget(struct cmd_tbl *cmdtp, int flag, int ar=
gc, char * const argv[])
>   	ulong dst_addr;
>   	char nurl[1024];
>
> +#if CONFIG_IS_ENABLED(WGET_CACERT)
> +	if (argc =3D=3D 4 && !strncmp(argv[1], "cacert", strlen("cacert")))
> +		return set_cacert(argv[2], argv[3]);
> +	if (argc =3D=3D 3 && !strncmp(argv[1], "cacert", strlen("cacert"))) {
> +		if (!strncmp(argv[2], "none", strlen("none")))
> +			return set_auth(AUTH_NONE);
> +		if (!strncmp(argv[2], "optional", strlen("optional")))
> +			return set_auth(AUTH_OPTIONAL);
> +		if (!strncmp(argv[2], "required", strlen("required")))
> +			return set_auth(AUTH_REQUIRED);
> +		return CMD_RET_USAGE;
> +	}
> +#endif
> +
>   	if (argc < 2 || argc > 3)
>   		return CMD_RET_USAGE;
>

