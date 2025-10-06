Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91503CCA471
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 15:20:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9013F83D8B;
	Mon,  6 Oct 2025 17:20:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xmfVC9Nc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85BB883DC7; Mon,  6 Oct 2025 17:20:03 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B830A83C98
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 17:20:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e2c3b6d4cso41270165e9.3
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 08:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759764000; x=1760368800; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QmlO+1aUe1x5jvl/quZ0nctsRYz5aaoMdmFTbp2e5FI=;
 b=xmfVC9Ncvu4WG54xqSwxWN8lLZ1lIEzAqI+4cp98UPOV8hEyOQH8/AAl+dLeXGN1VQ
 4VIYDJfljg7UOZZwEELAso0KnC7xLh8mu5P+wIMqWAN2OtAsRjjB50H9dHkS4Y9J2ztf
 OD/9O6umkTYN7TjC6uRc4UmcZO3uZvhD9t7gOkHMDTAqqefuMa7mtyVD8wQ/QgeGcDxN
 ZgsFdfNJI8X3E3T7w+QCc75JIBjC8AKdZe7P7a6TDgJGhWATjSuGOT0eMS1O+MoPBBDD
 Y+1YM6Yag8AaW1JIs3l/1134E4nmH8xRoBExlvHEonYqWWNhVkshbeBdz1mthg9Tgr3+
 QyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759764000; x=1760368800;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QmlO+1aUe1x5jvl/quZ0nctsRYz5aaoMdmFTbp2e5FI=;
 b=pMk1Wl14BrADFMd86ogxwnuEzf4+VoKaLw5h06U/PFsn3BTyqkS9YA3XY05cffv3rv
 RMWlStAOnmiU3nIC4ynfSHcSbkF9kPhhUrDy7bb//2c8T6w3CdGeVv90DlcVJGCU1DdS
 KS0ZYRhLyA59uhLgtYSP8wSTEyl5Wb8KPaZPRTmB3eYqeqoGKXUwRmgqZV3EI2mxJVGO
 9bXV+e3TIkv/7hUCQGZ4JsIfcIknmYJ7irXqTaY5+jx3B0QwSXOf6mOSp94iZpzAh9Jp
 Q8X17F2lJHiMXVj9gUKBPaf7sPv6kF81h9eZh2LpU6IYg8YGuJ3wBq2cQIkXnJOwhJ31
 ch1g==
X-Gm-Message-State: AOJu0YwkydYiXU/xCLdzSwfQ/8iJlOa7t/QdEc4wRHqZH45GBnYJPrXi
 vnLB7wQgDFQWHWw6HiZizFjaaD6pwz6bg4ATGFGDm53iGlQMPzRaJVbPjvyN6k17AsE=
X-Gm-Gg: ASbGncv0U/45PTDCC6q7UdMz+U3RflIFf1Prul6h9+rVL00MV1/x/N8V+UjTP27U1QS
 /TUp1bOtKDkTXuNro7BM6kXaLlt2bAX+xftlqPe9Eb2SPdxBb6dRMWsfGNWOZPTugllkvv0pZPe
 /bgu5HReKvzpc4PL/MfRS8BZ410kKoshbQfnoAirxUjBias0Y7WiURBvXQpegPzVtm8LflernTu
 3qcCWC1BQqhEo4R8hO0heteTKPGusi9c0seaWI+8kvVbatqMlo69nrPDe2rhTu+hLqu5xquaTKU
 Af0ZI2wvQqMC38l0OUvrNhrw7T21AJ9dQyt2tDju11yZJ0vpWOAm48DXdYR/TujWgNwgGxjrNsx
 pkjJ1p56Ehczaezud++uqo7HcNZ00qWFHpgTSdRL40dhXqPpyn3zERJ2jsJcn2wBOw3pRNoOvSE
 lZK07iV/MXETI8
X-Google-Smtp-Source: AGHT+IEAOTTzNkKmPaBMncz++P0o4S/0YJ8hHu8DMqQlmBfv+KmRDW/DG7gAPKDPjIsnFH4CaWXclg==
X-Received: by 2002:a05:600c:154e:b0:46e:6042:4667 with SMTP id
 5b1f17b1804b1-46e71153b78mr86764425e9.33.1759764000162; 
 Mon, 06 Oct 2025 08:20:00 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:d8c:ebdc:373e:b4a0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8b0068sm21304971f8f.26.2025.10.06.08.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 08:19:59 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/3] ti_sci: Address some issues found by Smatch
Date: Mon, 06 Oct 2025 16:19:58 +0100
Message-Id: <20251006-ti_sci-v1-0-9cef92e1022d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB7e42gC/x2NQQqEMAwAvyI5W6iFIuxXZFmSGNcc7C6JiCD+3
 epxmIE5wMVUHF7NASabuv5Kha5tgGcsXwk6VoYUU459ymHVj7OGnjhnpsgjIdSY0CWQYeH5zhf
 0VewWf5NJ9+cwvM/zAkLyjrhxAAAA
X-Change-ID: 20250725-ti_sci-7bc55cb0cdba
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Neha Malcom Francis <n-francis@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Moteen Shah <m-shah@ti.com>, 
 Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
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

Prevent a memory leak from a non-freed malloc.
Return an error code on an error path.
Assign a value to a pointer before it is dereferenced.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (3):
      ti_sci: Prevent memory leak
      ti_sci: Provide error code on error exit
      ti_sci: Pointer is never assigned to

 drivers/firmware/ti_sci.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)
---
base-commit: c280c4f7e52f08255f491783b3143a3be1fc08b0
change-id: 20250725-ti_sci-7bc55cb0cdba

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

