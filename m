Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA03C982CD
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 07:15:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1018880EB2;
	Thu, 17 Sep 2026 07:15:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UGRur__PH1F9; Thu, 17 Sep 2026 07:15:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3441480E25
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789629330;
	b=sMwpgVB6bcNgv9QAkAKBkOF3shRBF+o8nXH8UYMftN9x39l/UTfd6Af+8iYITkyrlcAQ
	 UUZ8mpSBrvhEuwoWSJqKQVFmADrIqMUZPRUxfrbk39RYbz3giT9C4OLXOBwlf7l94rYF3
	 TncXZnA3zwjcf5vfq4JwHNLxvuOOAPp3EfjOQKzbpti5UDQm2tqy2V982UJKIrva5TlIj
	 j58lc4jT5a+ipKRapZucwHVeeK+TQrvE0V2ehT3DB2XImJy1EIBD+3hdd8NIQhrVCm0NM
	 S6qQRse3qNm9YYdY4S/mTUM54t6562QFsebXAgOGZxHzRabqSQqsQc/aKplITBBThqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789629330;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=g/CxMe3FLd1MlIv2hiMrf+2/PYB4/69CCihs/sm2Jsk=;
	b=Jb2hfBW6hIwjenlAJVXx+bhFxn5vkrmlXOQFGipo7xhpa99/iOi2SFi2PyxoZHDn8xBZ
	 RfndG9RaYgWyF55E3qfXsbTDr8OuOch57o/iW6KafwiqMCQZDbSCjENDe3KQZXPpoJYR6
	 sjkSMtvunsgVJsDrU9fR4bRb79ZidWenwwoNnJ423kgKqoXgNz71ndKGqAMWUzyiG7jGe
	 TrU+O/THNzlE2siY2CcaW6CAY0H8Obe8Hxj54Q8oAQcizoCUk1M/W3CnCDDqIKDv/zkeh
	 K6kwWu7UPgiwsTkcVHt8ozRojhpJ1NzdMBwJFOkvcwZMu+RxhshAj6dfz9TlzDj1Wxw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789629330;
	bh=g/CxMe3FLd1MlIv2hiMrf+2/PYB4/69CCihs/sm2Jsk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mvwWGHICykKXgywRf3KONZh0TjzdqQGejPUiG/GPYlW/37FSCRH0kZ+pPr7WLpoB5
	 HC9mkIpmDiFScOjUUyESv1UlNxpG9aP6z4DqA4vPqsNH4R6aapf2Bj52haKx78Y2vw
	 wc5mG1xES/qk44CdFU9MVYfgzQxg63TOHDLwPViXkXAJM2sKg76yRw2GRyMEuryKxW
	 S0NMyYSEbjQW1KtkkVIDO49VUSkWxAsSs5I9A9sXEb62tltrg/Ho74WQkao37VoAuB
	 Tsj69crwwL+XIPTRi7bt/a2zizFlAH46NbLEH8Fd4E34MJSe2qGclFen4HHWQ35Cxk
	 MzQpfxpWtrvMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3441480E25;
	Thu, 17 Sep 2026 07:15:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 01C2137A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:15:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F340D400AD
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:15:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yDzUhfId3_lt for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 07:15:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 427EC4005F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789629328;
 b=d/wBVFk28m3r07So2T08iV5b9rU3lUDStZCvo9hFpr0JSMBo4VGpt2RMP9+cgZpcuIM4
 b21+dGs53oGIgMle/r6d/jSoFAcFRTEhSRhq0Fz2Eqh/6f2vJYXg12YR+xmLD+bpfoEDC
 GGg3V5//S1xK6Ct16PSwQChQmYbDJNQAS78P0VJHptggXbmd1WkWmCfMg2Wm2wPPijJL/
 9rq9Ka6VNej/MWY2ca/t5yrVpOXRMxV3wJfgAF6l77S2FdnUefauUdXjV8NUiLvA7mRvR
 emYC4dxKar5NXq5OdgxmS+23uAZCzvfst55MA1SCDEbvTN6nZgBKVS2eWgja1sV0tEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789629328;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=g/CxMe3FLd1MlIv2hiMrf+2/PYB4/69CCihs/sm2Jsk=;
 b=enQH0f4iY3V0kfKPmof+26rsn0EKcf4uPrzL+4rz78Kk//8r/o9JJjzNHWdWEF5hvk5X
 LvhNjBkkp0Jws3+Nwy/Qe1cepOTwdvirEHTge3JiZcVXIk+7f+DBENakGPr3lf673Vn1B
 RS44VNHRkUN4nx4xVxBQD6JABktUTwFw+q819M0Gw7e5a40Gm6Ukauc2PIQHvzMYo5YVu
 RWwQ6mIR2tEqN6CVP/gZtvQE+95vn5UqXyljC77twQf7yszlHga9fVYBo4tBBXngvU2mq
 EDkxNtef3d4FQm5/TNLA9BcAQrhWNkVpdgKavvo2udiI2kluGGwrk7Qw/foS5hWLQ3Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=HPRK+7iF; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=B3uz42Qj; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=HPRK+7iF; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=B3uz42Qj
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 427EC4005F
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:15:27 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60gn6663100
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 g/CxMe3FLd1MlIv2hiMrf+2/PYB4/69CCihs/sm2Jsk=; b=HPRK+7iFVRLPs63E
 DDL71eY8QKWtNhaFpZ89pHprv5Sj6Y4BRwhCZ3fBRVSySPmzkDr4Rt2+S9jYkDxB
 tYTU3GoAihyR+k4FM7uRwfkzVcqPPt/Pk7SU7VSyqSA9cCJGe9lLV1jTglUWMB9G
 FunXS0Z5CHs91G+l6c4Z460wv94NeCrjaccMumiSIuU9mfkEeqqCj223G/GMTTWG
 g/6OGX3kfdwJT7iyrZ0dR4Xw5F11yOcl3ATtz9L41PBrwLHp76SE3Q1/NVBFgMJi
 W5ERwqhlq3jgNcyJR0hpv0fRmFW5IkxSWOpcKoiA4AQh3yE4s878Xb9vKmlz8lET
 RUnJfA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqyga2tdh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:15:26 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-396901263b6so1068389a91.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 00:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789629326; x=1790234126;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g/CxMe3FLd1MlIv2hiMrf+2/PYB4/69CCihs/sm2Jsk=;
 b=B3uz42QjIUDz2i9bL1XP992WySAP3LDH6anm5wVfSAIfRj0p89pMjQYrQRKHUgvN5P
 hfFNc5xd6hlsHaJ4o++L4i5Fhmrxb9boT3hpaRMl5gfve+h25zz9CH+F5yMZ3IIc14bD
 qpkDmMay8j3FeABBv8vwlkFyfNeVAQvkTFeQ4STjkp+BFx9g7zgCM81S7vnYFEddYMkg
 yeu3YBLt0OC52dOTMGMpT5L1Jkpk/5DKXPONu759fMpWf6xvj7Q7h32TWW3i4NA6PYXp
 1Dn+kHQOClwdOOZv28WJnzxR7e+chfUkei9ugym+kexP4TTSAxHreSXEZlLq7rCLMzgl
 zlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789629326; x=1790234126;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g/CxMe3FLd1MlIv2hiMrf+2/PYB4/69CCihs/sm2Jsk=;
 b=Bq3q6lWisR7Nvciy8p1YSMU7zqHX5Psv2mygsg5fJzcPxp/vj4ygBlDqg92ECpAPOL
 6ph9CMdaeyz2KOB0cJS4y6hJIrvpGk3bwM7TPOCVR7aIK1J3vVRAoPDYsJcnN+79yJew
 quakNaovFpJgWV8szYwjodvljh6lJNluDAZTvsPOJsE4lhdOv5tkRzzQ/sz0jRjP7vJu
 IE6EAcwFHnwvuLSFTquLwfCn9G3bQR51Y6tv72IqsVNquFQK/z5jqftf6q6Dlh2+ahsJ
 W5q1BIm0CHYByWKp7wFLKHS3RWnekwp+YDzXGgj+WAYiHex0RtXG1kJjhPSBhOMJtYHV
 rp6g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJerAZASb3iX/gBy8lfY0XjHwJ3PGsp1deBxaCQy811YWB2w8k1WAFP33pecbX10cTUkpbYvk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ki5a5VfD/coI9fUrc3+3E5qHGQ3dA7eRgxZChOIuJtWxPyXtWU
 Ni8l1ewhQQtG29eoF6FGnesGhAENFDvefO8jFI8pfePH51nnkRP53H5pdl3zn1nzHnFlKp6pOo1
 ywyKiqVNlJAGmdHDw5NfLo/Q6AUUiUvojaQSnu4HVBxGiN6kXY5P/LzWbahXopF8EKKP91oHt3S
 lPAxk=
