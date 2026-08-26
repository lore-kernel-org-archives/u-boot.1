Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04804C61DC4
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 19:42:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2BC740755;
	Wed, 26 Aug 2026 19:42:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FmftHF6LhDSa; Wed, 26 Aug 2026 19:42:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787773354;
	bh=esN8L+mCjEoaJXO1X8eAMJvGiaokc+tWJzLTP14v3hI=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=omwR4X+bS8HjhJkekOCL8tIdXiF+QYODC1TYVJ9Gk2EEDDeTflRgCFn4CH7KwuCUB
	 LdiTnlsQkDguNrSYql16oFoi8oaEZcLobuEFTLRcIhuB7G06bSM4mGtRbLcGq/4txh
	 QoiB29Z9x9i4vDrgkiGUAAkmcKKgNohR8Pl2+8YQQtnWhijY6yBTKvSyxBj/lnMME2
	 v5xx423PabGCZw9yV0Pl1t3A1Rv+EOex0eJ2S/z+EyDu8d/XX82Gg+M3/OsEeyKs1U
	 Z4hC09aB2V3u661ePC9PATVzWGavecPDb/5hzqfDVIGyD2xbL6WNTFqdsaH4elZ2tt
	 MG73/izP8WqMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0DBCD40742;
	Wed, 26 Aug 2026 19:42:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 849D0323
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 18:56:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7684B80F39
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 18:56:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mo2HjuamK35C for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 18:56:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=urvashi.sharma@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=UieRsYUk; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=N3xPjJRB
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A8ABE80934
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 18:56:49 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QGv9CA1008447
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 18:56:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-type:date:from:message-id:mime-version:subject:to; s=
 qcppdkim1; bh=esN8L+mCjEoaJXO1X8eAMJvGiaokc+tWJzLTP14v3hI=; b=Ui
 eRsYUkyFut23CV/5BeF2lh9t2IRLInQR3fR6dM9ISvVYqlxdAKsN6MsOK6yFWsEK
 k+0DeE50vPieLkrbbW+uvyTdZr9EDERf8VTdUoiyTM8UV8RMAccOvgDPB+8SePf+
 rRhe+JJnvXaYWBI5sji4PRCMbe/OwzzyHuBSFo9bOA1nmKgsAw++4lxMdIxgv0WV
 t8g4dmySuiY4u/W9FNs7+UEmMeKrO4AKt8Ub9WsEpoQ0EkuKNTecKNGhG8UY0EQG
 BCW7fzPeHSsnA/zRtXyhFkEQDVmB8EbmQfCXtURQ0drPVJHtzEI2MniZKAvc0VU2
 DXGmXJOnTR1/kvIyd+mw==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9smxb9js-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 18:56:48 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-8200c815489so39111557b3.2
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 11:56:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787770607; cv=none;
 d=google.com; s=arc-20260327;
 b=dwsHRnPiPnOs03ZWlLvqR9urJIj08+tOHW/OjWIMxvXB2pVEQo8b2gcymrQ+XkscO1
 hp3WWpxzl4ylK/qWEUjyKCHMJPyDdEZZaTTpNUdR0s4iO0SAMvpebBagIvKc+xrRaVPy
 i3eaxHvV5LnmrJ34WUXlvpafuxzdrbHqQLt5tkrWFsgPSphbkopKrreMen49z8hkEPQi
 nCN3rgTgY7mD8X538uZLvSIpXJVHVP0ZRd2MmrdN7VCfb7LtdVbqS7WG8MnwLpAXHL0d
 /0UGepcpPdHssNpa940S2/bd6rvD18K0lEtCacoYzBmeyj87oJzFnIiYlv338kOn+ImE
 pugg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=esN8L+mCjEoaJXO1X8eAMJvGiaokc+tWJzLTP14v3hI=;
 fh=UPNS4HXYeIypNL+s9tL6UKBnRLDlxVjvSkHwqhb8LsE=;
 b=Z859dlRhrm0teOYVYY0X7WTHI+YobVdGErmoeK71QuP1MEy9COULTvJDoJkfIMBv/q
 xDgaEGa8xjeyvIsYZ0i+342CUmG8FMeVx8EeFC4MG/mMCFG1ZcwRqCA78qYwbKOWz0YU
 7q16K8FBTeN5XM/I8DJbaGuk0mwyPLyNtfU5XXnSxOZJZMlgs4G0StfWay5sjeKT2Ls4
 hmbLMn6oUDDQznFDsaFQMgIANFH9HV5i/C93dZt/fpobmXcdvgl8SEEZtrcwjXN4lifN
 BrnADTWMjDhNc+Pt7fBUZqr/BWflHJVBlbn8yigLYXwODWC0g/AqfOoPSO5kqV6SfAO6
 roIw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787770607; x=1788375407;
 darn=lists.u-boot-project.org; 
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=esN8L+mCjEoaJXO1X8eAMJvGiaokc+tWJzLTP14v3hI=;
 b=N3xPjJRBYj1RoboMdUjhwWYIQa9W54TZqt7vNNjxGFchRHvKc4w8pPJY/M1uJAcNEV
 LJ0+MxuGk3HbsIGmQDsYtZgTussTaJRmpo+ezuR93/Zt0k2r395FoV+np02Ca9EwF0ep
 FRj5ci+ddNtAIw3YliwJlwmmoA1NPCzPZJfnl6Jn4ve40WPfw3riNf9Q0MNnxYHIgs7R
 ICAet9v6gqBx0MZVK1dJURGifMVm+JJqUw5G4yxXDSmQ/pEEFJkGhiiXeYQRZRMf7h8W
 dugaP8jXUGdBA9ynT2rwlqwZOSFPwnquN4a8TTA9BxVJLKY0jX5dqK96cryU1Oug/CFQ
 SzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787770607; x=1788375407;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=esN8L+mCjEoaJXO1X8eAMJvGiaokc+tWJzLTP14v3hI=;
 b=sCU4p2HjwBsa5gdkzPQLyAKlU/Bt0ncWCB6wAlxVtSGXdCN3m5tVjLV9khtvczcTVB
 cE0KrOioOyKiOtVJWzkGHhzAoHBTXccufw+4/dftUzRLrSHqeLX+NO2ILEPIk3jdHArz
 nTtfGErfjzNyA9HZ8MYVpTvR0EJDx/1XAm1Vzu81SkAb1jvdDUvReFta1VW2t9vIBhk8
 9qSxoSPcivLS1lpwmZ91JX4nRCyYkyj7HhsLCQOyUPwoZ9m+rjjn762ocURkcIz+ywjm
 ZcDx+Tcw9do/K79oxfDyqPGPMiBPyY+0uXBQB2yZgJbHEDcFOTKHLDfK6887UJsq2qW5
 G88Q==
