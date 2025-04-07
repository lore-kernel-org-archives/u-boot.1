Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1E2C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 09:53:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E86782D06;
	Mon,  7 Apr 2025 11:53:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MjsJ5pYj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9EB582D0C; Mon,  7 Apr 2025 11:53:00 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CF8782CFD
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 11:52:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378drdJ016213
 for <u-boot@lists.denx.de>; Mon, 7 Apr 2025 09:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=bD+hAivna/wrOFtHnOCOVQlo
 UmhBpGAkO7aKd3PyJfU=; b=MjsJ5pYjSHWVHf9gKmp398wuaUkVX782hvcv44Xo
 tVtFwrRNHQTizJn+Z5H4wuMOjxYkrk1bwnq3GcR+SBQDv/YqsQ1jruhvEvOC5TxX
 98+pPg+3dWrl1xwjojF4TZ4Iqta+zDBPPs51r3hJ0stUKjUOTyRZhbbbF4ytgGqY
 ytsivKsMTkZRpHu8InXlHvmYFtixYuudnASNqpnV5F0r5O2FgZSmZMLD6eHauasF
 cmcb/BrarsBUNOmcnUMcLQOhsMdQrO9AFvCYqNjl98z2P2LQHnC3kmOTo9amtFvA
 JFa+OX4D2nOMJc0KYRXjuUFtELeUI+OEG5Anw/ADqyETig==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twdgbu5v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 09:52:56 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7c5b9333642so424843685a.3
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 02:52:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744019576; x=1744624376;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bD+hAivna/wrOFtHnOCOVQloUmhBpGAkO7aKd3PyJfU=;
 b=hq6BeJ2FE6s6rmnkV+UCDlcoiMDysCD1Z8tFWf2Vz0za/HZIAwcpN2GguF2qv8ajXv
 +15EJK7hP/GVnuodjOCxKMl6noKp1XQndWW8RTLfT5XAVsm5ckKaztXiP6fcDP0TeuuB
 QT7GR59lJ9cf2q7l+ZbLTN2FI26ncd28h9igNtgk44OU2KJA7t1fqDT7zGJKu1RRcxRr
 bWykrnsK6hiMn1yL1glmsmsBDx2wNp5Z821XzNKiGcAzptPHsZLPIViswOptpGGFxblw
 etLi6ZzXXJqeIR1aJRN2OQSUfOSZR6e/ApoO/mgxth488s63Q2+w9ObV1XBiSryzsOug
 ye/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7pGB1eFlOUft310vu2dK4a5vIa0hSCX1jE0CNu8dpjI383gasEMSlQCnGjBmPc7D3EKqT7a8=@lists.denx.de
X-Gm-Message-State: AOJu0YzQguzKYM4mzYEk6iu5MUJ8KCOSr42NoV7ucGdJG/5Q5Sl9Hk9F
 1jlUOxcvFss8odHspGHN+O1icVz3B33e0gj5ZvFp3/uaijpcggEFGwjvr+lPCL4alK9vqo8yxOT
 uwGYfKR2e8Yhlt7cO/V9PfZPInCEIR5/1hMVHg9BaiCBwA+5RLMjG
X-Gm-Gg: ASbGncsfG2GQuKOEMSlUbprvbjl+/ALj8kE4169/IpxgPnzav95Ty2jMvQlSPYFUwEt
 h2PTa77tqsfb4qDx03I1HYHJaPibRbuyQxceiQgLWWWtFLun9ub20Kw1lLLdhBevy/ZX805xXkp
 F3gv+fi6Wne+hk/Hi/8Vjc8/KDFVFcka2lzkRaQIzRE48gqvXYcTCV6/MIIpsbfTzllWvPnS4kG
 RJp/FTuu7ytOSBp/7Ltsg+bDAZ58nN6jnY5Vphv/gv4hY3m2oheT6Y3fQ7v9acnzTpfO7mHrtF6
 XK39zXj6L9t+ZppQrql383uFntzmf+WFA9SZZ7pg6qDZEt5svYY=
X-Received: by 2002:a05:620a:4612:b0:7c5:460d:45de with SMTP id
 af79cd13be357-7c7759e9d77mr1877555185a.8.1744019576050; 
 Mon, 07 Apr 2025 02:52:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHP59BkDwdr0oAUlCkC/aBXICCeLDEJzivM4QRtQVVRvIDqczO4J5+r6/TL7AcO3hL4oJD/oA==
X-Received: by 2002:a05:620a:4612:b0:7c5:460d:45de with SMTP id
 af79cd13be357-7c7759e9d77mr1877553685a.8.1744019575714; 
 Mon, 07 Apr 2025 02:52:55 -0700 (PDT)
