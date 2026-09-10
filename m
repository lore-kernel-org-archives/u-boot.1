Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F78C79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 10:30:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A5DD60809;
	Thu, 10 Sep 2026 10:30:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 02dT6efBM985; Thu, 10 Sep 2026 10:30:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 86600608E2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789036209;
	b=ALdp4qAUqzkCcBTrEk11i7wFLiTdc8ty62FyoGqgH9STpE6iiijlmknFmsn7PwBGZXml
	 RK5GnbYzbB/x3bL1IifgQHNjfzeys40hfsOMST5IO+zEv3f3iFhNNmdXVreiaWgw+hP3u
	 mXlKM4Of7Rxz5rjxzaRb0210ZdlzhCVsORcJ+GJl9NGIoUefQ104/qRAH97pQUkuKZa1B
	 mIwoeRGikcxjmkzFI4HuNkCbXSoOENLk+YBeUgL2NVlwdd02tCIkQeq8o75RI6HfGM6D9
	 +Z3B0zf02TYZWe9Oo+FtC3NKGoKqU2SUa2tdqRMXDe9l10feFjVNn8VSi4Tzlfxa+tg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789036209;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2thJXOizVCYDhDlyp6E5HC1FkQy2cMJg+5C1KadtFik=;
	b=glctUu5836hlK+HcdGIENZvdaSX/AI95NHy/fT0GKtn2a1Z1bNGVhJRuZwqhW4gExeKi
	 Nmb1QIlAONk/64K2MzPflJnKXLxlgZz8IddlWz0KYh59dvMOo4CyhLkSTD+KbijGa6F1T
	 /eLrhKFQTxMp3WfJXo9NrLjkkelz1/dnpXHpadQD3FOWZhd7AWDz2R/6SP4604FD6uhDj
	 Kg0NdwlI87IkwG6yYlJaBQIdLkHQueOwdAAgAZAoTGCRN19NLJneUPi9aH/MbG4NZJ9v5
	 q80pxRkCmQrqG41tDqDX2IVVqo1EWK0Q2rGEI/YZbdzeeNuyq+haCDRrt83F1QDD3TQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789036209;
	bh=2thJXOizVCYDhDlyp6E5HC1FkQy2cMJg+5C1KadtFik=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eyzEfQuQmV5jm1CqzzLsHO1laQF35g92dDr14J3yvLsBzdUQKnRI9qQGeWuVl3+tD
	 G4RK/sq3Cp7sqBvDGMtJdTkG6zBqyt4528yTB2gIclMkyIhV9VSZV5zQMs+8ui5V0E
	 qoxkHro/2HD9hZOIOUqw6C5iLGnEqYdLgDZhTNp3BUwoJyWuaSJ8qmt82Zb/oTmK8q
	 x/WHx73kMzLp/cdA2ofLywHFykEfj2Bvx7g2QYNZ10GyBv33PrtNV1Y26W3fZCIvoA
	 3coXlsUmZuW8elFwPIxRxYr6b+0gjsHih+Z5Ka/uzONWyxAupf+8Z3mRKugYpMGxqd
	 bG6WFKj2c6aWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 86600608E2;
	Thu, 10 Sep 2026 10:30:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3FC4CE11
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 10:30:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 31CB340A7E
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 10:30:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JjteuIyrSMpI for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 10:30:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 97CC040A55
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789036207;
 b=W0r5/0pKtDcEaGEZwQGacCDeBOi//kIXpBesgaq/8pDtynUADvq5ldotGn3Sh2rOyBo0
 qsV+375IjJO0q2V7UTS+v4H4NTlmnsSqLvFzBXXvmsfy9oqF4JhMcjwMk4wPb5wlglB+R
 v6GGnieYEpShlSEvZ6e6YzNNYxSSVsX/Nxf5sViRiKphTvLXa0hYC0XeYYaWsa6QZV7UP
 7rxUnBZWiAN1vrhGs5A2XiolwApeH6/hg0m3bXjvW4YVPQ0wBngCnvnSAwj4rtIRX1lqx
 6KDh5weS2ZWWJMADrbTeJUS0Fk+W5WqVefAFafTnE0M8hSg4Ggm6qRhILkSLtdouQ5w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789036207;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=2thJXOizVCYDhDlyp6E5HC1FkQy2cMJg+5C1KadtFik=;
 b=rtO88HOs14ysoSe6y18lE87qxTQxD6q1xvtuR6/BRXnoOFIFVd/z8b1yNtxGL/8k+Btz
 q5tYxVBpuIKfH0NKnds4/lCugU1dhv0avL1Er5bh97zmi9KFyW+78DgrDyB+QkNtYXvVW
 VDITgEd6sWHFuqAcfUoDQX1/cIHNGZdr44Zhoy998DtwGjynApYinDXhmEWoZ1+Ltogzz
 Ohz4yuihKGrVYzbgQtsPQrkZjGiiEeY3Vv8gu5MPT8XvuxhpATMVheWzX7Yg4H/kX4cqN
 INivpWFgmBl/ymGy2z4AVluEuIzbpejhFraOdxjM02Pbtfd/+EnDo/fkmabMwOd7Shw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=dJ94z85H; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=BCm9PlJb; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=dJ94z85H; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=BCm9PlJb
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 97CC040A55
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 10:30:07 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68A8pZPL3967622
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 10:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2thJXOizVCYDhDlyp6E5HC1FkQy2cMJg+5C1KadtFik=; b=dJ94z85HezB6N0vS
 ef/MbhJHz/V2hH5mMA5KUA71tlPZG20ds1AwiErDF9MlUNoEgPk2OIQxcKnDcul4
 T29vv6WKOdtGGLV+peIWG2OD8U7LFUTClY1DyPkUQBhipFpz4pjER4j+E8OS+/pD
 m1TT7GLJxD1Qm2jFuymDkWhe8gf0DWN9VUEhG4YvSGB6k7UjONnAVXPBkjFYnUFQ
 2LwVR3gSRxlWkuS3vDzP89XwMwGPF6QJ5dTEViVhPInURT40JX9pzl7xtAXyt9CR
 SF7R+4kUmvCLcNJye/SuE1viacU5WfMmn4ZKHGzmXgKq3X0GD+49fSkEXHDytkUy
 n821ww==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkrdn8n5b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 10:30:06 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cb11535e6a1so7338544a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 03:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789036206; x=1789641006;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2thJXOizVCYDhDlyp6E5HC1FkQy2cMJg+5C1KadtFik=;
 b=BCm9PlJbKFhdAdUAsKFg9rNIWxVXH7AbxUa5Km3WpH0IUEPusnhJ/VL3ymOdJTDuoB
 +Jxalua/TyzWi+F6fRt1Jomg/Rk9yLbw+mCSJAvwNWcbzcy7zyY9O1QhX/+BTJSj71g9
 +hkYmmzrNjfHDIo8P/7nuMwG9/MKAbEPpiov2DGm3T2C6IgQqpGdl6MF0+eNYaoocTtz
 x3CJffTOuHVTIt4DoKDeqBsdUCzweIUoghUsDARvdZlGEd3u4nXUVNSeo+ekRmbuOvYb
 qCnlTvzleUD7zYjwlqU0EpJgADCK2GbEaLT+tx0ojJR9tF1YrKQ62t83soiuoY9SkhL9
 rX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789036206; x=1789641006;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2thJXOizVCYDhDlyp6E5HC1FkQy2cMJg+5C1KadtFik=;
 b=ZZsgd9b9a+uWeOK5DYwr3zKFTcHnMPRTvMZvtMpnewKMPzbh/tpY5zUTuKstl9vve9
 uej/qIOBtgOJXZhVeCEHXn+mkfIUmHmjo32QcQ0gz+HmmgkOOykyNGsOrahYMsuz6lEi
 SnWLIzThAVD49LH+e4Gza9bXd7boFaTBg1Ob3h5RoFcMhcZCiSAwzLnn/uvYjr/EtPXE
 vNSapRfDSVhNYOESIA7/O5toK3beeJAH7qpL0VFlkWSWTMWSp/47ChGOOG4Dfib173rs
 6UmE5gMkN8IueDVyJ5eIsI0mcQ0ruP5GWPI1HFC2CBXVshAEmmEIPeuN9pbFw4dcIkLr
 7fbg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8Lz6hMOsK0+dDvpU2Lb7Te8YdUejdUyzqMd8J//lJnytz5JMSXuILTZ1tMjIWBI4blAYammw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kn/Nx3ZaKEzjLsCNZL+GEclfKyxQGSdu7RS0XoOFU+o8+WmzKG
 1YtT+9319m47VQ20cHFyOjZK2R4ld5QwUIpqO0/f7uVnmEIuepJUwUWzUP7nzd5QdGy3aQjl9MN
 ceO3lD/8RGhIAmjdD7ZZZuIpd5TIpUhsTDm33yL8hz6Z6XaZfGIgHa0/jhCZCkI1aiYI2JUQ=
