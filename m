Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364AFC02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 17:34:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8934B80790;
	Tue, 21 Jan 2025 18:34:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dsPdaTEW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6672F80283; Tue, 21 Jan 2025 18:34:17 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AF1380283
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 18:34:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b6fc3e9e4aso556543585a.2
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 09:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737480854; x=1738085654; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y9qjZnssU6PMK2MSBA437yRLXlTAGgognAtlk+ljadw=;
 b=dsPdaTEWk/f9fSwNVY2J4VOXdHmEfCasxP6+BMuQ5UcUVlLPAuGYaQaRTnAW2f8TYL
 lN1n4LAfouYutjhI+o/mXOO6r+sqpj/FQ9sDWABVWUmcR6mXDxjOiJ8UUu6NjlVUyugZ
 geiji9uB+7q3zUF+rRZDhdjbwph91mhpaQH5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737480854; x=1738085654;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y9qjZnssU6PMK2MSBA437yRLXlTAGgognAtlk+ljadw=;
 b=fa6XTHhBHymDanzG519P8vsngyvLpmP/frRvXHYLC7wTp4kmlB/5sU2nmrAlTA3Mf6
 /sUX7cAZ2bE9L1pX3rPK5cystq2A9OTUH7iLdhzJ+SWRFydzCHYeuYFb76V9MzqsTrRk
 5pY6/9SxkCpR0hSsC6Iq5sAGHWVTnp4cd1r9UlpfBb+0o6gyNN8Sld6vldPidnrTFqmD
 MBkR9FMhQIjSx3uumnrxAQeIZHTP0ZLw7mzMmmAbEWxq+KG2pi/mUJTTycbFcXRy9RWy
 rcXn61jRJB0q2CDXX0oW8Xs0VqbofOoPv8O48vh8MishBIDTuBYVLsirLqSR4hjDgyGw
 v+TA==
X-Gm-Message-State: AOJu0Yw+Ge2MIXjz1TI1w9BXal4Ynm3BnXeoR6BQVK7Az0nRBofGJcMW
 C8stSVQLH0p4tekJEEZ05XcZ9x8kf50PtoknQ9NGFzyl/gw6c/TeKkn+aYvSJ1c=
X-Gm-Gg: ASbGncubJ34rQrkS6sJgfY64G9ulQMyNKwTAcFSryVEzjzK/9XMU8GY6mPly4p1W5e2
 sINNyr4NizTFpb1nhKb8HKRlpsNejs9b/GF7uH0MujlQ8DOUnd3+pRgzNMSmZBH7zV39jpQC53D
 /aIHZEbAvYi0+2hD/xU2RiPbaKMqjAqP6Lbe+VOeMBuC1LHKT0vziB3QGPuDjvhk8rmAuoUNBzf
 kmuDclmwRS4Aum9ARiBPVZRWjkhMDK09XpQ0eXKnG8DzlxyKDs+kCYQapumFWpB9Q==
X-Google-Smtp-Source: AGHT+IF/VMOm7RBbeXBlKGjno3t/W/avLw/VHXYoWOfCOknuAHqYBDeYdnoWPI7NpzJFCfUanhNqMQ==
X-Received: by 2002:a05:620a:f0c:b0:7b6:f34b:cdd2 with SMTP id
 af79cd13be357-7be632898dfmr2870975085a.53.1737480854245; 
 Tue, 21 Jan 2025 09:34:14 -0800 (PST)
Received: from [127.0.1.1] ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be614746f7sm578462085a.9.2025.01.21.09.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 09:34:13 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Sjoerd Simons <sjoerd@collabora.com>, vigneshr@ti.com, 
 Jonathan Humphreys <j-humphreys@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20241220215334.372542-1-j-humphreys@ti.com>
References: <20241220215334.372542-1-j-humphreys@ti.com>
Subject: Re: [PATCH] configs: am62x_evm_*: Set DFU buffer size to 256k
Message-Id: <173748085285.2982616.5646367783646987160.b4-ty@konsulko.com>
Date: Tue, 21 Jan 2025 11:34:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Fri, 20 Dec 2024 15:53:34 -0600, Jonathan Humphreys wrote:

> OSPI flash writing was broken on am62x SKs as the OSPI flash device has a
> 256k sector size but was set to 20k. This breaks OSPI flash writes because
> the current implementation of the SF DFU backend requires that the DFU data
> buffer size be the same as the sector erase size, and the USB DFU config
> fragment (for both A53 and R5) reduced the size of the DFU data buffer,
> presumably so that it can fit into SPL's much smaller heap.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


