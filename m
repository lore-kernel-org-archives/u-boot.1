Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6432DC54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 16:35:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBC4187FED;
	Tue, 27 Feb 2024 17:35:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="orN92M1G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9210F87FFB; Tue, 27 Feb 2024 17:35:39 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED68387CC1
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 17:35:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41R9XwAb007106; Tue, 27 Feb 2024 16:35:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=qcppdkim1; bh=kBbDMp46KWjjFBHIbs2CM
 ag5czycEyjiKQHSvk6vdNA=; b=orN92M1GsMjyKfxWE4iVluvnCFjil9sb0ZNME
 zMPqLx47bHcNU7l77qGihJ5yPhkXQXJu98vV4ucqmT8lTMj032swxYEhKzwE0Ftj
 NGhAWBpb0EdqweoYOYIx/Bj86m+XBCCh+2kHzCh6+q8wIQSe3F9wpbCLaiVGHEOI
 VnCdKN6FdSiD4XBqZqO6o+cIJZjfh8tZSW4Ro2Zq2LG5QEN34KFuPZ64y6XE/ZI5
 /Db5xPFH9JrkTg2ggiYCfdfmPhnINccUQt4j8j5KSMzhJEhFMCmRVMlzPhO+wzy8
 4emnEIeYNCf408xuyDHm5EZBt+cqwhzSXSB6BwnlP5t8MmeKQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh8auhn98-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Feb 2024 16:35:17 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RGZGII023089
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Feb 2024 16:35:16 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 08:35:10 -0800
Date: Tue, 27 Feb 2024 22:05:06 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
CC: <u-boot@lists.denx.de>, FUKAUMI Naoki <naoki@radxa.com>, Hai Pham
 <hai.pham.ud@renesas.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Konrad Dybcio
 <konrad.dybcio@linaro.org>, Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marex@denx.de>, Mathieu Othacehe <othacehe@gnu.org>, Michal Simek
 <michal.simek@amd.com>, Neil Armstrong <neil.armstrong@linaro.org>, Patrick
 Delaunay <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, Sean
 Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Sumit Garg
 <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tianling Shen <cnsztl@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 00/10] Add initial support for IPQ9574 based boards
Message-ID: <Zd4POiGnybEQjLGm@hu-varada-blr.qualcomm.com>
References: <20240226100807.1095607-1-quic_varada@quicinc.com>
 <940ef1ef-0f70-42ab-8503-f1a2965cc297@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <940ef1ef-0f70-42ab-8503-f1a2965cc297@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: zt4P_Gydc4b_qBlpZVePa5VGoX9E1U7R
X-Proofpoint-GUID: zt4P_Gydc4b_qBlpZVePa5VGoX9E1U7R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_03,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270127
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

On Tue, Feb 27, 2024 at 02:37:25AM +0000, Caleb Connolly wrote:
> HI Varada,
>
> On 26/02/2024 10:07, Varadarajan Narayanan wrote:
> > These patches introduce the initial support code needed
> > for the QTI IPQ9574 SoC and RDP433 board.
>
> Awesome!

Thanks for the feedback. Will rework based on the comments given
in this and the other patches and will post a new spin soon.

-Varada

