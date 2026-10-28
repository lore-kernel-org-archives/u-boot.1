Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEC5606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 16:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yy9DW8cN;
	dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=zTvd3hc0
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E85C740557;
	Wed, 28 Oct 2026 16:58:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IJ0rO51WWoxq; Wed, 28 Oct 2026 16:58:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2A9CF4055A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793206693;
	b=j7viqTo5p5B0BnI56hy4vVs97qthN6QsPiOPQgP7fEWxU1jOG65SwX91BYH3EaWHt9VC
	 bsTUb2HNAais/AvO1EW98IkQLaOEylJ9IYohBdYKAhBLmsjVxWntZ8lM7zXnjsvFunJsc
	 QpOWpRuEZAqz4/mTO6c875/rA2X1lVGlIsncLKiGeF35oZs8WGa1w+GfHcaCWddhzkxPK
	 a2eHScksKh8Bx1TB9zx57S5gHBzWuUhRFZEnzy4TyJd3VmCDrl1yVRRsPOiNGty3tMT1i
	 w0XNrsVnuqp9F+7GoHcgi174D6QEADJkKDVn2WOtib16j0zrjFj46eQuizB5+nCzQfw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793206693;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MLc5i/0DnR2k0OKTAFkGBTCQVLfjR1k0JdxT6Wj2Hl4=;
	b=hZHZ8be1XL2sq7qweJBHEVN4MpdmnuisezdHJfwbhwRnbcCaAzTrBkQOb8a4AuwTpx24
	 UdHmMxSUlPWvs54PIGsPRpPbGGXOrjqECA6YNAtrbGvSFrccs3rsFiwj0JvzawuGbciuE
	 4eeqWzNxDsCFWx0WFM8jO5qQ96vmhNubd3p+xMk+VUbaAiq4wvLCMy9yBxPp/58NpwdiI
	 mNLVEgmRAMne/XyBb3ZA6sEM600fo34gA9FYWTT+RdfnHvpMMzdlUalWOLnn/XK6wpmtb
	 kB7S+Ke4p3n9QQ2sX1YPDtUlFsWkwwd14gvSMsm90QtxzveJPMViow1sX6IRpRbMt2A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=zTvd3hc0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793206693;
	bh=MLc5i/0DnR2k0OKTAFkGBTCQVLfjR1k0JdxT6Wj2Hl4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yy9DW8cN98jLp/Dt9Oczjs7b8FCO2aV8Ly6HGJD4v8hLkZeiS/nk3mxjeEUr6HiiD
	 xJD2G/lUcoNGa62Zx8g+SzHsvFe/I9W41APBUu66ZzfL05mUjQZIGQ01EnceUjnkR9
	 gSE+2Vwv1AZ5TTn3RTsFAFhtuA1EMuPQ0WA3Z4ahpP6E8zRH5bobL4Kgv52W4AaQQC
	 3b/VBIawdYVqkFwSQKqPVThLd2rfshhzX65bvZCAv7KkslWVR+XMCCbfXzX/1V4j7P
	 Tj0kPh9PU+lN3rOqZXh7DPlps4l3xt8CsQdOcbh8U0Gg9dwN4tXxjcWR/R9CE+sHgU
	 2MjgTg/nNwBoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A9CF4055A;
	Wed, 28 Oct 2026 16:58:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F8BC235
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:58:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 20C6E4055A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:58:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y5eK3NErcgaK for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 16:58:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 86EA440557
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793206691;
 b=SMDOJwwWfzgviN9dDYpKiZY2UgLxqmhie+AW8zqLtYjHYdrEnVz0jmlwL3sCLvLBUMAq
 GKb986oqiT2Bv6dgwD80jhrcbaOxNGVIr7NMalzzAWh2he4JUOXHU0A3YYkpL5T2om3Mz
 AZXBS7ayXQcUTTaEQid6KLQ8fA/qMFww8osPZbMBipnet3L/a+hGd3Vds8AFksoHjXsB0
 Qgky7n2k/1U8AdWecXpASJtSEE7imLNIG/Q66N133zuvKOp3SWibTvTSmB44rB2WxCjMF
 3aSpJaiK5/4kzqND3Od+JM8SKKZprcebAwYDhL4BV2YNSLyEGOul0Pzl69koIPB4gmw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793206691;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=MLc5i/0DnR2k0OKTAFkGBTCQVLfjR1k0JdxT6Wj2Hl4=;
 b=Bvg+UY/FVkkDsedSTCdsiPzck4tCcMnRhNiWwWgCa6oJZyoZN8BtPuv7bUujNcac43OV
 Kkfmj91PPgn11r09/MEKr/8i76ON+jb2ZaNG0CRaeKiDhi6k4dHJZ4fdIkr4UYq2CwGES
 h4zO2iuwYHsPQ7gITFUznIxujwbWWVKFssXoE64Wb5KbmJzogzB+bnS9Ijfu+jH5A/tZw
 R+0k4YeGl4fX9dLpeLaIojv0Y2ryepjqs01ncWa9AKTFu41LuA133S9mRomlHli+HxsNf
 mf63EYRIdOIxzTB+bZ1MSbYSfFqXX5ov2eDSlpvrIA1Z0cIoAaPmHjTlGrQ1Tsa+a2A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=zTvd3hc0; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=340e=it=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=zTvd3hc0
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 86EA440557
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1793206688;
 bh=MLc5i/0DnR2k0OKTAFkGBTCQVLfjR1k0JdxT6Wj2Hl4=;
 b=zTvd3hc0sVNfdvT7GSQaBpIh8HVtPFMPBxFc3yBkEpajQ3mThtj3yAiowcnprswOtUoDip2qC
 0Rilv7oCeOpwGF0bCH8u01bARuz4+oGDaDMq4CLWR7GiSgLUSrhn3zH+iGWDT6P9+/G7HpPM2JM
 tVco0E/8Hs4rUDfxSK7L4Gcma7YlZaYbev2ot/zLJ66H7i53vS46wh5k8bHNifrz3rJ3gw+6kMp
 sZrA9W4QT+MCdni5YKcxT4TayyWM/srF8qh+d5ANLIwqqOt6urxP/TWM4W+GoQ5Y2JwJ2ltKus6
 +b112D87GE2A42fVrMZQEsiXQ5fKQxB395/fjd7JedMg==
