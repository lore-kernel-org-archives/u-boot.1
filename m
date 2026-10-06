Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367BDCA5FED
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 14:30:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B865B40619;
	Tue,  6 Oct 2026 14:30:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vRbTln3gZR0N; Tue,  6 Oct 2026 14:30:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A57E4405D8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791297021;
	b=hkCm+FRoKs3PU3rnaeupIO0Rc36U49LIaG4aTD2laQQe9cYFr8a0TcyqYrPs1m33xAzQ
	 m5O1TYZS2Mwf768XawYx7klqahbTqMcLogEMHokS68xEDCArv2SFjVVCnuIOV11C/Qtou
	 PVx1OCNKUBUSfnYBPyPzEX77YK3H7PuTcsXsH/Xr4onAzYYbXwrHOjiiZWQdoJ+Xce1Pz
	 mapp9hh9JXOXA9qKe0DA5Cq/Z7syv7GXxsfUEghS/7SgVtSnDfBUWmWiVtzQapq5ypzc9
	 JtUqtIqvvUOYRJQ4ukXWYXkfYdwZkgFYziijz/ibY/tilNR5GRlKbkMhvBH/svrq4LQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791297021;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Jj3Q+1cPeTQaMVvC9QoZ/wND4CKnaxRSlOjhAq10VEs=;
	b=Kl1rElxw/KS2OsCPfnUwfuW3S1XP8JLYDhVfhOA0W+/Bu1fmCsQH1ruOzhQ30AqWk9Xl
	 +zjTFIMUwOyjtOoECEoMvot3ocYIAYIIoL1XKBHcS2n+yIlNqEqPCVAKU3K45NlHvnetY
	 ayWVDaoo7I17OZyRGyxkFjx51hmFIJ6RWiHZAdW90SpURhakysAUGedP8z2ikh2nF+spF
	 CWZhr0mc9YfGbBH46Kn8lRFr5Bf5WZWvY16uGJAQSynVO+KeJHDh/0QVy89N0aIXqYh9U
	 y9G9wfEPOZeQIRnnEvUMf8Ob/fNSNO9W6wxdYckEHNknuCG6zR/Uh/i8+iWYxPH79EQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791297021;
	bh=Jj3Q+1cPeTQaMVvC9QoZ/wND4CKnaxRSlOjhAq10VEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aOMdI1ixKSqDCz4Rt+01PwrKq64pAmJCYxf1Z3UZUPpsAkqOflnv3a2888fZBF7Zq
	 UMmny4x1rz95iXACUULRBNGqYL5oI1urAWLN4sh8QwpuhzmoQHpsVrQ4ttmnvkjg4L
	 Wlk6/Mol6EHlWhM/R6KINRQHEVGQtZJFw26SPUYB1WNMhnk2e0atOBafjPycS/a6ye
	 hmScbrsJeXdv396uurTqmo6IY2n32Uz1inc0LGwqF8k9tlEnM9V+f8Pu9Sz19itZK9
	 Gk+UFLnVQK3U1Awt82QBK921y8tfPGDHIG+coBDPLcOIdEUvRvzDxFp3JcTJwVWvml
	 z90lvNC4lnSxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A57E4405D8;
	Tue,  6 Oct 2026 14:30:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7AD301D2
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 14:10:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6105580D63
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 14:10:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oMv_Y8021Aa2 for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 14:10:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B88048096D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791295838;
 b=cpPdjxF0oi9P41Nz+T+nB5L3FvY5kuJuau6W4brrXftju+dUsZc2St4M/bUDZlyrfIZM
 Hb4BxvPkzgIUmdvf+h+PY3iW0X/IqZGUlh5veCkW8bpexMhDx6a+/1dZB0AtkEzu6yUrS
 y9tnCrke+0lRIczkRYQu51rtZT6c8NWZ4kr/bffI1P9Vl27rrWuwHOmSqKtTJ2bJqqxcz
 YXKJcI5aTzS3Z6A6u+epm2aYH/YofSDpNRMgGCXMrAffNZH++J9SokGEzMwLVZCOEnUi4
 RGeVEVz0wLbf+YS1VTlgMdLXg4pV/qeX2qQxgFZzrhDVNReidLwsFc8SjnAhOYTGFqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791295838;
 h=Received-SPF:Received:DKIM-Signature:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To;
 bh=Jj3Q+1cPeTQaMVvC9QoZ/wND4CKnaxRSlOjhAq10VEs=;
 b=p5LBEIpYUvQLGz++F4m9pEJjDwfEfTrY6jo2IM8k1Ae3j0KmEi8x4B89T40HPUQLJGCR
 BdGGS8szheCqxne+lC8w9hSuIGYMb1v8///hVkzQImzWPocCP1aS1mcsIbc8QKniSO8bB
 skoHh1beqWn1cb6N45P7arHIDh49/EXD7R6DkZs6zOIwa4NUXu7baRzg/ngSUrgLlWI95
 mnBmVyIqolk/5tAB7Lw05XaPVs+Xsyk9NMjaWzcH5LFk4ZAgOrzpdUufCmeRAS2ryuPa1
 BTpUsWsQ9BVkBMVr5feNVNB3leZfeFF31J864p4UdX/5L8cOt6DU9ARCukhT6J2eJAg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=lBc0q0q2; 
 arc=none smtp.remote-ip=212.27.42.6
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.6;
 helo=smtp6-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=lBc0q0q2
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B88048096D
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 14:10:37 +0000 (UTC)
Received: from L23803.iliad.local (unknown [213.36.7.12])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id BAE5F780107;
 Tue,  6 Oct 2026 16:10:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1791295834;
 bh=1xQ0wz0eQMZ2sGg9ISGPt6H86iorWAeRMj03aJnI56g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lBc0q0q2Ra90z/ETNPpAV+ZyPLGZtS6STqrzRGOwYz/HstygLVqtrDqSsOmLZ5OJP
 yKZKUQKWjAwYB0m/3/JUSBYaWPZLIsqOsIoWjoPL0R7NMLI4jDld5asmvbDLHVn1zd
 V7yvmMwVHm0EuoHTjL2frQpA8tHfOoouXuEtJbeqEcP6OG44lQRFKyCll6MrOj7wYG
 zUSnvHpDoWhzDsem/4j5Md1wK1I83LGSdEFTRbpoDoJuvK9rJumLGWw2Ky1WD7ci/7
 Zft9thKrvLakFIwy1SRbjC6sjYWA8TtWZbU2V+q63R9jnU+cv9vsNQGxDn7tIIW0ST
 Ku0KHgKC5aKmg==
Date: Tue, 6 Oct 2026 16:10:23 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: u-boot@lists.u-boot-project.org, Priyanka Jain <priyanka.jain@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: Re: [PATCH v6 08/13] board: lx2160a: serdes: add serdes1:2x40g
Message-ID: <asUBT7cJtcpegOzN@L23803.iliad.local>
References: <20261001204731.1774613-1-vjardin@free.fr>
 <20261001204731.1774613-1-vjardin@free.fr>
 <20261001204731.1774613-9-vjardin@free.fr>
 <20261001204731.1774613-9-vjardin@free.fr>
 <20261002140709.7g5ftz5xr3iooio5@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002140709.7g5ftz5xr3iooio5@skbuf>
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

Thanks Vladimir

If I am correct, there are 2 missing patch that do not have a review yet:
  https://patchwork.ozlabs.org/project/uboot/list/?series=526189

 - [v6,10/13] board: lx2160a: serdes: add serdes1:40g4x10g 
 - [v6,12/13] doc: lx2160a: document the sd1 hwconfig option 

thank you,
  Vincent
