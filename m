Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6721C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 21:37:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF10F81703;
	Tue,  1 Apr 2025 23:37:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=seoulsaram.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=seoulsaram.org header.i=@seoulsaram.org header.b="caLf5Gxa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FCA382051; Tue,  1 Apr 2025 15:41:49 +0200 (CEST)
Received: from mail-108-mta79.mxroute.com (mail-108-mta79.mxroute.com
 [136.175.108.79])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 646C880584
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 15:41:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=seoulsaram.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumoon@seoulsaram.org
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta79.mxroute.com (ZoneMTA) with ESMTPSA id 195f196244c00067b0.001
 for <u-boot@lists.denx.de>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 01 Apr 2025 13:41:43 +0000
X-Zone-Loop: 24373b5a8e5b47f67877a6387f8f1521c86089de04bf
X-Originating-IP: [136.175.111.3]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=seoulsaram.org; s=x; h=Content-Transfer-Encoding:Content-Type:Subject:From:
 To:MIME-Version:Date:Sender:Reply-To:Cc:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1m5YI8Z7Zh+FjmX7OFLbHGlcMLc2AdIaLSfYKV2qw/0=; b=caLf5GxaqMXiM0H0tMKStwAp8w
 9LqP0G4UohIcSOkAR4z6NLwFpubCCSCRKTTZnlgbnq2VzgPcUZiagZ4TMhwoEOWhA3Hff2fMgXaAs
 HzjvdJD37d4t9KCwxdycsEqUrykwGCwFy6Y3fOuUC78MpfG6O1qUrLSioL2a+k244+vT6qtLkQ4Oy
 zEqwQmEaF+Oq8K5FoqfSrD8uVGoJGVGIJYJ9y3Nkb9s2j0WN/bKGAZVm/7H+6NxIQTDpL5G5dHM7D
 Bd0zgwqumOI0oQQ0S4/gpnfEgAsFeoRDYHxmN6ZfTBDYnsoR8BAEuYRr8v4WIHtHIfdFVQC1n2t0a
 yM4hTCvw==;
Message-ID: <09c3ffd2-3933-4a3b-b64f-5cc10a1942fd@seoulsaram.org>
Date: Tue, 1 Apr 2025 22:41:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: ko-KR, en-US
To: u-boot@lists.denx.de
From: Sungjoon Moon <sumoon@seoulsaram.org>
Subject: [RFC] Upstreaming Orange Pi RV2 vendor patches - Seeking guidance
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: sumoon@seoulsaram.org
X-Mailman-Approved-At: Tue, 01 Apr 2025 23:37:36 +0200
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

I'm working on upstreaming vendor patches for the Orange Pi RV2 board, currently available at:
https://github.com/OctopusET/u-boot-orangepi/pull/1/commits

I'm rebasing these patches onto the latest U-Boot branch (v2025.04-rc5).
To ensure the patches meet upstream standards, I have a few questions:
  1. What specific steps should I take after rebasing to prepare these patches for upstream submission?
  2. The current patch set is quite large. Should I split it into smaller, more focused patches? If so, what would be the recommended approach for splitting?
  3. Are there any particular coding style or documentation requirements I should be aware of for the Orange Pi RV2 board support?
  4. How should I handle any vendor-specific code that may not be suitable for upstream?
  5. Are there any maintainers or subsystem-specific mailing lists I should include when submitting these patches?

Any guidance or best practices for upstreaming vendor patches would be greatly appreciated. Thank you for your time and assistance.

