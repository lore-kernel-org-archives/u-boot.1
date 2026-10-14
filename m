Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9414DCC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 12:51:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 38280607A9;
	Wed, 14 Oct 2026 12:51:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NNbIWRSj7gXd; Wed, 14 Oct 2026 12:51:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5442E6070C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791982298;
	b=lsbRh0wsga29EShR9EQZJgD0nHyj77qq2IqwqpmuvVrW60glPn5vXT3EVie5ugviJwe2
	 VGj+gm+B9QUwrYycRZy+F7Rxuro/+LZt1ZHSgoRBjJzW9/EzRCGNUUNoZAhF4PHTkFxkf
	 krPA7IfPYK14zCFvUrFvBe+svMUX2O1D7yoSvc/O9y+2vY2BzsqQFHoehg5BCQa4jsSDx
	 qIxgWN/PUlax+5gFb7fzKxg+ja8SpoRB66kUFifGwhvXap6hZpyxoKiNsJmwG0TLSVJ+I
	 3jU3PMTSLJklGM+cHxRqjfwlUDIxyyFMrMWI0aQuJjtj+NTRVw62km2oKdXWlACrfNQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791982298;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2hqrf3gCBrQTiOPCarWIAT7gqBExkFcbARARE4vNTSM=;
	b=NnRoDaZCnEBuL6lq1dnWD/rsUwvVJK376gNW3vDho937Zi3aZ+yVnyIClo/fzA6STc+5
	 D3Mxoze2Uy3D7+yoYZT+RBt6QJkkgTLjCufmZ5okwgnTJ/6lLT1SohpMyGY72S3We76Up
	 2ZK/Z6E48TDJrT4hUGejwt9jhqLlIgkz5kN3tHQIUoDYTkHisAevCPuGf9kPS6AX3wM2d
	 57c9qDtdvtw5xE6HiYqCfQllysM4tj/M9F++6/4OCvfKnTg8Do3Wae648AX6WV95zhP8n
	 snA6569RExH598CKbVVUxX1wStuoTfdYf4vPxCd8dsi85O8UjvuZ5g1ZKTxrSJ4uepw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791982298;
	bh=2hqrf3gCBrQTiOPCarWIAT7gqBExkFcbARARE4vNTSM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tm5P2XORoRIimoqFp1euHv0mhbZ+DF3nmxjIaybh74escyaklPA/Z3/T1B+XqMxXl
	 vO/7r+TRzDibhrc9Kvw5pb8N+Oa5Xbb89i1+a5BAcQ4vfKZ23psQDqDxjrFS4Ia1jR
	 Ot2v28h74k8WN190492v85vJPv/w1/zf60JihOX0FdAzVOyIGPRixxWyCQ+OguDXSh
	 uhz7IYbSDAxAMYSlyhR4j32qAT5JxSo9xVGmXgg+H1HvLHwdV+NI6vypsKILurqhVR
	 FxYCnrts2f3tnf/5jH2uRiksGMlMbxVJiJqOVLbTClX8sRV8J2OP/ORheA2/zib22b
	 +szS/MZOeztHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5442E6070C;
	Wed, 14 Oct 2026 12:51:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 51CB11DE
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:51:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 43D354006B
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:51:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1NhXyPwTv2U5 for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 12:51:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5E75D400D2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791982294;
 b=QF2KVxGl5zwggBwQFQAwgjJDpu3LrlOs0uDGCcrYbdmd4Zvs0KFS3TXbfP3hHvpc0pC+
 1vu29S22RG+HbjDEygNAPcJxPPxVP0PlctJIdOlcImlhI0AHc02OHRZRDrHX9DuhMcbt1
 Aan0Bnp21fDoON+2g0a0bLvKPuReOAp47oJFBKQMaZeenzX9YvjnZROXgF+6GbNA03MAt
 8qWyQBAel8wo81YhgiVbE3kCXj81H9AXZsI5fVsP9qs7N0oBoFAsRhJ/JQe0tzJGAz9o9
 CFNSDWwGcIsDXU1EchSOsHvefJ7YQlguEaUD4W5IRow1ooubMH+xMOHMr8kI0GqBn4w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791982294;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=2hqrf3gCBrQTiOPCarWIAT7gqBExkFcbARARE4vNTSM=;
 b=dpejwQpQMzQClwyA7zepwGi+cIfM/EgtKAWjw4vikU3HC2MVS7GEtJHuZ020qETrGt2b
 0SYAB/kVEM4e4/BSTh91NmyG0EdOj8np0GIxRcEbjKasVCI2pO/9NkufMnv/qG9cZGYt0
 motDlArBQZcazPmVxbXiop6Qfho/FvAXygdNLDxHdkJCrkcJw5nZ9PsJVFR+EH0xX2zw5
 XLypdt1+4mM+y+gQg8IOJXfmpACewZlGiKbs/w4+M2SMN4MRWZaKKohsb08G9QEbihwzi
 ZlunvvcMPgbdhcwb/WdgADiOApdjx61ftVc7ed3X/rfBntF0zQADRGWwl8Eev0ZkH+w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Fazd5alO; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=S57kxphF; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Fazd5alO; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=S57kxphF
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5E75D400D2
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:51:34 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EAZNEi806673
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=2hqrf3gCBrQ
 TiOPCarWIAT7gqBExkFcbARARE4vNTSM=; b=Fazd5alOrRviq8RhJ8ey/HaS5ES
 rnqR+Ra843HfFR1iFDTzQP00wPy2OqMRSuIEV0L2ZskuQghCj9t8aEUPZ9Rm1bFs
 sShxXvpMFMMfVFn/augPfqyWgGHBbanqXWr/ZjLhysvM2Dx9+yFrX+0z+69ZRdAG
 sBHyTcLXWV/Lsx7rVUXmtQvXbe8bZf9JxzuAyVDUOM47ggg2vGmq6k6PWHjumrLE
 p7HaDnC42rFOoEon3zq0YdIxyMnJLaUpCZM95tbKQ8MF4mN4/P+whsd9LD5TduDS
 cqC/ZswM+Bw5lI+mUdPYSXHS2yBA0J7ACpt/fm0f+1pb8S2DtoZX7kS0qEQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9ud6bh6t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:51:33 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-351788121cfso7238700eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 05:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791982293; x=1792587093;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2hqrf3gCBrQTiOPCarWIAT7gqBExkFcbARARE4vNTSM=;
 b=S57kxphFGrJcLiXR1iIsWDJ6/DqG1xJNyjQSl8NI8vCI2rzURkpsCfH4hXd9CQlEPc
 gX/+WHGrGvP+fF70v6268DKw8D7vCw6LIk1Ew5rh8KPA2m39aAYbCPN5FfczFOm91I5N
 Y6EAKdcFIgCpxdTsoOq+mKzV4B8SoazsL4CobsCC5gxniUPeqqcpEOOtDgK7QVao2JX7
 TDWlvbwUQK9rzi3eK8TfarHPGq48uIU9uTw3WuuLZXhsnBmrSDbFD2BOsEINUR48bUCe
 +N5BXU+x/3dBpLLPfzsr1fOSMN3lPyUPTYhRU19BNZMX6wIZUtGKwrviutE6LW3X9gHx
 dNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791982293; x=1792587093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2hqrf3gCBrQTiOPCarWIAT7gqBExkFcbARARE4vNTSM=;
 b=FS5uOgRf1WpRw1RIaxkbL7kAH4o6sjr43jnXCBpdrwrF84tUfGEBSBaUFR8phprbiW
 8pccfjBX6NaRMoeqxpzcJMgcZaca38PKLzOWCFmyMrA7gYK6BDYUcUdsS2k9SkxdM1oF
 +seS7412QpDC1HnSRg4GrJ2gfE7vjNPaOtsS1iF5tJMaf7FP2JQ2mYV7KGVBNA2atmfo
 mp+HXBQaoVmWnf9fghx1vXcOiQRyd5ZWFN9eO2RKufNVwyZiCA5OzebTVih3qra2v0vM
 gVI9RH5tpENIJjJOf0ObPo4uMBbZ1Ve01FdOikszTKVmVdlLi6smWBgk43PPLnpABwmY
 C6BQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw9VEy5JPeiVdywhEEGfnfUXSHlioxAe6dAWjH+FHcz7PZ8kNojKSAeRMoedcnP96/C/6mG/tc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLYNGArHzLxzXxJ1mI7CNyubMYd015lSRX+yWfY1+ACOLDG2fL+
 dz142qM2TAoRv5JNO+RKExOAmwO5fOwkXjKmfB0wC/Kc2SMOmEXwdrDiutnp1Kluqjsovltz4cY
 tC329qQT49XQg4HkxvlRjSWeHiWbOmLlyKv2iPTGTGHS63SQ90afpH/yN2hLa9KatQTjMmeo=
