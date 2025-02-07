Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E710C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 21:03:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3870A807AE;
	Fri,  7 Feb 2025 22:03:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ext.kapsi.fi
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ext.kapsi.fi header.i=@ext.kapsi.fi header.b="ramMUhXA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92CD080756; Fri,  7 Feb 2025 21:33:07 +0100 (CET)
Received: from mailserv1.kapsi.fi (mailserv1.kapsi.fi
 [IPv6:2001:67c:1be8::25:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05FF1801DE
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 21:33:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ext.kapsi.fi
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maukka@ext.kapsi.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ext.kapsi.fi; s=20161220; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:Cc:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KBfrkYgulP6jfn5xmuWYqef4bIR1DYW/oKeZKm3ZSSk=; b=ramMUhXAwkNazpf/shqNC+nRpV
 O8Z2icAUtmNupnS4BPymEzEc/Nommox9WOSs0t6qSA1mit63BSbnxkPsk9wFEaIqMiLdyYhQu8Bm4
 agLEvPqCQ82GF8eF5cMHIfglHHBYPgduVbgnKfZoGJrsbFFeNaTY6WxLOUa6UXR5N8ZR+VNZUj6na
 tlYXCYoeqCVRJcElJNgeR/wzkacaNJR90TBAUKsXct3WwmE6Ndj6OKB2EnRT18HKR9sRM/gKPf84A
 gvuN0P0NrfyHsOqrFIDm+EXlWetI7bKBvMJg+B0zhrck+/wrwP8LKLWKC+FShDAOjDwcwnzzodyUO
 oRcEfQaA==;
Received: from 88-113-101-104.elisa-laajakaista.fi ([88.113.101.104]:64550
 helo=[10.0.2.15]) by mailserv1.kapsi.fi with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.96)
 (envelope-from <maukka@ext.kapsi.fi>) id 1tgV28-0051U3-0H;
 Fri, 07 Feb 2025 22:33:04 +0200
Message-ID: <6e37e18c-b501-4e57-a9ac-23ae659fad3a@ext.kapsi.fi>
Date: Fri, 7 Feb 2025 22:33:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: maukka@ext.kapsi.fi, u-boot@lists.denx.de
To: Weijie Gao <hackpascal@gmail.com>
References: <c2572b2b-c4ce-4deb-a110-1cdc4614c642@ext.kapsi.fi>
 <CAN5eEr1-h-p9mZjqpn+aCduc6A9U1F+8t8biKrODimy3AM-hVg@mail.gmail.com>
Content-Language: en-US
From: Mauri Sandberg <maukka@ext.kapsi.fi>
In-Reply-To: <CAN5eEr1-h-p9mZjqpn+aCduc6A9U1F+8t8biKrODimy3AM-hVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 88.113.101.104
X-SA-Exim-Mail-From: maukka@ext.kapsi.fi
Subject: Re: Help needed: How to Specify MTD Partitions on NAND in a Device
 Tree
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on mailserv1.kapsi.fi)
X-Mailman-Approved-At: Fri, 07 Feb 2025 22:03:15 +0100
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

Hi Weijie

On 2/7/25 21:53, Weijie Gao wrote:
> Here's an example:
> https://github.com/openwrt/openwrt/blob/main/package/boot/uboot-mediatek/patches/105-configs-add-usefull-stuff-to-mt7988-rfb.patch#L316

Sorry, I should have been more specific. Actually defining the 
partitions is the simpler part. But the mt7621.dtsi in U-boot tree does 
not contain NAND controller node to begin with and I was not successful 
in defining one. I tried copying/mimicking one from the mt7621.dtsi in 
OpenWrt tree but that did not work out.

At the moment I get NAND working with the raw MT7621 driver only. Can I 
somehow drive it with "spi-nand" or somthing similar?

Mauri
