Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061F4C4451C
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 06:10:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA8CD6074F;
	Wed, 22 Jul 2026 06:10:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zp5W529chH_z; Wed, 22 Jul 2026 06:10:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5BE2B6071D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784700653;
	bh=/E889rEWOQDq20rfKfcEJH+1i8HJ5+/jKCSqXamAYpk=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Lfjvx7qnfp5m4eAnv35gQ1n+Y7u4qJoNjRyhBPM8k79i2H49flgahW5Qv2DZ7aZgk
	 EoBCIlRWayJdGa2Jj9BUiFffRQHTbkqzPBNMGLCtBxWgMs4b1qVB/zc/0NB4Qh93YJ
	 /AlkOzXFyibMlzbX8hFRA8wzgefIjJs2mB+4wEixtqWeMRo+IjYZ8WYvF6zctOHz3o
	 EXEdJ9TlRa+0DGOaz6Dz/YYsu0jq2gAThkQ7z1Rt01eRaZXv22QD4mFTsTKdxYyymD
	 u7sWoE7+o7Z43AHL+2cCg9QdN5qgC4B90OQftXbGq+tDh5NSZSTjAdr3PsHCyDJZv9
	 aVT8nRsV7rsOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5BE2B6071D;
	Wed, 22 Jul 2026 06:10:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6596F313
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:10:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4BC2C80D36
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:10:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cZBYCdTREzyP for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 06:10:50 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=jorge.ramirez@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 194F280D2D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 194F280D2D
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 194F280D2D
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:10:50 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BBE3848BA; Wed, 22 Jul 2026 08:10:48 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 941D0803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 08:10:46 +0200 (CEST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53iCa4045203
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 06:10:45 GMT
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6dahxx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 06:10:44 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c07f25de2so119916031cf.3
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 23:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784700644; x=1785305444;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/E889rEWOQDq20rfKfcEJH+1i8HJ5+/jKCSqXamAYpk=;
 b=Ky/mYnNa0abLIS/yWJIOD9mbhg03WEYYwF0N19giCYNr6YDRV7hhz4x2opyysWGvzD
 rMfNC9nEPwvxJdrimq7ow3WVDuZbw+cewJqGshKvsFIs/p/GJCX39lleormAvi2OzQuG
 6iwb77+oYrJj/zDGtvyHa9uJvyfzdDjoDqZfdRc7yERThC4uKxXaggnQvnuTsMRy7DQc
 mNKaJA03tZ29eKGYpZrCcwYzK6pPOBif5jXXbk516ta9YRCxfdMdryG7M23sw8q0gjRL
 u+SGqYPQBGqYtd0h8CFH26qB3UFHvKJgMZZYO/UTjpJ4JaryCI7kvZmIG1qlCh6FH2bM
 f3aQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RorYkeLGOWff/nwesmdkSbFN97LfvvY+bSZrAMHj/FVDVRrWyffwzU+CWtX/DQg/H8OCBuPlCs=@lists.denx.de
X-Gm-Message-State: AOJu0YzwQwupjhWV++WjIibMTPNqkC5rcjlBuci+ehr2LrtH2uFCwCWi
 A7Kcb/Hfc6i4EeokgaNoKYtw9L4A/y3Wk7CjogZk3/rwFnI+AUiq+OPxszdejBYhh/OgEiSoQHy
 x8Bldf/qpWKz+sYL+5/F3Y6flq2glfvtT8HDCNpRxarPh5VTKCqf00JW3
X-Gm-Gg: AR+sD11R13hC9zkh1H7LHfcBeC+aXqsP04n7dWKRAf0su2TjRQQh5jW9/2O4QN4h0qT
 WAceRm2WQcKL5d+t6n6onyjs17KxrudHWv5ghAOl+9YR/3s85kV+3P9BFKTTg/zwAlipedr2O/I
 wany1ZqFJW5qGErk+s7WYqtoITRl/X78CFpYAR8SPkUtF7rrVewLyEcBT4xEyqFPbidjJxTBRyQ
 PzZPGr29jldZY/YBq7k5tgOjaaeLcVDmJ9isagTySEo3nzA3Wo641irBH0C9ebM4mTH7Hdmt5Z6
 KLycpV+KNZllkSBc8EoD9T8xloOB96jSGUlCnav4SG+bBboTa1EetT/PvziC4h/ZMr4VgqIraE2
 Z1OwhoaPKf8s5FJIYphwvQbtgDeG0g8IvIE4=
X-Received: by 2002:a05:622a:551:b0:51c:135a:5b53 with SMTP id
 d75a77b69052e-5213aa6e46fmr203489411cf.11.1784700644284; 
 Tue, 21 Jul 2026 23:10:44 -0700 (PDT)
X-Received: by 2002:a05:622a:551:b0:51c:135a:5b53 with SMTP id
 d75a77b69052e-5213aa6e46fmr203489061cf.11.1784700643788; 
 Tue, 21 Jul 2026 23:10:43 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b5c2108sm51030915e9.2.2026.07.21.23.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:10:43 -0700 (PDT)
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Wed, 22 Jul 2026 08:10:41 +0200
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, trini@konsulko.com, 
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 bhupesh.linux@gmail.com, n-francis@ti.com, marek.vasut+renesas@mailbox.org,
 igor.belwon@mentallysanemainliners.org, shawn.lin@rock-chips.com,
 yoshihiro.shimoda.uh@renesas.com, alchark@gmail.com,
 tuyen.dang.xa@renesas.com, macpaul.lin@mediatek.com,
 padmarao.begari@amd.com, jstephan@baylibre.com, bb@ti.com,
 j-mcarthur@ti.com, venkyada@qti.qualcomm.com,
 hayashi.kunihiko@socionext.com, u-boot@lists.denx.de, sumit.garg@kernel.org
Subject: Re: [PATCH v1 4/7] ufs: rpmb: retry SECURITY PROTOCOL on power-on
 UNIT ATTENTION
Message-ID: <amBe4awYQneMViV-@trex>
References: <20260720085202.537019-1-jorge.ramirez@oss.qualcomm.com>
 <20260720085202.537019-5-jorge.ramirez@oss.qualcomm.com>
 <9c8ad68c-d1ad-43a3-b3d0-e960e9c5720c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c8ad68c-d1ad-43a3-b3d0-e960e9c5720c@linaro.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA1NCBTYWx0ZWRfX8ZYrVi6D47uC
 eH8OKfJgo3rSdTR3lgtdbbeovpqLukrn94H/jTv9ter8p+GCAiV4qFuqTI81sFqYKIyXsXdptlA
 Yh9R61RAaV3Dgo/sRxcpydx4JGIUB2I=
X-Authority-Analysis: v=2.4 cv=Ipsutr/g c=1 sm=1 tr=0 ts=6a605ee4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=zlSorN3yLe_ES7OLv-UA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA1NCBTYWx0ZWRfX6dDfeeABGkFx
 QskiJCDx2B3+8xhm6uwvzzhHnVIV8WoQXXFTfdOP8f2/E713Z3EliFZRk7rV1uWfWNyRjg2cnCk
 I7viutdhtdtYKvWAS5i3hfEFEal2XW6v1IjxkxAW1avr5q5UZmOJmHND9A1kf9duR3lYsSrsN7E
 A7QtdUAX1swMbttO3oyXklGGeg3ncF1b/PqC1V8BKOUg3lTBPb2q/CAJYm80f4sNxtgnpJVbuXw
 hD7EARel9p/08a6ejbMDM+AWxbfaFIWKXszlUeyl/sS3L5kLaru+uwfcbQxG+0oagGJdZG/KGPc
 UTKGQncnYiXWyFD+KAUvmrwe51NNtocjT89y6bwylX9+LMMvrw2enEmHr/KRh2cSwdZSJg2/cz3
 zbxbjvs9N1pl6QkyLMXFuUfnuW4EgbM22ErXix7Y5NmoV+tIuHkJoG3tmLi6oklCqML6Lu2jvgG
 T7ldVJgp4np88vLfQ8w==
X-Proofpoint-GUID: ebiq1Cfek__xL3kodr3MdJ5BRTO_nepA
X-Proofpoint-ORIG-GUID: ebiq1Cfek__xL3kodr3MdJ5BRTO_nepA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220054
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=/E889rEWOQDq20rfKfcEJH+1
 i8HJ5+/jKCSqXamAYpk=; b=Ji+6hZXmnh/ti2abFoxwBbqSZm1MayMXAgrZV8hK
 8eH4uP3kLW35GpctlOjf/gHjpocPo6ZVqG+QlUkDxW2WGtXin1cljTaNBiHKZfGB
 Ckgzn1c36hD73PUBjbpb4rZ4xNgV7CDUA+LmHKrUDnD2LgRRYn4d0mLgWULuHKTh
 0NibcXRRK0w/9Z9exe1iDp/C6aFvz89BiiQUtEey2eO8/NyyzFpMjd+QiRrc0/LX
 teXA5aFQ8Xjxe2+eZUrfNTOeHp+IvA5lDobSspGKtuEpQ+12OHGwGzc/bDfk81rt
 L83HoFeWjECCZKTll8d3iq81XXzxI5gSBUypebVYTkT3vA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784700644; x=1785305444; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/E889rEWOQDq20rfKfcEJH+1i8HJ5+/jKCSqXamAYpk=;
 b=XhGp7xL+kFJRvS0Cjs70z4l2Kxht5jHKi65pvLg9LTY013LZLhHsuJ8+dbLLaJTGTB
 n3RoRaF6fqE/Cl1GZMteCu8U66yR4PErq6wOndL5zPNIv/DyviqIQLg00+nWOF8bIZx7
 GtpCIZpGL3WB8sPgescC3LZO1vX+dR4m7wM0/JpXFprlq3KhsuLLH5QLO6mNyPrW1wxn
 X2tiSi89LZe0dfDpaGuItEJvT2HIHzSa5px9RlgFgQ9nWwicVRb6dcGWJgxfEjATSOZR
 7VL/ry+O4NVkL7qnIpADFkOPNziqj+EY2keIaJVvcgLYKCHA4sxv3OBNOA1+ynod5JfZ
 oxTg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ji+6hZXm; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XhGp7xL+
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ji+6hZXm";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="XhGp7xL+"; 
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
From: Jorge Ramirez via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 21/07/26 09:52:58, neil.armstrong@linaro.org wrote:
> On 7/20/26 10:51, Jorge Ramirez-Ortiz wrote:
> > The RPMB Well-Known LUN is untouched during boot, so its first SECURITY
> > PROTOCOL command after power-on is answered with a CHECK CONDITION
> > carrying a power-on UNIT ATTENTION, which ufs_scsi_exec() surfaces as
> > -EINVAL. U-Boot has no SCSI mid-layer to auto-retry, so the first RPMB
> > frame OP-TEE sends (the write-counter read that verifies the key) was
> > lost. Reporting the UNIT ATTENTION clears it, so retry the command once.
> 
> OK just squash this change with patch 2.

+1
