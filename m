Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AB6CC6B0A
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 05:33:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 76C4680C66;
	Tue, 13 Oct 2026 05:33:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 26KekFmnWVNw; Tue, 13 Oct 2026 05:33:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 68C8C80C9F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791869597;
	b=LQBTNaSQQsKVbrwNSmWO0XVnOOXir6OO6advWnaEe4KQ0jGJgn72ESUPzqPW3M8gPioV
	 y7lYvrpUevelT6NjjgnbJLdHWGGkRS6IbNYV2j4J9GGUQYfnH1ZcoPwXcpcOLH7pSOrmH
	 J4i15f2Lgremk6dCNE2hap4pZ9p0tOrcOIPsNpcafNp20FVb/oOQ2TaOkfCJ6USy++uZY
	 SWt7ulfknveYMDyAVbDoDLwVVDJ/PDJipTCzepA4T6LEsKwTlN9MkTUL/RdDo4bkL58gL
	 vxVhPLVGh+h5e2QqRl75X001P97TuM2VLX2LiEXy8T/EElM9GvIRu6/0L4sMTmeG4AQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791869597;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=l+auUpvWg+zITPt2xXRzODjrqqplHbB17onuGM7/4R0=;
	b=fe1csTw9jkAnm/WW5dz+QT9dnbm6E6C/4kUBSeQe95k8UG+G9uGKoj/EOC39NUUxjyYi
	 dJ7JOa97KpbcB1BXdUVNTMjMopch3kk8Y2K7mvOrJ5pbvWSqPZcKNbQzIlSlxCmJ7AsbR
	 D8eMlsUwGezbQsSlnwQ2D+f2QWhnRUeAHCpPlEhp490qANGSGOejyi+vqrXV3+r0dRBn3
	 s6zlxjvgEuIMuzzuXyf0R4tYLaS9n3lbMC9MFJdZzKpUPf8NJCfunXwiHbyB5SpA9s7/u
	 UCEEfDzwWwoMWmRlueThm0d9egQ99sgkXZVN/DF5XG3D0AUVpNgLM1Jy3WpAGp+9IcQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791869597;
	bh=l+auUpvWg+zITPt2xXRzODjrqqplHbB17onuGM7/4R0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ucNj6srTAfg6QMs5I94fwMdaxgwp3XVejq+qbpVhyaNUz025oqV+3gvtYZpkKc1St
	 dPeISx2nha0iuNFjpgMVOnXQi/xAXOvhemQuMsOA2PRSgvhcgIS4ZdZ/AA+X68mpIz
	 2Gh65vG7hdKb+9NjTzMkh+3e/7+G5PtMjXCswRZA+U5KkWXvCmi2L8VGBRlln4yCd6
	 RKWff2rPxgIigkQc8BTTrr43XDqW+GS3Erg0DP+nxV9UCYWE7T11xI2w4jTkMdzHWL
	 xQqeLWKuf3259tZxUuensvagCwzJEJGsWVA+T0pnmdnJP9o5fiYTPHP+ReZq3etpuS
	 R2bb/nRU+3pTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68C8C80C9F;
	Tue, 13 Oct 2026 05:33:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 25167105
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 087234065F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YthMNI9S63q4 for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 05:33:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1F8F540653
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791869591;
 b=B6VGGdvWzRyaDA6SC8SKb6LHY6NlT3T9rwY6NPrSSlE1kW/OXz3T+dpw2F2rdvf5V7qj
 lJhQqew/p98W6Mm0vr2HrOnlnnmqWaHC1b2xVJiLb7DkkiNBEC18iZ0k5r6nwgNQpmcUU
 27q8ddrSnh460dt7uaHmnj6dEezFHyHsCgWQPnE3eaoGR16qr7esxng6Pv+FHdqnOqVCR
 DHGcXBVd5K6HHvDM1sOWEbpJLGPNsULA24Zs6BdyqgmGvRefR7iftLp05AtW/bIW6JaXe
 L/DT+D9gVbXxLAx1wbbnSuK8j/RiJRc1/qgJGGqav96i0BrvI0Kgl9Gm/A/PX01QrvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791869591;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=l+auUpvWg+zITPt2xXRzODjrqqplHbB17onuGM7/4R0=;
 b=J7sPZmczvyhaLfNZHpSSbV+HJQoV0ZybFGQW1hG6id0noV/TM62xupIUkwNqdYDLGFyA
 ybxpHBMMHQwxMKSB09Ph/kSzKRcgRTS24lKHdczCckRjOtGcSl+7tdsCu2li1jsApWYZq
 N80Mkot9hJbAZzwnQ8PVpBf6QMFyMENylRSYJDCfCm+vt4c62cGg2+es5PI2yeZ7FUWCF
 sPCug6XVAKOUrTqLcL+9EQmTHbpn1hHstN0IN+YoIc8YBtSi1ryM99iRj6znwXGxRVY6C
 +77V2GzlH8Ccb2etHTWkA/Gs6Pl+P77TFCMqg1HRC94LGOl3M8b2n0+Y2Z8M2+DQcHg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ig8+Zhd6; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=htKCPeoh; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ig8+Zhd6; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=htKCPeoh
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1F8F540653
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:10 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D21MlI3509558
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=l+auUpvWg+z
 ITPt2xXRzODjrqqplHbB17onuGM7/4R0=; b=ig8+Zhd64UlUN4C6Rqci0iDL83l
 yEc4JFtD3ScVlGqpUrqZBWmlnBUt7YpnpG8SFwTA2NaM5jnGVp0Q/jvNNXTKY7nW
 0rV62dAxkoHf/84OTQ+YTbv+rXAgZytG+rI13lTWYiYBjwAxt8O1/gIuDf/N2+3w
 9778u8Lk/tR+dkW1lPDgONILZqWfymROMkYRJE4tWF2HWN1UttUHB6qGjHOckow/
 b+SGVjUvt1L19jyk/UgL1epErlFX44LGBeMB+tJe50kjzH9CpmTFfePzg0rSgvYA
 G+HVn+uY1JeFOjG3sy1gw/0dyEoqP3UMq34eS0tZZTHKw0KZnszWgwZahJA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wbc4ebk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:10 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3592749a017so2297101eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791869589; x=1792474389;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=l+auUpvWg+zITPt2xXRzODjrqqplHbB17onuGM7/4R0=;
 b=htKCPeohjBwRpYzNDGeIROnfIPZKX/cGrkLlEC39B/tr5lhrSV6VpGpXlbgMet/jA/
 NiQSaYncnVNIBOohtfl3a6Utj51Vn63ehIatiqsvdg5e1rbMtCguVPk/4TMr8IWNIhLY
 5kerSOMBRBAI0OhUvuiyaXq88T+p6k9MFNcZziYoXiomwlUcq5cHtGlRqkvm13yG2jCF
 tvK9TCudCHb9vjWwBR1Dc8DGTF4VUCHPZsfiXo6yTk1v61uckG7VJoltlwdxEubyI4Gh
 7Zaj3lkxhtebBQBOgTNxa2Ef5u9WL7olGI3PslxVZThXCvDr3+BN8LtBzTcCrsdEYoiP
 VXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791869589; x=1792474389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=l+auUpvWg+zITPt2xXRzODjrqqplHbB17onuGM7/4R0=;
 b=iZohDQIGLXXJy3tqS1R5gPj4Y0oRKbbI7K+Xi4jeiFItQgZAH5wlu66j8aRTuzHFG5
 oYfhKRXyIpbLJ61MEG5LpVo1k+pEmx4ftitDgK2t0TghzKSrsAizfg9kSz+WHXmTUnLx
 8dEuRFAZcqDJAHLjxBzIs0xuAfZiedt1rgLP0oDxcTZI2z2vgODAMzeDFhdBEGP417Yx
 Lzl5K+LR/nGtEilyx6lVksgo3ADo0M1CGyHYy+wh6/MYQJ9Q553u2iRDlki1YYWIdXEf
 t6WaQYax6KSPkTY0uxzm3stNbW4Tto8fQvmtUDAjTYAPXgfXSlogoBWPpaHLgbWVK8m0
 hzuA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8sto1f2V76j48G9zQUABYWQ5S7aWvBsdn5e1rzLHEAbm9HRIZeClApP9lZ+d7/r2FuaApj1o=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKf93VAmotX/1stlvwvQNprFaKklMTL6hlBJwbs09iYoMe5N/tD
 eiuxiQiUsyYR4kNVORwJ5OKW+OjCMCxOingLPEayrEgW8w101QgeUa5ykf+p4xVqyByhho3grWd
 Bqb6zBwMYo3KyV0f+2CFQ/29diZVS/Sn84+aMA/p1dEKFu9rUNtTG60uKypxvhyZTrVT4LNY=
