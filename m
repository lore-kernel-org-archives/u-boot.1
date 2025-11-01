Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE5DCCF9F8
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 11:54:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22B8183A1E;
	Sat,  1 Nov 2025 12:54:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bvAJHw5s";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kQhuhaSU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85C4483A24; Sat,  1 Nov 2025 12:54:51 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6670583A1B
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 12:54:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4czGVc6H25z9t0n;
 Sat,  1 Nov 2025 12:54:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761998088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=05vT8naUnAJVfnBV06wNbWvqWwXknGGCZ2NtxfDDR3I=;
 b=bvAJHw5simFQUKUiYw7jF6whctG5fbqgisJ1DimwPbPH+hAxyij7a3CrbMv9irVX6GKOMz
 649+89CJigE3jLCvxXtHHjEitkaTnf+TaWqQT37Shgu7eY6frqzH4eE7Vk7Pmlrz4VP3wY
 lDlzOiv1hjiSkdRyVU8T+E6GVpPuxNcteHNclyrWRHlRcDqwSG311kPUDU4/WmedPCij25
 tNtTtMfbSIHi/xJKK0Sck6IceYmbuxFx5PJLhkK5xcjBERt7y+sTqFP+8rpLmfICxOWY4F
 F9rnBlsRdN76nQVBeJJyVlo9PtHGdDrp7GMgVjFeugvMPVr0hwXyBbfnLTiW+g==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=kQhuhaSU;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <1fc25e78-4a7c-4471-b381-f35e69a8d5d8@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761998087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=05vT8naUnAJVfnBV06wNbWvqWwXknGGCZ2NtxfDDR3I=;
 b=kQhuhaSUFIHGtWwu9mYgAVG6Ppmzx40RT60AGAkZuUJHpHHJwkf7HfLotoeJBx1/PEsA3I
 s236kkKnpAwFZu7NGfI47rDOzVBuouw0u/RxL9E96cESffTudFdB3x9cHbb7lzeMuooHOT
 /iamo7j+2muL0f/UcHVOYcfTEgyWyYqGDsg18EtQCj0CAs/Cg0kf0pW/21gMN+UZZNnOcn
 JbZxS+vvkMqkSjqN0DvvtpZXJPZzHTgI/oiIZ7S4Cc+50PjwLX73VCcjJcExHJhXKeE4us
 FSLoyVxhuAsw+6LbRTum8z5T3dF22rGQochc52We51zbL1iJppfh38VTEEiQ3g==
Date: Sat, 1 Nov 2025 12:54:42 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 5/5] net: phy: aquantia: use generic firmware loader
To: Beiyan Yun <root@infi.wang>
Cc: u-boot@lists.denx.de, Yao Zi <ziyao@disroot.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini
 <trini@konsulko.com>, Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Weijie Gao <weijie.gao@mediatek.com>
References: <20251031152348.60571-1-root@infi.wang>
 <20251031152348.60571-6-root@infi.wang>
 <9942f1d3-669e-48a6-923a-c2607eafdd02@mailbox.org>
 <FEAA3555-3109-41E7-A58F-5B601B6C2FB5@infi.wang>
 <a8f176dc-59c3-4af4-88ed-03d064f2e7c2@mailbox.org>
 <8968863B-CFDC-4EE9-9062-08219AC0838E@infi.wang>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <8968863B-CFDC-4EE9-9062-08219AC0838E@infi.wang>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: yehkmqcpo3k1nhngn4abss5bryeiqjue
X-MBO-RS-ID: b5d9bc119efbf3a2265
X-Rspamd-Queue-Id: 4czGVc6H25z9t0n
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

On 11/1/25 8:45 AM, Beiyan Yun wrote:

Hi,

>>>> Can you not use the plain FW_LOADER to load the firmware from either storage, UBI or Block ? Is FS_LOADER even needed ?
>>> Thanks for the suggestion, and yes you can, but that API is script-only—it expects the board to stage the blob and just copies from the address exposed via *_addr/_size. The current users of this driver expect the old pattern: the bootloader mounts a filesystem (MMC before, now possibly UBI/USB/etc.), reads the firmware, and applies it. Keeping an fs-loader node in the DT is effectively the same contract as the legacy MMC setup, just generalized.
>>
>> Can you maybe write a script which implements the old loader behavior in a compatible manner ?
>>
>>> The fs_loader driver gives us several things the script path doesn’t: a standard way to describe the storage via "/chosen/firmware-loader"
>>
>> Try this:
>>
>> "fdt addr $fdtcontroladdr ; fdt print /chosen"
>>
>> And then look at the "fdt" command and what it can do regarding reading content of DT properties into variables.
>>
>>> , runtime overrides through "storage_interface/fw_dev_part/fw_ubi_*, and no requirement for a board-specific script. So FS_LOADER isn’t redundant—it’s the part that replaces the hard-coded MMC flow with a configurable backend, while the script helper stays available for boards that want extra logic.
>> Maybe a more generic script can be a replacement for the older hard-coded approach ?
> 
> Fair enough, I’ll remove fsloader for now.
> 
> I still believe it would be valuable someday: if reading from nvmem cell is implemented, the same DT could be used for both U-Boot and Linux.

See example above, you can read anything from the U-Boot control DT both 
in U-Boot shell and in U-Boot env scripts, using 'fdt' command .

-- 
Best regards,
Marek Vasut
