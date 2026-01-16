Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F8ED4899A
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 12:30:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75EDC82BF2;
	Fri, 16 Jan 2026 13:30:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mr1NHNue";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C46A8309A; Fri, 16 Jan 2026 13:30:34 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D76F80077
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 13:30:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EF99F60167;
 Fri, 16 Jan 2026 12:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4A4C116C6;
 Fri, 16 Jan 2026 12:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768566630;
 bh=ceh1sCezJII42yh03X+ujM+6rZ8Mk3HQ1ORhdzKtlFA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=mr1NHNuewBt7M6GwEyAMe2aCAlNbmDJ9hG6IISf4MfSvT1dUnm0Rq4DBNfIUcl1Z5
 O/QWeRpRb8YsP/rGdRtTeFBCJEokLj6nm9gdWm9b9wp6VBTp5XRoUYXYUk0TB+mlml
 hzNnMesZ4L40fMsoLUD2+cn/o/s3qSr/iYLXONjcr4ZL5DyrG67JXdUOyehF+o74Da
 1S39sE+xYwNaDX0Q6eF+xRy3sO2VeITcj7bHnYwAMSUolJgs9HEauiOG+GOexKSqAF
 QqBK/CNhGbp4nhqZqrFRsiLwlF/H/Dh+DwUE55ogzKF997OOl/DFrBA9p9V5CgdMyZ
 S4ZyjXBzR/LMA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, Casey Connolly
 <casey.connolly@linaro.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Casey Connolly
 <casey.connolly@linaro.org>, Kaustabh Chakraborty
 <kauschluss@disroot.org>, Jonas Karlman <jonas@kwiboo.se>, Sam Protsenko
 <semen.protsenko@linaro.org>, Balaji Selvanathan
 <balaji.selvanathan@oss.qualcomm.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>
Subject: Re: [PATCH 1/3] usb: common: default dr_mode to OTG when not set
In-Reply-To: <875x93fd54.fsf@kernel.org>
References: <20260114-casey-usb-role-switch-v1-0-fb7a626466b9@linaro.org>
 <20260114-casey-usb-role-switch-v1-1-fb7a626466b9@linaro.org>
 <875x93fd54.fsf@kernel.org>
Date: Fri, 16 Jan 2026 13:30:28 +0100
Message-ID: <877btheo4b.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

On Thu, Jan 15, 2026 at 10:17, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:

> Hi Casey,
>
> Thank you for the patch.
>
> On Wed, Jan 14, 2026 at 15:13, Casey Connolly <casey.connolly@linaro.org> wrote:
>
>> DT bindings dictate that dr_mode being unset on a DRD capable USB
>
> For the curious, this is defined in https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/usb/usb-drd.yaml#n23
>
>> controller means we should default to OTG mode. Adjust usb_get_dr_mode()
>> to reflect this.
>>
>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>> ---
>>  drivers/usb/common/common.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
>> index 13e9a61072a9..e3bd7339e68e 100644
>> --- a/drivers/usb/common/common.c
>> +++ b/drivers/usb/common/common.c
>> @@ -29,9 +29,10 @@ enum usb_dr_mode usb_get_dr_mode(ofnode node)
>>  
>>  	dr_mode = ofnode_read_string(node, "dr_mode");
>>  	if (!dr_mode) {
>>  		pr_debug("usb dr_mode not found\n");
>> -		return USB_DR_MODE_UNKNOWN;
>> +		/* Default to OTG mode as per DT bindings */
>
> Nitpick: can we change the comment to:
> /* Default to OTG mode as per devicetree/bindings/usb/usb-drd.yaml */
>
> This tells the same but is more precise and is imho, a more helpful
> comment.
>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

Also, I just noticed, but there is another similar change here:
https://lore.kernel.org/all/20260108-usb-dwc3-exynos7870-v3-1-343fa1e81e48@disroot.org/

Casey, can you see if the above is useful to you?

>
>
>> +		return USB_DR_MODE_OTG;
>>  	}
>>  
>>  	for (i = 0; i < ARRAY_SIZE(usb_dr_modes); i++)
>>  		if (!strcmp(dr_mode, usb_dr_modes[i]))
>>
>> -- 
>> 2.51.0
