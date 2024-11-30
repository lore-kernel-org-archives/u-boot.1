Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41229D7360B
	for <u-boot@archiver.kernel.org>; Sat, 30 Nov 2024 17:25:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F132898B1;
	Sat, 30 Nov 2024 18:25:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sKkC+BLJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13E0189890; Sat, 30 Nov 2024 18:25:12 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F407B88E00
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 18:25:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-46679337c08so15183031cf.3
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 09:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732987508; x=1733592308; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7H2RInLaoJ6FkpQw1n8aRPbRLY7k244IUigMu+VdlGI=;
 b=sKkC+BLJIkg6SSAbiT8bEsEAY1X10NV6PmU/xaxYDrnydtlPTNCmg6pKSYx0IiNe4H
 iepZ2Qi+5JzFc+RIw1DhHyE3q3rbX3cZiKd/f10YVCtwrohveNJfZqNUA/357Nk4Yuud
 F7Szxju178N1ErIR2P6tH2FyknINKV+eZ8Exw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732987508; x=1733592308;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7H2RInLaoJ6FkpQw1n8aRPbRLY7k244IUigMu+VdlGI=;
 b=fp+Knmadlg+HgFMGhQpiAg0IdOcB5RwTUTs15Y3WSYlNYuhVZYxPXJRI/j0pG0+sra
 hzi9dJBqOl52ueid57smkr2qXi7evwDZl6Rez/SMOdPnZU5YKSq71tWhOTGzOHh2K1lO
 igNpFqb5W3xidDn0rYLu5IQ42xkh70NF5++7m4mJ7MOKoVmA0XtYs1I+IdtimxTjJ7uL
 Am6K1LtSQy7+lCoZTH/QC+CsOG+IqU1y/K3XYIuMF3F/hY+Aiy6+1c6ZPqkjKz38KRUC
 F4FIBzH+IRm5TevRM61cnqf5XBy/uFCpJ+LFwxrKwOOMxJGMuq2YrEf7gmSrmuhhkOQm
 eDfQ==
X-Gm-Message-State: AOJu0YzzmXQdH+TnfglQFP1uJw8LSfy2JzTMbdTlxtMMBJ2sNubCv3uZ
 Lcp2csUPFVjUZtXrBjPHRfAtGrCLDk48eDrKfGZ7w4hFdA28U1wUl9jTqDeFo+w=
X-Gm-Gg: ASbGncs1kqR1Lf4PCPE3fN/KrDaEJqxsTcmmnVP4WvzcTmCH/SUnM22YddaPX9wUFzS
 oNM+zBw1/+z+R2cRIAtwxTWU/gLLg9sUcbpq2BMMjPkxmPM9xgFUmWwscpWDh7mcviVTqyD5D2U
 5t0Inn+5bvR3U9EMoxUiIes7XO8/uVqD7qWAoOFcyIg6/IT2GHyBRHTfxfqpFZ25IzsXFT7gewe
 98/ojZe2/W2luRd+bxTaOPhpVx0MbSR1w88XosMBLVFHoNq
X-Google-Smtp-Source: AGHT+IGMuc6eDEqWWupPTkAwVk/SxNPK+GwwBNJHr+1KMsTk9KCPzyavgrmOY6lOeYbabkRyofDjHw==
X-Received: by 2002:a05:622a:5c0f:b0:466:b202:5813 with SMTP id
 d75a77b69052e-466b366f296mr288508561cf.46.1732987507917; 
 Sat, 30 Nov 2024 09:25:07 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c407d882sm29218731cf.47.2024.11.30.09.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Nov 2024 09:25:07 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Richard Weinberger <richard@nod.at>, 
 Christian Taedcke <christian.taedcke@weidmueller.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
In-Reply-To: <20241121223217.330117-1-sjg@chromium.org>
References: <20241121223217.330117-1-sjg@chromium.org>
Subject: Re: [PATCH v2 0/8] test: Avoid needing sudo for image-creation
Message-Id: <173298750599.2255080.12891115197671882793.b4-ty@konsulko.com>
Date: Sat, 30 Nov 2024 11:25:05 -0600
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

On Thu, 21 Nov 2024 15:32:06 -0700, Simon Glass wrote:

> This series rebases and tidies up a series sent by Richard Weinberger
> to use unpriviliged code to build the test images.
> 
> Link: https://patchwork.ozlabs.org/project/uboot/list/?series=417786
> 
> Changes in v2:
> - Fix a few pylint errors
> - Split out image-size patch and default to 20MB
> - Attempt to reduce the diff, for easier review
> - Add new patch to drop exception handling
> - Add new patch to use the built mkimage
> - Separate out patch to drop support for fallback files
> - Add patch to remove prepared images
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


