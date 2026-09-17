Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D48C982D0
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 07:15:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D677480E2A;
	Thu, 17 Sep 2026 07:15:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zQasLorAVdLo; Thu, 17 Sep 2026 07:15:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2615080E19
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789629327;
	b=aEJdAwkK+IaV75GvBTGRY5usBKTPyUT3Ku27H37kbT6uELJVvvzxXUyoDDZGIkNW9BTy
	 cePaluyvYpKrJvvesqs6pXe1YOgE6L7w5ffjEok2TpLcrVoPoURdhRRZb1EzKVVGbRcQH
	 UrE4MmYZmu79evXC+kf/c4JwVNf3HxztmxYz1j5uwQX7hUiVhC8J3sHgugmm5etGfs/S/
	 3ODrK/qkdlBB84H5dQAptgxjyT3ZxyNVT1lqDsOrkX8/eUbY9PgriTz3ptn78jpcrHs4T
	 GqSo9eoh3X6f1/6Op+BAHDOWJ8iPx+9g4F8DeeeQ67vgypFjC/46NN/+c/JYwSIhEJg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789629327;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=;
	b=i0s6MOJlr1yz+0Sc4NtHJAZxOatswmYittmOowyMDnhjtjORz3K8TmIRyK65SZJ0jE3b
	 PTjnAxiqFWK3PiGUuwXoR+ch0KrYHV9I8l9EzEIRSJcfcsPycTJO2MgrchvFrwXw0A4HT
	 qCuoYvW6lO8YrFDUlYifW3p6TIFGOLJNcJIMFAuG0N+99PamfIQszdKkSzn9Wt3WFu7EL
	 u9MhAb7X6qVkc8Xt8YZWRbhbtD17czhfa4bWk9T6HCb3cbjlXnl7XefD8ckRa/yxrVSBo
	 Ynazc/l4Q5W2vcHxzQhgsYNyxZS+pfr3vkY3VThKLihC/8yXcoON6f5qGA6+FJLba7Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789629327;
	bh=uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KI1DDP7u8GS9E0HhA2SxdFY0eEp/Hsu9jSPxp/GHAj90Pp577QgJZR+CxhoA92EKD
	 OB4JBZyPLbekQ+CwQsIG204jPVcH++Wfeji2iND5BWRwJPYyDYe2HJ+NM6HQXqK3tF
	 CczBXWg7YdB7x+lMHiasUn9t2m8ufoZaK5bPUs4IBaD1hl4TmcGQGKWz7FeyCQizBT
	 AGyDgqapqkl9s7Xl3PGB5nskY0HITBJ43QEm4PpAIBSwPU2vKILqq5YKGyXeQJT+vc
	 XtudbE4GBp2nN8lO1LfXncf+MKZeM77z6RWg+H85Hx6E0q4ENnf9226XWx8ArLcQwf
	 Ogdx0+UQQ8a+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2615080E19;
	Thu, 17 Sep 2026 07:15:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 13CAE43A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:15:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EE936400AD
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:15:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xeP3VYGDaVgl for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 07:15:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 43EDB4005F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789629325;
 b=PSzi3dAXZhsz2kYm3Yxmfq+g/gPPTSZ00g1/gj6LeL2x5/atKoVQosC5kOsGvn3QBJyN
 fg14roplETkT5+6HGCdGvUvEG706GTgBHyLKJswXWyy7aFNE62N8JQx2ugNstDUSJsr8N
 wTERXmFn8aGsipzTnTgSj8nkzcP3OnmYareOFfXZX5JXECFNfkvEFc3IK+Lpaxz+wCs0M
 sI2GKjGL56vceamxgkkwoQryPueApeyb00tzOrGri5jJOzwUEW5vhjH19OwPPh1OtBC0N
 C9R9QTUMZgV4dTSg15MLOY01Pk/ijPPf1dCWrDyYpcMl7gqdrZE9Hh+Zpgkxod70/Hw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789629325;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=;
 b=VrqVyO1KJ+vCIDpnlFnjNG6E9SNdKd+7f0DNkexFRro/oegMJ5C4y7paOICjW7FQZlUi
 LLFebSPbmlJJyaQ5ES36Ba6QajmNBcuXxnrb/KMzDMYQPvjZ8xy8dIk+Phl09keFQA3zM
 1VylJxzAnRMJMNPKeP3P1khoKTzFJQTAFGdD6YADK7PfAvK3xAvXZ4iG9r9YRPkiMtYtT
 WR0BunWsvpDKwdhK5+3SfSNndlViOXedrmNhmQqBfdBLq4Ya+XIn45s0qqo5c+SjSUoR6
 Y5NzLuir+R+pc3A7OkE12Qfe3URK9lJQG4dKUs2ao+2Y5E3CsAO6sUlworhzsnL/+ew==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=h9ooSj7d; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VFrJmGPw; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=h9ooSj7d; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VFrJmGPw
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 43EDB4005F
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:15:24 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60tJd1031732
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=; b=h9ooSj7dElyjyHKi
 O5KVtiaEfxwrmmA6b1UOPrWWngqL+kJZY5U+0RRDYfia0JxxeUoufn2XNDXSxWGs
 +1kd+jg/iQCaXg+xBIsXG0vanBsxnakLdn4SLS3UkJbC6SmgkV43hW9upfMQStdk
 rxjY10v52r/7yeiptw7bA/twVPeJG0RIj3sGgubLUxPVn50JJOBhL3Rt9QTVHDsG
 9PI/SV7b9qoG43XoeOUtVD9R8gYR9IMzHOuRyZEKlvv8iyQ/ci+gVKnOX9nouSDC
 6lV0EDWQ5ptr2J2K1rZs5tOajVGcLMeg8jFy6ymxVkgL4H8vIl7Zd5D/SqnwiPIM
 9rar2g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqy7hay86-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:15:23 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-396901263b6so1068273a91.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 00:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789629322; x=1790234122;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=;
 b=VFrJmGPw7xx8qDDOWEoZobk/PCJH6aJgilAWF2DkIfo4TL4fyoQPHKBuIn7M8vQpvG
 gGFzTUFe76gi+gnaW/FH+cSS38+irQT3niZevuV8wOp1JSJ1L5ekIgxKtahT8Zr1k9nP
 Dx1O8PIDEznLsFOfFWozOLjTLUE5kVWNaCl2YCVvX0Hv6MHvCuQBZcmlj6a/BkMPkye7
 Ep1LK06sUFtc6+71yQbk9a/mDCRhvTTVwhTq9IXv0dE/FIg+8xbDFpLrQE4Qrqd2Gy5l
 +GXJMsrK7v3R7gkXqYUjSU1yg8VmXqiCeB8fy6qhXTu+dcSxDqb0GbOWIcLttvB9iqMZ
 vdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789629322; x=1790234122;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=;
 b=VSwEnJJXiSgbnUEjRadeL8nv2fYARSuewFphFo3gCyBVOWSJW1NvXG+XqV/Uhbfc9I
 hW6jQRxszMGsJIhCmRe5FP4VeqndrjcHyhBWxL/nRO16Aa+q3vmEPs2HkGSWPQs4jxfy
 /r71vNF2ttrgR+toOl0Mogn9XxEdMhQZyp9zRb0FGISrF5u3QrwFrTq04jkhvfZ1AOTs
 hnl6WACmsgBBULq8sZTMp0Knz4mXNZIujv43WW/3Yx/KUlv/HmMU/Y/iFMB+LHD+fpC2
 n5Rrr9YhXje6L0WpYAjmGd/u6iVE3EsdHtm6boMkLkuI8mWaX4pWPUU8QY4S5VBQXJfF
 85jw==
