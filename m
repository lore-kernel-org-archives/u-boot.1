Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAADFCD4F3C
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 18:13:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71A668481F;
	Fri, 15 May 2026 20:12:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="C6PbpBAS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D644846E6; Fri, 15 May 2026 18:56:57 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazolkn190130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d20f::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78A19846A5
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 18:56:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQ0IgZwSMIIMbJXQ/cjZdR3C37TcI3JCvG3+g6fn0lr4VtbN5xBak21J5qra43qOqOCLI1xKnOS/Ns4kSGQr1KY3km8CumIWhhc6CwFH1+AstwwgwsQXh3xk9vUvwYvgWqtKNOs9jXadDBI0d95PYx5a0U8INcXosdrg1hYN4XkjEQ6p+z9zRvpuFyQdeVl3ub+6hARjrfbl1y3NCF+LM9Tt1y6yc4sE0by5RTJPB/wKs/jk8Eg+/5jmHOI8v40vUZs0P/lRGGqQqFvYpu08P7RW4FgvvCjKJBJK3dT0JeAtJhzWYJdB8+lk06i4rAUpKiJcMoSseHx72X2HjUMxdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuealieImDAF9glLRCGk7P+RBfu9T+U+PLbaHti4Ykg=;
 b=kjH41WusYogRGNTGAKs8Pw8MIBQcJAYPHWq14Xo1/3Mrm/CyucSYdymne/0g68R0fphVC3oLuhST2MF4/LmVjowRRP9O+U3I6EhDCMVqmsZKvZZkEqJCYtUZBghaRo6Ls6VZYFpuSEM0mOXsVcQk5qYTlf4Ul53b4I34H3ysX4yDUMt2FHPw3/Rn7PgE551MbdIfpL21duUq6P+JzIxZ31iSpfUOTKgDRyUO260FOvE/ZmW7rHJpqSvtRK3Li4EdTaIc5K3NUNQCBE6JXRxRSJAngzlyZ0olIMX+jlBm8MTLaDaEgLPBbtTKpKImLo/i4G7uMwFYus+Iq5C+Iyxm1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuealieImDAF9glLRCGk7P+RBfu9T+U+PLbaHti4Ykg=;
 b=C6PbpBASNTgce98vCJqAjvI7mfDadeADnHTiKjvNA19+Pp9ZJ87V48+tESmvLsngwViT9IEVweMB7PkVfR9LroAQyLOZvjLfldVVagM+mry9iFD0ZhmgJKmCz6wCBMy6ob3+8yZLOHMmhRHLcMIsbGF+I1Uk4HczbnkT5qHyeiYMP4PvHuu8csXGiRD7GAQVWc5NtEUsQxSUg7On0/QmR6M6gndOA634XlqmeNk759QP8RvLEJV5l/Gd9xVoRUzjNPW7T+qA93kcozNBldEyomkS69kLw98usEz32NhAMrZfpL2rWnvqBaiypSrZ4WP6OnRIymonb4Di+yeJsj+NIg==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 VI1P194MB0541.EURP194.PROD.OUTLOOK.COM (2603:10a6:800:156::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.12; Fri, 15 May 2026 16:56:53 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%3]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 16:56:53 +0000
