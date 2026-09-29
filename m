Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFF4CA5FAD
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 23:08:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 58791407A1;
	Tue, 29 Sep 2026 23:08:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TCTTnysuGncj; Tue, 29 Sep 2026 23:08:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A7E60406C2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790723309;
	b=a0QC2tfLm7DofbRquz81wloBC2Zc6Vm9GXTprZJlB6xgYY6BHpU+WsAsAgF/Q/mOFokn
	 77J/b0WlI4BKiD0Cb6HRpd8+6hRMJ4hPRp1TqIal1MePpjLT/GCa6PSkoFjb3w+o71pyq
	 4Fx40ptl7+ZHGdW6q7IGGZuEpgShCdGBX1QNO+crCqWmXVwKfgcU/ZN5K3TeicpOLCKvb
	 fBsJiNAYzpD5rh1aDsi7Q1Ahr0ybSFyQe314wyxxhtIkSinBj+7hCvhiyHz3W7uiBM8zG
	 FPAt9vZTBZ8nhqcS4v5+enNeXbZttmOzUP2nlRaIG8Oyi9KlVavTeDDS6Z1BKUeVlow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790723309;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ds2mUe4QFeW5u2QIi9sdvp+MqigBlQcny0wf+3UWUnw=;
	b=MuzsDmhPnSGzh+/6vcW6+JFMbgLpFzwx6RaKsYwv/cRO9oEfnWmM3kvmFWnimcIs/vJq
	 +7smwiRpjTQiqpbXwcpXmrXlRRPSHYMKHUp5Q1k/mQpBgUTJEfW8Nh+q3IBqCl78M1czu
	 gG613Ir7sxhSTJdXPmjnCkzeExaxSfBVrjVKatdVFeP4r7ZVJUE1UhFrUoV19LwAiTSnM
	 vAjMH/7cfhfSqt9k8BfAymCL3nPqZXCcy0HQN0DS+DDKyPYkmRa8E7nZ6rxFHh/kZ8I8J
	 SL0kgtAmKDzDjTjqwwVOopqI8DC3tIpV6YJye/JiAQFqN5R83XNhAhKfNkRNdv6qJ6A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=RcTotar4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790723309;
	bh=Ds2mUe4QFeW5u2QIi9sdvp+MqigBlQcny0wf+3UWUnw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0TTxUImW9NoiTSKPc9tfQOKAQz9VWm8SgaV1Ed7fFwHDu79VOjBFw8G5YYwFrm76H
	 JRxYwEySSkOhebV14tM9tQenXw+aQFrZX4JUVFT2QX867nM4i1PrN0Opa4dybb0jAl
	 8NNSeDY55PON8D01bl3wN3taUNzF72/0CvMYHMtK5HHWxL2v44tpZ08rfJY8jqevfA
	 qu2HfwWCLVzKKWowC/97f8CSlJKk62ZftcgbCFATTXw1heJJjDZwijUFxQe626XeUU
	 /rLwryVH8BP4IuRpzMuyGoU+1ziBgQDcnk4GNkYvKNHGrjpj/81gNcckEsIUGEoACf
	 /hzEQ9xDYf7Kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A7E60406C2;
	Tue, 29 Sep 2026 23:08:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E6E8E282
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 23:08:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB954406C2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 23:08:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fcsahuekOmVb for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 23:08:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 688A540517
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790723306;
 b=Z5RSpUxzUHfDAsYwKajBaBiggsHmAFvDn+ksOpkh7uhBrg4RqiXonMapRYUSR9Ix+16F
 W5eIUbiSkuhxUfmjYVSYwrBdjAPgESm1cuctFJWk7zViq3eaI16Vo1V+mdDEBKD2WcyUD
 17usOfaPOAwZ7h3AJLVUvtzVkcdMfHBIkJocFDwffIHcSXjwyu1JMdQqB1PxFcsf8pjxP
 XwFB0q5wZholy/JBtoooPPYsDeWeM19grK3Nae9gw1Cu6ckInCAxXj4iWk85TKXJ+zEsB
 FBnc0HB7aeG+2ph75YijCLDTvz9Cq42D8J5lU2a0Z78ajSePSh8R2zlE6Z3feGxz5ew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790723306;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=Ds2mUe4QFeW5u2QIi9sdvp+MqigBlQcny0wf+3UWUnw=;
 b=i9UVeBqpG3hjlyCczPrIWv8Qc6I2N71HyLn1fl+PDAmaQq9c4W3R8jVIPu0OUjMlJ8Td
 O1scfLUfftSDFHVLP7Z8CXiLWL7L0qh9MXugroLd/oQeaS858AWRVUHgQUk9klmwwlyum
 yMDkuFzuzFq4g6MnvXS+pnt0zeAS0H7wX0BHnznNq2+UxDLJZ9nte86Ca8+bYxvjJHuCJ
 Nc5eixI7lrQeJAiRaCBEErqGrXTLfF9B29xPyFpGrB5Eb5L/8EX9AGmBXZA2UBBAvKjtN
 +tWXveXq9IeVMcUFgQZLz6+CueOakdCBR5YLwZVkD4je+X/pgY8LpLTNExoD9towJ/A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=freeshell.de; 
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=RcTotar4; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=RcTotar4
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 688A540517
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 23:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1790723297;
 bh=Ds2mUe4QFeW5u2QIi9sdvp+MqigBlQcny0wf+3UWUnw=;
 h=From:To:Cc:Subject:Date:From;
 b=RcTotar4VWEbfZ9eZ8rUnSQ0nv3Pwyd0x4xLLn/bLBYb5RQi7IAER7kxVm+d+29o6
 mduogItasJlGMajSZruAxhgauTx1zsTQC471IC+anHSK6wqBJMLN6vUYJiajrQ+esd
 I5jNA0isDY6Myyv3ExeERSbuPNR/rtnEYzjGpWSCJ/fEfo8WrRkEJg3INOC5DFJn0m
 +f13AaBpGqaazlf3Q/qsoja0x9JGfgXmmaKBhqCbENUYO5yoTQUJMJ3/kWQvdvyxqH
 aDcLrUzN5I3icN1ugrysh2NpI7djcskmku6QyOix8jTe257GA7tj+v8O7r+Tcgo5+k
 //jLTpQyoXlrg==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 7261DB22077F;
 Wed, 30 Sep 2026 01:08:16 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Leo Liang <leo.liang@sifive.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, E Shattow <e@freeshell.de>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH] lmb: Add StarFive JH-7110 SoC as requiring DMA below 4G
