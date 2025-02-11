Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F5CC021A1
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 03:47:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BFF5803CC;
	Tue, 11 Feb 2025 04:47:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="ijXV9tBZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DADC4805D7; Tue, 11 Feb 2025 04:47:09 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20731.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::731])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDD9E800CF
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 04:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=En9cnA1bDsprJtxxKbDhVF/ESUvQ1ecsL0i2F5sHemdubB4xpKl88z/R+koSLfGVyGRGF2cp7vpcT3wLAwMYVGVGsD2sxoAJn9E/k9FahBl8MMsIkXEoSX20LX6wKY4qZDOLN0kLhR5F4YRg2Ij32n5PRTOyITbWcsyL9oh8kzClzEsAhpPwC03DlMbV/go31Jw+QUCBS2Qz7uol4rUFlqyAGaVELzEQLMNNLvh7Mg+uwZgfpnBzmnsTVvv1mMqMz2u0lQ9JrUpIlwFk0GI+Wa30J5HXe6F9WNhC+n6BYcib8os4uyn+6gTiFB7Mkn/ozi7QbpweeMkbGz3OaMFCjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BVPHFdD45Shmw13qxAr/3WTcToQQRI1BDIbvim3u9o=;
 b=HqWJUnPKDaOnMsrCAwqApaXtMN/08LYj07S/bhZmCA5RnWtmFElYvw2Pq41xp9V12852MDhMSmtNCWWfINMNT/RY4C8jIoRxxbiMEEJFFEl5MLxZF2pyVamIWCBCYAp0nNVJqvvzgWWjIrUAL6u2UdCOGTxoCKgKvLrPC8NiTnBBWL5z/D0bj3tln7gUd7McWElPT7Ezyli6ep6kdlC16eVfHO+O/ww6705RF/agYwEUe2547clhnZh+lpJpI6ekRrcj76jnbvFov5UE778X3xJeMxlodqz65dxaQHr/rHP94h0cxWTyNCXaBE2pXg5Kkfks8wVkyu8IELlWG6YOow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BVPHFdD45Shmw13qxAr/3WTcToQQRI1BDIbvim3u9o=;
 b=ijXV9tBZvcXSkv4wgTID45RozXC0ITkmHrVrEcCkQs0vE0dBILJIySSNvHGO0ye5ceVHGl0tvpr+hvYAbG2CeTO/w6tYwFbmNomOQG0mce/ruVM8W8c4N3Y03iEiKB+IZigkJ1p6GNJ8y7IUJFQM7QCAiRwAqsaRAT6JjdufJ/AwSg+YMF8hPaCinA1aA3b2fkmoGTHZL8uXxI+cspkvxVuvfXU9pT9X1QGhEGpSVR7JyQR9t2zN4C3G8oD4axe1EgFq3x52A5RNpakwlyHkdc4/WrtaU034gb+Kqug9qXrb+VRnehGP1ltQK45iwoMJvKPwdbMuWrdUD2mv5/38qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by DB9P195MB1779.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:39b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 11 Feb
 2025 03:47:05 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 03:47:04 +0000
Message-ID: <810fcc04-c889-4f9b-a79c-3253b22287a9@phytec.de>
Date: Tue, 11 Feb 2025 10:46:59 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] configs: phycore_am64x_a53_defconfig: Enable
 ENV_IS_IN_SPI_FLASH
To: Daniel Schultz <d.schultz@phytec.de>, trini@konsulko.com,
 u-boot@lists.denx.de
