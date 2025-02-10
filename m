Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62170C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 22:29:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DB4B8043C;
	Mon, 10 Feb 2025 23:29:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Yt/vmXQB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2210180815; Mon, 10 Feb 2025 21:39:03 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 829D5803CC
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 21:38:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6f678a27787so43693897b3.1
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 12:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739219938; x=1739824738; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DUp+MT60wm67+15nbS2h0F/WEg9kkzxEiPtQGbigVU0=;
 b=Yt/vmXQBYvTFd7jo9F+AuunWjKnlf2tKzK0jKtYlksDqNOCqRG8zCmseDNQNo3UFqj
 OrPSS/m4xISkfUNww3ILwnVWRXGRp25nQkCZldr2c3rBPbYagVhGFs66sfgjNF9jgu6f
 z20od2k1I3qyxdhPN+nm0f/HYbZ/wqipAEel4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739219938; x=1739824738;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DUp+MT60wm67+15nbS2h0F/WEg9kkzxEiPtQGbigVU0=;
 b=BEkcoW9a9tXMh3bf+kNcBTqKIsM4WUOa2GRmTe7w/3R1B76Ordzo71Rzk8EFBQC+Iz
 ecXke8VnGUv2bQuwVY2qJjBvBett6HOpluiAkGfQjYzCCTDl2A2qru+p/LymOCMRyyGL
 tZVFWB4O5lkb79nshdsw6qun26mL1X7SiCJBzlH165RKyq7x1BrICaVHP8ApbIxe1p2u
 KMV85R1oOS9cqG1a9pNV/mnbDO4TvhtJAbfwGEx4hK9WmQWv4i0FCzUAD66lY9BJU4bq
 bTb4p3leZNE/OegVUzMoCbzA4EQZjFLkHRhrvDUK3sIqrXQe3djP4+WZ0gCxMfEVgmnr
 y5pg==
X-Gm-Message-State: AOJu0YzQd2dCtm9/J1bwJJhyLsIfhOaaEVfMavQXWow+oYSt9TbtvsQP
 bR17dT5UBjAKliRDOG7wYd8TKKiqK6M5f1pUVi0k+vJyGrVxwBRQ7s9FnQBSjZ0=
X-Gm-Gg: ASbGnctg77SeF28/6+GvEAFIrZeVwt0crsK+AT1eiv9LJ24Q1z1FPAtll+DCjCPLe26
 dehqL4K0HeTUpQhwpi9350+vY6YfD2OxGNudQX7X1X9yyPaipt34S5TEd48swQB8+R5xyP4xuOD
 wUCJdkLL+8sZFyf3aUQFuvDzROAlyZADKMd2FZ3Ki5swt6lQJTYEIbFfpf582plblG8V53SGpUX
 8oRJUJG8/DeYgC7Rqqmq3LXH1ZuY1VwJ8hZolWyaYqtoIg9qTvRqSk5aVS94cWKDsduHrQPYe9+
 4JVi6+xN84EyUA==
X-Google-Smtp-Source: AGHT+IFN/tPuJzN7APkaA64bC3j+J+oowGclqOvPOWpcBjv3xOyaPXDDSGWITIzlHqa4ulgEVZj6yg==
X-Received: by 2002:a05:690c:61c8:b0:6f9:9891:7a7f with SMTP id
 00721157ae682-6f9b29e575dmr139428767b3.25.1739219938434; 
 Mon, 10 Feb 2025 12:38:58 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99ff6a8d8sm18233207b3.79.2025.02.10.12.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 12:38:57 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jerry Van Baren <vanbaren@cideas.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Raymond Mao <raymond.mao@linaro.org>, 
 Richard Weinberger <richard@nod.at>, Sean Anderson <seanga2@gmail.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 This contributor prefers not to receive mails <noreply@example.com>, 
 mason1920 <mason1920@use.startmail.com>
In-Reply-To: <20241201144240.1664398-1-sjg@chromium.org>
References: <20241201144240.1664398-1-sjg@chromium.org>
Subject: Re: (subset) [PATCH 0/8] Reverts and fixes for board failures
Message-Id: <173921993557.2921783.3890127949068603825.b4-ty@konsulko.com>
Date: Mon, 10 Feb 2025 14:38:55 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Mon, 10 Feb 2025 23:29:01 +0100
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

On Sun, 01 Dec 2024 07:42:28 -0700, Simon Glass wrote:

> This series collects together a set of reverts and fixes to get most of
> the boards in the sjg lab running again.
> 
> Unfortunately three of them have developed a failure which requires more
> diagnosis, as it may just be a hardware failure.
> 
> For coral, the TPM tests fail, but the board is working, so this can be
> dealt with separately.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


