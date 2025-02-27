Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F80C19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 16:39:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25FBE81250;
	Thu, 27 Feb 2025 17:39:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tLq9IzXW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C96B81253; Thu, 27 Feb 2025 17:39:04 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22891811D8
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 17:38:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-abb7520028bso147231366b.3
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 08:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740674338; x=1741279138; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=53j079xqf3WBu0lUBuFxt7H38rR/8UZDXhp4HIUZXEU=;
 b=tLq9IzXW5h42TJ0hdVF5jOujv3Hgf4CxOCi/9OWjfhR+v2zXtVM92YAw31mjdxZKWc
 O7YyEU37keboCfI7eloURBipKbRWzLNTVHvLhxakaJYjym+DanSsBC2LnbqlFRbS9uvt
 +//+oSNVkN6ovv/25POoTZTY8o/XRj+5dovFenHHUgsNnZQAcRSDbxX4IxlTpmiYI7xJ
 Kx1YpuXYT52lHGdmF+S7ZTInGzVI371/LQvUj/wkzU5KUwalSRUyG8QF3wYF0/ER1g6/
 uFFocCpN8qfhty++uLD5LdVlKkXVugrKtrmEWc5R2xk03SVuU9zo1gsyEUba2ZUg5NEB
 mv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740674338; x=1741279138;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=53j079xqf3WBu0lUBuFxt7H38rR/8UZDXhp4HIUZXEU=;
 b=bL68aawsR9O9npxWXjgvWcLYj/jBYjyiqQq+JI5/HKDAAK9BmbMetCmwa7t57YDTEI
 ECxK0PgSYHVVu2qXRCwug5KJTN7BqDbP6evXZbAl+U6fY/Yi9mmLdWvblqqFzDr1XMsQ
 bJbmD9mN1qxH5C84w/YRTUhJR5f7C51SNa3z3DQpyTkJaQN2mqKGTeoqPGtZhMwfEmAZ
 3hYApiSXyhFtkX2pxaYtSJutzU0YyZ/d179J5GlTA47V9Z2O47MZ2KxUqZV6wTgupW9E
 B2+Dz5fHKpS38Ahktu2+mI+j4g3nhMR6+lEmhZ61R11MyY4WLYIbokjXv/m38dAAvIAB
 icNQ==
X-Gm-Message-State: AOJu0YzYFlGK3varc77yTb779UntywgQZZoO7aOhfBzGwT3pwIqAvOyC
 u3WEKSaez0wV5T7snkF9ahv4MIQwy6yE9nCQTtPzusQA8wHQ5OYmeWZFG1JY7qsEngm4zrnv8md
 Rai8=
X-Gm-Gg: ASbGncvrPR7Wk+PEnZ27Xx84JioqIfwIeD/6S0WLw5/TUf/g0iFBeXIWbmOgJ/JlUrA
 OzvEXk3g0DdhEOYgybAH3pYWBwkb5ykW4nSPwCndVIrcbi8mZdKE0JqMujxUSkUq5MK2/aA5xnk
 Cc/f7VZtj1FH/rm8sIOYmLcUCG0/QnUWhCOGnIPwPGBo9cr3aTjcyPxoRK7w5oe0Nse6CG5GZ1c
 00dVGSTLCLO3aIsa2jyCDxb/HMuXSHl3UppMqpivEq0D1vrN5bSSZLxfSJy/aB5VYfMOEx6mLDt
 BM4M1N1KhyUAVl5QQI0c3Cy8vYGrJ4ecfW957W7ydtr3m8clhoB925fjvGPZXoK9JWSfknTtZDz
 pMbq3aA==
X-Google-Smtp-Source: AGHT+IGVIPfHDrJONOIKoBmjNSFBypOUFecrHzY34Z8DZmwcXDI2jsbcjTZ65HF3fTqstbM88ZSgBA==
X-Received: by 2002:a17:907:940f:b0:abe:ce46:6231 with SMTP id
 a640c23a62f3a-abf25fa9852mr12378766b.16.1740674338245; 
 Thu, 27 Feb 2025 08:38:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:a4a3:25fd:919c:f316?
 ([2a01:e0a:3cb:7bb0:a4a3:25fd:919c:f316])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c6ed6dbsm148685766b.94.2025.02.27.08.38.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 08:38:57 -0800 (PST)