> >
> > 	SoC	: QTI IPQ9574
> > 	RAM	: 2GB DDR4
> > 	Flash	: eMMC 8GB
> > 	WiFi	: 1 x 2.4GHz, 1 x 5GHz, 1 x 6GHz
> >
> > New to both patman and posting to U-Boot. Please let
> > me know if something is not correct, will try to
> > rectify to the best of my abilities.
>
> Patches came through just fine, thanks! I haven't used patman
> personally, but I have used the b4 tool, I'd recommend giving it a spin
> if you haven't yet. Your get_maintainers.pl options might need some
> tweaking too (the defaults from b4 seem to work better ime).
>
> I've spent some time going through your series and there's a lot to go
> over, so apologies if this gets a bit long.
>
> I'm planning to pick up this[1] patch series this week and I'm sorry to
> say it has some fairly major conflicts with your work here. My series
> makes some fairly significant changes to Qualcomm support in U-Boot
> (moving to upstream Linux DT and getting rid of most of the compile time
> board configuration among other things).
>
> The thing I'm mostly concerned with is the totally custom init code and
> linker script. I discovered this branch[2] which seems to have a fairly
> complete git history, but there's still a lot of unknowns.
>
> * What is the custom linker script for (which isn't handled by the
> default one)?
> * Why do you skip U-Boot relocation (GD_FLG_SKIP_RELOC)?
> * How is U-Boot expected to be flashed and consequently loaded on this
> platform? I get the impression that SBL1 jumps to it directly? Is it
> built into an XBL image like on the mobile/IoT platforms, or flashed to
> it's own partition, or to SPI flash?
>
> In general there is very little context around the code being added
> here, and as a result it's hard to understand what exactly is going on
> and why things have been done a certain way.
>
> I'll leave some more detailed comments in line, but I think initially I
> would just like to get a better understanding of the situation here, so
> answers to the questions above would be most helpful!
>
> Please also have a look at reworking this series on top of my patches
> linked at [1], if you have any issues or questions then please do get in
> touch with me via email, or better via the #u-boot IRC channel on OFTC,
> my nick there is calebccff.
>
> Regarding my series, the notable changes are in how mach-snapdragon is
> handled: the target specific memory maps have been dropped in favour of
> reading the memory map from DT. The sysmap headers are also gone,
> instead the defines are moved to the relevant driver (mostly clock/pinctrl).
>
> I think it would be sensible to (for example) introduce
> mach-snapdragon/smem.c for handling stuff like your env_get_location()
> implementation (it would provide smem_env_get_location() which would be
> called from env_get_location() in board.c).
>
> You'll probably also want to skip the carve_out_reserved_memory() call
> for now.
>
> [1]:
> https://lore.kernel.org/u-boot/20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org/
> [2]:
> https://git.codelinaro.org/clo/qsdk/oss/boot/u-boot/-/tree/NHSS.QSDK.12.4.5
> >
> > Thanks
> > Varada
>
> Kind regards,
> >
> >
> > Varadarajan Narayanan (10):
> >   mach-snapdragon: Add support for IPQ9574
> >   mach-snapdragon: ipq9574: Add SMEM defines needed for IPQ9574
> >   clk/qcom: Add support for clock registers in IPQ9574
> >   clk/qcom: Include IPQ9574
> >   mach-snapdragon: Update gd->ram_size in msm_fixup_memory
> >   pinctrl: qcom: Add support for 'pull-down'
> >   pinctrl: qcom: Include IPQ9574
> >   mmc: msm_sdhci: Handle different vendor cap register offsets
> >   mmc: msm_sdhci: Reset clocks before reconfiguration
> >   board: qualcomm: Add support for IPQ9574 RDP433
> >
> >  arch/arm/dts/Makefile                         |    2 +
> >  arch/arm/dts/ipq9574-default.dts              |  167 +++
> >  arch/arm/dts/ipq9574-rdp433-mht-phy.dts       |  208 +++
> >  arch/arm/dts/ipq9574.dtsi                     |  771 ++++++++++
> >  arch/arm/mach-snapdragon/Kconfig              |   15 +
> >  arch/arm/mach-snapdragon/Makefile             |    1 +
> >  arch/arm/mach-snapdragon/dram.c               |   10 +-
> >  .../include/mach/sysmap-ipq9574.h             |  252 ++++
> >  arch/arm/mach-snapdragon/init_ipq9574.c       |   81 +
> >  board/qualcomm/ipq9574/Kconfig                |   15 +
> >  board/qualcomm/ipq9574/Makefile               |    4 +
> >  board/qualcomm/ipq9574/board_init.c           |  326 ++++
> >  board/qualcomm/ipq9574/ipq9574.c              |  170 +++
> >  board/qualcomm/ipq9574/ipq9574.h              |   75 +
> >  board/qualcomm/ipq9574/u-boot-x32.lds         |  250 ++++
> >  board/qualcomm/ipq9574/u-boot-x64.lds         |  188 +++
> >  configs/ipq9574_mmc_defconfig                 |  118 ++
> >  drivers/clk/qcom/Kconfig                      |    8 +
> >  drivers/clk/qcom/Makefile                     |    1 +
> >  drivers/clk/qcom/clock-ipq9574.c              | 1320 +++++++++++++++++
> >  drivers/clk/qcom/clock-qcom.c                 |   32 +
> >  drivers/clk/qcom/clock-qcom.h                 |    8 +
> >  drivers/mmc/msm_sdhci.c                       |   21 +-
> >  drivers/pinctrl/qcom/Kconfig                  |    7 +
> >  drivers/pinctrl/qcom/Makefile                 |    1 +
> >  drivers/pinctrl/qcom/pinctrl-ipq9574.c        |   77 +
> >  drivers/pinctrl/qcom/pinctrl-qcom.c           |    2 +
> >  include/configs/ipq9574.h                     |  111 ++
> >  include/dt-bindings/clock/gcc-ipq9574.h       |  156 ++
> >  include/dt-bindings/net/qti-ipqsoc.h          |   20 +
> >  include/dt-bindings/pinctrl/pinctrl-ipqsoc.h  |   19 +
> >  include/dt-bindings/reset/ipq9574-reset.h     |   54 +
> >  include/smem.h                                |   78 +
> >  33 files changed, 4563 insertions(+), 5 deletions(-)
> >  create mode 100644 arch/arm/dts/ipq9574-default.dts
> >  create mode 100644 arch/arm/dts/ipq9574-rdp433-mht-phy.dts
> >  create mode 100644 arch/arm/dts/ipq9574.dtsi
> >  create mode 100644 arch/arm/mach-snapdragon/include/mach/sysmap-ipq9574.h
> >  create mode 100644 arch/arm/mach-snapdragon/init_ipq9574.c
> >  create mode 100644 board/qualcomm/ipq9574/Kconfig
> >  create mode 100644 board/qualcomm/ipq9574/Makefile
> >  create mode 100644 board/qualcomm/ipq9574/board_init.c
> >  create mode 100644 board/qualcomm/ipq9574/ipq9574.c
> >  create mode 100644 board/qualcomm/ipq9574/ipq9574.h
> >  create mode 100644 board/qualcomm/ipq9574/u-boot-x32.lds
> >  create mode 100644 board/qualcomm/ipq9574/u-boot-x64.lds
> >  create mode 100644 configs/ipq9574_mmc_defconfig
> >  create mode 100644 drivers/clk/qcom/clock-ipq9574.c
> >  create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq9574.c
> >  create mode 100644 include/configs/ipq9574.h
> >  create mode 100644 include/dt-bindings/clock/gcc-ipq9574.h
> >  create mode 100644 include/dt-bindings/net/qti-ipqsoc.h
> >  create mode 100644 include/dt-bindings/pinctrl/pinctrl-ipqsoc.h
> >  create mode 100644 include/dt-bindings/reset/ipq9574-reset.h
> >
>
> --
> // Caleb (they/them)
