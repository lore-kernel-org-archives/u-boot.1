Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394A7606A337
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=1Ek+AXSa;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PMWVNm7z;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RylKHwFF
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0478A81132;
	Tue, 20 Oct 2026 16:47:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pPQOLZ78U4Vz; Tue, 20 Oct 2026 16:47:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CA43781103
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792514845;
	b=BrDQ2Mtx4tSf7DgQxB864MSOmX0lPsQfbXbE9ALR2RkBYGj3uzJ98X/eriZCg0/aXGbl
	 e/c4bL7BZiniF6pykIj42dT1LWY9Q0V+jkmbe1NxlrGWZNvrVjqj7YcSTkXW8IDvSoHbg
	 VwMvq+JaazGFyoYDxTUbzQFY+h0G1ElE7DhMUeatVqiVzkhcwQXIqbAxfC0jZEUW+nRKs
	 WaxR3jWdaExtOcbivuZ5tUVDOvhhSbAJQWH1PI7Qqnh9SzQ1hW2ncyYtbgXfzg+u6CROM
	 V0qF5l3KgAnszx99yrDEKqAqr6tEvLqGQ5qP4Rj2gAlSXpurary0+FhnYp4Veb9M6Zg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792514845;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DLssdStojDBh3CnDolHi0pz9M5fNdffRtxFw4pkmXcg=;
	b=qRAqYTMfC+eqV540nB9kmkcuws6Dinp2lNN7qoqIuKCJ98ITpgfn4pr5ngBN5TOW09SK
	 dJqUuI/L6jpgF04olEzrjfWoHR7wBV6ZlzjUK5gtXchQtSly478lXAmH4KTOOfVuFi3SZ
	 j8b7guCNcaoKYlyXts7V6xCzhrEyAoWaIXFuJL3mx54WELAEv8LcuqR61O8M3PYm+VSFr
	 W2dJknyOe+sBiM/pDMl1FzbPF1u/GURpMlLRfwaN9BekfwPq5gL+iTiqbF9NDvQSo3gmy
	 dnasM4IFV9/JmmTSbHvEEM8GeGIV460OUb0Ta1l9p9WDI3rnR3dul4AZJzG8WAHi/MQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792514844;
	bh=DLssdStojDBh3CnDolHi0pz9M5fNdffRtxFw4pkmXcg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1Ek+AXSawFp1x2ydP+9QB2HdlVea04ZSRtEEoj2ew63wz1OaQRLAaJJIqPcK/hMvM
	 FsMeuQvF8XSbmOjwtf0kVTGL6/R8ym+qqgBe2Mdl/hl/88+G+Dv6UW3DkfaL23p5Uk
	 nzG9LJVSCSYJOCEwDGQJ4HlW4oyoeIq+wVU2YKri0lU64EU70udsTE6Oyk3ua7P4DJ
	 ps0dWJfIiYp5dDGe4CQQ5akYR2yeMspMqMlqhfdcW3rKo58+rKdep7KsRRhayTdKJ4
	 1Tg2Cz5B7ADpF5K2Qxcx+H/+7pzElZXBv7JC8yT+5Z5itbLWzcq2/dF0zWInlKl1kV
	 ynORRX4Mu6V1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA43781103;
	Tue, 20 Oct 2026 16:47:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 65FEF1E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:47:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 57749408DF
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:47:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lp2FW74amDxU for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:47:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 46BAE408B3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792514842;
 b=AuRGcOi3zqg9A0CWxfMRPGHzRAvypR1WWbR6xtyUiwhdejmFJEYqiraBn+gw2PjEuYIW
 dYbacUr7POZ65+SBTggRavnATw2BesMjJ+NXFYPbYnG1g1bXMCxSsw8ex/gOXp23We51d
 gPxtQ/gZQHeE1sivmw6h/zEi0qWs57YXFCEt0yHfrhjc1F4qWggAPeB6l5AImqW1CzuaJ
 09EHuul+h1tWLTxHJbjN0+WT8EBjDiz8166VqxEwcHWvMjp/WrlTikgH4tFE9qZ36welp
 9KSxC38IXx/pgnuShwPHCDe6Fztc4p5t5fO+vKZXKJ6W1ApSOSI8EIMdJcZcKAboqkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792514842;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=DLssdStojDBh3CnDolHi0pz9M5fNdffRtxFw4pkmXcg=;
 b=tRA+qS26kvoaM1fpx0kxFzKyf10zLIxWT7aHTAF6FGLqMrPtrGpvHiZz93BUb5YQ6PlS
 NSlKZtJuNzvqYZwszJSDGpHh2ObDwXY3nowqUhOWgcR2jBeiyag/xjc95anFq5mB1PBxA
 osxVfdi2SYA/Jx1z2EoWXLI9ml2szQpJGM7M8v8+xdC0fZfCndZiHJn2JBs4RGcM/f9Vh
 nMQ2mlfWkd34o1cRQVkmJQl7B06ui6eGgjjMpggBQhtNwYnvgDubRah82vJpzIm/DmCmc
 kIiAes5b957bzLh8e8BC1vMnJorLD4VdRXVcUXsOegK/a55WRVenNv/wSzpLyelNV1w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=PMWVNm7z; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RylKHwFF; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=PMWVNm7z; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RylKHwFF
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 46BAE408B3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:47:21 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KD9qmk1781311
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DLssdStojDBh3CnDolHi0pz9M5fNdffRtxFw4pkmXcg=; b=PMWVNm7zi+koBXlc
 gOSj+QA5cT/7eCvMlkgD6Vib/k0Fdk1TaPprKk485wrJeuF1UeGVcmBTo3u1MpI3
 gCC51Yp1i2con5cDEzudvO+9xAG84cR24W5w48U9xo3E69eWr4tAVi6Nt7An3jW5
 qtj8Y3+ZMsq1jxTKekhGPM0DBj3U5YTpan0MFtAQynbXAE4+/ETJ1kv3xXX6ofDk
 Zw72Ln5LXEyfuXPLEVobf69KgZfi7CEIniyK0JT+oHhzTcCaW1NTVBuyM0PovTh5
 bwnvFnOvLyrR4RIjVMoGITI8SA5ayjZwi38SBMJiovXBO/Kl2mj75ywYFCTTo+Gy
 nhAd9g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4he7h29737-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:47:21 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3580c07911eso9532012eec.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792514840; x=1793119640;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DLssdStojDBh3CnDolHi0pz9M5fNdffRtxFw4pkmXcg=;
 b=RylKHwFFG4Fscv2W7oyfJ8+YMcdUyAVTnndCNp5NErpZBgQ0BFd8Eu/3jWDcthPDmb
 gEdZtzsl33CSzZwcb+rcINhA9MpUNjyrGcZcVW9uhntTs5uHQscw1vQOyYccYZldFlWs
 1qy84WOQJXWfr4np/kVfUtGoYnvG6P0TqEiCKoCiL2Of+P+isdCrlmm6eK+ahsHy9Wux
 h2g9CD1ICEHz8hzT5cRly9LLv2pu0t6UzLuK6WyTzb/b7tNoA+pTc5YUFgJje8qHYLLg
 XUPWQWEDpd2IiXw2n7Yl4lY2tL/kTNKa9uo8dQ2nVYy4e7bH3XAYUuKCcnTqV/AfEaXM
 qfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792514840; x=1793119640;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DLssdStojDBh3CnDolHi0pz9M5fNdffRtxFw4pkmXcg=;
 b=ldyTdleIKdRbX/FuoJmM+0FGA07UVZfjkob1WHlejccmo9k+nWFO6RS5jkBq/uM5PR
 +5+IR8tqUPQVf9glzgIl1WhOdivYFVTaTaJdxmC2RjprrjJ4aFOI9uesH9tFAGyGypCW
 sX4CpsdiJQn34x/23AHU5T6XwK65I3LhUMx0vZxtRv+2V4Qz/1YQ/VrvH2UYVygFb92f
 AfN2VjJPFW/QVHFuAg5S3fb/Xiz7//GO9LzCvj5lntwUw57FkdokFFD7vaqmKJCknDoQ
 36ajfVPjLpZTiz709Qh6WysNr1N/ZOOQPtVG0Qc1WfADdbz92vB+LkF9w+yW/GpMnT9q
 SSUw==
