Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FEDC3ABA9
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 11:41:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E2BB809A5;
	Tue, 29 Apr 2025 13:41:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="YwZUN6aW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B93C1809A5; Tue, 29 Apr 2025 13:41:18 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 191AB8070C
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 13:41:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TAG2Xl005181;
 Tue, 29 Apr 2025 11:40:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=FXzk/5oGFl7ef9XU8t7IQyut
 G/5wuJoKmDubYpyExq8=; b=YwZUN6aWReRT1nqpLNyzoMNyC1+ZeuRD+JbHXLPX
 eWAx64/tV1HSLtEXzMQy1QdE0akhhNEcgaQkcD2qx8ouCO/LSwif+dvf8TgJx3M0
 LcygEh9q0L75ULo3mWdnspJzuTYby7FtkY/6kJl7OtOJnml5ejiWWNfffMoHPtBs
 3i0vRQ88qz0ElnG9r6k2DK04aaXijaU2Mt8rKlCPveVqKH8LzEguwnt0ort3EH5n
 578NWJS+C+oo3C/BLPvSDbbNOpt+AWv5facnww0DZzfk5vgdxp+tya2276anZck9
 Ra3XGZ7r7/mym0uWUisQUVblrdd99yTUMeNrMjltGL5ToA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468rsbbbp9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Apr 2025 11:40:55 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53TBet0c028990
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Apr 2025 11:40:55 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 29 Apr 2025 04:40:50 -0700
Date: Tue, 29 Apr 2025 17:10:46 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Casey Connolly <casey.connolly@linaro.org>
CC: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@kernel.org>,
 <sjg@chromium.org>, <ilias.apalodimas@linaro.org>,
 <sughosh.ganu@linaro.org>, <me@samcday.com>, <marex@denx.de>,
 <robert.marko@sartura.hr>, <seashell11234455@gmail.com>,
 <ycliang@andestech.com>, <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v1 2/3] sysreset: Implement PSCI based reset to EDL mode
 for QCOM SoCs
Message-ID: <20250429114046.3hygqajx42tcsgv7@hu-varada-blr.qualcomm.com>
References: <20250410120208.4142087-1-quic_varada@quicinc.com>
 <20250410120208.4142087-3-quic_varada@quicinc.com>
 <1e0e9a72-40a8-4ce3-a390-edef1d6a03d8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1e0e9a72-40a8-4ce3-a390-edef1d6a03d8@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDA4NyBTYWx0ZWRfXwJT3eDtDlaoN
 ZTU3Ipe6BEzpdQ8YEJtFlrmqUfYnjZLPa84camxzwzOSTwh7MUNG3UOqw/DEbqSdwtn3hw2YaPk
 IBIxiknKRMH7D+A5kftS50Qzb8zqSJSBoMtpWBQ/TH2e7KyTxWA4/bFI0CJkms8QghwR73nHC37
 AW3bTkhrVx3hWnNWvuUj89iW66G9PHb/cpZdw/YeJ/7+QVAAIo+bnrHjagtoy5mr7J4LWQcX4WM
 uOtYswqan0vO1hI/33KdXI2HRGoA6ZPNb+vj+WFfEku3+CE4CkWyZWlcTz1m3dZr7pZxN469y3J
 rv5/W/X/Uf909DdS3aVRa3rdc+fN2hV+WGAQG7hTQmtM+QCOdJBR1Yb1SjY/Wxg6OIFnlIr36q1
 VOrf0j6IUkvgJ3YsEUviqxn+dM0/Ty1a6UcuaLzBgWaIV14k+hPfB7aypt0e0BfSKMVNBdOI
X-Proofpoint-GUID: 1I-DMIqHhXGKkjSgXLXRsUU0b0HVg4du
X-Proofpoint-ORIG-GUID: 1I-DMIqHhXGKkjSgXLXRsUU0b0HVg4du
X-Authority-Analysis: v=2.4 cv=I8ZlRMgg c=1 sm=1 tr=0 ts=6810bac7 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8
 a=c-n4J4-pAAAA:8 a=SK7vpsX4mJLF38ZNztMA:9
 a=CjuIK1q_8ugA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 malwarescore=0 impostorscore=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290087
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