Received: from trex (233.red-79-144-185.dynamicip.rima-tde.net.
 [79.144.185.233]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3009644dsm11380555f8f.6.2025.04.07.02.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 02:52:55 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Mon, 7 Apr 2025 11:52:54 +0200
To: neil.armstrong@linaro.org
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 caleb.connolly@linaro.org, sumit.garg@kernel.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH 6/7] mach-snapdragon: board interface to enforce fdt
Message-ID: <Z/Ogdhdy1NPmQdt/@trex>
References: <20250407081927.138915-1-jorge.ramirez@oss.qualcomm.com>
 <20250407081927.138915-7-jorge.ramirez@oss.qualcomm.com>
 <9b6d42e1-1582-4250-8325-641f29d2030b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b6d42e1-1582-4250-8325-641f29d2030b@linaro.org>
X-Authority-Analysis: v=2.4 cv=PJgP+eqC c=1 sm=1 tr=0 ts=67f3a078 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=9rMOtB7ueBl8bWGkC6audQ==:17
 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=ObC7mlpb7g8vBSQL3FIA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: QIqJJpvqu2LsF48_RiM8YUTPKO_IY0oj
X-Proofpoint-GUID: QIqJJpvqu2LsF48_RiM8YUTPKO_IY0oj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_03,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070070
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

On 07/04/25 11:04:30, neil.armstrong@linaro.org wrote:
> Hi,
> 
> On 07/04/2025 10:19, Jorge Ramirez-Ortiz wrote:
> > Some platforms might require the external fdt to boot.
> 
> Why ? we may want to build the fdt in, and discard the external fdt for some reasons.

on the db820c, the device tree that u-boot builds is passed to the LK
appendeded with the image via fastboot: the LK, processes it, ammends
the device tree and then hands it back to u-boot.

see the boot trace:

[2830] Only one appended non-skales DTB, select it.                                                                                                                                        
[2850] cmdline:  androidboot.bootdevice=624000.ufshc androidboot.verifiedbootstate=orange androidboot.veritymode=enforcing androidboot.serialno=2f490ecf androidboot.baseband=apq mdss_mdp0
[2860] Updating device tree: start                                                                                                                                                         
[2860] Updating device tree: done                                                                                                                                                          
[2870] Return value from recv_data: 14                                                                                                                                                     
[2880] RPM GLINK UnInit                                                                                                                                                                    
[2880] Qseecom De-Init Done in Appsbl                                                                                                                                                      
[2880] booting linux @ 0x80080000, ramdisk @ 0x82200000 (0), tags/device tree @ 0x82000000                                                                                                 
[2890] Jumping to kernel via monitor                                                                                                                                                       
                                                                                                                                                                                           
                                                                                                                                                                                           
U-Boot 2025.04-rc5-00022-gccd064439bc2 (Apr 07 2025 - 10:06:51 +0200)                                                                                                                      
Qualcomm-DragonBoard 820C                                                                                                                                                                  
                              

It is this external fdt that we need; so I thought allowing the board to
request the external fdt explicitily might make sense.

if you have some other idea/suggestion, please let me know, happy to abide.

> 
> > 
> > This change provides a mechanism to the board initializaion code to make
> > the requet explicit.
> > 
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> > ---
> >   arch/arm/mach-snapdragon/board.c | 13 +++++++++++++
> >   1 file changed, 13 insertions(+)
> > 
> > diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> > index 2ef936aab75..1bca9dce20f 100644
> > --- a/arch/arm/mach-snapdragon/board.c
> > +++ b/arch/arm/mach-snapdragon/board.c
> > @@ -150,7 +150,13 @@ static void show_psci_version(void)
> >   /* We support booting U-Boot with an internal DT when running as a first-stage bootloader
> >    * or for supporting quirky devices where it's easier to leave the downstream DT in place
> >    * to improve ABL compatibility. Otherwise, we use the DT provided by ABL.
> > + *
> > + * Alternatively the board can enforce the external fdt.
> >    */
> > +bool __weak qcom_board_fdt_external(void)
> > +{
> > +	return false;
> > +}
> >   int board_fdt_blob_setup(void **fdtp)
> >   {
> >   	struct fdt_header *fdt;
> > @@ -161,6 +167,12 @@ int board_fdt_blob_setup(void **fdtp)
> >   	external_valid = fdt && !fdt_check_header(fdt);
> >   	internal_valid = !fdt_check_header(*fdtp);
> > +	if (qcom_board_fdt_external() && external_valid) {
> > +		debug("Using external FDT\n");
> > +		*fdtp = fdt;
> > +		goto out;
> > +	}
> > +
> >   	/*
> >   	 * There is no point returning an error here, U-Boot can't do anything useful in this situation.
> >   	 * Bail out while we can still print a useful error message.
> > @@ -178,6 +190,7 @@ int board_fdt_blob_setup(void **fdtp)
> >   		*fdtp = fdt;
> >   	}
> > +out:
> >   	/*
> >   	 * Parse the /memory node while we're here,
> >   	 * this makes it easy to do other things early.
> 
