Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF20C61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 04:56:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00D3F82B7C;
	Thu, 12 Jun 2025 06:56:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="InEKRMvO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCE1382B97; Thu, 12 Jun 2025 06:56:21 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A55582B07
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 06:56:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55C4uHKR1561281;
 Wed, 11 Jun 2025 23:56:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749704177;
 bh=taKd4Ef3b0npdEFTGDC/ozjONVa5g5O19sC7/y6nvyA=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=InEKRMvOgDJgVGcXFQKa7+sDbINgp/aT/XZfMYd5mvPeYd8dQfkNyjysFKL7a7wRq
 yHzTd+jBHjTlST87A3lHROv7XOv6qUf59mGe5dLy0TrIgW2ByGxEP9ots3aKEbXPS/
 dfkrkNDKBgBp3u4/2CJcgP8xND/mkaibFGP8cIXY=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55C4uHbv2286540
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 11 Jun 2025 23:56:17 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 11
 Jun 2025 23:56:16 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 11 Jun 2025 23:56:16 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55C4uFbQ1423262;
 Wed, 11 Jun 2025 23:56:16 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 12 Jun 2025 10:25:40 +0530
Message-ID: <DAKACPN6Y7BP.3A56JS32H9QDF@ti.com>
CC: <u-boot@lists.denx.de>
Subject: Re: [PATCH -next 2/5] binman: add ti-dm entry to missing-blob-help
From: Anshul Dalal <anshuld@ti.com>
To: Bryan Brattlof <bb@ti.com>, Simon Glass <sjg@chromium.org>, "Alper Nebi
 Yasak" <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250611-missing-blob-help-entries-v1-0-c6de1844117f@ti.com>
 <20250611-missing-blob-help-entries-v1-2-c6de1844117f@ti.com>
In-Reply-To: <20250611-missing-blob-help-entries-v1-2-c6de1844117f@ti.com>
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
> Now that ti-dm is marked as a mandatory component for a successful
> build, adding some helping text about how to resolve a failed build will
> be needed. Add some text around what ti-dm is and links to more
> documentation on how to obtain the firmware binaries
>
> Signed-off-by: Bryan Brattlof <bb@ti.com>

Reviewed-by: Anshul Dalal <anshuld@ti.com>
