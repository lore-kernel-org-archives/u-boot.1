Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3971606A324
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=I0QxyVP+;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Bvi76Dkv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ajawKMUB
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81CAC60856;
	Wed, 21 Oct 2026 12:46:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RLqMojckOx_h; Wed, 21 Oct 2026 12:46:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 55E97608D0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792586765;
	b=tRdAqnXld2t7LZvx8m+s9lwWY0VMGYXNKBJmG0FLlvyEWsfW8WR2qd/0+rQjLVj+Nooe
	 5a10e7/9WayCrZrF3E1fQwUVoDIrUd1+JnMa2VYt1IwDS1q6cq1I40VQFgRTdEfeCFfIw
	 Chl9SvoHI5bLJhcZNh7DLSDJ5dif2W/CpcgadI5wG3NFZRjov9dD4kC1a+Bt/oMjcjH5c
	 V5oPFy4aKog5OZF7y2zWDepoDP2f/SNMU2wPV12nSrSqv4J/COXoaX5n3eXWh6kUH4Fb8
	 236feApsGJu0BGWVPIYwr5rcYUl3y0Qd49nDkJtKfvb1xMZY3hgMcaoha3KH0Fcwesw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792586765;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qyCmX0137Sooo+UY82mhSFkFpAtkDIwAlnYnDkryFuU=;
	b=F8hwNyoYDrU9t0Tcx6NS0gYTGnjfBFrzVDURQk8/HXnhRcEs7rOWd9a96pQvW7D+J8T3
	 6XVs/c632c+k3qe8YBPxtZbp1xEXR2Jw0liuSCkXSZm4mxK3F9h9kOq4mXb9ot4t3zqEu
	 Wqgpoed62IN8OlmzaRT/7A6vZJ4cyXwaRUHXDXQe2QgotGi3YEHIPFxkZDlxqwNdQDcjn
	 Bldq9QqLrFjwGABlb3B6EIyGy3nsbAeD+GEdgq+roCsXo9CgDdZGkIoyyRjsSRmLJ9wVK
	 JYhBjVv23cGIENQOdhceKH51+3B5EK+d1kw/S2tI8Bq2h5LrpTbVp7wXe+Xu8x6rOEA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792586765;
	bh=qyCmX0137Sooo+UY82mhSFkFpAtkDIwAlnYnDkryFuU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I0QxyVP+KbZFdLt7HXT5J5xzJSbWpbP83yfbPHvnJJ7ZVNIPKfByTtjJz1lDdACnk
	 ZABkrNoqVH0RM09AsZUcVUuN1Dkcnj+6cvoWvEZZh3KVLtV/HWGKpatjbSe+FqTYwj
	 LJe6fBDw1GcbKulOsZftDirbzXugg4Rn6+cXRRCShbM8Pgt2Z2MHoM/Pql+pROC3QV
	 tmroi38vUIkIE1RiuKSd3vnuVRTX/wqZwx3zLKXRsdgB4oSP0Dg0JIiGCPg0O/9SKH
	 bKLKSIJtbkTg59pdK/6sq7IamXSkvPdnpFjz1watoBneDuDusLCWDigunUewmvVsZ6
	 A/enRZA5ONCrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 55E97608D0;
	Wed, 21 Oct 2026 12:46:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 564E82A8
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:30:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3C56340560
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:30:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mrM4MLErGIwz for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 10:30:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C97654054E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792578640;
 b=kOJA85FxDY3wTrqZQhjeNudT2aeoS6EjgmSKCWxyTNdEGAH76OU/5Ds2Ey1pEy4Jl8fc
 z2flN8t9sszByLHivcX90pszlXmRADNgTIVqAJneL5aRzKKh4F4FozxAdsQ+DB40CoFIe
 grZEWYzFmVFCdM5uV/JoSi2cApRn1g1kIJB9AaGfBhDE+LpmTEaCApsZs7Nh6FgoovuXT
 KoLYDNVy74ZNAiiDF/BBpo/FE7/RGBUVnVkLgIBfU1u5BO4v0nQ8iRfrvaHLXp9ITiP8Y
 ElbTuCk7v1n2J5MAJrM+T2tZUGZYqLQnG649XKuXyhmOvV3Pu6mncQOIzCvceJS8XOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792578640;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=qyCmX0137Sooo+UY82mhSFkFpAtkDIwAlnYnDkryFuU=;
 b=lQvt8XswpYv/YMkPEen0ru1YV/mJCTKpWDpeAHp85e50KxNS+GI8C9QlFsgdxVxrarNn
 fAEoujlasnlrkCIqgnGTNlKN6bhHRpWhfCwT3CvmqN34z6alWMY7PTIYIzS/dD3YNNXO+
 kxdja0spVTyCVivY738YyAKnfZPom0YribqkKDJYOUW5PQny0kjlX9bPUx2xC2ah9ToR2
 RCB6+QrC2L8kLPj1XRLqb7J9ZeNBIYh0wMUx4BBXg3CKcvMfAzr0dRcYdMTJUwdxG9rg3
 jYgOL3Z3fc+cXo7r6+YRE5I7EWkncppKNsdsFz2BOS9YsVxr5kMXp+UOy4Ljd1T286w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Bvi76Dkv; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ajawKMUB; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=kr.sowmiya@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Bvi76Dkv; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ajawKMUB
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C97654054E
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:30:38 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LA6dLe4171532
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qyCmX0137So
 oo+UY82mhSFkFpAtkDIwAlnYnDkryFuU=; b=Bvi76DkvXPi3ZKGoYuVYGgpg71m
 OukEaZoXrKWPf4mXAWwxZUEs3p/IdkrvE4KeCVpvpjzs9Z0uq/o7+KfQqApZuYqy
 1KCuSeg+TJTj7XRgv9dtsp8srrKN2LQtaKsPuKWy8wfNWa/feJsrBjxAb9YgYZRZ
 NFyKnCixvP6RMwvnwtkpqSK1FCBdhPKNOeMie5LsfWBqpXVMnxKCpKGNw0XuWW8o
 5nqDO5XpWB8U7KzMSp6U46u+rOPCegpOnzDwRkUo3WBpfcT1dphpJB+z/d8yti+7
 MEHOdi8VLh0zWa+GylxyS3HA2bv07s/UgbIkul9S/D6/82QtheJfLCdvgCA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hed9huf4m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:30:37 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c0d568830so1343888eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 03:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792578637; x=1793183437;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qyCmX0137Sooo+UY82mhSFkFpAtkDIwAlnYnDkryFuU=;
 b=ajawKMUBQOZNdsCTneFl1tr6aEvzPXKeesLxvnVQ1G+PwZckkNE7Sh2+nUIVkxfhsJ
 IS4rhhcrViVW3BXqec/eTzNTk4gGLn9WsdkuId+pGkxnBr0/V5KDJ5LWvgsy86Q01hZH
 IjaafJ3lb+edtApW9J/0RPhgmYqzkxJgRUrlxPZ+wUQliphcFT4jimK+Ycy1iDurRWSt
 vnpBfZ+PldoZQL1wpVyLQo1BM4yBxUwnUWskI6V3UHWm63y+Vyu3WzB6P03OHOEib+xK
 UXi+dqvHvsl6Y8ZIuuGUe+cuNojak4UClgHSpc/VfXyCC8XwMmOvy7J/k8dqoT2eB1m+
 sq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792578637; x=1793183437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qyCmX0137Sooo+UY82mhSFkFpAtkDIwAlnYnDkryFuU=;
 b=aIpTPaRX9UBmQeHkZAKFRpTsO3WCmVoVSb4VQihYzVkZouHqDBjLPCgVTvFj6gF9e8
 TXTVeJkcNk3R9z25Kq1oUZyFRCHsz8CA6vDOcPvRnPsI+3M/LrgzbK4lIu3Fsop3a3Uw
 T5JXco46JunGhIIEEbMA6/kQ8eFXXxgI3lKfK7gd/SZ85PCF3k92FYNTLoMMQuGtk9gh
 83PuT69QEg99YPdcTEO8i8HlOEc6zrWiFobyrdvmDOg/ktAXtyNtmlfMhPHriUQr9wp0
 F4TVxofqSJ/jfIWKXZMOGUNIE/1d/2dPokZmM3cdNNcdQRHLWJAokZ811ibqdnuBveaA
 GxWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBylPzqB0KQ7MJ7/8tNvm68xlLHOMDA15QgwmsausOX4Z1LnOS+uzxjttXIV0+JhjteaHddfXsM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJmur99olZPgqbYAPsBqp+rj6HYRj41qI21jlD/BjvDv9S7MltR
 ghqO5Fz8xFKVwKzJOBmSbwaDp90xje4JDtyalTpN5gywKohSBFPX8fku5h3x+j58GuTFAqG/dsH
 ZLlGCaZtOpMglF6iy8m2qGBo0/yjt/UAtKMQVm5TpAubAaRPFK3CjI5J4A8TgnR/MAiDIL/A=
