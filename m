Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A1AC982CD
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 07:15:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5FCE80E25;
	Thu, 17 Sep 2026 07:15:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Vic3SFOiC-b; Thu, 17 Sep 2026 07:15:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1D75680EDC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789629336;
	b=cm3LVojnR/QDsKCA+FjjtneKfm5jfGpyK/1CLmWr8GE7yPZIsVSG9hfbqVB1E4GM1+N7
	 Iutm4Y/p8LYA8KpCd8DkveIxOQAwsDtbJslUhlVpyw2vzrX7kCML+yPBEKnXW7Fn6jnGs
	 nGydFBeUZ5+edkZ/5pGIBUfwHmSHVWslpZL7315Cha6OkSaSWWoJDTgL/uXro6Uf5pmek
	 ITZjNuMLXSp+ETAnuQQQ2j6jxsB2i21S+9EHzUCg5aKN2iMtOvrrsQSIsgh3ly1vF4SJu
	 1dkEBHJJJDbvd6cjyFTez+G8rOZ4NVM/FZf9eqWN2p8IEoOc5eRO0epCwYSlRReU7EA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789629336;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=pZJRS6XDMtAvRF/EukerNef0fSgcbR+HdXlJ4+U9nDo=;
	b=FMrCDGtskTJvgBEe5owEmiWOjWU+ue0QjZUEyZi4onm0pjprEYcgjCEUE7Tp3HuBYkXG
	 Ajfv13qsCJxTYtr4mSmobZJHa2dVVNe5O+MMqN/Q7PPbCLGn9fDc2kEB2ShZI3i9tDhmV
	 MptHBv9/W541o9H9JtzgV8ywceC0bAgeMk6h2oGY8MublxGYCO0zlWcbEAHvu8qjA8A3u
	 2TMEIFmk0LbpSshDJxCyvZfb7HL1nM8+sO5CiLrFPsRaS+9kEXGNZVMVij/zrwP+eb50T
	 i3XqpIVjszXwes2UijyiPEF50hzpiHiYzy6br2UslUvPSs+ofrBISS2bRa/55FqoZ/A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789629336;
	bh=pZJRS6XDMtAvRF/EukerNef0fSgcbR+HdXlJ4+U9nDo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HXcVrqxyqNiD/+u6TdY7EBgJa80X5xYK1OnO942ilEwvQgluNu/vdDt6giKaIJp7t
	 ZeWX+7z3+aaKb/jglJ9BThlR1myV0N0Jk8XocbKJU5w+8gLpYh/cdfrwftTMQVsIZH
	 AEITgUF5pIvroNGuLFTJzSAypG2L8dOxew1VEjbde2BD85kgw4Od7DMmjsof0QA2ec
	 HiIQcG8bwgaOi3SaFFAnYDAZI95+3+CFm9hjc/BFHnGDFu/oLnWO4BkGPUBi4GVR/k
	 Le0NH9CVF/EeLzzVSQK5O80IH1ETut5I+TLLc4fhHCALTErJ5L2dvcI6IWKrC0WBPp
	 xtLud1hxSH9fA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D75680EDC;
	Thu, 17 Sep 2026 07:15:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 17A0437A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:15:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F21006061C
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:15:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a1XveUj6WRX6 for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 07:15:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4E7BD60822
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789629334;
 b=T9mCSiAKHigVAcIE1QQsbsNK40oUr2bjdtjqKamk7i0s56pMes6rSjRZmjjN3VxxiqXD
 UsuK8bcedieabjykd+cdVZ2BmVC2IRKweVDr44qssSAxXhNE08RKI+6fMKkdtIW2ORngW
 HVE2y4BdnYmrEo6+H3/ipWHZlXpKX6zn/zPAuqvhiZfuKviL+tDSG5AjqTRRoYnYv2KYw
 XsVSK0sTlwgpzbc0rg2wcAFVKK+O5pb7zTcp3ZtMEgI9PDs6z6Bbo9nsd/Ftm8dHyjrKi
 zAtvKXc2ZTZV1b1GU3y+jSarnoWxj/9HyR9orViytiNb8mbZRxjNZBL/RK0Byn0hJNA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789629334;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=pZJRS6XDMtAvRF/EukerNef0fSgcbR+HdXlJ4+U9nDo=;
 b=JMAnLJJdKDfrBgk9YwHjp8aCARDy2rRNkm9PuZEyLvl4lj8u6t6uw2Mizu9db+nCJOu4
 5IThEfxT5N11ux5p+RscmRxAR2BeDoSHYOjhSMLkqA9JxGDDHglk0niZvghBFLBs9bfdS
 1G/RpJ1/w6gnGDz1FgSEVvKhAWWAX3SRGoq4tXIY3LgKlpXmmU8ljJCATQKwULCSC1GFT
 cN2actHKM62aPRDDn+xaZ6yEaER43o3xBsPHeXQB9rFtNr/ZHOzZ+W4yyXHMI3Nx+X7/m
 mjIA3JrCBBTt4ucEVQrFhgwLpODn2TxgUiqTjp0Due+exrWwbwP3UU+jrWH3j3G1vBw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=L0IE4jY3; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gT69GTEu; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=L0IE4jY3; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gT69GTEu
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4E7BD60822
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:15:33 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60vRX902044
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pZJRS6XDMtAvRF/EukerNef0fSgcbR+HdXlJ4+U9nDo=; b=L0IE4jY3+dBM7U9G
 rPuU+lWz5cf/MwBavBtJp9HfhOJy6FlQh+H0BlTtJvmGOcl/1z8kFrMtddSZwO8h
 86dED9j4ptUISft627XaB8fLlVti+cnM+RSLe3omcZYZVx+RbVmVJ63J0mtdJZHQ
 yRf/MRzZZavzCgAje1fo+uOfrkrInrSij2USs3kLnRAS4CouODYJW6vAXXlcF2t0
 IjQH5cmPnVTRLaSDSEEAcXlhUO93W9Muk14oEBBETfX/TVz4zNXfdvEajj0yl/xa
 dK7NXPwCn+6KF56VD2QyFYDAn/Z/wu83S+Z5RnaiTWE4dREln0QO6fIkuIVRBxZN
 HbBDeQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqy2d33vu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:15:33 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39e3dad7ab3so486528a91.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 00:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789629332; x=1790234132;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pZJRS6XDMtAvRF/EukerNef0fSgcbR+HdXlJ4+U9nDo=;
 b=gT69GTEu8pMyQNrdG+h1+HhPv5KW1aFTK6vQXXy66eQgFCXmSiF+UHyH70l8PkTGjF
 xFQWKMXzt3SCeefNjrfuQKSkqmhWr0MHHVD64CZbeMfLPC28rRPM+izBrl5XIp9FgSEL
 gOLDQItQpTTnhOU29cvt4dybam0HON8MwJSdLpvmMSRPwMneobjLZORyVuMK7VsIMPPW
 wL4mD3iMSayOq3smIL0gkZhKwWeBMJVh1FL57X748YbtbEC2+HGP0zdM5jyWvHReO+ma
 RHRu0uyoABu0d8Jd4VcT75jQvKhvFNTUpfKLkcxDM4VJyMuFQ+qY9S6wtEK3ZoTnS4yW
 x8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789629332; x=1790234132;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pZJRS6XDMtAvRF/EukerNef0fSgcbR+HdXlJ4+U9nDo=;
 b=YcLObYUpuryRax/SndYqRn1l2ifn1Qg6OCybmz63OR0/x5sliWg22ogNt+CA6S+BQP
 SU/5MwhSln2WqPRQ2eWRbFNG2th8M4m9VV4yPFRvl8zBOty8sY6x5G75jf7kdzYuU/Uh
 Do06qRpRBXnsbauXs6EVmjP1sy36Kz51pL8g3hrZ2epKdVdHIABMVxGQD2NzcnqSDvPP
 VAikeSjTsNwZ17qP/vAF9c+Qd+YwJMSrSW9460vfYw4XOYGBlUSUZqZgSKPkjBIs93is
 Q+d3OUxyBKK1CXrP99cZvQTJ0yj1H0sjs/sVrHvyiiBH70Pkpdr/D6DFZBLNx/WQvLfj
 288g==
