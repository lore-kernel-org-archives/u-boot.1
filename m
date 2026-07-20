Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8B0C44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:34:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2EB6D606E5;
	Mon, 20 Jul 2026 18:34:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xqqv0_puzmD3; Mon, 20 Jul 2026 18:34:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 74D3C605E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784572446;
	bh=MuDlr2bkOyLrsC2+tUTzgmd28d94VH+6L8+v2jJmhwI=;
	h=Date:To:Cc:In-Reply-To:Subject:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Maq6OhGyiXN/PohlzQjsWNW5JrF8JE3XU5BM55auq3xiG/tvAO0UjZ7ijhv8K2AX3
	 McXlwN2MiK8bfuPTTiVl1NX9mLwtaMgjUx34JiNe2HRkHobwNjj6mXKWZ/5td4jy5l
	 EpjXeaXFWWhigdbhYV5vS0UBzyeeFXRKBVfoBiuM5JfAoJ1AIsMQPeyRwF2FTLo5LK
	 2eEH48nw8LiKspftYEPBneYqT5yCE6r55z6Lhqa/TbSdVEXH9Jq0mHWKGjs8MOneiq
	 Zu1rB2aVWgh/gZZZuqwc5yjj30EZFWPATfJDKe0IUCHUuKTUF+KcFmEm2P9XKP1AXt
	 vdrxe4pv0ao0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 74D3C605E4;
	Mon, 20 Jul 2026 18:34:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 354612E5
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:34:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 19EFB6069C
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:34:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HtmZrnAp19ix for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 18:34:03 +0000 (UTC)
X-Greylist: delayed 558 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 20 Jul 2026 18:34:01 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3D130605E1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3D130605E1
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mark.kettenis@xs4all.nl;
 receiver=<UNKNOWN> 
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3D130605E1
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:34:01 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8599D847AF; Mon, 20 Jul 2026 20:24:38 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CD5580433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 20:24:36 +0200 (CEST)
X-KPN-MessageId: 4261a37c-8468-11f1-9e8e-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 4261a37c-8468-11f1-9e8e-005056999439;
 Mon, 20 Jul 2026 20:24:35 +0200 (CEST)
X-KPN-MID: 33|5m4/hcIuaYxJS7oTqZpIpL8z+cNaAWVqfWrOCQ9fL9OIQmXz3pnPMaRN8joegJu
 XCZoRlwjFiGfrparh5Pk7f34qpn73fOVq48RHQXkG0nw=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|/sEPCcNyXMmZEGNYcXeVUXLG/EVzY+fD9Pra1anYD72dqCtMtv+DS3C5JQ8kilB
 wSpMaW+WWHLfvH1U9NI+zVg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 41f2a3ab-8468-11f1-87f7-00505699b758;
 Mon, 20 Jul 2026 20:24:34 +0200 (CEST)
Date: Mon, 20 Jul 2026 20:24:34 +0200
Message-Id: <87ldb5sen1.fsf@bloch.sibelius.xs4all.nl>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-board-maintainers@lists.denx.de,
 u-boot-custodians@lists.denx.de
In-Reply-To: <20260715173119.GL749385@bill-the-cat> (message from Tom Rini on
 Wed, 15 Jul 2026 11:31:19 -0600)
Subject: Re: [ANN] Mailing list migration to lists.u-boot-project.org
References: <20260715173119.GL749385@bill-the-cat>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=MuDlr2bkOyLrsC2+tUTzgmd28d94VH+6L8+v2jJmhwI=;
 b=RHwSubiGOais9H4zi7EjsnNvg0lJcOq5amUPU/uINscP7AA+MQqGJnHQxla/NsGnITWdRa+UYa9ej
 3z8yNMtwySxFKvBtotyDYvrM8z/NeKNteF56Ycy2EScAXDniaoiv1FiisYw5YiomQv2Wqsson5fD8W
 NtJngJReED0rv0Wn+IPjOUbmws9JEQ+LMxPFB+tQ6HmGrwhl/iUVxc0XQyHqv2z8khVK0rVhXFlfU1
 Y77qXN1PU/IXlSMDYr79J4aIeDGXqczem8nn3IZyKcSCD9zMnmZhDNHeIFC0p9Wo/S8foGTH5gkaxx
 Ro1w3DtRudTMN9/IwtzBikqTlek4e7w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=xs4all.nl
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256
 header.s=xs4all01 header.b=RHwSubiG
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=xs4all.nl
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mark.kettenis@xs4all.nl
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="RHwSubiG"; 
 dkim-atps=neutral
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
From: Mark Kettenis via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Mark Kettenis <mark.kettenis@xs4all.nl>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

> Date: Wed, 15 Jul 2026 11:31:19 -0600
> From: Tom Rini <trini@konsulko.com>

Hi Tom,

> Hey all,
> 
> As I've mentioned in previous release emails, we'll be migrating our
> lists over to lists.u-boot-project.org. The news now is that we have a
> date. This coming Monday the 20th of July, we'll be turning off the
> receiving side of lists.denx.de and then importing everything over to
> lists.u-boot-project.org.
> 
> What do you need to do? Nothing much. All active subscribers and their
> preferences will be moved. This includes how lore and patchwork are
> linked, so all of that will work. We are going to try and ensure no new
> emails get lost in the migration.
> 
> Based on feedback from the test migration, we believe we know what was
> missing to ensure that the archive links are stable, and so that should
> be the case when we go live again.
> 
> I'll send out a reminder about this Sunday.
> 
> Thanks all!

Sadly it seems that the new list is (mis)configured to rewrite the
From: header to something like:

  "John Doe via U-Boot <u-boot@lists.u-boot-project.org>"

Does it have to be that way?
