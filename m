Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327CBC9830D
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 14:05:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8E2D40B3B;
	Fri, 25 Sep 2026 14:05:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iBe_fLeU--II; Fri, 25 Sep 2026 14:05:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 25E6D40AB1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790345124;
	b=UkM86tNa6VJqA4fJ8gma/kfpMI8SAyVSSEhuXrB4q+Rv9mVNwTLVrMqQ4D9viSh8XjDa
	 rf4cxeYv+4INx/bkQNmkgE4dkk7ZMsS+I6IcgowRd2ki+8SDAFOWFfJVwQSBkwny2+ukG
	 aPtlEm/gw4NvP13+8u5oojRRt31XHF7778/LHTJA77AGw2dqPwG88Wv7BxcrFMCgfuTGN
	 uHj9kOUDdt+OJYSRSzVxQDLY6/IFYalarnfsVENeUsiNm3Mx9oDzDEfC8gMQvOrqKj47k
	 29fif+D8AoIlt1GiWv9N7GxWD1OBQZy+sVcOpeDxHJBriwpy1qYxoATzOXlNeYoOVBA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790345124;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mHfEZ3Ak4JGSn0uNhbnUD1+ymESUV03Lm6dHezPhfHQ=;
	b=P6ltikC8gMA/qqQb/mbTfwNXCbrvi2HV3skWjgvCJbBnAK80UygMWBQO7GrgbQ9iQTWb
	 wSW9s5jXIPzWCJjqHp318oHS64mGwWgcHvrCpz8popaoaVcDwsElAIeualbs2oJjZOSPe
	 +jUG1ntxNq/nBtxWRp4fU81IVpnzIOksl6efV0FfN2MJiaqflvzMw5EBLVGPawquw+GZv
	 4Qw8SkXcWYATiHB7AVYKRaENwkQYsPPtTY1a+hPN5by45iUO3M26F3C+EtdvcGhlZNgjq
	 7+JXZUt1dSESJPWPq+gr2P2QChQkjU7yMBie81kNYxbACO+47BnCQaNCniZ++VGidQg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="H/tZLJET";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TgbAyufI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790345124;
	bh=mHfEZ3Ak4JGSn0uNhbnUD1+ymESUV03Lm6dHezPhfHQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rieKGXMvdhXmoB7ZOHbcb7RangpirN06fA+L5cobhBWiMMdFVFH7nkq4E7AAe7eGU
	 5KwkW+SxdPwKt+KwGVzDwm62P5rfocA3U9AWnRkzUoBXR3bHdHIrmlZtCrOhvlNVhp
	 OTOj0opgH+48PGQefJia0xmfm0LZz/oOOBKmkSv7/gieSPN44xB6qi4ulbIu0S2t/M
	 H+qMxWmmzu/ncPWXtpI/xyCQkAp1R7bJpPAAFE7dtHb32LDyZQT03fz/dGgROfsH8y
	 X+CN8OJv5JSPY1Cw+aapeENGhDS6hDl0gLk2rM4u6AbcoJyEuGtg3WOi/ejFLrYOfI
	 /RmUU0S3x8Lyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 25E6D40AB1;
	Fri, 25 Sep 2026 14:05:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 104AE332
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 14:05:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EA4C340A7B
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 14:05:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G9qvr2_QD6Lr for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 14:05:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3B65E40AB1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790345121;
 b=lTGrgRb1Va26ETHkVPblECU2VbkPVVuXRfLN6pGGeNpsDk/3CLXorNTgxufl1vSMp7MW
 1Qn/Si+Td+cp+YwEHkAh5L6rI7H/8gApAYCv+6cyTb8M+orl0QUTlCFKjtWuoVAjvm3rw
 UI0ayvVDRTVfhJvJR1Z9oHG7VPpMqJddFnbo7U+EYgSJtO6I/WF03YHG4V8mQ3SwaLm7t
 /Kau0zHgO4BO+vEGR5OM9w1WJN9GdRoihHjIsMxPrx7RcPh7T3e/U6lWM/Jgg+o37AxxD
 CKHRV3F3b4SB39x9UaD1KfY0jMw38bTJ2OsX3ltzdKZTvG5KYQoao3tkwWA+uPG9ZwQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790345121;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=mHfEZ3Ak4JGSn0uNhbnUD1+ymESUV03Lm6dHezPhfHQ=;
 b=Gz4XEA7Ua7Qpy7aONFXK7obLy+899sxwKXXKNPhSFwsy8QzfTbUe6OS0rWxDnFW1U4kU
 nQj0Dy8hP3x0aTIr+Bqt2xD7gKFyjWF8IuBo4SlwUNuAGB0s7sxv3m/2LeMLAqw55Wf9T
 OZx2xQBLw7Tq4WBo8pajhf299pgxuK3KhPo3qNYBhzjto7qVp0q7Kj1HINTVZNK3NywjG
 LzraL24QqbFj0INTYXMqTdgwYO0FtayxbWakPh9BWXbPRCzRNH49w56A631xHJefC6lQj
 9rVOGxaCeeE4WMWbHJruassivssIiWZS0lZwIFq8wdzyKZylkrypX2wyB1IdSHa6+8w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="H/tZLJET"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TgbAyufI; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=H/tZLJET; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TgbAyufI
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3B65E40AB1
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 14:05:20 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PD0JPo2911319
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 14:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mHfEZ3Ak4JGSn0uNhbnUD1+ymESUV03Lm6dHezPhfHQ=; b=H/tZLJETj2vnwCP8
 4BBG3x8DRQyhcUh5tD/n1n6yfe76BZU787U8KqEqExRDCqMc3380SDEg0oSe/pvW
 HKGfggw2Ak2X+IPdlvXqRZi9sSOejQNQIxhgfgAHvKHFcxZWK1IB4zDcIHVbw8tP
 o9fuGqN8xOpphL4aC07SegTu5x515ESECdr6lTJI9SeiW+JWzoV7KFATqqYMvdQB
 FhnlkHGX/Xhb7xfy4UPWFI1wQtiJVIW9fSqYLsz0cp4pBMFt/nyJi/UI2NYnsN3V
 fJLkvzxJt7uSdbZ5lRwQeDMqXb8cx41LI4PMGn72JCBrm304ZCYLyg6sm6Hpqa0G
 bJo5kA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwhm51the-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 14:05:20 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc21bc2923fso609141a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 07:05:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790345119; cv=none;
 d=google.com; s=arc-20260327;
 b=o+Onu/Nua+mlofuAjhCgTpYUQ3cu2SHDkSuWpRO832CfVAoUFcYsprdpN8RjPycdHB
 xyG+xTiqrnVeKsQ7tJftpiyp7Eb56MJdQZyXzOFh4C4EXKly/lbV87i2ymOeyXdnJw/f
 TpHl/Q86BmuRpBarHNTOgcZHaHH4OfRRrvig8mAsbUoHWKfLTZPjJZLTCEDatJmSWrkE
 TIORQ+a8TDp5tR9xXkKz1zSTIKr4NCHGRHK1sC3voR+w8mpJqrj8gLvE9JMb0AXsiDcS
 CDldXXgzFB7blj1zBL6D3yO7/CQ5RcerTfA1LmUufEikGmMhx03vScXOSQtHdz+Gde5l
 ITEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mHfEZ3Ak4JGSn0uNhbnUD1+ymESUV03Lm6dHezPhfHQ=;
 fh=RtNoFA4mp9Kr/NfWwt7eif/mhIQuJxKuqtQBBruqSzc=;
 b=sb2UprlA/Q2EBzdn6JAs7x28jaR2wBVxr68FOTEmqwIKm6sgMlPUDELStIhAPbqTbi
 WtRntDqNS8d89DknNspleGXQU4oTDLcNgB6q5cXjtuR/kGrSCkGyptZ/6yGcyntmNh4f
 /rucP2n2i3GtBzjK4dKuruLpM7EXglmF9wugOgbB+Hw8cycLXqT+0NM0VMvtbe2neL5P
 Hf7vPexebIWzdYyb1dxPhSd8qd+Kq9xDuokQH6Dt7mfVzrdD7v/k/7G6ndz5LSgtKZZz
 ycQup4kFvLfvnIwoF02OclU9HStRfBR4/OboNsL5TxHTFt4rpwLtAhi367E0TqcuKkIu
 zMPQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790345119; x=1790949919;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mHfEZ3Ak4JGSn0uNhbnUD1+ymESUV03Lm6dHezPhfHQ=;
 b=TgbAyufIt0nSjgHrm4IA+3EPUk0U2Zybyg/sZvudZbxwZNVXILqiBThdCpSSMg8ZuQ
 n9QIfOiuYn6zcv/LDFNWbo1PCRpwl/OVi23mMb6WaXh08znAe0Je61G2pfWcbQ2hQe2/
 bduvB85chEJep6yPaJ+JEHHfRYzPkRGqPgPklQc8E7Y+yyHk8zqReP5l8a7WTkBVYsM0
 mS3NzlHdhFy+80VYkyyfgS1EmdEb9y1OK56L0VYVK34e6EZrEMoXI0/cSuMaVzM+B3Z+
 FsskLkEmr0NjQw5ar7gvrTN8kE3Mg90/58Vh1fQjlp6Za0QrGG5iNC4vBNIRaKBTdYGC
 19Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790345119; x=1790949919;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mHfEZ3Ak4JGSn0uNhbnUD1+ymESUV03Lm6dHezPhfHQ=;
 b=MQQ8u1zextLdVQ6gIrm1KFRUm+xdGWt0V05FDLQvZCKAbbvt6WuM02rV1zwLILD7/W
 FKvj1wo9aZFb2HnAPe6RLFwPXsfp/y4euQQGWwt0RHUyAl7olXzjF+EFDbQDUNByK6cD
 Ej8vvNTY41jmFw6xyKGw/8iYTXV5GDLN9FTtXMalBvk9N9OK/zcFGRU926cpiRH3Ojec
 SRmu2ItzeidT9nLWkjFrW2W+f4zTA0kE78rXh8HJoNzo5ZCJNrdLpjY7XBFwXJ4LTcjm
 WqwhaMAM40Dorf6SFeN9wgaa4xAiiY1/pQt71FlDkEI92BgmSrPtHMNmancfJSdKgd+D
 OAAA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxkCN6P1WLIsrrDjVhFusDn2P0QtjjtE/n4FV3KIza2YQjNMPLmZCp2pD4XMojDMXarhWleLVk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k1a09bDye272yLwqnrcOBUmNq6tFotxf8ZVBBMPmy53DA3mB6x
 pDq+4+Yt67+xm7QkDzf7UnvQmW8ZNfaAjd//ezziGBH66qAF8So8pvx3V19eHGWfjMf3qdiZSQz
 pD53wEo8Un1Dn+NlNBtbYhZ5anQD8LPxVccGsnPnbz9qiM2TjDn+oh2hf15DpHYSvMqSSKwk5Pv
 3rT+2qSq1DSKIrQXdLa8qmcjeCGGxN7iX9oA/NcHXPk+k0nw==
