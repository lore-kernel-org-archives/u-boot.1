Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D36E7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 08:16:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B7DF8962C;
	Tue, 10 Dec 2024 09:16:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="tOrmNDXz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13A82897CC; Tue, 10 Dec 2024 09:16:15 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8781689452
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 09:16:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1733818556; x=1734423356; i=xypron.glpk@gmx.de;
 bh=XBpYwPkOV6GYW0HMxB0vGgIOpQXcmxjm0f+epsUYsmM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=tOrmNDXzD5fE4LXxU41mdbIuq6ElN1oNx85VUcmoOT6/qq93HrDyBzJRcpXeGmHz
 nTG4rgNkM+LH47spx5nsbClJRtwBdJl6lrDc9T1z7SUtG7fEtP92N2HhG08uzdrGq
 JB1sYid1cfSJftsx+kZmRplTLJfIuWzEFFQfO3HzPjpr1g4GWNoa8CXwDHAo0wzGP
 xKWJ0etQqWE7/lLW8M+MMdxcvKC9IwrFagE4eyefCDLF7OAUiw28bj2u5hQI/2fdo
 f0Z6QLQ/5Gzhp0nIJIpzxOXz6RRm9jJCdzHH1iggF2XcDrv2MgZIARo/bTY05K+1X
 ml9DH/A7Wkl9AdJTUg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmDEm-1u2kXM0N16-00dPl5; Tue, 10
 Dec 2024 09:15:56 +0100
Message-ID: <0f17622a-ae3b-4d02-9cdc-c39d4f8bfa6d@gmx.de>
Date: Tue, 10 Dec 2024 09:15:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] doc: test: Add docs and test for part_find
To: Simon Glass <sjg@chromium.org>
Cc: Matthew Garrett <mgarrett@aurora.tech>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Maxim Moskalets <maximmosk4@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tom Rini <trini@konsulko.com>, Wang Jie <dave.wang@rock-chips.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241209162801.288363-1-sjg@chromium.org>
 <20241209162801.288363-4-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241209162801.288363-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bRedakJN3GuPSgcyV/hIMgRmUIGbRpaGYUCRAfjTSUZynSKpw0M
 0JOFPFgPL6gjlFDjLFkXuWzV14ajBtPFqmxT8wQb/Q6YElf++fyLA9Xm0oUjGTS+xQqPfyu
 J+HtgPBjKNpL8+hNIt1E+fo5Pq3RD7XWUBERL+7j5oqdNnMVZJxvOuEqQgDS/s5wbQFBs7J
 LsImw7tE/SF9H+JBBh7+A==
UI-OutboundReport: notjunk:1;M01:P0:Z37VLIHREwM=;HEiFEEq9nZsuwN+RfAHT+i0suXZ
 oq1m+uKupgXkKFlx9rFD4JsfiYZB7XS3AXK+UzzJxI2z2Xou/m2SYbr+w0JipkZPPA839BAQk
 XUYqbazJY1z12wTWTvX5AehGUVjfRuUjzxjk1plYA7CbcHQLchUM0cCAxSWLGIUfUSTuD0k6q
 F6xC/21Of0+sgTWGDDcNs+JXSDTJneOQmbGDxAVSETASYMy3KS0hX9Pr+j/wgjh2FjG28/lbR
 bEB9pbtn4WSOcqaTJ8+wNDRisVKeAiSqxhh+XcEtFsgnefLpd/w8GHhil6nCujqLPYJ8DvP9m
 gqDhnmya+UX+AjcnktP5Bpu3tUtT7F25mkyxEXidAQ+Id7L187Staaz59s+kfgCZtmw3crHBc
 p6znx+TqGRFQJ7IsB3h+IRr9AQItIvoGMBq6a2qe3v26Xo9DEZqeh7cWwiidZwKQGAV9xflJJ
 8vsxEMEmYV5ECYTtXaoS3s5kXvddiWTmEVnzWz/jKdVc+x6RXhANDtxh3kD/SsRxV5hefs61s
 wHXMNWn1tDIrqhajj9DQNRbUUF36eun+SvCZlami0zUIntHTDuPZvTD3rgzBjohYMgaKSv0xw
 ylU+cFH4RSgnpJsr/A9X15KmnVsq83M/hpBFVuYzoWYq7IaxW3QwktinYffnuknllBrEXrbXZ
 ngviiKW5snzI+b3mtCWXoMKSSGlUgkragZxjwwmGndreACI32Sez3Hd+xJ13zUt8ZveI1GihM
 1h7Vgvb2a8/FwIYQsefcVMTO9BOQp2O61gl6FN4NUvBvqYN+ng7ZKSlqaiWjrdQfXd8Bycd4p
 Rca6fOJod2W5rme2zdnEPyARcOYSLTL0kb26mEcxBTySOLk32W4hSP58eIpyOQr+N4gLt0I7R
 qaE+K0kvc0GKa16OUvCSgrFUV3VbVFXYMdM+XaoaPcQkofN6u7Zo7SWaNylJTE6OGDYeEGDNY
 cUbDU2NkMu02AqA3hMKR8eSR3hibQQDJxHHslyrPt/JrTwF4qne0EwSdNFlKb3DZbknmMw1wp
 Nfj4T0BvCvVhGjkji6yjKuKK0O9EisgRIby39xPq/4XpMAWtOfQCY34E+i3reIvJ7iq1NyHkN
 U3OU0mwaRSUvitnZcVHj9cl8wCLcX3
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

