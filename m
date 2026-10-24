Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11259606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fDDjxQaB;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pyHmNOoq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Fyu7Zxd9
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D44258165C;
	Sat, 24 Oct 2026 17:38:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vdl_qVq-Ih6W; Sat, 24 Oct 2026 17:38:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2C79B815DD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792863503;
	b=Wv/gpRQIBaFutsFZS00QcRrta+45UDX4uXJdZPBjXOxfjR3otyqPggtsVNyQyBfy1Q4q
	 85qOUqwNDFvGYLiuc6ogJrtS+g1nT+AuuJGcz9nL/OUPBEx7jubYX4FzbNvO3BsouNYj0
	 q+UFjNx/bJZqDD/YBURjVGdPO+VJCDcWviHMLCekf4lbCZCqxtYD+iaY0BAgYc12jJyUL
	 3kBRTjPZ6p40zfbModdmI6c9yvDee8rX1yW77z5H5+VK2m37z4mcqR/0Or98TOXW8EcIl
	 ti2eDddQ36NX827YpNgSyzKInZ5Ez/UdOYw/ZMoxd9TAevWDO1NxdY12FhMIdS8trhA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792863503;
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
	bh=S8xo0Y8Fc7Rv9YoU4OalZugpg1QXHrNScqDM0P029No=;
	b=ksZHsr6hU5EVNd7vcMqygK4aMpAgBiRZrG7z3kOARzJ/m3JCD/xkdcS6WGYcQ++1NIA9
	 mp+5waFaBSAHs9Wecyc0ijpTzLrDzp4M079n+bS95OfsPPbFEMb+9ZomTo0Stcp/PHQHn
	 aCbzj9tugR81bUD9XxQpbJwJdwy//dMGRt1gR0Rzq0PheXHroH269Qn02Q4tu3QD87i8O
	 d3mR8CPggx5DuR8Z8olGP2EsfVwVnkPtcGTxLs2MP1r6dopu01degfREzdrOqYo/nwAfO
	 AMN4Q+ynFPyVZM883w17lAxDZyfQVYl8KV9VHKj4r2ILQ2K+dpglSj4URCLnlGNLrqA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792863503;
	bh=S8xo0Y8Fc7Rv9YoU4OalZugpg1QXHrNScqDM0P029No=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fDDjxQaBImMNnk/pkzLioNAVVcxx4EhOw4cLJZ70McwFbT7wS6tsEMjaR+xnB5jgJ
	 9rWcX6+UOfbM7pePYfQA85D+2NrrXdNvs/9TdShHza3JBbyNa5X64Tzdvoz/NvGThx
	 1AXpuNEyk/bBtkvdWMAKM6nkVKuUpkxPBW0/k3oFzt+wnpUCeBKLEEZvCf/SpqO0N2
	 vowVSBKXjstBqmR2P0bViGHMyiE+AqjQx0OeUHLGI26kBGWHQpYKDODWn4aAs2xL/p
	 YNVFaOtbThHKUghQQ6tZT/p3CEXIfO47xtks+0tAk+BQpAVaTc7DXuc2/GM8MoSgHi
	 DaoU9cHM8axiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C79B815DD;
	Sat, 24 Oct 2026 17:38:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DC48343
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:38:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D9A3460640
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:38:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KtbCE9DQ_cs9 for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 17:38:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1EA456062C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792863501;
 b=Jp8bcdojZ66Vjk+NQWybCmXL8bQUYxxtH3p9UOAPjGhjIssO566fiMlI7xmOizbfoDxD
 Nqv7shJUmmacCwdn0o7IudhT231qpW4FyJlZKh0e9fduaT7wvxjN6LGTW5vIXL59IAtGE
 j/lZGxTfTC4Ph7ETX8Bv85c0dU6cx/CjcmnFOPBdfzyD4vWoG4Zc4jEPX6VYAF07Xs/km
 a8o8W5WYFHH2BiWUxhS5q+PBkuDg1CbvmSWWNRxzLg3qx+J+kRoKtOoAWdtW/JbLCJsNk
 35RoUWK4HP5kjJh0flIGMKTrqxjxqvQDV6Uie87gnisYTk/LUIXELhUiw/y5UI4fpWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792863501;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=S8xo0Y8Fc7Rv9YoU4OalZugpg1QXHrNScqDM0P029No=;
 b=R48vneZBI9XCWNbfNNfDVtrU8hIWGEXU+h2fblmlQ7vfUZxzytplY37ZAzno1QidFlGj
 pOqiL2VFB4fR4pKh48+PRtPBxiTucGa6dTDLkl0Q8szx4WLwHIjcdsDA1t/mYNIr7SD75
 hs9uQeg2y72QSSYy6AioWDfQqFBkAd+l/r/ycMbdQv/ANodI/B7yXjyQvbLWQmhokdA3x
 b8HVFK2RZ5PaXjXKpvneOqiIthTM6iXaoGiaz+SBNMIheMjECG3U8RqMjxc7jNKUHXiXI
 c5AYdiSVpdMFdFVGw2y4hA99UZI/t7FnQ9tev2t2F/dqG+m4o5cZ+H+70m50BCUcgzA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=pyHmNOoq; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Fyu7Zxd9; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=pyHmNOoq; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Fyu7Zxd9
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1EA456062C
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:38:18 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OExt7r838833
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=S8xo0Y8Fc7R
 v9YoU4OalZugpg1QXHrNScqDM0P029No=; b=pyHmNOoqweN3VkOekFjISrLPGHC
 15GAF0Gh31rsH1ZwbkDWx43imIOZD+Wd/VYbeREIdJN6bW9kJ3qMXQWRwmju1Hlv
 ECCbOD+BMShoPMpZAvqKgPK+2Egy3a+MkIYhm/6dq4mXxxUi4E0Kc4H8ISd0dpmA
 /okZlnNF5aCS3dDE0op3LPzV3gq0vHUZsnbMrbQfRgeiNrPohS/DgeU/1YAsroMq
 zgWWSWM6F7u0gKWwNcIYAnhOHn4/09zINdksXTAgb/UMNrBMDSKFTp+/+dEFxe6E
 IVkmOHDsXhKWXYSZx/6lpP7JCtxH2tCRBdLptj2rBy7bb7+aQaDU1LeUTvQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgn27se7u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:38:17 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-139b62317d0so7119640c88.0
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792863497; x=1793468297;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=S8xo0Y8Fc7Rv9YoU4OalZugpg1QXHrNScqDM0P029No=;
 b=Fyu7Zxd9yF146A0G6yuuUVJTTgIyubpUb5BPhoicc/ybAaADrr9uNNMe3Lxj/7svas
 Uy7q7G6zacKG/cX/ZE1S2B5Z/qIiXbDPMTFdH1DPQLsnaonviU/o+hcOJPb0lZC7tnAk
 XZaK7PzWMoJjnDQesh9wxXiwG3U0V2/7Ru5mNzmhG/CETkQWUSDl26tB7IVIfWBnQRsr
 PN3iEsb6NKS+J2ku0mL8ZScsHc3tPEJUc8nJkJBrGf0CUk6p8Ywy+6J/LNJir1ajPoOp
 8QoceW2sbOzIIaUhOK1FBo8HYwZMTuMuYHSRSIkHtxuwm95DGsm2g2Ay2QTV6AN57EmN
 Sdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792863497; x=1793468297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=S8xo0Y8Fc7Rv9YoU4OalZugpg1QXHrNScqDM0P029No=;
 b=0m2oUP2WnyaDKjwiEJvgiBAIxTgFdLD5d/1DwXsXLpV8TAtT1hH4Cb81ff29RqwmgI
 UiRXSDpAs+943TMO4kUJoZMsUDa3ExYcI9a9DSE22Mb633SjupThPDkSdKJxeUhh2fEc
 WgxbummiSn+JDIIzYYo9Jq9KFCHecivlRPU9yjpUKtojc9II+h1TTSyg0AgOue/2/cSa
 7C9CtJ201ZDNYxpCj9m+oY0+zKC6FbKfrue13ts0RLgss/CjPgEywUViuqhkaA+YIx8/
 sGdSKMi/SSdVjaRbjyXrQ5GVATqN8sAoC0eZtRV0qKeFT8DBovO/RVnZwUtmyV0g2UAf
 jhDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXKAmww4crlbJAmMDn3M0XeJ2j3v4B3DzRzToaR1IgzURKK7hEES97HaZBCpKNJcwoR5dfZAw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI90nQv+YRGQSq5vdhYSxNKATABWuNG30nd1Vb1w6o2Y0aNuU3N
 G27uqvOScRdp3OYCoYzHrbIbjjd2E+6xpB/f5g3GuXqKdEVNdvlgPjtGkRDwfHXVWwO7p/4sIAk
 ndn7TnhgLV0pyvxcN/2oMkQYUVtLm/u86QKtnI1+/Kz265RsFqnoTQWSJmgNmRK0pKzTh63c=
