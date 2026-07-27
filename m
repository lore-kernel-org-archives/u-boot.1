Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BC2C53219
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 08:39:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6592A80A97;
	Mon, 27 Jul 2026 08:39:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DyMUO8TuRJN2; Mon, 27 Jul 2026 08:39:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7E05B80992
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785141581;
	bh=t44j9vyXq94LiALjbzSfrZYleqY6ufGXjZsGwMwg0YA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BJOIZklYeyAxfuGZLw//5qkrK8QKbAVwRtEXom3KSn2b3r1sGjAWMXrvFj9l1e0tj
	 lZm/VY5bxPceben6oaGHNtrJETU33EVbA7h9SPfAwlphf0SHY3p6x5emBKhQ3t1PNf
	 GBTCVfgYspBK/3OAxSnCqV3tGlBTza3mqESx6IV7IZ8quVqeEaddQagm9MnbDhwxMw
	 cuzfMRUJr+3uWxrgIKRUVOR3e6SBEXO7D6SL9En4XH8re023EPI/qp2oiRYyX4TxCb
	 mETZOqvE8hQt7eGk9j8nWbVzoy79mRnj7BXPiTbUjrHJC3HFaiQ4CDt4ypGMGQDC0c
	 3H8oNcy2d29Nw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E05B80992;
	Mon, 27 Jul 2026 08:39:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B59EC42A
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:39:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A7D44605B7
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:39:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Neqx0Rim2T60 for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 08:39:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.12;
 helo=sender4-op-o12.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7C278605AC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7C278605AC
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7C278605AC
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:39:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785140661; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=THVXA9SXty7f+5dNIccFTwAQK+paBwBjfJVOj2C0ilLjvQV1RmHz4vcJRTKhUsjFhr0cGi0S+YqEx0vOamVn4NtIyfuvH4jmzesUdfkrQR4/oT3kfac3rvVgqjuWbge2TxKzA7lqoMFW50yNvNRc57xm3FwpA12FowJeocxX/wY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785140661;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=t44j9vyXq94LiALjbzSfrZYleqY6ufGXjZsGwMwg0YA=; 
 b=mHUxNp+NEoH7Z4Jj1Nj4Fw83BknZ0rtPxNfAxaetaBZDNDGF2zseXFmH0J7iuGJcsQ9zSAHX6h3aQHGY3Il+T7SzadWuNjKQ9wqoTZC2uATWm6ZnV1GWeLppWo3H8xsg2tlYvO8yBVKWsuJUfx0SS0BXYMQOZN4qGDGVTgoYoY4=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
Received: by mx.zohomail.com with SMTPS id 1785140658890364.53009821257433;
 Mon, 27 Jul 2026 01:24:18 -0700 (PDT)
Date: Mon, 27 Jul 2026 08:24:06 +0000
From: Yao Zi <me@ziyao.cc>
To: Eric Chung <eric.chung@riscstar.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Han Xu <han.xu@nxp.com>, Yanir Levin <yanir.levin@tandemg.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>,
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Subject: Re: [PATCH v6 03/11] pinctrl: k1: fix pull-up/pull-down configuration
Message-ID: <amcVpqFDUh8XuNLm@pie>
References: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
 <20260727-m4-v6-3-2f58566d48ca@riscstar.com> <amcUt7Sv0PjCBrgA@pie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amcUt7Sv0PjCBrgA@pie>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/285.120.97
X-ZohoMailClient: External
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1785140661; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=t44j9vyXq94LiALjbzSfrZYleqY6ufGXjZsGwMwg0YA=;
 b=masaCn4ObOtEDmWNBYrEcZU6fNBAv5k5q/mUsMHK666wZd/bCrxj63GmUgoUi4JG
 8xQM2O6NjvJ15RpFTCS3C6DRGtX1LxSgzv2wzzGtWzTA5JfddVUjQyT5qqAZYjREkH+
 4rKvnTNXaH3TrCgocFBQDpeR3GVAPbSt1XyGfy64=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=masaCn4O
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

On Mon, Jul 27, 2026 at 08:20:07AM +0000, Yao Zi wrote:
> On Mon, Jul 27, 2026 at 02:59:05PM +0800, Eric Chung wrote:
> > Fix pull-up/pull-down configuration to honor the argument parameter:
> > when argument is non-zero, enable the requested pull direction;
> > when argument is zero, clear all pull bits to disable.
> 
> Since this is a bug in a patch that hasn't been merged, please fix it in
> place and re-spin the pinctrl/GPIO/SPI-NOR series.

Oops, I forgot lore is out of synchronization now. Checked U-Boot main
again and it seems the pinctrl driver is already here. Please ignore this
comment.

Best regards,
Yao Zi

> > Signed-off-by: Eric Chung <eric.chung@riscstar.com>
