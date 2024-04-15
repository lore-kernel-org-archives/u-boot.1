Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4B9C00A94
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 09:52:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E9DC88190;
	Mon, 15 Apr 2024 11:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="fHVb39FD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12D20881FE; Mon, 15 Apr 2024 11:52:42 +0200 (CEST)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5860C87D66
 for <U-Boot@lists.denx.de>; Mon, 15 Apr 2024 11:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240415095234epoutp0477567a5b0143acb12e1062f5c949d9ca~Ga1y8PdTQ1344813448epoutp04F
 for <U-Boot@lists.denx.de>; Mon, 15 Apr 2024 09:52:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240415095234epoutp0477567a5b0143acb12e1062f5c949d9ca~Ga1y8PdTQ1344813448epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1713174754;
 bh=ZKg09ILm1BZAt/PRQ0NmX4LO2KbFEJ7nV21quTXocMw=;
 h=Date:To:Cc:From:Subject:References:From;
 b=fHVb39FD4xnY6fzDCLg2nt42CYs6ZUK44J3LGS8QEEemtJH4OCnOBrln7QSoyKPU7
 eHcoWpXz0jN1IxE44X33ypau5cc/rF/DruutvwDRswX9MT7sGSDVSFyWfMiLly+Yyy
 ZfoYSjle6H8Xi8+4p74EoJSOJSmbM+U7FiEHMeFQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20240415095234epcas1p43bc7111bfc52814dc3735764b27d161f~Ga1yt7jZ_0503605036epcas1p4a;
 Mon, 15 Apr 2024 09:52:34 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.237]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4VJ2XJ4Xm2z4x9Q1; Mon, 15 Apr
 2024 09:52:32 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 C1.C4.09662.0E8FC166; Mon, 15 Apr 2024 18:52:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20240415095231epcas1p4106945fe2de51e77e1fd60684c3c83bb~Ga1wWWFgK0503705037epcas1p4T;
 Mon, 15 Apr 2024 09:52:31 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240415095231epsmtrp12af03e2257e6ee3299ef3d7a03a50ccd~Ga1wVlpkP2511725117epsmtrp1o;
 Mon, 15 Apr 2024 09:52:31 +0000 (GMT)
X-AuditID: b6c32a35-2b3fa700000025be-d3-661cf8e0cac8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 39.4F.08390.FD8FC166; Mon, 15 Apr 2024 18:52:31 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20240415095231epsmtip2bd7266797a49061258deedd72f9a66d4~Ga1v43oSs2041920419epsmtip2U;
 Mon, 15 Apr 2024 09:52:31 +0000 (GMT)
Message-ID: <6b1625a6-c5b8-4f18-8e3b-0e268936ae4b@samsung.com>
Date: Mon, 15 Apr 2024 18:52:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: U-Boot Mailing List <U-Boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>, Linus Walleij <linus.walleij@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Yang Xiwen
 <forbidden405@outlook.com>, Jaehoon Chung <jh80.chung@samsung.com>
