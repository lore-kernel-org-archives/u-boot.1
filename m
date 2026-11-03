Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C44606A329
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YTAFeMRI;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lWnDqq4B;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jIRds9FY
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 04F6B60866;
	Tue,  3 Nov 2026 13:44:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 66oGWimzf_BT; Tue,  3 Nov 2026 13:44:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4FB7B60865
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793713486;
	b=i3hoMvcQUCQTuw9JvPZxG4YvEsmup0KBdbwWKj3IxyNHiTF94rBJ7BaixLaGst1fOdmP
	 t9TbXbJsyV4iav/br4v7Vs9VksXhrSmFakZFnBWluMLpszdzqw4cHWRQXlaBFvICc39AI
	 xsHWE2JCm8LrOxDTwwBgVk3L2xQggPYU2l3VS97xGgme5brvpCAQpVd1WxWeQqNEKrlwm
	 7NtZbvX9Byh9JWTC1lLL+gZOsyJlQItZ3i2h1ycC+AHDlunIMC7ExpZTUa6ERt1m9elzd
	 KwKGGf/UFbi5Vc3MQHJN97F9elhS9Hn/b8w2Zq9Nl6nEw6u6tfZ8Goxr0oSOJuZuYZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793713486;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Wfm5WX9riLIbJm8pAmEUxorpDc5QuQAM3PU6S+HE6so=;
	b=EGtJEq+2mTWDW+EpQC3N9Wl51q5hAN+BXHk+dol+BLJ1AAiGmXG+PKRk9/4tXyyAsort
	 SHyNtT1m8SCkJbtSXhAqLbgof45TiYCysv4SyAHNibKDXvHV9t2vOnc3NpuPblDPd1jU+
	 Xa6/ELnfVx6xEDPLnKPO2J+M4TmRWYawlO4/VbrBLVAJkrmr3xc0/m8/n1gqQvKtKlbOK
	 a2RaXAI+4jiJXJwPVk+PrAduVKPiRh+mYYoJpl+1WmHpoB+wBpx2JHXnjGjiDdYD//GEI
	 r2GLe2HERjDN5ZLBnEtJMaS30XCcjZ8g58j1NiC3jEi3XGjR/Ak/ctwabJctD+cEIdw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793713486;
	bh=Wfm5WX9riLIbJm8pAmEUxorpDc5QuQAM3PU6S+HE6so=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YTAFeMRIcEa9g25rSMuvUQG7Dig5Un0IbRWRypmIrpVTsYgDCALz1UCrpMDxeAjxu
	 kJa/b+uWAj5hX/BW7+w5CeQDU75ZQcoo7cTj5Q2tDmg7Kd6uh2DoLaOVLjKwBfsS42
	 kTOMdHvO9EL4zX9M3zb+4OFWxiNcMXN1+z7MTLxKnzbStLZpPQwG3Mjx06evC1fzap
	 fy/Z7IQ3pKIMxgq0BD9l0P2W4P9B2kGM8qGP86RTjpOud3FJNPsX+6kLRzFeQqGJK6
	 lRayKNEKvqNnzAQicyqOOPlEDstlljtKRX9fAkhI4iOGKB3Di6laADO6aS/vt6dfz0
	 MeYSxIhcJrx3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4FB7B60865;
	Tue,  3 Nov 2026 13:44:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C9F3235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:44:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 62A0240070
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:44:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3OX5JyhoeLzD for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 13:44:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 27D0E40068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793713484;
 b=ZrBOtcvbGUC+DQoBYH/aP184/G0iZ9q6rO+gqIvTCc3JvGCRDSbYJuo9Cf2ixSkp95hc
 wd8ZF2T7lMjHeAaFLDwfhlRoAj4FmI0fuTjaimVdec94cJNdmIOsctdDKS0d2IVCxvWwj
 V5wxIq2v3vSrRtP5SUEpYF0mMxndvVl3E3KwyRvLZTL3Mkokh72jH+oOq6fdtBSOoDWXO
 spU8RlOKfvoCx7ZKcPv9gf0vqqznFv27cc28huWcqFtAkoAuSFJBb2rPMU2yR5mQLgO28
 B7XsC0gta7WuXqLwPKarn4/H/ygEkNZXr7akozKzRU2XKMEX6oQ6CNs2ZGQqKGrpfng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793713484;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=Wfm5WX9riLIbJm8pAmEUxorpDc5QuQAM3PU6S+HE6so=;
 b=jo2XGmbeY8+12W6eIMuL9CdKKYRxGbE/Cqm4ah7vw+R2nk6aXhLLcx8e57SKEniJaeDJ
 v9qvQCN7f9+GGihx5ElpA/4h9us2Mc4s3EDOnH4clUqitJrNh/yfueQF7loORInTLwV7L
 wah7CyVQ9uBZgm3yP+Qwr+pt9LQX/05aUrhcpJFmfVqzNdI5rXfyvhIde2XCBQ/0ft7w+
 /BA/IkQtfIaYuFR6Ml8KaGIDeokZmdHCv/DlinYBgYU9nyWVq/LOfo2zb3pgS0RBgqUr8
 O+xOJ4S0EDNSw1M1b+qL4rzdkyTJ908nnnNv03gkX5lHS4fnvE18daLLsIRSS5I6suw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=lWnDqq4B; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jIRds9FY; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=lWnDqq4B; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jIRds9FY
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 27D0E40068
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:44:43 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3DZ7lS2449488
 for <u-boot@lists.u-boot-project.org>; Tue, 3 Nov 2026 13:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Wfm5WX9riLI
 bJm8pAmEUxorpDc5QuQAM3PU6S+HE6so=; b=lWnDqq4BiNxOu3JxWvmRqec4e6B
 wcCrzOlhb64hIfhbBBOcfXuC5s1iWxnrqkFNl7oYwQbCQSWQr6p+qdU3QXZ4c8fu
 21hDEqgMRgWaU8uq+R6lNAdNTLbPP4B53CZgbhHHqTO1ey27JESAUi5YFOHjQmk4
 GWGcGRSnkiCSJQWnaxRJbmwKrloXE0Gbk9/FdBccx5Oel0lsIBfIcz9X4aHcVej1
 3djKbGYHcIpEhj7XySYprP2ZX3wSIhSgtfh+unTECrskoF5vRwJBwhAWCsgEWN5j
 ZwxQPnoaaogDapqicfBc7lEMs9C+i+MPXWxYVr8QAZpa8uqKqdhhtmFx63A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq7yct8ex-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 13:44:43 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3425098ae4bso1016316eec.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 05:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793713483; x=1794318283;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Wfm5WX9riLIbJm8pAmEUxorpDc5QuQAM3PU6S+HE6so=;
 b=jIRds9FYgjdqCqNIdeOInrlxf1Jma6gW54ih+xOcJXWCrBTh8t6EyKCPoEFfCwcuvY
 o3kpi9cE6Bm2Tt6NjK0QnuEwUcjHvmteDhwH5fHa88vflk3nGxmsy9tjOFpXwcarcFtX
 4cD4hQJdNdbZIh9VLTkUKRHTu3JuLqBZE99uYkdVMrmwB9xrQht9f6WBVC37YAbEFsz+
 CfkPUg8LNieMq3Lz8D+7zv/qT9iTbChSw9RR5Cp+lkLxf+N+jZyUBx0f8OFXrBo8ELH5
 gKPMrysVIGTeUBEb95ztbMlF0J6ELnI3mqJQtMPUSZUa6oiOMrxaVt+kdzvKQxalwgS/
 tQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793713483; x=1794318283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Wfm5WX9riLIbJm8pAmEUxorpDc5QuQAM3PU6S+HE6so=;
 b=tQRaXa5zVXscljnrBkIm/0HdKWWORkYkw6Lm258lByRPOMMCKJEQZ0PEOXDdcOmHSp
 /GqW5V6yo8N3sa9XujNJsnrYNCK11TpI5tIyClWT9j9m/vPwTznXCDcFzPRQeDaK/i32
 iO0uVJzZ90zXNayY7BVkdlqfL9dnvJXl5SOhcRg1TUApLe2roGm/bfQ1o80bCif0lgzN
 WEN4tXCz3SjTTGZrf97lb3BcfoLg/0Kxt+sCrP0fwFGZWgbZZfCWHzK8YfkdeMIgUZCJ
 5TxHjN7QbyNcgj3QXYacmDUczOJ+T7SRVY9u9KWpAIaj1pSn1FDpHxE1q7ih/qgKGLIR
 Qahw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOXsF5Ju8fryk3doYgpdhsfg8ZBVxIp57GxazR+GcA88FgfW+J81BLVGXbQU6ewxYDg2XuPM8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/5GSxC8C9TEI9sbzVVSk1BJvU+AtdH4FrS3tHOwV+B1ze8h+cy
 QJ/7X3gdrbN0vAK00UIiPWBtrD/ZpZqgeSyFybje89QQUttYaZ2nYxluKiLS2iujxV7YHcHvHAo
 WP8N/0oFygNyQTvZFyIADFGbK3TRozxZNzmgYgvZeTk7k6JHXL39eE0TFmxCELPbMjC99/Ck=