X-Gm-Gg: AYBFou2yS8YedRH6kk9Tlch9jpiCAFFSM1XbkEXuhVgkJUqHpAp0wapqQUAb0afYvcK
 wE7UkOWA70EId8ZySK6F5yr3uJMcSjQOpF2TF3A7zaSIxSpoUmIxYfzRADcVJ7DVZ7VgsFConS/
 lLK8rPBausFZePxmdMuvTw5c4XwZxzDBlI8cDbbpHoKIGy9V5P0GCCj9oQ0gJrTiHC0Lq/kcUQh
 PI0Nf1I1fdZGCgqknjJ0joOMwArmdjgRxx9JA3/dPTtwGoLUKWZ3BDO3j+CRntMIudH2ZpvpZ6t
 MnTy3dI6LuHqo/szG28cN2RB9ihiflNKOIaBqNoRl4ziTSMhwicYJ9LyAN90lH5T4FM+Ikgb+RU
 4jeX6V5cgUHuT77suFsfSix1xiHdW/erT3VOf3E8f/koukA73KrzRdYn6oQtaEd1m2Uy6ZdADEB
 IvkXSPDZQ9u5N6btyWKGkfzP5CPRYNvg==
X-Received: by 2002:a05:6a21:62c3:b0:3d0:ba81:79b7 with SMTP id
 adf61e73a8af0-3da39f7e2b6mr72397087637.12.1789036204883; 
 Thu, 10 Sep 2026 03:30:04 -0700 (PDT)
