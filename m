Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A6FC27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 17:10:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2367F8853B;
	Thu, 20 Jun 2024 19:10:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="IKJTKwjV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82A4388549; Thu, 20 Jun 2024 19:10:26 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D40A488537
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 19:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57cc1c00b97so1052530a12.0
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 10:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1718903423; x=1719508223; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2DaX+zUMxnVdVwGzsihJ+pb2yqGyMNxw1Yik5Umrch4=;
 b=IKJTKwjVqiTKdgSnUcRw8r162++Ch/LK5a1msEULqx6nwYO6F5fNelC2WohTUDD+uE
 rdyTOB/LurMHEfXIGsE10vTiaM8ia/Vx7dp6boSenT+QTTMV+n/oC62P66AAhSpVX9qY
 S2SpgV2h9GXLkU7dX2kd8FnAaOUgN7LaAGYe00f9zXYCvtO1c0fqG8sBeWCvLiB/cdm8
 vLq95QkUlhDwiqP/p9dT6UOCwzOFXO0vVEIvqIELfyzw0q8Rp1CBTd1z0MQM3E8WNO61
 wwZPip/m+0H4ZwPpTFmcCI8d4kvHnOhAgqI12W35M8tHi6155BMeWSlGLISAMvt0TDGd
 ASKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718903423; x=1719508223;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2DaX+zUMxnVdVwGzsihJ+pb2yqGyMNxw1Yik5Umrch4=;
 b=OvxckcTt0+/d/vx+Y/Vb4WC8TD1XzGz1WE4SgC9mu8yGf0pQnGPvNIhlWUIb/11tAn
 fs/73huCL7BQLpZ6oPYVLhWpaQYzEyJ1DyYHowhyl/Is2MebRujD8AYySO28IMuG9QI2
 0Dm6c0ESP+4Iggwdb2gbnXEGrFP3ix8O/3yQmsK+4eRDYtRoFBLi1lYFQ8AZ/RDl9ydw
 5KkxRmmObIs+1IG+Embp47rVdi+Qst4qzPJtVvDL3ZAt7Ohg/9WMEFO11Uj3T94uaFYK
 HZoAHe4KA37AC2XgGZqDPv5o1QtNWn0WryfCSKh36joxLFPsbTxym59xsttds87sWxG4
 2/IQ==
X-Gm-Message-State: AOJu0YwlgEPexU9ZRaU4CcsFkmgSE/YK560C4gTFp1vyXy7S+GZrWB+e
 cVMJ2p9lIChBUaDD1T00fyoXX3RLP1vOdxHnRVUWABMFi/wtK2GpuiIAxShwvv78vvfqGYuM+oW
 HLUBL9dznIizrwwdluT6/CwkGmSuR6yvTx5164Q==
X-Google-Smtp-Source: AGHT+IG5U5p4XWIhNvb6BOmwJmQFFm85nFuEg4Hp510R4A3xrhib9ovSTedsHWv7A5zlulbdaWLWzBwuE9WYMa7VRcc=
X-Received: by 2002:a17:907:c088:b0:a6f:fbc:b3f3 with SMTP id
 a640c23a62f3a-a6fab779addmr339561966b.47.1718903422804; Thu, 20 Jun 2024
 10:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1718638104.git.jerome.forissier@linaro.org>
