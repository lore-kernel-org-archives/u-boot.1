Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDF4CD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 17:44:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66BEC88199;
	Wed, 10 Apr 2024 19:43:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m1zXAdHP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B48B0881DA; Wed, 10 Apr 2024 19:43:28 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D15D881BF
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 19:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-78d57b9f3caso318972185a.3
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 10:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712771005; x=1713375805; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pWtGtJM9SKbJCyWrXH2wjpqlCT30+eUSLxG3btQRe8k=;
 b=m1zXAdHPcItx8UcM7PRP2DQFeQWewXGKL9HMr6dda59e3GBMz6IhQgaCUxBo0vRs+h
 6ykiJchRWJ/6ligHIIrGWjCWNIhrrUPA7ASfTACLG6jrnsfhvF2rwzlkA86CxzJoHMbu
 RFgYZg6Xv/vPu4d8hkg3GOSs21fSHtqiTyxRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712771005; x=1713375805;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pWtGtJM9SKbJCyWrXH2wjpqlCT30+eUSLxG3btQRe8k=;
 b=F47yYA6dJdudRoqAmtOsRuNbotS8hB52lxhkyHmFVfWF3CH8u29gVXFnNtS63hZ1Jc
 hNCpTW5yrV813CTehIISuwiY3sqnkBCgaQo8JhMzMrMDk8WD2w7YFmo3Ckam/HdElgCu
 BGBTBrABpyE/FOmyGF4B6EENcMGrnR4kKbcVxaM/S+1V5CR2ibcusc8UDFSYasS05eKC
 RwTH7beY/aL1usyfb3ZpUT2s0MsvRHJetXp1ufUFsUzOUXEICdQ3NnoD5kPnvYT82uFr
 17Gcc0vRpwZ+E1fR0kiuHjU5XqDLu0vp3ABwSl/CVWCqKR+uYn4LIo4TxgDIQT2JVAE8
 VCUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWf8RZvHGvzh2cmdRe8ZDy19uqhb30CfpkrJ/wC4Q5c9wPgkN3GHd1WgOD2CrjvQzacfgOTsH4FDIGWH3UOfnjceGlBOw==
X-Gm-Message-State: AOJu0YwpQQ+IxXRPRcXf0oZTPYnTQCSkp3KYE8pLwPG33P6lykNQkkxb
 vflZjORoyit3AgRaN+kP61zgUigfko84Cm3tSUIFCpZb8QEPgd0tQNSFyAitWBy/4T593rssqFv
 heKxHTw==
X-Google-Smtp-Source: AGHT+IEi4jswTP395731FCH3jcNnm59PEWE6rdbURLifC6Y4/o22/luY3ZU7npMYFyiFKQFmIToIQQ==
X-Received: by 2002:a05:620a:2225:b0:78d:5714:6698 with SMTP id
 n5-20020a05620a222500b0078d57146698mr3000020qkh.4.1712771004787; 
 Wed, 10 Apr 2024 10:43:24 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 vq3-20020a05620a558300b0078d6b676b9csm2308177qkn.17.2024.04.10.10.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 10:43:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Cc: Guillaume GARDET <guillaume.gardet@free.fr>, u-boot@lists.denx.de
In-Reply-To: <20240326093431.23962-1-sebastien.szymanski@armadeus.com>
References: <20240326093431.23962-1-sebastien.szymanski@armadeus.com>
Subject: Re: [PATCH 1/1] net: nfs: fix file handle length in NFSv3
Message-Id: <171277100370.98421.10855200047796374843.b4-ty@konsulko.com>
Date: Wed, 10 Apr 2024 11:43:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Tue, 26 Mar 2024 10:34:31 +0100, Sébastien Szymanski wrote:

> The NFS protocol uses file handles to refer to file or directory.
> In NFSv2 file handles have a fixed size of 32 bytes.
> In NFSv3 file handles have a variable length up to 64 bytes. This is
> also true for the MOUNT protocol. [1]
> When the NFSv3 server replies with a file handle length > 32 bytes, U-Boot
> only copies 32 bytes of that file handle and the next LOOKUP Call fails:
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


