Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26AAC55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 13:05:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 87BE34074A;
	Thu,  6 Aug 2026 13:05:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mLbOe792Z129; Thu,  6 Aug 2026 13:05:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 072EC40723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786021510;
	bh=XGZniwV3xKvXkdCzVdc6qHml7zql4HoVHEutk1rQ4nc=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=g5ROBk3kQAW0ch5as74A3Qtwh9sr6PrzQfbNBaUQVvSOZHk8TpbfYgcGVDlMi84um
	 QfRvBd6zYAMpi752rAN+tBrCEgH1s/LiXMhsYbBwEz6Bw1wQrAAnLSFUuicTmfbvMd
	 4HDDLNYOnuehLOQ5TPyA6MsPjW20zJqd8gZE4h0iwu5NWwVVHKmkae/HMlOerCc12p
	 aDUhxbiDE3nFN0E0/A6tGDu3TxcxoGZ2a3QaOyYtUwtQVCUKeT4A1u8YCxVWCLWaas
	 7NVAcc2FC958c23NPX574BOIfUbVyg5n4ZLTiWQfpWuxUw6/wHNMOwdB41721XQ3hc
	 Cr47H0gtpq/NA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 072EC40723;
	Thu,  6 Aug 2026 13:05:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 76381194
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:17:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 684FD4058C
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:17:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fHIEfX4PS2I6 for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 12:17:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.94;
 helo=sender4-pp-o94.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 748EE401D2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 748EE401D2
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com
 [136.143.188.94])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 748EE401D2
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:17:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786018455; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZsPSsbm+CahiA/C8r86tcwpQd6MxvWzZOscI/s/mT2htph/GxzrER6LE8pxlAx+XwqhRnX+IBfzrXVFCovYGzYeuuo93YWjFjlPnKFg6KKitqmWMAQ1naDrynlO+DUDpHFZkUZd9WXuS9QFnKw9VkEs2/+yV9LHU+L4BeIUIZZE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786018455;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=XGZniwV3xKvXkdCzVdc6qHml7zql4HoVHEutk1rQ4nc=; 
 b=kv1s8Sj7RyAJ/mJX22Q1X3hYBJOgHVhuHwsjU/2jMb8e7HCUZdFmRONIojqQX426d2cu7ReDZPeRtHiK2sX/NX57/f8ff9JfS1sRvR28FJ1SKXc7uSxP9XI8y6cr6xCSbU5mnpBI1hVYalhC0jr2F1+M/bNfN713S4pucDqbA6E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
Received: by mx.zohomail.com with SMTPS id 1786018452483561.2175552255005;
 Thu, 6 Aug 2026 05:14:12 -0700 (PDT)
Date: Thu, 06 Aug 2026 20:13:25 +0800
Subject: [PATCH v3 5/7] riscv: licheerv_nano: Use upstream devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-milkv-duo-upstream-dts-v3-5-917cf70a2337@zohomail.com>
References: <20260806-milkv-duo-upstream-dts-v3-0-917cf70a2337@zohomail.com>
In-Reply-To: <20260806-milkv-duo-upstream-dts-v3-0-917cf70a2337@zohomail.com>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Guodong Xu <guodong@riscstar.com>, Andreas Schwab <schwab@suse.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.15.2
Feedback-ID: zu0801122702c96729aa3261cbf4210a4d00000543319de6f3c76740517e46a83f59580744ea55b42fbe6f33:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Thu, 06 Aug 2026 13:05:01 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1786018455; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=XGZniwV3xKvXkdCzVdc6qHml7zql4HoVHEutk1rQ4nc=;
 b=F4IBQ2f2otLu8Fr/1mz2tTHKmTwGJFMpviN7Bnb+lnm8IZkcBPMxGPEgrd0RoPRm
 QiwNJwx8fVbEuJkRVaGaXWPF7HlzizF83iflbLsIuULp6+913lGFSZKG90QBPG7wUxr
 dcwDldlhUrWAg5VEPik3UhN/HQwudJ0q1ju/8iUg=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=F4IBQ2f2
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
From: Zhuxu Ran via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Zhuxu Ran <zhuxu_ran@zohomail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Switch LicheeRV Nano to the upstream SG2002 devicetree by enabling
CONFIG_OF_UPSTREAM and selecting sophgo/sg2002-licheerv-nano-b.

The SG2002 clock and MMC compatible strings used by the upstream
devicetree are now supported by the existing U-Boot drivers.

Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
 configs/sipeed_licheerv_nano_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/sipeed_licheerv_nano_defconfig b/configs/sipeed_licheerv_nano_defconfig
index ab29f327d7a..6754f3c0f7c 100644
--- a/configs/sipeed_licheerv_nano_defconfig
+++ b/configs/sipeed_licheerv_nano_defconfig
@@ -4,7 +4,8 @@ CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82300000
-CONFIG_DEFAULT_DEVICE_TREE="sg2002-licheerv-nano-b"
+CONFIG_DEFAULT_DEVICE_TREE="sophgo/sg2002-licheerv-nano-b"
+CONFIG_OF_UPSTREAM=y
 CONFIG_SYS_LOAD_ADDR=0x80080000
 CONFIG_IDENT_STRING="licheerv_nano"
 CONFIG_TARGET_LICHEERV_NANO=y

-- 
2.55.0

