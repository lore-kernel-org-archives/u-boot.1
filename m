Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEE1C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 20:01:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C3C083082;
	Fri, 11 Jul 2025 22:00:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ExyvXyiB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02E4F828A2; Fri, 11 Jul 2025 22:00:56 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1024826AA
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 22:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4080548891fso701412b6e.3
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 13:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752264052; x=1752868852; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XOJLTgx0GMyu8pnp3Ya4fp/mqUXaB2nMaJQ632s2FPw=;
 b=ExyvXyiBjEz9xd8n8e43gbUwScxvvCC494wvZJIJYcjlW4jIsgVTz40gJ63INxLM0E
 bDv6niF6IzEkLsslua7L7VEklWnLajI2nR8LuNiCj3Gn9tmNL/KJKfTvaInJ8zM8Qspn
 totH3fKVMb94YGldwHVStobf3XkFFwB8Wxnn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752264052; x=1752868852;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XOJLTgx0GMyu8pnp3Ya4fp/mqUXaB2nMaJQ632s2FPw=;
 b=wH3XwMsVAcHPNb7GLxcB2nQ5h2Ft6V8UwMUPIPEG9/KRBc7ZDbSApBQTuwMvebQZOI
 XnGcbS8PUpf97ppdRpI5WrUVwzxuEvmL0D0C+AILWpSteXH1JdOmnfgTU40oA79HJNP5
 Z1s0ihl2/kyfzQpmsipPW/IHj0HkQoX7DmmZTNod0dMPOVNBZ5ldumvD6f7NSj9ros8B
 s1aUujU+KmM18MCS+p2t1knWwveaLj7+5CXeRxRSI3fGEzSVbWUvFG8qB5pqI65fBJ/K
 OdT9WDw55vd5e5SjdegyHOkAYYFazt//Qbh3Ss06VQLKmgcPp23fJOPA/E/1j76OUcRO
 ornw==
X-Gm-Message-State: AOJu0Yy9Xjc0D5F+DjW4yMoVOCzHauC4c1cN7mtpr8nqh8TlVzx4JsnG
 hby1feNofjriL9TmOtZu1IdN9i3FPk/aoK171HAm+34TIHJzvDz2EdeVsZexiV+RMF0aB3xx3Uv
 RkZq4ocw=
X-Gm-Gg: ASbGnctmKbuf1tkTk3ymf4Q+ao1yqZTRX3B/4X4tfwgw7/dunVj5/WBwVGttMgiSQoY
 726UhamAWXjlwhsaV1jCeBHmhHbLp9IV9i95NH9rcS8s//1js3avsJkVU1IpLgTHI+eGpTbWmgI
 +/BHKMj9eGb7nYI4agLpEQAYABez+iqE0eeCZ6Jx9H3bt80CyaULTkbUBzWdvtAkQ00C0xzmKDL
 0+rGobBCvGwfGH2DiE3fE/omnQsIDd74NCyyHVn+Y/WBEczb/L4gpUHOQLcwgE3JgwvxYq3cymV
 IcF5MfLJGM9ebxgZOmDJuIavTF0xQrnSoS+2NTrj6j/4xEqQFOBMz9xr3uk5U9IjgHXNYighAQW
 FY8X7umbcrAbqmnIMMo5nD679CgwuoL1A0YfA3XKlVTUk6COE0ayl+tJ4tNpGHZR9+Q==
X-Google-Smtp-Source: AGHT+IFiErZn655g+6Ynfa2S7cup13q7UMym4IVXuJw2hnnK9WKcIYJrjG5oezWE7WJr6EDgrMnJKA==
X-Received: by 2002:a05:6808:1b0e:b0:406:7f50:a59e with SMTP id
 5614622812f47-4150fe89c31mr3533157b6e.32.1752264052464; 
 Fri, 11 Jul 2025 13:00:52 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-414161e2b74sm666516b6e.0.2025.07.11.13.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 13:00:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250704214612.3418920-1-trini@konsulko.com>
References: <20250704214612.3418920-1-trini@konsulko.com>
Subject: Re: [PATCH] block: sandbox: Add support for SYS_64BIT_LBA
Message-Id: <175226405163.2365211.18375177622034155681.b4-ty@konsulko.com>
Date: Fri, 11 Jul 2025 14:00:51 -0600
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

On Fri, 04 Jul 2025 15:46:12 -0600, Tom Rini wrote:

> In order to use SYS_64BIT_LBA with this driver we need for "start" to
> also be of type lbaint_t and to then use the correct printf format
> characters.
> 
> 

Applied to u-boot/master, thanks!

[1/1] block: sandbox: Add support for SYS_64BIT_LBA
      commit: 53bd87651e45b32efa398dd5e433d8b93d781445
-- 
Tom


