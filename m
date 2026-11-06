Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557CB606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=amKAVLE0;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=ygAzszJY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3024F81261;
	Fri,  6 Nov 2026 16:04:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7s6TupKprSql; Fri,  6 Nov 2026 16:04:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 153F48124A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793981057;
	b=jFV4ud3wuGV9iysb8CkyuaCIguP6LDxyFJYzR9eDN9IBiPNzelqzvAk5HmQrPfOygNeu
	 26p/FauqxANBl4XMcxibYP+7+jr9YilFKvDBwmTF9suN2H5+vJdbMVkrJgjgqtQk74Ps0
	 bcmhrh6VdQFO7dEAK4cOfos7yyENpBJCB8NOCFaoBuegTq8afyAU+gSDx7OkM88yStirm
	 unzcMBisgibu76NXcQ0PpYT1QBL4Oq03c8Dho5g/9ONFApu/rVydl+EouaurZmJNctvFL
	 dnWfFSshNugVMhRpEU0wRp5OljKfhdXT8eW9xcT9qKpW1oJw9pa92h6qpF/y3tXjHmw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793981057;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BhIynbaeoTbeYxBdg118ryPYM/DEIZ7pFnkOc1smlZg=;
	b=d15cbLnYXgceDCuXvSjGXriqlev1mnVLAvLSP8fifd5XUvG7EOOV6pUMgYlltM3uFhI9
	 p0hM5+piNGQOSJCmANS7uBrJ5VuZaKT71iiz75B8NCGxdJusV5kvRY5op7zyL6W4dwFlP
	 zzU3FGEHDUH049MxeSm+6gBw1ykra9m3nCHuiBVyZC3AhLGaXa/IpTDMDsRknYJ9cE1Bq
	 OR2NJS7r9HAGAPLHMCpj4o/mRWw+kONOJ6pE80owb4sWBamq9M2vU9qCpQKld7KL7nsTb
	 9qRPuXzZhJTlq4r8P5mElM4dlK2JhTWCh3PCYvQF23oFHazgkmNU/NGxNIpxxPKcxiw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793981057;
	bh=BhIynbaeoTbeYxBdg118ryPYM/DEIZ7pFnkOc1smlZg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=amKAVLE0vinHC51FHDI+TtybtwO7k8EKuwvJj8AXwpxvE9nksYPn8UI8Mihis2RCv
	 5PeaguvT4E3APi5nSzAAVwTtqW+tJwLoPoZ53nv19NyUa30zPpID2V/zCP6sEOiYE2
	 u2gR1KXTWtJAz6E2KnBvnkUL3EEbfOxz0BQsYtBwVbJmSqtx/aXBB0TNgXAp/kANau
	 zQ+O1X52gjtUFn0zp/VJb0JCOytDKfyfGrvOmCMPGqLgQOkLmNhNDiSRje90fcp49h
	 dYcxQx1SiB5BKxppqG9ClQZq6GCazyWVzUjcbRKasTQkYtfzsW8T1i/pCW1AT4vbpk
	 m3VrOIAWcL7ww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 153F48124A;
	Fri,  6 Nov 2026 16:04:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F1AF32A
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:04:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E7914408F4
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:04:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fAEITf2Plts6 for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 16:04:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 885F8408F3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::635"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=ygAzszJY
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 885F8408F3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:04:13 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c4697404c2bso103106866b.2
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 08:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1793981051; x=1794585851;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BhIynbaeoTbeYxBdg118ryPYM/DEIZ7pFnkOc1smlZg=;
 b=ygAzszJYMv33kwN+kgZMXCf2DnUmB3K+aSHAB+SdojiJh8LMMvIttQWWOTyY60i0O4
 tg5ocaxcHCnQ5GSQxL5FtltdSTC+/6xOGzoOdH279ILL+KT3gvXGzfsLVfKKBlz+d9bE
 cY1w+CrW1V/pHI6xPAAut4fl3WQB+y9QWMnaqHpb/1pFahiycUe8T8mq33oCKOzF0bWZ
 IE3XD2SCS67gOSkrcNY9Un5+iOZapdAv1tQfLCJ2PdsDWiVGDICRdVplpN1KbyEUZzhg
 8u9Fe5aKXMwTXWjMYAVOROs4uGk284dwTswJGyvUTuIuxJGaKG1OemMJB2RGF9ZIWWP7
 xwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793981051; x=1794585851;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BhIynbaeoTbeYxBdg118ryPYM/DEIZ7pFnkOc1smlZg=;
 b=yDVM5Bv2O1KLMXuTpmemTT6OoAbwx89P1+2DPlTRfuClbB5uYy3pkDXEdmzY7foCfF
 Yxm1vNctzKCmEOj3AwQuRURz8/aJgSQNZYtCe1iB8PQgYUteY2kvRakyIJQyiPDY1YKW
 ZFWjjZ8SKamQTYuyD60NmZO0T2rpovht9N4TDrqXl5N3inV24YFgM9HtxwhmSd+2Pixc
 qLPpE7veKYff6OLXvh/dnH59k2fOvNz/KBfJGPiv38TxlO6eFhIjODLfoxkQrSViNdvH
 9/kpvnUjPERXzsNOtpt7BqgFnJbUBHj33JiXzr9Ggvg7Xlr7uT/0BZdUoZDQf2Mj7zWS
 ErRw==
