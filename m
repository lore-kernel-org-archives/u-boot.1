Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33839FCC055
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 18:13:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37005838BB;
	Fri,  6 Mar 2026 19:13:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VFg9pbM/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2A1283F1F; Fri,  6 Mar 2026 19:13:33 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A2908382A
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 19:13:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-8cb38e86cf2so1009601585a.1
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 10:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772820807; x=1773425607; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1WV3XKEgpagTCVNXO7zvMLz1QxM1N4pjG9eDgp/QvZ4=;
 b=VFg9pbM/q0YyFUFjji9qnGIGXj+3cXGDHwdoMxqB2LZEr/W4Jq/g9iLZdy1XgpQaEt
 pTTrHM4UhuTdX81ogHW1SBjkSpWospaPCFRAxOBCyPtDS0QuXGa/kDs/vhy/IAaV+jph
 XH9kesuNr2k81qIwTlJ6fRG1eDmv+uaIPgzLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772820807; x=1773425607;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1WV3XKEgpagTCVNXO7zvMLz1QxM1N4pjG9eDgp/QvZ4=;
 b=lt/bDR5+JMCoLs12FEWvEN8DA8G+VVro5CCHwjJU5FA0djfFGjltcM4UEri/Uv1isW
 eoqWljZM0HLhqQdwC6PCpSTr6rPLuMezNEtx0CYUFFel70u2AUPeMXkigUmr+cqr1vz/
 kr1RIkxA9rxZhPKTv/JR/x7Blecj2Dj4aPHFoVDopVpFrcYn3leuQYxAQq1wnvmHdfl/
 HwO+r1TVXjFUbSMh8hJcj2fJwd2ACqu8a3VEmCrARZ+fU6A2Sp/ct+Dgx+WRNhRycDrd
 vgAv0dJpJfqvpD2K+9sEYS4DskZfkDkUl9hJNRST4ukZ60HbMAI/Vxf/M/AAknLniMrF
 B30Q==
X-Gm-Message-State: AOJu0Yyc3BO/8Ytgok0R3ryLBSOQ5pAyhkloS489YvI2emvIyciO50wK
 MRkPaUr3vkhPmHBNHZ/l0WLIRx81FTBtPLNvl4UjnJ6BxyiZ1swQSV7LC320rw+1H9wMQX2AUEL
 8gvw=
X-Gm-Gg: ATEYQzyGWUaLyOzTZ01Quw2OK83U1qhmcrm6xT3UJn29Bum2tBYbpGoEiYf09d40eGh
 8NkykDHpfeu2jZ7boMrM3KcQwIFsfSf/QACemDiqB9VPRYfDOOeGsca56J5qhl3IeXGYW4Lofzn
 m30IWd8JE+LjLlBKUI/cZ9QjNAvTmHXWWJygMeyICanLgm7NZrTJqzR358OEdFnlZ1/2kAQo6sU
 A6OGlBvpEkNK5eiiQJsMiLakfhoVqAGQlQD25oiXe5xMwkBouxiMjFzlc6ElHtGIPCs/gQHD+Kd
 AL2eO2YkU8dMv1wMv36IB5o+lsCRZSJGvUH3zGnYSWM8UQxqMPnoJIYWRe8atytSP5lFNIccqja
 4DqVCQRZX8+sco/X/VNm7oSzMzlkdAtEZJdc0sK6cNpBdgEizbI3/F5OYnCcCJ3Tgm3fkRE4A7Q
 Jww7XE+EswW3yhGhixueFb3c3//0TC
X-Received: by 2002:a05:620a:7119:b0:8be:e0c4:26ca with SMTP id
 af79cd13be357-8cd6d4884eamr399915085a.61.1772820806877; 
 Fri, 06 Mar 2026 10:13:26 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f5736c0sm155930885a.49.2026.03.06.10.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 10:13:26 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>, Alice Guo <alice.guo@nxp.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Moteen Shah <m-shah@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v2 00/23] binman: test: Organise test files into subdirectories
Date: Fri,  6 Mar 2026 11:12:28 -0700
Message-ID: <20260306181304.2426352-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

There are about 350 numbered .dts test files in tools/binman/test/ and
we sometimes have trouble with numbers being reused.

As an alternative approach, this series moves the files into thematic
subdirectories, without the numeric prefixes. This means it's no-longer
possible to simply type a three-digit number to get the right file, but
the names are shorter so it is still easy enough.

The subdirectories chosen are: blob, capsule, cbfs, cros, entry, fdt,
fip, fit, mkimage, pack, security, symbols, vendor, x86, and xpl.

Non-DTS test data (binary blobs, keys, certificates, engine source) is
also moved into the appropriate subdirectory.

This series absorbs the 'binman: test: Fix iMX8 coverage and
test-numbering' series [1], adding iMX8/CST test coverage and removing
the allow_failures list, since all files now reach 100% coverage. The
test-numbering patches from that series are dropped as they are
superseded by the subdirectory reorganisation.

[1] https://lore.kernel.org/u-boot/20260225225040.2568118-1-sjg@chromium.org/

Changes in v2:
- Rename single-node DTS files to match their entry-type node name
- Remove unused no_alt_format.dts
- Move ftest.py comment update from the doc patch
- Move doc-reference updates from the doc patch into this patch
- Add new patch to move x86 binary test data
- Add new patch to move FIT signing test data
- Add new patch to move shared key files
- Absorb the 'Fix iMX8 coverage and test-numbering' series
- Drop patch 'Renumber duplicate test-file prefixes'
- Drop patch 'Drop the number prefix from non-dts test files'
- Add iMX8/CST coverage and allow_failures cleanup patches
- Move non-DTS test data (binaries, keys, certificates) into subdirs
- Rename single-node DTS files to match their entry-type node name
- Fix awkward wording per Quentin's suggestion
- Move file-reference updates to the patches that rename those files
- Drop RFC prefix
- Use literalinclude for nxp_imx8.dts example

