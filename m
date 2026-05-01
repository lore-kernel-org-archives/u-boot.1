Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1833EFF885A
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 22:35:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42591840D8;
	Sat,  2 May 2026 00:35:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YxQrSQsL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0000184255; Sat,  2 May 2026 00:35:27 +0200 (CEST)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com
 [IPv6:2607:f8b0:4864:20::e34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0534583693
 for <u-boot@lists.denx.de>; Sat,  2 May 2026 00:35:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-6055a0414d7so663117137.2
 for <u-boot@lists.denx.de>; Fri, 01 May 2026 15:35:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777674925; cv=none;
 d=google.com; s=arc-20240605;
 b=BEH2PG5AILvOpM/EcATw9T9TCK/eETgydP6pbG5JXxoVPHut5pi80YZBLc8Vj3jfz4
 qIVO0nIBJXPtRKhZ7dNPtAkjosPoDWs8emoE82MXZh2IC9ddnaIYu1d1s+CHsvwUoF3i
 EuROjNohEoaV75/JGvzqkvafBJ2nVSbHDJZkvRfiLAlwycR6ItA24+ixLb3RVMkwELBL
 gYm7MePM4Mpea6IB8XeyY5n2N6pp6jiNIua3QYFaMAgYZHk9ZpJwWfuiCXnKHngi7YnG
 x6XMVwFbtX0wiAjIHo+de/9mJU3+1FsEm05cZKziTUBoAopZs+8IyRSgagBSHy+PEnOF
 nWVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kq4LoG77G0tIyAE5hkiai78t5z0kP3L9OV0gtH5Yxu0=;
 fh=IO3PX89vpQQt96TTQ9YS2SnMByLH1CqE1jFUfpg3CD8=;
 b=MK6dPQ4VRhYtgjUX63bF5K0rVY9lOEEQY4khPJ1KhAq8sw5AuC4xvh9BiJW5JDMnrO
 RliUM1SE7BIhU20MholCp/5Y+Dv9EWURfvzA1t92ZvUmcCKIoy2zxYXBnjwpqRn9x4NL
 9NUvmRG4OiMFYRuh8LQ0zuKvLNUssJUo0ldlLMi3HxTkLt5lLBgtujavuDDPwaxNyitu
 /T5RbVKdqgdmO7JGpnpetorFkvwWumISYI/uMZXEQWLfepY7mpGc6HGWjWzbNz9MJh7+
 FRrXWYjVpOjgjAjpCOYKWiRnvxlc05g58uLszgSvIuoSEgpIHo5jeiHwMaqEbEGN+190
 12ig==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777674925; x=1778279725; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kq4LoG77G0tIyAE5hkiai78t5z0kP3L9OV0gtH5Yxu0=;
 b=YxQrSQsLMTcH94vOS0qpYwA/BmBtAqlhrsQnptVHyp5ntb0xTGD5RdYg3ZMeZQNG1t
 ytcWGpExmgJigRLqkL828qJO32M22Kfg0mccDpTdd3uDmFq9U4NWQ0gITSiEzTxrNGsR
 4mnns+A2CTthFaC4QepsPehedtgvJXbSNdkglmgm6jnnVonJuhsVERtYXY48N/v5Aee3
 ih7CwTi8Jvx+NmSiGyeqE3vmkkF/HMHOzMEYfsi0SzAXmJGO8TJ+FbX/3ZR17brMej/V
 g/HmTYCTKxfkIsK2lY6BCdw0dqBmlnF4EsaA1Reh9NLRfGWLY66fJTGaNLtnHtbelBL5
 BDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777674925; x=1778279725;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kq4LoG77G0tIyAE5hkiai78t5z0kP3L9OV0gtH5Yxu0=;
 b=ijLD9CBw9f9a/sM51VsO5el47JHvJwFutg1OTb3iHvFm+SZoL/sTmBq0R3i8airpN7
 Rla9+NUjysHEdoNh29KWdwsrFIKRKYD/NOcPe5ovdNdLV38thNMmA2R1w+cGoYxE56p+
 GWEogYjP+zCFf+NqQzGL+nF/YVzgYvpS9uaGf7yJwfozPqamsfnMFQBzsuBcCguAlXtz
 ABGbartYy/9WM0L1xe2NYS/KIWfo0Yj1OPKXsaP7jOHI3cS1llsXjaXHLptWITDhOkXm
 gFJ7vaeLn7fFG2fb8lTK3+RTH+Mj4U7/3/PwO8VgvIw9tA4GjV4VrUU346UlRmahFTSQ
 /wwA==
X-Gm-Message-State: AOJu0Ywj32E50uAA96w2kqtFPH6BAChiHFadsJYquE44+nW8VOYrrj8C
 SLMDL7xdIhas+Hp0RCySajRXReRQsQ9LJR1rzyxJ9+JtRkOSPxYUbCB+xduFwXIXPWIPCMUDU9e
 GHlBclFFrVDO5HXdTv7fm7tbuN+BKALw=
X-Gm-Gg: AeBDiev2bBXV+uzoToYsc4/Ae/Bf9/DjGodwwDh8lKcoF3upaIX1k7TOEhxBECQKvkh
 prVUqDE4LXSXtomGgOL77VRWdCsD079eAMiY+ZrGNavcrtBwd4lxILifJ5g1lLWwePQKmujwrf+
 zx+jD/1xdVgG/nx00TH4QDCHOIl/liUiIgSi22PAdUGXgU2Xljno/LP0LePs8LrGTVN/LATvHd1
 7QNbPd3PhZin8zIM6Ic/B0lTpxg6WQPgq8gHZhVkHr5ciB82CJ45Kq3vw7Zgp8RKBjeMyOkBGyb
 ajB8YQDn4wYl8zv03T0=
X-Received: by 2002:a05:6102:5241:b0:608:9a34:c8ea with SMTP id
 ada2fe7eead31-62d85487f17mr601861137.10.1777674924684; Fri, 01 May 2026
 15:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <cffa552d648f84769f4d5d540f419173f10cb86e.1777444191.git.michal.simek@amd.com>
In-Reply-To: <cffa552d648f84769f4d5d540f419173f10cb86e.1777444191.git.michal.simek@amd.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Fri, 1 May 2026 18:35:12 -0400
X-Gm-Features: AVHnY4IuNwDDanX_aLP3koFXzzHZhHfypKU3v0bWscatkOgad_6mKNCjgfAMaEI
Message-ID: <CAMDkj5yrn8eVGFK61b7F8LS7YTn03yugJJ62QE80QUDw+QhKPQ@mail.gmail.com>
Subject: Re: [PATCH] bloblist: fix pointer comparison in bloblist_apply_blobs()
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Michal,

On Wed, Apr 29, 2026 at 2:30=E2=80=AFAM Michal Simek <michal.simek@amd.com>=
 wrote:
>
> The rec_from_blob() function returns a pointer, but the code was
> comparing it using "rec <=3D 0" which is incorrect for pointer types.
> Pointers should be compared using "=3D=3D NULL" or "!=3D NULL".
>
> Addresses-Coverity-ID: CID 645841: Incorrect expression (BAD_COMPARE)
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  common/bloblist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index afed968ce01d..d084be899588 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -300,7 +300,7 @@ int bloblist_apply_blobs(uint tag, int (*func)(void *=
*data, int size))
>                         }
>
>                         rec =3D rec_from_blob(blob - dat_off);
> -                       if (rec <=3D 0) {
> +                       if (!rec) {
>                                 log_err("Blob corrupted\n");
>                                 return -ENOENT;
>                         }
> --
> 2.43.0
>
> base-commit: e995dcb19c89c5c697b57380831167ff238b0d07

Thanks for the fix.
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>

Raymond
