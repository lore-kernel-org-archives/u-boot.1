Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4505EC5B549
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 22:37:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3897681E72;
	Tue,  3 Jun 2025 00:36:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bHC/PC7l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28CA582CCF; Tue,  3 Jun 2025 00:36:48 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DC6880F9C
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 00:36:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-407aac76036so1385440b6e.1
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 15:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748903805; x=1749508605; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bV0f/p6Rc1Q9McGV6yfkhbwfdEpWdSmQehG3xm76MQY=;
 b=bHC/PC7lSjGYNDcaYWkd9g4NvK64dO+j6AVyk/hnxOFM1Sf1YkHjoTL329OvLhXc3i
 Eet1SatyHZnhkiukGof4GNYNeyNbpmx4FCLDAOTkCGzV4YgG8RHuOTvdhzm4TN3zZuUK
 G7mYT4fBRp4SFZ6GCxTl0IANo/bdxv6UQ6dz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748903805; x=1749508605;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bV0f/p6Rc1Q9McGV6yfkhbwfdEpWdSmQehG3xm76MQY=;
 b=AyYnmg+aePjSXAO4M3tcvGzFUEewXnQdczPspkjHJn1LFRgLZlqW8IiHNT2sPorWk0
 X8eHvltzq9GpLeY2rV3iT/XNLN2awF9DORW2U8lPmHUAtqJvcZ18HrzKoVKJfmoLwtAc
 KFPuLgGmgL+XlEWJWpdfqMbXbgTzTJG1waAAppvbO9hQzx7ENs9eiuSA+7SY30C2tixt
 hIvovWVREhnnFFmy88kQ5DgmMXcBMLWPcDUAQ6VB91hwlUkoj601BG6nMzd0RNFRw884
 VYEJKrjWnDiyfIpdwtN698Yka/zhhuOhR5qnqr3XOmlvnd1LTNveUwi6zfOpYeejTltu
 9vVQ==
X-Gm-Message-State: AOJu0YyhP1VdoiHq3Kd5fNJncOHaIbxIglIqzPCznNewedLAFH0jBJCw
 zweAng4VdDZ5Yuwr1IOhJi2nbpdGx41W+TCqQlBiL0fKQ/Q/8DF18eRkIy9KrKn0j2o=
X-Gm-Gg: ASbGncs+AoSZUzQqXGU1YJ4JtFQbS2Ht6vDizEDbtoXyLi7eaECSl6Hse1iAnmJwx3S
 Djv5TEg6lDh0xrE82Dk9sgahXFkEcVR56k41PifMD5btP4/pERi1OB3VO9kFbATIx1ZMSa7OF6/
 vcy7eGyLWe2epWYnahPVT+19w831WRasEinZKtBc7QIpFlYeM9kaMp8+6lYMa5cuCv9JCAMsCVy
 XSLajIXmCGkhV/8GtpRxF9vv2AS/mEYxQ3TH5H2WeocMC3nTX4Loom1qNxG7qfUZOA+WT+WoURP
 qpt0Wxx5w7X/VmPrDmMCl9jKm/OKPExm1Pu+N949rhb5TxqdWW0F/C/g0d0+pJHCueYCl3XfFK7
 JJlK8jscTWc/oKbSZ2UBSyA==
X-Google-Smtp-Source: AGHT+IGYSBQUVj04GfW069moBasDhSHoDtnbO9iGSuspG0qxxoB1+c4AviYibATLV9Jwfrwhswz/iA==
X-Received: by 2002:a05:6808:2f19:b0:3fe:aecb:5c49 with SMTP id
 5614622812f47-407a65e4084mr6725171b6e.21.1748903804762; 
 Mon, 02 Jun 2025 15:36:44 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40678c1b622sm1584145b6e.11.2025.06.02.15.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 15:36:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <ziyao@disroot.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250530140548.4030025-1-trini@konsulko.com>
References: <20250530140548.4030025-1-trini@konsulko.com>
Subject: Re: [PATCH] scripts/spelling.txt: Sync script with kernel v6.15
Message-Id: <174890380329.1382323.9161387094399607366.b4-ty@konsulko.com>
Date: Mon, 02 Jun 2025 16:36:43 -0600
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

On Fri, 30 May 2025 08:05:48 -0600, Tom Rini wrote:

> Keep spelling.txt in sync with the version from kernel v6.15.
> 
> 

Applied to u-boot/master, thanks!

[1/1] scripts/spelling.txt: Sync script with kernel v6.15
      commit: afb3ab64cb7df90a2c6fd54f1639ff3f807f1e86
-- 
Tom


