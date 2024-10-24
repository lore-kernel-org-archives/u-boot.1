Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAF6D10374
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 20:43:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F92688FEE;
	Thu, 24 Oct 2024 22:42:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="miHiiVHX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97BFD88FC0; Thu, 24 Oct 2024 22:42:55 +0200 (CEST)
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com
 [IPv6:2607:f8b0:4864:20::a30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9105B88D61
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 22:42:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-50d32d82bd8so341758e0c.1
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 13:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729802572; x=1730407372; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ttRr6rS/17/IhO9OKMR/HANDL1BOsSYRvKwdSch6ngY=;
 b=miHiiVHXb0oDs4DiUsDjuE57llPF0C2RC7zSg2pvxJOQuAOb606Y++Pk/u+V4r06D5
 igSI1OsRBd0O6yyDu6kbpX9M0ChGBnLW7EebBpS7IyegPJ4KRBUVJc2w7p4fBp/iQOfm
 D/Xd7BUVvZWcgCsKVCR39QEmkGlrbIKmYXHZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729802572; x=1730407372;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ttRr6rS/17/IhO9OKMR/HANDL1BOsSYRvKwdSch6ngY=;
 b=tsAHG6y9iJNaNI//0G96QjsIT9PN8I57G7WUV4w/02E9P0OYkl3QoYfhxVvkjtduDk
 Apd/wG5EoRk9yXTaUDM0d/RFmc8BGrXK0yCAD6BUc//TV4F5QMlj1DyKfXhXw/acqHB0
 ej/zbniBxHhF/dyF52FdxJEFWdNnxh3fnP0BP5d3fH/9nUI6tGv78u6KZsnsmKPV9gWS
 mXufRIxTqRQDm0g30agTEm6/q4Iufd55mXknb04BFM71n39LN/d04LO3/44AWwt2jfbv
 NHe7yG9jUkChWYEkfLvBxRgchxRZEhyRuf+nAI5vxZKsBgqq17oDQFfA8hhz2I2sZHt/
 t6ng==
X-Gm-Message-State: AOJu0YxlRzVRoStg8Lzq9sZ2WEmAUCtGPgWaquXP79SSAut1z3hFs41U
 LwwO1P84o7MWentMO2k54kUbFSgBcKQKfpJHjcFT/JeLLzIcaH0v1cxc35erM4XC/EGjphyhGqA
 t0/i8Bg==
X-Google-Smtp-Source: AGHT+IGHuIvnYF85XQ8fYeKxZAlHUdb75jzpZj4WnDOF/Md1HP7aABOjGqbHNRQ/s0v/Opp4w+u3Kg==
X-Received: by 2002:a05:6122:1d42:b0:50d:3ec1:154b with SMTP id
 71dfb90a1353d-50fd01bdbfemr8873148e0c.3.1729802572389; 
 Thu, 24 Oct 2024 13:42:52 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1659c0361sm521428985a.19.2024.10.24.13.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 13:42:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Philip Balister <philip@balister.org>
In-Reply-To: <20241018211957.163051-1-philip@balister.org>
References: <20241018211957.163051-1-philip@balister.org>
Subject: Re: [PATCH] mcp230xx_gpio.c: Add a missing include file.
Message-Id: <172980257169.160410.8955033737421883903.b4-ty@konsulko.com>
Date: Thu, 24 Oct 2024 14:42:51 -0600
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

On Fri, 18 Oct 2024 17:19:57 -0400, Philip Balister wrote:

>  * Fixes a warning about implicit declaration of udelay.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


