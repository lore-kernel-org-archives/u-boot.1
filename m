Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4292CC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 22:41:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7487A810F2;
	Wed, 19 Mar 2025 23:41:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HqTOx9jp";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="g2SVmsC+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D48C810F4; Wed, 19 Mar 2025 23:41:38 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED09F809D4
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 23:41:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZJ3bd4cc0z9skV;
 Wed, 19 Mar 2025 23:41:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742424093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LdftcHeIFUjxrJYyLOcCFvMll4qNucp3eWsRZzfEOwU=;
 b=HqTOx9jpm9JtuJ4GPcnVvIAjzuMNv6DflKqOG9ndI0slTC/mGzFzwZuD2USztGcclg2MsR
 YTlgIG0FBTpwlzFFfpBgWxsjdRp5H/ITp7CD1wgih++iPJTVf5v8hmcRMXzx5ZArpv+gjB
 dhJlF9jFftM3eygstzE3RGucCh/3ZIcds71L1oi1rpQbI4qb3UUZsZsQ213dooKP9okd+V
 IzUXJCQPc9G2ZHbA3Lut37u92TzeP6GtrRBMLTJAJo8UrPTn5w6rCw+GNWfV6IICn28SIR
 G5yU/JIVdrYpnijjcDy4XILp2HlVmMHsPUrEYTXoS8uiYEaSFvpjhwe2M6qoeA==
Message-ID: <2ea44bda-b228-464d-8cb4-269e52b33a18@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742424091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LdftcHeIFUjxrJYyLOcCFvMll4qNucp3eWsRZzfEOwU=;
 b=g2SVmsC+fE7Lvw6DqQaBdFWOmPwcON66eLQ9u481zhL04qpD9BQtSZO5zJ/CUKYNl/X5N3
 XgdT0b8/I24qdPW1WsIFkRX0UWV7H3bXIzUbZ4AML+bw1sfbjGctQSw5g9wH2rvKeBROfJ
 hCWyoBB+HzjFEpko8tsZUzM2WFdeN0UAqYWyHMiaw+QInO8+X0QnzQjHmHvkZUK4RngkA3
 34srUjHRQgXyWXr42+enReFOlP9XJ87C398Vawjq0fyUYa+UbAXE9T6yFIXd8Oi4U10/b6
 Bh4/dBJO6sKPH+IAFFFuIBk+5mE+NDrDCCdtjuy/7+A3kmpydQQltUG5csJMuw==
Date: Wed, 19 Mar 2025 23:41:29 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] cpu: imx8_cpu: Print Speed grade if IMX_THERMAL or
 IMX_TMU
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, festevam@gmail.com,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Ye Li <ye.li@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20250319014240.592189-1-aford173@gmail.com>
 <b32475f3-d7a4-4eda-841e-1014201d61d3@mailbox.org>
 <CAHCN7xJUgRZJ6AzXYS1xdf0nVgK0s0t0Y7bRga5miUYxzCYmEg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAHCN7xJUgRZJ6AzXYS1xdf0nVgK0s0t0Y7bRga5miUYxzCYmEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 937ee4b7bde143273d3
X-MBO-RS-META: 8a9q6ffdgnntxma5mdabt4tqonexugnf
X-Rspamd-Queue-Id: 4ZJ3bd4cc0z9skV
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

On 3/19/25 8:13 PM, Adam Ford wrote:
> On Tue, Mar 18, 2025 at 9:13 PM Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 3/19/25 2:42 AM, Adam Ford wrote:
>>> Much of the data that is display by imx8_cpu.c is also
>>> displayed from arch/arm/mach-imx/cpu.c, except the
>>> speed grade and temperature unless the SoC is an i.MX9.
>>> Expand this to include checks for IMX_THERMAL or IMX_TMU
>>> in the same way it's done for mach-imx/cpu.c.
>>>
>>> Before:
>>> CPU:   NXP i.MX8MP Rev1.1 A53 at 1200 MHz
>>> Model: Beacon EmbeddedWorks i.MX8MPlus Development kit
>>>
>>> After:
>>> CPU:   NXP i.MX8MP Rev1.1 A53 at 1200 MHz
>>> CPU:   Industrial temperature grade  (-40C to 105C) at 28C
>>> Model: Beacon EmbeddedWorks i.MX8MPlus Development kit
>>>
>>> Signed-off-by: Adam Ford <aford173@gmail.com>
>>>
>>> diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
>>> index 53d31b3c0bf..facd561022f 100644
>>> --- a/drivers/cpu/imx8_cpu.c
>>> +++ b/drivers/cpu/imx8_cpu.c
>>> @@ -177,7 +177,9 @@ static int cpu_imx_get_desc(const struct udevice *dev, char *buf, int size)
>>>        ret = snprintf(buf, size, "NXP i.MX%s Rev%s %s at %u MHz",
>>>                       plat->type, plat->rev, plat->name, plat->freq_mhz);
>>>
>>> -     if (IS_ENABLED(CONFIG_IMX9)) {
>>> +     if (IS_ENABLED(CONFIG_IMX9) ||
>>> +         IS_ENABLED(CONFIG_IMX_THERMAL) ||
>>> +         IS_ENABLED(CONFIG_IMX_TMU)) {
>>
>> Can CONFIG_IMX9 instead select CONFIG_IMX_THERMAL or CONFIG_IMX_TMU , so
>> the SoC specific check could be removed from here ?
> 
> Any idea which of IMX_THERMAL or IMX_TMU should be selected or
> implied?  I don't have an IMX9 to test.
git grep says:

drivers/thermal/imx_tmu.c:      { .compatible = "fsl,imx93-tmu", .data = 
FLAGS_VER4, },
