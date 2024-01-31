Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD34C4828C
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 08:25:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43FC387718;
	Wed, 31 Jan 2024 09:25:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FEBB876EA; Wed, 31 Jan 2024 09:25:48 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50385876E4
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 09:25:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 40V8PEOD039264;
 Wed, 31 Jan 2024 16:25:14 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Wed, 31 Jan 2024 16:25:10 +0800
Date: Wed, 31 Jan 2024 16:25:08 +0800
From: Leo Liang <ycliang@andestech.com>
To: Kongyang Liu <seashell11234455@gmail.com>
CC: <u-boot@lists.denx.de>, Adam Ford <aford173@gmail.com>, Chris Morgan
 <macromorgan@hotmail.com>, Fabio Estevam <festevam@denx.de>, "Heinrich
 Schuchardt" <xypron.glpk@gmx.de>, Nishanth Menon <nm@ti.com>, Ralph Siemsen
 <ralph.siemsen@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, "Thierry
 Reding" <treding@nvidia.com>, Tim Harvey <tharvey@gateworks.com>, Tom Rini
 <trini@konsulko.com>, Wei Fu <wefu@redhat.com>, Yanhong Wang
 <yanhong.wang@starfivetech.com>, Yannic Moog <y.moog@phytec.de>, Yixun Lan
 <dlan@gentoo.org>
Subject: Re: [PATCH v4 3/3] doc: sophgo: milkv_duo: document Milk-V Duo board
Message-ID: <ZboD5Ld38r1_166X@swlinux02>
References: <20240128070614.7702-1-seashell11234455@gmail.com>
 <20240128070614.7702-4-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240128070614.7702-4-seashell11234455@gmail.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 40V8PEOD039264
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

On Sun, Jan 28, 2024 at 03:05:26PM +0800, Kongyang Liu wrote:
> Add document for Milk-V Duo board which based on Sophgo's CV1800B SoC.
> 
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> ---
> 
> (no changes since v3)
> 
> Changes in v3:
> - Add brief description of the procedure to run u-boot-dtb.bin
> 
>  doc/board/index.rst            |  1 +
>  doc/board/sophgo/index.rst     |  8 +++++
>  doc/board/sophgo/milkv_duo.rst | 64 ++++++++++++++++++++++++++++++++++
>  3 files changed, 73 insertions(+)
>  create mode 100644 doc/board/sophgo/index.rst
>  create mode 100644 doc/board/sophgo/milkv_duo.rst

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
