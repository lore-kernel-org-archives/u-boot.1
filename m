Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F980C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 09:12:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2588B86B4E;
	Mon, 13 Nov 2023 10:12:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ztYeB24B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0236D86FB6; Mon, 13 Nov 2023 10:12:17 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F76686B2E
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 10:12:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhHV44eJUi3wyTskzSAMTTaQbGoj0qt5W6L7IlnoFT5CD1kGU2OxE4CMphCp13mA3K4aDP0fSDo9tpn744udo/YvHDudGCDM8Lwq1wXht2zVKnqWxSaE5mb4NyJjzY1DlEAWrYoH76d5k6+MkyVQ8mfrI+XU2hrlBdZJMNmXLSzoU2+ckb5Qsmgs1k0RMAv+MRCoPXzhldla9toz9dMn0VR1MnItRSV9gxn9v/vnIIcbjeA/I9An4nTBN4gpTVbbDmbHdFUm9F0ioHySTksuyngC3AzBNT7111WKb6MbB8ACMrtfBKMu8EJYJsf695svomoplWfAwZT2D8luaBuD2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=508A5cfIi4beBrzuLe1ojVNyL5fWM2Vb54Xyedbcgng=;
 b=WYqiXzhPJoC59MHpaPC2cPzkYeldMDI1jjkRtlEBsAmkimNEunEv04W/c3wseaxKamEWJde584AUtUraqcdLo2Jv6qXROLsEJKnd6UKF+1B96CCXuTbzpvVVNOlf15yWJaMXl05JrNQIfJ8eTGCxccvm3ECmWp5HWsTWCN334suE5TxLU6IT4z3ydTjGuA2gRXs6zXZaGVhIuyEZm9x1sz5L8LTjcorhldaEEIZD1Ik86Qp/eEyK4khSE0h1VDaoFNSuhx8NNHBjkoK5OFylRbeNNJwlFI+eF25OycVFoexyHn6GRCws0b8TVBnQZhMIyHyrLNYCxU7KER6tP/rtFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=508A5cfIi4beBrzuLe1ojVNyL5fWM2Vb54Xyedbcgng=;
 b=ztYeB24B5pK4PS62YhgLaZ9i8wfZdM73naUbs0J1vS4bRMt7p3mKUOqr0qdN5uMAtnRdr+vrrgIXzJXPaAZHAtX39gbewpdHT1VS88ztFIMduORtCs9c2vFhURvUKFcqyCSpIB94IMGD1wPUfcsmXRWUMETdYcS3jzvPtVIFrpk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by MW5PR12MB5650.namprd12.prod.outlook.com (2603:10b6:303:19e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28; Mon, 13 Nov
 2023 09:12:10 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 09:12:10 +0000
Message-ID: <d3933e18-9c33-474c-a69d-a15cfa36bdd8@amd.com>
Date: Mon, 13 Nov 2023 10:12:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers: pcie_xilinx: Fix "reg" not found error
Content-Language: en-US
To: Mayuresh Chitale <mchitale@ventanamicro.com>, Bo Gan
 <ganboing@gmail.com>, Puhan Zhou <puh4n.zhou@gmail.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Shengyu Qu <wiagn233@outlook.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20231111173604.93103-1-mchitale@ventanamicro.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231111173604.93103-1-mchitale@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0059.eurprd04.prod.outlook.com
 (2603:10a6:802:2::30) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|MW5PR12MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: e60355cf-ce55-43b9-f9d1-08dbe4289daa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XqjXe7szwWuvL24orFIhqqy3V/y8XJk3VpfPIrCzc/MSBvIhPc41ZpZUNjPx09Mq4DClM8xejA21pWsDIY7ECQpJshM2vuIiS5WpNm12frM4iSfXkHrYMw5llly+9cOtlBwDVJtu3eB8Mlzj9LLLppUYc+H8pMlVlyhJLVicuKTSNRhusPHIs8wrfBXIKvLLchFwccJHEdVUl8ICrucCE8qVBdVBJMkgfvWoK0INKcqsQn+Ukx0zL8oMQ+j+6XZQXLRqp6VqTBm7vYvnxEcbOt4C2TYSLnNnDDRIZKA6D8WoYsVO0q6eVEBidKSllcThUo8o4EayvrZepjHxTSaiJXA+8laGceuvco0e0lET1DFoObv1/1P//IotwQEugY4SzIKtbrVgfHVwlL3nR+MLyPZ21S0YbIN7aLKB1ywztVVJCSxrY/zeRrnbHMnEAp9MYHTbZfbUT9h8HYcAs9/O7lKZBwFVMYp9qE8DSbY2Qz0RgxmAYRjBHKgz9JFHWohHqFF4ELx22hELYhPJNrKpyFfNyJaiTmTMJPa6i2Umprqx1HYw2Kshkb5gBSO8biNQFiEd/mVfxW2VpFldLQIqHqJBea+ApU5S7A9px6N3Hsql1wI2E6oL9jEUZiLUO428hGiWGLeGYi8UO0tAz9LbKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(136003)(396003)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(5660300002)(7416002)(41300700001)(38100700002)(110136005)(558084003)(36756003)(31696002)(86362001)(2616005)(478600001)(26005)(6666004)(6506007)(6512007)(6486002)(4326008)(8676002)(8936002)(44832011)(54906003)(316002)(66946007)(66476007)(66556008)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEpLdUdZaVNxNnVyWGFKUkI0TkkrZzdEVnJ3bmFTUm1ORHRHS3JpVitaUUtl?=
 =?utf-8?B?S21aTW1sRmRLcHpKZ3BiM1FoaUxhcnhtaXRiRTNqRlRZK2J6NDBLTzhLRFZG?=
 =?utf-8?B?NTN0elNUcE5POW5IOWY1VFdBYnFTWEdObk5FYzREdk5zd1UyR1JoNVdGaVhY?=
 =?utf-8?B?MkpFVkxpK3FHTmFNUVdNVElWMTIxcHpQUmhTelBmdkhFeWxOZXRrdzR6N2xW?=
 =?utf-8?B?dm5EOUJaZzBKdDFweU9aR3h2TU1IbGd2czdIbTN1dmlVNGRvSFcvN3NPVkEr?=
 =?utf-8?B?L04wSVBSV1pMYUdkWlB4eG4rN1RJK0tudFQ0bDJlY09OYkd5MHdUUS9EbmZQ?=
 =?utf-8?B?N3hsSStHclNQTm1uQ1FnNUNKVFZva0YvS0diSE8rTFJqMlRPcW1ScXoxOWlM?=
 =?utf-8?B?NHpNbW8zaVRJcHRsMmFyMWxjUXY4SnF4eDl0VWxCYXppMFVGVDU5WGpoSHNF?=
 =?utf-8?B?bldXZ21admpSbVViZkZXTUVXa3lGbXZKV2UwZ1JtQ1NzZ1pZb2U0YlBtWVhr?=
 =?utf-8?B?NnlvTHNZb2hwNmZLZjIzblJZZ1dVQ0d5SDNqaWJERExOZXdaeUJwbnhlL1lC?=
 =?utf-8?B?bGs0cGlTL2hzUERndlBVb1JyV1ZYeDMyMXJpWDdHUEc1clNLTFlQTkVXckRI?=
 =?utf-8?B?WXJvV25iVDVDRkZUT1J5MGhGdzFmMXVad1ZDR0dOU3UveEFTZlBoVGljSGsz?=
 =?utf-8?B?V2RkWnJsOWZFQkhyejFkUXJOdElzM0xRejFjN0hkMnJ1ZGsxU0VFd25FV1RD?=
 =?utf-8?B?VjhpMDZ3eU9JdGlZcjVVcmJMWHBtNFlCTXdhd0Y3NkhieGxvZTR2NEoySWJk?=
 =?utf-8?B?dGhIcjEyOG5MVyswVkRSNEh4NkkzZVVkcGw5d1gzbUlCM2syMXJCU0VLbDhV?=
 =?utf-8?B?S3RselJqN0k1ZEt1VkNmelorbEtLSkJaelprSDdKdUdaZWxvV1FacU0xcVBH?=
 =?utf-8?B?WmhsZWFXVHArUnpsQndyeVU5RjhYSmFmRUFRRkVPd1pWaGVMOWJNUmNXL3Bk?=
 =?utf-8?B?T0p2M2VrOHU1RVdNQVdNcmZ0MDRaS2dEYzZHMmFUV1ZjdDU2eGVPdXlGTjB4?=
 =?utf-8?B?N2Y4RjlUN0dFaTE5V25lSk14WEkxYkh3UVAzbTdBODRWeE5VNkNNd0QzYnBu?=
 =?utf-8?B?bFhWeHVNZWozWkRkY1c5OHVYaGZ3VWsrK2haRTF6aXYxT3RORldoLzVZbStU?=
 =?utf-8?B?bWRsMXF2Mk9jWFNBMVByMEFVNGVpWnZRV28wSkkrQWMveEQrRUo0eS9jamo0?=
 =?utf-8?B?RHRrc1dMNnpjQ1AyWlpFZDQ0NWt6MUVHdzlPcVFlS0xwZmcrWlk0NWkzSHl2?=
 =?utf-8?B?N2xObGswL2hGeWpXV1JLdFBHZTZ3bFFyWjdEZDlFK0QzbXZ1dG10R1BVMFRB?=
 =?utf-8?B?QkErV2J6SnFtL09xNm9MclZqM1FFTjM5WjBhU3hwZGlQODZ5V3ZiQlFrS3RC?=
 =?utf-8?B?Mmt4TWsyK0tyeGdEWXR1M2hsTHVDdjJNdkkrLzczdVBudm1nZlZKSmZKVXhk?=
 =?utf-8?B?NmNWSHpja2lXMHIwNXhXcTRnSVhjL2ZzaUNJREhXcGducE9QZmJ2cGRaSVBi?=
 =?utf-8?B?NVRrQ016K0M0cmVZNXZpQlhJcSs0SitycjVocEcySGxzMkhKNVkvMGhpUCtH?=
 =?utf-8?B?ZTVQRG5uUThmZzkrQWsxekM0M3VHZW9oNmJQR2lOak1pcThEeFlwdkVrZHUx?=
 =?utf-8?B?YzVRY1JmOHVDMVVxN2dGb2xxUEtFZWxzVmxVSm9UenZidUpaZGpPOWlKY2ts?=
 =?utf-8?B?NFJjSEM5Z00vY29Nb0ZtUHFhR1lyM1AxNE9mekVMRWZlL1lSVXZQTXowMnNv?=
 =?utf-8?B?Tmx1eTdHZFEwRit4OFlldmhNbzhkZVlybUdEVFlYaXlDRjhXVVhYUlBKMjRE?=
 =?utf-8?B?RmxuQWQzaDZCM0xUSE1DM1BPMStGeHRkRUJ6ejFDYm5CRVlNTi9UQ2pha3Bu?=
 =?utf-8?B?MjN2OUkrblNsSnIzajhGampwclJQOHBtbDJYVFJtVzRSVVRSQ0ZtMzVKOUY3?=
 =?utf-8?B?Wm5OUm01VktxNExKbDhvb3RGOHE2UTYyQmpiemQ2T1N0cjNxSXlpbEtVdDlw?=
 =?utf-8?B?ZVcvc0FBUWFHaytKMDR3RmMweURHdEFtWlZoTTNTamN0UXVUdSsrbDVzT2o0?=
 =?utf-8?Q?e4NE3s8SIBiLv78rgSK8vC5sv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e60355cf-ce55-43b9-f9d1-08dbe4289daa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 09:12:10.0529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WxxFbmOzkAEBDkTv1fQ8sdBYkYP8AbKDEe4s3fgIpg6Tl6LHUrmoJGzEZKi0122
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5650
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

one more thing here.

Subject of your next patch is
[PATCH v2] pci: xilinx: Enable MMIO region
and here you are using drivers: pcie_xilinx:

Please use one if you target the same code.
I prefer "pci: xilinx:" style.

Thanks,
Michal


