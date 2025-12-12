Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BB5D59D77
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 16:12:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAF71837F2;
	Fri, 12 Dec 2025 17:12:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="thlVswEn";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Akgyreld";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99F51835B3; Fri, 12 Dec 2025 17:12:24 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC958837F2
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 17:12:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dSZGn46WXz9t8x;
 Fri, 12 Dec 2025 17:12:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1765555937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QdS1ZAGfkj/oaJ0y0rvKpks+4DzCwAcCHy6aizvcu8Y=;
 b=thlVswEny2mqIChxvH2Ka76fkAQdW62uKD3lMi5UELwt5iVEd+FXEaFl7+JDWtBb03NJ2g
 a8NKwXtNv2Agb2H4YKP7BQJTdHkQjbeGzpYMOouN8KXLNeSE79Hd8h0VtsnFRgNyL/6zEI
 LsvHL1OdpmQYTGqzQFqdK0HiBBQdlIaFrArj2c1exToirE2SzmC53MoQkilZUdmYNZZWHY
 8CJK8N/I6j8usNHR5619evg1qZqhUoCloFJ7Z8hy8/Um5PGB+W+9Y85Qh9wEo6Ui5cBKT2
 X+6SZgy0rHerOoBj2IVyH+tkMpW2KwGoxGrrf4TvX3ok37OTicekoZLm/XLsTQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Akgyreld;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <b9fc4f8d-b10d-4308-bbe0-ff871fcdc940@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1765555935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QdS1ZAGfkj/oaJ0y0rvKpks+4DzCwAcCHy6aizvcu8Y=;
 b=AkgyreldVCRlXPhBZ1gA0JOl/q5u9rbYYCUR22021NWI+Bvxwc927/A/Da9EuNmUoYw16l
 XpLg6m3NXxT4WkWu98dgp5ag0v8Guyr4/jIWOILm6rStn9gqkWXP0kTuRLuejVIuT7Z667
 M6oIhvh3Q3VzhjMDhuajQ6jhQ/Gr5krJReHAvAf5TPv88tIaAEgbxPeKcdNwFWjzdQqSJc
 RerppHeQyAlkMN6sSWHD1smfzRblsHcdMayC/PoWhqvbm6o+f4Q/aXVji9bgE4GbwSl8Ei
 HGwkfFwqx7YgFUug6sLa3Xh85WfZ8Yqks9b8TVFLmqzOYVlSaEsugEKpiIkzSA==
Date: Fri, 12 Dec 2025 16:36:48 +0100
MIME-Version: 1.0
From: Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [PATCH v2 2/3] clk: stm322mp13: Resolve scmi clk before using it
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Lukasz Majewski <lukma@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Gatien Chevallier <gatien.chevallier@foss.st.com>
References: <20251211-restore_boot_for_stm32mp13_stm32mp25_boards_v2-v2-0-44e6e7de2beb@foss.st.com>
 <20251211-restore_boot_for_stm32mp13_stm32mp25_boards_v2-v2-2-44e6e7de2beb@foss.st.com>
Content-Language: en-US
In-Reply-To: <20251211-restore_boot_for_stm32mp13_stm32mp25_boards_v2-v2-2-44e6e7de2beb@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f54fa8c5ef8d8d5a76c
X-MBO-RS-META: jfei55qixhc1sig1rkgyq1qxkzjh3doc
X-Rspamd-Queue-Id: 4dSZGn46WXz9t8x
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

On 12/11/25 4:52 PM, Patrice Chotard wrote:
> During clock's registration, clock's name are used to establish parent -
> child relation. On STM32MP13, most of SCMI clocks are parent
> clocks.
> 
> Since commit fdb1bffe2827 ("clk: scmi: Postpone clock name resolution"),
> all scmi clocks are named by default "scmi-%zu" until they are enabled,
> it breaks clocks registration and boot process for STM32MP13 platforms.
> 
> By resolving SCMI clocks before clocks registration, it solves the issue.
> 
> Fixes: fdb1bffe2827 ("clk: scmi: Postpone clock name resolution")
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

Shouldn't the relationship between RCC and SCMI clock be described in DT 
using "clock" property and phandles / clock cells ? Once that is in 
place, you should be able to resolve the parent clock using that 
relationship described in DT, without the need to explicitly do these 
SCMI calls in RCC driver.
