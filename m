Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3D6CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 22:55:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC75F84859;
	Wed, 20 May 2026 00:55:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="RuvGCzY2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB303847FD; Wed, 20 May 2026 00:55:08 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ABCD846A5
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 00:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKnMxXYiDDnabV9osACAVqkc7slNrVycj8337AIXIe/YttQn8oRuCKXV84YX/5RAhknJnj/NASulUk/g9NoPVpeBLPq4EUbY7zywhyZsh47Mbz9+UDSE75VMsD9nGr0bor5AyHOuspCZf4zSh6nOwFr6ywmGTYSmiCys/HmoY1HVRxLa/sETrkgw6vjhq+3E8nKfhcUpJCXstzT8B1SxNG6nDvE5bZ3jPQcj+S2c9LIY0LZXtCPMxBbPtVBqgqs+x3fkBLPeyYgu9sAHSyM96pyeJWOdZlxO9ZlfX7jygs6KDTZe+ZuAYXebHE7AkuOrmMzpSeWsvqe6Wj1mLpnkEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZcnMuB+i2a62KNssdoxTbwcpzM5s6zTRX6VWgoh0ew=;
 b=Ppp8z/edjHtsf6szGJaT/wX1HVHmMDvnEE3w/no1+MRgoDqgAGd6FhDbTOANkYrSlDURKxAQQYT8KjPVydSDX5R+m2XxAnjqwuJ7QOl8/gMdBRax2U/EWBdXGCPXMBGlwF7mpU59lQwZHdpHWrMQu+DCjocIB2t2H0UltF4OgZu4sI4P2mdyVEoG0uivDzoMvrSgpdFGJePtc2pI6/ETVN3V3oW4Vs6lVG4XGPWi8TbmkY9hmDuJ5KcOLsCBww+qB4EMOIVoLH5FobGo2mWTL73hAozB4/RUG0tF3/IC7WtwgA8n2atPZi9SzuXNM8UnOEUuMzfAdDB+OUVxQsWGwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZcnMuB+i2a62KNssdoxTbwcpzM5s6zTRX6VWgoh0ew=;
 b=RuvGCzY25lFqIkuueqc4C5170k57qM3NuCq6y+QjGKz2PQzhZj43v1yUFCun02Umnc4232BJAyniriyBol9Nlovu77PtrCfEYolmOrsF0IymZrGL2+EHnTv5Q24n7stnDvgTQD9UCbx324aiWtWU4hZPguna/kz2Z4+LcldYmOY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AM4PR10MB9424.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6cc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 22:55:02 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 22:55:02 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 0/3] allow control DTB to double as "FIT image"
