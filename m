Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0870C606D82C
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Mt0vHJPt;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ACCskiAD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LqlNKRJU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CDCA1810AD;
	Thu,  5 Nov 2026 17:14:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gE6JRYNFFBi3; Thu,  5 Nov 2026 17:14:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2F70C810AF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793898876;
	b=jpb9dIBtBQT50Goq0JtMQ7Joth9XNTVpS5enIti+pvp9g0Io71pfQm8x+L7wFrnZH8cP
	 RS/ejXxdspg48KG4NeHbvjg0vhFxu3exeIP3lDo3L/T1tCYwvM6k8uzgT+Q9p9dt/8F5Q
	 2CU/ScnVu5zLEFhOojPDhed2P4qtjFqwOiQN/BrZ1nayyM0y+pjmuqB/x/kXSpu/3G0/6
	 ULA44F+U7vSUaWc79u+yUgXroWPtqSw74TeMy4tzhA/d8NFGLhkKUOrTDVJ85/DBpWVf4
	 sKf1bPLHDEEAfL+UVsRnjJ9w5xbThDQcc5KeYMHoYhKeElUzfMpjWCcfJ3CUSl1yT7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793898876;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jWEQnFyQ6iUFiTXjKyOA8GD/GsgqI0gclHtp8t5e64c=;
	b=XKgPDzsvfKupORVtP+fzjat4uCtk/MpN1u/+OZ/wLcm5x8/uvNaHMVh0fkgOjGwFFZXE
	 dxGXD82cSkDfuazM7Uj9kQPjgriOFbslquVsSkND0cOEINS7EHhtoUWUSa+7qUvCKflTS
	 4kqoYhsNI33qvOkGCn14YexqDK+lMcX8GYRT/WkrAj+GpzXDjQAR9jv01hvAYmm6zsNzW
	 xiWhTHtsaCE01NPI43hvE4XUgWPU9X8s5vctM3ks6HU8xnlKzOtw/Ujvh1DvD95cmvTuD
	 5Glxu56wNJ/ADUUpyfedaGddzJnoN8a20AKbWkCAOPpp9/eFkwAdTcrpmB3D4ht8Y/w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ACCskiAD;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LqlNKRJU;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793898876;
	bh=jWEQnFyQ6iUFiTXjKyOA8GD/GsgqI0gclHtp8t5e64c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mt0vHJPtOHEHG/7sWD7xun5Pn6phZidryWKbITqGhFLn1ad/NMmOoQ/PJlfBzH+yA
	 TWuHJZumrvdJExoHrZKxXcDxR9xVNN7KyVJDoGf1SiDaywCFyL75MmF+GkhUkhe6Yq
	 Uffpl/Kqlcsozpfg6Hr0XhBO/eEERIxYMZpOv/B6z0KMc2DHWX+12iSmnurDaon1V6
	 kp9WObSGnZzQtESmrSJPAFosw8YIFFyftmurFn1GbybO59tPHgYmqEMFxM/fdgHIyK
	 SKyP8FrVn9CHj6wtKQ+yp2tGObQRfjgmsZ0yFJxUCI9IackdE8I4AVO04KvPwdIaLB
	 1C9DoqOLtaqhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F70C810AF;
	Thu,  5 Nov 2026 17:14:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F6D631F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:14:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5BECF810AF
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:14:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GZ4wnO80yvEO for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 17:14:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9D41B810AD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=urvashi.sharma@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=ACCskiAD; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=LqlNKRJU
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9D41B810AD
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:14:31 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5EQAG6686793
 for <u-boot@lists.u-boot-project.org>; Thu, 5 Nov 2026 17:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=jWEQnFyQ6iU
 FiTXjKyOA8GD/GsgqI0gclHtp8t5e64c=; b=ACCskiADbYNOmda364NuZ6MMvA/
 WvK09r/wp18xwfhKauPxV6A23Pfjo/h03nrgDuJfgF77lcMr3SP29o5p8v0def8s
 giBT1r0JuIa4I0LSMwL3pdNHkoVAuiwdYXaNNTAouxA3tQ9L2DZO9CsVjFiru9ow
 gbXTA7ql3vO1+M8jghrox673Ssi8iPJtiDSIJR5iX0Wdat/dw17+9IcgGHp3rQ19
 j0ShZsj6LSPZNNYUdpyUhTW3TghEj6s6efBp7hfZbASWWLb95rK6xfDOoWVzP4Ev
 1MKv8k3il2xt67wylW5y0nr0H1A4CT4hjvf+Q3hJApCm9Tnqof03Xh1qbcw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrq1p234q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 17:14:30 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso3730583eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 09:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793898870; x=1794503670;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jWEQnFyQ6iUFiTXjKyOA8GD/GsgqI0gclHtp8t5e64c=;
 b=LqlNKRJU8GShkLWpxs7hayJxyFrSqA379OCRoPow7y1q9kNCtr8zKGKBxasAtQuEXu
 Wkyz7dK/J53V51ltDzUVxq7gZTEDdb8x+H2xN4CCXHYQFzGt6lhUJo1YSAE+54HGgD49
 Ef/M/mKeUMWaCBY3aPGw4raE+caww787dl4cvtX3uCyamYzmPlok36magKs5hGwHsl2C
 j3VvTlQcYsPydtR7KNf03Tm1Eh4wvVJMOIOyicBe1O2L6VWiU89aNM6sbrjKRkrTYA98
 58FgHTj3ZKgmHCtPxdZqL4AcJk3FhTRyQ+SIwyRpjQsxw5W2C4L3DLVYe6s+MnNlog9c
 7z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793898870; x=1794503670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jWEQnFyQ6iUFiTXjKyOA8GD/GsgqI0gclHtp8t5e64c=;
 b=lSzFH5ScfOBpOXUixYZkqwQHqCc3Imj72X/0L0n7jJnXuagLfCHJe6lW4l1NtRaCsC
 xQj4A27oWtE/hLktCoYfBv97FZUpcq/0Whgq/nDlfQwBsX9MpF+HHGH7aWYsal8TrQ8B
 +T9lWcSS78lI9IBm44maa0iVKpREgyIvzhuHforK2cm2nsTVM7L2AkvXGgAxOSbHkZ2o
 255F4WtSbFYmZ3UqtEPUVMt2QAx48HvXEqoGn0Towx+5gAK72PGQdP3UxbFmQjxBoB8W
 lBeyHsCUO0n/rwfOz3I8raHu5HkNS2+GhSDj4G8bQvp19dojSN0iHJd6vDMDUfGx3XOs
 z5cA==
