Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317E8E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 23:06:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F05E893E6;
	Mon,  9 Dec 2024 00:06:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OMf2W+LU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D660E89500; Mon,  9 Dec 2024 00:06:46 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD7AD88DB6
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 00:06:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5d3d14336f0so3399006a12.3
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 15:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733699204; x=1734304004; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6mcScgX5W+Tf7tTfq14ZkUCxgsvMhhJuG6Ig+GNDTrU=;
 b=OMf2W+LUXWozLISpje99Zeo2cXR1+dBtMnkyBv+MqqQgE4/0mBEMC41EIufYIOrGnC
 Bjqhb8hozBLvtYpyCDufRLdc9crb3TyHITBifJgPSk2YoF/S9Gg9iHxEbcF5MCMhZ5QI
 HG+HjOdeRTvoyQJ6SNMabptYeqQKRB0Rv0UBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733699204; x=1734304004;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6mcScgX5W+Tf7tTfq14ZkUCxgsvMhhJuG6Ig+GNDTrU=;
 b=iYn0/YW3idxruYskcSsM1w9vy+1TSgW5Msvy74kCxolbf8ji4jPfnbGZXD/oeDKvqW
 v0Nr3eUuKwhWLME33c5s+EeyZSDlm9dZOa6+pbWCIY4oT1ckGpZyg0abcozVmbt6/Xp3
 yt/ERqp/pb4k9NTYsoXYPP6zZag1zUIQMmVOxPXwciX0PIWpvk11teV57kL3F2Y72rDx
 8TFwEsDemn6Tsz90uay/m0uD75jOxTQzAFVWX4xH8KbfUDvpejaIqXhKwclm/BYWNFWl
 QXVeF/wrD/Ti7GlFxVPDxWdb1PbQdfYughgQ1gPI82bFvo0idwKIMn+Gyno5Yyuhed1w
 LCIw==
X-Gm-Message-State: AOJu0YzCevicCukFwG0J/EBN3vVPvrkdq4aNpPF5//gdrAR34ynGxLYI
 vKQeA/GNfkm8Z1gU3/wQ8QLmFGkH5xPfLyOvR6fjXwVQMiBum+o/JFUT80wTg07DjJKPiD1sZ+i
 mD2oNPri9US59qC7YcQGXjME+ScPNlm3yh3h7
X-Gm-Gg: ASbGncvi+SCtC255U+Jelm76roS+IbgODyBj1VD+Q8uvD2/wPQqtO2JGzzt9kg50qXX
 Y1Cz7Iplmk9j6Z+fja8JK6qSwpiMvgH9DQQ==
X-Google-Smtp-Source: AGHT+IHtds7LJOnp7Gj7KZXfDABN91G8Gc4yZhSvR2Sxh8fIXJSSchk0PxSd/nnmUmQuIDDguvvgOimym8DLy2wSaIY=
X-Received: by 2002:a05:6402:40c9:b0:5d3:bc1d:e56a with SMTP id
 4fb4d7f45d1cf-5d3be6770ddmr9988256a12.8.1733699204106; Sun, 08 Dec 2024
 15:06:44 -0800 (PST)
MIME-Version: 1.0
References: <20241206101132.1094545-1-jerome.forissier@linaro.org>
In-Reply-To: <20241206101132.1094545-1-jerome.forissier@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 8 Dec 2024 16:06:31 -0700
Message-ID: <CAFLszTgEnz51jScGJ5H783bxtKcdd3yP3tEGt4LkRDvMpMEhTw@mail.gmail.com>
Subject: Re: [PATCH] trace: proftool: dump-ftrace should write funcgraph times
 in ns not us
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

On Fri, 6 Dec 2024 at 03:11, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> When converting a U-Boot trace records file to ftrace function graph
> format for use by trace-cmd ('proftool -f funcgraph dump-ftrace'), the
> time associated to each function is incorrectly saved in microseconds
> instead of nanoseconds. Multuply the value by 1000 to fix the issue.
>
> With this change, the trace-cmd output looks consistent. Here is an
> example with udelay(25) added to mem_malloc_init() as a test case:
>
>  $ ./tools/proftool -m System.map -t /tmp/trace.bin -f funcgraph \
>                     dump-ftrace -o /tmp/trace.dat
>  $ trace-cmd report  /tmp/trace.dat >/tmp/trace.log
>  $ vi /tmp/trace.log
>  [...]
>  u-boot-1     [000]     6.719659: funcgraph_entry:                   |    mem_malloc_init() {
>  u-boot-1     [000]     6.719659: funcgraph_entry:                   |      udelay() {
>  u-boot-1     [000]     6.719660: funcgraph_entry:                   |        schedule() {
>  u-boot-1     [000]     6.719660: funcgraph_entry:                   |          cyclic_run() {
>  u-boot-1     [000]     6.719660: funcgraph_entry:        1.000 us   |            cyclic_get_list();
>  u-boot-1     [000]     6.719661: funcgraph_exit:         1.000 us   |            }
>  u-boot-1     [000]     6.719661: funcgraph_exit:         1.000 us   |          }
>  u-boot-1     [000]     6.719661: funcgraph_entry:                   |        __udelay() {
>  u-boot-1     [000]     6.719662: funcgraph_entry:        0.000 us   |          usec_to_tick();
>  u-boot-1     [000]     6.719687: funcgraph_exit:       + 26.000 us  |          }
>  u-boot-1     [000]     6.719687: funcgraph_exit:       + 28.000 us  |        }
>  u-boot-1     [000]     6.719687: funcgraph_entry:      # 37971.000 us |      memset();
>  u-boot-1     [000]     6.757658: funcgraph_exit:       # 37999.000 us |      }
>  u-boot-1     [000]     6.757658: funcgraph_exit:       # 38000.000 us |    }
>
> In the above dump, the udelay() call is reported as taking 26 us which
> is consistent with the timestamps (6.719687 - 6.719659 = 0.000026).
> Without this patch we would have "0.026 us" instead of "+ 26.000 us".
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  tools/proftool.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
