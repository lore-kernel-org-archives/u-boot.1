Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CC0E77197
	for <u-boot@archiver.kernel.org>; Thu,  2 Jan 2025 22:26:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1955C8031D;
	Thu,  2 Jan 2025 23:26:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B837E80196; Thu,  2 Jan 2025 23:26:10 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A547C8001F
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 23:26:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [IPV6:2605:59c8:31de:bf00:37c2:fe62:c21b:ab46] (unknown
 [IPv6:2605:59c8:31de:bf00:37c2:fe62:c21b:ab46])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id F2BE6B4B3C94
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 23:26:07 +0100 (CET)
Message-ID: <de7bf6b3-fd45-4c8f-a492-bd41db2aa904@freeshell.de>
Date: Thu, 2 Jan 2025 14:26:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: U-Boot Mailing List <u-boot@lists.denx.de>
From: E Shattow <e@freeshell.de>
Subject: LwIP and multiple network interfaces
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

Problem: 'dhcp' must be ran twice when the network cable is plugged into 
a port other than the first network port.

Network cable plugged into bottom (first) Ethernet port:
1. Power on
2. StarFive # dhcp

ethernet@16030000 Waiting for PHY auto negotiation to complete....... done
DHCP client bound to address 192.168.2.51 (3678 ms)


Network cable plugged into top (second) Ethernet port:
1. Power on
2. StarFive # dhcp
ethernet@16030000 Waiting for PHY auto negotiation to complete......... 
TIMEOUT !
phy_startup() failed: -110
FAILED: -110
ethernet@16040000 Waiting for PHY auto negotiation to complete...... done
ethernet@16030000 Waiting for PHY auto negotiation to complete......... 
TIMEOUT !
phy_startup() failed: -110
FAILED: -110
Could not start ethernet@16030000
3. StarFive # dhcp
DHCP client bound to address 192.168.2.77 (31 ms)

Bonus Problem: LwIP allergic to IPv6?
1. StarFive # dns ipv6.google.com
Unhandled exception: Load access fault
EPC: 00000000fff91ddc RA: 00000000fff9e20c TVAL: 0000000000000000
EPC: 0000000040278ddc RA: 000000004028520c reloc adjusted

SP:  00000000ff700040 GP:  00000000ff708e30 TP:  0000000000000001
T0:  00000000ff7001ba T1:  fffffffffe02a8c0 T2:  676f6f6706367670
S0:  00000000ff700308 S1:  0000000000000000 A0:  0000000000000000
A1:  00000000ffffd988 A2:  0000000000000010 A3:  0000000000000000
A4:  00000000fff9e1fa A5:  0000000000000000 A6:  0000000000000001
A7:  0000000000000001 S2:  0000000000000000 S3:  000000000000fff5
S4:  0000000000010000 S5:  000000000000ffff S6:  00000000000000c0
S7:  00000000ff7001b0 S8:  000000000000000a S9:  0000000000000023
S10: 0000000000000000 S11: 0000000000000000 T3:  00000000ff716d50
T4:  0000000000000035 T5:  ffffffffffffffff T6:  00000000ff7001b0

Code: 171b 0187 969b 0106 8f55 bfe9 4501 b749 (411c)


resetting ...

-E
