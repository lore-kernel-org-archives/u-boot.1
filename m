Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54D5E6BF37
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 20:13:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7DBF844F1;
	Fri, 30 Jan 2026 21:13:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="uKg6ElSj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8478184560; Fri, 30 Jan 2026 21:13:35 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0646844C7
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 21:13:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=03eb=AE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: References: Cc:
 To: From: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1769804011;
 bh=qbXLzFH2MTrMbfXhGZgNXKHOllWmd8wJ1LwMyn5MHhs=;
 b=uKg6ElSjKtvczJTkqH6Sskr+bFtd8B0GNpuy2ebsl+FPYv13BOjw1dy7gk51o/LMtWSS/mHxd
 sEbJUoa63++6dz4biDpBgQDVBwWNvIhqd5STm6u5VSelVnmdLfy1QZlSc/reLnwBwphWxb1bmnj
 KsrPfGDBQU6vilkbhMT9V8eRt0bVQ6tSE/VwEXRE5RPGxKhQvRe2myRWZp2/JnruVT1QguPnBGe
 luXuoJkQI5N6amTDHlCiIhj7yPV4tqdfXbUIR99oF5LYhk5fqZy97S/a119gZRtBrwE0Wy7/OW3
 swJf9Jty3YdmsukfECtFY9gBZMmIJoLFutxOO1fXld6w==
X-Forward-Email-ID: 697d10e6d2f8868516a59bf9
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.5.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <050276da-4483-45cf-8252-c5cb2cea44e5@kwiboo.se>
Date: Fri, 30 Jan 2026 21:13:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] usb: eth: asix88179: Use a fixed URB buffer size of
 16 KiB
From: Jonas Karlman <jonas@kwiboo.se>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Khoa Hoang <admin@khoahoang.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20260130002941.2336252-1-jonas@kwiboo.se>
 <20260130002941.2336252-3-jonas@kwiboo.se>
 <b251561f-936f-44be-bd01-eb1d08c0bdfc@mailbox.org>
 <d578ba21-bf07-4c3c-9e76-567f91ccab15@kwiboo.se>
Content-Language: en-US
In-Reply-To: <d578ba21-bf07-4c3c-9e76-567f91ccab15@kwiboo.se>
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

Hi Marek,

