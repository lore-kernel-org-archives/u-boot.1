Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3160C04FFE
	for <u-boot@archiver.kernel.org>; Mon, 20 May 2024 15:56:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C9A0881D9;
	Mon, 20 May 2024 17:56:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n+hEqZF0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE598881CE; Mon, 20 May 2024 17:56:08 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43E8B88221
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 17:56:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3c9c41cdc4cso1154062b6e.2
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 08:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716220565; x=1716825365; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b1bza6lEu9dpZezuHHq6/mpg5ipmlELkQlOYbUdOVh0=;
 b=n+hEqZF02AEyZalWciY7oVGcs4eD9m2n+osBE5JZC8lmtCAIHHsKVqHt/xx4+YOGiz
 DY2/XLhEzDKLSjfgWtxMqCuuiy//U6B5IKnFLrmq8XWRvPG33nlV4xIxYoiqprrCr00A
 dHVYdQgh8q0DYyREyZwlcW8R2MstzAnk/asWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716220565; x=1716825365;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b1bza6lEu9dpZezuHHq6/mpg5ipmlELkQlOYbUdOVh0=;
 b=w+t/Jaf4neZNBxR8cnCUUOveiMnCPdzGcZAvmDxPmxOkRFuvh813FOSyyJzZpEt96k
 YiW/MACZqy3xIh3KbKQG+17/Rl0hFq5CVuHBHLk1g12b4cJom0ftvEv4PBMHG0NwgjaX
 08cyh2I63hFXWLAf8KiuzOwtUVWCvbHn39Yn3vZSZ/ulfLM82RfP9KoRYl1pXMnM7UW2
 pjFLqBICRrgp+ZLxinYnf4N6AClrp0+1eNU4gVgPcJW0lBfKmRyg+sef+TLLe/LHrE8v
 bw+Ca5twG9WGmulwxFOEo7PknOg7so3MKbs+J9CCPajcKQV2qXUsdixzgQa9mXvpF2pC
 jHpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhC7gjC65bwgWAcXemEybJ0g5T+YRlahBL9pvCflgsL9CUNCmfHoJ8A5P6FMts8k6aQb3asPXe9QU5Uuxp2/m+DawLeA==
X-Gm-Message-State: AOJu0YzTkTUS/42kxwHEkwfpnG5yA2wnATEHEueBE1Grfw9n4ghr7lCS
 dL5vkZX6N7o5sJ++HjLbtF0U8yPMGNF/nw4Xs9tNkFZ+u2RXurh5wXAIDAoe1So=
X-Google-Smtp-Source: AGHT+IFMxCdPKwZStnnGNRsA21iTL0Zyv8K8bYFSFVgfCxTHrGzc3e4fi47h1yB5TIFVRU1ub7BEwQ==
X-Received: by 2002:aca:1b16:0:b0:3c9:65b4:7c25 with SMTP id
 5614622812f47-3c997082618mr33451275b6e.31.1716220565097; 
 Mon, 20 May 2024 08:56:05 -0700 (PDT)
Received: from [127.0.1.1] ([189.178.170.52]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf2a3c8bsm1199332585a.70.2024.05.20.08.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 May 2024 08:56:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Nishanth Menon <nm@ti.com>, 
 Robert Nelson <robertcnelson@gmail.com>, Wadim Egorov <w.egorov@phytec.de>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Simon Glass <sjg@chromium.org>, Roger Quadros <rogerq@kernel.org>
Cc: srk@ti.com, s-vadapalli@ti.com, vigneshr@ti.com, r-gunasekaran@ti.com, 
 danishanwar@ti.com, u-boot@lists.denx.de
In-Reply-To: <20240513-for-2024-07-beagleplay-eth-v2-0-a9bf457c3bb8@kernel.org>
References: <20240513-for-2024-07-beagleplay-eth-v2-0-a9bf457c3bb8@kernel.org>
Subject: Re: [PATCH v2 0/3] arm: dts: am62-beagleplay: Fix Beagleplay Ethernet
Message-Id: <171622056331.1577131.5584438868595064237.b4-ty@konsulko.com>
Date: Mon, 20 May 2024 09:56:03 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Mon, 13 May 2024 15:13:53 +0300, Roger Quadros wrote:

> Sync AM62 device tree files with Linux v6.9 and
> add in the missing bits in -u-boot.dtsi to get CPSW
> Ethernet working.
> 
> CI testing
> https://github.com/u-boot/u-boot/pull/534
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


