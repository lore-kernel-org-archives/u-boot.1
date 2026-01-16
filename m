Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F4AD4A604
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 07:10:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C419283015;
	Fri, 16 Jan 2026 08:10:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kV0sw0ee";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I3QzqySP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E8398309A; Fri, 16 Jan 2026 08:09:59 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABB7E82BF2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 08:09:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60FMhIs72818797
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 07:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=zx2YTyp3UG1gUWNscDdmJDld
 RUuUo8o8DhhFt/Hak6U=; b=kV0sw0eeTup5J6hayD+9WL6pL31lCvf+ibc/n8tO
 ya74lkaMKcqBnWaIZ6gu5kNPOcHGgCdaMhcGgvfHj9hWG0aoYLLFcao+CC2jA+2v
 VndkUYrfmrG69XJKq8zciQAJAAsm68zhTr12Y62uP/UtdeeY1w+NgaF/xRA5NQD5
 xNHafK1eDeV0qiHvLS0k2bF7vZZzvg4u1ANvDUHEjE+6YvRDuU64EbAh7isvLBHY
 8cUWrSYC4FXVDRW4ZzY6FsH1hoE4EvelzyMQQjB4IuzttcdEH4WAofWdpaSVfmcn
 ZsVZhIffs8HlqIgsIpkjbLCzcp+lihL3WBWsFrzW3x3TEg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq99ah5xu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 07:09:54 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-34c64cd48a8so1748201a91.0
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 23:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768547394; x=1769152194; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zx2YTyp3UG1gUWNscDdmJDldRUuUo8o8DhhFt/Hak6U=;
 b=I3QzqySPcUu+gA1+D4kDDX2gzS6RR61XYnhosPiaBB7dvgKmsox6qQvFC7vApD0FQO
 D6MOAuN7JZTN5wo9YF7cEezAXewfvM72yH+yz8cofzVvTq3mS1DBf8OvyyltQbub3yzm
 E3diWxOmE1xC6k4lSlaOeYOO9Z/JQ8ZRrN5Rukt9ezFmW1Ye9r9ROmxGSfzLdsNCoitI
 +YAKXyVzqMA13FI5Shp4Ur7UClKNfXsosR0FFWkHKOP+b2ARWX99W4kcFB1XIUSKgUHZ
 Tahrdn1Yn6jYhsis+mGbBPypN5n0p+ZuMDufZEAiCfoI8KkMJp8o2nCxTx0wyxIe2JYS
 DrDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768547394; x=1769152194;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zx2YTyp3UG1gUWNscDdmJDldRUuUo8o8DhhFt/Hak6U=;
 b=gjDm41yPIttncWjxMPgBBNovcNWi1K7nsaTotLFztA5C7LgUJSwxOakgwhpPyARf+u
 XuB5caUyTQbgD/8HB0SWzQ8ewowphkuKKwn979LZsSWEhEJe90titkUiEdejV9np9uIc
 HV0bn1/FFImd4IoXjd+3+++COOo8fR2sViVnwGDkQWCIdeNFZ83rh8drD3tDQ/E0RRN2
 RQ/XNunBRrV6FzOFJuIr242J5o36xL7Sw/MIQix18kR+L6Y9jK+QTr5WoEFEpIZNsKGb
 TnoaN9eJI6Uzs5oAqaoBLyh0lQ/hiEzBcbMgZwDKF04vnVwoIiCjMVp2u1SeoEtEvFBi
 Cofg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgqwQpOW6GGPMQuGkKdvgDFlr/+YX/mr1NUWrwV/iQ4ivlzlopkDS0xaFljirDm63NQekK2aI=@lists.denx.de
X-Gm-Message-State: AOJu0Ywi6+XKwKtl6oAa2NcjTRo2mmSt6HVofiz8bbEsQn12QPlchX9S
 w/Hc1WAYyQ/zgmCBon079adDQQ6IaE9w4CAB4lNJJRjI7DwcJAeP3lOO8782YOmDVh5gCLD5dI/
 RTPMt8/culR9rQ3kU9m46R1Em6tk6o8zV9xxFNzSOhd3Kr2lARul+lWMu
X-Gm-Gg: AY/fxX7vAFAyITtZ7LdwctBsQGIAbRoUkfFzwkYYwVFY4/pHODBkAgxhTFrsE9buQ80
 It4xFAwvdqE3paNbb7Nk5swpvw6x3wfXktmPSKGEu4bdwxHix+u560uHzWi5HH/W+tYin0Qq0C0
 wmeozUVfNA6TDdA3KFulBB4OJh373YS05wh0N+iL+2tgDleIJnDth2D+EyJy3YbTyAQQOwoUHw+
 VAdMUDyNRrR4DbSNzQF/VzV1y2pxNkaoJN17zZBPd5KW9LQ5xvf/7pjn+Vvg4tk1IL8qBbVquXR
 D6Z1+bme3S9DvYPL8JGFX4VBgMZ7tN6KWtuehpcrMWfBUNKXLQzMF2jbNw4KolWN4JAl0DWmToi
 n6IkmphFSq0VXCC5ogHX51SIvauSFjQLZIGSUtVLTyLMX1ukztIXMnbjYZJ5tOfxGV47XyPYqQB
 BXveRummQnrjzWjn8Md6oaVrRN0rvdzfhO2KxWJTc=
