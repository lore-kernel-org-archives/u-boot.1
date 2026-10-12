Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC3BCA9ED5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 05:35:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85A8E80D01;
	Mon, 12 Oct 2026 05:35:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n9VuCaIxPop7; Mon, 12 Oct 2026 05:35:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 92CA280CDC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791783310;
	b=Qpq2e5dpimlTgVUoS1+lZjxzHDeTzJ6dFwu5rRQ+V9YBRJ9WPxD1gsVWJ23kqGxu2ZH2
	 BVaMs95ERh+sQ+nqAP5Ft544eXpM5DsUv2fqP2Ygn3pQD0kb3OiHHXD0+b+dSZT3pVC7s
	 XD8rY2OvAQLzBzlIQFaa8xAePoN2XPnn2DoXGk2AAJ561ZeQmFVoxEBHWijVTw3JWXqm5
	 9zcNcbAolgFDeI1i2/mNcuZm3Gi4oJdyKzY7JxeIt6Iri5+T2iDDl3e81Oos+YonHY3yB
	 S4UKr72jk6XhaH6KDoSg7ST7P2uQbGj3dhBD7/MUqL+mJrPgnbR5goSNCzaKg18Re+Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791783310;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5AiJtkANOsugNwKsD0H+w5jWkfwEMDigYTwnkN/Pv5k=;
	b=DKejvZ7S/JR6tgku6RohBk6oEfaCoT6QQMOxTNXpeuGzqA9ik5usT3uKy8TM3IHh6i9q
	 cwlBlgQkJONpp5gPZuBhdc1V8aJ2ztQDWDl+F7JuMKFmCRQWwYGfb84c0Tnk8lyUT3W/m
	 msI/sj+qrsJ41tRarHx7SzkYNdWhaEyqvaK/GciVXbp1iqEHfTpZzesYGd8z5VK06hFdm
	 59NPjXp2QViZxkFA5541iVGkRqcUSMolQ50acaaqZ18qxtQ1PTk1vhFnPJovCmIIY8SsX
	 zJdbXCffkY43T1j/hKLgSWlSclR/K7/Yk2B1ildQra0Q4VhcHw6er2fW3ZeQFFQg+xA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hFNdO6W1;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fMnYcwmS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791783310;
	bh=5AiJtkANOsugNwKsD0H+w5jWkfwEMDigYTwnkN/Pv5k=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=1I4z/SY/FRcpvNkMdlY/XUULOVKY5mc1EO+Fd1LRsRCBEsnRO+JaOLpnOJ8WNygms
	 jbv0isQxmUcPjq/m2NX1NQfbIZnDlYG3dDY8KaeEMlFi8Y1IGYivP/nnB5+Y9zHBuU
	 XhmogZterMtIfOwqr4jb9rvdPpZHwnZlQVmkUcnHf/8EBPVpF33wfDOv111ZSp6A6E
	 MAwrja9g6H7BIkeCJBL1YMdPwFNCc8KEpwgfY+HsL11d6ENkAyeU4K+8AezCs7hwcF
	 wiwAh2nIUT6r6zllI562yMerHNdDnn4xyOgoL6aUYPD2lXRToXk8qqr434ZMjbrVHC
	 /TpyXKMATII+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92CA280CDC;
	Mon, 12 Oct 2026 05:35:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D96B9DF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 339C880CDC
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yJQhd6Ni292C for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 05:35:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0C04280CD8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791783303;
 b=poB7vdB52U52VTabbvhcOfNYYYPUKQH15LhrJ2hsYzX/9vqpgTe00Wtxes3Dmuyql8yX
 wimXDwgaOhHZtZHcMyZt00gsg0hIYLJi0Tk6TABTD55iWlPXoVZ5q1GQTiT+O7KSWty3j
 60p4SN/Jy+oWctybJr8eWn09OJUooj8sPO9Tw+3jltv6bWeIpRCUp6XkzZ2WcFGEmlM2O
 feemeHFfAc6SHfv7EdYkA1IgIJpNDnzPPMdTohYl+0enoJdE1Y9ZJoyTQyBVeIpZdFxMw
 gtZI9L1NCoW/qfveIYdLQWpYfFwIBW2bApBq61YxRoN9s/XUE+XQPD+xoJW4EGSG+EA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791783303;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=5AiJtkANOsugNwKsD0H+w5jWkfwEMDigYTwnkN/Pv5k=;
 b=Ae1JKk9dMlpX//73+viD7vBSFoQEFd1H9pYNfI0oOy+FOakLh3PAAIJ7nAyUBWdy4xYh
 3qUuuTMgn6PwWpUqkalRSVPWblPz5f3PXNbypO9oIupg1oe5mdLDY4l0ZojTpELN7eYmX
 dYEJ8RmZk/2XpQr5dkmXQ5zL6IUXhAjCukFYIl/HFEiY2L96wWBKy70cBwG/f7FBaCQoO
 vto3/FvBnbYVCHXAKhtN4TObhNT1EzOXpY5BydHNOmgh7evA1CJI9zz6jobvlIrLdk2PY
 lDQwbRmueSuHopAl1TzNgjEB/dby3ocT9pxnnb/1SegHZMw2LbZwnFzd8N9CbKYjNpQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=hFNdO6W1; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fMnYcwmS; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=hFNdO6W1; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fMnYcwmS
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0C04280CD8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:01 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C5Pg0f1787104
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=5AiJtkANOsugNwKsD0H+w5jWkfwEMDigYTw
 nkN/Pv5k=; b=hFNdO6W1QfU90feSvs7sosLBIB8IHujshnNagEAPk+m0EzSVoiU
 lbbN+rArebr5BMBk4l02JbINbVeJlQOxI6j+7g3dwJjK84iUg/kTXZ4f26XCVzXZ
 3MwUqV7yBKkuJr8cqsNMNhIuo5UzHHT+nKct/lkmvR3Ef2yNh10I1ZkLSpB5HSnM
 UV+JguojygGuqwB3RsKLg/hIEbGnj12J/CVepXN2rtALfc82IDGaMvdfb0bIF6xb
 XwBeaSmjb6lR2hF7txX352kuw2CWNlsmuLlFz+jM2zrXaC9EJokG5dLEFjzRIEd9
 go90YuzaM+EZChw48M4Sz7yFJpTfGe1ACoA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8sd1r101-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:34:59 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33713e5e6daso2661888eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791783298; x=1792388098;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5AiJtkANOsugNwKsD0H+w5jWkfwEMDigYTwnkN/Pv5k=;
 b=fMnYcwmS8nlxVu2aWvxFhQlrwntqJm18lgmXGCaon6uCy5B4yEDoE0EaK0Eg4jI9eU
 EKFRZ8Pvq8ZUnEyvN65TByMOy0ND67zH0dSeA/F2kK2smuySOGMVEgr4oD37mru3liAC
 0zyNtZmIWkhnJh3zeSUApnDQArsp0/feL9alF6AC/U4caVgoDCABd7hK2m/a0Ybxjl7a
 kWPVkEaLINuclZ0xyeRJ3RHkQWJEFt5Dne6g4se9EzOHj9RURdkG3ypqMMe3WQKBxS+b
 SjXa3UUs48p6v25mPkhKBffISG1sjiYseIm7fVRcvAxB34FRYwxhODiHrwaEOHTvTKYK
 Q3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791783298; x=1792388098;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5AiJtkANOsugNwKsD0H+w5jWkfwEMDigYTwnkN/Pv5k=;
 b=wBEpomXlQS20av3fBEklNFDsqsZiJlodTv69vCt08iw0lwGmV6gzxq7NIIPJUEv/0R
 bbHd27zZZ4S1mZpMdY/h06Dmo1/cgLSrswA06o6T8hyIQs6CgCvXrpfGc81Sje2pKw50
 T7uZO4wiG5H6Yx9OXepBqmShEXDBct+5qBjD2goh6JrZfgSttlx4qonqK7RQYt/bZJ+H
 kqZBS02lw78tiiTjBxd6AOXZeENMOyYL4cBUOFBrEoDzDvymYHJ5iH6Tl2HjBgfqn/z+
 ATgDUojlh82TStaqOjK0fIucLE/tRVj64h349id4J/Q+zlwrSXowqQoemA0fK+0BzPGB
 UXbg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwASYObO1pNqw1N6/lXR3o72BwL7Tk6z6IxyG6zbXlmyCj6kO6Vbaf/XrC9VqElGhIoaAoWwjo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKRaocRYk6f1gACIdpb2g8XkewhoJCcCRtXiuRhKK5Ub6j21Qn/
 gQcrfVjvJ0/uh+8lSycJ3xakkX2Bu61xZyL5S5jpZZndps41l+TUtisxmf6tS5E2YkbmVHR1ybP
 z6TDfVt2AAQvUZjqoye8m0o+vWA6P/nldL91MYC2STc2ZeWrtSol/9x4Xm0+bU2Ga3WQcQ4o=
