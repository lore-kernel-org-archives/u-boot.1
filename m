Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC6FD29DE8
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 08:42:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A74C836C8;
	Tue, 13 Jan 2026 09:42:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gixHFWnU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8738836A3; Tue, 13 Jan 2026 08:44:05 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E263D83642
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 08:44:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cw/H2qdgkm3UnCv0DS3CmwpfNwUtveGHYggYaR0kXDEotI3cG7ynajn7ltbEmKlrz3X9ypQKdjC5iSXQ0yI+KsCZ5ii1ku5yCeNL4/tcXXqyaomJ1d1r3E0yqvLoLX4O96yOtfkkyJCNZnKw1C/LkMXe5Me8VBQ+pL9uXOvHYwoLS4I+vXUWP7SdrHKkeAo9UnsHeoPXzfmPgLSWoUH93fD4vn24dX/k6MwNleUnGx4J8Fsk4oIJ/Mk29elQ9PV8WNt3FZOasKbhVYGTDovi9O38v7lqLYOE6topHtk4gHxLSElbUeWdD4bcAnf6nELnOowsCHhfCry0aQmNwhr9hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoDLVuswoj4JkQM21U/fzkEv4l1aGZaKcsTDuXU45EA=;
 b=FLrFAG4G2Yx38f9OKkH6RZSma0+FhGRmky0XaP3vBKcP2hIXzR0VFUK6rhw8Lwu3Z0P8NSZwMEB1J1G2D3URnIcXyyF+nL0U9qz/0VRajWLwnW8xLvFKxlaP60kN/ugKV1xCKz/urD4ejBr2lRIcuB4AmwdOCq5pwUBmBZFTHK4dAhnjQJnXX5nH58UlNcOoZtyH04NOliMM09pk5kUUFaovkxcfxNNwLqbuUh7tMjvkIXi7GLyY6HFnXzJ9OzlKh1JhLk1GaAnjXJPZbxOpFMDd/71Xc75EJkNvYYE8kCEZrwFZd/v2gQ0I8TLCXXSrzZ1v2kpmW5Wtr+po7k5P6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoDLVuswoj4JkQM21U/fzkEv4l1aGZaKcsTDuXU45EA=;
 b=gixHFWnUuF7WVKctVJfNNHoerbEUK5qa4mYU7wAgR2JaCMDMBK84XR1O0YuIq6JPLKd9SjxMP/Rr8YxE1MxTZX+y3LQEXLjA1jU3fuZ0ayTsQ7aQ8BeHSbrDZVvQdOXd0E0s7rgbJ30Ni/3yw9laUghx8wmNVuiecYN2qzafKUnNe5pDyDZ+e73beknJp4AipXnMlBgr5kDaPG0d14jmzj0vZmVhIUqnP/5p6npK4gjPoZqmj9VaDbq2sTuERXOpdyNxYaR1+DdWKde1zCirM9fuTOgOrf9JUPAtA/NAfEJN01LNdK0FwdT72m1x+LzoefAlrbrOUUSCl6bcYE3JVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by AS8PR04MB8708.eurprd04.prod.outlook.com (2603:10a6:20b:42b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 07:44:02 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 07:44:01 +0000
Date: Tue, 13 Jan 2026 16:58:18 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Michael Trimarchi <michael@amarulasolutions.com>, Joy Zou <joy.zou@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 u-boot@lists.denx.de, linux-amarula@amarulasolutions.com
Subject: Re: [PATCH V2 0/2] power: regulator: pfuze100: Fix voltage
 calculation and support high-range
Message-ID: <aWYJKl90YEvhVZMV@nxa18884-linux.ap.freescale.net>
References: <20260111082347.1302003-1-michael@amarulasolutions.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111082347.1302003-1-michael@amarulasolutions.com>
X-ClientProxiedBy: SG2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:3:18::15) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|AS8PR04MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a4f8d77-d0b2-44a3-fa01-08de527784c3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VkBB/fNMnE+JFvu867C157C0nCQhDO0GBhujPebiPMvqo232gB4UjcnYjTbc?=
 =?us-ascii?Q?v5jqEqNf1Y2rfpc6MfuuFx71vh17bnL8RKu9GsrjpPqF9ySK7kaKWoUXvIj8?=
 =?us-ascii?Q?alSwvlhVU+uNxTbXsF8h0oRH1YsJc5LI0vFGf1B94AWa3jzQ8lr24gTMKUmg?=
 =?us-ascii?Q?m3iYwvKEbqbnWEN9Dx9KfFTCNLQV24Y1AVeMiYdHYv8y3RSUMFFRqhSD/KAv?=
 =?us-ascii?Q?2UeuCfUaOu3NVMfurmhRJ/VxZrNtf9QVSg6RyLfKKu7iLSlhN7Xw119FwVel?=
 =?us-ascii?Q?odw4hD2qRLTqYWXNeUF65qcoyt5FtlliI4alh8vi3o+XUyazsOzg99T9noJr?=
 =?us-ascii?Q?Vf6iTDpBdSd5fSw3ayrzee1brENtSNZ/PkBRoQNyQ8G1kDIz5KuVCwU0xozY?=
 =?us-ascii?Q?4wWzr4VWsJFbKdpMfORfN2p4illiPvoTCh/t4HekajQy9//S+zfIY3EZ2TmQ?=
 =?us-ascii?Q?EJqUe3pJPub0DrQBdZ3/kFwxncsXYxG4tLnUhHPQkQtn3dRf7p/aoUcpiPYd?=
 =?us-ascii?Q?2uq25bQGWx8um+864Vy9PaZqmJDjTUZRgnfiWaH8u4XpDWE7m0IafqfPWXAw?=
 =?us-ascii?Q?VbvQ5bDImCzRoFQl229FTSj13Gr6GmqZ+oBwPhG+Ak6hkylNkvBIFwrCQQjQ?=
 =?us-ascii?Q?v5C6SPUtYz4FhbmIJeQjmDeoNsqWppXNkT/NYn9gO6KddD9AESDNpYF7AENg?=
 =?us-ascii?Q?eYmw7/Hxs25sLRMO6sYSyvD3K/krs4nJEWGh7rmd0r9rCLc1KPoGDUAfbNPD?=
 =?us-ascii?Q?zN92iKp/NqzNEpSsttp8K6T2Z+7H/k5VBvQ45NaNv+nu/4h57avl6GfwYFpT?=
 =?us-ascii?Q?ZyajVKyQoUxKTbfwDqsQWbTyx9iJdlAB4qpIQmvLx4fgZ67LiNEXNUL+pFFT?=
 =?us-ascii?Q?CijqtU7W4tltgjVuJ/FujRTNHCIWTu5OMIYu4epofvyKZCNky/Qbfs2dNyIu?=
 =?us-ascii?Q?h9fitpOqDLE31Yql5ZJ+xI/flRJqg25ZK/kEwBd8c1DYQ2GpUZ8GVbx7CuWp?=
 =?us-ascii?Q?7RtItDLNY9Ojm6rdltJ+6IY7PIjQhFJxi45Q1IUDg/wS0q92LRg+53MYrhaX?=
 =?us-ascii?Q?EgaK/vIARVPQ7CRinQGGN4t0K3vUchpXfJovzmf+0ooHNjwtDBzJme1t7rxy?=
 =?us-ascii?Q?bZYlOGtEuqSvukFzG0/m12zmHlJjWXge51fImXXWtDkhAomqsbSZN2OHcgWR?=
 =?us-ascii?Q?HONPzcOm5/JbLRyJxzC3NOCOOgLIve/o7ow6USv3+uUl16q/jFWsIiTvstoQ?=
 =?us-ascii?Q?fcKs0jbCDBzaxIwncnZIVA3BJ3FOEwDaunuyxLgrjxiZlX8++BF+Oirgl/0O?=
 =?us-ascii?Q?5yJ0zP97qwym/hHx56pCr9cx89PI6KlrPYnp08Uba4ZrFrgdRifNMQntVCEu?=
 =?us-ascii?Q?yDLObZ3qHIZEFaWm6wF+ohSHK6qEH+ZvWkKxYxG8zSLr9NMFTSr3LsfVk23B?=
 =?us-ascii?Q?SsMJIh21Yq2azE+YTVWmW+IOLRDSFNlgRWVGdUwbqiNttg9YHBhJI2SBvP83?=
 =?us-ascii?Q?PsvSuEfMTe6XL7nXPGxC/kdrz5RyhWowkKhk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kiwrvelr7+jlVFsYZ+nq8TNvXBONJ9800EbuOMrv7SH+tJXvwTZyQf7fQIaE?=
 =?us-ascii?Q?JlSzz076WLiU2yGuY6hHh61+9ZIbBatLnCEkwJ7N7nHNGUNkdQkwL7ZcIPrt?=
 =?us-ascii?Q?pUG+EHtUIm+9kdU2aqMLRkIzz/Y6qYfxBKWl2uaF0KBRPgMiq+2ANFHIEx63?=
 =?us-ascii?Q?NKtb5+wfW0RI/WHm1WAZ4lxa1AfSCg9uSfIYfnRtfrdmqxa3bgarUsRe/HBa?=
 =?us-ascii?Q?/Kr/o0Q54seanTs/yWU7cKrcc4/fQF3rZXH07DXYg2yMMytSNvUqyuika25/?=
 =?us-ascii?Q?S1il5CYJUh4CoUXoV3dcDETPrTKnTl70kup2jBF4N7s5MaemEMDzVU/RHpgo?=
 =?us-ascii?Q?rmJNtDljp19XhHRWFna5A0ueyyszP84z5E+vCleXLiMvvjY8/OY7oekJ+nGl?=
 =?us-ascii?Q?O/5Z8l8IawyQw0KryANduVN+LSx3Mn4wkg0/ATbu7QM6l1WbJjSv0zkd6RBh?=
 =?us-ascii?Q?1UNl6t7+F2QeUia9mixjmUImaXoYqQk7rUExu5vbFIEctQbdBLhPzCx6PbwI?=
 =?us-ascii?Q?eKG2J0FrSY4pyVx/MvC6UvwMLElV3UWj1KMJy2kq4z5aAjK0CnJLdUtONlaq?=
 =?us-ascii?Q?TaWuURZpYCbvuhm45OzlYJWiITQ+uVtAXp2+ZEvaX+vPoxAEHmbRqxePU7nF?=
 =?us-ascii?Q?bbIdYRtP5L0NRm4tIuZkSLOwW0GIe1G8vkF6Gt93FYkyPciFmPL68oso9KUo?=
 =?us-ascii?Q?anWEYB31LryTVNpuYlTRBFyJcWIIhaG0NWtLr62z0QpY2w37KasLpIEBHWvX?=
 =?us-ascii?Q?EhH2FhMdw70hjpBuwo6bbD4y0/oA/5LueYBwDVTnt0OgVDv6vYTFYiMLaLIA?=
 =?us-ascii?Q?DVJTIVmh1wb9xZfYkRkcvLTDMVPPhSt69evQjyCHhtFU4X+QrDJHzi2ZJ0sp?=
 =?us-ascii?Q?kPYnT4eBZv5RyhUU+0+B6jxnWEe5dePnaEhGP24nRtLqhLZQGHhu0jvx02u6?=
 =?us-ascii?Q?NmdAtd+MPgDfE2QuFHGUD6B3M4+ZwwB4NJqofsgh86C9vEYfhCmtAx9vi7Aa?=
 =?us-ascii?Q?ieU8yHxLWvx2LaT74/2w/Cn0iiwITpH266YqSuv77aTuoDNh6i+STYSuh4Vf?=
 =?us-ascii?Q?bwsXH4hRKYTSElZrdfTY2p5kIbgqGZ4xe2bBsglVIWmLuMnEpqUA7Pe5uATq?=
 =?us-ascii?Q?M1wIyVZHvi+/eIaUZFXSEy7sX/TNLyWQ8ep5TMtY6KfYveCK80waO6uFyp05?=
 =?us-ascii?Q?JFwKfeKH+uG2h4PxGt7raqmORuOntGCUbZS1T/izCn5qAhJJWXv74l94fvQe?=
 =?us-ascii?Q?PMyTGRdDeH/J80fIWIctFCATHGb1egKrqpwkc9RtZ1LrsyeWbQpfNV8QVp7Q?=
 =?us-ascii?Q?TTI5HSMAIgLXA0prW0nVixeHLUytl3xE9Jp5sVBmFTed8ywV1uxV9HdM51Gu?=
 =?us-ascii?Q?e09HXlmXO2fw/zSJAclFdg6HVj0V4LboWEpSZn/4GcXyZt/RKnVxhsYT4dP3?=
 =?us-ascii?Q?14U7uZD8R5VvB1d6YH2Jh/qz9hepngqEaCSgyJ/mCxqw8bo4Krki6Ep0mjtz?=
 =?us-ascii?Q?xZQWCCGx70NO7+M98uhLrMtziiq2z1mV2IIDlDFHJ3cP3PU0T0ErN5LNrKuA?=
 =?us-ascii?Q?vleyTCevsprK6VMn8jJMcpjyS7n8FLZ5sunz6rkj/ha0TDIMZSY5oh6lEzjQ?=
 =?us-ascii?Q?R9EegYYQINKLxd21J8Q13x/SX+FR0ESWOLAgKE1motKovIAoDDoNjB6w9Uhf?=
 =?us-ascii?Q?2ZJFK/czZHYsMOJ3pXkmlZ7W17JDPDpX8rxZAVwymEeRcqf6h/WYliT842Ev?=
 =?us-ascii?Q?pCxhv+adiA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4f8d77-d0b2-44a3-fa01-08de527784c3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 07:44:01.8713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8PNU1u4AEh2HhF7B8d/CRi3PqpBFejKi+a3b3NM+eMy+9WNg9Uz3At04gAKYgOL25kqGZq3DY9g5IJjjdsHUbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8708
