Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B48B1061B18
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 23:01:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD01D840AE;
	Tue, 31 Mar 2026 01:00:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HhwioJqt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 255AE8352B; Tue, 31 Mar 2026 01:00:24 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A7978407E
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 01:00:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-46708149af2so2883909b6e.0
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 16:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774911616; x=1775516416; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SY6SBQ4TgPKLqEcvypuqhlXXyTO5fTKz6bXUw2V08NQ=;
 b=HhwioJqtC4X0m3HBfbY+ne6yl1nzQZ00mrf/uQA/31VbUtF4q30euDRh/mQ+urNDzS
 N2hDi96KcDVPTLvOylcISh7mMxTt8x7UhJ+oS/jXG4Pp2mD7et4q0epaxhcZmFuu+KIb
 v6CUvi2DEP6nMjoLvy78Qd/ykS/CbIHEwmKWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774911616; x=1775516416;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SY6SBQ4TgPKLqEcvypuqhlXXyTO5fTKz6bXUw2V08NQ=;
 b=B9xu4qJCS1SborxoTqeSqSdOT/d4ayB5h05DzJ4sH3no2rF4cherjxDUT5V76AeSNd
 x8HNsjsOFFmPgdrj0TD7QndZC6thQ6siK0ABkxUDB8i3BtkPvXXDlPHRvEdZ40f9VQjO
 XvDLu2lGGtYGM5B50qOqy4YzQ11Jf38KI3rX+2L6vNyobpNZ+ov1z+4xY9Nolls1ykWS
 Sbuo71EkuOgC2Rc+w7zWdsDd55gq1iepL1OnvgcyyG7IvpGdX3kXFUXX2aqnr67nMLMb
 I+A66MuFPQyKwaIdH/4dSa8ttJDPX6w42zypIXePmIfBrviTEFeCC5AIWsgwi6XTMb00
 fEcQ==
X-Gm-Message-State: AOJu0YyEfM2McGMeTGph1I5fyxum4gxP3teU8Nv8Oxy9i8lh5xOqWv3F
 1CdX/HnJLEXbdA+iD8qAkakTCUI6JTu9nBmnTwdK9MtbCpUzso/Dbt/LpcS/bnfHNG1Ry97z5Ka
 uC0voHcE=
X-Gm-Gg: ATEYQzyzgX7cJJtqum3JExEn4kT1mzTjvapwsBcb3jipus26DtPV23ffyPygN9wGbUG
 in9GvhKkb2gAsE6OXUruWgiig8tLKbI4zoDZV5WxR4qmU6ylTG5HUuiFXkLEdut4LoJK+zdA78k
 SBvwYL1FFicMUB5brG4fyuahQ244pSlkY0lZK7IR7kNqpqf549XJZUs3u8NtHfNc9IIplQ8OkRA
 f4+ZTcHs9z+mLV1Z8EGHFOa1EQwqUkD4kjnTDoKxzJ4jkQM1TglXAFOCXXT4DItqYLswFg8xwrc
 EzKjA0XlTEQo9qo0sPORR7qEQ1cEOycfrSq8AlmLI1OxbSxlNBfFQJA/THJCFlKv9F5q1rPz4tS
 sPaYpDJtjPsyPWukeWqDxs9BOG5K+q8N3DejvfB0MgVHnksitwiJoKGfOxvWwYpTBS30zx3HJN7
 LdWSj88zv74bOBqdbJmXunWEGzHCyvR2DZwIDRsSJoDfJJ8pSPx+q5pTIk3xnpb9yqOoDnLqwLl
 yQk07I81bw9DkoBiJ51uBAoZrX/JBWBWoir95I0UwcrtTM=
X-Received: by 2002:a05:6808:6f92:b0:45e:dbf9:61c7 with SMTP id
 5614622812f47-46a8a616543mr7652231b6e.46.1774911615628; 
 Mon, 30 Mar 2026 16:00:15 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46aa03b1e64sm5644737b6e.15.2026.03.30.16.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 16:00:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260317012441.4162586-1-trini@konsulko.com>
References: <20260317012441.4162586-1-trini@konsulko.com>
Subject: Re: [PATCH] pinctrl: Correct dependencies for PINCTRL_TH1520
Message-Id: <177491161483.1028292.16520573043665399794.b4-ty@konsulko.com>
Date: Mon, 30 Mar 2026 17:00:14 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 16 Mar 2026 19:24:41 -0600, Tom Rini wrote:

> As exposed by "make randconfig", we have an issue with the dependencies
> for PINCTRL_TH1520. It really needs to depend on PINCTRL_GENERIC rather
> than select it, and PINCTRL_GENERIC in turn already depends on
> PINCTRL_FULL.
> 
> 

Applied to u-boot/next, thanks!

[1/1] pinctrl: Correct dependencies for PINCTRL_TH1520
      commit: 1d5d6789e39ce6786a6ce60ceb8980458f2b4e6e
-- 
Tom


