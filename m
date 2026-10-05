Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E6FCA5FF5
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 21:54:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7694F60666;
	Mon,  5 Oct 2026 21:54:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8LQyEUZ3siXF; Mon,  5 Oct 2026 21:54:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6DF5960767
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791237250;
	b=e2EeeMujSnMZREj0Jkdv0oY3kTqWoPdUGiFo39nR9PRtfe6FYCv6b+YLyCUBxEZTQ1Lt
	 jjTrgDkJAlnPJO6JFeVsaUfUV8xkTT3okYgRXHHKOkHREvPw6VHS0mFlDb7FjVy+hvI9z
	 gb1ExTO/M3ykJD0po2a4vtLJOUcvk8bBz9SOtw2I5XP027Ch+yvR5obRX72X6jhUuUEnG
	 lMVLeniyBLoU67CGFFTLaiwxpeBNYNBWB7L7PkoPbZ3IWAW5e5b46By27qCozqwFQmKpl
	 828QYraXHfHU45SmB/kmkiq2Ac++KTpknQ3JofNpAHBzf7xNDBjIEKCoRJWGPdyhz6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791237250;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=u7AQufQ8v4VYC+jkkA8SbG1xGvSLNYCrwMXinAOJHk0=;
	b=WFi54HaTqdSpvTyMA9a8yHl96cmJeIBRLaW1cAmreh+MGP5TJ1OLr43yBsgQTHeZosDs
	 MgF4Mt8fSg4FqBCeUhc6el4dQsLsHtZb4xHCtab+ORge1HQ+uS75p5EwFdvfoLEzg39s0
	 eAWar65gMb+ihX+OrkArn8wRUXxIeV2X/C7BZTWXOVQXsgaP4eLG/rinSsLc4AnQFZj5z
	 K3OMZhRFJBVOsf6CvwW5nRpwBjxC3YXykedo37zjNDF+CTAi1n19b7VWmew7OHoyOvV+F
	 t4hG2zwaUgwDKfrxBprx5oiKf1yQA3eXundEDD3T3Y8jhyGL0NtoHwtQ3dsQqEUHxsw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791237250;
	bh=u7AQufQ8v4VYC+jkkA8SbG1xGvSLNYCrwMXinAOJHk0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=emOYJRCEuyA4RXe+rq+IVx7AMsirV2X9C0qK0hjeo7QiMMGrbhoatrwytFzmPopdh
	 iiY5xeM5u8/PeJEH4+q1ed4Wj61Nu0orJLU6n6RfeXwiHKQxWG48S7++C3feqbJ6XL
	 K1kUcRsel31+65gVsGSUshS0C9THIjoRTz71CO1aOcwfwNnE5c3lC5klZRtRDXQ8Wo
	 f5A1kB7aaI7n3gOxIVlyleCtGD6l0TQfPvz23QXBC25WouyYZNQwbYex+dujef5ex+
	 FOFpvkT2SPVB6P5phO0eOIR2Y4oKC1cBYm85Fn7rXMB0KXuTa97srMBQxMxu2WNj8B
	 llMtx/a6TZEqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6DF5960767;
	Mon,  5 Oct 2026 21:54:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 785C72E0
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 21:35:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 75CC0808BB
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 21:35:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fnIK1IOyfujF for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 21:35:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CCF85808AE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::30"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791236157;
 b=MH7ICXcp+IZUAexC8y7DuyayC5SYQPkLmxoBiai8Ab/4pO/YErJIOjwoCyGFjkOGmJmX
 B0qOs4L6rNALwe09MrwsOMNbdT+0pLUjvVJ6ut8i0AaJEYOcYhKeIeZ6JmTxXS1Ltlhu1
 OPE3v5jQV4G2bOteFeNohljsxFmiiWVoIBf//xykJWzozaMXV6O6igqwZYiCQwjPw/9Jd
 BI6MB8aYfwnUqfJAFpWKocoS67X/1I2HblL6O3CJHzZt0W5U48yII68pnjIHnKeX0G4D5
 mOva8i13mvatgyArOf3xLyAbaFNST5aUn08ryeO6ug5grxjZS0/ZReciHMgBd1UP/hQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791236157;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=u7AQufQ8v4VYC+jkkA8SbG1xGvSLNYCrwMXinAOJHk0=;
 b=TdF/tShCTwbyHAn7BhcF5uXJUTjWKaNaatmJf08x02/J9yKOZMWXjiA5Stor4psuBNoa
 A4bc560vY23tSpeLWLaTHKW8lKUihqpVdmzWz61wbjFCCT7X/PlD6zQ//pu22TRclyd45
 uo6+ANAYpmybpA2UVMUvRGXPuHNZM3JfkGnVis7Ah3Jzaq9hUrQiDAk8++wesgpf7yFIx
 0ycOKnIF3ed3bM7NbkNnXdv0VRVXDijbUyU1V/iTAaPDAbWAs4G/GQkq/8iceV0Hex8fL
 f4t3j5Fop+zYCNxmh66d2S70gwcNOkbIeza+BzxFtOZTOIK1s+T8gmQPZ6b2VsxtQgQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=PFbtJ7Zc; 
 arc=none smtp.remote-ip="2001:4860:4864:20::30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::30; helo=mail-oa1-x30.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=PFbtJ7Zc
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CCF85808AE
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 21:35:56 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-49dfaa16190so175615fac.1
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 14:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791236155; x=1791840955;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u7AQufQ8v4VYC+jkkA8SbG1xGvSLNYCrwMXinAOJHk0=;
 b=PFbtJ7Zc1HwCu6kVzPQVaU3Ib/wm+7SnmQLlkjuC0DfLUiJdmgyh7G6f5P7lKlwCgQ
 Pc7uGKAF9CU8XzBR6ybscXKuNbGW1pAa3z0uflq2SzUoa582toDO4FaTmCCQ+t6vE50k
 qyclevKEYPNaEZaDX4p88vlfvHgraQAVBOnJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791236155; x=1791840955;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u7AQufQ8v4VYC+jkkA8SbG1xGvSLNYCrwMXinAOJHk0=;
 b=gpNnTmsx5YFqi/JeDTswiVZ7al8gYDT5HEn89obDhJdZplE9F87RRzyM5IkUtlOnWi
 AQByVCqGtEuk+ROj14Gme6ZDYW1G7yF0ro5lfHHMhd4uc//ufAL1AFGfYxDYdlXNNHnm
 dUVL49kdgQ5/tbjFcU/d4vo08hHoGO52lyRDNxu7bbJo1RORCMlmpY6Dxib+rNJjBMRD
 ZCioqwJItTPZUpYvbq8qDWj5XbF4pjOSPnmP1cZ7LnZSIQEYDP4IZxvuwSHsTYBp7aHn
 Z7LK6hpSEjhi+t9/YNyLkUubCZ6iRjJK4DzwjgnOtKPkYp0pBii2rSUaGlEs5UeKn2o+
 EIow==
