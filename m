Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F93DCA9EBD
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 14:39:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 524546067C;
	Sun, 11 Oct 2026 14:39:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CFydfZHBl_PG; Sun, 11 Oct 2026 14:39:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6AD9A606A8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791729572;
	b=X8KZpGE8mvR67hAPXmLBDx9lVD2w1/G93MWoyog242t2xOeosqVxn0js9pUjKI4cwQzX
	 alaIc1Johg1Ns1euJjueYqQgEAciE/NH4/Q+03RewXyf8z5Pau2DH95xeOUQIIzMLmsCJ
	 2gxFmJzd1f00hBfsoK4BLj5l2bp3KNgpAcmWDsIyiIwTcEW4YLxbv1zdsAH81jh2vJv47
	 haoLDJjwIbuw2qlW3kYAivoK7pP9yNsOeJVGiH046lha0V7sL7QMPF5qBrlMeqjF9pcrB
	 wNi3PK+8MApIWI/xYvKic0B2VXhdEboPgIM+qM2Fe20kqoq0bI0a7/gBCtMRspKrvdg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791729572;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=si9su3hpv4swqBaMd3a+WgYCofwHNHeEiEmv6MRxFbA=;
	b=Lnzw3zz4mDVAJhamjFHZ8shSiIcglyzuGWOqytOfX1T4UcPgUNrvjQ2aYFvyvOAREaHe
	 tNkUYT/2yhKgmNyTbNkCNkmlbq84lMj8R5/mtoFvNrp5dxt8dXozfZ4WN3EWP/Hqku/Cz
	 NNwepWyIRsCWWFcs1Yz0sxMnzT6q2l1KeKR8OEsgDYoi48gUe1Zi0RkwVmX+8wuEQxfby
	 RzRvcVjc1LXrSBB4i9lnJGNexpoE47aZUR9K/37KTnw5YOkhKp6Jxfa4xy926H2feHWea
	 KhvdKWsjo5ppjd6TLrgf2aUNpJAAClwXd1Ql5De/YviRTFTuvT/e567yikh+tF63tNg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791729572;
	bh=si9su3hpv4swqBaMd3a+WgYCofwHNHeEiEmv6MRxFbA=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Kezf4fCjM1DDNKTasZqTolOsEoIVMkR9vSNy0FRrbxEp3LIZd3sPB20rRI480149m
	 oV4RZ/2AEgtheVb8YhnmrCnQ206FOSTwRlNo1svdunUzVzlDIqcBhFfD+eVY9Wjv+4
	 Ik53qFGjRspqdv2Gu2WB1ZohrTJqDotQyRgplujIKzYAVuQH0xxIRjEoc/RtccKkVO
	 6H7BGO9OWf+MA++DPoN5S2HD0GhF+h5ZdvCJLsvvRv3hNtm7yV+kmhiKj00FrxgiDX
	 yN2uCn0eR1i/VMO5n7Kd4QIFCySWVO/2dVeDX5MO2L8haehYL5hD61m+/4pai/WNWM
	 HRk34knWBSaVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6AD9A606A8;
	Sun, 11 Oct 2026 14:39:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7BF9B111
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 13:07:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6282F80DA9
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 13:07:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gnEmI3mPfTOg for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 13:07:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9AF9B80D9F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791724069;
 b=M6WpcGwk1vQqwA5d0OOmJmlUGlBDa7qA1QdB5sWogjPXXH6Yq+fEWnx49TTGZF0dxZRM
 pnBq57TXH9tW5MNsWR0+vP817so0g5lSzSVGW13vGxRrIJxf4TQ8pERPVjaaOy7WqJuxQ
 qHOJZwdERR07RWxAzvLg2aZ2kkAk4yHRCqmn6JbPRKj9J4vCKfFAHH17g3HOrG2knbHdz
 qJoyzr8qjV5urFCUt7TNHeXkowso8IYGofQpAlY5Ww2hbAjkS8k8ztXXRrnStoYAbyaqk
 EtYXF2fhkcNp5PEIyNDTQtMb/Ljsvu5gRJs0GJpkeHAww+EIKOnH2KNMCplYLp7i6XQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791724069;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=si9su3hpv4swqBaMd3a+WgYCofwHNHeEiEmv6MRxFbA=;
 b=CDxwh2Zd6frKUu9TF1ydCJ0Ija64FUw4kLOCINMEK4C3psOkp2PzByYc7Rnc88Zj6i0+
 Kz3SIHU801XGO9xZ1Cy1QaUctfCt+GM4+sMOHS8DJiX1GiH2JT2U5flrnRA6GaDgqdyE8
 0/jf9UNMyQzIrQuk+nbf/srRlgs1cnokPYtNUTW9KFRC/CWK0f1RaTfKY85eF2pqLHbWo
 6ZjbYpPeTChpd7J8mXgA25aD2aA4qDLdGYO1Wozv2e9+4P9kHpobb+yIF+lkxyu/A1VTZ
 vrgc+pmZUeNlxhB/eSHl0LVICy63OaiWzWi5Wki+K9y//+9055uIPlRNvtTLTjRxmqg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=CQGuiBVg; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ZcRIeSAn; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=CQGuiBVg; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ZcRIeSAn
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9AF9B80D9F
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 13:07:49 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69B85HOS1512990
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 13:07:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=si9su3hpv4swqBaMd3a+Wg
 YCofwHNHeEiEmv6MRxFbA=; b=CQGuiBVg5M9GgV4JFrybxy6ks8GIu1cu6iEwE4
 LXanSydDNMc7ZWQsY8A+VcSQIVwsAzg2+pbADk3VWu4rjSOfByhYwgteA2zoLAPP
 IiTw5Thr1l10M/6NzuuJZvUBGOsP7BV51qNl8kT3jmTpcEu1N3CgcIdkT0KTQjKs
 /5Mt9VCpgnRk/NOHEg+Rg25WVfhvKjUPzI2uNFmltQScqje1tSYb9gRxhidJ797J
 ypNvquRVKVJq49SCYgpwfoXE32KqioR8ZUVW8nuf8c9OA77Q8ajyGwgR5xTOlkh4
 pbE23yGGZZc4O128gytpdn3sKbzAnSda4DJVFFFxmX7pW6CA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7ehjjxbc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 13:07:48 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5e5e644a815so474909e0c.1
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 06:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791724067; x=1792328867;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=si9su3hpv4swqBaMd3a+WgYCofwHNHeEiEmv6MRxFbA=;
 b=ZcRIeSAn+U+LMZgr+pe+Mp6LtqgJCuksWlUGvRVuv6wpswXVDPVo3PjRuAznvN2z7b
 Me0wSHIdXf7tqPuPAlrCCPaM9ol6wUiYp+s4fzufxP9TGXa6gDJWbWQMJVQBRi079lDK
 y3bezXn4zHz+E9og0HwGvDRPnOD/q3QOyDO9KP6QoYz3XvW0hDuQz/fCyA+NjKU3SYmF
 HZ1DMghxdc0YGo86OTFxF3Al3qryQ0GNUdFKfFMH1h50yDUtmtGKPTeaW/Zuy0nRWo7u
 THmIWZvZxZQVkVK7eWwWX+X0MoP1NfH4n6qWDojdKhor4URIkYzrtRWkXpIR0H06+P2V
 BgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791724067; x=1792328867;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=si9su3hpv4swqBaMd3a+WgYCofwHNHeEiEmv6MRxFbA=;
 b=a2CtJHpWoAHXd4AM/9r/+MPu7ZclGbRA+AOccAsOj2RqBMM7Qwk+Z9gRnRgVaK+/Xx
 XWwXS+TswF0f9yTMg1i2L/HeMJHAt5PS0Ifwo9qZXtpaEeh4EqAGuOVjKVaZqT3hkNN7
 0EFMOYPZgUXP/vD16m8cMJmn8lxWeVBoSYdHqOSE5gpPlFF3+AhxC6Qnes12ALUMxFDt
 8CkYypWVsMh4WQt1ryElM76VJXjNQ43igC6+B5g+Mikn4chsc1N9hOXEIN7FFK2abyNL
 Lvul77kHhg9XZvGMrN6m54y72VP/4WhjtLsS1cgfWNQqhlxMNyhsnKs6DC27E++jNKx1
 W0hA==
