Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EB5C5DF67
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 06:54:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C3AC80C6C;
	Tue, 18 Aug 2026 06:54:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CKldnvJAcmNl; Tue, 18 Aug 2026 06:54:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5312E80C75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787036061;
	bh=lqzcp8/9yko2QzVWQQiwSg732LN2x47yo20eG0M3rmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a8O9Oigyjyc/pbH5nr19m1vZ/pEPrrz4GFzQa4UQjfsHbY+7v/6Kw51/a41UXl46Z
	 twLN8+LNAMA7trHNGiAVfzwIcQvN+8u6sGeSFOuJHYXXcNGdCuwha8qjywWZsbTnTH
	 vOH089B7CD9qkjetIAlSBLO8b2iAhEuTUbBgEcWXn9404ZWlqoYPoqqp1pWv3DzITl
	 H25oNLrmsaOz97Qx350da+mb27tjejvbFKc//Zh1OQV5Wgk7XIGOmD6hzApjaGi29/
	 9vt4wsCEm1QIoT85wLEUqG7oiBbbAdVdunx8RTRhFQgyhJ3Ffklqv1eC7SykR8iSfP
	 NwyNZ/9kmCSoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5312E80C75;
	Tue, 18 Aug 2026 06:54:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 35E4425B
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 06:54:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1BC3B80C75
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 06:54:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q-nfAXBLCrEf for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 06:54:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2769A80C6C
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2769A80C6C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=fcLB71Sj
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2769A80C6C
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 06:54:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787036024; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mWRJx3nE7pLJyT91BjzfWaqwvLp2It9TRn30nOORl3lMfUfdk4PLLBQHpmp8XzjZBLEeXU7k9CFKJ1uk85T/LRojiJRwUkDNwNg1/xlIYIru8YA1Ur/hdTbAKWfr/RU+4e0z3suDIp9GkFKmm1QlUjnz5tgeY80j2vqiCvNLoXM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787036024;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=lqzcp8/9yko2QzVWQQiwSg732LN2x47yo20eG0M3rmU=; 
 b=HfIVe5uHsWkFGOqVoLTNkk+tkwJ1X3MbxayLmXihIDEhKHz2LGgSdMcPji7uebDETT3aFLmizKfFufeFyBFM0P5A99KG/DhFLkY3w78Yb3+opzFfGgMgUqeIP51sc2fhggiRhQvbmA7qSABmLE8qsr3RJUD0AM1VP3GF03Vy+34=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787036024; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=lqzcp8/9yko2QzVWQQiwSg732LN2x47yo20eG0M3rmU=;
 b=fcLB71SjgtfwpuI7YjPkAMlnilYHtNjVs2JIRTUB+aYzzkgGQcTD4k3qGeg1n1U/
 2yYgLoihXa3LFdmI21/pdekaVAgIamZa2ORJ74iPZ1uxbY2v2hOfudTVm5LMT8Hlen6
 8q5AizVs07e7GoxROxDgjlxWmyH0inDTYoAQFG6g=
Received: by mx.zohomail.com with SMTPS id 1787036022103382.2473958430709;
 Mon, 17 Aug 2026 23:53:42 -0700 (PDT)
Date: Tue, 18 Aug 2026 06:53:29 +0000
From: Yao Zi <me@ziyao.cc>
To: Junhui Liu <junhui.liu@pigmoral.tech>, Heiko Schocher <hs@nabladev.com>,
 u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org
Cc: Huan Zhou <pericycle.cc@gmail.com>,
 Guodong Xu <guodong.xu@oss.qualcomm.com>, Tom Rini <trini@konsulko.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Lukasz Majewski <lukma@denx.de>, Yixun Lan <dlan@kernel.org>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v2 0/4] i2c/clk: spacemit: k1: fix I2C bus configuration
 and clock handling
Message-ID: <aoQBacTKiBXUDddj@pie>
References: <20260815-k1-i2c-fix-v2-0-7d2a48607233@pigmoral.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815-k1-i2c-fix-v2-0-7d2a48607233@pigmoral.tech>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/287.21.86
X-ZohoMailClient: External
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

On Sat, Aug 15, 2026 at 11:40:20AM +0800, Junhui Liu wrote:
> Fix two issues in the SpacemiT K1 I2C driver and clock provider.
> 
> The first issue is that the controller bus mode is selected using the
> functional clock rate instead of the requested I2C bus speed from the
> device tree.
> 
> The second issue is that the TWSI functional clocks incorrectly include
> the bus clock enable bit in their gate masks. As a result the I2C driver
> can operate with only the functional clock enabled, which diverges from
> the device tree description and the Linux driver (both expect separate
> "func" and "bus" clocks).
> 
> To fix the second issue without breaking intermediate states, the
> patches are ordered as follows:
> 
> - First add the missing bus clocks (and their parent chain) to the SPL
>   clock tree.
> - Then update the I2C driver to acquire and enable both the functional
>   and bus clocks by name.
> - Finally remove the bus gate bit from the functional clock definitions
>   (except TWSI8, whose write-only register requires the combined gate).

Personally I think it's okay to break booting in this case as long as
you explicitly point it out. Merging the conceptually related PATCH 2
and PATCH 4 which together fix description of TWSI controller clocks
would make the commit description shorter and clearer. But it depends on
you.

For the whole series,

Reviewed-by: Yao Zi <me@ziyao.cc>

Regards,
Yao Zi
