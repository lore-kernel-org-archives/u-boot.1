Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA347CCF2E5
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:24:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4BF680F27;
	Mon, 19 Oct 2026 13:24:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HUgYjthaCWyM; Mon, 19 Oct 2026 13:24:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E203580F82
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416245;
	b=a3hRqp/xpANvJqXLDntBjTHZRzvjBTZhJuOnHx9waah0784CXvJy6iUuAH4eeElvDWlU
	 EwYbP/efy32GwO1bMcKHJi71f2NK5KfOeeU71T6EYdSGofGg4hEtnj9fG368lapgdBoy8
	 XnEo1qlWOrqXv2AkeuA5ee+wLS8XfWIF7NbCPKJBOQTfNskBJy6CGK2qGOCW2Adici01z
	 o5MsNIt7FoYBReOQm9BnSufPP7Y98Tll1WIiM6kCSlTdkZP/w3eaAB8YZw/J5katyx8cs
	 sh0tVLv2eBBPcaCkhbOg58a2OWF2k2RAt7hoGhyRNJbqtCAVVwyd+xsuKfr8lZO5zUg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792416245;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=inJb18NIWHg0PbQd9U3Yjedp9VFXzRNz3LNJlrmplkc=;
	b=pClhzEkMSIA7zBprKRpDNfAhxVV6Jd24gXj2YrcfggKX7wMcLY+R1rfHA9zvaVal5Jtm
	 yY52DBi15ryooXIUlyhSHvWuT0HNwryVlfGWHfSgtuZqqQfCb20kxukAAcWqJKCAUPhKq
	 fMBdOgdjp8sY7KkoVg+jWIGAYMg9yDejs8Jj7VLeeKIHCRM5ifKF61qCmf0qmJFp1ucd8
	 0iwYIMV3k/hDe04LDTFoR1QPgrE0mkzQ24k65N/Cxggsc1zPX/92cbtxAQ+TL60oo1WUQ
	 llBwrCL7S9WEFHccspOuPL5bGILvcHi3EaDlhDVMNo1GZ8ulKJLmGqA1w5NVPHSg5FA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y0fL2OGy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792416245;
	bh=inJb18NIWHg0PbQd9U3Yjedp9VFXzRNz3LNJlrmplkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KJ/eYzh4izISJ00Uhw8Ifa2l77ywdDIkf+hLoenZ39dvCOHvrZgmlTwH2M8B/yetm
	 I5cDq2ZNAI1YUStrQ6Pw6bfe0tMYOWNStc2HOhRNGYMGQb3RBYAMDXMBnHc8q6TlpL
	 NGy/7jr0KCBJ961TFSDRSpMXKNYzznjOzg1+apYIUMPiEdKdGyTG2OagMp/N5dTzkp
	 9nmh55hHgLHnjrtOJOiCIVcAd4u6Z4sE/LokVLXJ1OE1G5LkbSJ4r1H98VXuSV9Pug
	 kn2HdCMXR6U3Ze/0kR2dZuBVtBU1sranxRRUYQjKPvEFsbOGcsiQ2aM8vpLqN99YzK
	 xxGzW3C29Gi3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E203580F82;
	Mon, 19 Oct 2026 13:24:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 29E271DE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:46:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1B63980F4F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:46:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xV5X_HHYEg2C for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:46:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 83A7680DC7
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792406816;
 b=ReLS89MC5BVByS1g+ijevjkxBfXwqsFCAkDhd1aguyhFh1fcWCaAtDujPIGK20Oyi9bM
 GnWNgotm46lPRzXUwEWNwUSWCiy0K5kr4M+hNcJ874PWNfzDld2/BRWF9ykZ8l0Mt/+Lc
 jFD6nkOEACOG7lKAxFnZAw/RAtifeXA8/VNnPKXNnSvNAKldN3BgdXLTDeZue6tazE089
 XELq3O9lwaVskeU/nJi0aITh/+4+oBgXcew95ST+xNm9m1hRullyxUvgdwlZWvX0xCbg2
 LNnXcxipMhmh2IoGxzYLvOTAZyARFnDFGE4otnoAUDe/Zcm19p7g89cEfRGOWbN63Vw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792406816;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=inJb18NIWHg0PbQd9U3Yjedp9VFXzRNz3LNJlrmplkc=;
 b=RUlLOkLvHDn52OPR6unuXjM9eYKSrKCTy96Q5sXD9KtkExPRhF03yHfnxnkuxHdvGCaS
 boV0XMgEu390Lvn7vIUFmqnMGPrRh6Dy6rhEumUl41WG3ONIsI6mwogw0Cdv08XYiyk/n
 F0lWaoewhleOAupF1zbCE0W/WuUxMmtoet3xO6p4reIgDJtbzdpZ6Pj1PuesDIMalKPfu
 b8qvsLhUx2e//IomiYr0dry5E5OCZoicAFUQ29o2xWm7us4A96eXVjghU22Ttxmwhzq6b
 HZesy+uKma0USIzdKk20RACcvjgCI8Ausy5SxJCzeh2/CmO5Rss+Fh14L6tJfSESCQQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Y0fL2OGy; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com;
 envelope-from=kelvmod@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Y0fL2OGy
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 83A7680DC7
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:46:56 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3acb11973c3so1795496a91.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 03:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792406815; x=1793011615;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=inJb18NIWHg0PbQd9U3Yjedp9VFXzRNz3LNJlrmplkc=;
 b=Y0fL2OGyCT55QR5CxT7+1BwZSjA4r+RgjZKMHO92OHkH6uYofLeL7hy4zqX98Hj1Nj
 GoQNhKWrPzWJ4TJoUk5IIioxYd5vRt4UEVKEZwonIgq2aEjfHkqqoRnwDAQYbtVWWNpt
 fTaSYnT9/BJZjp+PmNZqq34CyzPS5TNmx0nzMr+FZ7wLEO32Z92xOcc7j3Tz3t9UOzlE
 wiiP1vrDp8aKcpQfx9T1R6aO0X/vF0bng4wEluJ90/TAaImKKpBskh0UiIbXSoiNL4qs
 Rb/PLLHveD5WkzZCvtYo2Lmbww5/DjzTXBLWI5RDUOtH3o5RtbDsKCT1Gug10goT5da1
 /Uzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792406815; x=1793011615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=inJb18NIWHg0PbQd9U3Yjedp9VFXzRNz3LNJlrmplkc=;
 b=EnmUV3T8Xeu37Qot8ua/1hvoyNSydf2RE+YWM/qwZb2C3XNeG26O4Gqz63ujV+k6Ff
 zDMpOKQk0LASkEL8uW+9vECxVc/WqSoLznCyulFLehsiQIr2Y5eqq3vMCQwueuV+1+rz
 oe0N5HuWFg8KINUMB6nqMMZv0thGflgx50EZ5CDX9D8np0G17tiYRKxlETOqv8etu0W6
 kAoVEq+JVIWpyblWj9CxeTtD82VB+DDiYSyLaBjgwexH1zXmIXBQseaSYa6jkyENYktI
 JC9lh7b09xdbsDK4/6jTGtZgB8bI4ykZagcaKZgw9xhdhR2pXEjZ0cSFz3/ExzbPk55N
 dZwg==
