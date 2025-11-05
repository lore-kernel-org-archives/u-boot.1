Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8A0CCF9F8
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 03:42:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2700839DF;
	Wed,  5 Nov 2025 04:42:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MmSeWPIq";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tkMRTyou";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7980D83A05; Wed,  5 Nov 2025 04:42:11 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88E4C83968
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 04:42:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4d1WNH6H2Bz9v9f;
 Wed,  5 Nov 2025 04:42:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762314127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YTVDxnFZIEsbo9S9byoSy4sT6Cs83DGItW5RN9uiA5A=;
 b=MmSeWPIq7mLjGXJ2QYzdG66YkeQmEyGw4nNQd3dBQQ5oGbbiASekTygg4irFfBin7axk/M
 V+lS2S5uV0Le/bcWOa95wj6erxIIl1gvHh8oCiPGYC1Ns5p4+CqnGtLItiuLZ7graadI2n
 LCKc0d5s3mvLfV/r2F6tVifGKR924f2GOK+LAR2wTMgLuSNaPKBGIjhowZMoFa66Uvmk1a
 Qdno4bcCN/6GgDcgsEJEwPHUqW30mEek1aUrXQDei5UJETpED5HV+HtAj2xefHVLOY//zO
 EW/hgElmpRjsvU7QXVfUzVEMx7N9KuKpy6wYZX4cX+POUH8+80aW0qvIh4ZSvA==
Message-ID: <00699319-a125-4974-8b5a-f41705f7ced5@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762314126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YTVDxnFZIEsbo9S9byoSy4sT6Cs83DGItW5RN9uiA5A=;
 b=tkMRTyouC3TLojO/Un1ozSJN/q63eiTO9Qe71TNULhzME9xgVyOdEtPdXx3AYIK7p5i8uN
 rcvNcFwp8N6OXrjwbenvEBMM+a/4qcQXfSmQJobhhB+WgBPeKQCCJE6pLFQxxL5KrOdqDw
 B5RBfofjsqrQM+QWSCvHa+XenHrWnpM121CE9pQHP5ulkw27JbW8GjBUmQbKgUZKaxIgmE
 L3GJhmKl7H9vIJdipOsVcvstIBwjctlIF1GmQ6dfgtX3kXIqGiZ+v5Dn+rZn+fcRIiJ10t
 0yrvkMQsUZS3zEAcXnDQI8anxfQyfszAdsMXRFuxj+0XTmYP/OW0J+4pNuKTYw==
Date: Wed, 5 Nov 2025 04:42:02 +0100
MIME-Version: 1.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYzXSBmaXJtd2FyZTogc2NtaTogQWRk?=
 =?UTF-8?Q?_clock_v3=2E2_CONFIG=5FSET_support?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>, Alice Guo <alice.guo@nxp.com>,
 Cristian Marussi <cristian.marussi@arm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Valentin Caron <valentin.caron@foss.st.com>,
 Ye Li <ye.li@nxp.com>
References: <20251103225625.195926-1-marek.vasut+renesas@mailbox.org>
 <PAXPR04MB964454E621F3467BFC0E6E61E2C4A@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <PAXPR04MB964454E621F3467BFC0E6E61E2C4A@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: t3m1mkupmjwde5mkof9qmufo691dkijo
X-MBO-RS-ID: 9063a6359c0113a724c
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

On 11/4/25 4:56 AM, Alice Guo (OSS) wrote:

Hello Alice,

> I tested PATCH v3 on i.MX95, and it works as expected. However, I noticed that PATCH v3 increases runtime memory usage. I'm not sure whether this is a concern we need to address, so I want to discuss it with you. Here is the change I made based on PATCH v2:
> 
> static int scmi_clk_gate(struct clk *clk, int enable)
>   {
> -       struct scmi_clock_priv *priv = dev_get_priv(clk->dev->parent);
> +       struct scmi_clock_priv *priv = clk->dev->parent_priv_;
>          struct scmi_clk_state_in_v1 in_v1 = {
>                  .clock_id = clk_get_id(clk),
>                  .attributes = enable,
> @@ -331,6 +332,7 @@ static int scmi_clk_probe(struct udevice *dev)
>                          }
> 
>                          dev_clk_dm(dev, i, &clk_scmi->clk);
> +                       dev_set_parent_priv(clk_scmi->clk.dev, priv);
> 
>                          if (CLK_HAS_RESTRICTIONS(attributes)) {
>                                  u32 perm;

This is a VERY nice solution, thank you for bringing this up.

I will use that for V4.

-- 
Best regards,
Marek Vasut
