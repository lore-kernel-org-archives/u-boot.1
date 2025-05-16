Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B394C3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 12:54:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C223F8006D;
	Fri, 16 May 2025 14:54:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="DlefdWj9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D8218059D; Fri, 16 May 2025 14:54:41 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::61f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E502480050
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 14:54:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUNvhI/qxP+DD6pCbbFYvRDqpgzZKq2BvZLagP8JwbU8/tRIprC4FKeGbG4+FWhDgKeuA0m0u+KPLKGsYyVZK37nfCOdShtxIIyrbqqGJ28j6/TBK4xsSFbYsB98ATGPWs6fOhsLTUHYTbrumo2MFgJw03Cp+cyLYjA+kM5bXfgNCdeS/ZqD9ft601f6dJNYR7wSnB+wx7ddu77m04crDX7eSvLeNnf6bvNHWxMreRvrxDgCdD18Q4ucNK2RDlP8wr3VL0mUxkMv6cSUaqsaikhPKsQ63B1CgepkBT/79LBrZvnHgN+KI2HbaF4PQUSoz6mZ5wt7z5wLD3/ezvj7Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dyp1pzB8XkodGSeIdmJV1YtuMD8dA6nFSbUfb1MHd6o=;
 b=lruQZN+43XGHmwBkCYV9ERROSGtZ0xYR1pBjol7fO1j5w8Y1PndyWHbKbENweE0hAuTy/oel+Tb0xNYS0K2C0S7QhMTqiKMz0KCCMOUYp+FTzhsrL6L79UhoLqshp1SnoBXSO+uQUzrkQ9/c5RXaFPZJ0UeXSgfBrZSHReONxdfW5uA/wC8J7VPA6kOUcYhypI2Pv8jSxKowMkOALKUsH09Lr/JKE0efQqLNCgiPyny/LYvFqcvIIOFGlYG1M+Msm8jA65lay4/sfuvUYLvrGxhN4Fe99pw6VhMTzrUj+CcuBDlEtC/i3/yZGHIBioluySzg0wppU1StFrENkC1+/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dyp1pzB8XkodGSeIdmJV1YtuMD8dA6nFSbUfb1MHd6o=;
 b=DlefdWj99ATvKwFBRT2azfXUTtzXEVMIFjYtx/fQNLI7zOXnJYdTa5NGYF1+rNsgiLhaqib2knKRDrt3ZKgtncMge8/IctTn6HDzDXKdjl5q8nq6McmL8FBvV3QMB+Th5BKhZn2xWTGY5Rl82ALKx1blj+2NLzRly90TShYA/9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS2PR10MB6973.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:57b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Fri, 16 May
 2025 12:54:35 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 12:54:35 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH] mkimage: do a rough estimate for the size needed for
 hashes/signatures
