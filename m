Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A61DC44512
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 04:57:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FD3B838D7;
	Sun, 19 Jul 2026 06:57:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fsuTWpAp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UUw2HjCb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29C5384119; Sun, 19 Jul 2026 06:57:37 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D61880517
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 06:57:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rahul.pathak@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66J4knxu2858933
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 04:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=M336mbP7ZR/JwlWL6SR5CNZr
 SjUSfIFKOencL04AaaM=; b=fsuTWpApbI7awIBcezGE1mwNA1Olbl4N0QxshOVd
 rBkMuXN7j1Gj3ARu4gIWixu7AcLtRC8O7tdf946PvEMynBAJc7c+W7gAQJB4XD07
 0lZN6qX99rxr+YAk74Nd2JZhTCvW5CLT3FamtLPE4tuw8CbLKQE6V2U93dwYXpO+
 w4UKbNNoKb+xHHhTC/43zekx4RnJMgPrstdMwj9jji8y55Of1m9OQX9QlirOOYLs
 r2KPikxwHAeDAf7tikE4wIUysh7ovfg8ttty0ta30fncZe3r47sCmG0+9zJ2X1bL
 tARmfH2IA14qr0amrddomAtwK+r6pJJ95pUarKL5Od3Y2A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2d9241n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 04:57:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92ef13b61bcso1471969885a.1
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 21:57:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784437051; cv=none;
 d=google.com; s=arc-20260327;
 b=jxL25RqKiRGk8MzuSC2RO49684XEQdCk9CgAg/o4Ff8O0jndIUsUgrLtmh9qsOYs/d
 liNKbCH3qYP9qGIwg9MdVn1j+iuyeAy6RL3PVTCUgo4hTdakNol/LLVbCsJjnM7h3agR
 OSAei/5oS3AUJSfV1pPXhT6syujugLvbR6r/LU31UBwPfPdBQqVK9kRTuUb2EI5hr53n
 VQWElMNXfkZr86Md5BBjzOSBgYH269KfTMgsleo6+TfFU9s0onfKoRPSgpZCYZKziS2V
 cVuRtjBEPvEqDFPiR52HrtAYKKS4KtoKRYeU17Brfj/aOPLZKE7WBja3ba2hV7vuV2gr
 SkFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=M336mbP7ZR/JwlWL6SR5CNZrSjUSfIFKOencL04AaaM=;
 fh=lKF8suJlCFCP9fZ6gCQfGg3jHgNxOnuuzuUhGi7d6ow=;
 b=P3mCC6hOeHA6o3LUYB6IiXkwWFnRU8fcjq26yXGA7GUsq3GH4lgG//whvL8/u2ha4J
 0EDsMqQf74TL+aBhyjqQ7OYoNY3hdhflvfLEbtofl/UmWTqcO+ahZuphYuarhT3V0WFY
 /H0+jEpm1iMPhUFyqeL66/376/pa0k6bsP+FIQIJM9edYm2wDcyTXv17FkhW6xTHw65W
 b2Xpa3y5Doj2QA1eBx5kD74y9VGxopS9OD463hhECrt3AI5NcwYaPvcsmUKTIIB9uSCp
 ECblwDxspH4VDHtm5LaxHXHejr289BRr89TfNe1+2s5wUhGNVHxs/BwZCOPXR2FhjBBO
 GPgA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784437051; x=1785041851; darn=lists.denx.de; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=M336mbP7ZR/JwlWL6SR5CNZrSjUSfIFKOencL04AaaM=;
 b=UUw2HjCbe/6VoN1wOSiPHj80JEQv5FltRUFSkDm8nip+nSxVnVxLiIR8816u/UTjgx
 X+QoqSEEIo1jzL46Sq0fyWLG6PiDCBpIYtmmPzTRQCD/0jinvU5yvniuIukmb2ZTSv2l
 tlSGYrcxUf5wtiyV0v+9i/VPkAJkJ9+SAxKy/BtuJ0O5tG1Rw3dkvoGtzDVbYgkEYHL0
 itT0PpMvAv0JsJWTPf94t7HQksDgUG7X04szW5jbhuI+FRW1swDSNyuF6bQVhmXaRzJ/
 eZdj3TAqFS0yHU7s2sODHoXmAmnro4/5Ikc93SxbTGqXBTbjzt3Z3HFeR7zBRoxxmgjQ
 l7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784437051; x=1785041851;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=M336mbP7ZR/JwlWL6SR5CNZrSjUSfIFKOencL04AaaM=;
 b=h68IeRU0d6TtYuiZnHjHekO2guz8LjoDrG9f9leOkpRKvo7gM5OGqoZB2LEPkXIEOQ
 RvlEUHyjeZICaqgnlwtyzgG6tPQqrejlPfeQXNJ/wLGSB1nXJeFMLiSGu+vghHtUJcgO
 g9Yf2Alu9VTSSZU1zNCyiJJ7XDlR35p7qlfFyHcyWcOiYPV2H2u5CUYo/ixGNUIJefAx
 zE8mJzSNcRVHsM4Ev9+YcYVL3rpd+LdYV7mqwIE9YZ/OmnFiwssz+LuG4/LHFJ8qyoIi
 5Z8WNBJndbXLJLXoQNZAxKDSZpCv5/dzbMMTi8bolEXVIuNJZ/9I13cG2HkRtoHSp+Tm
 dvfg==
X-Gm-Message-State: AOJu0YwLHP795/x0xZyGJsRa44xZ1ytWEqwQog/h3wIY3goT4POemvvn
 WYzMn1qU0l/1HfnLTiV/eLxV4aLSp4tYpJj62wdPbb/prKtPhYTk9x8aWCNoycFy9sHDmTaabJA
 REaBFqy2EugoofYzwJxXn2hb3psbtdnuySsdLa8CbeRVkJub0pj+aF9wndtJluaQkJrUK8X2nAZ
 6+T1XGRkoalsSP2sZJFwDt6eFagCibbfo=
