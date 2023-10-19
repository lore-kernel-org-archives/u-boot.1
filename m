Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93727CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 14:58:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E27328723E;
	Thu, 19 Oct 2023 16:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cCY5j44W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12E61870AF; Thu, 19 Oct 2023 15:16:23 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ABFD86FEA
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 15:16:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gborowiak@gmail.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-d77ad095f13so8170502276.2
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 06:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697721379; x=1698326179; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jWLqcILW6yEYxjfA/mgWWA1LCDtV/ubO6Ynq9Ca3V70=;
 b=cCY5j44WGe+hlSKVAkuI7aUMt/bhcRec3+ldVH13wxt8o+k155d2Dq8/wEhXXClN/e
 LJkqtRb6g/dIukXVR2jzJ01VFC5/SeSMEayoN3Fwj9Erde2oNNx/AzuDrwVm0yytNS77
 oadOuhwiMTK8FoUvs/MXOK0sEYbyi2h9UAp+NulPFmWDI4kMMkEvsck2xgHvyMxirfBo
 i9JN9cadTrKn1irpgRC2sj51TSa8WB3Xg6wIJoxTksGrQspU2yJBuxTYFVMfwwZO0oAs
 5VKgaZakM5MyNGAEJEubYb+nYmhHw4wpizMgq7vV+bgUloK/MCYM7VbrlPSt4nVI6FT6
 mozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697721379; x=1698326179;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jWLqcILW6yEYxjfA/mgWWA1LCDtV/ubO6Ynq9Ca3V70=;
 b=pHkk5i6tpE7T/rKaQ7TRrXzmlPjdP3mXyQRHK4SfIiuvg1k+qEN7F/a1k7bjwsJAbL
 iKrtk59mEUhGIvh+eVpcP/8crUMJPoqTAOGReUdpbrGptFq7dSmzVei+GttSsUG7Yoc+
 xucN47dIohlabHyXvbBaYvOPbCMSbsvXCvgUYQ1QTgDFdPBD+XuIgOg3TdPowEu1VQbq
 3GgN3knbbSWp68kkcQ49VS6j7n/6i3uchx5+UsRaJOqSVHJu5G9gZw5qEhiPjf1Fkk6h
 GSP3yPnMXG4p0+cts5RfP09ZPJhNmCp1BhelyrSuhgywaWa5XmGRv4tdbQZkcJK86cFt
 46zA==
X-Gm-Message-State: AOJu0YwnKi6MdKrucuuTfwgTFQiw0kyC2QsO7XfFOpXRBQq6hfbjrwyS
 4LslHorZciYS1yOoMZgSp5GJFSyZE+kuxUROTadjGTmmy2go0Q==
X-Google-Smtp-Source: AGHT+IG2IrnlOwYsME/q9GyQlE/0NiMruo47DaUcsfPLCLiPkEhPPQQK91tq1S2mEW146JzcZQuOP6/xRJSMMBjISEE=
X-Received: by 2002:a25:cd47:0:b0:d86:5a8d:6e34 with SMTP id
 d68-20020a25cd47000000b00d865a8d6e34mr2192671ybf.29.1697721379069; Thu, 19
 Oct 2023 06:16:19 -0700 (PDT)
MIME-Version: 1.0
From: Grzegorz Borowiak <gborowiak@gmail.com>
Date: Thu, 19 Oct 2023 15:16:08 +0200
Message-ID: <CAMwbjeWur3uKY0fV89PqdrSB7t_e=3Osot6DAocrhA57PCf_UQ@mail.gmail.com>
Subject: Branches in uboot-imx
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Thu, 19 Oct 2023 16:58:19 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello!

I just cloned the repository:

https://github.com/nxp-imx/uboot-imx

and I encountered a rather large amount of branches (listed below).

Are these branches somehow described, so I could read what they are about?
Especially I'm interested in branches whose names begin with "imx" and
"lf". What are differences between them, and how are they different from
branches here:

https://github.com/u-boot/u-boot

?

