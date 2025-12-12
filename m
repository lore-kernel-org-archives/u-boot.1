Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1549D59D6F
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 16:11:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 188EB83106;
	Fri, 12 Dec 2025 17:11:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ekktJbUJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Hzx31OBI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33DDD8334F; Fri, 12 Dec 2025 17:11:16 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9EA38307F
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 17:11:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dSZFY2swCz9sdM;
 Fri, 12 Dec 2025 17:11:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1765555873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/82cxtlJCkg+kr3ijFKaEuDNT6HsqzTKpdycnpfUsXE=;
 b=ekktJbUJuL49TToYkzxokoaFmXYl5SuWL4yuZU3oSCeRgSYjYwua488tKSO9nLvJxSKrXX
 ocKjKbLys4ROoE/lSR2eo+3Z5YXKu4DrZKXOyXY8BWwAF9M7OfoEV7Ss8GpZB6kStJ8SnP
 5NcZsOrR3CTP8FiFPoVTkpjh4u5yYnUS2mQC7QUMIy5mMX8t+lCUkx7/m/WeVFq6g/oN12
 3JC0cbyS2bdoaPFfdPRPHmhX/gZilXHe6e5FikqMp1MCjLlgTS7/5lVS1laTLO8C0ixt46
 p8BggmYAQkghvCpMpyPLI1fQqpnUveN0MchBwZZrh1bPWdSGJ1hpM5tCDe3eaQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Hzx31OBI;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <6a9825a4-0c0b-41ad-adc0-595f83b83a2a@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1765555871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/82cxtlJCkg+kr3ijFKaEuDNT6HsqzTKpdycnpfUsXE=;
 b=Hzx31OBIJ4jR/czdtYWH76bQrHQqXvRCMkfLc2iH5ey+sMIjJyZXgI2HUSz8eIJFP9g5Ry
 GUY2KiIg8EU8QETpU/PUn/64eAwYaD4ama3hEzONf8DTSPWb/s2uuOYTU+nLgK8uwU5JXs
 k+BNyen/PoYUr9923eSvHWgQVM8eFExbQ87Edb6Kh5Q0GHHlr71gnYpioTYPBOvoPZF0LR
 e5Gd9HZ6LKoMXtP/osN4GaV5KzWG1QGHc8BlfbAya74dFBH2y0jhx0atQGDbdJKQ7181x8
 GFNmW883xnRthKZ/O1oWZhWevOi/+gz+9Pva4TuiBlk++PSrkow1ZY7PGTvgVQ==
Date: Fri, 12 Dec 2025 16:16:02 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] clk: scmi: Fix priv initialization in scmi_clk_gate()
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, u-boot@lists.denx.de,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Alice Guo
 <alice.guo@nxp.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>
References: <20251208-sqqs-v1-0-290f0594e30b@foss.st.com>
 <20251208-sqqs-v1-2-290f0594e30b@foss.st.com>
 <3d8c5338-9a14-4f27-9dd4-d84929f9c6c5@mailbox.org>
 <aTq83QLQ6aa70y9i@nxa18884-linux.ap.freescale.net>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aTq83QLQ6aa70y9i@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: u9sfttx69mjpm9qnz5rc4mnta4neeut5
X-MBO-RS-ID: b6be52d4c416b49153d
X-Rspamd-Queue-Id: 4dSZFY2swCz9sdM
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

On 12/11/25 1:45 PM, Peng Fan wrote:
> On Tue, Dec 09, 2025 at 12:54:15PM +0100, Marek Vasut wrote:
>> On 12/8/25 2:51 PM, Patrice Chotard wrote:
>>> In scmi_clk_probe(), in case of CLK_CCF is not enabled, parent private
>>> data is not set, so in scmi_clk_gate(), an uninitialized priv struct is
>>> retrieved.
>>>
>>> SCMI request is performed either using scmi_clk_state_in_v1 or
>>> scmi_clk_state_in_v2 struct depending of the unpredictable value of
>>> priv->version which leads to error during SCMI clock enable.
>>>
>>> Issue detected on STM32MP157C-DK2 board using the SCMI device tree
>>> stm32mp157c-dk2-scmi.dts.
>>>
>>> Fixes: 0619cb32030b ("firmware: scmi: Add clock v3.2 CONFIG_SET support")
>>>
>>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>>
>>> Cc: Alice Guo <alice.guo@nxp.com>
>>> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>> Cc: Peng Fan <peng.fan@nxp.com>
>>> Cc: Sean Anderson <seanga2@gmail.com>
>>> Cc: Tom Rini <trini@konsulko.com>
>>> Cc: Valentin Caron <valentin.caron@foss.st.com>
>>> Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
>>> Cc: u-boot@lists.denx.de
>>> ---
>>>    drivers/clk/clk_scmi.c | 7 ++++++-
>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
>>> index f6132178205..e1c20f2c47c 100644
>>> --- a/drivers/clk/clk_scmi.c
>>> +++ b/drivers/clk/clk_scmi.c
>>> @@ -137,7 +137,7 @@ static int scmi_clk_get_attribute(struct udevice *dev, int clkid, char *name,
>>>    static int scmi_clk_gate(struct clk *clk, int enable)
>>>    {
>>> -	struct scmi_clock_priv *priv = dev_get_parent_priv(clk->dev);
>>> +	struct scmi_clock_priv *priv;
>>>    	struct scmi_clk_state_in_v1 in_v1 = {
>>>    		.clock_id = clk_get_id(clk),
>>>    		.attributes = enable,
>>> @@ -156,6 +156,11 @@ static int scmi_clk_gate(struct clk *clk, int enable)
>>>    					     in_v2, out);
>>>    	int ret;
>>> +	if (!CONFIG_IS_ENABLED(CLK_CCF))
>>> +		priv = dev_get_priv(clk->dev);
>>> +	else
>>> +		priv = dev_get_parent_priv(clk->dev);
>>> +
>> Shouldn't this be doing similar resolution like existing code ?
>>
>> 168 static int scmi_clk_get_ctrl_flags(struct clk *clk, u32 *ctrl_flags)
>> 169 {
>> 170         struct clk_scmi *clkscmi;
>> 171         struct udevice *dev;
>> 172         u32 attributes;
>> 173         struct clk *c;
>> 174         int ret;
>> 175
>> 176         ret = clk_get_by_id(clk->id, &c);
>> 177         if (ret)
>> 178                 return ret;
>> 179
>> 180         dev = c->dev->parent; // <-----------------------------
> 
> No need. The current clk code is indeed confusing.
> 
> In drivers/clk/clk.c, clk_get_by_id is ready called, so the first param passed
> to scmi_clk_gate is the clk that registered during clk driver probe.
Please add a code comment.
