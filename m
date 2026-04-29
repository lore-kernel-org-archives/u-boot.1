Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3ABFF886F
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 02:16:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D592F846AF;
	Wed, 29 Apr 2026 04:16:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jVKUn+Tj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E9F2846BA; Wed, 29 Apr 2026 04:16:06 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01E4D84671
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 04:16:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=er7UjSpExl933VcavolHE/VMGWFcWS34ljyRnoC5P3UPyAvnEQzSnTA7DkMCZJMvtLC6kmslUaP/2J2FhA+hlWT37ZbzizuZrGojDyO8xCzHBSZE0NRgg2BqO7OCfmp0l5pcs2jV2sppP7VKKS954LgTwHrJSrTw/Nx3qFaRXjvPedh13jdAj3TzumVP23cHc5eF2UHeRw+HF4EZLWpHRMbD+CEDrjjTN6whgtDmIGrxCNE3qsTS4upRqb2Gz8NAGVkXba9xTpgxjDvboRxMi31z2xAxOKDzx5rFIl+BGpY1HfvC4p6+TNprQjhaP/3xC+hMecNybFkuR3zXv4QGTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1yQwqWAmUXbe6qsMRqNmPSoRnFAGF6m8JAox1pL0LkY=;
 b=qxmmWTmNutVpcXuYqmAXJM5fcUJ3reMfvc+UgrDn7VimVnV3wXsx+v1/LrtozGeARNlkkL40OCTkeqarhz1/b+DB3CzCRiz4F5g4A5eOoD0JAJU5knCwM4YT9OXB7F74YSm9mZsTottNzZ/+FQX1WwAEc7VRM+0caLWAw0M+eRLmEFJs2UYQkdHN4LSFwWGeViwnn1xBAJL27lfuuJfsPI8WBF+jScfE0FMK1Drpa0h9Lkkht1q38JNHdkblB3nfwIKPF+rNZmCClURuAQGUSlAaIfsYDtU0W/vmrv2539CfL+n/T59tdRJg/xDaKIZMdamNSvog1kMcRVPkQPQgIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yQwqWAmUXbe6qsMRqNmPSoRnFAGF6m8JAox1pL0LkY=;
 b=jVKUn+Tju4RyIlfp0nVzoLxz+CIKnzOtouJH2c+MJQ7dnCQys2O+ibXmrg5Zke7h2YCThQ0zIFW3R1ITNfXUwSaXw8VxnmPj6uQYYXp0t7bjTVEeaBs3jWp7+MTW5KJLXHtskn1tyn5D138klpHIK0UD0jICGSHPLEHGQe1JePoQYc+vYvMKguohuypOLSpuPDWgbRr1KT0PuWDUCGUwt/bzUYIfrdGoy+1Sf1LDtVsPUMi8IOiygK4VsVCyQIvMGahOaXrGBqtwouejQ9dOplReIedIWEiicSHu5GCZaHOG1SjNc6Yk2MKN7oQxlBYOpa/4FFf/CcUs6oz8WOHVlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU6PR04MB11158.eurprd04.prod.outlook.com (2603:10a6:10:5c1::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 02:16:00 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%4]) with mapi id 15.20.9846.025; Wed, 29 Apr 2026
 02:15:59 +0000
Date: Wed, 29 Apr 2026 10:18:38 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de,
 Macpaul Lin <macpaul.lin@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 0/8] power: pmic: mtk-pwrap: add more capability flags
Message-ID: <afFqfjAMzFDg7Nsp@shlinux89>
References: <20260409-mtk-pmic-fixes-v2-0-73e83aa6345b@baylibre.com>
 <16a5c572-ba55-4481-82a3-013e4dd0b772@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16a5c572-ba55-4481-82a3-013e4dd0b772@baylibre.com>
