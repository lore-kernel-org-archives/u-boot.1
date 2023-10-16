Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4A3CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:30:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6559E86F2D;
	Mon, 16 Oct 2023 11:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697448287;
	bh=VLljGNJjgGaYUVixTgFYENunKFnJ305zz3+6+Z+AXZA=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=y10XCviudwnEEidfuenuigqB7NtURVrKyibcAD5EasEVsyqRr9WWszbrSQd/9p3eK
	 gJPf7bj7+eBHadp8mDd/VaD7UjKHx+wy1bmIt1Z6mGfse2tqF6XURcrVj5WmZq8jWn
	 /DKBjJnJYUrWye4kGbttHEs3hyVce6c2Nz3P5jOS93El+Aj8hzL2EpvoqHtgFs73/L
	 FHbGWe4WNEmdsPtJxEhb7/AmQDe81jmydW0m5k8L5uiQ5x/Zjk37Dpjb+oykf0bBVo
	 HA+k/5r+EuR3K7mdE3BWiqfacMRThe49xxtunZE1FUzBSaIb3VVV5mx5BGBhBc9nVc
	 nyXY1uOr8ZnHg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 166F686EE0; Mon, 16 Oct 2023 11:23:22 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E90A986E4F
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8BTr2pYKz1sCln;
 Mon, 16 Oct 2023 11:22:40 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8BTr2ckrz1qqlS;
 Mon, 16 Oct 2023 11:22:40 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id gDri-pTc8G-S; Mon, 16 Oct 2023 11:22:39 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 11:22:39 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
X-Patchwork-Id: 1840901
X-Patchwork-Delegate: sbabic@denx.de
To: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>,u-boot@lists.denx.de
Subject: [PATCH v1] board: toradex: verdin-imx8mm: set fixed LPDDR4 refresh
 rate as per errata ERR050805
In-reply-to: <20230928143933.11510-1-andrejs.cainikovs@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Message-Id: <20231016092322.166F686EE0@phobos.denx.de>
Date: Mon, 16 Oct 2023 11:23:19 +0200 (CEST)
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

> From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> Update lpddr4 configuration and training using updated spreadsheet and
> tools from NXP using data from previous spreadsheet and verified
> toward datasheet:
> - MX8M_Mini_LPDDR4_RPA_v22.xlsx
> - mscale_ddr_tool_v3.31_setup.exe
> The most relevant update is related to errata ERR050805:
> "DRAM: Controller automatic derating logic may not work when
> the LPDDR4 memory temperature is above 85 °C at initialization"
> Other relevant fixes:
> - DRAMTMG7 register: corrected calculation of T_CKPDX parameter
>   (equal to tCKCKEH for LPDDR4)
> - RANKCTL register: corrected calculations for ODTLon and ODTLoff
>   to follow the JEDEC specification
> - ADDRMAP7 register: added support for 17-row devices
> As per errata ERR050805:
> An issue exists with the automatic derating logic of the DDR
> controller that only samples the LPDDR4 MR4 register when the
> Temperature Update Flag (TUF) field (MR4[7] ) is 1’b1. If the
> LPDDR4 memory is initialized and starts operation above 85 °C
> (MR4[2:0] > 3’b011), the MR4 Temperature Update Flag (TUF) will
> not be set. The DDR Controller will therefore not automatically
> adjust the memory refresh rate or de-rate memory timings based
> on the LPDDR4 memory temperature. This may cause the controller
> incorrectly setting the refresh period, potentially cause the
> LPDDR4 memory losing data contents and lead to possible data
> integrity issues above 85 °C.
> Errata provides three possible workaround options, while option 2
> is the most reasonable:
> Disable the automatic derating logic of the DDR controller and
> apply fixed x2 refresh rate (0.5x refresh). This option is
> suitable for designs that are expected to boot at or above 85 °C
> and memory’s MR4[2:0] (Refresh Rate) DOES NOT report the following
> conditions:
> 3b101: 0.25x refresh, no de-rating
> 3b110: 0.25x refresh, with de-rating
> 3b111: SDRAM High temperature operating limit exceeded
> [1]: https://www.nxp.com/docs/en/errata/IMX8MM_0N87W.pdf
> Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
Applied to u-boot-imx, master, thanks !

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter  
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
