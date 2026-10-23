Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C68606A322
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 17:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pQ5dIQ9o;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QeYzYGrV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HxVwg4h0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 157B981547;
	Fri, 23 Oct 2026 17:44:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lqJLOZFwJ0JL; Fri, 23 Oct 2026 17:44:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5313A8151E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792777491;
	b=LxNYTEOghRhRCO5gATD59f7kpgF0nJp0M7rhJ2mojUwBvC3s214AhraPwKyEP7jWIGe1
	 p1bR3WVg98W5IMM1Q9SZ19NIQY19popOSUlS8n0ibzI4Pha/Vhr5Cwif16zVyCtP/LwLZ
	 IYCtMQao4V+4hLxc6LDTTv/TeCGge28jpGVj361J78ri2TXDVj9YW5Ek30eWq8POK0p6R
	 WRxjxYgLBv+yFiLiKmiS1lWFISNTXGHizLblWU+yjvHZgyIM11ulMUxl24vCpm5rdAMMb
	 JMu9lt+R7UTMKHgEbRG5h+FBC/aiZys7U/k8cBVtB3C3N0I8Oa5BFZGLClCw9l4XhKQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792777491;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=D11J0VoS3V+cLUtbDe+qeI2asuCqu3+CwBPASdeRMQk=;
	b=sGFPLiemqcncGAGao11gjPhtSV89lVPQt5ICcQRakBGV9yJzpjGibbKG1ipS6iSIiJAm
	 M94PYxbvBrQxY9+K4Aol+iRpGJPOf2Lkb3TtDROdyylroRJY+0LDP8b2wpQkjvwIhLL/u
	 i2Xi+jo07NeEeA2g1YNx6//HwQwfoqR+FVtx4wbTxsn79mbap0D9HJJukH0B5hpONgMEK
	 s3sZuAg/CpBIJhgFTR5vaesOTWqchgQwB0egqusTcH/rTNyhUaxMs82l6TUOkdCU3AyZ6
	 9FG+r1108X4pyamCLHq+0RFXhTqNBWtYw6MczvGnhX2aAJoVvtsQImwv6spVB9RK0cw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792777491;
	bh=D11J0VoS3V+cLUtbDe+qeI2asuCqu3+CwBPASdeRMQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pQ5dIQ9o14rP2BVpTe8KncDh0WkGnFAmyk7/FkL4p1Gm3wez3sHaDOEl4iAf+yhiN
	 nhHDO3hkLesuF0+R20Y1JMfyXEnIyeu3K6vZmKH01xNrHC9hIeAl4pE1Gvh8rYBh8A
	 BfQM+OIg4zBFgA4r93q9SrHEYHfkUHXdiK68Fs70lSV82N2nplFzmSEoaq3kKs1IRq
	 r7h9nPci6D9n9pkzNWfFgul7LyGKtrVIt8daCSWrTuRt2PEy5s6XCyjiM3dk0MgdLH
	 gIeQZbD69OSaip5TozJPaNbpsa3LkFYs09TM+5kt6PIXFLh6XTnLrHVhsJszeAaMCU
	 1NA5l3bYsLZyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5313A8151E;
	Fri, 23 Oct 2026 17:44:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 695C43C1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:44:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F69D409FC
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:44:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UnrDqcxBGZs0 for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 17:44:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7D14C409C1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792777489;
 b=TVZaq+607aYcHf7tc26oVlv3t6n3EbHlvZZvah4bkk8QNXpZxIv/42nCb5NaHZDA/aPd
 fgIvISZ32D1LB+aJ31t4rmiruLAz3rrXHsk7qcEcYHhbxu+ZECQBpLN7NE5nxkRb+eqPF
 0nPu2j3iuqU62R3Nc3xWLdtJlKW8Tuk0yMSvy/ZecJ4a1eWOnKV1+4Zn9LnFggnajEVNQ
 48ZjP95i5svKKSqNO8MwTGHG3nkAkM9oj7o8klY+cWIcNQ/D//+V/fjVh++WGd9Nv5dmj
 n1szCyNo4UW1IGNrLRcq56z916ieR2coOUcKA6LnBInSBDjLRfy7LYkuCeu8tgWFi0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792777489;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=D11J0VoS3V+cLUtbDe+qeI2asuCqu3+CwBPASdeRMQk=;
 b=f7X5uBfTJaGDmocAkTEmMsnb9GZL1DiyZUuIXa2diRbdZYY2QYkT7tf4A2pGxz2QjBlF
 +86k3d3ST2LhJtngCXr9IJTRDJU/6KFsh0sgw5ztidQqdVS5n+KWSYHpaZeOiuctszKER
 7U7ZDb7bhXve1pkHThJ1eU0BCtcizl03XaD4SxUh6ITl8VdLWVo/uyiINOKbk0YdKpvDp
 QFMc133Y7vCflj6cIb7HR49e0veU2EvflYs8CRdqGzEalezMGnRZ1vSih1CKbpYEJjMpm
 gLDFf//JmVrfFrF9c5exgIUkdcHt4b3KEmWjNGKEHdyCbMYju/R6mxfytRm+IJnglEg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=QeYzYGrV; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=HxVwg4h0; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=QeYzYGrV; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=HxVwg4h0
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7D14C409C1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:44:47 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG3nCg3811775
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 D11J0VoS3V+cLUtbDe+qeI2asuCqu3+CwBPASdeRMQk=; b=QeYzYGrVf1rKrsT/
 1zr/URti33ZnjdRqfEoMKpONqYP+aRu2NhenahIMQNvySxSTH/LlzMYiWZDxv4ky
 HuEGQVWjHiLd1/DovyzW6foSrN744bb6tDvuuUbDCDjo2XWiEGepOduuOS5myiz4
 aKakVBZC0hqTBXiB1ImIX3bsZVuY5xJB5dP+2zArFWP9wjIt/x/S3Gj3jNLTyIe8
 aVQCKDPEet88fGmcZ5pvDiZ3gwJFFYnKcKX9iOGpuowgkpE79iGa/gE+VEiqceZI
 nmT1rSIVLCh//3+u2I3Rr/h6pURubowO5tD+49X78AN9lJbUTzABaeSJojyA5t0D
 TC6tiA==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgas88cjy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:44:46 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-8afde3fe132so19477157b3.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792777486; x=1793382286;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D11J0VoS3V+cLUtbDe+qeI2asuCqu3+CwBPASdeRMQk=;
 b=HxVwg4h017hItkSXKs81sU2wSVM1YyznbQfkkhyR2l62aAaLukuQJwlk0BzQKySop3
 CFbinuydM2biF+uPQKrrjzReMvsX5I5mjRblg9rTU60cBopGL1ovdg5A6x8hSz2JPVMI
 hSFaQUmF0FECKqcZripLyFtpQuJyIbgG5z6TRLkk7mEsWhaVp97ImLBpFMmdXQzA7CWR
 WhLizaf+KSijIGTw+VkFkVpOJwhrvgCSfMzj+EllteCg9NqWw1j8t/Xe38n+uRq0ybBK
 jdtJobHg9HekWmisYY7im5oG5ZEbw2J1vvNk0KwLtsxAZFyHsUcKZe/U5UhaCmllct7I
 iUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792777486; x=1793382286;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D11J0VoS3V+cLUtbDe+qeI2asuCqu3+CwBPASdeRMQk=;
 b=0HTIdFdZ6qddEgbDqlGrfqZk6HLjYIYdqXjKMJtwYiCMhiQgnC1WPMuUSuQTD3/ji3
 vChNHVuJ3RBYXUMpNKgjJSjfuqDLxCjbvVbMGHhc+EMTGl+JtBC7srtNxQM4/Hqh9y0A
 9/e/Y4o3wvWnGnO7+k/7oimZ9QWlXYLk2btWFJJmJQlNkFzKro2ZJwqNOjiuCLLuavtF
 dtEfwyBAjSnd8SwaSM/MnFEflbx92Xa079DH6Kg7hp/jAitVyP0VQAan40EDMTPDGCTp
 jDnMDdTUWU8FFQ0Wu4sCcGFwyM4icbEEVhNL+q8oc4uxkakNvPxDMJUKgSig/5oj9hB7
 zbVQ==
X-Gm-Message-State: AFq9FYLJbYg4TZNxR5S/cNmrrsyRLZQHzjzwuCozQMjsvbp9wIv0QFjF
 3uSFoOCjqKooIgMcS30Nat7RU7m1Id6GfdgyqJjQaIx7JVL0fyL0SRgfWmYSitLwsOLxk5nfz+3
 DpY3HWGStcmMeUsCFnwJy1DiYIMX+bgY4spu8dOHfbZEtQfTwUoR/x96dQShY8aRbKuedzzk=
X-Gm-Gg: AYBFou3L5HzzuTQipQc0X5H3QIidpP64PoL027ey6LGisLVgqv/1y6fmzyWoIAtZZXz
 z3UwUhENoL+O8nh+2AFLnBy+z0BavKYNdxluhZUad1ymXq+/QgJvVi2UVWf3YZBRKBPABgOlMo7
 YHvzFXdrjSbEwcyqEl/u0viZ1X1b2vDRm/U7RLLZtHDrf67Mskxd5eLFzdI5kWbsodaio6KarNd
 NyOQlwmmT2QXc5/2LtUZ1u+R1ziIZ/QVfjccM0uj96/++VCuwarxRJMARq0JiXCKep16uzmr/go
 BbHdbSayQ2dPkka+9inw3CS/qYrbeD4Uae0yEDZTZBwcSURdhvwjGDgE0G2EGfsEzLg/tZsw2K9
 VxQTpvffmBGw0g/7/Ivy/cnnvWKnNo0xq8wUDDwdni2LthFwFAbWoX1/n5J10
X-Received: by 2002:a05:690c:e3e5:b0:8b0:f04a:3130 with SMTP id
 00721157ae682-8b157e35c82mr26300037b3.41.1792777485989; 
 Fri, 23 Oct 2026 10:44:45 -0700 (PDT)
X-Received: by 2002:a05:690c:e3e5:b0:8b0:f04a:3130 with SMTP id
 00721157ae682-8b157e35c82mr26299747b3.41.1792777485406; 
 Fri, 23 Oct 2026 10:44:45 -0700 (PDT)
Received: from x2e.lan (108-208-224-205.lightspeed.gnbonc.sbcglobal.net.
 [108.208.224.205]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b163dbf92esm2823357b3.32.2026.10.23.10.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 10:44:44 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] dts: monaco-evk-u-boot: add reboot-mode support via
 PON/SDAM
Date: Fri, 23 Oct 2026 13:44:39 -0400
Message-ID: <20261023174443.1552137-1-tyler.baker@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021-monaco-reboot-mode-v1-1-41cd3c8f15d5@oss.qualcomm.com>
References: <20261021-monaco-reboot-mode-v1-1-41cd3c8f15d5@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2OSBTYWx0ZWRfX9lU6pbpAnz4F
 Zu1o4rNJcXG8tE3EIqeDNoHi4ytbs1ppRRc0KS7xjYIND5SiAzNfevtjVMN3hB2AbtRK/X7Pl3+
 ayFPx+x2TrhBcQgHMw2XhfGLFPHSRYU=
X-Authority-Analysis: v=2.4 cv=OPqyTiaB c=1 sm=1 tr=0 ts=6adb9d0e cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=fn3WOaEb13W5ZdLQv2MA:9 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2OSBTYWx0ZWRfXxKBQPLiQuRBR
 E/gvyg4xrUBbSbek3jwIUo4HPImTsgexp+27tMU6NffU5MvVPK0QMo8sjHmqxIvxAKltQBsSe7a
 nR8dPL3mRhWsV0QdfjgSnT/ziLZ92GzuXklNJETlIr1roEFJF9zTyLzv1LG8yJngMhDTWMt38GM
 2wlsmLueVHchEiIQaimLC0Jt51dm1uMVvOESRo53gGRqJ4QKawU/bd16uFTK4T9S0a9oeFYqfQI
 HSFjV8iCWVg3Qcd36tW099bozZXGT2QDDCzoInAWys2OAFNAn8Ir0awqQZxe5Q8cNicdDcm6YFN
 mRfCbMTyjT5+G4CXK4iBpfQOcpJiStrqn0zflFO811lKpkGhdLLxAue1BBydtHeigMe0JpQaHjd
 QRDPgnJYVXsaItnG8/imRovoGuoWX9K2mKgRl/TVw73Mw0NJryjfhrUJMB+FCL+5BKV+ovb9Zdq
 GzMqReXnhnmufuzobzA==
X-Proofpoint-GUID: LECuyQMUeaRXC68-2vYMhrkSDr7j7rst
X-Proofpoint-ORIG-GUID: LECuyQMUeaRXC68-2vYMhrkSDr7j7rst
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230069
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 21 Oct 2026 at 12:25, Balaji Selvanathan wrote:
> monaco-evk is in dts/upstream, but monaco-pmics.dtsi that it includes
> has no PON node and no SDAM reboot-reason storage. Add them to the

lemans-pmics.dtsi in Linux already has these. Can they go into
monaco-pmics.dtsi there instead, and come in with the next dts/upstream
sync?
