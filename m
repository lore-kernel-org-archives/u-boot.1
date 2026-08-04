Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AF3C55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 03:39:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6469F406C5;
	Tue,  4 Aug 2026 03:39:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 28a9WsHZZ3Ak; Tue,  4 Aug 2026 03:39:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4B5C3405FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785814740;
	bh=lG47+JeRywJQZMud0KV4KJRzsfJXcFpT1l/JfesPC1k=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=B0XN5Jem9gdWSwW8Vtp3LyO2ua7iy8Hu8+EOKuSKKMaprhNeX51pIUV+heTF44LWi
	 0haYxN4dBUm85C6SE6Tnp0VpKVqjP/pE4MZ6P3I9RaPdOeUOmoJtl36uEijVYR9m4J
	 Ylf0zcP+qWDgONT34o7xZWpwu1S6JKTZGbnwATdoA9Hz8b8KfPfae/4sXsnUutXFwt
	 ZeJtASgd8k8QPWyucFawtoCr8I8XiF0hPiT1IcJwW7b1rEplStiIkZrUVjn1wDNXiR
	 66oL6409DDXz0KkjNW/X4tmrorNYz24V8zp477BUGUvVNQ45/YV6psJK6KxNvukVpM
	 UrRXWnXfpDw0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B5C3405FA;
	Tue,  4 Aug 2026 03:39:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AEC0432E
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 03:38:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9436640103
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 03:38:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sANb9xuAfSov for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 03:38:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 763604009E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 763604009E
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 763604009E
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 03:38:54 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BB11842FC; Tue,  4 Aug 2026 05:38:52 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34DAE80087
 for <u-boot@lists.denx.de>; Tue,  4 Aug 2026 05:38:50 +0200 (CEST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hDfQw3pFczMlDp;
 Tue, 04 Aug 2026 05:38:48 +0200 (CEST)
Message-ID: <ee1fd083-7958-4b67-a967-5c881cd5bf14@mailbox.org>
Date: Tue, 4 Aug 2026 05:38:45 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] ARM: socfpga: fix dead guard on
 board_spl_mmc_get_uboot_raw_sector()
To: Mahmoud Komaiha <mlpkos@gmail.com>
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, u-boot@lists.denx.de,
 Mahmoud Komaiha <mkomaiha@umich.edu>
References: <20260804013858.23721-1-mlpkos@gmail.com>
Content-Language: en-US
In-Reply-To: <20260804013858.23721-1-mlpkos@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: oauso6bawnx9ddfx97fkake4gddntfrc
X-MBO-RS-ID: f805161447be163d912
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785814728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lG47+JeRywJQZMud0KV4KJRzsfJXcFpT1l/JfesPC1k=;
 b=Z9OD+fWQE/AmtGK2jOylHTAj6fH7FZV8i+JFd79mAYNDn/cBjX03VrMOUNsLJZyi++iDEg
 G+oCRUYZ1wbQoE3W3jv9c+1F0gV01AHkaZYDGOnZi2w5W8nDXW0KXOfbnKN5P9gqgGtreH
 aIFJ5pCLOSjdaQoi6UMHMH7AwKvMXS2ZrIQnYQyKtbs+v0zOACrtJmYGoc6xeAqe+gpY9T
 XLZwth3n6utD4JhimZfB3EaAUJqEsWpqnvchH+m5n3C5RKweA+NluyaURmnKh9ssPUvGLB
 VTrRH260CHMmX4dDuca0qQiyN5G9Yksu78oWBi4O4RvpbeY82BI4dwFx1stlQQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 spf=fail smtp.mailfrom=mailbox.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=Z9OD+fWQ
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=marek.vasut@mailbox.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=mailbox.org header.i=@mailbox.org header.b="Z9OD+fWQ"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/4/26 3:38 AM, Mahmoud Komaiha wrote:
> From: Mahmoud Komaiha <mkomaiha@umich.edu>
> 
> board_spl_mmc_get_uboot_raw_sector() is guarded on
> CONFIG_TARGET_SOCFPGA_ARRIA10 and CONFIG_TARGET_SOCFPGA_GEN5. Neither
> symbol exists in Kconfig: the family symbols are ARCH_SOCFPGA_ARRIA10 and
> ARCH_SOCFPGA_GEN5, while the per-board symbols are of the form
> TARGET_SOCFPGA_ARRIA10_SOCDK / TARGET_SOCFPGA_TERASIC_DE10_NANO. These two
> lines are the only references to either symbol in the tree.
> 
> The guard is therefore never true and the function is dead code on every
> SoCFPGA board, so the offset of u-boot proper inside u-boot-with-spl.sfp
> is never applied.
> 
> When SPL loads u-boot proper from the 0xa2 partition
> (SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE) the resulting load address
> is the start of that partition, which holds SPL itself rather than u-boot
> proper. SPL then hangs with no diagnostic after printing
> "spl: mmc boot mode: raw".
> 
> Observed on a Terasic DE10-Nano (Cyclone V, GEN5) booting from SD with the
> standard layout (0xa2 partition at sector 1024). Instrumenting
> mmc_load_image_raw_partition() showed the computed load sector as 1024
> instead of 1536. With the guard corrected the offset is applied, the load
> sector becomes 1536, and the board boots to the U-Boot prompt.
> 
> Signed-off-by: Mahmoud Komaiha <mkomaiha@umich.edu>
Reviewed-by: Marek Vasut <marek.vasut+socfpga@mailbox.org>

Fixes: 62f7a9460209 ("Replace TARGET namespace and cleanup properly")

Thanks !
