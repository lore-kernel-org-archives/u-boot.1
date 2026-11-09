Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A0E606A323
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 07:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AY3UCHvT;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=superkali.me header.i=@superkali.me header.a=rsa-sha256 header.s=default header.b=djfi2PqQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58C7180F1D;
	Mon,  9 Nov 2026 07:00:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dc8NJvDfwdDs; Mon,  9 Nov 2026 07:00:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 031C980F07
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794207625;
	b=c1ywweuePsBof9FAleDTRfKw7AE0cWfxHYVW9Q7u3e6djUENyvX0rUANtZNcsVQ5uzXG
	 fhoP9duopRE3ErDLzeMyKIpk0c0Plve05TsoXb1qTbNkLIbyL04JOUtxrQFNm9B+l50ql
	 dOMXKiUvSPqR+aIfWhCAXA8ZaOxRdH0hLWaW4FJIwdud1NkjkvcnF62V5b9FgWq0nwWAT
	 z+W6EA7aHkGAnY8fk1TAL7xVdYb3RRAvenh4W9KoEMWEaq6on5d3uKsWKw7SueVn5m+ZI
	 akZzAYkEEP8oqBkRhNYAt/d8CS6evOxmzDrA7fgapNZxWf1wwCq5shlecX3PhBLtzow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794207625;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:MIME-Version:Date:From:To:Cc:Subject:
	 Mail-Reply-To:In-Reply-To:References:User-Agent:Message-ID:X-Sender:
	 Content-Type:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-Get-Message-Sender-Via:X-Authenticated-Sender:X-Source:
	 X-Source-Args:X-Source-Dir:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=GHjGf2EA0Yo+KCuuTG9RY4QgeWHP03Z52FfL1n0MCFU=;
	b=NaqqCEOVA0XwCBnllkWWuTSHMQHaI9Wgu3veudZaqftnXZ4ptJvx5pQ9NFoGCKZgiqGi
	 z3jydlVd0ygFW+AVTk/28u4NRfmlm6X7PJPik/KhkDKSyI5D4X7xVwoHhJON3G/bDA+W5
	 VUl1PQumD6d1Ol/FjUqMo9/XK4QBtstCvjd8kquxnG8I/cz3kUSlUc86S1GYX+quSk6mp
	 OsHHxME4j1ZS9fCb7M1sIOnY6eN1n2CQIef8o61zv2lNTCL+VnNeEvda85xG5nGa+ZQ/3
	 n60zDlkT9ou9xmd6i3Mt98lSigA2kMOqeuWp/5gFfaZ5ebg1KhiaQFrMBBPWCO1EboQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794207625;
	bh=GHjGf2EA0Yo+KCuuTG9RY4QgeWHP03Z52FfL1n0MCFU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=AY3UCHvTH989E7O1giEelFuN/zwjJ1izA8btdSegOEcaHWPccPXIQCY7juTrbPRoT
	 2m+UVmZlBippj4Z+G0Xl/LAv4B4iyq8lHco+xWKyxlnGpb2FRsQG1HTQXkIufEaRZD
	 7OpO0F8TeB460jV4Krl+9a5S7pC2GYRa5NCwzozUiqxBFoPbW1gRtLrBWuKwpZQDAb
	 Lt2cjfrLkMKB6ghdKsylEmmk3ihrS3laibM4b1IVrB36J2QkEnHjQ2s71QIuvJ11/V
	 mDJXruImtm5o/tj5MtuAJWnfnOdubvIm0B0L6fayVN33luWogNVtx/AN6VoSB3Rdig
	 XCHVFMI++byBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 031C980F07;
	Mon,  9 Nov 2026 07:00:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3BDBB361
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 07:00:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2D50560621
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 07:00:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uy_VIbWeSBEV for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 07:00:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BBC0A605F7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=92.42.104.18
X-Greylist: delayed 1357 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 09 Nov 2026 07:00:21 UTC
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=superkali.me
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=superkali.me header.i=@superkali.me header.a=rsa-sha256
 header.s=default header.b=djfi2PqQ
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=92.42.104.18;
 helo=fr5000-r.dnsiaas.com; envelope-from=hello@superkali.me;
 receiver=<UNKNOWN> 
