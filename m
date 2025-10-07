Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827F6CCA470
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 12:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C62A483935;
	Tue,  7 Oct 2025 14:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xTUyVQ5i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F071E83C9F; Tue,  7 Oct 2025 14:14:28 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA8ED83918
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 14:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 597CELoj009216;
 Tue, 7 Oct 2025 07:14:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759839261;
 bh=o0k4VXx6fTdfP7azgdmHmIhTzhUzCcvA9zy4rYF7Fco=;
 h=Date:To:CC:Subject:From:References:In-Reply-To;
 b=xTUyVQ5i4VzK3IVMz0Q4uCP24wieKUixhnKBqrc45q7Fce/tZb9XeQil/2hYfzGtG
 w7OBB3hDRUk5R8F3vI+GZ9T+MXILbho0pBKwpnBuJsRtKUR0XUVz5C3W3j3mNAljwD
 rKh1Qc6By1JoGiC+XVhJiDzDFsynTKbnRgHoJw44=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 597CELXi3579080
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 7 Oct 2025 07:14:21 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 7
 Oct 2025 07:14:21 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 7 Oct 2025 07:14:21 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 597CEKAY859349;
 Tue, 7 Oct 2025 07:14:20 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 7 Oct 2025 17:44:19 +0530
Message-ID: <DDC2YB35829H.25C5UU32Q009E@ti.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Bhupesh Sharma <bhupesh.linux@gmail.com>, Neha
 Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, Anshul
 Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>
Subject: Re: [PATCH v2] ufs: ti-j721e: Correct error detection
From: Anshul Dalal <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251007-ufs_ti-v2-1-501f575b6947@linaro.org>
In-Reply-To: <20251007-ufs_ti-v2-1-501f575b6947@linaro.org>
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

On Tue Oct 7, 2025 at 5:12 PM IST, Andrew Goodbody wrote:
> In ti_j721e_ufs_probe there is a call to clk_get_rate but the code after
> that attempts to detect an error from that call incorrectly uses
> IS_ERR_VALUE.  Instead the test should just be for regular error codes.
> The call returns an unsigned long so that needs to be cast to a signed ty=
pe
> first of all.
>
> This issue was found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Anshul Dalal <anshuld@ti.com>

Regards,
Anshul