X-Forward-Email-ID: 6ae229971ef0ef0c3f87859e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.18.11
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <6a5e35fb-2bfb-4551-a9a4-2f51a1cbdaad@kwiboo.se>
Date: Wed, 28 Oct 2026 17:57:55 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] clk: rockchip: rk3568: Ungate PCIE30PHY_REF clocks
 when PCI is enabled
To: Quentin Schulz <u-boot@0leil.net>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20261015224222.1582607-1-jonas@kwiboo.se>
 <20261015224222.1582607-2-jonas@kwiboo.se>
 <16574e5d-6d1f-4419-8519-b1cc356797a3@0leil.net>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <16574e5d-6d1f-4419-8519-b1cc356797a3@0leil.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin,

On 10/28/2026 1:41 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 10/16/26 12:42 AM, Jonas Karlman wrote:
>> The CLK_PCIE30PHY_REF_M and CLK_PCIE30PHY_REF_N clocks are by default
>> gated coming out from system reset. The probe() ops of the PMUCRU driver
> 
> Are they? I don't have an RK3568 board so cannot test this, but the TRM 
> says the bitfields are 0 at reset with "When high, disable clock", so I 
> am not sure what exactly this is for (except after a reboot where the 
> Linux kernel has disabled the PCIe clocks maybe?).

I guess the TRM is incorrect, because as I mention in my commit message
these clocks comes gated out from system reset, or I would never have
phrased the commit message as such.

