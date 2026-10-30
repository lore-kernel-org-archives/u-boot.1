Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4131B606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 12:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=orDMN0yy;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qfyx1mq5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IzI0HaiL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B6AD60634;
	Fri, 30 Oct 2026 12:20:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dzvvdXykhvZe; Fri, 30 Oct 2026 12:20:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A8D2960679
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793362802;
	b=FqemsClyCJ/X9UZrWGo4sqr+yIhItNa47jH/NC2pcs82pPs6snYt1msYi7mEsA4afzbi
	 oN/murjHn87bzKxyOxti9XlsFyzgfmB+lDl2w6RNKyYmvKiWUzzfReH1RdXqNMZtOnGkQ
	 hQ0KBZxmiZU0Cro9SYCHsdQc2b1dOdCj+xahUjexJIGKesWgLI+p1OSu0uEFIawfelJvX
	 BLdZH6s/CeyTRMNgD+duOm2UAz4UHINOyuIrc55Xm1Eg0b8GYJ6WxsEROKOs4oRnFFgeg
	 hZrlv/ikdHofBPjs6byRa8zjhb1ahY7eSxkkY4IpnRt4mUk3Pf9hODlEdVjmw9u7/Eg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793362802;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ft2Lf+XemvttYrKH8UBtCEKrwl2lhEVvTKT4KYAsdII=;
	b=JO9lvCB0Y+RFWGQeeCwQ0IYA14IdoMKvMCTn5TKjIAy3tsNQsIzdtgLrpCL34iCNYfzi
	 YLhK+WJ3QNJwwOD1pch5T13E3Igi2njk7ifWZBi1yZS6rY1T/5DG8KRXW2hvR+JNyzGJM
	 vs1oQ21RLZKEmjoagoZk0exaqYW+va54wcaGzP/2vWVG37lYyVkxXuaLOUzPFL+Ll7Fnh
	 1H5/lWqmSU6OeiUfwJMgX2Y2YDLKPm5E5WTICIAuWll2Qs4BStHLDd8FZGY/atsP1b//y
	 MrP74Eul3wb5PyAOHQ81Ws+EgY036ncrd3RhXvLUOoVHxE9a+C8aSKGyl4mcJOXvLCA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qfyx1mq5;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IzI0HaiL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793362802;
	bh=Ft2Lf+XemvttYrKH8UBtCEKrwl2lhEVvTKT4KYAsdII=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=orDMN0yy2orBbbXzIeVbWXvaVAYGLpfupDuGaseduoFrtPsJrTGMT4OKExfALtijU
	 4hKPmodPf+8kqhqgLw6sJTL/+jpZsy5O8xHJvCrH6WsWg1CJ0m2bVTfLj2CNby0bYd
	 JB3pewFIpXrV7PAEHRSc8B3KZLR9D2mGiWBDqzF6qIxRqNc+EyC9jyhF3K8dU2xFHV
	 eYQsFio04J0hKaHWkMhVPzye+hWfXVk4xiMjoetkEOUyBzlrnw1hPg1YNqb+jGA9PU
	 trNxdZ1cglLO+UtK32Np+girPyZXl0j7ojE0zefoipsQC9Xe6cX6cn78S7EAZ4pl2R
	 1Ce3EtamIgSCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A8D2960679;
	Fri, 30 Oct 2026 12:20:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D75414BC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:20:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BD4B860634
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:20:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eAjK6E_rJf8t for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 12:20:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D39166061E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793362800;
 b=sZq3ptBY0js8PtE84Y5vGN4TuBs0fHKvtHFBU+LAm6RmfzWx5A/Cg7HdK7hBI7dwI740
 Z92s6WMR9s76kilBHsArkHLYwv5h0IU4Fl3NeTG9yEceO5TgE56fOFMentUEEAR6FZJ02
 o3/TLMoNz3pukMacRK0oetO4JsTjfR94Mbi2hoov0JwnBc74DisSJNOYT029FEQWOTEhM
 651pl3eV2I/NrUVbo4ce+JTVpN/LrO69jm8RbB92klFaEA76dg9SKnyL5aj6B8LDqR23e
 IXZmjPnW6WucpK4bEYVC+jMX1cWk+FrTPkhM/C7rRcMYtyAwIRfJ1vc4eWkiXcorOPw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793362800;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=Ft2Lf+XemvttYrKH8UBtCEKrwl2lhEVvTKT4KYAsdII=;
 b=f2UlZURo9Fwp1eikJ/l6D4X3pM9Bda8admar8xs1BTaI+6thdm2+zp8D1Nl2ol2+zR6V
 E43xoytdkXEl6rrRnTDz2CPVVk7BhN7lrwsEujBiSTQcyx4VRSKCPgv80qzHbKXuHCs6O
 WYJIbTXxAIQkA7PnLvcyuD/q+GZ8ssRNoaHAQjb/El3G830F2Ca5FDGoJMFzkB54hqXWH
 o3WZQ9F5S+wLR6ZDiEVsSQlPlvl3dnI2xsM3Gzs+4vmECrwtZC8IpONFjA1HPHHyx1AjU
 nuAGGVik0weCbFXdykYDyzFEd85QtI8LifUR6y5muYz6QkITPFIvtO9opyb03lPLINA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Qfyx1mq5; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=IzI0HaiL; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Qfyx1mq5; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=IzI0HaiL
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D39166061E
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:19:59 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBGCnb3142215
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ft2Lf+XemvttYrKH8UBtCEKrwl2lhEVvTKT4KYAsdII=; b=Qfyx1mq57uR71QW1
 i03IWPFbs/k7hVs+ciiWm8enEFzSeu8OslbSgjpQ1LKjMx1wAyxfSh+brLb81TFg
 FXL+zsg8JNw9SRF1PsomPFc7nsQTmgXNEsQjiYZcsJgsAycT3liINgWcU5qa8bfi
 eLQ/EHC8LHVxlYc6oA5jTBltX94ceNCbGGumoMxIV37dtb91j2rH2aoS84z4frr6
 dQg5Vf9LD5ngHQUSECtVOUbVnd3FD8i1wdQNTXE+Z4eRVJFtvWjxx+j/RE/V4ul0
 VKPyrILWmKvRNzXTwffTdZyrsaN9tR8RDxxPsjgyDIChkq/8/nbfTq0qQQBgkRZI
 ejGG1g==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qjy6e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:19:58 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-67532014b2fso999631d50.2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:19:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793362793; cv=none;
 d=google.com; s=arc-20260327;
 b=FXB1BqOEhwic1kvHqZlBi871lqPnoX5p80PhUaS23fCagFZtbj4EvnVnq508US7RLn
 ZWH8lEyJ0Gg1SrE86Iv73oEjer9IAxx492XmPh1xYTbDT+bZwsqLF0gW0nw6sJRtvKX0
 70vNh6X2adzxfzQEs3rWKseRiA3Fg8oJc1Sv8ZJA3Up+sXrYuu08ylus6biMvHHpDHmh
 u/rjCI9Kw8rhxNuBqFjwVuu5dqpJW3CN4bIecdSDTaOzz0fK85EgbSmPT3MGrpIX6WzT
 uaw8/UVAb1tOEise5Uk32/hmLgNs5L6NqxNn2f9oAACgn9Sw6Njk71QZj2NuA50wVYdh
 01rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ft2Lf+XemvttYrKH8UBtCEKrwl2lhEVvTKT4KYAsdII=;
 fh=k3iHC0eQHRHT3lBfVdj40ufJLYpBywE9GJJ2uVT9Ku4=;
 b=KnjZZgpn/j7jHZhFpnriIuYvEDJfK1EV2BG/akDBCJyfDe7aCGrhoNNsuWFRuZ3dSS
 qto7FlhNLABZ+p+Y5P89OHmAIrlWNhzrm379zv7cSWF533utR759e87PUP2/GyHndjpJ
 6Y0H4shwYsKXXeiylgdu6+vlpcgK/TOcIA4/dLPh0LpdhDsXR4uSxp1AibiA3HgxPnmu
 l7NnGZHa7X71n4oSptKEc3OUy3bGtFjUerbNjGYWLFzhXTciWqoeLl2uFpupVnZOo/y7
 446TDC+W50/v71f/afjs4LrcOctPHQG5jDgS10P2iF0GKJ5ELjbTY61OGWJfXG0y5AgU
 hrZg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793362793; x=1793967593;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ft2Lf+XemvttYrKH8UBtCEKrwl2lhEVvTKT4KYAsdII=;
 b=IzI0HaiLTfrenaBcs2FjZlS7XhqDjJfNiLjki09mqyMLzFysmvVSz5zHW53sBODjHj
 6/hSuU301Y+Qey89N5qLY34qL/pwUqid7eYCdvNY0+c8hpEyPB2okorL2mIxXZnfMe41
 X4bgUn2uAAv9pOGEqXta9dRFQLGRkezamc9YigIMPQ6B1yVICeK5rQCyXbhJJ/WhZTzz
 /aYQN50IPe+qEZTot7vYUuVjjzB/5hKLVU+Bjd3hQmI5nsOVJxdBBCjNPvAtkm83IryP
 lb0nNmHzOkQYl6S5NcdJwGSSxxYmekgUbflKJT7fSAq7ehT/+TWp6370e032vFb5zC+v
 7Gmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793362793; x=1793967593;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ft2Lf+XemvttYrKH8UBtCEKrwl2lhEVvTKT4KYAsdII=;
 b=I0w0szzkJCO9Wpbq08M2j79rT5Xj2He8NcNqmP2Tyq5pQKz9Vtd1fp8fZTJtzJGTtt
 p4NkNbtJIpk+c5/l1xhim7X+b+kMQGTvfm9jJHw3qdv5xJEGo8lSeWhTvirHkm8jnAll
 YxblF1rfcsausqrrOrxnJuFi80hg2w2tQ9k9/LwItsZZywLoaKXs2NM3uFvuEQRkP2gj
 AKxbBOoxT/wSEgSzGtkhgU9Jw1jBERj1WkjdKaSP2rWe8qoneS0kOmOBN+aJyEQxWYbt
 U9edzaGCGILdTiZTx1UIUVlUJ/YCjm7dsHAu4WMqnBte4kAwK8OxIZWCGj6nno46GsSQ
 9d0A==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/JgrXj7XwKqP6sobyku3Q+krJUAeXlpjGwSEZ7TODCdA8uVWCDZNx1dOUoaFPqHAk4mxOuCY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJjA5nNa3CyDHVQ3xxk9D2CoD3WREoKQgL6SJJE/kV+cgCNRPtk
 DvtzbUPq+1I8hdtQ0da/IJPzpAphypqs+7VVqLJHS6NudbSFHC8rRIuEF0p5hHPge0jqfmjhhvs
 GuqLteyLJTEdu9k72/JHWTeDE0TfiiFr5a927ObrjMUQ1c3zVVIBaYU9ZjYNMAUYvyiqJjiIzOp
 E6us53JDBDCpag/OZZfRhHhDBKuuD7U+8bPSRqEYPmcMiMxA==
