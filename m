Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C8FCCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 12:11:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A70040608;
	Mon, 19 Oct 2026 12:11:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 61U3a93hi8ZF; Mon, 19 Oct 2026 12:10:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 82CC0405F8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792411857;
	b=GTlMo3CeWshdv1zw2HHu2fhtDQ/yvPS7aMZKpOX35du2CBbKvTe3CwFnAn5Duzqrxx/e
	 nRmz4prbX3vmw8Z7YGlGQKbLbOaADm2HRXtk0OKxBQXtCeeZeSvsrde2K08Pp52liKPTz
	 bHCSO38jHKSzjbAD76QBZHLxgVAexfoBWGRVmUekE3gTyrCO7KHrlpPqDKV/mUwu/AQ60
	 6Ag1RUV+bEs0XNSpaYoJQout1fxupqa3KtH92VplfcsNBCYGUx8BEf1ML3p31SscOWMCA
	 8jh77oTpSrxISESNet1hceD5uT7wKEKJzse77KY9O7G65Xc5cmI6lQWeKsNNHc0V8PQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792411857;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=J8d/3YZ/j/bWYO4+zJi+0r4vzCZAgRfV6KwNU9L7qXs=;
	b=VqiQ6olGIfUOWTi1O9BaTNC6d+PtTUB+QjfwZ1m8m64CJoGIM7/r09huGIexlyhVeO7o
	 5On2qEWBPeVZZ+ShSJn/nKe4PL74TTeuMKzN7OhfTFV48yRyIuCtLkO+51nj4+B13L9rR
	 b+TtjQD7xYvOlMywbNN7T+PslE6oPXfEp6Kqq8SdTPtN+AThreRoAtrmp5EyhnkmwFDJE
	 QtYReUqyXsr6W/niMo8cGcLNmn4OA6Slt1L5Kog5ZBaQVaEgDsG9G2+FmKLVSJbEGh4IT
	 RAvJVisJxiThvfrs2V0WSJyB5XyjD4HgKAnnKWIIY1130Gy+GECcip1Mor9xAxdTO/g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792411857;
	bh=J8d/3YZ/j/bWYO4+zJi+0r4vzCZAgRfV6KwNU9L7qXs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o3yaetoF1scrHCdHXXDfxzPnP/7NMfb5CFlw+3mz71hw1m8GGSZz+osgTaBRiKiQI
	 chOzAfW4EK7zB2pyY3DEhp36G1tRt+ZvFcD9PR7k/k6esuRE2LMYOSVaDQw+gU+EJP
	 Z4t88SxrF46hibBvYX+NusEcd6YavIZisyxvzb9rHtgMOrMYBhNlbcIAXOOsrdhDF2
	 s07qX7OUwuSB9DPxkWEZmnQ8gYXODGYJMN9sqC4UGqSPE1NjYJ/Iiku1Voknx/Co7g
	 h9VmKFwrkEdenBw9/oOnqliySiBAozxidcO6cUEsJIuIJ7//fvfnOsQ3Vnk8o/Op/z
	 KbWj/LWFPpoxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82CC0405F8;
	Mon, 19 Oct 2026 12:10:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E1FB1DE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:10:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F32060634
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:10:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YQpXwOlE-JrJ for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 12:10:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 72CB060612
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792411854;
 b=BuorgBXtb+dMcSlORNC6F29ozviOrddPVQ0inBh85lGfpcRQ26mj2OPcI5yfzpFjqiZA
 TfT3r9b2/8Ha8qA/M71TPkz3X0WKhyJ+eI9eIKiXsJb31b9Elo6yVRPUBx8HQJv5f5SVW
 0d1NdyyaddtOA/FSBtGUK11/TEbPj4q7pdQuPDHuafEz47Ewd4w4q8rPfJv7xKMtme1J+
 3l+1UtvcNcV8HtRiGdGu79g/KMDmfYl4q/UKE0GUbD333rWK4FtUZo1iFUu0pjkGdj+wb
 gV48Uda6+hOpKIk6thO+5P3M+uA+omqXq24XC9E/6epNTCe2WJnsoJ8VMioGkasIa0A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792411854;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=J8d/3YZ/j/bWYO4+zJi+0r4vzCZAgRfV6KwNU9L7qXs=;
 b=Oi6Nl7GCE0WVZcTOZRkKxO+iMaM9DGkj3469cQZY/Wlq7Rf/ZHPIoKri+I2vN4m+pjw1
 nnnVvSFPN6PY7JHDBT91IOoa3PGCtH6RpphsgKLT8L9OdE0AB2fIV4ZNH7/ili1fzDXD2
 ctEdAU5HGPAizgFoeeHHqVmQT+37BIAd6r7OKpWsi//mr2mLERagAFU61piMndZD/7XXn
 PTY8R9Gp/0Luwie1ynK0nh1mwfzHXxZat/aWZXaaRapc48iFFoFxSI2mZgqXnLo/qG7/t
 BPhw2637Cg9TIjuyJHd3u8PspG7lcutmjS2zGJR52GnQrhI5BBDOa8qY7ikVLs3wovA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=hO3U9bOi; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VPeCuHPo; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=hO3U9bOi; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VPeCuHPo
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 72CB060612
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:10:53 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OuO5723272
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J8d/3YZ/j/bWYO4+zJi+0r4vzCZAgRfV6KwNU9L7qXs=; b=hO3U9bOi+i1xPoGv
 AYvoudvGe6mtYkfnaY05pSUUOWsJpAd3+7aBhLxIOrSCV576ZkXgmnVKbKryLW23
 dx6O8ZgdGfyYdjxtAjn2BsPAGC5jjjpBsbem01ixrsJGiICCFhmP+GWKbn932J5S
 DgU+CbTVCqI/8dzNTtr4dHNH9NeT6veIGcEwN33QycW03kJmoeTM3xkLlmP23gQ4
 2ar0kiQKv/dSX/RDxIWfLErQopW3CnJCRIkk3f5L28KZoe0cFD5p7QfBgLIrxlgj
 mglEXSCs5B7uYtnlEzBKDbvd7vDVMgcGlwTqxiTXIEdUEYphkpHkabtOdZvd+8ZE
 YyDRkQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf65gytm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:10:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-934963b2bc0so409768385a.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 05:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792411852; x=1793016652;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J8d/3YZ/j/bWYO4+zJi+0r4vzCZAgRfV6KwNU9L7qXs=;
 b=VPeCuHPoys7n3VLrb/OcihqMxhRgbYQuz4c/BFPRtx/QT5gWlBl7HVMDst35ioTkoF
 YvhJlKwHypGpGr/CfOjCp5Aj8e5xemL+MTwrZe++B9BwBNJgxXv3mfyjN/alLSTGaRBG
 1UcIDCzilTaBcE00Gpve6gBhQXdTH1kF6iMWRa40F1O/hMHwjpVKaYoYzIYuGY3I9Fga
 Kp2hfalO5hDCMlsv9mn23udQrvbNaOXFwZl2i89CAfHc9Ca3/jaO314dzn97vc3DWUUH
 k8AmiSo6TGLB/oLOKHHGh5z1iqce80ZAJmFJIXZAnaZmjtPbAOy0HE71StL0G6O6S03k
 Fckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792411852; x=1793016652;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J8d/3YZ/j/bWYO4+zJi+0r4vzCZAgRfV6KwNU9L7qXs=;
 b=1Py7uvQYRTok2B0QVBspICSrycBAU5IEaTG98D663CHXTGscG6Ny4NjCFf5h1knk4r
 lKyRBEesU1h0HehP7MjyJgCuc5Cz3wuo/9XA9kDG++f+XEFeMCUR3EuMakbea9816nIz
 tM3Ew/nYrgEdF5a0DRwjq4fskg52cqJaTE+3nK5cd/OD5CcsX9lu2Sk69bkSl9B5Qh8+
 8RnvEM8EyR8OPrNrOhBnV9nNBOsWHXJdefHap6U5qhNUUJsk2iLVu7jWdur8C2tXz3UZ
 ZQzwQu33UnIEfSm3l94V6Sq8QsjxLNTRvbxR9oOP9y4RlneZ5SIBBq7XcbpJGIlm8yth
 EAsw==