See below runtime log on a Radxa ROCK 3B (from power off state):

  DDR 5c7dbc4d49 kwin.chen 26/05/21-10:58:25,fwver: v1.26
  [...]
  out
  PRE: pmu_clkgate_con[2]=6000
  POST: pmu_clkgate_con[2]=6000
  
  U-Boot SPL 2027.01-rc1-00097-gec7e6bacaadc-dirty (Oct 28 2026 - 16:35:51 +0000)
  Trying to boot from RAM
  [...]
  U-Boot 2027.01-rc1-00097-gec7e6bacaadc-dirty (Oct 28 2026 - 16:35:51 +0000)
  
  Model: Radxa ROCK 3B
  SoC:   RK3568
  DRAM:  8 GiB (total 7.7 GiB)
  PRE: pmu_clkgate_con[2]=6000
  POST: pmu_clkgate_con[2]=0

Using following code in probe() ops:

	printf("PRE: pmu_clkgate_con[2]=%x\n", readl(&priv->pmucru->pmu_clkgate_con[2]));

	/* Ungate PCIe30phy refclk_m and refclk_n */
	if (CONFIG_IS_ENABLED(PCI))
		rk_clrreg(&priv->pmucru->pmu_clkgate_con[2], 0x3 << 13);

	printf("POST: pmu_clkgate_con[2]=%x\n", readl(&priv->pmucru->pmu_clkgate_con[2]));

I guess theoretically it could be the DDR init blob that gates the
refclks, however running bare minimal TPL on same board show same:

  U-Boot TPL 2026.10-01297-g83bfcb8d6e91-dirty (Oct 28 2026 - 16:45:25)
  x0: 00000000 fdcc0098
  x1: 00000000 00000008
  x2: 00000000 fdcc1000
  x3: 00000000 00000006
  x4: 00000000 00000050
  x5: 00000000 00000000
  x6: 00000000 00020002
  sp: 00000000 fdcc0f30
  BOOTSOURCE_ID fdcc0010: 0000000a
  PMU_CRU fdd00000: 00004064
  PMU_CRU fdd00004: 000014c1
  PMU_CRU fdd0000c: 00000007
  PMU_CRU fdd00010: 00007f00
  PMU_CRU fdd00040: 00002063
  PMU_CRU fdd00044: 00001481
  PMU_CRU fdd0004c: 00000007
  PMU_CRU fdd00050: 00007f00
  PMU_CRU fdd00100: 00000080
  PMU_CRU fdd00108: 00000001
  PMU_CRU fdd0010c: 00000001
  PMU_CRU fdd00110: 00000800
  PMU_CRU fdd00118: 00000001
  PMU_CRU fdd0011c: 00000009
  PMU_CRU fdd00120: 0000050f
  PMU_CRU fdd00124: 00008bbb
  PMU_CRU fdd00188: 00006000  (pmu_clkgate_con[2])
  PMU_CRU fdd00240: 00040020
  DRAM init failed

Above should hopefully make it clear that the reset value in TRM is
likely incorrect ;-)

> 
>> unconditionally ungate these clocks to help ensure PCIe works in U-Boot
>> proper.
>>
>> Change to only ungate these clocks when the PCI Kconfig option is
>> enabled for current boot phase to delay the ungate as late as possible.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> Changes in v3:
>> - New optional patch to help delay the ungate of PCIe ref clocks until
>>    U-Boot proper
>>
>> This patch is strictly not needed, however it seems very unnecessary to
>> ungate PCIe ref clocks in SPL when PCIe typically only is used in proper.
>>
> 
> Considering the kernel seems (I had a cursory look) to be able to 
> control those clocks and have them handled via the pcie node, it seems 
> fine to me to possibly not have the clock enabled by U-Boot (e.g. with 
> U-Boot proper or xPL not enabling PCI).
> 
> So, I'm fine with the content of the patch, not the commit log. Can you 
> please confirm that they are indeed not at 0 when reset (and/or that we 
> do this to be safe when doing reboots) and rework the commit log?

As mentioned above, the commit message has been correct from start, so
please be explicit about what you think is unclear and needs to change.

Regards,
Jonas

> 
> If you want, I can merge patches 2-5 from this series for 2027.01 and we 
> can defer patch 1 here to 2027.04 if you don't have time to send a v4 in 
> the next couple of days.
> 
> Cheers,
> Quentin

