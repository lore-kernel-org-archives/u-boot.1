Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090D2C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 28 Jun 2025 22:11:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6443E82B34;
	Sun, 29 Jun 2025 00:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=benettiengineering.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=aruba.it header.i=@aruba.it header.b="WCaMAmtk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27BA482DA1; Sun, 29 Jun 2025 00:11:49 +0200 (CEST)
Received: from smtpdh20-1.aruba.it (smtpdh20-1.aruba.it [62.149.155.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 904F682977
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 00:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=benettiengineering.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=giulio.benetti@benettiengineering.com
Received: from [192.168.50.220] ([84.33.84.190]) by Aruba SMTP with ESMTPSA
 id VdluuPCG7qg4pVdluuea2v; Sun, 29 Jun 2025 00:11:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
 t=1751148703; bh=z0u7Jr1VOFrXFb7DtJ3IhMO5b3hJt133LLuk8HLSPlY=;
 h=Date:MIME-Version:Subject:To:From:Content-Type;
 b=WCaMAmtkMKYGUTaC0bVIkhp+0/BoJeihK1pU2PPduIKrCYruLSW9B6ZrClKu+dJDg
 VTX7aZ8yNLuvI/uw5ih3ABZZ9BoMR4NpA+Orrj8nLEtb7uP6E1YX7rxensaYv+ZaKy
 8IGXEvbCeaLLNYIYMHUngjHoI0NjXU99rXAKUuRTSwCKVD6WKqLJygJKfpUoReJN4D
 VaaE01FE7QAaTtDm9VmhCjeosAsVwi1VwcLfSaDqowSb2xy9aevC+gzHwtlbcAblJE
 zWIeniCZkmjsUmCAR8EZD97Q3kHr1LO7xjC0MboOjZ+KwGZCr9MAZ/CGaBHkxT3pdw
 EGJ2FskM/wQVQ==
Message-ID: <9328607c-51f3-4579-8f67-2cdb1551c72a@benettiengineering.com>
Date: Sun, 29 Jun 2025 00:11:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch/arm/include/asm/arch-imxrt/gpio.h: imxrt gpio use
 commong gpio.h
To: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@nabladev.com>, uboot-imx@nxp.com,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250628214656.2395915-1-giulio.benetti@benettiengineering.com>
 <7fe3036a-602f-4ab5-8a8a-ffabd0a3ae0e@benettiengineering.com>
 <CAOMZO5BZR9e2EFKJho1QFM4B96L9oCKf=3+ZohfYujh7iFzUsg@mail.gmail.com>
Content-Language: en-US
From: Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <CAOMZO5BZR9e2EFKJho1QFM4B96L9oCKf=3+ZohfYujh7iFzUsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIPi11kFcwxlSbQr2k4RDs1nkiRedjWyY2w7jDX3VF5Uru798CZaxhuVaQaww8e2OG/oBui59F9sVUJuEkpRfeWPAL+3nXvAQr8E/tDDC5E+dWA7Y0u4
 TMw56fyti22VLuTdqUVDUAMkENVrgLhm5u/dYoOAkjJOy8OYSwSbPL5kRZU8VrUGyc8quMvIXmfk9qX3OGQyLxVXY4qiZmQZgp3NC1TYc6cixLU2FAqDs2gf
 NSIbj4i8oVmCm0/g3/ar1+CxY4IV1WRJ+0LKsIoEtxaUF7qMhQUYTppTcF0LXfOMm91dcB9uZAtG1e2Ucm0ZMtaWK5rBeZWOmZQ5IuemMkA=
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

Hi Fabio,

On 6/28/25 23:49, Fabio Estevam wrote:
> Hi Giulio,
> 
> On Sat, Jun 28, 2025 at 6:48 PM Giulio Benetti
> <giulio.benetti@benettiengineering.com> wrote:
>>
>> s/commong/common
>>
>> can please the committer fix the subject when/if applying?
> 
> Please send a v2 with this fix and include a brief commit log that
> explains the reason for this change.

Ok, thank you for reviewing.

Best regards
-- 
Giulio Benetti
CEO&CTO@Benetti Engineering sas
https://www.linkedin.com/company/benetti-engineering-sas/
https://www.linkedin.com/in/giulio-benetti-79975951/

