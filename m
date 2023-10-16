Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A737CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 11:50:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A398186A26;
	Mon, 16 Oct 2023 13:50:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697457054;
	bh=2iQz30WzsYOaxEMOltaMwBJ5QsB4uNwGQpdMQsdBT/s=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Vm5uNPU9nXv628ovq2ggnW2cZo1jljgMTzhQ4VSAG+sCx+1g7TnliAeMIkIZiI+x9
	 X4aBGZiZ/OOjGQzbi44SpIKkb6EwX6hvkR1060+DW4qfWjMIPU1N1DgsmO/Z4hawR/
	 tqv3XrRzfYRCZkmu8MvwE8RWtucixhhOgRQDABZys5aeGmRxKjv8QdXvWBpS1j/P79
	 b3hpDHWHGbF7cfGrEU/gJVXElYEaG4zZppyXStkMZi1Jf3HqPcGGwcXLKu1/dk95+i
	 IfaDoSAtTuUfqvAUFzkK1rqFmC5MIqbSnDZplokATRIH8sTRzh6Y/6TKigVPVnKJiD
	 67kVTrcf58VDQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E354580090; Mon, 16 Oct 2023 13:50:50 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF74D86B05
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 13:50:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8Fmm0d7Fz1sClr;
 Mon, 16 Oct 2023 13:50:48 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8Fml704Cz1qqlS;
 Mon, 16 Oct 2023 13:50:47 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id 28IXmC-0gMOe; Mon, 16 Oct 2023 13:50:47 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 13:50:47 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Teresa Remmet <t.remmet@phytec.de>
X-Patchwork-Id: 1822211
X-Patchwork-Delegate: sbabic@denx.de
To: Teresa Remmet <t.remmet@phytec.de>,u-boot@lists.denx.de
Subject: [PATCH v2 5/6] board: phytec: common: phytec_som_detection: Add
 helper for PCB revision
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016115050.E354580090@phobos.denx.de>
Date: Mon, 16 Oct 2023 13:50:49 +0200 (CEST)
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

> Add helper function to read out the PCB revision of a PHYTEC SoM.
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
