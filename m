Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2158FF886D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 14:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2447B8460B;
	Tue, 28 Apr 2026 16:04:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ba6+aljT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 834908426E; Tue, 28 Apr 2026 16:04:43 +0200 (CEST)
Received: from mail-oa1-x43.google.com (mail-oa1-x43.google.com
 [IPv6:2001:4860:4864:20::43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B28383FB5
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 16:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x43.google.com with SMTP id
 586e51a60fabf-4303eb92930so1661060fac.3
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777385077; x=1777989877; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZNlxXiQoG+slBC8Anttn6YBaD+t4PewSqu8cr/O2pO8=;
 b=Ba6+aljTCXPgMhZneH6J90sw4sq50PMy7oYg3RZ41TtaZqTVH+sOJph5xtJaVDcurr
 N4o5jq7Tn8V6DjLeyCc4IElcYGpU38alN1bf4Gwy81XWeC/rZD85gMpE+R5Q33YFJY//
 z2PnWTRSMy44lDjnkMuToeY31MWbq6uvnq8Uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777385077; x=1777989877;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZNlxXiQoG+slBC8Anttn6YBaD+t4PewSqu8cr/O2pO8=;
 b=mBe249cWPokdZUxcwI5Mo8r7mIh5D1XbihJHRKLF0WdKQMR1bxFmyVfM7e5Lg9cmCS
 VYCGMBF38wVta+b8xAl920jKKAHsd+fAZRJ67TtCQqalAimivUIDdZBTkJacgW69UyD5
 sAmyYTmViqC1gWSAE/+8xMZ15PeefYWV3QjgNI48zqauarTysgOhzMP/xmdLS7NaTAXV
 sGWaeQQDnSQj6ZZvkDsKLjEq8mQG4u+8arAx5BmYHRt/3zlQpaji/AIdYW2+RsmesCXp
 77cDruQALag9iGfb6akCgbIVe+/Q2Gbj1pU08mw3LSFZ3q1koV49KH9UtXbMgeK0dg1Q
 DwgQ==
X-Gm-Message-State: AOJu0Yw5FB2y1YAG3QYK5Pr3pHH1Sr5KPRuaOY3YCXTUgcmSdwJmvXzI
 yU+EcULR+kXALPdfYJYTGu1ZIYq69dFmYRHDE7pHQFgKjorUWYsM32KuilrpU2G2JC+hDNTvJRp
 Bn8x73zlfXIiz
X-Gm-Gg: AeBDieu2Nw/2gRrPUuuolOsrPFHZu+aP3f6skuXb28Hcmjwv49Tc0H8Sc6tq0M0qjgn
 SXuCxnoor/QAW0vlrZkvsNs3d0w8I8spQOMYzsokK2fEk4neOn1ZIza8l8Q3wyAwtAAb3f9Ob2/
 /tSaretQZN0y0BlIXPCP7skGRD2JlNYxdzAp+uDp0VdGpTJrCa0WJCjy+aetvCLkJUE92KgN5vs
 f9FqJHcEHLyDcV2iy4hbLME0vaiIRt09BIJ5n8izQCATE6vntziGwOeNkuxKl0TTlPSOaGybqPf
 nNWGi425DSZqxc8VDnV5GSVQkC5HefCPkjZUW0n3eykildpHR6es6OqAz54ja+MDwUUcfC3YqXc
 D8C/RYaCUzxG7wFa8VaPQHwcw6RE9qMnuRtosZSj0KZ7z1lTBYCz2931bRc3uTOPCAF8a9DEsWh
 Z7dVopPo/6IBTodckOvq/242ch8plICFqlHQV7SSU5H10LsIq+qy1trrPYTrdb1NL5qcLjeRIwa
 iw5BK9nJJPZtw/xgYmHAG/b+LgPGZqDTHW+2wY7qZZ2zI1K9/aTckIOQSf3gei9NUgmKpAo
X-Received: by 2002:a05:6871:88d:b0:430:1342:142d with SMTP id
 586e51a60fabf-433f3a6058bmr1539741fac.25.1777385076766; 
 Tue, 28 Apr 2026 07:04:36 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-433efed4851sm1824634fac.11.2026.04.28.07.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 07:04:35 -0700 (PDT)
Date: Tue, 28 Apr 2026 08:04:33 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymondmaoca@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Christian =?iso-8859-1?Q?P=F6tzsch?= <christian.poetzsch@kernkonzept.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20260428140433.GQ41863@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FAaPXhXatYrCZpH5"
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
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


--FAaPXhXatYrCZpH5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's the latest report.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Mon, Apr 27, 2026, 5:41=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to *Das U-Boot*
found with Coverity Scan.

   - *New Defects Found:* 9
   - 77 defect(s), reported by Coverity Scan earlier, were marked fixed in
   the recent build analyzed by Coverity Scan.
   - *Defects Shown:* Showing 9 of 9 defect(s)

Defect Details


** CID 645841:       Incorrect expression  (BAD_COMPARE)
/common/bloblist.c: 303           in bloblist_apply_blobs()


___________________________________________________________________________=
__________________
*** CID 645841:         Incorrect expression  (BAD_COMPARE)
/common/bloblist.c: 303             in bloblist_apply_blobs()
297     				log_err("Failed to apply blob with tag %d\n",
298     					tag);
299     				return ret;
300     			}
301
302     			rec =3D rec_from_blob(blob - dat_off);
>>>     CID 645841:         Incorrect expression  (BAD_COMPARE)
>>>     Comparing pointer "rec" against "NULL" using anything besides "=3D=
=3D" or "!=3D" is likely to be incorrect.
303     			if (rec <=3D 0) {
304     				log_err("Blob corrupted\n");
305     				return -ENOENT;
306     			}
307
308     			/* Mark applied blob record as void */

** CID 645840:       Uninitialized variables  (UNINIT)


___________________________________________________________________________=
__________________
*** CID 645840:         Uninitialized variables  (UNINIT)
/lib/efi_loader/efi_device_path.c: 967             in efi_dp_from_http()
961     	if ((server && strlen("http://") + strlen(server) + 1  >
sizeof(tmp)) ||
962     	    (!server && IS_ENABLED(CONFIG_NET_LWIP)))
963     		return NULL;
964
965     	efi_net_get_addr(&ip, &mask, NULL, dev);
966
>>>     CID 645840:         Uninitialized variables  (UNINIT)
>>>     Using uninitialized value "ip" when calling "efi_dp_from_ipv4".
967     	dp1 =3D efi_dp_from_ipv4(&ip, &mask, NULL, dev);
968     	if (!dp1)
969     		return NULL;
970
971
972     	strcpy(tmp, "http://");

** CID 645839:       Error handling issues  (CHECKED_RETURN)
/lib/fdtdec.c: 1785           in fdtdec_apply_bloblist_dtos()


___________________________________________________________________________=
__________________
*** CID 645839:         Error handling issues  (CHECKED_RETURN)
/lib/fdtdec.c: 1785             in fdtdec_apply_bloblist_dtos()
1779
1780     	ret =3D bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
fdtdec_apply_dto_blob);
1781     	if (ret)
1782     		return ret;
1783
1784     	/* Shink the blob to the actual FDT size */
>>>     CID 645839:         Error handling issues  (CHECKED_RETURN)
>>>     Calling "fdt_pack" without checking return value (as is done elsewh=
ere 5 out of 6 times).
1785     	fdt_pack(live_fdt);
1786     	return bloblist_resize(BLOBLISTT_CONTROL_FDT,
fdt_totalsize(live_fdt));
1787     }
1788
1789     int fdtdec_setup(void)
1790     {

** CID 645838:       Uninitialized variables  (UNINIT)


___________________________________________________________________________=
__________________
*** CID 645838:         Uninitialized variables  (UNINIT)
/lib/efi_loader/efi_device_path.c: 967             in efi_dp_from_http()
961     	if ((server && strlen("http://") + strlen(server) + 1  >
sizeof(tmp)) ||
962     	    (!server && IS_ENABLED(CONFIG_NET_LWIP)))
963     		return NULL;
964
965     	efi_net_get_addr(&ip, &mask, NULL, dev);
966
>>>     CID 645838:         Uninitialized variables  (UNINIT)
>>>     Using uninitialized value "mask" when calling "efi_dp_from_ipv4".
967     	dp1 =3D efi_dp_from_ipv4(&ip, &mask, NULL, dev);
968     	if (!dp1)
969     		return NULL;
970
971
972     	strcpy(tmp, "http://");

** CID 645837:         (TAINTED_SCALAR)


___________________________________________________________________________=
__________________
*** CID 645837:           (TAINTED_SCALAR)
/lib/fdtdec.c: 1775             in fdtdec_apply_bloblist_dtos()
1769     	/* Resize if the current space is not sufficient */
1770     	if (blob_size < padded_size) {
1771     		ret =3D bloblist_resize(BLOBLISTT_CONTROL_FDT, padded_size);
1772     		if (ret)
1773     			return ret;
1774
>>>     CID 645837:           (TAINTED_SCALAR)
>>>     Passing tainted expression "live_fdt->size_dt_struct" to "fdt_open_=
into", which uses it as an offset.
1775     		ret =3D fdt_open_into(live_fdt, live_fdt, padded_size);
1776     		if (ret)
1777     			return ret;
1778     	}
1779
1780     	ret =3D bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
fdtdec_apply_dto_blob);
/lib/fdtdec.c: 1785             in fdtdec_apply_bloblist_dtos()
1779
1780     	ret =3D bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
fdtdec_apply_dto_blob);
1781     	if (ret)
1782     		return ret;
1783
1784     	/* Shink the blob to the actual FDT size */
>>>     CID 645837:           (TAINTED_SCALAR)
>>>     Passing tainted expression "live_fdt->size_dt_struct" to "fdt_pack"=
, which uses it as an offset.
1785     	fdt_pack(live_fdt);
1786     	return bloblist_resize(BLOBLISTT_CONTROL_FDT,
fdt_totalsize(live_fdt));
1787     }
1788
1789     int fdtdec_setup(void)
1790     {
/lib/fdtdec.c: 1775             in fdtdec_apply_bloblist_dtos()
1769     	/* Resize if the current space is not sufficient */
1770     	if (blob_size < padded_size) {
1771     		ret =3D bloblist_resize(BLOBLISTT_CONTROL_FDT, padded_size);
1772     		if (ret)
1773     			return ret;
1774
>>>     CID 645837:           (TAINTED_SCALAR)
>>>     Passing tainted expression "live_fdt->totalsize" to "fdt_open_into"=
, which uses it as an offset.
1775     		ret =3D fdt_open_into(live_fdt, live_fdt, padded_size);
1776     		if (ret)
1777     			return ret;
1778     	}
1779
1780     	ret =3D bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
fdtdec_apply_dto_blob);
/lib/fdtdec.c: 1786             in fdtdec_apply_bloblist_dtos()
1780     	ret =3D bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
fdtdec_apply_dto_blob);
1781     	if (ret)
1782     		return ret;
1783
1784     	/* Shink the blob to the actual FDT size */
1785     	fdt_pack(live_fdt);
>>>     CID 645837:           (TAINTED_SCALAR)
>>>     Passing tainted expression "fdt32_ld(&((struct fdt_header const *)l=
ive_fdt)->totalsize)" to "bloblist_resize", which uses it as an offset.
1786     	return bloblist_resize(BLOBLISTT_CONTROL_FDT,
fdt_totalsize(live_fdt));
1787     }
1788
1789     int fdtdec_setup(void)
1790     {
1791     	int ret =3D -ENOENT;
/lib/fdtdec.c: 1775             in fdtdec_apply_bloblist_dtos()
1769     	/* Resize if the current space is not sufficient */
1770     	if (blob_size < padded_size) {
1771     		ret =3D bloblist_resize(BLOBLISTT_CONTROL_FDT, padded_size);
1772     		if (ret)
1773     			return ret;
1774
>>>     CID 645837:           (TAINTED_SCALAR)
>>>     Passing tainted expression "live_fdt->size_dt_strings" to "fdt_open=
_into", which uses it as an offset.
1775     		ret =3D fdt_open_into(live_fdt, live_fdt, padded_size);
1776     		if (ret)
1777     			return ret;
1778     	}
1779
1780     	ret =3D bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
fdtdec_apply_dto_blob);
/lib/fdtdec.c: 1785             in fdtdec_apply_bloblist_dtos()
1779
1780     	ret =3D bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
fdtdec_apply_dto_blob);
1781     	if (ret)
1782     		return ret;
1783
1784     	/* Shink the blob to the actual FDT size */
>>>     CID 645837:           (TAINTED_SCALAR)
>>>     Passing tainted expression "live_fdt->size_dt_struct" to "fdt_pack"=
, which uses it as an offset.
1785     	fdt_pack(live_fdt);
1786     	return bloblist_resize(BLOBLISTT_CONTROL_FDT,
fdt_totalsize(live_fdt));
1787     }
1788
1789     int fdtdec_setup(void)
1790     {
/lib/fdtdec.c: 1786             in fdtdec_apply_bloblist_dtos()
1780     	ret =3D bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
fdtdec_apply_dto_blob);
1781     	if (ret)
1782     		return ret;
1783
1784     	/* Shink the blob to the actual FDT size */
1785     	fdt_pack(live_fdt);
>>>     CID 645837:           (TAINTED_SCALAR)
>>>     Passing tainted expression "fdt32_ld(&((struct fdt_header const *)l=
ive_fdt)->totalsize)" to "bloblist_resize", which uses it as an offset.
1786     	return bloblist_resize(BLOBLISTT_CONTROL_FDT,
fdt_totalsize(live_fdt));
1787     }
1788
1789     int fdtdec_setup(void)
1790     {
1791     	int ret =3D -ENOENT;
/lib/fdtdec.c: 1785             in fdtdec_apply_bloblist_dtos()
1779
1780     	ret =3D bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
fdtdec_apply_dto_blob);
1781     	if (ret)
1782     		return ret;
1783
1784     	/* Shink the blob to the actual FDT size */
>>>     CID 645837:           (TAINTED_SCALAR)
>>>     Passing tainted expression "live_fdt->size_dt_strings" to "fdt_pack=
", which uses it as an offset.
1785     	fdt_pack(live_fdt);
1786     	return bloblist_resize(BLOBLISTT_CONTROL_FDT,
fdt_totalsize(live_fdt));
1787     }
1788
1789     int fdtdec_setup(void)
1790     {
/lib/fdtdec.c: 1786             in fdtdec_apply_bloblist_dtos()
1780     	ret =3D bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
fdtdec_apply_dto_blob);
1781     	if (ret)
1782     		return ret;
1783
1784     	/* Shink the blob to the actual FDT size */
1785     	fdt_pack(live_fdt);
>>>     CID 645837:           (TAINTED_SCALAR)
>>>     Passing tainted expression "fdt32_ld(&((struct fdt_header const *)l=
ive_fdt)->totalsize)" to "bloblist_resize", which uses it as an offset.
1786     	return bloblist_resize(BLOBLISTT_CONTROL_FDT,
fdt_totalsize(live_fdt));
1787     }
1788
1789     int fdtdec_setup(void)
1790     {
1791     	int ret =3D -ENOENT;
/lib/fdtdec.c: 1786             in fdtdec_apply_bloblist_dtos()
1780     	ret =3D bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
fdtdec_apply_dto_blob);
1781     	if (ret)
1782     		return ret;
1783
1784     	/* Shink the blob to the actual FDT size */
1785     	fdt_pack(live_fdt);
>>>     CID 645837:           (TAINTED_SCALAR)
>>>     Passing tainted expression "fdt32_ld(&((struct fdt_header const *)l=
ive_fdt)->totalsize)" to "bloblist_resize", which uses it as an offset.
1786     	return bloblist_resize(BLOBLISTT_CONTROL_FDT,
fdt_totalsize(live_fdt));
1787     }
1788
1789     int fdtdec_setup(void)
1790     {
1791     	int ret =3D -ENOENT;
/lib/fdtdec.c: 1786             in fdtdec_apply_bloblist_dtos()
1780     	ret =3D bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
fdtdec_apply_dto_blob);
1781     	if (ret)
1782     		return ret;
1783
1784     	/* Shink the blob to the actual FDT size */
1785     	fdt_pack(live_fdt);
>>>     CID 645837:           (TAINTED_SCALAR)
>>>     Passing tainted expression "fdt32_ld(&((struct fdt_header const *)l=
ive_fdt)->totalsize)" to "bloblist_resize", which uses it as an offset.
1786     	return bloblist_resize(BLOBLISTT_CONTROL_FDT,
fdt_totalsize(live_fdt));
1787     }
1788
1789     int fdtdec_setup(void)
1790     {
1791     	int ret =3D -ENOENT;
/lib/fdtdec.c: 1785             in fdtdec_apply_bloblist_dtos()
1779
1780     	ret =3D bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
fdtdec_apply_dto_blob);
1781     	if (ret)
1782     		return ret;
1783
1784     	/* Shink the blob to the actual FDT size */
>>>     CID 645837:           (TAINTED_SCALAR)
>>>     Passing tainted expression "live_fdt->size_dt_struct" to "fdt_pack"=
, which uses it as an offset.
1785     	fdt_pack(live_fdt);
1786     	return bloblist_resize(BLOBLISTT_CONTROL_FDT,
fdt_totalsize(live_fdt));
1787     }
1788
1789     int fdtdec_setup(void)
1790     {
/lib/fdtdec.c: 1785             in fdtdec_apply_bloblist_dtos()
1779
1780     	ret =3D bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
fdtdec_apply_dto_blob);
1781     	if (ret)
1782     		return ret;
1783
1784     	/* Shink the blob to the actual FDT size */
>>>     CID 645837:           (TAINTED_SCALAR)
>>>     Passing tainted expression "live_fdt->size_dt_strings" to "fdt_pack=
", which uses it as an offset.
1785     	fdt_pack(live_fdt);
1786     	return bloblist_resize(BLOBLISTT_CONTROL_FDT,
fdt_totalsize(live_fdt));
1787     }
1788
1789     int fdtdec_setup(void)
1790     {
/lib/fdtdec.c: 1786             in fdtdec_apply_bloblist_dtos()
1780     	ret =3D bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
fdtdec_apply_dto_blob);
1781     	if (ret)
1782     		return ret;
1783
1784     	/* Shink the blob to the actual FDT size */
1785     	fdt_pack(live_fdt);
>>>     CID 645837:           (TAINTED_SCALAR)
>>>     Passing tainted expression "fdt32_ld(&((struct fdt_header const *)l=
ive_fdt)->totalsize)" to "bloblist_resize", which uses it as an offset.
1786     	return bloblist_resize(BLOBLISTT_CONTROL_FDT,
fdt_totalsize(live_fdt));
1787     }
1788
1789     int fdtdec_setup(void)
1790     {
1791     	int ret =3D -ENOENT;

** CID 645836:       Resource leaks  (RESOURCE_LEAK)
/drivers/gpio/gpio_scmi.c: 201           in scmi_gpio_probe()


___________________________________________________________________________=
__________________
*** CID 645836:         Resource leaks  (RESOURCE_LEAK)
/drivers/gpio/gpio_scmi.c: 201             in scmi_gpio_probe()
195     			return -ENOMEM;
196
197     		range->base =3D args.args[0];
198     		if (range->base !=3D priv->num_pins) {
199     			dev_err(dev, "no gaps allowed in between pins %d vs %d\n",
200     				priv->num_pins, range->base);
>>>     CID 645836:         Resource leaks  (RESOURCE_LEAK)
>>>     Variable "range" going out of scope leaks the storage it points to.
201     			return -EINVAL;
202     		}
203     		range->offset =3D args.args[1];
204     		range->npins =3D args.args[2];
205     		priv->num_pins +=3D args.args[2];
206     		list_add_tail(&range->list, &priv->gpio_ranges);

** CID 645835:       Memory - corruptions  (OVERRUN)
/lib/gunzip.c: 248           in gzwrite()


___________________________________________________________________________=
__________________
*** CID 645835:         Memory - corruptions  (OVERRUN)
/lib/gunzip.c: 248             in gzwrite()
242     				s.avail_out =3D szwritebuf - numfilled;
243     				s.next_out =3D writebuf + numfilled;
244     			} else {
245     				s.avail_out =3D szwritebuf;
246     				s.next_out =3D writebuf;
247     			}
>>>     CID 645835:         Memory - corruptions  (OVERRUN)
>>>     Calling "inflate" with "s.next_in" and "s.avail_in" is suspicious b=
ecause of the very large index, 4294966272. The index may be due to a negat=
ive parameter being interpreted as unsigned. [Note: The source code impleme=
ntation of the function has been overridden by a builtin model.]
248     			r =3D inflate(&s, Z_SYNC_FLUSH);
249     			if ((r !=3D Z_OK) &&
250     			    (r !=3D Z_STREAM_END)) {
251     				printf("Error: inflate() returned %d\n", r);
252     				goto out;
253     			}

