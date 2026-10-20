Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D17606A31F
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 05:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=czgdArNy
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 621B280D9E;
	Tue, 20 Oct 2026 05:49:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dS77XNQN5LEZ; Tue, 20 Oct 2026 05:49:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8D88980DA5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792475348;
	b=Su7LmHVtQH3VoqmNI05B5BrYgo1dOPyBYbdhZApNB/ZXX+wx3bhq1yVEXvygVzU3zbEZ
	 MMQ5rBZomEGBMZ/ETpEdZUpr+v5oGRMyuGOBbI1gtoUAW7o0I36U8H+9GE0tx7noQrSZJ
	 E5o5WeVyy5hMj3agtna0PISbY8EaSrW6UkV82iOziik8ViHrk3G5IVZa+Bd/Be9/MbL3s
	 aEaj8hpG3c/Hp5s/NuG9anqGKpO+KnouDb5JachKOLZsFm6afvCW61CW3RPX9/wdWNEke
	 HJ7FwlVa0v2sAmt56A/s+J5m7AXG1rcbfqgfM4iu3HWl9fRJsKM+yy4kGwURVvw93lQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792475348;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Virus-Scanned:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9THBw6Z4y5G7opsN3PHib7Ps5S6hvaHKwMkx9KQkhGo=;
	b=huCmvzalMEITK8yOSofW+2JCKOWOfaqZrb5e9USjIO1aLi43JMj6a1I/8qrHjEpRqzAa
	 oYV4ZJV4Mt3WSq8bzsULzj+zp+qNCHKShd3vyIRVZtC66+F6zMOkNPDtHlnuEXokOPTyG
	 AioERNTSppDE9QR/S3fOdsukvrYOMj9TzGOAiwlciUOOcD7/LaZhnDgtIGErvbzmHDBXH
	 Bb78Qn0YH01+W/S2kh2FNJKLS6oh+Df1UKkimiCBWZThbuJmGX7G5Geog+6RoDlFElBd2
	 ygslNvw1w47KlEHZiLzbXePZjSVZfCK+CvkuFVJntyirW092r7xrdzp7Zpz4H/Aj5LQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792475348;
	bh=9THBw6Z4y5G7opsN3PHib7Ps5S6hvaHKwMkx9KQkhGo=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=czgdArNy/V7IBSJtwMzuM2RWqIn43VnMhdr4ihQMUfOWCjTID4wSkY7uFoRC2su2t
	 28Xq5syBYk4eZZJPbKhKtcF07WaaOntu5CNibjO6W9w/P2Q4H0CdH0Su5MPH7bKuSQ
	 8YBDmOerzW00uIXqWu6CZ7Fj/YU9aeJ0LpzuE7Sj0w2j/MTbhO5WlFeTOd/5vcqzk5
	 X8OurCVtlX+b6Di9kdowFduGRyHM0qQre1v6S64oHUAu7Moa+ZKfCC8xowLUEzfQ9o
	 UWdzh36GPQUH8dZlXNOcX3SIWjo8OKZQWxyUcaH6xp5A6OUbs0xVzPPFfmu0RTlaHF
	 S9P+s8jjrEF4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D88980DA5;
	Tue, 20 Oct 2026 05:49:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 20A641E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 05:44:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 12A676075D
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 05:44:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7K_gYdUF5LlN for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 05:44:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 15E1B60773
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=92.121.34.13
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792475080;
 b=EW6Qm+6C0bTbwtyODrRMpJBGmLdLHOc5JTgckDpu35aLZKsORe44FLvMPMvszElYUtZ5
 0SMqI93pwoQkVDlTv8v0rqoqdq+wxVyk2MDPvyKGzENQ4UWme0bRwrfM4McZ51DOSq52m
 JobOly6UOhSrztasIRAMrePtSVj7Tt0YY6FW4N7RNM5+kwf82a/rpbcEsyQCJEJRJseEl
 Zq/l9FzogCYotEolS3dei3wrv4skjOdtJ1Gnb3jlPD1fzzZrFrUvVstmVK5gHX6pO3CBu
 bkARbfg+6h2jtZP2s+kJu6x8E3x5VeVlt44J5pYw/QyMmnRSs0IaNc0QrS0SQUugalg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792475080;
 h=Received-SPF:Received:Received:Received:From:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Virus-Scanned;
 bh=9THBw6Z4y5G7opsN3PHib7Ps5S6hvaHKwMkx9KQkhGo=;
 b=VspF3hd0oPcrxf2+3OSRGjlW/lvTMIJ7dtP69+B1AZFQSQCYD6DbSbrpQd4gaap0UDei
 uTwWHxso8hYxTfRr9hjzC9eWV55CL2rdZHRgkl9PFkLM1Rq0x+4X6lqWeqVpLCSlybcgB
 N6ha5h2vTirMkH8EF8YQZB20zKifP2YXCIu8N/EgOcyr+xb1X/kL5AbRWBKVOn2CEjwaA
 Xq8/YbmMj1+TyPdRVk6yoX+WvZcLDtfzJ1ANFD9RV4nePid+fOtX13vu6detHvBPQS3jk
 RIt7WL88t/d9Q2AhFAobFZi5uuG/amvxW6c4FpyHABNC9e9Fg5yCrt4HaahUoAZHkRg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=nxp.com;
 arc=none smtp.remote-ip=92.121.34.13
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=92.121.34.13;
 helo=inva020.nxp.com; envelope-from=qijian.guo@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 15E1B60773
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 05:44:40 +0000 (UTC)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8635C1A0077;
 Tue, 20 Oct 2026 07:34:35 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4FA551A0076;
 Tue, 20 Oct 2026 07:34:35 +0200 (CEST)
