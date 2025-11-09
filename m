Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF014CCFA13
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 01:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D21983E8A;
	Sun,  9 Nov 2025 02:38:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="YMxpH0L6";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yeShmIHS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2267D83EB3; Sun,  9 Nov 2025 02:38:22 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40F6F83E85
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 02:38:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4d3wRb6b3Mz9t31;
 Sun,  9 Nov 2025 02:38:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762652299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h3I8rkRlSpPuGl90I4NwIyQcTiDwr/ro4EYEXp1wB1U=;
 b=YMxpH0L6i0uOLwpHjUjGKb15sZ85LpbjfvRpxM8jsrFq7SE09TSJQoV1Mi/heRcvumeJpy
 uBX6YbP1D6cZF8zNl74mztyz1h3aRIG2eT1rAX6P7Np05CKaLhYmtNf987wonRxzY6dyP+
 HlJcCgiJf2/UKDURmqSCJ7bPPLJfE6C7Z3S+dpTnMYnq8FXuTWonApI0dS+qZ4hSFMFlIC
 0q3VxwFhC6Q8HQES5WW/r1VoMLZedkmG/x81N1Ljr9xPtn8rJHqTMkeIM4teRzBPBpNCNK
 km315E2K73Ub2ahEXFardf+r3NbcjLeT0LUhGCPyemQO75Sl7Fg2tOxbrnrY/A==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=yeShmIHS;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <d10c1694-f0bc-418c-8b34-61b6217562ed@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762652298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h3I8rkRlSpPuGl90I4NwIyQcTiDwr/ro4EYEXp1wB1U=;
 b=yeShmIHSEHBn+uNv5+M7p80k33xi0MOqIVV54afvXG20haX+nwX4hINK8EYd5G8X1AXRhs
 Pw1mQvhi0JbchMed1r84YT/bgzSpoy3iXxhOwXxl33eTxDrU7wi7x7TCr2UL+8n3zEVUZb
 zlohaTl/usng0qRLiAEHRRFP0NB872dt8K/P9Qg10ObdfVrdEQr3EzJQdttI4B7Fy2EDQQ
 ufENn54ASKsE463w0yWHUMOPHwv71k2tNAhMc6TPhzZzrtZAaB2kLBUKh4PUDBM/g9tOVX
 emjUcQKtNPYoV/hfEGn5K9hKjMFNJ464z6yCLUvXFTi8WIYh52uhFBSc2/Zong==
Date: Sun, 9 Nov 2025 02:38:15 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/4] clk: scmi: Defer issue of SCMI_CLOCK_ATTRIBUTES
To: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Alice Guo <alice.guo@nxp.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>
References: <20251107030352.475169-1-marek.vasut+renesas@mailbox.org>
 <20251107030352.475169-4-marek.vasut+renesas@mailbox.org>
 <aQ3jMu4dW61RgbWX@nxa18884-linux>
 <5842e083-d9ff-434b-98fd-f0ae5da334f8@mailbox.org>
 <DB9PR04MB84610B2CFE5A1ACEA4726D3288C0A@DB9PR04MB8461.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <DB9PR04MB84610B2CFE5A1ACEA4726D3288C0A@DB9PR04MB8461.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b80cfa09aad6d692c08
X-MBO-RS-META: 88f9x5n5f1ycss3t5i9cf7d3wh9xq6rs
X-Rspamd-Queue-Id: 4d3wRb6b3Mz9t31
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

On 11/8/25 9:02 AM, Peng Fan wrote:

Hello Peng,

>> Subject: Re: [PATCH v2 4/4] clk: scmi: Defer issue of
>> SCMI_CLOCK_ATTRIBUTES
>>>
>>> I will change this to "clk->dev", otherwise there is CI failure.
>>
>> What kind of CI failure ?
> 
> => ut dm dm_test_scmi_clocks
> Test: scmi_clocks: scmi.c
> find_scmi_protocol_device() sandbox-scmi_agent scmi: Invalid SCMI device, agent not found
> test/dm/scmi.c:426, dm_test_scmi_clocks(): !ret_dev || ret_dev == 1088
> Test: scmi_clocks: scmi.c (flat tree)
> find_scmi_protocol_device() sandbox-scmi_agent scmi: Invalid SCMI device, agent not found
> test/dm/scmi.c:426, dm_test_scmi_clocks(): !ret_dev || ret_dev == 1088
> Test 'scmi_clocks' failed 2 times
> Tests run: 1, 11 ms, average: 11 ms, failures: 2
> exit not allowed from main input shell.
It seems in the end, we were both right about the device parent. The 
function has to use dev->parent, but not clk->dev->parent, but the 
c->dev->parent resolved by clk_get_by_id() .

I sent a V3 with this change:

"
diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index 4e8e5a262c8..538ae054f4b 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -167,8 +167,8 @@ static int scmi_clk_gate(struct clk *clk, int enable)

  static int scmi_clk_get_ctrl_flags(struct clk *clk, u32 *ctrl_flags)
  {
-	struct udevice *dev = clk->dev->parent;
  	struct clk_scmi *clkscmi;
+	struct udevice *dev;
  	u32 attributes;
  	struct clk *c;
  	int ret;
@@ -177,6 +177,8 @@ static int scmi_clk_get_ctrl_flags(struct clk *clk, 
u32 *ctrl_flags)
  	if (ret)
  		return ret;

+	dev = c->dev->parent;
+
  	clkscmi = container_of(c, struct clk_scmi, clk);

  	if (!clkscmi->attrs_resolved) {
"