On Mon, Apr 28, 2025 at 04:22:47PM +0200, Casey Connolly wrote:
>
>
> On 4/10/25 14:02, Varadarajan Narayanan wrote:
> > Add SYSRESET_EDL to sysreset_t and handle the different SYSRESET_xxx
> > requests in sysreset_qcom-psci.c.
>
> To be honest, I'm not really excited about this. Copying the entire PSCI
> reset code and polluting the global sysreset reason enum with entirely
> platform specific symbols is not good practise.
>
> Additionally, while this specific EDL implementation works on your platform,
> it does not work on (for example) sdm845 and sm8250 which are platforms we
> still very much care about. I'm also not sure if it works on SC7280.
>
> I think this should be handled in an/the SCM driver like it is in Linux, not
> sure if Sam is working on that or if I can send a barebones version of the
> one I have in my tree. It will need to be based on the compatible string for
> the scm node in DT (and checking for the qcom,dload-mode property too I
> think).
>
> As I proposed before on IRC, I think it makes sense to pass the "reset"
> arguments into sysreset and allow the sysreset driver to implement a
> callback/handler for them, this way the "edl" argument makes it all the way
> to our platform-specific driver which can then call "psci_system_reset2()"
>
> I would implement this by adding a new op to sysreset_ops, something like
> .request_args, then have a second for loop which calls this, since we want
> any reset handler which /can/ parse the args to do so before we call the
> normal .request callback (otherwise some other handler might do a normal
> reset before we have parsed the arguments).
>
> For now I'm fine with this new sysreset-qcom.c driver being specific to
> qcs9100, but please include a comment that the psci reset2 call is only
> supported on some newer qualcomm platforms and that others can be supported
> via SCM.
>
> On that note, how does this new driver actually get bound? It doesn't have
> any compatible strings associated? Or am I missing something here... Please
> explain this.

Apologies, my bad for not mentioning it. Presently it is not getting bound.
Wanted to get feedback about the approach.

> Otherwise, I'm looking forward to v2.

Will post v2, with device_bind_driver("qcom_psci-sysreset") in psci_bind().

Thanks
Varada

