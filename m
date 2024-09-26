Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD1F2CDE03D
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:08:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F6AF88F55;
	Fri, 27 Sep 2024 00:07:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g52hXNKf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1062688E5F; Fri, 27 Sep 2024 00:07:27 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D12C588F44
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:07:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7d666fb3fb9so855493a12.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727388443; x=1727993243; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D1jp76bAFKAI+tDeQU7MjkXnu61B/cwyFivx5AznOqE=;
 b=g52hXNKfwPjTo/GSMh6wXaePjDVM8OhQ0jqSAyDPvfImlvez6xCOeghz3Wfavu6/0M
 oCKyJ8wxftMkOkw7XFXOV0Vc4YJJrKIcg+f/YUbJDHvBTZG586S+FbpeZ/wAZok+Gtrk
 tEBWNwWyN8WpyAEPAZQxYzpAp/C7AX2u33w+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727388443; x=1727993243;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D1jp76bAFKAI+tDeQU7MjkXnu61B/cwyFivx5AznOqE=;
 b=cAon6Md1O2V+R4p1WrM0v+/DJ0K/W/fRLS5hDHLMU/BaNwVzLe3VXIsdGMfxS/fJ8F
 OsnasQk9ix6AosWCMpm2kSLT9Znxv2LcuFKNixNp0KzJx5AE2w5QEHUVfsnrv8RlCcYw
 zgnkYG/+YndewOEpgIYykpZxPi68hraVIbj1GiEmwN+KJVugd/4d6OSAwRoeIrzl8lw/
 WIqFo0rgmWNjiTAwwbYStDfwNiEBCe5ZeAgTX/apbzYmagbTX0C8CKpu2zOQrvMdpjTM
 n/nlcWdp6xnT+/hrGQtByUTqQ2LdEuzOu0iWu7toS8aiYFpWL7KSGSR2lpY2+cfkOXBg
 mPfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLKaGZV8v1rW7Mo+7OQKKwBdfhhAcM0xy2Mp8zrA7LidxwVk6g1YSqsgg7BAnG/4Hd4Gg/a/U=@lists.denx.de
X-Gm-Message-State: AOJu0Yww1enk6SwwPVhnjl+uZSYrc8IQWdF4n70eNMY9//h7dUmiFQ7c
 +6hlbJ9APDdt/lNQxx3I8KSbt56427amYdFfCfUb/Ako0/71zPHjuh9OnG5t5QB9cnayJ6vkVWp
 dW1FG9giY7KSyYoHnilr/DU5M+2//NI+Pe8f/
X-Google-Smtp-Source: AGHT+IGwuWadRc2pHI8eVjYAWveIbGYra5bgaEwtOQIMO49zlwo8FSavQFIBc95wbwIBeVSh1YrToUP9pArE4+39y6s=
X-Received: by 2002:a17:90a:d994:b0:2d8:e6d8:14c8 with SMTP id
 98e67ed59e1d1-2e0b72ebe66mr2095834a91.15.1727388443389; Thu, 26 Sep 2024
 15:07:23 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Sep 2024 15:07:22 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240826191143.426387-11-sjg@chromium.org>
References: <20240826191143.426387-11-sjg@chromium.org>
 <20240826191143.426387-1-sjg@chromium.org>
Date: Thu, 26 Sep 2024 15:07:22 -0700
X-Google-Sender-Auth: B7f_xohgnud3QDgMm9TMPCn06Zk
Message-ID: <CAFLszTgh4Dh98i3TDtJ1JcuWdF_kAdZ26sNLW_AjHCehkUTfEg@mail.gmail.com>
Subject: Re: [PATCH 10/15] binman: Adjust naming for reading symbols
To: Simon Glass <sjg@chromium.org>
Cc: Lukasz Majewski <lukma@denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Rong Tao <rongtao@cestc.cn>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

These functions get the value of a symbol. The reference to ELF files
is confusing since they are reading the position/size of entries, not
ELF symbols. Rename the functions and adjust the comments also.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/elf.py           |  4 ++--
 tools/binman/elf_test.py      |  4 ++--
 tools/binman/etype/section.py | 13 ++++++-------
 tools/binman/image.py         | 11 +++++------
 tools/binman/image_test.py    |  8 ++++----
 5 files changed, 19 insertions(+), 21 deletions(-)

Applied to u-boot-dm/next, thanks!
