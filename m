Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3614BD10DD1
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 09:09:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8358A894A8;
	Mon,  2 Dec 2024 10:09:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="5UwFm9Zc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B324A894B7; Mon,  2 Dec 2024 10:09:34 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 389AD88BB7
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 10:09:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2066b4005c=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B28wQWx012763;
 Mon, 2 Dec 2024 10:09:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=selector1; bh=BIlBgfbr7bIZLursJExrFv
 Ib4NLiupBVxhdFvggbnNU=; b=5UwFm9ZchzasbiE+2Ny6T4AbMLABW2rmkMBZ9i
 YyoBepTos3NyWAHMCvwp/drNQl1xYftq3sBKl71N0F9neXyrzEFj3LJFMIGGOuX5
 sgcEHeb5rpriXzYhEmrBlJtq2VaXc2+dLWr/UbAeUgqlMksyVzDKCW2NCk45aVDg
 wgJdbNhUdgqOwOvlxgH8gYL65OSMGEM4VobcQl/yCH+fUYP1S3H0YuZkZZLvY1QM
 r3n95l415ATSb7QimpMgMHjQGP6vEpMzQ0XM02BLY8Sd4oFV0mao8t2hrWysTtCf
 j5H9gCIOFlcMr80vLJzm+9zRW8CzqMyh+G2BRLAWu/dGFwEw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 437s0kq5ns-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Dec 2024 10:09:31 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id ADC4740049;
 Mon,  2 Dec 2024 10:08:56 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C7650266A2C;
 Mon,  2 Dec 2024 10:08:49 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 2 Dec
 2024 10:08:49 +0100
Message-ID: <a7df8a2a-78c8-4542-8af8-dab3c4b59392@foss.st.com>
Date: Mon, 2 Dec 2024 10:08:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
CC: <christophe.priouzeau@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, <etienne.carriere@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: unable to access 'https://source.denx.de/u-boot/u-boot.git/'
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
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

Hi All

Since several days, it seems that U-Boot git repository is not accessible.

Fetching or cloning u-boot repo leads to the following issue: 

git clone https://source.denx.de/u-boot/u-boot.git
Cloning into 'u-boot'...
fatal: unable to access 'https://source.denx.de/u-boot/u-boot.git/': The requested URL returned error: 403

Thanks
Patrice

