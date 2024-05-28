Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46556C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 14:10:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B39F8842A;
	Tue, 28 May 2024 16:10:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jSsqtZTn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE61788431; Tue, 28 May 2024 16:10:10 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F385D87D70
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7930531494aso49950485a.0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 07:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905406; x=1717510206; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8WtG2WPwJPnFXCUVxNuBu7nOFdxR7M/5sxvAFpf+EJE=;
 b=jSsqtZTnwX3wo1K3iM9ZS5R1GZfLFXmUg2TP6D2WPS7MgTLxaQtzlBK5jUrC6DP4+w
 yUb3BSrHoKbVj5vqJDqqj0RKQDB2RY+iF9YS2x5x+Ab4afcwf2lbQzMttXETr5YYraEG
 Vr8K0XIHLsJTO978WAhtaUBN/Kf1OuIJ/s4x9LGiRHZ+seM/Gcuos1zeJ1Lbp2ubHuIX
 knva8UTOnePdHcYXoj9M3EL9b/3cWJVabK+VNB67WTOd2z2Fw65UD+/t6pnZzU5I9K30
 xQLt37x8fdqw51EVdekj8UhDMVfaPFimYsH6fsgDWbigsh9q0UfgXEhPK/fJt+fO7ZMU
 +Iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905406; x=1717510206;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8WtG2WPwJPnFXCUVxNuBu7nOFdxR7M/5sxvAFpf+EJE=;
 b=F1bzj50JPqtMQI2xxCrbMG3aszpsdvHpG83wodfATdwGeSXwQLii3MPsp1RTxy4sE2
 3ufldOYdldk8fsleZjxYr5emk+rlQFWWQDtBV8xb05TQ/ndNueZ4gROYlzba396dZsym
 ypvgsX9EU7MuFe4a9ftMqLuQUN1fJ58MvQ+pzrswn2ebpLQW+nEttj+F+m7SFfa9nG+A
 HaN5Gikw1JBCWPzZweLh+raavKV8dJrWWe4ZHa06t8mF0WjQXYD8xc5BJ6RfhAbzVgT4
 A4lJSmEmRMr+QZmE/WQu7wS/wTZuLcHQ+Vw/3DT6pXQojZt2cFW5Qci2Ie85UUHAwCU+
 g/cA==
X-Gm-Message-State: AOJu0YzppYjOY2+H8EMwDZmNonQcbabM5+xVS2H58jX5heqF1dIKzT9i
 Z3OrmjViwHNyQj80xWzf2iPYzYHrtgWo2Blgr3GukmmclPHQi8pAYDoCSgAbOhTkdURssfmpThE
 xm4g=
X-Google-Smtp-Source: AGHT+IGO69sFZ1u5m3cL799jbZpru4Mrmafafn4eYHy4gmSnv1EZ5pRmb21714ZcQ6RzVxwdK/N7bA==
X-Received: by 2002:a05:620a:40ca:b0:792:741b:3a27 with SMTP id
 af79cd13be357-794ab111e66mr1486260585a.53.1716905406169; 
 Tue, 28 May 2024 07:10:06 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abcc5844sm381033685a.53.2024.05.28.07.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:10:05 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ilya Lukin <4.shket@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v3 00/25] [RFC] Integrate MbedTLS v3.6 LTS with U-Boot
Date: Tue, 28 May 2024 07:09:11 -0700
Message-Id: <20240528140955.1960172-1-raymond.mao@linaro.org>
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

Integrate MbedTLS v3.6 LTS (currently v3.6.0-RC1) with U-Boot.

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
`MBEDTLS_LIB_TLS` is for SSL/TLS (Disabled until LWIP port for MbedTLS is
ready)
In this patch set, MBEDTLS_LIB, MBEDTLS_LIB_CRYPTO and MBEDTLS_LIB_X509
are by default enabled in qemu_arm64_defconfig for testing purpose.

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
For v3, the size-growth is slightly reduced by refactoring Hash functions.

Target(QEMU arm64) size-growth when enabling MbedTLS:
v1: 6.03%
v2: 4.66%
v3: 4.55%

Please see the latest output of bloat-o-meter for the reference of the
size-growth on QEMU arm64 target [1].

Tests done:
-----------

EFI Secure Boot test (EFI variables loading and verifying, EFI signed image
verifying and booting) via U-Boot console.
EFI Secure Boot and Capsule sandbox test passed.

