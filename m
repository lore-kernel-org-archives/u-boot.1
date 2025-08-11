Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A66CA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 22:22:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4DF0833BF;
	Tue, 12 Aug 2025 00:21:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sNcpP1sf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D390E8334D; Tue, 12 Aug 2025 00:21:07 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74537831C5
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 00:21:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3e51dc20af6so47948415ab.0
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 15:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754950864; x=1755555664; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zzDf4rkBTsPf0aF5xPOILsA6VwMOSSLCYtDHTNvumY4=;
 b=sNcpP1sfJ3T/44+IG1ZK3ROW/bRI62+XkB6GDOIMWYncDk5jOc3D1tImDIruYcSkT4
 PghTyDtwckL2NAGw3Qa+v9fegK58BFUf0McLT/sgYe0LXb+o+UnM7nHedcJfUP9+2Vze
 yQZR0OLzZOs5dyn2fxRmgEHe/B0ooratV2lVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754950864; x=1755555664;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zzDf4rkBTsPf0aF5xPOILsA6VwMOSSLCYtDHTNvumY4=;
 b=bWUe5GKDZ36WByeWt6nhwrwlwRDRFMKz/O4OOaVnxEryI0KSmsicxuQC6VkZYY4xKA
 +8o8guJUr0SOkcOehS6I3Ve+tYFgbSajeg9QZUZsEJIMhLci381NOAltK4ZHRDJBrHF0
 fimRVf5qBOCQVfCPvthDBlLPH5hZhrvv4f9iTfCnqvzTdAGvtY/llA+EFIod/Fs5+W0K
 Drpo7M7cFBhK0RYOVDE4gguqqLKurcOD7pNHHl6gaUIhzamFnn5kKAV4UF0IUsbo0W4u
 M0uMAYEyfww3xQp22YaD7LgxS6tbN5qNPdpjHN8XOn8OgHzTWo2FJK5voyfJzzS+Fp3k
 3GWA==
X-Gm-Message-State: AOJu0YzmYebXPljSDI38Ng9aXZU3o1kcnEDdf2fiy/4M2vA9Dp6G6wcy
 rv1vxsWqH8esbShAG2J7IkLGzeefR+KzFRaWNUpLOAnuFDoH+8kMmuoJ9Bkl6VBawf0ZXSNJj2b
 opMjErNo=
X-Gm-Gg: ASbGncvelSqaDIilyRcjJr+JqymoJ6MsXj63vI2h2VvSPYN69JQScDxKlkmGMab3imw
 7U3WFx98dt6a4vR5qdLWtOw5Q4L4qLyVqxdm5J8fXN5ABSfzE8TDPGcNgGUQuN3xPvja1AMPqeN
 6N2onk0lDqYNxvUwdJFoJ+bGkXbz6+ACejat17rIUDyGK8PVECQTtoMgNsbd/9awZmIAwTd0QN3
 wSBwv/94b/4mRHASCuAlr4NFN52TpnhyylMgnFB8laxdbimwLZveYp+5RlcjyKWgYE8GZgvgq4t
 zn36HtzlmvMJLnV4PWzOKOEK2gZz/9ajD/gpJawshNuSNK1okzrOIq5J0xYMRI/RhaH6FEvELax
 AIGAW1FkM7GHVBatuXZ6gdN05W8VD3C60QZ6cBqpk0otcP8RSlmixV0U=
X-Google-Smtp-Source: AGHT+IEMZMZE0DdeT4k39MuCjpdOtiI2avZxwZ4s4xhkd8P/kmcBW2EjxR7TtdizKsvrsjpF0rSyWg==
X-Received: by 2002:a05:6e02:250c:b0:3e5:1a42:8cf3 with SMTP id
 e9e14a558f8ab-3e5331676damr259981915ab.21.1754950864198; 
 Mon, 11 Aug 2025 15:21:04 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e533cdd3e6sm42092725ab.55.2025.08.11.15.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 15:21:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: chalianis1@gmail.com
Cc: u-boot@lists.denx.de
In-Reply-To: <20250730021908.3268071-1-chalianis1@gmail.com>
References: <20250730021908.3268071-1-chalianis1@gmail.com>
Subject: Re: [PATCH] pinctrl: gpio: sx150x: fix compilation warnings.
Message-Id: <175495086343.1657597.15421550278571570950.b4-ty@konsulko.com>
Date: Mon, 11 Aug 2025 16:21:03 -0600
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

On Tue, 29 Jul 2025 22:19:08 -0400, chalianis1@gmail.com wrote:

> Fixes: 5451504256d3 ("pinctrl: gpio: sx150x: add Semtech SX150x I2C GPIO expander and pinctrl driver")
> 
> 

Applied to u-boot/next, thanks!

[1/1] pinctrl: gpio: sx150x: fix compilation warnings.
      commit: 814ddd7824db7d43dbad3bf70154e0e692a00d1e
-- 
Tom


