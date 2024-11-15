Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE75D68BC1
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 14:32:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C0A6890F6;
	Fri, 15 Nov 2024 15:32:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="L6XhdV/G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AE52890E4; Fri, 15 Nov 2024 15:32:10 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0A3F89346
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:32:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 62b451ef-a35e-11ef-93fe-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 62b451ef-a35e-11ef-93fe-005056994fde;
 Fri, 15 Nov 2024 15:32:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=3/PeCd7pS3HD/eeTk+MRsqhXOTNZb4OVeHQ51cgLCAo=;
 b=L6XhdV/Gg1ruOcCwQ8g9Gvtavrpy9lebeorrKecrm0HN4hBPh7wY5y8d9vX3WEuh/kKPJDa6IvHMj
 phB97Q0FJWW46JegPaCG3urdG3G86rmEZYTB7hl8Ia4MPQ6EUqVqdIM83704kL1m5Z6rY9uzFc08ns
 eX98BHMv65dZqaCMF/k969Ijwkf/7t8rJyoYLk4mF/DC8ubudGwENuLj0e2v82mi0p3REpDQmbf4QU
 45ZL8LLgThhnViHlAXPBU3Ifj6f/R4mKKFbx79yCdRRKIHLSN/8eBir3kD/c5c4LMVQ0qKPx1FRU5g
 S4+ISc+DZvT3Yl4TQynsbpkDcq8z4DQ==
X-KPN-MID: 33|R1/9VoiQ+uHlAL9FAh8MinCsKEIsZQmB8qFF4HG4Vm/91MywXgs+mfFjrjLFTD6
 5f6KhpWKnEfO/surzbRWMa5nkxs2ySgGRsaA90ztae1Y=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|YNut7BquvkWnLCOk3S6gRgLz1+9NkVx8NwLalTyzxtcJQxr28qE/c6QQeCfE6/5
 HNjFntaKO4xFCi6D9cF4ZIw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 6396c454-a35e-11ef-8887-00505699772e;
 Fri, 15 Nov 2024 15:32:07 +0100 (CET)
Date: Fri, 15 Nov 2024 15:32:06 +0100
Message-Id: <87o72g1sbd.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: trini@konsulko.com, heinrich.schuchardt@canonical.com,
 hugo.cornelis@essensium.com, sjg@chromium.org,
 paulerwan.rio@gmail.com, al.kochet@gmail.com, ada@thorsis.com,
 philippe.reynes@softathome.com, u-boot@lists.denx.de
In-Reply-To: <87ttc9m0cm.fsf@prevas.dk> (message from Rasmus Villemoes on Fri, 
 15 Nov 2024 08:18:17 +0100)
Subject: Re: [PATCH 1/1] tools: use cryptographically safe RNG
References: <20241102163259.305802-1-heinrich.schuchardt@canonical.com>
 <20241114172654.GA4059396@bill-the-cat>
 <CAM=mAOmFn0tytht3oK1F59=-nGxuLJmtSr2HpJDyTf=LWKYQOg@mail.gmail.com>
 <20241114173927.GJ3600562@bill-the-cat>
 <87plmx1h4r.fsf@bloch.sibelius.xs4all.nl> <87ttc9m0cm.fsf@prevas.dk>
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

> From: Rasmus Villemoes <ravi@prevas.dk>
> Date: Fri, 15 Nov 2024 08:18:17 +0100
> 
> On Fri, Nov 15 2024, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> 
> >> Date: Thu, 14 Nov 2024 11:39:27 -0600
> >> From: Tom Rini <trini@konsulko.com>
> >> 
> >> On Thu, Nov 14, 2024 at 06:35:44PM +0100, Heinrich Schuchardt wrote:
> >> > Tom Rini <trini@konsulko.com> schrieb am Do., 14. Nov. 2024, 18:27:
> >> > 
> >> > > On Sat, Nov 02, 2024 at 05:32:59PM +0100, Heinrich Schuchardt wrote:
> >> > >
> >> > > > The PRNG implementing the random() function only has 2^31 states and
> >> > > > therefore is unsafe to use for cryptography. Use arc4random() instead.
> >> > > >
> >> > > > Fixes: cc34f04efd63 ("tools: image-host.c: use random instead of rand")
> >> > > > Addresses-Coverity-ID: 312953 Calling risky function
> >> > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> > > > ---
> >> > > >  tools/image-host.c | 35 +++--------------------------------
> >> > > >  1 file changed, 3 insertions(+), 32 deletions(-)
> >> > >
> >> > > Now I get:
> >> > > /home/uboot/u-boot/u-boot/tools/image-host.c: In function
> >> > > 'fit_image_setup_cipher':
> >> > > /home/uboot/u-boot/u-boot/tools/image-host.c:439:17: warning: implicit
> >> > > declaration of function 'arc4random_buf' [-Wimplicit-function-declaration]
> >> > >   439 |                 arc4random_buf((void *)info->iv,
> >> > > info->cipher->iv_len);
> >> > >       |                 ^~~~~~~~~~~~~~
> >> > > /usr/bin/ld: tools/image-host.o: in function `fit_image_cipher_data':
> >> > > image-host.c:(.text+0xb41): undefined reference to `arc4random_buf'
> >> > > collect2: error: ld returned 1 exit status
> >> > > make[3]: *** [scripts/Makefile.host:104: tools/dumpimage] Error 1
> >> > >
> >> > > in the docker container. I gather this means arc4random_buf is not as
> >> > > widely available as assumed.
> >> > >
> >> > 
> >> > glibc 2.36 is required published 2022-08. Ubuntu Jammy is 22.04.
> >> 
> >> Yeah, that's likely (a) too new and (b) strange because:
> >> https://source.denx.de/u-boot/u-boot/-/jobs/945810 and so is jammy
> >> 22.04.
> >
> > Linking against libbsd might be an alternative on older systems.
> 
> Or use getrandom(), which according to the man page has been exposed via
> glibc since glibc 2.25. Or just read from /dev/urandom which should work
> everywhere.

$ man getrandom
man: No entry for getrandom in the manual.
