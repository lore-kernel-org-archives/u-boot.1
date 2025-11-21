Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFF2CFC266
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 11:43:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14D488051F;
	Fri, 21 Nov 2025 12:43:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="t7WAdkEC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36B67835FD; Fri, 21 Nov 2025 12:43:40 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3332D802C1
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 12:43:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1763725416; x=1764330216; i=xypron.glpk@gmx.de;
 bh=ESrs0OBujF8LaxkQLxpOF9m5j4lNvfi8UE+EU3TcESk=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=t7WAdkEC+qA1PICQrxWI7XkJrXK8nN3AmNBVbMV8Vx6uWuSkenxrySt7IcIYZ2gn
 29rgX1AABCQ46qdM47mDVePekyzLCW5aZxME6YonMvJ1LQrvtZrlMLVWqEC7tqMD0
 Hc0jMqdg92p+w6RZiJ0DuZ2e9a5A5+lEM7p+Tn9Z0e/2vS+m9lvb1kKBHDRSbdKLQ
 ZMpFB5qeYouMxfT3pOQNC0ibLPDs/5GGnCvHY6/XgfD6XLB3bJWI+Z+MFZoYKPEor
 Bje6vLFPPfJYR+PiQSqDbbBd7iDlkMr7kVat8Mt0mBa8yP+s9L9MsjPMpVp5M3yQ/
 shIao+GdW9lddh7KEg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([46.114.108.80]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MpUUm-1vug200eXU-00nwdL; Fri, 21 Nov 2025 12:43:36 +0100
Date: Fri, 21 Nov 2025 12:43:32 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
CC: Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Subject: Re: [PATCH] boot: Check noffset before use
User-Agent: Thunderbird for Android
In-Reply-To: <20251120041613.817311-1-marek.vasut+renesas@mailbox.org>
References: <20251120041613.817311-1-marek.vasut+renesas@mailbox.org>
Message-ID: <0633F8F2-D242-46B9-A988-C45ADACFB382@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DGoO976/69201GoZ3MQEe2/bTi1UJWPfZYEXnoGPY3YtopPvZgs
 H31YNF5t95PhRJPwwKWmwlL3c7fA1GrfnOZPXgKVSNvX230MuZxKxx3hlRbH22VlLxAo66l
 /b1AlHMx5FrZjKn//3jckwwXPjjNrLyqBF8aEasCqPsCaDh8tOB8VSr/v3pje/v/YofcM1V
 PZxVajoqCmLTdjxqmIcug==
UI-OutboundReport: notjunk:1;M01:P0:TAFr7kC2J98=;ebEHkQDZtbAEFvp24MD22xtJ5Ik
 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
 CqrcLAk+umqYy6poJMCMiGhuf7FEcgtf37tCD8
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

Am 20=2E November 2025 05:15:30 MEZ schrieb Marek Vasut <marek=2Evasut+rene=
sas@mailbox=2Eorg>:
>If noffset is negative, do not pass it to fit_get_name() and then further=
 to
>libfdt, this will crash sandbox with SIGSEGV because libfdt can not handl=
e
>negative node offsets without full tree check, which U-Boot inhibits to k=
eep
>size lower=2E
>
>Instead, always check noffset before use, and if the return value indicat=
es
>failure, exit right away=2E
>
>Signed-off-by: Marek Vasut <marek=2Evasut+renesas@mailbox=2Eorg>


Acked-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>

>---
>Cc: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>Cc: Quentin Schulz <quentin=2Eschulz@cherry=2Ede>
>Cc: Simon Glass <sjg@chromium=2Eorg>
>Cc: Tom Rini <trini@konsulko=2Ecom>
>Cc: Wolfgang Wallner <wolfgang=2Ewallner@br-automation=2Ecom>
>Cc: u-boot@lists=2Edenx=2Ede
>---
> boot/image-fit=2Ec | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/boot/image-fit=2Ec b/boot/image-fit=2Ec
>index cccaa48f683=2E=2E35595f15ac3 100644
>--- a/boot/image-fit=2Ec
>+++ b/boot/image-fit=2Ec
>@@ -2137,7 +2137,6 @@ int fit_image_load(struct bootm_headers *images, ul=
ong addr,
>=20
> 		noffset =3D fit_conf_get_prop_node(fit, cfg_noffset, prop_name,
> 						 image_ph_phase(ph_type));
>-		fit_uname =3D fit_get_name(fit, noffset, NULL);
> 	}
> 	if (noffset < 0) {
> 		printf("Could not find subimage node type '%s'\n", prop_name);
>@@ -2145,6 +2144,9 @@ int fit_image_load(struct bootm_headers *images, ul=
ong addr,
> 		return -ENOENT;
> 	}
>=20
>+	if (!fit_uname)
>+		fit_uname =3D fit_get_name(fit, noffset, NULL);
>+
> 	printf("   Trying '%s' %s subimage\n", fit_uname, prop_name);
>=20
> 	ret =3D fit_image_select(fit, noffset, images->verify);

