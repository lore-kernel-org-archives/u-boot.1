Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49A0606A324
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TkzLb4J4;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NNMbF0fg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P0HYQZVF
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B40DE4080F;
	Thu, 29 Oct 2026 10:58:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j9M1-OomHw8v; Thu, 29 Oct 2026 10:58:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 41B5F40814
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793271499;
	b=rjjywzEUQPlpbBRva5udqrSBJGFq4X2WzBCkPksAKnobbl98R1qQXUuVKaDnsg2m/61K
	 zewPdiMNUlHftWcmgPjUq8sqkGJVNurBxUMIkHdPNgZRohqojGo4zdVvjZ0kFtwxLcDpv
	 RVo5jYDZUbTk0X8ffDb2sxM9ZM2VH/3124HcJ4gOJZeRdOkNj2E3G9AmcOKdv8ZcYTG2o
	 xGI5hFtI8fD781DEK4qRCzRFbL/EvZozRpREzTKPsIIEDHt3xUXfEoNhwQxWCLwzqEqvX
	 XbjFR+VH070xzhM8j5L1FzE7voAh0nawTHE7tE3ofg9aE//PX7V/ZP7xiSlbjsiSoXQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793271499;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qcuwm6LZgg8VrQ4fvD12a2pD7pn4JtYkLJl1X119Gl8=;
	b=GdC0pdbKRZj4ys+gmWkLqx//Qxfnp1AKtph0WWUhmNmyW8CLdTbxme5YylqesX6H2O9Z
	 3IbK+s70ozsVvugRNfjIjwMHiaReIMTUZ+4SJPhOx5Cg5ltbD6XJhC3MBd52TaFcfnPv5
	 JWNPfKwbabvnbOSeAJELhz7CVVQTltl0YNzNUSoMN7/3XDk4I1WNCvI7qzTU+v6FVVDSC
	 6dJDu4Iq3uMKg3bryPqrayxCBTDIdhzwAM+1ZOSlR4jvzsBn+XjESJPN1gbMxwTZ/Avtv
	 kVW8hy0+uIvciljJDQYR35vO93nSpDEZnpGgYwMVCDWAxsXDy0DuW/8YDcX1LsFi4Ug==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793271499;
	bh=qcuwm6LZgg8VrQ4fvD12a2pD7pn4JtYkLJl1X119Gl8=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TkzLb4J47pvh3+z1lMoJ1uBDN96TN/nPR40DBE8hIrefDYdTRBaAquS3z9eOo6ZWV
	 /QC+4xnyPoigGytOm+n+eLdb4PNY9nHJsLwn2HLlcK/pPVExNtUzbPRnpBAmhPE1re
	 TxIVWRoU31kRPxaWDh4Q0R1ySFdOt+nN4G0k2ZxcaH7A42eqe6/+xacNhKifIN4ERT
	 r/9ou+DOTD5x2Jj/aDDAdBMLFvHAF5qfmnTnCW/5eW2ug27+tNacaJccXwNSCJe8vd
	 trmOifHlPUpy1vKjRvYgtUB3jyhRvxMdKE6PUkA6ckRkQMchZjITEV0pPLGImd2Vf4
	 dJugMtj2ekgxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 41B5F40814;
	Thu, 29 Oct 2026 10:58:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 04BD2D22
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EAACC80FE8
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hg6zpQOU3q0T for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 10:58:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 173A280FD8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793271485;
 b=FD7qZFRmIIkh0XQO/Jtebyz5Jx2F6ljemSBYc7vmAoICjMz/iRPjV5ChU0wcEJPQaQcT
 pfi30dq6UHJszS6z41qHsX0i1bYPP8EONw3n02bFJ/5q8oweOws2Yil/t3/K2wLiibMuk
 L/+g2JYGzHb8RKwmAZ/VVeRr8US8g4eJlGmboQBOOrvbUQFmyc9M6vZba1jTY64Nf+Nm8
 7Xe5ryuJfDBoCA3KoMhMr0upwPeJBoBvkVfZMNdmWiE39Xontfeudt7YbRFtHmapRlAAQ
 4Pa6lR0RVmi/+CX47cH/1JPriUVJVz7dIqTEz2TDvTiXUayTk4FwnfH8lXP4aTtH0DQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793271485;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=qcuwm6LZgg8VrQ4fvD12a2pD7pn4JtYkLJl1X119Gl8=;
 b=Y2lSX2qDOb2Y+RYhaDO7LTwJFpLuPK2LjA2PabtU3COB160kt1/fJ5RJQpoi9+7pitRD
 1UgUIP0czJjaaJihhVLNx/rDU8Xvdthf9K4BITjlU3YsCGmLIQzlPqX9h6P24uvZPynTh
 lUgPpfMtR1c144il+ACZVAcSjmFisUsqP35erEgU+4YI7C/5Ey+03xr51sd3MyaganLKo
 5JsH7/CLw4jyZgNz8t9q+blwLbUnW7klH9WqHLbSMEF4bVJW3zSrus2om7e5co3cxhPNS
 ah/dTNKi8yLo2NL9ajFD7tPSKoZuTzTuNroXsZiqHE2r7ZkBrFFIh54+m4yRHg1xN3A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=NNMbF0fg; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=P0HYQZVF; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=NNMbF0fg; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=P0HYQZVF
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 173A280FD8
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:04 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T8vBHS2725114
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qcuwm6LZgg8
 VrQ4fvD12a2pD7pn4JtYkLJl1X119Gl8=; b=NNMbF0fg6JI1Q6adhfiw4MTi+sd
 Gmb7FMKqIKH0iuv2Dyt4vD9MV4UNkjUmvNxBZlGGQPSmGVFhnmr/VlqfI9f5nJbb
 pUNmUZDzUrgELRO8BE0ycu9V3jIDF9GtjSH8ySd6uLFt8E14+LayNqz+VxT2GhNA
 VmzFBatzELtaXlynu5agmVVQDap6N82m6OIfF/ci2Hx7FEPqFgyq9nOyGTQHCTix
 +CXK+VB/BQVOZV+IHJBkzJNj0vRdeYgZtViKnPym3NrQR79uvqhzmN2HESm3WWpR
 NuP+aglHjRweX22TDWUTMznvcv8GFULTrQSMHV931WsJjwf9BWU+gcFS5zw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hky5s9bpr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:03 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1a2f2ea3c3cso3050113c88.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 03:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793271482; x=1793876282;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qcuwm6LZgg8VrQ4fvD12a2pD7pn4JtYkLJl1X119Gl8=;
 b=P0HYQZVFC04y+aD8vfJ1/rMbE5xyY+x9sVgbKbAvs19vr6LWyY3y2bvu02wHbf0tBp
 NN9GTUuzx5RmlCOdd6iRVzv7OjfdePKCk9z35NxOYA5fbDxODJgRhdVy2aaqmax5Mf0k
 Qt6yBpeVbigMpww8kVphSszudSE2tAi9EZWQ73AQ3gcBA/RajRc6qeRzo46II+cYEF+B
 geU8Oo3zPooyaZiLAziWC9jaXRMqcQF5LpD49W0qze4Ef6Z17igO2eIAWpNxEN74SA96
 G9TgKZnxTxYnJ8KCUyj7QGGQ08LdcxlHj6yAVFr6d2JVrmIdNbS60ocDMS0kWlo5aEsJ
 F+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793271482; x=1793876282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qcuwm6LZgg8VrQ4fvD12a2pD7pn4JtYkLJl1X119Gl8=;
 b=SYGY+wgHGUcqjbeYupn2K8WsVPm6rg/VXvp6C+8XRdar6fZSy68v5PicJ1IKA498n8
 c9Wphciq3YAQw7EGOk8IKeeJm+1jfk+nNmqbONT4BzoXkkZ7eCSi4zbLO04hQeRBZ5W4
 BzKvTToxfVta6jk5zCwWYiKQvyPaqHg52zMGVVWzLWCpXCbvU7/CGMBRDqooRCqbLb4z
 /FJyVrbvHG+zZj1cZGLUURGMy/gCAG0d0GLFkFShpEfNp53DJmaRLGQwkGCgW49iu6r9
 WVv7Z8Yf+aPDZbXgqNT+hL/5mc1Iww/GWuSFHQRXi+cSuNxYYTFeloqGU975mr7jee+7
 heXw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxIK2ofyg4O9ZvPrDRMuzt+6LoiDmsO53nH2oRbjVMJduzc37+ZXCeK04+kQTilYo4gPihMBuQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJqi1O7rxNm3QjQoLRYqCCVhE5W2+3Ej2q9N9JR3YlZvO25vsIN
 9MmZNDmVHBkMQ/NnwSrapkSeXB0P2pZXnHUNwn2Bzgohbz3izdSJNTM5mOlKuBCozwyIDfV9Op6
 NCfp1c5a/Yhvyr3yESkI8l8YwixwkK/dgCsALkNPWm8v7TOE6l0mRGhBvb/OKiB27yzs3zfE=
