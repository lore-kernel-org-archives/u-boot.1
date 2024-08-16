Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C618C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 21:45:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E97688C02;
	Fri, 16 Aug 2024 23:45:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oviyZ8J1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E996488C07; Fri, 16 Aug 2024 23:45:02 +0200 (CEST)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com
 [IPv6:2607:f8b0:4864:20::932])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54BD288BB0
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 23:44:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-8430e4fb268so235515241.3
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 14:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723844687; x=1724449487; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9qh917cxfw/j7trNKYmP3z7NFVRUXtv8KgnMaTcmOkw=;
 b=oviyZ8J1qUhhseWeDEHjs8IsILiBO/kgkgzkG5jhwPNO12KNpmvttUUAhiiPqnDu7k
 Tcuxybg+mRwFKD5zEjj7MNXAWUA4LTFFKIcaKEZ6p383Q6BCFJlho2jX2EpkmnS/z5/+
 s6HQ/GJVi7ZKgrSft1kSsEJhgkwwfhvWFzDWHTnfMB/scclwS4OCBZSv7bUdeSTmkW1h
 CNXjbXQfdOocXdOF02N9TipIoBDsIRof1qC+LBEE/EMuSg0YgiZG9Ru+sAr/pSpXHTkF
 xKX9g6uwYIDzcBvoknvDxLUMTlc2tm709w8Fy7qkiXX8I1jzIluKErMFmrJIsgdANp8i
 2ydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723844687; x=1724449487;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9qh917cxfw/j7trNKYmP3z7NFVRUXtv8KgnMaTcmOkw=;
 b=baQcsiIgaWB107z79Px7roD0MXHXfwCmzyKcXio5Lr79XDJgLQ832U50X30phskGpx
 3OsDCcmLA1Uqw1WYzoBuLU8RXGyHx1fWjV0pGULMoKo8736qhJsZm7t6090hw8x0yCKz
 vN95wkyiJy4t0xe1Su1kkU+HBNgRJTzu8AiPZQrNrmmXVtRF8LRwwgdnyA8o44czh4KQ
 P+cw4m8psp35mk81nLfYn8UgJKzGesaEjUKWFJZwZokO8WKXbZoJhbMePNJu6vjJ1eCa
 WiEwR2TFUwf/2wsC7mhYE98sFM4ebqwxno1XBfrhKppeeGmNJ84evfGNyQyDlDlZ8eDH
 ByUg==
X-Gm-Message-State: AOJu0YzUDaQ2k0Tt1qTLzThIrRf+cTMNIDeZSOEA8N28JSGRDLvxj68F
 5q68M4SnCNljK94ZpM6wQ7tY7YxOgxs1MDEQf1d+cCdl/ky1dDK7ouihrYjC6joqeak59pZHUYd
 Lnu4=
X-Google-Smtp-Source: AGHT+IEvRTThLM7LiAEqjLQQ6Axdba+Zdz5HwBiSoc+zl+oaYYVBDvVLN+GGmXOWm5LChLLrb4DiIQ==
X-Received: by 2002:a05:6102:26cc:b0:493:c028:bee0 with SMTP id
 ada2fe7eead31-49779964354mr4444896137.15.1723844686513; 
 Fri, 16 Aug 2024 14:44:46 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6ff04ffbsm22044196d6.128.2024.08.16.14.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 14:44:45 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v6 00/28] Integrate MbedTLS v3.6 LTS with U-Boot
