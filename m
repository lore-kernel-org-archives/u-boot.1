Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9137FD6B076
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 15:31:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 078E983F32;
	Thu, 29 Jan 2026 16:31:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="D5DMGURO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X86xo1z+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5F2B83FDB; Thu, 29 Jan 2026 16:31:51 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C13F83B32
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 16:31:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60TAln8Y2953444
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 15:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FGqg/2Psbav2L5mAnUDM/RCTaMVvGZ2qxcOwe384Uy4=; b=D5DMGUROhttqAXz1
 ohWk4Bgxl74XE8H/oZjgFFry/pqJEphefmIJ8VVxm2pr/xNR6DIPwGnBIBldzdmZ
 4++jMO0fux+MoTFiT9PFWrIxPsGGoOWklspV1lfLDeifB6vw06nPdiTtUM6/nkJK
 SMKjwBQlnIK/sUhjkFvzE9rs02Qll3AlL6QofepGGaTsWxqSkw+1/mR8ba60Wd3P
 8hnSjl4g6ZWkmd983NmCDTsG+727IJUdeuhm+erJHPsrbU9YD8Vfc1MqMDdO3UqD
 LqXQYrm7WD23F230r3DT5+10kIZa/cwQXYGJZteX5nrm1NnFk+RpBJrMDZJd8J72
 4Rk8Rg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c06420vs9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 15:31:46 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2a75ed2f89dso10418695ad.1
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 07:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1769700706; x=1770305506; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FGqg/2Psbav2L5mAnUDM/RCTaMVvGZ2qxcOwe384Uy4=;
 b=X86xo1z+XnWjUVOfFuvug9jVenAzKDWxtY5zthEZXK+zYNz5GP4REQB4oLHwG1F0gR
 janB/A/NvdoLybJYZoTA9wziU5dygjHTPhkzvB2BVT2ArAMYRb7tZjQRt8l0avKjdk2+
 gjQF9mx1K2w8gRt6Y4qm3cnsRTxQSbmbLAowGg2s8vjfLsh5R/1XQR7FXKqLiVCp/WnU
 34Zp0q2ux5IhZieWJX5lTWQNhpW1oXZNZGV1HsZ3I+JTz00KfK5ttaauscLSCWov2TuM
 ks/qYa0VKdzWmh7Vr9INS3SxewDWMJEsyeCwKPGM/2LbIZadZ3TPRBYCHGANi/UWgDpw
 CjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769700706; x=1770305506;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FGqg/2Psbav2L5mAnUDM/RCTaMVvGZ2qxcOwe384Uy4=;
 b=wz9xk0ESS2ydGo/HciKZmxg+bMFl22pK/9jpwnxxZxoE46w8fttCsKsI9ui+EOLmBj
 UKqAY0acwrC6utt3pdQ+tSaXdB3RB6YXX++6Ad1nuxN1fpQI4Ox6x0ObGyyD7WzDKKrF
 Rhw+WzdaQK7v+zzbGGB9JtIEBuldGN2qbIO3+iwNFme0sT4pTakI18vGM2JcNhOtoVrq
 u4uiJsUkDtefmpQLA/cShePKB8Am+PEvECeW5kK8F95YH4pexd4ETdMyBq74doNjI9xK
 0K17htuOcjVrIdvgVFDakOoot+2NpW9sGlqp27j3f5NiUzWMU0i0vWQ/oTohOgYcQWow
 AcCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbAeBdIKE6/9MZU3gPyDws3lP6Sg7nC2HW7GfigcCZ2D9UrhGgllnrFD0rZRic+qNz+J3r1AY=@lists.denx.de
X-Gm-Message-State: AOJu0YweAvkvd1H437ZTdAEwejMImDhRL0O0PfEBq31vNmSMLeVg2EST
 gtkN1x6W4NrJjea+K1sewNX8OWcSOfGywlv8wzyspKbdBVD3FoC2R3dewVFfGGCRu6A4VhmXaNo
 yXgFdJEe6oLYZNG0yM3ZwkXDE0O3uu+sa6/y9N5+dlw6gxulzM0HBMdlR
X-Gm-Gg: AZuq6aIlxuTxNloMA68k6r59tF86ZGSrIbIhLc+5Zhzblxh0yzppyWWlYKmz+NIB747
 +PR6BlOzni353xsmaSIHonbBdlDJxnYbthhVh0tvFm79/HRlcYkbLIQHuRE0D0Jw6Pl5wA1Ateo
 Uw5drIsKDXVPUntqUAUxVraWhUPeRGv6CQQZPrNbqiZDOEYlQ9vmGWS8iYvlyzMI8ZPwfiH1TaV
 dNchzY847XPKsuTgDGse6K4kZE+o/afITH2sW7+vgUC84eghOJutjCrTs6CToYYyQ/4Vh7gZA7x
 hYE7TdgGa20r+MVQ1X+crx44jIRfJIjkFwdwH1cmL0V7ZTonPi3wlq25XCiH8wHPUP75+mrJWKl
 Yj0F1VJBsTvBqx+aTNAe7LOKxJrAMdNm6m74eQTj3u03xOK0=
