Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619D6CD3427
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 22:50:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0E5283E36;
	Sat,  2 May 2026 00:50:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PQLIPaPO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53911840D8; Sat,  2 May 2026 00:50:33 +0200 (CEST)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com
 [IPv6:2607:f8b0:4864:20::932])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8E4283693
 for <u-boot@lists.denx.de>; Sat,  2 May 2026 00:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-94ac8cbf3feso1572313241.0
 for <u-boot@lists.denx.de>; Fri, 01 May 2026 15:50:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777675829; cv=none;
 d=google.com; s=arc-20240605;
 b=f5G9OMblSygwlSXEwjNznc/GTGWYPYDQ1Pgc7Fht2H8z3ysVbP2aIt6JpHnSpyxeK3
 yd/gNKqkCBfAQTpdrGD980/7vhvz+S4j8YjomaAR04VDgJojPOX6fzdTcQDmO8+IK7mE
 +UYFXbAQWmR8b8+LT5fUU4ArVxobHo+BdhCFRLnq6d4Cj+pYht6UfSdTDixcYXr6dftM
 IHQX4HJW48B3N1DjbpJjLiJUPLhTOuwFIplUZNZpT90C9d0xCs/n0xxQLJGPLQQlUlIU
 ZchaXwDKvxpSZS+hAzuW5JjlwQts6b05aGXhpWgq91vyrSv/6fopq8ibX/+EFGMySy1t
 FEOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EmUZoz2YbbOv3m1Or9AeV8/lwY9z3y/fKIE7oErjCBY=;
 fh=nJoCrHz++5cdKgzGLgU9DJItF6xo5T4LwP15K8xTYqU=;
 b=iuPUOrX0hN7PV+O3WZBfMgRmELowKpfCAYb77g63bZ5DTVKVEi6xG8r5t2fCUxqxTq
 SSsJohw5gIl+iCh/kaZ5BufMCI8w15FZiv5Q+gYsv/Iqkx8aX932MJUOF7SPfPmgkabL
 Zs/TGYHOG/y3HNJlrwrdmT+Dlj62ilO8aK8BxP0yAI4MiPXw8naEks4Sd4+o12QNvNWz
 1cEgJaLNyZ5WiuPywdW9G+DbfsYOshFCQxrEPf88lv+9dzAkt+YMLd2awcoOqcScDVuF
 Z9VYVs1OdwYCQSVwvsG3qVY4S7XJKHXsMkJP4h60lq7CWB67hA5Y33PjMvimo8Wusd8Z
 Uh+Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777675829; x=1778280629; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EmUZoz2YbbOv3m1Or9AeV8/lwY9z3y/fKIE7oErjCBY=;
 b=PQLIPaPOisUPPogh/5Cfa17+GECK2y39PAOHlkfmhALRkHYnwcKAfdcBjnEIctw2rm
 Dr7IMH+0mLCEpyQd7x1Gw9TcnYesq99wFTo7op4fjNNq+4Q0kGQxfzxNJce7OvHIQGVj
 bdwC939x0/kRAk2kEL+WpJl/l6RGwUAIn7mlIgcT0HDHToJC34UR1/BZgZH1ZdMCq1Ak
 L+R50PHT+rzH0kVBfV7HlnY0cOGm9SaK1dW93q+sMiEeOzdKBTEu5RV1Mt4y61c2E8Df
 F0XAIrZe/sWVY7hoRFZ4PXr3xiFq1Ux6bvyp6r3Ogx6wo1lMLm+x4fZfFvaL8sfRojO5
 sUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777675829; x=1778280629;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EmUZoz2YbbOv3m1Or9AeV8/lwY9z3y/fKIE7oErjCBY=;
 b=MHrBI60zlsJ7qNkAhMHOqWb7V8mV8JKRNGJZfm+OXgHucYosGGRueTSCXxzfNTzyl8
 aMBhKbZb7iVmQTrqfNnDGBYBOfHT9RnY34yfG0J3EWDYbjj2LWsJUsQrNHxmuD4zyv0B
 sqy9r8FEWiqETV38dUgHLLNgunSV3vPu2SIQmOvlkg+stLWj0VAGaRxlsr2L2xvv2Fmb
 qi01EhX+k0FVvNzcKfbMqEsBeHCIiQdF/He0F60pMeBM3ulIg9iL1URJOCy8Ff+MBcMZ
 hWdqMhLvQHXIjNfqIb0GL5dO7eUBEwiSmFZC7XTN2PXwcT1RJWyQ5Amjs1hY4L3P71sy
 wsiA==