Known issues:
-------------

None.

[1]: bloat-o-meter output between disabling/enabling MbedTLS (QEMU arm64)
```
add/remove: 206/81 grow/shrink: 19/17 up/down: 55548/-17495 (38053)
Function                                     old     new   delta
mbedtls_internal_sha1_process                  -    4540   +4540
mbedtls_x509_crt_parse_der_internal            -    3072   +3072
mbedtls_internal_md5_process                   -    2928   +2928
mbedtls_internal_sha256_process                -    2052   +2052
mbedtls_pkcs7_parse_der                        -    1608   +1608
mbedtls_rsa_private                            -    1468   +1468
pkcs7_parse_message                          372    1648   +1276
mbedtls_mpi_div_mpi                            -    1168   +1168
mbedtls_internal_sha512_process                -    1056   +1056
mbedtls_mpi_inv_mod                            -    1000   +1000
mbedtls_x509_dn_gets                           -     996    +996
x509_populate_cert                             -     948    +948
K                                              -     896    +896
oid_x520_attr_type                             -     840    +840
__udivti3                                      -     832    +832
mbedtls_x509_parse_subject_alt_name            -     724    +724
mbedtls_rsa_deduce_primes                      -     720    +720
mbedtls_mpi_exp_mod                            -     668    +668
mbedtls_rsa_rsaes_pkcs1_v15_decrypt            -     652    +652
pkcs7_get_signer_info                          -     632    +632
mbedtls_rsa_complete                           -     624    +624
mbedtls_rsa_validate_params                    -     608    +608
mbedtls_mpi_core_exp_mod                       -     560    +560
mbedtls_sha512_finish                          -     556    +556
mscode_parse                                  28     580    +552
mbedtls_x509_get_time                          -     552    +552
mbedtls_x509_get_name                          -     516    +516
mbedtls_sha256_finish                          -     484    +484
mbedtls_rsa_validate_crt                       -     464    +464
mbedtls_mpi_core_mla                           -     460    +460
rsa_rsassa_pkcs1_v15_encode                    -     420    +420
mbedtls_sha1_finish                            -     420    +420
mbedtls_mpi_gcd                                -     400    +400
oid_x509_ext                                   -     360    +360
rsa_parse_pub_key                             24     372    +348
mbedtls_x509_get_subject_alt_name_ext          -     348    +348
mbedtls_sha512_starts                          -     340    +340
mbedtls_mpi_mul_mpi                            -     340    +340
mbedtls_rsa_rsassa_pkcs1_v15_sign              -     336    +336
mbedtls_oid_get_numeric_string                 -     336    +336
mbedtls_md5_finish                             -     336    +336
mbedtls_pk_parse_subpubkey                     -     328    +328
oid_sig_alg                                    -     320    +320
mbedtls_rsa_deduce_private_exponent            -     312    +312
rsa_check_context.isra                         -     300    +300
mbedtls_rsa_rsaes_pkcs1_v15_encrypt            -     288    +288
mbedtls_rsa_parse_pubkey                       -     284    +284
mbedtls_mpi_sub_abs                            -     284    +284
mbedtls_mpi_core_montmul                       -     276    +276
mbedtls_rsa_rsassa_pkcs1_v15_verify            -     268    +268
mbedtls_asn1_traverse_sequence_of              -     268    +268
mbedtls_sha512_update                          -     264    +264
mbedtls_asn1_get_alg                           -     256    +256
mbedtls_sha256_update                          -     252    +252
mbedtls_mpi_add_abs                            -     248    +248
oid_md_alg                                     -     240    +240
mbedtls_sha1_update                            -     236    +236
mbedtls_rsa_deduce_crt                         -     236    +236
mbedtls_md5_update                             -     236    +236
mbedtls_rsa_import_raw                         -     232    +232
mbedtls_ct_memcpy_if                           -     228    +228
mbedtls_mpi_copy                               -     220    +220
mbedtls_mpi_cmp_mpi                            -     212    +212
mbedtls_mpi_shrink                             -     208    +208
mbedtls_ct_memmove_left                        -     208    +208
mbedtls_rsa_public                             -     204    +204
rsa_sign_wrap                                  -     196    +196
mbedtls_pk_parse_public_key                    -     196    +196
asn1_get_tagged_int                            -     196    +196
mbedtls_mpi_mul_int                            -     184    +184
mbedtls_mpi_core_write_be                      -     184    +184
mbedtls_pk_verify_restartable                  -     180    +180
mbedtls_mpi_mod_mpi                            -     180    +180
mbedtls_asn1_get_len                           -     180    +180
pk_get_pk_alg.isra                             -     176    +176
mbedtls_mpi_core_fill_random                   -     176    +176
x509_populate_pubkey                           -     164    +164
rsa_verify_wrap                                -     164    +164
mbedtls_x509_crt_free                          -     164    +164
mbedtls_mpi_core_shift_r                       -     164    +164
oid_pk_alg                                     -     160    +160
mbedtls_ct_zeroize_if                          -     156    +156
rsa_encrypt_wrap                               -     152    +152
rsa_decrypt_wrap                               -     152    +152
mbedtls_mpi_cmp_abs                            -     152    +152
add_sub_mpi                                    -     152    +152
mbedtls_sha512                                 -     148    +148
mbedtls_rsa_check_privkey                      -     148    +148
mbedtls_mpi_core_shift_l                       -     148    +148
mbedtls_x509_get_ext                           -     144    +144
mbedtls_mpi_grow                               -     144    +144
mbedtls_mpi_core_read_be                       -     144    +144
mbedtls_x509_get_serial                        -     140    +140
mbedtls_asn1_write_len                         -     140    +140
pkcs7_get_one_cert                             -     136    +136
mbedtls_x509_crl_free                          -     136    +136
mbedtls_rsa_free                               -     136    +136
mbedtls_rsa_check_pubkey                       -     136    +136
mbedtls_x509_get_key_usage                     -     128    +128
mbedtls_asn1_get_bitstring                     -     128    +128
mbedtls_sha256_starts                          -     124    +124
mbedtls_mpi_core_mul                           -     124    +124
mbedtls_asn1_get_alg_null                      -     124    +124
mbedtls_x509_get_sig                           -     120    +120
mbedtls_pkcs7_free                             -     120    +120
mbedtls_oid_get_x509_ext_type                  -     120    +120
mbedtls_oid_get_pk_alg                         -     120    +120
mbedtls_oid_get_md_alg                         -     120    +120
mbedtls_oid_get_attr_short_name                -     120    +120
mbedtls_x509_get_subject_alt_name              -     116    +116
asn1_get_sequence_of_cb                        -     116    +116
mbedtls_x509_get_sig_alg                       -     112    +112
mbedtls_x509_get_ns_cert_type                  -     108    +108
mbedtls_mpi_resize_clear                       -     108    +108
mbedtls_mpi_lset                               -     108    +108
mbedtls_mpi_fill_random                        -     108    +108
mbedtls_asn1_get_sequence_of                   -     108    +108
mbedtls_mpi_core_get_mont_r2_unsafe            -     104    +104
oid_sig_alg_from_asn1                          -     100    +100
mbedtls_mpi_shift_l                            -     100    +100
public_key_verify_signature                  312     408     +96
mbedtls_rsa_info                               -      96     +96
mbedtls_pk_setup                               -      96     +96
mbedtls_mpi_read_binary                        -      96     +96
mbedtls_rsa_check_pub_priv                     -      92     +92
mbedtls_mpi_lsb                                -      92     +92
mbedtls_asn1_get_bool                          -      92     +92
mbedtls_mpi_core_bigendian_to_host             -      84     +84
mbedtls_mpi_core_bitlen                        -      76     +76
mbedtls_asn1_get_bitstring_null                -      76     +76
x509_free_mbedtls_ctx.part                     -      72     +72
mbedtls_sha1_starts                            -      72     +72
mbedtls_mpi_core_cond_assign                   -      72     +72
hash_init_sha512                              52     124     +72
hash_init_sha256                              52     124     +72
CSWTCH                                      1266    1338     +72
x509_populate_dn_name_string                   -      68     +68
mbedtls_pk_free                                -      68     +68
mbedtls_oid_get_sig_alg                        -      68     +68
mbedtls_mpi_free                               -      68     +68
mbedtls_mpi_core_sub                           -      68     +68
mbedtls_mpi_core_check_zero_ct                 -      68     +68
pkcs7_free_signer_info                         -      64     +64
pkcs7_free_message                           124     188     +64
mbedtls_oid_get_oid_by_md                      -      64     +64
rsa_debug                                      -      60     +60
mbedtls_mpi_sub_int                            -      60     +60
mbedtls_mpi_core_add                           -      60     +60
mbedtls_mpi_cmp_int                            -      60     +60
mbedtls_mpi_add_int                            -      60     +60
mbedtls_md5_starts                             -      60     +60
mbedtls_platform_zeroize                       -      56     +56
mbedtls_asn1_get_tag                           -      56     +56
hash_init_sha1                                52     108     +56
rsa_alloc_wrap                                 -      52     +52
mbedtls_mpi_shift_r                            -      52     +52
mbedtls_mpi_core_montmul_init                  -      52     +52
mbedtls_mpi_core_from_mont_rep                 -      52     +52
mbedtls_mpi_core_clz                           -      52     +52
mbedtls_ct_memcmp                              -      52     +52
mbedtls_mpi_core_sub_int                       -      48     +48
mbedtls_asn1_write_tag                         -      48     +48
mbedtls_asn1_sequence_free                     -      48     +48
mbedtls_asn1_free_named_data_list_shallow       -      48     +48
mbedtls_rsa_init                               -      44     +44
mbedtls_mpi_get_bit                            -      44     +44
x509_parse2_int                                -      40     +40
mbedtls_zeroize_and_free                       -      40     +40
mbedtls_rsa_pkcs1_verify                       -      40     +40
mbedtls_rsa_pkcs1_sign                         -      40     +40
mbedtls_mpi_core_exp_mod_working_limbs         -      40     +40
rsa_free_wrap                                  -      36     +36
mbedtls_md_info_from_type                      -      36     +36
mbedtls_x509_get_alg                           -      32     +32
mbedtls_pk_get_type                            -      28     +28
mbedtls_mpi_size                               -      28     +28
mbedtls_mpi_core_to_mont_rep                   -      28     +28
x509_get_timestamp                             -      24     +24
mbedtls_x509_free_subject_alt_name             -      24     +24
mbedtls_rsa_pkcs1_encrypt                      -      20     +20
mbedtls_rsa_pkcs1_decrypt                      -      20     +20
mbedtls_pk_info_from_type                      -      20     +20
mbedtls_mpi_write_binary                       -      20     +20
mbedtls_md_get_size                            -      20     +20
rsa_can_do                                     -      16     +16
mbedtls_x509_crt_parse_der                     -      16     +16
mbedtls_sha512_free                            -      16     +16
mbedtls_sha256_free                            -      16     +16
mbedtls_sha1_free                              -      16     +16
mbedtls_mpi_init                               -      16     +16
mbedtls_md5_free                               -      16     +16
hash_finish_sha512                            72      88     +16
hash_finish_sha256                            72      88     +16
hash_finish_sha1                              72      88     +16
x509_free_certificate                         88     100     +12
sha512_csum_wd                                68      80     +12
sha256_csum_wd                                68      80     +12
sha1_csum_wd                                  68      80     +12
rsa_check_pair_wrap                            -      12     +12
md5_wd                                        68      80     +12
mbedtls_x509_crt_init                          -      12     +12
mbedtls_sha512_init                            -      12     +12
mbedtls_sha256_init                            -      12     +12
mbedtls_sha1_init                              -      12     +12
mbedtls_pkcs7_init                             -      12     +12
mbedtls_mpi_bitlen                             -      12     +12
mbedtls_md5_init                               -      12     +12
mbedtls_asn1_get_int                           -      12     +12
rsa_get_bitlen                                 -       8      +8
mpi_bigendian_to_host                          -       8      +8
memset_func                                    -       8      +8
mbedtls_sha512_info                            -       8      +8
mbedtls_sha384_info                            -       8      +8
mbedtls_sha256_info                            -       8      +8
mbedtls_sha1_info                              -       8      +8
mbedtls_rsa_get_len                            -       8      +8
mbedtls_rsa_get_bitlen                         -       8      +8
mbedtls_pk_verify                              -       8      +8
mbedtls_pk_init                                -       8      +8
mbedtls_mpi_sub_mpi                            -       8      +8
mbedtls_mpi_add_mpi                            -       8      +8
mbedtls_md5_info                               -       8      +8
mbedtls_ct_zero                                -       8      +8
sha512_update                                  4       8      +4
sha384_update                                  4       8      +4
sha256_update                                 12       8      -4
sha1_update                                   12       8      -4
rsapubkey_machine                             10       -     -10
x509_note_not_before                          12       -     -12
x509_note_not_after                           12       -     -12
month_lengths                                 12       -     -12
x509_akid_note_name                           16       -     -16
sha256_process                                16       -     -16
sha1_process                                  16       -     -16
rsapubkey_action_table                        16       -     -16
pkcs7_sig_note_skid                           16       -     -16
pkcs7_sig_note_serial                         16       -     -16
pkcs7_sig_note_issuer                         16       -     -16
pkcs7_check_content_type                      20       -     -20
hash_update_sha512                            36      16     -20
hash_update_sha256                            36      16     -20
hash_update_sha1                              36      16     -20
MD5Init                                       56      36     -20
x509_note_serial                              24       -     -24
x509_decoder                                  24       -     -24
x509_akid_decoder                             24       -     -24
sha1_starts                                   60      36     -24
rsapubkey_decoder                             24       -     -24
pkcs7_decoder                                 24       -     -24
mscode_machine                                24       -     -24
mscode_decoder                                24       -     -24
mscode_action_table                           24       -     -24
x509_note_subject                             28       -     -28
x509_note_issuer                              28       -     -28
x509_note_tbs_certificate                     32       -     -32
pkcs7_note_data                               32       -     -32
rsa_get_n                                     36       -     -36
hash_update_sha384                            36       -     -36
x509_note_params                              40       -     -40
x509_akid_action_table                        40       -     -40
pkcs7_note_content                            40       -     -40
asn1_op_lengths                               41       -     -41
rsa_get_e                                     48       -     -48
pkcs7_note_signeddata_version                 48       -     -48
pkcs7_note_certificate_list                   48       -     -48
hash_init_sha384                              52       -     -52
sha384_csum_wd                                68      12     -56
sha256_starts                                104      40     -64
sha256_padding                                64       -     -64
sha1_padding                                  64       -     -64
mscode_note_digest                            72       -     -72
hash_finish_sha384                            72       -     -72
pkcs7_sig_note_set_of_authattrs               84       -     -84
x509_note_OID                                 92       -     -92
x509_akid_note_serial                         92       -     -92
x509_akid_note_kid                            92       -     -92
pkcs7_sig_note_pkey_algo                      92       -     -92
x509_akid_machine                             93       -     -93
x509_extract_name_segment                     96       -     -96
pkcs7_note_signerinfo_version                 96       -     -96
pkcs7_sig_note_signature                     100       -    -100
x509_action_table                            104       -    -104
x509_machine                                 113       -    -113
x509_extract_key_data                        116       -    -116
sha512_finish                                152      36    -116
pkcs7_note_OID                               116       -    -116
pkcs7_extract_cert                           116       -    -116
sha512_starts                                168      40    -128
sha384_starts                                168      40    -128
mscode_note_content_type                     132       -    -132
pkcs7_action_table                           136       -    -136
sha384_finish                                152       4    -148
oid_index                                    150       -    -150
MD5Final                                     196      44    -152
sha512_base_do_finalize                      160       -    -160
x509_process_extension                       168       -    -168
x509_note_signature                          172       -    -172
pkcs7_note_signed_info                       216       -    -216
sha256_update.part                           228       -    -228
pkcs7_machine                                239       -    -239
sha1_update.part                             240       -    -240
sha512_base_do_update                        244       -    -244
pkcs7_sig_note_digest_algo                   244       -    -244
look_up_OID                                  244       -    -244
sprint_oid                                   260       -    -260
MD5Update                                    260       -    -260
sha1_finish                                  300      36    -264
mscode_note_digest_algo                      280       -    -280
oid_search_table                             296       -    -296
x509_cert_parse                              408     108    -300
x509_get_sig_params                          304       -    -304
pkcs7_sig_note_authenticated_attr            316       -    -316
x509_note_pkey_algo                          336       -    -336
sha256_finish                                404      36    -368
sha256_armv8_ce_process                      428       -    -428
x509_fabricate_name.isra                     460       -    -460
sha1_armv8_ce_process                        484       -    -484
oid_data                                     513       -    -513
sha512_K                                     640       -    -640
x509_decode_time                             672       -    -672
sha512_block_fn                             1212       -   -1212
asn1_ber_decoder                            1480       -   -1480
MD5Transform                                2552       -   -2552
Total: Before=836401, After=874454, chg +4.55%
```

