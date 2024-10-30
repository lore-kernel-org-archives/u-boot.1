Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E047AD6B6DD
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 22:59:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D161989277;
	Wed, 30 Oct 2024 23:59:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DSAryePm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F2F689277; Wed, 30 Oct 2024 23:59:38 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4B938925C
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 23:59:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4609d75e2f8so13119161cf.1
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 15:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730329174; x=1730933974; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SKm9c9v+lPR7F73CNEfLMDtLOSB6ZtWoSN0NuORLvbU=;
 b=DSAryePmAowCB/1glRmXPzb8WPqaXapQFlg6hoetjUMEihqyjZUq9ja+WbFPQ3A47a
 OTs3XxQSqNSKDY+u5HphqmarBtREIRmoeqxik3gEb+V4/S2SOVPrF5ADZIxOmJlaO+Wu
 Y1sfyIesg8aB6P1CXnoTC+ONwl6hT0GtFxvUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730329174; x=1730933974;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SKm9c9v+lPR7F73CNEfLMDtLOSB6ZtWoSN0NuORLvbU=;
 b=kKYkgegdvLkwH0wkmmAu3ORMdk770lPOg6XMb/QJ7dxbOHWSccYfZ7mp6uT7fbDejI
 sBRYZqN7eU8LzyUwuIAjzl2o0A8Zl3E4AkewYTAD3QUIpctZKOPAfnaEEV5IKMnzbXDy
 ywcKw9ytCAOTUhx/oVclZdYJRrFi8h8secFRO0gs+Kvy0p3H0fMkQ0gOKeWS5esj6qRT
 GqKJ8NLdkdZicFLa3ozGK58/GYF/ro4WmQKPOA5zcUpCbnVjHRKi5XJR1XeYBvD1oOtv
 ZiTbJHvPJhkWveQVNPJuJxtXLENtAlW9ePuvS5NBtmHFjArsi4GgdP/+QqWu6VEfYYgN
 q6TQ==
X-Gm-Message-State: AOJu0Yw58QM48MTX3EvtbAF3jo1hQtYmgITa16WbAErYRzxnbwB60mJ0
 zLb11jhHK2V8DOiNXpJ18gL9WFQzK8gbV+HNLPsSJow1gUumCdEfjnn03ck/Ecs=
X-Google-Smtp-Source: AGHT+IHzMaUPQkwNv/lwLR4ZlN75K7TT0tv8pCVzBNhNb6QoKkhwyda+61T1aS97KIWg4cxb328CYg==
X-Received: by 2002:ac8:7f16:0:b0:461:22fc:73da with SMTP id
 d75a77b69052e-462ad2c765emr7092741cf.16.1730329174617; 
 Wed, 30 Oct 2024 15:59:34 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ad0896e9sm1257861cf.11.2024.10.30.15.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 15:59:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: u-boot@lists.denx.de, Beleswar Padhi <b-padhi@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>
In-Reply-To: <20241024-b4-upstream-j784s4-split-v1-1-f1376eed37c5@ti.com>
References: <20241024-b4-upstream-j784s4-split-v1-1-f1376eed37c5@ti.com>
Subject: Re: [PATCH] arch: arm: dts: k3-j784s4-r5: Introduce k3-j784s4-r5.dtsi
Message-Id: <173032917313.2233801.10409943925291389469.b4-ty@konsulko.com>
Date: Wed, 30 Oct 2024 16:59:33 -0600
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

On Thu, 24 Oct 2024 15:30:04 +0530, Manorit Chawdhry wrote:

> Create an SoC R5 dtsi file that could be used at board level R5 files. This
> would help in keeping the SoC level changes in sync across board files.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


