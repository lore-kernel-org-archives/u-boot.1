Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6B5FC6185
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 01:04:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BB8488C24;
	Sat, 14 Sep 2024 03:04:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="t7aeMpQE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CA2A88706; Fri, 13 Sep 2024 18:04:26 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C582887BB
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 18:04:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6c354091616so17466356d6.0
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 09:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726243462; x=1726848262; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BFmaM+bsdNw5mZ/i3HQXFGqMgdVqrzJFGpkkq69L74A=;
 b=t7aeMpQEluDR8WyMPoljX/7QFDwWoizEVZ2uNTXXo5euSj5chWqqBSZKPre41bKm/2
 jrRAG5Z51VQjldDB4VEAZcG1NlNb7E52nh374IKyO2lvjzDDuGUxaLnD21fR7V2joBjz
 OZMB4peiZcT6vkkY/kEtlpA1itZ1ac7CN6hfXirz3UoYTDb0UtL/q2XZJFoUa0XFf868
 LZPZf2gLKcndrAn4UNFFm8uAVvzgadIrDsuyGrqXeVynJ0YbeIkidzGoNU2CEX2EU6Pl
 9PL8LLLqY1SOIdOokQA+BHeB9n/HfL8sNoyT59g8r39RbTMG9UPPCUuNY4kG/ErhTkeY
 jc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726243462; x=1726848262;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BFmaM+bsdNw5mZ/i3HQXFGqMgdVqrzJFGpkkq69L74A=;
 b=PzQawTLUTK9ZQwTOpzu6Fe4j5LrHfgPYmjk/2sBEqyBQdKSeNgje/b9ctCh8ufvw3V
 4o3YaBfsryoQV4e1SghB7rY/8u74zsbfN2U2vv7U69olYvl3byvSj5TupXdddR3dSBaV
 HgToonNglQF8Yau/Of0KP/JBJ9lbYuewdW/gZFRM2bCKvYbRWOY/7uw4UUshBrbJ5g2c
 gIbKtJfaUm1i/Os/9N8N5fuXskgFcMeAowy8q9uCEBgmUV4ttJh9fAPAvuYX708w5fBu
 QYR/TD4dKzLNPdOJz2YtuQM3eHYDOY8kX13tCgzwivZt7hZGfsytsKVugfLGmSnBW04U
 huNQ==
X-Gm-Message-State: AOJu0YxElvXdCFcX4eAxsIg1LlvG2AnB5D4chsSj4eB8JruT6LpFjcF5
 n/G5zzIobk5BaspusMmD8tJNffL96vNLu1RK9CHfdeI43syid8ThrPhCLe24nfl3ygbPa5vCtms
 j
X-Google-Smtp-Source: AGHT+IF0jMMPgkK3SEPH/jnCGCRQNzuePFJh8npcUY0VEGCo+CpISeYuwRYV+zV3vKk0eDlHP5T0Yw==
X-Received: by 2002:a05:6214:2b8b:b0:6c3:67b3:4c1d with SMTP id
 6a1803df08f44-6c573519b5bmr113505986d6.13.1726243461508; 
 Fri, 13 Sep 2024 09:04:21 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534774908sm67697286d6.118.2024.09.13.09.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 09:04:20 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Andrew Davis <afd@ti.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Jonas Karlman <jonas@kwiboo.se>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v7 00/27] Integrate MbedTLS v3.6 LTS with U-Boot
Date: Fri, 13 Sep 2024 09:03:17 -0700
Message-Id: <20240913160408.2199558-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Sep 2024 03:04:24 +0200
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

Integrate MbedTLS v3.6 LTS (currently v3.6.0) with U-Boot.

Motivations:
------------

1. MbedTLS is well maintained with LTS versions.
2. LWIP is integrated with MbedTLS and easily to enable HTTPS.
3. MbedTLS recently switched license back to GPLv2.

Prerequisite:
-------------

This patch series requires mbedtls git repo to be added as a
subtree to the main U-Boot repo via:
    $ git subtree add --prefix lib/mbedtls/external/mbedtls \
          https://github.com/Mbed-TLS/mbedtls.git \
          v3.6.0 --squash
Moreover, due to the Windows-style files from mbedtls git repo,
we need to convert the CRLF endings to LF and do a commit manually:
    $ git add --renormalize .
    $ git commit

New Kconfig options:
--------------------

`MBEDTLS_LIB` is for MbedTLS general switch.
`MBEDTLS_LIB_CRYPTO` is for replacing original digest and crypto libs with
MbedTLS.
`MBEDTLS_LIB_X509` is for replacing original X509, PKCS7, MSCode, ASN1,
and Pubkey parser with MbedTLS.
`LEGACY_CRYPTO` is introduced as a main switch for legacy crypto library.
`LEGACY_CRYPTO_BASIC` is for the basic crypto functionalities and
`LEGACY_CRYPTO_CERT` is for the certificate related functionalities.
For each of the algorithm, a pair of `<alg>_LEGACY` and `<alg>_MBEDTLS`
Kconfig options are introduced. Meanwhile, `SPL_` Kconfig options are
introduced.

In this patch set, MBEDTLS_LIB, MBEDTLS_LIB_CRYPTO and MBEDTLS_LIB_X509
are by default enabled in qemu_arm64_defconfig and sandbox_defconfig
for testing purpose.

Patches for external MbedTLS project:
-------------------------------------

Since U-Boot uses Microsoft Authentication Code to verify PE/COFFs
executables which is not supported by MbedTLS at the moment,
addtional patches for MbedTLS are created to adapt with the EFI loader: 
1. Decoding of Microsoft Authentication Code.
2. Decoding of PKCS#9 Authenticate Attributes.
3. Extending MbedTLS PKCS#7 lib to support multiple signer's certificates.
4. MbedTLS native test suites for PKCS#7 signer's info.

All above 4 patches (tagged with `mbedtls/external`) are submitted to
MbedTLS project and being reviewed, eventually they should be part of
MbedTLS LTS release.
But before that, please merge them into U-Boot, otherwise the building
will be broken when MBEDTLS_LIB_X509 is enabled. 

See below PR link for the reference:
https://github.com/Mbed-TLS/mbedtls/pull/9001

