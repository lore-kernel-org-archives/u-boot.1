Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A69606A336
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lBxlZP+g;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=ljQG1qe5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DFD8C816FB;
	Fri, 20 Nov 2026 15:55:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KrGveXd3VrE8; Fri, 20 Nov 2026 15:55:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C28F0816F7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795190124;
	b=OE6HB6NRZ9FTWCNdZFlCER26BB7VcaETY6k5FDtMhuewnPEtAK01j0Vs8cQx8n42jlhj
	 yW9/o8zn/0KvfdF3w4JL08ZQtTzxQYPfc/m8AbcJmCPMRFAoAn0RXerL35DRnNMFAsWAs
	 MegEKpMHdff4r05u2wgWyCHsqxAYD72WJ05ncsrv1EExHuXbc6ejl4AX08qjinv/1YObk
	 f68vLL3ymHkt+U4wnCxwp5KXnsa0BabFlsURWsSQ0VmI1gVaiDxmtV1G6cdk8UCAqrIWX
	 QjjxmbrBmmhsZZxvqmZB8bOtvzVasDMGbNNaCymopbwjv1YJOq8ccF66cuCfFNjx9yQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795190124;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EEDQevGo/1vYB3Z8qC3FpUWQXgMXNuhzkTfOXD1dMuw=;
	b=W6wjc68B66HG88vyQua7gnSKuDiCph15TMRnshT8fynm44OzfkqiCiCVWHTNVNAADIu9
	 lZGTi95nn2iXQQYgAfMGhI4AW8Z20RlZM/ymDrxKVrpFPjZHyvWrRBJC2xjLWoqhF4w2O
	 fJ+IEMzXjqjs++QpkbHKZdRM0BDgU6dgrh1AOU4Fc7tWIWW57PLqSIRePNR5tQn7gmx8U
	 SVsujL2zBxoSTSj8/QKQGbUeyRynvI9e0jQiTV1yT7pORO1MnDRCAp5mKagOeSkXqnvWE
	 ETQEju6Px02IYi05il77Gw0j9NSyLYfrp8IO3umrMxfQqF4wlwDOGfdCujctfjOA5vA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795190124;
	bh=EEDQevGo/1vYB3Z8qC3FpUWQXgMXNuhzkTfOXD1dMuw=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lBxlZP+gZRBpRrFNYVaRBac2IZVVb0BfCHGpoZnZ0uvnI1po0pb61miM1GhpXS5TD
	 4tybtGA6oz4J2BGaVSF8x9v145fAiS5yiAvtw0yEA9AgBywpPs8RlN12wII0u9tnMS
	 xisZ0rZIZPe9NYDLAAy7W8Bv86SIyaLXRiJzjVXeoqVYhmBugI+ZlOBvcn3Nxdwiu9
	 cFubVmywMEU2N/acgqsA5RH0NC2bn2rhQT4w+O0rw0XnmiVlXJHbWXgbleBf0XN3co
	 x+LipRtgsVKagIYmzZdzXv23gVjgg7QyC/J6fxOloXqq6anwJr5k7iIZsB6cxFdW7s
	 vLF9kJn9ANDxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C28F0816F7;
	Fri, 20 Nov 2026 15:55:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9FB4DE22
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 15:55:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9DD8F40111
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 15:55:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ik-SB17fOTUI for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 15:55:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B0ED440050
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:5550::42ac"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:5550::42ac; helo=smtp-42ac.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=ljQG1qe5
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch
 [IPv6:2001:1600:19:5550::42ac])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B0ED440050
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 15:55:19 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jWKfr3JCfzrN2;
 Fri, 20 Nov 2026 16:55:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1795190116;
 bh=EEDQevGo/1vYB3Z8qC3FpUWQXgMXNuhzkTfOXD1dMuw=;
 h=From:Subject:Date:To:Cc:From;
 b=ljQG1qe5fTrJjqlTGT3tZ9i2LGo7rDf1iHO9x6gfXvFDGo7CIFFYNgfB3RRB/ILTg
 B7/PjolUOp01Gw7tcxpuAcD1F5EHQgnwM7jqwXk5BsCwubnov66Sw7OeIiIpbnlDCN
 bulx4JIvNeK5t4eMStTJpfmKob9tgfEESSxzTXjq/0FZiQtBFx5wg7UP0CEhU/QaT+
 r8ACD/HgWggONJN0vLtYjoHIF8f8lNRRI1OpXjUAqB76dZ2fnS52/Qx1uagGo/B1Gn
 wFtWmSKYGBhC2CXMBgT0SrieLeXslQ/uOpziJHaZdvesHi3RNwVsRH6QxLY4+9Kr9n
 9X+uhvr0l+R+g==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jWKfp5cx9zLs4; Fri, 20 Nov 2026 16:55:14 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH next 0/2] rockchip: update RK3588S Orange Pi 5 Pro to ditch
 our work-around
Date: Fri, 20 Nov 2026 16:54:59 +0100
Message-Id: <20261120-orange-pi-5-dts-sync-v1-0-bf749974a410@cherry.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMQQqDMBAF0KsMf+2ACURorlK60GRsp4sombRYx
 LuX2u1bvB0mVcUQaUeVt5ouBZFcR0iPsdyFNSMSfO8H53zPSz11VQ6cm7F9SuIp+THP+ZLDENA
 R1iqzbmd7RZGt4fZXe01PSe034ji+wafB634AAAA=
X-Change-ID: 20261120-orange-pi-5-dts-sync-bc2adfd9d565
To: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Cc: Sumit Garg <sumit.garg@kernel.org>, Quentin Schulz <u-boot@0leil.net>, 
 Tom Rini <trini@konsulko.com>, Heiko Stuebner <heiko@sntech.de>, 
 Dennis Gilmore <dennis@ausil.us>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This cherry-picks a patch from upstream Linux, so we can remove the
changes made to U-Boot-specific Device Tree.

No intended change in behavior. Not tested.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Dennis Gilmore (1):
      arm64: dts: rockchip: Use GPIO function for PCIe reset on Orange Pi 5 Pro

Quentin Schulz (1):
      board: rockchip: rk3588s-orange-pi-5-pro: remove now upstream work-around

 arch/arm/dts/rk3588s-orangepi-5-pro-u-boot.dtsi    | 22 ----------------------
 .../src/arm64/rockchip/rk3588s-orangepi-5-pro.dts  | 14 ++++++++++++--
 2 files changed, 12 insertions(+), 24 deletions(-)
---
base-commit: 79497816056122c49b3b135e14cbac59374e636c
base-tree: https://git.u-boot-project.org/u-boot/u-boot.git next
change-id: 20261120-orange-pi-5-dts-sync-bc2adfd9d565

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

