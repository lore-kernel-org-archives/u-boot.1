Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D48CC3DA6E
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 03:27:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7825E87645;
	Tue,  9 Jan 2024 04:27:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DuAJDvsR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C882487A36; Mon,  8 Jan 2024 22:08:20 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD77C877AF
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 22:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=arseney300@gmail.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-42989a64713so15431611cf.2
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 13:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704748097; x=1705352897; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j+KWPSzH3A685mf6y2+ktWWzXrl0Jx4K5aKmYOtQ84g=;
 b=DuAJDvsR70C+TA9mSpeZWqE1y6Nl9KKK0B6614mUNMWHp7S+4G2VMZ4iDAtbtBGA2i
 I12n0iRVEwbzGle3I2TfglQFgZnGv9vbnmovE1PFwFeDAR56Nnmd/MRKAYwzCZkNeBdM
 RVKFwNCDUmomo2ZOH2juut+7lip/OjeZXIjZVOFB63dZZ/R8GR412HC8heaOxCXOyrED
 cLxK4bG53dWFvmm79Rj44un0DfdJtW00cMo2F0InxmXhJiH0HPDlgXEK7Jumv6MXlXgg
 e+mLgkDlzZwveK+cRgGKzrPPIHcaLuDwv3LhtDoygsFqWk54WjXod4OpC1lkOR+hDv8/
 0oHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704748097; x=1705352897;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j+KWPSzH3A685mf6y2+ktWWzXrl0Jx4K5aKmYOtQ84g=;
 b=ksMTPkgkaLerA7O+zsh6AlwKjuGC5QDMKcmHtt419gk4kY7CdHCVwNdSeva2/z/M4Z
 VFjBbIzaRWsWwEG0DzweHBKEEufKR2Zx5tDLB3FfJGra7L/WwtrADazZoT6pzToVhaKR
 SUVLmUdUZ0fCOMXIrqd5OFIFPJEDb3Wx4WxDNs5uoMZMGyo049M8OwoE7Dz9H1pvwhzN
 kVkoy1aZ/aAhY+woXYjd87Fcp5iB0kv/ixP1ffrCa8HioGmy18JVjOHJH3So1oEDbdJT
 J+VL/pBhClPE3acDC0UljyvMrn7Nvy1/bGcO1TIIVFnJ5t0PQpTDN6ghV1tS5OqGdz97
 ZedA==
X-Gm-Message-State: AOJu0YztL49/Rg4cXZ2Y1AEXUwYvppbkKaUrobTkR9fxdlHaxM45xBkz
 eENOwzA4EbLGD796aghOfPI7siZ5iaacVDPdce1oG9uTn8I=
X-Google-Smtp-Source: AGHT+IFqnRcbf4+CgfQYslkG4vdXYZWIpNRwx7/E/qhhsnDN3x/wbgTBo2nA7MehpLLToanuZKYgW2HZH9sPm1nr3Gk=
X-Received: by 2002:ac8:5d01:0:b0:428:12bb:ae1d with SMTP id
 f1-20020ac85d01000000b0042812bbae1dmr6205483qtx.120.1704748097543; Mon, 08
 Jan 2024 13:08:17 -0800 (PST)
MIME-Version: 1.0
References: <20231230112050.90014-1-Arseney300@gmail.com>
 <9cdfedb2-d88c-4687-ac25-6680ba0088c4@kwiboo.se>
 <CANLA-xx8PS_mv4QTDeof5ReeK9WhosnRhRP=3XhwQJcrd76uFg@mail.gmail.com>
 <c12ac7d6-6ac5-42f4-a9d8-7e4d758145a1@rock-chips.com>
In-Reply-To: <c12ac7d6-6ac5-42f4-a9d8-7e4d758145a1@rock-chips.com>
From: Arseniy Mescheryakov <arseney300@gmail.com>
Date: Tue, 9 Jan 2024 04:08:06 +0700
Message-ID: <CANLA-xyG12FByq0o5FfceBVhG=nzTvz_VHY1ZRbbBBM+i74qbg@mail.gmail.com>
Subject: Re: [PATCH] rockchip: rk3568: add support of all UART
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 09 Jan 2024 04:27:54 +0100
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

Hello, you are right, that this patch is not needed for working
console and with property configured dt and config it works. But for
debug (for example, everything that was printed by debug()) it is
needed. Withit this code you will not see this prints.
And yes, via DDR blob you can configure a specific uart and it debug()
will work, but I think u-boot shouldn't depend on some proprietary
blobs.
