Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2703CC83F09
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 07:19:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76F0D83666;
	Thu, 10 Jul 2025 09:19:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DN40Mv8I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 975998368F; Thu, 10 Jul 2025 09:19:16 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A49083653
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 09:19:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ae3cd8fdd77so126603266b.1
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 00:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752131953; x=1752736753; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K8ssSKbdoIFvHXxoKVWQ/JcKaPQ95QEpLjAYVLLNKrA=;
 b=DN40Mv8IbjRgMAvPcJ+j8lBb+ddEN4IpkCdtD3Y2GFGfOMTa/rJBYql5rGk6N/fQ2E
 DE5JClhXuCF66rFFnPGUN6JubXorluPo9PKPD5bort/f3RN3hkCxVCF9YC6ufnWt9Lml
 nEY3eoGjy1vXxw3KdQ151hXUWLsvfpDJtLT3kQA5FRYnDUqXLl57W0+SB1WzQ1QwWV48
 kwHxsh2JSxdr70POaQW86lvR72Lswfc0bnrvLckxRYv8a47wUwqjK02rLmUF0/KpH6bh
 xMs9y6UVXg47Feoayd0ZAOpdZ+nsn/uW3JuIvWGQ5IUMWp2gS/rIMRU+HLzRFguh+mmx
 IhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752131953; x=1752736753;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K8ssSKbdoIFvHXxoKVWQ/JcKaPQ95QEpLjAYVLLNKrA=;
 b=RhDqRSCd0K76XgIHT5dEwkFtapEz2bflmi3/4kEnycah2qMOs5MDOXckEec+d0gdXY
 RdC5E21TM0MDA7tSVLp/NE5grO7cKNH4zoQkwjVpfOuIh10ELmGXrpPHT91wc95u/Ks3
 O55jm6onXms3ySYQB8UydXAZvgIUWHeZelW83d308p6Z+Nk0rjUZhKARkp25gXm/VHQF
 33mgubLqMfosxthmc92Q3R9406dXu9f3n3c22inNrJbxcS5K4HHQCv17N0Vt6/ygyJW0
 IE5dt8gV59KaJ621T6Uj8ZhGrEFQm7zHv40HfFIs8keOMd00iY5Se2p6JxYWmwjAn29e
 wf8A==
X-Gm-Message-State: AOJu0YyUj+MLNAoQHA3Ecev3lJM0DwvoxK1ouALzScac0mWjRavrEnAj
 qj7Fql+2xVx59hrV6nqdxqSiTCQa2nN/mOqCUPOB7EYYjzH/ZseTRKFZuVKpk/SDfqdRyhZ0pfE
 svKcz5/fYsw==
X-Gm-Gg: ASbGncvvPLhyU2ZJPNwvPCzlt3CIIsQBr7kfJWRN3yHfy3Jxi+U2KZeQ6E4CB1RVGZd
 Qq/0Ro0Wy/EfV37Y0I56d5ea7TWreOxH582f0Q9kgOcL3+UI5Rwk+1TQssPEvLOjvsepIcRvYe5
 Jozmtpm3ItWxvL429SsU1qV7O32k5NZoSJYjaNaV7wNd9h0NiMKzX60TJldMMDcKpAXY/IeNIIx
 uyhwXzFCSX04rQlglFa6Gva4JqGK1SJhYi+EwK1keTvr7z3jlSZ1Xc3XJucSMxlH2WYycryc82A
 u2YlyqJEIkVWrfdsNU+QPPjCzbAcbyz+68Pu+QqEPG5VQsg8TtwBHA+QCU58pDxPS2pM6ttPTFM
 pW62GJTSMUJ5rGcErNydBD9Kg9XcPRuSIjuMKSzk=
