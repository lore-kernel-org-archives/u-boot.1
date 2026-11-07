Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916B1606A330
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lvhyaxVe;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gkHlvI5N;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O5Mouoxi
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6509E81A46;
	Sat,  7 Nov 2026 12:53:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IPStsPqEjjtc; Sat,  7 Nov 2026 12:53:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 21885819BC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055987;
	b=Q64giiG0A3+DurrEJ1GEMyISEwFZpiddaSFVZNlDU9QtimTdd+zc1uIvKmjBB39HfvVX
	 7Nqr3nwLrNnNh3AZWMBhFyIm9FLoYVYy+OaMZVn1ftzNZRpcnvYTYBy5wVXHn/Fyw4bIh
	 Vd6nt3xRIYvLlAZEvYMimIuVaB56ABKW0WjmvH5CkgxWWqqnkcHcVpaLfAvyrxZHX/a0Q
	 1WmvcF41CKkDSeRkR4wKOrbH9MwEcslykr4shENuhxoSiiM6K6oVuo97ulG/Mog2eLA32
	 gPeLiGkydhEivauIKU6BjjapNNMuZ4wCTCeELx20pggjcWHGJSkzBEf9WVxi2aN3tQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055987;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=V6vTZ8BZhn8TyLnKSRrTa3IWIxmIiU29TmbsPr69Cas=;
	b=B+lZ3elo5FX19kou7p/E0/dpdO/GNhXQ9rKSLscaqefYnbnvEdzew7bJs0KDGwj3MOBY
	 e3uq2Q1GXcpYCxTvXMJTu5SHT0AWq12Xb9xUmqKOcGFSvTJfDCwMaKTMduHyLaI3Swn+U
	 IZMVrFSnQehd5W2s8k/F3xALZYXj8E9AFA4MyuNcig3ioUsanpBgqJ/ZHjDaIskB309xo
	 A574xi2teQ6Kgi/7BCNZIvI/4fgdmwvwH+tIXG4IgqYaUMrn9Rtk7MgD6SKQWPGwMWiMW
	 EHeln7YNMDklbwEgq+ZclgTeeQZHxDe94pf2h++FeunjbqkZDIdGz6dGpA5vm/CXAaw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055987;
	bh=V6vTZ8BZhn8TyLnKSRrTa3IWIxmIiU29TmbsPr69Cas=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lvhyaxVeEkBQOLYC1QxGe99MmvYrT1YcFwnY4exnos8t3tonRGamsPIwgnItySEH6
	 wQbJPTqd2i5nY8ywiqEoiYmORXLLV4CP+4H/ZK3QaI3u5pgC0L+k+Aoo1zrqtOuK3m
	 UxL0KZpQgg8ymC73Trccx8qmPLVFWCOvWggQcN14U/COeGzClqBvjZ+uHYdDbmog7y
	 /abXe6WJ0woGVSNOZrwbdpsCaXZcc3f8auxBlOK9MfN9baaeDX/f5C3/vu+mmuKxhO
	 TBf+OLyF6C/e2E4YtHie8dsTzC/Ylecn1Wyd/JunRJyRrbSzipfFYPemtPUGb/UypM
	 97n60gcd8WaVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 21885819BC;
	Sat,  7 Nov 2026 12:53:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C07834D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 12:53:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1176460684
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 12:53:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 50ddgnpj8qZ8 for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 12:53:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3D9006076C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=gkHlvI5N; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=O5Mouoxi
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3D9006076C
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 12:53:00 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A7C0VhM1757909
 for <u-boot@lists.u-boot-project.org>; Sat, 7 Nov 2026 12:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 V6vTZ8BZhn8TyLnKSRrTa3IWIxmIiU29TmbsPr69Cas=; b=gkHlvI5NpNg6B725
 xuytB7tBEjewCj5G9irTLCkWAXaT9mRyJtVqw54Sj4BLFolSxAO+bzfBI10slVVQ
 5IFGQ0d1MZM3Lp0TqDgZhHkchjBlq3zfvZJiAf3E4etqcZoI/9h4Vc1+NoFgB7n/
 vvAENeUgOPKbvWR3DmCnpvKVHHQDz3IoyThj9K381F8U3sm/HJ5dtWHpcje3+wxI
 zuOCy5k+4IlgsQq63Hy/2Z/yLhGVWp1Veu6bnH1hWGKWsKmz+EEumrtS/YHpa8St
 eu1GpfMEz96A1MX4mcH7slxfp1NdQc2YcMdt/N0Rx1CTvkVkeE3G/ybmlIeRuPHJ
 VAPuhg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsw99gqrh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 12:53:00 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cb98809caso296930785a.1
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 04:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794055979; x=1794660779;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V6vTZ8BZhn8TyLnKSRrTa3IWIxmIiU29TmbsPr69Cas=;
 b=O5MouoxidbdCWeWeJceKwKXdHnkvoXwY0AKFXXnaV4DNvvkMZRwWU3z6srLgkZfdnU
 /UXFJToNJPKYLhAVJIkvgIV80AxYbmuimuyRfHwYPK7T2myiqFMwkle2vvi5XyPZ1+8/
 9ZYl+vMpO703Xk3geTXUW8UQxAQazHswYCI3LZ6uwa64batI1r5uX0nBhQg50ZXaHdmT
 dAYnUogiccby/eNxBj76TME/+RBNBQN+YAcqjG8Dfuv1mdXAhsRndv/jcQn2vYnnOT5W
 VbeK98fXF+NaBZuJXv+mrVrowSgLURYKfKAaqYntu6vMrfyVQc8iwP8YxBcy9j0UMHwc
 g5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794055979; x=1794660779;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V6vTZ8BZhn8TyLnKSRrTa3IWIxmIiU29TmbsPr69Cas=;
 b=1yaQ6dUMsa+unhwfMMzsq9OzQBOJPgN/+jBP2DPaZHEN456zXddF+vYvnWSRVlTV3H
 cPQngPBjamfZj8nozp4hFUvZXL6MAVl/21EiSPKc/M2t8d5YDqFygYm1VDs2PPoeA21T
 SPvbxiiRXDQP6GS2gZSxqp9h4ETrIzVCJQa7v85HRFGqauCaY2/nvR1RF1IvCmOSSDYd
 iHMvuG8aB5Is5PtTkJNoU1Mti7delUHCnywJX2dVaNOHgGMKCXj81R7D7mUVIO6+1A/1
 cSeYMAb7cIAN1i0SvP3CrpB95VhAhZ6A9PTwmVLof0coWdg9GXz3gD8/hMpcJu2KGtSw
 iWwg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzN8r1gcw5PW9JWor+6kHpzN3d2QbWHuj58jHIVT2qVd1lXh3ykR4P/WdJOEY8Fvz3emRPF2EY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9Ksl6Fe4bykJhq+eep8jbaEiGYda3pQfZJiZLuW6KbCzaQ/AqH
 zh3UqGDmZC+c8+nzi8P17XdHEZd9HQc8MOYpk8AImRNprf80D0lU3ybcu9fkzB0yowbd/EM0xpe
 SEIII34n/91T1vLRof0ECrMi67B/f9OCc6b+dNoNI74F10J5mWWBzVnVd0PhFM7lSdRm8ZlY8ju
 EhkxI=
