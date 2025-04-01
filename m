Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96B0C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 12:33:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F58082145;
	Tue,  1 Apr 2025 14:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Gc9UGBUq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05048820A0; Tue,  1 Apr 2025 14:27:25 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9148480050
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 14:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id C41F7A446B4;
 Tue,  1 Apr 2025 12:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905CEC4CEE8;
 Tue,  1 Apr 2025 12:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743510441;
 bh=JJK/Jvstga/xytDPJ0YYePDla9tz+ymrmir980rFjA8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Gc9UGBUqRODWEEvRnLCIqT1lVPk+W6YTBb5Z3naM4MuQ7ydXj17SVlaq5BagzmkOS
 j1HrpGct57Td0t+SIZWQhNPOZeoelN4oypWMYHc1X4YuS0yTEY2JDXadLrDpve3C7J
 +H/WOYOAd7F/T5oS0wwSP0UosTSrlrx6yoI+yuRjbqfmWfDae7Tb78Q9HMnO9FG0+G
 Cmrx6aAm0LScx3iHkzK4aeS8pjJ96fTLrIYd8MnZoxDDLVM0ioxjFOENAvuMpLr2qW
 q+ZVnGU4cBCdZvh/ZJD7jGvmJxR4AJN3nMQ9Cs1NHs4y3VG4lAOktB/yYOHnlsV8YQ
 4U+B5IFlEEvMg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Eugen Hristev <eugen.hristev@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Zixun LI <admin@hifiphile.com>, Tom Rini
 <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/3] ARM: dts: sam9x60: Add USB gadget DT node.
In-Reply-To: <ff98b27c-07d8-4f49-9696-fd09ab2ab499@linaro.org>
References: <20250331162611.1557759-1-admin@hifiphile.com>
 <20250331162611.1557759-3-admin@hifiphile.com>
 <87v7ronqdw.fsf@baylibre.com>
 <ff98b27c-07d8-4f49-9696-fd09ab2ab499@linaro.org>
Date: Tue, 01 Apr 2025 14:27:17 +0200
Message-ID: <87msd0nk2i.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 01 Apr 2025 14:32:32 +0200
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

On mar., avril 01, 2025 at 13:40, Eugen Hristev <eugen.hristev@linaro.org> wrote:

> On 4/1/25 13:10, Mattijs Korpershoek wrote:
>> Hi Zixun,
>> 
>> Thank you for the patch.
>> 
>> On lun., mars 31, 2025 at 18:26, Zixun LI <admin@hifiphile.com> wrote:
>> 
>>> Add the USB gadget DT node for the sam9x60 SoC's.
>>>
>>> Signed-off-by: Zixun LI <admin@hifiphile.com>
>> 
>> Nitpick: title (subject) should not finish with a period (.)
>> 
>> This can be fixed up by the maintainer that will apply the patches.
>> 
>> Eugen, This is assigned to me on patchwork:
>> https://patchwork.ozlabs.org/project/uboot/list/?series=450655
>> 
>> Can I pick up all 3 patches or do you prefer to pick up [2/3] and [3/3] ?
>
> It is better that I take these two, because there are some pending
> changes on the same DT for the next merge window, so it would avoid
> conflicts.
> Reassign them to me in patchwork please.

Sure, that works. Assigned to you.
Thanks !

>
>> 
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>> 
>>> ---
