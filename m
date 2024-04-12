Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE6DC4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 22:00:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D41688227;
	Fri, 12 Apr 2024 23:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U+KisBGt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80ED48821D; Fri, 12 Apr 2024 23:59:37 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ACCA881F8
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 23:59:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e4f341330fso13317865ad.0
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 14:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712959173; x=1713563973; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nlwKeRsDy+kfJhv9p2vAF581ljJYvnxPui/T5R0IvCM=;
 b=U+KisBGt2nRLyu98FUUhw2eClkWRQg8sgN1HKYfZnJtJCiP+zXHW5GXhUOEzAv15W+
 xxhHtRJ1db48HVLMegW2oyFLDSmGDJ89yDTMqWCnKNb355VfubOcAZLd9NN8mWOG3g59
 XWzc9yow9WrQZ70pjWFe8NuLJkgAHAnMZ4C0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712959173; x=1713563973;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nlwKeRsDy+kfJhv9p2vAF581ljJYvnxPui/T5R0IvCM=;
 b=YqadmBHJdP06qq8MBArU4AIu0YNnQW2xh1luNOhNmijnCAJt+NbLV2Z11pmSgp+IDS
 MjIZ2ezSVwbv/TfF4vD8AI4e0w1wPVWFgNFILS2FPlXOti203/olP9VskYWXFxy0yavE
 J4mtK1wAKnmNyhDIh5lGtOvp+6LgjXeVBOdFtKysXSysOHPj6COQ152VpJYmXGv1eVCa
 C1T2pUeQHTtrQfsU+FNxZR2EoRY5OUR2AOE+ndH8/aOUPeal9D02IgKgFnSYyoBy4UNO
 UXw2ZOh92TcgV8HNjC78uJ5YbA8SiEkVbj+wGFn4cDIkLOrdKUXbXGqw3z3JpMP5jD35
 ZH6w==
X-Gm-Message-State: AOJu0Ywu0/5GYjS/MSzAEUYeq9oy1+UoxWBwMIIr2wxkLgJu2xsZthqA
 qmarfwB8cs4ZuV/OOwmqX/B1oayCiOmlvr6B/HUahzCeH/zdikMXBk2AZsCBG+oNhQ/3YwrXPv2
 5bFtTrw==
X-Google-Smtp-Source: AGHT+IGFU+cKV1pVnr0EZP0dxII9ha0msYqjg3vZHd526aCIhbHFvB1iaEQiAHJt1N+BnoReuyhGVQ==
X-Received: by 2002:a17:902:cecb:b0:1e4:2451:c2b5 with SMTP id
 d11-20020a170902cecb00b001e42451c2b5mr4469844plg.13.1712959173514; 
 Fri, 12 Apr 2024 14:59:33 -0700 (PDT)
Received: from [127.0.1.1] ([2806:102e:18:245e:b648:93e1:5c61:68a3])
 by smtp.gmail.com with ESMTPSA id
 kw7-20020a170902f90700b001e45240eca4sm3472958plb.196.2024.04.12.14.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 14:59:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, joe.hershberger@ni.com, 
 rfried.dev@gmail.com, Jim Liu <jim.t90615@gmail.com>
Cc: u-boot@lists.denx.de, Parvathi Bhogaraju <pbhogaraju@microsoft.com>
In-Reply-To: <20240408084902.2848964-1-JJLIU0@nuvoton.com>
References: <20240408084902.2848964-1-JJLIU0@nuvoton.com>
Subject: Re: [PATCH v1] net: designware: Invalidate RX buffer cache before
 freeing the DMA descriptor
Message-Id: <171295917233.1044279.9785370721236618454.b4-ty@konsulko.com>
Date: Fri, 12 Apr 2024 15:59:32 -0600
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

On Mon, 08 Apr 2024 16:49:02 +0800, Jim Liu wrote:

> In IPv6 context, the ICMP and UDP checksum byte in the RX packet
> is initially set to 0, recaclculated, and then re-inserted.
> This process can result in a dirty cache line. To prevent issues,
> it is essential to invalidate cache for the RX buffer before freeing
> the descriptor for next DMA transfer.
> This ensure that the dirty cache line doesn't inadvertently written back
> due to cache eviction, there by corrupting the RX buffer
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


