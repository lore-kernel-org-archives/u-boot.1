Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A925CDB482
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 16:48:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C339F86E11;
	Mon, 16 Oct 2023 18:46:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697474798;
	bh=d4Az2b5+VBJTVs/QFnv/4ZSAxtFgpEkRo2r9C989YnY=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=ZBSgcdztBufiM52MeIDfg4pWqUn2pSe9bP0d4dxjIFmmQc76ySzAwOyJ5EE35AT1s
	 P6zbPAg+gCGrUcJfz6FD37rZ8P+PBejvy7/lL1ZIQzdd0x02IPqWOeHal/VsbRLnPV
	 f+c7ZfpeYG7oqkY6opPnKgKyO+TAY9tXwGaB0mc9whAUciKN8GCY1QaZapBi8yADyc
	 SfBLdX3Xxbx8MGxixPQKVg1SXDoyYZlw/N9/yGlZ/mRIu2eN4n9lfn9M8NBt+8oCZ0
	 Y63Ok6yH6VVOB1q2imMTR1DF3NprBxoKjXnA5CiOEcgrXh0GTCu4VplAimtkY9PB5y
	 ZLpKHj4nS4Cuw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A541286E4F; Mon, 16 Oct 2023 18:46:28 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2613869EB
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 18:46:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8NKt2p1Mz1sClY;
 Mon, 16 Oct 2023 18:46:26 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8NKt2hYJz1qqlW;
 Mon, 16 Oct 2023 18:46:26 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id GenB2lhxrlb3; Mon, 16 Oct 2023 18:46:25 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 18:46:25 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Marek Vasut <marex@denx.de>
X-Patchwork-Id: 1837754
X-Patchwork-Delegate: sbabic@denx.de
To: Marek Vasut <marex@denx.de>,u-boot@lists.denx.de
Subject: [PATCH 1/5] spl: fit: Add board level function to decide application
 of DTO
In-reply-to: <20230921184420.45186-1-marex@denx.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016164633.A541286E4F@phobos.denx.de>
Date: Mon, 16 Oct 2023 18:46:27 +0200 (CEST)
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

> Add board-specific function used to indicate whether a DTO from fitImage
> configuration node 'fdt' property DT and DTO list should be applied onto
> the base DT or not applied.
> This is useful in case of DTOs which implement e.g. different board revision
> details, where such DTO should be applied on one board revision, and should
> not be applied on another board revision.
> Signed-off-by: Marek Vasut <marex@denx.de>
Applied to u-boot-imx, master, thanks !

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter  
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
