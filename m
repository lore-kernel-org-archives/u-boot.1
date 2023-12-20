Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB150C46CD3
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 16:41:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4742B8767C;
	Wed, 20 Dec 2023 17:41:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DsMbJbnu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C00738767C; Wed, 20 Dec 2023 17:41:15 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E3C1876B2
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 17:41:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFLHog8DWoqmHzx7oshR40TG6xuf+NswGm81tEE9CTpicg3qpIENe04ZVTjQUmu8r1GVdFWh7pR+UZM8PFV7aT9HGTjg1KmTVoeJPydhGkH0w6L6PjJWeuBF4VsoYNdTJJ6HhlCX6U2Fa+vcIdmWLGOYP2gBBpEE0tnmtZxUrP1qBkgh9cqNXim1BwycDoz0wy5HokUSV9jDTMU/7b2B9hsO4YmEiw78ICWwJ6BY6Tc4U80mMF14Rg849XRJv9YlQLP1XW5xXBL15IBLTqsX4pw30VlV2iBU9jPUXr/Yq4MXoNmNs8qD8+dsLkwg+5qOHrnqbmeg8hCJlvJJ3YJlJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EotynmTY3eTJWBu8mDKeL7S89YfRrq6bj/EH6mq5vL0=;
 b=S9+MU3A8K01fmYOLPZUmJXH0cW1vqLwCT97pLkYf+Fq7g4NMImWBqlzu5dj5Xw5DbXXv+9z4yEu++CnCn4U9rQb2Wxaa+yCMQ3O1dT9u2pDBuikKwJzPgP4ZavwMfv7XKGbEb+r/clM9g90rkTgVNQ8lQ4lAlwZ7WQBwb0J8apU0dveZ7OI82PmlLKpac3u0tibku90Rg0vnREw2kN3YqvzVbWKUHafyUehsjD1B68TIhTXya0D6utEVmiHdu44tGxJC4Du174nXhuv1dLEJwxbUlm/FNGYaY1lqapmOagUJkhPp3TKOBeRk2BY1xGFekkK+w0bIop34HUNIOfCsoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EotynmTY3eTJWBu8mDKeL7S89YfRrq6bj/EH6mq5vL0=;
 b=DsMbJbnusoHKaG9/aDq5C+kPjzj4azFfQagQA1aGaueasu83icXqHEVTfs4zvLfHkRlf2lm7Yv44OwdiV2JRuwdEVpXwGlz/Wr8Bh8osm1aksQ7qmEj71quYEnEgFzuKe3wcobVd0CNZpDBE23EI8HOtJqD2yMDlYgiHfVS/2BQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by CY5PR12MB6454.namprd12.prod.outlook.com (2603:10b6:930:36::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 16:41:11 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 16:41:10 +0000
Message-ID: <ffb4597c-4031-4e1e-8c35-4b0c1c32bbd0@amd.com>
Date: Wed, 20 Dec 2023 17:40:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] bloblist: Load the bloblist from the previous loader
Content-Language: en-US
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Baruch Siach <baruch@tkos.co.il>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>,
 Sean Anderson <seanga2@gmail.com>
