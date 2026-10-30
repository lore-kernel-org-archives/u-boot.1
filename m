Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810CC606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 05:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SqjPYcbP;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QvpOmkuq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Rli2k/YY
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 48D2860AA2;
	Fri, 30 Oct 2026 05:38:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sdVLYfzrudpZ; Fri, 30 Oct 2026 05:38:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8B2F660A70
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793338719;
	b=azE0dVVRM6RpwA0AKpVJGQZFRAvN686tNLDYEfT4//CNeRCJMTRJKkYUO3taR2vjsM8i
	 XbbbwtjB3ltUK+IOeczIeJREXQkH+k82Ee/4sV14N5pVdD52Y6xfRuqGvBaCHDjNoEmP4
	 flYVP4tROnPx2+C2VlPfUVT6CMtNwGbP1w0ffW4aN7uQa+WzMQwlktQJvOqD02IsPdEr4
	 SEEiWAbfbtKxyw5Rkl12qkIJzKyYQx/vBxwRmDIDZJLrmjlVkVIEmi3fM1HmOQqTJ5ITP
	 EejtryqVpzynoIAeiXHESuizYUD+KngoJ4pdzRIafkz9Wx8g/TBTUkoaUXIe6dSREzQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793338719;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7uxSMVzbnFvDgmYN1E53VZf+ppjtYnT4uOnhY1e9TJU=;
	b=DfZYaMc0kKzKyb1w6smOdnRzhqp2CgXjY1DsK7sMD1uxvVNLNFu9XeNrSyqg88hKkwna
	 qm5Zj2rZZFpPSJNRMqc1M1n7L4ROtq5kisK6apqJGp/YnvBTb6zhhtR4dSZij0BzIoaR8
	 XGv1zKZwkq1JB5ObikusB3XTqKEi0q5+yI27ZM0YOndSr8axBe2dnAgo9YxA8QXZZh054
	 O5iBltgpnke74uov8VyQJUgXVFcppRERYJS4hOx4CCuDF6AsLRqPTU2F5rFxGpLkOmOgy
	 E2m1rMDcpMJTQAiZiwYKmi8GdmP0XZ9CMFgggibGP56fEGuNkTgsdpX60etVLR1aEcA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793338719;
	bh=7uxSMVzbnFvDgmYN1E53VZf+ppjtYnT4uOnhY1e9TJU=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SqjPYcbPKe8HRB2GdBwFNjpyl6cVSjcwGWQUAElPaDYhOJ398uzS7IkM6IBpDz3n3
	 vGxK0CCf7+vigCjh7206/Owt1kd4DfTvFLdbzHpVfDJqR4V0oaSgNcERVvvW36iCYt
	 ttY9gzSP3gkdiEstdLY58xC6kfyZTRTn4rP0OtGPQeRmhuDqOuiRdJdVzejB5aGXnF
	 c9mwsGDHLkjqYmWJ6s9MYryyPiaieOC+fPODdz3H31/DlhQ/YK2Wf28eAPXuHMCYdL
	 gt3K7vonBiPzNO13Hv48aixzqR+ayn76DeZB034Lh8sy6bvB+oIOEEaV1s1cTqueBG
	 0mDa+bvgW3vqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B2F660A70;
	Fri, 30 Oct 2026 05:38:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F1BCD43
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:38:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 911AE80806
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:38:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bDJWgxiqF5Ze for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 05:38:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4B6C88079B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793338713;
 b=Ev8VvzVaTkfY6QENrT+IU2O40rTDSyJNOSyR2VLppJUTI7nf3NbPlEE6/o80El7VshhJ
 PV4nrG0G5aM0kbe/BvOmcUXr/EI4Livxk/OfL4alLzxdbJBkbEnlbAyOHbRAA4BrepDPb
 4klc/2THEiEn9xSd7fv+HJMismiG055ApgW4QfmEx5Y0GGK32Je3r1SbM12ZiY83RVk3I
 EL6egypanjOSGes6eGxsz9zV/H8H/gPeajuN6agKbh/X6vxXMmOX2TF4BZw3zd5s35v09
 49tioevQJiI7YoSLXTlTUhHqzx/IeTfHv8r5ykRrqlcwCFR2o9eHRMTLcSJWzZzUpQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793338713;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=7uxSMVzbnFvDgmYN1E53VZf+ppjtYnT4uOnhY1e9TJU=;
 b=eb2ovMusRCIRZIemDfJpnXfBwm0Kq8MhJkx97FWpRB7WJOPYmpDAVPeTXKG9dcLuOH89
 btCfH8OLBiros6L0GmL4eLOk44SbIHa07YBb5VznhkZxjB/HYli1p4gtcEoivPikMT0Q9
 uKC6+1iSlnDjot7mZ718ivxkjF9IhYyX3BYjchFBLWCaUV0/3S2T/mJHcMT38akG1Jc1y
 8739f0pYFwn6L9wc7fAC7bF+HymZSjNN2OvstIrJG4BDjbnMK23/nUbMHDYWItG8La8gL
 pqQA2inOp0Mi+yJWj0337f1wLmnoIdsKxWDoAykVrZBNY4W3kRsYCx1YYNX8k3PhbNw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=QvpOmkuq; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="Rli2k/YY"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=QvpOmkuq; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Rli2k/YY
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4B6C88079B
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:38:32 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U5FAPQ2913286
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=7uxSMVzbnFvDgmYN1E53VZf+ppjtYnT4uOn
 hY1e9TJU=; b=QvpOmkuqTxioP6N192IxaNezoesHBI+0iKASeW6UTwhRRNW1Nb/
 Ck51HO2kvwovjWDsEinhzwVDQ9Yl0ApTLpsWYmaUC8mDZXBYNnBUjvDGijuoQFVr
 6VaCa7gZ6TUT/IiUmjKPSXZa2HjKgMonAef+w5X/atYZJpOV5xviTa00z0OGX9HV
 qfKzFgaEWwaXaMsnqsF5Irycu7wjyI37rjx3OxoRRVxUkheb8E3KQz2/mGcY3DI3
 Or7Rzm0W7syzDn9tWknXmBzULl4Id3u4uzwzo309FxqnK+r0GatJqASE5+vjWr3M
 cawvNDy9x7sIzCs3jSASpMzlMYjIGXuL6cg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qscbt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:38:31 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36998507c13so684093eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793338710; x=1793943510;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7uxSMVzbnFvDgmYN1E53VZf+ppjtYnT4uOnhY1e9TJU=;
 b=Rli2k/YY2Zgb6oztoUghUmokcx94xwJffQlRzb/4xshdoaYil150Hl7on7B5uhsZcG
 CRTxDe+6SP4LIhwfD2iMuUxH+99q26GnxABaNAY6/P5DvTfyqX065q2KC8+I6UCfrBKM
 Jta5T4mMNKfSry1Bj+1hCsCNQmknv1diQ721/AdNngXf1XwDkgHI5/37iwiD7uey7P0Q
 5CSbssOjCMMJ4FsVOH41fYZKY4tZPH3qr0vw0TW309ve5NXLcYQ7Cqgy1i5Q8ocbf1vl
 83JrqZW0HIODY8uGq2+BCu2ubaJMakd0ur10DHJFsXkqipstDQQ/ZsXJ8L3fMWwLgpc4
 XTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793338710; x=1793943510;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7uxSMVzbnFvDgmYN1E53VZf+ppjtYnT4uOnhY1e9TJU=;
 b=SRe+sqg6TY1kBVQiOWIahbzZ7g3w1r4QhbIAx4/Dy2c4b41XtDveinarEeTmOXyu1t
 n5MZeMKRlGdgOCnNVDrIgH4wWNQ4m7+xFmPv+03Ac0gqKYO+R9w8i6e7Qtv5uyvaN+N+
 9XlRbqLJesDxSVU2XygIbcb3ozXZN83i+FWH2XFDmJuYuN1a5Mn0TO12bt1VkUpW8fl7
 s3GH50aReH/9tdH3NCxGFL7jMlTaYcKpn3b99jMw+gsWwdCFjC0Et1KnVckSgP+rZbaa
 wzi6C4n3j6kSy/+xpk5nnSQCTOYdAWkGqX7IkNftLEgGo4lO2c0dQlAPTF/17jh/rYbC
 2NOw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWfTrxWpk/SKRTO0vrXFqDg5znPICmUqzN1i1mjRJLXn+HQtlBY//rmEN/vEH5PPUaZf6QTbs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLEz/DnLzc0tJOlBZ8X/eNVUHIBz4DnH/IO37zY0SuS/DXTIMTW
 kqUyPC7ifenti5n+bvP9nmNhrZJPRLsqBZHku/hbBNEx7QAkyzdPOrqiojdM7zeZAk4tW2A6QqT
 0wx//ckHQmL2DKMtgelnXOsAWxRTK3iA42l10olGryngLiFvpo2XE71+4IxseIjIpG0fMLgg=
