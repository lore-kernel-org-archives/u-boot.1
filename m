Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C2CE83848
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 04:27:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D20A483C61;
	Tue, 17 Feb 2026 05:27:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ibBSBFZD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EG2TvrbD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70DBA83C72; Tue, 17 Feb 2026 05:27:07 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E23F83981
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 05:27:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61GIU8WB2803486
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 04:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=tfME0l7GvNu/QjFkHx4tziV3
 oWV3dSxi2VX0bl6XJPw=; b=ibBSBFZD0XFpiHTT1Yt+jXd74U63Po5j6OVXskMU
 7WmTMkqOrAImhi90dQmpUV6XEAV+9pKNXgPo7DERmtAf+WWKY0/QdgK0rcE5YMfm
 dtxrGbSJ5XRNeUGYQOdQSvNHZ/Mg53iH278QSc27z1fX9+6Qnrkw4bnKQmDTGY53
 RMq0FPchSHInrkwgiWDdh9yYOSPzBE7w1k1ByfhKTIG5/KA50N1lJ3NiAsyYKtyb
 Q0FkXqFOSumbXqdEDW2x7ZaWDL/t4ly293z2ikDjenJ9N1m2P4WVoiju1Md/oPnz
 VrRuiYhfjXbI77BauJhfm1ozNvKP1rBvdjdt7QLQf5pVFg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cbyxuj8ry-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 04:27:01 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2aaf2f3bef6so47392585ad.0
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 20:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1771302421; x=1771907221; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tfME0l7GvNu/QjFkHx4tziV3oWV3dSxi2VX0bl6XJPw=;
 b=EG2TvrbDaQic+hBpjQYPWavHMBhrKkwKdqU6GWIkxYVdGF4TpOE1Z6xsinQ1RGAzYW
 6YYRPHe+maRdrtD7BnuoRiuZavOqwQ158i3ewrFsTy56g/BXkyJ6hirDT2WL0EJN1vLP
 VWsJOiYK9+E2CszgCHt4s1od22WD++0ZO8GHB8P45gXrKF9jqXDNSw3kfy9k/uh6ObQd
 S7boXdhUtqL+ptkbkeawP0QNvYKFSP6ZRhq02AagXhIdy74UlYerDx8FaqkPT58D+V/2
 BiyOdrc7prSziZxkgMncGn2ntHe/mcP2KxyMbKboNEkH28aiFBlq90xVJvPk2ZnbbwX4
 Bveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771302421; x=1771907221;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tfME0l7GvNu/QjFkHx4tziV3oWV3dSxi2VX0bl6XJPw=;
 b=Ia6TYLIbVsICuLn3WsdyiXHsp5yiLKKbI1CuztrpaZRFyJNeet6putFaPreAuvXYct
 WDj0Ymrohg/LwRzLkt8R43khogILU9MQggcv1LtcT9KkP/PzwAjJuU/sPOrz4LdrTqql
 Di7JumJNQB6vQsTJnV0iTMaRelHnmcQYbrO4TgdOYBALDYKDPRoRTYWkfFTvEvlB/3Yz
 2S5yTRAJDQx2/AY/gN/zUdcQ7v1GWMgHn4YwYSGIPzVfvt6/4aJIFz9lrFz1+lixlKKt
 hx89WD9gdA6+SXRxDXYBj+3SxOAVEP6S3yUt97Xh+lRWXgkNr8aUP+99MGHAAnC5DjBO
 rtWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE+mFffSDerwMaUver0cFDVPqCmPGlDRtXEls/1ftijsLGQOlC9wF/VcsnuR6EoVWIx7KNp6o=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3Wlbt+tdYAMfNGomvgzVuT5I1MvF/e6UprvwUeYqW6DeLBbIb
 vtKXPNDOP+9gDOu/IWjNZcYxhiG3ENhr27TIhBZtAlT8nIqF9S/0yJ/Rn25v/lDP/5ldlaFxy6J
 AsYlA0yyO6UhbFwmpB2Ws4RZQTHRflVkVtiCzcF+wuSUNP1HihEJGzbXJ
X-Gm-Gg: AZuq6aLRbmDPg5+pHlqaxyprLCs+JACzGbL3eTu4RSbnNZmvginAeO2KMWf7eOBCPc0
 3rTnimCouzmUv+BJArjSNAyUBhsLBvuC/fekwPNLuh8H5P1N15DpaL4K4O52To3EfqnwhrNpfA8
 UgR/JE6Hv17B9hOQ/IqnSi/uNoAkSByGBlv3VfJqX669/HseAHr9ghl1ms1HabtOOuVNhQk9cs7
 mGQ113yIWKD1RlbasrIJr1d0BUcbFFp+9HgAioxkJgaSh7Lom1fqwpVfU2JbUNHSye6DSCMf+ZD
 1RwNgXLKoU1ArDbEptaMIMNbzBj363zMNJKdb8DlI3rM/ThYCzSv/juSLibYDHBsPp5OcqUEBh9
 0TKAKpRWwkpd8YehSC8k/8erCp0PXPT2SX+BoR9L7kLj3mQBQIv1FvsrFVB9d4//KlpifEKvy37
 lalvH8BWfJB5M1mc9TeJ0BQaXNo0f7mX2eDfsMq6mwlVM8uhOd1yw=
X-Received: by 2002:a17:903:1a90:b0:2aa:f5b4:9a28 with SMTP id
 d9443c01a7336-2ad1750a303mr107030825ad.42.1771302420833; 
 Mon, 16 Feb 2026 20:27:00 -0800 (PST)
