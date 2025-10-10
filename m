Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6687CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 19:23:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2D2A84301;
	Fri, 10 Oct 2025 21:23:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N4fDD3pf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0675583FA7; Fri, 10 Oct 2025 21:23:26 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DEC58425A
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 21:23:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-30cce892b7dso1311237fac.1
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 12:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760124203; x=1760729003; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UB0x9bU47SNh+qTGuCqgzGXFJFpq3aNZrfeqaBA3/e8=;
 b=N4fDD3pfDyYEFr1HRtO5LidGT9uZBcn6YcJWMnyqVZ0eShTAhZeMzxrwxgXW3E+Z5r
 L7xgapGRZY58ZdomgrNXa1V6noAlJ6FaUTOnzXqITTPxDH2LpKNwWZgr6orE7QoGqMMF
 SAXXwKDeDCJ9b9L+cJ4zmmruz7YNLIC3TJ34E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760124203; x=1760729003;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UB0x9bU47SNh+qTGuCqgzGXFJFpq3aNZrfeqaBA3/e8=;
 b=REKFZgr0stxG9H6C5NAXQu2T54bX4Pvd3YfaoPFRJQUvTkwgSEj3l4YH1ot4ys1eSM
 JjYGgCy8j/Q9JUKCIdb9fjti89nBHWRAcp6rzOpKpdTOuEq/4Afj1j9NaR5xUvjOwI0O
 NZnujH437j21F5NOJ2xPxq+GJbbKyezYadHU4SFS7N7KCcWOCueUoQvKsk9rl4WsMPB+
 Hv/cSFyXyH3xlg+B/90a6U9QUJMe6UQvi1n6JChLSpERvx/+7kt1W1Nmr4GrrJeHL47g
 Gqu1uLJfWGnv8d3193hChApSbzObM7udhn41PUS94DLfDhSOlO+67jnr/kbUCKazktLR
 fEzQ==
X-Gm-Message-State: AOJu0Yzd3kOWh/bPqs36t8O5LF9JAIGEVyusWN2oFuCP2a+flWi4x/af
 0p2BrIO24OS0/9lXTlHx1EWrT1hnmkKwoXnSUMWoOdRLXHdxS5P3l08Id13LR29ZQb/Xuhm+V2M
 8Dl4d9iA=
X-Gm-Gg: ASbGnctLotlmj5rHZSgBz9f706S48G4BlukV5J96kwrugl7N/Qr8i91uR+GWLnlIctQ
 uDAQEHnbf18QsT+YkdEC7hGGWz1bz6V8cYULkOuQ6h9RHTUom/q/XWibllHKJ9e9xkoAi+BbMxz
 dhaeTQddeE4nyBzyhdWOFpN7u1wTrJoRW0oBUfE8UJa7RevkXMiaGtexecs5I1mh+wSUAc03gBc
 ytcAnMnKg9QRMCwCtSjvVr+fuLt7YEclJfnWnZZJEEGZixj9KEn2mv+eAlTOPhUjnNFRqE2Yczy
 GOKphOc4xqCBAHzDLT9Gr3l95Fx8LL80kPguPP38vnspqVr3P5hXbbFMZUoqvmke1v+8bfY2lwo
 l2gNIZsRinlAN1eu5L3TPX2UvzTuRtQ2cBAFWoxs4HlIEN7k3zBg9FFVBhqS59hK7Dzhl3d/2dL
 wCYWgLhqDMbsLSAaoAzFGsueVJ
X-Google-Smtp-Source: AGHT+IHak4dp4NTkK+7ezFNUMw9IiSXCqM1b+PruE08JUkS3/8BRSepVpEpXWs2nYTwVG5DlmKHVQA==
X-Received: by 2002:a05:6870:d152:b0:2ff:89c8:44f4 with SMTP id
 586e51a60fabf-3c0f61fc644mr5652962fac.11.1760124202687; 
 Fri, 10 Oct 2025 12:23:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8f581ecsm1155832fac.25.2025.10.10.12.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 12:23:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251001203032.2828213-1-trini@konsulko.com>
References: <20251001203032.2828213-1-trini@konsulko.com>
Subject: Re: [PATCH] dts: Set a default value for DEFAULT_DEVICE_TREE for
 SANDBOX
Message-Id: <176012420189.1180358.457766542212876692.b4-ty@konsulko.com>
Date: Fri, 10 Oct 2025 13:23:21 -0600
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

On Wed, 01 Oct 2025 14:30:32 -0600, Tom Rini wrote:

> As part of building with "allyesconfig" we need to have the correct
> default value for the sandbox architecture provided here.
> 
> 

Applied to u-boot/master, thanks!

[1/1] dts: Set a default value for DEFAULT_DEVICE_TREE for SANDBOX
      commit: 3da6f00af38c7db9c28ca455ad72f552fdaf7713
-- 
Tom


