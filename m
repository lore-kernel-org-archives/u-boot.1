Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFBBC369A2
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 17:34:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F00783DCA;
	Thu, 10 Apr 2025 19:33:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WLs0O3vG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8841B83DB3; Thu, 10 Apr 2025 19:33:56 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BF4783D84
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 19:33:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3feaedb531dso238540b6e.3
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744306433; x=1744911233; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8EuUX/z1HdySLHF99h+5EOMvSd4RXNw0zS+BZ2qKCfI=;
 b=WLs0O3vGm0fOSJQOIu1Tkk0VWckd93f/ZlCZGFH/f5fdvoUYNo91o8/7Sb4wFDG4zJ
 bPBz1wigkQMqj4Be+iONo8MYJO+stvKrdIfroBjKNTdCr1jTy0+ufPQ/pvBs/4QLATgz
 tGiQaabpPLAl9WJHqRxyaNlhKR8FjH+nAdo4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744306433; x=1744911233;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8EuUX/z1HdySLHF99h+5EOMvSd4RXNw0zS+BZ2qKCfI=;
 b=Psw2wtEQqlbfYF+xOjGFxrbvwR6YjQPAaR2gaHeFoMAqTb6PpsIFF7oEhqex2i6bz5
 ixnE3BgasiGy+GH85VC1RwuZovq38FIEpD03/mIx6RhkeNdiZJ2fpcjV+aJwgZbyuTbW
 Dav/ilrZYMR+Q7g7y86rSKHDdtKMiAGa9gDYui9Yg50xxo3j95yLLbdoTYR29IhQoZEs
 ONCYe0GKttPzEnAlWKFvFY6D0/aGUZc5OBeAxZ0zpjYnT76Rc1Gk6PoiCjkGhclaJMxj
 BxscJfiQqa46oZejTUU9ZxYwTnKVxr11N1uG/OoupSTjfAUi8cP1H/vqPUrot0sW5/Qc
 zCNA==
X-Gm-Message-State: AOJu0YxispfeYxW5xTtOgPCdG0O/CSPFGM2c96Zp0ov3rgEd+tB8Mabz
 7bwLo/CeZKN6ego1QKROpi3gXsG8K2kiSz8V0c+CAb3efHrfbOxJIQnr7KckAbs7Nmcs6PglX4o
 fWdM=
X-Gm-Gg: ASbGncuNCHBpBoFGVnPlqcd0PFywM3dsEpkQXCinf9Ygc70VpZoFtLbSHAJvGvtR5uC
 kzY6r1XEDWk9pduobUdLi5NLhnaPwfrGJHiD5TsTVLVvBm8GTa8xGzP4/KS5yUhL7Gh6Pqdvx5j
 F408VqZka5Zyy77YISTn/Rn3O14ogNVO6kzlalZPPRgq47WWHgSlSs+Bxvbb6UcibReGTYvKPvb
 5fg+UvSF405M/nwADsMWBcMh+exKhi65uzfeOzUcZLvleXq9iYz+BHlcVhuxlgi338ihUul8yjb
 LT62cBmymfltlsS/wpz7U5y7in4uUEVOcR6VCNK0UwQQNTRpfGmctMFvWuFu1mGLeAQOPKc5Tcm
 P
X-Google-Smtp-Source: AGHT+IHLa87hQDdorC4PO0fP3PP286gpouywEVpuUNxfYTdhu2TZ068Ze7HHypi4/QKgxuL9fgXtxg==
X-Received: by 2002:a05:6808:4446:b0:3fb:2937:937c with SMTP id
 5614622812f47-4007bca0d4cmr2091729b6e.6.1744306433094; 
 Thu, 10 Apr 2025 10:33:53 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40082515ebesm75008b6e.11.2025.04.10.10.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 10:33:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250128230205.2062703-1-trini@konsulko.com>
References: <20250128230205.2062703-1-trini@konsulko.com>
Subject: Re: [PATCH] Dockerfile: Update to gcc-14.2.0 and clang-18
Message-Id: <174430643229.2959201.14271785518368577655.b4-ty@konsulko.com>
Date: Thu, 10 Apr 2025 11:33:52 -0600
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

On Tue, 28 Jan 2025 17:02:05 -0600, Tom Rini wrote:

> Outside of changing versions here the other visible change is that we
> tell grub that riscv64 does not have "large model" support. Without this
> change the resulting mkimage is non-functional. This is known upstream
> already.
> 
> 

Applied to u-boot/master, thanks!

[1/1] Dockerfile: Update to gcc-14.2.0 and clang-18
      commit: 001bac5f16adfc131ade7de73ee681972a89df1a
-- 
Tom