X-Gm-Gg: AYBFou2M2bGi+pKkpBhcceZUkc2YcCMYQoeilIljzjptRRjFax83MTfyRaazAP90WbA
 R7qkLjKJW2iKF0MnIew7wVq4vPBCnzVwsDFz/gMWYgrMN85XFtKgZafTz+4TfWiEzbhWLzOUi+A
 LIUvfGsvN9HoyJ8iw7NJb0K1xtGqqUl6O0zMvdeaTYsHRlSljg5HlquCyDgilk55taxkpGMjpk1
 FbchWM3CAVOPQ/EPBRa0Jacy3ZeJ9t6NqqtgrGlwUtEGWy3yLNbInZhKyOeZQgggp4uWUaDfw8A
 Mcx/PnO4KrveOIKTmBKZtQoSLrEWSAXJVSXI05HljN49h6SuAOFUQa9ZnSLG6gORViLJ+QL0YI8
 GlLIvCyMkcXj1VWWZDDZaLmV19MldOlAsbB00xQEZ+biIaTXDV5ll/2F5HFT/ww0N6JduGkosRn
 SIH1wtE+Ydl3X1iH3G64GMAu5ar69w/g==
X-Received: by 2002:a17:90a:e7d1:b0:39e:436a:984d with SMTP id
 98e67ed59e1d1-39e436aa4a4mr1235671a91.23.1789629325770; 
 Thu, 17 Sep 2026 00:15:25 -0700 (PDT)