X-Gm-Gg: AYBFou37inXtz5L9WtMBCvaFt93+VZ904oVfeV+7TG0lRcyPxOeQJ6/LamIYPVn3jPy
 7IjobSOg/74qIE1zRV1NWnG4PK+5/4xcBU09yAMGM0Kki1KDKXTsYZsug3wOrZo0VI/zgDkUe/y
 7GBWpmY1zp5dk87CVgtWQ8odpZDv25q/8n+Wi/fMZa4FZrb7j1rCct+dU1ZursoR8BsfesAMlbl
 0F46TTwrIFHN8uT+o2yURclxdudCIzKyhYHqX/Zh98VsoR8FDhxGQVcyuODq2hQf8VG+GGLFErb
 Q/fSagBkhZeui8B80ORIru8eTqj+pWtSCOAeiuQ7yESGpJwFY7anSepvljc+y0cu+fOsZZxmClU
 S3XVt5xGgxWY4dA/IuhFiV20ufZAG7zMQo2pXG9ZOkd4wogTIXavz2KXlLa2N6+dszK0vzo3t+8
 f1TEw/bQ4EMhaK/NND
X-Received: by 2002:a05:693c:87ce:10b0:35b:244b:ca8c with SMTP id
 5a478bee46e88-3674e04eb13mr2647029eec.33.1792578635998; 
 Wed, 21 Oct 2026 03:30:35 -0700 (PDT)