X-Gm-Gg: AfdE7clML3PjAwd4eZbUtZc6/Vnu1ZqRc3FAo3o/1wzAe6QNMspj2Ogmo5qNVJI2drV
 Tc6hPVQxPn4VltHP4cgRj0R+11wzOm7OCV2u4FZCoRFB2pYbkuvAiAmlkhzV95+VPSqpcti2hs8
 LPhdHKxrMB4fFxtd/MKb3TtHc0FnMQCpKkFpIyB7tX2RG3BPhL9FCZoPDo5g==
X-Received: by 2002:a05:620a:460f:b0:92e:46cd:72a1 with SMTP id
 af79cd13be357-930b3eea386mr940487085a.5.1784437051329; 
 Sat, 18 Jul 2026 21:57:31 -0700 (PDT)
X-Received: by 2002:a05:620a:460f:b0:92e:46cd:72a1 with SMTP id
 af79cd13be357-930b3eea386mr940486685a.5.1784437050906; Sat, 18 Jul 2026
 21:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260709175605.1070755-1-rahul.pathak@oss.qualcomm.com>
 <alZvl61jiQ0Wlvl2@bby-cbu-swbuild03.eng.microchip.com>
 <CAFR3w36bcmGtSMLwt2NBKh7OQ_AW_7dPJfYrqc0=KpGC6LwnUg@mail.gmail.com>
 <alj2IeRu5emA2amQ@bby-cbu-swbuild03.eng.microchip.com>
In-Reply-To: <alj2IeRu5emA2amQ@bby-cbu-swbuild03.eng.microchip.com>
From: Rahul Pathak <rahul.pathak@oss.qualcomm.com>
Date: Sun, 19 Jul 2026 10:27:19 +0530
X-Gm-Features: AUfX_mwRcSJ_y5lbqtPwyNg1C8sQEHu-L9U4687uRbbRbLkddRbbIAQAw4NuW-0
Message-ID: <CAFR3w35pn9HkFUYjTygRx1KEB-JArYFuKRMQWdjw8=F8QzzZqQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] riscv: Add generic SBI MPXY interface and MPXY command
To: Charles Perry <charles.perry@microchip.com>
Cc: u-boot@lists.denx.de, anup.patel@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=HpxG3UTS c=1 sm=1 tr=0 ts=6a5c593c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=XYAwZIGsAAAA:8
 a=rYGKK8fkLdGxlxCOeYkA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-GUID: xVTfWXynkGgle5HKI5_wGQOj1XkB3B6x
X-Proofpoint-ORIG-GUID: xVTfWXynkGgle5HKI5_wGQOj1XkB3B6x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDA0OSBTYWx0ZWRfX+KDvazUjvRDW
 Lru3/0tPg7UHJ/NWkBdw4tImbjWmuerrSowDjYD6Ta0jcnobdOn9z8Ojx/9/O6tcvHymo7P4ETR
 rmYE5eDXWY+yLwjdj6ol9FTE5h0wIMioB/zH9nc8kSVE/EsRUK8Y7VUD1+qfZKCx8EtYZ9TB+yb
 i8RlZcFHHoS4qLFpQkPEy+sz5UvqN9VOfq5cql7Y0Ic0/cUSAmxIIha3f8LJVwt2L+1rtSp2vK3
 D6MgMV+Ng3Is92mFr+Igzqn19lflTJ0SboKkXzkA1g7EBk1KyR8tTT2YYTN0S8xRKSqFTyA76ul
 9cJrm7DgjgRDW93Yhl8DJYJLsTCDi/i3z5/SLNizSA7r79n8ga2M6mau1kqQBE6KiFQdntef+qP
 EPO7YTEN3UW5KYYjBmI6fd22zAL7JNKNEomWwkZh6k/TcUK5j3yAXVYZso+mwOTzTUFiiY5hetL
 rAqMTb0s4cXpE4FKYTA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDA0OSBTYWx0ZWRfXxMgaUq1nl6qt
 qWBng9QX3Qpt5r4PVDLWLfgw4koL6RoG8NXtYI+MHkBDF9QpZABaEEw9vb/wxp5bqA5lbufmiDF
 n5di/6VE6AhRbM/SjN+Vg2InUxftgg0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190049
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

Hi Charles,

> >
> > Boot time tweaking of any attribute or any platform state changes via
> > scripts is also possible as you mentioned. The configuration can be
> > board specific and expressed in uboot environment scripts instead of
> > compiled in driver code.
>
> Most people will want the later, i.e. compiled code.

It's an assumption and we should not assume what people will want.
That's the thing with infra related support which can be used
to cater in many forms.

>
> That doesn't mean you need to modify all the drivers being used on your
> machine because U-Boot already has an abstraction layers for clocks,
> power-domains, resets, and other which are relevant to RPMI.
>
> If you make a driver that implements the clock, power-domain, etc. API and
> implement it so that it delegates to RPMI, you can leverage the existing
> drivers and you don't have to add "mpxy" commands to your bootscript. Need
> to use the network? you call "tftpboot" which calls your network device
> driver which calls your clock driver which calls your RPMI driver. Need to
> use the NOR? you call "mtd" and the same magic happens.
>
> I posted an implementation of this, please have a look at it:
>
> https://lore.kernel.org/all/20260708215200.1331416-1-charles.perry@microchip.com/
>
> If you want, we can combine our two patchsets into something that takes
> the best of both.

I have no problem with that.

>
> I can take your patch that adds the "mpxy" command and add it to my
> patchset with a few adjustments.

Sure

>
> Thanks,
> Charles
