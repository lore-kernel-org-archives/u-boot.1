Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D55E7716A
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 07:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9840B801CE;
	Tue, 17 Dec 2024 08:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="KKJNFmdl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D7DA801CF; Tue, 17 Dec 2024 08:37:56 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AC32801A0
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 08:37:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1734421062; x=1735025862; i=xypron.glpk@gmx.de;
 bh=lEchGfzBMzDBIX+Gdq33AUWgbGmtTML7R2ONHQW1XRA=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=KKJNFmdln1N3Ghm5NUQ/klNFa/hiDpLS7BprSft/gRkUrIYrtCPULPMLlxX+FQxC
 ScUEMh7FtnhdOut88H6NWKxtIyPM/k4blAyl43smJ4kjpVE/Dcn3TkJP0JvoGr64k
 UEVlwSbdvGHUgaE2oowfZQLL/VmIL1bjQlpW+4UzM+1pP40mxUyxM0m17HYqC0DH3
 2KOUyWgbwCyFcja+g7YXYRgYvBhjEFw5liD63G72P4rWps5NkSc8U/wNDtvtPaKA7
 fJEItLnHemWiWcvUyHFPT2FdP/zjZtxGmGxVCRmJSlifr1S2GCJTe98NyaNhFNG40
 sCBEFIe2gberuMyvNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2E1M-1taGgC1bME-00ybnL; Tue, 17
 Dec 2024 08:37:42 +0100
Date: Tue, 17 Dec 2024 08:37:42 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
CC: michal.simek@amd.com, trini@konsulko.com, sjg@chromium.org,
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 jerome.forissier@linaro.org, mkorpershoek@baylibre.com,
 akashi.tkhro@gmail.com, francis.laniel@amarulasolutions.com,
 ddrokosov@salutedevices.com, git@amd.com
Subject: Re: [PATCH v4 2/2] doc: man-page for optee commands
User-Agent: Thunderbird for Android
In-Reply-To: <20241217035914.1297469-3-venkatesh.abbarapu@amd.com>
References: <20241217035914.1297469-1-venkatesh.abbarapu@amd.com>
 <20241217035914.1297469-3-venkatesh.abbarapu@amd.com>
Message-ID: <997D5EA1-DAB6-4C5D-85CB-3B10E17CACD3@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hgff5tdKPBao1KV8gzQn5of0N3fuGmRsq8Cy8vqD3dPuMOYSnkg
 k2AAu7S/DMsA7w7u6diUI44P4Z+EAmU4c1CkiuW2PtBYLsiWQncN0DCf27u83kokfWlSWq6
 ARl6AK7ORbv+bifGMPebW1R/7pnSsJBxN7TNh8BSsDA1pcAp6CmR2shvibXx1PoA0ndxT8q
 iaUpPiNkeELN8nN1W/wrA==
UI-OutboundReport: notjunk:1;M01:P0:vEZlRDy3zoA=;OE/3zzv5tQf8v1aaYV5lG7qS//F
 TTo8w44/eQi+2RSBqlMenBLiIassIi2AKoyUaSOzT5dGkB7egOSek4AVXLHD9KD0Pjw2Lvx3j
 cdiIPzQOtW83pytbBTy3C2mVYKOE1PA8U390Dv948xBf2tBVhoxtq7EmB2UTcBW7zs23bSJte
 AALNqBZlHyk4EwR8skTAZFnNA9Rzs6bWRFuPiTNsXxIGGw2yrfqRNPjbwbIwy/ypYYxcqjtsu
 ajYD7jPmOyh6FhgLO53L+pXNr8rh3c94SUpMkTYMzWjOAEtYQnydEDFjhYeEwe1dZtIG42QjV
 SufxzrP0MfjoHl2X+viDkTM5rt9RjPcaLszIpY1lPFlKifuR3R4bNWGgLuYUrT3UprtyYxSvS
 I7vzvpZkOZF4brkRJ1M1osdE3wA725s1um+IGrrBvR/JkK0eQbBlOOEE8sWcTlkd3EO4Xf1Wf
 xL4TRIXecXcpBli89t9rGRG7ANt2sDRmAjJCtRCpEB4fSozUls3wHEf+wM7UzP5BXRB8cdg8V
 gEn9mjp+1u+oxaDhPrA3Os3nmfILMbwFSdzw6nTUdlNBkPwGVtQGS2EeCx+77h9U714brqqdf
 AX0rLd8Ln2JShpNoi0QlRmiN6PjEQdE3KRS38x9ldRU0P51HkXbwmc4y/NxQ8P1Kt0yOZddaW
 m3art+PHMNgt5REB8wj4z3SNNpTCi6u57qCK2KgECoxESIHpH03UdQ6WczZyf/Ah+w3eC3kY2
 TfRDW3QXF2kKVTiF61G6AZj0DzJxWLa0ggGKIxUFpExPBALwokmPS1VheNvQEFVX9jU1mOFUG
 yZ2t9cx5h8CliPDF1mJTbqew1fTcAPJBJ8Kmfhd2UNLZGTPF4cYfBSNa20Sp1tZ290pC8qvzS
 kJiQE3w5ZOBHnJTYBB8S4JLAJOyxbU+YimbR/vVk8qL1uJobXp1nGRxy8zflNaLR0sB/bpu8S
 Q69NLwBDhqAGFG6zAG3dcN5066KoTvAojPN0jbCJr9y3AdKx+shbVo4huMgaJ00tWTlk+crMx
 D+Aw9KEykjSX6yAKHkUj3f8Z4xRgcJ4mCe2jyoHxjTmrApIL8lnerRBviY2rcMg9VT4cWLO4U
 IlYF9Qy/hmUB16b9BYezUKXu9Xgd1f
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