X-Received: by 2002:a05:693c:87ce:10b0:35b:244b:ca8c with SMTP id
 5a478bee46e88-3674e04eb13mr2646985eec.33.1792578635262; 
 Wed, 21 Oct 2026 03:30:35 -0700 (PDT)
Received: from hu-ksowmiya-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367405edd7bsm6147480eec.6.2026.10.21.03.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 03:30:34 -0700 (PDT)
From: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 u-boot@lists.u-boot-project.org, kr.sowmiya@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, sjg@chromium.org,
 abhilash.v@oss.qualcomm.com, u-boot-qcom@groups.io
Subject: [PATCH v1 1/2] mach-snapdragon: Kconfig: add DDR training configs
Date: Wed, 21 Oct 2026 15:56:01 +0530
Message-ID: <20261021102602.3815107-2-kr.sowmiya@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021102602.3815107-1-kr.sowmiya@oss.qualcomm.com>
References: <20261021102602.3815107-1-kr.sowmiya@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YuKa1IYX c=1 sm=1 tr=0 ts=6ad8944d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=cjRSCWi10j7wZ1Xdxc8A:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA0MSBTYWx0ZWRfXyHQxbn0P4k0G
 h5Up+KasavciCZ3O6AEQ1M+w2bdECXMP24+1GSVbZ1r6fQcA6xajODzGyPwnIJSgEdSVd1JbKsF
 ffsZVYKQ0vzWqzknwomJBR83eoMflw0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA0MSBTYWx0ZWRfX8W88sOyrP4ag
 EW4vcGv7Nf/t4uyBqt5hBrs+7SRKOxOwbyyltTd80jdQFIbeV90GUM78YcvYVA/6OvDi9W0ek7S
 bpKZ2z8LsfJ1SqbdbBZq25/d/pelnzRspnP2suqa0CybC4jyDjAKuiRnCJkXJIbDe90Q/b9e/9r
 ctvx/4Y90LsVY9GvOG5UcHH5GtQhH+gmMNlzwCylSkp/hiPouD3i0SM9+rWbWD2vS1cTobkGy4Q
 XPv4AJA1yXE3JmSvZEWYYhQnc+7TyroqSacaofG3VLb4olkds3LToZ9ObOICv6mlSY+yAxeYA3U
 35zIUjSd/Hym4dBIHh/9E65tOsKe7gwzb1/0yAozO3tN0Ko/RDMolHzeo8KaaAg51oc1sReD+iX
 G8IpE+nfxhPBOutdwgiqACUOL17mn00roCXQ5s6Zs2Jqr6E0upwe0Ck0qWWke16YrY9W8GIrTOE
 5CiYg/ChJCdk4RnMd7A==
