Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F7BCA0EEB
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 19:43:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C9908304A;
	Tue, 19 Aug 2025 21:43:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p/dvnvzP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F118809A5; Tue, 19 Aug 2025 21:43:13 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CC40809A5
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 21:43:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-30cce90227aso1968101fac.1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 12:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755632590; x=1756237390; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4s/Bqn5qkzawApNPKq09SWPigduCxg7f+tspzWKlumk=;
 b=p/dvnvzPJmJZGTyYidM55WiA7TqXqQwAlp/xj6RQy4+pl0T1ACOCV/CiNdumSvMUw0
 04c9Rbw5qsIcRBVsvazPhnOgqwSs+ywkuoKyuu7oJsYa51PSGOsGXD9xUOXRGkcsphxB
 iOTqv0eU0e0Q+YndbLLZ/sU+kUgo1qBMdFyZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755632590; x=1756237390;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4s/Bqn5qkzawApNPKq09SWPigduCxg7f+tspzWKlumk=;
 b=oIkC/GsE6apwk+5iNUc8AAcZWUu4++BfV8E3VPeyUYs8BquFvkND3dV5vjqhh4prG+
 05hQzEdoB2fv93syaClr1T1J/Bz1iwBQqEN97gkp+/Jq/Vdl1uAR2APEKTcpCn9sYvNE
 b7FkZ0KKEZSuaqGjRvDLiDh8EQ9ENXTMMCw4SxhDthNUh54+lLE6pIWgbhlcWlUp8qSU
 rc+e1i/D9QlptN0TOJqk7cS9ODAEDxtFk7Z7ITy3rRmLB7+6qttuj58xHYM1R5f9jP2H
 LP+DDrjEoUBCZ69zxhq7GGhvlL4/so/oNgixhMFgEBTat8Ef4Zs9YWpI1Sb7H506HPvu
 TQ4Q==
X-Gm-Message-State: AOJu0YxiJvrDqjc2moB6m41Gzrp2VaT8QjhcJYAO151KkTma+7eE9D4U
 Lj2QiaXLAt4y8/G31MduQRWCAA8CiUnoqAiRcKPKAc4EKS4/+N7j/+QKfHbR/08ONl534I8uJwK
 YKSYG73s=
X-Gm-Gg: ASbGnctRXwhbMbQAiRNDS1QwhurvLJkEzEaeOXZq8KkAk7ROCWGc/bOHIpE5ZHWT5fW
 mIO8uURZ34f3+LDVZL8t0B4VUneOjFi3ZcxK/a4Js3mXNYyAFVXGmKTN8jGinxrREcn1Xgtucmv
 B4w/U0nW0qZmq0CoKV7j1SqkmpPMyHmJfciIM2Ui+vG1LDQH+tx4rBD6n41jJesB35nhl1hdp8P
 1fgrC5rydTJ58sdJX60rbH5AVLs6b0ekZH+vBQqs7JDxO8MM+hVUd/+Fb/9BFvM56ToG+WoVfxc
 uPVqZDIIxmyc7pVfd02cUork/X5G2xzxfNM2IiSSsQAKC68yZnDxiwyVOnYKBAMpAbzHPX0L/s/
 BjIcdqcWkIuSThyP/J8pONeY/q+Sb65FzXNnEvo0fzGCRe4RtMW9mu2w=
X-Google-Smtp-Source: AGHT+IG0gWgr/n/TdYbOzMi/4NEdFZ2PV3kYxJR09IegX36sWNzGfdej29TMdfh3iojw8/c7XVlltA==
X-Received: by 2002:a05:6871:e80d:b0:307:9de2:b3bd with SMTP id
 586e51a60fabf-3112298752amr155374fac.32.1755632589959; 
 Tue, 19 Aug 2025 12:43:09 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7439204e5easm2525109a34.38.2025.08.19.12.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 12:43:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250812061021.1237280-1-ilias.apalodimas@linaro.org>
References: <20250812061021.1237280-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] tools: aisimage: Make aisimage_check_params() static
Message-Id: <175563258902.3359676.3475594081740395062.b4-ty@konsulko.com>
Date: Tue, 19 Aug 2025 13:43:09 -0600
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

On Tue, 12 Aug 2025 09:10:20 +0300, Ilias Apalodimas wrote:

> We are trying to enable -Wmissing-prototypes and this functiion is only
> used locally. Mark it as static.
> 
> 

Applied to u-boot/next, thanks!

[1/1] tools: aisimage: Make aisimage_check_params() static
      commit: 544bf0aa599f9afd8ac5224b005edd4b5bb374ed
-- 
Tom


