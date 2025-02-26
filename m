Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1527BC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 12:43:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D5FB805C3;
	Wed, 26 Feb 2025 13:43:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IsRIi9oj";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rKtr6qHK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6536B80805; Wed, 26 Feb 2025 13:43:38 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A341801DE
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 13:43:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Z2vKN05zxz9str;
 Wed, 26 Feb 2025 13:43:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740573816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cEtk/oDWKfq+9d2+DjZWFVtg64wLHOExLF97/NBLwew=;
 b=IsRIi9ojdMuJMVR11UVHu9m+oovC+TX0IXhril4j1yDpEhpaDTFfFSe3HUa36L59H3YeCt
 VlVHu84MXXWXrkJlNsvERt2gU19xUL5ZJq19cs4J26qiaiLQwk02eIaV/95md+qXNzi/ss
 V/C3Sj8OVOEoqyakPoRtYw9FNIrMC9gmDm7EUqqUvqnZ2x04caVhZ+Pj199T6U8f8ZMv6L
 DLvj3kXe8mv3HQxaFdYKUkCg6cDHtjg/9xNV5PWx0A7IUasOnBnVMZUqjiqKuOKwjBucqQ
 h1SWaC+jKjylRZor3lGlvSprrPn5MT93XfHfZvJJdlZSLBA/YYppqFwxSfP2rQ==
Message-ID: <3c517906-7609-4145-9b84-b13616b75a06@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740573814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cEtk/oDWKfq+9d2+DjZWFVtg64wLHOExLF97/NBLwew=;
 b=rKtr6qHK45a2ThOdxB06NqlnrKPY/13YiHwgMFa4CxyrRky/1K/YmX84hSsmPHTylv9MWi
 OCKdPwXeYvxewoisuV7mBK1UjuisrIAjkTRTFfNF51u1LwZKGXn7uTUZyWxBpBHOEz6eC5
 tap68QrY3x6gJ+ziqvTke/7iKExRo8vunstOrHDVNxkULkQ0pVeBS/pm0WUfQoSxr2+QQ6
 lZQCNHn1lDnQmtDu5cb4rxOabN5D9czELzTuyQjuPE+oXi5vFCHp3KM7tb6pBbEZmU/L7y
 TAeu0m2Nqdwlzyilv62PpR+2rqrQRy+e8B+sL21QvdpwXBibvtAapDSvOJQ8TA==
Date: Wed, 26 Feb 2025 13:43:29 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 00/23] net: miiphybb: Get rid of global
 bb_miiphy_buses[]
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, Jim Liu
 <JJLIU0@nuvoton.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Ramon Fried
 <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
 <66a71c2b-d8b2-4df9-ba20-2852e568a2fd@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <66a71c2b-d8b2-4df9-ba20-2852e568a2fd@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 3j6kar6zkiz8p6fp7bd4pat8o1twejr5
X-MBO-RS-ID: 2bd398563cf57aeae92
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

On 2/26/25 9:51 AM, Paul Barker wrote:
> On 22/02/2025 20:33, Marek Vasut wrote:
>> Get rid of global bb_miiphy_buses[] which does not fit well with U-Boot
>> DM in favor of usual per-ethernet-MAC-driver-instance MDIO bus accessors.
>>
>> Introduce the ability to allocate struct bb_miiphy_bus {} and make it wrap
>> struct mii_dev {}, so the struct mii_dev can be passed into MDIO bus access
>> infrastructure as usual. When the MDIO bus access infrastructure attempts to
>> access the MDIO bus and invokes any of the bbmiiphy accessors, those accessors
>> are passed the structu mii_dev {}, but can also access struct bb_miiphy_bus
>> using plain container_of() .
>>
>> Clean up the drivers and update them to match.
> 
> I think this series looks ready to merge so I'll start rebasing my
> RZ/G2L Ethernet patches on it.
> 
> Thanks Marek!
Can you please fill in the RBs to patches which are still missing them, 
so I am not applying my own stuff without RBs ?

(and yes, there will be a follow up series which deduplicates the ops, 
that is not forgotten)
