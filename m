Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819FCC47DB7
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 08:56:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA7D787B8F;
	Fri, 19 Jan 2024 09:56:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="CKYu0TbG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8B7F87B79; Fri, 19 Jan 2024 09:56:53 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE3A286F67
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 09:56:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705654611; x=1706259411; i=xypron.glpk@gmx.de;
 bh=Ig7t6UG5z0k4WqewBZe/r45jYICIDNdX/bXc+j9YxAU=;
 h=X-UI-Sender-Class:Date:Subject:References:To:Cc:From:
 In-Reply-To;
 b=CKYu0TbGonlhMPI7XyUIxAjojFI922mQHm0JtQhWAuifJV0Y3h7V1ma7+YEM9qED
 zSxR5rNiEGxBK6s59zpZI2ASCdBhrEzvQxz6HStuf9AYNFR/7nRKcqQsttolcOI6m
 QI6GBwUszKapMqmokW5S7Us3g8ULnw+e2XcXdeVgQctzagMeNQa0AFO8SxRyvB2dv
 gvuGbuJlohbPOcnzHPbWyzEmPPWZX25OFCwt365jIa/4ZGRPAQGEEZhtDTVqM/wgS
 7+G6uuFnMZ9p1dtCKh7/tyiJ8+tKAhZ1j9utTJPStWz9HrV3Ba2R7EzOkXwuMCLJa
 wBgMfOYpBJ0dOtOnsQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIdeX-1rNg9O05o5-00EZdR; Fri, 19
 Jan 2024 09:56:51 +0100
Message-ID: <8cf878fc-88ee-4c27-b95f-d1bce5ddaf34@gmx.de>
Date: Fri, 19 Jan 2024 09:56:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: ** CID 478334: Memory - corruptions (OVERRUN)
References: <65a933ab652b3_da12cbd3e77f998728e5@prd-scan-dashboard-0.mail>
Content-Language: en-US, de-DE
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <65a933ab652b3_da12cbd3e77f998728e5@prd-scan-dashboard-0.mail>
X-Forwarded-Message-Id: <65a933ab652b3_da12cbd3e77f998728e5@prd-scan-dashboard-0.mail>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CXNATwILEXHyGjVZ3XjYITzbBcQPhgh5As54smvs+0yeYCv0qgl
 88QnQvpPCnLz+2NjJcQE27oyu3DvNlnfzz56EN0VMYUWFMC+OFtSZk5h/BhyFoSQJrxizHw
 LWTPoKbsnejxVNyD09b35YSu0IJyFF6d5mfacKkYCoqxfsMG6/zkH65lexHLBJZcpUzd18E
 pU1GBf+2RT26+euzBYVQQ==
UI-OutboundReport: notjunk:1;M01:P0:BZ0RqPPsbeA=;oIcxWTTs0zl6pyKLogepBU3V4Hr
 CxZTTyetqq7Aav6fviVB3MqxLzukdt81OzB6ArDDn4efu8j4xEalgc76VZ0yVq9gnVJlNefMP
 b6mK2jafBssBKY4IjgI31a7LGpzZaOHwIPSlnljHiUS2UvcS4Ma+e5hdh+XuCtYrz049rltCZ
 6pRoCDI1vZc1RZKgSsbH/PgQ7QfNKLpBIzWDnhCfB8LfaqSvQ6PfPqOWApKtmPTkIWocTge42
 BASgGuNGCYk/bf2+6UR/CZ7+6ta5laJv2nhJS30Cey+7D0ha//xBItzCAWPqADA85zx9cNq0G
 ceXbHyo3w9NQa+Vp0Ym5Zr7jQf1fqChEv278j4c6IN9d8cIrZRlQmJK2InhkNx5O/4eJwBJyr
 wzmYTx4zU1lU5JsJuTKPBuJlBfTYLWa9D59svLYBBwSZx6Nncd+rzKxZ76Q8IzYGUYGdGjc02
 a5f/+7oM8Qj0PL+uxLsyI2DRy/HmlWiwbk00XEbMUEPlxej2yo0GyIDlcqbsV8XXlk6fTBpPd
 Q30UzL3OQOpONBuBJAr95OFWKVPdGDERIfAwNl67Txg5SDL7gyUvCImhGm/F7XL4gT8bsUr4F
 +liqGKvKg66yzI+pIrZo/Li+bVbq96U0gN1YoLqxf9OtnPE9AbN46e5oj+pZ/OkiEFdk77bjf
 JR+pKQppVosxKsR479qWTqHHBBCrKC63IjFGh3BTHqOlc90MmaFRqhlPRFdt+h4TMi7COvkop
 iWVSZ0Pig/JK2LHiLxXhQ/YIH/niUkaVT4skeKNso5ZDPr5S8z1iNsMZQofyWbsYQKIKJErC8
 P+Y2gXPf6B+c3dcMho03zyQ/GDoXQ3k4aowWvz4lcwuXc2lF7dgh6eK5Kdqz/EvUcl36jdHGg
 5uoVuzE7l916DPDGxfEAgvvLKsC54IcdYlY+qfxBqptKKSSlqx7Le0lsqlBAHFJktA5tzgCNo
 2mEyXhmx4IxhHSVt+lotOVCxaSI=
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

Hello Ilias,

please, have a look at this warning.


=2D------- Forwarded Message --------
Subject: New Defects reported by Coverity Scan for Das U-Boot
Date: Thu, 18 Jan 2024 14:20:27 +0000 (UTC)
From: scan-admin@coverity.com
To: xypron.glpk@gmx.de

Hi,

Please find the latest report on new defect(s) introduced to Das U-Boot
found with Coverity Scan.

2 new defect(s) introduced to Das U-Boot found with Coverity Scan.
16 defect(s), reported by Coverity Scan earlier, were marked fixed in
the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 2 of 2 defect(s)


** CID 478334:  Memory - corruptions  (OVERRUN)


__________________________________________________________________________=
______________________________
*** CID 478334:  Memory - corruptions  (OVERRUN)
/cmd/eficonfig.c: 534 in eficonfig_create_device_path()
528     	p +=3D fp_size;
529     	*((struct efi_device_path *)p) =3D END;
530     531     	dp =3D efi_dp_shorten(dp_volume);
532     	if (!dp)
533     		dp =3D dp_volume;
>>>     CID 478334:  Memory - corruptions  (OVERRUN)
>>>     Overrunning struct type efi_device_path of 4 bytes by passing it t=
o a function which accesses it at byte offset 5 using argument "fp->dp.len=
gth" (which evaluates to 6).
534     	dp =3D efi_dp_concat(dp, &fp->dp, false);

How about using

dp =3D efi_dp_concat(dp, (struct efi_device_path *)fp, false);

Best regards

Heinrich

535     	free(buf);
536     537     	return dp;
538     }
539
** CID 478333:  Error handling issues  (CHECKED_RETURN)
/lib/efi_loader/efi_firmware.c: 413 in efi_firmware_set_fmp_state_var()