Date: Fri, 16 Aug 2024 14:43:49 -0700
Message-Id: <20240816214436.1877263-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
   aarch64: (for 2/2 boards) all -1468.0 bss +16.0 data -64.0 rodata +200.0 text -1620.0
            qemu_arm64     : all +4608 bss +80 data -64 rodata +200 text +4392
               u-boot: add: 29/-17, grow: 12/-16 bytes: 13072/-8304 (4768)
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
                 hash_init_sha512                            52     128     +76
                 hash_init_sha256                            52     128     +76
                 mbedtls_sha1_starts                          -      72     +72
                 mbedtls_md5_starts                           -      60     +60
                 hash_init_sha1                              52     112     +60
                 mbedtls_platform_zeroize                     -      56     +56
                 sha512_put_uint64_be                         -      40     +40
                 mbedtls_sha512_free                          -      16     +16
                 mbedtls_sha256_free                          -      16     +16
                 mbedtls_sha1_free                            -      16     +16
                 mbedtls_md5_free                             -      16     +16
                 hash_finish_sha512                          72      88     +16
                 hash_finish_sha256                          72      88     +16
                 hash_finish_sha1                            72      88     +16
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
                 hash_update_sha512                          36      16     -20
                 hash_update_sha256                          36      16     -20
                 hash_update_sha1                            36      16     -20
                 MD5Init                                     56      36     -20
                 sha1_starts                                 60      36     -24
                 hash_update_sha384                          36       -     -36
                 hash_init_sha384                            52       -     -52
                 sha384_csum_wd                              68      12     -56
                 sha256_starts                              104      40     -64
                 sha256_padding                              64       -     -64
                 sha1_padding                                64       -     -64
                 hash_finish_sha384                          72       -     -72
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
            nanopi_a64     : all -7544 bss -48 data -64 rodata +200 text -7632
               u-boot: add: 21/-8, grow: 4/-8 bytes: 10692/-4364 (6328)
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
                 hash_init_sha256                            52     128     +76
                 mbedtls_sha1_starts                          -      72     +72
                 mbedtls_md5_starts                           -      60     +60
                 hash_init_sha1                              52     112     +60
                 mbedtls_platform_zeroize                     -      56     +56
                 mbedtls_sha256_free                          -      16     +16
                 mbedtls_sha1_free                            -      16     +16
                 mbedtls_md5_free                             -      16     +16
                 hash_finish_sha256                          72      88     +16
                 hash_finish_sha1                            72      88     +16
                 mbedtls_sha256_init                          -      12     +12
                 mbedtls_sha1_init                            -      12     +12
                 mbedtls_md5_init                             -      12     +12
                 memset_func                                  -       8      +8
                 sha256_update                               12       -     -12
                 sha1_update                                 12       -     -12
                 hash_update_sha256                          36      16     -20
                 hash_update_sha1                            36      16     -20
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
   sandbox: (for 1/1 boards) all +19312.0 data +1440.0 rodata -4128.0 text +22000.0
            sandbox        : all +19312 data +1440 rodata -4128 text +22000
               u-boot: add: 258/-206, grow: 122/-59 bytes: 90286/-76286 (14000)
                 function                                   old     new   delta
                 mbedtls_internal_sha1_process                -    4982   +4982
                 static.mbedtls_x509_crt_parse_der_internal   -    4184   +4184
                 static.pci_uclass_post_probe                 -    3570   +3570
                 pkcs7_parse_message                        361    3638   +3277
                 static.sandbox_tpm2_xfer                     -    2605   +2605
                 rsa_verify                                 541    2794   +2253
                 mbedtls_internal_md5_process                 -    2189   +2189
                 mbedtls_rsa_parse_pubkey                     -    2053   +2053
                 mbedtls_rsa_private                          -    1813   +1813
                 run_test                                  2220    3932   +1712
                 mbedtls_mpi_exp_mod                          -    1649   +1649
                 read_one_chunk                               -    1606   +1606
                 x509_populate_cert                           -    1462   +1462
                 mbedtls_mpi_div_mpi                          -    1459   +1459
                 static.simple_panel_get_edid_timing          -    1385   +1385
                 static.sqfs_search_dir                       -    1336   +1336
                 static.mbedtls_x509_dn_gets                  -    1305   +1305
                 mbedtls_mpi_inv_mod                          -    1214   +1214
                 mbedtls_rsa_rsaes_pkcs1_v15_decrypt          -    1156   +1156
                 mbedtls_x509_get_subject_alt_name_ext        -    1155   +1155
                 rsa_check_pair_wrap                          -    1018   +1018
                 static.K                                     -     896    +896
                 oid_x520_attr_type                           -     840    +840
                 static.pci_uclass_pre_probe                  -     832    +832
                 read_persistent_digest                       -     825    +825
                 ta_rpc_test_invoke_func                      -     812    +812
                 ta_avb_invoke_func                           -     783    +783
                 static.dm_pciauto_setup_device               -     747    +747
                 efi_load_image                            4418    5157    +739
                 static.pkcs7_get_signer_info                 -     671    +671
                 static.dfu_bind                              -     637    +637
                 efi_tcg2_hash_log_extend_event               -     622    +622
                 static.sqfs_frag_lookup                      -     605    +605
                 mbedtls_mpi_core_montmul                     -     537    +537
                 mbedtls_internal_sha512_process              -     536    +536
                 mbedtls_mpi_core_mla                         -     520    +520
                 mbedtls_sha256_finish                        -     519    +519
                 static.sqfs_resolve_symlink                  -     509    +509
                 mbedtls_internal_sha256_process              -     487    +487
                 static.overlay_update_local_node_references  -     483    +483
                 mbedtls_x509_get_time                        -     483    +483
                 mbedtls_mpi_mul_mpi                          -     479    +479
                 mbedtls_x509_get_name                        -     470    +470
                 mbedtls_pk_parse_subpubkey                   -     463    +463
                 efi_tcg2_get_capability                      -     462    +462
                 find_and_setup_root                          -     456    +456
                 static.new_string                            -     450    +450
                 static.set_string                            -     448    +448
                 mbedtls_sha1_finish                          -     445    +445
                 longest_match                                -     424    +424
                 rsa_rsassa_pkcs1_v15_encode                  -     414    +414
                 mbedtls_mpi_gcd                              -     413    +413
                 load_full_partition                          -     413    +413
                 static.get_languages                         -     402    +402
                 static.efi_uninstall_protocol                -     400    +400
                 static.list_package_lists                    -     398    +398
                 static.update_package_list                   -     374    +374
                 static.efi_disconnect_all_drivers            -     363    +363
                 efi_tcg2_get_eventlog                        -     361    +361
                 static.get_string                            -     360    +360
                 oid_x509_ext                                 -     360    +360
                 static.new_package_list                      -     359    +359
                 static.efi_convert_device_path_to_text       -     359    +359
                 static.get_keyboard_layout                   -     355    +355
                 rsa_sign_wrap                                -     355    +355
                 add_sub_mpi                                  -     355    +355
                 mbedtls_sha512_finish                        -     352    +352
                 efi_tcg2_submit_command                      -     351    +351
                 static.find_keyboard_layouts                 -     339    +339
                 rsa_verify_wrap                              -     324    +324
                 oid_sig_alg                                  -     320    +320
                 efi_tcg2_notify_exit_boot_services           -     316    +316
                 mbedtls_mpi_sub_abs                          -     315    +315
                 static.append_device_path_instance           -     311    +311
                 static.get_secondary_languages               -     301    +301
                 rsa_encrypt_wrap                             -     294    +294
                 static.hash_init_sha512                     41     334    +293
                 static.efi_convert_device_node_to_text       -     293    +293
                 static.get_next_device_path_instance         -     290    +290
                 spi_set_speed_mode                           -     287    +287
                 static.buck_get_suspend_enable               -     276    +276
                 mbedtls_mpi_core_get_mont_r2_unsafe          -     276    +276
                 efi_tcg2_get_active_pcr_banks                -     273    +273
                 public_key                                   -     270    +270
                 static.buck_set_suspend_enable               -     264    +264
                 static.rsa_check_context                     -     260    +260
                 public_key_verify_signature                419     678    +259
                 __udivti3                                    -     248    +248
                 mbedtls_rsa_public                           -     242    +242
                 static.oid_md_alg                            -     240    +240
                 mbedtls_asn1_get_alg                         -     238    +238
                 static.get_package_list_handle               -     231    +231
                 static.dm_pciauto_exp_link_stable            -     231    +231
                 static.overlay_get_target                    -     224    +224
                 mbedtls_mpi_shift_l                          -     224    +224
                 mbedtls_pkcs7_free                           -     223    +223
                 static.register_package_notify               -     222    +222
                 static.create_device_node                    -     222    +222
                 mbedtls_mpi_fill_random                      -     221    +221
                 static.dfu_handle                            -     213    +213
                 static.usb_emul_find_devnum                  -     210    +210
                 mbedtls_sha512_update                        -     209    +209
                 static.remove_package_list                   -     208    +208
                 static.export_package_lists                  -     206    +206
                 static.montMul                               -     202    +202
                 static.sqfs_tokenize                         -     201    +201
                 static.is_device_path_multi_instance         -     201    +201
                 mbedtls_mpi_copy                             -     200    +200
                 mbedtls_sha256_update                        -     197    +197
                 static.set_keyboard_layout                   -     196    +196
                 static.ldo_set_suspend_enable                -     195    +195
                 static.asn1_get_tagged_int                   -     194    +194
                 static.get_device_path_size                  -     191    +191
                 static.efi_open_volume                       -     191    +191
                 static.append_device_path                    -     190    +190
                 static.append_device_node                    -     188    +188
                 static.ldo_get_suspend_enable                -     182    +182
                 mbedtls_pk_parse_public_key                  -     182    +182
                 static.duplicate_device_path                 -     180    +180
                 mbedtls_x509_crt_free                        -     177    +177
                 static.mbedtls_sha1_update                   -     176    +176
                 mbedtls_mpi_shift_r                          -     174    +174
                 static.unregister_package_notify             -     169    +169
                 rsa_free_wrap                                -     161    +161
                 mbedtls_mpi_cmp_mpi                          -     161    +161
                 static.pkcs7_get_one_cert                    -     160    +160
                 oid_pk_alg                                   -     160    +160
                 mbedtls_mpi_read_binary                      -     159    +159
                 md5_wd                                     571     729    +158
                 mbedtls_mpi_core_write_be                    -     154    +154
                 static.switch_set_enable                     -     150    +150
                 mbedtls_mpi_mod_mpi                          -     146    +146
                 mbedtls_asn1_get_alg_null                    -     142    +142
                 __alloc_extent_buffer                        -     142    +142
                 static.pldo_set_enable                       -     141    +141
                 mbedtls_mpi_cmp_abs                          -     141    +141
                 mbedtls_mpi_mul_int                          -     138    +138
                 mbedtls_asn1_get_len                         -     133    +133
                 static.switch_get_enable                     -     130    +130
                 static.nldo_set_enable                       -     130    +130
                 static.overlay_adjust_node_phandles          -     121    +121
                 static.hash_init_sha256                     41     161    +120
                 mbedtls_mpi_grow                             -     120    +120
                 reg_set_enable                               -     118    +118
                 static.load_and_verify_vbmeta            10699   10814    +115
                 mbedtls_rsa_check_pubkey                     -     109    +109
                 static.pldo_get_enable                       -     108    +108
                 static.mbedtls_asn1_get_bitstring            -     108    +108
                 x509_get_timestamp                           -     106    +106
                 static.buck_get_suspend_value                -     101    +101
                 mbedtls_asn1_get_bool                        -      99     +99
                 static.asn1_get_sequence_of_cb               -      98     +98
                 efi_reserve_memory                           -      97     +97
                 mbedtls_rsa_info                             -      96     +96
                 static.buck_set_suspend_value                -      93     +93
                 ldo_get_enable                               -      92     +92
                 buck_get_enable                              -      92     +92
                 data_gz                                  21219   21309     +90
                 mbedtls_x509_get_serial                      -      88     +88
                 mbedtls_mpi_resize_clear                     -      87     +87
                 static.sqfs_read_entry                       -      86     +86
                 static.nldo_get_enable                       -      83     +83
                 mbedtls_mpi_bitlen                           -      82     +82
                 static.x509_get_uid                          -      81     +81
                 static.mbedtls_mpi_sub_int                   -      81     +81
                 static.pldo_set_suspend_enable               -      78     +78
                 mbedtls_oid_get_md_alg                       -      78     +78
                 ldo_set_enable                               -      77     +77
                 buck_set_enable                              -      77     +77
                 static.sqfs_count_tokens                     -      76     +76
                 static.pldo_set_value                        -      75     +75
                 static.pldo_set_suspend_value                -      75     +75
                 static.pldo_get_suspend_enable               -      75     +75
                 static.nldo_set_value                        -      75     +75
                 static.nldo_set_suspend_value                -      75     +75
                 mbedtls_mpi_cmp_int                          -      75     +75
                 find_device                                  -      75     +75
                 rsa_decrypt_wrap                             -      73     +73
                 pta_scp03_invoke_func                        -      73     +73
                 mbedtls_mpi_lset                             -      73     +73
                 sha512_put_uint64_be                         -      72     +72
                 mbedtls_md_info_from_type                    -      72     +72
                 static.sqfs_disk_read                        -      69     +69
                 static.sqfs_calc_n_blks                      -      69     +69
                 static.simple_panel_set_backlight            -      68     +68
                 ldo_get_value                                -      67     +67
                 buck_get_value                               -      67     +67
                 static.nldo_set_suspend_enable               -      65     +65
                 free_extent_state_func                       -      65     +65
                 static.nldo_get_suspend_enable               -      64     +64
                 sha1_starts                                  -      64     +64
                 mbedtls_mpi_lsb                              -      64     +64
                 rsa_alloc_wrap                               -      62     +62
                 mbedtls_pk_setup                             -      62     +62
                 pkcs7_free_message                         115     176     +61
                 static.unicode_test_u16_strcmp               -      60     +60
                 rsa_debug                                    -      60     +60
                 lib_test_strlcat                          1195    1255     +60
                 public_key_signature_free                    -      58     +58
                 static.x509_free_mbedtls_ctx                 -      57     +57
                 static.nldo_get_value                        -      57     +57
                 static.nldo_get_suspend_value                -      57     +57
                 x509_populate_dn_name_string                 -      56     +56
                 efi_tcg2_protocol                            -      56     +56
                 mbedtls_mpi_core_montmul_init                -      55     +55
                 static.pldo_get_value                        -      54     +54
                 static.pldo_get_suspend_value                -      54     +54
                 mbedtls_asn1_get_bitstring_null              -      53     +53
                 efi_launch_capsules                       3090    3142     +52
                 static.pkcs7_free_signer_info                -      51     +51
                 static.ldo_set_suspend_value                 -      51     +51
                 mbedtls_mpi_free                             -      51     +51
                 static.mbedtls_mpi_core_bigendian_to_host    -      50     +50
                 mbedtls_asn1_get_tag                         -      50     +50
                 event_log                                    -      48     +48
                 static.subM                                  -      47     +47
                 mbedtls_pk_free                              -      45     +45
                 mbedtls_zeroize_and_free                     -      42     +42
                 static.ldo_get_suspend_value                 -      38     +38
                 static.sandbox_tpm2_get_desc                 -      35     +35
                 efi_capsule_update_firmware               1354    1389     +35
                 static.simple_panel_enable_backlight         -      34     +34
                 static.efi_firmware_get_image_info         696     730     +34
                 x509_parse2_int                              -      33     +33
                 ldo_set_value                                -      32     +32
                 buck_set_value                               -      32     +32
                 static.hash_init_sha1                       75     105     +30
                 mbedtls_asn1_sequence_free                   -      30     +30
                 mbedtls_asn1_free_named_data_list_shallow    -      30     +30
                 efi_start_image                           2492    2522     +30
                 static.hash_finish_sha512                   40      66     +26
                 static.hash_finish_sha256                   40      66     +26
                 static.hash_finish_sha1                     40      66     +26
                 generic_phy_get_bulk                       366     392     +26
                 static.set_descriptors                       -      25     +25
                 reboot_mode_probe                          139     164     +25
                 static.efi_open_protocol                   495     519     +24
                 static.mbedtls_mpi_get_bit                   -      23     +23
                 sqfs_opendir                              1655    1677     +22
                 rsa_can_do                                   -      22     +22
                 efi_install_fdt                            572     594     +22
                 sha512_starts                              132     152     +20
                 mbedtls_sha512_free                          -      20     +20
                 mbedtls_sha256_free                          -      20     +20
                 mbedtls_sha1_free                            -      20     +20
                 efi_query_capsule_caps                     210     229     +19
                 static.mbedtls_platform_zeroize              -      18     +18
                 sha256_starts                               68      86     +18
                 pta_scp03_open_session                       -      18     +18
                 mbedtls_mpi_size                             -      18     +18
                 c2                                           -      18     +18
                 static.efi_cout_set_cursor_position        257     274     +17
                 rsa_get_bitlen                               -      17     +17
                 static.efi_register_notify_events            -      16     +16
                 static.efi_cout_query_mode                 241     257     +16
                 static.dfu_runtime_descs                     -      16     +16
                 static.__reset_get_bulk                    166     182     +16
                 mbedtls_sha512_init                          -      16     +16
                 efi_guid_tcg2_protocol                       -      16     +16
                 efi_guid_final_events                        -      16     +16
                 efi_file_info_guid                           -      16     +16
                 clk_get_bulk                               157     173     +16
                 efi_tcg2_set_active_pcr_banks                -      15     +15
                 efi_tcg2_get_result_of_set_active_pcr_banks  -      15     +15
                 efi_pxe_base_code_arp                        -      15     +15
                 unicode_test_utf8_utf16_strcpy             946     960     +14
                 mbedtls_mpi_add_mpi                          -      14     +14
                 c4                                           -      14     +14
                 c1                                           -      14     +14
                 efi_locate_device_path                     541     554     +13
                 efi_file_read_int                          610     623     +13
                 d4                                           -      13     +13
                 rtc_days_in_month                            -      12     +12
                 mbedtls_mpi_sub_mpi                          -      12     +12
                 i2                                           -      12     +12
                 static.efi_cin_unregister_key_notify       257     268     +11
                 efi_auth_var_get_type                      102     113     +11
                 static.count_descriptors                     -      10     +10
                 i1                                           -      10     +10
                 fdt_overlay_apply                         1887    1897     +10
                 x509_free_certificate                      115     124      +9
                 static.efi_cout_output_string              534     543      +9
                 static.efi_cin_reset_ex                    185     194      +9
                 static.efi_cin_reset                       185     194      +9
                 static.dfu_intf_runtime                      -       9      +9
                 free_map_lookup                              -       9      +9
                 static.memset_func                           -       8      +8
                 static.efi_connect_controller              685     693      +8
                 mbedtls_sha512_info                          -       8      +8
                 mbedtls_sha384_info                          -       8      +8
                 mbedtls_sha256_info                          -       8      +8
                 mbedtls_sha1_info                            -       8      +8
                 mbedtls_md5_info                             -       8      +8
                 mbedtls_ct_zero                              -       8      +8
                 i3                                           -       8      +8
                 c3                                           -       8      +8
                 unicode_test_utf8_utf16_strlen             443     450      +7
                 unicode_test_utf16_utf8_strlen             443     450      +7
                 unicode_test_utf16_utf8_strcpy            1021    1028      +7
                 static.efi_firmware_raw_set_image         2312    2319      +7
                 static.efi_cin_register_key_notify         296     303      +7
                 static.efi_cin_read_key_stroke_ex          386     393      +7
                 static.efi_cin_read_key_stroke             247     254      +7
                 pci_bus_read_config                         83      90      +7
                 mpi_bigendian_to_host                        -       7      +7
                 check_node_type                            171     178      +7
                 ta_rpc_test_open_session                     -       6      +6
                 ta_avb_open_session                          -       6      +6
                 j3                                           -       6      +6
                 efi_signature_verify                      1640    1646      +6
                 j1                                           -       5      +5
                 eficonfig_process_select_file             2179    2184      +5
                 efi_protocol_open                          408     413      +5
                 efi_dp_from_file                           274     279      +5
                 crypt_sha512crypt_rn_wrapped              2408    2413      +5
                 crypt_sha256crypt_rn_wrapped              1669    1674      +5
                 unicode_test_u16_strlen                    269     273      +4
                 static.eficonfig_edit_boot_option         1567    1571      +4
                 static.efi_purge_handle                    150     154      +4
                 static.avb_safe_memcmp                      36      40      +4
                 sqfs_find_inode                            347     351      +4
                 sqfs_dir_offset                            101     105      +4
                 pci_conv_32_to_size                         46      50      +4
                 pci_bus_find_devfn                         121     125      +4
                 fdt_subnode_offset_namelen                 240     244      +4
                 efi_unload_image                           403     407      +4
                 efi_search_obj                              43      47      +4
                 efi_delete_image                           150     154      +4
                 efi_close_protocol                         229     233      +4
                 efi_add_memory_map                          34      38      +4
                 do_bootefi_exec                            444     448      +4
                 dm_spi_release_bus                          23      27      +4
                 dm_spi_claim_bus                           153     157      +4
                 dm_pci_write_config8                        10      14      +4
                 dm_pci_write_config16                       13      17      +4
                 avb_validate_utf8                           95      99      +4
                 avb_descriptor_validate_and_byteswap        96     100      +4
                 avb_descriptor_foreach                     715     719      +4
                 avb_be64toh                                  7      11      +4
                 avb_be32toh                                  5       9      +4
                 asymmetric_key_generate_id                 109     113      +4
                 unicode_test_u16_strncmp                   377     380      +3
                 unicode_test_u16_strlcat                   840     843      +3
                 unflatten_device_tree                      274     277      +3
                 str_upper                                  648     651      +3
                 static.efi_reinstall_protocol_interface    277     280      +3
                 static.efi_exit                            668     671      +3
                 sandbox_hub_bind                            20      23      +3
                 find_handle                                314     317      +3
                 eficonfig_file_selected                    484     487      +3
                 efi_firmware_get_lsv_from_dtb              369     372      +3
                 efi_create_indexed_name                    174     177      +3
                 efi_auth_var_get_guid                       85      88      +3
                 SHA256_Update_recycled                      76      79      +3
                 unicode_test_utf8_utf16_strncpy            929     931      +2
                 unicode_test_utf16_utf8_strncpy            921     923      +2
                 static.tcg2_measure_variable               236     238      +2
                 static.efi_cout_set_mode                   222     224      +2
                 static.do_env_print                       1278    1280      +2
                 prepare_file_selection_entry               400     402      +2
                 eficonfig_boot_edit_save                    96      98      +2
                 eficonfig_add_change_boot_order_entry      346     348      +2
                 eficonfig_add_boot_selection_entry         461     463      +2
                 efi_str_to_u16                             103     105      +2
                 efi_serialize_load_option                  260     262      +2
                 efi_get_variable_mem                       492     494      +2
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
                 file_open                                  738     739      +1
                 efi_var_mem_ins                            257     258      +1
                 cros_ec_spi_command                        420     421      +1
                 efi_update_capsule                         427     426      -1
                 byteReverse                                  1       -      -1
                 static.efi_cout_set_attribute              249     247      -2
                 sha256_csum_wd                             155     153      -2
                 vidconsole_sync_copy                        13       9      -4
                 vidconsole_memmove                          51      47      -4
                 tcg2_uninit                                212     208      -4
                 static.hash_update_sha1                     29      25      -4
                 spi_find_chip_select                       440     436      -4
                 sha512_csum_wd                             169     165      -4
                 read_tree_block                           1566    1562      -4
                 read_allocated_block                      2304    2300      -4
                 put_ext4                                   383     379      -4
                 free_extent_buffer                         321     317      -4
                 ext4fs_update_journal                      893     889      -4
                 ext4fs_read_inode                          392     388      -4
                 ext4fs_devread                              34      30      -4
                 efi_init_early                            1055    1051      -4
                 cros_ec_register                           291     287      -4
                 cros_ec_calc_checksum                       27      23      -4
                 cache_tree_free_extents                     57      53      -4
                 btrfs_setup_root                           101      97      -4
                 btrfs_scan_one_device                      675     671      -4
                 btrfs_release_all_roots                     62      58      -4
                 btrfs_read_dev_super                      1228    1224      -4
                 btrfs_free_path                             38      34      -4
                 btrfs_free_fs_info                          53      49      -4
                 btrfs_close_devices                        136     132      -4
                 static.hash_update_sha512                   22      17      -5
                 static.hash_update_sha256                   22      17      -5
                 lib_test_efi_dp_check_length               593     588      -5
                 efi_stri_coll                              252     247      -5
                 cros_ec_i2c_command                        409     404      -5
                 static.ta_rpc_test_open_session              6       -      -6
                 static.ta_avb_open_session                   6       -      -6
                 efi_str_to_fat                             369     362      -7
                 static.free_map_lookup                       9       -      -9
                 efi_init_obj_list                         5665    5656      -9
                 dfu_intf_runtime                             9       -      -9
                 count_descriptors                           10       -     -10
                 rsa_verify_key                             383     372     -11
                 install_smbios_table                       583     571     -12
                 d5                                          12       -     -12
                 sha256_update                               14       -     -14
                 efi_runtime_relocate                       240     226     -14
                 x509_akid_note_name                         15       -     -15
                 static.efi_tcg2_set_active_pcr_banks        15       -     -15
                 static.efi_tcg2_get_result_of_set_active_pcr_banks      15       -     -15
                 static.efi_pxe_base_code_arp                15       -     -15
                 pkcs7_sig_note_skid                         15       -     -15
                 pkcs7_sig_note_serial                       15       -     -15
                 pkcs7_sig_note_issuer                       15       -     -15
                 static.rsapubkey_action_table               16       -     -16
                 efi_register_notify_events                  16       -     -16
                 efi_guid_event_group_return_to_efibootmgr   16       -     -16
                 efi_disk_probe                             571     555     -16
                 dfu_runtime_descs                           16       -     -16
                 static.pta_scp03_open_session               18       -     -18
                 sha384_csum_wd                             296     276     -20
                 x509_note_serial                            21       -     -21
                 tcg2_create_digest                         718     697     -21
                 static.hash_update_sha384                   22       -     -22
                 pkcs7_check_content_type                    22       -     -22
                 do_net_stats                               371     349     -22
                 x509_decoder                                24       -     -24
                 x509_akid_decoder                           24       -     -24
                 rsapubkey_decoder                           24       -     -24
                 pkcs7_decoder                               24       -     -24
                 mscode_machine                              24       -     -24
                 mscode_decoder                              24       -     -24
                 mscode_action_table                         24       -     -24
                 set_descriptors                             25       -     -25
                 efi_set_variable_int                      2130    2105     -25
                 x509_note_tbs_certificate                   26       -     -26
                 x509_note_not_before                        28       -     -28
                 x509_note_not_after                         28       -     -28
                 pkcs7_note_data                             28       -     -28
                 x509_note_issuer                            30       -     -30
                 rsa_get_n                                   30       -     -30
                 static.ldo_set_value                       113      81     -32
                 static.buck_set_value                      203     171     -32
                 _u_boot_list_2_ut_lib_test_2_lib_asn1_x509      32       -     -32
                 _u_boot_list_2_ut_lib_test_2_lib_asn1_pkey      32       -     -32
                 _u_boot_list_2_ut_lib_test_2_lib_asn1_pkcs7      32       -     -32
                 sandbox_tpm2_get_desc                       35       -     -35
                 x509_note_subject                           36       -     -36
                 pkcs7_note_content                          36       -     -36
                 simple_panel_enable_backlight               37       -     -37
                 sha1_csum_wd                               209     171     -38
                 ldo_get_suspend_value                       38       -     -38
                 x509_akid_action_table                      40       -     -40
                 static.hash_finish_sha384                   40       -     -40
                 x509_note_params                            41       -     -41
                 pkcs7_note_signeddata_version               41       -     -41
                 asn1_op_lengths                             41       -     -41
                 subM                                        43       -     -43
                 efi_esrt_populate                         1209    1165     -44
                 ZSTD_decompressDCtx                       7789    7745     -44
                 pkcs7_note_certificate_list                 46       -     -46
                 static.public_key_signature_free            48       -     -48
                 static.event_log                            48       -     -48
                 mscode_note_digest                          51       -     -51
                 ldo_set_suspend_value                       51       -     -51
                 pldo_get_value                              54       -     -54
                 pldo_get_suspend_value                      54       -     -54
                 unicode_test_u16_strcmp                     56       -     -56
                 static.efi_tcg2_protocol                    56       -     -56
                 rsa_get_e                                   56       -     -56
                 nldo_get_value                              57       -     -57
                 nldo_get_suspend_value                      57       -     -57
                 x509_extract_name_segment                   62       -     -62
                 sha256_padding                              64       -     -64
                 sha1_padding                                64       -     -64
                 nldo_get_suspend_enable                     64       -     -64
                 static.free_extent_state_func               65       -     -65
                 sqfs_disk_read                              65       -     -65
                 sqfs_calc_n_blks                            65       -     -65
                 nldo_set_suspend_enable                     65       -     -65
                 static.ldo_get_value                       133      66     -67
                 static.buck_get_value                      196     129     -67
                 simple_panel_set_backlight                  68       -     -68
                 pkcs7_sig_note_signature                    68       -     -68
                 static.__func__                          32530   32459     -71
                 sqfs_count_tokens                           72       -     -72
                 pkcs7_sig_note_set_of_authattrs             72       -     -72
                 static.pta_scp03_invoke_func                73       -     -73
                 pldo_set_value                              75       -     -75
                 pldo_set_suspend_value                      75       -     -75
                 pldo_get_suspend_enable                     75       -     -75
                 pkcs7_sig_note_pkey_algo                    75       -     -75
                 nldo_set_value                              75       -     -75
                 nldo_set_suspend_value                      75       -     -75
                 static.ldo_set_enable                      370     293     -77
                 static.buck_set_enable                     482     405     -77
                 pldo_set_suspend_enable                     78       -     -78
                 static.find_device                          79       -     -79
                 pkcs7_note_signerinfo_version               79       -     -79
                 x509_akid_note_kid                          80       -     -80
                 x509_akid_note_serial                       81       -     -81
                 pkcs7_extract_cert                          81       -     -81
                 sqfs_read_entry                             82       -     -82
                 nldo_get_enable                             83       -     -83
                 sha512_finish                              123      32     -91
                 sha384_finish                              123      32     -91
                 static.ldo_get_enable                      386     294     -92
                 static.buck_get_enable                     443     351     -92
                 x509_akid_machine                           93       -     -93
                 buck_set_suspend_value                      93       -     -93
                 x509_extract_key_data                       98       -     -98
                 static.efi_reserve_memory                  101       -    -101
                 buck_get_suspend_value                     101       -    -101
                 x509_action_table                          104       -    -104
                 x509_note_OID                              105       -    -105
                 pldo_get_enable                            108       -    -108
                 x509_machine                               113       -    -113
                 overlay_adjust_node_phandles               117       -    -117
                 static.reg_set_enable                      118       -    -118
                 x509_process_extension                     125       -    -125
                 x509_note_signature                        129       -    -129
                 switch_get_enable                          130       -    -130
                 nldo_set_enable                            130       -    -130
                 pkcs7_note_OID                             136       -    -136
                 pkcs7_action_table                         136       -    -136
                 pldo_set_enable                            141       -    -141
                 static.__alloc_extent_buffer               146       -    -146
                 switch_set_enable                          150       -    -150
                 oid_index                                  150       -    -150
                 static.hash_init_sha384                    152       -    -152
                 sha512_base_do_finalize                    154       -    -154
                 unregister_package_notify                  169       -    -169
                 duplicate_device_path                      180       -    -180
                 ldo_get_suspend_enable                     182       -    -182
                 pkcs7_note_signed_info                     187       -    -187
                 append_device_node                         188       -    -188
                 mscode_note_content_type                   189       -    -189
                 pkcs7_sig_note_digest_algo                 190       -    -190
                 append_device_path                         190       -    -190
                 get_device_path_size                       191       -    -191
                 efi_open_volume                            191       -    -191
                 static.sha256_update                       194       -    -194
                 static.sha512_base_do_update               195       -    -195
                 ldo_set_suspend_enable                     195       -    -195
                 set_keyboard_layout                        196       -    -196
                 sqfs_tokenize                              197       -    -197
                 montMul                                    198       -    -198
                 is_device_path_multi_instance              201       -    -201
                 usb_emul_find_devnum                       206       -    -206
                 export_package_lists                       206       -    -206
                 look_up_OID                                207       -    -207
                 remove_package_list                        208       -    -208
                 dfu_handle                                 213       -    -213
                 static.sha1_update                         216       -    -216
                 overlay_get_target                         220       -    -220
                 register_package_notify                    222       -    -222
                 create_device_node                         222       -    -222
                 dm_pciauto_exp_link_stable                 227       -    -227
                 get_package_list_handle                    231       -    -231
                 pkcs7_machine                              239       -    -239
                 static.sprint_oid                          241       -    -241
                 lib_asn1_pkcs7                             244       -    -244
                 sha256_k                                   256       -    -256
                 buck_set_suspend_enable                    264       -    -264
                 pkcs7_sig_note_authenticated_attr          268       -    -268
                 static.efi_tcg2_get_active_pcr_banks       273       -    -273
                 buck_get_suspend_enable                    276       -    -276
                 sha1_finish                                288       -    -288
                 lib_asn1_pkey                              290       -    -290
                 get_next_device_path_instance              290       -    -290
                 x509_note_pkey_algo                        291       -    -291
                 static.spi_set_speed_mode                  291       -    -291
                 efi_convert_device_node_to_text            293       -    -293
                 oid_search_table                           296       -    -296
                 get_secondary_languages                    301       -    -301
                 append_device_path_instance                311       -    -311
                 static.efi_tcg2_notify_exit_boot_services     316       -    -316
                 sha256_finish                              357      32    -325
                 mscode_note_digest_algo                    327       -    -327
                 find_keyboard_layouts                      339       -    -339
                 static.efi_tcg2_submit_command             351       -    -351
                 get_keyboard_layout                        355       -    -355
                 new_package_list                           359       -    -359
                 efi_disconnect_all_drivers                 359       -    -359
                 efi_convert_device_path_to_text            359       -    -359
                 get_string                                 526     166    -360
                 static.efi_tcg2_get_eventlog               361       -    -361
                 update_package_list                        374       -    -374
                 efi_uninstall_protocol                     396       -    -396
                 list_package_lists                         398       -    -398
                 get_languages                              402       -    -402
                 static.load_full_partition                 417       -    -417
                 lib_asn1_x509                              423       -    -423
                 static.x509_fabricate_name                 428       -    -428
                 static.longest_match                       428       -    -428
                 set_string                                 448       -    -448
                 new_string                                 450       -    -450
                 static.find_and_setup_root                 460       -    -460
                 static.efi_tcg2_get_capability             462       -    -462
                 overlay_update_local_node_references       479       -    -479
                 sqfs_resolve_symlink                       505       -    -505
                 oid_data                                   513       -    -513
                 static.public_key                          540       -    -540
                 sqfs_frag_lookup                           601       -    -601
                 static.efi_tcg2_hash_log_extend_event      622       -    -622
                 dfu_bind                                   637       -    -637
                 dm_pciauto_setup_device                    743       -    -743
                 static.x509_decode_time                    779       -    -779
                 static.ta_avb_invoke_func                  783       -    -783
                 x509_cert_parse                            973     179    -794
                 static.ta_rpc_test_invoke_func             812       -    -812
                 static.read_persistent_digest              829       -    -829
                 pci_uclass_pre_probe                       832       -    -832
                 cert_data                                  971       -    -971
                 sqfs_search_dir                           1332       -   -1332
                 simple_panel_get_edid_timing              1381       -   -1381
                 asn1_ber_decoder                          1511       -   -1511
                 static.read_one_chunk                     1610       -   -1610
                 rsa_verify_with_pkey                      1680       -   -1680
                 static.run_test                           1710       -   -1710
                 sha512_block_fn                           1714       -   -1714
                 image_pk7                                 1811       -   -1811
                 MD5Transform                              1812       -   -1812
                 sandbox_tpm2_xfer                         2605       -   -2605
                 pci_uclass_post_probe                     3570       -   -3570
                 sha1_process_one                          8090       -   -8090
                 sha256_process_one                        9972       -   -9972
```

Raymond Mao (28):
  CI: Exclude MbedTLS subtree for CONFIG checks
  mbedtls: add mbedtls into the build system
  lib: Adapt digest header files to MbedTLS
  md5: Remove md5 non-watchdog API
  sha1: Remove sha1 non-watchdog API
  mbedtls: add digest shim layer for MbedTLS
  hash: integrate hash on mbedtls
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
 common/hash.c                                 | 146 +++++
 configs/qemu_arm64_defconfig                  |   1 +
 configs/sandbox_defconfig                     |   1 +
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
 lib/Makefile                                  |  14 +-
 lib/crypto/Kconfig                            |   2 +-
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
 lib/mbedtls/mbedtls_def_config.h              |  75 +++
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
 53 files changed, 2849 insertions(+), 232 deletions(-)
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

