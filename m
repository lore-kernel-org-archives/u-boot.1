Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE14DF364B5
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 19:47:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F04E384099;
	Thu,  9 Apr 2026 21:47:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="oY3tVjEn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5C61840D8; Thu,  9 Apr 2026 21:47:14 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD74983DC9
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 21:47:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1775764029; x=1776368829; i=xypron.glpk@gmx.de;
 bh=p0sPvAx6j4L0Ar75RxG1OMdR5FzaSAWrfNtNLd9cPNE=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=oY3tVjEn+bZomNsGK2aIjJ7E/OvcvII2STVELsYvk8l8aUaes+dCi3Vg5M7U2okl
 KV5QbTZtM0iLZUp6rKXEysObiFRKwowQ6yj4Tn91awpzRGEdDY5U5i1G/XLNUSdj2
 q1wWaPoST10eAPxoTCmy1L+nwrXHD2gFqAOnMlSSXVrdDohJFU5NpjVNutWtiYhlE
 KM4tGWzs2HKF+KHYfRWjy0wgD5F/GzvlIa0Y6a6WzrSv2UltHKmGySnYKuGG2t4hY
 ngwYvJYpbtTYW6+WrGRYW4oBHFczFlRd3ih8FfVFw1iQ3SWP3MdSAnL+POtVOAH6B
 KiOCKy7VhQ2wMwzNVw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Msq6C-1vI8vc3W1Y-00wmze; Thu, 09
 Apr 2026 21:47:09 +0200
Date: Thu, 09 Apr 2026 21:47:03 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: rs@ti.com, robertcnelson@gmail.com, ayush@beagleboard.org,
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com,
 afd@ti.com, ilias.apalodimas@linaro.org
CC: u-boot@lists.denx.de
Subject: Re: [PATCHv2 4/5] efi_mem_sort: skip unnecessary compare
User-Agent: Thunderbird for Android
In-Reply-To: <20260402205038.4005350-5-rs@ti.com>
References: <20260402205038.4005350-1-rs@ti.com>
 <20260402205038.4005350-5-rs@ti.com>
Message-ID: <59AD8D70-3B2E-4969-8E94-90BC60BEF96A@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7oOJlCxcpRkUX+K6FdYsnJP9QDJQe4O+VraMwKcOa0tP/c8jvDe
 yn0Zek25X2/72tJcZ8CY5LNHDrVY9Ktd9bIJyg2cSXfEOVE42G68vD1eRW2oiypEN5LcjKu
 QzemteY6+FzuvMHaQ9awllmN3jN/4gwSE3K5ZJ8PWv7UF7U6EYFeRsfq+QJNsYStaJckPK7
 q2WDTTJPFgYdJs20gdJ1w==
UI-OutboundReport: notjunk:1;M01:P0:aEPsRYmeEsQ=;Gy0dSaB5BV1nGn39/mQMR4k6N2Y
 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
 wetJP2BlPxH2jSb2WbG2netQ==
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

Am 2=2E April 2026 22:50:37 MESZ schrieb rs@ti=2Ecom:
>From: Randolph Sapp <rs@ti=2Ecom>
>
>I don't want to think about the possibility of this pointer containing a
>reference to something from a previous iteration=2E At best it results in
>a some arithmetic and a comparison that should usually be unnecessary=2E

"a some arithmetic" is not understandable=2E Please, adjust the commit mes=
sage=2E

>
>Signed-off-by: Randolph Sapp <rs@ti=2Ecom>
>---
> lib/efi_loader/efi_memory=2Ec | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/lib/efi_loader/efi_memory=2Ec b/lib/efi_loader/efi_memory=2E=
c
>index b77c2f980cc=2E=2E882366a9f8a 100644
>--- a/lib/efi_loader/efi_memory=2Ec
>+++ b/lib/efi_loader/efi_memory=2Ec
>@@ -129,13 +129,13 @@ static uint64_t desc_get_end(struct efi_mem_desc *d=
esc)
> static void efi_mem_sort(void)
> {
> 	struct efi_mem_list *lmem;
>-	struct efi_mem_list *prevmem =3D NULL;
> 	bool merge_again =3D true;
>=20
> 	list_sort(NULL, &efi_mem, efi_mem_cmp);
>=20
> 	/* Now merge entries that can be merged */
> 	while (merge_again) {

The suggested change looks correct=2E But we could go further:

We could get rid of this outer loop by either eliminating prev instead of =
cur or by using list_for_each_safe()=2E

Best regards

Heinrich

>+		struct efi_mem_list *prevmem =3D NULL;
> 		merge_again =3D false;
> 		list_for_each_entry(lmem, &efi_mem, link) {
> 			struct efi_mem_desc *prev;

