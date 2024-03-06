Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1260C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 13:38:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6721D87D7E;
	Wed,  6 Mar 2024 14:38:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84E9B87E92; Wed,  6 Mar 2024 14:38:40 +0100 (CET)
Received: from esa2.ltts.com (unknown [14.140.155.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF22686FB2
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 14:38:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=ltts.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhargav.r@ltts.com
IronPort-SDR: +ukFQExf7IOQqqX5Vfx+1gxXWw0njVpeyPEPotiNV2EzFkWwXrKt0UF/46+5w/rPb5Z9ARDSbG
 DWm81exB7zhQ==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
 by esa2.ltts.com with ESMTP; 06 Mar 2024 19:08:33 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: dan.carpenter@linaro.org
Cc: bhargav.r@ltts.com, d-gole@ti.com, jh80.chung@samsung.com,
 m.nirmaladevi@ltts.com, sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [PATCH v1 5/5] power: regulator: tps65941: Add TPS65224 PMIC
 regulator support
Date: Wed,  6 Mar 2024 19:08:24 +0530
Message-Id: <20240306133824.160183-1-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <694aef8b-02e5-4b2a-b237-e1d28bf8956f@moroto.mountain>
References: <694aef8b-02e5-4b2a-b237-e1d28bf8956f@moroto.mountain>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Fri, 23 Feb 2024 14:37:48 +0300, Dan Carpenter wrote:
> On Fri, Feb 23, 2024 at 02:42:12PM +0530, Bhargav Raviprakash wrote:
> > +	int mask = TPS65224_LDO_VOLT_MASK >> 1;
> > +
> > +	if (idx > 0) {
> > +		base = TPS65224_LDO23_VOLT_MIN;
> > +		max = TPS65224_LDO23_VOLT_MAX;
> > +		reg_base = TPS65224_LDO23_VOLT_MIN_HEX;
> > +		reg_max = TPS65224_LDO23_VOLT_MAX_HEX;
> > +	}
> > +
> > +	val = val >> 1;
> > +	if (val > mask || val < 0)
> > +		return -EINVAL;
> > +	else if (val >= reg_max)
> > +		return max;
> > +	else if (val <= reg_base)
> > +		return base;
> > +	else if (val >= 0)
> > +		return base + (step * (val - reg_base));
> > +	else
> > +		return -EINVAL;
> 
> Instead of "if (val >= 0)" it would be more clear to write
> "if (value > reg_base)".  Or something like this:
> 
> 	val = val >> 1;
> 	if (val < 0 || val > mask)
> 		return -EINVAL;
> 
> 	if (val <= reg_base)
> 		return base;
> 	if (val >= reg_max)
> 		return max;
> 
> 	return base + (step * (val - reg_base));
> 
> regards,
> dan carpenter

Thanks! Will change it accordingly in next version.

Regards,
Bhargav
