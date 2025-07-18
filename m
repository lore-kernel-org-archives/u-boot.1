Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23CFC83F17
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 19:43:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A5AA836B2;
	Fri, 18 Jul 2025 21:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EOSRsllh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C4C783642; Fri, 18 Jul 2025 21:43:30 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 543A883642
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 21:43:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-73e810dc01aso853671a34.0
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 12:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752867807; x=1753472607; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l17vNZ5cfszrY/Ih1d+bPS6R4TIlN2CILj20NFs1hQA=;
 b=EOSRsllhJgpFTZL2CpHvK9nU2K7KXNdVt8S4UodOE7klRMJuKhqftc/eN9hgTei9Ki
 M1xzDV8ysan+IK9wDm+dxTsBE7ugcGdgsVSdqVLZXJ983+pQifyyLvErbyy9QmvwQO7v
 BqxCEW5976huHkwOYaumbD3piJunNt47zpHDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752867807; x=1753472607;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l17vNZ5cfszrY/Ih1d+bPS6R4TIlN2CILj20NFs1hQA=;
 b=uwtOewz8iOkhIm8xKTxlh3gI1rZIbumbVTG0UHiNfRkk9yMLJZbT6pEyoeig+TOvV9
 Hvzh9nyHYaoDRdseYC986+rZT2cv8Cp90lz+Rritf8BPdA/AFEiNoPV3FbNnR+cZiDmi
 Ao9zc1cusg1lV+WR05tRHEkl0g32bkj05Y7UzaEYonhxFxlyMnlXZrt5k1GYSVCpQwlR
 dgb6G/B5jJXAaYFyGck2Jr4BNc2wOEfhUOp/gk98fzkEMlr2bxfdbro2XAtzxtjkmLWT
 4Pjq74ezkZVihGUlfMKtXAbNfZI5e94T3XaWyH6MINt+LhGF0/hy7X1kpLTmI9AbX9Qo
 i9dw==
X-Gm-Message-State: AOJu0YwJdUL1rPxTNK4VWLHtRI0cRzNpg5bod2PWDNBufOt9eyBxFZhp
 WWKWMi/sIpzzMXQL/zQC00L6OjSCi7jWzz2GfJ/rgdx1Fhk329G+qRgavA3VpKTz5JxgRJa9zWx
 o1l3Jxqk=
X-Gm-Gg: ASbGnctPfV9k2n2iN1lRJW3BI3vDp+emz1TUM8BisDn7RWHMVZl/ZKg33j78jic70eT
 RxHsLY+GBJVap9PgpUiXVwb3oPyLC9WHvvqvlpJ2DPAO/aTkFWgtmZdwo0GUV4ehASn3NhwrnZZ
 PCZF5I0I2L4/A0QIkwhGHxj2SvlsjqgRpDbb3U6x4tNmu7OXj3yV9Wywsl2OIdNdFAM3NtcKeRT
 ewVvNP8Gz/nfT8x21OV4sZkjwFcT0N/TDxya5dVmvf2v7P9BUXQUENQxwFXdyy/QYz8PZwYxWH9
 +BYZZNjdLz0y3/+ccrhxUuwrWqfb6hWcVe/m0Cabgj/zgQTjL6ZdkvxxJG4G96jyJyJwUXFLwCW
 jyUGnJz09Nv+DumS+y7hmyMu3f8/75njVGKe+KN/zNEvF76cYVeAowng0xqDZ6obtaw==
X-Google-Smtp-Source: AGHT+IF8m1EprziuliGCd/PejhUuhluQnWBpJMj/tIsLaZaV7Qv/xvdR0GyNnf0ZFS1h8S9LeN62oQ==
X-Received: by 2002:a05:6830:4d95:b0:73e:9023:8577 with SMTP id
 46e09a7af769-73e90238664mr916120a34.4.1752867807047; 
 Fri, 18 Jul 2025 12:43:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e83b0be4csm871076a34.39.2025.07.18.12.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 12:43:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250711152022.2225526-1-trini@konsulko.com>
References: <20250711152022.2225526-1-trini@konsulko.com>
Subject: Re: [PATCH] drivers: misc: Remove pca9551_led driver
Message-Id: <175286780617.1647311.5045624449293320963.b4-ty@konsulko.com>
Date: Fri, 18 Jul 2025 13:43:26 -0600
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

On Fri, 11 Jul 2025 09:20:22 -0600, Tom Rini wrote:

> This driver has not been converted to DM_I2C and the last platform that
> used it was removed as well. Remove the driver.
> 
> 

Applied to u-boot/master, thanks!

[1/1] drivers: misc: Remove pca9551_led driver
      commit: bdf443ffd54f401eea278c4f49cb99e9f63d7d0e
-- 
Tom


