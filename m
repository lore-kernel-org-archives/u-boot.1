Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA790CCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 05:19:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40C9483A98;
	Tue, 11 Nov 2025 06:19:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RKfGnSSv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1063183AA0; Tue, 11 Nov 2025 06:19:03 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70C1C83936
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 06:19:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9ru0isOFv7t5lp+Dh/Eul+znbEYcyFX0vnUlrP1HVrJNrEiIWryWfnZIF7dlu0vzGKl49jLc2x2J8E+Z9/Qxvr7rEZtQGiIqR0qLAZH8c9F9MnX5tB0qVd0S+LP8Skvsotv803ok3zD8K8E6yqIOeaQamTEp0xCjv0P3Z3Z7pU30BAMQ3wvlG63BZLifh4NmpQ0dYG8/uZ2FHZtvEkrgvigbHjblQBI07o4hQTYJXXSZJnZaNtkX4eREz0gvv4s7X/l6TlomirF1o0zjeVJPQSba2ibAVXGbubmbaP8eIYgiywYC2mPFRqNUzylIkdYTu/YbYUfwLW2SXzeIE5jDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cIBnf5qrmVBdqyj56KYFZ2IHSKqbdhPEJXsdT1jWEA=;
 b=OUUzXXItYG1gXLGgv0WxVGo8WoEg4DYsxPS4cDyZ5R6+R7T6AXPJ3ICyHBqN308BczuoA3kLwvuWvHLFQ5e9iYnijrWaHoavxKsFG04EayCg2Y/ssLN1/j158ZFrv2SxMXyrJo+MFGwBogc4DIBvNy06H4W8h4t7Q0PVKuhsI1lJd+pGC70WSNgvQ/sJZpkI4hvfgbTAs7RYbvu7kGc8qXLY/AE6P2kEbnkzTaYSaUv90AQ6aK3rNndv29AK//Ya+jSU/08Yinia8avjAxjA7NXaFDUmziI9N2P11R7wOruRZnrdPk9ZJcwqJIX4p1BnxypWbJtaqLY5MSXLpVuxCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cIBnf5qrmVBdqyj56KYFZ2IHSKqbdhPEJXsdT1jWEA=;
 b=RKfGnSSv+365v6Q9gTq9nx81nCbBtXNSs4DjUAXgbyfRwAZfWVh3IFu4NIwiWS6QanTPCRD2RfxV9Gr/owYPYR4t4i0TUE5eqhkgQOfIfHXM4xNJIVjWOk/vMoHfSmCecEVczz2gjn0yOz/JY2NMT3bWvI5SozO2l4CIXrG9h8o=
Received: from DM6PR06CA0089.namprd06.prod.outlook.com (2603:10b6:5:336::22)
 by IA1PR10MB7448.namprd10.prod.outlook.com (2603:10b6:208:44d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 05:18:57 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:336:cafe::ec) by DM6PR06CA0089.outlook.office365.com
 (2603:10b6:5:336::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 05:18:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 05:18:55 +0000
Received: from DFLE112.ent.ti.com (10.64.6.33) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20; Mon, 10 Nov
 2025 23:18:51 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 10
 Nov 2025 23:18:51 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 10 Nov 2025 23:18:51 -0600
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AB5IoM7369621;
 Mon, 10 Nov 2025 23:18:51 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 11 Nov 2025 10:48:49 +0530
Message-ID: <DE5M18VIB15A.2TVG99O546D0T@ti.com>
CC: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 1/2] disk/part.c: ensure strings in struct
 disk_partition are valid after successful get_info
From: Anshul Dalal <anshuld@ti.com>
To: Rasmus Villemoes <ravi@prevas.dk>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251110205411.4075351-1-ravi@prevas.dk>
 <20251110205411.4075351-2-ravi@prevas.dk>
