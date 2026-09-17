Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D78EC88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 07:46:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 13F60802E8;
	Thu, 17 Sep 2026 07:46:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 36_8VzIV4R_y; Thu, 17 Sep 2026 07:46:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5B9F980EDF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789631211;
	b=ShQQZFCXn0dX29GhMSE5Fry7012oWUWHdNaH3BzD/57dqWleZvor2lINsUInhQjgOvFQ
	 Pxc7zpXhc4pz83iigyoUcat9s4j+16m6JT0GlS1OwYPVJW4TpLutenoekpcnFDzTQVsV9
	 5brVdcxoIDrmpAjZLuK5T7IOhhAbijDneGtz0bQNDGfQQ2XVRIujWhDhxkmKI+XRJW/v7
	 1YisqAVdG80XfzV/DAkOltRivZ7NYIwvbzi47v0YJz4O5KwHiIq9yghUUBufCbtyvY1Kt
	 K3GJ1udzlBrlEa4emjWWX8jdwAtE3wZhJRPrdNJhUK510yziR08w2OFHEEbCWeglB+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789631211;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=s2CUow/2i2KRACRml37yePvwISBZUSh36chFrvUzLyw=;
	b=bsZKhweff96we2Qug6GfIo0MvPwGcV9IQTXClD5m7RxGLnMpeYHm26QcXr6ktfmYpjm4
	 2/07Y9/IK4T26LyBeF3zrLlzJwlrtbF765bmsOYtKDZhuY8DqcNjC1pW+yPYca+ASN/3A
	 ozhI7XCEVDZF+Q3MWF8AV/QvTbNGJnrUqndNCkrnDywaZL4M26v7gPpZwas93tLwwLcdS
	 p5W3QNSoFCsgqrbCkOlfRyb8KlzLHTMHIybg/427s8ldGDw7vqGS3a22OL0bX4cumzvO9
	 BGrjf44hRgkly/yr7OQQE3kRUllPVINMNCPfIMiDMGzaNMV5hiijdCnLFH4riiMeDuQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789631211;
	bh=s2CUow/2i2KRACRml37yePvwISBZUSh36chFrvUzLyw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WtCIvfE3H5m2qybXvWPXnx7J62FWaiLes5iS4O4JUJO+2BbuYhg3uatpo5G4SlFrJ
	 unCnVA61sC0vJP6dg5LT9gmyynVFVfBIdbpWOQHXshaYGjuBR57YtXQ3CyQI/81usK
	 SqskxZxeMtDCtMzRE0QAsQ6dnx3EBuQfBofHESBlSkPLc4wFFXU9ReDEdrXFDhSMtE
	 JVwzZPxMMLJVPQYz0f+d6XJ+Mv+798n8pvE4Qvm62doibfYZqQzAc0D1E5VT+En+DZ
	 YyJ55FSFkEwStA74y14aWouMDUrdCrMcsJ1/eL2hDIqD6gIdREx1E8AFIA9GKPxZSV
	 l1h2S+W+z9aCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B9F980EDF;
	Thu, 17 Sep 2026 07:46:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BE9802EB
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A4C86407A1
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MoynKEjBlpwE for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 07:46:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DD2224079D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789631209;
 b=GefeL6xjGyaCiBARu4FicJZUKODv0H6A/XgfdsRVZwnEBL90Bc1vfMOxh7kwyxNFguvE
 9Kzfq0C/9IE+pMzuxGHWAWHve15fbG1E/jjGAoZOzrrawdNhc6fJxEAEft10KbQb3ruVd
 TUFd5huIP9uA3ZhfLq76XsW8HjonMVEZtKc/Ah9PytnxMA8ipeGofGfGdghYj37CYvcY2
 fIwMUx0LCIMHc/LEQSnq7TTm/ulwOdRtmRksq8X/P9bBMLTre8HbLynZ+4nQpi8bp6H+5
 hlbod38vu41gxrwLYDRnhjP7jpgZuHIpGmKKraKSfVKKekUnehat1Gr6kaY0GJETVHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789631209;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=s2CUow/2i2KRACRml37yePvwISBZUSh36chFrvUzLyw=;
 b=Zja79vhhcRTFbjqgfUfZZGP0VOXHMBdv4fQiejX24VRmlHYiQF3Ost7QA/WHjKbUyt9Z
 9rr2XUVlWvkGQ1SiEqMF7EF4rQcE412+MNSUSCSAC9Kffl2iJto7WhIhMxN8meFp07Oi+
 5nZY4qCjXnxV91b0mvFFCu/s1fj/21H/399H9tR4JOVmL/mmA7I6t0wiicfOdGvNLWDtm
 J2kyDePE49iF3D0jEfcBOe+LftGWKKoO7UWcZGvZ6EEZjbQtE883f63UklvrAyrWRaPf6
 i35PqnfKsYF8uijVIWVeYnqBop0zS5mlgFRwtYEu92qZf88+JqvpvIi/3JDAhFsMteg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=kHxHfIyh; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dmqiAENb; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=kHxHfIyh; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dmqiAENb
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DD2224079D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:48 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60G8x1924346
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s2CUow/2i2KRACRml37yePvwISBZUSh36chFrvUzLyw=; b=kHxHfIyh8DKmLNim
 QRxCMW/lQs8KBnqfdEX3ozN6pztY6fWrM54GiRprd3Bq5tj8Ozhdz+zLq9JOf7jC
 0cis8o3lc3D8V4Z4qNPr2FQb/w+OA31+EFplW51lOv3uq56Z4d5ks5/qVX4GlzU5
 ebxEdBGRizBXp7sFY36p7VyJh0cnp1ovCvl7Y9tdLyIWOtot74ynuakLZS2vKH8q
 qd8GxTZ0LGwuVVqUEdJg0Tb6/KVF9Ubn3mngRNXlslz7KyS+ovbnMAGAr+fph/Ew
 GLaMw9n9S4tqfUDcIHM+gPaRgWSWOIWzEtifpRklkWNhT18prOx4yNCP6ialR/Dk
 urvqiw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqxw8u956-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:48 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d6fed0652bso8325245ad.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 00:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789631208; x=1790236008;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s2CUow/2i2KRACRml37yePvwISBZUSh36chFrvUzLyw=;
 b=dmqiAENb3Mq0nAaOy2rpGnFotL+Jur6bRpfGk/+HlNNqneddKGtEqiRGjQHROOOxT9
 h0i5yx9YIPNNqUEskcSe0qdVvc4Ej8MxgafN/X0O60c2TTxqATwHFryfN/ky53+75oKb
 Ke5gFSTCKWfbXmVTq0cMGosim8RWpUCme/4kvog0uQO0TtQKTMmkHCI4B/yr5dv0iXlw
 +hdifi44nR/tCjp/Mpc0EpFYvs97cV//HXeHiw+PYvy6Pwp5DGTcY1XNKJ79m8wglU13
 sSRNaQCZa6iQhA8ZuVoqR50ArIp+n6B9ZdcgCj10Pc8qMsplWt1R+TCys7m9bpBsnK4X
 vV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789631208; x=1790236008;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s2CUow/2i2KRACRml37yePvwISBZUSh36chFrvUzLyw=;
 b=Y00NRm+UxmURhHXyPswHLj8UXoEyvsjp5l7KqX2u+G+ewds5nC4kPacyEgyVKl0KUh
 VlqOgfWw2H+zaWBca0G2y4wJmPIHiD6lmNOiA/5co0wXQfpkRHvGiI1s67TgDv/7Fr2S
 3vYN91HQGZrlaxSvA0n+Y+rbGi5QU/b/wcsrveIIulSmQscL9INXagtmJud9Cf0Va1Us
 s7KoEw6K4DAm8KXxHXB5yl4mITJDQ8oZOZdTOFHTIElryjPigZaGQXnhpdaKHkml3UwX
 /aQxW4KfQv4vplW5+ZwoaJ0ZqhvUBxwzJc2ad//qSWRoixeY25nEMI963Y/e6ZpCYj1I
 FPiw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy3v6Rsi6gitWnsi84F0I4OT0A4dVLlZDO0jhE7A8foBi4rydADpRZ8TDhv0NRcomdTwELqHOA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++moUVUkUcGow/oJfj8GRp8bEL09N5lxNWAnPf9iDZZLdOreIgL5
 fBfPbMxTZu62/hJqKn5lTCjBpms5c482Cf2YCGbCqgxHabpdNgs8opr5NLRwQyXJBOFcpYLhj/V
 S4uyQHQU9TgfAiJhBlyhraIUjferBuldTL6Hl9TPMINwg3f6b0gJpkqlM2NK8+Lq47Eg0gcI=
