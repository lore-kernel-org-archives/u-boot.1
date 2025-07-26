Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFC0C87FCA
	for <u-boot@archiver.kernel.org>; Sat, 26 Jul 2025 15:20:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25E5C830C0;
	Sat, 26 Jul 2025 17:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X4+HuPeb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CBB683087; Sat, 26 Jul 2025 17:20:41 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AE178309D
 for <u-boot@lists.denx.de>; Sat, 26 Jul 2025 17:20:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-40a4de175a3so1818464b6e.0
 for <u-boot@lists.denx.de>; Sat, 26 Jul 2025 08:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753543238; x=1754148038; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ss5hXoy52/L5iXK07gZQQLvMSWrgoE5Y/acCVGw1Mdg=;
 b=X4+HuPebLnzG2po42VbatsUcF0rE+0N7tZl/rO/9GaU4fPIms8Ojt34K5ZNKB1p2zY
 EXRLUl6aN+50FdjiC5DtKvTt4ch3Edv4TWe27XZ6FA5K9NCzMUiRfX2t/MD+/BP5m3UE
 6YqyVppJc8HG+VVUsqSAsJ84O3nL4Dt+sc+K8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753543238; x=1754148038;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ss5hXoy52/L5iXK07gZQQLvMSWrgoE5Y/acCVGw1Mdg=;
 b=WApofPR/wezqa3dgyoa7M+TWvcnijn+JSzkO/44ZscJbCo1mLu05qDqfqYDdb2Tf8K
 zNKUfysuBeTHaL6EdrSLARyupzRkD3NJ9YUckNGfKADm8Ubn38pWXX66xQLcXqZtAnfS
 qhq5E9z/7q+j3faG0dk8GhC6bca9SO6H9ag2cPkRHyehLO26Ejmd/Hpq0WARRRtd5IfZ
 hLuHe1ZW1AZ6zoELeOlvmXWn1uAPgnWgJWhEoMhD+JgO/lGMDItEO1dREnVw6wVBIIhk
 Y+/pbO6xYQKPulNmX2viStPCvEAXzpYTkHOKec+vQ0AVMH5+u1lbc5r1APKH6qZLzzmB
 tn5A==
X-Gm-Message-State: AOJu0YysxVVMWveiAAC6tvjZ1Mp8naHrzKZGD588CKMJnBoEH8ngna7p
 2NoBWosfYG//LrfYKl87lZhtRZXI+10bsLSdlMT+XTJIyuN2dhbZpb7VqCPYWrSwLF2B+6jWGKH
 MxvOg3+4=
X-Gm-Gg: ASbGncvkgFyZxw1FLdxj5p0HDYaWhB5/z2KbH/UNtBn52zZ5afwIeYYY+keugQ87D6e
 THDl4sqk8Hz6vXNb0We6SzJeQk3Uj4ugr20i4k6/iUgsq1R0fyJeQzojlhG+O6zouMBGuCStebT
 I94RHnYobD/NNwjWXBkzpK/vVZIG4PXgO2tCgVtE/X1cY05DHZkcIzbpfvfW2kDMsshr4X7YYUu
 7ZEsSad82vXSbxI1FnP5V5Bk6mI0Y0BkUjQroOqfh7u/9CYBQULoLaEpR71fLSAy6MdwAyFSBHp
 zO1g0EyG2FAhjH3/Ma8vzc+D5GP1vGwOuLEIBXddvWetR1XOYCFlsGrElhF8Cg86PELCgFlGQnS
 M9uUIHxDYGkQxjycGQugNRoVD5lwuXqkiwWIYjYAH01rEvaz1IZMprug=
X-Google-Smtp-Source: AGHT+IGMdz4EXXykBeLJXFDdI/yH7WrNHzgSEnWWAZRCSsg0tWCRLCrSX+JzCQhjwdewN0YswjWULw==
X-Received: by 2002:a05:6808:1889:b0:40d:f3d:cef7 with SMTP id
 5614622812f47-42bb71f53d5mr3836341b6e.4.1753543238139; 
 Sat, 26 Jul 2025 08:20:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-42c7b93cb45sm353388b6e.18.2025.07.26.08.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Jul 2025 08:20:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250725190432.4152488-1-trini@konsulko.com>
References: <20250725190432.4152488-1-trini@konsulko.com>
Subject: Re: [PATCH] Docker, CI: Update to latest Ubuntu and Dockerfile
Message-Id: <175354323694.77109.5596187087358287405.b4-ty@konsulko.com>
Date: Sat, 26 Jul 2025 09:20:36 -0600
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

On Fri, 25 Jul 2025 13:04:32 -0600, Tom Rini wrote:

> - Update to Ubuntu "Jammy" 20250714 tag
> - Update to current Dockerfile which brings us QEMU 10.0.2 and newer
>   coreboot and pulls in lz4 via the non-legacy package name.
> 
> 

Applied to u-boot/master, thanks!

[1/1] Docker, CI: Update to latest Ubuntu and Dockerfile
      commit: 1d782a3f229c269d01e5b7a94744bcd7f53e3f47
-- 
Tom


