Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E98606A321
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RMUAenyy;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iE9QVC8n;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kczfjz6/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BFA93607FF;
	Tue, 24 Nov 2026 16:47:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XO7HM_gSnLRP; Tue, 24 Nov 2026 16:47:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 38E026069B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795538843;
	b=gX4Ti8iD15+g3+eb2Ap5t5u1/9PlpbA+PwfaLXCXnJOdeL4oVOhpn5V3uGvi3xDdc6WZ
	 r9k4EjxJdz/1SzOCCfGWQvRFYNlzvIKQiHlMcRPAD+k3TMK0bw2fyajhFy6FUCuakGwYw
	 DEf4CyrygI0Gy6J/sr6mWuRM6NsAtEiep0ndJH+T0DGANOFJd9F+xp3ZgMH64kOdmj4iT
	 CZZ8kmFOquoDnZIHcEaqDTjv3z0c8JB7ABmm6s1BB2/vw/9OBuCCrmzERGTy1ZrTWp2vE
	 KSdT9uzjjP/KYqHTkimQllXI45/crZhdVczKfrJT68Dh9aj4mA9juIMu9H2rrFNi0qg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795538843;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IbHO5Px37rhkdumqN31GteBLcsg3CBdTgzZS4DyAFso=;
	b=bblLImVQxKTP1QNxLH5nEUlLvp1fqLco167OMxa0MV0b1rmw/O8Eo5Xfvuq9AAVVoDTP
	 uMRiPt0A5m3VmR67ZNZYAnLn2/1yoTsKFC3D/VBG+RNf3985HG5i58L+8V18qzWBDM8gE
	 PGbrcS9TKh0B/+DYbmV8JceDEEceiiVz7s/cH/JtNh+FtCMvr8SC8HteLsizyLRP5FT/Y
	 DjNomQdbmtM5m/X5HCMralVKdWzA9QTB8SLN4BQBHMlU+W8wWcc+mvK6Awd+JFmkI2blw
	 ebJqOujgx2RmazMOjM+WNUi613NV/3mj+UbxG1SaUoH380vaYNL1SyPb0kp7OwPpVOA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795538843;
	bh=IbHO5Px37rhkdumqN31GteBLcsg3CBdTgzZS4DyAFso=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RMUAenyyBHXdhjVGFqAdJAikS4v83F/YhN3i1UVtRrQpCY/4yN4JTti2iBnXRGiQS
	 uV9o1a67YxA9ZZrOx0RE61VU84Wko0h3hzqfY/b26Z9T7BYRefvbaQRmy7AQHxm1R2
	 kEV1sVz7S5tieKojpAKTC8x3jo5eZQYH996VlmO1+xLhAfJ4qSFQgTL/azo37jShS2
	 sZ29r9jsckFyGPti4tnbV0/2nuBRwKjbsysr0JeqSA1kqpsdeEaJqkPpCp5Fh8794i
	 jJDEiUouU5xf2UhUl9/43ENpe3bjN8Af0SH7JBi9oZKIWf91kk1OC6WA+YK4L4qhrC
	 7r7AcizENfcPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 38E026069B;
	Tue, 24 Nov 2026 16:47:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3633C371
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1FB874018D
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1lRRSCO3ExF7 for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 16:47:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C915A400B3
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=iE9QVC8n; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=kczfjz6/
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C915A400B3
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:18 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOFLVXQ1331862
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IbHO5Px37rh
 kdumqN31GteBLcsg3CBdTgzZS4DyAFso=; b=iE9QVC8nxGrwta/Ib/wob9TFEeX
 aqeTqV0VK5OVAZ54a5qTM+7ebpui4eUNIs9VD9jA3xqKdF8IDGgwgMTEa+sRFXsl
 uI78am1eWfep3rudIBikS7oG+mKWOf9dQ9+BTLcH1XPaQAjN1BnHa1L6hCkPBrkX
 ZPycYvbSfrKhgz6vUJgWUMixWddW6IyFW4rLQWCQqDImv/8mdm9qgavStjprieXn
 4Rqx6IQusixFUSVcQMmP5jWp5YwXo2DPZIwkGv15RPjwuPWIBqasHsM/3gUUiNDq
 SJ91fRg4shIPgrI2Am9gr4g7ShAxIu32i+Ig11dKFs6GfL9yfWOpBZKuA2w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4yvb3vpn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:17 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-38531c1a566so4250098eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795538836; x=1796143636;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IbHO5Px37rhkdumqN31GteBLcsg3CBdTgzZS4DyAFso=;
 b=kczfjz6/3cEc+CDlpzDCw1qc0M4R3Je6WxjKvb0FBatmAcSzXB6THePCXF+nb0gIdX
 luG5PG3f+YGjf54Z72uatDoekQ4G/OYUp08SSPsrXHpEc0mly4jsunSvTDKc3gfe12+e
 vOGsp1Z0AUNWAg4oLU/de7ts6HgDtejK7ICEDm3zZA6tOIAKFsWnZkYt1fXRIlZW/H5d
 dZJZ3N+enV1HiXp2+EQ9Z+uE437VL9gHR8Vn80Bbj5BYW+v8T3lUhxZ2SIkpX6RhDC2/
 CEpOoHzrgfI9qyhe4Q1RZXMdkIFUktjETsHgMTEU6L0wdb+qKeRtvBwo4Qlp9vMu/6iV
 6Uvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795538836; x=1796143636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IbHO5Px37rhkdumqN31GteBLcsg3CBdTgzZS4DyAFso=;
 b=yClcjmWpxB9GZEoUz1N8glabDCSjORpJqSEGp19oOXlcpduFl3y3o/Zcw5uePNZEeC
 SJhSlgKgFTAyK/HReZ9WyaofGl7wB4mYXdlFpaZ6er/d8wAZAZiswVS3o0zbDaY2mid9
 NXjiPlP8c44Jhl/qHurruJMH4xzlZLmbUFS7pgyvAVeoISptTWTDDVMS46ga+9m0biBM
 jI39sQYxKOsQ3Ac2fRh/1Lp8/1dXmqxnBTWAvnGtbjYHzx45yfcqdjopNhPBJtUmJHGo
 hg3EQy9/f6Rzh1UdCQZRs0BzX6Y72m7sWE8mjlXgrZNViD07IVGLWflrGqWmphJKPO9l
 z5vg==