X-Gm-Message-State: AFq9FYKJ/zBsj/ORF7unWfP2FKvz+xAqt/RKh4mKmXUyz539KRrS0lld
 KAhtR8B6JPdHyMiKEDmDETgvq9+3JQ0OBDDsG6s5tnIMOmONCPclnGxbkp1bfLpzrwyhDLkxBlY
 EsWv6lNMj3nSEiqrd5TUIRiEv/5v6LnVacpVr+Ri2Yp8Kgc3VlmKa0TVhAhDlmNNuq7B1ZrQ=
X-Gm-Gg: AYBFou2VFR5P3w7HDGCyet6EFEGwsKkRfR3ucwq3qgLVHjJ3E5Z26RfzdFcrwllEEOp
 e68b2QNT7NBarq9VKpd+fhfh6MVbQiVfeZgYvzTCnUS+yIZuzVRH4XJ+CpoO6Zi3rigDQiohpRV
 C/8Ph50dV2XE+icVki9dLP52aV7fJrFOXAk0fMfiwOAj2W4SWc6l9O/fqgQfm2DN2ywdPHpB/tp
 gOohKRm6rQSXvFjEbZywbDKX+VKwMZWWjm4LosNSMfkXJ+5a7H8urL50MEhZE+WDgJw2hlXJeKz
 RwDnjwQZbGuNrjAi9a669txPhe2sgTfp7EWtfVwF12+sRnTth4SLA2DBNNcHiPlo/k1+5l9T+DM
 ay2j1Omsb2KGNa/Zfnvav//Ba6LIQHEvHoBIAlfEntMaf
