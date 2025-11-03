Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2747DCCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 23:03:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88398838EC;
	Tue,  4 Nov 2025 00:03:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nt4R2Udb";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="E7+NOCAB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E51A838E7; Tue,  4 Nov 2025 00:03:28 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 418308144A
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 00:03:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4d0nF96zlgz9sQ6;
 Tue,  4 Nov 2025 00:03:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762211006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+kbRzuAMoDDvlt3gMd8K/XKP5pC9mkZkiHw8trFlGl8=;
 b=nt4R2UdbghsbFiuHpjjJN3xuBrcYFQ/PPch9dbjlzKKLuq6BjslCkee32IY6LbDrdZ7WhI
 i9mT/YZ/9uUzsNqlGsFKw0jk1+SluxpZL1ex6lnt/uSxUOOQ8z1naIW7QNynUrhUXiHL5h
 9KaYcQwkDpfUn1E+gop1hGk4rsX6Id3UJOEbmvsObxUFXHxt3qAUeDEL/z3OtAnpi35Ohh
 wi6snmZCT4XNNX/4Xe0aRtAhoxx4Af3TgjPVCI7Y2BKZuYkuk3Ori3nTTfZnqK9bkoXrT/
 wLlelCpzbTBxXbRTHqmUGgWvLT6+fDAdwtIjOwfmmi6GUqgzsGS2JsY293lbnw==
Message-ID: <3446de6f-7abd-4aa1-a62d-7a8368ba82d3@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762211004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+kbRzuAMoDDvlt3gMd8K/XKP5pC9mkZkiHw8trFlGl8=;
 b=E7+NOCABbyRizbK7ccOO5euVGUrbiT7x86qqyhpCDCz+XaJ/Zby4WZTKgeiKPaQ9JCIKXh
 zIZypS5kTSjc4+T+Baw1GTd7K7TCxeJaqZPNO13bWwVcu4MQSn73urgR1Hvt6wXGURSIAr
 3j0PpfxbdaGt8XY2rIINezlejnaVFd8/5UnV/Kk+2xwnnWTQXQbPrARVVcRWxivwhBHWkh
 SzEWbMP9EAeUKGYhRUm4BmtAgO6ZPaNKcak2K5U9/7fLDDh00WPEBMBOw5rzKotzKimCbn
 s/PA4IrGdDSeg3NW7TcNvwAJZTk8pNjaBasaVDy45zCnaOzffiYwnoJTqovc/Q==
Date: Mon, 3 Nov 2025 23:57:19 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] firmware: scmi: Add clock v3.2 CONFIG_SET support
To: Peng Fan <peng.fan@oss.nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Alice Guo <alice.guo@nxp.com>, Cristian Marussi <cristian.marussi@arm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Valentin Caron <valentin.caron@foss.st.com>,
 Ye Li <ye.li@nxp.com>
References: <20251027135856.8909-1-marek.vasut+renesas@mailbox.org>
 <20251103083329.GA1698@nxa18884-linux.ap.freescale.net>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251103083329.GA1698@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 6d3zytxa9am3bmue3x4unepzec8d8on5
X-MBO-RS-ID: 9910106d79d2a0833a7
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

On 11/3/25 9:33 AM, Peng Fan wrote:

Hello Peng,

>> diff --git a/arch/arm/mach-imx/imx9/scmi/clock_scmi.c b/arch/arm/mach-imx/imx9/scmi/clock_scmi.c
>> index fa15b5f8df9..fc1d5d77799 100644
>> --- a/arch/arm/mach-imx/imx9/scmi/clock_scmi.c
>> +++ b/arch/arm/mach-imx/imx9/scmi/clock_scmi.c
>> @@ -10,7 +10,7 @@
>>
>> int imx_clk_scmi_enable(u32 clock_id, bool enable)
>> {
>> -	struct scmi_clk_state_in in = {
>> +	struct scmi_clk_state_in_v1 in = {
>> 		.clock_id = clock_id,
>> 		.attributes = (enable) ? 1 : 0,
>> 	};
>> diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
>> index a7d89f32cd7..f9e17c38cad 100644
>> --- a/drivers/clk/clk_scmi.c
>> +++ b/drivers/clk/clk_scmi.c
>> @@ -134,17 +134,29 @@ static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name,
>>
>> static int scmi_clk_gate(struct clk *clk, int enable)
>> {
>> -	struct scmi_clk_state_in in = {
>> +	struct scmi_clock_priv *priv = dev_get_priv(clk->dev->parent);
> 
> This should be changed to find the protocol@14 device, because
> assigned-clock-parents could change the scmi clk parent.
Ah, this makes perfect sense. This might also explain what Alice was 
seeing. I sent a V3 which should address that without any global variables.
