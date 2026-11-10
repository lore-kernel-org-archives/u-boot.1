Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9604606A31C
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 02:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YjYUmZJS;
	dkim=pass (2048-bit key, unprotected) header.d=timsurber.de header.i=@timsurber.de header.a=rsa-sha256 header.s=MBO0001 header.b=NpC9ZlTW
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1A52407C7;
	Tue, 10 Nov 2026 02:13:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sqDPZHot1iGs; Tue, 10 Nov 2026 02:13:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 474D640721
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794276782;
	b=qvqon3gcTdW8gW8offsKKfqCahBrnvhIRZKEy/YFToIqPRAI5hExMSmSgFKe4alkskpT
	 ZXS4jW+vrRqx02G1zz9cogVtGDLOXb1agXIqxROgQlIXKKI94/h4w3iwoPkq17zvuMWXk
	 sT3+M4MrozUqrYRQrx9rmfd9SYT0lqZ7cnrBbefU3VSGmipw0laSs+kube2tgUjewoB35
	 +UqVvvS5w/ogTf3S1z8VHuESctW4LoknggFenxIdNMud/IhagDqJjnswrloqIlIEm4X6a
	 J3EvH2SBtPOwZOanfpT+u8CMAGK4X8f5w3rRNwxLuQIxHYLe7z61o+8F+T7gQgnNXtg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794276782;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Message-ID:In-Reply-To:
	 References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Priority:Importance:X-Mailer:
	 X-Originating-Client:X-Rspamd-Queue-Id:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FjgYYYWJaOg8VhPkkriAhQ8uftKSWBd2HHoXqrmKKYY=;
	b=tdsSIArpCfHH9Q7ygcS7Xw6SgSmg2jITDSEXGglVpl/js553dAVE7QpJcZciF2yE+cd9
	 +7CfWKRai1X53jMYGGCWYzFQeEvHpldOu7A2hExu+pcM9cozQyXAmo1Bnxyss4zQJPWLm
	 2JW6jLic2n1JKA3Cndwap0HNlgSE1RKVBZaTlq2FbAABqDc9/Du01NI3RSqWNlS85W95n
	 2kGmibU2yJfyr5Eoh2lhWrYRrJDMfI9ZMOrCqD3Uhd9JgV03gRG3sUPjtJrXAqKN/ppKi
	 DikpWgsWs5uqDjPXoECZYXwrWvexqzVulbmL9AidntWuSTVhvEMbElv0rbq8S24n2GQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794276782;
	bh=FjgYYYWJaOg8VhPkkriAhQ8uftKSWBd2HHoXqrmKKYY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YjYUmZJSYKefmSVZNNqrKKFppVjp20neSY5iw4hgWrNd24Gskpdq33RUY6NA1UwMz
	 KLOaCWEbhrHAbvg26i/TdsjtmRRgDY5IUR2SpW0Nc+DZF/YTVT53T8QA86kC6/QqX5
	 sK6NbIFldUA0iT1LE972bmgOiHpYlOrihTwvG2BcUwM/IjrWcYsmzTVn8TqUpH2kTX
	 u/dMYE7wJjz/yN0H+uFmKQ5A35s7rya4M+o0bCMGjxSzbUQcYTdD57DpKJkG2VprhE
	 i4QRglZaMg/BAF/a8IoU3Cg62/1+lIi8BtrKfGfRYHU72PiqB05R7k7qxXUm6LbI1O
	 iQFhiDMbW86SQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 474D640721;
	Tue, 10 Nov 2026 02:13:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D70F9CC4
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 01:59:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C7D0A60790
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 01:59:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bQZYMLU545AJ for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 01:59:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 84D4E60668
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
X-Greylist: delayed 67 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 10 Nov 2026 01:59:29 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=timsurber.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=timsurber.de header.i=@timsurber.de header.a=rsa-sha256
 header.s=MBO0001 header.b=NpC9ZlTW
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=me@timsurber.de; receiver=<UNKNOWN> 
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 84D4E60668
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 01:59:29 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jNqb06c6qz8txj;
 Tue, 10 Nov 2026 02:59:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=timsurber.de;
 s=MBO0001; t=1794275964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FjgYYYWJaOg8VhPkkriAhQ8uftKSWBd2HHoXqrmKKYY=;
 b=NpC9ZlTWeNKYtwtH4aUDl4zMULJvml5saWwd+HNFv05bXih3TkvpNHNTPIamJVAMlvT3Aw
 KkkY05KvtL3OF36AtHvOGaK4p2kioFnOt4lb4HFDkbFp7cnzknil96+HvhXqn/SWuwMfhY
 l0gtvVwwiCrDR4P6CBWjwMnl7YdiCWH9yeEn3ykUyed7OmXT8Jpdb+812eE0OsnzHCz3R+
 bL4Hp0aznS5tEAoIezfGN5YELzklV5l0H3G5HUx885KH9UcA3NCswr28D9sES2gfIzS1Ua
 9p0UyZsFLj9He9TO10WhJ+9GDYVDAqUK6Zcipem5WXnua/lpDI/jMl+04TgaZA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of me@timsurber.de designates
 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=me@timsurber.de
