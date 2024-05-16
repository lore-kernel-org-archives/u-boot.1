Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482FCC25B78
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 11:29:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9E9887F4E;
	Thu, 16 May 2024 13:29:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="As7a4h3M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F40F687C40; Thu, 16 May 2024 13:29:36 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB857880DB
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 13:29:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-420160f8f52so29903395e9.0
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 04:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715858972; x=1716463772;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AEW4G8dp1QWvRrc1c5yBNuu/H5FUPgZ1Na4gyLHAIZw=;
 b=As7a4h3MIBA8VDRxdcz8xNZ1D+iifamiocxUBdILxExXLRioIBZWn2Rbhz174/S9dz
 wBwXmDp0Mfs0FcbUM/RE+x2jeWSQWo026Y+LPh4y8/b3OzAUiMWyr/KcM5cTMEQqZXNk
 OXJr8BO3RGUqAhfZ5NyjzdmbTPcN7jlAASKV+B0zMZExlWTrTFmTfDZukJe37M3jzU5X
 Cri1lURxUW7ewyRs2XSttSPnVIbtR2o5VmCmtxaRm+e2ZgSVHNSRGpDv7oRxEtAsZsza
 Bvl7VW33W8ASBtrQJPguLqkDhkK6lN6nEGlj4lHOXXvLM0KJ3vXi9CXRv9A3t/7FNOtF
 IFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715858972; x=1716463772;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AEW4G8dp1QWvRrc1c5yBNuu/H5FUPgZ1Na4gyLHAIZw=;
 b=PbIErvdcL975rw5d2O7u+S3K4uoLWCkMCL0TDFuc3NgNNiWxswrG00E3G84JlEAT8K
 pkShqWBgT6wXQpo8fR9RREYIAxfYUSoTVLbxJ3CO7rnid3ZNigWG71DTxokQepi2X9Ul
 i5gHpihuBJqJHGXT8fbqHVL7i25KyReD4NB5GrQ7laLcPMfzCf28WA9g2zJ7qQHZeV3r
 fYqymug32ikuKJO0As91y9UULukYuF31ye/eGeiL9GbAWrEgtQme/kpUChwLA/rHr9re
 07GhSFPO/2DAtJ1qsGL4Lq/PEprbooqJX+Q8LSBI2wpfpk39qw6V3rkIAkguGh5fkZkH
 /omw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKYOyIdvPIAXUsmDqr9aip7yWVe3nTtRMxHnt/c2c4iW4r4L1toL0rpDe0PC7sMH+xErLNlV5EgSZD3vebH1o9UGz1sA==
X-Gm-Message-State: AOJu0YxqyUEbPGknwPagiPLLdCvx/rGKxV4EV+Byu83NOYzMVRvf/Mys
 mfMQTUztAtrg0sS4M/or8leicBkfkNUKk/GbYm42/3Z6gYzOxtIlP0dfIsPYc5o=
X-Google-Smtp-Source: AGHT+IGuePtjdYe9KuKAol/4FAmnKZeoAOQMFGupU0wbLo9GBhx/Q9VKqiYBsIz04zO8s7zBeVKZFA==
X-Received: by 2002:a05:600c:5487:b0:41b:851a:af43 with SMTP id
 5b1f17b1804b1-41feaa38f9dmr125595365e9.11.1715858972116; 
 Thu, 16 May 2024 04:29:32 -0700 (PDT)
Received: from mkorpershoek-xps13.carmes.etincelle-coworking.com
 ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42013bf1a5dsm161083235e9.30.2024.05.16.04.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 04:29:31 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de
In-Reply-To: <20240516-gadget-maintainer-v2-0-23cc916df434@baylibre.com>
References: <20240516-gadget-maintainer-v2-0-23cc916df434@baylibre.com>
Subject: Re: [v2][PATCH 0/2] MAINTAINERS: updates for fastboot and USB gadget
Message-Id: <171585897146.292604.17310788084977868073.b4-ty@baylibre.com>
Date: Thu, 16 May 2024 13:29:31 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
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

Hi,

On Thu, 16 May 2024 11:15:40 +0200, Mattijs Korpershoek wrote:
> I've noticed that I'm missing quite some USB gadget patches such as [1]
> since I'm not always cc'ed.
> 
> With Marek, we agreed on the following split:
> - I take care of USB gadget side
> - Marek handles the rest
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/2] MAINTAINERS: add tree link for fastboot
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/5738a44f88d65c2847ad204e6ba9f4a5f12f7d4e
[2/2] MAINTAINERS: add USB gadget regex to u-boot-dfu tree
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/efbc11ccef89030ed54b7368458eeaf9ec687c77

--
Mattijs
