Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACF7CFA747
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 08:14:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8868A8042F;
	Fri, 21 Nov 2025 09:14:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="io08b5ch";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 521E282C7F; Fri, 21 Nov 2025 09:14:35 +0100 (CET)
Received: from mx-relay15-hz2.antispameurope.com
 (mx-relay15-hz2.antispameurope.com [83.246.65.157])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46159801CF
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 09:14:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0413995d28=max.merchel@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate15-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=8bEpURpZfnTGqZKYn0ALHChvTd4ISrvWa7XD5FM/wZQ=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1763712872;
 b=H03ElSam976/m8rppO+vMsicoTP2d8s1jrFEhkTRPzJo+jfmDhBIqZ8CeFFurgyqZ9/YeBIF
 5IzFgTWOPlq/2zKcajQV1gwa1+2oRNgZuG6hLc4hf/Lcd3jx+n94pvExPcYbz49FkqInor2xzMB
 oTrL5W3/Z9oF4j/aP9+mQbzh2VzxoxHE0Jqdny0GUSZid9mje7F/3OM69eH9rLx2hPjRokfR92o
 ufrmVAyzE0CurzoZJ5gLaW5E6CALUuODORHvPXVIfFnIyuvFM5MsQmDjdFKcmIzRHyTN/dA4BnX
 5p8RTiuH+LyIBU85tsk90qPuy0vWe+cEWdkkI7g6hR4Fw==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1763712872;
 b=TZXIgzQRmdBwp0L8HHyHCYfH7zBDsfGBuC0WZXsIaU+EWtPH5W8OVV+9wp1MBfnbwNYs1mb/
 cRqGT8pT13swIjCpEf+BXWBr72IczCGGtTanZL2fK17Ws9hKG4ZWvjJ/IMzT6m1w5ripC+xkBb7
 +xFBiZh7tQfqV4tSCYukCI+DMVCaagm3q1c9bVIS0z8U/9YP/txQ1aACQym3q+kyiiHWuCZ1fff
 nqIm5deQBKlww4VMCFj1Km0N1H13Y42xpLcJizWBKBN75R8TUzyNRQ+iar4hd9+PcZaCXmPHGNM
 TjL46NhgzTu1lr+GrRUAsb45Wu/XaqAj3A3bEDtHwPwyw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay15-hz2.antispameurope.com; Fri, 21 Nov 2025 09:14:32 +0100
Received: from merchelm-W2.tq-net.de
 (host-82-135-125-110.customer.m-online.net [82.135.125.110])
 (Authenticated sender: max.merchel@ew.tq-group.com)
 by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id
 1F0D1220D76; Fri, 21 Nov 2025 09:14:20 +0100 (CET)
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@denx.de>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, Stefan Roese <sr@denx.de>,
 u-boot@lists.denx.de, u-boot@ew.tq-group.com
Subject: [PATCH 0/4] board: tqma6: non-functional changes
Date: Fri, 21 Nov 2025 09:11:26 +0100
Message-ID: <20251121081138.73285-1-Max.Merchel@ew.tq-group.com>
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
 mx-relay15-hz2.antispameurope.com with 4dCSg049zTz2FbCY
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: 956f088924c0b42f006298e7179a2fd5
X-cloud-security: scantime:1.780
DKIM-Signature: a=rsa-sha256;
 bh=8bEpURpZfnTGqZKYn0ALHChvTd4ISrvWa7XD5FM/wZQ=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1763712871; v=1;
 b=io08b5chlfbNONZH1thDisH88HrL7S3qvko0YgUba20AVdYcKWrERx4w92+kB9+JkcOwhlAo
 LgcBUcxEduoaNqHBuiNwbh26msT+cCuGe6BjfQkz/yC6/+Ld3CgLHkD6NJrJ+JAuuEuzCKJHyKS
 cB3A2/oanzy1EqE6CtwsJXVXFIMt2rokMwnd8m+/f4pkrUCzS6yP5R2RMz6CK4AHfFyAJ2xH9Wj
 loBSH626YBYw9NIfriA5qzBhS1b/DORLssGvKAwjPmows3LARIQNchzBitHgWly/RBrDEI2qXYl
 0Dqq3u3fBJY9cxeUZSJmexJKle4P2XZo7XDOpcPGNftMg==
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

this series brings non-functional changes to the TQMa6.

Best regards,
Max

Max Merchel (3):
  tqma6: Remove empty function tqma6_iomuxc_spi()
  board: [cosmetic] tqma6: adjust SPDX tag
  board: tqma6: update MAINTAINERS

Paul Gerber (1):
  board: tqma6: style fixes

 board/tq/tqma6/Kconfig       | 23 +++++++++++++++--------
 board/tq/tqma6/MAINTAINERS   |  3 ++-
 board/tq/tqma6/Makefile      |  7 +++++--
 board/tq/tqma6/clocks.cfg    |  7 +++++--
 board/tq/tqma6/tqma6.c       | 16 +++++-----------
 board/tq/tqma6/tqma6_mba6.c  | 10 ++++++----
 board/tq/tqma6/tqma6_wru4.c  | 13 +++++--------
 board/tq/tqma6/tqma6dl.cfg   |  6 ++++--
 board/tq/tqma6/tqma6q.cfg    |  6 ++++--
 board/tq/tqma6/tqma6s.cfg    |  6 ++++--
 include/configs/tqma6.h      |  6 ++++--
 include/configs/tqma6_mba6.h |  6 ++++--
 include/configs/tqma6_wru4.h |  2 +-
 13 files changed, 64 insertions(+), 47 deletions(-)

-- 
2.43.0

