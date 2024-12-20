Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6AEE77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:05:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6F97803D1;
	Fri, 20 Dec 2024 05:05:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YrXtoUpT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E49ED803AB; Fri, 20 Dec 2024 05:05:11 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A260680362
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:05:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d0f6fa6f8bso2263846a12.0
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667509; x=1735272309; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hz+7sQKUvq3OMNc+BMBVlT6hZd2GOSFoNu1gWZ3Guj0=;
 b=YrXtoUpTyawdYE+O+91uEay9Hxvk3cSiEf4/1guJk/fE9e/cdLFBVHAtIA6YarbTlf
 nbJpHwhhx7COXmLOTJRoDCE20B9ovmwgJp6IXrHP8s/xOhUSuXCxd2JVpvxpwVvM+EpB
 F8ZTi9/KpDwZyScKOzIpp0EUB7FfYpjWQLIrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667509; x=1735272309;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hz+7sQKUvq3OMNc+BMBVlT6hZd2GOSFoNu1gWZ3Guj0=;
 b=fng/hnsmsHFydAjt08fp0OMEskFgBcHsEGBelAAHiGIGcgZPDlpGBQpPJBik1Y7gj/
 FnpwCU9WDVzlhs1aa3YbsrNJzBkFyAs1W/fZxjX+KVzJWAYyzLYluu20wfwgotwp9TTI
 mvcMDezng9KEBCK1hqqkYX0HVtMnZF7H7sglEzqfPavvBwL1JTC1p1QWjYezTZedaOTl
 ZlituVe6YgYroMAwguerxT+adotimx4z6UeIDxXzuG/AaWrEgAykbsP9xM7TO0MJ4P/i
 mv1aoWkUoDGDD+aGLJInIRt8WQH56QLAPOsx219fnv3R9ME5HGhUukjXPF20NFyLsEX/
 tekQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3qUyCdOAQs3CVO/HXunIy1qPSBF9e9ory2OXH5vh72Nw0zhD6/jnBc/HLZgS/zHvghpdSXxI=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+xxPdctU9dErgsVAfqrctNvmMn3vLMcd73b01pjiwMUy8JAry
 6CHrEWhhadigTsPdT4CUoGKpj0cRUSIgEuYwrg5TXmxHWojS5JeBtww14V9o8KixP3rzyS/Iaal
 HDjWT9vmiAWAqbgGnyrGmStW9gg/8Et7UIITm
X-Gm-Gg: ASbGncvjGNH6cMiKse/yoZmVWnyZoZ3bhYlMC1G1DlQv4qQpzUTgucpkB/EReFzJaU/
 tJoviVD4MrJsCmPRTEsR8XQG3Afb1jn+SHXrLBaQ=
X-Google-Smtp-Source: AGHT+IGwmYi1G2vI9vhrhsw4grYXRq8FE3oe+yajY/3nxEBxE5+XMsDlmFj+lfrHaO6ZhtHOByE12xH/4V+DGF2PanQ=
X-Received: by 2002:a17:907:7f0e:b0:aa6:c169:4e21 with SMTP id
 a640c23a62f3a-aac27028286mr93724466b.6.1734667509143; Thu, 19 Dec 2024
 20:05:09 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 22:05:08 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-41-sjg@chromium.org>
References: <20241206023626.2456858-41-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 22:05:08 -0600
X-Google-Sender-Auth: PJr_oQ4au4xxr9grqmDPwHRstpg
Message-ID: <CAFLszTioVxkRc51Y4YTf3mdxyhb4AiKXi-zjx8q7mYeUWeKLaA@mail.gmail.com>
Subject: Re: [PATCH v3 40/46] bootmeth_extlinux: Move boot code into common
 file
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>, Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Nam Cao <namcao@linutronix.de>,
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

The extlinux and PXE code for booting is almost the same. Move it into
the common file so it is easier to keep it in sync.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Pass through the bootfile since extlinux and PXE are different

 boot/bootmeth_extlinux.c | 24 +++---------------------
 boot/bootmeth_pxe.c      | 20 ++------------------
 boot/ext_pxe_common.c    | 25 +++++++++++++++++++++++++
 include/extlinux.h       | 15 +++++++++++++++
 4 files changed, 45 insertions(+), 39 deletions(-)

Applied to sjg/master, thanks!
