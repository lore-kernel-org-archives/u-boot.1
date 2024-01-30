Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3F5C47DA9
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 01:54:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 616A187C05;
	Tue, 30 Jan 2024 02:54:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cN702iG1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1862287BDB; Tue, 30 Jan 2024 02:54:13 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C39887BEE
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 02:54:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5ff7dc53ce0so28998657b3.1
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 17:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706579649; x=1707184449; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VizCw9fNb5MaMZEEITbDsE63WFlAp7vjZTt/5OLQVN4=;
 b=cN702iG1qcS1hZr0etGtfirLL01ACQpOyybX9Tydfw4dScjAuB8Bp3td25J+u23okk
 vOMhm7ijp0+xeVPw9oA2cloa1qrBuyBtryGS1oe/sfQBnmvfZCk0U1oaD5UGi9CpyJmT
 iTtqTRhsZ7ySnLEziffufhg3XAllvh7UKNnmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706579649; x=1707184449;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VizCw9fNb5MaMZEEITbDsE63WFlAp7vjZTt/5OLQVN4=;
 b=DKdJAFHrcNq+NIqtthGIwPdnsvVaMNWd0Nf8BOGMS7uZjtlSXeV4CQY5rA/n0c2TgM
 lNkCA48BtDadR4PW+FCk8EM3J5nSuxwKbmxQmPAIi6EiDkmoAlzK9UHZTsPunRWSFIzx
 hBVZYH2A459vWHwwdCVLI8sA7StVVteGkPy6C/F69EPD+bKj87ueHdoK30O6O1RBbrc9
 iCnJIRsbRTUQe8yEN39teVOS9tbs9/GCYcMBsLO9UTN6MPJ9FgX+Od7J8Y4KXgWKYnF0
 z2ZMoFUjgDgP5Lumh7+ammZXNF2xLOlhPdmCbjSljiJYovdsLfEQq/VHgng4tG1d039d
 BBNg==
X-Gm-Message-State: AOJu0Yw2ay2h2P9VsK9xdEamFutwp+RelOULy+0S7p2z6AY/SrVv0+Ny
 5eK+4SV8XJMtj3wWlYP0BUH3h2Kowy4TvZiJYXV07SDSUOu9Wn5RvTN3NvNW31Y=
X-Google-Smtp-Source: AGHT+IFdrT5PLvhnee8iZFeyKgqhrJ1F84VNaO3C/Bug8xkg+qs65rzzYkn1qhzbSVF1sD8J2DiMSg==
X-Received: by 2002:a81:b61e:0:b0:5ff:e530:eebd with SMTP id
 u30-20020a81b61e000000b005ffe530eebdmr4518566ywh.19.1706579649269; 
 Mon, 29 Jan 2024 17:54:09 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 x124-20020a81a082000000b005ff93c11cf5sm2881712ywg.100.2024.01.29.17.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 17:54:08 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, sjg@chromium.org, agust@denx.de, 
 bmeng.cn@gmail.com, msuchanek@suse.de, rasmus.villemoes@prevas.dk, 
 yangshiji66@outlook.com, Devarsh Thakkar <devarsht@ti.com>
Cc: praneeth@ti.com, nm@ti.com, vigneshr@ti.com, a-bhatia1@ti.com, 
 j-luthra@ti.com, nsekhar@ti.com, n-jain1@ti.com
In-Reply-To: <20231205155523.721784-1-devarsht@ti.com>
References: <20231205155523.721784-1-devarsht@ti.com>
Subject: Re: [PATCH v5 0/8] Move framebuffer reservation for SPL to RAM end
Message-Id: <170657964805.1823400.17091676308604702164.b4-ty@konsulko.com>
Date: Mon, 29 Jan 2024 20:54:08 -0500
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

On Tue, 05 Dec 2023 21:25:15 +0530, Devarsh Thakkar wrote:

> Move video memory reservation for SPL at end of RAM so that it does
> not interefere with reservations for next stage so that the next stage
> need not have holes in between for passed regions and instead it can
> maintain continuity in reservations.
> 
> Also catch the bloblist before starting reservations to avoid the same
> problem.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


