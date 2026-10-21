Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B3E606A31C
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 06:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ouLPElhu;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aZ+N/4l4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Bg3uFBt3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D1A5607C5;
	Wed, 21 Oct 2026 06:43:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M-kvgYnw6-ug; Wed, 21 Oct 2026 06:43:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D0EE060762
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792565031;
	b=mjhf2oSKIEtmR7rDLNVYvZjqnvnlro2T6CoRMCWTtSt/tuXyXNEcxl4n7ML/BVDqIvaY
	 kWyDez+ldE/hv5dONoQSPN3uwZYtGCi1WHgZmOA7fg6pLzqzxzwJ53N2lkJPM8aWHF8EH
	 Uay2+TViPfwgFKgtybYaG3OzjFo1+WnaM5toHw9GKOuvsZ8ok+Stp+3x06pNrEnGnj2Zh
	 7DZ7LYIKtybskg5GBVy+lcHRiN06JwFgXGM9Ub4s7xastSml3qwOEGqmNxVzUpC30n1lh
	 Fm9SvjvS+aks6EyxWr7IaDcFfIEphWtoGBHR8Zo/h5xqIEYrv7LeMR4G55e8gcErSYA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792565031;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=m/yKaJUlbnP8ucqUitwWQfyPatqHZJvrv+ASX4ErwdM=;
	b=k+qtqa8pkA0ggXT0iIyT2Q5GOlrIZ/MyXaIRQN/ua92jVNWWAx+xt2wybT8G+LJh0B7Q
	 7VtDPLZ/j++XKQD/p0ScCz2RItP4/mrgdVu3DGnl9zdNSYiUIrfkPyYDTflUmALeTHBy3
	 RxMbf3znetWIoZ9BTWXVULy0xpcfu1AuLnfZeGtPLkS8IT0VCjvZU6NIFmJf0hvVAOmQV
	 hX7hNamsPE4XDtz8pu6Wte6meK0RUdt+NtsIhx16HaFWAktxs7vfR5SOp7XykDk6Xl7Oh
	 MSzOTtZLFfUcc4iS4tCycH6BhuC4l0eAeGK6s63e6AjDH6Tvy8wkR0qyN6zl+/yOJxQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792565030;
	bh=m/yKaJUlbnP8ucqUitwWQfyPatqHZJvrv+ASX4ErwdM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ouLPElhupXloNXqCgdlNeOSgP/tA1V15ls3dntgBVmMl02x4FxA4bJ4Fht4EpLxMK
	 Y5C3UeIT3cZggUmWx8HvNFlItAfua0uQf8LDgw5ZyyGxjomTs3KzbgJ8LTZ5ZkaGJR
	 Rv36VCJ/tq2rCjd5mL32bfH8zClsV7MZ8kPf9Bu5YRRqA679lKsiMSBYOtvNUhSWZD
	 wEMSiMVtAXsjbIZhWWfFKev/dWA8G1gNf5MXLrhJspnUgD0u7kAoh5msgfn8H/EJRE
	 RyIAFRwTRpaSeZ/geV4VIzjdsksK48SwWlO/JM1nRP1QNVJ9XFGlD1nR8SBCJx71z1
	 ijHeMhR9MXf+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D0EE060762;
	Wed, 21 Oct 2026 06:43:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E876380
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:43:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0092240631
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:43:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZiJ2yVPHJx2W for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 06:43:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 37B15405A2
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792565028;
 b=YcoYjcEI6LD45KCxPFHrcZam7HUPD1eond9O1CwZinHDnws+wFikosMywDgSrGLnGDtw
 UftT5LT+w0RnthwBafUTafIAOdwQHK5+TvtvUrFkaeEo+BTZc5Q8icN51SHPCLlOBdxGu
 8h6mIbiJyXmRBN10sliJI0U+Zjr0j+6ZTQejj2zT/f3IN2vH6jCKz3Gvu1CYHqkdvPCuG
 hGpOD51GGKzr0Dd2t/Qu5yGk8AKGeFW+4OXxeuDkLOnXryFqmdUFneS0fwRhJvqkmxr0H
 k5etaSUNpkghlxlZgCjkn0WnNXSzjshpZViyGKS+Iev4sRdQ3eaRpSC7PxRUtvPaYmg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792565028;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=m/yKaJUlbnP8ucqUitwWQfyPatqHZJvrv+ASX4ErwdM=;
 b=fn8hAOdUzm8rYUrNnqgGC4uGi8GCzlIFR0s4ij0E3uL06tOXX+mSlkrO/UvNfQMsM5PG
 l/Yz/T8udsc4Iqq/N/eozdH9dSLB30qzLRmf89C2r8I78qc6eQCVbq4a1ieNLveTmfKIc
 L4nc9H1QEZuhqABqnHw451EnD7KqFGalfdZ5QuomRaQjjdIANpvjwlzxe5lqt5GQuKjIY
 lyilL3A8MxFx2d0FApgpHR4Ng/R8gv7GavNe6OVOLBe/P6HgkMI/EMR6oY/yAkAZA1Sqr
 PNxReJEqTOmOx6zj2rVNnpSTmmgM/6Au7duFHJhht3uDgyXW8LgrUmV0Zrx8fy2zjBw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="aZ+N/4l4"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Bg3uFBt3; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=aZ+N/4l4; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Bg3uFBt3
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 37B15405A2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:43:47 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L5j2J5165261
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 m/yKaJUlbnP8ucqUitwWQfyPatqHZJvrv+ASX4ErwdM=; b=aZ+N/4l4tZdIrEC5
 xmBqtyuqOY0CP001HwdedcchwArJ6kORkcr3jYoQfKkeQU63IElDhn/U+7GeDECP
 M6eLVbtiDVSLbVmfreFzgM0UybP/63mUe8h1rVLG05aTkPM8GrCALZXit/5XgyQj
 4Iu0/6o6LUvKDtpNnjw1CFVkOfzsVzGFyt8MvbNsj1OkHRKFDnxkzhY+b3LLKTbu
 6zWDyc2nZiUEcPbrYKzZgQxXF5RlIRqSS1/KgpRMKYKzVC5XLCgoWWH0Mc4dGiak
 7HFB+9t8H6wcsWKxZksIKH9kLCOQfPMQcCPBQwZRsUAc5QZfSS/0TrKPCgH+/ByS
 wUJZ8w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hegs01jvv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:43:46 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36696c9f55bso436402eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 23:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792565026; x=1793169826;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m/yKaJUlbnP8ucqUitwWQfyPatqHZJvrv+ASX4ErwdM=;
 b=Bg3uFBt36bqtuw0cLOGSW/6MEtsf5pYzy4IeuL6Tk273GPbrmyX1ctsP854jI15zOT
 o+j4dHL0RJ4CVXC+zAsESNOss2QsVDDI1AaGtft28YUzs59QJIk8fDurFuHxqJbICSxb
 XugGVI//JRGSRCqit9yml+LNfgddAl+occP5hYrJMgehiBcwb5NOm+nsKbEPGGintKq9
 5V1BtsYvqV26yayGJ+gg71UMEQfD9NfJdU59t3zIy0t+n0gd/jFKtrgWi3lFAXhib3Ei
 I3yAEfbLlmveg6J2MCl9ZuaMRvKhy7IWLjmoV178+/IOO72xVA/sKatXZYhAJvOsCoRi
 JC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792565026; x=1793169826;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m/yKaJUlbnP8ucqUitwWQfyPatqHZJvrv+ASX4ErwdM=;
 b=sFinP3W1LvvUm5NbwCzpuan9kDavQ0uGOx25qT4BBYr92tJGUDHRt3Rm6YeExNs/7v
 EDTIKKOs3OlugAs32TJsp5lU/2uYTdr4XAARzPu7kL4GynFfxslp/Rsqqovwl5+fj8w5
 TDEbS26jePAQNi17xoxHdJ8aayUAcoQmwkdiWBXocYLteRVhlOTSXnmMTyCl/G149tos
 6+MVmRLBhjWj/TkN0NziNBvcxOj4HxtWGUq7w9izO8GFOYB8bq0M2LgmEgewEQWRvhKq
 3laB8GGbxn670p7pb1m73UXVBDk+Pd70rDIMBBT+OLbrSRyl3m0IZhAo4cJ9uDfNWypT
 zjlw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjz++Cr30xN0XrRt2ANiD4HS6OIhqeASPH5wKqVEPTdzfG6CKoXAcx8HsFm5xlT/3m9qJRcwc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL1Ajv9RGo3img1FvtsaAWaAJf2s2IN+0P6Z9EST3IshHrEiPE3
 63Ror2WVORhYSnMIYyeag3/26fIqnUbQUTaIXzOUh2w+nntfv10R/yGyQmTdjJOtETjmjUG3JCk
 pRYzyVrW9N7QWefOSzLtGbzZyPTEyS1j5hemFAuZMIXd/3T0LWdyTZoojFjqRy4Yx517yNZ0=
