Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AD5E95A6A
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 20:45:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A9E586F10;
	Sat,  7 Oct 2023 22:38:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ESkLF42s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B68A86DF4; Sat,  7 Oct 2023 22:38:20 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C27E86DF9
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 22:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-59e88a28b98so29031927b3.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 13:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696711091; x=1697315891; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xk6hHDDqbF+Mu0tzO/Rb7WQ05/f1F9K/+CENpAF09W8=;
 b=ESkLF42sb30tjihj7K/2I+r0Xutpd1YuNMDistMvErFU524wnT2RDn8+jbgIjOuIPQ
 xswN5JzJtSfuitRYu99iHttmCs7h8am+fEUWVEoWKfC1i9gkpY5YZ3j9mr6GxcDQCFzF
 1ywsJQF1ivVco8UbXEj5YCVFbjXkw4xHGRx5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696711091; x=1697315891;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xk6hHDDqbF+Mu0tzO/Rb7WQ05/f1F9K/+CENpAF09W8=;
 b=W+Xh7PAkinMp9PCZOTZ1cDMemw3vQ1TMgym085ZgZl94vW9gD55ukIeFXiQ8GWEhiA
 HpN5QuuMmmy9sie/dQWa2A1OwN+OH4rlZDZ/+QJAZ5BsuyfqhZ/k61MVLzl/5EEX9R15
 bev2RtXqJ+F5JXLVMcm4A47xBdOk2MrlD9S9/+fcTD1Q3kh2YuhHFPboE3Z2dQtLvyTV
 4NBMj48ywGsY2jCUSuoVdjuS1QuZrRtFXjy1kp2AzqdnUlhWdNf/w6TTftMGYnzNHiO8
 /1s3TbMFz99NCD1Sj3BvBp1tKjCtnifiTFlLWqA98PlBxo+n0Wy00El82fljQ3b6XRPy
 Gfjw==
X-Gm-Message-State: AOJu0YyRNCDabECkeIQCNZNaYpdtnGgcYoL2zzoFxei6qYIK7A96yOsK
 ejiRhWKi5xvnIu/+OVBBptL8boaAybEh8M/bjTuNZQ==
X-Google-Smtp-Source: AGHT+IFqeX1quYqeIbLg2hhLdrrR+K7v3a8Y1m8t7LAGIsXkZpzJ8uc+KG/4clfLPHDfxP2lu/D3pO2QiggY94f7ByE=
X-Received: by 2002:a0d:dd4a:0:b0:59f:7832:c6bc with SMTP id
 g71-20020a0ddd4a000000b0059f7832c6bcmr5669023ywe.2.1696711091143; Sat, 07 Oct
 2023 13:38:11 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 7 Oct 2023 15:38:08 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ1g_SFCLxhRWoOFW9cNyJHokZfQg_y0KaGAvEsRcEogJg@mail.gmail.com>
References: <CAPnjgZ1g_SFCLxhRWoOFW9cNyJHokZfQg_y0KaGAvEsRcEogJg@mail.gmail.com>
 <20230923194424.1739224-5-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Sat, 7 Oct 2023 15:38:08 -0500
X-Google-Sender-Auth: oXDk1U5e6ZhV1hmILwHGhmoYqEc
Message-ID: <CAPnjgZ3K3e4xReA3h0ixe_9CVfEWcJBNNyuya8M3U_f0Ks5epg@mail.gmail.com>
Subject: Re: [PATCH v3 04/27] moveconfig: Drop unused cleanup options
To: Simon Glass <sjg@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>, 
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

Cleaning up the README and config.h files are not needed now, since we
don't have any CONFIG options to convert. Drop this code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 254 +-------------------------------------------
 1 file changed, 2 insertions(+), 252 deletions(-)

Applied to u-boot-dm, thanks!
Applied to u-boot-dm, thanks!