Message-ID: <BESP194MB2805D4957FB23F4FC2C7F370DA042@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Fri, 15 May 2026 18:56:51 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini
 <trini@konsulko.com>, Paul HENRYS <paul.henrys_ext@softathome.com>
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] net: bootp: Prevent out-of-bounds read in dhcp_message_type
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0073.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2de::10) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <e1dd4050-2ec7-4af2-99be-806176c970a7@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|VI1P194MB0541:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e523e28-b9f0-4048-2a88-08deb2a2f709
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|51005399006|23021999003|12121999013|55001999006|37011999003|24021099003|41001999006|8060799015|6090799003|15080799012|5062599005|19110799012|5072599009|56899033|40105399003|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2Mxb1BESWE4cHlRMnplekJDVXAyek50cGNwbVU0K0RIMzFMOExEUEFhaDF1?=
 =?utf-8?B?U0l1RS9QYlNTYlpwUGNpa3g5UUszVTB3bDdXYUYxQnM4MjZNMytLVFRUdjRk?=
 =?utf-8?B?S29yMVRHYlh5cHlIb1NjcTVScUdDeHhxTjFVTlRCUU9Cb2szNmVOZEZVK1hI?=
 =?utf-8?B?dThXK3B3TlpOazBOSE1HMDlxdUdQVytMNDFjTjdPSEI5Z2VnZ2lUUTJSYnAv?=
 =?utf-8?B?WERpUVgwZ21tWlg1bmpFODJpQVMwUTJKN01Odmwyekp5ZUwvM3N2d25pM2FP?=
 =?utf-8?B?SFRkcWlXQWczYVNsRlFuL2FVaEhtOU91R0c2bjNsSTBUMWpVcDdpWlhqMzZG?=
 =?utf-8?B?V0R3Z1NiSWNLSXNlRld2M2xNWXkxTG5ienBtcnFiTk1oMjFwbGtTei9kbGVS?=
 =?utf-8?B?WURpVmZTbS9iUWpjRTdGNVBXZXR4NHBLVlRMRkNEMEtCSnZvU2ExcFJYdmNk?=
 =?utf-8?B?RDJ3cTAyVHE4dlU5c0lJaHdTdTBzeUlUcm5MeW9mWW5UUzVvMnVPb3lZc1Zr?=
 =?utf-8?B?UmcxeUozOW1uT2xHaXRZN3BtS3FFRi9xMk9vdXYxOUZGNkw3aEFPbFdEZW5K?=
 =?utf-8?B?eVVQSjQxek9YOVA0VFpoWHlkcjNmbW1ydk5heTliZ254VGhwemo5amhjVzF2?=
 =?utf-8?B?NUpHcnVNUEtDSHVPeHhXc0F1ekRacEhYamF1ZEkzY3IvZkxTUG5GeWtTS2lu?=
 =?utf-8?B?Qlp2SDBsNkV1bUl6RFJUV0xlcnE2RlVWQjhXaVdqUlFOZmlXMUtYSEJMZ1Q4?=
 =?utf-8?B?cnF4Q3NBY1BTMWorVzNhYWNaK2FrQ2xIaXcwTjA5ZDFMYXYzc283N2Q0Sk1J?=
 =?utf-8?B?WnNuZ3VoTGRXUTI3NzRYNzB2WVR0Vmd0N0xCQXNzUTc0OVNIMWJkdjV1RmdM?=
 =?utf-8?B?VXNMaC9wRWxVMWZSSFFGZ2JPL0c0Q1o1Q01HZmVmNEE3Rm9tNVQ2L1hNam9Z?=
 =?utf-8?B?YmkwaWFtZHNmMlM5SS9UVFlJbzVTTnc0d25SVm15NEpiL09Ed1JjUzA0bU1L?=
 =?utf-8?B?S1JNVWtzU1puSklFWS9YNlhvSmFuSHBPaGJvMmZXemMwTFpra3pXZk9Cc0I2?=
 =?utf-8?B?YlN6MnhtMmg5R1RZTFl2Uk5uV0JiMEordWZZZzFqL0NyUEx3aDF3NjZ4U096?=
 =?utf-8?B?b0p6THB2V0RzZk5GK2JzemNmM3BIMng2RE5FYkpsWGtMQTc1S1FycWdoMjNF?=
 =?utf-8?B?blhsM212YzloU1laek9ienpmNUVPVWVwY2FBMm1ZcWQwQVlCZDBpa3MxZllC?=
 =?utf-8?B?U3VKejRlSkpDQ0JhVnE3MlVDYXpsZStXcldQWElhb0VtQlI1M3FyVXk5WW9Y?=
 =?utf-8?B?MmNiRXQ2MnU4dkZ6bUpmdlNTVGNUL0tZME55SFRGYlYyblJRRStNT0liZXBl?=
 =?utf-8?B?c2RpdXRTUXdoT240THJmTCtkRkE4bVFDYmErdHozYkoyMlVSM3hPZkVwNERN?=
 =?utf-8?B?TE90Q0ZKZWpUL09WQUJ4VzBzNytMVklJNTFzd2ZNYXdqMmJsWWR2NGR0cjdK?=
 =?utf-8?B?WS9UaGJaM3ZrelEydm1TdmFyRkFadXVKcEJob3BheEN3N0RGY0FMc1laVUNp?=
 =?utf-8?B?aGtKZz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFdEbCt3ME9hSE05clNaZkp1S2pnSkluLytyWnh4RHJoMEV1VGVwWFRBcllF?=
 =?utf-8?B?cW9GQVFqODVLY2M3clhGQzhQUk5jMUk2RDBHYXdFTmYyM25kUVdxWFBkYTdl?=
 =?utf-8?B?NTN2WlhoZU9qbkFSbTVNdi9qUkgzNmN6NXBQNHo4OEJscklBV2FOVEVKUDBV?=
 =?utf-8?B?OC8wb0JaRmFYcU5VN1FWTUVBT2tHbXdWcmYrb2tlWlVtTVo3MEFLSWNqSnFk?=
 =?utf-8?B?ZHBJOUdoaXFoc1RWVEFWR1NTS283Wld3K3Y5K3QwcGpVSGRMT3EwVWVURHRT?=
 =?utf-8?B?bUNjdEh4Sm4rSk9aODlOSkZmRm9ybE9qNGx0SW9vTVRQVHpzaTRoeFBJb1Vy?=
 =?utf-8?B?eS9WdnVjNjc2VlRxOTBnSjNNZVRoQzdvUWRPbFZJUzFuRDZrUVVuMkFrZHYv?=
 =?utf-8?B?czg2V1ZqMEI5VVhPclROZGM0Szh3bFB1dlpNcFRyV1lsUFJaRHVnYXExRXJ0?=
 =?utf-8?B?bkozY25kWXZjNXB0dFJaV2FDVG9LblN4eTdWMWl3OHZlQlpqZzNoYnd4Z2Z5?=
 =?utf-8?B?SGliUXM2T0NrblhZUXJkdmhVNGhDWi8xY1BoUDViSXB6WW9NYlUvK29JTWJ0?=
 =?utf-8?B?UnJ3S3JhcmxpRE9zZFkvRTk5Y0Q4Q3hTbXNKMUNld2xvdGR4UERUcEtaS29V?=
 =?utf-8?B?bHRBY0Fyem5wbVpBM0lGbXAxaXFFUlBvTTJBd05wOWljK3hlY0EzSnh5Snp0?=
 =?utf-8?B?NTJyMjViRFE2bitFQm5JckIvTkVmRFNZVVN4SHJYbWMwN1dJM21yajJzdDlE?=
 =?utf-8?B?VElNdTBZMngxeXcrcU1MK3dFZlhZbm9yN1plcGsybGpOWDdaTWNBYWM0TytZ?=
 =?utf-8?B?OFoxK2ZNdnVOYTdqNGxLZVFTZjVLa0lMSkNmRXZsOGc1elBjS2ZjcmVTSzla?=
 =?utf-8?B?T1lmTmVEbGx0VmhiYWlHV0oxY0hndGtuQTlGTlNRc3I1SElnM0ZheDFCSmdR?=
 =?utf-8?B?alhjYmlQOXFwUzBONzd0ZEJWNEJCNy8zSTUvZGQ5TEpnQ01MOHBvTkE0MVp2?=
 =?utf-8?B?ZS81aVQxMzBmd1F1V2RVWXp0TUpTcFpMblp1MXFMaWF4Sm9tTHZMWXZqeTJs?=
 =?utf-8?B?Q3dweEZPUHRTcEl4TDB2WnRRVFNuMmpuYWttMVlFOWptZjNlSjFqSDhIVkdn?=
 =?utf-8?B?cFpXcGpscEQwU0tNbi9WVHJXTTVzbVphMzNCdmdrbDEvTkxFeHAvNHBDKzh6?=
 =?utf-8?B?VHJQOEI5bG8xUHBORCtqN2lmYVVMLzRnZW1tUHZVQkd5VlhnUXhkRC9lU0pH?=
 =?utf-8?B?M1Excmh1dk9lL2xwMUpjN1QxVVc1dWNER3E2N1RsMkdWZ3doaEdUUFdPWmdZ?=
 =?utf-8?B?VUx0NnVZZ3ZnMHdMVzJUK0lqM2xHWitlcDBZKzVIbFg4REgxQXhnVVdnUkpP?=
 =?utf-8?B?L0ptK1M5MkVnZ1JWNlE4Y1M1eDNmdHVCRUJKU1BNYUszbVJ2QkM2S2J0SWNT?=
 =?utf-8?B?U3VBNWdGbXJRTVc3Z2pUSDV3OTFjOGFncTNOaVhqZlFBdGdjelowL0kxak4x?=
 =?utf-8?B?VEx2dVpRYm9pampteGV4WTF2YlNGQnk2RFBLNUdnLzlxcnhzTW1BU1diQTVZ?=
 =?utf-8?B?SnlUM05rdHgvL3prK0RNcDRmdXNydHllM3ZyNm5xTUVSSFA5OE5ydWpNRU02?=
 =?utf-8?B?dzdxdVVLQ3pvSEpmcXJvbzZiaWFoVHFuRTZEdHgxTUl3TUJyQ3ZJZnJmYVFJ?=
 =?utf-8?B?ejBmeFc5cFYrYnJZVE1tSkFzWE9pVWtGTlFaY2Evb00xQTNMaDBXZUlvaWZC?=
 =?utf-8?B?ZEkwdzNIdlpsSFEwY2J2NnYrRXRMUjJVVW1FeklJWHNYSGc2ZzBLTTR0cXNp?=
 =?utf-8?B?cUE1Q2FUOEhCZzIyRlY2aGQxN0tGb0R5UU9qMVVBYXVBWDk1bU1BRmFlZ0JZ?=
 =?utf-8?Q?vjIkKnWMfdxdL?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e523e28-b9f0-4048-2a88-08deb2a2f709
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 16:56:53.3807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P194MB0541
X-Mailman-Approved-At: Fri, 15 May 2026 20:12:56 +0200
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

