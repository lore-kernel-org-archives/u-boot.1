Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C00DCCA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 13:42:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7BAF9606C7;
	Fri,  9 Oct 2026 13:42:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9vEXuux6_G_b; Fri,  9 Oct 2026 13:42:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 317BA606ED
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791553336;
	b=NT9X0HoJcXMvmBY6Sj2lJI9E8xCgRtZKy4GEKCqAZFFBY2iRL/c13DzoE/Kzq5ZXW2nf
	 ZVPVZRSCfCmpvUV1Qvi3PL+11TN2yqZHuId1XyKgch462J0iFbpOOQTzkgZlKAr5l0wE9
	 ZMid4xUC8EIdrsYHcelnA5+WgwMtPISt/b949LY7anYUCis/3UafphHceAq4oDw4rqpTl
	 JFgyEh6/R3sV+Knzi8HaFOSgqB3aKsCqq+1wQ2LcoWyjSDVQr7mDuDRhLb0mBgiQc8/Ej
	 Es02xpZn9BBHTrRL4n6ID53DN5UD+rzsxWbOzZaUCeU+ZL2uNrs22/mLJFmvSDXpe6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791553336;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RQbMszSzBMKgyDzymOlNkcYFmEnUcmwYS2pYYh8vrug=;
	b=kFXxV5H8mi0aa5CsnoK7M0SVAwKHIb5eUIWRK8qkcQporHjkUtBGMlkM84zd0zUm4I7Q
	 tiOc1O3UU2zXyxC+ixHdDEEwYQ8ioXoY8OGfjOU5/g7b0/bOArhMjvwkaJpjLp90wcGv5
	 hV29XdU4JRja1+MZwpKlWjkW+dPwRw3YmXMmHt1h6TQyaLhfN/+LOsRtVhIMVr5/I2Ai6
	 L0txfjgeSgWAXqZKb6wuy4l59+R65elJ/NH1Uv1T6kDcVL/8LJNkXSh1w0pT5S0+RMlfK
	 cdbO9PBEz0fYUfJPhHhld+1f0KFP2Pc+HWFvb0G3ZgNJw2rbpQf7k2ylJSqbFK9/lyA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=POEZMosb;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RSlgA12Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791553336;
	bh=RQbMszSzBMKgyDzymOlNkcYFmEnUcmwYS2pYYh8vrug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VTXDYXA01soHV9ykltvT3A3L3AD1bBUQVoQH3ThGvDYHjGweIxlef0W4YJC1qqdZI
	 SetUnPD2ZISO29zptoohBZowrbMfhbOrkSn1WYbspu25DhS3i6emvgL4vyeOWBwl3Q
	 cn/hT2PHu3buIIgU0rU8Syif5utLxKs4qm6WoasyRaJp1C5elLsinZdqn6xCJQ5ODJ
	 sCjNa8jOPYaSKXE9Gc0+f7OajcpjzJarmuDVGwCx6rY0g5KBGdEJLkml6YpJ8Zhm5P
	 U14s4p9u8mbKGa0uMW2ARZp0XFfUkGgVo0L5qGxab5+lM3uwpEScBbZiUm6Jz2WUam
	 SoNa5l30KH7KQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 317BA606ED;
	Fri,  9 Oct 2026 13:42:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 00AB5184
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:35:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F23DB6067C
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:35:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sZdCPamScm8V for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 12:35:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B2CFD60675
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791549340;
 b=fSxKN26K7bb+mivs5EJ7bMnRpf/ZQUKhm0h2AogQ67dJ5Qn+nTWHtyZ8EsVXlGc0bcAp
 ZWpsw3Tbr1tTweYIx/yHOWcGKighuQnG3oQ0GBTFtcnDfO9xiGfKzwH0Pdi81xlhJtLfs
 nwhDjIR6Dj0vxIzVNfDJPvrV/i0JKCBsu6Zfh0gHHNlX7ryGpe7GeESLi/ajRVEbdnR+W
 KEEgeSFy2yRarbwiO1yJa/I3WjrDRISJ4n7RHuVSUJ9SvckL9lJW5TNNFvwJOAaTDBXA2
 mp30oyHNX603EVjQoUc5qFJcZ0zSQJ13AjTJTKuFrBTkpi6L56DCPckoZMLw21SxoqA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791549340;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=RQbMszSzBMKgyDzymOlNkcYFmEnUcmwYS2pYYh8vrug=;
 b=GbT58LAstW8eMeUNlqU5LEjoUXtE9ogZfJsFZ3arIydUg79Vx4pD+4vsvUWhblzXlnbg
 fXha5DSL3yuekJMvPAKAnbajP1MCt+qEvdNxO2JNBduKeGRLjvdgJzp2OgIyM9WIP0zfl
 aNvEH0lFm1ff5jio4VS8C5d/T4FskP59bXStDDMHhlhuOAPh9tt4xvQElhjItCyUlry+C
 G9JzmURZXWjwy1FKIU81kJU5OuFdZ8ih0ninPK6ip0xOx+W0dP6m/yGhnvbjp4u/B2xD3
 x8guE2rBDp2bUzU/42rw4SrCwhU3XN5Gy8JAH7ot7H5eIfVJVO5fjwYSf+AyrdNf64g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=POEZMosb; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RSlgA12Y; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abel.vesa@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=POEZMosb; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RSlgA12Y
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B2CFD60675
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:35:39 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6998KIvW1746833
 for <u-boot@lists.u-boot-project.org>; Fri, 9 Oct 2026 12:35:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=RQbMszSzBMKgyDzymOlNkcYF
 mEnUcmwYS2pYYh8vrug=; b=POEZMosbK2VczA8dOIgFV9LzHzs0foW6jpjf3USr
 OUsyQah9sSFVk3ZzFu/4VIKT4kZ4ttaUj396GHN1CXC8TlrzWU0wzOUo+AL+Cr3T
 wa4t5CXk9SdR9gFlRhMHmpquGYuccyD6mDZJOKqCukye6ymYYnJbAfay/oVWehYT
 EL05M/F+pnWhLii5IctO6XKyqXaOmA8ihuHDYOOxeVrhK83xgjtE7MK0M5fEpQDT
 TlzubkN+wtiJjfPUVYgKu8sF+K7YdPsuE270X7bG87js+Q4Z/nsTsN3y2R4vqi79
 SH1yuPBwoAiTv+jXNTD6PMFGTt6PGdvSpuu7eJXXKVQfBQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6ekvbu6w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 12:35:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cb98809caso935749385a.1
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 05:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791549337; x=1792154137;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RQbMszSzBMKgyDzymOlNkcYFmEnUcmwYS2pYYh8vrug=;
 b=RSlgA12Yc3wa0+tJJRt5XfClIXvOP2bOokl5MOltYE56VQwvMCDKQCR2YJ7OjvDmVZ
 Eenfbzp7i3O+QxCiy/E93k+oAgb9VWk1cblmhMfxzm8oqRD9RgNzHarwNjqHQ2Ksx/qq
 GEOpeySu6/fkR4IE9lCIR3Rw2oZ4cAqY4KBaHqao28ncx5tm1yJQw6rx50AlhIQYGfEz
 4OQjhP1MxL+2T+Yv3SWX/9yhF8vc6gnV6QAls25IJJH8eOyqLyT+jiEMokjrMNrKHL3o
 Rhe0cATK/Spu7tWv0JvnLpEK+ISYc2saH1Pe7nRENfdBRjtUqF0R4Gj3Q45zJcDi3OHa
 GtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791549337; x=1792154137;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RQbMszSzBMKgyDzymOlNkcYFmEnUcmwYS2pYYh8vrug=;
 b=bLhKXRFqlwUHx3WIgt9UH/QSSjZfizezNYrs439+BzQxO7CmQLaSBmpHpamvqvJIuk
 g9UeaS64OdGs6HceRFXzJFfXOXUa5+rB78gc50Ub9b1dx6AtS4typoACMvX0fxYTzEj2
 uMFlnUo9v7LNXOql91whcnw7K2BuF/Dj1yojAYfqtDXKGq9Hv+0V19l1iHEKX8USxDvo
 SJ7yaUH4saQ3WhvO3UKNWmLcJ1Ej9/MSDVq5GIhTv8027nsP5Ziv504HCQpvVgsGecAX
 Qzm8I2e3JGCRa8Nza32D0LIx/F0I3WBSpKZJh6dXfeYcz+MFGAEVE+Nq6EmCTQaHCxCI
 2YwQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxw+qsVB7tIAs/1ryZgCaaSo/5S3N2OBCGGh2rIQDj5kVlI8ALNSa6JeVn7TdNZxD9QnhjelDI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k33mHZdstBhQJtgFjDR2Av5hag6xkrlGv5xFj3FBV/WWTS5bmd
 cIQdukFu5VyfMOALYYgntj3giG3PTbFRzb9bzwp2AKngmrbTCiUEciyolreb9lPEfjmHkxHD4k2
 N+yX0KSEtt3ZbujN3GcVmy1guVivtDCzytaEGuWxg8iimjjYKGBHRc72d+oCn3evPf7JVFbsCDr
 yinoI=