X-Received: by 2002:a17:903:350d:b0:2a7:b8f9:5a5e with SMTP id
 d9443c01a7336-2a870e00597mr90762285ad.46.1769700706063; 
 Thu, 29 Jan 2026 07:31:46 -0800 (PST)
X-Received: by 2002:a17:903:350d:b0:2a7:b8f9:5a5e with SMTP id
 d9443c01a7336-2a870e00597mr90761975ad.46.1769700705501; 
 Thu, 29 Jan 2026 07:31:45 -0800 (PST)
Received: from [192.168.0.3] ([183.82.205.163])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b3eef68sm53088455ad.16.2026.01.29.07.31.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 07:31:45 -0800 (PST)
Message-ID: <0d815ef4-0a9d-4aa9-95bd-580320357531@oss.qualcomm.com>
Date: Thu, 29 Jan 2026 21:01:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fs: fat: Handle 'FAT sector size mismatch'
To: Tom Rini <trini@konsulko.com>
Cc: varadarajan.narayanan@oss.qualcomm.com, gabriel.dalimonte@gmail.com,
 u-boot@lists.denx.de, caleb.connolly@linaro.org
References: <20260122063442.2622684-1-balaji.selvanathan@oss.qualcomm.com>
 <20260128204102.GA1740001@bill-the-cat>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260128204102.GA1740001@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEwNyBTYWx0ZWRfX8DAON0nRb8GM
 kHHVayHTr6+sD3cMpS1rcKWddwiF6y0JqO2EyhL1X3dHoQ/GpPQlpIQScwgfH6Te+vRVK4GDcXn
 yVefpKfyBKrwdF88Opz7Og33Xme7K5PeG3xcif3JUw15fDhnbeCmEhmcbXyhIeaW1is8EphS5od
 J7U0DM3cBynKzLYdPcD+vTVwhDCKK+EnCUGL8NyYAwItpA7S6rAWmAKOs9T80qiCXoGRHkpU5P7
 JUJY+CVFiLBhmgLP+/PesX+CBvYTMYInaKMTUF1w2fRVms+4S2/QOh18DIb3RLyxvV/WHs6ywSp
 jZqh3B5P7o22TZmo5BVq2MsqgQk0ZITQdZTpjhdx3Xv/cRcOm/2GVcAE5s8XO2dXLYQv/uIl+hh
 +7mscoXClICParAyIcb6tfpD+uYPvWpkJHR/mfeaY6sbG1Sdjp6OoE5gyG1TdvMimitdrD0+YX1
 SuemsJhOiN18ScAa8Zw==
X-Proofpoint-GUID: 7Jhd3QANnihexUulY6y745gWW65NKhlu
X-Proofpoint-ORIG-GUID: 7Jhd3QANnihexUulY6y745gWW65NKhlu
X-Authority-Analysis: v=2.4 cv=dpTWylg4 c=1 sm=1 tr=0 ts=697b7d62 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=HZnA7H0z88OusNqQyx+Rcw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=YfCOm-DyAAAA:8 a=XpE1AkgCAAAA:8 a=EUspDBNiAAAA:8
 a=yiZsbi-qMpEF3Jq5_HwA:9 a=QEXdDO2ut3YA:10 a=Itx0EmGzAlkA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=zQLMK8awuJ6_Hvp-_9Ux:22 a=dpZMgbseYPk84XhQl7oQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290107
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

Hi Tom,

On 1/29/2026 2:11 AM, Tom Rini wrote:
> On Thu, Jan 22, 2026 at 12:04:42PM +0530, Balaji Selvanathan wrote:
>
>> From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>>
>> Do FAT read and write based on the device sector size
>> instead of the size recorded in the FAT meta data.
>>
>> FAT code issues i/o in terms of the sector size. Convert that to
>> device sector size before doing the actual i/o. Additionally,
>> handle leading/trailing blocks when the meta data based block
>> no and i/o size is not an exact multiple of the device sector
>> size or vice versa.
>>
>> Tested on UFS device with sector size 4096 and meta data recorded
>> sector size 512.
>>
>> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> First thing, clang shows a lot of warnings from this:
> https://source.denx.de/u-boot/u-boot/-/jobs/1365316
> Second thing, filesystem tests do pass:
> https://source.denx.de/u-boot/u-boot/-/jobs/1365314
> Please make sure v4 is put through CI:
> https://docs.u-boot.org/en/latest/develop/ci_testing.html

Sure, will address the warnings and will put v4 through CI.

Thanks,

Balaji

>
> Thanks!
>