X-Gm-Gg: AYBFou3qsZVOkjK6SV9LU6P1wOO4OupEeR12Rfcs1Xy4N5vWjQpzlNSnbfrLQL5xnau
 upvvZk5M6KDIfjNzOdyAvxTAHQ8aHHIZZgEAu5oyg1lSAwetjg2RGfN3OZWDaxb/oIiXx00Sxkb
 bCB0JNYNgrV1PH0HcNPmnwxfCe0zhIq8IUEbFCS9/yRbAiKuSgeIPnZUPHtD8NlNXAV7v1u5ijp
 XzJWk7g58JykKf/hdZXHj7IheMFtd5o5hJ1SoPHdMS2o0dKyHpK88TcLaGhQ9WDZgDGbYRPlAuO
 lGJIf5/us6/28EDnPmCJpYL+/PqUCgnOrJs65O2KpAb5s3k4EYuflWQcKCwLTNz4ITdXAjGqmqJ
 qGMxJ2eeUXVWHsp0QNU36XUjnvRhJeaOUoUf2xbS6pyEDdmQ=
X-Received: by 2002:a05:7300:c8c5:b0:34c:6edc:f4d with SMTP id
 5a478bee46e88-3537de061f1mr15516771eec.1.1791869589120; 
 Mon, 12 Oct 2026 22:33:09 -0700 (PDT)