X-Received: by 2002:a17:903:1a90:b0:2aa:f5b4:9a28 with SMTP id
 d9443c01a7336-2ad1750a303mr107030525ad.42.1771302420360; 
 Mon, 16 Feb 2026 20:27:00 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1aadc84csm77009455ad.68.2026.02.16.20.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 20:27:00 -0800 (PST)
Date: Tue, 17 Feb 2026 09:56:52 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, jerome@forissier.org,
 marek.vasut+renesas@mailbox.org, ilias.apalodimas@linaro.org,
 me@samcday.com, aswin.murugan@oss.qualcomm.com, clamor95@gmail.com,
 michal.simek@amd.com, u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v6 2/5] drivers: sysreset: Add sysreset op that can take
 arguments
Message-ID: <aZPuDGK/uUOg11fR@hu-varada-blr.qualcomm.com>
References: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260121063920.1500293-3-varadarajan.narayanan@oss.qualcomm.com>
 <CAFLszThUMWgySrb4H2F5PE6XVsRK0Cc+PZ37f_3xZ12HEhM=3g@mail.gmail.com>
 <aXg8ge6z7EMWliSd@hu-varada-blr.qualcomm.com>
 <CAFLszTh-B=zQyBjwJ_OuVxAbpTpUaKB1e9zB8Nm6+wuJCK5OcQ@mail.gmail.com>
 <aY7x9EAueKZ9Xxmt@hu-varada-blr.qualcomm.com>
 <CAFLszTgWW0-3hXkUWVmiDgfT1yMZMkjX8zDsT8Qf846ZgaA2Xg@mail.gmail.com>
 <aZKrlhpNI/tpdWmG@hu-varada-blr.qualcomm.com>
 <20260216152906.GU2747538@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216152906.GU2747538@bill-the-cat>
X-Proofpoint-GUID: Z-lGL02JO4fkiI8GQNTE1IoPmf2S8a0C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDAzMyBTYWx0ZWRfX+4sNqdODUngl
 iIEChzkoNNbx0wWxIA1Spmevwz59wtc4Gvftvjk6F8blxvIGWhhbTi9/g9sHAOSCUyLyZZYHmEw
 Dcf90kltYlXLKxbogZItAprDduEUzsApcBomwO9dRba2md/iNugwUH/8X5j5SYjvkhre7dKy07L
 +84j6e1xQFhXRgMg/etMblwG1YFf98YEAQem77z2HZQZ9ibOsSTAjnqb3Ql4KEtXwRkZJLmA4EA
 nUTggt4tppz0hxnMA/u+hX90nf38B2qJjEtA8qZCrlRo+Ra0rxRKfhKA9CSWHhDklqHO8V1gcZd
 Tqu6y93oEZqDyMvtN/AcqWd4SHDt3cWX7fWfzs1bcXjuwjQt0dkF64CIJpMtLMx1UAhzr+Rgda4
 WxrZi2wAcjkwKiYNdsqqcxh+S9mTpd0dmdy4T9pWvaGIuo+QkN7oRUmXBWcm8zHXoOUxLwQbu4M
 zYEPkmBqpJ2uYDU9P8g==
X-Authority-Analysis: v=2.4 cv=BpuQAIX5 c=1 sm=1 tr=0 ts=6993ee15 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=Tl0hoGAfEvBIV0USq3kA:9 a=CjuIK1q_8ugA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: Z-lGL02JO4fkiI8GQNTE1IoPmf2S8a0C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_08,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170033
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

On Mon, Feb 16, 2026 at 09:29:06AM -0600, Tom Rini wrote:
> On Mon, Feb 16, 2026 at 11:01:02AM +0530, Varadarajan Narayanan wrote:
> > On Fri, Feb 13, 2026 at 01:20:10PM -0700, Simon Glass wrote:
> > [ . . . ]
> >
> > > > > > > I haven't been following this, but what sort of args are you planning to pass?
> > > > > >
> > > > > > As of now, an argument to indicate reboot to emergency download mode.
> > > > >
> > > > > So how about adding a struct in sysreset.h where you can include a
> > > > > flag word and create a single flag for your case? We should be able to
> > > > > handle reset without the cmdline being enabled.
> > > > >
> > > > > There are other cases where this would be useful, e.g. an EFI app
> > > > > rebooting into setup boot.
> > > >
> > > > Previously, i.e. v5 [1] didn't have SYSRESET_CMD_RESET_ARGS config
> > > > option. This was added to avoid bloat code size for platforms that will
> > > > not need this. Please see [2]
> > >
> > > Sure, but you are adding a new method, so you could make it take a new
> > > struct instead of the string list, still behind your Kconfig option.
> >
> > Sure.
> >
> > You want 'request_arg' function pointer to take a structure instead of
> > 'char * const argv[]'. Is this understanding correct?
> >
> > If yes, this string list is what was given in the command line. And is
> > passed to the implementation specific handler.
> >
> > 	Command line -> do_reset -> sysreset_walk_arg -> *request_arg
> >
> > The implementation specific handler can interpret the argv[] as
> > applicable to itself. Not sure how to convert/parse this to a struct
> > that can be used by EFI app. Am I missing something. Please advice.
>
> Varada, do you think this suggestion is taking things in a useful
> direction? It's unclear to me at this point if what Simon suggested is
> going to provide something meaningfully more clear / useful or not.

At this point, for my case, it seems not needed. That is why trying to
understand his perspective to get better clarity and arrive at a
consensus.

Thanks
Varada
