Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0993CA9ED0
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 01:54:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9825380C16;
	Tue, 13 Oct 2026 01:54:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iVrv9cTaYcSD; Tue, 13 Oct 2026 01:54:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8FA0680BE8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791856440;
	b=Il1oljKeXRVSWehiK4OMIFEqFfUQ3dYQIt4r7bIj7K3+kUTLtVMRrcs200Va+/WpE6r0
	 ah4suZSAWU0eMN1m+vIXJyM+75cCOqcjjSs0muT0zJRzEymEMB028+8OnkKI80/X04Gwc
	 c4lO3t9AS6tYWeyEzU1x/d+4rKTPjtt4MkuGLjjcVcXDmyRrS7Oni9JeJtitJUGFeeOsY
	 dQQBhWj312RH7K0028coLSBGcOPs9wKEmzAukFmePv1QSD5DOnhjOnl8OLH//bwJrip+7
	 i1FuZ+wv7BROp4gl5BHQo7HG6IMor7DnsJ2xLhdlZ/P02ahfVpJCT4GDdzupgNKUL3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791856440;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QoEsfTo8WOjhCNFv9VFa8NaKqTa8SriPBo9RLZ4At9k=;
	b=DIMRqVREITbtTtkquXs4sRFnLBrpLQDRb7NWCvsyBIOnmBHMLRPWNSXuWDtkk4WjQUAB
	 ujafJKI9kn+1alwVN4SN6U25GbnIGrbz6naBRqdhf+q/Hr5ijqs5NOGMWZdJ6E2u33B4m
	 2TfznjHXfFdknuOgBNb8rhWdsDHgVQkK8TA9kMBbZOBGhrc91kudEeXhnx0SNb3UjmrxT
	 J1D53lgiQ8sxCydf+P0jh5Lk2TKnM7Ez/KttdB6c5IcNEIz8SXp9fSRCRxfezCvZbdJh2
	 z9G/x9SqLOX1kvuBH1R3sbe+VnybqIUITR5Lmt2Ae+7N3O3thBFaq6OQosNVNaTzjEw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791856440;
	bh=QoEsfTo8WOjhCNFv9VFa8NaKqTa8SriPBo9RLZ4At9k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fxa7I7cLz+VN0jtido6iDyDG6WjasWRlmWqqz8TLjCeADMkiMTK7QfgK83lP8lsAX
	 hPB66xEJYgJIKJl3T8UE/flsxMsmAGU1hMtTK0Tvh5sJZfidt98Wv/1F/SDQcMjlV6
	 gkfzVsVZ5WBVAstSY/LX4Qcg2xAGxZLLBa2jQlae7dUdeUsbSpGYePcVEzHDkPP7X6
	 9wpk7BCUvKtZkVH49zi7BDhtrKWMr6CO9Gh6NsmxbaX4CLfMXhA5GIWuLKAPD2+Q9q
	 ELo/dg3/WJ7AWfRq31tyyYnfxopntHmSXzs3YC1pF47AHs8uBOi/vcKgk2dN11xDLn
	 WXQy7OuhFFwCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8FA0680BE8;
	Tue, 13 Oct 2026 01:54:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E3131E9
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:54:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 000EF4008B
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:54:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DltlFJnM0zy5 for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 01:53:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 244E14008C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791856439;
 b=UJGujv8801qBo+5qnm/oYUTiCQS+Ob+7KeVXaPjDTdpOtMwv+xXI6CASLDoFEeMJ2SIl
 MGx+xdvRX16hi28QSJzMjOIZmyJDjScsvy3VeoeyK6299pD8jZRdLqNGgrkHccEibezbe
 676yMn9kCB9SCnti7WAh7UpJjC1qzXdig4iAkiIe+RPNjK5teBgk7pkCU2heOZjoDg83b
 NJkeGI8FUA9q2w30aBmtsr0Y8T6YUfsD+vqGbwDjFRz6cjetn9D29seqUZz+FPQglwwAp
 wvTlEzBMZkvc6S7H0oJ5tvJw4pFTGcEpKLE9JdVJ4atqMsXnSZajO4xAj44oYvP71nQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791856439;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=QoEsfTo8WOjhCNFv9VFa8NaKqTa8SriPBo9RLZ4At9k=;
 b=mUpjjbZhYneDDwOevoRgB0mHLD7vwbASUn/o9mkn/WKCVCKHMqMVtttJN+YsKQ3Co8P5
 cXaQJIvlg1dxwCInVbecSOWl3vVv+QvKm6B43IWcHdWLMHfPxn0Zj9ewsyM+VDovsYj8X
 ZlhNvwlW5jHv94zUhxIuo/JnQt4Nmu1VS3E8IfeYXkm7GCcqQ5SF8TOO4Hl+9BZha99ND
 o4mrJQUw5C8+NDB7SKOnsJJC5o+8C6j6SUICNXZHpXQIGmaRU8FJWTF9OH/oX3mjiOyqp
 f50xnmPQFVuI1mkZmHwID8rBvpY8D8H8PBgLfAG1e0ieNOkYPuWT2KneT0kXjUcUulA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Hw7hCntc; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jFmYWdh5; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Hw7hCntc; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jFmYWdh5
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 244E14008C
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:58 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CJMtDM2384234
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QoEsfTo8WOjhCNFv9VFa8NaKqTa8SriPBo9RLZ4At9k=; b=Hw7hCntcQzJkDLe+
 umZt/fUzPSIcE++pESg8MOKPVCQWYwvVuMgWa19aaF+7eUIRzeEgynp+bojE4z7J
 XPq+2crmiRXQXIwkSxAdamGEQbB8JrehduZ4/sENwaA+BVXUbnRwZNLtrMLp9Uqy
 n2Y5Vn2kTNLrCYw6mfef5I3QuhB2rRiubUpBrQmhV10+/2gXWMrjHMEshoQgAsyp
 BOK/jgbajqklUs7/B/rT35T/s9/sU8sbtH9U08qe20KRuSO8D5VlCDQVBFNt400n
 8cnIYiZXbaJ2fQeiHT0D8hRHV2zeflejXzk+pIyAQI/0FmR3kBKP2JgqZ65i5WSk
 J6606Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8v7kuyxy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:53:57 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3510d0baf63so7142106eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 18:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791856437; x=1792461237;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QoEsfTo8WOjhCNFv9VFa8NaKqTa8SriPBo9RLZ4At9k=;
 b=jFmYWdh59kGoVlwEW0ImBtYPX7aV9xPDDq8SJU+AmElYYqUwqfiOsIVuOvnriQf8kc
 tT9A1yww8dbxaXu8zpedzcv/AKNevSfIkAloJKn1G4Njcp50SujFFWidZXoFELqtsQXd
 frsE2J1hXbtV8wPoGTDEp5kizDosGEu03f/UpRPACy9Cpwi8bYIehwLhT3KTEB7o1S6J
 WxSPtoBxunzh1welcDKJ6v9o1+9yt0NkNNdvNQSp0GEryrgzyZxtzc0gSdonMxVvhOzM
 tDhye4/183Q0rC3YjTdo3NJzIQE6Y8qFOpK7haSSYK1GOhmPA3RdZ+Fy8AIC4kGd8Gbw
 SsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791856437; x=1792461237;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QoEsfTo8WOjhCNFv9VFa8NaKqTa8SriPBo9RLZ4At9k=;
 b=upE2eVRHkWHP6/MSnOFnLiOJYicf6jQHM3i+hlJYj9bWfuvKME0K6vS5gyMH/Sm53G
 E0BSyHQzO5ezLZZuk32Deg0nBg8xuqal6AMvCr68rDRX55st1Z8vPFUxaBZUXkLa5Q2O
 k4RR62V16BfwueDahUJSnq2C9hYIQga5n/B+pRBpRcyilZlJMectqF1tD+msRPWlQwsn
 j1qV0RTIIZvKe6NAIXdlqIMRcRV6ug2CH1oG//v8kIL4xkVqoUaLtX1g4rgeroNMJvUL
 NRIol3HGxtcpRkvwBkk8NAvKElzwxsZ1IWmv00g/BFqcWKYmiFtdin+suzCS0bi+HM0y
 3jYg==