In-Reply-To: <cover.1718638104.git.jerome.forissier@linaro.org>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 20 Jun 2024 10:10:10 -0700
Message-ID: <CAJ+vNU0yGH6FKZsx+UZXvnQnsT13U9iKUb68=Fqc_z7J0XL14w@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] Introduce the lwIP network stack
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Jun 17, 2024 at 8:33=E2=80=AFAM Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
> library for the network stack" [1]. The goal is to introduce the lwIP TCP=
/IP
> stack [2] [3] as an alternative to the current implementation in net/,
> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
> reasons for doing so are:
> - Make the support of HTTPS in the wget command easier. Javier T. (CC'd)
> has some additional lwIP and Mbed TLS patches to do so. With that it
> becomes possible to fetch and launch a distro installer such as Debian
> etc. using a secure, authenticated connection directly from the U-Boot
> shell. Several use cases:
>   * Authentication: prevent MITM attack (third party replacing the
> binary with a different one)
>   * Confidentiality: prevent third parties from grabbing a copy of the
> image as it is being downloaded
>   * Allow connection to servers that do not support plain HTTP anymore
> (this is becoming more and more common on the Internet these days)
> - Possibly benefit from additional features implemented in lwIP
> - Less code to maintain in U-Boot
>
> Prior to applying this series, the lwIP stack needs to be added as a
> Git subtree with the following command:
>
>  $  git subtree add --squash --prefix lib/lwip/lwip https://git.savannah.=
gnu.org/git/lwip.git STABLE-2_2_0_RELEASE
>
> The first patch renames some enums in order to avoid a conflict when a
> later patch enables the lwIP library.
>
> The second patch introduces a new Kconfig symbol: NET_LWIP, which selects
> the lwIP implementation instead of the current one (NET). Contrary to the
> approach chosen by Maxim in [1], NET_LWIP and NET cannot be enabled
> simultaneously. The rationale is we want to start from a clean state and
> not pull potentially duplicated functionality from both stacks. Note
> however that a few files are still built in net/, they are the ones
> related to ethernet device management and the ethernet bootflow.
>
> The third patch splits the net.h header into net-legacy.h, net-common.h,
> net-lwip.h, leaving net.h as a simple wrapper.
>
> The fourth patch introduces the Makefile to build lwIP when NET_LWIP is
> enabled.
>
> The subsequent patches implement various network-oriented commands and
> features: dhcp, dns, ping, tftpboot, wget.
>
> A number of features are currently incompatible with NET_LWIP: SANDBOX,
> DFU_TFTP, FASTBOOT, SPL_NET. All make assumptions on how the network
> stack is implemented and/or pull sybols that are not trivially exported
> from lwIP. Some interface rework may be needed.
>
> Due to the above and in order to provide some level of testing, a new QEM=
U
> configuration is introduced (qemu_arm64_lwip_defconfig) which is the same
> as qemu_arm64_defconfig but with NET_LWIP and CMD_*_LWIP enabled.
> Tests are added to test/py/tests/test_net.py for that configuration.
>

Hi Jermone,

I've given this a spin on an imx8mm-venice-gw73xx-0x via
imx8mm_venice_defconfig and I can't get DHCP to work (didn't work in
v3 either):

$ diff defconfig configs/imx8mm_venice_defconfig
68,69c68,71
< CONFIG_CMD_DNS_LWIP=3Dy
< CONFIG_CMD_WGET_LWIP=3Dy
---
> CONFIG_CMD_DHCP6=3Dy
> CONFIG_CMD_TFTPPUT=3Dy
> CONFIG_SYS_DISABLE_AUTOLOAD=3Dy
> CONFIG_CMD_WGET=3Dy
88,90c90,94
< CONFIG_NET_LWIP=3Dy
< CONFIG_LWIP_DEBUG=3Dy
< CONFIG_LWIP_ASSERT=3Dy
---
> CONFIG_NET_RANDOM_ETHADDR=3Dy
> CONFIG_IP_DEFRAG=3Dy
> CONFIG_TFTP_BLOCKSIZE=3D4096
> CONFIG_PROT_TCP_SACK=3Dy
> CONFIG_IPV6=3Dy

