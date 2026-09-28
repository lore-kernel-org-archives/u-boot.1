Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07AC8C9833F
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 12:02:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B43480981;
	Mon, 28 Sep 2026 12:02:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fiMgS7_ckCFy; Mon, 28 Sep 2026 12:02:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5459B808AC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790596948;
	b=TvkFKyxMyfvL/xWrk1mskXdXEDnl67GSrNz/A4R+46jEFg8YazhQ4OzKmy3+Pmazq07i
	 l6efc6g2bLATiC59lz51Q6A/x9+g2MzXXMCYLEzs5UNqfm8VlUfJro4rVSP83mmmOCsww
	 8Y58FxlM1+bQFfaMDiW2aVh6WHJZR3vpaLWQWdTCxwW3r+6brypuKDDZMIRTAzuIqjR/F
	 FK7fvH19rgKJsdNtXJKIKU+ve/r2v1wQNPOWLdt60WgaUnnEooX+mi1pjaue5TY373pIa
	 oH0HuLL/v+IpEDbwaY4g5FDPfXC7SAIAGZthcoerTRIBPWVsVrYFgDDilp1/t+FhkcQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790596948;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0SbH6j8N8xQiNWU3HjO0vRXuBaHTKb3LbW9cPqec0K0=;
	b=kUhjsC/x6IfZi3seI5T2AN98tc29cE3HynJI/3/be+/9MTFZb3LwJL6lXsuVLHHubByu
	 C+fGkCWeyu9T9mwCdPwRlhn9ddbINm9G+3mlVEpsqNZ2RqUUIN4mVdjZWVeYXCpImMziA
	 qT2TP1tv14Sd/q0y9XCb3whZczvUn/KGK/zK6F6740r3tL6IWkCS8Sh4hjDORETTGt/2m
	 3izne1MEkGJBnmCECtg3sttRuiptfGktnXbkgQk0Vhs658HiGFYXZJqI6zRXtiJiQ2HM9
	 jETXffxn6dvFO+tSRTkfK6xBIUnFNifKsZ8Kw81hLsdc+05laDQChku4SLAhXRW/GjQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790596948;
	bh=0SbH6j8N8xQiNWU3HjO0vRXuBaHTKb3LbW9cPqec0K0=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hsmecR1kbDU9jJQf0oOnDJ+88CLF+R17uaTzrOu235QI9eoIughKLhWEB3gVQW766
	 0eGOdpXgEzfVBM9ZZIZGxBKNQZZC64L3TiBZFUjKaIzGn9/kdMJgqhCGWl2uEv6VZU
	 ZDZYmNwInGdHbHGBtKN7b48mZlm3hWypMjGNXMzjN7TILl5jlRzZ1sUjeCRwSCq10q
	 qXWTBbJh6sGCFS5hePHTgV4sV8IcQ+dtNihq9001E/8IomklDncVcn+STx5VxNW6tz
	 SRd0C/WSD8gHzgChTmwV9mDdgLobdm5O5SwNTtb0q/vCZ+lx6HHGmJ5rq08tNF+pK7
	 XZ21KhCfHaDYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5459B808AC;
	Mon, 28 Sep 2026 12:02:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7099DD1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 568D760632
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gmO-NeXDAvJk for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 12:02:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7026660625
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790596946;
 b=PqkT5txFaQuQiVc/4o6RTxG4dKH7WZQkEA9PYhFnWwjzOak4WEd8oFUjlaJ3yEIj44vc
 qxPfB+7W4avkH6SMR2hdA2/ByZVsHq3XJ/dIhepdAV5NkJtk7aSwxDT7B4NxxbDYEfv0k
 9co+9ddOL+SXi//AtpNzj5FpErnB03RYldnB9CUgQVNK+l/C7BWAcf7ZGJoDUSYtszK7q
 DRmcbYYyGOCjX/Z7Fqw3Opt7EbreqbDDONPdjJQzWQ+kYpYx5KcpjCjhQEU4KTARCujKP
 1VxH311lmZr8sCwQlLsC9pV6ulzN3pa/n6BEkGtzfLQ8Wf7ZjxPIoZUhob2b0+LaTXg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790596946;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=0SbH6j8N8xQiNWU3HjO0vRXuBaHTKb3LbW9cPqec0K0=;
 b=ZwKPz47NUTfgHwEmuZ/LtHC2wEpvHhr1rZP39dXdfXTO0WX0oMAapexkLBOSexGa4lTj
 GRAN1xVA0Z4oXzIauczvuVpGmj7ORU+3Vv2JI10bdEhcl6G7kDwU9jv+DbaNzJtHx41Cp
 ZVS7ffEpTe03ZNRQzNBH0kR62dEMJYKgOcpOAET4uRiY6wjHoNOKLC0jxD+DArsrrda68
 cwfSJDAYHSn3v6bqQQ6z08hNBB051Awv89sU+L0QGp5XCFFnc0eERmrCBWiLqeiEim0Pc
 sXUJsS8CqTbUdjESGshQPrkMo+d2hUKwfm0M4YRg4Z8wQG0QbRNTS5rLiTQl8TX51MQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ktOWj8BQ; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="VS4QxiI/"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ktOWj8BQ; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VS4QxiI/
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7026660625
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:25 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SBAHVi1682977
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=0SbH6j8N8xQiNWU3HjO0vRXuBaHTKb3LbW9
 cPqec0K0=; b=ktOWj8BQzmP6HjGENTcumlj+WgCmeiW7NVbHMnf4wEXeVQtClNd
 aa0LyAOenIJzxVbKSYeh/p12Oqw8Bimk3MqRH7mYxLIx12aaoF3R+1EeJpsE9acP
 +XKn67vRisnEyMiP0ywuBCwBYBiu2ZDmzxVc7MxKd36e61IwolY+a74VKr08jWYD
 ncnUkvZ5JkTAG7uZp+HInqDOUXb3lwoP/3QnPUd/7OdDUcZmzo1H7jg9m+sO5ZsV
 K8UIt6jsZcicoDDuTjckeVyKOSfg9nLVOEr7q4DWvE5pE+8EfJ83jD4GnhY9r8Jh
 OIrJh6+Ac1XuuoRtiLHVwChznAaeO1dCcXQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynfkrj26-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:24 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-313d1015161so10526404eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 05:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790596943; x=1791201743;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0SbH6j8N8xQiNWU3HjO0vRXuBaHTKb3LbW9cPqec0K0=;
 b=VS4QxiI/yfaLOdcpRnzndmmHU1XFQbcq+teJQuLCG+Rfhc9e01XQs96n8SrGd4FoHx
 1Z++9hWM/aakWU4R+w4KuPMdEPyg5fIJGfreTYHRTfD9d7EEYRS09FDfoGL/GdPdaQSu
 9JG+cKPYVMnx3YjD98q6o6oDiFS8ELg/jGP0Psi+Dzy+xk3JSpub59h+yd/TH8OZOG8J
 Jlord1o1R7Vm1FlH0atApYvPm2/I9xwNJeeTGNMDCSnlUvSLh6fI033SV/WBEaSltOT3
 wbjspuFbGMeEtF2Hh99bWn6rB3vP5Y7zpZtlD9YPTj+r4fgiiTKxXq+eKyPcp/Ew+hwg
 42jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790596943; x=1791201743;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0SbH6j8N8xQiNWU3HjO0vRXuBaHTKb3LbW9cPqec0K0=;
 b=StX1HeLM6LB8nEmgkpesKGcvb6/+ahBo7/giDrbU0uXgALq9me2fjZZAZ5VC9xS4T/
 Yg36KewIPl9a1iQsklBP33g7HMTpDHBewg0SXwzET+aNHGu0grOOHF5rlW9JOt1JaW7b
 Gz6swJr4lC78Ez7I9Br7izVNy1wdqTovRm16/jPoc8tBSp6ZZStVOiR/VzHuP8z9bfHO
 P9IfprLEF7d0AsILiarNVy6PPwBVRfVqESx+5ODw8femYIykMDgb1ONJvVcj3ndiNFoK
 1sQJjvqm8b9620PXKtCzXwu7idYVBxevlFgD2z4xbF9AeYD+m460OssloasL7G1Pd6If
 hrkQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXSCPKneM0Ob/2aG4Zh0lXuDyQ+GXCjVnabH7H2hoHbl8+nmBjoMpaL3Om6IMOzXffEBK0E4Q=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI8KE3/8x/lEeOlsD8abOuwBTZieUmNSN6+ZCeMkTgloFZfG+1l
 2IbxkscVEAl2//cjkVY7q1xAylvVXEFUsZyyAI/O/hn+fNoLLnOSGRu0MD2JzFwyyZP/A88b+Lc
 vJzrpqi5LHBz1487t7miv2sNff8bLH75y+UPnYqtVDgUsZlKyH2YHOwuWotOAuZIx5EbetsQ=
