Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FFA606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=J591T6Ok;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T3ji5WCq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YRwWVnqz
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE02560809;
	Wed, 21 Oct 2026 12:50:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sZDmfc5aTckV; Wed, 21 Oct 2026 12:50:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BA014607F6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792587016;
	b=MdpUNr18elyh/E9Gl/RFk7YPBS++ovznxOvHwSbsxkUQtO+OCsOjglRZRLVsWINh0mWE
	 so6SDsagEVYlNpqml2z0DeKyseANqcC8TN0rCKR/ZtVQv4uLyIBWmaGEG1M846KB6Mw9/
	 fxqRryt2mn0cbPrtox6yWQh2HCJOvMDPXumlvaEiivkJTygpwIwLUfIVFWjISpWcExBcX
	 DLSjUDG7T0cK8eu9+2XXL177AXV66KbLMSo6jH8NKRmcVl66yS3NkXM+Z17XYjQd2KyCt
	 t+o556qV+AKjCNjR+++CpXckrDB5TdbeVlxDXNEAGsFKAnpMu/uhqNEc6NnYcujoukw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792587016;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1ooPIME6QxgvgYcbqjZ+lmvPUiQqUDN4j0k51oVWDLM=;
	b=ObSPtC1Sg1vuvroSTn0DCO2/WDjI/XV/03jTTAnnfUzC/fTlgMqT4qxjqeG+8d/xV48A
	 qxw67zhZxD+gagmgvMDdL9nzN4VjZkRPr2h0W0AhRoFCQX3e8Zlm1RU8ytrf/Nse5booC
	 Ip1O15Xu+54qn617+xw+NX04D0W2c5utU4pKDnmuvrhirDGSugnA1k+soAh8IOx7uly1U
	 8yDmPSSF18UzOFqV3640XdfqMBrp/ImmCMjR4d0Duhi0mQh+VM8M1Gv40+2+UM+JEUTXT
	 CAzwcQzE+ufJ2Gw4hGkh8IYp4xQv+V7KrFiAA2WcYAfL9OdcH8ir66+olUpG/T/6NiA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792587016;
	bh=1ooPIME6QxgvgYcbqjZ+lmvPUiQqUDN4j0k51oVWDLM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=J591T6OkAyeC2j2yUez+1Da5CBjcLdJ7ZolaXKxC59y55kihSiIaOUqXVRpRNEQDT
	 Vq13VVSMxOXPBGnZiJm0v62MowFALhWZ3EDvJKlSrL4XxWfWsAzbLcb+aORBiUdh/i
	 ymFevEoH/oqfsjZjFnq28sk+usdqxgei4WhHRWb6UFw31ZfGNxbNmJcS3Wf6AgRLQV
	 9AyNgvaaC+0wdeucQuXjMqqJEnDEFqzIeA+T23w1dqP4pahniX7Empidq1/2ZeV/0l
	 L3p1DjhM4V5WGdgJrzSggI1ZNRaX7nRzqzl9Ta5yrjcAYi8gDtbcfhHeof5EvlnWHi
	 rvcDmLFfsjhaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA014607F6;
	Wed, 21 Oct 2026 12:50:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7913323A
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 76A44810DD
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D3NiyY_sQZd4 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 12:50:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 66953810C5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792587014;
 b=dVA65Anwj5NpYRQLFneTcFsHBzbU1IvBEY3De5lbl3N8dj9U3l/Yw3lh+Z+3tz4nkqt5
 qM3QIsGPoQNzd3QywhO3fNSsSF23MOcJMwPMs5ypFEQn8K/6jQ8K2Qh9fBNCEOFNwZSOy
 VezJTXk3mS12sFNrmW3rLpzwbHs+JRuWMvzxG09cgOvSCf+t3YUg+3gXppHtg7EGzknHX
 LhS4KIt22ce1rEJoilFhL7N3eK20zAynSmVeGFHHmeAxCq5fVSR5M1cZzrYb8yfBNIBkr
 pTVh/FOJYLX00PfkSjLzAHx5PJorUYoKV/B0arMIF3jRqt+7CkAQqu4Z8onKNpw85Wg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792587014;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-Id:
 X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=1ooPIME6QxgvgYcbqjZ+lmvPUiQqUDN4j0k51oVWDLM=;
 b=pwT742Fs4/qUZfwf+5s1ezMfoXMcO6e03gQMKsC5o0UDpfs2vTUuDn7S+lm9HW5NevnF
 1mC+8L3Am1qGSFKacawYY45uGY4EbYrthZsKi+rERijljsx8MOkclXV60f2PdnKPrwiNF
 A96CIQUHoP2hz3wTAfmfz6Xr0q7t77h/s0GEU2tHBOCrskj16leWmbHMcVclZjVLAJlPI
 GE3U+dazamfPHDB3ieVWVujlhotZywXADVyTWLTzBwv+HcYXo9DvltbyqH3Wx2NU8pHeW
 oR2gnlRUcsNnPlRRmPSlOGkvjN9Hdhi4xo/kI05ePwya7U2v4UXaKs5LT+fyl3mCnTQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=T3ji5WCq; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=YRwWVnqz; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=gurumoorthy.santhakumar@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=T3ji5WCq; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=YRwWVnqz
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 66953810C5
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:12 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LBgQG5545150
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=1ooPIME6QxgvgYcbqjZ+lmvPUiQqUDN4j0k
 51oVWDLM=; b=T3ji5WCq3XRsazDTxHQ7qQJzxsJmuynkiN/5/o9P1Uzh2DuZzNg
 xQz6ZKUoNKq1lr72072mnaLvy22MVcsEZUXymvFMHMvxwCh+bDHa00LjVpQPyy0F
 rLOf3JXo5HpGfIRr3RnXQKPei6PEFrkFvK9O/fPV6EKQR/cj1/M6OnQ6HHdcj87o
 hUnO4IpPbORjcy1rjENV3fK61ojMXtAaGIWtXq3CbAerK956vULTFv0JCDO1MsBg
 XDINZRRPYiB2hAAPDr4qn77K/UQhRaw+g4j75j9AQxA+lCJ6trnA/vA61oF0V7J2
 9DCPU+1nqwpneR+9XKQpkUNfHrj0GVAyXOw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hetj48rde-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:12 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3425098ae4bso2825152eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 05:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792587011; x=1793191811;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1ooPIME6QxgvgYcbqjZ+lmvPUiQqUDN4j0k51oVWDLM=;
 b=YRwWVnqzOlFrxLIh3519MewQDjhbciTwgW4Ffh9CoP9Hna+DVN5ch36mFiYjsa0HT3
 lbnTg+bJOF5+Di5c58UVW0TJFELWgKpAnaz7QDA632hGZYyL2UBIZmZqTApn9gFtmd12
 QCpD3OUIp2OnUlTiVl8botH5mKPbd2A3akUcWzIKfSDgHoCej2OcGRJy/ralXNe2Skem
 bPVLPM2x0P/MfPBGpdr8eo618j7khHmGWGNjvEWSpF0W+KDChNbfTKw7mPGlkU+7PM2Y
 tAurpnh7yNfy/MuhBHKshR7utKQOl8myQo39iH9ztf8uDKe66UXwSck+J6F12x+AgGHl
 hprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792587011; x=1793191811;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1ooPIME6QxgvgYcbqjZ+lmvPUiQqUDN4j0k51oVWDLM=;
 b=Zcp0fFlX9Ktl0gYQQlh8KcnbP4V7g7xt8pXSipyPDd1Yp+7ZPXV7q2VsBOg2j5nux8
 nG2cKUg14Ah/7EFBIu7AGl1rEUlWym95AaBAt+i/KFgQp6vfuOnTyvgCKkiyxijVEin2
 t4gnXvxs+sKW/agfWYkdSSchd49unACTpqTrar9xnGYJS4sgw/oNVAJp4H+h+WMgaH5j
 er0h3w6txOwTMxzEFL+btcBzrNLy5wAaXDG2jYDfO7+SlS/La9U1HrvRWWeznesGxxr5
 lM0NUwYnKP1ASr7knmZUc9WqVG84/mUc3VsORKg9z3+5/xpuaEdoC2gYim9B+Y6fQXXq
 RQjA==
