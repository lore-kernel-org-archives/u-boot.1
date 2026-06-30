Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CE3C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 17:05:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 951FE84AE3;
	Tue, 30 Jun 2026 19:05:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MSwH+FpL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B24984AC0; Tue, 30 Jun 2026 19:05:38 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63BB284AC0
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 19:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7e6b5737bb2so4963369a34.1
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 10:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782839135; x=1783443935; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DN6RH4lnENpZRRB2iU4tPuS3kbGSxevq3Dsy6UcwFCs=;
 b=MSwH+FpL5nr7ho+ESBZPwHtGUabULUNGj4dDuY6L6Cu9RMowKYUG1lIK8bBB/nRZcx
 QCCtwWn1P/2dIUcTvt01k+MO8YR+kIwy+IzOYP8/L/G/Fl1FMeQcBKFy5onUgQXuwoGz
 tKgFEF+CDm31f59K0eVQe6alY3fSvZQ6XSkJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782839135; x=1783443935;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DN6RH4lnENpZRRB2iU4tPuS3kbGSxevq3Dsy6UcwFCs=;
 b=iZ4im7KMpBwZk6xLKKVD0TGBFK3ESHPRvl7b5hRfUBKGmMvjEJECOKk6y6bl3DhPQm
 kh+OeDQRLwDFHnhHDcp/EdRjidP9RkfhyBFjA7zjo5Q+GsngjLyft08MXSBsfWn+3sVw
 oaesb5x9iFQdcSSgvVyvZzUUGWlOuTQVCkmss2hPYnImlCGiVRWlAMesNq2YzTylK29A
 /VkhbkXb/VLZXKyDQAnrxMa7NVbJhFwKvIGXDAtntWaTEyYGhKGEffBOLf35l4VCHLGo
 k52Btvx2sJTLwnFlLOU7BbBb3XAessnGoKK0B9X4qkv+MpPLQrop/holBLbN4NiiLhfO
 FnXg==
X-Gm-Message-State: AOJu0YwqUJCITphvfQGbROrGAsjujsY41X3TF8yh9EQdlaLNnmC2UKCc
 OvVMr/a/GVkj0f2Teu60nx3LsRSNFMXu475LQKY3erdBobRPh7haoRqKNQpXVQEuDc8=
X-Gm-Gg: AfdE7clA0kiFV8xueLFIw4AAQ/g9/NRYk3QMFJFMBH1qCKXBTfpzgmIYVwcQy8Bqjqv
 H+JkN8Ok99/BqIdHOrQriAZzUgnuicbTUDrsuRx1ICUanNNqutBxcz8A1+h4IDA4xU/o13n6gLx
 ysLe2b4+cWfNBCJnFLTNzmu76fqvWvuQ4IkcWmZS1jWre3bOKrpw2gNI3vHBoZW1gv3e3469v8v
 r76BmMbwLxlyXvxN5XKNxblZBapJlblCipW4bmPf8QH4xajot8k+ypgnEhXhek3SwJaZ9LvDAYg
 pC+5ZHp2kY/k6GIZPoqg4/hymvkuGVmX77G1NaZwIVv9jNfJxFkygfO8Ki4rB3zN+yHGPQ8h0F2
 SfeH17QjBWvNAkBXQRjnEOq9TdzGw8/hMeNqa6syV+0TGI/gn2Mew32B+k3ZqkZ7Zj2FD4XNGt0
 SvdbAYV/5SFL8mmUNhcFwJyQwp4hhInUomKJeI898sRZsVA60aJwQcAyPwji5G3lvFjXvWiNznl
 mdSoWFLTZ/4Jgx+YjhYKmcS8UOMatnusF9MqxnhM9UTBkTdCw==
X-Received: by 2002:a05:6830:660b:b0:7e5:f957:a61f with SMTP id
 46e09a7af769-7e9ec7251cbmr4263039a34.18.1782839135183; 
 Tue, 30 Jun 2026 10:05:35 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e9ebf89825sm2786550a34.3.2026.06.30.10.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 10:05:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
In-Reply-To: <20260617023819.152378-1-marek.vasut+renesas@mailbox.org>
References: <20260617023819.152378-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] MAINTAINERS: Replace Cortina with N:
Message-Id: <178283913457.999303.17507996199229428532.b4-ty@konsulko.com>
Date: Tue, 30 Jun 2026 11:05:34 -0600
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

On Wed, 17 Jun 2026 04:38:04 +0200, Marek Vasut wrote:

> Use N: to match on all cortina files, drop the large list of
> entries which represent the same set of relevant files and miss a
> few in the process.
> 
> 

Applied to u-boot/next, thanks!

[1/1] MAINTAINERS: Replace Cortina with N:
      commit: 85a35bcd635f3f2e7d226323c2bbfef09d8d9443
-- 
Tom


