Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F70C47DA9
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 01:54:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E09A287CC0;
	Tue, 30 Jan 2024 02:54:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Zkwdl7E+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B354487C3B; Tue, 30 Jan 2024 02:54:15 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B31B887C46
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 02:54:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-603edb4c126so4867777b3.3
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 17:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706579651; x=1707184451; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oEFH6Mf2H8K3zdt4nAdZtB7IU9yfhvRVUH+ie8c/GyY=;
 b=Zkwdl7E+PxOYEYCGvTAymBvQsYSqUkSRB/34gy6+N8gErkHqBkBMskc6Rk2R95bs+j
 L5PQEs5LrZbBE1D0SowlxibpGTvKSyqv0pYhpPOUUqNTqEOD1y8RhTC/y3mvcM4gbvLc
 A+Ee9pBLAxKyfH+3vlt3xpr2c9LRi2GUSGYr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706579651; x=1707184451;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oEFH6Mf2H8K3zdt4nAdZtB7IU9yfhvRVUH+ie8c/GyY=;
 b=iub7KBqyIfRY6p6OpAvN2l0fvlDXQUv2kKhMUiwMPjZ84O1rOaeziVxf2BpJXJpVRR
 4+sLtOfRKjj7GHBvXSEhve0vbQdCeWWxKwU9MLdFQ8lmmwB85lT0WWJSzvwxF9a/com7
 qipJQN3+iuskCPE3t3I2FWgB24BL5nZr+6w9mumV5rsfSUeOc9ItFMR+EbZSyDnmRtQY
 6y9GNRm0ot1O4y7W5V/xXxrhCND6+P48sHw/3VZUrFSRDWlKP2LZ/CZCkeUt0J/4cfNh
 VMUuInqrAejinkFaifxwiCb5vK0zjXc6DZYKyuB/5T8N2nQ/2r12fQSPOvbW90Xbie7I
 9wtQ==
X-Gm-Message-State: AOJu0Yzr003nZXLBe6iwpfbsIE1LlcmlTKqB8Fcyw0xUSAJzwqapEhPT
 +2q7i+CVGBOKnO52xwIyMyn7UnDxDJTsEtJZGFfmN1Ex5GRtnSu8n+lDJepRAmI=
X-Google-Smtp-Source: AGHT+IEKdh5OyxwaCYxGUoXCjIiXXdAezXJTVBQcX7nauFsLyp5fwi1dkSukVTzCyxc/o9rcvluIIQ==
X-Received: by 2002:a0d:eb8b:0:b0:602:9b4f:61f7 with SMTP id
 u133-20020a0deb8b000000b006029b4f61f7mr5218458ywe.47.1706579651263; 
 Mon, 29 Jan 2024 17:54:11 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 x124-20020a81a082000000b005ff93c11cf5sm2881712ywg.100.2024.01.29.17.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 17:54:11 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, n-jain1@ti.com, agust@denx.de, 
 Devarsh Thakkar <devarsht@ti.com>
Cc: sjg@chromium.org, praneeth@ti.com, nm@ti.com, vigneshr@ti.com, 
 a-bhatia1@ti.com, j-luthra@ti.com, nsekhar@ti.com
In-Reply-To: <20240124090711.305690-1-devarsht@ti.com>
References: <20240124090711.305690-1-devarsht@ti.com>
Subject: Re: [PATCH] video: tidss: Use DT property names for parsing nodes
Message-Id: <170657965036.1823400.17951760399694728410.b4-ty@konsulko.com>
Date: Mon, 29 Jan 2024 20:54:10 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Wed, 24 Jan 2024 14:37:11 +0530, Devarsh Thakkar wrote:

> Use device-tree node property names for parsing nodes instead of
> indexing as indexing could be different between different SoCs based on
> number of DSS entities available on that particular SoC.
> 
> Also correct the video layer naming in driver to match to actual one
> being used in upstream DSS device-tree node [1].
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