Date: Fri, 16 May 2025 14:54:30 +0200
Message-ID: <20250516125430.1361912-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0025.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::16) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS2PR10MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e6aad51-ddc2-4af6-0929-08dd9478cf3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vQbyS9fQFXLQRyQX9AzC19YezwBR+QZz7PbXzcqKPOf9HhNL5Rfn5V/1LAk2?=
 =?us-ascii?Q?Cc3ab3ESNrKY3sX/veAOsNCptezqYfFc0r39KjZcCa8c6gQFdugcURR+zmHv?=
 =?us-ascii?Q?rexEtH4KnOuD1TZr3Eo2V18P+yFndYPEMlIfT5ctw6ZelkX+nCAHClQ/cEUV?=
 =?us-ascii?Q?SZ0hu8U9VGZQTvkVZGBx2b9cd7RlsTHTWOCKGn25rFVLPtdmBOX63N3OTNac?=
 =?us-ascii?Q?RvlGAGfrHIrc4uiJFViVHHyGJvfIvXqtIaMy1v/QvkdYnhAgkkB9YOSd7uQw?=
 =?us-ascii?Q?+aOawWbqXmUNdnre16n7scfmryiL7pBdru2YEEWNMKU+541991g7GqX0E0P3?=
 =?us-ascii?Q?SpC18YI/03LsVGBTuxern0dvV4pRWTFZv8DIr0v9BSRs5iXOlYAkpmJ2IesA?=
 =?us-ascii?Q?Mpr82dlNUu25VQgghOB0CGw5ewOlVkN/NlG4OCs7aIfNA9DOVgPipA+RtS1r?=
 =?us-ascii?Q?/hlUq2zxTf+hE6nclHHFA9ZDN6JrkOnJ3ura9dcMuRM+LUa2Vc+Vxu8ad7xB?=
 =?us-ascii?Q?WDdq6VmOfhAxmvQBohN9qTx16JfZenzgeqBEAXbs6/GFpu8FNkFPTq0ye+NJ?=
 =?us-ascii?Q?TwuPsfwm6XwNOIGmH4JoxyN2GHWMM1aT68mwNFr+J86JFl4vf7SO/TuqPaZr?=
 =?us-ascii?Q?d9M4ChyyjFmCbtEmSy1zuAz0UTnp0lx2ZY1DFaUTw0OPynO5yObTULtDKcNO?=
 =?us-ascii?Q?eZxoDgtNir0HNxfnTqp9D5N1Oyx2pde3Ic3CdNBaabU6Km1pZmPVg8uVOuyL?=
 =?us-ascii?Q?RO92NHoApq1uF3r7+VRg1VhB6PDPnaOExPivMOzrYWh6COElDsuRs/9nMxBa?=
 =?us-ascii?Q?Jzv4gFmWg+G+m4p52w5XYQQBP50VGs8k9aSyMGuIG5AmwOoIKuxOTodOu0kR?=
 =?us-ascii?Q?c8yZyCfzUvD4nMv2xkuFvg+PXgDF0XLWgNaVoNW9Hk7nPh/v9OrcwIMNJ5ou?=
 =?us-ascii?Q?rsydCvkxZUSzlSV8M2iY68kY0VSg3YcLv2RmlYkTa9kb+J6sHq3/718n0mrK?=
 =?us-ascii?Q?5eugzLj8NCIcoxHn6px4MTf5Bjfkgkde3pdai9SA3kiE1W+YEpwLYej/siYG?=
 =?us-ascii?Q?002dwZQU5Bu+JBJlkLuL+znZXjrQIkQPB8VOxhb+R87YgsQnqQtIiJ4nM6RU?=
 =?us-ascii?Q?LFMnEOoTTiopgW0azfKMRQOMWt1lRJl2/EHscVsk4f7F0vQzKaGf/zsqnwhI?=
 =?us-ascii?Q?uFGz9gVXON2SlgDz6PXsx8hXbIsM7PB+/G9e9/KShvdaXoMDW2e50BGyTd7i?=
 =?us-ascii?Q?AytZdfQXfZfxwHtxkljpwwEtC5DKWGf1duwyJ621P1V3y8rplpnvOZFe1Ciu?=
 =?us-ascii?Q?Tb2RPE9cDSPsJeh9oi+rdyyJRnwZMdNa+FiSfOO11pnGu+6u964PjtH2qsEy?=
 =?us-ascii?Q?5a+mIIOWhVib4/8QeqrYg7DJ3s/UqOY2JUA44PdPrrhQdTfH4CKu9ff1jGfZ?=
 =?us-ascii?Q?JnZmueVNIEKeSS2IlAbUt5xhW99/5vBLMBtNKAuwsLPLs26ZNI+HSQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lowrr716undJpmk/uoODg+JE8fakaXVAa/l1iJr8HFtZBkwRWVaz6kjrzUHt?=
 =?us-ascii?Q?TfJTJRAtksK9NdIF880FIbkvtyP98TE/kwtj+AVu5JsAg2XZh2ZU0NzSyg9I?=
 =?us-ascii?Q?DJFgo7WtCpA+XQ40u6hHvDCzwIDHjLopO0aO4QvrhYVDzDT5JHFhr3zMf3l2?=
 =?us-ascii?Q?eDFT9bYuKmcqPZcyCS1pzPJF8FrRTa7uoH+06BfRM+e+DYRB1v7uUnlvfcoE?=
 =?us-ascii?Q?/lUOkke9hRvzW1sSAAi0O7aB48SDx4chTzOJ8ywzXmRaUk5V1tefzkGiVpRc?=
 =?us-ascii?Q?2YIIyVBImxVFydig2SoYeTExXpZaiAd9EMeoJ/LHvQDnNry+mi4lheXDk1aK?=
 =?us-ascii?Q?h1D1jmStANStkrjO6F3t/rpyx27Qw2CeyrgRyx0EebLE5VKU8aola0ZKM64Y?=
 =?us-ascii?Q?fg55I6oafS28Ahgah9xlKy9DYf7r82/KtJpzryzjH5/M0/wKcAO1XykcqGWx?=
 =?us-ascii?Q?S1qyham1aUphm3DA0rn0C7swTGFrDEuFk1vqA0B31d/5bFiOSSOH/udQRTRd?=
 =?us-ascii?Q?UFdXX2NCqQHLL8CDKLJFMc/L6en/uIec9ruglIQECT97hw9hEGmwEybitS8z?=
 =?us-ascii?Q?M+AhC40CA5mCTNEk1NNOUwfuLKQiw9HFYerC41I72jjalpXZEpnEvB8s+acY?=
 =?us-ascii?Q?AZCoF/FYtGBfZLoBt7iA29HtmoKFF8SGitw8gPPLeBW9Bu4LVr14AgYwRklA?=
 =?us-ascii?Q?oyFLZBl9zXXLWrVOTJZpslpm1LV2j4LE5i//0kUP6RxP6ibCZuhUyangcgMk?=
 =?us-ascii?Q?VyTH3vJV0UQwoPs8yq2awy8x61t/rr+Zz59fQAkdhPpp4fuTABfBUdNENeyt?=
 =?us-ascii?Q?LlodhJ/LpsM61ofrdF2akuc8ka1x2ovU3oiNhK2vVlQSKT02S2VbFFVN8MDL?=
 =?us-ascii?Q?A3oA8BovN680394lfbj4DLgDkr1nguGNPV0I27bs9xMD4VN+1QwNguPFgKeF?=
 =?us-ascii?Q?KcqfPC076+Tm+Z51kJmQHwL1kRFvFX7cfHxvmioJaNywFSXVGfKS6xnRxFqs?=
 =?us-ascii?Q?2d8y+qBHzhmhNH49x2bWl27D9rQdJz62ajy4fXz2c+9XgdvHZ8D4rurJuCp8?=
 =?us-ascii?Q?UbGbks/LbFM92DJRFmPc7erLFliEoPLFf9jzBDaSGoWgs0o9F4gPy9b7cMyr?=
 =?us-ascii?Q?Rsr3wKDcyO6It5YJq4rWaOBue0sDrI2DmxO3M5FXhLIXVgxBUIvHbQZy/bXY?=
 =?us-ascii?Q?awW4dK7OUFNu8rmFOjTXKJ1wQl4aV2hyITyXRKccu6NoeAo+kX5w813rvmNz?=
 =?us-ascii?Q?uTJSG7oeU/7eBqsH6OwRtDaqVLj8upqo/5xHBFVLjoXBZR+trNKuNyxSRxsl?=
 =?us-ascii?Q?BWd4VExZzcOClxUu+a+WZ6tDf7qBMFER9aZbiUd2+elveFnk0FseeTyNsYCu?=
 =?us-ascii?Q?JGcx7RLiwgWnltQc0txiHcjeadso6a1+X0hEy35gPXHF07rEgp4fYF0z/GTW?=
 =?us-ascii?Q?P7TowJNNEoY5OEqjkN0giUpD8uer5RL8zWHUlJxJFuBiYgtpEgFH+vOoPTjV?=
 =?us-ascii?Q?jvgDhoIbo/I2mxcwSCfxMDbNVUEnlBHeORHA+Ok/E7aNHPMwW4LTKC3duvyE?=
 =?us-ascii?Q?4kSGvB5A+sJOYs1N4asjhrP1AWCqKa/1CsGhl02zGNAPyHQ9aDiCfkMUyhAf?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6aad51-ddc2-4af6-0929-08dd9478cf3c
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 12:54:35.1780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 49dodRnwNSUCpEniijRCNO3d/7+/GaqJBL0qfdpkWcDmEpTFEzhGggUz7iVQOACm2MElX8gu0GtqkKve8aFa2aKF4sNVNiT9NmONuCq6hTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6973
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