imx_4.14.98_8qxpc0_er
imx_5.4.0_8dxlphantom_er
imx_v2017.03_4.9.11_1.0.0_ga
imx_v2017.03_4.9.123_imx8mm_ga
imx_v2017.03_4.9.51_imx8_beta1
imx_v2017.03_4.9.51_imx8_beta2
imx_v2017.03_4.9.51_imx8m_beta
imx_v2017.03_4.9.51_imx8m_ga
imx_v2017.03_4.9.88_2.0.0_ga
imx_v2017.03_4.9.88_imx8mm_alpha
imx_v2017.03_4.9.88_imx8qxp_beta2
imx_v2018.03_4.14.62_1.0.0_beta
imx_v2018.03_4.14.78_1.0.0_ga
imx_v2018.03_4.14.98_2.0.0_ga
imx_v2018.03_4.14.98_2.1.0
imx_v2018.03_4.14.98_2.2.0
imx_v2018.03_4.14.98_2.3.0
imx_v2019.04_4.19.35_1.0.0
imx_v2019.04_4.19.35_1.1.0
imx_v2019.04_5.4.3_2.0.0
imx_v2020.04_5.4.24_2.1.0
imx_v2020.04_5.4.47_2.2.0
imx_v2020.04_5.4.70_2.3.0
lf-5.4.y_v2019.04
lf_v2020.04
lf_v2021.04
lf_v2022.04
lf_v2023.04
master
nxp/imx_3.14.38_6ul_engr
nxp/imx_v2009.08
nxp/imx_v2009.08_1.1.0
nxp/imx_v2009.08_10.04.01
nxp/imx_v2009.08_10.05.02
nxp/imx_v2009.08_10.07.11
nxp/imx_v2009.08_10.10.01
nxp/imx_v2009.08_10.11.01
nxp/imx_v2009.08_10.12.01
nxp/imx_v2009.08_11.04.01
nxp/imx_v2009.08_11.05.01
nxp/imx_v2009.08_11.09.01
nxp/imx_v2009.08_11.11.01
nxp/imx_v2009.08_12.01.01
nxp/imx_v2009.08_12.02.01
nxp/imx_v2009.08_12.09.01
nxp/imx_v2009.08_12.10.02
nxp/imx_v2009.08_3.0.0
nxp/imx_v2009.08_3.0.35_4.0.0
nxp/imx_v2009.08_3.0.35_4.1.0
nxp/imx_v2009.08_r13.4.y
nxp/imx_v2013.04_3.10.17_1.0.0_beta
nxp/imx_v2013.04_3.10.17_1.0.0_ga
nxp/imx_v2013.04_3.10.31_1.1.0_alpha
nxp/imx_v2013.04_3.10.9_1.0.0_alpha
nxp/imx_v2013.04_3.5.7_1.0.0_alpha
nxp/imx_v2014.04_3.10.31_1.1.0_beta
nxp/imx_v2014.04_3.10.31_1.1.0_beta2
nxp/imx_v2014.04_3.10.53_1.1.0_ga
nxp/imx_v2014.04_3.14.28_1.0.0_ga
nxp/imx_v2014.04_3.14.28_7d_alpha
nxp/imx_v2014.04_3.14.38_6qp_beta
nxp/imx_v2014.04_kk4.4.3_2.y
nxp/imx_v2015.04
nxp/imx_v2015.04_3.14.38_6qp_ga
nxp/imx_v2015.04_3.14.38_6ul7d_beta
nxp/imx_v2015.04_3.14.38_6ul_ga
nxp/imx_v2015.04_3.14.52_1.1.0_ga
nxp/imx_v2015.04_4.1.15_1.0.0_ga
nxp/imx_v2015.04_brillo
nxp/imx_v2016.03_4.1.15_2.0.0_ga
nxp/imx_v2016.03_4.1.30_7ulp_alpha
nxp/imx_v2016.03_4.1.33_7ulp_beta
nxp/imx_v2017.03_4.9.11_1.0.0_ga
nxp/maddev-imx-android-r10.3
nxp/maddev-imx-android-r13.2
nxp/master
nxp/scm-imx_v2016.03_4.1.15_2.0.0_ga
u-boot/master
u-boot/next
u-boot/origin
u-boot/u-boot-2009.11.y
u-boot/u-boot-2013.01.y
u-boot/u-boot-2016.09.y
