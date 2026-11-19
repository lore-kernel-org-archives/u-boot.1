Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFFA606A326
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 22:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XwOiPVP+;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=nHoH2k2v
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7AD7540DE7;
	Thu, 19 Nov 2026 22:26:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HjWcpF9MIdje; Thu, 19 Nov 2026 22:26:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C49C940DE8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795127203;
	b=U+Gg9tr52iTIucO/9DKTzCp4XuarsdzSNUpGCLqbe6RL8wWSXhKdmclHzwTMhl3mdAST
	 7QPnH8gL9O+PysbEQgmAJ2MwTZ+7Vdnh2Kx7YdeHLUhNXQy8ypECARbcL/z71OalQLEL5
	 FIuJSRaWhkGcz1i+Tw2DyEJfUPQ1llKALAkgXP2ysSVxkjryqW068e545myzzYDJfS4XL
	 T0RXoPd+ehlvjveb0rBVALLfwQZC7FexkEsUCWhKsnItO/oF9mC3hOGMX/upVndHYOSeK
	 tdbTgZlrD4gekiR8x7EH+mBBUReJFQlMmLDd4UQ0gPbpy1IgDE9EidkJ+vWpiuSRHCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795127203;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ta51HKHmWVXANyXE8x+DF66dt4ToPz9tGst3isgZHwU=;
	b=VPeDyzrW/9UlIwJuQp32Py357a3l7K0nxGQT3Pu19v574/8XKGKlqpuWb7mB7hCijXIt
	 nW7gmTcHNk/ml3MtshdSknXw6SPbRKDNkrPoycns2fW3SIVZSUiowKKHngfBC3R/Beec0
	 q536JGtvhdjJh/8EBBBatPXIBGwNM4ah0zVene3wkkndFljEw2b/Db37K5NHVqv0zmkXo
	 UyXE+6E0lET+wxTZchl9E1D6zWXptBB8BY2BgadG/cdXX7ntUFWejnM8e5vGwycqOQq8A
	 2YAmTYlrTDTfpXC+BuDrcZagSl2Nx+nmo5iUSR2XA2dQxOu9NkovtBwhS2njib5L77w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795127202;
	bh=ta51HKHmWVXANyXE8x+DF66dt4ToPz9tGst3isgZHwU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XwOiPVP+XwbpW0Iw5hKNKOX5mBJ/Y35uNgNMGoeuGKOxEkOcalwmFLNupnLOdpAzN
	 Rsm5iHFGjSqhAHL7XthhDyucwlAY0tpEcckGZo/e8w+mOqXrCeypoVRkpquw8NXUbx
	 oCB44xbdoInbqWd05tabeEOtP4Oo62S7fpyJNNh+x0MzYtQ9M3UwA9cnr55c1WZ/KV
	 jikcupwOsCRn+rOmCEY1K8LnOHf/0T9yRTURIVIIMmVQl/7jmqB7zMSDT4e1UNlxeE
	 fvaZtPM3Rt6YnDT+yc0aKz18N75Z5dCKpDHDMw9e9xf6K/wk8L0RwhAmcrk09Fe1kJ
	 rzYrMdoePdicQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C49C940DE8;
	Thu, 19 Nov 2026 22:26:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 771C23A8
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 22:26:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5D7DF40185
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 22:26:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XXSXShr3VjVq for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 22:26:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A15C640079
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=nHoH2k2v
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A15C640079
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 22:26:40 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-862aca1ed4dso165504a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795127199; x=1795731999;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ta51HKHmWVXANyXE8x+DF66dt4ToPz9tGst3isgZHwU=;
 b=nHoH2k2vTCbLp5+GYyNHfjUJ/8u1ZbbTOxnpgHY+gKHuAEeeyBZmKqB19TtkGO4rIs
 3BodlNjaEC7RDdkrRoWtpF17xYEE8UCzGAZpDRVO4b24Y+STCU6nHLaRuNA51f8SVKjO
 4/lf12laRb1EnBJKbc2kUDZTjTl3hkyxydUuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795127199; x=1795731999;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ta51HKHmWVXANyXE8x+DF66dt4ToPz9tGst3isgZHwU=;
 b=JJJElwUdBeoG/Ts6mItww+XqKdMyH4m+X/Yn++PZyXrPZyYMudBqXY0LJbhMvoPyj0
 WNdmCeI2TAntY5QLT2diorbLl4SNzKdiQ/C2PtcH+stUghseVfrTQOA+Mk7djIBfVnZ0
 MrdL2BciBm4o2xZJhnEQ2/H9++vsPAMkbaGlMYJ8wy8dXvRdrhhxpTPsErVarpzkLPiF
 aZmV0FWXYzTs5uGHj5cqYpcHMPOsXo1Iw0Mh6noAvx42FspPQBlwYFPDJjVi9/5UWjoO
 VnPh9zi7aZC7jJm5VkFm+4+w+85NBcvd726PcbQg43PXtk7A5Qfk0s1qYYS+wJTKzg1Z
 1r6w==
