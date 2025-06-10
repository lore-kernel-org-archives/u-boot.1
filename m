Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56830C5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 07:17:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEC9B80C83;
	Tue, 10 Jun 2025 09:17:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rxVXL+h8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AE3082AC4; Tue, 10 Jun 2025 09:17:22 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 303A68070C
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 09:17:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-70e5599b795so51612907b3.3
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 00:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749539838; x=1750144638; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EomWytHNvmnJKOPKn41n+zfLGfUTS2oGaiuIJsqT5CY=;
 b=rxVXL+h8y80GNwCc6rRJsDRlY7nL+wzJ+9ybehhWvTrFAjnGKEuiqA5LXYj/Hdb+Tw
 PdsmPWIunusMdaHLqTlkKQ437THORtyiMpmUxF5R5/m0vLQoWSCXe87aDvO7Bn8U2QZ8
 PxG2UsA58Mh8rH8UVALNGC5Be8RlxapebuHdIHuIyzYovsqN1PycMkoRp27FzkfHelhw
 cn6kLRyimy3unyqSU6TcQB6+lKQh6dn8DIhO/sROms1PQaKiOoJCLR7L4lUiwA14uWD4
 n8CNYEHsOIb1q/31mR+Jmn+6Cbf1k6w+1TczuDn1pALThNMYsrnwC1+p05RUvcv7e0he
 54bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749539838; x=1750144638;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EomWytHNvmnJKOPKn41n+zfLGfUTS2oGaiuIJsqT5CY=;
 b=CtOfeBTqPaL80Ww041kD//m6Wx/wRkZM3mSF4DF5783y8zjP3/oFS2N/vvubVjoRRb
 L+L84i0GGD1hM7UaAslDwxlA1obyrAKsgQ9zf2oS5O9l4K3Yfw5EpkpLC1+YyK9qISYd
 CEGnrZKTzwl7D+Iq7PBK7MIQU5DU2ndHv1kjASSObR7i0ZtJXlfQvjnXB720WvpYYKoi
 AXWHA367YhUdWYOWIZB7ddMlyBmQl1Q+oTxsoQOAtJZml8Wx1y7uwbFGmSTuZbcssl9Q
 25UMBC6JVp/TR+uH7v9W7BzNTLmeXhMV5xkYC/2mQcg6lfYt8N4pRulteK/B+dIgmNxl
 ClOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8ZT1ZJ1jj1U/Mx2vnPsYcXkgv6slq9xxvSqw0n2BPiG0+1L6mJYfhj0XAzIYd+5peeRINxSE=@lists.denx.de
X-Gm-Message-State: AOJu0YzuIqw/EYmwjXjUfZeH1QhkTGKt+wLmpEPrVt3lr53xwxj7N93m
 Bgs+wdW6zbug7ApHMb2/ssLAq7Q0CkzdvTH2vk0Bj39dRtMrhnqP1kxLetokhT6WaHxT2RQ/kw7
 ytU9EcAhIKUvUVPisNpfgZk9mF+loLBF5Vk/IZJwf8A==
X-Gm-Gg: ASbGncvHErATdAC7qMcC4DeECE/Cyg/VJctZKy+pMBwoVhobVdnB8OqTgtpv7ksarh/
 TV2eYiXk093acnmVpvPRTaynntWMMciAMTFrtIKOl6mLVMyUwpoheIUkXY8iIJ8ox3yPFoosE2h
 Z1/131nh9PnlpKEkNuz09HfKLy3zcgqOl1/DpATItkXWzb
X-Google-Smtp-Source: AGHT+IE8nh+mVp9XClD9P7BU8j2i/auiilE6ra1ZWYkAotp0klfdlDs4Gisv+QE4I76ErC8sN+w7UdTW6T4qnHnwdE8=
X-Received: by 2002:a05:690c:620a:b0:6fb:a696:b23b with SMTP id
 00721157ae682-71136747979mr18385217b3.33.1749539838024; Tue, 10 Jun 2025
 00:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250608074228.12407-1-heinrich.schuchardt@canonical.com>
 <20250608074228.12407-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250608074228.12407-4-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 10 Jun 2025 10:16:42 +0300
X-Gm-Features: AX0GCFsPS_Jk-_HtgCvRklq7tfskMAQFDQIUGfxBRcK8zm7viaMRwwTmQQPzlpg
Message-ID: <CAC_iWj+7OuZ7ed0ZSD4zmk0TF5JieH26-oce7Ocf3cg22Fg1Sg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] net: consolidate PXE processor architecture type
 Kconfig
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, 
 Michal Simek <michal.simek@amd.com>,
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Vitor Soares <vitor.soares@toradex.com>, Sean Edmond <seanedmond@microsoft.com>,
 Casey Connolly <casey.connolly@linaro.org>, Bryan Brattlof <bb@ti.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich

