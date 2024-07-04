Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9852FC31D97
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 13:00:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3F5588885;
	Thu,  4 Jul 2024 15:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=desy.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=desy.de header.i=@desy.de header.b="E/iBCyRI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21AA9885D7; Thu,  4 Jul 2024 14:28:57 +0200 (CEST)
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de
 [IPv6:2001:638:700:1038::1:9b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B660288363
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 14:28:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.huesmann@desy.de
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de
 [IPv6:2001:638:700:1038::1:a5])
 by smtp-o-2.desy.de (Postfix) with ESMTP id 3DCB713F641
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 14:28:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 3DCB713F641
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
 t=1720096134; bh=5fOr7VpB12JJZhg4SfYxMpKmF8DnI8JF0T38gKoKDnk=;
 h=Date:To:From:Subject:From;
 b=E/iBCyRIz54FSyHUVuN2DBY7W8AwhiqBAY0yUwe4eNYLd6LNDJ67PgaA/KYO79XKj
 X76KRGn9P7qHZSopEMJBTKndKmIjo4acbp0txrmYUKNSy+1JqBJjb4hgt2cBMqwAA/
 LHcd5dEMukMNmLRXNKNtYh51SdfXVj4AhwShPL68=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [131.169.56.129])
 by smtp-buf-2.desy.de (Postfix) with ESMTP id 32E14120038
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 14:28:54 +0200 (CEST)
Received: from c1722.mx.srv.dfn.de (c1722.mx.srv.dfn.de
 [IPv6:2001:638:d:c303:acdc:1979:2:e7])
 by smtp-m-1.desy.de (Postfix) with ESMTP id 2982C40040
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 14:28:54 +0200 (CEST)
Received: from smtp-intra-1.desy.de (smtp-intra-1.desy.de
 [IPv6:2001:638:700:1038::1:52])
 by c1722.mx.srv.dfn.de (Postfix) with ESMTP id 927FFA0038
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 14:28:53 +0200 (CEST)
Received: from z-prx-6.desy.de (z-prx-6.desy.de [131.169.10.30])
 by smtp-intra-1.desy.de (Postfix) with ESMTP id 6F7F2800C3
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 14:28:50 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by z-prx-6.desy.de (Postfix) with ESMTP id 622F12400E2
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 14:28:50 +0200 (CEST)
Received: from z-prx-6.desy.de ([IPv6:::1])
 by localhost (z-prx-6.desy.de [IPv6:::1]) (amavis, port 10026) with ESMTP
 id Yo2YXDrV0HSH for <u-boot@lists.denx.de>;
 Thu,  4 Jul 2024 14:28:50 +0200 (CEST)
Received: from [192.168.111.22] (bastion09.desy.de [131.169.5.75])
 by z-prx-6.desy.de (Postfix) with ESMTPSA id 426A12400D9
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 14:28:49 +0200 (CEST)
Message-ID: <59b7d539-d65e-44e9-94b1-c04871d80ecf@desy.de>
Date: Thu, 4 Jul 2024 14:28:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: u-boot@lists.denx.de
Content-Language: en-US
From: Patrick Huesmann <patrick.huesmann@desy.de>
Subject: zynq_gem without PHY
X-Mailman-Approved-At: Thu, 04 Jul 2024 15:00:45 +0200
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Dear U-Boot devs/maintainers,

We are running Xilinx MPSoC based MicroTCA mezzanine boards that, 
according to the MicroTCA standard, connect to the crate's Ethernet 
switch via a 1000BASE-BX interface at the backplane (the interface is 
basically equivalent to a SFP module; we actually have a bring-up 
adapter that uses a SFP module to replicate the Ethernet functionality 
outside a MicroTCA crate).

Most of our boards use a PHY in RGMII -> 1000BASE-X mode, but on some 
other boards a MPSoC MGT is wired directly to the backplane without a 
PHY in between (and the GEM set to 1000BASE-X mode accordingly). Now the 
Xilinx GEM driver (drivers/net/zynq_gem.c) assumes there is always a PHY 
connected to the Ethernet interface, and aborts the GEM initialization 
if there is no PHY found.

In a previous U-Boot version, I have patched zynq_gem.c to just ignore 
absence of a PHY, but the recent version of the driver 
accesses priv->phydev quite a lot - so it required a bit of effort to 
port the patch. Now I'm wondering if I should clean it up and try to 
upstream it. (Basically, if priv->phydev is null, don't touch it, 
disable autonegotiation and use speed setting from devicetree). Would a 
patch like this have any chance of getting upstreamed?

Thanks and best regards,
Patrick

—

Deutsches Elektronen-Synchrotron DESY
A Research Centre of the Helmholtz Association
Notkestraße 85, D-22607 Hamburg
E-Mail: patrick.huesmann@desy.de
Web: https://msk.desy.de/
