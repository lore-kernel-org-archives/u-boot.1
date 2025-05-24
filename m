Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F999C54E71
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 05:06:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB93C8353A;
	Sat, 24 May 2025 07:05:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hEzTlbFh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8EDD83443; Sat, 24 May 2025 07:05:54 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 939D4833FA
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:05:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ad53a96baf9so84795566b.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 22:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748063151; x=1748667951; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eTcYEEGVHY+X/aoVSWumIgvOuex1RtGUxpTFlznytV8=;
 b=hEzTlbFhpzCmfnToFg6mgW4HkjK+/TgSGu4L7CUz2EmHhskkrJSAwUr0QDzgA7XpyI
 b2Gu/CQnfttSY+vepLungtpJWWOsnW3kQobnpNUhkInVWkXoOYcmiS6Y6lEzvocXKXCu
 /BFD6a7sRszeH+9RVQQ25bRDCE5FA3O9O/bA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748063151; x=1748667951;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eTcYEEGVHY+X/aoVSWumIgvOuex1RtGUxpTFlznytV8=;
 b=nrVcG8dr7LSDUKeSpibE+7KdMn97Z4tNnJ6z3KvEtOVpQ97Zi3YR5QIdmPIBadM6Hp
 9RV9GwiacglSV72l7K1NGpaiLjKYP88je2uaruRr+IpiCpdfhedfR87qW3tCufTqnv+W
 djxMoOQrC4/5pNADnDfFevjTFL2uaeJEz/IERNW0je81IIY0O5zi/58HaWtJefQegjPr
 p3lfsVfn1VKpnDVw3JuXVNXTb4SB1t9+tV3F0T/U1MMvb1oCg4Huk7Hb3y3xKFiIUbyM
 tGXC4nYomu83tlwFqtBfMe3e38a7MV9wlrpy0VsTZyF80itD3zdMhidA+UnfAeUY2wet
 fS1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqf5Dqg/aowMDk3SMjexA+dCxwFWJ94ruQU+rXo0xx9s/HENcxNedxOpElh9bsdqS6Cmx1NO8=@lists.denx.de
X-Gm-Message-State: AOJu0YwQ6wn1nKv6oCnDG4PNM4XEN/IG+G7OxzQAIhrXDQd7zQDyRBaF
 pONuGKODBNBOpPv/+3F1LvEzTxOWwD3rdUF8qu7epFoqeBF54uUnEidkAukPmxelhsxqXoVnIAj
 jbywAo3MwpT5ZlSdm6lK8YfL6VbzoGlZN4IdLdCFDgIYyAxnRn84pFKL8
X-Gm-Gg: ASbGncsLYq8WExcCpke2kt35nGSmbInySpWp6T2bPmdQQz5PjzsWuuXOxgkUbU6Dn8M
 RzzJUfHNmZ/JLikfILPP4SEtXvknymB3dVy+VRJ+P1ca/6Vhqpckj2oXLrx1n4RkJDYhp9by9O3
 4sCFFmKZGusVYrCNNfWZxLlM+ADxJ7pc7i2mgR+DfQGw==
X-Google-Smtp-Source: AGHT+IGlIpXiNu8lmEadRAu2SC1Z31+aMeuwTi0A39jA//VSbxQdiVDl7wUU7rk14R/ooTslKoya1S/f+zpCtjZmk54=
X-Received: by 2002:a17:907:97ca:b0:ad2:1cd6:aacf with SMTP id
 a640c23a62f3a-ad85b306987mr117478166b.47.1748063150920; Fri, 23 May 2025
 22:05:50 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:05:49 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:05:49 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250510110535.1453745-21-sjg@chromium.org>
References: <20250510110535.1453745-21-sjg@chromium.org>
 <20250510110535.1453745-1-sjg@chromium.org>
Date: Sat, 24 May 2025 00:05:49 -0500
X-Google-Sender-Auth: TTvzRh2pKbod20v91Aid4NJvysc
X-Gm-Features: AX0GCFtbVaEGoZpGUa780eFMdXJ_mc9zR9x87JJ_G3P4oVM4Piyaeuf3pxOczx8
Message-ID: <CAFLszTi1hEogFJgh1LkWgABA+Ws4Vkq42w+6gY1vMgkqpCLdzg@mail.gmail.com>
Subject: Re: [PATCH 20/25] patman: Support aliases for commands and subcommands
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

It is laborious to type long commands, so add some aliases to speed up
use of patman. For now, allow 'pw' for patchwork and 'st' for status.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/cmdline.py | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

Applied to sjg/master, thanks!