X-Gm-Gg: AYBFou3hEmj19hoDawwXj2zD/p2Coi0/KKnNZkLKlWjlGBbtThFBnXrRDotXPNwHw6P
 z+HkzJrZaq2TtbtmoG7bkMgm3FhOEMgcuPR5Rj70ipDL2Y3ONwbhR368vmnu8pHLNOjkgenIgdu
 QE35LQ4gwd229elDtkWIpBV15pvzZcw6/lqfkdBtlskoP4W1FVrzZH86nsYi3mUuoH2nZwvCKpC
 t4DNXqAraUUND7lZWMzt2F756mGorQkuws7iJpR+g6f5vFdlRSAPiCKEtzWntXaH4GhPlDH1++m
 xkgaIrDIsD/hl2fK10odMokNsgE4jZQtc3w0tgk8RcgJYt3SnIlWut7jme1Z46tZyYX/lwcUXZI
 H4q53LnYVZ/MB/5Ngz9qlczU0mwxUPWZAD0LQUrO4cWWGLwt8mebTPAuCOlnCmv41Kzl3sTYwxJ
 tJ0KfFW/Hlp0JcsmTKybx9Hcuv/skHvg==
X-Received: by 2002:a17:902:c94d:b0:2d8:d4ce:9f32 with SMTP id
 d9443c01a7336-2dd8e635949mr125083595ad.16.1789631207376; 
 Thu, 17 Sep 2026 00:46:47 -0700 (PDT)