X-Gm-Message-State: AFq9FYJ28AFCxWPQJSTHo0oQ0FdGrD4DUwS2WzQZK2ji4ua8w9AxbBnz
 40TNIytjGbNXM+3cXldJvbBdSbWB/9C1Hg+42Cu0vwMghfJAFkxhjztWP+TciHqgI4++Phddwxk
 0Gl036B3a0TFHg+yFghDCtQdJ9vSGLt7ghZ8gsjMjedJ8/L190ORTJtzs3KrVyIA+MkS+XhM=
X-Gm-Gg: AYBFou1vK1SV30eG6ZPYORDTscov2FO4MSFWEHMR2wIUlXIv8XxlfYGlMs5YJsguMf5
 XBb2Onf2IkjaoMehT5b+3qp2LudbtOyZ5QzObfHtcPneIATY6g7m6hTKUHdmg0Tm8Er4Tfr0awH
 OomjHJVGCiqYBl+ivmColUwZk6QS5zi/SxlfiqhkhSA2afflUKHY5ji5LBKaoP21k7IaoAt+EMG
 UFiSWQVQjwNk+S6BebjdFORnXzCvzWNA+mvkuWxz4mMy/AV6Y68zVuWC1RDr1LU1TpvNBH/BF/Z
 DK/qWtayWw1ODnt+gY8OLZXv84OM0xIImwjAlNdSb/Hp/l6xqRLFTjJOCJw3qhXoJ7RLnXTDTca
 75SAnwfJ6cdYo9/mCMHGO86DFvxDalXLnUyh8gSQqgIqV4mRiwBrdYl9mfzq7yaaASBLU0vRq0w
 r0GKHRptxx2W7GYSX1N3ePIGfBeJM=
