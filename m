Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D843AC79FA1
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 09:47:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B694606C1;
	Tue,  8 Sep 2026 09:47:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KDDKXVNh5vX0; Tue,  8 Sep 2026 09:47:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1DA79606A9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788860869;
	b=Lj58xcnerR6i+VRBNEYePvKjue8xopDQI187GNB/Fij3YZ+fYkZFLgeqlFsLYxYS5shI
	 onlhJc1jLc4zYPkLXtH+VwaHoosAMvlGVSG/baLfJQDsb4iQCgGJhOUpMjMjxAkv7nKpi
	 KxRmdscCL/Vq8e06T18hS6Yx2XuyXcdxUTAaqg26QQl9kSIxoSMBxDygqN6PjNoe4JCP3
	 +znuOmhUK8WIoO16xj5AqxmnvHS/zLm+y8T4hL3HM6vqZiTT3p/Mn+mBDwx2DQqTUk0A6
	 5k04oBErrG+zmYFOdqY9ZdMF+NvlL58R6aCP4xoKpVnSlcxKCL91YOUQBRgjusiPBng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788860869;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:X-Google-Original-From:
	 Date:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZzKHn/1O7VyXlUr1A+XWdu7TZ8XG3ryOFUOkXaB9CPU=;
	b=bDKe9EUGbLz+LkV7qw3HDDOZkj9j+oJ0ZX2Gs17BaA014H693RagGmgMUDRppsh6guBi
	 32gFpJe4iwCWPUfDlSxXQLU6SRNljKjFEogrzTBfSFilIUxT6vZvXVHW0v2KkXjAIbPZZ
	 nw+GKGOLgyRsKY72IULbcw6z8u38V1P4OvjWbaYfBN5o9n5fHwWdZiqs1MkJURmD3DH1y
	 /VnhgdQY5xRlXtt/adGaTYs/1lyRE6ioaR0WRB8cQK6yVT+aNQczhQnoGB/CGXczAvqoP
	 oT6+N//EET86lHbmi0UdO8jBj5587UKRdyCNznEsaQ8k5Mvg7lk8GLB5XaEzPnasY1Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788860869;
	bh=ZzKHn/1O7VyXlUr1A+XWdu7TZ8XG3ryOFUOkXaB9CPU=;
	h=From:Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dmna9f8ufFZ/0+gosVFBDCvgGXnZ73MTTmfsBN2gbtruYwAhc7GemjKH1PVtdyBz+
	 9IIaV/TfPOnrcTW098gXc8sMwh7u7jnq/ziSEszngsgvcmuuWuzNQHqFNH8d4N0DVk
	 hhj/al+PTVSbkTsWJWpg2vd5LUiPx66WVbV4fsvuq1AtrLEaEVIXJAI+3AG8YUKZnh
	 GprNcJvdyXq2yMNpqQ6aSEjbOHamszbZXURocxqzN2VBSdIjjHVf/+bpkuV4oHgRGi
	 /3VUalkUx2pd8YWxnjNb7WWCGwmZPAjk6SNzzzQI1y6hOYpHdfEPaQCBaDyY4fmVtX
	 bQrYJ6sFJDVGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1DA79606A9;
	Tue,  8 Sep 2026 09:47:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 964A3D5F
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 09:47:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 87AF1404F6
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 09:47:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9we8BtbHGevW for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 09:47:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 97718404F5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788860866;
 b=qTdRmG5CXEU2jSBUbtj8uitb69JjBd67duubnuABgqYCB8HNg+0ePUJ4i+V8SqB56sTU
 NN8DGtL8qdZS8ZkyJleVrw+TMCsu0HOWlKr4lxpA1KPKfvDl7I9frESSA26ig0czH2tp7
 ak9iz7eFQv0TLX5KAxZavlYNMryfohjOtd0ZpnyBedlaTFz9vpOvWXOZs02m00X033djs
 OLe1U2MX0p5dCD/N+kQ1C2yRT/MXd20JhTTGXSD1WUjsKxldV7dbizU+ydu/PPWYqraE1
 1sIvs/Y5f62jYACP4VS1eb/yT/UvU6dW7zkSL0gxyPja18UQXz7pAHTKn/luZR87o/A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788860866;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
 X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=ZzKHn/1O7VyXlUr1A+XWdu7TZ8XG3ryOFUOkXaB9CPU=;
 b=LDGMHNxCB1IqlmcTuo8BkSGkKBS27DOTzHMxUnin7uNIw0f59cIcD7bO6/Upxcjruh59
 4m6Qj18fcKgLC+IF3FPqOuFEd29O2+O0KiOAvHdWc7ZRpeKXeOh+xjXUNh6FWY8syCnhR
 OmS+KFKDHRbQYRL2bvGYaBmCNSs3E881qv0FnGglunHUQ1fPnkzzq4XqdYTfv3CKVcTXQ
 +qmKLf0y5mRxqjAGhob0a7F4IHPxmfjNTnzqXLZAJpZw0XbF5Tc5Q/wxYpBFu9pD0HbYq
 +2CRlxokSzZxg75EFyor3cBOgcCqjy7sZrczH+oVWEcoQqz/QH94700EIACBhAHO4PQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=I56jwdZa; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=kbBqoLBO; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=I56jwdZa; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=kbBqoLBO
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 97718404F5
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 09:47:45 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6886M3jt1646478
 for <u-boot@lists.u-boot-project.org>; Tue, 8 Sep 2026 09:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ZzKHn/1O7VyXlUr1A+XWdu7T
 Z8XG3ryOFUOkXaB9CPU=; b=I56jwdZaM+K0bVCyJWxQIVMozE49VwHQ7vvDJkIG
 pHdMYIS5Y3UTgh8XW8I+OPmrFT/x2Z5reAGZkoePgHBq9iTID7eI4esL3Au1pVI4
 JXOGmZyZV6qnBaS+Vn93MYkbkw0rGwArdW+p2JIlmNoNznMHevVpXkmFv9Knehdu
 +hkdoEfXTcRt8iSXneoD5s1tdRJt2cQQL07UjmHdT6zAKv/E/mVAGad2A2Xcfo0+
 dKcoOZAs/kdYZU/xvUHhM7RHLqY55xSdLoH8nqq3o3XDdGwR0XzOMlbE2Qx7H2ZX
 mNQYjdewZIgsiMq0EOcHOp/hDaTON/Qf8wuXBAS+uB3rpA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjcvugvme-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 09:47:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92ec3146553so1053326185a.1
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 02:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788860863; x=1789465663;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZzKHn/1O7VyXlUr1A+XWdu7TZ8XG3ryOFUOkXaB9CPU=;
 b=kbBqoLBOaPeb87Uq/VKWMFY1cUUrtluYlu3vwvysm4OR+zjea7Q1pWFSyHcCxuUr+q
 hd/4SDdTEqlX9QFqTrs8t0AhTKg6s0kxQXOnwotb2UF4MiStO+4Hl8EMD/wK4G8YdTsi
 fJr51cj91WPINFZ/lXFSmtaVxehwIFbWRUD4lYcA4vyAhAHIm9YvsSyWc0q+LD6LZjHA
 bfXRryPXGwRjhQuVLEGHzPw6P8D9uQz5i0f2vYEg9zE655pqWsPyJG5ZhKmoh05BUI5I
 70Ror7jiTWgeem720zkuLTIzLtzaD8fIXTxZKI2n7FhWqXolV+R3XLqKwyKsDhzs3ukR
 xI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788860863; x=1789465663;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZzKHn/1O7VyXlUr1A+XWdu7TZ8XG3ryOFUOkXaB9CPU=;
 b=gTObcsYYD0Zph7ZC7CMP1EMci7op+PnZ8DfuDbXU1ZcMy/ux1LJQ9DoJi0icPdXQhB
 U+Z4DynDwejK+kiNYg9yKcsLjuxqFmmljdT7XCsLHoJmzjcsOdymNkwhXBBOJMkpOTQE
 AAsK2lNg51dXz+MIxTHH4XYMxeHna6FLTgm2KAZU7OwC+VaRap/M6sQ7/AxHMb/7GodJ
 0DPz5wjFmMPRSbm1ynfFpYMGl8w9BF4gdHz1EqyTPGINmvZJple+bdXz5+8Pg2iQMWSX
 DMVDMPA8/p3rZi9FVIKseVu3TkcOYlsoIXkcO2m3Os886Png76D5QTaxKD773TzsoIC7
 6yUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDdCF/PngEy9EChcC0BLkRb2lfaUcJNXdpXWdLb4qtwITWF8ESD1Tgx7wKSdm7AVAYas958qU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ljPyHNrnwZcTqWrpEwlN4i3ITanYi3Ie4MduS6mIGiESh67MH5
 q0iDlLAPD28rdD0P/9jf0pAPh+q92VooRWSkbmKWT1iubAcpdwvSoTmeZKw1APjdOfUGhHN/6pB
 5icyTnlxDx7u3suKJwlGhwnJ1+u7ToeyaCivoNECYs7tFg/TnQVRp1R/2JO5SkQBJGlHeQnY=
