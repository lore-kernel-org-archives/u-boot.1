Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46916C7EE30
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 18:40:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E4FF82E08;
	Tue,  1 Jul 2025 20:40:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bgjnTJWL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A2B382F28; Tue,  1 Jul 2025 20:40:40 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A740082CFA
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 20:40:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-73a4c557d47so2934007a34.3
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 11:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751395236; x=1752000036; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PI9tgAyL+XfCA3TU2PyAiVjrWwbERpaLb18Ww5+ZGnE=;
 b=bgjnTJWLCdQMU26UObKHKdJg66BGWLxYiRs8Dh1QnzzIUdBfROrB29QHjvYgSE3cbt
 doXm/MXQxz2V0Par0h27a+gJkggyrT6JYbYTG2yy51zPcpwMvdsCaV/xTj0YhPy1JS+w
 XeY1ysMrgk4s3jCgtxHgURbZsrvcb95qsF02Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751395236; x=1752000036;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PI9tgAyL+XfCA3TU2PyAiVjrWwbERpaLb18Ww5+ZGnE=;
 b=JhVQXOuE0DQRKPAVroKeqhs6pEJPp21nKJeTHUhV45HI9aYr3WVeg/GO+CYE4nO0Tp
 /Z+WE3UQoUdM37J0+ns3ep8SiIMe3VanpEgAD9BD2AapUKTz0YYOWh/9PtWzJPJCPhpS
 3HqSr/OT4xPTIwxzQ0Hd13NlYPU+dMi/YsQSHpiao0pMImTK96XxHGovNxCyoa+HXFtY
 vu+no+Vi5x6tc8rCJAWeQwJw6gqIFMy0tdrmt6gtg9244jAKu1mDsokVRyoD7PMU99pN
 Wmk5SW6RZiifWaNF3L0C0OVRaZ89KugtfKxQjFEvkTVs5alUEVr49KWTjaTayN/RNJTu
 PZ5w==
X-Gm-Message-State: AOJu0Yypm5+Z6F97gFyo0xeTv1/h76NGlJjCWSRt+5DciYFCQo9sighN
 SsH/NUbVxfuz90O9gProKqB8X9l52s+utXBXXnfg4m2svZqJSIWlWvZk2aUwitrD2nc=
X-Gm-Gg: ASbGncvpaCnl4sIJ9qNWsr4dXvdJnwfs6qwSjFfsuU88SvzLism247zioSUuKfRnYJO
 fpAL8YKOMs5d6g3tLkKBCDXX/qWWUY0ojL3evE57JT53KDOhFAyzrZlscog9g3r2526nZ7trl86
 g2HkftdvTHuNIogGIx9zj5CFLbpSc5JUg93x63jtxRYtLsPy/DeK8SrmHM0YI/6QsRS4yWvdFvt
 MnnGe0AVq6A7TOFCXDeg/WmqOflfQ+8dIz6mn/1dWnRxWkyjWHdYmp82IKTBgJ1qgtdweg65X0z
 MB/H7Z/zAMcjnezpUdQpfOq0DiXvJr/mRW5Yaj3jcjvHLESkN6JM3U3HISkfWNg2hqt6ShoW6lQ
 6oqPcST55Ct3+mO7zSjjSvw==
X-Google-Smtp-Source: AGHT+IEpsBYcOUeshxiuHvOvxb0FwuMM4UmyHQXJDfNaNSwwUnpuq6V77qFbVU3mmbQeqsV9yP1sUw==
X-Received: by 2002:a05:6830:61c7:b0:73a:9158:fb7e with SMTP id
 46e09a7af769-73b4d264eb5mr7694a34.25.1751395236081; 
 Tue, 01 Jul 2025 11:40:36 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afaff249bsm2210913a34.6.2025.07.01.11.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 11:40:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Alexander Kochetkov <al.kochet@gmail.com>, 
 Lukas Funke <lukas.funke@weidmueller.com>, 
 Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250418-binman-pubkey-dir-v2-0-b6b90a765ffe@cherry.de>
References: <20250418-binman-pubkey-dir-v2-0-b6b90a765ffe@cherry.de>
Subject: Re: [PATCH v2 0/2] binman: properly error out if path provided to
 key-name-hint in signature nodes
Message-Id: <175139523529.3190871.9175024643105070704.b4-ty@konsulko.com>
Date: Tue, 01 Jul 2025 12:40:35 -0600
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

On Fri, 18 Apr 2025 13:26:06 +0200, Quentin Schulz wrote:

> I misunderstood the documentation and put the signing key in a keys/
> directory while setting key-name-hint property in the signature node and
> u-boot-spl-pubkey-dtb to a path.
> 
> mkimage doesn't fail if it cannot find the public key when signing a
> FIT but returns something on stderr to notify the user it couldn't find
> the key. The issue is that bintool currently discards stderr if the
> command successfully returns, so the FIT is not signed AND the user
> isn't made aware of it unless the image is manually inspected.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] binman: etype: fit: raise ValueError if key-name-hint is a path
      commit: 2ddc47f9aa0581a907dd07cb4468ef6d4f3519dc
[2/2] binman: etype: u_boot_spl_pubkey_dtb: provide more explicit error for key-name-hint with path
      commit: 4e7e0ebcf59794b97542bb6b3d1e0a0fefa145f2
-- 
Tom


