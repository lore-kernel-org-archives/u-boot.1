Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEB2C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 15:24:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2E7D87809;
	Tue, 26 Dec 2023 16:24:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="nXRTBeas";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AB1D87884; Tue, 26 Dec 2023 16:24:22 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6345E876F6
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 16:24:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703604260; x=1704209060; i=xypron.glpk@gmx.de;
 bh=2Zt5oJjIfIWeVndi5bmP+EF7VRBgEd2gCt9kqecXRsw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=nXRTBeasnzXNN52VDPGJUmDAEwfh1qTfrxsjqeVQSbm+Z16haALyLfldPZ9Usbxm
 X+4IgsKLL6shHpcyj6n4vlzHP2pjvGX5lrpCM/DK7MExwDpy1U+b59qkdiJ/2PXKj
 3RRvn1U7HMEPjhLRH4qw7nzAjJCD7v+CDbvFGLYs8DpjDPwY31/LA98IF7x0lSjn+
 mv5X39//N7asEN6mmXKFiyhv0F5g6gQuwfus9OQM/ZpaqBbtRrri7denXVESpKAF4
 BTBtS11k4W5XwrPUgH+D/ehBBKWElwRK570AB+PcWO9+s78lU+QtnR3v0hMfm4pm0
 c6YWvUUdGbK6z+15jQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.152] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsZ3-1rTrqR0cdr-00HRXp; Tue, 26
 Dec 2023 12:03:12 +0100
Message-ID: <5f14ce2a-fd29-4789-bdc3-037c8ccfcd73@gmx.de>
Date: Tue, 26 Dec 2023 12:03:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] smbios: Correct gd_smbios_start()
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>,
 Troy Kisky <troykiskyboundary@gmail.com>
References: <20231015024511.3995580-1-sjg@chromium.org>
 <20231015024511.3995580-5-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231015024511.3995580-5-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cs6cdwOzL/cva3sn4+yvD2UaiSBkFMROiH31E+YYScwLX53ZT1K
 1L4YE0FJ7dzjJdDLxfvOSywK4T/caZveG6vt0seecLOcCuoxn43PwM4TtAflE2oJ4viP40l
 yjTbStxVfeeinUOcSf4s6r4Uc7L5H4MJid7jlhCAINHcL3r+XgWrYgCwz3b0f8Vi7sW9B25
 HHebDIK18VRJVLchiin/Q==
UI-OutboundReport: notjunk:1;M01:P0:cgLec0zD+Co=;Hex5aEA56I+69dY8D37C10HLz4/
 K7oov1RIK8VsirxOFu6O2qVJ5S9GcJzZGE61TJZUtEqtIQYrjPRMpdameHFSzmbJbbOul70mR
 3amMziin00SFddnSXlZXsJh92AuCVJk/uDawrJrZstXJJExfBNepe9IXiH12z2G9YWbk4NPqf
 xdI1Xapnc6xaAHJvVtLrqtzehfeArxkw6/yv5fFsvo3UKEKl+TR6ImbN+wvF1ddesr7uqAK1x
 lvnNGDsSaHFlSRv28DPzBrf8bFJhlaYZms/GMefKSfuHViDx/BoGOyA2K+4XWq9ygrVTH303s
 Hd5QmMs1TtvWDsTqLbgtporcd9QWI6PLv9c6iucKDTVjopwbXUZ5fcu9QlFwdFZnt0OltImzE
 U/X2tv1qIKCCb2+ugbW/jprbZXtvRjeaggJANRKUeF/1x/q6wQM/8HeXh2QO6LLV6PwSG+7/R
 qzqWYkkRcooOPfSCw0gzDbOZw6kswkn2dpvJhpFFHxIaXDcfeCcgUkvoypTvs0oIAhKy31HWH
 qboH/HcJz8xVus+QmL2FEswlh6Yp6mftOpqzqg/XrADR5eJxMpNIcreKfzl2sEX2rtujnRqDL
 tS0qom/RV1Q3vISSabC9KNvGwKzPLHwV0d2m5+Hwnim4KzjSf3nSLI2UHEnZOxn81WXDE9tQe
 XQJ2XVqP3E69q3v0Zbs9cJNXYHCvi3o6Imd2ju8d4h2SFyJH79sluHXyqhuzpD4B82rqaHROq
 aQLv5DUzt0Y8YtsG0PvLynd56cHP8RwyhQsT01OACK7gmBKlazKluNUarOX3W77QOqN5/FdxA
 EPrNgev5S9Ws92hf6sDu5NYAUBRCZuKEapbGjm8ALNlLVJuiLtXhMWzqLk53P+iX1/1AfxAhh
 tjpHS82MBgCCD5N8IlB/lKjvDzDxIrQJmGOJkUlqwiuXvwIn5x86z4P0dpSxgzQfkljXLNWSy
 2qSWbOoqFpy56FFXhqBXeGugXWA=
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

On 10/15/23 04:45, Simon Glass wrote:
> This should access arch-specific properties. Fix it and update the
> existing usage.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>
> Changes in v2:
> - Add a new patch to correct gd_smbios_start()
>
>   include/asm-generic/global_data.h | 2 +-
>   lib/efi_loader/efi_smbios.c       | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/asm-generic/global_data.h b/include/asm-generic/glo=
bal_data.h
> index e8c6412e3f8d..c1f7818817f2 100644
> --- a/include/asm-generic/global_data.h
> +++ b/include/asm-generic/global_data.h
> @@ -553,7 +553,7 @@ static_assert(sizeof(struct global_data) =3D=3D GD_S=
IZE);
>   #endif
>
>   #ifdef CONFIG_SMBIOS
> -#define gd_smbios_start()	gd->smbios_start
> +#define gd_smbios_start()	gd->arch.smbios_start
>   #define gd_set_smbios_start(addr)	gd->arch.smbios_start =3D addr
>   #else
>   #define gd_smbios_start()	0UL
> diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
> index 48446f654d9b..4ae4e4a7c236 100644
> --- a/lib/efi_loader/efi_smbios.c
> +++ b/lib/efi_loader/efi_smbios.c
> @@ -29,7 +29,7 @@ efi_status_t efi_smbios_register(void)
>   	ulong addr;
>   	efi_status_t ret;
>
> -	addr =3D gd->arch.smbios_start;
> +	addr =3D gd_smbios_start();
>   	if (!addr) {
>   		log_err("No SMBIOS tables to install\n");
>   		return EFI_NOT_FOUND;