X-Gm-Gg: AYBFou2DWaB4SvtEq/AAoA5n/3f8fGoBgWnF7zd/tlea+aKqwx9WqgutfaRjHbJgacr
 n1s5+jyONup5cNSQlYBBxN6Bt3hyno4XWPQN72KBSud838jceJeT+OriflcNnr6uLdp63nMt7HI
 TDX6Io5Db+V3T7E27xxlmBBDlodCVjNSJu953oCHLHElUqlvg82rjF0Z/sJJB57X4VEghd+DimS
 mOq7/3YtsYCp/WIK0pSwzZ21q5JQml/jo01SZvVtuDBGeoUVVugOnLwkviz1PcJ2Jza6MAQfmkk
 q8ScWkbRRid7VuBclXjUhKlk44JuKqVwm2lc7oEM4BxECxkE5a0B/HDoHZawRY74rAC41nRSBjL
 XP7JZmcBkTHK50t2rvn/vwZAfzKuCgcc=
X-Received: by 2002:a05:620a:3199:b0:936:dbd7:fcb3 with SMTP id
 af79cd13be357-939805f2908mr2876349885a.21.1788860863007; 
 Tue, 08 Sep 2026 02:47:43 -0700 (PDT)
X-Received: by 2002:a05:620a:3199:b0:936:dbd7:fcb3 with SMTP id
 af79cd13be357-939805f2908mr2876343785a.21.1788860862549; 
 Tue, 08 Sep 2026 02:47:42 -0700 (PDT)
