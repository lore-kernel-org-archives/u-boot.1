Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CD4CAC5B8
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 21:46:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7838583693;
	Fri, 26 Sep 2025 23:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JhbHd+M3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2E6981E13; Fri, 26 Sep 2025 23:46:30 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C253683653
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 23:46:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-31d6b8be249so2578612fac.0
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 14:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758923187; x=1759527987; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KoSpD9nHKyK3/PLZ0ntsLaiogBXiKGyItlE987/GcH0=;
 b=JhbHd+M3PWtoUFexeUUyRlLQKRxaHeioGkmjrEldeZwwCJ79BAk/la4SEyl5S++i4Q
 VmUUCt7wxUQn9dT4xAFc5ULFq+F/ybPUvBtrQJ2gS5ClVkCBI4JKmIMy4nnjfu3D27yy
 oO4nPFkYBoE4ui9ifY+ObtzZEcBm/xfNDVt0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758923187; x=1759527987;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KoSpD9nHKyK3/PLZ0ntsLaiogBXiKGyItlE987/GcH0=;
 b=pRgqKUuWXmU4KPCMui5HusH+J+txoZtPeVZGdqd91voItyfHMBrsYWwzgefA8icgkY
 +Vcsw8oRf5rLswC1aMo0Mgo/5CDPWGIVcw+IxmfDAyHPzUPvQ+BOfWlu6Te7i2CRf2st
 LybhV21A6DCPatloctCTmq8PvlgxUVQ4M5SzfjNSMl2HOpwjLuAKzOKI26dL3JzzXPQp
 WUTH54AR2rgTrCekDe9SYjaieUJHXI5G2k/t+a08Y1J/Ia6EgpF/YGAU5oTaaQQFkh29
 Aev1cq2Ouii9n8H4R8dpNBMVFtH74uNBZtbL62HcczIj+Lrj5wSbd3uuwMc8p//YkEHg
 7e3A==
X-Gm-Message-State: AOJu0YzUPSewyljR+h/UJpk6t1cgCckGrYUK+uAjh474+6BhihTUktk7
 5lqIR7t6AzT4ZcdlqTljKClVB+eEae/TPM4SSaQHdGDE1Wu0nbktKvi7ELAiqXBCerU=
X-Gm-Gg: ASbGncvlp8Y/B0YCuthsgDw55Wn3U1HykNojCEfIQ++5SE45WjleGyWnrqWynwVUDQd
 CfyadeOzWDqXRYPZq37wamk1RV6EHkrYdR3YXMlV+/KDupELGvI7O9ombTU/x93CBzg4jg3Q3Vn
 e5w+a9tVWoj+3QmkWj2HyqpOIU98oPCw9KO6qPf66OQ0GY1OeLRbSWiDiDuZ2P5VNsMVdhaMe5O
 AXEBHUZ9S7ZTAZ3+56zqWf9WJLnd91OOjQX6oWh2OFGwFgdtv4BCCqN1x36vpYNo0BM9cUjU6ew
 YryFyPyVHpto5ZXkVtd0AG50gRkbD/9aCHbUzRDKGsGTP+TyAgB0hkVyc++WQiKaQFGhjmXcoK6
 Lb9oRKVecqSFTimvi4FuObEuaGMR8zybz79ycHgr0TfdABVnpxZyxQTWiVNzygFptGA==
X-Google-Smtp-Source: AGHT+IGpMWca2IChUykPDMlcyS/i89mkTHKxQs2/PvRufmIyJdjMGu+m/22I/3+FqUS36K6Ka3g09Q==
X-Received: by 2002:a05:6870:55d0:b0:347:1e45:9d68 with SMTP id
 586e51a60fabf-35eed5f6a56mr5204315fac.32.1758923187457; 
 Fri, 26 Sep 2025 14:46:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-363b51636b4sm1720585fac.32.2025.09.26.14.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 14:46:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250926170943.846750-1-festevam@gmail.com>
References: <20250926170943.846750-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20250926
Message-Id: <175892318624.3792987.6460388074894418180.b4-ty@konsulko.com>
Date: Fri, 26 Sep 2025 15:46:26 -0600
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

On Fri, 26 Sep 2025 14:09:43 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/next, thanks.
> 
> The following changes since commit 44c4919e9dd6c162b237633ba689441eca9a149c:
> 
>   test: Fix optee unit test (2025-09-24 11:04:11 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