X-Gm-Gg: AYBFou1LqkR9KdmwCXd/KzH2nYG8r5cz3yqib2//VLp6FH2vZZy5mr0ovVxtySC0pzN
 /IX7qeFY2umyYeLRf2jjG7C9/SP0q3S9Ji0GiSAMrpakdGPuqM+ck9TPjrs5JcRwn8EqdOQcZih
 NVSVQrN21MyBE2kvQUuY2aMHG7WZ/EUGqdJiBS9q+LfGuizPpXa9jiXo2SiV4sco9eprq4p+z2o
 PCg7jMgCx/Blu0PiyCp4n1zGM/04qXCKYuywivLdnc+p07tg+x8SljUmStuMjnsOH0mYwKdcgbM
 0/on/v1RRac8qV4uXpAk7HLZ00vYQTxlmAES2WBfqTYgULj87FWLMPJAZoeP+0joVyN9fFyu1Iu
 UQOam48L2uRr+1Yw/bTUhj+YZ8qsqwdzVTLnOogi7/OA2QLFs0ufkUSW/11Xia1KzCTCjNjChE1
 c32ETIh84lNqdmBoqNzRduuGpdxXq+QZnNG1fXekADwmuXzvE2HtkYQcVI6c/eW0EqZ5cw
X-Received: by 2002:a05:701b:2511:b0:182:d0a8:d1a9 with SMTP id
 a92af1059eb24-1a93c6ccfa7mr20913811c88.0.1793713482616; 
 Tue, 03 Nov 2026 05:44:42 -0800 (PST)
