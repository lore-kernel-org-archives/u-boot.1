Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D13CC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 07:56:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77D7D87156;
	Wed,  1 Nov 2023 08:56:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="N7Yst7PO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59F2A87209; Wed,  1 Nov 2023 08:56:42 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A68D8710A
 for <U-Boot@lists.denx.de>; Wed,  1 Nov 2023 08:56:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20231101075633epoutp041dbafb4550c388b9ecdf9fb9909f1335~TcLHB1tjH1434914349epoutp04d
 for <U-Boot@lists.denx.de>; Wed,  1 Nov 2023 07:56:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20231101075633epoutp041dbafb4550c388b9ecdf9fb9909f1335~TcLHB1tjH1434914349epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698825393;
 bh=NXujR0BkPg+y5ac39S36i7opODq4zQCkE4X2GLa3ZiA=;
 h=Date:To:Cc:From:Subject:References:From;
 b=N7Yst7POD6xlKnP0D6maWAAzVsZ4z0klJ9RoO42jizsXai3hzwSjKjN/ChAtknD/2
 K/Q+ZPeZyD+ebXG10KhCNDJXPxfqzN3NhOrWV5NWTQOb2qaxrvU+Z6l/So04Eyzx1k
 0rnPptR+z0Sm1heUbKDQpcxGVtpqN9rzgPg2YfaQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20231101075632epcas1p163487888084ec2839f29a2f28c1c149e~TcLG0hHql2098120981epcas1p1v;
 Wed,  1 Nov 2023 07:56:32 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.232]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4SKzq359KLz4x9Q7; Wed,  1 Nov
 2023 07:56:31 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 C5.9A.19104.FA402456; Wed,  1 Nov 2023 16:56:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20231101075631epcas1p319becae866c164fd73339181486f8f35~TcLFRYf_50853508535epcas1p3L;
 Wed,  1 Nov 2023 07:56:31 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231101075631epsmtrp27b906803566d9cf5f6679e248ae3a25a~TcLFQXbB72061120611epsmtrp22;
 Wed,  1 Nov 2023 07:56:31 +0000 (GMT)
X-AuditID: b6c32a4c-80dff70000004aa0-75-654204af3da0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 00.C5.18939.FA402456; Wed,  1 Nov 2023 16:56:31 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20231101075631epsmtip2b96eaa064fb3778152b183828c4716e0~TcLFBzmsv0208102081epsmtip2j;
 Wed,  1 Nov 2023 07:56:31 +0000 (GMT)
Message-ID: <3ba8e520-989d-4243-b542-b9fb27868332@samsung.com>
Date: Wed, 1 Nov 2023 16:56:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: U-Boot Mailing List <U-Boot@lists.denx.de>
Cc: marex@denx.de, sean.anderson@seco.com, Bin Meng <bmeng@tinylab.org>, Tom
 Rini <trini@konsulko.com>, Oleksandr Suvorov
 <oleksandr.suvorov@foundries.io>, Peng Fan <peng.fan@nxp.com>, Jae hoon
 Chung <jh80.chung@gmail.com>
