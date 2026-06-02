Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D31CD6E57
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 19:43:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DEFF84852;
	Tue,  2 Jun 2026 21:43:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PGYwIPV5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CF0884855; Tue,  2 Jun 2026 21:43:20 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3637C83FEC
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 21:43:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXrRUJtn3B3aA4uMqheS4FhLDu2ZYf3wROMXArn1RY/a0Dg1k9Ukyxm6TcuFGLJKtV7cmnTX3UDuJKRoEBhVCPGyfH1RsYGYibfNmMxNVulq+PhwVtELkSa2EAPQoWRHoeVXsUCZUvE8iWl068XOfhwQVewTLdI7+3tye5jh64AImO519d6JSLZ7lrQlyEk6LUxzEQrqvPj1b+slAy7TdcSF9iNeriU2iIGNzoPQu4+pQgwT6zcVvxyz89/qRiNV+kam+Y81dxDY98rT3bDIKCgxuosUL6adCCrZWK4zSVNrsIYMYBkEvwV8CjcscWRN4KkQ3NeSIHuLzhlrp96wOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y565hgMjG0xtxHnT52pFoa1Bw5zwGaxCgQPkkT0hmv8=;
 b=V737HxGw3CGl/UN5fImkh9KsZ5NLEXUpbXSzSdzcb4OT6a61DP5JgIdsd3vqnOpV+JoYHZAt+30/1M2sIB4mHdaRW3Sk1NJwGeWMbcBInZKECbPSsg9PdvN7PvO3QMLug6JAvCaZZu2k5C27niSAkVQ697y4YNESC5b88DPDaGFNWhN2bi7dvLG54PhIDz3oQEePX0hChSAm7gIpD6gzFB4fBCR0ddlMjlUllNicNjLpXZ5+X53tFHsPENzv/cbvT8xwKKdsM4/btnLRgYtUdSUVr2193YY8Uh9cZTBC8oKED1nbwoEF0OYCKBWgiDy/2prhSBg2Vw7ljwrrCb2Zgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y565hgMjG0xtxHnT52pFoa1Bw5zwGaxCgQPkkT0hmv8=;
 b=PGYwIPV5Arv6dXF3Mzk1XN/ZcqKpR3c8zwH2emg+ObnC1/VQ9EuKk051r3LBZn1nis/zahQVNNuUCaJvNMJS0eI5V3FGUpEqWQ5VCZ3QHLypn7zHIDFu00zx4kz3chWPXIN5kBON5iBt3+Gjig7Qk8mR1ZvgE+5KNff8v8zR97Q=