X-Gm-Gg: AYBFou2itFyjd0DKhBF7ljZbN1Z/zxxxT6XmczsPlyoYyGwpeGAt/4HbYaULdMTjtnD
 as1/NftkEjRTfq68Hh5fYOncgxprZS8w5eRltBiJDC8Veyv6GVB/tL+eoPkYH3cNODdkaSEqulT
 7ywVSsyVcVorylh5S39+yzuXGgaq/WuAey61+o45tgjHrE5pOrOHYEQXwWb1bZ2r0WFaznyRmOY
 CstlK/r69jtSmZpkJEN4HfTKPENh9MshKNAygqNj03Yt57Q/ljUCWuDOguCF+sYZzN2iYvJFfC4
 mZjJWLSlSmAZgHEbeqxcSWzr5awke2cuLfrrBDSFNJuh7T+kO9udHIJDe0xrDfLn3YnoERpAC2P
 nnHFoYVhC5jPBTL2h6glTGrceBeZ0JRgkUeB8UCd0ym1eeoUr7DHXpQGEaulN4e5uhVUQ+sYpOj
 oeOWMjjwe9vfnQZ9Twm/QYyg==
X-Received: by 2002:a05:7022:4181:b0:193:7fb5:2c3d with SMTP id
 a92af1059eb24-1aa758fee40mr1816427c88.21.1793271481838; 
 Thu, 29 Oct 2026 03:58:01 -0700 (PDT)
