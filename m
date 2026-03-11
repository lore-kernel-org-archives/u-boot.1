Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4F9106286D
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 12:01:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A891183F53;
	Wed, 11 Mar 2026 13:01:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="igiuEEFW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A419B83F6D; Wed, 11 Mar 2026 13:01:29 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27C1D83F2E
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 13:01:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VmMmBD0tbzNaIfRC51npzxkPES6ejZVM9lnTfOeB/1L7dNAoSKF2zHXdqZCYSajrtwSdBaKUdrCUJI/j4JdgCKIH0uLHqVicbB8AjA8pxkmfvJrodbEqtebYQrqFgvOVSj3p2ozQj2TQwLUAP3/OeMV06O0RVR7EBJQ5P8zlFkjD93E/9yLkflocjNFO9zmKLsGx07inFvik3n2RcDZuWf5rwltQstn5ngxpGK9vC9XhIpP4mEB/MBiMCGDn6j8kMw/2AlEFE9GL+RIk3ZwfNpfJvg566/AD9gUXaU04bPVtd9wvoLOHBQP6UmCv7jpKY9ZxDO6MafVCzNhXmPL1MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UobuyKh3sTWhNN0iFVAiDbxWC24k2Kn74utLfpr2qFo=;
 b=XHNDb6OkolbBwxm7wJXXjitbGedOxBXVsrtm0pwtWIYW6vOqOSLWF7mJ7T1mS+BR4bHrSwOV+WWD5z80v7uaS6xHLstQy3UWcLoFKUkonaf0H3zzrqYUY83KnEnkjNle45fWU5kAFStQ9uFNqsg/6XGyKudzqPtgRzAnF72FwgRam9GFio9TKBPtOs8z8IEKx4hZTo7wGDQmx5CCziUcu7XLE0Z3LUQ5b1BO5JFcLZoFKPrmswytl8YS+SThp8s+HjEKCjiPYG5lBOqouJEgd30WYeyDYHLQ1uA2RTQlEUnGNeQRUZL838cAvFhkmfwlUg5Xeav0V6PmUS+vaQp2Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UobuyKh3sTWhNN0iFVAiDbxWC24k2Kn74utLfpr2qFo=;
 b=igiuEEFWsbyrzkGzQQ2y90T0YquEZGGcDzVZCPFHAe+CXrGPM0f/f4iEbNb8J7xWOppSk8hIZubyc/Wq9aGAVjgQBBEM00YffPoonza5t/pdwO2q3TEsIWgZr5t4GTLlKshpcr5QQkgPMwQlyQIfbO9VyMRtMlGsla9rZFXwHXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS8PR10MB7799.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:629::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 12:01:22 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 12:01:22 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Francis Laniel <francis.laniel@amarulasolutions.com>, Harald Seiler
 <hws@denx.de>, Tom Rini <trini@konsulko.com>