X-Gm-Gg: AYBFou1vioyYV2FsufPdka67AzUVuTJjIsvmLGhd4yRyFgTbPefaRGGlKnP6IMowEDx
 GMV8Tpcex4Qs+2pfmuyVGyMEVZaQSHunQ0eeWhCCrwDUEfZKdCB9XU7JCVVeaN2vZ3gbpY1X1eU
 wlgmO2mSSZzEExs/7BYYrlS1KwRfIJhGBI/iUuuliBmHpsNvJR/VhKO0QH7o9zBNPi6sV+ZbMBc
 O1qTVDCTMt/8Xq3Oo0UyLsfEfKnUKijogCrQuELdfhzyc03dX5HhIaQ/YNemzQdsGYL7FUtIP7X
 ekksvETCKacWOCB+sg67UgBfwJk8OPEQnIcKVpSv4F7LBy+jaYDw17oKntOMz/pr1Jsw+8Xooss
 SpCeYmMrh1FTl2fATsG5mlr6TO0TqicNjkfCjOhyVIMAYAioOzM0uUibNCaZwqswGyEi5zEdvQi
 luI5hvrYFQ4ppQA8ZCguAwxbstbML7
X-Received: by 2002:a05:693c:87c4:10b0:35e:af84:bf1e with SMTP id
 5a478bee46e88-3674cf37010mr1967520eec.7.1792565025482; 
 Tue, 20 Oct 2026 23:43:45 -0700 (PDT)
