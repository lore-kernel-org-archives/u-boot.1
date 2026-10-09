Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF96ACA9EBD
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 18:13:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94B35812C2;
	Fri,  9 Oct 2026 18:13:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SlELQurjUiTM; Fri,  9 Oct 2026 18:13:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 78A5D812B4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791569630;
	b=UYIM7eg/IytKbEbg6xoNtWMrksNZLQs/sCWyS/0yo7Ml58JICG4IFOf0A6tAyNmLawbT
	 KCkAMLHil5aQvOvVd9VESTj4WaDsMz53iSD61JQuCOq1LQPaerL96jcc8CoDIRO8Cas+I
	 Kfs1jHtkLQ0LgHfJ8gQGbs3v4GGeUDqbjaMexiHsq/RcaPATZr5awRNxTy67uuyhOu6sC
	 ErtKMINH728jfqVqbO9klJa+Jogv7nc8vuOP52YI7TEifyQ2v6w610ILQWrKp0fAs3VlJ
	 Kz6FTtI0qwIc/fPUdoxqh3FIQzcyAVjQncLiQT1ogFb7vcP7ALoxXPkxIAGX13p/qbQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791569630;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NZPFSB2LSScqEc6Wt/sPPd08vEVrcpdA1p5YfUk0spM=;
	b=U+FIsdkQH3TT6KYdsQByR/i9VVg3dj9980FetPDwrgGbkP/lhRiIxO0ITmrGPq/ND2J4
	 riilhqknaBG1WLv7pe/jWMqdbpGohaazzdUep38c6bw13sdc51vl8s9icP8ssWzW7sG1J
	 EAKJUt6gzMX0EF0FA2Ob7ukhwSabWqAqurF86AiFklDGrCorESrCYwRw7W8DNoGJoGfhP
	 O6GnrMx4+lsUgsYyl4hYD6YZwPpR2+0hytD5CLOlgd9ytq3DKzKJ1inam0Vt4su1BMCUU
	 YATGr2c9OEUnQS2WDJ941Hot2Sftsa4TSwaB/jxKbdEreCaV7SqpNK85vLm2eB0wQDg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791569630;
	bh=NZPFSB2LSScqEc6Wt/sPPd08vEVrcpdA1p5YfUk0spM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hE7cfmdY9oigr1no4EAYZF5MnCxuBX4yiqzQIKiBdakS4A9LBOLNuoI/VmzQ7yByJ
	 brss70Qlk++Kiceng6LY22zYQuL9Pm0CefGLOZ2VyB2ZxMnxgXV3QIWHbYiJz6cdWs
	 swprC6gQOD4F4mno4QZRtDLA5ACKg7fGum2YnssJTeUYOQPOfv3shMHhoRubI6AvbD
	 kfiiYBiA7vG24MOhO2FK/wM/7dO600xztUdkPXDkO2PDYqqHpziBVuyp4s8uNRZuDK
	 p1jlwuinqBEtunr77ZKoGL6pnc1g5ilLAG3/YWNCVE6XkQhWgWSx2TuFDRvnJbvIB2
	 xi1RzrMZ82rOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 78A5D812B4;
	Fri,  9 Oct 2026 18:13:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0575F75
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 18:13:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DF47E4016B
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 18:13:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ccuTHvLA-eBt for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 18:13:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CCB4440053
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791569628;
 b=jnNu42t3oRTfE4GAyQiuP6Q9KuwOXIwTukJm0K7mi0/+4KLrOvvm9RSWur/jSq4KXOYh
 h/kK4KH53plGIiXedVSvAgljfmtN1XNui7/+GIeCdGpfXAqkp9lIRVD6UOAwBez+IeNu5
 RRAWxDfpRVCZRgZGTI88rtrS0elNgxMxMYgFD2IawD0AlZoMhMBNskL0v1HjHalmF7bgW
 BgpryoClQwevPB4yAAaRe3AuW8s2xZR/jHcL2R6KXSLadI4GP7NCJRqJng3lyBY5CU9/Y
 JJJiNgoqrbiGnOw5ZKYgweL+6dl4KQuSsaBtzEQ4YK3TIkoLkn7ebUFSruwhNsZpRJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791569628;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=NZPFSB2LSScqEc6Wt/sPPd08vEVrcpdA1p5YfUk0spM=;
 b=o5B9pPE37C3n8PlprwbpCY1qwiYb2gfg0UJlgDMyiAlJBnzV71ZE1O7dBJTKVc2tAY7B
 7XstYNdRgvUFDUEoqCARCYevRhNlKBtKbV/veyvd4KaeSKY0ZZVRdYCBxkpnnMM54Nv2J
 aPeDNpKPeRLodUaWS8LyGNa7/0ZEZj8xCQsqMrXedrN5fU94MUl9O7uz2OsUCiVB6R3U4
 FSEsvARnlDSqIE/LUfkfSEn2k4XIE58qG1HwmB55S4S7zDaUBqhnX9DocwIZQk6OTOqiB
 I6YwZAk34RbhhYGDNUBu6LdOnAsQZ9KgZdiKgLT8WkyOgcGVgKoa1avJTdIpTkzqsxQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=jqKidw5a; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=MS4yth7m; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=jqKidw5a; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=MS4yth7m
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CCB4440053
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 18:13:47 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699HnD932901095
 for <u-boot@lists.u-boot-project.org>; Fri, 9 Oct 2026 18:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=NZPFSB2LSSc
 qEc6Wt/sPPd08vEVrcpdA1p5YfUk0spM=; b=jqKidw5aP0NiGpCgNOQ9eUrNEJM
 jHdQ5SeleSDb3Dr6/uUhxwj/d0407BkeJHDCGaVW31rAN21BipiHCAmJ8RSBIfMk
 rssiC25V26TbrI/AnRmji3KLghELpQCKh+1ZKfsqh4cpKbwiXuF/9Ts5BVCgn4rQ
 9o01+V5Q8MDuWmxabolX5tjEKUaUQ/jX08g2yHABO2+fNB0k1/ztuyWuoawgttq+
 lb43f2k//rs9BNZ6oZzkFV4XdqMVFyCSWiRo3r/xDDgUnoTKWQSjJ8Ib++fEDvMi
 /5Vjq1DUwGabDGc1ba1kAwbd6o/5Nuj/Are7o8Ik9Uplbt3zYz+Of47NkbA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t7g5vt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 18:13:46 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2d55d8cd938so68185ad.1
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 11:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791569625; x=1792174425;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NZPFSB2LSScqEc6Wt/sPPd08vEVrcpdA1p5YfUk0spM=;
 b=MS4yth7mmGzDtBBwo2Q0P1QjJ3aDgv9/2vcXdw2SU9o1M/EQQzmYBg7wjTPqDaiIGa
 wXklJtQX2Po/qtUaYTqV/a41vTK1YSFbsUf7yxlS1MDSmJ3zbkTu85QK0WO8dqfDhIz2
 v5bHQY8QDnnBnibDy6Cki1SaaukxNcWgFwBOlgg3c+XkvqmrLKd4LQCMjj1DlPMjNB1i
 dBlmybPuB7OI5CJX3REQJocy9DRQrUkQx210BHV0Qo9hFZlq1O1cO3p+c9nU0eyimVBd
 ufrjibjOxIr1KHnpVgjYkqqYdJZ21dB+R5Oiy92kROY+bJ5Wlr5FlTX6pNkFW1bOJpMj
 2sfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791569625; x=1792174425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NZPFSB2LSScqEc6Wt/sPPd08vEVrcpdA1p5YfUk0spM=;
 b=NIhlBgRVG0GUFMDVcDQ3lbS67smkPB0zAZEINTRUlvl1FUYxgVpMj0VKZR0HFYZEYv
 +reKPvAnRhfPa/+FLRnsyWRN4RA+/n8SG0g7KwNdFClvqVQ6AVcQKqmfGR1qBmuYN7if
 jhYXxJG9Jv2vF9eshj1bR7yHNp8E390PC1Gq5IE6JE2Dro8+rBkY7DuGJve3l3I78tXS
 T9gsOroUO1haHw5cFmPzJ2bstxn5FOjNbiBxohVgBx3TWhIuUDQrCzqJ42cInLKPYAGN
 GqtD39kNkyYthpSmniOsa07rpIkONPRaPFT3Gz1dSJ1chc4dfl/NXi/hYPRuLoIQbXed
 TTfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBznZqZ1s8sqDUkQbIg+VleQV4bdxzuW3UXdFWcva9K1Tw6Zin36fKNkw8GBTMcSj2ZmOSGEzro=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJcqbjcyAHESTin9cNLGj6qSRWqD5WabIixLT3Be6qa+GZ3iGmK
 tMg7MRkiRlFtIhwJigAWBT6UFoDUwPRyjmOR7nVQlYASCHu3NPe5RhuI9jBR/gdDSP9HrBKbYMt
 0xDQCEoZKBPFKepxNiS1nmKJDgv42brD3hsJo/Z6Nf6VLhUcNh2y0VcB0yXymDYfgqnEf+2c=
