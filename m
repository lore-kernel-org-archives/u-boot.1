Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5B7CCA470
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 21:55:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A654383981;
	Tue,  7 Oct 2025 23:54:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fs8bm0PH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99FE483984; Tue,  7 Oct 2025 23:54:58 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CF628397A
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 23:54:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7afbcf24c83so2084442a34.3
 for <u-boot@lists.denx.de>; Tue, 07 Oct 2025 14:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759874095; x=1760478895; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VNbsNTB9e+c7SUa5nqwK+nZwFuV7lRSHIkLiG+TBNR4=;
 b=fs8bm0PHz53UUkUt+qKi5cENhH3Z65ITIff87D+3XUolQ++mPv9sCbxtn2disk++9e
 tg6OfsOoH6QSemXqQH5JtoghVu8YbeiCnmIg3Jd5hRNibR3jehBc1mmNbbx2Xl+TxhOp
 bTkxcuoYp+Z10CvJ0Uud7qYRqVGOlibaWPxgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759874095; x=1760478895;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VNbsNTB9e+c7SUa5nqwK+nZwFuV7lRSHIkLiG+TBNR4=;
 b=RjPMenMtDiweGZE/jK8XKevmgo5A/aVFwdO57MiT2GdLxsBCMoy6FrakCVheaUwUxV
 fv00USoY9D4CS0hcssSOoCqA9692RAx8ukzxGEzYkQ4wNO9JUyIgEvuKQgw80w/DCTVb
 Hl2OGSQ0kq6mC8jgh0y6/f5sQJJ5pK16ENBlfn1q/8fFGSDO1p6DUjqMC3mv9NL/qxxF
 TtczUWW0oMq1Wno8pf+xSlMsM7SxVz1BfHhF4wilU9dvfTi6qHVhbMFrkvW31PzsUvSm
 ObKlBhJmMi+GDBdjh8axl72AjygYOjfalKObfO0IUBHuysqhMCWoz9NTjMrK3nC5VvAq
 dAPQ==
X-Gm-Message-State: AOJu0YzRSEUGTuedaI5dJCG0XutzZuGhHuKrMtVv18sYuhpfLTO3JU//
 fQlz86AXXEo85K1z6+VWgtsOpA7W5IlZt/5Zg0rhlGulWfsHajN9e8r+24gHX/NsJB8=
X-Gm-Gg: ASbGnctOZiPxWx/N89OxrJm88Z2QlebAwRgXsOHC7to17Xdpm0a2cYwqEG08ELo7ljH
 NfkyKgkSNYihBAJJmlf95xH+iWCCqIQ8ZmFIND01dwvrnewJ7ox9BJhsycONvfMwQSpJSFEIJBD
 tqrGiXs/P7NSktWo6QzctDRS9DcGTl/RmEYUFvCF6+FK9pH1AVznyHp7kverGpswHoDSg+roh2k
 KvQzWPDZ8YTKEXk/so/JJQeqDVrCK1PkjEIxdlTIXVKOlhwY5PjMPk38hAuhNSPDZ3ZBcvErn3W
 2QPMR3kJIuQCtitySi6okJf5YGO/fO3sDDCtFqs6XjqdXeojKcyIMWfi0IRH+X603zHpr17+GSn
 RnY487GU1a2wq1QpZ7q9ctMdccQ8zmmklvc0PtfcU2dAt4M3s2/Fmwi+ZCvFTZyfALlB+pHhRqk
 ERnf5UAn2u
X-Google-Smtp-Source: AGHT+IGPasAeYlJWaaSmTRMQe9qynLoYQVZpcwmgLOxlftgAC8bG/zDGOkbYInvzITMYjUkpKXaKKA==
X-Received: by 2002:a05:6808:11cc:b0:43f:445c:5e17 with SMTP id
 5614622812f47-4417b3e8408mr639422b6e.51.1759874094994; 
 Tue, 07 Oct 2025 14:54:54 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ab794be68fsm5566818fac.12.2025.10.07.14.54.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 14:54:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com, n-francis@ti.com, 
 b-liu@ti.com, nm@ti.com, bb@ti.com, kever.yang@rock-chips.com, 
 hl@rock-chips.com, tim@feathertop.org, marek.vasut+renesas@mailbox.org
In-Reply-To: <20250923124639.667718-1-anshuld@ti.com>
References: <20250923124639.667718-1-anshuld@ti.com>
Subject: Re: [PATCH v3 0/4] Add support for secure falcon mode: load kernel
 image before args
Message-Id: <175987409365.563772.13021490235522810257.b4-ty@konsulko.com>
Date: Tue, 07 Oct 2025 15:54:53 -0600
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

On Tue, 23 Sep 2025 18:16:34 +0530, Anshul Dalal wrote:

> During the implementation of falcon mode for TI's K3 devices [1], I encountered
> several limitations in regards to the current falcon mode support in U-Boot
> especially in ensuring a secure boot flow.
> 
> Although the current implementation allows for loading of a signed fitImage as
> the SPL payload, there are still a few edge cases that might allow bypassing the
> verified boot path.
> 
> [...]

Applied to u-boot/master, thanks!

[1/4] spl: fat: load kernel image before args in falcon
      commit: 6b8e03a95869f99cabeea0728e6f5469f3960bf7
[2/4] spl: ext: load kernel image before args in falcon
      commit: 50953dd5cd8063e0902335c1588997e3ce12994c
[3/4] spl: mmc: load kernel image before args in falcon
      commit: 00edec55f388000b9161d2427e1ae2e55f53c8ea
[4/4] spl: ext, fat: cleanup use of CONFIG_SPL_LIBCOMMON_SUPPORT
      commit: d0b5b33c4fa7555d142a02edf07ba259691360b3
-- 
Tom


