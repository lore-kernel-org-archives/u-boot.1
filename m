Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C55EC0218F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 17:26:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7181682836;
	Fri, 31 Jan 2025 18:26:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ejt7Z+jw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F09F682163; Fri, 31 Jan 2025 18:26:28 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86A48826C2
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 18:26:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7c0155af484so90730685a.0
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 09:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738344385; x=1738949185; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dMQoXgbe3efjG7ScyxWYvOy4VcaEKYcq6utRtt1Rrw0=;
 b=Ejt7Z+jwLbzZDM3qo/dNXGjGlR0bzhO0ksPGZpfzpGlFhI+eqs6uW4DVvq+GK3GRE4
 7F3tbNOIpzOcfo7cIUs0p0Qf2nWRjCGgTyPxri/SKGkKTZtUmLg8WGZWWntDyFQD8est
 nXpfH/F8OyG2oIjwa0SpsOUpNElNdNAGGbi7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738344385; x=1738949185;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dMQoXgbe3efjG7ScyxWYvOy4VcaEKYcq6utRtt1Rrw0=;
 b=N1Lg3atT6xeTUXYzsRWRf4Xxjpk6tZcB+NHvuyC0bzAdCvK8RJB+iHJ4TURGYOddfl
 UoHuvqO2zTeRKQr/aSMO1cNse+a40l33J4Ltn1yBf8YAxp2p7ynGZkKRq8fI0wbhRN6Z
 0J3GaUDpiPCZEos/BwNzJd4JMqVx7JtLbaSC7sc10ioksL7yc02F5risOpi2sy59T3ou
 jzbea1NJDqwgiAduLrNSJhnKzesiH/hcSbpz3IIGhYELP6qpLKyjPzR24GUqKHtAO757
 /8Wg7AwF+frvT85HbeYSBKhXpGdPFdHDMabllFPjKHyXO7yKeVyfvO+3fUN27R/sn/Lq
 xLHA==
X-Gm-Message-State: AOJu0YwmiRHp36v48yubPTRyS9id0pyZBiJJZPxKSOulEPNHap2HsvFC
 ut2d5CGFo3RkZxGoTdk3OlsIqn0rIBjOGzpmED4DiG9sar/7KOEjGbbAaJ9/gmarWZnf/Z+Nrid
 l
X-Gm-Gg: ASbGncvVIQx28zyLq40vi1g85sd+dHFDt72oxGV5p2NU7w+KvxKY6eO1I2eITe/fszf
 sZkbkZbXPQQWFB4I9ZcDry25vFFv4ermA09QYxL4GyGbcVrKLFIcyrYxVh7pZJ5HLogxZoM7tvg
 5OFD9NBfyZ1NpVSsOoz5bNFlpWmm7xdYJyHX3AnP43mzkSZDBpuv01p08aVrJehacfnkCPiCB1z
 P35vHl43K3JBqS1ezdbiRrun1ANClLDscgR6+FmEBG5L8xOepf33kWXhWTRtkFMT2wSx/DfJ1H6
 oF6y7viOCMxSIg==
X-Google-Smtp-Source: AGHT+IEs8XUwJz3nHAyQcu7/lyiOGvlJc0BGkRAA/2vZNPTZQmKvZWIKrAMTYXPyxcMUlEjjJzKRUw==
X-Received: by 2002:a05:620a:d95:b0:7b6:dc74:82b1 with SMTP id
 af79cd13be357-7bffccc9f6emr1990928685a.7.1738344385436; 
 Fri, 31 Jan 2025 09:26:25 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a8d9757sm213391585a.63.2025.01.31.09.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 09:26:25 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <a8e492b4-b2fc-4432-8ce9-669a8a70d1ed@foss.st.com>
References: <a8e492b4-b2fc-4432-8ce9-669a8a70d1ed@foss.st.com>
Subject: Re: [PULL] Pull request for u-boot master / v2025.04 =
 u-boot-stm32-20250131
Message-Id: <173834438459.3013010.7389437348209085278.b4-ty@konsulko.com>
Date: Fri, 31 Jan 2025 11:26:24 -0600
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

On Fri, 31 Jan 2025 11:57:04 +0100, Patrice CHOTARD wrote:

> Please pull the STM32 related patches for u-boot/master, v2025.04 = u-boot-stm32-20250131
> 
> CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/24410
> 
> The following changes since commit a517796cfa5d8f4ca2f0c11c78c24a08a102c047:
> 
>   Prepare v2025.04-rc1 (2025-01-27 16:38:46 -0600)
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


