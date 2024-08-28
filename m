Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15281C636F0
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 18:27:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1CB988AC2;
	Wed, 28 Aug 2024 20:27:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h4GG1FfF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D25C988A2D; Wed, 28 Aug 2024 20:26:57 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF391886A7
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 20:26:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4567dd6f77fso3296201cf.0
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 11:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724869615; x=1725474415; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IQ6xP7blvlkj3SqLPTsxfKq0hOBmEQfqnb0qgvuvT94=;
 b=h4GG1FfF90hxXuesLqNg6jR0rDrIyGZqo1IOWbe8MWK6bYg27BK0uZyr3778cCDAJI
 to6ewuFqOShGFMVx3PIYBcoI4dfR1pWdcMJpKY0KIyN16wecG2m1oUKCIu00MQcfe67P
 AfuWEf8NRRo3dljZl+rX4lEo3EMiPcm4qW5Zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724869615; x=1725474415;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IQ6xP7blvlkj3SqLPTsxfKq0hOBmEQfqnb0qgvuvT94=;
 b=LOIhBu0MgIs1IbzlfEnN6Ie0x2kVzcNyGVvyfucrDdOo3ErfxqusQeipxMXBVLyuFJ
 n9SBTj86jw15rFG5DMa7VNyf8QXkGYmCVH8i+EAm042VXdY+TOOma3TZZVlVZojty0Wc
 iHx2bvOu2/nAvn8mRxViG4jzPGXuC5yjmgpe1xZlh3eL8aVAeEYw44cTNEPmgVpz9hqz
 Mpoqw35J3PQO5XVtUXtKjng1C5Z+qf+4UL4UACwKywH5nez7C0GWn7SGv2cdprjG46A1
 YmoYmzdwW3MdbuaFaDFcMOljUb2RyIKoJoFhma5jHr7Jfd7uFcrvbRjswS3GsFt4MQx7
 MV4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmwWeeU0qOr7cvms8i2wX4gVMiFAI27uH4d3nHaHUn6RNNbJgosikyDfI5tgM1NdxlbhLR1Bs=@lists.denx.de
X-Gm-Message-State: AOJu0Ywe0xZDUQWfPpDrw/+c3l25BL79imTtWBOvAOvTq8cC5894r+fU
 FW9Fidv/DdhPXZ36l2sdQ2qhdRtKczME4Lfi35d2dxeSt+hQtaD4L4AQh4xhaa4=
X-Google-Smtp-Source: AGHT+IFwSt7WEPDZVAG4H3lCEmQAztFK6ezTD3v81E7zYxtcgdPCNs/LS1ZP4n7D4jdVCV0prVoICw==
X-Received: by 2002:ad4:5143:0:b0:6c1:6acb:e094 with SMTP id
 6a1803df08f44-6c33f32d9e5mr959166d6.6.1724869614648; 
 Wed, 28 Aug 2024 11:26:54 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162dcddadsm67835536d6.121.2024.08.28.11.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 11:26:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Greg Malysa <greg.malysa@timesys.com>, 
 Bo Gan <ganboing@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, 
 John Keeping <jkeeping@inmusicbrands.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Shengyu Qu <wiagn233@outlook.com>, u-boot@lists.denx.de, 
 Hiago De Franco <hiago.franco@toradex.com>
In-Reply-To: <20240819162449.101449-1-hiagofranco@gmail.com>
References: <20240819162449.101449-1-hiagofranco@gmail.com>
Subject: Re: [PATCH] tools/scripts/Kconfig: Update references from
 kconfig-language.txt to rst
Message-Id: <172486961295.3064792.1951041174315896382.b4-ty@konsulko.com>
Date: Wed, 28 Aug 2024 12:26:52 -0600
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

On Mon, 19 Aug 2024 13:24:49 -0300, Hiago De Franco wrote:

> The Linux kernel documentation has transitioned from using
> kconfig-language.txt to kconfig-language.rst. Therefore update all
> occurrences of kconfig-language.txt.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


