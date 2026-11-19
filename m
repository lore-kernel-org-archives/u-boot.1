Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02047606A326
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LRcgdNk0
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2EF540D76;
	Thu, 19 Nov 2026 18:41:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jUeF76PqHUGy; Thu, 19 Nov 2026 18:41:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9F42640D20
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795113715;
	b=phXl3zQRltXAxxkbpNqUm9OCHft0QQETCJxGVWSSJmcyHDb2frFOMMhw6ZKz5Ls2+im3
	 JQvcTKvmFszLB1hqlakrLhp6huc1xNcv8jKi58y/n+4L5qJDte6DctRtLzQNyvrH7OSOZ
	 iubQUpdc7HQPVjGFOdC6KcSjg6Jx1SSYF02EA6jJp68UcGN/Tw/0ICv+W2TEb3va76JYD
	 CRWC4NRTuqSzTFM1UFUKxZaTH2Zvo+kN68p7tdhKf+LqmGJPT53uY2az14x8UcRE8LWwP
	 sOzWB7LSXKvtJo/AlmXi8iKwtahvkF3zavxRZxQWIeFGQoaCGrUaOka0cZfKmuKPL+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795113715;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Subject:To:Cc:Message-Id:Date:From:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VsEkK0tVK6GrM4UipXKnC/Uak9xh+AleW/+FWikLE20=;
	b=fc/pn1jqhk57iRBt/Gd/UzlODYFz43vTAmlTGl2OC2f/EAqZ5Cy2jVI+ia2vDmiZjhnd
	 xpdPn0rhrasEKklquzQscQkY3DlINp4aLugMOc4iMCDAPD0mrQOo91DbDOMh5ESUG38uA
	 uviYOB8ICYpgDVIK929OEcFhqhC+Je7wGtwGgyqbSeX/WpSTdaHMyl4gthDhWur5SfkEB
	 RyfywV7MEsTVSjTl+dYp18n1Z8lj/FJFXfmOPkFAdPk6mFxK4MDEFWO9EQVtqGMTqlvBB
	 CHKFTokhjNTGyjr/yazVC3fUMBtymA+EZ0gdEUs19EHftXd0P2rfxzPSoUQUpKFh0HA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795113715;
	bh=VsEkK0tVK6GrM4UipXKnC/Uak9xh+AleW/+FWikLE20=;
	h=Subject:To:Cc:Date:From:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LRcgdNk0c3EF3MFSVSHXB/NvMSMBo+o0nN4yQC6RJ7yn6TcTLJK8WZ0UzXDkcgw/W
	 t2WbqtI7ZoNTShXsC8Va1Xx1isN7Ud05grUHeiwVyC4NMy70516FGAAuXu+Aea1z0t
	 okDTFCxWxuH1Ebgo7SIq7mUplPvlCIe7e8L+/YEnaBtoNdLmqodXGrHogcXbt2OC8N
	 kcu8AT7ccV98oeiyGY2d4M1++4IZB6FJIpC0ftEy9AlOmb3eknXbX/DSNs124+7Bo4
	 DR6/llZgL8ZHkhAU8wodtdsaIznJcFAzP6X+lCqb4bb6O+Ke9AFdI+36Mpifd4mRjQ
	 +XIaBR0w0Rtmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F42640D20;
	Thu, 19 Nov 2026 18:41:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0EC91465
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 18:41:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0079540099
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 18:41:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X1Kc6yWI31Tk for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 18:41:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BC96440071
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=213.95.11.211
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=213.95.11.211;
 helo=verein.lst.de; envelope-from=duwe@lst.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=lst.de
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BC96440071
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 18:41:52 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2005)
 id D163768B05; Thu, 19 Nov 2026 19:32:44 +0100 (CET)
Subject: [PATCH 0/2] fix NVMe on Raspberry Pi
To: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org, duwe@lst.de
Message-Id: <20261119183244.D163768B05@verein.lst.de>
Date: Thu, 19 Nov 2026 19:32:44 +0100 (CET)
From: duwe@lst.de (Torsten Duwe)
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Hi again,

to follow up on the complete series to support the Raspberry Pi 5 let's
look at the issues individually again, in order to get them done.

So here is the DT node fix for NVMe as briefly discussed, along with
the enablement on RPi. Simon's feedback on the two patches is included.

Torsten Duwe (2):
  dm: core: try harder to find a DT node for DMA constraints
  configs: enable NVMe on Raspberry Pi 4&5

 configs/rpi_arm64_defconfig |  3 ++-
 drivers/core/device.c       | 14 +++++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)
