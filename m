Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C07FCCF8555
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 02:52:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC0BF89034;
	Thu,  3 Oct 2024 04:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kLD10lXz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5284C88EC4; Thu,  3 Oct 2024 04:52:38 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41F2489001
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 04:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6cb2f344dbbso4145016d6.3
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 19:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727923955; x=1728528755; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mdz/ik0jYjh1gLMb0i/t2y2r2irxHMJ4Y0iL/fNqPCs=;
 b=kLD10lXzeW055MsoD0yhUQ2mPXVNB6pWvyyx5ln9Yheqev7k2khTEykZplLuOQSHZs
 e5I/WoFJT0LV12fdtbK5l/UHAY/4c8MjLTkfPik2+aZIjHd6UK1ohp+LaFh/dikw05mZ
 9Lyi0y+EJ3prLCdcs6hC2hDGfnmdnLsWFb5T4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727923955; x=1728528755;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mdz/ik0jYjh1gLMb0i/t2y2r2irxHMJ4Y0iL/fNqPCs=;
 b=MfIlJ1ddsv+VXKLT374RHjc5znmkd33aIpytwTDDOUi/ngsuIg6gigkxtRvpcZKgzd
 drzLYVJtuQWF4XnR3vuCepxRTYT0ASHH9JSsOllqdxusrDmjra+bh+rLTFnab2R4PDdG
 tC3KsCdqjMpn/hzNVRoryYE9zWNUHyjccoDlTHr8Daz4bPpw6sGg/6+8oU1Wvle2fE4A
 Gy+WosnDgUEg80vg0yndZtMBWwujWGm1RnEh5q277fTdCSjv0DQCYxExN4AElHMll8Ie
 lnaRT6ihv/SzqfvsfPFzZ7kd0rvMErNw0WZvk2DCtKFzGJZtsNiTfbFLUgyLSteD0epI
 y4SQ==
X-Gm-Message-State: AOJu0YwUyzOsgc2Gm3ra5q1Wc2YWGWw16fZudtUewUtlNNzwnd0jqQML
 v3Xy4XfULhyAIbI9A9m04mf3t0kelmT4DVINWhI7IaEiLf11i9nDmCWdGA4YGj8ESl9ROgCvnE+
 5lzI=
X-Google-Smtp-Source: AGHT+IE+xHa7kQnqq1Om/ev9bei9yd42iNTXE05XQE5+/XSy4VgiJ1mobaXzJ15pjj5wNjGJriSyZQ==
X-Received: by 2002:a05:6214:2d48:b0:6cb:10ee:de7b with SMTP id
 6a1803df08f44-6cb81a81670mr81526306d6.34.1727923955142; 
 Wed, 02 Oct 2024 19:52:35 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb938211f0sm1606826d6.142.2024.10.02.19.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 19:52:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Vaishnav Achath <vaishnav.a@ti.com>
Cc: u-boot@lists.denx.de, bb@ti.com, hnagalla@ti.com, n-francis@ti.com, 
 vishalm@ti.com, j-choudhary@ti.com, u-kumar1@ti.com
In-Reply-To: <20240915204714.1051646-1-vaishnav.a@ti.com>
References: <20240915204714.1051646-1-vaishnav.a@ti.com>
Subject: Re: [PATCH] board: ti: j722s: Update Resource Management configs
Message-Id: <172792395338.1516896.7466890727573229715.b4-ty@konsulko.com>
Date: Wed, 02 Oct 2024 20:52:33 -0600
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

On Mon, 16 Sep 2024 02:17:14 +0530, Vaishnav Achath wrote:

> Update J722S Resource Management configs to the latest output
> generated by K3 Resource Partitioning tool. Main change includes
> allocating more BCDMA channels to A53 for CSI2RX to support
> 4 x CSIRX capture instance simultaneously.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


