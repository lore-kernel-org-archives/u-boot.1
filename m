Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937CFE7716F
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 02:58:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFFB68938D;
	Thu,  5 Dec 2024 03:58:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="e36F+RrC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06FE78941F; Thu,  5 Dec 2024 03:58:33 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 194A68931F
 for <U-Boot@lists.denx.de>; Thu,  5 Dec 2024 03:58:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20241205025818epoutp04266898463e3a7e13667726921b67ec33~OKI5rCep30717907179epoutp04g
 for <U-Boot@lists.denx.de>; Thu,  5 Dec 2024 02:58:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20241205025818epoutp04266898463e3a7e13667726921b67ec33~OKI5rCep30717907179epoutp04g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1733367498;
 bh=uZHLuAUj+taZFwj8xwfSF2nEc+hB2B+6AA3jZVuDJCE=;
 h=Date:To:Cc:From:Subject:References:From;
 b=e36F+RrCbi0AOK41ct6i23UcPk1jTCmdjCtOtIiNoKoe6eja0GdPe0j/gh5Q2aXFg
 dBoiNCIC0oyVNTm5SKWbduqjLAqKeYlb3NL5ToE+V2dWQacu34XYNMKG9ai4eQDhpj
 T6CCNjGVPuNwd+04FFd9rkYJfjorfLbVC2FMpIuI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20241205025818epcas1p1b9388cebf62c152672bf2f8d6c7cd339~OKI5RuWQo2024720247epcas1p1b;
 Thu,  5 Dec 2024 02:58:18 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.233]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4Y3fGJ6f0Hz4x9Pp; Thu,  5 Dec
 2024 02:58:16 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 61.A9.23869.5C611576; Thu,  5 Dec 2024 11:58:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20241205025813epcas1p48a97abeabb5fa0ca5ae22443963c9117~OKI0d09HG1105511055epcas1p4J;
 Thu,  5 Dec 2024 02:58:13 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20241205025813epsmtrp106fd3897bc5344f8cad8bb6391644921~OKI0dF93I0260502605epsmtrp1l;
 Thu,  5 Dec 2024 02:58:13 +0000 (GMT)
X-AuditID: b6c32a36-6f5e970000005d3d-5b-675116c5ebc0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 F0.E0.33707.4C611576; Thu,  5 Dec 2024 11:58:12 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20241205025812epsmtip24e4e6e83539d7bfd929c2bee9eaf915b~OKI0NbXiy2037520375epsmtip2R;
 Thu,  5 Dec 2024 02:58:12 +0000 (GMT)
Message-ID: <80755d2a-748b-455a-a910-82bde9dd9740@samsung.com>
Date: Thu, 5 Dec 2024 11:58:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: U-Boot Mailing List <U-Boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, patrice.chotard@foss.st.com, Jaehoon
 Chung <jh80.chung@samsung.com>
