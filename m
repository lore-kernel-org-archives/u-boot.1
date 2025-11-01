Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD2CCCF9FE
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 00:47:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E305683C29;
	Sat,  1 Nov 2025 01:45:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Cs9+clAZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5389383B71; Sat,  1 Nov 2025 01:45:35 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCB6B83C01
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 01:45:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKJ7SdwH68LGlcj97eUubtsiBuIy+Ld9a+/V1m71NaXZcsqOTlL5dSQ20uJDykwPRzHMZhIZAh2BcLpmv0mUJBHawhy7ScNnKFfVpfuhRkmwba0aXTqajbc2DUfN70QJrgnoeRwyH5HVisryoIys8IRKzQJWhyhNeXxc1nQcfPTTRvzjMRMHU9TY66Oe9M2CoervmXxJmXZF85kD4CYnNSy7lnl8x1gXdeMZxDBKBkmHL4xNOtkUY4IR60bg8nFnB0tSZFKcT3tvcacsVpoQtlS20ngOw8UBe8qSH8mTWlfT9whabPmtYRj61HsFNQgSGcSrh5xFJAhonYGWhk2klg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buUJF/5pBYBBz2K5OPoJ491NOPmX+C1ZaV8+KnHVBGk=;
 b=xzuOAo93UH9y3T8DOeBlCqV0GWeoZkxUFGZ0XEuVOZ0mcxlRca9LLsiehF/BQYVNK7l4v9oCEbUFCla83iSA0WlW9WyO/b5P2jVJb+JgeMmD73xNH6cA/bwKbxE4b8+5HcS/YwbBFY6X0BDYxWOyshzuhOu/RMRQwkQrIZCQSs15t6bkWdZa3pX8gaXTJ6eEAA7RFm85K7VtG7rcPXOwQLc/qnq4Wq0f+eujk4TeV7/x6w7bxNOOMoEd5/EvXQWgcF2hsR7RXs9M9nYnYumZ87E33U5FbTYdQXDsurrNqtCU+D/lksMiGG9kQ8aGfMG6Qnd/k9ugrxHlvKjvpvNefQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buUJF/5pBYBBz2K5OPoJ491NOPmX+C1ZaV8+KnHVBGk=;
 b=Cs9+clAZMslH6Yjyjv/kvjWmy5bLnkDVuDvOefcmPJJ0jhzTj+3K9cp3g16fQaLTk1NSLOvRxivWpTknXTC0rwipeVO7Jon7YPtM2IsCmX2EpE4YegOCr6NIJJIyVp3X02F5hXhJ2UiOVlCOTP68frN8jCM05OZSSzR+5FlubS2TMFU0ZfLuAx03zOz7/BvsLmwyzda94PcWcVeo65RmeG0VMBNLCQvwtJ10Tp/pUvTyjiqD7xcZuu31ti56q4a8c95O+ScLtQj3qyMI6E72MjIaNF6buBQCwpAGOm4vfBHiJnM6+cTuaHWhku2TTRtXiNMyWhZ/5+OBBMB1OtaWnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS1PR08MB7586.eurprd08.prod.outlook.com (2603:10a6:20b:472::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 00:45:29 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 00:45:29 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 16/19] dts: airoha: en7523: add ethernet controller support
