Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A00E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 00:18:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C2C6800D7;
	Tue, 17 Dec 2024 01:18:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="PYYlKNrX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23D2C80107; Tue, 17 Dec 2024 01:18:48 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0607800D2
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 01:18:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1734394721; x=1734999521; i=xypron.glpk@gmx.de;
 bh=8vXHUeA3In6CMp+3EpZmMdTyheHkrIiMc7gdfyKRJdc=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=PYYlKNrXdKYEfghFCyoSediBmhZNnornhMfcQbADB2JFcsiXdFyBxr0SVZqOxPHy
 9bqo9IIzBF7i/oKSFhZcm9l4nSsQcNmONOGvwdS4/+RIoAO0xPEp2FkMCWN8KdJaP
 I/zW8jsP3THe62uHCL6on5Ph7oNdCoxMmjXBaVfiL5WCUot5PyokLM2ia6Kgqj4UR
 FDtrTm3BOA7ZDhYFCgXnxTaPrpa/q5Hj++4dQyz7pgdm+wOUdG3T5aBLRnEO1voYq
 8o+PuEKXgjNHC/+xetCdfX77JEQstdYM11DXfzO/mSzeHWjVf2fJUtBZoK+wdYChD
 Bft+3NUJBMFrj+relQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.106.131]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgeoI-1u48J23kWy-00okZW; Tue, 17
 Dec 2024 01:18:41 +0100
Date: Tue, 17 Dec 2024 01:18:36 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v2 1/1] gitlab: Add a StarFive VisionFive2 to the sjg lab
User-Agent: Thunderbird for Android
In-Reply-To: <20241216233853.2125656-2-sjg@chromium.org>
References: <20241216233853.2125656-1-sjg@chromium.org>
 <20241216233853.2125656-2-sjg@chromium.org>
Message-ID: <B12C4F95-DD8B-44C3-AE40-3EFFB7402914@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qINqnZrP/49ybbEbJP2dWNFH1Q9A5s6kUkMUwykeryo/uHfzQ7f
 2BAyNIXbA6UOLBNq6+3KN79Az04ajX7pEj70MxMsy76+GY0CvXczJRZiTtlS5by7jMhSrzk
 D1rtZw1qy0KfbFkttbSfSlc/eGb+jmP+X3Qqw//w8vPujPfzGm9ZaVFZ6Wr/cTB4qnga+bG
 e73kr+Zp+4TQft/CC2kFw==
UI-OutboundReport: notjunk:1;M01:P0:DMz9wjg836I=;Rd8ahnLrIu+PCRcSPHu5VKARt6I
 rtjfSFf9muR5hJrWCpfVlD5lYotcGW3snq3/n6vzS5rboRNv4RjCA2ZX2cw9BiaUq7mM9VGbV
 XWCIdcE7Pa5GlHeDIcwoADmCS3jz5/9CeKiBpQ0Xrzz/E6wyUyhunJvg4BoErxYeYIvB86RP/
 +iW3FaUC0oWHs4GQgsVTy8xX3VZNHY9tC2Zm5ktYwN9K00blWrE5E7NEPpSA/5DkfOouvYEbv
 mre+0wAeIdecgBMs27H83z9KK/kUDoDkeSSJVB95ELUU2XXVJDoQBFzu/myIc0xpYxrgO/Mtx
 q7qieZA6RCXk83p4qjw9up94EzlXGM5TRHiEMV1aFg3Syk3PyXahO8y+PgH9122WZS1kTDc6p
 GEhU8Xp4Hq9GBUbQGIRuQYYzyrulfIlTYQV2EgawioBlUZGml5VjVrOm8y/lBUwUxMcKsSwVf
 KmEqszpXuA1GgAN6GQSN8epEg5Ww3ddqBPrneAGUnHsN6jrWkYTg55HTpWFSY6hHYRYi6mhzN
 XwqLcAwuSYGkLBE3rM6THScsf3hJWXaP4cnIBalM5t8m46B8xA/oXLQ4Z5OkuZraoRdsdJk4u
 PlADZ0kgRJx/zUCAtYBZth+XD2XpIimR1nTQyCJkyJk402XnIP+VrvZapcFALgYwX5eVDjrU+
 VJpiFkNhXSmHWsWSH+OmDxDXTcfwDK4vjsUvZzV3njbckEeM/pN/QJjBRBLN2oSxseN02HLVE
 xxor3FApzOC8hPItPcbsM1ojwH4FWLpk5JbL2hXa/FtG7mgOI0lJfcxm2LAK/Ar7XuSpbroMY
 AkHxC9kF4nYyVR0hzX1YbaieHKL1DYsKcT5dtP13JCWMO0/gQdz6JYPwjsiFUaWLrUBEbEbJy
 5v6oaV9VCv4kFJL8iHY5NNlXY1V6fC3/QKFcYcTfb1Ad4n9t9Orjhp/MPEH3PfW1+wDHkicak
 VaHZslHCAWmJRpYsdrYgK3vCuteZBa+qG4cylmMnS3Gxhyw9Iv4Ky7ipNvm591lhrYnoV09aa
 r+AiOlMc+Yrtpg0Q5sN9Hxo5gGiZewkaISir4wZBhgIHNUKBQ0jBcBdUurCnu9qcmzLXq2Art
 ISEOrHPc5JCK0vWpwIsL/5II8gBX2c
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

Am 17=2E Dezember 2024 00:38:53 MEZ schrieb Simon Glass <sjg@chromium=2Eorg=
>:
>I have one of these boards loaded with Ubuntu 24=2E10 (64-bit)=2E Add an
>entry for it so that it can be used for testing=2E
>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>

=2Egitlab-ci=2Eyml supports an include statement=2E
Maybe it would make sense to move the lab definitions for lab_dfn into an =
include=2E

Such a file could be conditionally included:

include:=20
  - local: 'lab_dfn=2Eyml'
    rules:
      - if: '$LAB =3D=3D "dfn"'

Cf=2E https://docs=2Egitlab=2Ecom/ee/ci/yaml/index=2Ehtml


For the current patch

Acked-By: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>



>---
>
>Changes in v2:
>- Rename the board to vf2
>- Add a comment about what the board is
>
> =2Egitlab-ci=2Eyml | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/=2Egitlab-ci=2Eyml b/=2Egitlab-ci=2Eyml
>index ffcf8532944=2E=2Ea17c1b0a366 100644
>--- a/=2Egitlab-ci=2Eyml
>+++ b/=2Egitlab-ci=2Eyml
>@@ -696,3 +696,9 @@ rpi:
>   variables:
>     ROLE: rpi
>   <<: *lab_dfn
>+
>+# StarFive VisionFive 2
>+vf2:
>+  variables:
>+    ROLE: vf2
>+  <<: *lab_dfn

