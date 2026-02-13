Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DDCEE36B2
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 09:42:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10C3983936;
	Fri, 13 Feb 2026 10:42:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="W/WgankV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PYws0qJS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18EAF83AA9; Fri, 13 Feb 2026 10:42:27 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7217C80FA1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 10:42:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D925Tt2733479
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=T3rDc8lEr5eedm5blSuSVXqO
 BXEdMw1dTEkKSO/q97k=; b=W/WgankVXS4fMkcouxWGhKVCHkt+Y1zNrbMHomTx
 1WSUH6dDVNP4/WCOwibGJ2mbKHI0xKT9V9/EKFRIXGuz75IQmh6TQsog+zFAnFB3
 J5GVo4vFXBxTPvxBhFhy3LI6Ygdt1FEw0s+lqY33WhNYS6SwZhf2zRk0veInHxUy
 fmWGmw7Tod72CrThKeqopyfC1GPHPWxHb0u4TYFVxeWO0JuII1LQwuoXQ7efvNWE
 zJYDMB/6FWH4on7I6T+gFEipD325b5CJfFDNczKbSwx0Ezbl6poIov8PzWPqF/oA
 uc/3rt9Qt4TnyBMPkMn06pOtlTcPNRp9HJrIXW/VqpoS1Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9s6wstc4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:42:22 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c6e1919fb7bso566801a12.2
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 01:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770975741; x=1771580541; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=T3rDc8lEr5eedm5blSuSVXqOBXEdMw1dTEkKSO/q97k=;
 b=PYws0qJS34vi3XDaxNpptL5JJ1piUvCyxwzTszy9jKoAEeaL2Up72o0j/B9zBJtZcK
 N+mt9xexL0IOnZ0O1mLixwaJ5Bu/HXqDg1lS5j5s6HlSBgA/WfSnzfH+0hqmhNtaRUMf
 YBeR4Zn8mIzAgCIuBgcEbMj6IFv7ag8/27XNReoP/IY7wXZ7ghd36mApSxsINBBeeJho
 Hh3znZqnD0Hki3Mu1Us19VQ2X0Pbcl16e9GxvDjsRANev5C0ov236Fc4+TOEFSX9hK/W
 NYEIwOaPZgN8hVzwx48nthtnZMBPCIQmZNqyEAt2K+cchiFKmQzLPn3ZxPRuyoLOU+D1
 EqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770975741; x=1771580541;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T3rDc8lEr5eedm5blSuSVXqOBXEdMw1dTEkKSO/q97k=;
 b=JLyw3XUhR3ec7pOI+5XyaNw2szukzQbeRagE5ORI4iPBXQX/izJsIx1iX5V+NuN2lk
 WpXZr2OYSr+cZseFCgWEp804GX86DxDUzJlIosUvDYAhQRzJY7V3Tr/fPX0yyUlhCzkU
 rXTYrzkq1Y9PoFST6zkPBUA2+bsn/lHZOEOBjACn4DtKhapTklwOQOfao1vosdu06Bmr
 +io1Fw8zj6avTO3Tu1tPo+/b0aNkVCQFulNmn6U+ltBX6E/J1PfJ6BuqkpYwO3BempWe
 2e1xbYx9xRilBasmcYAdjoIVHEzm+90Z9+lhZZtrDuaElB+mp58ABm6kk8dR/ZQI27m8
 pSLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUofxzHfVsWhZeuxvyBoX4mbJh++cDfEPcLqWrYgSSGH2p2rzpZiJbPZxL6Yrfq8P4gaRFwh0I=@lists.denx.de
X-Gm-Message-State: AOJu0YwVlMUzyMzVu+b9rvdJ/1Kf2/9jYrk4PQTprmbV9kc4+KpyRoTb
 xv+uFtezKl7phKhwBD2AXMR6BwvDic1Iti6VkiEU1/XaAvJfsQyn48BwRizT8owPHJhoQfjYI7S
 OgI3R0nt8ho/xFu+yFKxS2a3Jz+TdudyE2DIk0d3NUE+UmM5jWRhG28Ebl+dO4BGB
