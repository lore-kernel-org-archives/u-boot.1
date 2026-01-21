Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661DAD262B0
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 06:42:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E873283B21;
	Wed, 21 Jan 2026 07:42:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lC7XKe/A";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UZeWDCQg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE4E383B23; Wed, 21 Jan 2026 07:42:24 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 064BD82A9E
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 07:42:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60L6Tk4G1036633
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 06:42:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Uob7DiQgJ0mU2uH78Gks/rH5
 JBTrMn2UIQqGINPcYbA=; b=lC7XKe/Agl11pKO80MMV3xM6eB4vyomAu9BwCZWm
 9UInO9pmvfU08CI5QOajCqyyCltPCbweywjLIZyMM4QLOR9CVNuJeatcmlF2M8nv
 ssSyaN3FUxDQUGj/TsVx+ymwNuQAu6B2y0urIW+ezulznJ1kUjjVCSVoYY3JP/lt
 u/tD55CSdxPtfWWLlk5Yzxd+m8W9VoT++0YrEKLd8HeAqQLBEv9dcECUQ6020VwD
 B3340XI54iw0TERdxmxFC4O48jE67uaj5MCnGkX0kAJpgOsa9SH5HHclr7YTiMBg
 7YTcRVBI4AnwbReDH3tNe7TAp2CNjYuFwSPqWjhq7/song==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bth55hv3n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 06:42:20 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c56848e6f45so3254025a12.2
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 22:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768977739; x=1769582539; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Uob7DiQgJ0mU2uH78Gks/rH5JBTrMn2UIQqGINPcYbA=;
 b=UZeWDCQgwQ0qX0416lQizFC4H5GNIQcLJJulJVr26HPJPvzItjP5K+o2iLN8LBVMSB
 yC+jNGPDcu1JHmY5k0ahLaRtKuxOs2sBstgLorEHmZDzdzWi4cOQD37bjUXg2xnDqLxG
 3cLqlVqh8KXaI2vgl6lIdVm/yuGmGPc7fnB4vy01+u9qoZ4S9/7VZa/HhGLbEEkkSBnb
 9Z2sCasw5UsrQxS5Q4t6SHJr0dJ0E5EsyVJoZABcdsqNiHBrJKYOvwuaHsDAK0sFflLz
 IoTEKfCjBFN/M9PYHx6f/GgmWBZ2iXG/93Vq0s9Qn6/zQn7O/xllwaO+dvIKrBD0p/GY
 1nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768977739; x=1769582539;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uob7DiQgJ0mU2uH78Gks/rH5JBTrMn2UIQqGINPcYbA=;
 b=r64ArJxWymgN0JssNYTDSez6aCeGRhI32nOQUpC89+dFkXMMFaTI43I/cw0xZjGdV3
 Yu/edHmUn+UFY76sF6nhxQTddRzI82iJIbPEvsTKb4/L+NSaU1I7CAxjgCFubaGIAK4B
 9f6KHagcqKpSJZY9MAwORMao506LuLVsH7T/ot/2Xo3bMDPrhweo5ElKauGU3fPl9ebE
 q5JfyI2E8CIMeJH8nU5GVwHaNmJY3InI/dZc5HtX00W/JsPaNBuTheI9t8TxEoichTZC
 DI5l1Vgvy/50opfkapOgw6BQx8Hb3+yGbaPVkK1ijG8jRPXte7RQwTkhc9xnhyRv360X
 HFew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdwdGekYDmUbEWRXz084tA/cBcepRZFG6Ni16cGlZzNILVNCAh9zI+S3MUioKw237PFDX6FRw=@lists.denx.de
X-Gm-Message-State: AOJu0YxxCuzIrNOToN+wskF1NcSkXpKleIy40pBEj8Rv+HtFwaB43f4v
 3+uINaheHUVMiOB/8cv9VP+9yVjZugCfhah1MS5ZMfUlyWLD35UQeEMI4jxYXeKthzEfy5UKSDa
 981hoAI/22gtNfYLQqxHah1gnZKkZVxJPjWs4eqKJX0lM57DdPv5XyWsO
X-Gm-Gg: AZuq6aKy6cv1jBTXWDs7ptVTh3M5HuNAj260PrlqT5yALY5XPT9L5sPkAAeA8WZegcj
 FrvviL0Y7WVUEkwli+rhaiWbYSYoIawN4E4tadsnljymdeyrwMQtI2AqreVvS6SifoqAsr2TtTq
 0QLUWOVpUub9Bt5rNUMRmDFwC4MQKULNo1il3nrFLilybCYMaBaGcXK+rfY7+3CFfwYZpjEOtoq
 2D+w7F4EhO4FJ3IrmAeQ5JJLv+f+FrgnHrzCYhjO45CwoALrT2V/tOl4tQ2oMqvPXJTIA+qTUA4
 57mDNn8zPU0MwJ7fVyUaN4qrxvuZsY6JwbEwELUVJQVdWNvtwysl+2WRD9tr5rHU1bmGZ97dmVv
 35FwQxATUuqwGCXdGgDowMuSBVnxEEIuEohzHaafGMgUK27AW8IqwvrY1fxeCgVmVvMoTlj7zvY
 7VLuyt4tBNpOnZJTYqDxMKuIHvr0XdKcIiv7x1DM8=
