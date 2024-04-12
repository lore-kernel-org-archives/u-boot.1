Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86867C00A94
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 21:59:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 057BC881D7;
	Fri, 12 Apr 2024 23:59:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pjSgRfc1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04C9D881EA; Fri, 12 Apr 2024 23:59:32 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02D1F87E01
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 23:59:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1e3ff14f249so10597275ad.1
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 14:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712959166; x=1713563966; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OPVT0BYK7d4uZyibyxy3PowH2+HIhFxi9gd/Ki0UC5s=;
 b=pjSgRfc12Xvza9ctZc/+54zJdaEV3sF8FI1Ruiv2EgYvMtQxRh7Lp00tc+ZKxa3pKM
 jYt1R2ggb1isthjt8TgEjp/iJlYHG301FxJFx1H9DyLG+7lYYa3PdZFOZ8wrIAfTW7dD
 +thP1c3OwRd9l7uwKe76+Oz7rdEuxb+skftXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712959166; x=1713563966;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OPVT0BYK7d4uZyibyxy3PowH2+HIhFxi9gd/Ki0UC5s=;
 b=PjY4kNRDynteiKgp6zrsIflFid2UJMcOzyTLmRdOXqYDUJTIsHB8ImteJF56NZRBL+
 vHkdchy1/7+nd5QVANokbY9RvA9f6xOrIj2d9BJn6t/Wu1ymAnNdvo1ABljCxfokFm2A
 iDavCDQXN0zcdjXqdXUuRDlV3HU1dT4Kd1reJ+rdB9UQs5p/W6w1e2TWtg5otJTfbxNJ
 CJiPVSdlg/xVJdhTHf5hpGfmsfEKXDkuWOWkiFNg88QAwsy+oEKXtIo52AH9d44zMOiu
 lTplD/pkaP1bKMzREVKyXE8GvRC/vQNib8qRdUkS9WO7GPCEiZb9liI69/uu1M/Yl0Xi
 VSMQ==
X-Gm-Message-State: AOJu0YzxT7EbwresNB3k98Ml7fsbFkxmqDiD/a6AbOUzB8RI4lVgCPiS
 iVlWcG84INHCiwUKlS2wBcsBSBsOiEzqW94pNx8OKpp7TZRMCEpBzJdSkwl8aIdE7aJM6EUgeta
 mQ4mwCA==
X-Google-Smtp-Source: AGHT+IFrgHIpOEcyHijFCHIdGwFuoBP3dyp7gbZWLKFyTwcbMH4WK/ePfHwYcIxckbarXe72HSsr/A==
X-Received: by 2002:a17:902:e885:b0:1e4:52c2:d05c with SMTP id
 w5-20020a170902e88500b001e452c2d05cmr5050246plg.29.1712959166458; 
 Fri, 12 Apr 2024 14:59:26 -0700 (PDT)
Received: from [127.0.1.1] ([2806:102e:18:245e:b648:93e1:5c61:68a3])
 by smtp.gmail.com with ESMTPSA id
 kw7-20020a170902f90700b001e45240eca4sm3472958plb.196.2024.04.12.14.59.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 14:59:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, git@xilinx.com, Michal Simek <michal.simek@amd.com>
Cc: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <cover.1711548887.git.michal.simek@amd.com>
References: <cover.1711548887.git.michal.simek@amd.com>
Subject: Re: [PATCH 0/4] zlib: Address CVE-2016-9841
Message-Id: <171295916545.1044279.17310073514978206531.b4-ty@konsulko.com>
Date: Fri, 12 Apr 2024 15:59:25 -0600
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

On Wed, 27 Mar 2024 15:14:49 +0100, Michal Simek wrote:

> it looks like that only CVE-2016-9841 is not fixed and this series is
> trying to address it. The first two patches are just preparation based on
> changes which happened in past. The third one is actual fix and the last
> one is following what has been done in Linux kernel long time ago and don't
> use incorrect zlib version string.
> 
> I tested it with and I can't see any issue.
> ./test/py/test.py --bd sandbox --build -s
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


