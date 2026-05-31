Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BD5CD6E51
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 07:02:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A299838D7;
	Sun, 31 May 2026 09:02:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="APN8rf3e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CE7C83DA6; Sun, 31 May 2026 09:02:07 +0200 (CEST)
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch
 [79.135.106.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E0FF8039B
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 09:02:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1780210924; x=1780470124;
 bh=rddxZC8vtHfLxUkml4w4z+iG75bRD0cix6gSYkmmY4g=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=APN8rf3e5FY8GBrH8b6iKeLl7LpqJt7Th4f5pqfBkUXuKXVdYmOr5ZQKP7YFsr56j
 9Ty4uAFvQL+ezt5EMC/14YHOllDOcY+YVVazEFrH31C9qhIrA4Z8ePY9JWFFYebc+v
 SdNG1sMqxXeIhylLY2YvqXur+X3Qsk1rb5giqvW9AFaMzU7IP0S78sCmLQIA1n4W1Y
 PD3JyaBX8WJ2FLq8StJuEOHlUwLFx5CpHDg89uSest5pUzlu04LvNs1sHc3k8s6QoJ
 ml0DpXME6/GjC0Ad0eyzjx+IxN3xLCQrDloX192XaMJhADhxmj9w5lPT2CJnOq5aaq
 zVA8yUH5cqP3g==
Date: Sun, 31 May 2026 07:01:59 +0000
To: u-boot@lists.denx.de
From: Sam Day <me@samcday.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Sam Day <me@samcday.com>
Subject: [PATCH] usb: gadget: fastboot: avoid stale IN dequeue
Message-ID: <20260531-dwc3-fastboot-fix-v1-1-1e4fbfd476e8@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: e825753e054d07d9dd6a4955fb88f3fdf8a3b7de
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

This usb_ep_dequeue line was originally added as a fix specifically for
MUSB UDCs.

On dwc3, it causes an error like this to be logged:

```
dwc3-generic-peripheral usb@a600000: request 000000016e0862
c0 was not queued to ep1in-bulk
```

The trouble is, this causes an infinite loop in `fastboot oem console`.
Every time it flushes out a response with a chunk of the console, it
triggers another instance of this error, which means another response
must be written, which generates the error, and so on.

I'm not sure if the MUSB gadget code still needs this workaround, so to
be safe I opted not to remove it, but guard it with
CONFIG_USB_MUSB_GADGET instead.

Signed-off-by: Sam Day <me@samcday.com>
---
 drivers/usb/gadget/f_fastboot.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastboo=
t.c
index 8df0e3f331d..fb7e47401ca 100644
--- a/drivers/usb/gadget/f_fastboot.c
+++ b/drivers/usb/gadget/f_fastboot.c
@@ -406,7 +406,8 @@ static int fastboot_tx_write(const char *buffer, unsign=
ed int buffer_size)
 =09memcpy(in_req->buf, buffer, buffer_size);
 =09in_req->length =3D buffer_size;
=20
-=09usb_ep_dequeue(fastboot_func->in_ep, in_req);
+=09if (IS_ENABLED(CONFIG_USB_MUSB_GADGET))
+=09=09usb_ep_dequeue(fastboot_func->in_ep, in_req);
=20
 =09ret =3D usb_ep_queue(fastboot_func->in_ep, in_req, 0);
 =09if (ret)

---
base-commit: 30b77f6aa146c96b831cb4ece038130b655b6a41
change-id: 20260531-dwc3-fastboot-fix-4f345f8b65dd

Best regards,
--=20
Sam Day <me@samcday.com>