X-Mailman-Approved-At: Tue, 13 Jan 2026 09:42:06 +0100
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

On Sun, Jan 11, 2026 at 09:23:45AM +0100, Michael Trimarchi wrote:
>This series addresses two significant issues in the pfuze100 regulator driver
>regarding voltage calculation accuracy.
>
>The first patch fixes the handling of the "high range" bit. PFUZE chips support
>two voltage ranges (controlled by a register bit) with different step sizes
>and base voltages. Previously, the driver assumed the low range, leading to
>incorrect voltage settings on boards configured for the high range.
>
>The second patch corrects the interpretation of min_uV. The driver was
>incorrectly using the device tree's regulator-min-microvolt constraint as the
>mathematical base (zero-index) for voltage calculations. This caused offset
>errors whenever the DTS constraint differed from the hardware's absolute minimum.
>The patch introduces physical minimums in the driver descriptors to ensure
>calculations are based on the datasheet specifications, treating the DTS value
>strictly as a safety constraint.
>
>Together, these changes align the U-Boot driver logic with the Linux kernel
>implementation and ensure correct voltage output.
>
>Michael Trimarchi (2):
>  power: regulator: pfuze100: support high voltage range bit
>  power: regulator: pfuze100: Decouple hardware base voltage from DTS
>    constraints
>
Please do not submit three version in one day. That only shows patches
are not developed in good shape.

The changes looks good to me, but I would like to see which platforms
are tested with the patchset before apply.

Thanks,
Peng
