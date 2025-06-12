Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394A1C61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 04:56:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DF1282A4B;
	Thu, 12 Jun 2025 06:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Lgrha+DI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD95F82B07; Thu, 12 Jun 2025 06:56:02 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 700EC828A2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 06:56:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55C4tvm82807626;
 Wed, 11 Jun 2025 23:55:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749704157;
 bh=uac/EVtsf0htBNmdjwp7MrqIA9jQS4qowhBMs4rNwaM=;
 h=Date:Subject:From:To:CC:References:In-Reply-To;
 b=Lgrha+DIxj4i8YDvtMlUoGfL7xEeg61wOJ0djHbNKIq3j3i7FkHo/Lpu5VH13cDO7
 Y4f+4vcdJq3yVeCWECvCOCJgTTG/lX/QKdAr62/nFr1R/MYy7UQmfAqFR5MHBQtQLy
 4M5elOa3LvhztPZHLmBPUFBmxqclBqMwlUhI/C4o=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55C4tv671529876
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 11 Jun 2025 23:55:57 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 11
 Jun 2025 23:55:57 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 11 Jun 2025 23:55:57 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55C4tuII1593597;
 Wed, 11 Jun 2025 23:55:56 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 12 Jun 2025 10:25:21 +0530
Message-ID: <DAKACGQ3IVUW.40I5D2WG1GR7@ti.com>
Subject: Re: [PATCH -next 1/5] binman: alphabetize missing-blob entries
From: Anshul Dalal <anshuld@ti.com>
To: Bryan Brattlof <bb@ti.com>, Simon Glass <sjg@chromium.org>, "Alper Nebi
 Yasak" <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250611-missing-blob-help-entries-v1-0-c6de1844117f@ti.com>
 <20250611-missing-blob-help-entries-v1-1-c6de1844117f@ti.com>
In-Reply-To: <20250611-missing-blob-help-entries-v1-1-c6de1844117f@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On Wed Jun 11, 2025 at 11:47 PM IST, Bryan Brattlof wrote:
> As the list of entries grows let's alphabetize the list to make
> searching a little easier. No functional changes intended
>
> Signed-off-by: Bryan Brattlof <bb@ti.com>

Reviewed-by: Anshul Dalal <anshuld@ti.com>
