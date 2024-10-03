Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461B2CF34AD
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 14:10:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BEC588E00;
	Thu,  3 Oct 2024 16:10:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="BDTJkzLr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A897988DFB; Thu,  3 Oct 2024 16:10:33 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D25788D75
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 16:10:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+0I7BQIPcAcaBN/14O75r136MioE3dq5BdMTE2GHP7GbrgdtUNy63RX3Dkt7I4Ml47mufkhQWQswGJYj43CbM4myN+0Tx0FE+D4i7HYmdNNTaQnMdlin9w0fW69z/4Hi34JJiVaE7sImNJjsY8h24zYfMvIWiHuSfqyZaqga9TX6Eu2vv7V0TdIecVB+h0IFXOV2A5CjtVlv6bLfvJ2FQS8yuVPsz4W0t+GREZqm692/F2SGssdxAp4EvDbyfB6Q14wYDiA66t/BGlbwcxTqahny1h17MMBHPto1iDLEAuJoeuf/2iyFFfXxudxUU+TP0As6htBetPuh7mqOZjZuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stN9NMBYMhzF793Ze5+iZkpaEUBiPEGeG0bFoWizXO0=;
 b=O4WshdYb3h+QQ70Ha133E9DxXD766DArwCwXDCgi+cYhH12o7wVFAh/0F2oPO76rv8A0GXJKAoXF3ZxGnByjEOjhmqwSUhrcdFBYd7dCQybq4avbXLZIMG51iSz4tGwt6mXI2Njui3p9aSPwuS+12AvIxMZX5qpslNsO0ufDWMtjX99B8whP5995ZT0PTwjPL4tG/h0vxq2Cl/1LBhxi+u3xtuYr4a6bjiAbxfjjQKDlcVVnvcAP7tbd4b5sH+rL5s2F9Ecq5rt6y9Pt8GUi6JEGqoAjKTOV/4rZ8Zma3e0kNgm1ODqyZJrLPdfb7FPAlwCDauqDX2z/zWkKO+l+pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stN9NMBYMhzF793Ze5+iZkpaEUBiPEGeG0bFoWizXO0=;
 b=BDTJkzLryaBvwYU8Qrp41z/YajGz4KabVhbrZTo3bMCd/nTGJpGtpP5tZ8R7WJKJrLh4s7EEEBcWpDsGaQTYlM/3MIZgtbwO6KoNDAHRbqj84KvvAJ8tUuUzSe8m51AP41WReTTRpJgrRvPspwKw3reczI2HDnPKKC3WEQzDM2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS8PR10MB6676.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:562::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9; Thu, 3 Oct
 2024 14:10:28 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.8048.007; Thu, 3 Oct 2024
 14:10:28 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 0/4] some serial rx buffer patches
