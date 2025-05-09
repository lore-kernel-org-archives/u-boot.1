Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88B5C3ABBC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 18:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA9A1829CD;
	Fri,  9 May 2025 20:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UyKnAOAU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A06858269F; Fri,  9 May 2025 20:57:50 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 849DF8269F
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 20:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2c7e5f7f0e3so892599fac.3
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 11:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746817067; x=1747421867; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2jf4aBY/pH+6QPKlrWFuBMyDM5/zgJlnQfbXfKFuAmA=;
 b=UyKnAOAUYPFZOHkKC2Y9wQinHSzTgOuk3dM415ZzQ3xFleQHQb5Erusipe1INbvOA/
 t4eBzYFt6beimAgrqWYOc64TUcC44y8b15PA385VkEnQx9SHxxKlpcXAM711QX4AtfAA
 m6DXHRpgHqD/IT39nUBYkk6ckWwhflB3Pk7LQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746817067; x=1747421867;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2jf4aBY/pH+6QPKlrWFuBMyDM5/zgJlnQfbXfKFuAmA=;
 b=jLqOxn6HSx0wnl+U951QccZfPWlxRH4b8eQM0wf1TbApcsb2ASahLtHnu6KViYGpkx
 L0UheYrA73+iyKbkt55zB3ufNthp4kQEv70YoO8YBcgvgaX9ZWMkO/fC+3TWXKm7JkvN
 OBdT5U4cagx/bfTJHFI7PgSq6z/SqIUyzjeP9hKyMoZF7D3Ft+V86HD/EymvpNTLERJA
 AWUJr8u8pNPHjrnNv3SJHj0/Dqcg2p4ep8jphnMZ5SGlsEKfFiiXTFYCQglAxdoOIusv
 JXUMvs+AcOCXSyWuGcjZxfks2Z0yO0o1WbpbPcv0dzWoBHg396Bfx0USu/befqd/m9PI
 hAeQ==
X-Gm-Message-State: AOJu0YyVapVYae59AxhjtsmfPbCfQ5bygAZHk1seS8jrDSXp3iKHDq7Y
 NRdfWd5Sqt3I09NY2sEzfznq0YWecr835UjSZa7AAh2MzRE1r6UzYPMVuB6HbiY=
X-Gm-Gg: ASbGncsqpoPjhKLVAl9hE37PrTJSCBpkPLU/Zby/xDG4thuPeIq7v3ct1KrQgQCDRHr
 SxF8E5nbFAIsUEyhGpNAOSEQ52nwrLPJ6lZVN2+QL71FHNuB+hxqFkkDfy4rj+Pbpopke82a+vo
 x0bmJBLiYIMqgIuB2+PxJ6EuS0T/ibo4bDzoHoY6rkHV3sWniibulf7yLnL9fonj6PDUN1dwXSI
 iYPn1loUSPrSsGu0IvQMjQZiMk2A85YlC+cl/kqdqchnt2fZTr8pdIQigxZGDg+nhIwEPARi/F2
 /KYCVmI2lND0ILo6qQnDQHi0TvgRNUo8YSomCAuVo9BPhckHQHIZe4LkIIp5GEHGqG9AFxY9CQS
 qExgZJzpspg4=
X-Google-Smtp-Source: AGHT+IEM3dprazYlEKbG3cjzl1HOcjxoU+oqgQLTjw7DbQRWe75nhaXkPS00oyrMBgV9BQF3gziTmA==
X-Received: by 2002:a05:6870:e985:b0:2c1:650b:fc86 with SMTP id
 586e51a60fabf-2dba4214053mr2660487fac.1.1746817067243; 
 Fri, 09 May 2025 11:57:47 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2dba06e7a10sm721707fac.18.2025.05.09.11.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 11:57:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
In-Reply-To: <20250226203126.3831979-1-trini@konsulko.com>
References: <20250226203126.3831979-1-trini@konsulko.com>
Subject: Re: [PATCH] x86: Correct usage of IS_ENABLED() macro in
 arch/x86/lib/spl.c
Message-Id: <174681706601.750074.1497463281647232535.b4-ty@konsulko.com>
Date: Fri, 09 May 2025 12:57:46 -0600
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

On Wed, 26 Feb 2025 14:31:26 -0600, Tom Rini wrote:

> This file was using IS_ENABLED() to test for CONFIG flags but omitted
> the CONFIG_ prefix and so did not work as expected.
> 
> 

Applied to u-boot/master, thanks!

[1/1] x86: Correct usage of IS_ENABLED() macro in arch/x86/lib/spl.c
      commit: cd2dc5f448df29b88668a1e1d97971f2007399eb
-- 
Tom