Received: from trex (250.red-81-38-139.dynamicip.rima-tde.net. [81.38.139.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce58da3acsm965353515e9.0.2026.09.08.02.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 02:47:41 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Tue, 8 Sep 2026 11:47:39 +0200
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>,
 Neha Malcom Francis <n-francis@ti.com>, trini@konsulko.com,
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 peng.fan@nxp.com, jh80.chung@samsung.com, bhupesh.linux@gmail.com,
 xypron.glpk@gmx.de, marek.vasut+renesas@mailbox.org,
 igor.belwon@mentallysanemainliners.org, shawn.lin@rock-chips.com,
 tuyen.dang.xa@renesas.com, yoshihiro.shimoda.uh@renesas.com,
 padmarao.begari@amd.com, macpaul.lin@mediatek.com,
 jstephan@baylibre.com, hayashi.kunihiko@socionext.com,
 j-mcarthur@ti.com, venkyada@qti.qualcomm.com, dlechner@baylibre.com,
 u-boot@lists.denx.de, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v4 0/5] ufs: rpmb: route OP-TEE RPMB secure storage over
 UFS
Message-ID: <ap_Zuydj9tCPc2w8@trex>
References: <20260807140119.324858-1-jorge.ramirez@oss.qualcomm.com>
 <aoMc8FDcE0bYGZch@trex> <aohaajBy5e6A4gFL@trex>
 <ao_89VbNNE1QTX6a@trex> <ap5i9edBJ7sNVmax@trex>
 <61fd743d-c722-42b8-a754-175715a4bcbe@ti.com>
 <ap54m53aTMXhIso3@trux>
 <d191ab8c-3c5f-46c4-8278-9644a508470b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d191ab8c-3c5f-46c4-8278-9644a508470b@linaro.org>
X-Authority-Analysis: v=2.4 cv=ePkjSnp1 c=1 sm=1 tr=0 ts=6a9fd9c0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=N2KLPU99T7rsMuN2xAoQUA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8
 a=1VxDqnHFAAAA:8 a=k-42gJp3AAAA:8 a=t4CWGyNZcSLyl8SV9ekA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22 a=aZ5uHUMKh6B-zo3GvD48:22
 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-GUID: B55KXV4bJStnBlHfOHOzn_mvRIOa53Io
X-Proofpoint-ORIG-GUID: B55KXV4bJStnBlHfOHOzn_mvRIOa53Io
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDEwMyBTYWx0ZWRfXwiet4v5PFb5G
 q2EPn1iGoMr4n4yfOicV4ZFE5/S6bh4lSkH3EcBhQBU5kh3whi2tS1g9VtFRCzgxgsxt0k8/56b
 jlhqLRUcSnIdlaEYN/aHo68oQbJy1v4SHEjfyzteXIQMeYsnGOGyuWMey1EqbzXWIBCY9kW/Rkk
 jz3mppPAeECnn6uUqtgMI30V8Syx7DlLZ7u7W0oCdoPyAsdPwPO60TAEqTqN4Ctm55vHQ0hAxEh
 b4sauuhbjMjbiZs4Eq2I8rLH0/SqJF2a7y5dxxz9fc3L8Wv5CiGBsoSDIllk/wan4ZOzHvl7vof
 moHBrGClCovCWNo375dFx1hbPizn8jvdVj7SwMLbfh5cTFm/EEoY4YoPo56dJ6iF1wFIPEdn0m5
 068EZDOAEIPNFYtPop+0jVeqkCqMWuHlp8dXKHomBT6QfvC6JMOxu98EFU8BrTrmEilvW7Vb8fN
 qBtr53U0LOxNw8is6Yg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDEwMyBTYWx0ZWRfXyp7jnImOeS+R
 IyMZxsb4IVf5bhXP6ICREyHGsCbt8HXMMR1ln4OtreF8vYwA8XfQaqNi/2kOpFEUVikW4Ikot4M
 M3hu0y3Als1pX0YDaGSLSu6AuZG2h1o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080103
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 08/09/26 09:43:14, neil.armstrong@linaro.org wrote:
> On 9/7/26 10:40, Jorge Ramirez wrote:
> > On 07/09/26 12:47:39, Neha Malcom Francis wrote:
> > > Hi Jorge
> > > 
> > > On 07/09/26 12:38, Jorge Ramirez wrote:
> > > > On 27/08/26 11:01:41, Jorge Ramirez wrote:
> > > > > On 21/08/26 16:02:18, Jorge Ramirez wrote:
> > > > > > On 17/08/26 16:38:40, Jorge Ramirez wrote:
> > > > > > > On 07/08/26 16:01:05, Jorge Ramirez-Ortiz wrote:
> > > > > > > > OP-TEE secure storage (CFG_RPMB_FS) relies on an RPMB partition, but
> > > > > > > > U-Boot's OP-TEE RPMB supplicant only speaks the legacy single-command
> > > > > > > > interface, which is bound to eMMC. SoCs that are UFS-only and have no
> > > > > > > > eMMC (for example the Qualcomm SA8775P) therefore cannot back OP-TEE
> > > > > > > > secure storage from U-Boot today. This series adds that support.
> > > > > > > > 
> > > > > > > > It introduces the transport-agnostic OP-TEE RPMB "subsystem" interface
> > > > > > > > (PROBE_RESET / PROBE_NEXT / FRAMES), where the normal world enumerates
> > > > > > > > the RPMB device and reports its kind, size and CID, then carries the
> > > > > > > > signed frames. The legacy eMMC supplicant is preserved unchanged, only
> > > > > > > > renamed to rpmb_emmc.c, with the new UFS backend added as a separate
> > > > > > > > rpmb_ufs.c; the two are mutually exclusive via Kconfig (SUPPORT_UFS_RPMB
> > > > > > > > depends on !SUPPORT_EMMC_RPMB) because the OP-TEE supplicant handles a
> > > > > > > > single RPMB transport. The subsystem interface is UFS-only for now; eMMC
> > > > > > > > can be migrated onto it later as the legacy path is retired.
> > > > > > > > 
> > > > > > > > On top of that it adds a UFS RPMB transport that moves JEDEC RPMB frames
> > > > > > > > to and from the RPMB Well-Known LUN using SCSI SECURITY PROTOCOL IN/OUT.
> > > > > > > > The per-region 16-byte CID is derived by BLAKE2b-hashing the exact
> > > > > > > > device-id string the Linux kernel builds (ufshcd_create_device_id()
> > > > > > > > plus a "-R<region>" suffix), so OP-TEE derives an RPMB key that matches
> > > > > > > > the one Linux would use.
> > > > > > > > 
> > > > > > > > The first patch is a standalone UFS descriptor fix the RPMB path depends
> > > > > > > > on (UTF-16BE string decoding); the transport patches also include a
> > > > > > > > power-on UNIT ATTENTION retry and a DMA-alignment bounce for the RPMB
> > > > > > > > WLUN.
> > > > > > > > 
> > > > > > > > Note: reading UFS descriptors reliably also requires the descriptor
> > > > > > > > data-segment cache-invalidation fix, which has already been posted and
> > > > > > > > merged separately, so this series is based on top of it.
> > > > > > > > 
> > > > > > > > Tested on the Qualcomm IQ-9075-EVK (SA8775P): OP-TEE with CFG_RPMB_FS
> > > > > > > > programs the RPMB key through U-Boot and reads/writes secure-storage
> > > > > > > > objects, with the derived CID matching the Linux UFS device_id ABI.
> > > > > > > > 
> > > > > > > > Dependencies:
> > > > > > > > Linux kernel:
> > > > > > > >   https://lore.kernel.org/linux-scsi/20260716083728.2226422-1-jorge.ramirez@oss.qualcomm.com/
> > > > > > > > Op-tee
> > > > > > > >   https://github.com/OP-TEE/optee_os/pull/7881
> > > > > > > > 
> > > > > > > > v4:
> > > > > > > >   - ufs: decode string descriptors: dropped the in-place
> > > > > > > >     ufshcd_str_desc_to_cpu() byte-swap helper; instead added an endian
> > > > > > > >     argument to utf16_to_utf8() (UTF16_HOST/LITTLE/BIG_ENDIAN) and decode
> > > > > > > >     with UTF16_BIG_ENDIAN, mirroring the kernel's utf16s_to_utf8s().
> > > > > > > >     Existing EFI callers pass UTF16_HOST_ENDIAN.
> > > > > > > >   - ufs: RPMB transport: build the SECURITY PROTOCOL CDB with
> > > > > > > >     put_unaligned_be16()/put_unaligned_be32(); drop the
> > > > > > > >     rpmb_frame_request() helper in favour of get_unaligned_be16(); move
> > > > > > > >     ufs_rpmb_read_geometry() to the patch that first uses it so it is not
> > > > > > > >     an unused static function during git bisect.
> > > > > > > >   - ufs: per-region CID/size: reject an out-of-range device-reported
> > > > > > > >     logical block size before shifting and split the size computation into
> > > > > > > >     separate statements for readability; order <u-boot/...> after
> > > > > > > >     <linux/...>; note that the serial hex encoding matches the kernel
> > > > > > > >     device-id ABI.
> > > > > > > > 
> > > > > > > 
> > > > > > > any further comments, is it ok to merge?
> > > > > > > 
> > > > > > 
> > > > > > EOW reminder - this has been pending for a long while
> > > > > 
> > > > > 
> > > > > anyone care to comment please?
> > > > 
> > > > 
> > > > kernel changes accepted and op-tee changes merged.
> > > > Just this one pending with no comments for nearly a month.
> > > > 
> > > > maybe we can merge?
> > > > 
> > > > thanks
> > > > Jorge
> > > > 
> > > > 
> > > > 
> > > 
> > > Looks like you're sending to the old mailing list instead of
> > > u-boot@lists.u-boot-project.org
> > > 
> > 
> > hi Neah,
> > 
> > ah interesting, maybe that explains it depending on people'w workflows: I see it hasnt landed on u-boot lore's.
> > 
> > I just run get_maintainers.pl and the recommended list is
> > 
> > jramirez@trex:u-boot (ufs-rpmb.v4 $) $ ./scripts/get_maintainer.pl drivers/tee/optee/Makefile
> > Jens Wiklander <jens.wiklander@linaro.org> (maintainer:TEE)
> > Ilias Apalodimas <ilias.apalodimas@linaro.org> (maintainer:TEE,commit_signer:2/3=67%)
> > Tom Rini <trini@konsulko.com> (maintainer:THE REST,authored:1/3=33%,added_lines:1/3=33%,removed_lines:1/2=50%)
> > Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com> (commit_signer:2/3=67%,authored:2/3=67%,added_lines:2/3=67%,removed_lines:1/2=50%)
> > u-boot@lists.denx.de (open list)...
> > 
> > still I can see it on patchworks with Neil being the gatekeeper.
> > 
> > I hope he can work from there without me having to resend
> 
> I'd like some review on the optee side before picking the UFS changes, which are fine.
> 
> I'm worried about the clash with Jan's changeset on the optee side.
> 
> Neil


adding the correct mailing list now

> 
> > 
> > thanks for the heads up though!
> > Jorge
> > 
> > 
> > > --
> > > Thanking You
> > > Neha Malcom Francis
> > > 
> 
