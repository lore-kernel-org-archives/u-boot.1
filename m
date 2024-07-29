Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269B0C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 15:30:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B1CA87E13;
	Mon, 29 Jul 2024 17:28:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UlNu8BcW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF1FE88874; Mon, 29 Jul 2024 17:28:52 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAE6687E13
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 17:28:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6b79b93a4c9so26068556d6.1
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 08:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722266929; x=1722871729; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9VJiZ8pFhYTxoZ3RQGq8KYQYJLKWTmrvx6ihRjOx8BE=;
 b=UlNu8BcWjtdkmAWOAblXoAmlZKiBsby2bgaoA1XB+8tW0btn395OcdEj1xF7fkzKpI
 4SkApQDnYSaBkdCU7qTkq8nczxiFBXVamV+CB2+2dvMXZiQpvFnb8ATjcrgPzOCSyStn
 EQ9Fs08t1ryxlokpQjHeCvpPEo3Fuv/+YsFEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266929; x=1722871729;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9VJiZ8pFhYTxoZ3RQGq8KYQYJLKWTmrvx6ihRjOx8BE=;
 b=o7QbLVUPPsyzfYK4Epu7v570th2fepUZQPhFrfE7aTW5eodahMqGl4cnDXUSsF/rTI
 dqqQbNQjOj71NcXI/XVNqC0yh2cz9fm58iFjgkQ7T8G6ql9gh5xq67RXHiDegHpKUfDL
 5KVLl99CEQNudAa4EBBQ4YH/aRvUxAp72MK4p5w3sqkMYciL68rqO5uG7HHOUHQWKRML
 9fmKhE4hNvqHv+yWqj1JXdHmgAZsVzpQgnK/VaLxaY+W//bS8BJcNNQSbleID96wC9mM
 GcR3J6i2dFHzHJPIqX3X3T5qOligS2JDsd2SLJ861Qvt0eNo7EFnRj1MbBiNhF0sVO1u
 9sUA==
X-Gm-Message-State: AOJu0YyoKk3gp0flWfN8K77HHwcirWtjk12+X3dq3/AJhLNBgATaHuTQ
 2ADxZQ0dOiqyg4SPqFpIHJ7a2sy6C0N+iqUf4zHodWW4i9UZoX5yXPX5he+mHhuYbbRwy7h1WBQ
 o6GhCoXx0+39dZn5NXZme4UvihbV8HuM4RX/6
X-Google-Smtp-Source: AGHT+IFOHDdWQg0N6YugrFHlxqcxeH4zjU8X9Bmly+QK0lBeUWzSizj9f/QmI5g91Q2f1k6OQVXuQSqdbwHcACoDRiA=
X-Received: by 2002:a05:6214:d8f:b0:6b5:8913:d63a with SMTP id
 6a1803df08f44-6bb56303455mr141014246d6.12.1722266929642; Mon, 29 Jul 2024
 08:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
 <20240727071742.1735703-9-patrick.rudolph@9elements.com>
In-Reply-To: <20240727071742.1735703-9-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:28:38 -0600
Message-ID: <CAFLszTh3oDeFTFRSQU944Zg6NrLntEyq-AJWghkXokYa0-ptsg@mail.gmail.com>
Subject: Re: [PATCH 08/17] acpi: acpi_table: Bump revisions
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, mbrugger@suse.com, pbrobinson@gmail.com, 
 trini@konsulko.com, bmeng.cn@gmail.com
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

On Sat, 27 Jul 2024 at 01:20, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> The FADT structure found in U-Boot represents FADT revision 6 and the
> GICC and GICD structures defined in U-Boot are based on ACPI revision
> 6.3.
>
> Bump the table revision to fix FWTS failures seen on aarch64.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> ---
>  arch/x86/cpu/tangier/acpi.c | 2 --
>  include/acpi/acpi_table.h   | 3 ++-
>  lib/acpi/acpi_table.c       | 7 ++++---
>  3 files changed, 6 insertions(+), 6 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