X-Gm-Message-State: AFq9FYIuvs6Q6WnVRoNIgIP2zlPUqExWbNQKZIXoCSfkONqtWZ0tyaAu
 wHlpZEPc/IsS+IYK/NRWUsDheFGByzZkaqxu8DUcP6cBpewB7bS+DUSTMZ2yGNzCVy4ZF+fgpug
 7NSy1EguqDLd/Jzg7oAxUJd3XFGMrZJvKmvGY18PplgiUsY6BPbbbXIuQ1Gh3MvEWeHk3PnjS7N
 BW81M=
X-Gm-Gg: AYBFou2Jl6boOfe6HIaTctWrqtoL3nA9WXY3Ah+K263wqugxOCp8G9D2PywpxgVQU5Q
 0AwznLkKNd5YOXdkK6XTyVVrDI4zt8+T6oyaqJU8AG0hFb+SFfjDlNdavrAhIPvkK4qxF2QTnT1
 0iYIhPwuvqzSKKsvXHZrHTKA/Sg6SMJOt3LewFN0O8OVhMbvDKwLcm/Mr6lnYo4xpvp7k+yomYj
 QHn2dxon1y2CId/uPfLLAzIg2Kiq67HAcGvbav0oqWS3oZd/MSxn+y8ElqezljTCpqjEl59up1y
 kN+pu9PFGI4/VEzo7qkhdu367ANtmcsDBiXoBPtDwM8uCfTJj/4+SLRerjLZXYpCzTsel3et7O8
 Dzg7Zc3FC/i33uGDyGkOpVfFEA8i5/CR2hmLJpOnijGu4
