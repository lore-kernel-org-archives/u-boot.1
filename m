Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BE2CCFA02
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 11:31:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53144830A0;
	Sun,  2 Nov 2025 12:31:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PJkoU2kU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3158383642; Sun,  2 Nov 2025 12:31:41 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B0358307F
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 12:31:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2947d345949so30775765ad.3
 for <u-boot@lists.denx.de>; Sun, 02 Nov 2025 03:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762083097; x=1762687897; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yNvnlFURNu43xzylFjOal1iwVXB5cxe/l3i5Eyp+Wc4=;
 b=PJkoU2kUKgij6Jk1oKxDpMOYUo49/1w/0+rdw+t6nUvniDkPpAtuwQ21o3PdExIK/b
 nOFNeRQsVaQM72uqkND1xq3NXRbDkOCB2oQpitASOa1l07Nc4QJ6x2VZ89fBIPrF1Kg3
 77yqVHTHTNDoMGeqZZPoXX2xaOBb30qvaBoIskK2qazDt9qp0LjGhwOrmd+x50tBmKwu
 wnHX662qhYK2kHaHTdLqWON1aS4bsvm02GmItYjT+7S7gbMpKC2xzzsxeSIBosq64yD7
 DZzkKJZf2KUI/qrbYqVwAwTwsjgf9agMMq1IsjUkkIbCtlki9qI6vj3b7Caj/0Hdtnx6
 oW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762083097; x=1762687897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yNvnlFURNu43xzylFjOal1iwVXB5cxe/l3i5Eyp+Wc4=;
 b=wktttx3OQFjcnULeeAVXlvR/yaFGEb7K6lgO04GFyhONM5sxwtrD7JE7ojtYg7GD1F
 qLHV4E65jIapyVemEBUcb6iMzInhWC7KbxLHNY6GnEHhPe+b5Mf/eJNaWP9hx7mz6QBt
 UiDS9Gq6AJazShED+7Q5vYQOo4TpVXgZ3RK+Q43jVtDXeaL0abHc5Fno9qHW0IlUwj4k
 /WebCk0baktA+S7ZodRxNbWA9tgNnjv9dsp3GHUqhpTr/ulMk6Aju/FrNkvVkgChFiIw
 UPDivs+gOTc6iX+uBmOm9MP+MhUpvSovMVsldhiNVB+B28rDKEQouGU+wg92a+GcCPnc
 gK6A==
X-Gm-Message-State: AOJu0YwksajHTrH7tdPdtbjwIbgPqZww3Zt0T3SsxBDlPIX10mgYGF4l
 IYFlx2RtdeStg1KQkrsWVq+sOUiCOlDzeDSwTDzYF1ozSDbnW1fAhAdAgYPvY1T1
X-Gm-Gg: ASbGncvh6Y+kovjzhr2HGVRipDR4tPZmSdJ8NEuqfyAKoKvppbgy6k8/QJvpXis1EYk
 0nmVGnHg/OSwMlxIZU0JVA296QC29MjW7QbfIKkUv2fqAQTA2lq9eLSOOH9zAe8F/Bt/ke2Htoc
 1hhkm2rGf0+ZXKC9JZcAA0i3MfPotHzBehQ8Ez3qKZ5nbphQGPGVEpdvFXU/Lt1pwv6ylIxJ7/t
 0mXOCMgvoDdWxWaqobquMzzm1jLWJntXKxsXS79v7mqPBHdNTPlvhRNRXn3TE2qQQFoRMOdmoL+
 BP3SrguLVgL0mJmXKsII5enARXX1Pe7Yrx6aI9k4ykgU7F+EmySaV6IVI4LjT+DogSC/wjwzPC0
 s/n75JTwyC+2hF9jQf4kImq0ENfOt/Rx9CBfvBe2Xbu54hJJK4vYMKMxT5z/ssCuIco68iyldPf
 RyqaqFqVCGUWpki0ThxY/tsBBz1A==
X-Google-Smtp-Source: AGHT+IHJOx6wFtqNLXFwH44sYYdc8S/VCcbTObXE9lMotHp3jjWyI5RpqaVZbheP9ziWf8f/Ph5POA==
X-Received: by 2002:a17:902:c405:b0:295:21ac:3533 with SMTP id
 d9443c01a7336-29521ac3969mr126803545ad.43.1762083097353; 
 Sun, 02 Nov 2025 03:31:37 -0800 (PST)
Received: from localhost.localdomain ([185.213.82.75])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2954448e9c2sm62700985ad.23.2025.11.02.03.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Nov 2025 03:31:37 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de, Dragan Simic <dsimic@manjaro.org>,
 Dang Huynh <danct12@riseup.net>, Brian Sune <briansune@gmail.com>
Subject: Re: [PATCH] rockchip: remove regulator enable from device probe
Date: Sun,  2 Nov 2025 19:31:22 +0800
Message-ID: <20251102113122.1038-1-briansune@gmail.com>
X-Mailer: git-send-email 2.47.1.windows.1
In-Reply-To: <20251101203429.1603832-1-jonas@kwiboo.se>
References: <20251101203429.1603832-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

Hi Jonas,=0D
=0D
This patch resolves the previous boot issue mentioned earlier on the mailin=
g list:=0D
=0D
[DEBUG] rk3399-nanopi-neo4: SPL SD init may report -5 due to SD power-on ti=
ming=0D
=0D
Quoting the earlier observation:=0D
"=0D
While testing mainline U-Boot (v2026.01-rc1-00070-ge34d01d23e45) on the=0D
FriendlyARM NanoPi NEO4 (RK3399), I observed that SPL sometimes fails to=0D
initialize the SD card with the following message:=0D
=0D
    spl: mmc init failed with error: -5=0D
    SPL: failed to boot from all boot devices=0D
"=0D
=0D
So the NanoPi NEO4 boot stall appears to have been caused by the previous r=
egulator patch.=0D
However, it is puzzling why the issue only affected SD boot and not MMC.=0D
=0D
This suggests that the delay method proposed earlier regarding power-on tim=
ing=0D
is not the actual root cause of the RK3399 NanoPi NEO4 SD boot stall.=0D
=0D
Tested with this patch applied, and SD boot now works normally.=0D
=0D
Regards,  =0D
Brian=0D