X-Gm-Gg: AYBFou0poE6Cd0ev0TkSENB32Dik7Mzqk3V+7CdYDR99jI2OlIoWj773HFZ3Cg08p1V
 22NQeTuMwEbQi0+GjBO69cHDbHeKjbja3NCrr/DnP1WWjxyReXXDb9jzz+rYFdjnB0IFRW2VNqu
 kbIFByCOv05P5+6Bu635RzAMBfm0C+L9hv1/PcXPs5Df7c0wwMrRei/afdpxuYFToMHcpI/wOTd
 gRShB8ujH2EBYOmgyhESqrngL/swB6Sx0KXKpPWYUZr9cduCvuREKnJSN7DRuBM357vUzj9ewZn
 Rs37NZhdwGlrLKFVVn0wlQkDwAQtePG+ICY9SW/54XcjV7P4eOsNY4LT2oepJ+7RgSnZ2OmZWDz
 vHxk0BI8K8AikmzC8pc/oL6408I3MfwnuC3mQZebHAD/G34w=
X-Received: by 2002:a05:7301:78a:b0:35e:44d6:eb8f with SMTP id
 5a478bee46e88-35e44d6f12amr1524179eec.39.1791982292597; 
 Wed, 14 Oct 2026 05:51:32 -0700 (PDT)
