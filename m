Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0230E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 19:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51C858022E;
	Tue, 17 Dec 2024 20:47:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bdnbdOTX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C01F980269; Tue, 17 Dec 2024 20:47:07 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C707D80107
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 20:47:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa67ac42819so920725566b.0
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734464825; x=1735069625; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AYCk3raWOfNOCCDdwRx1sohB3+2KHS+Nabtj1VwtYIM=;
 b=bdnbdOTXMc6EbU8Z8hfepVJWnRnlMw9BW6IdEny/oakVm2zZ0PFkHxdMdvvbPZ/t+O
 HDo/Q1egFPnbrLH9sv9JWWES3ksm2laTVcR6xIzEFXVAXDFZNuo6r/yb5S8/iQgVIlm6
 k3nL1lxNQAgh52XtwdprM/++9gaDOBoGvYr9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734464825; x=1735069625;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AYCk3raWOfNOCCDdwRx1sohB3+2KHS+Nabtj1VwtYIM=;
 b=cf1m/ObUUaZijFdVlrjodk6LWrk4IzyinVM7UMoKeipysxmsouskzUZX8dBxqQSLRA
 gAzfNgJVntbc3vcOKLf3urZh7jbmLERPfyJXuPPPHqcfQJ+fyY7tZDIJNu4npash5/pv
 gMkFA9HEUPpqc9h/Dm0FIDrTEVW8SwBAVAFCwD+3bgCP4EfjJRaUFcsqpRKrVpeROc52
 npNwp1+4uzrPvUL5Swc0IFFzE2NLlsNyffaYVH8YjEqDU9rN7bS0AAGzgk80strRPQ3R
 JRyYCVobxEO3fNIBzXDIGAO9BBaCHjIxck27nFvP1+aOgv+SMqf3GHXuYJ6rNmIbipll
 HySA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbZ37j7k46/kSpUIvrvMUfXgGwyAjOWq4m3NHiregQemtb6RK22r+wUGYExhBVNxJcr2T/CfI=@lists.denx.de
X-Gm-Message-State: AOJu0YywZnY7dFQY/7CCr/fRBiEIm2a2LoyumZq+sssA27emFua/shSb
 /Hh8/c3yEPK96gQrncOpob05y0G6ZeTGSmP2Zt/Q4TqJ7IlMEhk4eQh4Ktoy+tPOjln07LEBk+H
 5ASYQ9X2ODus9x7aMw3y9la2ezo7SwTSUYlgjQ65IyHkIEZY=
X-Gm-Gg: ASbGncs4LQftq+md8ar2DUnuLiZqQcqwcARHcpvOilBga6a1ZqdsmUtbYb8GxAdlWz4
 vi0oO4+ZQvbgzGyk1mqhyfpsyi2qvyQddL4tzHmQ=
X-Google-Smtp-Source: AGHT+IHp3uKRO7fvUaZvWrPCslf50lUpXkRptIM6ftgWgCepPctwf9tipsdd37zoMiHcEnME3zUug0VxUczwc1P3WCw=
X-Received: by 2002:a17:906:c142:b0:aa6:a33c:70a7 with SMTP id
 a640c23a62f3a-aab77ee59eamr1802402266b.49.1734464825278; Tue, 17 Dec 2024
 11:47:05 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Dec 2024 13:47:04 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241211135418.563803-24-sjg@chromium.org>
References: <20241211135418.563803-24-sjg@chromium.org>
 <20241211135418.563803-1-sjg@chromium.org>
Date: Tue, 17 Dec 2024 13:47:04 -0600
X-Google-Sender-Auth: pGyHDYzHGyceKb3Ywp7qCwI7KhQ
Message-ID: <CAFLszTiP40ncVx_f84QUBYdm6RWkF5speA5Hg30a8sx3AAQ2wg@mail.gmail.com>
Subject: Re: [PATCH v5 23/23] efi_loader: Simplify efi_dp_from_mem()
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Moritz Fischer <moritzf@google.com>, 
 Patrick Wildt <pwildt@google.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
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

This function should take a pointer, not an address. Update it along
with all users.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v5:
- Drop the enum / mem_type patch as it is not needed
- Drop the patch to remove extra brackets in efi_mem_carve_out()

Changes in v3:
- Add comment to struct efi_device_path_memory
- Use a pointer for the values in struct efi_device_path_memory

Changes in v2:
- Drop patch 'Convert efi_get_memory_map() to return pointers'
- Drop patch 'efi_loader: Make more use of ulong'
- Significantly expand and redirect the series

 include/efi_api.h                | 10 ++++++++++
 include/efi_loader.h             |  3 +--
 lib/efi_loader/efi_bootbin.c     |  3 +--
 lib/efi_loader/efi_bootmgr.c     |  2 +-
 lib/efi_loader/efi_device_path.c | 16 ++++++++--------
 5 files changed, 21 insertions(+), 13 deletions(-)

Applied to sjg/master, thanks!
