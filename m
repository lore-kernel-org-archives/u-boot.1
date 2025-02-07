Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054C7C02196
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 19:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BC38807D7;
	Fri,  7 Feb 2025 20:06:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ext.kapsi.fi
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ext.kapsi.fi header.i=@ext.kapsi.fi header.b="lDiQbjHw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C86C80207; Fri,  7 Feb 2025 18:54:46 +0100 (CET)
Received: from mailserv1.kapsi.fi (mailserv1.kapsi.fi
 [IPv6:2001:67c:1be8::25:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EA0C800B3
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 18:54:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ext.kapsi.fi
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maukka@ext.kapsi.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ext.kapsi.fi; s=20161220; h=Subject:Content-Transfer-Encoding:Content-Type:
 From:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HOBEJbQM7ow3GVr+iAvd/eBGI7mbndhBpB+DdW0/Dsw=; b=lDiQbjHwWeAaHKvG0dGBEMVxvr
 viXOXjN1olBPUy5uZCe7Y6OReiyMQjMyK5+0dTLdURsJrE45X2S2L0xOQ14SUvB9VUwUZtm2lpeRS
 nQqA3AjoqHiiqqA6PL6c8Q8Xh5CeEifJpSTD7/HXRmUhMPGOfrUDkl3hzwf4XBkUGgGrglcThgMwq
 B5PrmfNIfwi6V/z5h3ubMGcBSiwZf0ZpkVWAqK5asTmHDIThWx5Bj/nLfZssYuibLVOyrzxV8skE9
 CMdYEvK7udF1kkzEUrjJl00WMz9jNUns/crOuu3e9S/85hZnVCqxAOrodnyxLfKJDIrs12JPbVjGH
 ACKsCTdw==;
Received: from 88-113-101-104.elisa-laajakaista.fi ([88.113.101.104]:63835
 helo=[192.168.7.116]) by mailserv1.kapsi.fi with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.96)
 (envelope-from <maukka@ext.kapsi.fi>) id 1tgSYt-004w9b-1B;
 Fri, 07 Feb 2025 19:54:43 +0200
Message-ID: <c2572b2b-c4ce-4deb-a110-1cdc4614c642@ext.kapsi.fi>
Date: Fri, 7 Feb 2025 19:54:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: u-boot@lists.denx.de
Content-Language: en-GB
Cc: Mauri Sandberg <maukka@ext.kapsi.fi>
From: Mauri Sandberg <maukka@ext.kapsi.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 88.113.101.104
X-SA-Exim-Mail-From: maukka@ext.kapsi.fi
Subject: Help needed: How to Specify MTD Partitions on NAND in a Device Tree
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on mailserv1.kapsi.fi)
X-Mailman-Approved-At: Fri, 07 Feb 2025 20:06:26 +0100
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

Hello all,

I have a MT7621A basec SoC, which I am trying to update the boot prcess
for. As it is now, I have v2024.10 based U-boot running and I can
specify MTD partitions using env variable 'mtdparts' and use them all
right. But I am looking for a way to specify them in a device tree.

Linux identifies the flash chip as:
[    1.830000] nand: device found, Manufacturer ID: 0xc8, Chip ID: 0xda
[    1.840000] nand: ESMT NAND 256MiB 3,3V 8-bit

If someone can give my any pointers it would be much appreciated.

Thanks,
Mauri


