Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37383C021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 17:39:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8200F80FC2;
	Fri, 21 Feb 2025 18:38:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F/jsExA8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EEB480FDA; Fri, 21 Feb 2025 18:38:20 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD40680F6F
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 18:38:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22100006bc8so43673335ad.0
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 09:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740159496; x=1740764296; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q9qaDBql5uyRVITmsBtaoyltgbCLdb69gSO/+wWxeNI=;
 b=F/jsExA8KFSSNiII3QWLHUQq/PBa1MiQTKkf9K2cc/hHDAlWmNDnl/gQnbKI4YjYaM
 I1Sg1dZ5+4gK+6FwkXP9pFhNXNOexQpBSaW/bs+4LWF7A8z3SXziwuNfUPd50gQQ+pkQ
 IEMeHtH4D/11kY1BFBwjyDl+g1it4fnbuz0B4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740159496; x=1740764296;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q9qaDBql5uyRVITmsBtaoyltgbCLdb69gSO/+wWxeNI=;
 b=SIcLglzTneW3Ad9ddpRfaVkAhYKR924odFEl9nfdp3pjsRjDsquLPH3i63WtRZtAOR
 okMLYRUNdhw3m7sy7FUsLlNE2n72ijGcqJcHU/xMbhPIi3gx/s7VekujSxYw9HHxVpHf
 9PoinXb0ZH0I1RV3g0EaGu7qQiwNj4fRMq0xOrkc+NGW7fw5Wc0700Yp7CMqc1nS6vPl
 N8E874Ww+xzjmcjWnRwBAFlf7dKcITy1TrsWhFiUh/PvBufklxSUEfOvX1AqhMOMcP9W
 3myI+KDXLsoxWNdn/1WV2r2ZtW4tEot2Mmig+hsgUYUdE5VXZ1eWW+0+Wp1S+QQnD/XK
 TtNw==
X-Gm-Message-State: AOJu0YysMlmr5h7DJyIJpAD+RBTQ6mjm1XcLVtuc4SY4F1+5n6zSfSF+
 xgBJDPD4Men3VNxWIeBDiIAKvqs2Uk5TjzeWZIdNQ7v63CazMb11OQP6SAddKj24b3SFtY71mW8
 RcWw=
X-Gm-Gg: ASbGncu+cuXQDVVzUP1JWJ4HoH0FRND/Ov+we84cSEOeCHX0V3bOQGs8ojv+08ywyvL
 +tRMDyZ5cwV7l/9dVovweYbiVHpst3kK3gLoyizfg1CdkcImthABxyNGMbNxmc0tb5RjtKR+yYg
 ElAnFONttuI3lJA4SAwcHl63BfV8szCKtmFM/IssM+3HAx8a+E26ek2DHWa6cohdK9xePKA5tJ9
 /rQmNsPFskotNJp3tiL6PKpZk/nNJk4dARaK6RCEa2jvZxw+X7j2KXqtl+4+mQLmSByO6675tea
 naAgfz6DfE4bSG13rxV257k=
X-Google-Smtp-Source: AGHT+IHxvCugSemQ3qCd6gH2dQt937wge/nEcaPMf+P2xluMAsgW00FW2L0+NbyPCqSnWKmwlYi3TA==
X-Received: by 2002:a05:6a21:3995:b0:1ee:c7c8:c96 with SMTP id
 adf61e73a8af0-1eef3da4d9cmr6778881637.26.1740159495481; 
 Fri, 21 Feb 2025 09:38:15 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adec4756d0csm8792554a12.55.2025.02.21.09.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 09:38:15 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250212222317.684370-1-trini@konsulko.com>
References: <20250212222317.684370-1-trini@konsulko.com>
Subject: Re: [PATCH] tools/patman: Don't call a non-existent suite
Message-Id: <174015949456.3526942.2408700730825610167.b4-ty@konsulko.com>
Date: Fri, 21 Feb 2025 11:38:14 -0600
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

On Wed, 12 Feb 2025 16:23:17 -0600, Tom Rini wrote:

> With a newer pylint we get a warning that gitutil.RunTests does not
> exist, so remove the line.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


