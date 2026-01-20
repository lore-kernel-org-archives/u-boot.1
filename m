Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9E1D2ED0F
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 08:12:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EA4783AB8;
	Tue, 20 Jan 2026 09:12:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="RpyC0UyR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D769A839E8; Tue, 20 Jan 2026 09:12:25 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D57DA83A83
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 09:12:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgUckwU4/KgQdRpuTt6LrzNtnXFhT49XGkeiIIl7MU5P/yixAk29laxln0Lgumcqy5xSMic5OW2PdR2Za174of1uqE9qzqlL1XI0wXjRYQxAGeGIZ2Mv58bx8D4bLHLddUw0hj1ZH/6ObQJyXVI13zqywqxt4DYYa3nw0Z+FdcAMJ9HxdH5KY7u7/Hc8u/319qbqzesJMEElZ4G+X+YEcxcKENRKQ9FHBmX5JL1wbtJOrwAEyd8ovDDGCrv3HtRrmP6i5m3k45Q8tIbzMpnwytK46AZfvldgO4QW36I7SloZ8ht/JYYNX+W5Tkit5MKyZQn7q418vPIl+2snQe/iog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/gUDvV9VyUgBRzNv3Ae+BAF/m1pAeba2w4vc/H8QkE=;
 b=vWRtYxJbnaxyiCAsaWuUAKRoJuUBgNZcGmLLfMtOHXdyrH5X6SSfZuJ6m1vjI8jgCi1jawBrsap6BnujLA+QfvRrIuRJH4JPscnpsY9UPVGAJ553q836O4Xgrc7FcMsECgz2t1b5lW+2KNgPYgmZ04eOkNVanCx2GtXmWKUtHwf5YWT58hv9aHCosfPqEoehLW/KhhtrJbDw0h2UHtnmuwGWjySGNzz+nF/lpqY4FFP928A9UWapCEzjvyQbvyofbZHj62pZJr5FEudB/E8Qa87lh9lBbN+n8dNGnYOQfbf2iNz+LGnwY1WTliizGWC9BXyS2fKRKCbSyDdvbEtrwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/gUDvV9VyUgBRzNv3Ae+BAF/m1pAeba2w4vc/H8QkE=;
 b=RpyC0UyR6EquuL8jbzCmQgx7kJ8Im+C4Nx4rv/62S9vNCxE4lOe4FWqUkt1VFx70U7czSVRUJq4D8qGqUq9YNr7t41Lta9AbAzecrx4snq8ZNmX+zBUt35A+/dev2Z37oFU6KdQGnNrCMuIKtqEr4M/o/twwbW3VAJxwV0wSJuejk2hxOiiP1NIxNeRl5Ru24NTBazueqpFxzz+CcJtG2jWprBiXo90h75NnuCQBoZCud0NYY3vzuDmkA0TVMySL4gOm7q9sX89ygwcxVe9dAFIyfN4RUHz71e13vuLcojTK/9bEhj76METFdRHOF3RB1zlAnKbwwv52RLDWxsSeuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by PA4PR03MB6750.eurprd03.prod.outlook.com (2603:10a6:102:ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 20 Jan
 2026 08:12:10 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9520.009; Tue, 20 Jan 2026
 08:12:10 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, trini@konsulko.com,
 simon.glass@canonical.com, quentin.schulz@cherry.de
Subject: [PATCH v4 1/6] tools: mkeficapsule: Add support for pkcs11
Date: Tue, 20 Jan 2026 09:11:58 +0100
Message-ID: <20260120081206.251544-2-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260120081206.251544-1-Wojciech.Dubowik@mt.com>
References: <20260120081206.251544-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0199.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::21) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|PA4PR03MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 3133e90b-8009-4a95-ae4a-08de57fb9c45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|52116014|1800799024|366016|38350700014|7142099003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1MPgNIlEtneCukunDm6nrqzoCi7QINIKTjXY6weovLd3PJR9aBVI8llxwVOP?=
 =?us-ascii?Q?BeAdoxFo5uUG5o9aFdlB/DLspfhMkLqT/MRyh+Xp66rc8tSsk6GncAbyjCNa?=
 =?us-ascii?Q?hSJhAdDRZrc7IfhrH1cQNnZHpsnZOAl971iETtZForg4wuDiJDtBDzN78C2s?=
 =?us-ascii?Q?j1PjvpRcZHPE68zqkx6EiZfjE9xV3cbQh4LjMWkvunJoou4wFaPPDpk+hTUh?=
 =?us-ascii?Q?7nYtyRY4Hc1zAmZGmPaMHZvGTq9IBR59GicoAxFhkBR5xy3ZteT7hL8UZONx?=
 =?us-ascii?Q?sx40Nm6DIE0CTxGG2snSr2tZuVDtTh7SXajpb2kn2hjpprjqC0nbRNS1/Qcr?=
 =?us-ascii?Q?yzRPoCJgpswuT1C9iCv1oPsyivzTX2sjdTEATKNgvl5yTi9mmtNvB8eF4+1Z?=
 =?us-ascii?Q?E6cxDzv6xSDnJn9Xu1U49fxw6n0c8mpQWbfuuVsJW1mjyW/scWyHeIXNwqTF?=
 =?us-ascii?Q?4pDvecMOcwNTDkeghh7uLcFUVWDcSAbHxvTRtOu+As+s+azDo57AyOGJOEts?=
 =?us-ascii?Q?v5rz3DO6VNrvMu8QSNlSjOgv8x5GWaa3xgp6bPMNbRFfgeZ2Kj6/WDZ96Pbj?=
 =?us-ascii?Q?YmqmZDckBqR31VuSX2Sp6g1O+o/mS2+Vf0d9FyPd60HgE64hlqORInA9ufWy?=
 =?us-ascii?Q?VdlUIPPPaCZlL5fmHQS8Z/3yBz8qigaLGG0iv7thQkLS/xSNdyDsWDHK6Dd+?=
 =?us-ascii?Q?1K3qiNq9q06QfNjvBTZ7mPG5ncvG/K07hCgwdyLzx9OtE1QH383f4LNyAOSe?=
 =?us-ascii?Q?J4zzTsni/+BEB238P0u68rx/Kb8b08RLXGZC9zRnAyxbiwMgnOiTSrWd6DrL?=
 =?us-ascii?Q?TLW6wn6irT+qfPBCpbNn54/5dEPp9LQ/Q+v1CKO2Y9BuSKqGbmcpZDZJ3Oht?=
 =?us-ascii?Q?BxGI5CTBnFRPXoi/SE21uFjy497koPFxN38w+b8pVGKyyE0DL7fvryPfBKS9?=
 =?us-ascii?Q?eCODLD+XxqQ2Spv5h5R3Xyyin2maGc8/cXh3A1H0n1zwX8DDpEDAixl0fFOd?=
 =?us-ascii?Q?WhZGawjeohSngHOK066WikQ5XV3tVMqV/CB7oqoo8uQ3uN+mF8dvLbnvvZWh?=
 =?us-ascii?Q?Lje4LLIIJs6FHUgfHnMMO9MiOL59mOjdlfvdLVtOsDq/sIpR79m/javDKu24?=
 =?us-ascii?Q?9bn6/XGFKu7QdwN1jhji24xdkVD1wMcwhxUdEoxBTTVPLSl3iICiMROEJg+c?=
 =?us-ascii?Q?2Ev898cQxU0xCVAuU4sRhi2jp/ERupO/LsGFZOegOyeUcO6ru1mjixJg/vsQ?=
 =?us-ascii?Q?Le3dz7DV/cS0onYz0Y9N+GuyFGWPMERB9RX2+qff3HLJUX4SFvjOIGQwuz7J?=
 =?us-ascii?Q?UOJLxHqGOI1rq+Rqq0zPiehEIW5itYewean9oQOWkAF3VI4xV0uXntQ363P0?=
 =?us-ascii?Q?PGB/4nv0oYVJCPscGyn9npl8oNG/wivIhHmnlFXfF40dYh8C7tzlPbSuvNgo?=
 =?us-ascii?Q?FI35mA5NuvSuSqIYMGyje7VZMFJsCWbwAIzZGdvkta3hk9TFojIGlNXJZV7I?=
 =?us-ascii?Q?yRCNR3rvtIQWvTeHJZYaR3mx6lyJPKn4dv4mIoV/Hid0OKvAw7Mv6ItFUht1?=
 =?us-ascii?Q?sRlsBeaGQzMnGqLp1OaO0nsT/Tb1fmQgjZlSrjNmNp2xn9MrBPQVNDkaQgFp?=
 =?us-ascii?Q?rLTI4kTvcrdrEzGowxyPrp8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(52116014)(1800799024)(366016)(38350700014)(7142099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3iaotpf/0UXI0fSal9nJhI3OYz1/+Dmk8vDSnl9ln97Oh8hq5WiooEjX989L?=
 =?us-ascii?Q?AG/9DP4Mt6RFa88Kx0q3OUkJ41HuZ3dWHgYKuP4dCqlBSPWMKXhfXwwrNt89?=
 =?us-ascii?Q?VMOHbU/ZFjWI2KSgkpNQiZON6IpaGAAaDIy8sEzf4ZvIuxgLhlty5TdL25CD?=
 =?us-ascii?Q?9lAdJ2bDsDPxXUwdXkUOirofjSdLxUsREXHA/cdNPYAMNtiq+nF0SHnpxKWA?=
 =?us-ascii?Q?jhUmY+2Acv0VoVM8CDxvM77CX4G16NXq6WczeTqCf7POaL2NMEJBVLJlnkN6?=
 =?us-ascii?Q?77geXmZO9/4oAW4EQF9hyX5eddvMxaQUf9pzdJtpkc7jxBTUyz5GtXBp1/oC?=
 =?us-ascii?Q?J80YXAClJfMLVtZBIR6lKlovK9dvhG1nd4eSRRjoi/cFjClQ5KUv94zZdZ6Z?=
 =?us-ascii?Q?eUu+peCiPrFlnu4hLGpyr8p22JJTgmeawVOVFQA/FJd76cl8OgnBB9VGHBh+?=
 =?us-ascii?Q?LDEu2xtNmRTbR0BToFqKsjAk6AnGogjtAvWwcPapEvNZP9uS0v6r2bBaxcLF?=
 =?us-ascii?Q?d0//AvYWMMwk8ntdw0XJu5yqGkAxF46tVsYh7tDJdjyoSo9G5EGqudBSSBL1?=
 =?us-ascii?Q?VuowAwIRbgJqx+tQZCgHKdsHsH+iNEGX7XNHm19IKBH0ULYxAqIRi+uqnU5R?=
 =?us-ascii?Q?yo05IJDN4pI9fLGOhJSPtwtoit2BaXz33iNszAFzZsyNgSsFvSxdTQu0/N/z?=
 =?us-ascii?Q?z7VZO67F/y6lli/AXe85Kg05yvdZTfVBQNOXrxUzh0Gito9RPnKJ5bDgKAHN?=
 =?us-ascii?Q?SM8P2XkzByvNRZlOFDnobSmyU+xn2vX+srJGUYUKULEEAIiSQwnfXc2zJ3cq?=
 =?us-ascii?Q?EKYk03cLnyMsQSYobOq5rYY9bzLU4eBQEUN3EI2+9yxU7CgzTFfE//6Fl+3u?=
 =?us-ascii?Q?BQQBcl2f4f4Fp0QQhGLE1LEPn+yylR0OIPa//tosa0i/14ZadO1QgQ7GhdnD?=
 =?us-ascii?Q?SagDWpUNULTm04IYdN/uLwuBFpeERgxffORVqIm2goyMfw5L0U0Myhuh41cC?=
 =?us-ascii?Q?VEDsYaL642MgYFbVSD1TCBN6g8q2IdwRBP1bdCH5PIYsvxJ3zus4ldJt5eQL?=
 =?us-ascii?Q?+BSj1J2VkW/tsZ4H0B4D1mBSAGgyC5C98mMsFzX0HICbDgl3mmljErBCoidx?=
 =?us-ascii?Q?0DYLysSGJNgHYWdtqZ5V0YQhWi8Eb3kQaUVx1q/2++fvymv1NpnTcB31Vzrw?=
 =?us-ascii?Q?mpjrY/ZiDMLNDYrFwimLdqQ7yx2yaeUf9j5fTcKvkuL8QjZ8RhM+P43wGBG5?=
 =?us-ascii?Q?fjblFvYBYl5phCR7OCwmc7dzX9zDCpJs8tS1T8jIaROYmNudcdsJb3ZEQiLE?=
 =?us-ascii?Q?YoagD/NUDYa95m4wYxNpJXsEdn/EaT47eVk+i0c+JV7GdD6Tojyaf5S3XIxK?=
 =?us-ascii?Q?lF14CAygLRFFIvzG8sz5zqB0D1fvNAww/rlZ49ySajBYTYtqoxXOr1sgwoyu?=
 =?us-ascii?Q?8XoPIZiIEdlnMxpXub7yDDF0uZRUT3OyZz1sRnusotvaNKOsKTTie0ukjJOF?=
 =?us-ascii?Q?jvH+jfY9GH6ns9fnWssPR+C6FJoRKRWRsjrgpHnYeY/y7YAkexjyXtqSZVQO?=
 =?us-ascii?Q?X0GmhkZzp0t+aFOpsSmrJtpnbbl5y8BuVou7qO8jKE5nQk9W65tZ9sv4Wdhv?=
 =?us-ascii?Q?GXalnECF6t+Ta3ev4r6u4HXbtF3xvCB1KWkrNbjU3B+kjG+acO1pxQjtbNtS?=
 =?us-ascii?Q?9VLOYGD2mUKFiT9KhwTPGjFwoJmJPhdLWcadyob8mLEAY4cnFk34umnpPATC?=
 =?us-ascii?Q?0M3bFkgLUg=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3133e90b-8009-4a95-ae4a-08de57fb9c45
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 08:12:10.4336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ze4GZ5vmAxgzmA+cRtvEtj1aKABBdnADNjz9NTwuaSg3y5kfYSzetTBVFq/7eJYvZcItnAMPxCTfHkz8svBs6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB6750
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

With pkcs11 support it's now possible to specify keys
with URI format. To use this feature the filename must
begin "pkcs11:.." and have valid URI pointing to certificate
and private key in HSM.

The environment variable PKCS11_MODULE_PATH must point to the
right pkcs11 provider i.e. with softhsm:
export PKCS11_MODULE_PATH=<path>/libsofthsm2.so

Example command line:
tools/mkeficapsule --monotonic-count 1 \
 --private-key "pkcs11:token=EX;object=capsule;type=private;pin-source=pin.txt" \
 --certificate "pkcs11:token=EX;object=capsule;type=cert;pin-source=pin.txt" \
 --index 1 \
 --guid XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXX \
 "capsule-payload" \
 "capsule.cap"

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
 tools/mkeficapsule.c | 110 +++++++++++++++++++++++++++++++++----------
 1 file changed, 84 insertions(+), 26 deletions(-)

diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index 0f41cdb64f54..a61557b73bef 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -228,21 +228,54 @@ static int create_auth_data(struct auth_context *ctx)
 	gnutls_pkcs7_t pkcs7;
 	gnutls_datum_t data;
 	gnutls_datum_t signature;
+	gnutls_pkcs11_obj_t *obj_list;
+	unsigned int obj_list_size = 0;
+	const char *lib;
 	int ret;
+	bool pkcs11_cert = false;
+	bool pkcs11_key = false;
 
-	ret = read_bin_file(ctx->cert_file, &cert.data, &file_size);
-	if (ret < 0)
-		return -1;
-	if (file_size > UINT_MAX)
-		return -1;
-	cert.size = file_size;
+	if (!strncmp(ctx->cert_file, "pkcs11:", 7))
+		pkcs11_cert = true;
 
-	ret = read_bin_file(ctx->key_file, &key.data, &file_size);
-	if (ret < 0)
-		return -1;
-	if (file_size > UINT_MAX)
-		return -1;
-	key.size = file_size;
+	if (!strncmp(ctx->key_file, "pkcs11:", 7))
+		pkcs11_key = true;
+
+	if (pkcs11_cert || pkcs11_key) {
+		lib = getenv("PKCS11_MODULE_PATH");
+		if (!lib) {
+			fprintf(stdout,
+				"PKCS11_MODULE_PATH not set in the environment\n");
+			return -1;
+		}
+
+		gnutls_pkcs11_init(GNUTLS_PKCS11_FLAG_MANUAL, NULL);
+		gnutls_global_init();
+
+		ret = gnutls_pkcs11_add_provider(lib, "trusted");
+		if (ret < 0) {
+			fprintf(stdout, "Failed to add pkcs11 provider\n");
+			return -1;
+		}
+	}
+
+	if (!pkcs11_cert) {
+		ret = read_bin_file(ctx->cert_file, &cert.data, &file_size);
+		if (ret < 0)
+			return -1;
+		if (file_size > UINT_MAX)
+			return -1;
+		cert.size = file_size;
+	}
+
+	if (!pkcs11_key) {
+		ret = read_bin_file(ctx->key_file, &key.data, &file_size);
+		if (ret < 0)
+			return -1;
+		if (file_size > UINT_MAX)
+			return -1;
+		key.size = file_size;
+	}
 
 	/*
 	 * For debugging,
@@ -265,22 +298,42 @@ static int create_auth_data(struct auth_context *ctx)
 		return -1;
 	}
 
-	/* load a private key */
-	ret = gnutls_privkey_import_x509_raw(pkey, &key, GNUTLS_X509_FMT_PEM,
-					     0, 0);
-	if (ret < 0) {
-		fprintf(stderr,
-			"error in gnutls_privkey_import_x509_raw(): %s\n",
-			gnutls_strerror(ret));
-		return -1;
+	/* load x509 certificate */
+	if (pkcs11_cert) {
+		ret = gnutls_pkcs11_obj_list_import_url4(&obj_list, &obj_list_size,
+							 ctx->cert_file, 0);
+		if (ret < 0 || obj_list_size == 0) {
+			fprintf(stdout, "Failed to import crt_file URI objects\n");
+			return -1;
+		}
+
+		gnutls_x509_crt_import_pkcs11(x509, obj_list[0]);
+	} else {
+		ret = gnutls_x509_crt_import(x509, &cert, GNUTLS_X509_FMT_PEM);
+		if (ret < 0) {
+			fprintf(stderr, "error in gnutls_x509_crt_import(): %s\n",
+				gnutls_strerror(ret));
+			return -1;
+		}
 	}
 
-	/* load x509 certificate */
-	ret = gnutls_x509_crt_import(x509, &cert, GNUTLS_X509_FMT_PEM);
-	if (ret < 0) {
-		fprintf(stderr, "error in gnutls_x509_crt_import(): %s\n",
-			gnutls_strerror(ret));
-		return -1;
+	/* load a private key */
+	if (pkcs11_key) {
+		ret = gnutls_privkey_import_pkcs11_url(pkey, ctx->key_file);
+		if (ret < 0) {
+			fprintf(stderr, "error in %d: %s\n", __LINE__,
+				gnutls_strerror(ret));
+			return -1;
+		}
+	} else {
+		ret = gnutls_privkey_import_x509_raw(pkey, &key, GNUTLS_X509_FMT_PEM,
+						     0, 0);
+		if (ret < 0) {
+			fprintf(stderr,
+				"error in gnutls_privkey_import_x509_raw(): %s\n",
+				gnutls_strerror(ret));
+			return -1;
+		}
 	}
 
 	/* generate a PKCS #7 structure */
@@ -349,6 +402,11 @@ static int create_auth_data(struct auth_context *ctx)
 	 *   gnutls_free(signature.data);
 	 */
 
+	if (pkcs11_cert || pkcs11_key) {
+		gnutls_global_deinit();
+		gnutls_pkcs11_deinit();
+	}
+
 	return 0;
 }
 
-- 
2.47.3