X-Received: by 2002:a17:90a:e7d1:b0:39e:436a:984d with SMTP id
 98e67ed59e1d1-39e436aa4a4mr1235570a91.23.1789629325313; 
 Thu, 17 Sep 2026 00:15:25 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13ee7sm12175810c88.8.2026.09.17.00.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:15:24 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 12:45:08 +0530
Subject: [PATCH v3 2/4] configs: add qcom_sm8550_defconfig and debug fragment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-ipq5210-v3-2-d11dc3e8b16e@oss.qualcomm.com>
References: <20260917-ipq5210-v3-0-d11dc3e8b16e@oss.qualcomm.com>
In-Reply-To: <20260917-ipq5210-v3-0-d11dc3e8b16e@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: ntQtukLaRenBSfZlxMv3fLLG5iUWlE_Y
X-Proofpoint-GUID: ntQtukLaRenBSfZlxMv3fLLG5iUWlE_Y
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA5NiBTYWx0ZWRfX7+aVrMIGkIwZ
 GiWflj2phRUTjBprYClELytL2HE25Z/MumIZrzPiCMjqGl8DLKuQiHBmFZ4eZd3/d/47QCkm6oa
 TES7uWyN5G7lnohDuie/ULhOfVBjGQA=
X-Authority-Analysis: v=2.4 cv=I9fw19gg c=1 sm=1 tr=0 ts=6aab938e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=unZPNS3TcTlehdJ43tMA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA5NiBTYWx0ZWRfX4Hz2fUjYw85G
 dkS/Yey3N3nRqbFmT2QF4PzqECvVqGQdaYsvtal0jEN7RaJDhkdLBbDiJm99Vxl+TgHayUetwLq
 2CXZj5n1sy0f2e4X4c3na6EGbJYCKow1Ah1vTm2EnuTNL9jVmB8h1ijtxjfRx5kVC4rFJDRV1yd
 nOHmsERdCQWBKt5Kwsxr9JwH+Mx84LB17BJvkqIzTXxPsPHNXUYq+5TinpFn/UuAP0uuJFVlYhn
 tdteNN+iXq/+0mM448qib2K2WntWdY70sHedSvgfFP9cx4YmXMv0gwP7hja4I2qMm4y/hg/6J33
 ozzwnsCLdn4vW8kM//NkprBYIA9M0ipzG1sVe90fZM6eDYXAFaU5YX2XnVV6RnEYnOeM8/nTFwK
 DmwaqkSbkpdPj5V+nLildff54YtDOIdkJeyC6KwiI/5BATedYQ+mdNFmLe63lv0RjFvWTd263dT
 biEPzqODkGBHimVB3eg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170096
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

Add a defconfig for running on sm8550 as the first stage bootloader and
associated debug config fragment.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 configs/qcom_sm8550_defconfig | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/configs/qcom_sm8550_defconfig b/configs/qcom_sm8550_defconfig
new file mode 100644
index 00000000000..40f7c857007
--- /dev/null
+++ b/configs/qcom_sm8550_defconfig
@@ -0,0 +1,16 @@
+# Configuration for building U-Boot to be flashed
+# to the uefi partition of QCM6490 dev boards with
+# the "Linux Embedded" partition layout (which have
+# a dedicated "uefi" partition for edk2/U-Boot)
+
+#include "qcom_defconfig"
+
+# Otherwise buildman thinks this isn't an ARM platform
+CONFIG_ARM=y
+
+# Address where U-Boot will be loaded
+CONFIG_TEXT_BASE=0xa7000000
+CONFIG_REMAKE_ELF=y
+
+CONFIG_DEFAULT_DEVICE_TREE="qcom/sm8550-hdk"
+CONFIG_QCOM_GENERATE_MBN=y

-- 
2.34.1