X-Gm-Message-State: AFuF++mV5O/fE/pH6mCLrfi3KFTQbip+8kFiCDjgk7XMF9D0IFeo3m7H
 FKXMpb0dIvOyvYqcX4V+oQsrpLemOdkNQcjmBx3K0qb/zpIK/qsUB0JCHXNnNxk94CGvUPrbOFV
 rXuhwvz0YR/mrWbK7A/Rrt8cVK7AYIRSy3BlpZrDter0dV6GBM8U02FdF9ozFe/ZPsyhRuqut1b
 CBlmdZ5i2k2NmAw7JL45Zyq+SU5Fm5OmWBOQksgfh+T0eyzinF7bsk+SsB
X-Gm-Gg: AR+sD128styeujTL3koYh7aHeU1JkGzmzn3dPXNoGC9YBA63VyfCnF49qF16aSsRxjc
 98GsVIrtSE5qfZAJtCadkLPq8CNHTtw4hIwmj1R95gurX6lw+rGcbr4Ge1s3f0uT1x5XgSF1btV
 aIS621A86OcNoPI+TeaBE/oK39i50uAV8R2zIpnifwfY06L4QpB1JISEJhmw==
X-Received: by 2002:a05:690c:a7c8:b0:7fe:4069:d3fe with SMTP id
 00721157ae682-85741251c78mr32719197b3.30.1787770607383; 
 Wed, 26 Aug 2026 11:56:47 -0700 (PDT)
X-Received: by 2002:a05:690c:a7c8:b0:7fe:4069:d3fe with SMTP id
 00721157ae682-85741251c78mr32718877b3.30.1787770606821; Wed, 26 Aug 2026
 11:56:46 -0700 (PDT)
MIME-Version: 1.0
From: Urvashi Sharma <urvashi.sharma@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 11:56:36 -0700
X-Gm-Features: AcwNN1UYyLJt-kVMSoyrBpBXGP9Gtw5t248ZbJiyqiKy2BBo7NqKpbJReprSp4k
Message-ID: <CAJM1RwPMXB8qLm4+4h_hBLqsq9=YBW_GndXroi5En4VGBVq-oA@mail.gmail.com>
Subject: [SPL] ELF loader support - design discussion
To: u-boot@lists.u-boot-project.org
Content-Type: multipart/alternative; boundary="000000000000f5b34c0659f7c766"
X-Authority-Analysis: v=2.4 cv=O/oJeh9W c=1 sm=1 tr=0 ts=6a8f36f0 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=ptfpJce6A_uqtYqcfu0A:9 a=QEXdDO2ut3YA:10 a=rYWvHuFRnutz4w2LaVwA:9
 a=HCL_Vyi1dMbh8W-l:21 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-GUID: iXC6AtzOIOv0cscUmlVE1qqGYjKEzv1X