X-Forwarded-Encrypted: i=1;
 AKwUvByl1EqgJTrFnygFKuGFQzKGlE9nWBBzbOTxSVAvSfsAD9BE1JZUOoqcFbORM+erBEC1IRn2tmU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kGjIE2P8Pu8tU9Fm/Myx+NOmnnfTi4Bt3ibg8jGrcGk25FQN3n
 owXb/CIfXwV5GVJ2tYygknqJEvaln/yRUxXUEiTNSj6Z0Q2/3G0p1dBS/khY+QN766TN5a8rD87
 YoRc+pwBp5bPoJNWr85ibHPbnSiFyf83Ri6xUZ+10usm8JDUgP+DNwmmImQ7EwXs/3Nxb3HfrsF
 qRdlE=
X-Gm-Gg: AYBFou2thhcgRj7RKJLa2gXB+3uaJCRrumbBLTcndDyl/Ywg2fOvTnH+YJP7hkSdEM+
 65/mlLZzgDuOsFBcSqEK2XunNsy1mCfucK3rOU3D8E8h/n1Fi1AAATBMV5pg1zetiWbLgXdroxh
 9kkgWGxZIPDmAfNgSN+VRBLFTakofZpd84mjtd0WJ5uu4/AO99Mf1IrEge3H072bEXH9Q3OMfsW
 XfKTWOxtogyC2fIDVYLsCpP/twk/syZcFL6OBd+/+ZAv8INcRHSBqZEYQ9wzBqNEZSQwlFN64v4
 J9GetV0N22AQOBh77tkY9SjeJb5T1a/80XN2mShVHzCxl5uF/joDz5sHjff+gn/OYKGX7tjbGi1
 feIYxmVtA1ESoDTC1QBsj4vCks8xkUagJ1MKTk/Jc+ABHUHxiiI6w/ZX3faHqLF0YDLtomDx6wo
 Fp39QACIJUL/ReAs2RoHshULKsUKqgpQ==