> Kind regards,
>
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> >   drivers/sysreset/Kconfig              |  5 +++
> >   drivers/sysreset/Makefile             |  1 +
> >   drivers/sysreset/sysreset-uclass.c    |  7 ++--
> >   drivers/sysreset/sysreset_qcom-psci.c | 47 +++++++++++++++++++++++++++
> >   include/sysreset.h                    |  2 ++
> >   5 files changed, 60 insertions(+), 2 deletions(-)
> >   create mode 100644 drivers/sysreset/sysreset_qcom-psci.c
> >
> > diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
> > index 121194e4418..a6a1e57b603 100644
> > --- a/drivers/sysreset/Kconfig
> > +++ b/drivers/sysreset/Kconfig
> > @@ -240,6 +240,11 @@ config SYSRESET_RAA215300
> >   	help
> >   	  Add support for the system reboot via the Renesas RAA215300 PMIC.
> > +config SYSRESET_QCOM_PSCI
> > +	bool "Support sysreset for Qualcomm SoCs via PSCI"
> > +	help
> > +	  Add support for the system reboot on Qualcomm SoCs via PSCI.
> > +
> >   config SYSRESET_QCOM_PSHOLD
> >   	bool "Support sysreset for Qualcomm SoCs via PSHOLD"
> >   	depends on ARCH_IPQ40XX
> > diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
> > index 796fc9effa5..12dbad5254a 100644
> > --- a/drivers/sysreset/Makefile
> > +++ b/drivers/sysreset/Makefile
> > @@ -29,5 +29,6 @@ obj-$(CONFIG_SYSRESET_RESETCTL) += sysreset_resetctl.o
> >   obj-$(CONFIG_$(PHASE_)SYSRESET_AT91) += sysreset_at91.o
> >   obj-$(CONFIG_$(PHASE_)SYSRESET_X86) += sysreset_x86.o
> >   obj-$(CONFIG_SYSRESET_RAA215300) += sysreset_raa215300.o
> > +obj-$(CONFIG_SYSRESET_QCOM_PSCI) += sysreset_qcom-psci.o
> >   obj-$(CONFIG_SYSRESET_QCOM_PSHOLD) += sysreset_qcom-pshold.o
> >   obj-$(CONFIG_TARGET_XTFPGA) += sysreset_xtfpga.o
> > diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
> > index 536ac727142..d06c0a6908a 100644
> > --- a/drivers/sysreset/sysreset-uclass.c
> > +++ b/drivers/sysreset/sysreset-uclass.c
> > @@ -125,8 +125,11 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> >   	if (argc > 2)
> >   		return CMD_RET_USAGE;
> > -	if (argc == 2 && argv[1][0] == '-' && argv[1][1] == 'w') {
> > -		reset_type = SYSRESET_WARM;
> > +	if (argc == 2) {
> > +		if (argv[1][0] == '-' && argv[1][1] == 'w')
> > +			reset_type = SYSRESET_WARM;
> > +		else if (!strncmp("edl", argv[1], 3))
> > +			reset_type = SYSRESET_EDL;
> >   	}
> >   	printf("resetting ...\n");
> > diff --git a/drivers/sysreset/sysreset_qcom-psci.c b/drivers/sysreset/sysreset_qcom-psci.c
> > new file mode 100644
> > index 00000000000..3afb79e2d2e
> > --- /dev/null
> > +++ b/drivers/sysreset/sysreset_qcom-psci.c
> > @@ -0,0 +1,47 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2017 Masahiro Yamada <yamada.masahiro@socionext.com>
> > + */
> > +
> > +#include <dm.h>
> > +#include <sysreset.h>
> > +#include <asm/system.h>
> > +#include <linux/errno.h>
> > +#include <linux/psci.h>
> > +
> > +__weak int qcom_psci_sysreset_get_status(struct udevice *dev, char *buf, int size)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +static int qcom_psci_sysreset_request(struct udevice *dev, enum sysreset_t type)
> > +{
> > +	switch (type) {
> > +	case SYSRESET_WARM:
> > +	case SYSRESET_COLD:
> > +		psci_sys_reset(type);
> > +		break;
> > +	case SYSRESET_POWER_OFF:
> > +		psci_sys_poweroff();
> > +		break;
> > +	case SYSRESET_EDL:
> > +		psci_system_reset2(0, 1);
> > +		break;
> > +	default:
> > +		return -EPROTONOSUPPORT;
> > +	}
> > +
> > +	return -EINPROGRESS;
> > +}
> > +
> > +static struct sysreset_ops qcom_psci_sysreset_ops = {
> > +	.request = qcom_psci_sysreset_request,
> > +	.get_status = qcom_psci_sysreset_get_status,
> > +};
> > +
> > +U_BOOT_DRIVER(qcom_psci_sysreset) = {
> > +	.name = "qcom_psci-sysreset",
> > +	.id = UCLASS_SYSRESET,
> > +	.ops = &qcom_psci_sysreset_ops,
> > +	.flags = DM_FLAG_PRE_RELOC,
> > +};
> > diff --git a/include/sysreset.h b/include/sysreset.h
> > index ff20abdeed3..8bda9703cd9 100644
> > --- a/include/sysreset.h
> > +++ b/include/sysreset.h
> > @@ -21,6 +21,8 @@ enum sysreset_t {
> >   	SYSRESET_POWER,
> >   	/** @SYSRESET_POWER_OFF: turn off power */
> >   	SYSRESET_POWER_OFF,
> > +	/** @SYSRESET_EDL: reset and boot into Emergency DownLoader */
> > +	SYSRESET_EDL,
> >   	/** @SYSRESET_COUNT: number of available reset types */
> >   	SYSRESET_COUNT,
> >   };
> --
> Casey (she/they)
>
