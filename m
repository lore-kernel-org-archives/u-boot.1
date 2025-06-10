Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB003C5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 12:28:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B22A80E9A;
	Tue, 10 Jun 2025 14:28:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="b81zrVxk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0AA582AC4; Tue, 10 Jun 2025 14:28:07 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E4388070C
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 14:28:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CcDrSd/PzJknZqc2ekOYLXLRcQpdSTM/PvYn9+I+T2lWRCQ7Ux3m+AqVpRyORlQUj66uR2M2usC+XyijWC35WjDwlI9dnC4XzWu32bYTD97NE//d9NWYbiQVina+C4Gf2EsqxGxlpfhAbgp5+NPr3V27cEHh/hkEylC5AE/qf4t3IQ2k8+eAn4NwHtlZnjc/wbotMBLUoVx4rbTvlufNEn2xrMbb5WcVI4CElcbunpeMSbg0z0xDBrNmrbRKmSY+T00VTSIf80qmQ4+k4TPZEmuaZMUluQPvl2+rQxLs3hWyUmBX0XZtFkvQC7zaYAtmfcST/XVlDNWGGGP6ARcVow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhQgtVElrLwAfMbu+QuLloQSvth25lxsuEfDuDsI73E=;
 b=SvkOrvjph4coMJVUeV4skk4K8VA7Mh7Cc+DSF+pw+cWZHTLUJ02Ue2oJXt1JFe4Qd+bM7+1+MXvKDkSxXXa3da2R9MjVbZk2M56UfQU49Ihazc2y+ZvhEtD0vddOxFmQr6wam4vtt2eEOJ+0I+eJ8qU1Mz4G70HzTdt5NgLHAi2dBUPpSv0+NUbQrxzdkI1KcYgkawkW15u+wll+dbaScR+UC9+mmVlIqTH3QSMh66pzpobwWsvjOBgsv+im/ya4OZ4+wf4EUAoPUJZxLXEljeI1rrYlSFHeCPPqbjN56ncO6dAgbWVl5IOyuZRhNxZEoP1J9ZwTJOmB/dNr/7q2cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhQgtVElrLwAfMbu+QuLloQSvth25lxsuEfDuDsI73E=;
 b=b81zrVxkg92dMdIPPT56Q/gU1fIHnDNJMpqmWtbL4aJbcrTCvKR0NLPtQLGiNNHxrvMV4I27milTDONOF2XcxqUn29gRstqs1z0VeUpBUJa4um7CFOV7x6+Iktm/018Ws07nJrC+Y5jCB00d+Eejsp9NneP/s+/mrF0YUe4ITTA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by VI1PR10MB3502.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.27; Tue, 10 Jun
 2025 12:27:58 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8769.025; Tue, 10 Jun 2025
 12:27:57 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2] mkimage: do a rough estimate for the size needed for
 hashes/signatures
