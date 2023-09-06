Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F65CEE14B9
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 18:10:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBBC48698F;
	Wed,  6 Sep 2023 20:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WzzErFv2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63C7C86995; Wed,  6 Sep 2023 20:10:15 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6FC2866EC
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 20:10:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 386IAAxu086204;
 Wed, 6 Sep 2023 13:10:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694023810;
 bh=FV9LvhZqTmE3ud/PF8wcLvivruZpaLG1tLxSiuJvLX4=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=WzzErFv2J6dnY93OsjmVoo0XNMRiipVUoxLGZAyl1JZ+8Mi+ObBWWo8H9XMJiMDGd
 BPzgNbUGtWHhEwoyyOj2PYZT+X2QzleMKwiJOu0v+BWflNO0V1hkcxSbDh/5txkGFS
 SESBFj5WQPeFHW3V4Fz6CTxpeDxlIwzNASaAwMPQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 386IAAVj106630
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Sep 2023 13:10:10 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Sep 2023 13:10:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Sep 2023 13:10:10 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 386IAAv6130343;
 Wed, 6 Sep 2023 13:10:10 -0500
Date: Wed, 6 Sep 2023 13:10:10 -0500
From: Nishanth Menon <nm@ti.com>
To: Reid Tonking <reidt@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <n-francis@ti.com>,
 <u-kumar1@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <m-chawdhry@ti.com>
Subject: Re: [PATCH 3/3] arm: dts: j7200: dtb sync with Linux 6.5-rc1
Message-ID: <20230906181010.5rzbmfh2xzjgs7au@safely>
References: <20230905181309.61666-1-reidt@ti.com>
 <20230905181309.61666-4-reidt@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230905181309.61666-4-reidt@ti.com>
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

$subject: s/dtb/device tree or dts

On 13:13-20230905, Reid Tonking wrote:
> Sync j7200 device tree files with Linux 6.5-rc1

With that..

Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
