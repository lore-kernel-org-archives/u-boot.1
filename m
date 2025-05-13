Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F761C3ABCC
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 12:30:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B22482B41;
	Tue, 13 May 2025 14:28:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="sHYeB2vR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 727698091A; Tue, 13 May 2025 12:21:19 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::604])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7391381FAB
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 12:21:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rpMUbNr6BwS3i2Qlod7GGlqsiv0gUl+zSV4zawdox8xEh8pD59WSAb8wKQYv930tOPY8eRkWL1eTifc1x3FGtaEuNzh5tAHi8L1Q+7NFmGSQOWeSwqweTCLhmRb04J5RYUk4x2RH5h/DR4rtB7ERiY1X1ahEZnCS/z64/01oQ1HkoR5yAzAbVgs+bdsvl0BDey+f52wxYpg72sQ4V5yJkcB6lywZaY9kVw7w9kdPedCskVj6jiV4WoKGhMBvMz4s6viUy0NKybfcjIxVo80U+gp00H0vLBhiataJP7C+D2hw9oEzfj+YCqmCXqoQKgWZokBGolTEwu26CjybYyFIBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a73NyAe9NrPJnHlqdqg9vp17fVDqky4fruwqhru+k+Y=;
 b=pBUCqMvoDIGdSIRd57Ajtqkzo7uJuqTZ9b/lc7fdacGynGp/dBUwJS6Bqu/DexROFyPBENic4e6xXW/jPRA6FWOCOVyQ7JZaTBQBj7vc3SqfaclQOzw1q0bA+fiNVwBPfFFBEg2wB1+PAmndF0Dlhp9wZZffQDJSkW3JK5LqhG9aL0fok7EdqMHNYa76MQx2NdWXxbp/jRvPqhZP2/Sd9dHmKFgH50GOS0Om/KL8+lWnZBgRlJHk8A+LAoQqs3Bfg1uj/aXn2TDbZv/h85woC0W0uHfkdnX1zHbiLnK0Yh62bdfY1AFd+3/X0gTBVq+uDlOn5br6NvCqEthX+YntCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a73NyAe9NrPJnHlqdqg9vp17fVDqky4fruwqhru+k+Y=;
 b=sHYeB2vRyakFEd8ss29/vMLvVV6UPX7W+W2wUZE2kWxc8xxiuR4wbsqGih6C2w2eiw2hrPH2bptnGSi//8rI94Ni3sdUSwNQDwRxMwRW1dxIctXmFL/JWW159EXSeGLIYQQ3sR+38diDPYIy0/JWq9LC2GmeraRNedvFsKA57SReCqv4OFzXJSUg/uF+iz9ixT8FJbJNa3n1XRnv83CDigyLOxPqyIFndaOQmvHIOX3VGVWg037Bhnof5FCgIAD113vRAYYRlKOljknwJqT0BcHAzDf7r3pXL7ovZEnc5HZRmzupW2MXpOAhWV+9PUCMyU+aplGH5ve53dl/ZKgLuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN7PR03MB3410.namprd03.prod.outlook.com (2603:10b6:406:bd::11)
 by BN8PR03MB4979.namprd03.prod.outlook.com (2603:10b6:408:db::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 10:21:15 +0000
Received: from BN7PR03MB3410.namprd03.prod.outlook.com
 ([fe80::bf20:122e:c7a8:10c]) by BN7PR03MB3410.namprd03.prod.outlook.com
 ([fe80::bf20:122e:c7a8:10c%5]) with mapi id 15.20.8722.020; Tue, 13 May 2025
 10:21:15 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v5 11/12] configs: sandbox_defconfig: Enable configs for
 sandbox i3c
