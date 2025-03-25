Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FD5C35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 14:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C1A2808B6;
	Tue, 25 Mar 2025 15:14:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nTHxxU/b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CDD480EEF; Tue, 25 Mar 2025 15:14:29 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9AF2808AF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 15:14:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZMX3h4bb6z9tWj;
 Tue, 25 Mar 2025 15:14:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742912064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+2lxbh5phLFHLwWb3/Q3CB25kVXO/9bTDYqflcqalkc=;
 b=nTHxxU/bWKrpk/0owpR6epIczNd3VGc9bhYZ2Pvf2/tIIKzmF5wpzaxKyBYCLhrGcfSMrO
 kWtp3o4ZDU/7zAih4BnL4ttk4calAykCQVBt5xFOSm/29EIfQepmHNV84yWZCHE12yobgu
 76gkRMepBxodrXw8B+xx8V3ewt7wYqMOjgf7QXN4wa8zBXUmXbEJ/0VpVX+4CewiWciiHJ
 QBPeDJzeTBMwlUO3PGtOJQQ5SGkaFlJnEGWDEviBoHbgw1bfw+skfczPSCok1HBsJtMjfi
 YOEBqgd2NKys/eAwMpAMbV77F3P3Wn3A7SaOqkfd1MI59gx9v2jo1OhZjKXFQg==
Message-ID: <fd77d34f-835a-4186-893f-b3d8071ce662@mailbox.org>
Date: Tue, 25 Mar 2025 15:14:20 +0100
MIME-Version: 1.0
Subject: Re: [PATCH V4 4/7] cpu: imx8_cpu: Print Speed grade if IMX_TMU.
To: Adam Ford <aford173@gmail.com>, Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>, Enrico Leto <enrico.leto@siemens.com>,
 Peng Fan <peng.fan@nxp.com>, Yannic Moog <y.moog@phytec.de>,
 Gilles Talis <gilles.talis@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ye Li <ye.li@nxp.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20250325025452.950303-1-aford173@gmail.com>
 <20250325025452.950303-5-aford173@gmail.com>
 <6f58a557-d5b4-4bc7-87b0-6ed626ec534a@mailbox.org>
 <CAOMZO5CT0uevQaPWPAHM0qVULy+f6rsbwE72Kkph48ghpOSKkQ@mail.gmail.com>
 <CAHCN7xJoJYmZCG7e+zv3cJc8B460kqWpz8v-KibsVsHJzbpjUA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAHCN7xJoJYmZCG7e+zv3cJc8B460kqWpz8v-KibsVsHJzbpjUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 976a4f58c1a6d477f65
X-MBO-RS-META: xybaqb9u4ostehypj6hsipncf94mhydf
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

On 3/25/25 1:37 PM, Adam Ford wrote:
> On Tue, Mar 25, 2025 at 6:36 AM Fabio Estevam <festevam@gmail.com> wrote:
>>
>> On Tue, Mar 25, 2025 at 12:37 AM Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>>> Please drop the fullstop at the end of Subject and then add
>>>
>>> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>
>>> To the whole series.
>>
>> Adam, no need to resend. I will take care of it, thanks.
> 
> Sorry about that...again.  Thanks.
> 
> Once this is complete, I'll have a smaller patch series which shrinks
> my 8MP SPL code by around 4k by #ifdef'ing out dead code.  Hopefully
> it's not too cluttered, but that smaller series depends on both the
> UART clock and the CPU_IMX updates.
Nice, thanks !
