Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677D5CCF9E3
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 23:45:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB80183D52;
	Sat,  8 Nov 2025 00:45:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="sSOB1zvS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WBq5r8iM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 831B883E20; Sat,  8 Nov 2025 00:45:23 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B1E883D0C
 for <u-boot@lists.denx.de>; Sat,  8 Nov 2025 00:45:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4d3Fzj0vWZz9tNR;
 Sat,  8 Nov 2025 00:45:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762559121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8eMtf4cv8EPb7w1Odly0uarZtdTIisY/ppmSnFcDavc=;
 b=sSOB1zvS0ZrjlvGWpht60JK0FjhdLIAaiWYQPnbDGxC34CEs+6NHIWEUZORV9fJ+mzDj1A
 U7U3vR1yC7voo7HRRCpgbIT5mOm4kB6sEMHwbgQZgYIW3GexyCSE2ojeHCjqu9tUhi1SxO
 SlciI26QFby9uPwFkBL/PLQ8it3uprosnjuAaM/Pp2ROEwmuN0EjJTSKCiwBw8yF9ByE7w
 3vVsqmq6la60wtdp3hgkQ7N3drxjayUZOwK3taI9lO2DlSeQCFnk1SYIvZSs7INHNZTsLp
 iI26jiCYcq0yvtqa40PPo5S3ueuXKFyqAREznYu5dEX87eA4C8mGO6qSdKHkqw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=WBq5r8iM;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <5842e083-d9ff-434b-98fd-f0ae5da334f8@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762559119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8eMtf4cv8EPb7w1Odly0uarZtdTIisY/ppmSnFcDavc=;
 b=WBq5r8iMbSgQGQwX7IUhdH7BohFEJ8abT+qGeKRIxw9bfRMEpZC0KyFTjQzcwqCddSzimF
 +qQnJ9bwJhVW9NmyrvE1nCRnlqrrS98y0Cz9gOCRJKJHgc4SSY9yk6bRbB6ySe5I+pSxvU
 91aXRZTmRQGxF7TKf3xV1jlnUZ4cLlFiR5cxLyWYqT8P+uEDOshtw3G8hJ7XDGXObaQ26d
 53iEvZTPbT/PN2/CbqFQfuuTaRwWe2o4dbE/AAoV2d00tS7SOrDxvXlTeYxZdrlZY8Rr2d
 Vh8GsKL0DNbD3mP6fqjVPrW7TeQCfuNDJLL4/7MX3U3PG7t7M81mLjTUUkcYIg==
Date: Sat, 8 Nov 2025 00:45:15 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/4] clk: scmi: Defer issue of SCMI_CLOCK_ATTRIBUTES
To: Peng Fan <peng.fan@oss.nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>
References: <20251107030352.475169-1-marek.vasut+renesas@mailbox.org>
 <20251107030352.475169-4-marek.vasut+renesas@mailbox.org>
 <aQ3jMu4dW61RgbWX@nxa18884-linux>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aQ3jMu4dW61RgbWX@nxa18884-linux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 362fd3e4d6344979e86
X-MBO-RS-META: jfrhm6qefci1gjj75ps3cxucfg51nnmo
X-Rspamd-Queue-Id: 4d3Fzj0vWZz9tNR
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

On 11/7/25 1:16 PM, Peng Fan wrote:

Hello Peng,

> On Fri, Nov 07, 2025 at 04:01:26AM +0100, Marek Vasut wrote:
>> Instead of resolving clock control flags using SCMI_CLOCK_ATTRIBUTES
>> during probe for each and every clock, resolve the clock control
>> flags using SCMI_CLOCK_ATTRIBUTES when the clock control flags are
>> first used. Because most clock are never used by U-Boot, this allows
>> reducing the amount of SCMI_CLOCK_ATTRIBUTES considerably, and this
>> improve probe time of the scmi clock driver and U-Boot start up time.
>>
>> On Renesas X5H, with 1700+ SCMI clock, the boot time improved by 1.7s .
>>
>>
>> static int scmi_clk_get_ctrl_flags(struct clk *clk, u32 *ctrl_flags)
>> {
>> +	struct udevice *dev = clk->dev->parent;
> 
> I will change this to "clk->dev", otherwise there is CI failure.

What kind of CI failure ?

> No need to use clk->dev->parent here. The core code will
> find out the scmi root device.
> 
> No need send v3, I could patch it in tree if no objections.
This change would be wrong, so please do not do that. Apply this patch:

"
diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index 4e8e5a262c8..99fd9679634 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -168,6 +168,7 @@ static int scmi_clk_gate(struct clk *clk, int enable)
  static int scmi_clk_get_ctrl_flags(struct clk *clk, u32 *ctrl_flags)
  {
         struct udevice *dev = clk->dev->parent;
+printf("clk->dev->name=%s clk->dev->parent->name=%s\n", clk->dev->name, 
clk->dev->parent->name);
         struct clk_scmi *clkscmi;
         u32 attributes;
         struct clk *c;
"

When U-Boot starts, the output looks this way:

"
clk->dev->name=scmi-325 clk->dev->parent->name=protocol@14
"

Notice "clk->dev->parent->name=protocol@14" , which is correct, 
therefore the clk->dev->parent is correct.

With the "clk->dev" change applied, the wrong device is used and the 
system starts producing failures:

"
scmi-over-mailbox scmi: Buffer too small: hdr->length:32, out_msg_sz:24
"

What kind of CI failure do you observe ?
