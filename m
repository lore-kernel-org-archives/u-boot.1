Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49BBC54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 08:13:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 943E8812AC;
	Tue, 28 Jul 2026 08:13:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q4qT-T5G4jX6; Tue, 28 Jul 2026 08:13:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C8D6481293
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785226388;
	bh=IiS8q1WrktOQg3KX9vKLfWDHRYdowH9z+iE4WF2ypcA=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=llneoQ6elcJmv2jvyuB3NrCAUXNBcscWHmeCWT5VzK/NKEStCD2mz5dXuNC8RATNq
	 dzuqG5D9G/D/ufpmSDIc04N1Gas45SU0rniwcnY+wGuGOArp1vguf7u6yip4rXmQz9
	 ncYO/KTKUZOFQCTimDc+EzFQSEe1RkZgUElNGj8nmI/bt80E5F/sAWQZG3cTs/8ysI
	 BB+VT2HtxDr8E6YxNtGKqZz40F6L3RNsPyJxSB0EvuOhoIdZv+UIPssQEVDI5M/GwF
	 1vmEPd0DdYvOjjTAS1gzm8WyuKa/4VPOpKovoZiNIQakfmflSbVgRdQi5MEJdPDo7z
	 yacCPeWWiwwaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C8D6481293;
	Tue, 28 Jul 2026 08:13:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CA3A045B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 08:13:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A5DAB408EB
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 08:13:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nM6l5_6BJhTQ for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 08:13:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 29A59408E9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 29A59408E9
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 29A59408E9
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 08:13:03 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66C7284873; Tue, 28 Jul 2026 10:13:02 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AFAF82991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 10:13:00 +0200 (CEST)
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5b159850b16so3100074e87.3
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 01:13:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785226379; cv=none;
 d=google.com; s=arc-20260327;
 b=kBOR3mAHliataXs7Lklg9D0Xn99OhLlqMai8GTq/fFPoPW35rjbMNW24GlpwMvKIvY
 5GkhrADLR8zNhbW/J04SPKqblWw4QExQPWNghRQuOxsU6xMflgpmBbi5TIbyjyu2KK36
 qsphOzWED8OxyLHb6z0HQ0RzFfSNav1Y9Y6+s9/SivKGyRGWBUcE/5WumBn7COL49m2X
 injG9LKzI0uZ6N4BR3BUVzgsWwjW2rcGFOLVmxEOpoDSgKE3df2uKfv4KGcGMenmu2Xl
 i4jFmDJDXSr4trz4hSvejNW7AKgMJWZYjA/rbOh8oV4DQKgrTfR+xWuYTB2L0MIy2Mof
 qTPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IiS8q1WrktOQg3KX9vKLfWDHRYdowH9z+iE4WF2ypcA=;
 fh=mPwmtISFP0IMW/EpJ+Kp6oO4MRD8/SJa+OHuIoAPrfU=;
 b=bnjvzlisEN1djRi9pGG+BkZvHyBVugzmZv3AxcFFLF+g0Ix7uFAJAydRTIjcUVRNhu
 lJ4i4IJW1WjVea1o4l1sP6C/ATTfQt5sXKYPU5Dajbjr6dJg515XLQSfkObOYmlj04DC
 rHAMiB8qnyL9FQdOaYNqRTQfT4wpJXUFmr3cK34lCImevm9l6BTcRjWv8l/eYkuE+zys
 vFLpuJ1xMDm4rzGRl4gSt8X3FpBJW7Lr0UFMZFgs8VWw2D4P4UVVbJaaHM2sEg5TnQR9
 LKeijL1iS+5tp9DE2noGHzVGHWHR9rCxyZzOnDjJ+n3OsaSU3VlT5ISjRyC6FrAFh9ro
 +hxA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785226379; x=1785831179;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IiS8q1WrktOQg3KX9vKLfWDHRYdowH9z+iE4WF2ypcA=;
 b=R116UvGYg09Kuv6JHuEK3e7d89kVwQ+Lmr2hgG2/aUSXNQPo/UzkRXJFCf9Yu7cZMk
 HY5SeYa2ftl70LOcQnpywjZEDiExl1mcJqKQVpfYFqW1uGafisUwKp3JRdw1S/mF7v8y
 hv96V84atF4hzT+ZAVRhgAAUCvZdEGQpzqsrB2BcFNg642bjFi7tyo+OtzZhx+HA5qe+
 Lf3F+BMGEGzcPh2wf5ddcQgke6kqfWPGY8Sf+LdgHWWoFLrkHWHlnay31Hyalmzqdd6p
 uIOu2xv1gEEMIBTDojt5/OO46hStDO282WYvT3EuuYduACpxhNaq3AvMMTJPKCXOD0lt
 Et1A==
X-Gm-Message-State: AOJu0YyLSM9kYpLcBn0pyfcaBif55KcIbGBwE7t2AHMJAU2Zu7Pd6ZQ4
 k3aUNug958oit2ibsvIPaZ/I+oOw6+XEKjS/EVd2S6QxpymTl5/qdXAHnSMAEKrR086t/cWf+bu
 UtiWIU0pwwbdyFkjbNdEIYMIa0qG9Rzx2oMxVyPHWiA==
