Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B5FD2CE17
	for <u-boot@archiver.kernel.org>; Sun,  7 Dec 2025 07:17:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E954839A5;
	Sun,  7 Dec 2025 08:17:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="pdC2jo02";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B388F839C6; Sun,  7 Dec 2025 08:17:55 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83C838399B
 for <u-boot@lists.denx.de>; Sun,  7 Dec 2025 08:17:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1765091872; x=1765696672; i=xypron.glpk@gmx.de;
 bh=ijk2U8nGVKpYDdVXvAGnGMnGgR/coa4cTHrEI6n5CfM=;
 h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=pdC2jo02VacAChCQv4HZbzjZnf+7Svey1aB76u7VVo5seIKsbZ5oGiWxsknsZb2C
 bYKQfil96rE+Zxz2EPUsN8JP5iWBI9gMhSBJYTE2rRv5fsNT2iIcgkJsvvpnBoSXB
 50eIxghGEvtQYK104iHzkpCRdR7rk4heIpphQdgfmuFWyexvG1SGRJj7vbVcy7xYP
 shvh03RQZurz+Ls93xqhOstwmiJ5S7kM+dnGfVICW1UsawLRLO5xxLdPZBykvKmyc
 sfnOABxxGVdZSjKy+u7l/0I1ExmLF/s/8HhnRWFO5rgtcKtxvpkxQzcEEC2n9hK0x
 Ff57iDuvkPp8xjBN+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([46.114.3.139]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MulqN-1wJQEe3TMJ-010QpZ; Sun, 07
 Dec 2025 08:17:52 +0100
Date: Sun, 07 Dec 2025 08:17:50 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] doc: Update urllib3 version for building
User-Agent: Thunderbird for Android
In-Reply-To: <20251206165034.2621363-1-trini@konsulko.com>
References: <20251206165034.2621363-1-trini@konsulko.com>
Message-ID: <0DC1498F-9066-41E1-9B9D-CE45CC9F4849@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jLy4kvp3Dlkp0oU4EyfhkXgfj4Rn2MRpdkl4sjjQ+xoN7jHxs56
 oweld4DQLaQKRrJ0qJmZ7sLVPqQId/JQRfcYtoScWUyl31/M9ivJmxqqK6PDLqol29YJ64k
 Q1XDU3+RIt3tym9dEflVML0S0yNX9GKYk/V2VUnAHeqEp3xSYdRZBmXR11OvtkVDf3sqt4n
 Dj56wzYR4Han1/UdDQHMg==
UI-OutboundReport: notjunk:1;M01:P0:6sahdKkk4Sk=;IsbM/1OJUQlYqsnHroBXrJb9qJX
 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
 JW+LlsNg=
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

Am 6=2E Dezember 2025 17:50:34 MEZ schrieb Tom Rini <trini@konsulko=2Ecom>:
>The GitHub dependabot tool has reported two "high" priority bugs with
>this package=2E Update to the patched version=2E
>
>Reported-by: GitHub dependabot
>Signed-off-by: Tom Rini <trini@konsulko=2Ecom>
>---
>Cc: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>---
> doc/sphinx/requirements=2Etxt | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/doc/sphinx/requirements=2Etxt b/doc/sphinx/requirements=2Etx=
t
>index 8572c15ef68f=2E=2Edd433e2bb156 100644
>--- a/doc/sphinx/requirements=2Etxt
>+++ b/doc/sphinx/requirements=2Etxt
>@@ -24,4 +24,4 @@ sphinxcontrib-jquery=3D=3D4=2E1
> sphinxcontrib-jsmath=3D=3D1=2E0=2E1
> sphinxcontrib-qthelp=3D=3D2=2E0=2E0
> sphinxcontrib-serializinghtml=3D=3D2=2E0=2E0
>-urllib3=3D=3D2=2E5=2E0
>+urllib3=3D=3D2=2E6=2E0

Please, add a reference to CVE-2025-66418 to the commit message before app=
lying=2E

Acked-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>