X-Gm-Gg: AYBFou0W2Sk0kJgeXjafOAS8KLnR8HysXYeZ93zl/L5UEdnLWTkACMlNKWgWTPiN5y9
 cHMZjEPG8TsUv3qoTliNetoG/emIoUYbdd0e1GyfSsvdTq3HDOfVkcB0HWepV4niI7piZiIRgqH
 VgKcQZcXx51YiDI6X8MauihctzLT6/hXJFUxu8YDclCjZaLOh9VqhTn4kUwN2Fz97OB2Re+54fI
 JT4HY8R6MabziSPiAPWUUX7gR9PIxix1KOh9czGuuIk7DMJ4trp4b/eGHcXp1vdllvY8nqEsD0E
 COrmRLvO5ALBtCmZAkq4dRQQYKpK8c3AWmc9QyRi1J5IVAWgDaYzeJeVccgIpcHFY9EV3+BTxTS
 XKoLiurgZ8qfb8KsD03Ce8pueQ5xbqR+GSp+vo5fFBjSIkTpz
X-Received: by 2002:a05:7300:6d06:b0:34c:8f9a:30ed with SMTP id
 5a478bee46e88-3537e08e04bmr20236017eec.18.1791783298117; 
 Sun, 11 Oct 2026 22:34:58 -0700 (PDT)
