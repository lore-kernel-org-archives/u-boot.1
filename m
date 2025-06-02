Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D7AC5B549
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 22:36:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97B5582CA0;
	Tue,  3 Jun 2025 00:36:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b0o5Mss4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66F1882C84; Tue,  3 Jun 2025 00:36:45 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0195E80F0E
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 00:36:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-408d14c7e92so1445727b6e.3
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 15:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748903801; x=1749508601; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AOfQ5ZaiED1mlnZ8y6pLJ3EUYVNEitW5qEEaolEO6f4=;
 b=b0o5Mss4U+23bvD3LkPRiCFs/jyawZWDGtqkwJ8Nfp7Nf8v1nl4/jX3vZgWbtA59lf
 4BLgDu6Du4QfAbRhqu1nmuOuma+YBvQTOgvaIUJtD0fhbSj1aW2+SaTHi9TsuFggifkg
 uLL0LMXiGFhIv2ktpRSEtvPRKKuv8CR5Dobjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748903801; x=1749508601;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AOfQ5ZaiED1mlnZ8y6pLJ3EUYVNEitW5qEEaolEO6f4=;
 b=rKjLiYBj5sWUif26261FJSHUUH9hJJGQA1zl6CtAJ0pYWttRP8901WvjqeqWVzS96J
 6BJ5oeK1hqXm6ATzT0DEVhSx68DyyywLfd7s345ojJND7uQhLQ6WDX6QKEYA8sj//I0O
 OCTorUqrrW3Tw67SnYjbhrydjuf8rTbezXhp1qMlRDwHPTPsH4y0bN5SV//r7kBBpcag
 0+ck01ni3Fdzbx4mFm+wWFxNi/pIBW7UsOl9BF2mwtx3i0DXEulcTIkYOVieeyA9aqfO
 6PrYAHNNYlFEA/fc64j7iMwddT1go9PD8Geou6vbGLV89MN5OGmZFulY4mMtCx2H1+NB
 +3qg==
X-Gm-Message-State: AOJu0YwV1NmQ3LBEVohT6Qhan/QYpz9J7L60y9hpE5HwnGCs2hV7uPIz
 X6oP5EuziZbDozQNTMUNTy4WCLjcFNA529AUOfV/MhJ++5aCcVkIIV1CoRzPtCnXYlqZLUxkjie
 GhjNTC1Y=
X-Gm-Gg: ASbGncsEh+yxX95BJfvu4zGIoTzeNC7A1gzB6rf9WEdDoffhqfXcmL0XB2OFsUhGl7l
 md24OHoV1pxQ69+Gj2L5UDHX97OVOW4qWhxQ/p2Gxsf/xUlb+6igyvfw1SEbVGeex7+p/10F9D1
 RITYDM77zErQ3AdZAtxmFCojg5wj44hqlW4oudb/9OFp6Ap1AMLn41V3sCgloe37jKagiKyIte1
 703zgwwuL3LgBCiKe8XxehYUa/NBQg+MpmfE7IvAvj7tillE4BnayfkBxTWgLYoodhFq04UlPh9
 l1ppkAcobY4Kh9MtDUXT76/9P2PLq0yFYxkeoAUhuZByY3P+G509r5U6Wp1lpavyDiQx3zymzFV
 QUtFoH79kGb4=
X-Google-Smtp-Source: AGHT+IESK6rw10MG2/cXk7D5U090AWicoqdiPt1q8QA42p9SImoHpn9irN+5P8Gvc/9nyHs0gQzLxA==
X-Received: by 2002:a05:6808:64c1:b0:406:6d79:49e3 with SMTP id
 5614622812f47-407a661239bmr4803164b6e.34.1748903801476; 
 Mon, 02 Jun 2025 15:36:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40678c1b622sm1584145b6e.11.2025.06.02.15.36.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 15:36:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
In-Reply-To: <aD1hcL5njHthqFZ0@swlinux02>
References: <aD1hcL5njHthqFZ0@swlinux02>
Subject: Re: [PULL] u-boot-riscv/master
Message-Id: <174890380030.1382323.12500650807504582907.b4-ty@konsulko.com>
Date: Mon, 02 Jun 2025 16:36:40 -0600
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

On Mon, 02 Jun 2025 16:31:44 +0800, Leo Liang wrote:

> The following changes since commit b22a276f039f818d5564bec6637071cfc8a7e432:
> 
>   image: android: fix ramdisk default address (2025-05-30 13:44:05 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


