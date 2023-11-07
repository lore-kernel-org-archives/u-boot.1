Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD5DC4167B
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 23:34:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F07787608;
	Wed,  8 Nov 2023 00:34:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mY00cQbb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60ED28760E; Wed,  8 Nov 2023 00:34:24 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7918C875FC
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 00:34:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-66d09b6d007so43541926d6.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 15:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699400057; x=1700004857; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aP5+xUuJLb9w/vzn2HlUJbCVZzLDVtxh4WZYo2y4EE4=;
 b=mY00cQbbzjCo4Zrh1GKx6Y1n22j1UXXgpu+LT595MxnNVXnGwTOfP2xDR2Q2TDKCZD
 T1VJVqHwo1P0o9zI4TpzhZtJd2gT4jcH1OM51p2hiLt65XJRi+UbpAAqfG6BAbMFv7uI
 HkmUaX9854Ut2vqbs+bDcboDzFg/VoKuAWvek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699400057; x=1700004857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aP5+xUuJLb9w/vzn2HlUJbCVZzLDVtxh4WZYo2y4EE4=;
 b=AobCjByZ5bjvDe3RB2KhlEyDK/EctiMht9zQofX5ZqDSWfQMeUc+O9Q7/EeqOEXqSo
 gq+SJH6/jjG6Har/ct1PRsMItj17T7fygYVrw4MdXaUji93KrqiSi+v6K/K7YptdATmo
 BawYqlCBNncwxWP+CKjas1UF7BpyTZkFnsYYL00uowZ6BSHLP4Lwuk/LWor87OfTAg2d
 K8bbnuLsKSh/9NbADDPfHFuj9nXe7dRxr4JrL81yydbFX6WO2ABNqPOkukBsbWXNdOsr
 vhg8FJM8pCu5d7uIyGMbrm9THTNSuBVJZyAvv8Qxq1O+TC/Sjh8OVLcCkEf8BKAp3+2j
 84uQ==
X-Gm-Message-State: AOJu0Yzim5tqgeRszeXCuDrKjBLbSKWcUwyLT4HdZo4x1WIkZQH/2NNz
 YyNVxdPeUVGzxgnzKDJNsxOPKOKSAlTCCFaXnYXhdg==
X-Google-Smtp-Source: AGHT+IFN7mZ0QzlcYWnaP6Oz+d82MDcpkYRf8psK9m9EJUQ4saYOtwQkS2P3bBt0ZwinbXc5NyS9rQ==
X-Received: by 2002:a05:6214:482:b0:66d:2680:5a98 with SMTP id
 pt2-20020a056214048200b0066d26805a98mr313660qvb.41.1699400056937; 
 Tue, 07 Nov 2023 15:34:16 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-5409-8f3c-5603-0314.res6.spectrum.com.
 [2603:6081:7b00:6400:5409:8f3c:5603:314])
 by smtp.gmail.com with ESMTPSA id
 u14-20020a0cc48e000000b0065d0d0c752csm406745qvi.116.2023.11.07.15.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 15:34:16 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Angelo Dureghello <angelo@kernel-space.org>
Subject: Re: [PATCH 01/20] m68k: Remove CONFIG_FSLDMAFEC
Date: Tue,  7 Nov 2023 18:34:15 -0500
Message-Id: <169939997992.690013.2529695997497811606.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101162824.3755579-1-trini@konsulko.com>
References: <20231101162824.3755579-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Wed, 01 Nov 2023 12:28:05 -0400, Tom Rini wrote:

> There are no platforms which enable this feature, so remove it.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom

