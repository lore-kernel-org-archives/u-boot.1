Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC1DC282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 22:26:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D387B80107;
	Mon, 10 Mar 2025 23:26:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gC/TUHfD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F187E80F92; Mon, 10 Mar 2025 23:26:52 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD960800D7
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 23:26:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2239c066347so83523805ad.2
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 15:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741645609; x=1742250409; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZE3WgFoa67VO73QF5xTecRLfibCNfU89OwIDzsUvN0c=;
 b=gC/TUHfDP/QuoeluOU8tTAjpTMNftTfual+Fc4x94F+yb1smZlkhvJT4eymBsq8mVE
 QMIF9vGZJPo7eHbzxJ4nTLYTMQu3BV7qR+ZCLJyJ2WeBl0cbSupcgLKDSDlDpiLIeAEZ
 RJQBslnWZbR7csgiHdtw9eM3pYYE6dk3sGXug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741645609; x=1742250409;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZE3WgFoa67VO73QF5xTecRLfibCNfU89OwIDzsUvN0c=;
 b=LAJ/9hgq3IX//qMXpFSXxCv81YGVkvE6wu5BvmOHTGR1kSiIgvzg4EH2a+riTFussm
 7eb1vxJktU7Bn8FgEnu/H5OlLPM6wIvUnvViiBWGeuwn0DyaXUUOgQgVXmjlUG+atKsX
 SjwYypIVBwMmGXLJ/lTDL1Quy3fBFsLcOWMOgYP4xS9lldYYcgX7hAbcz7hh5KgCo0ky
 h8sEIVllXRr9wu1rcUcHvlKj3+7gXYB+I/urFcuFjo5Up3cyedQUWn+5q3FHSotJNOvd
 NVS1z6zHjrZosOqIcQoBFLzb4K9dAk2DeDr6IOBNjvWwjQmjDJwavg2jEXTHvpYM/Mau
 /o8A==
X-Gm-Message-State: AOJu0YxjjdXr9pMhcpGSZiBybszJebZvL/CcWXRlwdrnLOvv6NEU8LbW
 pPTlgHRsaP0cLQJ0lpGFcsKMMniGLJ6F9Wcv+a3aUr0TL4Xlh73XOu1d1DfhojQ=
X-Gm-Gg: ASbGncuIo+T8lNcankqL/5vZ4nrVbT09QIwA613ZUKpArjDQ0g6NISKbotA7iyHWYJp
 sxnpO8jHVKipa1iMXmNPODnXO4FKoVOcUEZCOrCgFGfLNyy7tEbAzIVvA1cGU79R7NuEoLMao1+
 wmHAw2JB82p20MkFxn0qVIUA2FHu6uhOJVMX44KWjO6GMrUGoc11XRX+btpjAW59EKdAreF454S
 QdzhFKewlpCU3LTF1PqSASTtlRZ6VthEKH2KNFdfdUNQVEpy0Z+g/25S0o0C7uk7/WEswmiVJsv
 xObPBVcZK1nXtgA5yZ5b8wKCPmfLAdL/iaOfnlWw2IQH
X-Google-Smtp-Source: AGHT+IFyHSGxzBF7849BAPMkSnCNmo1pDCy1NFFH9wlosJovXUH2ccFElpAVRED29gKBW8iYXNeT+g==
X-Received: by 2002:a05:6a21:394b:b0:1f5:889c:3ccc with SMTP id
 adf61e73a8af0-1f5889c6dd2mr4519689637.14.1741645609327; 
 Mon, 10 Mar 2025 15:26:49 -0700 (PDT)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736a336010dsm8394138b3a.59.2025.03.10.15.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 15:26:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Alex Shumsky <alexthreed@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Dragan Simic <dsimic@manjaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Janne Grunau <j@jannau.net>, Joe Hershberger <joe.hershberger@ni.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>, 
 Ramon Fried <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
In-Reply-To: <20241113150938.1534931-8-sjg@chromium.org>
References: <20241113150938.1534931-1-sjg@chromium.org>
 <20241113150938.1534931-8-sjg@chromium.org>
Subject: Re: [PATCH v5 7/8] env: Provide a work-around for unquoting
 fdtfile
Message-Id: <174164560690.390216.11166200633277191403.b4-ty@konsulko.com>
Date: Mon, 10 Mar 2025 16:26:46 -0600
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

On Wed, 13 Nov 2024 08:09:37 -0700, Simon Glass wrote:

> Some boards use a CONFIG option to specify the value of this variable.
> This is normally handled by efi_get_distro_fdt_name() but in the case
> of sunxi this does not work, since 'soc' is sunxi, but the files are
> in the allwinner directory.
> 
> Provide a work-around for this particular case.
> 
> [...]

Applied to u-boot/next, thanks!

[7/8] env: Provide a work-around for unquoting fdtfile
      commit: d085e692c98d0d7b57cc577ed9befda159cd4a40
-- 
Tom


