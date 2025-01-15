Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05893E77188
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 01:23:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90EAE8069A;
	Wed, 15 Jan 2025 02:23:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YsFiq2B/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C657B806D8; Wed, 15 Jan 2025 02:23:32 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 982178060C
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 02:23:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6e17d3e92d9so16950186d6.1
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736904209; x=1737509009; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/yHb+tiDK0S+1ukhHRO5xOJyvRwfQpQkECNM8S/f7Ig=;
 b=YsFiq2B/MZvEsNh3al27TQsY5CrsU9ugngcNXKlRcKRMqP9eyL+F+hpfq4Ct7J2oLQ
 +Kw2r7zLB8rajj4Ox5Tm5PB/hA47W53I9LyZ8n4x4jG7A3NSV3MhFd82yoqwajpQeQ3M
 md/CaXlLpKe6A05Uxz9nr5cNlY9nLJXZIWvw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736904209; x=1737509009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/yHb+tiDK0S+1ukhHRO5xOJyvRwfQpQkECNM8S/f7Ig=;
 b=qTurtMins3kE/4+0rqgignrZ8qRKFoyrbt99yss39kDW/Znbt8OjE19ybeZ/i9C2gW
 qh6C5BExpYbHUEdWCEr6bAUObNkXCJKGvtmZ0Kfh+1rtd/1KGltMUHRdWkxPr3pmLEok
 cU9WqwOs/WjXiqNUEV9Axn23KlCp9wJDjEKrrPgPSTj5gA+83IkULm5+P4Ben63bogJz
 S8j7jvf2Yb5OMpMcZ/ZCLIudC6dfR6lqNBUlwblRT3JwiVeKVOuwhU89dquBzGdZASPk
 TNc6Oa6UluZ6o9pa7n7uhZZk6eefJtg4TZvpfmplu3pN2NfiZ0JYDoez3gi1xLTwoKCA
 +2JQ==
X-Gm-Message-State: AOJu0Yytq9y9qKKzKmS0d2xvRNJNtcTOYO/99NeN/KQ06wHrseRwxbkn
 nTq08am1MSVn2EUuktrNKB9aKMCE39aNuz4Cjto3bX0a7JKsLBdyT6TzPyjKd58gJ4gF0eHfLHs
 U
X-Gm-Gg: ASbGncshQ9e3kk3sTvyz79E0mRmR+XHhznqLWwNmVG39pUtFsDSIz56IyJQ4hENqdLu
 ZiPyMrkynzawsskVYfTQKprLWd704WuNq2pPT+YwrsGAcaNVX2v7se6coih2RoDQS5Wm5OXL+UY
 EusZk6qUkc1ean6QD72Y2NDD4mcyBizlGoWAd+TJ2KpRs0XQUl8Qoupr2Di6GMn6UfCFqa3gKGw
 BxHRz6n3+yklIYZ1crXCBsoZc0rOZIlJgKfgoXil/OiLWjWWCAV9amMp3T/+RYOw3UxxE9Qcl/D
X-Google-Smtp-Source: AGHT+IEHQCNfwe8GV5rUBMKAIFVkt+oKEX5QLFjRvqEPSrnlazNDKM61Wqo4mrNR4jwgV6weESrlZA==
X-Received: by 2002:a05:6214:5bc2:b0:6d8:a730:110d with SMTP id
 6a1803df08f44-6df9b0eea41mr427911526d6.0.1736904209541; 
 Tue, 14 Jan 2025 17:23:29 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.16.9])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfad9a2358sm59817096d6.50.2025.01.14.17.23.27
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 17:23:28 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCHv2 0/6] Rework the BLK symbol usage in Kconfig
Date: Tue, 14 Jan 2025 19:22:07 -0600
Message-ID: <20250115012322.215243-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220222612.1757884-1-trini@konsulko.com>
References: <20241220222612.1757884-1-trini@konsulko.com>
MIME-Version: 1.0
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

Hey all,

One problem we have today is how the BLK symbol is set and used in
Kconfig files. Part of the challenge is that we use it as a gating
symbol for "we have a block device" and also for "enable block device
library code". What this series does is move to always use "select BLK"
by block drivers (a few were and a few others had it the inverse) and
then "depends on BLK" for functionality that needs a block device
present. The end result of this series is that a number of platforms
which had disabled EFI_LOADER now don't ask for it (they have no block
device) and espresso7420 has a regression about MMC support fixed. With
v2 of this I've picked up the review tags from v1 and also reworded the
body of the commit in the first patch.

-- 
Tom

