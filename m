Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102DCD2CDE6
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 23:11:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADC92841B6;
	Fri,  5 Dec 2025 00:10:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sE0+lBc2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E2E2841B6; Fri,  5 Dec 2025 00:10:40 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7594A84181
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 00:10:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7c76f65feb5so1216522a34.0
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 15:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764889837; x=1765494637; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IcD22IVB6RwzmJY7JzXeTfuWoHh2aal7a2KnzpqdPiU=;
 b=sE0+lBc240w0Nnw6p7QthkL/qgmA6h7zXYGPVWoYr7HIPxDwPkr+dC2SxB42v2mhJ7
 dhTI1Qgf0b3lFk5sHuHHHJZGJ9tbsfavl3xr7c8rke1fpVAbZHMxGOMkwFMfQD+zwP1U
 NiOOrU0aK0U2c7dP6E5585+9jKtJx+NEdQ3+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764889837; x=1765494637;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IcD22IVB6RwzmJY7JzXeTfuWoHh2aal7a2KnzpqdPiU=;
 b=dfkwCgs5pNsnhMAZv8AeGOurJjotbofldoGR0/FUCzjQ8q5RBdU+YApdyz/MBtYrOC
 bol4yfG7LU0BFsefKSUCkAiNz1btzmdoHqUD7THgjIMelcdPFyzdgYmCPsvhk+2/JVJp
 2D0rbRnbgLVwqt30kNREBSrljyEP/F6sopbmQzO06vQD+kIOAbvz06dLXj+URkMaPOYP
 Nto6pGWOKbBgvqZ4eo2wg5gKqbzYAQSAqW5GeiRRyV1JeNHjjXs1/RqzXh5VUb/40VOm
 0e+yMfZARRMUgzLS8+i5tQ5IyvNvQbNT+T03GogD9aHsoAiXbFVp77HXXE6i1cHj2jV4
 KCKg==
X-Gm-Message-State: AOJu0YzIFwgMYviuWkIoNh5vaEOpvigdckZBD5DAOkKeY+jO+9GTnvlh
 TNGGZtne2wqsUz4ysMT6NxPR7C2JlG7Yf1kJpg4yMesxxYdt18MowDF42yqg0fhc1Q+8qDu0o5N
 LwA0xBns=
X-Gm-Gg: ASbGncsBFKAKI1Ukgup2EPErof8xH4eSYsrna/lF/vQjdKuTbC2fBw1gsyXXq+Fvlfa
 VFE6fuXwLDtK5XQvJR9qAKL20iVR/MdxwhBULYHgL91zX52YfXu6FSM0cQf0FnigSWz3uX0kliy
 kRlvyeweTOmZqUDg+3UIlqusaADAcnqsgcQnZygdMpqpxhC3bcilxFOLrnsDScVuL3P+a+1grae
 4u52k3gp6Su9tAFOVv8Lyz8OGM+KWZr5p6FI7ATbc2WJV84H1Qs2cVJXDoTWJSZnexxqtY0Sux0
 +exMlc1W5/m6yNMMGOVdiJAqPuiudOMX3/FcnXVu10cn/JdEWTOhTRdzqL8oyeXuEEfiC//0mca
 o5RW1WsmaEfz2tfq+ajkei2Dam3WWMezU8HwH8sPW6oG25WoDbtRZE97IGZXSkrY9Ks3gvqtlC0
 fYnKO4F7efXJ6peSzEbWm3BSUEDgLihG/AFsNPvRZrHSvnH+WAZZTEl/t/w80=
X-Google-Smtp-Source: AGHT+IGYBuPH9e56YtveWwK3USXRPk7RSamL3cqXGqfta1n3O87T4rLzzbnIBucoZWWA0J/oMZvv1g==
X-Received: by 2002:a05:6830:44a0:b0:7c7:6977:17cb with SMTP id
 46e09a7af769-7c94db1950fmr4731185a34.21.1764889837289; 
 Thu, 04 Dec 2025 15:10:37 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acfafeasm2360264a34.29.2025.12.04.15.10.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 15:10:36 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: "Derald D. Woods" <woods.technical@gmail.com>
In-Reply-To: <20251119145532.843346-1-trini@konsulko.com>
References: <20251119145532.843346-1-trini@konsulko.com>
Subject: Re: [PATCH] omap3_evm: Stop disabling device tree relocation
Message-Id: <176488983644.2091996.3737874882949581887.b4-ty@konsulko.com>
Date: Thu, 04 Dec 2025 17:10:36 -0600
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

On Wed, 19 Nov 2025 08:55:32 -0600, Tom Rini wrote:

> Remove setting of fdt_high to ~0, which disables device tree relocation,
> from the default environment. Doing so prevents U-Boot from correcting
> problems such as having an unaligned device tree and leads to various
> failure modes in the OS.
> 
> 

Applied to u-boot/next, thanks!

[1/1] omap3_evm: Stop disabling device tree relocation
      commit: ab5e87e624e2220ad4c4155d6c61af2c09b761d3
-- 
Tom


