Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30C1E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:11:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ABF680601;
	Fri, 20 Dec 2024 05:06:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O7NLRFcL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4611805FC; Fri, 20 Dec 2024 05:06:51 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA36A8037B
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:06:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aa68b513abcso289637466b.0
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667609; x=1735272409; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vmiVIpu58RSAXla/TXs83XxhYWu28H0dBYJuQ59C5DA=;
 b=O7NLRFcLYZNDbuRlmAKebIVKAZ+D2gGhvkPKlISKWOUg1IQwmnkghZyZGZ5OVjEuNR
 7QPQUzH1QrrOQEdHdr0N6YxDBq6v0bBAd8qzbyctH96+g6AkCAZds2+q35nOqRlLH4Ow
 ep0HxF13oo8buPADoHCDtp2JtTsdebf9svNO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667609; x=1735272409;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vmiVIpu58RSAXla/TXs83XxhYWu28H0dBYJuQ59C5DA=;
 b=FTcDNzL/7cPOT+XMMb5UXKV0iPtKzR5hX8iQpmJW0L6izNHGk2gV1ZVjkZuxXkZA7o
 xUXjRYb6zZcXrQYRyg7RWAsJcbfcakvZMoyhNa8mUJbrQVv+oXVLSHNDzHwSzGqC7Vdj
 zn+hkwGo8FwhO1dy2CnOXkogDt34DUYZ0idqgI9PjfGxslJXMeKHdvyudr70MlWp7CRu
 eSQ6DWzygjNYBZZkYj+Np7cjwn0lyqSKy9YUti/KcuuNPbpyOdWeFRhixV05KMKKjbCD
 1r4ytV3cqgjzxyOJQhkyvRXklLcu6a5dvvdDaqpFiNulriG1QwBjQKperNAFlMrBPR85
 LKVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8LgrbFWasWe3jHODtsHTEXD5f3pEItpDrfLvUF7/drICQPDC5JynHOUujCaRDBVz2dWMgmrs=@lists.denx.de
X-Gm-Message-State: AOJu0YyCbCfZBQZCL433W0tzGRaHDVejxdGpv5PK9fDGnIKOWj2MqbBg
 1E+nNqwM0iL1rBjxQBngvFnwjlLPysu9hVf2SmzPdUkmEBaPlnL4pL1N/b9mmmDfNf5Jo3x9aJu
 vy9yW1k6AIj5xbIe82j7hURExd35SWTtETOJ0
X-Gm-Gg: ASbGncsSlFho3mqlfdLOTAJjMdISvgjcb7HYtLKVaXDtDALY22u6wC8gviM2uakpmnQ
 fXpDWie5O4oLIXN9XFOinfbUrSfNaIpqkh6DctCo=
X-Google-Smtp-Source: AGHT+IHqSzPxmddHkUqZ7cvYxO0rV78of8TiwnY8iy1DrHqWGawJ1E3xVQJMZDVUATNAB69ZQfsDhgNstdc1BxweS7M=
X-Received: by 2002:a17:907:2d89:b0:aa6:8fed:7c25 with SMTP id
 a640c23a62f3a-aac2afaed50mr93538766b.16.1734667609186; Thu, 19 Dec 2024
 20:06:49 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 22:06:48 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-7-sjg@chromium.org>
References: <20241206023626.2456858-7-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 22:06:48 -0600
X-Google-Sender-Auth: 3x0gWYJe5Dm2xPGwvX--BRv5HSw
Message-ID: <CAFLszThsz-w1CuK_h+1Vzy89h9X+hetj_s98gH4ZQmP3b6kfWw@mail.gmail.com>
Subject: Re: [PATCH v3 06/46] x86: Move the bootm state for zimage into cmd/
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
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

Rather than holding the state in the implementation code, move it to the
command code. The state is now passed to the implementation functions
and can there (with future work) be pass in from bootstd, without going
through the commands.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/include/asm/zimage.h | 22 +++++-----
 arch/x86/lib/zimage.c         | 75 +++++++++++++++++------------------
 cmd/bootflow.c                |  5 ++-
 cmd/x86/zboot.c               | 20 ++++++----
 include/bootm.h               |  8 +++-
 5 files changed, 73 insertions(+), 57 deletions(-)

Applied to sjg/master, thanks!
