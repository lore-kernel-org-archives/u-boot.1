Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3580F94CA2
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 01:17:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6761C839D5;
	Wed, 22 Apr 2026 03:17:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="huUKqT7u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74B5A8426E; Wed, 22 Apr 2026 03:17:23 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EBD0805D7
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 03:17:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ba60d78aff3so486644366b.2
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 18:17:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776820641; cv=none;
 d=google.com; s=arc-20240605;
 b=JzEmBcti0SgYBtI6YuuMxsT8pG6/fXInE/n+LRTS49NQvVXDIxkyzabZYXRi7BtbVV
 SxP+7vV5Q1lMEYmF4jDhXiOafxva/EfEqhlNeiXkOm02eNuFnkxaBXMX4bTpIjtcqVG4
 iacezRz9iQFcLSVOv6hvTaOIZLQfA7N8IgPuHl+RHIsZxhU/w6jAwY0nOi2lJj8fz7VX
 JwmT614U0T0dRON+uw43vli/agLe2Y84o0cQUI9dhXu0kEtO7HZYHya8peKjequeOKBn
 YpgXPAeaitoBYGvkUYgJKlwzJhfSR2ADh0aAJCYOabQtrQppI0k3pRS0nzJUlnokCe4d
 I+6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VQhZaJqXWBEvrAE0NS+3kCvZUPYjXnGDkLQWA7Mr5VA=;
 fh=Iec7j3EFBSfgazu61KsEkytLnSv/ErmdIw9e7NJDej4=;
 b=PTVktJB5vDm1w7234RS9c+Ng/1buVS6DtWslsnBTDMb4aFSYj9neSVH80gM01dCJIQ
 YU3Wx7K6+jW1480DelY1OIIc26KyjHsyFGeMd7yNOsP4LdX/QMwvksgQW7l6V96wYX4M
 9rl682S+h3JJMDjUP4HwDYcuPkMheadL8ga34h7LcNXnpAXPSNUzeW662+V0+u7XZitp
 VBC+2Ab0ObFJjjO6CEGRVCS2qG+0Z1oEoDVmvJApKYtaSULo8zz0Zet2QsHbj7nATFkw
 h/NBfBoChhMqrGn2S5B6j7xxM8pkbWOhpJdREqfXzNo/CmGQIWjXtRHSDVkDreHvyKSg
 vj0A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776820641; x=1777425441; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VQhZaJqXWBEvrAE0NS+3kCvZUPYjXnGDkLQWA7Mr5VA=;
 b=huUKqT7u6my8jIzHFy1t+rwhyBvsMdeT5USGdTtfSI9ITN4LyrTBfA2h479eE6R3iK
 rmyPFF8I1Yxu4AVMMo8xr0QxIouX4cmp1Noz/nfw1LfO3woTRinI5T3Hx4kHaqzY2U/n
 THLqEASewbDDffTY7ajSLbmAET2OjQZMgrkmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776820641; x=1777425441;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VQhZaJqXWBEvrAE0NS+3kCvZUPYjXnGDkLQWA7Mr5VA=;
 b=ll428U2/1uSP0TLL6Xq+RYZi+6FzcMpe4UMKR23MHYDXkhbESFLl6iUf11W4xQfX8b
 omTJsB7HHN4wlH5ehXuhe+INe4jYURiACfnYK+sqwWpyVULqGdeXHCntbedM7ICs7RYF
 8pxE+DXxw3Xpe4ZouXR6FweH0KMJuPVSdIcalVnfH6UaUcqUmYV4RKhDyl6jtJfOXhly
 PCcru1+ldTHO5Agw5mibZjckQS/bpVZ6GO7E3tqJojz9dEWwWRDnuawtXbJUBmMbG71/
 2jkC2c1gHKkC4E79hTZMrFM0Dzr65Xq/uFE7kLK9/DVNTmgOaTsyojpKYCV83sleF2LD
 /oXg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+URJK+kTRuTVnBCZQxTOMAdRp9NnEuNc/+wnOh04eMkGpQ+2wcL7R/HG5FwkPYKwUXIzPjBOg=@lists.denx.de
X-Gm-Message-State: AOJu0YyM3M7wE9eUlo9YocKQBopEEm3Qw68M9yDMVWqGy5eOLrr5kJGF
 0OIRMtuNwtrqrYPWqiv7yqeOF/1l9lpOd1PMnFKitDgA3S2a0O9eC6KmxHO87mGKNlX0L58uwE8
 J6lpHqIaF0qb1y5NzOx3mifdWWNG8yrUZpRkaeZ/3
X-Gm-Gg: AeBDietGPQ3F4A2MWYBIc35PTR+flO/pGFa0ZDWj09x07rcXOSUO46BZpjQ6J9NAKyO
 4oyk8itsHkRFhvD7ScLSJtmyoDJ8BHGmXMFn7eSDAu8dSGIxzz4zB/tlHMqjOAnx0/9QWeWXNz1
 mnwuvECy+lHh9hxncMLO0ZAxbAtVdNdwrL199sk3o/WMF05up0Mu3VVRPvAPra0WNTb8zNTqtXy
 4IgG6xGfEsFLhBu5t3/8UGK026dEB6fXOjyCwgSzkC7aeuzOmlVF1xazsrpoPI6vVdk5OOLhW2w
 OFW3joKJDMmt3o10zA+c
X-Received: by 2002:a17:907:7f94:b0:baa:3cf6:4f53 with SMTP id
 a640c23a62f3a-baa3d0598e6mr186389466b.5.1776820640944; Tue, 21 Apr 2026
 18:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszThBjowUW_CQJ9=_mGoo09sApZs-61CGiuoSn8Li+sPBmQ@mail.gmail.com>
 <20260421124008.5492-1-jcethrid@gmail.com>
In-Reply-To: <20260421124008.5492-1-jcethrid@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 13:16:51 +1200
X-Gm-Features: AQROBzBY-ugBvrZzvWAXJxDh-aQjKgXFz04pILoSohitaKtWJNNfdf5r6wCt650
Message-ID: <CAFLszTjeZgWvTeBPoV9d2fgFzMXL_P9eFNJ+ws2NWT25PB8OCw@mail.gmail.com>
Subject: Re: [RESEND v4 09/14] mach-sc5xx: Update image load address
To: Caleb Ethridge <jcethrid@gmail.com>
Cc: caleb.ethridge@analog.com, linux@analog.com, malysagreg@gmail.com, 
 philip@philipmolloy.com, trini@konsulko.com, u-boot@lists.denx.de
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

Hi Caleb,

On Wed, 22 Apr 2026 at 00:40, Caleb Ethridge <jcethrid@gmail.com> wrote:
>
> Hi Simon,
>
> Yes, this does change the location of the fitImage in the SPI flash.
> The U-boot environment before was stored right before the fitImage partition,
> with it gone we are moving the start of the fitImage partition so there isn't an empty
> hole in the middle of the SPI flash. I can reword the commit message to make it clear that
> this is the fitImage, I believe that answers your question?

Yes, I see. If you think a wording change helps, please go ahead.

Regards,
Simon
