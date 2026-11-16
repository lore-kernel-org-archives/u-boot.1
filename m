Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA7B606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 13:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OMBDWw6e;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NyiH8XC9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WKiY45y6
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 75E5180F83;
	Mon, 16 Nov 2026 13:02:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OCaWVo49pU-e; Mon, 16 Nov 2026 13:02:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6F1AA80EF1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794834142;
	b=kzcWA13ovu20YlkKJO0Ajg4uRKKk1/ZYT0QKSCrDGHMtZySX9y+X8c0XTC+msxk6i1nw
	 6J6Dr3HsuGiuHDQnGHPkW1OjSOxWz0DvM70CUme/CQ5AU85Zp5Nq7usjzx4FMc9mmVfUx
	 UcdMlFrwH0O7acSjIlvijqSFFxL8wKziomrujxC1vS8s5xYzUu1zp9jHW5RH0qUh1I/wD
	 cW/vuU8azXnli4R9J/2eZMh/5c84Dkwx96MNFLPRdZ7IvB0R9MqsQqVrzulTs8J5b0VXB
	 v9Mzk5gO64hPsbsVmE2gw+T0lA9cIqitXTz4yW4goBWGNOvTgToq8flsAggMCChrBwQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794834142;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yO3VePMxv1wmlJALEdh0AASG9znirOXwH5EmUR/hWRs=;
	b=doikRjcUy+VKzd4Pozp8Cvf3LKOaJW7UL/45nXg/N6RtZtIGqt6EIMzfHg/ewU6RcfiQ
	 bvtwuH46SYxz6gZFX5jIf9SFcMvhm8c6X0EmIzAG/waYE/PsYI2mubrxLxT813NLJoQlC
	 qttRUvTWVaLHcfzO1YD2l7w3x+GdGthIe7Lh7jptRQs4Cfx3syKc/+rK967XKC4Hzf9cj
	 VNh93xv+53cQ7QeA+LGMmXEYI5ncDiIxEvu8pmXgVzU0Z+57YrtOwqTt/zjPHLMk3tJ+J
	 4dqwcnLiS1fCDpAbPioPqa2SzA73DRlVANa0kIKeGJ4xzvd9nYkWG1VYnXZK4lNNw6Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794834142;
	bh=yO3VePMxv1wmlJALEdh0AASG9znirOXwH5EmUR/hWRs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OMBDWw6eM7okUL6TE+XtwG0r6ZchmnOW/fNZlnFHgpiF8xjpkIDyL3BtTmHWt4s8T
	 rNoTyt07mN3Rpk9M4fWvul0cWREuqDIiYqInPRv+NUBONL6GrjnJ4C7XUB8NBx0Amt
	 7LkQhb+IcV/b99+aLJMHRsDiRyP4NURux2i2HXoB5HHLAu2mf+3V7CYthVGThiYrTa
	 KNfdcGk/YKeLxBrh8apcf2K/Isu9FLzRNl7BQGc8X9QDXduE6nUzW2Vl5UaTQbbK3Y
	 +Tu1U9hMy6S4xqQ300uPhQJxIisbm3v8ghPS0MtNzwHs2cQ8vta/pGKlBqdSorTpoZ
	 kLZ72MmYp7p2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F1AA80EF1;
	Mon, 16 Nov 2026 13:02:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BD6581E7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:08:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ADD1A40603
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:08:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VbRJKZ5CLagN for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 05:08:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BC0E340588
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=NyiH8XC9; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WKiY45y6
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BC0E340588
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:08:11 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AG4RABe1201291
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yO3VePMxv1wmlJALEdh0AASG9znirOXwH5EmUR/hWRs=; b=NyiH8XC9DCM7uJHU
 ljJV5jXTZq3aafPcS/hIfFkIild+uLpwLh/Db0+2YRv3WqxsrrbCXrhknbcwLXJn
 usRhmjXq0Cy0HECtmcyoMVi4FmxRFbTQorYcW0GAlvoy7XjDRkQQs1w6jdBT8XPf
 J7oqYv/+Yul7O+LJcclzYWmJ7Z51/R0/RWRY2t5aMGB1CdEjJg71sIxvw0YVFDeb
 2TIlxDhWoP1kKKr3d2mZcPXRyG+GhXfYNVMGjbAy/7G7E9/txOFcqmygIx9VQd+W
 Fx+7beUMdioZzgRBlxFUdJqZXhB8FXXN1TT19YR9YckxhMidrJSlGMv5e30Q52ou
 Fi+IQw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmamswb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:08:10 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-99e12db7450so15560241.2
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 21:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794805690; x=1795410490;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yO3VePMxv1wmlJALEdh0AASG9znirOXwH5EmUR/hWRs=;
 b=WKiY45y6eRDIxLU67Ae5j28xm+FBZPHjmvUUV9EYOqOnj2uu0FjA0ZLRPizdcjyJ/4
 yhilcXRse7IgL5njFI6l0cqcgHMZJfYwBf2coMPl8E7Iu2eddKvaGRHhFyDLn6ThIHsA
 nYrQou6x8sabbUAM4VvECjr3HFoS3VflJFrUtlJjvNnzRMytyHL+W5hlSjgRV/a/cgzI
 DJay0Y6MicdzlgGOf0OXFdS/WZP+0cGAFof3aFbuj/hi6VDq14AZE68OiKvtJ2v5wzHG
 K9OPcVvXXV99vj+vLq56OsCTQq0golHDoAldF/vzuKLJMDZLqXinH7lt8NwhMYQLccaI
 yLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794805690; x=1795410490;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yO3VePMxv1wmlJALEdh0AASG9znirOXwH5EmUR/hWRs=;
 b=eqnucMwusX26Evrtm0Su7A/1Xinr4fvMIXKBMYMc3CDxVQ/8P3i2duPIE0q1bH8yLO
 /lPYmmd/xOZM+mN3xTCnhxpfsgbkWUfopxDdrrMNxemFxPrjWISBpGFlHXea8gQogG3Q
 xXsgXVgrVcHTG9/rd+XSNA6FG82TF33NDem54PxzPk2bGSwYbPUW89faEpeO4+rQ73iY
 Fcal0GNtV00rNJeE1MgJMqtoIegTT5SASwp48F75410HIg9iriE6njHnSIhfXBuOEibc
 6/vvz7V0Y02dR2tny7jrXi7b62kwKatoojowQk2FaazDvhD/64439ySd03Wdyp/pf3+t
 oYkA==
