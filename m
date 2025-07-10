Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89443C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 22:44:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16BFE83839;
	Fri, 11 Jul 2025 00:42:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tdutwWVm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F3888362C; Fri, 11 Jul 2025 00:42:13 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C486837B0
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 00:42:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-73cdff9a27aso355614a34.0
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 15:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752187327; x=1752792127; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a+0wBTO7ts42UAkuvrkxArclhujqLGpV4TreBTM+LQk=;
 b=tdutwWVmZJSYyyh7XF10KnIOo4i3CMBP6s6rX9FI6T/GGbNhQmPkPYV61VAiPl/x6X
 M4rCTjw9FdFRFF0/KckrxYc3QrxDyshaA1ctoGmLd7AIBJTGGZpQVMS8ETSiB0RF7DeC
 EXilJkQManQxaRO4mc4GSCZHx+DIvL59NYMaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752187327; x=1752792127;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a+0wBTO7ts42UAkuvrkxArclhujqLGpV4TreBTM+LQk=;
 b=Lnr6K8gUz90zv9Q9OeD6sjgCwWOkqu15W6LBy0F3d0BvrXFibKLgyLrDJllCIb7OSo
 turjv3jVuTk/W6mrKbxs+tIrIMFJFa5aPcEkit4Oa7HDn1AG+jcE4DaE6UWl2s1dSluV
 EL54UgofqCNmFSeVYyMdA4qKZN1WcGIXkrV7YSrN9FAw3oZTOGOp9h5zIbuZLzIJRpI0
 2pzGOmPrNdK9yUBTsr6OTV6BkGBx4EqICLl/zSIfAZNstiDnnBOmWp0WlPM6G3JdDVGp
 TLt6zas9+PfnxIiEodskBCsHLQRnxhjPdFY4rN0ni2+4xu6ywGM5DicqWSGYe0y63kXl
 EydQ==
X-Gm-Message-State: AOJu0YyZfPaECxgtIe8N/8OmVQhVq7aNE5v6ohJTmd35+u+ThJXzXGZo
 xWbEpI7OT1Q03dewdz78Qg9xoVOuOwqkR967A3x6TXYnVVctwoUyA1dhRODGXCo1q18fRBX2nEJ
 EIM5SaBQ=
X-Gm-Gg: ASbGncvIu5IyBmDzj7sbBIMxAWzCkMGuU/Y3Eh5xy1nh9zbaoTN8XDejc/s/hCmmEF3
 NiIAokuM8qwsRwAsH5Eeq7jsLItv6BtSz4ZujRUIIcS0MLGXaq7wzKm/w2MATvNF4AaHBF05rpH
 B2FljPLmBGbDFVUsMLOmPL1l4ithC7lA0654kJZppet80QLW+CsdPhab69fcEwsjGLg95rN2HyN
 pAH5cFCrL7p+OTm/eiQBwyt2g+cLL1CgBEhR3EF6wEim82dKb7/Y5OApIn2/lkPneZL5ClV49xN
 Z0Gv7FOCfC0dP//jdHwiuhkpVgCCMvNqmXwxaJvvuJjkhQY4VAqAu08B/Q/mZHg9jNLezabeL0+
 giTEW0akfT+U5NiK85V82hApMndDJH8Ov20QCwdLHU41aGezvuklpnnQ=
X-Google-Smtp-Source: AGHT+IEuuJxGxdYoO5zumByt828cCC+5cWkbvfo61xSTq9BHsMaGbcjvfyhh3U3sEGF4O29lVKd8Yg==
X-Received: by 2002:a05:6830:3115:b0:73c:ae54:a73c with SMTP id
 46e09a7af769-73cf9dd7e62mr1045143a34.1.1752187327349; 
 Thu, 10 Jul 2025 15:42:07 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf12b745fsm357354a34.64.2025.07.10.15.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 15:42:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250702010557.19333-1-trini@konsulko.com>
References: <20250702010557.19333-1-trini@konsulko.com>
Subject: Re: [PATCH] disk/part_dos.c: Make use of LBAF for printing
 lbaint_t
Message-Id: <175218732658.2073260.15646310322088823384.b4-ty@konsulko.com>
Date: Thu, 10 Jul 2025 16:42:06 -0600
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

On Tue, 01 Jul 2025 19:05:57 -0600, Tom Rini wrote:

> When printing the contents of an lbaint_t variable we need to use LBAF
> to print it in order to get the correct format type depending on 32 or
> 64bit-ness.
> 
> 

Applied to u-boot/master, thanks!

[1/1] disk/part_dos.c: Make use of LBAF for printing lbaint_t
      commit: 9cede1930b40673c2d86d036b98acf01198f06aa
-- 
Tom


