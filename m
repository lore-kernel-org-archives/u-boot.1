Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7343EC0032E
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 12:41:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 992EF8761D;
	Sat, 21 Oct 2023 14:41:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TdXafvQp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9547C875E3; Sat, 21 Oct 2023 11:40:22 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A922C875CC
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 11:40:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=viraniac@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2b9338e4695so22790011fa.2
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 02:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697881220; x=1698486020; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HGAyEr+MJjbyKx/5z6Z+nbt8ahTPOOSq7yQMKMKooKk=;
 b=TdXafvQpPBtLQnjKOq16ERD+7W9wVcf8Bsxkw+6nPbSL1Pd2EHpBWsmh0SC1yx/+2Y
 RK1rzN50TP2R4q0n9Ulf88HLPiAzhVscL8UjZJz1h3sOJFjX+XetrL7zf/HTnu7u1aPk
 AKcmCs4agzOeYn2s1AVEMOFN2HZxLOxp2fVIRMsRVOHk0KbHN3D6AQtTENHegxdcuajs
 PitvPL8lf0DoCDL3FVGp/7ZU+TcXkuLzg4mcxCG6xoBgwl9ZMV1MjA+mGmlwmkhd1dJ9
 p6ok+8Og6ODhtU+cnrb9w23zs4xQai4NG8yWk1Kdy2r7bWxsBtDxF5eRRnrS6nGGbVck
 t9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697881220; x=1698486020;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HGAyEr+MJjbyKx/5z6Z+nbt8ahTPOOSq7yQMKMKooKk=;
 b=GoSfX8RfC206lpeAKRXGnrfaxkr4wUup29m/UeAI8wObWCKTGsJ9vFz7AX++t+R03J
 hgIda8uavzdWMfgoR3ViwNU2FEjsfq98eEYW9X/3ncqaflQPLdIcWg4V1xvxk5PoVbga
 gjbb+hEpukCIAoyF49uNCThu5KeUc9WP1REq4v/aN/4UzmB8Q8hV+FMxS+3H9/sT6KIg
 Q6hBGxxljzv+Cgjjn3d4L3ZsISWi9Yd5vvNlYchv95cGcicjm/6K9FTuFPfsCQzANN8M
 OlM1Hlme7G47of0/cKzVRHCHvdLTrnjGmiUvEi3U9xzaLl16XenZYdx2hm9autfOtVUc
 qg1A==
X-Gm-Message-State: AOJu0YyMa3Bo5SwmesTWpBTs80jDB5hfkP6h56vZRJs1anEqIfhdUI0M
 SVnRBaC9GbZ0xTgHpVEA0pZJfpUuD9UiS6Kfh0Q=
X-Google-Smtp-Source: AGHT+IGGT2wojoIV7etAPB/lpWQf8WT1nn3YZsqBQ6qERTy6T1MgU6DQd/QnmNAuD3ijACLToQ2rB3aBM27jPLwmkmM=
X-Received: by 2002:ac2:5988:0:b0:507:9fc1:ca80 with SMTP id
 w8-20020ac25988000000b005079fc1ca80mr2898003lfn.54.1697881219479; Sat, 21 Oct
 2023 02:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231001161336.31140-1-viraniac@gmail.com>
 <4834802.GXAFRqVoOG@jernej-laptop>
 <20231021003839.1fcf08c8@slackpad.lan> <4518016.LvFx2qVVIh@archlinux>
In-Reply-To: <4518016.LvFx2qVVIh@archlinux>
From: Gunjan Gupta <viraniac@gmail.com>
Date: Sat, 21 Oct 2023 15:10:08 +0530
Message-ID: <CAJAzxbWj8X7EcXwPCypp0B2Eid3g4cfR-UYL-kwWbA2VBSFu7g@mail.gmail.com>
Subject: Re: [PATCH 1/1] sunxi: dram: Fix incorrect ram size detection for
 some H6 boards
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de, 
 Ondrej Jirman <megi@xff.cz>, Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 21 Oct 2023 14:41:14 +0200
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

> I'm fine with the current approach if Gunjan confirms that initialization
> works reliably.

I will test it out over the coming week. Too sick to even pick up the
laptop right now.

Regards
Gunjan
