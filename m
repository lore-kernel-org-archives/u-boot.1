Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F2BCA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 19:07:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B089F82DA1;
	Mon, 25 Aug 2025 21:07:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j0sa1rSr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C48483096; Mon, 25 Aug 2025 21:07:27 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1138282C84
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 21:07:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-314bccf2472so1556110fac.3
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 12:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756148844; x=1756753644; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EK9vBTlTRF8SG4RINeib+5wVV8s3VgiMWZ2OLylLqHU=;
 b=j0sa1rSreMEVN0dj5b0WhtDtvxHZ53kG+QeRNc2pwCdVnkMh0KKj166SQS35nOU56I
 r/pnEbS/hS7rGD7mHitkLpWBkZ8YZYwxgpK9ZJor2Jei3DmGkF1aTEF2HrtDBAXkVg4I
 WjucMfHMVfRXgIUqcgB9FeWQqihY17uAGCKxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756148844; x=1756753644;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EK9vBTlTRF8SG4RINeib+5wVV8s3VgiMWZ2OLylLqHU=;
 b=K9XGDMSeUm03e7vMTKbKmlzyqUgUn4TdKO4+SC/dq9ArwUgxUsWL0RQ9WTvcIAe3zg
 vKMjz3D7u7vKOFi8dUJOC3weKy4S8cDxIZBUDmtd/FtOGcrRq+lu/+Oxz6/CI+2jFKF1
 N7miQq3zC0GGSNA0xGjJjzd0CDfVRqG+Ab3Q6U3qGhde7VG1tooIPxBn/x3ls4blD8j6
 2LWPkPUYttYIAkZaRgE380mPY2+ZDKmsUTiBb8YKSv/1xPu5iHoe/MI+Eymv+sswtTnP
 n1VF0GgvtQmTYmhqysN5unJFjPgNl/gTosTfEZ7gWtrKayTxy/6QA2Cun+iKFP+N7N0d
 8PRQ==
X-Gm-Message-State: AOJu0YxqmHezDjzShVIPr54iipousBUPPxZ9LJ3x1PtL6K3F/BLdQbmM
 dpikfEYkrjipbMsKQHZHyXB5hx03OhMlRE10Frp/qrymjEzhCpheK/03pnYNeiNxEGI=
X-Gm-Gg: ASbGncunc86fOUZyJe4CYFzTOMHvma1aOS14xpmQvT5c9782dLxURr27NnzJLoc70Hn
 fEjuR0Y/CqiMbJl3dPy4yCQy4P09Yf5Uc6yWHbpWn6J0pqI0r0l3Tskg6UMkqwaF9lNS3eLwTzu
 3+4qplpEimbmrHsyTWe75H59JcKeboyKGDzAfXaGBo50RUwbeMmKSxaLNKBhi4c29QqosLULaKv
 A3QM3s3CxNDy/Jw5UIitIf82HFTT8mDf3FsTDqdCPGDNdDR2CNidb6TXDIfoeciTWqFv7SfNfkf
 ysdbg70drCXc0gzquq8ID152+rqbaTpVj23go8Wza4yecImwpHIsBJnc9iYXs0F/0Q7slfSaKXu
 KV+3GAhQyKPGHBAeuMA117v0J4qwpQECNuitW4cCFjDf76pisjHJX148=
X-Google-Smtp-Source: AGHT+IEpTcFy1C4WU1lwk5ZcSQ0JBtB9NVNAZoxAaF165ivhCf3QygXkE233YlkOCmQYYxZKsHlzrA==
X-Received: by 2002:a05:6870:56a6:b0:306:bd25:6d34 with SMTP id
 586e51a60fabf-314dcd40abbmr7221903fac.29.1756148843741; 
 Mon, 25 Aug 2025 12:07:23 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-314f7a95e2asm1925107fac.15.2025.08.25.12.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 12:07:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: vigneshr@ti.com, praneeth@ti.com
In-Reply-To: <20250814152145.2853307-1-anshuld@ti.com>
References: <20250814152145.2853307-1-anshuld@ti.com>
Subject: Re: [PATCH v1] remoteproc: k3: update compatible for am654 syscon
Message-Id: <175614884270.2895716.12109032000532072632.b4-ty@konsulko.com>
Date: Mon, 25 Aug 2025 13:07:22 -0600
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

On Thu, 14 Aug 2025 20:51:43 +0530, Anshul Dalal wrote:

> The existing compatible name for U-Boot's k3 system controller driver
> i.e "ti,am625-system-controller" has been added to linux[1] device-tree.
> This compatible in kernel is meant for configuring the Control Module
> registers (CTRL_MMR0).
> 
> However in U-Boot, the matching driver was being used to load the system
> firmware on the secure M-cores by the R5 SPL and therefore must be
> updated to a different compatible to avoid conflicts.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] remoteproc: k3: update compatible for am654 syscon
      commit: bd5036ddf2f3d9198f4054fc1a807c8f8960b281
-- 
Tom


