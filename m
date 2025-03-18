Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAF0C28B28
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 17:01:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B49F819B1;
	Tue, 18 Mar 2025 18:01:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UcOvFtOw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46F8581026; Tue, 18 Mar 2025 18:01:42 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2B22810F4
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 18:01:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3015001f862so4563953a91.3
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 10:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742317298; x=1742922098; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u/kNwDzqfAFH1dCDUNgqAaPgtc9HFF68WZqp2bsvQv4=;
 b=UcOvFtOwFYKjDfla1qTuPa5B6+v259O10vQ5M567hDPi/GwQMSH2Gvjr1fSrDeFWdj
 Gr/EtiYMyRPCgdJsrHvt01i7VaG2lCF8NnXcdHh/jKuhGbL5La8c0Ak4I9JkbjEWIug5
 pcpBZmk+3lz72LAqe15803/zLhjOxIW0V8o7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742317298; x=1742922098;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u/kNwDzqfAFH1dCDUNgqAaPgtc9HFF68WZqp2bsvQv4=;
 b=ajobQf5LHhBjAxldsYlYwlNkpvOUs+Br0uH4xCexOsZ02V0ifklXPfntqmB5C8ExQt
 ZIym9wUqYbfm1U+MrkzinrMpDrPvOSOLYcd9S4FQ8XBvf4I69/bcytdl5WEvRsS5Y8Tt
 TpHCtYUGYD6TRsWMZFQUTVEkzQbkt63ZwY6Rj099dmFb5tOV411q9GpSBNlkrJpNdloh
 g3lYxUOlBeXke6YZ7aEhgRc7gi28nBQOFs3ttDQaIwyyiRMv6+vRCyCElV3OUStJJfQP
 jnphdqsEQ2o69FRp9kcqNw2vDXEMxLXSyo8AKz4CYqsXmzVYiaQHj+7Bl4evS6Qod2D8
 uiCA==
X-Gm-Message-State: AOJu0Yy7oVeOk5HW4zJ12/Wo+eCbfxW4PTekTmjsQicKjwgkhPmgyhd8
 /lc/Ff62BqbIC+/UjE36qTsDQgmttQWhYM14io6eFCAombWeJOFHE42jXJ8umGBwzV7Pxpg296J
 Z
X-Gm-Gg: ASbGncu1/sxIO/Wx58Exe1FYsemQkexrCaPuzd2gcUVao6rlml3Y4CX/kYDKleEPUc5
 I7xJvu4HnA8qnrv4yqCF98LFOr4iZd2DCZs8fznOiBuO1SjbHXLj9FGh8GkaoQ3Yn1uTkS+3RWR
 VY0DW5c+uAS3iNfSqsSuYvPE/AdhZ0aImlvh5u5cH/rD3qjbV9B3ddehEyqFz0hcWaZ3fyO+1u6
 JAoI/azeny4W87d+QHlY8bGVcItH9o+7G3IwTEODIC5UiXNv6ObRgol70KWyP8ojKYZqFXRJuXb
 0KZS3reTjFWorS6G/ufWMvYY3k9OVJHjvIfU/rPK1TQu
X-Google-Smtp-Source: AGHT+IHtdRWPJlAbCi/SUu8R9WQX/fLVW+0Fi9oUB0hAx1PvPvdzWP4mCvh88Aza5VLjDjnz4cw2Uw==
X-Received: by 2002:a17:90b:314a:b0:2ee:90a1:5d42 with SMTP id
 98e67ed59e1d1-301a538d415mr4884922a91.0.1742317298260; 
 Tue, 18 Mar 2025 10:01:38 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3015363273fsm8458551a91.34.2025.03.18.10.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 10:01:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250304202436.2783784-1-trini@konsulko.com>
References: <20250304202436.2783784-1-trini@konsulko.com>
Subject: Re: [PATCH] serial: Add missing TPL_SYS_NS16550_SERIAL symbol
Message-Id: <174231729750.1761337.4069736670431144964.b4-ty@konsulko.com>
Date: Tue, 18 Mar 2025 11:01:37 -0600
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

On Tue, 04 Mar 2025 14:24:36 -0600, Tom Rini wrote:

> On PowerPC platforms with TPL enabled and SPL_SYS_NS16550_SERIAL
> enabled, today this builds under TPL as well due to how $(XPL_) is
> defined. Add the TPL_SYS_NS16550_SERIAL itself for consistency and
> clarity.
> 
> 

Applied to u-boot/next, thanks!

[1/1] serial: Add missing TPL_SYS_NS16550_SERIAL symbol
      commit: 0d8b2970a47c914faf13dd1aa97ff7f2070ba8e1
-- 
Tom