X-Received: by 2002:a05:7022:4181:b0:193:7fb5:2c3d with SMTP id
 a92af1059eb24-1aa758fee40mr1816346c88.21.1793271481049; 
 Thu, 29 Oct 2026 03:58:01 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75d4887easm14645551c88.9.2026.10.29.03.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 03:58:00 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, nikroks@mainlining.org,
 balaji.selvanathan@oss.qualcomm.com, nathbappai@gmail.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v5 09/13] arm: qcom: enable MMU and cache setup for Shikra SPL
Date: Thu, 29 Oct 2026 03:57:42 -0700
Message-Id: <20261029105746.3487456-10-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
References: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MiBTYWx0ZWRfXyLhN1jsj4uwP
 idiBF4RWVVboBxj6/GXN0Y8S2I61Nr7lKkr8MsFHmIprP0BCBP5aSmscVdRQ32iHms0TnPpY7/8
 JVKGZgFPUX2Uwh/EYhjOR7YVGFbHXLif8kO/GI8llnOhFcFwpaJ4KfH5lLMXNbEqOZZf4vutJmd
 7USMPUdl4hJ0xRnvQ4RHF7YDIkP9UE3S9+bhk/mx2l8r2fvjokZQZrVXqpVumG/4xtEQZ6oM+rl
 qXwnmAmXMNwf2gDKpsi5teXlnQOa3L3lQQtFrbtqTuhkdRIBibZaoxNuEiRACkJs2Hh1NmKznxz
 sXvbCQYRrarnpXxiYlAXAoCM87GNLiCTuV66MGMiigHGme9wGi1oI+tPxEkVCzqY/Y1GC71XD1t
 MgxqMeaNYtfCcFzyh0Ogjndn1kgFRkHPLrcpb5tgboYS5QkoZdzr6f1jD0oXd9Zo2s9RSFMPEC5
 yPy3QzUsK8jNK4RMaeQ==
X-Proofpoint-ORIG-GUID: j5K-tbTabGN3rnQzMQoAj_5vNPwkjaKC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MiBTYWx0ZWRfX7vq1VaU/3LZp
 zwZhtJf8meigjyug1cRPSMAng1IZEecmMAvz2XWGRv5aKCPqRCU93o8gLo3JY5MskDke7PIOcEv
 tAeRG2mB1tUeDrOG8UY5mQUvEP1Rk7c=
X-Proofpoint-GUID: j5K-tbTabGN3rnQzMQoAj_5vNPwkjaKC
X-Authority-Analysis: v=2.4 cv=f/vdl+yM c=1 sm=1 tr=0 ts=6ae326bb cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=md-n7zwCLhyBqDs_0qMA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290042
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,KHOP_DYNAMIC,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use Shikra fixed pre-DDR memory map when enabling caches in
SPL. Allocate page tables from the early malloc-F heap and
select the board map through a common Qualcomm hook.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/mem_map.c   |  22 ++++-
 arch/arm/mach-snapdragon/qcom-priv.h |   4 +
 board/qualcomm/shikra/spl-shikra.c   | 140 +++++++++++++++++++++++++++
 3 files changed, 165 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-snapdragon/mem_map.c b/arch/arm/mach-snapdragon/mem_map.c
