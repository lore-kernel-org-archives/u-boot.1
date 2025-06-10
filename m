Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1E4C5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 09:00:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EFE882AFC;
	Tue, 10 Jun 2025 11:00:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="GzgZ3HiR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D60382B07; Tue, 10 Jun 2025 11:00:22 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7B7880C83
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 11:00:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 044AC3F675
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 09:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1749546019;
 bh=uWDi28NJ8Nn0EjsX4JiE1zdfGzOskGnCWl5DSg5ehfI=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=GzgZ3HiR9pSb9jaeeAADmhcFmspluyYX/+L/RGlruHTS2qLKjJYYWxg8d3d5BzDYi
 Q8NPzklGe0wR1G2T+REKqF9F0QVyD2rGFPTbboPbIBPO8DnNIt6f37YVLlv3Y1QH/K
 EFs266Seds1xo2tIRv710uD2fHc5+7T8/iVqEGnWcEvjJ5ilJ92zN7aCpu843nPsqY
 9FKHy9mmccvw90tsfFymELKL29pJ+jktTGjd9kGFPITs6j/y/69BykUVPx3bsRe8kU
 P68MieFjoeTBs60vWpV08sRRddIBAFsE1TH8Xa7onkJRNgUMsDFaFWucLBPHbhKjwV
 b9mLhlKD25c5g==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a3696a0d3aso2135620f8f.2
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 02:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749546018; x=1750150818;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uWDi28NJ8Nn0EjsX4JiE1zdfGzOskGnCWl5DSg5ehfI=;
 b=ONVx29jTQ411Z0TBibfLO9BTTNwZH+i62g2/1oSFZXLtv9M2haUX2qiCImgmdsUXbB
 7Q0Nd+ZrGjbHp+mahImANj3zqLKFrzBl6z9+/JeNnqCFKCi8m5KDaN3UYt5OniDr7Keo
 B7QSl0aLMcitHGGmcWGJ0BIy1S1kqgq0bLK/i7oUBn0tFNHXvfCVOnjBKrgViTl1tvW7
 dU70IadWyVcnLXQElv0ZHFZh0pM5NtJNzNOaB6P+R8at2Hy8kpOt4sOjnreprhzj5S1t
 Zy8ZSyykI45dXKWGEz2BFnpEjY32We2UAnktZeXZgP8f2nthnLuqdvnG8f971/ddU1u+
 GdLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTsZpRe7SVPGVva/Plr+rHFomeJ5T7IX7piV3l/geRjtJMRkqhIBO0Sc/OVy6CQQvPHdWWIYs=@lists.denx.de
X-Gm-Message-State: AOJu0YyxoI+kVbkEggxmBZ82qyCJN8lvc2duH2e7umlxAzU2n59Lwr2/
 jjutppRqlXWmD3GWq1fVmxYbObvMy79bOA2HRJfmApXB4bmbabDkpSSQ/Xocwm/h3/xAa9i1pjq
 GyUXW4CKDxQDGJO3jHoTo92t4YebH+rw9agff7PqUNmGjRcf3AIkvzt7PTdV3+bX3BkLb1hs=
X-Gm-Gg: ASbGncuFBGTfoX74rx+J/FQx2P5F1N4youlYYJ78/s+M2WJm60JxMHgvXatffWF/hhh
 eMQuDYInsIjZLdi732OmaEYerf56XoLof4BmOUwcH05V2BA5B5969/pVlj5JXmXXEm0ObneG+R8
 mb1yw7UPoHd7pW9bxb3gkQxX2f8IU5oY0g7mA1xX3hzd3enl59CBYXVLN6yYCF6/4W2ekSZbIZr
 6fmyy55FbIKgszvbjY3SGIhTle0jpxMtQtIvTD0dEXZ+Tc7nnoN7rjh3DClsRfpvPdEERgLLH52
 ZkGMDVdB0CATgOs2VP5xlEa46h6oeOmB4eckW/lP9FhsmM9iYLwIMqPeyUdljgGENVwVOhK6b+5
 on2UW6Nzn8/YIY2mZsX8=