X-Gm-Gg: AYBFou3ZG4N0EjoWHCI3LRYc+k1whS4As7I098ThCUt5HTYgg1vQXPWH51rnBXwfn3f
 iNmHQp+SXMt+++zJuoELuG2tE1p4Mviiu4PEELpPDNQJkFZZWevCu3FfimrJeFyz8WrSxk7suYN
 G+8BcbD0I9uJB2ZPal0Obfp6YIXgYwER0o6ZtRXPqWOoiEllEpF3ODYwCbxZ01XYg/2krj7Ank4
 YfGVCESrTe3mfNpbfEozwcE8M24OPdfhnuHJPXoR12vx1/z/itX0/6I77ymWzWn2XCg/Zlkd+ak
 B+YT9ixObkYm7IuqQtR1d3DOpzfWjvCx9wHnvu7xy6zwYOM27mcpd9ZowDu1qzxD0zZbPTlN82i
 0vrfhftiMGhR2ZH7RUybCoa9HfXNsZ9HVJA4AKUfE/tn0A5w2PgI1nphBRjzmzR71+AULQ/Hy7f
 HgOebAB8LcgHcgmzX7HA==
X-Received: by 2002:a05:7300:d204:b0:33b:f8f9:c8e8 with SMTP id
 5a478bee46e88-3426feb9da1mr9390000eec.1.1790596941166; 
 Mon, 28 Sep 2026 05:02:21 -0700 (PDT)
