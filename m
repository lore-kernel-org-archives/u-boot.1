Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068E5C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:29:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8656280F53;
	Tue, 25 Feb 2025 00:29:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="dxaEygih";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CA8880F67; Tue, 25 Feb 2025 00:29:24 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C70580F3F
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:29:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1740439761; x=1741044561; i=xypron.glpk@gmx.de;
 bh=7BaWIfAG9PeKHudalxjCPcB66mBqewNM4aNz1LaIAhY=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=dxaEygihUDLpFTSt79fDp7mGl2phMTYHqnX+e8kzPXyBK5MpI/xX/HFg+jGi7Tvq
 C1kORSB3atHbkfXGA51gX5cZML5veXnEEXbY8RYqmrsgeoJAItGhevrCqT4Vss/70
 BoQj/oAu7ikUxTN79was9Xm53NnepNpQGDXXPO/WGJ4zNSJkwlPG3IQQeVMc91Aq1
 /zcXhOfU/NR8SVmGlvhkgbAsMPNpN51HmSxnRpCUhC+J+phe/8Ey/OhM+rfCW36RN
 EUSTnlBOOXbanCLH57pgfQIJDI+AGB8nEs+D3zptAAZK8hhg1+xXaDxztl41au3+3
 8IVhYDx+gnkBURZflg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8QS8-1tiKAL0dhA-00ErZJ; Tue, 25
 Feb 2025 00:29:21 +0100
Date: Tue, 25 Feb 2025 00:29:17 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Bin Meng <bmeng.cn@gmail.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 39/44] sandbox: acpi: Correct mapping in FADT
User-Agent: Thunderbird for Android
In-Reply-To: <20250224230640.2665206-40-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
 <20250224230640.2665206-40-sjg@chromium.org>
Message-ID: <52354712-B545-42BC-9784-8C91A676E368@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X/Y+pvUAuSaqxzGu35lbt5XWC6AeNky+63Q/sG0nyk6+G+jwNZ5
 JzVULSEbKF/qxGdL4wkvc3brMDeKHt91mBHfbyigzko8ImeoMfRXwVN37m04V/Z3wbpNa2W
 4RdOxwv/rr7rGEou09cDRUeY/kfkL5qIs70seyNCb2q+rqluKUhX/ptn+OJeXq3FN/FwzyU
 RVKSA0EKJwfYPbM8Wa4tg==
UI-OutboundReport: notjunk:1;M01:P0:kCmo5mw6k+A=;cUdZUnFykDaWyZ8LxX6QitvPmIB
 eWIMD7j1l+bf7SABF6sO+dJ3xI2o6mCpBb6C2c/2TJwXH5hodPxdujWnWbtN/IqKdGcXekg3K
 EmE67pJOPwQAKEMm0PYS2HYGPtaaVph7an8pZbKdqAgVjHrAFtlYiaCH1+CGFXqL57mgba/04
 WFA3etjRBHfAzgVf4sqhStLwKIhtXcLRgGW9gkjRHkyMYRo38b2PinhWpvt8lojruhuksXQzo
 h8d+3J5PO/DtYA+PL6AMbGeSSNNeiUrdEB6fsa2h3gP00jhU+2tN3Q29dBuXyRdvng5nxIiLt
 KY60pwm9inmml1pnHfHUD6bOUNboMrRou30M58Yk9jFjwfxCl1b7H4gOzd3lTR/GosyVvGKFZ
 GPyE6bXkjSLV5dztuUWV9sPQ5jbZc1y8KoE/bEtjdSOe5nnYkMgvqu+rYQbl/LpEFqWn81sEr
 F9vmawzjaeUGFcQTo6Fu9KTOXEXr6x8J+thehk3dHr0AQs6NCpzNhW79WrHzMNfDMj31r99RU
 7NdWU3EAbMa272yQtXDvdAAQLUxOUp39IMeijed/IAcHN5uTXMmS4e4oSeYodksIue4vMix/h
 ocnnLeuIn8amET8xKF7AvSpDrt2Es4aC5yEH8XMK09lNzSa/b4hkUTze3OYfM6DLawbeKW1n8
 hXRNsLSrqRRQYylely0wDOnT2Y5F04/Ghh+6w5g5PAQsXoSGK1S2ig9VWO+VB2ZNbK0k3HP2N
 Ys/WKEc8DtFAg3YgQGfbSZMxrbl8o+znGdjnqIycYfsRXO6FtJndwU3J+V38bntXaJsv7tEyM
 QqWto0tb3kiC3TDkhTwHXS4X3KrA7EGCYX75vh6qeK8u8oqgf1cbSwLv171PdItZmgqYKUqiX
 nStspJfBVJT+pxMKqzOPa46RgnUkzawpzhKQETzNUFS1P/+jR9k/lhq/EZDmt9stbOe5dU7xO
 6qNhJJUMp6ZWMDhjRmdjDYwKpug9V6QUyLAt7i7oTnByLdV85pElWV5spneJ3hB6WtBAc9/CI
 D8Kh9TPn/d+XuzfnKOIzRFxSMke/qhTc7ujvNHkGz4fkzbBZQJwxkPOhr01V4gLha/GmNStIw
 yGU/38JRD/kHXdFK4lbENPV7FGLMa0hM1In7fhTB8/L9YE+xTWdIzrxbnQ4rejeVy3N2LLx7W
 T6Ni2/x9t4H4Fzm8uuHPq3Asy1g85fraT5KTl+jAQwqgAQO20637N4DHkf+qD/sYrulstKCqL
 9KJ/LL0YAb4J+y0AqoGpxy4k4QsNGKkh5mx9nYUiLfY9djtbxhtFDu/d8zT3ke//r2pI7Ll7z
 vDiCIs780FtUOeRbJEkcrmbEdCHV/RlKrhjgc2PhvmTSE0Ctj8W1I8ECOIXIVde54YyxyC7lV
 on13VPi7a7bSgvxQlgNxqralUi2IjF9mdQvxDSTL2iooJWkCFEFdm97Yat
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

