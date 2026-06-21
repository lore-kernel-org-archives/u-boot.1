Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345D4CD98F2
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 19:02:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6683D84119;
	Sun, 21 Jun 2026 21:02:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ldg2EpVx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9709684874; Sun, 21 Jun 2026 18:46:58 +0200 (CEST)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7688B84119
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 18:46:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xerikasxx@gmail.com
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-663167a3ba2so1003639d50.3
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 09:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782060415; x=1782665215; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wIlVtGJc8JlGYAVEu+OUtU9CR/Mw5qxNZKTimn+QsLk=;
 b=ldg2EpVxiP48iax/yOhn1T8opj4reMJ5SckPEdXLcowsOe3BiIii9a5RdRz2hjgmJy
 04cM7AQ4PuEaNi7JKnVh/nFkB9SnF/XZ1X5UT+Ot1/aRm1ZC0ORBawvxTzLZp91FCG/5
 8M4iZgNijQEc08ZFrkKLb0bcmfQpF9cKJMIBTU562+BbwXe6sytlY+DnsFjKT0Szrr9g
 sY/44qeIp0V+SvPei85C8zyFv6ejUBGrv0K7gFV2MVZVPS3U1Hc5raJp0dLiGHTYyfIB
 VV3NeIy/2tOZll+octW8pcNlc/Pi2ciUZ9osqV24I0qWBSRl/MRR1mQSDl4iBxyd9QCS
 ZiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782060415; x=1782665215;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wIlVtGJc8JlGYAVEu+OUtU9CR/Mw5qxNZKTimn+QsLk=;
 b=nzSjSyO5BsOTPbtLEaUA7vpVc8oZt86yrr9Ei/0lS5m1u178CdxNEcE8b6gTgQHh8b
 //rtLpDHX4/QM5/QXgltCKgH5QeWHTsBJx8PIXarYE+/NXn3wKylEC7jPNyfQCJW7YEc
 HxNoQ9XWxm7CKty6UGZEXTdLlsmIgWfGJWTXBBATXQuAsoa6+I4+v1z2MMutFXih15+K
 NYkQ3BdZ28VUHLXXBXSJpZLSdXG0kNrC0Y97mgURSYjI517F2nQMdQooSztFBislIUT2
 rsKrYWsID1kuFD48w+SDvkKI/S4BP1sKh9LhgT/TMo96aN7tV/x9GibRTrkxD6c2c2oj
 Zk8g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpe+++crZOJ10F8xaTEuzZ6aeQGxrTcCieaB/qX5p29XJPHy3ZNiM4zWJTsJYdSMZBFr1LyjNw=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3e8CpMbPENzc+TqSWVzaIwCIJT497H7855amIzrgOj096ku5F
 pc3x30HLsTszDQLDXVnsqOpeXrt9urP73pkq1SZl9gR4vPYIehyLdQcU
X-Gm-Gg: AfdE7cltJqwMo9wscPFFKQVRiIR+ODDDB5aKytP7HTuyrdLKEXZzBgH7eaS71TfWGwC
 i71vCQkbMyc22kC/yFQCsd4gSiTLFVWABltG6QGjeaQ+/LVT7GchRyHQo3Gz4Zsm6YQ9yrDtjMU
 6cGQ8sERIEg5x0FeL4sCEpFQgGkreAWLhIHwHhzoLUk6DHVpKPcwXUiXMBcFV0Cdh35yCaryVaj
 xhFi12HBRB8rBl8lO3310KxxtVaWtSVjLNNimZQsfnnDMCy0kQYCeo3UWXGd7Ppf2VPV+m54Zt/
 i6qf1uG2IF7aQlZXDMp2gJg2qmqljMt2K6S3yG3tRwJy5qKvKYNEQ/EuziFtN2tCWR3IhVSSzQ5
 pxHfmDvMDQYs4Z8rvri1p8VtK2svLUyicCMN3xfLAAaDfv3yyCSjRSmW7W6Bl/5POa7ipQhLk9f
 68NlATtLmDcJuFTXs=
X-Received: by 2002:a05:690e:4144:b0:660:6780:f3f5 with SMTP id
 956f58d0204a3-662fff65f6amr9904001d50.52.1782060415248; 
 Sun, 21 Jun 2026 09:46:55 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66314d8c3f1sm2498215d50.15.2026.06.21.09.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2026 09:46:54 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Subject: [PATCH 0/4] qcom: Add support for SM7125
Date: Sun, 21 Jun 2026 19:46:20 +0300
Message-Id: <20260621-sm7125-support-v1-0-5ad69a39781a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSQrDMAxA0asYrWOwlKHQq5QsMiitCrGN5ZRCy
 N3jtMu3+H8H5SSscDc7JP6ISvAFWBmYXoN/spW5GMhR5zpCq+sNqbW6xRhSttRi7ZiWhmeEEsX
 Ei3x/w0f/t27jm6d8XeA4To1VZ4FyAAAA
X-Change-ID: 20260621-sm7125-support-25130e2f4ed1
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Vitalii Skorkin <nikroks@mainlining.org>, 
 Biswapriyo Nath <nathbappai@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Danila Tikhonov <danila@jiaxyga.com>, 
 David Wronek <david.wronek@mainlining.org>, 
 Jens Reidel <adrian@mainlining.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Paul Sajna <sajattack@postmarketos.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sun, 21 Jun 2026 21:02:28 +0200
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

This patch series adds support for Qualcomm Snapdragon SM7125 (atoll)
SoC released in 2020. The following components are supported:
- Clocks
- Pinctrl
- UFS
Most of the code for SM7125 is shared with SC7180, hence most commits
are labeled after SC7180.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
Vitalii Skorkin (4):
      clk: qcom: Add driver for SC7180 GCC
      pinctrl: qcom: add SC7180 pinctrl driver
      qcom_defconfig: Enable SC7180 GCC
      phy: qcom-qmp-ufs: Add SC7180 support

 configs/qcom_defconfig                |   1 +
 drivers/clk/qcom/Kconfig              |   8 +
 drivers/clk/qcom/Makefile             |   1 +
 drivers/clk/qcom/clock-sc7180.c       | 273 ++++++++++++++++++++++++++++++++++
 drivers/phy/qcom/phy-qcom-qmp-ufs.c   |   1 +
 drivers/pinctrl/qcom/Kconfig          |   7 +
 drivers/pinctrl/qcom/Makefile         |   1 +
 drivers/pinctrl/qcom/pinctrl-sc7180.c |  95 ++++++++++++
 8 files changed, 387 insertions(+)
---
base-commit: 298d44464dc63a4f3f5489150acd7958f359f9bd
change-id: 20260621-sm7125-support-25130e2f4ed1

Best regards,
--  
Erikas Bitovtas <xerikasxx@gmail.com>