X-Gm-Gg: AYBFou24OOMC5hispZtBYbZZ/oI9+2R5l9fwdBDL0j/L6xhf9MLjoydjgw6F0lqfjgs
 RJLQ1bW5fYUaYT1a31uu0PeEvo+dxdEV83PpIvOh25EbsrNyZvHc/qoiuzlzoPFkYWt3w5v7ziZ
 3C7VyGXL1jhSiSqQ3A3v7Y/BoZcMcTCL1lnk12m0wHh3TwW0WyyF21r6g6ug==
X-Received: by 2002:a17:90b:5108:b0:3a0:ca3d:c32f with SMTP id
 98e67ed59e1d1-3a0ca3dc5b6mr657990a91.19.1790345119221; 
 Fri, 25 Sep 2026 07:05:19 -0700 (PDT)
X-Received: by 2002:a17:90b:5108:b0:3a0:ca3d:c32f with SMTP id
 98e67ed59e1d1-3a0ca3dc5b6mr657958a91.19.1790345118675; Fri, 25 Sep 2026
 07:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260924-monaco-ventuno-q-v1-0-290b6a4d10c0@oss.qualcomm.com>
 <20260924-monaco-ventuno-q-v1-2-290b6a4d10c0@oss.qualcomm.com>
 <ad33fdf2-6db3-4368-920f-751a7489ae92@linaro.org>