X-Received: by 2002:a5d:64ed:0:b0:3a3:6a9a:5ebf with SMTP id
 ffacd0b85a97d-3a531cabb5cmr13012486f8f.20.1749546015782; 
 Tue, 10 Jun 2025 02:00:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF0lhezeAful1cUR++GOoVtSXuFEbWXb3Ssrmo7/Eg96SD8IhK93DwzUMXycircDss4fGK8A==
X-Received: by 2002:a5d:64ed:0:b0:3a3:6a9a:5ebf with SMTP id
 ffacd0b85a97d-3a531cabb5cmr13012450f8f.20.1749546015367; 
 Tue, 10 Jun 2025 02:00:15 -0700 (PDT)
Received: from [192.168.103.102]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53229d9e9sm11868558f8f.13.2025.06.10.02.00.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 02:00:14 -0700 (PDT)
Message-ID: <bb122e92-8191-478a-bcbd-b87011d87227@canonical.com>
Date: Tue, 10 Jun 2025 11:00:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] net: consolidate PXE processor architecture type
 Kconfig
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Vitor Soares <vitor.soares@toradex.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Casey Connolly <casey.connolly@linaro.org>, Bryan Brattlof <bb@ti.com>,
 u-boot@lists.denx.de
References: <20250608074228.12407-1-heinrich.schuchardt@canonical.com>
 <20250608074228.12407-4-heinrich.schuchardt@canonical.com>
 <CAC_iWj+7OuZ7ed0ZSD4zmk0TF5JieH26-oce7Ocf3cg22Fg1Sg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWj+7OuZ7ed0ZSD4zmk0TF5JieH26-oce7Ocf3cg22Fg1Sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10.06.25 09:16, Ilias Apalodimas wrote:
> Hi Heinrich
> 
> On Sun, 8 Jun 2025 at 10:42, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> DHCP and DHCPv6 use the same value defined in
>> https://www.iana.org/assignments/dhcpv6-parameters#processor-architecture
>> to encode the processor architecture type. We should only use a single
>> Kconfig symbol for both protocols.
>>
>> Furthermore we should make the value customizable. This allows for instance
>> to choose between "x86 BIOS" or "x64 UEFI".
>>
>> As "x86 BIOS" is encoded as 0, we should not use this value to switch
>> off transmission of the DHCP option. Use 0xFF instead.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   cmd/Kconfig  | 28 ++++++++++++++++------------
>>   net/bootp.c  |  6 +++---
>>   net/dhcpv6.c |  6 +++---
>>   3 files changed, 22 insertions(+), 18 deletions(-)
>>
>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>> index c335eceea63..4eb0140c10a 100644
>> --- a/cmd/Kconfig
>> +++ b/cmd/Kconfig
>> @@ -1864,12 +1864,6 @@ config CMD_DHCP6
>>
>>   if CMD_DHCP6
>>
>> -config DHCP6_PXE_CLIENTARCH
>> -       hex
>> -       default 0x16 if ARM64
>> -       default 0x15 if ARM
>> -       default 0xFF
>> -
>>   config DHCP6_PXE_DHCP_OPTION
>>          bool "Request & store 'pxe_configfile' from DHCP6 server"
>>
>> @@ -1977,12 +1971,22 @@ config BOOTP_PXE
>>          help
>>            Supported for ARM, ARM64, and x86 for now.
>>
>> -config BOOTP_PXE_CLIENTARCH
>> -       hex
>> -       depends on BOOTP_PXE
>> -       default 0x16 if ARM64
>> -       default 0x15 if ARM
>> -       default 0x0 if X86
>> +config DHCP_PXE_CLIENTARCH
>> +       hex "DCHCP client system architecture type"
> 
> DHCP ?

Thanks for pointing out the typo.

Best regards

Heinrich

