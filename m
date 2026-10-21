Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817C0606A329
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lrnu7cY9;
	dkim=pass (1024-bit key, unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=iIeE0PgW
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BB43607F3;
	Wed, 21 Oct 2026 12:31:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qcf8C_IJYjdX; Wed, 21 Oct 2026 12:31:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3A694607E4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792585902;
	b=FV0tHmXckayigLU1eftT4Y4+KPl6yPaDpvaIAA4m0fifalCdecNhdmXLZHWQD2EkDU5C
	 DLi4HALVB4Q5Xhu+nT2XEiNvnHzm9iMLyYprzC+hvdVt2QEy1+VRuK6CvtIx3iVjpHfI3
	 mEwK40hf6vh1nXaI6jQ8+Y9IC6Ref0XktgUqMdIZUdsEQc9BnFsNjQxFketAOcp/asq2C
	 nLVixOtWwmcjCCAWqaTaF1pzN31LcztFifNv1VJCSf55k1nMZO2OhiFh/axu0s6OqgEW6
	 9DGL8uyCNl6q35ZfKgTv8jdepgETjyF8bLm/SajUAzzFNsgxn+LSIel4Jd3lCVzXAmg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792585902;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Zoho-Virus-Status:
	 X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1WutkJRbLZrOl05obzFs3c9vc56f/aPyl9dJm6KFwog=;
	b=j3qdiRIyLmvQ1G55UjNNjCLDbRcTZ1RsuEDQE/GJZjhldVPWcXHJN5/n0yqfmxWRmPKU
	 r+0b/7tXopD/4PYD7ETs18jh/OyMB4SlCP/ZkfFROyvEsNhnkQA/yhHd/wrqaQXaS+WuJ
	 F+juAkobg++a6A6MZNedKrvdXbqBb8ZNOBdPZJlmXBa4+dR/tHYBbj7zpp0pGYK3ACH73
	 PmMidnE19HJCkUaH0lNcTovZI42KcOUgMlsIioryuBHbPLhKt5pZFP3/F3F7IFvzEOWUu
	 zltpBW3vDIZJFj3S+cUKWZV0HrIYnGYxIekG6zrRT8gTq6Tv3cV36PEZ1T/zEC3XarA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792585902;
	bh=1WutkJRbLZrOl05obzFs3c9vc56f/aPyl9dJm6KFwog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lrnu7cY9pmtKLezrvarp7mDE9eQwxlB7RKf3dKb7KEBcObqLP2kqkokZtzDgAbEHo
	 KABATwRw+RqtFr/PBoeKRGz5/f7MqMofXFX+5xP5AgdbmB85y68XFr73D55sbqj0OI
	 IYAm4yE/Ps+TATskJyr3EjlhOFZOlSU+vSfGagpB2SZHQFbHqpxfwmiXlLGB19WC9W
	 qloBxYZdB7isGBOEGzXdssmHO4jDbWZj/83UahGZf8FZfKh0qE+l7OeVNPQLGn5peU
	 KPD8A8VQYM2ev4RBNoPStQPxaLuuk/KF4yQdon0jdv9p0tcyp45qpU6fCelhGBQRSs
	 UL+SgM/4E18SQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A694607E4;
	Wed, 21 Oct 2026 12:31:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 20D942A8
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:31:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0643940398
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:31:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pIi1QTzH4AVC for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 12:31:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BA29940399
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792585900;
 b=SI2Yfwi69iUkP7hKFloe+yrMtTWRaxHKWNBeQm3GThpQUYLze7MrIoLONzRKVEMjt3lC
 dQtebmkUSUIIOThnVFcYlrGfRLLpgjhxyQh//Pca+x+BLFBFMEgxbvvQr7d53qkfMcbdD
 VMsui1nmfnPst+UgzdOPq6/gg/Fkz+ZlMGgSizu9kSxfSqpfjoN613pAFXEK+g5toUtLd
 kFrD9W4zVdUJPPxZM7ju+DJTaxiWqyVkNPO0u77NExqSiRNZXmt0ndS8riWTUPUqNRp+i
 8tZFkQ2BHFahxE80OtbKxqKQcq+srZgxnEKKlCyTlQWRHr6e3W052uhrVxeyLWLwmxA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792585900;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 Content-Transfer-Encoding:In-Reply-To:X-Zoho-Virus-Status:
 X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=1WutkJRbLZrOl05obzFs3c9vc56f/aPyl9dJm6KFwog=;
 b=HPdKAQXJGYJ6eap54Cb5dSw+PARQ+OfyUjPY4PzIk2hSXIR0wXUW+ndjOmbGOrTJqanP
 yxTfaUGCA4UCAAYpdbCSdONdRsCWx7tlliu5/EDerJ4lwZ6eVhAJ4hZaRAVAUyg5JsDT7
 9OPCKtr3qSUAL7Byy+PXAonFeigltvkKVZxaPvamO5hWM+fEXGB0acyOoBDjN0nLNPLaB
 ZK/yuxf5Dp53dkavl7Fibq5/ofIlsma6J+9oRxjx/BeFGBPzfcnBIuudnL6Q6/r4PE3sU
 QvIWROunITo20mRhEaSm2vdtWLFm1qmeh82t5KNEccd2/vEW2FTWhCHuuALEUpepBfw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=iIeE0PgW; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=iIeE0PgW
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BA29940399
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:31:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792585870; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=A59Jo0+4wR2++7bdcfQ7sjYfdhvKaRQklmJ89srhM5xqwkr6NlhmpW5iUU0EOpMeS3zo1aVE95/4mb78ApUa2aPBROkkbNukN/mNbV+pS2Kh6Ug0NXtTgRwmY0kc286lyHBEZdnO+G9sLlOs6E+u36hpT5mjT2G0Ydh5YVM3w8Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792585870;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=1WutkJRbLZrOl05obzFs3c9vc56f/aPyl9dJm6KFwog=; 
 b=BE8vj1gPSyURyx9Lg7nLrgTMIHr9VzDtPa4qHiJUqEJsJFAjzaehO1y1PzTrrHLYWcGjJ+b0x+ctLoebcKbTHZiubooDRv172g/A4EmBsEcu5Su33VEKj7A2LVgv/NKmenPGaLgvwn/2q+NWfqn7KSR1keiXj0CcqegOq0KRnw0=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792585870; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=1WutkJRbLZrOl05obzFs3c9vc56f/aPyl9dJm6KFwog=;
 b=iIeE0PgWMtk4ughKlebC2tYNPXvfJJjbG4tLKf+FLWacGOuUIfJwco0AL91FX3Sy
 lnbag1T1NdjCvQ2/9D1xfWF5+M4QhVqI4zedTwFV4MNYE2pOwO3ZoKn7SmPeC3PcqJQ
 Gg6HrP+Uicdvo7ggBj1OtIpI7E14qmhQyNrfrdL0=
Received: by smtp.zohomail.com with SMTPS id 1792585867407634.7202923507089;
 Wed, 21 Oct 2026 05:31:07 -0700 (PDT)
Date: Wed, 21 Oct 2026 12:30:59 +0000
From: Yao Zi <me@ziyao.cc>
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2] iommu: Add RISC-V IOMMU driver
Message-ID: <atiwg1Zus9vNQQJx@pie>
References: <20260825-riscv_iommu-v2-1-e0b816494b1a@oss.tenstorrent.com>
 <CAEev2e9WvQD3ZJNU91-UH1p5KBw1zXZgqhJuBC+6y+Q9HvwrwQ@mail.gmail.com>
 <CAEev2e87Wn=pE1uqFTpi1EVBiyHq=vLPFmvBTOv7Nzrdji0CNA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEev2e87Wn=pE1uqFTpi1EVBiyHq=vLPFmvBTOv7Nzrdji0CNA@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/292.565.41
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 05:53:18PM -0500, Anirudh Srinivasan wrote:
> Hi Yao Zi,
> 
> On Tue, Sep 22, 2026 at 1:37 PM Anirudh Srinivasan
> <asrinivasan@oss.tenstorrent.com> wrote:
> >
> > Hi,
> >
> > On Tue, Aug 25, 2026 at 11:43 AM Anirudh Srinivasan
> > <asrinivasan@oss.tenstorrent.com> wrote:
> > >
> > > Adds a basic driver for IOMMUs that conform to the RISC-V IOMMU
> > > specification. This driver sets up the IOMMU in bare mode so that
> > > peripherals requiring DMA in U-Boot can function.
> > >
> > > Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> > > ---
> > > Changes in v2:
> > > - Changed DDTP read timeout to 3s from 10s
> > > - Link to v1: https://patch.msgid.link/20260803-riscv_iommu-v1-1-793cfa421ab2@oss.tenstorrent.com
> > > ---
> > > Hi,
> > >
> > > This is a pre-requisite for U-Boot on Tenstorrent Atlantis. On this
> > > platform, the IOMMU comes up in Off mode at boot, so this is needed for
> > > SD and NVME boot to work in U-Boot.
> > > ---
> > >  MAINTAINERS                 |  1 +
> > >  drivers/iommu/Kconfig       |  8 +++++
> > >  drivers/iommu/Makefile      |  1 +
> > >  drivers/iommu/riscv_iommu.c | 82 +++++++++++++++++++++++++++++++++++++++++++++
> > >  4 files changed, 92 insertions(+)
> >
> > Gentle ping on this.
> 
> Gentle ping on this series.

I'll try to have a look soon, but am a little busy these days with
travelling and work. Please ping me again if I don't reply after next
Friday, thanks.

Best regards,
Yao Zi
