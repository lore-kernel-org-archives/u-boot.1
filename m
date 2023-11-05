Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18065C4332F
	for <u-boot@archiver.kernel.org>; Sun,  5 Nov 2023 23:15:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A29386F80;
	Mon,  6 Nov 2023 00:14:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="aRgs/uU4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA03986F5C; Mon,  6 Nov 2023 00:14:06 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC9AB86ED0
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 00:13:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20231105231341epoutp04504727c915ec800d0615f09b1fc51964~U3RBSosPb1396013960epoutp04_
 for <u-boot@lists.denx.de>; Sun,  5 Nov 2023 23:13:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20231105231341epoutp04504727c915ec800d0615f09b1fc51964~U3RBSosPb1396013960epoutp04_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1699226021;
 bh=Id3da9pau+YH9iyK2xQz3oqM+fZ9tHfx8FM1DnA3h+Q=;
 h=From:To:Cc:Subject:Date:References:From;
 b=aRgs/uU4H0+PJ7zmUdjKhLBWAtBXNr7+Iz81apOzPHKjrQnZFOTvwnsXUoyhDBzjK
 kJ1lI6jpmlQYxvG72Mrx6uxXRNb9ZzXqR6R1mK5DqBaWhwVZH6fDHFjus9zt7ubszj
 91rEkXIJjN8YGS4+RB5dXBqtof6IK70JGmdJ7tdI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20231105231341epcas2p30c7e67007a8981ba4d6967f0427ab9a2~U3RBDq0Xf0622506225epcas2p3T;
 Sun,  5 Nov 2023 23:13:41 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.98]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4SNqzT085lz4x9Q0; Sun,  5 Nov
 2023 23:13:41 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 8A.2E.09622.4A128456; Mon,  6 Nov 2023 08:13:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20231105231340epcas2p15c63b4e97f2c2981a7552f313a28d1de~U3RAc6nFl2027920279epcas2p1a;
 Sun,  5 Nov 2023 23:13:40 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231105231340epsmtrp2e202b277ed7fa7845fe90d10b073153d~U3RAcJrKS1816118161epsmtrp2C;
 Sun,  5 Nov 2023 23:13:40 +0000 (GMT)
X-AuditID: b6c32a46-d61ff70000002596-5f-654821a484d3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 97.9B.08817.4A128456; Mon,  6 Nov 2023 08:13:40 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20231105231340epsmtip223b62071fbd08543020c10f28139f60c~U3RAI18E61111811118epsmtip2Q;
 Sun,  5 Nov 2023 23:13:40 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, Stefan
 Roese <sr@denx.de>, Yanhong Wang <yanhong.wang@starfivetech.com>, Xingyu Wu
 <xingyu.wu@starfivetech.com>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH 0/4] Support StarFive Watchdog driver
