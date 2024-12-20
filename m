Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3089AE7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:09:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0876F80548;
	Fri, 20 Dec 2024 05:06:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hyu3CaTz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F78580511; Fri, 20 Dec 2024 05:06:12 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1856804FA
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:06:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa6a618981eso258618466b.3
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667569; x=1735272369; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aovee4T8nzN2eN8m/3TOc2uTz0rmq/zH3cI2i5+jB90=;
 b=Hyu3CaTzQk3BAqbcH27DRPzadXqE1EHVZzk/Z27PUgTW30dA8IBlk+hsmx4btg9DFP
 vEcXNix1a9Fq+I+mSvQt/Z3ROASs0v/U5UG+3kpiio/BZ4d7vq7b3h5dICIkOqylb8pn
 oxhljQcX4mnIcv9pVX2AQ7Z64+vLTCJdP3ywI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667569; x=1735272369;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aovee4T8nzN2eN8m/3TOc2uTz0rmq/zH3cI2i5+jB90=;
 b=KvOJ7swk7dF30f8n2FPITHHEUG+qNBqJRetCkv6Ij/j+/ynmYUtDWfIT+7QoFzph6I
 /iRWwC/cpdX9bGWzrDB5z/bVdbb47IhsO2wnpBiPVfPPt/WBwg4ga6QCuvXAoD5K55n4
 i8dwhG2QUOvcOb2Is1HlHsNNeLOjWy23urslKyiiZp7SMHbI16ZGn5j3u/HFI+LqkHYS
 W+M0zteb3cnYDBpuZzDslvli3G0MxofhS3fpsKc/SNzMsXCyfH0PjXo9gdRBqiLqeRVQ
 2IYnugfc98N+3r2ECU1mEvWSESBJVwJq3LD4Xw5wFyhKAVQG20S/7L0JV6U41nzZrVy0
 c+1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXxbfs6urnuBglI6J47Q7W0yM2DH069IS5gCBcbE1O8M20wbtZppOMUBekL3mUfDhGsSnYFyg=@lists.denx.de
X-Gm-Message-State: AOJu0YzeEvQ4aepFZLoPPVRQHxVQnJQD4fx1vRIoij8MUgTJrqoE3/no
 otlaCs3iu5WtxoAh2EC1VQf/YRPhl7ZHkLYBXKMd4XeNWiQq9GTcahwA1d0a6feDTYzR3iTrL7m
 h2dbdkOFm9tdo0Uazck5LYkueleg4AiK/6gkd
X-Gm-Gg: ASbGncv/9AoMKVWAYHWYpeFjiZQ6ex4pNYrzOrxT1PiEB5UYUbWIpd2oGna9ggn3tsr
 JMO3X3T0QoqR6UQShkdGWyCzkQtXl2yh3g4ZhWoE=
X-Google-Smtp-Source: AGHT+IFVDpynjC8Ctz9uGaB0zS98DWaD9coJnmCZIBogBtyRo309OkEYNtFZt0QRkld8QOLqFx8Wwa3NQAQ/5jti4Po=
X-Received: by 2002:a17:906:7956:b0:aa6:5e35:d730 with SMTP id
 a640c23a62f3a-aac2adb4d77mr80004766b.24.1734667569354; Thu, 19 Dec 2024
 20:06:09 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Dec 2024 04:06:08 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-21-sjg@chromium.org>
References: <20241206023626.2456858-21-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Fri, 20 Dec 2024 04:06:08 +0000
X-Google-Sender-Auth: 1P2Avcqpb_lVjrl6_Dzfh0Spr7c
Message-ID: <CAFLszTicsmBDh-w9j9SX1C9oMEzdefPMpMZcBfPRohH1b3CcTA@mail.gmail.com>
Subject: Re: [PATCH v3 20/46] boot: pxe: Refactor label_run_boot() to avoid
 cmdline
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
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

Adjust the remaining call in this function to use the bootm API. This
will allow PXE to work without the command line.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/zimage.c | 27 +++++++++++++++++++--------
 boot/pxe_utils.c      | 13 +++++--------
 include/bootm.h       |  9 +++++++++
 3 files changed, 33 insertions(+), 16 deletions(-)

Applied to sjg/master, thanks!
