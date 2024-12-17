Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8E5E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 19:48:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E312080269;
	Tue, 17 Dec 2024 20:47:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nms5op/Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE7AD80304; Tue, 17 Dec 2024 20:47:34 +0100 (CET)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6947780269
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 20:47:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-728ea1e0bdbso4468338b3a.0
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734464851; x=1735069651; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oyb0KuR8TYqoLbMzUak+coXfuxrNY9HwePeNN7DIJpI=;
 b=nms5op/QWCRaNDh0LibZCj0GiomO50VbbIu+x0exb/vOvj3hoDDC9E32Uyjj2XcOap
 g0a3VBP3VxSOkTC0YFFnq36efQti89kFpq0EJkfCewD6QVJcnjAKLOqqZjpqYLKWkoVj
 UMDoP3owVgPThV5B6FocAXQSLPv3Zdu7Pl0Ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734464851; x=1735069651;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oyb0KuR8TYqoLbMzUak+coXfuxrNY9HwePeNN7DIJpI=;
 b=Nwr2PIPHqHvRhAobSVgxD2V/4PxwdKBP/wrnC6/hSVPHum+VaJckmEbnZolWR5yGUb
 +xiRqtzu1s+daV1hOnml0BtW8cmlSUovoV15+E09Kp393aCfE98CHoJC4PYz3lR+S892
 072RK7IoJYiltj06PsVR16HE7qnVbgOBSGvpyqtV/3KG5UvpEjs10Er2GwcJGxZs+/Hn
 ZC9uovYJlFhKbV+so+QYw6HMcYjIA3AKNzbG+kAKUuVgRZgPK8Kl6OSrujBDRwMjjUn5
 L/IaYQ+kYNG8URZzEGW7EOTS4cOKCymzbnef1G1vk+oPPs0o/aAVLTUobZV/ZjozlCml
 Sbag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWldPxoOBCZf3S4Gyt+m+PrQVlhK0vBuQ7rvDbw4JfRaGq76ss8nt/121zmPDUxAXl+sWsXhxI=@lists.denx.de
X-Gm-Message-State: AOJu0YzhkAMpDH2T/HsHCoWnHs9PrBQgqq6ZpGPsTHwUB4M/JUOZ4Eor
 X5FhFZteGhG+a+ouBp1zBTNxi3I97GTKmVJXuXijt2t403Xy6Hc+ZUnoaCkFvdjki1Fp7cZR7S4
 JhUPoReqKcbIzc0rbTgCp1/P30QqDeg69fFwu
X-Gm-Gg: ASbGncuzxN1jTf72/eXmETNrVqQtJrvMw6F7uBX4tUkR/Os7OS0fAPbIHsa02sUcl5Z
 5lLlE5b78bTlS5+4qQlctV4j3R/E3ILNElbBV+5w=
X-Google-Smtp-Source: AGHT+IEGkPpV5A17rGKItjQptUIthZT4V1TkCtLCmT8K0rqZ425lS93iXXtCApNCbUTIHRKjCOTDUF7cC9ifyLnXu8U=
X-Received: by 2002:a17:90b:280d:b0:2ee:c91a:ad05 with SMTP id
 98e67ed59e1d1-2f2e91a9896mr206612a91.3.1734464850855; Tue, 17 Dec 2024
 11:47:30 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Dec 2024 13:47:24 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241211135418.563803-14-sjg@chromium.org>
References: <20241211135418.563803-14-sjg@chromium.org>
 <20241211135418.563803-1-sjg@chromium.org>
Date: Tue, 17 Dec 2024 13:47:24 -0600
X-Google-Sender-Auth: UCOYMdoYqAXu5ZcwdPIdzKmvTsc
Message-ID: <CAFLszTiPniky1ydUY2o=JVskj2eoZxxARAGR0nD8688LsRkQ1A@mail.gmail.com>
Subject: Re: [PATCH v5 13/23] efi_loader: Move struct efi_mem_list fields
 together
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
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

We don't need a separate struct for the values in this node. Move
everything in together, so that there is just one struct to consider.

Add a comment about physical_start, so it is clear that it is really
a pointer.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_memory.c | 85 +++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 46 deletions(-)

Applied to sjg/master, thanks!
