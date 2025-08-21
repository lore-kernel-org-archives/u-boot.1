Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9768FCA0EFA
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 17:16:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA4A582AC4;
	Thu, 21 Aug 2025 19:16:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K1sv42Co";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D090380548; Thu, 21 Aug 2025 19:16:36 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A06E380B9B
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 19:16:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-30cce5be7d0so781529fac.0
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 10:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755796593; x=1756401393; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xLZkhPFABYu6Zt5HuKy1QoP7UxEQETLuaPkE/La4M/c=;
 b=K1sv42Co0yELjMj5/tfgw8oOETB/lJLov4Hbso6mkkIASMuYHp5GSSPDaFYcyS4pnn
 2v2+IpFtr0aGP2dWkJ+gCMBIvFwz5TGZpNfKt5ryzvJZegeEk0hcjSocGUyEPs4fx7Kd
 IrMtQNkToaskWG96sm/gCCbmF9cix0pKM82YI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755796593; x=1756401393;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xLZkhPFABYu6Zt5HuKy1QoP7UxEQETLuaPkE/La4M/c=;
 b=lje4jjD4faxbkzhr0oCFLOwMT1VV9qkJfaZJShMbTEE9vb2OtmTw8e3O6pEq8n49kD
 zzkqoA5biMVWtMCadHo3ioDXkR4jt2moKE/8fNTtZq+gGkmlw11oby08YFKOA8TmMhNE
 Xo8TarNiG6HIf7f3O3CDpMJaOkNCBnC0F0pAkwGTOZ+0OJlPJe5ztQh00+OuUKC/Otq0
 yUber44YMWlsPDA1yFwpn+LpN/STgWiuvwVI2BL9gzIq7vgssaky1m3045aKRkSI6CDe
 wUGJJG/35Q1J+r2JYxCmzzPECgXV9oNeK3dGw9amQgc3gIAJiUtWpSOxhtvGpHZ979YE
 eVcQ==
X-Gm-Message-State: AOJu0YxL8ArRTCj54GUi9WSQevkC189C8SwmwR8wa5UbskVcO5qSOM/c
 pY0Y/BSTxcUsLQm4sGtCexfIyc8pSuduHg26r5ePDCQrwPAM6WyD6rpARiIU7zjMLDFFvqiXx1y
 eYkjtst0=
X-Gm-Gg: ASbGnct4hkShFBKjPCwuIXUUF/2MkrQTsqU0dYPbLXUWchJhD0zTOyAp0IpOuZaMwAP
 n6Fmm4b3fikyrmKTYJqHp/SG2ekP7qEueqAxT9JA8WQnkh6aAcNZ2qYPjhd5zMGsvHImVyxeERV
 V6BF3QsnFvPUvSQnlS9B1JAbxGQpIlMCdQt2FZ3CEHm0+Y0cd8W2qtlOSYH4Qb5FgrCac9ywKoV
 fL2tRBo0Rs4yPcMhIycHxwNO9Axc20xPwSEnCWUrq4ykV7XvdEOVFAe84Ou76etON069Rw9kQyX
 eGPA45kER7AdN7QMRX4J1TF9akPXhRuOVtbXaE/wQP/D4YqH6n3ZH4o5YIAFsA6Qmb4f+r6vbhe
 6tc+ytzayiXnkKPhiAtvkThWyhR5H7Vpu0G3IEC4URch6MOBRDL5T3QQ=
X-Google-Smtp-Source: AGHT+IHvHxcfsdlbhL6JQlkVFfL/f0yGHAXEuYJYRaEuk302xPpEkqjFosod4fz9fBn/YZqFwZ2TgQ==
X-Received: by 2002:a05:6870:9d8b:b0:30b:d568:4ec0 with SMTP id
 586e51a60fabf-314dcd426ddmr7887fac.25.1755796593326; 
 Thu, 21 Aug 2025 10:16:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-310ab952d79sm4999909fac.15.2025.08.21.10.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 10:16:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250812-maxim_codec-v1-1-3941a84c0795@linaro.org>
References: <20250812-maxim_codec-v1-1-3941a84c0795@linaro.org>
Subject: Re: [PATCH] sound: maxim_codec: Fix coding mistake
Message-Id: <175579659198.3655101.7638761012996251332.b4-ty@konsulko.com>
Date: Thu, 21 Aug 2025 11:16:31 -0600
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

On Tue, 12 Aug 2025 11:26:06 +0100, Andrew Goodbody wrote:

> In maxim_i2c_read the code mistakenly just returned the return value
> from dm_i2c_read leaving the following code unreachable. Instead assign
> ret to be the return value from dm_i2c_read so that the following code
> can operate as expected.
> 
> This issue was found by Smatch.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] sound: maxim_codec: Fix coding mistake
      commit: 2b751d42c35c36f7e3739d7bc7064f014e1263c7
-- 
Tom