Date: Tue, 13 May 2025 18:19:12 +0800
Message-Id: <20250513101913.30880-12-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250513101913.30880-1-dinesh.maniyam@altera.com>
References: <20250513101913.30880-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::14) To BN7PR03MB3410.namprd03.prod.outlook.com
 (2603:10b6:406:bd::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR03MB3410:EE_|BN8PR03MB4979:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc7f7be-8f96-4bd5-2485-08dd9207e4b4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dCJt0R4SU+3H6Ba9cdfpPK9H+YXW14ott4MhgBUusXBnPIUWNvj4YY0EO2O3?=
 =?us-ascii?Q?WJeBk3jChSvC6Jvh7Owc+cvmOFccjimCvDYVcL6OHw0AeW+zmumBqWPCBZGc?=
 =?us-ascii?Q?uShEOTmxww8U6HMF7FdpKKbaFevc+eBppYvs0uJtNXMGmJzf8ifS2cHxnICM?=
 =?us-ascii?Q?KFmNjEdHdfx0MFZpUSiLV8J/7al4PkmDRnILyxyrsHZ7yMHekO7BVcp3oWUz?=
 =?us-ascii?Q?N4xP1wdI7F0GYLr9TP0dgiu/L6YqoSehApHF3pBhZXOSZOIzJljvcULEuNyW?=
 =?us-ascii?Q?LJcNcfVXdaInNI1Br602cpJ5a3gW+Dr3n17PxCw1DKOomGYjtdmGEluBJH6I?=
 =?us-ascii?Q?CwqsciwxZLg7D747JGA5FmG/JFokovVE+cViy9+2UwNtCJYJ/SfjP2ZwnpoD?=
 =?us-ascii?Q?ZLK+OtN5pcWGbT5KVQYyCSnulhSA0g0A93TZZ2tzzrtezwjBAzkIl9LIwYT2?=
 =?us-ascii?Q?JzScNuG3ct58ZS2X1RYDDa7etEfvWURs3mfPs8EzZeYAeGH4/G7QcRD9TDYY?=
 =?us-ascii?Q?c/bSuA/8Ru6NtLWLVo3h2JH4VnWK3Fde73jy70E3/pAv542NFdW2nGbc6GuP?=
 =?us-ascii?Q?nyS25RpEKZBT5N5lYJYUJvi8VHXrfVtEHGjXnZ+LdmasoRz1U0Uh5s+B81LN?=
 =?us-ascii?Q?+Ml3VKFfCzT2+5/ezwa3XSPYDYk/+ePn6rz1xXC3rOYfK0FOvLINa//w2aSh?=
 =?us-ascii?Q?6CjUqWXTlU9RMjzPBmMn/XqqQ1MgIvexenUsX4kHOoSZtwrdtgECIauCG3QX?=
 =?us-ascii?Q?3eFiAag54u+PFn7OHrK7bk9Kt8O3zaYkC9jpKunRt5fZpp7M4qhiGaLgtDAm?=
 =?us-ascii?Q?m9tsv2DrqRquqt8Mr8pvjEgKIwYekzdtnv/0eC4ZJX0zuZa6u0FqkEXnEzLw?=
 =?us-ascii?Q?NZD0wsQhVUvnQ1gZsBV3Ho5rLX9gpw5AJyzSSe8pxpLSZ2nH+ewRZ17kfxDL?=
 =?us-ascii?Q?AI/jwEsIgRAk7cIUwijFDCnHgSqvbu8uMoQ3MgeXZd6Wd3/eehK8/bRuyqv0?=
 =?us-ascii?Q?WzyU3XDB6ntzQBrpxGm2WfE/Lm5KyExrxk1EsAbleHyhqXbjaBrvnRBtv8w/?=
 =?us-ascii?Q?gDkeTiT8lp5hqsQvndpUwHYLfVs7qZ2KcESoAFP1dq4VsKM/qEXFl/CL5viq?=
 =?us-ascii?Q?hpM/MPfCsdMIrCdGOf591+HVXooqQ4KxjAZEOVwANgEi/2sU2eI8O7ihyPvs?=
 =?us-ascii?Q?R8l9Hiwrs0TajG1hW9d+Jvq38UWSSwrOxPD9auSkQHn1MqH1jNXBkkGidfMM?=
 =?us-ascii?Q?X8yKUJtQG7SJHIADdRyDo7pZyzBas7Sd/H5jmcrIZpj59RKc9bL557wLCRnX?=
 =?us-ascii?Q?uDjPO/jqeElFjkq+vopqnGQJO0IQqKbn7JcIqhgIm134sQ5UEquoGF2DCz7D?=
 =?us-ascii?Q?szssfNWbDgmtAMFIIJzC5M1szI52PiRJbk2sBy7hpFTiFzJpLKInrUjgJdw1?=
 =?us-ascii?Q?BKGkfCUeqrU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR03MB3410.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ldkBhRtMb40iPvUfApl3TgZS9fnnDDweH42QqyDjAvPhCg9JUYsNYrs3wmF7?=
 =?us-ascii?Q?ukCVNFm6iXPqsyEVwN1q52uQ4MsjGFA8A9cGqExaN7USrw8d9HHVg4Nmv3G7?=
 =?us-ascii?Q?R83ghgtLJy7Y7TGDaBpDWGyPpbb/My2nnlzByE+ecazGLDer8xmhk3duHQOj?=
 =?us-ascii?Q?b7HMREimJ57ZL2Ia9d6OlC9u9gk3cUBmhZw8eW0/w++jUAY1P6c08EmJmlxL?=
 =?us-ascii?Q?bznk3+G1aEiaZlExU+XSy/gf7vYhTYBka+4AGybIxkgmgZ+0g9zC2+CiB/7j?=
 =?us-ascii?Q?Uly6MsQLBb1l7j4V1wf6B0TBiNdXJJjhYyxKknD4/spQrNcVh1daqha9xI0/?=
 =?us-ascii?Q?qBYo8XGWsrJsUNG2hKsyLSUjg9otTBRtLIGcKxkVbmDqaHULWkdParvReHEW?=
 =?us-ascii?Q?35VQzmYeW5DuDJL3Bh1jhs89RqzMVjT2qvbv4pHEydUC76euvJwcFDaGW/0d?=
 =?us-ascii?Q?Iaog7xaZ7cTrNqFBAILGZtC/niMmfhABErsZ/X8gEg8OhXGuqy67kYoCppX6?=
 =?us-ascii?Q?c/IqTNyODTYrpO3nhsGbdpIS6BFuSZKWh2P2+1BThmJTdzZe3nKwaK2fOtFR?=
 =?us-ascii?Q?w3/0lq/8TGBKv+cFJigw73Q7D1hXk+prrmGmW3oe0g0qfCjrFF/OPyN3wwpP?=
 =?us-ascii?Q?HyCcjTa6SDu9zQUcSvZV0Of/svgQ1sb8NFYVKKePsJEmakb+agz1cC8qgpmc?=
 =?us-ascii?Q?PJNKvHgjtiVzzqHvPEL/lN3iomicHyV6MDxBhgBI1oB8890WcK7IV1IiBfne?=
 =?us-ascii?Q?MBnZvzlrylHFArNAX814O6jqGq82wWcJIfAib1zhavb0ny2ru3/2jsafLHdv?=
 =?us-ascii?Q?UbeVoqoguYEhLHGJnqN5O5smuknF3eH2siKNW+0Y3s/L7ZaPGwZnOWdLi3NF?=
 =?us-ascii?Q?cea8JVK+7UFvG9TYLIrnRys0j773NlSzQQ/2N9uyxgKL3CNHL/hWvIaYGwCh?=
 =?us-ascii?Q?J/HJ3QHXtX1BBSahAz22+PkPlGOSAJdcaT/ezG06eFVt8K4HW1+dJY6xWUrU?=
 =?us-ascii?Q?b0mR7rvZDlRCfAew0ZYiMV1cMngY4KRpDbTMTEWRBaemlNTpPV8uTw5Ok4Zv?=
 =?us-ascii?Q?lKd492of6o2nDCDLrWjIAsqaZgiSGA08BsBE4eDRUB37hdfF9AHpLLd1Prmq?=
 =?us-ascii?Q?pFsOvAydrDD3mjhVNgSPJWsleUOt3OuORV6cwtEtTYLiWLc2rE7aYb0AjHru?=
 =?us-ascii?Q?OWE42DRkS+7402tiAW3eV+ARuVIvUOjGbf5eEfH0gx+8/lfT6Y4/5rZMAfnr?=
 =?us-ascii?Q?KuVy0PdVdavuI8e5vglikksEb89wOluSvkpTMwDg2yPBLv+jwTSMyXAye8SQ?=
 =?us-ascii?Q?sdVGszAO4fS/TpPQzLlZ5CTNhKNLmoIUJ898tyAZsi9BwAc8qqgie2jiJG4+?=
 =?us-ascii?Q?aKFkeazwSoZpjSKSsPWKKPROAG5MK6JYTiF8FzJ1z045KmFHyubYnfjdVYNk?=
 =?us-ascii?Q?PGMjkC2hL1ny6XQgevABA1tcmRQRkDLdwKbvle4yhEu/DQilqsUQWO8S/rWJ?=
 =?us-ascii?Q?Uzu8zoKt6jBaWgblvTNK6Jly7bGB82CGKACeCsqcvTkJjZJURtlmRTI36zhG?=
 =?us-ascii?Q?ryEVGmC30eXmar2ovKqjBq1+9GvSIqdzsXlq1cdYGPaMxZLXmX+7F5qhNXQo?=
 =?us-ascii?Q?sw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc7f7be-8f96-4bd5-2485-08dd9207e4b4
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB3410.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 10:21:15.8733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YstPA2xNqr6BmAAjdCySetp0w2vBnYpRoQ1bao+6bvsydybwgKYqHNrSVcbwpHiOUwm9SGqbTddBc9pIH0iuUaofutHM/xzDwz9AztRbrY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4979
X-Mailman-Approved-At: Tue, 13 May 2025 14:28:49 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Enable configs for sandbox i3c.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 configs/sandbox_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 861a1f4cd90..ba98cb0ae99 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -85,6 +85,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_GPT_RENAME=y
 CONFIG_CMD_IDE=y
 CONFIG_CMD_I2C=y
+CONFIG_CMD_I3C=y
 CONFIG_CMD_LOADM=y
 CONFIG_CMD_LSBLK=y
 CONFIG_CMD_MTD=y
@@ -206,6 +207,9 @@ CONFIG_I2C_CROS_EC_LDO=y
 CONFIG_DM_I2C_GPIO=y
 CONFIG_I2C_MUX=y
 CONFIG_I2C_ARB_GPIO_CHALLENGE=y
+CONFIG_I3C=y
+CONFIG_I3C_SANDBOX=y
+CONFIG_DW_I3C_MASTER=y
 CONFIG_CROS_EC_KEYB=y
 CONFIG_I8042_KEYB=y
 CONFIG_IOMMU=y
-- 
2.26.2