X-Forwarded-Encrypted: i=1;
 AL+hErHP4tbttDxBk/r9xjuQ7R8hch6Baq8kiiep1zRuWGbKo1mI3qayeCkZVFGLa78SSvS0lGxfqI0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/2fVRcyhwM/6WWeEKn/krrg9Vx+T8PoKsnr7kmMUfYRBEmQCgd
 1JuqDY44g6EvsKNP+mxCcFFzUK9xE0A9xv8kQjYt0+aIdqoDM4M/ikEG5HH6fZb5AsWjOyBTr8Y
 IwYM11W2vnaeZNA+Iplu3IupDqriLjiBbORfaYUxeGUHNHV5KBcHHkRk6ejw+UehbcYb6EX8=
X-Gm-Gg: AZFdTZdW3Wz8Ki1mbOfWUoXnV2E9VlCe/x++vSMouT/Y6vIAwPP9MUQwgPfhPmDD707
 qSEci7kDjab1aOTV+I0OV7jYyHD+O7ibrrj8p6ZvO0+PT32VE9/i4qRvlYeMqiiVfJAzXPHZ0yW
 LoKyBDTRV7GAwcd+WWAPB1mGLq0P6h2ApOREDLx7vAMZPc5gx6DQmHy2iJ7owlxZRmSz4yAifv2
 6b6YYE4QDN7n/vmiGInf3YK6+WC2QW6XvzjbKij/mUBXNwL/p1RLeKvR85a8rbhd+WAlg9n8XUq
 olGuom5yLapu/1nAU3/UBMylvveXrX/XIDZCnBALx2+jS9XwAetL/z3QEfklTaOSj7E5nglXefj
 yWJ2C6W4VYpm7qkQGXZfuMedA4RI0tm5Y863OlbYdBAHu+icThd4h6810LvWuQNw1vsUS02RO06
 DCPdakYUFaR6OG1uGRQgt7GtTDg9OgFNzOIW8Sl/kf8ceeQG6gL9At87VuXlAWRjnF/Tq4
X-Received: by 2002:a05:693c:8083:b0:376:6530:248f with SMTP id
 5a478bee46e88-38570a3717dmr18099362eec.24.1795538835596; 
 Tue, 24 Nov 2026 08:47:15 -0800 (PST)
X-Received: by 2002:a05:693c:8083:b0:376:6530:248f with SMTP id
 5a478bee46e88-38570a3717dmr18099308eec.24.1795538834834; 
 Tue, 24 Nov 2026 08:47:14 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566cd40c5sm55365072eec.10.2026.11.24.08.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 08:47:14 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, balaji.selvanathan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, quentin.schulz@cherry.de,
 william.bright@imd-tec.com, nikroks@mainlining.org,
 macpaul.lin@mediatek.com, dlechner@baylibre.com, xerikasxx@gmail.com,
 jbx6244@gmail.com, u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v6 1/9] clk: qcom: add GCC clock driver support for shikra SoC