X-Gm-Message-State: AFq9FYI+hsjHununkW/1waqsSJQmaVGumT3yakF5AZ8Ajcpb91s1UiOS
 VH4/SGlbgG9sjV3YRsDPpgZwtKao2L85MAeeI1hkjwDWofc92YFe3F9oBIwNA2SzPsZVjRmT4ct
 LoVBNxAusAhHqBJW496jluWdKsCLmOUdIVEK2aTMfU2bz9I1FmfJg0gmAlYxemKCHuXbYod4=
X-Gm-Gg: AYBFou2L+1hZgJPuMCVgTF71N6idcQZ4SZzLbt1JXaPy+8BS8CArVrTNV9AEK+G4Lou
 09aUvHbet4uYXnCbyaIDvnY2TGyTvq/3TGwon8S0vkodWDWFgaEO5Vp3PY8U1+67SvCDCW/T573
 t4na26JKjar0Iv9o+HY1UEp/BtZZSxygUAhhYnkNJwLl0heG2KFe2uWbt4TD1G6RUbnRjmIa9Qr
 4Ela4ZOmKJaXoSB7kmlEfMaN2Zc5u9LTdnu5V9/3wzFJ9L9tOLgWBc1gU0k3nWUV8Wu3Tg3biQh
 XCu23mzRP4m3jNazoLupgBHV1IpYay7MUcrBqv9rgzMjM++2NalrnKD8EBGNdaRcYANm1kzWBTF
 bUGV72HSULWFdNFIpo7o9byrC8CAYXkjLAHOsUCdHbCJqJEn1O2tnNQn48L+PVWiutf//NOuok4
 Amz/SXJSN8TQ4EsAu4X71wFHDOjaA=