X-Gm-Gg: AYBFou2d6/MzMPyosvH9HSwsJ2hgF+ljKAWIv/2mhDSTA81YWbYh6pU+FRu4AYpbFLn
 0hRgsK+gHh6y6XnDN+rL0kCFeawB+vQA3lMk3mkqHfivk3dDAF75lG8u0cHyLKna2bwTiEp74RZ
 VGMBRu+yPM0ihkSeQ9jx/VfD2KeU5G8mIDQDGBM2w0JKga+FBPTRcN1bMbh+/XAgGBRNXz6ntKI
 VeRuYICPoLlxoZwFn/VAYJu1mxN6WtVOSEGG1TEIJLW5liM7Ppp82ZBJ6dzeYj+PUbnyMYx4dTc
 NVdm2LZpYT9ZZ3VAENsH3ohYFNjOnVp435TdfSVXSu8C9BfNCFXeN9HcCL3IjTWa5DAEHfX7VH7
 OLOldffJ48Pk+6O94o6rHtgyZzt88wy27dVC7Yv71V88fu+JT0w/tHT2u90HeE4BoPQ0OAaTRRz
 N5HTV7zJBb2aOMCgVWHA==
X-Received: by 2002:a17:903:1585:b0:2dd:c100:9433 with SMTP id
 d9443c01a7336-2e842cd0d8dmr26024985ad.49.1791569625111; 
 Fri, 09 Oct 2026 11:13:45 -0700 (PDT)