> 
> Other than that
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> 
>> +       depends on BOOTP_PXE || CMD_DHCP6
>> +       default 0x16 if ARM64 # arm 64 uboot
>> +       default 0x15 if ARM   # arm 32 uboot
>> +       default 0x0 if X86    # x86 BIOS
>> +       default 0xFF          # DHCP option not sent
>> +       help
>> +         DHCP option 93 (defined in RFC4578) or DHCPv6 option 61 (defined in
>> +         RFC 5970) is used to transmit the client system architecture type
>> +         to the DHCP server. The DHCP server may use this information to
>> +         choose the boot file. For a complete list of assigned values see
>> +         https://www.iana.org/assignments/dhcpv6-parameters#processor-architecture.
>> +
>> +         If the value is set to the reserved value 0xFF, the DHCP option will
>> +         not be sent by U-Boot.
>>
>>   config BOOTP_PXE_DHCP_OPTION
>>          bool "Request & store 'pxe_configfile' from BOOTP/DHCP server"
>> diff --git a/net/bootp.c b/net/bootp.c
>> index f22921ed388..95d906e3b2d 100644
>> --- a/net/bootp.c
>> +++ b/net/bootp.c
>> @@ -545,14 +545,14 @@ static int dhcp_extended(u8 *e, int message_type, struct in_addr server_ip,
>>          }
>>   #endif
>>
>> -#ifdef CONFIG_BOOTP_PXE_CLIENTARCH
>> -       clientarch = CONFIG_BOOTP_PXE_CLIENTARCH;
>> +#ifdef CONFIG_DHCP_PXE_CLIENTARCH
>> +       clientarch = CONFIG_DHCP_PXE_CLIENTARCH;
>>   #endif
>>
>>          if (env_get("bootp_arch"))
>>                  clientarch = env_get_ulong("bootp_arch", 16, clientarch);
>>
>> -       if (clientarch > 0) {
>> +       if (clientarch != 0xff) {
>>                  *e++ = 93;      /* Client System Architecture */
>>                  *e++ = 2;
>>                  *e++ = (clientarch >> 8) & 0xff;
>> diff --git a/net/dhcpv6.c b/net/dhcpv6.c
>> index 0c2de75ba1d..5bf935cb6a3 100644
>> --- a/net/dhcpv6.c
>> +++ b/net/dhcpv6.c
>> @@ -128,7 +128,7 @@ static int dhcp6_add_option(int option_id, uchar *pkt)
>>                  break;
>>          case DHCP6_OPTION_CLIENT_ARCH_TYPE:
>>                  client_arch_opt = (struct dhcp6_option_client_arch *)dhcp_option_start;
>> -               client_arch_opt->arch_type[num_client_arch++] = htons(CONFIG_DHCP6_PXE_CLIENTARCH);
>> +               client_arch_opt->arch_type[num_client_arch++] = htons(CONFIG_DHCP_PXE_CLIENTARCH);
>>
>>                  opt_len = sizeof(__be16) * num_client_arch;
>>                  break;
>> @@ -194,7 +194,7 @@ static void dhcp6_send_solicit_packet(void)
>>          pkt += dhcp6_add_option(DHCP6_OPTION_ELAPSED_TIME, pkt);
>>          pkt += dhcp6_add_option(DHCP6_OPTION_IA_NA, pkt);
>>          pkt += dhcp6_add_option(DHCP6_OPTION_ORO, pkt);
>> -       if (CONFIG_DHCP6_PXE_CLIENTARCH != 0xFF)
>> +       if (CONFIG_DHCP_PXE_CLIENTARCH != 0xFF)
>>                  pkt += dhcp6_add_option(DHCP6_OPTION_CLIENT_ARCH_TYPE, pkt);
>>          pkt += dhcp6_add_option(DHCP6_OPTION_VENDOR_CLASS, pkt);
>>          pkt += dhcp6_add_option(DHCP6_OPTION_NII, pkt);
>> @@ -244,7 +244,7 @@ static void dhcp6_send_request_packet(void)
>>                  memcpy(pkt, sm_params.server_uid.uid_ptr, sm_params.server_uid.uid_size);
>>                  pkt += sm_params.server_uid.uid_size;
>>          }
>> -       if (CONFIG_DHCP6_PXE_CLIENTARCH != 0xFF)
>> +       if (CONFIG_DHCP_PXE_CLIENTARCH != 0xFF)
>>                  pkt += dhcp6_add_option(DHCP6_OPTION_CLIENT_ARCH_TYPE, pkt);
>>          pkt += dhcp6_add_option(DHCP6_OPTION_VENDOR_CLASS, pkt);
>>          pkt += dhcp6_add_option(DHCP6_OPTION_NII, pkt);
>> --
>> 2.48.1
>>

