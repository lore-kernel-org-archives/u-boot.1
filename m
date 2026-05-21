Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67DEFCD5BAC
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 09:10:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4BEB8341A;
	Thu, 21 May 2026 11:10:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="e1Pai9OO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 131C78432A; Thu, 21 May 2026 11:10:11 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD77E805D7
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 11:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZXaaI1ULBgHcyiIg8dCXjWkaQEolar81uIT6e8gH9tCpjLyeYGIZkABHZDp2PgBdOmvaEd+hvW9vgea6sivAHuX0fcsX0qN1Mwtdh1+Unz0Hp52BE5VACnNCc+7Cj01Xi/d9tK+U3R6Y4sUG9gHO2ykNrgyfS3bPtpXK4010mLNTE1xq5QoSUZ28F6tEm7ysdnyMJohLu36K+CZX1urxxUKLqb9bzSUoXWvpmjt7cvFXtqif0lplKo5L/horMqWlyCpHOQ4HOhIfQFusvIvS/wL1FWHtfLoycQ2TrW32aBKHwuE4RNz83Uj8EjGVFFhh9Div7VMaw3zRMw+UDipYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1idk48aSGW0wbeCQuqrP4QCOW9dtKYbdyACYD9xaO1o=;
 b=S8D0robBlKIP5V8VUfGFZsao704e2fKvymLx7X5wm/J5fXRjwkRzZvYeT0v8RS0fjolHBeJphm/09l14iUTBsugJXh+NwAISj8PstnUs64s2OtYXQh7qGuuyhlXHAOeKARsoFUFAlrV/IrcpN5qGdp8HN9dVT8c9DF9Cq+mXoyvYipEzmVl/Q+we3XrFign/KD+B5Dq5uaMRjxPUrQ0xDzY/lQDHa2Xre9aAPXnEAyczKC7b/6Y02ijBnJcntPvO+qnsDqHTa6rsmcoD/eCtiIQMmxPlLCmZ91x/TFzs9W/pEO2fPQ36aT5Ro363Or+GcqIuXLXR7224b9fLQMtKww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1idk48aSGW0wbeCQuqrP4QCOW9dtKYbdyACYD9xaO1o=;
 b=e1Pai9OO8GnMP2fMQ6ybRnF0HWZ9ouLzwgbVFKDRjvMgYJe1mI5pNmc/q08SjdA8GeiMVpan/d3wrc0eYY5J2f8zMWGaa1prCEMbxNj/hEzSvoyLShdWGRfvuMEtVuW0h2yhj1GFYFnIFlMUXs2a84LAkr159+yodkh9WNtsujE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DU4PR04MB11388.eurprd04.prod.outlook.com (2603:10a6:10:5ee::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 09:10:06 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 09:10:06 +0000
Message-ID: <ae7e69f3-2e94-44ee-b5ce-685f7f30b0b4@cherry.de>
Date: Thu, 21 May 2026 11:10:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] test/py: cover get_basename crash on paths with
 dotted directories