X-Forwarded-Encrypted: i=1;
 AL+hErEghO467Ss89gMgsnbiOcwLnS4gkqN/VtOAQUKnKzcSamWQNCc8mf1HONrE57uFkCGr5w0wAZ4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/w5IbbYsO42l2WNP7FRM2yfe88zK0NXl4Pq1nNC5uK05Jc0H0x
 7fUBOwq/Bv0PvWFv3iq4Gp1AZQ/6WXEQLp32MKZt8Pc5FXJYVUICjkLSac7ym5sJJDaSuZ3ll42
 wh9zVhur5gMugPKhldvWeUXZdz9ddAcVmh7Q5Fw1VOQ==
X-Gm-Gg: AYBFou3o6phAfbNxrQyhdLYOEXn2XGAtHx1hGh2O6HvgP76UyvJkyWyXsgFtnyuoUtH
 u624j+/8gbaaOKes6kVi9EY2qdXtYnaR50Is0FmNLEhUSF9OkyZqy6jB3/k2OnJkGcsE6Y7Rhsl
 4RiIt+n/UWrWJvujO+C8bKBAC1h6CQmfnNLleYbGErwy4931a71XrFgJbxhSw0M/V1rjzWy+Lzi
 dsZiz46WqgSCBVMw9+MXuBvkQIoWY17pyBI/NRAuUbREzQo4ytPgJ3wyC98xGYiiN/JtTwgqTdN
 hU5x15npGlFAXS4c3NY0lKw+v8xXRjupMe8I0AAddRhgdePV7FxwSgKFSCS91boltAV1p9b10PR
 MDEuq1cKQuNNfjalT9XVdpHpNR4RJ4pAd6K29n0nCWu4oh5m3k8476GzL7Ak1iTwCeVgCVg==
X-Received: by 2002:a17:907:94c4:b0:c37:8ccb:9b76 with SMTP id
 a640c23a62f3a-c4d34c7101fmr226148966b.40.1793981050925; Fri, 06 Nov 2026
 08:04:10 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028141554.3073545-1-anders.roxell@linaro.org>
 <b464c545-c1f4-461f-8f17-48854bd70825@cherry.de> <aunlk5FaVe_jcpSr@monster>
 <ca7b3725-cabd-4064-95dd-46c3eaa325f0@cherry.de>
 <548adaa3-9d2f-4fa2-8fdf-7c537c4d153b@cherry.de>
In-Reply-To: <548adaa3-9d2f-4fa2-8fdf-7c537c4d153b@cherry.de>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 6 Nov 2026 20:04:00 +0400
X-Gm-Features: AclHuK9rTa2daIuotQI7xsi3xMkpxuCIktZlBJRKJEtotHYF_INuVamZV3SEDh8
Message-ID: <CAKTNdwGTdBfOp+km6Wpp2reV2Nt6hoa1Tvfj8tBC4+uU+h3bJA@mail.gmail.com>
Subject: Re: [PATCH v10 00/30] usb: dwc3: part 2, make the resynced code work
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.u-boot-project.org, 
 marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org, 
 michal.simek@amd.com, lukma@nabladev.com, jerome.forissier@arm.com, 
 dlechner@baylibre.com, anshuld@ti.com, sjg@chromium.org, 
 Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org, love.kumar@amd.com, 
 s-vadapalli@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin, Anders,

