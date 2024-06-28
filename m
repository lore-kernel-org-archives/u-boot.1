Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12A7C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 19:51:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 533C58827A;
	Fri, 28 Jun 2024 21:51:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="stNCWuuO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EC1888590; Fri, 28 Jun 2024 21:51:41 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39DE088168
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 21:51:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-700cc8e447aso535457a34.2
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 12:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719604298; x=1720209098; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4wSLh2fG4uhcnoOUctT26qoV6bd7QmNp7VQg1TSULOk=;
 b=stNCWuuOi68FR9Yp5Fi2ZhZ/yELRIrBGIBXwK/8UmnX+s5H22nGTax6L/7nu2h9TnR
 mGrK34Akva9eSdWEf+hai2+CjXIp1KcDYb2fRZ5F4nq+Ky8J4PmdNphF87FBAqytZeaY
 Ada23UyY0pn2NB+1MRWBaxNXjjXCpeWpec1xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719604298; x=1720209098;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4wSLh2fG4uhcnoOUctT26qoV6bd7QmNp7VQg1TSULOk=;
 b=dtltIt+iwG4sTmKrLndLuMH6zWo4NsnpF0HAfaCQfeTnxVnmxPb2tQSqeRxLNNGCh4
 7lT9Q/RiUZ/3jfZ0M0/dO3fiZbES4LNsniuwkacpFYr7HtvC2DxDeY7/HkZAfVwTLbUB
 nI3Jyf33E/T3dgXg5Dk3cei8+7avlPArQhOw+vn10Ih5uIV4sKG+hUBbUT9IfBvPSNF0
 6AQYF36e2SW+DUUY96b5Pbpiz9qsH/bbhhroSKuaztvjlDa521IxgYqJd5CtBHv6jlMJ
 nAlYDwIUDGsjAuItUpvgCUwdlS8UXLR0h4tYqWKS3K6GiJzr5GtqtsEJSCuufmFtwjwC
 PkAw==
X-Gm-Message-State: AOJu0Yzalie+g9kxn7N1RlDQmqKO2CdMMoHFsBUit0QOv9PHJim/W3/E
 7Kd/WqmdzDeTgwX9EGFDC4CA25yNEV+5TKyirU24b1vleuzcwaTNRV3Ozn5f/42M6Wuwv+PrQwW
 WLkX+VA==
X-Google-Smtp-Source: AGHT+IG4CJXDykrT/NnoEvqZNEnCmd7kUtwwuro7TeH6As+HeAYUctSx8ticEKBxShWp6aUHPCWdFA==
X-Received: by 2002:a05:6870:d623:b0:25d:1c0:803e with SMTP id
 586e51a60fabf-25d01c080aemr17273568fac.7.1719604297896; 
 Fri, 28 Jun 2024 12:51:37 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-701f7b3926fsm430025a34.74.2024.06.28.12.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 12:51:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, 
 Padmarao Begari <padmarao.begari@microchip.com>, 
 Cyril Jean <cyril.jean@microchip.com>
In-Reply-To: <20240622201832.4103353-1-conor@kernel.org>
References: <20240622201832.4103353-1-conor@kernel.org>
Subject: Re: [PATCH] board: mpfs_icicle: change maintainer to Conor
Message-Id: <171960429701.3614441.12634542422111124555.b4-ty@konsulko.com>
Date: Fri, 28 Jun 2024 13:51:37 -0600
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

On Sat, 22 Jun 2024 21:18:31 +0100, Conor Dooley wrote:

> Padmarao is leaving Microchip soon, and suggested that I should take
> over maintaining the Icicle in U-Boot in his stead.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