X-Received: by 2002:a05:7301:1748:b0:350:2a5c:56c with SMTP id
 5a478bee46e88-361a1862b4dmr14769536eec.20.1792514839981; 
 Tue, 20 Oct 2026 09:47:19 -0700 (PDT)
X-Received: by 2002:a05:7301:1748:b0:350:2a5c:56c with SMTP id
 5a478bee46e88-361a1862b4dmr14769501eec.20.1792514839351; 
 Tue, 20 Oct 2026 09:47:19 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36632d8b273sm6318507eec.15.2026.10.20.09.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:47:18 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 22:16:24 +0530
Subject: [PATCH v2 5/8] arm64: dts: qcom: add psci reboot-mode edl node
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-b4-reset-edl-rebootmode-v2-5-f690da515804@oss.qualcomm.com>
References: <20261020-b4-reset-edl-rebootmode-v2-0-f690da515804@oss.qualcomm.com>
In-Reply-To: <20261020-b4-reset-edl-rebootmode-v2-0-f690da515804@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Biswapriyo Nath <nathbappai@gmail.com>, Simon Glass <sjg@chromium.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Vincent Jardin <vjardin@free.fr>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792514792; l=4320;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=ZuIxyfW9qEmRes19amQlkN924KFT9otfX14H4YsGoxM=;
 b=2CSAKici19T5skaJxTqdbUwSXvtFEl4l+zyoY0b8N4fYSnDsm0a42fVQW2hA2WE0y+RayydbT
 aiHXQg7JMXYCAHDJJbp+Wj8rX3yrMmxAmDvQ1j1DszcrWtnFzAzSJ7/
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: rwV_vjvJ2vZPL1CLEq9P_-i4kBtKbay7
X-Proofpoint-ORIG-GUID: rwV_vjvJ2vZPL1CLEq9P_-i4kBtKbay7
X-Authority-Analysis: v=2.4 cv=EuJHPicA c=1 sm=1 tr=0 ts=6ad79b19 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gu6fZOg2AAAA:8 a=cm27Pg_UAAAA:8
 a=EKzW3R7u2yVdMkTaO3kA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=2RSlZUUhi9gRBrsHwhhZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2NiBTYWx0ZWRfXyZFEyStIimuA
 Bo13YsHO//4sJkkSFC1asLXQHKQ4V6iu0rLAyokcCGCuIdHcDxPKrtLx09ViYZ1knJ3eIM+FCbf
 PcNYJ3vPTxcykeTA4XOZxuyJbacNWi4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2NiBTYWx0ZWRfXw017MO8wEJVK
 /7CHToh7ePvH1uwCGC4QzOmZtDXXvC3fmfN8vbuuveuzgIIi631+syIJn7GTLKl7TYQHeu2QwAJ
 UKMdUewOd303sn6zH1UkFlkWRqfkz6inhR204qHafcz4XtFCGJTcHdrDsjwlSuQ4/Vlh3pCYfWR
 GRO2JYVfnRvhkgM+P8Crpeq9KL78PRbRWzsPsXMrOAwbSKtzx/e9a8dHVUTKvF6JI77sbslNfvN
 Am7ZUZMMeDKB0mbxUZFpLSaZdFx2vr8zUceCeEXDBmutKpmmVozthNq6IE2bHeOgDzfxBxSmEB6
 VYPe2JFn7XvAQWMuXp8QmBrZs2TmYn72ZTdmzz/fkh7gnOR2dW16UwjSC+9qsy5kdKU189bi810
 p2iq6QQl0MKptow6bKfdN8nZv4r3DckYDVf5+JJ+O/Shcz47J39QWKyh7kOYv02mTVI7Zndof4+
 MkselczD3xe0SKzdABw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200066
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a "reboot-mode" subnode under the psci node in the U-Boot device
tree overlays of the lemans-evk, qcs6490-rb3gen2, monaco-evk, talos-evk,
shikra-cqs-evk and shikra-iqs-evk boards, declaring "mode-edl" so that
"reset -m edl" enters Qualcomm EDL/download mode via a PSCI
SYSTEM_RESET2 vendor reset. The magic value <0x80000000 0x00000001> is
reset_type = 0x80000000 (vendor bit set) with a cookie of 1.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Refer to the new "reset -m edl" syntax
- Also add the node for monaco-evk, talos-evk and shikra-{cqs,iqs}-evk