Received: from BY3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:254::28)
 by SJ0PR10MB5583.namprd10.prod.outlook.com (2603:10b6:a03:3df::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 19:43:13 +0000
Received: from CO1PEPF00012E66.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::93) by BY3PR05CA0023.outlook.office365.com
 (2603:10b6:a03:254::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.6 via Frontend Transport; Tue, 2
 Jun 2026 19:43:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF00012E66.mail.protection.outlook.com (10.167.249.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 19:43:12 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 2 Jun
 2026 14:43:10 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 2 Jun
 2026 14:43:10 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 2 Jun 2026 14:43:10 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 652Jh9fv3865670;
 Tue, 2 Jun 2026 14:43:09 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 2 Jun 2026 14:43:09 -0500
Message-ID: <DIYTJM7IRHSK.3UG460C1ZOUWF@ti.com>
CC: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>, <afd@ti.com>,
 <xypron.glpk@gmx.de>, <ilias.apalodimas@linaro.org>, <sjg@chromium.org>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCHv8 0/3] various memory related fixups
From: Randolph Sapp <rs@ti.com>
To: Tom Rini <trini@konsulko.com>, <rs@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260513204943.736142-1-rs@ti.com>
 <20260527000924.GA4051518@bill-the-cat>
In-Reply-To: <20260527000924.GA4051518@bill-the-cat>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E66:EE_|SJ0PR10MB5583:EE_
X-MS-Office365-Filtering-Correlation-Id: 80985253-6816-4c95-e5ac-08dec0df2e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|22082099003|18002099003|4143699003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: x/sVAHeKKIl2Dh2ggqga99NE4EHhS1gzuarUjMbcCltZBLvGmioOeDJzfHb8zE0cU1WnPNqcKR0FkC+k4JNJqId55gsiE361bj8tcE0e/RQ+pwDqP+C5S1la9qpUj+NI9joDPrEnNG6ww0cVfcSm5okVdon/rnleX6oWlMG9m34xgXR7LGGw/H8EU2S1le9M4Dt5XHbSowQewqRzpp5ujDx2B6DDHPL5lVeSLqTwrCqcueCnoD+FlGQsmabyDPhjs5wQXV/gEv/nxqFwSl6I7JyJy8oU+fO2N6yIddMCeQyDRxYrRcy+CMct3tRlOZ+YJMX6PNHdxgFktwuT4h0ej9kkvhakKALTTNDDVjOnpVnAfIu0GWJqwPYcZx9jchXNp72jHIPMkIIYEvSTAN6fjRFY2rwWn0YpJJ1//kgPleqdxLiBNqFgMzD2hDVDPEWhfn8GViVvi0pU8eY4k0sOHClU9mUk3g+WR/meEAUAFBtS7dDwD/fN3O7FdtkqG6TUEFLKnXCyLSJBhbQ/e0S3CgC/sMUPT2m1z10EE+AZLvPqbMfNAq7M2n8TgDt3biKDM+k6NoGzNBJTU/VGZBumyxp5AAfCuAa+nE6M8jfAQQGV95JWn539iFgjk4dWHallhWxTXVt2UiBKI9bHM07vHUZargMMF+DqinzGrbWvJJ8DdR+tj9mdS38nxgr86H2a
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(22082099003)(18002099003)(4143699003)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: //KbDPzRHHjbvcaabTfLthLaLc/ZlOOk6SFqvzeykRDEKMp6n2HmIQKhOVbzNPkMN2bC5PytKXzUXKTgAuBhnu2xS9yxjw3CUaU4XEQNdtniMsB/nFRwpXyaOcNvOdvWkBv8SeUud5ZBMg2WPVNcpdPOZRS0unTzI2MsvtzqhrFyDX8YsvP44mlSvLRH6WfvxIBFZAihp6sRcSYoBqsOlUUev3BjK3ugps/eKjfvi8BZJCvhsG89tX2nT1/TaGInapc2TlrZ0IDxpfIYIxGgCXkxnFd3fU5tRGbcthDCoTTjCllnsm2/vRYM4ld49pPjqw5fzvwrG9aiiGjFisDfmGTHY1ozdnhwPbJeI9D14ePU41rP5+odVuQ3zkDoAlz1UOcYTw044SwuKeqYs62NEBD9TPi2JxgpVwUdOhi2zScaK6frtYNyVEp1DmPvNh8a
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 19:43:12.0652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80985253-6816-4c95-e5ac-08dec0df2e5d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E66.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5583
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

On Tue May 26, 2026 at 7:09 PM CDT, Tom Rini wrote:
> On Wed, May 13, 2026 at 03:49:40PM -0500, rs@ti.com wrote:
>
>> From: Randolph Sapp <rs@ti.com>
>>=20
>> Nitpicks and fixes from the discovery thread on adding PocketBeagle2 sup=
port
>> [1]. This does a lot of general setup required for the device, but these
>> modifications themselves aren't device specific. For those specifically
>> interested in PocketBeagle2 support and don't care about these details, =
my
>> development branch is public [2].
>>=20
>> That first patch may provoke some opinions, but honestly if that warning=
 was
>> still present I wouldn't have spent a week poking holes in both the EFI =
and LMB
>> allocations systems. Please let me know if there is a specific usecase t=
hat it
>> breaks though.
>>=20
>> [1] https://lore.kernel.org/all/DHHC66BBMD27.YHGIH43C6XBK@ti.com/
>> [2] https://github.com/StaticRocket/u-boot/tree/feature/pocketbeagle2
>
> This leads to test failures now (that either need to be fixed or
> updated):
> https://source.denx.de/u-boot/u-boot/-/jobs/1464028 and please see
> https://docs.u-boot.org/en/latest/develop/ci_testing.html as well for
> starting CI, however you might want to run the tests locally first.
> Thanks.

So, that's the fun part. I ran qcheck with this. I went tracing through tha=
t
make target and even started manually issuing "./test/py/test.py --bd
sandbox_flattree --build -k ut_image_fdt_test_boot_fdt_add_mem_rsv_regions =
-s"
(and again with sandbox, sandbox64, etc.) to see exactly why that's failing=
 in
CI. I cannot reproduce the issue reported. It passes and reports all the
messages I'm expecting on my end.

The CI pipeline must not be loading the test.dtb. No idea how that's occurr=
ing,
or how the other UT_DM tests are passing. I don't see any particularly weir=
d
parameters in the test logs.

It's not like this test is dependent on the same things UTF_DM tagged tests=
 are,
but I expected to be able to reuse that device tree without having to speci=
fy
that flag. That's the behavior I have locally at least. Adding an explicit =
check
for CONFIG_UT_DM didn't seem to help at all.

Any advice here?
