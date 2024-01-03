Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9561C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 16:49:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FAAF877DB;
	Wed,  3 Jan 2024 17:49:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EjYEM8Ru";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D38B877EC; Wed,  3 Jan 2024 17:49:40 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58D72869F7
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 17:49:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-42836658198so3688861cf.0
 for <u-boot@lists.denx.de>; Wed, 03 Jan 2024 08:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704300577; x=1704905377; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x8FzrM/2GrJ8q/m59vuNYcslwqb6j+o0Sj7EuPKK/2c=;
 b=EjYEM8RufBC6UpD89M7v0txwVxdOArNtFlzXrsfzrOMp8YuXLIZ/FC3zY/FZfCC5uh
 YnR7zrnSl1fpSBmvtZb0Zvr7zND1ei06NgrzxIM1CqL48Tngj6MdNm/22+VzxMSqgThs
 QSfDi3mnaxZKZNgoeu1gqPZL0okDLnQ1BSBQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704300577; x=1704905377;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x8FzrM/2GrJ8q/m59vuNYcslwqb6j+o0Sj7EuPKK/2c=;
 b=AzBnfF2nIhMvVINWjGDk22Gflt67hhbwqvCikMb2hkumKWxSrE/uHMdQTcrJ0Q8nJW
 7uPn+XfnnzYLEy5jb1HSXXLWG7DqqY7Kp6Cb0rwMZrwY1QkQdHqF74Mf9UjR2TE/Oa4u
 RkdSoAyBEiK4y3v43mooyYrMBAaobQlYTAI1TJANMuwcYlFJv9QHcWsk/c5JMABM3pI2
 D0YnlKAbI75q6cU3c16rbiDjBHbxucQ8zpNI4Rl2aNk+C9lsNJ+jOXBsBnafjwqqebTJ
 9Ql7DwexfinMV+8D5w22IiLrM35tVUvLdSbAwwdpr8EQAyfZzvuT3zvrcnLn6t4Cgrb3
 zKyA==
X-Gm-Message-State: AOJu0Yz2dbRbtU5/iIvg9r/k+DulsHuhQqJl3udbb13N/frOtvgjTEUI
 k0xxLCNUnCL3YnqIVXqIxP9jUFp7ZHPjEQ==
X-Google-Smtp-Source: AGHT+IE1pUfU8udMsAy8SbOw1gsjr4x1cwaqS1qO/7cLQR4L5r1MBTs7Wn3hYX7zf+BKVKeR0xLG3A==
X-Received: by 2002:ac8:7d08:0:b0:427:9dbf:841f with SMTP id
 g8-20020ac87d08000000b004279dbf841fmr21656705qtb.6.1704300577136; 
 Wed, 03 Jan 2024 08:49:37 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 w2-20020ac84d02000000b00424046df696sm14236206qtv.43.2024.01.03.08.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 08:49:36 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anthony Loiseau <anthony@loiseau.fr>
Cc: Anthony Loiseau <anthony.loiseau@allcircuits.com>, 
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>
In-Reply-To: <20231222154408.21519-1-anthony@loiseau.fr>
References: <20231222154408.21519-1-anthony@loiseau.fr>
Subject: Re: [PATCH 0/1] MAINTAINERS: fix folders within glob pattern
Message-Id: <170430057637.1088233.12533163432702869981.b4-ty@konsulko.com>
Date: Wed, 03 Jan 2024 11:49:36 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Fri, 22 Dec 2023 16:44:07 +0100, Anthony Loiseau wrote:

> From: Anthony Loiseau <anthony.loiseau@allcircuits.com>
> 
> This patch fixes few folders I think mishandled within MAINTAINERS file.
> 
> For example, files within drivers/clk/tegra/ were not affilated to ARM TEGRA
> because rule "F: drivers/*/tegra*" does not match them. See MAINTAINERS file
> embedded documentation on top.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


