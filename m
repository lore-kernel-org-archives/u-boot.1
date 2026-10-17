Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00356CCA462
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 05:25:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7CEE340809;
	Sat, 17 Oct 2026 05:25:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2QGkTdipz3aL; Sat, 17 Oct 2026 05:25:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 315F2407CA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792214713;
	b=nR1aa8HxEiV/feRBjp7Re+RaLX3Kk/EY+0lrhcrsFCWIsQksuejTXYyrqcpOsVcDshCJ
	 17TcuLYEEoBPNo2F2iUq2n0AE1bdzeLEpaYN9B3fK7I3dSzpP5j/EApQgVb56bzxg96Jw
	 yztURjsiCESW0kkJya6+G2KkgL4xsWn1uZx7wnhAg/HFxQt/of03m+FOy9JlBrBltk4aW
	 6yBgAYfEHZ1sTeHDne2xFyPx6n9f2IRFVfijwz5aRYlvpH3V+Ea5O3CRqOpUCja2Xw4Pa
	 kJmMlUscUzP4X0eYM4vXqv/pjqhJL3ULkmCA8n9zi/v+ENKk+Jiv/9BlNx/9hLdyBtQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792214713;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Received:DKIM-Signature:Received:Received:Received:From:To:
	 Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:In-Reply-To:References:Message-Id:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ADevz4lTg88zlLGgtsqLNfkee88d26se6TI4xXgALMw=;
	b=eOT4uE2RbNgrfIxWtQc0wDPUU/b5fM4WjVmaDZok1FHPl14DH/gQZYubk5Cy+wz64LPW
	 H4R/8Dj15Nk9PJ4G7UIorRUg8aOAUGkYPM6mDy82wyzdUdYPLiDuvQJWqBR9eDHf1jG/M
	 LvT4mbPn8xqubT2gGkpdAy99m3kLX/mvZrNOE6h3DZFCPLq9NpSG4nzVKl4mJ2aUnNLFg
	 0UOdM4llLUFarwxPbwDdhWFIY/fICep+9mHuIbu7lFi3jN3GemkfYcLRtKSxdffzHeYPO
	 Di7zzefqblIUbsiIw5NsNxOo+MhW6kgiX1Rxso4J/Iz+Ur2FG71ygnPsAcQ3qv1F4PA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792214713;
	bh=ADevz4lTg88zlLGgtsqLNfkee88d26se6TI4xXgALMw=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KBJoz9CsGbPFAqRgyt6MQi1uDn38dO0expb7p9HUzwDf337F9bBUZtoP4IKKAy6pi
	 BuxVfGebUrm2Nao/UpRErTIzJ4RlHN7prudDYIKdB4qk5DakzPWzoQ7GNKzwbq+AGF
	 gB7KAoEw7fZZzPTrDkP9ALKgvMY9O8FzfVsTLT6PGn+neMmfA4TvKUZxVdbeUyXftd
	 H+oQeSvklCpiMEuPdvlUiRAkbdrxFxcpgHXHADLSrFiJ7oxvvx0HoRJ08hyBDlWnnm
	 0WWAypnNzDwHH/IHKZ1PafUyj+BZZBsqF4Y5zZzCGVPNCH1RTFCHe22c8IgrUtG/6e
	 YW57wkE8dHNVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 315F2407CA;
	Sat, 17 Oct 2026 05:25:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2629E75
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 05:25:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0C16181479
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 05:25:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ovSO8v5CKhaK for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 05:25:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 57C4B8146F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=210.145.249.197
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792214710;
 b=ig7mzlUuHloJPCII+Z3hQ2FbpnPj4I+DBYgBtKoNcKVOS4kDuHFw+bCHFJ3h8kUqYPLh
 RqENbnY8GPRRTSzYu4zcQhNQ7sa3x4jPqIOBuPbiS6sCRyDELGhkDnMvQQwr3VcErJ5eM
 nswQ50NyM8U0eBN4BeuWgITJRRbTZnIGyE5retkPjBzwfqqTzGvQgPgVdrysXeltHZ4A/
 woCvsmJJ2jtJPt7DTGopsqabQ0wXuqGJmkzCiJG0V9jWdhE/nmrT3pays+tTrfN//ryVS
 /lkXKgXCNll8SX1TN8qXWYxQq3hYKyGZPipuqoGsATNfSjA5ghiHAYvYHiBRRyFmibQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792214710;
 h=X-Greylist:Received-SPF:Received:Received:DKIM-Signature:Received:
 Received:Received:From:To:Subject:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer:In-Reply-To:References:Message-Id;
 bh=ADevz4lTg88zlLGgtsqLNfkee88d26se6TI4xXgALMw=;
 b=JwfOk8mfEc+J5Olbl14KKyaKvX9uN7kqnT5f5NaAPaXAXL8SOd7FL6bIUhKYWuYIorVV
 5pQ6AyoSHTe2ag8HnKAisU75k60lXSLY7g0ncy7sch9ffT/FZsubm0NK7UnaO3M+ydZqn
 fjpZcshwKv1efVbuunHG2XjNaQY92eu4uEJ6qLYUtWDc+BOPU4MgEXRv3oIIBDwOSdhy+
 6SlhlOT9IvLDYLrpgq88jw1jJnyLdAM8ZO/uCg50TgzBtjpWzqGu9aTFnH5TKwLoR2HW5
 ua9p61oVp1i7lmqHtg/PuyVRoErP58THbEstqgoi4Gh9ExVUiDwFLp29eY23ZiwlLCQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=docomonet.jp;
 dkim=pass header.d=docomonet.jp header.i=@docomonet.jp header.a=rsa-sha256
 header.s=20240125 header.b=vPZCY4l0; 
 arc=none smtp.remote-ip=210.145.249.197