X-Received: by 2002:a17:903:1585:b0:2dd:c100:9433 with SMTP id
 d9443c01a7336-2e842cd0d8dmr26024705ad.49.1791569624608; 
 Fri, 09 Oct 2026 11:13:44 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422e2aa4sm14599845ad.71.2026.10.09.11.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 11:13:44 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: sjg@chromium.org, trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, seanga2@gmail.com,
 alchark@flipper.net, lucienzx159@gmail.com, daniel@makrotopia.org,
 michal.simek@amd.com, aswin.murugan@oss.qualcomm.com,
 nathbappai@gmail.com, Michael.Srba@seznam.cz, jbx6244@gmail.com,
 marcello.bauer@9elements.com, anshuld@ti.com,
 tan.siewert@9elements.com, james.hilliard1@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH RESEND v5 2/7] misc: qcom: Add Qualcomm SPMI SDAM NVMEM driver
Date: Fri,  9 Oct 2026 23:42:47 +0530
Message-Id: <20261009181252.2334254-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009181252.2334254-1-aswin.murugan@oss.qualcomm.com>
References: <20261009181252.2334254-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=W8atxhWk c=1 sm=1 tr=0 ts=6ac92eda cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=xi5d6GjbYgY_MreKiQQA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 0F_T43C6AhAAZwy9TqX6iRRrw5_RrpUI
X-Proofpoint-ORIG-GUID: 0F_T43C6AhAAZwy9TqX6iRRrw5_RrpUI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX4E1RTDO+Xc/+
 maGhlIzEL57tTUtkpCe8mls4bneNwoj/CK3bNhAagIR/YZScr3dE2fc3dUN5qkXRypibt2ICvvX
 Ulvv9mdvEcdinOamcwluUwMXh01070E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfXzVfLuXXH8j8E
 70jyHovJz8FNOnnHKXZAKiTu1P6MsK6PAIs6b4/tzdyAfRifSKHqCP8ZNUn5Vslf78siahb3eYo
 l56RUiYQFL41YHqc5rclccUu5DM3idsbr+7vcmaX0jtqFzTBZnszotlSaWHq/xNSGjdFvIRx4dD
 nvtn1rM4Pd/HozfrFheh548Ji4WVd5V4izJ6bk3Sg2sWxEBymQHuyTvqJwbjnU9fm5A/sgztVo4
 LLL8Rg7WWqXTO8xMp+diS+Zd9SXvOprFVcHN+0JIoUQXpf4UwPTo+tXwmt0hIhy7JuexMKuA5fP
 shbUbEFChe1/qaPPRt5Mh4G07oEh42saG9+6MxqRA0Q2AU6GDA6JiuuDmzgrR6Q8+cdtHIhQVRD
 rU262gYDRTz1+ZvEbI8owUj8AWp0Whu52LYLYtG3vF1+jlJliwaXkFxwrc0HjVSB8t6bIZB6Eo4
 lXUFWSXz5XnWdEZeRxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090072
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

Qualcomm PMICs include SDAM (Shared Direct Access Memory) regions which
are used to store persistent data like reboot reasons that must survive
across reboots.

Without this driver, U-Boot cannot access PMIC storage, preventing
reboot-to-bootloader functionality and other features that rely on
persistent state.

