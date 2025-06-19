Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889FDC7115A
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 22:27:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C6FD82C55;
	Fri, 20 Jun 2025 00:27:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lKy4lAeQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC18882CF4; Fri, 20 Jun 2025 00:27:04 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF2888003E
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 00:27:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-60657f417c4so621565eaf.0
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 15:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750372020; x=1750976820; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k+iz63xDtgYCF36lkJIfUDBX8GTVg8ezKHAnL/4X8rg=;
 b=lKy4lAeQ9SKbWgI8UbQmdh4YT+e2UdnKXXNzTfFMd1RYPmUlHYqM2EafY/qKP3Q5Hz
 Nuxd1iKDBjXHs4DvaFEkociij0g9Hpic06EZA1RcEuDmf3HhZVQTYUCKI41KuvktRSoc
 wETE/3ATaJrH3+dOPTh0gpVJ4Gl2aE0LoHSxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750372020; x=1750976820;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k+iz63xDtgYCF36lkJIfUDBX8GTVg8ezKHAnL/4X8rg=;
 b=wjdLt8N1Tyt2AHr0ogxQcdYm2d0a6oVqjxVpnaj7UZI7uOP4m7n+ffpayssnaJXBDe
 UZYJ/vZiTaasvnypjxKVAtA26xOQNGQwdg2vvMkVK2RQvwDDasq5D2gqeDpzxbIDDZ1Z
 uPaHtQ2Du9MDt6YkaMDvoKXDlGAvNIYu9ezNXJfiOGkai2yodlfr/n9xeb25nbneTapP
 rGg1xowsl5uj8Zdsr6o/xHUwoW0DOVyRZX6k6VUgk8ZIgmdfpKPnSQPhKK8Nj9mHRm8p
 +aoGLVNFV9nl/extkFEynxeseXU14SyvoqGGzdP0NVuRRqTlhjBpQCmVimD9JtVO6g7U
 8mKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5lKs9sNocNxWAaj8Aoo5n+PktMCLWNflkoRMWluHYzqkbrnFGJwagqnrosKx6rdQ5AVID0Qo=@lists.denx.de
X-Gm-Message-State: AOJu0Ywxljeth/NxZCUyR1Dr65EUOb/hiTI55vdeaTCqFt2MhRO++ygG
 edXPSRojz9pU3oaL1gyD8agonTl3yKXBqd59NpLgHZuCP+iY52I2LSlML0Sr4xHSFn9mHQhtQ4J
 fMsPgxDc=
X-Gm-Gg: ASbGnct1xQeeTgYJh5bqaAa79J02/uSuKFsRO1/+E3ghhyY9TfLi2GyudyBSMA0l7q6
 HJHs00fyv8W2zVjGbLtdi0odFo9RSD+0WmKsmJf+x0Qa7sQ7GMGH1RXIqrKLM0pV6Khy0rbu9nI
 +cgTzNP25GfqK1hZs2cSSy99uHiXPcRD5IhX+a7go8l+cfwG7qJ94kx4LqNf1R40DDdaPyhWLIZ
 iEBvqWPpOsUFMBJTtM0K2M/4ZkXmwZgw3oemZ67rmWLDu02zCNP5W0E3NM3WkkotTKuF60snJGm
 x8mq4DNMQZIEaLscn1osOTi+vdjX9Ygf1P3y4FIZLip+nIFEsu64Dl5CTRvLLxYIc4Ocl5Ddx/g
 Caqgs3W56uz5GVjYGxk8ITw==
X-Google-Smtp-Source: AGHT+IFBJRb4dpORtW6Cgjs8OA6euktSyKXXCTk4Pd7yIQxTTC7ASIMa3gKG6iPGUsJ0XTCcQaAwPQ==
X-Received: by 2002:a05:6820:1b1a:b0:60e:d4e0:7be8 with SMTP id
 006d021491bc7-6115b8ccdf7mr573684eaf.2.1750372020442; 
 Thu, 19 Jun 2025 15:27:00 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6115b68f256sm74804eaf.1.2025.06.19.15.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 15:26:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20250606223923.503086-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250606210805.GE1382132@bill-the-cat>
 <20250606223923.503086-1-mikhail.kshevetskiy@iopsys.eu>
Subject: Re: [PATCH v2] arm/airoha: reset_cpu() does not take any params
Message-Id: <175037201916.2294222.3351130557431174806.b4-ty@konsulko.com>
Date: Thu, 19 Jun 2025 16:26:59 -0600
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

On Sat, 07 Jun 2025 01:39:23 +0300, Mikhail Kshevetskiy wrote:

> According to include/sysreset.h the reset_cpu() function does not take any args
> 
> 

Applied to u-boot/master, thanks!

[1/1] arm/airoha: reset_cpu() does not take any params
      commit: 592b42aeadb74cea3e84a45ad87510d4b35b5bc4
-- 
Tom


