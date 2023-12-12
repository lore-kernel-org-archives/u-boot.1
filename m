Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3C3C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 08:53:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAD5C877D6;
	Tue, 12 Dec 2023 09:53:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="YDoQ36v2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2AFF877D6; Tue, 12 Dec 2023 09:53:11 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3EC48078B
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 09:53:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VK+rwPShahCr7C89vEJ5173MWdUjt+Ot09tOYJcCqRJ98p5LS+aPqHXBgxhJ4Zjp/LCGPzeolIRqKxJtXbGGz7dSvZrD5/CqPx5nSpijT625KcpeVOcBZft2949IeYHEYgzTxRGpKb+N/fUUpvmS03rRidSJ7y3X8quUdPGqj36UovoGUUDPJexoEzlshWP/G3vGX4hNDtb+H77eFMxg79or9fg/6m9nwN+FyRP2gr1bQF1ax0IoVzRgzXUTWPTtCOx8UXMdPC47zHiheGqkyijlxi1GIeC18SH244G9cOXIB98zT7VC/w4ov2ccXysdu8khkQZaEc9kXg2X/eilIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmVm+ui/fpd1+t2CyawAKrsX5E6a38Hw/nkKflmCzZU=;
 b=Nsfuel5eUHItxFPiZ5oDbC2TE5h/cSbv1tu5TOWnNP39fDFbMcFOXN1qTvv+e9T3E8ebArzBt0WmBp2Y5Y9myvO5F08znZaHpjNRfgV8+IFZpTIPX1zXIBtXETnAiGtGAcYSsM2dpwa6bMwEZSLlBYE2SAnBx1ZzxAyGWaHmfet94AcLJ5duE5vq7eTTobIGn9YTnIc2XScY0Rt+0dXIj9d5pNGEXl4R8Zrq/L/wYcNbfJantMCJG6cV8VYFhY0xpITlkTRpDvJBKDx8dIr9h5QnTe3wuaQjB0GdUJV2t/k9Yr5NiK1cjezHEGj2r+hqEXk1cqEIW5Aags2u+DGqcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmVm+ui/fpd1+t2CyawAKrsX5E6a38Hw/nkKflmCzZU=;
 b=YDoQ36v2/AfVhQZBX2TYLq/bd+JfpYuFOSUsIZ7juO6XirNkPMuGM2TCBl9HpQTHHF8+kYyDci4s6dhDOFi9mkB601RQ6Oo8MZErHQ4AbYbZG0Cc72NoTV4IZqkO+PTqcr7EFVpm5Y0rqjB2NP4CBQS7XARrWAbLE1+Kfu2CvcM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AM9PR08MB5940.eurprd08.prod.outlook.com (2603:10a6:20b:281::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 08:53:07 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6%5]) with mapi id 15.20.7025.022; Tue, 12 Dec 2023
 08:53:07 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>
