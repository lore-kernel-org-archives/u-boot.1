Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4ECC5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 07:29:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6371682B20;
	Tue, 10 Jun 2025 09:29:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="W7jxMcfW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82B1C805D7; Tue, 10 Jun 2025 09:29:37 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A9C880C83
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 09:29:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6SdwjNtB845MN8eifh1nS/MoPDVSHQrNlAnThY2CHk4iv4eprylj5+rz/sRmGWYbVy7Ere9sjo++WjDObVlKhYn0yGauP1TRGkaSYZ4dCQiSbNAXz/I78l6GOBg3DZGtQDBlLpMckKL5swRXgIfwJRN7zaBM8B7Cy6fRhQK4k8Hcz0uwW1BJoy6EgN/DQFpU33sMgORlV394HddGgH6R1jEQF7C+GMEU0K7NRDU7+Tll0a1cRMCwWL55Kc+4v3vyr8jcIh8TcnHRsrTIcR0qHw50XV3Ap+iSlVXtyEQK+ALjj3xCqKvKB5t2Ll85N9kLv19zuS2ljZG+orzMw+lGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6e4YGeKhkPDIlj/j9zE2U2MjbXT9/EK0PEN5KDo9Hg=;
 b=VHD7N2O9ZQGkaJ4pKA/WyydLeyXwYHbCRaI45MJjU9GD3pWnI39ywikauFZQG3yW2NL4uHGOg+e4sdMV/4BOgFwQC++SMmo7JTvS6KLsKOQGe1xxfn/yCZmtU1OM386Eygnh7TIcBTYWFgNfShM4OvirZR5SO6GQrV+j8pUbOWlaOyAi6XB8by9mosjlCq1V230HJYJUGp5l9WtQvZPorhhEr7bBRPgbD7gKQ7mPBEYUcKJGzEufHSZ+H2b12wiHo3oFKaYnRKC6YwzUTbOHMrTuuA7cDzeLCjnmv50o+KgwGFHP0cp3Dt3cfxi7RlBnHGfRgm3hELWehLqu0fMFBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6e4YGeKhkPDIlj/j9zE2U2MjbXT9/EK0PEN5KDo9Hg=;
 b=W7jxMcfW8U37IYdYWP49P83Fe5FaeFcuI0n/e48cbHxfk6s+NSc46otQ4seLpJlD5VYUMsQrgr41ol0fd6onNGOpOYpW4sdJSbXV/6ENvXfCBJpU++CrlJAedLq7xBPdql9ubqpz671x88yzFKbzilZ8yBR6WFldNsPTJwCf9fZUNdRTRDVhHmXzneNZHSWF1EuFv6tYdqqQPoYNDjSNVIC34BUQX2eQgSUPw1lZ4WrunDugkHwCvX7CmczV//Mv7glOvmuTeORpsiSuPhxeAgsaMfaYhUGH2voEqRp1UMOEPH8d3bGIzK3ejyoqSBuCSUTJAUUhijrWZFlZvkUe+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB9771.eurprd08.prod.outlook.com (2603:10a6:102:31f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Tue, 10 Jun
 2025 07:29:32 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Tue, 10 Jun 2025
 07:29:32 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 1/3] drivers/net/airoha_eth: add missing terminator for
 compatible devices list