Message-ID: <4f570bef-8409-4b82-ad6f-0e060901d7f4@linaro.org>
Date: Thu, 27 Feb 2025 17:38:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] net: lwip: add support for built-in root certificates
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>
References: <cover.1740672437.git.jerome.forissier@linaro.org>
 <fc96dd94cb39b60571b43ef80c5c89ff7999e94b.1740672437.git.jerome.forissier@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <fc96dd94cb39b60571b43ef80c5c89ff7999e94b.1740672437.git.jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Sorry for replying to myself, I spotted a small mistake.

On 2/27/25 17:09, Jerome Forissier wrote:
> Introduce Kconfig symbols WGET_BUILTIN_CACERT and
> WGET_BUILTIN_CACERT_PATH to provide root certificates at build time. The
> file may be a DER-encoded (.crt) or PEM-encoded (.pem) X509 collection
> of one or more certificates. PEM encoding needs MBEDTLS_LIB_X509_PEM.
> 
> Usage example:
> 
>  wget https://curl.se/ca/cacert.pem
>  make qemu_arm64_lwip_defconfig
>  echo CONFIG_WGET_BUILTIN_CACERT=y >>.config
>  echo CONFIG_WGET_BUILTIN_CACERT_PATH=cacert.pem >>.config
>  echo CONFIG_MBEDTLS_LIB_X509_PEM=y >>.config
>  make olddefconfig
>  make -j$(nproc) CROSS_COMPILE="ccache aarch64-linux-gnu-"
>  qemu-system-aarch64 -M virt -nographic -cpu max \
>     -object rng-random,id=rng0,filename=/dev/urandom \
>     -device virtio-rng-pci,rng=rng0 -bios u-boot.bin
>  => dhcp
>  # HTTPS transfer using the builtin CA certificates
>  => wget https://www.google.com/
>  18724 bytes transferred in 15 ms (1.2 MiB/s)
>  Bytes transferred = 18724 (4924 hex)
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  cmd/Kconfig       | 16 +++++++++++++-
>  cmd/net-lwip.c    |  4 ++++
>  net/lwip/Makefile |  6 ++++++
>  net/lwip/wget.c   | 53 +++++++++++++++++++++++++++++++++++++++--------
>  4 files changed, 69 insertions(+), 10 deletions(-)
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index a188a2ef24b..cb3cc859616 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2186,12 +2186,26 @@ config WGET_CACERT
>  	  to the HTTPS engine.
>  
>  config MBEDTLS_LIB_X509_PEM
> -	depends on WGET_CACERT
> +	depends on WGET_HTTPS
>  	bool "Support for PEM-encoded X509 certificates"
>  	help
>  	  This option enables MbedTLS to parse PEM-encoded X509 certificates.
>  	  When disabled, only DER format is accepted.
>  
> +config WGET_BUILTIN_CACERT
> +	bool "Built-in CA certificates"
> +	depends on WGET_HTTPS
> +
> +config WGET_BUILTIN_CACERT_PATH
> +	string "Path to root certificates"
> +	depends on WGET_BUILTIN_CACERT
> +	default "cacert.crt"
> +	help
> +	  Set this to the path to a DER- or PEM-encoded X509 file containing
> +	  Certification Authority certificates, a.k.a. root certificates, for
> +	  the purpose of authenticating HTTPS connections. Do not forget to
> +	  enable MBEDTLS_LIB_X509_PEM if the file is PEM.
> +
>  endif  # if CMD_NET
>  
>  config CMD_PXE
> diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
> index 0672f48a7a8..a848d0b1dcf 100644
> --- a/cmd/net-lwip.c
> +++ b/cmd/net-lwip.c
> @@ -39,6 +39,10 @@ U_BOOT_CMD(wget, 4, 1, do_wget,
>  #if defined(CONFIG_WGET_CACERT)
>  	   "\nwget cacert <address> <length>\n"
>  	   "    - provide CA certificates (0 0 to disable verification)"
> +#if defined(CONFIG_WGET_BUILTIN_CACERT)
> +	   "\nwget cacert builtin\n"
> +	   "    - use the builtin CA certificates"
> +#endif
>  #endif
>  );
>  #endif
> diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> index 79dd6b3fb50..950c5316bb9 100644
> --- a/net/lwip/Makefile
> +++ b/net/lwip/Makefile
> @@ -6,3 +6,9 @@ obj-$(CONFIG_CMD_DNS) += dns.o
>  obj-$(CONFIG_CMD_PING) += ping.o
>  obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
>  obj-$(CONFIG_WGET) += wget.o
> +
> +ifeq (y,$(CONFIG_WGET_BUILTIN_CACERT))
> +$(obj)/builtin_cacert.c: $(CONFIG_WGET_BUILTIN_CACERT_PATH:"%"=%) FORCE
> +	$(call if_changed,bin2c,builtin_cacert)
> +obj-y += builtin_cacert.o
> +endif
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index 14466598d7c..f24aa9c2380 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -288,31 +288,34 @@ static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct
>  #if defined CONFIG_WGET_HTTPS
>  static char *cacert;
>  size_t cacert_size;
> +
> +#if defined CONFIG_WGET_BUILTIN_CACERT
> +extern char builtin_cacert[];
> +extern const size_t builtin_cacert_size;
> +static bool cacert_initialized;
> +#endif
>  #endif
>  
> -#if defined CONFIG_WGET_CACERT
> -static int set_cacert(char * const saddr, char * const ssz)
> +#if defined CONFIG_WGET_CACERT || defined CONFIG_WGET_BUILTIN_CACERT
> +static int _set_cacert(void *addr, size_t sz)
>  {
>  	mbedtls_x509_crt crt;
> -	ulong addr, sz;
> +	void *p;
>  	int ret;
>  
>  	if (cacert)
>  		free(cacert);
>  
> -	addr = hextoul(saddr, NULL);
> -	sz = hextoul(ssz, NULL);
> -	sz++; /* For the trailing '\0' in case of a text (PEM) file */
> -
>  	if (!addr) {
>  		cacert = NULL;
>  		cacert_size = 0;
>  		return CMD_RET_SUCCESS;
>  	}
>  
> -	cacert = malloc(sz);
> -	if (!cacert)

HERE...

> +	p = malloc(sz);
> +	if (!p)
>  		return CMD_RET_FAILURE;
> +	cacert = p;
>  	cacert_size = sz;
>  
>  	memcpy(cacert, (void *)addr, sz - 1);
> @@ -328,10 +331,33 @@ static int set_cacert(char * const saddr, char * const ssz)
>  		return CMD_RET_FAILURE;
>  	}
>  
> +#if defined CONFIG_WGET_BUILTIN_CACERT
> +	cacert_initialized = true;
> +#endif
>  	return CMD_RET_SUCCESS;
>  }
> +
> +#if defined CONFIG_WGET_BUILTIN_CACERT
> +static int set_cacert_builtin(void)
> +{
> +	return _set_cacert(builtin_cacert, builtin_cacert_size);
> +}
>  #endif
>  
> +#if defined CONFIG_WGET_CACERT
> +static int set_cacert(char * const saddr, char * const ssz)
> +{
> +	ulong addr, sz;
> +
> +	addr = hextoul(saddr, NULL);
> +	sz = hextoul(ssz, NULL);
> +	sz++; /* For the trailing '\0' in case of a text (PEM) file */

This line should have been moved to _set_cacert() at the place I marked
"HERE" above.

The reason for this hack is, before even attempting to parse a file as
PEM format (which is text-based), mbedtls_x509_crt_parse() checks that
buf[buflen - 1] == '\0'. When a text file is obtained via wget there is
no null terminator. Same when using bin2c. So adding the '\0' is
necessary.

I decided to always add a null byte because it appears to not cause any
problem with binary (DER) files anyways.

> +
> +	return _set_cacert((void *)addr, sz);
> +}
> +#endif
> +#endif  /* CONFIG_WGET_CACERT || CONFIG_WGET_BUILTIN_CACERT */
> +
>  static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>  {
>  #if defined CONFIG_WGET_HTTPS
> @@ -361,6 +387,10 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>  	memset(&conn, 0, sizeof(conn));
>  #if defined CONFIG_WGET_HTTPS
>  	if (is_https) {
> +#if defined CONFIG_WGET_BUILTIN_CACERT
> +		if (!cacert_initialized)
> +			set_cacert_builtin();
> +#endif
>  		tls_allocator.alloc = &altcp_tls_alloc;
>  		tls_allocator.arg =
>  			altcp_tls_create_config_client(cacert, cacert_size,
> @@ -420,6 +450,11 @@ int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
>  #if defined CONFIG_WGET_CACERT
>  	if (argc == 4 && !strncmp(argv[1], "cacert", strlen("cacert")))
>  		return set_cacert(argv[2], argv[3]);
> +#if defined CONFIG_WGET_BUILTIN_CACERT
> +	if (argc == 3 && !strncmp(argv[1], "cacert", strlen("cacert")) &&
> +	    !strncmp(argv[2], "builtin", strlen("builtin")))
> +		return set_cacert_builtin();
> +#endif
>  #endif
>  
>  	if (argc < 2 || argc > 3)
