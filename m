Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FDEC79FB9
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 13:11:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D620C40ABC;
	Thu, 10 Sep 2026 13:11:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GGCjms9fLCOS; Thu, 10 Sep 2026 13:11:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 79BBF40A8F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789045905;
	b=QPjqn4aGusIwtJGUinEtI1/5zmIgGECMV2XvoMcpYsa4ajAUzw3Tug8Ma75CGSoUsmFM
	 3gPvVOt36/cWh1ADQ3vMOqrOsJwPPMbTSOhga5y1i4zAkNDkNS0oh9zYgHsIChmX7INeR
	 9Sz1dcW5B81Co+d34c03LX5p4ibmea9J+0KntoVSL8tCzYpikAEMC5y/uIIhGPVlkaUT4
	 KwpocVWbnNEBhp8sWRWnQfVOkGdJXtwC5d64FMjKIbCkA2W+d5ceHPYBYL8xsha3ccMxW
	 5TJ0M4QjppOUgv6UPpv++BgKevU5lwQqbsIMUW7H/YF4GBy5LqxAjvZbuuUnUQoGs4g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789045905;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
	 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:Date:
	 Message-Id:From:To:Cc:In-Reply-To:Subject:References:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IbZPAfN6pIsMrOD8TcZJfDQoJNiUYp2uqVjoY+1iDMo=;
	b=e9t/ZJnRRAmxUf7/hOqmPCjKnapFMLi0ZdV1aDBCeqsarIHgj2nlp6BxdC2H4iPVyh8e
	 1IJQRjYQsd+43CglZ6YT/5C1/EXf67LQ6axVkOy+XVCwr/4bjsgfaYsbrEuo1WSLoQAvl
	 GxlQbc4DKZWh37UEei2AyY3Zznk6wL0zDyzHMnZkbUrwewqewbSW1WqXYcslkkKwd7KCY
	 vGHO9G3NV4AW1iRkXsVDBF8RGRWgPf2LuL3Pha27C0iqIdn4geGmJRzHXEK1QyqgxTY2R
	 4GATCTKuLL4BI6AkkujtO5iJ+D+naqPuJBYKsU2+LrBXHk/MSPcEDOKaBe6Gg3mQ/JQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=xs4all.nl;
	dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=N4XLkpTf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789045905;
	bh=IbZPAfN6pIsMrOD8TcZJfDQoJNiUYp2uqVjoY+1iDMo=;
	h=Date:From:To:Cc:In-Reply-To:Subject:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FO4h14feWqC7jUBbvhOxP+/aqdqCGfGc8upRyDdQxkEVOmsgAj1o6qXXqSmm6ndT8
	 /8UVGj0rYrU43X+PKPOBcfsFwgxMRQCuWbaV2VCM1mZ7m+ORRJZGQeXnT3KdxqSGl5
	 nH/zGgBSpVTMpK9rEuUuJRZpOj3oYt/Pv331velMlh8Ef494iJm91JAPgxvz2wDiWA
	 5r1sm6LNZwFeKNMuv0uCqbl9AuH2iAhyhBnnASM5NQvqakWr11vWEjLrhxGp65zAX4
	 Ogi27k0blP6Vl4DoaAxPaciiM7MHoZEVuVGzz6ZQ8FUWtVX6O65gLPdWv+N2RuSJvP
	 yZwAYItwleuCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 79BBF40A8F;
	Thu, 10 Sep 2026 13:11:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 855C849D
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 13:11:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7711740A9A
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 13:11:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EU7NWIny2eL9 for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 13:11:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 192B540A85
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=195.121.94.168
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789045901;
 b=s2bXEXOQ11JLqhkncI+VT+EjbQZqNAFDmHf7/7PRYgMEVfGUC0GMWatCgBllXRq/7VpP
 d1I3LHyZIuDyoqDbERAftH0Kmj7NBZf5D55sqjkAWgglx6rgX11fpXydsEV9eC3UxLIqT
 FV7AVZnVIvwxKY2Crch2W8CPJ7CV+PJUoPCw2G0dUcgeTTKHRG9kF245oX6ljKtId0qtC
 h97mRxZN6ajisa1ufw69yaWn3vXIoGyX7fnBsCTSTPVBUp6NFKNr2ESBos9cBkjPSrFqa
 AmKxmOC3c2iOhOnH3OFT1RygrOx8bSJMDRxHCqO+pcZKB5I12CvLYFskhLRpGFM1HPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789045901;
 h=Received-SPF:X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:Date:
 Message-Id:From:To:Cc:In-Reply-To:Subject:References;
 bh=IbZPAfN6pIsMrOD8TcZJfDQoJNiUYp2uqVjoY+1iDMo=;
 b=KRsXpF9IYCDhcAOyZJuIbYM5ZsZZhtmsYZxoA/yulhGdJIUNoN8SDfZeTTr8+EW6L4YG
 WwkVJclnBGCKBxhmBwe43pG53QxIMKln8WDjXVmtm8sFUcbsbdzGp/B8DwT+LklFFHM/Q
 m7TPuFvvLXKQtqjxWqzEdWEIStOyCYLdRkkyKrOiEqElDSShno1CxBCIt6zfxD4aMQOae
 49Agehfzn44XBOSQfGgrxS54FrwplKySm6ywe7of0sL/Z4dzfmgxh6hB9n+Hm+AvL7VfO
 OLt/FbRd3aek1nPsZRJUjPCIp2xzGF69a9MLeaAeibDj0DKPFovsTkaKnSiV3Lqlp+g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=xs4all.nl; 
 dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256
 header.s=xs4all01 header.b=N4XLkpTf; 
 arc=none smtp.remote-ip=195.121.94.168
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.121.94.168;
 helo=ewsoutbound.kpnmail.nl; envelope-from=mark.kettenis@xs4all.nl;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256
 header.s=xs4all01 header.b=N4XLkpTf
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 192B540A85
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 13:11:39 +0000 (UTC)
X-KPN-MessageId: 24075824-ad19-11f1-861e-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 24075824-ad19-11f1-861e-005056aba152;
 Thu, 10 Sep 2026 15:11:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=IbZPAfN6pIsMrOD8TcZJfDQoJNiUYp2uqVjoY+1iDMo=;
 b=N4XLkpTfbjDMYt609DdAw5JEK0sXbG1hf+4/U7BIAF4RamstPjsHN2oQybZlOeLKBrr1oz1/d16vU
 j1AdmYZaA02/Hq96Hj833xgRf9sY5TajwCReviLvqYTSkqE9JHbK4kfITrNGYR9hZ5tz5+Ov15mtso
 Eht6a76rHHwZnSWRwBcakWwOTL/8FmWUBxPMSFYo7Zn+6OzsePqfIngEt/RLFiwBte58+LksmuSCAc
 0E4vV743H5KwjeibOVwKcR0EENbMmCS2WlBor/N62ci39OG7R7u74MxxYp+C+XOLXJfSktazamVCMc
 UQT/ygYJvrAv6vPMQz1b2dAjIK9XEAA==
