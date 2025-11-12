Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35FACD342C
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 16:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0248D83CB8;
	Wed, 12 Nov 2025 17:35:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OVX6nhZp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62A5A83CCF; Wed, 12 Nov 2025 17:35:19 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B8C483A94
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 17:35:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7c704bdd57aso508609a34.3
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 08:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762965314; x=1763570114; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0TeWXRHm1BaKRRYtk0N4YNVhMJbXUKNmVcucziux+e4=;
 b=OVX6nhZpIEdSmWs73VDS9yYBtji6leNhH1B8gR7VQweYu/iPRpr7paAszlHKEN4HJp
 axMo6msg3naocrtpK+uyl1uR5Y7M91+9z6zCkV49YeS9Fx+S7ZmY9WXYJOWwFzewNqdN
 xbYF4HMVC9W1Yqsj8xXy8Ih5UnlFxQIiij8y5+3F7QVaMx/4lydCyoOYwrQEB9RF75fe
 ZNgG/B6r+Fany7SUMXOp/a7PP3FGyWKjWafwU4TXrfqMPxmoIuk1JU0niTFUswUeLSXu
 7Y+GwmNDOLhLeuuzA1Y0oGzUUNGKrFy4LuQp+9hC3qIZEANjerIZAdO4zG8ura4mP9f6
 dSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762965314; x=1763570114;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0TeWXRHm1BaKRRYtk0N4YNVhMJbXUKNmVcucziux+e4=;
 b=Z/HWTK9lJrqKZvuPxkpoNRMxdZDnAEQ/b3/jxsjw780ehpQTFzQdk9fClMo7UmSaZw
 B/JcCnRR81pT0RiCm9ShqsvO3PD2xk+Um7J9Z+5zsGYyIjcgM2oTDalwuCM9l0TWTGpa
 iHerD273ywlyVNv3j9JHrTbjpxV1OXoNEev+4yMr99gdUGMu/vzsx1EivSHIA68yHoXE
 Tn34PiW+W2Jqzj1UYAzTlhPZyJBDt2hSIqljt5hkfBCtP3lzNZcRqE0CRzTUoLf3N8F4
 ue6bcMDgToiUjMQB/6rrIHoBh6JSwgzvH9pg7Sqbol1XT/mOL/iuLyDmiYXpcJUO9T5T
 TGAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+n+OUNE904C5xzBhUxoXhZhttXnKsoQdzgxA2IZ96+lXJvRR462bxcO/9M2hWqSWTGQTOVnc=@lists.denx.de
X-Gm-Message-State: AOJu0YxNFBhMaua1F7hRHTd5cjphrQDcTUxS6xaVFeYXOErSlpYtw+lt
 Yvd2ggMMR8DWuzXjfMCcjCsp0w7NBj4AbKv7WPJvgNoL+aSVzTDy/sQCFOxQOGB/CH2/f3CWsC0
 jJWJIAEngKJ7WiXgXgjWPBiQJGZHqqaxwbfas
X-Gm-Gg: ASbGncubYYBCRJ0dXkXFMsS4eA5MLD+aPQW6amiYc6+YeZhm+06tCC/enVQEgoN7VQ5
 EbLxKHEmqCvxYXYGQ1fVCIQa+amJt8SEacFvCN8uWmdfuy/xS4Djt6h+8HuwC6uLkdiJcEgmYRD
 7QSuA696yeAglaj8qAZGl/yhVcuRj++AxXKIV4Hmw/vU/O+sMXi4u/w+t9EjZud3o66+SJtoHxO
 QHlwfiZ1WCOUsk0gi/JMin/nA1OO5eTMr32leVyOIqETDf53jETj7l/CgU9gw==
X-Google-Smtp-Source: AGHT+IH3MWKJwWpgtc+9z0TKdgN6AiYIxuolZqZc437X/e0P2DRt8LLwexevLH+uqP/BQFJ3zwYSId1x5afZhYbOaiI=
X-Received: by 2002:a05:6830:3147:b0:7b5:6246:833 with SMTP id
 46e09a7af769-7c72e1f2dd0mr1781745a34.3.1762965313995; Wed, 12 Nov 2025
 08:35:13 -0800 (PST)
MIME-Version: 1.0
References: <20251110050040.183-1-briansune@gmail.com>
In-Reply-To: <20251110050040.183-1-briansune@gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 13 Nov 2025 00:35:01 +0800
X-Gm-Features: AWmQ_bk91r9S5VAEYpKdMxi9-NnWSIDxqrZB9sdeJg6UU4KdS8sKqd3wGc4cuwk
Message-ID: <CAN7C2SDGh+PZaP2DNOhn3=D9Stw680-7k=Tus_+2r9UQYoAOyQ@mail.gmail.com>
Subject: Re: [PATCH v1] sync socfpga common u-boot dts
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

> The dtsi for socfpga common should
> turn on L2 and memory and no reason not
> to do so

Hi Tom,

Do TIENFONG still handles patches on SoCFPGA? Seems like there are
no action or response on all SoCFPGA related patches?

Brian