X-Received: by 2002:a05:6a21:62c3:b0:3d0:ba81:79b7 with SMTP id
 adf61e73a8af0-3da39f7e2b6mr72396768637.12.1789036202998; 
 Thu, 10 Sep 2026 03:30:02 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339a62be87sm42824576eec.6.2026.09.10.03.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 03:30:02 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 15:59:42 +0530
Subject: [PATCH v2 4/4] tools: qcom: mkmbn: Add support to create multi-elf
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-ipq5210-v2-4-d209f7dc0fc5@oss.qualcomm.com>
References: <20260910-ipq5210-v2-0-d209f7dc0fc5@oss.qualcomm.com>
In-Reply-To: <20260910-ipq5210-v2-0-d209f7dc0fc5@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDEyMSBTYWx0ZWRfX20LC6jqyo+/F
 yMPB4TU3RyjLqtyd5i5tcCZG8WlzkKgKfTp0HgnX5HSPsyD8sNIQHrQJV1X/UzcZ26w58czY5qz
 WYHKzZ8pi2A8NAf4uiGCk416B8iaLV/5jU8n4hQbr4jeVbrVDoO4lXuzjl1gvPc3HDQ9yUmmW5v
 pzwKRnjCI0E/9blr8xXjOX3TNjD+4KJnZDOAgUtFePzpgOQWhKz/Yd0Eoar3hE2Qxb2sE4LH0tg
 YgalgRA7wWLHbDld2jMIIZ4teHUe16Qzpfg7dnyy02Zwrc1s4bHE+xz2yyUZClBo3kyV2rnuuU0
 zZUa8iCnDNp8kK4lMD1khmqrBm5PP5dyYV7P1W3o2dxkmbYKfJRxf/dux0a4K/Rvh5yR5WIBFlB
 vKMbS4lN3LzFcrwpZsEsiRlk3XZmoY799X4HvFRUBBEbV1ghDPFt2MltCh6KdEubUCFchmW6ivf
 sJtbEfKRrtIfRLV9WMA==
X-Proofpoint-GUID: IG_FoCMsguwTh0rWMNLTB6expO6PwdfD
X-Proofpoint-ORIG-GUID: IG_FoCMsguwTh0rWMNLTB6expO6PwdfD
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDEyMSBTYWx0ZWRfXxJTh4D90LMWH
 LMxDlz8YsREy9Rcq/LNJjMl1AWRN2amJoITBDVQMMhZZsFnFlQkbwe5GjinvStWaBJBeNtM45YL
 GPRRRj74J9EuzNT3Im6NoRjlikNuVgc=
X-Authority-Analysis: v=2.4 cv=eOmGH3p1 c=1 sm=1 tr=0 ts=6aa286ae cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=cg-7CpDhVU-K4Wno2zgA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100121
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

Add a command line argument to take a list of files to be combined to create a
multi-elf expected by the boot rom.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 tools/qcom/mkmbn/mkmbn.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/qcom/mkmbn/mkmbn.py b/tools/qcom/mkmbn/mkmbn.py
index 6fe66fc4e55..6b0ea3a4239 100755
--- a/tools/qcom/mkmbn/mkmbn.py
+++ b/tools/qcom/mkmbn/mkmbn.py
@@ -104,6 +104,9 @@ parser.register("type", "hex", lambda s: int(s, 16))
 parser.add_argument(
     "-l", "--load", type=lambda x: int(x, 0), default=0, help="Load address"
 )
+parser.add_argument(
+    "-m", "--melfs", nargs='+', default=[], help="List of ELFs to include in multi-elf"
+)
 parser.add_argument(
     "-o", "--output", type=Path, default="u-boot.mbn", help="Output file"
 )
@@ -116,6 +119,18 @@ parser.add_argument(
 args = parser.parse_args()
 verbose = args.verbose
 
+if (len(args.melfs)):
+    try:
+        with open(args.output, "wb") as f:
+            for path in args.melfs:
+                with open(path, 'rb') as tmp:
+                    f.write(tmp.read())
+    except Exception as e:
+        print(f"Error: {e}")
+        sys.exit(1)
+
+    sys.exit(0)
+
 elf = Elf()
 
 data: bytes = args.bin.read()

-- 
2.34.1

