Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCE4CC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 06:10:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90EF040943;
	Fri, 16 Oct 2026 06:10:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZZvlx0LwJI9E; Fri, 16 Oct 2026 06:10:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A06534091C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792131040;
	b=T3HNpPTTmTHBnQz4y9+A2xNgiAKStYrSwURvQ/QyGgx8H1J89/KniG5dBwVHmxi9ktp1
	 PVSkUaJWK5fecTqUWIhPlQCrsQhDaKCy2SH0/JeX+qkj9Z6zv65XRDfN2IgEpI4OsRMoM
	 WvT2XtgbEd9Seh1S2Hn3iHTV2sK9B31dtnxaJ/snA/GKNA6MtGqeAG/xksVKTLDNg7IOj
	 PTC+CFkVFjcrEVFpuSQp59QjliobZGU0N8Mcqe1P5O7BZVqc19YA4MRXcyJdcJGJ67MGT
	 vp7R9u7ap9BLIBK2mDzS8dY9r4j78BYVI9wqExxr0teFAjMGeaZ+aiSCoZ4pmnZetnA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792131040;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tlq7BLdvHYBBnDVL7Ej7iAyxRToavJNgonsDeYINxro=;
	b=T8ijclRfV/6OvSkPiUHcBuYDBdTwDM86bWkZSAvgaxepOi6smOgvlKI2l+0R080Yd1RX
	 dBGkTZj/us979MMt42RPXuwwr0BzjG/uxJ1IzG6etOv6HXAFfCW7s3gKRHjUbdHoz5bMb
	 ZMDti7cnf0J9MWdzuZQPoJBgfZL2V6I74zzSewuNepXA65bVZf0iSD3JY0gN3VNXsonQ/
	 1H1kMltt4ggUbcaOGEG9LMC8KaC2FFoAAFREUYNa0kBaoBLTqsqrhqv76/0TIdoFxME4N
	 kaAxTT7BwaFJH7qMugmfy64PwUVAw1+fiQrl+aOResGCiD7M8CyNtSXTGhz/MSJopNQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792131040;
	bh=tlq7BLdvHYBBnDVL7Ej7iAyxRToavJNgonsDeYINxro=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qtk3vg1XLw0UN8ZhFVmtvrVNrTqV+6Xsnrwavn3fgUHTNfZgzphTfXY1uI36XtoMa
	 YYK9f/a2TiNqI/OEXQyQn+QYFF+x1D65h8C4EN2mrWbtZ4i4yDg+PZNTrpdkk1ZIJs
	 w1+h2Tij9JqvJaTQKnGbZuU/v95R2Sl62uhHBTWmHSS0blwCqnHIi4NrBFZ7Oai6tf
	 F5fpcaGTM9rWI8kmud8j5JjBvORPgVb2KEFa10dw95gfy9EwZrIfohkXoYTn7DRGah
	 6LrHQxty84EzVKuk51z9juNBTE/VCk3K1UnFs3JcEFHZg23IwfBbCkwTfCaLH2xtc9
	 r3ubmNyE2AFsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A06534091C;
	Fri, 16 Oct 2026 06:10:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F330D1E9
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:10:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D95614009C
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:10:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VSywtR8ts0ih for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 06:10:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5356040077
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792131038;
 b=ZpG/igzFeXsu4JW4u6mfZ2ENemDjnINC++wSFTj7BPsAgtVw7lUOgDdSVpA4Z4jXfBSI
 bsPu+wM6l4uqTiOe01AQlmhMDNkogDkDB4sPKzIP1Y/w9a9++EH/KuweTlI0Ce6KO0qz3
 gxoi/wuCFRArecIYfJO8tEwEnyK1IlTuI0PR8UWM01/uXUsMPVsl+avg4+7SEc8TUa3uR
 RQbdv8mTDDUnC603oYtcXTtyf8GVRPY4N7sb1MDWb6lbXTtQBr/oN5+mlNr2qq45R82RY
 5OFyHadn7en/qd0Uek9F96/awMCQeFiKrYrnehR0RFinlHfQotg1SAqFD1L83hHdAfA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792131038;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=tlq7BLdvHYBBnDVL7Ej7iAyxRToavJNgonsDeYINxro=;
 b=rm5jr6UA2k589vX5ekwxePuDfe4gZgWL2a4DQeT9PbYnziE2hNSa0GtnvGqAMP+EV68f
 cRATbMJEcU0YZoFRjkehOKAjVTb8GjfBwQi8V5Rne4WLNZyxGbKNU/VQrCmirNh4VNeJa
 iYNQ1VpyVErohXhLN7UkN53gxIk1FZ62NB8QZw/sNsqGueUhKN47ElrmjXt0PVxPlDRi2
 Y6bGD/L4FFEwgxuBmQO7egCxmLOu6u3fNWqVeSQhvDCVzBZ648e94AzetyW4MDnPQWYXg
 WOfrIfH5UOX/7PzSGNtOq42IdGkTRExjwRGNNeKdZ5ea4ZYdf1UjjVJq2MnEnlwCRPA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Qadyiz+e; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=QaSFUc4b; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Qadyiz+e; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=QaSFUc4b
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5356040077
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:10:35 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FLmPPn2678271
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=tlq7BLdvHYBBnDVL7Ej7iA
 yxRToavJNgonsDeYINxro=; b=Qadyiz+e9BuOxn2oc17i72ZdKsO4ecQZKneQ6f
 KksAwJCQ0HVYnfP+KzMD384FGCUWVffNbYvYS/hv+DSMfife6bOid95VVA89uaBy
 QkR386oov41nsrFiIntb+c0H5UVM0TCaTnqI5fxgWQhxNS/I6wXmjXhphj8H9xHS
 o7xCn778yPWKHgUXTe2B9Jpq84fq3dy30Gj1ZkXSQfmsyMEMPpt+JCQH0EQ4PwgF
 KYq+VH8/9egiMjQxGPvQ7aMpb6/X5qdly4VjzuT/sl+iGJ4+PWXMwUbgFU7XflZh
 /BuHVbj3Isef0zYompik8QiUoSniUScDvF1k4XeNIJAMbBug==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb19tb19q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:10:34 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35c3c370b17so7425250eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 23:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792131033; x=1792735833;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tlq7BLdvHYBBnDVL7Ej7iAyxRToavJNgonsDeYINxro=;
 b=QaSFUc4bAaP1sIZvLsbRDaVZTeXxx+YaVUCJw+97nfGppLJPoevI5ngLrp/apNRTL7
 n91PYm8/cn+EIXIO375d5JS3SM7C4MGRtgPZItMnL638ncEbSTfoAezrkQisxJ6nsCDF
 S5VJYrVXJuo8SNI9qPX+BvHzvg1XPHH41ZvrV77toBQnZUIhgJAaf2BlpAoNVzkcUwkZ
 2dOTXnAyJ6J+wRVhdIpQBb68L2cgtTQ285D0Yz5qdd+m+7w+V6U5Ihh+1MsPGhsrA3fH
 X44/wiLfGCixLtR0E1132JbSYBxHU1ufTAyq68A0Ght+KIw97Qc4nUjCrs2W5sAAyURM
 PFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792131033; x=1792735833;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tlq7BLdvHYBBnDVL7Ej7iAyxRToavJNgonsDeYINxro=;
 b=ejmrtF1UFEWqB8WIAWJKuJQle7aFgCU45Zm3Vt4UFxpe4ucyVnnunrkWW0PuT0Rlkl
 tp28gof2mXuoNrJuXM3q3w1iQrudfj1ufNVbVMF6xW6eTp/NG8kXct9YwLveawDBeMfi
 PksHCvywnnEBFuzGa3SWgrDqG1hP3JL9y/HD6EKkd94d/HOfwtpBl9mo1Zd8eALq2qlw
 1JKbQ4Fwx0NzZKPEWJA1wyCvdVAcQPi0QVO4Xh+FwZaGS91ij5PFRFTlEY+HgsyqpuV2
 NHtsbGHmGb8vOQkKvRcolggZTLCMbSXpswzB0zRgXSpII6lJH/jxQpN0XqVMR/yagDZF
 Y2BQ==
