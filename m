Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A364D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:12:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6DEF8906D;
	Fri, 18 Oct 2024 01:11:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fhw3bFjz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3272890C4; Fri, 18 Oct 2024 01:11:41 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22907890E9
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:11:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6c5ab2de184so8505806d6.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206697; x=1729811497; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hqKuvWVklwpZXoOShw7kqYpia1j3PNzt4PQXpAz/8pA=;
 b=Fhw3bFjz7YGX+G/ckGWE1t9Zfnrog5d/kc5xXCVC7mI6OzZatCAuPZN/bITHWyLrj5
 c551q1dVBp+DZOOuGpDBwpFNWvLR32whx/elB6I8dA+OnlO/312qAe6pT2Nl/L8/Q8sd
 4xZxJ+8wybs1GkzwZpi7Ax790UgMEnDnZlFzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206697; x=1729811497;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hqKuvWVklwpZXoOShw7kqYpia1j3PNzt4PQXpAz/8pA=;
 b=pIAwbRqDJMqDRfcwJa5fvu5gTq6VxWk5ny8nXuv+p1lM+ymjLwZ+1QpLSUB5dgyKU9
 F3PQX4/HXJ6Tnqo2iYtNOF+fNiDJvYPn52kf4a9Cbuqyjrz8ULtCWZPCd/S9FL3+d98N
 If/d9hD+BuJ5ySUyLlhaPMwnOrWps0Q1YPTP9suTRVTZfk2u2UYWtR95/h8a+6oB9l9X
 6KyV98dfo5Uq2kt2tZmRhNro9o7kLTQyDFWLS3jqd0tPRNywmMDNPoRvqOfIIX6FLTNO
 GxbPDBLFz0k9F+dajtmePM/FpiyOjfeRT5DpeURtAsRoCsVAmflPE7GIEwy3yxEJW8Fq
 1r1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuHUPbThjGFi119RzNCLIPjmaHk0haBi5BGjFRDrD9OS7yy80ijxWOnLBLSyyo9+5vouZxFNs=@lists.denx.de
X-Gm-Message-State: AOJu0YxrdYc973CB9fbZb8PLUsb6Dks0UeuQUVfuCXdK5Ip7KNSJwDry
 AfyXvfp7vy1/cYXqRrp0lcPLSJdZafAvR4nUS6UvnW/jGBXxx0fR9zO8ISupWMLq9OoKgs9m/WC
 NKI31S1A1jj/sVTjdKdaswJWz1ReGRdRygtW3
X-Google-Smtp-Source: AGHT+IFLk6v9vmkXT1IjUUdi16YWMqWTz4Nbr13PqJxmEZRu+hoMHNvUU9rKUXgT3bsmyTiZYlrIBOvDUZOmV01Ce0A=
X-Received: by 2002:a05:6214:3c85:b0:6cb:f9aa:9726 with SMTP id
 6a1803df08f44-6cde14b833dmr5027486d6.11.1729206697046; Thu, 17 Oct 2024
 16:11:37 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:11:36 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241014223212.2212442-8-sjg@chromium.org>
References: <20241014223212.2212442-8-sjg@chromium.org>
 <20241014223212.2212442-1-sjg@chromium.org>
Date: Thu, 17 Oct 2024 16:11:36 -0700
X-Google-Sender-Auth: R1hfHfiYq_GG1P0DQJ8U9iKtgI0
Message-ID: <CAFLszTiJBzB2rvCvP8PEX=_r5GO3FH_MLZoSmOuEANx6vSWzrw@mail.gmail.com>
Subject: Re: [PATCH v3 07/20] expo: Add a little more cedit CMOS logging
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Add some more logging in the CMOS read/write code. Tidy up a few
comments while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/cedit.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Applied to u-boot-dm, thanks!
