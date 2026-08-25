Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFA2C61DBE
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 17:00:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CBBFF606E1;
	Tue, 25 Aug 2026 17:00:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nm61wV72tQ2d; Tue, 25 Aug 2026 17:00:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787677234;
	bh=6OVweSA3SmRRf1b/mZCVVn8q3pSgdvCBLbOuHgkAleI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uPR5QshtFjmrGd6WNQ5IARdFAszi2bO9VYV+2KjrEKZub1berRyt/ngaqv3/ZhIRj
	 ywaU/HLIX3ctewc30nEdhSyMsn7gKxdRMt0fap9TrqSaNPYI0X3RFzWrp4p/oR0FJa
	 fZfQ8fpqL1cZxW8hUZTMr3oPGPP6LlGK5o/bybRmG3vxNWqCrYb4UeHlKX94CAp70j
	 z3Rr8ZrnnyavpV/3+KYLsCSomRkQNCeazXPalIw6UKbT7n6hrQW1JflcDVziLrrhYW
	 a0mpyuW5bQgVLxxZejqs8S1/qec4UELqOsFH8mSj/rfMoU9baHlO2dzsRNsFascoQL
	 U63F5SE8gC4kQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 020CC60750;
	Tue, 25 Aug 2026 17:00:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6DAFF35E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6BABB4064A
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bcjz9oLSg4NZ for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 17:00:28 +0000 (UTC)
X-Greylist: delayed 623 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 25 Aug 2026 17:00:28 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=gCXTvg+b
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:38e0::8faa; helo=smtp-8faa.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch
 [IPv6:2001:1600:19:38e0::8faa])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6D16E40648
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:27 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hTv0h5xDdzfmB;
 Tue, 25 Aug 2026 18:50:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787676628;
 bh=6OVweSA3SmRRf1b/mZCVVn8q3pSgdvCBLbOuHgkAleI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=gCXTvg+bbahRji+6Gpat8o3zU1lfhrocygdcbnxGZyto7SteUpbyo/8pTZn27fM+E
 2nCrIhOXxabS/xujvM7NAW0yjGZ4ypxzXlFe6vmV7th4i8eQtG34H9BObDd0adoHF0
 t6Pl59ov9VHnHzpAi1aEGreRjhtcjjsU7Px0dpbpCXwi95dP2sSKafsQ3p4Qo/oezr
 uHU+VbpSa/813+TOu9CllFrxhPt3jK8HljE8rplTl9kSBH/uTZJvk/KZWtGODHYdvl
 oGLk8pmOaKcwl/BsErlhoQ7+L7b+8cUVeR2m8nFD+l+lsjQMnU7NHyZUOqplSMCs0q
 uXM4nKuc8M11Q==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hTv0g1GjMzXSl; Tue, 25 Aug 2026 18:50:27 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 25 Aug 2026 18:49:54 +0200
Subject: [PATCH next 17/45] doc: board/google: chromebook_link: update link
 to blobs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-linkcheck-v1-17-ee7573fe3a4a@cherry.de>
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

Update link to one suggested in
https://review.coreboot.org/admin/repos/blobs,general. They point at the
same git repo in the end (checked locally with git clone --depth 1).

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/board/google/chromebook_link.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/board/google/chromebook_link.rst b/doc/board/google/chromebook_link.rst
index 16080304d6e2..f59fc467332f 100644
--- a/doc/board/google/chromebook_link.rst
+++ b/doc/board/google/chromebook_link.rst
@@ -13,7 +13,7 @@ First, you need the following binary blobs:
 
 You can get these binary blobs by::
 
-   $ git clone http://review.coreboot.org/p/blobs.git
+   $ git clone https://review.coreboot.org/blobs
    $ cd blobs
 
 Find the following files:

-- 
2.55.0

