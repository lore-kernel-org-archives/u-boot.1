Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231FDE8538E
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 19:47:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 857C984150;
	Fri,  3 Apr 2026 21:47:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rZ+UjhMr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 345C184129; Fri,  3 Apr 2026 21:47:18 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B39DD83F9D
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 21:47:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7dbba5076c8so436661a34.0
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 12:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775245634; x=1775850434; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HL95Oxi9msGrES+xiLMfrXWiO/2hwAeeoLLNmN9RjA4=;
 b=rZ+UjhMrQwVlgbgmo68LI4GHBk9Go/EaOhMVNzbpdh6xoln/FJUSjtkLmsRWihObkM
 Szgou4i6JLFYle1/o0WGMBX6WsJ24BJXJ+E9qb4r85kYn+NL9CMCswiRpXlkHmEwJk9s
 x6LfERpAISL5ptzbeF0Tbbvh9AJ8iEt634fEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775245634; x=1775850434;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HL95Oxi9msGrES+xiLMfrXWiO/2hwAeeoLLNmN9RjA4=;
 b=fKcjLqbd5S4DZiQ7lkY3lfbvVc/TUe9Q1RAT4O341beRD66mE9oR6oVqTaZwfEi20R
 l5kUyqsYiEDG16NCpRS0qgX4sKOUNMJxrGbi+KRlFILPD0nr0uYuNTocpskQBl7ZQSYN
 FfqtqHFrDaohGpueGWFkJEoMrkDBmdLaEvmv3TUoN5s6jMpiL1ehsANKMSWZvA6tzNDi
 7pcsogJd1QbDwVBs+rI522DI42GPvA2PsFefagW0WPuzoB+JON++0qTyd7NtHvMdbFOq
 XYbhGpi5QLQlyfU4BB43kniyvMl1Ydrzi9Szh1dihr2XkNcliug4Q1727xGFWTJfSRUG
 5GCA==
X-Gm-Message-State: AOJu0YxnUABEXAhA9h8B4r8cf03cpaq4x8mpelPTVkrzBOGJcGSTorWp
 w2qKKT/hDCFakm2vHPmYfJwi8JD8dfaegf9mqAkSGvYcGlbnimA8dhq0mWIk5/G8h1k=
X-Gm-Gg: ATEYQzwAEysewI4dzHEqKvFl5XKJDg6XdQPRztEikQjZxiBFHUERg/lWR5KfwFzZCLW
 Z1mmYMsbJuANoWQKWtgrEe/u+54eW1suMvxfyhVFVW1FECN7lIq888K0MhFGV6UcoFXti8bBIqr
 7tIzK+lnQPyXLOMXvMFb/bk8R7e3fJQvj2MgNJ3NFSDMOqg1ZKfFN575rL9W/zuAI57jSEYhB+Z
 I9JrQSVd/xAJf/AU65X7NnfJe/76aKyU6QEpyYLGv5k4wDPjKh7lGDyYvM6z/2A4euCjwpOXwKv
 PrugJCrRuRbBDVeVM/pyrwDHh5JU1ZQL3B3zYDkyqwhBwKZNySKDRRl6I0JNW4hFhgZ+N07ewnI
 ouLN8O1GF7c6CKp7J5GApXtsDBeJit1n89tHI2heY0zR1H3IFuif3MrNVGozta5QZwc5PxkY+3d
 gaTi7O7noZQv87xt2HR43niOhyyr3dHl8WiGglewSyG8hPCeAwsOudTe0cmOV7Q2lemiLPUuldw
 hBgj18RovM+TaCUEDTxaXUbDdQojwbAD4fOwsxFARlB1gs=
X-Received: by 2002:a05:6830:6186:b0:7d7:da02:1aa4 with SMTP id
 46e09a7af769-7dbb73279c2mr3039053a34.1.1775245634497; 
 Fri, 03 Apr 2026 12:47:14 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dbb5c96485sm2544954a34.22.2026.04.03.12.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 12:47:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260320205324.3788589-1-trini@konsulko.com>
References: <20260320205324.3788589-1-trini@konsulko.com>
Subject: Re: [PATCH] sata: Rework the CMD_SATA and SATA symbols
Message-Id: <177524563397.2281750.7056445750720248160.b4-ty@konsulko.com>
Date: Fri, 03 Apr 2026 13:47:13 -0600
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

On Fri, 20 Mar 2026 14:53:24 -0600, Tom Rini wrote:

> Today we typically enable CMD_SATA in order to have the SATA
> functionality itself enabled, despite there being a clean split between
> the two symbols. This in turn leads to potential configuration problems.
> Split things so that SATA continues to be separate and not CMD_SATA
> instead depends, functionally, on AHCI being enabled.
> 
> To do all of this:
> - Have X86 select AHCI directly rather than "default y" it later.
> - Make CMD_SATA be a default y option, given the split of platforms that
>   enabled SATA and did, or did not, enable CMD_SATA.
> - Change "imply CMD_SATA" to "imply SATA"
> - Correct TARGET_VEXPRESS64_JUNO because you cannot select SATA_SIL
>   without PCI (and in turn, SATA is needed for SATA_SIL).
> - Update a number of defconfigs to have no functional change.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] sata: Rework the CMD_SATA and SATA symbols
      commit: d05ef0f258c960c912bfaff2ccad8d7c4c6f35a9
-- 
Tom


