Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACA8C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 15:44:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50590608D9;
	Tue, 28 Jul 2026 15:44:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T9CktrsQeEhO; Tue, 28 Jul 2026 15:44:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A683D608D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785253441;
	bh=gv5lJgR3jCPTdjTU5e7JxcwuUo2cPUgJ59yFfisBJ1Q=;
	h=To:From:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K7Gi63xrmVR8xK7835goNFruAerDCp8RdKaSsPLPn35+6SekXgjxF8SGkupsaRgA5
	 f0PuIq/Wx7CiOTqteCfFgeZl7QzrrKMnxZ5VXPiSjJ3cBuOezbHw/8J0zXCpvMTBfy
	 x0vhXx47gWKCBvCNx1P95polxLr4My8rKAUcmezWfV/raKA/uezwtS/y1XMwKcZUFr
	 AuiUw8fcm7IVSy0P1KgMT4Y1MrBJbLB6Tto9n1F0tYhDvCt0qMNCot8XtGs/gIUeAR
	 Xmo+2QvALq5FvyxpkyEN3C+ffZz2VzfW8BOJxvkEcnDxhHfZzitcRDNLe+9gVqqrhp
	 n27jCGP1n0Gdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A683D608D4;
	Tue, 28 Jul 2026 15:44:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 57BAA4BF
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 15:39:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 50D4B608CB;
 Tue, 28 Jul 2026 15:39:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xw0o_M2GB9GE; Tue, 28 Jul 2026 15:39:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=gcbu-u-boot-users@m.gmane-mx.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6D5F5605CE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6D5F5605CE
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6D5F5605CE
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 15:39:41 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id A60818493F; Tue, 28 Jul 2026 17:39:39 +0200 (CEST)
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B17438404D
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 17:39:37 +0200 (CEST)
Received: from list by ciao.gmane.io with local (Exim 4.92)
 (envelope-from <gcbu-u-boot-users@m.gmane-mx.org>)
 id 1woju4-0003We-Ve
 for u-boot@lists.denx.de; Tue, 28 Jul 2026 17:39:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: u-boot@lists.denx.de
From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: Re: [PATCH v2 08/11] rockchip: doc: add boot medium layout text
Date: Tue, 28 Jul 2026 11:39:30 -0400
Message-ID: <jwvo6fr5dsv.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
References: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
 <5ab38df7-9065-4354-9b83-364d14efa390@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:4pIP316U3GbZ9tUHFXF8LdCqMuk=
In-Reply-To: <5ab38df7-9065-4354-9b83-364d14efa390@gmail.com> (message from
 Johan Jonker <jbx6244@gmail.com> on Tue, 28 Jul 2026 08:56:19 +0200)
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 28 Jul 2026 15:43:55 +0000
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=quarantine dis=none)
 header.from=iro.umontreal.ca
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org; spf=fail
 smtp.mailfrom=m.gmane-mx.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=fail (p=quarantine dis=none)
 header.from=iro.umontreal.ca
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=gcbu-u-boot-users@m.gmane-mx.org
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

> +  Write u-boot-rockchip.bin to offset 64.

Could we be more clear about the units used?  AFAIK it's really offset
32768 when counted in bytes, but I'm not 100% sure if that's true if
the eMMC/SD device uses blocks of other size than 512B.


=== Stefan

