Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BD9CC6B2E
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 05:12:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE0ED6090A;
	Thu, 15 Oct 2026 05:12:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eLYdILtvh0WQ; Thu, 15 Oct 2026 05:12:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3CAD2608FC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792041176;
	b=SRsCh7sLldR8T/65TGLOPDOFjVrER4r/TPXzvdpGUxh6eRT5/8txilOg2T7sDrOEPzvH
	 4/EyAJrcPte3PSvsilxIxpoIWplUcgNBSkHJrp76ZbSAs6ZBKIocf9I9FGdud8uSI4gHS
	 QKA1Q2DiWnmNhsZzDyiKAz73l97NjaMD0GXGsgNCvMkjTCfFPsIsPl3VTj4VTFD+x5Nxo
	 xi/Krb0H5RpEFsl1/AMHLSD+M0Ir8olYBdCJfE69mp/nTpoKelz5Xari3XeUwAbn6HOKf
	 5uRFjgcAggIxEmvSgI/cwduvEPJxdZ4Eq7MOeJTPJkYx4yfvwVGrwmxmF9CQ2on+t9A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792041176;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JPH4wNxIZQpTqqP8KSMAQX1mSN9AAWlva69E5mlSvcQ=;
	b=ZTekjFA0PYjKEhP51hEXshT1vS64KfsQk0M+m3/BZ6ZJ+yITIvipjKxyg8+F29hFBned
	 SIf89FyWvX73flFPJbaTiDHDEn6PCeaCltkrCmLPzXaBkkN1iUrUYxUqe/ochW+3yEZ11
	 +7Dl+twqan14pUjuRa2w7jk7XrPJO3dBjGph2aOihldDQU+2VVDV9KgPWgOzhcv6XBF5Z
	 aG+OJb8AQuNECeu2jyDTQf6bGabQ0BHaRsPHO3UFqY1KOAPc9gzFUR62TSE0HCwmO/ob5
	 Zra/fXbowocGfLxRsj37XyMpjxBNuh8VWvbh30tpFTExILXY3tE/Zis5/fcXjZrFS8g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792041176;
	bh=JPH4wNxIZQpTqqP8KSMAQX1mSN9AAWlva69E5mlSvcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OO9rMvNVAxbcUYiz0aHwEu2qhxJP2kE22MnDkBb8/Hza2dRHUl3xgVXARUCLqBYO8
	 n0XQRZyuTZOUGFPk06ece19TWKd8b9stroiU0UmQQYXG2yuTePRQS3uLl7rJRyqgei
	 P92WxbEk++Oxf6eOjBdECvBneawLyIrR1IvYOYZg+Gf9Y++QbdWZ8HQ8jt0OPXK2SE
	 pLExbUnx+fVAY/zYN1r5mpYqBqwdCDJqrTi+yMPMRqraoKxJ+fkGGXfOWb4kny1PGR
	 oIVR05xHTfwS6BiEgJ+Ircomw7L+3PJxf7/JJiqqcks77WWEyR6Sejl8OdugH3NBJc
	 wPHh8DVT1XseQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3CAD2608FC;
	Thu, 15 Oct 2026 05:12:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E64BB2E0
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 05:12:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CC40D40807
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 05:12:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tZ59H_aGxluT for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 05:12:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1C71F407E7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792041174;
 b=gbhpSnMY5/biYcbh8inoEJJkZcYnMmKV2oVT5CoxJrAzv9uIKBsUTuw7lHVN0y4TKMs8
 vo6QXmbZNmQKlZigdPvyKV56n0pbQh0OuEyfbAtcUOtug8wtuw3G8/12QRHSnRRVSOCOO
 L+ydsmyYC3zVGG7G/y/wU6A3GWM5i28HWEXsqvZmei73S6bBasQCIaAChOy+CNXzcRrpH
 L7+mvJwOgKbpWp8wDhQxxwmkcPX4uiwg4QTxx9Ym2K2aTBhGQVkK5Oj2lR2E9wb1jbB1j
 1RCTsutyHL1ap1lx5gi7AkTHtLhoAM4XTNg0SU9k11a/ELCRHsrc2Th4lvGHyEpR/Gw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792041174;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=JPH4wNxIZQpTqqP8KSMAQX1mSN9AAWlva69E5mlSvcQ=;
 b=afyuefg+f0WHmC/ECJpLiuXReyxw4gK9CA/3rZIUgsX7YVfAzne5Wx+STuQ0BHDeg/a6
 P3CWI5sAVrjwIIG34EDiefxVzMPTgBNARTjvgUi2dHa/mENS/RB6rahGPFyaP8ivgEwgm
 QIOHGZp5rEG10NGm1S5xrlVo3yJ1NFpZ4ZNXB8USQ7KWFwgify2F5qHGhCTjA3LfIE1JA
 Ds5lyM0esJoda7DW7R9qZh3ves6czVE5Pg3WmWf51ry81qr0ONAAhIXW2JoVaLj91T9+W
 kgzo4mBW6crzwOT8rvxs08xZxGsfFeImhtUSFLhuMsi676ZZ8Br7oURToZ4twoA8RKA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=lXIBqVNf; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=iJCZYXie; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=lXIBqVNf; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=iJCZYXie
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1C71F407E7
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 05:12:53 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F1ObOl1707231
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 05:12:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=JPH4wNxIZQpTqqP8KSMAQX1m
 SN9AAWlva69E5mlSvcQ=; b=lXIBqVNfHNOuVM8kVMRBQUULim9fmlbWRryaJRjo
 kdTnKQp8qYyWjy6vk+Xq0bjcw4Uqi3WD0oBsWXpQAPNyrHI9GyCv+5X5wEAE3kxu
 Rf8wOO1CLgqmnNzBuQTRSvahNXNvwSt/yDqXY+TygV0vp7iGdz/K73eyv3qc3zIS
 4LjNgjuUwemZG+jBRgrIKSumPw5qfccBkaZQuW8ZsZ98oA4n6fbNaCjhF5a2VGXX
 a/RmtErAXokJDM7hEbbFzyV3tgnfBItgl69cJmNZ+nvkwijlI1tcJNqw0ZP4xiDZ
 coJaTKexKRQVvzFG4isAejHqlD1knAtofqOuUgKEm1ByAw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4han54rqjr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 05:12:52 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35c902e0da2so2176626eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 22:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792041171; x=1792645971;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JPH4wNxIZQpTqqP8KSMAQX1mSN9AAWlva69E5mlSvcQ=;
 b=iJCZYXiezlA/2poN58V1xr/AhFQmgtZeoO6z5A8OV7trytLY6cxESOY2PrLZL3ov2O
 AtzY/3qYMrCRQgc2CPo9Re2RMkALEEOV6pJrquQ39zOcfHewaExP2/LViB/ilurXbics
 gFY+nQU4p77PuavUlaiLqPyX2hRwvag75ytpGPoJUV0Pj5Zpp5s7me6S9UGXsmWfDq+c
 XCCIa5uleS1VNIWI9oWFOT0zY1FAEmKdfGopsX8m//QuL8NdVgAd+q0cp8wOXWk8XLMz
 nSA7jdL+sKSWvDtnTE23AncTRx2PvraTEjbXnH7vSZ7dVIIjgdpmIAuLDcMqDNfR9PSe
 L5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792041171; x=1792645971;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JPH4wNxIZQpTqqP8KSMAQX1mSN9AAWlva69E5mlSvcQ=;
 b=GQJf+RLXjRP4oqodFPtc3u1JHKp7Y8kHvryxeUQLWDCgvx5U+Q/UACsM9E0ZIG940Q
 hhU01LN8CR62TS36UurRNkyLXdtXfAT/nQHF3zFl1HvhpICuxLCHjawrgGcuDHsQn12l
 ggWm4eENqX6Z/AEHlEGRbnOxic7whqZ1Dzfhb7CgzGG/xIl5QayOxx/GWgnZfgH9ArNT
 NEcYSCOahcGaVzMIP9dkZWXCIIDz/af0v+ezN0TqkxF0NVm/LWnsJGeNyx/LNItERf1M
 A0W8cE3ZIYp4vBWBVe6WuvFz06h8s7UkAKy4kqFwpYOG835QD8qOly1guX0mu1/ASoqO
 KKUw==
