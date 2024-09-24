Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7648ACF9C5B
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 03:24:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8588882BE;
	Tue, 24 Sep 2024 05:24:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21F2988B9F; Tue, 24 Sep 2024 05:24:37 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13EAC85B66
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 05:24:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 48O3O2mX056676
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Tue, 24 Sep 2024 11:24:02 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Sep
 2024 11:24:02 +0800
Date: Tue, 24 Sep 2024 11:23:58 +0800
From: Leo Liang <ycliang@andestech.com>
To: <bigunclemax@gmail.com>
CC: Wei Fu <wefu@redhat.com>, Yixun Lan <dlan@gentoo.org>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v1 1/2] gpio: dw: Add ngpios DT-property support
Message-ID: <ZvIwzuHwHYdQATbv@swlinux02>
References: <20240920090532.280504-1-bigunclemax@gmail.com>
 <20240920090532.280504-2-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240920090532.280504-2-bigunclemax@gmail.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 48O3O2mX056676
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

On Fri, Sep 20, 2024 at 12:05:23PM +0300, bigunclemax@gmail.com wrote:
> From: Maksim Kiselev <bigunclemax@gmail.com>
> 
> Starting with Linux commit 7569486d79ae ("gpio: dwapb: Add ngpios
> DT-property support") the "snps,nr-gpios" property was marked
> as deprecated.
> 
> And since all newly added dw-apb-gpio nodes are described using generic
> "ngpios" property, it's time to add support for it.
> 
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> ---
>  drivers/gpio/dwapb_gpio.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
