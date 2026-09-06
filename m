Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5271C79F99
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 12:18:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A8B1D80E17;
	Sun,  6 Sep 2026 12:18:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qkrot9pVc2SB; Sun,  6 Sep 2026 12:18:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DE31580E20
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788697102;
	b=c9HK662GUyDBmSiZnsE5sTCWaAVp8vw2hrn5ao2dSeuKpuUA8WulrGb/Y209lHnKv3kX
	 HfUZ5P134MYB0pgi4hx/yUPMXTGEbTCu9OaKm7EzslD4yWal0OPuTAy47atJwGb0LOkeL
	 tYFlcKaiNyKui80hUQDrB2aze/zCtkFyOLmaYIjYUasqsblMe2t98BEmlJl8PmG3RRbHc
	 kuQXaSyKzGseCfwl8yjyEaCT0lHIzJdG53Q2dZrnt261UbUtR0hcZRhVylh3TLkkYM7Ma
	 K8Ggo4ldOFY4Oz2g5K82nT8r5KCxjIbNM4d/0KyQRs7q58+EbRkQPNTgEVSnI6VkKQw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788697102;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=edo0hX0IP/ZVuwc4RglqB6ogAyGY9a680sO+rIxSUmo=;
	b=WaCqOPXFZVgb9KdxJGrLWWeHGsgMF7LA2aahzBk2u742NbO8KdnwDpbtTyXN9nxf4orU
	 CTmmQxOqMpVEX1g+s0tpCYSPC4Xh3j6kM5tBQkrmEEhbvrEsqBY8FvQ+cl8nk8e+YhBud
	 A9uGe7wOSf1y/jlXI4CAQGaxbE9AF/ZchebhTgte58nXPfJ8NuoTmFsHNXY8vTF5bTGSr
	 WDRDgSjO0sjwb4LgADn1Aagcfy/1geBuZOX0fol4ny6y8hakusLRvGpyh7LhOm7YuJvsD
	 C48Cxpszo5DNKRWtmkujWN6PjSnsMZbpCb0MkgJ8GIpDYSAzyyhCv0vMytn1czY62qg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788697102;
	bh=edo0hX0IP/ZVuwc4RglqB6ogAyGY9a680sO+rIxSUmo=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aYxxuolouuzWO7isRhMdLShx/DO+XR88gdqCWW2qOXWUge8Ir/Vk3sZEBIm6eExO1
	 9rHNNzUMCYGJnyzeSk/FJAQ/gJQri4tm3+pmdUs4COs5mtr7YtwSUHShJ1MmH7wgxq
	 e0mwn6f0um4kwx4f2Ei0dYPdsysJGH5c6g2PXHPvaTp5w396qptrVlzF8+6TX6inIw
	 Y9e6suMiumPJq+RO+imUo83GUw0joPsuyJag96uLqEFaNCsvrFD55L7CNM9Lh9mpxu
	 uSQNswrI9qYzfi9ccL98e6yIuuvkGWJqPEorroOqAHiMNvqWLt+dqLIUjU/IpLNPMo
	 wqQsgNV/5vC8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DE31580E20;
	Sun,  6 Sep 2026 12:18:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 63D9D9CF
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 12:18:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 55CF04061B
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 12:18:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f-AS77SLMfDw for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 12:18:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9BC3A405AE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788697098;
 b=fSRd8Lz3aPEcbsOuStBziQ0tE87m/v7+sjORAxvNPal2CftqUCRIY09pm0EXZykwYr4n
 xHTh246zNynhcixHv3Id4xuhF/4M5VQw/vasPv1dYGWfPpEeiaplgcMrYL9riIcflgY7m
 wfCs593ccdjh8A4TvN/v4mq0viSiCiVH9kDPo3so5MtTyCW7Y6k3z2T25F6Gx2zt25tF+
 1TWsPrups06c71DaTHLcwGNtK7hldJ43nElyStaYnmV966iKrYJ8bol6yxOvIhD/Hvxt+
 n1T05NvPZNd+MZgqQO/RzgUjcFTNVOcK4k7ZmYDnbpSYg9v75kAyy5tY/FzDUBVJ1Gw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788697098;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=edo0hX0IP/ZVuwc4RglqB6ogAyGY9a680sO+rIxSUmo=;
 b=V75IyxmexsBMoGBk27d5uHubTfN4j90YU6Kv+VHMj2qJG15uM97jso+WMUZf68fd9oSr
 kPDGqef6/bnt1dX+G3bafxRdeMbVOd2YMFSXiNZZkIiC6u4RoUs+1TOv9N2n7wSAWhLnT
 UQ8rfN7oEPvAsW7+ssqIbF7Ub2EgQx22c0a6WY+gmlbLhiZexU5eeXUCoCH60aKm9m7k6
 Wb617pT2iSga4fnIrXLREglvB98Q0BhQmIM032wsQ6O1kMXHe9QmiBfLA7YpcwattA2SG
 I6bOGPeK+C4y7ocxCWcIY+UMB64IrnLc01AWMwKTaHsI5X9ncu2mSV/BE5wBLTL7tag==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=KioJuNRo; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FkjA1daN; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=KioJuNRo; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FkjA1daN
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9BC3A405AE
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 12:18:18 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 686BF2wk1437010
 for <u-boot@lists.u-boot-project.org>; Sun, 6 Sep 2026 12:18:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=edo0hX0IP/Z
 Vuwc4RglqB6ogAyGY9a680sO+rIxSUmo=; b=KioJuNRoX2J6gKa2w3ea95lavHq
 /rbm/YZqjaogTljHi+hEuyiFGyZEXtF7lJzBv1mmlAOKMV7G5BRhJTSky83NnnPm
 zlqEVehf2hH6ZiJ+ZahHNRU84LA4cz9TYVwV/0M+1Hmb4846zHBvHG91dd+40G63
 oaFLRRbQeRSCwXdSXFqVv2k2ZPFumbWnOWEVr7zQ4VujUE9MeIvcguhW4cX6zgOp
 BqckMKebQd/8oB875WkpLgFJAuVoQo/SbPoT/SaTlcLOWaMOzpKockybLrCtcsLi
 6m5zAkmQUDCpRUPoJLj/E384TwCIA4Xnv178NDKGtfenz7V5nGByRIncCWA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggany3bqr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 12:18:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e8e864ef0so4599016a91.0
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 05:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788697096; x=1789301896;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=edo0hX0IP/ZVuwc4RglqB6ogAyGY9a680sO+rIxSUmo=;
 b=FkjA1daNNS7UBTYmd/JAJGHJyfj4EtN8sSsJsrrvWS8IcDvUVfEf0o12IR+0Es896p
 SYIhzhe+uQwGAU/Q0l6CwLmMmVFSPYD1eFRFZXzzykW7FrFJYqDZZyoxLRXyMiFARtPL
 z2m2pfZiZgXXnBkwAYoZkGLhISn5UxkZzNGA0Dw8Y3OKTgNIcRBVDGXV15PnS3mm+xmV
 mqiyTu3KIvTjJ+VFybGtB2H3pnL/vpXlQNhgT+eA9l+6IKvaTT1Aw4HkNeJmh/1F+tCs
 hh3QUM1vYzrqPol6VR4Djz0VYtV2a7WOAJ/RaFh2zZ6yluL1pCHM5m8+JJNk963nxVZm
 Y4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788697096; x=1789301896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=edo0hX0IP/ZVuwc4RglqB6ogAyGY9a680sO+rIxSUmo=;
 b=KLXr2GpSy0dl4ouNYVbKdwfFbYhBGPxLSOonHarF0ip4mqbHXkHPS0/yZZ2oV/WuH6
 LzRpknKuxKSsfTK+iV67jgiVaw+jkv57UKA40g6zsg0Y7WiJ50CsJTE3E+BSeBh4tjI9
 eenvK/QMWLH1duhZz9hSMuNyATpUM4/8NAPNylUZh+yS6WiVETSJ3Vq/OTzqX9Wsq4iq
 FLpMhHy8wgxkiRigitdM7KiuNV+iG6jj8VIz5eo9CUFmSnq8IagvvN6rey05A5DtP6Hh
 wk4VToyI+Bb+vrwdB9G1/3WBP8WZEawt/01SFojea0LmoHV3el2R7R0aGDfC96PSQ0gX
 t0aA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8ZqLx99TGFGtmeK5fgvdgvSD+HZeBop16HyhnsiYeZQjVvVjfNm5lAeNyUHo50C+4SfK2Zf4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mHlqChTd9NcTsUYe0Ui3N7YiShZq17f+9mQuYc3z/VfdsZrSlO
 S2jE8dEzn4TC0wploDKGaUmX+wC1yBXdVLr7c4iT7X0RHun2GPQsks6BTRdFcca5f8Qs6q8B3an
 NlWQvvcEp7YeYik3f5lWbf+5O6t9qJpECAAFTzn93n7YWn3J+EGKKD9Io9ZtjzcpJxrbjVsE=