X-Received: by 2002:a05:7300:6d06:b0:34c:8f9a:30ed with SMTP id
 5a478bee46e88-3537e08e04bmr20235959eec.18.1791783297570; 
 Sun, 11 Oct 2026 22:34:57 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cab27d5sm33446935eec.17.2026.10.11.22.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 22:34:57 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, luca.weiss@fairphone.com,
 nathbappai@gmail.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 00/13] qcom: shikra: add eMMC SPL boot support
Date: Sun, 11 Oct 2026 22:34:39 -0700
Message-Id: <20261012053452.1567885-1-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: SBItJCvjO3HIf30uAimjuRNqBgDDCoEc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAyMiBTYWx0ZWRfX1i7kC2Jsf/sI
 AFE4mnOyhSYMwMgoGKzTdCa59Hp7om+mAhIm4SUPdHgbotkyqi8carsM+rld4gRUQwPekImz/qq
 VVbcX4ZCSKGMGeLHhe9jIFzEQ/WySwQ=
X-Authority-Analysis: v=2.4 cv=QtHLTlyd c=1 sm=1 tr=0 ts=6acc7183 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=gu6fZOg2AAAA:8 a=yl49YU_cyvTrWwRhe6cA:9
 a=bBxd6f-gb0O0v-kibOvt:22 a=2RSlZUUhi9gRBrsHwhhZ:22
X-Proofpoint-GUID: SBItJCvjO3HIf30uAimjuRNqBgDDCoEc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAyMiBTYWx0ZWRfX1xSKKNKV3FQM
 G5tnU6aznNNjPAsNFK2YsAyEA0ADj0yS8nRwjRk+gY/ryRmC6QtpYpwbCv9vgVx0W8SqQ1o+r1g
 4KhRsGDZ/4IbH/gifx6PT/vZC7OHwV6+Ve6jgYyDvCaEichaFkKdl182we++hBJOGDD8p/4nN/L
 6egJVwr76/KHh6SCiIehmkTrvHP2R1JOFwviAcwZlVRMYcKqiobJfgzaz4q9aJ4LTjYjylvYdI7
 IyfKu8w4z1T8u0ro5xhr6VkeajIxMeRj0HJztXcTuOscNDokvi4sY+roznktsdhLDBy2Fefbzhh
 cj435U6g80BIYMHiLq2h604PxthfZSft6xQSex9cKWEPEMz3yzCNMGkQVjExk7Aefn6PdT4EJQA
 yVFKZgwWWxyz/KECBA4SF8BM0/GBVzuSbAgzRYZrFCfjMagiPWlTHTZ+mO4dSiYZm54pKRpvhxh
 uwSSpYagUVohDuKH0BA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120022
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