X-Gm-Message-State: AOJu0YwagSPKokahyduLsdvRPWpcXVMcR8biJQ4AhQCOG8Bop2O16bts
 5gitCRY5akCXw7Tffd4lKiDZ50FFtcpCiGQfjJri15gYjlmm+7f+kDZdi4uWd1Cd+t1uzjNvX5B
 tgLLkPefKviW5NINWUG060TS+1uXhUeA=
X-Gm-Gg: AeBDietegfoIRd+zat1gJNNFe6TkkPMUBjdJHkkk1PHtRVIgQTmjMTYf2vmiUn4htrz
 yU/JOjvzQJkSfn0hbd8qdF1r160uD9EpVRaS3w/r03sYkJdcvfN2xc+6du3gBtrWjXBv/fYNt1Q
 QFsgb7rC3U2uWwTtBOFiVuLpByoBvixeEpaKC5PhN8zGCK8uhMo0S9n6ayNAbg6+NlNOhnVYcSJ
 Zazn4NZJf4q125PF5A8MlZBifIMGAUBkR6vTtWD5eKcTEVT02Bvfu5IHjXimKZe/xy5Yp16Lzev
 XFAoCmNT9Qk233x0hs4=
X-Received: by 2002:a05:6102:3594:b0:5ff:b3f7:48de with SMTP id
 ada2fe7eead31-62d81c83c6cmr679890137.0.1777675829463; Fri, 01 May 2026
 15:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260428140433.GQ41863@bill-the-cat>
In-Reply-To: <20260428140433.GQ41863@bill-the-cat>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Fri, 1 May 2026 18:50:18 -0400
X-Gm-Features: AVHnY4Iq4kxgvzIVrjTDhbV-1hTmU9-2RvlV9ABeADtvCPq274NVMxv1afheywE
Message-ID: <CAMDkj5z-Fy3z6icxaNdz3TbYDR=3SSonEOKDuqVzahx=Migz7A@mail.gmail.com>
Subject: Re: New Defects reported by Coverity Scan for Das U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, 
 =?UTF-8?Q?Christian_P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

Hi Tom,

