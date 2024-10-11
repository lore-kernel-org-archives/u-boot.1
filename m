Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA83DD0EE3F
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 22:02:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3519E893E8;
	Sat, 12 Oct 2024 00:02:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="HWsguge1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3AEB893EB; Sat, 12 Oct 2024 00:02:05 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B036D893E4
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 00:02:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1728684117; x=1729288917; i=xypron.glpk@gmx.de;
 bh=dn25WLxeiXDVlV69TDTdxh6xUKEVztOlKLFVZgHS2Xs=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=HWsguge1gqloDGJegpK7KUSSaSdIi1vJgfCHG02YACi/+/vTZsfQlbTAB/PTadDQ
 m3CtoQX5gbpDFrdOJL+KmXEwxJgO91SYwXYn6wFwygZAcU43jxJanbs6Yr+nH1Xm4
 1Dm3eDzZdf15SzUGDRCLSEO8un5rWHropQQ0Q09UE1RAWpwHAv98IwvD+BROib1Qc
 vi42KTaJQqiz9WcF4t6ANDGHkC6M+edY5PbyJrx4sn6DDzAqjhCBv9q+t3WoP9riC
 TRkT7N5NJSaht+FTTbEGtamnxinl3iJNVxL8ulgRBg/VU1abwzVlkQawDgjjTkrY9
 F8TyQjBPhkh44RjLKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.104.96]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mr9Fs-1tnHSE3Kti-00j6NH; Sat, 12
 Oct 2024 00:01:57 +0200
Date: Sat, 12 Oct 2024 00:01:54 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: Re: [PATCH v4 4/5] efi: Reserve some memory for initial use
User-Agent: K-9 Mail for Android
In-Reply-To: <20241011212126.747741-5-sjg@chromium.org>
References: <20241011212126.747741-1-sjg@chromium.org>
 <20241011212126.747741-5-sjg@chromium.org>
Message-ID: <71ECC011-77EC-4308-AFE5-0E301BC27F84@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W58Ds9hZlsbS2/jK+IYkHROtx3hKt156jZH5UQu9acWXXJoI9cV
 5DmMVLUquTJL6LLhvaJcAyP000kOYEn0bnpJZetzTcN+E1LwwMlIrFIRbGmKqzIFyNlZZ4T
 4vG59uTu5wbP75avGEYqOA2oPSRTG5XSS6c6vfg4BctRoOTvCuQ1isUMXf/XtSP7B6M4dp5
 OCFitP8nBzOI99TATl5JQ==
UI-OutboundReport: notjunk:1;M01:P0:i/RRv2+ndj4=;uD+bSIuENQZdQlPcI53RNhB146f
 phzY0S6yxFk6A26Eji0MvJYSog4Z3B5GbfyDtAhgSXIDV4EfPWTxmEmtzYPn8CCs9+5yXOCHE
 Vqj+Z2hiaFoUplyLScfPa4DUKLUpcgE2VuPmwmSxmfF5a2ENLeMLatG7C99vosjzFWAdnVax2
 1s0MMfXVCGCAxWvk79YBdcuKSVKJ/dfGZ/mRQp8h7Dh9nVlZHVuPl2s1utgl53OBq8Kp2yTsD
 tJ6MIcV5BMg9hh2C1ouhFUCl4PYbddxQI1RRnfEA2F7cHuMCksreb69qOtBxdXVMqcvXJzrLC
 edkB9No+mQeVZIDQ0rUgi6YMh7zzMmqdMFaDRaSiOUo49UZ3LlBmp+8dUyhM/lgKKjfsU+Vfr
 eTXWahmKhZc0Z1UPTRrRUOqAtqrE1z1yGJICmLCkt7/pHwkpFswZBtf5TfK01SqC0poglG0Kd
 98WPzVlXKwA2JC7hNXHfq8fPBFq6MuDrCMnyOpmyg5F+hFiCLI6qDx2r5VXuZhPR/rOGa4nmL
 UeX5JxdxF/KMNOhjUv8gyQdhblpzvP31UY2ZD1wINi24FnaCkmPw8KNAaqMZtn3Ze6DuPk5Gy
 GaELTk8f/Y9nqQm/1j0Ma2xJaBqcSTr6G8YL0KpcGptd3y0jgf5Me8kXATn+lOxWKWEpEJPty
 oAupdGDG43gM9vAyspDQs3usodm1LbOn7yv5C4Ylg8F7ZwoPieDdFYetVHUIaEp0xQ17NmtMZ
 LPhvdRUe8OuzGy8f05jx4soq9Ewgwnj/0Yn3ws00qFrcDhVrsNdYh70ecKr53pA4DoxzSY+pr
 nWpPjNsmoZuipmrDQrAtIaaA==
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