On Sun, 8 Jun 2025 at 10:42, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> DHCP and DHCPv6 use the same value defined in
> https://www.iana.org/assignments/dhcpv6-parameters#processor-architecture
> to encode the processor architecture type. We should only use a single
> Kconfig symbol for both protocols.
>
> Furthermore we should make the value customizable. This allows for instance
> to choose between "x86 BIOS" or "x64 UEFI".
>
> As "x86 BIOS" is encoded as 0, we should not use this value to switch
> off transmission of the DHCP option. Use 0xFF instead.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/Kconfig  | 28 ++++++++++++++++------------
>  net/bootp.c  |  6 +++---
>  net/dhcpv6.c |  6 +++---
>  3 files changed, 22 insertions(+), 18 deletions(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index c335eceea63..4eb0140c10a 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1864,12 +1864,6 @@ config CMD_DHCP6
>
>  if CMD_DHCP6
>
> -config DHCP6_PXE_CLIENTARCH
> -       hex
> -       default 0x16 if ARM64
> -       default 0x15 if ARM
> -       default 0xFF
> -
>  config DHCP6_PXE_DHCP_OPTION
>         bool "Request & store 'pxe_configfile' from DHCP6 server"
>
> @@ -1977,12 +1971,22 @@ config BOOTP_PXE
>         help
>           Supported for ARM, ARM64, and x86 for now.
>
> -config BOOTP_PXE_CLIENTARCH
> -       hex
> -       depends on BOOTP_PXE
> -       default 0x16 if ARM64
> -       default 0x15 if ARM
> -       default 0x0 if X86
> +config DHCP_PXE_CLIENTARCH
> +       hex "DCHCP client system architecture type"

DHCP ?

Other than that
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> +       depends on BOOTP_PXE || CMD_DHCP6
> +       default 0x16 if ARM64 # arm 64 uboot
> +       default 0x15 if ARM   # arm 32 uboot
> +       default 0x0 if X86    # x86 BIOS
> +       default 0xFF          # DHCP option not sent
> +       help
> +         DHCP option 93 (defined in RFC4578) or DHCPv6 option 61 (defined in
> +         RFC 5970) is used to transmit the client system architecture type
> +         to the DHCP server. The DHCP server may use this information to
> +         choose the boot file. For a complete list of assigned values see
> +         https://www.iana.org/assignments/dhcpv6-parameters#processor-architecture.
> +
> +         If the value is set to the reserved value 0xFF, the DHCP option will
> +         not be sent by U-Boot.
>
>  config BOOTP_PXE_DHCP_OPTION
>         bool "Request & store 'pxe_configfile' from BOOTP/DHCP server"
> diff --git a/net/bootp.c b/net/bootp.c
> index f22921ed388..95d906e3b2d 100644
> --- a/net/bootp.c
> +++ b/net/bootp.c
> @@ -545,14 +545,14 @@ static int dhcp_extended(u8 *e, int message_type, struct in_addr server_ip,
>         }
>  #endif
>
> -#ifdef CONFIG_BOOTP_PXE_CLIENTARCH
> -       clientarch = CONFIG_BOOTP_PXE_CLIENTARCH;
> +#ifdef CONFIG_DHCP_PXE_CLIENTARCH
> +       clientarch = CONFIG_DHCP_PXE_CLIENTARCH;
>  #endif
>
>         if (env_get("bootp_arch"))
>                 clientarch = env_get_ulong("bootp_arch", 16, clientarch);
>
> -       if (clientarch > 0) {
> +       if (clientarch != 0xff) {
>                 *e++ = 93;      /* Client System Architecture */
>                 *e++ = 2;
>                 *e++ = (clientarch >> 8) & 0xff;
> diff --git a/net/dhcpv6.c b/net/dhcpv6.c
> index 0c2de75ba1d..5bf935cb6a3 100644
> --- a/net/dhcpv6.c
> +++ b/net/dhcpv6.c
> @@ -128,7 +128,7 @@ static int dhcp6_add_option(int option_id, uchar *pkt)
>                 break;
>         case DHCP6_OPTION_CLIENT_ARCH_TYPE:
>                 client_arch_opt = (struct dhcp6_option_client_arch *)dhcp_option_start;
> -               client_arch_opt->arch_type[num_client_arch++] = htons(CONFIG_DHCP6_PXE_CLIENTARCH);
> +               client_arch_opt->arch_type[num_client_arch++] = htons(CONFIG_DHCP_PXE_CLIENTARCH);
>
>                 opt_len = sizeof(__be16) * num_client_arch;
>                 break;
> @@ -194,7 +194,7 @@ static void dhcp6_send_solicit_packet(void)
>         pkt += dhcp6_add_option(DHCP6_OPTION_ELAPSED_TIME, pkt);
>         pkt += dhcp6_add_option(DHCP6_OPTION_IA_NA, pkt);
>         pkt += dhcp6_add_option(DHCP6_OPTION_ORO, pkt);
> -       if (CONFIG_DHCP6_PXE_CLIENTARCH != 0xFF)
> +       if (CONFIG_DHCP_PXE_CLIENTARCH != 0xFF)
>                 pkt += dhcp6_add_option(DHCP6_OPTION_CLIENT_ARCH_TYPE, pkt);
>         pkt += dhcp6_add_option(DHCP6_OPTION_VENDOR_CLASS, pkt);
>         pkt += dhcp6_add_option(DHCP6_OPTION_NII, pkt);
> @@ -244,7 +244,7 @@ static void dhcp6_send_request_packet(void)
>                 memcpy(pkt, sm_params.server_uid.uid_ptr, sm_params.server_uid.uid_size);
>                 pkt += sm_params.server_uid.uid_size;
>         }
> -       if (CONFIG_DHCP6_PXE_CLIENTARCH != 0xFF)
> +       if (CONFIG_DHCP_PXE_CLIENTARCH != 0xFF)
>                 pkt += dhcp6_add_option(DHCP6_OPTION_CLIENT_ARCH_TYPE, pkt);
>         pkt += dhcp6_add_option(DHCP6_OPTION_VENDOR_CLASS, pkt);
>         pkt += dhcp6_add_option(DHCP6_OPTION_NII, pkt);
> --
> 2.48.1
>
