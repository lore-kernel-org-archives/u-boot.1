Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E441606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 21:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dZPhXcrW;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DoapLDBd;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VRN2wgSh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2562B608AA;
	Thu, 22 Oct 2026 21:34:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OBHN9ueZpXiX; Thu, 22 Oct 2026 21:34:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 83E3F608C4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792704848;
	b=BXr/D9RIiBRQqfnY0fw3mEv/v+nPcBnypq6rjK3W3bzXKahLS6++sUaDmAZWjAgL8wlt
	 ozvH0fGMEziQSagPYmiVkbKD4DYJX1l0/aGi5KoL7CmgH0uViiWMoXlh636M8NQIl6uvY
	 FZ9OeYr17RqRspm+pK4G+XVKKd3dam6u++LF9dBj5vksFJny19A6PtnR8mpb0A+WzwFEK
	 YjCGvzel4e9iSjO+jDMUVl+rv30Zn6HVKsxXvwu/tadxGW3B3lB7xuKMPhliKLCqucFEV
	 hunTp/Bk55M8RzJ9mK7Iq9Tbk15Sg20E2O3lljF35MBMOdSXkVZChkjlzVRMAV4cGFA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792704848;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Xjrj5bQ9YORP1jRKFl9IlexiCkcSL5X3boLW59dQLzc=;
	b=ESPAyH4AlAHIYUZjcVhtYr/sUVGHF0wDnv7q396Ti5y/IYaAY/NJOnco809/c0k7q/0j
	 OurAg4W0ymJe29iczlLdjv4luyEF3BUoYtzSndYG5CdRaMVDbCAKUFxblA++lFianZFU5
	 MO/JDktL6sQ3FIxIIi/qKEOKDXb/Gk/DNOV8bMl7ba15VIHERgqjvQhbn06GSOREuub/2
	 Ofkk5hae2TZc+o0q/ra9nvRn+kjsnsEtzx5wd8vW9G4qOJJbziQLjx56pO7u8ZrfDPMHU
	 ISLnzlE04VUwJmNx9AKRIkU7pwucfhBkfPC/K4/c7vMwUsbDxcjCem1dhYiK7tdBmMg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792704848;
	bh=Xjrj5bQ9YORP1jRKFl9IlexiCkcSL5X3boLW59dQLzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dZPhXcrW0mwqXANFt+f6zlhiYBjpINFDyqdxgtn7GZqwdheat2bV3X5HFIHlr1yJo
	 EPMjpUSyf7wWWOJv4+vix+SdUnH4ODoBi30wYeltgT79i3G8ov98UHcfTJUz+otbUU
	 akmq1hUp79zmOYZ9bObHy9/0IAZT2K1R4uZ7B20TlA7IslCPmONPzc94MATzL+7L1N
	 +43Q+ke4bCOzC5A8vtGz0LIOz22623sGrQ7dQc7ycd9pTXBsNsJRizbATvvo8QUmqx
	 3+sLvXKOtO0FaWDERMsozfnkYpTUnW98BPVbE+1UmwPV7km0rmTEbVP07M3Rv3R6Jr
	 YDIazv1LKHunQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 83E3F608C4;
	Thu, 22 Oct 2026 21:34:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B7AD4BC
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6EB454057B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c-BmkmRfgs_1 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 21:34:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B8A1F40552
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792704845;
 b=iMSk/TA48RURPNMrxs2wdljhQPlgTPJa6XlwSzMU4Aude35i22vCCmy7fzqYYEPcTn7H
 ZkECqOxSjORSLGPPyr/7vpm+Oh/dHU/wYSo8+gupDIqZkglhUha+jG95Lw8vV6M9Y+tS7
 zXMiojIyPYJ71LbLwkXpij/Y6Fbet/nC9jO5N+cNrSTN7fjy069JS3L3OR+BTR1P71idZ
 LHewvOKEivnw4IcYjUfRG1Xl4M27fwvSyWlhRnVE8o9Lw2q06rY91n6m7+w7C0eG+TKsn
 b0nr8FKqD5slrLhd/nQExr/qSZb02G75pvXAfuQO9Eh2nn+bnrsiKzl+sJpUBQRaXKA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792704845;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=Xjrj5bQ9YORP1jRKFl9IlexiCkcSL5X3boLW59dQLzc=;
 b=KVfUiQYOh/lTwCUiLbptS4vGFsiF00PBGQ2o2yFYrlzaZsFj53sjkHdHYtPtQQyqZPN6
 LHnx5feKSWhcg6nfCGu6a2D/emiRzq81Ia3RbCcsLOLq3SuJWlWk7ZBqGjWyWwgmgnZre
 KiigNSG8+ZCf4rHpsa2lehnf6BuXReynm18ZyRi3Tyi/OLvSdaS6uKg2Ju700LHDE9Heb
 xx+e2wsM3JH2klAbV4SWwbG4O0pWduxJwiRzbGfx4Dst/FRH0ElkQdAaw7z5vIwEGX0sK
 1eMYl8BtCOVVu1nMrYlid8sP9nlenIf5hYH+BPdbn9HNyhx13TJEuQG23VCiqowrYQA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=DoapLDBd; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VRN2wgSh; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=DoapLDBd; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VRN2wgSh
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B8A1F40552
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:04 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIIFkl1512548
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Xjrj5bQ9YORP1jRKFl9IlexiCkcSL5X3boLW59dQLzc=; b=DoapLDBdmBwh2jL1
 vcYRZumIuCW6+2F3p/7kfgPFMhb3+dqShmP08AWhtPs8jB7VyVCtgdsaJJDKVFYN
 Q2S76UjTN7Du7PQl//11y/g7kt7aO3A9dhuoZHwdvqyC8Gn6aC+4yCkUoP0BHejx
 /u65jqZo+vzY2mTEb6+jgQCg53LkmutC9r0aJrA8wmeXU46G7hO6nxMk7QuvhryE
 56mxKrgCI2v+eJLUanZDkJPe9lqrqJsnFbJN+tCCcXRyqhXxev4ajiLOhkqBFacD
 sTndM1KhbnN2ljoazikXAQAcsrrLFTynGCZClZBPupuFiUGQ2caFcPDdSWn7uaKZ
 NoFNuA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmp8nrx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:04 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-8b118a963b4so12828457b3.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792704843; x=1793309643;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Xjrj5bQ9YORP1jRKFl9IlexiCkcSL5X3boLW59dQLzc=;
 b=VRN2wgShvDWCCU3eKQh2BqVohK3CKdx/4lqqNd+etGrL532f/XxbRQe7LyFf08SXc3
 NJcHTxm2vvDL0KVJFrlISBgd+i2IcGIesFp2YytFUz0aCFxjno5MXjG4KZvKupvUE+dn
 vAGnzBrCqlx45t0r6R/LH1AzR0J/FiejHV/KCS0NfKark5FS0wabKBKoq6LmiEFoGTqm
 oa+1Iq2uagTj5lQSJCCzR+ASNiCGsbBeiTIl7gjoie818W89P+98Z1CCnuSE3ogq3dPV
 W1tcvHhhz1/m2ViDcht/T2bSkg6yVVBfmkFnJtjLs0HnLXvuPCPpQgB3a7OzmXRqKMeL
 0wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792704843; x=1793309643;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xjrj5bQ9YORP1jRKFl9IlexiCkcSL5X3boLW59dQLzc=;
 b=w6YNOEfNTK0lNWOL7YMb3m1xjDO5LVnYU0LPCGJjkBIBFtEwkKXxCqkKGCUXgxp1IZ
 2pClMZRTW74/ZYP1F7BcwYmKf2epd8eRnU1wIIrS/do1Vc1rdlkvHudUmi9ZgdO10D1e
 rjJvDqT+lWQmSqNffBqGPTkQouXW+4E9Sjt3y2qBHBcpJgpoVBZdUdhKVWhyvx6BAZiK
 Ygeuuolg5ga9j0gPG9boS8oNZvGRgYxq3PkHmBqRRumlq8rlnBzH5qHZdqsF4lmOWCDt
 RIVw+7RHcWmQ92zX0t+xP6OIriwkDVt56FM/BKstoqKZFdBWRZ7CeAZ53W1L3vexrQ12
 aAOA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwCSLks32r3HiJIg5NPxGHGsagPUqmxxUaRhpFOnPhoEXY7elwmEzumh2Es/HUJrov3eT5uR+o=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLS6gvHjAPq74r6PeYjfjiWQiCHvwuJwFw1jJv5qQNPySu3f/hS
 JuWLJqGyTikgOgvkhM4JNz7f8vbPpWkHVh2ocy0hYXXOvXkGKtlnxCywWDOAr0GzH59nxz7NI8S
 CI27yCscG/hgcls5LFKbLByRnPfkyWfvccpuRZ2/q/dJdpRu+i3R0XJsrmsb9zy9DOP8sWYY=