X-Forwarded-Encrypted: i=1;
 AKwUvByA+QTGYiWJWLJdOLAb8mB6XMVETZ2+vn1YDBhsn/FSye3INL1fmSKxSD3T/ijPhCOXy+eq5H0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJam9KX+WIw/gMHtelVn6wvZjRwY6OSuLjbXBRO9qiO32m30uMH
 eJ14D5X3q+fdOnPXpIJ+HX2roRSM9FDeDwrz9ULiZDz3ODYuqC5TxT/CqR6sO6Gl/lnpaC67YEU
 zMX23Q8GKs5ZxQIBvVIrErQWtN0UceotaghT69waCy9msARRxWOfCWhaKMq4I2Ftdvp3hP+E=
X-Gm-Gg: AYBFou2FD7rL/QbBOut55jYPcdJb9s/FZ+OfBi2wKe9romVpkWpTO9lt1I79MycAe6A
 ZMLzA9yynS8PD5PU743yrwM/te657PeSYmWfcGFYGwQ6tuBXH0D13jAunzCd8CQPxXFv5jacyvG
 DVoxgXIPvsYB0ueV4czrkcOGqurx/rc8HsXBKxeHp+dMPOQQtCMFcogAUosCDPZeMDihXbuCh2Z
 rXRAzoUBMMhcOccseyMh0EWA9vNAu3nhYueJqq6oKCZP1xOfWLDJlx8xDv+RCdRZ//v7w33TCSM
 hOlgC/cvXNUw6p7U6nE9wF5wyahhFZf1VeQGiuYhEEz027Phu7BXzKtBo6fVaka7/qTG3JNpMsr
 T6kvkKw8LgkfcDYJtQMpWuKuaSJ0MjtJiIZbRvp2yigGZgE09KOPriyDzMYefaYnWm5RqbSHxmJ
 gEYa2X+64TRXfwu9vVLSqGyEDEJlNS2w==