On Fri, Nov 6, 2026 at 2:57=E2=80=AFPM Quentin Schulz <quentin.schulz@cherr=
y.de> wrote:
>
> Hi Anders,
>
> On 11/4/26 6:51 PM, Quentin Schulz wrote:
> > Hi Anders,
> >
> > On 11/3/26 2:45 PM, Anders Roxell wrote:
> >> On 2026-10-30 15:28, Quentin Schulz wrote:
> >>> Hi Andrew,
> >>>
> >>> On 10/28/26 3:15 PM, Anders Roxell wrote:
> >>>> Hi,
> >>>>
> >>
> >> [ ... ]
> >>
> >>> - Q7 USB P0 (lower) with Sandisk Extreme Pro USB stick,
> >>> - Q7 USB P2 (upper) with Sandisk Extreme Pro USB stick,
> >>>
> >>> RK3399 Puma behaves the same in main and with your series applied.
> >>> RK3588 Tiger has some regressions.
> >>>
> >>> Q7 USB P2 (upper) doesn't detect the Sandisk Ultra Flair USB stick
> >>> anymore.
> >>> It does on main branch, but on the USB2 controller only.
> >>>
> >>> Q7 USB P0 (lower) has issues handling the Kingston USB stick. 1st try=
:
> >>
> >> Hi Quentin,
> >>
> >> Thanks for testing both boards.
> >>
> >> About the OTG port: no need to spend more time on it.
> >>
> >> v10 had two bugs in the dwc3 core. It never read the core version, so
> >> every version check was false. It also cleared the GSBUSCFG0 REQINFO
> >> bits on every controller, and main does not touch them. v11 fixes both=
.
> >> My best guess for the Kingston write on P0 is REQINFO, but I have no
> >> Tiger to test it on.
> >>
> >> Did the other sticks pass with v10? That is the Ultra Flair and the
> >> Extreme Pro on P0, and the Kingston and the Extreme Pro on P2. I want
> >> to know if it is only one stick on each port.
> >>
> >
> > - Q7 USB P0 (lower) with Sandisk Ultra Flair USB stick,
> > - Q7 USB P2 (upper) with Sandisk Ultra Flair USB stick,
> > - Q7 USB P0 (lower) with Kingston USB stick,
> > - Q7 USB P2 (upper) with Kingston USB stick,
> > - Q7 USB P0 (lower) with Sandisk Extreme Pro USB stick,
> > - Q7 USB P2 (upper) with Sandisk Extreme Pro USB stick,
> >
> > was what I tested, on both v10 and main, on both RK3588 Tiger and RK339=
9
> > Puma. I only reported the ones that didn't work, so yes to your questio=
n
> > above.
> >
> >> Can you run the same tests with v11? It is on [1], on top of main
> >> ab4dc5aacf95.
> >>
> >
> > With v11 checked out, I only tested the scenarios with regressions I
> > reported in the previous mail, that is only, on RK3588 Tiger only, with
> > Kingston USB stick on P0 and Ultra Flair on P2.
> >
> > 2/2 tries were successful (regression gone) for the Kingston stick on P=
0.
> >
> > 5/5 tries for Ultra Flair on P2 (detected on the USB2 controller same a=
s
> > on main) were successful (regression gone). I got one try for Ultra
> > Flair on P2 that reported the stick on the USB3 controller, funnily
> > enough, the only try when I got a "cannot reset port 1!?". All other
> > times, the USB stick was attached to the USB2 controller (like on main)=
.
> >
> > I would like to run all test scenarios again and see if v11 introduces
> > other regressions compared to v10, but this takes me about 2h
> > uninterrupted and I'm not sure I will have time tomorrow or Friday as
> > there are other fires to put out (still have to review the OpenSSL
> > provider thing again, and I'm now finally impacted by it myself as I
> > updated to Fedora 45 with OpenSSL 4 this morning).
> >
>
> For the v11 (commit 6030c4d33099 ("usb: dwc3: enable SUSPHY again after
> xhci is registered")):
>
> Tested-by: Quentin Schulz <quentin.schulz@cherry.de> RK3399 Puma
> usbdrd_dwc3_1
> Tested-by: Quentin Schulz <quentin.schulz@cherry.de> RK3588 Tiger
> usb_host1_xhci + usb_host2_xhci
>
> I've just remembered I've now got a Pine64 Quartz64 (RK3566) with two
> DWC3, will try it next Monday.
>
> I should have access to a Pine64 Rock64 (RK3328) starting 2027 where I
> could test the DWC3 controller in there, if I don't forget (90% I will)
> I can then report regressions, if any.
>
> Not having access to any RK3528 device with a DWC3 (MangoPi 28k, NanoPi
> R28S, NanoPi Zero 2, Radxa E20C, Radxa Rock 2A/2F), or to any RK3576
> device with a DWC3 (Anbernic RG Vita Pro, ArmSom Sige5, Khadas Edge 2L,
> NanoPi M5/R76S, Radxa Rock 4D), I cannot test those. I'm assuming Alexey
> may be able to help for the RK3576 with the FlipperOne device (or others
> since he has quite the collection of RK3576 boards IIRC). For RK3528,
> maybe Jonas can help.

I gave the v11 (from GitHub) a spin on a couple of my RK3576 boards: a
Flipper One and an RK3576 EVB1 board connected to each other via a
full-function Type-C cable, using the dual-role controller on each,
and alternating roles for testing.

I found no regressions vs. main, and in one case v11 worked where main
didn't, so please consider the combined series as a whole:

Tested-by: Alexey Charkov <alchark@flipper.net> # Rockchip RK3576

What I tried:
1. Enumerate the onboard hub on the Flipper One (USB2+USB3, on USB1
controller) - works both on main and with the series applied
2. Initialize the USB0 controller after RAM boot out of maskrom (USB
upload, so the boot ROM leaves the controller running) - fails
identically on main and with the series applied, fixed for me by
[1]+[2] in either case
3. Expose a USB mass storage gadget from a Flipper running Linux to
the EVB1 running U-Boot - works both on main and with the series
applied, same throughput
4. Expose the internal UFS storage via `ums 0 scsi 0` from a Flipper
running U-Boot to the EVB1 running Linux - does not work on main
(never enumerates), works with the series applied and my two fixes
added (only after limiting speed to HS; SS still fails to enumerate)

[1] https://github.com/flipperdevices/u-boot/commit/89e4119ab6f3283b42d9590=
d0cf161d447f970cb
[2] https://github.com/flipperdevices/u-boot/commit/1dbd284347fdf9343ee72e7=
1674a35e735ffeca7

Thanks a lot for your work on this, Anders!

Best regards,
Alexey
