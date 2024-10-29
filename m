Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E553D74948
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 22:30:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB47B89209;
	Tue, 29 Oct 2024 23:28:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tTJfZy/i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55A21891E0; Tue, 29 Oct 2024 23:28:37 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4783B891F8
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 23:28:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b1507c42faso27196985a.0
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 15:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730240913; x=1730845713; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sV2LaiOmH7wQ4GqMWo2AKMTByoIgStIHO/ySkoMdNrw=;
 b=tTJfZy/iIVe6QkIsAcBUmsyQKgsnN0yF6Xx4fhaER8754R28esVu9PhJ/fAwcumnC0
 /5Vcl8xe+MPf4ervagBzNJCB1crzdBEM5QLB/AHqDBI4oRZvrIDKDXBa7xHfBJxRoOpR
 UNlW6G6eG5qosq7UZ5+z6MkPgWg5chKvCumIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730240913; x=1730845713;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sV2LaiOmH7wQ4GqMWo2AKMTByoIgStIHO/ySkoMdNrw=;
 b=BVnYad2rihf7r/4g0rCbl9cGgu5ZGs/2LblFtITVJWf2P/Y1zRMWVWxj0DSFzKwda0
 HK1LAJyCadVJJzUGyKH00MDTg5iGnsAE8P8Nv4O3eDVVWn362RCKpJDz1fEY5EwzBunU
 nmeEqypD4gD/tRi2KGNX4HPwrw6zmKxA8SRgD/zEXr3DLZyJ5ZIdefA4J8G+xuyuorQk
 PhnkpWx2n/VkZnnINxdiPMocC7G8t01+GMSfVdVbJxr2+TuSWoz7tPg1sdSkQiHtZOUH
 YiaVxBNpFMffE8k7qdZ+bH5ERf/M2b6OzZz58rFT8LL0NJNTXU6UYSZ+5qy07pN7pAcs
 CYug==
X-Gm-Message-State: AOJu0YzdRcGzL3aAeqFe/dDS7OFJ0vTehAUFkqSDglfxb1EfpKc7aSI6
 3Uc/2VVQs80SSATf7sJpn15cV8tjMiyiG1IHSN5tAZC87aOKKz159n9pMk+BvCgNfbMQ2Y31byk
 W3fA=
X-Google-Smtp-Source: AGHT+IGnR2vcFAfk9LxFb3piiMECjkAN00aggPzB5Fah2S5ku/InV/hfTb3GbRccP8T1kOr1QnrDiw==
X-Received: by 2002:a05:620a:450f:b0:7b1:3fbc:c092 with SMTP id
 af79cd13be357-7b1a9d12991mr639982185a.32.1730240913251; 
 Tue, 29 Oct 2024 15:28:33 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d3480d7sm459351285a.123.2024.10.29.15.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 15:28:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241028164844.2308549-1-trini@konsulko.com>
References: <20241028164844.2308549-1-trini@konsulko.com>
Subject: Re: (subset) [PATCH 1/3] test/cmd: Make some "ut dm" tests only
 available on sandbox
Message-Id: <173024091235.2563570.4452476860982123808.b4-ty@konsulko.com>
Date: Tue, 29 Oct 2024 16:28:32 -0600
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

On Mon, 28 Oct 2024 10:48:42 -0600, Tom Rini wrote:

> Currently, the "dm" suite in unit tests (ut) is only available on
> sandbox. Make sure that all cmd tests that are part of this suite are
> only available on sandbox and not attempted to be run on hardware (where
> it will fail to be able to be started).
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