X-Gm-Gg: AYBFou1Vv5tZKCs1VzbXFvwwaEWGBBnJShbETbvDTgATlwelAHKyusw5I0i4BiLki98
 DKl4NmwT2y7PxNNOm5KQnZTQTRO6vi9bwsYBQHYBPWT5AsmR/Dt1ICcVmfC5Fb0LjyFDArTaJcd
 cSlxyksVF99ruvpnyMMXL608LWwrQyGrSdZnqz524buCRomK6SoHqFi59VbtM8Ejx3aT1tnMdhC
 rLN7OAHUgILnradN0l0j7fiJ4oBEMcSYWgxKM2IyT7r5IotnQdlp6OSQ1HuMDUOmT3xqLlJfKlu
 SRzxZUyzD7uujbqlT6fFxAV94aiRJxxrMtb1CXaneJgBeB667rN83MfA7uI0psdU9fu855kl4y7
 Qg42YL3McrYUzRFU=
X-Received: by 2002:a05:620a:44c3:b0:93b:d79e:18fb with SMTP id
 af79cd13be357-93ebd4a86b8mr251554185a.62.1791549336857; 
 Fri, 09 Oct 2026 05:35:36 -0700 (PDT)
X-Received: by 2002:a05:620a:44c3:b0:93b:d79e:18fb with SMTP id
 af79cd13be357-93ebd4a86b8mr251548685a.62.1791549336114; 
 Fri, 09 Oct 2026 05:35:36 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.193])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db93d6069sm3465414f8f.0.2026.10.09.05.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 05:35:35 -0700 (PDT)
