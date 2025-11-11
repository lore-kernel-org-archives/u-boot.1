Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8968ECCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 04:23:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E17283AD1;
	Tue, 11 Nov 2025 05:23:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LIr426UT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9B6C83AE6; Tue, 11 Nov 2025 05:23:07 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4822883AB4
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 05:23:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLmI9vS0ckmjaadqZ3zacthJkxzsCQninnSw/qJJUkHu1Z3/Ow2BxS6KddI6hXXJvV6ytgAz7NkvyH/wVFA0BlNdpi8XekyR8uE6vAaJlCJuOfM28+ZkK36Ok7BaM2cebnQsPA54voHfizkIneUSLjypS2Cih/Mk55ED2vqrluyRkrB0Rp9O7ugAY8Hn30y//RoNG0bn+nisUVYDyZbyG56MLktGvVthOmOLYh7y4W15NYULUqHDA1pYoNFaC4c3gOlf0mRLODRuXwfm/ToYxgdPj85RONtE40Z/gpyTStkqDPmVSkarpDxLmW5CVVSqZun0Im8kC3TbkDLXUdM+Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8HONLK1D2ltAuOw6AaCxeH/KPOXtuGE9AW44lnpNoA=;
 b=d3GZr233ce/Iu5r9AT6ubwX3BvI57BMazojyquS0yp43tMlQwUi0qsbiyn24aLgyimiIRE/ytrxfSXWAg5jdQzZRTSEErkXmgmeu2JXv2suSNrccozn7w2hhP3aSjC44s+09CSvDuw0fjLTgPaPuU28u3p1zV4S/SqcQ/d8z50J9n7KjGOBXars4VvbthnYPtO+TwG1AZ+gFs51uxdYRCniiY4dFy03+dQdm/eNP8bAUTEmB5OVFexBIurIA3M9RBnsCafAEJIyrach5kdILnPL2EgJYFOG77mcdmh6G6ItJEfvmRq6VktqE+QxoxAkF378PIigb9cfs4uCxFX1KPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8HONLK1D2ltAuOw6AaCxeH/KPOXtuGE9AW44lnpNoA=;
 b=LIr426UTu86JMpfWO9sL91tgWldCu4t5UM9jIqqCJLqHd/EDVZnf0j6p+ElAPnsoiaYmWUyCHmoZ2a3LTSjKtcZwZnhI/dFtjzH62JOLSi/odPfPbGOI3V8D8dWGo/MgMZ8XLRJa3pHa/feMPGVfL6EX4lCIreJ6BCzCiidHbzY=