X-Received: by 2002:a05:7022:3b8e:b0:166:fc9a:11b3 with SMTP id
 a92af1059eb24-16a1206fed8mr25523559c88.12.1792041171401; 
 Wed, 14 Oct 2026 22:12:51 -0700 (PDT)
X-Received: by 2002:a05:7022:3b8e:b0:166:fc9a:11b3 with SMTP id
 a92af1059eb24-16a1206fed8mr25523524c88.12.1792041170846; 
 Wed, 14 Oct 2026 22:12:50 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a6021e49sm53004988c88.20.2026.10.14.22.12.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 22:12:50 -0700 (PDT)
Date: Thu, 15 Oct 2026 10:42:42 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Abhilash V <abhilash.v@oss.qualcomm.com>
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 kr.sowmiya@oss.qualcomm.com, sjg@chromium.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v1 2/2] mach-snapdragon: Kconfig: add CDT configs
Message-ID: <atBgyv6nTHHPNw6I@hu-varada-blr.qualcomm.com>
References: <20261014125125.711084-1-abhilash.v@oss.qualcomm.com>
 <20261014125125.711084-3-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014125125.711084-3-abhilash.v@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=RYQFmFtv c=1 sm=1 tr=0 ts=6ad060d4 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=hIPwaaXcspeaKeo_OuYA:9 a=CjuIK1q_8ugA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAyMCBTYWx0ZWRfXwPAzLBzi2XRj
 4XhJkB+dRC6RcE1rKGmNHG1JsaDXWUbBbtDBNGrx6gPIItyIeUoICHgAa8UAaJsbG53VmMvhSdv
 qlYc1OgKfBJK1MIjJMI6cqPnyp+hukeN1kxW8N5TCmHp28Lw1MknwUqeMuaJ9SiFnNUm2jR/A3k
 hYNJlY4Yujb2nTFMBUy+T36ho+jOTFf1tRLA/wuY69IABvSe7wExeipKSdv4swpVV8rVGG1FaZv
 oY60mwepRXJTlCjBvevdrXYCW7CkJU7AAZozH1V3S9ZmEv+xFYLTzBRAtapHuDv4GmTiENmX3vF
 gLj6AQxmp0PCwiQuKAflGdIL0y5aTChp3xwYV/K8IRnfTy4uG2gkKMGBXNSi16WpBagr3RfLbTQ
 p2LsL406XkOIVVms9h2/V0LFrwt3ssSCKF27eRFYHGCgweY3RrTIyfQaM1wPaYBCx01vbCLsKb8
 ZIYrALmPz4vCOFF1cYg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAyMCBTYWx0ZWRfX0pgEReQbQ3/R
 JAa0IU5J2drOhBiJf18miqnLEgEwe+80B3k3WPcqvq8ZVu4QYTL4wTy2KZLfrTG1L/ULRkiXNkA
 lN7yzir1jKotSIUgszi5OlXGAI24Te0=
X-Proofpoint-GUID: pGHiIV_ZLlpXDU7fYNy3LujoU5x8MmON
X-Proofpoint-ORIG-GUID: pGHiIV_ZLlpXDU7fYNy3LujoU5x8MmON
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150020
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

On Wed, Oct 14, 2026 at 05:51:25AM -0700, Abhilash V wrote:
> From: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
>
> Added CDT related config definition as part of feature enablement.
>
> Signed-off-by: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>

Add your Signed-off-by.

> ---
>  arch/arm/mach-snapdragon/Kconfig | 72 ++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
[...]