X-Proofpoint-ORIG-GUID: iXC6AtzOIOv0cscUmlVE1qqGYjKEzv1X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE1OSBTYWx0ZWRfX1PZ7Z5d/72t9
 mhYIwKqsVmW6J6yT+FYOiQyXuEITdHjVkuENhTYy9rUUB8gf2dl/uF3CKMQTg/X5EzpIXd2WXlh
 Ohf+yzJOQod3C8o1DDTIH0q2tA2w9jZ3uHA/Opehns8IhTh0LeCOf62DLmLjBOMzEvrTYGE8NIU
 zRTSZvvfBbs8OetQyCHG90LOvWu04yK2HFPky9neQp6wG/xgaAStavDWbT8OaLQKg55/SC6UxeC
 poEcQdNoXZjQ54Jgnv4GG5+ASCTxvmbQM5eWPTYM/RfGQ2ZCe/0fIjMSDZr9g4EmTAzW9q1pzvb
 D2LNrhCAf2cG7Tb3mKlvbaEdBY3E9hB9HuV5N931s/u3nZ5geCnc25lb5puEBN8CZJItpMvzP1L
 0hZLfivSXMPynIpjZinDsaw80qZ6/6/1jn+GGsmFvvCMXSTu1q3nd+UyVmAQ9Ci6ZvB5xPJuPqN
 qAxfH2UIj+slMglAl/g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE1OSBTYWx0ZWRfX47W/o2/LSwz2
 NRENcMTDsPqZJExEBJLn+Of7ivTurdgO+h3mTV1OIvL1XZH0rXYojLudowpVZfZqKJ9GCF1lxe3
 wReB8e/0ZwhGzSXlYfikS9IffWYEyKI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260159
X-Mailman-Approved-At: Wed, 26 Aug 2026 19:42:33 +0000
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

--000000000000f5b34c0659f7c766
Content-Type: text/plain; charset="UTF-8"

Hi Everyone,

Hope you all are doing well.

I'm working on a use case that requires booting via SPL in Falcon Mode,
where SPL is the natural choice given its minimal footprint. Our board
specifically needs to load an ELF image from storage (e.g., MMC/NAND/SPI)
directly into memory as part of this boot flow.

U-Boot already provides the bootelf shell command for working with ELF
binaries: it parses an ELF image, maps each segment to its linked address,
and jumps to the entry point. However, bootelf assumes the ELF is already
resident in memory - it does not read from storage itself. This differs
from the existing SPL image loading methods (MMC, NAND, SPI, etc.), which
combine storage access with image parsing in a single step. Since the FIT
and legacy image formats also don't meet our needs, there is currently no
existing SPL loader path that can take an ELF image from storage into
memory.

To close this gap, I'm planning to implement a new ELF loader within SPL,
built on the existing spl_image_loader framework (registered via
SPL_LOAD_IMAGE_METHOD) that already lets board/SoC vendors plug in their
own storage-aware image-loading implementations.

Since this would be a significant effort, I wanted to check with the
community before proceeding - has anyone worked on something similar, or
have any suggestions/concerns I should consider?

Thanks,
Urvashi

PS: New to U-Boot, so please bear with me if I've missed any existing
convention or prior discussion on this topic.

--000000000000f5b34c0659f7c766
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div style="font-family:&quot;Segoe UI&quot;;font-size:14px;line-height:20px">Hi Everyone,
<br><br>Hope you all are doing well.
<br><br>I&#39;m working on a use case that requires booting via SPL in Falcon
Mode, where SPL is the natural choice given its minimal footprint.
Our board specifically needs to load an ELF image from storage
(e.g., MMC/NAND/SPI) directly into memory as part of this boot flow.
<br><br></div><div style="font-family:&quot;Segoe UI&quot;;font-size:14px;line-height:20px">U-Boot already provides the bootelf shell command for working with
ELF binaries: it parses an ELF image, maps each segment to its
linked address, and jumps to the entry point. However, bootelf
assumes the ELF is already resident in memory - it does not read
from storage itself. This differs from the existing SPL image
loading methods (MMC, NAND, SPI, etc.), which combine storage access
with image parsing in a single step. Since the FIT and legacy image
formats also don&#39;t meet our needs, there is currently no existing
SPL loader path that can take an ELF image from storage into memory.
<br><br>To close this gap, I&#39;m planning to implement a new ELF loader within
SPL, built on the existing spl_image_loader framework (registered
via SPL_LOAD_IMAGE_METHOD) that already lets board/SoC vendors plug
in their own storage-aware image-loading implementations.
<br><br>Since this would be a significant effort, I wanted to check with the
community before proceeding - has anyone worked on something similar,
or have any suggestions/concerns I should consider?
<br><br>Thanks,<br>Urvashi
<br><br>PS: New to U-Boot, so please bear with me if I&#39;ve missed any
existing convention or prior discussion on this topic.</div></div>

--000000000000f5b34c0659f7c766--
