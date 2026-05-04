Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B2FCD342C
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 10:55:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F04D98394E;
	Mon,  4 May 2026 12:55:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h6MWhbuQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8289F83EF9; Mon,  4 May 2026 12:55:49 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5162980F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 12:55:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-67c1e0229acso2328182a12.1
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 03:55:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777892147; cv=none;
 d=google.com; s=arc-20240605;
 b=MDN+82DqpwRGRNqsyJ4j95sDs3LgbMX0LYgh+97i3R+n9TPBJGIbiww5ddKC/Nv/4M
 l8HCTUBz4vKHyyLjG7AjhGEpfeoJo+/WJ+f4WgqOdmFMzepADwo0001+VK8XaUMkP5Lu
 bBuWqKejoZsIt6/4lJcQ5V4SSatJzF2E+MYi/0kz/WtNq4VbAaa2wtSJkD4a+AEkCN3M
 hbITdQbuaSkT7gZRRB0fehAvFW0eCAnYEARjAiKA+PxHUqcrTAXcEk+5s2uG5VzZJy1t
 hKxE+/xxZPOmogXGVhxYWaZjkDMnL5f2sPcGW0GmxLSiOIVNqUlKSFCeZ1EZEhwEJIFQ
 9DVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IAAcyKsrZU62O7zU0GrFJJMHzMJum8sKJz21uFnGvzA=;
 fh=hlfLg/PRX2t20KzhaS0rLCaDcrgaLGVzYznDhWDuXMc=;
 b=bEjo8uNkbqmBzBogrS7CiPc6mkIj/VwBtjybgxb1UJXh00vK5GJHwZjZQndFYe8vCt
 v4lyK8guf1byrduk0kc+BCv0aYRgI60JHCTz1oqvxFG1HBHr/vTT1P+EAgnKliS9vBvX
 MzkCzj4+JMXRZg6tGTaoQF72GFiCNgS6Od2rzEpySX//AypBQ3h/aai+SurpmXH2gqcH
 PrRPI9gOB+2SvUCiJFjakeUX3nDVIibhg5yqafKMfcimK20qBX/17C8oLR5QukB9BEFe
 kLlmwCFaZcNnyy34k+OJmbtoPnIIDnEhGltoSaPz4Nwe1tbsjBxlaTgt/xXah/Ef1hmf
 Gj7A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777892147; x=1778496947; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IAAcyKsrZU62O7zU0GrFJJMHzMJum8sKJz21uFnGvzA=;
 b=h6MWhbuQadK8Hl2dydQzeqQrTji/ox8+3kE5yxyQuNxQySjgjjx7NRXsAiCbZBOG0L
 ZmtogO1061z+01jDx2TVyCuirkA5a2wPYQE6DTZ4hjzZsvEXXZoFFHv0rKXdfjFdLher
 gcRprNLEDYjlA56NqCusxUgAjFuwIVYnO2bbErSkUhFO2G9Omq4rlwnX60M7l/gSoANG
 eGKX1TbAQUNswPKkg4zti+aqrFCdeOzIqCDPzwh3y37tyQofuqt+EdlKVMf4U6O8+nDk
 iSs/hxkwWjkYf/bTKAJpVsmHuw43O7fG1U/DFpB4USdZo4rEXTXz+uvp8jFvZ/nCdUel
 Vy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777892147; x=1778496947;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IAAcyKsrZU62O7zU0GrFJJMHzMJum8sKJz21uFnGvzA=;
 b=n3RQWR8duUwpqv8kwJ/93QhotGR6ury3o5osqcQD2AZJmN/yNlFNzVsI6eqDKd2+NN
 eNa1KJHGZZDSaRiHMhZEy5pBv29R+V3mKBS7EGhKJimzVegrk+QrRaB4jBA+5LSBtsWW
 Vy9eS6LKlYTOZ+DyAhBtypr5FDH3h1NJvYcObUsVPPEN35L3FBIZgiUW6ymKfhJgqbWk
 Q237K8iNWGM/IXD+YF6fpnInfCkAzyyhKRn+JE7HpzktlMIhWFvbZmD1dy9JmqDOgisu
 cbTgiuZ/xXIudGG5J6kCyEi1RYIalZh5Ku5OoAx10SB04a/yqc2LwfTtEh0FZrmMxtua
 YnAQ==
