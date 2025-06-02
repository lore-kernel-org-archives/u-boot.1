Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2268C5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 20:37:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 101D781E72;
	Mon,  2 Jun 2025 22:37:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="iNf9VJxt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF13B81F0D; Mon,  2 Jun 2025 22:37:22 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B381280F0E
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 22:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1748896635; x=1749501435; i=xypron.glpk@gmx.de;
 bh=8Qgmt1YzGnl365mVbRblAS0UCliakD99I8qtng+SOdc=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=iNf9VJxtHgjd5XjzYFJxKiTG4JdnYtM0bWfnWcGya3S6qpj7A+A7lRSAzZHaAwxP
 yKBgvuGAh0Vp3td+JMs1Q//fFHVDp0NuyIB5d2RFwHwueRhHW0w4X+nA0n1Liwj44
 H3B5oI0dDjzUt7Hbis25CFg0isZ4tsXSVp2UWcWlMhlJvPwtdzpIMDZdDby8ujARe
 qQvUMM/VAwJ/Tt4WVwZNP/57uoLHIdnh/l8zsLD6Yb5m/mstF27+opXP0prwgzPS6
 DBtojN+c0ajZ3jBQTQ9mvnxpq7WlYOFjun6jn1fhrXv8qSZ1+Nh8sbwdXFwiboXke
 wp29Xy1u516MjWn2gA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuUnK-1vCdrs3r8M-012P34; Mon, 02
 Jun 2025 22:37:15 +0200
Date: Mon, 02 Jun 2025 22:37:11 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de
CC: Tom Rini <trini@konsulko.com>, Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH] cmd: smbios: Fix header for type 3 entries
User-Agent: Thunderbird for Android
In-Reply-To: <20250602201009.90885-1-kettenis@openbsd.org>
References: <20250602201009.90885-1-kettenis@openbsd.org>
Message-ID: <902988B0-EA7C-451F-9A1F-154D34675386@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EbwirQzx3C3S5h9hI2kMVZJgvHRfggzusZlJ2xGKAAlcgwDSxSW
 cj/pE1S9M6dtuvIU0Pch+35z4YvVH8AaN7a5p7Tc0ZErez1TpZvvdjcKUzR4rUPqmEAXyy8
 xUlv+hfbiaNlXefmR5g4h15Oom99G6wZhIrVGr5vJKzrfMMJbiSUeZbId3zE9a2q/evOEKM
 qA3dOggw4FhaUwXbG5z4g==