Am 25=2E Februar 2025 00:06:28 MEZ schrieb Simon Glass <sjg@chromium=2Eorg>=
:
>The values in the FADT are pointers so should not go through sandbox's
>normal addr<->pointer mapping=2E Fix this=2E
>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>---
>
>Changes in v3:
>- Add new patch to correct mapping in FADT
>
> cmd/acpi=2Ec            | 2 +-
> lib/acpi/acpi_table=2Ec | 4 ++--
> 2 files changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/cmd/acpi=2Ec b/cmd/acpi=2Ec
>index 094d9d4e858=2E=2E2273176f106 100644
>--- a/cmd/acpi=2Ec
>+++ b/cmd/acpi=2Ec
>@@ -58,7 +58,7 @@ static void list_fadt(struct acpi_fadt *fadt)
> 		dump_hdr(nomap_sysmem(fadt->x_dsdt, 0));
> 	else if (fadt->dsdt)
> 		dump_hdr(nomap_sysmem(fadt->dsdt, 0));
>-	if (!IS_ENABLED(CONFIG_X86) &&
>+	if (!IS_ENABLED(CONFIG_X86) && !IS_ENABLED(CONFIG_SANDBOX) &&

This looks like an unrelated change=2E

Best regards

Heinrich


> 	    !(fadt->flags & ACPI_FADT_HW_REDUCED_ACPI))
> 		log_err("FADT not ACPI-hardware-reduced-compliant\n");
> 	if (fadt->header=2Erevision >=3D 3 && fadt->x_firmware_ctrl)
>diff --git a/lib/acpi/acpi_table=2Ec b/lib/acpi/acpi_table=2Ec
>index 150f75027a5=2E=2E3805b61159e 100644
>--- a/lib/acpi/acpi_table=2Ec
>+++ b/lib/acpi/acpi_table=2Ec
>@@ -255,8 +255,8 @@ int acpi_write_fadt(struct acpi_ctx *ctx, const struc=
t acpi_writer *entry)
> 	header->creator_revision =3D 1;
> 	fadt->minor_revision =3D 2;
>=20
>-	fadt->x_firmware_ctrl =3D map_to_sysmem(ctx->facs);
>-	fadt->x_dsdt =3D map_to_sysmem(ctx->dsdt);
>+	fadt->x_firmware_ctrl =3D nomap_to_sysmem(ctx->facs);
>+	fadt->x_dsdt =3D nomap_to_sysmem(ctx->dsdt);
>=20
> 	if (fadt->x_firmware_ctrl < 0x100000000ULL)
> 		fadt->firmware_ctrl =3D fadt->x_firmware_ctrl;