Miscellaneous:
--------------

Optimized MbedTLS library size by tailoring the config file
and disabling all unnecessary features for EFI loader.
From v2, original libs (rsa, asn1_decoder, rsa_helper, md5, sha1, sha256,
sha512) are completely replaced when MbedTLS is enabled.
From v3, the size-growth is slightly reduced by refactoring Hash functions.
From v6, smaller implementations for SHA256 and SHA512 are enabled and
target size reduce significantly.
Target(QEMU arm64) size-growth when enabling MbedTLS:
v1: 6.03%
v2: 4.66%
v3 - v5: 4.55%
v6: 2.90% 

Please see the latest output from buildman for size-growth on QEMU arm64,
Sandbox and Nanopi A64. [1]

Tests done:
-----------

EFI Secure Boot test (EFI variables loading and verifying, EFI signed image
verifying and booting) via U-Boot console.
EFI Secure Boot and Capsule sandbox test passed.

Known issues:
-------------

None.

[1]: buildman output for size comparison
(qemu_arm64, sandbox and nanopi_a64) 
```
   aarch64: (for 2/2 boards) all -1568.0 bss -8.0 data -64.0 rodata +200.0 text -1696.0
            qemu_arm64     : all +4472 bss -16 data -64 rodata +200 text +4352
               u-boot: add: 29/-14, grow: 6/-13 bytes: 12812/-8084 (4728)
                 function                                   old     new   delta
                 mbedtls_internal_sha1_process                -    4540   +4540
                 mbedtls_internal_md5_process                 -    2928   +2928
                 K                                            -     896    +896
                 mbedtls_sha256_finish                        -     484    +484
                 mbedtls_internal_sha256_process              -     432    +432
                 mbedtls_sha1_finish                          -     420    +420
                 mbedtls_internal_sha512_process              -     412    +412
                 mbedtls_sha512_finish                        -     360    +360
                 mbedtls_sha512_starts                        -     340    +340
                 mbedtls_md5_finish                           -     336    +336
                 mbedtls_sha512_update                        -     264    +264
                 mbedtls_sha256_update                        -     252    +252
                 mbedtls_sha1_update                          -     236    +236
                 mbedtls_md5_update                           -     236    +236
                 mbedtls_sha512                               -     148    +148
                 mbedtls_sha256_starts                        -     124    +124
                 mbedtls_sha1_starts                          -      72     +72
                 mbedtls_md5_starts                           -      60     +60
                 mbedtls_platform_zeroize                     -      56     +56
                 sha512_put_uint64_be                         -      40     +40
                 mbedtls_sha512_free                          -      16     +16
                 mbedtls_sha256_free                          -      16     +16
                 mbedtls_sha1_free                            -      16     +16
                 mbedtls_md5_free                             -      16     +16
                 sha512_csum_wd                              68      80     +12
                 sha256_csum_wd                              68      80     +12
                 sha1_csum_wd                                68      80     +12
                 md5_wd                                      68      80     +12
                 mbedtls_sha512_init                          -      12     +12
                 mbedtls_sha256_init                          -      12     +12
                 mbedtls_sha1_init                            -      12     +12
                 mbedtls_md5_init                             -      12     +12
                 memset_func                                  -       8      +8
                 sha512_update                                4       8      +4
                 sha384_update                                4       8      +4
                 sha256_update                               12       8      -4
                 sha1_update                                 12       8      -4
                 sha256_process                              16       -     -16
                 sha1_process                                16       -     -16
                 MD5Init                                     56      36     -20
                 sha1_starts                                 60      36     -24
                 sha384_csum_wd                              68      12     -56
                 sha256_starts                              104      40     -64
                 sha256_padding                              64       -     -64
                 sha1_padding                                64       -     -64
                 sha512_finish                              152      36    -116
                 sha512_starts                              168      40    -128
                 sha384_starts                              168      40    -128
                 sha384_finish                              152       4    -148
                 MD5Final                                   196      44    -152
                 sha512_base_do_finalize                    160       -    -160
                 static.sha256_update                       228       -    -228
                 static.sha1_update                         240       -    -240
                 sha512_base_do_update                      244       -    -244
                 MD5Update                                  260       -    -260
                 sha1_finish                                300      36    -264
                 sha256_finish                              404      36    -368
                 sha256_armv8_ce_process                    428       -    -428
                 sha1_armv8_ce_process                      484       -    -484
                 sha512_K                                   640       -    -640
                 sha512_block_fn                           1212       -   -1212
                 MD5Transform                              2552       -   -2552
            nanopi_a64     : all -7608 data -64 rodata +200 text -7744
               u-boot: add: 21/-6, grow: 0/-8 bytes: 10524/-4308 (6216)
                 function                                   old     new   delta
                 mbedtls_internal_sha1_process                -    4540   +4540
                 mbedtls_internal_md5_process                 -    2928   +2928
                 mbedtls_sha256_finish                        -     484    +484
                 mbedtls_internal_sha256_process              -     432    +432
                 mbedtls_sha1_finish                          -     420    +420
                 mbedtls_md5_finish                           -     336    +336
                 K                                            -     256    +256
                 mbedtls_sha256_update                        -     252    +252
                 mbedtls_sha1_update                          -     236    +236
                 mbedtls_md5_update                           -     236    +236
                 mbedtls_sha256_starts                        -     124    +124
                 mbedtls_sha1_starts                          -      72     +72
                 mbedtls_md5_starts                           -      60     +60
                 mbedtls_platform_zeroize                     -      56     +56
                 mbedtls_sha256_free                          -      16     +16
                 mbedtls_sha1_free                            -      16     +16
                 mbedtls_md5_free                             -      16     +16
                 mbedtls_sha256_init                          -      12     +12
                 mbedtls_sha1_init                            -      12     +12
                 mbedtls_md5_init                             -      12     +12
                 memset_func                                  -       8      +8
                 sha256_update                               12       8      -4
                 sha1_update                                 12       8      -4
                 MD5Init                                     56      36     -20
                 sha1_starts                                 60      36     -24
                 sha256_starts                              104      40     -64
                 sha256_padding                              64       -     -64
                 sha1_padding                                64       -     -64
                 MD5Final                                   196      44    -152
                 static.sha256_update                       228       -    -228
                 static.sha1_update                         240       -    -240
                 MD5Update                                  260       -    -260
                 sha1_finish                                300      36    -264
                 sha256_finish                              404      36    -368
                 MD5Transform                              2552       -   -2552
   sandbox: (for 1/1 boards) all +17776.0 bss +128.0 data +1376.0 rodata -4288.0 text +20560.0
            sandbox        : all +17776 bss +128 data +1376 rodata -4288 text +20560
               u-boot: add: 246/-205, grow: 85/-47 bytes: 92037/-80203 (11834)
                 function                                   old     new   delta
                 mbr_test_run                                 -    6557   +6557
                 static.compress_using_gzip                   -    5344   +5344
                 mbedtls_internal_sha1_process                -    4982   +4982
                 static.mbedtls_x509_crt_parse_der_internal       -    4184   +4184
                 pkcs7_parse_message                        361    3638   +3277
                 rsa_verify                                 541    2794   +2253
                 mbedtls_internal_md5_process                 -    2189   +2189
                 mbedtls_rsa_parse_pubkey                     -    2045   +2045
                 static.make_fuller_fdt                       -    1991   +1991
                 mbedtls_rsa_private                          -    1813   +1813
                 compress_frame_buffer                        -    1704   +1704
                 mbedtls_mpi_exp_mod                          -    1649   +1649
                 wget_handler                                 -    1483   +1483
                 x509_populate_cert                           -    1462   +1462
                 mbedtls_mpi_div_mpi                          -    1455   +1455
                 static.mbedtls_x509_dn_gets                  -    1305   +1305
                 mbedtls_mpi_inv_mod                          -    1214   +1214
                 tftp_handler                                 -    1199   +1199
                 mbedtls_rsa_rsaes_pkcs1_v15_decrypt          -    1156   +1156
                 mbedtls_x509_get_subject_alt_name_ext        -    1155   +1155
                 tcg2_log_parse                               -    1060   +1060
                 HUF_decompress4X1_usingDTable_internal_body       -    1029   +1029
                 rsa_check_pair_wrap                          -    1018   +1018
                 static.K                                     -     896    +896
                 oid_x520_attr_type                           -     840    +840
                 load_sandbox_scmi_test_devices               -     776    +776
                 static.prep_mmc_bootdev                      -     773    +773
                 efi_load_image                            4418    5157    +739
                 static.pkcs7_get_signer_info                 -     671    +671
                 mbedtls_mpi_core_montmul                     -     537    +537
                 mbedtls_internal_sha512_process              -     536    +536
                 mbedtls_mpi_core_mla                         -     520    +520
                 static.compress_using_zstd                   -     498    +498
                 static.compress_using_lzo                    -     498    +498
                 static.compress_using_lzma                   -     498    +498
                 static.compress_using_lz4                    -     498    +498
                 static.compress_using_bzip2                  -     498    +498
                 mbedtls_internal_sha256_process              -     487    +487
                 static.overlay_update_local_node_references       -     483    +483
                 mbedtls_x509_get_time                        -     483    +483
                 mbedtls_mpi_mul_mpi                          -     479    +479
                 mbedtls_x509_get_name                        -     470    +470
                 mbedtls_pk_parse_subpubkey                   -     463    +463
                 mbedtls_sha1_finish                          -     455    +455
                 new_string                                   -     450    +450
                 set_string                                   -     448    +448
                 wget_send_stored                             -     434    +434
                 rsa_rsassa_pkcs1_v15_encode                  -     414    +414
                 mbedtls_mpi_gcd                              -     409    +409
                 get_languages                                -     402    +402
                 list_package_lists                           -     398    +398
                 efi_cin_read_key_stroke_ex                   -     393    +393
                 update_package_list                          -     374    +374
                 static.dns_handler                           -     374    +374
                 fastboot_handler                             -     363    +363
                 static.efi_str_to_fat                        -     362    +362
                 oid_x509_ext                                 -     360    +360
                 get_string                                 166     526    +360
                 new_package_list                             -     359    +359
                 efi_convert_device_path_to_text              -     359    +359
                 mbedtls_sha512_finish                        -     358    +358
                 rsa_sign_wrap                                -     355    +355
                 get_keyboard_layout                          -     355    +355
                 add_sub_mpi                                  -     355    +355
                 find_keyboard_layouts                        -     339    +339
                 static.scan_mmc_bootdev                      -     338    +338
                 rsa_verify_wrap                              -     324    +324
                 oid_sig_alg                                  -     320    +320
                 mbedtls_mpi_sub_abs                          -     315    +315
                 static.sqfs_split_path                       -     313    +313
                 append_device_path_instance                  -     311    +311
                 efi_cin_register_key_notify                  -     303    +303
                 get_secondary_languages                      -     301    +301
                 rsa_encrypt_wrap                             -     294    +294
                 efi_convert_device_node_to_text              -     293    +293
                 get_next_device_path_instance                -     290    +290
                 mbedtls_mpi_core_get_mont_r2_unsafe          -     276    +276
                 public_key                                   -     270    +270
                 efi_cin_unregister_key_notify                -     268    +268
                 static.rsa_check_context                     -     264    +264
                 public_key_verify_signature                419     678    +259
                 __udivti3                                    -     248    +248
                 static.efi_stri_coll                         -     247    +247
                 static.oid_md_alg                            -     240    +240
                 mbedtls_rsa_public                           -     239    +239
                 mbedtls_asn1_get_alg                         -     238    +238
                 get_package_list_handle                      -     231    +231
                 static.overlay_get_target                    -     224    +224
                 mbedtls_mpi_shift_l                          -     224    +224
                 static.efi_fat_to_str                        -     223    +223
                 mbedtls_pkcs7_free                           -     223    +223
                 register_package_notify                      -     222    +222
                 create_device_node                           -     222    +222
                 mbedtls_mpi_fill_random                      -     221    +221
                 mbedtls_sha512_update                        -     209    +209
                 remove_package_list                          -     208    +208
                 export_package_lists                         -     206    +206
                 is_device_path_multi_instance                -     201    +201
                 mbedtls_mpi_copy                             -     200    +200
                 mbedtls_sha256_update                        -     197    +197
                 set_keyboard_layout                          -     196    +196
                 static.asn1_get_tagged_int                   -     194    +194
                 efi_cin_reset_ex                             -     194    +194
                 get_device_path_size                         -     191    +191
                 append_device_path                           -     190    +190
                 static.efi_metai_match                       -     188    +188
                 append_device_node                           -     188    +188
                 static.efi_str_upr                           -     187    +187
                 static.efi_str_lwr                           -     187    +187
                 mbedtls_pk_parse_public_key                  -     182    +182
                 duplicate_device_path                        -     180    +180
                 mbedtls_x509_crt_free                        -     177    +177
                 static.mbedtls_sha1_update                   -     176    +176
                 sha256_finish                              357     533    +176
                 fastboot_timed_send_info                     -     174    +174
                 mbedtls_mpi_shift_r                          -     170    +170
                 unregister_package_notify                    -     169    +169
                 efi_cin_set_state                            -     169    +169
                 static.cdp_compute_csum                      -     168    +168
                 efi_key_notify                               -     164    +164
                 efi_console_timer_notify                     -     164    +164
                 static.cdp_send_trigger                      -     161    +161
                 rsa_free_wrap                                -     161    +161
                 mbedtls_mpi_cmp_mpi                          -     161    +161
                 static.pkcs7_get_one_cert                    -     160    +160
                 oid_pk_alg                                   -     160    +160
                 sha384_starts                                -     159    +159
                 mbedtls_mpi_read_binary                      -     159    +159
                 md5_wd                                     571     729    +158
                 mbedtls_mpi_core_write_be                    -     154    +154
                 mbedtls_mpi_mod_mpi                          -     146    +146
                 mbedtls_asn1_get_alg_null                    -     142    +142
                 mbedtls_mpi_cmp_abs                          -     141    +141
                 mbedtls_mpi_mul_int                          -     138    +138
                 HUF_decompress1X1_usingDTable_internal_body       -     138    +138
                 mbedtls_asn1_get_len                         -     133    +133
                 wget_timeout_handler                         -     131    +131
                 tftp_filename                                -     128    +128
                 static.setup_ctx_and_base_tables             -     122    +122
                 static.overlay_adjust_node_phandles          -     121    +121
                 mbedtls_mpi_grow                             -     120    +120
                 mbedtls_rsa_check_pubkey                     -     110    +110
                 static.mbedtls_asn1_get_bitstring            -     108    +108
                 x509_get_timestamp                           -     106    +106
                 ZSTD_frameHeaderSize_internal                -     103    +103
                 tftp_timeout_handler                         -     102    +102
                 data_gz                                  21367   21468    +101
                 static.uncompress_using_bzip2                -     100    +100
                 mbedtls_asn1_get_bool                        -      99     +99
                 static.uncompress_using_lzma                 -      98     +98
                 static.asn1_get_sequence_of_cb               -      98     +98
                 mbedtls_rsa_info                             -      96     +96
                 static.uncompress_using_lzo                  -      95     +95
                 static.uncompress_using_lz4                  -      95     +95
                 static.uncompress_using_gzip                 -      90     +90
                 release_sandbox_scmi_test_devices            -      88     +88
                 mbedtls_x509_get_serial                      -      88     +88
                 inject_response                              -      88     +88
                 mbedtls_mpi_resize_clear                     -      87     +87
                 mbedtls_mpi_bitlen                           -      82     +82
                 static.x509_get_uid                          -      81     +81
                 static.mbedtls_mpi_sub_int                   -      81     +81
                 mbedtls_oid_get_md_alg                       -      78     +78
                 mbedtls_mpi_cmp_int                          -      75     +75
                 rsa_decrypt_wrap                             -      73     +73
                 static.cdp_timeout_handler                   -      72     +72
                 sha512_put_uint64_be                         -      72     +72
                 mbedtls_md_info_from_type                    -      72     +72
                 mbedtls_mpi_lset                             -      69     +69
                 sha1_starts                                  -      64     +64
                 rsa_alloc_wrap                               -      62     +62
                 mbedtls_pk_setup                             -      62     +62
                 static.clear_bloblist                        -      61     +61
                 pkcs7_free_message                         115     176     +61
                 rsa_debug                                    -      60     +60
                 mbedtls_mpi_lsb                              -      60     +60
                 lib_test_strlcat                          1195    1255     +60
                 public_key_signature_free                    -      58     +58
                 static.x509_free_mbedtls_ctx                 -      57     +57
                 x509_populate_dn_name_string                 -      56     +56
                 mbedtls_mpi_core_montmul_init                -      55     +55
                 mbedtls_asn1_get_bitstring_null              -      53     +53
                 static.pkcs7_free_signer_info                -      51     +51
                 mbedtls_mpi_free                             -      51     +51
                 static.mbedtls_mpi_core_bigendian_to_host       -      50     +50
                 mbedtls_asn1_get_tag                         -      50     +50
                 BIT_reloadDStreamFast                        -      50     +50
                 tftp_init_load_addr                          -      47     +47
                 mbedtls_pk_free                              -      45     +45
                 mbedtls_zeroize_and_free                     -      42     +42
                 x509_parse2_int                              -      33     +33
                 mbedtls_asn1_sequence_free                   -      30     +30
                 mbedtls_asn1_free_named_data_list_shallow       -      30     +30
                 static.check_zero                            -      28     +28
                 static.himport_r                           968     995     +27
                 static.hexport_r                           653     680     +27
                 sha512_starts                              132     159     +27
                 generic_phy_get_bulk                       366     392     +26
                 reboot_mode_probe                          139     164     +25
                 static.mbedtls_mpi_get_bit                   -      23     +23
                 static.sqfs_opendir_nest                  1655    1677     +22
                 rsa_can_do                                   -      22     +22
                 ping_timeout_handler                         -      22     +22
                 static.mbedtls_platform_zeroize              -      18     +18
                 static.hash_finish_sha1                     40      58     +18
                 sha256_starts                               68      86     +18
                 mbedtls_mpi_size                             -      18     +18
                 c2                                           -      18     +18
                 rsa_get_bitlen                               -      17     +17
                 static.time_start                            -      16     +16
                 static.__reset_get_bulk                    166     182     +16
                 clk_get_bulk                               157     173     +16
                 unicode_test_utf8_utf16_strcpy             946     960     +14
                 mbedtls_mpi_add_mpi                          -      14     +14
                 c4                                           -      14     +14
                 c1                                           -      14     +14
                 efi_file_read_int                          610     623     +13
                 d4                                           -      13     +13
                 rtc_days_in_month                            -      12     +12
                 mbedtls_mpi_sub_mpi                          -      12     +12
                 i2                                           -      12     +12
                 efi_auth_var_get_type                      102     113     +11
                 i1                                           -      10     +10
                 d3                                           -      10     +10
                 d2                                           -      10     +10
                 x509_free_certificate                      115     124      +9
                 wget_load_size                               -       8      +8
                 tftp_load_addr                               -       8      +8
                 tftp_cur_block                               -       8      +8
                 static.memset_func                           -       8      +8
                 packet_icmp_handler                          -       8      +8
                 mbedtls_sha512_info                          -       8      +8
                 mbedtls_sha384_info                          -       8      +8
                 mbedtls_sha256_info                          -       8      +8
                 mbedtls_sha1_info                            -       8      +8
                 mbedtls_md5_info                             -       8      +8
                 mbedtls_ct_zero                              -       8      +8
                 image_url                                    -       8      +8
                 i3                                           -       8      +8
                 c3                                           -       8      +8
                 unicode_test_utf8_utf16_strlen             443     450      +7
                 unicode_test_utf16_utf8_strlen             443     450      +7
                 unicode_test_utf16_utf8_strcpy            1021    1028      +7
                 mpi_bigendian_to_host                        -       7      +7
                 efi_auth_var_get_guid                       81      88      +7
                 d1                                           -       7      +7
                 string_to_vlan                              35      41      +6
                 ping6_timeout                                -       6      +6
                 j3                                           -       6      +6
                 j2                                           -       6      +6
                 efi_signature_verify                      1640    1646      +6
                 static.test_data                             -       5      +5
                 on_vlan                                     28      33      +5
                 on_nvlan                                    28      33      +5
                 j1                                           -       5      +5
                 eficonfig_process_select_file             2179    2184      +5
                 crypt_sha512crypt_rn_wrapped              2408    2413      +5
                 crypt_sha256crypt_rn_wrapped              1669    1674      +5
                 wget_timeout_count                           -       4      +4
                 unicode_test_u16_strlen                    269     273      +4
                 timeout_count_max                            -       4      +4
                 timeout_count                                -       4      +4
                 tftp_state                                   -       4      +4
                 tftp_our_port                                -       4      +4
                 static.net_arp_wait_reply_ip                 -       4      +4
                 static.eth_errno                             -       4      +4
                 static.dns_our_port                          -       4      +4
                 static.cdp_seq                               -       4      +4
                 static.cdp_ok                                -       4      +4
                 static.bootdev_test_prio                   928     932      +4
                 static.bootdev_test_order_default          562     566      +4
                 static.bootdev_test_order                 2435    2439      +4
                 rmt_timestamp                                -       4      +4
                 retry_tcp_seq_num                            -       4      +4
                 retry_tcp_ack_num                            -       4      +4
                 retry_len                                    -       4      +4
                 our_port                                     -       4      +4
                 net_set_udp_header                         103     107      +4
                 loc_timestamp                                -       4      +4
                 fastboot_our_port                            -       4      +4
                 eficonfig_edit_boot_option                1563    1567      +4
                 efi_launch_capsules                       3138    3142      +4
                 efi_init_early                            1051    1055      +4
                 current_wget_state                           -       4      +4
                 current_tcp_state                            -       4      +4
                 bootp_reset                                 48      52      +4
                 bootp_request                              632     636      +4
                 asymmetric_key_generate_id                 109     113      +4
                 arp_request                                 87      91      +4
                 arp_raw_request                            223     227      +4
                 adler32                                    767     771      +4
                 unicode_test_u16_strncmp                   377     380      +3
                 str_upper                                  648     651      +3
                 eficonfig_file_selected                    484     487      +3
                 efi_init_obj_list                         5873    5876      +3
                 efi_create_indexed_name                    174     177      +3
                 bloblist_test_grow                         719     722      +3
                 SHA256_Update_recycled                      76      79      +3
                 unicode_test_utf8_utf16_strncpy            929     931      +2
                 unicode_test_utf16_utf8_strncpy            921     923      +2
                 tftp_windowsize                              -       2      +2
                 tftp_next_ack                                -       2      +2
                 tftp_block_size                              -       2      +2
                 static.tcg2_measure_variable               236     238      +2
                 static.efi_cout_output_string              541     543      +2
                 static.do_env_print                       1278    1280      +2
                 prepare_file_selection_entry               400     402      +2
                 eficonfig_boot_edit_save                    96      98      +2
                 eficonfig_add_change_boot_order_entry      346     348      +2
                 eficonfig_add_boot_selection_entry         461     463      +2
                 efi_str_to_u16                             103     105      +2
                 efi_serialize_load_option                  260     262      +2
                 efi_get_variable_mem                       503     505      +2
                 efi_file_setinfo                           523     525      +2
                 efi_file_getinfo                           783     785      +2
                 efi_convert_string                         109     111      +2
                 efi_binary_run                             790     792      +2
                 do_bootmenu                               2154    2156      +2
                 create_boot_option_entry                   206     208      +2
                 bootdev_hunt                               366     368      +2
                 add_packages                               890     892      +2
                 unicode_test_efi_create_indexed_name       481     482      +1
                 u16_strsize                                 20      21      +1
                 u16_strlcat                                106     107      +1
                 static.hash_update_sha1                     29      30      +1
                 static.efi_set_variable_runtime            553     554      +1
                 retry_action                                 -       1      +1
                 file_open                                  738     739      +1
                 efi_var_mem_ins                            287     288      +1
                 efi_set_variable_int                      1929    1930      +1
                 efi_dp_from_file                           278     279      +1
                 static.retry_action                          1       -      -1
                 fastboot_send                             1815    1814      -1
                 byteReverse                                  1       -      -1
                 static.tftp_windowsize                       2       -      -2
                 static.tftp_next_ack                         2       -      -2
                 static.tftp_block_size                       2       -      -2
                 sha256_csum_wd                             155     153      -2
                 net_send_udp_packet6                       415     413      -2
                 net_set_timeout_handler                     26      23      -3
                 fdt_open_into                              435     432      -3
                 fdt_delprop                                121     118      -3
                 tftp_start                                1367    1363      -4
                 static.wget_timeout_count                    4       -      -4
                 static.timeout_count_max                     4       -      -4
                 static.timeout_count                         4       -      -4
                 static.tftp_state                            4       -      -4
                 static.tftp_our_port                         4       -      -4
                 static.rmt_timestamp                         4       -      -4
                 static.retry_tcp_seq_num                     4       -      -4
                 static.retry_tcp_ack_num                     4       -      -4
                 static.retry_len                             4       -      -4
                 static.our_port                              4       -      -4
                 static.loc_timestamp                         4       -      -4
                 static.fastboot_our_port                     4       -      -4
                 static.current_wget_state                    4       -      -4
                 static.current_tcp_state                     4       -      -4
                 static.alist_expand_to                     120     116      -4
                 static.ZSTD_freeDDict                       89      85      -4
                 sha512_csum_wd                             169     165      -4
                 rarp_request                               202     198      -4
                 pcap_post                                  321     317      -4
                 net_send_tcp_packet                         52      48      -4
                 net_arp_wait_reply_ip                        4       -      -4
                 ndisc_request                              451     447      -4
                 ip6_add_hdr                                 77      73      -4
                 fdt_find_string_                            83      79      -4
                 fdt_check_node_offset_                      46      42      -4
                 eth_errno                                    4       -      -4
                 efi_dp_from_uart                            87      83      -4
                 dns_our_port                                 4       -      -4
                 dm_check_devices                           251     247      -4
                 dhcp6_start                                236     232      -4
                 cdp_seq                                      4       -      -4
                 cdp_ok                                       4       -      -4
                 ZSTD_getFrameHeader_advanced               449     445      -4
                 test_data                                    5       -      -5
                 lib_test_efi_dp_check_length               593     588      -5
                 static.ping6_timeout                         6       -      -6
                 net_cdp_ethaddr                              6       -      -6
                 fdt_pack                                    80      74      -6
                 fdt_create_empty_tree                      102      96      -6
                 fdt_add_subnode                            312     306      -6
                 ZSTD_initFseState                           44      37      -7
                 static.wget_load_size                        8       -      -8
                 static.tftp_load_addr                        8       -      -8
                 static.tftp_cur_block                        8       -      -8
                 static.packet_icmp_handler                   8       -      -8
                 static.image_url                             8       -      -8
                 static.BIT_initDStream                     518     510      -8
                 sha384_csum_wd                             296     288      -8
                 cdp_snap_hdr                                 8       -      -8
                 static.fdt_rw_probe_                        79      70      -9
                 ZSTD_decompressDCtx                       7745    7736      -9
                 rsa_verify_key                             383     372     -11
                 fdt_setprop                                147     135     -12
                 sha256_update                               14       -     -14
                 x509_akid_note_name                         15       -     -15
                 pkcs7_sig_note_skid                         15       -     -15
                 pkcs7_sig_note_serial                       15       -     -15
                 pkcs7_sig_note_issuer                       15       -     -15
                 time_start                                  16       -     -16
                 static.rsapubkey_action_table               16       -     -16
                 fdt_add_mem_rsv                            101      85     -16
                 fdt_del_mem_rsv                             84      67     -17
                 x509_note_serial                            21       -     -21
                 static.ping_timeout_handler                 22       -     -22
                 pkcs7_check_content_type                    22       -     -22
                 do_net_stats                               371     349     -22
                 x509_decoder                                24       -     -24
                 x509_akid_decoder                           24       -     -24
                 rsapubkey_decoder                           24       -     -24
                 pkcs7_decoder                               24       -     -24
                 mscode_machine                              24       -     -24
                 mscode_decoder                              24       -     -24
                 mscode_action_table                         24       -     -24
                 check_zero                                  24       -     -24
                 x509_note_tbs_certificate                   26       -     -26
                 x509_note_not_before                        28       -     -28
                 x509_note_not_after                         28       -     -28
                 pkcs7_note_data                             28       -     -28
                 x509_note_issuer                            30       -     -30
                 rsa_get_n                                   30       -     -30
                 _u_boot_list_2_ut_lib_test_2_lib_asn1_x509      32       -     -32
                 _u_boot_list_2_ut_lib_test_2_lib_asn1_pkey      32       -     -32
                 _u_boot_list_2_ut_lib_test_2_lib_asn1_pkcs7      32       -     -32
                 sha1_csum_wd                               209     176     -33
                 static.hash_init_sha1                       75      41     -34
                 static.hash_finish_sha384                   40       6     -34
                 x509_note_subject                           36       -     -36
                 pkcs7_note_content                          36       -     -36
                 HUF_decodeStreamX1                         187     151     -36
                 static.ZSTD_decodeSequence                 462     425     -37
                 x509_akid_action_table                      40       -     -40
                 x509_note_params                            41       -     -41
                 pkcs7_note_signeddata_version               41       -     -41
                 asn1_op_lengths                             41       -     -41
                 pkcs7_note_certificate_list                 46       -     -46
                 static.public_key_signature_free            48       -     -48
                 static.tftp_init_load_addr                  51       -     -51
                 mscode_note_digest                          51       -     -51
                 static.BIT_reloadDStreamFast                54       -     -54
                 rsa_get_e                                   56       -     -56
                 clear_bloblist                              57       -     -57
                 x509_extract_name_segment                   62       -     -62
                 sha256_padding                              64       -     -64
                 sha1_padding                                64       -     -64
                 pkcs7_sig_note_signature                    68       -     -68
                 pkcs7_sig_note_set_of_authattrs             72       -     -72
                 cdp_timeout_handler                         72       -     -72
                 pkcs7_sig_note_pkey_algo                    75       -     -75
                 sha512_finish                              123      47     -76
                 sha384_finish                              123      47     -76
                 pkcs7_note_signerinfo_version               79       -     -79
                 x509_akid_note_kid                          80       -     -80
                 x509_akid_note_serial                       81       -     -81
                 pkcs7_extract_cert                          81       -     -81
                 net_loop                                  3226    3145     -81
                 uncompress_using_gzip                       90       -     -90
                 static.release_sandbox_scmi_test_devices      92       -     -92
                 static.inject_response                      92       -     -92
                 x509_akid_machine                           93       -     -93
                 uncompress_using_lzo                        95       -     -95
                 uncompress_using_lz4                        95       -     -95
                 x509_extract_key_data                       98       -     -98
                 uncompress_using_lzma                       98       -     -98
                 uncompress_using_bzip2                     100       -    -100
                 static.tftp_timeout_handler                102       -    -102
                 x509_action_table                          104       -    -104
                 x509_note_OID                              105       -    -105
                 static.ZSTD_frameHeaderSize_internal       107       -    -107
                 static.hash_init_sha384                    152      41    -111
                 x509_machine                               113       -    -113
                 overlay_adjust_node_phandles               117       -    -117
                 setup_ctx_and_base_tables                  118       -    -118
                 x509_process_extension                     125       -    -125
                 static.tftp_filename                       128       -    -128
                 x509_note_signature                        129       -    -129
                 static.wget_timeout_handler                131       -    -131
                 static.__func__                          34215   34080    -135
                 pkcs7_note_OID                             136       -    -136
                 pkcs7_action_table                         136       -    -136
                 static.HUF_decompress1X1_usingDTable_internal_body     150       -    -150
                 oid_index                                  150       -    -150
                 sha512_base_do_finalize                    154       -    -154
                 cdp_send_trigger                           157       -    -157
                 static.efi_key_notify                      164       -    -164
                 static.efi_console_timer_notify            164       -    -164
                 cdp_compute_csum                           164       -    -164
                 static.unregister_package_notify           169       -    -169
                 static.efi_cin_set_state                   169       -    -169
                 static.fastboot_timed_send_info            174       -    -174
                 static.duplicate_device_path               180       -    -180
                 pkcs7_note_signed_info                     187       -    -187
                 efi_str_upr                                187       -    -187
                 efi_str_lwr                                187       -    -187
                 static.append_device_node                  188       -    -188
                 efi_metai_match                            188       -    -188
                 mscode_note_content_type                   189       -    -189
                 static.append_device_path                  190       -    -190
                 pkcs7_sig_note_digest_algo                 190       -    -190
                 static.get_device_path_size                191       -    -191
                 static.sha256_update                       194       -    -194
                 static.efi_cin_reset_ex                    194       -    -194
                 static.sha512_base_do_update               195       -    -195
                 static.set_keyboard_layout                 196       -    -196
                 static.is_device_path_multi_instance       201       -    -201
                 static.export_package_lists                206       -    -206
                 look_up_OID                                207       -    -207
                 static.remove_package_list                 208       -    -208
                 static.sha1_update                         216       -    -216
                 tcg2_create_digest                         718     500    -218
                 overlay_get_target                         220       -    -220
                 static.register_package_notify             222       -    -222
                 static.create_device_node                  222       -    -222
                 efi_fat_to_str                             223       -    -223
                 static.get_package_list_handle             231       -    -231
                 pkcs7_machine                              239       -    -239
                 static.sprint_oid                          241       -    -241
                 lib_asn1_pkcs7                             244       -    -244
                 efi_stri_coll                              247       -    -247
                 sha256_k                                   256       -    -256
                 static.efi_cin_unregister_key_notify       268       -    -268
                 pkcs7_sig_note_authenticated_attr          268       -    -268
                 sha1_finish                                288       -    -288
                 static.get_next_device_path_instance       290       -    -290
                 lib_asn1_pkey                              290       -    -290
                 x509_note_pkey_algo                        291       -    -291
                 static.efi_convert_device_node_to_text     293       -    -293
                 oid_search_table                           296       -    -296
                 static.get_secondary_languages             301       -    -301
                 static.efi_cin_register_key_notify         303       -    -303
                 sqfs_split_path                            309       -    -309
                 static.append_device_path_instance         311       -    -311
                 mscode_note_digest_algo                    327       -    -327
                 scan_mmc_bootdev                           334       -    -334
                 static.find_keyboard_layouts               339       -    -339
                 plain                                      351       -    -351
                 static.get_keyboard_layout                 355       -    -355
                 static.new_package_list                    359       -    -359
                 static.efi_convert_device_path_to_text     359       -    -359
                 static.get_string                          360       -    -360
                 efi_str_to_fat                             362       -    -362
                 static.fastboot_handler                    363       -    -363
                 static.update_package_list                 374       -    -374
                 dns_handler                                374       -    -374
                 static.efi_cin_read_key_stroke_ex          393       -    -393
                 static.list_package_lists                  398       -    -398
                 static.get_languages                       402       -    -402
                 lib_asn1_x509                              423       -    -423
                 static.x509_fabricate_name                 428       -    -428
                 static.wget_send_stored                    438       -    -438
                 static.set_string                          448       -    -448
                 static.new_string                          450       -    -450
                 overlay_update_local_node_references       479       -    -479
                 compress_using_zstd                        498       -    -498
                 compress_using_lzo                         498       -    -498
                 compress_using_lzma                        498       -    -498
                 compress_using_lz4                         498       -    -498
                 compress_using_bzip2                       498       -    -498
                 oid_data                                   513       -    -513
                 static.public_key                          540       -    -540
                 sha512_k                                   640       -    -640
                 prep_mmc_bootdev                           769       -    -769
                 static.x509_decode_time                    779       -    -779
                 static.load_sandbox_scmi_test_devices      780       -    -780
                 x509_cert_parse                            973     179    -794
                 cert_data                                  971       -    -971
                 static.HUF_decompress4X1_usingDTable_internal_body    1056       -   -1056
                 static.tcg2_log_parse                     1064       -   -1064
                 static.tftp_handler                       1199       -   -1199
                 static.wget_handler                       1483       -   -1483
                 asn1_ber_decoder                          1511       -   -1511
                 rsa_verify_with_pkey                      1676       -   -1676
                 static.compress_frame_buffer              1708       -   -1708
                 sha512_block_fn                           1714       -   -1714
                 image_pk7                                 1811       -   -1811
                 MD5Transform                              1812       -   -1812
                 make_fuller_fdt                           1987       -   -1987
                 compress_using_gzip                       5344       -   -5344
                 static.mbr_test_run                       6557       -   -6557
                 sha1_process_one                          8090       -   -8090
                 sha256_process_one                        9972       -   -9972
```

