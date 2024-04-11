Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E05C4345F
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 23:36:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDF6C881FB;
	Fri, 12 Apr 2024 01:36:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="BtICKbaK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27071881FB; Fri, 12 Apr 2024 01:36:18 +0200 (CEST)
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ac])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF725881EA
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 01:36:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
Date: Fri, 12 Apr 2024 09:34:39 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1712878573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ds2YimnXWivPY7YuShg8faqFqYAXpqY7gW4LYGKRuC4=;
 b=BtICKbaK2CQu9ZuNDPH4HLLM2f1HcLUGLS70fHuO6ZKxHSvaRFNOt0ZnsIPuVTvvuaCKDt
 GhTxSby+ywMQtqQRFdy13hcAmJ/msYCOxdlw/JJaFl5tz/NT4JWScEwQ94RU97/llmjfTo
 4fNclDY3mjYBKD0kcERvz32QKISM4R12J6akxd/gKkRegHQU6Sp8xcB0ZNAwugIy985TW0
 I/EmPAJtTJXijDkM5kop0BCUmzNKconzNpIXp0VhvntZLh93smfNVaVFZposNorX7f8Qzp
 DtL5t1DtsYpckMtWwChAmblDYCF1DUxnUnJppj038bHk7OidDsFz6eFRhaN52w==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: John Watts <contact@jookia.org>
To: Sam Edwards <cfsworks@gmail.com>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2 0/2] sunxi, usb: UDC/DM gadget model support
Message-ID: <Zhhzj_WeYAlzIHIi@titan>
References: <20230608195631.55364-1-CFSworks@gmail.com>
 <ZheG8J8h-X5GPdwX@titan>
 <CAH5Ym4gEJi693VRtrdgQAUmqQuQCCmQ1ASYJofQw92M6nBHyXA@mail.gmail.com>
 <ZheThnKWQJ3Zah-t@titan>
 <CAH5Ym4jgSbRsRQF21LbuQAft6-q5i6ssJc21p+S1qXfyme0mng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5Ym4jgSbRsRQF21LbuQAft6-q5i6ssJc21p+S1qXfyme0mng@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
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

On Thu, Apr 11, 2024 at 03:53:51PM -0600, Sam Edwards wrote:
> Hi John,

Hi Sam,

> Ahh I see the problem. In U-Boot, `ubi` isn't actually a block device:
> it's implemented as a stub in the block layer, and the filesystem
> layer redirects `ubi` accesses to the currently-mounted ubifs instead.
> But the `ums` command works on the block layer, so it's not being
> intercepted, and instead hitting that stub and likely crashing. In the
> spirit of the Linux ubiblock driver, I have another patchset[1] I've
> been working on[2] to expose static ubivols as true read-only block
> devices. Note that this only works for static volumes: the access
> semantics of dynamic volumes are too flash-like to support block
> device access, so accessing them with `ums` likely will never work
> like users expect.

I'll give a patchset a test when I can.

> Still, there could be some interaction issue between `ums`<->USB that
> I haven't identified. Could you try with mmc (if available) or a
> ramdisk (otherwise) just to confirm that `ums` is fine?

I'll try testing with those if possible.

I did find out that fastboot actually works, and is much, much faster than DFU
for some reason.

John.

> 
> Regards,
> Sam
> 
> [1] https://lore.kernel.org/u-boot/20230812000606.72319-1-CFSworks@gmail.com/T/
> [2] Not very diligently; if you're interested in helping test it, I'd
> love to get back to it.
