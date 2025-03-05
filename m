Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDDDC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 15:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0EE2808B6;
	Wed,  5 Mar 2025 16:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H5yfzHhE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9488B80F92; Wed,  5 Mar 2025 16:13:45 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 555468083E
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 16:13:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-390e3b3d432so4621314f8f.2
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 07:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741187621; x=1741792421; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lRqxkCY3uFXxQh70JxQxqeC6ApQftky1y3dBC8g1LHA=;
 b=H5yfzHhEv7KkZw2OXkODryl/95tUuvkfJzjbwAey2wBvfa8aaOTzk7g0fyVK06q/Gn
 9avbYzlCIxjmM6N0Q+MoFi1TY3yZ6bi5KVdQOElwUq4auAe7gIyC3jeFwoBvnsC0tgzJ
 cQAticgFn6tTCiQLy3Ktw2wTIBLy1WKX1P1VQFt2dMQoKPFM4hdIUP0ZvSjIvQC1+XIT
 9mb+0aSkM03iuQWFGhUFMslibV7fGirXF+7pDDI3KXnpiMStfCQN8pKGc4QteUpX+xJG
 WEeLpnRRPZM8LYqm7XNFiu3msGZfn+ZI3Gh7fsc4k/FLaMpwClRATbZMUHN72bYVTYWF
 k1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741187621; x=1741792421;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lRqxkCY3uFXxQh70JxQxqeC6ApQftky1y3dBC8g1LHA=;
 b=oJGIZ/K+UMNCKy67HVTbESc5/TIrRZlEZpm3h292gl7N0ucsxtG1NBYswYhBxmxbzv
 jw+9UJPmZ5XldBdFRUHVsGcUj04FbLk6PWweXUaK3p/XZUPkksSzheI3lLSNgIdSF5yr
 FtdI70soJUBFs0FAQNir5kl9swn7VXpAxD1P0EM7O2AiKDYLETkTJmhXOAH0gUmreLIN
 LD+dPsPIwKDyXhGk5o3IUcKGFwMLigzRpjb6Qjq/HTHMV534TnV0zNH0jQ2ma9giAUSR
 HE0ZsxCZnJI7eY9+vY2BqCrUD2x2wohMvrqGKzBOHgtD/slVe5JTUS/AyFWcOQoHrZvV
 T4AA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfs4/hX9UkBfFcxv2Z3efyZJImdDPel4Wk2o8f7KLB79kyED8011DycGV9LgqRI32LHRVy1VQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzQtEO7gBGSLR+7Gk2psh29haMQkFuJuPqfzLdInfp161pNBFyI
 gFfFjM8ezI4ybUkP9CN6WWi097/3mSSGZ9oDaqXLIJOCL1xQwGJS1PIFiXbTW3M=
X-Gm-Gg: ASbGncsu0qdx240anyw+lTaDBb4+O5MFqTqbw+9EQ2s7QIL533VyLCLuquaK3Ni9Q1a
 sffPFeO025PoPxjIAA61Hd2bItgzFNGVus304TVs37XChyQuN/V7lnPSInl9sz/A3TZ9kVCGKkv
 bCrRl6Yz89uOYFYkEWkBESGILQY2cwdQWGXAD+fs9stPlMBm+5zITKdphLiu6KbRShxiyG/b5Jd
 czldqaWJ/4fak7lDAdRXyGYUT25IlUDX7x6hgmMi7sTgXqz8ypday+ylwITRuDYQ0cnRXV6DUlv
 srBJrGq3SWtaVYx+o8gpj5q0Has0X74hikZKcaX0I96SfUzo6YszMqFak/7B6PTHR5eizhdP6ut
 268UqITcJ6TNwlwkaU+yuJkoe
X-Google-Smtp-Source: AGHT+IFZkKYcVGULm7fBxVnOUlXMOTO5QP2SE78d1OpYosm8XES5JprH/whvs/EGaARPibDqFl381Q==
X-Received: by 2002:a5d:47a2:0:b0:391:490:7acb with SMTP id
 ffacd0b85a97d-3911f72614dmr2792146f8f.2.1741187621011; 
 Wed, 05 Mar 2025 07:13:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:9358:6683:ed70:95ca?
 ([2a01:e0a:3cb:7bb0:9358:6683:ed70:95ca])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485db77sm20947777f8f.86.2025.03.05.07.13.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 07:13:40 -0800 (PST)
