Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26154CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 12:25:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9632D808AF;
	Tue,  4 Nov 2025 13:25:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bMEpa89z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1DAA82A9E; Tue,  4 Nov 2025 13:25:26 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3E678003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 13:25:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4d172V65XNz9v33;
 Tue,  4 Nov 2025 13:25:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762259122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=km0373sFx5PtUU7+15SFRGzvlKxmwbUvHETzDwboTd4=;
 b=bMEpa89zq90AnEARIW8nBOQOW8p+XEAE1LHCFSN31WpwxCO6vWT/tcIX4pFAa2yrLqH8/U
 OiB9cuIv2BcqYSMJoHeBaqGm0u2MREgEPnm5rT1aJMBncSSOKAOwsC6yLEX1dauAQTJNcZ
 k0SRo00bmn19xp6x9QLCGe85Yvqc76xCWAJs/p+QCmMfrnA5ZHldxo8ik0sf+//eeN0EBI
 E8aATtY7vOCQWZpFD0bp9R+rMFnQbVvIwrT8BsSgcilf4Ljzj90O1zTXd1T1uDhn5HTv9g
 j7G22bL7Fy5mWsGyD+uxtdhrnbYnTFZ1iVOsVgIr6tA/FXt43lNiArm5ltMDpg==
Message-ID: <97a6fc63-499c-40cf-8406-d47bfb4c3fc4@mailbox.org>
Date: Tue, 4 Nov 2025 10:05:11 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] clk: scmi: Bulk allocate all sub-driver instance data
To: Peng Fan <peng.fan@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Cc: Alice Guo <alice.guo@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>
References: <20251028034225.260469-1-marek.vasut+renesas@mailbox.org>
 <PAXPR04MB84590D1D084E14A5D6B6BA7188C4A@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <PAXPR04MB84590D1D084E14A5D6B6BA7188C4A@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: xa5fb4dn6sq13pf3yzakmfeawnuupnfb
X-MBO-RS-ID: 1c7ebaf867431655420
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

On 11/4/25 9:05 AM, Peng Fan wrote:

Hello Peng,

>> Subject: [PATCH 1/4] clk: scmi: Bulk allocate all sub-driver instance
>> data
> 
> I just see this patchset was delegated to me in patchwork. But
> there is no scmi repo, could I use the u-boot-fsl-qoriq.git repo
> for managing the scmi patches?

This is probably a question for Tom , I would say yes , or if you want 
to take over to whole clock subsystem maintenance, a new repo can be 
created for that.

But please note that I will be sending a rebase of this series after we 
agree on implementation of "firmware: scmi: Add clock v3.2 CONFIG_SET 
support" , because that change has slight merge conflict with this patchset.

-- 
Best regards,
Marek Vasut