X-Gm-Message-State: AFq9FYKoGgkTMvAeaQt+FlCyp5Pv0u99RIHfzOFvaLwpMU+XjziyjZdO
 qn8nPEXRdD8gUgjVli/ERhFTE02XtMGxZRE0sAPdAQnXSjbBhdDo4elfbb0J4ftUz6Zp3ECWR+2
 J+Ju8lf8nnNREdSQgNq0yB/qQw9SVD9IR0CQ6syG9z0uLYMFDqB9VCZkuexKgD8O/QKclGejUkl
 25dqY=
X-Gm-Gg: AYBFou1Bvso4XwvMd5D3kBKcHqnd+05kQB01XH0iJp/E1jfibrpFNziBwLj4JLZpCyf
 VdsX+H3/+kkxFWG//0ygeS6mjRQycb2oKV+LHMhhSlZ5/OZ9/imxIe6cyLyWlSTheR5LqukpCIQ
 mBkzqWoQarpkjbTywqBD/OWtzMh0TI20R724M3SRRLkTly6fF4aFAFHIUdb1slbZWFkNTtShjn8
 c2I8aOV+opYPBnu/N1qf84v/5lXT/lrnnAVyJYsZFjwOh7CV5mHdW4VTJnSsbbtGhxuz7Co1NxY
 gmz4xaY3uYQRuXt8UwenU6tLkHiGGZjlkAyDy86GorUOL7UzJZ5YzEGqKo+CuJhdMSI3DJXZUkn
 mnJ7ow+rR8VmWRbzqnq8YVsk/iyaJrW/5WMCMFn/n4Pytj41V+688IJAlml9uJtQ4CS3jP+PSOn
 RQWn1ytTmO9411q+JNZ50ceNbN7fyRW+NO3iA=
