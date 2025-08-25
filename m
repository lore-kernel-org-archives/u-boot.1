Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104BFCA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 14:16:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D7D883071;
	Mon, 25 Aug 2025 16:16:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ftgllJZm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA1EA8307F; Mon, 25 Aug 2025 16:16:03 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C84C58304F
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 16:16:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-61ddbc4264cso339840eaf.0
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 07:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756131359; x=1756736159; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5q1nEe/l/w+e6jZU9X+Ed2XP46q2FPL1EJM2UgU6NIM=;
 b=ftgllJZmrS9rlFtU+mZU1YXI1ThiiTBJucE6GuAPJ9pvOCPN1TX+gXvvc/3kfG4Rgs
 twns/VKnvzj5so4L8xsT41hiShvNsuu00mDDoestBXVU9bvZUwlDw4S0skkvf2dteiHs
 GmIs/P0Swnp5dv1evUHNSctMpw+WsmU7cx67w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756131359; x=1756736159;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5q1nEe/l/w+e6jZU9X+Ed2XP46q2FPL1EJM2UgU6NIM=;
 b=GORnaU7li864NOY/RdZrXQEN7ymg1ZNv9vqbuJsIR5EDPdgq62KJD+IMvJ0ntKp8k0
 7FuG4HIzR21qrmruksyUjhdfh7FiyUovvmajanIAwOxZIwNK1jvHtpWZDTKi9+/YBaFx
 AUYPY8hq/p0FXtMugGj4bISakm7/Ins7f8O0c0SO9gos8EnWgl1q/bgHGT9z6LMINArN
 l1c6x1FndRndoNG/A9OC2OMvw7ADvBFUb5O+24rE+Plhbpzp1da8+0NyrhlE2RwGTka6
 av1xVXINJzwhoES6lgE7THVPpS9H2pCPOToGT7Pv0nQ5jjhEy1dJGFAyxBsbqin0nUNj
 982w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrPSBiR5L5aVYgtLWDj1CgxSNOcSA3LE/E/PJSRcux4pS3pY4XJNcZfhBV5+PVM+CYMLIgUEM=@lists.denx.de
X-Gm-Message-State: AOJu0Yzh3Ey2EjwjoOeaTwHdKEzGPIVflNZ44kIHxzXIKpGcH0liaSBp
 /ekCMCyPW5M30gqYGHpGlKLmcCIRUe4E6V88j2No+r4+gEy5ZlEsUSfqZS/hba+OiXhQ5TXDrOv
 bS0Cc9f0=
X-Gm-Gg: ASbGncv+fvZo98eFMD3c5ifO1Zlvm5NEJq6isCGmsSC4/rBbqd4WwhUOfEpj7VbtvXM
 IY86FztO5DUSc00Lx1cdphZMkMULzU86UzeO9hP0R9lXNrzeJYw6yAIX+x2VqGm1ZnZrf6n0bvI
 KoB81ZjsFB1tydhPQikBw9Z/sJKp1FevftNqNvoDyzhRsrb0X5slSO5i2AHln5KeQz+TwixukC+
 R3tMLuKcUg82y1tvnQSqqgs/25doa13ZC31O7jojjk0tlyvbl9sjrOfzx7uExiqg/CZnBiCDOy2
 mUgwERtOOvpbTOeUcsKLSJQe9VareKAAjoVUr9Tv8t28k8z2qj4Nh3XP0TMTa4TqsX/7lhSmVnq
 tiiQbwFoS6eoW7lxIInXKTyRwhJEJOFphG6ob6osjWYKGCbXKrxUZbFE=
X-Google-Smtp-Source: AGHT+IEhXEadJM/vOqEYsOhbE6gBrQTV2xFqzNUKP/5lhLggOKcG0TCmRr9nGAeHjzHlvpp1InxV5A==
X-Received: by 2002:a05:6808:23ce:b0:433:f8ac:2eca with SMTP id
 5614622812f47-43785238250mr5381685b6e.27.1756131359380; 
 Mon, 25 Aug 2025 07:15:59 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-437a7a83d6bsm550437b6e.20.2025.08.25.07.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 07:15:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 U-Boot-Denx <u-boot@lists.denx.de>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
In-Reply-To: <CAOf5uwn3zo=yXVc=04Y2hcFZaEv2UTkPUN4SpPx9LeJ8DTx_Vw@mail.gmail.com>
References: <CAOf5uwn3zo=yXVc=04Y2hcFZaEv2UTkPUN4SpPx9LeJ8DTx_Vw@mail.gmail.com>
Subject: Re: Pull request for u-boot-nand-23082025
Message-Id: <175613135861.1523777.12146464856191148666.b4-ty@konsulko.com>
Date: Mon, 25 Aug 2025 08:15:58 -0600
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

On Sun, 24 Aug 2025 12:36:27 +0200, Michael Nazzareno Trimarchi wrote:

> The following changes since commit 94e690c44a03959c39f0f5a44a9b89c851af3b60:
> 
>   Merge patch series "bootstd: rauc: Fix segfault when scanning device with
> unsupported layout" (2025-08-21 15:05:15 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-nand-flash.git
> u-boot-nand-23082025
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