X-Received: by 2002:a05:701b:2511:b0:182:d0a8:d1a9 with SMTP id
 a92af1059eb24-1a93c6ccfa7mr20913762c88.0.1793713482046; 
 Tue, 03 Nov 2026 05:44:42 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b23f20d36csm7511194c88.11.2026.11.03.05.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 05:44:41 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, balaji.selvanathan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, william.bright@imd-tec.com,
 nikroks@mainlining.org, anshuld@ti.com, jbx6244@gmail.com,
 dlechner@baylibre.com, nathbappai@gmail.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v5 7/9] qcom_defconfig: Enable Shikra clock & USB driver
Date: Tue,  3 Nov 2026 19:13:49 +0530
Message-Id: <20261103134351.3532864-8-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103134351.3532864-1-aswin.murugan@oss.qualcomm.com>
References: <20261103134351.3532864-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V7foQuni c=1 sm=1 tr=0 ts=6ae9e54b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=uqFMpbG4MC8BjM4yXrYA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: Qrbmqr9WyXiBdhoipk_K2AnNi0-til5n
X-Proofpoint-GUID: Qrbmqr9WyXiBdhoipk_K2AnNi0-til5n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1NCBTYWx0ZWRfX7T9Bxj/uZOFm
 zzQtDIIMX7wopjpeeHG3qXa9PXqmQPmd8kWtu9dtGIE/jFGlxAm4+aFktm3AESzY7a8KPQ+Xeoe
 A1vac0EHUYCJ/m4k20ol6i/oXdTJjE752bk0i0L8BhZdJLaasKGi+E3XmVlnx293+1crWWle3Mp
 V+qPd6DIK59AJ61ZeAEf/1s6dOg3EIZ26vuhuMUlimE0LLVo7CFwvkZloZ5Ioh9xVP/mS25v2yE
 oN/qWnA7FHe99Znj8nhSXGrhCqnw5D26VUoLNEPDqse92Jhu7mzgOYgpxrl3aH8sH3Om7v3uBmi
 AwMs1fStOJjdsnmjw0cTlhiRzyx+l27Z0rHrppny37tleFA1h1JQpxfrnEiwv492L4oTPEg7E5q
 koVZdsv8eeQtsbCC78T9AkUyGDCUPyiujh5KDnunVgpKDjnu+Hxlc0BDDlWsscgStuYVYrN3SCu
 /uCmbXdYL1F1qy9G1sg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1NCBTYWx0ZWRfX4NFFkKtmZ0L5
 4vlshGfKyT07kn6QqiXcLlKUfqPc21hsAUCBCrMso6OifbeALqrf7QTS2GigxcWQk0UA2APd8Lx
 FAHgQn6VEKLOsYwG1P0WOxK3r50dGWA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030054
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

Enable the Shikra clock & USB driver in Qualcomm defconfig.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index a66b38bf7fb..a399f7e7984 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -63,6 +63,7 @@ CONFIG_CLK_QCOM_QCS615=y
 CONFIG_CLK_QCOM_QCS8300=y
 CONFIG_CLK_QCOM_SA8775P=y
 CONFIG_CLK_QCOM_SDM845=y
+CONFIG_CLK_QCOM_SHIKRA=y
 CONFIG_CLK_QCOM_SM6115=y
 CONFIG_CLK_QCOM_SM6125=y
 CONFIG_CLK_QCOM_SM6350=y
@@ -115,6 +116,7 @@ CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_PHY=y
 CONFIG_PHY_QCOM_QMP_COMBO=y
 CONFIG_PHY_QCOM_QMP_UFS=y
+CONFIG_PHY_QCOM_QMP_USBC=y
 CONFIG_PHY_QCOM_QUSB2=y
 CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
 CONFIG_PHY_QCOM_SNPS_EUSB2=y
-- 
2.34.1

