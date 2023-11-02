Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045DBC0018A
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 22:49:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F4898770D;
	Thu,  2 Nov 2023 23:49:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VI0TwuBT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9C2E87735; Thu,  2 Nov 2023 23:49:17 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51BEC876DF
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 23:49:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-d9caf5cc948so1494273276.0
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 15:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698965350; x=1699570150; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4FZWD8y+8EeQ1EiLu7E2C4lV+BgA3Iv+5Jp1Yy7/0wE=;
 b=VI0TwuBT+C2mkt0g2zzgzFmVEPWyQw2hRa45O8GAkCmLkMMb0QH5TsWoUeKwkRXO/t
 TruWgXz1V8rjzzvNQtBUksTRFoIQkPLL2x7IrEpdJYQK1K6bqM2GoKqxm5hK316Xas3z
 N2huYHCuG9xZIZYK+30RJzf9lalvwVoeLqyOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698965350; x=1699570150;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4FZWD8y+8EeQ1EiLu7E2C4lV+BgA3Iv+5Jp1Yy7/0wE=;
 b=IQuvwpKWmuOTm2dPAgFOKPl43U+lnLtfjt+4pKVRPqx9M27YVZv6AruANqNERKp1cx
 meptxSQxrpobcrJhpnPgmEGoj5SoW1GvYlNautppwNSvX6329NY8s6RyPDvCNB53hBTj
 BGnR/DCjlyJLhc4bkTeNCw6HZZroS9VYqOdQBVgiFxuwBty5L0r4LcqTXG7WuoxZoM67
 hS+Hsau292FbS4wm12JOc3d7IFoTCVxBtjJiisTAMUfob2id6JUsWvvgMAUTdFzQQmbt
 x586KmvfugKgOgXXtwQaYYgmYj4JgpfeIjIv7Cgp/Mb3QVwQosL0sLJ6zvz8ecKnDOUU
 R9kA==
X-Gm-Message-State: AOJu0YzKK4Jn2R5iC1ULljaCHrU5EkKqxqH89zryeF/nvKzLM5Th0KGb
 NafSKAu+olo8oF4N0O8TT4A3iPnZtA60CiRi7Csi2BvN03SPatp59po=
X-Google-Smtp-Source: AGHT+IG+vJBzLieeEI08nTFJRiUwJEBQKBWNZ0KdcTcUb8aJDwhT+Q8VRAXDaREXolTjaWSzOdCbKSRbq2MBDG7OIn0=
X-Received: by 2002:a25:7407:0:b0:da0:39ed:3ebb with SMTP id
 p7-20020a257407000000b00da039ed3ebbmr19434528ybc.3.1698965349846; Thu, 02 Nov
 2023 15:49:09 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Nov 2023 17:49:06 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231024180342.GC496310@bill-the-cat>
References: <20231024180342.GC496310@bill-the-cat>
 <20231024063047.20874-1-heinrich.schuchardt@canonical.com>
Date: Thu, 2 Nov 2023 17:49:06 -0500
X-Google-Sender-Auth: OkDwfBdKftRdfYP2TwZ6vwyEmsM
Message-ID: <CAPnjgZ0K80wziHJxCeASzm63r8CEmUt7h-Rf_rtBdfbdq0kBew@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] sandbox: eliminate unused functions from binaries
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Tue, Oct 24, 2023 at 08:30:47AM +0200, Heinrich Schuchardt wrote:

> The sandbox should closely mimic other architectures.
>
> Place each function or data in a separate section and let the linker
> eliminate unused ones. This will reduce the binary size.
>
> In the linker script mark that u_boot_sandbox_getopt are to be kept.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

-- 
Tom

Applied to u-boot-dm, thanks!
