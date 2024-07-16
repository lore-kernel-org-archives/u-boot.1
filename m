Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFBCC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 23:01:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9743E88A13;
	Wed, 17 Jul 2024 01:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L9qNVv/G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADFA78875A; Wed, 17 Jul 2024 01:00:57 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B7F188785
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 01:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-708b273b437so3242892a34.0
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 16:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721170854; x=1721775654; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=95vh5YFBX6txK+P2nafdy0aoblbl0x56zvkTTB4HT4Q=;
 b=L9qNVv/G5U9Fz0GqYvqIBP7oy1JxIhIWVroFZJvQLHm+H2gQrDYVw/DIOm4gqw9cBi
 McDzVUopZ08yJcSzIv0FAv+vV/fjN+MsFePjxSE3IsWxDrW0ChCPFcZPmXNUsNxCKeWe
 GhO4+2TcKsY7LVdg1tRR+j4B4s06nrjIiXKu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721170854; x=1721775654;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=95vh5YFBX6txK+P2nafdy0aoblbl0x56zvkTTB4HT4Q=;
 b=U+wDmzzuCI/1zSwkphJtwH/GWhhhQP/1MM+lJEDCxyML7i/qgOpqN8BBIiiQsT9TH7
 l7vC/OXCQsVTVr/8VNqhAYzIgQOQS1AtSYa5/fn9y3jn9rbGFqOONAmB0Q8wzdxQBeJe
 TOTq0+yBMI6Y/cp3tEl2OAhG8/4TbxNHk2GU9ms4lWHGjuZ1DXxuCRnf4S1tqayQPjJo
 PaC91sKCDv12yCUsW8Aq0RiT5XJoRkRVHVuQb2KAYzmbpkW8pjIDZ1USp2YEnKsX9Yyu
 KqyhDkv+Tqrm+tZ4ko9f80GA+LE09QSh3X1A3bLTJIgyVYQgary+cd6Dj22MJM0hIzVP
 7eow==
X-Gm-Message-State: AOJu0YzjBcU/49ybxw0ZgqxfC5pB4TrnmmmUbnazTVgxuhFpqaBaPGwD
 A6ZyI0h0U5IigDY/Y6t6g9vt2SLWVSnXlOlRsVTnUNvgkDdK49b+3W2ZmWzJLf8=
X-Google-Smtp-Source: AGHT+IH42sMBiUNuuWlp7rEo3fOiWCuI+GYkD8ErOiyLm9IIwQ228CORfh/y5dXPtIVL/KULrE5RTA==
X-Received: by 2002:a05:6870:c0cd:b0:24f:d3ce:fe92 with SMTP id
 586e51a60fabf-260bddd9806mr2992820fac.14.1721170854366; 
 Tue, 16 Jul 2024 16:00:54 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708c0d2fcc2sm1510063a34.77.2024.07.16.16.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 16:00:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, upstream@lists.phytec.de, 
 Daniel Schultz <d.schultz@phytec.de>
Cc: w.egorov@phytec.de, d-gole@ti.com, mkorpershoek@baylibre.com, nm@ti.com
In-Reply-To: <20240701062050.1475249-1-d.schultz@phytec.de>
References: <20240701062050.1475249-1-d.schultz@phytec.de>
Subject: Re: [PATCH 1/4] configs: phycore_am62x_a53: Add more commands
Message-Id: <172117085312.763145.796768975961942487.b4-ty@konsulko.com>
Date: Tue, 16 Jul 2024 17:00:53 -0600
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

On Sun, 30 Jun 2024 23:20:47 -0700, Daniel Schultz wrote:

> Add i2c and rtc commands with all dependencies which are
> required for testing.
> 
> Additionally, add smc and cache commands to boot Zephyr on the A53.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