X-Received: by 2002:a17:902:c94d:b0:2d8:d4ce:9f32 with SMTP id
 d9443c01a7336-2dd8e635949mr125082285ad.16.1789631206228; 
 Thu, 17 Sep 2026 00:46:46 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1e38sm14379848eec.16.2026.09.17.00.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:46:45 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 13:15:35 +0530
Subject: [PATCH v10 06/15] mach-snapdragon: Kconfig: Add rules to create
 SPL images
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-spl-v10-6-3e83dcd239f0@oss.qualcomm.com>
References: <20260917-spl-v10-0-3e83dcd239f0@oss.qualcomm.com>
In-Reply-To: <20260917-spl-v10-0-3e83dcd239f0@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Andrew Davis <afd@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: P9U9qyqCnas2TzcbLHZrsz6lK5-2gLvw
X-Authority-Analysis: v=2.4 cv=bY3+w+PB c=1 sm=1 tr=0 ts=6aab9ae8 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KPGK5uzhZNYWFyxW8pwA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEwNCBTYWx0ZWRfX7GLFH2SCSkm5
 0U8FOL0u7DY5ADiEZeXSTrEbK8HYRTpwet4KHtEc1KoETCNZbTg575Zhtb9sKNf2tl+/TwvXzCI
 H5TU//i+VV8Kx8uMdE6Nogcdr2De7pI=
