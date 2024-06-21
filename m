Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA131C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 12:59:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E9EB87D10;
	Fri, 21 Jun 2024 14:59:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d4jvhkmw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 381B888405; Fri, 21 Jun 2024 14:59:52 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9E72879AF
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 14:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ec408c6d94so23793441fa.3
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 05:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718974789; x=1719579589; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kkzxGGvd+rgmhU8uATscXOmOld4Mhrv9F+Affnp0a7Q=;
 b=d4jvhkmwGl9M0vWApCwFbtqyVFDbCzeEf3VDIg74kCOOA3Obt+kXlFCEWn4F1OSH9I
 vxW2f7LaJVoiz9xy4CFlSAdGQk88EBQeOC5Z8Z6vF5w2ss8N9dRCGywu2n35E9Sj3Kk0
 CLJOkXDh87NkT7U6h6cGKITz6coOsi0H5ORbFZOFWZKBw+kVJ0/hf/cQaO6r4bzeDnS/
 k+RnmCm907onuONXFIrywru658/hg2MG/3uyMTPfGm6BQ4/6J+LfUPqMRYOcOe6uT5dR
 znIhHem10+nzVvD/bnKk002WRtY9CwlvM6/xs6IurKVEhjVc02yB9nfczREGF61OTY52
 eMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718974789; x=1719579589;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kkzxGGvd+rgmhU8uATscXOmOld4Mhrv9F+Affnp0a7Q=;
 b=kMkdCWHGJHnIHTK0JYPqA6gqdlbgKw4htMqJTN72oJLz2Xwt8IW5doJYswZEAv9Sg3
 WW+13gcWP2JAXEcfytFhgcxlFEXd3yV/cYmymMWQMl+Hjn6QNaU/sQ+P/MNdJ8zJ8UIC
 ZyIRONEIR/0yq1n4MH832mm+2MayfNvmk/hbAc/pO2iKkVUJvYj871hTWDEf92Y8v17t
 AccH4DZkSjTcaRxKCsTEAL9DsLuf8DyLH91YJGuCH5D8xKJqBtAhQKcb6m1xp8xbPGtE
 TsfzQj6+gymnjTV+sWIVO28FNWNgZ/bhTuhUDmtkLOhmyTrCYFgPE9lOP7c9ftAywjcH
 f9PQ==
X-Gm-Message-State: AOJu0YxqjbMN8wiGn66EPxBgqUKh7TE25/F2AER6eyWoLMxD6rBsNeEK
 JtSguSStrSrXJKGLmMYgKkc2ZYKgG0DNYabMbidzXLRgI0oC9eouHJob+Dx4HEaUk4zh1F0GkaD
 2SmE=
