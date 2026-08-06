Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D008C56205
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 18:03:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 992CB80E75;
	Thu,  6 Aug 2026 18:03:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y2YhmTN-nBGo; Thu,  6 Aug 2026 18:03:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C519680E79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786039409;
	bh=qIz2pOhNb+m1zfvs1UKeLVYWz0RNcJDEdE2dc9RCvP8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BDjRLXireMVHpm+Uy8yiTNoMJ09VmQyaEZmoUp3a2Ls5GRILAOT1Gqn69k1n4kYoL
	 t/0wF2Ow8bgcn/vEriJcxNnVp9DD52z7m+yyp5zpnli+OxhlbWJPIT329WtyUGdlXh
	 FaRKF99N3o6MVNjVpldd1vV3m2RZ7eoaj7g8p6Gkwhh5seyaTzZEzJqtTa0DHCJD9F
	 yM7lWGlYcUc4/KjByqYewU9MwYjyDCFN4EQ1LuLFAvelK9E9EGG1RFTsjYO8QVR7NV
	 IU3lyPEw/6E6AWaCRR3y+gGB6xN5Dcpdrz48jjmYOIApT1DxmknwwW7QVSN2AY1YPs
	 sn9Iv0cunWAQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C519680E79;
	Thu,  6 Aug 2026 18:03:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B861397
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 18:03:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5D0F880E79
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 18:03:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z-1cTLaodHx0 for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 18:03:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com;
 envelope-from=malysagreg@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 935CA80E75
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 935CA80E75
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 935CA80E75
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 18:03:27 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so2482384a91.3
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 11:03:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786039407; cv=none;
 d=google.com; s=arc-20260327;
 b=aOInG2VuSWm/5nW7VBR9tKgsDSlMwHHbjgiB590R0aMg68hnLOPioTjPKf9qsI/UHz
 2jhw72yczmnS1sk2v+NIccT/Fj88UbXKojweiS+By6ofM9a4dfL+qsZ31AXNGpPc2Any
 capzlHvcg5aBeRn9F/FSgLi7pkcAlyhnFMb+/wsobkSFp84/rxQjBwmoTHlN+Iz+TYYN
 7HWEVm+ru8G48emsnUkIdrz2U2sncUWWMY3pu/F2s6NRcQYH3/crU6Mya0dTKhhl/abn
 SN0puzA6GdfXVnUcKwXo105JEGO9JzfUco+75r0X42lgPk29c4y43FJpAfubp9OnEkTW
 SUMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qIz2pOhNb+m1zfvs1UKeLVYWz0RNcJDEdE2dc9RCvP8=;
 fh=o4Vy9dEmhdQaE5Sn0s13o36ul6b57cxKzd7L4F+QfFc=;
 b=i/aFSZROJ9OzoWjBpEqchFaqYNA4mKcsiZn4Mht0uhjqbyOIWiiOeQruLqu7w4yAYS
 xZihswLLzBl1WZWcawakE5SZkojkbCQx2nVhHdC32n1hxMoHi8jM1MlfjdPUd2B5VjvU
 2xMRE0uWZVIqRUnkYTv2RwNvDXxcc4/YlSSXrcGUN2G4rAhwdDKJMiZ1zI1cpX+f1swB
 lXpLD2pIuAFpfS/Z77zygs4/v/hrM5VlXOZHJaSnlE7sKb9xX+M6Sk3FpGMVI0GhRkgy
 pxh5S0ppagCi7zrt1oFRadPZhQQ1j3IK3R4gCUl3CtzAOmVyM86cNsDrZDuT16fcSbHF
 SYzg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786039407; x=1786644207;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qIz2pOhNb+m1zfvs1UKeLVYWz0RNcJDEdE2dc9RCvP8=;
 b=K7QZFoeb54aYJLMaS20LtoDbHtkEVM6opgmOQo1wEE6Nl8nKJtScEvp9NjYLxt5n+3
 033EEqDQK82QLdWUAoBCLof0zXeLdVMJPRKqqkvUuxj8fxkALcYYc+A/lTWTjt+Yfgn+
 L/G0ZwyDQ1Q+6nptTFwXN/tC9ip0ZMUEZLvtg8hgUjAM9TH6X2hJdaAMYys8aEBOyZwR
 6kPIh92CtVFFGCD5kz52MOpMuA7sMsm+WjlCPwxJa03awvydNiulJlwa0cqxsT+3tPNU
 3HqlzG3cwNH5dOGC36kUWjku7ktShnruSyU7t45bkA1H/28Q8fGR5aCOBHA1npw+h2P6
 YpFA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/Y5dtNgY6TXMcm/08HC3o2Rhn1St5DZ/DIECPxQ3FBTqOwiJ/3ixrI5tH7fhTkDdD2iQEUxc=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyXz7IqjBW3v0Gfp/fHEa/RcBPjRpDARa4hgFX8hzyYmMTfGBLh
 ugK0K3Nc1HumpoYUnwC/EgaRQIGR1Djee65uho8gXaQb6uvDOwZSW9fA0j5++3BAjzNJsWZbAvW
 hwYmRkMVfsdgt5XzpRcNHEvLxYm8Z3Q==