X-Gm-Gg: AYBFou3KvqkT/paZvf6VE45FMsTksbMXIMovOE8p4KqfYeCHdQe/A/4rxJmsURmBOhC
 u3Sn1dNXop2VEQrU599MN1dowsjrEixU5OIwaq6BnmxYzn8PiCR69+FPu8VeS7Y1zrkmXaA/pCW
 qdClR81CM2xCl/gGgUlOEZKFwJSwngGQubGnja8IvrXen42tGuxbHSiU9Txs5qxXxUloR/dZyWa
 nrPZ/eQ4SaqRLjAKztvOsjHi4M531aFO3MoEqxZZNuoOsS99M6Rm4vCdvLHv8yqFLvv74oGybfE
 IJkrgy8R675O8MERMPd/86cscMocc+Iz4xlw//yyYBn4tZHbxLdZyElhckOdMaYHWW7EkvfJRMM
 TTLHWBdiFLhXQ6jcYq3+eu8hgoSq5rmKCkq3Lw1FggUqYZbT7qxYnaCRdfACp
X-Received: by 2002:a05:690e:118d:b0:679:97d1:439e with SMTP id
 956f58d0204a3-67a35a6c199mr219153d50.2.1792704843457; 
 Thu, 22 Oct 2026 14:34:03 -0700 (PDT)
