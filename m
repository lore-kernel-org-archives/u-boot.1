Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893AC606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 02:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=l+gh1rsM;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cC686/2s;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=krsaRcYj
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D4C04080C;
	Tue, 20 Oct 2026 02:37:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R3yP3BOICvAU; Tue, 20 Oct 2026 02:37:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 67170406D9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792463875;
	b=gewqqf3jnViBoOI0IBXi01owUH3xW/U9k+ZIGIL2iavRLDJVC7ldmEKuf4Eieh0nmQ54
	 06IWBfnTgGcuY2L/GGAf2XR73Bo+seTLOhQ0QbgXZRZkFV0OgPG8MW2sCwfB5j9FZpKSQ
	 VhdtPihfTXI3NyiiwhuJOKtzGOzVmyb1V1pU7TFK1VivhXKpfbY9W+HGMPkcSR52EaeoB
	 FKjP0Lnef+DQe4lc9S7juMhTtbHlRsQIeHWS92B6Uilgzy6P2i6Jqkry9d7mFx+HWy/v1
	 lrXH4qaNgtdlC1K2x2KUtojjqnNTNmU+FEEUZzQeOS45H5kOTajPZukYlpK6vP20IKw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792463875;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cjyG6TC4Hpmz+nNcaeBMEZPy2jJDOq/bZOW6L7WRcd0=;
	b=YC2ZCtTxlPW6a+dD+lklVi1/wr+SMbqnWPjLs4X6Vd6S8suOZ8YFHxC+Ikhlk7IrWD1g
	 WoGvs5/YVWsh9vOXQ7hiUnm+TltpftqyakCVfJX1+n0IfGrEstQigdCG5+nBgjsBS/i9O
	 zIfIiBxsuisqojcXIpQ6sy7p6fLb5g/1i5RQIHY95f7Z+ijf9uV8UUaWM2Jdp6DYuaqxt
	 TNFxvG7aa7iWjnOZ6tSUgoH+JmhDXvTMKSxvjy8XkmEWv7Rn9QYgr80RtC0CDmbRO3EEu
	 +QnsRWdh97tdrltcc21ZmfgECLjw1+ADRiIeoL2EoS5jZmUQ1LW8NHrV3oEUewJd9og==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792463875;
	bh=cjyG6TC4Hpmz+nNcaeBMEZPy2jJDOq/bZOW6L7WRcd0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l+gh1rsMIS/jJ8IY1tJJCi+oTTJo+3xN4Q6RF0w1b9jHf0L8jml9yxgrf9GjY6Nr2
	 MciQOncCAwpgkvnkHAZSqMXfToclpZD8+KKYiZHc87Jy1aJ7kWw0U+B8JwXPxBqh9B
	 Za9vioxoG/018bXOXde84Ie3+kmJNtQ4wiEqq6HbFB8LmOzC/kFzeXQuU6B/X4bmp/
	 dInPuWbZgw8qDu9rphL36lYgEkq5/TkGT0nUhP31i0FLYvwxYZumRyN01McCAp5YS1
	 O/j/SL9zZoC90WycTlo+uUgnfu5bJY8rgzX0WmmJ5LE1Ye5dp/LmsDXaf9qUnnVqM/
	 2l5iPE/8PkfTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 67170406D9;
	Tue, 20 Oct 2026 02:37:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C2B5B12F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 02:37:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A90E9810AE
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 02:37:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6EDPiDDTjOoe for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 02:37:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1D3C5809C1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792463873;
 b=Ae/SJ1pVRmLHTfBpisD4t3YMj4sfDXE4H8BXi80Mq57QKX9snXU8bx1i6vbpZmoxk3iK
 1INvLWA94FBw0HoL7KmzXL//d1QztTyXLlng8EO2uxYbFeddYJywoKzUc8yBMEWBkGHWm
 JEey9XfsPxf8QyWyaQOENDNSDVe9PccInA7h0/Sxt99rkl0OvOW4PcG9TocBtifhwyl3Y
 SyA2Q7Kigpq3nBvWFMrQ0CbUUlgekMri8UwQwaeGFcRxzbmGNlYKmlk1zAmtgtbjoi7Hi
 qozw9zf96GIDHShGJYS82MS0xOBEcvwPVG49AzZh5tT+Q4jf56kVNRA6ESdh3VczOsw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792463873;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=cjyG6TC4Hpmz+nNcaeBMEZPy2jJDOq/bZOW6L7WRcd0=;
 b=ZzKfN8L4BRdHiOZWhBOfJoAES2MRFcFHi0V2inAu6fCHXVMhWjZchneplNrFmZcao/CS
 vMXzpRJ40LQwC2qXAYEoe15MR1XiC1FiJgomiXm5lvloyba6FWYu/6+96BhXP1eGEBbhT
 x28qevC1l6xZ14LijWqXEIfD5jSbTBIYty4xjQNGw5joT7Klo4RIw+hLCEHgW8M6/xnKO
 KKUMes5tWUDwKhtfKg2NhQqZ7rNui2YzVspz1s0x6oqMp/Hx+RW1NmCclOm7GAZIIXEqG
 XfY/sywSGVXg/4pkcFNAamSD+7mlQWQKol2fBGWfMqQFM7OZQgndwf3HGjNp7kOc2jQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="cC686/2s"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=krsaRcYj; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=cC686/2s; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=krsaRcYj
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1D3C5809C1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 02:37:52 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K0t37c3485517
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 02:37:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cjyG6TC4Hpmz+nNcaeBMEZPy2jJDOq/bZOW6L7WRcd0=; b=cC686/2sZygieDoP
 wJQOuIsOzBKQYKKDAdndttE4ijs5JjTM54FiflsjcmfZ9ToBPBZt/vdiQOqZOE6y
 Q70daCn3+zftpo5LWFqdSkIsSlnyWQSJr9/nRq3B+TbDEGZHmQHWfU6M1RA8oG74
 6CgzZwRFM2iJuVHFPcyJMbxGKiepA4+fBaQqXoEJzCO2cgQ+1icaOMlOFpIWCAiR
 +Iigj/4Mh2/sDB6R1TMW42Gx16i9opFF14McdyDQmugiOcHm0vN0y6DVIBtAosmZ
 q8J9pCqz5a9eQpU+qPUl2knauswXx4iI+jjaOshdbAv/i0EVYhF0e66hfCOPGa0x
 yOUZPg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n0g1c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 02:37:52 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35cbea41088so4626200eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 19:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792463872; x=1793068672;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cjyG6TC4Hpmz+nNcaeBMEZPy2jJDOq/bZOW6L7WRcd0=;
 b=krsaRcYjml13M3/QbmeXikiNoDm2OYkgRGgb1+m2soUQk2POPBV6oVtkBLxSzcFeq9
 kicc16Wxi7+SmPjWzeRpHa6LjO2JDp9YxHc0SIz4Biq+9/G94gbhSIkYsVe1hb92/6ne
 ysZedAbVowlH2zxf8ZM454h60jB/b7mTbtHHcfUT14D0CH4Oct6mIjbWR1Z6qTOVdT9d
 eKpbkYj6loyfUia/YxL5z9oSuLhcxVI1nTulnWstWq9/tAL1EiRs8Ft/rEQqMysjKMeP
 Gs6/Ma/iGYoc4Wl1poOhjduEExa2OgNMflVtIV2H307+7vZZ0zO+k24uaCvfNWaaGqrZ
 bhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792463872; x=1793068672;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cjyG6TC4Hpmz+nNcaeBMEZPy2jJDOq/bZOW6L7WRcd0=;
 b=ncSTE+arthD6HmtWc85HGa6cDjFxoYUX6sK4Be2sOvn1mpkDtIT+UzbHWP658nLoQ+
 P5fSZ13pko/w4bXzt9pQBpSw1qala3gDch2FTTGMrH6tITDnEk3g97o/pppiTqOFbnl7
 jedwdOTvSdqYokvvWeGPQm98f9/SfHJT/1Yd/IM8JS/NvnKZZLEl+MNCx1DrMHaPowUa
 OBrTXHEVsHj6DK8qTVH2iLWPuKArUQRbVM+6e9sywCpEwwRrg2vKp2+2738Y4bRYe9kB
 AOGdfseTz3fLHUL46YobsyokqobA1vjYSkznxtM++o/E82lJLW4D55S4IwxffABclHYq
 cpSA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwYamv4TqSJEEBmMXWKTnpmnvTjiaFH0wIvfL24g5+N8GY51VfICfnUVNl1SHbGt4ZQALJaN90=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLKgyWK9EjQhzvmrRrk/SHaxKBK8a7JuNuf+Vh3cGBFnrgPcQGZ
 cQ48Fs2QM3el9ciaJXyeiS195mJelrhoahliVCwnxkA2BsHfgrOAXNlqH64f895hRTI/DKy+syL
 G/OaYjqtEv5yzShQmEBMS1KkmKOMiRW0DpKdw1xnC0WzhG+KHCiacKWbEepgZ3zUL6NHJwTs=