X-Received: by 2002:a05:7301:78a:b0:35e:44d6:eb8f with SMTP id
 5a478bee46e88-35e44d6f12amr1524144eec.39.1791982291906; 
 Wed, 14 Oct 2026 05:51:31 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-353814b556esm59713782eec.18.2026.10.14.05.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 05:51:31 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 kr.sowmiya@oss.qualcomm.com, sjg@chromium.org,
 varadarajan.narayanan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v1 1/2] cdt: enable CDT for Shikra SPL
Date: Wed, 14 Oct 2026 05:51:24 -0700
Message-Id: <20261014125125.711084-2-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014125125.711084-1-abhilash.v@oss.qualcomm.com>
References: <20261014125125.711084-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: eN55-XUA_HB6vDfzUMgKEY55aKleRImf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MSBTYWx0ZWRfXwm5ybUrpBhEt
 be7dNWpAY3mOL+sCsNIk5LdU361Xojdh7upgDJtVPvI1iP0lnXrPc08AuyfhhNp9NNd//hUugGR
 9ugjw6rdmMSJKh+QLSxJzq2D+wWmDZk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MSBTYWx0ZWRfX72zkTjhdM2Ls
 +7dO/2JuLgB2cdn3U7Lk5cdX3jDAhIymsjv2pQNRc87F6gbsp1btDoZ1fs1kNnbPNzdWK+Yumdt
 xY8MFjFamORmamJjINstbdQ1wY0PQoBFjn8t0WDW3lkm4kwfFV86Xyz7XnhllV/bxtzi38HznCE
 qGKHFbYMiIGHZpLh9f8Xoqj9WEMF/vpbTx4guquKRLXo2suX/e26G3BVHEGB96WKO85/T70Jv3R
 CoA5ZeBQtGT2FqrxcSlCwDnovo8eE+vQm3pqAVCqH9RbQGZQIl3dugFbbkWfJfgrDECH67BCJXY
 v6VyvhxdPzp+ds0cUxBoxpRM1HvCp+vD35udQi3YW83r6lNtiw46UZ3xZyhqU6HHNOE7tRg5/Y+
 Yr1T3H7yDQlKA/17y0IdPClPG2E59zFcWl9lGP8CgqHElFMIBJN9A8m7RM4+u8xv+6YP+PqZxev
 2Yh9MARzow9Ve6hG/zA==
