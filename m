Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C37DC98307
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 16:50:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C497380E4A;
	Tue, 22 Sep 2026 16:50:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dxFRtMUloMEq; Tue, 22 Sep 2026 16:50:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 067EE80E7D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790095804;
	b=mtrz6Rypf/Et60wl5POLpUaj8GaNf4dR/aPQylLVy/E5NbzhjWsP5p3kSr/E6GZ0oYSi
	 gozu4ZCOmRrKT/Kw9e8IYCcsjt69qEXSd2iUxWJ9CY7QiyMA/gkowqEIxWoaka44Jv+G2
	 jEIxsSe7Og2Z/vRzkGeVBF4d15t0AN3aptgD6gADciLCsmydpFRJ1x4SwPG+h1zYEcTqd
	 +m+68963gbF8xcb1kt29g17mOWmI7WPvKZjm0BZesMLj559APFyZYvkQMATmhsFSdik5L
	 PNshjxHqlwf+R1yMU5s3cLdC5gJx0JIV1q6ilGDj6Eu+O+wQ8eQeQwDlvGnrFkU1T3w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790095804;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Jj8GPcgKGbo+/u95NAkT3CSduXi4fXZLPntwcCxcppc=;
	b=BPhRA62fEZ/mDxlZanVMpMnMkW8swlAD+YQHyGMfDsC8sVK42aYQqD+U37rSFzocCsjG
	 +JO7VIK+DMuzXZnqOUDTeqwNI8SISJEOKK4h8NwYVgM7/tLBBjyf6+lbo3nZe1fKLEwUH
	 dr2/CdDDJhEE0CRgNasIuvGH5DySVsCwWpKGPwsvOraEZHUemZd/WJGlZTGb4qCitppXh
	 cYAjmkwVlBiS6c52JcNCR+BtG9qDyImv8q/WcM/eoEvJKW4jGt7wcLclbPqswoIl6iWw3
	 VostiBlIKplBIpZuzH8OwzyT/nr1FryLzLizKhKiXbUTN8yIGgUgBtyhE2itrVtY2rA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=WOQFlpGy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790095804;
	bh=Jj8GPcgKGbo+/u95NAkT3CSduXi4fXZLPntwcCxcppc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SHOLo1Gg5gUpVAVa14azT0O2v6sOMS6nffqGKd74fV19Puc+UGbkUXtG2PakaR4S+
	 nuXlD75e2PcNdgqnssqaxROlRG7lKPvNnJBcfPWyZ2if6nHSB+mXJteZ5T/THMkBwZ
	 UWxNi/K6sTMbz94hjFhpY6VF111gp2dfxOYLzoiMFiZVKMQrUOSZBG3rNEPundYOqF
	 wRN9WNAxjnDYheuUpDlO5DfMlqWfY+yVbYMO15SS1M1jsHVyZFYy/81rMK8Kub6/+i
	 YmIMOUFl9Z/i44fga8ERBgNU4RsKjWi/4OboSna6JijrV6r0TU5Cz4EU+G8/t+76ey
	 IcGK4DwITDbYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 067EE80E7D;
	Tue, 22 Sep 2026 16:50:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 734393A9
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 16:14:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 589CB80BE5
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 16:14:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8IEUR-QIuElD for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 16:14:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7FED580BD4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790093647;
 b=Hg/HD+d6TDEc9Jvkozy2QAS2lVwsqxOjydNsH8tjvahjhmgqA1VRSq9W10YKe3XEi+mm
 ATjeBabocCrgFbJbTbU5BowN5GAWr/N1uIYF68b3Xu5lhllF1SS1SpKmOrEIwCBu27WdK
 aUw5bFgBnFrDVLCWqYo6MwekClX30zcQeG2p+boHtshcHLCyst6n1wUVXdQtyDSnTRSsY
 yqAxel3ZKV2DRbr2ngRDfPYD6OobrqEHEwcJNunpXxDK3x/lzKeVFIxhnU1/bZXVxdokh
 SYPnjR1Mb361kl3AUGZerwceN9klrwG4kgLQHfajxdDHXL2AAnUWJpWhmUPjvoRMKKw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790093647;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=Jj8GPcgKGbo+/u95NAkT3CSduXi4fXZLPntwcCxcppc=;
 b=MoSuXJs1MkMmW1VAvFUnA2aIr2TXboc1NQZV3xBu9vqBCQpihgjyKWTuQX6K8Xhy0Jo8
 W6pzxL/TAnwUQrDdUiRuJYCxVh1wMB5Hic3lbpbjzyE/TtMxDgAaY+eGL2SALAN4gm0+1
 QqbXzvcgCM/4CjMXMFH5zF56bqCDz3FMgdMujwmfvJB1lpfCzSYWhepkxV17hrWUg4wwm
 BQzngUTKXzdd03AxvDk5eqNZuTFZjr99v3+j9rJgaY1NXJXb1OLEipsv+HPM28c9JZ/Yg
 OiLdzDoOUW7P2nlSRW4OPvfqLJfWoUJ1c06FaDxJz1vmau9Sod7F2c06YkdQtO5hseA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=WOQFlpGy; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.95;
 helo=sender5-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=WOQFlpGy
