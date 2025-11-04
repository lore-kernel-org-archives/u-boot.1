Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5693BCCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 22:48:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FABF83981;
	Tue,  4 Nov 2025 23:48:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UxEA1A2G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA5D78398D; Tue,  4 Nov 2025 23:48:32 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C309E83968
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 23:48:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c52fa75cd3so4662795a34.3
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 14:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762296509; x=1762901309; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZyauNSleKkDQrrSbKFJ+1YSpatsFLq82zZkJE+58HQc=;
 b=UxEA1A2G4aah76kvwzYe0eooAaIyNmBgEsqiS3MHfzQRBvewdGfBVkU1t6Q6mgWpbT
 LxP5CyLJg35DbxUPxcXo4/0jH1HDy0utXnOk0N+ZtMicZU1BU34Sy5tkyscENRw7wzxa
 HX0sfwc2NyjEYq+djE6juLIEspaTeqjzmTwtErHp+DzsMrcyP+H11m+GtEejWzHRpmKe
 qIcsNQXraOeFCKSrIthapa5g+FVnrzXPkV5jlh6yfEQ8/DHIPDX1dHIwnIYdhClSEUwV
 xqwcIIcq6vonKpDhXiPjBr1p14d1UxsoBko11Kf7N1jmKC4RXYtNcyjPT34pNjWeO/xi
 MCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762296509; x=1762901309;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZyauNSleKkDQrrSbKFJ+1YSpatsFLq82zZkJE+58HQc=;
 b=exk34gM9AYs2bZeOdkHd1r4B42Jkh5s7S/K+OIlcZYG6L7j9qrjvMOmUODuMMGoae/
 Mwgmlwb93ywXoRaX4V0uzig5bopqGIMt8MvzValwxpEhHtJrX8JWV3X5fcVZDXwLEH4s
 fXOUVrk8+TCu2Bbk6qVqYixWx4+CVSAbr/4Op9nkppATQJRf4q+1MzyADtwFTingHoLw
 g5/J3qqUXTMIEH0LLEJYzNAW2HZw8T6UmsfvMHykUCPmaB9uiLTH6uirb/rZvlzLuVSZ
 RF9t2NJXjqGBXjrqC0s2+M+oSt2acVcO8/mPU8Yg5rD6KOMwQD9tw6Jz5ZVPOc2haM99
 Z4Ag==
X-Gm-Message-State: AOJu0YzY0T7giAbPo+B6K2KaTIoCWrLCkHr5eaj/ZM6XDVagjclsf8CR
 e7P1uLP0ccM1Yvo4IlsjNMsJQDEgueKNliF2El5LpRDhLYBrF/4wMJoRpgnF+TRjwQCX21/AD7T
 afAdG9E+fz7q29M45/VRiFH1MsV0Fz3U=
X-Gm-Gg: ASbGncs+uTb57RSDuXGMc2l/F5E1d6Nav24BQpJrWFM/BuJuUB9kBGZg3qn7CzV/29o
 yaVgUsq8/R++CHi/3aMk5lMj80jH4VqoEf1zFCqbaf4A1RamDSAAjcw9Kmk6tQjfpjxZYOt+Bd4
 Yf4HA/lTF9+PpqDhPGXdjcI0MRXPQ0eGyAEXLhOPY83CDI/BbrCENjpIWiHECnX6uYfbVp2QQ8s
 qiVxXskMylkhORztTbGGJnrmHjtrmEPUqdVEHZBlTY+dekJMBSZTVU/dhrO
X-Google-Smtp-Source: AGHT+IGlmK30gemo99VOBUZm+ZmTgWajZ+tJgq5eJA3tjXb+vbA16z2ksQ5WpELCVuSrgrEh9BttEYV1cA7jqVt1MKY=
X-Received: by 2002:a05:6830:4113:b0:7c5:3190:c5d with SMTP id
 46e09a7af769-7c6d14a1d0bmr601572a34.26.1762296509483; Tue, 04 Nov 2025
 14:48:29 -0800 (PST)
MIME-Version: 1.0
References: <20251104010003.525-1-briansune@gmail.com>
 <20251104175123.GE6688@bill-the-cat>
 <CAN7C2SAvyfUyTqy8sqKxPWPG9Bu+aYiXGjMzfVJxR+mc59TD4A@mail.gmail.com>
 <20251104211832.GI6688@bill-the-cat>
 <CAN7C2SCLbo-9=QS8qURd=zwWyOYidAsCtb6E-CGbCmh7yrN9nA@mail.gmail.com>
 <20251104223753.GJ6688@bill-the-cat>
In-Reply-To: <20251104223753.GJ6688@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Wed, 5 Nov 2025 06:48:19 +0800
X-Gm-Features: AWmQ_bl3-wXGNLXvcUUrjJoxPh_FUgycpISNKzLRJFHH1Y_QGmbr65XBGRgHKpw
Message-ID: <CAN7C2SDnm5cK-J=DocOk5hS8k_7565RB9yg5XNVu_kaNb3UjvA@mail.gmail.com>
Subject: Re: [PATCH v6] Add optimized Makefile support for SoCFPGA handoff
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

> Yes, it really needs to not be in the top level Makefile, the more stuff
> we have there the trickier upstream merges get, especially when this can
> be hooked to archprepare and work just fine. Thanks.

Done~ see v7

Now back to the documentation you want.
Where and what should be included.
If possible, a good example can help me settle things faster.

Brian