To: Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20260521023503.29315-1-aristo.chen@canonical.com>
 <20260521023503.29315-2-aristo.chen@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260521023503.29315-2-aristo.chen@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0120.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::18) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DU4PR04MB11388:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e4d027c-b361-4635-bc29-08deb718bff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|4143699003|5023799004|3023799007|56012099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: gIazfDnbVo53y5+3SBoSM37VwpOizSpM0QTvZ70u93Uam5ozlGK9b/SHqNLcDne9FQVYnUOCBruxYIXEUFrgv7w0V6iXNYZdX9Dm7GaOU7Dw1X45NSWvderotZRwbhP/2rL0ChfQBuoTRTQTCwwj6uxiWosUT46pN8e/1s4UtsoOKh4fK0vO1yNSAU29g/xPQSVU0LQt76Nh++oumfHezEq/A9uIGONu2OaiRz0/JSnsBuYVWWfdZTZwh5ispl5q2TCW2cwxjhDjOBUqVvSOnbV3k40rvAvJTuYyHF5AJD7XVQZMJBSbbj2pU/nsjFK30ThpxJQFtQAzUqmWIZwUY2CKIkNNnZMC5fDFcn9gBk8zair+xvZF4T3qWWkfYGU6+AEarqXE8LRFRWiV3s8mXmlOUJYU72ZYxkofy6+cADWDaXFPlmUzl2v8I4mSH13jHgDGqhFdJkdhzmG19S1S0hdI9toKU0Lpgq5v6EuMcegjr7GNSS6vjSwmtmAGMrZnONstizQiBYfNrDAyEWS+Kyzc779rhpBqMszYEbHwi6YdFfZji58J5YJZNm5Oe/KFAus59PZtKltbDY8KPzGi5bhGtMW/H8u0lfFKCSCptK8KDlaLCPGdEHIZfgvJ8DmYQ14guLRPm8mM5EJr2TT6W6uuPJPA+cqMxLrbYyu56zjWkMnkz7F1t26tiBaMqBLw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(5023799004)(3023799007)(56012099003)(18002099003)(22082099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2svSDVvOS8yeUtwMzJkTVJmWXJFb1R3K0ppaFg4dE1Wd1ozRzBPcWJGckJ2?=
 =?utf-8?B?anBOMmFveU9Ca200cWRYYW5CQmZwZ2RTck9tOHprNXZNamNVVkpTeWhXVC9v?=
 =?utf-8?B?N3ArUVVFQmRCNWxMVlZuTkp2Sjg4ODJOQThNa0hGaVkxOXF1bktRSm90VkZs?=
 =?utf-8?B?eWlVNndta1RDUmlnciszQkFzVDk4WWhXeXcrNVJGQ0l4eHI1d052dkpzYVJJ?=
 =?utf-8?B?V2tmejRPUTd4bnNQZU1CNGYxeXVIc2dBUXh4OWtRTnBrOTNDVVJvS1A2V3VU?=
 =?utf-8?B?MTZmUWZ0c24ybG9jTWIya0VwbXF4Vkt2Q2l6QmhVN0R2TmEvOGlDcXZMSjBp?=
 =?utf-8?B?RW9RWWI2L1h1b2ZqdE8yWVpMTzhjTjZ0eGJnT0t0VEVwVFovdHF2R2VBdEM1?=
 =?utf-8?B?TkJadVRjSytySmQxaDVvSGY5K0prNVdaSnhzTkVmZTBlRmI1TzVCNVJHcTc0?=
 =?utf-8?B?ZHBJcVovRDAvWTBvYlRVN0RlWmROWHNDdGdtRHJrbWRUT3lXTm1tWHl1Yy9z?=
 =?utf-8?B?QlhzUGtQNDQ3Z3dVN29nY2dKWlVuUllCdERGNVpVK0JvckpsT2Q3dWdtNEhS?=
 =?utf-8?B?OGlkRHROdXl0QUN0ZHRNMDYxMzFwVFljb2hpS2thTEVDVEFoaDZZWWduV1lI?=
 =?utf-8?B?ejUzajYzeWx2TW1uVWFHaHRNWkRxRE13R1hNNGMvSUVGSHh5cklnSjl0OTEr?=
 =?utf-8?B?NDRzQXhCWllkVHFGMTRHd3MwaUVZTTF5dlhNVlZwa0xnd1F5eE92ek9XVnBy?=
 =?utf-8?B?bFNIR3pseVViYVRVeDA0SmRWUDhMUFdxbWkvR0QwRXBpUUxQczFBNWk0aTln?=
 =?utf-8?B?K0NOTFFqUTJNNXNpSmIxTExSWnVKUzNQY1BrcG0yNmQ4SGZyVDRLckVoK3Rk?=
 =?utf-8?B?eXNCbmN1dmRDcHhKRnBzcEozU25YVmZ2RWNyT2huYVp0ZFAzUGhZUTQ3cDNI?=
 =?utf-8?B?ZlNwbkowdjhFMG1CWGNDVWp5bXNtR3R2YVZueXNwWGhTeHh2a3l3clF2QllE?=
 =?utf-8?B?TnJ1c2JzankrcWJLVlBPTnduWXlZU0gwRWE0czJpZkxuY2pNbTNBNGxzTkVp?=
 =?utf-8?B?eCsxTnU2ZDZneUdDOUVrcHo1QVlObW1nS1hIdE9lQTRwZVRPM0Q2VktnZ2ds?=
 =?utf-8?B?WmtQNTlwSlhWbTFTU0VNNjNkVExhRnQwdDdxK1UwdWJqdVJiYUxzZnI2UTVV?=
 =?utf-8?B?UjliQW10YjlwTEVYZklQcWJYa1JLNnhIR1NORTZ1WmRXK2tZekw2Q1hMODZN?=
 =?utf-8?B?UWo3R2NPeElOSkloQmV1WlVIcGVlRWVwUW8wNDd1dXEwcVJuZUcxZGZobllS?=
 =?utf-8?B?N2ZDR1RhNnFKdEE5cmt1QmNxODFTLy9ucHU5TTlvOWwrZnNYZC9XTTZWUDY5?=
 =?utf-8?B?bCtBQnZmTE0zcDd1OUNoenJ4eWJwMW56WXEzdG05aXpFbmlUTlVIWEhRR0RV?=
 =?utf-8?B?YzNvRkxJK25pdUR4VlJkM2hxZEpHK083emwyNlNMVStQWUIzcWZtRkg4eUJV?=
 =?utf-8?B?aSs1dDQvUWJkSzdvNVA5UXozaWdHWThrVHNtdmUyL3FKbllDY2xQNFVKS2tV?=
 =?utf-8?B?RzhzRUg5VnVzSGNqTWYzazhzY2pKU2xjaUluTkxTanIzMnJVQnYrZDZmelRD?=
 =?utf-8?B?THphS0xtRVNLR2wyeHVCRmVLZElwZ1lZbkliQUtHUFJ0aWp4OWh6akFZVWZR?=
 =?utf-8?B?enhzSCtNV01mRmlEQ29HdEp4SjBGYURDRUZZVE5yNCtTOStqeDFXQXB2aytE?=
 =?utf-8?B?WUszeG5ZRHRMOWxXZVpVSTlWa1JrOEJuQnltZXIrNTFPY3RZR1lGUlBDQnhE?=
 =?utf-8?B?RHlhbFNRTDJWWXlqcUJaN2RidUYzMUIzbnh5RkI1RlJWK2lYQUZCMkdMUlJI?=
 =?utf-8?B?dXNZV0x1MER3SUhiVEVqZ0Z4UDRwOU9QMnRmOGpmSWg1eDNJSjdmbzIrbU9k?=
 =?utf-8?B?YklQUitiYUVjMkRncjh0U282U04yWHJ6cWI5QmFLQ2wxaXFKellQbVNNbTFk?=
 =?utf-8?B?VlBDOHZKSmNNVHhreFRQVndZU3BrL1daakdMak04eDlZMzJCLzRXbmhkalpv?=
 =?utf-8?B?S2NMeE5OcTVMdks0dE81NEtMS0J6ck1OU3JiMGJ6K3YvWThoSGEyL2JmU0Mr?=
 =?utf-8?B?cUdpSjBKNW0yUDRNNUVjM2h4WnVtRzJ4MVlmZno4b3Q4aU1SZVBCUUg3anN1?=
 =?utf-8?B?blZjdmJzN2ZUcEFjRXNObFNuWGZ3a0lBRnpqRUFLZy9TU2Erd0xFa0hxUGFH?=
 =?utf-8?B?MFpsUzNydEFicmhiNHpJeWtyL3Q3VUNJbTd5aWxSMHU2Wk9wZTlSNndmSE5i?=
 =?utf-8?B?S0hiejFLbDR2alNPWTkxTG1XTWs4Q1UvbGh0UXpSMnF4NkFSZTdzUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4d027c-b361-4635-bc29-08deb718bff1
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 09:10:06.3731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+wUnts0acEkXqKNYq2Jaq7R0GmWeph2bFwsa76d6t/Adp3ej8SYFpb2L6y0H5Fg3NBDU43NlJCARZSs7nRmewewsGJiRCnUWywB4S0qn0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11388
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

Hi Aristo,

On 5/21/26 4:35 AM, Aristo Chen wrote:
> Add a parametrized regression test for the fix in the previous commit.
> The test invokes mkimage in auto-FIT mode (-f auto) with a -b argument
> whose directory component contains a '.' and whose leaf either lacks an
> extension or is a plain identifier. Before the fix these inputs caused
> get_basename() to compute a negative length and segfault inside memcpy.
> The test asserts that mkimage exits successfully and that the fdt
> sub-image description matches the expected stripped basename, covering
> "./mydt", "./sub.d/leaf", and "./a.b/c". A control input of "./mydt.dtb"
> is also exercised to confirm normal extension stripping still works.
> 
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> ---
>   test/py/tests/test_fit_mkimage_validate.py | 55 ++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
> 
> diff --git a/test/py/tests/test_fit_mkimage_validate.py b/test/py/tests/test_fit_mkimage_validate.py
> index 170b2a8cbbb..0a1cc5963a6 100644
> --- a/test/py/tests/test_fit_mkimage_validate.py
> +++ b/test/py/tests/test_fit_mkimage_validate.py
> @@ -103,3 +103,58 @@ def test_fit_invalid_default_config(ubman):
>   
>       assert result.returncode != 0, "mkimage should fail due to missing default config"
>       assert re.search(r"Default configuration '.*' not found under /configurations", result.stderr)
> +
> +@pytest.mark.boardspec('sandbox')
> +@pytest.mark.requiredtool('dtc')
> +@pytest.mark.parametrize('dtb_relpath,expected_desc', [
> +    # Crash triggers: last '.' precedes last '/', or leaf has no extension.
> +    ('./mydt',       'mydt'),
> +    ('./sub.d/leaf', 'leaf'),
> +    ('./a.b/c',      'c'),
> +    # Control case: extension lives in the leaf, no dotted directory.
> +    ('./mydt.dtb',   'mydt'),
> +])
> +def test_fit_auto_basename_dotted_directory(ubman, dtb_relpath, expected_desc):
> +    """Regression test: mkimage -f auto must not crash when a -b path has a
> +    '.' in its directory portion.
> +
> +    Before the fix, get_basename() in tools/fit_image.c searched the whole
> +    path for both the last '/' and the last '.'. When the '.' fell before
> +    the '/', the computed length went negative and was passed unchanged to
> +    memcpy(), which segfaulted. This test exercises three crashing paths
> +    plus one control input.
> +    """
> +    build_dir = ubman.config.build_dir
> +    kernel = fit_util.make_kernel(ubman, 'kernel.bin', 'kernel')
> +    itb_fname = fit_util.make_fname(ubman, 'auto_basename.itb')
> +
> +    # Materialize the dtb at the requested relative path inside build_dir.
> +    dtb_abs = os.path.join(build_dir, dtb_relpath)
> +    os.makedirs(os.path.dirname(dtb_abs), exist_ok=True)
> +    with open(dtb_abs, 'wb') as f:
> +        f.write(b'dummy')
> +
> +    mkimage = os.path.join(build_dir, 'tools/mkimage')
> +    cmd = [mkimage, '-f', 'auto',
> +           '-A', 'arm', '-O', 'linux', '-T', 'kernel', '-C', 'none',
> +           '-a', '0x80000000', '-e', '0x80000000', '-n', 'test',
> +           '-d', kernel,
> +           '-b', dtb_relpath,
> +           itb_fname]
> +    # Run with cwd=build_dir so the relative path resolves the same way
> +    # the bug originally reproduced.
> +    result = subprocess.run(cmd, capture_output=True, text=True,
> +                            cwd=build_dir)

Considering we set cwd to build_dir, can't we simply use ./tools/mkimage 
instead of prepending build_dir to it? It's unclear to me if it's an 
absolute path, but I'm assuming it is otherwise the test wouldn't run.

> +
> +    assert result.returncode == 0, (
> +        f"mkimage crashed or failed on -b {dtb_relpath!r}: "
> +        f"rc={result.returncode}\nstdout:\n{result.stdout}\n"
> +        f"stderr:\n{result.stderr}"
> +    )
> +    # The fdt sub-image description is set from get_basename(); confirm it
> +    # matches the expected stripped basename.
> +    assert re.search(rf"Image 1 \(fdt-1\)\s+Description:\s+{re.escape(expected_desc)}\b",
> +                     result.stdout), (
> +        f"Expected fdt-1 description {expected_desc!r} in mkimage output, "
> +        f"got:\n{result.stdout}"
> +    )

I can't help but wonder if we shouldn't make this less dependent on 
mkimage's console output (and thus requiring a regex). FIT data 
structure is simply a device tree so why not parse it to look for the 
description property of the /images/fdt-1 node?

What do you think?

Looks good to me otherwise.

Cheers,
Quentin