Cc: upstream@lists.phytec.de
References: <20250210152548.1263498-1-d.schultz@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250210152548.1263498-1-d.schultz@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:820:c::22) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|DB9P195MB1779:EE_
X-MS-Office365-Filtering-Correlation-Id: 050afe9e-d877-4c19-b713-08dd4a4ebfe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Umw4ZitTZk9iaDVHMU1kd2I3VzljVTlJOWxTZE9Vc2NhSkxZQjQ1UmZ3K1Nn?=
 =?utf-8?B?Q283OHB0RTNwSm1mYnQ1Smc4ZCtJbGVOQU9IYUExYWhXd1NyWFdBNDgycVlj?=
 =?utf-8?B?Mlg4K0tnWWRxTStnTldJRUcyUXJiZUdtbEZSdWdldTRkakMzYm5WaXdGZUF2?=
 =?utf-8?B?SzQvL3FYOGxiU3NnR2wvOFptWFZ5RllzTDIyTVJjaDhucmpJQlBQT2hIN1hI?=
 =?utf-8?B?VHlGcHlNWDZJMDVMeTNYOHNSVGl2NDcySEptR0FLQnFDalU3VjE4V3VnRmdQ?=
 =?utf-8?B?VnZKNkRLMDk4WjdDSUhoTGhJM1hoZUQxbVlWZ0NYS3dqRnlvblFJbmxrR3BJ?=
 =?utf-8?B?N0FQeWxUT1Rub1dRYWt4L3RodDVUQ25MVmpBMHQrY09ZNDhpWTlIVlJkSUpM?=
 =?utf-8?B?aktyeGZlcGpJYk5rQm5tV0FLSXFzeHV5eTF1dWZhRk9uTlo2ckorQStsci9w?=
 =?utf-8?B?Z2JMVFFtREMyQXQrUFJkSHRpaWd1V2xFZ01SekFST0tZY01BbFAwK1FRU2NC?=
 =?utf-8?B?R1gwcER4ZUswTUkyZjNKU1hyUU96b1ZKangwb01CUHBVOE9BME93cXp0MWhp?=
 =?utf-8?B?M1RkZkIxYVhWMGhRZHN0QTVPMzB3MUNCeFhMcDF5QXRqOEdpdjhKdk1MNVQz?=
 =?utf-8?B?bFphdUhKWk5LZlo1VVZvemR5dVYybyswK0M0NHdoNDk4c0lvTXQwNzh0ajFZ?=
 =?utf-8?B?NTByd05IVGV4L2N3d2Q0SzZMcGUzVXFWZ1NMMXNwNkJYU0pWZUN3alZsdEwr?=
 =?utf-8?B?ejZ1aW95NE5yUjcyZTR4NlExd21lWDdxQm5uR0cxd2t0d0h5Yy9jdndKYlBD?=
 =?utf-8?B?V1U4VXlselFtN3lqZGFnekdEQmtsZkZiNjlha2YwczM1Q1doR2N1OWMvQkV3?=
 =?utf-8?B?aEZmMzh4QjBka2xqdHpLaVhOWGNlOStxQ3AzcTdXTy94TWFndjFOSWZKNDli?=
 =?utf-8?B?b2pxaEFRampEOVdKZ0ttOFJsSmllak1tS0JSSW1Va3FZVTFrdHhzK0EzdHho?=
 =?utf-8?B?ckpMWjEvRFVvSkR6cWFBcG9GWXZMeXF5ZFcxUDZnRjdnbllNWGN4NHBQNldN?=
 =?utf-8?B?aE9tamtTdHBkNnlxeWo2cG1tWWpNcXkwNXhISXFVK04rQjlsb1BqVmZnaDVV?=
 =?utf-8?B?NW1UQnlUaWREOVpkQk4yTnJYZEpKd1lMTDFhWGNPSWpMdndXUFVMdjRmY1l1?=
 =?utf-8?B?QTRpczk5TWx0MkVFdWEySkxMcldnQS9Vb3RDOXpOWGNoRk80ZC9lSmkzZGxo?=
 =?utf-8?B?VDJkTUtRYWVHeWVleG1MbFV1SU1lNlNmazRXbUxVeUNFdERnUW1uWHZtQ04v?=
 =?utf-8?B?QzIyaUNLakZEYS9ISWhlZW9rcXlFL0J6MkprTG00M2lMSDQwNEhMUDVuRXYr?=
 =?utf-8?B?WjhwT2JSOTdTTzlWOGVsRzZGU0VicFR1N3U2dVZrUXpnZ3g1eGJDZTlqY0t1?=
 =?utf-8?B?R2xmMTdSdXNQOHJsc2JiZFZjL0RoNHVsUEpjSDFqQVhjTElub3V6ZmhaRTJN?=
 =?utf-8?B?QlpaN2FZRW5Uc0lVMTYrMFg4S0tFLzAvQTlPcGtTbzBkSFNtYTR1YXg3dys0?=
 =?utf-8?B?SWl0VWtYc0dibU5qcEJKUTVTV0tZS3dBNFZKVWNNTXF5ZUdrampPUkdFeDJP?=
 =?utf-8?B?dWFJNnBCbDBESFdTRTljL1FaSS95eTRNYnB6anB3bHRuLzBybkU4SG1vMi9S?=
 =?utf-8?B?QjRsWnYwKzN6aWNtZXFkWUJPMUFrVi9nMC9IRVpOaExwcDdhZ2loYWhoeVNi?=
 =?utf-8?B?dkxDQzYySHlqZVVod2dEektlMnlvampnMW9kdlN5YU1IaEdCYlh2L2c3YWJJ?=
 =?utf-8?B?N2hxbUdoTGpKTnFBU2RibzhGVXQ0YVBGWkI3ZTMybkVCeVpUbVdsanVzYmtl?=
 =?utf-8?Q?HEhn2TeegOP9h?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUVacHk1eWRlNDN3RmVsekMvNzNxeWIvdzhUek1scStoLzg2NkFrek1VMnBi?=
 =?utf-8?B?R240Q3dxTDlPcUZFVkZ1VkVBaHlkVmphZGdscmhFQUZLQzdWUGowTXE1NHU2?=
 =?utf-8?B?S05ZVE90QmNHV1ZnSW5lNDlHYmovVXpYV29jQVl4bHA0cmI3NGFPdCtIUzdr?=
 =?utf-8?B?cnlBWXJ1VlNJM3BHeTRMZDVrTTc3MHBMY1ZsRExlTWRyb0loaER3NU0yYWlU?=
 =?utf-8?B?VE1udXMyNUlRYVJQcmFZNW13cUtBWXZMQzA1V2lLckU2a1E5emFEZ0x5S2tw?=
 =?utf-8?B?bXByVk1VUXppZUtpS1FLQ1doUXRaNGkyNllLQSs0bGtUb2tUL2dNUHg5NnFr?=
 =?utf-8?B?b3RaSWN4eTdVVmpDeHRaTnB6TE5QdWpsYjNuOTNBVEJBVnIyb0RUbU1ITmVy?=
 =?utf-8?B?SG84WDFEQ3lHb2JNMzZiZ1ErcTdnN0JxT0plMTdWbXpLVlZjaXhtSXRDNTdw?=
 =?utf-8?B?Zm1ObDJ3YmNJUlIyV3dpbVNxZUh4QWsxYTJyOWZQNVZnYnVML3hFMEExN1Rp?=
 =?utf-8?B?ZlJGVHg1N0YyaXcxWUdseTBBZzU2dXc3TGZlLytrbCtiaEp0RFUvM2RQZjl2?=
 =?utf-8?B?S243QllkcERadGh1V0NrazNVTjNDaERJenU4THBYdDFWcit2RGZGeVF1OWZx?=
 =?utf-8?B?M2NMK3dqc2F1WE5pVUp1T3FGSHAyR1QrUGp0azA2TDk1aVpuZm1Tb3dQOE4z?=
 =?utf-8?B?bmxDSUhQNHFwSzBydmI3dUwzS3hPdngrOFhHWEV5WnBsaXd6UVVKeTRtaFBr?=
 =?utf-8?B?UnFYTjlVbFdrcC91SnFhYXVlSjMxVGtDVkR3NjFDR3V4T2dpWW1IRkVQRDMv?=
 =?utf-8?B?WUpzKzUvdTJqZXVVWitYVnozVTRMdnptUXVtcThONXNxbERBSlFTOTVCRHpi?=
 =?utf-8?B?bzEvOXZiQlFsUW5Ib1c0VmlERHJpZ1pGL3NPc2VuVGJBNzVoWDZSN25XaXJG?=
 =?utf-8?B?NHdLQ3hwRG1Zd0hLZitXNHdiajlNRU9UWkRkQzc1MGlqQ1FFNFpVanpRdkI1?=
 =?utf-8?B?RjUvTW9KeVZSUUdpT1oyNHFEMnlkWS80c3VNSE92bkM2ZjluZnlBVk1Yb04z?=
 =?utf-8?B?N2tvZWxiWVE0Y3BMeTB1bDN6R2pDSXNOM2xaeGduaW9kYzVzSVBzYjhCMW5h?=
 =?utf-8?B?WlBSY2pPSm5KckwxWlpXRWFyT2loa0N1YUpWbHNkR1hFMUM5RWwvSjk4VHYy?=
 =?utf-8?B?K1JvSXJ4WFFjRFZ3NG1wWGVZdldseHZaMEJhaEg1UExvWVVzNURKeXVHMTRn?=
 =?utf-8?B?RW0zVTBGTis2M0tXa1cxNE45Y0oycHhqYnR1WUR0dHl1eGpxYjg4eDhxUDdB?=
 =?utf-8?B?T0dRejVTME5sQTl6UHVQYjhYbS9mVlg5ZDltZWJCQ3kvUGdYS3FTMHN3TUEr?=
 =?utf-8?B?MVd4d3VCWEx5c2wzQzh4SlFjVDZJMTE3NEJNb0NrQUpPMndzQTdYamhIRlZ4?=
 =?utf-8?B?K3NZWllDSFFuMHU1L0FPNjY4Q3VZQXp0Z3h5NU1FSnFCMHlSTTU2am1ueWtX?=
 =?utf-8?B?TXdhVm9Jc29ZRFNGTmpCdjFRb3JyRWg2R3RkZ0VCLzdYdmxzMXQrWUthR1c2?=
 =?utf-8?B?Wm1NZmhtdThUbHN2UFBMVVNQajlQalVPdFdnU1lSN1dXL3RmLzV6ejZTTnRz?=
 =?utf-8?B?cmJHZ2hJcFpHVUZuVTJYZ3EzSDZjSlVsaXBMSGJhYTd5cGRiWTMzSkNyVzAx?=
 =?utf-8?B?ZTk0THV2WEx6Z1Y5ZGpYZE8zL3BFQnk2ZTJRcWpGd0hBbW5yTWFQYmVJOWY1?=
 =?utf-8?B?OVdRT3B3RU9mWC9PakE3cXpZSnh5ZmtFMUNDT1kwa1NmMm9qb0hTTHFHMEt4?=
 =?utf-8?B?TXU3V29TOUg3ZDlGdzI0aXVUNFVLeE9VbU5SdTFCTUNyckJpQ2hWWTllS0dC?=
 =?utf-8?B?bEVnQTdrZWxMSGpLWndrNFZXUHh5aUJBK1NHaWVVYXVWZitzb1ZzMWRmRHV1?=
 =?utf-8?B?djhtYjR0N0E5OXhTUUF3OE9vMVo3dkUrM3V1Z0pXRGZwYVdrU2NIRGhKNFRp?=
 =?utf-8?B?eW8wVFczVjA3cnovQTF4SmFNSHBSc0FHWUdFT0JoTzk5Z3NaL1Z5eE9Sdmly?=
 =?utf-8?B?aXFlMXNVbEpzQXBtSDdoMVUxbzM0OVVLL0d0N1M2cGNVYWdjalZLS1pZeTlP?=
 =?utf-8?Q?YdLjZ8eMyO8ISJFFiTThe0Cn9?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 050afe9e-d877-4c19-b713-08dd4a4ebfe8
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 03:47:04.8420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+w90yoP76FX7yf1dtQHII+UHGLqdqRKOMNjky74f/KV1OwOkA7naChPYk6cZ67osOf/1KwKs+TITA64nXa/iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1779
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

Am 10.02.25 um 22:25 schrieb Daniel Schultz:
> Enable ENV_IS_IN_SPI_FLASH to read the environment from the SPI
> flash when booting from it. The oftree, kernel and ramdisk sizes
> are located in this environment and therefore required to boot
> an initramfs.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   configs/phycore_am64x_a53_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
> index f0c7ee26384..4ee1bd829a3 100644
> --- a/configs/phycore_am64x_a53_defconfig
> +++ b/configs/phycore_am64x_a53_defconfig
> @@ -14,6 +14,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80480000
>   CONFIG_ENV_SIZE=0x20000
>   CONFIG_ENV_OFFSET=0x680000
> +CONFIG_ENV_SECT_SIZE=0x20000
>   CONFIG_DM_GPIO=y
>   CONFIG_SPL_DM_SPI=y
>   CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am642-phyboard-electra-rdk"
> @@ -91,6 +92,7 @@ CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
>   CONFIG_ENV_OVERWRITE=y
>   CONFIG_ENV_IS_NOWHERE=y
>   CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_ENV_IS_IN_SPI_FLASH=y
>   CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>   CONFIG_SYS_MMC_ENV_DEV=1
>   CONFIG_NET_RANDOM_ETHADDR=y