Received: from fr5000-r.dnsiaas.com (fr5000-r.dnsiaas.com [92.42.104.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BBC0A605F7
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 07:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=superkali.me; s=default; h=Content-Type:Message-ID:References:In-Reply-To:
 Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GHjGf2EA0Yo+KCuuTG9RY4QgeWHP03Z52FfL1n0MCFU=; b=d
 jfi2PqQ4hd6GY3wENKHNZHKYlROyLIc5ZWv7v5a/mBqKHJjCM4CTzCGoGS0EEvNdcnf5HMnkAj6NY
 lOknORq8rTpMgRyYee+jmR+8X4KJQigwOK+A3p5HqcDLKL6hsb+uYmiIUGiP/DrqpUgI6uZ583VKS
 feEYJ7TXI/bppjO4D9a2RXnIs28auz2CHCUjFiIhFgSgn09BWfc2m/hUb/lTI2J51+lyumOgvP4TW
 ZQ5X1dsTMM3QFePoDjoBCP/7lruLqpmqraLL/z8eLO4wR80mrWdS98hcabGerlKAi6I5ZWcI+l9yU
 kM3DEu1OUG9UKux+BaXDMRCn6i7Xlelkg==;
Received: from [::1] (port=59844 helo=fr5000-r.dnsiaas.com)
 by fr5000-r.dnsiaas.com with esmtpa (Exim 4.100.1)
 (envelope-from <hello@superkali.me>) id 1xQJ0g-00000001G5m-1ag5;
 Mon, 09 Nov 2026 07:37:40 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Mon, 09 Nov 2026 07:37:38 +0100
From: SuperKali <hello@superkali.me>
To: timsurber@mailbox.org
Cc: u-boot@lists.u-boot-project.org, jonas@kwiboo.se, Kever Yang
 <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>, Simon Glass
 <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>, Tom Rini
 <trini@konsulko.com>
Subject: Re: rockchip: rk3588: big cores left on 24 MHz oscillator, Linux boot
 takes minutes
Mail-Reply-To: hello@superkali.me
In-Reply-To: <1551247609.687446.1794193215725@app.mailbox.org>
References: <1551247609.687446.1794193215725@app.mailbox.org>
User-Agent: Roundcube Webmail/1.6.20
Message-ID: <51ae203e3fe3198ae4674a24c4625395@superkali.me>
X-Sender: hello@superkali.me
Content-Type: multipart/alternative;
 boundary="=_87bd90e897ba99bd8dfae6798f269fe8"
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - fr5000-r.dnsiaas.com
X-AntiAbuse: Original Domain - lists.u-boot-project.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - superkali.me
X-Get-Message-Sender-Via: fr5000-r.dnsiaas.com: authenticated_id:
 hello@superkali.me
X-Authenticated-Sender: fr5000-r.dnsiaas.com: hello@superkali.me
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: hello@superkali.me
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--=_87bd90e897ba99bd8dfae6798f269fe8
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII;
 format=flowed

Hi Tim,

Thanks for the detailed report and the CM3588 numbers.

I hit the same thing on a Youyeetoo YY3588 in July and asked Jonas
about it. He had rk35xx clk patches queued that might already cover
it, so I kept the fix in Armbian and didn't post it. His clk series
have gone out since then, but as far as I can see none of them touch
the big-core mux or the SCMI CPU clocks.

Jonas, is this still on your list? If not, I'll rebase the patch on
master and send it this week. Tim, a Tested-by on the CM3588 would
be very welcome.

On your questions:

1. I went with SCMI because BL31 owns the CPU clocks once it runs
    and picks between PLL and PVTPLL itself. Switching the mux in SPL
    goes behind its back. Barebox fixed the same issue with
    assigned-clock-rates on the SCMI node in its rk3588 dtsi. That
    would work in rk3588-u-boot.dtsi too, but U-Boot only probes the
    SCMI clock device when a consumer asks for it, so something still
    has to force the probe. That's why the patch calls clk_set_rate()
    from the CRU probe. Happy to move it to DT if that's preferred.

2. The vendor U-Boot sets all three clusters to CPU_PVTPLL_HZ
    (1008 MHz) in rk3588_clk_probe(). In the Linux rk3588-opp.dtsi
    the lowest big-core OPP is 1.2 GHz at 675 mV, the same minimum
    voltage the little cluster uses at 1008 MHz, so 1008 MHz on the
    big clusters stays below anything Linux would pick. I can't vouch
    for the boot-time regulator voltage on every board, and I haven't
    tested RK3582.

Thanks,
Daniele

Il 09/11/2026 04:00 timsurber@mailbox.org ha scritto:

> Hi,
> 
> On RK3588 with mainline U-Boot and mainline TF-A, the big CPU clusters
> are still clocked from the 24 MHz oscillator when Linux starts. They
> stay there until the Linux cpufreq driver loads. Linux prefers the big
> cores for work, so early boot is very slow: on a FriendlyElec CM3588
> NAS it takes over 4 minutes to reach userspace.
> 
> Setup:
> - U-Boot v2026.10, cm3588-nas-rk3588_defconfig, binman build
> - TF-A v2.15.0, PLAT=rk3588
> - rkbin rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.24.bin as ROCKCHIP_TPL
> - Debian kernel 7.2.15 (cpufreq-dt is a module and loads late)
> 
> When cpufreq-dt finally comes up, Linux reports the starting rates:
> 
> cpufreq: CPU0: Running at unlisted initial frequency: 900000 kHz
> cpufreq: CPU4: Running at unlisted initial frequency: 24000 kHz
> cpufreq: CPU6: Running at unlisted initial frequency: 24000 kHz
> 
> Timings from the same SD card image:
> 
> unmodified    SCMI CPU clock raise
> initramfs unpacked           43 s          0.6 s
> Run /init                    56.9 s        0.9 s
> systemd-analyze              4 min 29 s    11.1 s
> 
> Cause, as far as I can tell: rk3588_clk_probe() in SPL programs B0PLL
> and B1PLL to LPLL_HZ (816 MHz), but it never switches the big-core
> clock mux to them. BIGCORE0/1 CRU CLKSEL_CON(0)[7:6] stay at the reset
> value, which selects xin24m. TF-A's SCMI clock driver returns 24 MHz
> for that mux setting (clk_scmi_cpub01_get_rate(), src == 0), and it
> only changes these clocks on the first SCMI set_rate request.
> 
> Armbian has carried a workaround for every RK3588 board since U-Boot
> v2026.04 [1 [1]][2 [2]]. It raises the CPUL, CPUB01 and CPUB23 SCMI 
> clocks to
> 1008 MHz from U-Boot proper, after BL31 is running, so that BL31 does
> the PVTPLL setup. That produced the right-hand column above. I also
> tried setting the CLKSEL_CON(0) mux to B0PLL/B1PLL directly in SPL. It
> builds, but I have not tested it on hardware, and it bypasses TF-A's
> own view of the CPU clock state, so the SCMI approach looks cleaner.
> 
> Questions:
> 1. Is the SCMI approach acceptable upstream, or would you prefer the
> CPU clocks to be set elsewhere (SPL, or TF-A at BL31 init)?
> 2. According to the Armbian patch, the vendor U-Boot also uses
> 1008 MHz. Is that rate safe on all RK3588/RK3588S/RK3582 boards
> at boot-time voltages?
> 
> SuperKali, you wrote the Armbian patch. Would you be willing to send
> it upstream? If not, I can prepare and test a version on the CM3588
> with your Signed-off-by kept.
> 
> [1] https://github.com/armbian/build/pull/10125
> [2] https://github.com/armbian/build/pull/10543
> 
> Thanks,
> Tim Surber


Links:
------
[1] https://github.com/armbian/build/pull/10125
[2] https://github.com/armbian/build/pull/10543
--=_87bd90e897ba99bd8dfae6798f269fe8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3DUTF-8" /></head><body style=3D'font-size: 10pt; font-family: Verdana,Gen=
eva,sans-serif'>
<div class=3D"pre" style=3D"margin: 0; padding: 0; font-family: monospace">
<p>Hi Tim,</p>
<p>Thanks for the detailed report and the CM3588 numbers.</p>
<p>I hit the same thing on a Youyeetoo YY3588 in July and asked Jonas<br />=
about it. He had rk35xx clk patches queued that might already cover<br />it=
, so I kept the fix in Armbian and didn't post it. His clk series<br />have=
 gone out since then, but as far as I can see none of them touch<br />the b=
ig-core mux or the SCMI CPU clocks.</p>
<p>Jonas, is this still on your list? If not, I'll rebase the patch on<br /=
>master and send it this week. Tim, a Tested-by on the CM3588 would<br />be=
 very welcome.</p>
<p>On your questions:</p>
<p>1. I went with SCMI because BL31 owns the CPU clocks once it runs<br />&=
nbsp; &nbsp;and picks between PLL and PVTPLL itself. Switching the mux in S=
PL<br />&nbsp; &nbsp;goes behind its back. Barebox fixed the same issue wit=
h<br />&nbsp; &nbsp;assigned-clock-rates on the SCMI node in its rk3588 dts=
i. That<br />&nbsp; &nbsp;would work in rk3588-u-boot.dtsi too, but U-Boot =
only probes the<br />&nbsp; &nbsp;SCMI clock device when a consumer asks fo=
r it, so something still<br />&nbsp; &nbsp;has to force the probe. That's w=
hy the patch calls clk_set_rate()<br />&nbsp; &nbsp;from the CRU probe. Hap=
py to move it to DT if that's preferred.</p>
<p>2. The vendor U-Boot sets all three clusters to CPU_PVTPLL_HZ<br />&nbsp=
; &nbsp;(1008 MHz) in rk3588_clk_probe(). In the Linux rk3588-opp.dtsi<br /=
>&nbsp; &nbsp;the lowest big-core OPP is 1.2 GHz at 675 mV, the same minimu=
m<br />&nbsp; &nbsp;voltage the little cluster uses at 1008 MHz, so 1008 MH=
z on the<br />&nbsp; &nbsp;big clusters stays below anything Linux would pi=
ck. I can't vouch<br />&nbsp; &nbsp;for the boot-time regulator voltage on =
every board, and I haven't<br />&nbsp; &nbsp;tested RK3582.</p>
<p>Thanks,<br />Daniele</p>
</div>
<div class=3D"pre" style=3D"margin: 0; padding: 0; font-family: monospace">=
&nbsp;</div>
<div class=3D"pre" style=3D"margin: 0; padding: 0; font-family: monospace">=
Il 09/11/2026 04:00 <a href=3D"mailto:timsurber@mailbox.org">timsurber@mail=
box.org</a> ha scritto:
<blockquote type=3D"cite" style=3D"padding: 0 0.4em; border-left: #1010ff 2=
px solid; margin: 0">Hi,<br /><br />On RK3588 with mainline U-Boot and main=
line TF-A, the big CPU clusters<br />are still clocked from the 24 MHz osci=
llator when Linux starts. They<br />stay there until the Linux cpufreq driv=
er loads. Linux prefers the big<br />cores for work, so early boot is very =
slow: on a FriendlyElec CM3588<br />NAS it takes over 4 minutes to reach us=
erspace.<br /><br />Setup:<br />&nbsp; - U-Boot v2026.10, cm3588-nas-rk3588=
_defconfig, binman build<br />&nbsp; - TF-A v2.15.0, PLAT=3Drk3588<br />&nb=
sp; - rkbin rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.24.bin as ROCKCHIP_TPL<br=
 />&nbsp; - Debian kernel 7.2.15 (cpufreq-dt is a module and loads late)<br=
 /><br />When cpufreq-dt finally comes up, Linux reports the starting rates=
:<br /><br />&nbsp; cpufreq: CPU0: Running at unlisted initial frequency: 9=
00000 kHz<br />&nbsp; cpufreq: CPU4: Running at unlisted initial frequency:=
 24000 kHz<br />&nbsp; cpufreq: CPU6: Running at unlisted initial frequency=
: 24000 kHz<br /><br />Timings from the same SD card image:<br /><br />&nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp;unmodified &nbsp; &nbsp;SCMI CPU clock rais=
e<br />&nbsp; initramfs unpacked &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 43 s &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp;0.6 s<br />&nbsp; Run /init &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;56.9 s &nbsp; &nbsp; =
&nbsp; &nbsp;0.9 s<br />&nbsp; systemd-analyze &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp;4 min 29 s &nbsp; &nbsp;11.1 s<br /><br />Cause, as far=
 as I can tell: rk3588_clk_probe() in SPL programs B0PLL<br />and B1PLL to =
LPLL_HZ (816 MHz), but it never switches the big-core<br />clock mux to the=
m. BIGCORE0/1 CRU CLKSEL_CON(0)[7:6] stay at the reset<br />value, which se=
lects xin24m. TF-A's SCMI clock driver returns 24 MHz<br />for that mux set=
ting (clk_scmi_cpub01_get_rate(), src =3D=3D 0), and it<br />only changes t=
hese clocks on the first SCMI set_rate request.<br /><br />Armbian has carr=
ied a workaround for every RK3588 board since U-Boot<br />v2026.04 [<a href=
=3D"https://github.com/armbian/build/pull/10125" target=3D"_blank" rel=3D"n=
oopener noreferrer">1</a>][<a href=3D"https://github.com/armbian/build/pull=
/10543" target=3D"_blank" rel=3D"noopener noreferrer">2</a>]. It raises the=
 CPUL, CPUB01 and CPUB23 SCMI clocks to<br />1008 MHz from U-Boot proper, a=
fter BL31 is running, so that BL31 does<br />the PVTPLL setup. That produce=
d the right-hand column above. I also<br />tried setting the CLKSEL_CON(0) =
mux to B0PLL/B1PLL directly in SPL. It<br />builds, but I have not tested i=
t on hardware, and it bypasses TF-A's<br />own view of the CPU clock state,=
 so the SCMI approach looks cleaner.<br /><br />Questions:<br />&nbsp; 1. I=
s the SCMI approach acceptable upstream, or would you prefer the<br />&nbsp=
; &nbsp; &nbsp;CPU clocks to be set elsewhere (SPL, or TF-A at BL31 init)?<=
br />&nbsp; 2. According to the Armbian patch, the vendor U-Boot also uses<=
br />&nbsp; &nbsp; &nbsp;1008 MHz. Is that rate safe on all RK3588/RK3588S/=
RK3582 boards<br />&nbsp; &nbsp; &nbsp;at boot-time voltages?<br /><br />Su=
perKali, you wrote the Armbian patch. Would you be willing to send<br />it =
upstream? If not, I can prepare and test a version on the CM3588<br />with =
your Signed-off-by kept.<br /><br />[1] <a href=3D"https://github.com/armbi=
an/build/pull/10125" target=3D"_blank" rel=3D"noopener noreferrer">https://=
github.com/armbian/build/pull/10125</a><br />[2] <a href=3D"https://github.=
com/armbian/build/pull/10543" target=3D"_blank" rel=3D"noopener noreferrer"=
>https://github.com/armbian/build/pull/10543</a><br /><br />Thanks,<br />Ti=
m Surber</blockquote>
</div>
</body></html>

--=_87bd90e897ba99bd8dfae6798f269fe8--
