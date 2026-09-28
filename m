Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E18CA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 14:45:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 22CFE80E31;
	Mon, 28 Sep 2026 14:45:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o3j8t0xoUZ9K; Mon, 28 Sep 2026 14:45:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1CCAE80E9C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790606748;
	b=T5vif0jfJVnBiZWUzHmDiggy2KpdQ6lpi2tRf8T22LpPMrtMHDHZ/3ciqLvDYA5Bh9Ex
	 aQ6v+UbGkly3Ewxfw+hNElxcBlBASx6JTyFNUlthV4znf/0vfG2cnUrXqSHr9Uzzaftvw
	 BQmIK//OuETVPB3mhyanngR34f70WV2A3PQV2OyNHq3jGunM4fQSZEl61HVSc1+oEWrX3
	 hpMYSQ8WDAqmASWvagFyhrro32N1QWsn0Pa6HuUXrNSDj3tKwnMeNzHYB8LF5heM2kUQY
	 803FP5VUQNhj1OFCHmvFrY+icZKvukgo0Ud/RlcMFYcL6ef2DDovn3j44vPTvqzwWdQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790606748;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9EqVS2cVj7a2BmQQxqTveT4p9lO4+s6EZEN92rheTBk=;
	b=l6DjsHqovKK2oux1kincA3cgR0AGYN6iA9oXNAVGBqGjh2601avXgaFjeqeVmQRHVzti
	 car+g6AquZMOfmXDKQdLM8CCU+avpq+vcQKOshKRZnlBWnKggqp4l9QTms3hyr+nZUNPu
	 mgAf0b+5aZuC2fX59TmMBYyfN/Q+hl2n4u6ahWCFk2L50CytoZKiP93DXL+0O+tOOrH+R
	 CRtaUEkq6oEDmFWFvudngsxloShCHNIcYH/yW+m1MjtTsGYOyPwNIHVKfdyx0pmVP37na
	 bPhUsQYDCMy7wSZkNCyC+0ESlvKsVE7L91CzzhbmL/Ya28F0TdHZo+wnyX6vsR9wBVw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790606748;
	bh=9EqVS2cVj7a2BmQQxqTveT4p9lO4+s6EZEN92rheTBk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ReIeuFsbFNcMjcSc4dLDJBZbGUN/Z4IxtT53kerFhtVpdYM6Yp4BpxOxLdOtoT9NL
	 0TNE49EZKobO/AuC3Ecfo2BEWRwV+hL3uBVopa+1HPrXIxPhSnS8LEkQ15vS07w5c3
	 Hb4HuvPa7qloqqiKSelXUWNt70Avv0e7wVgF3NnwTDGbDHgOms/6z88rbP1NSmZmYN
	 Gvjffo41cZz12vSJ5JUkxUcattob+JFabdqbdNpMpWXFIJi/jcbwWND2bwG3N8aViP
	 wKdUOPoEF0hAi90vr3+WBfVux6jPlBjIPxwdMtcuBTuxojrAop72BqgozX2+fvnHcW
	 PjcITrrKMAodg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1CCAE80E9C;
	Mon, 28 Sep 2026 14:45:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CD4B32F
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:45:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F2D5440216
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:45:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cnlxZKxt-EB1 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 14:45:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1901D40210
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790606746;
 b=CzfhE+Sg/WfiOXY4PB9mji3WKw7x1bLwk1/RtOjkBQu8l5POp0pxqD8mcwfA3ynsrhP7
 9RttGwFKnuPts8Tho+OTla3SACmvoJFtxaJTo6kgS3rdG9HOFeISW8XjssEb+YSuGZ/go
 q3Zqw8xLoRhJuL+tUB69UpQwtxhMmPVtAsvdTnkyj5FwcaYre9PWArhD//n6qhlNaLhlZ
 pqgUtE3NEBaq5YoN6nQA0VC23mmUcMOBciBQxIb55PeH887qieHaKWLKtzwtDZJOaqeMY
 V5zW6I5scXhJeE+ux+GxvLgeb9PndxJMysFziyXGriGVxenz1n3aWa8seLkEwoTyqZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790606746;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=9EqVS2cVj7a2BmQQxqTveT4p9lO4+s6EZEN92rheTBk=;
 b=rzGhCwXWmTFycuIScZI5A+3eYJRCsVd7tJW/Zpu9wggfUrzoRbCMNZrrjzOg42gWdBts
 BoZmtn7pyZJzR2/Fp7oR3c/A1Ez2RItc/MbNDO6Q8R15jMIlJ0Yza5Hqr7prjL7TKdvQl
 iih1/bd5O66XqzLAMBoQxoT6OTfpqjEdqBYH8H88b0T14OQkdgLYgw2juP79upA2Ibpfq
 n8WPv6jqLMyzDr+B2+BmsbVeelvUArqxa8Z0+4cmGkrdOIolp1nRNokSdX0eNrvvyq8zK
 aLFhWAt6cdlImGwa0LUBbPeyPkjlEXrWxMPLk8zI1zVOtxSee4QH5PzIM1Urbt8MRBg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Kq6S9dBo; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Kq6S9dBo
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1901D40210
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:45:45 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a99cd5115bso5216429a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 07:45:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790606743; cv=none;
 d=google.com; s=arc-20260327;
 b=APKMNYeOR3bhtKTKFCSAFS0eizqEoa6Xztk2jpDfN69616CyiEM6OggMV/is01rTuv
 o1hDERhSCrLojOgbGj1iJiS3LFvMcclQzKUdV5MKvvsyFPifbj457mnN4dK0qUrJjY9I
 hnQnUDSljiYelADsb6JlH8S03krXmbWK4cvuXqM8HFl5kPUWDHvHhmf+I91vT0UEtuzC
 Rh8B/Ls3a2RxZFRNu56k9D7CDxX3SgMITpp3TEOQ8eFHjOKuEYvIl4rF0x0V42tiaKsN
 h387+kOX63Irz0yu7P4JIZBsSuQNIINOgbVPY1IVjTa0Siy+wH5IXxMDPa80Yvmi312T
 Dt1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9EqVS2cVj7a2BmQQxqTveT4p9lO4+s6EZEN92rheTBk=;
 fh=YaCMksDIwQW19eVjWr+rhXlQ+CAmiAyRS87VGZJO5vQ=;
 b=cuoTMqoXinGXKomRC/GE2LoJQ5SgtPN8OHvBr+lMxq2xxw0Wqk+ZP7Z75TznjhjQDT
 OLbjH5mpycsMq1RPw20WySik0To+UTReOdclCcCL26Tfv0HwJQjFxtFxxeOzJ/QYe5R8
 kU4HsgjcIL1zMesSsteGAGXyIAQuuLyfnCFVCs1WJgYCP7CLo94fiMKMv4w/ZSeZK60i
 S/ir+rKaUcpKQww9YtUxoNk/hJB8utSJEqEAIKZJbd7bLDtqB+MeTYEdZrlosXmIfK4Y
 +RFgTHaMoFUUmuK5lc9+GkGU4M/hb6rvDeMEX1NN8iJjAfbc4F/sd5AKQTxO70Kmmrvs
 hlJA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790606743; x=1791211543;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9EqVS2cVj7a2BmQQxqTveT4p9lO4+s6EZEN92rheTBk=;
 b=Kq6S9dBodaUDbp+36UMIB0mqNGIOf8I1iRRYAUcTIfZkQ8tN2X3td5avpBCItIhlq+
 yJiP/i2J+gQ9QzY9RV19CkJnKlGeuoPZLiquX0bcmXOSfZbhcZEQM+KQ9IQY3L3OLTNm
 j69h7a5ElC9hz0pKuYVrcshNWu4iYAG7qz8JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790606743; x=1791211543;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9EqVS2cVj7a2BmQQxqTveT4p9lO4+s6EZEN92rheTBk=;
 b=rmOU4sJoyb0lQou/w5QE3h0zUy+2ZE9xcCj0ZLPce1LD0Z6PjWoZiykabT1cD4RJWC
 O5PeIXp+1dj+Ke9WAimz23jZwISHLuFac1i1m6Gsk28P1WONrb0ZtxiSyEaqZBCmjkDx
 OnAyirIseoRj11Il+J8k7fQvMAkUn2wwAbEbz6Ibi3kDSxEUD7ymPpSMrukj/dG3FOhK
 N2mEMF7fNcKcbPQipAZot2KOp9x6RkTwlqusI0VURvFqLP8xMteaT/HE1ymQet3AhV8X
 Xus9VhKxw3eycMBDbR+y5COYWL7XK02tNEojrID09jEs8cwta+CFnqE3u16l9QXnn04R
 dikQ==
