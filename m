Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4236CA1007
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 19:41:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE11E83A13;
	Mon,  1 Sep 2025 21:41:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uBb8kabL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2AA783A1A; Mon,  1 Sep 2025 21:41:11 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BC5E83990
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 21:41:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cFzkq05qqz9scL;
 Mon,  1 Sep 2025 21:41:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756755667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X1qfVvl+ID4bkTE6eZCZ+mT5G6j0wyRSn+ayqFWKJks=;
 b=uBb8kabLX0PmiWjyo9xPrd3J4Nm1712gxyhyjphT3hk9qNfEgI33DC4iPPQFOOC9hTKffw
 WV6VBX05cNPjuDlzV9GT2iKm3mwANT2wMrEgeN6I05Nk0LPRZV35Iacly3QCpjiXNw89/s
 lt14qgnqEQ14u20b45zJ6EtfJIeThJDBszFRsK04ooKXAc6yDjKNsjmbrhP1YRjVz6/9c+
 D6dI6M/sCe4Ksu3xb4bOH7lC/c+vDklpBMnT4LE/x/8U2o7f9SdXrN1l5Y2P6oP4AmnZXX
 6Whd9thCB4vs85hjughbRDILKUPO6WJgKmblXO0+OPF01d+9+L2YIP59qEBICA==
Message-ID: <536f87e8-2da9-4169-9575-a1a1e9d2a2ea@mailbox.org>
Date: Mon, 1 Sep 2025 21:41:03 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] Image size checks: Remove HAS_BOARD_SIZE_LIMIT
To: Philip Oberfichtner <pro@denx.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <michael@walle.cc>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>
References: <20250807102436.452691-1-pro@denx.de>
 <20250807102436.452691-2-pro@denx.de>
 <eac8672f-e90b-42e9-9efd-d94fcc8c1f17@mailbox.org>
 <20250807162115.GZ124814@bill-the-cat>
 <06dd9037-af3d-48a3-974e-80db481c7121@mailbox.org>
 <20250807201142.GC124814@bill-the-cat>
 <4813ce12-ad82-4170-999c-e5f816a42708@mailbox.org>
 <20250807232421.GD124814@bill-the-cat> <aJmuxlTEFT4R7HR_@antares>
 <83fd6db4-dc76-4f5d-9abf-9673b81eea14@mailbox.org>
 <aLVpfP1anv7UJzzQ@pollux.denx.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aLVpfP1anv7UJzzQ@pollux.denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: dyyxr7qp9n5wdj1ucskjiak1opf8ao4b
X-MBO-RS-ID: c4079d5e3c244721beb
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

On 9/1/25 11:38 AM, Philip Oberfichtner wrote:
> On Thu, Aug 28, 2025 at 11:44:50PM +0200, Marek Vasut wrote:
>> On 8/11/25 10:50 AM, Philip Oberfichtner wrote:
> [...]
>>> 	CONFIG_HAS_UBOOT_WITH_SPL_SIZE_LIMIT
>>
>> What does this one do ?
> 
> UBOOT_WITH_SPL_SIZE_LIMIT will be required for my currently pending mips
> board support, see here:
> https://patchwork.ozlabs.org/project/uboot/list/?series=468232.
> 
> In the next version, I'll include all size limit related patches in THIS
> series. Sorry for the confusion.
Do it the other way around, finalize this series as a clean up only, and 
do additional features in follow up patches .
