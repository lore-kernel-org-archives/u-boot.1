Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B01C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 07:16:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EF6582C96;
	Mon, 26 May 2025 09:16:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="r+vb9elD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CE4482CA6; Mon, 26 May 2025 09:16:08 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEA7B82B7C
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 09:16:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iefuFlx/KB/aCa0+wk2UcTctfDn9QArRoLLdS32/h+wEk40fj1OE04+NhQHB29nonJC0NbMciFEn0h46YLKbbcYKeUDV7UQiZkiFUpA9e6DvbOivJk6RGYkx4j8SltJJ6G6fHhBY29YX+oQ/2axQ+AOrV64ulpTkh7hXxpSBfuUMDglIWNLpOtaVSr0JnG5D4Eu5+0/FWRS+GHDqzOCPzauJt9Izu9tWLxbOx0YVLE94IvOJNT5snS+kMcHqUzNcf9sQ9LNC2OyZ9LR88IL6SqTVb9Es4rsQVh8XFcEelKiwB3+HfmiXz2iDdRlRZqRAXjbKxGU3gtsIDdHr831XSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cU+JQ5FjVGLFIUkTib1g+oRJD7kac0lEkJ0SU3sq/s=;
 b=DcoFclL0tPrxot2gRW4amw+S+4Wb66aCgpa217fHl8VScdnKE7fcBLajaMp9NnvDaBHNnkzGzGkdHrkxuVfoT6Y1C5COBXO8g/vbkhpDAFn1yUXQwAQCucBRJe1NAHk21cTfR4dxC57BIja1Qo1ARxZg+WjDqEzxqt4HKl2sxdeTQGwoiuWYG9ho7DyslKJLZc35ZDR5zy3ZId1lOzKyR2iMRvxBSE71yOaUFAVQVfvh2N7blS0PXcLPANy0XDnui9GQF5fxY2X0hDZON/AE/9YPgOWdvcRuPcawaDq/TV0DvPlSfEApJCWaVDfIM+e6clmLlS8O3wL3G1RzAJ7Fdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cU+JQ5FjVGLFIUkTib1g+oRJD7kac0lEkJ0SU3sq/s=;
 b=r+vb9elD4O0dmKK+1Gl0Nbgz5wg839sZxK0pKf009/c1n/PSErQf7FFxHs4d0ZXzom9FjOhItUYniBQ9M1zqSIfSCYgCnhA53XN4JobIFdvK2HIQFh/vhXG3QnQ8S2161NRKsjLW6nwcp1HmG8VFfXd1bMl9B9WpBXI4wkwKf/3GC/gsCJch37JqoLu69wOiOvusl6pPTUWt8ewPpSN0FuYfySnp1OyG6xTXZvjSNpAQQDUr4D854WR/LTI+4XioRFWld6mdxz9hScevMXXoc8KgV64eL2MBK5SxXJILxqXkwBZevJisv0s+8FMkDegj5917srYFsrFXuOXUmZ/qCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10674.eurprd04.prod.outlook.com (2603:10a6:102:483::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 26 May
 2025 07:16:04 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 07:16:04 +0000
Date: Mon, 26 May 2025 16:25:50 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Adam Ford <aford173@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/4] clk: imx: add i.MX6UL clk driver
Message-ID: <20250526082550.GP19264@nxa18884-linux>
References: <20250525122316.661999-1-michael@amarulasolutions.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250525122316.661999-1-michael@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:195::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10674:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ede4b12-bc16-4471-f5b7-08dd9c252d4c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FTZSfuKr9smafLte1ycXsz+N+4TcJkgl3mHSnjjzS8krRtWMHvfpnkN+nKFR?=
 =?us-ascii?Q?kktjZw8OHJPffafBbMCqPVfQ+2GBwiFPHMt1MGuXvufI36k+JZ7PyTipVMEl?=
 =?us-ascii?Q?H5sDZRuXDY57VvO5Fl1rr5Fcert6WA7JkXDj4MVMjAB7ED3s1dMBap/+fe5n?=
 =?us-ascii?Q?IyikMDyqbOiA0qx/ou7hofPXxeO+BxIhnIqx/FUo7sUlMTZWrRN8mPNN2muD?=
 =?us-ascii?Q?7tIG1+ZXiXI2kNo/QgpfDzNkBp/juEkd/0VdoPlEIX0flO9hIQBak7UWdN+V?=
 =?us-ascii?Q?A62+hUx5LPpO+/+bI1dSYY9rLnQBeN0zECzEHnJUmJ0BEhrh4+gHuowhOIK1?=
 =?us-ascii?Q?qxVy5MXVATfMg1iYgNjraiqFkCzXUDz4cl3wfPoCjRYD9zPtNU7OTFYLLiIh?=
 =?us-ascii?Q?8z8lUItL3sWpjNl4pEvQd3k0rWgw0E039X9ZBYXf8xAMzvlDalQa3GZLzACL?=
 =?us-ascii?Q?lcGd+kV8FwPsTCM8NY8MpJEp0niUNe27cBC+kE5qv5zQ6Wv4PEB9YDFInInf?=
 =?us-ascii?Q?P73nT57r4XfIeMkeJzimDRR08WBHv+4+uYzul4xcyp4HaBjeuEFD1E+Mf+Sk?=
 =?us-ascii?Q?zEvhJk7VBnycNQXXMYPAzBTJ3bPw5S2BLNgadZd3NqHKgqPbKRjdQ5yEW8Q3?=
 =?us-ascii?Q?nujKc/s+QGzzdx3Zo4tmrmpSqxMca0wpAMiEH026zoceyB+lKu9NjuOMalgm?=
 =?us-ascii?Q?gnvGTGCj9HDe8pPgGpepp/+saQH6rwCpSrMltyplYtcsXw0a+5KxXyjtzznf?=
 =?us-ascii?Q?WmOjv6FmurD+s0zN93p3munEB21iL2JGcQRg89Yo68l06c0jdf5lg1pPXBeP?=
 =?us-ascii?Q?7yMyQd7zPGmUWqLyZPE9D2SGX9cZKbrqbf4yv1Cmr7eyTN3p+97QP3PmH8Mv?=
 =?us-ascii?Q?RZYdF7eQG0thGbPf+rXcb5vSfFfU6F/NdXvH0kfuwtQw3GEs3nzAecO7sZjk?=
 =?us-ascii?Q?BQZsMFwIgAazzQFO9UJfcgD1rx6I2doIWZvB3Jwgs9tY8hLOqnmhRnOABDtJ?=
 =?us-ascii?Q?Ov7Qr/8D9O5k4RbhsnoAiSABfXziJ70XnPVCe2udrfMAunR5tcCtglP62lBK?=
 =?us-ascii?Q?JjdYj8K9ZUR3JliosredWbEcZaADZLL3HiFvYt55AONMhHcKMnbze4mo20F0?=
 =?us-ascii?Q?DLnvlToml6ajVrpk6qaVJSC5iqYYv8jjbiC1BEQf6xL4sRQKWv8JBxBbjFoV?=
 =?us-ascii?Q?lIfwKCO8cRPykBPDeQ1Ae33b94maZMdW0A8goOi3WajDNqBomHtD7ZuCNwCM?=
 =?us-ascii?Q?01NLNSICGorh2FNaNwu7bFvd1LPWm61eTDLgzWOrEMWGh10xRS7+3riQlzo6?=
 =?us-ascii?Q?NwT0gg1KZooYMqvNlc6f95AYir2cWgjMf3QyaAOFXa3GlNtjMdacSGte7aJD?=
 =?us-ascii?Q?vtQRL1IjvNiscWVglhuEOzTeRdWQD5/f+KqM/2jsXLqJPsLleO/yXH/W6YBv?=
 =?us-ascii?Q?BqI++boqNjsQG4oUlEDh55X7/yCC6T6BVOF/pQAaOWLl5FOMEmypPg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b5SpbisChVGEiHguDgKsUn0Gcbtx+b8yBAaJMLgNe3qLSEM7+sRrNMLayrAV?=
 =?us-ascii?Q?HXLac70kF2kx3bYlk4iIX/J5Ry8/TL7FnSk/MXxiUa5v3mxYRA1IYZqJnX2v?=
 =?us-ascii?Q?cL5v1kfoZrSoV+M/MMHvZNU8PR3tsqr5UEHh0Ltn/7yCp9HygrrJDgcbVtWW?=
 =?us-ascii?Q?lxjjNc12LEYRJBThI/+8CxEW/YZPj8bhX1xo/7miDPgVjDmZjAxHVSMDXAiu?=
 =?us-ascii?Q?vHAnerk2loey5V9uS+vZFEyZKZTWzGG8ekwz2dolTe9Mn6EvHWqQUV8tMuN8?=
 =?us-ascii?Q?aS6U+pMJy/q+q6bY+oa+KLyGWNjvUlJRsgt1rldwR3qN1lYdrHyW2gteUgDn?=
 =?us-ascii?Q?hqi9SXmwnAliBp5sEiEmf/NbYfrAXsTmhkR8joj/7fIGjbYvlSAm/DmY/ee1?=
 =?us-ascii?Q?pU6/I0GLUXcGcMfiUJFvB5jOB/TMPW8gEqqe0Lw+mf5XklssoGrcnXDySaYl?=
 =?us-ascii?Q?LP0GY1Xu1+4YHMw6VoHclOsHP8Jzqaekls0ZMwy/js/go+YYQDhqcl8BV3wH?=
 =?us-ascii?Q?FR0myHybB0slwOK8IxM06dddZHjP3lgQM1t7L9plgRRftdYYu6MjY3LpJ102?=
 =?us-ascii?Q?0Oe7iu0YXldd5lPgpLogMM+Q5gfLQSjx9aFmTul4qbDIbGX24HE+udI5Zmtz?=
 =?us-ascii?Q?3wR7Rr9JBIoQ3ul6rgBZphFm8/BBS641d8cocqlMALz5T3sy8G/mA6xal9ih?=
 =?us-ascii?Q?lTkRv8yP+o0naXfYTZZBIP918WGVAAjP5k1xCF23d2KWlHfXRsssXNthZQOu?=
 =?us-ascii?Q?Zxr+fHuzaCCQ554OpGis+AOtPC3mmLpgHOu4x4qcbM9eQYlJZ4JSqoZ6lhKf?=
 =?us-ascii?Q?bBIM4YCIplbVPX0x2JA4gdi31n7jP3vPT/z6OPRYK/YGs/jaxfc0KcR83f2o?=
 =?us-ascii?Q?IQ1esEhN6RWyHsHmvDhMVOGCTpyNuGf/ULXdMMmjraCBA1Zcx4DrL0+bQmF+?=
 =?us-ascii?Q?4ROy3zE4/FjjjX8L5osbinGRnuo0FqC+JBWdIt7dRWhcfhgXGCWXQZGF3vJ5?=
 =?us-ascii?Q?P/d2BQM3wOIu6ly0tlJIm0A5vA7AyCm/bPwR09NbHoo/k0UJMfqW9yV75cNC?=
 =?us-ascii?Q?nq4Qy6nrUxSTopHn2p1pvoTaaejrZE8Q9sbjBQ0YwPpO3hFvvncZ83ymg8KK?=
 =?us-ascii?Q?2enPJFAYThrSHjH5XYj5rRYD0w/5GHTB8Ji28vBoh/Bi7l2b4snJ3A76xUef?=
 =?us-ascii?Q?AM6ITZ0nEhOhyLPGT59ra15CBNG9Ltk0ZnuPBpMYuhLgvz5urBlkmyPbjqfd?=
 =?us-ascii?Q?0XRG0Na02jGfy0OYg1EcAkYa+n3OuXhBPYnR+Ww5D+PIXQo6XhXVxtS4Nexf?=
 =?us-ascii?Q?khiFs7510wI002trzkKgeAAGEdIpk7XobXeoa6ICxDKyN3PL3MxVTQLdPP+L?=
 =?us-ascii?Q?e6GbXNz6nuhN5Ku+j/o0NypKrDm796/nxQ15R0CepdvHkhecvGOIqvIRzHa7?=
 =?us-ascii?Q?e+u9Uc/+LmiMml8JqEyMkhDe4Gj7UjrNwK4lRXWc0vpz64kj92UlnrTpnS7j?=
 =?us-ascii?Q?RAPv7BDcaCQ9yKTONYC9zpjBApihXPhVFquklie7IACCkEN2fjfn06hxU0It?=
 =?us-ascii?Q?Y3R8fISHLGe/QgQzKpWv6Ys2rhlXuzShJ/xxfVQF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ede4b12-bc16-4471-f5b7-08dd9c252d4c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 07:16:04.5458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86iAaW37g9SNIfyrTyc7Vv/LNRdLtq+vLeFbg5jQxgMyBEYZYJ/WhvdjjLM3211oJwBJv/WYDbPJG/9uFarXDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10674
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

On Sun, May 25, 2025 at 02:23:09PM +0200, Michael Trimarchi wrote:
>Add i.MX6UL clk driver for i.MX6UL CLK driver model usage
>
>Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
