Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CB9D6CFC1
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 04:36:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE26883B72;
	Fri, 23 Jan 2026 05:36:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dcy3zYe+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KJkmgkoP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7020B83B5E; Fri, 23 Jan 2026 05:36:24 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3635483AE9
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 05:36:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60MK7XSC1117235
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 04:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=VlfK3qTuUjnRShkWEtZEN78N
 RLeNJLsCzQl/uH0tXaU=; b=Dcy3zYe+Wop62mH0OmvXO1qGsSPtxxut2xWXNfQg
 WUOerFTX/dUqrpRqeZR0gOW9UvUdNb0Lzi7JIBTn2FnUrDmW5uMeTNLBYerCDUim
 3cT5dUXkXsI9f9nu5hJ8+LD+8lj3SnB+9OsxrZJopu8PBn/RhkpuNe8PKAkCZxdf
 GPOXdDgpzJW2OGppG6Krtn6ZQbmMy7djtaJnt7x3e0Wy5kJBC4h53MmsH0OudAIU
 6f22djxzKN3E1kInVgf2ll7SyKzZdT0phnTt9PxAOCfMAG7jRoAgUwDk+1Wr9m+5
 atEA5igk6GXgJWODDt6z6pE/bo/fIf8IYLMiep03e3HJrw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bur1ca1aq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 04:36:17 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c52d37d346dso908528a12.3
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 20:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1769142976; x=1769747776; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VlfK3qTuUjnRShkWEtZEN78NRLeNJLsCzQl/uH0tXaU=;
 b=KJkmgkoP+YUNyFI80UKq4cxWzAPYebLb+W/4Jrddc7glpqISVcluWs4Cf2A+tbrqfp
 Vn0BONENn+b9QX024t4GtsNeNTr6HuYhOdlJi4JEf2vn9F6p6AsfjnmNDV1Y844YzOrT
 0UM+uUIse0lq9tns6bWVACPvk9neAFYLrdK/PM0+lXX00PjlIw7A2y9GC80Jrvwbe4Y6
 IrPi0n/OMr/r/iCocqz3xLoNUrh4uG9sXnYVPEFwNHEuazPh5RyC+bbg5t8k2tLeP7JQ
 WiSoJziYTEf41UN+n0nCJbeWeTMzoGAiPYRyZzZGL3AM6wOLVtir1apqt+XcqsDx35Mb
 cdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769142976; x=1769747776;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VlfK3qTuUjnRShkWEtZEN78NRLeNJLsCzQl/uH0tXaU=;
 b=tlYo7shO4kn3iBvVCc4ZZ2Y3MaDnlEJJsN+XQ1D1Rvptm56q8fCfGk3hcCjcYdaZjr
 l85pLbCjMcTih9okHZkOBOFX9P+VM3yhNyxzMKEZUhqhh1JDi/eSKlO1ofgwauxwCSlp
 5KnIDeovFRoCo+n2yZSXGFS8jD4GVGF5TLonorPjJGKBG4kvMI75774ae9uArq7I2QHA
 sErjZ4f6VjFA1L4I2cHoYpN+bzqiiVoSfZhjhdcpIA3mEOuJ0TL95RyOicqc19uvcs8N
 MfkQRZMxinZeGF4NB4jipqPeSC6X9k+8WVixRlPlXiQjMZNhsFNCB63GwQJUAPjGlb9u
 7uPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPYU+sFon5hQNu0YwLWx2HMv4ttuAOzaMPB567DVoNEfkGbUrAP2+DAfUYXwIKfjB72LYT/Gk=@lists.denx.de
X-Gm-Message-State: AOJu0Yyg/OuMf9n5ePfXbIPWwH3KUSVWyionhLUTE5dHfPgXQnw0ZFOu
 RMIjg8vCh8jPJsdi5KMMPBzdIjgEg/GbRLaJVmJFL3wqOVWfuE8vcFXHqjSNXMWkhnE0nujIMmT
 04FpGII/kGaIweHpdEzdjA4xPzz0pnyvQeqVQiUCZ/POjz0C6gw3s1nW6