X-Gm-Gg: AYBFou2Szf4APY4GXSzIabG738Oj/TNPrajHVkJqUC9Ew1rqScXs3r1rHbTUT+AZrfF
 ZBqBq0oICtatde+IjZBYLTf54e7uykii8uy/MOWyk1Zv0iDmA0desNmmv8ZWlqPW+m0H1Jsrmvt
 2Rs5GTiDdvz+II8jwHQsMYWoSm+wJM+vlFcs0h0KjfnrQMFGrB6gTYrcEFORO89xvpankhHbyg8
 I1mmTv8MOdRiL4kzVVYtjED1H222B/KOFcwURrJBjT+RGIOicl53OcAi/qqvaV5vcReC804Huz9
 gJ4+md5VOqkcb9z98rIUavoAl3w4lsAYISw7E7lUKXXPcLvrsecVLTaeKjAtdLK2GcshE5fIuOd
 DC4dH7cER7yG1zhorGx7SeOvaizK/u/INJAVbmOwRNBXNU4pYEvrEhTZj3uj3HwNzUt9btwgQv0
 rTyRVWot9PnYO7a/fSUzTiHQ==
X-Received: by 2002:a05:693c:42d4:b0:361:1dd6:531b with SMTP id
 5a478bee46e88-36a42484fa3mr1917102eec.26.1793338710034; 
 Thu, 29 Oct 2026 22:38:30 -0700 (PDT)
