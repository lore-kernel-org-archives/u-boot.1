Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA594C3601A
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 19:51:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC32B82C49;
	Sun,  6 Apr 2025 21:50:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c17yfcuO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A75D82C0C; Sun,  6 Apr 2025 21:50:56 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D46482BCD
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 21:50:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-601e3f2cee1so1807471eaf.2
 for <u-boot@lists.denx.de>; Sun, 06 Apr 2025 12:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743969053; x=1744573853; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3EnjZ1sXBQfgRA9XpqVcyX7MEtgwrtAnIRB7M7863co=;
 b=c17yfcuOTpXZnphGVGSk2tDdxrIcVBuN9c6fcGqNyL+bbzHtlZscMX93O6qFJsLVxZ
 9e5bxIS1I50SciF3mnZHBpn0OdaJqZZOi3X4K1Eg70jrF8ypltXIjJA2xkmD55Hx8181
 snG2ZN4I6xFFn8TCoU1we4i4zUgPFY4FwyVqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743969053; x=1744573853;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3EnjZ1sXBQfgRA9XpqVcyX7MEtgwrtAnIRB7M7863co=;
 b=NH9FqhrFXdBiSBkou/Z0PbXx7jLHaLLKz+k7wxIrnPw2aouDWT/OsP1Yt0b/scJ1wj
 W4qS6h7cFX9oDzFgsRVmof8Amw41IjdnXQSp0ERXGwXZZ2Lusia/BD0YffGkx0NL6G5A
 A/+BpZceod/+qsIzJj4qc+y1TrgXe2EyAFyiAesceLQH49glQnwcSjxY0zBwJCWEd/9c
 NnTkkaxtupwV3rM1an0cwF29OeIDbaRdv2N6hB8VqLWLSzkCEtbKvWY46dNd1UQGo/kn
 HbFa+6NePmm4z7Mi5H4H4R94cIuM+4SSsTQR5EQ2awiIouaYB0mqz+IxQ9gzwXdUvrt3
 KyLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4NgnbouuMqcxs+A1UGFNFUB38dxBBYSm4ncF/g2zWMk9eCT0IJHVIH4SyOCiB46YINc90rUQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4zB7YHisL42+QodWo41OGjJ9840vp6IYCDAt3foSisKqArn5G
 oP43y9mz3zEBhvE7+37iPse5Xvvz4mtNRlWUyhCCY8zcUbH1yD1cNoc3kfeI7R4=
X-Gm-Gg: ASbGnctm0Z3bX2sGP9yYYPcVYdx58gulwkt9z/fbPUb1rONce4/OM11TfNYAAKC3677
 vcZzn+qxxTIeH/9RvhoyjgFc2ORW9lTKHWerLQpcKtE6t61TuiPtTk2YSV3DLXtaLddCB+rOlJG
 kVCAVmlKnbjFNV2cUrAG0vO5bjODvnKFQVKAHGzKiwAytrKZnS7iqTrlJw+iKSWHt+imbMlQD6v
 JPj1PLd+SxtU1t52lCGD/ws52m4xMHjM68czm9P7q7ZKvKM0gMCNKHVkMc/1IYlQriqRAqgiHJn
 yug6vMLiJ+sF60mNmxvrqzX6GP6Q2IVKxS+3pYfgfXa/TKgmhjybMFKqyX4Cg+2u71a5GqWhQKl
 py6BlJXqrBwrzQCg=
X-Google-Smtp-Source: AGHT+IF0jQ2JgYy+0j60F1O2577DqxRvEuyAZfdGz6mEhhOW5zpzIdgitoWHAfd+TROTbyibm4sTdw==
X-Received: by 2002:a05:6871:7a2:b0:2c7:6ad3:fe56 with SMTP id
 586e51a60fabf-2cd32ebe099mr3767907fac.15.1743969052700; 
 Sun, 06 Apr 2025 12:50:52 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2cc845cc500sm1703175fac.18.2025.04.06.12.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 12:50:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, xypron.glpk@gmx.de, 
 sjg@chromium.org, u-boot@lists.denx.de, quentin.schulz@cherry.de
In-Reply-To: <20250402215025.2655384-1-heiko@sntech.de>
References: <20250402215025.2655384-1-heiko@sntech.de>
Subject: Re: [PATCH] boot: call dhcp_run in pxe bootmethod
Message-Id: <174396905113.1127672.11718337468369561736.b4-ty@konsulko.com>
Date: Sun, 06 Apr 2025 13:50:51 -0600
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

On Wed, 02 Apr 2025 23:50:25 +0200, Heiko Stuebner wrote:

> A recent change tried to speed up EFI booting by not calling dhcp_run
> from eth_bootdev_hunt() every time. PXE so far relied on that dhcp_run
> call to get an IP address.
> 
> Fix that by adding a dhcp_run call to the pxe bootflow, with autoload
> disabled to only get the ip address and nothing else.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] boot: call dhcp_run in pxe bootmethod
      commit: 1915fdcc21268c0f5df513461e3ddbb03a26f3c5
-- 
Tom


