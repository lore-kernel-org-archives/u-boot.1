Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5FED49C9E
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 10:54:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6433E842F4;
	Fri, 30 Jan 2026 11:54:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Il4NrhkL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA72F842FC; Fri, 30 Jan 2026 11:54:28 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF1478420D
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 11:54:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d4a6=AD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1769770464;
 bh=v1ViP8xlO6lMduJYMvUBoMOSgCVis/DAU5sm6K1Mguw=;
 b=Il4NrhkL4WQEY0VG1nXLwBDd2QtocAhD5wUgawGua05tup/bgwfaxRcm+thQ2yScnEpy3/Hk0
 F8IbAm58miewDP816iHy013Mrv9oEud6U7aOJRM660OEmCqQb6ddLmrJ/2wRLpvzskKxItOKSDd
 1PGPSfX/uNNqbIgTOMwFLQ+B7CDHr6veehSM+9vc5fp6hlKJmEO5NDsq2DKbVe+9oNNOY5u6+Rx
 ZHsUXOZ5OWpo2rY2DrtEQ798mlS6h4t7eZLtioKKhLQYdE/gc9VaE8oL9Hj0WxEd6FHklLonRaQ
 tniXGan/jY+O5Kdu268n4ZAD4+NyBrfJkUoMQPVdPg8A==
X-Forward-Email-ID: 697c8dd8a5545d580c921750
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.5.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <d578ba21-bf07-4c3c-9e76-567f91ccab15@kwiboo.se>
Date: Fri, 30 Jan 2026 11:54:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] usb: eth: asix88179: Use a fixed URB buffer size of
 16 KiB
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Khoa Hoang <admin@khoahoang.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20260130002941.2336252-1-jonas@kwiboo.se>
 <20260130002941.2336252-3-jonas@kwiboo.se>
 <b251561f-936f-44be-bd01-eb1d08c0bdfc@mailbox.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <b251561f-936f-44be-bd01-eb1d08c0bdfc@mailbox.org>
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

