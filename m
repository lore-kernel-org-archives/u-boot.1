Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA84C47073
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 00:19:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3869487ABE;
	Mon,  8 Jan 2024 01:16:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i6zGMqXo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 273CA87AAB; Mon,  8 Jan 2024 01:16:35 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3021B87A70
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 01:16:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-67fb9df3699so14486386d6.2
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 16:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704672984; x=1705277784; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F03KOHNoBPA7vF6vsl+UH281N3Zf8YGr5JyORhbnmKk=;
 b=i6zGMqXodkvLNcRusUHNysJGTr5Nj1ix2bV+1DpXWET27W+iQb15f60dEjbwEOyfVJ
 6XUyt9mI1klnuugItCk+G829tODHGK54Riizl6gf0oGCdiqzeVUSeztgRYtiDM1QgQmQ
 Wa/qxJEWpnF7Nxx8AroEqVvuSBr77jdhNsCFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704672984; x=1705277784;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F03KOHNoBPA7vF6vsl+UH281N3Zf8YGr5JyORhbnmKk=;
 b=lcKcPsbN0sCGba421f1tzdKVwkJGxid/5wKo7wAOAR82e3w+QqsHvdPyC2n7FP9iN6
 8LVrNWvxvFKmsBGgIWzIJnTo1wN6GOHe7QAUqBdap9eg6NAmrfw09E1zbIjuEdiecw16
 XYoUWg4OOEbW9V3g0RYfERDa3usfRG95FEtDtFbwphcVfOtBcvwUDvhuKdVtpa7X/6D1
 0v8TPIRie1rc85pJhThKJ4ftjrYoibHNiW5hSJ14jmcL+HwsUlKjrs1IniQHfqQMQvPm
 gdXBgjj9oxSLtw1wqvqtyKU89ridpzJI0t9gFVEVnePNpsnjgWj8rsN/j17yGr4FXCCS
 jeBg==
X-Gm-Message-State: AOJu0YwZhiIPvlxbZQ9anZqKH0VqAdg0NJGMakODTuvvH3WBgM0QL0If
 nyrrvbsVlsn7uYKbChjRjcKpq9PsXpweDJ2MoQt3VI2HbCqL
X-Google-Smtp-Source: AGHT+IHj6i8iegcRGcm5kjnIQ2kKpFK+eiGYfB7ouLBNtzCDZen+dPyxN1EJJZwCjKTXpbJ8tvyThHwN+/JdduYwwQM=
X-Received: by 2002:a05:6214:d4d:b0:67f:4a00:c423 with SMTP id
 13-20020a0562140d4d00b0067f4a00c423mr4897791qvr.2.1704672984100; Sun, 07 Jan
 2024 16:16:24 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 7 Jan 2024 18:16:23 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231219150408.10949-9-heinrich.schuchardt@canonical.com>
References: <20231219150408.10949-9-heinrich.schuchardt@canonical.com>
 <20231219150408.10949-1-heinrich.schuchardt@canonical.com>
Date: Sun, 7 Jan 2024 18:16:23 -0600
X-Google-Sender-Auth: fWkoPnxNr0P3QvxwI-t6oLL2EOk
Message-ID: <CAFLszTjtq6oxw-HojFOgtRC=jAU675=M+NrYwnR5bb1Wf9erhw@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] configs: qemu: add config fragment for ACPI
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>
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

Provide a configuration fragment to enable ACPI on QEMU.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v4:
	mention that QEMU v8.0.0 introduced RISC-V ACPI support
v3:
	no change
v2:
	no change
---
 MAINTAINERS                         |  1 +
 board/emulation/configs/acpi.config |  3 +++
 doc/board/emulation/acpi.rst        | 23 +++++++++++++++++++++++
 doc/board/emulation/index.rst       |  1 +
 4 files changed, 28 insertions(+)
 create mode 100644 board/emulation/configs/acpi.config
 create mode 100644 doc/board/emulation/acpi.rst

Applied to u-boot-dm/next, thanks!
