Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF773C02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 13:32:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CE4F8083C;
	Sat,  8 Feb 2025 14:32:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ext.kapsi.fi
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ext.kapsi.fi header.i=@ext.kapsi.fi header.b="L8vDsnVu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE11D80812; Sat,  8 Feb 2025 10:04:06 +0100 (CET)
Received: from mailserv1.kapsi.fi (mailserv1.kapsi.fi
 [IPv6:2001:67c:1be8::25:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45EAA80141
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 10:04:04 +0100 (CET)
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
 bh=AcvHQvlZPgpZzOOLS4PumlietHfVxlozia9EOc5Tht4=; b=L8vDsnVuCeAawDMDyy13BQH5tg
 2NoZfQuxAzUZrhCp37/t99YsWtwKKm0aYjfW2wUiVEd26CN0RofdHqHc+foeA7n9WwNyk0zZyaBH3
 BIQWhm3Dmtq3zyPv3J1cfJiTyLofvUG//JFdYcfkQnHAg127aR6Y1lcRk7SduSNEmI76oAJRcp+IA
 M5v5KAV37boeErxSNs5CRFtqu4hiFc9geV/lxgfUOhX972ShtnRbnsDcp4IrhNkUV5iHpJ+Kt2whL
 mQcdVnPT20/SSWrWsXjc9UzGk9MkiO80FZKjeKPZ40Z55kKYzi14qcXD8dXVsMzSSeevhoUt/gohs
 vVkC8oGg==;
Received: from 88-113-101-104.elisa-laajakaista.fi ([88.113.101.104]:49327
 helo=[192.168.7.116]) by mailserv1.kapsi.fi with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.96)
 (envelope-from <maukka@ext.kapsi.fi>) id 1tggkt-005OmI-1i;
 Sat, 08 Feb 2025 11:04:03 +0200
Message-ID: <38cd600e-5dec-428e-bb31-b80459abad1c@ext.kapsi.fi>
Date: Sat, 8 Feb 2025 11:04:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Mauri Sandberg <maukka@ext.kapsi.fi>, u-boot@lists.denx.de
To: Weijie Gao <hackpascal@gmail.com>
References: <c2572b2b-c4ce-4deb-a110-1cdc4614c642@ext.kapsi.fi>
 <CAN5eEr1-h-p9mZjqpn+aCduc6A9U1F+8t8biKrODimy3AM-hVg@mail.gmail.com>
 <6e37e18c-b501-4e57-a9ac-23ae659fad3a@ext.kapsi.fi>
Content-Language: en-GB
From: Mauri Sandberg <maukka@ext.kapsi.fi>
In-Reply-To: <6e37e18c-b501-4e57-a9ac-23ae659fad3a@ext.kapsi.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 88.113.101.104
X-SA-Exim-Mail-From: maukka@ext.kapsi.fi
Subject: Re: Help needed: How to Specify MTD Partitions on NAND in a Device
 Tree
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on mailserv1.kapsi.fi)
X-Mailman-Approved-At: Sat, 08 Feb 2025 14:32:37 +0100
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



On 7.2.2025 22.33, Mauri Sandberg wrote:
> Hi Weijie
> 
> On 2/7/25 21:53, Weijie Gao wrote:
>> Here's an example:
>> https://github.com/openwrt/openwrt/blob/main/package/boot/uboot-
>> mediatek/patches/105-configs-add-usefull-stuff-to-mt7988-rfb.patch#L316
> 
> Sorry, I should have been more specific. Actually defining the
> partitions is the simpler part. But the mt7621.dtsi in U-boot tree does
> not contain NAND controller node to begin with and I was not successful
> in defining one. I tried copying/mimicking one from the mt7621.dtsi in
> OpenWrt tree but that did not work out.
> 

With fresh pair of eyes I found that the 'mt7621_nand.c' in OpenWrt tree
implements what the U-boot version is lacking and that they are both
your work. Are there plans for bringing device tree support to U-boot or
would you be able to review/assist if someone tried it?

Thanks,
Mauri