UI-OutboundReport: notjunk:1;M01:P0:6UFnJlI1s2Q=;U63OW1I15KHrlvsz1CFGOqtmJwX
 srxMAtFJKrK1q70KJcEbx1pK9EEEVIKE/gxlIrE7njrvx08+yE+uwH2+trqClYJJxgNHe0Crj
 ZRILpzHxnH3Qooq4GTcIMC8T+IqKOkvpjpl4IYui/lS21IXmOlUZWW1wT8UzyGdeAeXYPpFbE
 cVd7Q7EOpDXUMZQtDjwUtjdl3I8PzgBEFlsoK/NHayCovj1qzsmxo4enzUSg4h4bfiIB39WEn
 jIazQjOpPMUN1NPkSiBPMiZhFOdH7noArGHykbHDSJG4e0V2dDJIXG+jN0Y/4aHJ+H9aEiYnG
 QGP2LfkIO24WfFkWDAylYBo/oOze4CPR7Bt+WSj2aZ5qZA5lFZDCWly5T0FVxBx2YB4RfkT25
 dyCVpAc7e1HzzrBeXIRZYOk8njzuw7fQ8Y+3ozUjDBVsaFyXA3HInZmDB2ExDB0CMvb8IKTrz
 rI8loKGTmJmrJdRHYKFRDw/D5Sz9e1THTDi6H0g5Z6H0BmcDJXbCD0fPQyEop463zdnh66drJ
 FOL0HxEPDp0VF/ipwRCqgiZkRtEToZeDLiw18DrkfJbUabN4viSU1q1jUlFs/kFGZi+bNjuEr
 aqxYVawP1pN1zmODuL8y31K5VfvJpgyUnXXLRl1Rx6UrKj9KPG9wjdCcfj60wSvoZcDBI34bS
 k+rMehpf1U7bPI6stSSaIM9aql1vkPlS9QCkEoewwby6kRFBRW1eMgceRqc8HSer31nXhVqiR
 1DbuGc7u/FBV8xiK/gqx1deCL1ShyRjlHTq0VRMxiyu5sQHAbcTBBJkqFZzfaBwQ1rrrT/eeE
 CQljthoHPq9A6fjr2xxtcrH65Joi6XBsapKPIpaTApCf8fkkjeNGcppK3/1PhqD3ElazGRZVu
 1Avsw3xF5nnuBbAVjt/+FQUjL2yZenzYbbWnPKgXUYRDGR6Wo9IJDKeJgzlLQfLPI31Z8CpCh
 +N9P4O9Lym5tYDkuidouVXe2bbAQ87kjc0/1NHCsN1/RvYAyj/VhFipZF64/ga2TAidaM/NVZ
 GpujxDzsSgIgG52TsIGXRhwqNPIbKtb0+BaWIW5KyqY+fmBm5XUOPWhbnj5qcxAautNvuZZ6X
 SvQjmWzpDef9yVx8+UG2JEQNSwJ6WBukLk1oKhl+hSGj0EiRxNjWpqAXhk1C8fMm9my0atBUo
 YBr8X0XRtUTv7wwune4E8jmSxWrEpp4DZSwRUiTbvxXhzbI3r/RE0PZQVm5cYnr+HU5XhQ5zS
 c53RFaVogy09mKLvz7SvGZDAIUg9MHWtivMKDrt9uc4PfknakeGFt7CPJ9QY6wMzSvcM1RvcC
 PlGOkiHkE9gUEkTqwLZYp4aPPf/cktLyPY3aaSxQteatpPIwJYbYxyle6TEb8ELfXhut93w4J
 fdU51DaDvPvp1uopTeH57uh1jr6If/6Pisg5JvnV4Oogcs70/vIX64GJx4SG/GGSRBaTeqkCN
 HVAj7kaPTuLXkDqs/VkYaA52ciTWRFGnd7nx7rNgOBLBi5MiFx+roEENUKSrZR2VVJ882Bwkm
 ysXXf9oQnVLKOvtvbvvo4IYJD16RG/7v7dkXOgmAwNhSzzQgNd0VySZsGuquVuHp6o23rd87H
 3GZndTwENww2QW2DJZVmslJsbiY2DUMlxO62POCeXqlOwg29UkDnK7vDmVK3AD0akkF32vyfT
 yC5C+LsfVkRmEG8GTpBvqqY1bhOxe8i/UCPjpq90Mmw2zRZNGdNobqVOg/qg4TvYlcCCWHnvk
 1dFj9r8+25J8VIUE2n1F4fAaGNfj+sT3cYCbTFbzMsN1dV/wIb3YcpwlEgsmXCHOBeoJT/OWf
 +RVCifiixcIffFrjFll8DWfh9/tz6+/EXnQaIxEFI2efsEySWgHMowarRB7FiyFbrqiGfWa8s
 MQReKIrIGonFGuX/SOdm3ZJiFOyyNYcNFevCC0hMd8oamF61bYcT1DGrENd5e1E4ccM5TeCxM
 vvfXxWk8kvT5tg2dttw78J9kDCTLX56Ed8E6f6jOz8m6mH5unib5j74wslAUgStMbKFXu+yBN
 r76SVuaTLMe3hP/7M6LeSX6BdiMDvQl8rMfoEba7K9VylG7dTdaGI9v65th0U/8HTKEctJtbh
 PxTMEmQ8kPNKgm0egOu1OSU4guodBKGaioorsXYAMvdWWOnqL+TtQ0OPY1Qj4DWQdIeKtTfMF
 D7oNrNo0/xK3fmgEZ+BYtQI5bPE/WJ5GkPDkM5BnwXoYYT6l2aSRYln5UI2NA+rG8jmnKB9HK
 6e3Cf4ZjiYoEcV3aOVkrgJa2S5v9855VCJ2G6pVvc8ECMxzZhwZ0jWs0N7DbrIc5QyMKrlVOL
 DRrj+3flsJew/gNpzR10HPazca4Y5o011ONwYava6deK2/nZEnq01ITOrY1Y7jjmCJG7pAUca
 92Oo2coZKb02Gt+JmnwzSl+QcobisaZegRQSS220nZ4Ma1ZCEZDzrx7f38asK8COSzYcWpgXp
 4o7oN0K4kBwetZQnyP+zgHtx5F2lEZZYH1+CAXYXn/4C/IJb2yQHIfyHIA/mTXM3qZ/OpqDtz
 lEmAeO9ziIEo9tGu/6v3La7Is6kFnH7gz2FZp6a5XesAOXY7z9JA6lQOzRxKP0UCnlfTZee58
 Z1eoMiiJHD0xtgfyLIGtk48nuNSJ2X0G1diXRU/eGpz6R8EKGLalistCF6ah0WOivCFvNyg1a
 YVvZTm1mnpW0iLfu/dIqQJmbIJX2h5AzY5/Avvsfm/ynHR+Z9fzTT+xNyh9Kp0EKSYjyFkF5X
 pBkDlKeCyYnbqD2vdx9MQ524zleCRNCcoPlQrHQsMyVdS4F9HYQMArGcAg4d1SwqkTq4BsCWE
 Fe+4mf/xsvUwPhN9tS/OuJff0mHvmPp++VJu9Zd25b6Eg9ACDJ7vSS4JL7i+yCR97uh3aOH4i
 fq6sDK+VCtsCaXTP/xn12i1gQrryrvNbnxlXVP0rXObKixagdrLOmBZV8KyyFQOWHPmsQVCbb
 Z4EBq/TS7RM1WCvnL3oZ1fQK+S1Mv8eS2OhaGXaF7CcC3XSaJOf88Qm7MvuLr+Y0bGzjFU6ap
 2eab49wWFVf3SROufaNU1ZsDSCAgXOJIRwLd7eXmUgzg6voc0Dw0FpFBGKP5PCrolnL3hS23g
 hiWF4IPUtnS8yGQOqVNjChUty32ZcjLbGxrIyNxkNga+nkF2dbFrZpepvV89KfilkILWZWfAB
 KQKHO0MlAUj67iTEfE1y4TBD7+jZx1xwgqX4v8MoisW/XAw==
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

