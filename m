Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B16CA5FCC
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 20:15:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42F7040B26;
	Wed, 30 Sep 2026 20:15:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BeYPghRv-sTg; Wed, 30 Sep 2026 20:15:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7FF5C40B38
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790799324;
	b=WlGNRI6qyeqfYfVUXwJG5RU+cdTZg5NwpYyuzqLIMUPEY9pE3w1rhVlNIsPlt/Out6xr
	 oXkUwL7hYoNHIDWKrZ7s6QIwCNTyq5In3Hf2A85VsUcS4SxzN2GCVc2SgvHzxz7h/ThoO
	 dE/N+mjmWe7FjEKEXYGpecS/yp4ma02IiTVsYBMWuytQ5JKij4CC/SrOfhcM/5m654k8C
	 keupeDwJzoNs45znIMfBtHJK7p66KPBbgJsy9p4CG1mjoesyC2VDhmWHQSHkmR8rRabWm
	 ZQ1ZyDtFlSovUG7j94WuBl0BEZzt52kpfHWnfmEgNYCh9+Pb0W5sTixgiHXAR04pG7Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790799324;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BUICAzswUrX8vt1uNGRhY2WEqYMZSe2D2vVWQXBHMW8=;
	b=laPw0iU2BZnBuPcxjlwnxcbuM8Evmj9dxLAtFPcUv6fANGu/NOtztZsKaf5yAQ4ayt3E
	 swi4fZVGZolFQsnD25aY9ZUp5xYOBhLNlhSsi3cDp0r9Htn0Txhc8ai82boMr/qa3T9GY
	 vGMYrX3OLOlN7IP7ugfryUKq6DK2ldaBJBoRCSkAKUgVXrHgWr/ATAd1g15OvWMU5NElO
	 hwDLo1ix3xwMWDUo88nOVCbLX7R26ghhW1C+UZVtVif6KnY0YNcG+PmvRIuPpM1tBGtE3
	 QJQo1uh7EiTI5cGr0Cl7m8e0wyCmmDrEJKFHd4/STjkog4Xv6D23UbwM8hNREH91Lag==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b="TCkrC/BE";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790799324;
	bh=BUICAzswUrX8vt1uNGRhY2WEqYMZSe2D2vVWQXBHMW8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RvDHGNzTYM6ZsnCAsooC6FCzEg7PcFOlT8gBFNNWEzDSIO0Fqe/mDOPwI5F7g0iEg
	 cOcNTFYWeI9NpVTuk5428XuUpINdT+gXITIW91miB4CgseSO57P01XxMYFgz4xMhaH
	 YcSYDUd8DGY/mj/yEN+tVeduWAFtM4QUxdO+2owPI7SuhJ7PAGhL12AditCrdzxpl8
	 NUZtQhLFU9w38tTd1/aw5bOMy5htV1tPUMiejoyst56m2OUCSlGbWde2z53r6eFbWm
	 rUESMcVzI/QRnYhvbapApJ2TjTvvRURzFkWrm40brg1j2370fJbbYqx3IQ+9FCzc1f
	 SI1/U4xPri7qg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7FF5C40B38;
	Wed, 30 Sep 2026 20:15:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 23A653AC
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 20:15:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1455F40B30
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 20:15:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ofcnv4VfVbqX for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 20:15:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6E07140B26
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790799314;
 b=NAxB7pDxliacqMAuiWvLOHh9yJAPjP8lGILE1bwOgdfkpZeRK+1hDI15D2p05188O637
 5KlmPgDRsuHoOW+W03m0dotgjRyibXu6tAeo3c+efvlErueiUf+oN0dInt/aZwfc0iLV6
 w82ZN3PBO3wy0hP8lH9KvOTgDg+6tlom2w1PL2slKaSbuZoiCxj3yI4jMVAriWFDmpwmg
 e3jwSzNB3wjccZ4FYWctFNUo0OFF691aSKNX/3rA4W1RtwzEo9X01w2SYXC3bt+XVxZbH
 NTtN24pOJn3jJ5083e/FvXouoZxv+YuFMimWihXfcUGrB8jdPoetvee7f53FvgrNIwg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790799314;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=BUICAzswUrX8vt1uNGRhY2WEqYMZSe2D2vVWQXBHMW8=;
 b=rbCZ7Ksq42AQLjPOsIqBjNSBuA09fE1DzzuYwByxDvyfBEqcbaqHT8qyHcgLSbKPNH87
 6MYyldjq8/TO/0nHKyWPrpZz4+l+Az6X8/956zOgdVeFpeoYM5gq/5RTPk9ByFJHaE/9E
 Vvnd32hkm1Z55ry8RNoNSqb/Sbca3VuPnBXXXCW5lqREi8l3XWRevojKHgdbly3EDrcbW
 xsWrVxyow1grJ4e3qsMET7SCsKDZTHZPqe5Fq1jOIjDCPrUhyXuOs4Dd+uGZjcajLbIRJ
 MXX+cKuFk5RTHQetppcE6d3ZesF05eBOlw8Qmo80S6EoEmhOKTiH24z3kmgp4aFnpcg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="TCkrC/BE"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2a; helo=mail-oo2-x2a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=TCkrC/BE