X-Gm-Message-State: AFq9FYLjcR/0CC3lIihgi+MpMlNUY/vRqfzLcAdNDKOw3OZ7fQq15FkX
 HTyToP/jKzTmKo9fZNHQaadTH4752YJaBEGVnIq/w1Ljn6qvWzsExbNZrwnWhmu8rmQG2vvz+cs
 LBqRz/m3HRGbYSpTyZIsmKkG4cAxJNH7ZVDyWzZAvNEx60EtiPmQ=
X-Gm-Gg: AYBFou1JLtXaW8gDHbXArn0xHd3a4nEEhaz46wHuuQnRDaKW6LzOAqzvmT4Cit9iZuS
 7t2vsgbW4uOo/YZz6vTWWk68Qpjo+3MZZTbFSh+j6y01Wo3HCxHAcagZPDwkwMDAWPSd9OVavph
 ZsxIFbubEPzVFyqxrjW4SqUW6zdUrmMJbzGOE5V6Ioz9ej0UWDXi7v/zVKwf/UeRsPnGhmwOkpN
 zNOnonBUB7TlQ4/S4OPril83jdJONeYEn0umN80H8qe7ZA+6bsT7I8U17Y1UFQ1e0m92ay8eMQ9
 1Pp/sZCqBMyur1/iBh4YJx6C/DrMQvtrPV9lPR4gnsWeJg78Z09MiA==