X-Received: by 2002:a05:6122:d1c:b0:5c5:731b:11d2 with SMTP id
 71dfb90a1353d-5e91f43e0f0mr2389177e0c.8.1791724067265; 
 Sun, 11 Oct 2026 06:07:47 -0700 (PDT)
X-Received: by 2002:a05:6122:d1c:b0:5c5:731b:11d2 with SMTP id
 71dfb90a1353d-5e91f43e0f0mr2389121e0c.8.1791724066678; 
 Sun, 11 Oct 2026 06:07:46 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c346637b997sm53774266b.30.2026.10.11.06.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 06:07:44 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: [PATCH 0/2] optee: two RPMB fixes for RPMB requests served by U-Boot
Date: Sun, 11 Oct 2026 15:07:35 +0200
Message-Id: <20261011-upstream-optee_rpmb_b4-v1-0-7c63edca4b92@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBG4avIrBtIrEjtVUqRRP+0U1DDTCwF8
 e5N7fJbvLeRQhhK12ojwZuVl7nAnSoann5+wPBYTLWtW2edM2vSLPCTWVIGeklT6ENjYry0voH
 v7LmjEidB5M8xvt3/1jW8MOTfjfb9C9CXH0p6AAAA
X-Change-ID: 20261011-upstream-optee_rpmb_b4-ff86a4ea9039
To: u-boot@lists.u-boot-project.org
Cc: Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA1MiBTYWx0ZWRfX57/8/pJfRnjb
 eVoKYwH9s5qh7XdLhNk99UTVkYOUWBvRClfQs7sNPy9cFf3+aEFFAgan4e+Vc9ULICRK7Xv/7r/
 8rZzyhaWCO90OtXHophmXXhna5Rem5WxAgQOJzpSqz9RO0BiYcnHi9wB0/1yE+ekm8WbDOCSo6z
 UJ4QQPMyROL25Zap78l2zRzyqg2AOq1lmlT2L14DA/4+5NEqPWEytWYNPzj4zy32bnUDFDbmL+5
 GrWXqARsGVDdc8yKx4pDOAxnzjVtlKx/2caf5Feo0WNQEe4dFtcWzH1wAp2kM4PFqm1dTUfU1H+
 1lpjWQgoljhiUWHTvGnPhLIPah88Bt2Fya1I7DHHwWjvGBJytkrHbwnAJpv+ESR2dXmtLLTTQLN
 GNYrZcQ4kJH8563x4ndFOX/Y9vEu2Jjzc285U7lKf09xfAMI3pwPTTu6jXdcz3zIbuicDE2zHah
 fMtIs2INoJYlMsjRFsg==
