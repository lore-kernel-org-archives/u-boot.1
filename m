Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90D8C02196
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 10:52:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47B21807FE;
	Thu,  6 Feb 2025 11:52:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="IctQk+UW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4442A80805; Thu,  6 Feb 2025 11:52:48 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41C50807E4
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 11:52:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1738839165; x=1739443965; i=xypron.glpk@gmx.de;
 bh=lRWo1NDlBxSECuRp50UGlsV9g7O9sspP/CCUgzDeSyc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=IctQk+UW9xcUE3eferyLEkzvASvSkqyUI0cxnCidR2gT+8P1KDovtLRM2J5RUtXm
 o7zsINGNHVFvnDcSdxQbesQdxtsWx3w1M14Cbzm1NVdJZb/aBNhpzVwfFO3XOpYLD
 anfT19QWMg2nBKG+fCKbWIo2q2VOWX/FWxNhJAajLdj6A+l7ds9bE+OkktZrM0CUm
 vQUUQz/LVa+177UwEpzDQxIcWg324fXV0SXevALxbuSMHGlMzqSY3mQ/m0KAt3uLZ
 u4Wkafy06vmoUSZ6OdsPAApXRxaliRBApkrUnsLXx7f5rUs4jR0zHRtnf97hzpNnp
 pR7t4FPkpqJStIXwMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSbx3-1trNTA05Dl-00OhDi; Thu, 06
 Feb 2025 11:52:45 +0100
Message-ID: <3926cdd3-39e8-44da-84f4-b9c877d6ac60@gmx.de>
Date: Thu, 6 Feb 2025 11:52:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/32] efi: arm: Allow use of the EFI table in the app
To: Simon Glass <sjg@chromium.org>
Cc: Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-23-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250203174245.1331464-23-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZunuXu4aum4C6HBWwejIwabDqgAbOCE+sqg7p9JP/FW60uRuFM3
 fXWrpVJlKA/cSP5AYqsoAeOJbpb55pXtG0rTuvqDeMEGytSaMgOsoJQ14cND9C4GQ//jeHe
 IGG5n4E/zSyllXLb3r5N9WllcVTVWfv+vXBZoP3MekYDmnG5MCFBg7auS5l+QWmMLykhqYD
 cmX3H5/95KVgz/7LEde+Q==
UI-OutboundReport: notjunk:1;M01:P0:G3n4As1+4To=;f2GuMaySgmY/Q+IwrvY771i5+C1
 upmxyXSycwP90+MRcoxsi5gaNRNuO4ZPAF4PMvQlAJH9MOUOXx+PuC+Zkb5saP2GEAlKv1GAV
 kdhQp3HE/MgbhkP1hZ4k9y3z7CLnu3KCRYTmqlDm/aUiKQmSo0raS4UwINcZ5Jk24XaiT+R7G
 bav1z74NNPU28nc8jaLuSZUgzCc3Pbs32Zw5EbVTwiY1gL8eMVe9ePK8tb18BL+UjJF6kCvco
 1YX1iL8eMxUMiMjXKCyuS3cW2mhALYACQW4L/jHZAV/nKmqU7HAX70CJt6joWfTepmsGVtR3l
 zqBFd/jGb+y1NZCvE8+iAWEF9E+OtOlyOu2tVvpn9Q6m5TpCfxfZAgqSx0ABDQH68D6QJTcaE
 g+HQfadi2qlR4sa+g5AQaR++x8E0AK3d4K6+xnVtVtDuQip7E18i6ydHkxILGpLHZfRVI2BBt
 sK31nnj1u79HNuwK3I96e5X3d2qY2kmIOFTgzmGO+/and4h5a5kIrIzbEyWrlnpQiFkyxpUHd
 YQjr6PGeQ82+FLGO2Z5QwtK+XI/tmgsfWnX2shtoerqynvtWHwkKCfjIlz6BZBZA58jM6T6WY
 sqgZ4cMcniRaLNks1w6ZRQ/6V/XAZrzrAy6qZKB2sE1ORIeHVknQo9bhre0cGY8hSCkbidTyC
 JDHg8mW5MwQi7z7Tg9LUNavtoAiHIqes1u3L4ViAdlSLjqTBFfw+3DwDsSXwzNXtt+wn60ECY
 wJlY0KDHlA+7GW0PSca5Tn89hlyoKYSb+c2vkfTkeGc0ZUWWqmUuiYy/WfAIB1l6K0LMG6bPl
 WFnV8X+z3SpiFvqNNTZ+u6y39PQXSfYw+k/NV6QTVmJrLyy3dCwVcBNHtILd+op2vtdi0O9CR
 WBn3E2rZsAAFEck0bt8gqyc1lLxX7NNj9L0h0TG1F0ghgWuKNfEwglsDE35eCd7UURb038ssW
 F0b3uBOZV0RVj7LczNEKxd7cRbzSoGN+tMKuAIZGESSC8BH6sw1wexPtFYwIapHy6pmKxyL0r
 AtInIY8uck2038ZX+jWIPFzBf0xMrIHAb13MHXK98ZgJIbHWA8QXgvwqOsZEca+gEPN6oMtCE
 bixmTOmTe84HslL2oA43H90zvvIon/yIvnpE7AEAU1bbyjHglVwg9wQynAguwQhDLxic7tjHp
 C0tgl0bLoIFYdpjs9Kbf2I33I6E6TC65M8HqrZAClLNNJCNBk06cI/NNLPbj8kMemn+6tPHUG
 KQO/y6ODir33i1G4MyzVWfCI95N3+M/gY9JHCCk7r0EaSHFJPMe+u6ixrVquHghC/f6vp8WEQ
 OoqiLIQOyoqkaYcMXleWp5AZ372fwagQgcrHIC0fAgeh2O1XiqTE4xcgmPTRGaUz8T3SavaRQ
 ohm0e5xRpz0CzHzh15Ii15z2pbwDiLvjK63kkEoFlU444bgSDgDHRzAmDL
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

On 2/3/25 18:42, Simon Glass wrote:
> It isn't worth the hassle of omitting this field for the app, since code
> is shared between the payload and the app. Adjust the condition to avoid
> a build error in the 'efi' command with the app on ARM.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   arch/arm/include/asm/global_data.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/g=
lobal_data.h
> index 8d51111f095..6a85fb2e152 100644
> --- a/arch/arm/include/asm/global_data.h
> +++ b/arch/arm/include/asm/global_data.h
> @@ -108,7 +108,7 @@ struct arch_global_data {
>   #ifdef CONFIG_SMBIOS
>   	ulong smbios_start;		/* Start address of SMBIOS table */
>   #endif
> -#ifdef CONFIG_EFI_STUB
> +#ifdef CONFIG_EFI
>   	ulong table;

Unfortunately this field is not documented at all. Please, add a
description. The description '/* Table pointer from previous loader */'
given in the X86 code is quite unsatisfactory. I would not know what
table the field points to.

If this field is EFI specific, shouldn't it be defined in
arch/x86/include/asm/global_data.h?

Best regards

Heinrich

>   #endif
>   };

