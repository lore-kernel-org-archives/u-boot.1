Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01DDD65C6C
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 11:10:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C732895AF;
	Thu, 14 Nov 2024 12:10:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="F6e4VWiH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D81EB895AF; Thu, 14 Nov 2024 12:10:43 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99A498641A
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 12:10:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731582640; x=1732187440; i=xypron.glpk@gmx.de;
 bh=uOgpxsQcLlTBfvddIggwfpHc1rMhoZGw9ifLYp7n4mQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=F6e4VWiHQyqdgoWOAuqwfcn1M0bUljXLeV7as/eGquLbl0ykGEdZb3Yb4ySIRJLC
 TD873ZK90NJPUUgyHZ8SdrfiEQn8vCWVBWAyDqLHmUK/qGR+ruG5XlhdDnvfaF4nt
 sFUV5IXN/heBrWogwlOzYE6DjqUGZvuJ5L331XhI07CjtsM4Jad0Nriva74pzQQUQ
 pFS30Ji7zLejLjTk+dTx6bb5XG20htaLjzHc2VUNKrYRHKEu1OAzs77Rn5FKo/W/j
 C8A04F+E1bIK2SJmaF4G6xRkml4xiv2lnPu3J1voSkZx2T23Wh/huvF2PCDl3rF6V
 FU1F0L/dlvfs0J3oSA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKbg4-1tUAYu0Vie-00J2pP; Thu, 14
 Nov 2024 12:10:40 +0100
Message-ID: <781168c2-355f-44c4-b2d8-341ba8132316@gmx.de>
Date: Thu, 14 Nov 2024 12:10:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/20] test: Move str_ut test into lib
To: Simon Glass <sjg@chromium.org>
Cc: Francis Laniel <francis.laniel@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241102193715.432529-1-sjg@chromium.org>
 <20241102193715.432529-13-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241102193715.432529-13-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qyN1EROihaQwAF7dTL7GfS3T9G/tIQs6U0ZWn78g5Xxh/3wGKrs
 1H9HJClgZwR4GhKbgSVe97xIGuytwV2F1/ZyWK8Au6A5ep7NlrzeEurI+13ZLBaPfe8k5Ld
 zeP9fsqy1o/4lWyYxYr+RXAO+GQ95N8XxCdlKJO6wcMm0fRK7odYsnn8tOLf8SQe4EAbVuP
 ATtl7xXAzAvxTTOGdWGDg==
UI-OutboundReport: notjunk:1;M01:P0:dgZi+NgPra4=;j+Jz2U5mQgFW/erfbUEFOX8A4I0
 zxEcqW62Tv+oFrZemZyhN7sArboEQ9iJP5nJ2Bx9IK8TglbzN46Kgu/+OXrKvx+Gp8yblRkNK
 W4aEMTA/bspIMq9GFjiNMqqT+6y0XfOrJC6hmjuYOxJE7l+vKS50rNmOSqFwPIuClh3rWBUid
 TqG2VTZ1wDAeaGxvorM6WhdEYThAo0RMpStd9FiQ9DHWuOoXEHARlcYHeImmmtpe4TmcGKWE+
 6Hb+erYjECHPtCe0ToldHKiZ8NmckPVfxFmUwg4IoHC9HGNeFWQxCuavyNJfFpmbSlG22ux9c
 DOmbrwYDnKvX0Z9ksWWSMF/SyaNJHETOLwk9up6IiN0ZqszJwF465MZVamm+1dj+UPKN+0sK7
 KeP72u3s92RpmuQRp6ioi/C7bshI2jormHgBnFWwAegcqRrdaOxNjnJE3vDgoysqwVALLoojX
 4FqaFB3XqnfcmpAE3h9BzZ3m3ElSJgDQ0Aa9ERRh/OMoOPnNOVIGLJF9d2T6QUBrO/8/t7wtD
 4FNrJBol8xRCs+CeZkkusiD3YDb2+ue9yDmAwxi6z/DgYZVDW28j3a+vCHintaudthaNA79q1
 2rfFBMrumw/sf3rwxiNCF3g7GFee9DHSYd84utD4L1Sx0LOZSsXESUVMKZ6B5IkD31DmQdiBH
 DOq2fIjSzuG0h9WZahRwD0mlDfZy/iipZJqyoKrjkUC4wR0PYCyGyzRxFgT3glS5rP2xNFADm
 Em3YLGfHo0DiycNGMewa5Re9GoC5s/V/oLH5CVqf+giBuErKEuIXDlYRU8ln54v3z4DNyBnSU
 6O94JSPzaYMoeDOygnAP3B4pnFw1AJ/urpPsXW061oMxdlrgpXzYzCFFYCySt5WujWWEjanxs
 MDYs18ZE8+6bFTUn/BI6XVc1rnI+OWJ+lYjgbT9qiWzycx2fNY2gO+TCD
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

On 11/2/24 20:36, Simon Glass wrote:
> This test doesn't belong at the top level. Move it into the lib/
> directory, to match (most of) its implementation. Rename it to drop the
> unnecessary _ut suffix.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>   test/Makefile                | 1 -
>   test/lib/Makefile            | 1 +
>   test/{str_ut.c =3D> lib/str.c} | 0
>   3 files changed, 1 insertion(+), 1 deletion(-)
>   rename test/{str_ut.c =3D> lib/str.c} (100%)
>
> diff --git a/test/Makefile b/test/Makefile
> index 9f19bfa472b..220a249c397 100644
> --- a/test/Makefile
> +++ b/test/Makefile
> @@ -14,7 +14,6 @@ endif
>   ifneq ($(CONFIG_HUSH_PARSER),)
>   obj-$(CONFIG_$(XPL_)CMDLINE) +=3D hush/
>   endif
> -obj-$(CONFIG_$(XPL_)CMDLINE) +=3D str_ut.o
>   obj-$(CONFIG_UT_TIME) +=3D time_ut.o
>   obj-y +=3D ut.o
>
> diff --git a/test/lib/Makefile b/test/lib/Makefile
> index ce22780eed8..be20bbc047f 100644
> --- a/test/lib/Makefile
> +++ b/test/lib/Makefile
> @@ -17,6 +17,7 @@ obj-y +=3D lmb.o
>   obj-y +=3D longjmp.o
>   obj-$(CONFIG_CONSOLE_RECORD) +=3D test_print.o
>   obj-$(CONFIG_SSCANF) +=3D sscanf.o
> +obj-$(CONFIG_$(XPL_)CMDLINE) +=3D str.o

Shouldn't this be CONFIG_$(PHASE_)STRTO, see lib/Makefile.

I would not know why we need *CMDLINE as dependency here.

Cf.
https://patchwork.ozlabs.org/project/uboot/patch/20241113210646.88937-1-he=
inrich.schuchardt@canonical.com/

Best regards

Heinrich


>   obj-y +=3D string.o
>   obj-y +=3D strlcat.o
>   obj-$(CONFIG_ERRNO_STR) +=3D test_errno_str.o
> diff --git a/test/str_ut.c b/test/lib/str.c
> similarity index 100%
> rename from test/str_ut.c
> rename to test/lib/str.c

