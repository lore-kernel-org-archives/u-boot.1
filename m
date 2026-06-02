Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C98ACD6E57
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 13:43:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A1A284867;
	Tue,  2 Jun 2026 15:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="mA2da18X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E2F784868; Tue,  2 Jun 2026 15:43:25 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03ABD84857
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 15:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id A1F721A37D2;
 Tue,  2 Jun 2026 13:43:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6BE4C603BC;
 Tue,  2 Jun 2026 13:43:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E82C9108883E7; 
 Tue,  2 Jun 2026 15:43:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780407801; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=38pCtzhgtGpXQatvKMtYimUYSJiFjjej2LI9oZBs0i4=;
 b=mA2da18XZ52e2FqZWd1VmUsSPddcc8Z9MtWCj25qI+bFRwUPfIon+CnpOdW2+tKKCxMzld
 R53UG0zJte1GNW4E9HhEezIxaZCc79oC8xTjz1znWaWfBy20iNhzybTsxYaiyyxQOTtHd1
 QmiWmAAIvWN2UUy8F6F6aze0yyhWSRlPplEPyZqyRdK5c0EtlmwtsbEAn0sWERMtBuutOO
 ENP9hacDaMMAdePds6Bsh83qQ8ZSdplv9NYna/TIuHc+aIBIuoaQtUHCGqyXFrS9OIHU9X
 UE9znQExH1tgJBmV28DcejBhLb7PO3LzFEIpPNrr6UmhA5x1R1CrJ490cSkBAA==
Message-ID: <867bd0f9-f975-42a5-bd51-7afde868552e@bootlin.com>
Date: Tue, 2 Jun 2026 15:43:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/20] board: ti: j721e: Add resume detection for
 J721e/J7200
To: Thomas Richard <thomas.richard@bootlin.com>, Tom Rini
 <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, Udit Kumar
 <u-kumar1@ti.com>, Abhash Kumar <a-kumar2@ti.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
References: <20260430084414.1354490-1-richard.genoud@bootlin.com>
 <20260430084414.1354490-4-richard.genoud@bootlin.com>
 <67e5312d-a68c-4b95-8d7f-6fef9b41bb04@bootlin.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <67e5312d-a68c-4b95-8d7f-6fef9b41bb04@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Le 01/06/2026 à 10:29, Thomas Richard a écrit :
> On 4/30/26 10:43 AM, Richard Genoud (TI) wrote:
>> From: "Thomas Richard (TI)" <thomas.richard@bootlin.com>
>>
>> Add the capability to detect a resume. This overrides the weak
>> function j7xx_board_is_resuming(void).
>> To detect the resume, SPL searches a magic value (0xBA) in a register
>> of PMICA.
>> This value is set by DM-Firmware during the suspend sequence.
>>
>> Signed-off-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
>> Co-developed-by: Gregory CLEMENT (TI) <gregory.clement@bootlin.com>
>> Signed-off-by: Gregory CLEMENT (TI) <gregory.clement@bootlin.com>
>> Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
>> Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
>> ---
>>   board/ti/common/k3-lpm.h | 17 +++++++++++++++++
>>   board/ti/j721e/evm.c     | 37 +++++++++++++++++++++++++++++++++++++
>>   2 files changed, 54 insertions(+)
>>   create mode 100644 board/ti/common/k3-lpm.h
>>
>> diff --git a/board/ti/common/k3-lpm.h b/board/ti/common/k3-lpm.h
>> new file mode 100644
>> index 000000000000..a2141a0c25a8
>> --- /dev/null
>> +++ b/board/ti/common/k3-lpm.h
>> @@ -0,0 +1,17 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * Copyright (C) 2026, Texas Instruments Incorporated - https://www.ti.com/
>> + * Copyright (C) 2026, Bootlin
>> + */
>> +
>> +#ifndef __K3_LPM_H
>> +#define __K3_LPM_H
>> +
>> +/* Magic value in PMIC register to indicate the suspend state (SOC_OFF) */
>> +#define K3_LPM_MAGIC_SUSPEND 0xba
>> +
>> +/* PMIC register where the magic value resides */
>> +#define K3_LPM_SCRATCH_PAD_REG 0xcb
> 
> K3_LPM_SCRATCH_PAD_REG_3 so we easily know it is scratchpad reg 3.
ok

> 
> We currently use the entire SCRATCH_PAD_REG_3 register to mark a resume.
> Some PMICs in certain configurations use some scratchpad registers for
> other purposes, so we could consider using only a specific bit range (or
> even a single bit) and document it. This would free up the remaining
> bits for other uses.
> However, an 8-bit magic value is likely more robust against accidental
> user modification.
> No strong opinion, just raising the topic for discussion.
This is indeed a good point.

Thanks!

> 
> Best Regards,
> Thomas

Regards,
Richars