X-Received: by 2002:a17:90b:2dd2:b0:349:30b4:6367 with SMTP id
 98e67ed59e1d1-35272fc6c03mr1744289a91.30.1768547393937; 
 Thu, 15 Jan 2026 23:09:53 -0800 (PST)
X-Received: by 2002:a17:90b:2dd2:b0:349:30b4:6367 with SMTP id
 98e67ed59e1d1-35272fc6c03mr1744273a91.30.1768547393503; 
 Thu, 15 Jan 2026 23:09:53 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-352744468b7sm406966a91.8.2026.01.15.23.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 23:09:53 -0800 (PST)
Date: Fri, 16 Jan 2026 12:39:47 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Tom Rini <trini@konsulko.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, ilias.apalodimas@linaro.org,
 jerome@forissier.org, marek.vasut+renesas@mailbox.org,
 christopher.obbard@linaro.org, me@samcday.com, michal.simek@amd.com,
 clamor95@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v5 0/5] Implement reset to EDL for qcs9100
Message-ID: <aWnkOxk5xiZDG5YX@hu-varada-blr.qualcomm.com>
References: <20260113103840.1948029-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260113144244.GV3416603@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113144244.GV3416603@bill-the-cat>
X-Proofpoint-ORIG-GUID: jK_pCL0eTyhZ4nr2j2XR2vBJctF3CYQ5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA1NSBTYWx0ZWRfX1eMLnQ0yH4bv
 b4x0Zd99NnQd1T+M1z1WikMNV0gTrKWt9KaswgNlZs1yYSyw7OUP4uEa4M1WBdG1gRGU0ZsSmq0
 8IgrX6zZ3/6TQUICLEEAYy8/6jvH6cVmaxXCmAyygNOg50SEKYrduFMt0y/HJBrYwGEL/Z950dr
 EXvDZDrwivcLxMgDNX7v4JZUGAAmef816WW4LUj/ZlJie7tKUrKAB3DWP6Q2OCjRO8FHcaj5U56
 bKQjNF0QDMmdhafSTnKWWvg4CJJECTHTnyQ2H/0MHZyIiFs8aXH60L+G6nYTCtwiwIA5wchh/Yj
 wLPE4/ybW2fvLBotT9qulUJwvlzhjAXSZ3GUeZlNGe38RQ97gpnnvvQJK5kezBV/XMLmrVZNFWl
 1l2Noo69avxz0mqnBXlR7EbqpRFHQYtTW24vGXnE8VJiwZi56nIT4Y/LZy1nQokBF0mt6bNUXo1
 6XYSZ9Vsu8T3NGxvViA==
X-Proofpoint-GUID: jK_pCL0eTyhZ4nr2j2XR2vBJctF3CYQ5
X-Authority-Analysis: v=2.4 cv=f5ZFxeyM c=1 sm=1 tr=0 ts=6969e443 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=YfCOm-DyAAAA:8 a=p8qblEsGCOWw3XjXDyQA:9
 a=CjuIK1q_8ugA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=zQLMK8awuJ6_Hvp-_9Ux:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_02,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160055
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

On Tue, Jan 13, 2026 at 08:42:44AM -0600, Tom Rini wrote:
> On Tue, Jan 13, 2026 at 04:08:35PM +0530, Varadarajan Narayanan wrote:
>
> > Using the 'reboot edl' command in Linux, the platform can reboot to the
> > Emergency Download mode. Implement the same for U-Boot.
>
> Have you used buildman's size checking options before? If not,

No.

> https://source.denx.de/u-boot/u-boot-extras/-/blob/master/contrib/trini/u-boot-size-test.sh?ref_type=heads
> may be helpful to you, as it can be a bit tricky at first (but IMHO is
> better than the linux kernel bloat-o-meter). I ask because, what is the
> size impact of these changes on things like say qemu_arm64 and qemu_arm?
> I saw the cmd/ portion is guarded by a new CONFIG option which is good,
> but I wonder about the more generic sysreset changes. Thanks!

Please see below for u-boot-size-test.sh output

$ ./u-boot-size-test.sh --board qcom_ipq9574_mmc
Generating board list...Processing #include to produce configs/socfpga_agilex5_vab_defconfig
Processing #include to produce configs/r8a78000_ironhide_defconfig
	.
	.
	.
Processing #include to produce configs/am69_sk_a72_defconfig
Building 2 commits for 1 boards (1 thread, 16 jobs per thread)
01: configs: am57xx_hs_evm_defconfig: Reserve EMIF memory used by PPA
06: qcom_defconfig: enable psci based sysreset
    2    0    0 /2              qcom_ipq9574_mmc
Completed: 2 total built, 2 newly), duration 0:00:13, rate 0.15
/tmp/qcom_ipq9574_mmc/edl5/boards.cfg is up to date. Nothing to do.
Summary of 2 commits for 1 boards (1 thread, 16 jobs per thread)
01: configs: am57xx_hs_evm_defconfig: Reserve EMIF memory used by PPA
06: qcom_defconfig: enable psci based sysreset
   aarch64: (for 1/1 boards) all +224.0 data +8.0 text +216.0
            qcom_ipq9574_mmc: all +224 data +8 text +216
               u-boot: add: 2/0, grow: 2/0 bytes: 224/0 (224)
                 function                                   old     new   delta
                 sysreset_walk_arg                            -     124    +124
                 do_reset                                   100     160     +60
                 sysreset_request_arg                         -      32     +32
                 psci_sysreset_ops                           24      32      +8
(no errors to report)

Thanks
Varada
