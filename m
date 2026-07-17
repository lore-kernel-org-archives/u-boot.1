Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B851EC4451C
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 13:58:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 066C284E56;
	Fri, 17 Jul 2026 15:58:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="atNHLmbV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C630484D6D; Fri, 17 Jul 2026 15:58:35 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DFEB84D6D
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 15:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kuj1SPaPQbokDrPpO0Wud5uzPuWel4zAdo/3AEtqIGUDuy1HaSZ0iq0n9qTjaCELM/p9YNeyE5xwNB7px2QInmAwcUwjg2YvV5Os2AfFS7hrLu91GyxrOE9ySe3ssH8GJPHhWZDLLwRLD5HUKUeBQSZAid3SeVwQeQGQ9xbus0G6enlhViW2pG4r7cK+ZYrxPe1QvyTH1gtXqTaI7dqO6nFJNRawIBfDmUiCasVU9akIdWtr9jKHQ9DyyMx9zuwAuR2VxqzBdMlbmNA4/+n9NZifeoFQc+irnD/6znTslZYB3HhT/c7UDm56fG+suMEAtxYD25q8HDtov5UzEV1Xwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJJtzWPtS6Q0ZfaSDF9oXc/3sOvzX0gqPTKtXJLr5QU=;
 b=eI9uNAm32VbX+vdSl6VUUngPHZyzOJZLZ29mEC9JqbyPmNJekZQdY40Yx58++1QVoxjSXl5W5rB+puIgY1yT6ka4AOJxJn0z1jb/A6ndAZf0n/i9bjwhYWYneKqi5zhuIYQ2fVdaHhigFGV1fh370T4YlgkpUK38EiJdpYcCGxyLYCmND+qlbKAyu6XdsAbh9ZgjQBnFki4MKl/T8oNohMSrxX1DaLR/zUPoSlFwrY5OmNdixDbW7ezw481c8aqGTNhO3luXphApfUVzftquSqhV4X/OJB3WmrZTdyiCjN+8+oJK83/dhql/wcFjEfKQLcFlKNktcUBhguz0Jm777g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJJtzWPtS6Q0ZfaSDF9oXc/3sOvzX0gqPTKtXJLr5QU=;
 b=atNHLmbV5ajZ0qXJ4E/p9JWGAPDKgOtu+38Q57lsipSQambCIDRK+QcHcaDgCO4F0zZqjoWxg769cvSJLMyWUkyH67Xmo2TtJG+pmdhSTvA9A5lfS7TdlSyXaUKaNboAM0cl0Wzs3IYuI/1LAp4AO0razWZz75zaTjLdQ9YzaO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS8PR10MB7426.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5aa::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:58:30 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:58:30 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 0/7] k3-binman ergonomics