Date: Thu,  3 Oct 2024 16:10:25 +0200
Message-ID: <20241003141029.920035-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.46.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0005.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::35) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS8PR10MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: 93904e08-f6cc-4049-d8c3-08dce3b52233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkJ5OFdhYmdkOGNsUm5nWEloTm9xU1dUUjNjdnpmd1hnS0dtMlBiUkNyZWRs?=
 =?utf-8?B?MnZKYnl4eS9qQXkyNXFMVUZGQ0doOFNYL0Y0OGwrY1RJcHZDYVp1SkYwSG4r?=
 =?utf-8?B?Z0lZaG0yMEMzaEhZSktEOXJVS1lDLzB6eXFTTis4WXNNWkpQbFZDL0NKWTcv?=
 =?utf-8?B?VDFETmNBR0kwQnFuVXpYRkNRT2hkRjRJVmJDbzY5V3FsMm1wbStFdkFPR0Z3?=
 =?utf-8?B?YkNlT1FueTRveTVBWk5MNjZkcW52b1BZcUlTWnZuUDQ5MzJjWWc5MVRsam5R?=
 =?utf-8?B?cDE2UTVXRUYyRFNZajhJMkY4SWVCZS8vRWlUbTU0VURKeHNvSnY2aTk5V3FI?=
 =?utf-8?B?NWRtcE0wQWJuN05mYnpHTnN4dmNtdWdHSkJ3VUdmSWdGWDhSNmpUN0tCM1BU?=
 =?utf-8?B?Sy9TbWJSZTczOEhOUmhhQWc2NjJOWjRLVVY1UXBVMWpyNEZHYS9keXdZZXNo?=
 =?utf-8?B?ZU5wYSswZlV5eC92b01PNG43dndiUjh2M1g3cnV4N2pRd0RkWHlvS3NReGls?=
 =?utf-8?B?YUgvc0xaeW5RaEdqOFN3VThaS0R0Nm9sTzFDU1R0cjJVYll3emppMUg0a3Y4?=
 =?utf-8?B?QlNnYTkxaHo4SmFVYXFyV1UzbjA2K0NiOVQwYUFnNkpVZllMMVJvaFVndzFN?=
 =?utf-8?B?QnovMUFaZFpUVk9DMTNaT2puU3hQVlB2b0xjOVVPYUlDWDRXbnF5V2d0ck9P?=
 =?utf-8?B?QlpobTA5OW9yZzhySzFSbG8yWEN4ajFsRjJNYVIvbEtmUlVxc3dEeGlyNlM4?=
 =?utf-8?B?UlNtR0hFRjFNOS8zaTNidUZBcHBPcXA1cFZDV0RHK0c1cmxETCtFR1dXVExm?=
 =?utf-8?B?V2NXZkRTWVZSaXowZXozcmd2dyttcXNUaStING1oejhDaXl5SGFwZTZBVTZR?=
 =?utf-8?B?dzFsUUluRC84VkpoVHBEZnUxVDJtdmVTUGJXMk1FOE1zOVdWQ1luMFRuckZB?=
 =?utf-8?B?eEQzRklOR2t1cG51YWdEeGdIYmtXUDg1bVIxNkdhektuVmVjdUJlb2pyQW9W?=
 =?utf-8?B?em9wZGlkMEVpL0IzRktoY1BaUHBrdU8wRTY4UlgxcXZHaUNiZ1Y5Zy9odFE1?=
 =?utf-8?B?YWxZVnRhUG5KSEs4S082N0FHekkwZTdVYmRmSlRoSlFYb3VOMEdxZW1XaEFI?=
 =?utf-8?B?ZUNTVUN1dUxyR3lHQmFkZit2eFpVVnBJRkJYbi9ITlVGdDk4V09vVENhYldx?=
 =?utf-8?B?ZDlGSFYxRVZNalBtS2lqM01OdndlVWxmMTBidzlERGpsZzk3QlJCZHJuQUFi?=
 =?utf-8?B?SE5iMTZaM01WT3htVzVwMFlIUktsVjJhc0YvSThmMUpYbHdCaCtpV0VIT29Y?=
 =?utf-8?B?Y1o0eVNKRHZyTjBPZWMzOUtQeU9NK08rbE9sZC9LZnBML3dPYXBkRmY3VHY5?=
 =?utf-8?B?WXNNZ2sxMjVPMVBORWg1Q3R3Zjl2dEhDeVJaTjE5eC8yUHMxSlUwUm1UdGE4?=
 =?utf-8?B?MXdJWXV1RTBrN2tVcTdkdStJL1UwMGdUaXlFWlZ3RXlsZ1lId0t2Ty93RVd4?=
 =?utf-8?B?TVQ3bmVINUJNNUJsenVHM2VJZjVnRmgxUkpsME1ZdmcrenpKRXVnNVpZTURX?=
 =?utf-8?B?S3cvZmVHeDVFcUt5UlZIOHhicUVGZTZhbm9pQzVJK1dvbTRyeXJINWFPS1Na?=
 =?utf-8?B?WUNsUElZcklIdEkrcUgrTkwxNGoxdzAzckVoSEI5WlcwM1NISkxsUEtkclVi?=
 =?utf-8?B?WnJyWmcvR2ExUGVxZDdsWGEvYVVZNFk2TGJvL21RZXdTcEFFM21rdk96V0pS?=
 =?utf-8?B?RkhGeTh3eXJaMGNyVlNEaWQ0RkhHYTU1RUtoc3FjYVNYZFBYOSszTC9rL2Nu?=
 =?utf-8?B?OEV4VWJYM1UwM2FDMVh4Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDN5Q1BCaExReFF2ZVJZamRmUEpBZVIxSkV4STl3OGhxWFlmZ2xQQ2NZajJY?=
 =?utf-8?B?WUhmTXVlWEtVcXBHMmx6RVZraUFuTlFWV21iMGM0U1NCRmtHT0ZaUEJRK2Ez?=
 =?utf-8?B?VnlNSmxMaG5hVE41c0l6YjlSYUdCbXM5R2FFanRuQ2FoQ2ZiZmc4LzlMa2VH?=
 =?utf-8?B?MWpBT1YySVJuT0VEa3BXejkzVHp1MlFERzlxVDF1emJPOXgrdmprN2ZXei9L?=
 =?utf-8?B?S204MWtLaE04dTg2UUsrZmwzYzNia1FMM0pIOWhDVjZ6RGpkSTdjVE52THNI?=
 =?utf-8?B?cVd2TVBkaldkV0Voc0xSU3hGWktNaFlvUWYwaTQzVS9melFaSWZBMTlUUE1z?=
 =?utf-8?B?elZWc1NJSTIwS1d2SzVhQy9maG5LMFNGa0ZtdnlRMGg2RHkyQXFkM2xNbXVx?=
 =?utf-8?B?TXFRWWoyeTBuLzEwcmFNUFd3S2t0eWtFRzNoZTdiVG5aQVp2WFVJNy8rMzZv?=
 =?utf-8?B?M2ZwT1MxTy9FYlIzN1RHaWF5NUkyckNtSGtORDFKTEM4YlM5K0VuNjJSR1ZE?=
 =?utf-8?B?cnRQZUNTSEFibWh4S1B1RE51c0xoVVNyUFc3QmgzZFYyUkpCOUFmNzc2WnRZ?=
 =?utf-8?B?RHB0SW5pSGpPV1NJOEVIOU9IV1FmL0laUldNSnIxOHZrczdNemRGdmV6SDd1?=
 =?utf-8?B?d29Gdm9oL2ozc3ZEYjNHMU41OHVwKzlkS2dZVm1YSWthR0ZzTmRTVGExSGRi?=
 =?utf-8?B?U2JzQ25IU1UwcUQwNTNlR3VFY3BIUktCSlhhRDV2UFlyTTZkT2c1M1NaZXll?=
 =?utf-8?B?Z1YwV1JqS0VFRTZYOWZnZkZxODYyUjY2QUp3d0hyWWh5S29taXVzVTlOMGZj?=
 =?utf-8?B?ZlE5b2FOYllsL0VXV3NKcTRiTEE3YmNzNktlTFpUR202VWE5Tkgxa3ZKNXlX?=
 =?utf-8?B?SERZaHVXdGxxYXMrWFB3T2RRcW9JU2Y5YjIzc1RUQXp3YlJ5c0lzTmc2dWx1?=
 =?utf-8?B?eXdJM1NpWFAwdXVPMGNVc1NSai83aG9LNWRNaWpwRHBmTTE5YlRpUXdkbVdO?=
 =?utf-8?B?dDZ1MVowWDIwaTNTdTlNN2Vma29veUowbGVMcEYrejlwbDVYUTZ2YmN6VFVD?=
 =?utf-8?B?YmhON1RNK1hRenhmckwrdHA1NjZyVDBqVnpmcTJrcm5pOEdDQjMvN0o1Z2pW?=
 =?utf-8?B?UXpFOThIVUVtWTRFeno4TFlmQjQvTDY1RlhLSEdiSDRPWnpkNzhtRWxGWHdJ?=
 =?utf-8?B?ZVk0azJRSjkwbXBZTlRvVUNmbHlQYkUrR1BFNjU0bGsvS3JXRmsxbTEraUNG?=
 =?utf-8?B?K2l0OFV0cWs4aFZnVTlmaDNwQTBtRGhGejdJR0p3T3V2VW5rTXFPM3ZIVTRJ?=
 =?utf-8?B?aVViS1l4cUN2cFlNMlNEaTgweWNBbFNnMWN0SHdnbldXN2tmaEtoNWc5L3FI?=
 =?utf-8?B?T1U2QU5ROTFFeUR0RXpvN1dSUkQ3QU1qTlVLWnpjZituS2pOdE5RZmdaYUN6?=
 =?utf-8?B?R09wUGt3bzFKdVd4V1pUMVNCcCtFdVNObnR5WU1Ndlk0RlpuSjdtVWJNQkdJ?=
 =?utf-8?B?WWJyWkNQZU5SbVA2bkdPOXVoUkIyZ3I1aTJRSXhGNGxXdk1weXlOYThwUCs3?=
 =?utf-8?B?Q3lpQ2tmd0JyL1BPWDRjMm14cjk5THlWbGlXMTkzTXpRN3ZWdFg5bjZweVdm?=
 =?utf-8?B?RDNpc2h3bStDY2gvWVY3Y0NHQWFmcjJYbVNOTlVSMjVka1JiNndCOVZJdGlU?=
 =?utf-8?B?QU8yM0t2NG1SMDZNNnU4bFFmQnJUeW84YzYxMVQwVTMvS08vYVBTaVVGYXFo?=
 =?utf-8?B?M0NnKzgzTnNtd2U1QS9DVXUyMDlEZ1ZsS21KZW4vRzUwNzkzRkphVGRGTWNv?=
 =?utf-8?B?dEE1QS9xQjVjV3p3UmRPTVFVMW9YNm5LRXV2QTNzZDBlTzRTWlNONm1tdmFP?=
 =?utf-8?B?ZDNFcnpPMG5TeHhNbzJUZzZmUHRCMXZCc2pYMnk0MFpwMDcvdmtuQ09qS05Z?=
 =?utf-8?B?Z2FoQ0hlajRsY2E0ZjRCMGw0VnIzMlNEY2JqTW40N0lCY1A2clBrSERkQ1Fo?=
 =?utf-8?B?a2dtUko0alJ4Sit3T1kyWUJvOWVjYXRrWkhWZjRBUXlpdU5zR2pnMU92Yjhi?=
 =?utf-8?B?WWxYSWFkaXdjdmozY1pjbWxkR1djeHB4WER5VkRaSEJ1Qi9aVmd3VTZBSVFV?=
 =?utf-8?B?L2Z4dDkxV3N4amFqRS9WVGZUTkRWYnZ1OFBtWTBlU1A3TVlkMUJmeE4xeXd0?=
 =?utf-8?B?bVE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 93904e08-f6cc-4049-d8c3-08dce3b52233
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 14:10:28.3112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJSiPFzkAAPvihV/bx2NFUxE0TuuTyi1B3jDUPNx9Ozil/8L5R3dAcbALtPyyN5uNkvX9BLvFrzXLKR3nCk0v7FoRZiHCmNzUNrbDvzL2ps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6676
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

Some small improvements to the serial rx buffer feature.

CI seems happy: https://github.com/u-boot/u-boot/pull/674

Rasmus Villemoes (4):
  serial: fix circular rx buffer edge case
  serial: do not overwrite not-consumed characters in rx buffer
  serial: add build-time sanity check of CONFIG_SERIAL_RX_BUFFER_SIZE
  serial: embed the rx buffer in struct serial_dev_priv

 drivers/serial/serial-uclass.c | 23 ++++++++++++-----------
 include/serial.h               |  8 +++++---
 2 files changed, 17 insertions(+), 14 deletions(-)

-- 
2.46.2

