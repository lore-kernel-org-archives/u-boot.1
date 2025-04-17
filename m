Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B411FC369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 04:58:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D566C83010;
	Thu, 17 Apr 2025 06:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="lt2oBfQT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C015782F75; Thu, 17 Apr 2025 04:20:23 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A944F82CBC
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 04:20:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzD199v73qpMqkcerHvyCB241eAtBg97oSh8ROiCogeNj08FrHVe6nR7ykLNfNcVoNzOvcJXub08btxQesLd7r/dMQLF6gohis5bttbNQ74JEt+KR4mPuRZH9fUr3GVbaJci2EURNzEug6SYqBlSofLq3PgnKlhprFborEqg9OS/I33WqIrxa/QaoXudo/TargQ9oPLNTTI3RmTAihe26S8zackgUFZ/WXUzcwIfwmz3LaPBRh+qygW+l6yxtTqyINW2uQFIuCaSYq1UGRkzoDzgBESxayTDKufmq3rsO2r9uLAQFL+1BAzu0jwupky6IPn77u8wxABl8Y6suxRmUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwthSkHgoiil+GXcTl5+zELnlp+QoSrk6hn87zm2sIs=;
 b=sDmNjVv2D+qkus8rrSkpgy3DZXHzz1Y4KtyUbG6Whp8jJJ7dD4sIYbDlUPquUDNydw1P+GPetG+RVRuFl5fkez1TyLYqd2FrxwjV4tNr/MohxjxkVKbvZjIzWsMgNoz8SuM8CSwxZXfso07G2sBUxe4vzEFGE0UWR5op0+WsWiHBwzIXDnVxvZH9yRo8rb7y+amXISe+dKKpPfg2McdqDfKUIcdP+Fs19jaICgO6S8bBKjR7dxtzo2ua/yOsnfb98hOOEeyc5VWqyCUzEoMsjTQleZOfEiN/xO1JwJklL5EyrUrYHYRTNVqxilVT0f8OBXDAhkSTIpwB4AtNISnFDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwthSkHgoiil+GXcTl5+zELnlp+QoSrk6hn87zm2sIs=;
 b=lt2oBfQT4gOSQwnBX/aAdCFypkBJgf/K63egDQ6xOs70gWJyQp3ZN4cKbwmV8hW2r+Ao1eFKFYdOellXatdFJDt/INKnnpWHuyW6wjb0YD3xyCxXA0bbWNk8RCIvGduPkFjYiWoQBh6IQ+ulYU59kjNDo46X5veoyRoERisAG7nMrxZnK5Q36mU4R2G8IOJ3ucOGDKBVXQf66HRdsug3KZ86xZHvx6AOTYg+FciLGlCp813Qz6tphP2OU5MoGsyx7yLLbWb59lt6SSVI0guStxvMW2MztTl0GVWQ3rjoUkdjuEQiv/tZZwGRiKgiFXChYB1WDNUs/8sOCoQZNU8PVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by PH7PR03MB7414.namprd03.prod.outlook.com (2603:10b6:510:2ef::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 02:20:18 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 02:20:18 +0000
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
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Sieu Mun Tang <sieu.mun.tang@altera.com>
Subject: [resend v4 07/12] drivers: i3c: master: Enable probe i3c without
 slave device
Date: Thu, 17 Apr 2025 10:18:35 +0800
Message-Id: <20250417021840.6212-8-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250417021840.6212-1-dinesh.maniyam@altera.com>
References: <20250417021840.6212-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:217::24) To SA1PR03MB6370.namprd03.prod.outlook.com
 (2603:10b6:806:1b5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6370:EE_|PH7PR03MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 26662a05-41e0-4513-5eb1-08dd7d5665b4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K243e5MIn01/2obnXxS1r/SyZY9bj4CSF+By006Fh4DFKaoCChD5OeYU9e3v?=
 =?us-ascii?Q?CA9LmRakU8xBh0UjHxHcMH1PFQ4aNKW4ySrKjak8voFuOirbZHZKjRJ7Rp/m?=
 =?us-ascii?Q?MSTu61607zIzgH9sq0PowybdmAShHFeJamwIGv8fZsVmJ5KscznOcFV/gau4?=
 =?us-ascii?Q?vyqE9UE6DUbLdPSJdr/K6u7dQOM17lIEaibWQXyaYhi/DnUU467nX9y5gs9B?=
 =?us-ascii?Q?hCpV8VztvqbZVhKu4c9Tu/Ym7ZEdvPlb2rS+apKUXm2HaHyulcUn20v+EHbB?=
 =?us-ascii?Q?3sPY9x5A0kWEkiOeyNyEdfBwHR1KJcvuKvJpXdumsWsWlkaVcJ7ATss5U63V?=
 =?us-ascii?Q?8rcutDAPXMI+R5isZRGHxYRgyLvYD04lsPu5sO65BSLngJylCmuU8djSe0RQ?=
 =?us-ascii?Q?G2EgILWjzqIbw6+I3OFcA56nieW3+FG3kOk0/N4HitGonEgSJNq1+XnxN5Le?=
 =?us-ascii?Q?wQTnhjbgesJY6nOEdAjD7uYPDD2/8WYtv7YblSqKlhy89Tl8LO1uXAcAeRZ+?=
 =?us-ascii?Q?0lIJhflugRI4wRdiy8ow4C28pJWo2A4Dl50eJy3eVxiZrGurDrZxXSfqtm+I?=
 =?us-ascii?Q?Z+nICok3gaL/jGLgX/J2U/uMo/7jTG60tdJugw+VocRPEhi6hX1tbpQWLIBA?=
 =?us-ascii?Q?mgmbekwlCnXz4FhiFHUBWwKZ329FJ/zDQXhg1gXftmVfcvCZ4HcZqrlmJ2iY?=
 =?us-ascii?Q?7MLd13MiHijIrgxvFaEG+00hzz6H8zBBTmZcDaL3LG/pqtiDxQR9JTCuhtFk?=
 =?us-ascii?Q?be/AM/i1dWGB9t99Otg95cuZpjEV7R3YLUKvTAQssmUHO4xv4K8IhIwK9/yn?=
 =?us-ascii?Q?jx8CGeH598J7a4ZQKlydRpErxW0UrXg1G1IY0RHPG+AmqDgJVn1nO916pziU?=
 =?us-ascii?Q?I0bMKINk30E3yLdkB4LPf2uxNy8w9cPtgnZNjNZeEk1mhOaa56xoScGrHENF?=
 =?us-ascii?Q?dn0lPyH0tEPDXTX7YCB2eF/paZ6o3L7Muim+IXvNHvoxKYM+zbQQoQN5wyID?=
 =?us-ascii?Q?4JBJRntkRSMGTO7SlXTgtNCUYs53ymp0M/zy5UvCRN4Gyjw3qQGoiy2q7bFG?=
 =?us-ascii?Q?lTeoM9DMI6ZwTiv22dFIvrGOWFmsZFpEK4Z/k/FOInW288D8BmgFo+GvlFQw?=
 =?us-ascii?Q?X9apYqCHNSBL8+l3pWX2O7KNoGKOzOK0PAr42NVq4ORuyXtqdC+egS6LLPTB?=
 =?us-ascii?Q?Wx81ajGAPcLNV/+3JOoGadVK7c65NMZyR0bOSaF3aqIiJNEzy9o2WCcjbTa3?=
 =?us-ascii?Q?L9rqQ6NYVR3xInMedCj33TJNyNgd1AOpLWlZ3YVdf7ak12qk6SpNfKK/JVZ+?=
 =?us-ascii?Q?e/Iwd04rJ9hvUuDk2h9UuQbcK02J/PY7GduouaQN8lsAZGx/XLfRJfv02yPB?=
 =?us-ascii?Q?71z85bXrjy98qUHa4I05eBnnUYkRtxXDua7sucspGeXSnb1YEYMWcI1w2Xu6?=
 =?us-ascii?Q?TUteSwJHAJg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?neYDA4KcaRBQK9jR89FgwjNFj2PgN8U2nff/JqglF8MWOXscSiZpmxpvFfMH?=
 =?us-ascii?Q?k8mLvAi7n9ypmBdW2B57P8exFsdzshku1O18S4FJInNaNNh82vUwAE+ykWaS?=
 =?us-ascii?Q?mlV0B3gYB0qJrDlfHfvTsNiI54br4oNKYyNJA85n49aeLqVXTsluENBk0Bc3?=
 =?us-ascii?Q?0fehJBWPqKj2DcCKHwPsT1GZVK9DJ1ir3+H6ucgP0Baa4y9XSiC+AnFdm0tW?=
 =?us-ascii?Q?DWcVhGB1w4cLOFRP0gn5ZboU65NdeYhTQB44G+aklbcafa07gDSPsSguyeom?=
 =?us-ascii?Q?Kmjltvz0ZbPb2Ai//7VLXO1C762p31IvP9a4vj0U+k8gt2wbxpoupHOeieCC?=
 =?us-ascii?Q?5v6BxDhSsstkhN2FkkBsS0+ALW5uNOzia6holJr/KhqkRXZi9RmhPTYkisPT?=
 =?us-ascii?Q?e4pcrzQDSTlPaY/2k2O93UK7Lp22We5vZVbi8+CO4UhnAyb1XRxtSi6bcW/x?=
 =?us-ascii?Q?oTyyKJmC8G8kqXah7nZ02WPND31fXu7zLRzSujS/2+Rc8nFWVNRzFLyeOLRo?=
 =?us-ascii?Q?WmvCBeAgn/uhiXS12AcfbriT8yVN1SDAQGD7EQ361VKTHNEMM8yNo7XDXGIQ?=
 =?us-ascii?Q?mLkUpqclc/4zYhlyl7FdEKDcCSqN6gO2kGxo/f6TMbJYM7Hkmt7pCAQRtZSO?=
 =?us-ascii?Q?QZakz/CI8ZCO89dpbwCkZSU5LJZfeb0yKek+ddn1WBfhzZe2Fh4YYiOkqVLM?=
 =?us-ascii?Q?/OBDrnkuvALY35T/2eCF9cDTUnHfTxjiMmbvjsmeXtRap8Kk5hICixdXwlnU?=
 =?us-ascii?Q?ZyO2JMUJdxi2ApMfhzvIJNvTAmWNW+MbfiTqM18rR1yISVfxUl6+Sb8aAaRb?=
 =?us-ascii?Q?SPEHkfe11+hRbrrSVAGA0zo9il4IRJ7AsyxuyCLmBZzG4EFZWbyzeVd2SYC1?=
 =?us-ascii?Q?JQ2v+8fLMsHtf6wBYTupv8Lpfsz9mv8HsQ1i2P1C50AOWe8KwgLH3JBmlizj?=
 =?us-ascii?Q?zqmC96sPIO308WPo9QMq1Ws/oVfZA19Tc+AakIEnkSWec4ZpNrL/j6sPbEm7?=
 =?us-ascii?Q?oH1oU4SISMuQPk5VduiihRsZhnsJIxJR55VPGz3+lofHSEg8aH9OKRKcoT2T?=
 =?us-ascii?Q?4Kr7gp/avzXvt9v4vWAT3R1GU072lqRTYDe0eYhMxO5w3qaM+8fPDeT+fJAR?=
 =?us-ascii?Q?7ZpUj0FKMiiZio7Hh5+B6Nn3RYssF626UmI5dWhNP/Ehc8/tsuJHxwJdr0WT?=
 =?us-ascii?Q?9dCoiygTLiih0slfV3LQHXhfcSscpvoeez8565L6sX6OL1xEBse2AYhMkzAt?=
 =?us-ascii?Q?RMhOrQcTMDamJSA1mdNIoPq0aSgKLMt6U2TrILHd1xBJaqLhXyX1bF4G73nB?=
 =?us-ascii?Q?t7uhjgb736sNXrWUZ/+h2ZWVaen9rR57MWC+7Tx7LQh7tGndETykKbtkd4Pq?=
 =?us-ascii?Q?G66iYgTpEGnPOKwkRsk64WgiIH815gGTtr/Api2v/gDUAvadxjc7vMHYYDE4?=
 =?us-ascii?Q?hCT2dnuoa3/Tdk6y2Tq2Buor6+zBszy0BdWHD7f3XL5sxl8i/uJaCH23xrE7?=
 =?us-ascii?Q?B0bcpf+MWrLivBgHJJzio/tSf/pMf4cCda8WNtty+zCuriI1APZDI5jVXF0u?=
 =?us-ascii?Q?xqq0tlyrc9HhfpAk37qbiohS7ws/U+/kzW/A2VSjcU0qxoe/9s0bfNiEeNlQ?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26662a05-41e0-4513-5eb1-08dd7d5665b4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 02:20:18.6109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGw/6z282vVO5cAxDTk5goF9U3zNLp07cJ+UlyD1qA/kKzvcRGM77VHxDfGz/w3IBbz3F5fAwmeUcaqM/h4ak6nZWzPhuoMHRFGUHCEjlGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7414
X-Mailman-Approved-At: Thu, 17 Apr 2025 06:57:49 +0200
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

Picked linux i3c driver upstraming patch to fix the issue to
probe for i3c controller without slave device attached.
With this fix, the ret check will be on command error and will success
without slave device attached.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/i3c/master.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index fe12a2a1b46..909d650e951 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -452,6 +452,9 @@ static int i3c_master_rstdaa_locked(struct i3c_master_controller *master,
 
 	i3c_ccc_cmd_dest_cleanup(&dest);
 
+	if (ret)
+		ret = cmd.err;
+
 	return ret;
 }
 
@@ -507,6 +510,9 @@ static int i3c_master_enec_disec_locked(struct i3c_master_controller *master,
 	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
 	i3c_ccc_cmd_dest_cleanup(&dest);
 
+	if (ret)
+		ret = cmd.err;
+
 	return ret;
 }
 
-- 
2.35.3

