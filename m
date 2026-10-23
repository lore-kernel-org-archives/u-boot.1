Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24574606A31B
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aqWFR04U;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DbvsOqW7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UwOtqMMB
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E919B6068A;
	Fri, 23 Oct 2026 09:47:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H7n8itR0m5iS; Fri, 23 Oct 2026 09:47:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4A31860648
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792748857;
	b=mvcEKRfTxACE7B5eV3BR5f/GrbSHHWNH1jjCNT0o7MPkZpFbW8faYqAysPw7eMweJJGx
	 arcjtFwKQgaIFP/ttiIk2i0JevIsWeePmmOAlXZz0oa6CwnjVPIkdfvu4GMLf50uiayXm
	 EujBX/YxnBTVVbkGkGvSvlQMhDdd9PakhDE6983qSwy9Dk/7xIR6LKNEawlLt9M7eo7JT
	 emRFdmhkCZxFsOx0Wd57CvUoKsgrF+xFLEoDb1cT3wk2F4ayJ1CkouRA/fYe/a+pOj56s
	 XJTefMt0mra5zTHXxQiOBm8EWHA7mydUuS4rsbr+AbF1s+4Bbh3hVb42O1bQfBdUqZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792748857;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hOpkylqKRRTM9dAo6GFIBX4g7jRQXdYvGHbfSYMgCxE=;
	b=j/Ts803sKPXIBUgy1ETrDneCP3hzAExjRQZWTLUjaFlg3FjLTHHe0uj9oxgqBmyjxmkj
	 j+s6YybHPKpzvsFHwSQAdIGWhDB0x7KI1TkscTNoOkiF6Xt0UzPo8gARnQbXrcOXZi5Kw
	 EP5VVfMo5bvm3hlVaK0XNxMqL2WSiNBl12xt9kLnBQpyucjK8Zx6fGJyWD+I4lizpui52
	 GctCSA1Ahra7Owm9/rYf1FdPb3cMtoF8rnMYKEsxJKwYE1rOlMmopM2H1fzfwSUVuFB1o
	 YpF9+wDSJY91kWkjvcpDVU5YFwaCUXWZ6S/w+YEmbcBIiJY/gzpOLM0TguEWcuOFwTg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DbvsOqW7;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UwOtqMMB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792748857;
	bh=hOpkylqKRRTM9dAo6GFIBX4g7jRQXdYvGHbfSYMgCxE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aqWFR04UQTLCV7Okld70SIe6q+ONOUo0Gdi5FSfafpmz0ECyiqfGMthqlj6Z7Uy7O
	 AwaBdxUwimlU0d8ZSJYvL+T7PiyRlY+T4M4O9wjtzhS/94KkxMCz0hTbe8Sbg0vrWT
	 S4u75kbNVckqryNMS+EX8hFXQQdFknt38QO3aAvTeUm93H/CuUuKq+dVNFyVK4EyPU
	 n0Nbd8ljyQqK2lrHlB1aKr5pge9ZNGDfTUYDhM4Z5HdbQ2NybgFx4i9urMFtQs0J3F
	 zDxlLhB++YFvKda/6qFk8BVDnqhd+klsYGPvJHWe0pBSxwHKtcqK1R74svwJTEJCaT
	 QGdhY1g3GKuwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A31860648;
	Fri, 23 Oct 2026 09:47:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C9C36371
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:47:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B8E8560648
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:47:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VaM9A5kvqTg6 for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 09:47:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 32E296062A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792748855;
 b=emQij/BBNasuSz5bmSJ6XqNlW/4jiTpyOBm8OqUxJaTzIlCN5j7+gO2G7wQLIVuN6boE
 CQbWwCMTEOdirpV9TcpAuF3/IKGEXQB7VGuxczl/DrV8rcf0D6R6Wq73KgDjqACweW1M8
 ww3Qv3mFBQ9EBfo876tqCKysNeB3jQajn/I/Qc/UKXVJlmSxrNu7ebEMAhZ5DW6uFJpXS
 r28lrr7auzmve6FIcVo6IKbyLAoyV/TAnco4Sd1eGmemh90Vo73kswCcc5n8XVIM5zBb0
 AJt17MAniFnK6UDJuB2mDMC2H8jpf7gDATBX9g8uEy86dHoFo3khs4744XJT4Ja7zyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792748855;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=hOpkylqKRRTM9dAo6GFIBX4g7jRQXdYvGHbfSYMgCxE=;
 b=QdDkrgU6MGxqIACOcyQasdgPFUsOilj6AGzvVqOTFCtKjezdtd5jw8X7uJPLjcBwCt/z
 m5zlIj7mTG+Dhuf1bLB07qRSJYUGf7Cc0jHO9cPxX6dlhINBkMhvKKLfxsGJloNN7QthF
 JXv/Zz6T4WBF3qV27Ks1HN3wJhaHisa8pz1J5oLW+HcUuo29fkVVXRXKhkkAoLttl9sad
 oS1i28usxrgreDf6Rmlu9o4nS/voT9FN8BDt0iFRPp9u0V7m9k2F1/5GEjFF7ljjQqHeh
 GsAjVgJwzjj8gd2784cDgCxC9zEgvTkQ/ITnZWgiUNBD52++aDq15aLOfmMYXce35bg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=DbvsOqW7; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UwOtqMMB; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=DbvsOqW7; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UwOtqMMB
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 32E296062A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:47:34 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N7FShV587751
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hOpkylqKRRTM9dAo6GFIBX4g7jRQXdYvGHbfSYMgCxE=; b=DbvsOqW7Hde+cgSk
 vezT0PFsubBxOQ3XrTuOSVGxePWSvclL7pE6Xs9N0+6n8W4sDUNFPHTxGYTxa6Zv
 HxH+qA2m5y0JSvpiLQvVSDgotNddIcT65dRA78gu17Zmk/3QbVg9Z/dkwjFBpBsn
 Gt/fz3yPUmEy6SlpOmfOMUEq5g/1aqPR1wId+oK0Vdr0GX39nWIJuMb8YbwKfpL6
 wdg/8fONNk5O3NAXHOxTQ3X6DQteW7mS06qEexR28g4/V9gSDruE0zBK6DQ/yo3N
 tFhiDPHaAdLVFeBAcfeC6sZ5+1EElS78ikvXD8N3DgTUttVwvwD0BD6DHrqAGD+k
 bvL4jw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsmath9n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:47:34 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3580c07911eso2125852eec.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 02:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792748853; x=1793353653;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hOpkylqKRRTM9dAo6GFIBX4g7jRQXdYvGHbfSYMgCxE=;
 b=UwOtqMMBweq2BnNKqwm74wvv/oWneB+5VIIka1bdAJwQG0L+WWzq6Y0pWnl25vAxjC
 1lP2uXIkF6W22KH3DQkb2zWB/W6vphJ+wf4JiHCI76QCNoD54mAPELbLNx2UhQv+aH/c
 spMvpLVsFDwz+yCwBar4iHOb+FzVzm9MBwoTBPnjuEE0gp5kjrEu7tLH5aBXREELDlfn
 rWo0bbFsCysy0P6i87c6gCOqjNb2C0lHryZQQmOcoS1Ab0faofoLLzOuagDaLvCA+TQr
 DfRVnH8JNLHDENkQTe1p9z7l6Ly2Kc6cMjZyaZ+B+OuMbXlSb5Ut9V/vKRpCnSB+tZi1
 5R4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792748853; x=1793353653;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hOpkylqKRRTM9dAo6GFIBX4g7jRQXdYvGHbfSYMgCxE=;
 b=YnkWPdBayRyV7lLy8eL39ruJrbe2DFdsTpLznNbgO3oxwVIDMNxWLoybQ+B8JqKRyr
 NWZy8pHAmhLSYUnWkkfmbqA7C+HgFUKYBUGwZlOEyYGAopWn6WFTUvumdYSmj1xio4sH
 t0HDHcoxamMAZdg6u/udItoy9wSLfeUncKs3qk9yEpzKspuKi29vL8tLxzFqdS1OkmlL
 rgMAPI1EwVIsvRDD/2ht9MPfBL6kPKzDRMmJJWD7XBwptul1Lze6vEC7G4MeIuQf4qP4
 CftWBUNd8nB9xxWwgJDUteJgElmQETkAf+Nfhs+O3V26xb5QucPfkp38v8b0V/XOvNn1
 oJZw==