In-Reply-To: <ad33fdf2-6db3-4368-920f-751a7489ae92@linaro.org>
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 10:05:06 -0400
X-Gm-Features: AclHuK-wEUvP9_v0FT0b_19vcgBaXg4eka3-6T1-z-whdvqKsImLFw2P4zQTZPY
Message-ID: <CACckqB0RXn219TE2SzzQbi-HYhYc10Xi1xtek82Laf6u+Am0NQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] clk: qcom: qcs8300: add QUPv3 clocks
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: EnAQ3-7EyZf3C6U_Unp65E-RvwMYBvjK
X-Authority-Analysis: v=2.4 cv=QYnzLcbv c=1 sm=1 tr=0 ts=6ab67fa0 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=KKAkSRfTAAAA:8 a=_tmDWiHaD96Q7rQ5_8YA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1NiBTYWx0ZWRfXzedwjUtVroMn
 bDvWlW/MfRnfQxurfIwkF7AFC+6Hqv5xNItTymM6VTh22b1S4uFH+zuQ68QnY2LCVU8NDJ0vpi0
 Gd/SahloeUpgrfR9NUmrwM8p3j+fzMEA4jB+bvryBxNHtrdWtSed1GUNqAFQdE4ZqcEYEjdB6Rg
 0wG+4dvhy9eBtcrG7XGJrKlKvyQf84f0T4oNrP1N3TIenhVyUDBLqBXUYB/dDWIPO9jxKSyeTRa
 Mkjb7QXt0I97g/taDMbLmWwNgCBK05p6nJHvvl/gNreqpTdqgIRV5MxmVaig9FY3XreEP1xowtb
 M47BzwzI8m4Ia4nhVrQL1hMh0oXloJ6YK1CmbhpFdrRbSDywrrpYpQW4ykpW6CyX2q6yoOzzIf9
 NeYfeuzvi1RvTlRbLUlp2P7emhM8jFyQ9LUzWpobIBERxQ3OxAmxpf9RllJYJbQgOIinlUzD+R7
 IhCnW8xHSeRKUIU0nTg==
