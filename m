Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DE9C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 20:01:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 540A082F49;
	Fri, 11 Jul 2025 22:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Fw6oMxAm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E5C382FD4; Fri, 11 Jul 2025 22:00:51 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E0AB826AA
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 22:00:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-73cddf31cb2so730286a34.1
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 13:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752264047; x=1752868847; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7gDt2FJ+fLPVkNUDcckuuH8wgVjAU0bSydpeFKbFSbA=;
 b=Fw6oMxAmhVTVbjuRgo3D7dgJDbUq9DsW9eJpoONDJS1CDOIcfZbyxVjkMm8OVBsTy+
 n/A/+V4qcdooO+lMS/eHtSI8ae3IBHonwEJaNg/SSWyZGuZVlQjzKa2xn34JIzDKMY7h
 om9ChQlG+Ne/pTyCPXFilG7xeHuZBrq4TNglU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752264047; x=1752868847;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7gDt2FJ+fLPVkNUDcckuuH8wgVjAU0bSydpeFKbFSbA=;
 b=vjmgxTNwdKXu9KbIRfI6kkked3fAGH986myEdMSk0MJ3JzO6cWBNKe12TrPPsCc9w/
 p1aalGp+Od1qnJZLRj2zZ7jU3rEeMvNUVr4bCUfPIH70wiGuuGYmk7l6eOMe+UrY9YTy
 sFoFovBSjs5KFuwwFOlVx29vpI4AXaaVQFSIl5obD20RcwIZXFV9NPl+QYgaBp4J8fkT
 7nG1jERKpAd0SpGdOD9EMbnPh02jWw6XLEHVM7nyNae43BJsb5rt6xnkomWbLFpvdHpP
 KKyocSU9NKMXu+O7R/VO8DPMRdTf2/nIjTlbKJgExUG9VfD84vzQaEFQZXxhmmIaoxtD
 nEZQ==
X-Gm-Message-State: AOJu0YxQ31D5BKAiJSPXnATmEbXTNc0kWf6PURfFuUZNkyE2dRJXrx5F
 B0yHyapvhsXjixREJ/utDLI7C82L+0XDXnmFaSdY6v3Ezvl3cQ27X9DCCfC0iQiXjxcoHurBL9s
 UsB3ZwFk=
X-Gm-Gg: ASbGnctfupr1vpDJse7sbUJyXpG8SlXRONG1J734bo9JHRkx53ej6mo+LNQ6bZvQi4W
 lqwCZ9WTM4DG4AYi3bVbititpWtEZVEDqJnKjNFxDHzDsLRRZ46VtkHbnmmjoijEku3ClScWaO0
 DTAB8iYMOcjIEc5gPs4Jld9XPlufOp9fCJalyoIhpgYirjNo2951WImrHt9Otqa4YIihUxACASz
 mF20Zxx0eQh6T51Cvk8beMAqVKCpFaN/H2NccLABicasKev0rIEOIZIN/4EGD/bMh0CpG6idSmz
 ax1ZXTYYAxYE3PujXBJfluf9swJXRLbnjyzs7KKAdB5ZDs/mPKHMUHyRgZs0cou+71ISSyxXBMS
 0LsEc43+d6V5tsO7lbeZrQAJa6T4JET1elp7pBT0q8cg168k8bdjL/NM=
X-Google-Smtp-Source: AGHT+IGL9eOybGZhAjzInRfUdQBPzaBk2ldEThSLOwxNr6iDxdx8RjkgNZw/4M08SqtKtDSBlILf6g==
X-Received: by 2002:a05:6808:16a9:b0:40b:1597:b2d1 with SMTP id
 5614622812f47-4150e31e356mr3956646b6e.17.1752264047009; 
 Fri, 11 Jul 2025 13:00:47 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-414161e2b74sm666516b6e.0.2025.07.11.13.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 13:00:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250704-ext4fs_fix-v1-0-5c6acf4bf839@linaro.org>
References: <20250704-ext4fs_fix-v1-0-5c6acf4bf839@linaro.org>
Subject: Re: [PATCH 0/3] fs: ext4fs: Fix some issues found by Smatch
Message-Id: <175226404601.2365211.417227970989193952.b4-ty@konsulko.com>
Date: Fri, 11 Jul 2025 14:00:46 -0600
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

On Fri, 04 Jul 2025 13:32:41 +0100, Andrew Goodbody wrote:

> Smatch reported some issues in the ext4fs code. This includes a
> suggestion to use an unwind goto, to not negate a return value and to
> ensure that a NULL check happens before the pointer is dereferenced.
> 
> 

Applied to u-boot/master, thanks!

[1/3] fs: ext4fs: Do not negate error before returning it
      commit: a7e44898b4d2484a9fd3226f44bc9b51d174f1e3
[2/3] fs: ext4fs: Use unwind goto to free memory on error
      commit: 36f05e622446046a93ff3a2c6958b65b85c6bffd
[3/3] fs: ext4fs: Perform NULL check before dereference
      commit: 2d6221262ee948b9ae407b51a9bae693348826f5
-- 
Tom


