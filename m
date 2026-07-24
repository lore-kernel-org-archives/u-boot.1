Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F591C531C9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 10:50:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3801A607B8;
	Fri, 24 Jul 2026 10:50:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2s1yOOMbE9eS; Fri, 24 Jul 2026 10:50:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 52109607A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784890207;
	bh=I+/Uq0BEUFhnM3fwj2dnzF7X3nkG0QHhAFcDBOA1qtE=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=SRJ41svdlXBdqQ7k82bP13PphAlEbub4KinU7P6aKWdo49coo7TQm0ln5Lp7cbYZQ
	 CROcnPYMDWxXvoDcLu/0vOpkxkuGlDCY4pizGxmLPDT0H3jpqjV+QjVP5EqZ+PP+1j
	 Vk4NbuZMwc31CzffudM4tEiD9fCeSiRdjpuJkIcEDSDxznCg/pIsR8xD6eKkwvo82u
	 rP5T+CAE5Mngrm6R4s41qnJiyz8XurgCPTIecPEc9z6IVbHiXcky4Nw+RTIiQgNks+
	 gxy+FDm4r7Rsr16gRUHVs90UsLnVneCprMsSOP+Z2vdEGH32080+Un86ObR/Bp1sI2
	 PvgHlU3lUHldw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 52109607A8;
	Fri, 24 Jul 2026 10:50:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F2F7D347
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 10:50:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E4A5140A40
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 10:50:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1ApcmLLkEMWv for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 10:50:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2769640A3C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2769640A3C
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2769640A3C
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 10:50:04 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66OAE1pc2889416
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 10:50:04 GMT
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm61kg4q4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 10:50:04 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-84870e7f498so297480b3a.3
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 03:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784890204; x=1785495004;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I+/Uq0BEUFhnM3fwj2dnzF7X3nkG0QHhAFcDBOA1qtE=;
 b=k4Ig4iskDrj81SDuEVJxamFF58n1cy0cDU08wSJxahlpCTTy+QZBiMchTcztEiXx0f
 nmBDBqpDcyoQnRMMPebA3pMJBAYZv1RhquRbqYirkq7cO0IMNG2teRI2+qCEdnwsahHH
 m3/nMRpuwuHVGcFMhtRIiYHypJhvW4PAXGZokQvuljT9PWZP96lIjEscjiD4GFLkXBG5
 AektpytH6If0PtryLVZjMEwWgxHvFoGkuIiY2J9MLJ6Jv69/RCAi1hgNn3em1DyiNCgA
 eUNdjue5kxg10HwwbCznTn2PpteAEhXJ3dDjrMm2qWHDOhCtoOW+s5Ka3Ae7vyQSqE9m
 DLGg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp15CNyiQuplCJ5JVoRslITnaulbG23T/w/zHYTaSf51K9iIX951UyeVU4jJRBSWaHGRmZXU+8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwvijAd7CdqcvRnrYWh3V1SEwRUn+3E6ExkUOLqWkV/3T1C+yH7
 +vBamh2KMvceicReta7WKGYWhL3POaVPTkVUkK18L0YO4SvcYgphTyhENUCPRal9jTBzA72nwvX
 sui5SbVJqR7+thHcBNX8kfH/zovDmDvYlgdoaExYpwWPyptPsfRoK7q2ukRxxJI8987s6Y84=
X-Gm-Gg: AR+sD10UrdXqegnO8HslyiNW4L4T8uk8X6WwMQFUIn1V8AROgDn4jciK+GE/I7tmfkj
 rJKhtYavuq0yw/w1LjTvAnplmck2SDKO31QMSI3wgmemd5McFzivSFMvfCELZ8dV9ORh9Hy0jDB
 Cb3/qYPa9JWTN4jObWKFJW+O/TLeNU62+NkumYMoLRhP5urnBADzJhF4vK3J2jPpCnocWoUhmq/
 ZXyx7z2jkHegEqU7FrjEigsrOeX/k0nIhxjtGpzvEES5hObe2ymYyt1p9iHmpJa6QljIsgRn0ju
 YMHy2gfY7IUC5ebIHWJao1wPCxqS6bSeFQRJvvYTIH7VrpSNlRFlPuhRY8Glk4vQavnHLuWuWM3
 hv1QFKILAsl8rHcSG7WpXdDXrqnskqVupOLHGgNDo10m6ymcDdRlmPnLKdvRZjF6LzL5BV1FKQ9
 ZkTU6MnGNSfjG4qVlIOTF/xhVzFV+nWQ==
X-Received: by 2002:a05:6a21:9086:b0:3c4:2cf9:28ad with SMTP id
 adf61e73a8af0-3c44afcd274mr7934294637.12.1784890203810; 
 Fri, 24 Jul 2026 03:50:03 -0700 (PDT)
X-Received: by 2002:a05:6a21:9086:b0:3c4:2cf9:28ad with SMTP id
 adf61e73a8af0-3c44afcd274mr7934279637.12.1784890203399; 
 Fri, 24 Jul 2026 03:50:03 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147df0ba0asm27208036eec.18.2026.07.24.03.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 03:50:02 -0700 (PDT)
Date: Fri, 24 Jul 2026 16:19:57 +0530
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] phy: qcom: qmp-combo: honor USB-C orientation for port
 select
