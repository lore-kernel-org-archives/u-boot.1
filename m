Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29483EF48CA
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 05:49:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F55982BF2;
	Fri, 13 Feb 2026 06:49:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ozgpLqIM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y0KAQ2Ff";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 311CE83936; Fri, 13 Feb 2026 06:49:38 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B922D80FA1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 06:49:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D3BHW72093764
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 05:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=TsNMhMb39kEx0J8FBuC5dCQq
 N0zPxRTpTcY8pSehZ9Q=; b=ozgpLqIMKMELWx6rjjue7vd7AL0rFO114kZZ8F0P
 R4y1SDemgmhNlNwGuV9kmIVoqZnycq0eBovRFKLFBJpFhG0qjSUls4A9jkZO8e16
 URthZsqgrty57sOkUkYRtwfvpmeZvtNVSyX5/EayanDu64eDiO5diNxBxoZdmTa5
 z4W/0cUsUz0STdtl465+yp08wfwG50ygGmu245gPkXuIvgz34lG0iYtR3gmlgfag
 iSMRJy4s4SdpWoROqFuC0Ilh9EZf7kUqujqGkLTZ9w6k+nbhTr7/J4OeQZtYJgpR
 98bSXKebCrb68M+2anRQHDRQZFCGg/6OBsS5MImr8Esuug==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9k6y2bck-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 05:49:34 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2aad5fec176so6490465ad.2
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 21:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770961773; x=1771566573; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TsNMhMb39kEx0J8FBuC5dCQqN0zPxRTpTcY8pSehZ9Q=;
 b=Y0KAQ2FfEltAI1jXTKa2iY1f0bL6MqC5LdhLg/rI2/Ah6KM3v0tRMYLUw0K2U/hnu/
 cBixLvo+xImJAOUSelnGPJBJivahq0wbOdJFesB0SisS1CefeUhmCgVaa7x78ULVsFZA
 uqRu7PwDP0ph/WKoVzeuN9ZZDn2qJz3M8EFkpKZzaTqY4V8QbY9svxo7Xkw/neO5jlff
 v/X1nJIVY13/wzrfQ5xTZ3RQLF5IvXrAIQKJ5BpamoG0WJRfgCB+85RUgefYP1YY02uh
 7oOcSjaG3U0GD/wbvTh2bug/oGvI7/HAY1QWo9ARwXAwdXJ02tTLhLgH6GXKPM6da37S
 113g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770961773; x=1771566573;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TsNMhMb39kEx0J8FBuC5dCQqN0zPxRTpTcY8pSehZ9Q=;
 b=TiZRZ/O06nPKv91QYMhbSyMu9yMfapd8iyQ81YMPD2C+iWywpoCopsaoBcRM1rzqao
 t36chbnwIQsgVf6oCZhrXBODxVabmRMTfOCWR18e6/NKzE0h0aVWTrqOIuf/1BtnfO7k
 pXW4ebWeABZpjL/3PASTJtm5b6up+Q/8oAKCmerN257j2+zOu311ncsP4AibK0degPY0
 9WyHcp8584QGGA2b+WdzH/64ndk0ixBsXjFq20bnpFxYcEFcAUKBHpWizCLApnvSfOiS
 KkGwAZz9NNyfGbTC0hiWA0ULiS53uJLNpHRR8s6RDY4L2dKHHNa7uECjosfiely0c102
 65Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHH2/dysUDY4yykDaSKIuwHRyTPU0IgYg9xEltTf/KLStsQE+DH7XgIXSts+6mXkfKYKnceh8=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/DCCIfJYlrEH4B2+BAdN84CrIWEG3ZGER18k5GkrHL5XI8ZR/
 8Lz75q/J6CYL8/bGUldvBzhulD3o2MqBYW02UDkCua/FNk6WiBxufne6CyVCokT4Og6HztmvVmD
 322kC7zA2wP190o+4L6KvLEXW7hUOIoaJ+7rEXvBCwN7acGHlTe5rUE1W
X-Gm-Gg: AZuq6aLEarQFVZb5xWPToqZ+d6D7gWuRF/+XxXEujTFRxzf3bkisrAnRFLquY7BVB+j
 7zjUJSFy2v+9T1vl5/ZmMZBYJXS4YVOlC+Ecp0XCvXy+DtPbN//hGkNOnGLZ9f0hUWZUAZCyekP
 NFd0PI5Nju/t3L3oWpkcAsVy/0EjgGR8h53QOthggMTfOPd4F8f3c0iDdu5/g2xwiJryI/HzWFj
 nkmG0SBm/xqA9s6d+gRgb3qMM1BZpGQARMJIuT1EWFjffc3PYIQzNY6DjH2GLjVKA37RDhQ56Ro
 evYFAhp2ZgkuLOX2od1braw4jQjYe+Lys1BJ8oW6+BRu4xHv1E5nYpHgk4vacS+pBijZ74ZoH4J
 UJOB3+BWZvGxVW8YfEkDkmXCPZixN2m5wol7Q1eDYFyPmg6UxQS+t3TKeLLTolIDxGVdbwhkp+t
 VFfuyH0tZN4zw/VH7DAiKlLJfL1RceKbxmhKhwVWD7Pi2m4FYwxDg=
