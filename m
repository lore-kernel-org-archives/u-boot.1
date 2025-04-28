Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58954C369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 21:34:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 531B582145;
	Mon, 28 Apr 2025 23:34:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GSzW3Uul";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E425282153; Mon, 28 Apr 2025 23:34:01 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A7F68210E
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 23:33:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7300069c447so3012679a34.2
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 14:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745876038; x=1746480838; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O9hwB/pBsnUL1odgHIR+vH81+v+MNhxyYeeTx5kGB0w=;
 b=GSzW3Uul07c3BOodnq62rLEePvOOG4/zOs/0oQpXieEHB3wbva/GHXRbQ1eDg1UUjw
 C78Y3tIxe4UT1AjaDeiDxasl+7Ddb9/cee67mkG8MdWF0xSB9k2b7i0y/hvy59WpMdeb
 9YM0EVDmZtKndJOmDQcO1oBKoUbiitZSHwz6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745876038; x=1746480838;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O9hwB/pBsnUL1odgHIR+vH81+v+MNhxyYeeTx5kGB0w=;
 b=Oi+BG4uXupPaJeRx4mI0ttDrlqW/DxxekKJ5AOqpa8Bs9phbG045eOuggSQeNzYAVq
 HsoyjTVqSnZEVeCIn4jXHU7L2Iqdo6FVi/Zf3UlRb1HWUbzLjjZFmXlGXNH2bp/4ClQq
 RUrdrH/mKtVOYVGvmE0o4UBefEqXtBO9VnuyfCM7WFBX3J2FtlGodKJlhtlwdrpDZu7w
 6JsdkpMJgglV8Robs8x2vbggPqOC+TxocpTzSJsUwhW0viLvXKSOEpIzhFDw3/4Ng+us
 L83Hxt62sWm0SFrID0HeTlLkDjlDpeZmeiupgJZcB4xKOfoaYl3XMq2ajzoV1SsH0k0/
 HwDQ==
X-Gm-Message-State: AOJu0YwjLsltQNS1d13qXgq+R9zTevHdQfZ2uRoOlY7qT3dRTBEvUk64
 YwHpAi3fPp5T9KmKbsCR/T7TXO0hOVubegggp/MWorNMCHwQJMxptd1EP55QHN99sePRU5TAIfQ
 q
X-Gm-Gg: ASbGncs7AkDFZzupg/B3tFW+HGHQFRRXPTDZEJZ7pFN+XGcpzp2+R9eZyHvNgkIGHDG
 OZvPDblCnBY1a1GlgpcDk5OyMOTFBMoKgbxQmB/vXblslunve6g+DNnCnk5R0NPUR57X080B/BF
 SWQ9vaLJWbMcU3job6OqzvNFVCw9lOFEWGcoZ0mvO/irlbvC2iQaR2QK1rjwO6H8MoEJyOqU6BM
 l4759zQCIBN8sm6MasksaNWAun9tJiM3VsOVTD4S8bs3LIb3VWhwziacUnfPICcyIjD2cOUJjEe
 EjslhNeso/1TKa3Rv8y7GmlOGFmMJYAdK66HJre96XcGvnLlocKt6QDVyhqLf5DLTL1oVkX96dN
 k
X-Google-Smtp-Source: AGHT+IHMP1azCrgatUs2WjR5SjzmsSpxcL91Q2a9HzoFBOqzQYziw2M5vXsTDwoeQF8IraE6N4+Rmw==
X-Received: by 2002:a05:6830:4887:b0:72b:87bd:ad5b with SMTP id
 46e09a7af769-73088aab017mr859927a34.4.1745876037942; 
 Mon, 28 Apr 2025 14:33:57 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b139000sm3108a34.40.2025.04.28.14.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 14:33:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mark Kettenis <kettenis@openbsd.org>
Cc: marcan@marcan.st
In-Reply-To: <20250420115808.94272-1-kettenis@openbsd.org>
References: <20250420115808.94272-1-kettenis@openbsd.org>
Subject: Re: [PATCH 0/6] Apple RTKit improvements
Message-Id: <174587603696.1121500.7934805869764857141.b4-ty@konsulko.com>
Date: Mon, 28 Apr 2025 15:33:56 -0600
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

On Sun, 20 Apr 2025 13:58:02 +0200, Mark Kettenis wrote:

> This is a collection of improvements for the Apple RTKit code
> that we have been carrying downstream for some time now.
> 
> Hector Martin (6):
>   arm: apple: rtkit: Add support for AP power & syslogs
>   arm: apple: rtkit: Add default buffer handlers
>   arm: apple: rtkit: Add a generic RTKit helper driver
>   arm: apple: rtkit: Add OSLog buffer support
>   arm: apple: rtkit: Add endpoint field to buffers
>   arm: apple: rtkit: Support allocating OSLog out of SRAM in helper
> 
> [...]

Applied to u-boot/master, thanks!

[1/6] arm: apple: rtkit: Add support for AP power & syslogs
      commit: 72bc04b8744c8b2756cbf115a88bc48fbde57c6b
[2/6] arm: apple: rtkit: Add default buffer handlers
      commit: 89cb15788a16f2568083d984c547ff41c56a2d68
[3/6] arm: apple: rtkit: Add a generic RTKit helper driver
      commit: 7bac7f5f012f4990ac28116839043cf588499e3a
[4/6] arm: apple: rtkit: Add OSLog buffer support
      commit: 082789a4f7a1a7bac46ef75f98acf93ee8bfe837
[5/6] arm: apple: rtkit: Add endpoint field to buffers
      commit: fe593cc8ed9b9616eca9d094be1b1557824dcea4
[6/6] arm: apple: rtkit: Support allocating OSLog out of SRAM in helper
      commit: 4a55e7f0311df145662831576bbe0ed2113227ce
-- 
Tom


