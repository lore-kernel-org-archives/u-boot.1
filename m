Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE922CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 14:00:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3547A81D6A;
	Tue, 28 Oct 2025 14:59:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WRTKVU12";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="j8xqxLrt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0CDD832AD; Tue, 28 Oct 2025 14:59:57 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3633080422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 14:59:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cwsSq05Ynz9sq3;
 Tue, 28 Oct 2025 14:59:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761659995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Evd3VWTxSfXTBvtr8fqeAKfxi54jYrypbkRIVAEamdw=;
 b=WRTKVU127JOVItX90I2Mpnir0ACnrkhoXdGgghGIRGsMTyHJk7JtqGgBrbOl6EY4dQ/+sy
 kd6nwDlDBc/c+FOjMObvUfTgpr3+/ueKsSakOzWWJDegAkn1OX2rtOJBeee3xu9Jjv/+8O
 I70e4EBYHVL68V2ofhJMew+/hXGGAV8r0oYv1lXnGGD4edFhkIM+MIuYecej4HRAA9JRJT
 x1ZpGW2H0zitxzFjBih2SJ+wFqbfGsR6AD3uZe4C+JtVNe7MACUW0UdZqtAVO7tRn3Jzdd
 gbeQMn9TpwPZ5HP4Gt/W45CSKkwLUFjTnsrPI96rateX4ZWMvHVtA38XC8kpcA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=j8xqxLrt;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <293ee928-2309-4f26-8b9f-0268db7d7c8e@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761659993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Evd3VWTxSfXTBvtr8fqeAKfxi54jYrypbkRIVAEamdw=;
 b=j8xqxLrt6kf694yvk2pW3LP4aleITrkcbLn38FMuYz10EECkfFK/VQL95M9PeIijy5Puzs
 yb/Q8+lrKQye2fXIL1zO14rHl9QSnYbJTyYhlL1eLR0YL397lNQ0Zl3Gj0M+hkyry73E48
 V+hY3uVzRrs/ZRFPdyspoxeLhIaFKV9NGqRST+Hr3nxz7dmCVrAOARDHlLYArupVFRyCbc
 5d7DZ2HmeAd9uw3rd8ZMNkh2x/CBl/nqchSaICICMbLflz1gy327hUFQV8mZbIWFRzAu65
 Kgj6PjHyPZOv4sIGgU2abcXAYxyobILWEARW2l0xc3nUFMN1OqVxslinNK1Kbg==
Date: Tue, 28 Oct 2025 14:59:50 +0100
MIME-Version: 1.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBmaXJtd2FyZTogc2NtaTogRml4IHVw?=
 =?UTF-8?Q?_code_comments?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Alice Guo <alice.guo@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Valentin Caron <valentin.caron@foss.st.com>,
 Ye Li <ye.li@nxp.com>
References: <20251025223456.253958-1-marek.vasut+renesas@mailbox.org>
 <PAXPR04MB9644894FE99A83CD8352D25EE2FDA@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <PAXPR04MB9644894FE99A83CD8352D25EE2FDA@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 0a887dbd0093c01b45a
X-MBO-RS-META: maf7cy49bnktuaocwh648fyk9q6ct1yb
X-Rspamd-Queue-Id: 4cwsSq05Ynz9sq3
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

On 10/28/25 9:38 AM, Alice Guo (OSS) wrote:

Hello Alice,

> While reviewing include/scmi_protocols.h, I noticed that there are still a few functions and struct definitions whose names do not match their associated comments. For example: scmi_base_protocol_attrs, scmi_base_protocol_message_attrs, struct scmi_clk_attribute_out, struct scmi_clk_attribute_out_v2, struct scmi_pinctrl_config_set_in. I think the remaining inconsistencies should also be cleaned up.
Fixed in V2, thank you!
