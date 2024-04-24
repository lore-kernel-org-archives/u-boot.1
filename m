Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7295AC4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 07:55:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAB9C88DE4;
	Wed, 24 Apr 2024 09:55:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713945311;
	bh=NO4oEIDBwP6c3M00slLiv00gh0JNgi2FnLVMLelElIg=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CPZYEc/gV01ktFwbYuPpxjEu7pDTzYEh68D+bcN+wVXYvQ+Wk/3eBpCNzdiW4hXpi
	 PpZMieWguCf5Q4hQWt9CtgFIQaJJ6Cdb2VOL88vrt8889k44CtHfMgERcKu6eg6CnY
	 wjHZDsh1/X2df9mJlJG1TZxwcDxr+wZXyz6Lsxfjh3QS5oGCVVrXTv4NelIClUXLAj
	 OzuvO2C3RAgrMcjK9t0RZZRsHQ0mIMowGHujJRs0Xe4f+DUComAZYWFzOl6pRk+JZy
	 Qope4WwvFpA2Se+9y2BaCJ1IBCL8oyhbfAFxMgoH1MFvFqAppUJRAnwtXrvnvq6bFh
	 M6MSmEyIdK1sA==
Received: from eryximachos (119.116.205.77.rev.sfr.net [77.205.116.119])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id AFDFE88DE3;
 Wed, 24 Apr 2024 09:55:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713945311;
 bh=NO4oEIDBwP6c3M00slLiv00gh0JNgi2FnLVMLelElIg=;
 h=Date:From:To:Subject:From;
 b=ZD0Ad8YsBDBLyBodzUkbVPTM5oF7HGWwZWgn7wQNuQIzeZlnZ09WzunZ4DEXaS9vD
 Gm98nwq41/Llka0Lj/efxryr6BUJnC8mesOcWAkuc/0GJ7x2DviNEm2Qa0y00VY8pR
 pA3fTLfZTvdRpVIHr5TwmMCGv/5WAhzd/E4Hkae8J+nCVCtYw/kYABsMOHzVHXEWbZ
 GnK/i6ketvbw9K5uCg2lwf3Dktr/YI4O0J9EQG8dHqPgQP31j3H8Ng1ZmGhqXg02mI
 2niQmzWsZQVoMwEky7yu1ofBSjNiRAWEFxlwS63uDEs1i4R/bxeUbR4J6t5sRXB8tL
 KpMDQfft409Qg==
Date: Wed, 24 Apr 2024 09:55:09 +0200
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de, sjg@chromium.org, xypron.glpk@gmx.de,
 bmeng.cn@gmail.com
Subject: EFI payload in 64 bit mode?
Message-ID: <Zii63ehQPa3WAAj0@eryximachos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hi,

I'm wondering if it is currently possible to have U-Boot run in 64-bit
mode as EFI payload.

TARGET_EFI_APP64 selects X86_64 to achieve this. TARGET_EFI_PAYLOAD does
currently always switch 32-bit mode. Any hints what would have to be
done to get it to run in 64-bit mode?

Thanks in advance,
Philip


-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-22  Fax: +49-8142-66989-80   Email: pro@denx.de
=====================================================================