Target:
u-boot=3D> net list
eth0 : ethernet@30be0000 00:d0:12:b5:f8:41 active
u-boot=3D> dhcp || echo fail
eth0: ethernet@30be0000 00:d0:12:b5:f8:41 active
netif_set_ipaddr: netif address being changed
netif: added interface 0 addr 192.168.1.1 netmask 0.0.0.0 gw 0.0.0.0
etharp_request: sending ARP request.
etharp_raw: sending raw ARP packet.
ethernet_output: sending packet 000000007df00bf0
dhcp_start(netif=3D000000007df2af40) 0dhcp_start(): mallocing new DHCP clie=
nt
dhcp_start(): allocated dhcp
dhcp_start(): starting DHCP configuration
dhcp_discover()
transaction id xid(42021)
dhcp_discover: making request
dhcp_discover: sendto(DISCOVER, IP_ADDR_BROADCAST, LWIP_IANA_PORT_DHCP_SERV=
ER)
ip4_output_if: 0IP header:
+-------------------------------+
| 4 | 5 |  0x00 |       336     | (v, hl, tos, len)
+-------------------------------+
|        0      |000|       0   | (id, flags, offset)
+-------------------------------+
|  255  |   17  |    0xba9d     | (ttl, proto, chksum)
+-------------------------------+
|    0  |    0  |    0  |    0  | (src)
+-------------------------------+
|  255  |  255  |  255  |  255  | (dest)
+-------------------------------+
ip4_output_if: call netif->output()
ethernet_output: sending packet 000000007df2c010
dhcp_discover: deleting()
dhcp_discover: SELECTING
dhcp_discover(): set request timeout 2000 msecs
ethernet_input: dest:ff:ff:ff:ff:ff:ff, src:28:28:5d:bb:16:9f, type:8899
ethernet_input: dest:ff:ff:ff:ff:ff:ff, src:00:27:0e:0d:74:ba, type:806
etharp_update_arp_entry: 172.24.20.24 - 00:27:0e:0d:74:ba
etharp_find_entry: found empty entry 0
etharp_find_entry: no empty entry found and not allowed to recycle
etharp_input: incoming ARP request
etharp_input: ARP request was not for us.
ethernet_input: dest:ff:ff:ff:ff:ff:ff, src:98:90:96:ac:d7:63, type:806
etharp_update_arp_entry: 172.24.20.3 - 98:90:96:ac:d7:63
etharp_find_entry: found empty entry 0
etharp_find_entry: no empty entry found and not allowed to recycle
etharp_input: incoming ARP request
etharp_input: ARP request was not for us.
ethernet_input: dest:ff:ff:ff:ff:ff:ff, src:84:2b:2b:4e:5a:9a, type:806
etharp_update_arp_entry: 172.24.0.1 - 84:2b:2b:4e:5a:9a
etharp_find_entry: found empty entry 0
etharp_find_entry: no empty entry found and not allowed to recycle
etharp_input: incoming ARP request
etharp_input: ARP request was not for us.
ethernet_input: dest:ff:ff:ff:ff:ff:ff, src:cc:96:e5:1e:a0:7b, type:800
ip_input: iphdr->dest 0xffff1fac netif->ip_addr 0x101a8c0 (0x0, 0x0, 0xffff=
1fac)
ip4_input: UDP packet to DHCP client port 138
ip4_input: packet not for us.
ethernet_input: dest:ff:ff:ff:ff:ff:ff, src:d4:be:d9:9f:5a:b4, type:800
ip_input: iphdr->dest 0xffffffff netif->ip_addr 0x101a8c0 (0x0, 0x0, 0xffff=
ffff)
ip4_input: packet accepted on interface 0ip4_input:
IP header:
+-------------------------------+
| 4 | 5 |  0x00 |        68     | (v, hl, tos, len)
+-------------------------------+
|    19472      |000|       0   | (id, flags, offset)
+-------------------------------+
|  128  |   17  |    0x2e51     | (ttl, proto, chksum)
+-------------------------------+
|  172  |   24  |   20  |   48  | (src)
+-------------------------------+
|  255  |  255  |  255  |  255  | (dest)
+-------------------------------+
ip4_input: p->len 68 p->tot_len 68
ethernet_input: dest:ff:ff:ff:ff:ff:ff, src:00:0b:ab:2e:fa:51, type:806
etharp_update_arp_entry: 172.24.24.181 - 00:0b:ab:2e:fa:51
etharp_find_entry: found empty entry 0
etharp_find_entry: no empty entry found and not allowed to recycle
etharp_input: incoming ARP request
etharp_input: ARP request was not for us.
ethernet_input: dest:ff:ff:ff:ff:ff:ff, src:98:90:96:ac:d7:63, type:806
etharp_update_arp_entry: 172.24.20.3 - 98:90:96:ac:d7:63
etharp_find_entry: found empty entry 0
etharp_find_entry: no empty entry found and not allowed to recycle
etharp_input: incoming ARP request
etharp_input: ARP request was not for us.
ethernet_input: dest:ff:ff:ff:ff:ff:ff, src:84:2b:2b:4e:5a:9a, type:806
etharp_update_arp_entry: 172.24.0.1 - 84:2b:2b:4e:5a:9a
etharp_find_entry: found empty entry 0
etharp_find_entry: no empty entry found and not allowed to recycle
etharp_input: incoming ARP request
etharp_input: ARP request was not for us.
fail

Even using ping before DHCP fails:
u-boot=3D> setenv ipaddr 192.168.1.1; ping 192.168.1.146 || echo fail
Using ethernet@30be0000 device
ip4_route: No route to 192.168.1.146
ip4_route: No route to 192.168.1.146
ip4_route: No route to 192.168.1.146
ip4_route: No route to 192.168.1.146
ip4_route: No route to 192.168.1.146
ip4_route: No route to 192.168.1.146
ip4_route: No route to 192.168.1.146
ip4_route: No route to 192.168.1.146
ip4_route: No route to 192.168.1.146
ip4_route: No route to 192.168.1.146
ping failed; host 192.168.1.146 is not alive
fail

Best Regards,

Tim