X-Received: by 2002:a05:6a21:8213:b0:38d:eef7:6acf with SMTP id
 adf61e73a8af0-38e45d5c8b1mr4059281637.31.1768977739429; 
 Tue, 20 Jan 2026 22:42:19 -0800 (PST)
X-Received: by 2002:a05:6a21:8213:b0:38d:eef7:6acf with SMTP id
 adf61e73a8af0-38e45d5c8b1mr4059268637.31.1768977738926; 
 Tue, 20 Jan 2026 22:42:18 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c5edf249c24sm13885758a12.11.2026.01.20.22.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 22:42:18 -0800 (PST)
Date: Wed, 21 Jan 2026 12:12:12 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Tom Rini <trini@konsulko.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, ilias.apalodimas@linaro.org,
 jerome@forissier.org, marek.vasut+renesas@mailbox.org,
 christopher.obbard@linaro.org, me@samcday.com, michal.simek@amd.com,
 clamor95@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v5 0/5] Implement reset to EDL for qcs9100
Message-ID: <aXB1RFNAPuwZ4U5a@hu-varada-blr.qualcomm.com>
References: <20260113103840.1948029-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260113144244.GV3416603@bill-the-cat>
 <aWnkOxk5xiZDG5YX@hu-varada-blr.qualcomm.com>
 <20260116144355.GK3416603@bill-the-cat>
 <aW3DjqaULjsb32QU@hu-varada-blr.qualcomm.com>
 <20260119170701.GD3416603@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119170701.GD3416603@bill-the-cat>
X-Proofpoint-ORIG-GUID: MG6wLHbVtXunyKHAANkp1LYNTuVNQpNY
X-Authority-Analysis: v=2.4 cv=Oa6VzxTY c=1 sm=1 tr=0 ts=6970754c cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=B1HSPpWXsJd6grJeN-oA:9 a=CjuIK1q_8ugA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA1NCBTYWx0ZWRfXwwa5nIRI8/Lc
 mqwTACPpSV/1mSNFwurqtPQDDu2uzmTG3Se88U8yMpi3BkJeQjtKrW+171s9Yrd6t2pJTBFXNaF
 y8dyXr6jfbP8aZ8UHpgm85v8VH/ImDSt0EAq3N2aGOEEmdUalZbxTfxSy17zTHo+VIoETIots7k
 dySRg3GAxj3MlL46/ZM2iouKWLrTG5QRNuYxddrcVEKBaUCWUwKYIN39pITs/WRoLoyiTiLPXoz
 kKmAPEqzl8sr4XGqQj8hgGKVOL109Di7DL7kGFEj5Jy1cIUknHlzCPwzQPv4rwqUagW3kRM/oaA
 NbOfGlI4VGS7f4EDk6+u+kXa4K5NCyuYFqeQp87fbsXie6NiWQRkuQuu3XDFFtF6olYyzf/A81r
 VIuYWet5gKNRMd8zGaBpcZIcOw8PXRQ0O0RwFbZ3tjHhpgyX8qc0zZMWUHgQL8VYyjitL9G1Y6q
 2NhHLyS6rLG2HqtM9LA==
X-Proofpoint-GUID: MG6wLHbVtXunyKHAANkp1LYNTuVNQpNY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210054
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

On Mon, Jan 19, 2026 at 11:07:01AM -0600, Tom Rini wrote:
[ . . .]
> > $ ./u-boot-size-test.sh --board qemu_arm64
> > Generating board list...Processing #include to produce configs/socfpga_agilex5_vab_defconfig
> > Processing #include to produce configs/imx6ulz_smm_m2_defconfig
> > 	.
> > 	.
> > 	.
> > Processing #include to produce configs/genmai_defconfig
> > Building 2 commits for 1 boards (1 thread, 16 jobs per thread)
> > 01: configs: am57xx_hs_evm_defconfig: Reserve EMIF memory used by PPA
> > 06: qcom_defconfig: enable psci based sysreset
> >     2    0    0 /2              qemu_arm64
> > Completed: 2 total built, 2 newly), duration 0:00:19, rate 0.11
> > /tmp/qemu_arm64/edl5/boards.cfg is up to date. Nothing to do.
> > Summary of 2 commits for 1 boards (1 thread, 16 jobs per thread)
> > 01: configs: am57xx_hs_evm_defconfig: Reserve EMIF memory used by PPA
> > 06: qcom_defconfig: enable psci based sysreset
> >    aarch64: (for 1/1 boards) all +216.0 data +8.0 rodata -8.0 text +216.0
> >             qemu_arm64     : all +216 data +8 rodata -8 text +216
> >                u-boot: add: 2/0, grow: 2/0 bytes: 224/0 (224)
> >                  function                                   old     new   delta
> >                  sysreset_walk_arg                            -     124    +124
> >                  do_reset                                   100     160     +60
> >                  sysreset_request_arg                         -      32     +32
> >                  psci_sysreset_ops                           24      32      +8
> > (no errors to report)
>
> That's not great. Can you please look at if you can cleanly rework your
> changes to have less, or ideally no, size growth on the 700+ other
> platforms that enable SYSRESET? Thanks.

Have posted v6 [1] addressing this, please take a look

-Varada

1 - https://lore.kernel.org/u-boot/20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com/#t