X-Gm-Gg: AYBFou1+Z5PF6ZT4+X9bgg3zOl5F3tpWsxnHz7BZeENEXbrboiPuh2n+xq4/EKhxHpO
 GsM/VXiDXmoDjMwUGK1RK5bG1s3UknLsagEPiqhHL//t23UmYQ5swx7RRyXx/vqRw3b0ymnnatY
 W2UwYnPmEToRuCYzqROpmZZIRyiPy3FAINQzHVInf4nCZCtjPjhV3hGZw=
X-Received: by 2002:a05:690e:1c1b:b0:679:a252:70e7 with SMTP id
 956f58d0204a3-67ba4e955c9mr1708565d50.22.1793362793024; 
 Fri, 30 Oct 2026 05:19:53 -0700 (PDT)
X-Received: by 2002:a05:690e:1c1b:b0:679:a252:70e7 with SMTP id
 956f58d0204a3-67ba4e955c9mr1708558d50.22.1793362792614; Fri, 30 Oct 2026
 05:19:52 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260902170559.3225833-1-aswin.murugan@oss.qualcomm.com>
 <20260902170559.3225833-2-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260902170559.3225833-2-aswin.murugan@oss.qualcomm.com>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 13:19:41 +0100
X-Gm-Features: AclHuK8ZZfgtipsnp8cc7gx_CUeJgqpQcXUd59IbsRJYTqJmH1lpA7uVp2oy8sM
Message-ID: <CAPzfCAZxoeROTPf+OWLm4H9B_sLxhMw=mM+m5PMjH8EZU9QXJg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mmc: msm_sdhci: fix max-frequency read into
 wrong-sized variable
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, nathbappai@gmail.com,
 varadarajan.narayanan@oss.qualcomm.com, quentin.schulz@cherry.de,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: oGfyvjHWgCTQxv3jQ7mKZF-DZaQLdf_q
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0OCBTYWx0ZWRfX2z2165wycJPA
 6S6XPU+66Tcc3bVoJyTmxPSiICm+hS6roYVH3ISB58MN4aJ0alQFyByjkaVY6qh4k6+R+KjTPsF
 TG3nlpAW0/Z0bnEfoB+Z+00rAhF8Mk8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0OCBTYWx0ZWRfX+WMhbnrogHou
 5YLxIBtlJ5xpqtfshXuG2/9/WKkUPckhDKB8wm2vI3Qrp4r+LyjHyf/0+Lyn119I/oxa/Bcdf4b
 TK37nZPLaeUIJL0rUxuEDGgd7cgi4++cxy2Efpxeq1yuRURvfwhr1IteCDrE3fDWOOAsB6png4E
 Z3P1SoTcxOB5wECwSM61tV8PUhT5ImCArZbam3QhN7hyQIGmPRkwOLYQIrsZIezZn0xHKYz6ByV
 Vd8qP+WuWXbjm1ZjRxup4CCla4jSZL6wmF7MZ83EjA/Lj84YGZZjZW9xEgk70pLxF2ojlTSHwpg
 +08tzTt+1OEcc19RIIxjiL21QvLSw5wjcBl/nDJJiaILHLjdyNcupeLacyzZi5c2BWSxqyNPVc+
 t8jUnpI83fmpczFrbU8Crt+6UroxtCTmLc7kM4wFW0titTZFn3bVw2qo1h2XdloETh3H/uLzPLI
 v7Gx9G3oVoZ8NWZmFNg==
