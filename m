Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CF4E7718B
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 04:06:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 896A68069D;
	Tue, 31 Dec 2024 05:05:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uSbo5NOe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC07080584; Tue, 31 Dec 2024 05:05:43 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE673804BA
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 05:05:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b6ff72ba5aso796948985a.1
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 20:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735617940; x=1736222740; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JZjSFaMBCwogLKPnWr0FQoYKTLxo4S9b/EsvSzQWyTY=;
 b=uSbo5NOeJeB+e+jQlU1IgILftvVJk2kacnIhgt9JglKJ+Z+s74tQkShjyDQlNU9tdB
 ZLKvBa1QjE/L3LKJvz8DJ6StyBjubZo/j/e2WOO2Emv0XCfyGqmt7E77q4rcKtncdBX5
 kHZtxSdAmfHIAmu2si4Eu6RZ5uK5j+J+keatM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735617940; x=1736222740;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JZjSFaMBCwogLKPnWr0FQoYKTLxo4S9b/EsvSzQWyTY=;
 b=H5gweuFnTXZN5sQVrLoXQDWVoOaddqjLo7EEczaJMKD3sI23L71me/QAL1rRlylQGO
 yXhmiEEXx9LeqGFZYSuVbSouwZH/3TU7nWIOIfNsPbjd7VnsqeogDBic5w520/Nz1czE
 y/nLLTBA/qFbFnUNLyxHZiQQ0J62+6hmEOJucc6LWZ+3alJzamuc0V/3g26cW8ArKM0z
 m2DRTOcIW+zVyZ5sibtNL2otAmN3UVxNEn8+qF6g6wtoqy1pyZEW2WNT8lmCyEtCIGPQ
 Yjo34F9CS0Ei2w2wJDOiNEoG1c338B7u3+Vwe/Glp8c2jOXcFAYqRbtzh9fqZZv5Rpeg
 tK+w==
X-Gm-Message-State: AOJu0YxsRsimphuU9ONmWkVqC/mm1A8eX8aulqK8oDzaNGMPOYAqoxyv
 DHgG/alSI3iFgOGGmUKP/HQB8mPA8guN7hoS5155OB0TN+bUOebVxiGbOfrElf2rRNAapemOFyJ
 O
X-Gm-Gg: ASbGncsY7KH6OpdUBt1AinKdBJGgtTIEY/uFEWDoau9NDclUmSeMOLur9x0h81nnc/0
 68GkrTP+gZHkrZ/TXjictWuC9hyHOrMzWhGjVqEDdcU9pxLJ+pPxfz7a2ISGSlOqMKZtvfdyWOv
 NIlo2+E4eFDoKY4gPkS2HpIq7kR68EF7ENbR+k1B9sT0LsVXk57CstawZv5r18P93G92uGnKb68
 9CQ11KoQELm3foSwtdUA3zmc0zzOI5TRN4gWHKaT465BhueRJkBFKpa
X-Google-Smtp-Source: AGHT+IGnblkPiTd/McB/HjKJH0xsROqVKdGucZO+3DBnVwFsgBBB69F5CF/NJhe9OWMfo61zVKyGbg==
X-Received: by 2002:a05:620a:244c:b0:7b6:72bc:df67 with SMTP id
 af79cd13be357-7b9ba71692bmr7535525285a.1.1735617940704; 
 Mon, 30 Dec 2024 20:05:40 -0800 (PST)
Received: from [127.0.1.1] ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac480886sm976081485a.83.2024.12.30.20.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 20:05:39 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20241212201459.1613044-1-trini@konsulko.com>
References: <20241212201459.1613044-1-trini@konsulko.com>
Subject: Re: [PATCH] Gitlab: Make test.py stage only depend on binman et al
 testsuite
Message-Id: <173561793871.257558.7078356733174992891.b4-ty@konsulko.com>
Date: Mon, 30 Dec 2024 22:05:38 -0600
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

On Thu, 12 Dec 2024 14:14:59 -0600, Tom Rini wrote:

> Our Gitlab pipeline is currently broken up in to several stages. This
> was done with the thought process of "we should test tools and if
> they're good test emulated targets and if they're good test real
> hardware and if they're good test the world". However, in terms of that
> first stage it only really matters that binman, et al are still
> functional. And for a few years now Gitlab has had a "needs" keyword
> that lets you refine pipeline dependencies. Use this to perform the
> minor optimization of having test.py only require that tool testing job.
> This will become more useful later when we add long running testsuites
> that we do not want to block later jobs.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


