Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D590ECA6002
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 18:12:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6BB4B80F65;
	Wed,  7 Oct 2026 18:12:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QJlcDCpzkIPc; Wed,  7 Oct 2026 18:12:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9AF4E81172
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791396721;
	b=QlsRd9zoj2YhhM5cb9Ly+OYCqNZ+6tbxJkO7VXdDr+zNeeQchcjZZILX/TUzeoR/MSne
	 Kdlq4pY8xDKQgGsfBIbLJX3iQd8+b+y8PKSGDPZCipQz/gtoXHuuCeXXNu5mMAPcue5Hr
	 nB4TjvpwhJRb1e22u89AFk1/Fq1GGhOadx5DkR3z/1eDfcptz6XV4cSg636axAsCYu0z0
	 2jRTVbFznKYb6gkuhlO20Svxtwt8ktaldunnPu+pT6I0BGKGqsD4yrE8DulgPlwd+TdOp
	 SwydIA/YePMgw1br5NGy+rM4r/laWreGxSYZBXMMWxKdlQnINCOuM+l8nrP7J6rfJPw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791396721;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vIQq7N9ExQ+/Az1YKH9r5l7ShBBR6u7ChJGzMxESx64=;
	b=idvLgqSJ5/PjzXD+yHoIVMbc7dkEE6yrTPnqmt4xqXNGOi3wxvwv+EuEjsletzp1LzSJ
	 GdeqIqCTahEj0q4P51V4IhRpBkRtkJrNohH3IAsNatjJ7A1jc8Phg4In7DVcWp8ErqFh7
	 MBqK0374Vs/N/sJVyPzWvnqB+0hxNvunumc15JXfZZk2x04dkDW58QqbHDzys+y8NojUp
	 BQYeEAqw1DZwOFOeq7XcDuDrUGbUbxzhQ0w9tJd6XcAZmB5zNGSh00au4ML+FU4rYOeWY
	 auz9P4Wf1mDjICy8ItPdyncHjm+fKP0wN1yktKOlixUGK1rlPgWfF5YgIUxNmSjM/qA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791396721;
	bh=vIQq7N9ExQ+/Az1YKH9r5l7ShBBR6u7ChJGzMxESx64=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xj2u7dB9OIFhNIhuYaKGYXVCVK8T6A5yNt7kdoxUtf6FdcTiFovhroWEsCUgKpwbH
	 1AMcSvS6dV0ycBCB3E3BB5DaUs5rLv5AL2aaC4SbmFLGkeaDvlGYedQgLy9a1igIek
	 Wju9MJy+2nkbyb7d42coLo+a7R5v1pz6+ZX81n5ikoQh9CU/xEqjqWmXhyUVCCXgvq
	 O0hC5hgaLqDFf8aDpDU1XmMIQug+kpmQKU2Nf6FPqVUHNvoyGds3566OaDBYJ6+IeH
	 FH9C+3ofBuu+fqQI0HiuhbEI7wu3ORzXdqNjbXZ0L2N1RHWrUv9wrbIssq3brr+uRT
	 o7DTCslLp2uIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9AF4E81172;
	Wed,  7 Oct 2026 18:12:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B9FE75
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 17:43:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6FB5C4F3BE
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 17:43:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2vXnGGN0BxkD for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 17:43:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8AD3B4F477
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791394962;
 b=DhFLIlGJBaJdHIc+WptwoDyth1xZ5JyW2jkAXLoOMxTuBhmdih1fp9LTJ1+W36bNb+FA
 urW6tdMjwTK5T4hiDYA4PsFi4wy9hbL58ab05PVxT+2u35qYQCEfhqhKal7feU/7xGzIG
 swJHIb82ivlnGHZiwuLgJ+L8hgg3L+V7PMf/5GJkstbJS6vvU2jG7bZQBem72fPdwvvSu
 oQYOB6AP15q4UWacQLD6zdsGblfh2Tu3FKylX/a4VAQPrhaqeN/nRNfRx2q/5jxOnujM2
 B4KuUXX5ttC20Ofdfhqi4O5RMHBjHSdkCoZpARdg3U5IgT5POaV55cXrZKnaIzbhS9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791394962;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=vIQq7N9ExQ+/Az1YKH9r5l7ShBBR6u7ChJGzMxESx64=;
 b=iHBQvMbW2pYOx0zjYiDfjS2W3boBpl5K1knOQ/zmydUCe/ymQil/JyNSsKpuqP3djPk0
 j09hJa5OM5AUyL9c+WcRCXRmmCJxFD6zYe5+W2IKHOILCBFcRcRS+1JFvUBW7oc15xFDM
 CgEJ8UTh4vwgnMut9kw4KT2bYFBm1q7q1lSevEpVREDSSnNF7hvXV/L9t2Yu5KGyNlnDG
 QBS2l05i23eLRAmQwSDlqRhcIfaVh6anfd17Z54XS2W/wmlDSV4x9d+oLG/qIOIcbCS2a
 Bm6dsd9yGtbr/tfjo8FSrBUdZBVm0HVqgceUM9eodNb8/ouaO1zsCQDBXu4o1AuJ49w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=mJYuOn9P; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jcF3V7sz; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=gurumoorthy.santhakumar@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=mJYuOn9P; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jcF3V7sz
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8AD3B4F477
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 17:42:42 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697EtTTf2809033
 for <u-boot@lists.u-boot-project.org>; Wed, 7 Oct 2026 17:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vIQq7N9ExQ+
 /Az1YKH9r5l7ShBBR6u7ChJGzMxESx64=; b=mJYuOn9Peesdr6t3MBX4eCQK2bL
 mhxvKkuu820RELB94kBf9SNIA/GKbFMHGm3YdPjVc8JJR5X19/R3HwEByDRm4Az3
 uM4oUKTJ3n0qiBoOh0KEYYfCZR9+xJu4mDSnjkLOAQFaffwwTZcpZFCsgHHoWlOe
 X8JrggPrTHOoth0ccvmRti40//fcxjdh87ej1GuIAKGfa2pSgitoAmlnA7EpXyPw
 ELcVRQrrf+hIw0f3T2BN1YFO1ztPD9reI+nwmSlpSUf8aefmjJF5jd9wLq5DoJub
 7F4oNfn5tJEaEta9Wci04/lvuy5Epmm1MSvMzTNEccZrkp16QmDqDOqI7ow==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5fw8tnqu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 17:42:41 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-341eff9e381so6431972eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 10:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791394961; x=1791999761;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vIQq7N9ExQ+/Az1YKH9r5l7ShBBR6u7ChJGzMxESx64=;
 b=jcF3V7sz8q3qddGigtPgXQj7pBXJGuWfSsIbQwj8h84i9Wq1RsNwoVS7SXsxFfOo9u
 RXHsD7OadS95yDRaN0++t+WVq94NiMX3n1M/PGUmUAdIp2U7Z3pJ1KhliOBkzcjtYXB1
 sOHpRONC4MyuMmaNl/Tulkq3FGM/nMUuvuhFi8gyrOrVxf7fp8LeNs061EKX4LqvyWJ+
 u1T1ftCnNul55Bk+SiNClu5aVdhhzqfH2z7BXObBaC1IANVxwPNIS6G5KNNGHr+IfRei
 CUUeZQ51wpLxzuWodIT2jTbePcH2e4DbbUjd8j1jJRDKE5nSoiblUAp5TK3rxSJgqDOg
 JjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791394961; x=1791999761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vIQq7N9ExQ+/Az1YKH9r5l7ShBBR6u7ChJGzMxESx64=;
 b=qb1ECoMXhmBTD+4RufEV32aCn5WHxJaGrEaW9zu/J1US+1Qrov9brhCU6O3qVgHob5
 tmG5L4seYBpQ1uatSwhkgchioL3KZ59Oixws8AV7w7XeqI2zFaTIGRZ7sfWgvossb9Ki
 UdGdQXvEba53l4x//6M9LIiBDmcYBJ47em7aTw0cpyUQm2wqqKtaqXuf27t0G2glECZZ
 XGoOLsWXC1Q5ktZZKWLmX6Yi+7TTa3W9fHr9i3beIFzEC1ZyuyQQmQHpcRAFieBXJu6v
 WQY45N3l1wZ9hODa/NWrHTxeNVwYEfPbjoyo6MJIJd2Cha9vrF/KvlnzF/Dd1Y9yNHWs
 55cw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZEQCvLpLfw6QE5+tA5CELxTfCPSdwwdRGu6djbLuiLGuCP1CGSl7h2M4/bXmt5PeYzg71Nms=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIUYjk2gB6Gd8ugKxMDOzy4glFyiTGWYvXt5b2WG+nLHxGe5DDt
 EuSXN17T6a+hf/sSzwxOhwOgq1N45i7Zb590H2H1Rs0k+1X452dOChMRIhuq7ApWBzjakv7Fyrn
 p77sFH1uqKB/u+3BhZqwh0otvRrvR7KUWUSSfWHdFNvzw9/e9nxGypdNuC4SFQCZrT0outqd3Mu
 NBDiA=