Date: Sat,  1 Nov 2025 03:45:00 +0300
Message-ID: <20251101004503.2379529-17-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0283.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS1PR08MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: 61e9fca0-a818-4f90-7b15-08de18dff4a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y3tVwdQYo8IRKSrl01wgBmOPo8ObJLtLfMy2cUUwKe95pgQ6wMpmg9hjahzk?=
 =?us-ascii?Q?HsqaZaH4XasTg6okmcel8bNxDxfXXKZsmXw5iTuYAOPZ41Tb1moKA5nTpdhY?=
 =?us-ascii?Q?WZxYlNQV+IKr4JDwdgbguL+EDqfLx9hLkOx0eRkGs7OdwRfqv58wADAyAz2F?=
 =?us-ascii?Q?ZchEjuCbhBjnR7A2JVOK3DqNZhQAw00+19DX07OiTY4LkBg5cU7q/vVxokvK?=
 =?us-ascii?Q?pT3yuy+XuBoBQ2MMD4wmhw9WB98sxcKzmyB5duAkGj9AWQbfFEd1QOgdWh1V?=
 =?us-ascii?Q?ExOW4oWIgVGy3GXkag9/+3ZHUUos8YXgH9YWcZWR2O8pMp7ONpkLTr4YSbCZ?=
 =?us-ascii?Q?47UeLIHUciS4cv6veTf7AAiHFJJAU+DJ/9AQzYj3U3p7by4iLM6Dy67CwIp0?=
 =?us-ascii?Q?chttVe1yOKvglSCun79YArkBqRc9J4fGGtweLXzI7HsQMxvRPk1rWMsmLIix?=
 =?us-ascii?Q?pzpHQzmd7VYAsoJt/GYNLBGA8/k7Z4FWvxdhcmr1AAKLbUb2VQYW/7Qf7Cry?=
 =?us-ascii?Q?leJA4X7oLIYVHYF3wXqYyUfmlIw5shVeKUTRS98OwnxSu3UCweIAWDhLsF1E?=
 =?us-ascii?Q?rdW+08ciNqhEcQYfDWr6Bi/fditqJYyl1Ig5Ku5aunwJT4kUZERV8KwUINB6?=
 =?us-ascii?Q?DVbNpDx0RgKj4PyqRO8Y6ebrArJY6kTbF+gwutEH5lL6wTu94bQ/IxiUcFnB?=
 =?us-ascii?Q?N5I6SYo8g9JNt7lu84Sqrd6arl0gqeCcWWgbNX/Yq3C5Q+deROwlT2kRdyQL?=
 =?us-ascii?Q?Xcp0M7aTAvZsmmt1+d6h28HO7JzCBV1na5w+9u9IUQQ0WFpqaB8JViHYf5YH?=
 =?us-ascii?Q?Boq44KJwYDRJpkwgbhSqcKFdv50/1jVyIteTTM1LNtBiDgYjTk6yAxb9yETX?=
 =?us-ascii?Q?h+G3R7EZ6+h5EtOZ4i/a9U9+lWwnRfD226rnwpqCRUR/ZdoaRxLoTpB0ogIE?=
 =?us-ascii?Q?CeqTI4LuswvWrbeeeV8fQxIyHqiGVPjq3eaeYGuwNuc+QABzFAwJ0daqW7LB?=
 =?us-ascii?Q?wFlpj+71ItAXXw/o/rS6B+PfEBDDqtXC7YW+UM46iYDkEz976NwFJmpn+jP/?=
 =?us-ascii?Q?lNFN8rG8cnoha7ETc/qolZlzuEaLW2AwlKhCyahYi34kziyEwaZ5L45AyoaO?=
 =?us-ascii?Q?3OsWa5km2i4GVjJOisrfk2E2BLH6RC/556m2nIBmjaMz1FanbrbJa2kcGq/+?=
 =?us-ascii?Q?uUMswmTt2Iv9L/+RAYIkNbUQNfMnFhyTEKKbkAw1Cq8B1KFNAJ+fPsgMtM72?=
 =?us-ascii?Q?qO57rj2I+me0jvwKYRZfwE5zHuyrCHFXoym4SUSQw5hX4815u5MsramUdC7G?=
 =?us-ascii?Q?Ix5AHWux7KpT/DZowkvXrUmA38zAn28QhS9HX2QpxAtzHjsw0LbAYyLKMBHT?=
 =?us-ascii?Q?2bv/0Ij8/avLAxpLnyldH2M7/V9LosP2qS/U6dqzX7GMgTSST1vuOUyVYwJw?=
 =?us-ascii?Q?GDOXnat77UsNeXAGeFlE46jGgPQW6YO3utQZZJ+fEMVOYj2fHZI6UUUJ9gSa?=
 =?us-ascii?Q?y3YwW9bNzmMjqmEgZZ49Ax7S4gMrW7DwzR5V?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wlnONr/m2lPP/LXa0iViM1YARR2b5rghiWHXU8kbhbpf6V4xwXJS8Gn+3Bpf?=
 =?us-ascii?Q?yihnJp3n31QvzbNvMfdDQ+qXmw68eOpGNSUKhXNf9PWwvgqS/lbH4mgXSPeU?=
 =?us-ascii?Q?Q0utnJtDDlg7DljmG1mmpPSLSSJZkYJDgkzaMP9iopCGNxvrcsI7IRCy6jNK?=
 =?us-ascii?Q?0xrEoYetEkGugwbY26dxjO4U7Dckc4J4m+t1a5K2C3c+NrzzTGcXY1kHAfby?=
 =?us-ascii?Q?nHS2hC7I1hXq8rz3SmAGDubqkCfJ76h1pfWwVbT7rGQuqBdRFW59F4QG5ufU?=
 =?us-ascii?Q?ieM85q0k2uErzHU2by//agiekSs01T9X3Fe2L1s8JOl0doEO6LcVJ2yYRf0p?=
 =?us-ascii?Q?KM2EnbLxKKrcmvHf4fWLJGAP69loQMkdBmtrpGwAvV6d2xyauvM5k91VlbkS?=
 =?us-ascii?Q?QRkLGTla0D5VyxsErRpRzx6BdcQ8kp+jxEh7sXh9mHFcxzxmLwHnRq2fPsxl?=
 =?us-ascii?Q?3jikl+lrmX9+wFOcXpiEwN38Q55845/JXtB0xiCxv2pZ1TAmvdNu426i46Ad?=
 =?us-ascii?Q?wU4I1PCazEaDTwJzrHl63YBRwwQpslC3X73L77aXop5mdtKu9Ls56PnWK/ix?=
 =?us-ascii?Q?CriIdNfL66beWTXc+tKbhE6CJ915UUclfoEfPVi0XE2CBPgbbRrzeuCUcVrc?=
 =?us-ascii?Q?/aPgyrDanH+8WZb0XF0S9m/MzH3GXuPH32BOeqPv9r3hbCkdXrsgmRpiXtuJ?=
 =?us-ascii?Q?EeS2vB4uPMUagJ5HpHukB0Wi6q2pkUX9Fb9Xim5Wbdok7iYPnicJHd2dyujn?=
 =?us-ascii?Q?p3IHZ+3o8ySIQnyzOlkEzNOtMNyMPD5bvLD4c7Vgmbx4bsTbzUo7F23fPwzd?=
 =?us-ascii?Q?YMGwJL6BvHsNJWj9AFydjV1iKHKTEdrhtXrq+rYud70nehH8obWWYQQ+vr0E?=
 =?us-ascii?Q?9ZgD9SqDJXHBqrNZTFeDi6RwyodrktNrCaSjFH4jWsSSOSIO+HglDjaut45+?=
 =?us-ascii?Q?m+d39OI1L7jF4AGTnETWNOANyRwFjcpGLFaNkrDS91LfMCsvCXZgg67nJJA4?=
 =?us-ascii?Q?eJ+uQsBCUAhEupbqJCkNX/Dr5fYj3D0heO1G2CFAGT0Sieu6n0mitLa0HAfn?=
 =?us-ascii?Q?g+a9vydvgl/3AoVS2oYsf0u9onL2o9cXsVU7r91C7FcOxXm83aSjYCxzwEbC?=
 =?us-ascii?Q?y+AFvkBVklKs+VJ4+8RkoE1m7sDsWwU7ABVmhZqDlKMX44dSbYWiA4VsvDkx?=
 =?us-ascii?Q?SmKpXj59bPhCbLtOqIp/Ftw8FKyfIPBcERN7zm4s1moUJc1vKCoROOWEfaq9?=
 =?us-ascii?Q?Nbz6nAn61uRRH3ahpLUwje9Cf8JNTqpTo0YHOdXCe+IRbQGf0HxOj2/LIDj7?=
 =?us-ascii?Q?ayydadtoXyLgrw+ep16Oy6fbmUkdf5SXHGabwlI1RwMmFzRHXc0c7Eagn7kX?=
 =?us-ascii?Q?yEUmhyJilg2QJj4Nd5eh6oQ1ybl2AC6HY66PxTRrSaPzvz5Our5hKONpP05a?=
 =?us-ascii?Q?eqXaAFZLnMQTKNMCQotT0OQZt3/gH01E6ol7J4FFAWDgN8/bPmHJLYSILV5l?=
 =?us-ascii?Q?XBLIW1RrOVBG4n2B+sIIOY2ZQUq48p+3Axao5sxzUVRMWHKjAXzJPeDP3sCg?=
 =?us-ascii?Q?uMMPH2gPp5Gjx43EaPNAu0uK/Zq/bb1lI/7hHsM9uSf85IL6QERGo9B/Y66A?=
 =?us-ascii?Q?kekbIrXo0HE1DJT5RH8nE6w=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e9fca0-a818-4f90-7b15-08de18dff4a0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 00:45:29.5877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V02ytPbRvbKzWerAcjq4AAp4K0MFtFwOqPEm5OSWliqTYUwQF5LxuQjEkCgWq/r2I1hsE317pJzNNLJHDO5pT3uZRQUeBlLK9uKhZd21yRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7586
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

