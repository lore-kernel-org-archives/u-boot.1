Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F065E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 19:48:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B44D8035E;
	Tue, 17 Dec 2024 20:47:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QLVH6hxH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B1A08035E; Tue, 17 Dec 2024 20:47:28 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FEE680291
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 20:47:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aab9e281bc0so581337766b.3
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734464846; x=1735069646; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lu6vIRcH3gwbD3mTV8+GDXIz9Sxh/pIF+gYyXivFVsc=;
 b=QLVH6hxHCyIkzrO1YToxaEHM2asEHjbtsMkFZA/vNvdaCMcOHZ6oXL80RuwGBkzDyr
 TsIVFLg38OA3Nup2f+f43n1fzhgmwMaK2CUexyn+ZqDHSHZPZRf9Gp6k4gccAUvN5jhJ
 bNdIGKn0/4eqOYhHRqt55aZJOKg3qUd0Ckz3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734464846; x=1735069646;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lu6vIRcH3gwbD3mTV8+GDXIz9Sxh/pIF+gYyXivFVsc=;
 b=VyYzp0E6cFmd+sAX+hvH6s5QfJZNxAy4cPpjvclIkJXXbZ9HMwqxIQP2wRwDDxcVeQ
 ltsUyG5X0xJddz/N7mWpZQeAZsrbUKaswHv1LIPUxb2CG3klttxJluzQSIcAIqTzlAK+
 PXqsZX6kptwyJDJ7eetyfOrBvaqlfctr/pt6GgkG+rMYKANK9BlIqo5E4G2D+hpRdx9m
 eM93HYz8Jj55EaRkNSUdfxl6Q574/LtOwkvBa/QZebPvGEbZD89FiKJyCeodjh4dtRmm
 CQQjTpWFWuZMDRPd1Ix+mnRgRLk4kWJqT/fkbXm08Dbl9G35S3hkm1caz6pK5rebfmgI
 Spwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtqHrYlvAmF8QMbtRT+ALupkHGIaLb/J2Q0IkmBx2+lWjvHhwPnlroaH6FTJ6R6BWIGjRxzng=@lists.denx.de
X-Gm-Message-State: AOJu0YwcBf54+z3KDstR7UlH+OfhwIFNijIq4N1xFHhec9N5pg31hWgP
 wo08fYrpvocdEg6eI8cMJTzQ8nCxPch9m5LiNDFvA6lPUIqZz4Qki31GYD+gHZ9/7ec4WGcHBuF
 X3SzvQ0G7AHWsKFocCvEQbelJ0Vq62xZskA7i
X-Gm-Gg: ASbGncvOcVk4mCaNTktIWS+kgK57vxlktsWnLvu0kDB0jIKmQASJQVNB6vN+k/3zrA9
 OrCIxNXHkagCDl+wY69XYHLW31T+3Qr4mcgdTzJo=
X-Google-Smtp-Source: AGHT+IHkWeY2mtCoWTW3Rv66l0Xg579cSVdPxPeoVrtOjyzDzbX6QYA7gnZB90MWAnpyYzPxzPgXaW8A/qCL9DmVigI=
X-Received: by 2002:a17:907:8694:b0:aa6:becf:b26a with SMTP id
 a640c23a62f3a-aabf46e9e58mr371366b.9.1734464845752; Tue, 17 Dec 2024 11:47:25
 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Dec 2024 11:47:22 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241211135418.563803-15-sjg@chromium.org>
References: <20241211135418.563803-15-sjg@chromium.org>
 <20241211135418.563803-1-sjg@chromium.org>
Date: Tue, 17 Dec 2024 11:47:22 -0800
X-Google-Sender-Auth: Z2alwFSaU-g-gHIRN8nRJyuQ5Qc
Message-ID: <CAFLszTgPR_XPpB-aBrzei-2sWuKfEzs+-UAeM6ROpv95qJ0MCA@mail.gmail.com>
Subject: Re: [PATCH v5 14/23] efi_loader: Rename struct efi_mem_list to
 mem_node
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

This struct is really a node in the list, not a list itself. Also it
doesn't need an efi_ prefix. Rename it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_memory.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

Applied to sjg/master, thanks!