index f64ec0c674e..9df522f7a4e 100644
--- a/arch/arm/mach-snapdragon/mem_map.c
+++ b/arch/arm/mach-snapdragon/mem_map.c
@@ -28,6 +28,19 @@ static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
 
 struct mm_region *mem_map = rbx_mem_map;
 
+#if defined(CONFIG_SPL_BUILD)
+enum qcom_memmap_source qcom_memmap_source __section(".data") = 0;
+#endif
+
+/*
+ * SPL platforms whose pre-DRAM address map differs from the common Qualcomm
+ * map may override this hook.
+ */
+struct mm_region *__weak qcom_spl_mem_map(void)
+{
+	return NULL;
+}
+
 static void build_mem_map(void)
 {
 	int i, j;
@@ -65,10 +78,12 @@ static void build_mem_map(void)
 #endif
 }
 
+#if !defined(CONFIG_SPL_BUILD)
 u64 get_page_table_size(void)
 {
 	return SZ_1M;
 }
+#endif
 
 struct mem_resource_attrs {
 	fdt_addr_t start;
@@ -185,6 +200,7 @@ static void configure_reserved_memory(void)
  */
 void enable_caches(void)
 {
+	struct mm_region *spl_mem_map;
 	u64 tlb_addr = gd->arch.tlb_addr;
 	u64 tlb_size = gd->arch.tlb_size;
 	u64 pt_size;
@@ -192,7 +208,11 @@ void enable_caches(void)
 
 	gd->arch.tlb_fillptr = tlb_addr;
 
-	build_mem_map();
+	spl_mem_map = qcom_spl_mem_map();
+	if (spl_mem_map)
+		mem_map = spl_mem_map;
+	else
+		build_mem_map();
 
 	icache_enable();
 
diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
index 27e5c54e512..c267c0d9aec 100644
--- a/arch/arm/mach-snapdragon/qcom-priv.h
+++ b/arch/arm/mach-snapdragon/qcom-priv.h
@@ -5,6 +5,8 @@
 
 #include <stdbool.h>
 
+struct mm_region;
+
 /**
  * enum qcom_boot_source - Track where we got loaded from.
  * Used for capsule update logic.
@@ -40,4 +42,6 @@ static inline void qcom_configure_capsule_updates(void) {}
 
 int qcom_parse_memory(const void *fdt, bool fdt_is_internal);
 
+struct mm_region *qcom_spl_mem_map(void);
+
 #endif /* __QCOM_PRIV_H__ */
diff --git a/board/qualcomm/shikra/spl-shikra.c b/board/qualcomm/shikra/spl-shikra.c
index b41877743b2..c6327a14767 100644
--- a/board/qualcomm/shikra/spl-shikra.c
+++ b/board/qualcomm/shikra/spl-shikra.c
@@ -3,15 +3,107 @@
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include <blk.h>
+#include <cpu_func.h>
 #include <asm/io.h>
+#include <asm/sections.h>
+#include <asm/system.h>
+#include <asm/armv8/mmu.h>
 #include <dm/uclass.h>
+#include <init.h>
 #include <linux/err.h>
+#include <linux/sizes.h>
 #include <linux/string.h>
+#include <malloc.h>
 #include <mach/qclib.h>
 #include <mach/spl.h>
 #include <part.h>
 #include <spl.h>
 
+DECLARE_GLOBAL_DATA_PTR;
+
+#if defined(CONFIG_SPL_BUILD)
+/*
+ * The SPL device tree does not describe the complete early physical layout,
+ * so use Shikra's fixed map when enabling the MMU.
+ */
+#define SHIKRA_SPL_DEVICE_REG_LOW_BASE		0x00000000UL
+#define SHIKRA_SPL_SYSTEM_IMEM_BASE		0x0c100000UL
+#define SHIKRA_SPL_SYSTEM_IMEM_SIZE		0x00020000UL
+#define SHIKRA_SPL_BOOTIMEM_BASE		0x0c200000UL
+#define SHIKRA_SPL_BOOTIMEM_SIZE		0x001c0000UL
+#define SHIKRA_SPL_DEVICE_REG_HIGH_BASE	(SHIKRA_SPL_BOOTIMEM_BASE + \
+						 SHIKRA_SPL_BOOTIMEM_SIZE)
+#define SHIKRA_SPL_DDR_BASE			0x80000000UL
+#define SHIKRA_SPL_DDR_SIZE			0x80000000UL
+#define SHIKRA_SPL_DDR2_BASE			0x880000000ULL
+#define SHIKRA_SPL_DDR2_SIZE			(SZ_32G - SZ_2G)
+#define SHIKRA_SPL_DEVICE_REG_LOW_SIZE		(SHIKRA_SPL_SYSTEM_IMEM_BASE - \
+						 SHIKRA_SPL_DEVICE_REG_LOW_BASE)
+#define SHIKRA_SPL_DEVICE_REG_HIGH_SIZE	(SHIKRA_SPL_DDR_BASE - \
+						 SHIKRA_SPL_DEVICE_REG_HIGH_BASE)
+
+static struct mm_region shikra_spl_mem_map[] = {
+	{
+		.virt = SHIKRA_SPL_DEVICE_REG_LOW_BASE,
+		.phys = SHIKRA_SPL_DEVICE_REG_LOW_BASE,
+		.size = SHIKRA_SPL_DEVICE_REG_LOW_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE,
+	}, {
+		.virt = SHIKRA_SPL_SYSTEM_IMEM_BASE,
+		.phys = SHIKRA_SPL_SYSTEM_IMEM_BASE,
+		.size = SHIKRA_SPL_SYSTEM_IMEM_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE,
+	}, {
+		/* SPL and QCLIB execute directly from BOOT_IMEM. */
+		.virt = SHIKRA_SPL_BOOTIMEM_BASE,
+		.phys = SHIKRA_SPL_BOOTIMEM_BASE,
+		.size = SHIKRA_SPL_BOOTIMEM_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE,
+	}, {
+		.virt = SHIKRA_SPL_DEVICE_REG_HIGH_BASE,
+		.phys = SHIKRA_SPL_DEVICE_REG_HIGH_BASE,
+		.size = SHIKRA_SPL_DEVICE_REG_HIGH_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE,
+	}, {
+		.virt = SHIKRA_SPL_DDR_BASE,
+		.phys = SHIKRA_SPL_DDR_BASE,
+		.size = SHIKRA_SPL_DDR_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
+			 PTE_BLOCK_INNER_SHARE,
+	}, {
+		.virt = SHIKRA_SPL_DDR2_BASE,
+		.phys = SHIKRA_SPL_DDR2_BASE,
+		.size = SHIKRA_SPL_DDR2_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
+			 PTE_BLOCK_INNER_SHARE,
+	}, {
+		0,
+	}
+};
+
+struct mm_region *qcom_spl_mem_map(void)
+{
+	return shikra_spl_mem_map;
+}
+
+int arm_reserve_mmu(void)
+{
+#if !(CONFIG_IS_ENABLED(SYS_ICACHE_OFF) && CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+	mem_map = qcom_spl_mem_map();
+	gd->arch.tlb_size = PGTABLE_SIZE;
+	gd->arch.tlb_addr = (unsigned long)memalign(SZ_64K, gd->arch.tlb_size);
+	if (!gd->arch.tlb_addr)
+		return -ENOMEM;
+#endif
+
+	return 0;
+}
+#endif
+
 #define IPQ_SPL_BOOTCFG_REG_ADDR	0x1B46070
 #define IPQ_SPL_BOOTCFG_DEV_MASK	GENMASK(5, 1)
 #define IPQ_SPL_BOOTCFG_DEV_SHFT	0x1
