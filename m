Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E649C44536
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 11:40:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DFE424080A;
	Wed, 22 Jul 2026 11:40:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2e2kOao6lxG6; Wed, 22 Jul 2026 11:40:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2431C40718
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784720434;
	bh=mdLpfVFwCoqcW3cTXT1HbdGaLzLc8XceYkNj5jqVhDw=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=xS7qRkCShTvar1gfecr0hUjWHRFTJBXwvVCUEJFASSqffAhDalgcQBGdOWEp4J7Kj
	 v7AH9s49W5tfgMMoRNTNkXa4SSAnAn+Eff7bljwgoby7HwDNp2jqqhtd66+4tIPz1X
	 teT8apG/9TPVw7kFfTu34DrOOynJTrcWuNpBNOXJqpabwT0oof0fsnnKseG1xGHcvv
	 n3kzDOtzAccXd3bkIeEUpoeOT7XWHiJpVFFpUUB/VOEMyvWbZb+5UWf+RaT6UmgMFy
	 oQF3kSlZWnlkhldRDpu2Cg5b7/hJ23YIdom5XO/8eIDp2zVHv14ukp0ENZAhuapocg
	 CAkA00iXOfoBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2431C40718;
	Wed, 22 Jul 2026 11:40:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DAB91EB
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 11:40:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C0E6D40718
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 11:40:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gstJTPevymb0 for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 11:40:32 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=varadarajan.narayanan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CF5C740704
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CF5C740704
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CF5C740704
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 11:40:31 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4C61848BA; Wed, 22 Jul 2026 13:40:29 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA67D803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 13:40:27 +0200 (CEST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M8x1W3523799
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 11:40:25 GMT
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjrtt161t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 11:40:25 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb5cc1e13f8so6017020a12.3
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 04:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784720425; x=1785325225;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mdLpfVFwCoqcW3cTXT1HbdGaLzLc8XceYkNj5jqVhDw=;
 b=N3e7LJjWd3Q3Qxts4Q1T3XEB6uPnmvXHF8SrNZz8Kf2QE/gyl5OknOgCsa2Vn+EFmq
 Jo9OdMAEqKmoOIPsYU7YlziQyzNL9Vg0ZT4KtQNyO1DGlUhC0vkWDCZvTe4iGImWmF13
 mI3CvQeVGsjR5TQQDVGcrUPO2oQGErriS/H6jEC4owr8lSBz5wvLA5ZGejGyqJHWPINL
 +9VtuARfGTgHxjAs4mKGn1mxcJ1rUk1/fkJbHNox/12kPIpDZBTUIrIAWJlij4o2lBxD
 qZKOpPGu+qV2j+QrO3WMpYsyQ+SjcrbbYQisyIJC+4rRSEvkMnbcXzJg3TkC8XGhgti2
 0o7g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rot7ktPA4kJgSyPafWwQ9qMJc3x5RK1f6gGT00QpCCCAc4dNmtLq/le6eGDY9uecHizeM+mf6s=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0O467jbhy5UJVukoOJyZvZ/4AsECkc/tv71KPoze5JBAMaKk2
 igab/spAnYHKzJ7mHfFtcZrcR86BxX6P12udjtJJs8NDAui34x2Qu2+RwxxsK8zyT5w8ynZcp2Q
 Ijzs4MZnvqKy+nZbJ2hOO7R7xC7nrWopfrvUh8nW7uGgQ/saE6vIinYJO
X-Gm-Gg: AR+sD11kb6m7KDSkiVUzotTDLCm19HSSk56WpQgxgWsm0Z4Im/hJLT93GcSpyANI0yG
 1/4/eOVpa9bR/87ueS5D87kllvmUiCFN9BLbwytnHSsfmL2r+WqNvvQCN6t95CR0f9T049Qxaoj
 7ZvPfsgrze8COqiPcJjbPvmvK+VB6nMWY598DsD77r049YuHR/vwss6zDIoYduzgouvupVlsUyD
 xWePRIxv5MhGrYjoMaom0qcgPOJQQz2rxlHrs3p3alTre+7S2a5XK3V0Xy+VbOqntCkZdGWWsgc
 YUrgTrVWzcfYc8NnS5S+MFtFe3rFwxb+ciCbHdTIE45l1ErwKnshJJWQwhAzLkgP7AT4mDFglaz
 gaDjmBvkHmbj0hv1QRkJizG1m07CwCNp6/QR7c/cR9HCZQ4sviqf8Y4KdUoqjyysvgW1vb047uo
 xROKU//CV52ypAvzWaWm6ge6jperRT5Q==
X-Received: by 2002:a05:6a20:430f:b0:3c4:3454:38a7 with SMTP id
 adf61e73a8af0-3c434543beemr2293176637.54.1784720425087; 
 Wed, 22 Jul 2026 04:40:25 -0700 (PDT)
X-Received: by 2002:a05:6a20:430f:b0:3c4:3454:38a7 with SMTP id
 adf61e73a8af0-3c434543beemr2293135637.54.1784720424668; 
 Wed, 22 Jul 2026 04:40:24 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e0818e4sm9119004eec.22.2026.07.22.04.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 04:40:24 -0700 (PDT)
Date: Wed, 22 Jul 2026 17:10:16 +0530
To: Badhrinath S <badhrinath.s@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, michal.simek@amd.com, luca.weiss@fairphone.com,
 danila@jiaxyga.com, adrian@mainlining.org,
 aswin.murugan@oss.qualcomm.com, david.wronek@mainlining.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v4 2/4] pinctrl: qcom: Add ipq9650 pinctrl driver