Received: from sender5-pp-o95.zoho.com (sender5-pp-o95.zoho.com
 [165.173.182.95])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7FED580BD4
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 16:14:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790093593; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lJWZwXAtFRtTgzepM9AzzN+i/j/1pU9u874ExML2dnJ7KIVFcWze4uESNfEDUUAdKRpmz0Yx1p9TR/WQs+zWGZleQbtLTXmUX3ojkNJ8o5bJ6gDh6By8lXFr1HYQGEUbwQVEYEFxSJzPktKFINLCteTRoKQGjfSKno4QEWSMZ1g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790093593;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Jj8GPcgKGbo+/u95NAkT3CSduXi4fXZLPntwcCxcppc=; 
 b=P9khklNO3HKoHl26IG77WejqUA8Tq1AOLm8Cl/3pVen3mvUWAAZ+dsBDhq7Dji3tfaySUU2ui+O8kv6FPucxnkl10eIFQtaYrGfvSAN17SsZj1niMJrvAk8fEbJtgGFw6qO+DTPy/ZXvhfmkz6/8jn2Xlg47ylmMvrP2SoZlO7A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790093593; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=Jj8GPcgKGbo+/u95NAkT3CSduXi4fXZLPntwcCxcppc=;
 b=WOQFlpGyrEUlNu+QlXyToqysWtmkenEonf+QnMVNvUjatX3gt6mcL3l4LQihckb4
 MJmfdFOVJqUzSfVkF68LAw8cQnhE7N8XMufilk2qNFBNxbDnL5ZI6T7BjyWKBT/j38b
 JSd7/Sp2pO624L/NSrTxHV740/Ih67sSRxN4PcSQ=
Received: by smtp.zohomail.com with SMTPS id 1790093591852842.3324098365363;
 Tue, 22 Sep 2026 09:13:11 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Tue, 22 Sep 2026 23:46:22 +0800
Subject: [PATCH v4 07/11] riscv: licheerv_nano: Use upstream devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-milkv-duo-upstream-dts-v4-7-d45b74dfad36@zohomail.com>
References: <20260922-milkv-duo-upstream-dts-v4-0-d45b74dfad36@zohomail.com>
In-Reply-To: <20260922-milkv-duo-upstream-dts-v4-0-d45b74dfad36@zohomail.com>
To: u-boot@lists.u-boot-project.org, Chao Wei <chao.wei@sophgo.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Yao Zi <me@ziyao.cc>
Cc: Zhuxu Ran <zhuxu_ran@zohomail.com>, Lukasz Majewski <lukma@denx.de>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Hiago De Franco <hfranco@baylibre.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Inochi Amaoto <inochiama@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Chen-Yu Yeh <chenyou910331@gmail.com>, Chen Wang <chen.wang@linux.dev>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Leo Liang <leo.liang@sifive.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Alexander Koch <akoch@initse.com>, Andreas Schwab <schwab@suse.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Marek Vasut <marex@nabladev.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: b4 0.15.2
Feedback-ID: zu080112272e756187caf038fee1f3fa9100008e6ea962dbc06f43279e50c91891047f7e8a3d83cde266ea4b:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Tue, 22 Sep 2026 16:50:01 +0000
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

Switch LicheeRV Nano to the upstream SG2002 devicetree by enabling
CONFIG_OF_UPSTREAM and selecting sophgo/sg2002-licheerv-nano-b.

The SG2002 clock and MMC compatible strings used by the upstream
devicetree are now supported by the existing U-Boot drivers.

Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
 configs/sipeed_licheerv_nano_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/sipeed_licheerv_nano_defconfig b/configs/sipeed_licheerv_nano_defconfig
index 9aa3ede10c5..21b8fece201 100644
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