X-Gm-Message-State: AFq9FYL4Dpdi3RcrtFvtSfoMHpoy6hKQ7lqjMPzF1FqsHSqBupntU5Po
 JZbzahmwmREpCbJd6N/GN7o1XoO0nBHiJmsOmdwQIdRLqpvVWKumGFmwDVJxstFIGvlhuR/sk5T
 0TzLZyVc3jbIaJxnWx0i3QWiztpez8uP1GVMv8D24UyD81KRkR18nuJ5h27O+S2syPuRHgO8=
X-Gm-Gg: AYBFou1xPtSM5QtZJwJiN366iBeu+t7gi4t0aB8TWT6xNUcBs2VAtscKQeyWqrt5Bnw
 HLZePmlmzuiZxs5c0tgU41P7ihheJJjri9Rjwpo5JTkyEIBN2jRWvcdATJUQy/+S5LCls0z1LT8
 kGHoYgZEInOdIZFehamHRuqrMg7wf6PpJY5gwRYqPzKywzCteBoVQEWE1ApxN0ycUlPV+ukwYZr
 LLEn0KuCHlIrFJgpL+DOs25DEtCl8Rm298XZ8v5m0GcVIPNCw/3kQjc6ruWOZ4S9Zw13k3I+uSt
 iEG30XaI2FScmKD0ortg8FiqaiKp5sIEM3umOcPe/AAY3pDsEV/H+1i2maYKCzH1LJ7lzKUvGgb
 HhMMcJDavj5+sthTWuXprszVNd43AzAgdIh1kmVBvUnlhBYld1jy6FGjo4Lx7VCFejTzVO90gtf
 lkTGVSubpmiXOtnxP3YnP2mkODYBHGBCO4BilNXP0=
