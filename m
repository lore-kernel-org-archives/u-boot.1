Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB7DC4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 20:49:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A8B287C50;
	Fri, 15 Dec 2023 21:48:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="atqumwxq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AE2587C17; Fri, 15 Dec 2023 21:48:55 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25D9C87BD0
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 21:48:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-77f524597c3so62613385a.3
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 12:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702673332; x=1703278132; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dTiyDAS0207utKS0wOX+d8wPJK8nJGfgo9zSlPSTI8c=;
 b=atqumwxqc4CSb5W/nje8kuRK1DKPyKAsrnzNQzKfP4q5c6HUrMLQbz28xriAZX1DhR
 krE7irf7yTDxJIRKO3l/9a8XQ2Wj2y1xipSu6+JQ9HAjPOpTHNWWt4mUdQH3nS7xKNC9
 dgN9nMJNH437CkkQbgkZpXPrwNaYnBKA+he0VxxLuygSO75DDewyjpP+TPciD5HP0c4U
 AekZZfOUiWCJ7OuojHpQ3x4GiWLqnIwacHmbdBb5nteG4gTtSp6mlTC251Ndxro3K2EW
 XIh3LTFAKrsqotuTOwl1y8NcsAQv9qM8MpbXznIXBbZxHdwU2aKnxFGBE8BENBSj0Ke5
 jjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702673332; x=1703278132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dTiyDAS0207utKS0wOX+d8wPJK8nJGfgo9zSlPSTI8c=;
 b=Y4Ee3ocf/41fXA6M26DyFkbue2Rt+4CLRBrzOLJzYHnUci6TRxh1GEu2reyB9Tktdk
 CusSc+DaArNVVQ/6p50YsOoEplIfucqbynCCuBYidnuODTtAI3QXpuDVvkI+XXocn7sj
 tFtOnRhlyz3mpa3mBfxzrwtoJgqU5rnWp7XhySic3xUHGIR1aiFgFVjF4/W0ZEJwqzHn
 M9Bb2kt5JbjqTYP5wRL7lH8LpMKwTryddQC35/4Vr4Y8XPmToe5t5vuk9wv0leEellNC
 fAqNXc6v0H2gN6S84T5Y+ojITQSvaYFWofFNRXAtRHjQlB6Kwst1GUN7eZsz9UID8tLa
 pe3Q==
X-Gm-Message-State: AOJu0YyQs79ykwHh0IDPOA8d7POdxFscFdhMPai2CHD7XCpqOrL8sH5e
 uHjeNQQAkWk2kwyd9mjNYls=
X-Google-Smtp-Source: AGHT+IE1A6m+w0acnHQmQiBDtlCHMNe2Os/bwwXyhTFN/8A/X+Z1/GD7VdM1+1fS+0Q6I95OZlUb2w==
X-Received: by 2002:ad4:4f88:0:b0:67e:f245:f72f with SMTP id
 em8-20020ad44f88000000b0067ef245f72fmr5016586qvb.102.1702673331962; 
 Fri, 15 Dec 2023 12:48:51 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 bn3-20020a05620a2ac300b0077d9b938490sm6331693qkb.23.2023.12.15.12.48.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 12:48:51 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: JJLIU0@nuvoton.com, YSCHU@nuvoton.com, jim.t90615@gmail.com,
 KWLIU@nuvoton.com
Cc: Sean Anderson <seanga2@gmail.com>,
	u-boot@lists.denx.de
Subject: Re: [PATCH v3] clk: nuvoton: add read only feature for clk driver
Date: Fri, 15 Dec 2023 15:48:33 -0500
Message-Id: <170267330672.2421617.8613669182068933649.b4-ty@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231114090004.3746024-1-JJLIU0@nuvoton.com>
References: <20231114090004.3746024-1-JJLIU0@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Tue, 14 Nov 2023 17:00:04 +0800, Jim Liu wrote:
> Add a flag to set ahb/apb/fiu/spi clock divider as read-only
> The spi clock setting is related to booting flash, it is setup by early
> bootloader.
> It just protects the clock source and can't modify it in uboot.
> 
> 

Applied, thanks!

[1/1] clk: nuvoton: add read only feature for clk driver
      https://source.denx.de/u-boot/custodians/u-boot-clk/-/commit/652d8d4561a3

Best regards,
-- 
Sean Anderson <seanga2@gmail.com>
