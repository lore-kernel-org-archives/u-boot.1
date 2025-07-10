Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE5CC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 22:42:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00CDD837E2;
	Fri, 11 Jul 2025 00:42:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RG95Gxj5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68B8E836EE; Fri, 11 Jul 2025 00:42:04 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 544CB836CE
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 00:42:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-73a43d327d6so782911a34.2
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 15:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752187320; x=1752792120; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jLDskAiOEkZfjP69aaIHKxTzN+N4s0XYS0q4zPwxsV8=;
 b=RG95Gxj5VOnx4dloxMv/vvNaRwoTxflaivPBfCqKCfTWbKPdRA/0zKwlIiE1l14Rep
 B0HY4QXET6jmCfOBttDkZ/QvTiI2b0+41zMKNse/A+83ZOZ62ZQG+StDrwnjMQ0zbGgj
 vykRqKdnxdvimnmCJyYe7S4CQFMDutgqDlHKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752187320; x=1752792120;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jLDskAiOEkZfjP69aaIHKxTzN+N4s0XYS0q4zPwxsV8=;
 b=V34oh7U5lp55EB4q2IiDjLkQ+lGs7z2RRRLvsjlU0LRATSTGmnMVn3I9qiIQBUpaGG
 TCUpzvh10bP0vqR8Cv3ghmTWd11YiDVRDlePC73rx5GQq8L1NWWocxwLwL3VmZsYFhbK
 xy3oHPAenHXh5qIv4xy9SALsRdlXoAwslTQLMNfO45ScO+x3HXJOE/ju2+BHR/V8mQTQ
 JvuXMQGBjm6D4UhV/qDF2oh2SCs3wiXGMSovq/TsSHN1KaeL6/E0ymAg3mCSf5NcR4zf
 iwkHNc+KksBwiIyZOWhkZPppVwjMldlW5glk0LBCaDyuP4rJuMWiqkBwqGgDl8YWNhVy
 y4uQ==
X-Gm-Message-State: AOJu0YwXHnzuTYD/MS/IzFNKhLA5QSOqCz5I0Cocr+eo/GEdzVZ5Hx/n
 0S51sqNUz7uwzkVYrwZ6i0MFryyZkibYXK0GJNaSP2msqxLtELUS5SfQbP6v3MfTjmzp2PgYkKE
 ZyM+4QBs=
X-Gm-Gg: ASbGncvw5UC+ZSWY6PJSEHCR/jrIHWyyKF4fohrhbGJrVElSaPDfldShTFCgk6zv/JT
 J8rYxC9RtwdV+zm89ACsPYWBmg8oUyn24EIrVftt9t82ygtBvhh4uY0/bKbJk40bBkYQki4BjDG
 NyXyDOwAxb+cJ43nmZ32Pxv7ye48o4Ca7zihDOtKsyUW3QTuob8u+hdNNke5JmFaA1kG8FrjPEa
 czP8P6BqildtVjHQvhbdt7RbA2UpIg+NNLRPel8vZRFSMS7Ok28amIXQwjcTpKIeRbf1fy30xrM
 x0iYiA9S2p219UIHSb3vbyZc55la0C1tCFPRv8WL1admWKa/o0vEB7j4HLf8kXmNoLCnm9bHDWx
 4h28ddPyGp8NWCjbymT8baiywooG5wuOPG6MGRKrAZchLDjJUBQ648Z0=
X-Google-Smtp-Source: AGHT+IHlmKPPDNDp+GRTfN0SCorD4UkeYCUliLgNki9qKfTgATCJEo554/Dataiq/xBFeQ5SROkpJw==
X-Received: by 2002:a05:6830:348b:b0:73b:32bb:7a06 with SMTP id
 46e09a7af769-73cfb22e14cmr366375a34.20.1752187320134; 
 Thu, 10 Jul 2025 15:42:00 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf12b745fsm357354a34.64.2025.07.10.15.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 15:41:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250702010415.18873-1-trini@konsulko.com>
References: <20250702010415.18873-1-trini@konsulko.com>
Subject: Re: [PATCH] crypto: nuvoton: Tighten some dependencies for the
 nuvoton platforms
Message-Id: <175218731937.2073260.15207021551909362676.b4-ty@konsulko.com>
Date: Thu, 10 Jul 2025 16:41:59 -0600
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

On Tue, 01 Jul 2025 19:04:15 -0600, Tom Rini wrote:

> The nuvoton AES driver cannot build without platform specific headers
> being available. Express that requirement in Kconfig as well.
> 
> 

Applied to u-boot/master, thanks!

[1/1] crypto: nuvoton: Tighten some dependencies for the nuvoton platforms
      commit: 42dee43d627e67e4250382e4a036298b9ca38ef5
-- 
Tom


