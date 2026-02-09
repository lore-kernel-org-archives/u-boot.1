Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44EBE81BD3
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 17:47:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14A87805D7;
	Mon,  9 Feb 2026 18:47:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QMzYBrAr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 633758388D; Mon,  9 Feb 2026 18:45:57 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7504E80325
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 18:45:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrey.lalaev@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-480142406b3so36644725e9.1
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 09:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770659155; x=1771263955; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IaEk3jZO8xyfChisswwGUirHPHqr2weO34JGw75hs9Y=;
 b=QMzYBrArmiOJWU1FE5R8FFCf3OTC10ILhByX7UgoUIkugggX4QV22KmWiTk4/4KAz+
 HJ6Azp4/A/cIdxoj9xfqI0l+cO3i2obm9NDoPAJ/iOq0bwCab7nbGKFTMuDJrxTUjtPu
 SkpK8IxGX2lid3qSP/tH8XUqh3c6f9gOYDJ1Y3kyxpSGRbJeDFHqlPTsVuW3fOTqPrla
 ndtGs5b3QDLWMxikdbUediLDccL/UEyv27s1rCXQHKxo3syQ3ymzCYibxW0wMcVcPoKd
 aUSSTkACqgg37Mja7URtaDU1wMeA6kWcGSYowNGifr5EVSxlCCNNvc0UuiVLiX+QIg31
 i8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770659155; x=1771263955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IaEk3jZO8xyfChisswwGUirHPHqr2weO34JGw75hs9Y=;
 b=N1xJ1FqMDwksWWuq85jFtCAjxxRZ8w3x6zj3CgKqm52uii3+N0x8QJgyFj1j6kpqYw
 uZOd6sQ0qrTU24y8G1KoeuJMg0i8l6FmaJQq+yxyF3eG+QhJOgtrTvnfwfLG5Z4gVOwm
 qANepCZka50/cliPnq14dbMcSgILsyty0ZKk75WtDAhEFHDRwNosE/b8EexAKD+4mnJX
 JpGiAyu4l3428pqbsBOcQwBoye02q1QtAmPqZUioM0RiMTb6UDJze0GOWGfGIWr9dTu3
 c+veicai5uMTJFwZs38Dj/mFhuVwdRmihcAvuk1nej0VX4Y0cBu9iUlpNM4FTabRcONc
 Ozsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJEUiWdifWUIUcLju5+OfLjA4jzpFvtB//LZUDanyYY/nBPypE4e6x+auDtP5hSv3mZponHnM=@lists.denx.de
X-Gm-Message-State: AOJu0Yw64CRjtu3Jg8P2cbffnejGbJiiVTX+CUZYenu1NzRsczfP255u
 GfjUE12udBglPLKVKhvwwn9y69EjjIda2NciyBPV5d+WXZTRaHpien/0
X-Gm-Gg: AZuq6aJuy2kuEFq0vLK0ARzkIz0K/rwQuqOQQpcqpm44UzD5Rr/zIla8ZaVJfAtFrqw
 cjJqtMS62nHeXWerEsL5SoFaa/rCz0FKYCCMY4TXpgEdJeMbDSylU9G9HXJlmYdiLoQQEHxuZTA
 K5wXG1vEhkr9tc/mqiQjIp9a08YCSVAgGtN0XolMGo7WqNTlu1pyD8wcaSu/gTScsHAICca4Rds
 nGKlEkdqkC/zYF50GlHduRPa1gzZ0LktACOMo0WhbpRCnUNSA3xNDU5oWIeNjejA9JMMtD5zD05
 vwBxS9yJyRwx/RIzP9I4apXmtRE0rLAIBIM9lGsS7OPr1JMcvZwpZunCymdAk+19xUl+sanAvEZ
 tUW8cO5AcU7oxuomwp6HExkPVR+ARTDX+xFB9sJCeiOUY+TZaQPMtx68ixdf1kS3745+6Yt6UKZ
 oOhqe7x6GZIfAgmldUzYmnaXAgkq37gHW40X3b7D+Xu0gKOs0TczEom3pzqNDrTSYX/tcfg7UJy
 eBUqTjrzNpQdLj2FLJOCNXx5qEVKWF8jJLG+Y9RjhY=
X-Received: by 2002:a05:600c:8b2a:b0:480:1d0b:2d15 with SMTP id
 5b1f17b1804b1-4832021d841mr170674415e9.27.1770659154589; 
 Mon, 09 Feb 2026 09:45:54 -0800 (PST)
Received: from thinkpad-p52.telekom.ip
 (2a02-8388-e6ca-5780-862a-653f-c029-07fe.cable.dynamic.v6.surfer.at.
 [2a02:8388:e6ca:5780:862a:653f:c029:7fe])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d7f09c1sm7702545e9.13.2026.02.09.09.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 09:45:54 -0800 (PST)
From: Andrei Lalaev <andrey.lalaev@gmail.com>
To: heyitsmemikeyy@gmail.com
Cc: pbrobinson@gmail.com,
	u-boot@lists.denx.de
Subject: Re: U-Boot Not Working on Raspberry Pi 5
Date: Mon,  9 Feb 2026 18:45:53 +0100
Message-ID: <20260209174553.2743099-1-andrey.lalaev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CABRivRtu9=L2SyB9PnoEwbyJfs6tckHcd0GOToStvV2VpLY3pw@mail.gmail.com>
References: <CABRivRtu9=L2SyB9PnoEwbyJfs6tckHcd0GOToStvV2VpLY3pw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 09 Feb 2026 18:47:12 +0100
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

Hi Mikeyy,

Pretty sure you've already fixed the issue, but I've also encountered it
and found out, that U-Boot actually works, but UART doesn't.

The root cause is compatible of `uart10` which is set to "arm,pl011-axi"
in DTS for kernel 6.12. "arm,pl011-axi" simply not supported by U-Boot driver.
I've changed compatible to "arm,pl011" (as in dtb for kernel 6.6) and UART works again.

Best regards,
Andrei Lalaev