X-Gm-Gg: AYBFou2uf+vDoCmhcNBtuaMCIDWqpHHtSBWCJNh+rOdGJFL9SPHopFp0FeBVpcqJWZi
 FTDgxsmxm6J/24fm1wC9zxPssbUzROtGkG9nNYyUfRT6W3YGVw9RJgcjB6mxg7S5KmA8aWlMUxk
 NINjWvTM0TopVf8WxxebCjcwoztcjJk0KSzHAvzKe2qfKC0YW0ZC24cAVp2NdbxDDQPRJa7PYyo
 nfCOJzEQNt670NxLC0WKO5AxsXw4p8Gyx5vQkx1mu8UzYz3N+2xydFjV62tZt7VjbeMXtKDpEio
 R34cJDO0XxMzfxWto7YsPsv25J3fy1lMpdLG/PfmvMtvA4/YusIRihzCtACg55QYPKOaTsKmwFT
 QN5Me4eqimiiu7VltBrI9YhlGwzIaSWlIUyXRNEkmpqNH3NwNHBZCfqlLiIddH852kUm5kZpnZc
 nHwQyyDXeheNtPsQr5xEAcxFdTzPVM
X-Received: by 2002:a05:7301:618c:10b0:35c:ceb0:8c11 with SMTP id
 5a478bee46e88-361a1a586cbmr13044225eec.14.1792463871576; 
 Mon, 19 Oct 2026 19:37:51 -0700 (PDT)