X-Greylist: delayed 546 seconds by postgrey-1.37 at util1.osuosl.org;
 Sat, 17 Oct 2026 05:25:10 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=docomonet.jp
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=docomonet.jp header.i=@docomonet.jp header.a=rsa-sha256
 header.s=20240125 header.b=vPZCY4l0
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=210.145.249.197;
 helo=ocn-dfr-mts-202c2.ocn.ad.jp; envelope-from=y-asai.0816@docomonet.jp;
 receiver=<UNKNOWN> 
Received: from ocn-dfr-mts-202c2.ocn.ad.jp (ocn-dfr-mts-202c2.ocn.ad.jp
 [210.145.249.197])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 57C4B8146F
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 05:25:09 +0000 (UTC)
Received: from ocn-ckd-mts-208c36.ocn.ad.jp (ocn-ckd-mts-208c36.ocn.ad.jp
 [125.170.88.101])
 by ocn-dfr-mts-202c2.ocn.ad.jp (Postfix) with ESMTP id 388EEC0000F5
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 14:16:02 +0900 (JST)
Received: from ocn-spm-mts-201c1.ocn.ad.jp (ocn-spm-mts-201c1.ocn.ad.jp
 [210.145.246.199])
 by ocn-ckd-mts-208c36.ocn.ad.jp (Postfix) with ESMTP id 048F460008B95
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 14:15:56 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=docomonet.jp;
 s=20240125; t=1792214156;
 bh=ADevz4lTg88zlLGgtsqLNfkee88d26se6TI4xXgALMw=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=vPZCY4l0HFT6c49YR9hhxFTkgmIy04vCpJPkDdJx9kXDW8o4eziIsVzcvIJ6Y820k
 hGBi7AKFpt7DEwyRO9rdAf83s4QkwmG1+O/FYzLuniT5Hk8chJpQl6uQtjTdsyjaFo
 n5jp6fjhQvF/Ie42QcTOYbZxFBTBFLPbdrOC4ogQ=
Received: from ocn-vc-mts-210c1.ocn.ad.jp ([210.145.250.232])
 by ocn-spm-mts-201c1 with ngmta
 id 01b03369-18df3947801d6e2d; Sat, 17 Oct 2026 14:15:55 +0900
Received: from ocn-sdpx-mts-202c1.ocn.ad.jp ([210.145.249.135])
 by ocn-vc-mts-210c1 with ngmta
 id 46fc158b-18df39473c7f4d88; Sat, 17 Oct 2026 14:15:54 +0900
Received: from docomonet.jp (p3688129-ipoe.ipoe.ocn.ne.jp [153.238.101.128])
 by ocn-sdpx-mts-202c1.ocn.ad.jp (Postfix) with ESMTPA
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 14:15:54 +0900 (JST)
From: "Asai, Shigeaki" <y-asai.0816@docomonet.jp>
To: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 2/2] arm: dts: meson-g12b-odroid-go-ultra-u-boot: set
 vddio_c to 3.3V
Date: Sat, 17 Oct 2026 14:15:54 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: HidemaruMail 7.42 (WinNT,A00)
In-Reply-To: <69377c9e-b4a1-462a-b82d-66e13b465626@0leil.net>
References: <20261010013237.2269021-1-y-asai.0816@docomonet.jp>
 <20261010013237.2269021-3-y-asai.0816@docomonet.jp>
 <69377c9e-b4a1-462a-b82d-66e13b465626@0leil.net>
Message-Id: <EDD5DF6959F6392F3006A@docomonet.jp>
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

(Resending to the list only; my first reply was rejected by the list
server. Sorry for the duplicate.)

Hi Quentin,

Thank you for the review.

On 10/16/26, Quentin Schulz wrote:
> I'll let Neil decide since he's the maintainer of that code, but I don't
> think this is necessarily correct? The spec specifically allows
> 2.7-3.6V, c.f. https://www.sdcard.org/developers/sd-standard-overview/.
>
> Moreover, RK3399 Puma has 1.8-3.0V only, and it's been working fine for
> years now (though I haven't checked with that SD card specifically).
>
> What happens if you do NOT use the SD in U-Boot at all and boot straight
> to the Linux kernel, is it also broken in the Linux kernel then? If not,
> then your issue is probably not what your tool output and we may have an
> issue elsewhere (possibly in the MMC subsystem for example).

Linux is fine with this card at 3.0V. Linux itself sets vddio_c to
3.0V, and the system runs from the same card (SD high speed, 50MHz)
with no errors in dmesg.

Following your comments, I tested again without this patch, and I can
no longer reproduce the problem. I tried U-Boot 2025.07, 2026.07 and
2026.10, with and without patch 1/2, and three SD cards, including the
one in the commit message. In about 35 reboots from Linux, U-Boot always
read the card and booted the kernel. At the U-Boot prompt after a
reboot, vddio_c was 3.0V and the SD card ran at 40MHz, so the
conditions were the same as in my original report. I do not know what
was different when I saw the failure.

So I agree that 3.0V is probably not the cause, and I will drop this
patch. If I can reproduce the problem again, I will look at it again,
including the MMC side as you suggested.

Neil, sorry for the noise.

Best regards,
Shigeaki Asai

(This reply was written with the help of Claude.)