X-Gm-Message-State: APuU4Z9Ut7flGniKkxQxgnc/xXZqJlCxglBzLBln0blRZtZ4zHkvEU0N
 KrHyJxD1Dn2hcSylP2RiVYwo6ajwsWqQUvBwwnYf9/vn7COE5DeTfjmY4AiCWnUHHHxD0jDRmQ8
 OlyPbKT0nZrbhLqGdHEEkVA9b10LADMSMpB7MglhRQ6K1rpApJ8s0KG/iFmQqqeE1rkymg9AtJh
 BrGE0=
X-Gm-Gg: AYBFou1+KOVrUdJwzVoSWdK4jafmvhKGjL0FhSt/amNZ3YElfwZbDGLKyelQ7fyFuah
 cx4ztvJ6YnZC1eHCPK82SMRdswaR2sOZUgkxTRgBw37xdvHSEzdV6eTEIvRHBMzXn7NCQOWOGNP
 7knqg6MLuu5RTmDGo3j2ovZGbSvi6XU03mjYemr+5dxecjg3oWS9uiYZmudqNWm4t5YE0duOuGH
 0/z8p6CosById6QPuhRN/BI0QJndPSy/1N6VHd6iYroSTgo0727er8ZrP/vkvQreZn9/I4vaqUI
 YRVRRz/nLTxePdLarGdKj5cEkKrNlcxO0VY4sXf+NnwiWGjFv8P2EzgxJRZVkcJGemeBtVHxg1y
 Pjnt71LbRB72EKYrrT9yGyWhxEsfv2ppNorybPn38fUQc1+6zMwhOYzaEjFL6jzB0rrmRF5nCqJ
 KThEkSYyIdBgs1367C+/bfct8Cq/z3rw==