From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [GIT PULL] Please pull u-boot-mmc master
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmnu6DHzJpBi1T5Cz+3dzDbnHjVxur
 xck3V1kspvxZzmTRuvIOm8XUSZvZLd7u7WS3ODz1A6MDh8eHj3Eerw6sYvc4MeESk8eda3vY
 PM7e2cHosXP2PiaPza9fMHv0bVnFGMARlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhr
 aGlhrqSQl5ibaqvk4hOg65aZA3SakkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafA
 tECvODG3uDQvXS8vtcTK0MDAyBSoMCE74/rlTywFr8QqVk14xdLA+F6wi5GDQ0LAROLkYpEu
 Ri4OIYEdjBJXrjSxdDFyAjmfGCVWTuaBSHxjlDh3aC4zSAKkYdqxXjaIor2MEvt3GkHY7xkl
 1uwIA7F5Bewk1jy+wgKygEVAVeLtbWaIsKDEyZlPwOaLCshL3L81gx3EZhYQl7j1ZD4TiC0i
 oCfx+OxRVpC9zAKzmCS23/sFtotNQEdi+7fjYEXCAoYSj2+eYIVolpfY/nYOM0iDhMBMDokt
 LTNYIA51kXi8egPU0cISr45vYYewpSRe9rexQzQ0M0osXXKQFcLpYZT413CdDaLKWGL/0slM
 IC8wC2hKrN+lD7GNT+Ld1x5WSNDxSnS0CUFUq0hcev2SCWb+3Sf/WSFsD4mufzPByoUEYiUu
 LeKcwCg/CyksZiH5fxaSd2Yh7F3AyLKKUSy1oDg3PbXYsMAQHr3J+bmbGMHpVMt0B+PEtx/0
 DjEycTAeYpTgYFYS4b0mJ5kmxJuSWFmVWpQfX1Sak1p8iNEUGCETmaVEk/OBCT2vJN7QxNLA
 xMzI2MTC0MxQSZz3zJWyVCGB9MSS1OzU1ILUIpg+Jg5OqQammZ8bF3bP+3HOpEPYM+8Xj8UH
 G8m6l/fLz6xextW6+ZdLWv/bfyyFd5QZ2bPL0j055svG7Tlm/VzecT2HZpvr+jDXnBOWvbeX
 2Px5y+bg/3fOvk7ZiCS9JHuHxjaxbKH/ay8fUArOPC5QWZ1Xd4p/3sXiDZ//mC3a783iH7ly
 IbNZ0653Zmuu/omf+/nLym9Sl/vzP1l9cZv6JOFpUsSmjaIGi9P5b2q2++f1rXtvu+lcWZn5
 rOdb5Ot/fXmx6WrB7Lw3v90OxMsU7l9ociLV93r1vbef72ndqD4SWrR84cutwUnf+2ut2482
 qC2vK1b9qZLLwyg6S1ZpyjvHaM9HVa0nkqVX/3eXKPi12UtPiaU4I9FQi7moOBEASQ8mwjAE
 AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSvO79HzJpBv9vSlj8u7mH3eLGrzZW
 i5NvrrJYTPmznMmideUdNoupkzazW7zd28lucXjqB0YHDo8PH+M8Xh1Yxe5xYsIlJo871/aw
 eZy9s4PRY+fsfUwem1+/YPbo27KKMYAjissmJTUnsyy1SN8ugSvj+uVPLAWvxCpWTXjF0sD4
 XrCLkZNDQsBEYtqxXrYuRi4OIYHdjBL37z5ng0hISXx+OhXI5gCyhSUOHy6GqHnLKPFk5Uwm
 kBpeATuJNY+vsIDUsAioSry9zQwRFpQ4OfMJC4gtKiAvcf/WDHYQm1lAXOLWk/lgrSICehKP
 zx5lBZnJLDCLSWLml4WMIAk2AR2J7d+OgxUJCxhKPL55ghVkPrOAusT6eUIQc+Qltr+dwzyB
 UWAWknWzkKyYhdAxC0nHAkaWVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwZGipbWD
 cc+qD3qHGJk4GA8xSnAwK4nwXpOTTBPiTUmsrEotyo8vKs1JLT7EKM3BoiTO++11b4qQQHpi
 SWp2ampBahFMlomDU6qByWXarl079d+kCoYH2XFVsM1IELvue+xh/C3xJWtnrD8X+8fU6Oqt
 b37Kaz/nPHtlGP5nyqolYZvm/6tfHKm5cNKRpVvbc9J+pK5f/VD7RbVPoX7yjceOpwz/PzQX
 PbE84lzm5fv1whyTJKeZhBavezPXrPjL2+/cVvO14rdZxQns5Hp2Vlnl5WRdxtWsv9g4C04e
 fKzW9eFLlfQtzcsT5yYtjfi3W1x8vpXQzd0X9Wfv2XMxIOmDcJLt56a0q5mXczavnXT9caR4
 atYm9stPb65Nf5RVsTO4Y43vtqSbdqcWVyvEh7KU37+cFzrZK2j/9rD68GU5s37JCFlMU7gU
 fMbqmt6OP9euPTny/uvEwvOLlViKMxINtZiLihMBOe1slAMDAAA=