X-Gm-Gg: AYBFou1xxyJwhrFveoQ76hf/8SUZ7eXLseoWRLHNw5wjZinksAUwbupHykp5JsN/lXJ
 /kVSa/5ufPrs/8qngoefj7BTBpajPvO4q3auRhxmKvUkgD+gGMNQ7GtIlUna6iRNrZBEKZ25dp2
 xtQIRE9wdlj34qe4Q1sFm6AxAcuW1WMjx+oGU9ACbKcfaW+PMx6Fp7z90qZ0pCgkNd2vdnUbhga
 WU7QCRzGPHFsbwuoZ1Xz/S2tz3kk/sFADZcJn2Zr5ehk98ehh0nH21NhL2/H+DQb/F/Yas1ZqHP
 f1iwK4MKTpAm3q+MtPnHVtbNczLlN7m4z5V8skZeE95oEiGkDQIzpJei945plBkHswAmK+R9UZw
 vzjY68UcTYvlrz7DBqQHNmG9SVWzE/XKAnnYmBIhN+HZxJoU6+oyC9d7hnOj+fYLfwhI3VSTGEP
 kqyPhjzRD7Y8KoIRcqdTpq0hBeMe2hR7Gzvg==
X-Received: by 2002:a05:693c:83dc:20b0:33b:b0c8:73d2 with SMTP id
 5a478bee46e88-3515dc54535mr3494554eec.3.1791394960551; 
 Wed, 07 Oct 2026 10:42:40 -0700 (PDT)