Raymond Mao (25):
  CI: Exclude MbedTLS subtree for CONFIG checks
  mbedtls: Add script to update MbedTLS subtree
  mbedtls: add mbedtls into the build system
  lib: Adapt digest header files to MbedTLS
  md5: Remove md5 non-watchdog API
  mbedtls: add digest shim layer for MbedTLS
  hash: integrate hash on mbedtls
  makefile: add mbedtls include directories
  mbedtls/external: support Microsoft Authentication Code
  mbedtls/external: support PKCS9 Authenticate Attributes
  mbedtls/external: support decoding multiple signer's cert
  mbedtls/external: update MbedTLS PKCS7 test suites
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
  asn1_decoder: remove ASN1 decoder when using MbedTLS
  test: Remove ASN1 library test
  configs: enable MbedTLS as default setting

 .azure-pipelines.yml                          |    3 +-
 .gitlab-ci.yml                                |    3 +-
 Makefile                                      |    6 +
 board/friendlyarm/nanopi2/board.c             |    3 +-
 board/intel/edison/edison.c                   |    3 +-
 board/xilinx/zynq/bootimg.c                   |    2 +-
 common/hash.c                                 |  143 +
 configs/qemu_arm64_defconfig                  |    5 +
 configs/sandbox_defconfig                     |    4 +
 include/crypto/mscode.h                       |    4 +
 include/crypto/pkcs7_parser.h                 |   56 +
 include/crypto/public_key.h                   |    6 +
 include/crypto/x509_parser.h                  |   36 +
 include/stdlib.h                              |    1 +
 include/u-boot/md5.h                          |   14 +-
 include/u-boot/sha1.h                         |   25 +-
 include/u-boot/sha256.h                       |   20 +
 include/u-boot/sha512.h                       |   22 +-
 lib/Kconfig                                   |    4 +
 lib/Makefile                                  |   10 +-
 lib/crypto/Makefile                           |   12 +-
 lib/crypto/asymmetric_type.c                  |    2 +-
 lib/crypto/x509_public_key.c                  |    4 +
 lib/mbedtls/Kconfig                           |   25 +
 lib/mbedtls/Makefile                          |  132 +
 .../external/mbedtls/include/mbedtls/oid.h    |   35 +
 .../external/mbedtls/include/mbedtls/pkcs7.h  |   21 +
 lib/mbedtls/external/mbedtls/library/pkcs7.c  |  154 +-
 .../tests/suites/test_suite_pkcs7.data        |    4 +-
 lib/mbedtls/mbedtls_def_config.h              | 4262 +++++++++++++++++
 lib/mbedtls/md5.c                             |   59 +
 lib/mbedtls/mscode_parser.c                   |  111 +
 lib/mbedtls/pkcs7_parser.c                    |  533 +++
 lib/mbedtls/port/assert.h                     |   12 +
 lib/mbedtls/port/limits.h                     |   33 +
 lib/mbedtls/public_key.c                      |  105 +
 lib/mbedtls/rsa_helper.c                      |   99 +
 lib/mbedtls/sha1.c                            |  111 +
 lib/mbedtls/sha256.c                          |   65 +
 lib/mbedtls/sha512.c                          |   96 +
 lib/mbedtls/update-mbedtls-subtree.sh         |   50 +
 lib/mbedtls/x509_cert_parser.c                |  497 ++
 lib/md5.c                                     |   15 -
 test/Kconfig                                  |    2 +-
 44 files changed, 6734 insertions(+), 75 deletions(-)
 create mode 100644 lib/mbedtls/Kconfig
 create mode 100644 lib/mbedtls/Makefile
 create mode 100644 lib/mbedtls/mbedtls_def_config.h
 create mode 100644 lib/mbedtls/md5.c
 create mode 100644 lib/mbedtls/mscode_parser.c
 create mode 100644 lib/mbedtls/pkcs7_parser.c
 create mode 100644 lib/mbedtls/port/assert.h
 create mode 100644 lib/mbedtls/port/limits.h
 create mode 100644 lib/mbedtls/public_key.c
 create mode 100644 lib/mbedtls/rsa_helper.c
 create mode 100644 lib/mbedtls/sha1.c
 create mode 100644 lib/mbedtls/sha256.c
 create mode 100644 lib/mbedtls/sha512.c
 create mode 100755 lib/mbedtls/update-mbedtls-subtree.sh
 create mode 100644 lib/mbedtls/x509_cert_parser.c

-- 
2.25.1

