Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5604FF4180E
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 16:40:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7CDD83F8A;
	Mon,  9 Mar 2026 17:40:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="mk5dz+hs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD4F183F93; Mon,  9 Mar 2026 17:40:15 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74C1783F20
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 17:40:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1773074412; x=1773679212; i=xypron.glpk@gmx.de;
 bh=hOQV1Sfkz8wV3xuEVyQkk8Mes48aFiBCCwRHAHQHGYM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=mk5dz+hsh7PiPuJv4HGeUVKTa3kdEjdXQ9EBZWZ44MdXbRfXO2ixQx6qhhu9QnXu
 M7AzVrDYXZ5gq3QMB8GQawNNTO+cnAMIOFi7uC6UAu7UndcDcI01IfSEwqTl38JTe
 5gczVjVmNU4e76uYQxVplWg9FwV+ZoM2JyQLysmJJAiXNRQLycYnnzyqaBp53C27S
 Qd7e5w3PLVjRyhgvBw9z0oDdfGo0hfutmhh56fKv97H2xM+vp6RiAcjh89O6FT397
 IErCKK1rEa+krrKzZ/7piEKytleyUwE/Wxg+EKchElIOYLkB9T+FL/NUonCq/gHVQ
 Q71ATWZh+KWEuuL10A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNbox-1wJ579381L-00Uah1; Mon, 09
 Mar 2026 17:40:12 +0100
Message-ID: <bc95625a-54cf-479b-ac6e-acb316bc867b@gmx.de>
Date: Mon, 9 Mar 2026 17:40:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] efi_loader: export efi_ecpt_guid
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20260305161349.2317130-1-vincent.stehle@arm.com>
 <20260309163638.2340548-2-vincent.stehle@arm.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260309163638.2340548-2-vincent.stehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PO+mS+j82ln4PxxvZZIjXelc1+K2UyEW5iPJF+aJ9HuavTSw7xf
 bYdM96o2Ug+VAnb9rxppWVTbeGY1Al42s8wvxZdeVzuoUUVZWWQxWcqdSWs2ofFVd0qxqH6
 EKuC5t/980qyTwHZ8GrXXLKAKQYO6HxhZNeQtb8PIUzow9z3h5/Uunk3fzuc869T3iSDGtI
 1N2bIVJNQLtycM9JovrUg==
