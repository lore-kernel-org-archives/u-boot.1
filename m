Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0502FD4F3F
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 20:46:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4013384179;
	Tue, 10 Mar 2026 21:45:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ODFzfKDJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0930F83FA6; Tue, 10 Mar 2026 21:45:35 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC0538414B
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 21:45:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4671cbce465so867060b6e.3
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 13:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773175531; x=1773780331; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4tYq9jBCmOhidPL7kC/9VLxFTlbuHLcyO6rV/Sqp2QU=;
 b=ODFzfKDJ9EbzBZzAuO+4Nrk5lOgC5IeWI3KApBcIWs5eeOcRDCzWD2huK6dEfpoKJA
 otk4PFB5IkWyDF+JZxCSNo+drv0zoEMmcKP4SjTQXQHgMQZ6L6RN+njRcQeMkjhm2sDx
 ttHkWhdrod8XJV3zi/gxSsEIAflL6FV2HL1rA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773175531; x=1773780331;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4tYq9jBCmOhidPL7kC/9VLxFTlbuHLcyO6rV/Sqp2QU=;
 b=Puj8N8sYh6zjE1j+Oylk5AM/p5Ry7B8QEo4q7Qm7Q4TyN93hlStN4ZCXwiav8EgB0u
 GYXbcptNnzpQCdJI9WlaRp2tEbEUbT9u3eXep0pQxhySTL5U6n8mKY6NDSH2USMUDMhS
 6s2XK/1sxkMRJqbjk3+PeP+WER0X+WTtb4Rt7FZQLqGvrY1WhyiEJxy7XQhG6wA3swjK
 NJZxIZd/heyoVeVrzmdGGG0gfYUVUqaWjao+dPQFjFkcXSpnO1MDSjJICrHJiSaBNRA/
 0zZSD1YcNHtKaR8p5BKpie0CKSRtFX3qxGR/6DN1slSsfl/pn4wEzn/P2TAjMRJgKHB5
 brVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5wdphqLFR0w75tZa3hmyrTOq5HikkEHrXB1/wyspJp0/jhYYBRfwBQPvNh4S5iSPr+Ob/Qgw=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2/dcGN0FYdKuP05+sUcqFY4k2QH1VebeVtY1VlsK/NM2AKvPw
 4wrcYHW1VDT80IQDy4sAc/vi//RY9f4Q3TVzBFPRosgdUL4mGf4uMDMVW7VFpaSTiMg=
X-Gm-Gg: ATEYQzy/pzDfNtuytWEAGBBbwLfAPCy1PEM1BDzwMD0Rk5/0lmRNd2pg2GbBdwZNunE
 rQV9JU6B7LXzuDmkfFgXgQso0D31HuqowizSPJjtGWumNHAo0f9eT7ip8HE8GxEuw2KeB9JAAfB
 ok2KQZm3VdNRVI1GtaPCAoyEqQxbDvcrYk9HGn0pDreVe0ZdehRrsSZ+zmhTM+LwCFBUUwqtS1i
 NeWg7m+xEsyBvPMRsizCQB7Ym5E4b9XXncSqynHX7l767VW3nRZ4VybLhdrZB7YDqqAr1pnqRHD
 CGafQ6f36JKZjg+zaT6MJoI3IcKWwCO8afAwKlr492p2iYhE9qyz2dI8RkHSwJ0LtDFAHKXCtUU
 niY8o1z9Mn0AeyLqepIbIVUpf1cWybCukviO1A76KZXOIUcqY0C+0QYJujePu+yUYC6JtWWU5Ju
 mljfKp3wJ4Akn7/KRJEzlm+/PCG9Tc9D90RavgTvA67gOe77Hb0JdpjEzLsktlrHVUds6+GFsHN
 71QoZGsYz9vkFHWCCVUdL66MlJOcAuITy90fILu51Be
X-Received: by 2002:a05:6808:3442:b0:462:a915:31aa with SMTP id
 5614622812f47-4673367e819mr26311b6e.63.1773175531654; 
 Tue, 10 Mar 2026 13:45:31 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466dfac3acfsm8256086b6e.16.2026.03.10.13.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 13:45:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, u-boot@lists.denx.de
In-Reply-To: <20260225130312.60122-1-heinrich.schuchardt@canonical.com>
References: <20260225130312.60122-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] disk: fix DOS_PARTITION dependencies
Message-Id: <177317553086.23044.4952366622657338842.b4-ty@konsulko.com>
Date: Tue, 10 Mar 2026 14:45:30 -0600
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

On Wed, 25 Feb 2026 14:03:12 +0100, Heinrich Schuchardt wrote:

> * The symbol for the x86 architecture is CONFIG_X86 and not CONFIG_x86.
> * Correct the description. The partition type is called MBR.
> 
> 

Applied to u-boot/next, thanks!

[1/1] disk: fix DOS_PARTITION dependencies
      commit: 04e96eb693cdb26204143629c56d45a353390a75
-- 
Tom