Am 11=2E Oktober 2024 23:21:25 MESZ schrieb Simon Glass <sjg@chromium=2Eor=
g>:
>The 'point of cooperation' is where U-Boot starts allowing EFI to use
>memory outside of the U-Boot region=2E Until that point, it is desirable
>to keep more below U-Boot free for loading images=2E
>
>Reserve a small region for this purpose=2E

Your commit message provides no clue why this should be needed=2E

If we ensure thst LMB is up before EFI initialization, the EFI subsystem w=
ill be able to allocate memory from there=2E

Best regards

Heinrich


>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>---
>
>(no changes since v1)
>
> include/asm-generic/global_data=2Eh |  6 ++++++
> lib/efi_loader/efi_memory=2Ec       | 21 +++++++++++++++++++++
> test/py/tests/test_event_dump=2Epy  |  1 +
> 3 files changed, 28 insertions(+)
>
>diff --git a/include/asm-generic/global_data=2Eh b/include/asm-generic/gl=
obal_data=2Eh
>index d6c15e2c406=2E=2E20705be14dd 100644
>--- a/include/asm-generic/global_data=2Eh
>+++ b/include/asm-generic/global_data=2Eh
>@@ -443,6 +443,12 @@ struct global_data {
> 	 */
> 	struct upl *upl;
> #endif
>+#if CONFIG_IS_ENABLED(EFI_LOADER)
>+	/**
>+	 * @efi_region: Start of EFI's early-memory region
>+	 */
>+	ulong efi_region;
>+#endif
> };
> #ifndef DO_DEPS_ONLY
> static_assert(sizeof(struct global_data) =3D=3D GD_SIZE);
>diff --git a/lib/efi_loader/efi_memory=2Ec b/lib/efi_loader/efi_memory=2E=
c
>index 50cb2f3898b=2E=2E9cc33397371 100644
>--- a/lib/efi_loader/efi_memory=2Ec
>+++ b/lib/efi_loader/efi_memory=2Ec
>@@ -24,6 +24,12 @@ DECLARE_GLOBAL_DATA_PTR;
> /* Magic number identifying memory allocated from pool */
> #define EFI_ALLOC_POOL_MAGIC 0x1fe67ddf6491caa2
>=20
>+/*
>+ * Amount of memory to reserve for EFI before relocation=2E This must be=
 a
>+ * multiple of EFI_PAGE_SIZE
>+ */
>+#define EFI_EARLY_REGION_SIZE	SZ_256K
>+
> efi_uintn_t efi_memory_map_key;
>=20
> struct efi_mem_list {
>@@ -944,3 +950,18 @@ int efi_memory_init(void)
>=20
> 	return 0;
> }
>+
>+static int reserve_efi_region(void)
>+{
>+	/*
>+	 * Reserve some memory for EFI=2E Since pool allocations consume 4KB ea=
ch
>+	 * and there are three allocations, allow 16KB of memory, enough for
>+	 * four=2E This can be increased as needed=2E
>+	 */
>+	gd->efi_region =3D ALIGN_DOWN(gd->start_addr_sp - EFI_EARLY_REGION_SIZE=
,
>+				    SZ_4K);
>+	gd->start_addr_sp =3D gd->efi_region;
>+
>+	return 0;
>+}
>+EVENT_SPY_SIMPLE(EVT_RESERVE, reserve_efi_region);
>diff --git a/test/py/tests/test_event_dump=2Epy b/test/py/tests/test_even=
t_dump=2Epy
>index e282c67335c=2E=2Ee36fc6a1586 100644
>--- a/test/py/tests/test_event_dump=2Epy
>+++ b/test/py/tests/test_event_dump=2Epy
>@@ -20,5 +20,6 @@ EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           =
=2E*boot/vbe_request=2Ec:=2E*
> EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    =2E*boot/vbe_simpl=
e_os=2Ec:=2E*
> EVT_LAST_STAGE_INIT   install_smbios_table            =2E*lib/efi_loader=
/efi_smbios=2Ec:=2E*
> EVT_MISC_INIT_F       sandbox_early_getopt_check      =2E*arch/sandbox/c=
pu/start=2Ec:=2E*
>+EVT_RESERVE           reserve_efi_region              =2E*lib/efi_loader=
/efi_memory=2Ec:=2E*
> EVT_TEST              h_adder_simple                  =2E*test/common/ev=
ent=2Ec:'''
>     assert re=2Ematch(expect, out, re=2EMULTILINE) is not None
