Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDA7CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 23:57:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B316836C8;
	Wed, 29 Oct 2025 00:57:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jfYOrB9y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44975836F0; Wed, 29 Oct 2025 00:57:33 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 298F1832AD
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 00:57:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c531b42dbeso2561400a34.3
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 16:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761695850; x=1762300650; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s7ED0zfWwnuzx4kUZHj+3mGyS7egqhIqrz4d3eVJqis=;
 b=jfYOrB9yB4kZgv6ug7Dy1OVjZv2C6YoGnIU51I8UnAekwT1JnerRTTz8y2h9RFREwr
 gVW5pvBsBIsNIapHtlD9mPGTC9nEan8uhyV9oobRTiYuJbNJF/g4TX/fvj82s/jWDXj+
 iZz4WR4Fn062QrbroHPkE60CtAyUE0UPyZVH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761695850; x=1762300650;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s7ED0zfWwnuzx4kUZHj+3mGyS7egqhIqrz4d3eVJqis=;
 b=gdOMaBnKrJVSFw9h1ZKUEwkeu0/D6iJMYZ9IHsZGf2L+IBy5oXNpf1cofNjmMMLGMl
 4zHooaY3G5EmbXTYlL8Iz9y+nW/Y2A97yiTKxlgMJz3IcV0Bh3jAp7I0C7bMPvhExLIz
 IH9Pu0k7dGMTLoDvX80RgGCNigh8udK4bHLJoWx/Ts8N3yqj5gMw9TKDQLrEAhNSqmri
 nupQ3Cpn+ktP0hp4NmKeCgGn5l1CgbqPdMf87CT5xlULDCyp9ggy7XC/QYSEDtvabDg+
 FcWkpDhPhBk6HLEvAaZ7nbsr2L1prZEGtdw1w8OGCCGSruHZTrEsnyZvE+4FFevpbTXC
 SYng==
X-Gm-Message-State: AOJu0YzaEDZcJqTu5yUqKUEtfGoU4+hNNs/tlgWijfyInfSl8KomySWx
 VdGFAQQtLp+D6KFyzL7SMtmUzCh75ZdNa5x46EJAehowGblOwZ1Cs6gjtaktw5VsmEM=
X-Gm-Gg: ASbGncsjw4TkNXRaI6VqtiXhprELAcrwA1l/g6Rs2DVC4NhepvudAQrRuXpZgMbq028
 PBrNlHBWC0HCELt4CtszL2nQ2H+gBDL0nA/H9LGMoZKOyXpEvKxrpd/LJwtXizOARvki3cfpQax
 hYkl5bjfTjL4dhmvvSpCLbB/7d45sK72P5fyJWfD/DGy6dSh4T3AIhXE9j0wU+AuL/YpZKQZ1Aq
 cUL0eBc3KOkwUh2QXqGi3jOdIZ7Dc44oKnxRkePXofq1p3bqYeGnsEb18oNCfCfZIVyOq6PSVl4
 4ytuo/gYFygQeJ4/rMYF0rf76BDhzrqHdYvbWEHOsvCY8qwk9s7KTzkXZtJ3CFzqGtkXK5lSCph
 0UzSMukXdgbVQRk49SrdNbGFM2tTq/rMJz3Bv+cY6bVW1MzQqE3i3W2ZAaMtbAl6NoriVQCU5Za
 R4B078XSJCIH2+88cIq7qByUEhTqv/4sQ8ioeElw==
X-Google-Smtp-Source: AGHT+IEBI7ADtFpwJo7prTazWHw0tZ6XGLpI5neyB1ah34cP39ZQoBCzAog9idpaBnOI93zopoV8nQ==
X-Received: by 2002:a05:6830:6b0d:b0:758:1417:7ee7 with SMTP id
 46e09a7af769-7c68301c245mr806509a34.5.1761695849885; 
 Tue, 28 Oct 2025 16:57:29 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c5302068a6sm3646234a34.25.2025.10.28.16.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 16:57:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250701-mtd_nand_fixes-v1-1-f31517bdce2e@linaro.org>
References: <20250701-mtd_nand_fixes-v1-1-f31517bdce2e@linaro.org>
Subject: Re: [PATCH] mtd: nand: Prevent dereference of NULL pointer
Message-Id: <176169584897.2287207.14049608243634191586.b4-ty@konsulko.com>
Date: Tue, 28 Oct 2025 17:57:28 -0600
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

On Tue, 01 Jul 2025 17:12:44 +0100, Andrew Goodbody wrote:

> In nand_wait_ready there is a loop that includes a NULL check for
> chip->dev_ready before it is dereferenced. Use a NULL check once the
> loop is exited as well to cover the case where it exits due to a timeout
> and it is therefore not known if chip->dev_ready is NULL or not.
> 
> This issue found by Smatch.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] mtd: nand: Prevent dereference of NULL pointer
      commit: a5c83da3ccb372133fdbe43e0a8e65e06b3291e8
-- 
Tom


