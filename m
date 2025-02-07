Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759F0C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 10:31:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1E9F80207;
	Fri,  7 Feb 2025 11:31:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="HCMUPx+9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACC4C80737; Fri,  7 Feb 2025 11:31:16 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E180801BE
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 11:31:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ifabOairxRIPIYapZB5JLSJlur/0k0ZfY70+elhRLJ/Yi6bl+NI33isc20WzU7Re7LQk/iU6qLvWqogSLbdJbqdtvgOtAiPdHVi+KPMA1dCBizfudfy5JrgMgtwjweXqZQ3IufJPIDP7vPTDlTBhrueuGrie75/PdpCKhxI4LXIcwiybp5OGNa4FaEHq+98bO9Nd3QOALvEBhjx5dOjmK2bz8K8WSKWqIA1dhiOBz+o7uQ/6MymCH+c9GJTQ82ZdpSD670NANcyKWFuTA/cEZqhNd+sXvE9n1RQ30dGo1vcd/8zPWmN//8sXzWxmDh1aE2FBMQzfpgbGQG2n7GKhXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGF9hhVVjzdJ8+KtdUm6djkE6z2OUrDgouSwIKWSPds=;
 b=TMJEtKfn2T8+HnWk8rTNFDSZsjqyBCkPU7bEoW48ywLNrcGlxu2HaJvTvj3KOfJ7o5ZNVS2hj3DBGSzCgP5wbhPwIKlts5M4D6H/d2dE92pjES3EzZ1CEP1NM5dBy+Kdkk2GpiENquuqnNoH52td8KdSXH3KaaKCgvOekyVfsPpLZevM3nC6wXt1FpVZR1Ax1NUJG5svEjXHbW+x3fE0bCcPSFZviQ+ZmPahQjkUkZ+f8oxBKPycRJtMaC6l2D61lYGwU/hD1eomiq3osv1MQaioP+2lh/VOVktl7h8V2C4YTFZ0wipawBZC/wfl2u20FE0a9wEuJUwa0ZazcIBkCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGF9hhVVjzdJ8+KtdUm6djkE6z2OUrDgouSwIKWSPds=;
 b=HCMUPx+9TSmVp8XvfkqcyIcny9E54X8mArWJDX785baQwRMVFWVXAGQD7SxuM8WXNMYoa/RRfeICl+A1cjbgAeYA+ZtXPSryjAnnVJcC3uUeBUP41Jr0NWLaELbihAxwI+EEoNj2a3qwr3GLyOvKeR1BN/FAxrYUsjXnJ6c+2IM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by DU4PR10MB9072.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.6; Fri, 7 Feb
 2025 10:31:09 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8422.005; Fri, 7 Feb 2025
 10:31:09 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de,  Joe Hershberger <joe.hershberger@ni.com>,  Tom
 Rini <trini@konsulko.com>
Subject: Re: [PATCH] tools: mkenvimage: Add pure shell implementation of
 mkenvimage
In-Reply-To: <20250205143641.65430-1-marex@denx.de> (Marek Vasut's message of
 "Wed, 5 Feb 2025 15:35:52 +0100")
References: <20250205143641.65430-1-marex@denx.de>
Date: Fri, 07 Feb 2025 11:31:07 +0100
Message-ID: <877c62rqqc.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0085.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::7)
 To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|DU4PR10MB9072:EE_
