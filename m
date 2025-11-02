Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6631FCCFA02
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 11:19:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3E0D83642;
	Sun,  2 Nov 2025 12:19:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OG1OI3So";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0027838BB; Sun,  2 Nov 2025 12:19:09 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A7D38307F
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 12:19:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ssunkkan@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-27d3540a43fso35185445ad.3
 for <u-boot@lists.denx.de>; Sun, 02 Nov 2025 03:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762082345; x=1762687145; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kLIggXVMNO+G4B5TR6Se+GPOQrineKIukvkA1pgT6w8=;
 b=OG1OI3SoFaygR8ff/4reAvasuAtT6x49lEllrXU5YZEN7Qn5M9cSpyGNhIUNeacNzl
 LjZoZxzP+hHecLwTSrjUdKZTXHKXHG8YTbKgh3O1eXXAgcGDTBm+iXBSmxynFYH60ceb
 HaH9Z3iuDXTtijy4h57FsYZfdJEUS8z2arLX0bEFKV4rLngR9o517hLSOvKlFKj3je/m
 PCpHAEJ67Bu8AKqUlS7MV0YzREOi6jtXykllE94k7D2uV3/icsrCoHtrm5McWHUV39an
 zObUHLOXFP/eglMR6qRpCHLqHZ4dO9qUa1gNhz1zI5WCRcizdjCauYyigA55OPvT7sS7
 jX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762082345; x=1762687145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kLIggXVMNO+G4B5TR6Se+GPOQrineKIukvkA1pgT6w8=;
 b=MOlDXE8GY8CZ+gRTqzlhwjfPWDy7NALrH4RUQFT6cqgV5NRhzn5uvkHWJ6nT4Dn4AE
 ptBzUAWZ8rC8s1r3CQZrq6NNNzfGHb5bVgOmomdzxVHBwFf+fpR/8KH2DYedImeNfBG7
 79E5iyYdh/tCmARzhQob8JGI3MDl91d3kzhgagYgtHINnc5r1wqeU+90qoA9i85HPged
 RG2pCl2vpZYJd1IVJlu6Sd/6X0kFSyelvabnlR2CmUPNXA55IT7NrHVGz5OzpvljlKM2
 Zpr64mymB75OZt0jox4RrPNVuA/WCQ9Z9OeTy4VgjAGbraWt1m3cgbJKb9uIrqYgJi3F
 wh/A==
X-Gm-Message-State: AOJu0Yw+0u8SbjzCcOziIbda5FWjaU2DeS24hwwdAcy7TCOvsHzLV2gt
 Q5tKgHD/nanXMeE7rWvnk/Pw6MGhKbjc4aIHHeur9FBhS7S4ILZSgCMAosqTtHthk8E=
X-Gm-Gg: ASbGncv9xrZ6ih1x6EEkE0HOK7KkJTSAqv6MMIxju2MWvGJLe/v3kEhPc+X+EMEnJTj
 MCZWgrTN5WAFPFsy3Zbi++raMzdiO8t3rooMrRWsB9AqH4SlQn7xDPfp1mFNdFc3TYUDf594BoR
 Zw19UBQlH8WSS6M4DioBHUeMFbad9jEXI6EWiKge3U7KGiXsSzFhAeo3c0XDIaucZQ9u+ShOsGY
 jcrxjMUroIJfhtfZISN16N6buQpDfgxabVD2Ie0mPm1QovDE9SavS/h+4QvUxUy1/d6z/A2TRjK
 ki6ea0JhhhC9dJlAaifmeS9Q/I0dzdUIwHPyOcTNgRwmF3dZkr25PzX/5yTcrvGQCSpEMmVF96i
 93+/uS0yl0ocKHbqkSCb75bg+U8cVPRnONoOOqWYXCXq2fu5XhImk8wMDSybFuZIxjY16tzujyI
 9y4RFfGrAIWnyylINmtWuyZXvt0UfS8Vc0NM2Xi8B3087MtguWrgY9/LAPf33zlmLcL/HwuKFFZ
 a5J2HEMoW3EECP5NMbK9bW6Dz4=
X-Google-Smtp-Source: AGHT+IFw+A6JJ1ukBHqXs/MI872Zz5OU/BnlVWCkNMdMiOHB32mdP60XY1IS73eK96uH7ANXwCWiVQ==
X-Received: by 2002:a17:902:f68a:b0:290:c0d7:237e with SMTP id
 d9443c01a7336-2951a55d517mr128733015ad.39.1762082345471; 
 Sun, 02 Nov 2025 03:19:05 -0800 (PST)
Received: from sun-virtual-machine.localdomain
 (ec2-13-112-158-202.ap-northeast-1.compute.amazonaws.com. [13.112.158.202])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34050bb62casm11318214a91.20.2025.11.02.03.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Nov 2025 03:19:04 -0800 (PST)
From: Ssunk <ssunkkan@gmail.com>
To: u-boot@lists.denx.de
Cc: Ssunk <ssunkkan@gmail.com>, jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, trini@konsulko.com, Takahiro.Kuwano@infineon.com,
 marek.vasut+renesas@mailbox.org, pratyush@kernel.org
Subject: Re: [PATCH] mtd: spi-nor: add support for XMC XM25QH256D/XM25QH512D
Date: Sun,  2 Nov 2025 19:18:50 +0800
Message-Id: <20251102111850.5266-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827115205.17285-1-ssunkkan@gmail.com>
References: <20250827115205.17285-1-ssunkkan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi all,

Gentle ping — any comments on this patch?

Link: https://lore.kernel.org/u-boot/20250827115205.17285-1-ssunkkan@gmail.com/

Thanks,
Ssunk