X-Received: by 2002:a05:693c:83dc:20b0:33b:b0c8:73d2 with SMTP id
 5a478bee46e88-3515dc54535mr3494511eec.3.1791394959792; 
 Wed, 07 Oct 2026 10:42:39 -0700 (PDT)
Received: from hu-gsanthak-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515abb779dsm8486756eec.1.2026.10.07.10.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 10:42:39 -0700 (PDT)
From: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@nabladev.com, hs@nabladev.com,
 gurumoorthy.santhakumar@oss.qualcomm.com, Michael.Srba@seznam.cz,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 3/5] clk: qcom: Add RCG post-divider rate helper
Date: Wed,  7 Oct 2026 23:11:49 +0530
Message-Id: <20261007174151.2590649-4-gurumoorthy.santhakumar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261007174151.2590649-1-gurumoorthy.santhakumar@oss.qualcomm.com>
References: <20261007174151.2590649-1-gurumoorthy.santhakumar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA3MCBTYWx0ZWRfX3gWGw8PLtpuA
 qEWTkNHyT8GBWnJo/35fxbDi4Kcqd7rPxOCYjcNLBLdnYNTKXjjgQcaXqBTE9KG1j6OU6xtPkow
 rQoQEjUMa/TI+nfoz6xwBMwwHi+K+/A=