Date: Tue, 29 Sep 2026 16:07:50 -0700
Message-ID: <20260929230758.616924-1-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Platform drivers and hardware for StarFive JH-7110 SoC are not capable of
DMA access above 4GB. This was previously a problem for MMC access then
resolved by a workaround, since reverted in a3075db94d49 ("lmb: Reinstate
access to memory above ram_top"). The symptom of this is EFI boot failure
of GRUB from EFI System Partition on USB MSC with a starfive_visionfive2
board target that has the on-chip Cadence USB, tested with Pine64 Star64.

Restore the workaround with a dependency on LMB_LIMIT_DMA_BELOW_RAM_TOP.

Signed-off-by: E Shattow <e@freeshell.de>
---
 lib/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 6b6b90bc915c..4bb120c97cbd 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1314,7 +1314,7 @@ config SPL_LMB_ARCH_MEM_MAP
 config LMB_LIMIT_DMA_BELOW_RAM_TOP
 	bool
 	depends on LMB
-	default y if ARCH_BCM283X || ARCH_ROCKCHIP
+	default y if ARCH_BCM283X || ARCH_ROCKCHIP || STARFIVE_JH7110
 	help
 	  Some architectures can not DMA above ram_top boundary,
 	  which is after 4 GiB or 32-bit boundary too. Limit the

base-commit: 369d71b895bc5ce94556d43f05ef9d20084af0d5
-- 
2.53.0

