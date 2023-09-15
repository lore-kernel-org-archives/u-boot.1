Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0391FEE644B
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 09:39:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3B8486828;
	Fri, 15 Sep 2023 11:39:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="jVF/BjyC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D16A8689A; Fri, 15 Sep 2023 11:39:13 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8BFB86409
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 11:39:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpfdWGraRzoj1TWxb+zr7M9P6M9LUoNH3OVHUr+gA5l8QkKUhZy5auBB2dQYsSf0xCAK1YkbaS+CJK/YM84SQiavchOEKi8jV6PW3E4/KVb8BnrEnAJAVhMGK6e5YBL6FmjxlScr1fd78BGnmbZroU9TUbUGyYtjKaU59fv+hs0uisDdTQ6q5oeNfrfqjOa7ljw3f/YnBsh6/0khasvXZ6RUNaYt0Ao7dSDwfNgfNM95xP+Iwl5z9i84eFbTwtPS+muWSpkCLwk/U4yjMA5fBY2FTlBGO2dUVypQSg5MAE2y08CN7z4SgQZIewCSqSOFTDyoLUP99v2Hunh4YpBT8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKtHT6tBjeSyP5xmIeE5oOz4+bk6yRSQrrmvW5zdf0E=;
 b=DEsJmrwy9aB1fnvQX6juhHV17o7V4RSRBkl9B4UfOLD1albAvCpI9HzzzavTbDrureWQSwzcEWmOprWpS2VMfqW4ez8jW9/eq7l9RrFVJxB1T80OpDiVlgYz3FRGNUr19QBWHnIi/nsW9Zy5GBHMNKjnVtjemQy/aAz7rlM9mRDye/oFeVfL6kXP2e5/NW7ONHpPe67SklYBiway5pi0PXC0F3CxZv+CofNgn3c03YRmNg/aFFAVYmhafvkne07HzolSiJ5cMtxPHmo2eSv/oXX0DJv+0AcfVkcGqBX7oy6d3Jzmwji7efqD1GH9Ibcav0hv86O2a/Pv9M/Rlr7rlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKtHT6tBjeSyP5xmIeE5oOz4+bk6yRSQrrmvW5zdf0E=;
 b=jVF/BjyCC6QYgE2Ncvvhr7hCSMf4DB0T9Ff4U1lLkwMsyUDG2JvslmIayrpk0BzE39jbBoBj4/E1GUXajBCBc4N8eYfWbvA9JoCr1B/xJ3L0o0zTyO3p7BPLd9NIUH7lioQh+S3QLx0sH/rWkMIR21lp9K2GFQbPt0imJDacBbc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AS8PR08MB9768.eurprd08.prod.outlook.com (2603:10a6:20b:613::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Fri, 15 Sep
 2023 09:39:08 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::485f:c3e3:6ccb:ad51]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::485f:c3e3:6ccb:ad51%4]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 09:39:08 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH] arm64: zynqmp: Corrected pcap_prog register address