This patch adds integrated ethernet controller support to en7523 dts

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 arch/arm/dts/en7523-u-boot.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/dts/en7523-u-boot.dtsi b/arch/arm/dts/en7523-u-boot.dtsi
index e5a84dc56eb..e22938ac5d7 100644
--- a/arch/arm/dts/en7523-u-boot.dtsi
+++ b/arch/arm/dts/en7523-u-boot.dtsi
@@ -22,6 +22,27 @@
 		#reset-cells = <1>;
 	};
 
+	eth: ethernet@1fb50000 {
+		compatible = "airoha,en7523-eth";
+		reg = <0x1fb50000 0x2600>,
+		      <0x1fb54000 0x2000>,
+		      <0x1fb56000 0x2000>;
+		reg-names = "fe", "qdma0", "qdma1";
+
+		resets = <&scu EN7523_FE_RST>,
+			 <&scu EN7523_FE_PDMA_RST>,
+			 <&scu EN7523_FE_QDMA_RST>,
+			 <&scu EN7523_DUAL_HSI0_MAC_RST>,
+			 <&scu EN7523_DUAL_HSI1_MAC_RST>,
+			 <&scu EN7523_HSI_MAC_RST>;
+		reset-names = "fe", "pdma", "qdma",
+			      "hsi0-mac", "hsi1-mac", "hsi-mac";
+	};
+
+	switch: switch@1fb58000 {
+		compatible = "airoha,en7523-switch";
+		reg = <0x1fb58000 0x8000>;
+	};
 };
 
 &uart1 {
-- 
2.51.0

