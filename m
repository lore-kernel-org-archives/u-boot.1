Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6306CFC539
	for <u-boot@archiver.kernel.org>; Sat, 22 Nov 2025 17:45:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED62A83AEF;
	Sat, 22 Nov 2025 18:45:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cvX7ZthX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CE1183B03; Sat, 22 Nov 2025 18:45:50 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EEA283AB8
 for <u-boot@lists.denx.de>; Sat, 22 Nov 2025 18:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6571763793bso1263978eaf.1
 for <u-boot@lists.denx.de>; Sat, 22 Nov 2025 09:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763833547; x=1764438347; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gh+8Jai0rmUJlw5LxjxxVI8vSsuepabfyPE0wTKU8H4=;
 b=cvX7ZthXfRZGRnzb4hhFwnAdryrTnQAwb7TNcgaQIv1m4BGuwWICYj+AXDvmFcef0p
 f97uhWofk0fa9MbnjJoMtqCG3co5jBt1EpovVdR8lbKDmpLMvUT3f237Ohn1iJFe46pc
 4bqSZ7VdFZVGvVtcR/59hC77HGNlkS3vzrmjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763833547; x=1764438347;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Gh+8Jai0rmUJlw5LxjxxVI8vSsuepabfyPE0wTKU8H4=;
 b=P5dX4+saC+1AQg1BsZhdcJKnsNoWN9UIyJvmR8pVzHOO4Y1b1XF/8vXaNYNtH0fJ4C
 qzP8N8Ng2EmuSi+T5essGzZwvy4nH7FWwy0yRPxVtVE/Zv3xBsKn3h6BedojZMYapwwL
 fTuD8teVq0xQgVLOsuNJeRfmtjzMFU82inAeqgTTkbIlyu4ZXW0J6P5p0Alz/9iLF6B0
 Xf3JBlgUy7JIW5rbL2CO673pCkr+vkEr9GyPqUbsUGsJdryVgRS32gqJhMyCRUluRDyo
 Hw23/gRj7/ieR7rIs3TrezxK1Uf1T24Gdr0bvhm8AS08tkVUZC35HBjXl5EfytyQ8Z7E
 urmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGtDHqOO53KWy8aFdSNql4OnaV6YsupWTcF7Mh0xBBdCauxe/3zpJG6+9S2JzuiBPOhbb4Bd0=@lists.denx.de
X-Gm-Message-State: AOJu0YyCezn12F7nE9k+XAmrdu0p/HdogCuulRzX+RBHc+D1es4AILIM
 jP6qZj24H6suWSsrjNI9+p0BvTx995HDQ2SvHs3ZpA2e2Pj2y3UucYQmDOrlB8MSF7JcprmWH+8
 8L72rmI0=
X-Gm-Gg: ASbGncv0GCaJL/+8sJFLz3pF8D3WgSEvGsQJTw5cfRAkJwG7OmPCjOvtWm/Wwz4jQ4o
 lAkDa2fjmFBWica4tw2DDSTgEq93jC4243g0psm6vuk6ofX2W9fjPIi8cIsOvYkt6ruyQ5hTI4d
 GGxrUb53Z+0OlKwFrPWR080gNKiHorpplSDcpvscpkAVVxlqyK0LYSHplTN1b8uvcEGZFnogWZs
 CI10haAREoZr+wVbYab7eb5PDl83THdlhfRCiR6GOaFy/eP77Ko4UhOheI4bNsINeJcx/rFATBV
 bfT1/d3WZUCrqWfOldbc9v8jK3cAx2LnvMXBMsHXsCi85/3zy/09xOsWbae8EjcjKuI3XYKSZpk
 phfNt2eiQ+OQtc78ewPjfvpke54zCUSrUJXFPDA09GdULG0VvptoQbg9+edHL4tpMOfTqW+1dq+
 3snQIVkTRBYx+t3TVrG6mF/Kjv743wsQVjM5gV6UJ1p0IJCf7T
X-Google-Smtp-Source: AGHT+IERrZ7cLqF/udSXXJ4hqopUP8P8IsG6VDd6RfVmWmLDEmUszqhCQSzESz7Z3KsdUQc7Rxuu8A==
X-Received: by 2002:a05:6820:150a:b0:657:57b7:e944 with SMTP id
 006d021491bc7-65790867ec6mr2434134eaf.0.1763833546921; 
 Sat, 22 Nov 2025 09:45:46 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65782a52468sm2537360eaf.6.2025.11.22.09.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Nov 2025 09:45:46 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <cc6e6c06-2327-42d6-8def-251541c76cd8@gmx.de>
References: <cc6e6c06-2327-42d6-8def-251541c76cd8@gmx.de>
Subject: Re: Pull request efi-next-2025-11-25 for next branch
Message-Id: <176383354546.230884.6702645368359612262.b4-ty@konsulko.com>
Date: Sat, 22 Nov 2025 11:45:45 -0600
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

On Fri, 21 Nov 2025 22:08:52 +0100, Heinrich Schuchardt wrote:

> The following changes since commit 8ff90aa64b730c3f511921d4ff79e9f64e625867:
> 
>    Merge tag 'interconnect-next-20251120' of
> https://source.denx.de/u-boot/custodians/u-boot-snapdragon into next
> (2025-11-20 08:00:11 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


