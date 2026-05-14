Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF4ACD4851
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 12:36:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CECF83FB0;
	Thu, 14 May 2026 14:36:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="f3h83iNU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AFED8407D; Thu, 14 May 2026 14:36:07 +0200 (CEST)
Received: from mail-dl1-x122c.google.com (mail-dl1-x122c.google.com
 [IPv6:2607:f8b0:4864:20::122c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C87083AA9
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 14:36:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-dl1-x122c.google.com with SMTP id
 a92af1059eb24-1330d6bb78dso4646679c88.1
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 05:36:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778762161; cv=none;
 d=google.com; s=arc-20240605;
 b=aD6TkGBl1blWXF7gla/3gjAGuqCnSQn28HNnETh53vMhePMN+Jxoc1/gUpeo3knNUR
 V0sIlCzK1LbSEQ6ovqWE35QQ+6H51PAacuyrNofV0UctwlZu6+U2h+ArgR7Wu8X5P9U0
 3zrYgRJN0W+0DQ2kS5afst/iaSUiI0FPIVM0mMnP6/TMaYNKm1bObCyPlz06uXMDC03G
 G19vF0wuxywbFhPceqbCPjawxQJ7xpPEn8hQl/mu8uNMUPJx5YsxxbUI9JUmWcnc5RdV
 nF9JaKf0uTTuPW0x/sNsd4z5dkalhnUOJLfepFFrD0J8Oj7e7uDjuaPBCTcTeiv/ivQC
 YfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HilmNsBXxF6+r0GSMht6FKtiuVqVkmibtZmAOJK4OQg=;
 fh=Cujqt3SDGh0QOKxHrv00pCEAljIBC4tUL/vkvGMt8n0=;
 b=H8iIkPR4kTaaL3d6tGf1nLDUFeT9oCqykA2PV5KGFRndNqjrE1lHjWMJkjM+H+lQxA
 xTFv1KWfG8Awwz9+miEFYLnfr72+IfLhEBbMWtLhn6Z+yLAqvFCKIwLAYMKW3zO531nJ
 xsU8eGmR6DkBTw576lCIzx557d0ont1hu1OBUH6HXxg25FfYdQ+7BXnJab42kNYST4tZ
 6KAahk2myVxFJM+rZQeleelIuQWT7NqUGt3ZKyPqbLWByjk2qmbSdeeJ2l+MmwwW1VEa
 L+y2ABORQy+dlEvLnNiIcQuL3nPNHDIasZJtjbktTAwgGZalIzbquzNtEQBKQqvSzcUk
 w20w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1778762161; x=1779366961; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HilmNsBXxF6+r0GSMht6FKtiuVqVkmibtZmAOJK4OQg=;
 b=f3h83iNUUjkTwwy0Nagrj5js7YhdQ5z0PQvbtHu4Ym1FdV7FofsKLxqACbi6kKjKmN
 i+35UpyMg+jpgAtGxUnu93DSwpgQ/BEUVgL+pkJ0jnGYEoz86P18tFJXw+PeyFXpv1kn
 KYrY4i3aF3V+0NDp0VUIIkb3qGKd+jxBBppjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778762161; x=1779366961;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HilmNsBXxF6+r0GSMht6FKtiuVqVkmibtZmAOJK4OQg=;
 b=EPtMn9sMVJaORfjskP7WaK81rG+4Cr0Em5Zoryv10+yBOZGnTeZJDiMR8+TA96fCzL
 J2mWzHhVFAnaYAtCE5ikaCWRJIBmsY+RV0C+dEJ266JyS2aeGjeOxjMQiS3LlfEqBu3k
 PifuuDzU7XlpAEN7S9bgqeCDUjQlZ76HRDoNRaFZWCqYwu+ZMlFrhbORrKh1Id/aDI+u
 JqGA60a/zBsext4ayi0ry2IiyViY9dQhbHou9jbey012dneqdJpPR+Nd8bWQy+wS7Rgm
 seDjHVvwjxOBovHh2n266GAHgaVkWoVlVzwEWRcVI4ia/3kzTgM08un3gCVt98MHI/jw
 MQxg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8p5kEFEg7I1v6dV1Bvsn0j57Q7X4doX+Nwpxp20KiUT5ogLykYsJtkQIlR9O+tn1PA5os5XsI=@lists.denx.de
X-Gm-Message-State: AOJu0YyIFns0ENa1HkTZ9JIxcGRY4amEgiP9AF1RPUX54QbbOKNCgeHn
 dg672crGyPxnAbYdpP133YMzUgvdEHAU7iacg3MKQlwLrOBBYWwSIvh0NBNWNToGFpsj46GoGP7
 3tgkR94KcS4e0dSoWxk0FT7oizl22T3v++p3S7+6pNg==
X-Gm-Gg: Acq92OG3oeehKeeHwNIu3Bdn/XQHq5d6FsZb7znbJ9C9I9TWqk+cMkamudaZYUSBgTx
 ATn8cCfjeun/j22j9o/its9UHXJ/XZmd/dPZ/doyoUTc4QjQ+TEqSYD7pdErrp3900sEwVzBUuW
 JOGA9vXNctVOb5pkPNxcB88KfcUGp7jdzdunXCuMwzEos8M1JrMoUIrUH1vYrdnKKfZ+7c6SkOt
 YiHPlube8nKGIGd57XwOFFfqUXPvYSxgvFKt0NQWaJIcbOnKryg6GE75M4nXAtMYM36nPgFG/A2
 4t1vBVI=
X-Received: by 2002:a05:7022:f008:b0:12a:71ab:8235 with SMTP id
 a92af1059eb24-1342ee39d21mr4608543c88.6.1778762161316; Thu, 14 May 2026
 05:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260505074948.2603870-1-daniel@thingy.jp>
 <20260508192952.GA1948090@bill-the-cat>
 <CAFr9PXnAt2y9-yRqmTdUmn9CHQHZ3HjJ=MWeW6Mi4MxHRx9ivw@mail.gmail.com>
 <20260511150038.GH1858239@bill-the-cat>
In-Reply-To: <20260511150038.GH1858239@bill-the-cat>
From: Daniel Palmer <daniel@thingy.jp>
Date: Thu, 14 May 2026 21:35:49 +0900
X-Gm-Features: AVHnY4Jt3goSbhIh3NOKOJps3oAUdIcsAmsAIUZrl6sLfmUB-r9vAchRPYzySBw
Message-ID: <CAFr9PXkTm2ufq9cbkQQ+gPhORq-prhSf6GQP1cpjFk65+7TJKQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] Add virtio-mmio support to m68k virt machine
To: Tom Rini <trini@konsulko.com>
Cc: visitorckw@gmail.com, angelo@kernel-space.org, bmeng.cn@gmail.com, 
 sjg@chromium.org, u-boot@lists.denx.de
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

Hi Tom,

On Tue, 12 May 2026 at 00:00, Tom Rini <trini@konsulko.com> wrote:
> > I didn't realise I could trigger a pipeline run so thanks for the
> > information. Anyhow, I triggered a run for v6 and it completed and I
> > couldn't actually find where the error in the result. I triggered it
> > again for the v7 and it passed too. Is there something I should check
> > before I send it again? The run is here:
> > https://github.com/u-boot/u-boot/pull/964/checks
>
> That's very strange. I just re-checked v6 and still get:
> https://source.denx.de/u-boot/u-boot/-/jobs/1446347 and both Azure and
> Gitlab run the job the same way. Can you trigger it locally with
> allyesconfig ?

Before adding a new patch to fix the issue, building allyesconfig
locally gave me the same error as your CI pipeline had and that went
away when I fixed it.

Cheers,

Daniel