X-Proofpoint-ORIG-GUID: P9U9qyqCnas2TzcbLHZrsz6lK5-2gLvw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEwNCBTYWx0ZWRfXxJJnZwZYwhZt
 fsP3al1/Z4kBn8iJfADp0WMrjatI5g3eiZWQwLNL/EdgXN0tMjabkIMuM4mw7xqf02Ix9FTEuM2
 GXrHFrR5zDoV9E10OjjBQ81hoJLrS6GOF5N3u0qinp4zg0D8f+LI/CzT1UGsZOmq+x4MYtEPZID
 owzDRjRY6b0XWfNdWRi5Ri4rTk/3m1G4YvhcCc+tacY4NiNaI7i6RiAwDzjWum2z5WnY6E9tuZE
 GVqToEkUEWlEZQFoR50GpQ4TBVJ5tRUTGappDnfo1/a5NwqNx+WF6fdFCWGGQ6aTXXTREXnzKyj
 ItQ1yxf5D4xUS+RKgtNgr+E3FHKnOhOb5PL3N9tLqQXfnHEMD5VBW/YGNhOUcZ+a5QK6ylMrsnZ
 C/q36j6UYpQyD4GCYd+G23KGr8ItYH7ailnS8yFV5kNr6bSodze5huIAYQV4semxT3HsCKayI02
 XM05RHs6L0iBPpiPUvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170104
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

The boot rom expects the secondary boot loader in MBN format followed by
the TME executable. Add rules to board/qualcomm/config.mk to create
u-boot-spl.mbn and u-boot-spl.melf.

u-boot-spl.melf is the combined multi-elf file that has u-boot-spl.mbn
followed by the TME executable.

Additionally, this patch adds a config option to specify the path
of the TME executable to be used to create u-boot-spl.melf.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig |  7 +++++++
 board/qualcomm/config.mk         | 25 ++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index ddded0029ef..5718b66cde1 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -59,6 +59,13 @@ config QCOM_GENERATE_MBN
 	  New platforms can be added to tools/qcom/mkmbn/mkmbn.py if they aren't already
 	  supported.
 
+config QCOM_TMEL_ELF
+	string "TME Elf to concatenate with U-Boot SPL MBN image"
+	depends on SPL && QCOM_GENERATE_MBN
+	help
+	  Path of the TME Elf file to be concatenated to u-boot.mbn to create
+	  boot rom expected multi-elf image
+
 choice
 	prompt "Qualcomm boot0.h workaround"
 	optional
diff --git a/board/qualcomm/config.mk b/board/qualcomm/config.mk
index 769e4a51ca0..5c45f993a41 100644
--- a/board/qualcomm/config.mk
+++ b/board/qualcomm/config.mk
@@ -8,7 +8,30 @@
 # Create Qualcomm signed elf images
 CMD_MKMBN = $(srctree)/tools/qcom/mkmbn/mkmbn.py
 quiet_cmd_mkmbn = MBN     $@
-      cmd_mkmbn = $(CMD_MKMBN) $<
+      cmd_mkmbn = $(CMD_MKMBN) -l $(CONFIG_TEXT_BASE) $<
 
 u-boot.mbn: u-boot.bin FORCE
 	$(call if_changed,mkmbn)
+
+ifeq ($(CONFIG_QCOM_GENERATE_MBN),y)
+
+quiet_cmd_mksplmbn = SPLMBN     $@
+      cmd_mksplmbn = $(CMD_MKMBN) -o spl/u-boot-spl.mbn -l $(CONFIG_SPL_TEXT_BASE) $<
+
+INPUTS-$(CONFIG_SPL) += spl/u-boot-spl.mbn
+
+spl/u-boot-spl.mbn: spl/u-boot-spl.bin FORCE
+	$(call if_changed,mksplmbn)
+
+ifneq ($(wildcard $(CONFIG_QCOM_TMEL_ELF)),)
+
+quiet_cmd_mksplmelf = SPLMELF     $@
+      cmd_mksplmelf = $(CMD_MKMBN) -o spl/u-boot-spl.melf spl/u-boot-spl.mbn $(CONFIG_QCOM_TMEL_ELF)
+
+INPUTS-$(CONFIG_SPL) += spl/u-boot-spl.melf
+
+spl/u-boot-spl.melf: spl/u-boot-spl.mbn FORCE
+	$(call if_changed,mksplmelf)
+endif	# CONFIG_QCOM_TMEL_ELF
+
+endif	# CONFIG_QCOM_GENERATE_MBN

-- 
2.34.1

