Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD837C7EE31
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 19:32:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3D8E82B34;
	Thu, 26 Jun 2025 21:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Oa/kDZg4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADCD782977; Thu, 26 Jun 2025 21:32:45 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95D3C82977
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 21:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-60d6303a11eso724515eaf.0
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 12:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750966362; x=1751571162; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KtYasOqNQKsizEm3AplswBboM1mnsitELYbbxJF4KOI=;
 b=Oa/kDZg4ZDIrbnusnxyPpX7hvqAaAeGWR688w1PAMm0cyI7urZf9R0qae/ppa6o9JZ
 qjiIuV8PFK8zwo/YnoEE5pu2jX5R3R5tkLbRt0jN+aSxSvuncMEpjowsLF1eGRrlIgXg
 m2s711EUkwQCMNBdqEYsMSvTXzryK41wwnGSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750966362; x=1751571162;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KtYasOqNQKsizEm3AplswBboM1mnsitELYbbxJF4KOI=;
 b=KJhJJCNHttd7IpJDSsQOHXLUFSYXJRmEu/BlJxivhNB0kI2m+mHmoJBDzUJRoYJV6F
 zSInsfUmrMvOkXjhkmznDdPHl/meFmUtBvdCtWMWxn0kmDiATqSMNm1qanCMI/kcTYKv
 +H4LwvAjYVlIzltiZThPRwvNsvmQrwBP0KhmTUGfVnff+qwvoCRmQT0i4Qx/XLC7Yksg
 IeEAOD+sphPnonSEd+o4qXvVPzx8Pk8VfDK1WHFyZDZvPwIQQCr4YBotGq9q4Ak9yDbc
 nm5eoL6qEgu+Ks0hK/4WZhWdVV052ORUqv/4wquABCFTcHflc4Dogw4zpnmvHnrU/ZQr
 1Trw==
X-Gm-Message-State: AOJu0YxLhLS0k8VtV5+BzpZ94HWL1Bg/LvMkQDkOID50GVlhpdpkg7+E
 KL+FFkcQ5RyFxyD5LcZ6gvANem/Rh+x4vhaWQUCTNZ203wZtIje6lntccTyQHpB6OyVCBb24thC
 oJHxgcDw=
X-Gm-Gg: ASbGncua28T2XJv9dyVzDB1s/1FHmSn7SjLMGUgs6k7WrP4qLUqGw1G49YIKcNZhiCQ
 FlJjz/kAZC2V1AN8S9nu+vZPbuc8Utx2kk8L9G+WFhsMt2atKw2Cmd4P0V6WP1U9TEO4MDR/v+F
 ofCSx6qpAsFCsEBkAhDAPHMKmZHHGnuQi2IQ7PIfHlP/1ReOEatvOyPfbAxPI095Qd65rnzavka
 uXbvgYwzfb9KyAli3Hg4/Owhq61Uf+1INXddspLkMJmib1sQAxxuax5pfh+BRVpqVrzZPNkLwIh
 gOgkSUCm4QtiHt44Loy8aMJQ0/iIvhq8CHcRelIiygQWK0Gi4F2dNMSQ/aAzoeMSAStUMd+T40q
 daJc2qE2agfn2iKNRSobk/yFAJ0D878IC
X-Google-Smtp-Source: AGHT+IHq4SjCCmCwK0iWAcc167u8yFbtcxGN3rGPZP7rwFd3tQcr7U7mAiRmp03TAgMlUVUA/Zh4AA==
X-Received: by 2002:a05:6870:ab88:b0:2c2:dfbb:2dbd with SMTP id
 586e51a60fabf-2efed40b4afmr207874fac.8.1750966362306; 
 Thu, 26 Jun 2025 12:32:42 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4eab4e3sm511958fac.4.2025.06.26.12.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 12:32:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: vigneshr@ti.com, praneeth@ti.com, nm@ti.com, msp@baylibre.com, 
 Akashdeep Kaur <a-kaur@ti.com>
Cc: u-boot@lists.denx.de, vishalm@ti.com, sebin.francis@ti.com, 
 dhruva.gole@ti.com, k-willis@ti.com
In-Reply-To: <20250625124053.1953344-1-a-kaur@ti.com>
References: <20250625124053.1953344-1-a-kaur@ti.com>
Subject: Re: [PATCH] log: Fix the compilation error for emergency log
Message-Id: <175096636076.1890320.12136144240629875372.b4-ty@konsulko.com>
Date: Thu, 26 Jun 2025 13:32:40 -0600
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

On Wed, 25 Jun 2025 18:10:53 +0530, Akashdeep Kaur wrote:

> The log level "emergency" cannot be used as that results in compilation
> failure. Correct the macro name used to print at this level.
> 
> Fixes: 249679658750 ("log: provide missing macros")
> 
> 

Applied to u-boot/master, thanks!

[1/1] log: Fix the compilation error for emergency log
      commit: 757227777b6ff446491fe95977e699b98dbb0434
-- 
Tom