From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [GIT PULL] Please pull u-boot-pmic master
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmvu5RscB0g87pUhY3frWxWvw8+Z7d
 YuqkzewWb/d2sjuweDzt38ru8erAKnaPs3d2MHr0bVnFGMASlW2TkZqYklqkkJqXnJ+SmZdu
 q+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA7RTSaEsMacUKBSQWFyspG9nU5RfWpKq
 kJFfXGKrlFqQklNgWqBXnJhbXJqXrpeXWmJlaGBgZApUmJCd8XT2LuaCBRwVCy4+YWlgbGbv
 YuTkkBAwkfh/fw+QzcUhJLCDUWJ5838o5xOjxJuDH5jgnA8TNrLCtJx93MwKkdjJKLFr40qo
 lveMEkt33GcEqeIVsJO4eWwySxcjBweLgIpE4w1WiLCgxMmZT1hAbFEBeYn7t2aA3cEsIC5x
 68l8JhBbREBP4vHZo6wQ8QyJhq0PwUayCehIbP92HKxGWMBI4se1v2wQNfIS29/OYQa5QULg
 GLvEjh8rmCEudZHY3g9ztbDEq+NboJ6WknjZ38YO0dAMdPSSg6wQTg+jxL+G62wQVcYS+5dO
 ZgL5gFlAU2L9Ln2IbXwS7772sIKEJQR4JTrahCCqVSQuvX7JBDP/7pP/UCUeEhdWc4KEhQRi
 Jfqu3mSfwCg/CykoZiF5fxaSd2Yh7F3AyLKKUSy1oDg3PbXYsMAIHsPJ+bmbGMFpUMtsB+Ok
 tx/0DjEycTAeYpTgYFYS4Q3SDkgX4k1JrKxKLcqPLyrNSS0+xGgKjI+JzFKiyfnARJxXEm9o
 YmlgYmZkbGJhaGaoJM575kpZqpBAemJJanZqakFqEUwfEwenVAPT6uCSPxPnXTOxaH3NM/XO
 /o/zdpWJ5E9K3Dl5qlLaxyypyHUy7M88/IxMEg0qD52y+1Ib8LCU+83OAwcCreQKJnq+WvOQ
 ZfqK5b6LLF/zLO8pej1R/rbIj6NJvnf2THtnd7DU817Yw69ZW5oknpZp7jR8HsjFYOCSvP6N
 Z1ZQxdqL7DHvK3y86gre6yz9zqd+Ys7H1W1bg+ynMUzp/L3bzXHBzXs7tTnYJ+Xe38Vd4Cl9
 ebblVKfPJVlpSjYq/36whZTu/RtzafvR/Qp3DpYfTwu65GEV7ZEsyV0p+JpxP8tdhSUHlxmF
 TLjW6Nkxd+XVDY9Z25YUmUSsNZr/LqvH47N7ZPuTB/vbLskxnTbYpMRSnJFoqMVcVJwIAOcs
 bzUMBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsWy7bCSvO5RscB0gxVGFjd+tbFa/Dz5nt1i
 6qTN7BZv93ayO7B4PO3fyu7x6sAqdo+zd3YwevRtWcUYwBLFZZOSmpNZllqkb5fAlfF09i7m
 ggUcFQsuPmFpYGxm72Lk5JAQMJE4+7iZFcQWEtjOKDG3gQUiLiXx+elUti5GDiBbWOLw4WKI
 kreMEhfvMYPYvAJ2EjePTWYBKWERUJFovMEKERaUODnzCdgUUQF5ifu3ZoBtYhYQl7j1ZD4T
 iC0ioCfx+OxRVoh4hsSDNzfBatgEdCS2fzsOViMsYCTx49pfsAuYBdQl1s8TgiiXl9j+dg7z
 BEaBWUi2zUKyYRZCxywkHQsYWVYxiqYWFOem5yYXGOoVJ+YWl+al6yXn525iBIeyVtAOxmXr
 /+odYmTiYDzEKMHBrCTCG6QdkC7Em5JYWZValB9fVJqTWnyIUZqDRUmcVzmnM0VIID2xJDU7
 NbUgtQgmy8TBKdXAVHCmpdKStSjnxdmjW4UMpzoWLbYtCnToCcl/fU/h338d+QmK3KKxag6P
 +PVDBbZYOa/8WHRk9oM8Ue5lpxY0Kn9jmVVpvkhn+rnymyv69GJnWn8tU2l49CDX6BlX8yKd
 k0xZm+R2pAb0vtsuN21muXv/exaD6FmXLy32chaIWzLvlKPz5QPfez8p7NsgcCCk/d/T607v
 jRc/msBq6jhJzfB9/qLtcSEfJzkd8A1jX/Uiplbj9/sLi6W/WgRrdwn9uLFwT8JXd53GN4w2
 L1d6vmvfdGfRqsznmVkSa8SeChlwTeGZP8/a62x6yJx+jcrI1+uDC2dPqdTcY5g5aTvLFnf2
 KVvseUx0E5mvPO2xU2Ipzkg01GIuKk4EAIcikkzUAgAA
X-CMS-MailID: 20241205025813epcas1p48a97abeabb5fa0ca5ae22443963c9117
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241205025813epcas1p48a97abeabb5fa0ca5ae22443963c9117
References: <CGME20241205025813epcas1p48a97abeabb5fa0ca5ae22443963c9117@epcas1p4.samsung.com>
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
If there is any problem, let me know, plz

Best Regards,
Jaehoon Chung

CI: https://source.denx.de/u-boot/custodians/u-boot-pmic/-/pipelines/23718

The following changes since commit f96e5133184aac377b54bd61f8abf78710f2ee56:

  Merge branch 'master' of https://gitlab.denx.de/u-boot/custodians/u-boot-samsung (2024-12-03 12:37:20 -0600)

are available in the Git repository at:

  git@source.denx.de:u-boot/custodians/u-boot-pmic.git master

for you to fetch changes up to 74cd1af1124fbe3cd16c58bc3ad9ff1f9c6ecf3e:

  power: regulator: replace dev_dbg() by dev_err() in regulator_post_bind() (2024-12-05 07:31:31 +0900)

----------------------------------------------------------------
Patrice Chotard (2):
      power: regulator: replace some debug() by dev_dbg()
      power: regulator: replace dev_dbg() by dev_err() in regulator_post_bind()

 drivers/power/regulator/regulator-uclass.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)