In-Reply-To: <20251110205411.4075351-2-ravi@prevas.dk>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|IA1PR10MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: afc059bf-d94a-452d-db21-08de20e1cfc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjROZk9tTFJXL0JCcndtQnFTUURXbHZseDA2RU5jVDhjWGxQODVTZHRmUHBa?=
 =?utf-8?B?U0tlbnBuV1JXb2RRTXEwZVdPR2ZhVHhiWjNOWlNEYmlIZ3d3dnk0SnRnUE5v?=
 =?utf-8?B?NnhLMmVodkxQanVwTnMzN0tOWW1NQk9VVDdDK0FKT2hXUlhHUGducFYrYnVz?=
 =?utf-8?B?ZDVWVnJSdzA0WnFqTUZjczJYM0FWK1JjOWdVZ05SMG40WGRLRGo0cGVIYWha?=
 =?utf-8?B?Vnh2QzJxdWxwZ2Y4eWZIUEF2dFdiUXc3bk1JUmxIdGoyZ3VHNitPUjQrNlda?=
 =?utf-8?B?QzNGeHQrbVJ5UEhBai9FOFZheGk3NTRBUE1VeXVBVWd6ZEo4OFZpaDFsUXBw?=
 =?utf-8?B?M093K0VPdms2bHpiL2NoKzhiaVV4TTJ3b1cwTWFmR0JMVFFFdU82SXRoeGpr?=
 =?utf-8?B?QWhEMlNDRFBPYi80dWEyT1RRekErVk9ZUkU1bFllUm91VWx6OEZURmk4YXNS?=
 =?utf-8?B?dFpPdUZQeGxuemlVTWRkbHV0OERKc3lTRFlXZ0d4cW96amlvb3FObEg4WUEv?=
 =?utf-8?B?eEZnTXpJVkNMMzAzcW91N3Ztd2FrYXo5aWF2ancyUUFycy81OGU3dGdvenla?=
 =?utf-8?B?QWc5UFpwRi9md0UrbExUb0tFR1lZekJmRTl0QjlzVVpLRTlEZkRjOWJ3UTJY?=
 =?utf-8?B?L2RPMzJ1OVVkM0ZIb2FjVlRpU3EwdU5yeE5ZTHpwNFJhRFRYeGU3Qisvd2I2?=
 =?utf-8?B?c0VaZE9LTmovRHdubDFsOGRidGxtd0pKb2dlRnZJaW1uS242WEFLSU84Tk5S?=
 =?utf-8?B?NHJIN1dxajY1QWlQSy8za3dUR21zb3BMV0RxMzROTXVqOHRyT081UVRVdnZz?=
 =?utf-8?B?UUlmMDgzVzI0YXV0NDlTSkJrSEVtTitpaTFVU3k1dHZIQW11WnUvMnlIWVlX?=
 =?utf-8?B?ellkVm1hTjNta0R1Yi9IVEZYL3lrQzd6eE9SMTlveW82MU53R2ZYc00zOHF6?=
 =?utf-8?B?bkhhSFVGTVFKUlFrUUdjMHZZZXptWVR3aGFVTHVVZytzN1JudVovRVIzTUw3?=
 =?utf-8?B?OG11SFB5cmRwRWwzbjhJMzUvNFhWSm80UTRJb1krUHh5dFdqOVRHclRRaGwv?=
 =?utf-8?B?MVFSMWF3dVkyUW9IWndLaE40eE5yR25ZdjdYS0pHZEZreVNsSjZlQWVLNU9r?=
 =?utf-8?B?eXNxS1dqbXdGNUVFK0t3TUJTc3FlYkh5c2gzaUVJV1MxditxUVltN3FkL0tU?=
 =?utf-8?B?YzlUZHpzSmdQdEppaGRNUkJiTFhUem9KSDJlR0RxU1hXYVJWV2V5NmpXdE9q?=
 =?utf-8?B?ZU5GZzBLbGU2K2pLUTRaRnRNak92NkQyUERqdHp3Wk1GNEFXblByeWhiMUR1?=
 =?utf-8?B?UmhPdllWTWQ5RXoxNmpGU2U5Z2cvcTduWk5aNVF3Z0V4WHliYk4zYVVkZktN?=
 =?utf-8?B?K0ZIeWk0VFdXSkNaeXJVSUdMekJMSDRCWFA1bmoyMytLVVpZRkJka0UrYXlX?=
 =?utf-8?B?SnFWOEJGRVNBSkZXWkd5d1VmYjMyQWt3czVBaFZwZ0F6L0FDcC9sbWxaL3VJ?=
 =?utf-8?B?NVRjaVc4RmNFUjRILy9NZWlqamZIVGRtR085OGlwQWMzbWFvTHUrUDZ5L2lx?=
 =?utf-8?B?L291R0N6dXZwQlJIRXpwYzhsMHNxOFdxVDkwY0JvUm1mL1NzS1ZwUGRpSjVj?=
 =?utf-8?B?UzhGaHNhQ0Y3RE1pKzdWRUxBR3cvbUx1Q1R1MllEd2pHVGdqVlRKMmtVMDRK?=
 =?utf-8?B?Vk1MVjJXdUZVV2NVcGNxbnYyRnhFSmdOVnJmOXlyYVZNNzl1Y0JxTWltczd4?=
 =?utf-8?B?SFowenJSMW1nc3VwM2tmZ2pUQ0xkeThZekxrUWtXN0lVNktGOVRRNWVNNW4z?=
 =?utf-8?B?ZzJGTHpDNS9ZOVplUnpVZXo2bTlVeTU4T1FvazRsdHY2UEZqZXJobzl0OUtZ?=
 =?utf-8?B?UlNxVnhKSURDSkNRYk9UMHR6S2tYUFpiZ0txT1NJUDhYcVNIL2E0dkFJV3J5?=
 =?utf-8?B?OEpvcDVhQ3VGNzBMK2dLTmQyeDBaWUVFNVoxUEdXQkw5MW5vYkZ3VFpCWFJW?=
 =?utf-8?B?M2N2NStnOFR1em9UR2JaWUVSaDkzNS95d3g5TXZzM1BnZXptS2d2K1BTZUlB?=
 =?utf-8?B?NmgweGxVVmxna3l3cGtxclJxemQzMllWd0loZitFTkVvajBhekhpQithdFgr?=
 =?utf-8?Q?wRWk=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 05:18:55.7995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afc059bf-d94a-452d-db21-08de20e1cfc2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7448
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

