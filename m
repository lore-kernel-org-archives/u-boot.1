Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1830606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 18:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RWwuDvS/;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YWg07ACR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Bqqayme1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC7F36066C;
	Thu, 22 Oct 2026 18:20:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gQAoRwwJxPfo; Thu, 22 Oct 2026 18:20:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 004186070C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792693209;
	b=GAdl7YOqlnyG89KvTDrKHXeXHf8i9EiiKnWORhYvPHurvBNmknTUU+XJIPFmGmAgPweA
	 MbV77+X3v0mmyMsHK1mhzY7nNB2CeMMZlSMeuH6B1Odzi1d1+6g/4H94M7H+/5wUqEfAh
	 1K3v1F9tcjfyXM+c2U85w+DapzjA+PKs9BcgjiWCoIwnHdgfPJ+FEo6/r8BfRAkcqm74/
	 p1MvLEIQQt5wdBDo3nzl0ZlE+zLNMcej0yMXCRYQMnAMVh8RlXGiLd1Nn1UEKaiqxQa8l
	 vysPMB6SrQQlh+PwDzu1v36mps7Y9QrpFc0vhomkiPmHk7SOL/0jrGHKVvpKVY2xlGA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792693209;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qj73p9AR/fTQ326Lud8nxDQ/jIJXJ9XYud+OnyjBlJ0=;
	b=FPlhIygB+s2ZZk5PyHQWnVxxMKiycr2svRfnkExOL9mdt6UXHFIyULZ4qoIWR7n7m9CD
	 qy19D48wS4bupPMuU+Km45iiQuQG2ET0IlsmgHamiXY2hTJSbcG3cO3ZFpJmjC2blvOBJ
	 1OtTf+qzpAS4hybehNKKAOedkjchT4MT6OEhfyr+P/l+XWhydTcIPMVeLC+kKhwnd+wgQ
	 aFuf4fZJGrNLCZZv2l3rj3Q9S3kOvUtsaRM7gPwA8NCbfo8rIzmePqdz374Tq1FH9z18A
	 qAQmIBylUeNFK9v5t6dBtkCPWuzDn741st+6ccoUN9PGiRKu9QpEeud+hI5KsYF903w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792693209;
	bh=qj73p9AR/fTQ326Lud8nxDQ/jIJXJ9XYud+OnyjBlJ0=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RWwuDvS/fnQg049zgqtk6aB0vFpE94WJMq9LQMDUe1mbEZhblgWlJYmEtyartOfae
	 JEZFAJuAIOIzK7vhddd21mcMMpLpAzutJ37UAPa2pOiAKDy/FO1dRfDJC/yM93XUVd
	 k7j3fdRr77hqVF8IBaYWF+ZZexC1GmyHp4+h9JiXe+JJuADwTMcpCbXsdWtYCd5co0
	 MpIkHStOlWXv0GsPUNfeUg7fSE1cJpP7RKA6xjKKbkUXD80IKS1Tzfl7x5lx9gvRNH
	 IQvWWP9MZfwGS9Y/JEoITdagHxFaek8BFNoujkCP6iP8TtmdezOFmfyQGmmcA7ycli
	 ZB+5VRe0i6i1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 004186070C;
	Thu, 22 Oct 2026 18:20:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 19BB23A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 18:20:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0ADE740998
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 18:20:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KtB155UXIt52 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 18:20:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AF50B40578
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792693206;
 b=iBuOAPUzaLK1OCCIvgDgctdXA2fdbJSE0PEFKMWnLjmCknWkRwlz3qsymPhRUQAG5AlC
 GlzlUFNc8xJktx3v344JfP161Y0RkmfvmyTddal2BrA4FOkR4InLDPiLQMLGJD97zoEbd
 LAC6xjlbnj31zHcv2bHHlxx52vkaGYf4YSqXPDgodz05Zx+LhbTx22wBDFhqUwAViWZvm
 jk+zzwBcImgn7umOCCY5eCklilnzLUogi6q0LEva6SuMx7+Ub3i15GWWjMFR9RQgePiQo
 Fe5qyEnS7o/kplxIap7j3lq9PlFd08JrgX0Pf9LhLcfZEM07c9JQZmSmc1G8rvRzAgQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792693206;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=qj73p9AR/fTQ326Lud8nxDQ/jIJXJ9XYud+OnyjBlJ0=;
 b=PjctkTgZRXARI/FYusbiNS5bmM5Xg6ffHHj8pAxHZc/SettxYom1w9IDqhAccQFopne5
 t5RajPmqYM0oHhbEOyHawfnErK802Ws6QZx08Mw6Juk1d9M0Pab1ExXlpsA0AfyOaa1Vn
 neSwx6naTPo1XzmdR6L4cJ86IUQsjR5mAT9XC1UB93GOyFBXKfVAlqp5HPyDZv28S8kc4
 nWhr71KAxndfubQXXz1H/CeF+7ehPisBva2CMrt/+ZGNoT+CmyCunMOEJLA1Ux2p66X0Y
 fLTKm2BNMil0GJp3IhhpSti51EKA4fqIXzgMliaP2+aXZJXNfPnakelehR+E1zc3Wug==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=YWg07ACR; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Bqqayme1; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=YWg07ACR; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Bqqayme1
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AF50B40578
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 18:20:04 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHXSJ1495555
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 18:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=qj73p9AR/fTQ326Lud8nxD
 Q/jIJXJ9XYud+OnyjBlJ0=; b=YWg07ACR0MSvg8W8JA3cxADL4uW0ymi/WeXqkX
 pzD5nFTKLDFHNqDDb9vjqcEA+t2h+ZuJJuwtkn7wf9OZMprD2uJxdYwS6JJYGIWu
 t/ZMtlu2R0teEtYMUQc1OT1DsYK6WNlCxRTdExL4tsqfKqWpO9kVMVRdGcosjEoQ
 W8wCIUiMdSmUdrOJHGX1bQrPz025X/6NGJaJFwIcM7XwhxV9KBdfTjnQK94xk5Rd
 kSS7z67fdzxsVvixTIfwce5KDobYKCkEIMkN+OZBvrt8xjh1ANDEv2UvFUzmLsV9
 EBwlAt0w1w4S8avlVP3Q8LhuKRF8MSlBL2G4badTW2K1oi5w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmr80dd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 18:20:04 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e82060977so6515285a.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 11:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792693203; x=1793298003;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qj73p9AR/fTQ326Lud8nxDQ/jIJXJ9XYud+OnyjBlJ0=;
 b=Bqqayme17/SrIQcnfg8lvq65FUefUe80LtTQ7Z6CmpxvCpQ5nuE3j0RtBsby8dxQpP
 /mPs3RJVI45ZlxkVuqTm6irW97r02vMXI5ph4F6KL79mReoSMHd8yHvLWvTBqk3Db/ny
 WTnJ5ls+bT7HCheETv51ABAekkz+H1+JT8EoCM8OzoPppHUC7aPEmXUMNUx+vqhvoi3V
 z6OBb8On6UmjEa+jf9ueZAPEwgk6yueTFt2pj7iHo133eNiNKUwJLsseNmHQurTBSbOp
 hXvilfPwHs0FgBfwzhWxB7/CfEGJJuAaa2ixzCDFajfvRQAML1YCsY7Rg5l3vigZba9i
 DJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792693203; x=1793298003;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qj73p9AR/fTQ326Lud8nxDQ/jIJXJ9XYud+OnyjBlJ0=;
 b=H1wDzNsnWYtn5BYZQXh+BgKz0sYdxdJw8pnbO+E/1RRGE6MXJOe3O3fRs7cqlKWgA/
 /Psxb++0b+1LMVR97zK2pUVlMcSP9zXxIw4GMbazt4rRBzREFYRaG9gC57O4xd7uWJGI
 pIXazBcVjQKgV/R8Of9TONrtagaxDlgHGroEzzNgvWBqB0fW5vdM/Wky5r7bJgo5Apsv
 FRacqCau10tS74axVCtYMcrVwBLP3z3oG9TsAcJH3PaJcv/zx9pqpHQBZzviayDu9I6U
 fX7dkKOhnlb3lHUt9IKzI0qzYK/h1rFo+bCMtzbW5JQay36krXC+d5z6OI3wbIxXjGEu
 yiFA==