Date: Fri, 17 Jul 2026 15:58:17 +0200
Message-ID: <20260717135824.2142135-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00073CE3.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::1c5) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS8PR10MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ac8913-2aa0-4fe1-6235-08dee40b7b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: cNU1X9axdjO8R3Hc2GBCqYQ/VHQisfmo64FceQfuDdY7bkY7T7SM94AKfyKphSDpnDMp5gkFREA1MkINd9wmEA4Lysgd/qz2lLKdrOeQmPzuKzrOLbupzPLMwz7dhn3O18Bcu0HoNbs5mTnlarM/+mx4y4JXL4n0flOZoBqV4UZlaOqCuJa04TiplEZw2tFYBw0R+tCPU9TdpDk66PZwQgJPo9yQ8BFfsqWT+zxycnfpW4D9hXt03GoW5tBel05RUlUgSuRXiWLCiDI4+2HMYdRMVLPnxUlMs2XP9DzjYPlkp48vhGMie9+GkwNmvwohZUdGQpc/ejIf5suBVjxMSuZ1c6cehNwLHjhhuSqey1wQCQWLwKMVIJgmCh6C9I7dqj7itmuXY7hQFYMqQNxJTQ9/UPl7COezhVCxgSjU4iFlC/bVqtp9m8/wRNYti22k+K6+5VweCXPpBTcxkyWvutM2ypctFIeXvgZPBOwAdMDi6GfK4vzGTj5E7DtE47Q3qpdp1ZEOYTHh65qlMe0/6yQZfD9EM4BqoarKs6u9/wqnnrlLD/FPhloMMhYUe/oUv8EKW8QfjUcRR6H3WhyGwpUGYoGJ76ydh1vymXaWPdoCxeo3o1RpTRre4ZAN97mvKhBrl9q4wIZiCQOy4PM+VNKqUHLpZK+TfeWxI0II7FE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(10067099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E+J3UeJWvV0eZtJW2s6ZJuwTkan1EcSrBndQ59TG5YyLeezUmsPqdJS8XJQN?=
 =?us-ascii?Q?TdouU8gWi+rE+XXhAqbX8uUQ47AXLZ/bnRUuL7y/oqWVAsQF48/uUh7pN7AV?=
 =?us-ascii?Q?aC/rtd+xUXhXC/o7YfuQ5Z+dHzm1RbPGwZyi2LHUYhoMtKe6Zq1Fv3bw9po6?=
 =?us-ascii?Q?OhIZp+NOWpmP9iC5+mN3+hFhVC1o6LeCjbYlLcR0wx1JN9IRPj30y2Yb+YbW?=
 =?us-ascii?Q?KMJr6EEoGI03kYFMtRdb7sUvql9t7ihC2kBQEOmTXu2ZnHmD5bPa0/172EXm?=
 =?us-ascii?Q?OCBSaosb2OodBbkykEFRa6nS1LNfe8yJjW0eV8TsSB79+Nu/DzUf5iL6mXbT?=
 =?us-ascii?Q?/c9r31L8wJfiz1mqxSs1Aj7y42EMX8IIC8KiPsyGCV92g7g9Of8n+tP5QDtG?=
 =?us-ascii?Q?Ud/LHgtNVz9DYPIFmBjUi+i8B4115p0dWqnd6k6Yd5wnv6jnURyFKTi8Dbzz?=
 =?us-ascii?Q?yCCN9qt0shERl23Nl0YthkHwAIALP0z8AG7hK64u4pVjSVkI/QdvoREpIU/J?=
 =?us-ascii?Q?uO5QndfS96A3UEASaexPgnBAEiCQafKXbD/A1JN25k6C58tZmWeix6ULCRco?=
 =?us-ascii?Q?vg69nBDBz+00e/FjQi7AGc/6jHXZzmzNoGMABtJ1VgZkJcoPu5m4wrmo8/f8?=
 =?us-ascii?Q?FzDQXHsLrvg0pPTbkALm+6rOyENDo8uufSox45K72v89/K9uxu5pw3gXR26s?=
 =?us-ascii?Q?UmMRW1HtFbIUPHvPQr3pqylFfpekR3qQrNMtLu5uYYNvUAf7/ugSqGOPGbXc?=
 =?us-ascii?Q?mAfNNucIE4jthludVu7IXmckASU1oJmllNoWSSGb0mPa3DwxZwQCGq16XJB+?=
 =?us-ascii?Q?ioT4coKPmiEaJUemadj0aT9p/F9nhuDRfFvdFsLOmQIQm/VDOhOjEhCqSTin?=
 =?us-ascii?Q?fqo+hAt+Tuv1WYeB6V0ElgVdO09VsOEKJFV9n5nCw7/4pDtDUza7Pie1YFeN?=
 =?us-ascii?Q?PQ3XjTn0O2lDCrM7vN4hFWHJLFlVst4XgRrNaiB90MQHVWbJQGgM6unOnTeN?=
 =?us-ascii?Q?gyXnNZP2vB6uRCO6xJJndtdLrfCLIxXhS5ebJkDY1/vHd2UXLEY3SbySgNZT?=
 =?us-ascii?Q?59D85vyR13p2BG8wwAyGJ8GGXgUF3TJy1wTuEk6BKY0b3nUVhX+e7c6E+Aqk?=
 =?us-ascii?Q?qPzzi2dbFBbEzQVZdndIvLLX7qQz8CkEaA8W+z0GpihDv6N8Bd520NT9j3gn?=
 =?us-ascii?Q?8x0tAl3VtkqeBR6u35DOhuBdTe/x5c244fmpwZnadviw7SF8IOlYiJidKqoh?=
 =?us-ascii?Q?nYCYt8LgMvjvD388+1uuLdL5JD2zpf8gsmNcVKQ7DpYiJ3LGvB83Ryn5q9Aw?=
 =?us-ascii?Q?XIAyaclTxlgUt9/h3i7YU86YJIoa/0ne0VxfFZvLvy5K2T8LIulX0+7FgXb6?=
 =?us-ascii?Q?+ksG3Ppki7Kf08KnpjNEpjT7W6oAkPGj75amF61jWENd+ibPpGGSHZINyNfw?=
 =?us-ascii?Q?LgzL/5/4F3PIk9eVErjO6kZ7iWCMrpo/qKRE8o1REQ1YHBkgtpvK2tFx7VzK?=
 =?us-ascii?Q?l8OluI5l+lYReCtxbwEMwW7m8ypkqR5ietaGgQSAehgXtrBKzp0bL4OJhACD?=
 =?us-ascii?Q?l4yzEZU5bC12MMn/v8ZdtOZWQEY/tcgNgUHWbhcIG9eDQFYPBn1G1JxHD6ws?=
 =?us-ascii?Q?RjerAdIIOq86TkOnE+DJhTsEMbbLlzoUFbYNPY1Q6SKFZePTdiqK8T4+mlgx?=
 =?us-ascii?Q?n/utCTlTIwHHDsOEB97noVNml/P8yi588xBto6ZfqYA3bKIJijJQ7xgabwPp?=
 =?us-ascii?Q?OWYsd6bh0ejkqCu7/8RahKaTnnNJOj8=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ac8913-2aa0-4fe1-6235-08dee40b7b54
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:58:29.9434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jl0+MuLtI63/aY8G4InI5EP6TiQw9S9YZ4/KhyV0jx3BZ/NNNOXnRsyLbmcp0EtL0+FgTvDtqyR3HIcdOUxSMstWtfBnp0/4JMPNtiFXzWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7426
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

When trying to hook up use of a customer's own signing infrastructure
for some am62x devices, I found it was more difficult than it should
be to point at the right key(s). One has to patch in the keyfile=
property in way too many places, and if you miss just one, the build
succeeds using the generic custMpk.pem for the one you missed, but of
course the resulting artifacts are unbootable.

Use the template mechanism that binman already has to allow one to
only set the keyfile= in a single place. I cannot really imagine any
case where one would not want to use the same key for signing all
artifacts across the r5/a53 cores, but that is of course still
possible, just as any downstreams that have explicit

&{/binman/tiboot3-am62x-hs-evm.bin/ti-secure-rom} {
    keyfile = "foobar.pem";
};

&{/binman/tiboot3-am62x-hs-fs-evm.bin/ti-secure-rom} {
    keyfile = "foobar.pem";
};

will continue to work.

Changes in v2:

- Make sure an x509_cert entry (and derived classes) always has _some_
  valid reg_dist_name attribute. openssl not only requires existence
  of a distinguish name section, it also needs to be non-empty.

- Implement the "allow string list a value" for distinguished-name
  properties alluded to in v1, as it might as well be done now and
  doesn't take a lot of code.

- Verify that property values in the distinguished-name node are
  strings or string lists.

- Add documentation, both to the binman entry definitions and a new
  patch with an update of k3.rst's section on Secure Boot.


v1: https://lore.kernel.org/u-boot/20260710123618.2036728-1-ravi@prevas.dk/

Rasmus Villemoes (7):
  binman: openssl: refactor creation of Distinguished Name section from
    dict
  binman: x509_cert: allow and parse distinguished-name subnode
  binman: x509: fix CN emitted for basic x509 certificates
  k3-binman.dtsi: add keyfile_template node
  k3-binman.dtsi: add empty distinguished_name_template
  k3-binman.dtsi: insert keyfile and distinguished name templates in all
    ti-secure(-rom) nodes
  doc: k3.rst: describe use of keyname and distinguished_name binman
    templates

 arch/arm/dts/k3-binman.dtsi              | 35 ++++++++----
 doc/board/ti/k3.rst                      | 48 +++++++++++++++++
 tools/binman/btool/openssl.py            | 68 ++++++++++++------------
 tools/binman/etype/ti_secure.py          | 16 +++---
 tools/binman/etype/ti_secure_rom.py      | 16 +++---
 tools/binman/etype/x509_cert.py          | 23 ++++++--
 tools/binman/test/security/x509_cert.dts |  5 +-
 7 files changed, 147 insertions(+), 64 deletions(-)

-- 
2.55.0

