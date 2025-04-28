Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1E1C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 21:34:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3450E82935;
	Mon, 28 Apr 2025 23:34:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q5a02mG5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7095882918; Mon, 28 Apr 2025 23:34:07 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4814D8210E
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 23:34:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7302a769534so3692014a34.1
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 14:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745876044; x=1746480844; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+k5Ntoxb3dEKPLwyDJNFPbSfrYin1dI1bZgWHKwxrXU=;
 b=q5a02mG51UGp/HvY3Su96Ch+ZTuqp5U4YRDFZYKW8M9b21ZPNV6Imr9BI/r9y8thF2
 cSgNYNAMvcEG7ZUw0YZM1mamNTmTyBmLWbmTDCqbOnnG4I1hSHgRyJTgvB0bTYzaWnG4
 eFPaO+EJHVWvsgrlqpIihL79fTaFXwnS0EZHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745876044; x=1746480844;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+k5Ntoxb3dEKPLwyDJNFPbSfrYin1dI1bZgWHKwxrXU=;
 b=pWsLiewutAosOJikTdDIYSuv16snfb2Lksv12aScGTe6N1pWdP6aFDTYx1vUGttuUD
 Qswdt3RyJWNYPPc9Ai5Hx+UD2KQvrfY1TBBMt3bpprYTnOoYx0MybK3xWlDiKAVXCYgE
 TOfmK2H1kMcRLpOwlVkaz3hJ8jSNFKvsR1drr+jbDF2USTt90gfndasF3Y6q6GGYHDFq
 bG04qvdLillw3EoH52aS6KvPMn9snvEOEqAYHguIvpfedygnb7grXY6Ort91+f0rTope
 2V72akuK09I/0fdWRYOf3eUsX0XA7RVFjO9xaGAJ47qtZM7rCO83NY3jznkLWJbzJsEx
 Fw9w==
X-Gm-Message-State: AOJu0Yw1E8JT+NRAuAJAYfo0+Bd36t+AY4wskmC2gK6kPot3sPzEI9gi
 XrJ4bcMDpzHc3QQGfVejjWRhvYl+7JszDazPCn3j6m/Z+Lg4jCZXdHMC5ONgrcs=
X-Gm-Gg: ASbGncu2NVVkQUbSzaKWDVFsTDCxWNMlFzIIlPmaLduB/tTrYv9kXeDWCrw1sKFs5B/
 RFoKj0LnMR8qGdF3FhhYhyGcen5gZR7ddgUA5ho0Jljc8OmjotyD5bUAGe5EMOKlfvHY5nVtGrY
 GpdXTw9w9NqoeX+kZDqCGn/fMgStayStgSLRLFb3GjgaWYBLXdvZ1N90lCKKezIqyYcpOI59O6N
 vvFDWT6j3Ug6Ddxt3XnhouFIB37UphxJ8UO1vxU+mnnS250Bxh0DS+w3+fIbuSmPIUb20iedByQ
 NDDWlcOVUPkDstyRqUywpA6PR9sfkQAfKGszXOUM5MxEJAnEqdSxhqvAuuC5vtWzWetjGfRxAev
 U
X-Google-Smtp-Source: AGHT+IHnnHiq31oX7fd5H2PGx3uBF8D+PrSRjrmz9L8+mWYU/xXqENVPfH74whSx67qcb3n8uoBang==
X-Received: by 2002:a05:6830:610a:b0:72b:9506:8db1 with SMTP id
 46e09a7af769-7308a4f1c69mr239808a34.4.1745876044084; 
 Mon, 28 Apr 2025 14:34:04 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b139000sm3108a34.40.2025.04.28.14.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 14:34:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Weijie Gao <weijie.gao@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Francesco Dolcini <francesco@dolcini.it>
In-Reply-To: <20250425034303.77100-1-weijie.gao@mediatek.com>
References: <20250425034303.77100-1-weijie.gao@mediatek.com>
Subject: Re: [PATCH] mtd: mtdparts: calculate mtd partition offset before
 calculating size
Message-Id: <174587604322.1121500.2177050763610787165.b4-ty@konsulko.com>
Date: Mon, 28 Apr 2025 15:34:03 -0600
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

On Fri, 25 Apr 2025 11:43:03 +0800, Weijie Gao wrote:

> The mtd partition offset must be calculated first as it will be
> referenced when calculating the mtd partition size.
> 
> 

Applied to u-boot/master, thanks!

[1/1] mtd: mtdparts: calculate mtd partition offset before calculating size
      commit: 65a0d47f5a1e19b1766e3c206b8126951c813afe
-- 
Tom


