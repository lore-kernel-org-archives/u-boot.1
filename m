Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB4BCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:27:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61FCD86F1E;
	Mon, 16 Oct 2023 11:23:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697448197;
	bh=JJOFrgJ18rEyiLXvNzmg33DjB0TFwjoWIy4WBGdEJCg=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=Cbjte3RzHdXO2Uf32MZ3F9lyC8dqkC1bAd83uQUAYGJ4bY2mqtYnAGvNgSjOvDVaQ
	 OD6C+TUWFbT6HM2fXZ5aNcsoKviYZFB88jWWOQy39Ca864i6oPFTa5u4S/qQ0XnBL0
	 vXz8+PpVUmIZKQgsQnJIk5Cp6JRZs39TXt9JeqRdyDsCa5dXSQalzL7UoqFMl0t0Bu
	 VUvvneeLZPKUL2t0hz7nCcpBy0M+kDqdtxVtXcXwzR2+BA2O451VH/FwHCdeU7Soey
	 qzJW0mXfPfmlNfDNlW1vz97NRbfkrLjsM5MetGVA82QJbDLUCvOPiH6/3og+hNwZYh
	 7nGrEL4dlPjbA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43E4486DD5; Mon, 16 Oct 2023 11:22:29 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B947E86CAF
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:22:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8BTP3k6Rz1sCln;
 Mon, 16 Oct 2023 11:22:17 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8BTP3SWDz1qqlW;
 Mon, 16 Oct 2023 11:22:17 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id J5WqFDRxs5bf; Mon, 16 Oct 2023 11:22:16 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 11:22:16 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Tim Harvey <tharvey@gateworks.com>
X-Patchwork-Id: 1825581
X-Patchwork-Delegate: sbabic@denx.de
To: Tim Harvey <tharvey@gateworks.com>,u-boot@lists.denx.de
Subject: [PATCH v2] arm: imx: imx8m: add optee configuration to ft_system_setup
In-reply-to: <20230824190517.981411-1-tharvey@gateworks.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016092233.43E4486DD5@phobos.denx.de>
Date: Mon, 16 Oct 2023 11:22:21 +0200 (CEST)
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

> If optee is detected configure it in the Linux device-tree:
>  - add /firmware/optee node
>  - add /reserved-memory nodes for optee_core and optee_shm
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
Applied to u-boot-imx, master, thanks !

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter  
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