X-ClientProxiedBy: SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU6PR04MB11158:EE_
X-MS-Office365-Filtering-Correlation-Id: ac9a3bca-f2c5-4de5-e0b1-08dea595412d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|7416014|52116014|376014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: ZHuvT4gfvq5275ZpgsdUFkZLGjorGw/cpffWxlDxF7Ip/KNPAWw9kcypvcPNNBx3O1ysu8XmG2SNcysJSms+Lm7dugnRZtqDYxswjQWoLUdvXXdvQsTjUauWmRS+zXfsKqLAYKu4ZgJyVAkxh7kfr1kdjek4S0nd7+VBIVpihA0WCadx+WwVTWQ9ZrBuLXq2iSSFdnNngZZAp0qiUKNaLclLkNRyLGh+PNAI9IU9WH8EsAajxS39rCzA+ekE9UjrQvKivhiNU+0asLBFn0IvRvNSkkiTfHuF7wUvd1+2gR4elKdTag7NgE0tTkC37mBOnc8sBBcEdhsTB9zZI9DXo95Y7BUPEB2XnDegARF2rlusMTor9w2p5Og2lW8h9rNBbJ+BTNFITOQvtEKmRdB96610afHgbQaZzK2uHgdtgGalL8BwVs5xR9j3E7loBk9lWQtU0PI8WlD7nYSNA+VMBCJGQK4UZRS7j/0vvPCbpiiShvlK/lBn9achEICHiC8gewRSbf2MdKC/NBDQwsohdiUhvTHp2iB/JmIuac+t6UgMu610Yags2Re8XzhqILqdjD3m4Dir/+D+rAwZ8K7cFoJeyuOFwc6TWFXJ/wk0285+4EMBSqtxa265HLt8omJndGRFCQhUQ9Mw4gi5I1yTtLrFZ4kwgXQtqdZ5Hk0HZRmkrBuwYghH8jTllXksmPOr2OWbOmeLVYT0NTAsRN/bPAju3hLYQtFacE7YCgEfbcNBE4bQZW88xwKv32eruHqT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fZdEe//X2yq2OHLbLA9SG/wPtTh+PfJrgY3wec2BR1m+YngAYlZX6pRv4u9F?=
 =?us-ascii?Q?c5dZq5voQNjJ2zii4sDeEvTjodcXB3UwGqyjkRlL+V7/GZSPC1gybyGMWrPj?=
 =?us-ascii?Q?uEJixTRUTOJcBCASJPkhYW//IdulGCsUhGykS2sH3ZTM39wUFA0rtUpsvhz5?=
 =?us-ascii?Q?+Rlx/a7RkQUuj1lC0DwR0VgF71Q1OTHAtfz1zfd3q1kFpczrJ+jaBnlu20Xy?=
 =?us-ascii?Q?FHHuveU0lIdOzsK3oQ5fEGum3fE0YurBEhzdGcz4145yh8b9f5EEOL8t/Bwm?=
 =?us-ascii?Q?PGGRRUoFoLbpZxAtLVxgnzT9YFbSryJ159tumfdQpOwBFk4COZBeDDGYgg67?=
 =?us-ascii?Q?i+/T0LUqtwr5ZlOF34ereKdscxn+s04YbwbzxTG06xV/G4/42TV9oPM36scg?=
 =?us-ascii?Q?1aL/KtxNqs71zm0V1z2p5YFebr8hrMdBcBwMId9bPYNbORuOiYTfapwxv8tI?=
 =?us-ascii?Q?mB6peKPR6pu0u5qhJ0IkpjsiXHcDSxFxhBO9LkBoZNgMMDIb0pM6FfVJbslw?=
 =?us-ascii?Q?8QTXZEhod9BD2h5RW3gE2EobTzwlSrCCcedReiUqui4Do5tgx3ZfYKTjfJov?=
 =?us-ascii?Q?OgqyUXirHmunYeLEtKrPqOc0VhMfuznJlCgMqtnXgxuEl+8vtYL/5AL5g2kz?=
 =?us-ascii?Q?1KDsvPVdWSZwndypsike4aiFhrvVAjkykfmHhASUEvC8H8F3jK8WQZPI8eUV?=
 =?us-ascii?Q?Lmrv27iTOyP2nx0fj5G8hAYGjEO08qSkIvUo7zbpuENpwDKZHrjzB3hxlrbK?=
 =?us-ascii?Q?R4Cj60NWqpDqGjdSj+rmiRDSWzQZ1pFYDJRffPX/68F/vHXqEKC6u+Sze6QJ?=
 =?us-ascii?Q?t6UGLabT8IyqXeAbtefEGGkim6lshlh5fV2aqU+LQwZwlD2sHoYo6oLHwsmO?=
 =?us-ascii?Q?G62q7+nvkQ8fWbVl5F8mBE+0rYRYy0VFs+YOsGTuG8ZkZxFhyhYYMiuVYa9G?=
 =?us-ascii?Q?h5ht6ycCaw12IfBKjFOcD5eXgmurBfhcIZa4V2chbxTQatcf1ofIswjGPkCd?=
 =?us-ascii?Q?8JdRdI7iIPZnyxbGkwYq49RTR0KznSxylvFGAtwsGOLdVPGf0bWaf7OKkFVc?=
 =?us-ascii?Q?ISMrlYR/NsrTzPyyjDdhYgAY/dXRJc2mJxWDA/VE7WGp2qZ6F94jyqkxWYyE?=
 =?us-ascii?Q?5yB2dkFIb8OWVFo2N6eWAVxf2KRRnmIECh0k/DoAZryg/n7NZdz/BjY6TivQ?=
 =?us-ascii?Q?XmX/O8qF6eJqJMYyrksY8R3OcqnwfOd3OuS8Z5z7r3s08wb1BnE0dX+tXbCH?=
 =?us-ascii?Q?quikNQB567ea+2F4lNYyImveMqqsi93U3xhMEuoIUqYAFNmivfTHjidwGeJr?=
 =?us-ascii?Q?KJG0r1jC3iPr+W075cGelwzO7vFurY0J0gb/nAKzVspKxk/ncimQbLGZ2tus?=
 =?us-ascii?Q?+mxceTxgXITTsFkI3H/09npVABt+O9GOaLPmwp4tXd6B/qHZVgvr42w2+ait?=
 =?us-ascii?Q?/XWTgxpoKtUu9DNIzBOD0+5OXYNtU+sCs0Elt9l9JcdX7x8ri2RuaHgj3cAw?=
 =?us-ascii?Q?WEkMIg+lSIlxzAW/N3T1Qf+K/61mUXOCDxL5ntticw2ZOlwe26ttsJtAarCA?=
 =?us-ascii?Q?oduKdctVm3fRi8V2N0TIIGe2vG5ju3XT7mIGqLCNIXPGMrd4n3yMEyZBo4fv?=
 =?us-ascii?Q?FyhpnnrEg7LaDPbK3sL9fG2rFodVnqaO9YR9YY3JZuynOCX713CUI0Mn8Sf6?=
 =?us-ascii?Q?mcmFPVLjOskFY8lBhPct5JraXfejrt5tAhHzdIp3L61tvMu9UL/PJETyXPtI?=
 =?us-ascii?Q?upHpyQ1u4g=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9a3bca-f2c5-4de5-e0b1-08dea595412d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 02:15:59.9278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kv+bJvq9IRq2kbFiw0FMxAQnnysgKD9HgO/QbGRiJAccoXemGHWbbXCHCyptsgZLF800oa/0OP1wsAmwwiQ84w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11158
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

