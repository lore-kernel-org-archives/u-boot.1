Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BB6C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 14:56:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF61588A31;
	Fri, 14 Jun 2024 16:54:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="otMjwHUr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95E32889AA; Fri, 14 Jun 2024 16:54:35 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D97B88A26
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 16:54:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-254a9b89be2so1227671fac.2
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 07:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718376872; x=1718981672; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uxUblZUkdsB0LWGncIITPszvlueHYEJIhYM6vpACkEE=;
 b=otMjwHUr8of4UxoC0NGnZl2YBp/fhf+xNUts8IdyIg3r5r4sR5r10ZBq53shD6qQPW
 xRmb6qhWTCaYYf3zgEC00iI0ksICmGBetoHPKcTozF4WMYMVGzU6EIT2C2vsj/tJuwRN
 G0JPzpNdWrszqsiznyIo4GVy5dbsbEkUuNPJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718376872; x=1718981672;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uxUblZUkdsB0LWGncIITPszvlueHYEJIhYM6vpACkEE=;
 b=pu9kpzsF+nGbKYscI7LjCQgpEeWhIPRQxGHyi5WErEloJzcoBUPBxLxYEWi3/nEPVM
 UoOjLLT6CgDIoGWUKIk2498obMJ3x2LIiEh02VsLt6hhQ3DWH1C3UIMF8eP50el3erSg
 EJx9ZVqctfjH+my35EMbsYozObbRzKwWNsdVZrwOmeGTNbXz2YqzsEgaC2z2vz6S0MC7
 2qbsDPPYdmKkuDEmTYjASySS3mFAnjI7/xZ6hIbYiR6Ozeu4bJb2MK+qcruwxu1UZJQW
 nAwRQ7lThq2HffLGIxTNq/ntKcuYFnCLuvDiT5Q9qehvVOLiPaTq05fUBQrWQO2DLJtb
 EIKw==
X-Gm-Message-State: AOJu0YwiiFVSCiMOAcICeitqFt7TLXEz7iSH1X5uzMsSNZsAlQBx1Ncg
 eNA5CQY6s5Ss+fx0NBucKW4KK0fz0Buw6k3HRC+pzQd97Zdjg0nwXmMU2SmK40E=
X-Google-Smtp-Source: AGHT+IEdruEIDqHt1ekB7YH0kz57V8kch2YQ2AnnCpFPVxdtE6mDOMGYiecBkyoLmjQkdf7AuiwMsw==
X-Received: by 2002:a05:6870:418c:b0:23d:225a:9443 with SMTP id
 586e51a60fabf-25842b7a95dmr3063753fac.41.1718376870788; 
 Fri, 14 Jun 2024 07:54:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2567aa2fbe8sm986898fac.28.2024.06.14.07.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 07:54:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Love Kumar <love.kumar@amd.com>
Cc: michal.simek@amd.com, git@xilinx.com
In-Reply-To: <53549cdc5fc6c144f83ade47e159a3830f05e575.1717580941.git.love.kumar@amd.com>
References: <53549cdc5fc6c144f83ade47e159a3830f05e575.1717580941.git.love.kumar@amd.com>
Subject: Re: [PATCH v7] test/py: net_boot: Add test cases for net boot
Message-Id: <171837687019.2655592.8091224532388046580.b4-ty@konsulko.com>
Date: Fri, 14 Jun 2024 08:54:30 -0600
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

On Wed, 05 Jun 2024 15:19:35 +0530, Love Kumar wrote:

> Add tests for booting image using tftpboot/pxe boot commands, tftpboot
> boot case loads the FIT image into DDR and boots using bootm command
> whereas pxe boot cases downloads the pxe configuration file from the
> TFTP server and interprets it to boot the images mentioned in the pxe
> configurations file.
> This test relies on boardenv_* containing configuration values including
> the parameter 'pattern'. tftpboot/pxe boot cases boots the Linux till the
> boot log pattern value is matched. For example, if the parameter
> 'pattern' is defined as 'login:', it will boot till login prompt.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