@@ -51,6 +143,54 @@ enum {
 	IPQ_SPL_BOOTCFG_DEV_SD_EMMC	= 0x1,
 };
 
+#if defined(CONFIG_SPL_BUILD)
+void board_init_f(ulong dummy)
+{
+	int ret = 0;
+
+	memset(__bss_start, 0, __bss_end - __bss_start);
+
+	qcom_spl_malloc_init_f();
+
+	ret = spl_early_init();
+	if (ret) {
+		pr_debug("spl_early_init() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	event_notify_null(EVT_LAST_STAGE_INIT);
+
+	preloader_console_init();
+
+#if !(CONFIG_IS_ENABLED(SYS_ICACHE_OFF) && CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+	ret = arm_reserve_mmu();
+	if (ret) {
+		pr_debug("arm_reserve_mmu() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	enable_caches();
+#endif
+
+	ret = qcom_spl_loader_pre_ddr(spl_boot_device());
+	if (ret) {
+		pr_debug("qcom_spl_loader_pre_ddr() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	ret = qcom_spl_invoke_qclib();
+	if (ret) {
+		pr_debug("qcom_spl_invoke_qclib() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	board_init_r(NULL, 0);
+
+fail:
+	if (ret)
+		reset_cpu();
+}
+#endif
 int qcom_spl_soc_qclib_override(struct interface_table *table,
 				const void *fit, int images_node)
 {
-- 
2.34.1