Message-ID: <26ec5905-e96a-4ff2-bdea-652eb9031ee3@linaro.org>
Date: Wed, 5 Mar 2025 16:13:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] net: lwip: extend wget to support CA (root)
 certificates
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 u-boot@lists.denx.de
References: <20250305142650.2966738-1-jerome.forissier@linaro.org>
 <20250305142650.2966738-2-jerome.forissier@linaro.org>
 <cb301142-b76a-45ff-ace4-39e58d9a8de7@gmx.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <cb301142-b76a-45ff-ace4-39e58d9a8de7@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Heinrich,

On 3/5/25 16:07, Heinrich Schuchardt wrote:
> On 05.03.25 15:26, Jerome Forissier wrote:
>> Add the "cacert" (Certification Authority certificates) subcommand to
>> wget to pass root certificates to the code handling the HTTPS protocol.
>> The subcommand is enabled by the WGET_CACERT Kconfig symbol.
>>
>> Usage example:
>>
>>   => dhcp
>>   # Download some root certificates (note: not authenticated!)
>>   => wget https://cacerts.digicert.com/DigiCertTLSECCP384RootG5.crt
>>   # Provide root certificates
>>   => wget cacert $fileaddr $filesize
>>   # Enforce verification (it is optional by default)
>>   => wget cacert required
>>   # Forget the root certificates
>>   => wget cacert 0 0
>>   # Disable verification
>>   => wget cacert none
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>   cmd/Kconfig     |   8 ++++
>>   cmd/net-lwip.c  |  17 ++++++--
>>   net/lwip/wget.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++--
>>   3 files changed, 121 insertions(+), 6 deletions(-)
>>
>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>> index 8dd42571abc..d469217c0ea 100644
>> --- a/cmd/Kconfig
>> +++ b/cmd/Kconfig
>> @@ -2177,6 +2177,14 @@ config WGET_HTTPS
>>       help
>>         Enable TLS over http for wget.
>>
>> +config WGET_CACERT
>> +    bool "wget cacert"
>> +    depends on CMD_WGET
>> +    depends on WGET_HTTPS
>> +    help
>> +      Adds the "cacert" sub-command to wget to provide root certificates
>> +      to the HTTPS engine. Must be in DER format.
>> +
> 
> Shouldn't we build CA certs into U-Boot?
> Downloading certs from unsafe media is not a good replacement.

That's the purpose of patch 4/6 [1]. Although downloading may still be a
valid option when used with hash verification as I mentioned in a reply to
Ilias in v1 [2].

[1] https://lists.denx.de/pipermail/u-boot/2025-March/582567.html
[2] https://lists.denx.de/pipermail/u-boot/2025-February/582102.html

Best,
-- 
Jerome