X-Proofpoint-ORIG-GUID: oGfyvjHWgCTQxv3jQ7mKZF-DZaQLdf_q
X-Authority-Analysis: v=2.4 cv=TpVzFzXh c=1 sm=1 tr=0 ts=6ae48b6e cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=xOZ-w3URlxOM5qECcykA:9
 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300048
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,KHOP_DYNAMIC,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Aswin,

On Wed, Sep 2, 2026 at 7:08=E2=80=AFPM Aswin Murugan
<aswin.murugan@oss.qualcomm.com> wrote:
>
> msm_sdc_clk_init() reads the "max-frequency" DT property with
> dev_read_u32(dev, "max-frequency", (uint *)(&clk_rate)), writing
> only 4 bytes into clk_rate, an 8-byte ulong. The upper 4 bytes are
> left uninitialized whenever the property is present. Read into a
> u32 local instead, then assign it to clk_rate.
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> ---
>  drivers/mmc/msm_sdhci.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> index 7bdb02142a2..e0753a1cd5d 100644
> --- a/drivers/mmc/msm_sdhci.c
> +++ b/drivers/mmc/msm_sdhci.c
> @@ -70,8 +70,7 @@ static int msm_sdc_clk_init(struct udevice *dev)
>
>         var_info =3D (void *)dev_get_driver_data(dev);
>
> -       if (dev_read_u32(dev, "max-frequency", (uint *)(&clk_rate)))
> -               clk_rate =3D 201500000;
> +       clk_rate =3D dev_read_u32_default(dev, "max-frequency", 201500000=
);
>
>         ret =3D clk_get_bulk(dev, &prv->clks);
>         if (ret) {
> --
> 2.34.1
>
