Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4388BCF885D
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 20:38:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C8948409E;
	Thu, 20 Nov 2025 21:38:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rtZGC4RO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B342E840AE; Thu, 20 Nov 2025 21:38:39 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9F2A83F14
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 21:38:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dC9DC6D9wz9tNF;
 Thu, 20 Nov 2025 21:38:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763671115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pnuWa/y4fyB08cL/bLUxYRcb/+YqIMaiPT9la5fyAhg=;
 b=rtZGC4RO0FWcDNbOWaSPxZNGBCvtZoq7LK7PFaHzoGF1NH0WSdsuxsb1cb97PIDaw7ul+l
 jDDxj7KloTHUgLNWRGvLMPCDrHsZ7lxuoaGLakXmdcXQ6Ddu6RnWQQHvIa3GOvI50ZCUcO
 X3012I+Ws4dJMndzcBsneIruE9Q13n5T+bg1Fv6SjqkXL6T2F9/IUdxUYnP/WkmrqDXmy4
 Bfg5aoswJ8dU/BYlKRRAYYo1sPTAcB6IwVtuMaoFnqKmiD0hOyCRZID3HeVIVHqvrVWEVU
 XgA9E04Av1tFvGYTxavz2bQA5ZDCdiNlF+wLD7O+lpnasobwAOqZDvtNqmO6rQ==
Message-ID: <d90e6eca-2b3d-4274-8738-b2eb49f1e722@mailbox.org>
Date: Thu, 20 Nov 2025 21:38:29 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/6] clk: scmi: Force call of scmi_clk_get_attribute()
 during probe
To: Patrice CHOTARD <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Lukasz Majewski <lukma@denx.de>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Yao Zi <ziyao@disroot.org>,
 "u-boot@dh-electronics.com" <u-boot@dh-electronics.com>
References: <20251114154259.4035206-1-patrice.chotard@foss.st.com>
 <20251114154259.4035206-3-patrice.chotard@foss.st.com>
 <4a71038b-ce5b-4119-9493-4e33642a8528@mailbox.org>
 <71047e69-164e-4c65-9eb7-587de4f147ff@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <71047e69-164e-4c65-9eb7-587de4f147ff@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: qik4h1fq7tqifh4z71c6eh6urhsrbck6
X-MBO-RS-ID: ac1924b393938235c66
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

On 11/17/25 5:36 PM, Patrice CHOTARD wrote:

Hello Patrice,

> On 11/15/25 00:08, Marek Vasut wrote:
>> On 11/14/25 4:41 PM, Patrice Chotard wrote:
>>> Since commit fdb1bffe2827 ("clk: scmi: Postpone clock name resolution"),
>>> all clocks which are parent clocks are name "scmi-%zu" which
>>> leads to error during their children clocks registration.
>>>
>>> In order to not cancel boot time optimization done in
>>> commit 3547e315c188 ("clk: scmi: Defer issue of SCMI_CLOCK_ATTRIBUTES"),
>>> choice has been done to re-introduce scmi_clk_get_attribute() call
>>> during scmi_clk_probe() under new CLK_SCMI_FORCE_ATTRIBUTE flag.
>>>
>>> This restores boot on stm32mp13 and stm32mp2 family boards.
>>>
>>> Fixes: fdb1bffe2827 ("clk: scmi: Postpone clock name resolution")
>> SCMI spec says that clock IDs have to be monotonic and incrementing, without gaps . This driver registers all SCMI clock for you exactly this way. What exactly is the problem on STM32 ? Are you maybe missing some reparenting somewhere else ? Maybe the clock parent resolution should happen when the clock are first used, just like attributes are now resolved when the clock are first used ?
> 
> Hi Marek
> 
> Initially, on STM32 we first registered SCMI clocks with their real names and then we registered all RCC clocks
> in stm32_rcc_init(). For most of these latter clocks, their parent are SCMI clocks.
> 
> After commit fdb1bffe2827 ("clk: scmi: Postpone clock name resolution"), the name of these SCMI "parent" clocks
> becames "scmi-%zu" which makes clk_register() failed as we still try to register RCC clocks using their parent's "real names".
> 
> For example: for STM32MP13, clock "ck_hse" becames "scmi-0", so all clocks which are "ck_hse"'s child can't be registered.

I don't think any clock driver can depend on SCMI clock shortnames for 
clock look up, because the SCMI clock shortnames are an optional hint.

Instead, if some clock registered in this RCC driver have SCMI parent 
clock, those SCMI parent clock have to be referred to by SCMI clock 
udevice and matching clock identifier (in this case, I assume that would 
be SCMI clock ID).

The relationship between this RCC clock and SCMI parent clock can likely 
be described in DT using 'clocks = <&scmi_clk N>' , which you already 
have in stm32mp131.dtsi:

  788                         clock-names = "hse", "hsi", "csi", "lse", 
"lsi";
  789                         clocks = <&scmi_clk CK_SCMI_HSE>,
  790                                  <&scmi_clk CK_SCMI_HSI>,
  791                                  <&scmi_clk CK_SCMI_CSI>,
  792                                  <&scmi_clk CK_SCMI_LSE>,
  793                                  <&scmi_clk CK_SCMI_LSI>;

Can you use that for the parent lookup and simply ignore the shortnames?
