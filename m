Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A40CC6B2F
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 08:19:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40C95810A2;
	Thu, 15 Oct 2026 08:19:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mxxs2t4r3WSw; Thu, 15 Oct 2026 08:19:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4C88E80F5C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792052357;
	b=WMcrRBqfmSAeLfA6MLrQYAejMd6O5Es7ITd28403I5sefOpJG5kRSNVz7za9PisIWZbr
	 UWmTplYsmKMLyXBd/l7CnypBIUj/+RMR5rMyeFKvqf+QEHscKljTTFeQGFQxGRyAJSd9M
	 154rqhKxV8TWnIoMEfKVpMFw/oMEGcq6ws9NqjeXaD0Ht1hv6J5XeJQu89uQhi9IZRmwQ
	 0ptzayrBa5hkzCx8wpuyMx9Aekyo0ctbCUvxsEYhvCwa/8CWzYfzdoQBhGM0YxR8AwVNR
	 ADim8zUQ9aVebaFtzhp9/52UJQIJs4e1GxvQDMLCRbXwlfrVSN5GEY85Ly2tyt7D1Mg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792052357;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZpDmS5DSDpevCmbHwmwtKMWX334zCcD4SOHvhS6oOaY=;
	b=KfpYbDOJyKB5h/Mp+HHm4sA90xRv6K0jIXEuOAhIkOinatq+eykAO/2pdgJijVipCe4E
	 dRYKQ4JsmfbcDgcl23FJAbLUI1y9N3C11g6erhqnA8Et/O0to/Uxi3+kFclceCrxQyazH
	 1J9CBslAVfp7/wMj+dUkSmdVus2Jo3esrj3QtltXtG+2DJCTw+6XWvSo78xyNjB03AZEc
	 1LYXn6evXTaJIjeXY1rOvTLmhvanjugAdUapCEl00W9T1a4HjVFjQTFNGbySPNI+ycuaZ
	 hCBR2DlwNwPuYzRMwWxSkX5AfrlysyCRvWeH0q4PIUXf0zQ/FL5Upm/QLCK4Y1bz+qw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=J3ECJAd5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792052357;
	bh=ZpDmS5DSDpevCmbHwmwtKMWX334zCcD4SOHvhS6oOaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M3fk5ajazCnrta9Sy3ElS3Fzcu2zxSnawc4q8qv4nupiXyCz6f4b3cNMERNn7MSuL
	 NRjMsGVp+CygbuDr2NNH7NMtVpTm1T0Pl4M0ocPygvip9TUGy2TKLYiswhT1iHOfFf
	 4ef3A1jrKMBczcZ+s4K7PT/NaSHp3K0+xGVOV+kjaxTOAhSKciT1PtV3lp9nfn0VRB
	 S5dBn7gZO4Zf1+NqFbsyyCMdlB1j18nfaRYMufp8UmRoEYDXG+quP3xEW59P46DR77
	 Lt8kS46LqWi73K1b3LlsrT/uRqzjzUsMiTfazOByF0YGXPbZ0KjZeHais39te0WPT0
	 KQjqPEzLO70SA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C88E80F5C;
	Thu, 15 Oct 2026 08:19:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 62DD9A58
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 08:19:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 52AF080F5C
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 08:19:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VGhryLOB5CH1 for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 08:19:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2365F80F26
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.27.42.2
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792052354;
 b=O7mzMNBGuc+lJ9HB/EIWGXwnk5+Q0ua34g7HtZXM1qK/ayEEytbGVqxn/LiWjGqqR0gB
 GHHanH9Ouh/FdiqJqZjjBPDk8O+OZstjLRsm0sRswOIu/zABlEN/YLOYTbR8dOf6YNeWA
 qdgkfc/jdBWlqF3jtGKMVHOIBWwD0Kdtgsm8sIA5L5ujovaHcXfA2cSvJITtd50eZjA8y
 217TWiCJouxwSrSuMaJXubYMZ6MLXI8BLkAT8lSNSBbrxv199U8eqkfKhYqCmE43eqR5h
 51J81rrAEw783WbyEzZerxy8vYddTWOr2yEUTD4b2TRO4UYecNm1kLzZfQQPHFy1u+w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792052354;
 h=Received-SPF:Received:DKIM-Signature:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To;
 bh=ZpDmS5DSDpevCmbHwmwtKMWX334zCcD4SOHvhS6oOaY=;
 b=KK+Zh9/q2lYaGWmeRAnmhKg7xjCNbDDUgVB/LlqtU2BgVpA0bkPUfg4rbtD3nL3romdf
 mB2+2DCrZycXDGwGiMPlTOLskUU3n37l8thAfV8tsOECSQ076k6bbQJxMwyklXrTx7y+C
 tZUuXut0w4P9hJMRr84v54sUhfDPXXfOtLbAgOW0iME0fNKrpVUJjVOgnLktfKpyvTQck
 dfpsvN0CZ+exYOwI6pbb3zMtiBv6v2CRMcIMhh/tuHl+/JxEkGwG6Ndq4/8KJ1V6mLsEE
 /QGX2z0+zYWPE9DRIH6gnrzU34suEjyFDpwLOyjJn3H9UvgJqiWwNuP7ewzM1GCgcKA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=J3ECJAd5; 
 arc=none smtp.remote-ip=212.27.42.2
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.2;
 helo=smtp2-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=J3ECJAd5
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2365F80F26
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 08:19:11 +0000 (UTC)
Received: from L30177.local (unknown [78.240.198.129])
 (Authenticated sender: vjardin@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 785822003C1;
 Thu, 15 Oct 2026 10:19:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1792052349;
 bh=9PmLqny1N/IfTPw2lvHiGi4u7ErcWso9pLbtHwHq3yQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=J3ECJAd53+RsnkACuot73vwI5eQF5N0gA2nVNr5bQb7u/hm30NLXEwYhYOZ/kos7u
 Yz8zQ5JPbdbbzmZiKlsPsF4toUK0KL889FZt7Sh9AHxSLBeoInrknDWaFrhIDg8L/Z
 E+qqgkgiBXaNoVyRP+592imPaaMwmpHGHRVGUzdoQl5ojGXsaPPJ6nLyup0lU7UXaw
 jc3cKSrVtQbPkBblBacc8EFxpR+miLEu2g7W5HJql4c0U6oZZCyqhC5M7hHEyIRXJ4
 GupOuq/gYFggdjVR9aeEuH7cjiN28T+XmJQgCrwEOBW5789gqkcAjS9yoQWV2CzKVn
 b85US47mx0/og==
Date: Thu, 15 Oct 2026 10:19:02 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v1 0/4] pmbus: read back the VOUT_COMMAND setpoint, fix
 the nbxv3 VID handoff
Message-ID: <atCMdn6ObbsLkxS7@L30177.local>
References: <20260928162904.1143614-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928162904.1143614-1-vjardin@free.fr>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Peng,

Regarding this serie too:
  https://patchwork.ozlabs.org/project/uboot/list/?series=525625
it is a gentle ping.

Without patch 4, the VID handoff could run the core above its fused
voltage.

Please, could you have a review when you have time ?

Thank you,
  Vincent
