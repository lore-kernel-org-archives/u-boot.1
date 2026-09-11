Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB656C88E53
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 01:07:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A68C2606C8;
	Sat, 12 Sep 2026 01:07:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j4lTvgH8ZaM2; Sat, 12 Sep 2026 01:07:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 69EB860721
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789175268;
	b=OJg9C7rF7xFRR/fcglEsn4N/gPBKvLiUgcYNeetefBFhhA84+oz/SMG4Hwbm8pNpyuGh
	 pX1q83GrHunK4asVUHPqWLY3MaTYCZFN9GSsEF4fB8pUKSUQSr5SBq6G6a9QPWJEM84BB
	 dy9YgO9AIRRBOTXHmQ6e5Jy1HoQfx37IZv3p43GZnvHD2k41uhqvyzeKFZv9f9N7odbso
	 7ShmUlO16UDilMeIxM+45XcgB1skBlWr+qZIKGMex86aCcp+rRp41PmYtF9iv6vC6sDiM
	 Z0InR3mhH6jYCbciqh6k83wO+NR8CQ5ClHDGgX8FwT+P1V8QPK/5Fh2KIILlnMIWIfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789175268;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uBfc4obMp1zG6PEaC17wgshWbaxb8aygACjsVJwa/NE=;
	b=MMjtOk+B0EgtV58YWMwpbJyevwojeHcfQ6vpLrQYiok2iwubwxPQ2IS/coBLJ0S38s4d
	 FJMTGPmvg699KFzqBGx52apvJBt8xWQEYnJ8N4SuSUVfHpyfEOavmgp9MEyHldd/v1szH
	 jN4+oPvXkzYc6yOvQMpA6v+gE3N12aUUiIidxzhivVIkSG0r8bYqtZkV3V19Y3wgEdZbr
	 /tBzrRZIzJIwTgtzb+OyVsfD+zGrqzcoODTe/eUNwbiX2STQx8FxZKQKcPI7g56jUO/96
	 CordW+prkoFmmdun+cyRv4LxgJkGmnlzAYwErx+Th6bpdMUKwcYakbdjH7OtMmoPOdg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789175268;
	bh=uBfc4obMp1zG6PEaC17wgshWbaxb8aygACjsVJwa/NE=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zzKWK6jDAFOQaVtO0F/uSrU/3QAUHI6ft7LGRpSkmJzLpnB6NvHsWM5khuGB+HERQ
	 bNYpICskk85hlsaEAgIEMVyhJDtWYDhXTq3g4xuIKbeW0faAmvYek/725b/BYB9qGE
	 kBlCDI3Yori1WLf+JhldnqJUrLA/mFkUZO5pW592GfQaWpCqGIYaKLkRLTtoyd/THP
	 4k2LNzJIbnawNgtUBXvFdeAyyRjDECPFzKOR47rTBIvWSQd9EEduMiy5GeKOiTsxgr
	 Cbt6gyJo4mYsqfOMys1wekgSNDBNZlaDZVST0eRGyM0h9BxReWoBUQkH00Ip+AVs/2
	 MdeRJyphgSmbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69EB860721;
	Sat, 12 Sep 2026 01:07:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 685D5255
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 19:20:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4DB9F80F54
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 19:20:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T1HlgIvnaPuY for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 19:20:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A49E780F4F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.103
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789154423;
 b=FrRvhfg8fnTmzhnVLqJcnTiNAcXkMG7FM86+BiYvJO4/WshPDvQYJuKPrSuNWXztOs0O
 yOttrLOa3b3kPJPPYZPqiEiNhoVAYm9HC6Q7429lkhGvJJya/aOZOhnJqAYSe63F1G2gW
 sRm1XhaoQ5H4Zxp4IQAsQ7EBhi9kTN7GYhp1MVqLZ3oQSftn/SNKC6vgeasEHtOGywTCq
 AIYG3YRm/XQrMBvWM9DBaB4rlNA3ntNVoEgA+y8zkUdyAkFIayhSLUte9Xk7+wshpraUB
 zokW5czfv3JM2W5WQ029beKOmN5ycLEyKcoxxwrEBhLX9sqmkRmDWb5wcjR+FqjFk7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789154423;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=uBfc4obMp1zG6PEaC17wgshWbaxb8aygACjsVJwa/NE=;
 b=Bv44dzOTdy3vRVjNq8rNUilT4+wPmMiefllIutbpC1E1eqTg7UogUmMSROjv91GHR4kx
 Vhg13iuZGxRA7ivmqixpWHJz5/gsmJk9HfiIkgFvGQ47HeyyTAPg7BOGQE7hF+PbcyUyX
 I2cH8jt0T6KW83dj6ua6lFZGrbbOIQmA58gixPOhUCA6VWmnpkHwTx3wmZShYGvHYZ3H1
 zxspNwQa4E/kZq8kD2ndnhY5JvKQPGV0JtyOZtL9k6Bhu9GdT46aAHV7QDeGwoJVbPXZF
 x2ahCa1Gh3JvHBuyXwCzQd4SfdxV4hgr7WmS+c+c75BJWZdvLOWM/fwqejWquXWxVdA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=GutX9YtC; 
 arc=none smtp.remote-ip=109.224.244.103
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.103;
 helo=mail-244103.protonmail.ch; envelope-from=petr.hodina@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=GutX9YtC
