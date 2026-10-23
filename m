Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6799C606A32E
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0Vuh9OWo;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JcLaDCfy;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PjQp4tCs
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2015181551;
	Fri, 23 Oct 2026 17:45:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jxx9RrLov-gz; Fri, 23 Oct 2026 17:44:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2D0CB815C3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792777499;
	b=IeggmjT7y2oZpeOPo9r2iiQKGAeSBpuxbEApIw/zUirr0ZA0QsOCWwcexy8MozPeDm/J
	 9ehAEJZA90iPP2SLIVmokn5pdaALJ46BBd7x+DmKwIplpnybqcZhfDR0WAdNRC3+G4ff3
	 DZxWH89CXZeHSjrwbD0oe2VnEY/P820cCKGRHtS9/I3iMsj461q/qO3aQcjZQO2GksYzM
	 PGF7WY7EJVHck5+MamhSOgGJnATrAv0QHB0jWaF83cGcbpfJQPVitj308llG70/yvDJJB
	 S8plSf6KgIYc9HKBcKcPBD7kL6zdPdqMWlWn4hRbXOpkS/FMcn10QnpJDBhKmNoEUZw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792777499;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RuQj/AVd1fM7fs43lyLx1Ttm1QSFPVvShlM7HDzNAKw=;
	b=SpJpuK37dj0bZR3ISKOOFUxSTHt7FD1omMOem7T7M94iu8uhtV6TmMLzIvpNJnAVoRCz
	 swSL6fWnRG33a20cfWfvg9vvfFKBKEJ0XQEin7MhDqRKdENlkhur9uy25k88oDji+ifER
	 +m41V62vWJfp6CXF1hfTkHQXF8R5Xhto8CmB7LhbnXybXaN/qIY4SG2uBethTprGFxWdI
	 FFjVOH1UTc4xGcXxLiIKwYsdHOtjxxN8/r3fH90jYtKYbfyK6iHxeBIErGkW5DHVpbqfd
	 WIaQsUNhAFf9cAXq5a/rO5VOk774thseyQ6JQ8m/zIyXkx66d9l1bxcAsvOoBLBwYHg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792777499;
	bh=RuQj/AVd1fM7fs43lyLx1Ttm1QSFPVvShlM7HDzNAKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0Vuh9OWoph4btUCXxd+7XCKh3DIEU2fjHGkB3q2uyiZT8CHGCh5PjJ7R4bvqMFIG+
	 Ms7+jWp27vlBWTlq7mObZPSmJeEaMss5KbenAOFSxxqt6pfwSbKn4qVi8jnp4fhVhi
	 RZrhFBE+zqO1YREyl810x6cfYJwAtG7KjhkL/5EircXr9WJ6kGJor1FLZ22zKTzINX
	 qa7Tf5MDTx+nHTWu5c3nXPHulG2excTqFUcXdU0MNyYvCBiV4/j+q0ppK6fKL2jVXS
	 grLAPKfMa8V1JTfwSBK4mTUYy3F6ycNTzYFbZxY1BAbql6eqFIJTDH7IO9r8MVRquQ
	 xeWfRYJr8a9Cg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D0CB815C3;
	Fri, 23 Oct 2026 17:44:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3633623A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:44:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2883260626
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:44:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id knifj3Uw0hzF for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 17:44:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7576260618
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792777493;
 b=WgA8AdvrjcDK5sfn/rz7mYYtqD3wWFjpV2+W6IzAaOJibe93vShWCVb6c98nSjhEzhga
 NFodCnyAHdL6HvrsikzaNd+6YfOgQPrCk0IVRB2dylq5lENFXsM9FdVqkVbQNlYgOR8pG
 Y1un5CzaeyOiAnFgmTGDdyDGjg9GnxzjF9nUigGLeKDz1ezT9ilhNQHyiBk7rvbKnrudd
 fDWQ7mZZiZouPFiQNsRC2O9tgiQXCJdsS7CfC2Xdi/NXS0PG91XALlx9FSeMGYfeyT1vf
 J/8Zjw/UCD6d3eFXsFvUUeZCiHIaeZNdIF9WlpTJZq4dQce8NC8O0UPaSqYpDQ9N+/Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792777493;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=RuQj/AVd1fM7fs43lyLx1Ttm1QSFPVvShlM7HDzNAKw=;
 b=lsqm1FugfR1IYO+OU5aIyeA4K8boy+ztQpyPxc7SzetzCQbGYPjpdY6gTeGKrugGCv0I
 1htPJabHzosoEMYxNuN4rtt5UbJXeBcnkMVFnVGjvEX5zAO7lMB6vcthCos96UiuzB+Xb
 D8OW/inzQiOe2jAZZcYIMp72PT3CY20rBJBg43SquiLush64nd746htDLc+GdVQg1Cp9h
 H/yaDIfwd9HsmDwJpJ7Qd2QYU1dIpdlm+bM1UpdMS0u6h7pkXhpLD3JlcHe9thtdXoHx0
 aZq770aWeUeTvOf77/yVNf5FGQa73sfDxTjtmSPBELnkkhZU6iHQcqQGW1wJJud8W4g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=JcLaDCfy; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PjQp4tCs; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=JcLaDCfy; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PjQp4tCs
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7576260618
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:44:52 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG6Kxq2216025
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RuQj/AVd1fM7fs43lyLx1Ttm1QSFPVvShlM7HDzNAKw=; b=JcLaDCfyaPSgV90J
 9kMhCSe+OZ6U0tw/TUmJ0EGGQDcps8122RRmxmozIF122zAuDcJAPb8XD8atxJ8W
 Gwl78uzcHqjSY/DYInSyb80JrQZlCNevC/IvQ/iNa7/nVxZQCDECmUfLAZry09nT
 nUIqWg9ts6nYYG6VKV0HziUUVAH6ZTLHcNoHlJF+YDnSDp5GAIvEwGwFz4odyF6W
 7HaooFaqBtBfMw2YfplYG4CNJ5to4yxyRMfl5ZueS0g4wj3XlrjZ3W295/1iCx2B
 tAtWIUTbGYQKNNF6rfpVdN/qd6LRbtIC1c1O6b8ixRhoit8cfeU6BglfBwKdA+en
 6ID/NA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgatc8cc8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:44:50 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-8b0d36c1db7so20541947b3.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792777490; x=1793382290;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RuQj/AVd1fM7fs43lyLx1Ttm1QSFPVvShlM7HDzNAKw=;
 b=PjQp4tCs5RRLZqvgJDVefwnbMRgPY7DpMd0i6HTJBL+jM0sEfCuPTA3Ccivh7Dqi3I
 t+jU/4TEg4aLn82OJC413vzgizBS9Gx1bRTWiIyWOP0E7YQ82MD4UpVDtiU5nbzMAo+A
 bRxT20yDvRbHcu6xc8a9ODvD6Nv/SHKEOHRqJDz4FxZQfO5W/awXdgeKk4NA+vfGhcGR
 cE1L54s3NY7Clz6Puv1wXyQxLRaXFs+z8TUNB5Al09czw+FSlocRfchqJZgwoOEWmFQw
 1IL7QkIvButgIiZuCTmnqow55ugTKJkB+ETqVhUp54wwmJ/ahw9WJbCiZyUKZZ+k2iQW
 AdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792777490; x=1793382290;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RuQj/AVd1fM7fs43lyLx1Ttm1QSFPVvShlM7HDzNAKw=;
 b=2n8MzJk8GSUVdMdhpw2QRRNmoeFL9khBWRW9wcrOd6SjoOQzSvSrXFIF2eAN+O7qIL
 q4x3C+EBsr9wz7E7VHGGLxyQXj7EO8rLUrG+hTdnHVIIS2yzGZELqbHwAas+FEAYQJJj
 g5ei0XmXHeDUuwPlxDtRNBPEfbn6TytlLK2fq7zHRJkmrYjSI/TjUxp5FLCt2sM1JNqw
 7twhX+zmk/H1ZyhZUx5AU8qzCP7VpnqtiJIYUsg4Lr6JBv/O3Y3Y0u5haGYpTnFPuduR
 AMnA7BbotAOk8HzrOhpkyp6YMtNdGG0Bc+lFj6Sszq3wtnnnX4o3dj454TWzN6GgjTwl
 0o8g==