Date: Tue, 10 Jun 2025 10:29:22 +0300
Message-ID: <20250610072924.1066329-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610072924.1066329-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250606201728.462664-1-mikhail.kshevetskiy@iopsys.eu>
 <20250610072924.1066329-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0096.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:275::14) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB9771:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ca0eb8-57ea-4584-70d2-08dda7f08ad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QDJqN/5cmrEodlfR9P+HjnD8/k8w+K0ZJshq8jkc9MbZaXut+UY5/m6E0IbF?=
 =?us-ascii?Q?GgPrsaAugDF/pmw4EyAzQZxR56HQE4w8CUJZKZ3uVo3TUrBB3UJGUReBnUJt?=
 =?us-ascii?Q?qUvzTV56oUJmLhPzeK9ONjXNviO7Qcgzf1nbWlJikHt3hW8MGu55Ci0LhgXm?=
 =?us-ascii?Q?YGTa2E1Ne009RZIcokcMqVP/O6eYITW0NYxGKv424XZLGmSflnFcNSH2S4vI?=
 =?us-ascii?Q?rd2dLQJGklC9VDRAdAFut4etaYQECetKRaoMwhxdOuQSxyhcwKqUy+/oMlZJ?=
 =?us-ascii?Q?Br0guIkrxme0lIi2VghwlEBi/i3vNBTWO8glCAIMAntIruvzS/zmJgPtHZth?=
 =?us-ascii?Q?3Qde5qI64Tu8AxFZBB+uP0xnA9oijioWSzdBXF7/RFQSBqMMpuqRBT8PrHnU?=
 =?us-ascii?Q?wbK08WXtHluVZRG25ayXUpK4IFpOrpq7ovG6L7W7wig4ZnwcxHFttCERvR+g?=
 =?us-ascii?Q?yCpTpurP/nF7RxjcZHWrfd3MpF5C7oNVeUeMqQqTtVZ1UZuyzJzztiotFyff?=
 =?us-ascii?Q?AEzRD2Eq00BwPC+m4nfV4dEW2v3uwwDITClqeuudrHYHNUmzXZs9x0/Zk1hS?=
 =?us-ascii?Q?h3Q//dCEAPXEhJtE83XOPXxS3c+mKXt7FykNX17zWZI/Uts70nZgS2y7mEyf?=
 =?us-ascii?Q?3qiU1jS1dqACuD7zCnCcCNm/iXGkZaA6T7T5Z6EsfbhfOgtZPgY+y+Zxd7Ti?=
 =?us-ascii?Q?8TMPdypUkzalDlms3LrodLfmBtYzZL1Xwk4wMHlgShWVL3aT25BlbBwtyRRI?=
 =?us-ascii?Q?h+eBZDj6yWRsmJqeIhH5EG4MiiVOD5OgGGf9L9U+++lWdGoYA5Jq1eB7QjJo?=
 =?us-ascii?Q?4lrtXpgrK2w+aSvQCaAtNshq1LYgk99wlG9m9lNlUHV9ZuMa785jXJ6MlDbz?=
 =?us-ascii?Q?vqVNQmm6jvRUO8x+yKusStEilDvxe9COFPeI3X1yD0kgOmcV9FPJ+xC5c0jf?=
 =?us-ascii?Q?7Mjgx+WJ1z2HAqKeVVZ5e2iulX9aEBZddWVnUUD2MwDZbQAOjexjSY2wPqni?=
 =?us-ascii?Q?JdlsyA09I6uqQl0KI+KsvjOmHnmvtooa61Rh+gz3uCZevQ7YQrNHMD2lneW6?=
 =?us-ascii?Q?d6FEjZGoqxkIXzlK0PHV/wFZ8b2nuCYtzK6TbKhM82Ybkff3+Ft/va8K5iP8?=
 =?us-ascii?Q?cxeNdFZSeHEUe6te+LKN704lgZdTsPAaHN38M0YI8zGhweFZH0eGQVdzGhWN?=
 =?us-ascii?Q?MaggL+zTg7PZtfD5D7Dvxz/RPdQ+70z/VI5IKq2wETloihjIsc79ZXVFixNb?=
 =?us-ascii?Q?g5PzWBdXIaqeDdc586ZHu9IXXwwt/jZPKou1lsN/EG+6ze0V6RxDAlVohLdk?=
 =?us-ascii?Q?C+Xk3i9gvqJlzRRIJWWuTrgzydi581UseCnK9cv/qAtx7Kd8bPFDf8MVOOVk?=
 =?us-ascii?Q?2D1Nusl2ksydPhR7tBaecNwV/eC21Hihw1wcGr6aCJLQHohNueWsyivdt5dn?=
 =?us-ascii?Q?WC7ZB8dLMTx2JGiLbbBZ9LTeG+CKBP3X5zlvoVq6DC+wW6MnirrLHw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D4yAodTzlFuRmMr3zPTCXq1en7A0+/+OK5kAt9CMSfZFWMIK9HQxPqQ9LXip?=
 =?us-ascii?Q?kPc6bBE3nc4GAm5h0jimYwCqtRXuZtyszyGEjSdfAMMl/drrSEI1TQyPORg2?=
 =?us-ascii?Q?HkipnJlNoMct9LRoRkF/4IpoAxGndcXaDYkjAYbmUKzY1SWTwr321mdbkR9x?=
 =?us-ascii?Q?uhknou6DBh0AS0guRPcmZHsj1LsK3olavfOv5XGpq4+nakfs2Rx4sANYGSVE?=
 =?us-ascii?Q?nMF8CyM7xUhp7w069PzMEKgNcSbpTkGH6n4qqYcClF494GoDTyxnJOMZk5Vw?=
 =?us-ascii?Q?zU1bf+LohaPur8b3E+siMoTEdcSS3tbsb3K9pj6CRMSgeqNsuTx457PjJMvZ?=
 =?us-ascii?Q?F8K7rF+79iRwwQFTaggMFhJem5ZpKne/rl4zFuGjmHTRZd4idKX250Nx9tTz?=
 =?us-ascii?Q?Y2yDLzPtj8sc2XU1H3Rk8fSwMdQP0asSxDVQx6MK0NZry82Hu9KW4Oib/dGy?=
 =?us-ascii?Q?l7Ba8Qzn+e6mis+biwTgVPsSZeNBwQHG+COibcdx3Bo1UcK4Zw4xmXXQ2wkm?=
 =?us-ascii?Q?EAEy5cqFFQHgrIoD5IbRZrEZH/YWDSmKr8wB9/ErFNdnUckJLWpD11ONkUP4?=
 =?us-ascii?Q?QxD7vgJGa+odM34M/VHK96FtyBCbyuIUbNkqux16bX7ybNGmDCo4G2nkf+ZC?=
 =?us-ascii?Q?1qHiv4H4SjVwhfiI/FY97hvOqdX3ovf5HvoUxCmo2NcyVdoR6QgQbxN0ULgv?=
 =?us-ascii?Q?SLTROqqTVCF0oqRJtwnhWLustq6pz7HAf+DsQYD/kyR+dTkLZCAvzYycT0hx?=
 =?us-ascii?Q?Bvn2QTXahcD1MvFTlQvNfSN/SXpcFgh5gnjYFE0VhGdz2tBjKMKi8D5StXde?=
 =?us-ascii?Q?alylVjxSRqcCVTOjk0gENaQngfKRARj9fg1S7h4QVwvG+80ky779H6BxpGuT?=
 =?us-ascii?Q?P8SFlcI5pxvePpDuS+Ny5APtBCDAGA1X3gnKncwlGdWM1MgUgknGRaNHyJ6U?=
 =?us-ascii?Q?6ANm5FYfDrNMXBXRHt8K64uEHySLKBYn5wlEYFjXn7YkjGn14FBfsJv1MQ7p?=
 =?us-ascii?Q?aXFkzOjYj+POf9+GsG+6MbwitTGOkxNUdP9jUuSqQH882o81ND+fthoxyCrX?=
 =?us-ascii?Q?jBPKxmQVTdekqWNMzNSnbVD8iLRniHUhX5tb6aCz7kppLc2nhfuBBJou599d?=
 =?us-ascii?Q?ggdLMHgYBdWzePd07+CcAUZ9TNctocyryfeBIakzV5emk+t2ACVCNal1NGN3?=
 =?us-ascii?Q?A9WQBkloCElTzsM5lm6FTpUDWX33Z1bbEmW2joi5wRqfGYEHZZBLGm4HwHhf?=
 =?us-ascii?Q?pVU+Y/+0usyld4ZelNzEAcsbvsDVA6/nSTZOI2t2/0pGYB1rcfCub2pzue9L?=
 =?us-ascii?Q?7NHIxEkO0xZoirwI9kEV7NCocFZPqAAp72i88mWKXPfzcaqNf7KRchYdkNfp?=
 =?us-ascii?Q?yhp3lp0AheVIKIXR6U6y/NO01InvMAzNBD9k8oPM+9Epd6+tLcDK3G51+mXd?=
 =?us-ascii?Q?WH2ZXzYTgBJE7IcKtGlagF5fk48A16uZk87I1kczs8+uYE4J6Hu+EiwVzEDR?=
 =?us-ascii?Q?VvuDnl29KXBltZWg3BuU8OTpVIKRKmh3RJ4Ppy+GgjjsTRAo6T+8/IAPi82g?=
 =?us-ascii?Q?2jNdCy4n/eGUUlRJAalS72htLbB05Br2K9NBIYbXw70oJ7VNxMn6LJHEI8ar?=
 =?us-ascii?Q?8ZlzkzPNtRu+Bazmrdsa1fg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ca0eb8-57ea-4584-70d2-08dda7f08ad1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 07:29:32.5670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HB92ZZWIG9LuF4yiQ/0qHxUNg5FmfqM/F6z6qm2xJcIs4enRpFuh+NJGuK1CQEOyFAJxz23TpxtcChRfsReDV0If5cWX2TTLUIxq8HmmS8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9771
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

Compatible device list must have a terminator. If terminator is missed
the u-boot driver subsystem will access random data placed after the
list in the memory.

The issue can be observed with the "dm compat" command.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 7e35e1fd41d..2aa42b3d727 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -926,6 +926,7 @@ static int arht_eth_write_hwaddr(struct udevice *dev)
 
 static const struct udevice_id airoha_eth_ids[] = {
 	{ .compatible = "airoha,en7581-eth" },
+	{ }
 };
 
 static const struct eth_ops airoha_eth_ops = {
-- 
2.47.2

