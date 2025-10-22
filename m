Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55352CCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 17:26:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F5DD80422;
	Wed, 22 Oct 2025 19:26:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EdJnkWyi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ECEB833F6; Wed, 22 Oct 2025 19:26:20 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 437D48004F
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 19:26:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-443ac88ff96so1434760b6e.2
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 10:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761153977; x=1761758777; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yTsP0NdqvJ7U7DbfTpPoF8XgczivzwEGFSISsQIiQzM=;
 b=EdJnkWyimDLacC+wHaxPklFo0wKUyDukOFkLG6C0KcOD0OiB6A5bebW2PZznXrUp/R
 5AbvG7HS5CBw2pQRd+Rjw+ZUNZ1+CwtfD6+hF+66X56+UatABDviIc9K/pDtrSpf6LEj
 3uEuw+aimmH3NlD6CA4KRdL9W2DMKHh8fmV9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761153977; x=1761758777;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yTsP0NdqvJ7U7DbfTpPoF8XgczivzwEGFSISsQIiQzM=;
 b=ZeTux4C6FMkBMzoB7vYDfDxweHdON54hNpm9FgOtY7pZuQLOcryUcDsoq5Gm8/D4V+
 o+KIvIN05lYb+FarSSl2D3n6JBjTnG7xTG75hkp+3QM8RPz04b6kdgz5nkWaPbEqBx/1
 sR+Y/8UlPAQhR1DCztsH/pvniG0BDN0m2UKbh2j4oHWGBVlsd568kvntGCQldbbhhZ6a
 9bMSwfwCCJEABmLNT6ymfobVqz548pgFFDpS3U5wei6ox8ltNao6018LlUZg/cEqHFUt
 64WbWhK2QyEMaCVlP7gQwWUiCkhGmUR89qkwvXtmtM/GHnIWqKvVNQYQll8ikyyz7AXn
 8tQQ==
X-Gm-Message-State: AOJu0YzUaOO6qQh4Peb4Zn80JfeoG/qiUd167PGPz8WAY81mtybPzAH0
 D87n2gqm3VnNdI4Fd25GZnDxH+nLZjJG2I/tK6TrrDD9jnC4PHk5erQ94jvT7hREKpA=
X-Gm-Gg: ASbGncsO0N7bsoKynaeOyxEWCT14su82Pvu4yl1wAKP1SP5BXh6r9nmzbsQ2NsuHT6J
 ULHr3XN0t7nt0zDf3K85Pdb6qnWqU5jNbBJUecI0BEYc028vKQSNRaUnEq6mgaOjJPfTiwFe93u
 dQgrXzvQrw0B1uKizfeSPqWaWQC3C2Yrbwv7KCiMwNclZ4w+Q8anFeHhW+ugh7xMQp3huxSQiGl
 JBda33htdUVfoCz7OaOWRg0QSI02hw+5QyhwdNxgXxTtx1nieNwDxIqAPvCxdzVRrpUiD8lUP/w
 HuUWejmFlr/ejfItipgTKd9UalcOxf25HrYlVQ2eYXM34IfBBU7IewhM277c/i3KOvJ97bZrtlw
 FMVj9XbsIdC0ZuPlWhd8OA1Oe6FFOrcdEDe722lXUlHun0YfVMbw0YmVVM0GjEdjtd3VyV0iDxx
 DuMPvTEKjM/rGFEQaWXZDlLB+BgujMStyNON9pN6uUuWEXnfA5PAc93rR9OKU=
X-Google-Smtp-Source: AGHT+IHAo22A7SwMxI6Hxkf20V1a86XQiXsYswzi51SyYTNyUgF7/DbDyFJp6Ax++3JPFTGyjj/gbg==
X-Received: by 2002:a05:6808:1929:b0:441:8f74:e7a with SMTP id
 5614622812f47-443a30144a0mr9002970b6e.52.1761153976860; 
 Wed, 22 Oct 2025 10:26:16 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-443df20786fsm3453493b6e.18.2025.10.22.10.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 10:26:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Chen-Yu Tsai <wens@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>, linux-sunxi@lists.linux.dev
In-Reply-To: <20251020145527.2702250-1-wens@kernel.org>
References: <20251020145527.2702250-1-wens@kernel.org>
Subject: Re: [PATCH] .mailmap: update email address for Chen-Yu Tsai
Message-Id: <176115397535.1634412.1042663139010164553.b4-ty@konsulko.com>
Date: Wed, 22 Oct 2025 11:26:15 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

On Mon, 20 Oct 2025 22:55:27 +0800, Chen-Yu Tsai wrote:

> The email forwarder I'm using has run into severe problems with Gmail
> lately. Switch over to my kernel.org address.
> 
> 

Applied to u-boot/master, thanks!

[1/1] .mailmap: update email address for Chen-Yu Tsai
      commit: b27705b9094d349882e6c7411c325c9308f68e63
-- 
Tom


