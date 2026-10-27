Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080F2606A31E
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 09:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WG6wb4Lr;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=mJKX3EL7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA779606FA;
	Tue, 27 Oct 2026 09:40:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8nMZdTMTZqgJ; Tue, 27 Oct 2026 09:40:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2685E6074E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793094032;
	b=nH5J+S+H7c3+XMkgLBzsIN92sl8ILe2VFGDOrvEh7DJg1Jc4QN1r4Pnxc86ZI6rWaIHQ
	 90goErz5xr53p7FPyNVg9s6cKLGCRylRYDkxuKMUUkPMWSSr5KO6U0g+6W0YdJVFnl7uO
	 yNzbCzzNfHqL9Xjl8ktGbsv8syX90qmAuOutDdyUpoAUT9HQ7m/LSyLtwkAa1VZk4EToJ
	 eEk/WwtaVfLv4Frjt6Vcwx1eKIygJI2hdqr1mt4juNnVR3uycln18gjTABX3bMzAXqubh
	 D/Rc880+sMt++g+Lvgw1Y+cQNRlHO0Ej2jQL4lEY1UNhXvkVPakt6Z6ou4I337mD1cg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793094032;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BaCBFdB+2X9D5thBb7ebplK+hH814a8FF4FfyN+LxU4=;
	b=oN1PPl8J0amkBoURB6Tm4wuw+8DQE2HsoDINnVGFHcnNl0rxHDftaKrypC+2wNh0Rniw
	 3C7t26YR09KRn8rmrisXnf4RFy53Q+Zj12//yi6fB+LGpFtb2HqiQjIy4H7f9Q2Bx4Iti
	 7v5coyHblvmr41pZ9J9ueNbZ8OcyECXrqe4DnroIXuvQnbrtp302RLCS94Kc6JOyTwjk+
	 uqJj98P6+EJ+JOO2BwXkSD3T+aeVegrMyEhHKe1RE5sfaTBIl1ZHo1AlZczR/7/wJtJJc
	 VFm3GTsKl8guamdteIe17WEkdPO1h9dfDo1CULqfeqHcZr6B516mIgmyhJq3mnWODGQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=ew.tq-group.com;
	dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=mJKX3EL7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793094032;
	bh=BaCBFdB+2X9D5thBb7ebplK+hH814a8FF4FfyN+LxU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WG6wb4LrstrAfAyBNsZwfKDrdrhAgQMhhXMoMyil0ZL/pXQc5Pt+/7QVfjAUoX3Xe
	 /qLg1QOYUxlelOOIFMdOiQfsh69ASVmEMX3FDelXL9lPjkUBcLOjJGgMunHsT6y1JJ
	 eZFgIJKHQwwm4AiunZaYM0CWAfMmvkIZHsO1mGdewCM7ZPZNlD/IzfIs76+k0/nfWO
	 tHMOihcpbRLOAivm43omzUTpzNpY8GKfWLCtJkjP4CHptNJoIc+JnXTHzHMxIY22cC
	 yOY+YXviINt4g/+FqhzmfiijDjsHncXwrAyw6u63EbIvSsLVCzR1Uo/hgCN+B8IAef
	 n+6j+FxHF4o2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2685E6074E;
	Tue, 27 Oct 2026 09:40:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4193872
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:40:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3399860687
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:40:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RxLnOdJpF6pA for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 09:40:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 81A2960755
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793094019;
 b=MeZcE31bE/6VpO57JHfWieDIr0zz9cZzrSV0MoGpVsC46qKgNHo3ad6msmbDI1F3ALV9
 1+zWnqHzXBZ0yPAqkTlRuXJ3EAR3ht9dk6Efocgs69ZPQ6x4/pXxBfb7z1DUoWQB6aLDr
 uylpO7aCHALBYPGg5bxskSey9d+rLUr7HfbkWOfdesKmuOKvu8YQFdxYeCBtBmN7nPDzW
 T/ZbH/IeQxhvviHTlIe/LqW2YXuD0XhplTUu9bdnUVWaSqLfTHFA6ngEWxmtlgRBbrC5d
 O9iUAxrBOrgCPt6oh3GpuJ4LqvotndsqPv1l4MtgN1lqpbVjUZpPVpdPm2Nxm6UVcUw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793094019;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned;
 bh=BaCBFdB+2X9D5thBb7ebplK+hH814a8FF4FfyN+LxU4=;
 b=F/kEtTMt7Rp/S/NoiO1GedUs36LtyaWJjUCqvDxXbYm6cyA0cv5vS6pYUff5tstPTFaA
 17P1sJUe+MkOZBgMDIAeXmo5ofyKXAE4x3hDGnQhw+Mz+yBRY/FlUXlY5oMVIXT4qxnui
 9GJKsc1yGRuVplYoX+LtSbrg90gDpp6iYvA+ieaP7MoDQgXNW0AFqY6sJnlG6paXhOdwR
 y+hKRo10HKS0l5GVnQFa70mpcMAGKIhoQXqBuuwsBS+X75551PF0NnmPfPzfZUBybZlya
 Tf07w9+qu1FixZTGI57EGEnsZsl6dWtJV5yHLiDFmd3lm9rTp3NmXYqKV+98UgqbF1g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=ew.tq-group.com;
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=mJKX3EL7; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=mJKX3EL7
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 81A2960755
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=BaCBFdB+2X9D5thBb7ebplK+hH814a8FF4FfyN+LxU4=; b=mJKX3EL7pjEAW/BA2m6OX9Qdiu
 PSkA81n/YBF69+rg/ekhQgyJmL7UXeDIr5ki6vgjRowd8yXJM0lUx7XqwvVVxcS8INKf2g4DuZFXX
 8vKZqJX9imEtCyPbN6V2QZzcNI0F6EcocMh5ReUg0W41mZ6wgeja5AKtwwj9lmaY/sqIK1AcCRvgu
 7r/BgML+Y2i5Dn2YxhrRM3vzjPlXAk1+mgf/FQUgWvlccYr0fr0LL8e1XsAnDey0+Sdwed0XxqncY
 hyL49GhKJz0+x+0njhXQcxP4ZDJAWgutzYJCQM2jJNlgG+ilxdxFOlKwNw4GyoDAH4F+rgy2qcsNq
 JWJkXEeA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xLdfE-0007Uw-2a; Tue, 27 Oct 2026 10:40:16 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xLdfE-00022y-2n; Tue, 27 Oct 2026 10:40:16 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH 06/16] power: domain: imx-gpcv2: set CPU domain mapping on
 probe
Date: Tue, 27 Oct 2026 10:39:03 +0100
Message-ID: <8e1a93cdadc33a5cca67d6d8d447b072d8839321.1793091394.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793091394.git.nora.schiffer@ew.tq-group.com>
References: <cover.1793091394.git.nora.schiffer@ew.tq-group.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28166/Tue Oct 27 07:24:12 2026)
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The CPU domain mapping registers and bits were already defined, but they
were not written to the hardware. This is necessary on the i.MX7D.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 drivers/power/domain/imx-gpcv2-power-domain.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/domain/imx-gpcv2-power-domain.c b/drivers/power/domain/imx-gpcv2-power-domain.c
index f61982df60f..b94ec60fc0d 100644
--- a/drivers/power/domain/imx-gpcv2-power-domain.c
+++ b/drivers/power/domain/imx-gpcv2-power-domain.c
@@ -522,6 +522,9 @@ static int imx_gpcv2_power_domain_probe(struct udevice *dev)
 		return ret;
 	}
 
+	if (pdata->domain->bits.map)
+		setbits_le32(pdata->base + pdata->regs->map, pdata->domain->bits.map);
+
 	return 0;
 }
 
-- 
2.55.0