X-Gm-Message-State: AFq9FYLUfgTFH/skwET4Z+IWMo0HLtC84o8HL5TtJ4pR4f8K97hwIT07
 vbwbdlyZDLQaDTovVdSW+sWmq1EIaBVMH8fqYAKCuIc/djm8CPGlGi1ki9TkvH+AifnKPuBX5gV
 0PIHA9acIq6inLSg/UV+gGb/edLuyGaFOqm8VGcEbJYZfQ6Guj+CfbuGUYUJ++20+TQy7Watbo+
 M7BUw=
X-Gm-Gg: AYBFou0dkTQ5LbxRvb3pCMq7yYEelJKCMb8X/sdQeqB+CIKmrwC7piE675+Tb4O/EQO
 tmq62MBYRY6Jwr4WfqNWaLV2jZfgVRWUaS1QwwOvSyPVHujnlt+R9GOW9pmtgMknQ7axg6dXTZn
 NPfkBA2vV2d8h8v56T8uKIXwDKsGwWvyrnmh4NmegSe8BFk59/8bwx66bdgozdQn9ZzPs431qqd
 2Qn6oHjT4Gna3L6YeMj5IBeew7EPRmiZN2VFqk/Qxt0tGDJOgh7q7SqaMjsnWYzFXd9zmvDCpiK
 sRLB519Efd2EkUePqSOZZ294CD6AKBVurJWJxCXT3HmKw+VSVDseQBde5qLOn0wxHsveqLWDY3o
 mKYsSUJzr2bcIiUFL/lrWWXUYH6lUqSZJB6U3Faump2imI9R9ls8+TirkLqEBF7+crpkhbMzr81
 kyMfVBjLMYa4AdkiN17Al0ezx2iy4J57GGXrK93A==
