Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C23BC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 15:44:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72BD34088F;
	Tue, 28 Jul 2026 15:43:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pOTw0V-AZqEs; Tue, 28 Jul 2026 15:43:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BDD494081B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785253438;
	bh=unvs3CILyXkj39SG/6dEKJEe7qw48k9OiaHHWjWGS7g=;
	h=To:From:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ceXHACgEo+EcveT4x4/9/xx8ergdCX8vPlGgaum0CPEVumIXr+gwSMLuD89tn8dzI
	 f2A4CwZrrdN2tQ5bhbo3APrh+MOJhlCw2d2NB9cbs5zyz4E+zmHuvWk2oQP0lguu9n
	 FrwkO1gCFbHAIdpzK/UUL0TP063mjrsSdhCOExoc4KI8ZoX1pwYG20ccChuFaHDC2D
	 whLR18qjdPEzRf29vVEPKiKFkJ8IsKeHYMrTylC5xJeevb9Xlsxk+eDMPsDYt//DUh
	 be23OxkFXsVIKPWqlSFBxqt4bLJjMyUwnzsqcuWUQQdubE/pfCjGIAlhe0twwjgw99
	 STPwxDHzKEttQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BDD494081B;
	Tue, 28 Jul 2026 15:43:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 87A19350
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 15:33:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7973D60783;
 Tue, 28 Jul 2026 15:33:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tVMKk6vXWlrp; Tue, 28 Jul 2026 15:33:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=gcbu-u-boot-users@m.gmane-mx.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3EC9360758
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3EC9360758
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3EC9360758
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 15:33:28 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id E06D98493F; Tue, 28 Jul 2026 17:33:26 +0200 (CEST)
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E5038404D
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 17:33:24 +0200 (CEST)
Received: from list by ciao.gmane.io with local (Exim 4.92)
 (envelope-from <gcbu-u-boot-users@m.gmane-mx.org>)
 id 1wojo2-0003hT-JB
 for u-boot@lists.denx.de; Tue, 28 Jul 2026 17:33:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: u-boot@lists.denx.de
From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: Re: [PATCH v2 08/11] rockchip: doc: add boot medium layout text
Date: Tue, 28 Jul 2026 11:33:17 -0400
Message-ID: <jwvv79z5dwg.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
References: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
 <5ab38df7-9065-4354-9b83-364d14efa390@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:EYmoW9K8PKSi8wW9+j8Y0M9Jtwk=
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

> +* EMMC/SD card:
> +
> +  Rockchip uses a unified GPT partition layout for it's the open source products.

"for it's the"?


=== Stefan