X-Gm-Gg: AYBFou29yXMUM9kfhbQM7nyxYw3ljqvlr5uAhpyMKtD8PDuBy2Tt2pcPvfh9CMSIStc
 3bcIp//ARqMpJ5M/eDRHt/+Sa/993NqYc4K3GujfZHyAB1AARYWI9+sXsypKOk7f8kkZDLhGXkz
 s8/uC4+eI/A5wN/i2OmHCe5oF71PECZQoo2Qo2BLaZWFKBLSeimzahIAGIKTO0byMdyuRwD7I0a
 HU0q7rmuLUXJ9hrNSr9UgqKF5iKwXj33jg8wKhkMqS1b4BwsiNxh1QdcYjNqHvwRxY2xYrzsdqm
 SQNIUc6NuUm57O4TawAR9KWSg7cjjqQlAdcFmRt2X07v78LvyElcirrv0trzD3FoMuL2e79ViQS
 10HhxqFfYEM9/Vh7Nj7/r9s1iVR8W8UHVdXLJbfstz6G+SxmJT2hymno3sGjAqCB/Seh90YQB+c
 /5BO7st33PiFfU6/shx+A=
X-Received: by 2002:a05:7022:1188:b0:163:a197:722d with SMTP id
 a92af1059eb24-1992afd2de7mr3639176c88.4.1792863496535; 
 Sat, 24 Oct 2026 10:38:16 -0700 (PDT)
