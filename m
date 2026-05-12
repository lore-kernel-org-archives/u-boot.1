Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD44CCD343F
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 16:16:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 443AF838BB;
	Tue, 12 May 2026 18:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="F+5FVzA5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14D7A83EF9; Tue, 12 May 2026 18:16:40 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73B04836AC
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 18:16:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIHqb/OA8wXqic+z7nM0pscTEZHqviw/VBweDg+JJLHJif7IPkzPLcbBQMkQckIrs0SyHiiE6LuvJQyz14FuCJBKdii8AzRnzJpHY/CijCDNvRagQonQ1Vb7Jq53rFH7j75dd5e7sjOSWU8udZ/gWQcrc6cDVNWrT1ZxRYXWqD73BP+GSudn/TEJmyWCiq0t1n0OTJUgDXGuGjv4BhAhS5h5PQWFiFVQ3BW+KJtxeMI02AH8H3C8oXm4GMneHRpzNIxfvrqZKtRi8ZZKidVvWrljpOn0I2KOJUgltspoInm7HwXKuHrdfFutcvEzNstdGEW1Hp+HdyWoICjXeIPCxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsS2JOauodHf7DoDRBn7wSIWrZtNIjTnQPF/smrm+SA=;
 b=wzCjwWqUE1G0peHNS5m0OsTZkbjff+1bawbJKdQ88SIb9M2WovVh4ezhZiWccnfygwnlWLjZ7EV8dYot4iONCg9Pwa/3BYwDrYey8pwvONATYNwXceVmAOuycy+zIsl8MEGjcWmGDEjURlQMQ523OT6117fV7VwD+gaXV8d/WPw4qA6esetJUUYq4wjHIDH9sMSx29ZUKsuio6uJDQFxHTMduIGCY+5evg4krQuLx1plBbSSinsDT7rCfXqDoHsQnCCzKlS5labShf63TbzCmC+JF6Fad3/qzx7jlgRj72k4Rl9Hl8EnOr/5+86iY/a2IJtcw8nQuktTRA80IVJihg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsS2JOauodHf7DoDRBn7wSIWrZtNIjTnQPF/smrm+SA=;
 b=F+5FVzA59aUb7Uh9a1B9FSRr5E9j20bG0OO3k8ksiCL+nfn4LPrzbiYdcVoKigpZLhyEMHtaou/m/qhQZwo9d+TaCQ1Ip2XMawFMZrTtzKTIIYr+JhEn4RaJErGkhJVQBaTkXwVoOkDpGtNYD0dX7TK8v3Ae4zP13keOUAc1QTs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AM0PR10MB3668.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Tue, 12 May
 2026 16:16:34 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 16:16:34 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 0/2] allow control DTB to double as "FIT image"
