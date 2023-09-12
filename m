Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E57DCA0ECA
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 09:23:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F39B81FA8;
	Tue, 12 Sep 2023 11:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="u7YkXz2a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50548833F5; Tue, 12 Sep 2023 11:23:05 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA8498063E
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 11:23:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38C9N0Vv108500;
 Tue, 12 Sep 2023 04:23:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694510580;
 bh=R9MRfiI5eJX408pUS7/tIcjGdsbLD4KHu1P/wFRLNqk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=u7YkXz2a0zlMqTxALprSLravo1wCfXXj2ppL5bRUtDqFEd7fa1mHbULCB7edC3kjY
 yPHs84cDXxytdAS+fwiVBJMxZgMjYkPvfE1Fv/O2Vps68r8KxgGS9JLTfu3tzk5IF8
 8RoJjkSP1F0JRay6ZcjIjaE/+fzg6NbfKF6ZEhM4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38C9N03M106824
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Sep 2023 04:23:00 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Sep 2023 04:23:00 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Sep 2023 04:23:00 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38C9Mxli069785;
 Tue, 12 Sep 2023 04:22:59 -0500
Date: Tue, 12 Sep 2023 14:52:58 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Kamlesh Gurudasani <kamlesh@ti.com>
CC: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew
 Davis <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, <u-boot@lists.denx.de>,
 Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
 Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH 0/2] RFC version for ATF and OP-TEE Firewalling
Message-ID: <20230912092258.qmey6x5jxsmktdqg@ula0497581>
References: <20230905-binman-firewalling-v1-0-3894520bff8a@ti.com>
 <87edj3hhog.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87edj3hhog.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Kamlesh,

On 14:49-20230912, Kamlesh Gurudasani wrote:
> Manorit Chawdhry <m-chawdhry@ti.com> writes:
> 
> > This is a start to firewall ATF and OP-TEE memory regions using the
> > firewalls present in K3 SoCs. Please give reviews as to what can be
> > better in the implementation.
> >
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> Hi Manorit, thanks for the patches.
> 
> I hope this solution is easily scalable to sitara devices as well.
> Mainly considering the difference in type of firewalls.

I am trying to keep both types of devices in mind and will change the
implementation if required to incorporate both of them. I don't see any
problems as such in the current implementation w.r.t Sitara devices
also, will see if any occurs and will update you. Thanks.

Regards,
Manorit

> 
> Regards,
> Kamlesh
