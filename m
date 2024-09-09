Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56ADCD4F4C
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 06:41:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2394588C70;
	Mon,  9 Sep 2024 08:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF4BD88C73; Mon,  9 Sep 2024 08:41:54 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9310C87FED
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 08:41:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 4896fTo7000268
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Mon, 9 Sep 2024 14:41:29 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 14:41:30 +0800
Date: Mon, 9 Sep 2024 14:41:27 +0800
From: Leo Liang <ycliang@andestech.com>
To: Kongyang Liu <seashell11234455@gmail.com>
CC: <u-boot@lists.denx.de>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jonas =?utf-8?B?U2Nod8O2YmVs?= <jonasschwoebel@yahoo.de>, Kever Yang
 <kever.yang@rock-chips.com>, Nishanth Menon <nm@ti.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Sumit Garg <sumit.garg@linaro.org>, Svyatoslav
 Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 2/2] doc: spacemit: bananapi_f3: document Banana Pi F3
 board
Message-ID: <Zt6Yl6tahrBRHwU8@swlinux02>
References: <20240718043329.1500-1-seashell11234455@gmail.com>
 <20240718043329.1500-3-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240718043329.1500-3-seashell11234455@gmail.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 4896fTo7000268
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

On Thu, Jul 18, 2024 at 12:33:23PM +0800, Kongyang Liu wrote:
> Add document for Banana Pi F3 board which based on SpacemiT's K1 SoC.
> 
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> ---
> 
> (no changes since v1)
> 
>  doc/board/index.rst                |  1 +
>  doc/board/spacemit/bananapi_f3.rst | 78 ++++++++++++++++++++++++++++++
>  doc/board/spacemit/index.rst       |  8 +++
>  3 files changed, 87 insertions(+)
>  create mode 100644 doc/board/spacemit/bananapi_f3.rst
>  create mode 100644 doc/board/spacemit/index.rst

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