X-Gm-Message-State: AOJu0Ywf/jOjbGFOAMhj0Rp+b2tKafUVIxjmWboshwWImEZ5Rk/oxiNy
 j5NtJhrSZYkHklAyDNni0ZAcq+xIzX4jpfJvyofsO5ogdzgvIvuEjf7ayp8L6x7bAbmz/bdjK6j
 gvKniI5Hoo0IO16KR6QorckIxR6rjrOg=
X-Gm-Gg: AeBDiesQjnrY4SZuyIShXqK6FycLLunADGGwrX9ZCarUzn1MHjJfv4HzzRfZYlXirTL
 L/KbkTBxf3u8DqF+HBdybzTGnq+T/Eopt91YRqruqUBGfSXK3/twG+bOm6c96cKPeFaxZ0KwujV
 FNCXQ7eNkcCLGCsuCR0KU/foZFy9dif8hl08kGy8dvMUcM6eUDwRsr/ItMzLDF69YTH2w3o7rIN
 iOaKd1Kzjz5MoGyXHL7hU5axRML7ko6QSCTAMNZZRJahndTY7N4e3TzBkrN87Yg7GI0jUYPOL3J
 JqlPkGQDH3dwJyBB19bR7JpOvuXwUfI4J9FvNNx/hPoWHE59xxWr/7CrUc+vebefb4olUSJAhu/
 6ZBYE1ElbSWiODQynJffLoZfp+6Ruo3l7uxmJ2aTCmArDpknTPt7FyRmyJpkyLBGFd6zK/YenyD
 ZnS6kbZYP7n1M=
X-Received: by 2002:a05:6402:1217:b0:676:3cbd:1f7f with SMTP id
 4fb4d7f45d1cf-67c1992a5b5mr3001835a12.2.1777892146464; Mon, 04 May 2026
 03:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <CABVgzFqe4Wj8DGJHFfwHgYy-As57CnmROXuyOnMhnEBwvJOZdw@mail.gmail.com>
In-Reply-To: <CABVgzFqe4Wj8DGJHFfwHgYy-As57CnmROXuyOnMhnEBwvJOZdw@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 4 May 2026 11:55:34 +0100
X-Gm-Features: AVHnY4K59bt9XV-LEkg8QRXrCAPJosVS2YAxlUBLD-_HxPa4UO_UXQK5kF70iOI
Message-ID: <CALeDE9N5WTKjqnFPxr=4ASAR6KCDVpdf8Se0viuLVVjyeTWV9Q@mail.gmail.com>
Subject: Re: Raspberry Pi 4 Model B Revision 1.5 and U-Boot >= 2025.07 stalls
 issue.
To: Matteo GUGLIELMI <matteo.guglielmi@gmail.com>
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

Hi Matteo,

> TFTP downloads in U-Boot >= 2025.07 on Raspberry Pi 4 Model B Revision 1.5
> stall during transfer (continuous T output), while the same setup works
> correctly with U-Boot 2025.04.
>
> Please note that U-Boot starts correctly, DHCP works, and small TFTP still
> works, but large TFTP stalls (e.g., kernel or initramfs files).
>
> On the contrary, Raspberry Pi 4 Model B Revision 1.4 does not have the
> stall issue and can download files correctly up to the latest stable
> version of U-Boot (2026.04).

As far as I can tell from PCN [1] the only difference is the dual RAM
chips so I'm not sure what difference there may be and I only have rev
1.1 and 1.4 of the 4B. Any chance you could do a git bisect between
2025.04 and 2025.07 to work out what change causes the issue?

Peter

[1] https://pip.raspberrypi.com/categories/560-pcn