On 09.12.24 17:27, Simon Glass wrote:
> Add some documentation and a test for this new command.

Shouldn't this be two patches?

>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   doc/usage/cmd/part_find.rst | 119 ++++++++++++++++++++++++++++++++++++
>   doc/usage/index.rst         |   1 +
>   test/cmd/Makefile           |   1 +
>   test/cmd/part_find.c        |  42 +++++++++++++
>   4 files changed, 163 insertions(+)
>   create mode 100644 doc/usage/cmd/part_find.rst
>   create mode 100644 test/cmd/part_find.c
>
> diff --git a/doc/usage/cmd/part_find.rst b/doc/usage/cmd/part_find.rst
> new file mode 100644
> index 00000000000..fd5bd6578d5
> --- /dev/null
> +++ b/doc/usage/cmd/part_find.rst
> @@ -0,0 +1,119 @@
> +.. SPDX-License-Identifier: GPL-2.0+:

This is not a valid SPDX identifier.
Cf. https://spdx.org/licenses/GPL-2.0-or-later.html

> +
> +.. index::
> +   single: part_find (command)
> +
> +part_find command
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Synopsis
> +--------
> +
> +::
> +
> +    part_find <uuid>
> +    part_find self

We already have a part command.
Remembering the command would be much easier if you would add the
functionality there.

> +
> +Description
> +-----------
> +
> +The `part_find` command is used to find a partition with a given type G=
UID. When
> +it finds one, it sets the target_part environment variable to the corre=
sponding
> +``interface dev:part`` string.
> +
> +uuid
> +    Universally Unique Identifier (UUID) to search, expressed as a stri=
ng
> +
> +self
> +    This is only permitted in the EFI app. It indicates that the requir=
ed
> +    partition is the one from which the app was started.
> +
> +Example
> +-------
> +
> +This shows searching for an EFI system partition and looking at the fil=
es on
> +that partition::
> +
> +    =3D> host bind 1 mmc5.img
> +    =3D> part list host 0
> +
> +    Partition Map for host device 0  --   Partition Type: EFI
> +
> +    Part    Start LBA       End LBA         Name
> +            Attributes
> +            Type GUID
> +            Partition GUID
> +    1     0x0000202f      0x0000282e      ""
> +            attrs:  0x0000000000000000
> +            type:   ebd0a0a2-b9e5-4433-87c0-68b6b72699c7
> +                    (data)
> +            guid:   6b1e51e3-427c-9f45-a947-e467b7216356
> +    2     0x0000002d      0x0000082c      ""
> +            attrs:  0x0000000000000000
> +            type:   fe3a2a5d-4f32-41a7-b725-accc3285a309
> +                    (cros-kern)
> +            guid:   dece619f-4876-e140-a6c9-8c208a0c9099
> +    3     0x0000202e      0x0000202e      ""
> +            attrs:  0x0000000000000000
> +            type:   3cb8e202-3b7e-47dd-8a3c-7ff2a13cfcec
> +                    (cros-root)
> +            guid:   078cee87-a195-ae4c-a974-8ba3a3d783b3
> +    4     0x0000082d      0x0000102c      ""
> +            attrs:  0x0000000000000000
> +            type:   fe3a2a5d-4f32-41a7-b725-accc3285a309
> +                    (cros-kern)
> +            guid:   08d2f20f-d941-fc43-96f6-948931289d71
> +    5     0x0000202d      0x0000202d      ""
> +            attrs:  0x0000000000000000
> +            type:   3cb8e202-3b7e-47dd-8a3c-7ff2a13cfcec
> +                    (cros-root)
> +            guid:   0b23ba00-a11c-ed4e-8b49-5e8738899569
> +    6     0x00000029      0x00000029      ""
> +            attrs:  0x0000000000000000
> +            type:   fe3a2a5d-4f32-41a7-b725-accc3285a309
> +                    (cros-kern)
> +            guid:   6d8158a8-f82d-0d4d-8983-a3ada4eb9b73
> +    7     0x0000002a      0x0000002a      ""
> +            attrs:  0x0000000000000000
> +            type:   3cb8e202-3b7e-47dd-8a3c-7ff2a13cfcec
> +                    (cros-root)
> +            guid:   76e8f9b0-7db7-3844-8f18-21de93485211
> +    8     0x0000102d      0x0000182c      ""
> +            attrs:  0x0000000000000000
> +            type:   ebd0a0a2-b9e5-4433-87c0-68b6b72699c7
> +                    (data)
> +            guid:   071dfd2d-173c-f64b-9474-3318665e1d24
> +    9     0x0000002b      0x0000002b      ""
> +            attrs:  0x0000000000000000
> +            type:   2e0a753d-9e48-43b0-8337-b15192cb1b5e
> +                    (cros-rsrv)
> +            guid:   b9d078c3-bafa-cd48-b771-a0aaa18d5008
> +    10     0x0000002c      0x0000002c      ""
> +            attrs:  0x0000000000000000
> +            type:   2e0a753d-9e48-43b0-8337-b15192cb1b5e
> +                    (cros-rsrv)
> +            guid:   7b0c0234-1a29-0c4f-bceb-40fae8f7b27c
> +    11     0x00000028      0x00000028      ""
> +            attrs:  0x0000000000000000
> +            type:   cab6e88e-abf3-4102-a07a-d4bb9be3c1d3
> +                    (cros-fw)
> +            guid:   aced715d-cd1f-394a-9e3e-24b54a7b1472
> +    12     0x0000182d      0x0000202c      ""
> +            attrs:  0x0000000000000000
> +            type:   c12a7328-f81f-11d2-ba4b-00a0c93ec93b
> +                    (system)
> +            guid:   e1672afd-75ee-d74e-be95-8726b12b5e74

