Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA790C61CE8
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 20:13:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A4AB82B33;
	Mon,  9 Jun 2025 22:13:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GXhGykpI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3414682B20; Mon,  9 Jun 2025 22:13:30 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 160AC80E9A
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 22:13:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-407a5b577f8so1125805b6e.3
 for <u-boot@lists.denx.de>; Mon, 09 Jun 2025 13:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749500007; x=1750104807; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EbuSlma5NgLFNVD05azh2MPZzCKfjHS+yLILCTGPhe0=;
 b=GXhGykpIaPMjl92S9Xz4hHc0JH/6/nzij3K++pvmI5xiIZ9n1vq1Z0J4McWD8rd9ho
 /5T+DZf85Ysx+n51VjU2i+4HAJV8eqYwQzuJIE9XCndeIEntseoYS3t5RQWHWe1WVQA3
 gnz3QKe6Um/ZB7py+O3R0ny/uQe3znnH3NDvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749500007; x=1750104807;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EbuSlma5NgLFNVD05azh2MPZzCKfjHS+yLILCTGPhe0=;
 b=Db8xGQlms81D0evJxRTfPR78EsWvlM5GnuV9BDuliWAriMzdgGqRN5XIB9hkhMtDd+
 AD+ZAA7L2Focncf7NbtQsz3dTxfZxuWgYWwFNKBEwyF92ECEzra0C1NtDcCQ/cgVP+fu
 Z1b4rXPUnK43q1evYtDHOOpdlyMfjDqGYwXT/xXibmIXAHDKZNuFlKommysRXE+Nuune
 97pJPCT+xFP0Pp9wlqApEXHfMa0rAjjX4nh5TiBK4yg7NWytoRnu4XRiwKCZph/s8fnM
 pR8+DSWfT79ZdWvvr5D9W9qKndaw7rS8H0Zmr39yAZ1YQA8mPFMFQd5CeYEwXElEr6Wz
 Odew==
X-Gm-Message-State: AOJu0Yy/e6zu2HFwLd80XsTZ6S5MrXiZ7y5eobcuzvmYvwptXo2lKsyK
 iLzIj/XyloEiPSX6GeFV4P/qphqJqDiDYjhUgIYSJjYOkizu4TYNNmiuU9Wx7rn4BaU=
X-Gm-Gg: ASbGncuAlYH/GZB9Eral5CuMbSdmyKiwUdX+64/Q5jYpByro7vw2BHD7DFBBVHFujJp
 bIFKL41hwkxQwJqqVJcAk5GoNKOCfz3Ria90Lcly7QbrkVd4hH98iMVZ5MMwPy5j5doR/UXO4vX
 TOxvUP8P6HTiQ3iMptimKBJ80nqdP3et1gKSPk2HzmnEPrc3uhBZzXfiH1Lxk4/s1DfZ1atLXGB
 AKULlyLn95fPb6k1Iw8hq38/+3eGmEZno6DDAPV8acAX081oYyTgtYQ7SA/G6Fq1rrewt/KFNOe
 5ESK3iR0exjOg3kS7LXEYQp3DcpJh84LCvnLFs622xtU37zwgKJOSybin3ItNexQ/V1wQ0co2Ln
 gW21mO2Tclnx0i+PlMHdytQ==
X-Google-Smtp-Source: AGHT+IEJvo8OJB6CIzmFcXWHhUBKTROJc0WD6TV9kDqX+lmy3NRiAza2Z4hLGyBoFYvk0EorkSxMgg==
X-Received: by 2002:a05:6808:2804:b0:406:3a0c:1801 with SMTP id
 5614622812f47-409051faa7bmr8467694b6e.20.1749500006813; 
 Mon, 09 Jun 2025 13:13:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4090692e00asm1933503b6e.3.2025.06.09.13.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 13:13:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Yang Xiwen <forbidden405@outlook.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250531-pie_blob_fix-v1-0-7b4a37987dbc@outlook.com>
References: <20250531-pie_blob_fix-v1-0-7b4a37987dbc@outlook.com>
Subject: Re: [PATCH 0/2] arm: armv7: fix a bug that prevents
 CONFIG_BLOBLIST and CONFIG_POSITION_INDEPENDENT to be enabled together
Message-Id: <174950000517.721141.15379025652634352235.b4-ty@konsulko.com>
Date: Mon, 09 Jun 2025 14:13:25 -0600
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

On Sat, 31 May 2025 21:10:01 +0800, Yang Xiwen wrote:

> This patchset also enables CONFIG_POSITION_INDEPENDENT for qemu boards
> to avoid similar issues to happen again in the future.
> 
> 

Applied to u-boot/master, thanks!

[1/2] arm: armv7: restore section to .text after saved_args
      commit: 03005fbe5006c4c79143fdddb453d3ec74e004f5
[2/2] arm: qemu: Add imply CONFIG_POSITION_INDEPENDENT
      commit: 0a7610c97ae6af8d2681e361eb24fce1cd63194d
-- 
Tom