Date: Tue, 10 Nov 2026 02:59:24 +0100 (CET)
From: Tim Surber <me@timsurber.de>
To: Jonas Karlman <jonas@kwiboo.se>, "hello@superkali.me" <hello@superkali.me>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <u-boot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>
Message-ID: <672518753.38177.1794275964239@app.mailbox.org>
In-Reply-To: <a404b26d-e455-4c38-a8d1-18c370565d65@kwiboo.se>
References: <1551247609.687446.1794193215725@app.mailbox.org>
 <51ae203e3fe3198ae4674a24c4625395@superkali.me>
 <a404b26d-e455-4c38-a8d1-18c370565d65@kwiboo.se>
Subject: Re: rockchip: rk3588: big cores left on 24 MHz oscillator, Linux
 boot takes minutes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.53.348
X-Originating-Client: open-xchange-appsuite
X-Rspamd-Queue-Id: 4jNqb06c6qz8txj
X-Mailman-Approved-At: Tue, 10 Nov 2026 02:13:00 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas and Daniele,

you're right, recent main fixes the issue!

Best regards,
Tim
> Jonas Karlman <jonas@kwiboo.se> hat am 09.11.2026 10:24 MEZ geschrieben:
>=20
> =20
> Hi Tim and Daniele,
>=20
> On 11/9/2026 7:37 AM, SuperKali wrote:
> > Hi Tim,
> >=20
> > Thanks for the detailed report and the CM3588 numbers.
> >=20
> > I hit the same thing on a Youyeetoo YY3588 in July and asked Jonas
> > about it. He had rk35xx clk patches queued that might already cover
> > it, so I kept the fix in Armbian and didn't post it. His clk series
> > have gone out since then, but as far as I can see none of them touch
> > the big-core mux or the SCMI CPU clocks.
> >=20
> > Jonas, is this still on your list? If not, I'll rebase the patch on
> > master and send it this week. Tim, a Tested-by on the CM3588 would
> > be very welcome.
>=20
> The commit 514663543ecf ("clk: rockchip: rk3588: Always initialize clocks=
 in
> SPL") now in main, should help ensure that big and little cores are using
> b0pll, b1pll or lpll coming out of SPL.
>=20
> U-Boot v2026.01-rc2 to v2027.01-rc1 do not always set CPU core rates in S=
PL,
> depending on what boot media being used in SPL.
>=20
> With that patch now merged the big cpu core should be clocked at 816 MHz
> instead of 24 MHz.
>=20
> There are also other clock fixes pending ("rockchip: Miscellaneous RK35xx
> clock fixes") at [3], that help fix some other issues in the rk3588 clock
> driver.
>=20
> [3] https://patch.msgid.link/20261011222930.1085075-1-jonas@kwiboo.se/
>=20
> >=20
> > On your questions:
> >=20
> > 1. I went with SCMI because BL31 owns the CPU clocks once it runs
> > =C2=A0 =C2=A0and picks between PLL and PVTPLL itself. Switching the mux=
 in SPL
> > =C2=A0 =C2=A0goes behind its back. Barebox fixed the same issue with
> > =C2=A0 =C2=A0assigned-clock-rates on the SCMI node in its rk3588 dtsi. =
That
> > =C2=A0 =C2=A0would work in rk3588-u-boot.dtsi too, but U-Boot only prob=
es the
> > =C2=A0 =C2=A0SCMI clock device when a consumer asks for it, so somethin=
g still
> > =C2=A0 =C2=A0has to force the probe. That's why the patch calls clk_set=
_rate()
> > =C2=A0 =C2=A0from the CRU probe. Happy to move it to DT if that's prefe=
rred.
> >=20
> > 2. The vendor U-Boot sets all three clusters to CPU_PVTPLL_HZ
> > =C2=A0 =C2=A0(1008 MHz) in rk3588_clk_probe(). In the Linux rk3588-opp.=
dtsi
> > =C2=A0 =C2=A0the lowest big-core OPP is 1.2 GHz at 675 mV, the same min=
imum
> > =C2=A0 =C2=A0voltage the little cluster uses at 1008 MHz, so 1008 MHz o=
n the
> > =C2=A0 =C2=A0big clusters stays below anything Linux would pick. I can'=
t vouch
> > =C2=A0 =C2=A0for the boot-time regulator voltage on every board, and I =
haven't
> > =C2=A0 =C2=A0tested RK3582.
> >=20
> > Thanks,
> > Daniele
> >=20
> > =C2=A0
> > Il 09/11/2026 04:00 timsurber@mailbox.org <mailto:timsurber@mailbox.org=
> ha scritto:
> >> Hi,
> >>
> >> On RK3588 with mainline U-Boot and mainline TF-A, the big CPU clusters
> >> are still clocked from the 24 MHz oscillator when Linux starts. They
> >> stay there until the Linux cpufreq driver loads. Linux prefers the big
> >> cores for work, so early boot is very slow: on a FriendlyElec CM3588
> >> NAS it takes over 4 minutes to reach userspace.
> >>
> >> Setup:
> >> =C2=A0 - U-Boot v2026.10, cm3588-nas-rk3588_defconfig, binman build
> >> =C2=A0 - TF-A v2.15.0, PLAT=3Drk3588
> >> =C2=A0 - rkbin rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.24.bin as ROCKCHI=
P_TPL
> >> =C2=A0 - Debian kernel 7.2.15 (cpufreq-dt is a module and loads late)
> >>
> >> When cpufreq-dt finally comes up, Linux reports the starting rates:
> >>
> >> =C2=A0 cpufreq: CPU0: Running at unlisted initial frequency: 900000 kH=
z
> >> =C2=A0 cpufreq: CPU4: Running at unlisted initial frequency: 24000 kHz
> >> =C2=A0 cpufreq: CPU6: Running at unlisted initial frequency: 24000 kHz
> >>
> >> Timings from the same SD card image:
> >>
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unmodified =C2=A0 =C2=A0SCMI CPU c=
lock raise
> >> =C2=A0 initramfs unpacked =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 43 s =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00.6 s
> >> =C2=A0 Run /init =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A056.9 s =C2=A0 =C2=A0 =C2=A0 =C2=A00.9 s
> >> =C2=A0 systemd-analyze =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A04 min 29 s =C2=A0 =C2=A011.1 s
> >>
> >> Cause, as far as I can tell: rk3588_clk_probe() in SPL programs B0PLL
> >> and B1PLL to LPLL_HZ (816 MHz), but it never switches the big-core
> >> clock mux to them. BIGCORE0/1 CRU CLKSEL_CON(0)[7:6] stay at the reset
> >> value, which selects xin24m. TF-A's SCMI clock driver returns 24 MHz
> >> for that mux setting (clk_scmi_cpub01_get_rate(), src =3D=3D 0), and i=
t
> >> only changes these clocks on the first SCMI set_rate request.
>=20
> The switch to use the PLLs is done in drivers/clk/rockchip/clk_pll.c
> in rk3588_pll_set_rate():
>=20
> =09if (pll_id =3D=3D 0) {
> =09=09rk_clrsetreg(base + RK3588_B0PLL_CLKSEL_CON(0),
> =09=09=09     pll->mode_mask << 6,
> =09=09=09     2 << 6);
>=20
> here mode 2 should be selected.
>=20
> Please see above, the clock driver was not always probed in SPL for
> v2026.01-rc2 to v2027.01-rc1, please re-try with main, and also with the
> series at [3], to my knowledge the core rates should be back to "normal"
> and not 24 MHz with main and/or with the misc fixes series.
>=20
> If you need other board specific core clock rates, please try to use
> clock-assigned-rates in the CRU node for your board.
>=20
> Regards,
> Jonas
>=20
> >>
> >> Armbian has carried a workaround for every RK3588 board since U-Boot
> >> v2026.04 [1 <https://github.com/armbian/build/pull/10125 <https://gith=
ub.com/armbian/build/pull/10543 It raises the CPUL, CPUB01 and CPUB23 SCMI =
clocks to
> >> 1008 MHz from U-Boot proper, after BL31 is running, so that BL31 does
> >> the PVTPLL setup. That produced the right-hand column above. I also
> >> tried setting the CLKSEL_CON(0) mux to B0PLL/B1PLL directly in SPL. It
> >> builds, but I have not tested it on hardware, and it bypasses TF-A's
> >> own view of the CPU clock state, so the SCMI approach looks cleaner.
> >>
> >> Questions:
> >> =C2=A0 1. Is the SCMI approach acceptable upstream, or would you prefe=
r the
> >> =C2=A0 =C2=A0 =C2=A0CPU clocks to be set elsewhere (SPL, or TF-A at BL=
31 init)?
> >> =C2=A0 2. According to the Armbian patch, the vendor U-Boot also uses
> >> =C2=A0 =C2=A0 =C2=A01008 MHz. Is that rate safe on all RK3588/RK3588S/=
RK3582 boards
> >> =C2=A0 =C2=A0 =C2=A0at boot-time voltages?
> >>
> >> SuperKali, you wrote the Armbian patch. Would you be willing to send
> >> it upstream? If not, I can prepare and test a version on the CM3588
> >> with your Signed-off-by kept.
> >>
> >> [1] https://github.com/armbian/build/pull/10125 <https://github.com/ar=
mbian/build/pull/10125
> >> [2] https://github.com/armbian/build/pull/10543 <https://github.com/ar=
mbian/build/pull/10543
> >>
> >> Thanks,
> >> Tim Surber
