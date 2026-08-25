Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB0FC61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 16:55:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3EB9E6072F;
	Tue, 25 Aug 2026 16:55:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uV-DQUgZs98Z; Tue, 25 Aug 2026 16:55:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787676939;
	bh=FjNWK8ikQ+3wEdeAI53A/4ACKjHG1L7078cFxrpxub0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0XAHYDmDWolrEfKx82BHd2rJn6MYRakot7YJdqOHeBs5E5i8WB7Qw4GQMWHHqOhCb
	 UYkH3Jiffka0hEb018oQvt9azYHw0nzf1DCL1CTH/f2xGFrd5VAIkibNKSljITnCix
	 JzGS7QFH1qGUHgz04E0aeUxTAvtKyY/uLam8suavYt7MRjZUu49+oOYDQGjZScRuJ9
	 p+xNC0JNxmPVFo5nnKZs2VCizuPEAC6i5GRwciDin+itdh9eLLik3Vm4meHzzkCSvN
	 zYp0CzgS5hh0xO6BUc4TaAFfyui379ioTSycJ/N/EpNDN++ZJqw0ZfDUcRAyj7moVz
	 h4azLzF1c/sCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE5A160722;
	Tue, 25 Aug 2026 16:55:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 748573DA
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:55:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5B2D94018E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:55:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ns-xV7kO5tCV for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 16:55:36 +0000 (UTC)
X-Greylist: delayed 309 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 25 Aug 2026 16:55:36 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=lmBON7PB
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:7ff8::8fae; helo=smtp-8fae.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch
 [IPv6:2001:1600:19:7ff8::8fae])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 439BC4004E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:55:35 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hTv0F3420zkDf;
 Tue, 25 Aug 2026 18:50:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787676604;
 bh=FjNWK8ikQ+3wEdeAI53A/4ACKjHG1L7078cFxrpxub0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=lmBON7PBAD0EllbUGXAm1uPdNKmaJh8E6fHWcvER897QUS+wL7ATQRnkZUaGGviCH
 tDFSWVAhsWd4GmMNDLR/tOKPJjzk/iuewwKqEnAvumT1x/4QhbkvsCMPrnpfr3SGgw
 5SwY8R6etaZwGR3G6nNyu8AFjlin4Uy1tFc7J+lUNZstLo1whKj6F4jPNuksWPmxFP
 FRMW5/QYVtzhC/OmQb/U/fzk+iCUEoslfePfu3KB33Cy5KKYSqrfhqxNoKmp8awb4M
 Lmd3K7oIEel6bU6nwH8yv7X7c25eZqDi6H1/sox9LtDza9orn1S/bU7GXsJ6hMqN/R
 TMiOJry+MgNmQ==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hTv0C5w6NzWgc; Tue, 25 Aug 2026 18:50:03 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 25 Aug 2026 18:49:40 +0200
Subject: [PATCH next 03/45] doc: develop: sending_patches: fix links to
 pw-am.sh
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-linkcheck-v1-3-ee7573fe3a4a@cherry.de>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
In-Reply-To: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
To: u-boot@lists.u-boot-project.org, u-boot-amlogic@groups.io, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Viacheslav Bocharov <adeep@lexina.in>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Soeren Moch <smoch@web.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Le Jin <le.jin@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Sean Anderson <seanga2@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

The OpenEmbedded wiki doesn't reside at that address (it does at
https://www.openembedded.org/wiki/) but it's unclear what it's useful
for to link to it so instead let's remove the link.

The related pw-am.sh script cannot be found at that address, however it
is available at a new address so let's use that though OE-Core lists it
among the Outdated information in its wiki[1].

[1] https://www.openembedded.org/wiki/Patchwork#Outdated
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/develop/sending_patches.rst | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
index 8172dc551838..8286808173d6 100644
--- a/doc/develop/sending_patches.rst
+++ b/doc/develop/sending_patches.rst
@@ -479,9 +479,8 @@ mbox file and apply it using::
 
    git am file
 
-The `openembedded wiki <http://wiki.openembedded.net/>`_ also provides a script
-named `pw-am.sh
-<http://cgit.openembedded.org/cgit.cgi/openembedded/tree/contrib/patchwork/pw-am.sh>`_
+OpenEmbedded also provides a script named `pw-am.sh
+<https://git.openembedded.org/openembedded/tree/contrib/patchwork/pw-am.sh>`_
 which can be used to fetch an 'mbox' patch from patchwork and git am it::
 
    usage: pw-am.sh <number>

-- 
2.55.0

