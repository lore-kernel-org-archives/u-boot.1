Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D0AE784AC
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 14:15:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C363870AD;
	Mon,  2 Oct 2023 16:15:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZSU2jweV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6081E86E14; Mon,  2 Oct 2023 16:15:14 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7122086DF5
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 16:15:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-59f4db9e11eso163299177b3.0
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 07:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696256110; x=1696860910; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TIMqewLpL2QWRR9Cp0X0P7+q4OZ2SrYIj1KumP1qbO4=;
 b=ZSU2jweVbS+9VLrDNJuEzI6pnHlDM/0FxjhpoVgTwDIkG24g0LSFND+4UvbIwsvmLe
 HweG3JKH2AtZHJovTEtNe0nV1oOik+fNjakixUzw1zC2yWSoHW8dyUEkxlS0OppcA9gQ
 PwWZ8CfdMMilKD9WqQoiqS/0WsXRqAuHSEb1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696256110; x=1696860910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TIMqewLpL2QWRR9Cp0X0P7+q4OZ2SrYIj1KumP1qbO4=;
 b=MDLNnHNxTUULbQFu7KDfY6QI87NjvSn8pyIi8o2NTub1x9QDqGZkKk0NVIatIvEMNg
 S7BXsrPlEjSoWPETvjMkeIrgXnDmX5GTyPujqVn6DvfKGCqdFPBOq6iZd80ripGFTGg7
 rk//fIVaEk1YyiD53uEZHR2QfVxYAwb4+t5I3/G6h4fO2HY6vprSYZi7QA3m99rM/2Qb
 hs6kQbIFESETmdfBJkWsmfVM1Qp/MwjYl7MoFvpLSCGQlov/6Pj+7lEFy86W4Ug4o8sT
 kNDY60XIWcEhF44k0ELX9BhpVeoXQzSTON+f3z5vHzIxfxP2P8fUKhmQsEnklKG19BSj
 d9jA==
X-Gm-Message-State: AOJu0YxYeNfIwOJiK1w6vz8kRDfl1Q71p9t9tpov01+mEWgf3tEpD0uI
 iulrcksKRjXh4SFHOx1T+MR7DNMO7rCNdF27wWnb6w==
X-Google-Smtp-Source: AGHT+IHz5LtJ5nupfhUONhgJvTCu7a+D85+dZq5DXu5iD4K33jnJ4f6zzMyGfReFza+X/ZEkMFj9xw==
X-Received: by 2002:a81:5f03:0:b0:59b:f18b:efa0 with SMTP id
 t3-20020a815f03000000b0059bf18befa0mr12625818ywb.36.1696256109947; 
 Mon, 02 Oct 2023 07:15:09 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-92a5-a961-a832-88f6.res6.spectrum.com.
 [2603:6081:7b00:6400:92a5:a961:a832:88f6])
 by smtp.gmail.com with ESMTPSA id
 r63-20020a81b342000000b0059f7ca6beb4sm5958292ywh.55.2023.10.02.07.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 07:15:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de,
	Bhupesh Sharma <bhupesh.linux@gmail.com>
Cc: sjg@chromium.org,
	marex@denx.de,
	n-francis@ti.com
Subject: Re: [PATCH] MAINTAINERS: ufs: Change Bhupesh's email address
Date: Mon,  2 Oct 2023 10:15:08 -0400
Message-Id: <169625609072.3543335.17943862289371460560.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915181442.3403172-1-bhupesh.linux@gmail.com>
References: <20230915181442.3403172-1-bhupesh.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Fri, 15 Sep 2023 23:44:41 +0530, Bhupesh Sharma wrote:

> Set my current personal email in the MAINTAINERS file.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom

