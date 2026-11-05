Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE34606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 18:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jydkOXSh;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b24mjECv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EtO5qcci
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B3D06811DA;
	Thu,  5 Nov 2026 18:27:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7a_Vf26bQEiB; Thu,  5 Nov 2026 18:27:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9C041811D2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793903265;
	b=LPngeb347a8Z+DpowH1W5ZbANLY2eP06hotK4uB1uS0IgXMB4fttWWUHXS2d18OqRiUn
	 Ft+njN0dBYCFG2FW8HkXVI0HAZbjPCVeBBqcge0W732okwYoJnf0mQ8L/a9uqsz1R3y1y
	 tUpF3RqmMtyDhFad+LCsDEJpTdu40tQ68Begg3onZbw5k9rw5EwNtBGAep7+p19geoDDN
	 xUDFoHvf3NQ5SByhvxUPqePDfLb9MD3Yfzb6sPB7BlSprAYxDdMY9nbLihlZUYhCgdhk0
	 5vY2wksF0J9ySO3OB8rXpiAlqi5Cp3WD5460ToINV7qqLvEFVVcw2D4O+LEUHBf4JkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793903265;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CpUMm57C+q//Vq0n/IcBtY4jaU08wWEtqnCS9alzk0Q=;
	b=KD6CKl3oFyiHASQvElMFtY46wHJ+LJ8DLU1KnXjh2NYp9CKpuPQebCQj55hJcdYinf69
	 h4YswJisltvvWi8JFoj4XeFsAEBagoEfmA+5yu5kpsvcXyTNXNVUvO9QMMU9cd5I64qXH
	 z8heE6pgeI2n/iWBJeO43yGZqXM0U+BmkdLJF/wZjWsoE0DseESTJafIffNNmIHypsjle
	 dAlN/FS8iHXEu7aTgGYVIelFtY7WAxfVzaBrWHEhDe9So+Zc5Brw70JjMrCXhbjNJxZPH
	 xYr/SbXWMJmbJpLQKxdMk4UW0ppcBIm1xosZZy5NS0shnRuhLfe9UBL0Bwfx3XzUIBw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793903265;
	bh=CpUMm57C+q//Vq0n/IcBtY4jaU08wWEtqnCS9alzk0Q=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jydkOXSh/b1ENaT34/G1RMgpazOLWLYgNpZ0Db4RCglARSP4wELqH/d6mp7dpjRTc
	 ViHps9/UQWSDnvQtQYITQRbvMSAer8I5y8MkcOZzM+N9kv2XqiZb9zwEN15VV465J0
	 SmDb5STJb80kY2a1ss4wM6l+2nBYonQ/UnDaG/it+jKJ6Z1VmHDrBV8zV72QHjOAwd
	 j7bllt5adirxmROUHRkxJdQfuCkYJRtZqzp2BaEGhxOH+WIolGvbCr5bfRTuongUEz
	 mwQ1j+fKLIxO/RMj6ggf2J8TR+/0OqWssVxczXVBvJ7xZsrhHR6rf8AbopnhA8x3Bs
	 EDCfa6RG/dlzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C041811D2;
	Thu,  5 Nov 2026 18:27:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8AA0731F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:27:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 86F25400FF
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:27:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uyqkkwxt7SIl for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 18:27:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A361640012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=b24mjECv; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=EtO5qcci
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A361640012
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:27:43 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5HeMXZ526082
 for <u-boot@lists.u-boot-project.org>; Thu, 5 Nov 2026 18:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=CpUMm57C+q/
 /Vq0n/IcBtY4jaU08wWEtqnCS9alzk0Q=; b=b24mjECvJf2jmPkoZX4MUQAb3tF
 oTWo0bhppPEk3Pd+zm+TMMsuDEejxE+n8FKYKybfr/Bx2T49SIih904QSrEhbnLU
 kDwLcxT8k7ENHtWwZL/s3kV2swN942cyWurBZ/H10VCZiUvk5AgF0Rg0sqAQSGFA
 KoDcxgSr5+qXzhGm9kPvhl0UEAl5bYUk4qZWfszuvnwlvJWJxOF+efcRO+a4Wbdh
 5YJJB0L/5YqK1YUhTJPVq6yGIs8giD5s04NO6LpXTGc9JqkpLd17wvYelC6AIrJY
 SFMZYw5YHhB1S/DJXCJvgJcyZwInLCrhqjZFOHADDD1/EkFw+IVwJ+xBabA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrj43kpem-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 18:27:42 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36f1e7d9d4dso609455eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 10:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793903262; x=1794508062;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CpUMm57C+q//Vq0n/IcBtY4jaU08wWEtqnCS9alzk0Q=;
 b=EtO5qcciZTA8D7j2JZK0ta75y6l4Nz3kjeuZWLWJVZglKxGNLp8E84gSzYfIDUVwya
 Lt4h1lJ3htOc/LVnjtD5FZ/r0U0AS2tk/1NRiki7cXQfhyWG8PwWJmbSoGUy+qoAM8eG
 Re+DdJ9mEYPyC334UkyNAB4UF7HJVkGxqwjoqVh2nNVa6mK8GrzjsO17JZcGMkNgm8Af
 xvF9q4iuaDthOeuWKKHdL/kYR+jM6U6rFdEFqWMEprKClFtjRjqvwgUwBdonJgo33XO3
 FNCUSCrbOXMCKOlvIwx/p1rRKRPazGGJ9SOh7AhbK7C0voZCI4Y/1ElGbsblU+fHDNgE
 YPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793903262; x=1794508062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CpUMm57C+q//Vq0n/IcBtY4jaU08wWEtqnCS9alzk0Q=;
 b=YgJBkREP/umuk4vthsU7ncrkczcGV4HMvfac7u5gv9ijsK5onHaQ8HdRlOUu188kmr
 ablLbL431ggg7WXLW69M0O58nsSB28rM+5id/WltUiQAzySlVCBDPVaRLp5bnWa+Ddz0
 VwIW7TH1oAUaKxDadRQQr0tlGqTZsgX3tNKK8TA2ERjsVDjmRluTyic5TeBjDTVjbwSF
 dXnG13rE53ZVNBtGZocBv7Bv2HfAFUZre1OzHsLKDysiuOSl30oTfnAxGLcoimh6cnnJ
 RMq2izUH8Sjw5r0Yi0J52IqaBMykfMbRvBZ6JdzjhWlM+T54zOdSuqd028VhmuDyxBBF
 k8NA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+OGmil9bEHyiuHxDUUwd9FU5GJ+wdAHqx/+W8rBeDucOvdblJQx3HH8TQ1jVTur0Q/XY++I8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/dywHzWUiV6gAdJwmXdtHZiq1XYe0nNXBZeE9MNAyIU29nVaGC
 /JIz0ZREXDegPzqt2DxwSyVYhWcAn/3gBQrmsu0mGe9zK4Um8ANfMXrU74nc8E72Eifog2njL5B
 0rtmf/oxDKTezYn/RdMQlA9KNuDP66g3jNLGVmk0mDJsAWyqzl0GPKuA7vNc9XUZj/l8bNUY=
X-Gm-Gg: AYBFou3DuaDXwa0/aDC4Di/4u10IVckDEH5X3bhlJGHWZBgibn5Q/3BLbkiwN91Uh2D
 y0Kmy6aVXYQh4+S3YRzB/PUfEDeoG8CsrEWawqVWzoheAODWGPOq3Aiaz7IH8QZHAzyIhpIn32m
 Hl70yo1gV6/eYmKMM6YCX2UmumwEIcmNisk0AF80N9jo2iP7WLkxXZsOQu0B+jU5axt2rjJFzob
 zlv2v1ukusfrSokolv6+NtWDFr8k4qtHijA4Ddn5NVoGABww/EoGSVZi8H/b0/PhW9KEJYxwMsi
 iny91D0lMuiSlPm/+MdH14e/6VUCbY2nUCP0rTVtv6aiV43j/PyqCjclZ7xfWLj+cHo3jDqGyCC
 6K1suZcB3A+ORzE/Dfpb+gudA3aR/Tydja3K+JYZ996k6+YKOJKWGmCCl/9IvIHZB9fopErelSj
 rEr9vuLTUtRHuO4u2eQ+tqSpvVz8XSeun7B3XVbmouZUctIm/VekBRysHsWb93rPpaeqDg
X-Received: by 2002:a05:7300:4719:b0:368:6f29:f26c with SMTP id
 5a478bee46e88-36a4221aa0dmr27457944eec.4.1793903261968; 
 Thu, 05 Nov 2026 10:27:41 -0800 (PST)
X-Received: by 2002:a05:7300:4719:b0:368:6f29:f26c with SMTP id
 5a478bee46e88-36a4221aa0dmr27457897eec.4.1793903261412; 
 Thu, 05 Nov 2026 10:27:41 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36f6b2be5bcsm141198eec.6.2026.11.05.10.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 10:27:41 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 nathbappai@gmail.com, balaji.selvanathan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, tyler.baker@oss.qualcomm.com,
 jbx6244@gmail.com, nikroks@mainlining.org,
 bartosz.golaszewski@oss.qualcomm.com, shengchao.guo@oss.qualcomm.com,
 andersson@kernel.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v4 13/13] configs: add Nord defconfig,
 MAINTAINERS and documentation
Date: Thu,  5 Nov 2026 23:56:14 +0530
Message-Id: <20261105182614.2405482-14-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105182614.2405482-1-aswin.murugan@oss.qualcomm.com>
References: <20261105182614.2405482-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 30rgwxAj0EfFKrmnvgG0ebDEqgFCa4Sg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3MyBTYWx0ZWRfX72LtFCKagYx4
 B8ihx1nZkzCPlLHCU651FL8CXooyUOIvI/aniXHYNaX+mPawgQbwA/8dUa9/FA1Rj9crDbA1jAu
 B+vHkZvWDjgKB5c4jg8m6jjcRMCqQoK4HBa45NU7Vgf+zecvsNC8NwHIjMMM8n+tdQeSu+FYYMP
 rE+2kpJdwPCyWWobQopAXGMyF/b58EXOQR9K7aJgkXhrkOPpbgp0CCWsOOpDGhQxqP5wddMrcBr
 ZKyPAwID7ciDLzFgKYpjdupPWSNppR0RJfYFxdkI5BfhBV/5vR6Wf1xlcF9HoRHtdDTWGPGKJi5
 9u3WwTsWfMihS9UIGRMqnGTpC4dTeVGZhVIegQwT1enORZgUdOsFJXYE8qRnbkLUkxVWFXOjVq7
 8OvvQumDIeQJPyLUcrtgsZixscdtXCTWtalZTKXaBab1438JlnkvYiSsJi+vaJ/G1xovTDK8t2h
 gyhHZFK+JMhHb7r+Esw==
X-Proofpoint-GUID: 30rgwxAj0EfFKrmnvgG0ebDEqgFCa4Sg
X-Authority-Analysis: v=2.4 cv=SZdi5fRu c=1 sm=1 tr=0 ts=6aecca9e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=ryGrPRTExSs_bnroXBEA:9 a=PxkB5W3o20Ba91AHUih5:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3MyBTYWx0ZWRfXxorL9YZNH2+5
 wzB7NY/0JENM2Zd1RBFd3Csc/1Ocsr2VHzG3X6SZvjPYW8f4LzQ1lSH4nu++T+tA8jQZF6MPBML
 6FYcaz8jPap4dyetbcXGBlmlTH0YnrY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050073
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

Introduce a defconfig for the Nord board, add the corresponding
MAINTAINERS entry, and document the board.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 board/qualcomm/MAINTAINERS        |  6 ++++++
 configs/qcom_nord_defconfig       | 27 +++++++++++++++++++++++++++
 doc/board/qualcomm/dragonwing.rst | 14 +++++++++++---
 3 files changed, 44 insertions(+), 3 deletions(-)
 create mode 100644 configs/qcom_nord_defconfig

diff --git a/board/qualcomm/MAINTAINERS b/board/qualcomm/MAINTAINERS
index 3767a2a7949..39bb5ea90fb 100644
--- a/board/qualcomm/MAINTAINERS
+++ b/board/qualcomm/MAINTAINERS
@@ -22,3 +22,9 @@ QUALCOMM DRAGONWING QCS9100
 M:	Varadarajan Narayanan <quic_varada@quicinc.com>
 S:	Maintained
 N:	qcs9100
+
+# IQ-10 and similar boards
+QUALCOMM DRAGONWING NORD
+M:	Aswin Murugan <aswin.murugan@oss.qualcomm.com>
+S:	Maintained
+N:	nord
diff --git a/configs/qcom_nord_defconfig b/configs/qcom_nord_defconfig
new file mode 100644
index 00000000000..9473ead48fe
--- /dev/null
+++ b/configs/qcom_nord_defconfig
@@ -0,0 +1,27 @@
+# Configuration for building U-Boot to be flashed
+# to the uefi partition of Nord dev boards with
+# the "Linux Embedded" partition layout (which have
+# a dedicated "uefi" partition for edk2/U-Boot)
+
+#include "qcom_defconfig"
+
+# Otherwise buildman thinks this isn't an ARM platform
+CONFIG_ARM=y
+
+CONFIG_DEFAULT_DEVICE_TREE="qcom/nord-rrd"
+
+CONFIG_QCOM_GENERATE_MBN=y
+
+# Address where U-Boot will be loaded on this board
+CONFIG_TEXT_BASE=0xD8D00000
+
+CONFIG_ENV_IS_IN_SCSI=y
+CONFIG_ENV_SCSI_PART_USE_TYPE_GUID=y
+# SCSI partition type GUID for logfs partition
+CONFIG_ENV_SCSI_PART_TYPE_GUID="bc0330eb-3410-4951-a617-03898dbe3372"
+# CONFIG_ENV_IS_DEFAULT is not set
+# CONFIG_ENV_IS_NOWHERE is not set
+
+CONFIG_TEE=y
+CONFIG_OPTEE=y
+CONFIG_OPTEE_LIB=y
diff --git a/doc/board/qualcomm/dragonwing.rst b/doc/board/qualcomm/dragonwing.rst
index 42828842da5..cfeffc0da03 100644
--- a/doc/board/qualcomm/dragonwing.rst
+++ b/doc/board/qualcomm/dragonwing.rst
@@ -6,15 +6,17 @@ Qualcomm DragonWing
 
 Qualcomm DragonWing boards are industrial-grade platforms targeting factory
 and edge applications. They span multiple product families, including
-IQ6, IQ8, IQ9, and Q8, which are based on Qualcomm QCS615, QCS8300 (Monaco),
-QCS9100, and QCS8550 series SoCs respectively
+IQ6, IQ8, IQ9, IQ10, and Q8, which are based on Qualcomm QCS615, QCS8300 (Monaco),
+QCS9100, Nord, and QCS8550 series SoCs respectively
 
 More information can be found on the `Qualcomm's IQ6 product page`_,
-`Qualcomm's IQ8 product page`_, `Qualcomm's IQ9 product page`_ and `Qualcomm's Q8 product page`_.
+`Qualcomm's IQ8 product page`_, `Qualcomm's IQ9 product page`_,
+`Qualcomm's IQ10 product page`_ and `Qualcomm's Q8 product page`_.
 
 .. _Qualcomm's IQ6 product page: https://docs.qualcomm.com/bundle/publicresource/87-83838-1_REV_A_Qualcomm_IQ6_Series_Product_Brief.pdf
 .. _Qualcomm's IQ8 product page: https://docs.qualcomm.com/bundle/publicresource/87-83839-1_REV_A_Qualcomm_IQ8_Series_Product_Brief________.pdf
 .. _Qualcomm's IQ9 product page: https://docs.qualcomm.com/bundle/publicresource/87-83840-1_REV_A_Qualcomm_IQ9_Series_Product_Brief.pdf
+.. _Qualcomm's IQ10 product page: https://www.qualcomm.com/internet-of-things/products/iq10-series/iq-10800
 .. _Qualcomm's Q8 product page: https://docs.qualcomm.com/doc/87-61717-1/87-61717-1_REV_D_Qualcomm_Dragonwing_QCS8550_QCM8550_Processors_Product_Brief.pdf
 
 Installation
@@ -54,6 +56,12 @@ Generate the default configuration for the IQ-9 platform:
 
   $ make O=.output qcom_lemans_defconfig
 
+Generate the default configuration for the IQ-10 platform:
+
+.. code-block:: bash
+
+  $ make O=.output qcom_nord_defconfig
+
 Generate the default configuration for the Q8 platform:
 
 .. code-block:: bash
-- 
2.34.1