Message-ID: <amNDVVLvTZaerWkg@hu-varada-blr.qualcomm.com>
References: <20260724-kodiak_ss_orientation-v1-1-d9d8fd271e0c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724-kodiak_ss_orientation-v1-1-d9d8fd271e0c@oss.qualcomm.com>
X-Proofpoint-GUID: JOVJFlqKqtc6DDDMPxslCJ3NomUjS-4O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA5OCBTYWx0ZWRfXzrGiAT989alY
 VghhcYNVhc/v4cvjIIY+j1eEONf+r4IHPHBIN9MlTsHt7qzSrkm6ghK0gZFTMfcDkm6mhwVF78Q
 Pi/EloXBnnB4JgnBLeyA76Iz4fbuz77ZmWqlVqBWrflem1x9YqDxi/st6Q0Sa/IPQEdVZIrfgq9
 0cs4iaBtP+2NSiLrp2PI0n5FbGA1A6a5iZ7zRUAjFaRI5II8nvboWHmUlb6u/JeIDhE+ybpaWBI
 eXiK+y/BnXYyCUJ3UFfaHU7WhzjL5PjNDv2+tKJxCgCzbnRtZ+DVeMu5hxBw0k+c2i70f9xONLI
 YBu+9xOU/ctMAl1aYictGuLSOCVZtvzp3NmCemNpFQJ4bOVPF8MmMbKlUYFXUs008v0wYBq7qHB
 scpPA5NbGHl9RJJ5sIE+HXMeytCDfAuqJt/86a2r9cY6IRo7Y9IChT3x0dj+2cASe4ShPtkWd8P
 ZpKU6+Ce1bQ0naQLYAA==
X-Proofpoint-ORIG-GUID: JOVJFlqKqtc6DDDMPxslCJ3NomUjS-4O
X-Authority-Analysis: v=2.4 cv=JLcLdcKb c=1 sm=1 tr=0 ts=6a63435c cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=QlY2XnXuNKyItd4kf6kA:9 a=CjuIK1q_8ugA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA5OCBTYWx0ZWRfX6cmaGy5DkcQp
 BPNMGZQNlzJ7M/NIu0pjQchn5QAKS8+ANVhfdsdYd/IbpHZIAVfgQDfhWsdFe5+H+FT6Al+xkUu
 tITGxBOsYINw+ItUoR6UvUE8qs46PuQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240098
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=I+/Uq0BEUFhnM3fwj2dnzF7X
 3nkG0QHhAFcDBOA1qtE=; b=GJ76GT4uV8WyYUGSERnq34in4W4v5sCEALxXx8al
 acO8gHCqHQ5dqSAuZyp4wPamAsIi9I3lkOOKb/V02TxSQbdn6PR75ejE64NFnMzA
 6x5lGlafN2pOnwsmBshivnwS2j+nirwsovCb/KTq4PuR6a3f4fxCQOPArXjNkxz1
 rXHwOVyyGGx+/9SJVzui2U1sH2RVlLwr2VvZE+6U9iydylgdHuGJUTGbGSVOhQgx
 qsTT+Z1XNhiAnQMtOcIpGMlspYwB43ZAjghtpCDtR4GACJC9Kes2ycSTN+gqdp1C
 AGWRtBB5zxVqyyMF4oOa6IsjBYrrhQG/VUFKQxIFaNEzOg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784890204; x=1785495004;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I+/Uq0BEUFhnM3fwj2dnzF7X3nkG0QHhAFcDBOA1qtE=;
 b=PDZcXNEicw5V5RwWf7CIHEMH2wqTDJMqgea/Kzp5twEsb8UNZ+H0vAVhcjy3wssb1S
 GHug1NeDb9ky1xIvcKUoT0dZIrnleY6pUzu/NhAdaWrHcw1PlV/Ofw/HhRBvsFDLR8Nx
 LkxfMPu9ws9IcEfVVM3Rd19jLI3TlXLqxQRH+LZyl+5IlyYWr6oZ4fmia+2m2UtgITTG
 EHtlyz5bqpgprEcKEO8Jzrg1zlRIxtIOk0Vbz0soq2TBRC5B8xlmR2XelUOV/b9TkB3X
 UJuq1ful11YhrYIuWv9RWQ7xgb5q3g1p5XzCThtF7+vaJU6fOPM2QW3RTubWoa84dRfa
 pJQQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=GJ76GT4u; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PDZcXNEi
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Varadarajan Narayanan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, Jul 24, 2026 at 03:48:59PM +0530, Balaji Selvanathan wrote:
> Read the USB-C cable orientation from the orientation-gpios
> property on the qcom,pmic-glink node and use it when programming
> the TypeC port-select mux.
>
> Taken from Linux commit 815891eee668 ("phy: qcom-qmp-combo: Introduce orientation variable")
>
> Previously the driver always set SW_PORTSELECT_MUX without
> accounting for cable orientation, so the SuperSpeed/DP lanes could
> be routed to the wrong side of the connector on boards where the
> cable was flipped. Now orientation is read once during DT parsing
> and SW_PORTSELECT_VAL is added to the mux value when a reversed
> orientation is detected.
>
> Tested on QCS6490 RB3 Gen2 board.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
