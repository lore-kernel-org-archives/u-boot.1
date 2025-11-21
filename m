Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F7ECFA747
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 08:20:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A242B802C1;
	Fri, 21 Nov 2025 09:20:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Iy5ijHZP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE44783045; Fri, 21 Nov 2025 09:20:09 +0100 (CET)
Received: from mx-relay129-hz1.antispameurope.com
 (mx-relay129-hz1.antispameurope.com [94.100.132.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 508EB832AD
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 09:20:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0413995d28=max.merchel@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate129-hz1.hornetsecurity.com 1;
 spf=pass reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out02-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=Dz/asnz1Rw+1Qw72lkqThuzloowvwq2bsWwpSRhEISs=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1763713206;
 b=HG9+Q9qmTAZTwxn/4kQtoKkQ/1OZ1WljLTXSQo5Nuy9v1y+ra+ZyQPOV1DmiJrzgELrIBJQl
 h/msjq7wqvQENblpZBahOVuBSr/NW8EaC2S006NK8HFeg0hBUjd9y/zTmwgMOv7JxIGq+yWOWJ6
 6L/Ryn/GaMjTc2Fx9Cjv1BWrweI10TKjiu3fsbXhLBElV7egyxmIz2e7gZVVo4nRL1lfGxqVPgU
 tMMYrxdjR7oU/0t6VzQHaqcgxmC9zow77LW9qLR8XlScSstRoaHtgsJPgEr3/hI0uY41DnyKEET
 MoK6yG8mqwsy1xhXqREM+CnsH46UaOcpec6yEzE52Z7pw==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1763713206;
 b=V1mAlwoTFcoiNeujVPHqwPGgApxNY56IAjs+sVqmiF7F+si3iq/7ruFkltIdQhTQIBnhX9Q7
 dRioOgp64uHmAFjnoRxfcMDZHUvdCi1baVgahYNOES8YVHfduRqVf8hyjsrToumqMgOm6Q2ybK0
 YdDdjePzbi2yq/ThHoWd9Ih7IisX5bnKfq1kiMM+VSSqtwVR0I+uT2li53xhYag+hna1U3lEbeU
 w9DgmmrTFs70le5Pak4BpbTysRVcSLnxqoNLkLF+w9tfE0eU8cPXDUbIGuf+W8b13zUs0F9QFXL
 UrQaGLsKlRxxtZq+74H/qdcmNtBB96ZxDFcfnfzQlnhMw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay129-hz1.antispameurope.com; Fri, 21 Nov 2025 09:20:06 +0100
Received: from merchelm-W2.tq-net.de
 (host-82-135-125-110.customer.m-online.net [82.135.125.110])
 (Authenticated sender: max.merchel@ew.tq-group.com)
 by smtp-out02-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 19DD95A0C49;
 Fri, 21 Nov 2025 09:19:49 +0100 (CET)
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Subject: [PATCH 0/2] net: phy: micrel_ksz90x1: workarounds for ksz9031 ERRATA
Date: Fri, 21 Nov 2025 09:18:05 +0100
Message-ID: <20251121081810.73852-1-Max.Merchel@ew.tq-group.com>
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
 mx-relay129-hz1.antispameurope.com with 4dCSnK4Qckz4FV9G
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: 81a6506e554b138be8f7ae12edaa7ddc
X-cloud-security: scantime:2.953
DKIM-Signature: a=rsa-sha256;
 bh=Dz/asnz1Rw+1Qw72lkqThuzloowvwq2bsWwpSRhEISs=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1763713206; v=1;
 b=Iy5ijHZPmZ4ZQwZJm5oNxftdW8z2SBA103Mbq+EhP4X8TMx7tkfT4yXa1ELTOZlGgpuv7Sh5
 Hu+bTEaKhbNFv/nEBRhQ5vsXoFysapXydMZIWjhrxIDZQlpg26NcBNEqPrCsfIYRTZUav+CJQP4
 cGVr0MLhgWUInZD7QUOtXNvtyuCo76npnnymkQDzkfgJg4a8Ljs4q4bWnwoGDZbFz9nnWuwdilC
 gsxrKjduRN5X6iJ2Zweqxc6GkoYf3dnxSN82/gAYcDnIYNgH47bIjOKW7Vjlg1cZYhlfDlg9FVM
 rxnG1C1lJipxo7yB8GTLkEbuGIQNRKW5JC8rJRYqCbP3w==
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

Tested with TQMa6 on MBa6 Baseboard.

Best regards,
Max

Markus Niebel (2):
  net: phy: micrel_ksz90x1: disable asymmetric pause for KSZ9031
  net: phy: micrel_ksz90x1: support forced GIGE master for KSZ9031

 drivers/net/phy/micrel_ksz90x1.c | 55 ++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

-- 
2.43.0

