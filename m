Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03570CA1017
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 20:14:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98D488391B;
	Fri,  5 Sep 2025 22:14:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WpHknfCe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2CA48391E; Fri,  5 Sep 2025 22:14:39 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D41D883919
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 22:14:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-31d7119322dso1151021fac.0
 for <u-boot@lists.denx.de>; Fri, 05 Sep 2025 13:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757103276; x=1757708076; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1BDeFzC73ziO1u3Fe+weP9V3p9zkBmZWYt5cJzwU8Wc=;
 b=WpHknfCeI1HWmYN+dCvUUykiQj2wSY7OwFTxWUJh8JrBUnByAhvnzXpzb5z4d4GkJa
 RQsFr9SxQ3JS37fGGsidxQRbnXGHCqDjRloBgLUGcQH4V1psRDwXmjpJsF9ILSGKd1sg
 C5FehcHt4GJViHiHZtrymkcFEhP3RxsVrCkE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757103276; x=1757708076;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1BDeFzC73ziO1u3Fe+weP9V3p9zkBmZWYt5cJzwU8Wc=;
 b=MtNWzNLPPAlwC1DnBKynV5y0ALUMvGWpagcfUxVMwfSUr389OMDZdU5E1SOmP5BC+N
 Wo8d+skxF4Wxwm+F1etke9MboSQJLixutwe/w28mTYcPLakTb8pA997RtjuDuRBp8pmy
 ssvBhcwDyYCbMhsavnKjozHnWbbNLYRqwU+GeIlIE4lOEpdrfCCvk8pmL7KyYUjJpBl5
 RXA/rTtsqnVr9Th0Ik8QhsrfLUHr1dBJ71V7rtUeNvyw76RIsmfHND1X4nBbMA+FWGge
 cdOQN0E0i8ZJo1Rz8PVAn3FRp6UhSgYEnkCONcaStW+YX6eGbmDZLLb+AD1AbsNBJJzV
 XGYw==
X-Gm-Message-State: AOJu0YxGqPZzY+j2DVSJDSEaBw1p6krQVoOqE6WW01UElOD+l9RfuLRc
 2jRoDmnfKIAi3Y7XnRSP14RXaG3RK4In09pAFD0gUAJbtGuMJPO8rA65kH7gB46WpNJqOoppsga
 IdwWRlpU=
X-Gm-Gg: ASbGncuXR1LuMGzeyvkE2xIp0mTVuQ9BlsFxGfZo/ZLJVGytfTvgzIy7Xed7BysuCx3
 AfwJNGiMMJx1y/3Rd146bRw6m0C10CJuIUt5CUZUqy9kvxiqtsZQU83hNQuhJV07oHE/A3AeEV7
 YWfkgbdiPk2U7ntWvWaDyDIop4Te9s+FRQgXsolXQMJ9FY976QpucqNQmXUWWAO6fKYsVoa0hYO
 HAl2y10QPpaPD1G4Lzse09i9U9t/s8Zfad4Iyv//20CtUSheNbgjChZRzfe7UrsXOG+ofxZKg9c
 OrqnnjIuFrfyDz/BmP7nkDv4Xv1sq9bmGSNXam/7v1+sqSGj+kx5KiA4HCnBLxIGS9GURjhkw5+
 WgJXyXOcRC/UWwvjSscJ1SIfxhGamJnvZ2XMVQuSXbxX6BEJJ1E/kV2os97yATDuDOw==
X-Google-Smtp-Source: AGHT+IF/1NFHbD0LtEzo27HmtLRMprGzMRSJiM4XF8Mx0etrr+X4SWyJFl27eoMJAlwqlGP51fSdSQ==
X-Received: by 2002:a05:6871:5884:b0:315:6c17:e881 with SMTP id
 586e51a60fabf-3196334764bmr12050613fac.23.1757103276583; 
 Fri, 05 Sep 2025 13:14:36 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-319b6057f21sm3980007fac.22.2025.09.05.13.14.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 13:14:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250905132708.184530-1-festevam@gmail.com>
References: <20250905132708.184530-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20250905a
Message-Id: <175710327540.3852976.13543674305782582433.b4-ty@konsulko.com>
Date: Fri, 05 Sep 2025 14:14:35 -0600
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

On Fri, 05 Sep 2025 10:27:08 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/next, thanks.
> 
> The following changes since commit e31947724f69faaa6b0ccd2539052781358b0572:
> 
>   Merge patch series "memtest performance improvements" (2025-09-02 14:11:45 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


