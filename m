Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F68CD1283
	for <u-boot@archiver.kernel.org>; Fri, 29 Mar 2024 17:12:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C6B487C2D;
	Fri, 29 Mar 2024 18:12:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="txAxIENw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33CF688213; Fri, 29 Mar 2024 18:12:47 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26AFD879E2
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 18:12:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3c38eced701so1294733b6e.1
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 10:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711732364; x=1712337164; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UgzBkyv02/okQBHVc0uin2hsQ7rUR24PlWW+sRHTvDE=;
 b=txAxIENwMtT0FSkFfoDGmlBOZnvOUY5ODmIPLkY7ODBg6rd2cvr8IdFgfEwd0pJx0N
 143IFL4alKVhPH8KCBBar2scmpLNp6WpxgqfnU59dbtrOqKoHuwdp1gaGkpKXqajLGee
 9zurzZwmz7yX9tPxvL1Dl6s4mEeW3x39Hxsgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711732364; x=1712337164;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UgzBkyv02/okQBHVc0uin2hsQ7rUR24PlWW+sRHTvDE=;
 b=Xhi1EI3b7w7PO+RaN2MyVWz9j0IqkVb+U3ABQMkdz2sXQjqc+DsUjGMg0vLV4F8ynB
 q4M8+WNpiSYDV4gd7r8mSO/vfA8noEwancpZW44/xHxLM3ZBx62AT88BxA227iPjBOp4
 Rpl+oL5HtQiuu/AOuFoEURHvMxsMEppFBq7cz9xBhihdy0TVjslqCLovpqfYUVgZ+5RU
 COJzQMugXx4rNos8OuJIjR4xrHSXPKfaCIkUe3wSebrHSrIh0mPAcS/SFce1KejbMyHf
 HFy2vfTro5ju1lBqoli7K8zSQwpPGWMPIXp/ZrgIzJYXr8ltpMbyR/8qDcHbuD8g4Xu+
 zgaw==
X-Gm-Message-State: AOJu0Yzdwq73YLXn87x8nsf6HwCNSpaji+4uz+KgcSAlOMs4S166NLTz
 HU4VaaqToZ9pzi3T0hqxRaJU5VkrSYcjp9LJJvVL2HOPEaVH9FONYyEV9E6yr+8=
X-Google-Smtp-Source: AGHT+IGU55C2WB8QRCvO1pYMPAPGDej4uSUlxkVuKzNjh7jepvINkhRXv0g2XA/8UFRDLB8k8bWIug==
X-Received: by 2002:a05:6808:1304:b0:3c3:83dc:d6fa with SMTP id
 y4-20020a056808130400b003c383dcd6famr3148333oiv.36.1711732363897; 
 Fri, 29 Mar 2024 10:12:43 -0700 (PDT)
Received: from [127.0.1.1] (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 mf4-20020a0562145d8400b0069697d41adfsm1822296qvb.55.2024.03.29.10.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 10:12:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, cfsworks@gmail.com, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org, 
 richard.henderson@linaro.org, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Michal Simek <michal.simek@amd.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Edwards <CFSworks@gmail.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Bin Meng <bmeng@tinylab.org>
In-Reply-To: <20240315064354.2215266-1-ilias.apalodimas@linaro.org>
References: <20240315064354.2215266-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v4 0/7] Clean up arm linker scripts
Message-Id: <171173236259.4169857.16695162713948386821.b4-ty@konsulko.com>
Date: Fri, 29 Mar 2024 13:12:42 -0400
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

On Fri, 15 Mar 2024 08:43:44 +0200, Ilias Apalodimas wrote:

> The arm linker scripts had a mix of symbols and C defined variables in an
> effort to emit relative references instead of absolute ones e.g [0]. A
> linker bug prevented us from doing so [1] -- fixed since 2016.
> This has led to confusion over the years, ending up with mixed section
> definitions. Some sections are defined with overlays and different
> definitions between v7 and v8 architectures.
> For example __efi_runtime_rel_start/end is defined as a linker symbol for
> armv8 and a C variable in armv7.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