X-Gm-Gg: AR+sD10TP2jrTZJF9XGtf4WIlBZZr9AKo58c/ICad6jfBJttlvr0IOvHxPVSrXr1/R/
 X7NoSuWyVvhgjAbff6D9kXlGWBRSdOjJkxJtB+Bo0qOSB00IY5fozbwN24fie2194ZpNC3qekQ5
 VNkjZdmQHjsCPe/5mmlANyBLUZ7FP82gJN9lH0UqiwDAqk2iLVF7CzmJSeUMKoliFZfOgkg+vjw
 GxKtH+CFBKrfYFJ5fsSEn2Pt0xf4e/jMiVHfhj73aVzfFes28qiH7J/vQWXJyqvfZEG6U6jVFM=
X-Received: by 2002:a05:6512:b85:b0:5b0:1433:13b9 with SMTP id
 2adb3069b0e04-5b2d022360fmr320914e87.25.1785226379089; Tue, 28 Jul 2026
 01:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260722154602.3373184-1-jamie.gibbons@microchip.com>
In-Reply-To: <20260722154602.3373184-1-jamie.gibbons@microchip.com>
Date: Tue, 28 Jul 2026 16:12:47 +0800
X-Gm-Features: AUfX_mwGyxsWY6Ft7E4BTIzJvC6tlCKZyzmOZuR_8QbleObGMM61SrO4fsy3_KI
Message-ID: <CAC7DN2BP7q5BhEY36n7yZkzhteCmMT_PPkdbidoD3E2XVjA0pg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] MPFS: add hardware RNG support and fix RNG
 consumers
To: Jamie Gibbons <jamie.gibbons@microchip.com>
Cc: u-boot@lists.denx.de, Conor Dooley <conor.dooley@microchip.com>, 
 Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>,
 Tom Rini <trini@konsulko.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Martin Herren <sputnik@on-the-web.ch>,
 Michal Simek <michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1785226379; x=1785831179; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IiS8q1WrktOQg3KX9vKLfWDHRYdowH9z+iE4WF2ypcA=;
 b=iaxO2aQm8Rf+B15+s8EAVS3+Z5YT0RNTCBimos7QrRlWdto3gQ7SZK3OKbPgfr62z/
 cbjScILEx56snY88gi1Lg3lYWMb3s9qcNcUzNLzWcBWWWfkiFsLEH1eSBpq5iv3hCfOh
 GsWHT8TUu394QgvJ/HJkDbco8G78o5Xs0ypnO9Go0sMwr5xTOicqdE8H+NJOABFLm8iT
 Ara7c6YxErnilO6HQpKtXLyTBq+nahwPdDkZCkZ0O/jNvQ7kES0YC9ECqBTbTz3OSODQ
 3a1QL3on0N8zPwOPuSDKCZrmZCgjHBlAHyQ0+QYJR+JWikrRJoPe/4zkpacRF15wIfV1
 bQtA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=sifive.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=sifive.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=iaxO2aQm
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=sifive.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=leo.liang@sifive.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=sifive.com header.i=@sifive.com header.b="iaxO2aQm"; 
 dkim-atps=neutral
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
From: Leo Liang via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Leo Liang <leo.liang@sifive.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jamie,

On Thu, Jul 23, 2026 at 8:52=E2=80=AFAM Jamie Gibbons
<jamie.gibbons@microchip.com> wrote:
>
> Hi all,
>
> This series adds support for the hardware random number generator (RNG) o=
n
> the Microchip PolarFire SoC (MPFS) and fixes several related issues
> uncovered during integration and testing.
>
> The MPFS hardware RNG is accessed indirectly via the MPFS system
> controller using the mailbox interface. Unlike typical memory-mapped RNGs=
,
> the system controller mailbox is shared and non=E2=80=91reentrant, which
> introduces integration challenges in U=E2=80=91Boot=E2=80=99s synchronous=
, polled
> execution model during early boot.
> While integrating the RNG support, testing revealed that mailbox requests
> issued during autoboot could fail spuriously due to transient mailbox
> BUSY states. Investigation showed that the MPFS mailbox BUSY indication
> reflects multiple phases of the underlying IHC handshake, allowing
> U-Boot=E2=80=99s polled model to observe intermediate states that Linux=
=E2=80=99s
> interrupt-driven model normally hides.
>
> This series addresses those challenges in various ways.
> 1. Adds missing infrastructure in the MPFS system controller driver to
> explicitly receive mailbox responses.
> 2. Binds the MPFS RNG as a sub=E2=80=91device of the system controller, m=
irroring
> Linux behaviour and avoiding the need for a device tree node.
> 3. Introduces a new MPFS RNG driver implementing UCLASS_RNG.
> 4. Enables RNG support in the Microchip PolarFire SoC generic defconfig.
> 5. Replaces unbounded polling loops with regmap_read_poll_timeout().
> 6. Replaces an immediate -EBUSY return with a bounded wait for BUSY to
> clear, before issuing requests, avoiding spurious early-boot mailbox
> failures and allowing KASLR seed generation to complete successfully
> during autoboot.
>
> The resulting behaviour matches Linux semantics where practical while
> remaining appropriate for U-Boot=E2=80=99s single-threaded execution mode=
l.
> Interactive RNG usage and boot-time KASLR seed generation both work
> reliably after the mailbox sequencing fixes.
>
> All changes have been tested on the PolarFire SoC Icicle Kit ES.
>
> Regards,
> Jamie.

Applied to u-boot-riscv/main, thanks,

Best regards,
Leo