Date: Fri, 15 Sep 2023 11:39:01 +0200
Message-Id: <20230915093901.1062825-1-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::6) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AS8PR08MB9768:EE_
X-MS-Office365-Filtering-Correlation-Id: fc36a213-29f6-4085-6b5f-08dbb5cf9c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3FK6ajUJFbt5PJt/cs0UWDYLaTkmXuYNdQ0zNFyySKStP6xVm4DyrG5vLKnwS56/QfP9KSRatHln/HdXlh1GHzGCkPnxgY4rSh+gD3VKSEjH7Bpwe+xfj5W87z7VgqHRWfcO1HLVNAPHWG84++NfZU8hnS3/FVLEUPKKfPmK/U0tCjc09adK7BeUUGrMeoC/4Eh3T1GeEEdsyVcMga9oiaKcRokL0nod7GbGmywtcCIPPf6DcAPmx1qpIPkbDOK4Hv2yJ0KZYGaQgLfqxgkjb840xam/WUqQgVVlZ7CfIiU499i4h/7dsMENFejcRE7vWApJLG8Y9A3oKEsmrS1aIdE1TNXO4yBQ4JahY4rZwIw48Cz9llOJqwCyFJ+UcO3dSlFi+PQO7QerNANzgpejSTQYzAp62zR2cO3QlDiBstDj6YT/pzpWaTUuhpafRcyAIShCmc4GiCG474+jILpgX+L5e55B7af16Lt7HG5DCtdVop6eq8DVZgNbC3Dhzxj2/Wo0tfjgX+Ucfx2P9fWvyWTHe9a7Wx7lpsNeS2g8ttmWYKsL+kj141nOR9AYLKdchjturmlofA4Ky4Dvb4oJyGaLyRXz0bXxHeSYSQ1hit8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199024)(186009)(1800799009)(26005)(2616005)(1076003)(5660300002)(8676002)(8936002)(4326008)(52116002)(83380400001)(6666004)(6486002)(9686003)(6506007)(41300700001)(6512007)(316002)(86362001)(38100700002)(6916009)(54906003)(66946007)(66556008)(66476007)(478600001)(38350700002)(966005)(2906002)(4744005)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jDouyt5pI10XSvljVRwkzmeWwiO4fqz/EG5JuJCwb/uSFbM+VRS0SKrGzN+t?=
 =?us-ascii?Q?QnCvIH021vkrNEoqBISfGk0LP5DjieMnrsBFMW8pTuAGgY9GsVtGPH9ZYaxl?=
 =?us-ascii?Q?h/xDBdtJZPMdOnNbw0mAmZqvDlgiCtZ1DScUINzftIm/0fvs8JeH+4j3vBYJ?=
 =?us-ascii?Q?BqG2FZvWLjAcQF2+S6n/yn+NXFiVTP0o5sPPPD3xcIPmqYz61Pge8m+PIHs5?=
 =?us-ascii?Q?UQQd/kYRvbtKo8DkRneWk0a+9w5HpkFTIhWacPSnbcD7KMfKsjxtSK0TOAM6?=
 =?us-ascii?Q?PdI2h1k8LM7dyE90cf5VJ4zmcpRjJvRyXOklaFI53DLFrtBok73TtQ+oQqZu?=
 =?us-ascii?Q?ES7KRA+757OIUH8fZaUSL6p8xCHBR3FBYiItpOBXLZcIc9uXZtN026TLkVur?=
 =?us-ascii?Q?nUshhHnzw+Q6J4OU3/HsN79TXqhwgnZbAArrKb8SWkqWfALRADY3SCKu+uIw?=
 =?us-ascii?Q?1kIg5RQEHfwBh4XiVcuppXG+B/++WU05khcArk3RD6l+MR3cCl3Aa7fogyUQ?=
 =?us-ascii?Q?K7zdvi3uvc+KNNP/2uDdc8sGnbkoeoYlMWwzGgjOrq50Wtlw6fR/+G8/elnK?=
 =?us-ascii?Q?9H5f+zJ3coG7oUzodyi5VRgaEDqNYZYdzQxUygdrEbkoX/ktNIUrFt/SpbSm?=
 =?us-ascii?Q?l5fVhMh+P3zOyvyx3CXS+f3buXHN3fGM73fhEY/Gil8NEHnjwcarir9SDYMD?=
 =?us-ascii?Q?KdBE7b3d6wWuH4Fd9HQ0Lyl/7KmQ6HyvZt96llP9/oSp/q0rB5OhcienX66j?=
 =?us-ascii?Q?N0X2nRfHCFGiSQP9b0V5nHwfX78LeOtONEu7SdCEVNEIEg56piTW/3Kx6Qdj?=
 =?us-ascii?Q?NcBJDSfuaKJgcLJjQJ5Ziud4F46R03NYUaxVkrvDwYakcP3cRUt8Cws4C9N1?=
 =?us-ascii?Q?iO07FEnilkD/pAfsLsLqmYmIjOemcsVL+q3MbpQCvqA/I1igiFqX1F9HmprQ?=
 =?us-ascii?Q?g6Tb9ulq4LAJFB8WYfkWTU7wlQ0zIWNSNGLbkLRNIDe5TkHMhhPjWYWmPzBm?=
 =?us-ascii?Q?v4Gw22peg/LbG8IPHz3jDkebK+vEacLvlu+qUXv/1hMtY8rYa4seVYxLdaCq?=
 =?us-ascii?Q?bMYdna0Rhj7bI9vYom0orSbQy8ygQZNYBH6MYPvJhb1s0+A+mO3hVZBjl9KA?=
 =?us-ascii?Q?GMn04oQDh/FeuA9tPO0OHJ+UIvfzMelBVA5Ufop6lIws5dWLttQCykcUZ6cI?=
 =?us-ascii?Q?kLisNbJEVj6uPfcBIimdo8K6DpKAR7VHJXambulR9DsyKA3YcAxYxrRcq1B2?=
 =?us-ascii?Q?/3lnX055jMMEWSGKiXja72Q0CBQ35tfJvzSNNWJtIs1A62EVHad16UWaV0EJ?=
 =?us-ascii?Q?Nys+o+lkR+fEaPIX4IBqf52iXz4MhJcpb53CvilI3S7+gwGzRuVDCj4I/ay0?=
 =?us-ascii?Q?As8C9yhkmmkGEajMS1b5ouRGFgWRTc6hVQa7COO1LTAOJ64d4bTF+UkukJwI?=
 =?us-ascii?Q?MzDcWYopNbcKN7X0Mk9kwTh/FLqoQlfzaRIFZv/BERr2U0x7tq8ZX9fS/Dri?=
 =?us-ascii?Q?b5ytxbwxHq5see95aoBUuKAHRqQbPJ8+FGQNL/or1hHJ/eER63jG1zuqfAgb?=
 =?us-ascii?Q?VEdTNz3pAeyxCBbU4r+0t8Bo3k5VP0Vp+WbDySItRMnJvxkPILOoInxnmzTU?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc36a213-29f6-4085-6b5f-08dbb5cf9c0d
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 09:39:08.6244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ocdRg3V4ibFbhtlTZEbfivbfEAfLABb8G/GmgsK65aIewKWaGUazu0dzfffPAtktMxipQxkCIJyypA+WvrY9iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9768
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

From: Lukas Funke <lukas.funke@weidmueller.com>

Currently the pcap_prog struct variable is pointing to 0x3004 which is
incorrect according to [1]. The variable should point to 0x3000.

[1] https://www.xilinx.com/htmldocs/registers/ug1087/ug1087-zynq-ultrascale-registers.html#csu___pcap_prog.html

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

 arch/arm/mach-zynqmp/include/mach/hardware.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-zynqmp/include/mach/hardware.h b/arch/arm/mach-zynqmp/include/mach/hardware.h
index 634bf169c6..8cb6494e52 100644
--- a/arch/arm/mach-zynqmp/include/mach/hardware.h
+++ b/arch/arm/mach-zynqmp/include/mach/hardware.h
@@ -166,7 +166,7 @@ struct csu_regs {
 	u32 jtag_dap_cfg;
 	u32 idcode;
 	u32 version;
-	u32 reserved2[3055];
+	u32 reserved2[3054];
 	u32 pcap_prog;
 };
 
-- 
2.30.2

