Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33384D68BEF
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 08:29:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7CD483CF3;
	Thu, 18 Dec 2025 09:29:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="aHjBMY6I";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="w64A/WS+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22B9683D13; Thu, 18 Dec 2025 09:29:30 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F25183C2B
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 09:29:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dX3k00PH7z9smP;
 Thu, 18 Dec 2025 09:29:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766046568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dqPZUwKSWXvt7MmMK9HyGaL9pm1069dhyg0ycSRnBvs=;
 b=aHjBMY6IGw2d67Ry2YQNTArm7tNPX5rYkUgvKw+BbgtXUSM3XigJOX5TlCWJQLmEX3t7nB
 3KGVeGtbwhz5l3BEtu5v6+ZAgnx6PMvIuMtEVZxxNYi4Vbpk3SqbSoIkUm3kForULq0oCg
 mV3Ch6FHpiLz2NkOtd+QMrqhD1KqFl31iiRnIn16v0ajDQuJcB3xj3GIJkV6p5D1+xd/5U
 gxI8Nd331ggt03q9aTgm4brx//JY4G6ibkJ40C/jOuFrzRI83e9J/RjzioYgckXvc6yG+F
 0Nj1NSfjiC2PlIGaF4UnMXBExwX+HN125h48vzaQFjQd4qqF3iCTGGm9BSYb6g==
Message-ID: <48e26149-3991-4473-a1cc-53718ee16ec3@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766046566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dqPZUwKSWXvt7MmMK9HyGaL9pm1069dhyg0ycSRnBvs=;
 b=w64A/WS+a3uqPJAYnBFuGJTlZ9rP8xQwjam7gT+eLAS2NV+9OOkfOoc3cS45YlH17WoI/1
 q/l4G4W1gZJwBYbXEUt2AKLdiKbqAuQxqLsiWMDGAZSoqSHNAODG79y5l3le89YW92M4tn
 IJRhk6pDa6i7oIpKnccZiQ75QXxwv8gb9ojacvg/slsN3wdKOZOWQSJjr9ksXre9t1Id1m
 x2bapx+KyzYncjFFpcO56CnSnja5Pg3W2GHeoL2lbRG1X0bphghy2hEPBBfBuGjK3YKhDU
 f3uEi/oL4GaVudTLPkhD2igvK0nDr9T2tyYM33BiGMEmaOjTH2Z2pyLzqcVG0Q==
Date: Thu, 18 Dec 2025 09:29:22 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 3/3] clk: scmi: Remove duplicated
 scmi_generic_protocol_version() request
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Alice Guo
 <alice.guo@nxp.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>
References: <20251218-sqqs-v4-0-ff95bf2062ab@foss.st.com>
 <20251218-sqqs-v4-3-ff95bf2062ab@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251218-sqqs-v4-3-ff95bf2062ab@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 9801bb128fb4c9fb38c
X-MBO-RS-META: 91atmqk6pxkhp31hhq1z6mrodapi5h3x
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

On 12/18/25 9:26 AM, Patrice Chotard wrote:
> scmi_generic_protocol_version() request is done twice in scmi_clk_probe().
> Remove first call which is useless.
> 
> Fixes: ae7e0330ce22 ("clk: scmi: add compatibility with clock protocol 2.0")
> 

The newline ^ should not be here.

> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
[...]
