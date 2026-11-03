Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB49606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BMM4ol0O;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M9qageQV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bbp/HPnr
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 21C3560876;
	Tue,  3 Nov 2026 13:44:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I-eYIEhRHT1z; Tue,  3 Nov 2026 13:44:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CC1116085F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793713492;
	b=X59502B+6+hJ/34+kVltnOUrD6FVFqnB2u2drxbhWRCtZS1WLN2h73/d77j0ILh/OKVA
	 sKWeKFfWawIPnzowgrEKCfWgRlK2s/URek48tpLA5+Mk5e1uH17E43B0cIvewXlTr1wLJ
	 YBG+D3sr0r6Bl/tUmMadbUijSVyN68V7t4AM9ego59BjAxtw8Eg8r20JIRTbmaNnDXXQr
	 +X4jkr128jHvm6N8MIKSHf8aF6UIQ5SPy73HnxGvaKUO/nPQQkNjIy2b3pTkvX/L2e7w+
	 sXGboBjIH2AxJlm+WgmIIvXByNnPtmTmG8H9bhbegiR7Mv7V8Afdyv9P8csIyhcJJtQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793713492;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6HJlZOyIZNyv1g3Z2SZvu0mxYEElj+VgHI9lgkmfrkA=;
	b=B6iEYYVYSraaOzthIqaHkthA7KiLwf23WJdJryId+5hrBxpqVWRo80+32Uj262cEnP/q
	 GjzEpsrCwxwNMsXsjx3HE1Y8RJO3lhG7iYRfBouUNvVftgoItt/uFkUI/X9qvgJvvgpI5
	 n969C0fjiRGkKL1R5RHEq3aCO3ZkzPNfeK9x09a9ZVAYfAaoSswLJKYvub0lR4yQyJP9z
	 DHzDXKhkE3joGlVEFUGzju/TUKdWNUjZtSC3cJpV2IK9v1CyJzQxhnF6TWC6/NxFVsrCS
	 wb3yeKaP1yaT/h0rUcGZFHLvlm0XmVq8ByC2Es8ZsPJOVHmbGFiLeWsQV/WmUsKKRuQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M9qageQV;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="bbp/HPnr";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793713491;
	bh=6HJlZOyIZNyv1g3Z2SZvu0mxYEElj+VgHI9lgkmfrkA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BMM4ol0OHLpU+7p1JsmOpouLzp3m62GkOsVKYcyzX2cfNjsOgIBT7FFVs+fPHZf2g
	 3zBtvzQjNn9I4IPysYgQuP9j/6PjrftcqtUHX2PaUuddodLqZHmwKWbCvdTF5rZfAJ
	 PyarhWCdxvIaeOLRzJBCA4zUiijW2fdRYXp97AxgtbM6wWjJZ6XtUX6CAY3SHM4EAR
	 r/v54qr/lSCzYfg/nn+AvqglXQzJX/3qrWo43n7v0p/Jjx86HSBhpIB4oe3Mvp8qrS
	 QxpWIs8aD8yLAtGWgZgJKNIkGkKcwDNyQKgrn4pfeI2umhmn/WhB5j430oVFfi0COO
	 bEMHNwT2Lizyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC1116085F;
	Tue,  3 Nov 2026 13:44:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 469EF4BC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:44:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 386A36087A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:44:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pt_Zjp3H6AEe for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 13:44:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9745B60879
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793713489;
 b=nkPqzkB3+3/Fd/gBnnLEIxXz4nh0cSzRBiK8chQej692ck/4st81Rvq5Z+/ehWwY4gcT
 bwCZr+tO57tMGVamQzgpTh+5gptCewpqF47iC0TZW24GcgL0m2A9VLOxm+GVJIHyly3Oj
 Ec+TpcHCAeUpjNb2nf8BEEGcIglyx4mOHMJ36skEEDC1rVtFcwCf1wyegipEvAkd63pCx
 AL5LDBgRCkME2LqZkEAvcFGl/SbS48m6uanCBSjZrHT9vba1f4KOjUyb1vxt5pZ1+uahy
 6N15DV3TkVNYCRLQjpdmlxyvzi3giuviCozU/fbzSfFs8ujU0Xlt/zvVSzGdw/IXenQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793713489;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=6HJlZOyIZNyv1g3Z2SZvu0mxYEElj+VgHI9lgkmfrkA=;
 b=GqAzjN6Nr7fG5KH/taFpBzLmTkaCWN05j3eSYI67mySWAXUtgL1LawQZfynOZ01SpTeD
 c/zLBwyBHE2jlDs070gcCZ7Fb27I168UByDnLRw2ioLSWVRT1EDgz4oZSu2o3blUk+OnI
 TjjWZk37kLP2Og1MYANHRefF0HEhIk11NeLB0mCYU4Dk6URq4qUlgLJSy3d6ZqqhZg45t
 pamrCFAX9+rygQyjicvIPJlDTSja2b1aRtCEkU4WdliDq0U1CrpCfsV1E34ZnXa6Y1Oh1
 zfLG5u/QYYfDkFaksx41LR4BYqAwvpPamU1VAZJKj2oS4ili9xUzCU+CRJOh5smajgA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=M9qageQV; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="bbp/HPnr"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=M9qageQV; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bbp/HPnr
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9745B60879
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:44:49 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3DZhhQ2449941
 for <u-boot@lists.u-boot-project.org>; Tue, 3 Nov 2026 13:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6HJlZOyIZNy
 v1g3Z2SZvu0mxYEElj+VgHI9lgkmfrkA=; b=M9qageQVyNJUjlVZKF03j8nAwcc
 zdLJKU8QT6JyOpBLN91Yt2FwPXuUuZA2GqvNsElBZYsiitbDXOWUEORbaX3ggIyF
 1Zz/JbnpPR3zNActi+nB1MlUMWEw3KNzpa929aYG9sQKHOAte3AF+0vfzepuxoPd
 gd+jJKN4t+alfLWI7JY389mReTalSWIX3FJQ4yNPrNu+oRU6fafknR54T+K3ko7s
 pVoFL3ClkRq8Q2cOeXx2t+9Q1pGsfml7Yvm06B5Izg8q85j8hHbx0cs1Csy9JULD
 Nt5lyfar1UFQIIF5InpYa7XG7/1Br7EVZPwVwYTJaZ3u4RJpLR41L3ESxDg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq7yct8ff-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 13:44:49 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35cbea41088so5656120eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 05:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793713488; x=1794318288;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6HJlZOyIZNyv1g3Z2SZvu0mxYEElj+VgHI9lgkmfrkA=;
 b=bbp/HPnrLao/IIADUrhnlY//ftXFFUU4p8eFwhwiJphzLoI6cSqncUe5k/ZhrUTZ2O
 043Mf0RpdV+4tfMXZO35N3gvCpeJOqfhFMT2jOTQl5CdrJxUkguPpoKASQ4UDd1k/mKo
 w9xubKTvzbndamMC51OEQ0Vutu3KUoWUTpNkuqtfTT2BVeFRP+NhgkQEHMFqbAUaLAIn
 qbI7KoNqnvvt6PVl91C6MNwzsvUFaTh9y7kclwM5IRV5GyoIKVm1aa8VTfC2CAzt5g9B
 QnafAuFwISQZXE6ogLV/NGTIaqQ8vivjtIg6WIFXM0yY7PTdOEmrl/ZbzYlFBNN9afqM
 nV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793713488; x=1794318288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6HJlZOyIZNyv1g3Z2SZvu0mxYEElj+VgHI9lgkmfrkA=;
 b=Lc7BYLT3824P5HqOulXnxubpIbNEvCfxekqzDZIiIOUWcRtrpoe7gN5rSYG6GOdhSj
 ui6Q9fT/YVff4eE7xl90OZFgE0pqSF+Lm33sDFA4+XwoLLFyi9N6Mo6rarnyulApUd5q
 lFqgbNeQm1OUQEzqX2OvRYBmIadm8x3aprTZaiwJ7rTFnp2pTw8HXvWbBC5JSUOaLxfM
 MNYC+5nhfxlMGqNzXTqPTk/rvH7iXyKV5RxaIUVuzpKDuy2FPfXZ8eQz5r0/Ny4eA2Vn
 FBainyyciRn8Dp0VY2psfDMoT+qKoKIXOMQDJHWUiCB0N/jZOZz86aq+xbEXSn8GsGeB
 WP/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWBk4JOI9Y3FLyskBaZiWaEC1igDOVwzXuJVplf7ZoEID0U3d5uqewmMGNk5rQbbv4htCBUwo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z93oThnK5pMw7jqyx4W0l46Fv1Gii6DjJ9YjisRnWswXfisua1p
 HDSapGgiHMHUt+g23pX7CcvGnwOuEPa24Bo2p/NLg0cu3LWFQWn/JVRYvEHqVLqs5wEGOjWB5Sk
 5s8kY58b2i5eKgtJZeHTsaqWo48TAe3ES3hfbXTNyg7ErzZXrUudCFJ/JjF6CKzzyD7wqAQA=
