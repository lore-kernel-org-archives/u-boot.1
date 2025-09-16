Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C43CAC598
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 22:06:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00B488323A;
	Wed, 17 Sep 2025 00:06:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k5BOijrU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 260B38323A; Wed, 17 Sep 2025 00:06:37 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07841800D7
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 00:06:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-74595f3852cso4211952a34.0
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 15:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758060394; x=1758665194; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pJ1NY5zgtSmj11gHCx0DIzxhZI0HgdyHdvf0nWvhE/E=;
 b=k5BOijrUQ64/3H5PYW4sG45b5oWwpI1+c0j9+8xXzqtCZkHxfljZNgqTDaTc2R4+nl
 TvSY7P3eY7vpCrcsbdFde/346NtrwF70gK7YaHnhKPHxtoYvEzQM6x9Krxnu7aqRFk1b
 noBdhTubbckRDFR1DXSFUrx0vOHsBNrNBxwq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758060394; x=1758665194;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pJ1NY5zgtSmj11gHCx0DIzxhZI0HgdyHdvf0nWvhE/E=;
 b=J9jlsFOd1srwjCGTBIgwiOvlU+glo9b9aQvTXEGa3jUUbYSmlIkSyYXo3qxLArhPJC
 hBSaDMyK1/yo6mAJkL9xFXEvE1PB0kPCuPzO7ILle44XklfA7wVR4AiZoM/zm5DCYpLD
 TrvZ1Oi9WX3V8Bd48l0ZEqyqtlbU29ugegPBqiBafBGA70ZbmBeEO3hkbt8qeR+m25r4
 r9ZtYnGDmazOYfzfLGN8g1o0zHtemwuMvMz7EoUeOu4a8OnVmUaiqLqh93grQoiJbs7n
 OFglIt+PiwR6qTu7T7iHG0Gg+ZaUPDnxRf1SltEXEJywkzE3gTLMLkDiG8gYELMGYxS+
 MSpQ==
X-Gm-Message-State: AOJu0YzTQQUMi4IjvQaMmEF03lGippZ+YDzz57JM5FFKzw4ZM7zJK012
 BhSBlRaevNGZlk6iV9vsEyxAerS/dSJhyqxC2x0s1XMVBS8D3T0mHpObIOqBE96aVUk=
X-Gm-Gg: ASbGncveYWQ0g3WG7T6j5RJYkWB7WXJEoZpwTiAEdydSbuCks9sVY9EMjRxNCYArFv3
 f8SGpPNOtGYfpzZsQNNESSiPPDmrRAa9joelrIhc2atOynpDgBw/KrnMKtWLH3wcEK0glvTIqP2
 olq/nxF9qIQYEkcWB7EkaAkbqALezYyvlFfpbp016WvErEvrYOS1qoA9BsG4HdzX71Mflh2J9i4
 YWj+/jiHdR0PWlZB7zUkR4rPcvHtI42dZP1g+NtlKBOBjf1Qr7HUevTpGratHHdzpAgzgNV9FGm
 9l/u/wLweZ5v7nlkHlG8vM/V2OAAmIn0m14TLuic/4yTMZakBqfODu7tGbT/b95GJ7GZUW2iNLw
 TFHK9G8UspZmpj1GK2+UcgNZwydTVqjD7ni5yBLNODHd1EiDNdq+brLHtUaX6Ib3sPA==
X-Google-Smtp-Source: AGHT+IEzV6fg+hHI281rqvVpFr2zPytUsHu/2PP3WURQoMvsOtJ5PC2VN5daEW1Bg6XYeLu4IaTQvg==
X-Received: by 2002:a05:6808:1b08:b0:438:2453:8e with SMTP id
 5614622812f47-43b8d8a0a74mr9747458b6e.19.1758060393580; 
 Tue, 16 Sep 2025 15:06:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-43b82a72a48sm3500050b6e.20.2025.09.16.15.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 15:06:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20250903142101.90350-1-marek.vasut+renesas@mailbox.org>
References: <20250903142101.90350-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2] env: Remove usb_ignorelist and env_fdt_path from
 ifdef CONFIG_ENV_VARS_UBOOT_CONFIG
Message-Id: <175806039264.649628.14287278356310660556.b4-ty@konsulko.com>
Date: Tue, 16 Sep 2025 16:06:32 -0600
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

On Wed, 03 Sep 2025 16:20:52 +0200, Marek Vasut wrote:

> The CONFIG_ENV_VARS_UBOOT_CONFIG should protect only U-Boot
> configuration variables in environment, those are arch, cpu,
> board, board_name, vendor, soc. It should certainly not hide
> usb_ignorelist or env_fdt_path from the environment. Fix it.
> 
> 

Applied to u-boot/next, thanks!

[1/1] env: Remove usb_ignorelist and env_fdt_path from ifdef CONFIG_ENV_VARS_UBOOT_CONFIG
      commit: 8db442e1a03b048fd34651b3e48ffdcc0bf7868b
-- 
Tom