Date: Wed, 20 May 2026 00:54:55 +0200
Message-ID: <20260519225458.5587-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPAP307CA0003.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:3::7)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AM4PR10MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: e36d93a5-ef30-4680-be8d-08deb5f9a8e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|11063799006|56012099003|5023799004|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info: JFjdLyQ5t1JjErp7dEicgqq6h2ey2brCQYM212FK/7TIHLQH9fVPN/KJcP11/Li6xfOBv37IrEPcp57bf87QEglOkt6aIHJVoYLd6LAKvkQrPc+nCj1QV8dRjQKKrYwgFixSdI6/MdDVZTVufZWc5meb6fF+RKadGK6iJ77J3EucwTVAIS3252KfePpnrN9SWoA+yvhDa2YftfWbehO+EL32hCgwxnI5Z0Mta//QUq3iRxxK3p8ivUjKa5i5cnbqap0ED6Bz3CgLivdcPsZ0a6eJjOk+wsC1aBg015hrS70OsAPSlLTxbcNmN2In50ETInUxNOSAFrfXIhW8BAJF8MUMD0qd4ybjNd26QoOdX/gQaraXT/f28EuQh1DdyAJWgkrN3GnA+NE+oLb8jsudTpa3K9UMWL1Z1K6xFoI5OZGjnfajPJ3cLdG0XxteJk6x3Y9USsH3KH1rC03S5pZxwl7irbqp5YNn5uyWfke5la7ftBhr4Uolo0YdWq15d3VP02P+Nhiw/JzU1o6vLstnAqMfbEu8vyDlgWfEaPYBE+qn9vPiiJAFEJ61uoNZwA3zM1p/zkxiuzXLvw/W2drMn5h/e2s9u0zNGvZ+GrjNXSrLpsctHVn+fTHXXIzsvRxPgi67bevB1UueV8zrp+rr7895IYaABNTgsqc3hawpSyi3XrPtG9M1w8Uo3TsTOaCH3pXNPUdUwpuLjTnCNxDp44V1cLvCpLsUgIeVmERrpsXzS8BGzNoXsLu4eOUBFen2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(11063799006)(56012099003)(5023799004)(38350700014)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tHczQFPWJHoUipmX4OugNXYpFHxIeDAvwxusQuaxfi6UO0NHqPnnkGLEX6QN?=
 =?us-ascii?Q?FhFtX+WZ9JlTgrukDqDXqqK6X6cFxtQemztRtL9piCzrg/3Hh7boZx82u3fR?=
 =?us-ascii?Q?/IZfi+PGG9q1fXAQgJ9zcuRt4LrOLBLGPJ4lhycplH9j8ov6eTh2EHP8oW0+?=
 =?us-ascii?Q?2YSAGE8WlwH0IkItaA0ntq0AoCOOFceegO/Pa/ZmGqALVgQ68pqga7+YTk73?=
 =?us-ascii?Q?VH8lcLsa1/3SY1TxqHGlwmPrJe+ejj9LtFwh2HT9yVgGQbzp2LG5CodlsxQE?=
 =?us-ascii?Q?T1iTqMTK8ktJIFOZ+Bd3FWHeNBHqoLgQaQ4xThoOxBt11YDb64Ygqx0YU16F?=
 =?us-ascii?Q?cYO3QUUZcMGyF08tbMwm6vLQKxpEbP4yiH0X51MtcBTcYNOMeE2aaqfxx/cL?=
 =?us-ascii?Q?rAmZNx2o+km3JwTzTv/Gpj73T2RBi6o7NwTGiSrdOygYswrco9zL8SSONt9H?=
 =?us-ascii?Q?KSku5OUuFbuYejPA8wDnGrwg5H9E8mfWo8K0ApGuPSnHT3pAvEuvCTN2Mo/l?=
 =?us-ascii?Q?Gzcuq+5JLDQ8H3YTFJF0QGLRiHydehqSXTkFx1q+aZI4cp38u50oSX1AUTp3?=
 =?us-ascii?Q?H/zgKn+69fQ6DfLRh93Kz0GPiuFhQWwutaKm1XAKKtJCw2HnzpMSs2DY8Et6?=
 =?us-ascii?Q?og2e52sr3X/xci+pmt7RyRiaux5BGsjNZa6QQfIiIQ64eZrsOXM+Kf245+qE?=
 =?us-ascii?Q?afKPNGCiBLS2gYTnzFT+pFD09+9s5kb7Zj00Hi59CwEk+lS68Hq969RANGN1?=
 =?us-ascii?Q?ltpgF125yCxBZ+3HYtQKJLgJ/QcV5ANzjxfUP1VBb4lVnvdga7GNNCFrM9nc?=
 =?us-ascii?Q?l41UNkh9dQ8wn3POFuirwaRWnZSpu4fU19nGR0fVgG7uP+JhGKAC+XJ0l0U7?=
 =?us-ascii?Q?4XMD4iyMMj1FmZytaM++n5Qc/MZ5BMI/kDxvGeRWE+RaqEWLw3Syrl2LDOYY?=
 =?us-ascii?Q?lfSwvDuOtdwpuv9SJCNiIdzBsfSANYtoarBhEVZk1JBE0Id0j4M4f4zb2AyN?=
 =?us-ascii?Q?9ltn1zEDxDaBKcb/YJk4Wx1yg2a2ipePoe0VLGFKcebGoiDtiopz78C0LtBO?=
 =?us-ascii?Q?1rP0JPBYac9cr3gkPTk1F0JFvykNmmI117ZBG+NHoJDy0uczTEVRxnH+B3lP?=
 =?us-ascii?Q?rS15+dTh8fTyLPFUvb8xEQ4AHBVHLV2WsAalVu94vkL+MKWX4TivnVaGcMQ8?=
 =?us-ascii?Q?Q+7WzRDtIoyy6PTwWDTjvRCnal6NnaXQQaSvWewZuMKYI6sLY3HmHnS99hZP?=
 =?us-ascii?Q?g9vgWPo2laaV86I7YM8GgQa8ZS2o/jvrTgY+COlsxNSru2wY0L5eU75Fxdk9?=
 =?us-ascii?Q?NE4zUMjYoy3hdowf3Vvn4lWpVCm+C9irgNLHrHJ/MCpWW9E/kE8ZHefFdEV0?=
 =?us-ascii?Q?NQh27oDHpSPTBCESz4YAkubDWUKh+1SkCTumFNuEYoBPOK96JZo8fjAnxwEw?=
 =?us-ascii?Q?vGpE2OOaioHNe9lhxUrSIhjOuojJycX/MdWEmhA3exy6Z2ET8+iSrfav2uik?=
 =?us-ascii?Q?JWdrvVbzpkGaBeJbIQZL5yun6HVtzD2id18mA8bxN35nmIlhFS3wn7ExOqGD?=
 =?us-ascii?Q?BbtnRS3Q/MX/aVslrrAD1R7wthc6CSB/J5ttYyx/g/u5MHf+iYUQjMq4MFgs?=
 =?us-ascii?Q?uT+Z0xHyA5MM7V++P91IePG3t8U6FhGh1kGqVia02MoKqwgtL7KHWgcibRPp?=
 =?us-ascii?Q?EIB8iW+hJMvfwg9SUAzdpoWR6asXdneAcJDdesTcpgVmMBAzFy6uLG91MHkQ?=
 =?us-ascii?Q?m0I3zhoqCnkR5Ga65XI0xbmeD8y6VA0=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: e36d93a5-ef30-4680-be8d-08deb5f9a8e6
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 22:55:01.9597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E3wZ1hmHJv9QdvQkB6s7gKLlxgETdw0kiXlioPemRTUN+Ef10yWRMaS4W1hdwnNq1EryfelqijjUaBTWmdj8YGcdx9/uL2qb4IVKUaITuwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR10MB9424
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