On Tue, Apr 28, 2026 at 10:04=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:
>
> Here's the latest report.
>
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Mon, Apr 27, 2026, 5:41=E2=80=AFPM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
>
>
> Hi,
>
> Please find the latest report on new defect(s) introduced to *Das U-Boot*
> found with Coverity Scan.
>
>    - *New Defects Found:* 9
>    - 77 defect(s), reported by Coverity Scan earlier, were marked fixed i=
n
>    the recent build analyzed by Coverity Scan.
>    - *Defects Shown:* Showing 9 of 9 defect(s)
>
> Defect Details
>
>
> ** CID 645841:       Incorrect expression  (BAD_COMPARE)
> /common/bloblist.c: 303           in bloblist_apply_blobs()
>
>
> _________________________________________________________________________=
____________________
> *** CID 645841:         Incorrect expression  (BAD_COMPARE)
> /common/bloblist.c: 303             in bloblist_apply_blobs()
> 297                                     log_err("Failed to apply blob wit=
h tag %d\n",
> 298                                             tag);
> 299                                     return ret;
> 300                             }
> 301
> 302                             rec =3D rec_from_blob(blob - dat_off);
> >>>     CID 645841:         Incorrect expression  (BAD_COMPARE)
> >>>     Comparing pointer "rec" against "NULL" using anything besides "=
=3D=3D" or "!=3D" is likely to be incorrect.
> 303                             if (rec <=3D 0) {
> 304                                     log_err("Blob corrupted\n");
> 305                                     return -ENOENT;
> 306                             }
> 307
> 308                             /* Mark applied blob record as void */
>
> ** CID 645840:       Uninitialized variables  (UNINIT)
>
>
> _________________________________________________________________________=
____________________
> *** CID 645840:         Uninitialized variables  (UNINIT)
> /lib/efi_loader/efi_device_path.c: 967             in efi_dp_from_http()
> 961             if ((server && strlen("http://") + strlen(server) + 1  >
> sizeof(tmp)) ||
> 962                 (!server && IS_ENABLED(CONFIG_NET_LWIP)))
> 963                     return NULL;
> 964
> 965             efi_net_get_addr(&ip, &mask, NULL, dev);
> 966
> >>>     CID 645840:         Uninitialized variables  (UNINIT)
> >>>     Using uninitialized value "ip" when calling "efi_dp_from_ipv4".
> 967             dp1 =3D efi_dp_from_ipv4(&ip, &mask, NULL, dev);
> 968             if (!dp1)
> 969                     return NULL;
> 970
> 971
> 972             strcpy(tmp, "http://");
>
> ** CID 645839:       Error handling issues  (CHECKED_RETURN)
> /lib/fdtdec.c: 1785           in fdtdec_apply_bloblist_dtos()
>
>
> _________________________________________________________________________=
____________________
> *** CID 645839:         Error handling issues  (CHECKED_RETURN)
> /lib/fdtdec.c: 1785             in fdtdec_apply_bloblist_dtos()
> 1779
> 1780            ret =3D bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
> fdtdec_apply_dto_blob);
> 1781            if (ret)
> 1782                    return ret;
> 1783
> 1784            /* Shink the blob to the actual FDT size */
> >>>     CID 645839:         Error handling issues  (CHECKED_RETURN)
> >>>     Calling "fdt_pack" without checking return value (as is done else=
where 5 out of 6 times).
> 1785            fdt_pack(live_fdt);
> 1786            return bloblist_resize(BLOBLISTT_CONTROL_FDT,
> fdt_totalsize(live_fdt));
> 1787     }
> 1788
> 1789     int fdtdec_setup(void)
> 1790     {
>
> ** CID 645838:       Uninitialized variables  (UNINIT)
>
>
> _________________________________________________________________________=
____________________
> *** CID 645838:         Uninitialized variables  (UNINIT)
> /lib/efi_loader/efi_device_path.c: 967             in efi_dp_from_http()
> 961             if ((server && strlen("http://") + strlen(server) + 1  >
> sizeof(tmp)) ||
> 962                 (!server && IS_ENABLED(CONFIG_NET_LWIP)))
> 963                     return NULL;
> 964
> 965             efi_net_get_addr(&ip, &mask, NULL, dev);
> 966
> >>>     CID 645838:         Uninitialized variables  (UNINIT)
> >>>     Using uninitialized value "mask" when calling "efi_dp_from_ipv4".
> 967             dp1 =3D efi_dp_from_ipv4(&ip, &mask, NULL, dev);
> 968             if (!dp1)
> 969                     return NULL;
> 970
> 971
> 972             strcpy(tmp, "http://");
>
> ** CID 645837:         (TAINTED_SCALAR)
>
>
> _________________________________________________________________________=
____________________

Fix was posted at:
https://lore.kernel.org/u-boot/20260501222801.1596650-1-raymondmaoca@gmail.=
com/T/#u

Raymond

> *** CID 645837:           (TAINTED_SCALAR)
> /lib/fdtdec.c: 1775             in fdtdec_apply_bloblist_dtos()
> 1769            /* Resize if the current space is not sufficient */
> 1770            if (blob_size < padded_size) {
> 1771                    ret =3D bloblist_resize(BLOBLISTT_CONTROL_FDT, pa=
dded_size);
> 1772                    if (ret)
> 1773                            return ret;
> 1774
> >>>     CID 645837:           (TAINTED_SCALAR)
> >>>     Passing tainted expression "live_fdt->size_dt_struct" to "fdt_ope=
n_into", which uses it as an offset.
> 1775                    ret =3D fdt_open_into(live_fdt, live_fdt, padded_=
size);
> 1776                    if (ret)
> 1777                            return ret;
> 1778            }
> 1779
> 1780            ret =3D bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
> fdtdec_apply_dto_blob);
> /lib/fdtdec.c: 1785             in fdtdec_apply_bloblist_dtos()
> 1779
> 1780            ret =3D bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
> fdtdec_apply_dto_blob);
> 1781            if (ret)
> 1782                    return ret;
> 1783
> 1784            /* Shink the blob to the actual FDT size */
> >>>     CID 645837:           (TAINTED_SCALAR)
> >>>     Passing tainted expression "live_fdt->size_dt_struct" to "fdt_pac=
k", which uses it as an offset.
> 1785            fdt_pack(live_fdt);
> 1786            return bloblist_resize(BLOBLISTT_CONTROL_FDT,
> fdt_totalsize(live_fdt));
> 1787     }
> 1788
> 1789     int fdtdec_setup(void)
> 1790     {
> /lib/fdtdec.c: 1775             in fdtdec_apply_bloblist_dtos()
> 1769            /* Resize if the current space is not sufficient */
> 1770            if (blob_size < padded_size) {
> 1771                    ret =3D bloblist_resize(BLOBLISTT_CONTROL_FDT, pa=
dded_size);
> 1772                    if (ret)
> 1773                            return ret;
> 1774
> >>>     CID 645837:           (TAINTED_SCALAR)
> >>>     Passing tainted expression "live_fdt->totalsize" to "fdt_open_int=
o", which uses it as an offset.
> 1775                    ret =3D fdt_open_into(live_fdt, live_fdt, padded_=
size);
> 1776                    if (ret)
> 1777                            return ret;
> 1778            }
> 1779
> 1780            ret =3D bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
> fdtdec_apply_dto_blob);
> /lib/fdtdec.c: 1786             in fdtdec_apply_bloblist_dtos()
> 1780            ret =3D bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
> fdtdec_apply_dto_blob);
> 1781            if (ret)
> 1782                    return ret;
> 1783
> 1784            /* Shink the blob to the actual FDT size */
> 1785            fdt_pack(live_fdt);
> >>>     CID 645837:           (TAINTED_SCALAR)
> >>>     Passing tainted expression "fdt32_ld(&((struct fdt_header const *=
)live_fdt)->totalsize)" to "bloblist_resize", which uses it as an offset.
> 1786            return bloblist_resize(BLOBLISTT_CONTROL_FDT,
> fdt_totalsize(live_fdt));
> 1787     }
> 1788
> 1789     int fdtdec_setup(void)
> 1790     {
> 1791            int ret =3D -ENOENT;
> /lib/fdtdec.c: 1775             in fdtdec_apply_bloblist_dtos()
> 1769            /* Resize if the current space is not sufficient */
> 1770            if (blob_size < padded_size) {
> 1771                    ret =3D bloblist_resize(BLOBLISTT_CONTROL_FDT, pa=
dded_size);
> 1772                    if (ret)
> 1773                            return ret;
> 1774
> >>>     CID 645837:           (TAINTED_SCALAR)
> >>>     Passing tainted expression "live_fdt->size_dt_strings" to "fdt_op=
en_into", which uses it as an offset.
> 1775                    ret =3D fdt_open_into(live_fdt, live_fdt, padded_=
size);
> 1776                    if (ret)
> 1777                            return ret;
> 1778            }
> 1779
> 1780            ret =3D bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
> fdtdec_apply_dto_blob);
> /lib/fdtdec.c: 1785             in fdtdec_apply_bloblist_dtos()
> 1779
> 1780            ret =3D bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
> fdtdec_apply_dto_blob);
> 1781            if (ret)
> 1782                    return ret;
> 1783
> 1784            /* Shink the blob to the actual FDT size */
> >>>     CID 645837:           (TAINTED_SCALAR)
> >>>     Passing tainted expression "live_fdt->size_dt_struct" to "fdt_pac=
k", which uses it as an offset.
> 1785            fdt_pack(live_fdt);
> 1786            return bloblist_resize(BLOBLISTT_CONTROL_FDT,
> fdt_totalsize(live_fdt));
> 1787     }
> 1788
> 1789     int fdtdec_setup(void)
> 1790     {
> /lib/fdtdec.c: 1786             in fdtdec_apply_bloblist_dtos()
> 1780            ret =3D bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
> fdtdec_apply_dto_blob);
> 1781            if (ret)
> 1782                    return ret;
> 1783
> 1784            /* Shink the blob to the actual FDT size */
> 1785            fdt_pack(live_fdt);
> >>>     CID 645837:           (TAINTED_SCALAR)
> >>>     Passing tainted expression "fdt32_ld(&((struct fdt_header const *=
)live_fdt)->totalsize)" to "bloblist_resize", which uses it as an offset.
> 1786            return bloblist_resize(BLOBLISTT_CONTROL_FDT,
> fdt_totalsize(live_fdt));
> 1787     }
> 1788
> 1789     int fdtdec_setup(void)
> 1790     {
> 1791            int ret =3D -ENOENT;
> /lib/fdtdec.c: 1785             in fdtdec_apply_bloblist_dtos()
> 1779
> 1780            ret =3D bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
> fdtdec_apply_dto_blob);
> 1781            if (ret)
> 1782                    return ret;
> 1783
> 1784            /* Shink the blob to the actual FDT size */
> >>>     CID 645837:           (TAINTED_SCALAR)
> >>>     Passing tainted expression "live_fdt->size_dt_strings" to "fdt_pa=
ck", which uses it as an offset.
> 1785            fdt_pack(live_fdt);
> 1786            return bloblist_resize(BLOBLISTT_CONTROL_FDT,
> fdt_totalsize(live_fdt));
> 1787     }
> 1788
> 1789     int fdtdec_setup(void)
> 1790     {
> /lib/fdtdec.c: 1786             in fdtdec_apply_bloblist_dtos()
> 1780            ret =3D bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
> fdtdec_apply_dto_blob);
> 1781            if (ret)
> 1782                    return ret;
> 1783
> 1784            /* Shink the blob to the actual FDT size */
> 1785            fdt_pack(live_fdt);
> >>>     CID 645837:           (TAINTED_SCALAR)
> >>>     Passing tainted expression "fdt32_ld(&((struct fdt_header const *=
)live_fdt)->totalsize)" to "bloblist_resize", which uses it as an offset.
> 1786            return bloblist_resize(BLOBLISTT_CONTROL_FDT,
> fdt_totalsize(live_fdt));
> 1787     }
> 1788
> 1789     int fdtdec_setup(void)
> 1790     {
> 1791            int ret =3D -ENOENT;
> /lib/fdtdec.c: 1786             in fdtdec_apply_bloblist_dtos()
> 1780            ret =3D bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
> fdtdec_apply_dto_blob);
> 1781            if (ret)
> 1782                    return ret;
> 1783
> 1784            /* Shink the blob to the actual FDT size */
> 1785            fdt_pack(live_fdt);
> >>>     CID 645837:           (TAINTED_SCALAR)
> >>>     Passing tainted expression "fdt32_ld(&((struct fdt_header const *=
)live_fdt)->totalsize)" to "bloblist_resize", which uses it as an offset.
> 1786            return bloblist_resize(BLOBLISTT_CONTROL_FDT,
> fdt_totalsize(live_fdt));
> 1787     }
> 1788
> 1789     int fdtdec_setup(void)
> 1790     {
> 1791            int ret =3D -ENOENT;
> /lib/fdtdec.c: 1786             in fdtdec_apply_bloblist_dtos()
> 1780            ret =3D bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
> fdtdec_apply_dto_blob);
> 1781            if (ret)
> 1782                    return ret;
> 1783
> 1784            /* Shink the blob to the actual FDT size */
> 1785            fdt_pack(live_fdt);
> >>>     CID 645837:           (TAINTED_SCALAR)
> >>>     Passing tainted expression "fdt32_ld(&((struct fdt_header const *=
)live_fdt)->totalsize)" to "bloblist_resize", which uses it as an offset.
> 1786            return bloblist_resize(BLOBLISTT_CONTROL_FDT,
> fdt_totalsize(live_fdt));
> 1787     }
> 1788
> 1789     int fdtdec_setup(void)
> 1790     {
> 1791            int ret =3D -ENOENT;
> /lib/fdtdec.c: 1785             in fdtdec_apply_bloblist_dtos()
> 1779
> 1780            ret =3D bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
> fdtdec_apply_dto_blob);
> 1781            if (ret)
> 1782                    return ret;
> 1783
> 1784            /* Shink the blob to the actual FDT size */
> >>>     CID 645837:           (TAINTED_SCALAR)
> >>>     Passing tainted expression "live_fdt->size_dt_struct" to "fdt_pac=
k", which uses it as an offset.
> 1785            fdt_pack(live_fdt);
> 1786            return bloblist_resize(BLOBLISTT_CONTROL_FDT,
> fdt_totalsize(live_fdt));
> 1787     }
> 1788
> 1789     int fdtdec_setup(void)
> 1790     {
> /lib/fdtdec.c: 1785             in fdtdec_apply_bloblist_dtos()
> 1779
> 1780            ret =3D bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
> fdtdec_apply_dto_blob);
> 1781            if (ret)
> 1782                    return ret;
> 1783
> 1784            /* Shink the blob to the actual FDT size */
> >>>     CID 645837:           (TAINTED_SCALAR)
> >>>     Passing tainted expression "live_fdt->size_dt_strings" to "fdt_pa=
ck", which uses it as an offset.
> 1785            fdt_pack(live_fdt);
> 1786            return bloblist_resize(BLOBLISTT_CONTROL_FDT,
> fdt_totalsize(live_fdt));
> 1787     }
> 1788
> 1789     int fdtdec_setup(void)
> 1790     {
> /lib/fdtdec.c: 1786             in fdtdec_apply_bloblist_dtos()
> 1780            ret =3D bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
> fdtdec_apply_dto_blob);
> 1781            if (ret)
> 1782                    return ret;
> 1783
> 1784            /* Shink the blob to the actual FDT size */
> 1785            fdt_pack(live_fdt);
> >>>     CID 645837:           (TAINTED_SCALAR)
> >>>     Passing tainted expression "fdt32_ld(&((struct fdt_header const *=
)live_fdt)->totalsize)" to "bloblist_resize", which uses it as an offset.
> 1786            return bloblist_resize(BLOBLISTT_CONTROL_FDT,
> fdt_totalsize(live_fdt));
> 1787     }
> 1788
> 1789     int fdtdec_setup(void)
> 1790     {
> 1791            int ret =3D -ENOENT;
>
> ** CID 645836:       Resource leaks  (RESOURCE_LEAK)
> /drivers/gpio/gpio_scmi.c: 201           in scmi_gpio_probe()
>
>
> _________________________________________________________________________=
____________________
> *** CID 645836:         Resource leaks  (RESOURCE_LEAK)
> /drivers/gpio/gpio_scmi.c: 201             in scmi_gpio_probe()
> 195                             return -ENOMEM;
> 196
> 197                     range->base =3D args.args[0];
> 198                     if (range->base !=3D priv->num_pins) {
> 199                             dev_err(dev, "no gaps allowed in between =
pins %d vs %d\n",
> 200                                     priv->num_pins, range->base);
> >>>     CID 645836:         Resource leaks  (RESOURCE_LEAK)
> >>>     Variable "range" going out of scope leaks the storage it points t=
o.
> 201                             return -EINVAL;
> 202                     }
> 203                     range->offset =3D args.args[1];
> 204                     range->npins =3D args.args[2];
> 205                     priv->num_pins +=3D args.args[2];
> 206                     list_add_tail(&range->list, &priv->gpio_ranges);
>
> ** CID 645835:       Memory - corruptions  (OVERRUN)
> /lib/gunzip.c: 248           in gzwrite()
>
>
> _________________________________________________________________________=
____________________
> *** CID 645835:         Memory - corruptions  (OVERRUN)
> /lib/gunzip.c: 248             in gzwrite()
> 242                                     s.avail_out =3D szwritebuf - numf=
illed;
> 243                                     s.next_out =3D writebuf + numfill=
ed;
> 244                             } else {
> 245                                     s.avail_out =3D szwritebuf;
> 246                                     s.next_out =3D writebuf;
> 247                             }
> >>>     CID 645835:         Memory - corruptions  (OVERRUN)
> >>>     Calling "inflate" with "s.next_in" and "s.avail_in" is suspicious=
 because of the very large index, 4294966272. The index may be due to a neg=
