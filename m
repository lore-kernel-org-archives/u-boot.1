Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A34EC54E65
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 22:49:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27F9F83164;
	Fri, 23 May 2025 00:48:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UBJbWH7s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADB32831D3; Fri, 23 May 2025 00:48:41 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95B40831C3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 00:48:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2da73158006so4731134fac.0
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 15:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747954118; x=1748558918; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIUKu2ZculLqqHW8UX8Nj9w8lf9z2Vw2wkPbS4RVwa0=;
 b=UBJbWH7s6Mp4OnNTMZxDxzjP9pO7EnMpBxcKuLH6achw+8Vet2bq8Xr8rdF0j39Q8p
 skxsAj7rNUVhPTjbHV78cijaLMmCe8RYdi2uV2rM9h+Q3O7ZwH3ss3yqs/h0SHfVnWb6
 R28bCyfLog+H4HcUJS/MsS2Zbhj71bSrncFVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747954118; x=1748558918;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nIUKu2ZculLqqHW8UX8Nj9w8lf9z2Vw2wkPbS4RVwa0=;
 b=bH6naFQRobH98H00B8D3ifcrgYoqI7YorkgV3F6VrV6cB2+1bXLSsUQgUEE1S7GB6H
 RL77sYASkF3bFWfqrMjUBdaY3Wvn/nFCJNvPCJd3UIuFt1zfh0Uh9E05t1e9pTXxHknP
 oU9mIn7bUWMx6xdYIDEhEU+H/Pr2hsBQOO+Fkqr2keepHnRUTMLbgdfTyNKiVIK+gGxt
 ZrS1y9MKCvGS6nAYDdwHwlX8cVdCRTftKTiHkBSPNGfk82Eo+QKnhuoXk0cF3L7ex+To
 bCxaYbVMIVemhRnbI3Cn53x2/0TiYd3GfU1rX2L9QcKuUXxVksi1YnZtPk5cW3XfStHS
 l8dw==
X-Gm-Message-State: AOJu0YxX615x7qrH2FRKac21za44Iou1C/UMdBTcl1bFJNM8ZVjhOvxj
 8iG0FsjQbOb+6IEKyCgtRMhzjRp+IioNbcfIB2GfK/tAPGUUI0SdNuNq3qbppYUjMs8=
X-Gm-Gg: ASbGncvrtSbEbSAeoXUL0+uI5bbMR+iECZrZkernW/K6A1e5EqrN4WzGZivgoKdRTXP
 W77ypWP2V3aN+TJrT+dKD1yalIseLWOlWHxPxWIBsscX83aurxvFZYEEiOBBsBzP6UO1XnJOz8M
 jdC5/MZ98vVMKODSVbzMvqZxvwk/1ZYubtKYo+yyjSU/Yx0TsQ+1ycO9zmFHElu69+fWhk6CV5M
 FhklLW7Ue3clLmvJgruu6ZAi98j5FcYmFfQpzTteXZljmqhYapqaa/2eatTG8kh9yz4gBXI/MxE
 Zem00obQ6Sv1zAiK50gX1TcJTKzQZyzLrjJTAcIv92if+dQSdMQBN7l9PNwMYOMDuRFvGDwZDJl
 +kUkvGe3XbK0=
X-Google-Smtp-Source: AGHT+IHX6GIgSi+46ZFY0ma89V9nNHoZ+rGsEAswhOuaE29ZgGdwZSYO2uTWjq25ooEZ47DsQn6zmA==
X-Received: by 2002:a05:6871:a592:b0:287:471:41eb with SMTP id
 586e51a60fabf-2e844bc0936mr540173fac.6.1747954118357; 
 Thu, 22 May 2025 15:48:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c060af78sm3258534fac.5.2025.05.22.15.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 15:48:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Ben Dooks <ben.dooks@codethink.co.uk>
Cc: nazar.kazakov@codethink.co.uk, javier.jardon@codethink.co.uk
In-Reply-To: <20250507122342.495127-1-ben.dooks@codethink.co.uk>
References: <20250507122342.495127-1-ben.dooks@codethink.co.uk>
Subject: Re: [PATCH] common: add config for board_init() call
Message-Id: <174795411726.2210140.11076289366524597550.b4-ty@konsulko.com>
Date: Thu, 22 May 2025 16:48:37 -0600
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

On Wed, 07 May 2025 13:23:42 +0100, Ben Dooks wrote:

> Add CONFIG_BOARD_INIT to specifu if the board_init() needs calling
> during initcall phase, and default it to 'y' for the relevant
> architectures which probably need it.
> 
> This allows anyone with a board that doesn't need it to just remove
> it from the initcall list w/o an empty code block in the board init
> file.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] common: add config for board_init() call
      commit: 86acdce2ba886153f152b924b28e5c040e316c80
-- 
Tom


