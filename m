Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9584D59D77
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 16:11:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65E8E8367F;
	Fri, 12 Dec 2025 17:11:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cYShps7p";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="inJAsMP/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F115C83837; Fri, 12 Dec 2025 17:11:27 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F5A78307F
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 17:11:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dSZFn5pQFz9tdm;
 Fri, 12 Dec 2025 17:11:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1765555885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Dhee7iMZXNTNw727B3QWRDYpTj+oops3VP3LJRJqN4=;
 b=cYShps7ptwiST/A768eOlxpBgi+gk7iJW8iHCJbtf3EfKzGA6a6l3LiD3L0SVmQ7jRW7pv
 Bj7E/xd9t9PsxPS80WG4+whNPvFhN7ds3WiPjIK23eSWWHDP1CdPXE8a8qYY3xdV2OlS4i
 rmjtzviUsl0++x9Z5+D7BuqBjUOOeP2KzMKDwM/sfRk+2ZtqE5akY+aimYXQba9QwNe9xe
 h9R2k4DzN7WoUfcsHFGT3+dU9iviisp16LZwYYpZnLYKyum48ssHRLabVIfu1CtQNT7IzQ
 CP5AosFxeFhyLAmHzXvDbqDs5UcKSeovmuEDraOwjLIIlD2IG3L9FRAipFhGvA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="inJAsMP/";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <34d62f27-e10c-4ab3-8cf3-b69c8aadb35a@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1765555883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Dhee7iMZXNTNw727B3QWRDYpTj+oops3VP3LJRJqN4=;
 b=inJAsMP/Icvf3pwHUU4kZtXFoMIA1CFAE56zwiMpY0Gs/qrBERFZJQgrOUDSAZxjn92y1I
 /upAnVj9Sxr4QW6Vi9wcRP0wsrZ5yVWAy0tf85QCXfgEXl4XltN5m/Z9Df2bIMKYrvchmp
 nc5VXCdfZsx9aCYEleCVzlVJU4vnZYJVhzFiSgLwywLeakyOud8rwoDg21C3mKDHzhUZiH
 C5OVS6th+zPoU9CzsK/8uUoKW2wgrG0fbM7/ux0Vrh4cSKpgiMi2Ap0zJP2Lgz+EemZe/v
 KIzIqTRjv+Sf3oju7kzTL8wmGssYJc+MdP/uLxLSSaYhLwBAC/Qp8oVOFvcyEA==
Date: Fri, 12 Dec 2025 16:23:53 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] imx9: scmi: clock: Correct imx_clk_scmi_enable
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Ye Li <ye.li@nxp.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>
References: <20251210-imx-v1-1-c3cfa8d318a9@nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251210-imx-v1-1-c3cfa8d318a9@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: qjwsxk8atzw6iapdeotrjq87rrd86wdx
X-MBO-RS-ID: e28ff2b1627aeccb44d
X-Rspamd-Queue-Id: 4dSZFn5pQFz9tdm
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

On 12/10/25 4:45 AM, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX9 SCMI Supports CLK SCMI version 3.0, so need to use
> "scmi_clk_state_in_v2".
> 
> Per Spec about extended_config_val: "This field is used to set extended
> configuration of the clock device. It can be ignored if extended config
> type specified by Bits[23:16] of the attributes field is set to 0."
> 
> So no need initialize extended_config_val.
> 
> Fixes: 0619cb32030b ("firmware: scmi: Add clock v3.2 CONFIG_SET support")

The aforementioned commit did not change the behavior of this code. The 
code worked before this commit with v1 structure, so I assume the 
firmware (SCP?) supports both the old v1 and new v2 structure ?

If yes, then this is not a bugfix and shouldn't have Fixes tag.
