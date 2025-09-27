Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7D7CAC5B0
	for <u-boot@archiver.kernel.org>; Sat, 27 Sep 2025 14:05:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4BDC830CA;
	Sat, 27 Sep 2025 16:05:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R0t/rYZV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A22F7832C8; Sat, 27 Sep 2025 16:04:59 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89EB180819
 for <u-boot@lists.denx.de>; Sat, 27 Sep 2025 16:04:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7827025e548so1865557a34.2
 for <u-boot@lists.denx.de>; Sat, 27 Sep 2025 07:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758981896; x=1759586696; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O2JdoA317WN0oo6RR7JeVf6qLu2OP6XgEAGmLh9NMeE=;
 b=R0t/rYZVkZFk+vJ1GhyJpwDwqaVS5pfX0Ic64LQ4c1RkGXJqX2tIzW672tsAr2SAqq
 F8CBOw5ZH5Sua1Z1wsutCxLYvXI6/o0hbQd45RslPLLBgMXOrlFPV6Q8u9lvfiP3xyFz
 dslrMiNbcry6nInzDZXt8joK3K8GVhs/c6wzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758981896; x=1759586696;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O2JdoA317WN0oo6RR7JeVf6qLu2OP6XgEAGmLh9NMeE=;
 b=MofNkhSBC7tr6WAvR2Ld5I7/sR45TivZhJP+klLISuC0cJe/nDgrQyk5LTp+eoUMop
 tSNmsHCrlrX+2rB/94c2dcSyVbngLpYz6PgtjyErzfRM/fbe7alF7XKi/+KuJzJTHOp2
 wat6RoAbDaTpz94iY9Kdeky39DN5+p6cx42j+HfYMGc8BDW/5awPPhcVVRfOMi02O0tp
 LiUbP3kwzOn3bfA3fIQVhxhWrqdcZSSGJgFLDUg+zZVPxka6i4T1qp/C7LpAND6lJbDI
 0BAX8MYD/Coty1DSAzMKEXzsn2sc415lZ7p2qwC5P/CDtZPfbMi98R51y3m1Twic9q9x
 utUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcsDwlPGnbHM2gEPnmrjycyLxVAmKRwRdJlG2d41pEuUPdZwaAL7xt8kGLPRmU6R/34w5urd4=@lists.denx.de
X-Gm-Message-State: AOJu0YzAndc0R7IxZnBTcwBd3J4CtsOITT749mlR16U5IgV0u16D+iBH
 0Zbxrt9X9enTKtzR/RDOSdu9ogr0FjWRPUpQr1/M7duQYzVWjoFLVXCeHaen31qWwuONspglPP7
 5Fr4hwbM=
X-Gm-Gg: ASbGncvBMf+d7btENekjg08STRgCGhjUBWmcd8RsViAgrZXDID4vGpgt0G4GUnJznGA
 em+IMwvTN7R0FV1DEZaaMxcpzb6WWqZ+XXAX3KTG6lKk9U9ApoZ4XkckUPKKwFtlCUb5aW1nZVy
 Wp6wn1dkVxrnULXn4DvSkdnuc2+g+a2rS4yF4yxRjM0f8uLuW0lAWmGN64s2/c1nXaebqQyBvAO
 D0feQ2+bdGlZkAZWZZmLFwJ2ChH4sOWHQHViHWc8rNQaN9v3tI6ISDen0t4hWwP8/GB9nMIXtq8
 AnZjH9I7SucNeOMYHsgzRaF2bte32BNWdEZlUY+7ctpmLh9l3h23/9IYbBeoKPCNyFBA+FFKI6V
 kCnYo3ScwME5qlTJKIBIAG8t4tBaN3jFfjuOitpVDVvQf+QjPBBFLbCg=
X-Google-Smtp-Source: AGHT+IFkj0DL2thpePXKJcxUQlM+2EOf47XTl2p43DccBKrtUw9IbqEoc6bOY9Nc8NxchyEhkozGNw==
X-Received: by 2002:a05:6830:6211:b0:743:801d:5215 with SMTP id
 46e09a7af769-7a048c02271mr7138953a34.17.1758981896284; 
 Sat, 27 Sep 2025 07:04:56 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7b4c0e92da9sm20077a34.26.2025.09.27.07.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Sep 2025 07:04:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: mkorpershoek@kernel.org, j@jannau.net, u-boot@lists.denx.de, 
 vishnu singh <v-singh1@ti.com>
In-Reply-To: <20250916072515.1088313-1-v-singh1@ti.com>
References: <20250916072515.1088313-1-v-singh1@ti.com>
Subject: Re: [PATCH] bootstage: stash boot records to reserved mem before
 kernel handoff
Message-Id: <175898189474.3905802.8730233590307516405.b4-ty@konsulko.com>
Date: Sat, 27 Sep 2025 08:04:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Tue, 16 Sep 2025 12:55:15 +0530, vishnu singh wrote:

> U-Boot now stashes its bootstage buffer into a reserved memory region
> whenever CONFIG_BOOTSTAGE_STASH is enabled, just before exiting to the
> kernel. This allows a post boot parser to read a unified timeline
> (SPL→U-Boot→Kernel→MCU/DSP) directly from DDR, enabling standardized
> and repeatable boot-time profiling across releases and SoCs.
> 
> Change summary:
>  Call bootstage_stash_default() in announce_and_cleanup()
>   when CONFIG_BOOTSTAGE_STASH is set.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] bootstage: stash boot records to reserved mem before kernel handoff
      commit: b6d9aa6aafc0ae2f551de301e1f371c4814cef68
-- 
Tom


