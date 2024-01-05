Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5A5C3DA6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 13:17:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C14CC879A2;
	Fri,  5 Jan 2024 14:17:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=prolan.hu header.i=@prolan.hu header.b="iCGuEor9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74EF987720; Fri,  5 Jan 2024 14:17:15 +0100 (CET)
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2471879A2
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 14:17:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Csokas.Bence@prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain
 [127.0.0.1])
 by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id BE6C2A022B;
 Fri,  5 Jan 2024 14:17:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :from:from:message-id:mime-version:reply-to:subject:subject:to
 :to; s=mail; bh=PIx4qxm/QSbcqcQlnMS8MFe/FmBa5Mdf/bjfr8/DwHg=; b=
 iCGuEor9Up0Yj/YQmblsM+Ddhm8sNAGeuUrwziP2i9wPpyDywJ/PXzxUeSl+ZJbt
 1NBxF5HwNhmmJNSHgJTH4PqxNHBbHWzTiEvFcN2m56wVlZvveNnBjlwdomLVlW8H
 1g85fXaSXHfezR/AR1IbIFD58wG2196jJ00mKlfO1ML2yOWgSL/IcepgF4ORUi2K
 bNe5PS2KC8dsYrsP3STtTt4fzhgmKUVZ3HXF9/CW6g/UGYP7YXJqaJ0SU/pZ4WBS
 YBnRkBYdlwu0iGi2QQQQ4PtKFn/fhepKKtb6neANjSjUOvPtFYbpguXaBBsiEeaq
 bAUisNFLntRQ6/Scf3h6nPnuwqpy4xKETs1rfqBCTjhaXvyNq3OyE6Cha2tWyw6Z
 dC/mnPPLbsoRfpHIHNxmm4Vy3XiFAzatAekBvyY33I8e7p3dChxDSvP6rmO5MUUY
 TyXAtYlYUR1uZkHO8TiSKrd83FIHauDLF1jcfT7q8g6wtbm2Ry0dvTvZAZrtahzK
 fwpMB0yKW29cAzO0FNT6xpwBPiFh/hTYbpp6xcP3F98uIkGVsuAAtaM2ub9s0wgl
 bc6JUv+YnP6XU09L07QSo0jj1xaGepkv0ml6bXc1YnOSLvtPg7juFuj/8casLmQP
 Lqq32r1SmM8pBdtgKr6PePp+aW/vVSblNolfhvYP7L8=
Message-ID: <036691b9-47f5-42b0-8868-eb072fdcdc6c@prolan.hu>
Date: Fri, 5 Jan 2024 14:17:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Ayoub Zaki <ayoub.zaki@embetrix.com>
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
Subject: Re: [PATCH] rsa: use pkcs11 uri as defined in rfc7512
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.254.7.28]
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A29CE703B55657D60
X-Mailman-Approved-At: Fri, 05 Jan 2024 14:17:27 +0100
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

Hi,

I just noticed this patch being pulled. Won't this break existing 
scripts though? I mean, I'm all for the change, as now I don't have to 
cut "pkcs11:" from URLs anymore, but it's bound to mess up some 
automation systems.

Ayoub Zaki wrote:
 >  		else
 >  			snprintf(key_id, sizeof(key_id),
 > -				 "pkcs11:object=%s;type=public",
 > +				 "object=%s;type=public",
 >  				 name);

This is incorrect, now there's no "pkcs11:" at the start of the URL we 
pass to OpenSSL at all! Same with the similar clause in 
`rsa_engine_get_priv_key()`.

Bence

