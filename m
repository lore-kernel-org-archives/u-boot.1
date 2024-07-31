Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A755C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 04:14:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB53C871C7;
	Wed, 31 Jul 2024 06:14:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="w8MHgK2C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58ADE87903; Wed, 31 Jul 2024 06:14:45 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15DB58692C
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 06:14:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ViKWluV9LG82dhg199V4DUAlOd+DcfQ1LKzfGKZzCD4EXotwvMVtzoKpH+cerdk6gkK+oTlAjupk143uiIC/EqtR9bL6N1itUmQVL7ahoyLklSenRnwf/Y3WEmA8TLdZYNP22DODUMIKuF1gIuac/W4/8HSlxOWAD9oe5H4jgwxnaKYEcuewTh2AZ94IkX2jvvOM1lyehQ1fvvogu+gdSehckR7tdwlla0y/SXlMuV9+d60V5M7t2ZExh/jtJ984n3sXY944lGa32cBFKadhzDeR/ESmYuyJTBFlkkmbP2+bbjsy90EJKiweytvZypyxKWmlSfqXqSR2zV4/4/9CCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEVK/F7lYBVP7TRnACQe0M1Bq1DIwqb6FoBXo6NbLNY=;
 b=XhogrFR3TrGVC8LYwk9QSpwK3f6p7Z2yC2zpc91zehiTm8lZSg5Tmvsy69uoFi2cOcBDygcL4Fuowe/06IDaGQX2owuArLh/fpwCBMAOkRrdJgEAUWR71q8js3EjeBez7SMJ9No5wGFhfhMsV0NYDldO4CJak062ccn05sBInrdvCpiMZFVn+DwbThOGk18UK7NvQmknoa/ZO/Mxx09d6wUauAElZ2Jpx7MUrn1JREhBJUWh9I7M2xDgUGRT6wyacqR/CmGaHwcl0gDIpCKyqQyRVQQPT71qDw3czypDgYHhcaa0o/ugBI0+LkXFUyuA08PFyvbwjMlJF2DkboK38g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEVK/F7lYBVP7TRnACQe0M1Bq1DIwqb6FoBXo6NbLNY=;
 b=w8MHgK2CtHmHzxYBHMuVh09eeTqLLunqM3yni0V4tRoBiAuSN1GEZoazQ8bX6rtP9IKyHriD86on6PJUebBoTHsj5GlRdV7MG71PS425ZkL98m4KqDRxTjYOMmyx53F0c1fHX273+gNPFkouSnc4dJNKt7CiclTgaB/0uiKb4B+pYAtlnwvvmwCRe3Id5U4/xzMlLs/I+hpppy1stKWQdEokrfIv1/dC9SLqkfJmtrtR0BNkpN/FEDyPsVrc0ylO6R68q7Q2niU4Cs9/oOFAYXoLYXwatgQSP8pNszKeIFUSUhF6gYQs8gbG6QYTmMkMjrg/rQNhjlh8ydSOR9HMeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DB4PR08MB8125.eurprd08.prod.outlook.com (2603:10a6:10:384::19)
 by PAVPR08MB8967.eurprd08.prod.outlook.com (2603:10a6:102:326::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 04:14:41 +0000
Received: from DB4PR08MB8125.eurprd08.prod.outlook.com
 ([fe80::e9de:ca06:dae1:ef2f]) by DB4PR08MB8125.eurprd08.prod.outlook.com
 ([fe80::e9de:ca06:dae1:ef2f%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 04:14:41 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [RESEND PATCH v3] net/tftp: make tftpput working with servers that do
 not use OACK
Date: Wed, 31 Jul 2024 08:14:32 +0400
Message-Id: <20240731041432.3840128-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0632.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::22) To DB4PR08MB8125.eurprd08.prod.outlook.com
 (2603:10a6:10:384::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR08MB8125:EE_|PAVPR08MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: 8334c803-2b37-4a3f-9512-08dcb1174cf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|366016|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E/OH1EbRhvijyE4v9F14253n00RacyISk+am/cdJ0BzT+uQDj7XEQhsoN9Rb?=
 =?us-ascii?Q?jpp3zNneTvUXHeV1sm8qmUqfSTxhvrP1Rhdd5kw1aXd7ltVW0IBic19p4l/n?=
 =?us-ascii?Q?To5gaXC7y9x6wSsEGGQZ7gBPuO6i+wJDRsmI9Ai1cgfXW85GIscx+Qu8HoJH?=
 =?us-ascii?Q?Fn1kGNzTqBwyf1CGGF5s11S59I76SpdDf83vCMuoZYbqSCVGz7JP+R/ldVDL?=
 =?us-ascii?Q?f177IDTxlWbMQtO+0sekDoSR08WXrcjH7BRHXUVGEDLIgzVqy+jbCuSVocOu?=
 =?us-ascii?Q?Kt1ELtSaywID+47wQhBGH7rSWY+aBKPgift9thExrCvLpusClmDJGq18C+4w?=
 =?us-ascii?Q?g7k96kDBA1/RGoYGKvqpxCxFB4plr0CphFN3/JTM5uGRwuWcOZFv3I2a16t3?=
 =?us-ascii?Q?/+GOoUEE0xuFvvUnHTfBXf+RPhBvL9w7Tue4DGeaW5Oog782gN1kfqKhR3l3?=
 =?us-ascii?Q?Pr6q/MhkJdhJpYWbM1CNvk7SJZS4jVOLFgo4KtWClUJrcBCQr7iRX1mUGlhA?=
 =?us-ascii?Q?4WEOssTXae5Hg0bg2VRQ7OPFM2EKECdWwf+NKvw7Q/e3B2sM13AwvWR0iTZL?=
 =?us-ascii?Q?I6Br4DFjgkkOyKekm38MMgueaGKs/73gurzo9ttzSD3ng8VHvvPrB6RIDQ7/?=
 =?us-ascii?Q?VbtZLAR64AEXx45u4nLhPmaLDKQvIhT/XhtXI1NwhC1p1J9DHaFeEnW5wYDH?=
 =?us-ascii?Q?SM/09uDX3yC28aWtpT3/o3PgHgxw3KrWivHq2pKAViziU31zS8l/JR+Bqhkh?=
 =?us-ascii?Q?P6gg4HHId4825grOB/glckiBhB8uIercE47TRpJVuXQ2VVU/YZPmcXiTZCaA?=
 =?us-ascii?Q?oRiwr0v4O3KC+mPi/XwRc8kTE6VajdOvM+DtIGoaZ2r8sLXiZls7MxyTGKL/?=
 =?us-ascii?Q?z4qt5DTSesAM7Lnr/FA1jbJY2QeXtfACHsoujMB2AHEGYu/WxbAloB7/gsHw?=
 =?us-ascii?Q?cdrlP2nvVflgIqwR2hCX7+Q1zBvq4bkWq38G5eHzM5cZXNdulBI1qnAHzDwu?=
 =?us-ascii?Q?V7fKd92EePy56/dcuaBjw83S48rXFuyHkDcjtaKnHojiKWk8T3z5l8R2YRDv?=
 =?us-ascii?Q?guxHF+Qn5nZLfTQfIP3DWcdcNP4B+kuexhRplTOF5AfwT2bYn8SfqQQgbQ3X?=
 =?us-ascii?Q?ry4hnaSlIjrV4/Wbl3ZeDvaw3hPHMACYiS4WXkZTtOIy0JJQE2hW3zhoQtbi?=
 =?us-ascii?Q?AU0I69K7gW4o5Hn9+Ggy8gZcBoniP0v7wCSI0th8nl1FpYa/eRlKhBuLW/Z7?=
 =?us-ascii?Q?9jce81Bk7QSF35yNfZK+TP64Ga8PJGAyctgsqNdYaFcnWnVEiVGdcPBPH+MW?=
 =?us-ascii?Q?A8tlkzb51CusypSMoLubdKmEblwEozrTzyXSJL+bVgh0YO82YOuhVI1Ogxji?=
 =?us-ascii?Q?Zc7zo3E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB4PR08MB8125.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pZAQ3ZNPZeDh6KIJuVeqDhs7h3eAXgHucAq3ZFdHdinYOLIz+OZB3RxvmIkO?=
 =?us-ascii?Q?MSRYFDYMbRVM14rxnyS59SCKv4Iz5rYY888nTvd/aij44MxNT2t2oHP4Oilp?=
 =?us-ascii?Q?UQZR0xTD6AEZLW6K1mndmhBMCaXCCzQbGWwsU7MpB0B0E+Nomv+aC/zMkjNe?=
 =?us-ascii?Q?vFHbnj9Az6+Ma3hZz1+p9AhDZdIzvTgFEmpEQOLB26PHrEjSQt0Ck2v0OYCy?=
 =?us-ascii?Q?zJ8KXGIftmZ7+ykg/f1pzcKwc4IU+SJrf0zcVi/ng8sgAmQVO+xptioXCdha?=
 =?us-ascii?Q?GrRZPoU2MLTOjSB6KZU7u8bmOeesWJe8jhiq/x0A+CklInxgoZ1sBJinS+rj?=
 =?us-ascii?Q?Fs0txpdN6oEUlAAmfQShg+LLrx7D/Bc5/g6LrIlvqmQpSORZ9GZ3iC3If1th?=
 =?us-ascii?Q?8Tid5uWWY5mufbYPS8fsT/5GJx/Inkl0MHOY39lVQb+w69PaeEKlScXjY6Of?=
 =?us-ascii?Q?KOXA5PFiVYcN+BmZwTHMgfu5SCLxAxBdqBGT5e3xcSJ74JPZEPE8eUzXA5pe?=
 =?us-ascii?Q?Y8E46z8iz1zvw2xKBVRxkpqN2P+A40sNNUfEurm+PO2zFKtBcw99DAWHWaH4?=
 =?us-ascii?Q?au1ZretJx23Z4JKQeUSUbYsUYugayAHZJLfc9XKo8V8eGhK/cxdHdsoETK1g?=
 =?us-ascii?Q?o8V9gOaLmzu5v4Tr6/8puKynjwID6s5Cx/5oFSPBc2v8PM9uWvYrMImULDh0?=
 =?us-ascii?Q?GT930K6aH8vu5ZVT5A33iBFwZHI0dmmAxwKRSw0mTt99nQtQEN8hSeKw4IBY?=
 =?us-ascii?Q?/CHKXPElFhw1KB2jcBmz44BY59XEZHRB4cgBWJw18RC4bLQ838Y/ocITzJHl?=
 =?us-ascii?Q?PBP3nPRaJy6n1uWWmoZpeW80/hEY4Z9DoeqHObyYmvtVgX5LUE5Y4/E5pfeT?=
 =?us-ascii?Q?QS/ho8h9PJ2gmojZ2u5U6MJ44Xm7QftFu5iyWStr/pP8f3zYeqImc/wOtouF?=
 =?us-ascii?Q?hZvZ/u8pXPYTqWAmNGzmi2A53r8N9rPthAR69ReGxgiVIkp5vZbAnc1HpuYV?=
 =?us-ascii?Q?9b8GHvJ6fWEL0Yir3sgIOv5/Wny3A6fWHLLEa7/Dq56it8l3ztY07Q8YlEAl?=
 =?us-ascii?Q?cmzlgVPRpkSOFDPRRoYKCEghbMUNXWfeOV1B7J6l+L72jmbwzdd4O8akQrUY?=
 =?us-ascii?Q?Ks38GbdP5CqMIpLc4dlmtLwFexLF7EmhHAimhns03yzPU4osyhFeJ1p6SuH3?=
 =?us-ascii?Q?KdqRP/kp7OcrKSzGgGeXB2MzsSMKKuFA9qvhX7yaCcqH99XFnLg/YiQR3jBm?=
 =?us-ascii?Q?I2Q1o49PR2wCMb9ScfCtNjG9sz9NmlbWwGP014kJpY8Id37kpys8j4AvKo8b?=
 =?us-ascii?Q?ZlMXQUV6Wnev1CDGUucN0a4pD4Cp/DBkmuIrzPZdcXGhAcx0tk0H896/nW2C?=
 =?us-ascii?Q?p3PVlj9+zCqsrFANGk0IsRI6lGgg4DOfe/HnE2xVjdZoZFecWTYMdI9crKi4?=
 =?us-ascii?Q?EsMDaSWk5bn+5fx6AHY4+N0pBxm0UBboKG6+6JZsMGSpR750hrt3E2YVsuQf?=
 =?us-ascii?Q?fv5U8jghSfN7GDXLSUixahk619Ci56yroZcZlQeHGLDMWIKSwufV94FLlDin?=
 =?us-ascii?Q?2mDSKIf2y8geHaTIJB8/tAFk4CqTAulMf60IygMYtNdHig9ie1Lmurz6S2LZ?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8334c803-2b37-4a3f-9512-08dcb1174cf5
X-MS-Exchange-CrossTenant-AuthSource: DB4PR08MB8125.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 04:14:41.4737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CqdL3EWr7oTRzNVAcAnqz3h83WK3Y7sGKiXEVVODqT6DVoYjP/WezjrZMPIakwNFYkU6sA17nXMPK0wJI6clDWigXIFXcaCjBya2H4fQSRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8967
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

Option Acknowledgment (OACK) is an extension of TFTP protocol (see rfc2347).
Not all tftp servers implements it. For example it does not supported by
tftpd server from debian-11 (https://packages.debian.org/bullseye/tftpd).

Starting the "tftpput $loadaddr $size out_file" command with such server
will results in the following packets flow:

192.168.27.3   192.168.27.1   TFTP   Write Request, ...
192.168.27.1   192.168.27.3   TFTP   Acknowledgement, Block: 0
192.168.27.3   192.168.27.1   TFTP   Write Request, ...
192.168.27.1   192.168.27.3   TFTP   Acknowledgement, Block: 0
192.168.27.3   192.168.27.1   TFTP   Write Request, ...
192.168.27.1   192.168.27.3   TFTP   Acknowledgement, Block: 0
192.168.27.1   192.168.27.3   TFTP   Acknowledgement, Block: 0
192.168.27.1   192.168.27.3   TFTP   Acknowledgement, Block: 0
...

so, no data transfer happening.

Here is a packets flow for tftp-server with OACK support
(tftpd-hpa: https://packages.debian.org/stable/tftpd-hpa)

192.168.27.3   192.168.27.1   TFTP   Write Request, ...
192.168.27.1   192.168.27.3   TFTP   Option Acknowledgement, ...
192.168.27.3   192.168.27.1   TFTP   Data Packet, Block: 1
192.168.27.1   192.168.27.3   TFTP   Acknowledgement, Block: 1
192.168.27.3   192.168.27.1   TFTP   Data Packet, Block: 2
192.168.27.1   192.168.27.3   TFTP   Acknowledgement, Block: 2

and this time data transfer starts normally.

As we can see there is no OACK packet in the first case. Investigating
an isssue we'll find out:

1) tftp_start() sets

      tftp_state = STATE_SEND_WRQ;

2) on OACK tftp_handler() sets

      tftp_state = STATE_DATA;

   and send a first DATA packet.

3) on ACK tftp_handler() will call a tftp_send() function.
   tftp_send() will

   * tftpd with OACK support:

       Current state is STATE_DATA, so transmittion of data packet will
       happen.

   * tftpd without OACK support

      Current state is STATE_SEND_WRQ, so retransmission of WRQ packet
      will happen. Thus tftpd-server will retransmit an ACK.

      This will repeats until timeout happens.

      According to RFC1350 this is wrong. We should start data transfer
      instead of WRQ retransmission.

This patch fix an issue, so tftpput works fine with both types of servers.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
v2 change:
 * add more bug details

v3 change:
 * provide detailed analysis of an issue.
---
 net/tftp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/tftp.c b/net/tftp.c
index 65c39d7fb70..2e073183d5a 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -493,8 +493,15 @@ static void tftp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 				tftp_prev_block = tftp_cur_block;
 				tftp_cur_block = (unsigned short)(block + 1);
 				update_block_number();
-				if (ack_ok)
+				if (ack_ok) {
+					if (block == 0 &&
+					    tftp_state == STATE_SEND_WRQ){
+						/* connection's first ACK */
+						tftp_state = STATE_DATA;
+						tftp_remote_port = src;
+					}
 					tftp_send(); /* Send next data block */
+				}
 			}
 		}
 #endif
-- 
2.39.2