UI-OutboundReport: notjunk:1;M01:P0:0mfwUxQNhIo=;Luil3eSout9OxnTBGwbns/Gekk3
 uslFMKRcinZECd8YOtsXD3tplfAgADD2fnjKPxelZqa0Y89+rgbjoleoDmHam6ZkN1sYnF4bb
 GP/QXbfxcQznNJiyeaWmwbUJAfjbbFk55/Ftqy2EVvwhRlffkexh552XF72K3+gBa3s+7cOv/
 BX8Anv8siovBbIi1z4y3EoB0EF0b2ZBZvdXXoKgqWp6n65ZX+JvC6/4qB+6m0hv32j+otR3im
 LW4x342L+WiSppEVQKt6DR/33B1L14sPATroZ/h2oSdDga9Q2Qnft6hsU2HHE55O7ltY0seu3
 MJJkE97xL/pKa8LEjeQ1GzkCUM5ge3Gxx4NVEg3lx45iFq6iVf6CmPDYXAG0I9rexXYDrUXkn
 H8F1OSpQ2irVx7D+2M5kmJ/V/CASllErLKSXT4iCluWorA7coomteKYNg8+M3z8kFg/E6YU4/
 kvf3QEsLfGhQ44HAqEOlCJKY6kGrq1QcAA0XNl9/hoIPIidTqT4xOiGDCd3CkkJgF9Crercp2
 Npx1Ts8vC3AoyoI2/psM1ym/1W9Vez6XyipkRy3N+ullKGab5GDo4h/gwrhkhqLY5c1XzSVb9
 wliWdvHy7D77LpTNTDctuLv8WXSMbW5sZdUmo+klbrG2g966c7A6Bz5hJLIeJJEmRLLNZiiSg
 TTy4lMawioMU7aeMWNv7jAjww/h015FN4aB+xyFmVaLeXIZUC7lsTMxqRXawCarToAw2KZ/kl
 QUGubMsk712/HnFLvLfLduykjMLmCUUIPlUY2Nsg2lBkPJ9hGarsyU5ep8QNf5E49ZvU5bmDa
 /5fDxRlZ9RdO9tSvFpPHcWUOUGvYPRrFCFs0pvLFBfSIgT+i2hcPlE8jIIbxufqMTQF8gNlN8
 s/+XeUbGu9t0qxaKTmZVwhCdMTs0ENSEUtFyNgzpiAy+1Bx3FBdvxkOprUbZvPMUZ+0JXG5hZ
 Ra0V/7oBx10Gly5AWUiqBQGpWU4kJRfGKodpbrSqRIaA+eYSYosIoh7MRQ0tglsPjwvXUbayU
 3HV6G04GrIz7IlAIlF78IM8GG7J96BWyB+3XCt3/CSOgPiqQh+JTi1ii193Y7bn5IGu3NKKni
 VC48yeuYoJJifYWKWMOrX48rw6y8SrWtaPyGydofZePzMIpEizS195yPPXycM7Tc7uEYPBuDl
 R0Yyj/j/zeSQAZMGbtoAB4w6QWL5vjjSrRdnaGnLh1Sb4b8wNwLb3fOPBvr7AKIRKhYdtMHZB
 sRNTAqBOcEOE5DyXNWhrHJukejUdsB6hBZfehZQM29sCfmXkv2xFhdMvHAbZhkk0afX+Q/lZI
 9phi+30gOx0t2dCwxvioJpZI0WrKpRuY2S/0aGuZHP4SzObPgKb69IkWAZe0YYRrZwdZUe9hp
 HeFYMtjf/duo99jVBht+gQFFsZ+7xsVuF6K770Q1GdOd3aKDvOb1gqxBNazbPTjh35wR38ett
 xaqwn7wmLNGMJJYbqR9e1bcCdTcng06oG72AadRGnRJo3uc22WXzsM/o3G6bSU+EAZ2vRQynO
 8yr9Oqz5UULobR8TwF+XmnLmtvRyjjpaOabrv6Bnoy48TynigXfG9oEtlUZNKV+5HePs3pcZS
 PnWSsdM35B0ageAPhlVYns31fLFFRizrURLCLBePfKLmHly3LQVpoY621MhNcTxIChg0agWP0
 DTaGuVtawOy5rFZhPPq7LS2nn6OWS1FZkC1ECJlYGLvkkAwatOCGlFASGm2Ly0V1EBrMJANgW
 psFzPWTK/BOX6YXnGiRppau95/dd++dbKeUSo7xeFi3F1qcRtHaFOMUYy5YHf2fFENPSV9sIg
 mH1H3R3ICefaKuVyphhijGgMnPwmPHaXt9O1iuHirGaGL2eTzUAvlB3vVYj3cIX+jB76AB1k/
 7e0KEYfC2LxqeScM/sFSGY1Y7ay/EOKi8EnzON619kAhIMAAOGGgWg2H3XpJpgHboGJme3wBl
 pInJGfX55dyISgvmyuujDlWfpbjmTptgHyGBrKqR4Id5iRm2AaMAUm5X+k+Kk2GFzGTuVU+tK
 hQV/HLTFXEOsUS44FI3zhwA42uYYfklG5cd/PaSeHXyxfZQjs/IwtW22cGlaTn9GuTDok0avJ
 Y+wdw+UzshDXwuUln7URselncuY/1CIWRXp+BZJl8cRy48JQKZb026eUNaM6RaVC9BvYgSE1U
 69Xa5H3XQbAfAwgn6f1RExzEn9D4o1H3FCysAEAI25T3obFTFCXw29MgV7XRmono1x9g1uoNA
 t9VF9psOdCvADzMXxiU/RdpT+0ekU1Mh/lkWbrG6vJoAQ+nlPOZkiGDiOl7XScw0T3A3i36Oo
 zIwwI2xtkO+q6MsnvRoUVHMfxZi3An9VjIrEpAHOccIvU8WqKveSSj08unwyrk0eZiH1Jk8hy
 5z2whMf/v14T5RLwU8V5R0D9AVwhkblNKwCNd7lP6ue4OQhDFn/ICluA5RHqD+AePeBjrHdV3
 6tBTDEqybteEH6JjJg2rAoIHdKeWv8SBmI96ma0lYMyNTt8hkEYJ4h0cONqPjzj7mMveXaE5d
 z+ydcccdciSU2zwA9p600cRU3zCNVJFt/gYW97Oe4k2ItSTZI1lPjyPZ6CNH/ld7dFHozOhla
 RttFvn4LG5to8lCx8NTJ/mTc6SmaEtfQjYWPIvQiEsZXbcx7Jl+SAEAm5TGPY13vFj87V3+DA
 o6s5nmoVU1oNgsNticGADc0leD6xiCQwpsTFYQXlM7od8AwXqHrbVLJkxUpwow9OZViaJ+zNK
 U95Wc+Huf4XvWO78htVC4dZ7DfNfurLd1aUjU0svw43pkfhmkr2IPgENr/C1RaSRpMbLJ7cef
 H90iKZxG6klbzKBr9xEyB8Hx/KXECQChuDyP5SgBTEshl8vRneWjoenXVD7HcEKgQHMKKqPNE
 TVIwJIEigor52UixNV8uDQMEdgR2xdrqAVU1Bk9oyZIcZy5kby9JsW58Qc7HyOCqIBsHd/zeA
 qR6mnLYjMOAY31KQIDWkD8kfnFW5bwcTKg8UKTmn+PUCgdgp2gYJ+wXG1/XKQ4YOqbPiNt8YG
 ISBBjwmk7tUHMgxY9iefy7YgrAQagJz0zkWnpShS1/LVakbMmoDBp4PGVoxn+B5mZu77OeKQx
 tYMzbOg5fR8Cls+eCNlssaLg1scsl0++bDz+SJwsvPWEgdmUwSzt8lQx3KGMsGPRUTmedFgUF
 SKkGPdCdOLOYirVrtqhTiCp2GMf6uJbbn1YpZdbvQVHztWFWpTNDVH0ySPlB+SOLVMJhq19ix
 X+CBkv48LOZPJeIdyk1zGhpTjwYO0X7X70Lxqhb15RSqdwFhGGk84Dhn+xuovRY4osdz1HOfj
 bYWk+fnRciDyJoQXZUBCo0PMufGPBUfxwExUOKttH9Wp4gUgQbOv/vRynMV0dVmHqShad6acm
 aKzmk9K0Kdbxgao6HBrYUPVjLQFQ2lKE7FRhSa09YJwSHWLw8Y02NrnqoKqAHbWs/F5/ptHDj
 ZoClPPwy5hlS6va/X83H5a15+GZ1VF8SVv+lPWCfC7qHflWBAlWRhVeOlxxMPdcVkqIhb1cUg
 07oqwJ/dlvfP1XtMqz0k/iKKxpjn/JQKq4qPk0+UTDooV3WZFaZwp9UVpx55Yyf/1oR4ztCC3
 TYhoGCbstSy82Oz6XWiMM5vXewxQw1pfppFR1Cld1osIf8Jo0PHZjQwGNvchsew96hIxI2r7i
 4vqCtfVZ+KiTZr+BSQv9XHT+m87WETR6+pA11c/Kk5R5DnSTCakxqc2Lyq7gYED9XcJmnmNm7
 d9nBKocE9VbqTSR7oIrgIopuO1UESLAsnTJQ43FM3vAtFt2S5iGjygdFySkvtBT1iD91F5rOU
 NYy8hANyOUayp0wC1l6DhQFW3F4P0PM+whFtKFOiblmqN8HLncj0iE8FNP5KfXVuI1MhPbh6X
 QrxSSiGU1RkN5P6xoS85AIN5Vh5w3gny8Z87UxzBkyA3obiQUeegcBFoT8K3PhLeToaBqBI1i
 zWLfEYU00tg2gWa/r6DmG7ww5xZadiMEbWFDQWkIu8bgCwe55SvLGYJ3F8jFob3BChGhym4sI
 Hz3Cy8nsI+pqW+7KA+ld4PHAzXlCFeQXdjP2UifHZFIa8auy7KTcoBVY6af9hidHT+WtyGsVS
 zGfuN+5C6wEqLeuOZDLaENcSG7RrsKknzmN7X8ZAIrZer91BwvSA35HQgmWdglclzArdiJ5r/
 j293++RvGKbzXoYzuD8E49pgj2U4topc0zSZQLeQlBnUCsYQGpryCLRGrjs+CvYeCtNyvrD61
 I5Fw08R+Z0mZl5AwiW1d52AtGnNMeOwpY+CRqWTe52AEnPpm0o5RWhBEoHSryJgkDs31XVZYm
 A+6S253gG7HJ5wFiymcVekOjzl+HXWbttrodOU1LUmPUhAgPXLChvqOzat9Mz4tbQb+K+SGIP
 3222BvK7+kc7aHoSesn7uzBUzpWv0w0WZerjwbMASN5WC4G9FK8+cRoP0C/6EulKMZuKHUpcw
 FfxJ3B7m8rQkgvq1tesJNK3HpMZYfsrRgnPkJlDD+jLMnTRaeEpZm2c4nJt/oa+bA/wmays0k
 YgfOIc2aEmb8YEgsJtqtlfvj05wwfhLqkLWAFO3sx8joaf3CIQ72EItnX4H8mxYpztVsRsd3c
 6ZeH78CKmPprEYJED15GLIRYuBusjvg8GykpcibvVnw/OReVuCYVwozUPVfVnR9+hcla6K11m
 esv3tOhgLFyvrzOIm6mgLGdYaqO3ATyHNy0qcimcFLbBij7vsI4w7CIBhMg4sF54+DFFgrPTX
 EW/7i5JA6HyjOmdPyImdk5vUMGTLuVHos222CJbFiBXM5kK4x6OmFQbL0bIz7PCz8Ng6Hlamd
 +al22A5XD5pSHJP/nuyf0YTYScBkXjrobey1/VVeJ3qbSBgszo5H3ujszQtp2qGl2Cxy93KSr
 QHfYvYf0eWlV2oGY3RlJGx/1mIzSDYzkSLuqqqBaAKcnZTIQD4FQSJEB5zkGrauQ2lSoc2O69
 pqLzN/9jQO31TYrkJm9PF6tObeXd0GhikqBoUqXivmX03fqdxu5+8E1cPSHuLlsM4Uzom2fWM
 sulS6pncOA/BZ4Oc5KF/h2Xq8qACx4wJk4EKDGyh9RGegLGJ+pzNEJxIivO3E92HkKzMvPO6r
 aZc7bnaIza0WlMoHD7fwXnHQcvO/gCoJbBm1wf6+We5I669jpF/RUckuBKF9NJIriDWGlg8Gi
 h3hyFV92i194Tis3d20XZSalNiUbYVwEiL5VwvOCo7c5tGU+WQg==
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

