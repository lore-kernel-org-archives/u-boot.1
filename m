Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68243D2A545
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 21:30:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C76EB83B05;
	Thu,  4 Dec 2025 22:30:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=simong.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=simong.net header.i=@simong.net header.b="5wgV8ZL9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AFF583A5E; Thu,  4 Dec 2025 22:30:39 +0100 (CET)
Received: from simong.net (simong.net [IPv6:2a02:7b40:d4ed:e883::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47FC183A5E
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 22:30:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=simong.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simong@simong.net
Received: from simong.net (localhost [127.0.0.1])
 by simong.net (8.15.2/8.15.2) with ESMTPS id 5B4LUUkU013525
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 4 Dec 2025 22:30:30 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 simong.net 5B4LUUkU013525
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simong.net;
 s=default; t=1764883831;
 bh=XXaK3mZKq8QUZ0q2LH1E6WfoCh77HwXS86UeNR/l4rk=;
 h=From:To:Cc:Date:Subject:From;
 b=5wgV8ZL9MfZyFwzlbRZRG4dV/LwdktHquzCWwL7PGzKvdJvqNMVfrW3gWsMXG8ka3
 bLRrVv5NkDudGGdX0bDm2GmFRWIPZfH5Ptya25umaH7QdEn8Zwnxq6sqfc77ZXGYMX
 dCRGgQoA0un3Aggy1KVvJHhqgy+s+2uPoNQDx+nM=
Received: (from simong@localhost)
 by simong.net (8.15.2/8.15.2/Submit) id 5B4LUUcU013524;
 Thu, 4 Dec 2025 22:30:30 +0100
Message-Id: <202512042130.5B4LUUcU013524@simong.net>
From: Simon Gaynor <boundary@simong.net>
To: U-BOOT Mailing List <u-boot@lists.denx.de>
Cc: Simon Gaynor <simon.gaynor@ezurio.com>
Date: Thurs, 4 Dec 2025 13:29:21 -0800
Subject: [PATCH v2] nitrogen6x: change maintainer
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.6.2
 (simong.net [127.0.0.1]); Thu, 04 Dec 2025 22:30:31 +0100 (CET)
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

Simon Gaynor shall be the new maintainer

Signed-off-by: Simon Gaynor <simon.gaynor@ezurio.com>

diff --git a/board/boundary/nitrogen6x/MAINTAINERS b/board/boundary/nitrogen6x/MAINTAINERS
index 17018d69f64..c7355b0e40e 100644
--- a/board/boundary/nitrogen6x/MAINTAINERS
+++ b/board/boundary/nitrogen6x/MAINTAINERS
@@ -1,5 +1,5 @@
 NITROGEN6X BOARD
-M:	Troy Kisky <troy.kisky@boundarydevices.com>
+M:	Simon Gaynor <simon.gaynor@ezurio.com>
 S:	Maintained
 F:	arch/arm/dts/imx6dl-nitrogen6x.dts
 F:	arch/arm/dts/imx6q-nitrogen6x.dts
-- 
2.34.1

