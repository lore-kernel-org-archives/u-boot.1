Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E86FC35FF1
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 22:45:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8FC68197F;
	Thu, 13 Mar 2025 23:44:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FYJBY4BG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92AEB80756; Thu, 13 Mar 2025 23:44:26 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C6E581A02
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 23:44:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7c55500d08cso136465085a.0
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 15:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741905863; x=1742510663; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vIWFyoGC5tunrTP3xMGUPD2eNi2llpAhXLhwaR1qh/w=;
 b=FYJBY4BGd/1i8BSmBeK7ModDV0z+JCEmJeLoNoHs5mUqY04w0BWCBF8XL8JTGmyWvb
 2u/ga+K8OTF9JAk71o11J7EUNJdQp0X2pkwRkFLdL6x8rl0oxAqgZFxK7Ieh7cYIvFjE
 j4nObe8tFL5lEOcSaMYMQEoaD+KlkRU8WSY24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741905863; x=1742510663;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vIWFyoGC5tunrTP3xMGUPD2eNi2llpAhXLhwaR1qh/w=;
 b=KTARCIHYZgDg6w9apBcEH92kawIxk7rTUFvVtdhXmBv0HDjKySnUuRhzjV7dzYSxSF
 EDMP7tgQvip499MvBYkRuUYz55JhJrP6YQ2JlH8hnLJUk+E6+ToPCng0u1/WQYphsy8e
 +3Be+vQCfDjMhVJMqDFOq6GAOtJzOX4F2HWig9W6Fdo2aZ60RnCS0Aski4sCfOYyfY7U
 ovDl9OG4K6VWvf40Hj3a1MvmkzCKhhSZOQYha1L3pmD/iyJ9tjSkTtee4tTNB709uSoU
 l8DOAbS/4R94paUeja5lSFsibGA81O8yC3BOisaUN+iscq/mNfEw6+pwxt2xAYLEG8cG
 k/Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/xfz+1uz0WllSc0X0wKz2HvQRtLCV0oILmTxhT/ZgsY6gOStTwSDjCAXAg8wSoopqU5Ok5lY=@lists.denx.de
X-Gm-Message-State: AOJu0Ywtp/kkzgFLiNyZAtmfZoftL9EFyoybxYzAXxsTf7+2q1FIH/UA
 VnggUg+mg8AnZSjDuJCiSOxSsMtkJAWUYTLmy/ACls0LaEFTedzcb4VibeIJxX8pvNqyNTchW22
 Z
X-Gm-Gg: ASbGncsX8bXnxvTAKRzdJdjyzaPgdNey8dUAEbDCEqM7J5HCgYJvryfNaMpAb8GQNvS
 eYdatrEpN+AflTVIGVJ1Lsl1PgYfUp/McPhKOyu+gU112zL0XNtn0Gu88jb64Eud8VSAG+RZg+x
 kAvAMEILRvbhZfGn6Xxad2nvcRh0K+1KaYsa4BMRVGOKAFS6OC4kA2DJrXSB5CB/3vG1elO2yNq
 uN/vAdInSt04iPfK5TCehh7EbSc+CZalm0ES6SF89F+Rv2JZB8helYgOhN7jWpIGdksOXZLqLpe
 4J7pyfMjoY5ObldrIRJVPe0b76LuzecKA3zk1sMq712R
X-Google-Smtp-Source: AGHT+IGhAWO1RdzyLeBXaPnq0/YUqUeFmUIvbkxEvSonzCBos1/pbc0k8Xji47ex89hC259L2UgNiA==
X-Received: by 2002:a05:620a:178f:b0:7c3:c9f9:3936 with SMTP id
 af79cd13be357-7c57c7d6d55mr12622785a.20.1741905863308; 
 Thu, 13 Mar 2025 15:44:23 -0700 (PDT)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c98225sm154508585a.49.2025.03.13.15.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 15:44:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: vaishnav.a@ti.com, u-kumar1@ti.com, u-boot@lists.denx.de
In-Reply-To: <20250228054222.2852694-1-n-francis@ti.com>
References: <20250228054222.2852694-1-n-francis@ti.com>
Subject: Re: [PATCH v2] board: ti: j784s4: Update Resource Management configs
Message-Id: <174190586130.2150240.11398930563362566849.b4-ty@konsulko.com>
Date: Thu, 13 Mar 2025 16:44:21 -0600
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

On Fri, 28 Feb 2025 11:12:22 +0530, Neha Malcom Francis wrote:

> Update rm-cfg.yaml and tifs-rm-cfg.yaml to account for the
> changes added in the K3 Resource Partitioning Tool v1.18
> 
> The change enables resource sharing between A72_2 and MAIN_0_R5_0
> for the BCDMA CSI RX and TX channels, J784S4 supports upto 12
> CSI cameras and 16 channels would not be enough for all such use
> cases for RTOS and Linux, thus sharing of resources in needed. Resource
> sharing between A72 and R5 for BCDMA CSI channels allow Linux to use 32
> channels at a time.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] board: ti: j784s4: Update Resource Management configs
      commit: 91156b63464f6166c73bffa3bf59790be7d8786f
-- 
Tom


