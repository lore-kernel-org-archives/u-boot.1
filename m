Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0922C83F03
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 16:29:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9862081D5D;
	Thu,  3 Jul 2025 18:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="neHHzRnE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6178282F00; Thu,  3 Jul 2025 18:29:37 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E733380E9A
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 18:29:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2ea08399ec8so115173fac.1
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 09:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751560173; x=1752164973; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a7mexDc1JTwRqZxtrvO+1QgkpyK07FlJMUqZROePaaQ=;
 b=neHHzRnEOdC5XzbTJXYRgEuCDmM3opR/qJxMxw6DW3EfDf2LtNOO94pFs8JqA/m9nQ
 LAEI5qV7GnFIRlxltAZa0yvzq60I6SAsPZTcJ3+8tdpZ8Xk9k/BUlN698fZbnfjv6/bo
 LxLdZrh0hgFB4htoBBvkCksWg1FVsHZ2vi4Jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751560173; x=1752164973;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a7mexDc1JTwRqZxtrvO+1QgkpyK07FlJMUqZROePaaQ=;
 b=mf8HYQZATgP8HGo6xButEm1naZhcXoAVC2jWWtTZM/r4+yTaVzE5mqq+FKs4IfiMba
 6P5UqHM5dAohQ5/9U9KnCDOdJNLZ4kzddAivB08voVyerNMFxmEpy7bT0TaQAYj27lhQ
 3vrN5W4/xiFnErlqMyF3ah++ATcEegX5WqWRvLc6sexjGLbet7RrOP+bC2tAtU2nYDYA
 Xou46ZvvDL4TyoiDe6nAP5x9wX4VVlKydh5WnTBBwADiTK9VO4FgBEr8qLijOyi54bnT
 vGk8XA7OqT9zYZKNLhrC7WTgRZ/+wT+UJLVVyQCG8CymmH/Rm7dLYWx3hFqua3Yrt4Fo
 /FDQ==
X-Gm-Message-State: AOJu0Yyl1oRnN9rFvDFOJv5FQCiRslqdf4vookLFNzOsiuNhWZpZviHc
 bTahvFDpsLT7gm1TICP+v6DiT8ekFnzsUixTLDOT2/zpiT7tthNPVnaTACT6cdviU5w=
X-Gm-Gg: ASbGncv6oPBQ0gW0Ul9iym2qHgYz9qIOCyknv7lwr+xW9vW7ZaeunlA0+K59mBFbIYC
 OvjOyaw7UIBzPtnHaBEtSYKZCmtkC9Eim0sEmsV4Dl+nomBPgsnYci7PICw53SP0LnCqZ+OLwZy
 j/JwGWlKrFkctMmHnlTVJtIsODn69toGUsfTAfYInfVVpgYT/vj7hkFN9cYlPUQwKbqkyfi1Fgc
 DHZtWhF1eKkhTKi53mUeVPdFH6rP1EkKPjNq2ahhD5+FHDCP6yaqF1IBULBva7ahTEHNAh3xEl6
 Qc7ukG53C67OUcFp/ueUHFeTSyCmjYCnqEmKjgRInIm19OCZerVUM/CEWev064wTy/ilIFEXeK2
 W3pdasfMKCIYEX8KbN0E=
X-Google-Smtp-Source: AGHT+IFCcMgxHrXXkPfLkn+zaMsyzQYOZRGJIMHgzm+TpGFs/xGE0CpDWCN5erVA8mqYwMIx8v836Q==
X-Received: by 2002:a05:6870:948c:b0:2d5:25b6:ec14 with SMTP id
 586e51a60fabf-2f76ed921bamr2515556fac.15.1751560173615; 
 Thu, 03 Jul 2025 09:29:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73c9f7714c4sm19400a34.28.2025.07.03.09.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 09:29:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com, ziyao@disroot.org, 
 conor@kernel.org, ben.dooks@codethink.co.uk
In-Reply-To: <aGaPFKZQNGrEbCnV@swlinux02>
References: <aGaPFKZQNGrEbCnV@swlinux02>
Subject: Re: [GIT PULL] u-boot-riscv/next
Message-Id: <175156017281.3012248.548651943497669024.b4-ty@konsulko.com>
Date: Thu, 03 Jul 2025 10:29:32 -0600
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

On Thu, 03 Jul 2025 22:09:24 +0800, Leo Liang wrote:

> The following changes since commit c405bab7661dd60420e97a4edeb3162e9d7e02c5:
> 
>   Merge tag 'mmc-next-2025-07-02' of https://source.denx.de/u-boot/custodians/u-boot-mmc into next (2025-07-02 07:51:57 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git next
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


