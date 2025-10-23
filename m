Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C16CCD1BC
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 18:50:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E82F8006D;
	Thu, 23 Oct 2025 20:50:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="cWC7NMh6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82EF380422; Thu, 23 Oct 2025 20:50:40 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C4928003E
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 20:50:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1761245437; x=1761850237; i=xypron.glpk@gmx.de;
 bh=fsn1v5DGvrszsl6vGZ7/wob1CayC8QSHEHovBgnO7JY=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=cWC7NMh6rcnAe6kjRdIG16Ab0r9x0HDK2vS8LkEWC0PDP8B56EYjAKEGGuBtCzea
 dvCQ4oBRL51fgvh1EgeOKc6bx/+ukIoU7eOk1EP2W4/B86bZIkFz05o5ueNvx8dSc
 1te96kKCtKZtxBHQZQzpuBE3vw4l6sQi3a8Ohz7Q7RZ4XNSzainM0QHF+IdtVsgiQ
 27BMlUhgyp+2pB49dWJRRUQutmCkQ5Ig13ED3zPDFoGpl105MKGVNzybgdgcUjtWE
 Dki5gClqkm3WxgkZ5mCBN5Jq/IX+HL11hcLyqoCzkjyX4pAHNWGG31QB31VRHY9ap
 WSyoKaDpXtH4M+VkKQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([82.163.239.194]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mi2Nv-1uYnt62JHt-00ZsM8; Thu, 23 Oct 2025 20:50:37 +0200
Date: Thu, 23 Oct 2025 19:50:36 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
CC: Simon Glass <sjg@chromium.org>, Kory Maincent <kory.maincent@bootlin.com>
Subject: Re: [PATCH] python: Add a top-level requirements.txt file
User-Agent: Thunderbird for Android
In-Reply-To: <20251023174059.1962529-1-trini@konsulko.com>
References: <20251023174059.1962529-1-trini@konsulko.com>
Message-ID: <5226195D-CE22-424F-AB0F-6238DD3F685E@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DkNVIWEb2UE1xzf2utunU2iIkrLGXCzxVLOwY2bsIKVLmoNYbGm
 Ef+QTCcMEuHOxN0ULgBvg0iU6UpUySJVK3Wwd6GOQwBYkOE8jBcTQ6LR2XFRDbLhZctY2mE
 EA1h08OkzC3nsd2XHmbBxMEHcW1AnuLOHXFKFE6R/hOpP7ht0AK6bpzBLEbsqd/4UJcsrPd
 bb18divWkRMKSsgVjDugQ==
UI-OutboundReport: notjunk:1;M01:P0:TLW6E0F5VZM=;m9GhHAI/18zSX7lBm8GcFvRq1R1
 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
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

Am 23=2E Oktober 2025 18:40:59 GMT+01:00 schrieb Tom Rini <trini@konsulko=
=2Ecom>:
>A frequently reported problem is that someone misses a required python
>package when doing a specific task within U-Boot=2E This is in turn
>because each of our requirements=2Etxt files only lists their direct
>dependencies=2E It is not always clear that another tool has its own
>requirements and thus something else fails=2E Solve this by having a top
>level requirements=2Etxt file for the project which in turn installs all
>of our other project requirements=2Etxt files=2E
>
>Signed-off-by: Tom Rini <trini@konsulko=2Ecom>
>---
>Cc: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>Cc: Simon Glass <sjg@chromium=2Eorg>
>Cc: Kory Maincent <kory=2Emaincent@bootlin=2Ecom>
>
>As Kory is the most recent person to hit this, cc'ing them=2E I think thi=
s
>is the right path forward and if agreed, I'll update documentation in a
>follow-up=2E
>---
> requirements=2Etxt | 8 ++++++++
> 1 file changed, 8 insertions(+)
> create mode 100644 requirements=2Etxt
>
>diff --git a/requirements=2Etxt b/requirements=2Etxt
>new file mode 100644
>index 000000000000=2E=2E0fd08b9da17b
>--- /dev/null
>+++ b/requirements=2Etxt
>@@ -0,0 +1,8 @@
>+# For ease of use, this is all requirements files for all portions
>+# of U-Boot
>+-r doc/sphinx/requirements=2Etxt
>+-r tools/u_boot_pylib/requirements=2Etxt
>+-r tools/buildman/requirements=2Etxt
>+-r tools/binman/requirements=2Etxt
>+-r tools/patman/requirements=2Etxt
>+-r test/py/requirements=2Etxt

These individual files may require different versions of the same package=
=2E

Either the individual files should be feature complete for each CI step, o=
r we should move to a single requirements file=2E

Best regards

Heinrich

