Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48679C2BA2B
	for <u-boot@archiver.kernel.org>; Sat, 16 Sep 2023 22:36:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A1708556F;
	Sun, 17 Sep 2023 00:36:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="DnnnL4yG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10787854BD; Sun, 17 Sep 2023 00:36:37 +0200 (CEST)
Received: from s.wrqvtzvf.outbound-mail.sendgrid.net
 (s.wrqvtzvf.outbound-mail.sendgrid.net [149.72.126.143])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B462C8556F
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 00:36:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=mime-version:subject:references:from:in-reply-to:to:cc:content-type:
 content-transfer-encoding:cc:content-type:from:subject:to;
 s=s1; bh=sojpvlmAEC/SXAB75gwXq8K/XnwjK1yZXh5wSfyIKro=;
 b=DnnnL4yGJdi6n69ZKfattUcIJTscBWTdP2ACpeACrMWKyTbdZkxfVj/O/WvogmQZ7e7i
 71JA6Nx4/nZfpgsZrdYyj3FDpPqOmqAU95MZHutkzdsmyu+ZqlQ3npcjZ8URN+16LmGfG7
 5KV1rPUxwaiekhKlN7iU1od/xTIce7my5oQLcU+yJxW6ygiaSl7hdACKZvpzVTblafKUdl
 03gkasPVHyioJwbUAC/JCi4MaAGnywa7gyTcRKLDmUc0PaPh9CRzm1iaN56Q4cM4Gys+mO
 ciLhrWExqynvvhhrRw7lfp97j4wbtLdgGNqInLBYPZK5DhX0oWa9Z+Gbq0UjZJcw==
Received: by filterdrecv-7765c6879f-kht5h with SMTP id
 filterdrecv-7765c6879f-kht5h-1-65062DF1-5
 2023-09-16 22:36:33.211591986 +0000 UTC m=+120104.323691084
Received: from [192.168.1.50] (unknown) by geopod-ismtpd-8 (SG) with ESMTP
 id JuYTxpoqS2-UuPiOsxkPZQ Sat, 16 Sep 2023 22:36:32.833 +0000 (UTC)
Message-ID: <5ce50e56-ed40-de94-e2a4-8b55c8006058@kwiboo.se>
Date: Sat, 16 Sep 2023 22:36:33 +0000 (UTC)
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Aw: [PATCH v3] board: rockchip: Add Bananapi R2Pro Board
Content-Language: en-US
References: <20230820160004.44880-1-linux@fw-web.de>
 <trinity-6cf108b4-a879-40e2-a04a-54451262d671-1694873885042@3c-app-gmx-bs23>
 <f00dad5e-bbe7-7a4d-e955-ce317cefb932@denx.de>
 <E81B855A-F7F8-4405-B4A7-8261D55C075D@public-files.de>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <E81B855A-F7F8-4405-B4A7-8261D55C075D@public-files.de>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h+It+BvinUAh1DSel?=
 =?us-ascii?Q?BFWy82=2FO8cL6vtEQAfbDYnkK4exb3iPKLIKTNN5?=
 =?us-ascii?Q?ZYtA+LDR6Xbzes5UA9utZVUcWTAfhe9vMBxSruH?=
 =?us-ascii?Q?1Sa0jAuTdXjo1QWkz5VrqQyObBVxaeB4IGroDj8?=
 =?us-ascii?Q?mu5lsR6BQltL4wM7LKH=2FIHifWZtt5jHDkFPRdR?=
To: frank-w@public-files.de, Marek Vasut <marex@denx.de>, Frank Wunderlich
 <linux@fw-web.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Type: text/plain; charset=us-ascii
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

On 2023-09-16 18:45, Frank Wunderlich wrote:
> Am 16. September 2023 18:07:44 MESZ schrieb Marek Vasut <marex@denx.de>:
>> On 9/16/23 16:18, Frank Wunderlich wrote:
>>> Hi,
>>>
>>> just a friedly reminder. would be great if it can be merged in next uboot-version.
>>
>> +CC Tom
>>
>>> regards Frank
>>>
>>>
>>>> Gesendet: Sonntag, 20. August 2023 um 18:00 Uhr
>>>> Von: "Frank Wunderlich" <linux@fw-web.de>
>>>> An: u-boot@lists.denx.de
>>>> Cc: "Frank Wunderlich" <frank-w@public-files.de>, "Simon Glass" <sjg@chromium.org>, "Philipp Tomsich" <philipp.tomsich@vrull.eu>, "Kever Yang" <kever.yang@rock-chips.com>, "Marek Vasut" <marex@denx.de>, "Jonas Karlman" <jonas@kwiboo.se>
>>>> Betreff: [PATCH v3] board: rockchip: Add Bananapi R2Pro Board
>>>>
>>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>>
>>>> Add Bananapi R2 Pro board.
>>>>
>>>> Till now evb dts could be used, but iodomain is different
>>>> (evb has 1v8 on vccio2 and vccio4 which are 3v3 on r2pro)
>>>> and with iodomain driver this can cause hardware fault.
>>>>
>>>> Devicetree in mainline-Linux:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
>>
>> What would be real helpful is a commit ID from which the DT was copied , so it can be easily updated in the future.
> 
> It is no plain copy...i removed parts not relevant for uboot now (from current linux version). E.g. switch driver is currently bundled in mtk ethernet driver and using different devicetree structure than linux dsa driver. We have to separate it before we can use it on r2pro. But this will take some time...also pcie(-phy) does not have a driver yet,so before adding dead code i dropped these parts for now.

pcie(-phy) should have a working driver for rk3568 as of v2023.10-rc2,
and is extended to support PCIe bifurcation with the following series:

rockchip: rk3568: Fix use of PCIe bifurcation
https://patchwork.ozlabs.org/project/uboot/list/?series=366997&state=*

Regards,
Jonas

> 
> regards Frank