X-Received: by 2002:a05:620a:3707:b0:93f:2493:bef3 with SMTP id
 af79cd13be357-93f29b97979mr1282842985a.10.1792411851862; 
 Mon, 19 Oct 2026 05:10:51 -0700 (PDT)
X-Received: by 2002:a05:620a:3707:b0:93f:2493:bef3 with SMTP id
 af79cd13be357-93f29b97979mr1282837185a.10.1792411851160; 
 Mon, 19 Oct 2026 05:10:51 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b38a1c6364sm3961522a12.14.2026.10.19.05.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 05:10:50 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:10:40 +0200
Subject: [PATCH v3 1/2] optee: rpmb: select the RPMB partition per request
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-upstream-optee_rpmb_b4-v3-1-c97cf24fc56f@oss.qualcomm.com>
References: <20261019-upstream-optee_rpmb_b4-v3-0-c97cf24fc56f@oss.qualcomm.com>
In-Reply-To: <20261019-upstream-optee_rpmb_b4-v3-0-c97cf24fc56f@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX/jZQB60b6Df9
 G6xlgsSZuwdxaVvRsjsrv966yn3oNX12vnaRy7VdF/RZoA7hQq1Ge4zNh3phmBeBgFqm6VtvZoe
 Y5MQNXaBBa5hV1fJW2utAy5hZh8oMzQ=
X-Proofpoint-ORIG-GUID: CaoJCBJtd2KsNdf-Sbxw7X14PCtF951d
X-Authority-Analysis: v=2.4 cv=Y5ptIReN c=1 sm=1 tr=0 ts=6ad608cd cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=zL1JONcZbJ0eZN6WwLkA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX0NnGcYqfB1of
 lskD+zzU/cVpJqUmVvu0RcJEWilgUqY9xAPeU1Q9Rd1AhtEQ3Uk/VSA97ZXUbISSOU09aO1Kswy
 pVXSgCuE2p9EZW1ApNAY3mYEHgspXrm5sOAJZBXyI71KRk5DbKRDBgH+jAm/N/mzPIMJDFPYBlz
 UhrcMM0DIn8hSKgGKyPP7y79g1IsdEUQkWZWSpY5wdkUd4QBP7JZhU6RVt5TXOJEqwUfYlrLdhC
 cLT4clR6A97q94p1p6WUBLrIrwOmZkhQq7/KmzxwnZML21RajKf8G5rbHuKzlA0WlVJ9CSq4a9K
 EsT/6dZIg9aFpxVxG5ymYRnAJ3J+9HPfdTG7vi6OtbKmm2t2SSyLjg3G4sRyBfP8HBAJULAMWcG
 SVx6XihAcPlV6CnmkHYzbpbCr1oUnFm34emDr9AcZn76IJz2cMFJCZrXFito+t0yMvsx2hX9qLN
 186IVFt7dBxkjgwfBTg==
X-Proofpoint-GUID: CaoJCBJtd2KsNdf-Sbxw7X14PCtF951d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190048
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

The supplicant switched the eMMC to the RPMB hardware partition when the
device was first used and only switched back when the OP-TEE session was
released. Between two RPMB requests other users of the same device switch
it back to the user area: libavb does so for every partition read while
verifying a chain, and the Android bootmeth reads boot/vendor_boot right
after verification.