Background:

I have several customers that will be using a certain remote signing
service for signing their images, in order that the private keys are
never exposed outside that company's secure servers. This is done via
a pkcs#11 interface that talks to the remote signing server, and all
of that works quite well.

However, the way this particular signing service works is that one
must upfront create a "signing session", where one indicates which
keys one will use and, importantly, how many times each key will (may)
be used. Then, depending on the keys requested and the customer's
configuration, one or more humans must authorize that signing session
So for example, if official release keys are to be used, maybe two
different people from upper management must authorize, while if
development keys are requested, the developer himself can authorize
the session.

Once authorized, the requester receives a token that must then be used
for signing via one of the keys associated to that session.

I have that integrated in Yocto in a way that when a CI starts a BSP
build, it automatically works out which keys will be needed (e.g. one
for signing U-Boot, another for signing a kernel FIT image) based on
bitbake metadata, requests an appropriate signing session, and the
appropriate people are then notified and can then look at the details
of that CI pipeline and confirm that it is legitimate.

The problem:

The way mkimage does FIT image signing means that the remote server
can be asked to perform a signature an unbounded number of times, or
at least a number of times that cannot be determined upfront. This
means that currently, I need to artificially say that a kernel key
will be used, say, 10 times, even when only a single FIT image with
just one configuration node is created.

