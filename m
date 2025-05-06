Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDCEC3ABBE
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 22:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 838F88007D;
	Wed,  7 May 2025 00:03:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sBJjnRS7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24C3682114; Wed,  7 May 2025 00:03:02 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08BB88056A
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 00:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2d0364e9231so1843027fac.1
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 15:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746568979; x=1747173779; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1kwEU3RWWcJwnHrl2keAmRu/uDV8yDTKADZjZC2s1cw=;
 b=sBJjnRS74V71+z3usjKD8Rc4C9Y/NDScZsP7nLlVJtwaa8fQTS3PeTGGeX30CXZNCy
 ASvK8p4wGXCAQY+/sz+eYc5w6FABNa8Q9ZTs+u2aCwy5u5V55uGHQdckH9qgosEo/tjZ
 IFwC7UDySsu0w8PNBm88bUDmf/dVo9K+O7bvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746568979; x=1747173779;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1kwEU3RWWcJwnHrl2keAmRu/uDV8yDTKADZjZC2s1cw=;
 b=qb3Op0ty0BdrcJnrW6Q0xnh1H+/PhROyOX7079wnqacAt3QQi8wEn1+hd+sDTtuXEW
 TAUMF/XoRLkYDhMBv2ghTUQfnBlsH3qFiezxE+CS/oSd7IpaTaCghikGjHLngLzax4Gy
 QdU3LHPxoHrFlx3wSQ6zp3RMDN7aUjRRUERg1hB9bslFqG8cIUARLiSaV21fcvUAWljf
 p6p0yylv5O39gH+h3ogomSgQca9uXBR2LfeKXSUTc5+AemKAkYUvzhBW6ThpiNT/+Z4o
 ZL6ZIKDX0naJcoAcnLSOYhAvimJ0sbU5NMgoTyiPeSv+/R6kByxswy87TncRT8O1FCCe
 7BUQ==
X-Gm-Message-State: AOJu0YzCQtER7k5yHjKiSD94Mi3epuQZOH2Cc2Sz6qmszfD6eF6h8cfz
 /2nk/RrXu3nrwXaq+TqxEpDusr4DpDUBw37wl4n6e2HP8HVAnSoVG3L73p6XHyc=
X-Gm-Gg: ASbGncugyCZm+3DdKskQGzYysclCML5Ezi4qjUnMHwE1Xyqg2bK4vXvJOuA0pLoROv/
 hAJczBl2HLgkaZkysbAJyfTacJDEAIRoNA709TFXIEYNCJwJR3Z+eVw3PBlH+iOaXQ+0Chz9gZP
 6fOdDLL5eBJ/GfJI5V8SDHssaqDnVAmYHaowucn1AeRjln4grYsTNpM59wIe1Q9PSAL+RxxKjXv
 pxYz55CMtyeH+oy8ajMX7+RpjTVKg66wvdvazgEYWhObB/HBn8Cy5vHmuQnRW8ko5Qnw0u5M0xb
 Jz9i3I3NWrm3PfvcwX6twqtugPfzECymGzVWapq1tngIi52Lr71Dilv5b/l/SbcZsHLCOA/VDWZ
 Z
X-Google-Smtp-Source: AGHT+IFcnprp/iNBHDYOElRunnN3ss/ehs7uTO4YqhqPAaBZA/Po9Lu5VSigEqCpDbZYHJZbrvtTJw==
X-Received: by 2002:a05:6870:898a:b0:2d9:9c91:ccde with SMTP id
 586e51a60fabf-2db5beb0d3bmr574899fac.22.1746568978588; 
 Tue, 06 May 2025 15:02:58 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73210a1b343sm143796a34.39.2025.05.06.15.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 15:02:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: michal.simek@amd.com, jagan@amarulasolutions.com, vigneshr@ti.com, 
 u-kumar1@ti.com, seanga2@gmail.com, sjg@chromium.org, 
 william.zhang@broadcom.com, stefan_b@posteo.net, quentin.schulz@cherry.de, 
 git@amd.com, Casey Connolly <casey.connolly@linaro.org>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>
In-Reply-To: <20241119063918.12540-1-venkatesh.abbarapu@amd.com>
References: <20241119063918.12540-1-venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH] mtd: spi-nor: Send write disable cmd after every write
 enable
Message-Id: <174656897733.280764.6288967960874458663.b4-ty@konsulko.com>
Date: Tue, 06 May 2025 16:02:57 -0600
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

On Tue, 19 Nov 2024 12:09:18 +0530, Venkatesh Yadav Abbarapu wrote:

> Write enable(06h) command will be sent to a flash device to
> set the write enable latch bit before every program, erase,
> write command. After that write disable command (04h) needs
> to be sent to clear the write enable latch.
> 
> This write_disable() is missing at the majority of the places
> in the driver, add it to clear write enable latch.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] mtd: spi-nor: Send write disable cmd after every write enable
      commit: 46b3580c59466563bd26aa6aec1f15a8adf5dd5f
-- 
Tom