X-Received: by 2002:a05:7300:c395:b0:35e:5f8f:9665 with SMTP id
 5a478bee46e88-35e5f8f9989mr7879530eec.29.1792131033437; 
 Thu, 15 Oct 2026 23:10:33 -0700 (PDT)
X-Received: by 2002:a05:7300:c395:b0:35e:5f8f:9665 with SMTP id
 5a478bee46e88-35e5f8f9989mr7879491eec.29.1792131032662; 
 Thu, 15 Oct 2026 23:10:32 -0700 (PDT)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3607ee0cab0sm4379834eec.3.2026.10.15.23.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 23:10:32 -0700 (PDT)
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 11:40:28 +0530
Subject: [PATCH v2] arm: dts: lemans-evk: Add SPI-NOR flash node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-lemans-spi-nor-dts-v2-1-70307aab80c5@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANO/0WoC/22NzQ6CMBCEX4X07JJuQX48+R6GA5ZFaqDFLhAN4
 d0tePUyyZfMzLcKJm+IxSVahafFsHE2gDpFQne1fRCYJrBQUmWyxAx6GmrLwKMB6zw0E0NaY5t
 rqahMChGGo6fWvI/TW/Vjnu9P0tP+tDc6w5Pzn8O64N47BCjx/E+wICAUWlGeJLJFnV4dc/ya6
 167YYhDiGrbti9RSqz2zQAAAA==
X-Change-ID: 20260916-lemans-spi-nor-dts-4a1f7c02e938
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792131029; l=1776;
 i=vandhiadevan.karunamoorthy@oss.qualcomm.com; s=20260817;
 h=from:subject:message-id; bh=FUm6KM7joD4FsOkYgnRB1OiI7qiWwquANba8qoWaytQ=;
 b=4qM9f+wmQ904kegqbhpy3UulhCJ7MnGXZlLlylpXvbpvfMNcV0GTQrWGIhMR5RPww9hymzI3o
 5xAl9NfFR28Atut7VqtMHLKkwXGZ/+k+mnMaYypNzEo1cXc742wr5v0
