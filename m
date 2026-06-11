Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A70CD98D5
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 12:47:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28A0F84996;
	Thu, 11 Jun 2026 14:44:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pynrPlPE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iVuO0P97";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA0338407D; Thu, 11 Jun 2026 13:37:01 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78061838D7
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 13:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B9x62B267528
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 11:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ImO16dnA7Zxc28kcoyU8VmVn
 +oMQgUE9wAcEAopOTLE=; b=pynrPlPEdGwVk/oM2rthw1IiaqQYWELtrWcH/vhJ
 qkAlJ7ksP/tcdrMHrAdd9BDOK8G28/1PL09Iotb0wy+Ytp7piRQfkedzNzDD3u7b
 wmwpZoBqc3CQXrVoYe9+ZKy98DaEqKyjHxMH7iDXuETGoH5Sex9rRqfzUmEdxUN4
 nKC6wdx/ctTZ80WtvyIeIHBAnQrHLfkH2Va7sFhevuSiA9nJnsys7n2nEWNjd3Ih
 r4/CUuAL/RapTLo/WRT49bCXFJUXhXDE2SjBNvZXuIH/r7OC4eEE2s5HNPynJ9W9
 2CoKbMZbFSWuNYzY0AAwwMrcNN+/6g7JKkdoq3K+4zGlXA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6u365d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 11:36:57 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2c0532a6588so73074745ad.0
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 04:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781177817; x=1781782617; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ImO16dnA7Zxc28kcoyU8VmVn+oMQgUE9wAcEAopOTLE=;
 b=iVuO0P97cploR4bYeDBARDVt5CPC5JFL2P0Eo2E/6ImJLczmIuAcNeUMLsqEo1X+8W
 4xbfudQx7Jys1yV3cfbTGV0kXWJuXVBdYMoZ6QCsw6z3RDo0dMc4qjqJR/5Qsya71eNH
 BYvrvT07vMqvWNAzOfVZJZJJfkp5yPFjzWkvHZwRcz1eW72DbHT1/q/0TdRvYKiv9+xD
 lEa9sGRgMRnrhvky0zrOqK7gHtE57zf/TUx4A1Nz0p21BB0iZbU7k1H24uZckL5QEcQl
 V1Jpt0DsjrsAflWHFYc5MNEg3tXge1QQ/b+VVzHcarn4l6RYOriFMr5PWODWnqWmTGbg
 u/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781177817; x=1781782617;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ImO16dnA7Zxc28kcoyU8VmVn+oMQgUE9wAcEAopOTLE=;
 b=D3SF9bsw+g1oa6jb3p1PU2xmKk4upWCCAHdMY1EDFWbqOqf0v8giYLuvD7nV23Fp0A
 sWeDfPY91K57dFNklLlBuJ9Y9hX3n7mdU7i/DdKYoDOCgNdr67G3ODRjlzqTSEVDnM1E
 Lik0Lfg77cg4UOTheaaOqOaKu6SRruhTRhjT1xfDBHMmIZ+vTpUtPVrvcSacHZOC7Ui1
 KkI1mtUZcoutJN8vZpm+VqYS4oIcD466SpoqXkw8dgdD0nyeNPpVA6OPrDcfGIEW7NET
 m4ZXLUHPtBPARyjvDXnzUqzGgCH0fgnJL2RE/EFJzRbpH9ySTpjjDDTSypFbS3l8Poxj
 GcHA==
X-Gm-Message-State: AOJu0YwQroYgooBWFFnlH/HAwMn5RTXW6zBQhjP5By4P7ytD2Ertw09O
 +eLXiB7fcB8fkQQ7ZqOQmq4QWSFDK7QaEpHadUcDFGklgK+ohIyHzexbwS2r5utEuEgDeAVaS2y
 lWHHADW0ZigDpXGi3LyQEHMeM/YrBeKghKQkt4tzM2qGEQGftznE5OSSO
X-Gm-Gg: Acq92OEU/kZ6wark4Wz9I3cBOF+v08/zFAn632+lPx1eVo09DrMAUEmMaHKzC1tKeTH
 xuSLXF2nXkjIY3znUvwOqa6ZknLhaeYBlx9/7Cvh7YAgmA8iCJ5sCST0cDiXeepRc57qrZP47ih
 kcA2i9WUyvXWJC3JkYIK0sVqmJHvkERs2q4BjVofrOM75n6a5bMpQvvGfp6DV4QkRnYo0UOg0FV
 ++kSudg+fbYdE1vc7tNWzYM+piGpoRr3Jd93EQ+vrF7JprdkzFZNUBKtDDxel329T60flT0/NZ9
 QotYXLj2VsCbVMUVADTDPml9jg7e2n15MY7lmkZMk9qOB+GtQalFzAUUEH8XwdtOkZ1eBaoNB24
 TE70UerSlF7H0difVb9iNfmo2pHlKKUShYCFbnEFQwMDXbOBgSRIOfNGM3XjDmlETIEJK9KZh9a
 g3IasXobOy1GSSCPIKnaZW0ipym1MMWOD1UUFdN9V7a8VzQ3G9ToQVZRQx/wVVjw==