Date: Tue, 10 Jun 2025 14:27:48 +0200
Message-ID: <20250610122748.2756616-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0055.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::18) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|VI1PR10MB3502:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d8d0534-bf00-4e1a-d0b7-08dda81a3af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|376014|10070799003|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2PtuiumUmxY935eG5q+EkSyCZ2fAu05Z4BA8YwW9MiI5PTMeVjUEjIaXw7w5?=
 =?us-ascii?Q?Arh4bawq/9MC58UYBruoW1jvObdOlO9drXDO2sTvtCQ8/+0C81OFNms7nK+c?=
 =?us-ascii?Q?k8QPBJUtiPasEKlTh9nczmnr9Sht8n+yfdlyV28Y8SbImTvfH+MA4QQuovCa?=
 =?us-ascii?Q?A4P9QCXX+HqpVRlIZEmoOpNJ59P5pT7TYIExqtXVmHlk3rcn2f4AgII6ZfOI?=
 =?us-ascii?Q?4/eL/66r5bVdjD1u7PEWL9WAPffygiFbH6yIgxE/rLUMnDP3ro7WdCRVwVvB?=
 =?us-ascii?Q?JiYiwFlaTxTnXs0JIoobXVuiPfkAyER/XHRTllVzKTaYbaX7NyjMVmqHaLuO?=
 =?us-ascii?Q?U27s6mcQ8fKxVv72iDlSqXyrOYqeGo3X+fev2GGBi8h5sUvgE3C70zCSmuJs?=
 =?us-ascii?Q?kbMc8QMWbP4xRewl5H3hHPS8FOOwruY9/EX761F0A9PfB38L0etFdL302zen?=
 =?us-ascii?Q?AOGi7polDa8hkLf8CbP+imMtZxiTOPIzcacyJPWShO7Pazv5yVF85VxUWhb9?=
 =?us-ascii?Q?n+egPJ+RaCgudseb4SizrMBFBAH3hx4YCzD+qGWV1142mtNoA5hZGqIKWvP5?=
 =?us-ascii?Q?sxrl1YhrLNDoacuGNnpbwnRZe9ZU42bZgDoDeJKaff4ALSPbsnN9676JeZts?=
 =?us-ascii?Q?xU1zRf4mix4t97yPRcXx8QPl5u8SieKdOoyflE1fOJQwVSg+Fa8YNiqZ+iID?=
 =?us-ascii?Q?V1yWxPGv0guo+qc2uUKXuZMa6chCDfXBk+Zzm3A8D9gYE+8CVw+mv1624lYG?=
 =?us-ascii?Q?j3KwPgV3pVB4brMqxQxwxBJ3Ln5d/8uCLNPzfvMvlojcYcsAzJEG35kBjKkd?=
 =?us-ascii?Q?DEY7xxPRK9N84qskPSG0EQns0UWhm38UUUkWSalTOo4UuC+IDXAm/pY2PRLB?=
 =?us-ascii?Q?bOcvuF2GJ88iXz2scmd5DQNehzR5sL9+4TrDcWFL1iOhJ96uBgyx50VdqzcN?=
 =?us-ascii?Q?ZFpth2u+jC7yoWqQMGQzg6z4ECOXiFX8/ePc1QuoY8kpcLlSaB/L6hTjq6w+?=
 =?us-ascii?Q?iAd6pr+t0KL7FQwjKm/rzPofyxY2j0fpjxDa8f6mjRVxFgpSFdlo44TtXvCM?=
 =?us-ascii?Q?H6jYres5BW7fBOaEHuynMYBIPU8QvPjR4GyiNlW36dheLgbZjgxccCqiNqUM?=
 =?us-ascii?Q?usY1rnDESd7Llv/AwkAxWU7kS38YETlCbcXZJfvfi6gGpgY14EvHbs4ORAxq?=
 =?us-ascii?Q?DvP25B149JkUsDSjUyc39NNWOwfdaRegM9QMwRjYju6MjFZTHpjPbS2VeZGB?=
 =?us-ascii?Q?HXyn8VBxykY2TadYCzVeyDCsrr6xiWo3xy8JZ9tjQ4VWT40uraLSlKDDjNk3?=
 =?us-ascii?Q?7Up69PSeCJPCkFhAKKeeBZjFwdLh8+9zsEEAp7kJnWgeK9WnRNedJOdk4H2I?=
 =?us-ascii?Q?65+v1vDgMMsXxxp7QIZJhdxt31kkCtbGKAppTPL3X2vbr02ts7Y6GlYVwhHG?=
 =?us-ascii?Q?MrQK5Yczgwc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(376014)(10070799003)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gZyMK3IofjC+NozpxLr8e8I+O9zBsCa8UKG09thwUCUk8ONVBevYyCQlT4Z3?=
 =?us-ascii?Q?QVbbMqAlfcOiYaHjxokMT27+KUQJtiWxDqn6ovUOyEtfngYlQN0Yb5ORI30y?=
 =?us-ascii?Q?NJQZs9Dlf81+2fQHkP/Td67Z7IR5Akr/ca2IPZpnVVx4e37Mg5443kNDQY4k?=
 =?us-ascii?Q?+3xHVRf5Lrny0oUE1IINW6GXLq5WTH/C3IfkwbTRi8Ht+J3o4i4WeS9zCSFi?=
 =?us-ascii?Q?a4FndaAdPy4l+2OsfUkZs8CDPUtbtXjmxgO8Tkg5aX4X/QNdRFRBwVGeLkdu?=
 =?us-ascii?Q?ZHzAITxaWt725N1BtmhYPy14YvJ6VmN6KU8+33/iak3EB/IV0lFqvLtzg3h4?=
 =?us-ascii?Q?AbhAPgVogATRAPu+KI4MpCfdlGDjJZj68odG551YiRBeH3ikok+QQbMuRmru?=
 =?us-ascii?Q?CoxCI6kd8ImZZq81h/GJ4/J8nyNQoybV51ZIiw5o2qsTCOlCQdEbRm3y/uep?=
 =?us-ascii?Q?9k7kps89pIo+sjUvphPb4zlzUJJfl86FlPJmBrwhYwv0HrRobI8XkuSsju1k?=
 =?us-ascii?Q?HUVFK41Z21ridF1PC7tOwKjwA+9JFK+k1hhOdHFbE7vz+qshHmJuoPsXLUBY?=
 =?us-ascii?Q?SmvyUQfRQ3nPwqMKpoQsFlQeMlwo0AYp/0Yl1QA7dFxIygxxIPw712tJppaj?=
 =?us-ascii?Q?ewI8Tqr9tC/DOHRsNBA0n2Xwcl0ohhdsLzOrceUA655hqRkSxiVzjSh8L12f?=
 =?us-ascii?Q?fpwo8Ekm8grcgG3KmFmhEW9HJnzFQtYo4y6pa3g72QnydiFIZ45AoiTdc4rv?=
 =?us-ascii?Q?+lnSDknPPmykhqbvmjck7XlMuOljGZGrvevSpTzu7Fe4S99KE7ng9XMUJytO?=
 =?us-ascii?Q?h6pZvFJLzQVsnYJ3IA1NasYLsG5SxCxVqEpJ/NTtTpsQahqi4NR55RtIJJyz?=
 =?us-ascii?Q?vwuUlaHjrmPtaO4TRy7Yba8lMQyTkRpdht8c+Joeo8m8KNshTLU2cHsR2Xf0?=
 =?us-ascii?Q?ytjSik8X699scFhq0T99K+p1UiZEavGtBgIv/5/F2nzFbzp3gh8I1QAmQA/W?=
 =?us-ascii?Q?hFGArUmTpyt6rVXOigy8eMZXKzTOMhuqL6gI10pOJBQ9lcq3asHujjFfOVQs?=
 =?us-ascii?Q?xVgA66IKcQmwnlB82TUtKpSbf/wmtvico5tKTtbx7rP2tkb2607hjIDpmgzF?=
 =?us-ascii?Q?wWwBSiwifBcCVgHxm1QQuzPiAwjOWE1Yrd1x3PamHz+7BwKzLPN6aM0byE3t?=
 =?us-ascii?Q?waiWQ1Wit35H8CpPzmjJ8oViiyEtp1hWb8mrmzwIVVOQ+miZ7N+AYqefoaJU?=
 =?us-ascii?Q?VKcIk3V/qv6jo8OSgHG026QbwuQCnIpaRFvMUingEot/bVOo6W0wuAtck5MM?=
 =?us-ascii?Q?rDO0uL83Ha3z4jkKshVh8z+tevx41sYY9pKfNVJJRXYHesedtPr+2Spsde2y?=
 =?us-ascii?Q?buV7QmOc3d5PxVDnWY+Ff1ZQdh1TU83XLF90nnHDCMfOMi3LhQnNr+6r1Wkb?=
 =?us-ascii?Q?aS4hZYtfHMdadgBGLfMZT0GfsQTCmxfVnm2YXwufaxkRKS5dhFWcxBtXklDx?=
 =?us-ascii?Q?ePlbqDlTFXb4Rc6hPXYjGTwqcASnRa8EHhWeIySmfy2Y5zybOr/BZRup6Nnj?=
 =?us-ascii?Q?L436vfPO0h7baLkOR7nzqf+ao1QU6iH/OOfZ3TAfTN1eXffrlEP7Qj6bF5GW?=
 =?us-ascii?Q?UxiD6Q+ojMsdLLsJL5wbUzyUmiGnWr7bzQpvxjk9BxAc4pxlOL+MYBhusqDU?=
 =?us-ascii?Q?bLXktw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8d0534-bf00-4e1a-d0b7-08dda81a3af1
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 12:27:57.1458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzzv7Lw/qvWIALtipHDNO+EF4FQdhmnlAO+zReVGBrtfy22DW+qFYL0yrtXqp66zNgpYiEnVF2a2d5hMDY6720yyIGdeaqPUtrrxxf9233w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3502
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