Date: Tue, 12 May 2026 18:16:29 +0200
Message-ID: <20260512161631.284143-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::10) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AM0PR10MB3668:EE_
X-MS-Office365-Filtering-Correlation-Id: 0564758c-5694-4a49-2ccb-08deb041d5cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014|11063799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: PeK+GFeDRRU+gTjSBAzLOGxdFnlAAUt5lALux7+Dz1H9KYspsl+QIIp0y8s6yLxbcuDiJormsvUFOJLvMwRlQOUxz/Ws5SFa7yszLX/omjj8YaybIT7KkPrf8njJ5ucUfGxH9C2TjqvY+Q4U9KjVoZIz2sKZOf1JS2yqNKzHsEElZmG7qhPrapaj9B0Uob+v0qorDAKPjaiX3YQKx6NBCkTbhawh1qj+y2aGnvzVIopPzhw8PFkT3RAzK/9m0QYgzMA48fU4o1aQRzefdv9js5R0i0u2wTLQIVPM40dM+dqPyx6gRWWoxX9P6AJsSzY3MJLWLElrQbctAtaGNKN7UuOBYxTW+Lv6RDgiW+NS7RcXY9+1vNh0yFWeGTHBxi1ofqmjg3/A1EDsSSJ6bTGy1Qf7yLH4V1abcHbB8DW9cOllekoSG7SHpITBmpbH593TlygyCmH7DpH5wArqo3aXp47miJXK3w+ye3DcgPNpfDp0MXoDFwM1qJY90uH6VcgPkYkT0ntO2R5yY/+6lFmLg6PcrtrZc7I4pRKQ6zGZwXQbWst59L35FGgjB5cP/yCuFGKZD0a8rRZtlkfhgBRuMz5da0jmSqMuob1FtoSFxfkStsI85CZaP8RglagdRG3+7BVuzBYLx62l8ZPjx0L2R/0X0FeF4tB1meIyRwVs/QFNY3695Kz5APz7hdm2rpgwTvU8Y3XhbVnGLc34Cnq+iSn3ajU3gDsY63q+k6m1+1B4bm292hb+VFQ9jPDU5PYr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(11063799003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cjlGfu4Lr6DrzyX02OpciMy2eSUEK1HVBPyAA9CDZ3iGycrFWXqZMpnOdI1j?=
 =?us-ascii?Q?nE1793Dixq+JfNX5Rb47mcLe6+/L1nPWRZzy+QEcEArotJqW0rs+zHehUQPw?=
 =?us-ascii?Q?eRNj1KHcEjIKxdjKeVkqRGbf/FDgFPv/IghhI1QVb+ZtFJ7xycbv1WH8V8OM?=
 =?us-ascii?Q?brLRI7P386w8PgFjz8nMAkyvocU83/hpPe0YXdsRnvBvlx59ioAeBXeHuEky?=
 =?us-ascii?Q?A/0yIGhnYT8KYDzlCFS/mHrjg53QDcyUtifyqp39dJjMl5hEK8noNeGmqLmp?=
 =?us-ascii?Q?XFIuo9rKYdejBQKmKLPSO6Iy1HC50kv6zhDQ69712QptQImqPg/CrTEg0s6d?=
 =?us-ascii?Q?qNn4uRfOprk5wgJVxpkfL2Jx7b93HE2qZRVGlRWZMh6hAocJEx3SAzan/OBz?=
 =?us-ascii?Q?4mM08ZgvnZDiaGs8hHMN5g1Afg3CiBJKOwCtI68yOvZFoB8B8tpe5gIYsvJB?=
 =?us-ascii?Q?uex2MJavZaK7phuEUL5Rngv6hHcwfAtzCrGeGWql4384KsOiQ4WnpgErNu/T?=
 =?us-ascii?Q?CtHtLAmaIlwzOweJMVGNvpWO9W8nmavssxubfxnmhGHe5sU4ZJ62Tmg/obWz?=
 =?us-ascii?Q?moVzpv7oBtZHGxJawxywOmAhbCs71ZJ6pfvOBeCJeH1B7bw4E+aTWl+i0tZc?=
 =?us-ascii?Q?p1MHd/P0C1K2BylcujJ0icmOxd3wRgLWDtZsQKtE/dM0iedYfR/pE2ybdxiF?=
 =?us-ascii?Q?tzRwY2jTrgHFGBEXjJvixx0NtD9/GT5cerxT7t2FguIcXrZvaUtAHW3s2XrD?=
 =?us-ascii?Q?KJjcIcKztr1QWCyAB3U8WMxujr/pTSjJ8GXCmUCGMgWaEhM2C+DsV4JMR9ay?=
 =?us-ascii?Q?waHnbF78NXrXvjU3jDvUBWFsFjpH5N9ZbcOehBvJfNrVPJI7883IOEp6Ol97?=
 =?us-ascii?Q?dfW+8BMdxYtgrfXKNXFwC7AMiXfa4STXC1zAxijgsSOJ9Hrm0d3w0gWKSVGv?=
 =?us-ascii?Q?nNZkJEXv13YLLHib6S11YhNtNmboq3/dVLfbYFs/qLze6S7FmUcayYoy5AnM?=
 =?us-ascii?Q?744uDX2SVFiX2IDX9igTxBs0EfjbqUk/KJ+omVnCr9FteipRipbLBDiQNd97?=
 =?us-ascii?Q?W8BalIJvT8D531xAek9YvVXcX7ZzWV53Kv8L0AUVGNfCoPcHTp8vEIKxmELA?=
 =?us-ascii?Q?qFYCNbLlLasADZohTjwGzEmCztXdCEv7hOj9xYW29BX8FoOndzZ/IWjB+r4w?=
 =?us-ascii?Q?2IYcmfT5cD+7EkiD0PdPHq7V2ua2pltXu9sWBSeIvxRGubA2U2yucbTvBR0l?=
 =?us-ascii?Q?OS8JQpkf4bb+0mgmbpXUhGTQLVWU6V1MR30Os67rH13/7W4mjhrrun6Z5M8o?=
 =?us-ascii?Q?Mujude3l4z0mq9HX/lsNaBlzW6iNVcpu9YNaUjJ4eBljUEswpFNfrrJMawHM?=
 =?us-ascii?Q?Xy6tZ5a/SYPeB7nGcBex142T3FojtJiNnbwL2ph4GY3Bh0BlbmskrttjxWYD?=
 =?us-ascii?Q?qxdl3qtpmqtdFI+kVSSEErLlIUBSqlGNlRgmp3WfqDRFXWtJ2vH4WpSKWfW4?=
 =?us-ascii?Q?RGa1VR/oTqvnI2064DzMdBNKrsFKzYzTxyn6n3CobWwLRT3/RYs9YpkPciPw?=
 =?us-ascii?Q?qX9WRp7iWCmLWAs9gFnnG+ipT9PW4PPzqwLQz8K1UMA6t3ovVDhl7fAWo9/r?=
 =?us-ascii?Q?Qqj5DGT244B1MYWnIHxGojELx6VtfN/n6EmulfzgnY0NYJkTdbf8A3ZkHFXB?=
 =?us-ascii?Q?RkB2Gb0P6dj4nF1ZXNTs09WvIZQpKRNZSnavdL7TW5ja607aY2pO9jaa8bX1?=
 =?us-ascii?Q?cvK1LTcUfXR9Nrs1v3zsp4ZKGPiWbLM=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 0564758c-5694-4a49-2ccb-08deb041d5cd
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 16:16:34.1898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5pKSgvAdvD5NxYj+4Eo6f9ZpW1mxgF2sjMn4y3i7SWcTEi4NdQEs7iODyZ0ak4Sw+A5qRcSpP3L+46pEhY+Fd7rK7YtoXrFUeTExXMn+MIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3668
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
that's where the public key for the kernel verification lives).

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

I realize this is a bit of a hack, but I do think it's somewhat
elegant, and avoids inventing a whole lot of extra infrastructure for
allowing one to embed larger scripts and invoke them from the shell. I
am of course happy to put this exemption for gd->fdt_blob under a
CONFIG_ knob if that is deemed necessary.

CI is half-way through (and past the sandbox testing that would
exercise this) and seems happy:
https://github.com/u-boot/u-boot/pull/969

Rasmus Villemoes (2):
  image-board.c: exempt gd->fdt_blob from fit_check_format() check
  test: hook up test of allowing control DTB to act as FIT image

 arch/sandbox/dts/sandbox-test1.sh     |  4 ++++
 arch/sandbox/dts/sandbox-test2.sh     |  4 ++++
 arch/sandbox/dts/sandbox_scripts.dtsi | 18 ++++++++++++++++++
 boot/image-board.c                    |  2 +-
 configs/sandbox_defconfig             |  1 +
 test/py/tests/test_source.py          | 12 ++++++++++++
 6 files changed, 40 insertions(+), 1 deletion(-)
 create mode 100644 arch/sandbox/dts/sandbox-test1.sh
 create mode 100644 arch/sandbox/dts/sandbox-test2.sh
 create mode 100644 arch/sandbox/dts/sandbox_scripts.dtsi

-- 
2.54.0

