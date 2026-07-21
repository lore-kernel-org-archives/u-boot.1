Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27F3C4452B
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 06:08:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7320780E1F;
	Tue, 21 Jul 2026 06:08:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 78PdurhazoQg; Tue, 21 Jul 2026 06:08:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C447680E16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784614122;
	bh=6wYg+LnafSlHr3L1z+eA3GQBSoIU+0+M8bcgVSrfkWA=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=0F/C9ceF0NjMiwTBghdMib2DO7G10ts9FhJTA9gveYO8uT7jIQRmz1PIg/Byh5dhH
	 LNgQTmQTUBsvelK5Aqn4X8v7aqdOSe20JA7DlKi93c/Oq6byZBb8QoRjzMOP4lUwTp
	 VJqQkFrBNhw1MDJqyweOV7LguwQgD+VnjVpQVn4SKq2C5wgUy12B5pThvp3zhE3p+5
	 len5kc5YJus+8Eebsng4ppJUD9C5fXqp1H2chrKqT24A014HUvrws7hE9+/J9pjwA9
	 +3sonmoZwND5VO3uRTS7A0f0tTdZtDvCoW35Xy52U8TIlWNxlmFGV4QGSkfqDZVUyt
	 LO8jFg/9TD42w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C447680E16;
	Tue, 21 Jul 2026 06:08:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0DFCA9E5
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:08:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0B437407C1
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:08:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eA4w8Sq-41Vx for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 06:08:40 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A612B407A2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A612B407A2
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A612B407A2
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:08:39 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2E7F84659; Tue, 21 Jul 2026 08:08:37 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C31E803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 08:08:35 +0200 (CEST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KNCn4r046344
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 06:08:33 GMT
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqv5tkxt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 06:08:33 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cacf17c7e0so109098605ad.0
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 23:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784614113; x=1785218913;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6wYg+LnafSlHr3L1z+eA3GQBSoIU+0+M8bcgVSrfkWA=;
 b=Jzm2kWn6eoAjgOW6G1Z3XjPPmj9GZhyeBg/EizNwle4gf6MOrDewLenzGkVz7b31M6
 1U99uzqVx+dl0tEys7a1ZBJJbBST3ILy5WPQ926gGxmrW/aFys1UlBO+EFjaGD4KxfaZ
 W3sCMuQwrYvEY1kc5/4sJ/igYDiuhU0jg2m2QOn1loUSGftxw16OpCIXehSPGf+J1qqs
 CKAg9gwJ+NTRHsBm4fhWTficE2F87C9FEv9cLsSmqx1BlllmgG2fX1BTXhzLQEi8iqY/
 UxRoLjT2HtTGfYTDCv035FqDRqBda4np+wZQx/FZKyX/rMhHIR5QT9y1Q+DHuDOvh494
 9xxQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqr5F5ATrj0DM7/2Zm/6qHJb8NcqjyRXrrU+Bf2lAFCqr9rYmuum3eqlsqBa8rD2YMR0typziM=@lists.denx.de
X-Gm-Message-State: AOJu0YyJOyC6CqdFzaLXQ3zfSwN+t8HAbnH5JrZEHxld2K21sx4vW0qp
 yV0hOITxE7oudBnTiX8AVKqF+j7Gu3zsDpxICb+iVqXvqxx+lbEtNrBxSQ2f2ob6StKVFQu33vC
 qK+QNfaSOFHGZJqbXzDWaw7k+D/cDB2onXuKGNajZZoXuyD1LWHwuLucH
X-Gm-Gg: AR+sD12bBOGR0OGalhcD62GKSOzgIf5LUpTXzrpqi1R4kNLnRAe0li7w8S/r5PZQt1B
 3/QvOsAwl5Q1chdjTwCME7cgG/cA8SezV5uM9VqE+tMYyJ6pODVRBt03KUjOzP5I9xrNdZuhxZk
 Un9cqcgiDdJ8U6faBxtPPUexxFmPeSztIO9XjetPA8R8eVjTnllhD5rviwfZKud254OjYtqJqn2
 5uXg5mzPydk4nUnK+1UNEC2E7qfZ5tA1aKfB/uRD17NUbBoOc/4z6pumXq6bpmUhvS7cIG3DbrT
 0CkMiICH/jNNOl5lXmcUgl8WScIT8PMnpXd1SQy5uYQP+TiX6lHpD6RxQ0hPS5aDvr46rPYQfJa
 eELgm5KyrsZkdMvL6Q8T7fM3pH/EvR6xDDEuMGGR4aNhyMNSfp1tSgo62gPakbXQ07om/xUnDPx
 z4J3Oi2PczFcippNjJsOiBBfM/P+H35w==
X-Received: by 2002:a17:903:2acc:b0:2cf:7ffb:82aa with SMTP id
 d9443c01a7336-2cf7ffb8d74mr25776035ad.45.1784614112628; 
 Mon, 20 Jul 2026 23:08:32 -0700 (PDT)
X-Received: by 2002:a17:903:2acc:b0:2cf:7ffb:82aa with SMTP id
 d9443c01a7336-2cf7ffb8d74mr25775645ad.45.1784614112079; 
 Mon, 20 Jul 2026 23:08:32 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1bb8a4sm46842979eec.14.2026.07.20.23.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 23:08:31 -0700 (PDT)
Date: Tue, 21 Jul 2026 11:38:26 +0530
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 2/3] tools: qcom: mkmbn: Add support for ipq5210
Message-ID: <al8M2i+p+arHVbK4@hu-varada-blr.qualcomm.com>
References: <20260714-ipq5210-v1-0-0b98251aabbd@oss.qualcomm.com>
 <20260714-ipq5210-v1-2-0b98251aabbd@oss.qualcomm.com>
 <83cb6bab-ca75-4c26-8363-19c40ce8da21@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83cb6bab-ca75-4c26-8363-19c40ce8da21@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA2MiBTYWx0ZWRfX9dV4KyrKkOoO
 B0AIGxZDV1BPyH7ME8TREAQRSXRivuOmIlfLpJe/yIvaocATP3YZYblG2K740V7Ouap1bP5HNnW
 vU342IHzEwBVBcFfgvaF79UuU4rWYE3ieEqC0UX1Cr6/OyhS+7Ku5GaUBalTNJdimfMAi7GuOxB
 zmCzhse1UdBlVx51GYrL/4PCZPg1pktUSqrX6i5eNooamcjqevZyJP4TXEtKDSKPlSq7qutybVV
 5Yxrq3JlgmaG5e1oIzZNgf6RFHm0IsB3YADfEMSHgXMy1VixKrjOEYMTn5vBRTJUsAAEkzwizeK
 iqcI8lwkQ77ssYk2OhrIiANpPlg4y1s0ptq3tkxYm+3WqwyH69THGeq8jF7q2O0UJKJqATgkIfB
 v7JLRL8w+YLJvH8itz0cbnVO04kLGFElMED6m9Cla+QJve0A5DjrT1SYvPIOe6yWeYShSJeP4Sw
 Qs5qZxF+PXZOshQasnw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA2MiBTYWx0ZWRfX00eO0hfp3FHb
 jPRRmOmGlgz9ad+os/cryPSHRgc9391bl8+qyNDJODxl0Xrrr4jYCIPBFNSPD/Ge3UUhBgnI01B
 s7Jks7lx2crkheeiffdiaslvRyQfyvA=
