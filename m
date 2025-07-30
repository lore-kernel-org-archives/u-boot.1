Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 112B4C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 15:34:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BEEB805D7;
	Wed, 30 Jul 2025 17:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Vqdpg6iZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63F608091A; Wed, 30 Jul 2025 17:34:50 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20705.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::705])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08510803CC
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 17:34:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlMwRcIQ49USG4yndt/zKhrHBIdrf41JmLzxUn+9k2uROvdN6x+myECiu2RPCbVpWdSUQp3dTZd3h9I7csOeh2TdZY9ms7beJFejR17ZKMAwCjTqQwE6UqgtpLNQH3U9n/9O+xc7d13IQ2V/1qLTj2QqBkVZGj0RvLYjrU6xtRKuogjzHDFHmD/Tt5OkeoH/nKPk3vOYfMQhkkQQEVtuWnZDumupZbvflkCeqpTXaDQvABvDe3JbYjZ6M2fK7LUkybC2tvs1X47GevxnOoy0UuaupoSdtMavMKQ9tvApIUQkmUQoRDWDx89wLVD54TmL+3WEm+OIwtbt49ID/mYvFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFp3HUHUnzwppP4qC+oModSBxaiIWEBD1yyem0P6RQI=;
 b=PX3LIBbjolCgVTpxq6T34QzPKPuk5OuihGY5MtVqy3Bnm0rZhtC+6LYFAs/De3ryNtgIpzVgkkUQUj5siaqIHp/H3ExNao6nP9IOXuO9C57gOot/PbUwpUyopkmlSXZuQIXdL7soxa3SOfsZnp0FW/7/PP3+SW/Z2A3tVwBnwRL+8xsaUHGd6b5hAPHA2ckqfPukE4MnYaq2GR1cLkGxvq8LENwL5nEayOyP+zaOuhVqHKKcxvVrfzOn5QOTy4DClWUP/fSFg/h83d60sJZYyPlL0KsEQjbTRrx3G/q961Rk5RfpMUI7IvH6nALVf9PhR5UzKWbVbXOISh4+Vz/zLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFp3HUHUnzwppP4qC+oModSBxaiIWEBD1yyem0P6RQI=;
 b=Vqdpg6iZpjYRXB/E4pciaglp5Aaw+B8IJIhfkQ5/rD5ScojK2VVCgUD5Do8zNiwoR7ODru1bUwpWRcJxlSLkZQkUP7mQWtR6/vt9l2PtkBaW9hWJQaHmTBxY57cMb3wf7w2Sgi++EwMZxWyNG1pphnOytoM/kgBsXjxEwhKk1mvWY69UaY7kj4EbcXEmRJiXxljf0Zt5Avmv8OAZE2DV+P5Xwj/v8sZK7uEwLDy9qHww8q4dBCz+tPmeBNSO85pc4HIoYEouKlxS9WS4+cxQakdkwX75NpwwebIug23+ZbnKF9AcrOThsSZt8aN3Y8AkJbIATsXbd0K09sUOCVqCNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by AS2P195MB2081.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:551::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 15:34:45 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%5]) with mapi id 15.20.8964.025; Wed, 30 Jul 2025
 15:34:45 +0000
Message-ID: <9d812fd3-6bbd-40c4-9485-f1aca43804b9@phytec.de>
Date: Wed, 30 Jul 2025 18:34:42 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arm: dts: k3-am62a: remove GP security variant for
 AM62A
To: Tom Rini <trini@konsulko.com>
Cc: Bryan Brattlof <bb@ti.com>, Garrett Giordano <ggiordano@phytec.com>,
 u-boot@lists.denx.de, Daniel Schultz <d.schultz@phytec.de>
References: <20250729-no-62a-gp-v1-0-1dbdb4469ad3@ti.com>
 <03e3be58-3c69-407d-8bf8-3f90e6b19e6c@phytec.de>
 <20250730142624.GO1807455@bill-the-cat>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250730142624.GO1807455@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0048.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::10) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|AS2P195MB2081:EE_