X-Received: by 2002:a05:693c:87c4:10b0:35e:af84:bf1e with SMTP id
 5a478bee46e88-3674cf37010mr1967484eec.7.1792565024916; 
 Tue, 20 Oct 2026 23:43:44 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367411bd27dsm4547476eec.17.2026.10.20.23.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 23:43:44 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 12:13:14 +0530
Subject: [PATCH v4 5/5] configs: rename qcom_qcs8300_defconfig to
 qcom_monaco_defconfig
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-b4-monaco-v4-5-c90f0c01d312@oss.qualcomm.com>
References: <20261021-b4-monaco-v4-0-c90f0c01d312@oss.qualcomm.com>
In-Reply-To: <20261021-b4-monaco-v4-0-c90f0c01d312@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Biswapriyo Nath <nathbappai@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 William Bright <william.bright@imd-tec.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792564992; l=561;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=HNiYAUuU+c7YvLVKEfPqe8Xc/Wywm0/vCQOut/C748w=;
 b=jEIC4phzArf8exFDuRjNwxdT3w2N3iqOGM5aQL7fyMNis5ka0ZNE/3I59Nv8VNwVzeL8J8Q+k
 f3mTE2Rk6TuBe7EqkvhADPVrXYYwgASbJR3/t/a7LI/r2P6X3op262B
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=S/NMU4sP c=1 sm=1 tr=0 ts=6ad85f22 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=lFgAsW0ZWYHAtZjuoJAA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAyNiBTYWx0ZWRfXx1Jv9P95xixw
 SnZKqSQVvIKi67oBOn3PPRvlmwIoOL6/+Mlcv3yjI4JlLPBqAp9qSKIJ2w5WKR0q3bMnaG+W/2z
 OaEkZTTo+5MglixXc9dffm6TsQef6ZfBfc3xoCTIKiaIFwxRS2G86wjWPsf+S4jUtUX3AGMbziy
 1VhDt+DAOAwvRtSRc0FUoMAaqf3o5wzhLSE2eZsCQjePQgTRJOK/n2i7VXQcvh7CP0gUR/mwffA
 EEpGuf1pR6kvn5jX+18RKhAKHbHlhsKmIcIrIUZd/gpgONEyS6Q/8yxO3xAzF9bOvYIh3ZEUzQ3
 dHHSQCDuJa8JXz35yiojGy2mjP8xFYJjq7zSnlvcmsTuIljLvl/XXTEL/bWp91nSyn5ABBWZH33
 yZKfLMDiau20RVwgzBEnu8HEtKYzN1Kg0wI6TLIV7ULKxhf3JK+9Qb5kQRZg/jpj+ekDXBIh8jv
 tUlvEb5Jfzt5kseW4Lg==
X-Proofpoint-ORIG-GUID: C1LPylP2ZSUKrs7FsGoo12bYVnQK4Gzu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAyNiBTYWx0ZWRfX5rIkRbvmrgJN
 aCQtYapl1gyaOsggTgeHdAuumf4n3MdCcsf+y7HeVBCuXMSp5nIMW0SKhFquTQB8am6q+WGXIhA
 YW3Jy4Cx3+3xKkxXMTfEMMXL3Be5aj4=
X-Proofpoint-GUID: C1LPylP2ZSUKrs7FsGoo12bYVnQK4Gzu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210026
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

The defconfig now builds the monaco-evk device tree rather than the
qcs8300-ride one, so name it after the board family.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- Newly added in v4
---
 configs/{qcom_qcs8300_defconfig => qcom_monaco_defconfig} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/configs/qcom_qcs8300_defconfig b/configs/qcom_monaco_defconfig
similarity index 100%
rename from configs/qcom_qcs8300_defconfig
rename to configs/qcom_monaco_defconfig

-- 
2.34.1