X-Authority-Analysis: v=2.4 cv=WNpPmHsR c=1 sm=1 tr=0 ts=6a5f0ce1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=omrdh7r7VwyEFzMp1CUA:9 a=CjuIK1q_8ugA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 98qykVJcjO4GbQX6g901lDREF_LEJTS3
X-Proofpoint-ORIG-GUID: 98qykVJcjO4GbQX6g901lDREF_LEJTS3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210062
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=6wYg+LnafSlHr3L1z+eA3GQB
 SoIU+0+M8bcgVSrfkWA=; b=koPp8xg/PR3Mj8TPtP1VFOJ8Yj8JyZxDqfHKTzVl
 UJMnlvMNdVAr4mMfKbHVZbOJ27pR50QAOmmMaPM1QSUnNp+7OnuCsAu/zZyu8PeW
 ZB+q9qJGce/MxmtB2z3Crd1mfpE2dBzJvIBMlDM1OEm5tR7KLVXmH4E3lZt90LMk
 ZpLTe3TtFF/EaqsIyxGb6RpObkp0rALfRXdtEVW/RZnGMUrS2eMvcJ/QZg3CjhEI
 I0fHTWqrZVvnhkhP2o8UQzJEub3b7JsCGHNmg0nqPT1CUpBhciqV+anxnQMjGAf6
 X3jGrFM7j6EgSBRptD+F0h/JeDUtWRUwrtzOON4+12ob6A==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784614113; x=1785218913; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6wYg+LnafSlHr3L1z+eA3GQBSoIU+0+M8bcgVSrfkWA=;
 b=e15OVtTjHExnICJR+oqyFNKk/Xzsyu3Lv1549f6VRiJVfP0XKEuyrbZ4EkJP3m8euN
 xeU+VT5tW9Ut/51vKXlzJPqpXk8tbNwMVY4BspxasvlSogBAZNrGarRC8yw2M0OfD1bR
 iN9H04PcKMOQz5oaZ0AqfczxdOlvRqXABxXo3t11wolWbKTa0XIj+skWZjpNrzP8cP8o
 IcM62ncStBUPYV49eexVGNLjoKGvzZa+pKwR6CV87AEGwDk3vv84uG4Uhu+PKM4dCB9Y
 wtSGBjEu5HQjkyqQsr8yV9k1K7aFowTuCFlwbY+ve50QNXfZNQueYIeEpha6s2dXPg+3
 rBUA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=koPp8xg/; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=e15OVtTj
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="koPp8xg/";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="e15OVtTj"; 
 dkim-atps=neutral
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
From: Varadarajan Narayanan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, Jul 20, 2026 at 02:25:37PM +0100, Casey Connolly wrote:
> Hi Varadarajan,
>
> On 7/14/26 10:52, Varadarajan Narayanan wrote:
> > - Add ipq5210 entry to the 'boards' table
> > - Add an argument to specify the SPL load address
> > - ipq5210's boot rom expects the SPL image size to be 4-byte aligned. To
> >    support this add an argument to specify the image size alignment to
> >    enable the mkmbn script to pad the image accordingly.
> >
> > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> > ---
> >   tools/qcom/mkmbn/mkmbn.py | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> >
> > diff --git a/tools/qcom/mkmbn/mkmbn.py b/tools/qcom/mkmbn/mkmbn.py
> > index 8d2078acc30..46edbcafb32 100755
> > --- a/tools/qcom/mkmbn/mkmbn.py
> > +++ b/tools/qcom/mkmbn/mkmbn.py
> > @@ -85,6 +85,7 @@ boards: dict[bytes, MbnData] = {
> >       b"qcom,sm8550\0": MbnData(0xA7000000, 7, SwId.uefi),  # C8550
> >       b"qcom,sm8650\0": MbnData(0xA7000000, 7, SwId.uefi),  # SM8650
> >       b"qcom,qcs615\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
> > +    b"qcom,ipq5210\0": MbnData(0x87980000, 7, SwId.aboot),
> >       b"qcom,ipq5424\0": MbnData(0x8a380000, 7, SwId.aboot),
> >       b"qcom,ipq9574\0": MbnData(0x4A240000, 6, SwId.aboot),
> > @@ -100,9 +101,15 @@ parser = argparse.ArgumentParser(
> >   """
> >   )
> >   parser.register("type", "hex", lambda s: int(s, 16))
> > +parser.add_argument(
> > +    "-l", "--load", type=lambda x: int(x, 0), default=0, help="Load address"
> > +)
>
> How about we extend MbnData to support an optional SPL load address option?

Would prefer to remove U-Boot proper's load address too from MbnData. Since
these are readily available in CONFIG_TEXT_BASE and CONFIG_SPL_TEXT_BASE,
they can be passed from board/qualcomm/config.mk. Why maintain in 2 places?
Please let me know.

> Then just have a flag to indicate that we're building an SPL image (since
> presumably you need to add an SPL specific build target for
> u-boot-spl.mbn?).

Ok.

> >   parser.add_argument(
> >       "-o", "--output", type=Path, default="u-boot.mbn", help="Output file"
> >   )
> > +parser.add_argument(
> > +    "-s", "--szalign", type=int, default=0, help="Size alignment"
> > +)
>
> Pretty sure it's safe to align all the images...... we really don't need to
> be adding bogus flags for this kinda stuff.

Agree. But wondered if the alignment requirements change in future to 16 or
64 then this would be handy. Anyway will remove and align everyone to 4.

Thanks
Varada

> >   parser.add_argument(
> >       "-v", dest="verbose", action="store_true", default=False, help="Verbose"
> >   )
> > @@ -149,8 +156,15 @@ if not mbn:
> >       args.output.unlink(missing_ok=True)
> >       exit(1)
> > +if args.load != 0:
> > +	print("Using load address from command line: %s" % hex(args.load))
> > +	mbn.loadaddr = args.load
> > +
> >   log(f"Detected board {match.decode('UTF-8')} with load address {mbn.loadaddr:#x}")
> > +if args.szalign != 0:
> > +	data += b'\x00' * (-len(data) % args.szalign)
> > +
> >   elf.phdrs.append(Phdr.from_bin(data, mbn.loadaddr))
> >   elf.ehdr.e_entry = mbn.loadaddr
> >   elf.update()