X-Forwarded-Encrypted: i=1;
 AKwUvBz2eE9+MNC94Bd1coLa07sc9hJsUHMOtpLgxXcl8SIUX5pOOYbRusVMjrJ2lJDaJzqYm/8KPHg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL1+GrUQmOTnqwXliR0s7vz/70shoQ7ZkHuQ0leum+nmqLa1nqX
 yUKLXbv3ud5s8Z/MM2RgY1LNJWBJNE/RRUhgidbuZM48O+rzFJsy9G/pWQK5//F/QgZpbSo3QfG
 IYEs4Gf+egOcCOuV0LTumaw6MjAEbKLPTiKgP+wef+wuiukgd+DNUHa3SHJ2e0RmmJ50SbJ0u1n
 rsTG8=
X-Gm-Gg: AYBFou3bLUPp0TesWALWYY63/0iHmCdFmyk0LeKs5cMw+EYITxDeujN/zVx4Xhbp6pd
 caR7nrZplLavSZ22cLrj6sio5TOjeqweHAJxmLRtvwirAhLGLsRuOLHoMPy0DqBrA++YCgk3/qB
 XWHR5vSOUwT8hG1v4iFNjhtl/h+GKw7oqwtcRPNlNq6rr3pZJuriWfqwKsnsmimwJ9NfDIj9ei4
 04dKZGG+fPaAQ2DzgcljoZNeR7ddTORa1b/EL3PMoQNKuACL7fai0i4Oc2aXF99Q+hG8E/vDM5A
 RQOafvMYN4/p3rmtkimByb4RisRpRhDph+X4z4VyeI22bZ3ZfRbf8enKAkfqXNcaeizxHZptZrD
 xGQLTgfpW0RePT+6civB2Hmy5zMXXenv1aNJaDZPu8Teu9w+e+1YqVapGqdcZ