Date: Fri, 9 Oct 2026 15:35:33 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michael Srba <Michael.Srba@seznam.cz>,
 Johan Jonker <jbx6244@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Krzysztof =?utf-8?Q?Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>,
 Joy Zou <joy.zou@nxp.com>, Vincent Jardin <vjardin@free.fr>,
 Guodong Xu <guodong@riscstar.com>
Subject: Re: [PATCH 1/3] drivers: spmi: add new driver for MediaTek's SPMI PMIF
Message-ID: <4x3kicuxaha4b6rhizaokkie5uzr5d5wfoazsgj74nzm2pnbl2@qdibrrz3hpyd>
References: <20260924-mt8196-spmi-v1-0-dd2263403691@collabora.com>
 <20260924-mt8196-spmi-v1-1-dd2263403691@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924-mt8196-spmi-v1-1-dd2263403691@collabora.com>
X-Proofpoint-ORIG-GUID: rcquXXuQ_abCixnOLWrqlKtMtjlH0Zw0
X-Authority-Analysis: v=2.4 cv=csYOAF4i c=1 sm=1 tr=0 ts=6ac8df9a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=EiYrS7xXfcF7w+nkr41hpQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=QX4gbG5DAAAA:8 a=9wRRi52x1QSRyoxE9d4A:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA1MCBTYWx0ZWRfXweNVvbdzdz65
 C2QWKprk+KeS28R2v0MZG8bZHF5rqLkMyFJ+Av2s207gCqVdzMlkCrLCf2+OXQtNpXX8+0M0tb4
 0iRXivXiqpRy4teiK64RzYt094Bu6FAbAlPloKcGNu1BpU00v92DsEzd71wheEzN6T82aCKFZ3u
 qXU4Nb/ko2XRTySiJl+q+3/5KeAmL5xdjIkb/CdaLhcXtHueYRdU7DFQtoWCdWDjB1ZgEuLQaGS
 h2hkmNfVBGaSCQcgmJKzq32OFSBZKJnHGOGPOzy1SAkhkyjI5EfVfipYexBS32AjNjeA4/fk9al
 4FFwQ20rJ2urgUvjt3a/nVivELai7rAC3rgeKFn5DladWDvLIuyJqjcPHoRNuIOO7MFitqTombh
 GiLMao8miAgcIMnEdfaJ5AXUnTBaPYmHhyTU1EQ3N1X3SiHEzazxuXfL2F54aY+cM9+B5F3mYEP
 n4MMv5BPfVNeI3xYwBA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA1MCBTYWx0ZWRfXxCNMJst/xU43
 z24RFLrObwyb1HvUjyLCRD2Vt0xtkh+rMJU9OdBcJoigEWtKTdroR7okRsJilGHnPA2JxnppQ/9
 9xkV3yxqq3+MQbLfVBG0MwZgUNRaJA8=
