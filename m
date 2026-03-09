Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D06F41808
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 15:11:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FA9B83F9A;
	Mon,  9 Mar 2026 16:10:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NVqN9s0/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5792783F20; Mon,  9 Mar 2026 16:10:49 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F4FA83F59
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 16:10:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-40423dbe98bso2891223fac.2
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 08:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773069046; x=1773673846; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u2RNPqW+U0ZQ8xsCF78JdrYIfZ/mW7bGZmRrE7ZBMKk=;
 b=NVqN9s0/Vrdv9cRMMpmB7HzUly/ELYKRFLdqnjnga5h6q9ZbKSc1SYNtRBrtRmI/xn
 v/eS5qfOiE/m9CRwPwxnrnzaNVUA556K06TscC9iPoNoPTk8GC+ZVeErhJx1dyUWlTMV
 MlQtFfkyGrnAnXJcyAAEhJ/nqoa0qnLPW6Xl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773069046; x=1773673846;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=u2RNPqW+U0ZQ8xsCF78JdrYIfZ/mW7bGZmRrE7ZBMKk=;
 b=ChP3xg6RDySfT05cZg7c0DbtAaVeZPWXi/RN/E8cakeirTg1mWI3uXx3bPvkV4noxw
 2QeoLCyhMlgivD0wsKUFLOr3EVLKVa6gM5A0a228hqVWbyCEkGeTiUsk4HS/2lt7KvRV
 BzBYROng6Qpvr3d1zfG2V7XRJHIU6A0s5hc12DHOVMwjWBEeWs6qM/v0ZAu6YIpOeMps
 xIp9rAMTQe0OWh/C4SmTfi+wHRQ8o8tKp0yRmWhmWnncC5jJGon6h0Isc039uUldMrLh
 MlE66yhRdd2L1BfySlcX9AG9aQMewKpZToAjwE5R4mX3RZkAvX8/kXi1CiQIQTgSz6+3
 hz6g==
X-Gm-Message-State: AOJu0Yxptm5b7q+/1XdqZm4ZnCU+Ka4O7NAgN7caHzD4iRzaF8YqNhRl
 h7ZeNS31KSL7mIUo/Ovlj/7YrNEWUCKgupQOCZ/9eGukCWjcCnEEYAtyuet7GRSpjXw=
X-Gm-Gg: ATEYQzwXQ3gYi7x8VsTeU6ff8eZI8HLsEQ/ZiS+Ef/JNJxliuL6/4IeOEG89IX1BTku
 6Zmq9ymKeXGPohSHCxi40AVMz5OpI63peWi3YToV4cJ3asIuykQDe4Lx+WzJx1M13IDnmH14tKm
 a7bl9Mtud1dXNvqh/j6gCfhuD+gRPI0RE7zFPBj2D/BeBugt/L1sRY9U3ijDLGA8ZKt3SkPdqJZ
 uR3sHNWaxDvMph39zHczefuRpvNr613rC1Zv+csNwIvGhcJZ/xYD4NUvTSzLlT4fEGE0kADSNGT
 ZtISSg5Q4dACYGZbowMaOWOvlpHc260eqJtI8R5B3Uz6glEBsp00baXR1y2zNK6skm/dXUyR3Mt
 bxTufGRFX9WkmOTL3bXujv3hk25MRDr3dqsf3obUjlKHvrpJuGBHNLYG+Sx5VikjN5YapHmaF6x
 1bMxXq5tLeMSKD+CR5DGt3Sw1T8j/0uxJsP8YUZcbAYVF/AvqwkBbCYbyZ2KBUqEyy93FiPKsPJ
 gewmjRQRLUO+sWKoZjJ5HOpdb4qn2wI+TlzlQGtUl6XZFy3f5ROIJ8=
X-Received: by 2002:a05:6871:728:b0:40e:dcbd:e92d with SMTP id
 586e51a60fabf-416e38cea72mr6385755fac.0.1773069045709; 
 Mon, 09 Mar 2026 08:10:45 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-416e65b1cacsm9376128fac.8.2026.03.09.08.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:10:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <20260224155712.286317-1-ludwig.nussel@siemens.com>
References: <20260224155712.286317-1-ludwig.nussel@siemens.com>
Subject: Re: [PATCH] bootm: fix booting kernel_noload image
Message-Id: <177306904503.2117441.16116722120521605409.b4-ty@konsulko.com>
Date: Mon, 09 Mar 2026 09:10:45 -0600
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

On Tue, 24 Feb 2026 16:57:10 +0100, Ludwig Nussel wrote:

> FIT images don't work without having to explicitly specify physical
> load addresses. Digging into that it looks like a flaw in
> bootm_load_os().
> It duplicates images->os for convenience. However, the code handling
> "kernel_noload" images then updates the load address in the copy with
> the value lmb_alloc_mem() returned. Later there's another call to
> lmb_alloc_mem() that uses the old value. This leads to havoc due
> to subsequent calls of lmb_alloc_mem() picking too low addresses.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] bootm: fix booting kernel_noload image
      commit: fe6484b402759dba6024cf2f8c212b27f769a0d7
-- 
Tom