X-Gm-Gg: AR+sD13zSGglh+5jAX84SkIug9Y5tyL9j5esWw5dzEICv1R5qFXKQEr0++C0bMtmA7M
 rZ2Vc4amFolIlhHOS1CeHT+Zw8F7g26ns/HPW31x7EggVRIaYH4MLncfr0GLeQpX8y/hmLTkFz7
 frZD/PWuTMVOI1gz+mafLRFOn8AYmht5ExrAwRwKceMhgEGLhF/BIRttwiZJqiMdRYx/PWGgTWQ
 xtBF8GT9Rw1F2zXOItHJoXH4C6qS+0mcza08EFbJBYF5TwsNAJ6EaWN7by62vNlJ8Oe3R3qObZN
 EDP33TBJyWmpSgNs4PG5OYGwAdAfCNO5hquu8jx4yuY/awOAjUwiiOjXou3v33CgxUAmDaUVIGA
 W92cUpZQ5UEU=
X-Received: by 2002:a17:90b:17c5:b0:37c:607b:2cd9 with SMTP id
 98e67ed59e1d1-3903b9f3ee3mr14575535a91.0.1786039406744; Thu, 06 Aug 2026
 11:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260804104332.2585195-1-u.kleine-koenig@baylibre.com>
 <CABdDSeV3tiEeVE=_YNn33JN1KDU51h-q8TBOv-Y31T1yF26EkA@mail.gmail.com>
 <anQcSAqpLeHDCXM8@monoceros>
In-Reply-To: <anQcSAqpLeHDCXM8@monoceros>
From: Greg Malysa <malysagreg@gmail.com>
Date: Thu, 6 Aug 2026 14:02:31 -0400
X-Gm-Features: AUfX_mz9VUwlQ7W6X7_QVh-NME1k55oIxXD0bXvtLE6uQPrsm3aZwhL2V3N3PE0
Message-ID: <CABdDSeXw5qO-HsG_50RU=fDpfUb+ZJUXLs-uOdY2dhZM7D8huw@mail.gmail.com>
Subject: Re: [PATCH] arm: sc5xx: Enable BOOTSTD_DEFAULTS
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, Tom Rini <trini@konsulko.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Philip Molloy <philip.molloy@analog.com>, 
 Ozan Durgut <ozndrgt@gmail.com>, Caleb Ethridge <caleb.ethridge@analog.com>,
 linux@analog.com, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786039407; x=1786644207;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qIz2pOhNb+m1zfvs1UKeLVYWz0RNcJDEdE2dc9RCvP8=;
 b=CaabbHW9EG0e9ZMWdIOuX7kjhwIqtO9Tn0m4cm3NSd2ABdFMo7d/r2kqK/1UtOIbcU
 VRthch2nayL73y61Empx/x4cbNhYGTtxnHqa5dXX7SkEINiVw010VO9APWJxoF6iSVlu
 5XlsEIDM3I2QHc9ObaIk9gJo2QPx7/FQxyOs/vO+e3RXWRw2RxBW9i7L5OTxiKJl7MnN
 iJXwlVsFtgCGyfo1WjUr1F5Xw3lETLUYqTma34t2HjyHL7DVKQmRX3Jk2OnFIjos7/Jq
 fYBBNKr/zH+t7yKA7+HeS0bUYbIu93Ynr+ZfPQ+1MzfB5jxuBeg+/I5YmtzMaBuTKwH2
 qYIg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=CaabbHW9
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Uwe,

On Thu, Aug 6, 2026 at 1:48=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
>
> > 2) How do you intend to use a debian image on these boards? The kernel
> > does not currently have mainline support or drivers, and the SPI flash
> > memory is likely too small for a debian image, as it required
> > extensive tweaking in yocto to build root filesystems that would fit.
> > Is it going to use exclusively NFS as the root filesystem?
>
> My usecase here was to be able to start the installer to create a rootfs
> on the eMMC for kernel development on "my" sc598 board.
> And I'm using a custom kernel with the Debian rootfs because indeed
> mainline doesn't work on these machines yet.

Sounds cool! I've never tried running a non-yocto setup on these boards.

>
> > 3) Why not make the same change to the sc594/sc598 boards as well?
>
> That commit is a port of
> https://github.com/analogdevicesinc/u-boot/pull/136 to mainline. I just
> modified all non-spl config/sc5* without much thinking.
>
> I will respin this series on a newer base commit and verify the
> resulting image fits into flash---at least on the one machine I have on
> my desk. I don't know other sc5xx boards, if some of these have a
> smaller flash, enabling CONFIG_BOOTSTD_DEFAULTS for these probably
> doesn't work.

I think for sc598 and newer this is a good idea. For the older 32-bit
ones I agree with Philip that it is probably not worth it. The 598 som
has much larger flash as well so it isn't a problem, but the old 573
ezkit has 16 MB total that we tried to get uboot, kernel, and rfs
into.

Thanks,
Greg
