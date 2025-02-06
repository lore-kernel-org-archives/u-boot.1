Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18201C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 17:13:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 955FA80C7E;
	Thu,  6 Feb 2025 18:13:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="G1BYZ3HV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 558C580C83; Thu,  6 Feb 2025 18:13:56 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4681280C66
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 18:13:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1738862023; x=1739466823; i=xypron.glpk@gmx.de;
 bh=+Vgxsvi1owL96d5KnyvTq43GzvltVP9RnT/somWtNjs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=G1BYZ3HV30xbnjsunXk9XiJ2Ut9vqSzwCSsNneE/thxfHR6L+2T8YU+VbF1Npgqz
 3YC86DXnOlhk8j2p41pA56QZ9JMfu79qwHRCT6EnbG+BP0s9+/zmrrxww0aKFZYfJ
 ujrTLic1+xetumpJmizQl3UuLMV8zPIH3k7K5Okrv8bppzrEGCgioNTniLDYw9yR3
 8pG5VHdGDON4H/tJyNo9CKsEMfphqDH+7/v7MfDEQoiaTF7uVJyq2GQvCGWJiG8a4
 +nBHr6emXz7caniYj0dxki8QdqhdHnafqZXtkdTvmQH6C+Mzlb7yw/+pY+lumZoel
 qHX7cIxFePbXyo3j6w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJVHU-1tzo9m3QSm-00XG1v; Thu, 06
 Feb 2025 18:13:42 +0100
Message-ID: <eb12d64b-c10a-4fa0-b32d-10658667814b@gmx.de>
Date: Thu, 6 Feb 2025 18:13:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/32] efi: arm: Allow use of the EFI table in the app
To: Simon Glass <sjg@chromium.org>
Cc: Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-23-sjg@chromium.org>
 <3926cdd3-39e8-44da-84f4-b9c877d6ac60@gmx.de>
 <CAFLszTgN=k7mjR3-=XW7ZZOMpRPSdxuAXqszPeE4qJAwVKOnVQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszTgN=k7mjR3-=XW7ZZOMpRPSdxuAXqszPeE4qJAwVKOnVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UFW8juiBwtiWgi/QYi4gFENwU6tkpwVdQPEMnqhty/zl6GGQR3L
 iAFq2PmW9wN1BYqpr9dveCO0P291r9mXfj6xLjY/N1bWLfAczkAkK39GOB/sYWjbXF7lFx2
 mwaDhPwmVCKLPIb88ImqwmkR83rTFvfxt3pOs+GHOj4H8mIpeZRG3+I3YQ1/touuOBvgxbg
 /l1oHsGecI3vlyJfFNXXA==