Date: Tue, 24 Nov 2026 22:16:52 +0530
Message-Id: <20261124164700.1606518-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124164700.1606518-1-aswin.murugan@oss.qualcomm.com>
References: <20261124164700.1606518-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aJ1lOr9m c=1 sm=1 tr=0 ts=6b05bf95 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=p3-4Csf5Jppavy1jNJYA:9 a=bBxd6f-gb0O0v-kibOvt:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 2rpuDEbzU5zvV23kSiCqEjbYSXCUl_wq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2NSBTYWx0ZWRfX4EvnHx30bHnL
 n/2AbMDHUUTkSKNtSnOOWWsLaIWPeR1hbwbY4wdos5eJiOTsjFD+ZdgxvMepvFaAWn9EbaJrGaK
 KAjTUsssk80gKkDGl/l4IDmPAjwvsvw=
X-Proofpoint-GUID: 2rpuDEbzU5zvV23kSiCqEjbYSXCUl_wq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2NSBTYWx0ZWRfX7Wr4gw2cSLvu
 E8yddAFK2RSi4feU4WnzmFhwkEIaDZL9G/khuXHtqEM5EtXTtmQwYUNCmv4Je0DrulzgNr7XR/2
 RYhwuLG4UUKbPzki7Ucxgn/tw8KuDNhvCb7TqNQQoxTdYIb0wou/2TmU1XU153mLgMWT8BajfYM
 SDUzRcOZ3X1rvcCBcye8w5jNhv6XCVJ4BMU01kcJ7etCogaocs4e1XPfNYkcMB3Q5591ZffaF/v
 yhZFkJ04T2Sx3yddYNeA5hMrVlRMWGNOLjghDDLjqJNwjGRh9XNFkv7RLo7Q3Q0+Ygo/ELeUDSu
 QJKiIbRA5ZhEYkX0lbsSHZymYvpIYD7x1ob52QsEtgtp8O+YkDQ6kiujYfBvti1bs5YYiXAA09p
 5fhK2mjC+QK4dwlhXoqEPXASeEK2JHh/ri5+HPsqyWfvkJJ8ZfiIvX+LVx/q6gbhR7WaG0+RCoK
 j0USzE13FPoDW3D2h5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240065
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

Add initial support for the Global Clock Controller (GCC) on
Qualcomm Shikra SoC.

This introduces a new clock driver (clock-shikra.c) implementing
the required clocks for early boot and peripheral enablement.
Update Kconfig and Makefile to include the Shikra GCC clock
driver in the build.

The driver currently provides basic clock definitions required
for system initialization.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig        |   8 +
 drivers/clk/qcom/Makefile       |   1 +
 drivers/clk/qcom/clock-shikra.c | 344 ++++++++++++++++++++++++++++++++
 3 files changed, 353 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-shikra.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 0d8f5028a4e..2ff0d8c99b3 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -113,6 +113,14 @@ config CLK_QCOM_SDM845
 	  on the Snapdragon 845 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_SHIKRA
+	bool "Qualcomm Shikra GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Shikra SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 config CLK_QCOM_SM6115
 	bool "Qualcomm SM6115 GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 73cafc3f938..11d6c85af3f 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_CLK_QCOM_RPMH) += clock-rpmh.o
 obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
 obj-$(CONFIG_CLK_QCOM_SC7180) += clock-sc7180.o
 obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
+obj-$(CONFIG_CLK_QCOM_SHIKRA) += clock-shikra.o
 obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
 obj-$(CONFIG_CLK_QCOM_SM6125) += clock-sm6125.o
 obj-$(CONFIG_CLK_QCOM_SM6350) += clock-sm6350.o
