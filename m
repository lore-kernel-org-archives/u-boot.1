Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1769ED6E2C7
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 17:33:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9697980077;
	Thu, 18 Dec 2025 18:33:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XLtm5g7Q";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JKUXtgaR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84385800AB; Thu, 18 Dec 2025 18:33:33 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9707780050
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 18:33:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dXHnl2Gqvz9t8Y;
 Thu, 18 Dec 2025 18:33:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766079211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C5kNB//CYBg7TEn2wM5yBCUt4B/pt/K8Aom45PYCmCY=;
 b=XLtm5g7QiAsM9o9KCBXDRYklmbJkRBudHNJppjP0ifnIZRNPTkM+9yfaqlEXGC5OM6i7il
 admVGh3VjOwTEFsAsX3MJ05Ae+xHRjaTVHCGk0WC6acIOgM2cihprwQzrI/VN7298FAAGo
 iZ5PZwiqVA22qbd6lD1anAttUMDUzYReSRStN3NzQC6el1Z4D1FJqPUQK2Htnm1n5jzBKK
 bNp9aM4LWmmS8YU71BhlXft57MJ493Av14LDpGyXCEf8WcYPpdiOJqSn8TjO7hjaSrKNgF
 AU/wtcvf6QZtYaov40t65WR8+9VRPkU+0e7Ea6ddAVKhOc8wdudyg7f5RjW1jA==
Message-ID: <730c310e-7587-42ac-8f84-223b0d26d03b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766079209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C5kNB//CYBg7TEn2wM5yBCUt4B/pt/K8Aom45PYCmCY=;
 b=JKUXtgaRf/dtCd4j03lxtKkMiWstsdlV0OWFu0CoEHfRkRwTdDExkPIi4Vf7bUHAit2xPS
 s7PzqG8JyHmYfdrD38P42OP670rKy7yhOPy3U47CH6YIJ+fqMr4/bEihfq3jLgUkDPZg7U
 5dwcjBk8GRW6ITMHj0iCZ1Rh8G9R0mbaXcn9Ek2aCiZdUvM8c8dW4UCvIqPdncZ0LvfbFF
 i8fm3rS8oiHtuhbRAtPkjtAdKXZiHL3XSobetWGV/3bBlca03Pe0WmtXRmUvGMUkdsxSzZ
 TZDLPOUGBE4ZvWJCifDE1A8qs2M2pShwY0IriDObbQ8JwKgryAX36dyc7DlBVA==
Date: Thu, 18 Dec 2025 18:25:29 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] clk: scmi: Fix name defer
To: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Alice Guo
 <alice.guo@nxp.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Valentin Caron <valentin.caron@foss.st.com>, Ye Li <ye.li@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>
References: <20251211-clk-scmi-imx-fix-v1-0-9579567da829@nxp.com>
 <PAXPR04MB8459088345D73E40394E121988AEA@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <030912f8-7bcd-4e4f-a63e-85fa8eb27917@mailbox.org>
 <PAXPR04MB8459F29BBA73A78228B31EFB88AFA@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <PAXPR04MB8459F29BBA73A78228B31EFB88AFA@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: yyuompqm6gfyjn6n6het6uhymrwdd4kh
X-MBO-RS-ID: bb49ada67a02d0c3a45
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

On 12/13/25 12:36 PM, Peng Fan wrote:
> Hi Marek,
> 
>> Subject: Re: [PATCH 0/2] clk: scmi: Fix name defer
>>
>> On 12/12/25 7:32 AM, Peng Fan wrote:
>>
>> Hello Peng,
>>
>>>> Subject: [PATCH 0/2] clk: scmi: Fix name defer
>>>
>>> I see this patchset is delegated to you, mainly because patch 2 is to
>>> fix imx95-blk-ctrl. Since this patchset is based on Patrice's clk scmi
>>> fixes, I am thinking to pick all the scmi fixes including this
>>> patchset to send a PR to Tom for master soon.
>> Please don't, I think this implementation has unresolved questions and
>> frankly, I also think this is completely wrong approach. You should
>> model the relationship between clock in DT using "clock" property and
>> phandles, and then let the U-Boot clock core resolve those
>> relationships.
> 
> Ah, I need to give a look to model it in DT, but the DT is already in
> Linux Upstream. Driver using current DT is broken.
> 
> Without this fix, we need to live with it in this release cycle.
> 
> Updating DT and drivers requires more time.
How does this even work in Linux ? The clock relationships must be 
somehow established there too, right ?

Note that you can always use -u-boot.dtsi to add u-boot specific tweaks, 
ST does it extensively anyway.