X-Proofpoint-ORIG-GUID: pNthnsWXDqaYA2mmLI11Cz3AQy9uvPOM
X-Authority-Analysis: v=2.4 cv=MpTHeGae c=1 sm=1 tr=0 ts=6acb8a24 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=52kzTPwna7FOPIafxoEA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: pNthnsWXDqaYA2mmLI11Cz3AQy9uvPOM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA1MiBTYWx0ZWRfX37q/Y5W1MBOw
 9rfkAnW3rUvs7lOX5qmSJ4RuNImRT4s1wLZrjuqGXHh5F72GZPHgmjwVDXrjfQ2BPGfaDfb8YMh
 bTeN5ufWEc+wyeu76SVEVs7EGAQjv7g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610110052
X-Mailman-Approved-At: Sun, 11 Oct 2026 14:39:24 +0000
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

When U-Boot serves OP-TEE's RPMB requests itself (CONFIG_SUPPORT_EMMC_RPMB,
drivers/tee/optee/rpmb.c), two problems show up as soon as a TA uses RPMB
secure storage while other code is using the same eMMC. Both were found
running the OP-TEE AVB TA from the Android bootmeth on QEMU virt with
QEMU's eMMC/RPMB model, but neither is specific to QEMU.

The first patch makes the supplicant select the RPMB hardware partition
around every data request and restore the previously selected partition
afterwards. It used to switch to RPMB on first use and switch back only
when the OP-TEE session was released, so between two RPMB requests other
users of the device (libavb reading partitions, the bootmeth loading
boot images) switched the eMMC back to the user area, and the next RPMB
frames were routed to whatever partition was selected at the time,
ending in status timeouts and I/O errors.

The second patch stops optee_rpmb_available() from announcing the RPMB
device while a supplicant RPC is being serviced. When the first eMMC
initialisation is triggered by an RPMB request, OP-TEE is blocked in that
RPC holding its RPMB mutex; the announcement opens a nested session and
OP-TEE's second thread spins on the mutex forever, since U-Boot has no
notification support to put it to sleep.

Tested on QEMU virt (qemu_arm64_defconfig + OP-TEE, eMMC on sdhci-pci
with an RPMB partition) with OP-TEE 4.11.0-rc1: the AVB TA reads and
writes rollback indexes and the lock state while libavb verifies a
vbmeta chain, and a TA call that is the first eMMC access after reset
no longer hangs.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
Igor Opaniuk (2):
      optee: rpmb: select the RPMB partition per request
      optee: do not announce RPMB from within a supplicant RPC

 drivers/tee/optee/core.c          |  3 ++
 drivers/tee/optee/optee_private.h |  2 ++
 drivers/tee/optee/rpmb.c          | 70 ++++++++++++++++++++++++++++-----------
 3 files changed, 55 insertions(+), 20 deletions(-)
---
base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
change-id: 20261011-upstream-optee_rpmb_b4-ff86a4ea9039

Best regards,
--  
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

