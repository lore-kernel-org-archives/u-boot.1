Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D0BC02180
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 01:53:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C819805C5;
	Tue, 14 Jan 2025 02:53:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="td/wcD24";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A5D4805DA; Tue, 14 Jan 2025 02:53:37 +0100 (CET)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E93EB801F5
 for <U-Boot@lists.denx.de>; Tue, 14 Jan 2025 02:53:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20250114015329epoutp0220891c03278b696f88d7be5927726443~abDuxtxbu0378203782epoutp027
 for <U-Boot@lists.denx.de>; Tue, 14 Jan 2025 01:53:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20250114015329epoutp0220891c03278b696f88d7be5927726443~abDuxtxbu0378203782epoutp027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1736819609;
 bh=9gEo/qGsuPGh4Oo4xvXi1e4r7o/FoI1zUXWf0p7yDWM=;
 h=Date:To:Cc:From:Subject:References:From;
 b=td/wcD24FZNwJmHdAn82MCXocE7bBpplXA6aoNaiuvxm1uO52yap9SLwwRS4kbdqa
 kThXaexKCQox8xq1HvHiWcIoNG8w0qWnVPzf6616XaL0xXOXzYVtY6D4Jl0JQA4xL1
 npt7S6PWPO3cEI61ldkwyjyTHaT+0m+bL9J2zWtQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20250114015329epcas1p218d6412a975c6eb456bc320c01b91307~abDuM8qoj1375113751epcas1p2I;
 Tue, 14 Jan 2025 01:53:29 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.237]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4YXBx36q2pz4x9Px; Tue, 14 Jan
 2025 01:53:27 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 E9.D7.31735.593C5876; Tue, 14 Jan 2025 10:53:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20250114015324epcas1p4c2c83151f7110658531d7ac9c5222630~abDp-FJQn2231622316epcas1p4U;
 Tue, 14 Jan 2025 01:53:24 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20250114015324epsmtrp163689c975505316fcf9988a912efccdd~abDp_c7YE1212812128epsmtrp1X;
 Tue, 14 Jan 2025 01:53:24 +0000 (GMT)
X-AuditID: b6c32a4c-ac3ff70000007bf7-15-6785c395fbc4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 73.AA.18949.493C5876; Tue, 14 Jan 2025 10:53:24 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20250114015323epsmtip1bf378f366ad00c37ed035ac81c89b193~abDpNmg-H3221032210epsmtip1C;
 Tue, 14 Jan 2025 01:53:23 +0000 (GMT)
Message-ID: <302404b9-bd4a-4797-9b50-012b68ecf170@samsung.com>
Date: Tue, 14 Jan 2025 10:53:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: U-Boot Mailing List <U-Boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, s-ramamoorthy@ti.com, u-kumar1@ti.com,
 Jaehoon Chung <jh80.chung@samsung.com>