X-Gm-Message-State: APuU4Z8cFm/cDmonl2JTu8htdgHimGpRRpFxg06XhoDHvigQN3WD/fZj
 eE4I3uIviLgkAeV8i/KCC0/fT6CfXunhGUPRvULwHDNhV95XBf5s/AcjvZG43QWuhhv/Qr+ngEJ
 YoII8RssMueGj9ipcQTFEpd99YHI5vwcnFXzmcxZuzUSUM6tShmd//vgDk3a53htfmIWt1aQKoh
 ojq9xMmmndIB17HE8Wqgwj4DuluM8qrEzdo/INekyihT2TWg==
X-Gm-Gg: AYBFou2nvFnyHNi6flKAV+x74zifOY1CwZ+PCUOYizeR2Rff/ErYGhtpsHDFiX0mX2O
 AIUgSoEbdNq11I7emJOioVfHpfGyh88w8ebUyyCVRHeXKS8lfsKIeS9/IbExAuYuW7b1sVIssne
 fPsLeR2EZrFt7Z5I6bpHTCVgcrRuki5ts8Wthz7VSkNxmEEqMWTgJV0rpNonYoSCFt2CEyNpDSm
 nnkuFZxlag1U2mz6wpQG6II1P79pjHq+Trd6YQIN54D
X-Received: by 2002:a05:6102:a1d4:10b0:7c3:83a9:edb2 with SMTP id
 ada2fe7eead31-7d64d454788mr2907556137.1.1794805689820; 
 Sun, 15 Nov 2026 21:08:09 -0800 (PST)
X-Received: by 2002:a05:6102:a1d4:10b0:7c3:83a9:edb2 with SMTP id
 ada2fe7eead31-7d64d454788mr2907549137.1.1794805689288; Sun, 15 Nov 2026
 21:08:09 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261113-rpmi_v4-v5-0-6787318ad186@microchip.com>
 <20261113-rpmi_v4-v5-5-6787318ad186@microchip.com>
In-Reply-To: <20261113-rpmi_v4-v5-5-6787318ad186@microchip.com>
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 10:37:57 +0530
X-Gm-Features: Aa3M54rB7qKS9GSzTT_zO3qFW0cvII9tqAne3tD_fouho4S0Vg3fNu3sGDPQ5To
Message-ID: <CAPxK-6fnxjB-XXoBYcJRU+iQVWy7odLJ82zRddHaLhxEYaLxdw@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] firmware: rpmi: add a test and a sandbox driver
To: Charles Perry <charles.perry@microchip.com>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Romain Caritey <romain.caritey@microchip.com>,
 Mame Maria Mbaye <MameMaria.Mbaye@microchip.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Conor Dooley <conor@kernel.org>,
 Peng Fan <peng.fan@oss.nxp.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 0qFrDr-pq38gYGV-c_3l14s9lpletrnt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAyMCBTYWx0ZWRfX+aZ7bIFQCHj/
 mdmFVSFjF846cyFc4undfV9rzcGy0oAW2GjFW/BMJwufSiG3hO0fzTe0L++nq4iJBZKhFu+Sp4r
 T5M12m/17QBo6dq/wu6axHqHAgNOgs0S4t6OeNmNMXMcxDw7UCo2f+jbO32afnIZeMBcY1M8aWs
 wUXq9p/WhKMMht8cfk4TRAV217PIldH7xby8VNMMqWke11AYggZPWiwhzrvGpckHeEM33q8v+wn
 zEKY+vIoyPSJ3HbBcgZntY1NF/3gdEp7t29vRlcWQxxr727dzMb75lluvyT2qogAc3fHKlKkLM5
 OOe2G8j6ikWqVaD7rU42YM0h4ds8XFVtp4fpV117oAzVIcZuOHCGNggIVYeLiKQ2/4Y6nmpZIAv
 NxW1mk+qlMR1eC7OSOIJcqPzZ5Wz2rEPNbeBz449nPrpypyhEZFVO/hmPtLVoji+cmuN5ycfLQn
 MWxqrgJ9lMw+4AsgtTQ==