> 
> Best regards
> 
> Heinrich
> 
>>   endif  # if CMD_NET
>>
>>   config CMD_PXE
>> diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
>> index 0fd446ecb20..1152c94a6dc 100644
>> --- a/cmd/net-lwip.c
>> +++ b/cmd/net-lwip.c
>> @@ -27,9 +27,20 @@ U_BOOT_CMD(dns, 3, 1, do_dns, "lookup the IP of a hostname",
>>   #endif
>>
>>   #if defined(CONFIG_CMD_WGET)
>> -U_BOOT_CMD(wget, 3, 1, do_wget,
>> -       "boot image via network using HTTP/HTTPS protocol",
>> +U_BOOT_CMD(wget, 4, 1, do_wget,
>> +       "boot image via network using HTTP/HTTPS protocol"
>> +#if defined(CONFIG_WGET_CACERT)
>> +       "\nwget cacert - configure wget root certificates"
>> +#endif
>> +       ,
>>          "[loadAddress] url\n"
>> -       "wget [loadAddress] [host:]path"
>> +       "wget [loadAddress] [host:]path\n"
>> +       "    - load file"
>> +#if defined(CONFIG_WGET_CACERT)
>> +       "\nwget cacert <address> <length>\n"
>> +       "    - provide CA certificates (0 0 to remove current)"
>> +       "\nwget cacert none|optional|required\n"
>> +       "    - set server certificate verification mode (default: optional)"
>> +#endif
>>   );
>>   #endif
>> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
>> index 14f27d42998..c22843ee10d 100644
>> --- a/net/lwip/wget.c
>> +++ b/net/lwip/wget.c
>> @@ -285,9 +285,68 @@ static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct
>>       return ERR_OK;
>>   }
>>
>> +#if CONFIG_IS_ENABLED(WGET_HTTPS)
>> +enum auth_mode {
>> +    AUTH_NONE,
>> +    AUTH_OPTIONAL,
>> +    AUTH_REQUIRED,
>> +};
>> +
>> +static char *cacert;
>> +static size_t cacert_size;
>> +static enum auth_mode cacert_auth_mode = AUTH_OPTIONAL;
>> +#endif
>> +
>> +#if CONFIG_IS_ENABLED(WGET_CACERT)
>> +static int set_auth(enum auth_mode auth)
>> +{
>> +    cacert_auth_mode = auth;
>> +
>> +    return CMD_RET_SUCCESS;
>> +}
>> +
>> +static int set_cacert(char * const saddr, char * const ssz)
>> +{
>> +    mbedtls_x509_crt crt;
>> +    ulong addr, sz;
>> +    int ret;
>> +
>> +    if (cacert)
>> +        free(cacert);
>> +
>> +    addr = hextoul(saddr, NULL);
>> +    sz = hextoul(ssz, NULL);
>> +
>> +    if (!addr) {
>> +        cacert = NULL;
>> +        cacert_size = 0;
>> +        return CMD_RET_SUCCESS;
>> +    }
>> +
>> +    cacert = malloc(sz);
>> +    if (!cacert)
>> +        return CMD_RET_FAILURE;
>> +    cacert_size = sz;
>> +
>> +    memcpy(cacert, (void *)addr, sz);
>> +
>> +    mbedtls_x509_crt_init(&crt);
>> +    ret = mbedtls_x509_crt_parse(&crt, cacert, cacert_size);
>> +    if (ret) {
>> +        printf("Could not parse certificates (%d)\n", ret);
>> +        free(cacert);
>> +        cacert = NULL;
>> +        cacert_size = 0;
>> +        return CMD_RET_FAILURE;
>> +    }
>> +
>> +    return CMD_RET_SUCCESS;
>> +}
>> +#endif
>> +
>>   static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>>   {
>> -#if defined CONFIG_WGET_HTTPS
>> +#if CONFIG_IS_ENABLED(WGET_HTTPS)
>>       altcp_allocator_t tls_allocator;
>>   #endif
>>       httpc_connection_t conn;
>> @@ -312,11 +371,34 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>>           return -1;
>>
>>       memset(&conn, 0, sizeof(conn));
>> -#if defined CONFIG_WGET_HTTPS
>> +#if CONFIG_IS_ENABLED(WGET_HTTPS)
>>       if (is_https) {
>> +        char *ca = cacert;
>> +        size_t ca_sz = cacert_size;
>> +
>> +        if (cacert_auth_mode == AUTH_REQUIRED) {
>> +            if (!ca || !ca_sz) {
>> +                printf("Error: cacert authentication mode is "
>> +                       "'required' but no CA certificates "
>> +                       "given\n");
>> +                return CMD_RET_FAILURE;
>> +               }
>> +        } else if (cacert_auth_mode == AUTH_NONE) {
>> +            ca = NULL;
>> +            ca_sz = 0;
>> +        } else if (cacert_auth_mode == AUTH_OPTIONAL) {
>> +            /*
>> +             * Nothing to do, this is the default behavior of
>> +             * altcp_tls to check server certificates against CA
>> +             * certificates when the latter are provided and proceed
>> +             * with no verification if not.
>> +             */
>> +        }
>> +
>>           tls_allocator.alloc = &altcp_tls_alloc;
>>           tls_allocator.arg =
>> -            altcp_tls_create_config_client(NULL, 0, ctx.server_name);
>> +            altcp_tls_create_config_client(ca, ca_sz,
>> +                               ctx.server_name);
>>
>>           if (!tls_allocator.arg) {
>>               log_err("error: Cannot create a TLS connection\n");
>> @@ -369,6 +451,20 @@ int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
>>       ulong dst_addr;
>>       char nurl[1024];
>>
>> +#if CONFIG_IS_ENABLED(WGET_CACERT)
>> +    if (argc == 4 && !strncmp(argv[1], "cacert", strlen("cacert")))
>> +        return set_cacert(argv[2], argv[3]);
>> +    if (argc == 3 && !strncmp(argv[1], "cacert", strlen("cacert"))) {
>> +        if (!strncmp(argv[2], "none", strlen("none")))
>> +            return set_auth(AUTH_NONE);
>> +        if (!strncmp(argv[2], "optional", strlen("optional")))
>> +            return set_auth(AUTH_OPTIONAL);
>> +        if (!strncmp(argv[2], "required", strlen("required")))
>> +            return set_auth(AUTH_REQUIRED);
>> +        return CMD_RET_USAGE;
>> +    }
>> +#endif
>> +
>>       if (argc < 2 || argc > 3)
>>           return CMD_RET_USAGE;
>>
> 
