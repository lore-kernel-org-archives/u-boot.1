Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6360606D83A
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=URAXTZFQ;
	dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=loO2aRFb
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F285405E6;
	Mon,  9 Nov 2026 09:25:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HVYZQPQ2MbyN; Mon,  9 Nov 2026 09:25:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3103840640
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794216302;
	b=aGj2mRsntZOu02Ujjrfj12s6ndWezswlB855uk0oCSCYGNuz6P2/apaPAdfPeGq+Lw0E
	 9juKeNWzvkrkwDFlTE88HkI+O48WqrngaTS2j5R2wT1NDzsNJ6AbjIx9I1AVgpuCfwo6c
	 m4EQVQlySJp2yqMvXWBl3VdCydYilPFwC5PVXYa/q6C8j0qYQE7vPNh0E4eUKVhLtYno1
	 ihaQyAFYGfm9dIQLTXLS0JkzvJdpAnS3xNrjMPxgYj3cWzffBs9GwxrEtVefpD3TNI6r3
	 R5tKDOoxJTwqiwlkhez9zAtuT8c4cgRCPqH+5GQs4IgNpHow9FcACI6LrjbfmKBDcsA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794216302;
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
	bh=n+XHEsHgSJHDz3ZBejAcmJHBcZQO6YFFqHFnkuz33f8=;
	b=EkeYvoAoD97zcMjO+0/KWOtSo86C2SUTZ5kh9FEzsbT+CPK8HV4C3Yi+hMMDuDUWtRyU
	 x+NdHTzYAREGTQdOSx15I5Yy8Vt9lxmEEXIax2V4NwN3CnDAeWbCWJVdAAn3vy+tWhjlw
	 44t/N7vVRXez5GrMw7AtAlWiXceYax9+0DVDuQe+DYaaw+nW5x+a0Mv0M3jB5DPhQa9AY
	 iEOK3tNo5AHZUHDG9BqAZnis0ZZe1cCQPpTqowcyLpTjgkFbBk6x+W+oJ73oodVV3OKkX
	 W3mk/8d0Tk0SY8SQPY7lMg6tJz6JrX1AIIntxGLXZO2tPPJEOnb0GPAauuB1wF50LvQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794216302;
	bh=n+XHEsHgSJHDz3ZBejAcmJHBcZQO6YFFqHFnkuz33f8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=URAXTZFQvBTrOG6iv/renitvajJC0A99WFnFfWmyEb3A7wlV4amYQMctzhiOgdolX
	 0Q4zGnWh/6XhIbBb/Hh+NJEeFnjoXB62tKmZalwYv0Lp0dHhIx2r8FR814DE1Yvx2q
	 sdwpBBcIUgNcXJZUc+1fsVl4t3FIwsLGAcrZVxto3IwxHT+skS1YpaOJTBt7Sy/DQh
	 YMCaPdEYOoHvDKk3z34e/z/7MqO+3KSa2JuP8sH4QsyGNblVjKK6D/l6KpW4cIe+EY
	 zT0IECvrW4Uy5xrjdxygzFIJQFF/cIe2L2GaPMMhVjjRhWmK9RAordgWYQFtWaA/vN
	 4fyTAlrOD4olg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3103840640;
	Mon,  9 Nov 2026 09:25:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A4853235
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 09:25:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A131F80E31
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 09:25:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tgRirigC7AYe for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 09:24:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DAAD680C87
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=88cc=i6=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=loO2aRFb
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DAAD680C87
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 09:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From:
 Content-Language: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID; q=dns/txt; s=fe-e1b5cab7be; t=1794216296;
 bh=n+XHEsHgSJHDz3ZBejAcmJHBcZQO6YFFqHFnkuz33f8=;
 b=loO2aRFbbkrzkuaKf+u5zHataxn2CmmrbbjnKuEholPWgefR9ol/mTNYzhoTaTufCorMqby97
 L7Y9ubUyB0zSAxriTe17nO9e6FUDcrWLdsfGZzQ7b0hyMQlrCordflY/GSJR/uXkViZ9mSn2Q+X
 D4qKypSCgrLXGcaLZ1/HyKA+q4YerHLvckd0WaZOQh8DdDWFtsdLWnahehfK9t7aHX2ZNXmVVWB
 gD43mGDD6gF+SNBSkjXSUvqr9hEyMH5kCGYIw8mHSidpponvZ4hMvAY+oduJIUHiTG0qZcsJ0U9
 QegYtLL8p7dqdlPgIx465Xk/lmdeNdpIJUYvOZNP5x8A==