Add qcom-spmi-sdam driver that:
- Probes SDAM regions from device tree compatible "qcom,spmi-sdam"
- Implements NVMEM provider interface for standard cell-based access
- Uses SPMI register read/write operations for data access

This enables reboot-mode and other subsystems to access PMIC storage
through standard NVMEM APIs.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/misc/Kconfig          |   8 ++
 drivers/misc/Makefile         |   1 +
 drivers/misc/qcom-spmi-sdam.c | 202 ++++++++++++++++++++++++++++++++++
 3 files changed, 211 insertions(+)
 create mode 100644 drivers/misc/qcom-spmi-sdam.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 5f22bcb330e..a7e86c2ee5a 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -102,6 +102,14 @@ config QCOM_GENI
 	  for providing a common interface for various peripherals like UART, I2C, SPI,
 	  etc.
 
+config QCOM_SPMI_SDAM
+	bool "Qualcomm SPMI SDAM NVMEM driver"
+	depends on MISC && NVMEM && SPMI
+	help
+	  Enable support for Qualcomm SPMI SDAM (Shared Direct Access Memory) blocks
+	  as NVMEM providers. This driver support accessing SDAM blocks in PMICs
+	  for reboot reason functionality and other NVMEM use cases.
+
 config ROCKCHIP_EFUSE
 	bool "Rockchip e-fuse support"
 	depends on MISC
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 9ddbe9cd114..e920b8637eb 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_QFW_SMBIOS) += qfw_smbios.o
 obj-$(CONFIG_SANDBOX) += qfw_sandbox.o
 endif
 obj-$(CONFIG_QCOM_GENI) += qcom_geni.o