Simon Glass (23):
  binman: test: Capture output from tests with warnings
  binman: test: Move pack/layout test files to test/pack/
  binman: test: Move U-Boot variant test files to test/xpl/
  binman: test: Move x86 and Intel test files to test/x86/
  binman: test: Move FIT image test files to test/fit/
  binman: test: Move FDT/fdtmap test files to test/fdt/
  binman: test: Move blob test files to test/blob/
  binman: test: Move security test files to test/security/
  binman: test: Move CBFS test files to test/cbfs/
  binman: test: Move ChromeOS test files to test/cros/
  binman: test: Move mkimage test files to test/mkimage/
  binman: test: Move FIP/TF-A test files to test/fip/
  binman: test: Move UEFI capsule test files to test/capsule/
  binman: test: Move vendor-specific test files to test/vendor/
  binman: test: Move symbol test files to test/symbols/
  binman: test: Move remaining test files to test/entry/
  binman: test: Move x86 binary test data to test/x86/
  binman: test: Move FIT signing test data to test/fit/
  binman: test: Move shared key files to test/security/
  binman: test: Fix code coverage for iMX8 and cst bintool
  binman: Remove the coverage allow_failures list
  binman: Drop the allow_failures parameter from run_test_coverage()
  binman: doc: Update binman_tests.rst for subdirectory layout

 doc/develop/binman_tests.rst                  |   46 +-
 tools/binman/entry_test.py                    |    2 +-
 tools/binman/fdt_test.py                      |    4 +-
 tools/binman/ftest.py                         | 1082 +++++++++--------
 tools/binman/main.py                          |    7 +-
 tools/binman/test/214_no_alt_format.dts       |   13 -
 tools/binman/test/Makefile                    |    2 +-
 .../test/{023_blob.dts => blob/blob.dts}      |    0
 .../test/{157_blob_ext.dts => blob/ext.dts}   |    0
 .../ext_list.dts}                             |    0
 .../ext_list_fake.dts}                        |    0
 .../ext_list_missing.dts}                     |    0
 .../ext_missing.dts}                          |    0
 .../ext_missing_sect.dts}                     |    0
 .../ext_opt.dts}                              |    0
 .../test/{217_fake_blob.dts => blob/fake.dts} |    0
 .../missing.dts}                              |    0
 .../named_by_arg.dts}                         |    0
 .../{273_blob_symbol.dts => blob/symbol.dts}  |    0
 .../accept.dts}                               |    0
 .../accept_missing_guid.dts}                  |    0
 .../accept_revert_missing.dts}                |    0
 .../{311_capsule.dts => capsule/capsule.dts}  |    0
 .../empty_type_missing.dts}                   |    0
 .../missing_guid.dts}                         |    0
 .../missing_index.dts}                        |    0
 .../missing_key.dts}                          |    0
 .../oemflags.dts}                             |    0
 .../revert.dts}                               |    0
 .../signed.dts}                               |    0
 .../signed_ver.dts}                           |    0
 .../version.dts}                              |    0
 .../bad_arch.dts}                             |    0
 .../bad_compress.dts}                         |    0
 .../bad_type.dts}                             |    0
 .../test/{110_cbfs_name.dts => cbfs/name.dts} |    0
 .../no_contents.dts}                          |    0
 .../no_size.dts}                              |    0
 .../{114_cbfs_offset.dts => cbfs/offset.dts}  |    0
 .../test/{102_cbfs_raw.dts => cbfs/raw.dts}   |    0
 .../raw_compress.dts}                         |    0
 .../raw_ppc.dts}                              |    0
 .../replace.dts}                              |    0
 .../{104_cbfs_stage.dts => cbfs/stage.dts}    |    0
 .../{125_cbfs_update.dts => cbfs/update.dts}  |    0
 .../test/{067_fmap.dts => cros/fmap.dts}      |    0
 .../binman/test/{071_gbb.dts => cros/gbb.dts} |    0
 .../gbb_no_size.dts}                          |    0
 .../gbb_too_small.dts}                        |    0
 .../test/{074_vblock.dts => cros/vblock.dts}  |    0
 .../vblock_bad_entry.dts}                     |    0
 .../vblock_bad_phandle.dts}                   |    0
 .../vblock_content.dts}                       |    0
 .../vblock_no_content.dts}                    |    0
 .../test/{262_absent.dts => entry/absent.dts} |    0
 .../collection.dts}                           |    0
 .../collection_other.dts}                     |    0
 .../collection_section.dts}                   |    0
 .../{083_compress.dts => entry/compress.dts}  |    0
 .../compress_extra.dts}                       |    0
 .../compress_image.dts}                       |    0
 .../compress_image_less.dts}                  |    0
 .../compress_section.dts}                     |    0
 .../compress_section_size.dts}                |    0
 .../test/{096_elf.dts => entry/elf.dts}       |    0
 .../elf_strip.dts}                            |    0
 .../entry_args.dts}                           |    0
 .../entry_args_missing.dts}                   |    0
 .../entry_args_required.dts}                  |    0
 .../entry_args_unknown_datatype.dts}          |    0
 .../test/{174_env.dts => entry/env.dts}       |    0
 .../env_no_size.dts}                          |    0
 .../env_too_small.dts}                        |    0
 .../test/{084_files.dts => entry/files.dts}   |    0
 .../files_align.dts}                          |    0
 .../files_compress.dts}                       |    0
 .../files_no_pattern.dts}                     |    0
 .../files_none.dts}                           |    0
 .../test/{069_fill.dts => entry/fill.dts}     |    0
 .../fill_empty.dts}                           |    0
 .../fill_no_size.dts}                         |    0
 .../image_entryarg.dts}                       |    0
 .../test/{127_list.dts => entry/list.dts}     |    0
 .../name_prefix.dts}                          |    0
 .../test/{268_null.dts => entry/null.dts}     |    0
 .../offset_from_elf.dts}                      |    0
 .../{269_overlap.dts => entry/overlap.dts}    |    0
 .../overlap_bad.dts}                          |    0
 .../overlap_no_size.dts}                      |    0
 .../overlap_null.dts}                         |    0
 .../prop_test.dts}                            |    0
 .../read_image_skip.dts}                      |    0
 .../remove_template.dts}                      |    0
 .../{132_replace.dts => entry/replace.dts}    |    0
 .../replace_all.dts}                          |    0
 .../replace_multi.dts}                        |    0
 .../replace_repack.dts}                       |    0
 .../replace_section_deep.dts}                 |    0
 .../replace_section_simple.dts}               |    0
 .../replace_with_bintool.dts}                 |    0
 .../section_fname.dts}                        |    0
 .../section_timeout.dts}                      |    0
 .../{055_sections.dts => entry/sections.dts}  |    0
 .../{259_symlink.dts => entry/symlink.dts}    |    0
 .../test/{222_tee_os.dts => entry/tee_os.dts} |    0
 .../tee_os_opt.dts}                           |    0
 .../{286_template.dts => entry/template.dts}  |    0
 .../template_multi.dts}                       |    0
 .../template_phandle.dts}                     |    0
 .../template_phandle_dup.dts}                 |    0
 .../template_section.dts}                     |    0
 .../test/{066_text.dts => entry/text.dts}     |    0
 .../unique_names.dts}                         |    0
 .../unique_names_multi.dts}                   |    0
 .../unknown_contents.dts}                     |    0
 .../unknown_pos_size.dts}                     |    0
 .../alternates_fdt.dts}                       |    0
 .../alternates_fdtgrep.dts}                   |    0
 .../alternates_inval.dts}                     |    0
 .../alternates_spl.dts}                       |    0
 .../alternates_vpl.dts}                       |    0
 .../bootph_prop.dts}                          |    0
 .../compress_dtb.dts}                         |    0
 .../compress_dtb_invalid.dts}                 |    0
 .../compress_dtb_prepend_invalid.dts}         |    0
 .../compress_dtb_prepend_length.dts}          |    0
 .../compress_dtb_zstd.dts}                    |    0
 .../decode_image.dts}                         |    0
 .../decode_image_nohdr.dts}                   |    0
 .../test/{115_fdtmap.dts => fdt/fdtmap.dts}   |    0
 .../fdtmap_alt_format.dts}                    |    0
 .../fdtmap_hdr.dts}                           |    0
 .../fdtmap_hdr_endbad.dts}                    |    0
 .../fdtmap_hdr_middle.dts}                    |    0
 .../fdtmap_hdr_missing.dts}                   |    0
 .../fdtmap_hdr_nosize.dts}                    |    0
 .../fdtmap_hdr_pos.dts}                       |    0
 .../fdtmap_hdr_start.dts}                     |    0
 .../fdtmap_hdr_startbad.dts}                  |    0
 .../hdr_no_location.dts}                      |    0
 .../test/{194_fdt_incl.dts => fdt/incl.dts}   |    0
 .../incl_tpl.dts}                             |    0
 .../incl_vpl.dts}                             |    0
 .../list_fdtmap.dts}                          |    0
 .../{060_fdt_update.dts => fdt/update.dts}    |    0
 .../update_all.dts}                           |    0
 .../update_all_repack.dts}                    |    0
 .../update_bad.dts}                           |    0
 .../{169_atf_bl31.dts => fip/atf_bl31.dts}    |    0
 .../bad_align.dts}                            |    0
 .../binman/test/{347_bl1.dts => fip/bl1.dts}  |    0
 .../collection.dts}                           |    0
 .../binman/test/{203_fip.dts => fip/fip.dts}  |    0
 .../test/{207_fip_ls.dts => fip/ls.dts}       |    0
 .../{209_fip_missing.dts => fip/missing.dts}  |    0
 .../{205_fip_no_type.dts => fip/no_type.dts}  |    0
 .../test/{201_opensbi.dts => fip/opensbi.dts} |    0
 .../test/{204_fip_other.dts => fip/other.dts} |    0
 .../{208_fip_replace.dts => fip/replace.dts}  |    0
 .../binman/test/{172_scp.dts => fip/scp.dts}  |    0
 .../test/{210_fip_size.dts => fip/size.dts}   |    0
 .../test/{206_fip_uuid.dts => fip/uuid.dts}   |    0
 tools/binman/test/{ => fit}/aes256.bin        |  Bin
 .../test/{275_fit_align.dts => fit/align.dts} |    0
 .../{227_fit_bad_dir.dts => fit/bad_dir.dts}  |    2 +-
 .../bad_dir_config.dts}                       |    2 +-
 .../bad_oper.dts}                             |    0
 .../binman/test/{ => fit}/dummy-rsa-engine.c  |    0
 .../dummy-rsa4096.crt}                        |    0
 .../encrypt_data.dts}                         |    0
 .../encrypt_data_no_key.dts}                  |    0
 .../external.dts}                             |    0
 .../extract_replace.dts}                      |    0
 .../test/{170_fit_fdt.dts => fit/fdt.dts}     |    0
 .../fdt_compat.dts}                           |    0
 .../{333_fit_fdt_dir.dts => fit/fdt_dir.dts}  |    0
 .../fdt_list.dts}                             |    0
 .../fdt_missing_prop.dts}                     |    0
 .../fdt_name.dts}                             |    0
 .../fdt_oper.dts}                             |    0
 .../fdt_phase.dts}                            |    0
 .../firmware_loadables.dts}                   |    0
 .../binman/test/{161_fit.dts => fit/fit.dts}  |    0
 .../{219_fit_gennode.dts => fit/gennode.dts}  |    0
 .../image_subentry_alignment.dts}             |    0
 .../key_name_hint_dir_signature.dts}          |    0
 .../missing_blob.dts}                         |    0
 .../{340_openssl.conf => fit/openssl.conf}    |    0
 .../replace_sibling.dts}                      |    0
 .../test/{340_rsa2048.key => fit/rsa2048.key} |    0
 .../test/{280_fit_sign.dts => fit/sign.dts}   |    0
 .../signature.dts}                            |    0
 .../signature_engine.dts}                     |    0
 .../signature_engine_encrypt.dts}             |    0
 .../signature_engine_pkcs11.dts}              |    0
 .../signature_engine_pkcs11_object.dts}       |    0
 .../signature_multi_key.dts}                  |    0
 .../signature_no_nodes.dts}                   |    0
 .../{340_softhsm2.conf => fit/softhsm2.conf}  |    0
 .../split_elf.dts}                            |    0
 .../subentry_bintool.dts}                     |    0
 .../subentry_hash.dts}                        |    0
 .../tee_os_opt.dts}                           |    0
 .../tee_os_opt_bad.dts}                       |    0
 .../template.dts}                             |    0
 .../coll.dts}                                 |    0
 .../filename.dts}                             |    0
 .../image.dts}                                |    0
 .../image_bad.dts}                            |    0
 .../image_no_content.dts}                     |    0
 .../missing.dts}                              |    0
 .../missing_multiple.dts}                     |    0
 .../{156_mkimage.dts => mkimage/mkimage.dts}  |    0
 .../mult_data.dts}                            |    0
 .../mult_no_content.dts}                      |    0
 .../name.dts}                                 |    0
 .../special.dts}                              |    0
 .../{290_mkimage_sym.dts => mkimage/sym.dts}  |    0
 .../4gb_and_skip_at_start_together.dts}       |    0
 .../align_default.dts}                        |    0
 .../assume_size.dts}                          |    0
 .../assume_size_ok.dts}                       |    0
 .../{007_bad_align.dts => pack/bad_align.dts} |    0
 .../change_size.dts}                          |    0
 .../dual_image.dts}                           |    0
 .../test/{003_empty.dts => pack/empty.dts}    |    0
 .../entry_extend.dts}                         |    0
 .../entry_extend_section.dts}                 |    0
 .../entry_extend_twice.dts}                   |    0
 .../entry_shrink.dts}                         |    0
 .../expand_size_bad.dts}                      |    0
 .../extend_size.dts}                          |    0
 .../extend_size_bad.dts}                      |    0
 .../image_name.dts}                           |    0
 .../{021_image_pad.dts => pack/image_pad.dts} |    0
 .../{001_invalid.dts => pack/invalid.dts}     |    0
 .../invalid_entry.dts}                        |    0
 .../missing_node.dts}                         |    0
 .../test/{008_pack.dts => pack/pack.dts}      |    0
 .../pack_4gb_no_size.dts}                     |    0
 .../pack_4gb_outside.dts}                     |    0
 .../pack_align_power2.dts}                    |    0
 .../pack_align_section.dts}                   |    0
 .../pack_align_size_power2.dts}               |    0
 .../pack_extra.dts}                           |    0
 .../pack_image_align.dts}                     |    0
 .../pack_image_overflow.dts}                  |    0
 .../pack_image_size.dts}                      |    0
 .../pack_inv_align.dts}                       |    0
 .../pack_inv_image_align.dts}                 |    0
 .../pack_inv_image_align_power2.dts}          |    0
 .../pack_inv_size_align.dts}                  |    0
 .../pack_overflow.dts}                        |    0
 .../pack_overlap.dts}                         |    0
 .../pack_overlap_zero.dts}                    |    0
 .../pack_zero_size.dts}                       |    0
 .../pad_in_sections.dts}                      |    0
 .../section_align.dts}                        |    0
 .../section_inner.dts}                        |    0
 .../section_pad.dts}                          |    0
 .../sections_offset.dts}                      |    0
 .../test/{005_simple.dts => pack/simple.dts}  |    0
 .../skip_at_start.dts}                        |    0
 .../skip_at_start_pad.dts}                    |    0
 .../skip_at_start_section_pad.dts}            |    0
 .../test/{024_sorted.dts => pack/sorted.dts}  |    0
 .../unit_address.dts}                         |    0
 .../{079_uses_pos.dts => pack/uses_pos.dts}   |    0
 .../encrypted_invalid_iv_file.dts}            |    0
 .../encrypted_key_file.dts}                   |    0
 .../encrypted_key_source.dts}                 |    0
 .../encrypted_missing_key.dts}                |    0
 .../encrypted_no_algo.dts}                    |    0
 .../test/{090_hash.dts => security/hash.dts}  |    0
 .../hash_bad_algo.dts}                        |    0
 .../hash_no_algo.dts}                         |    0
 .../hash_section.dts}                         |    0
 tools/binman/test/{ => security}/key.key      |    0
 tools/binman/test/{ => security}/key.pem      |    0
 .../key_name_hint_dir_spl_pubkey_dtb.dts}     |    0
 .../pre_load.dts}                             |    0
 .../pre_load_invalid_algo.dts}                |    0
 .../pre_load_invalid_key.dts}                 |    0
 .../pre_load_invalid_padding.dts}             |    0
 .../pre_load_invalid_sha.dts}                 |    0
 .../pre_load_pkcs.dts}                        |    0
 .../pre_load_pss.dts}                         |    0
 .../section_ignore_hash_signature.dts}        |    0
 .../sign_non_fit.dts}                         |    0
 .../spl_pubkey_dtb.dts}                       |    0
 .../x509_cert.dts}                            |    0
 .../xilinx_bootgen_sign.dts}                  |    0
 .../xilinx_bootgen_sign_enc.dts}              |    0
 .../base.dts}                                 |    0
 .../base_expand.dts}                          |    0
 .../comp.dts}                                 |    0
 .../disable.dts}                              |    0
 .../{260_symbols_elf.dts => symbols/elf.dts}  |    0
 .../expand.dts}                               |    0
 .../nodtb.dts}                                |    0
 .../{187_symbols_sub.dts => symbols/sub.dts}  |    0
 .../{053_symbols.dts => symbols/symbols.dts}  |    0
 .../{149_symbols_tpl.dts => symbols/tpl.dts}  |    0
 .../nxp_ddrfw_imx95.dts}                      |    0
 .../{339_nxp_imx8.dts => vendor/nxp_imx8.dts} |    3 +
 tools/binman/test/vendor/nxp_imx8_csf.dts     |   26 +
 .../test/vendor/nxp_imx8_csf_fast_auth.dts    |   21 +
 .../binman/test/vendor/nxp_imx8_imagename.dts |   27 +
 .../nxp_imx95.dts}                            |    0
 .../powerpc_mpc85xx_bootpg_resetvec.dts}      |    0
 .../renesas_rcar4_sa0.dts}                    |    0
 .../renesas_rcar4_sa0_size.dts}               |    0
 .../rockchip_tpl.dts}                         |    0
 .../ti_board_cfg.dts}                         |    0
 .../ti_board_cfg_combined.dts}                |    0
 .../ti_board_cfg_no_type.dts}                 |    0
 .../ti_board_cfg_phony.dts}                   |    0
 .../test/{225_ti_dm.dts => vendor/ti_dm.dts}  |    0
 .../ti_secure.dts}                            |    0
 .../ti_secure_firewall.dts}                   |    0
 .../ti_secure_firewall_missing_property.dts}  |    0
 .../ti_secure_rom.dts}                        |    0
 .../ti_secure_rom_a.dts}                      |    0
 .../ti_secure_rom_b.dts}                      |    0
 .../ti_secure_rom_combined.dts}               |    0
 tools/binman/test/{ => x86}/descriptor.bin    |  Bin
 .../descriptor_offset.dts}                    |    0
 tools/binman/test/{ => x86}/fitimage.bin.gz   |  Bin
 .../test/{094_fmap_x86.dts => x86/fmap.dts}   |    0
 .../fmap_section.dts}                         |    0
 tools/binman/test/{ => x86}/ifwi.bin.gz       |  Bin
 .../{043_intel_cmc.dts => x86/intel_cmc.dts}  |    0
 .../{147_intel_fit.dts => x86/intel_fit.dts}  |    0
 .../intel_fit_missing.dts}                    |    0
 .../{042_intel_fsp.dts => x86/intel_fsp.dts}  |    0
 .../intel_fsp_m.dts}                          |    0
 .../intel_fsp_s.dts}                          |    0
 .../intel_fsp_t.dts}                          |    0
 .../{050_intel_mrc.dts => x86/intel_mrc.dts}  |    0
 .../intel_refcode.dts}                        |    0
 .../{046_intel_vbt.dts => x86/intel_vbt.dts}  |    0
 .../{032_intel_vga.dts => x86/intel_vga.dts}  |    0
 .../no_ucode.dts}                             |    0
 .../optional_ucode.dts}                       |    0
 .../{144_x86_reset16.dts => x86/reset16.dts}  |    0
 .../reset16_spl.dts}                          |    0
 .../reset16_tpl.dts}                          |    0
 .../test/{029_x86_rom.dts => x86/rom.dts}     |    0
 .../rom_ifwi.dts}                             |    0
 .../rom_ifwi_nodata.dts}                      |    0
 .../rom_ifwi_nodesc.dts}                      |    0
 .../rom_ifwi_section.dts}                     |    0
 .../{031_x86_rom_me.dts => x86/rom_me.dts}    |    0
 .../rom_me_empty.dts}                         |    0
 .../rom_me_missing.dts}                       |    0
 .../rom_me_no_desc.dts}                       |    0
 .../single_ucode.dts}                         |    0
 .../{033_x86_start16.dts => x86/start16.dts}  |    0
 .../start16_spl.dts}                          |    0
 .../start16_tpl.dts}                          |    0
 .../symbols_tpl.dts}                          |    0
 .../tpl_ucode.dts}                            |    0
 .../test/{034_x86_ucode.dts => x86/ucode.dts} |    0
 .../ucode_missing_node.dts}                   |    0
 .../ucode_missing_node2.dts}                  |    0
 .../ucode_not_in_image.dts}                   |    0
 .../ucode_spl.dts}                            |    0
 .../ucode_spl_needs_retry.dts}                |    0
 .../pack_dtb.dts}                             |    0
 .../spl_bss_pad.dts}                          |    0
 .../test/{078_u_boot_tpl.dts => xpl/tpl.dts}  |    0
 .../tpl_bss_pad.dts}                          |    0
 .../u-boot-img.dts}                           |    0
 .../u-boot-spl-dtb.dts}                       |    0
 .../u-boot-spl-nodtb.dts}                     |    0
 .../u-boot-spl.dts}                           |    0
 .../u-boot-tpl-nodtb.dts}                     |    0
 .../u-boot-vpl-nodtb.dts}                     |    0
 .../test/{255_u_boot_vpl.dts => xpl/vpl.dts}  |    0
 .../vpl_bss_pad.dts}                          |    0
 tools/u_boot_pylib/test_util.py               |   15 +-
 381 files changed, 696 insertions(+), 556 deletions(-)
 delete mode 100644 tools/binman/test/214_no_alt_format.dts
 rename tools/binman/test/{023_blob.dts => blob/blob.dts} (100%)
 rename tools/binman/test/{157_blob_ext.dts => blob/ext.dts} (100%)
 rename tools/binman/test/{215_blob_ext_list.dts => blob/ext_list.dts} (100%)
 rename tools/binman/test/{218_blob_ext_list_fake.dts => blob/ext_list_fake.dts} (100%)
 rename tools/binman/test/{216_blob_ext_list_missing.dts => blob/ext_list_missing.dts} (100%)
 rename tools/binman/test/{158_blob_ext_missing.dts => blob/ext_missing.dts} (100%)
 rename tools/binman/test/{159_blob_ext_missing_sect.dts => blob/ext_missing_sect.dts} (100%)
 rename tools/binman/test/{266_blob_ext_opt.dts => blob/ext_opt.dts} (100%)
 rename tools/binman/test/{217_fake_blob.dts => blob/fake.dts} (100%)
 rename tools/binman/test/{173_missing_blob.dts => blob/missing.dts} (100%)
 rename tools/binman/test/{068_blob_named_by_arg.dts => blob/named_by_arg.dts} (100%)
 rename tools/binman/test/{273_blob_symbol.dts => blob/symbol.dts} (100%)
 rename tools/binman/test/{319_capsule_accept.dts => capsule/accept.dts} (100%)
 rename tools/binman/test/{321_capsule_accept_missing_guid.dts => capsule/accept_missing_guid.dts} (100%)
 rename tools/binman/test/{323_capsule_accept_revert_missing.dts => capsule/accept_revert_missing.dts} (100%)
 rename tools/binman/test/{311_capsule.dts => capsule/capsule.dts} (100%)
 rename tools/binman/test/{322_empty_capsule_type_missing.dts => capsule/empty_type_missing.dts} (100%)
 rename tools/binman/test/{318_capsule_missing_guid.dts => capsule/missing_guid.dts} (100%)
 rename tools/binman/test/{317_capsule_missing_index.dts => capsule/missing_index.dts} (100%)
 rename tools/binman/test/{316_capsule_missing_key.dts => capsule/missing_key.dts} (100%)
 rename tools/binman/test/{315_capsule_oemflags.dts => capsule/oemflags.dts} (100%)
 rename tools/binman/test/{320_capsule_revert.dts => capsule/revert.dts} (100%)
 rename tools/binman/test/{312_capsule_signed.dts => capsule/signed.dts} (100%)
 rename tools/binman/test/{314_capsule_signed_ver.dts => capsule/signed_ver.dts} (100%)
 rename tools/binman/test/{313_capsule_version.dts => capsule/version.dts} (100%)
 rename tools/binman/test/{106_cbfs_bad_arch.dts => cbfs/bad_arch.dts} (100%)
 rename tools/binman/test/{109_cbfs_bad_compress.dts => cbfs/bad_compress.dts} (100%)
 rename tools/binman/test/{126_cbfs_bad_type.dts => cbfs/bad_type.dts} (100%)
 rename tools/binman/test/{110_cbfs_name.dts => cbfs/name.dts} (100%)
 rename tools/binman/test/{108_cbfs_no_contents.dts => cbfs/no_contents.dts} (100%)
 rename tools/binman/test/{107_cbfs_no_size.dts => cbfs/no_size.dts} (100%)
 rename tools/binman/test/{114_cbfs_offset.dts => cbfs/offset.dts} (100%)
 rename tools/binman/test/{102_cbfs_raw.dts => cbfs/raw.dts} (100%)
 rename tools/binman/test/{105_cbfs_raw_compress.dts => cbfs/raw_compress.dts} (100%)
 rename tools/binman/test/{103_cbfs_raw_ppc.dts => cbfs/raw_ppc.dts} (100%)
 rename tools/binman/test/{142_replace_cbfs.dts => cbfs/replace.dts} (100%)
 rename tools/binman/test/{104_cbfs_stage.dts => cbfs/stage.dts} (100%)
 rename tools/binman/test/{125_cbfs_update.dts => cbfs/update.dts} (100%)
 rename tools/binman/test/{067_fmap.dts => cros/fmap.dts} (100%)
 rename tools/binman/test/{071_gbb.dts => cros/gbb.dts} (100%)
 rename tools/binman/test/{073_gbb_no_size.dts => cros/gbb_no_size.dts} (100%)
 rename tools/binman/test/{072_gbb_too_small.dts => cros/gbb_too_small.dts} (100%)
 rename tools/binman/test/{074_vblock.dts => cros/vblock.dts} (100%)
 rename tools/binman/test/{077_vblock_bad_entry.dts => cros/vblock_bad_entry.dts} (100%)
 rename tools/binman/test/{076_vblock_bad_phandle.dts => cros/vblock_bad_phandle.dts} (100%)
 rename tools/binman/test/{189_vblock_content.dts => cros/vblock_content.dts} (100%)
 rename tools/binman/test/{075_vblock_no_content.dts => cros/vblock_no_content.dts} (100%)
 rename tools/binman/test/{262_absent.dts => entry/absent.dts} (100%)
 rename tools/binman/test/{198_collection.dts => entry/collection.dts} (100%)
 rename tools/binman/test/{246_collection_other.dts => entry/collection_other.dts} (100%)
 rename tools/binman/test/{199_collection_section.dts => entry/collection_section.dts} (100%)
 rename tools/binman/test/{083_compress.dts => entry/compress.dts} (100%)
 rename tools/binman/test/{186_compress_extra.dts => entry/compress_extra.dts} (100%)
 rename tools/binman/test/{182_compress_image.dts => entry/compress_image.dts} (100%)
 rename tools/binman/test/{183_compress_image_less.dts => entry/compress_image_less.dts} (100%)
 rename tools/binman/test/{185_compress_section.dts => entry/compress_section.dts} (100%)
 rename tools/binman/test/{184_compress_section_size.dts => entry/compress_section_size.dts} (100%)
 rename tools/binman/test/{096_elf.dts => entry/elf.dts} (100%)
 rename tools/binman/test/{097_elf_strip.dts => entry/elf_strip.dts} (100%)
 rename tools/binman/test/{062_entry_args.dts => entry/entry_args.dts} (100%)
 rename tools/binman/test/{063_entry_args_missing.dts => entry/entry_args_missing.dts} (100%)
 rename tools/binman/test/{064_entry_args_required.dts => entry/entry_args_required.dts} (100%)
 rename tools/binman/test/{065_entry_args_unknown_datatype.dts => entry/entry_args_unknown_datatype.dts} (100%)
 rename tools/binman/test/{174_env.dts => entry/env.dts} (100%)
 rename tools/binman/test/{175_env_no_size.dts => entry/env_no_size.dts} (100%)
 rename tools/binman/test/{176_env_too_small.dts => entry/env_too_small.dts} (100%)
 rename tools/binman/test/{084_files.dts => entry/files.dts} (100%)
 rename tools/binman/test/{190_files_align.dts => entry/files_align.dts} (100%)
 rename tools/binman/test/{085_files_compress.dts => entry/files_compress.dts} (100%)
 rename tools/binman/test/{087_files_no_pattern.dts => entry/files_no_pattern.dts} (100%)
 rename tools/binman/test/{086_files_none.dts => entry/files_none.dts} (100%)
 rename tools/binman/test/{069_fill.dts => entry/fill.dts} (100%)
 rename tools/binman/test/{080_fill_empty.dts => entry/fill_empty.dts} (100%)
 rename tools/binman/test/{070_fill_no_size.dts => entry/fill_no_size.dts} (100%)
 rename tools/binman/test/{188_image_entryarg.dts => entry/image_entryarg.dts} (100%)
 rename tools/binman/test/{127_list.dts => entry/list.dts} (100%)
 rename tools/binman/test/{056_name_prefix.dts => entry/name_prefix.dts} (100%)
 rename tools/binman/test/{268_null.dts => entry/null.dts} (100%)
 rename tools/binman/test/{274_offset_from_elf.dts => entry/offset_from_elf.dts} (100%)
 rename tools/binman/test/{269_overlap.dts => entry/overlap.dts} (100%)
 rename tools/binman/test/{271_overlap_bad.dts => entry/overlap_bad.dts} (100%)
 rename tools/binman/test/{272_overlap_no_size.dts => entry/overlap_no_size.dts} (100%)
 rename tools/binman/test/{270_overlap_null.dts => entry/overlap_null.dts} (100%)
 rename tools/binman/test/{045_prop_test.dts => entry/prop_test.dts} (100%)
 rename tools/binman/test/{191_read_image_skip.dts => entry/read_image_skip.dts} (100%)
 rename tools/binman/test/{346_remove_template.dts => entry/remove_template.dts} (100%)
 rename tools/binman/test/{132_replace.dts => entry/replace.dts} (100%)
 rename tools/binman/test/{143_replace_all.dts => entry/replace_all.dts} (100%)
 rename tools/binman/test/{133_replace_multi.dts => entry/replace_multi.dts} (100%)
 rename tools/binman/test/{139_replace_repack.dts => entry/replace_repack.dts} (100%)
 rename tools/binman/test/{278_replace_section_deep.dts => entry/replace_section_deep.dts} (100%)
 rename tools/binman/test/{241_replace_section_simple.dts => entry/replace_section_simple.dts} (100%)
 rename tools/binman/test/{239_replace_with_bintool.dts => entry/replace_with_bintool.dts} (100%)
 rename tools/binman/test/{261_section_fname.dts => entry/section_fname.dts} (100%)
 rename tools/binman/test/{202_section_timeout.dts => entry/section_timeout.dts} (100%)
 rename tools/binman/test/{055_sections.dts => entry/sections.dts} (100%)
 rename tools/binman/test/{259_symlink.dts => entry/symlink.dts} (100%)
 rename tools/binman/test/{222_tee_os.dts => entry/tee_os.dts} (100%)
 rename tools/binman/test/{263_tee_os_opt.dts => entry/tee_os_opt.dts} (100%)
 rename tools/binman/test/{286_template.dts => entry/template.dts} (100%)
 rename tools/binman/test/{287_template_multi.dts => entry/template_multi.dts} (100%)
 rename tools/binman/test/{309_template_phandle.dts => entry/template_phandle.dts} (100%)
 rename tools/binman/test/{310_template_phandle_dup.dts => entry/template_phandle_dup.dts} (100%)
 rename tools/binman/test/{289_template_section.dts => entry/template_section.dts} (100%)
 rename tools/binman/test/{066_text.dts => entry/text.dts} (100%)
 rename tools/binman/test/{237_unique_names.dts => entry/unique_names.dts} (100%)
 rename tools/binman/test/{238_unique_names_multi.dts => entry/unique_names_multi.dts} (100%)
 rename tools/binman/test/{057_unknown_contents.dts => entry/unknown_contents.dts} (100%)
 rename tools/binman/test/{041_unknown_pos_size.dts => entry/unknown_pos_size.dts} (100%)
 rename tools/binman/test/{328_alternates_fdt.dts => fdt/alternates_fdt.dts} (100%)
 rename tools/binman/test/{329_alternates_fdtgrep.dts => fdt/alternates_fdtgrep.dts} (100%)
 rename tools/binman/test/{332_alternates_inval.dts => fdt/alternates_inval.dts} (100%)
 rename tools/binman/test/{331_alternates_spl.dts => fdt/alternates_spl.dts} (100%)
 rename tools/binman/test/{330_alternates_vpl.dts => fdt/alternates_vpl.dts} (100%)
 rename tools/binman/test/{347_bootph_prop.dts => fdt/bootph_prop.dts} (100%)
 rename tools/binman/test/{124_compress_dtb.dts => fdt/compress_dtb.dts} (100%)
 rename tools/binman/test/{250_compress_dtb_invalid.dts => fdt/compress_dtb_invalid.dts} (100%)
 rename tools/binman/test/{248_compress_dtb_prepend_invalid.dts => fdt/compress_dtb_prepend_invalid.dts} (100%)
 rename tools/binman/test/{249_compress_dtb_prepend_length.dts => fdt/compress_dtb_prepend_length.dts} (100%)
 rename tools/binman/test/{251_compress_dtb_zstd.dts => fdt/compress_dtb_zstd.dts} (100%)
 rename tools/binman/test/{128_decode_image.dts => fdt/decode_image.dts} (100%)
 rename tools/binman/test/{129_decode_image_nohdr.dts => fdt/decode_image_nohdr.dts} (100%)
 rename tools/binman/test/{115_fdtmap.dts => fdt/fdtmap.dts} (100%)
 rename tools/binman/test/{213_fdtmap_alt_format.dts => fdt/fdtmap_alt_format.dts} (100%)
 rename tools/binman/test/{116_fdtmap_hdr.dts => fdt/fdtmap_hdr.dts} (100%)
 rename tools/binman/test/{137_fdtmap_hdr_endbad.dts => fdt/fdtmap_hdr_endbad.dts} (100%)
 rename tools/binman/test/{135_fdtmap_hdr_middle.dts => fdt/fdtmap_hdr_middle.dts} (100%)
 rename tools/binman/test/{119_fdtmap_hdr_missing.dts => fdt/fdtmap_hdr_missing.dts} (100%)
 rename tools/binman/test/{138_fdtmap_hdr_nosize.dts => fdt/fdtmap_hdr_nosize.dts} (100%)
 rename tools/binman/test/{118_fdtmap_hdr_pos.dts => fdt/fdtmap_hdr_pos.dts} (100%)
 rename tools/binman/test/{117_fdtmap_hdr_start.dts => fdt/fdtmap_hdr_start.dts} (100%)
 rename tools/binman/test/{136_fdtmap_hdr_startbad.dts => fdt/fdtmap_hdr_startbad.dts} (100%)
 rename tools/binman/test/{120_hdr_no_location.dts => fdt/hdr_no_location.dts} (100%)
 rename tools/binman/test/{194_fdt_incl.dts => fdt/incl.dts} (100%)
 rename tools/binman/test/{195_fdt_incl_tpl.dts => fdt/incl_tpl.dts} (100%)
 rename tools/binman/test/{257_fdt_incl_vpl.dts => fdt/incl_vpl.dts} (100%)
 rename tools/binman/test/{130_list_fdtmap.dts => fdt/list_fdtmap.dts} (100%)
 rename tools/binman/test/{060_fdt_update.dts => fdt/update.dts} (100%)
 rename tools/binman/test/{082_fdt_update_all.dts => fdt/update_all.dts} (100%)
 rename tools/binman/test/{134_fdt_update_all_repack.dts => fdt/update_all_repack.dts} (100%)
 rename tools/binman/test/{061_fdt_update_bad.dts => fdt/update_bad.dts} (100%)
 rename tools/binman/test/{169_atf_bl31.dts => fip/atf_bl31.dts} (100%)
 rename tools/binman/test/{211_fip_bad_align.dts => fip/bad_align.dts} (100%)
 rename tools/binman/test/{347_bl1.dts => fip/bl1.dts} (100%)
 rename tools/binman/test/{212_fip_collection.dts => fip/collection.dts} (100%)
 rename tools/binman/test/{203_fip.dts => fip/fip.dts} (100%)
 rename tools/binman/test/{207_fip_ls.dts => fip/ls.dts} (100%)
 rename tools/binman/test/{209_fip_missing.dts => fip/missing.dts} (100%)
 rename tools/binman/test/{205_fip_no_type.dts => fip/no_type.dts} (100%)
 rename tools/binman/test/{201_opensbi.dts => fip/opensbi.dts} (100%)
 rename tools/binman/test/{204_fip_other.dts => fip/other.dts} (100%)
 rename tools/binman/test/{208_fip_replace.dts => fip/replace.dts} (100%)
 rename tools/binman/test/{172_scp.dts => fip/scp.dts} (100%)
 rename tools/binman/test/{210_fip_size.dts => fip/size.dts} (100%)
 rename tools/binman/test/{206_fip_uuid.dts => fip/uuid.dts} (100%)
 rename tools/binman/test/{ => fit}/aes256.bin (100%)
 rename tools/binman/test/{275_fit_align.dts => fit/align.dts} (100%)
 rename tools/binman/test/{227_fit_bad_dir.dts => fit/bad_dir.dts} (71%)
 rename tools/binman/test/{228_fit_bad_dir_config.dts => fit/bad_dir_config.dts} (71%)
 rename tools/binman/test/{224_fit_bad_oper.dts => fit/bad_oper.dts} (100%)
 rename tools/binman/test/{ => fit}/dummy-rsa-engine.c (100%)
 rename tools/binman/test/{340_dummy-rsa4096.crt => fit/dummy-rsa4096.crt} (100%)
 rename tools/binman/test/{343_fit_encrypt_data.dts => fit/encrypt_data.dts} (100%)
 rename tools/binman/test/{344_fit_encrypt_data_no_key.dts => fit/encrypt_data_no_key.dts} (100%)
 rename tools/binman/test/{162_fit_external.dts => fit/external.dts} (100%)
 rename tools/binman/test/{240_fit_extract_replace.dts => fit/extract_replace.dts} (100%)
 rename tools/binman/test/{170_fit_fdt.dts => fit/fdt.dts} (100%)
 rename tools/binman/test/{334_fit_fdt_compat.dts => fit/fdt_compat.dts} (100%)
 rename tools/binman/test/{333_fit_fdt_dir.dts => fit/fdt_dir.dts} (100%)
 rename tools/binman/test/{284_fit_fdt_list.dts => fit/fdt_list.dts} (100%)
 rename tools/binman/test/{171_fit_fdt_missing_prop.dts => fit/fdt_missing_prop.dts} (100%)
 rename tools/binman/test/{345_fit_fdt_name.dts => fit/fdt_name.dts} (100%)
 rename tools/binman/test/{223_fit_fdt_oper.dts => fit/fdt_oper.dts} (100%)
 rename tools/binman/test/{335_fit_fdt_phase.dts => fit/fdt_phase.dts} (100%)
 rename tools/binman/test/{276_fit_firmware_loadables.dts => fit/firmware_loadables.dts} (100%)
 rename tools/binman/test/{161_fit.dts => fit/fit.dts} (100%)
 rename tools/binman/test/{219_fit_gennode.dts => fit/gennode.dts} (100%)
 rename tools/binman/test/{167_fit_image_subentry_alignment.dts => fit/image_subentry_alignment.dts} (100%)
 rename tools/binman/test/{347_key_name_hint_dir_fit_signature.dts => fit/key_name_hint_dir_signature.dts} (100%)
 rename tools/binman/test/{168_fit_missing_blob.dts => fit/missing_blob.dts} (100%)
 rename tools/binman/test/{340_openssl.conf => fit/openssl.conf} (100%)
 rename tools/binman/test/{277_replace_fit_sibling.dts => fit/replace_sibling.dts} (100%)
 rename tools/binman/test/{340_rsa2048.key => fit/rsa2048.key} (100%)
 rename tools/binman/test/{280_fit_sign.dts => fit/sign.dts} (100%)
 rename tools/binman/test/{340_fit_signature.dts => fit/signature.dts} (100%)
 rename tools/binman/test/{340_fit_signature_engine.dts => fit/signature_engine.dts} (100%)
 rename tools/binman/test/{340_fit_signature_engine_encrypt.dts => fit/signature_engine_encrypt.dts} (100%)
 rename tools/binman/test/{340_fit_signature_engine_pkcs11.dts => fit/signature_engine_pkcs11.dts} (100%)
 rename tools/binman/test/{340_fit_signature_engine_pkcs11_object.dts => fit/signature_engine_pkcs11_object.dts} (100%)
 rename tools/binman/test/{341_fit_signature.dts => fit/signature_multi_key.dts} (100%)
 rename tools/binman/test/{342_fit_signature.dts => fit/signature_no_nodes.dts} (100%)
 rename tools/binman/test/{340_softhsm2.conf => fit/softhsm2.conf} (100%)
 rename tools/binman/test/{226_fit_split_elf.dts => fit/split_elf.dts} (100%)
 rename tools/binman/test/{220_fit_subentry_bintool.dts => fit/subentry_bintool.dts} (100%)
 rename tools/binman/test/{221_fit_subentry_hash.dts => fit/subentry_hash.dts} (100%)
 rename tools/binman/test/{264_tee_os_opt_fit.dts => fit/tee_os_opt.dts} (100%)
 rename tools/binman/test/{265_tee_os_opt_fit_bad.dts => fit/tee_os_opt_bad.dts} (100%)
 rename tools/binman/test/{288_template_fit.dts => fit/template.dts} (100%)
 rename tools/binman/test/{247_mkimage_coll.dts => mkimage/coll.dts} (100%)
 rename tools/binman/test/{254_mkimage_filename.dts => mkimage/filename.dts} (100%)
 rename tools/binman/test/{243_mkimage_image.dts => mkimage/image.dts} (100%)
 rename tools/binman/test/{245_mkimage_image_bad.dts => mkimage/image_bad.dts} (100%)
 rename tools/binman/test/{244_mkimage_image_no_content.dts => mkimage/image_no_content.dts} (100%)
 rename tools/binman/test/{229_mkimage_missing.dts => mkimage/missing.dts} (100%)
 rename tools/binman/test/{292_mkimage_missing_multiple.dts => mkimage/missing_multiple.dts} (100%)
 rename tools/binman/test/{156_mkimage.dts => mkimage/mkimage.dts} (100%)
 rename tools/binman/test/{252_mkimage_mult_data.dts => mkimage/mult_data.dts} (100%)
 rename tools/binman/test/{253_mkimage_mult_no_content.dts => mkimage/mult_no_content.dts} (100%)
 rename tools/binman/test/{242_mkimage_name.dts => mkimage/name.dts} (100%)
 rename tools/binman/test/{283_mkimage_special.dts => mkimage/special.dts} (100%)
 rename tools/binman/test/{290_mkimage_sym.dts => mkimage/sym.dts} (100%)
 rename tools/binman/test/{098_4gb_and_skip_at_start_together.dts => pack/4gb_and_skip_at_start_together.dts} (100%)
 rename tools/binman/test/{200_align_default.dts => pack/align_default.dts} (100%)
 rename tools/binman/test/{326_assume_size.dts => pack/assume_size.dts} (100%)
 rename tools/binman/test/{327_assume_size_ok.dts => pack/assume_size_ok.dts} (100%)
 rename tools/binman/test/{007_bad_align.dts => pack/bad_align.dts} (100%)
 rename tools/binman/test/{059_change_size.dts => pack/change_size.dts} (100%)
 rename tools/binman/test/{006_dual_image.dts => pack/dual_image.dts} (100%)
 rename tools/binman/test/{003_empty.dts => pack/empty.dts} (100%)
 rename tools/binman/test/{121_entry_extend.dts => pack/entry_extend.dts} (100%)
 rename tools/binman/test/{123_entry_extend_section.dts => pack/entry_extend_section.dts} (100%)
 rename tools/binman/test/{122_entry_extend_twice.dts => pack/entry_extend_twice.dts} (100%)
 rename tools/binman/test/{140_entry_shrink.dts => pack/entry_shrink.dts} (100%)
 rename tools/binman/test/{225_expand_size_bad.dts => pack/expand_size_bad.dts} (100%)
 rename tools/binman/test/{088_extend_size.dts => pack/extend_size.dts} (100%)
 rename tools/binman/test/{089_extend_size_bad.dts => pack/extend_size_bad.dts} (100%)
 rename tools/binman/test/{022_image_name.dts => pack/image_name.dts} (100%)
 rename tools/binman/test/{021_image_pad.dts => pack/image_pad.dts} (100%)
 rename tools/binman/test/{001_invalid.dts => pack/invalid.dts} (100%)
 rename tools/binman/test/{004_invalid_entry.dts => pack/invalid_entry.dts} (100%)
 rename tools/binman/test/{002_missing_node.dts => pack/missing_node.dts} (100%)
 rename tools/binman/test/{008_pack.dts => pack/pack.dts} (100%)
 rename tools/binman/test/{027_pack_4gb_no_size.dts => pack/pack_4gb_no_size.dts} (100%)
 rename tools/binman/test/{028_pack_4gb_outside.dts => pack/pack_4gb_outside.dts} (100%)
 rename tools/binman/test/{010_pack_align_power2.dts => pack/pack_align_power2.dts} (100%)
 rename tools/binman/test/{131_pack_align_section.dts => pack/pack_align_section.dts} (100%)
 rename tools/binman/test/{011_pack_align_size_power2.dts => pack/pack_align_size_power2.dts} (100%)
 rename tools/binman/test/{009_pack_extra.dts => pack/pack_extra.dts} (100%)
 rename tools/binman/test/{018_pack_image_align.dts => pack/pack_image_align.dts} (100%)
 rename tools/binman/test/{016_pack_image_overflow.dts => pack/pack_image_overflow.dts} (100%)
 rename tools/binman/test/{017_pack_image_size.dts => pack/pack_image_size.dts} (100%)
 rename tools/binman/test/{012_pack_inv_align.dts => pack/pack_inv_align.dts} (100%)
 rename tools/binman/test/{019_pack_inv_image_align.dts => pack/pack_inv_image_align.dts} (100%)
 rename tools/binman/test/{020_pack_inv_image_align_power2.dts => pack/pack_inv_image_align_power2.dts} (100%)
 rename tools/binman/test/{013_pack_inv_size_align.dts => pack/pack_inv_size_align.dts} (100%)
 rename tools/binman/test/{015_pack_overflow.dts => pack/pack_overflow.dts} (100%)
 rename tools/binman/test/{014_pack_overlap.dts => pack/pack_overlap.dts} (100%)
 rename tools/binman/test/{160_pack_overlap_zero.dts => pack/pack_overlap_zero.dts} (100%)
 rename tools/binman/test/{025_pack_zero_size.dts => pack/pack_zero_size.dts} (100%)
 rename tools/binman/test/{166_pad_in_sections.dts => pack/pad_in_sections.dts} (100%)
 rename tools/binman/test/{181_section_align.dts => pack/section_align.dts} (100%)
 rename tools/binman/test/{267_section_inner.dts => pack/section_inner.dts} (100%)
 rename tools/binman/test/{180_section_pad.dts => pack/section_pad.dts} (100%)
 rename tools/binman/test/{101_sections_offset.dts => pack/sections_offset.dts} (100%)
 rename tools/binman/test/{005_simple.dts => pack/simple.dts} (100%)
 rename tools/binman/test/{177_skip_at_start.dts => pack/skip_at_start.dts} (100%)
 rename tools/binman/test/{178_skip_at_start_pad.dts => pack/skip_at_start_pad.dts} (100%)
 rename tools/binman/test/{179_skip_at_start_section_pad.dts => pack/skip_at_start_section_pad.dts} (100%)
 rename tools/binman/test/{024_sorted.dts => pack/sorted.dts} (100%)
 rename tools/binman/test/{054_unit_address.dts => pack/unit_address.dts} (100%)
 rename tools/binman/test/{079_uses_pos.dts => pack/uses_pos.dts} (100%)
 rename tools/binman/test/{302_encrypted_invalid_iv_file.dts => security/encrypted_invalid_iv_file.dts} (100%)
 rename tools/binman/test/{305_encrypted_key_file.dts => security/encrypted_key_file.dts} (100%)
 rename tools/binman/test/{304_encrypted_key_source.dts => security/encrypted_key_source.dts} (100%)
 rename tools/binman/test/{303_encrypted_missing_key.dts => security/encrypted_missing_key.dts} (100%)
 rename tools/binman/test/{301_encrypted_no_algo.dts => security/encrypted_no_algo.dts} (100%)
 rename tools/binman/test/{090_hash.dts => security/hash.dts} (100%)
 rename tools/binman/test/{092_hash_bad_algo.dts => security/hash_bad_algo.dts} (100%)
 rename tools/binman/test/{091_hash_no_algo.dts => security/hash_no_algo.dts} (100%)
 rename tools/binman/test/{099_hash_section.dts => security/hash_section.dts} (100%)
 rename tools/binman/test/{ => security}/key.key (100%)
 rename tools/binman/test/{ => security}/key.pem (100%)
 rename tools/binman/test/{348_key_name_hint_dir_spl_pubkey_dtb.dts => security/key_name_hint_dir_spl_pubkey_dtb.dts} (100%)
 rename tools/binman/test/{230_pre_load.dts => security/pre_load.dts} (100%)
 rename tools/binman/test/{235_pre_load_invalid_algo.dts => security/pre_load_invalid_algo.dts} (100%)
 rename tools/binman/test/{236_pre_load_invalid_key.dts => security/pre_load_invalid_key.dts} (100%)
 rename tools/binman/test/{233_pre_load_invalid_padding.dts => security/pre_load_invalid_padding.dts} (100%)
 rename tools/binman/test/{234_pre_load_invalid_sha.dts => security/pre_load_invalid_sha.dts} (100%)
 rename tools/binman/test/{231_pre_load_pkcs.dts => security/pre_load_pkcs.dts} (100%)
 rename tools/binman/test/{232_pre_load_pss.dts => security/pre_load_pss.dts} (100%)
 rename tools/binman/test/{165_section_ignore_hash_signature.dts => security/section_ignore_hash_signature.dts} (100%)
 rename tools/binman/test/{281_sign_non_fit.dts => security/sign_non_fit.dts} (100%)
 rename tools/binman/test/{306_spl_pubkey_dtb.dts => security/spl_pubkey_dtb.dts} (100%)
 rename tools/binman/test/{279_x509_cert.dts => security/x509_cert.dts} (100%)
 rename tools/binman/test/{307_xilinx_bootgen_sign.dts => security/xilinx_bootgen_sign.dts} (100%)
 rename tools/binman/test/{308_xilinx_bootgen_sign_enc.dts => security/xilinx_bootgen_sign_enc.dts} (100%)
 rename tools/binman/test/{336_symbols_base.dts => symbols/base.dts} (100%)
 rename tools/binman/test/{337_symbols_base_expand.dts => symbols/base_expand.dts} (100%)
 rename tools/binman/test/{338_symbols_comp.dts => symbols/comp.dts} (100%)
 rename tools/binman/test/{282_symbols_disable.dts => symbols/disable.dts} (100%)
 rename tools/binman/test/{260_symbols_elf.dts => symbols/elf.dts} (100%)
 rename tools/binman/test/{197_symbols_expand.dts => symbols/expand.dts} (100%)
 rename tools/binman/test/{196_symbols_nodtb.dts => symbols/nodtb.dts} (100%)
 rename tools/binman/test/{187_symbols_sub.dts => symbols/sub.dts} (100%)
 rename tools/binman/test/{053_symbols.dts => symbols/symbols.dts} (100%)
 rename tools/binman/test/{149_symbols_tpl.dts => symbols/tpl.dts} (100%)
 rename tools/binman/test/{346_nxp_ddrfw_imx95.dts => vendor/nxp_ddrfw_imx95.dts} (100%)
 rename tools/binman/test/{339_nxp_imx8.dts => vendor/nxp_imx8.dts} (93%)
 create mode 100644 tools/binman/test/vendor/nxp_imx8_csf.dts
 create mode 100644 tools/binman/test/vendor/nxp_imx8_csf_fast_auth.dts
 create mode 100644 tools/binman/test/vendor/nxp_imx8_imagename.dts
 rename tools/binman/test/{350_nxp_imx95.dts => vendor/nxp_imx95.dts} (100%)
 rename tools/binman/test/{150_powerpc_mpc85xx_bootpg_resetvec.dts => vendor/powerpc_mpc85xx_bootpg_resetvec.dts} (100%)
 rename tools/binman/test/{348_renesas_rcar4_sa0.dts => vendor/renesas_rcar4_sa0.dts} (100%)
 rename tools/binman/test/{349_renesas_rcar4_sa0_size.dts => vendor/renesas_rcar4_sa0_size.dts} (100%)
 rename tools/binman/test/{291_rockchip_tpl.dts => vendor/rockchip_tpl.dts} (100%)
 rename tools/binman/test/{293_ti_board_cfg.dts => vendor/ti_board_cfg.dts} (100%)
 rename tools/binman/test/{294_ti_board_cfg_combined.dts => vendor/ti_board_cfg_combined.dts} (100%)
 rename tools/binman/test/{295_ti_board_cfg_no_type.dts => vendor/ti_board_cfg_no_type.dts} (100%)
 rename tools/binman/test/{323_ti_board_cfg_phony.dts => vendor/ti_board_cfg_phony.dts} (100%)
 rename tools/binman/test/{225_ti_dm.dts => vendor/ti_dm.dts} (100%)
 rename tools/binman/test/{296_ti_secure.dts => vendor/ti_secure.dts} (100%)
 rename tools/binman/test/{324_ti_secure_firewall.dts => vendor/ti_secure_firewall.dts} (100%)
 rename tools/binman/test/{325_ti_secure_firewall_missing_property.dts => vendor/ti_secure_firewall_missing_property.dts} (100%)
 rename tools/binman/test/{297_ti_secure_rom.dts => vendor/ti_secure_rom.dts} (100%)
 rename tools/binman/test/{299_ti_secure_rom_a.dts => vendor/ti_secure_rom_a.dts} (100%)
 rename tools/binman/test/{300_ti_secure_rom_b.dts => vendor/ti_secure_rom_b.dts} (100%)
 rename tools/binman/test/{298_ti_secure_rom_combined.dts => vendor/ti_secure_rom_combined.dts} (100%)
 rename tools/binman/test/{ => x86}/descriptor.bin (100%)
 rename tools/binman/test/{141_descriptor_offset.dts => x86/descriptor_offset.dts} (100%)
 rename tools/binman/test/{ => x86}/fitimage.bin.gz (100%)
 rename tools/binman/test/{094_fmap_x86.dts => x86/fmap.dts} (100%)
 rename tools/binman/test/{095_fmap_x86_section.dts => x86/fmap_section.dts} (100%)
 rename tools/binman/test/{ => x86}/ifwi.bin.gz (100%)
 rename tools/binman/test/{043_intel_cmc.dts => x86/intel_cmc.dts} (100%)
 rename tools/binman/test/{147_intel_fit.dts => x86/intel_fit.dts} (100%)
 rename tools/binman/test/{148_intel_fit_missing.dts => x86/intel_fit_missing.dts} (100%)
 rename tools/binman/test/{042_intel_fsp.dts => x86/intel_fsp.dts} (100%)
 rename tools/binman/test/{152_intel_fsp_m.dts => x86/intel_fsp_m.dts} (100%)
 rename tools/binman/test/{153_intel_fsp_s.dts => x86/intel_fsp_s.dts} (100%)
 rename tools/binman/test/{154_intel_fsp_t.dts => x86/intel_fsp_t.dts} (100%)
 rename tools/binman/test/{050_intel_mrc.dts => x86/intel_mrc.dts} (100%)
 rename tools/binman/test/{100_intel_refcode.dts => x86/intel_refcode.dts} (100%)
 rename tools/binman/test/{046_intel_vbt.dts => x86/intel_vbt.dts} (100%)
 rename tools/binman/test/{032_intel_vga.dts => x86/intel_vga.dts} (100%)
 rename tools/binman/test/{037_x86_no_ucode.dts => x86/no_ucode.dts} (100%)
 rename tools/binman/test/{044_x86_optional_ucode.dts => x86/optional_ucode.dts} (100%)
 rename tools/binman/test/{144_x86_reset16.dts => x86/reset16.dts} (100%)
 rename tools/binman/test/{145_x86_reset16_spl.dts => x86/reset16_spl.dts} (100%)
 rename tools/binman/test/{146_x86_reset16_tpl.dts => x86/reset16_tpl.dts} (100%)
 rename tools/binman/test/{029_x86_rom.dts => x86/rom.dts} (100%)
 rename tools/binman/test/{111_x86_rom_ifwi.dts => x86/rom_ifwi.dts} (100%)
 rename tools/binman/test/{113_x86_rom_ifwi_nodata.dts => x86/rom_ifwi_nodata.dts} (100%)
 rename tools/binman/test/{112_x86_rom_ifwi_nodesc.dts => x86/rom_ifwi_nodesc.dts} (100%)
 rename tools/binman/test/{151_x86_rom_ifwi_section.dts => x86/rom_ifwi_section.dts} (100%)
 rename tools/binman/test/{031_x86_rom_me.dts => x86/rom_me.dts} (100%)
 rename tools/binman/test/{163_x86_rom_me_empty.dts => x86/rom_me_empty.dts} (100%)
 rename tools/binman/test/{164_x86_rom_me_missing.dts => x86/rom_me_missing.dts} (100%)
 rename tools/binman/test/{030_x86_rom_me_no_desc.dts => x86/rom_me_no_desc.dts} (100%)
 rename tools/binman/test/{035_x86_single_ucode.dts => x86/single_ucode.dts} (100%)
 rename tools/binman/test/{033_x86_start16.dts => x86/start16.dts} (100%)
 rename tools/binman/test/{048_x86_start16_spl.dts => x86/start16_spl.dts} (100%)
 rename tools/binman/test/{081_x86_start16_tpl.dts => x86/start16_tpl.dts} (100%)
 rename tools/binman/test/{155_symbols_tpl_x86.dts => x86/symbols_tpl.dts} (100%)
 rename tools/binman/test/{093_x86_tpl_ucode.dts => x86/tpl_ucode.dts} (100%)
 rename tools/binman/test/{034_x86_ucode.dts => x86/ucode.dts} (100%)
 rename tools/binman/test/{038_x86_ucode_missing_node.dts => x86/ucode_missing_node.dts} (100%)
 rename tools/binman/test/{039_x86_ucode_missing_node2.dts => x86/ucode_missing_node2.dts} (100%)
 rename tools/binman/test/{040_x86_ucode_not_in_image.dts => x86/ucode_not_in_image.dts} (100%)
 rename tools/binman/test/{049_x86_ucode_spl.dts => x86/ucode_spl.dts} (100%)
 rename tools/binman/test/{058_x86_ucode_spl_needs_retry.dts => x86/ucode_spl_needs_retry.dts} (100%)
 rename tools/binman/test/{026_pack_u_boot_dtb.dts => xpl/pack_dtb.dts} (100%)
 rename tools/binman/test/{047_spl_bss_pad.dts => xpl/spl_bss_pad.dts} (100%)
 rename tools/binman/test/{078_u_boot_tpl.dts => xpl/tpl.dts} (100%)
 rename tools/binman/test/{193_tpl_bss_pad.dts => xpl/tpl_bss_pad.dts} (100%)
 rename tools/binman/test/{036_u_boot_img.dts => xpl/u-boot-img.dts} (100%)
 rename tools/binman/test/{051_u_boot_spl_dtb.dts => xpl/u-boot-spl-dtb.dts} (100%)
 rename tools/binman/test/{052_u_boot_spl_nodtb.dts => xpl/u-boot-spl-nodtb.dts} (100%)
 rename tools/binman/test/{285_spl_expand.dts => xpl/u-boot-spl.dts} (100%)
 rename tools/binman/test/{192_u_boot_tpl_nodtb.dts => xpl/u-boot-tpl-nodtb.dts} (100%)
 rename tools/binman/test/{256_u_boot_vpl_nodtb.dts => xpl/u-boot-vpl-nodtb.dts} (100%)
 rename tools/binman/test/{255_u_boot_vpl.dts => xpl/vpl.dts} (100%)
 rename tools/binman/test/{258_vpl_bss_pad.dts => xpl/vpl_bss_pad.dts} (100%)

-- 
2.43.0

base-commit: c0ca147ac6228949a6d6497531c9f2f4a0dc6c67
branch: bini-us2
