Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BD6EB8FA5
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 10:49:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6624A86682;
	Wed,  6 Sep 2023 12:49:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="kr+cE7WC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10895866D0; Wed,  6 Sep 2023 12:49:56 +0200 (CEST)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60E5586680
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 12:49:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20230906104948epoutp031947a84fab30ec676cde27b78ac35b63~CSaZd4oZ20902509025epoutp03S
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 10:49:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20230906104948epoutp031947a84fab30ec676cde27b78ac35b63~CSaZd4oZ20902509025epoutp03S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1693997388;
 bh=EdHxLD6rPhOCw7w9oHE/OSFDMuIw+wYfTCIWX8hSLyk=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=kr+cE7WCYVcmlqKHC+Hl5mFVON4fCqFKtiuQjVobYkYeoWd9c4d1ne5qzvOfR0GYn
 TGu7eZZlhFCvy5n1h7Fum8F68nZqTldI0WICO/lyw72hOExfwVfeGdphvozlQymO9M
 lfpvOwzJb5h9VYWv4xe9G4c30jTjY4R6FP25eMY0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20230906104948epcas2p33f36611e1162684b4ef9aabad8fd61a0~CSaZEphOx1263812638epcas2p3d;
 Wed,  6 Sep 2023 10:49:48 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.100]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4RgfJq3y6gz4x9Px; Wed,  6 Sep
 2023 10:49:47 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 EA.09.09660.B4958F46; Wed,  6 Sep 2023 19:49:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20230906104947epcas2p34e80a7969f56cfb5490fded66d8a1a66~CSaYFu7fv0076900769epcas2p3t;
 Wed,  6 Sep 2023 10:49:47 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230906104947epsmtrp1b0cd4bb51442e8a8870a16d9c8a4a0a8~CSaYFEMQu3105431054epsmtrp10;
 Wed,  6 Sep 2023 10:49:47 +0000 (GMT)
