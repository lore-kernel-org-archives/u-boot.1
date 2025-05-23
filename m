Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7ADC54F2E
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:21:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0105383322;
	Fri, 23 May 2025 15:19:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NSShbUXC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8ECA83335; Fri, 23 May 2025 15:19:07 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C12A83339
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:19:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6000f2f217dso12406603a12.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748006345; x=1748611145; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ol0LQr9l84QnsKIZ+qruPGU98TeB6F38VZsVsTKCdAk=;
 b=NSShbUXC1eFaBvDvTUHQeA99GwsjJ4GtbhPM37O64LS+8MhujTgdG+XwpgHkqAcl0u
 bRhsoCV7HapvArY7SgSGDbhIUBfD2FHopvRafzOPqTJmMUskWiRFNUroI5H3jUATyvSH
 wykXqWmogBHHjPuA6N5j8vaab6a5zoIdiFac4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748006345; x=1748611145;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ol0LQr9l84QnsKIZ+qruPGU98TeB6F38VZsVsTKCdAk=;
 b=VOoRot1s/8sUlIIHqSZWlZBvSioWgVx/AbCkl9YhCRr/SreH2Q2BlyJU/9CE9YFdEI
 UiSWdjmhjcQsJsPZDSor1A0yQZigQZ9ApBMr0A1dQmVuHKIckXu/2+xw2uzFutbLy9lC
 rJasC2QsRWAfHy2YpiWdu6+cgI6XWx6IHS3sWAkyrayW1eowqc77EOVmZZn8MHE56VBk
 baT+3vYKbU8dP426i3Elq96DX0/64xyF17mymdyl8LnK1LE7H1qElCXj/VAulhPzZcab
 p86MYzcoT9zkAV1NdoQSRiKLOBElpaqvUH/JgZHk10+t849fuOsteOzXJo8aXpQ0AGBq
 pbXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3ymvSNlFSnrGLKkaVJApwUYMwaGtRLxNFM7v9U5wC5DxGqetMJqt1VNK6cvlMMqRmIl0nUTQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+jzz+XmFUjYQOCdqq3tACjed0eapmbfU5gfyDSkyIKcuBgidt
 JFgGyN+GX7CrSprHGjrdduCDhnbW8YxNYS0VZCRG8ZKj32sbZUF4GW0gj5u7HZbIreiVUYrVxHA
 yxtwIZw3JfiLbcA9rI+TzlQTtodTmoQV24ahuToO1
X-Gm-Gg: ASbGncuhHGwBpKAUFKQ4yXy+fgt8mIUaF5MNvHFlpJPRJ2wyoRUlpQqQe3fzFXcFo5V
 /R0oIUcrWMf+D++7g2JTY4YzT8ITutI/6SVpdIC3aqo//CKc/kFyoycD7YvhW7eleTKbS7CKZM8
 DbXR+n6xp4kIcvUVNElr0GYvXecSps8Nff9w==
X-Google-Smtp-Source: AGHT+IFUuEFDqFGshR/ckG2NHev6Be65J1rbGKqXmPC7TPD+vghpE9kzXsaMxExi4nZhRPMiXmET71dyAW8/k0yZWzU=
X-Received: by 2002:a05:6402:2355:b0:601:31e6:697d with SMTP id
 4fb4d7f45d1cf-60291695206mr2651230a12.22.1748006344791; Fri, 23 May 2025
 06:19:04 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:19:03 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:19:03 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250504132356.2317305-12-sjg@chromium.org>
References: <20250504132356.2317305-12-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
Date: Fri, 23 May 2025 08:19:03 -0500
X-Google-Sender-Auth: _rx1rt7QeqMdSarMrd3ybfOfvY8
X-Gm-Features: AX0GCFuaRapHLX3-sqs328gGlJZB7DoOmIsRtwlObPnHKDFGkm456W8XBcmQqPA
Message-ID: <CAFLszTgme0RD23yFbww8TgTO7f4t6wdcOXe+5fzwUtEFcKkufg@mail.gmail.com>
Subject: Re: [PATCH v2 11/30] patman: Rename test_basic() in test_checkpatch
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

This currently has the same name as a test in func_test.py so it isn't
possible to select one or the other with 'patman test test_basic': both
are executed.

Rename this one to avoid confusion.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/test_checkpatch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Applied to sjg/master, thanks!
