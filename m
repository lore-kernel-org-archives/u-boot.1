Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DDFCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 16:48:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABD4286DE8;
	Mon, 16 Oct 2023 18:46:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697474817;
	bh=Jq1gbt+lGejOuD9G3eAjBtEeg0x2rES4bS0oeeew4hs=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=PiY5UQk1o3b2EgiOwyVfU/tN78EEWffTQa1fg+u0CbXVuG/Z/fPNHCkLDMaOEzV31
	 Qrv3PWl6GkaKVvH5XaMXlXFIh9p99COYePAxr5cEzwBtZkIynEqtE9SqN1ZTfVHNl8
	 KIrcCHOFMtEEkSpKSbzahpKL19TciCuslHg8QMmWImvS1X2HplKTdIx1IQFif3Rs0l
	 MieuTg6g1xcD8L4qW76ra+uwI3yqk+DI2fpLDmCPeY0+AN07InJwmPLnYk4eK3c1WX
	 f+3GN5oKJghXva0x+y49wuB6xEFIPfV24E5mRSj9QkRLAMq/CrfCY4lJSLqqfQzEf3
	 b7JOp9WMHS97A==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DEF586E03; Mon, 16 Oct 2023 18:46:38 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E727E86F17
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 18:46:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8NL24wb5z1sClY;
 Mon, 16 Oct 2023 18:46:34 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8NL24pVSz1qqlS;
 Mon, 16 Oct 2023 18:46:34 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id 5TFkcnoGhaMW; Mon, 16 Oct 2023 18:46:33 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 18:46:33 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Marek Vasut <marex@denx.de>
X-Patchwork-Id: 1828414
X-Patchwork-Delegate: sbabic@denx.de
To: Marek Vasut <marex@denx.de>,u-boot@lists.denx.de
Subject: [PATCH] imx: hab: Use size parameter
In-reply-to: <20230831145724.80227-1-marex@denx.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016164638.1DEF586E03@phobos.denx.de>
Date: Mon, 16 Oct 2023 18:46:35 +0200 (CEST)
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

> The current code works by sheer coincidence, because (see HABv4 API
> documentation, section 3.4) the RVT authenticate_image call updates
> the size that is passed in with the actual size ROM code pulls from
> IVT/CSF . So if the input size is larger, that is "fine" . Pass in
> size instead to make this really correct.
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