From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [GIT PULL] Please pull u-boot-pmic master
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdlhTV3fq4dZ0g18NvBY3frWxWvw6tJ7Z
 YuqkzewWb/d2sltM2zuD2YHV49WBVeweZ+/sYPTo27KK0eP4je1MASxR2TYZqYkpqUUKqXnJ
 +SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QIuVFMoSc0qBQgGJxcVK+nY2
 RfmlJakKGfnFJbZKqQUpOQWmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZMx+9Zy24wlmx+mhW
 A+MH9i5GTg4JAROJT/8vsYLYQgJ7GCW2r2TpYuQCsj8xSpz6eJsdwvnGKPHm5y1GmI4dn2+x
 QST2Mkq0fnvACOG8Z5TY0rSGGaSKV8BOYvmhTWA7WARUJX60/IKKC0qcnPmEBcQWFZCXuH9r
 BlgNs4C4xK0n85lAbBEBPYnHZ4+yQsSLJA5MfgVWwyagI7H923GwGmEBI4kf1/6yQdTIS2x/
 O4cZ5AgJgVvsEo2fD0E95yLx7Nt+ZghbWOLV8S1QcSmJl/1t7BANzYwSS5ccZIVwehgl/jVc
 Z4OoMpbYv3Qy0DoOoBWaEut36UNs45N497WHFSQsIcAr0dEmBFGtInHp9UsmmPl3n/xnhbA9
 JLZO2MwICeBYifaVi5kmMMrPQgqLWUj+n4Xkn1kIixcwsqxilEotKM5NT002LDDUzUsth8dy
 cn7uJkZwYtTy2cH4ff1fvUOMTByMhxglOJiVRHiXsLWmC/GmJFZWpRblxxeV5qQWH2I0BcbK
 RGYp0eR8YGrOK4k3NLE0MDEzMjaxMDQzVBLnvbCtJV1IID2xJDU7NbUgtQimj4mDU6qBiUU7
 TU9j9wNnizSN62cUClhZZjU1Pb3e8eG6IO/Un+9tAp+dOcPD9bXGlbv+jnj2yrdXzmY6NLrO
 ONj7bUXYnJB2Y5HHRi+Pp/UXe0pfuWJj86v+VffpZbYc8+/dSF+dHr5liT2r8j433V91v5qZ
 E9/JC95hzliQ/nv9Sdmq2/1ctxbOXlenfuHd7UdH7tZ/nza5fu39uxJybyutPCSWiXgrbpmw
 IOXZv0X394TnqzfNLPtxYoHo8VMRmof6NFdNmLy6XWnuL45fYqsf6XOI8/1+pvbl2qYT6cxT
 dG33Ju0o/nRFnHdZzr3Wg1f77vKvNbgYKjhT3WtZ24wzNfbvZy/SlN/ovPRK/7Tps/LKFjkr
 sRRnJBpqMRcVJwIA+fc8iBUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsWy7bCSnO6Uw63pBh/WaFrc+NXGavHr0Hpm
 i6mTNrNbvN3byW4xbe8MZgdWj1cHVrF7nL2zg9Gjb8sqRo/jN7YzBbBEcdmkpOZklqUW6dsl
 cGXMfPSeteAKZ8Xqo1kNjB/Yuxg5OSQETCR2fL7F1sXIxSEksJtRYufOlawQCSmJz0+nAiU4
 gGxhicOHiyFq3jJK7FswkRGkhlfATmL5oU1gg1gEVCV+tPxihogLSpyc+YQFxBYVkJe4f2sG
 WA2zgLjErSfzmUBsEQE9icdnj7JCxIskTk3dCxZnE9CR2P7tOJgtLGAk8ePaX7AbmAXUJdbP
 E4Iol5fY/nYO8wRGgVlIts1CsmEWQscsJB0LGFlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXr
 JefnbmIEh7iW1g7GPas+6B1iZOJgPMQowcGsJMK7hK01XYg3JbGyKrUoP76oNCe1+BCjNAeL
 kjjvt9e9KUIC6YklqdmpqQWpRTBZJg5OqQYmxbXZM0+9U+tUmCvZEqFXX/12/R+hoqYf5+bf
 mHSgS/GNVmW6frlDei5/1j/xgEN+MjtVlzvXrF+omRqhqCP/50Vr+ZkWh/tK8jM5oqMtwyRU
 Fu+r3DYt0FDgiZieX2yi/Z4zN49ITFpka7l5dt/C+P9xZdoHBD8vWFNkt3LxFrEfcxn8jZrZ
 9k0pnCyUk/bC2ebi5bX5tcFLQpZsUhKqmp6/bkLf4sNH6pWtI5c/13Hyljhc6PlH9vi7x8du
 7n276+uFGhbLhtfOGjuC3vmqm71/yiAocYmlY02K06WYqYHT1d4e3WN+ovHyv4Oh32fc2qF7
 0XHB4s3XDd6GbHIoM+dl2cWswbtL5qVa9zkpJZbijERDLeai4kQAamFsJuACAAA=
X-CMS-MailID: 20250114015324epcas1p4c2c83151f7110658531d7ac9c5222630
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250114015324epcas1p4c2c83151f7110658531d7ac9c5222630
References: <CGME20250114015324epcas1p4c2c83151f7110658531d7ac9c5222630@epcas1p4.samsung.com>
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

Dear Tom,


Please pull u-boot-pmic master into u-boot master branch.
If there is any problem, let me know, plz. Thanks!


Best Regards,
Jaehoon Chung

CI: https://source.denx.de/u-boot/custodians/u-boot-pmic/-/pipelines/24175

The following changes since commit 6a0db9ee030f634731b792d864fc7a9df6cc6b80:

  Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-usb (2025-01-13 08:25:00 -0600)

are available in the Git repository at:

  git@source.denx.de:u-boot/custodians/u-boot-pmic.git master

for you to fetch changes up to b9fe3ec8a235e2f4cb1091dd4b24150313944ccf:

  power: pmic: tps65941: Fix TI TPS65224 PMIC compatiable (2025-01-14 07:44:51 +0900)

----------------------------------------------------------------
Shree Ramamoorthy (2):
      power: regulator: replace printf() with pr_err()
      power: replace magic numbers with macros

Udit Kumar (1):
      power: pmic: tps65941: Fix TI TPS65224 PMIC compatiable

 drivers/power/pmic/tps65941.c                |  2 +-
 drivers/power/regulator/tps65219_regulator.c | 30 ++++++++++++++--------------
 include/power/tps65219.h                     | 14 +++++++++++--
 3 files changed, 28 insertions(+), 18 deletions(-)
