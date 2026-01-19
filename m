Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BDBD4A5EB
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 05:39:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D2EA8307F;
	Mon, 19 Jan 2026 06:39:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lxnhzh7q";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jVULuDGE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8207F8004F; Mon, 19 Jan 2026 06:39:39 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB8C58313B
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 06:39:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60ILYE28113385
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 05:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=BlaF2yVRJbb1PhoAwfXRElf5
 znnBJTOEm1l5RKIpKR0=; b=lxnhzh7qkt3DCz1bzLeQEBGb/e0ZnYAETKlqLC4m
 dDvr7YZ86ontzd4sQ1/i1+0CbF8hM4BdnwMoCygv5cSNcWJY5/9Oq8Y8Gaqd/LQs
 0sVTb/np+aA+DSBjmVB/kQvqfdDe+c7EtcxX6XWtJmUH3vTYTxeTB7F6lQRBsA9R
 KMt95UMCwYYLpc9PawhyAGmrxzJRA0wtYwSJTdowRmrasd2nIr4HI+PAjPprtwb8
 bnLeFbBrB8WdDqaxn/TDWFEIJeu5D27GsW9GT9HIIBEPoKTXQqzTqgEc00E9eMhY
 uI4b9EB9rUVezuvYVPEpsHXDGr8m0csdsS+45KW5cDEB5g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4br36dbrbp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 05:39:34 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-34e5a9f0d6aso3889092a91.0
 for <u-boot@lists.denx.de>; Sun, 18 Jan 2026 21:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768801173; x=1769405973; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BlaF2yVRJbb1PhoAwfXRElf5znnBJTOEm1l5RKIpKR0=;
 b=jVULuDGEZtPYucTKtjLGF1TvVfKpkaV2Tmj0ZFycazIYmfUYNXVUeYSI9eELMZ5wIw
 yEfzqUwgPSzSuTUtlfwTaxR5sfpzBbIHPvhPD2OYJNy0CS8cjG8Ae049i0JPe9iJRwYO
 /jW0qfxHHTDSUGbEO8vycDkfldsxvBKkpQHvdrOL8zeR8YuUHCaEb0ko4cQ9PiKwjH0Y
 Riv8gIqer58aZkLefNd7yZwqfn3i8ax6pyNakevVMxn5wEMoNjMEJhdZS8m6cFlN1BsC
 KGYfQHMcX9V9ppw2Pokm66XGwPU3VAPmhFRbs3B9YInn0nQxA3LcUnqVNGOCs4mVU1UG
 iBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768801173; x=1769405973;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BlaF2yVRJbb1PhoAwfXRElf5znnBJTOEm1l5RKIpKR0=;
 b=bK4A/x9CIGtqim0kmTqF0FhwivBeed9qA54S40QJd/QtqVY67uqiSDZXParEbdNFY7
 jmA1QBissFN0qNUn77+rRFzHKAQxYPvKpoczTBMb/6iQ8Fo960+d8Iliv88kRpoODA6n
 S4NnD29qIrmmQClOjR6LN7UQPVzc6YR2KkORAJ8QdYQ0/TyzCtnnwkZ2ucJ9xRuyApLN
 /q9agOKcu1zlhPctB19lfwNOAL0PxkPhtwb5cafWxCW+3Q3KZ8/cmFSiUCORtMzAqV6k
 yNeXRQjRRV++nkKIVrBoKt6NXuO9w/ACYrjMA7Ebb+9qiwv4yiBK1l2DIJ1+KoEtu6z6
 M+Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9007sVeFTgHuziRquwwpkI1RFMnDq7TXDPTk+j3S+5IdfCYWThcnij8YVdclQ/YLAxSwDdg4=@lists.denx.de
X-Gm-Message-State: AOJu0Yzyflukuj+QxDiSBb8vFDxu6b6x3aB3ihl9HQYE6psS71D+rrM0
 0E2268l5h+fFwJUY/lLysEeTF8VxKOlJWPH6qUKv6NGgn2gmU59EOBzzNPef0v5C1km8TVzyjFA
 CO7UXmFZMFG5jgCdr018OOzqSCMrFNAPAZ4bKD+LsU3LaDciKpncVORT3
X-Gm-Gg: AZuq6aIumVn8Y0GOu5yPmwmmKwe9ps56zi+8yL/ttXRAtucEwVCYZg3rKcaWXkG5YXv
 NNFPRst9tlyBnoqxKZhBf5YRfqmymPua6pOxGJcdaEvwMBBhwAp7QnEr2DPMkG/lYFB6xCJM0Y4
 bNkeIee3FR5h+xPyrakRdZoBDLL5P1p399MIasuGmB5pgGNFa44PzdkoMrMTbgxb6L5Y5L3CKag
 Jvfy9ZJ4NVBCqbgAoZbjCvZ41bkvMbd+LvjRxDUJQY7ylb9xGFY4cC0C3CP3kECXNzbCuO39sRH
 vH3KQH6lVkodOfmG0SFs5bwuftMyO7Yquz91DAnMuM0TLENXRBtK/p2OcFSGDJpVuoG2XL5khCj
 bMMd5y7B2IvikMeDE33fJ5XylKnp/e0OLdCHjaZe6u4rbucGIMCCp6NzPot3x9T/HyO2EWaSTJN
 q8A1eT0eu/q9FfiyxCjav/Lei0SHoDfdNDT1qjQ3w=