X-Received: by 2002:a17:903:acd:b0:2c1:f29a:b554 with SMTP id
 d9443c01a7336-2c2f21a11f5mr27129585ad.21.1781177816773; 
 Thu, 11 Jun 2026 04:36:56 -0700 (PDT)
X-Received: by 2002:a17:903:acd:b0:2c1:f29a:b554 with SMTP id
 d9443c01a7336-2c2f21a11f5mr27128825ad.21.1781177816274; 
 Thu, 11 Jun 2026 04:36:56 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164fa00b3sm262086895ad.32.2026.06.11.04.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 04:36:55 -0700 (PDT)
Date: Thu, 11 Jun 2026 17:06:36 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <joaomarcos.costa@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Javier Tia <floss@jetm.me>, Rasmus Villemoes <ravi@prevas.dk>,
 Jan Kiszka <jan.kiszka@siemens.com>, Dhruva Gole <d-gole@ti.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Simon Glass <sjg@chromium.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peter Korsgaard <peter@korsgaard.com>, Heiko Schocher <hs@nabladev.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Jens Reidel <adrian@mainlining.org>,
 David Wronek <david.wronek@mainlining.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Daniel Palmer <daniel@0x0f.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Yao Zi <me@ziyao.cc>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 David Lechner <dlechner@baylibre.com>,
 Bo-Chen Chen <rex-bc.chen@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v2 08/14] phy: qcom: add SPL_PHY_QCOM_QMP_UFS for SPL UFS
 boot
Message-ID: <aiqdxFntQsatnSmT@hu-varada-blr.qualcomm.com>
References: <20260606-spl_ufs-v2-0-72fed24ef01b@oss.qualcomm.com>
 <20260606-spl_ufs-v2-8-72fed24ef01b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606-spl_ufs-v2-8-72fed24ef01b@oss.qualcomm.com>
X-Proofpoint-GUID: gqdNK2hpqbd-CUvyw0LQ4cuXMpJ_Smci
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDExNiBTYWx0ZWRfXzdO9Wd9xPT0b
 7v1io51EfA5cI+TOSRaNCHdEKvzRmzbb61guRdQsWlH3GEV94YLpdyb3pR4HlGqgvLymoPj0339
 5h3+c/OHnpcOc83D7qmsyW5MQnX3gD0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDExNiBTYWx0ZWRfX9oXefduUl4vk
 iNh12A9IXYZkj7DRZvcPWBU/4BM2Z8zjysE2FfpLgbRW4qTIW60s/UYOyy5GlEeydbAV73ai1ST
 /WUPmVO5vXwNVPPw2p0vdU4M3toFykSqCIfWY9+O7eIaQWVIuDi7X6dFNSEanhIjWjLL14/ql+h
 ihY5Y6QoZihjgO0GRHBjw5shBgteHZ7odK0tGJEq5YdnO0z+t0DwcHe2RMMBASTE0vR7FLD3yFU
 0qutE0AdTiCErBMuin0SKryUyQEN6OwDapO5XCNosbVU1ufaXEgTD38uXhvdTlk80rIIvPyQwDl
 lReIXvWJ8YuSvcy+H53RVYiomnab5SX8ngpVJZq3iJq18LQuOPKZnDTN+FknC8ToD8gChB8S8/R
 SZ8+YCgGRXFbORsjT3NP0OzogIhfeGDI3zpjG4B7bzqpEaX141a6Sj3CHTp/tpVEhteCYCMUhBb
 LLzwCXz5WFvQwl0eeSQ==
X-Authority-Analysis: v=2.4 cv=F5lnsKhN c=1 sm=1 tr=0 ts=6a2a9dd9 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=apS4mnb-EXvwoMepENMA:9 a=CjuIK1q_8ugA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: gqdNK2hpqbd-CUvyw0LQ4cuXMpJ_Smci
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110116
X-Mailman-Approved-At: Thu, 11 Jun 2026 14:44:23 +0200
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

On Sat, Jun 06, 2026 at 03:48:39PM +0530, Balaji Selvanathan wrote:
> Add a new SPL_PHY_QCOM_QMP_UFS Kconfig option to enable the
> Qualcomm QMP UFS PHY driver in SPL on Snapdragon platforms.
> This is a prerequisite for UFS boot support in SPL.
>
> Switch the phy-qcom-qmp-ufs.o Makefile rule to use the $(PHASE_)
> prefix so the correct config symbol is selected automatically
> for both SPL and U-Boot proper builds.
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

...