X-Received: by 2002:a05:7300:e9cf:10b0:369:404c:29bd with SMTP id
 5a478bee46e88-369d98655d9mr2576437eec.38.1792748853187; 
 Fri, 23 Oct 2026 02:47:33 -0700 (PDT)
X-Received: by 2002:a05:7300:e9cf:10b0:369:404c:29bd with SMTP id
 5a478bee46e88-369d98655d9mr2576400eec.38.1792748852649; 
 Fri, 23 Oct 2026 02:47:32 -0700 (PDT)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9d892b1sm6071291eec.10.2026.10.23.02.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 02:47:32 -0700 (PDT)
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 15:17:17 +0530
Subject: [PATCH v2 3/4] blk: uclass: dispatch UCLASS_MTD lookups by block
 descriptor
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-series1-spinor-mtd-gpt-v2-3-5d29d32c1289@oss.qualcomm.com>
References: <20261023-series1-spinor-mtd-gpt-v2-0-5d29d32c1289@oss.qualcomm.com>
In-Reply-To: <20261023-series1-spinor-mtd-gpt-v2-0-5d29d32c1289@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>
Cc: Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Anurag Dutta <a-dutta@ti.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Udit Kumar <u-kumar1@ti.com>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792748836; l=1133;
 i=vandhiadevan.karunamoorthy@oss.qualcomm.com; s=20260817;
 h=from:subject:message-id; bh=8Q3jspIUkia01hQf+TIbYsOM29yPnGV41nWuGPkIf7o=;
 b=FAdCaKNet+W/1Ni9ThXG31eHfhqIJ9KZisQ+dWJtqSYr5/G/2MEFEwiiPSHmz/5v6fv7dUGho
 KQqsxbzEwWgDv0SswQArRFcwc94i4h74LmEPv/5F7LelwpTajxcNjR/
X-Developer-Key: i=vandhiadevan.karunamoorthy@oss.qualcomm.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Authority-Analysis: v=2.4 cv=V7LoQuni c=1 sm=1 tr=0 ts=6adb2d36 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=yLItsQnbMmdtGSEzpXIA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzOCBTYWx0ZWRfX1jEkFPAZ+dm5
 /YazyL1p6klulgIOZT5DQ8yWpJNf/s2J5SS9z4bN1ILZdhX1+5+s6GEUVabKbDhc3Tf6Ptm2bwc
 x/siNyeS2WEn/ihfFn4f9/ZJGJ7allc=
X-Proofpoint-GUID: fjryoJ4QCtr_DQn4FdZv464jiN5SqYW7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzOCBTYWx0ZWRfX9+MXk2Mzg6hT
 NX7O3+T/EAn3NCpn+BKS5QW1uuZyEBQ3MyTRwlCP8WyJZnXdqQJ2YP6AC4CtP/L7AbhN/gXOxtk
 +c0mdXK3+iJleY1+yg4B/S8EA8JeLt/2ekVpagSCywGCyqM3d+kZxOiTu5YrPeytQfX+RgPyz5j
 xgWYLKRIm0rjNgIGCeAKuPwraHTEjia/3D58b73Amu78IbV8uXVIr3PzdZbg8wMrqBVf5KY/Vjx
 WrXbQUOaaWw9o8qCWib6IKsRO2Nti9n2AcVpSOyixsn1eC4JHnbVdn4L3jmEXF0fWMLyZO8dPXU
 ivwpbVp38myiuo31mej9YM+pXQbTvoL2fGSpcjZNSbwjh25YBwbELGJmgsz2prMLCDEZtO+bilN
 joesApuaO6bhGTi5HtcROgbgtUyInvChXi+/nrDHMlq3ivCh3Y8CBHjSFC8wmWBYcRR0aRE8VTh
 sYZ6xW9Pkc8dxs4CAVg==
X-Proofpoint-ORIG-GUID: fjryoJ4QCtr_DQn4FdZv464jiN5SqYW7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230038
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For uclass_id == UCLASS_MTD, resolve
blk_get_devnum_by_uclass_idname() via
blk_get_devnum_by_uclass_id(UCLASS_MTD, devnum), matching on the
block descriptor's own uclass_id rather than its parent device's
uclass. SPI-NOR backed mtdblock/ubiblock devices are parented by a
UCLASS_SPI_FLASH device, so the generic parent-uclass matching loop
never finds them; SPI-NAND and parallel NOR are unaffected since
their MTD block devices are parented directly by a UCLASS_MTD
device.

Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
---
 drivers/block/blk-uclass.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
index 6d2161cfc7b..231c0622091 100644
--- a/drivers/block/blk-uclass.c
+++ b/drivers/block/blk-uclass.c
@@ -128,6 +128,9 @@ struct blk_desc *blk_get_devnum_by_uclass_idname(const char *uclass_idname, int
 		return NULL;
 	}
 
+	if (uclass_id == UCLASS_MTD)
+		return blk_get_devnum_by_uclass_id(UCLASS_MTD, devnum);
+
 	ret = uclass_get(UCLASS_BLK, &uc);
 	if (ret)
 		return NULL;

-- 
2.34.1