X-Received: by 2002:a17:90b:2dd2:b0:343:e692:f8d7 with SMTP id
 98e67ed59e1d1-35272c8de28mr9672919a91.11.1768801173445; 
 Sun, 18 Jan 2026 21:39:33 -0800 (PST)
X-Received: by 2002:a17:90b:2dd2:b0:343:e692:f8d7 with SMTP id
 98e67ed59e1d1-35272c8de28mr9672904a91.11.1768801172901; 
 Sun, 18 Jan 2026 21:39:32 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c5edf354b16sm7993196a12.30.2026.01.18.21.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 21:39:32 -0800 (PST)
Date: Mon, 19 Jan 2026 11:09:26 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Tom Rini <trini@konsulko.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, ilias.apalodimas@linaro.org,
 jerome@forissier.org, marek.vasut+renesas@mailbox.org,
 christopher.obbard@linaro.org, me@samcday.com, michal.simek@amd.com,
 clamor95@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v5 0/5] Implement reset to EDL for qcs9100
Message-ID: <aW3DjqaULjsb32QU@hu-varada-blr.qualcomm.com>
References: <20260113103840.1948029-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260113144244.GV3416603@bill-the-cat>
 <aWnkOxk5xiZDG5YX@hu-varada-blr.qualcomm.com>
 <20260116144355.GK3416603@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116144355.GK3416603@bill-the-cat>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA0NCBTYWx0ZWRfXz6aSApDSCiH2
 1xkAyQdxSC2GnIcGisXW7h2+3dnGGptr3CSazHJ7SDNfqAPSOro26gFrCfWtao1SFgQOyM63BWf
 JopjmJyKGDOTRtFwphOIi4CUbveseWKxaBjtp5Cm7fyObMgeFTcdj+lk4pW95rskqVjPHCoCC4p
 jMphKVTh+95Si4UAZjWs1DyQfO+99rU066lwZM3qMu0tZLl/g8ijoFZnCFbfar8OUi5WdrMQojp
 V+92udHDauDx1yzMfpl0RNyKxHCnNUoG70nI1kyWSHMA5aEvZKSbXeHnW642W+LI8YDjs8qF5sz
 t+/ZwzsxJVgBdZwl6Bzm6a1dJoUPD5Gp/f3Mkme3Q0I7SsYBEJvfI8sSFjC+EAeJEwc0H4kXvXC
 5RPwGAf9dH2dUo8/dNQvhPmKyLvOcmM/ifpUSoj4SC3zlIKWbyJt//ukWXTCgcIu+cHQqfFpIQQ
 mBXhhk7CYZM1gERUPoA==
X-Proofpoint-GUID: HfDQgsew41A_MrE5FJkVJrXPLzq119A4
X-Authority-Analysis: v=2.4 cv=GJ0F0+NK c=1 sm=1 tr=0 ts=696dc396 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=YfCOm-DyAAAA:8 a=MRX72g5zeYc0j_hlgaEA:9
 a=CjuIK1q_8ugA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=zQLMK8awuJ6_Hvp-_9Ux:22
X-Proofpoint-ORIG-GUID: HfDQgsew41A_MrE5FJkVJrXPLzq119A4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601190044
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