Am 2=2E Juni 2025 22:10:08 MESZ schrieb Mark Kettenis <kettenis@openbsd=2Eo=
rg>:
>Change from "Baseboard Information" to "Chassis information"=2E
>
>Signed-off-by: Mark Kettenis <kettenis@openbsd=2Eorg>

Shouldn't we replace all terms in the output with what we find in the SMBI=
OS specification?

E=2Eg=2E the type 1 output should refer to "firmware" and not to "BIOS"=2E

Reviewed-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>

>---
> cmd/smbios=2Ec | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/cmd/smbios=2Ec b/cmd/smbios=2Ec
>index 562dd7959be=2E=2Eed419f19028 100644
>--- a/cmd/smbios=2Ec
>+++ b/cmd/smbios=2Ec
>@@ -280,7 +280,7 @@ static void smbios_print_type3(struct smbios_type3 *t=
able)
> 	int i;
> 	u8 *addr =3D (u8 *)table + offsetof(struct smbios_type3, sku_number);
>=20
>-	printf("Baseboard Information\n");
>+	printf("Chassis Information\n");
> 	smbios_print_str("Manufacturer", table, table->manufacturer);
> 	printf("\tType: 0x%02x\n", table->chassis_type);
> 	smbios_print_str("Version", table, table->version);