X-Received: by 2002:a05:690c:f89:b0:8b0:c6bf:a67f with SMTP id
 00721157ae682-8b157e6bcedmr26249617b3.31.1792777490546; 
 Fri, 23 Oct 2026 10:44:50 -0700 (PDT)
X-Received: by 2002:a05:690c:f89:b0:8b0:c6bf:a67f with SMTP id
 00721157ae682-8b157e6bcedmr26249367b3.31.1792777490146; 
 Fri, 23 Oct 2026 10:44:50 -0700 (PDT)
Received: from x2e.lan (108-208-224-205.lightspeed.gnbonc.sbcglobal.net.
 [108.208.224.205]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b163dbf92esm2823357b3.32.2026.10.23.10.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 10:44:49 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, Michael.Srba@seznam.cz,
 william.bright@imd-tec.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, nathbappai@gmail.com, macpaul.lin@mediatek.com,
 jbx6244@gmail.com, dlechner@baylibre.com,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v4 01/12] clk: qcom: add GCC clock driver support for
 shikra SoC
Date: Fri, 23 Oct 2026 13:44:42 -0400
Message-ID: <20261023174443.1552137-4-tyler.baker@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021160916.3894471-2-aswin.murugan@oss.qualcomm.com>
References: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
 <20261021160916.3894471-2-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2OSBTYWx0ZWRfX/Nt+AKXt4HvB
 Luk2r9qoFMW3sCzC6A1gII7dZuVyfVp385H2LiBXUwzf5fosGhhT2m+0rOoG2H37AfEFdT6OVff
 xde0YfJy04qtNAtrIL0Bu+MvBobtPRYMbKbmTCk3LK+SNqQll/SJo74GcPRSntf9ByyTt54kXrK
 ivyptAa1ujG9lq3ZPyacRy68Vdi1HU68ub5SegyPV6EiA13KgZt8E4U3XToJpJfLlRhwjVwpva8
 mD9f4kFtrKsYp3m5YkCUJldUr3VePejBkXaBI5R269qh8rwLtbomsdZ+BCzo6rhAw5vVsPLd11G
 clDOZGkVvtOaR0c6oDJg3ZXOLi35BG6JmAKOIPW0B0PPop7msDEUJWiTaLUDmwCzyCON2rOBNOG
 Ut7hltCvnd1fBETpOAsLsLWT0ePn/TmozanDrs0eCVJW7/OHo5ey+58aupagCegryhyIQv6V9MB
 EYyx0hSgpDnCMxJtxvw==
X-Proofpoint-GUID: 8UD7HeKXt3Oy-2P7NLl1s7PdYAYbtDpg
X-Authority-Analysis: v=2.4 cv=Scxi5fRu c=1 sm=1 tr=0 ts=6adb9d12 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=6RV0hZrHneF7dcpHI_AA:9 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-ORIG-GUID: 8UD7HeKXt3Oy-2P7NLl1s7PdYAYbtDpg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2OSBTYWx0ZWRfX0ruUfF9qhYRG
 6Ke6f/ChK7FFYf40xxviAV15DBjoxWSdNKSHALisxToHATAIebix0AAZRtBOOGrVP7lu5ii2jHv
 D+DbzGRSwoU0wIRQ14/Wxgmamy6+A9I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230069
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

On Wed, 21 Oct 2026 at 21:39, Aswin Murugan wrote:
[...]
> +	GATE_CLK(GCC_AHB2PHY_USB_CLK, 0x1d008, BIT(0)),

Can these use GATE_CLK_POLLED? Most are CBCR-backed in Linux, same as
the sa8775p/sc7280/qcs615 conversions.
