Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8B5CA0EEB
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 19:43:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 811E083096;
	Tue, 19 Aug 2025 21:43:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cJzm2VZP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF56382F49; Tue, 19 Aug 2025 21:43:14 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CAA58211F
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 21:43:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-30cceb382d1so4320511fac.2
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 12:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755632591; x=1756237391; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nbOYT07WJ2NXx1hvdAYrjVfG6b8MTjrw5lsqJfRk8qc=;
 b=cJzm2VZPKRyd6KTmeSbJhSuVrXbUMxaCX95xCWQrBLADOEd+KrUrSHouo5m6c6o19q
 1dRX8ldofzMgzq0ZAci2TAQK6g6kfsYYWKJfkLfnaE0xFhe2R5kysi8bdHlLOR+hWKoD
 iYeFk7nfh5IvZqL8fzZ7rIHBo7aNUuZ9tD9s4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755632591; x=1756237391;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nbOYT07WJ2NXx1hvdAYrjVfG6b8MTjrw5lsqJfRk8qc=;
 b=GstZ3uFoh1/oq65Ox9hZOs/qy4FhmF2j0fThg10J/HFiB2J9dIX/CVtN3MeF5RDTZL
 qj/pGxR19kbHkbzn9rQf1/cbUmdHKs50oI7zfM8EWOKaNgW1k/loFPhBnmcokzfNsXnk
 tHfWu7lSFUCK2OgsVx1iqnCX9fO07c7XIw08Zwn0vJ/627q5bkvQCrqA6pVgWZ7WnSxw
 YBL3ufrrwtJx0/mniV93UZ3tZZJhlM7ZyH7XjpQO1j2bIlxn5VhhRuFjgNTc2Y7XTZfU
 7d7N3/WYEfioCQRZomjHZlS/qmXq7PJ7X2o+dm/w77VZqY8lIoxsJ2g5ilxeftmT3tRk
 NjLA==
X-Gm-Message-State: AOJu0YwI00eJIxygOJruXcl63lE99wy7Ta+GiNLiSprAqkCxTGNaenaj
 X8KYN7Hl4JqcUe+gRuQ0L407BiwePxTmGjOo5GUT5GSRVN7xDRSpaK6HtC+wCXlermkqhD5hMUo
 SLYF/q6Y=
X-Gm-Gg: ASbGnctffOflMYNkdC5KYuA8NRje5Jo4GifW3d7G+bStpOhwe33ntuRK4cZktVpMYO1
 sUSTvSPLXkox0Fjmc5nFe46QU5QrEN6uNuSopza72Cdp/zKbTK3MEkbNWWw3cmWA+uXFm23gvzH
 tpgoCdN0QHrmp64aupXPrCto72AX6ZHtjRT8F3seAgM/pDfoe/AxWGmngKsOxw4HN3Qb5HAEQ0o
 ZivT8TihHFYEgjOjxg4an8qVmq/F2iYd2Reb2pBDRu19eORVFMHTojoyshNJw6+W08Cm/dOHW1V
 fgs9e6h80ceaPxd20gY5sMJUjjhM/Olicxq/RBBrX/4R7dgMptgmUIGrva2M9VGB+Vq8Iflz+4C
 Vb/K9gHqy9IUGqFmZuG+MrWR81Qga5iHEvM1Id5HOD9hlbElH20KWE2E=
X-Google-Smtp-Source: AGHT+IGZ2CdaaNB6o3FT6XkqIaa97a4OwaSbmy6genZyfV1J9o1Qd9xesWPZImTKjvmznIeJ3d0txw==
X-Received: by 2002:a05:6871:e7cc:b0:30b:bd6a:de31 with SMTP id
 586e51a60fabf-31122a30951mr168453fac.34.1755632591078; 
 Tue, 19 Aug 2025 12:43:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7439204e5easm2525109a34.38.2025.08.19.12.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 12:43:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250812-sound_rt5677-v1-1-52105f86182c@linaro.org>
References: <20250812-sound_rt5677-v1-1-52105f86182c@linaro.org>
Subject: Re: [PATCH] sound: rt5677: Cannot test unsigned for being negative
Message-Id: <175563259008.3359676.6718182750053844922.b4-ty@konsulko.com>
Date: Tue, 19 Aug 2025 13:43:10 -0600
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

On Tue, 12 Aug 2025 11:36:53 +0100, Andrew Goodbody wrote:

> In rt5677_bic_or the call to rt5677_i2c_read returns an int so old
> should also be an int to receive that value and then be able to test it
> for being negative which would indicate an error.
> 
> This issue was found by Smatch.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] sound: rt5677: Cannot test unsigned for being negative
      commit: da938a4254b4cf9d4e7b894a0a30536b0d9266c5
-- 
Tom


