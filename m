Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0F9C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 22:34:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C331D88385;
	Fri, 26 Jul 2024 00:34:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KuwsfEaX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3D6E88395; Fri, 26 Jul 2024 00:34:08 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D167488365
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 00:34:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5d5af7ae388so170566eaf.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 15:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721946844; x=1722551644; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=byq++LCsIW6KR3C9DpPjCHcE/fYnEOZnSVeubVyKNuQ=;
 b=KuwsfEaXcpH67+rNFZevdmE0KkRTd5CRkbU8bFIHAkGch++7jJxvKwgzHy6Q4Tsgjc
 4vI4y4QDWhV3KzSdS+IPCQseTTa1bGC1Uyg0EtEyr7YGHSdaTyyrWDawYpYwOGFj4Y3D
 CjUjbjeHYoF6cIAsBwBOl9pWeO1m0uCNuUhns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721946844; x=1722551644;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=byq++LCsIW6KR3C9DpPjCHcE/fYnEOZnSVeubVyKNuQ=;
 b=k8WdkYSaKZV5VomFvy/svGvSgrSaZsRDk2dmLxe3qZCB5L+kHYpqjcGJ2ucuujGJvB
 Ttr1IxCNln/lLC4jQbVJEDarzv1N4CW5yDQROotxQjokNSDQcVHU9HS6+WsahpycXz6+
 c9BrAao923BK/DGL4f4MLBEEF9lc5hbBaSZ89hxRPWyMCB9zbsHgZhUhAMBH0uGhcIpI
 uXnlJrq/SoHu+trjG+xWJ2XYlzdT+LM7UZlyhqy6t4bnGDZaiYv+y/38H9F/RMeLjeiO
 3SDPwaO064gYutXRixIdke3sZD7489cxMPulkFM6tJdtRpJJldXU0LTiUIQ30jZEG0x+
 GERQ==
X-Gm-Message-State: AOJu0YwPfDGFaXmFBmisArC2KfWrZibGnZ4F+CCWkhYSiMAArnpgjTwH
 Kxc79z+vkSNgPPC4xtPAO4XZJS/ujVyi1LGUW140XKSeACB137sYfiDfgROF2bs=