X-Received: by 2002:a05:7300:d204:b0:33b:f8f9:c8e8 with SMTP id
 5a478bee46e88-3426feb9da1mr9389888eec.1.1790596939499; 
 Mon, 28 Sep 2026 05:02:19 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144b4ae50sm28658382eec.17.2026.09.28.05.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 05:02:18 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, lukma@denx.de,
 aswin.murugan@oss.qualcomm.com, nathbappai@gmail.com,
 Michael.Srba@seznam.cz, luca.weiss@fairphone.com,
 nikroks@mainlining.org, jbx6244@gmail.com,
 krzysztof.kozlowski@oss.qualcomm.com,
 bartosz.golaszewski@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v2 0/9] arm64: qcom: Add initial support for Nord SoC
Date: Mon, 28 Sep 2026 17:32:00 +0530
Message-Id: <20260928120209.1064781-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0NyBTYWx0ZWRfX3UZlf3jQSRoI
 YuL0L5xJCulvGuaPiGdFBmsv987dZAow3tUGmnEYoW0wvf2jeRoYQRZwM2SSHyY+5pEiEpAcmSI
 7b049Z0G7R855V9HFlhjTEK1flNZCdLbz99qWklOdP+iBYJ4rw3naXNoudUp3GtlWGvxO9hmCWP
 lXU0eqCrqvaucip0XTeKeof3iACUXUB9CcyriIRVBY4paiS8zGgVKfGi1odwBtIvAn9CqDnfhEI
 hESVh/tJgi9PZYBXvo8VUtL1KlKuDt1BH+jD0ewu8254Qb6LOBfMYmyej6Yosi60+6Ha6Z+V5wD
 l6VEI//ZaqmjJxYtpq526pwmQGJhVIaKFfcajw3d0oUCY0kBqWdhZSJQEKf0KVTabHa/j6TVvGm
 8aRPep5UzqrfzaYAJg0DZlEbjTRMEV8f9f3yVrXvnlxGBP8QANYXSXKSXXDX9Lq1F56zWcKz3XN
 E+pJ+uWvdvy5SCb3JjA==