X-Authority-Analysis: v=2.4 cv=fJ6sTpae c=1 sm=1 tr=0 ts=6acf7ad5 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=lxvI--4TMCuyKu_ZmrgA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: eN55-XUA_HB6vDfzUMgKEY55aKleRImf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140051
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

From: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>

Add support for loading the Config/Chip Data Table (CDT) from eMMC
during the Shikra SPL boot flow and registering it with QCLIB via
the interface table.

Signed-off-by: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board_spl.c        | 96 +++++++++++++++++++++
 arch/arm/mach-snapdragon/include/mach/spl.h |  1 +
 arch/arm/mach-snapdragon/qclib.c            |  8 ++
 board/qualcomm/shikra/spl-shikra.c          | 15 ++++
 4 files changed, 120 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 31a06b1e002..725d0cfd1e6 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -10,6 +10,10 @@
 #include <dm/uclass.h>
 #include <hang.h>
 #include <init.h>
+#include <linux/kernel.h>
+#include <mach/spl.h>
+#include <memalign.h>
+#include <part.h>
 #include <linux/err.h>
 #include <mach/qclib.h>
 #include <spl.h>
@@ -38,6 +42,98 @@ void __weak qcom_spl_soc_rpm_reset(void)
 {
 }
 
+#if IS_ENABLED(CONFIG_QCOM_SPL_CDT_SUPPORTED)
+/**
+ * qcom_spl_cdt_load() - Load the CDT from the boot medium.
+ *
+ * This functions read the boot medium for CDT information which gets saved
+ * in IMEM location.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int qcom_spl_cdt_load(void)
+{
+	struct blk_desc *desc;
+	struct disk_partition info;
+	lbaint_t blocks;
+	bool is_mmc;
+	int ret;
+
+	ret = qcom_spl_get_boot_blk_desc(&desc);
+	if (ret) {
+		pr_debug("CDT: boot device not supported for CDT staging (%d)\n",
+			 ret);
+		return ret;
+	}
+
+	is_mmc = desc->uclass_id == UCLASS_MMC;
+	if (is_mmc) {
+		ret = blk_dselect_hwpart(desc, CONFIG_QCOM_SPL_CDT_MMC_PARTITION_NUM);
+		if (ret)
+			return ret;
+
+		part_init(desc);
+	}
+
+#if defined(CONFIG_QCOM_SPL_CDT_USE_PARTITION_NAME)
+	ret = part_get_info_by_name(desc, CONFIG_QCOM_SPL_CDT_PARTITION_NAME, &info);
+#elif defined(CONFIG_QCOM_SPL_CDT_USE_PARTITION_GUID)
+	ret = part_get_info_by_type_guid(desc, CONFIG_QCOM_SPL_CDT_PARTITION_GUID,
+					 &info);
+#else
+	ret = -EINVAL;
+#endif
+	if (ret < 0) {
+		pr_err("CDT: partition not found (%d)\n", ret);
+		goto restore_hwpart;
+	}
+
+	blocks = DIV_ROUND_UP(CONFIG_QCOM_SPL_BOOTITEM_CDT_SIZE, info.blksz);
+	if (blocks > info.size)
+		blocks = info.size;
+
+	{
+		ALLOC_CACHE_ALIGN_BUFFER(u8, blk_buf, blocks * info.blksz);
+		size_t read_size = blocks * info.blksz;
+		size_t copy_size = min_t(size_t, CONFIG_QCOM_SPL_BOOTITEM_CDT_SIZE,
+					 read_size);
+
+		if (blk_dread(desc, info.start, blocks, blk_buf) != blocks) {
+			pr_err("CDT: failed to read CDT partition\n");
+			ret = -EIO;
+			goto restore_hwpart;
+		}
+
+		memset((u8 *)CONFIG_QCOM_SPL_BOOTIMEM_CDT_BASE, 0,
+		       CONFIG_QCOM_SPL_BOOTITEM_CDT_SIZE);
+		memcpy((u8 *)CONFIG_QCOM_SPL_BOOTIMEM_CDT_BASE, blk_buf, copy_size);
+	}
+
+	ret = 0;
+
+restore_hwpart:
+	/* Restore the default (user data) hardware partition, if eMMC. */
+	if (is_mmc) {
+		int rc = blk_dselect_hwpart(desc, 0);
+
+		if (rc) {
+			if (!ret)
+				ret = rc;
+			return ret;
+		}
+
+		part_init(desc);
+	}
+
+	return ret;
+}
+#else
+int qcom_spl_cdt_load(void)
+{
+	return -ENOSYS;
+}
+#endif /* IS_ENABLED(CONFIG_QCOM_SPL_CDT_SUPPORTED) */
+
 /**
  * qcom_spl_get_boot_blk_desc() - Get the boot medium's block device.
  * @descp: Set to the resolved block device on success.
diff --git a/arch/arm/mach-snapdragon/include/mach/spl.h b/arch/arm/mach-snapdragon/include/mach/spl.h
index a32a85c48fd..ed3e5910e7a 100644
--- a/arch/arm/mach-snapdragon/include/mach/spl.h
+++ b/arch/arm/mach-snapdragon/include/mach/spl.h
@@ -12,5 +12,6 @@ void qcom_spl_malloc_init_f(void);
 int qcom_spl_loader_pre_ddr(u8 boot_device);
 void qcom_spl_error_handler(void *arg);
 int qcom_spl_get_boot_blk_desc(struct blk_desc **descp);
+int qcom_spl_cdt_load(void);
 
 #endif /* __SPL_H__ */