On Fri, Jan 16, 2026 at 08:43:55AM -0600, Tom Rini wrote:
> On Fri, Jan 16, 2026 at 12:39:47PM +0530, Varadarajan Narayanan wrote:
> > On Tue, Jan 13, 2026 at 08:42:44AM -0600, Tom Rini wrote:
> > > On Tue, Jan 13, 2026 at 04:08:35PM +0530, Varadarajan Narayanan wrote:
> > >
> > > > Using the 'reboot edl' command in Linux, the platform can reboot to the
> > > > Emergency Download mode. Implement the same for U-Boot.
> > >
> > > Have you used buildman's size checking options before? If not,
> >
> > No.
> >
> > > https://source.denx.de/u-boot/u-boot-extras/-/blob/master/contrib/trini/u-boot-size-test.sh?ref_type=heads
> > > may be helpful to you, as it can be a bit tricky at first (but IMHO is
> > > better than the linux kernel bloat-o-meter). I ask because, what is the
> > > size impact of these changes on things like say qemu_arm64 and qemu_arm?
> > > I saw the cmd/ portion is guarded by a new CONFIG option which is good,
> > > but I wonder about the more generic sysreset changes. Thanks!
> >
> > Please see below for u-boot-size-test.sh output
> >
> > $ ./u-boot-size-test.sh --board qcom_ipq9574_mmc
> > Generating board list...Processing #include to produce configs/socfpga_agilex5_vab_defconfig
> > Processing #include to produce configs/r8a78000_ironhide_defconfig
> > 	.
> > 	.
> > 	.
> > Processing #include to produce configs/am69_sk_a72_defconfig
> > Building 2 commits for 1 boards (1 thread, 16 jobs per thread)
> > 01: configs: am57xx_hs_evm_defconfig: Reserve EMIF memory used by PPA
> > 06: qcom_defconfig: enable psci based sysreset
> >     2    0    0 /2              qcom_ipq9574_mmc
> > Completed: 2 total built, 2 newly), duration 0:00:13, rate 0.15
> > /tmp/qcom_ipq9574_mmc/edl5/boards.cfg is up to date. Nothing to do.
> > Summary of 2 commits for 1 boards (1 thread, 16 jobs per thread)
> > 01: configs: am57xx_hs_evm_defconfig: Reserve EMIF memory used by PPA
> > 06: qcom_defconfig: enable psci based sysreset
> >    aarch64: (for 1/1 boards) all +224.0 data +8.0 text +216.0
> >             qcom_ipq9574_mmc: all +224 data +8 text +216
> >                u-boot: add: 2/0, grow: 2/0 bytes: 224/0 (224)
> >                  function                                   old     new   delta
> >                  sysreset_walk_arg                            -     124    +124
> >                  do_reset                                   100     160     +60
> >                  sysreset_request_arg                         -      32     +32
> >                  psci_sysreset_ops                           24      32      +8
> > (no errors to report)
>
> OK, so minimal growth on the platforms that would use it. How about
> platforms which don't? qemu_arm and qemu_arm64 should build the sysreset
> code in general and that's where I'm most concerned, platforms which
> aren't using this feature. Thanks.

Please see below for u-boot-size-test.sh output

$ ./u-boot-size-test.sh --board qemu_arm
Generating board list...Processing #include to produce configs/socfpga_agilex5_vab_defconfig
Processing #include to produce configs/imx6ulz_smm_m2_defconfig
	.
	.
	.
Processing #include to produce configs/am69_sk_a72_defconfig
Building 2 commits for 1 boards (1 thread, 16 jobs per thread)
01: configs: am57xx_hs_evm_defconfig: Reserve EMIF memory used by PPA
06: qcom_defconfig: enable psci based sysreset
    2    0    0 /2              qemu_arm
Completed: 2 total built, 2 newly), duration 0:00:18, rate 0.11
/tmp/qemu_arm/edl5/boards.cfg is up to date. Nothing to do.
Summary of 2 commits for 1 boards (1 thread, 16 jobs per thread)
01: configs: am57xx_hs_evm_defconfig: Reserve EMIF memory used by PPA
06: qcom_defconfig: enable psci based sysreset
       arm: (for 1/1 boards) all +184.0 text +184.0
            qemu_arm       : all +184 text +184
               u-boot: add: 2/0, grow: 2/0 bytes: 184/0 (184)
                 function                                   old     new   delta
                 sysreset_walk_arg                            -     104    +104
                 do_reset                                    92     136     +44
                 sysreset_request_arg                         -      32     +32
                 psci_sysreset_ops                           12      16      +4
(no errors to report)

$ ./u-boot-size-test.sh --board qemu_arm64
Generating board list...Processing #include to produce configs/socfpga_agilex5_vab_defconfig
Processing #include to produce configs/imx6ulz_smm_m2_defconfig
	.
	.
	.
Processing #include to produce configs/genmai_defconfig
Building 2 commits for 1 boards (1 thread, 16 jobs per thread)
01: configs: am57xx_hs_evm_defconfig: Reserve EMIF memory used by PPA
06: qcom_defconfig: enable psci based sysreset
    2    0    0 /2              qemu_arm64
Completed: 2 total built, 2 newly), duration 0:00:19, rate 0.11
/tmp/qemu_arm64/edl5/boards.cfg is up to date. Nothing to do.
Summary of 2 commits for 1 boards (1 thread, 16 jobs per thread)
01: configs: am57xx_hs_evm_defconfig: Reserve EMIF memory used by PPA
06: qcom_defconfig: enable psci based sysreset
   aarch64: (for 1/1 boards) all +216.0 data +8.0 rodata -8.0 text +216.0
            qemu_arm64     : all +216 data +8 rodata -8 text +216
               u-boot: add: 2/0, grow: 2/0 bytes: 224/0 (224)
                 function                                   old     new   delta
                 sysreset_walk_arg                            -     124    +124
                 do_reset                                   100     160     +60
                 sysreset_request_arg                         -      32     +32
                 psci_sysreset_ops                           24      32      +8
(no errors to report)

Thanks
Varada
