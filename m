Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4B7CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 11:51:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08CBF86CFE;
	Mon, 16 Oct 2023 13:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697457071;
	bh=BEfphKrtGFhtxc3TgsmR5kAWCS4S+yaORvunHspeFdg=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UHl45rp+IF82RR/Iv37wfDBjsDHpx5G+d34lGSdVoYNpqEgrvyQnjdxUGVo0swJOi
	 uuxJ2PJa1IlHKGlc+x9KfQGZWCyc85IeLnliRqf/CS3p4UPbNzNazMiKRXiihdPH02
	 m5NUvWwqMc3dFQmyaUsLpPI1lAIfpz4u1WOoIyuKgPIrYwXK+JaqamJSvYGS9iTCBI
	 zpo0zaJQn8QoHFI/kg+UJ4zm4T+z9/CErdirvNEzX2/pgVDm7rnYeM8fC3s5jauaB+
	 TckRjYtZk+BVttvF+aGanyvr4nYMMe35S0f6kgUqD+nJZ/3bYl7o4oNAFMvBV4nSF+
	 ST5rcXAncRZgQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2546A86B1D; Mon, 16 Oct 2023 13:51:02 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9118B8667B
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 13:51:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8Fn02LBZz1r3wq;
 Mon, 16 Oct 2023 13:51:00 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8Fn01sQ9z1qqlS;
 Mon, 16 Oct 2023 13:51:00 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id jZuNDa2P6MpV; Mon, 16 Oct 2023 13:50:58 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 13:50:58 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Teresa Remmet <t.remmet@phytec.de>
X-Patchwork-Id: 1822210
X-Patchwork-Delegate: sbabic@denx.de
To: Teresa Remmet <t.remmet@phytec.de>,u-boot@lists.denx.de
Subject: [PATCH v2 6/6] board: phytec: phycore_imx8mp: Add 4000MTS RAM timings
 based on PCB rev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016115103.2546A86B1D@phobos.denx.de>
Date: Mon, 16 Oct 2023 13:51:01 +0200 (CEST)
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

> Starting with PCB revision 3 we can safely make use of higher RAM
> frequency again. Make use of the EEPROM detection to determine the
> revision and use the updated RAM timings for new SoMs.
> Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
> Reviewed-by: Yannic Moog <y.moog@phytec.de>
> Tested-by: Yannic Moog <y.moog@phytec.de>
Applied to u-boot-imx, master, thanks !

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter  
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