Part of the security model is that once the number of signings using a
given key has been depleted, the authorization token becomes useless
even if somehow leaked from the CI - and _if_ it is leaked/compromised
and abused before the CI has gotten around to do its signings, the
build will then fail with a clear indication of the
compromise. Clearly, having to specify a "high enough" expected use
count is counter to that part of the security model, because it will
inevitably leave some allowed uses behind.

While not perfect, we can give a reasonable estimate of an upper bound
on the necessary extra size by simply counting the number of hash and
signature nodes in the FIT image.

As indicated in the comments, one could probably make it even more
precise, and if there would ever be signatures larger than 512 bytes,
probably one would have to do that. But this works well enough in
practice for now, and is in fact an improvement in the normal case:
Currently, starting with size_inc of 0 is guaranteed to fail, so we
always enter the loop at least twice, even when not doing any signing
but merely filling hash values.

Just in case I've missed anything, keep the loop incrementing 1024
bytes at a time, and also, in case the estimate turns out to be over
64K, ensure that we do at least one attempt by changing to a do-while
loop.

With a little debug printf, creating a FIT image with three
configuration nodes previously resulted in

  Trying size_inc=0
  Trying size_inc=1024
  Trying size_inc=2048
  Trying size_inc=3072
  Succeeded at size_inc=3072

and dumping info from the signing session (where I've artifically
asked for 10 uses of the kernel key) shows

      "keyid": "kernel-dev-20250218",
      "usagecount": 9,
      "maxusagecount": 10

corresponding to 1+2+3+3 signatures requested (so while the loop count
is roughly linear in the number of config nodes, the number of
signings is quadratic).

With this, I instead get

  Trying size_inc=3456
  Succeeded at size_inc=3456

and the expected

      "keyid": "kernel-dev-20250218",
      "usagecount": 3,
      "maxusagecount": 10

thus allowing me to set maxusagecount correctly.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 tools/fit_image.c | 80 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 70 insertions(+), 10 deletions(-)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index caed8d5f901..65c83e0b950 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -24,6 +24,65 @@
 
 static struct legacy_img_hdr header;
 