X-Received: by 2002:a05:6402:4044:20b0:6aa:ee54:970c with SMTP id
 4fb4d7f45d1cf-6aaee549b5bmr5839422a12.23.1790606743495; Mon, 28 Sep 2026
 07:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260922060941.534035-1-hs@nabladev.com>
In-Reply-To: <20260922060941.534035-1-hs@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 08:45:22 -0600
X-Gm-Features: AclHuK-tVzsS7JxhQlxUbBgiWW99XEtTTn3P1D3YMHGft5yu8ecjOZRREIapgiA
Message-ID: <CAFLszTi650uOiYLB6Pn--w0NE12w4+pEq3dN2mqg8SBxDY8xDw@mail.gmail.com>
Subject: Re: [v1,0/3] mtd: spi: Microchip 23LCV1024 SPI SRAM
To: hs@nabladev.com
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Heiko,

On 2026-09-22T06:09:29, Heiko Schocher <hs@nabladev.com> wrote:

> The 23LCV1024 is a 1 Mbit serial SRAM with battery backup on an SPI
> bus, used as non volatile scratch storage. This adds a driver for it,
> plus a sandbox emulation and a unit test.

Just to check the placement: this is an SRAM, not a NOR flash, yet
both the driver and its sandbox emulation land in drivers/mtd/spi/
next to the flash code, and the driver is bound to the spi_flash
uclass. Have you considered drivers/misc/ or a new
drivers/mtd/spi-ram/, with either a dedicated uclass or UCLASS_MTD
directly? Piggy-backing on spi_flash to reach the sf command works,
but the naming is a bit confusing.

> Patch 2 and 3 touch sandbox and the tests not the SPI NOR subsystem.

Not quite - patch 2 modifies drivers/mtd/spi/sandbox.c and patch 3
adds drivers/mtd/spi/spi_ram_sandbox.c plus Kconfig/Makefile entries
in the same directory, so they very much sit inside the SPI NOR
subsystem tree. Please reword this in v2.

Patch 2 introduces a new sandbox,emul device-tree property but I don't
see a binding document for it. Please add a short binding under
doc/device-tree-bindings/ (or extend the existing sandbox SPI binding)
describing what it means, with an example.

Regards,
Simon
