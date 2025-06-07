Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6E3C61CE7
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 14:09:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FF4582ADA;
	Sat,  7 Jun 2025 16:09:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="INWXsfhG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C22882B0F; Sat,  7 Jun 2025 16:09:14 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9E5681F0D
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 16:09:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2cc89c59cc0so2360016fac.0
 for <u-boot@lists.denx.de>; Sat, 07 Jun 2025 07:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749305350; x=1749910150; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4nijXCavLlJzZSzt14woGLgz+d5j91VzH04B88C9gbI=;
 b=INWXsfhGW/rOQIFw+17x3iOAKmH0/O0hS8nJTSnak8tZ84CgM9k7iWV+1rfbOVxaFj
 L3udBW4U3Zcd61r1VbyVyw5ruZAyeuiKNtlfPaejasRdMzyct4pVsOOV386Ss2nwAvsP
 n4wWc/g9Y4yqHtIPhWq3eM738Bqh6uCVNELZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749305350; x=1749910150;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4nijXCavLlJzZSzt14woGLgz+d5j91VzH04B88C9gbI=;
 b=O2RQz/hwbXIaQ2/VHU/v7gDh0Hp3yJR5ilmzlkG376O0zxdEN2EvM+vpE3Omqazo70
 XG6xhRDYmR7It9dFGGFcolTjZ/cyvOFI/0ngWUv6BwX5ZgPHgmj+oEpYFEtr/6/bITfO
 6OlJvU2ukBGXMMmgKQIavyZNt01zyOsq6oPe+ZvLDwxWUPrsbvZBMCvs3zrT6GkuLo4q
 id3Jk5/0zqWvxjtBNbtNLZo7q0rXaxCGDNG9Y9e7kRX/wWswmNceT5oIWso/e+flB7/P
 JgN+gw8X2Ln+8EIxUfRgTMRCaDNAQZwN5LDUIP6NhcasJuX4bhQjK32U2M3ioUw8CrG3
 +aJg==
X-Gm-Message-State: AOJu0YxKjjUizLhsldi73xlj22Ic7uoVDKY8cYIJAhWrXzKsljw5terS
 5CfnSBEXAN7XgM9xhRDZ39p0pym2NLVVw5ZnMSdTPu4bIKiAjp4bFWWKNNYWkR46kcX3jA4xKVS
 BmlK4VuY=
X-Gm-Gg: ASbGncv+pblCDT7loCA1Mh+g6bdsd86yvlKAUBWCZ0f5JSzKgR3ZYJam/CJ8p1HSpnU
 TufOwPIJxTjhZAzjsOLXoRiymHJ/qnBFB8a+Pu9AWGeWrvDeZxzcY70BlO50pCTgFXeAK9drHpr
 iAdJmmICoHNmV49h5JOGep+t3hoobhFjhYP50Xs3PV+VYSJo3l2/fG666Ul5FT/61TC0wi4EZzp
 W2aFIVjBQw3N3lcI/WWwqDFtCGn5NIBxn5lGq/BhpNXTXlX0RXiK46CCrs0mI6A6MdQ29K3NO9X
 F0m1KVr3EoNDveAkxO6c9gN0yW6MDVNWCoc2qezFNBGhwaSqMHOhefNFGsrf2JmdmdLLR6b/rZm
 vxVswb59MY7AnRitMmSP3RA==
X-Google-Smtp-Source: AGHT+IET/U+TZlAHzIFVi5MGzgJmIq6UPE4K8lkTHKxI9lsOSKGZUXMJdEPmLZeX0j/Rye+zZCYMcw==
X-Received: by 2002:a05:6870:d1c8:b0:2c1:f878:410d with SMTP id
 586e51a60fabf-2ea04433cb5mr4352466fac.14.1749305350498; 
 Sat, 07 Jun 2025 07:09:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ea073407b1sm954067fac.38.2025.06.07.07.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Jun 2025 07:09:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250527235040.2996531-1-trini@konsulko.com>
References: <20250527235040.2996531-1-trini@konsulko.com>
Subject: Re: [PATCH 1/2] include/dt-bindings: Remove functionally identical
 headers
Message-Id: <174930534910.3446816.9541003321919659930.b4-ty@konsulko.com>
Date: Sat, 07 Jun 2025 08:09:09 -0600
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

On Tue, 27 May 2025 17:50:37 -0600, Tom Rini wrote:

> As part of moving to using OF_UPSTREAM and so the upstream dt-bindings
> headers we have a number of these headers that are in our include
> directory and differ only in combinations of spacing changes and/or
> switching to SPDX license tags. We can safely remove the copies under
> include/dt-bindings now to prevent future conflicts.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] include/dt-bindings: Remove functionally identical headers
      commit: 9006969b6d402992e89dc2c2810aff08249b2e4a
[2/2] include/dt-bindings: Remove strict subset headers
      commit: d8ff4a06526816fcb463551dd0ed41c7f696b012
-- 
Tom


