Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD97C4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 23:06:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1088889DF;
	Tue, 30 Apr 2024 01:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C2Vzix1y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87B3D889A9; Tue, 30 Apr 2024 01:04:26 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FCE0889B9
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 01:04:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-790ff1fa7b3so89000985a.2
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 16:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714431863; x=1715036663; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CJHqcH0e42ck9PHmLuPUanU2NjsoYcR6jlD3EhSbLtk=;
 b=C2Vzix1yOmyrV3l+kxlFODqV+XazANL+bTzF+TRyZDJ1XY9zdxd2NG3hp6fNDzYNuD
 iTr03r+pIKxKds6nLhcPslAiHtNSq2YoxaCO0XUi1gfWrLEglmXSy21PHBxEyYChNVjA
 o8e4uOhhUQixVpXfcLqHHseFPX/nTT92xjYck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714431863; x=1715036663;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CJHqcH0e42ck9PHmLuPUanU2NjsoYcR6jlD3EhSbLtk=;
 b=Aw8c5fD5ANaj0d+ihGu2OoddQpiETGZCMlvrV0o7IqXcMSSKmXg7kx9P7L/EooiwsD
 4PO+w7xJl9CDBQO2ZFNgVdprH68drmzCAnYwSNLM9zuD2zt/gTmWmI8s69tOPXMg6fKd
 yBed8MSTrkHdbbO+hdJ5sKi2n1VmmtE+/5ik3gcUwkbuOViuTzmODWlXibzIspTpyoEu
 r9SadAxx+BnePRheHCpBMCSw/a6pyI7mTHHjLmz5wAawfh71g1WO0ED1Nr4EIKMiZ3FA
 n/bk8pllMXlUvrcC5isClA0mSD7/FGKhO33qEfYKPX3n3gvtUNSQodjGNZ106SIef9Wz
 bpBw==
X-Gm-Message-State: AOJu0YwBCp3NjJrM/t8OWn/ghaoLi8Qd4nneWGRrMLzpCXbp3h0oUorY
 0fPAnhlwSAyl0R7goZDPoGFxuAoVuvtxMGhgZISeCc4VLf6p/zBfj1HrYgK7fr1BSNemYEYCcT+
 CH2KxCg==
X-Google-Smtp-Source: AGHT+IFfHl1oDzMPha6bJKj1C3PgqcnI+7fsK5CUSJ1Kr6TgDcufmdFFfIKY9GjnEnkUzDIcoxY6qQ==
X-Received: by 2002:a05:620a:10ba:b0:78b:cfdc:b0fc with SMTP id
 h26-20020a05620a10ba00b0078bcfdcb0fcmr8975168qkk.21.1714431862910; 
 Mon, 29 Apr 2024 16:04:22 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 h6-20020a05620a13e600b0078f044ff474sm10967156qkl.35.2024.04.29.16.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 16:04:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Daniel Schultz <d.schultz@phytec.de>
In-Reply-To: <20240419155540.2447006-1-d.schultz@phytec.de>
References: <20240419155540.2447006-1-d.schultz@phytec.de>
Subject: Re: [PATCH 0/5] Update PHYTEC SOM Detection
Message-Id: <171443186216.1749944.4720717716938824007.b4-ty@konsulko.com>
Date: Mon, 29 Apr 2024 17:04:22 -0600
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

On Fri, 19 Apr 2024 08:55:35 -0700, Daniel Schultz wrote:

> This patch series extends PHYTEC's SOM detection by minor
> fixes, a generic helper function and a new valid flag.
> 
> Moreover, it adds a module to provide access to the SOM
> detection for our TI AM6 products.
> 
> Daniel Schultz (3):
>   board: phytec: common: Generic "add extension" function
>   board: phytec: common: Fix eepom is empty check
>   board: phytec: Add SOM detection for AM6x
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


