Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5338ECA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 18:15:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB52A8340A;
	Wed, 10 Sep 2025 20:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KTboP27j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBE3B833AD; Wed, 10 Sep 2025 20:14:51 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5DC6833D0
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 20:14:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-74381e207a0so5509230a34.0
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 11:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757528088; x=1758132888; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nzhapUPehvY+HQXNJj3t53XpnKu9dyvsBzMOX/f3fEw=;
 b=KTboP27jzuMcR3ljwBIk1f+PEf39cIBPH5orb7l+oG11UjOsOP5ptpyyv8N+mBKUdc
 xNftmtVhzpkrIkuzPF3jt2ED6g8SGCUR9NHmrlCR1eXeXmxceAgUa9Sw3CPYXsYAeU/2
 k5zbsBgVV4i/TyAWjHiOzsM+z3neLo/3apVEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757528088; x=1758132888;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nzhapUPehvY+HQXNJj3t53XpnKu9dyvsBzMOX/f3fEw=;
 b=KeUYvBSU9lrPSFtBtRDqkC2QXOnsp+78XSy63zQvzU0MrclokVgn4blhwzE3KUybMH
 QfDIwFEXuJC3qhbB0I9Px1D6eHyZGC5OLsIh83P8hyX/EMN8GdSqrWj7v0FStHxWVdE1
 rbAcjPhS1Az9fIOwINjNYLgkqOGatod+8PKRPY9zB7zczEqo3xf823/Ja6HkvU3zZlZE
 SVQigDJwFBk7/sRc9OB9Ns+SjsxEYhdYq5+R2w3dHISPESCyr58mvVhIzRvIRyHJlD0e
 aRF4C7aCoUggEh5oLQpvJMoWC5kn583tIL9IyZc8U+RxXJGTnzof1Outt/R8kBfMXBNL
 TTEA==
X-Gm-Message-State: AOJu0Ywa8QeiBZGBjmcjMxO4/upTPlXh/7a97gZ3n3zrOiCDI/9segf+
 i/FPoOH2N0bnMbOm4go9FL7LYVTbcDpV+9S1oSJJTIlxnm0DSMuXeQVHoLfSc+BUuJDf/eeWhFc
 V1uXdmHw=
X-Gm-Gg: ASbGncuG+JL0OXu8K6rEb/yXxx8bhSezM7t9v9lXji88ob1qjMG0ZKka6hOaQS71kEB
 I1GQ6fhVz0TNQHTWmF3w99TmfaMk/c53FxYftYHQTsWJ0WAcB28bDYIkXTydW1lpbVkklD4pUt5
 w3l58vcIEYZZciyuIrpiPy4eApFP2RmbC55AOQKOOir0DHH5RXK0yVBqF8PM+oCnwfvpeiKiSZ8
 TehW9NFBTMx733QBzfmVM7J6mah5pBdMadozMvDeHUyKKVjXI/+P2vmXjWubUgEXU4DOja8KZcA
 GIR/fLA4lRsiEn4Snkz3UFXdGx1/TPnbMOxs/vn9VKryQ1/kJxgDfeM8WXutXV/O1ttZGOp4/9w
 1LqHdx+PS9Td2/qyhTJ4Btntt1MRDiTUzmMa+PTL2KfqnBsFuFndjgiw=
X-Google-Smtp-Source: AGHT+IEE78toUGDoE9YVls9leWiudgoXJAR05U3xmebY6VIgcU8wj3EKOXfS82siyJJBo1SAjhVhzg==
X-Received: by 2002:a05:6830:90a:b0:745:56d7:ac95 with SMTP id
 46e09a7af769-74c77a6700fmr8878272a34.25.1757528088406; 
 Wed, 10 Sep 2025 11:14:48 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-75200e6a1casm18100a34.17.2025.09.10.11.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 11:14:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <20250826194537.20788-1-mibodhi@gmail.com>
References: <20250826194537.20788-1-mibodhi@gmail.com>
Subject: Re: [PATCH] fs: ext4fs: add CONFIG_EXT4_MAX_JOURNAL_ENTRIES to Kconfig
Message-Id: <175752808706.1959855.11891207840576334577.b4-ty@konsulko.com>
Date: Wed, 10 Sep 2025 12:14:47 -0600
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

On Tue, 26 Aug 2025 12:45:37 -0700, Tony Dinh wrote:

> Add maximum ext4 journal entries to Kconfig. It is necessary since the
> number of journal entries is proportional to disk capacity. For example,
> an ext4 4TB HDD partition could require approximately 500 entries.
> 
> 

Applied to u-boot/next, thanks!

[1/1] fs: ext4fs: add CONFIG_EXT4_MAX_JOURNAL_ENTRIES to Kconfig
      commit: 8c599da5060c2bb4c085a7d92794c8134f61ef25
-- 
Tom


