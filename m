Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D687EE49A4
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 19:03:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4D9A86BA2;
	Sun, 10 Sep 2023 21:03:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="XkX+P2Ir";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A93C186C09; Sun, 10 Sep 2023 21:03:56 +0200 (CEST)
Received: from s.wrqvwxzv.outbound-mail.sendgrid.net
 (s.wrqvwxzv.outbound-mail.sendgrid.net [149.72.154.232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5551382BBF
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 21:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=mime-version:subject:references:from:in-reply-to:to:cc:content-type:
 content-transfer-encoding:cc:content-type:from:subject:to;
 s=s1; bh=5gJUgdJslKPamyn1ThmOl8nOws8JeNTejjsAPp66tgc=;
 b=XkX+P2IrKTloAxzvQhDhhEeukVKNqoLO62fHjyLunKLrinEwfmDAtpfdrOaZFe0Jb35A
 Qu/l6IlsCRxPCXKbpB+Oone0x6Zdq9TGbkdow61z8sduWjgV6bdUy/DHrinMWHvDFL0hDU
 yczjOlR993l04FvP2HcD2ybuyIMJAMWhATQwmlzeT48pjqH02cFU/I3DSzVvH2pzQ8ibiZ
 J3OAv/Y6WAz7YhrYbwR7pcFaOwXYq4ypf6yr3JOja6oLsu+K3newzL3dmopYVzFwdQ0KRC
 OJZDne/Ku/cAo61YU9f31kjTgHTWTo4rgn3+CgC+bQPF9HGO5r4iQE9Xmapf9wpw==
Received: by filterdrecv-7765c6879f-q5h4f with SMTP id
 filterdrecv-7765c6879f-q5h4f-1-64FE1317-45
 2023-09-10 19:03:51.592359204 +0000 UTC m=+2693321.947329386
Received: from [192.168.1.50] (unknown) by geopod-ismtpd-4 (SG) with ESMTP
 id y3p38SBSS-aO5Ozu_UoETQ Sun, 10 Sep 2023 19:03:51.174 +0000 (UTC)
Message-ID: <43d64bdc-ad1d-371e-da8e-c7dbffc9dc87@kwiboo.se>
Date: Sun, 10 Sep 2023 19:03:51 +0000 (UTC)
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 0/4] support for booting the compressed U-boot binary
 on Rockchip based ARM64 SOC's
References: <20230725035101.281325-1-abbaraju.manojsai@amarulasolutions.com>
 <20230910182448.285542-1-abbaraju.manojsai@amarulasolutions.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20230910182448.285542-1-abbaraju.manojsai@amarulasolutions.com>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h+PjN6Fga9AmNDr4e?=
 =?us-ascii?Q?kTxCE1wGB1yEJ2fvQhK63KQhgkMsdpuFw4s=2FaF4?=
 =?us-ascii?Q?Bejv4J6gD4O+=2FM3rJtSO9l+g1A1ZJyZxXBwlflM?=
 =?us-ascii?Q?OZ=2FM9mo5CL=2F3sIGap80XIPz0G4zULUXyGX=2Fpj+9?=
 =?us-ascii?Q?TE0DyHGb1A6ZbjX5nY5pCBltnYPEJXQpSrSA01?=
To: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, Simon Glass
 <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang
 <kever.yang@rock-chips.com>
Cc: dsx724 <da@lessconfused.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>, u-boot@lists.denx.de
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Type: text/plain; charset=utf-8
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

Hi,

On 2023-09-10 20:24, Manoj Sai wrote:
> This patchset adds the support on Rockchip based ARM64 SOC's that  compress the U-BOOT proper along with dtb
> and ATF in FIT image format.Second stage bootloader(SPL) loads the compressed binaries, uncompress
> them and  handover control to the next stage.
> 
> Changes for V3 :-
> 
> 1. Replaced spl_decompression_enabled() function instead of checking IS_ENABLED(CONFIG_SPL_GZIP)
>    and IS_ENABLED(CONFIG_SPL_LZMA) in spl_fit.c
> 
> 2. Removed extra wrapping parentheses in spl_decompression_enabled().
> 
> Size Comparision between compressed and uncompressed binaries :-
> 
>        size of uncompressed binary    :- 9.0M (94,21,824 bytes)
>          manoj:u-boot$ ls -lb u-boot-rockchip.bin
>         -rw-rw-r-- 1 manoj manoj 9421824 Sep 10 22:22 u-boot-rockchip.bin
> 
>        size of GZIP compressed binary :- 8.6M (89,85,088 bytes)
>          manoj:u-boot$ ls -lb u-boot-rockchip.bin
>          -rw-rw-r-- 1 manoj manoj 8985088 Jul 25 07:42 u-boot-rockchip.bin
> 
>        size of LZMA compressed binary :- 8.6 M (90,06,592 bytes)
>          manoj:u-boot$ ls -lb u-boot-rockchip.bin
>          -rw-rw-r-- 1 manoj manoj 9006592 Jul 25 07:47 u-boot-rockchip.bin
> 
> Test results of  Booting time using bootstage command in Uboot command prompt on roc-rk3399-pc board :-
> 
> 1) Uncompressed U-BOOT : Total boot time ≈ 12.063971 seconds
> => bootstage report
> Timer summary in microseconds (10 records):
>        Mark    Elapsed  Stage
>           0          0  reset
>   1,833,884  1,833,884  board_init_f
>   2,959,528  1,125,644  board_init_r
>   5,224,521  2,264,993  eth_common_init
>   5,523,428    298,907  eth_initialize
>   5,523,606        178  main_loop
>   5,523,764        158  usb_start
>  12,063,971  6,540,207  cli_loop
> 
> 2) GZIP Compressed U-BOOT : Total time ≈ 12.824968 seconds
> 
> => bootstage report
> Timer summary in microseconds (10 records):
>        Mark    Elapsed  Stage
>           0          0  reset
>   2,594,709  2,594,709  board_init_f
>   3,719,969  1,125,260  board_init_r
>   5,985,450  2,265,481  eth_common_init
>   6,284,371    298,921  eth_initialize
>   6,284,549        178  main_loop
>   6,284,708        159  usb_start
>  12,824,968  6,540,260  cli_loop
> 
> 3) LZMA Compressed U-BOOT : Total time ≈ 17.025004 seconds
> 
> => bootstage report
> Timer summary in microseconds (10 records):
>        Mark    Elapsed  Stage
>           0          0  reset
>   6,852,254  6,852,254  board_init_f
>   7,940,143  1,087,889  board_init_r
>  10,190,458  2,250,315  eth_common_init
>  10,487,254    296,796  eth_initialize
>  10,487,432        178  main_loop
>  10,487,590        158  usb_start
>  17,025,004  6,537,414  cli_loop
> 
> 
> As per suggestion from Mr.Jonas Karlman (jonas@kwiboo.se) through Patchset V2,that check boot time
> with enabling CONFIG_SPL_FIT_SIGNATURE that might impact boot time.
> 
> Tried to check the boot time with CONFIG_FIT_SIGNATURE enabled, I didnt find any significant
> boot time improvement  with enabling CONFIG_SPL_FIT_SIGNATURE.

