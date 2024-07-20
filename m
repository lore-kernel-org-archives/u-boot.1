Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025EDC3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 17:10:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E35188897;
	Sat, 20 Jul 2024 19:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PA5v5OWd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 191008883F; Sat, 20 Jul 2024 19:10:18 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03862887F3
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 19:10:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7035b717880so1761408a34.1
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 10:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721495415; x=1722100215; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eUTuaHrWY1rUSuuWpSj7wJc6uwZEv42rS2nntAdu2z4=;
 b=PA5v5OWdAckU5/PYABacvsj2xdrO+7HqpSOoV0WJIAo6nKz4R6ras/whj4mfjeAcyO
 cT6AJmPA12NteNFslsmEMzubctT8PsQasseOaZwKmGSAcrd9MxWuWFsOYr0z2xVFGyte
 kBFVRxJdGVhlUDbI6Dfm2nK6QhfziTlIgljBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721495415; x=1722100215;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eUTuaHrWY1rUSuuWpSj7wJc6uwZEv42rS2nntAdu2z4=;
 b=WRNK9XsMGwp3qQ3KdioNT0CDzVYYT56rWaANgO6zL+YX9I/G4jO2jDLqTTRW5cIQKn
 mXupc9ZGcF8p+zJhtA5Fmf/k8kPPiC5SIb186QQ1v9NUZMzi1+/wJzMHEP75I7vHoaAc
 iK+GubyD3Oz36Z9jVXbJliJSlEixe/1yJjl0/RnnyrwoEc1CccxtStPViaTZqN2SgJgl
 WUpdi6+BK39Qw9CF/5bwAgmuRywlQKunfjVVGifdB6CBI/Kh760i21Ev2qs0HY5qexuP
 r3GB0zNxYoBgiUvV1CGgtTpFn7bLtm6vzsRQjRN9HSajdi/Jo+QNDYN1tkB5QjN0BHAA
 Jh6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgSSdIbz8xA9q464AtXAucDn1mdUZycot7kElPzTw2ITnYh3yhbaXX9amxr15aE7QGdbFDDYJeTnpsxuEISi351bKjyQ==
X-Gm-Message-State: AOJu0YwG2RktpHD1Hv2Xrdr7zBi+aYxBkKgcebr85YUJRcHLB4uXo+IW
 6A6Pq73/IEVi16ahxBHEqJ/WB+NPlWhDdIG1HN1zRTB7aqENM0TZOYxBZuRFdM7l8AWZaUWLwuW
 D0NM=
X-Google-Smtp-Source: AGHT+IHgNkNNOckYArWIV3RgY36cmG9MqhT6U/Yu/4BN14KF6kKpZI71zRPfDLAtmBzC3GuWHDupRA==
X-Received: by 2002:a9d:6f93:0:b0:703:6f95:98e9 with SMTP id
 46e09a7af769-708ea09d9cdmr4153058a34.10.1721495414499; 
 Sat, 20 Jul 2024 10:10:14 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f6189bd5sm773037a34.65.2024.07.20.10.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 10:10:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Udit Kumar <u-kumar1@ti.com>
Cc: nm@ti.com, u-boot@lists.denx.de, j-humphreys@ti.com, 
 marcel.ziswiler@toradex.com, vigneshr@ti.com, b-padhi@ti.com
In-Reply-To: <20240715174301.2688466-1-u-kumar1@ti.com>
References: <20240715174301.2688466-1-u-kumar1@ti.com>
Subject: Re: [PATCH] configs: j784s4_evm : Increase Dynamic memory
 allocation size
Message-Id: <172149541234.3268377.2927049348821454979.b4-ty@konsulko.com>
Date: Sat, 20 Jul 2024 11:10:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Mon, 15 Jul 2024 23:13:01 +0530, Udit Kumar wrote:

> Increase malloc size to 32 MB to align with other J7
> family devices.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