On 1/30/2026 2:26 AM, Marek Vasut wrote:
> On 1/30/26 1:29 AM, Jonas Karlman wrote:
>> The commit 05278af8b3df ("eth: asix88179: packet drop when receiving
>> large fragmented packets") adjusted the URB buffer size to allow large
>> fragmented packets. However, this change result in use of a large URB
>> buffer size for slow speed connections, e.g. 10/100M use 26 KiB.
>>
>> Using a ASIX AX88179B USB 3.0 or ASIX AX88772E USB 2.0 Ethernet adapter
>> on a Rockchip RK3528 with a DWC2 USB controller this large URB buffer
>> size result in invalid rx_hdr and result in unusable Ethernet.
>>
>> The data read back from AX_RX_BULKIN_QCTRL after being configured also
>> does not match the values in the AX88179_BULKIN_SIZE array.
>>
>> Change to use a fixed URB buffer size of 16 KiB to fix use of Ethernet,
> 
> Why 16 kiB and not something else ?

Using anything larger than 16 KiB resulted in issues, and a datasheet
for the older AX88772 prior to the D revision mention default 16 KiB for 
"Maximum Frame Burst transfer on USB bus" so 16 KiB seemed like a safe
size to use for newer revisions, and this also made it possible to use
fragmented packets up to just below 16 KiB.

> 
> Is this a USB controller related problem/limitation ? Maybe the DWC2 
> driver needs fixing instead, to handler larger buffers ?

I accidentally mixed up what host controller was being used, the board in
question is using a generic-echi controller not the DWC2 as I stated.

Below follow some debug prints, what can be observed is that when
length=26624 is returned from ehci_submit_bulk_msg the ax88179_eth_recv
will return len >16 KiB and that result in the rx_hdr at the end of
the returned buffer being bogus data, e.g. for following:

  BOOTP broadcast 1
  ** asix_send_common(), len 342
  ehci_submit_bulk_msg: dev='usb@ff100000', udev=00000000f9f2c520
  dev=00000000f9f2c520, pipe=c0018303, buffer=00000000f9ee0680, length=350, req=0000000000000000
  TOKEN=0x80008c00
  Tx: len = 346, actual = 350, err = 0

  ax88179_eth_recv: first try, len=0
  ehci_submit_bulk_msg: dev='usb@ff100000', udev=00000000f9f2c520
  dev=00000000f9f2c520, pipe=c0010383, buffer=00000000f9f2cf00, length=26624, req=0000000000000000
  TOKEN=0xa7808d00
  ax88179_eth_recv: second try, len=16512
  ax88179_eth_recv: 2 packets received, pkt header at 112
  ax88179_eth_recv: return packet of 106 bytes (1 packets left)
  ax88179_eth_recv: return packet of 0 bytes (0 packets left)

The buffers returned from the AX88179 contains something like:

 <packet data N><N+1>... <packet header N><N+1>... <RX HDR>

Above the "2 packets received, pkt header at 112" seem to indicate that
the pkt header is in the middle of the packet data, in other instances
the rx_hdr seem to indicate that the buffer contains  thousands of
packets, i.e. the rx_hdr is likely bogus when more than 16 KiB is
returned from ehci_submit_bulk_msg.


More info and debug prints:

=> dm tree -e usb
 Class     Seq    Probed  Driver                Name
-----------------------------------------------------------
 pinconfig   277  [ + ]   pinconfig             usb
 pinconfig   278  [ + ]   pinconfig             `-- usb-host-en
 pinconfig   280  [   ]   pinconfig             usb-wifi-pwr
 nop           0  [   ]   dwc3-generic-wrapper  usb@fe500000
 usb_gadget    0  [   ]   dwc3-generic-periphe  `-- usb@fe500000
 usb           0  [ + ]   ehci_generic          usb@ff100000
 usb_hub       0  [ + ]   usb_hub               `-- usb_hub
 usb_hub       1  [ + ]   usb_hub                   `-- usb_hub
 ethernet      0  [ + ]   ax88179_eth                   `-- ax88179_eth
 bootdev       2  [ + ]   eth_bootdev                       `-- ax88179_eth.bootdev
 nop           1  [ + ]   rockchip_usb2phy      usb2phy@ffdf0000
 phy           1  [   ]   rockchip_usb2phy_por  |-- otg-port
 phy           2  [ + ]   rockchip_usb2phy_por  |-- host-port
 clk           3  [ + ]   rockchip_usb2phy_clo  `-- clk_usbphy_480m

=> usb tree
USB device tree:
  1  Hub (480 Mb/s, 0mA)
  |  u-boot EHCI Host Controller
  |
  +-2  Hub (480 Mb/s, 100mA)
    |   USB 2.0 Hub
    |
    +-3  Vendor specific (480 Mb/s, 100mA)
      |  ASIX AX88772E 00CFCE77
      |

=> dhcp
** asix_init_common()
asix_write_cmd() cmd=0x01 value=0x000b index=0x0002 size=2
usb_control_msg: request: 0x1, requesttype: 0x40, value 0xB index 0x2 length 0x2
ehci_submit_control_msg: dev='usb@ff100000', udev=00000000f9f2c520, udev->dev='ax88179_eth', portnr=3
dev=00000000f9f2c520, pipe=80000303, buffer=00000000f9ee0bc0, length=2, req=00000000f9ee0ac0
req=1 (0x1), type=64 (0x40), value=11 (0xb), index=2
TOKEN=0x8d01
asix_read_cmd() cmd=0x02 value=0x0003 index=0x0001 size=2
usb_control_msg: request: 0x2, requesttype: 0xC0, value 0x3 index 0x1 length 0x2
ehci_submit_control_msg: dev='usb@ff100000', udev=00000000f9f2c520, udev->dev='ax88179_eth', portnr=3
dev=00000000f9f2c520, pipe=80000383, buffer=00000000f9ee0b80, length=2, req=00000000f9ee0a80
req=2 (0x2), type=192 (0xc0), value=3 (0x3), index=1
TOKEN=0x8c00
asix_read_cmd() cmd=0x01 value=0x0002 index=0x0001 size=1
usb_control_msg: request: 0x1, requesttype: 0xC0, value 0x2 index 0x1 length 0x1
ehci_submit_control_msg: dev='usb@ff100000', udev=00000000f9f2c520, udev->dev='ax88179_eth', portnr=3
dev=00000000f9f2c520, pipe=80000383, buffer=00000000f9ee0bc0, length=1, req=00000000f9ee0ac0
req=1 (0x1), type=192 (0xc0), value=2 (0x2), index=1
TOKEN=0x8c00
asix_read_cmd() cmd=0x02 value=0x0003 index=0x0011 size=2
usb_control_msg: request: 0x2, requesttype: 0xC0, value 0x3 index 0x11 length 0x2
ehci_submit_control_msg: dev='usb@ff100000', udev=00000000f9f2c520, udev->dev='ax88179_eth', portnr=3
dev=00000000f9f2c520, pipe=80000383, buffer=00000000f9ee0bc0, length=2, req=00000000f9ee0ac0
req=2 (0x2), type=192 (0xc0), value=3 (0x3), index=17
TOKEN=0x8c00
asix_write_cmd() cmd=0x01 value=0x002e index=0x0005 size=5
usb_control_msg: request: 0x1, requesttype: 0x40, value 0x2E index 0x5 length 0x5
ehci_submit_control_msg: dev='usb@ff100000', udev=00000000f9f2c520, udev->dev='ax88179_eth', portnr=3
dev=00000000f9f2c520, pipe=80000303, buffer=00000000f9ee0bc0, length=5, req=00000000f9ee0ac0
req=1 (0x1), type=64 (0x40), value=46 (0x2e), index=5
TOKEN=0x8d01
asix_write_cmd() cmd=0x01 value=0x0022 index=0x0002 size=2
usb_control_msg: request: 0x1, requesttype: 0x40, value 0x22 index 0x2 length 0x2
ehci_submit_control_msg: dev='usb@ff100000', udev=00000000f9f2c520, udev->dev='ax88179_eth', portnr=3
dev=00000000f9f2c520, pipe=80000303, buffer=00000000f9ee0bc0, length=2, req=00000000f9ee0ac0
req=1 (0x1), type=64 (0x40), value=34 (0x22), index=2
TOKEN=0x8d01
BOOTP broadcast 1
** asix_send_common(), len 342
ehci_submit_bulk_msg: dev='usb@ff100000', udev=00000000f9f2c520
dev=00000000f9f2c520, pipe=c0018303, buffer=00000000f9ee0680, length=350, req=0000000000000000
TOKEN=0x80008c00
Tx: len = 346, actual = 350, err = 0
ax88179_eth_recv: first try, len=0
ehci_submit_bulk_msg: dev='usb@ff100000', udev=00000000f9f2c520
dev=00000000f9f2c520, pipe=c0010383, buffer=00000000f9f2cf00, length=26624, req=0000000000000000
TOKEN=0xa7808d00
ax88179_eth_recv: second try, len=16512
ax88179_eth_recv: 2 packets received, pkt header at 112
ax88179_eth_recv: return packet of 106 bytes (1 packets left)
ax88179_eth_recv: return packet of 0 bytes (0 packets left)
BOOTP broadcast 2
** asix_send_common(), len 342
ehci_submit_bulk_msg: dev='usb@ff100000', udev=00000000f9f2c520
dev=00000000f9f2c520, pipe=c0018303, buffer=00000000f9ee0680, length=350, req=0000000000000000
TOKEN=0x8c00
Tx: len = 346, actual = 350, err = 0
ax88179_eth_recv: first try, len=0
ehci_submit_bulk_msg: dev='usb@ff100000', udev=00000000f9f2c520
dev=00000000f9f2c520, pipe=c0010383, buffer=00000000f9f2cf00, length=26624, req=0000000000000000
TOKEN=0x27808d00
ax88179_eth_recv: second try, len=16512
ax88179_eth_recv: 2 packets received, pkt header at 112
ax88179_eth_recv: return packet of 106 bytes (1 packets left)
ax88179_eth_recv: return packet of 0 bytes (0 packets left)
BOOTP broadcast 3
** asix_send_common(), len 342
ehci_submit_bulk_msg: dev='usb@ff100000', udev=00000000f9f2c520
dev=00000000f9f2c520, pipe=c0018303, buffer=00000000f9ee0680, length=350, req=0000000000000000
TOKEN=0x80008c00
Tx: len = 346, actual = 350, err = 0
ax88179_eth_recv: first try, len=0
ehci_submit_bulk_msg: dev='usb@ff100000', udev=00000000f9f2c520
dev=00000000f9f2c520, pipe=c0010383, buffer=00000000f9f2cf00, length=26624, req=0000000000000000
TOKEN=0xa7a88d00
ax88179_eth_recv: second try, len=16472
ax88179_eth_recv: 2 packets received, pkt header at 72
ax88179_eth_recv: return packet of 3938 bytes (1 packets left)
** asix_send_common(), len 342
ehci_submit_bulk_msg: dev='usb@ff100000', udev=00000000f9f2c520
dev=00000000f9f2c520, pipe=c0018303, buffer=00000000f9ee0600, length=350, req=0000000000000000
TOKEN=0x8c00
Tx: len = 346, actual = 350, err = 0
ax88179_eth_recv: return packet of 0 bytes (0 packets left)
ax88179_eth_recv: first try, len=0
ehci_submit_bulk_msg: dev='usb@ff100000', udev=00000000f9f2c520
dev=00000000f9f2c520, pipe=c0010383, buffer=00000000f9f2cf00, length=26624, req=0000000000000000
TOKEN=0x27a88d00
ax88179_eth_recv: second try, len=16472
ax88179_eth_recv: 2 packets received, pkt header at 72
ax88179_eth_recv: return packet of 3938 bytes (1 packets left)
DHCP client bound to address 192.168.42.234 (3365 ms)
Using ax88179_eth device
TFTP from server 192.168.2.50; our IP address is 192.168.42.234; sending through gateway 192.168.42.1
Filename 'default'.
Load address: 0xc00800
Loading: ** asix_send_common(), len 42
ehci_submit_bulk_msg: dev='usb@ff100000', udev=00000000f9f2c520
dev=00000000f9f2c520, pipe=c0018303, buffer=00000000f9ee0580, length=50, req=0000000000000000
TOKEN=0x80008c00
Tx: len = 46, actual = 50, err = 0
ax88179_eth_recv: return packet of 0 bytes (0 packets left)
ax88179_eth_recv: first try, len=0
ehci_submit_bulk_msg: dev='usb@ff100000', udev=00000000f9f2c520
dev=00000000f9f2c520, pipe=c0010383, buffer=00000000f9f2cf00, length=26624, req=0000000000000000
TOKEN=0xa7988d00
ax88179_eth_recv: second try, len=16488
ax88179_eth_recv: 2 packets received, pkt header at 88
ax88179_eth_recv: return packet of 0 bytes (1 packets left)
ax88179_eth_recv: return packet of 0 bytes (0 packets left)
ax88179_eth_recv: first try, len=0
ehci_submit_bulk_msg: dev='usb@ff100000', udev=00000000f9f2c520
dev=00000000f9f2c520, pipe=c0010383, buffer=00000000f9f2cf00, length=26624, req=0000000000000000
TOKEN=0x27a88d00
ax88179_eth_recv: second try, len=16472
ax88179_eth_recv: 2 packets received, pkt header at 72
ax88179_eth_recv: return packet of 3650 bytes (1 packets left)
ax88179_eth_recv: return packet of 4949 bytes (0 packets left)
ax88179_eth_recv: first try, len=0
ax88179_eth_recv: first try, len=0
ehci_submit_bulk_msg: dev='usb@ff100000', udev=00000000f9f2c520
dev=00000000f9f2c520, pipe=c0010383, buffer=00000000f9f2cf00, length=26624, req=0000000000000000
TOKEN=0xa7808d00
ax88179_eth_recv: second try, len=16512
ax88179_eth_recv: 2 packets received, pkt header at 112
ax88179_eth_recv: return packet of 106 bytes (1 packets left)
ax88179_eth_recv: return packet of 0 bytes (0 packets left)
ax88179_eth_recv: first try, len=0
ehci_submit_bulk_msg: dev='usb@ff100000', udev=00000000f9f2c520
dev=00000000f9f2c520, pipe=c0010383, buffer=00000000f9f2cf00, length=26624, req=0000000000000000
TOKEN=0x26189d00
ax88179_eth_recv: second try, len=16872
ax88179_eth_recv: 2 packets received, pkt header at 472
ax88179_eth_recv: return packet of 0 bytes (1 packets left)
ax88179_eth_recv: return packet of 0 bytes (0 packets left)
ax88179_eth_recv: first try, len=0
ehci_submit_bulk_msg: dev='usb@ff100000', udev=00000000f9f2c520
dev=00000000f9f2c520, pipe=c0010383, buffer=00000000f9f2cf00, length=26624, req=0000000000000000
TOKEN=0xa7b08d00
ax88179_eth_recv: second try, len=16464
ax88179_eth_recv: 2 packets received, pkt header at 64
ax88179_eth_recv: return packet of 3360 bytes (1 packets left)
ax88179_eth_recv: return packet of 0 bytes (0 packets left)
ax88179_eth_recv: first try, len=0
ehci_submit_bulk_msg: dev='usb@ff100000', udev=00000000f9f2c520
dev=00000000f9f2c520, pipe=c0010383, buffer=00000000f9f2cf00, length=26624, req=0000000000000000
TOKEN=0x27b08d00
ax88179_eth_recv: second try, len=16464
ax88179_eth_recv: 2 packets received, pkt header at 64
ax88179_eth_recv: return packet of 5681 bytes (1 packets left)
ax88179_eth_recv: return packet of 3141 bytes (0 packets left)
ax88179_eth_recv: first try, len=0
** asix_send_common(), len 42
ehci_submit_bulk_msg: dev='usb@ff100000', udev=00000000f9f2c520
dev=00000000f9f2c520, pipe=c0018303, buffer=00000000f9ee0680, length=50, req=0000000000000000
TOKEN=0x8c00
Tx: len = 46, actual = 50, err = 0
ax88179_eth_recv: first try, len=0
ehci_submit_bulk_msg: dev='usb@ff100000', udev=00000000f9f2c520
dev=00000000f9f2c520, pipe=c0010383, buffer=00000000f9f2cf00, length=26624, req=0000000000000000
TOKEN=0xa7a88d00
ax88179_eth_recv: second try, len=16472
ax88179_eth_recv: 2 packets received, pkt header at 72
ax88179_eth_recv: return packet of 0 bytes (1 packets left)
ax88179_eth_recv: return packet of 64 bytes (0 packets left)
** asix_send_common(), len 82
ehci_submit_bulk_msg: dev='usb@ff100000', udev=00000000f9f2c520
dev=00000000f9f2c520, pipe=c0018303, buffer=00000000f9ee0600, length=90, req=0000000000000000
TOKEN=0x80008c00
Tx: len = 86, actual = 90, err = 0
ax88179_eth_recv: first try, len=0
ax88179_eth_recv: first try, len=0
ehci_submit_bulk_msg: dev='usb@ff100000', udev=00000000f9f2c520
dev=00000000f9f2c520, pipe=c0010383, buffer=00000000f9f2cf00, length=26624, req=0000000000000000
TOKEN=0x27b08d00
ax88179_eth_recv: second try, len=16464
ax88179_eth_recv: 2 packets received, pkt header at 64
ax88179_eth_recv: return packet of 63 bytes (1 packets left)

TFTP error: 'File not found' (1)
Not retrying...
** ax88179_eth_stop()

Regards,
Jonas
