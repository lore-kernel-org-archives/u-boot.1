Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF96E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:08:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB04680463;
	Fri, 20 Dec 2024 05:06:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QwdkUY3T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29E4080446; Fri, 20 Dec 2024 05:06:02 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B82280087
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:06:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9f1d76dab1so274582866b.0
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667560; x=1735272360; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sARa9+TEwvlNQf4rQYB0O/UYDH7bhSbvHeyjZ32xj7w=;
 b=QwdkUY3T/8+i1MIfY5F8wlJt9oC9RnsjcQ6PWp8nx8wRzt9ewonluspDxwRGoY+VvL
 fq/LYzaAc8hZiQtObCUSVKaC2hsiQufW9M1EQbaCC86j80MiL7uB9AhQMGi5PCdORHoE
 NVTZRLcvokwoCAX/HeZz44xgNf/a6PrEYpjyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667560; x=1735272360;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sARa9+TEwvlNQf4rQYB0O/UYDH7bhSbvHeyjZ32xj7w=;
 b=tGfv/G+4aAWDQLde1lb8LcFr9XIf9t3u2zwcqM1N3JrJH/q2nrl3zePKrLulIjh+EI
 8NezMockZl822IdMAs50VwZAEQ9JHUx81kUtKbWXpbGYoYOs7fFDZ/KbX6XKTQcTN1k3
 gzNEE1bGK1sy/F07gzfBco0IruwYcRc+Dn4lZ68LhXwRf80nG+bRIzTw1V0dyIrFMHPc
 ARxw6QX1LApotvVVH3JCWixGF4hmVinTR6Dji/noJ39owrRzQ/zOBT2SMEy63kRTHCZQ
 Qlt9Hl6PDiggWi/8gg+V8Q2jgSzBJJDxm26jh1Ngl8ARancHTv0rw4EBmvazqJIJfITS
 kdbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG4GynEWM3phbeZuKmq8y47Ugi51iVQFY+qNrD0XsFzt4qQeGvmROsn0yc7q9btmnoMHcN2KA=@lists.denx.de
X-Gm-Message-State: AOJu0YyPy3YlBmdwqND/3aJbLr3bosh0idNcVgQx9J3Bm3rnYH5PMT4s
 UkIOaGMWCFXljxNRdkylmfyRjCSor4Iaz1I7p5QQ1ODAVxeldX/5OaqHZYpmooUGba90aOcdthG
 KHa8NnL3BMJMMxF8+7ME2qGqhKtyl5mAGNsAF
X-Gm-Gg: ASbGncuzRrfK0ZeWhlbLijximNfEVcl1Jbm7w2Zohnx2xo4DUl9RMQmTbQv8PpD//Zp
 EXCLkdRSEmMktINGnYDEuOMJl8cE2kG4PBa7WQeI=
X-Google-Smtp-Source: AGHT+IHmp4JtiXfg3eBaVaMOY82wMZyeNs4sdn4vFj/rTEt4rtxviTYvM697KqlICzKFx+43An+tHbwLgHiCMV2iQXM=
X-Received: by 2002:a17:907:7286:b0:aa6:79fa:b487 with SMTP id
 a640c23a62f3a-aac28a2ab8fmr85661866b.10.1734667559708; Thu, 19 Dec 2024
 20:05:59 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 22:05:58 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-24-sjg@chromium.org>
References: <20241206023626.2456858-24-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 22:05:58 -0600
X-Google-Sender-Auth: NTXNFNvkafCkrNcqoWbmMNU9l8Y
Message-ID: <CAFLszThXcTzjFR+qzCHq=Wi5iRN4MaZtxfFFC89gzjx=QmcNBA@mail.gmail.com>
Subject: Re: [PATCH v3 23/46] net: Simplify parse_args()
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Adriano Cordova <adrianox@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

This function repeats the same code in a few places, namely setting
net_boot_file_name_explicit and copying of the filename to
net_boot_file_name

Move these two operations to the caller, with just the filename (or
NULL) returned by parse_args()

This makes things a little easier to follow.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/net.c | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

Applied to sjg/master, thanks!
