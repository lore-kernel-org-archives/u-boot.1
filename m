Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5239AC3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 12:58:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D53F782006;
	Thu,  3 Apr 2025 14:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yv3WnQLY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45FF082045; Thu,  3 Apr 2025 14:58:02 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC93D81F44
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 14:57:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5339sWll026731
 for <u-boot@lists.denx.de>; Thu, 3 Apr 2025 12:57:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=rmOYSJMQKdXEiJnnijgZGxcw
 vhCV1hPl7N6O3nCVkMI=; b=Yv3WnQLYhkE/JoX2tV4/yttvGbQF3on9F842vbw3
 hax5++PUS6urA+zLGyoWvTNXN5wkEWDDUwKh3xt4wfR4vI3tpvEK6HMzj2YZNjHJ
 0DwcVN5RaSIbz99iNRP8ErDb+RmxItf5EYE+yi9qSyNVDpOBSCD5B+bXhl8Br2U1
 shHMnLwwbUbo633azm/ruXhRBZxcwo4MdI7P0igr9ZyyCT05FhUVH9bMfVoAmUf+
 s808if7M7j0YB9xHePfvo6eDE5G+GJeoFJ4Mws1sziksSKL/HMY8iMSgx+Ksdl1K
 ZhA4k0zGyDd27MM2pV0NX5faWPzR3I2LhLWDRrPlKoM+hQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ruadw36d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 12:57:58 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7c549ea7166so129956285a.2
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 05:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743685076; x=1744289876;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rmOYSJMQKdXEiJnnijgZGxcwvhCV1hPl7N6O3nCVkMI=;
 b=hSsVadA/8Jrggj4K3XO2dMPdE2IFqNdoI9t0BL8qR2r2qexTsjLG9QvsxVrHXtArQI
 +LRokdi/amysuwWsWDFXVxZtir8BidyjqFpkRdCq5zCcwKR8m+LpIoLh3lvOyLvKX5/e
 Ka6QN214+jaWc+/jbGXCSq3PY0mnUaYYGTkBsDTlLHxiOOs8KDTgvDiEmY66XRzg8Hr6
 pqefpEWZoDqtxNOMUp5scxY7O8MU/sFnNdMv0HZw24STTQ7R5axF0OoOJo190+VYqCMQ
 UxxtODS62hRicSP2fnYMsCg8ZOeG1nyLb33BTI5ddLvtLMzUh5XjY/GtfRDa9a/8xnBa
 aQSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9RFB/uo4J4VMrdOxswXCHuE6HoH0rZ8j7eB3xPR9tLh4dhZRbDX9CvjAusiPrGyCcvoXtp9M=@lists.denx.de
X-Gm-Message-State: AOJu0YwQcmHAyzmgfxbEV/vM1j8Jwvy3wkCtpfAshfPWu8omGYLuchKz
 FGF8QcmYc6da5ZAdM34TMvOkBHLvuCZIcIViF4IGnvwL07/F3eXNVFNPR7z9DJ3efv3FttFiHxC
 HC2W6NIrsPBO7PQjBtOp/G0WvZg1hopli6peidnE8sepGuDW6fmjF
X-Gm-Gg: ASbGncu1CxC1H6eDrQKMAhAWdHcLsm+FoEZSVqUVwTQlKQqXxTJj59b0srqHaDRaz4Y
 z1NKYm6d/+gahAne/gP6PbOxa7ao1Djq3RtYlwWmLIOvoKkwO7qyvLQkx954soV+uHRPS2EULKb
 VZix9TJtVBSzgpDvf7iRg9EtFRR4n43QshMPw3/P8oD4VTffFheMGex20DlCKCoGGOkskg7HOjs
 PVho0Z2FDb8Sftbeo4AbaWLdpi70QVd48GojndMSR40AvUwohIsP4h6/0WANAblFzZ8tf30/dpx
 +VSAuXG7ajuxuDWsvLzHwnRu39ezwhFXJsmtsF/KW75rxyAuCCY=
X-Received: by 2002:a05:620a:288a:b0:7c5:4c49:7699 with SMTP id
 af79cd13be357-7c76f24c70emr228941885a.9.1743685076682; 
 Thu, 03 Apr 2025 05:57:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGs2OfyvGlf0qzUslw5O/FtnY5m3G2BOkFZJpOrcjSb+GvO84jmytNnAFRIVz4fjI4rBWJzw==
X-Received: by 2002:a05:620a:288a:b0:7c5:4c49:7699 with SMTP id
 af79cd13be357-7c76f24c70emr228938785a.9.1743685076324; 
 Thu, 03 Apr 2025 05:57:56 -0700 (PDT)
Received: from trex (233.red-79-144-185.dynamicip.rima-tde.net.
 [79.144.185.233]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a9bcfsm1771152f8f.33.2025.04.03.05.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 05:57:55 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Thu, 3 Apr 2025 14:57:51 +0200
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH] MAINTAINERS: board: qcom: db820c: update contact details
Message-ID: <Z+6Fz/xHTlvJwerA@trex>
References: <20250403094601.9207-1-jorge.ramirez@oss.qualcomm.com>
 <71822cca-35de-4097-b591-b098d77c40ba@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71822cca-35de-4097-b591-b098d77c40ba@linaro.org>
X-Authority-Analysis: v=2.4 cv=VI/dn8PX c=1 sm=1 tr=0 ts=67ee85d6 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=9rMOtB7ueBl8bWGkC6audQ==:17
 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=pGLkceISAAAA:8 a=DkJRj8jr1xbUH63__vEA:9
 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: QtOkiNB3AKC1LFYrkOw7fZ-yc8MqcdEK
X-Proofpoint-GUID: QtOkiNB3AKC1LFYrkOw7fZ-yc8MqcdEK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_05,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504030056
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

On 03/04/25 14:50:26, Caleb Connolly wrote:
> 
> 
> On 4/3/25 11:46, Jorge Ramirez-Ortiz wrote:
> > Update contact details
> > 
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> 
> Congrats!

thanks :) we got the oss identity recently so never had the chance to udpate.
> 
> Acked-by: Caleb Connolly <caleb.connolly@linaro.org>
> 
> Will you be giving this board some love? Unfortunately I don't have to test
> so it's not yet making use of the fancier generic support parts in
> mach-snapdragon.

sure I have one around, will give it a go.

> 
> Kind regards,
> > ---
> >   board/qualcomm/dragonboard820c/MAINTAINERS | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/board/qualcomm/dragonboard820c/MAINTAINERS b/board/qualcomm/dragonboard820c/MAINTAINERS
> > index 7ef905bdf69..28741d98334 100644
> > --- a/board/qualcomm/dragonboard820c/MAINTAINERS
> > +++ b/board/qualcomm/dragonboard820c/MAINTAINERS
> > @@ -1,5 +1,5 @@
> >   DRAGONBOARD820C BOARD
> > -M:	Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
> > +M:	Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> >   S:	Maintained
> >   F:	board/qualcomm/dragonboard820c/
> >   F:	include/configs/dragonboard820c.h
> 
> -- 
> Caleb (they/them)
> 