+obj-$(CONFIG_QCOM_SPMI_SDAM) += qcom-spmi-sdam.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_EFUSE) += rockchip-efuse.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_OTP) += rockchip-otp.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_IODOMAIN) += rockchip-io-domain.o
diff --git a/drivers/misc/qcom-spmi-sdam.c b/drivers/misc/qcom-spmi-sdam.c
new file mode 100644
index 00000000000..f987c19deb4
--- /dev/null
+++ b/drivers/misc/qcom-spmi-sdam.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Qualcomm SPMI SDAM NVMEM driver
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <dm.h>
+#include <misc.h>
+#include <dm/device_compat.h>
+#include <dm/uclass.h>
+#include <spmi/spmi.h>
+
+#define PID_SHIFT 8
+#define PID_MASK (0xFF << PID_SHIFT)
+#define REG_MASK 0xFF
+#define SDAM_SIZE 0x100
+
+struct qcom_sdam_priv {
+	u32 base;
+	u32 size;
+	u32 pmic_usid;
+	struct udevice *spmi_dev;
+};
+
+/**
+ * qcom_sdam_find_spmi_pmic() - Find SPMI controller and PMIC USID
+ * @dev: SDAM device
+ * @spmi_dev: Returns SPMI controller device
+ * @pmic_usid: Returns PMIC USID for SPMI access
+ *
+ * Walks up the device tree to find the PMIC parent and SPMI controller.
+ * Supports both direct SDAM under PMIC and virtual NVMEM under PON.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int qcom_sdam_find_spmi_pmic(struct udevice *dev,
+				    struct udevice **spmi_dev,
+				    u32 *pmic_usid)
+{
+	struct udevice *pmic_dev = dev->parent;
+	int ret;
+
+	if (!pmic_dev) {
+		dev_err(dev, "No parent device found\n");
+		return -ENODEV;
+	}
+
+	ret = dev_read_u32_index(pmic_dev, "reg", 0, pmic_usid);
+	if (ret) {
+		dev_err(dev, "Could not read PMIC USID: %d\n", ret);
+		return ret;
+	}
+
+	*spmi_dev = pmic_dev->parent;
+	if (!*spmi_dev || (*spmi_dev)->uclass->uc_drv->id != UCLASS_SPMI) {
+		dev_err(dev, "Could not find SPMI controller\n");
+		return -ENODEV;
+	}
+
+	dev_dbg(dev, "Found PMIC USID=%d, SPMI controller=%s\n",
+		*pmic_usid, (*spmi_dev)->name);
+
+	return 0;
+}
+
+/**
+ * qcom_sdam_read() - Read data from SDAM/NVMEM region
+ * @dev: MISC device (SDAM)
+ * @offset: Offset within SDAM/NVMEM region
+ * @buf: Buffer to read data into
+ * @size: Number of bytes to read
+ *
+ * Uses the same SPMI register access pattern as pmic_qcom.c driver
+ * for consistency and reliability. This function is called by the
+ * NVMEM subsystem via misc_read().
+ *
+ * Return: number of bytes read on success, negative error code on failure
+ */
+static int qcom_sdam_read(struct udevice *dev, int offset,
+			  void *buf, int size)
+{
+	struct qcom_sdam_priv *priv = dev_get_priv(dev);
+	u8 *buffer = buf;
+	int ret;
+
+	if (offset + size > priv->size)
+		return -EINVAL;
+
+	for (size_t i = 0; i < size; i++) {
+		u32 reg = priv->base + offset + i;
+
+		ret = spmi_reg_read(priv->spmi_dev, priv->pmic_usid,
+				    (reg & PID_MASK) >> PID_SHIFT,
+				    reg & REG_MASK);
+		if (ret < 0) {
+			dev_err(dev, "SPMI read failed at 0x%x: %d\n", reg, ret);
+			return ret;
+		}
+		buffer[i] = ret;
+
+		dev_dbg(dev, "Read 0x%02x from 0x%x (PID=0x%02x REG=0x%02x)\n",
+			buffer[i], reg, (reg & PID_MASK) >> PID_SHIFT, reg & REG_MASK);
+	}
+
+	return size;
+}
+
+/**
+ * qcom_sdam_write() - Write data to SDAM/NVMEM region
+ * @dev: MISC device (SDAM)
+ * @offset: Offset within SDAM/NVMEM region
+ * @buf: Buffer containing data to write
+ * @size: Number of bytes to write
+ *
+ * Uses the same SPMI register access pattern as pmic_qcom.c driver
+ * for consistency and reliability. This function is called by the
+ * NVMEM subsystem via misc_write().
+ *
+ * Return: number of bytes written on success, negative error code on failure
+ */
+static int qcom_sdam_write(struct udevice *dev, int offset,
+			   const void *buf, int size)
+{
+	struct qcom_sdam_priv *priv = dev_get_priv(dev);
+	const u8 *buffer = buf;
+	int ret;
+
+	if (offset + size > priv->size)
+		return -EINVAL;
+
+	for (size_t i = 0; i < size; i++) {
+		u32 reg = priv->base + offset + i;
+
+		ret = spmi_reg_write(priv->spmi_dev, priv->pmic_usid,
+				     (reg & PID_MASK) >> PID_SHIFT,
+				     reg & REG_MASK,
+				     buffer[i]);
+		if (ret < 0) {
+			dev_err(dev, "SPMI write failed at 0x%x: %d\n", reg, ret);
+			return ret;
+		}
+
+		dev_dbg(dev, "Wrote 0x%02x to 0x%x (PID=0x%02x REG=0x%02x)\n",
+			buffer[i], reg, (reg & PID_MASK) >> PID_SHIFT, reg & REG_MASK);
+	}
+
+	return size;
+}
+
+static const struct misc_ops qcom_sdam_ops = {
+	.read = qcom_sdam_read,
+	.write = qcom_sdam_write,
+};
+
+/**
+ * qcom_sdam_probe() - Probe SDAM device and register as NVMEM provider
+ * @dev: SDAM device
+ *
+ * Handles both real SDAM blocks and virtual NVMEM under PON blocks.
+ * For virtual NVMEM, adds the parent PON base address to the offset.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int qcom_sdam_probe(struct udevice *dev)
+{
+	struct qcom_sdam_priv *priv = dev_get_priv(dev);
+	fdt_addr_t base;
+	int ret;
+
+	base = dev_read_addr(dev);
+	if (base == FDT_ADDR_T_NONE) {
+		dev_err(dev, "Could not read base address\n");
+		return -EINVAL;
+	}
+
+	priv->base = base;
+	priv->size = SDAM_SIZE;
+
+	ret = qcom_sdam_find_spmi_pmic(dev, &priv->spmi_dev, &priv->pmic_usid);
+	if (ret)
+		return ret;
+
+	dev_dbg(dev, "SDAM base=0x%x size=0x%x PMIC_USID=%d\n",
+		priv->base, priv->size, priv->pmic_usid);
+
+	return 0;
+}
+
+static const struct udevice_id qcom_sdam_ids[] = {
+	{ .compatible = "qcom,spmi-sdam" },
+	{ }
+};
+
+U_BOOT_DRIVER(qcom_spmi_sdam) = {
+	.name = "qcom-spmi-sdam",
+	.id = UCLASS_MISC,
+	.of_match = qcom_sdam_ids,
+	.probe = qcom_sdam_probe,
+	.ops = &qcom_sdam_ops,
+	.priv_auto = sizeof(struct qcom_sdam_priv),
+};
-- 
2.34.1