X-Gm-Message-State: AFuF++mrWikRC9YcURRk2nnLCOSYJvSkjaQ5hQ+EKI4SAR89nSF+E2iQ
 CD6BtYT+qNdc9kYMRdGECH0unnHTbfOHGgZGhcD2a0m6keIsAdXimWc5I3P+Gr3Pl/ReW3/py6q
 ZC1PFx4+o92/s
X-Gm-Gg: AYBFou2AkoRhCbiJ3/E6zc2jApBu/+81CPDoLr/zAu6oLVbYJIdXCg2PNMA2NXPbwLp
 v8pT+4PNhAevivgUNC980uAm9fMRYjBQvZ2ns8jH4VawrX0BwvF4A+KzDq3hYoFfKq//ti71EF8
 1T7Qwftoj7niQywKK9YIm899Ddtza8yCOOuWuLUkCIEBmKC7oR0kxhAY6hmhUUheM7CVL2HDPdb
 9/n9KruYcf5r6pc7fa9PRtoBoN1CMvMgZaHrjjNiIi22kGRhaHQpJH32e/li8iDEFZZJBH77yMB
 LB0lkjOYT7V0Y/UvkwfX8TY6T/E31JZgYnEWX5RJrHd8ZLUHIKhgGwIoVmkfBbhQXoDvkh46hUV
 n0Pcn3d1ElYVOjJQpLhswvWFjfENi966nBCA8x+eW1ZvfTvMZTiuCFjrCZk8VytL0v81lG/dYG9
 kt2qjqpJh+6Mm91iZNjF15fmVK3MFwsdpnNmd1IMvzZGA/qeFPK2AjwEYabNlGiVWp2x36dh1cr
 /0qkcdHf0vBoWJslTwoG0szntU3/8ICrZ1EgzvcM+hKp4bHdU1zxiH7j5nYZ69i84Hhqi39HN3X
 1UBwVdPe8AGiRPB3xQ==
X-Received: by 2002:a05:6808:158d:b0:4b2:8dbf:ffd with SMTP id
 5614622812f47-4faab598042mr680019b6e.1.1791236155584; 
 Mon, 05 Oct 2026 14:35:55 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4facac74b4fsm657289b6e.8.2026.10.05.14.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 14:35:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <stefan.roese@mailbox.org>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20261005115102.747237-1-stefan.roese@mailbox.org>
References: <20261005115102.747237-1-stefan.roese@mailbox.org>
Subject: Re: Please pull u-boot-marvell/next
Message-Id: <179123615499.1385963.6200483181015107299.b4-ty@konsulko.com>
Date: Mon, 05 Oct 2026 15:35:54 -0600
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

On Mon, 5 Oct 2026 13:50:57 +0200, Stefan Roese wrote:

> please pull the following marvell changes for the next branch:
> 
> - lmb: enable LMB_LIMIT_DMA_BELOW_RAM_TOP for ARCH_MVEBU (Bruno)
> - ddr: Fix the SPD EEPROM dependency for Armada XP (Pengpeng)
> - arm: mvebu: turris_omnia: Enable the `mmc reg` subcommand (Marek)
> - arm: mvebu: helios4_defconfig: enable the RTC (Igor)
> - arm: kirkwood: remove obsolete configs for Zyxel NSA325 board (Tony)
> - arm: mvebu: helios4_defconfig: enable device tree overlays (Igor)
> - MAINTAINERS: Add missing file entries for some boards (Tony)
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


