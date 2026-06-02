Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57175CD6E5D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 23:17:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37E9E8485F;
	Wed,  3 Jun 2026 01:17:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bvwxn+Gn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71FF883EF9; Wed,  3 Jun 2026 01:17:36 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B52F84837
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 01:17:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wT1RWjCBgt65nPs18n1bQ4/nuHvnJzTaDV8yOw7iyYlvyC7QypdnaGHXEIS+iM1MdwEUZjelc3BxMiMh0q9mqluqA0XVtYZK43aXS8wkUghwQq6JQOu2N3AZ/aRAnKBTtD98PRvqaKOGfaFIn959YDz/FDpCkw+KkuRMg8HTInz2+dQrwZtDHdCZ5mPHV02Nw0/pd7opwILMQHkUFlYpmYCKbsOwFuSFPvIWRrCjeMPrOvSAoITMAb8Br8LFuYiBznb1l3enmL93sAJLyL++hzuOwCrDbvooGRUDPuH9W1cLC9I5esT67LAxiZYKBZ5prydoIl3e7BbKQGObwzy2Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGZoMWDVGNUtgNaEjWNZsDO5n71U+V+aCCcjdzLUXfI=;
 b=XEX7P/ROnSo70KC5e/x9D8V3dm15Gop81RejubQemcTkym0UeVhA8X8EOOrFRkEeiJ0wSLyf5Et4kItV01yYCgZZcF07ppBMnA0okr23fsutuptd9nR+bbyajb9qgHjeif+wYrZ7jLnAT+TVVKj+fWUu5cg5/4yOdYdfNS4UHZemHpaOk1cgTwMFRT6AodZuqFLW3UVErOM/LrlOWlQYLIZ55C8rYVY20sckC+cZ+gJR0aOKL2oUxKgfDdsf+mQ4IgrY+5rnB+Df5CQ0lQFxCcjygMltLgzPwtkypT25tIFBjZcv7ePIwRP4X2d93RUjKszofop59yjFgaMFK8HASQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGZoMWDVGNUtgNaEjWNZsDO5n71U+V+aCCcjdzLUXfI=;
 b=bvwxn+GnJj3sO+1+UYLbgxBN1lj4sEOdkX+4+nbPIpltnw55mKWQT6dLFi+yTe6+RRmpj2oiX89POEGEKGBzM2ibkjATleqPw2NxuF2AQZofoVb3Flko9VfXuHwxbuo30OcHvxl+n6VxTFL2oEmHAJlhs31eHlp9KAD9p1a4XTY=
Received: from BN9PR03CA0438.namprd03.prod.outlook.com (2603:10b6:408:113::23)
 by PH7PR10MB5878.namprd10.prod.outlook.com (2603:10b6:510:127::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 23:17:28 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:408:113:cafe::53) by BN9PR03CA0438.outlook.office365.com
 (2603:10b6:408:113::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 23:17:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 23:17:27 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 2 Jun
 2026 18:17:27 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 2 Jun
 2026 18:17:26 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 2 Jun 2026 18:17:26 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 652NHQT04177592;
 Tue, 2 Jun 2026 18:17:26 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 2 Jun 2026 18:17:26 -0500
Message-ID: <DIYY3OHVR8RJ.1PB5CX4VZJPN@ti.com>
CC: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>, <afd@ti.com>,
 <xypron.glpk@gmx.de>, <ilias.apalodimas@linaro.org>, <sjg@chromium.org>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCHv8 0/3] various memory related fixups
From: Randolph Sapp <rs@ti.com>
To: Tom Rini <trini@konsulko.com>, Randolph Sapp <rs@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260513204943.736142-1-rs@ti.com>
 <20260527000924.GA4051518@bill-the-cat> <DIYTJM7IRHSK.3UG460C1ZOUWF@ti.com>
 <20260602203147.GO627328@bill-the-cat>
