Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A38C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 19:52:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C21E870F5;
	Mon, 13 Nov 2023 20:52:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nzgkwJ13";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 930A987124; Mon, 13 Nov 2023 20:52:22 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57003870D0
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 20:52:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ADJqGVX095897;
 Mon, 13 Nov 2023 13:52:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699905136;
 bh=HcJ8wLxVXMXwRc9yvBSm+XqcoQYpGVOWvsFmhM3Apzk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=nzgkwJ13BUj5q6fJCrxUTO0WoPBfbB4l99xLhq+r4Img+iAU6DWKE/xEqulaNfcaJ
 V1ohVYcCT7LWOOEoBYC9Yb1OWv/6+0UqE4WaRXX5SrS4+ys5UJA+7OW17SzItHZMch
 puRD3p4QdJPxCEwwC4q1lMvLPqHsM1Ny6JN2mFEo=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ADJqG31083598
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 13 Nov 2023 13:52:16 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 Nov 2023 13:52:16 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 Nov 2023 13:52:16 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ADJqG6t080672;
 Mon, 13 Nov 2023 13:52:16 -0600
Date: Mon, 13 Nov 2023 13:52:16 -0600
From: Nishanth Menon <nm@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <u-boot@lists.denx.de>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <reidt@ti.com>, <m-chawdhry@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: misc: Move esm-k3.txt to
 ti,j721e-esm.yaml
Message-ID: <20231113195216.m7itxtjh467vv3yr@equity>
References: <20231113043023.2126690-1-n-francis@ti.com>
 <20231113043023.2126690-2-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231113043023.2126690-2-n-francis@ti.com>
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

On 10:00-20231113, Neha Malcom Francis wrote:
> Move esm-k3.txt to ti,j721e-esm.yaml in line with the devicetree
> documentation in kernel.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  doc/device-tree-bindings/misc/esm-k3.txt      | 25 ---------
>  .../misc/ti,j721e-esm.yaml                    | 53 +++++++++++++++++++

What is the rule here?
https://tgit.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/misc/ti,j721e-esm.yaml
we have the binding in upstream kernel.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
