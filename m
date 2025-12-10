Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C26FD3C92B
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 17:13:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E668283B48;
	Wed, 10 Dec 2025 18:12:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kRoNneQb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 270C183CEA; Wed, 10 Dec 2025 18:12:54 +0100 (CET)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5970A83AEF
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 18:12:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-65b1f030a08so14708eaf.1
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 09:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765386770; x=1765991570; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jd22GJl9JwzJUo1+K7Lsu+hpVcBFtUcq1SzCTRcXFR0=;
 b=kRoNneQbipRZm3OrfNi8mgKf3HhKeRpaky1Dk0mnjn21nDdalDZ45uEx5DpHsRX161
 EdIPTp9ARUfegLuzMhP0Wx5NiLHdHFz1qrHuGy7FkDWtYfsuSzkPCfqCS/rkhtCFcJlD
 LRtSvkZ44sIPMzc6SMuk6cJDtnbgoZ5rrP8VQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765386770; x=1765991570;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jd22GJl9JwzJUo1+K7Lsu+hpVcBFtUcq1SzCTRcXFR0=;
 b=RXK+R0Jdn5YNnovspdf0zUfVYogQMQHq6MIfhsoLS5nBoijD8pMDfnk0Wp5Wf7PDHV
 ME7AMDoXIcJOwM3ERXE0fZv0PgpMJGHKfYBXSJ3ioBAoBQjb9myGVEKsUsNLThVfYlaB
 rRaNe1nRLWyki8hA7CkXRcy+XBSy7hXT0tdM1t3KhShpww+sy6POpViU3clbaO7EwVtU
 mO3YY1+FBZcAN6sFfgk452vt7m0lQHbw2ExMFebJMJSeSMGS3GyEWFlePb0N7jfWTgmA
 HuvDmCUo25nlFj674GidWJpC6XnmgBZbC/D+YR7HYC+Xw7sNw4Pqq8UyvZ4EESRFEyYE
 S6/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsB10W0hgctJrbcGaEz4fIhFcS7sS5NOJ/CxEUqJs8syvx3x+razhJZ0QjkRfiIvtFo8S1BaY=@lists.denx.de
X-Gm-Message-State: AOJu0YwIcX3/avOAF4zbIuFJ1HXgJehZTxFhMJEF2VK5HN0tdbKunCu1
 6cj4HsBiLYj+C+a1K3K3vJdPxxHQJCVzqjvzZNn4zsA/CvFwIhyBztVjWPVVgjmHSXI=
X-Gm-Gg: ASbGncs8TbK+lQ76WhmwZWCPgjBbm/EUHvT1vo2u1+OrIzAMJjcY+wlDHocvA7g6ouw
 GxAobJEatSGx2UAg1hU/6dVkjCc2sNxU/ItBz2wSf98OSj0s3GjII/0EkAxYMyd65oBQnROgG+o
 VqYJH//mqpc1IUo6hIpFt3AXUA46GTnizTyHkDdop361qZBcbU2LrKHDDsdBuEjOwOUlkyjkE76
 Ug8fMvRxNp0SMruPVHHzu8jjyKCVLO6G7gLnw3zZR+wSfXEPI6ql0s5KKlYOLyMiFB/u4GwIJ07
 NOkQFVWWiaqqPZoDS3cvEaegAvxsU+IjsfnoziVtfec8lBxjvdLqeqxttK3ktU9yYbJ92Q2Adlk
 EGXENvxCvY5cdGlnTCWUkRgPyJ8xB/iUeJwmF282hTMvAwScXR3znBtYE9R5VINocxdLi8LUFe1
 yjMlJjki2XE7YsPf8cCpzmQoNDKtcw1X2ULDtrW0Q9Rm1wBKUR
X-Google-Smtp-Source: AGHT+IEHbZhetRK3jHskJeb5cNGa40ejX9vQX7PVmUbUcfnUAtvaWDLeVEOkgUOh7KYCVqKYjuRcVA==
X-Received: by 2002:a05:6820:1ca7:b0:657:71ec:5450 with SMTP id
 006d021491bc7-65b2abf2ebdmr1958859eaf.2.1765386770041; 
 Wed, 10 Dec 2025 09:12:50 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65b3480fb94sm34528eaf.11.2025.12.10.09.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 09:12:49 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Raymond Mao <raymondmaoca@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
In-Reply-To: <20251208204738.62792-1-heinrich.schuchardt@canonical.com>
References: <20251208204738.62792-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH] Makefile: use --output-target instead of --target
Message-Id: <176538676923.3321367.4867156790142837239.b4-ty@konsulko.com>
Date: Wed, 10 Dec 2025 11:12:49 -0600
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

On Mon, 08 Dec 2025 21:47:38 +0100, Heinrich Schuchardt wrote:

> The objcopy man-page teaches:
> 
>     --target=bfdname
>       Use bfdname as the object format for
>       both the input and the output file
> 
> This implies for --target=efi-app-x86_64 that the input file would have
> to be an EFI app.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] Makefile: use --output-target instead of --target
      commit: 7da7ca7cf50f4996493b99198e939726e721906d
-- 
Tom


