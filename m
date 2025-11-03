Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38386CCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 11:05:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE474836D1;
	Mon,  3 Nov 2025 12:05:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dLuq8MgT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9714D838CE; Mon,  3 Nov 2025 12:05:24 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2934E83642
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 12:05:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c2878bdf27so2401180a34.2
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 03:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762167921; x=1762772721; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VF9Tyhv9IxNwgK9PrqKy0N7TDVYOIFOyRoUMAyRAOV0=;
 b=dLuq8MgTc7A8j6HblzVPfLvQjYxQa8HwHu2IRAuXl38hjsV8Cgu3UurezW9B/7o2yl
 cUun00q1WXkYam5tmj/9GVhIj5eMI4E7Z1MZBiVFP52K3ghsil3m0GGM2t4/aeVtaoYX
 H1NHVo6Sv6Cjb4saWOpAF2CEDz5eiOUbg7FJjJTczxYZHrknVrtabP3JilDCsmZ1Bcdv
 Ylt4SWZjdRYLjAN4H/QTvyqsSkvAMdMevSpU0fOU907UGcAFOeMs5h8YYdlKezRRQTgk
 eSkcHJC2zBf2epKEX2WgvN8308gJ+raMSNSQ9MV3GOJCiCQNTHdD4nTPagSElCc3pjpe
 fZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762167921; x=1762772721;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VF9Tyhv9IxNwgK9PrqKy0N7TDVYOIFOyRoUMAyRAOV0=;
 b=MFJgREu/ukvbFY80N4i+87uLy0Ss7o09lys3V8wUcJC76MhuPcX9+mDlH6rZJAL7ID
 RD1J/w0hOM9ukY5s2MH2lgkExS4NfquP5qH+9AzIpllr5ZxSQlTRs4WjYrgLOjxdpcbD
 gTjn0TP6GNFGRXVnyIpfIosi3YMQA9uAzP6lxJF59K3DOS8jLI1c358NR+avRaLwN1U/
 jXsrQ8hnljUymWu5G1WpHHzTvJMdpyE3JTNpudX0baHdxz+m0m971Z2/eH4JF3J6tnEb
 3TKQXA4XUpFNZ/AQJLZyXrDIxr5X6ZTftkFylJRVyzg8k9EVHld5+KK7sZuuU7QL4VAg
 ofrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2gCPYPqL+p2nZ0gmOh/9DZOvENW6UxBPkdMVVEuZO5QMiBwGzC2mNZ0qYgt+Z4qTslv02PmU=@lists.denx.de
X-Gm-Message-State: AOJu0YzMn1z7HN9Ejn7eXRsgevr23RiBu59CA6ccj0XWgl5/QMlGjVDG
 hoHc+maqqkkM31WX+qK9q04boqICEqf7S7F/xsYEiyUEN4VZp1GQBmVFYG3vXzXGVqaBLObEQuG
 iaNMVai60D7TXXy3ZdP9ck0F/4thET/BrEE7bqlU=
X-Gm-Gg: ASbGncsH2hlos69Pf1+TVydD99VoIt7JUnnjAGyj8L80szdV6F9O/dXVeyv75G4xMd6
 JAyVkOUGUD2lDx7V3sv31D1+ewMYBUdITpb+/GhYaSzAoBa8+R5PcmEoV4AEOzghkovuw8FI2H6
 mCiVVmagWYvNgJnLPGmZe+zJ30BqDg4lEPIs3qP0gwnxUYpExaHZcrczuV+cMjDGd9YKJQrklTw
 oDL6VqRQiscJBWoxX51FPp91BEdzs6avry55MN5JLDrSqYhrTveN1pGIyJs5g==
X-Google-Smtp-Source: AGHT+IH4gp5+6zOuAmrIbUHJBr7mVAn1iFFAky/DE2etPVgGnjfmqPuZt+lDrqReYVqCyR0yCBe6tDboC19mC7UOgSw=
X-Received: by 2002:a05:6830:6d55:b0:7c6:76b9:db23 with SMTP id
 46e09a7af769-7c6967e4e5bmr6816279a34.25.1762167920851; Mon, 03 Nov 2025
 03:05:20 -0800 (PST)
MIME-Version: 1.0
References: <CAN7C2SArdbhag_56MwOMGoaEYSLiHbHHo3KFhUS5U03ntEJbGA@mail.gmail.com>
 <0f8fa8d4-3cab-4555-af1e-03feaef81ca5@cherry.de>
 <CAN7C2SBiONLZLy3jwUW8OE2QkvJ+N2Av8zcu5PEPa0zZmPNOpA@mail.gmail.com>
 <8987cd66-3ba4-4a40-84a2-9f978d688566@cherry.de>
In-Reply-To: <8987cd66-3ba4-4a40-84a2-9f978d688566@cherry.de>
From: Sune Brian <briansune@gmail.com>
Date: Mon, 3 Nov 2025 19:05:10 +0800
X-Gm-Features: AWmQ_blWuwP47qP_GtMGAo15JV1qbujzMCeOBGLwilPACU33tG9X8SwnQw8VXro
Message-ID: <CAN7C2SBvEX-mBUW2dXa1PFociqjnjnRkc+8ZS4cCNXeDW1Vs7g@mail.gmail.com>
Subject: Re: [DEBUG] rk3399-nanopi-neo4: SPL SD init may report -5 due to SD
 power-on timing
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

> MMC != eMMC
>
> SD Cards are MMCs, eMMCs are MMCs.

My previous mail mmc/MMC is referring to MMC slot.
Because NEO4 have a header pin slot aka MMC slot.
that can be any kind of MMC but the official module
only provide EMMC daughter card.

So there could be confusion.

The MMC slot could also run SD CARD adapter
daughter card. See [1]

[1] https://wiki.friendlyelec.com/wiki/index.php/File:NanoPi_NEO4-1808-IF-01.jpg

So what I mean is that slot is not having issue.
But SD card slot is having issue.
It is a bit hard to describe.

Brian