X-Received: by 2002:a05:7022:1101:b0:195:1a77:85cb with SMTP id
 a92af1059eb24-1ac57454ee8mr27693147c88.1.1793898869580; 
 Thu, 05 Nov 2026 09:14:29 -0800 (PST)
X-Received: by 2002:a05:7022:1101:b0:195:1a77:85cb with SMTP id
 a92af1059eb24-1ac57454ee8mr27693115c88.1.1793898869034; 
 Thu, 05 Nov 2026 09:14:29 -0800 (PST)
Received: from hu-urvashis-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245c2d69asm16950476c88.11.2026.11.05.09.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 09:14:28 -0800 (PST)
From: Urvashi Sharma <urvashi.sharma@oss.qualcomm.com>
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.u-boot-project.org, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Tim Ouyang <tim609@andestech.com>
Subject: Re: [PATCH] riscv: spl: Add BOOT_DEVICE_UFS
Date: Thu,  5 Nov 2026 09:14:27 -0800
Message-Id: <20261105171427.1438009-1-urvashi.sharma@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJM1RwOUkgmJWN5aSnbbjtUKoGEb=CPUPU2hw8RAD0=k5-q=3w@mail.gmail.com>
References: <20261009215008.2796804-1-urvashi.sharma@oss.qualcomm.com>
 <ab9ae53b-1939-4a68-8af0-b7b17709bded@freeshell.de>
 <CAJM1RwOUkgmJWN5aSnbbjtUKoGEb=CPUPU2hw8RAD0=k5-q=3w@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AaYkjHXG c=1 sm=1 tr=0 ts=6aecb976 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=C09yMGpKkpbmaMf8h3AA:9
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2OCBTYWx0ZWRfX/fTRGbYhSWr2
 tfOZP5nzgf50z1x49vzz1N6SXhzERz+rrquUK5z5yxqJY4Il7R0UugqsadAFF518gZdofjIWdNx
 5Lkfdtz7t0jMUS88TmkE09zfqqd+Hfqj/8105KMadNpUV7+3jgvAE4TEHJiRq9nR9nLTaZyK7nv
 7lgUueX/vAsAqyBM3SfD1ELFjuupMyr93KYkszTYFL0RElKXGrwJ5krbGkloWk2SBgkxoQnusTu
 ABDQ7BOaE6Oo63YTDbAJPy0VtVB35Y0bfCNJCEhhpCRLBoTnLlpypSxT8FXw5OzP5bhFw57vUFB
 DtAlgvOTvebCER02h2sEKH9q/8KlqX6nlVcYceas8XyFOM4K7JQ7Cd1NAUaJHFeqe4eNqGjUj5L
 qTWbwU00sEMfBag4f3geyo/o5kFzcCLtniwHerSI3CQJIWC9+D8h8harT6bmW8U8gT5FG1whuZ8
 Q3Ix/vkU3XojbtF+HqQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2OCBTYWx0ZWRfX0dlP++dLkKPr
 mWVvmYsbqVlJureTWEp+RdEi9CdvkuD/+GG3zN5RJUzLsQKwcFrN1FuZSJu/X1LI9tDzSGn3O0I
 BFO57cNvi1S6r2fJdopVi6gAfy5bOZw=
X-Proofpoint-ORIG-GUID: Sjwe39cjBX5Xjy48Jk5bF33a7rfqMgQa
X-Proofpoint-GUID: Sjwe39cjBX5Xjy48Jk5bF33a7rfqMgQa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050068
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi E,

Gentle reminder on this patch. Please let me know your thoughts on my
earlier reply when you get a chance.

Thanks,
Urvashi