Am 17=2E Dezember 2024 04:59:14 MEZ schrieb Venkatesh Yadav Abbarapu <venka=
tesh=2Eabbarapu@amd=2Ecom>:
>Provide a man-page for the optee command=2E
>
>Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh=2Eabbarapu@amd=2Ecom>
>---
> doc/usage/cmd/optee=2Erst | 66 +++++++++++++++++++++++++++++++++++++++++
> doc/usage/index=2Erst     |  1 +
> 2 files changed, 67 insertions(+)
> create mode 100644 doc/usage/cmd/optee=2Erst
>
>diff --git a/doc/usage/cmd/optee=2Erst b/doc/usage/cmd/optee=2Erst
>new file mode 100644
>index 00000000000=2E=2E53e36853742
>--- /dev/null
>+++ b/doc/usage/cmd/optee=2Erst
>@@ -0,0 +1,66 @@
>+=2E=2E SPDX-License-Identifier: GPL-2=2E0+

The correct SPDX identifier is GPL-2=2E0-or-later=2E

Maybe that can be fixed when merging=2E

Otherwise

Reviewed-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>

>+
>+=2E=2E index::
>+   single: optee (command)
>+
>+optee command
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+
>+Synopsis
>+--------
>+
>+::
>+
>+    optee hello
>+    optee hello <value>
>+
>+Description
>+-----------
>+
>+This is a very simple optee hello command which is going to
>+increment an integer value=2E
>+
>+value
>+	value to be passed which is going to increment
>+
>+To enable the OP-TEE OS side HELLO WORLD example please refer
>+https://optee=2Ereadthedocs=2Eio/en/latest/building/gits/optee_examples/=
optee_examples=2Ehtml
>+
>+Examples
>+--------
>+
>+::
>+
>+	=3D=3D> optee hello
>+	The Hello World TA is going to be called
>+	D/TA:  TA_CreateEntryPoint:39 has been called
>+	I/TA: Hello World!
>+	TA value: 0x0
>+	D/TA:  inc_value:105 has been called
>+	I/TA: Got value: 0 from NW
>+	I/TA: Increase value to: 1
>+	TA value: 0x1
>+	I/TA: Goodbye!
>+	D/TA:  TA_DestroyEntryPoint:50 has been called
>+
>+	=3D=3D=3D> optee hello 74
>+	The Hello World TA is going to be called
>+	D/TA:  TA_CreateEntryPoint:39 has been called
>+	I/TA: Hello World!
>+	TA value: 0x74
>+	D/TA:  inc_value:105 has been called
>+	I/TA: Got value: 116 from NW
>+	I/TA: Increase value to: 117
>+	TA value: 0x75
>+	I/TA: Goodbye!
>+	D/TA:  TA_DestroyEntryPoint:50 has been called
>+
>+Configuration
>+-------------
>+
>+The optee command is enabled by CONFIG_OPTEE=3Dy and CONFIG_CMD_OPTEE=3D=
y=2E
>+
>+Return value
>+------------
>+
>+The return value $? is 0 (true) if the command succeeds, 1 (false) other=
wise=2E
>diff --git a/doc/usage/index=2Erst b/doc/usage/index=2Erst
>index cb7a23f1170=2E=2E4dd00f002cd 100644
>--- a/doc/usage/index=2Erst
>+++ b/doc/usage/index=2Erst
>@@ -92,6 +92,7 @@ Shell commands
>    cmd/msr
>    cmd/mtest
>    cmd/mtrr
>+   cmd/optee
>    cmd/panic
>    cmd/part
>    cmd/pause