X-Received: by 2002:a05:693c:42d4:b0:361:1dd6:531b with SMTP id
 5a478bee46e88-36a42484fa3mr1917080eec.26.1793338709374; 
 Thu, 29 Oct 2026 22:38:29 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428aed76sm4174107eec.9.2026.10.29.22.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 22:38:29 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, abhilash.v@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v4 0/2] arm: qcom: shikra: add SPL SD-card boot 
Date: Thu, 29 Oct 2026 22:38:22 -0700
Message-Id: <20261030053824.447668-1-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CiwVcYktmte_l8IhT_Wrdy_LB1eWASFY
X-Proofpoint-ORIG-GUID: CiwVcYktmte_l8IhT_Wrdy_LB1eWASFY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAyMSBTYWx0ZWRfX2emIDcnxefLz
 4Ny7QYfOD5W4f6h151QFMdHZj3JMC9KedfAxHEpX7oEWSxFwyt8Op1SF7ha1RkQB8l9uIRA9GaN
 NkoTye0QXWInrUKxuYs0HZlWYoip0Xo7DtOkfhEBkNDzCkVaDElvKvlyYIrCmAKFwZU0KCazhv0
 CPfwBKUJlMzltmz3xesvPSiFAaFEvB8vSpKZxo0F/jKji7vcqwLQFiGRdggqpLcHn+EvjpUk+M3
 FtNOy8zX++M+pOfwO0x/nKtlTwGPEhQkxffnqnSq+WPt4rCMkjVNrn768usHavdUoNHBBb4afAh
 QgPhAUGK8WUPtsQvG+KtniiW9DVvM00+46KCaMimymntDM8F+3c0bxLH9W0VvfPukKWtSzGN+QH
 JF4pf2pXGQhSHYFy7tB5NiScKn71E2jUk/MF4SY9w7EA+hY72zZrtjswdjsV8+5azXc/EzNw6rD
 ENeQL7VSo/dDHqV0Gjg==
X-Authority-Analysis: v=2.4 cv=dPgzC+Zb c=1 sm=1 tr=0 ts=6ae42d57 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=wwqtjF8b-EO1TeAHCeUA:9 a=zgiPjhLxNE0A:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAyMSBTYWx0ZWRfX9cUW9qLksFRM
 DKOFrWWvOmn3al4v6Wu3YQqq1WsxesnnDIxAWwpB98E37ABLYopxNiXNiveQDW5Q1Dlp4cEtzIz
 rijgLCo30FsajxiSoKUSYZmrD/OQXKg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300021
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable booting the Shikra IQS EVK from a removable SD card in SPL.

Add the required SDHC2 device-tree support and select the eMMC or SD
boot device. Update clock handling so only the PLLs required by the 
selected clock source are enabled during early boot.

Depends on:
 - https://lore.kernel.org/u-boot/20261029105746.3487456-1-abhilash.v@oss.qualcomm.com/ 

Changes in v4:
 - Removed changes from shikra-iqs-evk.dts since this has to go into kernel dts
 
Changes in v3:
 - Moved support from cqs to iqs DT

Changes in v2:
 - Rebased on top of the updated Shikra SPL series.
 - Dropped the standalone MMC boot-source patch, now included in the base series.

Abhilash V (2):
  clk: qcom: shikra: gate PLLs by clock source
  arm: dts: shikra: enable IQS SPL SD boot

 arch/arm/dts/shikra-iqs-evk-u-boot.dtsi | 19 +++++++++++++++++++
 drivers/clk/qcom/clock-shikra.c         |  3 ++-
 drivers/gpio/msm_gpio.c                 |  3 +--
 3 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.34.1