X-Received: by 2002:a05:7300:c8c5:b0:34c:6edc:f4d with SMTP id
 5a478bee46e88-3537de061f1mr15516741eec.1.1791869588503; 
 Mon, 12 Oct 2026 22:33:08 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-353810403e9sm39727670eec.2.2026.10.12.22.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 22:33:08 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, Michael.Srba@seznam.cz, sjg@chromium.org,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, nikroks@mainlining.org,
 luca.weiss@fairphone.com, nathbappai@gmail.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v2 09/13] arm: qcom: enable MMU and cache setup for Shikra SPL
Date: Mon, 12 Oct 2026 22:32:40 -0700
Message-Id: <20261013053244.2954876-10-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013053244.2954876-1-abhilash.v@oss.qualcomm.com>
References: <20261013053244.2954876-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyMSBTYWx0ZWRfX0fdhAlauCc96
 eW+ja6ddhgpP+UstSucDxJzJ2gti1Z5qlrQnUn5Jul2G+ZlAXEhOlsuY6rbMZPWz5GagsiyO6PT
 JLQAiGhoPZbDAze//Kxx7Df3Mh6WeT0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyMSBTYWx0ZWRfXzEb4jR3ugFRk
 5Kk67O5+OQ+lr8LOH0A3ndPgz4oAPSzIK/9NtgfGzUykk5LysH6vdoxqOivGo5oUhRl3/WkbsdZ
 gYlUPMjBiFm0+8oq1y/DDnc8QoXdEFRWiAPr+QjouLB6w2+S5ur6HYbFuPem30vZoaoYMObGfpA
 8Uj8Q80+iHo9eJJpwU40+amqG/ffUvzeNpLB/Odgl+c/fRMGMc+EGWQTZzyfGWzl3HP4x95N2Ik
 E/000ITErXBULr+JDn8kQXEfbaVwoYZgbIW34p5HDH/kk8PbBs1wv9tF2Gejc4HiABJR8mRWraQ
 XUHlrmFFn5TXJn29rlrNYskaJXHbDuNe38yH9l7JJNwhVdjZWsEnywB058cIhtY75bmpRPO6ttc
 TJB7V6fgoUHd6NZUfG+XU6IDqQm6aUPB8//Az1GqNB7JPwJWhy5k/RW4F2l/nj+nzNZSheIDJl+
 unmunhzU0DnMUffccPg==
X-Authority-Analysis: v=2.4 cv=C4p8WgP+ c=1 sm=1 tr=0 ts=6acdc296 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=md-n7zwCLhyBqDs_0qMA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: J1UNRmFYLC37v_vpuQco3uTA0PFbzNZm
X-Proofpoint-GUID: J1UNRmFYLC37v_vpuQco3uTA0PFbzNZm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130021
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

Use Shikra fixed pre-DDR memory map when enabling caches in
SPL. Allocate page tables from the early malloc-F heap and
select the board map through a common Qualcomm hook.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/mem_map.c   |  22 ++++-
 arch/arm/mach-snapdragon/qcom-priv.h |   4 +
 board/qualcomm/shikra/spl-shikra.c   | 140 +++++++++++++++++++++++++++
 3 files changed, 165 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-snapdragon/mem_map.c b/arch/arm/mach-snapdragon/mem_map.c