X-Proofpoint-ORIG-GUID: EnAQ3-7EyZf3C6U_Unp65E-RvwMYBvjK
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1NiBTYWx0ZWRfXwUPZqlitUvrX
 valj8qKkO9558mrnPc9WDWbWwVWPj3Sz9YAApAzYFk2zTk/qzocfM8Ei7fVTNeSYIvHfls8kLcV
 02ad20FyFuHLnIlsho7uJNXKadyKDkk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250056
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

On Fri, Sep 25, 2026 at 8:38=E2=80=AFAM Casey Connolly
<casey.connolly@linaro.org> wrote:
>
> Hi Tyler/Claude,
>
> On 9/25/26 01:38, Tyler Baker wrote:
> > The QCS8300 clock driver has no QUPv3 clocks, so every QUP serial
> > engine in the device tree asks for a clock the driver does not know:
> >
> >    gcc@0x100000: unknown clock ID 109!
> >    gcc@0x100000: unknown clock ID 117!
> >    gcc@0x100000: unknown clock ID 121!
>
> useless context
>
> >
> > Add the QUPv3 wrapper 0, 1 and 3 serial engine, core and AHB clocks.
> > They are branch vote clocks: each is enabled through its bit in the
> > APCS clock branch vote registers and polled on its branch status
> > register, as the Linux QCS8300 GCC driver describes them. Rates are
> > left as the boot firmware set them, as for SA8775P.
>
> more useless context which doesn't belong here, this is not what a good
> commit message looks like.
>
> I'll let you respin this series before i take a look at the other
> patches, using LLM slop commit messages like this is frankly just
> disrespectful, nevermind confusing and polluting to the quality of the
> codebase. NAK

Ack, apologies, I'll fix this up in the next series.
