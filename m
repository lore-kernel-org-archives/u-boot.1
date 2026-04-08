Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF7DEA3C55
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 13:01:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A52484118;
	Thu,  9 Apr 2026 15:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=iro.umontreal.ca
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A69183CF5; Wed,  8 Apr 2026 19:48:17 +0200 (CEST)
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C24E83693
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 19:48:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=iro.umontreal.ca
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=gcbu-u-boot-users@m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
 (envelope-from <gcbu-u-boot-users@m.gmane-mx.org>)
 id 1wAX0e-0003xQ-2n
 for u-boot@lists.denx.de; Wed, 08 Apr 2026 19:48:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: u-boot@lists.denx.de
From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: Re: [PATCH v1 1/2] lib: hashtable: fix integer overflow in himport_r
Date: Wed, 08 Apr 2026 13:47:59 -0400
Message-ID: <jwvfr55xsa7.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
References: <20260408140339.798015-1-aristo.chen@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:nvPhJnCGivcZzT0rPesLvFb5prI=
X-Mailman-Approved-At: Thu, 09 Apr 2026 15:00:51 +0200
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

> +	/* Check for potential integer overflow */
> +	if (size == SIZE_MAX) {
> +		debug("%s: size too large, would overflow\n", __func__);
> +		__set_errno(EINVAL);
> +		return 0;
> +	}
> +
>  	/* we allocate new space to make sure we can write to the array */
>  	if ((data = malloc(size + 1)) == NULL) {
>  		debug("himport_r: can't malloc %lu bytes\n", (ulong)size + 1);

Rather than depend on SIZE_MAX being the right boundary, can we do
a check along the lines of `size + 1 > size`?


=== Stefan

