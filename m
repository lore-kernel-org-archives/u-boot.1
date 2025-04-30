Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F433C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 11:06:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A479A8283E;
	Wed, 30 Apr 2025 13:06:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="hmbvTcVt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12EEB82B19; Wed, 30 Apr 2025 13:06:41 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81A768215E
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 13:06:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1746011180; x=1746615980; i=xypron.glpk@gmx.de;
 bh=ZyG+1S3sBzJPM5XjqS0yFmWpcuyXZK01DkquPDFKgMo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=hmbvTcVtigh/V3SwXKUseCRr6cm015LVafrgjp1ps2O9yUqjeXQcSlLidXg4+GAH
 4WULL0/bwSoWWChyIOZCEliNFo8J9nVz5j7XbciGTGvjXoE/5qrcvhokUnVdxrcDv
 95VmyJYHJINgiqc9YL7HO7yfNfOa/1XGth/ElYEjKulAV+BTGWcuRYKibTJiuQ5J3
 umZGHMExZXl2m2oLKvMkhuCNrpfJ+z4hviRR2GFZcR1O04yk+ZbdO6bsfIXIkqwrt
 wPaYCm8ymgGQqkRa+3EgDNiQUZR5C0bSXexiNOpWibE1PBq5IW4D8+VZwXcl6xvMz
 YwGFYooCisJR92oAcQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTiPl-1ueAKX2wVJ-00J79a; Wed, 30
 Apr 2025 13:06:20 +0200
Message-ID: <3403cd7d-6030-4388-9442-6a8ccc9c8abf@gmx.de>
Date: Wed, 30 Apr 2025 13:06:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] uthread: doc: fix inline documentation
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot mailing list <u-boot@lists.denx.de>
References: <20250429095747.3867260-1-jerome.forissier@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250429095747.3867260-1-jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h4l8mPYLAwD98JFUuZCDjz8N39ShNy4eKy0e65ZZaLppTxHoXK5
 MMY/LvVklhAyj6DHC1aQlDQFHgsnuDzvRVGN1odYDivFXIRHNE8T104+K2J11zBX1YjtKGJ
 tBBMaGSbcXQcsN3bzIv1V1OeP2qA+c0B794q3mGSorTlEFJ30zBFtJw1LVK87H+91v9CSR5
 M3IC0tAjV1mjxntC4Qz9Q==