X-MS-Office365-Filtering-Correlation-Id: cf83cc77-6063-421b-0908-08dd47628952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|366016|376014|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/FqwNFf2UwHkgTxE7F3T1gvnKAwApV4LvnRHeCDCCTRT9/f0VgF+4/Lvx9t4?=
 =?us-ascii?Q?EYLsWSVHVkpusUqNj9SWWgxeHWGXvbxAF3SSOljZsLBB8k7uEmBdyuqqOqmJ?=
 =?us-ascii?Q?OutgDeECTfR9YcR+Tu7W2ChQ55ekKGg6LQE6PnwkCU0hVqPSu28cmoAzyrEF?=
 =?us-ascii?Q?YrYvprUw4d7zg37UWmlUM+0IEpqGvdnzMEPaSaMFnLdB5SMx7AzKPRlWGYoY?=
 =?us-ascii?Q?GNqGwQkYrq7bexr9XAkCEnaUVINXskXjbekymp95acoSnSfrprBp2YBMPkDd?=
 =?us-ascii?Q?JAJ52rHZpPkmPctGLKT4P4tnu1l778Qv6Wzt0aZRex6WusD7Vi3WS1Aw+Bpc?=
 =?us-ascii?Q?fAMBzq7aS2V5ODTlGr6nMQdqgB9ObAl6qZ0L6GXoeFukfcrC08uhvwsSY7aG?=
 =?us-ascii?Q?zOcWav5PER2ipFxB3QIwROFYfbiZcMx9G7XP9R1k1k393fxFRzOB+EKN9SAt?=
 =?us-ascii?Q?et/TZP7nVidaWtK7QTINW85CpLXOGSaqgAtSAbLNO3+/9RvTw7oFRacSZ+St?=
 =?us-ascii?Q?UoKPImDWLNz+eoAJf6nRTOjqceJsuswi/ABhJBx6+TdMt/Lt8jbe3aJ+YWxt?=
 =?us-ascii?Q?KIwfOKQv+rDDyTn/2idFVTSoABk25dX4G2pTNr2A2waMcVvPqANGJpo6x6Kv?=
 =?us-ascii?Q?sAiOu0vNLFfRZjM3lODBpQ4C3pRSuoyGByTBtz3myrFkSSaZfjRfZNuBh90V?=
 =?us-ascii?Q?h1amvYYmB5g8uqoLkY2SPU7mOInsn3zRjqxAC5KjqXGI4Q3swy/VlJXAqivI?=
 =?us-ascii?Q?IQ8pMXVMnzxGVX28ad+S0lah0E5qvHmyqxHM/uqsOL1k+VKlJYO0rK0Qfu6H?=
 =?us-ascii?Q?mCxkHxNuXyITZ4XdOb9HXwIN+rXF0HiIXPvYVKvVfzCsimpYsth8GJDrScEX?=
 =?us-ascii?Q?qnRR/NOGI+AZfXh8bFwtgNZI2P2O78cSAR/jNl9EKx7ybWPXDB6/OXQ2VisQ?=
 =?us-ascii?Q?sCKI4YPoOCkuGhZwV+OXvZgwiQ3YVqv6eHBFCUlKob78OkxpU4JNhqHI4ZfU?=
 =?us-ascii?Q?/hf3skRTy6doJiq9L+dZJUUBJuhFg9nl9NMvIhV8wj85ApXorLCnWwREcrqz?=
 =?us-ascii?Q?zGMpam4l/fhaj0BihtOP8jSkxAPBn103Wl4zRlfnJXNZvUNyAx5TxdHYwXtL?=
 =?us-ascii?Q?OFD4/7w34eVpZbpz6AZfgWNP9mIVH1fGD5ZPHr55q3/8Qpedpf+A7+VwLbSs?=
 =?us-ascii?Q?CCQTGVf/Qmkz/T28G/Vg+tiyROMTWPInJD3sSFBGh1dWTJE0FpMyng2gN55j?=
 =?us-ascii?Q?3VcKsMlF0hL2PKuFn0hjeCpfra08mHpJC5HbZ26qPUTnvXclOnbJqxw4bUTi?=
 =?us-ascii?Q?fL9bPd6hBKY8HF5bLreRaFArPZUeP7uIJj6kzJwTyu3xMuEdcHRvmQVPtIoZ?=
 =?us-ascii?Q?s2upwj3ou5A6Lp6rl8lr7VV+v9J/jxdk6sz9ppIjTuR8pbEZVU7pYSMKF2BF?=
 =?us-ascii?Q?Wy3wftnEqQNDb+Vfr8n7zoxfo7VJ2eMi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(366016)(376014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MhtvlrO7Ue/27q3k6EXL1tiv8HmCv6afKI/V+RWyBCQf6KFySX4AFomlZ4nH?=
 =?us-ascii?Q?AI2QINLuMmziOH2QFGT+HmhOR5Rk7J4ccq37WdHcpicveC7CHqWHaCWPu6lh?=
 =?us-ascii?Q?UA7o20SUB9muPgGm3UckR930y2Dp1zhmS3fUjSEVGWmWJefzjyK/SzY9gHNi?=
 =?us-ascii?Q?GsBLpbv3vCZjZwB/7VTbe1ZLNEN4cmc3sf8DM5ozPfGc+lbfTboZfhKyEFoW?=
 =?us-ascii?Q?cPv6LJk+4jUhDQQ/nIGtsHe4LWUJSrIWsTCWhl62D1Y2NRIrhBYR+Gx0Kyo0?=
 =?us-ascii?Q?LKaPsaDDXUAx8bYBlWf5528pRScqXsAw5zGvuTZjrVOyELdEnyojE6Ld7c1p?=
 =?us-ascii?Q?NzZ5Le4slJn/wdyhokrI3iVN4Vrk/LVg+811IsMjwRuugEcgI7Dlp/GCKdXE?=
 =?us-ascii?Q?msWiy50xTVKS073nYxBffPiNze1HD/5iciS5oWlCZ6F9nyPn/pTJIK6ltdO1?=
 =?us-ascii?Q?ToiAbNqQpjMyaXr/7kdX0OsJG58NymbaY8j51PJou4r9Nm8Zk8BoAvKN8Ibm?=
 =?us-ascii?Q?K83dfPko43vBhsp8OpoWHSzXyda8HtGsC0t5HwHeuZEWiLiK3ukHFoC9vIFs?=
 =?us-ascii?Q?KUnW7xnJBkivFXeSPQo+l7YlNAyFToLqcbsmY91PLcJSnWG8CVQ9El/WM1Mg?=
 =?us-ascii?Q?zt5i/gNYq39oFqf99i1pKJ3prmMfJFa2WMrTkAI+9Merec8AgJEhTGmPIUbi?=
 =?us-ascii?Q?5Trv7fx+4AdihWDXIN6TUgL9+42FfhXLdhf6RGZnGur2GM0ZGln2DTY5cYi7?=
 =?us-ascii?Q?WnhYGJiF9o6dWmMnHdQJ7/CKrDU6DCXFU5fRCgtpFm5xxtwT5T7lKCfylpFp?=
 =?us-ascii?Q?kfc/Nq2tszQX4+PACvLGOz2ilLpl1C53AhHDitYVUY5CxaFPIAAnsMOaY3EG?=
 =?us-ascii?Q?6/kTy4CZwGE8HLlISp0N1DDPjhPMzx9EkbAQAib6h6n7KzmDmFsGAN52r7NB?=
 =?us-ascii?Q?c/CR2jQ5r7W78Pk+aWPWz7wN4GjIm7SAf5tbI8x2ZrhoGXySFbuM1Md1JYzC?=
 =?us-ascii?Q?Y6UI3frjbcKgf0ksvJcwDC/vZtykOAggvJ4HVUWBSQGlV1AptkS7Fd6DlC16?=
 =?us-ascii?Q?vK62bZmH/xJRJ1ufZM0skHK4WrJ+d/i/MoJmkNqOsitdj1rxsvnUGiAvrgll?=
 =?us-ascii?Q?1CjvmhN41CiX+2HwkJt/Xxwjo/tNhnMJUMTy1lmG3rAVCBgq+e3MtLAiCWkJ?=
 =?us-ascii?Q?Tz/kzDTN1KbFeU7RvuPGdu+ncs9sCkNbc95eGn+XYLVeMHdaTjvNKvvZPXwn?=
 =?us-ascii?Q?rSvXdJlhMyifQOJ8fcB09VbGxw6gxkjPc91G/4oEZMAo2cJzQXsXbBJMxW8w?=
 =?us-ascii?Q?zJBdkYEh1N5OetnOvNpXrm7mgUvXljQTWjFr0kpGuydyepkYmDFZFEhXbbVv?=
 =?us-ascii?Q?TSt62iUQw1NHjx9jLJkEjBsfPl0y/W9Tg5jVOyzrEavKsWYwCwfIxXSi8cux?=
 =?us-ascii?Q?83guuX2JJZjgMSwYMbwy0rNGO1Wd/RdNWyLP5aCWrzoMPwMciKc4qt9hQ/i1?=
 =?us-ascii?Q?ET1+fU7SbYFdKNcVgyG0BBKT8SiYkiSllqO7naDkhHUbhE9yTRCBNKzDRalD?=
 =?us-ascii?Q?HtQ6ma+YDesrYWGp9sLQczZchrEn3sSPLRdg8a0ccRfx/kl+qr4YkFJm3QDe?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: cf83cc77-6063-421b-0908-08dd47628952
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 10:31:09.4295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: keXMElfyuAL0cbWsdeo2JzL954ZNfRBQc3dcDwYcEnZOyvyMmeGUE9oZ7qewSAuqAADcnFK4MdPN2QR8ZT6pcfydzI6ILKyFy7zh1HALHBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9072
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

On Wed, Feb 05 2025, Marek Vasut <marex@denx.de> wrote:

> Add implementation of mkenvimage written purely in bourne shell.
>
> This is not a replacement for mkenvimage tool, but rather a simple
> implementation which can be used in environments where mkenvimage
> itself cannot be deployed due to various constraints, like hardware
> manufacturing plants, but where bourne shell and basic tool are
> already available.
>
> The external dependencies which are not shell built-ins are gzip
> and grep.
>

Eh, and cat, sort, dd, tr, mktemp, head, tail, mv and rm ?

> All mkenvimage parameters are implemented and compatible with the
> C implementation of mkenvimage.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Joe Hershberger <joe.hershberger@ni.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  tools/mkenvimage.sh | 126 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 126 insertions(+)
>  create mode 100755 tools/mkenvimage.sh
>
> diff --git a/tools/mkenvimage.sh b/tools/mkenvimage.sh
> new file mode 100755
> index 00000000000..f83fac92e5d
> --- /dev/null
> +++ b/tools/mkenvimage.sh
> @@ -0,0 +1,126 @@
> +#!/bin/sh
> +
> +print_help() {
> +	echo "mkenvimage [-h] [-V] [-r] [-b] [-p <byte>] -s <environment partition size> -o <output> <input file>"

Nit: you included a .sh extension in the filename, probably this output
should reflect that.

> +
> +(
> +# Read input environment file, make sure there is a trailing newline,
> +# sort the result and remove empty and commented out lines.
> +( cat "${INFILE}" ; echo ) | sort -u "${INFILE}" | grep -v '^#' | grep -v '^[ \t]*$' | tr '\n' '\0'

Doesn't sort ignore stdin when given file(s) via argv? Also, the newline
added by that echo would probably by removed by the grep, and you
manually insert a \0 right after, so probably the first cat;echo should
just be removed.

I'm also wondering why you even do that sort; AFAIK, mkenvimage doesn't
do that. And it would make a difference if the input fx had two
definitions for the same variable

foo=Y
foo=X

because when loaded on target, the last occurring value takes
precedence.

Are you handling escaping of newlines, in order to allow values to
contain newline characters?

Rasmus
