Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A972CDB479
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 15:02:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CA0F849EA;
	Tue, 23 Jun 2026 17:02:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c6TXT9ps";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46871849EB; Tue, 23 Jun 2026 17:02:06 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E0FE849E5
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 17:02:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-697ce8cfe65so2755582a12.3
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 08:02:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782226922; cv=none;
 d=google.com; s=arc-20240605;
 b=DGcsNvzugl58CIV0KPLxx4cu4j12BS/lTVGApXOZ10srLKYMoY/H+G/RHXZssknxrZ
 mh9td8yHwz0fwJWFelwNcZym1ii9prKq7Gx5ThLq63Yfg0kR5x0oaOkyfsxEftlMobw/
 gMkei3akP5ubRskFhokBzXJJky0wgXxFBSeMAT1BOOVixF+XPQs61d8nMkB/DfBJscg6
 Lpfi2RF4CUrSJe36Lsn33kVN5gL9EegUQZAfcwpAI14a+M0acGjxof+ZqYFSvUdACkkQ
 bVuuPMks5bB9mGKBGOukQqsARBY+/5uhfMvtpvbqmsXm7lsk5lLjrJ0R9oyqmbpwcMJ1
 1Xdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2ub3mS+uLLA9DDklaQX1e4rVNj9IbgeNbKBXFkAuOXw=;
 fh=PeEydQ2hvwtp+1/k8K8imEwfaH20KPrHght1b4v3g9w=;
 b=hL8XojNGhsNyCZP3NkZv1K/TvKHXIokIUPWlgQwo7D3BwFc6E71rkAKa2PvMeFCfOL
 PKRhXSrRczodXQwPkTMzQqt/t9gG4ajLuaT2avyWa0b5gTVyZ6FJ6IlEs6ABrdaqa0p5
 77DvzmlEb/HdADcKoVQoFJHHdhUkbfs3i0tcZEncusOcI1ayOtYOZqIP7Xvibz2KWxdf
 9piDNV/EHruVp4d0ut1eFC+MCgwoTZ+K42GMTaBqR3FMHYaNtEEp8ADNgrmSmr5Ql6ix
 fK4fv3MCJ/3k4QT1gKTRntjfbigmm3Lb9qEubE4aVRzS0wNejOu5B5k8Q0vxe7/a7+x8
 UdLg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782226922; x=1782831722; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2ub3mS+uLLA9DDklaQX1e4rVNj9IbgeNbKBXFkAuOXw=;
 b=c6TXT9psIAxtoInc6QWzfoIT8Xc5nKsl81erIY9yhFn1GqbcutpHCpwOdBEvqhbBY6
 bs+wSsGWSwSyxLhhLVark6HTM2uGYQ1ncpXVe3vjMrGYW3s4IEoGXs7lnrUEDBNVhKr8
 ZpCCJCBFRmRgEr0w/rLJO54UG8aFOFXqeijPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782226922; x=1782831722;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ub3mS+uLLA9DDklaQX1e4rVNj9IbgeNbKBXFkAuOXw=;
 b=OiWlV73pXk4thHRAmCHyZh4WTGwIdra7XCRvQFfEjXx9F5n/lgpRQo8w7HZmIiOXui
 jumDQOwixyZpYUBk0q465AdpufgcHcDo0xMXB7DSCBpH4N2uAac/t955FjGv6uFkx4/p
 0eMOwbItB9zVAWnxuVH6Nq0NG9NRdCRSv3R0RUF8ow3NFb6blBwZ5LvJBaux+9raQnfq
 XCj/RsvJs0lzMwORVINia8981omfSEFGTmqpOrmb5Mx+wEn8HS9MLlhgfSUx4oz1yQhH
 wXFzgKItTkQXwZ6B+SuUhoY8PNMf0d0omdCFtEgfdqp9uIIMXobgMvRzXRPHxm5Tdnx1
 DDdQ==
X-Gm-Message-State: AOJu0YyM5lCReGiYQPhqQE1I4ZIYozUqo1V0bzy42vkDCpsOfAvu1M3v
 YfvwGbVsBXsWXXrNrXVN8BayS06VYwSfIYc5y2dhHe4hHTmN2SARWUnKmqUGn4Bx9OB23m74DsY
 SZ6mzesK3388d1VLfwJ7HXHMkM3C+rbKZQxM9niaonPuCB3WqeCpxPA==
X-Gm-Gg: AfdE7cnwIqGwQOgJGvmSkF8izXMQSeOu9HTICgSYW5VtPhJGa3wDDAU+t2EyYqpTlII
 iN5kOghITZ/w/O2faqcOCh7qtBamBcC9Q2o7HJvZdZ4KeTdW7taDVtmYyEtWBgwdbKUcsj5m57n
 smbXdrG/d4q/0/BXqK8iDOZgVfE5yT3VIDlEJuIRO/lY3HZ2al9CyG8NNrIDdMkaVBunWWBfFd/
 3uZkWjQf6HthKLQEtq5NmgNZujCsa4HpqSZ8QGOWwhNVjAYQRtbwyje7W8fxgiJaJLIzPB5fg==
X-Received: by 2002:a17:907:1998:b0:c0d:ab45:a070 with SMTP id
 a640c23a62f3a-c10901da8d8mr177774066b.35.1782226922095; Tue, 23 Jun 2026
 08:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260621143938.2863-1-aristo.chen@canonical.com>
In-Reply-To: <20260621143938.2863-1-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 23 Jun 2026 16:01:48 +0100
X-Gm-Features: AVVi8CfY0D0cU2RPwxHB30E9ul7A8lZ7d09H75OLea_cmvXTtjoHpj7PQHJLyB0
Message-ID: <CAFLszTjaFQL2jbAdn=E44iz1OHN=1PDEne9m+nwvRMHWA3y+bQ@mail.gmail.com>
Subject: Re: [v1,
 0/2] vbe: bound FIT external-data reads against the firmware area
To: aristo.chen@canonical.com
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

Hi Aristo,

On 2026-06-21T14:39:32, Aristo Chen <aristo.chen@canonical.com> wrote:

> One open question: should the external-data blk_read() in vbe_read_fit()
> also be deferred until after the phase has been signature-verified,
> rather than just bounded?

The bounded read is the right first step. Deferring until after
verification touches the SPL/TPL/VPL call paths and the bootmeth flow,
so that could be done as a separate series.

> Patch 2 adds the missing range check ...

This could use a sandbox test that gives vbe_read_fit() a FIT with an
out-of-range data-position or oversized data-size and checks it
returns -E2BIG

Regards,
Simon
