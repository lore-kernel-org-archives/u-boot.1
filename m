Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17030CDB482
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 11:00:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F02286F65;
	Wed, 18 Oct 2023 13:00:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697626803;
	bh=3vOQLGRlyMCH1Xulds7G1sIPWSf38fMaeQsVq2wTDsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nvTGUmg5FdZlw+2v0HkZglYkbLnFl2/2KOAy155iQjL+LxNuUrgmuSEt4YtLVqj5a
	 pl8eGpWfNLKHSuw4FAWyVXHKWT9PMh7T4aKEVDaCz4zwLVKPL2mhZazAlMIe/7Z5lj
	 8kQHK5RH61qlJOKHCciogPdnfRlhXdtLkSsRVKr4CKcU1fiqjyKHwNuFYZSITP7ylh
	 e90Bm9E58BiBmaEEL/2/3sfmNdVK7mzCrap8VBHQp2QxmLsNV83VV8E0UhJXbiWorm
	 P0m53frCwsKHs4lFo85CbG0QGA180toaAzLdh8JRF5KXzIRbivRKhJ3zDWcOEBk6J+
	 17LnureijYrEA==
Received: from eryximachos.home (unknown
 [IPv6:2a01:cb18:989:a700:4b67:3ae7:15fa:40a0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9EB4C86F61;
 Wed, 18 Oct 2023 13:00:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697626801;
 bh=3vOQLGRlyMCH1Xulds7G1sIPWSf38fMaeQsVq2wTDsU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ncd2J9cRHNLNweq3onHAgsNr4w290F+j2FRAA+RTp5NSvwM7Uo7LGPw0HReNIFEZk
 TQNRY3TbvuJ2XoSBZkMvOET1jdILbmxxBx6Za7E6R32jitNlaxGErqB4u2yBVo3khM
 qiOPF8ckCnb6Dy/UqMT24Ss5O6qfOv24KztI3yfDe3XKRvLnT7d3YjKEsmFcf9TGrp
 xGVJhlu2ztwbhngoP/CJ90AUcrcwO7qG5kil2M0VVwghk1UTIbl5vkW6yqp2vmkaQV
 1era811KcCgUcVDLb1uLgqASPUO63etWWA/G0v+yTRNX9LePenmQfPJ9loe5l8xx3q
 p0ck0gi0a8Qxw==
Date: Wed, 18 Oct 2023 12:58:32 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Heiko Schocher <hs@denx.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
	trini@konsulko.com
Subject: Re: [PATCH 2/2] bootcount: Add driver model I2C driver
Message-ID: <ZS-6WM11jJnsaakJ@eryximachos.home>
References: <20231013094302.28944-1-pro@denx.de>
 <20231013094302.28944-3-pro@denx.de>
 <037dac45-eee4-c0f1-b72e-ee0a2bfe3807@denx.de>
 <ZSk-2lBrLW5Bel_X@eryximachos.home>
 <ZS6ET7ExtDSCfsNN@eryximachos.home>
 <CAPnjgZ2OZka03fG5Bt49JxoLn-VHy5TB81r6_uXTy+K5SOGYOw@mail.gmail.com>
 <1ba8ea25-bad0-b66f-b189-67754c488103@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ba8ea25-bad0-b66f-b189-67754c488103@denx.de>
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

Hi Heiko,

On Wed, Oct 18, 2023 at 06:31:57AM +0200, Heiko Schocher wrote:
> [...]
> 
> May Philip can use uclass_get_device_by_phandle and try a list of
> possible UCLASS candidates, like UCLASS_RTC, UCLASS_I2C_EEPROM,
> UCLASS_POWER,... and if found, check if parent is UCLASS_I2C...
> 
> may not so expensive ...

Looks more cheap and elegant than the other variants indeed. But I'm not
sure if we can maintain generality using this approach. 

What if the specific I2C driver is not included in the build, because
the devices "actual" functionality is not required? Or what if a driver
for the specific device does not even exist in U-Boot?

Wouldn't the device fail to probe then?

Please correct me if I'm wrong, I'd give it a shot in that case.
Otherwise I'll try it with the aforementioned
device_find_global_by_ofnode() followed by device_bind_driver() using
UCLASS_I2C_GENERIC (I hope that works).

Best regards,
Philip


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
