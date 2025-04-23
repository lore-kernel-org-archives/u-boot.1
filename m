Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8698DC369D3
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 17:34:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A024B807AE;
	Wed, 23 Apr 2025 19:34:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gYCBqPXr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A999809A5; Wed, 23 Apr 2025 19:34:13 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25708805D7
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 19:34:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-72c1425fbfcso132220a34.3
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 10:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745429650; x=1746034450; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=An8H+l+vpRfCp4H4WBicQ06BebH6zMZdOumNOovH4/Q=;
 b=gYCBqPXrArseOxedzWKc2C0gVgTC0iPcqspfndeY+duRJssvRO5IK+EcV4xRxL5yje
 tXOD36wS3yYHBjRFlUrNl6zDcTeL/gVPEI5pqW1JTx3NNrYlsmIIeC0cCNRMpNoLHIZq
 4zo0lVUhVm5kPWCt+X3vShKmJ57miOy/rpPlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745429650; x=1746034450;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=An8H+l+vpRfCp4H4WBicQ06BebH6zMZdOumNOovH4/Q=;
 b=StAl29IupR5IQpEUiLEBPhRUnlDyYmtN0BIg9MwgriVDvIEVkYrMostaZlZzmCZdYC
 0+JyFM13QE1aLQZ7KSk7tAjhum5x7wpM2rldK+42MhXA4LhYyoIfzKXdnQ/08ZvkmBGE
 BbdxKUWR06YS13AgtrSoJdO8EinuCFiwidIBEE0FtXEZxYUGGbHieCR7HkULsHNtKg68
 y6pt84cwyQ48NFgfnQDqeQgMWjJYNWXalA3S1nroYZ625ZS3e5S5eQ4x73ToCUii9pQH
 U61Q2j/m3B0d/C1nsljnE9D8oj3y1Dr04UcnTr0lGyhfYAfKal9+hcpnFYXLkcvOfD9N
 TrKw==
X-Gm-Message-State: AOJu0YzihtNcmJ/TuhtxoX2CdeKbhdOCpXgvWilqxhYrPLKu24J5mFep
 fnFM6mksWnxtTPVeV/ORLzpIUypRD2dnLvIJSOipFSlNBIKVS4tuC2aXc7814sZtqsHi3b2VUp/
 ells=
X-Gm-Gg: ASbGnctPL0/+0Wm2BwUQNqdQ2ZoA9d4UJ1YPxdjJ9gWk4KRq0xfsmeXcFhdHPO98Olv
 J25y6y5+TETxnIHknaGwHVQ6Bxgn/Ecgrl+EZrB/gCRn0ZW9lF7kdQS9PXA1CllRfBCW/ML2YGj
 X4uKAsmPtwmsWEN0TOTB2SWCw1Kxl7tDWNjprBgdQbDqWwovCjWNR+/YxWeFh+0S0efUnQQNlM6
 Wsa82JlmjUYR/FGbn1syqodLC+btCZp9QhvXATuotWzOVRpMiY/hSehjJt/rmPoklHLcH2C6O6z
 jqnUu2I2/+bSr7UG80GTpPkRFEuheoRjdrsgEBEHy5QXqQC/HinWIBQ4rmbThYVHtB4vWyqJxd9
 7iQk2CBd3NPQ=
X-Google-Smtp-Source: AGHT+IHthxh4opY56yjNxYl6smGKzMZ9HiiW36SpqlaphmwfRkm85jng45gRmOooQF1aIrpdAaw1fA==
X-Received: by 2002:a05:6830:264b:b0:72b:a6f4:de5e with SMTP id
 46e09a7af769-73006333e3dmr14316607a34.26.1745429649977; 
 Wed, 23 Apr 2025 10:34:09 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73004884887sm2572933a34.45.2025.04.23.10.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 10:34:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <cf77132e-2a29-4d9d-98a8-a7c5c65fee5e@linaro.org>
References: <cf77132e-2a29-4d9d-98a8-a7c5c65fee5e@linaro.org>
Subject: Re: Please pull net-20250423
Message-Id: <174542964907.3933035.15100251652099147381.b4-ty@konsulko.com>
Date: Wed, 23 Apr 2025 11:34:09 -0600
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

On Wed, 23 Apr 2025 10:58:04 +0200, Jerome Forissier wrote:

> The following changes since commit 4446bc331c65d3efb8a9321d6368c61edb56479b:
> 
>   mips: mt7688: gardena-smart-gateway: Increase CONFIG_SYS_BOOTM_LEN (2025-04-22 15:16:11 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-20250423
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