On 1/30/2026 11:54 AM, Jonas Karlman wrote:
> Hi Marek,
> 
> On 1/30/2026 2:26 AM, Marek Vasut wrote:
>> On 1/30/26 1:29 AM, Jonas Karlman wrote:
>>> The commit 05278af8b3df ("eth: asix88179: packet drop when receiving
>>> large fragmented packets") adjusted the URB buffer size to allow large
>>> fragmented packets. However, this change result in use of a large URB
>>> buffer size for slow speed connections, e.g. 10/100M use 26 KiB.
>>>
>>> Using a ASIX AX88179B USB 3.0 or ASIX AX88772E USB 2.0 Ethernet adapter
>>> on a Rockchip RK3528 with a DWC2 USB controller this large URB buffer
>>> size result in invalid rx_hdr and result in unusable Ethernet.
>>>
>>> The data read back from AX_RX_BULKIN_QCTRL after being configured also
>>> does not match the values in the AX88179_BULKIN_SIZE array.
>>>
>>> Change to use a fixed URB buffer size of 16 KiB to fix use of Ethernet,
>>
>> Why 16 kiB and not something else ?
> 
> Using anything larger than 16 KiB resulted in issues, and a datasheet
> for the older AX88772 prior to the D revision mention default 16 KiB for 
> "Maximum Frame Burst transfer on USB bus" so 16 KiB seemed like a safe
> size to use for newer revisions, and this also made it possible to use
> fragmented packets up to just below 16 KiB.
> 
>>
>> Is this a USB controller related problem/limitation ? Maybe the DWC2 
>> driver needs fixing instead, to handler larger buffers ?
> 
> I accidentally mixed up what host controller was being used, the board in
> question is using a generic-echi controller not the DWC2 as I stated.

I dove deeper and it looks like there could be an issue with ehci-hcd
and handling of short packets, see below debug print that dumps the qTD
and where it can be seen that the first packet is short and using the
xfr_bytes - totalbytes of the first qTD with a short packet fixes my
issue.

  BOOTP broadcast 4
  ** asix_send_common(), len 342
  ehci_submit_bulk_msg: dev='usb@ff100000', udev=00000000f9f2d520
  dev=00000000f9f2d520, pipe=c0018303, buffer=00000000f9ee13c0, length=350, req=0000000000000000
  QH: next=0x1, alt=0x11, token=0x8c00, totalbytes=0, xfr_bytes=0
  qTD[0]: next=0x1, alt=0x1, token=0x8c00, totalbytes=0, xfr_bytes=350
  TOKEN=0x8c00
  Tx: len = 346, actual = 350, err = 0

  ax88179_eth_recv: first try, len=0
  ehci_submit_bulk_msg: dev='usb@ff100000', udev=00000000f9f2d520
  dev=00000000f9f2d520, pipe=c0010383, buffer=00000000f9f2df00, length=26624, req=0000000000000000
  QH: next=0x1, alt=0x11, token=0xa7808d00, totalbytes=10112
  qTD[0]: next=0xf9f2a140, alt=0x1, token=0xbe989d00, totalbytes=16024, xfr_bytes=16384 <<-- SHORT
  qTD[1]: next=0x1, alt=0x1, token=0xa7808d00, totalbytes=10112, xfr_bytes=10240 <<-- SHORT
  TOKEN=0xa7808d00
  ax88179_eth_recv: second try, len=16512
  ax88179_eth_recv: 2 packets received, pkt header at 112
  ax88179_eth_recv: return packet of 0 bytes (1 packets left)
  ax88179_eth_recv: return packet of 0 bytes (0 packets left)

  ax88179_eth_recv: first try, len=0
  ehci_submit_bulk_msg: dev='usb@ff100000', udev=00000000f9f2d520
  dev=00000000f9f2d520, pipe=c0010383, buffer=00000000f9f2df00, length=26624, req=0000000000000000
  QH: next=0x1, alt=0x11, token=0x27a08d00, totalbytes=10144
  qTD[0]: next=0xf9f2a140, alt=0x1, token=0x3e889d00, totalbytes=16008, xfr_bytes=16384 <<-- SHORT
  qTD[1]: next=0x1, alt=0x1, token=0x27a08d00, totalbytes=10144, xfr_bytes=10240 <<-- SHORT
  TOKEN=0x27a08d00
  ax88179_eth_recv: second try, len=16480
  ax88179_eth_recv: 2 packets received, pkt header at 80
  ax88179_eth_recv: return packet of 5429 bytes (1 packets left)
  ax88179_eth_recv: return packet of 4149 bytes (0 packets left)


The diff below seem to solve my issue even better, aligns the ehci
transfers to only use one qTD with a 20kb buffer for optimal performance.

But that is probably still not a good solution, ehci-hcd should probably
gain proper support for short packet handling and usb_ether_register()
could start using a 4kb aligned rxbuf to make sure 20kb transfers instead
of 16kb transfers are used for ehci controllers.


Maybe I should just drop this patch and address your feedback on
remaining patches for v2?


diff --git a/drivers/usb/eth/asix88179.c b/drivers/usb/eth/asix88179.c
index 69d3073b669a..a04952b5eb74 100644
--- a/drivers/usb/eth/asix88179.c
+++ b/drivers/usb/eth/asix88179.c
@@ -475,7 +475,6 @@ static int asix_init_common(struct ueth_data *dev,
 	/* RX bulk configuration */
 	asix_write_cmd(dev, AX_ACCESS_MAC, AX_RX_BULKIN_QCTRL, 5, 5, tmp);
 
-	dev_priv->rx_urb_size = (1024 * (tmp[3] + 2));
 	if (*tmp16 & GMII_PHY_PHYSR_FULL)
 		mode |= AX_MEDIUM_FULL_DUPLEX;
 	asix_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
diff --git a/drivers/usb/eth/usb_ether.c b/drivers/usb/eth/usb_ether.c
index 8bba3e0974e6..02c93b40dd3e 100644
--- a/drivers/usb/eth/usb_ether.c
+++ b/drivers/usb/eth/usb_ether.c
@@ -72,7 +72,7 @@ int usb_ether_register(struct udevice *dev, struct ueth_data *ueth, int rxsize)
 	}
 
 	ueth->rxsize = rxsize;
-	ueth->rxbuf = memalign(ARCH_DMA_MINALIGN, rxsize);
+	ueth->rxbuf = memalign(4096, rxsize);
 	if (!ueth->rxbuf)
 		return -ENOMEM;
 

Regards,
Jonas

> Below follow some debug prints, what can be observed is that when
> length=26624 is returned from ehci_submit_bulk_msg the ax88179_eth_recv
> will return len >16 KiB and that result in the rx_hdr at the end of
> the returned buffer being bogus data, e.g. for following:
> 
>   BOOTP broadcast 1
>   ** asix_send_common(), len 342
>   ehci_submit_bulk_msg: dev='usb@ff100000', udev=00000000f9f2c520
>   dev=00000000f9f2c520, pipe=c0018303, buffer=00000000f9ee0680, length=350, req=0000000000000000
>   TOKEN=0x80008c00
>   Tx: len = 346, actual = 350, err = 0
> 
>   ax88179_eth_recv: first try, len=0
>   ehci_submit_bulk_msg: dev='usb@ff100000', udev=00000000f9f2c520
>   dev=00000000f9f2c520, pipe=c0010383, buffer=00000000f9f2cf00, length=26624, req=0000000000000000
>   TOKEN=0xa7808d00
>   ax88179_eth_recv: second try, len=16512
>   ax88179_eth_recv: 2 packets received, pkt header at 112
>   ax88179_eth_recv: return packet of 106 bytes (1 packets left)
>   ax88179_eth_recv: return packet of 0 bytes (0 packets left)
> 
> The buffers returned from the AX88179 contains something like:
> 
>  <packet data N><N+1>... <packet header N><N+1>... <RX HDR>
> 
> Above the "2 packets received, pkt header at 112" seem to indicate that
> the pkt header is in the middle of the packet data, in other instances
> the rx_hdr seem to indicate that the buffer contains  thousands of
> packets, i.e. the rx_hdr is likely bogus when more than 16 KiB is
> returned from ehci_submit_bulk_msg.
> 
> 
> More info and debug prints:
> 
> => dm tree -e usb
>  Class     Seq    Probed  Driver                Name
> -----------------------------------------------------------
>  pinconfig   277  [ + ]   pinconfig             usb
>  pinconfig   278  [ + ]   pinconfig             `-- usb-host-en
>  pinconfig   280  [   ]   pinconfig             usb-wifi-pwr
>  nop           0  [   ]   dwc3-generic-wrapper  usb@fe500000
>  usb_gadget    0  [   ]   dwc3-generic-periphe  `-- usb@fe500000
>  usb           0  [ + ]   ehci_generic          usb@ff100000
>  usb_hub       0  [ + ]   usb_hub               `-- usb_hub
>  usb_hub       1  [ + ]   usb_hub                   `-- usb_hub
>  ethernet      0  [ + ]   ax88179_eth                   `-- ax88179_eth
>  bootdev       2  [ + ]   eth_bootdev                       `-- ax88179_eth.bootdev
>  nop           1  [ + ]   rockchip_usb2phy      usb2phy@ffdf0000
>  phy           1  [   ]   rockchip_usb2phy_por  |-- otg-port
>  phy           2  [ + ]   rockchip_usb2phy_por  |-- host-port
>  clk           3  [ + ]   rockchip_usb2phy_clo  `-- clk_usbphy_480m
> 
> => usb tree
> USB device tree:
>   1  Hub (480 Mb/s, 0mA)
>   |  u-boot EHCI Host Controller
>   |
>   +-2  Hub (480 Mb/s, 100mA)
>     |   USB 2.0 Hub
>     |
>     +-3  Vendor specific (480 Mb/s, 100mA)
>       |  ASIX AX88772E 00CFCE77
>       |

[snip]

> Regards,
> Jonas