References: <20231219211114.393193-1-raymond.mao@linaro.org>
 <20231219211114.393193-4-raymond.mao@linaro.org>
 <f2221d44-cbb7-4355-b9a1-ecea47af62c5@amd.com>
 <CAEfUkULk+gFBEg=6YPtzracvHJ6pU7AM=+fw0eB3=NuxjctNcA@mail.gmail.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAEfUkULk+gFBEg=6YPtzracvHJ6pU7AM=+fw0eB3=NuxjctNcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0045.eurprd04.prod.outlook.com
 (2603:10a6:802:2::16) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|CY5PR12MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c95835e-3518-4d88-d5c4-08dc017a78ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1X7Lld21VsRZ7Tgna2wvHUBj1BVvyLGRav4s/D/mSu08Co3oJ/8bKaB3oJ0eMN5eY71neZTa26Jbdluc9B/HQz01KmfTpyqKkODOJySLQHfZFQzm4jI8DthKsF0PDeC4UKm3tv4zqYbCX+i4K1Mfli/TV0cDSkdvThDKDcV55VisHwlh4Fnm/T0eKNstceYJ/8OHzzEXuzQDyQvvB9Leb4trXtOQubq6yV7XxL6s6pfyPDpxB8NuLlZosYbxYtPNL8vABJ685N312OwO7pPGnj2AvmchuskuL8o/T0gQKmKDytSDeTvc1sxh/0MVwQ4kkqhLNAUbjmK7ODzYeLLyqJ2hX7mj3cOQDzsgwDS3+ItcPSLVJa3lBQWTf9nr4E5S/mAX90E2mBbNCRC8Da+lGRWBJbUETR91wyPN/QdB4BLH04ydhffmS+JZNLWcmPJ0PqsChdSFZyGpdUQnF97DkwZU2KUXUIlwoUaOSGfC1Yy03ICGYWFLQSQSWO0yaO4UCniZJVRgOhStiGCHhuiDXbPBU73Oe92wqelBw+Qm82k4Fycv8tYtIyBQRiwUc2FsVxPzEdXAKKvHqG1oti9Kry16xA/5reLXaiwBzoGIJL3ve416SR37YUcb1iiRHGSz/zK1Ixl0M9zPNFG8cGGEaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(366004)(346002)(396003)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(478600001)(66946007)(316002)(66556008)(66476007)(6916009)(38100700002)(36756003)(6666004)(41300700001)(31696002)(86362001)(6512007)(6506007)(53546011)(54906003)(5660300002)(26005)(4326008)(83380400001)(44832011)(7416002)(8936002)(2616005)(8676002)(4744005)(2906002)(31686004)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDJleG82VjdnNWdpQ0hmbjNaamgwU2t2QnMvUXVXTjZUeUdaZnBaRnNKWlFD?=
 =?utf-8?B?UnM5dU45d2YzYnNYRFZCRjVnK2g2ZjFEMDVoSjB4dEVwSXZTVjhJUERjOVRK?=
 =?utf-8?B?eXplNXRWbTNOYitNUEJiZjRURHJrR3Iycm5uTUU0dUd2aWUvZm5xSUt1NFht?=
 =?utf-8?B?ZTZzdlI1dFZQcEpHT3B3MW9CUURVNWl2U2xsbTk2MDVSN3A2ejlheWtaKzhW?=
 =?utf-8?B?Y2J6L3NLdTZBd2RjeWpEbGtEeHczN1VPQWtLUFpsK3ErVjVlVG9rSFc1NlRj?=
 =?utf-8?B?cGFOMG5oOXJ1dCtZSnFkbWxHWHRrSmEzNC9iZlkvMHV6YzY1TGdZckVMcjB1?=
 =?utf-8?B?L0N1L05sdTB2ZzhuOEhLN1k1aVNOUXowb1Y4d2pFdnNydWpwblFQUTI4ekdT?=
 =?utf-8?B?U0lTWjRaRk12MFh6OFEvaXo2c0o2WTZ1b255SDlkVEhZR1RzQ2J5MnR6WmI2?=
 =?utf-8?B?bm44UldkZUVMVVpYS3lVOG14MEdGUmhJSHQ4Zkh6aFVvNnpTamJSSWFGYUts?=
 =?utf-8?B?eTlxMGNuYUdSQlJPajJxMFNnS0VwWW1KWmY3RUZ6SVVQSytmZlJEVEQwNThv?=
 =?utf-8?B?V2hRNFlaaVZjT0pHQ1h0YW5TdjdxTXA0Myt6ZFg3eDN0OTZhd3RnTnFZcEVz?=
 =?utf-8?B?bGF6SHJBa1VLK3AxSjFwSTBOd1kzY3lvNFRLV2NGZm1KWlpJanl4NFFvRmVL?=
 =?utf-8?B?cjRNTWZxcGxkSHlWMTRHbjNtZG1BSzFuMnNqeloyOHpCZTBaUFc3U0QrbGtr?=
 =?utf-8?B?T1R0d1J0N1pIOEQ2VHpnS0ZKWlVWUXRvQ1ppNWlDRW9SZWNpV1dZMVcxcHAv?=
 =?utf-8?B?YjJmNG1EWWJZV0ZOVk50WUY4U01zdWRra21hbFBjRXh2SmUrMW1LS0hsdGta?=
 =?utf-8?B?TW10Nm9mRDViWkd6b1FGSk40WGFGOHJaWFFTNzVXcDFmd2dKZlF6YUlFR0Rv?=
 =?utf-8?B?NDZiYWFQODBRY2R0WTNycjJJcXRBM1pNNnZXWjdVSkFVZVMxcHVqRDl2enZz?=
 =?utf-8?B?N1VyWHhrQXlIZmUvSXFyUUZVcldVVlo0eWFPVFI2c1FjR3AvZGFmVTBtUFlQ?=
 =?utf-8?B?emo2d29tWGhqQm5CRFFXN3l1L0pNbG5aMk9OTXoyQlk0SlpCVDVhQUc0Y2c5?=
 =?utf-8?B?UDdUQ3U5R1drYWhXRjcvcmcvTHpGQmRHelBmd2hFR0JBV1F5ZnRqQ09nUXhM?=
 =?utf-8?B?cmRwR3NuU3dDMFZYOFBEM29RNW9YZENyWjZzdEszSCt5WGxVUlVHWjVBUFls?=
 =?utf-8?B?TS9tTytLMkwwQzB2VFI3RkFQc1k5aFRDWlRvWG00WnAwVlBHNy95SFplZTJt?=
 =?utf-8?B?R09Jd2hueXJLeHloTFBWWmxLSFovTU1DcmJ5WEIwbUE5cXNReGx5Ny9xRTFo?=
 =?utf-8?B?S25VWk43a3pBRmE2bXZoN0VMMjk1STFkejY1VzhNZWczY0NGTGpMV09TUUR1?=
 =?utf-8?B?WjFpbC95RktQU2E1MG11emRZM09nNlFKQ1h6dUFxQmNpK2xkSUswRk9saitS?=
 =?utf-8?B?STBHcGl2Tk1FM1dVZ2NoUk1jRkUzc3lrbFJ0TVJjQitXUmpCM3dYUmluRmJT?=
 =?utf-8?B?REIvUFltN2RTcmZCbElHYkxNYzg0UGRlNFl1YXlsM2Z5dUxjUExvck95NG51?=
 =?utf-8?B?SnlTNTQyVXhQaXk1d2JyelUrSmN0aVRlbC9IZkplajR5ZEFiN05SWFBRc2g5?=
 =?utf-8?B?YlZRaFpZUjFlaStSOHZhbUhLaGZRYzQwSGpPblBRWFdIUU8zT2h6MG12WlRx?=
 =?utf-8?B?a1o2YnMxa3BwZ3Uxd2Q1UVk4ZW1hUGpQMXlRSXR4U0t0bm1ab2JSRlN4eVhz?=
 =?utf-8?B?ZnIwYUVmTEZTeE5LWW1aZ0hkOTZkc0swWkNkQytVVmoxUk9ta1NPekFSR2U0?=
 =?utf-8?B?TlNQQ0FtWnhodlJ3SVhXcUR0dFdOU0U0Z3hzM2VRcXRvcVlEMCtSVFBvSUNJ?=
 =?utf-8?B?UXIzNmx3U3JrbjZXMU5WMHhPOEtrbk9MRXoxa1pUVEVrV0FFbTJqZWxuZDVN?=
 =?utf-8?B?MjlBSHhDbXYvWGpqQ0ZPRENQeGd2ejVDNzJnZTJpUzBVRzdwSlVoSEJZdmts?=
 =?utf-8?B?SnlMVnhWK0xVMTB3SlBteHplUjZ4SVE1UFVpbEJUWUJGcWVpM1VRZStRK1h5?=
 =?utf-8?Q?/rGJQM32pn38F9NIIYhNbk+cu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c95835e-3518-4d88-d5c4-08dc017a78ea
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 16:41:10.8885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDr/aEBkpdWkJb+mjZ7lMen9y0zgk+9Bg63qbICt46CV6tUIR8IefFcNg3BZqlu0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6454
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

Hi Raymond,

On 12/20/23 15:53, Raymond Mao wrote:
> Hi Michal,
> 

please avoid top posting.

> Other vendors should add their own custom function under the 
> "./board/<board-name>" directory.
> The inline function here is just to avoid the building errors on other platforms 
> which do not yet implement the custom function.
> Otherwise we have to create a function "board_bloblist_from_boot_arg()" under 
> all boards with this patch.

pretty much platforms which enables bloblist via Kconfig want to start to use 
this functionality and start to get information out of it.
It means I think dependency is on BLOBLIST. Simon is using it for sandbox that's 
why I can understand that you want to limit it to ARM or ARM64 or both.
But I don't think you should connect it to any specific ARM arch like ARCH_QEMU.

Thanks,
Michal