X-Proofpoint-GUID: rcquXXuQ_abCixnOLWrqlKtMtjlH0Zw0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090050
X-Mailman-Approved-At: Fri, 09 Oct 2026 13:42:07 +0000
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

On 26-09-24 18:02:49, Arnaud Ferraris wrote:
> This driver (ported from the Linux kernel) implements 1-byte wide read
> and write operations for the SPMI-PMIF bus found on MediaTek SoCs. It
> currently supports MT8195 and MT8196.
> 
> Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
> ---
>  drivers/spmi/Kconfig         |   7 +
>  drivers/spmi/Makefile        |   1 +
>  drivers/spmi/spmi-mtk-pmif.c | 462 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 470 insertions(+)
> 
> diff --git a/drivers/spmi/Kconfig b/drivers/spmi/Kconfig
> index f8972371150..cab82e83c24 100644
> --- a/drivers/spmi/Kconfig
> +++ b/drivers/spmi/Kconfig
> @@ -27,6 +27,13 @@ config SPL_SPMI_MSM
>  	  Support SPMI bus implementation found on Qualcomm Snapdragon SoCs
>  	  in SPL.
>  
> +config SPMI_MTK_PMIF
> +	bool "Support MediaTek SPMI-PMIF bus"
> +	depends on SPMI
> +	help
> +	  Support SPMI bus implementation found on MediaTek SoCs. This
> +	  driver currently support the MT8195 and MT8196 SoCs.
> +
>  config SPMI_SANDBOX
>  	bool "Support for Sandbox SPMI bus"
>  	depends on SPMI
> diff --git a/drivers/spmi/Makefile b/drivers/spmi/Makefile
> index 8cb93c820e0..016a8e6b734 100644
> --- a/drivers/spmi/Makefile
> +++ b/drivers/spmi/Makefile
> @@ -4,4 +4,5 @@
>  
>  obj-$(CONFIG_$(PHASE_)SPMI)  += spmi-uclass.o
>  obj-$(CONFIG_$(PHASE_)SPMI_MSM) += spmi-msm.o
> +obj-$(CONFIG_SPMI_MTK_PMIF) += spmi-mtk-pmif.o
>  obj-$(CONFIG_SPMI_SANDBOX) += spmi-sandbox.o
> diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.c
> new file mode 100644
> index 00000000000..0bc8309b447
> --- /dev/null
> +++ b/drivers/spmi/spmi-mtk-pmif.c
> @@ -0,0 +1,462 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021 MediaTek Inc.
> + * Copyright (c) 2025-2026 Collabora Ltd
> + * Authors: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> + *          Arnaud Ferraris <arnaud.ferraris@collabora.com>
> + */
> +
> +#include <clk.h>
> +#include <dm.h>
> +#include <malloc.h>
> +#include <regmap.h>
> +#include <syscon.h>
> +#include <asm/io.h>
> +#include <asm/processor.h>
> +#include <linux/bitops.h>
> +#include <linux/err.h>
> +#include <linux/iopoll.h>
> +#include <linux/time.h>
> +#include <dm/device_compat.h>
> +#include <dm/device-internal.h>
> +#include <dm/devres.h>
> +#include <inttypes.h>
> +#include <spmi/spmi.h>

Do you really need all of these?

> +
> +#define SWINF_IDLE	0x00
> +#define SWINF_WFVLDCLR	0x06
> +
> +#define GET_SWINF(x)	(((x) >> 1) & 0x7)
> +
> +#define PMIF_CMD_REG_0		0
> +#define PMIF_CMD_REG		1
> +#define PMIF_CMD_EXT_REG	2
> +#define PMIF_CMD_EXT_REG_LONG	3
> +
> +#define PMIF_DELAY_US   2
> +#define PMIF_TIMEOUT_US (10 * 1000)
> +
> +#define PMIF_CHAN_OFFSET 0x5
> +
> +#define PMIF_MAX_BUSES	2
> +#define PMIF_MAX_CLKS	3
> +
> +#define SPMI_OP_ST_BUSY 1

PMIF_MAX_CLKS and SPMI_OP_ST_BUSY are unused. Same for PMIF_CMD_REG_0,
PMIF_CMD_REG and PMIF_CMD_EXT_REG above. Please drop the unused defines.