From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [GIT PULL] Please pull u-boot-mmc master
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmge56FqdUgwc7NSzOT5zOanHxylJm
 izdtjYwWT9/MYLH4seoLq8W8+y1MFlMnbWa3eLu3k92Bw2PerBMsHoeudrJ67Jx1l93j1YFV
 7B5n7+xg9Nj4bgeTx7N/39g99vSeZg3giMq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDU
 NbS0MFdSyEvMTbVVcvEJ0HXLzAG6TUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJT
 YFqgV5yYW1yal66Xl1piZWhgYGQKVJiQnfH/706mgutcFRdetjI1MB7h6GLk5JAQMJG4+f8b
 WxcjF4eQwB5GiVVH/7NDOJ8YJV7N+8gM51w89JAFpqVvxn2oxE5GiZ23jkC1vGeU6HsxnRmk
 ilfATuLW+z52EJtFQEXiUfNURoi4oMTJmU/AJokKyEvcvzUDrIZZQFzi1pP5TCC2iICexOOz
 R1lBhjILPGGUuNt+GCzBJqAjsf3bcTBbWMBQ4vHNE6wQzfIS29/OATtJQqCXQ+L/hvOMELe6
 SHRPOcgEYQtLvDq+hR3ClpL4/G4vG0RDM6PE0iUHWSGcHkaJfw3X2SCqjCX2L50M1M0BtEJT
 Yv0ufYiwosTO33MZITbzSbz72sMKUiIhwCvR0SYEUaIicen1SyaYXXef/GeFsD0k2s4tBIeQ
 kECsxOSn+xknMCrMQgqYWUiBMQvJb7MQjljAyLKKUSq1oDg3PTXZsMBQNy+1HB7pyfm5mxjB
 yVfLZwfj9/V/9Q4xMnEwHmKU4GBWEuE9bOqQKsSbklhZlVqUH19UmpNafIjRFBhFE5mlRJPz
 gek/ryTe0MTSwMTMyNjEwtDMUEmcN+ZTe4qQQHpiSWp2ampBahFMHxMHp1QDk7qIquUena3h
 E5cxGx2oSYruWLNttUVd8m9Hlbsdfzdf31u5PrDrZo7xPNv2Bp1ekZY9zyc9eir4YIXcShYW
 m/S4zZ1vFxiv1F8YKVuzcJv/8pIdrl5Jyvf0/x8q8Fl6MI3jt/akc3PdPlgmpqi90DzYlChj
 WJXNInTw1vl/D/Y3iUb8Xu0dWV/oenQ6x3mdhHnnkoxDV/9fvWpe08HefcvP1ywRyZK/ecfW
 gDc21STOR3yzuejid54X6l8157sZlXx63hbnM/XPCk3BpWVtAcbxjnWtC65Y5Rptq+6bJXPi
 UeQGd60My/hFCoVPNrLHXV3GGlHtteTrnQmXZdlERbeyftbbvNz7tt+O5QyWSizFGYmGWsxF
 xYkAKi0IFkcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWy7bCSvO56FqdUg7/3eSzOT5zOanHxylJm
 izdtjYwWT9/MYLH4seoLq8W8+y1MFlMnbWa3eLu3k92Bw2PerBMsHoeudrJ67Jx1l93j1YFV
 7B5n7+xg9Nj4bgeTx7N/39g99vSeZg3giOKySUnNySxLLdK3S+DK+P93J1PBda6KCy9bmRoY
 j3B0MXJySAiYSPTNuM/cxcjFISSwnVHiys+NLBAJKYnPT6eydTFyANnCEocPF0PUvGWU2Lxi
 PytIDa+AncSt933sIDaLgIrEo+apjBBxQYmTM5+AzREVkJe4f2sGWA2zgLjErSfzmUBsEQE9
 icdnj7JCxJ8wSjy/4g5iswnoSGz/dhysRljAUOLxzROsIDcwC6hLrJ8nBFEuL7H97RzmCYwC
 s5Bsm4VkwyyEjllIOhYwsqxiFE0tKM5Nz00uMNQrTswtLs1L10vOz93ECI4RraAdjMvW/9U7
 xMjEwXiIUYKDWUmE97CpQ6oQb0piZVVqUX58UWlOavEhRmkOFiVxXuWczhQhgfTEktTs1NSC
 1CKYLBMHp1QD04rIy3L9etWv/A7nPj6QyrN0ctozkdB79X7fSoTr7OSPhVzu5938fWXj2sTV
 r5+9nn+vROGSSvAD+4Y94qv4D3QsbJATP6IT+VT63E6Wy7Xm1zhm1U42zYt0WWy5QPPBwmMp
 7xv6S4NvrSy+Iv1YNjz08M5pi3NT/6+bzcjjdqQynkvh5gxnH7WPaySTa634gns2OpV3KNod
 jvRdfrKoa1nF+9D5/48stNaQ+CUTYVco69ZXw//HQjRKS+HABjH/XxFpOrKhgewx9YsEVjvs
 /ar66+YDlUXbE6c83V/EwKr8exOj5a1ZDimF1+54Hui5qnLKXyzo4RGZFIejurYntGqYnzVv
 +7z0/VfFb1ozlViKMxINtZiLihMBahIbZAADAAA=
X-CMS-MailID: 20231101075631epcas1p319becae866c164fd73339181486f8f35
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231101075631epcas1p319becae866c164fd73339181486f8f35
References: <CGME20231101075631epcas1p319becae866c164fd73339181486f8f35@epcas1p3.samsung.com>
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

Please pull u-boot-mmc master into u-boot master branch.
If there is any problem, let me know, plz. 

Best Regards,
Jaehoon Chung

CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/18386

The following changes since commit 62fc66b6d228d628c3f672c736aa57e4174ac783:

  Merge branch '2023-10-31-platform-updates' (2023-10-31 13:08:10 -0400)

are available in the Git repository at:

  git@source.denx.de:u-boot/custodians/u-boot-mmc.git master

for you to fetch changes up to b5f403936d037e0bc08e78b8af64adf53da13b90:

  cmd: mmc: Add mmc reg read command for reading card registers (2023-11-01 10:09:21 +0900)

----------------------------------------------------------------
Bin Meng (1):
      mmc: pci: Drop the superfluous cast

Marek Vasut (1):
      cmd: mmc: Add mmc reg read command for reading card registers

Oleksandr Suvorov (1):
      mmc: spl: select SPL_BLK for SPL_DM_MMC

Sean Anderson (1):
      mmc: sdhci: Rework SDHCI_QUIRK_BROKEN_R1B

 cmd/Kconfig           |  7 ++++
 cmd/mmc.c             | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++
 doc/usage/cmd/mmc.rst | 26 ++++++++++++++
 drivers/mmc/Kconfig   |  1 +
 drivers/mmc/pci_mmc.c |  4 +--
 drivers/mmc/sdhci.c   | 19 ++++++----
 include/sdhci.h       |  1 +
 7 files changed, 145 insertions(+), 9 deletions(-)