X-Received: by 2002:a05:693c:2509:b0:35b:a688:d17d with SMTP id
 5a478bee46e88-35ba688da7amr3478015eec.29.1791856436841; 
 Mon, 12 Oct 2026 18:53:56 -0700 (PDT)
X-Received: by 2002:a05:693c:2509:b0:35b:a688:d17d with SMTP id
 5a478bee46e88-35ba688da7amr3477975eec.29.1791856436177; 
 Mon, 12 Oct 2026 18:53:56 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb68e56sm34612666eec.29.2026.10.12.18.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 18:53:55 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 07:23:15 +0530
Subject: [PATCH v7 6/8] arch: arm: dts: remove Lemans EVK override DTS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-snagboot-v7-6-fc296a32836a@oss.qualcomm.com>
References: <20261013-snagboot-v7-0-fc296a32836a@oss.qualcomm.com>
In-Reply-To: <20261013-snagboot-v7-0-fc296a32836a@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791856396; l=1412;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=RlBhEl/QgjRmR/ppAjn1yX+sHTrgAqgvlHLzGSElyOM=;
 b=vSVx4whcIMGZK2f/7sbLLA1NjecHpBkRMhXLr55+6IOzYRm2gJLx5i0xWJ4WcNpi2pmfxxUS6
 QYlQrGXmAG6CzhgZy0pTmo+Ixbj2ox2VvO5e1MwOaWpOQrC5q/9hSgf
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAwNyBTYWx0ZWRfXzUAYaZkiyRxC
 dJVt16e5nZWD8O+vKtb59IrfGZShhetrQ6BlHkrD2CcbItQ/SOzKko4FNXkBqmNbcIWigjJS+S1
 507+11x1K9eZVS02DGODAhfGvkw4x6bMui9Ra50/EnXXLGvG/FogxqerjgJXOsxbF0bccWn6+Kz
 xLWCpJU+cxicQ4mzjOCYvGv4W/gbitTCytQG/JOLg0o+6NbrOPqc9qEgRsTksUziQXyEyJ99In2
 1D2ZAQrwHFT8XOnl3La4L+SUvFVuo/+6atA2XE2QBK5y/VkH4yvloR78CqwCQhOHwVZWiEx/CQc
 U0950+ofq4KHnzdfu/iI37PeKcmrq/XLW3H0GSQwuykN61A1he9iERF/eM1H5xASWaiE8GH+DzJ
 eK8HdU7HaLVFts9V2m+RX1LI2BkkvJqFxNubju/WIVg7I+Nq/twOPo9y0VGBelgG9GXgrhe3+ex
 tSXhSKBqi8lHKwvPUKA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAwNyBTYWx0ZWRfX77Vnx2THV/j8
 a55jR3zy0LYFl89W2tk/+5LjioYEDIH58HYhr3+sF/UGEe4hVN/e0ZwWMDaF/Z6nWB5p3WZOPcD
 PX/F25Lr67Cn9ChvtshAEIh2CfOtL04=
X-Authority-Analysis: v=2.4 cv=VOtIDNPX c=1 sm=1 tr=0 ts=6acd8f35 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ZgaKLAyxbO7a4fke8goA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: PlyNJZra8_UFr_YU56VULBISmZZrmvch
X-Proofpoint-ORIG-GUID: PlyNJZra8_UFr_YU56VULBISmZZrmvch
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130007
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

Remove Lemans EVK override dtsi: arch/arm/dts/lemans-evk-u-boot.dtsi
provided the following SMEM modernize series is picked:
https://lore.kernel.org/u-boot/20260618-b4-modernise-smem-v3-0-472391477988@linaro.org/

Memory node is not required as we can read the memory info from SMEM.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v7:
- No changes

Changes in v5:
- No changes

Changes in v4:
- Newly added in v4
---
 arch/arm/dts/lemans-evk-u-boot.dtsi | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/arm/dts/lemans-evk-u-boot.dtsi b/arch/arm/dts/lemans-evk-u-boot.dtsi
deleted file mode 100644
index cdd3d32f61a..00000000000
--- a/arch/arm/dts/lemans-evk-u-boot.dtsi
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: BSD-3-Clause
-/*
- * Copyright (c) 2026, Qualcomm Innovation Center, Inc. All rights reserved.
- */
-
-/ {
-	/* Will be removed when bootloader updates later */
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x0 0x80000000 0x0 0x3ee00000>,
-		      <0x0 0xc0000000 0x0 0x0fd00000>,
-		      <0xD 0x00000000 0x2 0x54100000>,
-		      <0xA 0x80000000 0x1 0x80000000>,
-		      <0x9 0x00000000 0x1 0x80000000>,
-		      <0x1 0x00000000 0x3 0x00000000>,
-		      <0x0 0xd0000000 0x0 0x01900000>,
-		      <0x0 0xd3500000 0x0 0x2cb00000>;
-	};
-};

-- 
2.34.1