X-Gm-Gg: AYBFou0di3xE4TSblvAdnrg69sBGYUjjiHgusPRAO6x1ijti8VG5mhd5XJQvV9qi7F9
 v3VgYYkCCy1sfJlW8mf5COYBVtCtN1KHiDXjDpO0/LmpuHdNxsB7eShTUIejkP8uCn/IEGhEFUD
 QRlVpC/XhWI9fVOxVZ2j0UJIxgLBOiba1z50I6MzsvesEiKHRgl9ZhtlAXZEwcdIHenezaL95F+
 YAHOUSkhyJBr5IGYkUKVqshuhmE/4IoW4H6G4CdZ4OmzZroAIoAMCFSRmLAETCYfxtGshTucOhh
 4kCjQ7WmTttwXxUwxEJXevWQhlZZ9xUo9cfNj6XT2uAlzcGD5bUwPCakI6Orbqh/ci4Lg3ZYCEs
 Gi/f85yH7e3VgGmaQRChsC66HlXcnbmcoYCWLryvX9n4JSOAi0c+mmSF9wCtDZ96AKsQy6Abh+u
 wxwpvlhFKWdXC260Fu+j4=
X-Received: by 2002:a17:90b:50cc:b0:398:9be8:ea65 with SMTP id
 98e67ed59e1d1-39b261d9da7mr30271374a91.18.1788697096192; 
 Sun, 06 Sep 2026 05:18:16 -0700 (PDT)
