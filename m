Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352FACCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 03:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA57A83C64;
	Fri,  7 Nov 2025 04:05:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gcX9qU9l";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="C6Rgec/W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 605C483C7B; Fri,  7 Nov 2025 04:05:23 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D17583C5A
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 04:05:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4d2kSx1KSxz9sn0;
 Fri,  7 Nov 2025 04:05:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762484721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sdC+Z1synhQCRhsxf/1NdE5+5FvegbKNY4Zex75ys3M=;
 b=gcX9qU9lP7izfe5WN/8jClEDNNdm/E4zmgn7ZKmoT5UekZ3xzrxcaw/fUT1uDDoKF2Fu0M
 8Xq9okiSUpEJspINll6vEGA6GBBBxCxUN2d1fD43L8fiYbaReLE++8Mcs6SJkY53wPvAW8
 s4DKO+V9He3niHgaDuhY2tYtC58fiNsokwy4j/5K850XLCzR4vKSnLjr1yyNP1DQdDXDNi
 FbPBBb1mnYdD3qwOQ0A731W8x8BkbS5QROzxQDNauF2rAhMMqBn/hIeUQquiyxt1Fcxatk
 JdJW1gUyt3Eb9x/8vELsHpx0VJzqcN99pGdsjpziucr9EUV7dJwlCeqP0cnc4w==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="C6Rgec/W";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <8d3bfcdc-0a11-4d51-8739-7da9c873ab0c@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762484719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sdC+Z1synhQCRhsxf/1NdE5+5FvegbKNY4Zex75ys3M=;
 b=C6Rgec/WKvuRn9s7TAtfj9zYJqlERoTvots31blfrDJDW0subyQGNB/WmMcbawEMqz8p+B
 +d8TcMNr+a/J3BYQs9SGmBU5nvD/PEZ9HsNepC4EtO7XMgs7fbeFfqJHA0fFKCgq4nG1Go
 h99+7OlntoC/BdIWSXXk8sRlEoZQChHtx5Ccoqq9stW7ufV8nd+5andFCZjIGK+v8s1nlu
 YlGZRkyEqM1vHttzOwbzCuLvEBBozEDQfJHPOYL3p4NRPsQOBvI+Qx3LLvaAuqRZD9Ijzv
 kIYWN8pF3B8UmL1xqU7aVPKwR6xf5hiQ4EienOwEBfjDhVEAy1ya0fY5+HEcfw==
Date: Fri, 7 Nov 2025 04:05:17 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] clk: scmi: Bulk allocate all sub-driver instance data
To: Peng Fan <peng.fan@oss.nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>
References: <20251028034225.260469-1-marek.vasut+renesas@mailbox.org>
 <aQ1noJ_VxwmA_MHY@nxa18884-linux>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aQ1noJ_VxwmA_MHY@nxa18884-linux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: ad90e0955c59e616672
X-MBO-RS-META: di6ubweqxe6thwkxapc9nxajruuag8d1
X-Rspamd-Queue-Id: 4d2kSx1KSxz9sn0
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

On 11/7/25 4:29 AM, Peng Fan wrote:

Hello Peng,

> On Tue, Oct 28, 2025 at 04:41:03AM +0100, Marek Vasut wrote:
>> Allocate all sub-driver instance data at once. The amount of data that
>> have to be allocated is known up front, so is the size of the data, so
>> there is no need to call malloc() in a loop, mallocate all data at once.
>>
> 
> There is conflict when applying this patchset, would you please
> rebase with fsl-qoirq/next?

I just sent V2 rebased on qoriq/next , I hope it works now.

-- 
Best regards,
Marek Vasut
