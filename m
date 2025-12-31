Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D85AEE49BD
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 03:53:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E819784009;
	Wed, 31 Dec 2025 04:53:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="a8RyWwfv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD5E48400F; Wed, 31 Dec 2025 04:53:06 +0100 (CET)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E24283FC6
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 04:53:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7ade456b6abso8554435b3a.3
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 19:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1767153183; x=1767757983; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rWbRukvhhPOJmRuhaqlo079lqhYzPaWf/8H1oZn7jsc=;
 b=a8RyWwfvomVIMa7c/VwTNUajpui9IyVQ+JD9+T6NXFJw9+CFqpLgEAhF/T39/sZKNy
 N/Q8lNozVa8L4hS3aCUVOp8He5eR8RXtz9TLfTy1UfAlr4Vn5Z1YkRenBTGOpDTtwhBF
 uOjxsjSd9KB+CMrO6T6xECrlTMcZ+22HS5q8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767153183; x=1767757983;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rWbRukvhhPOJmRuhaqlo079lqhYzPaWf/8H1oZn7jsc=;
 b=iI6qerNGnmjivwq/LVcn0y0xY+UI016x0pOqCZauTTz7EvHiK+jky4GYDWkrURsH2D
 xaWgiJlRU5Klwymr2Zi+momyJzWPMBpOMqG0gW9gvzoiMV0OqOuFDhnfXcH6pdQMzO/w
 BaJkyq97qb4YOpqLnev5/2gsuF1wna7YsbLg1xAiMOn8vzHNuRvWabiQKsuumBp75Du3
 w9p6wCcW+cJfrxj6kcz6tR/LMeZJpZpTv10jDz2htrD+JW9CBtu4LYDvNVwiveVuQEqb
 nnS1Ty7O48b94noE46JQVwSreMNLpvB9y3Gl3z+iP6c6ZoDVvbQNy8wVVy31r2AqAMoM
 joNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ8wZvP60PeFwOadjw1jQEWZbg9HW1GOBl72rt2gF628SRMlfMhLEQsVZd4oO9tb0m38RdN1I=@lists.denx.de
X-Gm-Message-State: AOJu0YyyeNHbPtxAF/fNzaGmKqYWhElNr2E/fcStHtcZLAjbNUdh6pIS
 unkaXkol5CHFWJQrQmvOmrHdqQry9/Kl0rfJdlLCtomnNM1WQS3hA30eeyIO56dX6g1gHUZ8P3r
 FTQXYL4JLxiKPGenLmlssf/DJRRGfc6kvB5YDPgfpwA==
X-Gm-Gg: AY/fxX7xaXd83egMRx7bG5VnUqEgvEMu6QqTbO5fscH4zTiNJh5f73LAYyF7OU+Rle7
 keuKkRg60t8g48t1MyiT53BZ3vV2mkY73fRXJB/KBLPQj/DMS400NdmIuca3PfdcGfarR5D5+V5
 xdLZ0qROBDBy/xmcNYAC56FHlRvqo73K6bQe7mKBhS6LR3GerLfAipenTtv4eAgo+eCtFgzKBX/
 g2XXgfyqUs10JcCiYhR+zJD2yGrSt0UVLLOiseUvtuN8Ln8T5e2Ixq7BZDQ2ucRQAMiWrtd
X-Google-Smtp-Source: AGHT+IHq/blEjbvsW4KEdEx7hjBOUZel5MBG5l0AnBGUYOE3zT11w6gN5/DpK5h4PrOHw5imrOqTQ9gSQ1brQ66DOjE=
X-Received: by 2002:a05:6a20:7f81:b0:366:197a:ece6 with SMTP id
 adf61e73a8af0-376a77f12ddmr31372476637.1.1767153182850; Tue, 30 Dec 2025
 19:53:02 -0800 (PST)
MIME-Version: 1.0
References: <20251230160112.3045527-1-visitorckw@gmail.com>
 <20251230160112.3045527-2-visitorckw@gmail.com>
In-Reply-To: <20251230160112.3045527-2-visitorckw@gmail.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Wed, 31 Dec 2025 12:52:52 +0900
X-Gm-Features: AQt7F2rmFupiCrZNlvY5e56bc-753laY6NdggmH9a3srYlftuAbiEDa68cQiDYU
Message-ID: <CAFr9PXmkcU4J8_wjReaf-cY9UAf4vFa7w+uTe727v0Wu5A1y6Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] serial: Add Goldfish TTY driver
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, trini@konsulko.com, 
 me@ziyao.cc, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, 
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Kuan-Wei,

On Wed, 31 Dec 2025 at 01:01, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
>
> Add support for the Google Goldfish TTY serial device. This virtual
> device is commonly used in QEMU virtual machines (such as the m68k
> virt machine) and Android emulators.
>
> The driver implements basic console output and input polling using the
> Goldfish MMIO interface.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Tested that this works as expected for the console.

Tested-by: Daniel Palmer <daniel@0x0f.com>
