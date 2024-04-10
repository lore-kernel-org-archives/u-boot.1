Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022D2CD128A
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 17:44:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E29F0881B7;
	Wed, 10 Apr 2024 19:43:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IvQFRlRW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53687881D0; Wed, 10 Apr 2024 19:43:25 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4592988191
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 19:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-78d555254b7so6690385a.1
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 10:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712771002; x=1713375802; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6O4RmzC48rpe24s8YfqtxatwOkNqa+88VR4Nq6aWyaQ=;
 b=IvQFRlRWOYESG+DJua9uC4jnfDumjTDev3p8Wa+TTugmtvti8f5VZShPuoYwur32ON
 nzzQM3nIwdOJB4iikxuU48znGWwYRHAEPvYaB4mhLni6VPA2u+4kvLCzk6qf+Ytq6MMP
 CBjd3ytopj0EbkXcJ+G9SpCxbJUf7Bbe6sdNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712771002; x=1713375802;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6O4RmzC48rpe24s8YfqtxatwOkNqa+88VR4Nq6aWyaQ=;
 b=fZ5mAjnWGwvr4FwXMotQPl4dzEs75I/f15jyD8kIbmrtHBFyGzyLH9nntoeYzp1nS9
 JChWrWwoDNN4dqJ3nZGV4nRbCsA/bh7VJl0iSGI4jlLgz9DGyAagzx1+eUhB0THkIWVA
 NeatcyLDmx89q+PI/BW7dDHt9Q6nBfRNeDeSHjeCan/Nwz4otAB+xKJSAXyqjcjbX86d
 hgytVIU8KZqTEic5J3nyVrWP2V9IH2W6Slef/ZehQaQut9puP3aqSXVjk+DvZno9a69u
 0YTHASNZroiAva9fGIMdbjso+12QcMkddXB/euhEPrtkSICLujD5tZ8dt0begGMv/ZGU
 1Eyg==
X-Gm-Message-State: AOJu0Yw7KwxOqa2UnQejX+z5DliQYb/ia3Ia7nhbGmoU5ZAMr5DJ4qjb
 nbU5BuvZ5pS5e/IMb97YNPgy2jnv+WuEfJCoYHhw37Cb8mOSJ9zb66Mqp5iFIZtZyQZ9pKSKK/x
 WZ7yfwA==
X-Google-Smtp-Source: AGHT+IH1IzNHtboSbicE3By+Hidg4bOYMNS3IRdNR+hLuZES+Y5Jfq9wJJ40FyjgSndZizDX+zVv+Q==
X-Received: by 2002:a05:620a:2948:b0:78e:be11:c245 with SMTP id
 n8-20020a05620a294800b0078ebe11c245mr582870qkp.6.1712771001751; 
 Wed, 10 Apr 2024 10:43:21 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 vq3-20020a05620a558300b0078d6b676b9csm2308177qkn.17.2024.04.10.10.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 10:43:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240320132352.46102-1-heinrich.schuchardt@canonical.com>
References: <20240320132352.46102-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] fs: ext4: make "File System is consistent\n" a
 debug message
Message-Id: <171277100104.98421.12267930022432340741.b4-ty@konsulko.com>
Date: Wed, 10 Apr 2024 11:43:21 -0600
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

On Wed, 20 Mar 2024 14:23:52 +0100, Heinrich Schuchardt wrote:

> When accessing an ext2 system the message "File System is consistent\n" is
> shown after each write. This is superfluous noise. Only write a debug
> message.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