The commit message for patch 1 explains what it is I'd like to be able
to do, but here's some more background:

For a long time, we've embedded the boot script in the U-Boot binary
by building a bootscript.itb, and using a .dtsi like

  / {
          config {
                 bootscript = /incbin/("/path/to/bootscript.itb");
          };
  };

which in turn is mentioned in CONFIG_DEVICE_TREE_INCLUDES, that
bootscript.itb FIT image has been embedded in U-Boot's control
dtb. Running that was then a matter of doing

  fdt addr ${fdtcontroladdr} && fdt get addr bsaddr /config bootscript && source ${bsaddr}

There are a couple of advantage of having the bootscript (and other
script logic) embedded in the U-Boot binary. First, there's no need to
figure out some separate partition to store the script in, and making
sure that gets updated whenever the bootloader itself does. Second,
one doesn't need to worry about verifying the script; whatever steps
one needs to take to implement secure boot for U-Boot itself will by
necessity also cover the control dtb (if nothing else then because
that's where the public key for the kernel verification lives). And
third, the boot script is automatically updated together with U-Boot
itself; and if U-Boot is stored in an eMMC boot partition, that update
is guaranteed to be atomic.

Now with the stricter requirements of libfdt starting from v2026.04,
the above command no longer worked, or only half the time, because the
embedded FIT image may not land on an 8-byte aligned address. So that
line had to be changed a little (line breaks added)

  fdt addr ${fdtcontroladdr}
    && fdt get addr bsaddr /config bootscript
    && fdt get size bssize /config bootscript
    && cp.b ${bsaddr} ${loadaddr} ${bssize}
    && source ${loadaddr}

which is getting quite unwieldy.

Then it struck me that one could perhaps simplify all of this quite a
lot: Cut out the intermediate bootscript.itb, just create a .dtsi
which directly puts a /images node inside the control dtb

/ {
  	images {
		default = "bootscript";
		bootscript {
			description = "Boot script";
			data = /incbin/("/path/to/bootscript.sh");
			type = "script";
			compression = "none";
		};
	};
};

and treat the control dtb itself as a FIT image; so the command to put
in $bootcmd becomes simply

  source ${fdtcontroladdr}:bootscript

and embedding other pieces of callable scripts is quite trivial.

And that almost works out-of-the-box, except for the fit_check_format() sanity check.

Introduce a CONFIG_ knob that allows one to opt out of those sanity
checks, for the special case of the address being checked being
identical to gd->fdt_blob.

Changes in v2:

- Guard this behind a CONFIG_ option

- Move the exemption logic into fit_check_format()

- Add a section to doc/develop/devicetree/control.rst describing this feature.

- Fix and improve the included tests.

CI was happy with v1, and is mostly through this v2:
https://github.com/u-boot/u-boot/pull/969

Rasmus Villemoes (3):
  image-fit.c: introduce CONTROL_DTB_AS_FIT config knob
  doc: develop: add section on embedding scripts inside control DTB
  test: hook up test of allowing control DTB to act as FIT image

 arch/sandbox/dts/sandbox-boot.sh      |  2 +
 arch/sandbox/dts/sandbox-inner.sh     |  4 ++
 arch/sandbox/dts/sandbox-outer.sh     |  4 ++
 arch/sandbox/dts/sandbox_scripts.dtsi | 24 +++++++++++
 boot/Kconfig                          |  9 +++++
 boot/image-fit.c                      |  5 +++
 configs/sandbox_defconfig             |  2 +
 doc/develop/devicetree/control.rst    | 58 +++++++++++++++++++++++++++
 test/py/tests/test_source.py          | 18 +++++++++
 9 files changed, 126 insertions(+)
 create mode 100644 arch/sandbox/dts/sandbox-boot.sh
 create mode 100644 arch/sandbox/dts/sandbox-inner.sh
 create mode 100644 arch/sandbox/dts/sandbox-outer.sh
 create mode 100644 arch/sandbox/dts/sandbox_scripts.dtsi

-- 
2.54.0

