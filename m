Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FF0C9833E
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 10:28:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D12A480D3F;
	Mon, 28 Sep 2026 10:28:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L_DHGwgrlv7K; Mon, 28 Sep 2026 10:28:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0C90380C92
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790591328;
	b=krayynU5oXtITVY3lqiiGhPegRRxXTf2/uVqnGnt2nuFQZed0GwSnhZFWN872hWaxBeE
	 Wbh262j2npeKMbqyT8dBL4Yedh1ekJhF6EaazSyNZVyyl6sOPSCTgMohZk+1Mtwg8PImq
	 OmQjoJVcChHyOWKYqf4KFZsSLLDUy3a3cfw88yeK6H6E219yuePTgIOdP3CrAnuXevRZf
	 Z+rF7EuozR9mIPqTHKfwM+8k5csdg0rc/WMeDBuSw/HQDZXNJvreifrhxHp9ThxH5zW9W
	 9zlaCxVrzfAjtOx2OZpb72Q15C4aJpgC9FiYpDOtnRXNunPh6+dzC6uBIyj/4IIfxXg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790591328;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZQhZIYPazQab+L0r861xUwUNwWHExRc+VpGqEklsUD0=;
	b=bf/+Ea9UzKoxHIdcsBKYcbtsbmPpQd5ctBd3BrYL+w9UMqP1O1tDshnCgRdzlA2HFilB
	 TvpU6okMWVtMnubVy9Z0Cc2sb1tgmegKmZXRm0apzT9H2bcyMyVAFpTG9Ezo3qAPyXUwo
	 8AuIud1yY2y2WttpgarG23pv8/5ABwalCBROFmwE09gGHHThBRDNPuPeXVKRSOndRYJam
	 HFZBhKrxWHYAe8nC6tVpgAnW/38muCCUC/Za46KJJgEaxv8COHRGeGaI/dIlagJRJrbxG
	 TmE0xnGC/MZ/b2hNDxRHrDqQMcqS3E/OXah43MpWXPrP50CrBmCUcnu6FXdcHEvfI/g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790591328;
	bh=ZQhZIYPazQab+L0r861xUwUNwWHExRc+VpGqEklsUD0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zkQ2Q6IX+QRkuCmRGT1cs8FdiOQWK/Eovfb0aeCfpqBJW7VX7BCpQGoi18JOm9qT4
	 zFp2oYK2PA7QQKDvhXXVwy9FZqaB5oFMeheQCECRIYyBPY1mgRT2NGUlov7oxtvNeT
	 zZM0v8GQApYVxwqfw7ptabs+shGheMbg+O8kCyypliAsknjYF6Agi7qDkKTwC/yhml
	 ngCiVygfEm9KaAww4y3kqO3PiHzDP1b6OmPAssgp/80aP1w2RCeA4anbCOETOKELG8
	 WaXIJpcSCReM6RHZnwIz4K2ZUtOIVvZOmyTTUDve2K2ScVnt8f8P4QVx/kwFPq6OgI
	 D+r4mW9gTRXeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C90380C92;
	Mon, 28 Sep 2026 10:28:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 65DF524E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:28:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C98C40664
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:28:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aqsgXqTLqxPq for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 10:28:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3B8DA40676
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790591323;
 b=gg3v4L5yuObMcOQ51G94wEwlQ6PjeTa6V2cQyrjoKnPceI6xOB33dvO4W1jcCXVTwvE7
 MapSpWRQ2BTK8TMHExQ6iaVApk0Och+VnNTuvAEBnAee1OuCTAVx+yaWDRsCpDBBseDRX
 AFotCOaR5dTQYglCcUFNM658Ul1kRZm2+C10o/hAXeSfhlBQ4X5yVBd5Zv3lHNwpQvTlY
 eqI6JwLDTpYXmgGWeN7t+ujiOJnH+4vPf21kb0Sy+qCiVNYTnCHN+9jbG+Yd3KCUPsc3i
 g5BfN1LQh5Vx5Kzlv/UKHAzPl+/xMGLQnGi2bIdMeFfOPSXG2nibSjK0j7Fv9JCW3UA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790591323;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=ZQhZIYPazQab+L0r861xUwUNwWHExRc+VpGqEklsUD0=;
 b=Wb3SWLNH9izcG9eQTp9KUgClfJVdIDsdMevt2I+/THGge0VDzOihCiEvMP9jhzF0n/Zb
 Vw6XMMsKvPmGLpUEFY2r3S36/UAqCdRb+/tv0m3maJdxWtNmdbcOdGa0y645u4zFh6F1X
 oCM6AI4I5KNK74uPohuooNZwL8ZK1FpYVwLqwShrNv5lwyRMVLIPf0PHmbuOw3h/WAg4L
 HA/YDevww7kvUqIWntmpaNuL3nSg6IyLur1lcAY87XYMEi6oKZWgvDdPalPSbNdlfwIwV
 6anGPAFueovyzLaCsKovnwyc2jKWYsUBWw2TIRu8JsQp5hKqKQkJt0flJj9Mbh3Rn5g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=cGDlPKDR; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=hd720SDU; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=cGDlPKDR; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=hd720SDU
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3B8DA40676
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:28:42 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9M3HR805389
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZQhZIYPazQab+L0r861xUwUNwWHExRc+VpGqEklsUD0=; b=cGDlPKDRhgnXlR81
 2z07cdTwgQsGzXtf2RlSiqo6IH6MHwN5ZeAGpknqaUMKgXIUgzKHsN5OJYeL3cNe
 xpkUByYUXcpdXkhecG+yIMoAQ5h4cNWeSsTjx428YvI02kCgAzecw3ZA2UmVQaO1
 oDH0Q92WQFXcJBpuUWWsiR6nGBCNWQfKE6BZIRNxOjd7sUFRPxaM08nl/XwX1Ynl
 CmljHAh6cMDYUq6HPwBmPtKzcqSp9UuGJXB+tX3dcrP/jLdAfgebzkpFvl9js8kV
 bFn9GxBHIJud9EyL4BME0ekX0RP5AdQALE43BBq+jC8yEkl7SB+xa+s5j/3PTqgh
 dR6jhw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyk5mruuj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:28:41 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1384427c3efso4278917c88.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 03:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790591321; x=1791196121;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZQhZIYPazQab+L0r861xUwUNwWHExRc+VpGqEklsUD0=;
 b=hd720SDUFJBT+IiZ4x6rFO4IW+r/IJKYgYAeALdSkScsXTkbzW9Af/i5waHzVo20AZ
 8qMDGon9/trvghmCOyD8rkHwNJExTlkHQ9fOJHHs2T0aBCl6W6vSJ1lCl6Ok4o7Y4beQ
 CBWyL3HmZ08/kQ1mvmU/TWsDKOmGhRDQ9ZC1t9hC52g+/jm6im+8qik8pdAkgLU45xUp
 h99tlJ90brj+Hrb9xHwhr0Gnm3atGXZnqneTPewM2n0mpdXaJASzo8Yzd3TvXtHY52b1
 KII5gI9DH0njNHAyEoQOZsUSW8lHu8cgIeQZv/uPaMdnu+kQKHqxcqJJim6oAHp69SsQ
 gw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790591321; x=1791196121;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZQhZIYPazQab+L0r861xUwUNwWHExRc+VpGqEklsUD0=;
 b=UF5ExIs9+AvefBZFhkqQa/ze1nuhekA6Rx0KYm353WDPj6VyvGTdWpFL+DtujUTzhK
 pcYD4ErUFZRg0BRo3lhbn4cgnn9TaLNIU6aMNwCDNz8vz09qjIW2R2JIwmsL7TcTSzb7
 M9OpcLUBk6/y8le0yqBK/owEsBAUR1IVThjXwURYo7elQqXym6u0PiUFRf1IiII4pmG3
 rki+IEmNMSNnOpSnGtNxdhUHSCS4EM3f56saNnEoE8ajGj4lGu9JQLtMkU7wFjjSNT8x
 tdJO3UoZNYonvnYdTLOpuqvUDoni+u3XUC+uQid/GxZ3D+pB+yrf3nMPr2e72cEx+fzx
 SrCw==
