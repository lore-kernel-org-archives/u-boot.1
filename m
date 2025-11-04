Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B6FCCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 19:05:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3C44838A5;
	Tue,  4 Nov 2025 20:05:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KiQoDiA3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 917638003E; Tue,  4 Nov 2025 20:05:08 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E83B8003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 20:05:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7c2816c0495so3845864a34.3
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 11:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762283105; x=1762887905; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=19SbC4bkEKcR+fsijJKmX8QymvHi54208RDuOnQSpng=;
 b=KiQoDiA3sHdO007HBf1J4EjihFdMbXpbqNNgvkffP1zZHRgMr1iSbzZSftd4buJhkR
 //OdHvlthn8vndcz/HPe5DuRDuuydQbPzxIDujcchueOkXEmdtKIqJADSl+MtZM5GTI+
 myC3cte8qlVv0+DWCx7DNMFdUrO78oLfIwI0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762283105; x=1762887905;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=19SbC4bkEKcR+fsijJKmX8QymvHi54208RDuOnQSpng=;
 b=BcpUp029MP4m5AkvLL6rezSiVdSCz0kJ2mOxn0uqiS1QJjEhzgh68nLwgM7gfcPUCj
 BN5STQXxvMymO4bhJj+/Bunqgqvl80CEcZ7TuLFHAEoLOvZQnPI6C4/mMMaWM9iHGX1W
 NqokXKCzQwdFISBKR8Qlg/aoa0fCYNkRv39xnN7wkOEBgTPvAqEL2UyL6UCIw/+P9XGr
 33nujXgK9dMkfcf+zp25yGiQ/3GUC/g+lRdpYgvzQtb39LYphgKpL7+QZoHhcvOnhzUA
 Bq4r4wDJdq2lm6buBeQF99PfjYMHchEOy33GHEgAzkLu1As67wE1H9vAVxbftdoDNk5H
 10qA==
X-Gm-Message-State: AOJu0YzkzD5aNP+E3eJ43q+h8WxOF1uFPAU9BQZsOEELcY2p1s/cjIFp
 7tswlYnH9FFzG9359ANKNv77JiYPbqzTH8WZXMLlMemqjSqNhxkQ/hUw+Y3lK9TbBW4=
X-Gm-Gg: ASbGncuYLe0+1XF2bPu6qf4HDjQNkv2TSaohKVrazLzhbArJUmsIc2U2Nuk3Zkt8ZTt
 5t5SWLSK9w/LKWkvQMReiVlyF/fzf4/4eMbY10XWJgHuiCso4iopD74JjffUfKOfIWZCzHnoohV
 PVMvUGv6KOt0gVe/6Y3pVn6gqY5R1tNoQO+qa0R45WO/ii/iDRmLeEscxEQGma+5cVKDXsANhlU
 RYZBqyDH3AV6LXEskntYua4Prl9XV/5cYXe3z4vbfkL3z8Dbm2lk+NBcRcE7Uca1VZrK7ZMlL8r
 QT1V1kiR8Uj8eivIB/p0e7MwSMDGj1KmeoLUZP0fxisYiJA42ncJegFCdxCDls4YRDtsYKSNNdo
 UDSyporD3xNOYxaAaaPKlnWWTA6Ceew3AQczW3HrJBTMNIxDhN9XM40aNijyhJxB91VCBWNSSUo
 539zH4Ow5hby4lmRCOy2f/FUb613Du6JUz6XiASQ==
X-Google-Smtp-Source: AGHT+IF5H2cSn4Yyv8oV4M1ayKDagCuUouUBPkYMBWMcEKYGeTXd9BM0+F00LyjpVIjJxo6n51BCHQ==
X-Received: by 2002:a05:6808:4f68:b0:44d:9e0a:eef2 with SMTP id
 5614622812f47-44fed57202cmr251526b6e.65.1762283105210; 
 Tue, 04 Nov 2025 11:05:05 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44fe4ca9d03sm352611b6e.24.2025.11.04.11.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 11:05:04 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251104181221.3980984-1-trini@konsulko.com>
References: <20251104181221.3980984-1-trini@konsulko.com>
Subject: Re: [PATCH 1/2] CI: Move to Ubuntu 'Jammy' 20251001 tag
Message-Id: <176228310404.3992564.12719024892457136091.b4-ty@konsulko.com>
Date: Tue, 04 Nov 2025 13:05:04 -0600
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

On Tue, 04 Nov 2025 12:12:20 -0600, Tom Rini wrote:

> This also incorporates the following commits to the Dockerfile:
> da7942de29f7 Dockerfile: remove Python 2.7
> 183299d9a400 docker: add OP-TEE and TF-A build for testing Firmware Handoff
> 
> 

Applied to u-boot/master, thanks!

[1/2] CI: Move to Ubuntu 'Jammy' 20251001 tag
      commit: 8b7295f352b262713361fe03c62410de47e49a36
[2/2] Gitlab: Drop vexpress_fvp from tests
      commit: ef34776f21969a71594dc6224d0e54cf5a2a980c
-- 
Tom