+static int fit_estimate_hash_sig_size(struct image_tool_params *params, const char *fname)
+{
+	bool signing = IMAGE_ENABLE_SIGN && (params->keydir || params->keyfile);
+	struct stat sbuf;
+	void *fdt;
+	int fd;
+	int estimate = 0;
+	int depth, noffset;
+	const char *name;
+
+	fd = mmap_fdt(params->cmdname, fname, 0, &fdt, &sbuf, false, true);
+	if (fd < 0)
+		return -EIO;
+
+	/*
+	 * Walk the FIT image, looking for nodes named hash* and
+	 * signature*. Since the interesting nodes are subnodes of an
+	 * image or configuration node, we are only interested in
+	 * those at depth exactly 3.
+	 *
+	 * The estimate for a hash node is based on a sha512 digest
+	 * being 64 bytes, with another 64 bytes added to account for
+	 * fdt structure overhead (the tags and the name of the
+	 * "value" property).
+	 *
+	 * The estimate for a signature node is based on an rsa4096
+	 * signature being 512 bytes, with another 512 bytes to
+	 * account for fdt overhead and the various other properties
+	 * (hashed-nodes etc.) that will also be filled in.
+	 *
+	 * One could try to be more precise in the estimates by
+	 * looking at the "algo" property and, in the case of
+	 * configuration signatures, the sign-images property. Also,
+	 * when signing an already created FIT image, the hash nodes
+	 * already have properly sized value properties, so one could
+	 * also take pre-existence of "value" properties in hash nodes
+	 * into account. But this rather simple approach should work
+	 * well enough in practice.
+	 */
+	for (depth = 0, noffset = fdt_next_node(fdt, 0, &depth);
+	     noffset >= 0 && depth > 0;
+	     noffset = fdt_next_node(fdt, noffset, &depth)) {
+		if (depth != 3)
+			continue;
+
+		name = fdt_get_name(fdt, noffset, NULL);
+		if (!strncmp(name, FIT_HASH_NODENAME, strlen(FIT_HASH_NODENAME)))
+			estimate += 128;
+
+		if (signing && !strncmp(name, FIT_SIG_NODENAME, strlen(FIT_SIG_NODENAME)))
+			estimate += 1024;
+	}
+
+	munmap(fdt, sbuf.st_size);
+	close(fd);
+
+	return estimate;
+}
+
 static int fit_add_file_data(struct image_tool_params *params, size_t size_inc,
 			     const char *tmpfile)
 {
@@ -806,16 +865,16 @@ static int fit_handle_file(struct image_tool_params *params)
 	rename(tmpfile, bakfile);
 
 	/*
-	 * Set hashes for images in the blob. Unfortunately we may need more
-	 * space in either FDT, so keep trying until we succeed.
-	 *
-	 * Note: this is pretty inefficient for signing, since we must
-	 * calculate the signature every time. It would be better to calculate
-	 * all the data and then store it in a separate step. However, this
-	 * would be considerably more complex to implement. Generally a few
-	 * steps of this loop is enough to sign with several keys.
+	 * Set hashes for images in the blob and compute
+	 * signatures. We do an attempt at estimating the expected
+	 * extra size, but just in case that is not sufficient, keep
+	 * trying adding 1K, with a reasonable upper bound of 64K
+	 * total, until we succeed.
 	 */
-	for (size_inc = 0; size_inc < 64 * 1024; size_inc += 1024) {
+	size_inc = fit_estimate_hash_sig_size(params, bakfile);
+	if (size_inc < 0)
+		goto err_system;
+	do {
 		if (copyfile(bakfile, tmpfile) < 0) {
 			printf("Can't copy %s to %s\n", bakfile, tmpfile);
 			ret = -EIO;
@@ -824,7 +883,8 @@ static int fit_handle_file(struct image_tool_params *params)
 		ret = fit_add_file_data(params, size_inc, tmpfile);
 		if (!ret || ret != -ENOSPC)
 			break;
-	}
+		size_inc += 1024;
+	} while (size_inc < 64 * 1024);
 
 	if (ret) {
 		fprintf(stderr, "%s Can't add hashes to FIT blob: %d\n",
-- 
2.49.0

