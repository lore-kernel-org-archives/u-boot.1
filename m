Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E3FC4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 08:21:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD8BA88928;
	Mon, 29 Apr 2024 10:21:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="POzECRLh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2E748892D; Mon, 29 Apr 2024 10:21:11 +0200 (CEST)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 492BB88880
 for <U-Boot@lists.denx.de>; Mon, 29 Apr 2024 10:21:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240429082101epoutp04ec5a2bf32b7693a2075c80edba669520~Ksn3Tr2pT1746017460epoutp04H
 for <U-Boot@lists.denx.de>; Mon, 29 Apr 2024 08:21:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240429082101epoutp04ec5a2bf32b7693a2075c80edba669520~Ksn3Tr2pT1746017460epoutp04H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1714378861;
 bh=IfcNP3wk5i/R5SQ2DAYzyJCrd+1wuLqqiRMubkcfPk0=;
 h=Date:To:Cc:From:Subject:References:From;
 b=POzECRLhcCMbciSmF0dy2FNJQzm/zRCFgte+KouOyz5szCig/g7O5ywdLQvWPYs85
 jKCAtzPhD90Cs4ldE83l7AAb/g2H3T/VoCp2fzyn4Xi4XR7ezLJNQSa3ltW2+ysUzC
 /htFJlRVrAflMdYr9k5bIaMFRyOfM/B+vffY39IM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20240429082101epcas1p43d9a82d4acb27aa7fa57578d349f8e6c~Ksn3J7cJe0340603406epcas1p4G;
 Mon, 29 Apr 2024 08:21:01 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.237]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4VSbrC61Yrz4x9Pr; Mon, 29 Apr
 2024 08:20:59 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 26.A6.19431.B685F266; Mon, 29 Apr 2024 17:20:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20240429082059epcas1p1f35772730ea8c9b8caf558bc360152c2~Ksn1IyOeo1647516475epcas1p1L;
 Mon, 29 Apr 2024 08:20:59 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240429082059epsmtrp146ccbe004891349328ecff7a9346b7a3~Ksn1IGasa1655416554epsmtrp13;
 Mon, 29 Apr 2024 08:20:59 +0000 (GMT)
X-AuditID: b6c32a4c-1d1ff70000004be7-3c-662f586b440c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 81.82.07541.B685F266; Mon, 29 Apr 2024 17:20:59 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20240429082059epsmtip269938af6101d4de452e019c1ae61b9e6~Ksn07SXn_0178101781epsmtip2U;
 Mon, 29 Apr 2024 08:20:59 +0000 (GMT)
Message-ID: <03866810-e652-4668-9e47-7ec88949a855@samsung.com>
Date: Mon, 29 Apr 2024 17:20:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: U-Boot Mailing List <U-Boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Bhargav Raviprakash <bhargav.r@ltts.com>,
 u-kumar1@ti.com, Jae hoon Chung <jh80.chung@gmail.com>