X-Received: by 2002:a17:90b:50cc:b0:398:9be8:ea65 with SMTP id
 98e67ed59e1d1-39b261d9da7mr30271330a91.18.1788697095793; 
 Sun, 06 Sep 2026 05:18:15 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14332405e92sm11768639c88.8.2026.09.06.05.18.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 05:18:15 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, xypron.glpk@gmx.de,
 aswin.murugan@oss.qualcomm.com, varadarajan.narayanan@oss.qualcomm.com,
 quentin.schulz@cherry.de, balaji.selvanathan@oss.qualcomm.com,
 dlechner@baylibre.com, vincent.stehle@arm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v2 3/4] scsi: Add scsi_scan_new() to scan only new devices
Date: Sun,  6 Sep 2026 17:47:50 +0530
Message-Id: <20260906121751.3550628-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260906121751.3550628-1-aswin.murugan@oss.qualcomm.com>
References: <20260906121751.3550628-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X45i7mTe c=1 sm=1 tr=0 ts=6a9d5a09 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=Llik4w9wTn4nbzgA8qQA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: aZ8InUrs3fWvWcRRI59LPNwVaGBlxMSL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA2MDEzNiBTYWx0ZWRfXwyaCvhd0qAQJ
 HtqJDkKT/2o6UKAGntN/tNhG0cvwyasqKJtJ1PHAMeNosMkkde31z2lFblvLyRX4vGISahzrxOY
 XGqYCNfkv/oes7mTUM3rAQ8Ne+sR5ugZdyAirHTUCRY3WLpxw8aghw+cO19IXOpPI0CI9sA3BFH
 DmssT6kqIsU7ITq7ozTZ0HwKge5n1SNZhSJcFUfIZ6+3w1Y0pZu3TNspwkFmmXoiPhRb6zMM43w
 IeMxTqrzs08onLTw4YuLmkSdXZWlMja8hHEbU/SIFvOMMAM47AL3Ik2UZ+pXiXSqOWnW9NaLGGF
 2Q7WD7vnxHNiGwDG2zhcekY/fXpK9dwothiWPT/gFpNWKkmFtHfG3PF/1QDWnnTitfpJxwj3pW3
 KNtRaleB3GrZWqsxPKmaJfuZkixKB8R1KmHaCBtw0ID7eyNTjdwqFpDY/CamHcRNs43rbSLmlw1
 ctPcU6olUsiktSC2Zdw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA2MDEzNiBTYWx0ZWRfX2ycJvNAQSoM4
 jxCsljHe07WEhc6CbNtKgd8Vae67KaaSYY2mIPtx2k2iU7ydQqANfUJnSNXhGXlz11OxsrmxI25
 65KCE60G7vCm6M6FnYUDwMttbIamMVo=
X-Proofpoint-GUID: aZ8InUrs3fWvWcRRI59LPNwVaGBlxMSL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_08,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609060136
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

scsi_scan() removes existing SCSI block devices before rescanning,
which can invalidate existing references and requires callers to
avoid redundant scans.

Add scsi_scan_new() to scan only controllers without bound block
devices, making repeated scans safe and eliminating the need for
scan guards at individual call sites.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/scsi/scsi.c | 27 +++++++++++++++++++++++++++
 include/scsi.h      |  8 ++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 50e7d749921..736dccfcbff 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -673,6 +673,33 @@ int scsi_scan(bool verbose)
 	return 0;
 }
 
+int scsi_scan_new(bool verbose)
+{
+	struct uclass *uc;
+	struct udevice *dev;
+	int ret;
+
+	if (verbose)
+		printf("scanning bus for devices...\n");
+
+	ret = uclass_get(UCLASS_SCSI, &uc);
+	if (ret)
+		return ret;
+
+	uclass_foreach_dev(dev, uc) {
+		struct udevice *blk;
+
+		if (device_find_first_child_by_uclass(dev, UCLASS_BLK, &blk) == 0)
+			continue;
+
+		ret = scsi_scan_dev(dev, verbose);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static const struct blk_ops scsi_blk_ops = {
 	.read	= scsi_read,
 	.write	= scsi_write,
diff --git a/include/scsi.h b/include/scsi.h
index 2520a8b8fe6..a7770029c6b 100644
--- a/include/scsi.h
+++ b/include/scsi.h
@@ -344,6 +344,14 @@ int scsi_bus_reset(struct udevice *dev);
  */
 int scsi_scan(bool verbose);
 
+/**
+ * scsi_scan_new() - Scan all SCSI controllers for new devices
+ *
+ * @verbose: true to show information about each device found
+ * Return: 0 if OK, -ve on error
+ */
+int scsi_scan_new(bool verbose);
+
 /**
  * scsi_scan_dev() - scan a SCSI bus and create devices
  *
-- 
2.34.1