X-Google-Smtp-Source: AGHT+IGEjhX3ARZSHTiQwJfHoYrhhWjpJDaJFDcsQesX5kHVJQrZz5miqEBW8m4Z2u7qVCpPSdOs8Q==
X-Received: by 2002:a5d:5f8a:0:b0:364:3ba5:c5af with SMTP id
 ffacd0b85a97d-3643ba5cc94mr5844896f8f.61.1718974768360; 
 Fri, 21 Jun 2024 05:59:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:dbe1:6155:be06:e47d?
 ([2a01:e0a:3cb:7bb0:dbe1:6155:be06:e47d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a8c7499sm1701697f8f.90.2024.06.21.05.59.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jun 2024 05:59:28 -0700 (PDT)
Message-ID: <0db93742-f8d3-45b6-9d1e-e4f687c2d81a@linaro.org>
Date: Fri, 21 Jun 2024 14:59:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] Introduce the lwIP network stack
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>
References: <cover.1718638104.git.jerome.forissier@linaro.org>
 <CAJ+vNU0yGH6FKZsx+UZXvnQnsT13U9iKUb68=Fqc_z7J0XL14w@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAJ+vNU0yGH6FKZsx+UZXvnQnsT13U9iKUb68=Fqc_z7J0XL14w@mail.gmail.com>
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



On 6/20/24 19:10, Tim Harvey wrote:
> On Mon, Jun 17, 2024 at 8:33 AM Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
>> library for the network stack" [1]. The goal is to introduce the lwIP TCP/IP
>> stack [2] [3] as an alternative to the current implementation in net/,
>> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
>> reasons for doing so are:
>> - Make the support of HTTPS in the wget command easier. Javier T. (CC'd)
>> has some additional lwIP and Mbed TLS patches to do so. With that it
>> becomes possible to fetch and launch a distro installer such as Debian
>> etc. using a secure, authenticated connection directly from the U-Boot
>> shell. Several use cases:
>>   * Authentication: prevent MITM attack (third party replacing the
>> binary with a different one)
>>   * Confidentiality: prevent third parties from grabbing a copy of the
>> image as it is being downloaded
>>   * Allow connection to servers that do not support plain HTTP anymore
>> (this is becoming more and more common on the Internet these days)
>> - Possibly benefit from additional features implemented in lwIP
>> - Less code to maintain in U-Boot
>>
>> Prior to applying this series, the lwIP stack needs to be added as a
>> Git subtree with the following command:
>>
>>  $  git subtree add --squash --prefix lib/lwip/lwip https://git.savannah.gnu.org/git/lwip.git STABLE-2_2_0_RELEASE
>>
>> The first patch renames some enums in order to avoid a conflict when a
>> later patch enables the lwIP library.
>>
>> The second patch introduces a new Kconfig symbol: NET_LWIP, which selects
>> the lwIP implementation instead of the current one (NET). Contrary to the
>> approach chosen by Maxim in [1], NET_LWIP and NET cannot be enabled
>> simultaneously. The rationale is we want to start from a clean state and
>> not pull potentially duplicated functionality from both stacks. Note
>> however that a few files are still built in net/, they are the ones
>> related to ethernet device management and the ethernet bootflow.
>>
>> The third patch splits the net.h header into net-legacy.h, net-common.h,
>> net-lwip.h, leaving net.h as a simple wrapper.
>>
>> The fourth patch introduces the Makefile to build lwIP when NET_LWIP is
>> enabled.
>>
>> The subsequent patches implement various network-oriented commands and
>> features: dhcp, dns, ping, tftpboot, wget.
>>
>> A number of features are currently incompatible with NET_LWIP: SANDBOX,
>> DFU_TFTP, FASTBOOT, SPL_NET. All make assumptions on how the network
>> stack is implemented and/or pull sybols that are not trivially exported
>> from lwIP. Some interface rework may be needed.
>>
>> Due to the above and in order to provide some level of testing, a new QEMU
>> configuration is introduced (qemu_arm64_lwip_defconfig) which is the same
>> as qemu_arm64_defconfig but with NET_LWIP and CMD_*_LWIP enabled.
>> Tests are added to test/py/tests/test_net.py for that configuration.
>>
> 
> Hi Jermone,
> 
> I've given this a spin on an imx8mm-venice-gw73xx-0x via
> imx8mm_venice_defconfig and I can't get DHCP to work (didn't work in
> v3 either):
> 
> $ diff defconfig configs/imx8mm_venice_defconfig
> 68,69c68,71
> < CONFIG_CMD_DNS_LWIP=y
> < CONFIG_CMD_WGET_LWIP=y
> ---
>> CONFIG_CMD_DHCP6=y
>> CONFIG_CMD_TFTPPUT=y
>> CONFIG_SYS_DISABLE_AUTOLOAD=y
>> CONFIG_CMD_WGET=y
> 88,90c90,94
> < CONFIG_NET_LWIP=y
> < CONFIG_LWIP_DEBUG=y
> < CONFIG_LWIP_ASSERT=y
> ---
>> CONFIG_NET_RANDOM_ETHADDR=y
>> CONFIG_IP_DEFRAG=y
>> CONFIG_TFTP_BLOCKSIZE=4096
>> CONFIG_PROT_TCP_SACK=y
>> CONFIG_IPV6=y
> 
> Target:
> u-boot=> net list
> eth0 : ethernet@30be0000 00:d0:12:b5:f8:41 active
> u-boot=> dhcp || echo fail
> eth0: ethernet@30be0000 00:d0:12:b5:f8:41 active
> netif_set_ipaddr: netif address being changed
> netif: added interface 0 addr 192.168.1.1 netmask 0.0.0.0 gw 0.0.0.0
> etharp_request: sending ARP request.
> etharp_raw: sending raw ARP packet.
> ethernet_output: sending packet 000000007df00bf0
> dhcp_start(netif=000000007df2af40) 0dhcp_start(): mallocing new DHCP client
> dhcp_start(): allocated dhcp
> dhcp_start(): starting DHCP configuration
> dhcp_discover()
> transaction id xid(42021)
> dhcp_discover: making request
> dhcp_discover: sendto(DISCOVER, IP_ADDR_BROADCAST, LWIP_IANA_PORT_DHCP_SERVER)
> ip4_output_if: 0IP header:
> +-------------------------------+
> | 4 | 5 |  0x00 |       336     | (v, hl, tos, len)
> +-------------------------------+
> |        0      |000|       0   | (id, flags, offset)
> +-------------------------------+
> |  255  |   17  |    0xba9d     | (ttl, proto, chksum)
> +-------------------------------+
> |    0  |    0  |    0  |    0  | (src)
> +-------------------------------+
> |  255  |  255  |  255  |  255  | (dest)
> +-------------------------------+
> ip4_output_if: call netif->output()
> ethernet_output: sending packet 000000007df2c010
> dhcp_discover: deleting()
> dhcp_discover: SELECTING
> dhcp_discover(): set request timeout 2000 msecs
> ethernet_input: dest:ff:ff:ff:ff:ff:ff, src:28:28:5d:bb:16:9f, type:8899
> ethernet_input: dest:ff:ff:ff:ff:ff:ff, src:00:27:0e:0d:74:ba, type:806
> etharp_update_arp_entry: 172.24.20.24 - 00:27:0e:0d:74:ba
> etharp_find_entry: found empty entry 0
> etharp_find_entry: no empty entry found and not allowed to recycle
> etharp_input: incoming ARP request
> etharp_input: ARP request was not for us.
> ethernet_input: dest:ff:ff:ff:ff:ff:ff, src:98:90:96:ac:d7:63, type:806
> etharp_update_arp_entry: 172.24.20.3 - 98:90:96:ac:d7:63
> etharp_find_entry: found empty entry 0
> etharp_find_entry: no empty entry found and not allowed to recycle
> etharp_input: incoming ARP request
> etharp_input: ARP request was not for us.
> ethernet_input: dest:ff:ff:ff:ff:ff:ff, src:84:2b:2b:4e:5a:9a, type:806
> etharp_update_arp_entry: 172.24.0.1 - 84:2b:2b:4e:5a:9a
> etharp_find_entry: found empty entry 0
> etharp_find_entry: no empty entry found and not allowed to recycle
> etharp_input: incoming ARP request
> etharp_input: ARP request was not for us.
> ethernet_input: dest:ff:ff:ff:ff:ff:ff, src:cc:96:e5:1e:a0:7b, type:800
> ip_input: iphdr->dest 0xffff1fac netif->ip_addr 0x101a8c0 (0x0, 0x0, 0xffff1fac)
> ip4_input: UDP packet to DHCP client port 138
> ip4_input: packet not for us.

That's weird. I think what could happen is the interface already has
a static IP assigned when it is registered to the lwIP stack and thus
DHCP never receives the packed because it is dropped before.
I have reworked the initialization code in v5, lwIP will get to know
only one interface at a time and I make sure that interface is registered
without an IP address when doing DHCP. Hopefully that should fix the issue.

Thanks for testing!

-- 
Jerome

> 
> Best Regards,
> 
> Tim
