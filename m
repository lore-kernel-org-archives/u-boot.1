Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6237FCCFA13
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 18:45:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A35FD83C02;
	Thu,  6 Nov 2025 19:45:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="CpW/EivK";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="I3EbU/RL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E426E83C04; Thu,  6 Nov 2025 19:45:07 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D1C483B85
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 19:45:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4d2WMj2ghNz9v4J;
 Thu,  6 Nov 2025 19:45:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762454705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7hm1a7awX6OwwMmrApWPLXnueXnpspcFBd8Y4CWIMbc=;
 b=CpW/EivKMVwzuM3kQwne4Q6eWZwoXjxA0BhgixZVGjUEuQ8WbeoS/Y9hzLwD6UHEkAxEV5
 2atbHebmu4f3286HgW9ecmFUIekgjFG9Nze4cxSXe1lo3fmx7IIjpZ6L6p4xPNsHCfl76w
 nJjFwHEthNZpyNdfZX2V7duVyrnjIlJe3xDJHiREUoSZV1tgkpXiy6Q4I1KOWC41PKrSfI
 mMwrvADZ1NukVOmhEfPAVYlqxJ+VoAq2CiB/xuez6siGhqh17EkRjFkLlXYv/qvQH8p+F2
 3SO5BUB8iTIloH7BgSIXsO1KD9QtnwE+WWlfdn+BMs1Vho1kdcBcFmogPcSoMg==
Message-ID: <b475b895-38b6-483f-b498-5cb4247251c2@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762454703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7hm1a7awX6OwwMmrApWPLXnueXnpspcFBd8Y4CWIMbc=;
 b=I3EbU/RLaXd0mOTbLrVL1K17V3RzdMLPQhLS76tkXqzsEh0r/ZxTMr+SkPY1HkTWAPEAp+
 WLDeMGUBGxCV9w6Bg4A2zslLSQ5XbbtBBpY/vsDTvleR+1o654OFsJwMb4iisfG6IsfTdV
 435fFMSP7NsmR93eEh6K7+h/FIOYwKjcim3HGHp/9vvsSzdhpCGveCJj9f3zsbAsj4NwC2
 T5IBmIGSSyG1SPnZsSR8f7SiK2Io0LPUvAKuXOlVuC/VHR0GxzL+IwtgsnlfZ9qLKbKtzQ
 GbzggDKFjxyxIYLS4E8f6pcq70xQyiSsFDCQ0yUO4K6fx8AT3Ptl27thELzJ7w==
Date: Thu, 6 Nov 2025 19:45:00 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] clk: scmi: Bulk allocate all sub-driver instance data
To: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Alice Guo
 <alice.guo@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>
References: <20251028034225.260469-1-marek.vasut+renesas@mailbox.org>
 <PAXPR04MB84590D1D084E14A5D6B6BA7188C4A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20251104160631.GY6688@bill-the-cat>
 <PAXPR04MB8459585528148DC8B365867B88C5A@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <PAXPR04MB8459585528148DC8B365867B88C5A@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d1ce3de6e879ce65989
X-MBO-RS-META: ub84p4y4r5pmjwztz1xgbks97auiwi4x
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

On 11/5/25 1:49 AM, Peng Fan wrote:

Hello Peng,

>> On Tue, Nov 04, 2025 at 08:05:53AM +0000, Peng Fan wrote:
>>> Hi Marek, Tom,
>>>
>>>> Subject: [PATCH 1/4] clk: scmi: Bulk allocate all sub-driver
>>>> instance data
>>>
>>> I just see this patchset was delegated to me in patchwork. But there
>>> is no scmi repo, could I use the u-boot-fsl-qoriq.git repo for
>>> managing the scmi patches?
>>
>> It's a question for you as well. I'm fine with a PR from that repository,
>> but if you want I can make a u-boot-scmi repository fairly easily and
>> add you to that.
> 
> No need a new a repo. I could use u-boot-fsl-qoriq.git for scmi
> patches.

Do you plan to pick any of the patches for 2026.01 still ?

-- 
Best regards,
Marek Vasut
