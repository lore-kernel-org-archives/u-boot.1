Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8E8C531CC
	for <u-boot@archiver.kernel.org>; Sun, 26 Jul 2026 11:46:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6772A60645;
	Sun, 26 Jul 2026 11:46:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oMxpA9Fa11d6; Sun, 26 Jul 2026 11:46:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 838706062D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785066389;
	bh=JvFEUUvE5nVHfId9cIOVm4iGMKEHBeii4rRT92HrRs4=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=YDNejzX3NeFc/+6MYWJBdzUe1Vcbi33jDZd9NkSiMqpqoUGssONjDjR2+YwDbK4YV
	 67RjrReQ6GweCLCq8x8gviT8AVKyFwWRBY0/MTwpt0nGmm8NnZLnm9/UO3FZAufZaM
	 SHxfgS+KpCDkaHFFzkLLddi+rTZ9Z/RM/AQJ3LKUI+dV9djiC6CUbLtiWhGGw/1Spr
	 JJyQSf0VDj8KPQdQ2nX2j4h0TJEfT020ZoeGl3FNBiUsTDIiTw/KCCP05bHhKopzef
	 GOjF5NIgkMybKpqiBY5JcmePbTiJkYGDbba6mGyazhp3xys7CX18Edj9H89RFZrRhV
	 1T2VyPVXeIr2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 838706062D;
	Sun, 26 Jul 2026 11:46:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8117B490
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 11:46:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7EACE6062D
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 11:46:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 37MKfMQ4X3a7 for <u-boot@lists.u-boot-project.org>;
 Sun, 26 Jul 2026 11:46:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=203.137.112.168;
 helo=mx0.gmx.wtf; envelope-from=u-boot@vicb.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6A539605F0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6A539605F0
Received: from mx0.gmx.wtf (mx0.gmx.wtf [203.137.112.168])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6A539605F0
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 11:46:27 +0000 (UTC)
Date: Sun, 26 Jul 2026 13:46:21 +0200
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.u-boot-project.org
Subject: Re: RK3399 TF-A hash verification failure for atf-3
Message-ID: <amXzjSrD9Bo6et7h@localhost>
References: <alujuCnNh13eRfdA@vicb.net>
 <56c497f8-4109-42a4-95df-7c0e0b6277e8@cherry.de>
 <amNcqiirO1PbPS9H@localhost>
 <2c79df57-d01b-4f27-8506-ccbd6daef7c3@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c79df57-d01b-4f27-8506-ccbd6daef7c3@cherry.de>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vicb.net; 
 s=f747d04263f05989; t=1785066385;
 bh=JvFEUUvE5nVHfId9cIOVm4iGMKEHBeii4rRT92HrRs4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=n8U9+Stq54yZGqkl5i5VwofE1qfckchwysgxc+QT51dg/cZt2vslr/67n5JmVeq3T
 zD/oFq5Z1llHKUnbdIlzliV3EJJHeH8vn2hcY5fSRk2tbPACdDbe9XuYqrcErDHKpm
 46BvlLhNYxRfBWldFB11NCQYNIYEocYBS3+3lPX6sETOE/UIBceYSm4kt7UNYqBrW3
 DDrlK/bi5eaa/+oQyLXqGFBr15mIoXm+qwXYAOlRzgQQVDuG9j57u1gHUA3g1AgA0X
 tFf8+zofDQGelQ7PZ3FzQlj6mxM+QJazXPpYSohrJVWOCILyrNviEZ6ybmuyoADz0r
 xlbq7fFkOvIJg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=vicb.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=vicb.net header.i=@vicb.net header.a=rsa-sha256
 header.s=f747d04263f05989 header.b=n8U9+Stq
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Vic B via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Vic B <u-boot@vicb.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, Jul 24, 2026 at 02:55:20PM +0200, Quentin Schulz wrote:
> Hi Vic,

Hi Quentin,

> Since this is not really a U-Boot issue but rather TF-A as I understood it,
> maybe add (or switch to) the TF-A mailing list in Cc/To? c.f. https://lists.trustedfirmware.org/mailman3/lists/tf-a.lists.trustedfirmware.org/
> 
> The few times I wrote there I got first support in under a few days.

Yes, switching to TF-A mailing at this point is obviously the best way
to go now.

Although GCC 14.2 from Debian's stable which hits this issue is no longer
supported by TF-A (according to TF-A docs, minimal supported version GCC
version is 14.3), the same failure also happens on Debian testing with GCC
15.2, which is another reason to continue with TF-A folks rather than
let this go.

> > The Armbian's attempt to fix the issue by increasing PMUSRAM_RSIZE
> > in plat/rockchip/rk3399/include/shared/addressmap_shared.h from 8K
> > to 16K seems like more promising course to me - although the resulting
> > build with oversized pmusram isn't really usable, it produces much more
> 
> I don't think generating a broken binary over erroring out is a good thing
> (it seems however to be quite useful for your debugging session :) ). What I
> mean is that I don't think this is something we should get merged into TF-A.

I'm sure this one shouldn't get merged, although it is useful for
debugging, when the broken binary gets loaded by u-boot (which is
possible after disabling hash verification), it most probably results
in the M0 PMU running garbage after having the first half of its code
overwritten by the overflowing part.

But despite the M0 PMU running garbage and most probably not working at
all, the system appears stable even with this obviously broken binary.

And this is IMHO yet another reason to ask for help from TF-A folks, as I
have no idea how to determine whether the resulting PMUSRAM image works
as expected.

Cheers,

Vic

> I have neither the time nor knowledge to look at the rest unfortunately, but
> I really appreciate you giving lots of information and debugging output, I'm
> sure this will help someone help you eventually :)
> 
> Cheers,
> Quentin