This excessive list is just distracting in the documentation. Two
partitions are enough.

> +    =3D> part_find c12a7328-f81f-11d2-ba4b-00a0c93ec93b
> +    =3D> print target_part
> +    target_part=3Dhost 0:c
> +    =3D> ls $target_part
> +                EFI/
> +
> +    0 file(s), 1 dir(s)
> +
> +
> +Return value
> +------------
> +
> +The return value $? is set to 0 (true) if the command succeeds. If no p=
artition
> +could be found, the return value $? is set to 1 (false).
> diff --git a/doc/usage/index.rst b/doc/usage/index.rst
> index 71970d5f2b3..64fb91bc5a6 100644
> --- a/doc/usage/index.rst
> +++ b/doc/usage/index.rst
> @@ -95,6 +95,7 @@ Shell commands
>      cmd/mtrr
>      cmd/panic
>      cmd/part
> +   cmd/part_find
>      cmd/pause
>      cmd/pinmux
>      cmd/printenv
> diff --git a/test/cmd/Makefile b/test/cmd/Makefile
> index 583e7c2eec4..dfc49af7bf3 100644
> --- a/test/cmd/Makefile
> +++ b/test/cmd/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_CMD_LOADM) +=3D loadm.o
>   obj-$(CONFIG_CMD_MEMINFO) +=3D meminfo.o
>   obj-$(CONFIG_CMD_MEMORY) +=3D mem_copy.o
>   obj-$(CONFIG_CMD_MEM_SEARCH) +=3D mem_search.o
> +obj-$(CONFIG_CMD_PART_FIND) +=3D part_find.o
>   ifdef CONFIG_CMD_PCI
>   obj-$(CONFIG_CMD_PCI_MPS) +=3D pci_mps.o
>   endif
> diff --git a/test/cmd/part_find.c b/test/cmd/part_find.c
> new file mode 100644
> index 00000000000..1663d4a654f
> --- /dev/null
> +++ b/test/cmd/part_find.c
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0+

This is not a valid SPDX identifier.
Cf. https://spdx.org/licenses/GPL-2.0-or-later.html

> +/*
> + * Test for 'part_find' command
> + *
> + * Copyright 2024 Google LLC
> + * Written by Simon Glass <sjg@chromium.org>
> + */
> +
> +#include <dm/device-internal.h>
> +#include <dm/lists.h>
> +#include <dm/ofnode.h>
> +#include <dm/test.h>
> +#include <test/cmd.h>
> +#include <test/ut.h>
> +
> +/* Test 'part_find' command */
> +static int cmd_test_part_find(struct unit_test_state *uts)
> +{
> +	struct udevice *dev;
> +	ofnode root, node;
> +
> +	/* Enable the requested mmc node since we need a second bootflow */
> +	root =3D oftree_root(oftree_default());
> +	node =3D ofnode_find_subnode(root, "mmc5");
> +	ut_assert(ofnode_valid(node));
> +	ut_assertok(lists_bind_fdt(gd->dm_root, node, &dev, NULL, false));
> +
> +	ut_assertok(device_probe(dev));
> +
> +	ut_assertok(env_set("target_part", NULL));
> +	ut_assertok(run_command("part_find c12a7328-f81f-11d2-ba4b-00a0c93ec93=
b", 0));
> +	ut_assert_console_end();
> +	ut_asserteq_str("mmc 5:c", env_get("target_part"));
> +
> +	ut_asserteq(1, run_command("part_find invalid", 0));
> +	ut_asserteq_str("mmc 5:c", env_get("target_part"));
> +
> +	ut_assert_console_end();
> +
> +	return 0;
> +}
> +CMD_TEST(cmd_test_part_find, UTF_CONSOLE | UTF_DM | UTF_SCAN_FDT);