Received: from lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com
 (lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com [10.52.9.99])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 5491D1800068;
 Tue, 20 Oct 2026 13:34:33 +0800 (+08)
From: Joseph Guo <qijian.guo@nxp.com>
Subject: [PATCH v2 0/4] Add initial support for FRDM-IMX95-PRO
Date: Tue, 20 Oct 2026 12:25:07 +0900
Message-Id: <20261020-frdm-imx95-pro-v2-0-09b188f16738@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABPf1moC/33MSwrCMBSF4a1IxkbypnHkPqSDPO0dtCmJlErp3
 k0LOpDi8Bz4vwWVkCEUdD0tKIcJCqShDnY+IdeZ4REw+LoRI0xRQhmO2fcY+llLPOaEuRZS2GC
 1JArVaMwhwryD97buDsoz5dfuT3R7PxT/pSaKCY7O6tBYZig3t2EeLy71m/s3aiITngihCPUHk
 TyMPJfCG8KdUc03atd1fQNdbEs5FAEAAA==
X-Change-ID: 20261012-frdm-imx95-pro-39454beb9506
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Johan Jonker <jbx6244@gmail.com>, Primoz Fiser <primoz.fiser@norik.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, Lei Xu <lei.xu@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Simona Toaca <simona.toaca@nxp.com>, 
 Joseph Guo <qijian.guo@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792474473; l=1792;
 i=qijian.guo@nxp.com; s=20250519; h=from:subject:message-id;
 bh=JzwTGneMLcniakxX2gbWKnLjHxMET9phf4a34TGNVEQ=;
 b=FEh3giY3q4KkEN3sKDL7u6a3Fw9xT+jydbvcGVKVGfZWrQS2bQUEry0Ni2L4jleCiZl50GdEN
 KLkJjNCRIymBAVLC5IbUOuWx1d7VG8zrk83b2b3naMX8KhXCUluZugY
X-Developer-Key: i=qijian.guo@nxp.com; a=ed25519;
 pk=VRjOOFhVecTRwBzK4mt/k3JBnHoYfuXKCm9FM+hHQhs=
X-Virus-Scanned: ClamAV using ClamSMTP
X-Mailman-Approved-At: Tue, 20 Oct 2026 05:49:05 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

NXP FRDM-IMX95-PRO is cost-effective with extensive
expansion capabilities based on the i.MX95 19x19 SoC.
It is designed for AI and robotic situation.

Difference with i.MX95 15x15 FRDM:
- Use i.MX95 19x19 package
- Support 2 KEY-M M.2 PCIE
- 10G ETH interface
- Secure Element interface

CI: https://github.com/u-boot/u-boot/pull/1055/checks

Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
---
Changes in v2:
- New patch add to enable remoteproc for i.MX95 15x15 FRDM
- New patch add to remove dropped config for i.MX95
- Refactor duplicate config to imx95_frdm.config
- Link to v1: https://lore.kernel.org/r/20261015-frdm-imx95-pro-v1-0-d354da03ca68@nxp.com

---
Joseph Guo (4):
      imx95_frdm: Enable remoteproc for i.MX95 FRDM
      imx95: Remove container.cfg and imximage.cfg
      imx95_frdm: Kconfig: rename board prompt to imx95_15x15_frdm
      imx: Add FRDM-IMX95-PRO initial support

 arch/arm/dts/imx95-19x19-frdm-pro-u-boot.dtsi      |  65 ++++++++++
 arch/arm/mach-imx/imx9/Kconfig                     |  10 +-
 board/nxp/imx95_frdm/Kconfig                       |   2 +-
 board/nxp/imx95_frdm/MAINTAINERS                   |   1 +
 configs/imx95_15x15_evk_defconfig                  |   2 -
 configs/imx95_15x15_frdm_defconfig                 | 139 +--------------------
 configs/imx95_19x19_frdm_pro_defconfig             |  12 ++
 ...mx95_15x15_frdm_defconfig => imx95_frdm.config} |   9 +-
 doc/board/nxp/imx95_frdm.rst                       |  29 ++++-
 include/configs/imx95_frdm.h                       |   4 +
 10 files changed, 125 insertions(+), 148 deletions(-)
---
base-commit: 5e3b01c8466dbe45cd6a06299f8f4c7e8c1c2363
change-id: 20261012-frdm-imx95-pro-39454beb9506

Best regards,
-- 
Joseph Guo <qijian.guo@nxp.com>