X-Gm-Gg: AYBFou3+hXrGIQ+AyQBTfF9inaSenAaWX01acYDBiVZTIGsesz4EuwT0bYKCcHV9S/i
 wupkj5770WuIFtWbtZn1/0gpYuEHaosm6vLSXobm+W8lu5PLjHPm3DGDsBMIUQYT5yMQakwXPcC
 kz047bqordcxubPsZGB4ytPK3xGpe5kCVn1Stv2bQuAmR91HMWMA5i5A7EUP0iTsYeEA4TwiZXw
 gHj2gjSKDG3hnKP4dCYMb0/Od9vYg2qfYNT3D3wmObI8GS0iryLtL7YUMqmROfP/J8ojgZitSdg
 qCaZ17Zm9uu2grtF+4bHDr87DuSnd51ogU23gVpWzy2RVRn/vmWl7N3q60TZN5o4PO4VNehiQ6j
 3O2frguwBuVcIJ29XAbUMFnVUR+s9pYOFZP4SSF02CE6Gx5YijU7CoDUqSrQRbHeFkbrViPLka8
 GRZCoGwX2Q5bGQ
X-Received: by 2002:a05:620a:628e:b0:93e:f9ba:6902 with SMTP id
 af79cd13be357-945f33aa7c1mr815352285a.9.1794055979352; 
 Sat, 07 Nov 2026 04:52:59 -0800 (PST)
X-Received: by 2002:a05:620a:628e:b0:93e:f9ba:6902 with SMTP id
 af79cd13be357-945f33aa7c1mr815348585a.9.1794055978813; 
 Sat, 07 Nov 2026 04:52:58 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d356c3692sm148599966b.66.2026.11.07.04.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 04:52:58 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Sat, 07 Nov 2026 13:52:51 +0100
