Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DA1C77B7F
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 23:50:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E269882E67;
	Tue, 24 Jun 2025 01:49:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Tbf/Osjp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17C8382EA3; Tue, 24 Jun 2025 01:49:43 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2D5382E35
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 01:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a507e88b0aso3999685f8f.1
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 16:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750722579; x=1751327379; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nX358pXq2mSGSiYuNTGdSL1IHxnjF1GL9yM5aTwGNWA=;
 b=Tbf/OsjpwuTcDclTNgRgrtLvV2v4sgdeARJkFomW/h/P1EOig8tDhJkufQcgosV7Gm
 HL4dvak6BmdWAetDVBwLUYUXLRTPqO6fZiBso72kWnubXoRCSZKzF79BkWP+luVYAF8W
 eFw0mNGi/qRMeretRdU3/X2xdU0wtLhvuynVarAcc9vOLZA3FnAQSpE4HRmAuDSr/ns5
 mQvgoAw2qBZlSxFppV/PLnTbzptZ3/IbUljz9L+Ar1muOWhdOCeZ2cAHAnGXHvzyEZ13
 Ul/1upyRyKGB71YwX1iYNzRNGqKui4lWQdEooL2g/wo2hQkV7Pfst5POiZXSSu76Ny1I
 UVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750722579; x=1751327379;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nX358pXq2mSGSiYuNTGdSL1IHxnjF1GL9yM5aTwGNWA=;
 b=Oili7j3TlSTST4P5TUYosxzqdAxLjg0o2RTm+5rjghZ+RwIGQZ1maGaugL8As3Kr2C
 6Iscxrhv2+Al2JQs77X1Hce+CAHU6fidOdKoBtEyGaBquxmTZPsOHjB9lptct6lEqoBq
 Zquy9bCY0uKhuQmA+woqPE1u1+gCM2aihTm4WnZjj3NmYzOiKw10hzJS5Vvqy6rDrWrC
 cYjI3HpOvEB3ZDNH4FjwrYcbrfMyipIKn3aupdNlfZWubAmM0HwRI7ELmaXfwe9tMAPQ
 aTazF+hiplD7re2WOuZ6yjQuN3c+mtvEHPpreo/CZgW/ouH8R/GgOdgZ0/U5wZA9QVaD
 ritQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjz4Wjkq6xMwhj0JcAsH/et/TO87jwS6+aokj8GpFNDHlHxoKjFHHFrgVogpy7EfrN+n36oPQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzINFiAT0sZrIr689ei3ETR8A/EEjLNix6vEFc8cfnfw7wuQIsl
 /4ptpW8zEnMJKF83rPTNBEM8P8DlQrkxfMqMWYWlE0rl08N1bVWFs+1kahNHl/DL+C4=
X-Gm-Gg: ASbGncseYeRfKwHQXBatgIL/zpGGEYfZsmWfiGZzH6KvvBcEIqQb69cijupISr2o0gc
 eiGhqdcYmLBf18nmIwDipb5vQhlKzWhxSmsIC5UZEH1oW1+b4PsTPluNG9GxFwHGd9xLo+oKDIW
 Utvpbdyoqt9EPu6VlQzCveVfHHSh+idTJLZf38JWpSaJl2NbWJJE6wdWQIS3f0eebXh3Kw87LB8
 11en1wlxAiIxgFnwFVP3SzyKHA16YKVHlXknX3jNXqYuV8NfddnIzkTVK5dHrLVv0RUSpXl5GlC
 oYhEFVWMBL6Hsu+y+NUU8IwvL54XaQ6JQn0FzSV67XsRyTsZORXp9Yp4rwt1UYOOU9tSFA5R/AZ
 Rs3xIXD8WB5U=
X-Google-Smtp-Source: AGHT+IFqaBT6KcCI5DXVzjFioqbOQ5kI1OHkAb0F3EWPI7TcSa8Yk5hUwjDaGIhZONUzY/uRmwgdKQ==
X-Received: by 2002:a05:6000:491c:b0:3a4:f7dd:234b with SMTP id
 ffacd0b85a97d-3a6d1164217mr14137942f8f.0.1750722579167; 
 Mon, 23 Jun 2025 16:49:39 -0700 (PDT)
Received: from toyger.tail248178.ts.net ([213.240.182.16])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e7fb5716sm432284f8f.0.2025.06.23.16.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 16:49:38 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: neil.armstrong@linaro.org, trini@konsulko.com, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>
In-Reply-To: <20250516130854.606067-1-sumit.garg@kernel.org>
References: <20250516130854.606067-1-sumit.garg@kernel.org>
Subject: Re: [PATCH] mach-snapdragon: of_fixup: Drop USB dr_mode override
 for RB1/2
Message-Id: <175072257708.128390.13879095705539344766.b4-ty@linaro.org>
Date: Tue, 24 Jun 2025 01:49:37 +0200
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


On Fri, 16 May 2025 18:38:54 +0530, Sumit Garg wrote:
> The default DIP switch configuration on RB1/2 is to enable flashing
> support via USB type-c port either using QDL or fastboot. It's just
> cumbersome to get the host mode working in U-Boot via DIP switch toggle
> when you need the flashing capability using the type-c port.
> 
> So instead lets enable fastboot in U-Boot for RB1/2 boards which is
> more useful in the default board DIP switch configuration. This let's
> us to drop dr_mode DT fixup.
> 
> [...]

Applied, thanks!

[1/1] mach-snapdragon: of_fixup: Drop USB dr_mode override for RB1/2
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/fce945be04b7

Best regards,
-- 
Casey Connolly <casey.connolly@linaro.org>