> +
> +struct ch_reg {
> +	u32 ch_sta;
> +	u32 wdata;
> +	u32 rdata;
> +	u32 ch_send;
> +	u32 ch_rdy;
> +};
> +
> +struct pmif_data {
> +	const u32	*regs;
> +	const u32	*spmimst_regs;
> +	u32	soc_chan;
> +	u8	spmi_ver;
> +	u32	num_spmi_buses;
> +};
> +
> +struct pmif_bus {
> +	void __iomem	*base;
> +	void __iomem	*spmimst_base;
> +	struct pmif *arb;
> +	struct clk_bulk clks;
> +};
> +
> +struct pmif {
> +	struct pmif_bus bus[PMIF_MAX_BUSES];
> +	struct ch_reg	chan;
> +	const struct pmif_data *data;
> +};

The bus array isn't used, since the bus instances are allocated separately
in bind(). spmi_ver and spmimst_regs also don't seem to have any users.
Can you drop the unused fields and the unused SPMI register table?

> +
> +enum pmif_regs {
> +	PMIF_INIT_DONE,
> +	PMIF_INF_EN,
> +	PMIF_ARB_EN,
> +	PMIF_CMDISSUE_EN,
> +	PMIF_TIMER_CTRL,
> +	PMIF_SPI_MODE_CTRL,
> +	PMIF_IRQ_EVENT_EN_0,
> +	PMIF_IRQ_FLAG_0,
> +	PMIF_IRQ_CLR_0,
> +	PMIF_IRQ_EVENT_EN_1,
> +	PMIF_IRQ_FLAG_1,
> +	PMIF_IRQ_CLR_1,
> +	PMIF_IRQ_EVENT_EN_2,
> +	PMIF_IRQ_FLAG_2,
> +	PMIF_IRQ_CLR_2,
> +	PMIF_IRQ_EVENT_EN_3,
> +	PMIF_IRQ_FLAG_3,
> +	PMIF_IRQ_CLR_3,
> +	PMIF_IRQ_EVENT_EN_4,
> +	PMIF_IRQ_FLAG_4,
> +	PMIF_IRQ_CLR_4,
> +	PMIF_WDT_EVENT_EN_0,
> +	PMIF_WDT_FLAG_0,
> +	PMIF_WDT_EVENT_EN_1,
> +	PMIF_WDT_FLAG_1,
> +	PMIF_SWINF_0_STA,
> +	PMIF_SWINF_0_WDATA_31_0,
> +	PMIF_SWINF_0_RDATA_31_0,
> +	PMIF_SWINF_0_ACC,
> +	PMIF_SWINF_0_VLD_CLR,
> +	PMIF_SWINF_1_STA,
> +	PMIF_SWINF_1_WDATA_31_0,
> +	PMIF_SWINF_1_RDATA_31_0,
> +	PMIF_SWINF_1_ACC,
> +	PMIF_SWINF_1_VLD_CLR,
> +	PMIF_SWINF_2_STA,
> +	PMIF_SWINF_2_WDATA_31_0,
> +	PMIF_SWINF_2_RDATA_31_0,
> +	PMIF_SWINF_2_ACC,
> +	PMIF_SWINF_2_VLD_CLR,
> +	PMIF_SWINF_3_STA,
> +	PMIF_SWINF_3_WDATA_31_0,
> +	PMIF_SWINF_3_RDATA_31_0,
> +	PMIF_SWINF_3_ACC,
> +	PMIF_SWINF_3_VLD_CLR,
> +};
> +
> +static const u32 mt8195_regs[] = {
> +	[PMIF_INIT_DONE] = 0x0000,
> +	[PMIF_INF_EN] = 0x0024,
> +	[PMIF_ARB_EN] = 0x0150,
> +	[PMIF_CMDISSUE_EN] = 0x03B8,
> +	[PMIF_TIMER_CTRL] = 0x03E4,
> +	[PMIF_SPI_MODE_CTRL] = 0x0408,
> +	[PMIF_IRQ_EVENT_EN_0] = 0x0420,
> +	[PMIF_IRQ_FLAG_0] = 0x0428,
> +	[PMIF_IRQ_CLR_0] = 0x042C,
> +	[PMIF_IRQ_EVENT_EN_1] = 0x0430,
> +	[PMIF_IRQ_FLAG_1] = 0x0438,
> +	[PMIF_IRQ_CLR_1] = 0x043C,
> +	[PMIF_IRQ_EVENT_EN_2] = 0x0440,
> +	[PMIF_IRQ_FLAG_2] = 0x0448,
> +	[PMIF_IRQ_CLR_2] = 0x044C,
> +	[PMIF_IRQ_EVENT_EN_3] = 0x0450,
> +	[PMIF_IRQ_FLAG_3] = 0x0458,
> +	[PMIF_IRQ_CLR_3] = 0x045C,
> +	[PMIF_IRQ_EVENT_EN_4] = 0x0460,
> +	[PMIF_IRQ_FLAG_4] = 0x0468,
> +	[PMIF_IRQ_CLR_4] = 0x046C,
> +	[PMIF_WDT_EVENT_EN_0] = 0x0474,
> +	[PMIF_WDT_FLAG_0] = 0x0478,
> +	[PMIF_WDT_EVENT_EN_1] = 0x047C,
> +	[PMIF_WDT_FLAG_1] = 0x0480,
> +	[PMIF_SWINF_0_ACC] = 0x0800,
> +	[PMIF_SWINF_0_WDATA_31_0] = 0x0804,
> +	[PMIF_SWINF_0_RDATA_31_0] = 0x0814,
> +	[PMIF_SWINF_0_VLD_CLR] = 0x0824,
> +	[PMIF_SWINF_0_STA] = 0x0828,
> +	[PMIF_SWINF_1_ACC] = 0x0840,
> +	[PMIF_SWINF_1_WDATA_31_0] = 0x0844,
> +	[PMIF_SWINF_1_RDATA_31_0] = 0x0854,
> +	[PMIF_SWINF_1_VLD_CLR] = 0x0864,
> +	[PMIF_SWINF_1_STA] = 0x0868,
> +	[PMIF_SWINF_2_ACC] = 0x0880,
> +	[PMIF_SWINF_2_WDATA_31_0] = 0x0884,
> +	[PMIF_SWINF_2_RDATA_31_0] = 0x0894,
> +	[PMIF_SWINF_2_VLD_CLR] = 0x08A4,
> +	[PMIF_SWINF_2_STA] = 0x08A8,
> +	[PMIF_SWINF_3_ACC] = 0x08C0,
> +	[PMIF_SWINF_3_WDATA_31_0] = 0x08C4,
> +	[PMIF_SWINF_3_RDATA_31_0] = 0x08D4,
> +	[PMIF_SWINF_3_VLD_CLR] = 0x08E4,
> +	[PMIF_SWINF_3_STA] = 0x08E8,
> +};
> +
> +enum spmi_regs {
> +	SPMI_OP_ST_CTRL,
> +	SPMI_GRP_ID_EN,
> +	SPMI_OP_ST_STA,
> +	SPMI_MST_SAMPL,
> +	SPMI_MST_REQ_EN,
> +	SPMI_REC_CTRL,
> +	SPMI_REC0,
> +	SPMI_REC1,
> +	SPMI_REC2,
> +	SPMI_REC3,
> +	SPMI_REC4,
> +	SPMI_MST_DBG,
> +
> +	/* MT8195 spmi regs */
> +	SPMI_MST_RCS_CTRL,
> +	SPMI_SLV_3_0_EINT,
> +	SPMI_SLV_7_4_EINT,
> +	SPMI_SLV_B_8_EINT,
> +	SPMI_SLV_F_C_EINT,
> +	SPMI_REC_CMD_DEC,
> +	SPMI_DEC_DBG,
> +};
> +
> +static const u32 mt8195_spmi_regs[] = {
> +	[SPMI_OP_ST_CTRL] = 0x0000,
> +	[SPMI_GRP_ID_EN] = 0x0004,
> +	[SPMI_OP_ST_STA] = 0x0008,
> +	[SPMI_MST_SAMPL] = 0x000C,
> +	[SPMI_MST_REQ_EN] = 0x0010,
> +	[SPMI_MST_RCS_CTRL] = 0x0014,
> +	[SPMI_SLV_3_0_EINT] = 0x0020,
> +	[SPMI_SLV_7_4_EINT] = 0x0024,
> +	[SPMI_SLV_B_8_EINT] = 0x0028,
> +	[SPMI_SLV_F_C_EINT] = 0x002C,
> +	[SPMI_REC_CTRL] = 0x0040,
> +	[SPMI_REC0] = 0x0044,
> +	[SPMI_REC1] = 0x0048,
> +	[SPMI_REC2] = 0x004C,
> +	[SPMI_REC3] = 0x0050,
> +	[SPMI_REC4] = 0x0054,
> +	[SPMI_REC_CMD_DEC] = 0x005C,
> +	[SPMI_DEC_DBG] = 0x00F8,
> +	[SPMI_MST_DBG] = 0x00FC,
> +};
> +
> +static u32 pmif_readl(struct pmif *arb, struct pmif_bus *pbus, enum pmif_regs reg)
> +{
> +	return readl(pbus->base + arb->data->regs[reg]);
> +}
> +
> +static void pmif_writel(struct pmif *arb, struct pmif_bus *pbus,
> +			u32 val, enum pmif_regs reg)
> +{
> +	writel(val, pbus->base + arb->data->regs[reg]);
> +}
> +
> +static bool pmif_is_fsm_vldclr(struct pmif *arb, struct pmif_bus *pbus)
> +{
> +	u32 reg_rdata;
> +
> +	reg_rdata = pmif_readl(arb, pbus, arb->chan.ch_sta);
> +
> +	return GET_SWINF(reg_rdata) == SWINF_WFVLDCLR;
> +}
> +
> +static int pmif_spmi_read(struct udevice *dev, int sid, int pid, int reg)
> +{
> +	struct pmif_bus *pbus = dev_get_priv(dev);
> +	struct pmif *arb = pbus->arb;
> +	struct ch_reg *inf_reg;
> +	int ret, data;
> +	u32 cmd;
> +
> +	/* Check for argument validation. */
> +	if (sid & ~0xf) {
> +		dev_err(dev, "exceed the max slv id\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Wait for Software Interface FSM state to be IDLE. */
> +	inf_reg = &arb->chan;
> +	ret = readl_poll_sleep_timeout(pbus->base + arb->data->regs[inf_reg->ch_sta],
> +				       data, GET_SWINF(data) == SWINF_IDLE,
> +				       PMIF_DELAY_US, PMIF_TIMEOUT_US);
> +	if (ret < 0) {
> +		/* set channel ready if the data has transferred */
> +		if (pmif_is_fsm_vldclr(arb, pbus))
> +			pmif_writel(arb, pbus, 1, inf_reg->ch_rdy);
> +		dev_err(dev, "failed to wait for SWINF_IDLE\n");
> +		return ret;
> +	}
> +
> +	/* Send the command. */
> +	cmd = (PMIF_CMD_EXT_REG_LONG << 30) | (sid << 24) | reg;
> +	pmif_writel(arb, pbus, cmd, inf_reg->ch_send);
> +
> +	/*
> +	 * Wait for Software Interface FSM state to be WFVLDCLR,
> +	 * read the data and clear the valid flag.
> +	 */
> +	ret = readl_poll_sleep_timeout(pbus->base + arb->data->regs[inf_reg->ch_sta],
> +				       data, GET_SWINF(data) == SWINF_WFVLDCLR,
> +				       PMIF_DELAY_US, PMIF_TIMEOUT_US);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to wait for SWINF_WFVLDCLR\n");
> +		return ret;
> +	}
> +
> +	data = (int)pmif_readl(arb, pbus, inf_reg->rdata);

Are the upper bits guaranteed to be zero for a single-byte read? Otherwise,
this can return a value outside 0..255, or even a negative value which the
caller will interpret as an error. I'd mask the result with 0xff here.

> +	pmif_writel(arb, pbus, 1, inf_reg->ch_rdy);
> +
> +	return data;
> +}
> +
> +static int pmif_spmi_write(struct udevice *dev, int sid, int pid, int reg, u8 val)
> +{
> +	struct pmif_bus *pbus = dev_get_priv(dev);
> +	struct pmif *arb = pbus->arb;
> +	struct ch_reg *inf_reg;
> +	int ret;
> +	u32 data, cmd;
> +
> +	/* Check for argument validation. */
> +	if (unlikely(sid & ~0xf)) {
> +		dev_err(dev, "exceed the max slv id\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Wait for Software Interface FSM state to be IDLE. */
> +	inf_reg = &arb->chan;
> +	ret = readl_poll_sleep_timeout(pbus->base + arb->data->regs[inf_reg->ch_sta],
> +				       data, GET_SWINF(data) == SWINF_IDLE,
> +				       PMIF_DELAY_US, PMIF_TIMEOUT_US);
> +	if (ret < 0) {
> +		/* set channel ready if the data has transferred */
> +		if (pmif_is_fsm_vldclr(arb, pbus))
> +			pmif_writel(arb, pbus, 1, inf_reg->ch_rdy);
> +		dev_err(dev, "failed to wait for SWINF_IDLE\n");
> +		return ret;
> +	}
> +
> +	pmif_writel(arb, pbus, (u32)val, inf_reg->wdata);
> +
> +	/* Send the command. */
> +	cmd = (PMIF_CMD_EXT_REG_LONG << 30) | BIT(29) | (sid << 24) | reg;
> +	pmif_writel(arb, pbus, cmd, inf_reg->ch_send);
> +
> +	return 0;
> +}
> +
> +static const struct pmif_data mt8195_pmif_arb = {
> +	.regs = mt8195_regs,
> +	.spmimst_regs = mt8195_spmi_regs,
> +	.soc_chan = 2,
> +};
> +
> +static const struct pmif_data mt8196_pmif_arb = {
> +	.regs = mt8195_regs,
> +	.spmimst_regs = mt8195_spmi_regs,
> +	.soc_chan = 2,
> +	.spmi_ver = 2,
> +	.num_spmi_buses = 2,
> +};
> +
> +static int mtk_spmi_probe(struct udevice *dev)
> +{
> +	struct pmif_bus *pbus = dev_get_priv(dev);
> +	int ret;
> +
> +	if (!pbus) {
> +		dev_info(dev, "Not probing a non-bus spmi device\n");
> +		return 0;
> +	}
> +
> +	pbus->base = devfdt_remap_addr_name(dev, "pmif");
> +	if (IS_ERR(pbus->base))
> +		return PTR_ERR(pbus->base);
> +
> +	pbus->spmimst_base = devfdt_remap_addr_name(dev, "spmimst");
> +	if (IS_ERR(pbus->spmimst_base))
> +		return PTR_ERR(pbus->spmimst_base);

devfdt_remap_addr_name() returns NULL when the address cannot be resolved,
not an ERR_PTR(). These checks won't catch that, so probe can succeed with
an invalid MMIO base. Please check for NULL and return an error instead.

Also, spmimst_base is never used after this. Do we need to map it at all?
With the IS_ERR()/PTR_ERR() calls gone, linux/err.h can go too.
> +
> +	ret = clk_get_bulk(dev, &pbus->clks);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to get clocks\n");
> +		return ret;
> +	}
> +
> +	ret = clk_enable_bulk(&pbus->clks);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable clocks\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct udevice_id mtk_spmi_match_table[] = {
> +	{
> +		.compatible = "mediatek,mt8195-spmi",
> +		.data = (unsigned long)&mt8195_pmif_arb,
> +	}, {
> +		.compatible = "mediatek,mt8196-spmi",
> +		.data = (unsigned long)&mt8196_pmif_arb,
> +	}, {
> +		/* sentinel */
> +	},
> +};
> +
> +static int mtk_spmi_bind(struct udevice *dev)
> +{
> +	struct pmif_data *drv_data = (struct pmif_data *)dev_get_driver_data(dev);
> +	ofnode child, node = dev_ofnode(dev);
> +	int ret = 0;
> +
> +	if (!drv_data) {
> +		dev_err(dev, "Cannot get drv_data\n");
> +		return -EINVAL;
> +	}
> +
> +	if (ofnode_name_eq(node, "spmi")) {
> +		struct pmif_bus *bus = devm_kzalloc(dev, sizeof(struct pmif_bus), GFP_KERNEL);
> +
> +		if (!bus)
> +			return -ENOMEM;
> +		bus->arb = dev_get_plat(dev->parent);
> +		dev_set_priv(dev, bus);
> +	} else {
> +		struct pmif *arb;
> +		u32 chan_offset;
> +
> +		arb = devm_kzalloc(dev, sizeof(struct pmif), GFP_KERNEL);
> +		if (!arb)
> +			return -ENOMEM;
> +		dev_set_plat(dev, arb);
> +
> +		arb->data = drv_data;
> +		chan_offset = PMIF_CHAN_OFFSET * arb->data->soc_chan;
> +		arb->chan.ch_sta = PMIF_SWINF_0_STA + chan_offset;
> +		arb->chan.wdata = PMIF_SWINF_0_WDATA_31_0 + chan_offset;
> +		arb->chan.rdata = PMIF_SWINF_0_RDATA_31_0 + chan_offset;
> +		arb->chan.ch_send = PMIF_SWINF_0_ACC + chan_offset;
> +		arb->chan.ch_rdy = PMIF_SWINF_0_VLD_CLR + chan_offset;
> +
> +		if (arb->data->num_spmi_buses) {
> +			ofnode_for_each_subnode(child, node) {
> +				if (!ofnode_name_eq(child, "spmi"))
> +					continue;
> +
> +				/* Bind the subnode to this driver */
> +				ret = device_bind_with_driver_data(dev, dev->driver,
> +								   ofnode_get_name(child),
> +								   dev->driver_data,
> +								   child,
> +								   NULL);
> +				if (ret == -ENODEV)
> +					printf("Driver '%s' refuses to bind\n",
> +					       dev->driver->name);
> +
> +				if (ret)
> +					printf("Error binding driver '%s': %d\n",
> +					       dev->driver->name, ret);

Please propagate the bind error instead of just printing it. As it stands,
we continue and return success even if a child bus failed to bind.