X-AuditID: b6c32a47-d5dfa700000025bc-bf-64f8594b0687
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 BE.03.08788.B4958F46; Wed,  6 Sep 2023 19:49:47 +0900 (KST)
Received: from KORCO082417 (unknown [75.12.40.192]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20230906104946epsmtip296aa7572e94aadd0bc80fdd13f6f152b~CSaX2ebvh1897218972epsmtip2x;
 Wed,  6 Sep 2023 10:49:46 +0000 (GMT)
From: "Chanho Park" <chanho61.park@samsung.com>
To: "'Heinrich Schuchardt'" <heinrich.schuchardt@canonical.com>, "'Rick
 Chen'" <rick@andestech.com>, "'Leo'" <ycliang@andestech.com>, "'Yanhong
 Wang'" <yanhong.wang@starfivetech.com>
Cc: "'Simon Glass'" <sjg@chromium.org>, "'Marc Kleine-Budde'"
 <mkl@pengutronix.de>, <u-boot@lists.denx.de>
In-Reply-To: <20230906100803.79812-3-heinrich.schuchardt@canonical.com>
Subject: RE: [PATCH 2/2] riscv: dts: starfive: generate
 u-boot-spl.bin.normal.out
Date: Wed, 6 Sep 2023 19:49:46 +0900
Message-ID: <000101d9e0af$da53e490$8efbadb0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLgXrlp9FI+RP5glVKFMAjsQEyxagEMN1GJAglIjLyt5/W64A==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmua535I8Ugxlz5SwuNN5kt1i/aAqL
 xdsXZxktvm3Zxmjxdm8nu8WPrkeMFo8PvWZyYPfYc3oWs8eshl42j9kNF1k8zt7ZwejR/9fA
 4/ZZ3gC2qGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfM
 HKBTlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF5gV6xYm5xaV56Xp5qSVWhgYG
 RqZAhQnZGav7N7IUXJGo+PnsGFsD43WRLkZODgkBE4m9c08wdzFycQgJ7GCU2P/xDhuE84lR
 omvydVYI5xujxNIbb9i7GDnAWm42SkLE9zJK/JzzG6roBaPEu28XmUHmsgnoS7zs2AaWEBHY
 xSjx+uIbNpAEs0COxKPbp9hBbE4Bd4nJ/z6BxYUFgiWuz5zLAmKzCKhInNi9HqyGV8BSYsHF
 9YwQtqDEyZlPWCDmyEtsfzuHGeIJBYmfT5exgtgiAk4Sp98eZISoEZd4efQIO8gREgJbOCTm
 /J/CCtHgIrFk3zFGCFtY4tXxLewQtpTEy/42qDfLJXYsS4LobWGUaG7bA7XMXuLHTZA5HEAL
 NCXW79KHKFeWOHIL6jQ+iY7Df6Gm8Ep0tAlBNKpLHNg+nQXClpXonvOZdQKj0iwkj81C8tgs
 JA/MQti1gJFlFaNYakFxbnpqsVGBMTyyk/NzNzGCU6mW+w7GGW8/6B1iZOJgPMQowcGsJML7
 Tv5bihBvSmJlVWpRfnxRaU5q8SFGU2BQT2SWEk3OBybzvJJ4QxNLAxMzM0NzI1MDcyVx3nut
 c1OEBNITS1KzU1MLUotg+pg4OKUamBru7zpnw+jb9+3JseWbrdyq2Nf9E8/98jjJcUdiWsuB
 Da3BsqYaVtvc3iptObNwZv5fo6XisVfmWsxK+MrCXSmq3cKh/onx59zsZokVTH82XFYsrs4R
 nzGjrXMZi4/447Pvt82R2bx06YmmUoN7h1N3LY50cE+03eNZqXntX6WZIINYRv2sWVymDXM3
 bJieo+az5bC2XXLUVqMqyZXW5wwf693T/PFskXFc3bRfNx9E1N1wYMuete2F3bWKOR5iHYKc
 vhJnXvE+vjanYmOfzDqdCUGXxL0PLV23/8JZxacp+XcUym5qOok96FBXvija8WaS/8LIp7cu
 3JrjGx9TIaG7xkzlUcep1VP1Y941RSmxFGckGmoxFxUnAgBP/MgQLgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWy7bCSvK535I8Ug0sf2S0uNN5kt1i/aAqL
 xdsXZxktvm3Zxmjxdm8nu8WPrkeMFo8PvWZyYPfYc3oWs8eshl42j9kNF1k8zt7ZwejR/9fA
 4/ZZ3gC2KC6blNSczLLUIn27BK6M1f0bWQquSFT8fHaMrYHxukgXIweHhICJxM1GyS5GLg4h
 gd2MEqs/v2bpYuQEistKPHu3gx3CFpa433KEFaLoGaPE/W/NYAk2AX2Jlx3bwBIiAnsYJda0
 HwTrZhbIk5j1bDUzRMdlRond1/eBdXAKuEtM/veJDcQWFgiUmH7sDFgDi4CKxInd68FqeAUs
 JRZcXM8IYQtKnJz5hAXkVGYBPYm2jYwQ8+Ultr+dwwxxnYLEz6fLWEFsEQEnidNvD0LViEu8
 PHqEHeab7p09bDDf3H3wkn0Co+gsJBtmIWyYhWTDLCSTFjCyrGKUTC0ozk3PLTYsMMpLLdcr
 TswtLs1L10vOz93ECI5CLa0djHtWfdA7xMjEwXiIUYKDWUmE9538txQh3pTEyqrUovz4otKc
 1OJDjNIcLErivN9e96YICaQnlqRmp6YWpBbBZJk4OKUamDbl9L2a8/fLqg3zX4r0voraLppz
 OEGnd9l3p8nv5gn+CJziptg4sfZu4OK6mGvXFbZ5Nr/mW+uttfngpH9L5zM5KG0Xy/j3YbvB
 BY0TDE0ChRH3d8WsLGXx1RNleffMrmLXzTmmR73KnhlouH3R41jw3il/Pte/4MfBz06cMZ92
 Ri3D4Ok7JsM1DDvl9H3mX12T3qBzQ7Zw8bxPRnMb7y74cOSJY3fznImz/hce5tza5v2jebFi
 fpX2M33pa24Tt8pnfZQ79X7LigzdxQrmL3JUCjL9rVQT67dfPKUkfid///UYoVWbctim3NIK
 ZmZeahzxuSHfe+eSnQ80dJy3zpseEpFVVvMkTF0jtW+ZvYMSS3FGoqEWc1FxIgA7LcRvMQMA
 AA==
X-CMS-MailID: 20230906104947epcas2p34e80a7969f56cfb5490fded66d8a1a66
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230906100824epcas2p4c31730acb8655079c99cb5c07d959659
References: <20230906100803.79812-1-heinrich.schuchardt@canonical.com>
 <CGME20230906100824epcas2p4c31730acb8655079c99cb5c07d959659@epcas2p4.samsung.com>
 <20230906100803.79812-3-heinrich.schuchardt@canonical.com>
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

> -----Original Message-----
> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Sent: Wednesday, September 6, 2023 7:08 PM
> To: Rick Chen <rick@andestech.com>; Leo <ycliang@andestech.com>; Yanhong
> Wang <yanhong.wang@starfivetech.com>
> Cc: Simon Glass <sjg@chromium.org>; Marc Kleine-Budde
<mkl@pengutronix.de>;
> Chanho Park <chanho61.park@samsung.com>; u-boot@lists.denx.de; Heinrich
> Schuchardt <heinrich.schuchardt@canonical.com>
> Subject: [PATCH 2/2] riscv: dts: starfive: generate u-boot-
> spl.bin.normal.out
> 
> The StarFive VisionFive 2 board cannot load spl/u-boot-spl.bin but needs a
> prefixed header. We have referring to a vendor tool (spl_tool) for this
> task. 'mkimage -T sfspl' can generate the prefixed file.
> 
> Use binman to invoke mkimage for the generation of file
> spl/u-boot-spl.bin.normal.out.
> 
> Update the documentation.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Tested-by: Chanho Park <chanho61.park@samsung.com>

Best Regards,
Chanho Park

> ---
>  .../dts/jh7110-starfive-visionfive-2-u-boot.dtsi   | 10 ++++++++++
>  doc/board/starfive/visionfive2.rst                 | 14 ++------------
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
> b/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
> index 13f69da31e..defe2b605f 100644
> --- a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
> +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
> @@ -103,4 +103,14 @@
>  			};
>  		};
>  	};
> +	u-boot-spl {
> +		filename = "spl/u-boot-spl.bin.normal.out";
> +
> +		mkimage {
> +			args = "-T sfspl";
> +			blob {
> +				filename = "spl/u-boot-spl.bin";
> +			};
> +		};
> +	};
>  };
> diff --git a/doc/board/starfive/visionfive2.rst
> b/doc/board/starfive/visionfive2.rst
> index 941899a0a4..f5575ab68b 100644
> --- a/doc/board/starfive/visionfive2.rst
> +++ b/doc/board/starfive/visionfive2.rst
> @@ -65,18 +65,8 @@ Now build the U-Boot SPL and U-Boot proper
>  	make starfive_visionfive2_defconfig
>  	make
> OPENSBI=$(opensbi_dir)/opensbi/build/platform/generic/firmware/fw_dynamic.
> bin
> 
> -This will generate spl/u-boot-spl.bin and FIT image (u-boot.itb)
> -
> -u-boot-spl.bin cannot be used directly on StarFive VisionFive2,we need
> -to convert the u-boot-spl.bin to u-boot-spl.bin.normal.out with
> -the below command:
> -
> -	./spl_tool -c -f $(Uboot_PATH)/spl/u-boot-spl.bin
> -
> -More detailed description of spl_tool,please refer spl_tool documenation.
> -(Note: spl_tool git repo is at
> https://protect2.fireeye.com/v1/url?k=501ce742-3197f262-501d6c0d-
> 74fe485fb347-9a3f03c95f77a084&q=1&e=490deaec-ec5a-4b0d-a03c-
> def31f4b19ad&u=https%3A%2F%2Fgithub.com%2Fstarfive-
> tech%2FTools%2Ftree%2Fmaster%2Fspl_tool)
> -
> -This will generate u-boot-spl.bin.normal.out file.
> +This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out)
> as well
> +as the FIT image (u-boot.itb) with OpenSBI and U-Boot.
> 
>  Flashing
>  ~~~~~~~~
> --
> 2.40.1


