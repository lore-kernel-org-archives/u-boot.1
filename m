Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91410C5B543
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 14:09:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B281181F0D;
	Sat,  7 Jun 2025 16:09:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L4yQvSud";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E413F82B7C; Sat,  7 Jun 2025 16:09:16 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB964807B1
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 16:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2ea0086338eso972329fac.1
 for <u-boot@lists.denx.de>; Sat, 07 Jun 2025 07:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749305353; x=1749910153; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EhHmGUuqTB3sqph2dTwm107CsCkgbgHJ85srdQeYUdM=;
 b=L4yQvSudWa2EUTQLze4YtLcq8jL/p2NpZkL27XOJFX1xBYebqLWI0/HegBx40+HHxv
 Ue7bsjO9fJpzoksVCF1Yn5xcn5KAOaDs0wubaYO333Hx/1AdEVZvJZBwgzVNLbXNxO0d
 bY/04ljOam+sd86uTdnibP5bhlebfuilCuh+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749305353; x=1749910153;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EhHmGUuqTB3sqph2dTwm107CsCkgbgHJ85srdQeYUdM=;
 b=DFlP1uRU5WBdzXO323sHmzVyVcIV+dvMex/CX7AnSYUKzK0nXa8kd8CPM6q4ThYbiG
 qibRwVV3AiR0c5XT9D/v7sYVgq4S+lsvEVek4ZoBW+3JpqcMjzIlmj21sBwiuufeyTh7
 qz0za5OupEJAf4/PbgXrI7CbENdywOre/Cg1KpRjiOH9x9wZ8v5Jj4BEHF7RIfwhY+vN
 gkFdWl8iLs+lzYTzLz1A10TFmb7JlEdrUq7NHc3FtiQ/OBjKDrmBW7svqSaKdNyVldo3
 iIrlSvT9DWDZug56h7NnqFxXte1kQg6Lo3AtJeHxSD3lTb/WaNKXpfy1o33yDuoHMUKR
 cpiA==
X-Gm-Message-State: AOJu0YwmzLdDoEgfj1gvJjSfKRNHnh0fs2ZJDeEvcQuFcaKBiMxWazc+
 dfEBADstEaWqqHZdFfOejWWk+B6XnSkhOkOkwcuhp/axw8E0GBJYsFTShSIZ9t5Fpp+JQpZiCtw
 3GQGSpm0=
X-Gm-Gg: ASbGncv46Gcy5teSnD/zbJ1NYlAL5Wo/c31meQk7Jrv6+K3yqsmA6kHT8OeaWkdKOUn
 M35vHStIlgfcRbyqhcb7iYGtL7Mt6j4HrWLoWjXLddeLo3ytqll7/h9k9r6V7szyG6qrjsWIUEU
 VHASjuA/7iz8SEfsef1QYVs1m5ttVC17+9xE7qjva+vsahfQorvDFRqlDeDmSq6SNnHvUIg6lW3
 1rkUAO3nBr5sqTx0zwSl1P2Y+6omzRRzgX3LU8Hn0amN5Yzlup9iJ9iTh50E5al/Dtc2viAfOd9
 6YqFpzieV2EK9Zv5wZv68gsly0+9pcQMH5/xoSCz0OeeI28xyv6CZOjWGq4/EgWOzebE7ZyTMTN
 fTSF/jEnA/l6vzfyMBOktKNaGUU53G9wQ
X-Google-Smtp-Source: AGHT+IHaVORbvIkwZwwewoHE0Ys5FAGIUlqB+iFVjTgF6IjSmoRBAStiTrfgWJBEHWZocsXf4J3ScQ==
X-Received: by 2002:a05:6870:d95:b0:2e9:735:91ba with SMTP id
 586e51a60fabf-2ea01031355mr4431011fac.25.1749305353573; 
 Sat, 07 Jun 2025 07:09:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ea073407b1sm954067fac.38.2025.06.07.07.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Jun 2025 07:09:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250528203746.3804904-1-trini@konsulko.com>
References: <20250528203746.3804904-1-trini@konsulko.com>
Subject: Re: [PATCH] include/dt-bindings: Remove headers we can safely upgrade
Message-Id: <174930535218.3446816.1657295359632422230.b4-ty@konsulko.com>
Date: Sat, 07 Jun 2025 08:09:12 -0600
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

On Wed, 28 May 2025 14:37:45 -0600, Tom Rini wrote:

> As part of moving to using OF_UPSTREAM and so the upstream dt-bindings
> headers we have a number of these headers that are in our include
> directory and while they are not a strict subset of the upstream version
> of the headers, all platforms build with the new headers as well. We can
> remove the copies under include/dt-bindings now to prevent future
> conflicts.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] include/dt-bindings: Remove headers we can safely upgrade
      commit: de3976531649d950dc4f5a6fa6eb4920f6799e47
-- 
Tom


