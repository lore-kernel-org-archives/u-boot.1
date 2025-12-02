Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E21CCFD2F6
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 08:16:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE3C983E1B;
	Tue,  2 Dec 2025 09:16:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="tNlwlPB/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDD2B83E3A; Tue,  2 Dec 2025 09:16:12 +0100 (CET)
Received: from mx-relay50-hz3.antispameurope.com
 (mx-relay50-hz3.antispameurope.com [94.100.134.239])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0D7583DE0
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 09:16:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=042460c183=max.merchel@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate50-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out03-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=ffBzL89B266FY2cKYEP7mkeVesDcw8phxLrHaG4oxIg=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1764663370;
 b=h///x91MSdXIlcH+KpfCe6vo/0rC00KtqUcwbXjuHa1G+LJEeXZiwGQSbPqS70c9R0ywv/E3
 EtXRcyPSHqc554hFUhLJTpctpfPlRyJquZuqYNtzmHm14Ub0HFLmWghbS86t1CTH56yQ+khpoHC
 g7q0/WnnTReiNMSxtsH9FEEIsYXfA0PtVVB6BohoczR4pKHOyc+NIPDeGUoQYSHZrN+veKppEOx
 +9tkHJ89j8r7kVE3eeCeD5s6M2e5ZI/35frbRGrctLnPOVPql7WjGhekBtPL0Rx9ON/tKEGxH/w
 exOIgqWMrPqEHHwQMQOpV8ilfPF48mCTeeAXZuvswq0uQ==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1764663370;
 b=KwlT3j7Fx6ToOimHko95LhIxikifCYPxiMDuNM/0ORGGlATCkdDVVxVJMC+Z1/pYOGnme1bo
 B64cyig8rCNK/tBSfvZ9yzpqtogJl8z56g3zxXc/uZIbiNyTRavXn89kgOvKgYP/Cfvu3WXprNV
 MDfgezOjecF7MSwkGjSCGktnreauUHn1Srto+80wlKbHlXpn76PCHtD1ZkkETNey77CPhhppQVb
 rVeJimSnkCr7/S3bRb+8ivgbh6B9QYF7B08iwu6SQ541dIvW8IOvY6tK+ez27tyJvPggu2OSv86
 ky8Jsdk1a1L+a/pCPUXUNE6zhZsUk+rDYp0vYwCG43qrg==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay50-hz3.antispameurope.com; Tue, 02 Dec 2025 09:16:09 +0100
Received: from merchelm-W2.tq-net.de
 (host-82-135-125-110.customer.m-online.net [82.135.125.110])
 (Authenticated sender: max.merchel@ew.tq-group.com)
 by hmail-p-smtp01-out03-hz1.hornetsecurity.com (Postfix) with ESMTPSA id
 A70D6CC0E95; Tue,  2 Dec 2025 09:15:55 +0100 (CET)
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 0/2] net: phy: micrel_ksz90x1: workarounds for ksz9031
 ERRATA
Date: Tue,  2 Dec 2025 09:13:41 +0100
Message-ID: <20251202081352.302025-1-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: max.merchel@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: max.merchel@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay50-hz3.antispameurope.com with 4dLD9m1ZSzz2nHpZ
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: db2619668910c675c322f9ee9c47ebae
X-cloud-security: scantime:1.863
DKIM-Signature: a=rsa-sha256;
 bh=ffBzL89B266FY2cKYEP7mkeVesDcw8phxLrHaG4oxIg=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1764663369; v=1;
 b=tNlwlPB/qxIHbLq8JoDfC6EAN0PfSxgJBrBzhzPeRI5p19SQqmiyLRzzEdDOCS1VeqnF6WDF
 4rSeMpjV92IJ2xvnANXLOT9AhviSwUsUY4t6cJpBAH6VDrzatpIIn8CXPGu/P67x/5v3u9OgkHI
 7Z2TWiOVq2stzslATkhks4PVS1Roz2PYfE9roslDXCxt8g6ntME2DSXv717fsV2vS58x/3F985J
 CeYESrq5GJAlA3Fg6fPBWG2s6e+FgvfkLUXh/g4kRwfJ2bvR1JB6xibLFCZchplOOiicSpwAxkp
 9xpF8bhmALDH17hKt8ZbT9LsAAfvOTZyIoplhJVo3Jrag==
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

Hi all,

this series contains workarounds for ksz9031 ERRATA from the
Silicon Errata Sheet (DS80000691D or DS80000692D).

Tested KSZ9031 with TQMa6 on MBa6 Baseboard.

KSZ9021 untested

Best regards,
Max
---

changes v2:
- [PATCH 1/2] net: phy: micrel_ksz90x1: disable asymmetric pause for KSZ9031
  - implemented workaround as function 
  - integrate the workaround for KSZ9021
    - add KSZ9021 to commit subject and message
  - add references to linux commits
  - remove unnecessary return 0
- [PATCH 2/2] net: phy: micrel_ksz90x1: support forced GIGE master for KSZ9031
  - Change the variable order to a reverse Christmas tree layout

Markus Niebel (2):
  net: phy: micrel_ksz90x1: disable asymmetric pause for KSZ9031 and
    KSZ9021
  net: phy: micrel_ksz90x1: support forced GIGE master for KSZ9031

 drivers/net/phy/micrel_ksz90x1.c | 66 +++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

-- 
2.43.0