X-Forwarded-Encrypted: i=1;
 AKwUvByA0dyGJWbf1bM5RjlFsdXYBraO3cAQjtULs2lrwDlxuS8ApvtRHmxWv4TqV5v8SFVqPPeFS+g=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nkblZKFH5AbbDAYhcfYa8tGegBxHvsHw5dwnoiw0zsktnmO7HD
 wdfiNI3UlBY2WGtuyeoC7rcq8XmZZYz0C+TfGHLHqo2nPduQiSEQY5cPhAOmj6d0GqXZKTCE7hX
 f5IgUjh7vTUv7YdPhR62RbtU+bmIiVe1cQ5U/tZQ7w7zs03VbQkkQVCBavdXFjS/PRX8b/+V8r1
 dQai4=
X-Gm-Gg: AYBFou3LccQc+ekMmV9NOcqhxR18VpfzJLdRCT3sdJ4pcW2DsX+KVT9lMLWCkJhlHtK
 seD6547+0z6pHkiwAYISwZPv7i0SQPi+1cUmy+t/L03CQABFrbXi4mi+tgaylCzyxjVkr3tAtaa
 mJzZowcmmWwTHMKX8DMpp3uuudeMqOuB1GAQlNvHY99/XRtmGWNB6vlnHuMEgopKXuGro5S01ur
 oe+4VuY1X6P+aAgSc5Bv7tNsDqXTPEIPiPHKEVYnLLZrJsdnbgfI0RuChKrM7qiHRJbPPw4skXn
 6zrfq4Y6+RsQ6yu6cogbZelC8EGpqRdbkxNbl6+BClyOxH4CcoyFZ/ehTwye3p2YhrWwQJ9La6s
 UpkHuPtH/07i2ppX4j5jrjTxc5j7wwTe0+qf3hXvhKCrB8WpUYUE2sJLwwBMhNSIA5CY0+JSXfJ
 nMMzWrdtHsEO+tyKzFDoDuD4PQSGcpCg==