Date: Mon,  6 Nov 2023 08:13:14 +0900
Message-Id: <20231105231318.992857-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmqe4SRY9Ug8e91haX92tbvH1xltHi
 5LoPTBZv93ayWyyccZbJ4kfXI0aLx4deMzmwe+w5PYvZY96sEyweZ+/sYPTo27KK0eP2Wd4A
 1qhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygK5QU
 yhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BeYFesWJucWleel6eaklVoYGBkamQIUJ
 2Rnf1x9jLZjDUTHl7UzWBsZNbF2MnBwSAiYS2w4fZuxi5OIQEtjBKDFv4XsWCOcTo8SR7o8s
 IFVCAt8YJU632MB0dO1/yApRtJdR4tPUj1Dt05gkNlzfyghSxSagK7Hl+SswW0TgFKPEukvK
 IDazgLZE5+cp7CC2sICpxLzXP8FsFgFViX9LuphBbF4Be4nVa44ydTFyAG2Tl1j8QAIiLChx
 cuYTFogx8hLNW2czg+yVEDjFLjHt6zNmiHoXieNroiAOFZZ4dXwLO4QtJfH53V42iJJyiR3L
 kiBaWxglmtv2MEPU2Ev8uDmFFaSGWUBTYv0ufYhyZYkjt6C28kl0HP7LDhHmlehoE4JoVJc4
 sH06C4QtK9E95zMrhO0hsfDKQlZICMZKHDj/jHkCo/wsJL/MQvLLLIS9CxiZVzGKpRYU56an
 FhsVGMFjNDk/dxMjOBVque1gnPL2g94hRiYOxkOMEhzMSiK8jt4uqUK8KYmVValF+fFFpTmp
 xYcYTYGBO5FZSjQ5H5iM80riDU0sDUzMzAzNjUwNzJXEee+1zk0REkhPLEnNTk0tSC2C6WPi
 4JRqYBK+1n+N6dffIs/vJjumXeyw3Vj7f80S548pFewaxt2h2fe/OSRxp7ac4P6avCsxLrQ2
 cXen8zXmgBlB0/wbHy+6zdPm/PwgY9Hrc1eC7exYazaFG5414MleUuzyti7mXsRFqXiGTxZK
 MfHdVjbqt28JHGXRWiGsZfTj+3uRoJ+RrJozrjqcZUqyUL3yacExrq9LWhdHr+HunPZj+V9+
 i+IdBgurdiZ4JaRd2X3mK8fno7mRCxLOliUWvW7tOjc1Ly25tXtq9ctw2+2JJQ1nj01KkLz2
 d/Xllcz6y59qmNdyzN9j/qdGSd6sxeDSn9jpqjv51kytr165RO7yHH/++sW6Mfcd7W1Wv+u8
 0xayRomlOCPRUIu5qDgRAC02jU8OBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHLMWRmVeSWpSXmKPExsWy7bCSvO4SRY9Ug82TFSwu79e2ePviLKPF
 yXUfmCze7u1kt1g44yyTxY+uR4wWjw+9ZnJg99hzehazx7xZJ1g8zt7ZwejRt2UVo8fts7wB
 rFFcNimpOZllqUX6dglcGd/XH2MtmMNRMeXtTNYGxk1sXYycHBICJhJd+x+ydjFycQgJ7GaU
 mLBkCitEQlbi2bsd7BC2sMT9liNQRZOYJLr2TGEESbAJ6Epsef6KESQhInABqHvHLLAEs4C2
 ROfnKWDdwgKmEvNe/wSzWQRUJf4t6WIGsXkF7CVWrznK1MXIAbRBXmLxAwmIsKDEyZlPWCDG
 yEs0b53NPIGRbxaS1CwkqQWMTKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYKDVEtr
 B+OeVR/0DjEycTAeYpTgYFYS4XX0dkkV4k1JrKxKLcqPLyrNSS0+xCjNwaIkzvvtdW+KkEB6
 YklqdmpqQWoRTJaJg1OqgensfcGNU5nj1QN2LmpImW7w2bLSf+tNhhyzF/vjim6c4/7rcjOn
 Ti+vlL0hYWmko/GEy/E/gipW2WSli/59vr6+Knz9fzZFU99J3zeYNorp/pP5y1+k8D3trP6T
 C/GGH5RK1+7NEc7KXr/HautNNYYTLceapF+tZPe1XSIddIjxudxijzksG+1/qbcf5lDxbVQt
 /SO0/r255VbTqE8Rr+ceuOKVwONRvyxGRl6znS3aQ73//4I/HJN5nhznrn7KPWNC07Ek0XCJ
 ioIdG3qb3E1nvvA4tf9fv9fmU5c2td5PlblR23OI7c+OPUlWPFcSH11srCpr+nZSa8aUk9U9
 3uXWliWbn2kKfzcXWRTvpcRSnJFoqMVcVJwIAF8qA5LBAgAA
X-CMS-MailID: 20231105231340epcas2p15c63b4e97f2c2981a7552f313a28d1de
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231105231340epcas2p15c63b4e97f2c2981a7552f313a28d1de
References: <CGME20231105231340epcas2p15c63b4e97f2c2981a7552f313a28d1de@epcas2p1.samsung.com>
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

This patchset adds to support StarFive Watchdog driver which is based on
Linux kernel's starfive-wdt driver. Actually, the original driver supports
both JH7100 and JH7110 with variant coding but this removes the JH7100
part of codes because JH7100 isn't supported in u-boot yet.
However, this patch tries to keep the variant coding style for future
work of JH7100 and have a consistency with the Linux driver.

Chanho Park (4):
  clk: starfive: jh7110: Add watchdog clocks
  watchdog: Add StarFive Watchdog driver
  riscv: dts: jh7110: Add watchdog device tree node
  configs: visionfive2: Enable watchdog driver

 arch/riscv/dts/jh7110.dtsi             |  10 +
 configs/starfive_visionfive2_defconfig |   5 +
 drivers/clk/starfive/clk-jh7110.c      |   9 +
 drivers/watchdog/Kconfig               |   7 +
 drivers/watchdog/Makefile              |   1 +
 drivers/watchdog/starfive_wdt.c        | 329 +++++++++++++++++++++++++
 6 files changed, 361 insertions(+)
 create mode 100644 drivers/watchdog/starfive_wdt.c

-- 
2.39.2