Received: from mail-oo2-x2a.google.com (mail-oo2-x2a.google.com
 [IPv6:2607:f8b0:4864:31::2a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6E07140B26
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 20:15:13 +0000 (UTC)
Received: by mail-oo2-x2a.google.com with SMTP id
 46e09a7af769-81be5042c56so3075137a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 13:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790799313; x=1791404113;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BUICAzswUrX8vt1uNGRhY2WEqYMZSe2D2vVWQXBHMW8=;
 b=TCkrC/BE6iub7vOqhQQzcPsCLMIlbCiicUORhrc9QiPxglAWNXl3qYAamRpNAlc58K
 vNcdi3Tlm4cX+afA+qD6nHtU4ol/7tngmKqm96I5a9MES+f1LxUqtdxYilABEQ5GEwnU
 x8KX3FISJ/jX2ihwEQHa+EMkuflCBLyKfC12E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790799313; x=1791404113;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BUICAzswUrX8vt1uNGRhY2WEqYMZSe2D2vVWQXBHMW8=;
 b=utMkB/nwO8UgRLzc9U1T3wyJX8DO7vpv+TCTuTu9/DrBg+2P3PYJhHMi5CFThCWCtR
 +xaqG/x/Ys6v0n7+kUJ0ed8CzGoFfx6DGTApZhsBWjF0mSUha5AWXYy9sq5lgKDAoTC2
 LUCuguLkgVVAy3ac97IDXeDn3U56rDajer7Aw0c24zpbKbu7DeJjPw6ncvv2dxfWhu6S
 XNWa1IwCeLWkg8do/bQBdYfLBce7xnXDH422JjhkvKNrBHJeGLExxm/xoTSW+nWvTAaz
 yS0AGgFgEFwHpNIObFsvHOsjDGgP1yokEhfc7X9yP22KzxCBGSEsVAFPgYTYHm3b18Qs
 5DUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxG4lOVIwoUKzH/6EXNSLzntH7cwvNc8WVN0Rb0W3Lfa6cwb91G4NMHhQ18oUYUgtXybSGwJug=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kQsPEIN2WKz0wuprDXpml6OMknTJmyIFSEzSAmuaHTUMpGO3W5
 Yg8r92yZsKSvduejO9VQx0NMxAllW1Gm409wu4TduwFcBLEB0Xhbr4LeE/PucoyTpy4c7y8Ra+B
 ERuhNKwkEG8vF
X-Gm-Gg: AYBFou0oLNUuqADn8iTVGhNKPMioZFNO34BOlUXkZCTZctbACJG4HY+Xa1Ngj8WovID
 ASGkTbXtEEi+Kq2kA6aogDp9KtiN2iYHjsnWqoZ8z5yqp65cWzTDfzqYMOO2svV3wRA2bIEgcHw
 x+3fsulWR1v1cxz5tEqE3wrFG3JxiVCmyUhK2n/6Bp3RdXgQ2nLKsQddNU66AQWvHFgwJcIFljF
 d8BmnkB5E99iL7Im1IihjLshskDlxNxkkyCRgr07EpgGPo0NiVFLrCkOoxLSh1j6b+5qhz3MPUd
 PaCOHgT6rBEsQ25q9unJ4eXeBBgsp66cjFcPWY4wrl7xeiW6r8Ua2X0SE5xnKAJ5KUeIMBymxuk
 l++wjx+V9sAtrSVLVqtml1N5h+BC6/xkpFLIc5vbrIJP7IElfhrQSmHIpzA4oNTcP4x0MO5Xe3N
 SWUKBHeZInTUAbnQLRbMeqM9C8wXXVT194p1dOxahHl0JoWZSpf3hcKDZvopw+c83bkxQfZzxpB
 rGfRfB9bPL2KNcq5yPRg51zsY43+pSVmQmM7XD5TZaRpfH692qmVH+jaFKZ8GqodARYb9PlP500
 ZoW1Z/7XSlFVgTiJwbM=
X-Received: by 2002:a05:6830:82e7:b0:7fa:ab72:9df9 with SMTP id
 46e09a7af769-8204d11f883mr2860405a34.17.1790799312849; 
 Wed, 30 Sep 2026 13:15:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-821281a797dsm821896a34.3.2026.09.30.13.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 13:15:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Cc: =?utf-8?q?Alvaro_Fernando_Garc=C3=ADa?= <alvarofernandogarcia@gmail.com>, 
 Kever Yang <kever.yang@rock-chips.com>, u-boot@ew.tq-group.com, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20260907100230.29136-1-nora.schiffer@ew.tq-group.com>
References: <20260907100230.29136-1-nora.schiffer@ew.tq-group.com>
Subject: Re: [PATCH] video: pwm_backlight: avoid integer overflow in duty
 cycle calculation (again)
Message-Id: <179079931213.506059.15645259877093076114.b4-ty@konsulko.com>
Date: Wed, 30 Sep 2026 14:15:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 07 Sep 2026 12:02:30 +0200, Nora Schiffer wrote:

> When the variable `width` was introduced, the cast to u64 was dropped,
> meaning that the multiplication would be done on 32bit numbers again, only
> converting to u64 after the value had already overflowed. Reintroduce
> the fix done in commit 533ad9dcda38 ("video: backlight: pwm: avoid integer
> overflow in duty cycle calculation").
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] video: pwm_backlight: avoid integer overflow in duty cycle calculation (again)
      commit: 989ccb5325b5ee9d949cc1801b2a3101d0d2451b
-- 
Tom


