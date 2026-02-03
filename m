Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65583E87829
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 13:49:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E520784222;
	Tue,  3 Feb 2026 14:49:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="x3CLFjEY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82EB984248; Tue,  3 Feb 2026 14:49:46 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B17D84206
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 14:49:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id CFEDCC211C9;
 Tue,  3 Feb 2026 13:49:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6CD0860728;
 Tue,  3 Feb 2026 13:49:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 57F08119A8888; Tue,  3 Feb 2026 14:49:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1770126582; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language;
 bh=I10zY8qYoA/YCyJ6oCqtcSlLHGoKzL6Q4QlSUpYeC9M=;
 b=x3CLFjEYyaxJJEWv/Zfc8YqRxGzyDc0/O57A4eilhG5ki4BhOX3+npaWeHqB9PDi00rSxP
 OD25TWiV7SiMN9PlN84r51Y3MEgRj7VwMziLfm5xckNxhT6lFT9b3y7SuSQPArzcy3vik7
 V0IDGcyMcXyTG6vOYqJCnZgudpxUqJhCmUQH9GRoeo8vjnbgjHYWAnUPLf/cytqoRAI7Nf
 pDlNnPP+bAU/yHVYTqj0NqPCdpijZFx4KwYIiMPXyUs9H/M+PNBgCJiUgCI/MfnTz61yH+
 49UINE/I26cvMKnE+omTHj9i2YIGgrsE0y7pfAVN3CLjExLunfS++B2xj0ITWA==
Message-ID: <cf501633-465c-4024-a728-ec830ab16af0@bootlin.com>
Date: Tue, 3 Feb 2026 14:49:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, fr
From: Richard GENOUD <richard.genoud@bootlin.com>
To: Bryan Brattlof <bb@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Chintan Vankar <c-vankar@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Kumar, Udit"
 <u-kumar1@ti.com>
Subject: Missing power domain in j722s/dev-data.c
Organization: Bootlin
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Bryan,

When trying to discuss with the PMIC on a J722S-evm board in U-Boot R5 
SPL, I got the error:
ti_power_domain_of_xlate(power_domain=81fffe2c, id=107)
ti_power_domain_of_xlate: invalid dev-id: 107

PMIC device lookup was done with:
uclass_get_device_by_name(UCLASS_PMIC, "pmic@48", &pmic);

After checking the file arch/arm/mach-k3/r5/j722s/dev-data.c, the id 107 
is indeed missing.

Could the missing dev-id be added it the file?

Regards,
Richard