X-Received: by 2002:a05:7022:1188:b0:163:a197:722d with SMTP id
 a92af1059eb24-1992afd2de7mr3639140c88.4.1792863495940; 
 Sat, 24 Oct 2026 10:38:15 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a020df20sm10714248c88.6.2026.10.24.10.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 10:38:15 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, xypron.glpk@gmx.de,
 aswin.murugan@oss.qualcomm.com, nathbappai@gmail.com,
 Michael.Srba@seznam.cz, balaji.selvanathan@oss.qualcomm.com,
 sjg@chromium.org, aristo.chen@canonical.com,
 jorge.ramirez@oss.qualcomm.com, smoser@brickies.net,
 ccaione@baylibre.com, vincent.stehle@arm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 2/4] configs: qcom: disable malloc pool zero-init on boot
Date: Sat, 24 Oct 2026 23:07:47 +0530
Message-Id: <20261024173749.3509050-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261024173749.3509050-1-aswin.murugan@oss.qualcomm.com>
References: <20261024173749.3509050-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=G7GJgNk5 c=1 sm=1 tr=0 ts=6adced09 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=bYrVA6HKleQzmPLfxwYA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: K8zYPb0kQjHRbOZFNmgvjdToYjkjhdjq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX2ChgSBP3XkGr
 tQ2rWEcz0Pd4EKJJYN+oiSAhubtkexxTPrP6c/cB+fVxzAVxr288gJMYg7L9qKsGzzdErZCj2yv
 lB9dGyUr1kbITXEOypyHDpgnAcyIYlU=
X-Proofpoint-GUID: K8zYPb0kQjHRbOZFNmgvjdToYjkjhdjq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfXzn3aPC5oA7kA
 zxMeGglG/9iPw7DuuWbFMS1g8JrFIeFJF7dlD+7d1kbUyDIauF+6iWATIE3P5F6gxegF6Kn3SgU
 nI9obg0J/xc108OfiQm7QFaLGiJbpmKSqLmbOmA6Rwfwl8gn2THux6Cve/SOg3vI5x+aY7aRTJD
 v4cWuXvJKlm1s9+tL5vUyX3XSCfeSOJSa7A3C4J4n/c72lOt4Ma7ZNwc14dCI14xioVhYBeeeyz
 83WKdR+hux8NUQ65hb3dswvWPzfK0iry77RhJbkUPu7bBkk7x5f0uzJQvFrCv9gUqgTwU4BYuxb
 tzsCFNy6goVapW2tgr89U9AObOeliJfPbGwGHiA5FwHccMBh4UWou4PlSSK/wWiZ9ybSNOMwSsX
 dsRAagTUvEhRbqs1v0reEHvBfqK2uTKYgugrmCsDD6I+9iOAHUV3kuGvHa+4jvvih4AfPEzZwJe
 AiPzRyl6bich8UX8p/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610240070
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

CONFIG_SYS_MALLOC_CLEAR_ON_INIT zeroes the entire malloc pool at
init, costing measurable boot time on the 256MB pool used by Qcom
boards. Disabling it saves ~74ms on Qcom SoC bootup time.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 295ce4aa714..dac9c15c12f 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -13,6 +13,7 @@ CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_BUTTON_CMD=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_BOOTSTD_FULL=y
 # CONFIG_BOOTMETH_VBE is not set
 CONFIG_BOOTDELAY=1
-- 
2.34.1

