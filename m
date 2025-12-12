Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F03D59D6F
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 16:12:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DD1A83993;
	Fri, 12 Dec 2025 17:12:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="L7vQE/B4";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="D1VHhcUx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66629839A8; Fri, 12 Dec 2025 17:12:00 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 905A783993
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 17:11:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dSZGQ2z3Yz9t9K;
 Fri, 12 Dec 2025 17:11:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1765555918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g002FmpqXj21RY8B/ww+LXDmE3EQti3VPuVI3ud9jMs=;
 b=L7vQE/B4DqCZRrj6Fi2DGi76GmHtKcElk72/XROVE++avX4LCLqjG5tymiUYjMbHV1nBd2
 QVrLRKVhtDbI1vbXnF3/t4St+SQ6+RX8inn+qCUyoIfY/b6vl0Aq2FRyy5Drt5N1n6TwPA
 H9ROrgU6JbwP+K7cUM2a5dC+0P4yn/+IsEdZwFkubh7l9LdaOPZwwA/bpGLXUHsSBSkKJY
 /Xas7sXk5Jc6D/HudpFTTGx2Vtma4KDel9DVtgZVwTTns02w521k+8A5qzllN53+l0LaSE
 JzMAyfvLPc+bW00fFxoC+ng4Dyl1uZmblk7RVuzLgHNMt8ZNpWHUg1do93xgJQ==
Message-ID: <030912f8-7bcd-4e4f-a63e-85fa8eb27917@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1765555915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g002FmpqXj21RY8B/ww+LXDmE3EQti3VPuVI3ud9jMs=;
 b=D1VHhcUxonU8awHVCzame7Qx8z1hIXpwRdskSVwOQU26WrNwWbplt4gXEzEAy3omLzR1Ax
 rFB94cmCIVFFGl8bxs3AUC3HOPL2axwtZDuXXsrX199w8U1skhPIWGhcU3s+4Ns8HIMY/U
 QpQCMT/bR/LHESV0Pir9v/T3mhBnCucUYlVQRawIVtkPjMs/cAXq0V49W4gZ4d5B3umpwp
 k+PolqBeMOjdIZ5R7Davx6SEco7jMnef84wJlq1yt+fmWPFnypYJ3IdnfWFRbQ+YYEK5qm
 sr351d8S+cgyJ4poi9HgYoDmvtd7VQR2e3929Ohvx6WDeg4JHxHfUfHmxzA+0A==
Date: Fri, 12 Dec 2025 16:31:01 +0100
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
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <PAXPR04MB8459088345D73E40394E121988AEA@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 1792ebd1cdc6515cf88
X-MBO-RS-META: gxnyx8y3cqz1uma33g933funpequd5j1
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

On 12/12/25 7:32 AM, Peng Fan wrote:

Hello Peng,

>> Subject: [PATCH 0/2] clk: scmi: Fix name defer
> 
> I see this patchset is delegated to you, mainly because patch 2 is to fix
> imx95-blk-ctrl. Since this patchset is based on Patrice's clk scmi fixes,
> I am thinking to pick all the scmi fixes including this patchset to send a
> PR to Tom for master soon.
Please don't, I think this implementation has unresolved questions and 
frankly, I also think this is completely wrong approach. You should 
model the relationship between clock in DT using "clock" property and 
phandles, and then let the U-Boot clock core resolve those relationships.