X-Received: by 2002:a17:903:41cb:b0:29e:9c82:a918 with SMTP id
 d9443c01a7336-2ab5055e2fcmr8191705ad.22.1770961772891; 
 Thu, 12 Feb 2026 21:49:32 -0800 (PST)
X-Received: by 2002:a17:903:41cb:b0:29e:9c82:a918 with SMTP id
 d9443c01a7336-2ab5055e2fcmr8191495ad.22.1770961772428; 
 Thu, 12 Feb 2026 21:49:32 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ab2986edecsm73192385ad.22.2026.02.12.21.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 21:49:31 -0800 (PST)
Date: Fri, 13 Feb 2026 11:19:27 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Tom Rini <trini@konsulko.com>, gabriel.dalimonte@gmail.com,
 u-boot@lists.denx.de, caleb.connolly@linaro.org
Subject: Re: [PATCH v3] fs: fat: Handle 'FAT sector size mismatch'
Message-ID: <aY67Z87tM28Dtw76@hu-varada-blr.qualcomm.com>
References: <20260122063442.2622684-1-balaji.selvanathan@oss.qualcomm.com>
 <20260128204102.GA1740001@bill-the-cat>
 <0d815ef4-0a9d-4aa9-95bd-580320357531@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d815ef4-0a9d-4aa9-95bd-580320357531@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=NsTcssdJ c=1 sm=1 tr=0 ts=698ebb6e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=YfCOm-DyAAAA:8 a=XpE1AkgCAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=osljQ9aYmv_DjUfmjjMA:9 a=CjuIK1q_8ugA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=zQLMK8awuJ6_Hvp-_9Ux:22 a=dpZMgbseYPk84XhQl7oQ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA0MiBTYWx0ZWRfXxBwYkI0e8RQq
 THnU8XwDfmXrUNZWbg/oXUJaTqLdSEVBcL+++V22PcOLkbNfw//Z/e0GE76P+CKSjkJrkmcuuz6
 90KfgpPr3k7DfjhvERRs8ciUrZA/RTL39ta1aGqXZSCh3O7JChWA9G7WsMdGK9QQm7hGMHFtVSY
 3FTbjVR0d5Jdf7kJyBNmWwPvoO01T1tejPxA4afob2ZBq7QbVmZ7dDZn8kh0DygHUBXeDtHwHmm
 9CLVtYUzGX9YSLRXkRkcAeut/5qvB3Ak+W/5IyUUcho6ZtOBpagO/innOKS62vABI9yYsTo7xkB
 bIhB6aZAwewP+D0h4+8aTlqD6pVWbMgTVC7J8WsHzcq+uXf0DNvyX8qD1x7hV4s2STKk7nYL4Lu
 XjRoU4LpdAR+CCqTwpsN4CCiG2YRxF4pa/V1JiGL2usYEDK55dYbpvdjSqmbU66XAXkBFjjj0o6
 JjMHWDPPbAujX1nbYkA==
X-Proofpoint-GUID: s-n-CUaUsj7i5SDpUFrMweOifAFKz_UF
X-Proofpoint-ORIG-GUID: s-n-CUaUsj7i5SDpUFrMweOifAFKz_UF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130042
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

Balaji,

> On 1/29/2026 2:11 AM, Tom Rini wrote:
> > On Thu, Jan 22, 2026 at 12:04:42PM +0530, Balaji Selvanathan wrote:
> >
> > > From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> > >
> > > Do FAT read and write based on the device sector size
> > > instead of the size recorded in the FAT meta data.
> > >
> > > FAT code issues i/o in terms of the sector size. Convert that to
> > > device sector size before doing the actual i/o. Additionally,
> > > handle leading/trailing blocks when the meta data based block
> > > no and i/o size is not an exact multiple of the device sector
> > > size or vice versa.
> > >
> > > Tested on UFS device with sector size 4096 and meta data recorded
> > > sector size 512.
> > >
> > > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> > First thing, clang shows a lot of warnings from this:
> > https://source.denx.de/u-boot/u-boot/-/jobs/1365316
> > Second thing, filesystem tests do pass:
> > https://source.denx.de/u-boot/u-boot/-/jobs/1365314
> > Please make sure v4 is put through CI:
> > https://docs.u-boot.org/en/latest/develop/ci_testing.html
>
> Sure, will address the warnings and will put v4 through CI.

Have posted v4. Please see [1].

Tom,

The CI failed while building am33xx kirkwood. When I locally reverted
the v4 change and tried to build amxx related platforms, I was getting
similar errors. It doesn't appear to be related to this change. I might
be wrong. Please let me know if that issue has to be resolved.

Thanks
Varada

1 - https://lore.kernel.org/u-boot/20260213053719.2590474-1-varadarajan.narayanan@oss.qualcomm.com/