X-Gm-Gg: AYBFou16KdZQ34HsyIqTXZOZGWFI7HJte0pHrP2HzwyYcsErzsXtbr+omPTNcWkBokY
 3TxGg79f6fwlLTVrj9+N8QeEO/qo8qwJTg8sJ5EWTQZz1zaY93AVDYKpfEtvF3WgHdXLwWIMt88
 gqeGOsZ5FTesdXyCellSQVZ7VOdLJNDx9ED1nBlzMUKVZiGro/vGSyJWDayePiB2TZYmZxf+c92
 PC8uQ4sAhIyVd/wCn0NMkLd0Z23Y/hFVVKx8ZgZSsb29LjA3cKeTM906e/r1PEy4H1DFIXJAMZf
 5ezfWfijtq+ZR1aczbYBsbg2s9+cIE4CFKzXOOqGcSKIiqZqM57FHhusV6D+AbF2pP8PJJqg081
 v828oOpLF3GeOt5LNubBhzdVdwARtwJ1/uboaOvzR7G+YU9HeGtcX54LxzUl5FTuKk5w2LHcCOZ
 ewGI0bJdMT+E1Lu/rLQ5q6nHNuUfAGIc+wH4GSH02hOnOmlDKhPMSFmx1lnsUSM9pc9x4U