X-Forward-Email-ID: 6af191655ebd64eb2309de9c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.19.13
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <a404b26d-e455-4c38-a8d1-18c370565d65@kwiboo.se>
Date: Mon, 9 Nov 2026 10:24:47 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rockchip: rk3588: big cores left on 24 MHz oscillator, Linux boot
 takes minutes
To: "hello@superkali.me" <hello@superkali.me>,
 "timsurber@mailbox.org" <timsurber@mailbox.org>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>
References: <1551247609.687446.1794193215725@app.mailbox.org>
 <51ae203e3fe3198ae4674a24c4625395@superkali.me>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <51ae203e3fe3198ae4674a24c4625395@superkali.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tim and Daniele,

On 11/9/2026 7:37 AM, SuperKali wrote:
> Hi Tim,
> 
> Thanks for the detailed report and the CM3588 numbers.
> 
> I hit the same thing on a Youyeetoo YY3588 in July and asked Jonas
> about it. He had rk35xx clk patches queued that might already cover
> it, so I kept the fix in Armbian and didn't post it. His clk series
> have gone out since then, but as far as I can see none of them touch
> the big-core mux or the SCMI CPU clocks.
> 
> Jonas, is this still on your list? If not, I'll rebase the patch on
> master and send it this week. Tim, a Tested-by on the CM3588 would
> be very welcome.

