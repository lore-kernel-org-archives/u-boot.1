Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AE0106705A
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 16:00:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1630F84277;
	Thu, 12 Mar 2026 17:00:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="aY58SRtI";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="aY58SRtI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97BAD8427F; Thu, 12 Mar 2026 17:00:20 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD77184068
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 17:00:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=lyerXlTFKLWisGlusirJ9sZJv67oV6/P728gf3ibYiEIDyNqTZTtYoNeBnBH8nMiDfev0O80zx+Zkmw9nMAs2akPb67NdGtda1BYfMDHxQumz0OKQSF7DizhzRm5sylkyZ8emQSNWjn5qjlVVwp8Fx/jq963Ua8MGY6doasmV+74igB5748wDhPtBXfsc2s6vKqTyZM+DKf4qRkvcSkJswiBlajgbi7hKVSw7o0bl91nGhyVVnYSowpxSVKT0WAoON/X5ajPPMfq2gxDqXmKRs1Q7sKqfhgFecyE8a5fVGxlC88UE2hKndpdvMIZONNK6AMlx5aGCm6psVBxzRKIng==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMHOsg+4oG9hwCgZMW2ALYxGSywXZAUBiX4sXpOhUrs=;
 b=iSTtZkrk4Bdbm4YaETaBfBBF7n0ifrPXUbnlWfIKE5OTov6D2xdDW0Gw2I+BS6Bx4SIPQnNE2OVDKtZfg+faQXi1oeLa9ZBGg4NiG7q/wqIGKpro8lD2UyEKGlOrV+2STGgZ/RQHBiMdbGU8k1pEpxzD8oOKyStnSNT4UtOuXBvgb/kyQfFetzIjcjoIGJzFJCqg/MtzqgNzKNdY8023ARLDp/NcnFBLd80+vV6L+wJG8TD6ojMu5Tr0P+LalcitOzvxD9Cy3o2ST0lDKE9zfqR6ayOSOqkF2ZlEjGlzT+U40DONP0NeSS42ra4bQG9Ikb0O9RRNWJ+3pkTGhigrtQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMHOsg+4oG9hwCgZMW2ALYxGSywXZAUBiX4sXpOhUrs=;
 b=aY58SRtIVZGkyiLx8ua6ncND36w8BYGOAS6dfEUqKSCP+ofasU1pf8v3hQQRkrxHVdUuBC6oGNMI97Ir+NkkQkRS9Z/DfE1ZX/lnLzX1F5ImB5FUX6M1asOS5ycbafqBs2X0Ke4PbhmsOl6zNyUXnFTAwC2gkRquONoVUJKGfs4=
