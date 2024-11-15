Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC272D6A25E
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 00:21:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B03088964A;
	Fri, 15 Nov 2024 01:21:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="I9MNyUjF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DB2989688; Fri, 15 Nov 2024 01:21:29 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B22468852D
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 01:21:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 8c5c91cd-a2e7-11ef-8d51-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 8c5c91cd-a2e7-11ef-8d51-005056999439;
 Fri, 15 Nov 2024 01:21:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=5xYN7alW9ltHkGL+SWPvO3UJ658uJfR1MT0Au9MWuB8=;
 b=I9MNyUjFuCxjgCB1mRJbujjjis19KLdkEwWlQak7kT5WUidDER3W+UsnBKH19K0iKYPrvIfp6Ae7V
 O5gSNJM524QxvdR1IFJbe5fPpOvOqVRDpESKbCxiF4nHNGTaR5QiZYoZQn/yV5uLb9FBHUjVMLpVYu
 6ta35IOkFSK8bQWnY4AwTJbCp0Mgo3op6CH3RT2ml9hjQs+ubVMhWp/V5tdFPI4iJjjSAWDLA9Nonq
 rLSH9MVf1ZZ7m0K2+85g3wALB+V+JWMoe9t4/bDVp2Y2zVPmT1MMAdxe3A7deImkCS/scVYbmsaJ01
 l/6HcohqfUzb0OAnUhXRNdwY+G2IaYw==
X-KPN-MID: 33|qibAzbRy26P3u82e96kgON35OL4rywgGH3W6zgdUEXbxrJG21xYF5iFS8eMRpPg
 itmUnei1vqBFrNTJCep5gE2iKXACwjEcP4aDHSQbO+M8=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|BwXndb0Dj143Ktaq1W62k3Q1OYjEdfdn7qaQnoEhr4oE0etUTuVqv8SB3uRTSQ8
 7z/xWfHG7Fal/n0NIFtwbUw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 8c4e0fce-a2e7-11ef-8887-00505699772e;
 Fri, 15 Nov 2024 01:21:25 +0100 (CET)
Date: Fri, 15 Nov 2024 01:21:24 +0100
Message-Id: <87plmx1h4r.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Tom Rini <trini@konsulko.com>
Cc: heinrich.schuchardt@canonical.com, hugo.cornelis@essensium.com,
 sjg@chromium.org, paulerwan.rio@gmail.com,
 al.kochet@gmail.com, ada@thorsis.com,
 philippe.reynes@softathome.com, u-boot@lists.denx.de
In-Reply-To: <20241114173927.GJ3600562@bill-the-cat> (message from Tom Rini on
 Thu, 14 Nov 2024 11:39:27 -0600)
Subject: Re: [PATCH 1/1] tools: use cryptographically safe RNG
References: <20241102163259.305802-1-heinrich.schuchardt@canonical.com>
 <20241114172654.GA4059396@bill-the-cat>
 <CAM=mAOmFn0tytht3oK1F59=-nGxuLJmtSr2HpJDyTf=LWKYQOg@mail.gmail.com>
 <20241114173927.GJ3600562@bill-the-cat>
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

> Date: Thu, 14 Nov 2024 11:39:27 -0600
> From: Tom Rini <trini@konsulko.com>
> 
> On Thu, Nov 14, 2024 at 06:35:44PM +0100, Heinrich Schuchardt wrote:
> > Tom Rini <trini@konsulko.com> schrieb am Do., 14. Nov. 2024, 18:27:
> > 
> > > On Sat, Nov 02, 2024 at 05:32:59PM +0100, Heinrich Schuchardt wrote:
> > >
> > > > The PRNG implementing the random() function only has 2^31 states and
> > > > therefore is unsafe to use for cryptography. Use arc4random() instead.
> > > >
> > > > Fixes: cc34f04efd63 ("tools: image-host.c: use random instead of rand")
> > > > Addresses-Coverity-ID: 312953 Calling risky function
> > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > > ---
> > > >  tools/image-host.c | 35 +++--------------------------------
> > > >  1 file changed, 3 insertions(+), 32 deletions(-)
> > >
> > > Now I get:
> > > /home/uboot/u-boot/u-boot/tools/image-host.c: In function
> > > 'fit_image_setup_cipher':
> > > /home/uboot/u-boot/u-boot/tools/image-host.c:439:17: warning: implicit
> > > declaration of function 'arc4random_buf' [-Wimplicit-function-declaration]
> > >   439 |                 arc4random_buf((void *)info->iv,
> > > info->cipher->iv_len);
> > >       |                 ^~~~~~~~~~~~~~
> > > /usr/bin/ld: tools/image-host.o: in function `fit_image_cipher_data':
> > > image-host.c:(.text+0xb41): undefined reference to `arc4random_buf'
> > > collect2: error: ld returned 1 exit status
> > > make[3]: *** [scripts/Makefile.host:104: tools/dumpimage] Error 1
> > >
> > > in the docker container. I gather this means arc4random_buf is not as
> > > widely available as assumed.
> > >
> > 
> > glibc 2.36 is required published 2022-08. Ubuntu Jammy is 22.04.
> 
> Yeah, that's likely (a) too new and (b) strange because:
> https://source.denx.de/u-boot/u-boot/-/jobs/945810 and so is jammy
> 22.04.

Linking against libbsd might be an alternative on older systems.
