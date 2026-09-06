Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B15C79FA0
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 12:19:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD16960664;
	Sun,  6 Sep 2026 12:19:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nTbL-4f9PAs5; Sun,  6 Sep 2026 12:19:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2371760659
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788697144;
	b=d+wzeczt//K0rsCZiRU+Su/YTQGufbjjcgFYt4RINv2uCoyqjhUjHmi6WyHzVB4MqR1h
	 05P+bpvrFhgm8dO1W3sjcMUJdC+0l+WqFezZPzTrhOUwmbrfQO9+5Sz9fwzigH5Y+cziO
	 arazDBD98kyUJPPpdGVFgj+olgvQeExMC3BhcUTtX72KGfO9WCNVn2NENu2iqI9URV3wa
	 dI1KrNvJ5Mw1tZxKoJ5snx1SZg4gKeVL4/cq7+NhDE555DLK9zE0svx8MS4b89wUHF0tJ
	 DxASNHCRvkMk2l3sL4CfjYQtt+NIMXirkGxEMlQON5pN+dEwYUDIV/QaZxxcqo3piNw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788697144;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EQYVUFb7G6M5aCeHM6z5NC+a+5rwL10eojLukdK8JAA=;
	b=XZNWF9x4NzUzFQaDsv6toG09u/Jgi+KX7VcO+i86XIiaCxjXOKIV/nRfTOE0t20KDyoq
	 T0ggwmreV/iojXnTVpNId4omRbRTqK4dz0Op+6wIalzws20/EngYjqZoFr9ICX/zteLpM
	 /IVeBekiv8e5WlVSCn6JBZQvf5735OyVbSBk2PnRu2u0kEhz439nEL1kKy7aUk3ciQ54o
	 C41sjm8riMM7t5pbcfA2XA1L5cePDydsvdJpKno79eX4e0TU6HtwsyRi+6uVfk8dV0pe8
	 bYzj+zfpKTF4iU6bv+uimyqk61+ivKjIbazydZ+dcqK7qrTytMVi3cGld3+IKPOzrYQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=makrotopia.org;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788697144;
	bh=EQYVUFb7G6M5aCeHM6z5NC+a+5rwL10eojLukdK8JAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aPEj6haSMxKqIwSxOfzOoZwHsArbqfd+Qr8ijhuUeb1TEkc2Q4QjEqRHW0wj8NR72
	 BqcAclouAYb/vzNluzVqH+VwfrJx4RkX4HUDJK8c2KFrRu8t85LilpRxg5xvy/7nmu
	 mqgLMcbwm21BLeN0E+s8AaJheIpaNWGAgo3jyL03V2i6vQOstDsy36Z4xt94WTj9hN
	 4QAQu23ZC0nNzbxGeK0YeJ0oM49O2Z/ztcmxlRes7jVr7JBqwmDlTyDZz7OnyGQtwt
	 CpGjiQ+xrUmApHHlPLJns7NyqGG+M3v55uLBtveSgXOaJTlkG/4dLFIxBa+p2W3LQr
	 h5X+fagBnH1bA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2371760659;
	Sun,  6 Sep 2026 12:19:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C7C6A970
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 12:19:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B96BE6061C
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 12:19:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gC0Su4lJxdH0 for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 12:18:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D79F660627
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788697139;
 b=C+Eo71QjCIN+9CBWtBGcSXcPgULLa///nQaM7cajlRoVkTxsZgXA6uhyPBLBBtDlSgIA
 oejNq8CHHmuDZajiTEUmmDvG4V7r6b94V/1e+vxFOUHiXzEg+qsSsyAjdIgSAtmzyVVAf
 63sLodxdtrcJos4ICG/2AbjEwOKPLclswbSvCPBoD0Ckc6Jp2d0/frDdKY+ZajY4hRAjQ
 RIQxIFLRXTgomOYOfZFQnC9Bxlg5s/bmiGn3F+DuB65s6f2kRWTSvpQK4JBaq49ZVAHXG
 ZGxiURjs3SHq7mvfj3K2/EWTsE/wb6eGKWuLPyqm5bGs6st6R5N6aixDPyVODy6ptuA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788697139;
 h=Received-SPF:Received:Date:From:To:Cc:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=EQYVUFb7G6M5aCeHM6z5NC+a+5rwL10eojLukdK8JAA=;
 b=b6zyYS5yEpDQNZeXLLTK4PUAohbnNcO9IiVGmnOghnR4EQ4I895ea0EXn7TlKse7wyc1
 QhnQVWjdW/bq/qHOj/U+QOgsfdPknOU5rwfH6cctHi7jgpDbse0tYgFPW4uOm8X4OmoCW
 622o/lk1UjcDNGgcQA4HLvmTatQpFZluyxLhOY5iR8fIB1FG0bGYXElcXZ74jicdDAeEO
 f2PRc/uiVrWSDsgNgXLWOt1YaROOY0FihCZ9i3hxnO4nMA9LSMNZACJQkGwKTlDMyCr+b
 In5D/2REvix3d1M+pDQS5WA+GXiROA+F8dhVxk46OpSdyfqdt9QdGGRubcdBnPzSuDg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=makrotopia.org; 
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D79F660627
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 12:18:57 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100)
 (envelope-from <daniel@makrotopia.org>) id 1x3Bpi-0000000059u-1lRL;
 Sun, 06 Sep 2026 12:18:50 +0000
Date: Sun, 6 Sep 2026 13:18:46 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Lucien.Jheng" <lucienzx159@gmail.com>
Cc: weijie.gao@mediatek.com, chunfeng.yun@mediatek.com,
 igor.belwon@mentallysanemainliners.org, dlechner@baylibre.com,
 jstephan@baylibre.com, GSS_MTK_Uboot_upstream@mediatek.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, jbx6244@gmail.com,
 msp@baylibre.com, u-boot@lists.u-boot-project.org,
 frank-w@public-files.de, skylake.huang@mediatek.com
Subject: Re: [PATCH v1] arm: mediatek: add BPi-R3 Mini eMMC board support
Message-ID: <ap1aJu7LV4qEM-nl@makrotopia.org>
References: <20260906120756.8290-1-lucienzx159@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260906120756.8290-1-lucienzx159@gmail.com>
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Sun, Sep 06, 2026 at 08:07:56PM +0800, Lucien.Jheng wrote:
> Add device tree and defconfig for the Bananapi BPi-R3 Mini, an
> eMMC-only variant of the BPi-R3 board built around the MT7986A SoC.

Also the BPi-R3 mini has both, eMMC and SPI-NAND. Compared to the
BPi-R3 it only lacks the microSD slot and the SPI-NOR flash.

The tiny SMD switch to pull the bootstrap pins in order to select
a bootorder with either of the two devices having precedence is
labeled SW1 and sits next to the dual-M.2 slot.
