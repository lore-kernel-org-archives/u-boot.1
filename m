Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA12C25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 10:20:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 573C988460;
	Tue,  4 Jun 2024 12:20:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717496401;
	bh=WBXBtoONHGwHueNtUJXEUwD1HOWTBmq+/+AM6/99GLQ=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UqCNY9yMGcUcsFQJerG3YoP1Rfq+MLYXFNTyziHnXZNgqMm4/EY7Gs9LjIllZdqra
	 GM4uHLAH/1U7xpA9vERwRWOH3VvMGem/j8C4Al7GuMEAPrRCKbT1ovz14DrOqzHA8p
	 xpEaSw1hveNdiWNbI3h12cx9W9QumjtSReT9aAK5NWiC5/4SV84l2Txu8Zq1pBQFPB
	 ncDbjQV9ZNfqIqRuRS69oH2uMb7RH8RiY4SBCpKSSQJQ4d7ciSsMazghkgCisbA7Gh
	 xD4Y3SLKuFsQE23i7BN3jc01+sudHVjDQ027fMnG06zuqwuutsz6MNBanfnk9TBMqP
	 I5kFyxusVO/2g==
Received: from eryximachos (unknown
 [IPv6:2001:861:52:5f60:ff6c:4545:dfcf:4c97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 032F58841E;
 Tue,  4 Jun 2024 12:19:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1717496400;
 bh=WBXBtoONHGwHueNtUJXEUwD1HOWTBmq+/+AM6/99GLQ=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=yAvrsv+kLEeEkNw93g4SiswhMoJgRC8b3q+2vVzknIvquuuPoIxCUGdNPNySBkUiQ
 fqSbHxUnlAaoIE7Hbo8Ek8ylJ2MRSZZSrTuPld3nEoGyLJSe3ceE/qF/z8mULy3S9t
 TTz3cy5UmiahtunSj9R8zO5Uom08aweskvKvFvnLXQZKxgs2juqGq4kY7JfHPZRw7N
 jHxmCabh6s0+T1qmsfT7BHdmK4lHfidtJnd1rNn3GZNniZd7RRceiQq8R1UY+Ymhde
 HQJvQj9olYzx15CZgjCxLVODya/ueyLtsOqWdTYRcBOvpYkH9Qql7kIgtD3Dizp8yi
 wQgIhZxwAPonQ==
Date: Tue, 4 Jun 2024 12:19:58 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] usb: Assimilate usb_get_descriptor() to linux
Message-ID: <Zl7qThUPiybZWK_p@eryximachos>
References: <20240517091820.3992-1-pro@denx.de>
 <92b158da-b023-4874-bdf2-dd3a1aa014af@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92b158da-b023-4874-bdf2-dd3a1aa014af@denx.de>
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

Good point. See V2.

On Fri, May 17, 2024 at 11:16:19PM +0200, Marek Vasut wrote:
> On 5/17/24 11:18 AM, Philip Oberfichtner wrote:
> > Before this commit, usb_get_descriptor() failed for some flakey USB
> > devices. We hereby adopt the more robust linux implementation [1].
> 
> Can you include which exact device fails and how? Details of the failure are
> valuable for the next person who runs into such a bug. Search engines index
> the ML posts too, so they become searchable using those.
> 
> Which kernel version is this imported from ? Commit ID would be good to add.
> 
> [...]

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-22  Fax: +49-8142-66989-80   Email: pro@denx.de
=====================================================================
