Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CA4109C048
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 17:08:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32E6283A41;
	Wed, 25 Mar 2026 18:08:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ffmPIn4E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D56D83A91; Wed, 25 Mar 2026 18:08:14 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F1188352B
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 18:08:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4671cbce465so7190b6e.3
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 10:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774458487; x=1775063287; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YqnKJZTarz4rWhUfDVMYsvC19js95mBu/h8BOrfnK9o=;
 b=ffmPIn4ELY0B9NPdT5y0pVDMejUW9hLQIGDqHvHQ/zaxSguNQMtZmWZ6A919e4ajHQ
 J9YYWeArvn/D2Y0uvLrcKPJU99aFwwJm6ANnAsfKknqnh1LFd9Z5S4Tqgz3Xd2uz2T3U
 FOvfSmspmW9+1JtUyRjtJ2rLNDV8/r9buznLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774458487; x=1775063287;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YqnKJZTarz4rWhUfDVMYsvC19js95mBu/h8BOrfnK9o=;
 b=TMzeSjohpoE/mN8SdoqLJXEsznagIBpeL2UfsQZRw1Fr0CWSowXPf5u0HRw1KROfWl
 tbAHWnE/DWmgrp3POvXJWhBOaj9MSGDzLVNA30QNQH62MTeIIiH9EcGzwrzY8SEj3ij8
 lTgBV5NUzimRN0/5ADowGqyDY/GySkoY7Pfj+DcldRsVruPqc7hH0/qlIKwxuyO5+WOn
 r50YpzGJlAuy5yKSaWbgy6NSWhVNd73mVQZYn/eXP+lTtT5qBPSOsENCb9EFRPchND9y
 cD7w+OVZFuzT/wJIC737wxOANsPZXYtYSl8VCXLnn05VzPmL1nNcuau8bMCiXblxAUy7
 3Iug==
X-Gm-Message-State: AOJu0YygCnBpo4+eq3DhppobrEWTiQYhHEWx70clZLduSg7mmCjmSs7W
 I8dGgDGaGS769gEf8OT6hPTUJO9z7tlx6Dat1dPGP3DKea8QkeZGZgKe+ZJqrUwv7vQ=
X-Gm-Gg: ATEYQzyhyPx4mjw8v3wuvhwWJf56J+JslrXDASsSatgotO1wrVFvg7PsGk83i0j5CiZ
 zhZopFffSOih9z4x2/wTcj9jjBm+52RLxIvJJxOp+2TldUT518VMMhK9h10eKxl/Vmh7ZAktxJA
 GDwj0wZR01MrKE4ULGcu8pJx62q5RHeqbTxQZPs8R8mkMTE5zVNA+Y13l3VIYC2nEMK3DCC/yiz
 PiVItHhOk35kYgUo6QugScO2OV2IMOO0JsCdl4GFCZwtqfzNeMDKRETKmzDLxdda9+cxXH9bw8S
 YQbUgHf9dn5QkN6iZ+Ge86erYNnkiUZlD1oSU9bGbL0NMQV6Fe3yWBXRisUH7h8qK6W8nD0ONpR
 wR1ox8gFv7SB5+7a3TdiPhyhUjh5xRSplrEcS2iipkLHm9eew47gaDJ24S/Kg1+muRty3Cu8aMb
 BwN+MtK4tlMpEMfsxLy/GJg81XlMrf1OBht72rGpyfEn0rNSxQRcxcQicpjmVqw8cbbsopVg7BV
 dNTlWY5qbdjRMpYHiIvlLw88nrc+LDJzdviZBMGy/nrKzk=
X-Received: by 2002:a05:6808:144e:b0:467:880:7454 with SMTP id
 5614622812f47-46a5c5a3227mr1867577b6e.18.1774458486573; 
 Wed, 25 Mar 2026 10:08:06 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41cc77d8aa8sm109500fac.8.2026.03.25.10.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 10:08:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260324150903.3786680-1-casey.connolly@linaro.org>
References: <20260324150903.3786680-1-casey.connolly@linaro.org>
Subject: Re: [PULL] Please pull qcom-fixes-24Mar2026
Message-Id: <177445848570.3401805.14148956748971029943.b4-ty@konsulko.com>
Date: Wed, 25 Mar 2026 11:08:05 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 24 Mar 2026 16:07:34 +0100, Casey Connolly wrote:

> These are minimal fixes that should ideally go into master, sorry
> they're so last minute. The watchdog patch is the priority, if you'd
> rather not risk taking the others I can queue them for next instead.
> 
> Kind regards,
> Casey
> 
> The following changes since commit eb95914b9f5886b7ca0eaa2dbcd8a66bb8e5f81a:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