X-Forwarded-Encrypted: i=1;
 AKwUvByMskUtMBySCe7bg/OWTT56szqPc5h625ZreigQWVZ71fagbUSPTZMYx7A7FVgePpafVvwc48M=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKeior0v1JCnFKPvX0JPEBlzZLZZ2GAx4gw/+Md4UArwtHpo5Wk
 QlJI6qMr1aamWWcDZxs0mWH7G0LfVKz1+YjHErm0i8y6+mJRjdrNQ3b3Jt0JA62HsddyyeayPaj
 LYmbjvxdens7AOGUheJS138sboNgTOKTm/LKVK5vcmu4uYe8GdhY9yXg/kOMRxXlicoeBgjU=
X-Gm-Gg: AYBFou3xfz3nVcoD3Eku5RTE2OS7QW77ZhcF2TZXi0a/jZ4CF+hDzAbOXC85dPr7/vC
 jUx7P3OaLDw909kSjz9PbgW/cc3wva0O1rHeTe3sAJgu6EY0xoyLLaiFvGjvhe7GiD1iPautmzs
 mUyaK9RxOO/tGARsFPTxyUNmdtCWRMHZEdyK4f5FD9sYR+isGpaitGdwkZhlkcX3rrBYq9d6UuI
 IFg2s3qsk3J2pcg4XgZXBNfRaI0ch1Cnz0qYkmduQzRRs214xdf3GCcLc0LJ1vlU6cK1aYvVdzU
 /GjbZY/PtHaTY1bRgnRlYbRcW+k8Da77u85yDI/QiS5rtEAy7NeAiWtAUhJDHaEhZ2GQrglRncI
 8v4M/W6aHtP0udbSYZdvsoah6m0amWJGtyi/GNKfWxY2h