X-Gm-Message-State: AFuF++nNXvkiPGSPa52BSR/KJzLLlOntig4YUSJM5MFlWssrFOg1f+h0
 egXcVy2z25alg/Mlii/BQUlWLJ17JI8H66y1GGAd1zT1M0iI/UO10ayfib3vM+HhEiCTltYsKyB
 4I3Y2xIyNLjTqT26zxmtsXBAoBWEjlVO682c+T35KA8LDWiqfZs3Kmm9UdxdSm0cB6HSoHTA=
X-Gm-Gg: AYBFou2FkYfN2POpEtEi5cSSLbimfiDokjCgyUGeGtNKcTTKjKS2wmD7SHBaFIKZZ0D
 Fwac+FQBnTHJVx7NoG5PfC6UNaqO+qpvTUIyRV6M2oYxL8UpegcBRGnYcU8m4ldoaWPTGoKqgVy
 RTpFiDhHCM5FBRwSH00XlUArXnnVbUZhmNHLcqZxYHWv43qDUSJt357RcJUzrUjZR2PTxIVsrFc
 hIrFpMZh4mobeeVPI7UQsEixk3uDYRnh0+/rsY6M/LxwAsjCboKEAvpz7uOivoDjhKuKokRCZlD
 bGVKTuIksILWhWK1lcFTposLCUFT6JW2al+a3NwwS7v5RKG7ghUzfZI+nU6nwxEgMfr4cNVEcEx
 uFihq6Nm7292ioTSFEhvno8Hfa+U7uWl4IALKbCqQT9PkdNgZZ77rTWF/M+t2rNi8T9onSfGdJZ
 OPD60g0sAqtSPbBLJ48e6wSFd7kKCSMJZXLWUkLMc=
