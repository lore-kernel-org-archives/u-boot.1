Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498C0C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 03:41:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFDEC885A5;
	Thu, 18 Apr 2024 05:40:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VgbTOwKq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6A818855E; Thu, 18 Apr 2024 05:40:17 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C00398856A
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 05:40:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-78efd1a0022so26857185a.3
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 20:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713411614; x=1714016414; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9zZcgaPmxfIRV8u6aXl3Jomw6FWM0BTWTEgBvG3usQ0=;
 b=VgbTOwKq8sDUixIfYAZ+yYEytCkXtxDFw5stY0zLahgxGmjtgbtix9QKv7ZMLOsEse
 6PYz6e0wl/yCRqZzm2NDeIiT8gjzNcjt8J9qP4FXVsK9++1imzezxzRuw3mPYmp+zmJc
 ozDiI72goC4stJqGQDbILlWt4WwNF3UMhvYi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713411614; x=1714016414;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9zZcgaPmxfIRV8u6aXl3Jomw6FWM0BTWTEgBvG3usQ0=;
 b=L8K1FQPr5fsGWbPJdRL3M7wztd0h9utaEKLYd/dy0t11GLd68sDTRSSqXtMwvxaX/h
 yzlpFhrnRVo/jFsy5WEs7TnLZXPwVJfRHeZPBzvikKMCiAWSML1FkOaVnmXo9ifljpm9
 m0eJyIqNYXD9ez4OyXMztOh4QRWosu1cxIOSEUfAETRiW94szfnCL8S1Nrgp312TSWXl
 MR+hPysquOhdCdijcWtA29/mrxUJAMYjaurq9/gz1I1k0TAmrhVezkUwTbw3FQrIUhuy
 f9PnA81eL+Uvx5PXeFKRnUp1XAySJx/kewVWhU00W8MAxVLHiL+HzaUQitwDhbDa9nOP
 q06g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQmg4UbbCexFSX9V5QWq0zCodSJqbZDMfcteBlG//VdQfvHd2CPma8sHrrBnMVDlHjPaDvcQumkRpJpB+PJm3IVPB7TA==
X-Gm-Message-State: AOJu0YyWIGpBuMrat0yRobn17iA8ETPJjeTPihChbPhxU+IIAuW08UIv
 HNCunad5RUp1IowLeqw8wza9aPYNotXu4NVNm8p6zY5q8V5WmfXJUqfK41KrNZg=
X-Google-Smtp-Source: AGHT+IHy9VBhAc0+eN2uZ2O27DFPrwPn2nDtYZ5DPuEJewF+HTI9yJ4yiG3/HCemS23zCYbeZbkycA==
X-Received: by 2002:a05:620a:2441:b0:78a:5eb3:8e3d with SMTP id
 h1-20020a05620a244100b0078a5eb38e3dmr1577619qkn.8.1713411614740; 
 Wed, 17 Apr 2024 20:40:14 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 du33-20020a05620a47e100b0078d68b23254sm259041qkb.107.2024.04.17.20.40.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 20:40:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 u-boot@lists.denx.de
In-Reply-To: <20240409200607.61893-1-heinrich.schuchardt@canonical.com>
References: <20240409200607.61893-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] fs: fat: fill creation and change date
Message-Id: <171341161379.1250683.5055928110041752164.b4-ty@konsulko.com>
Date: Wed, 17 Apr 2024 21:40:13 -0600
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

On Tue, 09 Apr 2024 22:06:07 +0200, Heinrich Schuchardt wrote:

> The FAT specification requires that the change date is set.
> 
> If a DM RTC device exists, set the creation and change date to the current
> date when updating the directory entry. Otherwise use the date 2020-01-01.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