X-Authority-Analysis: v=2.4 cv=NdhzRGD4 c=1 sm=1 tr=0 ts=6afa8fba cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=hwM_GrIuAAAA:20 a=EUspDBNiAAAA:8 a=XYAwZIGsAAAA:8
 a=cm27Pg_UAAAA:8 a=ficgilWOSC4QEZ_Rp7QA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22 a=E8ToXWR_bxluHZ7gmE-Z:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: 0qFrDr-pq38gYGV-c_3l14s9lpletrnt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAyMCBTYWx0ZWRfX+/99bScUqcrm
 bwwht9t7WyqaIKm/tSWyuxyfKmFZNgOd0fsuyUZVLZYLQbOUSLyE+Y8nsO26H7G8lp+9/MmCN3p
 v2dRRPrrtZ+dabC0Y6dPKhNhfXjJJaw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160020
X-Mailman-Approved-At: Mon, 16 Nov 2026 13:02:15 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>

On Sat, Nov 14, 2026 at 1:13=E2=80=AFAM Charles Perry
<charles.perry@microchip.com> wrote:
>
> Create a new transport layer that sends the messages to a simulated RPMI
> firmware.
>
> For now, this only contains a simulation of the clock service group
> which is implemented using code from librpmi [1] and adapted.
>
> Also add a test in test/dm that makes use of the RPMI clock driver.
>
> [1]: https://github.com/riscv-software-src/librpmi/blob/3f3c4ca47339a8795=
432e260f17e1fc5091c9a3a/lib/rpmi_service_group_clock.c
>
> Signed-off-by: Charles Perry <charles.perry@microchip.com>
> ---
> Changes in v5: (from Subrahmanya review)
>  - remove rpmi_clock_sg_get_supp_rates() as this service is not used by t=
he
>    clock driver
>
> Changes in v4: None
> Changes in v3: None
>
> Changes in v2:
>  - Reorder headers
> ---
>  MAINTAINERS                                |   1 +
>  arch/sandbox/dts/test.dts                  |  12 +
>  configs/sandbox_defconfig                  |   2 +
>  drivers/firmware/rpmi/Kconfig              |   3 +-
>  drivers/firmware/rpmi/Makefile             |   1 +
>  drivers/firmware/rpmi/rpmi-sandbox-clock.c | 357 +++++++++++++++++++++++=
++++++
>  drivers/firmware/rpmi/rpmi-sandbox.c       | 156 +++++++++++++
>  drivers/firmware/rpmi/rpmi-sandbox.h       |  47 ++++
>  test/dm/Makefile                           |   1 +
>  test/dm/rpmi.c                             |  48 ++++
>  10 files changed, 627 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90b98707c4d0..e69f0684b101 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1573,6 +1573,7 @@ S:        Maintained
>  F:     drivers/clk/clk_rpmi.c
>  F:     drivers/firmware/rpmi/
>  F:     include/rpmi*
> +F:     test/dm/rpmi.c
>
>  SANDBOX
>  M:     Simon Glass <sjg@chromium.org>
> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> index 895ecb97e875..f47a356345ba 100644
> --- a/arch/sandbox/dts/test.dts
> +++ b/arch/sandbox/dts/test.dts
> @@ -884,6 +884,18 @@
>                 sm: secure-monitor {
>                         compatible =3D "sandbox,sm";
>                 };
> +
> +               rpmi: rpmi {
> +                       compatible =3D "sandbox,rpmi-transport";
> +                       #mbox-cells =3D <1>;
> +               };
> +
> +               rpmi_clock: rpmi-clock {
> +                       compatible =3D "riscv,rpmi-clock";
> +                       mboxes =3D <&rpmi 0x8>;
> +                       #clock-cells =3D <1>;
> +                       clocks =3D <&rpmi_clock 0>, <&rpmi_clock 1>, <&rp=
mi_clock 2>, <&rpmi_clock 3>;
> +               };
>         };
>
>         fpga {
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index e8b462e7c11c..bb7cb14927a5 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -200,6 +200,7 @@ CONFIG_BUTTON_GPIO=3Dy
>  CONFIG_CLK=3Dy
>  CONFIG_CLK_K210=3Dy
>  CONFIG_CLK_K210_SET_RATE=3Dy
> +CONFIG_CLK_RPMI=3Dy
>  CONFIG_SANDBOX_CLK_CCF=3Dy
>  CONFIG_CLK_SCMI=3Dy
>  CONFIG_CPU=3Dy
> @@ -216,6 +217,7 @@ CONFIG_FASTBOOT_FLASH=3Dy
>  CONFIG_FASTBOOT_FLASH_MMC_DEV=3D0
>  CONFIG_ARM_FFA_TRANSPORT=3Dy
>  CONFIG_SCMI_FIRMWARE=3Dy
> +CONFIG_RPMI_FIRMWARE=3Dy
>  CONFIG_FPGA_ALTERA=3Dy
>  CONFIG_FPGA_STRATIX_II=3Dy
>  CONFIG_FPGA_STRATIX_V=3Dy
> diff --git a/drivers/firmware/rpmi/Kconfig b/drivers/firmware/rpmi/Kconfi=
g
> index 421a1fa9deba..b462d3693987 100644
> --- a/drivers/firmware/rpmi/Kconfig
> +++ b/drivers/firmware/rpmi/Kconfig
> @@ -1,6 +1,7 @@
>  config RPMI_FIRMWARE
>         bool "Enable RPMI support"
> -       depends on RISCV && DM && OF_CONTROL
> +       depends on RISCV || SANDBOX
> +       depends on DM && OF_CONTROL
>         select FIRMWARE
>         help
>           RISC-V Platform Management Interface (RPMI) defines an OS-agnos=
tic
> diff --git a/drivers/firmware/rpmi/Makefile b/drivers/firmware/rpmi/Makef=
ile
> index 87ef3623a93a..7c4ed755f80f 100644
> --- a/drivers/firmware/rpmi/Makefile
> +++ b/drivers/firmware/rpmi/Makefile
> @@ -3,3 +3,4 @@ ifeq ($(CONFIG_$(PHASE_)RISCV_SMODE),y)
>  obj-$(CONFIG_RPMI_SBI_MPXY) +=3D rpmi-sbi-mpxy.o
>  endif
>  obj-$(CONFIG_RPMI_SHMEM) +=3D rpmi-shmem.o
> +obj-$(CONFIG_SANDBOX)  +=3D rpmi-sandbox.o rpmi-sandbox-clock.o
> diff --git a/drivers/firmware/rpmi/rpmi-sandbox-clock.c b/drivers/firmwar=
e/rpmi/rpmi-sandbox-clock.c
> new file mode 100644
> index 000000000000..03f48af135de
> --- /dev/null
> +++ b/drivers/firmware/rpmi/rpmi-sandbox-clock.c
> @@ -0,0 +1,357 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 Ventana Micro Systems Inc.
> + * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
> + */
> +
> +#define LOG_CATEGORY UCLASS_RPMI
> +
> +#include <asm/types.h>
> +#include <asm/io.h>
> +#include <asm/byteorder.h>
> +#include <linux/kernel.h>
> +#include <linux/string.h>
> +#include <rpmi.h>
> +#include "rpmi-sandbox.h"
> +
> +struct rpmi_clock {
> +       enum rpmi_clock_type type;
> +       const char *name;
> +       u32 rate_count;
> +       const u64 *rate_array;
> +       u32 transition_latency;
> +       enum rpmi_clock_state state;
> +       u64 rate;
> +};
> +
> +const u64 discrete_rates[] =3D { 20000000, 333333333, 500000000, 1000000=
000 };
> +
> +const u64 linear_rates[] =3D { 50000000, 100000000, 1000000 };
> +
> +#define DISCRETE_CLOCK(name, current_state, current_rate) \
> +       { RPMI_CLK_TYPE_DISCRETE,                         \
> +         name,                                           \
> +         ARRAY_SIZE(discrete_rates),                     \
> +         discrete_rates,                                 \
> +         0,                                              \
> +         current_state,                                  \
> +         current_rate }
> +
> +#define LINEAR_CLOCK(name, current_state, current_rate)         \
> +       { RPMI_CLK_TYPE_LINEAR, name, ARRAY_SIZE(linear_rates), \
> +         linear_rates,         0,    current_state,            \
> +         current_rate }
> +
> +struct rpmi_clock clock_simulation[] =3D {
> +       DISCRETE_CLOCK("CLK0", RPMI_CLK_STATE_DISABLED, discrete_rates[0]=
),
> +       DISCRETE_CLOCK("CLK1", RPMI_CLK_STATE_DISABLED, discrete_rates[1]=
),
> +       DISCRETE_CLOCK("CLK2", RPMI_CLK_STATE_ENABLED, discrete_rates[2])=
,
> +       LINEAR_CLOCK("CLK3", RPMI_CLK_STATE_ENABLED, linear_rates[0]),
> +};
> +
> +static u32 clock_count =3D ARRAY_SIZE(clock_simulation);
> +
> +static struct rpmi_clock *rpmi_get_clock(u32 clkid)
> +{
> +       if (clkid >=3D clock_count)
> +               return NULL;
> +
> +       return &clock_simulation[clkid];
> +}
> +
> +static enum rpmi_error_codes
> +rpmi_clock_set_rate(u32 clkid, enum rpmi_clock_rate_match match, u64 rat=
e)
> +{
> +       struct rpmi_clock *clk =3D rpmi_get_clock(clkid);
> +
> +       if (!clk)
> +               return RPMI_ERR_INVALID_PARAM;
> +
> +       clk->rate =3D rate;
> +
> +       return RPMI_SUCCESS;
> +}
> +
> +static enum rpmi_error_codes rpmi_clock_set_state(u32 clkid,
> +                                                 enum rpmi_clock_state s=
tate)
> +{
> +       struct rpmi_clock *clk =3D rpmi_get_clock(clkid);
> +
> +       if (!clk)
> +               return RPMI_ERR_INVALID_PARAM;
> +
> +       clk->state =3D state;
> +
> +       return RPMI_SUCCESS;
> +}
> +
> +static enum rpmi_error_codes rpmi_clock_get_state(u32 clkid,
> +                                                 enum rpmi_clock_state *=
state)
> +{
> +       struct rpmi_clock *clk =3D rpmi_get_clock(clkid);
> +
> +       if (!clk || !state)
> +               return RPMI_ERR_INVALID_PARAM;
> +
> +       *state =3D clk->state;
> +
> +       return RPMI_SUCCESS;
> +}
> +
> +static enum rpmi_error_codes rpmi_clock_get_rate(u32 clkid, u64 *rate)
> +{
> +       struct rpmi_clock *clk =3D rpmi_get_clock(clkid);
> +
> +       if (!clk || !rate)
> +               return RPMI_ERR_INVALID_PARAM;
> +
> +       *rate =3D clk->rate;
> +
> +       return RPMI_SUCCESS;
> +}
> +
> +static enum rpmi_error_codes
> +rpmi_clock_sg_get_num_clocks(struct rpmi_transport *trans, u16 request_d=
atalen,
> +                            const u8 *request_data, u16 *response_datale=
n,
> +                            u8 *response_data)
> +{
> +       u32 *resp =3D (void *)response_data;
> +
> +       resp[0] =3D cpu_to_le32((u32)RPMI_SUCCESS);
> +       resp[1] =3D cpu_to_le32(clock_count);
> +
> +       *response_datalen =3D 2 * sizeof(*resp);
> +
> +       return RPMI_SUCCESS;
> +}
> +
> +static enum rpmi_error_codes
> +rpmi_clock_sg_get_attributes(struct rpmi_transport *trans, u16 request_d=
atalen,
> +                            const u8 *request_data, u16 *response_datale=
n,
> +                            u8 *response_data)
> +{
> +       struct rpmi_clock *clk;
> +       u16 resp_dlen;
> +       u32 flags =3D 0;
> +
> +       u32 *resp =3D (void *)response_data;
> +
> +       u32 clkid =3D cpu_to_le32(((const u32 *)request_data)[0]);
> +
> +       clk =3D rpmi_get_clock(clkid);
> +       if (!clk) {
> +               resp_dlen =3D sizeof(*resp);
> +               resp[0] =3D cpu_to_le32((u32)RPMI_ERR_INVALID_PARAM);
> +               goto done;
> +       }
> +
> +       /* encode CLOCK_FORMAT */
> +       if (clk->type =3D=3D RPMI_CLK_TYPE_LINEAR)
> +               flags |=3D 1;
> +
> +       resp[3] =3D cpu_to_le32(clk->transition_latency);
> +       resp[2] =3D cpu_to_le32(clk->rate_count);
> +       resp[1] =3D cpu_to_le32(flags);
> +       resp[0] =3D cpu_to_le32((u32)RPMI_SUCCESS);
> +
> +       if (clk->name)
> +               strlcpy((char *)&resp[4], clk->name, RPMI_CLK_NAME_LEN);
> +
> +       resp_dlen =3D 8 * sizeof(*resp);
> +
> +done:
> +       *response_datalen =3D resp_dlen;
> +
> +       return RPMI_SUCCESS;
> +}
> +
> +static enum rpmi_error_codes
> +rpmi_clock_sg_set_config(struct rpmi_transport *trans, u16 request_datal=
en,
> +                        const u8 *request_data, u16 *response_datalen,
> +                        u8 *response_data)
> +{
> +       enum rpmi_error_codes status;
> +       u32 cfg, new_state;
> +       u32 *resp =3D (void *)response_data;
> +
> +       u32 clkid =3D cpu_to_le32(((const u32 *)request_data)[0]);
> +
> +       if (clkid >=3D clock_count) {
> +               resp[0] =3D cpu_to_le32((u32)RPMI_ERR_INVALID_PARAM);
> +               goto done;
> +       }
> +
> +       cfg =3D cpu_to_le32(((const u32 *)request_data)[1]);
> +
> +       /* get command from 0th index bit in config field */
> +       new_state =3D (cfg & 0b1) ? RPMI_CLK_STATE_ENABLED :
> +                                 RPMI_CLK_STATE_DISABLED;
> +
> +       /* change clock config synchronously */
> +       status =3D rpmi_clock_set_state(clkid, new_state);
> +       resp[0] =3D cpu_to_le32((u32)status);
> +
> +done:
> +       *response_datalen =3D sizeof(*resp);
> +
> +       return RPMI_SUCCESS;
> +}
> +
> +static enum rpmi_error_codes
> +rpmi_clock_sg_get_config(struct rpmi_transport *trans, u16 request_datal=
en,
> +                        const u8 *request_data, u16 *response_datalen,
> +                        u8 *response_data)
> +{
> +       u16 resp_dlen;
> +       enum rpmi_error_codes status;
> +       enum rpmi_clock_state state;
> +       u32 *resp =3D (void *)response_data;
> +
> +       u32 clkid =3D cpu_to_le32(((const u32 *)request_data)[0]);
> +
> +       if (clkid >=3D clock_count) {
> +               resp[0] =3D cpu_to_le32((u32)RPMI_ERR_INVALID_PARAM);
> +               resp_dlen =3D sizeof(*resp);
> +               goto done;
> +       }
> +
> +       status =3D rpmi_clock_get_state(clkid, &state);
> +       if (status) {
> +               resp[0] =3D cpu_to_le32((u32)status);
> +               resp_dlen =3D sizeof(*resp);
> +               goto done;
> +       }
> +
> +       /** RPMI config field only return enabled or disabled state */
> +       state =3D (state =3D=3D RPMI_CLK_STATE_ENABLED) ? 1 : 0;
> +
> +       resp[1] =3D cpu_to_le32((u32)state);
> +       resp[0] =3D cpu_to_le32((u32)RPMI_SUCCESS);
> +
> +       resp_dlen =3D 2 * sizeof(*resp);
> +
> +done:
> +       *response_datalen =3D resp_dlen;
> +       return RPMI_SUCCESS;
> +}
> +
> +static enum rpmi_error_codes
> +rpmi_clock_sg_set_rate(struct rpmi_transport *trans, u16 request_datalen=
,
> +                      const u8 *request_data, u16 *response_datalen,
> +                      u8 *response_data)
> +{
> +       enum rpmi_error_codes status;
> +       enum rpmi_clock_rate_match rate_match;
> +       u32 flags;
> +       u32 rate_low, rate_hi;
> +       u64 rate_u64;
> +       u32 *resp =3D (void *)response_data;
> +
> +       u32 clkid =3D cpu_to_le32(((const u32 *)request_data)[0]);
> +
> +       if (clkid >=3D clock_count) {
> +               resp[0] =3D cpu_to_le32((u32)RPMI_ERR_INVALID_PARAM);
> +               goto done;
> +       }
> +
> +       flags =3D cpu_to_le32(((const u32 *)request_data)[1]);
> +
> +       /* get rate match mode from flags */
> +       rate_match =3D flags & 0b11;
> +       if (rate_match >=3D RPMI_CLK_RATE_MATCH_MAX) {
> +               resp[0] =3D cpu_to_le32((u32)RPMI_ERR_INVALID_PARAM);
> +               goto done;
> +       }
> +
> +       rate_low =3D cpu_to_le32(((const u32 *)request_data)[2]);
> +       rate_hi =3D cpu_to_le32(((const u32 *)request_data)[3]);
> +
> +       rate_u64 =3D ((u64)rate_hi << 32) | rate_low;
> +       if (rate_u64 =3D=3D RPMI_CLOCK_RATE_INVALID || rate_u64 =3D=3D 0)=
 {
> +               resp[0] =3D cpu_to_le32((u32)RPMI_ERR_INVALID_PARAM);
> +               goto done;
> +       }
> +
> +       status =3D rpmi_clock_set_rate(clkid, rate_match, rate_u64);
> +       resp[0] =3D cpu_to_le32((u32)status);
> +
> +done:
> +       *response_datalen =3D sizeof(*resp);
> +       return RPMI_SUCCESS;
> +}
> +
> +static enum rpmi_error_codes
> +rpmi_clock_sg_get_rate(struct rpmi_transport *trans, u16 request_datalen=
,
> +                      const u8 *request_data, u16 *response_datalen,
> +                      u8 *response_data)
> +{
> +       u16 resp_dlen;
> +       enum rpmi_error_codes status;
> +       u64 rate_u64;
> +       u32 *resp =3D (void *)response_data;
> +
> +       u32 clkid =3D cpu_to_le32(((const u32 *)request_data)[0]);
> +
> +       if (clkid >=3D clock_count) {
> +               resp[0] =3D cpu_to_le32((u32)RPMI_ERR_INVALID_PARAM);
> +               resp_dlen =3D sizeof(*resp);
> +               goto done;
> +       }
> +
> +       status =3D rpmi_clock_get_rate(clkid, &rate_u64);
> +       if (status) {
> +               resp[0] =3D cpu_to_le32((u32)status);
> +               resp_dlen =3D sizeof(*resp);
> +               goto done;
> +       }
> +
> +       resp[2] =3D cpu_to_le32((u32)(rate_u64 >> 32));
> +       resp[1] =3D cpu_to_le32((u32)(rate_u64));
> +       resp[0] =3D cpu_to_le32((u32)RPMI_SUCCESS);
> +
> +       resp_dlen =3D 3 * sizeof(*resp);
> +
> +done:
> +       *response_datalen =3D resp_dlen;
> +       return RPMI_SUCCESS;
> +}
> +
> +static const struct rpmi_service rpmi_clock_services[RPMI_CLK_SRV_ID_MAX=
_COUNT] =3D {
> +       [RPMI_CLK_SRV_GET_NUM_CLOCKS] =3D {
> +               .service_id =3D RPMI_CLK_SRV_GET_NUM_CLOCKS,
> +               .min_a2p_request_datalen =3D 0,
> +               .process_a2p_request =3D rpmi_clock_sg_get_num_clocks,
> +       },
> +       [RPMI_CLK_SRV_GET_ATTRIBUTES] =3D {
> +               .service_id =3D RPMI_CLK_SRV_GET_ATTRIBUTES,
> +               .min_a2p_request_datalen =3D 4,
> +               .process_a2p_request =3D rpmi_clock_sg_get_attributes,
> +       },
> +       [RPMI_CLK_SRV_SET_CONFIG] =3D {
> +               .service_id =3D RPMI_CLK_SRV_SET_CONFIG,
> +               .min_a2p_request_datalen =3D 8,
> +               .process_a2p_request =3D rpmi_clock_sg_set_config,
> +       },
> +       [RPMI_CLK_SRV_GET_CONFIG] =3D {
> +               .service_id =3D RPMI_CLK_SRV_GET_CONFIG,
> +               .min_a2p_request_datalen =3D 4,
> +               .process_a2p_request =3D rpmi_clock_sg_get_config,
> +       },
> +       [RPMI_CLK_SRV_SET_RATE] =3D {
> +               .service_id =3D RPMI_CLK_SRV_SET_RATE,
> +               .min_a2p_request_datalen =3D 16,
> +               .process_a2p_request =3D rpmi_clock_sg_set_rate,
> +       },
> +       [RPMI_CLK_SRV_GET_RATE] =3D {
> +               .service_id =3D RPMI_CLK_SRV_GET_RATE,
> +               .min_a2p_request_datalen =3D 4,
> +               .process_a2p_request =3D rpmi_clock_sg_get_rate,
> +       },
> +};
> +
> +const struct rpmi_service_group rpmi_sandbox_clock_sg =3D {
> +       .name =3D "clk",
> +       .max_service_id =3D RPMI_CLK_SRV_GET_RATE,
> +       .servicegroup_version =3D RPMI_MKVER(1, 0),
> +       .services =3D rpmi_clock_services,
> +};
> diff --git a/drivers/firmware/rpmi/rpmi-sandbox.c b/drivers/firmware/rpmi=
/rpmi-sandbox.c
> new file mode 100644
> index 000000000000..5597c27067eb
> --- /dev/null
> +++ b/drivers/firmware/rpmi/rpmi-sandbox.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
> + */
> +
> +#define LOG_CATEGORY UCLASS_RPMI
> +
> +#include <dm.h>
> +#include <log.h>
> +#include <rpmi-uclass.h>
> +#include <dm/device_compat.h>
> +
> +#include "rpmi-sandbox.h"
> +
> +#define RPMI_SANDBOX_MIN_SLOT_SIZE 64
> +#define RPMI_SANDBOX_SHMEM_HEADER_SIZE 8
> +#define RPMI_SANDBOX_MAX_MSG_SIZE \
> +       (RPMI_SANDBOX_MIN_SLOT_SIZE - RPMI_SANDBOX_SHMEM_HEADER_SIZE)
> +
> +#define DRIVER_NAME "rpmi-sandbox"
> +#define DRIVER_NAME_LEN (sizeof(DRIVER_NAME))
> +
> +struct rpmi_sandbox {
> +       struct udevice *dev;
> +};
> +
> +const struct rpmi_service_group *rpmi_sandbox_sg(u32 servicegroup_id)
> +{
> +       switch (servicegroup_id) {
> +       case RPMI_SRVGRP_CLOCK:
> +               return &rpmi_sandbox_clock_sg;
> +       default:
> +               return NULL;
> +       }
> +}
> +
> +static int rpmi_sandbox_get_attr(struct rpmi_chan *chan,
> +                                enum rpmi_attribute_id id, u32 *data)
> +{
> +       const struct rpmi_service_group *sg =3D rpmi_sandbox_sg(chan->id)=
;
> +
> +       if (!sg)
> +               return -EOPNOTSUPP;
> +
> +       switch (id) {
> +       case RPMI_ATTR_SPEC_VERSION:
> +               *data =3D RPMI_MKVER(1, 0);
> +               break;
> +       case RPMI_ATTR_MAX_MSG_DATA_SIZE:
> +               *data =3D RPMI_SANDBOX_MAX_MSG_SIZE;
> +               break;
> +       case RPMI_ATTR_SERVICEGROUP_ID:
> +               *data =3D chan->id;
> +               break;
> +       case RPMI_ATTR_SERVICEGROUP_VERSION:
> +               *data =3D sg->servicegroup_version;
> +               break;
> +       case RPMI_ATTR_IMPL_ID:
> +               *data =3D 0;
> +               break;
> +       case RPMI_ATTR_IMPL_VERSION:
> +               *data =3D RPMI_MKVER(1, 0);
> +               break;
> +       default:
> +               return -EOPNOTSUPP;
> +       }
> +
> +       return 0;
> +}
> +
> +static int rpmi_sandbox_request(struct rpmi_chan *chan, u32 service_id,
> +                               const void *request, unsigned long reques=
t_len,
> +                               void *response, unsigned long max_respons=
e_len,
> +                               unsigned long *out_response_len)
> +{
> +       const struct rpmi_service_group *sg =3D rpmi_sandbox_sg(chan->id)=
;
> +       const struct rpmi_service *service;
> +       u8 slot[RPMI_SANDBOX_MAX_MSG_SIZE];
> +       struct rpmi_transport trans =3D {
> +               .msg_data_size =3D sizeof(slot),
> +       };
> +       u16 response_data_len =3D 0;
> +       enum rpmi_error_codes err;
> +
> +       if (!sg)
> +               return -EOPNOTSUPP;
> +
> +       if (service_id > sg->max_service_id)
> +               return -EOPNOTSUPP;
> +
> +       service =3D &sg->services[service_id];
> +
> +       if (!service)
> +               return -EOPNOTSUPP;
> +
> +       if (request_len < service->min_a2p_request_datalen)
> +               return -EINVAL;
> +
> +       if (!service->process_a2p_request)
> +               return -ENOSYS;
> +
> +       err =3D service->process_a2p_request(&trans, request_len, request=
,
> +                                          &response_data_len, slot);
> +
> +       if (err)
> +               return rpmi_to_linux_error(err);
> +
> +       if (out_response_len)
> +               *out_response_len =3D response_data_len;
> +
> +       if (response)
> +               memcpy(response, slot,
> +                      min(max_response_len, (unsigned long)response_data=
_len));
> +
> +       return 0;
> +}
> +
> +static int rpmi_sandbox_of_xlate(struct rpmi_chan *chan,
> +                                struct ofnode_phandle_args *args)
> +{
> +       if (args->args_count !=3D 1)
> +               return -EINVAL;
> +
> +       chan->id =3D args->args[0];
> +
> +       return 0;
> +}
> +
> +static int rpmi_sandbox_probe(struct udevice *dev)
> +{
> +       struct rpmi_sandbox *priv =3D dev_get_priv(dev);
> +
> +       priv->dev =3D dev;
> +
> +       return 0;
> +}
> +
> +static const struct udevice_id rpmi_sandbox_ids[] =3D {
> +       { .compatible =3D "sandbox,rpmi-transport" },
> +       {}
> +};
> +
> +static const struct rpmi_transport_ops rpmi_sandbox_ops =3D {
> +       .of_xlate =3D rpmi_sandbox_of_xlate,
> +       .get_attr =3D rpmi_sandbox_get_attr,
> +       .request =3D rpmi_sandbox_request,
> +};
> +
> +U_BOOT_DRIVER(rpmi_sandbox) =3D {
> +       .name =3D "rpmi-sandbox",
> +       .id =3D UCLASS_RPMI,
> +       .of_match =3D rpmi_sandbox_ids,
> +       .probe =3D rpmi_sandbox_probe,
> +       .priv_auto =3D sizeof(struct rpmi_sandbox),
> +       .ops =3D &rpmi_sandbox_ops,
> +};
> diff --git a/drivers/firmware/rpmi/rpmi-sandbox.h b/drivers/firmware/rpmi=
/rpmi-sandbox.h
> new file mode 100644
> index 000000000000..132d1e9e8be6
> --- /dev/null
> +++ b/drivers/firmware/rpmi/rpmi-sandbox.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
> + */
> +
> +#ifndef _RPMI_SANDBOX_H
> +#define _RPMI_SANDBOX_H
> +
> +#include <stdbool.h>
> +#include <asm/types.h>
> +#include <rpmi.h>
> +
> +struct rpmi_transport {
> +       int msg_data_size;
> +};
> +
> +struct rpmi_service {
> +       /** ID of the service */
> +       u8 service_id;
> +
> +       /** Minimum data length for handling request */
> +       u16 min_a2p_request_datalen;
> +
> +       /** Callback to process a2p request */
> +       enum rpmi_error_codes (*process_a2p_request)(
> +               struct rpmi_transport *trans, u16 request_data_len,
> +               const u8 *request_data, u16 *response_data_len,
> +               u8 *response_data);
> +};
> +
> +struct rpmi_service_group {
> +       /** Name of the service group */
> +       const char *name;
> +
> +       /** Maximum service ID of the service group */
> +       int max_service_id;
> +
> +       /** Service group version */
> +       u32 servicegroup_version;
> +
> +       /** Array of services indexed by service ID */
> +       const struct rpmi_service *services;
> +};
> +
> +extern const struct rpmi_service_group rpmi_sandbox_clock_sg;
> +
> +#endif
> diff --git a/test/dm/Makefile b/test/dm/Makefile
> index 89f9a9d1edfd..0f334012dda8 100644
> --- a/test/dm/Makefile
> +++ b/test/dm/Makefile
> @@ -137,6 +137,7 @@ obj-$(CONFIG_CMD_RKMTD) +=3D rkmtd.o
>  obj-$(CONFIG_$(PHASE_)DM_RNG) +=3D rng.o
>  obj-$(CONFIG_DM_RTC) +=3D rtc.o
>  obj-$(CONFIG_SCMI_FIRMWARE) +=3D scmi.o
> +obj-$(CONFIG_RPMI_FIRMWARE) +=3D rpmi.o
>  obj-$(CONFIG_SCSI) +=3D scsi.o
>  obj-$(CONFIG_DM_SERIAL) +=3D serial.o
>  obj-$(CONFIG_DM_SPI_FLASH) +=3D sf.o
> diff --git a/test/dm/rpmi.c b/test/dm/rpmi.c
> new file mode 100644
> index 000000000000..7cb4fd11a46d
> --- /dev/null
> +++ b/test/dm/rpmi.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
> + */
> +
> +#include <clk.h>
> +#include <dm.h>
> +#include <dm/device-internal.h>
> +#include <dm/test.h>
> +#include <rpmi.h>
> +#include <stdio.h>
> +#include <test/ut.h>
> +
> +static int dm_test_rpmi_clock(struct unit_test_state *uts)
> +{
> +       struct udevice *rpmi_dev, *clk_dev;
> +       struct clk clk0, clk1, clk2, clk3;
> +
> +       ut_assertok(uclass_get_device_by_name(UCLASS_RPMI, "rpmi", &rpmi_=
dev));
> +
> +       ut_assertok(
> +               uclass_get_device_by_name(UCLASS_CLK, "rpmi-clock", &clk_=
dev));
> +
> +       // Grab clock 0 and retrieve the rate
> +       ut_assertok(clk_get_by_index(clk_dev, 0, &clk0));
> +       ut_asserteq_64(20000000, clk_get_rate(&clk0));
> +
> +       // Change to 1GHz
> +       ut_asserteq(1000000000, clk_set_rate(&clk0, 1000000000));
> +
> +       // Revert back to 200MHz
> +       ut_asserteq(20000000, clk_set_rate(&clk0, 20000000));
> +
> +       // Grab clock 1
> +       ut_assertok(clk_get_by_index(clk_dev, 1, &clk1));
> +       ut_asserteq_64(333333333, clk_get_rate(&clk1));
> +
> +       // Grab clock 2
> +       ut_assertok(clk_get_by_index(clk_dev, 2, &clk2));
> +       ut_asserteq_64(500000000, clk_get_rate(&clk2));
> +
> +       // Grab clock 3
> +       ut_assertok(clk_get_by_index(clk_dev, 3, &clk3));
> +       ut_asserteq_64(50000000, clk_get_rate(&clk3));
> +
> +       return 0;
> +}
> +DM_TEST(dm_test_rpmi_clock, UTF_SCAN_FDT);
>
> --
> 2.53.0
>
