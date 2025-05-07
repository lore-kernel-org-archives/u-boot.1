Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55923C3ABBF
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 15:09:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCF1181F32;
	Wed,  7 May 2025 17:09:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="gSwGpDH+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A31082153; Wed,  7 May 2025 17:09:45 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 677D68059D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 17:09:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1746630580; x=1747235380; i=xypron.glpk@gmx.de;
 bh=Gs6j11nDJx25BAUdr3L6l3DARuswbBwMVI9sUzaQ2yE=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=gSwGpDH+VknKqr2Z0tKEfjLZ7jUb9tEI1kT4aC7F/XU0GSgN/z3Wa/yX5QTPdW2R
 TScO/51nXIx7OVnHEYs7PMCJdSbPtwpLvJSaODZFBBy8skuYtEttkdUT0a/q8cHYc
 WmIKiLz6Dj7QtCO/gC4pBMxMxf/aGBSk+Nhaym3TpXyh6mk8zvUuaIjYi+GenI4W9
 S2ykX7zHGpD6HKJ+I+x4BzkjMEHaCrh8VmreB+zkNcBgPyEWb5ffnJ2KH2y9OGfPV
 3gDLkztNp3atdHtkQDOXhfsh+vtLyBII38Z36S6HLuvonfBQ0iqOvfDUUVz81dnwZ
 4faHnXo72YtU5cQEtg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([213.157.19.150]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mplbx-1uozgP1Alx-00jFSR; Wed, 07
 May 2025 17:09:40 +0200
Date: Wed, 07 May 2025 17:09:39 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
CC: ilias.apalodimas@linaro.org, sjg@chromium.org, trini@konsulko.com,
 o451686892@gmail.com, Adriano Cordova <adriano.cordova@canonical.com>
Subject: Re: [PATCH 3/3] test/py/test_efi_fit: test fdt and initrd
User-Agent: Thunderbird for Android
In-Reply-To: <20250507144619.3288456-4-adriano.cordova@canonical.com>
References: <20250507144619.3288456-1-adriano.cordova@canonical.com>
 <20250507144619.3288456-4-adriano.cordova@canonical.com>
Message-ID: <417600CE-CA2D-4E62-BA3A-4AC230C39A56@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JgztA3dgHrXtUrr6I9CzQWmwA4Z7r4txBj+59vhBL9QtUgYYppv
 0hBBU5miYElBcjjLptwfqkZ6mThHNHzPLq3cOJiLSSYGTEDGSaZ2UbQvGKlxouNLCNjPbB8
 OzZYScoQ76QQjVh2RKLCmThSqyqTbkviiHIls7aW0ZDRxMLqUeBJd9sOR4LY1XDEWzb8tqS
 G+9SqdXunBn1EtXu0XPhg==
UI-OutboundReport: notjunk:1;M01:P0:4TqkAv1jXQo=;7FxSsYpXEdpU/Vdp3hCdB+lXlD+
 R+KgDZrqPHtD5C1JvPVypu4z/kvJqDpmzo9B+rYvlctt9daMcdIKMv3wmIHeT0NU3j2scZ/9E
 FoTrQ4Hbh4Cif93eQRVor6jHdOjN2pVzBn8EeA8D1D0broKtnOt9Zb/uG+od5gQcIocVXxTyG
 gyanSSNz1pIgeBc7lIII0CKW0hnh7OMm35HvaM7bH3KXNH3GH3tM17SQnfd/i/pA/CfDQ8x9o
 RghWz0Lel26wpykDB4ozJqLzc0v1G44hevHfOWTwviX6P3CiogW0hnUp8GqcGTpguUbgxT6vE
 tBMkM2C6V6cjCHAXQo92JwSkmSvVse8/F4H8BHVxv8YhOtUzmwxFyb+Pc5V8M4g9E3qKNOH1p
 ThtKR7iAg6t8GVem8iFZRrVChsK6mH2h203ktrxOMwjWGe5nWzjdiEpVWQMhh6W9plVINrbOM
 HCbtJjWerojUZrOTBZot8bPc5b1jacMMegd0KsqPsjV7l0nusgb1UkVH4xIX6TLUa6WDi1tBk
 fT0vBI2Fx57X4Q6HZN3gYOA7SOqBmiQjHcGZt5BwAwJVvtpzrJXBmAztuhnhJ6Xv4Vhqpwg8s
 cK7tQGRTfKQPj7ohAJx+PFmGkfSee3ndpMLgXVhfxSK8peLsyos2i4b6B/7xO4bpnO6XcOICy
 IBGTgVS3G1pIxTddnhyr90vMzjleBd4OB5kMTBJTeJ+OXUt9rFBbNd3hZdbHo3HcpCHc7EMgS
 4FRCaOFKFhyNVUcSt4e54p+dQzLXX2Ut1u60yC7P4EEKappI7eH0HI+jmYz4bJRvWa9qycu+P
 3geiJjJi3fTdG0oeSen8mnktrH8iNuZkXHJtlDIAI4EDtWC5qrZqAsRV19IUfo+rRje7crGCp
 rrAOqaeRCE+TysWziyKQpMBobdOT3juBJvMD8Sg2Zytg2bHE9GlJYHmRkgRIa/Cbn41wga8Y3
 WNn5NKrjtXQCwGyNeP/SFx58GU0cnvRofRdUzS/y54vChVRSVszn4SExaJDP6lEmdzIQXVO9v
 f7sJvrUEfko2iIezwxzwzIzbYouYQVwY2atUQr11mF2eUKky3gQcontDNe7cbY3WXo5mQspz2
 SnZiu+7TohIpDhMVgtC1Azw9HBVa5SbjVRectIhZDnlv1gvO78XMyx9B3e84/9CfuQJkPFpoi
 0FV7+qdBaWL9IuSD2bZ1GLHa5/bH7YI9iJIvxqmlL4OfoQwIFmMRMkh3Fw+3FMY8nNCOdxRSa
 8Js4Q3qQ1UqoGegELbzke7ivjTStsHSqaqr5r1b3q6YYEUNpCj4tryu5phyvAsNQV1VCjZJUn
 UA3gG3NJ+j2AABYREoJdcFtFdgG4wxr95m92YB2SmHPPzWKEpoF8zc0C3sTFbQYkZUmqkuhGP
 7JMgplknVAckHsVeiYboDrYzo41a02bZdVaKAaacU134aY9N4n7Ra8X5xAXH7PTucc3hn1l8n
 Inu2DO72du1yF0fVsLyPO3DW8YHFoD31yGK5Bx28LLA0NTcve1eyiJW25uRR+VDkFiJ8tIKGN
 Vxq4rRCkvN8YJ2vzSruwiQHMcmjiH3sjQU9MrcQVGLdk7xXLNTQPmxTu+uknKsm4bG0tQ2SnA
 Jw3DuDKKwKgXYtH0L35NPz3QnqVpxtyABQ4fS0drqeU+ar+iw5OPxHS3tcEezZP/BKKjQ97it
 i8wUMVxCgrxs0X66jJCMvWGRXY+QAPKgCoNIUzJ/ovd6Y8Kf5BusPlKF9QQGnVehfGlhn4pa1
 +XfHCSCvJrbI1QloYKz7UCnvZYpUXY96Y65pkXDF+lqgOW7rzHrKLDxmbT1fnIRSx7/LzK4pu
 YixPVyLVaRNYVPihqTmg+CifyudVOoRsNzh7GxNXHDT/3cT/9zkCds2zVlm5v8jFEDAn6Ipqw
 KwtjM5F61ApTKAwfXz+rgpfeaiPlOCTxgdllMEvo/ulKj6e7Nyawo7wvYk7LVl/jL1EvQzTNV
 zc/8zk2jYsapT2wMFNkkfnxVJ+MOyjWmymx8zSTBwCNfpX/v++gdXRKhIyx7aR6ailiZ1L/Il
 8gDbKKJC7hkGICB/yW/oMJLflmAdicTdgM55AkUgYm2UxX5886GJc5cENs5yonOl+WNb1jUYP
 pcwQl6678EKenEeguJ13aGz13Dm1zK81xRy4dNzqlsHLFLwvUsbu/X+4Y4canhqCL6W8hUh7g
 knzFIQis794dUAYJ7NmRrIFUhdGFuw9HVQMl1P8HkoOxWSfwSeSjQhqONmirhF94rqhbzSPPW
 6SuSL61YlxyLTavk0KHs5Add6XLF7Zq7PHr2sJwof1VAclFFFXjkgux3Ouf1JUeeX41z0Un8D
 BVDtVCeIEgd5OODwRPC6NPWWsgKQGPrtThLjKz+QbE6pYRPdHcQjvQO3qfMq/uNgSCCWc6Pja
 2yD+EwYfO96GeSCDh/yBVwwLNpNAhdsYEnvwjAV+7OMxvLsshJONWRkuqQtlGTICz1PFpJkH4
 qpfgCN3GLrdUXfuPL7vj/1hUVKJ7CgvxN9DSMlb69RTm0LoxHmPKhrBgp1PjlOTxZuvCOuDDi
 Z2t55S7irlp/Tm1BQ+dyjivbxv/pY0JJM9w8P/Trzd5Y+ia+I0e3I9+EdZQKAW2RKEs/xrIvq
 xoZvKgTd3QGbTT+NmSQFucyMvw+lQe97BLvsZSc7Mm47va2sz1BE4X05NgaNLmECJj+BOKt6h
 f38AWFAr3tNH+Zslx8yeWIT/g6dNNy3Iw06hu4eqm631zp5nq9jq+5Ng1g95Esrn759XM2+//
 XK+N4YogTdrF3U1Ub2vWtw8wWP0jQ8+F/nlt1fUZ1dB+YX4QqR2hcjdgitKzeVFnrCRUfoBDR
 RCEW9IfYFIMhfUjPdRi75acPES9bJBYeIyv5viGROl8SxxaEi2CLhnR/xgDW1O0djSTCOS5gT
 QE8QQn2JvHjG0N63ewLdsL14TLjtGB3NAI2atCQ1cCsGfejpqOSCn2bqpGVObECgmguY3F2DK
 yk1yamCWI2XvITh8qCd71jJUqfTMVxxX+1YTF01MoL67K3FobQGyqqVOqGNG5XMP7w6NgjXAK
 mE5s1q6AFhN6LO++fCrjQLYiSgrIUhGmHHZA/Zlf7Kr0L0SYoxS3eWpRIDEJmdTFW0ebaYWD6
 7rC0uj7TlvO0fMuqS7m295tsXXCi/nrAz6Uv05Vb9FN6MjnpnjtsMnhfYOxi8oFnUq8jfmv3v
 pj3I=
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

Am 7=2E Mai 2025 16:46:19 MESZ schrieb Adriano Cordova <adrianox@gmail=2Eco=
m>:
>Signed-off-by: Adriano Cordova <adriano=2Ecordova@canonical=2Ecom>


Please, provide a commit message=2E=20


>---
> test/py/tests/test_efi_fit=2Epy | 156 +++++++++++++++++++++++++++-------
> 1 file changed, 124 insertions(+), 32 deletions(-)
>
>diff --git a/test/py/tests/test_efi_fit=2Epy b/test/py/tests/test_efi_fit=
=2Epy
>index 5f352e7efff=2E=2E63ee8e6cef2 100644
>--- a/test/py/tests/test_efi_fit=2Epy
>+++ b/test/py/tests/test_efi_fit=2Epy
>@@ -66,9 +66,29 @@ ITS_DATA =3D '''
>     #address-cells =3D <1>;
>=20
>     images {
>-        efi {
>+        helloworld {
>             description =3D "Test EFI";
>-            data =3D /incbin/("%(efi-bin)s");
>+            data =3D /incbin/("%(hello-bin)s");
>+            type =3D "%(kernel-type)s";
>+            arch =3D "%(sys-arch)s";
>+            os =3D "efi";
>+            compression =3D "%(efi-comp)s";
>+            load =3D <0x0>;
>+            entry =3D <0x0>;
>+        };
>+        dtbdump {
>+            description =3D "Test EFI fdtdump";
>+            data =3D /incbin/("%(dtbdump-bin)s");
>+            type =3D "%(kernel-type)s";
>+            arch =3D "%(sys-arch)s";
>+            os =3D "efi";
>+            compression =3D "%(efi-comp)s";
>+            load =3D <0x0>;
>+            entry =3D <0x0>;
>+        };
>+        initrddump {
>+            description =3D "Test EFI initrddump";
>+            data =3D /incbin/("%(initrddump-bin)s");
>             type =3D "%(kernel-type)s";
>             arch =3D "%(sys-arch)s";
>             os =3D "efi";
>@@ -83,18 +103,33 @@ ITS_DATA =3D '''
>             arch =3D "%(sys-arch)s";
>             compression =3D "%(fdt-comp)s";
>         };
>+        initrd {
>+            description =3D "Initial RAM Disk";
>+            data =3D /incbin/("%(initrd-fs)s");
>+            type =3D "ramdisk";
>+            compression =3D "%(initrd-comp)s";
>+            os =3D "efi";
>+        };
>     };
>=20
>     configurations {
>         default =3D "config-efi-fdt";
>+
>+        config-efi {
>+            description =3D "EFI FIT w/o FDT";
>+            kernel =3D "helloworld";
>+        };
>+
>         config-efi-fdt {
>             description =3D "EFI FIT w/ FDT";
>-            kernel =3D "efi";
>+            kernel =3D "dtbdump";
>             fdt =3D "fdt";
>         };
>-        config-efi-nofdt {
>-            description =3D "EFI FIT w/o FDT";
>-            kernel =3D "efi";
>+
>+        config-efi-initrd {
>+            description =3D "EFI FIT w/ initrd";
>+            kernel =3D "initrddump";
>+            ramdisk =3D "initrd";
>         };
>     };
> };
>@@ -108,7 +143,7 @@ FDT_DATA =3D '''
>     #address-cells =3D <1>;
>     #size-cells =3D <1>;
>=20
>-    model =3D "%(sys-arch)s %(fdt_type)s EFI FIT Boot Test";
>+    model =3D "%(sys-arch)s %(fdt_type)s EFI FIT FDT Boot Test";
>     compatible =3D "%(sys-arch)s";
>=20
>     reset@0 {
>@@ -120,6 +155,7 @@ FDT_DATA =3D '''
>=20
> @pytest=2Emark=2Ebuildconfigspec('bootm_efi')
> @pytest=2Emark=2Ebuildconfigspec('BOOTEFI_HELLO_COMPILE')
>+@pytest=2Emark=2Ebuildconfigspec('EFI_LOAD_FILE2_INITRD')
> @pytest=2Emark=2Ebuildconfigspec('fit')
> @pytest=2Emark=2Enotbuildconfigspec('generate_acpi_table')
> @pytest=2Emark=2Erequiredtool('dtc')
>@@ -137,8 +173,10 @@ def test_efi_fit_launch(ubman):
>     The following test cases are currently defined and enabled:
>      - Launch uncompressed FIT EFI & internal FDT
>      - Launch uncompressed FIT EFI & FIT FDT
>+     - Launch uncompressed FIT EFI & internal FDT & FIT initrd
>      - Launch compressed FIT EFI & internal FDT
>      - Launch compressed FIT EFI & FIT FDT
>+     - Launch compressed FIT EFI & internal FDT & FIT initrd
>     """
>=20
>     def net_pre_commands():
>@@ -210,7 +248,7 @@ def test_efi_fit_launch(ubman):
>=20
>         return os=2Epath=2Ejoin(ubman=2Econfig=2Ebuild_dir, file_name)
>=20
>-    def make_efi(fname, comp):
>+    def make_efi(fname, efi_file, comp):
>         """Create an UEFI binary=2E
>=20
>         This simply copies lib/efi_loader/helloworld=2Eefi into U-Boot
>@@ -218,6 +256,7 @@ def test_efi_fit_launch(ubman):
>=20
>         Args:
>             fname -- The target file name within U-Boot build dir=2E
>+            efi_file -- The source =2Eefi application
>             comp -- Flag to enable gzip compression=2E
>         Return:
>             The path of the created file=2E
>@@ -225,7 +264,7 @@ def test_efi_fit_launch(ubman):
>=20
>         bin_path =3D make_fpath(fname)
>         utils=2Erun_and_log(ubman,
>-                          ['cp', make_fpath('lib/efi_loader/helloworld=
=2Eefi'),
>+                          ['cp', make_fpath(f'lib/efi_loader/{efi_file}'=
),
>                            bin_path])
>         if comp:
>             utils=2Erun_and_log(ubman, ['gzip', '-f', bin_path])
>@@ -264,6 +303,27 @@ def test_efi_fit_launch(ubman):
>             dtb +=3D '=2Egz'
>         return dtb
>=20
>+    def make_initrd(comp):
>+        """Create a sample initrd=2E
>+
>+        Creates an initrd=2E
>+
>+        Args:
>+            comp -- Flag to enable gzip compression=2E
>+        Return:
>+            The path of the created file=2E
>+        """
>+
>+        # Generate a test initrd file=2E
>+        initrd =3D make_fpath('test-efi-initrd')
>+        with open(initrd, 'w', encoding=3D'ascii') as file:
>+            file=2Ewrite('test-efi-initrd')
>+
>+        if comp:
>+            utils=2Erun_and_log(ubman, ['gzip', '-f', initrd])
>+            initrd +=3D '=2Egz'
>+        return initrd
>+
>     def make_fit(comp):
>         """Create a sample FIT image=2E
>=20
>@@ -275,22 +335,35 @@ def test_efi_fit_launch(ubman):
>         """
>=20
>         # Generate resources referenced by ITS=2E
>+        hello_bin =3D os=2Epath=2Ebasename(make_efi('test-efi-helloworld=
=2Eefi', 'helloworld=2Eefi', comp))
>+        dtbdump_bin =3D os=2Epath=2Ebasename(make_efi('test-efi-dtbdump=
=2Eefi', 'dtbdump=2Eefi', comp))
>+        initrddump_bin =3D os=2Epath=2Ebasename(make_efi('test-efi-initr=
ddump=2Eefi', 'initrddump=2Eefi', comp))
>+        fdt_bin =3D os=2Epath=2Ebasename(make_dtb('user', comp))
>+        initrd_fs =3D make_initrd(comp)
>+        initrd_fs =3D os=2Epath=2Ebasename(initrd_fs)
>+        compression =3D 'gzip' if comp else 'none'
>+        kernel_type =3D 'kernel' if comp else 'kernel_noload'
>+
>         its_params =3D {
>             'sys-arch': sys_arch,
>-            'efi-bin': os=2Epath=2Ebasename(make_efi('test-efi-fit-hello=
world=2Eefi', comp)),
>-            'kernel-type': 'kernel' if comp else 'kernel_noload',
>-            'efi-comp': 'gzip' if comp else 'none',
>-            'fdt-bin': os=2Epath=2Ebasename(make_dtb('user', comp)),
>-            'fdt-comp': 'gzip' if comp else 'none',
>+            'hello-bin': hello_bin,
>+            'dtbdump-bin': dtbdump_bin,
>+            'initrddump-bin': initrddump_bin,
>+            'kernel-type': kernel_type,
>+            'efi-comp': compression,
>+            'fdt-bin': fdt_bin,
>+            'fdt-comp': compression,
>+            'initrd-fs': initrd_fs,
>+            'initrd-comp': compression,
>         }
>=20
>         # Generate a test ITS file=2E
>-        its_path =3D make_fpath('test-efi-fit-helloworld=2Eits')
>+        its_path =3D make_fpath('test-efi-fit=2Eits')
>         with open(its_path, 'w', encoding=3D'ascii') as file:
>             file=2Ewrite(ITS_DATA % its_params)
>=20
>         # Build the test ITS=2E
>-        fit_path =3D make_fpath('test-efi-fit-helloworld=2Efit')
>+        fit_path =3D make_fpath('test-efi-fit=2Efit')
>         utils=2Erun_and_log(
>             ubman, [make_fpath('tools/mkimage'), '-f', its_path, fit_pat=
h])
>         return fit_path
>@@ -357,7 +430,7 @@ def test_efi_fit_launch(ubman):
>=20
>         return addr
>=20
>-    def launch_efi(enable_fdt, enable_comp):
>+    def launch_efi(enable_fdt, enable_initrd, enable_comp):
>         """Launch U-Boot's helloworld=2Eefi binary from a FIT image=2E
>=20
>         An external image file can be downloaded from TFTP, when related
>@@ -372,19 +445,20 @@ def test_efi_fit_launch(ubman):
>         from the host filesystem=2E
>=20
>         Once the load address is available on U-Boot console, the 'bootm=
'
>-        command is executed for either 'config-efi-fdt' or 'config-efi-n=
ofdt'
>-        FIT configuration, depending on the value of the 'enable_fdt' fu=
nction
>-        argument=2E
>+        command is executed for either 'config-efi', 'config-efi-fdt' or
>+        'config-efi-initrd' FIT configuration, depending on the value of=
 the
>+        'enable_fdt' and 'enable_initrd' function arguments=2E
>=20
>         Eventually the 'Hello, world' message is expected in the U-Boot =
console=2E
>=20
>         Args:
>             enable_fdt -- Flag to enable using the FDT blob inside FIT i=
mage=2E
>+            enable_initrd -- Flag to enable using an initrd inside FIT i=
mage=2E
>             enable_comp -- Flag to enable GZIP compression on EFI and FD=
T
>                            generated content=2E
>         """
>=20
>-        with ubman=2Elog=2Esection('FDT=3D%s;COMP=3D%s' % (enable_fdt, e=
nable_comp)):
>+        with ubman=2Elog=2Esection('FDT=3D%s;INITRD=3D%s;COMP=3D%s' % (e=
nable_fdt, enable_initrd, enable_comp)):
>             if is_sandbox:
>                 fit =3D {
>                     'dn': ubman=2Econfig=2Ebuild_dir,
>@@ -420,14 +494,28 @@ def test_efi_fit_launch(ubman):
>             addr =3D load_fit_from_host(fit) if is_sandbox else load_fit=
_from_tftp(fit)
>=20
>             # Select boot configuration=2E
>-            fit_config =3D 'config-efi-fdt' if enable_fdt else 'config-e=
fi-nofdt'
>+            fit_config =3D 'config-efi'
>+            fit_config =3D fit_config + '-fdt' if enable_fdt else fit_co=
nfig
>+            fit_config =3D fit_config + '-initrd' if enable_initrd else =
fit_config
>=20
>             # Try booting=2E
>+            ubman=2Erun_command('setenv bootargs nocolor')
>             output =3D ubman=2Erun_command('bootm %x#%s' % (addr, fit_co=
nfig))
>+            assert '## Application failed' not in output
>             if enable_fdt:
>                 assert 'Booting using the fdt blob' in output
>-            assert 'Hello, world' in output
>-            assert '## Application failed' not in output
>+                assert 'DTB Dump' in output
>+            if enable_initrd:
>+                assert 'Loading ramdisk' in output
>+                assert 'INITRD Dump' in output
>+            if enable_fdt:
>+                response =3D ubman=2Erun_command(cmd =3D 'dump', wait_fo=
r_echo=3DFalse)
>+                assert 'EFI FIT FDT Boot Test' in response
>+            if enable_initrd:
>+                response =3D ubman=2Erun_command('load', wait_for_echo=
=3DFalse)
>+                assert f"crc32: 0x0c77b025" in response
>+            if not enable_fdt and not enable_initrd:
>+                    assert 'Hello, world' in output
>             ubman=2Erestart_uboot()
>=20
>     # Array slice removes leading/trailing quotes=2E
>@@ -449,16 +537,20 @@ def test_efi_fit_launch(ubman):
>             ubman=2Econfig=2Edtb =3D control_dtb
>=20
>         # Run tests
>-        # - fdt OFF, gzip OFF
>-        launch_efi(False, False)
>-        # - fdt ON, gzip OFF
>-        launch_efi(True, False)
>+        # - fdt OFF, initrd OFF, gzip OFF
>+        launch_efi(False, False, False)
>+        # - fdt ON, initrd OFF, gzip OFF
>+        launch_efi(True, False, False)
>+        # - fdt OFF, initrd ON, gzip OFF
>+        launch_efi(False, True, False)
>=20
>         if is_sandbox:
>-            # - fdt OFF, gzip ON
>-            launch_efi(False, True)
>-            # - fdt ON, gzip ON
>-            launch_efi(True, True)
>+            # - fdt OFF, initrd OFF, gzip ON
>+            launch_efi(False, False, True)
>+            # - fdt ON, initrd OFF, gzip ON
>+            launch_efi(True, False, True)
>+            # - fdt OFF, initrd ON, gzip ON
>+            launch_efi(False, True, True)
>=20
>     finally:
>         if is_sandbox:

