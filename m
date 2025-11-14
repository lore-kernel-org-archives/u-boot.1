Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787E4CE8D4F
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 16:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A44A88416F;
	Fri, 14 Nov 2025 17:05:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ZxIUUvjk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C293584184; Fri, 14 Nov 2025 17:05:23 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AC058415D
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 17:05:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3413684226=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AEFeu2B2602845; Fri, 14 Nov 2025 17:05:19 +0100
Received: from am0pr02cu008.outbound.protection.outlook.com
 (mail-westeuropeazon11013001.outbound.protection.outlook.com [52.101.72.1])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4adr7pbtuv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 14 Nov 2025 17:05:18 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6OoDt2rrvSmWiRIvIc7Bc9dAgOq+TPpwj7FUcff0iX051Glh2d8XXSXSw/cjQ3I1GwmpDCG8aJAA9dlodPkkI5+9hyyaGlebAjaZOzrJ//zDgTER4384TDAMi3hbd7P+YGxGcxwdRoAKnhBnezsgMEhvGODsZ8AlSzMTOh8wBshmPTXPcFrBI+xNYGjGmvX9WMu6Pl18L08SLuJRW1R7QbwZUo/GuQ1cEscPDL7LA/doYqoseIHnYnJ36JwHt+Y3YtAqTfoXiBEe7LFat3OF88AxntT16RdXUBQDFp7rnVTizaoVY29YVIhhULxrGL4lMIEygcf5P9K6R9h33lFgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RZ9/BGO1BQyNOT5A/EjMvC9f0VZ0zHL+WbzhSff2bI=;
 b=xSu2FeXhjBIdGEfOJ99AgaPsOEq4ZRpwbiFz0LVn3QAQnM6H2RmJmaCX7MSGpfFX3tGtAzGJ3KnGArRWsr6KwSUgPw57h0toxBnivHEW7KWjepJ7jQDh6wL92kynlOvsrzBCIo/fmFv+pWvyweD5GGNSTAsJLlMCzsKsxPwZ8nr3PcsKN6pEMutaBy8SJmk2SdMSYJmz1ahbgqK3e1VVG928zfjuR4tWekiSKrqGDyqWq2P7Ll9EN+55w1MbMYL2DprNy7IIUvB5jxM+bI14K/BmGncVIvZ3MdApfsASDDts0LTsettCzHeM/czc+v87aFjaKP8LR4BW9xVGAFMvVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RZ9/BGO1BQyNOT5A/EjMvC9f0VZ0zHL+WbzhSff2bI=;
 b=ZxIUUvjkp0/qeoM2JJnrMnQhchNM02sz99HQYSSIACeq4gbn+X3ot7QSLvol/Ejvr4KAHaNbDKltDPCD5gI0r8dgK58q6Y7289+iivFRD3IS7ZV8i5zIHiTT+bYIco6pyWmbqEATbBIjsInRTD93nfFnJf3Rd3RfDPE9rClUkRfH6qzBZr7T6tL9Y6FGJM8bFeP0DkkSU08URIoSrmKkVRvpjwW/iqhzBwpiGLDt7x1SXuoLQrLS6S16AOCHPyZlokSUiw8eEYaOhHClbg4Rl551smM2cXbGYDj8ZEFBlVWgSZWc7zOwSrURH4gB+tcNe2OjAT2Xu7FKezQn2eIx3Q==
Received: from AS4P192CA0025.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::19)
 by VI1PR10MB8230.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 16:05:11 +0000
Received: from AM3PEPF00009BA0.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::bb) by AS4P192CA0025.outlook.office365.com
 (2603:10a6:20b:5e1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 16:05:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM3PEPF00009BA0.mail.protection.outlook.com (10.167.16.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 16:05:10 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 17:05:20 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 17:05:09 +0100
Message-ID: <c931c566-a2b8-424d-80d3-b5130e3ea8e0@foss.st.com>
Date: Fri, 14 Nov 2025 17:05:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] adc: stm32mp13: add support of adc to stm32mp13
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Tom Rini <trini@konsulko.com>
References: <20251009152610.300154-1-patrice.chotard@foss.st.com>
 <20251009152610.300154-2-patrice.chotard@foss.st.com>
 <10609ea2-d2ee-4e0c-bf9c-1178e67a5776@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <10609ea2-d2ee-4e0c-bf9c-1178e67a5776@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA0:EE_|VI1PR10MB8230:EE_
X-MS-Office365-Filtering-Correlation-Id: 632d70e6-f29f-4535-a9b8-08de23979655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WlMwRXBNNHdhclBnb2xTQ0tPT1pnZDBEOTRIR3RuOG1Rc3NRY3ZhSXVrdHRu?=
 =?utf-8?B?OWwreEljNXlFYUZva2NCUDVSMW9jSVNPRVNqVDJkZXdKOXFtVmUvSW9Dbk1w?=
 =?utf-8?B?N3JsenhXczV1d2I4MG00ZmY5Yk1kSVY4Wmlzb2FyL28zLzdMWE5SMGc1Nlps?=
 =?utf-8?B?dGtBZkwycVIveEZMb2l1dHpNalJOTzZFME4ydkhBS2lXL3dJZ1IwMWR6NkZo?=
 =?utf-8?B?WlRSbkxITi8zM3BKRUV0aDZPTDNzR0R3b2IrS0ZLU2lxTWFhaGxzU1hoZjYv?=
 =?utf-8?B?L2swcFFiNWpXVmlhMW9LT3VjbmtHYUxqbGIwMHU2aGdwaXhFQXpTQVVKUElR?=
 =?utf-8?B?NDI1OTdET2oyMUNjSjVMQ1MzcEUwTGRJU1hJVC9nTFY0b2M0clg3RVNWTG54?=
 =?utf-8?B?VHIxZGJDS0dIS01kdGRMR0pnMWxsdFZYaFlhcVYvS0RSbTYydVppMzZKNDM1?=
 =?utf-8?B?L3l1OGRqcXRuYk03L1ltU01MZTd1dUtVRGQ2bWdMTFJHaGNlSzM1SlJBY0g2?=
 =?utf-8?B?WnprK3hWRGFmU1l2MXZSNEE5eUhyZmVHMWRJY01TcXZoTVVzbm5rZFJZWjIx?=
 =?utf-8?B?ZGVUR3ZCbHQ0SE43b29DaVRrbkVvUkQyT2l0MGdMZ2Z6Z0gzUzB6OWgxeFp4?=
 =?utf-8?B?MStxMUZ5ak1BODNjOXhRc0E0MXAyVS9BTXJSU3Uvb1VZcDBaZGROankwb2JF?=
 =?utf-8?B?TkRUUzRIYkY0MTErbzVacWQ2QUVRcERweGxDU2tOdkNpaFVZY1hqWlNBZmtV?=
 =?utf-8?B?bmFFVVIvUHZMQ09OMHQ0Y00razlGQlpWdHVQakJZL09WNjFxYWRveXBYaFlH?=
 =?utf-8?B?dmEyckExSDZPQjMwcEJnc05TOFo3VHAySG11cjA4QTU1VE1PbFV5SzlCOXo0?=
 =?utf-8?B?MUlWeDdpWmlEaVJncDNUOXljUXA2bzdabUd2QmJQYzVyd280N0NNRG9pWi93?=
 =?utf-8?B?ajltbXNOQnkvTUJHSmlRcG9iZHJsUW0vMzlEQzlZZ0d1S3VoSmtRZjU2am9U?=
 =?utf-8?B?UWJrNHRvVm9TNVRqRUFWMnpycVMvTnNQc1BzL0c0MTZGSjdPY2VjUWRvMjBT?=
 =?utf-8?B?MnR3TERzV0xXeWppclBveEYybW5vNkExZVNQQ09odFAzZEpBMWVicitMeHJI?=
 =?utf-8?B?Q2FUUjFyMUk2cFZKaGlMTVJrQmFwQTdDemU0emEzOEFjS3lhZW5ZTkRLVXNX?=
 =?utf-8?B?NndaS1RxNDZ5emFiajVGNUdwK3dYeUd3WDFSNm93aWpib1NNKzNXenVsTVc1?=
 =?utf-8?B?SEhBMXdXY251T05DaUFwV1hOTTEzMVBCenIrbllIcHludEFFK3Bydzc3SG1l?=
 =?utf-8?B?ZFJMK0N1RjE2WDJDN24wMzZKSzRQcHVscEZJalJlNldrWjEzWjF3dUV2WWd2?=
 =?utf-8?B?YW5HYXphSnZJdm1ic25tWGdRVWM1cm8zYlZtVUNyVEszUW1iejQ4OU5EaEhq?=
 =?utf-8?B?RFE2OExZVWNodlBldmM1WnZyNjFHMkpENkY1NjllSzFRd3ZRc2xxYWpNUjJC?=
 =?utf-8?B?WE9iWVVORUs2bWNFVW5kQlhmMTNVOFFlQzFVM3k2TGxveW9WaHh6cDZqbTlV?=
 =?utf-8?B?S2VYc3YvWlZKUG9MUUJZcjNhWEpMKzVaUG84VFlKQnlQVC9xN2RwUXhTeDBT?=
 =?utf-8?B?RmJCa25yenYvTDRCSEJ1WGZycWpMSUJuaXZ2NlpGT0RTbWdpMTVLTWkxeHgv?=
 =?utf-8?B?WUswMVNFT0RJNlJvOWJDT2h0OHZYb2JBeXdJSi85MFlaV3NFVkdBYmdPc0pD?=
 =?utf-8?B?WlZnOW9DTWFnaW1NalJSbU5KdlRHT0d1VWhnZFQwK2dOQk1uK2w0NW5WZUtl?=
 =?utf-8?B?L2E2QzlPenIvTTVpYmVuRmpPSVJSUk5NVVQ0UC9qSm9OZjNDaTY3ellKdFNH?=
 =?utf-8?B?YWNGdnQvV2xQVkRqODN1dFNmM2pxL3pkTHRkNzBTdHNiczladFlmbkpaY1Nh?=
 =?utf-8?B?LzBCTVdSMFFHVXlqVDRsbjhzK3FiQjJQY29lM3AxRmtqcnBtRXpLOFpMSG1o?=
 =?utf-8?B?aGp6anZRenYwdEFUUzJGNmRLNTI0TlMyMnl5aUJRNlNDNGlkWEc4YTJjY0JD?=
 =?utf-8?B?YXAveDlmRUszaXRkaWVMVFJNRnUrT1VOSzJFZlpKcGRKMExMTUlDYmRaZTdL?=
 =?utf-8?Q?9Az4=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 16:05:10.1560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 632d70e6-f29f-4535-a9b8-08de23979655
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8230
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDEyOSBTYWx0ZWRfX0wS4WhUbOIOx
 mxWcbR0wJ8ezIljIuR631ulzol1tZB/V/ZmLnItE5EJT3eJ/1Ikbw7XG/ab9Ku3U5GQV1uYMNr4
 z1TwmFHBCMO3oQqdd80QyPeR92z6LdqmowT/dKDsW0774i06ni/Jtv/8ZqpAsdklx+wzOlKoP27
 Qe/zagOltONBO29phE5G+E8M2g+fpSyR6T8h8oBFdTOZgPt7iGy/ab8HYJ7RNUGdKhhmKe3h5kC
 vmOtV/J5OA5I6BGcrXNrltrRQfxjq72CXI2cSVGFm8eojmCquEJm7xQSuUMKl4AGw3pNC1Vkens
 m+nRIiqaClOS0ClKyl2isbvb+xNprx65Es9N/HWLXF1Tkw2i+EKaZd4d3Nrh5+XPq0pwWL5QqVS
 RXYY6q86bFmJ9uxpSMlheVpSIEaUwg==
X-Authority-Analysis: v=2.4 cv=avi/yCZV c=1 sm=1 tr=0 ts=6917533e cx=c_pps
 a=U9/24nWfJo5LsBcH4C/8Zg==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=eN9v4IUx9Y8VbzdPR3wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-ORIG-GUID: Dq1AHObCVoqAJnKqAMlBg1fUg1pumL4N
X-Proofpoint-GUID: Dq1AHObCVoqAJnKqAMlBg1fUg1pumL4N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140129
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



On 11/13/25 18:59, Patrick DELAUNAY wrote:
> Hi,
> 
> On 10/9/25 17:25, Patrice Chotard wrote:
>> From: Olivier Moysan <olivier.moysan@foss.st.com>
>>
>> Add support of STM32 ADCs to STM32MP13x. This patch introduces
>> stm32_adc_regspec structure, as this is already done in kernel
>> driver, to manage smartly the differences in register set
>> between STMP32MP15 and STM32MP13 ADCs.
>>
>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   drivers/adc/stm32-adc-core.c |  1 +
>>   drivers/adc/stm32-adc.c      | 79 +++++++++++++++++++++++++++++++-----
>>   2 files changed, 70 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/adc/stm32-adc-core.c b/drivers/adc/stm32-adc-core.c
>> index af340b8b273..3446e34fa46 100644
>> --- a/drivers/adc/stm32-adc-core.c
>> +++ b/drivers/adc/stm32-adc-core.c
>> @@ -200,6 +200,7 @@ err_aclk_disable:
>>   static const struct udevice_id stm32_adc_core_ids[] = {
>>       { .compatible = "st,stm32h7-adc-core" },
>>       { .compatible = "st,stm32mp1-adc-core" },
>> +    { .compatible = "st,stm32mp13-adc-core" },
>>       {}
>>   };
>>   diff --git a/drivers/adc/stm32-adc.c b/drivers/adc/stm32-adc.c
>> index d50f00f1233..808c3c610f8 100644
>> --- a/drivers/adc/stm32-adc.c
>> +++ b/drivers/adc/stm32-adc.c
>> @@ -49,16 +49,35 @@
>>   /* STM32H7_ADC_SQR1 - bit fields */
>>   #define STM32H7_SQ1_SHIFT        6
>>   +/* STM32H7_ADC_DIFSEL - bit fields */
>> +#define STM32H7_DIFSEL_SHIFT    0
>> +#define STM32H7_DIFSEL_MASK        GENMASK(19, 0)
>> +
>>   /* BOOST bit must be set on STM32H7 when ADC clock is above 20MHz */
>>   #define STM32H7_BOOST_CLKRATE        20000000UL
>>   +/* STM32MP13 - Registers for each ADC instance */
>> +#define STM32MP13_ADC_DIFSEL    0xB0
>> +
>> +/* STM32MP13_ADC_CFGR specific bit fields */
>> +#define STM32MP13_DMAEN            BIT(0)
>> +#define STM32MP13_DMACFG        BIT(1)
>> +
>> +/* STM32MP13_ADC_DIFSEL - bit fields */
>> +#define STM32MP13_DIFSEL_SHIFT    0
>> +#define STM32MP13_DIFSEL_MASK    GENMASK(18, 0)
>> +
>>   #define STM32_ADC_CH_MAX        20    /* max number of channels */
>>   #define STM32_ADC_TIMEOUT_US        100000
>>     struct stm32_adc_cfg {
>> +    const struct stm32_adc_regspec    *regs;
> 
> minor replace tab by space before "*regs"

ok

> 
> and it is strange to use "struct stm32_adc_regspec" before to define it
> that can cause some warning with compiler ?

no compilation warning was raised by the compiler, but ok, will move 
"struct stm32_adc_cfg" below struct stm32_adc_regspec declaration

> 
>>       unsigned int max_channels;
>>       unsigned int num_bits;
>>       bool has_vregready;
>> +    bool has_boostmode;
>> +    bool has_linearcal;
>> +    bool has_presel;
>>   };
>>     struct stm32_adc {
>> @@ -67,11 +86,30 @@ struct stm32_adc {
>>       const struct stm32_adc_cfg *cfg;
>>   };
>>   +struct stm32_adc_regs {
>> +    int reg;
>> +    int mask;
>> +    int shift;
>> +};
>> +
>> +struct stm32_adc_regspec {
>> +    const struct stm32_adc_regs difsel;
>> +};
>> +
>> +static const struct stm32_adc_regspec stm32h7_adc_regspec = {
>> +    .difsel = { STM32H7_ADC_DIFSEL, STM32H7_DIFSEL_MASK },
>> +};
>> +
>> +static const struct stm32_adc_regspec stm32mp13_adc_regspec = {
>> +    .difsel = { STM32MP13_ADC_DIFSEL, STM32MP13_DIFSEL_MASK },
>> +};
> 
> minor all this block can move before "struct stm32_adc_cfg" (when used)

ok

> 
> 
>>   static void stm32_adc_enter_pwr_down(struct udevice *dev)
>>   {
>>       struct stm32_adc *adc = dev_get_priv(dev);
>>   -    clrbits_le32(adc->regs + STM32H7_ADC_CR, STM32H7_BOOST);
>> +    if (adc->cfg->has_boostmode)
>> +        clrbits_le32(adc->regs + STM32H7_ADC_CR, STM32H7_BOOST);
>> +
>>       /* Setting DEEPPWD disables ADC vreg and clears ADVREGEN */
>>       setbits_le32(adc->regs + STM32H7_ADC_CR, STM32H7_DEEPPWD);
>>   }
>> @@ -90,8 +128,7 @@ static int stm32_adc_exit_pwr_down(struct udevice *dev)
>>       /* Exit deep power down, then enable ADC voltage regulator */
>>       clrbits_le32(adc->regs + STM32H7_ADC_CR, STM32H7_DEEPPWD);
>>       setbits_le32(adc->regs + STM32H7_ADC_CR, STM32H7_ADVREGEN);
>> -
>> -    if (common->rate > STM32H7_BOOST_CLKRATE)
>> +    if (adc->cfg->has_boostmode && common->rate > STM32H7_BOOST_CLKRATE)
>>           setbits_le32(adc->regs + STM32H7_ADC_CR, STM32H7_BOOST);
>>         /* Wait for startup time */
>> @@ -134,7 +171,7 @@ static int stm32_adc_start_channel(struct udevice *dev, int channel)
>>           return ret;
>>         /* Only use single ended channels */
>> -    writel(0, adc->regs + STM32H7_ADC_DIFSEL);
>> +    clrbits_le32(adc->regs + adc->cfg->regs->difsel.reg, adc->cfg->regs->difsel.mask);
>>         /* Enable ADC, Poll for ADRDY to be set (after adc startup time) */
>>       setbits_le32(adc->regs + STM32H7_ADC_CR, STM32H7_ADEN);
>> @@ -147,7 +184,8 @@ static int stm32_adc_start_channel(struct udevice *dev, int channel)
>>       }
>>         /* Preselect channels */
>> -    writel(uc_pdata->channel_mask, adc->regs + STM32H7_ADC_PCSEL);
>> +    if (adc->cfg->has_presel)
>> +        writel(uc_pdata->channel_mask, adc->regs + STM32H7_ADC_PCSEL);
>>         /* Set sampling time to max value by default */
>>       writel(0xffffffff, adc->regs + STM32H7_ADC_SMPR1);
>> @@ -156,9 +194,11 @@ static int stm32_adc_start_channel(struct udevice *dev, int channel)
>>       /* Program regular sequence: chan in SQ1 & len = 0 for one channel */
>>       writel(channel << STM32H7_SQ1_SHIFT, adc->regs + STM32H7_ADC_SQR1);
>>   -    /* Trigger detection disabled (conversion can be launched in SW) */
>> -    clrbits_le32(adc->regs + STM32H7_ADC_CFGR, STM32H7_EXTEN |
>> -             STM32H7_DMNGT);
>> +    /*
>> +     * Trigger detection disabled (conversion can be launched in SW)
>> +     * STM32H7_DMNGT is equivalent to STM32MP13_DMAEN & STM32MP13_DMACFG
>> +     */
>> +    clrbits_le32(adc->regs + STM32H7_ADC_CFGR, STM32H7_EXTEN | STM32H7_DMNGT);
>>       adc->active_channel = channel;
>>         return 0;
>> @@ -206,7 +246,7 @@ static int stm32_adc_selfcalib(struct udevice *dev)
>>   {
>>       struct stm32_adc *adc = dev_get_priv(dev);
>>       int ret;
>> -    u32 val;
>> +    u32 val, mask;
>>         /*
>>        * Select calibration mode:
>> @@ -231,7 +271,10 @@ static int stm32_adc_selfcalib(struct udevice *dev)
>>        * - Linearity calibration (needs to be done only once for single/diff)
>>        *   will run simultaneously with offset calibration.
>>        */
>> -    setbits_le32(adc->regs + STM32H7_ADC_CR, STM32H7_ADCALDIF | STM32H7_ADCALLIN);
>> +    mask = STM32H7_ADCALDIF;
>> +    if (adc->cfg->has_linearcal)
>> +        mask |= STM32H7_ADCALLIN;
>> +    setbits_le32(adc->regs + STM32H7_ADC_CR, mask);
>>         /* Start calibration, then wait for completion */
>>       setbits_le32(adc->regs + STM32H7_ADC_CR, STM32H7_ADCAL);
>> @@ -394,14 +437,28 @@ static const struct adc_ops stm32_adc_ops = {
>>   };
>>     static const struct stm32_adc_cfg stm32h7_adc_cfg = {
>> +    .regs = &stm32h7_adc_regspec,
>>       .num_bits = 16,
>>       .max_channels = STM32_ADC_CH_MAX,
>> +    .has_boostmode = true,
>> +    .has_linearcal = true,
>> +    .has_presel = true,
>>   };
>>     static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
>> +    .regs = &stm32h7_adc_regspec,
>>       .num_bits = 16,
>>       .max_channels = STM32_ADC_CH_MAX,
>>       .has_vregready = true,
>> +    .has_boostmode = true,
>> +    .has_linearcal = true,
>> +    .has_presel = true,
>> +};
>> +
>> +static const struct stm32_adc_cfg stm32mp13_adc_cfg = {
>> +    .regs = &stm32mp13_adc_regspec,
>> +    .num_bits = 12,
>> +    .max_channels = STM32_ADC_CH_MAX - 1,
>>   };
>>     static const struct udevice_id stm32_adc_ids[] = {
>> @@ -409,6 +466,8 @@ static const struct udevice_id stm32_adc_ids[] = {
>>         .data = (ulong)&stm32h7_adc_cfg },
>>       { .compatible = "st,stm32mp1-adc",
>>         .data = (ulong)&stm32mp1_adc_cfg },
>> +    { .compatible = "st,stm32mp13-adc",
>> +      .data = (ulong)&stm32mp13_adc_cfg },
>>       {}
>>   };
>>   
> 
> 
> only minor  remarks
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
> 