X-CMS-MailID: 20240415095231epcas1p4106945fe2de51e77e1fd60684c3c83bb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240415095231epcas1p4106945fe2de51e77e1fd60684c3c83bb
References: <CGME20240415095231epcas1p4106945fe2de51e77e1fd60684c3c83bb@epcas1p4.samsung.com>
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

BTW, I'm checking other pending patches in more detail.
After checking, I will apply them into u-boot-mmc. Sorry for too late.

Best Regards,
Jaehoon Chung

CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/20345

The following changes since commit b03b49046af5dfca599d2ce8f0aafed89b97aa91:

  Merge https://source.denx.de/u-boot/custodians/u-boot-usb (2024-04-14 15:58:31 -0600)

are available in the Git repository at:

  git@source.denx.de:u-boot/custodians/u-boot-mmc.git master

for you to fetch changes up to 3657ef738ad6aa2c32c569e7ae67a5557343f7d0:

  mmc: cv1800b_sdhci: Remove the unused argument (2024-04-15 17:58:59 +0900)

----------------------------------------------------------------
Heinrich Schuchardt (2):
      mmc: Avoid buffer overrun in mmc_startup()
      mmc: Don't suggest to build modules in Kconfig.

Jaehoon Chung (1):
      mmc: cv1800b_sdhci: Remove the unused argument

Jonas Karlman (1):
      mmc: Add SPL_MMC_PWRSEQ to fix link issue when building SPL

Linus Walleij (1):
      mmc: arm_pl180_mmci: Rely on DM

Marek Vasut (7):
      mmc: Drop unused mmc_send_tuning() cmd_error parameter
      mmc: tmio: Check INFO1 for completion during DMA transfer
      mmc: renesas-sdhi: Stop transmission in case tuning block transfer fails
      mmc: Convert hs400_tuning flag from u8 to bool
      mmc: Add generic tuning flag
      mmc: renesas-sdhi: Do not access SCC during tuning in send_cmd callback
      mmc: Unconditionally call mmc_deinit()

Yang Xiwen (3):
      mmc: hi6220-dwmmc: handle clocks and resets if CONFIG_CLK and CONFIG_DM_RESET enabled
      mmc: dw_mmc: Don't return error if data busy timeout
      mmc: hi6220_dw_mmc: add fifoth_val to private data and set it in .probe

 drivers/mmc/Kconfig           | 23 +++++++++-----
 drivers/mmc/Makefile          |  2 +-
 drivers/mmc/am654_sdhci.c     |  2 +-
 drivers/mmc/arm_pl180_mmci.c  | 66 ++-------------------------------------
 drivers/mmc/cv1800b_sdhci.c   |  2 +-
 drivers/mmc/dw_mmc.c          |  4 +--
 drivers/mmc/fsl_esdhc.c       |  2 +-
 drivers/mmc/fsl_esdhc_imx.c   |  2 +-
 drivers/mmc/hi6220_dw_mmc.c   | 72 +++++++++++++++++++++++++++++++++++++++++--
 drivers/mmc/meson_gx_mmc.c    |  2 +-
 drivers/mmc/mmc-uclass.c      | 21 +++++--------
 drivers/mmc/mmc.c             | 38 +++++++++++++++++------
 drivers/mmc/mtk-sd.c          | 21 ++++++-------
 drivers/mmc/octeontx_hsmmc.c  |  8 ++++-
 drivers/mmc/omap_hsmmc.c      |  6 ++--
 drivers/mmc/renesas-sdhi.c    | 21 +++++++------
 drivers/mmc/rockchip_dw_mmc.c |  2 +-
 drivers/mmc/sdhci-cadence.c   |  2 +-
 drivers/mmc/tmio-common.c     |  8 ++++-
 include/mmc.h                 |  9 +++---
 20 files changed, 179 insertions(+), 134 deletions(-)
