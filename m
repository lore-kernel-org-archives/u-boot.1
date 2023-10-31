Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90955C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 07:46:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9059087C6E;
	Tue, 31 Oct 2023 08:46:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698738380;
	bh=LL9xr4+UmbUD+22Jfr1GVedN8fcV/kP9LDhj3p52k1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xQHb/Q7m7Q4jTQjYuTECbrbTQtTz3O0DisS/cQBs1eGglZPtFSdW4NUvsZreFW3KV
	 78FGeErtp+tHeEk6ZR/VX+sTOPK++UHR1v8GaM10/R4PO4JdTfSrQGXvpt9EPvfDpb
	 PRUNQrDUVHely3VXkSwNGtlquE4nI+LoluHF2lwQ/yk3DeAFtzCwap62VVMaADfPhw
	 rKFgVip+dblfun4DFwi9OGGi5lsoW2fQk8H3rkWsPT4LgintNjZy+i/5IwD8tAlNIL
	 QHa8qK3BqFlSHi12fIetzXHYhpoAfAjk35euIwfc/jrNfEJPKu3ynE+c6G+NDB/ZuS
	 G6fwnlQlrM4Sg==
Received: from eryximachos.home (unknown
 [IPv6:2a01:cb18:989:a700:4b67:3ae7:15fa:40a0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 07CFD874CE;
 Tue, 31 Oct 2023 08:46:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698738379;
 bh=LL9xr4+UmbUD+22Jfr1GVedN8fcV/kP9LDhj3p52k1o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=J9P0gcPrcRvPGpcVmM83xGb+FQt0xxoRPDwpcW6GXGHNx0tKapK+BUWeJ4G4U7s/A
 jhi0UN/0xLIGCJrYTU9vHsbCLdED6I1MtQh3BbTCg15ObyHeIgQYZqFSyOgkiCnAjK
 KSOR66wYA/v51MnAT9NcAjan6inx4CCHxmMjLbeAbzaDq+rzCw1rE9t2kxp1xK5WbD
 xkBRaLmZzpEf+hIqWpXx43k3uMhkIuwvW0cj4GA3MctCAIKeCP9oazot5GjxwZ3S2M
 1zN5xryI/ZH/nvBcQcRdKpG30Johe1RpqWZDFagsEuUkcr/yO//ShlgRjyFmPbgreU
 STGM+d+K17h1g==
Date: Tue, 31 Oct 2023 08:44:45 +0100
From: Philip Oberfichtner <pro@denx.de>
To: hs@denx.de
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
Subject: Re: [PATCH v2 3/3] bootcount: Add driver model I2C driver
Message-ID: <ZUCwbfRhrfGpUjtw@eryximachos.home>
References: <20231020090227.16634-1-pro@denx.de>
 <20231020090227.16634-4-pro@denx.de>
 <1f54d2df-f56b-f2c0-6962-c6aed0c61a31@denx.de>
 <8fd9d28e-1463-7351-0202-4dc96234c68b@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fd9d28e-1463-7351-0202-4dc96234c68b@denx.de>
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

On Mon, Oct 30, 2023 at 06:17:23AM +0100, Heiko Schocher wrote:
<snip>
> 
> 
> Your patch drops an checkpatch error:
> """
> ERROR: Do not add common.h to files
> #164: FILE: drivers/bootcount/bootcount_dm_i2c.c:10:
> +#include <common.h>
> """
> 
> Could you please check and fix?

Oops sorry, V3 is on the way.

Regards,
Philip

> 
> Thanks!
> 
> bye,
> Heiko
> -- 
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-22  Fax: +49-8142-66989-80   Email: pro@denx.de
=====================================================================