X-Received: by 2002:a05:7301:618c:10b0:35c:ceb0:8c11 with SMTP id
 5a478bee46e88-361a1a586cbmr13044174eec.14.1792463870358; 
 Mon, 19 Oct 2026 19:37:50 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36082b8573dsm36349143eec.25.2026.10.19.19.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 19:37:50 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 08:07:38 +0530
Subject: [PATCH 2/3] configs: qcm6490: Enable Gunyah exit support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-gunyah-exit-boards-v1-2-39ec03d9e365@oss.qualcomm.com>
References: <20261020-gunyah-exit-boards-v1-0-39ec03d9e365@oss.qualcomm.com>
In-Reply-To: <20261020-gunyah-exit-boards-v1-0-39ec03d9e365@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792463859; l=679;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=EjdBRv7MxKoKS+DHbNEnVFkvOaa4C6eXWOHOVsI6u1M=;
 b=5ZL6Mos5XdzhqMzHmibGlhVrq2+ibmh3exFlXsvpA5nNGP4Wl0TjBQs1wi1w6UtNN99aYvcId
 e4D/gULQ7nDDRBQ9yuVX8jiv6VBfqV6LEEm7NXU1GOJTpPzV8Jc4vNn
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=aIplOr9m c=1 sm=1 tr=0 ts=6ad6d400 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=eJSkjvnNxjshUIuaBzgA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAxMCBTYWx0ZWRfX644Ak7uAbjML
 /4CewbWfIqiNK1seV2qyjMUG8O6ZvcdehpPoskijDecg1GtJVzt6kPPrigH42J3utFUQoqWwnJy
 nG88GlsiQNJPycObU4plwQ4mm04Pzcs=
X-Proofpoint-GUID: oahGGWGn0U_v6mr6s47Gmz3P8WBvRJlW
X-Proofpoint-ORIG-GUID: oahGGWGn0U_v6mr6s47Gmz3P8WBvRJlW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAxMCBTYWx0ZWRfX8cXczWzO609u
 nlyDLCFq0ZFcnHlUTW75to29/yMSxxAiWaGWOY7Hg7qZAud08DCzO4LQZDLwsUEYE6kTqbz9Do1
 ke3Fb2AwkpJe8ubLx2qLs0puCjALUoTGQ0j4jO9xLDKo8QsnltjiVAeAtam/lBSk6FADCF937s6
 rAKjvPTYa6eSilurosKmKxFaV3PO0WWBUq7BqDG2rwjLxfVnTp4bTN34QVvNlHM9zQUQLETfm2x
 w8ZBG2Ra9rXUy6CuNyzvNuMRqo49O6AvA0bDoGUget3VLvcbCSIHQzHoh97Ai8tXue3mlhKKBMI
 pxLLk2r2f/d10MRGZjz76MN58THQTY+OtJOoOScCugEyz6srrPUsXuof7VK+qGyr8hMPR0NRRkO
 0fCCcFZzlk16ZG7k5WxJu8Kd8SLKkPtgr35dXIQ1h70U9qxmyITlv/Fln6eYUG6RyPqhB4eJGfn
 3jv+AVgj1jF7FFniTpg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200010
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Include exit-gunyah.config fragment to enable early hypervisor exit
on QCM6490 platform, allowing U-Boot to run at EL2.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/qcm6490_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
index 56ec771ba1e..8416fe2f749 100644
--- a/configs/qcm6490_defconfig
+++ b/configs/qcm6490_defconfig
@@ -4,6 +4,7 @@
 # a dedicated "uefi" partition for edk2/U-Boot)
 
 #include "qcom_defconfig"
+#include "board/qualcomm/exit-gunyah.config"
 
 # Otherwise buildman thinks this isn't an ARM platform
 CONFIG_ARM=y

-- 
2.34.1

