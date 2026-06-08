Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B19CD8CA4
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 19:53:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 515FD84825;
	Mon,  8 Jun 2026 21:53:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UrsZ0aaA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E3EE838BB; Mon,  8 Jun 2026 21:53:25 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C6438405A
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 21:53:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-69e1f777bcaso3545088eaf.1
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 12:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780948402; x=1781553202; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Eg2WZwzPqp+XNPUxifP8dvxS04+IMfVlci4V/8z9SfI=;
 b=UrsZ0aaAtETT/J86c/jIJnr7loqTqaYENqWWGDpszUdnbl+eQe3gBY9TSA7NlKMDpE
 T5/oqabvVwqjiG50YaIOC9wt56dq04Mh22gvBbGPILcfDI2vn/GKRxAh+YywoqHUEWvr
 gQJvcZecE3TWvAYxGrErLAGunMtWpRyqtO+Fc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780948402; x=1781553202;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Eg2WZwzPqp+XNPUxifP8dvxS04+IMfVlci4V/8z9SfI=;
 b=Sg1Je/6Q3MN220Fzu/laRv9/ZQVEXaWaBNxCZiZYa5w/iE6tW6Z8orU90ysS4acWe+
 zkfbsudeAlcvR9CkPz+jBU91YPf2CDMQCiH1zsMAnmhLIhyjCJPW5JVSRvr6nec80jCW
 3KoaH3DSfILCvy7BpJXeDAIhP/eCofGkGcjluyqMYrwBQBrVdQCr8UwpMpTTD2QdPNoY
 jKF8+t0q5CpTIdGt0HIMD2RGbFQMg12QDrtZmrAAQBo9Fnh/Bjd7PBHmH2eEQPgcskhg
 RVSA87thSwZVGD+hT/BsddKSzXVQHG3Mypbb2draB1jpAj2zatgzaAwpO0vplZuW6xVF
 QiHg==
X-Gm-Message-State: AOJu0Yy/pOUR/23pFCFcZ0f4BEZ8NHhaN6ramuq96PBrGRAuZda6duzF
 8NcWjFAFWSceIJ+JpRhMCGka2Rd6rNNtC0vgB1GSJ/2/Wugv3qfgzn7K0cK5zhozLufvmyRdoJU
 6MmJgL64=
X-Gm-Gg: Acq92OEFEGAIwD9gX78lT6wma0sT6sXTUYyMneVJz9zmywy+3aZ969Q7J5FV9eD5tn8
 c/5zjNAG+oCkqdRUxrfRfmvPldzlxfkMWdEhtvTn2aaVJtpUkYFWNQBzoutA9JioZoz23Sb0Fjx
 zdF0Bh6l+/bW7qVOCRDfapXejCHX6oNbGx7hJfElGDLx3MPHF+lJ+aFZnc6o55W2ZQ5WG8Mrd0M
 JNtVL6z2aWB2+p2jKplsvJSzMBQCtRvwHJlY0KknQeD6kmVwv39p6fdsubwTyMIkk6FQapLP7qh
 rjbbZ8IuB9FOIh9opP4nWm+iF50UnsVbZVsNHcwgfLT5JzOgmFbws0xCUA9leuAEbrATqtSKM4S
 S+2k6EZmJ0PGe1ZNeTJhqjC+EknIQEKSxMJbk2mbSNNNkyFy8cpK6bxgnoslmp25Nbget94W/Tx
 Q1hLSfF4Fdioe1+qITpb6uN956+RiQSc21SWP+NwLVuedlYmL2PnQYIutbe2gDC4cBDdiNMsT8Z
 60XAWE1rndRocTKmcWNtCZaDW/uSKjLTGgmp+9iABtCq0CRV6GrV01jpMSa
X-Received: by 2002:a05:6820:1f12:b0:696:6ec9:f601 with SMTP id
 006d021491bc7-69e6d55510emr5546020eaf.26.1780948402159; 
 Mon, 08 Jun 2026 12:53:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-440d8295b38sm16484374fac.10.2026.06.08.12.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 12:53:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, boewingloh.linux@gmail.com
In-Reply-To: <20260605073331.19749-1-f.boewingloh@beckhoff.com>
References: <20260605073331.19749-1-f.boewingloh@beckhoff.com>
Subject: Re: [PATCH] smbios: Fix wrong sysinfo ID for Type 3 enclosure
 asset tag
Message-Id: <178094840148.2176779.3146897663450489179.b4-ty@konsulko.com>
Date: Mon, 08 Jun 2026 13:53:21 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 05 Jun 2026 09:33:31 +0200, boewingloh.linux@gmail.com wrote:

> smbios_write_type3() uses SYSID_SM_BASEBOARD_ASSET_TAG (Type 2) instead
> of SYSID_SM_ENCLOSURE_ASSET_TAG (Type 3) for the enclosure asset tag.
> This causes the enclosure's asset tag to be read from the baseboard
> sysinfo field rather than the enclosure-specific one.
> 
> Fixes: bcf456dd ("smbios: add detailed smbios information")
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] smbios: Fix wrong sysinfo ID for Type 3 enclosure asset tag
      commit: 6d7171bcfe2994a5fc42dd900bbaea732db1aeac
-- 
Tom


