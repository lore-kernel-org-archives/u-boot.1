Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC08C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 21:12:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43F1684AD6;
	Fri, 10 Jul 2026 23:12:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lcG2Q2ZG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EABAC84AE7; Fri, 10 Jul 2026 23:12:46 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A93284AA4
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 23:12:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c9e7391839cso1201809a12.0
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 14:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783717963; x=1784322763; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PqmtHnV3RmMu2IY/so6P3i1fbw35yKVwNRX4cUBXBvc=;
 b=lcG2Q2ZGZZnD8PFaaoQZDg9tOozlPOhbufh6nK/ZtyAB3Yt93RZLEtrO9ICpYY56Re
 7E17c7gC2tZlb2cZB4FbU3YMsDu1z/gSh/UZ9jcKVST5QccSIsa3Onuwh5M70GBc3Qit
 d39QGSEXX2C4eTmJNYWfsm1Dq4/wh4KHy+OgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783717963; x=1784322763;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PqmtHnV3RmMu2IY/so6P3i1fbw35yKVwNRX4cUBXBvc=;
 b=rQsNZ8CiABrAu9IVN1z8LXy56sxYIS6nSj4IIFjINkzarT62ojhwt9OzaeK5EOh4wa
 P9zJHRIIxOAKBauY2OBMCNYlHpdthkBbDYKtcqr3dhX5P8sm8XScSzZDKZLecOmfTIuJ
 oDcjF6LB1iBzOrsVdWWxvOb7Bsasx1LHNDS4nigklidsZOAkakYt5NFxmWjmXtZVTbds
 U2yVQoEkUWuyH4faId/fs/e4MyzfqLRZlxxGPBqbtFbGfNSrfalNHUg2Nx0VbWbKQI0a
 Y4gdvNHz4Fmc0xwwW+RgZEihT7PBzkNJTMB34imyh6SJeRLfYnx78EsTq+WadFfOyu+f
 Hf9g==
X-Gm-Message-State: AOJu0YxTsDO592hqJ7PLBnMQZXY6ZW0k6Z1GsFoGZgNZfZq6hNuT6UgE
 TkVIf5g8GARZlLiaGcSZhiHGvdwLF/qKniZfa8QDz7FqrQXcZpe4AArFa6ZSoeR5ktFnWjush4Z
 FMcz3Ovs=
X-Gm-Gg: AfdE7ckM47JY9Zcc6HdAj6OHh/6vmXN7h0gnGrTqOWIlNUqvsDeL2yTxuvOqbrt5gRJ
 2BQpperpT8/yS/OgLMnNdGGyeKAFEqqy7kX54PtH5Mb1OIquB1gT0I6I0N72ZTnunhErrRg/50l
 4KXTNpl9DcHmTLf1WsvLGxYDDIjOKCgRJVWEaB1HCr0ZcohzPdKDDCD+Wz5vMTPzlC9SbdqN/BQ
 iNaONmLWPDmgB9bnxM/EV0EZq+v+ZdD2O1mQDrXqtAX753kY5n/avKtv3D3JPXgyzI7DG5kbbT3
 E4mRGfLwkxStdYwpuunHndF9PILHgfe19Z6vBIZPkaUT+xk4BS/kiwYdwkP+OlNbGZHL2px0+M1
 pwHz/t128rwOP1UjwtZb2vte66bmdyQF0RzmM2lQ5Q3YChN3iyCgsXHhkJ29QuKqF9iQPrdZT1J
 jsxZFkn80n88oibNlH0d1J7Vwxf/oDPcNsKnjgFl+9OzJQkgEI2gUgjkt4MLwFcTOjVhGXxbxvE
 3mwJll+Qrlfq9r6uIGOLqGU7THRM67skXW+
X-Received: by 2002:a05:6a21:7018:b0:3bf:6edd:4dfb with SMTP id
 adf61e73a8af0-3c110009c5bmr594143637.5.1783717963041; 
 Fri, 10 Jul 2026 14:12:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac14f2sm46359278eec.27.2026.07.10.14.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:12:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <471cfb20-03a3-43f3-a391-d9503d9e6a82@0leil.net>
References: <471cfb20-03a3-43f3-a391-d9503d9e6a82@0leil.net>
Subject: Re: [GIT PULL] Please pull u-boot-rockchip-2026.10-20260710 into main
Message-Id: <178371796199.2873859.3006411438563458267.b4-ty@konsulko.com>
Date: Fri, 10 Jul 2026 15:12:41 -0600
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

On Fri, 10 Jul 2026 17:59:03 +0200, Quentin Schulz wrote:

> The following changes since commit 913fedc816570c07bfc7f9c4046dc2a3a55e4099:
> 
>    Merge tag 'xilinx-for-v2026.10-rc1-v3' of
> https://git.u-boot-project.org/u-boot/custodians/u-boot-amd (2026-07-08
> 10:13:24 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