With RPMB left selected those reads hit the RPMB partition, and the next
RPMB frames were routed to whatever partition the other user left
selected, which ends in status timeouts and I/O errors (seen with
the AVB TA on QEMU's emulated eMMC).

Select the RPMB partition around every data request and restore the
previously selected partition afterwards.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 drivers/tee/optee/rpmb.c | 88 ++++++++++++++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 36 deletions(-)

diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
index 7ae6045511b..d4abc48f764 100644
--- a/drivers/tee/optee/rpmb.c
+++ b/drivers/tee/optee/rpmb.c
@@ -42,51 +42,55 @@ struct rpmb_dev_info {
 
 static void release_mmc(struct optee_private *priv)
 {
-	int rc;
-
 	if (!priv->rpmb_mmc)
 		return;
 
-	rc = blk_select_hwpart_devnum(UCLASS_MMC, priv->rpmb_dev_id,
-				      priv->rpmb_original_part);
-	if (rc)
-		debug("%s: blk_select_hwpart_devnum() failed: %d\n",
-		      __func__, rc);
-
 	priv->rpmb_mmc = NULL;
 }
 
+/*
+ * The RPMB hardware partition is selected for the duration of a single
+ * request only. Between two requests other users of the same eMMC, for
+ * instance libavb reading the user area while verifying a chain of
+ * partitions, switch the device back to the user area. Keeping RPMB
+ * selected across requests would make those reads, and the following RPMB
+ * frames, hit the wrong partition. get_mmc() therefore selects the RPMB
+ * partition on every call, and restore_part() puts the previous one back
+ * once the frames have been routed.
+ */
 static struct mmc *get_mmc(struct optee_private *priv, int dev_id)
 {
 	struct mmc *mmc;
 	int rc;
 
-	if (priv->rpmb_mmc && priv->rpmb_dev_id == dev_id)
-		return priv->rpmb_mmc;
+	if (!priv->rpmb_mmc || priv->rpmb_dev_id != dev_id) {
+		release_mmc(priv);
 
-	release_mmc(priv);
+		mmc = find_mmc_device(dev_id);
+		if (!mmc) {
+			debug("Cannot find RPMB device\n");
+			return NULL;
+		}
+		if (mmc_init(mmc)) {
+			log(LOGC_BOARD, LOGL_ERR, "%s:MMC device %d init failed\n",
+			    __func__, dev_id);
+			return NULL;
+		}
+		if (!(mmc->version & MMC_VERSION_MMC)) {
+			debug("Device id %d is not an eMMC device\n", dev_id);
+			return NULL;
+		}
+		if (mmc->version < MMC_VERSION_4_41) {
+			debug("Device id %d: RPMB not supported before version 4.41\n",
+			      dev_id);
+			return NULL;
+		}
 
-	mmc = find_mmc_device(dev_id);
-	if (!mmc) {
-		debug("Cannot find RPMB device\n");
-		return NULL;
-	}
-	if (mmc_init(mmc)) {
-		log(LOGC_BOARD, LOGL_ERR, "%s:MMC device %d init failed\n", __func__, dev_id);
-		return NULL;
-	}
-	if (!(mmc->version & MMC_VERSION_MMC)) {
-		debug("Device id %d is not an eMMC device\n", dev_id);
-		return NULL;
-	}
-	if (mmc->version < MMC_VERSION_4_41) {
-		debug("Device id %d: RPMB not supported before version 4.41\n",
-		      dev_id);
-		return NULL;
+		priv->rpmb_mmc = mmc;
+		priv->rpmb_dev_id = dev_id;
 	}
 
-	priv->rpmb_original_part = mmc_get_blk_desc(mmc)->hwpart;
-
+	priv->rpmb_original_part = mmc_get_blk_desc(priv->rpmb_mmc)->hwpart;
 	rc = blk_select_hwpart_devnum(UCLASS_MMC, dev_id, MMC_PART_RPMB);
 	if (rc) {
 		debug("Device id %d: cannot select RPMB partition: %d\n",
@@ -94,9 +98,18 @@ static struct mmc *get_mmc(struct optee_private *priv, int dev_id)
 		return NULL;
 	}
 
-	priv->rpmb_mmc = mmc;
-	priv->rpmb_dev_id = dev_id;
-	return mmc;
+	return priv->rpmb_mmc;
+}
+
+static void restore_part(struct optee_private *priv)
+{
+	int rc;
+
+	rc = blk_select_hwpart_devnum(UCLASS_MMC, priv->rpmb_dev_id,
+				      priv->rpmb_original_part);
+	if (rc)
+		debug("%s: blk_select_hwpart_devnum() failed: %d\n",
+		      __func__, rc);
 }
 
 static u32 rpmb_get_dev_info(u16 dev_id, struct rpmb_dev_info *info)
@@ -130,6 +143,7 @@ static u32 rpmb_process_request(struct optee_private *priv, void *req,
 {
 	struct rpmb_req *sreq = req;
 	struct mmc *mmc;
+	int rc;
 
 	if (req_size < sizeof(*sreq))
 		return TEE_ERROR_BAD_PARAMETERS;
@@ -139,9 +153,11 @@ static u32 rpmb_process_request(struct optee_private *priv, void *req,
 		mmc = get_mmc(priv, sreq->dev_id);
 		if (!mmc)
 			return TEE_ERROR_ITEM_NOT_FOUND;
-		if (mmc_rpmb_route_frames(mmc, RPMB_REQ_DATA(req),
-					  req_size - sizeof(struct rpmb_req),
-					  rsp, rsp_size))
+		rc = mmc_rpmb_route_frames(mmc, RPMB_REQ_DATA(req),
+					   req_size - sizeof(struct rpmb_req),
+					   rsp, rsp_size);
+		restore_part(priv);
+		if (rc)
 			return TEE_ERROR_BAD_PARAMETERS;
 		return TEE_SUCCESS;
 

-- 
2.53.0

