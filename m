Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B82C369C2
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 16:31:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B4438291D;
	Sat,  3 May 2025 18:31:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Hb2ephaJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A4E882845; Sat,  3 May 2025 18:31:35 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23F27822D7
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 18:31:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3f7f7b70aebso2272018b6e.2
 for <u-boot@lists.denx.de>; Sat, 03 May 2025 09:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746289892; x=1746894692; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6r1zybKfxkB00S0Qko3nbqf0zI0MuLgbEg6OWtbttSM=;
 b=Hb2ephaJwwlyNj0FSiXj9WfMuRd+6m6rw7CbQHE2Bh9IRkMl9iH+w3Hw0P+KhF57UF
 +QjJkg42bkYeg2QaJTL6Pp6BFWn2EQKiBhZInfg/J9otHYXuVQQ7FH7DTxAIeI1CY38q
 NR8SBgS8r6F6gQtWWaTsa/dDayzujyFFFsrD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746289892; x=1746894692;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6r1zybKfxkB00S0Qko3nbqf0zI0MuLgbEg6OWtbttSM=;
 b=TmaYCB7HRqJGNPdfEEylTI1LU3HOQPRUaGgzGOy8QLQr2thY5+HWj1JIzLLm8eVPfg
 yg46nwCPrAsosIV83F24VCK2kvmiEqVTv+LKttykUBuc6eDchR8hWW9fztSWb1uZwDQV
 QjWQ9s72WezjrWV21Fldc58MeuGev3pGrMN+ysVIiXg4eh2SFRTnmX+zqbVUA16XmYca
 +O2sdU3olrhEG4mhJjj3qgP9so1JiyvQ0w/RX2+cHNGbweNklDESuhfXegKftakDvIjQ
 Mg8lCnoJ6cZfqZTvR0jW9FsBsBJQiE41aPVgud0P5cc406na65eUJ5Rf/0uAvvYmkL1k
 MHUg==
X-Gm-Message-State: AOJu0Yx/YSPZwaIjMFEoe7IS8qj/E+Ujxb0xPoHbIcuRqdw5pipmQJPj
 sMiRwxW2LrXizyXDzHO2nuZ+OGe2GZFMT2wI99arTIpfvlJLc5qBnY/o+uMMf2UoPPNKA4b2kWX
 H
X-Gm-Gg: ASbGnct04aoq1vzc3FnlT33p+FEe33QXw5c6oAEsYOf2zk7ORhxY0u4stS85ONIg7bs
 t5sm8IK3jbRrfkhT2z1U0yNVTFQLyG4xmEfnW/T2MymSeUxNetuXkZyF0nfLuxrT57E42QrzJdF
 aQQGnScXaJ8ITs4TBSBOdOzpl9lnnmKl0TC2uRufKcfqSS/YbgjdduG724W8PIijPSLSRT3tnwd
 8PhNkM4JE9BMQ154mDfkdygfgO5VF2fI50CN0TvqAnghlVdswG8aoBgxKh6d0uzoOf8aTuq/hus
 BetRSO/JrDDEN+vgCIrgPCaBl0ZWePEptBWdvD61YhZ1PaxCODv76sKMxpH/al0K2N+JEEo8yDS
 S
X-Google-Smtp-Source: AGHT+IF3L0oNzafOxkQozPu5iMJK975kPhJ3O1QPdCCJEwUmArCv58dZ8GTDcRiJ/hTNHoP8vdp1Qw==
X-Received: by 2002:a05:6808:3092:b0:401:f362:4bb2 with SMTP id
 5614622812f47-4035a5db11fmr700823b6e.35.1746289891937; 
 Sat, 03 May 2025 09:31:31 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607e7db25f5sm970991eaf.17.2025.05.03.09.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 09:31:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250425-effective-memory-v1-1-8531fbfe81cd@ti.com>
References: <20250425-effective-memory-v1-1-8531fbfe81cd@ti.com>
Subject: Re: [PATCH] arm: mach-k3: use CFG_MAX_MEM_SIZE
Message-Id: <174628989073.1571566.6447721991332485841.b4-ty@konsulko.com>
Date: Sat, 03 May 2025 10:31:30 -0600
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

On Fri, 25 Apr 2025 12:02:06 -0500, Bryan Brattlof wrote:

> Rather than hard coding the maximum memory size, lets just define the
> CFG_MAX_MEM_SIZE so get_effective_memsize() will return the correct
> value without modification.
> 
> 

Applied to u-boot/master, thanks!

[1/1] arm: mach-k3: use CFG_MAX_MEM_SIZE
      commit: 78c0f7e3eb0dc96df163cd5ec51de80a28fb31e7
-- 
Tom


