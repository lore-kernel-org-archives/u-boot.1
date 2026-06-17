Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7B5CD98F3
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 18:52:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6D3A846B0;
	Wed, 17 Jun 2026 20:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="XgqINl7D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AB3784833; Wed, 17 Jun 2026 20:52:17 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DD458460E
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 20:52:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1781722334; x=1782327134; i=xypron.glpk@gmx.de;
 bh=9l33ygFZtd0sPSmXe3/orUuAk/WwJ0j7krjWlm4IR4Y=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=XgqINl7D6R78FpUmyZx2GDhZLPGVnYr2nYyJTnmWa3xUCh0GxTylAsSvXaRUV9Xq
 CPprSWjRuzNwhMmhTSXSLoifpGW+vGrbT9T75bj9cb6QX+DL9Eol7y2MVwE96yUsL
 nclsQvp5CllbwIZrzar5VXgS67baSbHtpTU0fjEo3pfsh/vytYTTn8JfKPIsor0fX
 Q3eI91X9fnz27R7ve986xFAk0kGs3jI+1XQEEQRNxez3FVO7LEgSNNTyEdk5otX2P
 te3zbCQWfRcymT0MKvRK40zHtrlinvrwO03P3tL0JBlX4rTGM1jI0F25HLETOxBVW
 /aSAxqQlyswmP2I1Sw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McYCb-1xCXyK2syz-00mFIH; Wed, 17
 Jun 2026 20:52:13 +0200
Date: Wed, 17 Jun 2026 20:52:12 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: =?ISO-8859-1?Q?Vincent_Stehl=E9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Alexander Graf <agraf@csgraf.de>
Subject: Re: [PATCH v2] efi_selftest: fix guid comparison
User-Agent: Thunderbird for Android
In-Reply-To: <20260615105615.61271-1-vincent.stehle@arm.com>
References: <20260611092926.578977-1-vincent.stehle@arm.com>
 <20260615105615.61271-1-vincent.stehle@arm.com>
Message-ID: <BE8D13A9-8E39-4CDB-B8D9-F316BBBBA390@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iKKHgdQwuJ7TLlg0g9mWzMpD2KiG4nnNXY18Pskj4WHnsjsw/4M
 uOqRu7sX3vs+mDXxJV1FZ18kDPftCyhJvfQ51CTm6rHinXXhGIedCI7FlGxiXuk8SqMNn2U
 kyanr6TuRBTASWSa8us6iiTrkxhxXsf/58dYD8ubgCOLa2sOWFKD++AYA/0oo45O8esnp0e
 ISE6ncw2L2S0HHM9X127A==
UI-OutboundReport: notjunk:1;M01:P0:5OVGjs+pclc=;Wuk+HRD+MMBmVdvBafUzLSDnOBs
 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
 eYoe7kaLUhgvb3vP8Y=
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

Am 15=2E Juni 2026 12:56:15 MESZ schrieb "Vincent Stehl=C3=A9" <vincent=2Es=
tehle@arm=2Ecom>:
>The `loaded image' efi selftest is comparing protocol GUIDs with the wron=
g
>polarity=2E
>This can be verified on the sandbox, where two protocols GUIDs are
>retrieved by the test from the image handle in the following order:
>
>1=2E Loaded Image Device Path Protocol GUID
>2=2E Loaded Image Protocol GUID
>
>The test matches on the first GUID, while it is in fact looking for the
>second one; fix the comparison polarity=2E
>
>Fixes: efe79a7c0de0 ("efi_selftest: test for loaded image protocol")
>Signed-off-by: Vincent Stehl=C3=A9 <vincent=2Estehle@arm=2Ecom>
>Cc: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>Cc: Ilias Apalodimas <ilias=2Eapalodimas@linaro=2Eorg>
>Cc: Tom Rini <trini@konsulko=2Ecom>
>Cc: Alexander Graf <agraf@csgraf=2Ede>

Reviewed-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>


>---
>
>Changes for v2:
>- Continue using memcmp() and not guidcmp()
>- Keep the Loaded Image Protocol GUID definition
>- Fix Alexander's e-mail address
>
> lib/efi_selftest/efi_selftest_loaded_image=2Ec | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/lib/efi_selftest/efi_selftest_loaded_image=2Ec b/lib/efi_sel=
ftest/efi_selftest_loaded_image=2Ec
>index 5889ab12617=2E=2Ee0668f60ebd 100644
>--- a/lib/efi_selftest/efi_selftest_loaded_image=2Ec
>+++ b/lib/efi_selftest/efi_selftest_loaded_image=2Ec
>@@ -60,8 +60,8 @@ static int execute(void)
> 	efi_st_printf("%u protocols installed on image handle\n",
> 		      (unsigned int)protocol_buffer_count);
> 	for (i =3D 0; i < protocol_buffer_count; ++i) {
>-		if (memcmp(protocol_buffer[i], &loaded_image_protocol_guid,
>-			   sizeof(efi_guid_t)))
>+		if (!memcmp(protocol_buffer[i], &loaded_image_protocol_guid,
>+			    sizeof(efi_guid_t)))
> 			found =3D true;
> 	}
> 	if (!found) {