Raymond Mao (27):
  CI: Exclude MbedTLS subtree for CONFIG checks
  mbedtls: add mbedtls into the build system
  lib: Adapt digest header files to MbedTLS
  md5: Remove md5 non-watchdog API
  sha1: Remove sha1 non-watchdog API
  mbedtls: add digest shim layer for MbedTLS
  mbedtls: Enable smaller implementation for SHA256/512
  mbedtls/external: support Microsoft Authentication Code
  mbedtls/external: support PKCS9 Authenticate Attributes
  mbedtls/external: support decoding multiple signer's cert
  mbedtls/external: update MbedTLS PKCS7 test suites
  public_key: move common functions to public key helper
  x509: move common functions to x509 helper
  pkcs7: move common functions to PKCS7 helper
  mbedtls: add public key porting layer
  lib/crypto: Adapt public_key header with MbedTLS
  mbedtls: add X509 cert parser porting layer
  lib/crypto: Adapt x509_cert_parser to MbedTLS
  mbedtls: add PKCS7 parser porting layer
  lib/crypto: Adapt PKCS7 parser to MbedTLS
  mbedtls: add MSCode parser porting layer
  lib/crypto: Adapt mscode_parser to MbedTLS
  mbedtls: add RSA helper layer on MbedTLS
  lib/rypto: Adapt rsa_helper to MbedTLS
  asn1_decoder: add build options for ASN1 decoder
  test: Remove ASN1 library test
  configs: enable MbedTLS as default setting

 .azure-pipelines.yml                          |   3 +-
 .gitlab-ci.yml                                |   3 +-
 Makefile                                      |   6 +
 board/friendlyarm/nanopi2/board.c             |   3 +-
 board/gdsys/a38x/hre.c                        |   2 +-
 board/intel/edison/edison.c                   |   3 +-
 board/xilinx/zynq/bootimg.c                   |   2 +-
 configs/qemu_arm64_defconfig                  |   1 +
 configs/sandbox_defconfig                     |   1 +
 drivers/mmc/Kconfig                           |   1 +
 include/crypto/mscode.h                       |   4 +
 include/crypto/pkcs7_parser.h                 |  56 ++
 include/crypto/public_key.h                   |   6 +
 include/crypto/x509_parser.h                  |  55 ++
 include/limits.h                              |  25 +
 include/linux/kernel.h                        |  13 +-
 include/stdlib.h                              |   1 +
 include/u-boot/md5.h                          |  14 +-
 include/u-boot/sha1.h                         |  37 +-
 include/u-boot/sha256.h                       |  20 +
 include/u-boot/sha512.h                       |   9 +
 lib/Kconfig                                   |   4 +
 lib/Makefile                                  |  15 +-
 lib/crypto/Makefile                           |  16 +-
 lib/crypto/asymmetric_type.c                  |   2 +-
 lib/crypto/pkcs7_helper.c                     |  37 ++
 lib/crypto/pkcs7_parser.c                     |  28 -
 lib/crypto/public_key.c                       |  31 --
 lib/crypto/public_key_helper.c                |  39 ++
 lib/crypto/x509_helper.c                      |  64 +++
 lib/crypto/x509_public_key.c                  |  58 +-
 lib/mbedtls/Kconfig                           | 424 +++++++++++++++
 lib/mbedtls/Makefile                          |  56 ++
 .../external/mbedtls/include/mbedtls/oid.h    |  35 ++
 .../external/mbedtls/include/mbedtls/pkcs7.h  |  21 +
 lib/mbedtls/external/mbedtls/library/pkcs7.c  | 154 ++++--
 .../tests/suites/test_suite_pkcs7.data        |   4 +-
 lib/mbedtls/mbedtls_def_config.h              |  78 +++
 lib/mbedtls/md5.c                             |  57 ++
 lib/mbedtls/mscode_parser.c                   | 123 +++++
 lib/mbedtls/pkcs7_parser.c                    | 506 ++++++++++++++++++
 lib/mbedtls/port/assert.h                     |  12 +
 lib/mbedtls/public_key.c                      |  82 +++
 lib/mbedtls/rsa_helper.c                      |  95 ++++
 lib/mbedtls/sha1.c                            |  99 ++++
 lib/mbedtls/sha256.c                          |  62 +++
 lib/mbedtls/sha512.c                          |  93 ++++
 lib/mbedtls/x509_cert_parser.c                | 447 ++++++++++++++++
 lib/md5.c                                     |  14 -
 lib/sha1.c                                    |  13 -
 lib/tpm-v1.c                                  |   2 +-
 test/Kconfig                                  |   2 +-
 52 files changed, 2706 insertions(+), 232 deletions(-)
 create mode 100644 include/limits.h
 create mode 100644 lib/crypto/pkcs7_helper.c
 create mode 100644 lib/crypto/public_key_helper.c
 create mode 100644 lib/crypto/x509_helper.c
 create mode 100644 lib/mbedtls/Kconfig
 create mode 100644 lib/mbedtls/Makefile
 create mode 100644 lib/mbedtls/mbedtls_def_config.h
 create mode 100644 lib/mbedtls/md5.c
 create mode 100644 lib/mbedtls/mscode_parser.c
 create mode 100644 lib/mbedtls/pkcs7_parser.c
 create mode 100644 lib/mbedtls/port/assert.h
 create mode 100644 lib/mbedtls/public_key.c
 create mode 100644 lib/mbedtls/rsa_helper.c
 create mode 100644 lib/mbedtls/sha1.c
 create mode 100644 lib/mbedtls/sha256.c
 create mode 100644 lib/mbedtls/sha512.c
 create mode 100644 lib/mbedtls/x509_cert_parser.c

-- 
2.25.1