Received: from DUZPR01CA0344.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::9) by DBAPR08MB5639.eurprd08.prod.outlook.com
 (2603:10a6:10:1a2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 16:00:12 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:4b8:cafe::bc) by DUZPR01CA0344.outlook.office365.com
 (2603:10a6:10:4b8::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Thu,
 12 Mar 2026 16:00:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.16
 via Frontend Transport; Thu, 12 Mar 2026 16:00:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivT9qRTCDCfO5R5mvU3Fg8T89UasfaMCoG1c2VwjRnaz5pQ6jGgb3S967J7fHYFIBukX/1g+viy78J2qfDxC5vlRnTn3LU5bJve+sOP7Vmdj6PQeuZOLFJws6ismnCkLFfIFh6tCwvomgDIt1vK+yRawStu7TydoRw+tBQn+ZL2y/5CmiI7risYp1rnnO3GQVqCMTfvs+egU+/AEafSaEFW3RMI12ZT+WeWLCZL7O3aQnwsdW7p+v4RkjVFDuU5b5oOMhnLAZeg7EjU7rah0kCKXi7FGIjHZ7bca8pdf5QGs22lzqkEPL3Quu0r+Zjy+nFGsUb+6DfvsThhXIQDpJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMHOsg+4oG9hwCgZMW2ALYxGSywXZAUBiX4sXpOhUrs=;
 b=gJxRQM5hK3N83M8KzQPrDT6SQIm3OcL2+kUfLngS8CTvGd5DJc+7YtSQ8+ax59kSzh9aEc/GKBAtZ57yVhQnvuhlKExzS9UBJVo2tGsf8M69+pnpzrFRX4wu1KCYpBlb2HKj3lFGSvUaw6AlUeuduFsjq1p/Dx8wM1hHY+KitknpthCXyvyyW+2MyvaHSvGQiYh19/QZA+U/s22VMfyEoABrEH1J/7VvRUCyYB9EdqfXHGboUF+wLUvNaR2fI9/kgoO8tHlCDUJjpNqd2RWDUrKygJ4hX16C/A820MDji8LP6tJCOYjywVWz0S239F+W1MMDoJTpxjEypNN29P4JxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMHOsg+4oG9hwCgZMW2ALYxGSywXZAUBiX4sXpOhUrs=;
 b=aY58SRtIVZGkyiLx8ua6ncND36w8BYGOAS6dfEUqKSCP+ofasU1pf8v3hQQRkrxHVdUuBC6oGNMI97Ir+NkkQkRS9Z/DfE1ZX/lnLzX1F5ImB5FUX6M1asOS5ycbafqBs2X0Ke4PbhmsOl6zNyUXnFTAwC2gkRquONoVUJKGfs4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB11741.eurprd08.prod.outlook.com
 (2603:10a6:150:312::22) by AM9PR08MB6179.eurprd08.prod.outlook.com
 (2603:10a6:20b:2da::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 15:59:08 +0000
Received: from GVXPR08MB11741.eurprd08.prod.outlook.com
 ([fe80::d47d:7756:5c28:de2c]) by GVXPR08MB11741.eurprd08.prod.outlook.com
 ([fe80::d47d:7756:5c28:de2c%3]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 15:59:08 +0000
Message-ID: <91fa5175-5eb1-4991-9467-fc3fe4f52105@arm.com>
Date: Thu, 12 Mar 2026 16:59:07 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Please pull net-20260312
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, nd@arm.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0133.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::8) To GVXPR08MB11741.eurprd08.prod.outlook.com
 (2603:10a6:150:312::22)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GVXPR08MB11741:EE_|AM9PR08MB6179:EE_|DB1PEPF00050A00:EE_|DBAPR08MB5639:EE_
X-MS-Office365-Filtering-Correlation-Id: ed93d888-e203-43f9-f9f4-08de80507189
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info-Original: Sz7/yWjZyUEAeNvxM+I0GCle9Lb//zbeF9LYGCZkQ8TCE3eCxuExPpisDd/d9KjQjUDzTGEBY9wmocK8PRKoydfw020Q7NS0ZET/fF9kmD7zjsugyjfs8br1DJILTjUqZKXggLWOHpw4VGaOGDkf2d+ufv6h7EqTOkWGtZqLwi6zcZyO4vlgYi/5Jr+65lVPIg1UUOhK3BF4g/bpLzdR2hFXEYOiIJgsmQ4jzzeoCfspisOA2b942J9/KaCs56ILBSP0IDfFXLshqq4aE9w6iMkM9e3kyIVzKOU8wcAt5Lga7j+058l1QvR3051BC2l0lm6/BgfD/PBqNhIn1mz3HBtbneEFQ9AvVMbmrRaiDBrMLsSj+XNdbG3FYyyYTNM9jrdhcJj3sbJL3Ch+Mcqb003NtZJBRzN6mjSQ2/f7tjeoPy7wuccqIj3Oe62MLHajb01IeXR9zbrC7ZijBGYXln5YO6ySB8L/0RGWCCgiu9hlWDqiumUc8Da3DG/UmbNhznmWTa9B8E4M3SZppz4p2MKPhocFp7lI396fxl2/6FSPKaDRmK0+WDSOlYuhtdJHyox4opi9mXm5Yg+Ozh6xshM3O1//iBGKIl5UAuvTvZ9tH02Q7pWvPH6WS47tjwIlxPgrSNnOQaP7bVm2VKRMVhuE55j9Zf953GvWiaRwbTARa+jhePI250XS4eEl/iVB
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GVXPR08MB11741.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003); DIR:OUT;
 SFP:1101; 
X-Exchange-RoutingPolicyChecked: p3syLeOhAARr8lO4Mph5+xVEu/AC+IOz4eppbd+qkSVaBdsqAkjQeJ3h3KGr5NMym59kUqTUqsykSkqhLabBFj/T70sw6GDAjHb5I0b5TB4PPSaPtoNRrS7xy1hT+1/jOUtp1uRYUuNoFzIXqusk7q+oBUAhKaZn4nQsPmfpYdTZDbC5XlRIVKmxamqZeZM6E5hqcLnmHGGEyc/eryqnMBZ/azmwKTKH+3crcTmdj+9GXUND0ETLL4ROoBHmyHgjeyeOQ2EiINC7VL2Zn6KY6+iGP3jnP0JMHrvriPLXjIRQqXBNFjzp5Gvn3Z0e0+fIxFRPl0MLLRKTs3n09mz0ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6179
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 15494a93-f2a6-4c7e-815c-08de80504b4b
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|35042699022|36860700016|1800799024|14060799003|82310400026|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 9Q2A1f0Js/PeVzgj+cXBYzdOQA5X221AsyWxBPagyd7zmAan4pE03L71fx0KDkuwb6w0LHtMvqCpwXU4N5r+N/WbxVLOTOyeYKI5HaefkAwQknmTd1FoZSPjxuRT+iAACNXbBglW2lC9UIDNpphX/5UU+QOe6OnwPA8YO5/DHZjfo8xIQRdtCsIKMqA7SUw4acBR6BE3Ce3T47vsIil6kmw9CaaoLnfXN88eWM3rFYc23Guo2HJZIrsTvAohuDJiTUNz0rakSfDGbwJF6uWizP06KwExV4nLQdi/Jl8eA7CJakTfrkPd6/G07rY7fdsrUajhwRYHo+TF4KdSEdTFN0NFpfxSWtkbh1FUJpeKTaqpCF+71Z8Zh5TC1bJED+ZPLS30Fs/zI1AdMLSgZPRv5um6RnjyNPJ1kKcwD2L7BQleUNx2tOfR0XhdPWxiqqgqk4gHgYk/h5SuqtBU1aze1RZ/pqwCA/s3BKkS6yv7AQ/k7JlGqtq3U5KdwFPTqQb253Zky+ugokw0TwnBGruRIJcmdl+dsuTDRVXUIw01+ZcounugPvZvCcs6SbA7452Kc20iWqzfgMxkdnZcxgmKqCgHTAUAHTVn9XFJ96tAk0RzhDS8dJ4cguoLUyu8++ZY036kuNz87A8A7naQt5HyJGksORdiOMaaVLwKJaU+dZ87jY/8L2fV4TPBcIJJ7PqhqfCYXg7plM6ncGYXoE5UGVfLBXaD+Wv75k3h+bXfIRI=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(35042699022)(36860700016)(1800799024)(14060799003)(82310400026)(13003099007)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VdiMwrIcXNz/gc5MHefzFSOWsUz57DV5ZJNpEJdw1A+vR3NQevF1Rak16PaHKl0VcetUU/BWz0hsRVuWbB4AXmmHDd0UqC9Bd4PHGSI3vmQ/wR7IqPQY1qJLI73Q22LoJwrrsq+s4Yy2P+xr2gNrO68jyrzq04YcVmz9fiaSCwmK3tL/RQH/SUqLP4haz7QtXiAWKa7Z0NrXBd2Pe0gdzLAOUiOkA3BmYvWVXt4Geg4wSp5GU/WLSdz7CO/cyqru2bUQH1VMTuKzmZULu0uL5AY2seElXgxqBX4fbZkPH87hK1X2QL7+Ez0WRaipdQDa+8PNwjMQyT0M5hr8nzFqSTQuR4GVSoG4ccd7FhO0dqIJR7mW79v1R2X0OHTZtp3RfLRy6N7SobXfUn+VSMoXSeg9l/F5NhpB7IaPaDCc7doUFnJWytRmPiNRYc6UJEqB
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 16:00:12.3205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed93d888-e203-43f9-f9f4-08de80507189
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5639
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

Hi Tom,

The following changes since commit ba7bf918dafcd093ad733b07ba490baeb20cf5da:

  Prepare v2026.04-rc4 (2026-03-09 13:52:04 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-20260312

for you to fetch changes up to e2c621b2cfd9489b5cc1fec4dc45045dab901ff9:

  net: Move network PHY under NETDEVICES (2026-03-12 15:53:41 +0100)

----------------------------------------------------------------
Pull request net-20260312.

net:
- Move network PHY under NETDEVICES
- s/DM_CLK/CLK/ in HIFEMAC_{ETH,MDIO}
- Add support for Airoha AN8811HB PHY
- airoha: PCS and MDIO support for Airoha AN7581 SoC

net-lwip:
- Fix issue when TFTP blocksize is >8192
- Adjust PBUF_POOL_SIZE/IP_REASS_MAX_PBUFS for better performance and
  resource usage.
- Enable mii command for NET_LWIP

----------------------------------------------------------------
Christian Marangi (6):
      net: mdio-mt7531-mmio: use common header priv struct
      net: airoha: add initial support for multiple GDM port
      net: airoha: add support for Airoha PCS driver
      airoha: add PCS node for AN7581
      configs: enable PCS for Airoha AN7581
      net: airoha: fill in support for PCS/PHY in Airoha Ethernet driver

Heinrich Schuchardt (2):
      boot: availability of command mii for NET_LWIP
      net: do not use non-existent CONFIG_DM_CLK

Jonas Karlman (1):
      net: lwip: Fix PBUF_POOL_BUFSIZE when PROT_TCP_LWIP is disabled

Mikhail Kshevetskiy (9):
      net: airoha: avoid out of boundary writing/access to gdm_port_str[] array
      net: airoha: declare airoha_eth_port as U_BOOT_DRIVER()
      net: airoha: do not call airoha_fe_init() from GDM port independent code
      net: airoha: init switch before GDM port initialization
      net: airoha: pcs: improve/fix building rules
      net: airoha-pcs: an7581: sync with linux code a bit
      airoha: add GDM1 sub-node into EN7523 ethernet controller node
      net: airoha: makes PCS support optional
      net: airoha: use mt7531 mdio for GDM1

Pranav Tilak (1):
      net: lwip: scale buffer pool size with TFTP block size

Tom Rini (1):
      net: Move network PHY under NETDEVICES

Tommy Shih (1):
      net: phy: air_en8811: add support for Airoha AN8811HB PHY

 arch/arm/dts/an7581-u-boot.dtsi        |   71 +++++
 arch/arm/dts/en7523-evb-u-boot.dtsi    |    4 +
 arch/arm/dts/en7523-u-boot.dtsi        |   13 +
 arch/arm/dts/en7581-evb-u-boot.dtsi    |   18 ++
 boot/Kconfig                           |    2 +-
 configs/an7581_evb_defconfig           |    2 +
 drivers/net/Kconfig                    |   16 +-
 drivers/net/Makefile                   |    1 +
 drivers/net/airoha/Kconfig             |   12 +
 drivers/net/airoha/Makefile            |    4 +
 drivers/net/airoha/pcs-airoha-common.c |  827 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/airoha/pcs-airoha.h        | 1220 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/airoha/pcs-an7581.c        | 1375 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/airoha_eth.c               |  319 ++++++++++++++++++---
 drivers/net/mdio-mt7531-mmio.c         |   24 +-
 drivers/net/phy/airoha/Kconfig         |    2 +-
 drivers/net/phy/airoha/air_en8811.c    |  687 +++++++++++++++++++++++++++++++++++++++++---
 lib/lwip/u-boot/lwipopts.h             |   22 +-
 18 files changed, 4517 insertions(+), 102 deletions(-)
 create mode 100644 drivers/net/airoha/Kconfig
 create mode 100644 drivers/net/airoha/Makefile
 create mode 100644 drivers/net/airoha/pcs-airoha-common.c
 create mode 100644 drivers/net/airoha/pcs-airoha.h
 create mode 100644 drivers/net/airoha/pcs-an7581.c

CI link: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/29493

Thanks,
-- 
Jerome
