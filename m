Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B92E95A6A
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 20:42:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B885986EF3;
	Sat,  7 Oct 2023 22:38:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GREyfY7D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D77086DD8; Sat,  7 Oct 2023 22:38:03 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45BC986DC5
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 22:38:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32320381a07so3206165f8f.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 13:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696711078; x=1697315878; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=stQSGOaj8ptIQ/+6aHNhJiBRHGbS4lZLVdtLy+Ccalk=;
 b=GREyfY7DKCafLP/lTl8Qvvq5Urh5uq5SgvlBKdZFYq4Bk7tWXdEE8ComnyKYJeLRQs
 GouQcPbhRap0pk/R/pEX1MJOt0T2Xsa2jmBl+es64G/p8VModZj16dXqkzCie+0Ay/06
 6rUpjxdrzN3NAu1eOcFMhfJa31p1W76mKKL1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696711078; x=1697315878;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=stQSGOaj8ptIQ/+6aHNhJiBRHGbS4lZLVdtLy+Ccalk=;
 b=trQ/3tWQ5mUTR2K/I+QxE4jyAT16GRTsLb32rVzNn98s/t2PNHK0JW4wez962WYGp1
 BxPErM183IZ3XAm+ZQvKRE7WlZWn5LagTLABD0j6/lFbxv87LTnSYgh5o/WlyG4PCcgg
 /d1CNJc5ktNeORNWLvzG00aWl7pxT688YPRS4tEUqeRJPL64qcuZi2YYz5r9FvLLnSwP
 TVFsTgVRB/D+jIp3JcUScdOsEtdvIyiP2gW/HYbKnFWq0KmXWg2h8Ufd2+e6RaP3eQFW
 cB7HMNv9hoJNwBQFzQ7BAU5S8thBCn14+dHeq4cDiKTwaiM2HnZ9yHJNeM4r3MnjyiT9
 o0Ow==
X-Gm-Message-State: AOJu0YxD6i7u1K4k0ly0l+TWXZnHZkzJUKCwihAb7jI/yDD7TbjgedAq
 9/XZGENdgDI0fq0ufgsPICBu3Ev4tYQUBkmMrcsbNQ==
X-Google-Smtp-Source: AGHT+IFpwYtw0o97hscSc1+DMU8DO0HB+207ZT3AumGs6WYTj7nDkmUUNcB3DKw3S37xIseARpAi0Tf0Hqjrqigzbz8=
X-Received: by 2002:adf:ee10:0:b0:317:393f:8633 with SMTP id
 y16-20020adfee10000000b00317393f8633mr9705595wrn.58.1696711078545; Sat, 07
 Oct 2023 13:37:58 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 7 Oct 2023 13:37:57 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ2pJJRnsoHVknKUCRmOGuTsFKFh=NHU=3Nscku_gqrBJQ@mail.gmail.com>
References: <CAPnjgZ2pJJRnsoHVknKUCRmOGuTsFKFh=NHU=3Nscku_gqrBJQ@mail.gmail.com>
 <20230923194424.1739224-11-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Sat, 7 Oct 2023 13:37:57 -0700
X-Google-Sender-Auth: nhJYCYNw6G649R1uQjALF906mHY
Message-ID: <CAPnjgZ2FtCe7u8sX4w_O2xw7A+=kRn5OD+FgZS2fUrKsCmmufQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/27] moveconfig: Use f strings where possible
To: Simon Glass <sjg@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Avoid pylint warnings by using 'f' strings where possible.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 56 ++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

Applied to u-boot-dm, thanks!
Applied to u-boot-dm, thanks!