X-Received: by 2002:a05:701b:220a:b0:185:6c8c:d860 with SMTP id
 a92af1059eb24-190a52e16acmr2521321c88.5.1792587011303; 
 Wed, 21 Oct 2026 05:50:11 -0700 (PDT)
X-Received: by 2002:a05:701b:220a:b0:185:6c8c:d860 with SMTP id
 a92af1059eb24-190a52e16acmr2521294c88.5.1792587010648; 
 Wed, 21 Oct 2026 05:50:10 -0700 (PDT)
Received: from hu-gsanthak-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903aff3481sm6467815c88.10.2026.10.21.05.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 05:50:10 -0700 (PDT)
From: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: u-boot-qcom@groups.io, trini@konsulko.com, ilias.apalodimas@linaro.org,
 peng.fan@nxp.com, jh80.chung@samsung.com, sjg@chromium.org,
 Michael.Srba@seznam.cz, Varadarajan.Narayanan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
Subject: [PATCH v2 0/7] i2c: qcom: Add GENI I2C support for IPQ5424
Date: Wed, 21 Oct 2026 18:19:56 +0530
Message-Id: <20261021125003.2948090-1-gurumoorthy.santhakumar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: AQ7CgBB9MpEbctqsR0dGXMf10AZ_XUyP
X-Proofpoint-GUID: AQ7CgBB9MpEbctqsR0dGXMf10AZ_XUyP
X-Authority-Analysis: v=2.4 cv=N768hG9B c=1 sm=1 tr=0 ts=6ad8b504 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Ca2OmdCv_43TQ0Xh73gA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1MSBTYWx0ZWRfXw04IWeO1RN3l
 TSCvtgLJm8KywksWlXoncgmtOpSTYuwYDFkLviZ+9Yx9AwWm3mw9azM8/ZzOIIcChmAiOmFUVf9
 7HCjJc8JBAdxPgONqIHwJBGluR65WmxMcpzWqzv/wPnS163HNAqe6C0CLnrEqICm30FPgNhH/a6
 Ywz1EuuuLua51MM0tshkQ6CVzgCaxQgM7HM9jtqb6rC4rW+BmF0W89pN9Wk205RHk2cgZcwOSVd
 QDCx/MZCxOIZTp/nap46CwyWrbmBsW2Ez85PF6Dt7C2q5Xq9FitHhsnA2CRJZjbMptevNJnPtqh
 BOq/novZtJ9DYgxbFQino+eZzBAcLBJ5LydIY0wadNybH5WYrMjOJNujSNOa6A9rTv89AXmB54y
 y2bQIB25iC0Qj4TshDXV2QqzxhzL6e8FiDpL3aeTMKSM/2f0QLS27f+sOs4k/sE93Fg365AV34S
 +RipE+GWpXkYhQBp7dQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1MSBTYWx0ZWRfX0SPj2YG1qu8X
 sJ1Y/N7AKP7upPRMbFciu04p8BYVRPV/Q2rmMNAENJ8xe9vPnCBTAdWruijGQnunBJ4zh6Yzxr8
 VrUqps+FjrNNatR3adbGjCscZVbhX7A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210051
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add GENI I2C support for the IPQ5424 RDP466 platform.

Changes in v2:
- Align the 19.2MHz timing values with Linux.
- Add effective 32MHz clock handling.
- Use the clock provider get_rate() result to select timing values instead
  of the flag-based approach used in v1.
- Add chip probing as a separate patch.

The GENI minicore support patch is a prerequisite for this series.

Link to v1:
https://lore.kernel.org/u-boot/20261007174151.2590649-1-gurumoorthy.santhakumar@oss.qualcomm.com/

Gurumoorthy Santhakumar (7):
  clk: qcom: Add RCG post-divider rate helper
  clk: qcom: ipq5424: Add GENI I2C clocks
  i2c: geni: Fix 19.2MHz timing values
  i2c: geni: Add 32MHz clock support
  i2c: geni: Add chip probing support
  arm: dts: ipq5424-rdp466: Add GENI I2C nodes
  configs: ipq5424: Enable GENI I2C support

 arch/arm/dts/ipq5424-rdp466-u-boot.dtsi | 63 +++++++++++++++++++++
 configs/qcom_ipq5424_mmc_defconfig      |  6 +-
 drivers/clk/qcom/clock-ipq5424.c        | 73 +++++++++++++++++++++++++
 drivers/clk/qcom/clock-qcom.c           | 34 ++++++++++++
 drivers/clk/qcom/clock-qcom.h           |  4 ++
 drivers/i2c/geni_i2c.c                  | 67 ++++++++++++++++++++---
 6 files changed, 239 insertions(+), 8 deletions(-)

-- 
2.34.1