diff --git a/arch/arm/mach-snapdragon/qclib.c b/arch/arm/mach-snapdragon/qclib.c
index b9a74863c1c..16308e0e77f 100644
--- a/arch/arm/mach-snapdragon/qclib.c
+++ b/arch/arm/mach-snapdragon/qclib.c
@@ -123,6 +123,14 @@ int __weak qclib_populate_interface_table(struct interface_table *if_tbl,
 	if (ret)
 		return ret;
 
+	if (IS_ENABLED(CONFIG_QCOM_SPL_CDT_SUPPORTED)) {
+		ret = qclib_add_iftbl_entry(if_tbl, CONFIG_QCOM_SPL_CDT_PARTITION_NAME,
+					    CONFIG_QCOM_SPL_BOOTIMEM_CDT_BASE,
+					    CONFIG_QCOM_SPL_BOOTITEM_CDT_SIZE);
+		if (ret)
+			return ret;
+	}
+
 	return qcom_spl_soc_qclib_override(if_tbl, fit, images_node);
 }
 
diff --git a/board/qualcomm/shikra/spl-shikra.c b/board/qualcomm/shikra/spl-shikra.c
index c2a5d2d692b..98912493c88 100644
--- a/board/qualcomm/shikra/spl-shikra.c
+++ b/board/qualcomm/shikra/spl-shikra.c
@@ -12,6 +12,7 @@
 #include <dm/uclass.h>
 #include <init.h>
 #include <linux/err.h>
+#include <linux/kernel.h>
 #include <linux/sizes.h>
 #include <linux/string.h>
 #include <malloc.h>
@@ -333,6 +334,12 @@ fail:
 		reset_cpu();
 }
 #endif
+
+/**
+ * qcom_spl_soc_qclib_override() - Populate Shikra-specific interface table.
+ *
+ * Adds Shikra-specific blobs/entries to the QCLIB interface table.
+ */
 int qcom_spl_soc_qclib_override(struct interface_table *table,
 				const void *fit, int images_node)
 {
@@ -381,8 +388,16 @@ void qcom_spl_soc_shrm_reset(void)
 
 int qcom_spl_soc_pre_qclib_routine(void)
 {
+	int ret;
+
 	qcom_spl_soc_shrm_reset();
 
+	if (IS_ENABLED(CONFIG_QCOM_SPL_CDT_SUPPORTED)) {
+		ret = qcom_spl_cdt_load();
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.34.1