I may not have been that clear in my last mail, it is the following
rfc/patch that may improve performance. That prfc/patch does improve
performance for sha256 validation when CONFIG_SPL_FIT_SIGNATURE is
enabled.

[RFC] rockchip: spl: Enable caches to speed up checksum validation
https://patchwork.ozlabs.org/project/uboot/patch/20230702110055.3686457-1-jonas@kwiboo.se/

Would be great to get confirmation if D-cache enabled in SPL also
benefit this series, and not just checksum validation.
(that rfc/patch unfortunately did not get much feedback)

Regards,
Jonas

> 
> Comparision of GZIP and LZMA compressed U-boot Boot time with and without Enable of CONFIG_FIT_SIGNATURE :-
> 
> - GZIP Compressed U-BOOT  and CONFIG_FIT_SIGNATURE enabled  :-  Total time ≈ 13.283998 seconds
> 
> => bootstage report
> Timer summary in microseconds (10 records):
>        Mark    Elapsed  Stage
>           0          0  reset
>   3,052,571  3,052,571  board_init_f
>   4,179,787  1,127,216  board_init_r
>   6,445,472  2,265,685  eth_common_init
>   6,744,416    298,944  eth_initialize
>   6,744,593        177  main_loop
>   6,744,751        158  usb_start
>  13,283,998  6,539,247  cli_loop
> 
> - GZIP Compressed U-BOOT and CONFIG_FIT_SIGNATURE disabled  :- Total time ≈ 12.824968 seconds
> 
> 
> - LZMA Compressed U-BOOT  and CONFIG_FIT_SIGNATURE enabled  :-  Total time ≈ 17.005996 seconds
> 
>    => bootstage report
> Timer summary in microseconds (10 records):
>        Mark    Elapsed  Stage
>           0          0  reset
>   6,775,071  6,775,071  board_init_f
>   7,902,443  1,127,372  board_init_r
>  10,167,546  2,265,103  eth_common_init
>  10,466,418    298,872  eth_initialize
>  10,466,595        177  main_loop
>  10,466,753        158  usb_start
>  17,005,996  6,539,243  cli_loop
> 
> - LZMA Compressed U-BOOT  and CONFIG_FIT_SIGNATURE disabled  :- Total time ≈ 17.025004 seconds
> 
> Manoj Sai (4):
>   spl: fit: support for booting a GZIP-compressed U-boot binary
>   spl: fit: support for booting a LZMA-compressed U-boot binary
>   rockchip: Add support to generate GZIP compressed U-boot binary
>   rockchip: Add support to generate LZMA compressed U-boot binary
> 
>  arch/arm/dts/rockchip-u-boot.dtsi | 11 +++++++++++
>  common/spl/spl_fit.c              | 20 +++++++++++++++++---
>  include/spl.h                     | 10 ++++++++++
>  3 files changed, 38 insertions(+), 3 deletions(-)
> 
> --
> 2.25.1
> 