ative parameter being interpreted as unsigned. [Note: The source code imple=
mentation of the function has been overridden by a builtin model.]
> 248                             r =3D inflate(&s, Z_SYNC_FLUSH);
> 249                             if ((r !=3D Z_OK) &&
> 250                                 (r !=3D Z_STREAM_END)) {
> 251                                     printf("Error: inflate() returned=
 %d\n", r);
> 252                                     goto out;
> 253                             }
>
> ** CID 645834:       Control flow issues  (NO_EFFECT)
> /drivers/virtio/virtio_blk.c: 184           in virtio_blk_do_req()
>
>
> _________________________________________________________________________=
____________________
> *** CID 645834:         Control flow issues  (NO_EFFECT)
> /drivers/virtio/virtio_blk.c: 184             in virtio_blk_do_req()
> 178             */
> 179             while (i < blkcnt) {
> 180                     u32 blk_per_sg =3D min(blkcnt - i, seg_sec_cnt * =
priv->seg_max);
> 181
> 182                     ret =3D virtio_blk_do_single_req(dev, sector + i,=
 blk_per_sg,
> 183                                                    buffer + i * 512, =
type);
> >>>     CID 645834:         Control flow issues  (NO_EFFECT)
> >>>     This less-than-zero comparison of an unsigned value is never true=
. "ret < 0UL".
> 184                     if (ret < 0)
> 185                             return ret;
> 186                     i +=3D blk_per_sg;
> 187             }
> 188
> 189             return blkcnt >> priv->blksz_shift;
>
> ** CID 645833:       Control flow issues  (DEADCODE)
> /drivers/virtio/virtio_blk.c: 185           in virtio_blk_do_req()
>
>
> _________________________________________________________________________=
____________________
> *** CID 645833:         Control flow issues  (DEADCODE)
> /drivers/virtio/virtio_blk.c: 185             in virtio_blk_do_req()
> 179             while (i < blkcnt) {
> 180                     u32 blk_per_sg =3D min(blkcnt - i, seg_sec_cnt * =
priv->seg_max);
> 181
> 182                     ret =3D virtio_blk_do_single_req(dev, sector + i,=
 blk_per_sg,
> 183                                                    buffer + i * 512, =
type);
> 184                     if (ret < 0)
> >>>     CID 645833:         Control flow issues  (DEADCODE)
> >>>     Execution cannot reach this statement: "return ret;".
> 185                             return ret;
> 186                     i +=3D blk_per_sg;
> 187             }
> 188
> 189             return blkcnt >> priv->blksz_shift;
> 190     }
>
>
>
> View Defects in Coverity Scan
> <https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>
>
> Best regards,
>
> The Coverity Scan Admin Team
>
> ----- End forwarded message -----
>
> --
> Tom