X-Authority-Analysis: v=2.4 cv=e6aT2qp/ c=1 sm=1 tr=0 ts=6aba5750 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=gu6fZOg2AAAA:8
 a=-KWCMSehS6Sf777T99UA:9 a=scEy_gLbYbu1JhEsrz4S:22 a=2RSlZUUhi9gRBrsHwhhZ:22
X-Proofpoint-GUID: 9yw6vRGFrMvKSioNCj_qFUYFKsqpkEsB
X-Proofpoint-ORIG-GUID: 9yw6vRGFrMvKSioNCj_qFUYFKsqpkEsB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0NyBTYWx0ZWRfX7I5249MmpXBV
 hSYelCaJeX0BC47uLLd4iau5HofERnLIwXhv83tyqdwJNUvWyGIz0urD4FKlIxtm2tvMhtoZwYH
 Lf/TLqzI+abUhAltAhvik5k14gDQf28=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280047
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

This series adds foundational support for the Qualcomm Nord SoC in
U-Boot, including clock, pinctrl, USB HS PHY, and configuration updates
required for early platform enablement.

The series includes:

  - Clock driver support for Nord
  - Pinctrl driver support for Nord TLMM
  - USB HS PHY support for Nord
  - Configuration updates required for platform enablement

Changes in v2:
  - Drop DT patches; they will be synced once the corresponding changes
    land in the upstream Linux kernel
  - Drop Nord-specific defconfig
  - Drop ELF 4K-alignment support changes
  - Add USB HS PHY support for Nord
  - Retain only clock, pinctrl, USB, and platform enablement changes
  - Address review comments from v1

Link to v1: https://marc.info/?l=u-boot&m=178695918491771&w=2

Thanks,
Aswin Murugan

Aswin Murugan (8):
  clk: qcom: add GCC driver for nord
  clk: qcom: add NEGCC driver for nord
  clk: qcom: add SEGCC driver for nord
  clk: qcom: add NWGCC driver for nord
  clk: qcom: add TCSRCC driver for nord
  configs: qcom_defconfig: enable nord clock drivers
  pinctrl: qcom: add TLMM driver for nord
  phy: qcom: snps-eusb2: add Nord compatible

Bartosz Golaszewski (1):
  dt-bindings: clock: qcom: add the definition for the USB2 PHY reset

 configs/qcom_defconfig                        |   5 +
 drivers/clk/qcom/Kconfig                      |  43 ++
 drivers/clk/qcom/Makefile                     |   5 +
 drivers/clk/qcom/clock-nord-gcc.c             | 165 +++++
 drivers/clk/qcom/clock-nord-negcc.c           | 186 ++++++
 drivers/clk/qcom/clock-nord-nwgcc.c           |  91 +++
 drivers/clk/qcom/clock-nord-segcc.c           | 137 ++++
 drivers/clk/qcom/clock-nord-tcsrcc.c          |  88 +++
 drivers/phy/qcom/phy-qcom-snps-eusb2.c        |   3 +
 drivers/pinctrl/qcom/Kconfig                  |   8 +
 drivers/pinctrl/qcom/Makefile                 |   1 +
 drivers/pinctrl/qcom/pinctrl-nord.c           | 615 ++++++++++++++++++
 .../dt-bindings/clock/qcom,nord-negcc.h       |   1 +
 13 files changed, 1348 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-nord-gcc.c
 create mode 100644 drivers/clk/qcom/clock-nord-negcc.c
 create mode 100644 drivers/clk/qcom/clock-nord-nwgcc.c
 create mode 100644 drivers/clk/qcom/clock-nord-segcc.c
 create mode 100644 drivers/clk/qcom/clock-nord-tcsrcc.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-nord.c

-- 
2.34.1