X-Proofpoint-GUID: RAJ6apq0eYZLWYj92X0kyuUPj5cnkJQu
X-Proofpoint-ORIG-GUID: RAJ6apq0eYZLWYj92X0kyuUPj5cnkJQu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210041
X-Mailman-Approved-At: Wed, 21 Oct 2026 12:45:42 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add DDR training related config definition as part of feature enablement

Signed-off-by: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig | 43 ++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 9e23d6d8948..0855cb204d7 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -93,6 +93,49 @@ config QCOM_XBL_SEC_ELF
 	  The image is copied to the build output as xbl_sec.elf and embedded
 	  by the platform SPL linker script as a Qualcomm XBL-sec segment.
 
+config QCOM_DDR_TRAINING_SUPPORTED
+	bool "Enable DDR training data save/restore support in SPL"
+	depends on SPL
+	help
+	  Enable support for saving and restoring QCLIB's DDR training data
+	  to/from a dedicated storage partition during the SPL boot flow.
+
+if QCOM_DDR_TRAINING_SUPPORTED
+
+config QCOM_DDR_TRAINING_PARTITION_NAME
+	string "DDR training GPT partition name"
+	depends on SPL_PARTITIONS
+	default "ddr"
+	help
+	  Name of the GPT partition on the boot medium used to persist DDR
+	  training data across boots. Locates the DDR training-data
+	  partition by GPT partition name.
+
+config QCOM_DDR_TRAINING_PARTITION_GUID
+	string "DDR training GPT partition type GUID"
+	depends on SPL_PARTITION_TYPE_GUID
+	help
+	  GPT partition type GUID identifying the partition on the boot
+	  medium used to persist DDR training data across boots. Locates
+	  the DDR training-data partition by GPT partition type GUID.
+
+config QCOM_SPL_BOOTIMEM_DDR_TRAINING_BASE
+	hex "IMEM address to stage DDR training data at"
+	default 0x0c368000
+	help
+	  Address within BOOTIMEM where DDR training data is staged, to be
+	  consumed/produced by QCLIB via the interface table.
+
+config QCOM_SPL_BOOTIMEM_DDR_TRAINING_SIZE
+	hex "Maximum number of bytes to stage for DDR training data"
+	default 0x8000
+	help
+	  Maximum number of bytes read from/written to the DDR training
+	  partition and staged at
+	  CONFIG_QCOM_SPL_BOOTIMEM_DDR_TRAINING_BASE.
+
+endif # QCOM_DDR_TRAINING_SUPPORTED
+
 choice
 	prompt "Qualcomm boot0.h workaround"
 	optional
-- 
2.43.0

