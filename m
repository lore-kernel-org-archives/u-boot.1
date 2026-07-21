Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0B1C44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 11:49:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9EFBA6062C;
	Tue, 21 Jul 2026 11:49:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iZpTZAdLcc4X; Tue, 21 Jul 2026 11:49:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BE5816072B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784634556;
	bh=WCdof6QhLF/aWqK3VExZcIRPNERozUERYTID+lMexVA=;
	h=To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=vST8alIAWJah5CGJQWZpHpy2kV4bXMHuA25YZiPzQbXTdo5LkQ5gC3vZMEVBLRtSA
	 a3oJd+PuwUXe/LkOChTDCeBq4gQWeF+kVy7lv7A1m1ROQiFPMNK3O7jFg58x7wZd7x
	 IxXcDz1MspZzgF4O2JysV4MDnMysZ9QLe0Q2Dal9IN7IHibWqhgEAouxQjTN2Xg26v
	 kpSebSJ0ZLoQEv2filtgY9gCFieNlIctbEucjmfOKy4bZrzP4Ja5GcA9vHcZZITX3V
	 YIx9WhYMmfJv5dO07ZeIb21c6GRVrAHJ6CGNyg7Tw6GhCajzm4Vf8LU6Gsiw/9S+NU
	 2FV8GfeCvJWzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE5816072B;
	Tue, 21 Jul 2026 11:49:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 53794EB
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 11:49:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4516540902
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 11:49:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NU1DbTrD3WP6 for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 11:49:14 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=neil.armstrong@linaro.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CC267407DF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CC267407DF
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CC267407DF
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 11:49:13 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1357084659; Tue, 21 Jul 2026 13:49:10 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4B85803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 13:49:07 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47f7027ca11so1808725f8f.3
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 04:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784634547; x=1785239347;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WCdof6QhLF/aWqK3VExZcIRPNERozUERYTID+lMexVA=;
 b=QEQMw0Qdl6M0vS+74jIzpoE+DhsDQFDKr+H5CaluYsC7gpYrrggTMBbiBeGQBin47m
 jk41JuhilF/RC47bsBnOkgHx4AMXl66N72fJJ+1LTX4rONNK7I/Z8Mo/kymmu6ji3bAA
 nfmqodTC7521EYAQrbRhzzy1MbnHY09lA9YLLgGXpDdZnDI5VtwbodhLXVMKpkPyavE1
 fF9FwjmtDnG8S3CH0j/nb8IKY9JHuRx+PZr+GET1Co8ZVu5/R5VC2DlZfKeaDA+QLINI
 9M0p+vtC8MMr1L5MfQh4xEj4MHp9O03KSbV1To87FjFn0OKWGGEWYyX8ZUNX9Xc0F0Gl
 SYSg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6oCadV8u35qPAhNWksyqy+o0Memh7B3TMLa6t1YQuCRSQD6MhDhf5Zz/rJE9HNAVqlRtV/Sw=@lists.denx.de
X-Gm-Message-State: AOJu0YwSEOfv02L/2K6DNE25BP99t0Vtt8a88+RoVpp3+R54t4SGpXXC
 voQcHkX/CYz+Txi1MF0vU6J7q9zonmP9b91OPxDuy9kxoy5F96pmmkoDuGbrGFg4FWg=
X-Gm-Gg: AR+sD13lLGv4owXTE/BGz5F9H79tqJ5cvc+QD+1QeQytPwLrOl4kXW1QeFDfUYQ6A0+
 5qacGKsBvzfD0DaLtTdvdvp/QF2XBs6lyxvHYXSM9TRiogNx8Ur0cgAuAX297aU6qkJc5x82Dfp
 AC4jzIO++lC4Injzr5WXqvjDXo8XA6tGIeYBdRYuvWOEWE6oNUQH1OMN3dYKYz2c9NgrPD41fiV
 hqauQSX5hatuCZGoScpG24+t/FCYI0Vwvp/FU2M7qlr2r5KIEZkdIiHOQxWK09OvXjvCQXy0D3f
 prXw9p1Oe7cMYr+KqSF+iJiASeBrnaAyp4s6NAImQp4l7Qrk41sahB/mwP3qSk684zDecKMuU32
 9T4j31UZ6VxcP/HYpSFUSCQLHaeZ9aPgP87Qa3Lh0+SWBUHggU6uvOPUFd1cLx6eJcMZL3lJrng
 5/aqpV+UUVynWOKVBZ+eY6tOoC/znzULzTQw==
X-Received: by 2002:a05:6000:1842:b0:47f:7067:395b with SMTP id
 ffacd0b85a97d-47f706739camr15283480f8f.10.1784634546482; 
 Tue, 21 Jul 2026 04:49:06 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ee0086sm41400199f8f.30.2026.07.21.04.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 04:49:06 -0700 (PDT)
To: Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>, duwe@lst.de
Cc: Tom Rini <trini@konsulko.com>, Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Martin Schwan <m.schwan@phytec.de>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Prashant Kamble <prashant.kamble223@gmail.com>, 
 Denis Mukhin <dmukhin@ford.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 u-boot@lists.denx.de
In-Reply-To: <20260706172028.C148E68BEB@verein.lst.de>
References: <20260706172028.C148E68BEB@verein.lst.de>
Subject: Re: (subset) [PATCH v2 0/4] Fix NVMe, not only on Raspberry Pi 5
Message-Id: <178463454564.3673459.9159641790960538939.b4-ty@b4>
Date: Tue, 21 Jul 2026 13:49:05 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784634547; x=1785239347; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WCdof6QhLF/aWqK3VExZcIRPNERozUERYTID+lMexVA=;
 b=jYGQFNfqEI/JavU5vivCPukuCdlaEwWPXgWSIS5WiTEi80T3BujdUhKly/9A/4Y9//
 vhvWuQUT6b9BH9ODddoX8f5nPQv6megM3A2ho1jaZ0w4IJKED0zncUl1xB8jU1Rv89uK
 UIkrJ6XWTseAGhHs+JULKXSscAcC6ExUQIW2VdQgVY6ByqCLBkDqnndu7eQjkbX6dORa
 l2NDJb4N+ShXKDHjOSHh8oIFgzNqXDGqJHJ6GydlC+son7bSfj92mgNvsrD0oVnLLLPu
 yNBOKlXReg353xqMJX8JjiW02sJ5oP5FPnum2UGcdUelmB+DzUUK69bRlVhRoIKWpADZ
 O5wg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=jYGQFNfq
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=neil.armstrong@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="jYGQFNfq"; 
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
From: Neil Armstrong via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi,

On Mon, 06 Jul 2026 19:20:28 +0200, duwe@lst.de wrote:
> Here's the rework of the central fix as requested by Neil, the DMA
> addresses as required by the NVMe device are no longer calculated
> "last minute" before going into the registers or into the memory
> locations, but early, as they occur.  Hopefully talking variable names
> and member names are used to store the values when they are needed at
> a later point.
> 
> [...]

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/neil.armstrong/u-boot-nvme (u-boot-nvme-next)

[3/4] nvme: Fix missing address translation for PCIe inbound access
      https://git.u-boot-project.org/u-boot/custodians/neil.armstrong/u-boot-nvme/-/commit/09b1c0f98c0b0fe0291e6dac49d0013e782b438d

-- 
Neil