index f64ec0c674e..9df522f7a4e 100644
--- a/arch/arm/mach-snapdragon/mem_map.c
+++ b/arch/arm/mach-snapdragon/mem_map.c
@@ -28,6 +28,19 @@ static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
 
 struct mm_region *mem_map = rbx_mem_map;
 
+#if defined(CONFIG_SPL_BUILD)
+enum qcom_memmap_source qcom_memmap_source __section(".data") = 0;
+#endif
+
+/*
+ * SPL platforms whose pre-DRAM address map differs from the common Qualcomm
+ * map may override this hook.
+ */
+struct mm_region *__weak qcom_spl_mem_map(void)
+{
+	return NULL;
+}
+
 static void build_mem_map(void)
 {
 	int i, j;
@@ -65,10 +78,12 @@ static void build_mem_map(void)
 #endif
 }
 
+#if !defined(CONFIG_SPL_BUILD)
 u64 get_page_table_size(void)
 {
 	return SZ_1M;
 }
+#endif
 
 struct mem_resource_attrs {
 	fdt_addr_t start;
@@ -185,6 +200,7 @@ static void configure_reserved_memory(void)
  */
 void enable_caches(void)
 {
+	struct mm_region *spl_mem_map;
 	u64 tlb_addr = gd->arch.tlb_addr;
 	u64 tlb_size = gd->arch.tlb_size;
 	u64 pt_size;
@@ -192,7 +208,11 @@ void enable_caches(void)
 
 	gd->arch.tlb_fillptr = tlb_addr;
 
-	build_mem_map();
+	spl_mem_map = qcom_spl_mem_map();
+	if (spl_mem_map)
+		mem_map = spl_mem_map;
+	else
+		build_mem_map();
 
 	icache_enable();
 
diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
index 27e5c54e512..c267c0d9aec 100644
--- a/arch/arm/mach-snapdragon/qcom-priv.h
+++ b/arch/arm/mach-snapdragon/qcom-priv.h
@@ -5,6 +5,8 @@
 
 #include <stdbool.h>
 
+struct mm_region;
+
 /**
  * enum qcom_boot_source - Track where we got loaded from.
  * Used for capsule update logic.
@@ -40,4 +42,6 @@ static inline void qcom_configure_capsule_updates(void) {}
 
 int qcom_parse_memory(const void *fdt, bool fdt_is_internal);
 
+struct mm_region *qcom_spl_mem_map(void);
+
 #endif /* __QCOM_PRIV_H__ */
diff --git a/board/qualcomm/shikra/spl-shikra.c b/board/qualcomm/shikra/spl-shikra.c
index 52c13859afc..358023b24e4 100644
--- a/board/qualcomm/shikra/spl-shikra.c
+++ b/board/qualcomm/shikra/spl-shikra.c
@@ -3,15 +3,107 @@
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include <blk.h>
+#include <cpu_func.h>
 #include <asm/io.h>
+#include <asm/sections.h>
+#include <asm/system.h>
+#include <asm/armv8/mmu.h>
 #include <dm/uclass.h>
+#include <init.h>
 #include <linux/err.h>
+#include <linux/sizes.h>
 #include <linux/string.h>
+#include <malloc.h>
 #include <mach/qclib.h>
 #include <mach/spl.h>
 #include <part.h>
 #include <spl.h>
 
+DECLARE_GLOBAL_DATA_PTR;
+
+#if defined(CONFIG_SPL_BUILD)
+/*
+ * The SPL device tree does not describe the complete early physical layout,
+ * so use Shikra's fixed map when enabling the MMU.
+ */
+#define SHIKRA_SPL_DEVICE_REG_LOW_BASE		0x00000000UL
+#define SHIKRA_SPL_SYSTEM_IMEM_BASE		0x0c100000UL
+#define SHIKRA_SPL_SYSTEM_IMEM_SIZE		0x00020000UL
+#define SHIKRA_SPL_BOOTIMEM_BASE		0x0c200000UL
+#define SHIKRA_SPL_BOOTIMEM_SIZE		0x001c0000UL
+#define SHIKRA_SPL_DEVICE_REG_HIGH_BASE	(SHIKRA_SPL_BOOTIMEM_BASE + \
+						 SHIKRA_SPL_BOOTIMEM_SIZE)
+#define SHIKRA_SPL_DDR_BASE			0x80000000UL
+#define SHIKRA_SPL_DDR_SIZE			0x80000000UL
+#define SHIKRA_SPL_DDR2_BASE			0x880000000ULL
+#define SHIKRA_SPL_DDR2_SIZE			(SZ_32G - SZ_2G)
+#define SHIKRA_SPL_DEVICE_REG_LOW_SIZE		(SHIKRA_SPL_SYSTEM_IMEM_BASE - \
+						 SHIKRA_SPL_DEVICE_REG_LOW_BASE)
+#define SHIKRA_SPL_DEVICE_REG_HIGH_SIZE	(SHIKRA_SPL_DDR_BASE - \
+						 SHIKRA_SPL_DEVICE_REG_HIGH_BASE)
+
+static struct mm_region shikra_spl_mem_map[] = {
+	{
+		.virt = SHIKRA_SPL_DEVICE_REG_LOW_BASE,
+		.phys = SHIKRA_SPL_DEVICE_REG_LOW_BASE,
+		.size = SHIKRA_SPL_DEVICE_REG_LOW_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE,
+	}, {
+		.virt = SHIKRA_SPL_SYSTEM_IMEM_BASE,
+		.phys = SHIKRA_SPL_SYSTEM_IMEM_BASE,
+		.size = SHIKRA_SPL_SYSTEM_IMEM_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE,
+	}, {
+		/* SPL and QCLIB execute directly from BOOT_IMEM. */
+		.virt = SHIKRA_SPL_BOOTIMEM_BASE,
+		.phys = SHIKRA_SPL_BOOTIMEM_BASE,
+		.size = SHIKRA_SPL_BOOTIMEM_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE,
+	}, {
+		.virt = SHIKRA_SPL_DEVICE_REG_HIGH_BASE,
+		.phys = SHIKRA_SPL_DEVICE_REG_HIGH_BASE,
+		.size = SHIKRA_SPL_DEVICE_REG_HIGH_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE,
+	}, {
+		.virt = SHIKRA_SPL_DDR_BASE,
+		.phys = SHIKRA_SPL_DDR_BASE,
+		.size = SHIKRA_SPL_DDR_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
+			 PTE_BLOCK_INNER_SHARE,
+	}, {
+		.virt = SHIKRA_SPL_DDR2_BASE,
+		.phys = SHIKRA_SPL_DDR2_BASE,
+		.size = SHIKRA_SPL_DDR2_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
+			 PTE_BLOCK_INNER_SHARE,
+	}, {
+		0,
+	}
+};
+
+struct mm_region *qcom_spl_mem_map(void)
+{
+	return shikra_spl_mem_map;
+}
+
+int arm_reserve_mmu(void)
+{
+#if !(CONFIG_IS_ENABLED(SYS_ICACHE_OFF) && CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+	mem_map = qcom_spl_mem_map();
+	gd->arch.tlb_size = PGTABLE_SIZE;
+	gd->arch.tlb_addr = (unsigned long)memalign(SZ_64K, gd->arch.tlb_size);
+	if (!gd->arch.tlb_addr)
+		return -ENOMEM;
+#endif
+
+	return 0;
+}
+#endif
+
 #define IPQ_SPL_BOOTCFG_REG_ADDR	0x1B46070
 #define IPQ_SPL_BOOTCFG_DEV_MASK	GENMASK(5, 1)
 #define IPQ_SPL_BOOTCFG_DEV_SHFT	0x1
