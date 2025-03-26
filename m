Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB9FC36005
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 02:22:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C3AD810E8;
	Wed, 26 Mar 2025 03:22:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="X/iGN1Fj";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tg0TXZ26";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48A448186D; Wed, 26 Mar 2025 03:22:27 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 114CB800C1
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 03:22:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZMrCh5RdGz9snc;
 Wed, 26 Mar 2025 03:22:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742955744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XljpdfOgLUFrD2Jh3phC237tKB07sRRKiy3jjrX9jwc=;
 b=X/iGN1FjM4VRUlKtAqyu30IS0FE13bhNBiJlbaDqbupRxhPEAPYD+RG5s6Sxl67Ba+8GMx
 abmkUGF+wX2/cEf2HaZss87fIqsGyuE9muYxe9TkSoMfBvkRvkoXF+XdxChXfXnzlmmRs5
 6UCUHtLVwLHB5SMtvsQpAb4wqkORsV19pXhlu6zCyxC6oXQCgMhLggfFuV0chL78Xah+HE
 NgGSEBfwnd0lbQYnAOKjCChK9obgu4kqG5hHf1dXUwS2KuU2Gsw1dLhTXySQZK5OjUDJE9
 KBHfU0aDVRz5cTfZ8GypIkWOSWEWrzOuEIypFuijLlEzEFSR6uolczTPJp7oGg==
Message-ID: <86f01206-563c-43f0-84c0-a23c03302485@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742955742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XljpdfOgLUFrD2Jh3phC237tKB07sRRKiy3jjrX9jwc=;
 b=tg0TXZ26XY/JDskV4PjXHEyxJ4Qs8SIXb635xD65+fck3e90sA7+PhnTPyRF8DE1KcWJ/M
 U2Tpl/TEIK0zfsJ8dSaik+eHQQpd7LiZuq75JMOSYmjlCLwZarbVF/IgrTJoE/hhB0iOfM
 o+G0dTKFkYEpbVTneUcXTudT7d+1t6hXFlFI5JKPDaOZkmvo6RNRBH+uMoNGNqtd+3gVWL
 VdBvOf54gsCJOeFsux4/4yBYf6jxk8vY1iYgx7sfO8bc0YGHHqEkReJaShnAZEx0ohA8oF
 peRUud07dMir+teLPXXXa7MAcQMtWFf3hDDIBlucj9TLKx4YuGZ+hUoVwqjWaw==
Date: Wed, 26 Mar 2025 03:22:20 +0100
MIME-Version: 1.0
Subject: Re: [EXT] Re: [PATCH v3] mmc: mmc_boot: Support Sandisk and Micron
 eMMC BOOT/RPMB hardware partition resizing
To: Luke Wang <ziniu.wang_1@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "trini@konsulko.com" <trini@konsulko.com>
Cc: "pbrobinson@gmail.com" <pbrobinson@gmail.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>,
 "jonas@kwiboo.se" <jonas@kwiboo.se>, "sjg@chromium.org" <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20250325082914.2240470-1-ziniu.wang_1@nxp.com>
 <5005e7ba-1b9a-4d49-9cd6-d48a8341e436@mailbox.org>
 <DU2PR04MB8567774A082F1734BB3703D2EDA62@DU2PR04MB8567.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <DU2PR04MB8567774A082F1734BB3703D2EDA62@DU2PR04MB8567.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: b3p4u7sir6de8tcwrpgtcbe4mjm6rn18
X-MBO-RS-ID: 08673cf248c086afeb8
X-Rspamd-Queue-Id: 4ZMrCh5RdGz9snc
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

On 3/26/25 3:20 AM, Luke Wang wrote:
> 
> 
>> -----Original Message-----
>> From: Marek Vasut <marek.vasut@mailbox.org>
>> Sent: Tuesday, March 25, 2025 10:24 PM
>> To: Luke Wang <ziniu.wang_1@nxp.com>; Peng Fan <peng.fan@nxp.com>;
>> jh80.chung@samsung.com; trini@konsulko.com
>> Cc: pbrobinson@gmail.com; marek.vasut+renesas@mailbox.org;
>> tharvey@gateworks.com; jonas@kwiboo.se; sjg@chromium.org; u-
>> boot@lists.denx.de
>> Subject: [EXT] Re: [PATCH v3] mmc: mmc_boot: Support Sandisk and Micron
>> eMMC BOOT/RPMB hardware partition resizing
>>
>> Caution: This is an external email. Please take care when clicking links or
>> opening attachments. When in doubt, report the message using the 'Report
>> this email' button
>>
>>
>> On 3/25/25 9:29 AM, ziniu.wang_1@nxp.com wrote:
>>> From: Luke Wang <ziniu.wang_1@nxp.com>
>>>
>>> Current mmc bootpart-resize command only support Samsung eMMC
>> BOOT/RPMB
>>> hardware partition resizing. Add Sandisk and Micron eMMC BOOT/RPMB
>> hardware
>>> partition resizing support. The commands and parameters for resizing
>>> partitions are different for each manufacturer. Select the corresponding
>>> function according to CID.
>>>
>>> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
>> I think you missed picking up Peng's RB from V2 ?
> 
> Sorry, I miss Peng's RB.
> 
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
Next time, it would be better to wait for Peng to add their RB again, 
rather than adding it yourself.