This series adds U-Boot SPL support for the Qualcomm Shikra platform.

The SPL runs from BOOT_IMEM and performs the early initialization
needed to boot U-Boot from eMMC. It configures the required pinctrl
and clock state, loads QUP firmware from its GPT partition, invokes
QCLIB to initialize DDR, and loads the U-Boot FIT from the eMMC
boot partition.

Dependencies:
 
  This series is based on the following previously posted series:
 
  - Qualcomm IPQ5210 SoC bringup v10, Varadarajan Narayanan (15 patches):
https://lore.kernel.org/u-boot/20261005-spl-v10-0-c4ca29bf27ed@oss.qualcomm.com/
 
  - Initial Shikra SoC support v3, Aswin Murugan (13 patches):
https://marc.info/?l=u-boot&m=178668446732727&w=2
 
  - Enable HS200/HS400 eMMC modes on Qualcomm v2, Aswin Murugan (3 patches):
https://lore.kernel.org/u-boot/20260902170559.3225833-1-aswin.murugan@oss.qualcomm.com/
 

Abhilash V (11):
  arm: qcom: add common QCLIB SPL extension helpers
  pinctrl: qcom: add Shikra SPL pinctrl option
  board: qualcomm: shikra: add SPL board support
  clk: qcom: add configurable FSM-voted PLL helper
  arm: dts: shikra: retain QUP SPL dependencies
  clk: qcom: configure Shikra GPLL6 for SDCC1
  clk: qcom: enable Shikra QUP wrapper clocks
  mmc: msm_sdhci: make tuning callbacks optional
  arm: qcom: enable MMU and cache setup for Shikra SPL
  board: qualcomm: shikra: prepare QUP firmware in SPL
  board: qualcomm: shikra: embed XBL-sec in SPL ELF

Aswin Murugan (2):
  arm: dts: shikra: retain SPL dependencies in IQS overlay
  clk: qcom: build only selected clock drivers in SPL

 arch/arm/dts/shikra-cqs-evk-u-boot.dtsi       |  44 ++
 arch/arm/dts/shikra-iqs-evk-u-boot.dtsi       |  42 ++
 arch/arm/mach-snapdragon/Kconfig              |  10 +
 arch/arm/mach-snapdragon/board_spl.c          |  12 +-
 arch/arm/mach-snapdragon/include/mach/qclib.h |  16 +-
 arch/arm/mach-snapdragon/mem_map.c            |  22 +-
 arch/arm/mach-snapdragon/qclib.c              |  77 ++-
 arch/arm/mach-snapdragon/qcom-priv.h          |   4 +
 board/qualcomm/shikra/Makefile                |   3 +
 board/qualcomm/shikra/config.mk               |  24 +
 board/qualcomm/shikra/shikra-spl-wrap-elf.lds |  40 ++
 board/qualcomm/shikra/spl-shikra.c            | 460 ++++++++++++++++++
 drivers/clk/qcom/Kconfig                      | 208 ++++++++
 drivers/clk/qcom/Makefile                     |  48 +-
 drivers/clk/qcom/clock-qcom.c                 |  48 ++
 drivers/clk/qcom/clock-qcom.h                 |  24 +
 drivers/clk/qcom/clock-shikra.c               |  73 ++-
 drivers/mmc/msm_sdhci.c                       |   4 +
 drivers/pinctrl/qcom/Kconfig                  |   8 +
 include/configs/shikra.h                      |  11 +
 20 files changed, 1126 insertions(+), 52 deletions(-)
 create mode 100644 board/qualcomm/shikra/Makefile
 create mode 100644 board/qualcomm/shikra/config.mk
 create mode 100644 board/qualcomm/shikra/shikra-spl-wrap-elf.lds
 create mode 100644 board/qualcomm/shikra/spl-shikra.c
 create mode 100644 include/configs/shikra.h

-- 
2.34.1