X-Received: by 2002:a05:701b:2406:b0:143:50a0:56c7 with SMTP id
 a92af1059eb24-146ce2a0529mr9330058c88.3.1790591320558; 
 Mon, 28 Sep 2026 03:28:40 -0700 (PDT)
X-Received: by 2002:a05:701b:2406:b0:143:50a0:56c7 with SMTP id
 a92af1059eb24-146ce2a0529mr9330013c88.3.1790591319858; 
 Mon, 28 Sep 2026 03:28:39 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145acd3d8eesm23015091c88.8.2026.09.28.03.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 03:28:39 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 15:58:16 +0530
Subject: [PATCH v4 3/3] configs: qcom: Add qcom_lemans_spl_defconfig for
 Lemans EVK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-spl-lemans-v4-3-007635cc4667@oss.qualcomm.com>
References: <20260928-spl-lemans-v4-0-007635cc4667@oss.qualcomm.com>
In-Reply-To: <20260928-spl-lemans-v4-0-007635cc4667@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790591300; l=3944;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=AGjEUFTquEAtZh4P5Qf2CFAW9nS90+Eq0G/oJ3PnSwc=;
 b=WT90NhOH+AEKVygDVMTNL3lZhAhrbejGO+ph8qBnJx9f5WsD2DBWqXMCeIjV4UVURsB/ZgMGh
 JkZDHQaQcMHCfz/RWyC/9uaA8Y5ymXbCmUTOxik7P9Ub9Mz7eEWnG6h
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: ARigwQ2sS69EOo4M6t7IWNWTLD2Qmji0
X-Proofpoint-GUID: ARigwQ2sS69EOo4M6t7IWNWTLD2Qmji0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0MSBTYWx0ZWRfX9avrdF+UCkzR
 3Ae5sr6JCpp97q8i7MC/qWcU0wF76KFukDsBb8z1m9+fQ8sUXyIBwwi3k4ERO6RrBeD8yuFo5b0
 HL7gY2S615Z/mIoLGSerjJUJHlrEReZdbWNr3CZnltNlRFRuNqQMDOqsPmNCoKsR7iLblv9HUWv
 8U5XyB96xzSMIdPNqhCtHCRvBNU46u6DQAhnPaZjQjwwOw66/+NxfW7pMowAf/1ZbO9X401D03a
 ZtqyHet1tVppiJIJhQvUFfdGj1AY+yvUCH2rj19662W6mVlI1aTQqoQZZ4hr0429t/b9jZRUZw4
 VTYclopXHhj3BL7P7wnNeZop0A5ps3aIGQVQnW8vCQjiG//ZTpl2a7iPwSV3Wi1k8cld0Yksg1i
 gtDxhdV94UeDmvWW43uKu9xQ5V6QcV1dgR9Z0vbubGBITYAA1dS8QJ+VD/pScl8N5bIC4fh3J62
 PDdoRE538tP2/niDNNw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0MSBTYWx0ZWRfXx9QAlyoZPvj8
 T32mPO28XfQiRxVPYnwj8zdwRGV/Zs1K9k3iRp1149qZwT1BfZyaDYJbd/H3MCuTYGkUQpkSmvi
 UeOzZWGI6X7fxoIvk4w4KHNRavqJ71o=
X-Authority-Analysis: v=2.4 cv=asYnmiZV c=1 sm=1 tr=0 ts=6aba4159 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=MIDpp_XfdsXPtEUIc0cA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280041
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

Add SPL defconfig for the Lemans EVK board. The SPL loads a FIT image
containing TF-A, OP-TEE and U-Boot proper from the "uefi_a" UFS
partition and hands off to TF-A.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- Drop CONFIG_SPL_FRAMEWORK_BOARD_INIT_F, since board/qualcomm/lemans
  now provides board_init_f() directly as a strong override.
