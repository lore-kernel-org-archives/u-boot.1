Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2423C25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 22:27:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3142888D2;
	Sat, 25 May 2024 00:27:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UwcxMwAx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A95F3888D9; Sat, 25 May 2024 00:27:33 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8658A884CD
 for <u-boot@lists.denx.de>; Sat, 25 May 2024 00:27:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-24cbb704135so360384fac.3
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 15:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716589650; x=1717194450; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0TKt27GovnJPi90dxnsIT/VrRbHzPfJ2MQRBD5b8upA=;
 b=UwcxMwAxks/P8LJ8IJtm8hgNwkUO66Z0PRP/t7b8uVO7q02M4QVv1uiQzlJsHNegqs
 muPfTY59AuYGyghHtZHHXb42I48D0+pfCClqjrvhz7YGN+qUWLNmXyifTvrD9GUNnvx6
 1qwCbzPhauEqjaZfOLxrqaZkgYgPkrn4rG9PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716589650; x=1717194450;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0TKt27GovnJPi90dxnsIT/VrRbHzPfJ2MQRBD5b8upA=;
 b=HfeXnYdNm+iUWHekU/BQq5fVLWIQWLWGDT0NMXI9hAlGfZ1WINKm/zZsmxLhPIcI1C
 SZpB38LYlZjoBVTEhZRk3obQll3yjIf1EQ0EToO1PeXSJjOPUv78kk0bH0Lwr01ww6gj
 +eeJZYK3t8n2EqRgZR+70vfFJ/iUW91y1ER5q6kbCCZGv7AjhOanRUK2dNs99L9ft5S7
 ryBQUySVf97uZ6P3iBhsoT1VhOUpBqbAkUcUXSqYfyrJ7M4kcbhThrTBswyZzfx3CQPx
 i1zQkHMWI3HNToVUJSDUuqgBzSRp8etAEMdeilBKgIEOaSa53ohvWeWP5gdKCtiBK0tf
 QL9w==
X-Gm-Message-State: AOJu0Yw5Q2kFPzvzsq+GRxd8zIojpw6DsBBT/Z23181qlGJ2t3qz/OYI
 M2LMvgDIfOo74XXbTF4O7bM317jOK5zcBkKoBGXYpgjSiN9IpnaGx/LJn+BowmU=
X-Google-Smtp-Source: AGHT+IGR9dKM4YGvN+8UIvcfAi0UtLkqq7pJVegAyYgWyRI+Zov23dfBNLy/BJ26uXdp/TToEnyRTg==
X-Received: by 2002:a05:6870:521:b0:24c:625a:bc60 with SMTP id
 586e51a60fabf-24ca13f395bmr3606264fac.42.1716589650185; 
 Fri, 24 May 2024 15:27:30 -0700 (PDT)
Received: from [127.0.1.1] ([189.178.170.52]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43fb18b15e0sm11901621cf.66.2024.05.24.15.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 15:27:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Yann GAUTIER <yann.gautier@st.com>, 
 Etienne Carriere <etienne.carriere@foss.st.com>, 
 Patrick DELAUNAY - foss <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Michal Simek <michal.simek@amd.com>
In-Reply-To: <20240322105733.203888-1-sughosh.ganu@linaro.org>
References: <20240322105733.203888-1-sughosh.ganu@linaro.org>
Subject: Re: [PATCH v3 00/20] FWU: Add support for FWU metadata version 2
Message-Id: <171658964874.3241790.5083883377843165535.b4-ty@konsulko.com>
Date: Fri, 24 May 2024 16:27:28 -0600
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

On Fri, 22 Mar 2024 16:27:13 +0530, Sughosh Ganu wrote:

> The following patch series adds support for version 2 of the FWU
> metadata. The version 2 metadata structure is defined in the latest
> revision of the FWU specification [1].
> 
> The earlier versions of these patches were migrating to a version 2
> only support in U-Boot, similar to TF-A. However, based on feedback
> from ST [2], this series has been updated to support both versions. A
> platform would still be needed to enable one of the two versions of
> metadata through a config symbol.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