X-KPN-MID: 33|X+d19bXM1AvgWjEMFzwF1dtaS5sZ765Ee04lCukobxK5p+2ftizrqh3zOhwkAz5
 Zideo49LI8aPxwdw7/YNtxL2OEHywBsa6Ug3LK4Cmd38=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Nm7O8lMTYkMF4OVpHh8QPwEt+kICFkTQYmMdHg4NlU7ULXspwP9loqZ8b+SLf4T
 LVWNWgWierszVCNdrL37cLw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 2371cf42-ad19-11f1-a8be-005056ab7447;
 Thu, 10 Sep 2026 15:11:31 +0200 (CEST)
Date: Thu, 10 Sep 2026 15:11:30 +0200
Message-Id: <875x0ds131.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: j@jannau.net, u-boot@lists.u-boot-project.org,
 asahi@lists.linux.dev, kettenis@openbsd.org, sven@kernel.org,
 bmeng.cn@gmail.com, trini@konsulko.com, fberder@outlook.fr
In-Reply-To: <6a3f39b8-d063-44d9-97f2-9b74fb06870e@linaro.org> (message from
 Neil Armstrong on Thu, 10 Sep 2026 14:44:38 +0200)
Subject: Re: [PATCH 0/4] Apple NVMe fixes for macOS 15+ firmware / M4 support
References: <20260904-apple-nvme-fwabi-v1-0-f7ede661c469@jannau.net>
 <6a3f39b8-d063-44d9-97f2-9b74fb06870e@linaro.org>
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

> Date: Thu, 10 Sep 2026 14:44:38 +0200
> From: Neil Armstrong <neil.armstrong@linaro.org>

Hi Neil,

> Hi Mark,
> 
> On 9/4/26 21:22, Janne Grunau wrote:
> > Hej,
> > 
> > this series adapts Sven's Linux nvme-apple series of the same name to
> > u-boot. It fixes bugs which are worked around on M1/M2/M3 based devices
> > with NVMe firmware from macOS 14.x or earlier. Starting with the NVMe
> > controller firmware from macOS 15.x (required for M4 support) the
> > workaround is no longer available.
> > 
> > The quirk to require page-aligned buffers for the admin queue is not
> > necessary for u-boot. As far as I can see the buffers are always
> > page-aligned. Add noisy WARN_ON_ONCEs to ensure it's noticed if this
> > changes or I was mistaken to begin with.
> 
> Do you want to pick those changes or should I route them via the
> NVMe custodian ?

I'm not setup to pick these up myself, so it would be great if you
could route them via the NVMe custodian.

Thanks,

Mark

> 
> Thanks,
> Neil
> 
> > 
> > Janne
> > 
> > Link: https://lore.kernel.org/asahi/20260806-b4-nvme-fwabi-v1-0-bde19ce8db04@kernel.org/
> > 
> > Signed-off-by: Janne Grunau <j@jannau.net>
> > ---
> > Janne Grunau (4):
> >        nvme: apple: Don't set a DMA direction for commands without a data transfer
> >        nvme: apple: Never set the opcode in the NVMMU TCB
> >        nvme: apple: Add WARN_ON_ONCE for non page-aligned admin queue buffers
> >        nvme: apple: Drop the PRP null check chicken bit
> > 
> >   drivers/nvme/nvme_apple.c | 19 ++++++++++++-------
> >   1 file changed, 12 insertions(+), 7 deletions(-)
> > ---
> > base-commit: 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc
> > change-id: 20260904-apple-nvme-fwabi-cf74f7cefac4
> > 
> > Best regards,
> 
> 
