Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB053D3B7D2
	for <u-boot@archiver.kernel.org>; Sat,  6 Dec 2025 14:12:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB90983A97;
	Sat,  6 Dec 2025 15:11:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NjKLc0tX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F3B883979; Sat,  6 Dec 2025 15:11:07 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED61883A5E
 for <u-boot@lists.denx.de>; Sat,  6 Dec 2025 15:11:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c71cca8fc2so2338676a34.1
 for <u-boot@lists.denx.de>; Sat, 06 Dec 2025 06:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765030260; x=1765635060; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7IRGyQ7rJ41TMoNUTMhhO+v9eYcyX6gNplR4Z7A/O7M=;
 b=NjKLc0tX55c2iSzdr5slbHCarJUfihASrpY2T/GypDU9cMoZu0fusG67Ept41qysJa
 22QARU80/xeM6rWkg35yOiNFCOzwkc5w8/LfyvvCxUvMEQfXAKg/HASSYJ7JdsIHmVVL
 4TTjrwyqp8BCF7gKmPGB2sYzKqJSBAlvqnPZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765030260; x=1765635060;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7IRGyQ7rJ41TMoNUTMhhO+v9eYcyX6gNplR4Z7A/O7M=;
 b=Zu8fJA5Ei3ZA2cT3Sq9gQI5bqoqDGTy/ryOMj3NusLhCIVifnmcF5IivTKpdXyHFYs
 GTdbJuRipxI4eL/UU1l6v1S+1ifW1zT+ffbrUtho4MqX3v7XHFSiN+o3x4owhIw+Af4c
 xJltCFkGi7oGaH5K1hlREvL+hcrToDUCcr5Qx8TzRSeQLNwOBoy168UKXKs+sDaY3W9A
 Y493FO7IpdhzW9qP2aTGAN4hLeZoy5o/Skrihohs02NdsmNr+rH8rqNW16gYb4Hb1NnZ
 9Ogplw78rJ2bY1KaycgJ+ewJdagTIAbwWrJRxCrKZ6how75+xakC9mReb7yrXjl0bCxe
 M9tg==
X-Gm-Message-State: AOJu0Ywpf0cBwHS3r/0PYLT2/Li3QrdBTso0doPCyXfkNgZVotcXkkAk
 bxL6QGZQpBqgNB72wlS7/mGFmnIyW9TDd8ICZ0n6f57AdfojX7OFOyPKcSYCI0xlRLflhcPDAI2
 opsirfhI=
X-Gm-Gg: ASbGnctKLmCWZV1SeLvtfBFUkVucTqekHmYkCuZsxtsuIqt09VW/Qox9czlgPYEOur8
 mdMIP/YXTxrIqNjiITFB/JxbAXsq6jn7E21LBkcX2WddNTvzjF4MqsM5BoTNtOIG4Ur0nk2fOnT
 BhNk3zhx5ckvduOOkTufO6KdgEBPPfhzdw4FIgzzpyeVYQNcVeVSqntVmFCJPNvqTuRkXZDo+ZP
 n7I0ksGkIZm+ahV5WBi3S74scSy3VP33ZRS6Z6IKmpDzi9xJn94mgRihOB61sAGaX+U+YPTKovK
 S5wWwW1qnwcPZgH5LlRdpDzVr1BDIAcgYCPqLwWILeA69oiejhTLJLQ4F7/NRNBaKFCYcYyDou1
 DDU05rVY5x1ll5Y4/Z33j+He/etoCYYSymvqy48XmxS0FVp+w/ckQ8QR2+ynw+vB1FFB74+4Npv
 w/JgUQlRYVtVK+61BkgDDAQWlq5O9yvx0EvlLlumv1l9urquCI
X-Google-Smtp-Source: AGHT+IHMYDtnXu32x7Yl8FcoDLCP+fktmuyTms98t4m5IhQEFrg+0bbtClpKHiUP/T9sucZlGVexmQ==
X-Received: by 2002:a05:6830:4426:b0:7c6:cd24:6392 with SMTP id
 46e09a7af769-7c9708356f1mr1102945a34.34.1765030259739; 
 Sat, 06 Dec 2025 06:10:59 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acd733bsm6078499a34.26.2025.12.06.06.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 06:10:59 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Cibil Pankiras <cibil.pankiras@egym.com>
In-Reply-To: <20251120133201.263725-1-cibil.pankiras@egym.com>
References: <20251120133201.263725-1-cibil.pankiras@egym.com>
Subject: Re: [PATCH] reboot-mode: Correct macro name from U_BOOT_DEVICE to
 U_BOOT_DRVINFO
Message-Id: <176503025911.2523567.1417375560205861843.b4-ty@konsulko.com>
Date: Sat, 06 Dec 2025 08:10:59 -0600
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

On Thu, 20 Nov 2025 14:32:00 +0100, Cibil Pankiras wrote:

> The macro U_BOOT_DEVICE has been renamed to U_BOOT_DRVINFO.
> This patch updates the reference in reboot-mode-gpio.h.
> 
> 

Applied to u-boot/next, thanks!

[1/1] reboot-mode: Correct macro name from U_BOOT_DEVICE to U_BOOT_DRVINFO
      commit: 1165e8efcba0ab3efd1ea4ff956d26746fc386b0
-- 
Tom