X-Gm-Gg: AZuq6aIcOaGwz7FYRTqQJDeLWGy0G6W134AJjGFtKTUCMCDzMN8/zb+pJfIqwYpl8XB
 bnzVHoUMtY1hP02tx+1rjVF4thw83rad2TugY+3h/KpyYEknL3sUh04bjAX8XBPwk1j1NsgiioG
 HBLWWoEX6VQgPys2Ic3bJMmuVI24Th9JATwd2HmwznPOM5GIoKNoqyzpyegSsijedv3nyM1UN85
 YpTsj1sjbhbZreg6PGCBin9PldBEcqR7a+fxhv6AcjVdHqaGbti/veSncctt0Q9KfQhl9evJpZ3
 jmjdi5/bLQ16lMdESYVImowez2rHHd1IrNgUCk1T3YLiLClKbE6AfSdAgpHQBEpV51gthRVy8jQ
 TDeR8WPGOzKt9UV7x28G0L1SAO4Npo0SOvCC0ppQIOg71nN5v2pY0agCB+lWDvly9UQ4/Kp5l8u
 rsaC+LQQvqT+5fMqdl5D39m3S37uB9inzYLGvVBGe1VtsRX1niATA=
X-Received: by 2002:a05:6a00:3306:b0:824:9ce1:908 with SMTP id
 d2e1a72fcca58-824c9645f4dmr1434596b3a.67.1770975741483; 
 Fri, 13 Feb 2026 01:42:21 -0800 (PST)
X-Received: by 2002:a05:6a00:3306:b0:824:9ce1:908 with SMTP id
 d2e1a72fcca58-824c9645f4dmr1434565b3a.67.1770975741029; 
 Fri, 13 Feb 2026 01:42:21 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6b69ba2sm2035407b3a.38.2026.02.13.01.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 01:42:20 -0800 (PST)
Date: Fri, 13 Feb 2026 15:12:12 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jerome@forissier.org,
 marek.vasut+renesas@mailbox.org, ilias.apalodimas@linaro.org,
 me@samcday.com, aswin.murugan@oss.qualcomm.com, clamor95@gmail.com,
 michal.simek@amd.com, u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v6 2/5] drivers: sysreset: Add sysreset op that can take
 arguments
Message-ID: <aY7x9EAueKZ9Xxmt@hu-varada-blr.qualcomm.com>
References: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260121063920.1500293-3-varadarajan.narayanan@oss.qualcomm.com>
 <CAFLszThUMWgySrb4H2F5PE6XVsRK0Cc+PZ37f_3xZ12HEhM=3g@mail.gmail.com>
 <aXg8ge6z7EMWliSd@hu-varada-blr.qualcomm.com>
 <CAFLszTh-B=zQyBjwJ_OuVxAbpTpUaKB1e9zB8Nm6+wuJCK5OcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTh-B=zQyBjwJ_OuVxAbpTpUaKB1e9zB8Nm6+wuJCK5OcQ@mail.gmail.com>
X-Proofpoint-ORIG-GUID: 3Mb2dAW-Uhd7NlYTXuAoF5wtS7god9yX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA3NCBTYWx0ZWRfX2oONTcACrlQA
 dWEsN2G4/8p4EXE7LFwQU9CCQ1UPwNJMFFfDfGBsOfr2M2iJv6wliMntBQzE6ApnLCAinqnivgC
 /V+JHExU9JL3dwVglRQDwMgXZysSfRDtJIXI6f9u0Vr2A7LTQFbNv6H1DHASiiqJHV1g9bzcvBg
 tRAJXnj0iWi6/XJjZQpc4yt/pZ3l6VFCIOmMco0+TelotC+ZX31/SNYIGu5Dflfp2eAmlVzSd2Z
 zDryIjFoN9H3tEwMIawOUpIsR5y2sErYbhEwYCQ7HRv22tEbmN+MExo/LRQ3UNTwKBWeH8ZI56I
 1x1qegdRc8hL+OHQAYwh5QScjaVO0lgoefJlXArUF8g5TLHc2YCJkUO6IBnofwnp65CZH/0d/5m
 h9FGACn/YBQ8Kb3D0SUbRlMo4HgNfg7/Yb+KWs+CaqT6LfpnDxeecus2ds9/vtn71pTdUqYN6dw
 4DeQts11xRiazMuHDAw==
