Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAF5CAC592
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 10:47:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A25548329B;
	Fri, 19 Sep 2025 12:47:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D755833ED; Fri, 19 Sep 2025 12:47:09 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4783F833AD
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 12:47:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 58JAkrME068629
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Fri, 19 Sep 2025 18:46:53 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 19 Sep
 2025 18:46:53 +0800
Date: Fri, 19 Sep 2025 18:46:50 +0800
From: Leo Liang <ycliang@andestech.com>
To: Jamie Gibbons <jamie.gibbons@microchip.com>
CC: <u-boot@lists.denx.de>, Conor Dooley <conor.dooley@microchip.com>,
 Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>, Cyril
 Jean <cyril.jean@microchip.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 3/6] doc: microchip: introduce common sections
Message-ID: <aM00moKjWJ40NAMf@swlinux02>
References: <20250902101105.3218793-1-jamie.gibbons@microchip.com>
 <20250902101105.3218793-4-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250902101105.3218793-4-jamie.gibbons@microchip.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 58JAkrME068629
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

On Tue, Sep 02, 2025 at 11:11:00AM +0100, Jamie Gibbons wrote:
> With the upcoming additions of new MPFS boards, separate common
> documentation to allow this to be reused appropriately and avoid
> duplication.
> 
> Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
> ---
>  doc/board/microchip/mpfs_build_boot.rst |  29 +
>  doc/board/microchip/mpfs_common.rst     | 666 +++++++++++++++++++++
>  doc/board/microchip/mpfs_design_hss.rst |  37 ++
>  doc/board/microchip/mpfs_icicle.rst     | 743 +-----------------------
>  4 files changed, 742 insertions(+), 733 deletions(-)
>  create mode 100644 doc/board/microchip/mpfs_build_boot.rst
>  create mode 100644 doc/board/microchip/mpfs_common.rst
>  create mode 100644 doc/board/microchip/mpfs_design_hss.rst

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
