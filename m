Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA3CC001E0
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 00:46:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53CDF870AB;
	Fri, 20 Oct 2023 02:46:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87413870AE; Fri, 20 Oct 2023 02:46:13 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71BB387051
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 02:46:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=randolph@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 39K0jpfw004774;
 Fri, 20 Oct 2023 08:45:51 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from atctrx (10.0.15.173) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0; Fri, 20 Oct 2023 08:45:49 +0800
Date: Fri, 20 Oct 2023 08:45:42 +0800
From: Randolph Lin <randolph@andestech.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Falcon mode on RISC-V
Message-ID: <ZTHNtvq7LnjsFlwg@atctrx>
References: <baee495f-8326-47c5-b89f-56a62ea95b9a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <baee495f-8326-47c5-b89f-56a62ea95b9a@gmx.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Originating-IP: [10.0.15.173]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 39K0jpfw004774
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

On Thu, Oct 19, 2023 at 10:49:56PM +0200, Heinrich Schuchardt wrote:
Hi Heinrich
> Hello Randolph,
> 
> I just saw your patches merged to enable Falcon mode on RISC-V using
> CONFIG_SPL_LOAD_FIT_OPENSBI_OS_BOOT. I did not see any documentation update.
> 
> Should information about your development be added to
> doc/develop/falcon.rst? Would you be willing to provide a patch?
> 
> Best regards
> 
> Heinrich
Thanks a lot, I will update it ASAP.

Randolph
Sincerely