- Drop CONFIG_TEXT_BASE and CONFIG_REMAKE_ELF (U-Boot proper build),
  matching the qcom_ipq5210_mmc_defconfig on the new architecture.
- Add CONFIG_SYS_BOARD="lemans" to point the build at
  board/qualcomm/lemans.
- Explicitly disable CONFIG_SPL_MMC and CONFIG_SPL_DM_MMC.

Changes in v2:
- No changes
---
 configs/qcom_lemans_spl_defconfig | 109 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/configs/qcom_lemans_spl_defconfig b/configs/qcom_lemans_spl_defconfig
new file mode 100644
index 00000000000..4f556c916c3
--- /dev/null
+++ b/configs/qcom_lemans_spl_defconfig
@@ -0,0 +1,109 @@
+# Configuration for building U-Boot to be flashed
+# to the uefi partition of Lemans-EVK dev boards with
+# the "Linux Embedded" partition layout (which have
+# a dedicated "uefi" partition for edk2/U-Boot)
+
+#include "qcom_defconfig"
+
+CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
+CONFIG_DEFAULT_DEVICE_TREE="qcom/lemans-evk"
+CONFIG_ENV_IS_IN_SCSI=y
+CONFIG_ENV_SCSI_PART_USE_TYPE_GUID=y
+# SCSI partition type GUID for logfs partition
+CONFIG_ENV_SCSI_PART_TYPE_GUID="bc0330eb-3410-4951-a617-03898dbe3372"
+# CONFIG_ENV_IS_DEFAULT is not set
+# CONFIG_ENV_IS_NOWHERE is not set
+
+# SPL configurations for Lemans-EVK
+# Purpose: Load FIT image (containing TFA, OPTEE and U-Boot proper)
+# from UFS storage and jump to next image (TFA)
+
+CONFIG_SYS_BOARD="lemans"
+
+CONFIG_SPL=y
+CONFIG_SPL_BUILD=y
+CONFIG_SPL_FRAMEWORK=y
+
+CONFIG_SPL_TEXT_BASE=0x1c100000
+CONFIG_SPL_MAX_SIZE=0x60000
+CONFIG_SPL_BSS_LIMIT=y
+CONFIG_SPL_BSS_MAX_SIZE=0x10000
+# CONFIG_SPL_SEPARATE_BSS is not set
+
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_STACK=0xD7300000
+
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xdb300000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
+
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+
+CONFIG_SPL_DM=y
+CONFIG_SPL_OF_LIBFDT=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_SPL_OF_REAL=y
+CONFIG_SPL_SIMPLE_BUS=y
+
+CONFIG_SPL_DM_RESET=y
+
+CONFIG_SPL_CLK=y
+
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_DM_GPIO=y
+
+# Lemans boots from UFS only; disable the SPL MMC path
+# CONFIG_SPL_MMC is not set
+# CONFIG_SPL_DM_MMC is not set
+
+CONFIG_SPL_UFS=y
+CONFIG_SPL_UFS_QCOM=y
+
+CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM=4
+CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR=0x0
+CONFIG_SPL_UFS_RAW_U_BOOT_USE_PARTITION=y
+CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME="uefi_a"
+CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM=1
+
+CONFIG_SPL_PARTITIONS=y
+CONFIG_SPL_DOS_PARTITION=y
+CONFIG_SPL_CHARSET=y
+
+CONFIG_SPL_PHY=y
+CONFIG_SPL_PHY_QCOM_QMP_UFS=y
+
+CONFIG_SPL_POWER=y
+CONFIG_SPL_POWER_DOMAIN=y
+
+CONFIG_SPL_LOAD_FIT=y
+
+CONFIG_SPL_ATF=y
+
+CONFIG_SPL_REMAKE_ELF=y
+
+CONFIG_COUNTER_FREQUENCY=19200000
+
+# CONFIG_SAVE_PREV_BL_FDT_ADDR is not set
+# CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR is not set
+CONFIG_SPL_ATF_LOAD_IMAGE_V2=y
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0xB0800000
+
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_MISC=y
+CONFIG_SPL_QCOM_GENI=y
+CONFIG_SPL_MSM_GENI_SERIAL=y
+
+CONFIG_SPL_BANNER_PRINT=y
+CONFIG_SPL_CLK_STUB=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_SPL_PINCTRL_QCOM_SA8775P=y
+CONFIG_SPL_QCOM_SMEM=y
+
+CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent interrupts reset-gpios"

-- 
2.34.1

