Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DCAD1BDE7
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 21:59:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 533EC83C28;
	Wed,  3 Dec 2025 22:59:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=simong.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=simong.net header.i=@simong.net header.b="k9hgqiY4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E3FA83C7B; Wed,  3 Dec 2025 21:47:24 +0100 (CET)
Received: from simong.net (simong.net [IPv6:2a02:7b40:d4ed:e883::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EA6383BF1
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 21:47:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=simong.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simong@simong.net
Received: from simong.net (localhost [127.0.0.1])
 by simong.net (8.15.2/8.15.2) with ESMTPS id 5B3KlGoY008395
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 3 Dec 2025 21:47:16 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 simong.net 5B3KlGoY008395
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simong.net;
 s=default; t=1764794837;
 bh=KV41iIfyLT3+z9DrtveqCFAPnRfttr3IHisZnhhhBzw=;
 h=From:To:Cc:Date:Subject:From;
 b=k9hgqiY4+65td15emagEF92hJAgCKwyYYdk1b4iSKKbJ20LXvo81tlTIHW1V+TiZy
 pK0u86Ug9De3N09IAf8HH69bMwl4RjZEzkxP043SSMxsgSd2yPD/rKG4qsDQvyv8E0
 4AwecNr6o14y/tvbHVaS9HTAnwnNDbX/pi4xf978=
Received: (from simong@localhost)
 by simong.net (8.15.2/8.15.2/Submit) id 5B3KlGos008394;
 Wed, 3 Dec 2025 21:47:16 +0100
Message-Id: <202512032047.5B3KlGos008394@simong.net>
From: Simon Gaynor <boundary@simong.net>
To: U-BOOT Mailing List <u-boot@lists.denx.de>
Cc: Simon Gaynor <simon.gaynor@ezurio.com>
Date: Wed, 3 Dec 2025 12:45:27 -0800
Subject: [PATCH] nitrogen6x: change maintainer
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.6.2
 (simong.net [127.0.0.1]); Wed, 03 Dec 2025 21:47:17 +0100 (CET)
X-Mailman-Approved-At: Wed, 03 Dec 2025 22:59:30 +0100
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

Simon Gaynor shall be maintaining the new maintainer

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

