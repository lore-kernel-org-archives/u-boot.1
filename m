Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72413C83F17
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 21:11:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70C9B83043;
	Mon, 14 Jul 2025 23:10:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OPlhBTxC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A36D82F6F; Mon, 14 Jul 2025 23:10:53 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95DA582E52
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 23:10:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-73c89db3dfcso922127a34.3
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 14:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752527449; x=1753132249; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gq6Nd1MhtovZtvwDwt9NXp8dhJ37fBXHy/HjoYWqY9Y=;
 b=OPlhBTxCTKoS7kEsVy1j9/TQllHEcqb94gQZDwncu3q6kntXZFG5lU/X+b7frLPVNQ
 ulTvRSrmVF2dk1nmv9jqcYxIYzUOlrxL59qB8MPr832fEV4GpX47wTnkyQAihKaIpIJ9
 +RODO6w2CnD6wip+1inWasdnl9Z2ZbvEKvnhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752527449; x=1753132249;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gq6Nd1MhtovZtvwDwt9NXp8dhJ37fBXHy/HjoYWqY9Y=;
 b=r2/SrHL40g2qkW+P0J161DqwX6nUb8dbI28nf0lUZM5jM0ASO580CYNz8p2AjBLbqJ
 s5M1HkmJJ3A/ifHN32pAfIsZXglL2mBrxn4+QKe8riYspJxExMik68Iy6C8keLo1HEen
 j09FIH3MLuwZQsGi47QtfB3LPJj6JckFqRUktyyDrSBq6czwkkXL5A8rbzGLkcv9cda7
 DwVmUZD8r4hp2/sKdlRObMbvv7waempjdjqdIshJ7JTtXBRNZkAF0gKtERCaNyW2FPPo
 AAsaCtMOTPaGlx1b+ESj1cSJK4zJ0ia1dqvZ3MTYA7aL13b2MMj/+tBAVl+d7dE3vzkw
 rFIQ==
X-Gm-Message-State: AOJu0YzefhB7bz/edZmX/Cs1e1jjsSzF3/Kmta5xy8B2Tg7iD2rzP754
 isbF6Y3IanRjoJBazjowNlrNWghNpr57cRdWDTt1DBw/xaDahAfYrIOGgqZ2L/v0AdQ9ISo8NqH
 TGYue8R4=
X-Gm-Gg: ASbGncvoTKjSOYha9dRG4XaoE/uzHIdnXtjQbGl/oIP6Br7i8lGMqUVu6xYDh4/Fvqg
 pYgOJTBlBeYXXuZsZ0t51Wj6XihnS2GNUrg3Jn0qWukTY2/YTB6e/vIMwJes6UTOyimfLDI/emP
 OpAAfZVdl3Ib80on0/dQbqUW0yAMP2lYQJe1MCYWfgg4PggRk6eLymSLh8rZfDg1C2bAn5aP8eO
 2/7kbj1olXqJYGGxkQTIh8nfIp9LNeArmUJqtLtYIQrzAxUyQ5aI+TaAUJU7w35Hg8Wv8ErRtgW
 9Td/JSb/Tw8hJnjnTipobCricIlSN4JjIYvL9JiVv6ncRs7Ew7dxRsLqGxpBiNuA/wGOpO2Tmj3
 iMxG/97CeU2W97ojq3ZbDHSE9umIIxxotchCktuFW8XIjPKQOQ1I6CrvqGYwBAWDgHw==
X-Google-Smtp-Source: AGHT+IFgaBW/Li8KpKm6i6A+iwksptjuHhqomO0zLiH02QAQckXxcuADinvwhDWWg67IkzajTOaSKA==
X-Received: by 2002:a05:6830:3e9a:b0:72b:9724:6a82 with SMTP id
 46e09a7af769-73cf9f0d8dcmr6123444a34.17.1752527449229; 
 Mon, 14 Jul 2025 14:10:49 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e541c3a6fsm202668a34.57.2025.07.14.14.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 14:10:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Philip Molloy <philip@philipmolloy.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 Philip Molloy <philip.molloy@analog.com>
In-Reply-To: <20250707150438.3016690-1-philip@philipmolloy.com>
References: <20250707150438.3016690-1-philip@philipmolloy.com>
Subject: Re: (subset) [PATCH 0/4] Minor fixes to comments, README, and
 Kconfig description
Message-Id: <175252744816.202878.3383780359482514055.b4-ty@konsulko.com>
Date: Mon, 14 Jul 2025 15:10:48 -0600
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

On Mon, 07 Jul 2025 13:06:00 +0000, Philip Molloy wrote:

> From: Philip Molloy <philip.molloy@analog.com>
> 
> A hodge-podge of minor fixes I came across while debugging.
> 
> https://github.com/analogdevicesinc/u-boot/tree/staging/philip/minor-mainline-cleanup
> 
> Philip Molloy (4):
>   pinctrl-uclass: update comment to reflect code
>   serial-uclass: fix typo in comment
>   gpio: add SPL to Kconfig option description
>   README: remove obsolete note
> 
> [...]

Applied to u-boot/master, thanks!

[1/4] pinctrl-uclass: update comment to reflect code
      commit: b476530a8412fa45e8bfe0cd10c2b5f5f197e9ca
[3/4] gpio: add SPL to Kconfig option description
      commit: b4c65b337aab7446b03dab6f22b289c88e4c0053
[4/4] README: remove obsolete note
      commit: ebfbc77109a1fee5db71f767dd1f58d7c68bb442
-- 
Tom