X-Gm-Gg: AZuq6aJD5xgxsYflIsuarUY+Fxv3domRnDlthiJKp8a0lRqC8zU6YhHkAAegLfCKbxz
 PX45eZi4Yo81N4IObiCL5HGgl4bBhmoHcXU0fGdbhECaFBFgVjUnkSG/62biJP4H/amRuAcOeK+
 t4zxpyFJiW70I23r0TWbh+k7Fgp/7eXVxzUZX8N8Y/RnQLlU8JJunYE78XS3gQB28IIXovZcYzL
 /1AwX3sPxmCjHEkQWerUMD6qYhBwurqhqhxnZ9254ThgKI+65kYhqAOorHzP9VRwWRFXmsWO+Cv
 lAEIZfJW/x0dk5CRgk/xYmzDWJ+FhN1zhxlXAG5AAK3yYfv7hHCcYl4O4DpV01VVwPhh/tnmHXE
 Mzvt7xxAdNrRG/eATrmpKY8ZNKPKf9fg/7MBBthddfIros0p6ULu1Ngij5j5EOeq6CkqUkvAurE
 xE2VoLo+2YluRkDtF0ksD4lmh2WAid99lRsqZoEYU=
X-Received: by 2002:a17:902:d489:b0:299:e031:173 with SMTP id
 d9443c01a7336-2a7fe625165mr15983195ad.35.1769142976446; 
 Thu, 22 Jan 2026 20:36:16 -0800 (PST)
X-Received: by 2002:a17:902:d489:b0:299:e031:173 with SMTP id
 d9443c01a7336-2a7fe625165mr15982355ad.35.1769142974981; 
 Thu, 22 Jan 2026 20:36:14 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a802daa85esm6999845ad.1.2026.01.22.20.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 20:36:14 -0800 (PST)
Date: Fri, 23 Jan 2026 10:06:09 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: trini@konsulko.com, neil.armstrong@linaro.org, quic_varada@quicinc.com,
 casey.connolly@linaro.org, bmeng.cn@gmail.com,
 andrew.goodbody@linaro.org, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/2] Revert "scsi: sync cache on write"
Message-ID: <aXL6uTKU8xVWhwyM@hu-varada-blr.qualcomm.com>
References: <20260122083954.2722972-1-balaji.selvanathan@oss.qualcomm.com>
 <20260122083954.2722972-2-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122083954.2722972-2-balaji.selvanathan@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=FswIPmrq c=1 sm=1 tr=0 ts=6972fac1 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=N_ykLT0s8f5MVdpOFKkA:9
 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: vJ35j32b6eKfO7dJmruBMDCEMGg1rCVs
X-Proofpoint-GUID: vJ35j32b6eKfO7dJmruBMDCEMGg1rCVs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDAzMCBTYWx0ZWRfX6QZCRZuMg1wL
 uKVhYPPTF49BCOLvgzIAnbPuzNfwUgsnksOvgKSxnGYo51bnK9bLWDQdaNia8rng/Ly+lUivmYQ
 bGEC3Tt1x+KNL+pejlJ1rSjIrjQMhMmfdXxwxEWoE5cUi90clXFXB3YkkJcTdxQqn2uWEz7wEi7
 0PtMQ1FsGWshrEkE4RorMdoHjlv8LXqVOFCtyRBlAIcENMrbFDdVIx03VvVpwVW1Cifg3zQrYVd
 sXIzfsrwkQUTGciAOkIPKW83vsfuNerO3p3S7fOfj39ArQo5cdtgMDmnyogVzL4xTIRC/Lukdn8
 WvayWKq+B3/ShHF4R3t60qDbNKCmZe2GVUY6xzBIqbocmqu075Tvf8JpjEX1HZhy5IcWuiMdi8C
 vrxRtoQPnWnrSoJ6J1PUaUKMmRhWarzALAbbnoCQQyNnwxqVOHJqj2KrXXzv+RT91i04z5eTTT8
 ybr0NcCztprhEMaHvYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_06,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601230030
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Thu, Jan 22, 2026 at 02:09:53PM +0530, Balaji Selvanathan wrote:
> This reverts commit ffe4e6ab42d2534302be825e49a2d085acf80f30.
>
> While the SYNC_CACHE approach prevents data loss during board resets,
> it causes system hangs during large sparse image flashing operations.
> This will be replaced with a FUA (Force Unit Access) approach in future
> commit, which achieves the same data integrity goal more efficiently.

Typically the format is

	Revert "subject of the reverted commit"

	-- explanation of this commit --
	. . .
	. . .
	. . .

	This reverts commit ffe4e6ab42d2534302be825e49a2d085acf80f30.

> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

-Varada