dhcp_message_type() scans DHCP options looking for a 0xff
end-of-options marker with no check that the scan pointer stays
within the received packet. A server can send a crafted OFFER with
no 0xff terminator and large option length fields, advancing the
pointer past bp_vend[312] into adjacent heap memory.

This is the same class of bug as CVE-2024-42040, which fixed the
related bootp_process_vendor() call site. Fix it by adding an end
parameter to dhcp_message_type() and checking that popt is lower
than end.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 net/bootp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bootp.c b/net/bootp.c
index 8976936b184..f0dc329d6e4 100644
--- a/net/bootp.c
+++ b/net/bootp.c
@@ -997,13 +997,13 @@ static void dhcp_packet_process_options(struct bootp_hdr *bp)
 	}
 }
 
-static int dhcp_message_type(unsigned char *popt)
+static int dhcp_message_type(unsigned char *popt, unsigned char *end)
 {
 	if (net_read_u32((u32 *)popt) != htonl(BOOTP_VENDOR_MAGIC))
 		return -1;
 
 	popt += 4;
-	while (*popt != 0xff) {
+	while (popt < end && *popt != 0xff) {
 		if (*popt == 53)	/* DHCP Message Type */
 			return *(popt + 2);
 		if (*popt == 0)	{
@@ -1120,7 +1120,7 @@ static void dhcp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 			    strlen(CONFIG_SYS_BOOTFILE_PREFIX)) == 0) {
 #endif	/* CONFIG_SYS_BOOTFILE_PREFIX */
 			if (CONFIG_IS_ENABLED(UNIT_TEST) &&
-			    dhcp_message_type((u8 *)bp->bp_vend) == -1) {
+			    dhcp_message_type((u8 *)bp->bp_vend, (u8 *)pkt + len) == -1) {
 				debug("got BOOTP response; transitioning to BOUND\n");
 				goto dhcp_got_bootp;
 			}
@@ -1149,7 +1149,7 @@ static void dhcp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 	case REQUESTING:
 		debug("DHCP State: REQUESTING\n");
 
-		if (dhcp_message_type((u8 *)bp->bp_vend) == DHCP_ACK) {
+		if (dhcp_message_type((u8 *)bp->bp_vend, (u8 *)pkt + len) == DHCP_ACK) {
 dhcp_got_bootp:
 			dhcp_packet_process_options(bp);
 			/* Store net params from reply */
-- 
2.43.0
