Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2950CCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 16:26:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CE9683526;
	Tue, 30 Sep 2025 18:26:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mEWTv0Jp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C2A1802C1; Tue, 30 Sep 2025 18:26:32 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EBCF83071
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 18:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-8ca2e53c0d3so266936939f.1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 09:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759249589; x=1759854389; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ibiqHsX2hBoCK3JrTAbLso+AVejyUXlZyO2J0mJqBzg=;
 b=mEWTv0Jpmz3xxnQ+Q432LEO2mCSox1ylMvQxzXdJwKw6ZQGgYuXG/MN2v1T28lrvLb
 K2X8U4CMUy3d1RJhUPsFOL/UZTx0/e7VC7v2PzywZQbMorhNYwlZs59KvFORVZ9cJlZO
 ew7cFRrkPJS7SIdcP4A8qxbBpaf1ZKCmYREaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759249589; x=1759854389;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ibiqHsX2hBoCK3JrTAbLso+AVejyUXlZyO2J0mJqBzg=;
 b=bJkNihMAmrA0As87bJKOggWUFjrG9b764IoJZLa6xCGGbgfiLImfs/JhcJq9dJLQ9l
 Uf9OolyDJLkkUzBIciK8wsrHx+mu1L9ZQx20aLFAatafHfpBKaAHlE20HSdmL4RoerTg
 /B8t2i2KP4Y51RVUZf+tQ9W4t8zPoLl8X+XuXzwBtH0olZjpxeq17ffPpKFSeQ+BTipO
 p8vplOx6yMrFpIya/rpcog3iJCFqj74mbX/pw5wTaYe5bj+l/akS0nKi9ymaci0i/h9P
 DQ9O29zseXsBCu14l6ixklbD12DwElMEdZBBgWJAkN8srSJukaqnU4qGKQA734PcDNru
 nWPQ==
X-Gm-Message-State: AOJu0YxekTjauq7AtiEPunqkCEOEpBgtJx9iTefdVdA0fi7QgNHtOA79
 pDMxoum0HBmZDlqVT8BY4LgHmen7AstS95l8wTdq5LtaYO6rXcYH/a+KCKaYrfjMBfw=
X-Gm-Gg: ASbGnct398g/914j5wiAjTDM+naGuQmMw+CkYfRcf0Tc+pfKCdbOZJRQqO8GIB4b28t
 4nTxhcOAGFyAjIgSH1gYuRBndo90X6teeROrzVUHwGuF8LcM5lr3EOW/Jt0dtQFdStczVBUYczF
 ksT3+f9XVGAb55Uz5DnFs5EHXObxr8QiXZR0KFL7aqSWrcpJXbCaru8ObQ5rvvPKt+Q/k06fx1n
 2TaP6jybZDtN+aOYvN9WPAJv89ULXJndiLqDExd6xaK0rRQ2qnx7ndPvi2ob6TC+I0gb4vdkQJV
 /aih9dHLkNl6D2jZfuf3Au8hiX8X2auIPMoZ6ZcvaTWsa8S6PqAwYRwcWLkk+BXhY6EYivloi7C
 u5NXeBnhrttOaRHI0TJLZthDx6/jehCWkcEuJJDgOQ2vGUhCzCgidDPZLUbETK+R3CYV8SL7SbQ
 lq8bo=
X-Google-Smtp-Source: AGHT+IFoJORrenjSdb5lQ3W6LpVLAB7zUOLAvIQnx0RXVTQC71gmOkoONr48q+2vkdLqr2xmXqUCJg==
X-Received: by 2002:a05:6e02:1522:b0:428:ef2c:c942 with SMTP id
 e9e14a558f8ab-42d81693cc1mr9075305ab.29.1759249588695; 
 Tue, 30 Sep 2025 09:26:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-425b9133085sm70159935ab.0.2025.09.30.09.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 09:26:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jamie Gibbons <jamie.gibbons@microchip.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, 
 Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>, 
 Cyril Jean <cyril.jean@microchip.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>
In-Reply-To: <20250930154534.3914214-1-jamie.gibbons@microchip.com>
References: <20250930154534.3914214-1-jamie.gibbons@microchip.com>
Subject: Re: [PATCH] board: mpfs_icicle: fix pointer assignment in
 board_fdt_blob_setup()
Message-Id: <175924958733.1117195.5853928276039212855.b4-ty@konsulko.com>
Date: Tue, 30 Sep 2025 10:26:27 -0600
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

On Tue, 30 Sep 2025 16:45:34 +0100, Jamie Gibbons wrote:

> Correct the assignment in board_fdt_blob_setup() to use *fdtp instead of
> fdtp, ensuring the caller receives the correct FDT address. This
> resolves an issue where the device tree pointer was not properly set due
> to assigning to the local parameter rather than the dereferenced
> pointer.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] board: mpfs_icicle: fix pointer assignment in board_fdt_blob_setup()
      commit: 8dee93cfc50992990ea6f1871b128d464929e1f5
-- 
Tom


