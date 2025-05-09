Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9633C3ABC9
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 18:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9111E8283E;
	Fri,  9 May 2025 20:57:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U7IlyJKK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 991DA82A55; Fri,  9 May 2025 20:57:54 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D9478211F
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 20:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2c2c754af3cso2292105fac.3
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 11:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746817071; x=1747421871; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4PK5a2TNv3QRmD3sgpJ+TOB13pe9Hna1xxUzBPBE5Bk=;
 b=U7IlyJKKeSn1CbH/VLkGBV7uiY2qPoiglO+itfizZfbH2ElQA3LW6jO4NuAIYKvxGQ
 556sm4GM1boz0z69lq4ZjlB3WO4ea+8VedaiSPglyoBedlPui9wzVzKY5V0CKOJKpHuz
 i1BCQ7jbaGGHqOMmLcHxo2goZBiKiOqqq11L4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746817071; x=1747421871;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4PK5a2TNv3QRmD3sgpJ+TOB13pe9Hna1xxUzBPBE5Bk=;
 b=UVBXMzP/wgx7G5+DUJy7xravR7R/ZdqhC08vRyZ4CUjTUQqIWV9o1d2TIQmcJtB/wd
 e6rGRK1YKE0Q08uz6M4nlMRab8v9ePEZKqr/dftOhZ4WMOuDKeHLMeK4bg5UMQj/KxB6
 /s1nYSXsNJduIODYdOJ+stCs7ftxBrW+sLn5O8YxgrOOkp5M78sR3yO35FPc0iOPLhmU
 Rpcxuvd8U02lLTw4XFFbfBCE7iU8Fun1zmaz+km4lgAxdFcNNwMwr4TX43RYKNktokM9
 gQiZTa1R7m0NlfBVYoGjSXH37sXOpcCAW8b0UxNQfw/31F3gWNed+uQC0Tq03RCzJUmq
 2Cdw==
X-Gm-Message-State: AOJu0YzfkbjfIIk3e7ue9A90A7z434W1QIkluzWS9yrgNe7Jt1J3XpkQ
 DA56/VxhThzVgncH8aV3ydkYuEijdHBIWTkLTrdwYH5pe1eLA1EXDvOh1Ym3pIc=
X-Gm-Gg: ASbGncu8ck5t55BHzMZ8gChrEFQ6iFigO3ewvop374QNPca1hcsW+AEsZ/wfx8Jk5Pm
 tquvWtObnkNfPMM1TTJK1K2o3BbVGmoV0lDzqeExqtW+XCdAGRPizXsY9jIUtWZkZ7E3tXRqTAv
 xV5XOIoNsKtU3wgB+YNpPTtJzftG8h7gSx5MriW5nkSCYJggLCmtXw5n0501wgjdCRK/UhjyJhm
 Sr40iomaWhA73o9EwrnXDJ7ifc6P9lsz57UIHH2UOZzO2Upj6s6EqWt0kK8zf4qT3kKz7bu4HF8
 9cXQGzUmAdWD6WeVb3rCDEbm8RqHXPbCgxoYfDVQzhg1n4jDfrtCqXBa/YriHpX5OZtp0hB/mVV
 oBaz2SGtqme4=
X-Google-Smtp-Source: AGHT+IGyi5U0zeI99OyjEWpFAbeV6UGycyV3hT/HtC4nAiGYc+KgR9O4VG3ibTOdtajStz1lf/NbOQ==
X-Received: by 2002:a05:6870:2007:b0:2c2:588a:70a3 with SMTP id
 586e51a60fabf-2dba44db67fmr2636521fac.24.1746817071180; 
 Fri, 09 May 2025 11:57:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2dba06e7a10sm721707fac.18.2025.05.09.11.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 11:57:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250315012845.399316-1-trini@konsulko.com>
References: <20250315012845.399316-1-trini@konsulko.com>
Subject: Re: [PATCH] x86: Correct usage of FSP_VERSION2
Message-Id: <174681707023.750074.17169014894103940380.b4-ty@konsulko.com>
Date: Fri, 09 May 2025 12:57:50 -0600
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

On Fri, 14 Mar 2025 19:28:45 -0600, Tom Rini wrote:

> As the code is today, we get a warning about "select" statements on
> "choice" options not doing anything. In this case, we move to having a
> "default FSP_VERSION2 if INTEL_APOLLOLAKE" in order to get the desired
> outcome.
> 
> 

Applied to u-boot/master, thanks!

[1/1] x86: Correct usage of FSP_VERSION2
      commit: 06782314308424c80c666f42a460e05ac4419f95
-- 
Tom