X-Received: by 2002:a05:620a:4015:b0:93f:4498:603a with SMTP id
 af79cd13be357-93f627ac67emr529715085a.35.1792693203353; 
 Thu, 22 Oct 2026 11:20:03 -0700 (PDT)
X-Received: by 2002:a05:620a:4015:b0:93f:4498:603a with SMTP id
 af79cd13be357-93f627ac67emr529708985a.35.1792693202671; 
 Thu, 22 Oct 2026 11:20:02 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46a5c4cef1sm15162266b.28.2026.10.22.11.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 11:20:01 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 20:19:54 +0200
Subject: [PATCH] net: fastboot_tcp: act on a command that succeeded, not on
 one that failed
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-upstream-fastboot_tcp_fix_b4-v1-1-df51bb9e972c@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWOUQrCMBBEr1LybbCJUtGrSAlJurURTMLuViKld
 zfRzzczPGYTBBiAxK3bBMI7UEixgjp0wi82PkCGqbLQvR5Ur7VcMzGCfcnZEruU2LDPZg7FuLO
 0J7j4q5p7N2hRFRmhNj/9ffwzre4JnpuzLZwlkA5t9EuLJojlGKFw65ZAnPDTvu37/gVIB3XNq
 wAAAA==
X-Change-ID: 20261022-upstream-fastboot_tcp_fix_b4-a3e7c91f0b62
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: ULPGCNE-wkcnNcLFzYjFmyUvu2JNF2m6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA3MyBTYWx0ZWRfX5H8Tv+ilKUiz
 1GHP8jxe3iulIIg2WWXMxH9DOJprEXKcdXzgZ5G4UKoQ6edQA/O0SShFHcDHwaLucX2wbAdR6JA
 tqwM7K8J0bRzLI5oQiDTZMdHbeoJOpo=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6ada53d4 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=hL0M1Tl4LosABt32:21 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=brN-StddfPF3Fj-3sTgA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA3MyBTYWx0ZWRfXzPFoEUX+L9Ku
 4INsm1N166tlBtKusUvDbp1r2ooB1pwqE7FxUGliWA+vAfldt1a4FotmC7QHiESbJhAdkVQcz3n
 PC7FwwAnP/wkg8bx01Jbyh9xhV44X0MwCMk6p9A9LzEuhPdAtG1Tat0/8GPsnETVY82JjwX/erp
 SU34yIeJXuYDsmYzkzDMAgShVm4vtcyYUmJB7/O1CDKTiRs8IuywnwOkdRQPROtkyTP0mM75F04
 p/tQ1MHzmGWdpIqFYTailKashNtJM1DL1eMiJquG4anSthBi5fK0us9dY02XSxQjQrTyXsebgjS
 4P41gTjMtL5dcLChFt9uuDzkmHwkiJIJroiyVyDG+BAiEwCYDWH8TdDrQf5huWjqlVK74/VA35x
 DqWaAz1o93gb+5vfgWnmuGwCmz9I0YrSeSPXFEC60S3ZB7hWOyPqkPhgPaaqz6s6fvJ4+rKimc4
 CMzF0Iv/JY7FcpKuUMw==
X-Proofpoint-ORIG-GUID: ULPGCNE-wkcnNcLFzYjFmyUvu2JNF2m6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220073
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

fastboot_handle_boot() takes a "success" flag and boots the downloaded
image, leaves fastboot or reboots only when it is set. The TCP transport
passes strncmp("OKAY", ...) != 0, which is true when the command failed:
since the TCP rework, "boot", "continue" and "reboot*" over TCP do nothing
after their OKAY reply and would act after a FAIL. Pass the comparison
result like the UDP transport does.

Fixes: bf962de97c37 ("net/tcp: improve tcp framework, use better state machine")
Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 net/fastboot_tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/fastboot_tcp.c b/net/fastboot_tcp.c
index 3ea25c997fc..b9b4f707b14 100644
--- a/net/fastboot_tcp.c
+++ b/net/fastboot_tcp.c
@@ -57,7 +57,7 @@ static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
 	fastboot_command_id = fastboot_handle_command(rxbuf + sizeof(u64),
 						      txbuf + sizeof(u64));
 	fastboot_handle_boot(fastboot_command_id,
-			     strncmp("OKAY", txbuf + sizeof(u64), 4) != 0);
+			     strncmp("OKAY", txbuf + sizeof(u64), 4) == 0);
 	rxbuf[sizeof(u64) + cmd_size] = saved;
 
 	len = strlen(txbuf + sizeof(u64));

---
base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
change-id: 20261022-upstream-fastboot_tcp_fix_b4-a3e7c91f0b62

Best regards,
--  
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