Update a binman test case accordingly: With the previous behaviour,
mkimage would try size_inc=0 and then size_inc=1024 and then
succeed. With this patch, we first try, and succeed, with 4*128=512
due to the four hash nodes (and no signature nodes) in 161_fit.dts, so
the image ends up 512 bytes smaller.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
v2: Update the binman test case.

v1: https://lore.kernel.org/u-boot/20250516125430.1361912-1-ravi@prevas.dk/

 tools/binman/ftest.py |  8 ++---
 tools/fit_image.c     | 80 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 74 insertions(+), 14 deletions(-)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index fa174900014..d5ab4de2152 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -4013,7 +4013,7 @@ class TestFunctional(unittest.TestCase):
         self.assertEqual({
             'image-pos': 0,
             'offset': 0,
-            'size': 1890,
+            'size': 1378,
 
             'u-boot:image-pos': 0,
             'u-boot:offset': 0,
@@ -4021,7 +4021,7 @@ class TestFunctional(unittest.TestCase):
 
             'fit:image-pos': 4,
             'fit:offset': 4,
-            'fit:size': 1840,
+            'fit:size': 1328,
 
             'fit/images/kernel:image-pos': 304,
             'fit/images/kernel:offset': 300,
@@ -4039,8 +4039,8 @@ class TestFunctional(unittest.TestCase):
             'fit/images/fdt-1/u-boot-spl-dtb:offset': 0,
             'fit/images/fdt-1/u-boot-spl-dtb:size': 6,
 
-            'u-boot-nodtb:image-pos': 1844,
-            'u-boot-nodtb:offset': 1844,
+            'u-boot-nodtb:image-pos': 1332,
+            'u-boot-nodtb:offset': 1332,
             'u-boot-nodtb:size': 46,
         }, props)
 
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

