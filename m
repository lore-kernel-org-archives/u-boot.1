Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8573C25B75
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 03:13:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42DBA884C3;
	Thu, 30 May 2024 05:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A9FD8864C; Thu, 30 May 2024 05:13:56 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A10188225
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 05:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 44U3Dfx8012011;
 Thu, 30 May 2024 11:13:41 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Thu, 30 May 2024 11:13:40 +0800
Date: Thu, 30 May 2024 11:13:38 +0800
From: Leo Liang <ycliang@andestech.com>
To: Conor Dooley <conor@kernel.org>
CC: <u-boot@lists.denx.de>, Conor Dooley <conor.dooley@microchip.com>,
 Padmarao Begari <padmarao.begari@microchip.com>, Cyril Jean
 <cyril.jean@microchip.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 2/2] board: microchip: icicle: make both ethernets
 optional
Message-ID: <Zlfu4mvmJ-6q2h1X@swlinux02>
References: <20240515150434.406916-1-conor@kernel.org>
 <20240515150434.406916-3-conor@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240515150434.406916-3-conor@kernel.org>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 44U3Dfx8012011
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

On Wed, May 15, 2024 at 04:04:31PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> A given AMP configuration for a board may make either one, or neither
> of, the ethernet ports available to U-Boot. The Icicle's init code will
> fail if mac1 is not present, so move it to the optional approach taken
> for mac0.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  board/microchip/mpfs_icicle/mpfs_icicle.c | 23 +++++++----------------
>  1 file changed, 7 insertions(+), 16 deletions(-)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