UI-OutboundReport: notjunk:1;M01:P0:2q5sQjCkFnA=;2rceX8TqT78QhxlLrADxtiEuZNA
 jMW5rCqTNyOjCu209jA7vlAVup8C/0rWzW/ol5ziI/vIaPyu323f2evyE6V4np11KOGrxDkiU
 4gryatDjvXS4oCg/nTFkJZxdoACvKgkdC+sndgk8j0OFh710f+rQ44gpJ01h0cPz+S83ciLEI
 w6RVbRc0Eb24JY1qjmfkl27UlGBzU79xggbjC5k9KwG1UYFZbWapdXgDvBmvAMsAi/BbBv46M
 fvS8bfVPEP4r2vi42YrV25MBnjk5IjF1Nx2hEVnHegHSLcytL9mdjeuNzinS0K/4P/F5LUbmm
 apwLju+b4sIcBMW4zi0yTWJ3jBb9YPFR9pOQ81XcEfOoQ7Juwp7dJ5SyI9bn7EOJKwcqz0Adw
 HggWOykbVF79BOz/iJTjxRAZtsIuWIe6g2mzJZw9YfhyKu7QACHXGrIvtnSdvyc60FBDs9/db
 SUT/p1myv0Kg8PR7cRZ32e/CNEBxmOSyvmDYiDL6WL24aHxWtDTIMC7+xfd025MoWY75iphYl
 EQzKgTFzkYOQydw++IWfhM8L83NjlkjldKx1j52r0moyRvLNqFOvtY6IFFtSdDf7juwwu5eLO
 +WzKkQu+EwVVuKzeEuAi/Z3/LDMcpM1DN4Gs0rf0QlPx0SMcz8tzMt2y5FDaVVOX6yADLL1YX
 wJVOGOavMmJf3eSndJMWyKyqVjB5/cPa+T9fVCin9aSm0f2N/vClFDf/hDdcrYHwyqlBx0ujF
 w5VjpZ+yImYEuFOtc/VlKDKO6D2vdmisbTHIQZGYuvm+5QPXAf9f5ZvDURJPjpszX7fBo5gfo
 nqawLV62101G9T5Wk3P5HombXZgkemz4aIGzZmrPShUZ/YRMSj5fSqWNahX3V2MRaXJARuPBx
 ofYPHWPyYwc4htdiiEv+ZbembCWzc4WNMUiP/bDG6Thl+t2NcIWc6F4RT35GeXOS2KuAhQ2c9
 mr5V16DXzC1f+7orsTFNyPn8owYFKE2muEw1CX/A+NKbDCPrMFyUrex0qxoh4QtBL1tFf+2RO
 x01cbdBkTnhYt+yoNDSEcuL00eAaYrt/QYcHSaUKLbmkOPCAxvZZxnnXRfvy4X75nzmt9hZqk
 hKDfkoR+pG52Xht5KKefMDKxyRQHxsUXFwa2FgrmpBPw6pqyLEpwWXmZUaoW0FKB1pXpdHdr1
 qIyDli23QiBhLuYYuo7gqfTxqRJuVmvc1CcaSku1hTE5lee9HbdCwAC+2bbgB9VSQ+/pve7G3
 aXh65JpPSz8s/JihwW1wX3m5QIqZd9+SyuLpvkS3rCSkBq/t6YwImlwuFK1Fmp2EM/hi5NEFQ
 hdA0CCzn2lG4xsl495xVROCOq6EJeTSjJzNNtd32NxUvsVOME3m5PWvoTB874HuEq3NxtjgU6
 m9gzirP4qg+Ocl5HKMxajIlCJCaMneAlofuugJj5bGn80oS4bFreuF9g+UiQmOr95fgrmEFtl
 VrIsE+K/u78OOK3yBmVQhLrsQmnBP6Y2VVXLhLm2pL7f3eIVs+4epyYz/8vQOvH+o6NDF5rxl
 OwRmZUCMRalcYy9WMvZ+YJrgXDUjigK+Mx1UMMXNyExL4lFGe6rmlVQ/HEmgpg8kL1+6s3mAb
 vt24Swo3Gu8NsyTGyVjcJh/h+fUdfPS9gF0wDlCNsiL6YaHpBHAf2npEa7aELwO44wcly6TM6
 QnDFiqHKIiTUtYHnuFxwyKsMxILDZGRX04oYERC7kTIrxJlfEARgn1K3yhNDusfsV0j/jKFqU
 U4Oae9FNimvRQ685JO6oUaEYWXhaONFyhLuLyzSV62+4Z/+eURymgQrq6BKMYEejg7lMErLR5
 9YueFhakOic1nuP5cpcEhuaoiXQmyh2Kj7Asb3hZNIvon9BIH3AuuGfm+GYO20NbzkD5MWXwL
 w22JyW00xd3bJFkdaiTXIOXtN0sqErWQ053MtP/ee+ssTu1BLcNpLZxgvIaU8CWYn+lme0PMy
 O/FKyIOZZR3LhjQPtYLJvywOrRixda0K15Z5coqdkPKTNRAPCVHgWvzl0LzrMJqw8guW1FpWg
 G3rYVjZ7PctFPvPNMbPFd7fvSrtoY94lr3ybTlLQjW6OUQxM4jEHzNQCPUfCcx08rXa0e/jdn
 bDbf+L9mcCEe6JpTj7oG2TcrHbghQAgDBEv/pd3YabgSLT4Gap86b8B28egxs0Yzu7G34/e6X
 ibMKujITQqyNUxJsstt5paiqMwIU+l7ZUfo74v/4nYypNaN2ZSEz+1ukmKGUIqgonvOiNps9L
 fTYjODXHNhWEohPvl7AjidldqibpV+fxWn+J5CgmA4OVNMq20Xajqqu1Xnp900KZhsdxKgIFI
 hpXJjpvg0Bg9GPWNeGH1W54AVIkynQk+Qw5uM1/LipL9GTmmP1O486niwOjfrWZg/VXN68fj5
 FWtIJ3PTp3Yt5ylw+kgig13OBOnWJaD+TnefA8L/kJx7RCrIIl1wLUj2BWbpgf9s8B7EeAMAp
 WpJYa61MmM3tbd0g93ONleV2RF3Z2pbf/wj9fBhB2CC/kD6bEoN8CtgB9s6Jmd/hXmMhBisET
 RIGePeJU8gIGovGPfPIHJqsaZnISOZPvKZ5KCqae5uQ+j4rEZOAy4NGWUh1pUtitHm/mvcGoM
 U4szR2Z/+u74FR6PKzWpCn/zzQOcF9K04Ybvya5l113Q2CtYsGIHQqyJQAVEqTOiWwnbgnmbj
 +XJsF4WV+A2kAdd0HhLe660vZ0DLfJDEeru/bIx2izYJzw+Mh093LGEKP0HnwdQtycVLczqoF
 wPtcPQkp/dZxMtnEg1BwBH733GAmN9eaOqIb6RLvpuN+LhvwO8zUrzIVbxfRJwLFQgVfLacgz
 GkiY78brzsnICbhxYrqYEPUeTI09zsMP02EKU1+NYJm9ew8SqMJfOoxO0awFIBAFODRwQMYEZ
 RgdRKbnp9s4B/QwvGshGFx6IBmtXCh4Jl62PWsc0Kt+HT121LEADvjA/MEMvLj42n/sYng7yc
 iatQS7hochbATEV13fEM0dw243hBo8rgJI/2RojCJwllsyWoq0BY
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

