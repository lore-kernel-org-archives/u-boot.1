Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0D6CDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 11:51:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C8DB86D56;
	Mon, 16 Oct 2023 13:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697457071;
	bh=kXsRjQkKB+3yvVYjbyi0HLOZEYFjF5q38iAnsy75PFU=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Cf7/Tv00ODNRNwJbV9iDAcZDDKJt4q6qcz9PBiGjF7ajL4I5Yd/7gUXoyex9ib4d2
	 qtWUGSJ0UpCs6nB9JsdqfpD4AkywGy4l30LJol6wuxJt4259wuWG89kqEIz/f0lnix
	 XZsxgS/LwCsFylnXX00WlKsF5NVErtvnRQXZBEjbwOAa8GCNCMbbqUULVAUxjCv3TH
	 5/zYEztYDP33E4pqNu6jDweks87yzyPmjoIx4VkSobZESU9d2TB51Y5Fp8eOkpC/nF
	 8dBggcA7DcpVsKclv3AfHM2NnopPqpf+qEt9kXQ3OOvyjQyKRFqBZOdebVvuFrmTv+
	 YZx5uAJ9pzHJA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A994B86BE0; Mon, 16 Oct 2023 13:51:07 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7807980090
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 13:51:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8Fn36sYnz1r3wp;
 Mon, 16 Oct 2023 13:51:03 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8Fn36mZQz1qqlS;
 Mon, 16 Oct 2023 13:51:03 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id LIPnBgjGQvbh; Mon, 16 Oct 2023 13:51:03 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 13:51:03 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Teresa Remmet <t.remmet@phytec.de>
X-Patchwork-Id: 1822209
X-Patchwork-Delegate: sbabic@denx.de
To: Teresa Remmet <t.remmet@phytec.de>,u-boot@lists.denx.de
Subject: [PATCH v2 4/6] board: phytec: phycore_imx8mp: Update 2GB RAM Timings
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016115108.A994B86BE0@phobos.denx.de>
Date: Mon, 16 Oct 2023 13:51:04 +0200 (CEST)
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

> Due to PCB layout constraints in PCB revisions until including 1549.2,
> a RAM frequency of 2 GHz can cause rare instabilities. Set the RAM
> frequency to 1.5 GHz to achieve a stable system under all conditions.
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
