Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F4E606A923
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=e5Ug5rHF;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=pFvGpszn
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DAC03811C5;
	Thu,  5 Nov 2026 16:43:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O8y0I3d01dtk; Thu,  5 Nov 2026 16:43:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E6199811C0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793896980;
	b=Dbks3V7RpUhLpEuUCGV1ITb3wdKatE4GmroDcWing3zaARCLFAV14cx8PcowfO3RTRPg
	 XnX/8Oou1Jf/1nAc3uClst/PfziM0hzqUpmXuuY5zObrwtr+MLaWHzd7gL8ZeEUp0BhP+
	 7yWNKmJdM37yQqjVI4SlPo1OcsCPzgvMMqt8mTL/whDxKhe0xGT/Tf8jks38d8XZzRYFC
	 b7qfn5ouN5wxClOgob7OXuIPhIhDBfNy5aETjKyC1AuKhY1mA3vCc1QzsL0a7ZyU2BwzD
	 LzmVwkTVTj2bb0TGy6VLuyLC8mMyJg2TI4Tdp4upk8xKr1uEjCCNys83PhuoT1nHTiQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793896980;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-ZohoMailClient:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zEH5hwYalvMUznHucIF5rCBERa+mPA4RoifVGYClaj4=;
	b=bqP6njckgmapjBcShBzwK+Ak+W0cdmvIN7D9Uq96vOxRMKmD3W6Ph/HNmGU5bFu+egID
	 7HFe9lWx66yuWH0vrVDm80hmxQgkfqT1O7+c+XRZJFajaZAMDq6EWMWbX+BMzJBeVqqx7
	 0ZgZ1LewU0JXoHprBm73iso/Sf9l56HjhGJgejJU0C8YzA5TtVhQAGCqxqIBHQJ+E9fLY
	 ZiY9We964GBU4820LxCa2F2F3P67Xq0WM0EWBVG6gu38C2Yxuhi+BTbQWjUktK4zjUQ16
	 CunxbjvMY+JG1ONGpKaqEaNGvWjoCV6w/6htJCgBZt2yVvNo3GyebrdJ9ajxQBRZu8w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793896980;
	bh=zEH5hwYalvMUznHucIF5rCBERa+mPA4RoifVGYClaj4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e5Ug5rHFCOvnobl9r3x9kpPw/2rZVmpMUF1XBqUy9W+prWKujQAwXa9CTFvRshrlY
	 Q4GHvIoiVOm8BKBR+AdPNjnJnwRprByHGl5050EcB/iIZqeiLy/e+thS5J7NexDIlU
	 RVstGGBBdGNkJUqwHeViRvlt/0wxvxfwpZLV4fKYmu3eyKPQi8okBVSAtQAwz1fcqr
	 fn7FuWzDyB0kSJHWQa6nJ7BEeNSppUe4qxmW8ddHaWITLw29rTjdxFi2cw6LwMhj5t
	 dvdrEIcX7vQSvsAgrZQMp4xZKS+cw168Yf1xkrCS+997xZKRQUNHLIipig3cvs/VDT
	 bDxSA5/mezq2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E6199811C0;
	Thu,  5 Nov 2026 16:42:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0678D235
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 16:42:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E060440869
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 16:42:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id krR7mVKKj1dI for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 16:42:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0BCF440829
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=pFvGpszn
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0BCF440829
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 16:42:56 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=pFvGpsznrL8lGrw6kGME6WJQ+/AlZBfKDA8HdIjIUcmJuimzwdDE31U6Dsxt3RS/qzF0nKrNZcppkLbVwZkquNX3CprwPKy8BMz9o+RrIa9a75CeT1x2zhDgz0tpLf1vRQEyj7Czqo4rRsCKK+oOoQO9AuL19A8CJFTET+p0M5w=;
 c=relaxed/relaxed; s=zmail; d=pigmoral.tech; v=1;
 bh=zEH5hwYalvMUznHucIF5rCBERa+mPA4RoifVGYClaj4=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793896962418467.99503544513914; 
 Thu, 5 Nov 2026 08:42:42 -0800 (PST)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Fri, 06 Nov 2026 00:40:43 +0800
Subject: [PATCH 5/5] doc: spacemit: k3: Add SPL build instructions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-k3-ddr-v1-5-1e60e1d78020@pigmoral.tech>
References: <20261106-k3-ddr-v1-0-1e60e1d78020@pigmoral.tech>
In-Reply-To: <20261106-k3-ddr-v1-0-1e60e1d78020@pigmoral.tech>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>, 
 u-boot-spacemit@groups.io
Cc: Tom Rini <trini@konsulko.com>, Yixun Lan <dlan@kernel.org>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, E Shattow <e@freeshell.de>, 
 Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1820;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=66rzmi/a7Yuwg/1K43R/+wWyHjVbLThJmdvps5ZADR8=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLLebLw4vfjgv7LXmdM3ZXdc1jjqsDpjef3NmsapOzuiL
 qx2TQ473VHKwiDGxSArpsjC5S/+z1qH59sRgdb7MHNYmUCGMHBxCsBE1OMZ/uft2Rv14Wn/yaVf
 JOau2OYYcS7HZ9aTDaf3Be10zj4ys0SW4X9NmMCfts3HOl+7O76rtot7tLR0V49bUjmfE+fbEy2
 T/RkB
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document how to obtain the DDR firmware required to generate
spl/u-boot-spl-mkimage.bin.

Also switch the OpenSBI repository URL to upstream, which now includes
K3 support.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 doc/board/spacemit/spacemit-pico-itx.rst | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/doc/board/spacemit/spacemit-pico-itx.rst b/doc/board/spacemit/spacemit-pico-itx.rst
index 18d11d6671b..8b3bf4d202c 100644
--- a/doc/board/spacemit/spacemit-pico-itx.rst
+++ b/doc/board/spacemit/spacemit-pico-itx.rst
@@ -19,8 +19,8 @@ Tree blob. OpenSBI may be first built as below:
 
    .. code-block:: console
 
-      # Clone OpenSBI fork sources with K3 specific patches
-      git clone https://github.com/spacemit-com/opensbi-upstream opensbi
+      # Clone OpenSBI
+      git clone https://github.com/riscv-software-src/opensbi.git opensbi
       cd opensbi
       make PLATFORM=generic
 
@@ -29,14 +29,18 @@ Tree blob. OpenSBI may be first built as below:
    .. code-block:: console
 
       cd <U-Boot-dir>
+
+      # Download DDR firmware
+      wget https://github.com/spacemit-com/spacemit-firmware/raw/refs/heads/master/k3/k3-br-v1.0.10/lpddr5_imem.bin
+
       make spacemit_k3_defconfig
       make OPENSBI=<OpenSBI-dir>/build/platform/generic/firmware/fw_dynamic.bin
 
-This will generate u-boot.itb
+This will generate spl/u-boot-spl-mkimage.bin and u-boot.itb
 
 Testing
 ~~~~~~~
-Currently there is no U-Boot SPL build target. It is required to use 'FSBL.bin' vendor
+Currently there is no full U-Boot SPL support. It is required to use 'FSBL.bin' vendor
 board support package SPL for DDR initialization and testing u-boot.itb. Please test with
 fastboot command via USB download.
 

-- 
2.56.0