X-Received: by 2002:a05:690e:118d:b0:679:97d1:439e with SMTP id
 956f58d0204a3-67a35a6c199mr219143d50.2.1792704843050; 
 Thu, 22 Oct 2026 14:34:03 -0700 (PDT)
Received: from x2e.lan (108-208-224-205.lightspeed.gnbonc.sbcglobal.net.
 [108.208.224.205]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67a3404f69bsm350509d50.21.2026.10.22.14.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:34:02 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, Michael.Srba@seznam.cz,
 nathbappai@gmail.com, nikroks@mainlining.org, luca.weiss@fairphone.com,
 jbx6244@gmail.com, u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 1/8] clk: qcom: add GCC driver for nord
Date: Thu, 22 Oct 2026 17:33:59 -0400
Message-ID: <20261022213359.765731-1-tyler.baker@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021160448.3893858-2-aswin.murugan@oss.qualcomm.com>
References: <20261021160448.3893858-1-aswin.murugan@oss.qualcomm.com>
 <20261021160448.3893858-2-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NSBTYWx0ZWRfX9feTh0WZj0L+
 NhuFJQilWrrhXPvvnyS/71dCf0+fYfwJJUYIf+ZY7vuFWZuYkiSAQSlEhmA+vRf0Ga7w2RST4N4
 fxMP+0FCC593FpaquWLVRn7II6onC6g=
X-Proofpoint-GUID: SmOb1e_4B5kOG-QOhnVwicG7aGptNmej
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NSBTYWx0ZWRfX4gDOu214qA89
 CWlJ64ONyLbNq2twG+J/RCK3TKEa7E8NAZaKcbIvJHEWLs+Blih31IH+CCzF1qMxuqO2c/gURFS
 bkIiQsIxSraDKiH6zK7RRiAtpKJrR7fZjfzeFE/76O1i3KskJOl8ML2YTg4eY7QWPbc2XuB1J/L
 j4lgt9x78bLX2sg5f30OZL7zd2UD1JVLOsH+a/givAR1QENGHFT5eAr/JJ+BTn1GD8M20oVt+9C
 HpVrYF3l6LAXOGMHsiV4okT2AJQWsw7Uuk+SnLbmM0waEpxNb2qCCXdPm083X04bvZtcBavYqA8
 01I2D2mXBUw0/MztIc6b6NT42QIyWBfS9Z8QR9lIxNGf0mympGMFtez2/16MRY8uKWIeN6k4irb
 jP5pelXZTbaPNDSPpH9p1wXrtOuHAF5DQ3KttPNY8yKplRQZF8d7Pqv0nOW8GbSljAvC5rrpQs6
 aVnqNuvb+iKzX2ConwA==
X-Proofpoint-ORIG-GUID: SmOb1e_4B5kOG-QOhnVwicG7aGptNmej
X-Authority-Analysis: v=2.4 cv=BdBNQbt2 c=1 sm=1 tr=0 ts=6ada814c cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=sOnDfXEmMANyBQqeG2kA:9 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220085
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 21 Oct 2026 at 21:34, Aswin Murugan wrote:
[...]
> +	GATE_CLK(GCC_BOOT_ROM_AHB_CLK,          0x1f004, BIT(0)),

7 of these are CBCR-backed in Linux, use GATE_CLK_POLLED like the
recent sa8775p/sc7280/qcs615 conversions. With that:

Reviewed-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
