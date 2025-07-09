Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F181C83F10
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 23:19:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8A358366C;
	Thu, 10 Jul 2025 01:19:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P6Iddj7k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C043835CB; Thu, 10 Jul 2025 01:19:05 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ED04835C3
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 01:19:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-73a4c557d47so181528a34.3
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 16:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752103142; x=1752707942; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W1czvfRhowI1mk88bdqinU+cDF92sGMIeWVpIpYy6iQ=;
 b=P6Iddj7ktvMNxcMuIFPkcEr5T7eAZLLgBo/nW9s5JhO9Dfx60stcG77bT24GfpLYsN
 227LxKrgcS1hjUOX/C73+NDrF2mw2zseh6FU4cdj2KpffS/chvCsQhd9sffflMXTlCs6
 DMxKx/TA0mVQ6jJWdk5qVF1YdM/vVNUDXubKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752103142; x=1752707942;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W1czvfRhowI1mk88bdqinU+cDF92sGMIeWVpIpYy6iQ=;
 b=k/iuT/qi4LCHTEpKRs5IFAJJCKHfqp9jSR+k32zRyog3L5RJ3DDQY8nSzmV8b2lp6C
 ++Tl8t/g11P1fhiU3FPjndGF8O+GgjCNfThYD/eXP+8AqhjtV+COW1L4GGUC63gAp8Gf
 0j6tM+doB5ModfLIvyMrqb+K4JMgE+VB4U9f/XQxHtwXZWq5DfdJJtpv04IAX438HRJw
 WfLUZRmq3MO30fchtsrCr+8OLaVr3PAEtPShcUZvF1B56d9erKzOmtL7/1eYOoVARSw6
 knnIXuhiplOwe/oIxu2iOsMEVsgvKctD3pc1pNl97eStxtDiQfyv5D4xzuSaHLdtwEqy
 RsgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0041CbSy3hA2GjQZ9zQwJQ2MSBlKqeDPPTXnc2mCREkXwnexYbw6poYVFuoKvWcwsCIdo8h0=@lists.denx.de
X-Gm-Message-State: AOJu0YwDF2Uv/sOrldPkCn9SQRdyTcVGPuaZ0gZQ6B/BypYt/ITblITn
 CBbQ/BbBMrybRE1wDZzg7DZ4eZ8dVJ3VLCuvrWArjtrxLJ10zNouv/WFSB9eVjFy3I5vwrXogE1
 8rUQTBhA=
X-Gm-Gg: ASbGncsBNkPeB8B5jj1rYOnYgxpHFW6t+3HCjL3iQGBeLTVAHbdyx9YaQJpBGJNX+oj
 HqBq2/e7VkvNr12VMoOJm+9hyWRonOhl3phjrKd8cMGQmymom0clTSm+4KFyeU20DG5Z0pKVqwH
 5zdglbo32FGkwFLbjsYnPjaD1CFd+iw3KmfAnVTctqrdDr7zSzecdiBpeqZl7q0ZtrAapuc0xv0
 shEVKBEIX62zOrJmaCilBysPrfNcWqmOtAKNziid1/gbuktI+J3SNbLiRKNtSpMmBDwV1t/0Qhk
 oXNj8lc9zFi6Fx3fhpdjTuc9vLX5Wr2gi5Lw/GxN2kg61gJ3C3A7CE5sHuXUaGOw4eYIIAXsmYl
 PPhPi2/BLgx1hgs/GcoE=
X-Google-Smtp-Source: AGHT+IE9dJ8yoqATEmebU6Mb4wxM75/IryQF2GcCTib3SgpwOGhnQYJC2qkJjkeuF/j8J0JRdvbzmQ==
X-Received: by 2002:a05:6830:4c98:b0:73c:aceb:fcc4 with SMTP id
 46e09a7af769-73ce60a5e8emr1926881a34.1.1752103142178; 
 Wed, 09 Jul 2025 16:19:02 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf127258dsm33211a34.34.2025.07.09.16.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 16:19:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Janne Grunau <j@jannau.net>, u-boot@lists.denx.de
In-Reply-To: <20250708121251.83980-1-heinrich.schuchardt@canonical.com>
References: <20250708121251.83980-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] lmb: add missing fallthrough in lmb_alloc_mem()
Message-Id: <175210314058.1870480.10384737080771715356.b4-ty@konsulko.com>
Date: Wed, 09 Jul 2025 17:19:00 -0600
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

On Tue, 08 Jul 2025 14:12:51 +0200, Heinrich Schuchardt wrote:

> Add fallthrough to clarify the intent.
> 
> 

Applied to u-boot/master, thanks!

[1/1] lmb: add missing fallthrough in lmb_alloc_mem()
      commit: 344e1798059ba65769272be3145736685bb25a7e
-- 
Tom