X-Proofpoint-GUID: 3Mb2dAW-Uhd7NlYTXuAoF5wtS7god9yX
X-Authority-Analysis: v=2.4 cv=CLInnBrD c=1 sm=1 tr=0 ts=698ef1fe cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Iqu_MdM8sPRO1OrDf-0A:9
 a=CjuIK1q_8ugA:10 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130074
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

On Wed, Feb 04, 2026 at 01:23:05PM +1300, Simon Glass wrote:
> Hi Varadarajan,
>
> On Tue, 27 Jan 2026 at 17:18, Varadarajan Narayanan
> <varadarajan.narayanan@oss.qualcomm.com> wrote:
> >
> > On Mon, Jan 26, 2026 at 06:15:34PM +1300, Simon Glass wrote:
> > > Hi,
> > >
> > > On Wed, 21 Jan 2026 at 19:39, Varadarajan Narayanan
> > > <varadarajan.narayanan@oss.qualcomm.com> wrote:
> > > >
> > > > Add a 'request_arg' op to struct sysreset_ops to enable sysreset drivers
> > > > to receive arguments given to the 'reset' command. Process the
> > > > request_arg() op before the usual request() op.
> > > >
> > > > Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
> > > > Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> > > > ---
> > > > v6: Wrap this functionality inside CONFIG_SYSRESET_CMD_RESET_ARGS
> > > > ---
> > > >  drivers/sysreset/Kconfig           |  8 +++++++
> > > >  drivers/sysreset/sysreset-uclass.c | 37 ++++++++++++++++++++++++++++++
> > > >  include/sysreset.h                 | 18 +++++++++++++++
> > > >  3 files changed, 63 insertions(+)
> > > >
> > > > diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
> > > > index 0181f6cd581..6fb0ca81dc6 100644
> > > > --- a/drivers/sysreset/Kconfig
> > > > +++ b/drivers/sysreset/Kconfig
> > > > @@ -49,6 +49,14 @@ config SYSRESET_CMD_RESET
> > > >         help
> > > >           Enable sysreset implementation of the reset command.
> > > >
> > > > +config SYSRESET_CMD_RESET_ARGS
> > > > +       bool "Enable reset command to take arguments"
> > > > +       help
> > > > +         Pass on the arguments received by the 'reset' command to the
> > > > +         sysreset driver(s). The sysreset driver(s) may make use of the
> > > > +         additional arguments for implementing arch/board specific
> > > > +         functionality.
> > > > +
> > >
> > > I haven't been following this, but what sort of args are you planning to pass?
> >
> > As of now, an argument to indicate reboot to emergency download mode.
>
> So how about adding a struct in sysreset.h where you can include a
> flag word and create a single flag for your case? We should be able to
> handle reset without the cmdline being enabled.
>
> There are other cases where this would be useful, e.g. an EFI app
> rebooting into setup boot.

Previously, i.e. v5 [1] didn't have SYSRESET_CMD_RESET_ARGS config
option. This was added to avoid bloat code size for platforms that will
not need this. Please see [2]

Thanks
Varada

1 - https://lore.kernel.org/u-boot/20260113103840.1948029-3-varadarajan.narayanan@oss.qualcomm.com/
2 - https://lore.kernel.org/u-boot/20260119170701.GD3416603@bill-the-cat/