Subject: [PATCH v2 1/6] sandbox: add generic find_next_zero_bit implementation
Date: Tue, 12 Dec 2023 09:52:31 +0100
Message-Id: <20231212085236.2730768-2-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231212085236.2730768-1-lukas.funke-oss@weidmueller.com>
References: <20231212085236.2730768-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0211.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::6) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AM9PR08MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a829d5-3a24-45cc-4f7b-08dbfaefc2ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3/LXePAz107wsvOEhBGlV1xJtY064apZtGAhEhOITnv5IS301vsLqnNw1CjvQkC4fvtVvl9K6la/sWbodSJt0pmozQTzAcYjctZSRE+HzPU4Yq7hUExMhI0EENRX87OlrLZgCgrjQyptxiPar6BflOOCy5hux5S5d88qz5Doxjko2sUxubo+UTeTk1/q+euk4XFaT6F7XEkDU4QgmgD3MvpH5hhLcLy7w4KxPqN1AEl0pzsHeWkvNGxOYHJF9vJ8lUAlfj7amh8bnRrGI/tH17smzeTfaT0WelaVBEEqpH7jPVtqomVhP7ruE0n2HPOeLVhwcUhO65suRKeoKJvs72W58dzZqFRos/zTQRmuL4o2FVIeG5ZThKK1tW99kjGUiwvfIaZN1hFmdDMAusdIJ7V10Bzk9PBUF6FgC2A79nbQsZDoOwioovdCpVkEiaFAB0jj9j7B3XOb4R2Zw3NW2XVdZBTxfMOBhgbUrXozR6TmIHDeZHwlvPFmNloC1Mbo7PS4Oby/dVuO89h4fFm3LMDXXwz9rCuxjnI+0vSde2yPi3ZhoF8JzBYN844LLxsa5Y8xFDJcpg35v73ttoMaUBL+G2asx2pvpz5IiRNVoTHFU5J084DYbPmfovz74kX0ddCQiaite7hQb+HhTxuuBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(107886003)(83380400001)(52116002)(6506007)(6512007)(2616005)(1076003)(9686003)(5660300002)(4326008)(8676002)(41300700001)(6486002)(2906002)(6666004)(8936002)(316002)(478600001)(6916009)(66476007)(66556008)(66946007)(38100700002)(36756003)(86362001)(54906003)(38350700005)(41533002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+UN/AVvbUpYYWn9SRE3690YTXLmv6CfTgRgb6voCUzWm7embutRAauh40KZv?=
 =?us-ascii?Q?pv/lRXzhu3NNbOdqEBrT9hQGgK0nF7iDhfzBYJKfPRHwJhhMubcjy00TfivF?=
 =?us-ascii?Q?TiUY8IfRZKnYK76IDSXt4MNZNO6Alc3nydoEzgMzsvMFYn5se9Vdgfy/LemC?=
 =?us-ascii?Q?7JCBstppPkEZfA+0jcQAhWqXNL/2Ffw+n7mBIceL2SYTX5cCUo5hEcZx3Ign?=
 =?us-ascii?Q?NC2hy/I7/WlSAUJd7Fyl4as6jSx5KB13t2UbJj/jVUljCpXESHtMYCBJz5jm?=
 =?us-ascii?Q?RF/MbNpHvCGV97py35fBJI2dKzDDIVTsWYPoyjA+oWH9XsxYGArMocclub33?=
 =?us-ascii?Q?o9CxQzo9X00Z2UPIez0bRWhMtLzfVWpJdl53aGzYiS4b2eOIMnL7X4jYDNRa?=
 =?us-ascii?Q?sN11ECvhzA4HBHtlD82eDodh8oz+2ic1dgDJcn7lU92apUw25HCS4mii7RJK?=
 =?us-ascii?Q?W+bE4PBVaKozeL32Z++S5I60gtAkOMfkF+QK8wdIWwZgMnWtf8ggWdTJm0au?=
 =?us-ascii?Q?myAQeMB2q0mVbvtP46oqcGFa6sbpLoz8AVyBWf+HOsjpqdQ2j2BZua+rol8O?=
 =?us-ascii?Q?T3hWmlPkM4cKepOl89CFxU+bjn6TMN4SlIalxMJ65BN+x6rMVtDD6husnhrU?=
 =?us-ascii?Q?Yf8weLMji08tMi/T5vTuge+q0FEHtzql7b3MAVVD3KAa1iLmfLNBsOxp/l/T?=
 =?us-ascii?Q?eV1exGM16DyY7scMa0ScJrkCXICix/2bGqcnUgIG2HfwcjD9p0BOfj+/wnQy?=
 =?us-ascii?Q?NvPOfUP08VYT8NLow0hwMvSMx0shvd5hvzaIIGOCexMTJSfVVRHR8NJJe+Y9?=
 =?us-ascii?Q?WR5kQi/upIQkFia1j/JDauW5DbCU1tF6KWPnQwYkPkVwkQktR7fcO+NmQwjq?=
 =?us-ascii?Q?F9c6WKa2Jyjgm6dUClas2tLy+/mwa7QbHFvmrNIMbkI/Yd/2DfG8dYIVtukr?=
 =?us-ascii?Q?Cze3HYkoIRjhLce+UaWgekmbf05evaydTXexMK0QY5LnaIW/N035Rvr57UD1?=
 =?us-ascii?Q?x4dUea0OCjbF8n5xUatTGCSe74Q4McCjvjYC7em8WQTb2E/qtLzvh7eQTsmt?=
 =?us-ascii?Q?iK2JP7lN5tqo4KtXO3+NgQyfhFy31rqQ6h7FWYL+6pT2FDUiU7NwVCUU1lAC?=
 =?us-ascii?Q?rRiYScgwLvseF06pCRTJCo093SyKHEXYHDqdrmJ5e3Y3j9lCh5qTaXEkYV4G?=
 =?us-ascii?Q?UZVGRDMTxool+kbl4m5UkFI4pWIjN4oxh8VoRMtQUptjqkJpxZYHAdewbNjS?=
 =?us-ascii?Q?RNFKuW3jD87Q5W5BAK2Qkp2cetRkaVkeL4+9A9jqvWK1zjViUPh2EpaLUkwN?=
 =?us-ascii?Q?fBiTXkrxo9QxEMeCkCPc2JgCXArz6B/leYyUTjIXszuhWKAezeP6atQ9V45T?=
 =?us-ascii?Q?qSdnfD8xiY7CYkQMvCkDnIXEYleCBKWnGWoC6cceJtvqROXBt+soI5a2BD3l?=
 =?us-ascii?Q?78ATRmAFAR9Au/ahi2GX0CdOa6nX6tTnTL6f/EBq+OTzek1u7HwNfxIPoV3q?=
 =?us-ascii?Q?4IgM+4hgxodHsh1J5dyEbpQh/PLYFJsEnR/E0CsvsTSehTQL3WDGyMxnF2QK?=
 =?us-ascii?Q?OglwJibIABolU02+ilPNezhik8ITYgCwCfsHtZ081GpZp1iZtXQIHI7Yrq4z?=
 =?us-ascii?Q?oQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a829d5-3a24-45cc-4f7b-08dbfaefc2ec
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 08:53:07.8731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3YvG5BD/yP150YD37vXJDAsrBEaRCyCsUYGvOed/zHQcotGngRSnfcojv8o6JbegAwJf7XchH8LGRTFaiX6f8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5940
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

From: Lukas Funke <lukas.funke@weidmueller.com>

Add generic 'find_next_zero_bit' implementation in order to enable the
use of the 'for_each_set_bitrange' macro. The implementation is currently
missing for the sandbox-arch and using the function results in a linker
error.

There are more efficient implementations in the architecture specific
implementations. However, for the sandbox the implementation should be
simple and portable.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

(no changes since v1)

 arch/sandbox/include/asm/bitops.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/sandbox/include/asm/bitops.h b/arch/sandbox/include/asm/bitops.h
index f27d5e98c5..453ff005d2 100644
--- a/arch/sandbox/include/asm/bitops.h
+++ b/arch/sandbox/include/asm/bitops.h
@@ -104,8 +104,20 @@ static inline int __test_and_change_bit(int nr, void *addr)
 	return (old & mask) != 0;
 }
 
-extern int find_first_zero_bit(void *addr, unsigned size);
-extern int find_next_zero_bit(void *addr, int size, int offset);
+#define find_first_zero_bit(addr, size) \
+	find_next_zero_bit((addr), (size), 0)
+
+static inline int find_next_zero_bit(const unsigned long *addr, int size,
+				     int offset) {
+	unsigned long *p = ((unsigned long *)addr) + (offset >> 5);
+
+	while ((~(*p) & 0x1 << offset) == 0x0ll && (offset < size)) {
+		offset++;
+		p = ((unsigned long *)addr) + (offset >> 5);
+	}
+
+	return offset;
+}
 
 /*
  * This routine doesn't need to be atomic.
-- 
2.30.2