X-Received: by 2002:a05:7022:1707:b0:189:d6bf:7eaa with SMTP id
 a92af1059eb24-1ac5c3699f6mr17738812c88.16.1793713488237; 
 Tue, 03 Nov 2026 05:44:48 -0800 (PST)
X-Received: by 2002:a05:7022:1707:b0:189:d6bf:7eaa with SMTP id
 a92af1059eb24-1ac5c3699f6mr17738776c88.16.1793713487663; 
 Tue, 03 Nov 2026 05:44:47 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b23f20d36csm7511194c88.11.2026.11.03.05.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 05:44:47 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, balaji.selvanathan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, william.bright@imd-tec.com,
 nikroks@mainlining.org, anshuld@ti.com, jbx6244@gmail.com,
 dlechner@baylibre.com, nathbappai@gmail.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v5 8/9] configs: qcom: add debug UART config fragment for
 shikra-evk
Date: Tue,  3 Nov 2026 19:13:50 +0530
Message-Id: <20261103134351.3532864-9-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103134351.3532864-1-aswin.murugan@oss.qualcomm.com>
References: <20261103134351.3532864-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V7foQuni c=1 sm=1 tr=0 ts=6ae9e551 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=3Z-LdhOq5Ikn1NNAXfgA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: SgD9VPhfgDEKCcFW5kvPzovuNNrmMXv1
X-Proofpoint-GUID: SgD9VPhfgDEKCcFW5kvPzovuNNrmMXv1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1NCBTYWx0ZWRfX/HMsYj/EhGJZ
 Gp9+QQFzDGLYJYic4O5zL4i1bbLfqLeDUbwaeUe3ktHO/psnLddxYjf9sYlOUAKagp3M9yifAYs
 aB6uePyLSS1KRRnMVUIju23imuRAPitmfC1F7mU8hUwC2pKoKfL6XSU0QzTreCsRLQHkM4zKNsL
 PvTtVHj2WkJxCn6R7GW4Y++t0iKNDAb553nl77DjIdgbXort7F4jk4bLlyUKUZGejLWHyXX9V67
 ADCW+BdUR0qXCv/b5rVUx7Lb/zyLTg06gNS4Y9lHhlD1w7Ui/9k49lCSilCpGWcrKXyxIOn+Qwl
 fOlaeo6KeidbtwXj6JQReWsKDmaBqYfgB5qykfbXGMgn/Qrdo6gHH+MFyX0ETVGf4FFVdH1y7Kv
 x26BSrvTIREOC8qik+I72XP5k3YPxUQ1mZjW87E9lmnLeJyxmGTNiAMl0Om1Y+gLLkU9BxIkgCP
 Hzmy3d932z3KtkgeV4A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1NCBTYWx0ZWRfX68W4UxJKItAA
 PprQHNKGiyciFfLIYOC1aWUtHSlArmkm7zEyLi+aNO/nmuZIzzYYfyA/8XECUKpoVH4jLKodsh4
 AJrFXSWtU3b7V2YENCMN269QNbx8LX8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030054
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable early debug UART support for Shikra

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 board/qualcomm/debug-shikra-evk.config | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 board/qualcomm/debug-shikra-evk.config

diff --git a/board/qualcomm/debug-shikra-evk.config b/board/qualcomm/debug-shikra-evk.config
new file mode 100644
index 00000000000..034ab3249cd
--- /dev/null
+++ b/board/qualcomm/debug-shikra-evk.config
@@ -0,0 +1,5 @@
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0x4a80000
+CONFIG_DEBUG_UART_CLOCK=14745600
+CONFIG_DEBUG_UART_MSM_GENI=y
-- 
2.34.1