In-Reply-To: <20260602203147.GO627328@bill-the-cat>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|PH7PR10MB5878:EE_
X-MS-Office365-Filtering-Correlation-Id: 661ca26c-1cf9-4aad-fa70-08dec0fd1d03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|3023799007|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fNxIo4bbRiePPaUstnv5wRG1z2iUi9IU+N98b0aiEUyP7wE03Zj7Q7CcXl7WrmL0JBLuEs5SuBMWw0FiNkc0GiZWs2LqDvbjlp3uArMjGjMerlb/nBFhzI9zZ6xN96xz+Yy/Yr6CvrqrwGbWIIjue6TKraWrrRN7oB3uqd0GHUJq/OVy9v04AaRTrB9RQsTBv5p6M3akJO6SnYbVTBAZ5tI4pUITCgu+qwOd34fDszC9dZDk6cZ+YP3BxJSJ8ENdjliZb/lxJkApcEQLoWR0hemt+kEBZU9kRAx3sPorrnK8nXJ6T2jjsU3rNvPIxQhiwLK0B3KfXrdJvxp/W4w6kuR4XXYgk/DEQRFthtoVNwjI/dDuG6fzA0eHWLqLB/ye51rCdKdWWRjpjmwXOaydMzOKt4P21h5Z4wyPOrw2RhS3+dSAINrr1jm9V2t4hk8Cq1keWhrFprMJZ5FrzCZvNBajb7iUL9mWjQP/B+a2TtDMDyLSnxHWd3DFwdpLdmwBwVOIyJpJkx7oV1hIsMlWVTTWjgjqKcjAAfYq+7LdFzX+wbQ6cCyh6d8Ujn+nTo7v1mHKg4XVTPj4YUdj8fP8SPPuKEqLyEWDz9t/1DZXBJ0YrmM+NF2D9htpgNruVibgshwOOwntk3xZD+gvsh18fM+nqr+QITCFWhXl8y6+NVaVuZ5FRrfQkp0iTzqXavju
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(3023799007)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: myK3ucdy4rc0PhKbzQbKqcUMJSzOf/4LMBJmet9dB3D5wCH63X6dSDRNiQ6MfElvmDula8pG61Eh6z69sTrqAr5VpueLUj8G5FocFiw7IKEtpnNFV1L7xQtwPPsBWEXfK+LSGEmnHRlGvv3Iuyz/9W6QJBNrzoK89WDi2FC68oRdTJX81Ubr0N0Uy/ioUHUHPM7Hx3VRwtjXPWtcGGS2GrujFhle714KvPg82cQ3po8StcsgWQtTKBm3/CtKFn8O+XPcVGMW6YCHrT6XlmJPKvzf2iimXWO2cFTWCtdADp7GwF+UtDsn7NeZl6h0JkfJwgjzpp6rNikj0xp4xAy5OMjHal/dnsT1VwNxb4jG8NxNAXco5uPymjTWnZgAitWVtTLbYvOXZAoX8WUopRxYxMPs9VKVKkGKsZ36lQ1sBxpRpAYbXPS1PkYazcSOkJcc
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 23:17:27.8074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 661ca26c-1cf9-4aad-fa70-08dec0fd1d03
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5878
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

On Tue Jun 2, 2026 at 3:31 PM CDT, Tom Rini wrote:
> On Tue, Jun 02, 2026 at 02:43:09PM -0500, Randolph Sapp wrote:
>> On Tue May 26, 2026 at 7:09 PM CDT, Tom Rini wrote:
>> > On Wed, May 13, 2026 at 03:49:40PM -0500, rs@ti.com wrote:
>> >
>> >> From: Randolph Sapp <rs@ti.com>
>> >>=20
>> >> Nitpicks and fixes from the discovery thread on adding PocketBeagle2 =
support
>> >> [1]. This does a lot of general setup required for the device, but th=
ese
>> >> modifications themselves aren't device specific. For those specifical=
ly
>> >> interested in PocketBeagle2 support and don't care about these detail=
s, my
>> >> development branch is public [2].
>> >>=20
>> >> That first patch may provoke some opinions, but honestly if that warn=
ing was
>> >> still present I wouldn't have spent a week poking holes in both the E=
FI and LMB
>> >> allocations systems. Please let me know if there is a specific usecas=
e that it
>> >> breaks though.
>> >>=20
>> >> [1] https://lore.kernel.org/all/DHHC66BBMD27.YHGIH43C6XBK@ti.com/
>> >> [2] https://github.com/StaticRocket/u-boot/tree/feature/pocketbeagle2
>> >
>> > This leads to test failures now (that either need to be fixed or
>> > updated):
>> > https://source.denx.de/u-boot/u-boot/-/jobs/1464028 and please see
>> > https://docs.u-boot.org/en/latest/develop/ci_testing.html as well for
>> > starting CI, however you might want to run the tests locally first.
>> > Thanks.
>>=20
>> So, that's the fun part. I ran qcheck with this. I went tracing through =
that
>> make target and even started manually issuing "./test/py/test.py --bd
>> sandbox_flattree --build -k ut_image_fdt_test_boot_fdt_add_mem_rsv_regio=
ns -s"
>> (and again with sandbox, sandbox64, etc.) to see exactly why that's fail=
ing in
>> CI. I cannot reproduce the issue reported. It passes and reports all the
>> messages I'm expecting on my end.
>>=20
>> The CI pipeline must not be loading the test.dtb. No idea how that's occ=
urring,
>> or how the other UT_DM tests are passing. I don't see any particularly w=
eird
>> parameters in the test logs.
>>=20
>> It's not like this test is dependent on the same things UTF_DM tagged te=
sts are,
>> but I expected to be able to reuse that device tree without having to sp=
ecify
>> that flag. That's the behavior I have locally at least. Adding an explic=
it check
>> for CONFIG_UT_DM didn't seem to help at all.
>>=20
>> Any advice here?
>
> Have you tried running it the way it's shown in the
> .azure-pipelines.yml or .gitlab-ci.yml files? And I wouldn't limit
> things to just the single test, it's possible there's some unexpected
> thing to be cleaned up from another test that's contaminating things.

Hell. Had to bisect all of the ut tests just to find out
ut_bootstd_bootflow_cmd_boot is changing out the device tree before my test=
.

I didn't want to make my test dynamic because there's a chance any reservat=
ions
I try to make could overlap with a device or some already allocated range. =
I
need some known working allocation that's in a valid DT to be safe.

The bootflow_cmd_boot test will change the state of the running sandbox in =
a way
that I assume can not be easily reverted. Please inform me if this assumpti=
on is
untrue.

I can add a wrapper fixture in pytest to make sure the sandbox is restarted
specifically after that test, but I'm not sure if that's appropriate.

---

As an aside, test_ut_dm_init_bootstd should absolutely be a fixture instead=
 of a
test. May need to fix that later.
