Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1985CA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 11:46:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71FC14065E;
	Mon,  5 Oct 2026 11:46:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lieCWDAn6JkE; Mon,  5 Oct 2026 11:46:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B382840639
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791200790;
	b=cEPJD/kSlK2gcJgt+AEvlS3vtBvMyf/I5KFOwU9AO2YBfDs/vC8/2E4cl0O/CQ+Ybn8L
	 kMWGkDTCSFW7nJannJf5u+eTfnJD86gJXwelmU/x1zMhFJkiWAry/mf9rD/UBVH5d1cIN
	 sMnIodgvCo3PFvxgSJ+aCvRMFoqkieufU0xpDZgpXrcUGczWAo2jWAnsTlW24BKDLv+AW
	 cnivmbPP01x1JnloluASptrMn8TKT5eaaowl68EYlfJ1ImwO6tR45yMj/s2RtUAVETQvF
	 eieeBiHx0tB6evcdc9iHCWYqehpBcKeuUMVq4JDIlgj5yQ++F2vK4eisE8WlVw4JlVg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791200790;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=S+0b+IpwtPxhjuFWNGmCUlkjG71TCDMZmUa6lcwaZj8=;
	b=S//d9SRaVF2WGpgB2/vyon7jFUjSenMwO0JOJfHU564lfotXdBmo/0S8bIOLsdCrBmBm
	 wQ98pquiC0feZzDrbyb56c3m8yaQ/5dBrTYhsi+tBpdXvck7UFre1TNppYWO7rO9YzKom
	 VpJwOo4K37g/9wpluIPfgJg6Y/8wsfK3SHyYMMfZrvZVbC5x+uCMYDmSCGv7R1mIkwGma
	 6euBOa5IFpJSW5V2YXFC+AqRqt7EUt/a9l1SaX60FUdfjZNgtxcFvWOyuwhrLOA+u6Zhk
	 xI6TQl1tJYXnsRBsOckcLOlxRMSWnHJuLzjB9kHbyEFTYYrFQ+IAthVU1AyLBA9AGOQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791200790;
	bh=S+0b+IpwtPxhjuFWNGmCUlkjG71TCDMZmUa6lcwaZj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K/hjB3qrV0JNzP290ygCoUdbQDv+Mq6RFyDRteSxxn1Fmlmnzi9d//BoCqo0J7/7g
	 KGAWWFMPm7ci62fMDcHVVdS+BLVjcjKOpuzZZa0j2f0GSXy/fuuVMbDtD6jamxFXqq
	 /DmCaQzjSf0vimo8BbwVTyrS33BP4kqxovWHqdreaujB9RWoNmXDPW6Dkkdcl0Nz2/
	 JN38LumSe3qWtzJBRN0Gft3HzvchCvKqmJkcWQTYXs/fSIimXxq7nW9P+ilFq3qIA5
	 n6yG5gIx+eWkeBehaQOv5e759OEEBIH4c6fIT8CbRc1RgUwuHj7A8er7bvac//TRnm
	 dyP7fES+Hp54A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B382840639;
	Mon,  5 Oct 2026 11:46:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 58A8A34E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:44:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BD957400AA
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:44:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WhhbvGSdBM9j for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 11:44:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3E7764007E
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791200696;
 b=EBPy98VbXvnvXoALQt8Wmfda7/G9FlVcvTaggC9FANhjNgrkV71d9iC32Xav92geuh9Q
 YeMuPiA9Shc6woMH5tBtevPPa5RDfA0QdmZ3q+6RGGfJhr2XdvGyxA2EUBWZuoOis9etg
 iNZNJKsmvpmdu95TolTc8RQdCu/mJJSRhToxkE3unT9NbIrtllZi3X0JoWDEsfKOAbgnU
 +ah6v39sDxxxTjKRFiM6HmeAHgqit5ibXeQ7/hVv9Zt0g+/uKctpqxd4VxuKy13D5v+qe
 K66rmtyLX6MedZpyMUTDX6JJQNySJ1oaH+aQ+nMSEcF87uydhBhMssh5vFxSCyHNlCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791200696;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:Content-Type:MIME-Version:
 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=S+0b+IpwtPxhjuFWNGmCUlkjG71TCDMZmUa6lcwaZj8=;
 b=WX55TeY+l42mnJ7qI9o7kA6Mklqm/+yJMXpefvoHtSZSWIyR+50aDKbWUrTNZ4QqIBgQ
 hWgD1Xd6ZZMH7uUROM1LjHs6UIY/iMomnkGSC8Bhv/RsQBe+zWu+hpkfMPmbzOImYlEV6
 3O+FZdiXFLoaz+tzO4S8wbDdUNYKiaT7zWOG3nAON+n5aV4hlUuXZnHn2qhJEJIWpv/0A
 6g2nGoKtV4o+sCOostHJBh0mjb1R4TWZBNy2B0uokiRBXo4CN5yrGjet4e8GKVFUVeglj
 3ZINkX0djg5Au7dlPpMW5gamO/9H/or3A9uZ6kx+bXgshe/iXJ4a0VEEnmy/I7kv5aw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=YhlCbl7b; 
 arc=none smtp.remote-ip=80.241.56.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=YhlCbl7b
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3E7764007E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:44:55 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hyyH83pjMz8t9v;
 Mon, 05 Oct 2026 13:44:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791200692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S+0b+IpwtPxhjuFWNGmCUlkjG71TCDMZmUa6lcwaZj8=;
 b=YhlCbl7bDTnqivC9g4vlEfOWTVLgBMRLcL3DY61KNfljUax56h4WfJ0okEJzlHtRnLddQg
 Sj2zsdZgfUloe7L8ap0yP75aF6osuhSgeDBBdC6Jx+cPXXVS6Nc1AzMU1wFy+K59KSHm3A
 ldqqELFD2v9RctPhtGoc/4XWr7gkILaMisAD4extoMqLkmcRZTv4SFZP1grCIqpm+cwylR
 /jY57lBO3ZQIpTkOl2/k9cWdIfNhihEl824lhcn8DkOANmnHORYXjF2JRCxS4Fz7XVFJUh
 VNQEuKCU+CtEWVrEF82Ak+MZrqk/PbRKKyU+Pdh6Dsc2Zymj5g4kpQmyP/qSAg==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Tony Dinh <mibodhi@gmail.com>,
	u-boot@lists.u-boot-project.org
Cc: Jason Cooper <u-boot@lakedaemon.net>,
	Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2] MAINTAINERS: Add missing file entries for some boards
Date: Mon,  5 Oct 2026 13:44:39 +0200
Message-ID: <20261005114447.741892-3-stefan.roese@mailbox.org>
In-Reply-To: <20261002-maintainers_file-v2-1-74a0f9963b19@gmail.com>
References: <20261002-maintainers_file-v2-1-74a0f9963b19@gmail.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 1hgc8jw7i55nq76k3aq3cmnh646y49or
X-MBO-RS-ID: 7dcdb6a489b878a1e92
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

On 10/2/26 21:21, Tony Dinh wrote:

> Add missing *-u-boot.dtsi to MAINTAINERS file list.
>
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>

Applied to u-boot-marvell/next, with a fixup while applying:

  [sr: rebased onto next, the kirkwood dts entries are already removed there]

Thanks,
Stefan