X-Google-Smtp-Source: AGHT+IEPg9uX6aMJ8NGhCS0KGAEmcLM3cZRN0gko6a+QV6DA/FyLrzONbQHv1ohUlzz4LeZAYPId6w==
X-Received: by 2002:a17:907:94ca:b0:ad8:8719:f6f3 with SMTP id
 a640c23a62f3a-ae6e6e7a992mr161718766b.22.1752131953338; 
 Thu, 10 Jul 2025 00:19:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:157f:442:48ff:45a9?
 ([2a01:e0a:3cb:7bb0:157f:442:48ff:45a9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e7eeae48sm82620266b.65.2025.07.10.00.19.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 00:19:13 -0700 (PDT)
Message-ID: <15e75099-b5cf-4d65-a9c3-f78514b464b6@linaro.org>
Date: Thu, 10 Jul 2025 09:19:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] net: lwip: fix initialization sequence before a
 command
To: Tim Harvey <tharvey@gateworks.com>
Cc: U-Boot mailing list <u-boot@lists.denx.de>, Simon Glass
 <sjg@chromium.org>, Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20250415211819.1254435-1-jerome.forissier@linaro.org>
 <20250415211819.1254435-2-jerome.forissier@linaro.org>
 <CAJ+vNU2Z-9n78B25g6h7AEEcWDQfKxM0vWymft2-LaWwpb-_2w@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAJ+vNU2Z-9n78B25g6h7AEEcWDQfKxM0vWymft2-LaWwpb-_2w@mail.gmail.com>
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

Hi Tim,

On 7/10/25 01:53, Tim Harvey wrote:
> On Tue, Apr 15, 2025 at 2:18 PM Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> The things that are done prior to executing a network command with
>> NET_LWIP are not consistent with what is done with NET. It impacts the
>> selection of the current device, and more precisely if the active device
>> is invalid NET would return an error while NET_LWIP would try to pick a
>> new device. This incorrect behavior was detected thanks to the eth_rotate
>> sandbox test (dm_test_eth_rotate()).
>>
>> Fix it by re-using a sequence similar to what NET has in net_loop().
>> This piece of code is inserted in a function called net_lwip_eth_start()
>> renamed from net_lwip_eth_set_current().
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> ---
>>
>> (no changes since v1)
>>
>>  include/net-lwip.h  |  9 ++++++++-
>>  net/lwip/dhcp.c     |  3 ++-
>>  net/lwip/dns.c      |  3 ++-
>>  net/lwip/net-lwip.c | 40 +++++++++++++++++++++++++++++-----------
>>  net/lwip/ping.c     |  3 ++-
>>  net/lwip/tftp.c     |  5 ++++-
>>  net/lwip/wget.c     |  6 +++++-
>>  7 files changed, 52 insertions(+), 17 deletions(-)
>>
>> diff --git a/include/net-lwip.h b/include/net-lwip.h
>> index 64e5c720560..0d3bb8a8bd8 100644
>> --- a/include/net-lwip.h
>> +++ b/include/net-lwip.h
>> @@ -10,7 +10,14 @@ enum proto_t {
>>         TFTPGET
>>  };
>>
>> -void net_lwip_set_current(void);
>> +static inline int eth_is_on_demand_init(void)
>> +{
>> +       return 1;
>> +}
>> +
>> +int eth_init_state_only(void); /* Set active state */
>> +
>> +int net_lwip_eth_start(void);
>>  struct netif *net_lwip_new_netif(struct udevice *udev);
>>  struct netif *net_lwip_new_netif_noip(struct udevice *udev);
>>  void net_lwip_remove_netif(struct netif *netif);
>> diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
>> index 3b7e4700c6e..92bd7067a7f 100644
>> --- a/net/lwip/dhcp.c
>> +++ b/net/lwip/dhcp.c
>> @@ -115,7 +115,8 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>         int ret;
>>         struct udevice *dev;
>>
>> -       net_lwip_set_current();
>> +       if (net_lwip_eth_start() < 0)
>> +               return CMD_RET_FAILURE;
>>
>>         dev = eth_get_dev();
>>         if (!dev) {
>> diff --git a/net/lwip/dns.c b/net/lwip/dns.c
>> index 149bdb784dc..19172ac959a 100644
>> --- a/net/lwip/dns.c
>> +++ b/net/lwip/dns.c
>> @@ -121,7 +121,8 @@ int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>         if (argc == 3)
>>                 var = argv[2];
>>
>> -       net_lwip_set_current();
>> +       if (net_lwip_eth_start() < 0)
>> +               return CMD_RET_FAILURE;
>>
>>         return dns_loop(eth_get_dev(), name, var);
>>  }
>> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
>> index 6b7b696dbf0..6748008736b 100644
>> --- a/net/lwip/net-lwip.c
>> +++ b/net/lwip/net-lwip.c
>> @@ -134,18 +134,27 @@ static int get_udev_ipv4_info(struct udevice *dev, ip4_addr_t *ip,
>>         return 0;
>>  }
>>
>> -/* Initialize the lwIP stack and the ethernet devices and set current device  */
>> -void net_lwip_set_current(void)
>> +/*
>> + * Initialize the network stack if needed and start the current device if valid
>> + */
>> +int net_lwip_eth_start(void)
>>  {
>> -       static bool init_done;
>> +       int ret;
>>
>> -       if (!init_done) {
>> -               eth_init_rings();
>> -               eth_init();
>> -               lwip_init();
>> -               init_done = true;
>> +       net_init();
>> +       if (eth_is_on_demand_init()) {
>> +               eth_halt();
>> +               eth_set_current();
>> +               ret = eth_init();
>> +               if (ret < 0) {
>> +                       eth_halt();
>> +                       return ret;
>> +               }
>> +       } else {
>> +               eth_init_state_only();
>>         }
>> -       eth_set_current();
>> +
>> +       return 0;
>>  }
>>
>>  static struct netif *new_netif(struct udevice *udev, bool with_ip)
>> @@ -224,11 +233,20 @@ void net_lwip_remove_netif(struct netif *netif)
>>         free(netif);
>>  }
>>
>> +/*
>> + * Initialize the network buffers, an ethernet device, and the lwIP stack
>> + * (once).
>> + */
>>  int net_init(void)
>>  {
>> -       eth_set_current();
>> +       static bool init_done;
>>
>> -       net_lwip_new_netif(eth_get_dev());
>> +       if (!init_done) {
>> +               eth_init_rings();
>> +               eth_init();
>> +               lwip_init();
>> +               init_done = true;
>> +       }
>>
>>         return 0;
>>  }
>> diff --git a/net/lwip/ping.c b/net/lwip/ping.c
>> index c586a96806d..542ef2cb148 100644
>> --- a/net/lwip/ping.c
>> +++ b/net/lwip/ping.c
>> @@ -168,7 +168,8 @@ int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>         if (!ipaddr_aton(argv[1], &addr))
>>                 return CMD_RET_USAGE;
>>
>> -       net_lwip_set_current();
>> +       if (net_lwip_eth_start() < 0)
>> +               return CMD_RET_FAILURE;
>>
>>         if (ping_loop(eth_get_dev(), &addr) < 0)
>>                 return CMD_RET_FAILURE;
>> diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
>> index 123d66b5dba..4f9b2049187 100644
>> --- a/net/lwip/tftp.c
>> +++ b/net/lwip/tftp.c
>> @@ -280,7 +280,10 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>                 goto out;
>>         }
>>
>> -       net_lwip_set_current();
>> +       if (net_lwip_eth_start() < 0) {
>> +               ret = CMD_RET_FAILURE;
>> +               goto out;
>> +       }
>>
>>         if (tftp_loop(eth_get_dev(), laddr, fname, srvip, port) < 0)
>>                 ret = CMD_RET_FAILURE;
>> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
>> index ec098148835..a3b82908877 100644
>> --- a/net/lwip/wget.c
>> +++ b/net/lwip/wget.c
>> @@ -471,7 +471,11 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>>
>>  int wget_do_request(ulong dst_addr, char *uri)
>>  {
>> -       net_lwip_set_current();
>> +       int ret;
>> +
>> +       ret = net_lwip_eth_start();
>> +       if (ret < 0)
>> +               return ret;
>>
>>         if (!wget_info)
>>                 wget_info = &default_wget_info;
>> --
>> 2.43.0
>>
> 
> Hi Jerome,
> 
> I'm seeing an issue with NET_LWIP related to this patch.
> 
> In net_lwip_eth_start the eth_init function is called first in
> net_init then again within the if eth_is_on_demand. This causes a
> situation where the netdev is started, then stopped and started again
> and in the case of at least the dwc_eth_qos device this causes the phy
> to drop link after negotiation has been performed the first time a
> network operation occurs.
> 
> The situation is this on an imx8mp_venice board for any network action
> (dhcp, tftp, etc):
> u-boot=> dhcp
> ethernet@30bf0000 Waiting for PHY auto negotiation to complete...... done
> No link
> FAILED: -11
> eqos_start ethernet@30bf0000
> No link
> FAILED: -11
> Could not start ethernet@30bf0000
> 
> Here is some debugging added:
> lwip with eqos:
> u-boot=> dhcp
> net_lwip_eth_start
> eth_start_udev ethernet@30bf0000 running=0
> eqos_start ethernet@30bf0000 phy=null
> eqos_start ethernet@30bf0000 calling phy_connect
> eqos_start ethernet@30bf0000 connected to phy ethernet@30bf0000
> eqos_start ethernet@30bf0000 calling phy_config
> ethernet@30bf0000 Waiting for PHY auto negotiation to complete....... done
> eth_start_udev ethernet@30bf0000 done running=1
> ^^^ this was a result of eth_init being called in net_init
> net_lwip_eth_start calling eth_halt
> eth_halt in_init_halt=0
> eth_halt current=ethernet@30bf0000
> eth_halt running=1
> ^^^ now, because we are already running halt continues on to halt the interface
> eth_halt ethernet@30bf0000 calling stop
> eqos_stop ethernet@30bf0000
> phy_shutdown ethernet@30bf0000
> ^^^ phy is shutdown here
> net_lwip_eth_start calling eth_set_current
> net_lwip_eth_start calling eth_init
> eth_start_udev ethernet@30bf0000 running=0
> eqos_start ethernet@30bf0000 phy=ethernet@30bf0000
> ^^^ phy links again but link has not been established by the time we
> try to use it here
> No link
> phy_shutdown ethernet@30bf0000
> FAILED: -11
> eth_start_udev ethernet@30bf0000 running=0
> eqos_start ethernet@30bf0000 phy=ethernet@30bf0000
> eth_start_udev ethernet@30bf0000 done running=1
> DHCP client bound to address 172.24.23.42 (1110 ms)
> u-boot=> dhcp
> net_lwip_eth_start
> net_lwip_eth_start calling eth_halt
> eth_halt in_init_halt=0
> eth_halt current=ethernet@30bf0000
> eth_halt running=1
> eth_halt ethernet@30bf0000 calling stop
> eqos_stop ethernet@30bf0000
> phy_shutdown ethernet@30bf0000
> net_lwip_eth_start calling eth_set_current
> net_lwip_eth_start calling eth_init
> eth_start_udev ethernet@30bf0000 running=0
> eqos_start ethernet@30bf0000 phy=ethernet@30bf0000
> eth_start_udev ethernet@30bf0000 done running=1
> eth_start_udev ethernet@30bf0000 running=1
> DHCP client bound to address 172.24.23.42 (29 ms)
> ^^^ any follow-on network operation is fine as the PHY has re-linked
> at this point
> 
> legacy:
> u-boot=> dhcp
> net_loop calling eth_halt()
> eth_halt in_init_halt=0
> eth_halt current=ethernet@30bf0000
> eth_halt running=0
> ^^^ does not call stop because its not running because eth_init hasn't
> been called already
> eqos_start ethernet@30bf0000
> DP83867 ethernet@30bf0000 Waiting for PHY auto negotiation to
> complete....... done
> ^^^ works
> 
> Here's another board (imx8mm_venice) which has a different MAC (fec)
> that works fine with this patch:
> u-boot=> dhcp
> net_lwip_eth_start
> net_init init_done=0
> eth_start_udev ethernet@30be0000 running=0
> fecmxc_init ethernet@30be0000
> ethernet@30be0000 Waiting for PHY auto negotiation to complete.... done
> eth_start_udev ethernet@30be0000 done running=1
> net_lwip_eth_start calling eth_halt
> eth_halt in_init_halt=0
> eth_halt current=ethernet@30be0000
> eth_halt running=1
> eth_halt ethernet@30be0000 calling stop
> fecmxc_halt ethernet@30be0000
> ^^^ halt is called but for this MAC it doesn't drop the link
> net_lwip_eth_start calling eth_set_current
> net_lwip_eth_start calling eth_init
> eth_start_udev ethernet@30be0000 running=0
> fecmxc_init ethernet@30be0000
> eth_start_udev ethernet@30be0000 done running=1
> eth_start_udev ethernet@30be0000 running=1
> DHCP client bound to address 172.24.23.44 (1117 ms)
> 
> The difference here is the FEC mac driver (fec_mxc.c) is not disturbed
> by a start->stop->start. I'm not exactly sure why this is... I thought
> it was because the FEC driver configures the PHY in the probe vs the
> start but even if I remove the phy_shutdown call from the EQOS driver
> it still drops the link on eqos_stop.
> 
> Removing the call the eth_init from net_init makes NET_LWIP behave
> like legacy and makes more sense as you don't get a
> 'start->stop->start' call sequence to your netdev but honestly I'm not
> sure if this also points out an issue with either the fec driver or
> the eqos driver regarding where/how the PHY is handled.
> 
> Would you agree with:
> 
> net: lwip: remove eth_init from net_init as its called later
> 
> The call to eth_init within net_init casues the network interface to

causes

> start, stop, start again which can cause issues with certain network
> device drivers. Remove it to make it behave like the legacy network
> path.
> 
> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> index 3918d57d7e58..d53faa39ba11 100644
> --- a/net/lwip/net-lwip.c
> +++ b/net/lwip/net-lwip.c
> @@ -285,7 +285,6 @@ int net_init(void)
> 
>         if (!init_done) {
>                 eth_init_rings();
> -               eth_init();
>                 lwip_init();
>                 init_done = true;
>         }

Yes, that looks good to me. Please also update the comment:

diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index f05c4cd3f64..505d002e185 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -237,8 +237,7 @@ void net_lwip_remove_netif(struct netif *netif)
 }
 
 /*
- * Initialize the network buffers, an ethernet device, and the lwIP stack
- * (once).
+ * Initialize the network buffers and the lwIP stack (once).
  */
 int net_init(void)
 {

While looking at this I also noted that with NET_LWIP
eth_is_on_demand_init() is always true so net_lwip_eth_start()
could be simplified. Feel free to add a patch for that too :)

Thanks,
-- 
Jerome

> 
> Best Regards,
> 
> Tim
