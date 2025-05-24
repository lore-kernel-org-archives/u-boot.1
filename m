Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF98C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 05:08:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DC258363B;
	Sat, 24 May 2025 07:06:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L7AOtmqz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C610883303; Sat, 24 May 2025 07:06:20 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D331834BC
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:06:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ad53cd163d9so78770066b.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 22:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748063178; x=1748667978; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qR/RvON/KXaiss8WIo26HdEkPNcUntKB4huOiIQSKG4=;
 b=L7AOtmqzLTnO3ugs0t8w5r7hFvocH/yQLbTXrzapTkUlX7FkGyeXIMVgkLTABmvgTk
 utV5/YlTkRoS8ITs7QJvBc1dm8VpubygXyqCXO9R0sT9abv4dstzCZxQ16/kXPWw/eVe
 BUbmKuaf/rFCjIL8SK+gJD4BWgoyWKWgQG01w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748063178; x=1748667978;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qR/RvON/KXaiss8WIo26HdEkPNcUntKB4huOiIQSKG4=;
 b=IKOyZD58omI4kfCZN9fifqbXVEzGEiX2DNdcI0nSoGvp0dRV26i54GyUVFcEOlfhSG
 Gchjo48cCFiX9SXZbVf6hFy8UWQy6zujPIVyIOT9f5C+RyEi31IpI6dLrNVZ3ku86KYo
 g0UfSX0aHWi5WKMHV81iBcWU/dVTSOZvXoryex1zE635f8IBhwLeL5l2f6GJGo8ToXK5
 mYUqQb8IvtJ3iQc1VWYNVetPRS9J4wfkJHZJVyNdvGvFaIELMhoi28feteKon5SCsw+2
 DS1GOs/ctR9e/U5HOGR5W+8q5vbObGBANc3c08aIHCGvhSxqrKsc22Yscj5rQOvbbVjG
 TTfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6jRZTB1fJ7U2LeyjoJnsjj0ULaNLImBpIpzKDF/qnYEZt8su7ZPJtv/TDwXy84ppBxRT2bcw=@lists.denx.de
X-Gm-Message-State: AOJu0YyoJp4rw/+45Wx74SGZI8ZfKS9P/oE/Rr/RPuvIoBxH9flvqlCH
 NSWDYrQ2FY1zIPVyFPeOzXAjRmplRTYi3ie60VappkIumUoG8hUd/y1jYmW8ilyvo69RFg6/Jf/
 WBq/HG6NzVE+AbBc9a328aWffGyWyGB4Z8HNGD+e3
X-Gm-Gg: ASbGncticjx4woD7M97+drveUJ85HRSgEhZPpDxPvDiWU7ot6B3ERr8ZTEq2oQA65U1
 sqkSTQW+NjFcFg2ugw4flwrRlXoN1zifT55qR2Nk/hEaU8qUuFDPaAR4TcFZzw7ZODqUHO/YZod
 acTToz5pV/T3rGq4qizGu0wUEyE3Y5Xuo=
X-Google-Smtp-Source: AGHT+IG0ETKkA6+rg5UhdW/c6x8RtfGEdFlVxF6OFU3vWcLD22PuXn0nN0zzQ1cZZwemTIlZHFCpIccutVqhzi1uiZM=
X-Received: by 2002:a17:907:7ea8:b0:acb:5583:6fe4 with SMTP id
 a640c23a62f3a-ad85b12f881mr125217066b.6.1748063177992; Fri, 23 May 2025
 22:06:17 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:06:16 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:06:16 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250510110535.1453745-11-sjg@chromium.org>
References: <20250510110535.1453745-11-sjg@chromium.org>
 <20250510110535.1453745-1-sjg@chromium.org>
Date: Sat, 24 May 2025 00:06:16 -0500
X-Google-Sender-Auth: VeCSDzOkJTkDzE228ppANbaJO9E
X-Gm-Features: AX0GCFsx8AexmIk5iGnxwTEOohJWvUHDHJcvM85RoEkfOo7l4jOmZPAqwH3qOjA
Message-ID: <CAFLszTiq18C0V_18=17cEMSBrjO16nGvijCXnksFyaqGbD7G_w@mail.gmail.com>
Subject: Re: [PATCH 10/25] patman: Add a helper for managing cseries
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Add a module which includes helper functions for dealing with Cseries
objects.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/__init__.py    |    6 +-
 tools/patman/cser_helper.py | 1524 +++++++++++++++++++++++++++++++++++
 2 files changed, 1527 insertions(+), 3 deletions(-)
 create mode 100644 tools/patman/cser_helper.py

Applied to sjg/master, thanks!