@@ -81,6 +173,54 @@ static int shikra_boot_device(int *mmc_seq)
 	}
 }
 
+#if defined(CONFIG_SPL_BUILD)
+void board_init_f(ulong dummy)
+{
+	int ret = 0;
+
+	memset(__bss_start, 0, __bss_end - __bss_start);
+
+	qcom_spl_malloc_init_f();
+
+	ret = spl_early_init();
+	if (ret) {
+		pr_debug("spl_early_init() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	event_notify_null(EVT_LAST_STAGE_INIT);
+
+	preloader_console_init();
+
+#if !(CONFIG_IS_ENABLED(SYS_ICACHE_OFF) && CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+	ret = arm_reserve_mmu();
+	if (ret) {
+		pr_debug("arm_reserve_mmu() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	enable_caches();
+#endif
+
+	ret = qcom_spl_loader_pre_ddr(spl_boot_device());
+	if (ret) {
+		pr_debug("qcom_spl_loader_pre_ddr() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	ret = qcom_spl_invoke_qclib();
+	if (ret) {
+		pr_debug("qcom_spl_invoke_qclib() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	board_init_r(NULL, 0);
+
+fail:
+	if (ret)
+		reset_cpu();
+}
+#endif
 int qcom_spl_soc_qclib_override(struct interface_table *table,
 				const void *fit, int images_node)
 {
-- 
2.34.1

