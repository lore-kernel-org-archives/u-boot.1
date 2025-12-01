Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798E3D116F1
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 01:44:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1121683D8A;
	Tue,  2 Dec 2025 02:44:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="sMYFDk6K";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="d0AEpf5A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D66383DCA; Tue,  2 Dec 2025 02:44:26 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86AA383CF3
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 02:44:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dL3Tz1fWhz9tcx;
 Tue,  2 Dec 2025 02:44:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764639863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LOefFkiU6lwqvs8iTA/7Tuagh5vRckCn5pixdRphb5A=;
 b=sMYFDk6KitXvMpueM41CPkDWSGFecq1o/T3U166t/vOD4CPwcCsZQpDvdaM/YXdvaQaLyW
 Tq+P3Pg9gky9+gtiz1iCFbZFSYPzXrkhCw9G6vl7JOwMD/os/NnFIEyF5T2UZKh5WAPvW6
 kjYN7EjYnRTCJbw0jHgQgMyoHgW7YvOftezM5zGvLjKzCKY3t6K/dZtIV0q3YKGIi3Fo2j
 zsZba5Nhwd65MLT40UlJ6XgqxgwhVCkWGSCav27mDnDrfQwzweYtFijy71pr71lePQ2Gly
 Snvnkgnef2zUMhcCzryXQKPhnaqH87AAJzIclRnyMblPLF1tOQgUdslLxsHKyg==
Message-ID: <696b2ac3-a68e-453a-87bc-89228a54c9b8@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764639861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LOefFkiU6lwqvs8iTA/7Tuagh5vRckCn5pixdRphb5A=;
 b=d0AEpf5A8ACvrSq3ZFDSToroLCdg6GcUsoG/SUsjZz35qiwCx2kosMzbS7jizeuum9nuSx
 bN2qMImTjkA1ChEj9QqOWerzEZ+1zUiW9SS1CaGIv/3xOHzrD7G/HntOETxXbfpE7NoUHI
 9+XJedKVgFbfC0i+juRukz/UdKHuY/fq4jQ5vlMhh0ZBesAOBPeswAvj/Yt1IjytK/TsAI
 lbub9HgqAfErwuF6yZlESWcQTDZWDhXzs6Zhj2mmTz3hjWjNZJwQF4Xnf8cT77LJzjHPVu
 PvctWBPEfDUkL8NJyDFGbc8ItqpNw0cAyUE1FudA8koEPKSlCw366A4/EA8KRg==
Date: Mon, 1 Dec 2025 18:47:19 +0100
MIME-Version: 1.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYxIDEvNF0gZWhjaS1teDY6IEFkZCBw?=
 =?UTF-8?Q?owerup=5Ffixup_implementation?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 dl-uboot-imx <uboot-imx@nxp.com>
Cc: Marek Vasut <marex@denx.de>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Stefano Babic <sbabic@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 David Zang <davidzangcs@gmail.com>, Alice Guo <alice.guo@nxp.com>
References: <20251128-usb2-v1-0-25ec5ac127ff@nxp.com>
 <20251128-usb2-v1-1-25ec5ac127ff@nxp.com>
 <a016c693-071e-47f2-b5a8-f03ccaa7a7f9@mailbox.org>
 <PAXPR04MB9644482227D883EDAF12D3A9E2DBA@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <PAXPR04MB9644482227D883EDAF12D3A9E2DBA@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f0aeeebe868513741d9
X-MBO-RS-META: hd93gjbezpc59zc5gt17q9y58r79nand
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

On 12/1/25 12:07 PM, Alice Guo (OSS) wrote:

>>> This sequence is ok for our IP when the delay time is exact. But when
>>> the timer is slower
>>
>> How can the timer be slower ? Maybe there is some bug somewhere else ?
> 
> On i.MX8ULP, the A35 system counter uses the internal LPO. The trimmed frequency of the LPO is not as accurate as an external oscillator.
How much does it drift ? Details please ?