Received: from MW4PR03CA0217.namprd03.prod.outlook.com (2603:10b6:303:b9::12)
 by SA2PR10MB4476.namprd10.prod.outlook.com (2603:10b6:806:f9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 04:23:02 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::6d) by MW4PR03CA0217.outlook.office365.com
 (2603:10b6:303:b9::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 04:22:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 04:23:01 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 22:22:53 -0600
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 22:22:52 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 10 Nov 2025 22:22:52 -0600
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AB4MpFT305204;
 Mon, 10 Nov 2025 22:22:52 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 11 Nov 2025 09:52:51 +0530
Message-ID: <DE5KUDXKQ20P.86VFM203YPJS@ti.com>
Subject: Re: How to use ECDSA for signature verification?
From: Anshul Dalal <anshuld@ti.com>
To: =?utf-8?q?Marko_M=C3=A4kel=C3=A4?= <marko.makela@iki.fi>,
 <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <aO1GvGrXUw-co84_@kehys.lan> <aQ98sHenb3G1MQDi@kehys.lan>
In-Reply-To: <aQ98sHenb3G1MQDi@kehys.lan>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|SA2PR10MB4476:EE_
X-MS-Office365-Filtering-Correlation-Id: e9fae7a5-4e14-4a11-0a13-08de20da0041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUJFY3N0ZWw0VFNocTUrNGUydHpEenVqS1VQYmFxQ2JRQkFxWGFzQjNZZ1Nn?=
 =?utf-8?B?N3NjVFpRWjFYT0xybU53Y1FFcGpUMHp6b29wekJpRUJSRXV6bGtnaHJmSTRZ?=
 =?utf-8?B?TWU2Ni9QL05JWGc4TVR6S2M2aTJrdjhlYTBDSW5BZUpoYUdPYlcvcEVsclQx?=
 =?utf-8?B?eHlaa0twMnFaQkF1WHUxd1QwU1h1T3JSQTBhVDJjRUV4SldRaGtFeXJvZU44?=
 =?utf-8?B?MWRkcHlJYTRONUdmUmd2Wk8za0VCbytpcUJSN2lwcm0vbEdwblBJbmx2SFc4?=
 =?utf-8?B?alFqMGJjZ0lYQzEyM2czLzRSa3RLbVo1enRNVnYra0hhL1dSKytFc2hZL2V0?=
 =?utf-8?B?RGJNbTJ5azF0TTlkOWRRUEliTFNUa1BYaUI0UWFZZ3hBQmZWRUxmaVU2NmVU?=
 =?utf-8?B?bWJCUXZlMTlodkNEc09IYXNGNE43bDZQVVJQNFhWVHhqN0FNVEtLb0ZmSVRM?=
 =?utf-8?B?c2laRW1RY2ZHcFFNLy9NSk1uSmlka0FUbkpFSENLVE8vRVlPTWQrMUhVeW02?=
 =?utf-8?B?MVZlTWdGeUxqVGNldDYzQUliUHNMbndzdjYybWVZMFZVaWI4ZVJFcXZzekQv?=
 =?utf-8?B?UXdyR0Y5UDZPR0x6R1l3Zjl4UGY0cktVSUhhZWt3dHpZTGlqVm9LT2dicjdo?=
 =?utf-8?B?ajJVV1NPdHBGd2o5MmlUaEsyOEJndzZxanhlZ3ZuYjhoaHJiNHZYbXZNRU1Q?=
 =?utf-8?B?bmxKWUgzd0RHOElzaFFQOXFHbWNya1ZDQWp5TXBRSmRGaXZQcCsvR3lNWU9v?=
 =?utf-8?B?MVYwWkE1ZzF2TnBDNzRobE5FblNnbUhHTytUbEt0Sk5XT0JtTEw3UGpwa0ha?=
 =?utf-8?B?VjZjSUF2VFlaSnJMSEpmdDhyN0NkTEVjeE53N1k5SkpWYjFtdm1QemFOR1dD?=
 =?utf-8?B?dlhQeERzODNoVXQ2a3YxZGVEcTNOMlpDYUk1Y3UydEMvWXc5YXhJbjBOQlk3?=
 =?utf-8?B?VFRtQ1R0R3dvYlJyTXBDK21vWHoyRmdVRjRCUkxXVEhvcjJmNDNwdVZ3TnFq?=
 =?utf-8?B?M2FmWTg4Y1RrZ1htakxRN3lEUHQxSVovc20zWC9VUGlNaEw2RnE2M2dNM1Fs?=
 =?utf-8?B?RUJxclRvUFYrMnp1QThieS9ITVRIR2xQNm5HTlY4eU5lMkFRUVc1cDBGUlVB?=
 =?utf-8?B?VlBjWVd5UXovdzZxblVZQnBUd1NsTWt3a1hnT1hleTM2N1JaUGxIMzRybGRJ?=
 =?utf-8?B?bVd6dG1EZHozTEgvdytTLzNibkxIYnNpREdmZFpmTzVWYVN2S2lZOVpPUE96?=
 =?utf-8?B?eEJtMFRHa0tQNHd4N0ROS1hYaHpiaC8zWG1meTE1d0R1QWNaWXpsRHR1SERM?=
 =?utf-8?B?SE8xM2hIeXZFVnVUMTR3V2d1N2lQRVRsNGJxVHVqcTkzMjNoZC8zRk45c0tU?=
 =?utf-8?B?SHVmVmdTSGVtS2tEWE83cnVkZ1E4Z280TGo3RDRRNlVVWTZzcjkxY2Y0cFN2?=
 =?utf-8?B?Rk5BQ28vQnVJRTJMODduQ0twUHZEUnhIbm1UT0g0eENqZERmc3c0NVFneFpF?=
 =?utf-8?B?VEhReFI4TGxGaitObERzRlJ4N3F0SVoyM0dFVEFDNm81bmE5bWxvNEp6alFX?=
 =?utf-8?B?UUc5bHJIQ2F4MzVLclFIdE1LY0x5QUpNRGZQRFRQV0hiRllVTTdhckE3MG55?=
 =?utf-8?B?TW56VFpXbVpBUFlERGhibW55VGpPdXhkL2pQQ0d6blIzbWViaSs4SWRqOGhy?=
 =?utf-8?B?VkllOXlZaFNDaUNYRHpLd0ppSHduUldhSFpUNXlnZHgrL3NKcVBtVUI5dC9E?=
 =?utf-8?B?azdoenhteENra1VGWHdscTZyN2VXVVRnMlV2bHJaRXpnSkJzWjR4Z2tVMjZO?=
 =?utf-8?B?QWR5em1vRTRTcHJNNGhsbU55MlhjRGhTemVDVUhwdUl1ajNIZ3pvRFFKSkd1?=
 =?utf-8?B?Tk03enhyQ3ZLSUQzdCtGSVptUjRYMjQ4QXBhWHBIdXd0YkgzUGdKSjh2Zi9h?=
 =?utf-8?B?Tlp3TDc4UlRQV0FYUU5RMi9EUnRIWUplSEV1SEtNVWlIOFJha042UU5yd1lP?=
 =?utf-8?B?bi9TR2x0RFpBRnhNUmJZZjVnMk5NVVU4YnJtZW5pdWJINFVlS09Dck5rNU0r?=
 =?utf-8?B?OTBJd0FGVlFDUllkWmxhSDFoaFcrcGZmNHJaSmw1RHhJSGJmZTJIRkRFaXJV?=
 =?utf-8?Q?dWco=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 04:23:01.1187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9fae7a5-4e14-4a11-0a13-08de20da0041
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4476
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

Hello Marko,

On Sat Nov 8, 2025 at 10:54 PM IST, Marko M=C3=A4kel=C3=A4 wrote:
> Hi all,
>
> I am new to u-boot, please bear with me. I got CONFIG_FIT_SIGNATURE=3Dy t=
o=20
> work with the RSA algorithm, but not with ECDSA.
>
> My two main questions are:
>
> Is CONFIG_ECDSA_VERIFY only implemented for the two targets:
> rom_api_ops in arch/arm/mach-stm32mp/ecdsa_romapi.c
> cptra_ecdsa_ops in drivers/crypto/aspeed/cptra_ecdsa.c.=20
>

Yes, those two seem to be the only one's implementing UCLASS_ECDSA.

> Is it feasible to support something more modern than RSA signatures on a=
=20
> reasonably high-end target, such as ARMv8? Are there any suggestions or=
=20
> git commits that you would suggest as a reference?
>

Should be possible, you can look at the current implementaitons of RSA
and lib/ecdsa/ecdsa-libcrypto.c for reference.

> Mon, Oct 13, 2025 at 09:36:50PM +0300, Marko M=C3=A4kel=C3=A4 wrote:
>>Hi all,
>>
>>Yesterday, I successfully built the u-boot master branch with=20
>>CONFIG_FIT_SIGNATURE=3Dy and CONFIG_RSA=3Dy and got the signature=20
>>verification working with sha256,rsa2048.
>>
>>Today, I wanted to try out CONFIG_ECDSA=3Dy, but I am facing some=20
>>trouble.  I am generating the key and trying to add its public part to=20
>>the device tree blob as with fdt_add_pubkey as follows:
>
> I got a bit further with this, using the algorithm sha256,ecdsa256.
>
> With a patch and some work-arounds, I think I understood the host-side=20
> workflow. However, the signature check on my target (TI Sitara am62x) is=
=20
> failing.
>
> Unlike with RSA, the mkimage command expects the ECDSA private key in a=
=20
> file like dev.pem, not dev.key. I successfully created a private key and=
=20
> constructed a signed FIT image with the following commands:
>
> openssl ecparam -name prime256v1 -genkey -noout -out dev.pem
> mkimage -k . -f fitImage.its fitImage
>
> I verified the presence of a signature by running the following command,=
=20
> which produced the signature in a "value" subnode:
>
> dtc -I dtb fitImage|grep -A10 signature
>
> For the algorithm sha256,ecdsa256 that I chose, the fdt_add_pubkey tool=
=20
> requires a patch to avoid SIGSEGV, which I am copying below from my=20
> previous message:
>
> diff --git a/tools/fdt_add_pubkey.c b/tools/fdt_add_pubkey.c
> index 5582d7a8efe..4f7028cc15c 100644
> --- a/tools/fdt_add_pubkey.c
> +++ b/tools/fdt_add_pubkey.c
> @@ -73,9 +73,10 @@ static void reset_info(struct image_sign_info *info)
>   	info->keyname =3D keyname;
>   	info->name =3D algo_name;
>   	info->require_keys =3D require_keys;
> +	info->checksum =3D image_get_checksum_algo(algo_name);
>   	info->crypto =3D image_get_crypto_algo(algo_name);
>  =20
> -	if (!info->crypto) {
> +	if (!info->checksum || !info->crypto) {
>   		fprintf(stderr, "Unsupported signature algorithm '%s'\n",
>   			algo_name);
>   		exit(EXIT_FAILURE);
>
> Unlike with RSA, fdt_add_pubkey does not accept a public key:
>
> fdt_add_pubkey: Cannot add public key to FIT blob: Unknown error -5
>
> I am able to work around this by invoking the tool on a _private_ key=20
> dev.pem that the fitImage had been signed with.
>
> I don't know if there is a cleaner way, but here's how I am embedding=20
> the public key to the image. I first build U-boot from the scratch,=20
> modify the generated u-boot.dtb, and finally rebuild to have the=20
> modified DTB included:
>
> make clean
> make -j$(nproc) CROSS_COMPILE=3Daarch64-linux-gnu- ...
> cp u-boot.dtb u-boot-pubkey.dtb
> fdt_add_pubkey -a sha256,ecdsa256 -n dev -k . -r conf u-boot-pubkey.dtb
> fit_check_sign -f fitImage -k u-boot-pubkey.dtb
> make EXT_DTB=3Du-boot-pubkey.dtb \
> -j$(nproc) CROSS_COMPILE=3Daarch64-linux-gnu- ...
>
> Even though fit_check_sign passes on the host system, the signature=20
> check would fail on the target system (TI AM62x) as follows:
>
> 8304957 bytes read in 346 ms (22.9 MiB/s)
> ## Executing script at 90000000
> sha256,ecdsa256:dev-  error!
> Unknown signature algorithm for '<NULL>' hash node in 'conf-1' config nod=
e
> Failed to verify required signature 'dev'
> Boot failed (err=3D1)
>
> It turns out that for ECDSA signature verification, at least three=20
> configuration options will be needed:
>
> CONFIG_FIT_SIGNATURE=3Dy
> CONFIG_ECDSA=3Dy
> CONFIG_ECDSA_VERIFY=3Dy
>
> Rebuilding with CONFIG_ECDSA_VERIFY=3Dy changed the error message to the=
=20
> following:
>
> sha256,ecdsa256:dev-  error!
> Verification failed for '<NULL>' hash node in 'conf-1' config node
> Failed to verify required signature 'dev'
>

This is probably due to U-Boot failing to find a driver with
UCLASS_ECDSA, you can verify by adding a "#define DEBUG" to the top of
lib/ecdsa/ecdsa-verify.c and check if the following error shows up:

	ECDSA: Could not find ECDSA implementation: -19

Regards,
Anshul

> I did not attach a debugger to the target, but I am rather sure that the=
=20
> verification fails because of the following:
>
> static int ecdsa_verify_hash(struct udevice *dev,
> 			     const struct image_sign_info *info,
> 			     const void *hash, const void *sig, uint sig_len)
> {
> 	const struct ecdsa_ops *ops =3D device_get_ops(dev);
> 	const struct checksum_algo *algo =3D info->checksum;
> 	struct ecdsa_public_key key;
> 	int sig_node, key_node, ret;
>
> 	if (!ops || !ops->verify)
> 		return -ENODEV;
>
> I found only two definitions of ecdsa_ops, and it does not look like=20
> either one should be available on my target system.
>
> The cosmetic error <NULL> in the error message occurs because the local=
=20
> variable "noffset" in fit_image_verify_sig() will only be valid if the=20
> for loop is executing "goto error". This bug is tricky to fix, because=20
> as far as I understand, we want to allow multiple signatures to be=20
> verified.
>
> One more thing that I noticed is that the function fit_check_sign() has=
=20
> an unused parameter:
>
> diff --git a/tools/fit_check_sign.c b/tools/fit_check_sign.c
> index ab3266aff20..3d1e66f2b58 100644
> --- a/tools/fit_check_sign.c
> +++ b/tools/fit_check_sign.c
> @@ -80,7 +80,7 @@ int main(int argc, char **argv)
>   			return EXIT_FAILURE;
>   	}
>   	image_set_host_blob(key_blob);
> -	ret =3D fit_check_sign(fit_blob, key_blob, config_name);
> +	ret =3D fit_check_sign(fit_blob, NULL, config_name);
>   	if (!ret) {
>   		ret =3D EXIT_SUCCESS;
>   		fprintf(stderr, "Signature check OK\n");
>
> The above patch shows the only caller of the function. It also shows=20
> that the caller is invoking image_set_host_blob() on that parameter,=20
> which is why the check is able to work. Maybe that call should be made=20
> part of fit_check_sign() itself? Anyway, this code does not execute on=20
> the target.
>
> With best regards,
>
> 	Marko M=C3=A4kel=C3=A4