Received: from mail-244103.protonmail.ch (mail-244103.protonmail.ch
 [109.224.244.103])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A49E780F4F
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 19:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1789154410; x=1789413610;
 bh=uBfc4obMp1zG6PEaC17wgshWbaxb8aygACjsVJwa/NE=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=GutX9YtC6NshaIXbktl7ZNjSOxRn38G1Uj0c5QbRiRfj2Kkdh/PsmWECF2n/R4vWW
 aHt2X3ksM7JV3/cuLsFmIqnNl59ap9bAeZpotq+T1Mqm/HhNWkQrOHGr9kHqRnlAwE
 kwEEkvpf27Jxg+4oXvEIBNdi0GduPO8nIOTkHf2Y2zuQBkWG0EBBv+mXKRZ1iBatCf
 ZIgjlLREi25rHOUW0L+meXUBs6JLD7F2CSZbVR768/+ZoVlFzCUdEBKlXDJPSGwE1K
 gLqERnRY4QNzoQD+fiai2nVb+ONkCedv6XnDnp+DhAxoEhNzIIxjuagBPZaWYbN86k
 rbHmwKMnohoMA==
Date: Fri, 11 Sep 2026 19:20:05 +0000
To: Tom Rini <trini@konsulko.com>
From: phodina <petr.hodina@protonmail.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.u-boot-project.org,
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Alexey Charkov <alchark@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Anshul Dalal <anshuld@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, David Heidelberg <david@ixit.cz>,
 Petr Pavlata <petr@acrux.cz>
Subject: Re: [PATCH 1/4] common: Add command line parsing utilities
Message-ID: <8aDPIwN_xcto5LeR9MPcrDr5NaNDDImT7S5mRkPmJpYhukYnX4XP52fNqlscYcXRFjQmiSi3ygivxpgY2hAILJ7xrSE0apkH123kYnXPUNo=@protonmail.com>
In-Reply-To: <20260911185345.GT1764417@bill-the-cat>
References: <20260911-b4-android-bootargs-carryover-v1-0-6ebb43da3df0@protonmail.com>
 <20260911-b4-android-bootargs-carryover-v1-1-6ebb43da3df0@protonmail.com>
 <17753947-74ac-4b42-8d94-436e7984e062@mailbox.org>
 <U6YrT3S_BQGuySCLDPjwnTxE9bvcH4uMX9vLfz5D0b32Kumb7X-TVcYowyUHmESFKNVU8jSLlDPqYQI9Y6owcWFWAicWEhCrB7lL4J1z6JE=@protonmail.com>
 <49a1bcfe-1aec-465d-b138-52b6803ce9c0@mailbox.org>
 <20260911185345.GT1764417@bill-the-cat>
Feedback-ID: 23468634:user:proton
X-Pm-Message-ID: ddcceb4bc35dd72042cc67f9441240ae4e28f305
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 12 Sep 2026 01:07:35 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Friday, September 11th, 2026 at 8:53 PM, Tom Rini <trini@konsulko.com> w=
rote:

> On Fri, Sep 11, 2026 at 08:46:30PM +0200, Marek Vasut wrote:
> > On 9/11/26 8:39 PM, phodina wrote:
> > > On Friday, September 11th, 2026 at 8:30 PM, Marek Vasut <marek.vasut@=
mailbox.org> wrote:
> > >=20
> > > > On 9/11/26 8:18 PM, Petr Hodina via B4 Relay wrote:
> > > > > From: Petr Hodina <petr.hodina@protonmail.com>
> > > > >=20
> > > > > Add a new utility library for parsing command line parameters in
> > > > > key=3Dvalue format.
> > > > Is this reinventing environment or UPL ?
> > > >=20
> > >=20
> > > The target is a chainloaded environment. In this case u-boot running =
on Android devices where you unfortunately don't have the possibility to us=
e UPL.
> > >=20
> > > As stated above it's purpose is to simplify the operations on the com=
mand line arguments from the previous stage and pass them to the next.
> > >=20
> > > Typical example is to remove the skip initramfs or extract the value =
for the panel to pick the right dtb (not part of this patch series)
> >=20
> > Is this something you could do in an U-Boot script using setexpr sub/gs=
ub
> > instead ?
>=20

Well that should be possible as the C strings are messy.

However, the intention is to be used from SPL where
the setexpr sub/gsub would not be available.

> Yes, I would like to see how this gets used in implementation too, as
> I'm wondering if we shouldn't just be also saving off something like
> "prev_bl_bootargs" and leaving the rest to the board code to deal with.
> Maybe we should also add the android-specific helpers in a new file
> under an Android-related Kconfig as well.
>=20
> --=20
> Tom

Will send the example in another patch series with detailed description.

TLDR; The boot.img contains as the main target the SPL u-boot build with ba=
rebone dts. Qcom has a thing called SMEM which can be used in runtime to de=
tect the board and based on that we pick the correct dtb and jump to normal=
 u-boot.

Also thanks for the good idea to place the helper under Android Kconfig.