X-Developer-Key: i=vandhiadevan.karunamoorthy@oss.qualcomm.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Proofpoint-GUID: Spnr2JduUA79cVFohUuaCxbNEVNJztix
X-Proofpoint-ORIG-GUID: Spnr2JduUA79cVFohUuaCxbNEVNJztix
X-Authority-Analysis: v=2.4 cv=NqZE4MdJ c=1 sm=1 tr=0 ts=6ad1bfda cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=poP29n66LpQIKrTssMQA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAyNCBTYWx0ZWRfX/S6t/2M6RKox
 E7RL8kMMHW96QnL4Lx6wkxCLoM3Arc7WAbr98O/NCDZgx6iYHnywkpBw8qL6PxE0B6LDWdWJg/p
 Mb4VB5VCpgukGOLNZ2Q5HSvAzyVgmr5BSbV1hgB8dZuYNr6gfwXw9MaSvPx5bGyfD3Y4yZ/ZgVF
 Vrwno1yGNEOxkNxapx9tRCff2sW5vDj2L1VlUR0GXbTROqd0cpu07MervGf5ZLcLg8PveG943k/
 AOr3EwdT/urHXtTRFPaEOrU/J1UpWOApabP36vv+9Vwo9LQLe9q2fb6QA0kGVwu+C+iPobbc9Xa
 GNxesFvJDfeiH3E+pvCCxyK28+GCH3FWrQZJON76OUXXCsWrBrz9+o0rAa1yrUQaerCwuWBfY/t
 H0QjePBK1lpvdh9bXKiZHYrv+7WE+XU/i1aRJZjU7syvn/FswSVu66EvYQ+SIJaocUAQ0rnIBBV
 pNbe5Wk5RA/LwQ1tUsQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAyNCBTYWx0ZWRfX8SX5nQHt1O+L
 2WsFSX8FTlqvHa24IfnasiSVQDrFgv4LkK34Sts5gP1hK39mS6xXCiVskqkYM7gxKmN6sa3SGBU
 Qr6+pVycbohXKuVVGgcyzlqtjB4Vuhk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160024
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

The SPI-NOR flash on the LeMans EVK is connected to SPI21 (QUPv3
wrapper 3, SE0) and routed to the SAIL hardware. The flash is used
only by U-Boot during EDL or recovery flows and therefore is not
described in the Linux device tree.

Describe the SPI-NOR flash in lemans-evk-u-boot.dtsi. Keep SPI21
disabled by default so that it does not affect the normal boot flow;
the recovery flow enables the controller when required.

Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
---
Changes in v2:
- Override only function of qup_spi21_default
- Drop redefined pins, drive-strength and bias-disable
- Link to v1: https://lore.kernel.org/u-boot/20261015-lemans-spi-nor-dts-v1-1-8c2e7330f1c4@oss.qualcomm.com
---
 arch/arm/dts/lemans-evk-u-boot.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/dts/lemans-evk-u-boot.dtsi b/arch/arm/dts/lemans-evk-u-boot.dtsi
index cdd3d32f61a..f17347b1f2b 100644
--- a/arch/arm/dts/lemans-evk-u-boot.dtsi
+++ b/arch/arm/dts/lemans-evk-u-boot.dtsi
@@ -17,3 +17,28 @@
 		      <0x0 0xd3500000 0x0 0x2cb00000>;
 	};
 };
+
+&qup_spi21_default {
+	function = "sail_top";
+};
+
+&{/aliases} {
+	spi0 = &spi21;
+};
+
+&qupv3_id_3 {
+	bootph-all;
+};
+
+&spi21 {
+	assigned-clocks = <&gcc GCC_QUPV3_WRAP3_S0_CLK>;
+	assigned-clock-rates = <48000000>;
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <48000000>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <1>;
+	};
+};

---
base-commit: 9703d24aa2e5f2ca0793a47a25807eba53716792
change-id: 20260916-lemans-spi-nor-dts-4a1f7c02e938

Best regards,
--  
Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>