diff --git a/drivers/clk/qcom/clock-shikra.c b/drivers/clk/qcom/clock-shikra.c
new file mode 100644
index 00000000000..edf001d81a1
--- /dev/null
+++ b/drivers/clk/qcom/clock-shikra.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/types.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,shikra-gcc.h>
+#include "clock-qcom.h"
+
+#define GCC_QUPV3_WRAP0_S0_CLK_CMD_RCGR	0x1f148
+#define GCC_SDCC1_APPS_CLK_CMD_RCGR		0x38028
+#define GCC_SDCC2_APPS_CLK_CMD_RCGR		0x1e00c
+#define GCC_USB30_PRIM_MASTER_CLK_CMD_RCGR	0x1a01c
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0x1a034
+#define GCC_USB3_PRIM_PHY_AUX_CLK_CMD_RCGR	0x1a060
+
+static const struct pll_vote_clk gpll6_vote_clk = {
+	.status = 0x6024,
+	.status_bit = BIT(31),
+	.ena_vote = 0x79000,
+	.vote_bit = BIT(6),
+};
+
+static const struct pll_vote_clk gpll7_vote_clk = {
+	.status = 0x7024,
+	.status_bit = BIT(31),
+	.ena_vote = 0x79000,
+	.vote_bit = BIT(7),
+};
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
+	F(7372800, CFG_CLK_SRC_GPLL0_AUX2, 1, 384, 15625),
+	F(14745600, CFG_CLK_SRC_GPLL0_AUX2, 1, 768, 15625),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(29491200, CFG_CLK_SRC_GPLL0_AUX2, 1, 1536, 15625),
+	F(32000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 8, 75),
+	F(48000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 4, 25),
+	F(64000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 16, 75),
+	F(75000000, CFG_CLK_SRC_GPLL0_AUX2, 4, 0, 0),
+	F(80000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 4, 15),
+	F(96000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 8, 25),
+	F(100000000, CFG_CLK_SRC_GPLL0_AUX2, 3, 0, 0),
+	F(102400000, CFG_CLK_SRC_GPLL0_AUX2, 1, 128, 375),
+	F(112000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 28, 75),
+	F(117964800, CFG_CLK_SRC_GPLL0_AUX2, 1, 6144, 15625),
+	F(120000000, CFG_CLK_SRC_GPLL0_AUX2, 2.5, 0, 0),
+	F(128000000, CFG_CLK_SRC_GPLL6, 3, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_sdcc1_apps_clk_src[] = {
+	F(144000, CFG_CLK_SRC_CXO, 16, 3, 25),
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(20000000, CFG_CLK_SRC_GPLL0_AUX2, 5, 1, 3),
+	F(25000000, CFG_CLK_SRC_GPLL0_AUX2, 6, 1, 2),
+	F(50000000, CFG_CLK_SRC_GPLL0_AUX2, 6, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0_AUX2, 3, 0, 0),
+	F(192000000, CFG_CLK_SRC_GPLL6, 2, 0, 0),
+	F(384000000, CFG_CLK_SRC_GPLL6, 1, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(25000000, CFG_CLK_SRC_GPLL0_AUX2, 12, 0, 0),
+	F(50000000, CFG_CLK_SRC_GPLL0_AUX2, 6, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0_AUX2, 3, 0, 0),
+	F(202000000, CFG_CLK_SRC_GPLL7, 4, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
+	F(66666667, CFG_CLK_SRC_GPLL0_AUX2, 4.5, 0, 0),
+	F(133333333, CFG_CLK_SRC_GPLL0, 4.5, 0, 0),
+	F(200000000, CFG_CLK_SRC_GPLL0, 3, 0, 0),
+	F(240000000, CFG_CLK_SRC_GPLL0, 2.5, 0, 0),
+	{ }
+};
+
+static ulong shikra_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
+
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP0_S0_CLK:
+		/*
+		 * ftbl_gcc_qupv3_wrap0_s0_clk_src[]'s last entry is
+		 * GPLL6-sourced; vote defensively even though this port's
+		 * only requested rate (debug_uart_clock, 14745600) resolves
+		 * to the GPLL0-sourced entry.
+		 */
+		clk_enable_gpll0(priv->base, &gpll6_vote_clk);
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, GCC_QUPV3_WRAP0_S0_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_SDCC1_APPS_CLK:
+		clk_enable_gpll0(priv->base, &gpll6_vote_clk);
+		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC1_APPS_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_SDCC2_APPS_CLK:
+		clk_enable_gpll0(priv->base, &gpll7_vote_clk);
+		freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC2_APPS_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_USB30_PRIM_MASTER_CLK:
+		freq = qcom_find_freq(ftbl_gcc_usb30_prim_master_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, GCC_USB30_PRIM_MASTER_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		clk_rcg_set_rate(priv->base, GCC_USB3_PRIM_PHY_AUX_CLK_CMD_RCGR,
+				 0, CFG_CLK_SRC_CXO);
+		return freq->freq;
+	case GCC_USB30_PRIM_MOCK_UTMI_CLK:
+		WARN(rate != 19200000,
+		     "Unexpected rate for USB30_PRIM_MOCK_UTMI_CLK: %lu\n", rate);
+		clk_rcg_set_rate(priv->base, GCC_USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR,
+				 0, CFG_CLK_SRC_CXO);
+		return rate;
+	default:
+		return 0;
+	}
+}
+
+static const struct gate_clk shikra_clks[] = {
+	GATE_CLK(GCC_AHB2PHY_CSI_CLK, 0x1d004, BIT(0)),
+	GATE_CLK_POLLED(GCC_AHB2PHY_USB_CLK, 0x1d008, BIT(0), 0x1d008),
+	GATE_CLK_POLLED(GCC_BOOT_ROM_AHB_CLK, 0x7900c, BIT(1), 0x23004),
+	GATE_CLK_POLLED(GCC_CAMSS_AXI_CLK, 0x58044, BIT(0), 0x58044),
+	GATE_CLK(GCC_CAMSS_CAMNOC_ATB_CLK, 0x5804c, BIT(0)),
+	GATE_CLK_POLLED(GCC_CAMSS_CAMNOC_DRAGONLINK_ATB_CLK, 0x58060, BIT(0), 0x58060),
+	GATE_CLK(GCC_CAMSS_CAMNOC_NTS_XO_CLK, 0x58050, BIT(0)),
+	GATE_CLK_POLLED(GCC_CAMSS_CCI_0_CLK, 0x56018, BIT(0), 0x56018),
+	GATE_CLK_POLLED(GCC_CAMSS_CPHY_0_CLK, 0x52088, BIT(0), 0x52088),
+	GATE_CLK_POLLED(GCC_CAMSS_CPHY_1_CLK, 0x5208c, BIT(0), 0x5208c),
+	GATE_CLK_POLLED(GCC_CAMSS_CSI0PHYTIMER_CLK, 0x45018, BIT(0), 0x45018),
+	GATE_CLK_POLLED(GCC_CAMSS_CSI1PHYTIMER_CLK, 0x45034, BIT(0), 0x45034),
+	GATE_CLK_POLLED(GCC_CAMSS_MCLK0_CLK, 0x51018, BIT(0), 0x51018),
+	GATE_CLK_POLLED(GCC_CAMSS_MCLK1_CLK, 0x51034, BIT(0), 0x51034),
+	GATE_CLK_POLLED(GCC_CAMSS_MCLK2_CLK, 0x51050, BIT(0), 0x51050),
+	GATE_CLK_POLLED(GCC_CAMSS_MCLK3_CLK, 0x5106c, BIT(0), 0x5106c),
+	GATE_CLK_POLLED(GCC_CAMSS_NRT_AXI_CLK, 0x58054, BIT(0), 0x58054),
+	GATE_CLK_POLLED(GCC_CAMSS_OPE_AHB_CLK, 0x5503c, BIT(0), 0x5503c),
+	GATE_CLK_POLLED(GCC_CAMSS_OPE_CLK, 0x5501c, BIT(0), 0x5501c),
+	GATE_CLK_POLLED(GCC_CAMSS_RT_AXI_CLK, 0x5805c, BIT(0), 0x5805c),
+	GATE_CLK_POLLED(GCC_CAMSS_TFE_0_CLK, 0x5201c, BIT(0), 0x5201c),
+	GATE_CLK_POLLED(GCC_CAMSS_TFE_0_CPHY_RX_CLK, 0x5207c, BIT(0), 0x5207c),
+	GATE_CLK_POLLED(GCC_CAMSS_TFE_0_CSID_CLK, 0x520ac, BIT(0), 0x520ac),
+	GATE_CLK_POLLED(GCC_CAMSS_TFE_1_CLK, 0x5203c, BIT(0), 0x5203c),
+	GATE_CLK_POLLED(GCC_CAMSS_TFE_1_CPHY_RX_CLK, 0x52080, BIT(0), 0x52080),
+	GATE_CLK_POLLED(GCC_CAMSS_TFE_1_CSID_CLK, 0x520cc, BIT(0), 0x520cc),
+	GATE_CLK_POLLED(GCC_CAMSS_TOP_AHB_CLK, 0x58028, BIT(0), 0x58028),
+	GATE_CLK_POLLED(GCC_CAM_THROTTLE_NRT_CLK, 0x79004, BIT(16), 0x17070),
+	GATE_CLK_POLLED(GCC_CAM_THROTTLE_RT_CLK, 0x79004, BIT(15), 0x1706c),
+	GATE_CLK_POLLED(GCC_CFG_NOC_USB2_PRIM_AXI_CLK, 0x111c4, BIT(0), 0x111c4),
+	GATE_CLK_POLLED(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x1a07c, BIT(0), 0x1a07c),
+	GATE_CLK(GCC_DDRSS_GPU_AXI_CLK, 0x71000, BIT(0)),
+	GATE_CLK_POLLED(GCC_DDRSS_MEMNOC_PCIE_SF_CLK, 0x29044, BIT(0), 0x29044),
+	GATE_CLK(GCC_DISP_GPLL0_DIV_CLK_SRC, 0x79004, BIT(11)),
+	GATE_CLK_POLLED(GCC_DISP_HF_AXI_CLK, 0x17020, BIT(0), 0x17020),
+	GATE_CLK_POLLED(GCC_DISP_THROTTLE_CORE_CLK, 0x79004, BIT(13), 0x17064),
+	GATE_CLK_POLLED(GCC_EMAC0_AHB_CLK, 0xad010, BIT(0), 0xad010),
+	GATE_CLK_POLLED(GCC_EMAC0_AXI_CLK, 0xad014, BIT(0), 0xad014),
+	GATE_CLK_POLLED(GCC_EMAC0_AXI_SYS_NOC_CLK, 0x109d4, BIT(0), 0x109d4),
+	GATE_CLK(GCC_EMAC0_CC_SGMIIPHY_RX_CLK, 0xad044, BIT(0)),
+	GATE_CLK(GCC_EMAC0_CC_SGMIIPHY_TX_CLK, 0xad03c, BIT(0)),
+	GATE_CLK_POLLED(GCC_EMAC0_PHY_AUX_CLK, 0xad018, BIT(0), 0xad018),
+	GATE_CLK_POLLED(GCC_EMAC0_PTP_CLK, 0xad034, BIT(0), 0xad034),
+	GATE_CLK_POLLED(GCC_EMAC0_RGMII_CLK, 0xad038, BIT(0), 0xad038),
+	GATE_CLK_POLLED(GCC_EMAC1_AHB_CLK, 0xae010, BIT(0), 0xae010),
+	GATE_CLK_POLLED(GCC_EMAC1_AXI_CLK, 0xae014, BIT(0), 0xae014),
+	GATE_CLK_POLLED(GCC_EMAC1_AXI_SYS_NOC_CLK, 0x109f4, BIT(0), 0x109f4),
+	GATE_CLK(GCC_EMAC1_CC_SGMIIPHY_RX_CLK, 0xae044, BIT(0)),
+	GATE_CLK(GCC_EMAC1_CC_SGMIIPHY_TX_CLK, 0xae03c, BIT(0)),
+	GATE_CLK_POLLED(GCC_EMAC1_PHY_AUX_CLK, 0xae018, BIT(0), 0xae018),
+	GATE_CLK_POLLED(GCC_EMAC1_PTP_CLK, 0xae034, BIT(0), 0xae034),
+	GATE_CLK_POLLED(GCC_EMAC1_RGMII_CLK, 0xae038, BIT(0), 0xae038),
+	GATE_CLK_POLLED(GCC_GP1_CLK, 0x4d000, BIT(0), 0x4d000),
+	GATE_CLK_POLLED(GCC_GP2_CLK, 0x4e000, BIT(0), 0x4e000),
+	GATE_CLK_POLLED(GCC_GP3_CLK, 0x4f000, BIT(0), 0x4f000),
+	GATE_CLK(GCC_GPU_GPLL0_CLK_SRC, 0x7900c, BIT(18)),
+	GATE_CLK(GCC_GPU_GPLL0_DIV_CLK_SRC, 0x7900c, BIT(19)),
+	GATE_CLK_POLLED(GCC_GPU_MEMNOC_GFX_CLK, 0x3600c, BIT(0), 0x3600c),
+	GATE_CLK_POLLED(GCC_GPU_SMMU_VOTE_CLK, 0x7d000, BIT(0), 0x7d000),
+	GATE_CLK_POLLED(GCC_GPU_SNOC_DVM_GFX_CLK, 0x36018, BIT(0), 0x36018),
+	GATE_CLK_POLLED(GCC_GPU_THROTTLE_CORE_CLK, 0x7900c, BIT(21), 0x36048),
+	GATE_CLK_POLLED(GCC_MMU_TCU_VOTE_CLK, 0x7d06c, BIT(0), 0x7d06c),
+	GATE_CLK_POLLED(GCC_PCIE_AUX_CLK, 0x79018, BIT(0), 0xaf044),
+	GATE_CLK_POLLED(GCC_PCIE_CFG_AHB_CLK, 0x7900c, BIT(27), 0xaf010),
+	GATE_CLK(GCC_PCIE_CLKREF_EN, 0xb8000, BIT(0)),
+	GATE_CLK_POLLED(GCC_PCIE_MSTR_AXI_CLK, 0x7900c, BIT(30), 0xaf020),
+	GATE_CLK_POLLED(GCC_PCIE_PIPE_CLK, 0x79018, BIT(2), 0xaf050),
+	GATE_CLK_POLLED(GCC_PCIE_RCHNG_PHY_CLK, 0x7900c, BIT(31), 0xaf040),
+	GATE_CLK_POLLED(GCC_PCIE_SLEEP_CLK, 0x79018, BIT(1), 0xaf04c),
+	GATE_CLK_POLLED(GCC_PCIE_SLV_AXI_CLK, 0x7900c, BIT(29), 0xaf018),
+	GATE_CLK_POLLED(GCC_PCIE_SLV_Q2A_AXI_CLK, 0x7900c, BIT(28), 0xaf014),
+	GATE_CLK_POLLED(GCC_PCIE_TBU_CLK, 0x79018, BIT(6), 0xaf098),
+	GATE_CLK_POLLED(GCC_PCIE_THROTTLE_CORE_CLK, 0x79018, BIT(5), 0xaf094),
+	GATE_CLK_POLLED(GCC_PCIE_THROTTLE_XO_CLK, 0x79018, BIT(4), 0xaf090),
+	GATE_CLK_POLLED(GCC_PCIE_TILE_AXI_SYS_NOC_CLK, 0x10f2c, BIT(0), 0x10f2c),
+	GATE_CLK_POLLED(GCC_PDM2_CLK, 0x2000c, BIT(0), 0x2000c),
+	GATE_CLK_POLLED(GCC_PDM_AHB_CLK, 0x20004, BIT(0), 0x20004),
+	GATE_CLK_POLLED(GCC_PDM_XO4_CLK, 0x20008, BIT(0), 0x20008),
+	GATE_CLK_POLLED(GCC_PWM0_XO512_CLK, 0x2002c, BIT(0), 0x2002c),
+	GATE_CLK_POLLED(GCC_QMIP_CAMERA_NRT_AHB_CLK, 0x79004, BIT(9), 0x17014),
+	GATE_CLK_POLLED(GCC_QMIP_CAMERA_RT_AHB_CLK, 0x79004, BIT(12), 0x17060),
+	GATE_CLK_POLLED(GCC_QMIP_DISP_AHB_CLK, 0x79004, BIT(10), 0x17018),
+	GATE_CLK_POLLED(GCC_QMIP_GPU_CFG_AHB_CLK, 0x7900c, BIT(20), 0x36040),
+	GATE_CLK_POLLED(GCC_QMIP_PCIE_CFG_AHB_CLK, 0x79018, BIT(3), 0xaf08c),
+	GATE_CLK_POLLED(GCC_QMIP_VIDEO_VCODEC_AHB_CLK, 0x79004, BIT(8), 0x17010),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_CORE_2X_CLK, 0x79004, BIT(21), 0x1f014),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_CORE_CLK, 0x79004, BIT(20), 0x1f00c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S0_CLK, 0x79004, BIT(22), 0x1f144),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S1_CLK, 0x79004, BIT(23), 0x1f274),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S2_CLK, 0x79004, BIT(24), 0x1f3a4),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S3_CLK, 0x79004, BIT(25), 0x1f4d4),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S4_CLK, 0x79004, BIT(26), 0x1f604),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S5_CLK, 0x79004, BIT(27), 0x1f734),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S6_CLK, 0x79004, BIT(28), 0x1f864),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S7_CLK, 0x79004, BIT(29), 0x1f994),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S8_CLK, 0x79004, BIT(30), 0x1fac4),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S9_CLK, 0x79004, BIT(31), 0x1fbf4),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_0_M_AHB_CLK, 0x79004, BIT(18), 0x1f004),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_0_S_AHB_CLK, 0x79004, BIT(19), 0x1f008),
+	GATE_CLK_POLLED(GCC_SDCC1_AHB_CLK, 0x38008, BIT(0), 0x38008),
+	GATE_CLK_POLLED(GCC_SDCC1_APPS_CLK, 0x38004, BIT(0), 0x38004),
+	GATE_CLK_POLLED(GCC_SDCC1_ICE_CORE_CLK, 0x3800c, BIT(0), 0x3800c),
+	GATE_CLK_POLLED(GCC_SDCC2_AHB_CLK, 0x1e008, BIT(0), 0x1e008),
+	GATE_CLK_POLLED(GCC_SDCC2_APPS_CLK, 0x1e004, BIT(0), 0x1e004),
+	GATE_CLK_POLLED(GCC_SYS_NOC_USB2_PRIM_AXI_CLK, 0x10a14, BIT(0), 0x10a14),
+	GATE_CLK_POLLED(GCC_SYS_NOC_USB3_PRIM_AXI_CLK, 0x1a078, BIT(0), 0x1a078),
+	GATE_CLK_POLLED(GCC_TSCSS_AHB_CLK, 0xac024, BIT(0), 0xac024),
+	GATE_CLK_POLLED(GCC_TSCSS_CNTR_CLK, 0xac020, BIT(0), 0xac020),
+	GATE_CLK_POLLED(GCC_TSCSS_ETU_CLK, 0xac01c, BIT(0), 0xac01c),
+	GATE_CLK(GCC_UFS_CLKREF_EN, 0x8c000, BIT(0)),
+	GATE_CLK_POLLED(GCC_USB20_MASTER_CLK, 0xb0010, BIT(0), 0xb0010),
+	GATE_CLK_POLLED(GCC_USB20_MOCK_UTMI_CLK, 0xb001c, BIT(0), 0xb001c),
+	GATE_CLK_POLLED(GCC_USB20_SLEEP_CLK, 0xb0018, BIT(0), 0xb0018),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_MASTER_CLK, 0x1a010, BIT(0), 0x1a010),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1a018, BIT(0), 0x1a018),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_SLEEP_CLK, 0x1a014, BIT(0), 0x1a014),
+	GATE_CLK(GCC_USB3_PRIM_CLKREF_EN, 0x9f000, BIT(0)),
+	GATE_CLK_POLLED(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1a054, BIT(0), 0x1a054),
+	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0x1a058, BIT(0)),
+	GATE_CLK_POLLED(GCC_VCODEC0_AXI_CLK, 0x6e008, BIT(0), 0x6e008),
+	GATE_CLK_POLLED(GCC_VENUS_AHB_CLK, 0x6e010, BIT(0), 0x6e010),
+	GATE_CLK_POLLED(GCC_VENUS_CTL_AXI_CLK, 0x6e004, BIT(0), 0x6e004),
+	GATE_CLK_POLLED(GCC_VIDEO_AXI0_CLK, 0x1701c, BIT(0), 0x1701c),
+	GATE_CLK_POLLED(GCC_VIDEO_THROTTLE_CORE_CLK, 0x79004, BIT(14), 0x17068),
+	GATE_CLK(GCC_VIDEO_VCODEC0_SYS_CLK, 0x6d044, BIT(0)),
+	GATE_CLK_POLLED(GCC_VIDEO_VENUS_CTL_CLK, 0x6d02c, BIT(0), 0x6d02c),
+};
+
+static int shikra_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (priv->data->num_clks < clk->id) {
+		debug("%s: unknown clk id %lu\n", __func__, clk->id);
+		return 0;
+	}
+
+	debug("%s: clk %ld: %s\n", __func__, clk->id, shikra_clks[clk->id].name);
+
+	return qcom_gate_clk_en(priv, clk->id);
+}
+
+static const struct qcom_reset_map shikra_gcc_resets[] = {
+	[GCC_CAMSS_OPE_BCR] = { 0x55000 },
+	[GCC_CAMSS_TFE_BCR] = { 0x52000 },
+	[GCC_CAMSS_TOP_BCR] = { 0x58000 },
+	[GCC_EMAC0_BCR] = { 0xad000 },
+	[GCC_EMAC1_BCR] = { 0xae000 },
+	[GCC_GPU_BCR] = { 0x36000 },
+	[GCC_MMSS_BCR] = { 0x17000 },
+	[GCC_PCIE_BCR] = { 0xaf000 },
+	[GCC_PCIE_PHY_BCR] = { 0xb1000 },
+	[GCC_PDM_BCR] = { 0x20000 },
+	[GCC_QUPV3_WRAPPER_0_BCR] = { 0x1f000 },
+	[GCC_QUSB2PHY_PRIM_BCR] = { 0x1c000 },
+	[GCC_QUSB2PHY_SEC_BCR] = { 0x1c004 },
+	[GCC_SDCC1_BCR] = { 0x38000 },
+	[GCC_SDCC2_BCR] = { 0x1e000 },
+	[GCC_TSCSS_BCR] = { 0xac000 },
+	[GCC_USB20_BCR] = { 0xb0000 },
+	[GCC_USB30_PRIM_BCR] = { 0x1a000 },
+	[GCC_USB3PHY_PHY_PRIM_SP0_BCR] = { 0x1b008 },
+	[GCC_USB3_DP_PHY_PRIM_BCR] = { 0x1b020 },
+	[GCC_USB3_PHY_PRIM_SP0_BCR] = { 0x1b000 },
+	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x1d000 },
+	[GCC_VCODEC0_BCR] = { 0x6d034 },
+	[GCC_VENUS_BCR] = { 0x6d018 },
+	[GCC_VIDEO_INTERFACE_BCR] = { 0x6e000 },
+};
+
+static const struct qcom_power_map shikra_gdscs[] = {
+	[GCC_CAMSS_TOP_GDSC] = { 0x58004 },
+	[GCC_EMAC0_GDSC] = { 0xad004 },
+	[GCC_EMAC1_GDSC] = { 0xae004 },
+	[GCC_PCIE_GDSC] = { 0xaf004 },
+	[GCC_USB20_GDSC] = { 0xb0004 },
+	[GCC_USB30_PRIM_GDSC] = { 0x1a004 },
+	[GCC_VCODEC0_GDSC] = { 0x6d038 },
+	[GCC_VENUS_GDSC] = { 0x6d01c },
+};
+
+static struct msm_clk_data shikra_gcc_data = {
+	.resets = shikra_gcc_resets,
+	.num_resets = ARRAY_SIZE(shikra_gcc_resets),
+	.clks = shikra_clks,
+	.num_clks = ARRAY_SIZE(shikra_clks),
+
+	.power_domains = shikra_gdscs,
+	.num_power_domains = ARRAY_SIZE(shikra_gdscs),
+
+	.enable = shikra_enable,
+	.set_rate = shikra_set_rate,
+};
+
+static const struct udevice_id gcc_shikra_of_match[] = {
+	{
+		.compatible = "qcom,shikra-gcc",
+		.data = (ulong)&shikra_gcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_shikra) = {
+	.name		= "gcc_shikra",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_shikra_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
-- 
2.34.1