Subject: [PATCH 3/5] test: avb: test the lock and unlock commands
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261107-upstream-avb_tests_b4-v1-3-9177277458f9@oss.qualcomm.com>
References: <20261107-upstream-avb_tests_b4-v1-0-9177277458f9@oss.qualcomm.com>
In-Reply-To: <20261107-upstream-avb_tests_b4-v1-0-9177277458f9@oss.qualcomm.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: IE86UyaTuEOULC7vXJOWxwwtH_Gal_I6
X-Proofpoint-GUID: IE86UyaTuEOULC7vXJOWxwwtH_Gal_I6
X-Authority-Analysis: v=2.4 cv=CMq/zhrD c=1 sm=1 tr=0 ts=6aef1f2c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=Oh2cFVv5AAAA:8 a=EUspDBNiAAAA:8 a=e0WsrT6I02IYUqeqVjgA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=7KeoIwV6GZqOttXkcoxL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDA1MSBTYWx0ZWRfX2sGgYNAdlkPw
 ztEHyYlwN/oUNiGoPCqHzWR2wJi2+Ikfo9nMnA9KtJlBj1jqbop6vDGH1R48nbV8su1ZZuBJXZd
 927ZIKKvvWQy9LvPzXh1qdCRAyqg58mh9uAdwSMGF0DzS7UuaC5V11K/mliz4Bt+t5pZn9MwPHa
 gJnhoF59ozxAyRbKCOYx3kNNtkaLISlsNRHYU8+/49zYuKD+FB51uJkI64l175pl91ifC2dTXvD
 xaICUHIb6/7Oh1AHMH9v0EXpiBaQGTj4rSSM96NhybzFay/FGXsk2efdnqVNJ6YuyWAvmwLEZ+o
 yrW1H+uAHRYBT8nVEm99z7JyOziO9vogcyQiVMPlVbsp6ZGjJQ+ENtRcYQJQ9e1KOtYE4CuaAmP
 hvRM0NNEyhHdXjzWtsKfnGrefUKE8KrmSZTDFdOB1zoBs8ayqeC2/h1ruAML1WuWbu9uNejnI+w
 dsQsSff8vXcCMP3DN6g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDA1MSBTYWx0ZWRfX4s1STLLM7oc6
 bMjIiI6o7Wj5lKz3vMYeKyI7SlxCOljeeoeYRf0lLjz1YdJeHqVnLjIuJqR+Aj0ho3nOpCj6CGx
 u9MjqNl8jLB6U4CjZREpJaI1MAP9IL8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-07_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611070051
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

The lock state decides whether the Android bootmeth boots images that
fail verification, and AVB requires the stored rollback indexes to be
cleared whenever it changes [1]. Test both, and that locking a locked
device keeps the indexes.

[1] https://android.googlesource.com/platform/external/avb/+/refs/tags/android-17.0.0_r1/README.md#locked-and-unlocked-mode

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 test/py/tests/test_android/test_avb.py | 42 ++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_android/test_avb.py
index 4dca5849ced..cf1f333dd19 100644
--- a/test/py/tests/test_android/test_avb.py
+++ b/test/py/tests/test_android/test_avb.py
@@ -206,6 +206,48 @@ def test_avb_persistent_values_hex(ubman, avb_device_id):
     assert response == 'Read 4 bytes, value = 00ff0010'
 
 
+@pytest.mark.buildconfigspec('cmd_avb')
+@pytest.mark.buildconfigspec('optee_ta_avb')
+def test_avb_lock_unlock(ubman, avb_device_id):
+    """Test locking and unlocking the device
+
+    The lock state decides whether AVB accepts verification errors, and AVB
+    requires the stored rollback indexes to be cleared on every change of
+    that state.
+    """
+
+    response = ubman.run_command('avb init %x' % avb_device_id)
+    assert response == ''
+
+    try:
+        response = ubman.run_command('avb lock')
+        assert response == 'Device locked, rollback indexes reset'
+
+        response = ubman.run_command('avb is_unlocked')
+        assert response == 'Unlocked = 0'
+
+        # Locking a locked device keeps the rollback indexes
+        response = ubman.run_command('avb write_rb 5 7')
+        assert response == ''
+
+        ubman.run_command('avb lock')
+        response = ubman.run_command('avb read_rb 5')
+        assert response == 'Rollback index: 7'
+
+        # Unlocking it resets them
+        response = ubman.run_command('avb unlock')
+        assert response == 'Device unlocked, rollback indexes reset'
+
+        response = ubman.run_command('avb is_unlocked')
+        assert response == 'Unlocked = 1'
+
+        response = ubman.run_command('avb read_rb 5')
+        assert response == 'Rollback index: 0'
+    finally:
+        # The other tests expect the unlocked state the TA starts in
+        ubman.run_command('avb unlock')
+
+
 @pytest.mark.buildconfigspec('cmd_avb')
 @pytest.mark.buildconfigspec('cmd_mmc')
 def test_avb_init_interface(ubman):

-- 
2.53.0