X-Proofpoint-ORIG-GUID: fyto591-wfF44HAK3pdenKaUMoF4Kdnm
X-Proofpoint-GUID: fyto591-wfF44HAK3pdenKaUMoF4Kdnm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA3MCBTYWx0ZWRfXyAWQQMsFjo2L
 GHJMME15fK187j026Lu2RhAAFHXrEGIU4lGHRexW5cND+SApgs5w6/iI3BG1wMQ6cdGgVenLpGZ
 ZYbbGVYbj3p4gKpb1djctfs+cZzgJB/i46qvOLy+7UPif2mag0tKxOH8TImVml31jGMqb2ShxbO
 KsxQz/1h2qSiO8VfI5zAbc/tqtQQET9tcQymfMOfxwXEUbA5PTcQzDTpOY51Phmivc7pH6YYLGv
 riorgnaYJy/E3hyNa590WgTZbb+gYiaKMO9DAtQRxd+JqMCUnxziCEyVRZbB5rJozqEbrXs14EB
 U3xwW5HMjf965BopEwTTnDABvLWp8REkQW0ESb7b5LlI1c+4+qVF2rfCt1LCm54BqWXOu0mudmV
 Uku42dH36Cx7pu2jZGx4wu1MPSapjQpBUSoAOLcE5uLbpDr0GaNbD0thWnoDeJfDrTeeA0Dwjxl
 EsMyVj5a4sORO+pWDIw==
X-Authority-Analysis: v=2.4 cv=Af0kjHXG c=1 sm=1 tr=0 ts=6ac68491 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=aEf7El5rx04oq9GOVaAA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070070
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

Add a helper for RCG rate configuration using RCGR divider and
post-divider settings.

Unlike clk_rcg_set_rate(), it supports fractional dividers and
post-dividers encoded in RCGR.

Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-qcom.c | 23 +++++++++++++++++++++++
 drivers/clk/qcom/clock-qcom.h |  3 +++
 2 files changed, 26 insertions(+)

diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 6b46d9db744..7d9de5d2073 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -193,6 +193,29 @@ void clk_rcg_set_rate(phys_addr_t base, uint32_t cmd_rcgr, int div,
 	clk_bcr_update(base + cmd_rcgr);
 }
 
+/* Set an RCG rate and an optional post-divider.*/
+void clk_rcg_set_rate_with_post_div(phys_addr_t base, u32 cmd_rcgr,
+				    u32 post_div_reg, u32 div,
+				    u32 post_div, int source)
+{
+	u32 cfg;
+
+	/* setup src select and divider */
+	cfg = readl(base + cmd_rcgr + RCG_CFG_REG);
+	cfg &= ~(CFG_SRC_SEL_MASK | CFG_MODE_MASK | CFG_HW_CLK_CTRL_MASK |
+		 CFG_SRC_DIV_MASK);
+	cfg |= source & CFG_CLK_SRC_MASK;
+	cfg |= div & CFG_SRC_DIV_MASK;
+
+	writel(cfg, base + cmd_rcgr + RCG_CFG_REG);
+
+	/*optional post divider*/
+	if (post_div_reg)
+		writel(post_div, base + post_div_reg);
+
+	clk_bcr_update(base + cmd_rcgr);
+}
+
 #define PHY_MUX_MASK		GENMASK(1, 0)
 #define PHY_MUX_PHY_SRC		0
 #define PHY_MUX_REF_SRC		2
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index 9899cd28aad..3f45bee6b48 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -115,6 +115,9 @@ void clk_rcg_set_rate_mnd(phys_addr_t base, uint32_t cmd_rcgr,
 			  int div, int m, int n, int source, u8 mnd_width);
 void clk_rcg_set_rate(phys_addr_t base, uint32_t cmd_rcgr, int div,
 		      int source);
+void clk_rcg_set_rate_with_post_div(phys_addr_t base, u32 cmd_rcgr,
+				    u32 post_div_reg, u32 div,
+				    u32 post_div, int source);
 void clk_phy_mux_enable(phys_addr_t base, uint32_t cmd_rcgr, bool enabled);
 
 int qcom_gate_clk_en(const struct msm_clk_priv *priv, unsigned long id);
-- 
2.34.1

