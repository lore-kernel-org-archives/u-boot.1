Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B50FD2D65
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 12:20:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED24B83F2A;
	Tue, 10 Mar 2026 13:20:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=digi.com header.i=@digi.com header.b="gGX+7RK0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5744D83FC0; Tue, 10 Mar 2026 13:20:50 +0100 (CET)
Received: from outbound-ip173b.ess.barracuda.com
 (outbound-ip173b.ess.barracuda.com [209.222.82.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A97383981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 13:20:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Javier.Viguera@digi.com
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11023137.outbound.protection.outlook.com
 [40.107.201.137]) by mx-outbound22-42.us-east-2b.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 10 Mar 2026 12:20:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObVBSRIE+wTJGXrJnz9bxD4uawMKQwGgN4nhufuycey5c8HHwSC0J1X8Sa+cIbMxalDkvTPAoLihaQW6JNlOLzJap296qjY9GiY4JWgOIN2l2E1ZXhISLMvC4xmedvN8nK/7+kadMrfoMpD03zxeSFDMDxi+HKryIR4X1vtBpwP1PU8AQEDSxw5ap23RQ8rYW+0ncqwDh/d1NQWM0VRUUxU1dQUbhGNwB872k5cGjA6ahQ+sDxhZ8sA6oIwdvpK7nOFZqgYn8/xWOcAqgTHY+23ypcXbGXiwG1cDOIoJYn+s5YpKqAEcpFpohpW8xVC83gVGgKtqXuAdCFKBJGqEIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgTSIAUGNKJiF8O/GXm1IFsE8PZ1q6P/crIQQ4Snoqg=;
 b=wgLrSzBmOjiNd3Fck4qVsv5NqLybIp+FNbi8T1XU5kAoACR6dZ1LgPDEZbQVms91wjc74/oR7Hm3PBtKd1kqGyWp1IHWDfjCXRJG+K99m/4MS2Yt/MKRRYWwPAPgNCtlgsqDMDcW2LP0+EYufhzKLI3Q0SJcp4e1VAaZJxYN0YK/uli9LLUn0XiLXnwqzodqyR/T/tOQWzCrFGSmWAWW8TZTPVahU63AO6kDvOtCEkuh3GmhbustCTHarq0pqBZRamP51bmhxeS3oZ2cujchV9GpltYQV1RKPrnNIr9A2kYynkV2wfBWzrtXlAPCfCUZK3YLryZKXzolcwqsv5A2UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgTSIAUGNKJiF8O/GXm1IFsE8PZ1q6P/crIQQ4Snoqg=;
 b=gGX+7RK01PuBMbQEKL1P4kOg8Q5kPeuOk7soyLRnjs6/EBoiFdSRxZnQVZ3whZCO5y2cW5uKNioHKw4TJdpD5lok6lccRtV13icBlzQqWQa1P/0OKYmzxTvzY1HM7S1W57usJACok3kvkI27h25OE+YjavcOh8FTL1pbmkOCXLqePi7e+X0Pb1R0nHb1ZcYLzYIAlMmpUCwl4Q4gWs8YMSZFHPyCzCjgr+kVyEdt0M2ganmC4nMO6S5vd5J3PxcznT1C3MJt4nepam4uC8pIzaAfHfSd0deo92GnpxCsoRU9WJ74C9xqhwcpelVE/RzxI0E5i0jUd296n8JRqdrMzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from BLAPR10MB5156.namprd10.prod.outlook.com (2603:10b6:208:321::24)
 by PH7PR10MB5724.namprd10.prod.outlook.com (2603:10b6:510:125::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 12:20:42 +0000
Received: from BLAPR10MB5156.namprd10.prod.outlook.com
 ([fe80::228a:7b4f:3287:f13d]) by BLAPR10MB5156.namprd10.prod.outlook.com
 ([fe80::228a:7b4f:3287:f13d%6]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 12:20:41 +0000
From: Javier Viguera <javier.viguera@digi.com>
To: trini@konsulko.com,
	u-boot@lists.denx.de
Subject: [PATCH] rtc: rv3028: fix PORF flag not being cleared
Date: Tue, 10 Mar 2026 13:20:07 +0100
Message-ID: <20260310122033.2037427-1-javier.viguera@digi.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR16CA0023.namprd16.prod.outlook.com
 (2603:10b6:610:50::33) To BLAPR10MB5156.namprd10.prod.outlook.com
 (2603:10b6:208:321::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5156:EE_|PH7PR10MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: bc3d85c4-6fdc-4074-0270-08de7e9f7226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: LHqwUB32qnVqJ5XbcTQMVkZndUZb9FlPmD4NdIdR1eNMBo4yfAnEg7xzNkj6hN4gVxcVk+ZDoBujUnuzk1LqbF4zPbJJ5Uru8vS7lByUu4Umv1rOIiUOrlr3qOGCsVvNfuUv6yfDbhDlLcWev2BltGkU7kKp+vs+FVql6JdCjNjcFHjkvBHPx9jKTYT623sD5aWZZwjwX5bg474YyRIu1dWdO4I73eUKk09bQJ4xQ3Qq/bvtjFLrEM4L0wOmfcxZUuYZni5ZpcdE6fwPVH6T3wH2r+usSEZ9B1x+YwpyhVMIxA6mk/LBojJNwrLKHbpIVpK//UObL7OG0uBWzG0K8y8DD+1/jVEXPpvJpPLaBXxsPYsxqqi5Hi10SyTUKC6vs7sDn7VsizFTFR3Ym0jET+i761M6/F+W8TkyV7Vw7jK/hVhSJMNEBIKiRZAnqoCtnVA9jRD8/Q5oRe7ey2+dHGa/fwHakCRDwQ7QBPdFBfJQGiSx7cDpFZLdzMj47CgvH9Z06xkRU/EQUX5KDuo0VnDVSQMQRHs0U3+QM6hzO/88s8uRnaTgiUHd44g0Cs6kpbWNGDmfbYBsRy9Rtw7KRyJlf7cOwNegSgfqkaLnNOp1k8is75KxAM6Wkz7TdavafGlsBg/3qAs7qtrFb1bdVscxpKvUYMMQkaePlfZPirgm7JO689eqURxDKUQHvhU35mELCLnhLjLcV37hNNirvhnR+4fXWlnO+PzURo5oVFvLy7jLjhMcwJWfY7cB5CHa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5156.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+5iBWysBwdV/zaI5eY1UgkoMkDAPL3cHNTYZxeX2iXr3pCQDJszbbh6MBEbe?=
 =?us-ascii?Q?YOHnaulnJz+5/6IIN/TG06QlxMpsIcAQ1CEivGTkyXIoRCGbVSUrKCy1rZm9?=
 =?us-ascii?Q?zWJ9q3xFVQkVhtx2cv6C2YeZRYcV/eMgxmUq8O1NA6XN7KFt3WiDp/dYo7b6?=
 =?us-ascii?Q?CQuIOIgfJSdV7bOuomMcErzVRn0LAYhjW3jXADmJPMGE6ChXsKh70VnO5//j?=
 =?us-ascii?Q?WBxox4OQA/kaRbWCvHtpwLoP1Vn7Enmnt3tVEMPFfNOTKltBrBwDM3WS13SZ?=
 =?us-ascii?Q?ib8DpZu0FAGXgpMRzjGi+e6sM0iPGcqOnXQQBp7q5pm8Z4u7xL5OuQAlHhyx?=
 =?us-ascii?Q?9e5hULag119IRc3smaI1+TQh6O5aJhxzNENteqNeLJuScMC8Ay+ZWt2z/09E?=
 =?us-ascii?Q?gXl5qD3LHUTf151oI/8DIsYdxWObVSSNWqBynnfp66TLLIknTMXkk27jfRAH?=
 =?us-ascii?Q?GtAD0TPFUkaeZ0BX4IQ969TITR7MqHx7oNEkxSh+6KW/5jpG5Tqg9+v4Nhbd?=
 =?us-ascii?Q?P9xsu7fHxZz64R9A0kqSF774QYviVEsojCPVwodrZKbgOueGnmX2cPlyU41X?=
 =?us-ascii?Q?BoMJKE734N7ipKBJkvtfFV15PfZmlbGwo/67X8WpXYbJ18F5LlprDIYXr/Ri?=
 =?us-ascii?Q?AmXeB1ECjhhgtwL8fGctTywKp0DsfxSvdphVd8188XIQrf03y5cArhWMe3Pz?=
 =?us-ascii?Q?pwMAOpgQFo3pgaQe3my2EvSiBPF5MvY9UTfeqej3nQrJIsA/JYuUejKnR4L/?=
 =?us-ascii?Q?MJGyBBHyFONocvPN6obgMOeZO/kuk1h2/oiQm8qBoKV0uVgEtLLCYIFZC10c?=
 =?us-ascii?Q?NYeRT+QWXZQGYlaz+7tQyVB8ysmLjnrSyvKYjmFGIjlCkklco5lwyNjb5zgB?=
 =?us-ascii?Q?3sykANWXer1Irs9lZTkDwPKqmy/ezp16MBcXJNPpvntR7Qp1dcHt3EEi22lz?=
 =?us-ascii?Q?sWsp26Ng+FStfKpgOnYAd+DOW1Le4wptXT7oWsaiADgtwruGBlWfYnyREXo6?=
 =?us-ascii?Q?uSUWFEryJxMUKbnY5RRVGLxzcX4/7l1NyFWh3sDpCSDsJN53EnBoT9TdVC6i?=
 =?us-ascii?Q?OG38Mj0zhXbI4oHQnr928PuDaSwtwebJTYk9ddd+3p++nRQNhyp8ZlDJxzAG?=
 =?us-ascii?Q?8CLvbPOx4TwAK9MDdZaJa0VexdPHhQ/eCVOvdWwiHciNe1Q5OUIawveixG7d?=
 =?us-ascii?Q?FXXMQz/eb5kKRpqJHsWgmLg6Gr3l8V6GmVwg9NsE/HvmXLMjoMUFmuOMK4/i?=
 =?us-ascii?Q?urJeoLf548Yn9QqOmKeqibQdVsBI2+b50IPIpREvN5klISP638Te4+Gbisgz?=
 =?us-ascii?Q?IQ1JWXzZeVJ9oLXZHb17gw9jdPq851CxlgTtcBL/F72AyGSKMhfxZG4pu5Yd?=
 =?us-ascii?Q?nLUNa3w82FVco3/FXj99Ppwf8b22s2q82OwSlZmCQPynq6jjhXd/fPg8MCZW?=
 =?us-ascii?Q?THGF8HX1ui2tWwnJT+H2lnzpVfZTpVFjd58DTSK/Y+ZbwnO6h3lI8PazB4Jd?=
 =?us-ascii?Q?Jk+38aXpdvtSEOEiQNQz6U0Dus3+Jqi5lUyghIsSsMDVVpvZxU3DPN0w5AUa?=
 =?us-ascii?Q?r64VlAEULyoZlfkKY1jgFpsk54nojLK/wxN0y8469gmbuv+L77Q2Gx5aIYLj?=
 =?us-ascii?Q?heDHsyVdnXbDhbVwXDn0w5PEyYeOC9NBElyWLuW1T7Q1v/564Eun/nduG3s2?=
 =?us-ascii?Q?Hh50D88kJcqyglh4zz0rJg2RpubH2jVtHL6hP7abF0t7Sz8+ezT1XU4870mF?=
 =?us-ascii?Q?4sZQ3W6M0w=3D=3D?=
X-Exchange-RoutingPolicyChecked: hu02XxBTnDFYK6gqWL58C10rnt5As7KBmwQzgi8CH4ifAn5xL4DZ6hNoM8MtW9opx7WBIavbLcCPuArL1hNOBxWhu1zy6c9tdRg4D1sLGn2uUgqZ7xXnrxxIugIcCV5wucULBuV65kgOmn6tn3XhtW0RMBVNkBBMKDbGwGYB5X6jP8qVdr396wxHYJFCXi3UHpAcL0WdstswvXFi8UVEIVHLCgiBUiKjIhK4/Yex5YBwhIQ2qnuskn7di3XNGxO6ZI1RfR5Zrz4SX0sQJ1HtCHP9Lk2+Vs2qPTOMt5/Xm16uIk6wqQSWnnYwD4wuIgg2+VfOXh3NthfTNk2Um8Bodg==
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3d85c4-6fdc-4074-0270-08de7e9f7226
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5156.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 12:20:41.9193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lpkJgARZNi/pVYe7ExGABEKfF3TDmYZkNu1yFDVbFUCRP3DivUSZrd6CqhE39HP+KH66b1CMMmFYFi+6FEsctg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5724
X-BESS-ID: 1773145244-105674-7681-1721-1
X-BESS-VER: 2019.1_20260224.2149
X-BESS-Apparent-Source-IP: 40.107.201.137
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZGlsZAVgZQ0MTEzNTC1Dgxzd
 jExCjRMCU5xcTQwNTUwsjEzMDU0shAqTYWAIYzhx5BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.271705 [from 
 cloudscan13-54.us-east-2a.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
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

The current code sets RV3028_STATUS_PORF instead of clearing it, so the
flag remains asserted. Use dm_i2c_reg_clrset() to clear the bit.

Signed-off-by: Javier Viguera <javier.viguera@digi.com>
---
 drivers/rtc/rv3028.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

Based on Linux driver:
https://elixir.bootlin.com/linux/v6.19.6/source/drivers/rtc/rtc-rv3028.c#L338

diff --git a/drivers/rtc/rv3028.c b/drivers/rtc/rv3028.c
index b14d2a246ffc..4e05ef8de2a2 100644
--- a/drivers/rtc/rv3028.c
+++ b/drivers/rtc/rv3028.c
@@ -130,7 +130,6 @@ static int rv3028_rtc_get(struct udevice *dev, struct rtc_time *tm)
 static int rv3028_rtc_set(struct udevice *dev, const struct rtc_time *tm)
 {
 	u8 regs[RTC_RV3028_LEN];
-	u8 status;
 	int ret;
 
 	debug("%s: %4d-%02d-%02d (wday=%d( %2d:%02d:%02d\n",
@@ -157,13 +156,7 @@ static int rv3028_rtc_set(struct udevice *dev, const struct rtc_time *tm)
 		return ret;
 	}
 
-	ret = dm_i2c_read(dev, RV3028_STATUS, &status, 1);
-	if (ret < 0) {
-		printf("%s: error reading RTC status: %x\n", __func__, ret);
-		return -EIO;
-	}
-	status |= RV3028_STATUS_PORF;
-	return dm_i2c_write(dev, RV3028_STATUS, &status, 1);
+	return dm_i2c_reg_clrset(dev, RV3028_STATUS, RV3028_STATUS_PORF, 0);
 }
 
 static int rv3028_rtc_reset(struct udevice *dev)