Message-ID: <amCsIG2c43bBoQs0@hu-varada-blr.qualcomm.com>
References: <20260722104624.3842833-1-badhrinath.s@oss.qualcomm.com>
 <20260722104624.3842833-3-badhrinath.s@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722104624.3842833-3-badhrinath.s@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: X8bj3_TYRBRk2U4nOOkAjRv7gcV3Y4s6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDExMyBTYWx0ZWRfXxhoNLv8x45Uu
 eyVQji5W+1hdcKcryRJHQKDtL/D2bh0WVRtQ45hnj1b+aOsUEwMNC+r/GHBfldTjkDF3cVmH8H7
 ojcBWFkSdsXyvKBc9oEhyNLbm13U1CBkIzJNj0bYDNdxPIE/JDCTNkKUfm7EJB+fsDoWn30wwSy
 0OnQDq7hT9zof5msTAoZh/e2ffMIujA13pApHmPuYifl0iZ+KotPrUGrvEs0YfyBcEiHdK+AR8c
 q5cazH6+nTU9hTvgAJBX9l+zqyue/5huFUiQ+kbbBQo06i9gRydnGq/+xuQ79B/A04MNoFJuQk2
 ZULXmJfXnTzzM+g8OOib+idT1mvmN0bQzZ+PZdclnxdX1Qt1tGIiIWrEa6Khhl1YNp2fe6mcfm3
 d0T7juEVk8jBr0OmPWWk8vSX2paeDIWsARXZpVWioIOfwinRMLqtjpAHL+r1hmD9aFLtYWkxKsr
 mZ05yufadr0VohU97eQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDExMyBTYWx0ZWRfX6xzTWlIAN4Fe
 nqoiTWEggxAQHVFqfZ3jnZ1VDLc0sKT+rghVr+8T/3mzxkEsnNy91jE/4Nc1DpxJ5OrVWyowwbk
 pXkVdTRVcr4x7Iewtm4qmGQZKdnqPxM=
X-Proofpoint-GUID: X8bj3_TYRBRk2U4nOOkAjRv7gcV3Y4s6
X-Authority-Analysis: v=2.4 cv=V8lNF+ni c=1 sm=1 tr=0 ts=6a60ac29 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=ZKDt5Znw961Hpe79zl0A:9 a=CjuIK1q_8ugA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220113
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=mdLpfVFwCoqcW3cTXT1HbdGa
 LzLc8XceYkNj5jqVhDw=; b=RhTR3Me90W3nkaEID4rpiKgClFMasW9PJprhW0Wd
 yRlfhFm79NS3WjHYm/tDgpdCW27i1krqGTyad1bNDWwoCZvVqIZrPgYAYacUR+i4
 cg0BySFkOxKbrR1ZkMO1HbGFAgQJ+AlQP0shSUvfrp1Gn7CyeDulnQwrBzo6UTwp
 b9q5Y1V4UXBxKO4dDqnbE6zdZ/InwMjd3jrsiYgYURJie91Znl64WyfVFKv1iqbT
 WjVt1gh17qJhLx4mncAc5xZyp7/2/8NuX6JFN5ScM6d80Dsxe70oakbEIRBRPTpE
 7VcjdQ/T0/uA+uqOkpjJYqzqFD24Kva8592Mph6GcIJPuA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784720425; x=1785325225; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mdLpfVFwCoqcW3cTXT1HbdGaLzLc8XceYkNj5jqVhDw=;
 b=VIcCkzr+1a0kv/CH2wo+N11juSGrJHhVQOx6Sn5/zJEEArvpp1TbZfoRKEk9xCfKqT
 Z/uKK2iSQU8d+7x4pKWq6WCLgV/6sWHT0Nw2xKPjD+vv1eyRMXsLPtBqF93kcVDvz3QB
 CvgFOoYsy+B6U3uOxkgzXWZWQ72PCP53tzly/RMYxDbdGU97TGcqo/5TPbp41rbeGUJA
 Oy6QBnH5ouk2ODKa0ur7hp9ZxR6qqVK9480paspAJ7fWWEbJHqex5IJNlXbBntxlCfUj
 zTtaTPCvqryJmJ3zgSRZgN285iXt8X8wkwc74oo5bhbl9gjOpPwY5pZEtecrjyKSf9ed
 Jzfw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=RhTR3Me9; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VIcCkzr+
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RhTR3Me9";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="VIcCkzr+"; 
 dkim-atps=neutral
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

On Wed, Jul 22, 2026 at 04:16:22PM +0530, Badhrinath S via U-Boot wrote:
> Add pinctrl driver for TLMM block found in the Qualcomm IPQ9650 SoC.
>
> This driver supports 54 GPIO pins with various pin functions including
> UART, SPI, I2C, SDCC, PCIe, and other peripherals.
>
> Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