Depends on the following series, which add or change the board files
touched here:
- monaco-evk:
  https://lore.kernel.org/u-boot/20260812-b4-monaco-v2-7-865d288c0be6@oss.qualcomm.com/
- talos-evk:
  https://lore.kernel.org/u-boot/20261020-qcom615-talos-evk-dtb-v1-1-ae2d2b48b0c7@oss.qualcomm.com/
- shikra:
  https://marc.info/?l=u-boot&m=178668446732727&w=2
---
 arch/arm/dts/lemans-evk-u-boot.dtsi      |  7 +++++++
 arch/arm/dts/monaco-evk-u-boot.dtsi      |  7 +++++++
 arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi |  7 +++++++
 arch/arm/dts/shikra-cqs-evk-u-boot.dtsi  |  7 +++++++
 arch/arm/dts/shikra-iqs-evk-u-boot.dtsi  |  7 +++++++
 arch/arm/dts/talos-evk-u-boot.dtsi       | 11 +++++++++++
 6 files changed, 46 insertions(+)

diff --git a/arch/arm/dts/lemans-evk-u-boot.dtsi b/arch/arm/dts/lemans-evk-u-boot.dtsi
index cdd3d32f61a..12616f22987 100644
--- a/arch/arm/dts/lemans-evk-u-boot.dtsi
+++ b/arch/arm/dts/lemans-evk-u-boot.dtsi
@@ -17,3 +17,10 @@
 		      <0x0 0xd3500000 0x0 0x2cb00000>;
 	};
 };
+
+/* Enter Qualcomm EDL/download mode via "reset -m edl". */
+&{/psci} {
+	reboot-mode {
+		mode-edl = <0x80000000 0x00000001>;
+	};
+};
diff --git a/arch/arm/dts/monaco-evk-u-boot.dtsi b/arch/arm/dts/monaco-evk-u-boot.dtsi
index 8e9102eae4d..74f2aed15b0 100644
--- a/arch/arm/dts/monaco-evk-u-boot.dtsi
+++ b/arch/arm/dts/monaco-evk-u-boot.dtsi
@@ -3,6 +3,13 @@
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
+/* Enter Qualcomm EDL/download mode via "reset -m edl". */
+&{/psci} {
+	reboot-mode {
+		mode-edl = <0x80000000 0x00000001>;
+	};
+};
+
 / {
 	reboot-mode {
 		compatible = "nvmem-reboot-mode";
diff --git a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
index c3ec4a317f7..a850cdeb2ee 100644
--- a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
+++ b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
@@ -17,6 +17,13 @@
 	};
 };
 
+/* Enter Qualcomm EDL/download mode via "reset -m edl". */
+&{/psci} {
+	reboot-mode {
+		mode-edl = <0x80000000 0x00000001>;
+	};
+};
+
 // RAM Entry 0 : Base 0x0080000000  Size 0x003A800000
 // RAM Entry 1 : Base 0x00C0000000  Size 0x0001800000
 // RAM Entry 2 : Base 0x00C3400000  Size 0x003CC00000
diff --git a/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi b/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
index e807b91ef1f..2f3ccda69f9 100644
--- a/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
+++ b/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
@@ -20,3 +20,10 @@
 &usb_qmpphy {
 	status = "okay";
 };
+
+/* Enter Qualcomm EDL/download mode via "reset -m edl". */
+&{/psci} {
+	reboot-mode {
+		mode-edl = <0x80000000 0x00000001>;
+	};
+};
diff --git a/arch/arm/dts/shikra-iqs-evk-u-boot.dtsi b/arch/arm/dts/shikra-iqs-evk-u-boot.dtsi
index e807b91ef1f..2f3ccda69f9 100644
--- a/arch/arm/dts/shikra-iqs-evk-u-boot.dtsi
+++ b/arch/arm/dts/shikra-iqs-evk-u-boot.dtsi
@@ -20,3 +20,10 @@
 &usb_qmpphy {
 	status = "okay";
 };
+
+/* Enter Qualcomm EDL/download mode via "reset -m edl". */
+&{/psci} {
+	reboot-mode {
+		mode-edl = <0x80000000 0x00000001>;
+	};
+};
diff --git a/arch/arm/dts/talos-evk-u-boot.dtsi b/arch/arm/dts/talos-evk-u-boot.dtsi
new file mode 100644
index 00000000000..fe53845a84c
--- /dev/null
+++ b/arch/arm/dts/talos-evk-u-boot.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+/* Enter Qualcomm EDL/download mode via "reset -m edl". */
+&{/psci} {
+	reboot-mode {
+		mode-edl = <0x80000000 0x00000001>;
+	};
+};

-- 
2.34.1

