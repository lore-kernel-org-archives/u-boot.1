Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02283CAC592
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 16:36:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FB3A8331F;
	Fri, 19 Sep 2025 18:36:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="oEWiLtjp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15CB383321; Fri, 19 Sep 2025 18:36:45 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FF568329F
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 18:36:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cSynh2vKMz9srN;
 Fri, 19 Sep 2025 18:36:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758299800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WgxWacgak9E7CzQPcreXMxAl+kHpCoXGvOGhwUXm1Lc=;
 b=oEWiLtjpv+bhOU0Y/vn9OqFiaRtnU6r55p0P2/U2TeE/g2xiv4SLu1lHASVeW+K2r6K3Ow
 w/TxBSyJXUbViLaijtyGeTBJiXwlkAFPOOq5Axdkp8N2ikSM1Q2hs8ZQaQnrzuI1tmazZX
 dPj2FeGBHeGvXklhKM47+gXmThTjg44unipHNwPMSskW8RsmPK0AdyP4T6zD1GwyP6FYIP
 bPG6SWwIqhwc6k9ApgPfhh+jzyfvROIg5oRbBjqb6yHww8wI3I26cSCSOS1TA0l3uL6TWw
 riog6DwRVzDSdB/5hrEsUvffv/Q3GveLndIJQrPRmyOjqHvqoTj7mbUvYVUQCQ==
Message-ID: <c019ab11-3f3c-4e3b-9049-5ed31be9c145@mailbox.org>
Date: Fri, 19 Sep 2025 18:36:38 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] cmd: sf: align erase and write on erase block boundary
To: Ye Li <ye.li@oss.nxp.com>, Ye Li <ye.li@nxp.com>, u-boot@lists.denx.de,
 jagan@amarulasolutions.com
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com
References: <20250919070156.1497268-1-ye.li@nxp.com>
 <0528b2bd-09ef-45d4-9003-f8c1baab372b@mailbox.org>
 <220c3246-781a-4349-8d16-6eb1dfdc79e0@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <220c3246-781a-4349-8d16-6eb1dfdc79e0@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 568e0c4332f53c0b42f
X-MBO-RS-META: cnh5dto5d5gi7maqd34krqqh6o9h9cxd
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

On 9/19/25 5:46 PM, Ye Li wrote:
> 
> 
> 在 2025/9/19 20:20, Marek Vasut 写道:
>> On 9/19/25 9:01 AM, Ye Li wrote:
>>> From: Viorel Suman <viorel.suman@nxp.com>
>>>
>>> Align erase and write on erase block boundary in line
>>> with how read was aligned in commit 622b5d35613.
>> What is the issue that is being fixed here ?
>>
> Previous commit 622b5d35613 tried to fix issue that offset is not sector 
> size aligned. But it only use the aligned offset read_offset for flash 
> read, not use it for erase and write. So still unaligned offset send to 
> spi_flash_erase and spi_flash_write.> What is the reproducer ?
>>
> If the address is neither page or sector aligned, we meet issue with 
> flash update
What exact command do I run to trigger the problem, what is the failing 
result without this patch, what is the passing result with this patch ?