X-Google-Smtp-Source: AGHT+IES1wmDWs11NStkxYEnwQmI5MMsNrkraVjyjHhlSFqrfTjzreYT/a+439JnlwVQCsWeEl+zqg==
X-Received: by 2002:a05:6871:7a0:b0:25d:6eaa:ab1e with SMTP id
 586e51a60fabf-2649fc971b1mr2209633fac.14.1721946844307; 
 Thu, 25 Jul 2024 15:34:04 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-45.totalplay.net.
 [187.190.202.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7093aff565esm16956a34.52.2024.07.25.15.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 15:34:03 -0700 (PDT)
Date: Thu, 25 Jul 2024 16:34:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>
Subject: Re: [PATCH v5 00/20] Introduce the lwIP network stack
Message-ID: <20240725223401.GD989285@bill-the-cat>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
 <20240725172220.GA989285@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QKrcgseAgk70CkXu"
Content-Disposition: inline
In-Reply-To: <20240725172220.GA989285@bill-the-cat>
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


--QKrcgseAgk70CkXu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 11:22:20AM -0600, Tom Rini wrote:
> On Thu, Jul 25, 2024 at 02:57:21PM +0200, Jerome Forissier wrote:
>=20
> > This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
> > library for the network stack" [1]. The goal is to introduce the lwIP T=
CP/IP
> > stack [2] [3] as an alternative to the current implementation in net/,
> > selectable with Kconfig, and ultimately keep only lwIP if possible. Some
> > reasons for doing so are:
> > - Make the support of HTTPS in the wget command easier. Javier T. and
> > Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
> > so. With that it becomes possible to fetch and launch a distro installer
> > such as Debian etc. using a secure, authenticated connection directly
> > from the U-Boot shell. Several use cases:
> >   * Authentication: prevent MITM attack (third party replacing the
> > binary with a different one)
> >   * Confidentiality: prevent third parties from grabbing a copy of the
> > image as it is being downloaded
> >   * Allow connection to servers that do not support plain HTTP anymore
> > (this is becoming more and more common on the Internet these days)
> > - Possibly benefit from additional features implemented in lwIP
> > - Less code to maintain in U-Boot
> >=20
> > Prior to applying this series, the lwIP stack needs to be added as a
> > Git subtree with the following command:
> >=20
> >  $  git subtree add --squash --prefix lib/lwip/lwip https://git.savanna=
h.gnu.org/git/lwip.git STABLE-2_2_0_RELEASE
>=20
> This is better than v4, and on the hardware platforms I could build and
> boot on (which was most of mine except the am62x_beagleplay), the tests
> ran and completed, including the tftp+boot a Linux kernel.
>=20
> The bad news is CI blows up, a lot:
> https://source.denx.de/u-boot/u-boot/-/pipelines/21764
> And:
> https://dev.azure.com/u-boot/a1096300-2999-4ec4-a21a-4c22075e3771/_apis/b=
uild/builds/9014/logs/106
> which is another Kconfig dependency problem. I don't _think_ I
> introduced that, but since this wasn't against top of tree, I had to
> apply the cmd/Kconfig patch manually.
>=20
> I have my world build running still and may have more comments based on
> that.

First, with NET_LWIP being default rather than NET, there's a lot of
other Kconfig dependency issues. Unfortunately I don't see an easy tool
for making sure this is all clean aside from a shell loop like:
for C in `(cd configs;ls)`;do make -s $C;done

Once those are fixed, this is feeling pretty OK I think. I assume PXE
support is high on the follow-up TODO list? That said, after taking
tiger-rk3588 as an example platform and hacking out PXE related stuff and
turning on lwIP:
   aarch64: (for 1/1 boards) all +10144.0 bss -4040.0 data -64.0 rodata -10=
0.0 text +14348.0
            tiger-rk3588   : all +10144 bss -4040 data -64 rodata -100 text=
 +14348
               u-boot: add: 161/-115, grow: 8/-6 bytes: 24552/-14382 (10170)
                 function                                   old     new   d=
elta
                 dhcp_recv                                    -    1296   +=
1296
                 tftp_recv                                    -    1152   +=
1152
                 ip4_input                                    -     596    =
+596
                 new_netif                                    -     556    =
+556
                 etharp_query                                 -     552    =
+552
                 udp_input                                    -     540    =
+540
                 etharp_input                                 -     532    =
+532
                 distro_efi_read_bootflow_net                 -     516    =
+516
                 dhcp_loop                                    -     512    =
+512
                 ip4addr_aton                                 -     492    =
+492
                 static.dhcp_select                           -     484    =
+484
                 ip4_output_if_src                            -     436    =
+436
                 udp_sendto_if_src                            -     408    =
+408
                 static.dhcp_reboot                           -     400    =
+400
                 etharp_output                                -     400    =
+400
                 dhcp_create_msg                              -     384    =
+384
                 etharp_find_entry                            -     376    =
+376
                 dhcp_bind                                    -     364    =
+364
                 send_request                                 -     352    =
+352
                 dhcp_discover                                -     352    =
+352
                 raw_sendto_if_src                            -     328    =
+328
                 pbuf_copy_partial_pbuf                       -     328    =
+328
                 netif_add                                    -     324    =
+324
                 do_tftpb                                   544     868    =
+324
                 pbuf_alloc                                   -     308    =
+308
                 dhcp_release_and_stop                        -     308    =
+308
                 net_lwip_rx                                  -     292    =
+292
                 raw_input                                    -     288    =
+288
                 udp_bind                                     -     284    =
+284
                 ethernet_input                               -     284    =
+284
                 etharp_raw                                   -     284    =
+284
                 static.dhcp_handle_ack                       -     272    =
+272
                 ping_send                                    -     248    =
+248
                 ip4addr_ntoa_r                               -     220    =
+220
                 inet_chksum_pseudo                           -     216    =
+216
                 ping_recv                                    -     212    =
+212
                 etharp_output_to_arp_index                   -     208    =
+208
                 netif_set_addr                               -     204    =
+204
                 do_ping                                    124     328    =
+204
                 dhcp_start                                   -     204    =
+204
                 send_data                                    -     192    =
+192
                 dhcp_fine_tmr                                -     192    =
+192
                 pbuf_copy_partial                            -     184    =
+184
                 tftp_close                                   -     176    =
+176
                 script_read_bootflow                       420     596    =
+176
                 linkoutput                                   -     176    =
+176
                 ethernet_output                              -     176    =
+176
                 tftp_write                                   -     172    =
+172
                 pbuf_memcmp                                  -     168    =
+168
                 static.send_error                            -     164    =
+164
                 netif_remove                                 -     164    =
+164
                 raw_sendto                                   -     160    =
+160
                 arp_table                                    -     160    =
+160
                 tftp_init_common                             -     156    =
+156
                 pbuf_realloc                                 -     152    =
+152
                 dhcp_inc_pcb_refcount                        -     152    =
+152
                 tftp_tmr                                     -     148    =
+148
                 pbuf_free                                    -     148    =
+148
                 udp_sendto                                   -     144    =
+144
                 udp_connect                                  -     144    =
+144
                 sys_timeout_abs                              -     140    =
+140
                 ip4_route                                    -     136    =
+136
                 static.resend_data                           -     132    =
+132
                 pbuf_memfind                                 -     128    =
+128
                 pbuf_add_header_impl                         -     128    =
+128
                 boot_file_name                               -     128    =
+128
                 static.netif_do_set_ipaddr                   -     124    =
+124
                 lwip_standard_chksum                         -     124    =
+124
                 sys_check_timeouts                           -     120    =
+120
                 tftp_error                                   -     116    =
+116
                 etharp_free_entry                            -     116    =
+116
                 tftp_get                                     -     112    =
+112
                 dhcp_run                                     -     112    =
+112
                 static.send_ack                              -     108    =
+108
                 eth_start_udev                               -     104    =
+104
                 close_handle                                 -      96    =
 +96
                 sys_untimeout                                -      92    =
 +92
                 ip4_addr_isbroadcast_u32                     -      92    =
 +92
                 init_packet                                  -      92    =
 +92
                 etharp_cleanup_netif                         -      92    =
 +92
                 raw_new                                      -      88    =
 +88
                 pbuf_remove_header                           -      88    =
 +88
                 net_lwip_get_netif                           -      88    =
 +88
                 dhcp_option_trailer                          -      88    =
 +88
                 udp_sendto_if                                -      84    =
 +84
                 pbuf_alloc_reference                         -      84    =
 +84
                 udp_remove                                   -      80    =
 +80
                 ip4_input_accept                             -      80    =
 +80
                 netif_set_link_up                            -      76    =
 +76
                 udp_netif_ip_addr_changed                    -      72    =
 +72
                 raw_remove                                   -      72    =
 +72
                 raw_netif_ip_addr_changed                    -      72    =
 +72
                 dhcp_option_long                             -      68    =
 +68
                 dhcp_dec_pcb_refcount                        -      68    =
 +68
                 udp_new                                      -      64    =
 +64
                 sys_timeout                                  -      60    =
 +60
                 pbuf_try_get_at                              -      60    =
 +60
                 pbuf_clone                                   -      60    =
 +60
                 dhcp_network_changed_link_up                 -      60    =
 +60
                 tftp_cleanup                                 -      56    =
 +56
                 pbuf_cat                                     -      56    =
 +56
                 netif_get_by_index                           -      56    =
 +56
                 _u_boot_list_2_cmd_2_dhcp                    -      56    =
 +56
                 tftp_state                                   4      56    =
 +52
                 pbuf_skip_const                              -      48    =
 +48
                 net_lwip_if_init                             -      48    =
 +48
                 dhcp_supplied_address                        -      48    =
 +48
                 netif_issue_reports                          -      44    =
 +44
                 tftp_context                                 -      40    =
 +40
                 ip_data                                      -      40    =
 +40
                 etharp_request                               -      40    =
 +40
                 raw_bind                                     -      36    =
 +36
                 net_lwip_remove_netif                        -      36    =
 +36
                 memp_malloc                                  -      36    =
 +36
                 ip4_output_if                                -      36    =
 +36
                 dhcp_option_short                            -      36    =
 +36
                 call_lwip_dhcp_fine_tmr                      -      36    =
 +36
                 netif_set_up                                 -      32    =
 +32
                 netif_set_down                               -      32    =
 +32
                 inet_chksum                                  -      32    =
 +32
                 dhcp_set_state                               -      32    =
 +32
                 dhcp_rx_options_val                          -      32    =
 +32
                 pbuf_get_at                                  -      28    =
 +28
                 distro_efi_read_bootflow                    60      88    =
 +28
                 distro_efi_boot                            360     388    =
 +28
                 tftp_client_set_blksize                      -      24    =
 +24
                 sys_now                                      -      24    =
 +24
                 pbuf_copy                                    -      24    =
 +24
                 pbuf_chain                                   -      24    =
 +24
                 memp_free                                    -      24    =
 +24
                 eth_bootdev_hunt                            44      68    =
 +24
                 do_dhcp                                      -      24    =
 +24
                 pbuf_ref                                     -      20    =
 +20
                 netif_input                                  -      20    =
 +20
                 do_net_stats                               328     348    =
 +20
                 static.str                                   -      16    =
 +16
                 ip4addr_ntoa                                 -      16    =
 +16
                 udp_recv                                     -      12    =
 +12
                 tftp_init_client                             -      12    =
 +12
                 netif_set_default                            -      12    =
 +12
                 udp_pcbs                                     -       8    =
  +8
                 tftp_read                                    -       8    =
  +8
                 tftp_open                                    -       8    =
  +8
                 raw_recv                                     -       8    =
  +8
                 raw_pcbs                                     -       8    =
  +8
                 pbuf_add_header                              -       8    =
  +8
                 next_timeout                                 -       8    =
  +8
                 netif_null_output_ip4                        -       8    =
  +8
                 netif_list                                   -       8    =
  +8
                 netif_default                                -       8    =
  +8
                 net_lwip_new_netif_noip                      -       8    =
  +8
                 net_lwip_new_netif                           -       8    =
  +8
                 lwip_htons                                   -       8    =
  +8
                 lwip_htonl                                   -       8    =
  +8
                 dhcp_rx_options_given                        -       8    =
  +8
                 dhcp_pcb                                     -       8    =
  +8
                 udp_new_ip_type                              -       4    =
  +4
                 static.xid                                   -       4    =
  +4
                 mem_trim                                     -       4    =
  +4
                 mem_malloc                                   -       4    =
  +4
                 mem_free                                     -       4    =
  +4
                 ip_chksum_pseudo                             -       4    =
  +4
                 current_timeout_due_time                     -       4    =
  +4
                 udp_port                                     -       2    =
  +2
                 ip_id                                        -       2    =
  +2
                 static.called                                -       1    =
  +1
                 netif_num                                    -       1    =
  +1
                 etharp_cached_entry                          -       1    =
  +1
                 dhcp_pcb_refcount                            -       1    =
  +1
                 net_boot_file_name_explicit                  1       -    =
  -1
                 tftp_windowsize                              2       -    =
  -2
                 tftp_window_size_option                      2       -    =
  -2
                 tftp_next_ack                                2       -    =
  -2
                 tftp_last_nack                               2       -    =
  -2
                 tftp_block_size_option                       2       -    =
  -2
                 tftp_block_size                              2       -    =
  -2
                 ping_seq_number                              2       -    =
  -2
                 net_our_vlan                                 2       -    =
  -2
                 net_native_vlan                              2       -    =
  -2
                 env_flags_vartype_rep                        7       5    =
  -2
                 timeout_count_max                            4       -    =
  -4
                 timeout_count                                4       -    =
  -4
                 tftp_timeout_count_max                       4       -    =
  -4
                 tftp_remote_port                             4       -    =
  -4
                 tftp_remote_ip                               4       -    =
  -4
                 tftp_our_port                                4       -    =
  -4
                 static.first_call                            4       -    =
  -4
                 saved_tftp_block_size_option                 4       -    =
  -4
                 net_try_count                                4       -    =
  -4
                 net_state                                    4       -    =
  -4
                 net_server_ip                                4       -    =
  -4
                 net_rx_packet_len                            4       -    =
  -4
                 net_restarted                                4       -    =
  -4
                 net_ping_ip                                  4       -    =
  -4
                 net_netmask                                  4       -    =
  -4
                 net_ip_id                                    4       -    =
  -4
                 net_ip                                       4       -    =
  -4
                 net_gateway                                  4       -    =
  -4
                 net_dns_server                               4       -    =
  -4
                 net_dev_exists                               4       -    =
  -4
                 net_boot_file_size                           4       -    =
  -4
                 net_boot_file_expected_size_in_blocks        4       -    =
  -4
                 net_arp_wait_reply_ip                        4       -    =
  -4
                 net_arp_wait_packet_ip                       4       -    =
  -4
                 dummy_handler                                4       -    =
  -4
                 arp_wait_tx_packet_size                      4       -    =
  -4
                 arp_wait_try                                 4       -    =
  -4
                 net_server_ethaddr                           6       -    =
  -6
                 net_ethaddr                                  6       -    =
  -6
                 udp_packet_handler                           8       -    =
  -8
                 timeout_ms                                   8       -    =
  -8
                 time_handler                                 8       -    =
  -8
                 time_delta                                   8       -    =
  -8
                 tftp_prev_block                              8       -    =
  -8
                 tftp_load_size                               8       -    =
  -8
                 tftp_load_addr                               8       -    =
  -8
                 tftp_cur_block                               8       -    =
  -8
                 tftp_block_wrap_offset                       8       -    =
  -8
                 tftp_block_wrap                              8       -    =
  -8
                 net_tx_packet                                8       -    =
  -8
                 net_rx_packet                                8       -    =
  -8
                 arp_wait_timer_start                         8       -    =
  -8
                 arp_wait_packet_ethaddr                      8       -    =
  -8
                 arp_tx_packet                                8       -    =
  -8
                 arp_packet_handler                           8       -    =
  -8
                 net_get_arp_handler                         12       -    =
 -12
                 default_filename                            13       -    =
 -13
                 time_start                                  16       -    =
 -16
                 start_again_timeout_handler                 16       -    =
 -16
                 _u_boot_list_2_env_clbk_2_vlan              16       -    =
 -16
                 _u_boot_list_2_env_clbk_2_serverip          16       -    =
 -16
                 _u_boot_list_2_env_clbk_2_nvlan             16       -    =
 -16
                 _u_boot_list_2_env_clbk_2_netmask           16       -    =
 -16
                 _u_boot_list_2_env_clbk_2_ipaddr            16       -    =
 -16
                 _u_boot_list_2_env_clbk_2_gatewayip         16       -    =
 -16
                 arp_is_waiting                              20       -    =
 -20
                 net_set_udp_handler                         24       -    =
 -24
                 ip_checksum_ok                              28       -    =
 -28
                 ping_timeout_handler                        32       -    =
 -32
                 net_clear_handlers                          36       -    =
 -36
                 ip_to_string                                36       -    =
 -36
                 is_serverip_in_cmd                          40       -    =
 -40
                 net_send_udp_packet                         44       -    =
 -44
                 net_get_async_tx_pkt_buf                    44       -    =
 -44
                 eth_halt_state_only                         44       -    =
 -44
                 on_vlan                                     48       -    =
 -48
                 on_serverip                                 48       -    =
 -48
                 on_nvlan                                    48       -    =
 -48
                 on_netmask                                  48       -    =
 -48
                 on_ipaddr                                   48       -    =
 -48
                 on_gatewayip                                48       -    =
 -48
                 net_eth_hdr_size                            56       -    =
 -56
                 arp_init                                    56       -    =
 -56
                 net_init_loop                               60       -    =
 -60
                 eth_init                                   300     232    =
 -68
                 env_flags_validate                         644     576    =
 -68
                 copy_filename                               76       -    =
 -76
                 net_init                                   112      32    =
 -80
                 string_to_vlan                              84       -    =
 -84
                 net_set_timeout_handler                     84       -    =
 -84
                 compute_ip_checksum                         92       -    =
 -92
                 tftp_init_load_addr                        100       -    =
-100
                 skip_num                                   104       -    =
-104
                 tftp_filename                              128       -    =
-128
                 arp_request                                128       -    =
-128
                 tftp_timeout_handler                       132       -    =
-132
                 lmb_get_free_size                          136       -    =
-136
                 net_set_udp_header                         144       -    =
-144
                 arp_timeout_check                          148       -    =
-148
                 net_update_ether                           152       -    =
-152
                 eth_validate_ethaddr_str                   152       -    =
-152
                 string_to_ip                               156       -    =
-156
                 net_parse_bootfile                         160       -    =
-160
                 net_set_ether                              180       -    =
-180
                 net_set_ip_header                          184       -    =
-184
                 arp_raw_request                            228       -    =
-228
                 ping_start                                 276       -    =
-276
                 net_send_ip_packet                         292       -    =
-292
                 net_check_prereq                           308       -    =
-308
                 ping_receive                               332       -    =
-332
                 net_start_again                            336       -    =
-336
                 net_loop                                   544       -    =
-544
                 arp_receive                                560       -    =
-560
                 tftp_send                                  584       -    =
-584
                 net_process_received_packet                764       4    =
-760
                 tftp_start                                 908       -    =
-908
                 net_boot_file_name                        1024       -   -=
1024
                 tftp_handler                              1308       -   -=
1308
                 net_pkt_buf                               7744    6208   -=
1536
                 arp_tx_packet_buf                         1600       -   -=
1600

Although I'm not 100% sure that config is functionally equivalent, so
perhaps it would be helpful if you could take a board or two and
reconfigure them with the legacy stack, but equivalent functionality to
with lwIP, for comparison sake? Thanks!

--=20
Tom

--QKrcgseAgk70CkXu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmai0tEACgkQFHw5/5Y0
tyzO4AwAtPZ/cdlYXBf3JAK0jqjRTPqR3+56iAXyvuvj84xsnOtXRt7XKTgbk/G9
gi3ZXMZO2LNwNgHGxEWuVPneSWClvTaTdeSyUDWtVhM8JkRLAu4TEGg3TZOAFpWt
YjWIWvh4u8xVwJr3beBKr96v08lK0hChO+rU4xMWftCpM93YNldkOFqYpR8oxALS
UC6rNbK9LG5pmgqqzkuvarxBMKYRU+lSEDA3BL1Xu2oTJPelcesUWe5T0Jv8sPa5
TxpAyourkYw+zw/chaq5SyRQKkNvQrGRdwPOHInXvBtkD1gYkcH+19UuNK6Gz7hx
4MZfuydEJW7t9mDAD5bFBxN920o9Bdq9MHWNY/tY/MKgJnvyHzncgD+b1yijq+ii
m3xZ1Ul7STcApk9DHQ7uYFWvuYdyjU7KA7P1jqca4cqmLHOx0J9TaSaGR92Jn236
L6BXufoxIUrEcLY+5310eoL6XGsq1vGgTL6Njn7xmLpTOLxA5vlQehG0nRKTycjk
FhV2h5K4
=y6Js
-----END PGP SIGNATURE-----

--QKrcgseAgk70CkXu--
