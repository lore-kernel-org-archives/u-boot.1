Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC36C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 16:43:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69D9A80F9C;
	Thu, 24 Apr 2025 18:43:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UMgF7HFF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6486D817C4; Thu, 24 Apr 2025 18:43:45 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB0DA8082A
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 18:43:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-72b82c8230aso463361a34.2
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 09:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745513021; x=1746117821; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QSskYxYnl0m826cnQQQRfVOpmmSmLKP1w4dtBnADqDk=;
 b=UMgF7HFFazdkoLsTtojFpxJcPzdhvQagi/r9QFLmXoXa5azB11Ivx0tvo2awnsetvr
 rgH2bLCA/Gkuy9f+IbF4KhmuC3EZAF0yGpTMxvz1IxWgmDX4I5BM7ahBa5TQMuF5GHjS
 okCr5lzGAooTrA9PO3hgWfyCwNUwPtzQQYGBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745513021; x=1746117821;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QSskYxYnl0m826cnQQQRfVOpmmSmLKP1w4dtBnADqDk=;
 b=qJKoRUjd0JXEcdWpUAZqFUO3rJCqcdQx9lrAElsSN2CR8oP/f7NwBmN/e4p7vyPhcS
 34yd7UWD3NoN3ZuJARz/YTxTic581FD9szBPBBz8ILownCGwEhYhycEfGg2Efs8JS0MX
 I3w2aIoGePt+VhozJNbGFLEMh+M5oKYhDiDnLjzHobN9AsYXNBl4t1FdeJKI+4tXYL2v
 ozwsDbxPbB/6UtEh39lRwegMTPSY2/Hpx6MS7g52ylOEQ+wHmCgBUZ6GJxpikJpM8uo3
 UGUPRvFr45WI76oeaVbN5j0Z05TiGjj5UqU4FiI7Zd84Blb3l/vYYMjs61iDE9HnTyDX
 vYtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU38zWspTYpBfP1d1bzlJ11sRP/SekfsVM6+Ra5mmYQnLdJsswj6+YRk83XXf2S52fTp6QVm40=@lists.denx.de
X-Gm-Message-State: AOJu0YyhDC/YdHODQTWlc67NzpC10zOvo7CS4Vre8mMOkpcQXoqnpghJ
 QpYL9Oaow2q4SsgT8WxJ9m6p7McGXDiTV336Z1+2gNr0voywfHI7QJW82ZiECrk=
X-Gm-Gg: ASbGncvWIjlPinkNdO07vUAVMEIoVNLVP3cfS1WVuN0cjFbf662StriytegK8hqPOXN
 k2vs8SehVK9+eQB2uFisLM18mF0i00Y9+Guc9CtsYpckgCrNZKGkvk/fw6GEvPAQ6EOeymmYDtS
 Vti9Q6bwF7oq2t56GvNCW6iQzEIJYVHVsUyleX9RFMnS8r32YP3YSfI/9OuwQpA7tk2J26VI8k4
 X373+DGBxdVnDrqbmvzO/zqBvhuggLzPnLwBNfajJxctcUs4HRcNYfr9rzHbmlXjdIMbZqlPdMK
 Rzm/JWqjC8ZPAwdOCldo3ffY4WPCc0orSLOEz2rxa8hk2D6jacI1hjes7K+gmPAULW2ow5QcTY9
 b
X-Google-Smtp-Source: AGHT+IE7iiaE1vab5enq+D32gDukQYL5lE5R4Mz8Ra2pYpVwQEFIKD292A6YUsEwp+xhKxQxDhmRKQ==
X-Received: by 2002:a05:6830:6101:b0:72c:404d:dc38 with SMTP id
 46e09a7af769-7304db79eb0mr2281010a34.17.1745513020741; 
 Thu, 24 Apr 2025 09:43:40 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7304f2af97esm297869a34.41.2025.04.24.09.43.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 09:43:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Samuel Holland <samuel.holland@sifive.com>
Cc: Baocheng Su <baocheng.su@siemens.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@linaro.org>, 
 u-boot@lists.denx.de
In-Reply-To: <20250414194710.2096669-1-samuel.holland@sifive.com>
References: <20250414194710.2096669-1-samuel.holland@sifive.com>
Subject: Re: [PATCH] smbios: Do not look up children of invalid nodes
Message-Id: <174551301978.4069373.7201881040181346714.b4-ty@konsulko.com>
Date: Thu, 24 Apr 2025 10:43:39 -0600
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

On Mon, 14 Apr 2025 12:47:04 -0700, Samuel Holland wrote:

> If there is no UCLASS_SYSINFO device available, parent_node will be
> ofnode_null(). Calling ofnode_find_subnode() then triggers an assertion:
> 
>   drivers/core/ofnode.c:598: ofnode_find_subnode: Assertion `ofnode_valid(node)' failed.
> 
> Check for a valid parent_node, not just that OF_CONTROL is enabled.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] smbios: Do not look up children of invalid nodes
      commit: 8327aa9af4be32b4236dfd25c8cefe568e9b3641
-- 
Tom