On 3/9/26 17:36, Vincent Stehl=C3=A9 wrote:
> Export the ECPT GUID, to prepare accessing it from more than one locatio=
n.
>=20
> The C file containing the GUID is compiled only when CONFIG_EFI_ECPT is
> set; gate the export accordingly.
>=20
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>=20
> (No change in v2; re-sending in the series for consistency only.)
>=20
>   include/efi_loader.h             | 4 ++++
>   lib/efi_loader/efi_conformance.c | 2 +-
>   2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 3e70ac07055..0ebc80e0af0 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -387,6 +387,10 @@ extern const efi_guid_t efi_guid_capsule_report;
>   extern const efi_guid_t efi_guid_firmware_management_protocol;
>   /* GUID for the ESRT */
>   extern const efi_guid_t efi_esrt_guid;
> +/* GUID for the ECPT */
> +#if CONFIG_IS_ENABLED(EFI_ECPT)

This #if looks superfluous. The include should compile without it.

Best regards

Heinrich

> +extern const efi_guid_t efi_ecpt_guid;
> +#endif
>   /* GUID of the SMBIOS table */
>   extern const efi_guid_t smbios_guid;
>   extern const efi_guid_t smbios3_guid;
> diff --git a/lib/efi_loader/efi_conformance.c b/lib/efi_loader/efi_confo=
rmance.c
> index 2d31800ccb8..470141af483 100644
> --- a/lib/efi_loader/efi_conformance.c
> +++ b/lib/efi_loader/efi_conformance.c
> @@ -12,7 +12,7 @@
>   #include <efi_api.h>
>   #include <malloc.h>
>  =20
> -static const efi_guid_t efi_ecpt_guid =3D EFI_CONFORMANCE_PROFILES_TABL=
E_GUID;
> +const efi_guid_t efi_ecpt_guid =3D EFI_CONFORMANCE_PROFILES_TABLE_GUID;
>  =20
>   /**
>    * efi_ecpt_register() - Install the ECPT system table.

