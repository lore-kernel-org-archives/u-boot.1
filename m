Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1CBE8538E
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 19:49:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6F98841D6;
	Fri,  3 Apr 2026 21:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k1k6hgNS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3645841D5; Fri,  3 Apr 2026 21:47:26 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E2D98413A
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 21:47:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d74aa6bcdbso1191373a34.2
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 12:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775245643; x=1775850443; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WkGdxbumjepwOZYBWMhyMv3s6lXUFdw1+veYGW6NDCw=;
 b=k1k6hgNSoSczogehjOgXR9aep9u/5FFZotsm9Mso4mrMB6SjmYFA/8oRWIydDY+c8A
 aDGO7iIEBUJLYL/8g/KI9f0rrY1Fi3K3qC1flzOVKtCp5f2N6PR+ItO5H7aV0VZHuAE9
 GcTUGcBR5YNGlMRnIL2anpF2pfvttrriR+0xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775245643; x=1775850443;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WkGdxbumjepwOZYBWMhyMv3s6lXUFdw1+veYGW6NDCw=;
 b=YncDl4sccauLhIabp/M8CB0gj+Qduf7oTWhX9jFLeYAJKg9dTLSw5RUVdUNUzZQiZR
 YPefS+W+ghDq7AN61KT8aIb5ZXD2apXjvCBIuCnMXmUfG1ZSTkrMNtTClon2mQkxaYzz
 nkGKaxf7JIIR6gysbX9EdJ9kuaaHNlVgUPdCQak00oR/+Tq5pqtSFnWAN6QPvVKty3yc
 QUJKi6s+A6IuwXONOHaA8j7yiyo7Y/bUQAlp2QtnpYTIuEy+8SPfG9W6J2DxdvyM+fGq
 hg2CDxQRRLTelYdlo/zocUfWtAj+XvqD858jbT9hKekNiJMSCqZAdDae7J1ypXBHAXmr
 CK5Q==
X-Gm-Message-State: AOJu0YwIdvZelxBXaKE3W8aZ9ZqclXO5nKq2zEpMvcd0G6q7ZaVniwMe
 3VAebBrEX3VnkJLev8zzlzY0RauIxWzTVWqbQZIdAwCf+FTUgYTp0XuJKuOJ449p3fD26jIEvg4
 39iasgt0=
X-Gm-Gg: ATEYQzyyHioS8zBxkdX+yqK6gKZ6zA3CVZcywR5LTRR7lOoPcQk8MzPdqgnDgCGZmmc
 1N1gnjI6tRT1GXwbmy/T+MfEiSKvpsiqBMAENRbwgno6Xvd5eegY8pfieH838jzqX8nMXXVPP1E
 Ap+tpzt+1E6hXWqMRg/iIWAVL55I0lBUD/7zudcKF3u3fqHOnamlG8beicmszNpRFugHD74h3Ch
 SdolNzZPmvyocwHhq7WM6HWPA1u08+MwL7hrb2vOOakrsP+LTCAodI1rP43qcYRbRPHxBRyQEhA
 nbQYQZkz4oHGcZ3EjErwq+XoRP2XVAXOQghjh9v1owF8RBxnzUvBk5/bh+EFxwwsdmwR3IFgwQA
 MPUNaiA3Kci8m8qoWOTNDho1tuusgJNwazs7Zc16JSZIt6lJMqL0WWio6CkEwEhVKKz6mblhGIW
 dMMJmVfES1sGn4SxHk705W3BDotZ/61BTYScUyvy2lvcfYmG2sF5YsC0S5WuMyfifk9jk/cvT3A
 SLKvZEY941MuK+m8+iV/FHHB350xemhlyc1AxTbRM+kK3c=
X-Received: by 2002:a05:6830:83a7:b0:7d9:9310:5e87 with SMTP id
 46e09a7af769-7dbb72b98e4mr2310983a34.23.1775245643370; 
 Fri, 03 Apr 2026 12:47:23 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dbb5c96485sm2544954a34.22.2026.04.03.12.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 12:47:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260320205347.3789062-1-trini@konsulko.com>
References: <20260320205347.3789062-1-trini@konsulko.com>
Subject: Re: [PATCH] clk: Add missing dependency for SANDBOX_CLK_CCF
Message-Id: <177524564288.2281750.18242216162424518829.b4-ty@konsulko.com>
Date: Fri, 03 Apr 2026 13:47:22 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 20 Mar 2026 14:53:46 -0600, Tom Rini wrote:

> In order to build SANDBOX_CLK_CCF we need for CLK_CCF to be enabled, add
> that as a select similar to other drivers.
> 
> 

Applied to u-boot/next, thanks!

[1/1] clk: Add missing dependency for SANDBOX_CLK_CCF
      commit: 2e676dbf073c377392261fee3990351c1e2591f2
-- 
Tom


