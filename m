Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14448D1BDE7
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 19:52:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 336B788DFB;
	Mon,  4 Nov 2024 20:52:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Zg3WzZjk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27F9788D4A; Mon,  4 Nov 2024 20:52:02 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F020288C9C
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 20:51:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-460c1ba306bso33067921cf.2
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 11:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730749919; x=1731354719; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jQtwGgiCxOgbnbIZPKCnsIW9lKpu3s0/tAI8m4dSOXk=;
 b=Zg3WzZjk8dz79aMm1HmKNU9p9suzHCOyyApJjQ7sMhZBpL25Dovi6BVSBEQwKTfGxl
 o58Vkxal3OfoXGYEgi7kDQz8iSCtDohol+E4MORTmq9464Ix5DoT+uGFmw8q9LcSG4IF
 Lf3ZLnVESKvRh1lrpekIkUpqpOj3JmHMB7BK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730749919; x=1731354719;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jQtwGgiCxOgbnbIZPKCnsIW9lKpu3s0/tAI8m4dSOXk=;
 b=lZvIqQn4CY4QPqQapNqEEkny1nSWATTaKyDvaXaS9qhdRMfQ/gDwtvxgfxlwnw75u2
 Pwk13rKTeh/zA2YILsvnySCfhqIRt8syKbYOXiaXXkDjaQUcnEcNYuyu07mBEHQlFaqW
 1E0xW2KWmu3EkyxrWnaPgYG+vZ8Bvi36r8k9MLcMpS1EdjYuOtEb8bq00S1AHqG3yxsC
 f9zQ4iwaG7NAutIXu2RlUsr+FJaVgo50EEYLgYMFQ8Fbl771OsgiYuqv2gUkwmbtM/oz
 UKhQ+oFuKh4lRCTokib4663IW2S6xGlFfOL3FUIbw1MR79JLzunx+a9fIGS36QUZO3ng
 smfA==
X-Gm-Message-State: AOJu0YxEc9T49AgbaHfycC86f+wpaEcJLX7tsANcJf9ufGhew6CyHWMI
 Rlf7oxJ0xqfk+YMafukV1SUBjgbktCgTZGB85TmkCrHWcIy81FdDw/q4+zbR04c=
X-Google-Smtp-Source: AGHT+IF6m6cB/oyLWAsnpWRN8x9o4eQWKwUPRARLQmU5BI/jN8Qsh94qK7kP0IUgFTOy1v5yaxwbbg==
X-Received: by 2002:a05:622a:1b8f:b0:461:148b:1884 with SMTP id
 d75a77b69052e-462b8650b0emr175884351cf.11.1730749918806; 
 Mon, 04 Nov 2024 11:51:58 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ad0a1794sm50347791cf.25.2024.11.04.11.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 11:51:58 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20241104183643.1116385-1-sjg@chromium.org>
References: <20241104183643.1116385-1-sjg@chromium.org>
Subject: Re: [u-boot-test-hooks PATCH v5 0/3] Add support for Labgrid
Message-Id: <173074991729.3618279.1154623179293637270.b4-ty@konsulko.com>
Date: Mon, 04 Nov 2024 13:51:57 -0600
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

On Mon, 04 Nov 2024 11:36:40 -0700, Simon Glass wrote:

> This adds hooks for use with my integration for Labgrid (called
> Labgrid-sjg). The only existing hook that really does anything with the
> target, with this integration, is the 'console' one. There is also a new
> 'getrole' hook which looks up a role to find various things about it,
> such as the U-Boot board name.
> 
> Changes in v5:
> - Use Labgrid-sjg instead of Labgrid
> - Use LABGRID_SJG to indicates the 'Labgrid-sjg' integration is running
> - Update commit message and cover letter for Labgrid-sjg
> 
> [...]

Applied to u-boot/u-boot-test-hooks.git/master, thanks!

-- 
Tom


