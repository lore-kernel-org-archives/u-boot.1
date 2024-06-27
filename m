Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C199AC27C4F
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 01:19:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC7D8883D9;
	Thu, 27 Jun 2024 03:19:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nu87DsS9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25E1F884DD; Thu, 27 Jun 2024 03:19:06 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD14C883D9
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 03:19:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3d561d685e7so802208b6e.1
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 18:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719451142; x=1720055942; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V1JsaFQL95UNAW6x/g/L2VjSc3kaxQrE/TEzLqUZtjc=;
 b=nu87DsS9SZ11MK2NAbk06Rj0dXXq/utd98XhHbZr99/dAjQDunb1mBFp15OalyY+Vg
 2y+k3SOPLLtZ62wXYzHbN2ycIp5VtHhsR3emssqgHlVWlGqN63UQxnFCo1ExTisQIFSv
 PjjcDuVZ7dgR2Xh3wONAHOpXJT6+WTJl2HW7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719451142; x=1720055942;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V1JsaFQL95UNAW6x/g/L2VjSc3kaxQrE/TEzLqUZtjc=;
 b=wmOtYh8ixqKMvD5AHtRJvEfKQu5q0UUefsENnHo2RQ6QBRmFpyxEPx6vUtuxgSV368
 +WAMPhlnrj2d/g9UATGs//tFQ+ULOdQyOw9yPuOUVmSQQuheB50eukFjhP7Q2LJqBJOy
 MKwr58Gn/f7Lkci5FpCMi2T3Q1WADIYPvfly1/O/CXhCcaSTfArLJ0tCPJmxzCV02Yq0
 96ua5xsdFphHKDvXwOP6u1NVyRQOuBFdFp/2Tj2bszzOs5XguWGs0d66JChqf5kmNv/+
 OfrndzMAnriWF9kwPHY/yrXYCITkKJ8Qe3OHT8pjUeU3793RCNB0ErEs1zhaKwQvdttO
 B7/w==
X-Gm-Message-State: AOJu0YxacdUPBQMcatvanxWAr949SCiuZRFHxyWZVaHNwL3LxnTs3FCG
 QBkZDWLjZ9dS1bkJ7iBRBf4pohITau5u4ihzHyfGDVLBao8nk87UPHY3hC7jI98=
X-Google-Smtp-Source: AGHT+IFs6k8sQvRyct4hNOMykT18xcWzfmCnhuZpNwMrgvGm99HW1sEnA4NnMjznJ2h/4YGysofPiQ==
X-Received: by 2002:a05:6808:1596:b0:3d2:20e2:3690 with SMTP id
 5614622812f47-3d545a543e3mr14317499b6e.44.1719451142645; 
 Wed, 26 Jun 2024 18:19:02 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d56779f68fsm78240b6e.39.2024.06.26.18.19.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 18:19:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Paul Menzel <paulepanter@mailbox.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, Marek Vasut <marex@denx.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>
In-Reply-To: <20240619123453.720600-1-sjg@chromium.org>
References: <20240619123453.720600-1-sjg@chromium.org>
Subject: Re: [PATCH 1/3] pxe: Add debugging for booting
Message-Id: <171945114145.3478677.13570700547612365560.b4-ty@konsulko.com>
Date: Wed, 26 Jun 2024 19:19:01 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 19 Jun 2024 06:34:50 -0600, Simon Glass wrote:

> Show which boot protocol is being used.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


