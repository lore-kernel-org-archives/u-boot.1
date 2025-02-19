Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B502AC021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 07:12:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4246080C98;
	Wed, 19 Feb 2025 08:12:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="HSXClq7R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E8E180EBD; Wed, 19 Feb 2025 08:12:40 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2E27801DE
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 08:12:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IIwWTT011626;
 Wed, 19 Feb 2025 07:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=8CfMZqOVaJrDpasoS9G8/dHu
 yIVon9vnwnngB1+c150=; b=HSXClq7RWQ9eAUz71uB99gxq1cWmgt/2gekYftJY
 8GwBCHrv6oF4+G75jcCNSxejw0CimFvgaE4Aon8idc7cptVjvgp6IqJbXfrWbR5u
 Z+2ZIcuu6kiFB0odYwo1T975gTqq9A3SphSB4Z7Xb6c/oKUOLubq9M6zP3FjkV4Y
 FSrdckur5nFXWo+xt56a4H1u2YwKr4HJFosjLubyz12BTOvpljnoGJfqUl/Z5Nx6
 q5ZWvcxiIxc5G7+149gsyYj2eiz73aPHLMIsFfEHDbNA59FXtNgdSS+MktCQlU/1
 eLRdL3XorlSGWu5xyo41iMPFaRkpmY7WqREt7HLa8X9ekA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy3hje5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 07:12:24 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51J7CNRx026982
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 07:12:23 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 18 Feb 2025 23:12:17 -0800
Date: Wed, 19 Feb 2025 12:42:14 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
CC: <trini@konsulko.com>, <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>,
 <lukma@denx.de>, <seanga2@gmail.com>, <peng.fan@nxp.com>,
 <jh80.chung@samsung.com>, <robert.marko@sartura.hr>,
 <luka.perkov@sartura.hr>, <ilias.apalodimas@linaro.org>,
 <sjg@chromium.org>, <lehmanju@devpi.de>, <Volodymyr_Babchuk@epam.com>,
 <marek.vasut+renesas@mailbox.org>, <pbrobinson@gmail.com>,
 <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: Re: [PATCH v3 1/8] doc: board/qualcomm: document RDP building/flashing
Message-ID: <Z7WETijFateGTwnH@hu-varada-blr.qualcomm.com>
References: <20250218085430.2422287-1-quic_varada@quicinc.com>
 <20250218085430.2422287-2-quic_varada@quicinc.com>
 <59b2b371-97a7-4b3e-af5d-1ea1f6dee2eb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <59b2b371-97a7-4b3e-af5d-1ea1f6dee2eb@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: 6IaqAdo0W_AmdpKwYRcgUF1UkzdWg2Ai
X-Proofpoint-GUID: 6IaqAdo0W_AmdpKwYRcgUF1UkzdWg2Ai
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_03,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502190055
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

On Tue, Feb 18, 2025 at 05:33:19PM +0000, Caleb Connolly wrote:
> Hi Varadarajan,
>
> On 2/18/25 08:54, Varadarajan Narayanan wrote:
> > Introducing basic support for Qualcomm IPQxxx based RDPs.
> > Document the build and flashing steps.
>
> It looks like you forgot to squash this patch into a previous one (which
> isn't part of the series?)

Yes. Will post the correct one.
Sorry about this.

-Varada

>
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> >   doc/board/qualcomm/rdp.rst | 34 ++++++++++++++++++++--------------
> >   1 file changed, 20 insertions(+), 14 deletions(-)
> >
> > diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
> > index b51b495e4f..f6ea689b91 100644
> > --- a/doc/board/qualcomm/rdp.rst
> > +++ b/doc/board/qualcomm/rdp.rst
> > @@ -1,24 +1,21 @@
> > -.. SPDX-License-Identifier: GPL-2.0+
> > +.. SPDX-License-Identifier: GPL-2.0
> >   .. sectionauthor:: Varadarajan Narayanan <quic_varada@quicinc.com>
> >   Qualcomm RDP
> >   ============
> > -The Qualcomm RDPs are development boards based on the Qualcomm IPQ series of
> > +Qualcomm RDPs are development boards based on the Qualcomm IPQ series of
>
> Also, please explain what the acronym means.
>
> >   SoCs. These SoCs are used as the application processors in WiFi router
> >   platforms. RDPs come in multiple variants with differences in storage
> >   medium (NOR, NAND, MMC), no. of USB and PCIe ports, n/w ports etc.
> > -More information can be found on `Qualcomm's product page`_.
>
> This should point to something like https://www.qualcomm.com/products/internet-of-things/networking/wi-fi-networks/networking-pro-series/qualcomm-networking-pro-820-platform
>
> I'll give this a proper review once I have the whole file heh.
>
> Kind regards,
> > -
> > -.. _Qualcomm's product page: https://www.qualcomm.com/developer/hardware/rb3-gen-2-development-kit
> >   Installation
> >   ------------
> >   First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``IPQ9574``::
> > -  $ export CROSS_COMPILE=<aarch64 toolchain prefix>
> > -  $ make qcom_ipq9574_mmc_defconfig
> > -  $ make -j8
> > +	$ export CROSS_COMPILE=<aarch64 toolchain prefix>
> > +	$ make qcom_ipq9574_mmc_defconfig
> > +	$ make -j8
> >   This will build ``u-boot.elf`` in the configured output directory.
> > @@ -28,20 +25,29 @@ security in this case, but it provides the firmware with some required metadata.
> >   To "sign" ``u-boot.elf`` you can use e.g. `qtestsign`_::
> > -  $ qtestsign -v6 aboot -o u-boot.mbn u-boot.elf
> > +	$ qtestsign -v6 aboot -o u-boot.mbn u-boot.elf
> >   Then install the resulting ``u-boot.mbn`` to the ``0:APPSBL`` partition
> >   on your device with::
> > -  => tftpboot path/to/u-boot.mbn
> > -  => mmc part (and note down the start & end of '0:APPSBL' partition)
> > -  => mmc erase <blk no> <count>
> > -  => mmc write $fileaddr <blk no> <count>
> > +	=> tftpboot path/to/u-boot.mbn
> > +	=> mmc part (and note down the start & end of '0:APPSBL' partition)
> > +	=> mmc erase <blk no> <count>
> > +	=> mmc write $fileaddr <blk no> <count>
> >   U-Boot should be running after a reboot (``reset``).
> >   .. WARNING
> > +	Boards with newer software versions would automatically go the emergency
> > +	download (EDL) mode if U-Boot is not functioning as expected. If its a
> > +	runtime failure at Uboot, the system will get reset (due to watchdog)
> > +	and XBL will try to boot from next bank and if Bank B also doesn't have
> > +	a functional image and is not booting fine, then the system will enter
> > +	EDL.  A tool like bkerler's `edl`_ can be used for flashing with the
> > +	firehose loader binary appropriate for the board.
> > +
> >   	Note that the support added is very basic. Restoring the original U-Boot
> > -	without a debugger is almost impossible.
> > +	on boards with older version of the software requires a debugger.
> >   .. _qtestsign: https://github.com/msm8916-mainline/qtestsign
> > +.. _edl: https://github.com/bkerler/edl
>
> --
> Caleb (they/them)
>
