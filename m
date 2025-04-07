Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF7AC3601E
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 14:18:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A03E80194;
	Mon,  7 Apr 2025 16:18:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OAWV+kNi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39238807B1; Mon,  7 Apr 2025 16:18:17 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC8768006D
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 16:18:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378duhC010872
 for <u-boot@lists.denx.de>; Mon, 7 Apr 2025 14:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=I9RjSA9xhnuZFz9143cCMnRg
 fowjmphK/a1d78zWIU4=; b=OAWV+kNikS2kYcqqKnsyEtHiBuFOhykI35fHCDF6
 mqLuTa8whAmu6bGY4r0j1qpsCadmt3Mlpaq8Dbg+iD8KxV8nV9cexphoJ89bZUPl
 58joBtpgpk+VM6Ff5RYyrZHTqE/9vtjRRqO3DVaIn3SsPPsQmfYZp7uHrjuznxO4
 NXmAoWFZyS/2ByV8wEynCLQWv2oQahCWvOuJVSimRV63nBHxWmDkE29QhmqkQ/j0
 POSRTc+4jwAo/U1a9D/4fWHMRS36ECP2RlgeguJ3W8wKmoW8Zvxpm5WOoQInuurC
 fI45ZCp7ITI6VVUOXdUkvtYt2/D8NQ3Jyu7gEtwdqan3MQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twd2mggn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 14:18:13 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-47699e92ab0so81791681cf.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 07:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744035492; x=1744640292;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I9RjSA9xhnuZFz9143cCMnRgfowjmphK/a1d78zWIU4=;
 b=DGF8BI/CKVZ6zhuv1QyHfyc0WR3/8dyf/En+bRoDKgPVFaSd3iMeFd3pFsT8KC3GZ7
 NpxpWEEKAbRzCYB948hbYPUdB3v3vzlprpzvM6xLBkQOh4p/1L122Y8mE8CaxZa7Hb9H
 IoMq0fO8YAhZx6NCvOJno65mfPSvqFibgU4nrqtBWFzRLx8MDJqwC01rNwkDE3O0TQLW
 0zCAEJSUvWTXVz3A2+2Dr8W6mLyUptg4VaLMzfoaxStkXAR9LqCLJUQhKzn20im7/Awm
 YBbhZd/xqVJci4w34Y6/bfv7OIofrgWE/tIDqN8MeITHB6EnyOpdNyoekSYpnaaQP0zj
 7URg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdYOnv399wjgur3H8931AiOnRv2AH3/xVW09T8N7/LYT6hoGMp3V5OYIv9hIhqcpFL8V9YYPE=@lists.denx.de
X-Gm-Message-State: AOJu0YxW/jYiktaycXuDg71rs8kogFUrvOxw7hKbmcZcafuFwjzV54J9
 ADxFpe70kNlDUUe9Q6YO3OQ1UcI8RZUUGkPSOPJ6HJchYLIHafmhbPVeTlAdww9lFGfDV4m7F4X
 OeiUHf8qvhXqUVKCWOcJvMbhfJcmQ5DJIvdnDjyktpsnezymwPgfJ
X-Gm-Gg: ASbGncuuCam14fwBDenlJ0kS5REwDSnPiOLAGA4Hd4K3swyU4pqAv1MvxERhqCNpBJm
 FkdEg+XQ0pAvDaQkfcKtaUqR0kWVGjvz+tArCQnkvmR6aeRzwf77YFBILnleLhsd36V+C9mlxUc
 kUpDIAxVAox8K0co0LFPDcHoZaTTrihhbUWb4MkJqN+NNuhcddo9L4Dw2VcOTeIWp25EWNwceoD
 y+h0ZRiRekSfqXsFaXsXikzYGiO2KLKKgxddAG9PH9NgxSWqvNSZMOAqFLzKKg+PFvs5y3sRqdE
 Gsczoid3cN1q5Mr24v8QmVocFDSvOK+ZTHJUyEJiVOrTm7sQwuk=
X-Received: by 2002:a05:622a:1446:b0:476:850a:5b34 with SMTP id
 d75a77b69052e-47925992b1amr204058921cf.30.1744035491671; 
 Mon, 07 Apr 2025 07:18:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHFTWg7UWmZqvEJ8Ywo93mTHfMD0WU3K4CODDN7Y6FhINgyisJz+sPihWEiRNaZDDCEvjstw==
X-Received: by 2002:a05:622a:1446:b0:476:850a:5b34 with SMTP id
 d75a77b69052e-47925992b1amr204058581cf.30.1744035491382; 
 Mon, 07 Apr 2025 07:18:11 -0700 (PDT)
Received: from trex (233.red-79-144-185.dynamicip.rima-tde.net.
 [79.144.185.233]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020d938sm12348866f8f.65.2025.04.07.07.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 07:18:10 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Mon, 7 Apr 2025 16:18:09 +0200
To: neil.armstrong@linaro.org
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 caleb.connolly@linaro.org, sumit.garg@kernel.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH 4/5] clk: stub: add qcom,glink-smd-rpm
Message-ID: <Z/PeoRytdb3M7j22@trex>
References: <20250407120536.236003-1-jorge.ramirez@oss.qualcomm.com>
 <20250407120536.236003-4-jorge.ramirez@oss.qualcomm.com>
 <0da8570a-1f41-47b8-885d-b9361de0897c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0da8570a-1f41-47b8-885d-b9361de0897c@linaro.org>
X-Proofpoint-ORIG-GUID: IxSpPERPbOePh6OriyhLXHRYnScNgem2
X-Proofpoint-GUID: IxSpPERPbOePh6OriyhLXHRYnScNgem2
X-Authority-Analysis: v=2.4 cv=NaLm13D4 c=1 sm=1 tr=0 ts=67f3dea5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=9rMOtB7ueBl8bWGkC6audQ==:17
 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=3JgXUKaukyY0bKv0KU4A:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070100
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

On 07/04/25 14:37:27, neil.armstrong@linaro.org wrote:
> On 07/04/2025 14:05, Jorge Ramirez-Ortiz wrote:
> > Add support for the resource power manager clocks over SMD/GLINK to be
> > stubbed.
> > 
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> > ---
> >   drivers/clk/clk-stub.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
> > index 5fbbb07b7f7..09be2946bbc 100644
> > --- a/drivers/clk/clk-stub.c
> > +++ b/drivers/clk/clk-stub.c
> > @@ -15,6 +15,7 @@ static const struct udevice_id nop_parent_ids[] = {
> >   	{ .compatible = "qcom,rpm-proc" },
> >   	{ .compatible = "qcom,glink-rpm" },
> >   	{ .compatible = "qcom,rpm-sm6115" },
> > +	{ .compatible = "qcom,glink-smd-rpm" },
> 
> You can delete qcom,rpm-sm6115 if you add qcom,glink-smd-rpm

ok - I wasnt sure if you wanted that as part of a separate commit.

> 
> >   	{ }
> >   };
> 