UI-OutboundReport: notjunk:1;M01:P0:i+3nGR6rgac=;wJ54K4bvEhZOCT2AHWIOte41+bF
 EZOmipyMMY/xTDtT8knPc0Ult4nYwV8zpDMD2Wa2r8mihHdh60lec1c/jSDs+XRKwyYGueBUf
 CyDSvAehLq8qk8lACkpcJH7wzr7zYhSyrUWxp4QcFafY1heTyhFu4nNoBuSVFJAPhiGVRe9CL
 Mj//sG0Hta5rIChduztQKzyVGNVtN31VGjPNuv9GJoSxCQv4k+ZTchnlOX73ezWbPivrIGTD/
 tsb0CHmfchH5BMJKXqsSaRAj9AX4fvOudi9PxE7fl3ywjD2pvxgoyCvMXjh+dRdPRcR1Xfqao
 knmELMk3dmu/Hj0T9pru/UcS9ea8UCjIuECgnmqCvjMm87+YY/65vI92EJMuBEu4rF9xKG6a1
 tHFSztsCAM8U5ZeAbrfi8X1c47kvncne1TwzfjClqcGzvKgLTr/9iJDqYHL2Twjr1HXOk1inU
 PU1cpy0EerTD3kEkQp7oS+hQ55e+LgT88dOZU8HBtsRgkZuZYCzaY94P23VjzankcfBxO1DiM
 6k9nqwYXfp9IP4D9aLacijrVdYS+vUQaTUEukCRi6ZO5orRySexQ91E/Q7fpiGAuj8lpLmySm
 JhZ333EvB0rWEdYV91kGLUELKIAYZ0ynSPpD/g/A+8iiSbpU12EKqwrNN4wlr+G6Y7nd+DO6z
 d3anGpgScyqqzGi+RHTrlM/XXEh9vrBbgRBYqd32UJ1eeBsEiEPKwXaNWY3aTFbxFGlXP0NTa
 5b90ZmSJ/jNPGQxpg5p+H5Va+dDDaY4dj5/G2II0ANZTSyXf/qiLJYh2jyA4mWed+AoUxboFC
 wmG/fvzYBiEIjh1rFJ5/FeuCG9PhqaxtupYHMpC7kzPOu2WW0i5SKgb4eJT6+ZNKMWm8KfoGP
 qojJPISvaJ4yrRANZBlHJV8VTS7s1kAcKM+uymOgGaVRkPHg7uMfoYYjaCjn7I7i2oDLr3Qie
 rdRPx9pWqQKzN2Fe4+WgSaS0C7UhVW7Mx/FXpC0YtLdM7V5ATjqBa0/FremHoWD4YfgGvu4Kz
 pjnApdE0DgI1IibBTluBBp0xUMw0tMv75IlgG3Cf363vpDx8VqM5ezWyAw4d/Bf95gxHm7xiP
 Ko/qAfz8XA/ujp2Bgi6AW6ZGy5zNfUYxtQjWfttAgaIMhKtUcIOBOZEVOiNTRaKSvluUlCAl5
 yEwa9rH+yWEBNhxR5rjCwknEm5E2YWOelpeDxi97j6JVgzxptSXjsgvlsgaVTe2Lcrni0+/Je
 ajxBEesXnPENdwaxLQZZa1V8RBtOLMPkStK8TsTcBp3+hCJX9Gs7sK2WKMxssSeL9Pb0xaUb3
 5cSg8bOWmJwLnhvtjtaez33F3oAznJvge6JUAqBHFLkF2YuYoYNoemlfx1pRibwIlvt8KheV5
 TeEtYMSPTzIa2fm7YtvEc5drhdKXLlovTq+teUMzsxeLAJJn75cfJcrdGB
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

On 2/6/25 13:37, Simon Glass wrote:
> Hi Heinrich,
>
> On Thu, 6 Feb 2025 at 03:52, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
>>
>> On 2/3/25 18:42, Simon Glass wrote:
>>> It isn't worth the hassle of omitting this field for the app, since co=
de
>>> is shared between the payload and the app. Adjust the condition to avo=
id
>>> a build error in the 'efi' command with the app on ARM.
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> ---
>>>
>>>    arch/arm/include/asm/global_data.h | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm=
/global_data.h
>>> index 8d51111f095..6a85fb2e152 100644
>>> --- a/arch/arm/include/asm/global_data.h
>>> +++ b/arch/arm/include/asm/global_data.h
>>> @@ -108,7 +108,7 @@ struct arch_global_data {
>>>    #ifdef CONFIG_SMBIOS
>>>        ulong smbios_start;             /* Start address of SMBIOS tabl=
e */
>>>    #endif
>>> -#ifdef CONFIG_EFI_STUB
>>> +#ifdef CONFIG_EFI
>>>        ulong table;
>>
>> Unfortunately this field is not documented at all. Please, add a
>> description. The description '/* Table pointer from previous loader */'
>> given in the X86 code is quite unsatisfactory. I would not know what
>> table the field points to.
>>
>> If this field is EFI specific, shouldn't it be defined in
>> arch/x86/include/asm/global_data.h?
>
> It depends on what the previous firmware was. Where it is coreboot,
> this stores a pointer to the coreboot tables.
>
> On ARM it is somewhat EFI-specific, although only because we don't
> expect people to want to boot from coreboot to U-Boot on ARM. But I
> have long-since given up betting against any particular boot
> combination.

This does not quite answer the question if we should move this field to
asm-generic.

As the usage of the field is non-trivial it should be documented.

Best regards

Heinrich

