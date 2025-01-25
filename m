Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CA1C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 21:37:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C34680C91;
	Sat, 25 Jan 2025 22:37:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Jq0gAr1C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1B1480EC0; Sat, 25 Jan 2025 22:37:07 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F6BD80836
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 22:37:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5db689a87cbso6474267a12.3
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 13:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737841024; x=1738445824; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BggwSNveL1yOj5psG7KZvVmVKn7wLLLX5hMQynorQdY=;
 b=Jq0gAr1C+8fHeXuJjo6QofPEaFe/EL89ySSss1/DQxUUijHAjSij9W5S6xqdOHVDKg
 o68EJkVmiT1F2NubumXDQu6B08pS1wGz0wgGCNgTsNq3CU7wY4HpWjbUHYoWtfiaG2nV
 dFjZGdmGRECTEkdVYfhGlmxjh3NSchY/dux+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737841024; x=1738445824;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BggwSNveL1yOj5psG7KZvVmVKn7wLLLX5hMQynorQdY=;
 b=Qlcgpp+rwxxKQ61CwlCSD4ma8gmILWPmAFMjHjeGsmj6uOek9uxN71FHSikedcaCve
 l9XoKHwJ9GMwE2WyHj8d59Iig9OhHGff/fkk1ZNV0KEjbPKHDnv3AWyj76xIFg6ueFJF
 vKdnuq1Wy148JWPSrR5MxpVnyCwJ+PF05LozqtqGJwrRhefjYrYUINUStyYlu+i2yfAD
 7RAWRovEoCR9XleZ6hHwq9eWWyJSMEp44MTPWhb3L1ZydpZt7540DPPzF4kJzR6bs43H
 p0sAmQwofPpsISV7it4ty0En8XOdg9WrYJo2Crk99xhcJbb/XjayXVhAV+XeADx1iE8+
 GVZQ==
X-Gm-Message-State: AOJu0YzqXvgaesXpXl9yrO/5cqb2MROtxJx2B1XWdtIvXlKRcomcVvoT
 HuLKKwz5QbDCRtKRCRM2fJafibI1ukjlO+bac/wtoptHYOdcnW4WZv537lmWsWJEg2hbl/Hk0T3
 ufohT1XfN++b2BmXm/7QHK8XsjO3qub/JdPARsBwgNkbBcnayRw==
X-Gm-Gg: ASbGncvijJBbXrYn/2mtg+TOo8zhR+zYy+4yrj2iwoL6L7PUWGCP9HrCncX+itppLmG
 DjVXwhvYMDgEFD14FbOFf5Ik8P2k+ts7jQkz8qBmTa9shiwxATdMVxSO2v67VMlY=
X-Google-Smtp-Source: AGHT+IFioFxn92zrsoLYnP5WGRQIYEhrPlpY4TICdY21iia9B8esTGGStEm1d3SwnLll9X+ZXfQwt7vL0eEiXIZyYCA=
X-Received: by 2002:a05:6402:50d3:b0:5d9:a91:3382 with SMTP id
 4fb4d7f45d1cf-5db7d33958emr30549292a12.21.1737841023892; Sat, 25 Jan 2025
 13:37:03 -0800 (PST)
MIME-Version: 1.0
References: <20250124185605.372347-1-sjg@chromium.org>
 <20250124192056.GU60249@bill-the-cat>
 <CAFLszTjowGVr2R0=bz-h=sU0NHjP8CDaF04cfO1Kbh8d8F5nFA@mail.gmail.com>
 <20250125183025.GB60249@bill-the-cat>
In-Reply-To: <20250125183025.GB60249@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 25 Jan 2025 14:36:52 -0700
X-Gm-Features: AWEUYZlC2vMVlYjC_jqcvlsD56lwH7VQ0-nGJJnCLQ-UQNzyhfUC_c7gDTbi2r0
Message-ID: <CAFLszThbkdt_RqvDGr6nV4QvFG4u6z1uh7Yu=65es_ZA3_5tEQ@mail.gmail.com>
Subject: Re: [PATCH] test/py: Add a report show test durations
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@nvidia.com>, 
 Stephen Warren <swarren@wwwdotorg.org>
Content-Type: text/plain; charset="UTF-8"
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

On Sat, 25 Jan 2025 at 11:30, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Jan 25, 2025 at 10:14:05AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 24 Jan 2025 at 12:21, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Jan 24, 2025 at 11:56:04AM -0700, Simon Glass wrote:
> > >
> > > > Execution time varies widely with the existing tests. Provides a summary
> > > > of the time taken for each test, along with a histogram.
> > > >
> > > > Example:
> > > >
> > > >    Duration : Number of tests
> > > >    ======== : ========================================
> > > >        <1ms :  1
> > > >        <8ms :  1
> > > >       <20ms : # 20
> > > >       <30ms : ######## 127
> > > >       <50ms : ######################################## 582
> > > >       <75ms : ####### 102
> > > >      <100ms : ## 39
> > > >      <200ms : ##### 86
> > > >      <300ms : # 29
> > > >      <500ms : ## 42
> > > >      <750ms : # 16
> > > >       <1.0s : # 15
> > > >       <2.0s : # 23
> > > >       <3.0s :  13
> > > >       <5.0s :  9
> > > >       <7.5s :  1
> > > >      <10.0s :  6
> > > >      <20.0s :  12
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > >  test/py/conftest.py | 77 +++++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 77 insertions(+)
> > >
> > > Whitespace issues aside,
> >
> > Do you mean the blank lines? pylint wants those for top-level items.
>
> That's weird but OK.
>
> >  we should probably not do this every time, just
> > > when requested.
> >
> > I'd like to see it on each run, actually. It doesn't take any time to
> > calculate and it lets us see where the time is going.
>
> We already print the full time, and I think knowing what the tests are
> that take so long, so that we can see if there's anything to do about
> it, would be more helpful. The general feedback about our pytests today
> is they're already too verbose in the normal case.

This is what is shown in the full output (although with CI you have to
download the files to see it):