Hi Rasmus,

On Tue Nov 11, 2025 at 2:24 AM IST, Rasmus Villemoes wrote:
> Not all ->get_info implementations necessarily populate all the string
> members of struct disk_partition.
>
> Currently, only part_get_info_by_type() (and thereby part_get_info)
> ensure that the uuid strings are initialized; part_get_info_by_type()
> and part_get_info_by_uuid() do not. In fact, the latter could lead to
> a false positive match - if the ->get_info backend does not populate
> info->uuid, stale contents in info could cause the strncasecmp() to
> succeed.
>
> None of the functions currently ensure that the ->name and ->type
> strings are initialized.
>
> Instead of forcing all callers of any of these functions to
> pre-initialize info, or all implementations of the ->get_info method
> to ensure there are valid C strings in all four fields, create a small
> helper function and factor all invocations of ->get_info through that.
>
> This also consolidates the -ENOSYS check and standardizes on using
> log_debug() for reporting absence, instead of the current mix of
> PRINTF and log_debug(). It does mean we have to special-case -ENOSYS
> in the error cases inside the loops in the _by_uuid() and _by_name()
> functions, but it's still a net win in #LOC.
>
> Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>  cmd/gpt.c      |  4 ++--
>  disk/part.c    | 63 +++++++++++++++++++++++++++++---------------------
>  include/part.h | 16 +++++++++++++
>  3 files changed, 55 insertions(+), 28 deletions(-)
>
> diff --git a/cmd/gpt.c b/cmd/gpt.c
> index e18e5036a06..84221881c39 100644
> --- a/cmd/gpt.c
> +++ b/cmd/gpt.c
> @@ -724,7 +724,7 @@ static int gpt_enumerate(struct blk_desc *desc)
>  			continue;
> =20
>  		for (i =3D 1; i < part_drv->max_entries; i++) {
> -			ret =3D part_drv->get_info(desc, i, &pinfo);
> +			ret =3D part_driver_get_info(part_drv, desc, i, &pinfo);
>  			if (ret)
>  				continue;
> =20
> @@ -820,7 +820,7 @@ static int gpt_setenv(struct blk_desc *desc, const ch=
ar *name)
>  		int i;
> =20
>  		for (i =3D 1; i < part_drv->max_entries; i++) {
> -			ret =3D part_drv->get_info(desc, i, &pinfo);
> +			ret =3D part_driver_get_info(part_drv, desc, i, &pinfo);
>  			if (ret)
>  				continue;
> =20
> diff --git a/disk/part.c b/disk/part.c
> index be2b45d5a29..49a0fca6b89 100644
> --- a/disk/part.c
> +++ b/disk/part.c
> @@ -72,6 +72,28 @@ struct part_driver *part_driver_lookup_type(struct blk=
_desc *desc)
>  	return NULL;
>  }
> =20
> +static void disk_partition_clr(struct disk_partition *info)
> +{
> +	/* The common case is no UUID support */
> +	disk_partition_clr_uuid(info);
> +	disk_partition_clr_type_guid(info);
> +	info->name[0] =3D '\0';
> +	info->type[0] =3D '\0';
> +}
> +
> +int part_driver_get_info(struct part_driver *drv, struct blk_desc *desc,=
 int part,
> +			 struct disk_partition *info)
> +{
> +	if (!drv->get_info) {
> +		log_debug("## Driver %s does not have the get_info() method\n",
> +			  drv->name);
> +		return -ENOSYS;
> +	}
> +
> +	disk_partition_clr(info);
> +	return drv->get_info(desc, part, info);
> +}
> +
>  int part_get_type_by_name(const char *name)
>  {
>  	struct part_driver *drv =3D
> @@ -322,12 +344,9 @@ int part_get_info_by_type(struct blk_desc *desc, int=
 part, int part_type,
>  			  struct disk_partition *info)
>  {
>  	struct part_driver *drv;
> +	int ret =3D -ENOENT;
> =20
>  	if (blk_enabled()) {
> -		/* The common case is no UUID support */
> -		disk_partition_clr_uuid(info);
> -		disk_partition_clr_type_guid(info);
> -
>  		if (part_type =3D=3D PART_TYPE_UNKNOWN) {
>  			drv =3D part_driver_lookup_type(desc);
>  		} else {
> @@ -339,18 +358,16 @@ int part_get_info_by_type(struct blk_desc *desc, in=
t part, int part_type,
>  			      desc->part_type);
>  			return -EPROTONOSUPPORT;
>  		}
> -		if (!drv->get_info) {
> -			PRINTF("## Driver %s does not have the get_info() method\n",
> -			       drv->name);
> -			return -ENOSYS;
> -		}
> -		if (drv->get_info(desc, part, info) =3D=3D 0) {
> +
> +		ret =3D part_driver_get_info(drv, desc, part, info);
> +		if (ret && ret !=3D -ENOSYS) {
> +			ret =3D -ENOENT;

Why are we overwriting the err code from part_driver_get_info here?

Regards,
Anshul

> +		} else {
>  			PRINTF("## Valid %s partition found ##\n", drv->name);
> -			return 0;
>  		}
>  	}
> =20
> -	return -ENOENT;
> +	return ret;
>  }
> =20
>  int part_get_info(struct blk_desc *desc, int part,
> @@ -657,15 +674,12 @@ int part_get_info_by_name(struct blk_desc *desc, co=
nst char *name,
>  	if (!part_drv)
>  		return -1;
> =20
> -	if (!part_drv->get_info) {
> -		log_debug("## Driver %s does not have the get_info() method\n",
> -			  part_drv->name);
> -		return -ENOSYS;
> -	}
> -
>  	for (i =3D 1; i < part_drv->max_entries; i++) {
> -		ret =3D part_drv->get_info(desc, i, info);
> +		ret =3D part_driver_get_info(part_drv, desc, i, info);
>  		if (ret !=3D 0) {
> +			/* -ENOSYS means no ->get_info method. */
> +			if (ret =3D=3D -ENOSYS)
> +				return ret;
>  			/*
>  			 * Partition with this index can't be obtained, but
>  			 * further partitions might be, so keep checking.
> @@ -695,15 +709,12 @@ int part_get_info_by_uuid(struct blk_desc *desc, co=
nst char *uuid,
>  	if (!part_drv)
>  		return -1;
> =20
> -	if (!part_drv->get_info) {
> -		log_debug("## Driver %s does not have the get_info() method\n",
> -			  part_drv->name);
> -		return -ENOSYS;
> -	}
> -
>  	for (i =3D 1; i < part_drv->max_entries; i++) {
> -		ret =3D part_drv->get_info(desc, i, info);
> +		ret =3D part_driver_get_info(part_drv, desc, i, info);
>  		if (ret !=3D 0) {
> +			/* -ENOSYS means no ->get_info method. */
> +			if (ret =3D=3D -ENOSYS)
> +				return ret;
>  			/*
>  			 * Partition with this index can't be obtained, but
>  			 * further partitions might be, so keep checking.
> diff --git a/include/part.h b/include/part.h
> index 6caaa6526aa..d940f8b5d0e 100644
> --- a/include/part.h
> +++ b/include/part.h
> @@ -509,6 +509,22 @@ struct part_driver {
>  	int (*test)(struct blk_desc *desc);
>  };
> =20
> +/**
> + * part_driver_get_info() - Call the part_driver's get_info method
> + *
> + * On success, string members of info are guaranteed to be properly
> + * initialized, though they may be empty.
> + *
> + * @drv:	Partition driver
> + * @desc:	Block device descriptor
> + * @part:	Partition number to read
> + * @info:	Returned partition information
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int part_driver_get_info(struct part_driver *drv, struct blk_desc *desc,=
 int part,
> +			 struct disk_partition *info);
> +
>  /* Declare a new U-Boot partition 'driver' */
>  #define U_BOOT_PART_TYPE(__name)					\
>  	ll_entry_declare(struct part_driver, __name, part_driver)

