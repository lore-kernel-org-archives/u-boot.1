Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D700AD29DE2
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 08:20:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E7C583655;
	Tue, 13 Jan 2026 09:20:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Pz8tbjcT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6C0C83015; Tue, 13 Jan 2026 09:20:37 +0100 (CET)
Received: from mx-relay03-hz1.antispameurope.com
 (mx-relay03-hz1.antispameurope.com [94.100.132.203])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7ABF82C7F
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 09:20:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=04663608a3=max.merchel@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate03-hz1.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out01-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=Oim2vbSonv/wE0bcoYjtIQi5V/5XfL5y3yj65VEoB38=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1768292435;
 b=jcPl4evLvRvkza1IzqFy7vNISTrZBzu2FtCtbr7gS0q9+bG4XRarI6hENyL2HJvqiG++Xxi5
 OSVgOloc7Ymfi3Qu0fkAJ0Gd7Ig9Bk7rWE6aAuqjWbz6Dv3n9jjTZOHIJJAdTUeF5si7L8wR4WM
 m7fUDqI2yrg6KKzUDMmXge7XzrPHPM+ZXaeEW73dguUClmU+/1EYHMqOKE/iAb3QP440pgWX2qf
 LDUe0pdF7tufcRqMGtG3cNkku68Y2zvcS2qlFbTuaQELAAaSpUu5MLjoDKDATzx7h6TkpSA6YEM
 YCd/4kOowBQ6sAfruQArIDVGVNO0XQgmi1gBa5C3879nA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1768292435;
 b=CnmNiFUTaR+ALUMJUH6/8txxwPc+3xmjATYbpSU3zYUCuiZOvC9z8yz8onEn0NDbyWm+qlSl
 xdJJ3aCaxUdQxhuJpVmIvv5U7PX3HipKX5tNfkz5C/Idbq3gtbnIvZs+gqaTCDBoPtM1It+WwgB
 7ncPOuht3r8geA1diryTB3eMum7WH1XQcoPJNshtGhFasY+jAZR/L5ApLOlbPMg8JtR64AK4Qhx
 gISY5e57iXDwa87fApGbHQO6WYgBrsbKsBwHNEVQlJRP6IxczzhtTVVaypPko6PACThAjGz6qPl
 JZLOem+0FaP5QzRCZCC2ldrZt+aj9f7BkCTplV3R4y6kw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay03-hz1.antispameurope.com; Tue, 13 Jan 2026 09:20:34 +0100
Received: from merchelm-W2.tq-net.de
 (host-82-135-125-110.customer.m-online.net [82.135.125.110])
 (Authenticated sender: max.merchel@ew.tq-group.com)
 by smtp-out01-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 219CDA411FC;
 Tue, 13 Jan 2026 09:20:19 +0100 (CET)
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome@forissier.org>, Tom Rini <trini@konsulko.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [RESEND PATCH v2 0/2] net: phy: micrel_ksz90x1: workarounds for
 ksz9031 ERRATA
Date: Tue, 13 Jan 2026 09:16:36 +0100
Message-ID: <20260113081726.502484-1-Max.Merchel@ew.tq-group.com>
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
 mx-relay03-hz1.antispameurope.com with 4dr2HR4QLbzdc03
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: a0a8a19017f13462304521722098471f
X-cloud-security: scantime:1.967
DKIM-Signature: a=rsa-sha256;
 bh=Oim2vbSonv/wE0bcoYjtIQi5V/5XfL5y3yj65VEoB38=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1768292434; v=1;
 b=Pz8tbjcTvh+DgJttegpvx+5BQm8d8Qe9JpC7oHX7jInoQLiNaQH8IDyTtwYWV0KWuV9AmXdy
 trbjIb6QMwlWaAxt7UQinh/J4qQ/ONszkIAyPVuOi1Yg9FM8lA4KXCSJmbJVhR7Exvg/t91E6MO
 igdJvVGuizXaoTH7NyTTNNJUtSV3PNclYkVe5NlS0SxkW1wgabozNeae/6U1racwaA9yMWvEWKP
 ie2MxUs+DBTph63IHJw4AiyDCqrF/wlTvhqor/Ffr3pEj3qbOZ5gxHVR4H6H/0sOlvXpU2ALu09
 T7TMIsN+aM7MJusWFRnf1GLYi3Ckue5ufPd8ScLuimSmA==
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

resend the patches I sent at the beginning of December,
just rebased to current master.

This series contains workarounds for ksz9031 ERRATA from the
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

 drivers/net/phy/micrel_ksz90x1.c | 61 +++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

-- 
2.43.0