X-Gm-Message-State: AFq9FYK26ANVEEbyuI4gIsQPstEmVhMYYN2lTeSXeeBa3STCs/7+YdDk
 SLQeawx5A7fC7iwF1XRrsNNZW9JxvxZrxMfFxuhmTfITPMqpYmwtjnJGoc2sR9qK
X-Gm-Gg: AYBFou0yd9mxd4bJMCR6TmZlNH7KsVCMC4G99W891JDyD4Tc+RuyULH4Yo2VPCjtkwE
 YgdeVnRXUNwuK2876LVqrgXvWJBDKNTHq1WZCr/9NujrkBvcdFEUY4BfLI7LOgogf7XubBywj80
 xWv+iW4ssqQcZr8zd4Go1v6p6r9GsovBgFQzwsQL+8aD8GrNiNg6EdJfuDluEEI1V+CaJKdMbBB
 lS8pBb299GIW+pa5bMeUT8wXphw9NVF5hnZIsJq9ZjYGM71Itte90AfVZvCFt4Ek+YXRInfVkHC
 koZNTHZw54YVOzp7ye4F9gqgDi2S+nVUY7I2GHpUQF/GXslvXw29qCwABv20P27auX+G0Irmh4T
 Kpn7DL3C28Xu7F1kjRvVdGZGmbkWvca0mSrJO504lUb82TWnOeYbF0C3gXF4qcaQZf39tC68txv
 4p2N5HVG52DWfbhjPEBoYdyurhIS5USpgzcc88VHbplgFjb/DZI8WJ/pn36eN/2jshe/GiRYmTt
 YsPXghEW/0hqqjE
X-Received: by 2002:a17:90b:5906:b0:3a4:a850:6982 with SMTP id
 98e67ed59e1d1-3aceebf6a69mr6616575a91.26.1792406815577; 
 Mon, 19 Oct 2026 03:46:55 -0700 (PDT)
Received: from frosty.lan (2403-580b-35b2-8--43b.ip6.aussiebb.net.
 [2403:580b:35b2:8::43b]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac94627250sm19973760a91.8.2026.10.19.03.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:46:55 -0700 (PDT)
From: Kel Modderman <kelvmod@gmail.com>
To: Dennis Gilmore <dennis@ausil.us>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <u-boot@0leil.net>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Alexey Charkov <alchark@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>, Kel Modderman <kelvmod@gmail.com>
Subject: Re: [PATCH v2 0/5] rockchip: Add Xunlong Orange Pi 5 Pro
Date: Mon, 19 Oct 2026 20:46:30 +1000
Message-ID: <20261019104630.2596905-1-kelvmod@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012020134.621305-1-dennis@ausil.us>
References: <20261012020134.621305-1-dennis@ausil.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Oct 2026 13:23:57 +0000
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

Hi Dennis,

Sorry, I missed that v2 was out - I'd been testing your v1 the whole
time. v2 works fine on my board, a 4GB Orange Pi 5 Pro with the YT6801
NIC and an NVMe in the M.2 slot.

I tested patches 1-5 on v2026.10 in both a LibreELEC and an OpenWrt
build, with rkbin DDR v1.19 and TF-A v2.15. v2 as posted boots from SD,
and with PREBOOT="pci enum;" added it boots as well, where v1 hung every
time. So the -u-boot.dtsi change fixes it. Linux then sees the NVMe and
the YT6801 at 1 Gbps.

Tested-by: Kel Modderman <kelvmod@gmail.com>

Thanks heaps,
Kel
