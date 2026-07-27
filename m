Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680B4C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 20:15:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBA334078A;
	Mon, 27 Jul 2026 20:15:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8kdmT3dZ_9Dw; Mon, 27 Jul 2026 20:15:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7547E40761
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785183340;
	bh=djU6Nq/IBcfdrPBOrcFKrilMqHKo9bTsMluODYHhgjg=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=CdlE/t3kkUrJxuogvWl23eg8hUOYe+iSuqRBF6ZjYPiJqC6ZLJ0nNSRaY6vWza+mi
	 aHAgLdUsTr94IRAHwCYQ+f4Znb3OQDdz0sePTxy31WZFjvERg8AxrYlCt+b7Egvnck
	 FgQpbnUZearSRHxjjYLbu3WFYoV/lnLPLu7GVnmwn9TGSPi3GlRrJnypqs7NK7yBtt
	 WQo9wEZJ+0gtavY30eB4Y33RBNZhNIANa4hy1tg31jT314cVmgxjP1XyoIGE0f6pr+
	 BSraVymg+WiiGyKC7ZXNKcd2nSAqoIsIo2PWCv8PyesEP9RdZruU1hg8Jch+btOSN7
	 EQWgOCPGQnjGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7547E40761;
	Mon, 27 Jul 2026 20:15:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 78C1A350
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 20:15:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5F16260741
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 20:15:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nq6OZlmfEXYB for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 20:15:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=203.137.112.168;
 helo=mx0.gmx.wtf; envelope-from=u-boot@vicb.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 525CB6073E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 525CB6073E
Received: from mx0.gmx.wtf (mx0.gmx.wtf [203.137.112.168])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 525CB6073E
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 20:15:38 +0000 (UTC)
Date: Mon, 27 Jul 2026 22:15:31 +0200
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.u-boot-project.org
Subject: Re: RK3399 TF-A hash verification failure for atf-3
Message-ID: <ame8Y9bp1ygSZx8F@localhost>
References: <alujuCnNh13eRfdA@vicb.net>
 <56c497f8-4109-42a4-95df-7c0e0b6277e8@cherry.de>
 <amNcqiirO1PbPS9H@localhost>
 <2c79df57-d01b-4f27-8506-ccbd6daef7c3@cherry.de>
 <amXzjSrD9Bo6et7h@localhost>
 <CALeDE9NfUQcQPninY=f+ohNpVz9OtcF+b_yU70E2v76-qCuGjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALeDE9NfUQcQPninY=f+ohNpVz9OtcF+b_yU70E2v76-qCuGjg@mail.gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vicb.net; 
 s=f747d04263f05989; t=1785183336;
 bh=djU6Nq/IBcfdrPBOrcFKrilMqHKo9bTsMluODYHhgjg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EMoVV92ZfM142xtvJQj1DAzcNElX+G1zNHy20YMGqV/9ARx7hdJkKo8lc0KWaVjx+
 LdxhxtIdXiirKKcMor/Kp1UYJ6qN5L5GEDvqcP0dfRZ9qr/vM79LOu76Lu556XlMA/
 16s+8nJIJLE3SDSqB3haBvbhU/mPmYhWEjI6sK78eMVhK5Pqba2tOHUhfULIRsK5I6
 GRrP2h9LVJ3KeYNBc7lu2oUzgdx1h2cTTjjf3ltsWVtie3SHE0XuQSmFn9NaCMMhtn
 319nje4yNOSCBzBPWme0PXFSAWTApbef1WnwcGWV/tr1q2JanTjfJc4p6EwEi2kzDA
 9evLVmIBk25wg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=vicb.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=vicb.net header.i=@vicb.net header.a=rsa-sha256
 header.s=f747d04263f05989 header.b=EMoVV92Z
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

On Mon, Jul 27, 2026 at 01:12:58PM +0100, Peter Robinson wrote:

Hi Pete,

> > Although GCC 14.2 from Debian's stable which hits this issue is no longer
> > supported by TF-A (according to TF-A docs, minimal supported version GCC
> > version is 14.3), the same failure also happens on Debian testing with GCC
> > 15.2, which is another reason to continue with TF-A folks rather than
> > let this go.
> 
> The thing to note is it builds and works fine using the Fedora gcc
> toolchain so it might not be considered a TF-A problem by the upstream
> project. Now many that comes down the debian build options, or
> settings in TF-A code, or some random combination of pieces is what
> needs to be worked out.

I agree, finding the option that causes the difference is what needs to
be worked out in the first place (at least for those of us who use
GCC on Debian or Debian-based distros and need to compile TF-A for
RK3399; other people aren't affected, so they don't have to care).

After this gets clarified, that option may be either added to the long
list of compiler/linker options that TF-A already uses (and make it
support GCC regardless of its distribution-dependent default
configuration), or adjusted in Debian's GCC package (which works for
everything else except TF-A for RK3399, so the motivation for such
adjustment is probably quite low).

My findings so far indicate that the TF-A build system is complex enough
to make the first step (i.e., finding the option that differs between
GCC's default configuration of Fedora and Debian and causes this issue
to happen) a non-trivial task for someone who isn't familiar with the
internals of TF-A's build, and the size and alignment requirements add
another non-trivial part hidden inside the M0 code and its makefiles and
linkerscripts.

This makes me believe that the authors of TF-A's M0 code for RK3399 (who
already have full understanding of how the M0 code works with the HW
while providing all required APIs to other components and meeting the
size and alignment requirements, and also of how it gets built) are much
more qualified to help with this than Debian's GCC maintainers.

On the other hand, I fully understand that TF-A team, despite listing
GCC as one of the supported compilers, don't actively chase this issue
on their own; after all, the fact that TF-A can be compiled with GCC on
Fedora without problems confirms that GCC support in TF-A is fine.

So in the end, it's not surprising that this issue persists since 2018
and seems to be heading into Debian's upcoming release and future TF-A
versions as well :(

Vic