X-Gm-Message-State: APuU4Z9ZuT0d4Il85frg3H9oUa+h1ICs7oWAOAug/2CNBFl4dpfxJiYB
 uSzu1f1ituS0ZaNZVCc38CuMneiqZdpmAuNvtaFZ9+5xOi0UWxNUxAr4/nSQ1xMwbk0=
X-Gm-Gg: AYBFou3v3m3JkdOPfoLlydD82lzAUe/S0k/kz/+HTuXoPMJH+8EvSsXCZqnGp6ih5gJ
 83P997eQwR2L1VvjFdUohhFBOgfkGEk6ZEpj12eR56FQDHUy3uD7aC61qVDkGh/NWPOLnaiDEhG
 6JzUk9mQe0NOQRJIgB4yRwok33IjrhXaJQqxFvog2/KLn8DyQ7DhTMFfnM1qMZUmm7lpEBDI/zH
 Kq2tNth6NHcYlV2q7YtVKnToZgPH1APMN9JmdPKeDfZ4mVo8pcBRXNzOg1HnR1wsv0fIOroVhrV
 7cFcYeq2ZecpoIY2i/vbfKLvGv2tSQ/1y5hvqCTdpjlhMiLUS4pO+ooyP27sgBBThNLnhqBr/9R
 tz3zz7RYsyHoXyYf8u2P2cSQyeyL/rJvzZEpoBM/GVJjL9wWWWT7GgD/FIp/UwVbFrG+rQWquAH
 DJuHmzGyT2Bnf+903CoYMFb+1+apRP6EQ9W9qjeyLRjAWVO61/9n6alhAtEDdlBFaCEc1ZATZ/o
 39j/cw5ms+O95xbjyxdKNVVEy2klz5NfP6V9BqTLz/8SSvaaALIFaAEjZpC7uxR2z3OxEDSkSA9
 R29Ygnrg/k4wz1/X1AQfslX97opfQqUtrP4J2+KHjJ6fk39Vt4I9pwOyATxf+bwWOwrwV7cy4Lf
 pBwG9JxiwHWoFcwRiBIG09YxCdQ7Rr2qcGabv9wEHO+fvjZYdA0Z+67TZToXPNXh+8KRnZW6y3O
 vhoeD+ySrbwtphgYrvLiCT1zz7K/vYBA==
X-Received: by 2002:a05:6830:448d:b0:85f:1601:d3 with SMTP id
 46e09a7af769-863157af868mr1475503a34.23.1795127199169; 
 Thu, 19 Nov 2026 14:26:39 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-863168c1bc5sm649069a34.6.2026.11.19.14.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 14:26:38 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: bmeng.cn@gmail.com, bin.meng@processmission.com, visitorckw@gmail.com, 
 sjg@chromium.org, xypron.glpk@gmx.de
In-Reply-To: <cover.1793836645.git.alan.tseng.cs@gmail.com>
References: <cover.1793836645.git.alan.tseng.cs@gmail.com>
Subject: Re: [PATCH v7 0/6] virtio: Add a virtio RTC driver
Message-Id: <179512719833.764313.15438192331238592276.b4-ty@b4>
Date: Thu, 19 Nov 2026 16:26:38 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 09 Nov 2026 07:34:00 +0800, Hung-Chun Tseng wrote:

> QEMU v11.1.0 added a virtio RTC device (virtio-rtc-pci and
> virtio-rtc-device), but U-Boot has no driver for it. This series adds
> one, so U-Boot can read the time from it through the RTC uclass.
> 
> Patch 1 adds the driver, patch 2 updates the virtio documentation and
> patch 3 adds a MAINTAINERS entry. Patch 4 lets sandbox tests answer
> virtqueue requests as the device would, which patch 5 uses to test the
> driver. Patch 6 documents how to reach the virtio RTC.
> 
> [...]

Applied to u-boot/next, thanks!

[1/6] virtio: rtc: Add virtio RTC driver
      commit: eb36d1397def8d4dd836fe580e965a960d4405ee
[2/6] doc: virtio: List the supported device types
      commit: adbf9f718db837ceb55e6c44cc42681e814e3f78
[3/6] MAINTAINERS: Add entry for virtio RTC
      commit: ea9d1b6610200d38943a090f697b5ec33994b7b3
[4/6] virtio: sandbox: Let tests emulate the device side of a virtqueue
      commit: 2afa361ec6fd87d74b11cb57ee43ff9e9da8f2da
[5/6] test: dm: Add tests for the virtio RTC driver
      commit: 9e4fda399ec31c7d4586242e5d6dc73fb6258165
[6/6] doc: virtio: Explain how to reach the virtio RTC
      commit: 0115e0d56be982ab9bde4b3ea582908e12ff8c69
-- 
Tom