The commit 514663543ecf ("clk: rockchip: rk3588: Always initialize clocks in
SPL") now in main, should help ensure that big and little cores are using
b0pll, b1pll or lpll coming out of SPL.

U-Boot v2026.01-rc2 to v2027.01-rc1 do not always set CPU core rates in SPL,
depending on what boot media being used in SPL.

With that patch now merged the big cpu core should be clocked at 816 MHz
instead of 24 MHz.

There are also other clock fixes pending ("rockchip: Miscellaneous RK35xx
clock fixes") at [3], that help fix some other issues in the rk3588 clock
driver.

[3] https://patch.msgid.link/20261011222930.1085075-1-jonas@kwiboo.se/

> 
> On your questions:
> 
> 1. I went with SCMI because BL31 owns the CPU clocks once it runs
>    and picks between PLL and PVTPLL itself. Switching the mux in SPL
>    goes behind its back. Barebox fixed the same issue with
>    assigned-clock-rates on the SCMI node in its rk3588 dtsi. That
>    would work in rk3588-u-boot.dtsi too, but U-Boot only probes the
>    SCMI clock device when a consumer asks for it, so something still
>    has to force the probe. That's why the patch calls clk_set_rate()
>    from the CRU probe. Happy to move it to DT if that's preferred.
> 
> 2. The vendor U-Boot sets all three clusters to CPU_PVTPLL_HZ
>    (1008 MHz) in rk3588_clk_probe(). In the Linux rk3588-opp.dtsi
>    the lowest big-core OPP is 1.2 GHz at 675 mV, the same minimum
>    voltage the little cluster uses at 1008 MHz, so 1008 MHz on the
>    big clusters stays below anything Linux would pick. I can't vouch
>    for the boot-time regulator voltage on every board, and I haven't
>    tested RK3582.
> 
> Thanks,
> Daniele
> 
>  
> Il 09/11/2026 04:00 timsurber@mailbox.org <mailto:timsurber@mailbox.org> ha scritto:
>> Hi,
>>
>> On RK3588 with mainline U-Boot and mainline TF-A, the big CPU clusters
>> are still clocked from the 24 MHz oscillator when Linux starts. They
>> stay there until the Linux cpufreq driver loads. Linux prefers the big
>> cores for work, so early boot is very slow: on a FriendlyElec CM3588
>> NAS it takes over 4 minutes to reach userspace.
>>
>> Setup:
>>   - U-Boot v2026.10, cm3588-nas-rk3588_defconfig, binman build
>>   - TF-A v2.15.0, PLAT=rk3588
>>   - rkbin rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.24.bin as ROCKCHIP_TPL
>>   - Debian kernel 7.2.15 (cpufreq-dt is a module and loads late)
>>
>> When cpufreq-dt finally comes up, Linux reports the starting rates:
>>
>>   cpufreq: CPU0: Running at unlisted initial frequency: 900000 kHz
>>   cpufreq: CPU4: Running at unlisted initial frequency: 24000 kHz
>>   cpufreq: CPU6: Running at unlisted initial frequency: 24000 kHz
>>
>> Timings from the same SD card image:
>>
>>                                unmodified    SCMI CPU clock raise
>>   initramfs unpacked           43 s          0.6 s
>>   Run /init                    56.9 s        0.9 s
>>   systemd-analyze              4 min 29 s    11.1 s
>>
>> Cause, as far as I can tell: rk3588_clk_probe() in SPL programs B0PLL
>> and B1PLL to LPLL_HZ (816 MHz), but it never switches the big-core
>> clock mux to them. BIGCORE0/1 CRU CLKSEL_CON(0)[7:6] stay at the reset
>> value, which selects xin24m. TF-A's SCMI clock driver returns 24 MHz
>> for that mux setting (clk_scmi_cpub01_get_rate(), src == 0), and it
>> only changes these clocks on the first SCMI set_rate request.

The switch to use the PLLs is done in drivers/clk/rockchip/clk_pll.c
in rk3588_pll_set_rate():

	if (pll_id == 0) {
		rk_clrsetreg(base + RK3588_B0PLL_CLKSEL_CON(0),
			     pll->mode_mask << 6,
			     2 << 6);

here mode 2 should be selected.

Please see above, the clock driver was not always probed in SPL for
v2026.01-rc2 to v2027.01-rc1, please re-try with main, and also with the
series at [3], to my knowledge the core rates should be back to "normal"
and not 24 MHz with main and/or with the misc fixes series.

If you need other board specific core clock rates, please try to use
clock-assigned-rates in the CRU node for your board.

Regards,
Jonas

>>
>> Armbian has carried a workaround for every RK3588 board since U-Boot
>> v2026.04 [1 <https://github.com/armbian/build/pull/10125 <https://github.com/armbian/build/pull/10543 It raises the CPUL, CPUB01 and CPUB23 SCMI clocks to
>> 1008 MHz from U-Boot proper, after BL31 is running, so that BL31 does
>> the PVTPLL setup. That produced the right-hand column above. I also
>> tried setting the CLKSEL_CON(0) mux to B0PLL/B1PLL directly in SPL. It
>> builds, but I have not tested it on hardware, and it bypasses TF-A's
>> own view of the CPU clock state, so the SCMI approach looks cleaner.
>>
>> Questions:
>>   1. Is the SCMI approach acceptable upstream, or would you prefer the
>>      CPU clocks to be set elsewhere (SPL, or TF-A at BL31 init)?
>>   2. According to the Armbian patch, the vendor U-Boot also uses
>>      1008 MHz. Is that rate safe on all RK3588/RK3588S/RK3582 boards
>>      at boot-time voltages?
>>
>> SuperKali, you wrote the Armbian patch. Would you be willing to send
>> it upstream? If not, I can prepare and test a version on the CM3588
>> with your Signed-off-by kept.
>>
>> [1] https://github.com/armbian/build/pull/10125 <https://github.com/armbian/build/pull/10125
>> [2] https://github.com/armbian/build/pull/10543 <https://github.com/armbian/build/pull/10543
>>
>> Thanks,
>> Tim Surber

