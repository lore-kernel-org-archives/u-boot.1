Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C6DC8303F
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 21:33:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28B8F82C84;
	Mon, 25 Aug 2025 23:33:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XO2tb+ru";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D72282DA1; Mon, 25 Aug 2025 23:33:02 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C3E3828A2
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 23:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-30ccec2515dso3463806fac.3
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 14:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756157579; x=1756762379; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FunEx1iGoQ49JgKMjA4YEksLXBts+mWo41cU9MVEaQ0=;
 b=XO2tb+ruvfO/l2pnXRXSdQnJyd/DNP2fK0GKkAWSWlR111NPQcPULA8HEFkm4lC0oB
 GnELsqFd6a0sl0w1pcuTzoCA688eJdmW0r0qftRJCV3dcfAf+exlNAKQG7RunIzI5498
 2hcwbkScigsiZEPXm955UbqTR7xKyg1CafUaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756157579; x=1756762379;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FunEx1iGoQ49JgKMjA4YEksLXBts+mWo41cU9MVEaQ0=;
 b=Rj0nLPxgaHHZIZFgei0wDl1L3Tb3OT0Ob3j30RvOo4eczUzDy1XFRsZj9GjUuVjtTU
 x0iNrhL4ayxvOtcVQ5M1XrNHRAakmy/lTkrBgV6t9CE/snQQ37Wc4jNkiPPdnrB9845Q
 EaDjCDriu6RzBnaZtlW+OB4HBQcNL/j59fqR73BMq4N472eDqV10h/XQKBvm+u9rFa/J
 6xbTpg0yYUe/tkZdfEKPcyYllulcP4G0u1UFL2d7lq9rwHHW6mXe2F9UxR2s9EyYtI9B
 gHodvtVEltdz2Ai1+datuS85Xq0DB7UKQN3XSLzRBBtQAiIeeF3Q5vqZPN9meICRcJn3
 16RQ==
X-Gm-Message-State: AOJu0YzvuLCJm6LR7Em2afG+nwAfSZyv5+Ppomzqp74zz9+nYfGFQ2aC
 h8CgIm3Or1rCcpRnMRvHm91e5KOFlmznE44aGsji3yJiYv8qw0kGOsJBZoH97Smno+QzYkvlY+g
 Mr1QDXFM=
X-Gm-Gg: ASbGncu69U9hcPBtseGRPtoG6NkfpH7F0my6+Rs7ECzJgT+EkrzXEni0m9y72NUnHr9
 75CK0ZMD1dum/wnHY8hArhNKMA7mDqieykdwMLdUKtRrIdzMv1TSx5uVUS85bD7CnOZrFlAuPHZ
 sMkWL2WFj04LaKsgxff5MXP+fwod6hcZpNalkYrAVVPAQdFBi58OPow1vBp22LuFjk+g+4uhEW/
 VRUYvRtbQ+y0+D0EJ31ZYhF+3bycUq7jtl0I/XGYKzsMR4odwgGiBS6Cmo24r5kpkO9Qzh/mmWY
 gfZ5A/cqyqQieoZMnupyg2w+w3WYAQuGnMQhFFxVuTezEaQ6m4FOrSKyPS9l+ywJ0+zBuZoJ7lT
 vLr2wfwgqOzqgihTUFMpzuaRmAz5ughhyeNUckxyFPG+Ve9/lE6n/oZrq89dqqYfu+w==
X-Google-Smtp-Source: AGHT+IFZUnLWV+jBgrkmnpn01B1EBg+2tQ1oi1j3xZ1wkJ9urhpJuffnq/8k6YRM2+RA0q99Lg61Zw==
X-Received: by 2002:a05:6870:e85:b0:30b:b37a:6bcd with SMTP id
 586e51a60fabf-314dcac2a8emr6958655fac.6.1756157578804; 
 Mon, 25 Aug 2025 14:32:58 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7450e2841ccsm1984421a34.13.2025.08.25.14.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 14:32:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <ravi@prevas.dk>
Cc: Heiko Schocher <hs@nabladev.com>, Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <20250815061719.2758662-1-ravi@prevas.dk>
References: <20250815061719.2758662-1-ravi@prevas.dk>
Subject: Re: [PATCH] i2c: omap24xx_i2c: remove unused members of struct
 omap_i2c
Message-Id: <175615757784.113379.2458531680905401594.b4-ty@konsulko.com>
Date: Mon, 25 Aug 2025 15:32:57 -0600
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

On Fri, 15 Aug 2025 08:17:19 +0200, Rasmus Villemoes wrote:

> The clk and clk_id members of struct omap_i2c are not used anywhere,
> and AFAICT never have been.
> 
> 

Applied to u-boot/next, thanks!

[1/1] i2c: omap24xx_i2c: remove unused members of struct omap_i2c
      commit: 91595c96a53360dce696c2da694b1983c91d64f6
-- 
Tom


