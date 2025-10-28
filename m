Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E871CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 16:57:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F596836D1;
	Tue, 28 Oct 2025 17:57:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rOmaZSif";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 593B483937; Tue, 28 Oct 2025 17:57:36 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF029838AB
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 17:57:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-475db4ad7e4so16687405e9.3
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 09:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761670652; x=1762275452; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ffv0GwUrvWeCT6HEosGZQenk6kuONihWy4YX6ZA8LDM=;
 b=rOmaZSifXcUcohO3Z/dfWG4saKT8s2TAkoe52uEOn0JfFXPcR812ZB60JRjnooizs4
 +ztRaCUNqEnMJV6Udj2L88Q/q9AOrOEU4CRX6sA11NZEHFw9exDK1wErxqXZgTUShdJd
 pPWMp1WYWkko3kSH17B4w9GhfrxZqNbVoXbdvqirazeL1C6R6Fj2H/irxL02IIU5VyVg
 V0AzEcHhmCi4hSwn53GS+bqxK6pN1YRLAUShIv/E6aOZN+gsVtqtOIQCo0hb3C7dM0QI
 5rpE8zTbLxGn5OogiVhgHkyvk8Zv56OV57cAHzLvs8d8fKXl3NBvxbhl+0B87BRbyrLl
 9a7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761670652; x=1762275452;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ffv0GwUrvWeCT6HEosGZQenk6kuONihWy4YX6ZA8LDM=;
 b=RbuI5BPL8CV8a5cFy996OY8VoML+xjwkRkuKJGhBEMehc1nUFjGKqi3Uk9tikje2P9
 ldxpksbd8K4tm4vvqp/PZqBUFmO+k1zKZrIaF/Z4UCctZHILEFIPtV+wigtyc9zIHFJP
 /szsvvYypUddxu+kBa16TENBqIZiOm48hn9buku3fMkFj9hm3MJFr5UEd8Ppj3tMhz1F
 cKMtBtoQLLwFccjvmZofkCgGVxD7wUrLyJ1vV+A3/fIGUNATY1L9pHs61Om35JZaeZbP
 pvlVtTCGxzrsLewGYOGU5fusE1ICpeUBliLUvUPXo+IMDqT7EKgoIwYpqjSBb+srIQBc
 hPpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwU84wYB80St1yyMQn/mPPQ1mL2+sRKdrCJXoW8k4/5Z99e3ascSx1n2l65awhNVJJXElfRqw=@lists.denx.de
X-Gm-Message-State: AOJu0Yzphx7ui+sLnCeYEeiYnPktooBR2DS2z+fP6mi02rYYPmvykl4w
 IXteY/WC/g8OXOfGGMFsfkEtXMPHrJ/iCkGOAnynorn1obWQXYeHfrwmPBgUNnMSJYvq2eidGm7
 wW/tAN/A=
X-Gm-Gg: ASbGncvL9GbIBTgS723CdhTFGCjVfMXLhqdAPF/bCedSnPEzhalQ8yRXzrXtP5peWX/
 +GICSpsg0V6sPPVgSx17hSGRo4gyNKiIVz90TiouqkgEHv/e+PHfYz0Um7AqvMLA1ecA4TxQwMo
 64XlfTJgmuXog2nbLwKjFw4yJZucwaL7PPE+EUQmb9bpO/QjLT4UENnhyAhrKNLrHK/FGUBrPpe
 h5R4Lv9QBbXiUnii5PCk79CekJSgjm3CovfAiAwrsmasdum20tpqxmz6qysgZKDhe3gxWRkdkJq
 FMqA6YQ4Tsja7vQMTvKieCWT07bZgNXUF22cR/JsOCepyoP/T0pkoh4y4vGPL96mCJU0GSXASJw
 qhC59hGxNHOiW/6JB7iZHo9I5+EUP2CXMtgOBTbavigbENtRA5JXIo5iFpdOC66Dc9ql8Y4huTg
 1Z3Uo6lO0DkELrmOiGgeXV
X-Google-Smtp-Source: AGHT+IE/4IBrPgfW4WgO6ahyVsa1jsKyOp4XJlLXyRVoHcPXauvUL8wAlp6HUykhjS8TB50fXSiCJQ==
X-Received: by 2002:a05:600c:34c3:b0:46f:b42e:e39c with SMTP id
 5b1f17b1804b1-4771e1f3e2amr1137635e9.41.1761670652219; 
 Tue, 28 Oct 2025 09:57:32 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e222ca5sm1971495e9.15.2025.10.28.09.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 09:57:31 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
In-Reply-To: <20251010024557.673787-1-hayashi.kunihiko@socionext.com>
References: <20251010024557.673787-1-hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH] ufs: Fix wrong bitfield usage for Data Direction in
 Transfer Request
Message-Id: <176167065171.4104072.270585011028939401.b4-ty@linaro.org>
Date: Tue, 28 Oct 2025 17:57:31 +0100
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

Hi,

On Fri, 10 Oct 2025 11:45:57 +0900, Kunihiko Hayashi wrote:
> Commit d232d7fdbf6f ("ufs: core: sync ufshci.h with Linux v6.12") updated
> the Data Direction values from bitmask values to simple enumerations.
> 
> Before:
>     enum {
>         UTP_NO_DATA_TRANSFER    = 0x00000000,
>         UTP_HOST_TO_DEVICE      = 0x02000000,
>         UTP_DEVICE_TO_HOST      = 0x04000000,
>     };
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (master)

[1/1] ufs: Fix wrong bitfield usage for Data Direction in Transfer Request
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/d0dfb8c635ab4ff60090878879c9f75f9a7193da

-- 
Neil