On 29.04.25 11:57, Jerome Forissier wrote:
> Fix Sphinx warnings:
>=20
>   $ make htmldocs
>   [...]
>   ./include/uthread.h:56: warning: cannot understand function prototype:=
 'enum uthread_mutex_state '
>   ./include/uthread.h:64: warning: cannot understand function prototype:=
 'struct uthread_mutex '
>   ./include/uthread.h:56: warning: cannot understand function prototype:=
 'enum uthread_mutex_state '
>   ./include/uthread.h:64: warning: cannot understand function prototype:=
 'struct uthread_mutex '
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Reported-by: Tom Rini <trini@konsulko.com>
> ---
>=20
>   include/uthread.h | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/uthread.h b/include/uthread.h
> index 89fa552a6f6..11a19aa9488 100644
> --- a/include/uthread.h
> +++ b/include/uthread.h
> @@ -51,7 +51,10 @@ struct uthread {
>   };
>  =20
>   /**
> - * Internal state of a struct uthread_mutex
> + * enum uthread_mutex_state - internal state of a struct uthread_mutex
> + *
> + * @UTHREAD_MUTEX_UNLOCKED: mutex has no owner
> + * @UTHREAD_MUTEX_LOCKED: mutex has one owner
>    */
>   enum uthread_mutex_state {
>   	UTHREAD_MUTEX_UNLOCKED =3D 0,
> @@ -59,7 +62,9 @@ enum uthread_mutex_state {
>   };
>  =20
>   /**
> - * Uthread mutex
> + * struct uthread_mutex - a mutex object
> + *
> + * @state: the internal state of the mutex
>    */
>   struct uthread_mutex {
>   	enum uthread_mutex_state state;

Tested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