On Mon, Apr 27, 2026 at 06:15:55PM -0500, David Lechner wrote:
>On 4/9/26 3:30 PM, David Lechner wrote:
>> After using the mtk-pwrap driver a bit, we noticed that there were a few
>> places where it was writing to registers that were not defined on all
>> platforms. The undefined registers are treated as 0, which is the DONE2
>> register on the affected platforms. This could cause the DONE2 register
>> to have an incorrect value, which could cause Linux to re-initialize the
>> PMIC unnecessarily.
>> 
>> To avoid this issue and ensure that we only write to registers that are
>> defined on a given platform, we can add some more capability flags to
>> conditionally call any register writes that aren't common to all
>> platforms.
>> 
>> There are also a couple of other cleanups that we do along the way. And
>> in v2, I've picked up Julien's patch to add support for MT8195 and
>> rebased on top of this.
>> 
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>> Changes in v2:
>> - Use EOPNOTSUPP.
>> - Reorder patches to reduce churn.
>> - Added new patch to fix driver description comment.
>> - Added new patch to drop chip type enum.
>> - Picked up Julien's patches from [1] and rebased on these changes.
>> - Link to [1]: https://lore.kernel.org/u-boot/20260317-mt8195-add-ufs-support-v1-0-7d731ec438ae@baylibre.com/
>> - Link to v1: https://patch.msgid.link/20260327-mtk-pmic-fixes-v1-0-ef874ca82409@baylibre.com
>> 
>> ---
>> David Lechner (6):
>>       power: pmic: mtk-pwrap: fix file description
>>       power: pmic: mtk-pwrap: add PWRAP_CAP_WDT_SRC flag
>>       power: pmic: mtk-pwrap: add init capability flag
>>       power: pmic: mtk-pwrap: drop PWRAP_SLV_CAP_DUALIO on mt6359
>>       power: pmic: mtk-pwrap: remove interrupt related code
>>       power: pmic: mtk-pwrap: use pmic compatible to select child info
>> 
>> Julien Stephan (2):
>>       power: pmic: mtk-pwrap: use tabs for alignment
>>       power: pmic: mtk-pwrap: add MT8195 support
>> 
>>  drivers/power/pmic/mtk-pwrap.c | 115 +++++++++++++++++++++--------------------
>>  1 file changed, 60 insertions(+), 55 deletions(-)
>> ---
>> base-commit: 2a1bcefce835b827bbf88a9e112d646c5c4af9c1
>> change-id: 20260317-mtk-pmic-fixes-c1523b1b0dad
>> 
>> Best regards,
>> --  
>> David Lechner <dlechner@baylibre.com>
>> 
>
>Hi Jaehoon,
>
>Is it OK if I take this through the MediaTek tree? We need to
>pick this up for v2026.07 to make sure the boards we added recently
>are working correctly.
>

Feel free to take it through MTK tree.

Regards
Peng.