X-Received: by 2002:a17:90b:3bc8:b0:398:dcfe:968e with SMTP id
 98e67ed59e1d1-39e1e504f3fmr19281091a91.20.1789629322367; 
 Thu, 17 Sep 2026 00:15:22 -0700 (PDT)
X-Received: by 2002:a17:90b:3bc8:b0:398:dcfe:968e with SMTP id
 98e67ed59e1d1-39e1e504f3fmr19280987a91.20.1789629321936; 
 Thu, 17 Sep 2026 00:15:21 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13ee7sm12175810c88.8.2026.09.17.00.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:15:21 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 12:45:07 +0530
Subject: [PATCH v3 1/4] tools: qcom: mkmbn: Fix ipq5424 MBN version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-ipq5210-v3-1-d11dc3e8b16e@oss.qualcomm.com>
References: <20260917-ipq5210-v3-0-d11dc3e8b16e@oss.qualcomm.com>
In-Reply-To: <20260917-ipq5210-v3-0-d11dc3e8b16e@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA5NiBTYWx0ZWRfX25sHqnAXLjL3
 C6f5Q5wki/NNiW3ztfw8uwLct7KyzDrsUay/MpsD4V6J57hxS/OtPeQu27qfnW2ZL9bfz5CAR4k
 mu40XeGBJdCl1ejEGI/y5+eg68eQEMC2z6kJFADae4hCvK1cXcBn0HY6MiA1/IyLuzF5uqXd7me
 X7hUxlLludmqB4Jok06qA+cxjJaMwAwu9KpSjr/WPqpdwGhHpsB4E49sBuLO2FjTJ9viPvdOCym
 Mt7ufhhHpwZTIgV7xJs5X88lacybuygJGgzUAFryo81lLI7hsGm2fkKf60/2ueJSah5bAIkfqLT
 3f36M48J0kN2HcZT9amxcRZe45RSAJ6fXhisyAZIzbc3tRbrjOVTqDAps16Gy8b1cMP2XfR4y8L
 h1dM0sIFK+B9TE7AWL2/hqzYTnpi5/rMLHQRjFAJ6MmIMjvZDyhRp3G+kafn1j6uhYIrbhkQMTv
 V5Rn0wl9TqQ/qqMT1zQ==
X-Authority-Analysis: v=2.4 cv=L8aI0OT8 c=1 sm=1 tr=0 ts=6aab938b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=5oOYJkjiZhHqBJ3UFLIA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: Mo91hHrStX7u_AqoQ0qI4NYe19s0sLUu
X-Proofpoint-ORIG-GUID: Mo91hHrStX7u_AqoQ0qI4NYe19s0sLUu
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA5NiBTYWx0ZWRfX7PoOaggdcVpX
 ZKv8gKuguwhEISUlIwZeBFeX3+jcxlyA+KD+oRsrkMf88k0H2V5HdS8gQ8Q6cfexSiUl+zh/IFE
 DVJXTNKQH8ChruvLBmbgH5gfdnB8RnE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170096
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

Since ipq5424 uses MBN version 7, update the ipq5424 entry in the 'boards'
table accordingly.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 tools/qcom/mkmbn/mkmbn.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/qcom/mkmbn/mkmbn.py b/tools/qcom/mkmbn/mkmbn.py
index e4484b539b0..8d2078acc30 100755
--- a/tools/qcom/mkmbn/mkmbn.py
+++ b/tools/qcom/mkmbn/mkmbn.py
@@ -85,7 +85,7 @@ boards: dict[bytes, MbnData] = {
     b"qcom,sm8550\0": MbnData(0xA7000000, 7, SwId.uefi),  # C8550
     b"qcom,sm8650\0": MbnData(0xA7000000, 7, SwId.uefi),  # SM8650
     b"qcom,qcs615\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
-    b"qcom,ipq5424\0": MbnData(0x8a380000, 6, SwId.aboot),
+    b"qcom,ipq5424\0": MbnData(0x8a380000, 7, SwId.aboot),
     b"qcom,ipq9574\0": MbnData(0x4A240000, 6, SwId.aboot),
 
     # msm8916/apq8016 has an "aboot" partition but the process is the same

-- 
2.34.1