Subject: command negation in modern hush parser
Date: Wed, 11 Mar 2026 13:01:19 +0100
Message-ID: <878qbyr2wg.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0012.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:1::7)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS8PR10MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: f16aea1c-ad18-4610-a9c3-08de7f65e907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: gJCO+JLdbMbZJq1ymya27Mrn+T1XwCzB3N5mUM/I14lp9TPDW9RS91e2KYXqlF4gUdaNjikMIukWR4qqtU4aErcS1fGt9zhFO7r0sjvIZ516bqxaoTlCErkFfF1CtMKojnSlky0yccWaDevpLmrSh96Z14T0+22nsD53ChAgFjz00pZ+aNdeG5L9c5CJ5mvBDZFhtBuBQNsfTElOhI3htTzw2z6wmHq597K3yBrbgcGH+GuaDQw79Q8DRXx1m4hN3+2ec447OO+e+kx2OBe1rRB+OhC8QhXRE/Ief2WBNODMyos4Lb7frt7I5N51hgE+pAemS71Kzm3hhkmnQ+lMwqeXL+Y5SUkiTnoS/sK7VJW4wBF+xCq1zGpVUTJQYerkE43iX+JXp8PBo0HC7y6wO/UjsGZwQWAbS12ogBv4Sf2S7e818zdvj7aIQnLHRTDsxEf28bqYwmpbnxVO5vnb7FajawNObI8OWdU/gy1BHfeaoV2JKurQGlh74yRU63QSEpLNaYQjongrZiNLouhvQQ8IaoJkTF0uBYhxZRJQY3IK/OYBRkNS6g3vLKEndfKZzoCsLYvD8vXo3sPpptqx7UbV4sbd3kDdfPkqFTn/U8T8snky/KImGsiUZw2m2yz/kE57t4sp6LZbdtLyoLzKsvy05Gsx18V9etPngshP7XKJHGBVjn2wtj7N/tOq3IyU3D+bjNminjPDqMwNn6CUepJs+nAVBWlU8LvEX9JiK6+aKrtvY2tfLlOsdX5UMLSKHL4MlYFmO5SSVjHpNuJR5ysxGni0oOWVDH6DfTTUXBw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(18002099003)(56012099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DoZBDax9CeyjelkJJPhskQ+VjYKfQGqhR5mB6BKI88s7T9e8BflcMxZP9gJZ?=
 =?us-ascii?Q?TGtm9HwTVv5E0SK+VS/v9y1UHYHt8V23hNHIigZ4INm6dAYWqrcwJOovq92c?=
 =?us-ascii?Q?ZzL2KyI7ShrN5z2FcpzahFYi8uxDKKcDFoUDSjmxYsxvCTa0abAzp3V3a09X?=
 =?us-ascii?Q?4U56MOYm+TQBmsh5/bH7kHotzNtQz6E3bKnj001ALEumtqksifyGQlqzbU3N?=
 =?us-ascii?Q?aihWf0Bcj+2tYEIHX4QFIGvqfahTLft5kkzjOnxEwvgX50YMgn6qPJNtBQ+X?=
 =?us-ascii?Q?QpbyxFgWvIeipU42JG9HJLa/LMAgqs/FuLKvy5Biu47TK7o4bh6cLVk/jnba?=
 =?us-ascii?Q?hfcguCPK5l2/iByBco3YEJcPIaKB2EB8Xt9ZpK/zXJHR73MeRlyqeajEKIEi?=
 =?us-ascii?Q?y7EvVe9Jbcy5+FPmTJ59xSWhKSinMXHjl9T25U3OoScW4IkXfEX9oBaLzt4J?=
 =?us-ascii?Q?UluHCiyXfVY/hN+B764OoLCoe+ZI2+nsWnpXeQl1VxOv+figIR9Ho5EMMblH?=
 =?us-ascii?Q?k31Y7dgIB1X9WliuKaDVW4A6KgAgBd80z2Rd6NO/AqavYgGqaTrjKvyFMKbk?=
 =?us-ascii?Q?FtaD/pLaFUdVNUErFeyNZ9UIYSAkrMjaxhXh0UGmOBOoqAhfEreGiS8J7ryD?=
 =?us-ascii?Q?bfILNy2M8LflfPlmg5NfpEnycouD/OddjZCB9bBFS3VGYts8e/c5xJIEwoYO?=
 =?us-ascii?Q?OctSlfomsupUwlISlqj5XAfL0QtF195q+HNWlnhzX307XM7Bq3ImjpjckXj/?=
 =?us-ascii?Q?wIULmkMuqVGUkriPq7XMSGOWnpdkpHtW7D8FBpiWoddPGbeG9q4doStjGof1?=
 =?us-ascii?Q?mOV1Kt3sN+S/1tBZvoEHpkD6DXYeFa/JRU5oBHCGH2P1EmlBomK8XQZ/Vkhi?=
 =?us-ascii?Q?MtsN4GEJoLrh06FLYPm023UO98ahRsIlBrTONt5mgqhj/7KbjsgigBbABneY?=
 =?us-ascii?Q?vlGGrjpQ9AKATtaCrmLuATieiYPfD/DxdjIgoOet2f2Z7fehgbWB1o4jy/Dq?=
 =?us-ascii?Q?0QFGdipp7jsHyIU4tBjdGlbf+drvkqxhQtOSnoPcSMylrwomnkKsAbJPvDLP?=
 =?us-ascii?Q?6TUj0JC7avLLo3iWGIfkWkqp7PPv9/WfOW1fIs9u+WV8mOS/wNa6AdCt69ZR?=
 =?us-ascii?Q?Y2NH6VPbMEOgSwZuRLd9hANKCEo8dJnveUkF85Olr2xAf00Aoq6a7U5v4Ygo?=
 =?us-ascii?Q?KGauFN2DgdWTK1YFO+eaJjM0uQ5LrLBNuXeC7H2zG/8cSsnpKMFalf9o72Y5?=
 =?us-ascii?Q?5DrL23l83LCJMeTwwD15XVdUWVCP887VE0bGmyz+mfgTKb3yHbotovcOvWhB?=
 =?us-ascii?Q?WJzXeyWHW6gAazQ8RglpF1pzr+3dfdY2/M5svKDhiiiquEO1J/traQXa9mNA?=
 =?us-ascii?Q?tcMNTrgasbvssJp7jvJu2hGMAYOBKcxtpKaGkOfw5ArnwamG/5z1AewsRhsz?=
 =?us-ascii?Q?+H4wC244maIWXXl+frfVwpde0xJq4ETIW7dG3uSIM9sIOeleNtH71ZUIgQVz?=
 =?us-ascii?Q?JLpFE+9OxK4V6yVHbUdCUXhPU17yGyedn8Bs3eYdw7avZTRMEJ8XV1815k/P?=
 =?us-ascii?Q?Yodfpm5VqJOBWhhWhLvwg71E+59elmb9iAJ5mA+Cly1kBSLfJUPueV4kOMEI?=
 =?us-ascii?Q?t8GyYxFzeYI+xmIQYTpdHvXuqIn+LosODEH084EhSo6GluDJU2md1d329l+z?=
 =?us-ascii?Q?7nbs0RBRLKxvfYtem/fnuzYQYtdiP9eCJreKWtD9z/6d5g3QvTZevpL1UpCT?=
 =?us-ascii?Q?34RcnIjB13o3q+k9aCFnx3FViqcxWfo=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: f16aea1c-ad18-4610-a9c3-08de7f65e907
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 12:01:21.4303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjstNLNqjoLsy6c4MdY2PxdbjipNLj2KKdDMFgFXAlzQ36yXWfwcmO+C3HhzUBut4rrEgdcKoMwDwvu64NvBSW9AJeiH7PQp5NwtJEzLeqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7799
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

Hi

Today, I was bitten by u-boot shell not supporting the negating
operator, as in

  if ! some_command args ... ; then ... ; fi

So at first I thought about implementing a simple '!' command which,
similar to the the 'time' command, would just run the rest of the
arguments, but then negate the return code.

But then I looked at the modern hush parser code, which did seem to have
support for that in the shell itself. At least the "! command ..." gets
parsed, and there is code for rejecting "! ! command" which does seem to
be active, but unfortunately, the "! command" form doesn't actually work
as expected:

=> cli set modern

=> ! false
=> echo $?
1
=> ! true
=> echo $?
0
=> if ! false ; then echo "This should be printed" ; fi
=> if ! true ; then echo "This should _not_ be printed" ; fi
This should _not_ be printed
=> if ! echo "echoing always succeeds, so... " ; then echo "this should _not_ be printed" ; fi
echoing always succeeds, so... 
this should _not_ be printed
=> version
U-Boot 2026.04-rc3-00079-gb008b86fd180-dirty (Mar 11 2026 - 12:44:08 +0100)

gcc (GCC) 15.2.1 20260209
GNU ld (GNU Binutils) 2.46

I don't really grok the whole parser code, but just injecting a simple
printf at the start of done_pipe, it seems that that gets called twice
for each command, and the flag indicating inversion gets reset on the
first call, after which it doesn't affect the actual return code of the
command:

=> ! echo hi
done_pipe entered, followup 0, ctx->inverted = 1
done_pipe entered, followup 0, ctx->inverted = 0
hi

Any ideas?

Rasmus