X-Received: by 2002:a17:90b:280a:b0:39d:fcbe:fdcf with SMTP id
 98e67ed59e1d1-39e1e2659a8mr13820953a91.1.1789629332524; 
 Thu, 17 Sep 2026 00:15:32 -0700 (PDT)
X-Received: by 2002:a17:90b:280a:b0:39d:fcbe:fdcf with SMTP id
 98e67ed59e1d1-39e1e2659a8mr13820879a91.1.1789629332036; 
 Thu, 17 Sep 2026 00:15:32 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13ee7sm12175810c88.8.2026.09.17.00.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:15:31 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 12:45:10 +0530
Subject: [PATCH v3 4/4] tools: qcom: mkmbn: Add support to create multi-elf
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-ipq5210-v3-4-d11dc3e8b16e@oss.qualcomm.com>
References: <20260917-ipq5210-v3-0-d11dc3e8b16e@oss.qualcomm.com>
In-Reply-To: <20260917-ipq5210-v3-0-d11dc3e8b16e@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: 2xePx1185LGpjXs-Fv91KKqvxteFPHZo
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA5NiBTYWx0ZWRfX/t8pCS3TvRO/
 hfcZjzYjjii5JoU+k4McLTKlSNvNSg2o79xmxGMEvxZYuVqA+fhOWS152bMQ3n2ncx4fKb4OFo9
 jK0x2XaX7GX+R3KfUvFj84YfXVvzlmA=
X-Authority-Analysis: v=2.4 cv=HbeB3SE8 c=1 sm=1 tr=0 ts=6aab9395 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=S3gQTLpqa8hfpVGigeQA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 2xePx1185LGpjXs-Fv91KKqvxteFPHZo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA5NiBTYWx0ZWRfX/Sw11YPM0aDx
 +MPprol/EOcdv3CG1qvjmo8jMOjEXu4YVqmlZpjIQ1CfnCrBSA+qjDGVpQp/jupZ9tl9Y6CdpCL
 JMJNu+pe76sc5ZrnDY1Du+Bdm6gRQ3GSG8cljy8aeeR+ub3mzs0gcB75x4Y6eO0S/qzOno1S+3e
 L0oUmt1PJrlVhhk1zbJd0h7cuLQMPPbovu8+VxjLTJI+J72D+gcaDOv3VxNNi0pKH5Fdm8BX0N2
 IhyUSGvNS7Vt2mryWmL/lHBTcf1inCumjE+3nCfRNn4MzvepC8oRPetBQJbJfBHviyU7n2ppCyR
 eGF4Z8CLG6MmiefI7UrUE4UB/KhSK7hZJrMzx3uWbT9CWzyipI91xmXVmLYU4c4aZl8Idg8mfft
 AIDRa5nZ2oKvZnMxlOBHvQpIf6HGbFHbbxuGQSnaUtbotguQML+ut8hutr8hdxBai+JkcvQEBjs
 U2JiUs7hd0eKKnhiRqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
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

Modify the 'bin' argument to take either a single file to convert to MBN, or a
list of files to be combined to create a multi-elf expected by the boot rom.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 tools/qcom/mkmbn/mkmbn.py | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/qcom/mkmbn/mkmbn.py b/tools/qcom/mkmbn/mkmbn.py
index da4d45b600a..8af268a2d8a 100755
--- a/tools/qcom/mkmbn/mkmbn.py
+++ b/tools/qcom/mkmbn/mkmbn.py
@@ -110,14 +110,32 @@ parser.add_argument(
     "-v", dest="verbose", action="store_true", default=False, help="Verbose"
 )
 parser.add_argument(
-    "bin", type=argparse.FileType("rb"), help="Binary to embed (e.g. u-boot.bin)"
+    "bin", nargs = '+', type=argparse.FileType("rb"),
+    help="One or more binaries to embed (e.g. u-boot.bin) or create multi-elf"
 )
 args = parser.parse_args()
 verbose = args.verbose
 
+if (len(args.bin) > 1):		# Create multi-elf
+    try:
+        with open(args.output, "wb") as f:
+            for path in args.bin:
+                with open(path, 'rb') as tmp:
+                    f.write(tmp.read())
+    except Exception as e:
+        print(f"Error: {e}")
+        sys.exit(1)
+
+    sys.exit(0)
+
 elf = Elf()
 
-data: bytes = args.bin.read()
+if args.bin:
+    data: bytes = args.bin[0].read()
+else:
+    print(f"Specify the binary to convert to MBN")
+    sys.exit(1)
+
 
 # dtb is at the end, so find the last match
 dtb_off = 0

-- 
2.34.1

