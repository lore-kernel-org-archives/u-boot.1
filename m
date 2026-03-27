Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F202010F2865
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 19:15:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EE3E83FA3;
	Fri, 27 Mar 2026 20:15:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=iki.fi header.i=@iki.fi header.b="DjNIyO5T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D03583FC6; Fri, 27 Mar 2026 20:15:41 +0100 (CET)
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74CD183E7A
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 20:15:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marko.makela@iki.fi
Received: from kehys.lan (dsl-hkibng22-54f98f-8.dhcp.inet.fi [84.249.143.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: msmakela)
 by meesny.iki.fi (Postfix) with ESMTPSA id 4fj9Ms0d39zyWr;
 Fri, 27 Mar 2026 21:15:37 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
 t=1774638937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vJMxlJPmYbsPGcd0Q+H7br6HlwRVfl9jhvqP0T6Fweo=;
 b=DjNIyO5T81DopOc0kTrJsw4g4wLcmmPl2Py9wDTiPNzQR7/4lZLqljVRsAoEaOmOT5hX0Q
 70zafVkWXN9ZT9peDVFrDPLVopVAb1kP9FD66cdTOXUkEkFo9gXJk0X8zxFY+cVh0QuEEh
 i5yoM/NurcP56XpEIxdc8lV2U/cAP1g=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774638937;
 b=LbxagAEgtddhgOQiKT3M8XWSE49Na/P25INpi4hQZ0eCNhfCSAG8JPSODwbPMKxLbGN5/i
 u9+Xv9HyQciiEZS7T/6wZxy4F/9EeIN7PxfrlKf2PJmWUgi/KCWfN7vwU6UxK/TcqChV/n
 3ZXLMtSc0YCTf9MnD8vhiPycr43bkl0=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=msmakela smtp.mailfrom=marko.makela@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
 s=meesny; t=1774638937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vJMxlJPmYbsPGcd0Q+H7br6HlwRVfl9jhvqP0T6Fweo=;
 b=n+Kkil9JzkyvNGULBdLN+IOFxVaamLXj1CrMH1tl2PfERwZGXoQHqS59kczRR02OpYDNx3
 FpTCOrbuHAxYiKk11hAVqRZoy6pDFjPRZq7OtJWbRGloqSvYgncS6h9rJPBqGl3d9dWIA0
 KbYlsvUlhIh8XzRLZ+lhyhmCNG3Ffvc=
Date: Fri, 27 Mar 2026 21:15:35 +0200
From: Marko =?iso-8859-1?B?TeRrZWzk?= <marko.makela@iki.fi>
To: Robert Nelson <robertcnelson@gmail.com>
Cc: Randolph Sapp <rs@ti.com>, Erik Welsh <Erik.Welsh@octavosystems.com>,
 Anshul Dalal <anshuld@ti.com>, bb@ti.com, nm@ti.com,
 trini@konsulko.com, afd@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] k3-am62-pocketbeagle2: add initial board support
Message-ID: <acbXV--BvxNuZxEa@kehys.lan>
References: <20260317223800.776581-1-rs@ti.com>
 <20260317223800.776581-3-rs@ti.com>
 <DH7I5D8U3GQX.1NAV7HTPAAJ8L@ti.com>
 <CAOCHtYhr50ywU_ar6qFPYrwJeUbjE+GQC_OYO_W4Pc5A9iJ5-w@mail.gmail.com>
 <DHAEYEEVEBW7.304SKN4GDBP4B@ti.com>
 <CAOCHtYgan-p8PiuwKCPmDY=xaKvnGc+F1OZXgyDHFGg4F9NJ1Q@mail.gmail.com>
 <DHCAJ6L5XC77.9F2NK2OOEAT5@ti.com>
 <DHD3N5DPHPVI.159WWX3H4U3Q3@ti.com> <acaTPyGbaUQj7hk3@kehys.lan>
 <CAOCHtYidPpJMZeDj0KkLkuh6YYOFVAe80NMWWu5wbmV2ou+=UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOCHtYidPpJMZeDj0KkLkuh6YYOFVAe80NMWWu5wbmV2ou+=UQ@mail.gmail.com>
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

Fri, Mar 27, 2026 at 09:53:03AM -0500, Robert Nelson wrote:
>On Fri, Mar 27, 2026 at 9:25 AM Marko Mäkelä <marko.makela@iki.fi> wrote:
>Marko, here's my last wip, before Randolph submitted:
>https://github.com/beagleboard/u-boot/tree/v2026.01-am62-pocketbeagle2

Thank you. I was able to merge it to the current master and build it, 
but that of course does not guarantee that it would actually work. I 
guess that it wouldn't, and I should for now try out your branch as is.  
But I did not get that far yet.

To get a somewhat predictable starting point, I downloaded 
pocketbeagle2-debian-13.3-base-v6.12-arm64-2026-02-12-8gb.img.xz on a 
MicroSD card. It booted straight to Debian; I could access it via the 
USB Ethernet and /dev/ttyACM0 endpoints as noted in 
https://docs.beagle.cc/boards/pocketbeagle-2/02-quick-start.html.

Can you help me enable the USB serial console, first for u-boot and 
subsequently for the Linux console? Would I have to hold a button while 
starting it up, or would I need some special u-boot configuration 
option, or remove one of the files so that the autoboot would fail? Some 
months ago I used a phyBOARD Lyra (phycore_am62x_*_defconfig), and it 
was a rather well documented procedure with that one.

Best regards,

	Marko