[-] Section: Timing Report
TIME: NOW: 2025/01/25 14:28:57.725945
TIME: SINCE-PREV: 0:00:00.001214
TIME: SINCE-START: 0:02:00.303750
   10.0s  test_time
    5.7s  test_bind_unbind_with_node
    5.3s  test_fit_auto_signed
    5.0s  test_pstore_display_all_records
    4.4s  test_bind_unbind_with_uclass
    3.9s  test_extension
    3.2s  test_sqfs_load
    3.0s  test_sleep
    3.0s  test_vboot[sha1-basic-sha1--None-False-True-False-False]
    2.5s  test_fit
    2.3s  test_sqfs_ls
    2.0s  test_pstore_display_one_record
    1.7s  test_dm_compat
    1.7s  test_ut_dm_init_bootstd
    1.6s  test_ut[ut_common_test_autoboot]
    1.2s  test_exception_exit
    1.2s  test_ab
    1.2s  test_dm_drivers
    1.1s  test_ut[ut_lib_test_udelay]
    1.0s  test_ut[ut_common_cread_test]
    1.0s  test_ut[ut_lib_test_time_comparison]
   913ms  test_clean
   880ms  test_mrproper
   691ms  test_dm_uclass
   647ms  test_dm_static
   608ms  test_pstore_save_records
   590ms  test_event_dump
   567ms  test_ut[ut_bootstd_bootflow_cmd_scan_e]
   549ms  test_ut[ut_bootstd_bootflow_cmd_info]
   475ms  test_tpm2_pcr_extend
   457ms  test_ut[ut_dm_dm_test_video_comp_bmp32]
   453ms  test_ut[ut_dm_dm_test_video_bmp32]
   448ms  test_ut[ut_dm_dm_test_video_bmp24_32]
   436ms  test_bootmenu
   433ms  test_ut[ut_dm_dm_test_osd_basics]
   423ms  test_help_no_devicetree
   406ms  test_env_initial_env_file
   392ms  test_ut[ut_dm_dm_test_osd_extended]
   370ms  test_pinmux_status_all
   369ms  test_abootimgv4
   348ms  test_tpm2_dam_parameters
   343ms  test_tpm2_change_auth
   321ms  test_tpm2_pcr_read
   316ms  test_tpm2_get_capability
   315ms  test_abootimg
   312ms  test_gpio_exit_statuses
   309ms  test_env_ext4
   308ms  test_ut[ut_lib_lib_crypt]
   303ms  test_dm_devres
   302ms  test_source
   288ms  test_ut[ut_dm_dm_test_nand1_start]
   283ms  test_ut[ut_dm_dm_test_panel]
   283ms  test_ut[ut_dm_dm_test_nand1_end]
   268ms  test_tpm2_clear
   265ms  test_tpm2_sandbox_self_test_full
   245ms  test_tpm2_continue_self_test
   236ms  test_stackprotector
   227ms  test_help
   225ms  test_ctrl_c
   224ms  test_env_import_whitelist
   224ms  test_ut[ut_fdt_fdt_test_print]
   221ms  test_log_dropped
   220ms  test_ut[ut_dm_dm_test_video_rotation2]
   218ms  test_env_import_whitelist_delete
   208ms  test_poweroff
   191ms  test_ut[ut_dm_dm_test_video_rotation3]
   190ms  test_ut[ut_bootstd_bootflow_iter_disable]
   188ms  test_ut[ut_dm_dm_test_video_rotation1]
   160ms  test_ut[ut_dm_dm_test_video_context]
   153ms  test_ut[ut_fdt_fdt_test_list]
   145ms  test_ut[ut_bootstd_bootflow_scan_boot]
   145ms  test_ut[ut_bootstd_bootflow_scan_extlinux]
   144ms  test_ut[ut_bootstd_bootflow_efi]
   143ms  test_ut[ut_bootstd_bootflow_scan_menu]
   141ms  test_gpio_read
   139ms  test_ut[ut_bootstd_bootdev_test_cmd_hunt]
   138ms  test_ut[ut_bootstd_bootflow_cmd_boot]
   136ms  test_ut[ut_bootstd_bootflow_scan_menu_boot]
   131ms  test_ut[ut_bootstd_bootflow_android_image_v4]
   131ms  test_ut[ut_bootstd_bootflow_cros]
   128ms  test_version
   127ms  test_ut[ut_dm_dm_test_fastboot_mmc_part]
   126ms  test_ut[ut_bootstd_bootflow_android_image_v2]
   124ms  test_efi_pre_commands
   118ms  test_ut[ut_dm_dm_test_usb_keyb]
   116ms  test_ut[ut_exit_cmd_exit_test]
   112ms  test_efi_helloworld_builtin
   111ms  test_ut[ut_dm_dm_test_bootcount_rtc]
   110ms  test_ut[ut_dm_dm_test_cmd_mux_list]
   107ms  test_ut[ut_fdt_fdt_test_apply]
   106ms  test_ut[ut_log_log_test_cat_allow]
   103ms  test_ut[ut_bootstd_bootmeth_cmd_order]
   102ms  test_ut[ut_bdinfo_bdinfo_test_full]
   101ms  test_ut[ut_bootstd_bootflow_scan_glob_bootmeth]
   100ms  test_ut[ut_dm_dm_test_blk_base]
    95ms  test_ut[ut_bootstd_bootflow_cmd_glob]
    91ms  test_ut[ut_bootstd_bootdev_test_cmd_list]
    91ms  test_ut[ut_dm_dm_test_video_text_12x22]
    90ms  test_ut[ut_bootstd_bootflow_cmd]
    90ms  test_env_expansion_spaces
    89ms  test_ut[ut_dm_dm_test_video_text]
    89ms  test_tpm2_cleanup
    88ms  test_env_info_sandbox
    87ms  test_ut[ut_log_log_test_file]
    85ms  test_ut[ut_dm_dm_test_cmd_hash_sha256]
    84ms  test_ut[ut_bootstd_bootflow_cmd_menu]
    83ms  test_ut[ut_bootstd_bootstd_images]
    83ms  test_ut[ut_bootstd_bootdev_test_next_prio]
    82ms  test_ut[ut_dm_dm_test_video_copy]
    82ms  test_ut[ut_dm_dm_test_part]
    80ms  test_ut[ut_bootstd_bootflow_cmd_label]
    76ms  test_ut[ut_env_env_test_htab_deletes]
    74ms  test_ut[ut_dm_dm_test_video_truetype_scroll]
    73ms  test_ut[ut_cmd_cmd_test_meminfo]
    73ms  test_ut[ut_dm_dm_test_video_ansi]
    68ms  test_ut[ut_bootstd_bootdev_test_order_default]
    68ms  test_ut[ut_bootstd_expo_render_image]
    68ms  test_ut[ut_log_log_test_dropped]
    67ms  test_ut[ut_bootstd_bootflow_cmd_hunt_single]
    67ms  test_button_return_code
    67ms  test_ut[ut_fdt_fdt_test_chosen]
    66ms  test_ut[ut_log_log_test_double]
    65ms  test_ut[ut_fdt_fdt_test_memory]
    65ms  test_cmd_smbios_sandbox
    65ms  test_ut[ut_bootstd_bootflow_menu_theme]
    65ms  test_ut[ut_dm_dm_test_eth_act]
    64ms  test_ut[ut_bootstd_bootdev_test_hunt_scan]
    64ms  test_ut[ut_log_log_test_triple]
    63ms  test_ut[ut_dm_dm_test_rkmtd_cmd]
    62ms  test_ut[ut_bootstd_bootdev_test_cmd_select]
    62ms  test_ut[ut_dm_dm_test_video_truetype_bs]
    62ms  test_ut[ut_dm_dm_test_acpi_cmd_items]
    62ms  test_shell_run
    62ms  test_ut[ut_bootstd_bootflow_cmd_hunt_label]
    62ms  test_env_info
    61ms  test_ut[ut_bootstd_bootdev_test_hunter]
    60ms  test_ut[ut_dm_dm_test_blk_find]
    60ms  test_ut[ut_dm_dm_test_cmd_host]
    60ms  test_ut[ut_dm_dm_test_blk_foreach]
    59ms  test_ut[ut_dm_dm_test_blk_devnum]
    58ms  test_ut[ut_dm_dm_test_part_get_info_by_type]
    58ms  test_ut[ut_dm_dm_test_armffa_cmd]
    58ms  test_ut[ut_fdt_overlay_fdt_overlay_test_change_str_property]
    58ms  test_ut[ut_dm_dm_test_spi_flash_func]
    58ms  test_ut[ut_dm_dm_test_blk_iter]
    57ms  test_ut[ut_dm_dm_test_blk_flags]
    55ms  test_md
    54ms  test_optee_rpmb_read_write
    54ms  test_env_import_checksum_no_size
    54ms  test_ut[ut_bootstd_bootdev_test_prio]
    53ms  test_ut[ut_dm_dm_test_ffa_nack]
    53ms  test_ut[ut_log_log_test_file_mid]
    51ms  test_ut[ut_common_print_display_buffer]
    51ms  test_avb_persistent_values
    51ms  test_ut[ut_dm_dm_test_nand0_start]
    51ms  test_ut[ut_fdt_overlay_fdt_overlay_test_change_int_property]
    50ms  test_gpio_input
    50ms  test_ut[ut_dm_dm_test_cmd_hash_md5]
    50ms  test_ut[ut_dm_dm_test_power_regulator_set_enable_if_allowed]
    50ms  test_ut[ut_dm_dm_test_power_regulator_set_get_suspend_voltage]
    49ms  test_ut[ut_bootstd_bootmeth_cmd_order_glob]
    49ms  test_ut[ut_dm_dm_test_power_regulator_set_get_suspend_enable]
    49ms  test_ut[ut_bootstd_bootflow_iter]
    49ms  test_ut[ut_hush_hush_test_simple_dollar]
    49ms  test_ut[ut_log_log_test_level]
    48ms  test_ut[ut_fdt_fdt_test_get_name]
    48ms  test_ut[ut_dm_dm_test_acpi_cmd_list]
    48ms  test_ut[ut_mbr_mbr_test_run]
    47ms  test_ut[ut_bootstd_bootflow_cmdline]
    47ms  test_ut[ut_fdt_overlay_fdt_overlay_test_add_node_by_path]
    47ms  test_ut[ut_bloblist_bloblist_test_checksum]
    47ms  test_shell_semicolon_three
    47ms  test_ut[ut_log_log_test_level_deny]
    46ms  test_ut[ut_fdt_overlay_fdt_overlay_test_add_node_by_phandle]
    46ms  test_ut[ut_bootstd_bootmeth_cmd_list]
    46ms  test_ut[ut_lib_lib_test_efi_log_mem]
    46ms  test_ut[ut_log_log_test_cat_deny_implicit]
    46ms  test_ut[ut_dm_dm_test_mmc_blk]
    46ms  test_ut[ut_bootstd_bootdev_test_hunt_prio]
    45ms  test_ut[ut_fdt_overlay_fdt_overlay_test_local_phandles]
    45ms  test_ut[ut_log_log_test_file_second]
    45ms  test_ut[ut_dm_dm_test_scmi_cmd]
    45ms  test_ut[ut_dm_dm_test_blk_get_from_parent]
    45ms  test_ut[ut_dm_dm_test_video_truetype]
    44ms  test_ut[ut_dm_dm_test_cmd_pinmux_status_pinname]
    44ms  test_ut[ut_fdt_fdt_test_get_size]
    44ms  test_ut[ut_fdt_overlay_fdt_overlay_test_local_phandle]
    44ms  test_ut[ut_dm_dm_test_ofnode_for_each_compatible_node]
    44ms  test_ut_dm_init
    44ms  test_ut[ut_dm_dm_test_spi_claim_bus]
    44ms  test_ut[ut_lib_lib_test_print_size]
    44ms  test_ut[ut_dm_dm_test_video_damage]
    44ms  test_ut[ut_lib_lib_test_hush_echo]
    44ms  test_ut[ut_dm_dm_test_power_regulator_set_get_current]
    43ms  test_ut[ut_dm_dm_test_power_regulator_set_get_voltage]
    43ms  test_ut[ut_dm_dm_test_video_bmp16]
    43ms  test_ut[ut_dm_dm_test_adc_wrong_channel_selection]
    43ms  test_ut[ut_bootstd_bootdev_test_order]
    43ms  test_ut[ut_bootstd_bootflow_system]
    43ms  test_ut[ut_fdt_fdt_test_rsvmem]
    43ms  test_ut[ut_dm_dm_test_pci_phys_to_bus]
    42ms  test_ut[ut_dm_dm_test_read_write]
    42ms  test_ut[ut_dm_dm_test_video_bmp24]
    42ms  test_ut[ut_dm_dm_test_eth_rotate]
    42ms  test_ut[ut_loadm_loadm_test_params]
    42ms  test_ut[ut_bootstd_bootmeth_cmd_set]
    42ms  test_ut[ut_dm_dm_test_rtc_cmd_rw]
    42ms  test_ut[ut_dm_dm_test_power_regulator_set_get_enable]
    42ms  test_ut[ut_dm_dm_test_uclass_devices_find_by_name]
    42ms  test_ut[ut_hush_hush_test_command_dollar]
    42ms  test_ut[ut_lib_lib_test_print_freq]
    42ms  test_ut[ut_dm_dm_test_adc_single_channel_conversion]
    42ms  test_ut[ut_dm_dm_test_acpi_cmd_dump]
    41ms  test_ut[ut_dm_dm_test_cros_ec_features]
    41ms  test_ut[ut_dm_dm_test_video_chars]
    41ms  test_ut[ut_common_print_do_hex_dump]
    41ms  test_ut[ut_dm_dm_test_video_bmp_comp]
    41ms  test_ut[ut_dm_dm_test_power_regulator_autoset_list]
    41ms  test_ut[ut_dm_dm_test_power_regulator_set_get_mode]
    41ms  test_ut[ut_log_log_test_min]
    41ms  test_ut[ut_fdt_fdt_test_get_addr]
    41ms  test_ut[ut_dm_dm_test_adc_multi_channel_conversion]
    41ms  test_ut[ut_lib_unicode_test_efi_create_indexed_name]
    41ms  test_ut[ut_setexpr_setexpr_test_fmt]
    40ms  test_ut[ut_dm_dm_test_bootcount_syscon_four_bytes]
    40ms  test_ut[ut_dm_dm_test_power_regulator_autoset]
    40ms  test_ut[ut_dm_dm_test_bus_child_post_probe_uclass]
    40ms  test_ut[ut_fdt_overlay_fdt_overlay_test_add_str_property]
    40ms  test_ut[ut_bootstd_bootdev_test_any]
    40ms  test_ut[ut_dm_dm_test_spi_find]
    40ms  test_ut[ut_fdt_overlay_fdt_overlay_test_stacked]
    40ms  test_ut[ut_dm_dm_test_part_bootable]
    40ms  test_ut[ut_bootstd_bootdev_test_bootable]
    40ms  test_ut[ut_dm_dm_test_power_pmic_mc34708_rw_val]
    39ms  test_ut[ut_dm_dm_test_bootcount_syscon_two_bytes]
    39ms  test_ut[ut_dm_dm_test_bus_child_pre_probe_uclass]
    39ms  test_ut[ut_dm_dm_test_uclass_devices_get_by_name]
    39ms  test_ut[ut_fdt_fdt_test_rm]
    39ms  test_ut[ut_lib_compression_test_bootm_zstd]
    39ms  test_ut[ut_lib_lib_test_efi_image_region_sort]
    39ms  test_ut[ut_bootstd_bootdev_test_hunt_label]
    39ms  test_ut[ut_dm_dm_test_bus_child_post_bind_uclass]
    39ms  test_ut[ut_dm_dm_test_spi_flash]
    39ms  test_ut[ut_lib_compression_test_bootm_gzip]
    39ms  test_ut[ut_dm_dm_test_fdt_disable_enable_by_path]
    39ms  test_ut[ut_dm_dm_test_acpi_write_processor_package]
    39ms  test_ut[ut_lib_unicode_test_utf8_to_cp437_stream]
    39ms  test_ut[ut_dm_dm_test_ofnode_get_child_count_ot]
    38ms  test_ut[ut_dm_dm_test_first_next_device_probeall]
    38ms  test_ut[ut_dm_dm_test_nand0_end]
    38ms  test_ut[ut_lib_compression_test_bootm_bzip2]
    38ms  test_ut[ut_dm_dm_test_fdtdec_add_reserved_memory]
    38ms  test_ut[ut_lib_unicode_test_utf8_to_utf32_stream]
    38ms  test_ut[ut_mem_mem_test_ms_cont]
    38ms  test_ut[ut_dm_dm_test_acpi_get_table_revision]
    38ms  test_ut[ut_dm_dm_test_button_cmd]
    38ms  test_ut[ut_lib_compression_test_bootm_lzma]
    38ms  test_ut[ut_dm_dm_test_autobind_uclass_pdata_valid]
    38ms  test_ut[ut_dm_dm_test_fdt_remap_addr_name_live]
    38ms  test_ut[ut_dm_dm_test_timer_timebase_fallback]
    38ms  test_ut[ut_bootstd_bootdev_test_next_label]
    38ms  test_ut[ut_dm_dm_test_acpi_ctx_and_base_tables]
    38ms  test_ut[ut_bloblist_bloblist_test_blob_maxsize]
    38ms  test_ut[ut_dm_dm_test_autobind_uclass_pdata_alloc]
    38ms  test_ut[ut_dm_dm_test_phy_bulk]
    37ms  test_ut[ut_dm_dm_test_ofnode_by_prop_value_ot]
    37ms  test_ut[ut_dm_dm_test_ofnode_get_by_phandle_ot]
    37ms  test_ut[ut_dm_dm_test_ofnode_livetree_writing]
    37ms  test_ut[ut_dm_dm_test_ofnode_by_compatible_ot]
    37ms  test_ut[ut_dm_dm_test_rng_cmd]
    37ms  test_ut[ut_lib_unicode_test_utf16_utf8_strncpy]
    37ms  test_ut[ut_log_log_test_cat_deny]
    37ms  test_ut[ut_bloblist_bloblist_test_cmd_info]
    37ms  test_ut[ut_bloblist_bloblist_test_resize_fail]
    37ms  test_ut[ut_bootstd_bootstd_adhoc]
    37ms  test_ut[ut_dm_dm_test_video_bmp]
    37ms  test_ut[ut_font_font_test_base]
    37ms  test_ut[ut_dm_dm_test_adc_single_channel_shot]
    37ms  test_ut[ut_dm_dm_test_spmi_access_peripheral]
    37ms  test_ut[ut_fdt_fdt_test_bootcpu]
    37ms  test_ut[ut_log_log_test_file_deny]
    37ms  test_env_set_existing
    37ms  test_ut[ut_dm_dm_test_fdt_remap_addr_index_flat]
    37ms  test_ut[ut_lib_unicode_test_utf16_utf8_strlen]
    37ms  test_ut[ut_lib_unicode_test_utf8_utf16_strnlen]
    37ms  test_ut[ut_dm_dm_test_mux_emul_default_state]
    37ms  test_ut[ut_lib_unicode_test_utf8_utf16_strncpy]
    37ms  test_ut[ut_dm_dm_test_acpi_write_processor_cnot]
    37ms  test_ut[ut_dm_dm_test_power_pmic_mc34708_get]
    36ms  test_ut[ut_lib_unicode_test_utf16_utf8_strnlen]
    36ms  test_ut[ut_dm_dm_test_eth_async_ping_reply]
    36ms  test_ut[ut_dm_dm_test_pci_bus_to_phys]
    36ms  test_ut[ut_dm_dm_test_bus_parent_data_uclass]
    36ms  test_ut[ut_dm_dm_test_fdt_remap_addr_name_flat]
    36ms  test_ut[ut_dm_dm_test_phy_ops]
    36ms  test_ut[ut_dm_dm_test_video_comp_bmp8]
    36ms  test_ut[ut_dm_dm_test_syscon_by_driver_data]
    36ms  test_ut[ut_dm_dm_test_mmc_base]
    36ms  test_ut[ut_dm_dm_test_oftree_to_fdt]
    36ms  test_ut[ut_lib_compression_test_bootm_lz4]
    36ms  test_ut[ut_lib_compression_test_gzip]
    36ms  test_ut[ut_lib_lib_test_lmb_overlapping_reserve]
    36ms  test_ut[ut_dm_dm_test_acpi_cmd_set]
    36ms  test_ut[ut_dm_dm_test_cros_ec_events]
    36ms  test_ut[ut_dm_dm_test_ofnode_get_child_count]
    36ms  test_ut[ut_lib_test_str_to_list]
    36ms  test_ut[ut_lib_compression_test_bootm_lzo]
    36ms  test_ut[ut_lib_unicode_test_utf16_utf8_strcpy]
    36ms  test_ut[ut_lib_unicode_test_utf8_utf16_strlen]
    36ms  test_ut[ut_fdt_fdt_test_header]
    36ms  test_ut[ut_fdt_overlay_fdt_overlay_test_add_subnode_property]
    36ms  test_ut[ut_lib_unicode_test_utf8_utf16_strcpy]
    36ms  test_ut[ut_dm_dm_test_decode_display_timing]
    36ms  test_ut[ut_dm_dm_test_adc_multi_channel_shot]
    36ms  test_ut[ut_dm_dm_test_eth_async_arp_reply]
    35ms  test_ut[ut_dm_dm_test_acpi_get_name]
    35ms  test_ut[ut_dm_dm_test_ofnode_get_by_phandle]
    35ms  test_ut[ut_dm_dm_test_scmi_voltage_domains]
    35ms  test_ut[ut_dm_dm_test_usb_fdt_node]
    35ms  test_ut[ut_dm_dm_test_fdt_uclass_seq_manual]
    35ms  test_ut[ut_dm_dm_test_mux_emul_select_deselect]
    35ms  test_ut[ut_lib_compression_test_lzma]
    35ms  test_ut[ut_lib_compression_test_zstd]
    35ms  test_ut[ut_bootstd_cedit_base]
    35ms  test_ut[ut_dm_dm_test_pinctrl_single]
    35ms  test_ut[ut_dm_dm_test_blk_usb]
    35ms  test_ut[ut_lib_compression_test_bootm_none]
    35ms  test_ut[ut_dm_dm_test_first_next_ok_device]
    35ms  test_ut[ut_lib_compression_test_bzip2]
    35ms  test_ut[ut_lib_lib_test_abuf_realloc_size]
    35ms  test_ut[ut_dm_dm_test_ofnode_by_compatible]
    35ms  test_ut[ut_dm_dm_test_ofnode_by_prop_value]
    35ms  test_ut[ut_dm_dm_test_ofnode_write_copy_ot]
    35ms  test_ut[ut_dm_dm_test_virtio_rng_check_len]
    35ms  test_ut[ut_log_log_test_helpers]
    35ms  test_ut[ut_dm_dm_test_power_regulator_get]
    35ms  test_ut[ut_hush_hush_test_env_dollar]
    35ms  test_ut[ut_mem_mem_test_ms_s]
    35ms  test_ut[ut_bloblist_bloblist_test_cmd_list]
    35ms  test_ut[ut_dm_dm_test_scmi_sandbox_agent]
    34ms  test_ut[ut_dm_dm_test_acpi_interrupt_or_gpio]
    34ms  test_ut[ut_dm_dm_test_ofnode_copy_node_ot]
    34ms  test_ut[ut_dm_dm_test_ofnode_copy_props_ot]
    34ms  test_ut[ut_dm_dm_test_ofnode_for_each_prop]
    34ms  test_ut[ut_dm_dm_test_ofnode_read_phy_mode]
    34ms  test_ut[ut_lib_lib_test_uuid_bits]
    34ms  test_ut[ut_bloblist_bloblist_test_resize_last]
    34ms  test_ut[ut_dm_dm_test_iommu_pci_noiommu]
    34ms  test_ut[ut_dm_dm_test_eth_alias]
    34ms  test_ut[ut_dm_dm_test_mux_mmio_select]
    34ms  test_ut[ut_dm_dm_test_wdt_watchdog_reset]
    34ms  test_ut[ut_dm_dm_test_ofnode_read_aliases]
    34ms  test_ut[ut_dm_dm_test_virtio_missing_ops]
    34ms  test_ut[ut_lib_lib_test_abuf_realloc_inc]
    34ms  test_ut[ut_bootstd_test_bootflow_cmdline_set]
    34ms  test_ut[ut_dm_dm_test_bus_children_of_offset]
    34ms  test_ut[ut_dm_dm_test_cmd_temperature]
    34ms  test_ut[ut_dm_dm_test_pci_ea]
    34ms  test_ut[ut_lib_lib_test_lmb_get_free_size]
    34ms  test_ut[ut_lib_lib_test_efi_dp_check_length]
    34ms  test_ut[ut_dm_dm_test_decode_panel_timing]
    34ms  test_ut[ut_dm_dm_test_devm_mux_mmio]
    34ms  test_ut[ut_dm_dm_test_fdt_remap_addr_live]
    34ms  test_ut[ut_dm_dm_test_scmi_power_domains]
    34ms  test_env_set_non_existent
    34ms  test_ut[ut_dm_dm_test_ofprop_get_property]
    34ms  test_ut[ut_dm_dm_test_bus_child_post_bind]
    34ms  test_ut[ut_dm_dm_test_ofnode_add_subnode]
    34ms  test_ut[ut_dm_dm_test_uclass_find_device]
    34ms  test_ut[ut_dm_dm_test_usb_flash]
    34ms  test_ut[ut_lib_unicode_test_u16_strcasecmp]
    34ms  test_ut[ut_dm_dm_test_ofnode_find_subnode]
    34ms  test_ut[ut_dm_dm_test_ofnode_phy_is_fixed_link]
    33ms  test_ut[ut_dm_dm_test_ofnode_read_fmap_entry]
    33ms  test_ut[ut_bootstd_bootflow_cmdline_special]
    33ms  test_ut[ut_dm_dm_test_acpi_resource_template]
    33ms  test_ut[ut_dm_dm_test_ffa_ack]
    33ms  test_ut[ut_dm_dm_test_ofnode_find_subnode_ot]
    33ms  test_ut[ut_dm_dm_test_cros_ec_switches]
    33ms  test_ut[ut_fdt_fdt_test_addr]
    33ms  test_ut[ut_dm_dm_test_ofnode_read_chosen]
    33ms  test_ut[ut_dm_dm_test_tpm_autostart_reinit]
    33ms  test_ut[ut_hush_hush_test_if_basic_operators]
    33ms  test_env_import_whitelist_checksum_no_size
    33ms  test_ut[ut_lib_lib_test_hush_pause]
    33ms  test_ut[ut_dm_dm_test_acpi_device_status]
    33ms  test_ut[ut_lib_lib_test_abuf_uninit_move]
    33ms  test_ut[ut_dm_dm_test_dev_get_attach_bus]
    33ms  test_ut[ut_dm_dm_test_power_pmic_mc34708_regs_check]
    33ms  test_ut[ut_dm_dm_test_syscon_by_phandle]
    33ms  test_ut[ut_dm_dm_test_syscon_reset]
    33ms  test_ut[ut_fdt_fdt_test_resize]
    33ms  test_ut[ut_setexpr_setexpr_test_str_oper]
    33ms  test_ut[ut_dm_dm_test_wdt_gpio_level]
    32ms  test_ut[ut_dm_dm_test_acpi_spi]
    32ms  test_ut[ut_dm_dm_test_button_linux_code]
    32ms  test_ut[ut_dm_dm_test_fdt_remap_addr_flat]
    32ms  test_ut[ut_dm_dm_test_ofnode_copy_props]
    32ms  test_ut[ut_dm_dm_test_ofnode_write_copy]
    32ms  test_ut[ut_dm_dm_test_sysreset_get_last]
    32ms  test_ut[ut_dm_dm_test_video_bmp8]
    32ms  test_ut[ut_dm_dm_test_acpi_write_processor]
    32ms  test_ut[ut_dm_dm_test_devm_regmap_field]
    32ms  test_ut[ut_dm_dm_test_led_default_state]
    32ms  test_ut[ut_dm_dm_test_ofnode_compatible]
    32ms  test_ut[ut_lib_compression_test_lzo]
    32ms  test_ut[ut_lib_lib_test_alist_init]
    32ms  test_ut[ut_lib_net_test_wget]
    32ms  test_ut[ut_bloblist_bloblist_test_reloc]
    32ms  test_ut[ut_dm_dm_test_rtc_cmd_list]
    32ms  test_ut[ut_mem_mem_test_ms_mult]
    32ms  test_ut[ut_bootstd_vbe_simple_test_base]
    32ms  test_ut[ut_dm_dm_test_bus_parent_plat_uclass]
    32ms  test_ut[ut_dm_dm_test_ofnode_get_reg_ot]
    32ms  test_ut[ut_dm_dm_test_ofnode_is_enabled]
    32ms  test_ut[ut_dm_dm_test_tpm_report_state]
    32ms  test_ut[ut_dm_dm_test_hwspinlock_base]
    32ms  test_ut[ut_dm_dm_test_ofnode_is_enabled_ot]
    32ms  test_ut[ut_dm_dm_test_uclass_devices_find]
    32ms  test_ut[ut_dm_dm_test_remoteproc_elf]
    32ms  test_ut[ut_dm_dm_test_reset_bulk_devm]
    32ms  test_ut[ut_dm_dm_test_uclass_before_ready]
    32ms  test_ut[ut_fdt_overlay_Afdt_overlay_init]
    32ms  test_env_unset_non_existent
    32ms  test_env_unset_existing
    32ms  test_ut[ut_lib_unicode_test_utf16_strnlen]
    32ms  test_ut[ut_dm_dm_test_acpi_gpio_toggle]
    32ms  test_ut[ut_dm_dm_test_acpi_write_tsd_package]
    32ms  test_ut[ut_dm_dm_test_cmd_mux_deselect]
    32ms  test_ut[ut_dm_dm_test_ofnode_copy_node]
    32ms  test_ut[ut_dm_dm_test_pci_region_multi]
    32ms  test_ut[ut_env_env_test_attrs_lookup_regex]
    32ms  test_ut[ut_lib_test_get_timer]
    32ms  test_ut[ut_lib_unicode_test_utf_to_lower]
    32ms  test_ut[ut_fdt_fdt_test_mknode]
    32ms  test_ut[ut_lib_lib_test_lmb_unaligned_size]
    31ms  test_ut[ut_dm_dm_test_acpi_inject_dsdt]
    31ms  test_ut[ut_dm_dm_test_i2c_addr_offset]
    31ms  test_ut[ut_dm_dm_test_irq_get_by_index]
    31ms  test_ut[ut_dm_dm_test_ofnode_root_mult]
    31ms  test_ut[ut_dm_dm_test_wdt_gpio_toggle]
    31ms  test_ut[ut_lib_unicode_test_u16_strnlen]
    31ms  test_ut[ut_bloblist_bloblist_test_bad_blob]
    31ms  test_ut[ut_dm_dm_test_acpi_device_path]
    31ms  test_ut[ut_dm_dm_test_cros_ec_hello]
    31ms  test_ut[ut_dm_dm_test_first_child_probe]
    31ms  test_ut[ut_dm_dm_test_ofnode_phandle]
    31ms  test_ut[ut_dm_dm_test_ofnode_u32_array]
    31ms  test_ut[ut_fdt_fdt_test_get_value]
    31ms  test_ut[ut_setexpr_setexpr_test_regex_inc]
    31ms  test_ut[ut_bloblist_bloblist_test_init]
    31ms  test_ut[ut_dm_dm_test_acpi_fill_header]
    31ms  test_ut[ut_dm_dm_test_button_keys_adc]
    31ms  test_ut[ut_dm_dm_test_spi_xfer]
    31ms  test_ut[ut_lib_lib_test_alist_empty]
    31ms  test_ut[ut_lib_unicode_test_u16_strncmp]
    31ms  test_ut[ut_bootstd_cedit_env]
    31ms  test_ut[ut_dm_dm_test_ip6_make_lladdr]
    31ms  test_ut[ut_dm_dm_test_pch_ioctl]
    31ms  test_ut[ut_lib_unicode_test_u16_strlcat]
    31ms  test_pinmux_status
    31ms  test_ut[ut_dm_dm_test_fdt_translation]
    31ms  test_ut[ut_dm_dm_test_uclass_devices_get]
    31ms  test_ut[ut_log_log_test_cont]
    31ms  test_ut[ut_dm_dm_test_acpi_write_tss]
    31ms  test_ut[ut_dm_dm_test_bus_parent_data]
    31ms  test_ut[ut_dm_dm_test_device_get_uclass_id]
    31ms  test_ut[ut_dm_dm_test_virtio_all_ops]
    31ms  test_ut[ut_dm_dm_test_net_retry]
    31ms  test_ut[ut_dm_dm_test_ofnode_get_name]
    31ms  test_ut[ut_dm_dm_test_ofnode_get_path]
    31ms  test_ut[ut_dm_dm_test_reboot_mode_gpio]
    31ms  test_ut[ut_dm_dm_test_remoteproc_base]
    31ms  test_ut[ut_dm_dm_test_rtc_read_write]
    31ms  test_ut[ut_lib_lib_test_abuf_map_sysmem]
    31ms  test_ut[ut_fdt_fdt_test_addr_resize]
    31ms  test_ut[ut_setexpr_setexpr_test_str_long]
    31ms  test_ut[ut_dm_dm_test_fdt_uclass_seq]
    31ms  test_ut[ut_dm_dm_test_livetree_ensure]
    30ms  test_ut[ut_dm_dm_test_acpi_write_i2c_dsm]
    30ms  test_ut[ut_dm_dm_test_acpi_write_pss_psd]
    30ms  test_ut[ut_dm_dm_test_bus_parent_plat]
    30ms  test_ut[ut_dm_dm_test_power_pmic_io]
    30ms  test_ut[ut_dm_dm_test_usb_multi]
    30ms  test_ut[ut_dm_dm_test_virtio_remove]
    30ms  test_ut[ut_lib_unicode_test_u16_strlen]
    30ms  test_ut[ut_bloblist_bloblist_test_shrink]
    30ms  test_ut[ut_common_dm_test_cyclic_running]
    30ms  test_ut[ut_dm_dm_test_ip6_addr_in_subnet]
    30ms  test_ut[ut_dm_dm_test_ofnode_get_reg]
    30ms  test_ut[ut_lib_lib_test_lmb_alloc_addr]
    30ms  test_ut[ut_lib_unicode_test_u16_strcpy]
    30ms  test_ut[ut_mem_mem_test_ms_limit]
    30ms  test_ut[ut_bootstd_bootflow_cmdline_get]
    30ms  test_ut[ut_dm_dm_test_i2c_probe_empty]
    30ms  test_ut[ut_dm_dm_test_i2c_reg_clrset]
    30ms  test_ut[ut_dm_dm_test_uclass_foreach]
    30ms  test_ut[ut_lib_unicode_test_u16_strdup]
    30ms  test_ut[ut_bootstd_expo_object_attr]
    30ms  test_ut[ut_dm_dm_test_ofnode_aliases]
    30ms  test_ut[ut_dm_dm_test_simple_pm_bus]
    30ms  test_ut[ut_bdinfo_bdinfo_test_help]
    30ms  test_ut[ut_dm_dm_test_i2c_offset_len]
    30ms  test_ut[ut_dm_dm_test_iommu_noiommu]
    30ms  test_ut[ut_dm_dm_test_power_pmic_get]
    30ms  test_ut[ut_dm_dm_test_uclass_drvdata]
    30ms  test_ut[ut_dm_dm_test_acpi_power_seq]
    30ms  test_ut[ut_dm_dm_test_cmd_mux_select]
    30ms  test_ut[ut_dm_dm_test_ofnode_too_many]
    30ms  test_ut[ut_dm_dm_test_read_resource]
    30ms  test_ut[ut_lib_lib_test_alist_filter]
    30ms  test_ut[ut_bootstd_expo_object_menu]
    30ms  test_ut[ut_dm_dm_test_eth_prime]
    30ms  test_ut[ut_dm_dm_test_virtio_ring]
    30ms  test_ut[ut_lib_lib_test_lmb_simple_x2]
    30ms  test_ut[ut_bdinfo_bdinfo_test_memory]
    30ms  test_ut[ut_bootstd_expo_scene_no_id]
    30ms  test_ut[ut_dm_dm_test_acpi_fill_madt]
    30ms  test_ut[ut_dm_dm_test_acpi_gpio_irq]
    30ms  test_ut[ut_dm_dm_test_acpi_interrupt]
    30ms  test_ut[ut_dm_dm_test_bus_parent_ops]
    30ms  test_ut[ut_dm_dm_test_cros_ec_vstore]
    30ms  test_ut[ut_dm_dm_test_dev_get_attach]
    30ms  test_ut[ut_dm_dm_test_firmware_probe]
    30ms  test_ut[ut_dm_dm_test_acpi_write_values]
    30ms  test_ut[ut_dm_dm_test_fdt_get_addr_ptr_flat]
    30ms  test_ut[ut_dm_dm_test_fdt_uclass_seq_more]
    30ms  test_ut[ut_dm_dm_test_ofnode_read_ot]
    30ms  test_ut[ut_dm_dm_test_tpm_autostart]
    30ms  test_ut[ut_hush_hush_test_if_hexadecimal]
    30ms  test_ut[ut_dm_dm_test_acpi_dp_new_table]
    30ms  test_ut[ut_dm_dm_test_ofnode_phandle_ot]
    30ms  test_ut[ut_lib_lib_test_efi_log_base]
    30ms  test_ut[ut_lib_unicode_test_utf16_get]
    30ms  test_ut[ut_lib_unicode_test_utf_to_cp]
    30ms  test_ut[ut_dm_dm_test_ofnode_string_err]
    30ms  test_ut[ut_dm_dm_test_scsi_base]
    30ms  test_ut[ut_dm_dm_test_usb_stop]
    29ms  test_pinmux_dev_bad
    29ms  test_ut[ut_bloblist_bloblist_test_align]
    29ms  test_ut[ut_env_env_test_attrs_lookup]
    29ms  test_ut[ut_lib_unicode_test_utf16_put]
    29ms  test_ut[ut_dm_dm_test_ofnode_delete]
    29ms  test_ut[ut_dm_dm_test_regmap_syscon]
    29ms  test_ut[ut_dm_dm_test_sysreset_walk]
    29ms  test_ut[ut_pci_mps_test_pci_mps_safe]
    29ms  test_ut[ut_common_test_event_probe]
    29ms  test_ut[ut_dm_dm_test_regmap_getset]
    29ms  test_ut[ut_dm_dm_test_sysreset_base]
    29ms  test_ut[ut_dm_dm_test_try_first_device]
    29ms  test_ut[ut_lib_lib_test_efi_image_region_add]
    29ms  test_ut[ut_hush_hush_test_if_inverted]
    29ms  test_ut[ut_hush_hush_test_if_z_operator]
    29ms  test_ut[ut_dm_dm_test_adc_raw_to_uV]
    29ms  test_ut[ut_lib_lib_test_alist_for_each]
    29ms  test_ut[ut_lib_unicode_test_string16]
    29ms  test_ut[ut_dm_dm_test_bus_children_funcs]
    29ms  test_ut[ut_dm_dm_test_ofdata_order]
    29ms  test_ut[ut_dm_dm_test_ofnode_string]
    29ms  test_ut[ut_setexpr_setexpr_test_backref]
    29ms  test_ut[ut_dm_dm_test_acpi_dp_multiple]
    29ms  test_ut[ut_dm_dm_test_acpi_emit_string]
    29ms  test_ut[ut_dm_dm_test_alias_highest_id]
    29ms  test_ut[ut_dm_dm_test_i2c_read_write]
    29ms  test_ut[ut_dm_dm_test_sysinfo_gpio]
    29ms  test_ut[ut_dm_dm_test_video_base]
    29ms  test_ut[ut_lib_lib_test_alist_add]
    29ms  test_ut[ut_setexpr_setexpr_test_regex]
    29ms  test_ut[ut_dm_dm_test_acpi_emit_simple]
    29ms  test_ut[ut_dm_dm_test_acpi_emit_stream]
    29ms  test_ut[ut_dm_dm_test_button_label]
    29ms  test_ut[ut_lib_lib_test_lmb_noreserved]
    29ms  test_ut[ut_dm_dm_test_acpi_fill_ssdt]
    29ms  test_ut[ut_dm_dm_test_devres_kmalloc_array]
    29ms  test_ut[ut_dm_dm_test_pci_addr_live]
    29ms  test_ut[ut_dm_dm_test_power_domain]
    28ms  test_ut[ut_bootm_bootm_test_silent_var]
    28ms  test_ut[ut_dm_dm_test_child_ofdata]
    28ms  test_ut[ut_dm_dm_test_pwm_cmd]
    28ms  test_ut[ut_lib_lib_test_dynamic_uuid]
    28ms  test_ut[ut_lib_unicode_test_utf8_get]
    28ms  test_ut[ut_bloblist_bloblist_test_blob]
    28ms  test_ut[ut_bloblist_bloblist_test_grow]
    28ms  test_ut[ut_bootstd_bootdev_test_labels]
    28ms  test_ut[ut_dm_dm_test_i2c_bytewise]
    28ms  test_ut[ut_dm_dm_test_inactive_child]
    28ms  test_ut[ut_dm_dm_test_pci_addr_flat]
    28ms  test_ut[ut_dm_dm_test_phy_multi_exit]
    28ms  test_ut[ut_lib_lib_test_abuf_init_move]
    28ms  test_ut[ut_dm_dm_test_acpi_write_cond]
    28ms  test_ut[ut_dm_dm_test_bus_children]
    28ms  test_ut[ut_hush_hush_test_if_inverted_binary]
    28ms  test_ut[ut_dm_dm_test_fdt_remap_addr_index_live]
    28ms  test_ut[ut_dm_dm_test_livetree_align]
    28ms  test_ut[ut_lib_lib_test_lmb_big]
    28ms  test_ut[ut_dm_dm_test_cros_ec_pwm]
    28ms  test_ut[ut_dm_dm_test_ecdsa_verify]
    28ms  test_ut[ut_dm_dm_test_reboot_mode_rtc]
    28ms  test_ut[ut_dm_dm_test_rtc_set_get]
    28ms  test_ut[ut_dm_dm_test_acpi_write_name]
    28ms  test_ut[ut_dm_dm_test_cmd_blkmap]
    28ms  test_ut[ut_dm_dm_test_device_reparent]
    28ms  test_ut[ut_dm_dm_test_dsa]
    28ms  test_ut[ut_dm_dm_test_spmi_access]
    28ms  test_ut[ut_hush_hush_test_for]
    28ms  test_ut[ut_dm_dm_test_csum_ipv6_magic]
    28ms  test_ut[ut_dm_dm_test_led_blink]
    28ms  test_ut[ut_dm_dm_test_read_phandle]
    28ms  test_ut[ut_dm_dm_test_remove_active_dma]
    28ms  test_ut[ut_dm_dm_test_scmi_clocks]
    28ms  test_ut[ut_bootstd_Abootstd_setup_for_tests]
    28ms  test_ut[ut_dm_dm_test_acpi_write_tables]
    28ms  test_ut[ut_dm_dm_test_button_gpio]
    28ms  test_ut[ut_dm_dm_test_fdt_phandle]
    28ms  test_ut[ut_dm_dm_test_phys_to_bus]
    28ms  test_ut[ut_dm_dm_test_pmc_base]
    28ms  test_ut[ut_dm_dm_test_syscon_base]
    28ms  test_ut[ut_fdt_fdt_test_move]
    28ms  test_ut[ut_lib_lib_rsa_verify_invalid]
    28ms  test_ut[ut_dm_dm_test_led_toggle]
    28ms  test_ut[ut_dm_dm_test_qfw_firmware_list]
    28ms  test_ut[ut_dm_dm_test_wdt_base]
    28ms  test_ut[ut_lib_lib_rsa_verify_valid]
    28ms  test_ut[ut_cmd_command_test]
    28ms  test_ut[ut_dm_dm_test_devm_regmap]
    28ms  test_ut[ut_dm_dm_test_pci_drvdata]
    27ms  test_ut[ut_dm_dm_test_all_have_seq]
    27ms  test_ut[ut_dm_dm_test_blkmap_slicing]
    27ms  test_ut[ut_dm_dm_test_dev_get_mem]
    27ms  test_ut[ut_dm_dm_test_eth]
    27ms  test_ut[ut_dm_dm_test_ofnode_conf]
    27ms  test_ut[ut_dm_dm_test_pci_on_bus]
    27ms  test_ut[ut_dm_dm_test_rng_read]
    27ms  test_ut[ut_hush_hush_test_if_octal]
    27ms  test_ut[ut_lib_lib_test_alist_ensure]
    27ms  test_ut[ut_log_log_test_disable]
    27ms  test_ut[ut_setexpr_setexpr_test_plus]
    27ms  test_ut[ut_dm_dm_test_acpi_write_prw]
    27ms  test_ut[ut_dm_dm_test_ofnode_options]
    27ms  test_ut[ut_dm_dm_test_timer_base]
    27ms  test_ut[ut_lib_lib_test_abuf_init_set]
    27ms  test_ut[ut_lib_unicode_test_utf8_put]
    27ms  test_ut[ut_dm_dm_test_string_to_ip6]
    27ms  test_ut[ut_setexpr_setexpr_test_oper]
    27ms  test_ut[ut_bootstd_test_image_phase]
    27ms  test_ut[ut_dm_dm_test_acpi_power_res]
    27ms  test_ut[ut_dm_dm_test_acpi_write_csd]
    27ms  test_ut[ut_dm_dm_test_acpi_write_cst]
    27ms  test_ut[ut_dm_dm_test_adc_supply]
    27ms  test_ut[ut_dm_dm_test_devres_kcalloc]
    27ms  test_ut[ut_dm_dm_test_dma_m2m]
    27ms  test_ut[ut_dm_dm_test_ofnode_fmap]
    27ms  test_ut[ut_common_print_hexdump_line]
    27ms  test_ut[ut_dm_dm_test_acpi_basic]
    27ms  test_ut[ut_dm_dm_test_acpi_dp_copy]
    27ms  test_ut[ut_dm_dm_test_acpi_write_return]
    27ms  test_ut[ut_dm_dm_test_remove_active]
    27ms  test_ut[ut_dm_dm_test_devres_phase]
    27ms  test_ut[ut_dm_dm_test_ofnode_read]
    27ms  test_ut[ut_dm_dm_test_reset_devm]
    27ms  test_ut[ut_dm_dm_test_dma_ranges]
    27ms  test_ut[ut_dm_dm_test_fdt_pre_reloc]
    27ms  test_ut[ut_lib_lib_test_hex_to_bin]
    27ms  test_ut[ut_lib_lib_test_is_enabled]
    27ms  test_ut[ut_lib_lib_test_uuid_to_le]
    27ms  test_ut[ut_loadm_loadm_test_load]
    27ms  test_ut[ut_setexpr_setexpr_test_str]
    27ms  test_ut[ut_setexpr_setexpr_test_sub]
    27ms  test_ut[ut_dm_dm_test_axi_busnum]
    27ms  test_ut[ut_dm_dm_test_dma_rx]
    27ms  test_ut[ut_dm_dm_test_oftree_new]
    27ms  test_ut[ut_dm_dm_test_pci_mixed]
    27ms  test_ut[ut_bootstd_expo_test_build]
    27ms  test_ut[ut_dm_dm_test_acpi_dp_int16]
    27ms  test_ut[ut_dm_dm_test_acpi_find_table]
    27ms  test_ut[ut_dm_dm_test_acpi_scope]
    27ms  test_ut[ut_dm_dm_test_axi_store]
    27ms  test_ut[ut_dm_dm_test_dma_offset]
    27ms  test_ut[ut_dm_dm_test_ip6_make_snma]
    27ms  test_ut[ut_dm_dm_test_led_label]
    27ms  test_ut[ut_dm_dm_test_ofnode_u32]
    27ms  test_ut[ut_dm_dm_test_ofnode_u64]
    27ms  test_ut[ut_lib_lib_test_lmb_simple]
    27ms  test_ut[ut_log_log_test_buffer]
    26ms  test_ut[ut_dm_dm_test_dsa_probe]
    26ms  test_ut[ut_dm_dm_test_rkmtd_dup]
    26ms  test_ut[ut_lib_lib_test_abuf_large]
    26ms  test_ut[ut_bootm_bootm_test_silent]
    26ms  test_ut[ut_dm_dm_test_acpi_dp_array]
    26ms  test_ut[ut_dm_dm_test_irq_base]
    26ms  test_ut[ut_dm_dm_test_pci_swapcase]
    26ms  test_ut[ut_dm_dm_test_rtc_reset]
    26ms  test_ut[ut_dm_dm_test_scmi_base]
    26ms  test_ut[ut_bootm_bootm_test_nospace]
    26ms  test_ut[ut_bootm_bootm_test_subst_both]
    26ms  test_ut[ut_dm_dm_test_acpi_dp_child]
    26ms  test_ut[ut_dm_dm_test_axi_base]
    26ms  test_ut[ut_dm_dm_test_pch_base]
    26ms  test_ut[ut_dm_dm_test_sysreset_get_status]
    26ms  test_ut[ut_fdt_fdt_test_set]
    26ms  test_ut[ut_lib_lib_test_alist_next]
    26ms  test_ut[ut_lib_lib_test_lmb_at_0]
    26ms  test_md_repeat
    26ms  test_ut[ut_bootstd_expo_object]
    26ms  test_ut[ut_common_test_event_simple]
    26ms  test_ut[ut_dm_dm_test_regmap_poll]
    26ms  test_ut[ut_dm_dm_test_regmap_rw]
    26ms  test_ut[ut_dm_dm_test_uclass_names]
    26ms  test_ut[ut_hush_hush_test_semicolon]
    26ms  test_ut[ut_mem_mem_test_ms_b]
    26ms  test_ut[ut_dm_dm_test_blkmap_write]
    26ms  test_ut[ut_dm_dm_test_first_child]
    26ms  test_ut[ut_dm_dm_test_iommu_pci]
    26ms  test_ut[ut_dm_dm_test_smem_base]
    26ms  test_ut[ut_dm_dm_test_sound]
    26ms  test_ut[ut_lib_lib_test_abuf_uninit]
    26ms  test_ut[ut_lib_test_timer_get_us]
    26ms  test_ut[ut_mem_mem_test_ms_quiet]
    26ms  test_avb_verify
    26ms  test_ut[ut_dm_dm_test_acpi_gpio]
    26ms  test_ut[ut_dm_dm_test_devres_alloc]
    26ms  test_ut[ut_env_env_test_fdt_import]
    26ms  test_ut[ut_hush_hush_test_if_binary]
    26ms  test_ut[ut_dm_dm_test_acpi_dp_int8]
    26ms  test_ut[ut_dm_dm_test_p2sb_base]
    26ms  test_ut[ut_dm_dm_test_rtc_base]
    26ms  test_ut[ut_dm_dm_test_rtc_dual]
    26ms  test_ut[ut_env_env_test_env_cmd]
    26ms  test_ut[ut_lib_lib_test_abuf_init]
    26ms  test_ut[ut_lib_lib_test_lmb_flags]
    26ms  test_ut[ut_dm_dm_test_clk_bulk]
    26ms  test_ut[ut_dm_dm_test_efi_media]
    26ms  test_ut[ut_lib_str_simple_strtoul]
    26ms  test_ut[ut_lib_str_simple_strtoull]
    26ms  test_env_echo_exists
    26ms  test_ut[ut_dm_dm_test_get_stats]
    26ms  test_ut[ut_dm_dm_test_phy_base]
    26ms  test_ut[ut_dm_dm_test_usb_base]
    26ms  test_ut[ut_dm_dm_test_acpi_offsets]
    26ms  test_ut[ut_dm_dm_test_acpi_package]
    26ms  test_ut[ut_dm_dm_test_blkmap_creation]
    26ms  test_ut[ut_dm_dm_test_button_base]
    26ms  test_ut[ut_dm_dm_test_read_and_clear]
    26ms  test_ut[ut_dm_dm_test_read_int_index]
    26ms  test_ut[ut_mem_mem_test_ms_w]
    26ms  test_ut[ut_dm_dm_test_acpi_integer]
    26ms  test_ut[ut_dm_dm_test_clk_base]
    26ms  test_ut[ut_dm_dm_test_compare_node_name]
    26ms  test_ut[ut_dm_dm_test_mdio_mux]
    26ms  test_ut[ut_dm_dm_test_pci_base]
    26ms  test_ut[ut_dm_dm_test_simple_bus]
    25ms  test_ut[ut_dm_dm_test_adc_bind]
    25ms  test_ut[ut_dm_dm_test_led_base]
    25ms  test_ut[ut_dm_dm_test_led_gpio]
    25ms  test_ut[ut_dm_dm_test_pwm_base]
    25ms  test_ut[ut_hush_hush_test_while]
    25ms  test_ut[ut_dm_dm_test_blkmap_read]
    25ms  test_ut[ut_dm_dm_test_i2c_offset]
    25ms  test_ut[ut_bootm_bootm_test_subst_var]
    25ms  test_ut[ut_bootstd_expo_base]
    25ms  test_ut[ut_dm_dm_test_acpi_i2c]
    25ms  test_ut[ut_dm_dm_test_devres_free]
    25ms  test_ut[ut_dm_dm_test_fdt_offset]
    25ms  test_ut[ut_dm_dm_test_irq_type]
    25ms  test_ut[ut_dm_dm_test_virtio_base]
    25ms  test_ut[ut_hush_hush_test_and_or]
    25ms  test_ut[ut_hush_hush_test_if_mixed]
    25ms  test_ut[ut_common_test_event_base]
    25ms  test_ut[ut_dm_dm_test_host_dup]
    25ms  test_ut[ut_hush_hush_test_or_and]
    25ms  test_ut[ut_hush_hush_test_until]
    25ms  test_ut[ut_dm_dm_test_dsi_host]
    25ms  test_ut[ut_dm_dm_test_ofnode_get_path_ot]
    25ms  test_ut[ut_dm_dm_test_reset_base]
    25ms  test_ut[ut_dm_dm_test_pci_cap]
    25ms  test_ut[ut_dm_dm_test_tag_del_all]
    25ms  test_ut[ut_measurement_measure]
    25ms  test_ut[ut_bootstd_expo_scene]
    25ms  test_ut[ut_dm_dm_test_acpi_device]
    25ms  test_ut[ut_dm_dm_test_acpi_string]
    25ms  test_ut[ut_lib_lib_test_alist_get]
    25ms  test_env_text
    25ms  test_ut[ut_bootstd_bootmeth_state]
    25ms  test_ut[ut_dm_dm_test_i2c_find]
    25ms  test_ut[ut_dm_dm_test_sysinfo]
    25ms  test_ut[ut_lib_lib_test_alist_has]
    25ms  test_ut[ut_dm_dm_test_pinmux]
    24ms  test_ut[ut_bootstd_cedit_cmos]
    24ms  test_ut[ut_env_env_test_htab_fill]
    24ms  test_ut[ut_hush_hush_test_if_base]
    24ms  test_ut[ut_dm_dm_test_ethaddr]
    24ms  test_ut[ut_dm_dm_test_ofnode_compatible_ot]
    24ms  test_ut[ut_dm_dm_test_dma]
    24ms  test_ut[ut_dm_dm_test_i2s]
    24ms  test_ut[ut_dm_dm_test_process_ra]
    24ms  test_ut[ut_dm_dm_test_request]
    24ms  test_ut[ut_lib_lib_test_abuf_set]
    24ms  test_ut[ut_dm_dm_test_fdtdec_set_carveout]
    24ms  test_ut[ut_dm_dm_test_operations]
    24ms  test_ut[ut_dm_dm_test_serial]
    24ms  test_ut[ut_dm_dm_test_autoprobe]
    24ms  test_ut[ut_dm_dm_test_validate_ra]
    24ms  test_ut[ut_dm_dm_test_clk]
    24ms  test_ut[ut_dm_dm_test_tag_inval]
    24ms  test_avb_is_unlocked
    24ms  test_ut[ut_bloblist_bloblist_test_blob_ensure]
    24ms  test_ut[ut_bootm_bootm_test_subst]
    24ms  test_ut[ut_dm_dm_test_bus_children_iterators]
    24ms  test_ut[ut_bootm_bootm_test_nop]
    24ms  test_ut[ut_dm_dm_test_iommu]
    24ms  test_ut[ut_dm_dm_test_rkmtd]
    23ms  test_ut[ut_dm_dm_test_lifecycle]
    23ms  test_ut[ut_dm_dm_test_pre_reloc]
    23ms  test_ut[ut_upl_upl_test_info]
    23ms  test_ut[ut_dm_dm_test_acpi_misc]
    23ms  test_ut[ut_dm_dm_test_acpi_name]
    23ms  test_ut[ut_dm_dm_test_acpi_uuid]
    23ms  test_ut[ut_dm_dm_test_pci_busdev]
    23ms  test_ut[ut_bootstd_cedit_fdt]
    23ms  test_ut[ut_dm_dm_test_acpi_write_tpc]
    23ms  test_ut[ut_dm_dm_test_devres_kzalloc]
    23ms  test_ut[ut_log_log_test_pr_cont]
    23ms  test_ut[ut_mem_mem_test_ms_cont_end]
    23ms  test_ut[ut_dm_dm_test_mailbox]
    23ms  test_ut[ut_dm_dm_test_remove_vital]
    23ms  test_ut[ut_lib_lib_test_hex2bin]
    23ms  test_ut[ut_lib_lib_test_strlcat]
    23ms  test_ut[ut_dm_dm_test_children]
    23ms  test_ut[ut_dm_dm_test_sound_beep]
    23ms  test_ut[ut_dm_dm_test_tag_ptr]
    23ms  test_ut[ut_lib_lib_test_bin2hex]
    23ms  test_ut[ut_lib_lib_test_longjmp]
    23ms  test_ut[ut_dm_dm_test_audio]
    23ms  test_ut[ut_dm_dm_test_phy_setup]
    23ms  test_ut[ut_dm_dm_test_soc]
    23ms  test_ut[ut_mem_mem_test_cp_w]
    22ms  test_ut[ut_dm_dm_test_acpi_len]
    22ms  test_ut[ut_dm_dm_test_autobind]
    22ms  test_ut[ut_dm_dm_test_k210_pll]
    22ms  test_ut[ut_lib_unicode_test_u16_strsize]
    22ms  test_ut[ut_common_print_efi_ut]
    22ms  test_ut[ut_common_print_printf]
    22ms  test_ut[ut_dm_dm_test_bool]
    22ms  test_ut[ut_mem_mem_test_cp_l]
    22ms  test_ut[ut_mem_mem_test_ms_l]
    22ms  test_avb_read_rb
    22ms  test_ut[ut_dm_dm_test_acpi_dp_int]
    22ms  test_ut[ut_dm_dm_test_remove]
    22ms  test_ut[ut_dm_dm_test_misc]
    22ms  test_ut[ut_dm_dm_test_tag_val]
    22ms  test_ut[ut_lib_unicode_test_utf_to_upper]
    22ms  test_ut[ut_upl_upl_test_read_write]
    22ms  test_ut[ut_dm_dm_test_acpi_dp_gpio]
    22ms  test_ut[ut_lib_lib_test_getopt]
    22ms  test_ut[ut_dm_dm_test_reset]
    22ms  test_ut[ut_dm_dm_test_reset_bulk]
    22ms  test_ut[ut_dm_dm_test_tee]
    22ms  test_ut[ut_hush_hush_test_or]
    22ms  test_ut[ut_dm_dm_test_host]
    22ms  test_ut[ut_bootstd_bootmeth_env]
    22ms  test_ut[ut_dm_dm_test_read_int]
    22ms  test_ut[ut_dm_dm_test_ram_base]
    22ms  test_ut[ut_dm_dm_test_tpm]
    22ms  test_ut[ut_common_cli_ch_test]
    22ms  test_ut[ut_lib_compression_test_lz4]
    22ms  test_ut[ut_lib_lib_errno_str]
    21ms  test_ut[ut_dm_dm_test_mdio]
    21ms  test_ut[ut_dm_dm_test_uclass]
    21ms  test_ut[ut_lib_lib_test_aes]
    21ms  test_ut[ut_common_print_guid]
    21ms  test_ut[ut_dm_dm_test_sm]
    21ms  test_ut[ut_upl_upl_test_base]
    21ms  test_ut[ut_lib_lib_memmove]
    21ms  test_ut[ut_lib_str_hextoull]
    21ms  test_ut[ut_lib_str_trailing]
    21ms  test_ut[ut_dm_dm_test_clk_ccf]
    21ms  test_ut[ut_dm_dm_test_regmap_base]
    21ms  test_ut[ut_mem_mem_test_cp_b]
    21ms  test_ut[ut_dm_dm_test_cros_ec_sku_id]
    21ms  test_ut[ut_mem_mem_test_cp_q]
    20ms  test_ut[ut_dm_dm_test_leak]
    20ms  test_ut[ut_dm_dm_test_ordering]
    20ms  test_ut[ut_lib_str_dectoul]
    20ms  test_ut[ut_dm_dm_test_pci_ep_base]
    20ms  test_ut[ut_lib_str_hextoul]
    20ms  test_ut[ut_dm_dm_test_nop]
    20ms  test_ut[ut_dm_dm_test_plat]
    20ms  test_ut[ut_lib_lib_memdup]
    19ms  test_ut[ut_dm_dm_test_fdt]
    19ms  test_tpm2_startup
    19ms  test_ut[ut_dm_dm_test_acpi_create_dmar]
    19ms  test_ut[ut_dm_dm_test_spmi_probe]
    19ms  test_ut[ut_dm_dm_test_scmi_resets]
    19ms  test_ut[ut_lib_lib_memcpy]
    19ms  test_ut[ut_dm_dm_test_irq_get_acpi]
    19ms  test_ut[ut_addrmap_addrmap_test_basic]
    18ms  test_ut[ut_lib_lib_memset]
    18ms  test_ut[ut_lib_str_upper]
    18ms  test_ut[ut_common_snprint]
    18ms  test_ut[ut_bdinfo_bdinfo_test_eth]
    18ms  test_ut[ut_dm_dm_test_cpu]
    18ms  test_env_printenv_non_existent
    18ms  test_env_echo_non_existent
    18ms  test_ut[ut_dm_dm_test_i2c_speed]
    18ms  test_ut[ut_lib_str_itoa]
    18ms  test_ut[ut_lib_str_xtoa]
    18ms  test_ut[ut_setexpr_setexpr_test_int]
    17ms  test_scp03
    17ms  test_fit_ecdsa
    17ms  test_efi_eficonfig
    17ms  test_ut[ut_dm_dm_test_acpi_dp_int64]
    16ms  test_pinmux_dev
    16ms  test_ut[ut_lib_lib_test_abuf_realloc]
    16ms  test_net_pre_commands
    16ms  test_ut[ut_dm_dm_test_qfw_cpus]
    15ms  test_unknown_command
    15ms  test_shell_semicolon_two
    15ms  test_efi_bootmgr
    15ms  test_ut[ut_hush_hush_test_and]
    14ms  test_part_types
    14ms  test_ut[ut_lib_lib_crc8]
    14ms  test_fdt_add_pubkey[sha1-basic-sha1--None-False]
    13ms  test_pinmux_list
    13ms  test_tpm2_init
    13ms  test_pinmux_usage_2
    13ms  test_mkimage_hashes
    13ms  test_lsblk
    12ms  test_pinmux_usage_1
    12ms  test_ut[ut_bootstd_bootflow_set_arg]
    11ms  test_button_list
    10ms  test_qfw_list
    10ms  test_bootstage_report
     9ms  test_qfw_cpus
     7ms  test_shell_execute
     4ms  test_fstypes
TIME: SINCE-SECTION: 0:00:00.004227

This is just the summary which is visible in CI:

[-] Section: Timing Summary
TIME: NOW: 2025/01/25 14:28:57.730179
TIME: SINCE-PREV: 0:00:00.004234
TIME: SINCE-START: 0:02:00.307984
TIME: SINCE-SECTION: 0:00:00.000041
Duration : Number of tests
======== : ========================================
    <4ms :  1
    <8ms :  1
   <10ms :  3
   <20ms : #### 47
   <30ms : ######################################## 377
   <40ms : ############################# 278
   <50ms : ####### 69
   <75ms : #### 47
  <100ms : # 18
  <200ms : ### 29
  <300ms : # 15
  <400ms : # 13
  <500ms :  8
  <750ms :  6
   <1.0s :  2
   <2.0s :  9
   <3.0s :  3
   <4.0s :  4
   <5.0s :  2
   <7.5s :  2
  <20.0s :  1

So what do you think would make most sense?

Regards,
Simon