X-MS-Office365-Filtering-Correlation-Id: 845f1d22-c66a-468e-0387-08ddcf7e9c98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3cwUHkzcXEzT2xjbmkyUGNOMVRUa2lwNzFiUk9iKzFZeExwZS9XSGxTUVVk?=
 =?utf-8?B?Z1l1ZExab25RVXRLWjdFbGZVaTR2N1FDeGRuRW1oRDRWRUFmSkRYUGoxSHY2?=
 =?utf-8?B?RXlncTU4dXNLMGQvWi9KY3E5dFRYTkoySUdCMy9pS3lsM3J6aTVWREVTREs5?=
 =?utf-8?B?YzhoanQ3ZDIraGtRWXRFV0FzZmdydkZ4QnFTdkJTRENCVGJQc3RBMVB6RHV1?=
 =?utf-8?B?bEl2Nk1vbVkyVVRCYVNYME0wY1FmWE5sUDVmaHVDTG9NSXdhdmoxVUtRbUtp?=
 =?utf-8?B?b09TdFZXdGdwOTdMekM5dWlSR1FibStXQ3loUkFtMEN2SmJWQlVGUjJYcDhL?=
 =?utf-8?B?cUJDWVFiRHRUbUxHRE9jOE8wZ284NW13T3drMlM5UHkzTWdtVjJIeEFMemlW?=
 =?utf-8?B?d2hLU2VRVFRjMkJOVFlTTEJQdXJzVWxITVJFYlAxUWlFSVgzWSsydVVCYnJF?=
 =?utf-8?B?NjNkRVJlWDgrUGZocWdlQVFId3VQRTJjZ1o5ZTFyYjl1SkVEeWJkRUlXZ0dm?=
 =?utf-8?B?L0lWOGRENUJVckR6U2dPWW1tTXEvc2JNL0RkTmtTclU5VkZBYmpNeFB3N1Z5?=
 =?utf-8?B?SmtUN0FpN1NwaThSaDlBeGluaVphRWYxMzRQNmE3NmZoaWJ6Q2JvN0htK2Ux?=
 =?utf-8?B?em1SUUp2Z3VnSkxwK2Y2a0NxSG1GWDlBZVE4L09JZGdncUdZQlg4Q2VDVEJh?=
 =?utf-8?B?YlV3cnRWQ3hxejZKYjluZmNQQWdaMzk2MmpyVVAvSUhVRFZYVFpCL1NXTVhG?=
 =?utf-8?B?OEVzY0Zza1hlQnpPUjRURytySmpCTUVnTUZ2dmozYldIa0ZwVmJzV2IxMnhY?=
 =?utf-8?B?aW5KTkxrdjRWeFlJZzM4MndNTHJrUGc1TDJrY01OM2xhUjNnRjN1WlJhUUZy?=
 =?utf-8?B?Ky9RSi85NHVIa0pnVG1pblgwN3h6Y29JK09keitxZkZ2bVE5Q2lLclJ1VnEy?=
 =?utf-8?B?V0VhbUsrWkZSRnRzdWc4M2lnOXBUTy9ZTHBrbkV5ZUkyTjQ1QjI1Umo3Ulp6?=
 =?utf-8?B?Ky9taTM4WmVTRngrY3hhcjRHMThqU09EVkpmaktpN0xVanE0SEk4NHBKa3FR?=
 =?utf-8?B?a0oxV2hEcCt1OS9NRENPa2s5UStiWmhUTGVHN1k2aVZSdEcwVE9JdnRRSXJS?=
 =?utf-8?B?NnVzOHhIOTZrZVFVRk4rWGZqRENZYklwNHZ1NHdlWUVhWjhFcmNMVkczL3BU?=
 =?utf-8?B?MW1XZ3B6ZGI1Qm4vdTBFV1Rnc3FBOE5rN3VoNnhYRXdlMEFtRVdpSktlOWtx?=
 =?utf-8?B?cHY3WXE0TVMyTVNPdFNxR0RteEl1S1I1TGVRWHZUZ0RLYVhlV05ObnB1bisv?=
 =?utf-8?B?RzdUNWcvV1JZcXIwcTVDbitkNHE5K01sKzlrQ1ZpUndwOEN5bzNCTThOb2Nx?=
 =?utf-8?B?b3RaNjBFVExsMHB1aGdwczBCUStpRW1TUHRweE1vclI5KzFZK1pESEVFbnM0?=
 =?utf-8?B?WUFITmRhUW9YRmovNTMwOUQ2NXd1QWx1cGVYU2NkWVNrMTlneVI2NEJaSVd3?=
 =?utf-8?B?NkY2cDYxKzFmQWFpa2ZMODBmcU1FaTZIY1FnTWgwd0ZjSmdlanUzUWVsZ1Vh?=
 =?utf-8?B?YmtOK0JWRHJLV1JvRklxUlVIU1E5ZUtFKzVJSUJJV2o2bnlPS01nV1lreWQ4?=
 =?utf-8?B?M1RXQXY4N3J6SnlYcGx1MVVjbFYrSVpDSVVobmc1YXJFQzc4UHIwZDlxZkJr?=
 =?utf-8?B?OEx4Q3V5WVJvN2JpUmt3RzFJVWNVYmlvdEdJN2JZSVhWeGJ0MHE5S0lpb0NZ?=
 =?utf-8?B?NzNiZHY2UStsR0loSERKUXJnKzMxVnJlbGxBZXhLbnVUL1ExeDJRd3ZOQitr?=
 =?utf-8?B?UWZRM2NZaEJyYXhXa2dFSmh1MExOUEd0N3MxZW9WbmtZNlFqbUtERWRMVFRo?=
 =?utf-8?B?b21VdndlZEFSOS8wZzlUeFgzQ1F4bVZ4NkZkMFF1Z0w3clozcDQvTWtzeXVC?=
 =?utf-8?Q?aUilDzGHAPs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1ExUHZYWkgzcVZ3bnZ5QUFDd3dPZFptejUyU2UyNWd3b29Ca25STGRxa245?=
 =?utf-8?B?cGlZR20wVTdjQ1BuMWp1eUZBcERpVFFiTFpOTURrNGdGY2J5RW04WGJNVGJJ?=
 =?utf-8?B?MTVKQkZ6by92SXN6S01HU3lsQVZaMVJOc2ttRVg0NUI4Qk8venNQOFQ3b3Fu?=
 =?utf-8?B?Q1NiSFMrdWZuTk9xMyt1SkpoUk8xSUc1bVd1OHUrWnZJbVhWM1NrQzhLQ1B6?=
 =?utf-8?B?V2dmU0hzeUJWSVJDVlFJaE5JVkpUclhZRzlETW9xM3kzM2Yzc3VtUGRiNUdm?=
 =?utf-8?B?a1Jxa1AwRGVqdmFsYnIvVFRQdVhiWHJBTnRhNVFBbmg0ZWVJWUVIcjhLYXMz?=
 =?utf-8?B?RHg1RUF4Mk5lMi90aTkraFlsUytZZEhSSmxFeURtR0JNRUNvcTVuTW9jMXV2?=
 =?utf-8?B?czROM2pFZDY1WG9RbDZqTlRyd3pQS3N5K0gyU29nSElaVDZzQjVGYkpwY2Zp?=
 =?utf-8?B?TGdReUFZVEQ3L3d2ZG9PKzFaWElKeThPZFRRZ2ZabW5ydGdQZjhKeUtPUVJ2?=
 =?utf-8?B?empTYldGZkI2ZS9yelQ5TXc0WVpVL0RGMGw5QWdWRTF0ZE9Qd0NNcUFXM1p1?=
 =?utf-8?B?U1YwVjk0VGxpSTJUSCtETkZWNmVZSkE5VERnSzdkdHh4MDRndFZvNXVSbEw0?=
 =?utf-8?B?U3g5Vm5jOHdrT2xOQUFIN3QzS21lTzJ4c3NZNC9KUEVPZnpmdi84dnAvMTB2?=
 =?utf-8?B?NnlMNWp6UnArOFUzNG1Ea2hrMnArNzg4REsweXNJd1FNdEdaQXBJaGI0c1g0?=
 =?utf-8?B?ZnhwSUVtaHlUbDlhQ3g3V3JuTmFRTjZBbjFCcjF4d2RBUDBhS3RWbkROM1ly?=
 =?utf-8?B?K3lFVlVkQ0tCOGdIQXlxYlE4MjVxeDNERFpIUXZvOENVWU1DZ1dEOUpiaHlY?=
 =?utf-8?B?VTRmVkhBWlgxVmowL0xPLzQ3TXh1Y0tmSlBDdUJsamQ2aThoKzhQRVR3YlBT?=
 =?utf-8?B?K0hqamVjRmJBYkV0OFpDZGlKK3hReWRjR1pTcjROeCs5b2tocVZHZUVFUGgv?=
 =?utf-8?B?YXh2VFFMdCtRbVhmZmNxUVdWNFhYRkIvUk5IM1ljYUlPRFkrUkpOWUxIRVBu?=
 =?utf-8?B?ZjdvdmpuMEFiM1RFRzZkNXVlVTUzb252VW9OZXFRNDZlYWRJS3pvMHVYU2sx?=
 =?utf-8?B?OGhldEU0UmkySmFVeTNZZGhBdmY4Vm5TK0hTUjM0Ti9Cdnl2ZmVsSENlSEQ4?=
 =?utf-8?B?eW9LN0N0anJ0VUNjTFp1UEw1YzVHM0RjbGJpeVFSRlBKQUZLOUhtL3lVMEdi?=
 =?utf-8?B?cmdDMC80b0R6TmduVzZ6ZGZReTVFckcrcE4zLzFLYzBJMVVwWlBOVUNQdU5I?=
 =?utf-8?B?b0c0M3J3WHNaMGp3eWZlR1grbnJ4eThmdFNKL1dFTFFMSmxXdWRDVTFUYm14?=
 =?utf-8?B?WXYwVVozQldyTjF2NUdhWmw3WnZnRWkvNGZqQnBVZHQ5VjRob05UajhqbG40?=
 =?utf-8?B?SzkyR3Rid1ZWN0RCbUwxQUhoMG9oUGFaRTdrVlFQdyt5K0xPSGF3bjVzT0U0?=
 =?utf-8?B?TC8zVlRJaUxmYnZWQzkrMmFkK3hsNVM0N29xS2pZamVHeWgzZmt4UldleHlN?=
 =?utf-8?B?THozT0hTUlVzTkQvRnJVUVVjT1JHM01tZ3poMllwWGxKNkptZ2FKNE5NS0k2?=
 =?utf-8?B?TUxqMjdWSVlwMDFwajcwdU9XZjZNUlRIdExOa3dtL1gyQzRmMENjMVBGVGU0?=
 =?utf-8?B?SG5GbGxRbTZqZlhnSTdYK1VXaXVGTll2b1ZpT0gzSC9YSGtPK01kSzg3SmxD?=
 =?utf-8?B?eWVSejdpSXRKUjN2dTRLdzdLL2hLZklONllLak5jOW50U09zRkhZakZ0RVk1?=
 =?utf-8?B?djg5WThuQWMySG9VWGxIS21iN1k5TTFIVjBQcG1CQkJtNmxCL3BrOUo0eHVW?=
 =?utf-8?B?RFlhK1YyZDQrZ0hSOFJMRkYycjJrVEN5bTZSekFIUUtFUytKSU9lZHpEMlBy?=
 =?utf-8?B?WU1tc1h4RXh2RUUxL0lPM3ZwTGUvQnlzcnpWM2d6V01PbkxCZmdYWW1tY0NX?=
 =?utf-8?B?ME51YVFPTm5UUmtlSUw4QUxnc2lBU3p1V1NsbHE3dlVuYVRnK2lBR3pOY3Vt?=
 =?utf-8?B?RHVsdi9SSlJMQXM2Tm1lL0tGRllUd2FWT0J0TTZsNTZNeGppNkhVNzA0M2ZM?=
 =?utf-8?Q?OxZnPrbvpBkI9bNgeAyF1ObOo?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 845f1d22-c66a-468e-0387-08ddcf7e9c98
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 15:34:45.7791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXmXMOhvj0lkwyNyhAij2tMcpVNb/CmHTFz784DynTkw/OnmqXnlKPLhs+JEM6hyeW0ZoVjo1huefpAK92jv/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P195MB2081
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



On 7/30/25 5:26 PM, Tom Rini wrote:
> On Wed, Jul 30, 2025 at 04:12:48PM +0300, Wadim Egorov wrote:
>>
>>
>> On 7/29/25 9:36 PM, Bryan Brattlof wrote:
>>> Hello Everyone,
>>>
>>> The AM62Ax was created right when TI was shifting to their high security
>>> (HS-FS and HS-SE) processes. During this transition a small subset of
>>> AM62A parts where configured to use the old "GP" security for internal
>>> and for select groups of partners but never sold for the wider public.
>>
>> I guess I will need to update my hardware to an HS-FS device :/
> 
> Did these chips then get sold to the wider public? Or just distributed
> within phytec? I'm wondering if we have another i.MX95 A0 type situation
> or not
> (https://lore.kernel.org/u-boot/PAXPR04MB96443299A51764EE05533DE0E224A@PAXPR04MB9644.eurprd04.prod.outlook.com/)
> 

I am pretty sure I got a super early prototype for bringup. AFAIK there 
are no other SoMs with this revision in the wild.
