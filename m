Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482AFC282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 22:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 289AD81A02;
	Thu, 13 Mar 2025 23:44:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CYCWo3t8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B691819B1; Thu, 13 Mar 2025 23:44:28 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04C1081B4B
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 23:44:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7be49f6b331so139206985a.1
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 15:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741905865; x=1742510665; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y4jC7tUWkh6X3z+/sjIkHtusc50cONTaCWfAnY/I0pk=;
 b=CYCWo3t8MTXMJ6BUtSgysiTBekeaf2gkCU9JhrUOLCJcBJmLIJEkcvUtumjRUSU3kS
 Q3nLvCrkhuLfFzSuta4kiKXgIXpyp8BiZVZNCyrlgmIgtiEjHRt5iBfAXnfMhRjpKZEX
 KN61cYYeBB0Mr+lEBmwrgQhdjSA7mDHfFRUuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741905865; x=1742510665;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y4jC7tUWkh6X3z+/sjIkHtusc50cONTaCWfAnY/I0pk=;
 b=GpBkn/nFTp2+27AqUOOrUN11eTrdavoQPYXJIuzQXNN86mHI0iQuAAKj9UQU+b1Sm9
 HpdRo4W0So3oDG/tGEcOAinTh4DZejPeiQ/Ul20N6ILmJ/qBEgn2liy211YbYqQq+OjT
 +eiVdOPDTdpWKoXB+5McA5WG5PKo2ZNIkByyk9LhHMsp0Ekv3XYakxdJlaJt4NKv3GOW
 UUF1wGigj3LgGnkHAKrNJ0WNFTugOteCSsDeSX8e5YrmCu5gjWpdnt7U21aNuihOmGHs
 fqDdqbhmwqT/YXMDPGvNm4FYS2u1Creh5FIqcfsPcKIfd8D8SoYkLC6PaNYY9YIVEsZK
 JHiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuuhcbwRVFhJ3cEbL0i9oH9ZIDZXmcEjpEwIQ/uFuHzxrOYGRTPlqW1CV/qaqG8Yb6px4iAN4=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6TaO1ml11eUQ+75lyWZFwhX1qt+KwNGMJDBEzmB6LF0mtQBZR
 s1kv8wTNB1aCOfp5V8C2L35k+w509WHScReXgRQcAUsQj0qB8dwkQSgEdoqVErwhpFwoLCvP2X1
 m
X-Gm-Gg: ASbGncv103tKAUEEA+Sne9vfOVz/fxopWiYndfHSbLmckYI3Eowwmnf+fzU9wbx7vea
 IhjrLgp02XPDn7UaUKiG2OiywHjncsyCxZPUrECTTQYpFKW+1+DF4cnzIlENVqUOCTEppEUvBv3
 owphp5qlLLKUeBAQHBmQcCfnhY6kMLQ+quqZho7B7N6dD+On2Vp+Wcww/5o4awQzHRPLJpnc2Xn
 k+DySSLQCcvVHWtidg+UuUW2+ywTSsNpEP4DRrIxNPrWdRbzI/8IvUHIvG3JZT68seIBbcGOdod
 u5cE1BIr6QWJYudgozVLqDMm4mR/xL+bZ4+xEVWDOlvk
X-Google-Smtp-Source: AGHT+IEjw4xSIbP46FqriQnYWqlBU61SXjSUc9BCxa/ruHxD2hOK385mtlXu2iEMl0Z1UtYmKtkTbg==
X-Received: by 2002:a05:620a:2603:b0:7c5:4de8:bf71 with SMTP id
 af79cd13be357-7c57c8f03d1mr14193285a.50.1741905864987; 
 Thu, 13 Mar 2025 15:44:24 -0700 (PDT)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c98225sm154508585a.49.2025.03.13.15.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 15:44:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>, u-boot@lists.denx.de
In-Reply-To: <20250305084130.2677310-1-vigneshr@ti.com>
References: <20250305084130.2677310-1-vigneshr@ti.com>
Subject: Re: [PATCH] memory: ti-gpmc: Alloc per driver private struct
Message-Id: <174190586344.2150240.15212788059087971663.b4-ty@konsulko.com>
Date: Thu, 13 Mar 2025 16:44:23 -0600
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

On Wed, 05 Mar 2025 14:11:30 +0530, Vignesh Raghavendra wrote:

> Driver uses dev_get_priv() but never allocates it in its
> declaration leading to various crashes. Fix this by explicitly
> allocating the storage.
> 
> 

Applied to u-boot/next, thanks!

[1/1] memory: ti-gpmc: Alloc per driver private struct
      commit: 628908f849e1a8c99c47aad0df0e4feb7a6b2c9d
-- 
Tom


