Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE8BC282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 17:03:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4ED481D4F;
	Tue, 18 Mar 2025 18:02:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rnzuO3U0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6860C8191C; Tue, 18 Mar 2025 18:02:49 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16AEC81026
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 18:02:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-223fb0f619dso100461155ad.1
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 10:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742317364; x=1742922164; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MhRM1qfmOYRGujd/Y5ZOz+gJWmpUSGuJWk/teaL7oVQ=;
 b=rnzuO3U0UnRG+9Mw2IAy9hyCwCdM4Ffh/dZMl1PkFiFR9B+WmwcpTXR4cbtG6F9uQ2
 haseJw9ZFeor3X7/VqW0GYs1tEQ/RWuwxTOJCaeSyyM+g9eOsTZ5s41Vczqi126YsRaF
 IvvO41SoIF3XVcOJgEMBkDUcAl+FCDfJMtqpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742317364; x=1742922164;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MhRM1qfmOYRGujd/Y5ZOz+gJWmpUSGuJWk/teaL7oVQ=;
 b=I2XYU/rf4fbKXMMxD0wvuiW8U1XWtGlF9JdHY/qEWT9swGcOTsA9n9GmMHSB/5VW2h
 j4+wLHHDi3iXTUtyR2yytiu6QjWhcGVgXEiT8nRxbBcyANMgvqphnRk+dIwUScCW6KmD
 +k//5xxTkkKMa0/374YD5AGtQXLeQa8poR1+0TryIIF/lZc1ObTqUuM6K+JxdZopJBPq
 ZasTiK8q2hfjDokreks6iwOBhuuZAOalUOznCMmXMjgqd7j2fN3GJSWmLVSzbegSnykK
 lgYyWcZo2V6tiljSBrPIAvSC5wKtbehFSsEdlFsKYHO1JyfrTV1fDkb0GECWqwZ5Lo+g
 gQNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5rD+LZI36RBZhl8OmTPVG8/RU4ZMOroxA4ubCOmqSXWhmSNajawi7RxkMi2AqohVIsYb/8LM=@lists.denx.de
X-Gm-Message-State: AOJu0YwUOPKQ5F0J7l5DhQbwKrLcwNZqIw6CwhvOm7hvgH0GL4c88dF8
 Cq23UAvzl8qjrlH9pDiCrskiZ6XMsbv+JlXgslaftMhJokr2t2JILAY/+m78nkM=
X-Gm-Gg: ASbGncvKvZwNVRNRHR0Tu2el2/FGD7ecYl8fiRLSbGjlxTe4MGcF75qNuqX2SSAOkj5
 reIJd+MiiDFiZDJuEiTSQ5geg50a5b42RU87sDhLF/UhKjnQOzrzmyz5hVSerNft5wotUH51rbB
 OnD5O/sD/DNYKrs8fX0/ps3guCAf8Rqa7yM9Zl1GHJHsuRecIyLPq5z+PWIsy/ZefmYheblcUMy
 nX2Nog7wmHId46cvRD/o9qqZvbfKsyTyzK1FMss+PJh09DN4uTSntBYVlWCQlueAry1QGDgIQwf
 000OEe+rmGUePlAzd94bEd+N/AaTSbP1yfkkbhTZTi4u
X-Google-Smtp-Source: AGHT+IGFuRl27qC8JtrU0ecCZA8HpPFwciJadY+vZ01udaLQUIWK7lYusMG5efgvge/6JUnh3hxgXQ==
X-Received: by 2002:a17:902:dad1:b0:224:b60:3cd3 with SMTP id
 d9443c01a7336-225e0a6c240mr242300505ad.19.1742317364423; 
 Tue, 18 Mar 2025 10:02:44 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bd4e0dsm97501595ad.221.2025.03.18.10.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 10:02:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Rick Chen <rick@andestech.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, E Shattow <e@freeshell.de>, 
 u-boot@lists.denx.de
In-Reply-To: <20250304160403.380961-1-heinrich.schuchardt@canonical.com>
References: <20250304160403.380961-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] dumpimage: fix handling of StarFive SPL too long
Message-Id: <174231736302.1761706.4503316177757189574.b4-ty@konsulko.com>
Date: Tue, 18 Mar 2025 11:02:43 -0600
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

On Tue, 04 Mar 2025 17:04:03 +0100, Heinrich Schuchardt wrote:

> The header of the StarFive U-Boot SPL file u-boot-spl.normal.out has a
> field indicating the payload size. When copying U-Boot SPL from a
> partition the copied file might be too long.
> 
> Currently in this situation a misleading error message 'Incorrect CRC32' is
> written.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] dumpimage: fix handling of StarFive SPL too long
      commit: 15ba2b7356af035bc7dfd5c279e9658291fc7cf3
-- 
Tom