From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [GIT PULL] Please pull u-boot-pmic master
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdljTQDc7Qj/NoP2XlsXm+QeZLS5eWcps
 MXXSZnaLt3s72S2m7Z3B7MDqsXPWXXaPVwdWsXucvbOD0ePrpk2sHsdvbGcKYI3KtslITUxJ
 LVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wB2q6kUJaYUwoUCkgs
 LlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAt0CtOzC0uzUvXy0stsTI0MDAyBSpMyM7YseEWS8Ei
 7oqjv3ezNzB2c3YxcnJICJhIrFlzh7GLkYtDSGAPo8TW+9+YIZxPjBJ//rewQzjfGCX2rH7G
 BtPyZf0eVojEXkaJ08ueQTnvGSWmLGlnBKniFbCTuHJoA1gHi4CqxO6/j9gh4oISJ2c+YQGx
 RQXkJe7fmgEWZxYQl7j1ZD4TiC0ioCfx+OxRsKHMAq2MEj+Pb2QGSbAJ6Ehs/3YcrEhYwEji
 x7W/bBDN8hLb384BO1xC4CW7xKzb36FudZHY/3kNK4QtLPHq+BZ2CFtK4mV/GztEQzOjxNIl
 B1khnB5GiX8N16G6jSX2L50MtI4DaIWmxPpd+hDb+CTefe1hBQlLCPBKdLQJQVSrSFx6/ZIJ
 Zv7dJ/+h9npITOzdBPaxkECsxKFnc9gnMMrPQgqMWUgBMAvJP7MQFi9gZFnFKJVaUJybnpps
 WGCom5daDo/o5PzcTYzgRKnls4Px+/q/eocYmTgYDzFKcDArifBumqOdJsSbklhZlVqUH19U
 mpNafIjRFBgtE5mlRJPzgak6ryTe0MTSwMTMyNjEwtDMUEmc98yVslQhgfTEktTs1NSC1CKY
 PiYOTqkGJg0RjsVrc2afaJue+v753w2pVtZS3JqlW9cc3ewlXL1u+VOd5GdCV3+99lxWd7Tg
 /5TKvlUr8g98Nt9/Js/5qlqyyglms5oHCi+mV+ssCWN+qKqfv0FbeuXUG52dat8zLeX/TP/y
 ouz95NPZXAxSm1a4LYvLeFj0gNeU19HihUOklovw2p0HsvO2FwluvR3MopJ29Zagq2JsY/Tl
 L28Mc1rinXkjlt1fbs80I2iG74XFLjP8U6LmrnHTPln08lSj+FnZmuMLX680qVT8bs8aO18g
 sa37i5lH3EUWkWhzDztPHWn3+PsnGg93GP49X7hYZO40BrH5T2wsnvNcL/m1K7F5t4dS5kGL
 lT3B5anvlFiKMxINtZiLihMB4TjXcB0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWy7bCSvG52hH6aQe8+PovN8w8yW1y8spTZ
 YuqkzewWb/d2sltM2zuD2YHVY+esu+werw6sYvc4e2cHo8fXTZtYPY7f2M4UwBrFZZOSmpNZ
 llqkb5fAlbFjwy2WgkXcFUd/72ZvYOzm7GLk5JAQMJH4sn4PaxcjF4eQwG5GicU7LrBDJKQk
 Pj+dytbFyAFkC0scPlwMUfOWUWLm14VMIDW8AnYSVw5tYAOxWQRUJXb/fcQOEReUODnzCQuI
 LSogL3H/1gywOLOAuMStJ/PBekUE9CQenz0KtphZoJVRYvLBWWAJNgEdie3fjoPZwgJGEj+u
 /QU7gllAXWL9PCGIOfIS29/OYZ7AKDALybpZSFbMQuiYhaRjASPLKkbJ1ILi3PTcZMMCw7zU
 cr3ixNzi0rx0veT83E2M4IDX0tjBeG/+P71DjEwcjIcYJTiYlUR4N83RThPiTUmsrEotyo8v
 Ks1JLT7EKM3BoiTOazhjdoqQQHpiSWp2ampBahFMlomDU6qB6ZDbpvIrGw8eKp0hdWaqeWb4
 4XurGUQD7nK/UlzgP/l1lfzXYP/YbwfubRFIs9f78Vxh+5ysv0WepZwZf/c99lyvPvvqBItp
 nv3GRuxf3bZunVT95m/cmTmHmWZ997/Xui7SL9KVvenooRmNWS3iEc8eOf63KmkXVDKS/8z9
 9YHmGjnjeBu2jBpGhlBlUcvQ43NkOi4lc/qnJkVePDJ/7hKVoguquXPCUlLXKQZFxljnMh/r
 69G9JOpgrcGdcUVT2pnHVEGktPLKsoeqPrz5LwpT66c87Lg96d3arbcX9okx6Z+1uWvkPvVs
 tS5X59HLy9nTZKNbInlNm+dNvqHJ0JOZfjGM3fhhJptH41UlluKMREMt5qLiRAC9rX3W5wIA
 AA==
X-CMS-MailID: 20240429082059epcas1p1f35772730ea8c9b8caf558bc360152c2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240429082059epcas1p1f35772730ea8c9b8caf558bc360152c2
References: <CGME20240429082059epcas1p1f35772730ea8c9b8caf558bc360152c2@epcas1p1.samsung.com>
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
If there is a problem, let me know, plz

Best Regards,
Jaehoon Chung

CI: https://source.denx.de/u-boot/custodians/u-boot-pmic/-/pipelines/20569

The following changes since commit 174ac987655c888017c82df1883c0c2ea0dc2495:

  Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-mmc (2024-04-26 07:39:18 -0600)

are available in the Git repository at:

  git@source.denx.de:u-boot/custodians/u-boot-pmic.git master

for you to fetch changes up to 17fd67aedde714556895a0d39431f482accd0cc3:

  power: pmic: tps65941: Update compatible to aling with kernel DT (2024-04-29 09:20:51 +0900)

----------------------------------------------------------------
Bhargav Raviprakash (5):
      power: tps65941: Add macros of TPS65224 PMIC
      power: pmic: tps65941: Add TI TPS65224 PMIC
      power: regulator: tps65941: Added macros for BUCK ID
      power: regulator: tps65941: use function callbacks for conversion ops
      power: regulator: tps65941: Add TPS65224 PMIC regulator support

Udit Kumar (1):
      power: pmic: tps65941: Update compatible to aling with kernel DT

 drivers/power/pmic/tps65941.c                |   4 +
 drivers/power/regulator/tps65941_regulator.c | 381 ++++++++++++++++++++++++---
 include/power/tps65941.h                     |  30 +++
 3 files changed, 384 insertions(+), 31 deletions(-)