** CID 645834:       Control flow issues  (NO_EFFECT)
/drivers/virtio/virtio_blk.c: 184           in virtio_blk_do_req()


___________________________________________________________________________=
__________________
*** CID 645834:         Control flow issues  (NO_EFFECT)
/drivers/virtio/virtio_blk.c: 184             in virtio_blk_do_req()
178     	*/
179     	while (i < blkcnt) {
180     		u32 blk_per_sg =3D min(blkcnt - i, seg_sec_cnt * priv->seg_max);
181
182     		ret =3D virtio_blk_do_single_req(dev, sector + i, blk_per_sg,
183     					       buffer + i * 512, type);
>>>     CID 645834:         Control flow issues  (NO_EFFECT)
>>>     This less-than-zero comparison of an unsigned value is never true. =
"ret < 0UL".
184     		if (ret < 0)
185     			return ret;
186     		i +=3D blk_per_sg;
187     	}
188
189     	return blkcnt >> priv->blksz_shift;

** CID 645833:       Control flow issues  (DEADCODE)
/drivers/virtio/virtio_blk.c: 185           in virtio_blk_do_req()


___________________________________________________________________________=
__________________
*** CID 645833:         Control flow issues  (DEADCODE)
/drivers/virtio/virtio_blk.c: 185             in virtio_blk_do_req()
179     	while (i < blkcnt) {
180     		u32 blk_per_sg =3D min(blkcnt - i, seg_sec_cnt * priv->seg_max);
181
182     		ret =3D virtio_blk_do_single_req(dev, sector + i, blk_per_sg,
183     					       buffer + i * 512, type);
184     		if (ret < 0)
>>>     CID 645833:         Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "return ret;".
185     			return ret;
186     		i +=3D blk_per_sg;
187     	}
188
189     	return blkcnt >> priv->blksz_shift;
190     }



View Defects in Coverity Scan
<https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>

Best regards,

The Coverity Scan Admin Team

----- End forwarded message -----

--=20
Tom

--FAaPXhXatYrCZpH5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCafC+bQAKCRAr4qD1Cr/k
Cru/AP9dHblzYwMc9Mu0BFLinI2qthdlEtVdjnPR+lIbXLPLPAEA6mEL/mjzTWVk
FvkcuZEtEtmQFeKMA0A+BbxXWL6FEwc=
=ayda
-----END PGP SIGNATURE-----

--FAaPXhXatYrCZpH5--
