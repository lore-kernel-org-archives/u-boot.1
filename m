Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BCE606A320
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 06:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=K6ExGTew;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FywkAxRf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dWXK4bhn
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A661980DB2;
	Thu, 29 Oct 2026 06:24:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ozf3pwM_6xa9; Thu, 29 Oct 2026 06:24:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 930B780D7F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793255086;
	b=mNtNdoMjBoWenhvibvckPqstUMwd49Y3UDJVk+/fAQWGm/rhus9RVLNa1agIyZGymKg8
	 GKZdT67FG7Pu3VVDaLl/VhyO7AM++EgNjST5kKON32xA68iAsR8IbLHYryYY6pbV+uxms
	 GOj2rJIFfXc6MXvuBK2H5kFXdlWVEot2xgxIyBKuVZeyceW3MDX01Mn6UtTERpfVwun3g
	 RyMqoDoygjyXhWEkTlAa9oWdyyzellllidBHkkxoWV7jYE/EBcCn2nGWNfX3/3SycHDxb
	 ib1H0GFwyvEWvqkpq+HZrBu8p58uwHf7Zc09/V8liKrvAQh7vRD5qwYAnL4Ytg03K9w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793255086;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=u4lQYhmClA+0cn6CDbpXmSI6aFJnH7eOS7ySqu8ycRE=;
	b=qafH/nHCWjzZCuSmvNUzmHb2thnWaPvRvZVe1NnwQbODT8pzGLedNPo/gzuJSyL8/djZ
	 gQpfUCfdrnZFdIUn9mpnjtzOdKEuwZjQL23wsghIVEi4Mtyq34KLypRVRiSwRqRxaPMvO
	 kMi4m6VrOGmmV6wGy5Bq/K5aYMyTaT8yGXjof4rOsZ1gW4lEnaAUQ6UzV3lrpTv419XFP
	 hScx8foMVyhkHOKcXo8k4dG+qc7p6/0yeoUOy1uw9znaGZHr91B6fhM59H/DLH90vf7Tx
	 bhp2hmn/BdS/IhMdUMIIqIhOeqAVcbcFw7YbZxZ0f9V43A89vtxDsw5wPUdekpWYkiQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793255086;
	bh=u4lQYhmClA+0cn6CDbpXmSI6aFJnH7eOS7ySqu8ycRE=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=K6ExGTewV+hrMJHLBdQV+yBN1tMkx2bAuTOWQA61LRLoWAED217osjqhWFGA/21Dx
	 LPJKrmfskr6bMQJaYhyWMz2sQfshJV7orsVlcUEWEwSAPG/pGWK8+pobj6KeYyrdaq
	 75tzep3I6fVE9MnKxLjeQ7htmRTAzxC21mVJ/Rui4412ILioqJrpl5ZfVoUbHtrmsU
	 G/qNjnntLEPrYRRCxgvcy9BLTTJK2IR5LyUc9ALMMmSTZ5oN/6akC+3wAIi/UNfdeS
	 1Cw0ZStcoTLiCqkMgP6/Fx5eMSgeIsaBB7ar/xUTryD+4dDpr34h3dPNB51wgZbmdt
	 CfDREhk2iiK8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 930B780D7F;
	Thu, 29 Oct 2026 06:24:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 960F5235
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:24:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 87C3C40176
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:24:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SN4l6p48EZ_a for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 06:24:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B169640080
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793255083;
 b=dfamcsY1XRZh2ktQgExog2pdMPCnKQIQAmophGcCCPPqmqZfyoLrEq4uci2tJN5BTcjd
 rbuQsRBiyGAyK+G+C0F7TmwPLh3iNNkvF143W9rzYJ3MrFrGgEpkMg/2FhknFpA+SUvwt
 3a79Sjkid1JCCXQ7p5qXcuPqFmEYG8tNUtULDIr1WpMSphaPGwynHw+7Xup068naj/YEH
 GcM3eU8ASkLib30iqxH6adcD7R5qorc2axaotM1yu557Lqs+BuCADT7q192ekOss8Q4rA
 pLaqT8R/+o20vei7vsHK761BrAQVgVUyho7NKZ+k99kCod1slsPrEa6qUq5I1Q4K+PA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793255083;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=u4lQYhmClA+0cn6CDbpXmSI6aFJnH7eOS7ySqu8ycRE=;
 b=DL9DCfO9P9pzLokbQO5FfSP2jQqkJvNxoj29EQHVH/kzOau8N2rlR9q5XsNsyDXbmyOM
 Vhu++noOO2Bs0qfeLFmgVcLiQGenkeZ4POKS1h3JWS2SfE6/74YHBuri0uxqtTCnIIgnd
 kpppY8xbjMkpZ/Ve5FVmWIjkLohGx6WKk8dJaHdy/utxRRcGiLfTSyeDjzewwX7C6PLEO
 ee3FkLoxvQIwphxDY6ZMtcju1SFZfh0o3b4X0T+D9OyCYuJgwW4v7vH0HzJ08r7eBTEcP
 Ghrlsn5NDFq0p4oHPoCc2n8ln/eH2VlqefSwE7D5C1xtKvkrte9we7ctFQjF1XoUTmQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=FywkAxRf; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dWXK4bhn; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=FywkAxRf; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dWXK4bhn
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B169640080
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:24:39 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T5H4uo3829221
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=u4lQYhmClA+0cn6CDbpXmSI6aFJnH7eOS7y
 Squ8ycRE=; b=FywkAxRfShNa99RtfUToUBCvU3s/X9gQyKDcgPSyovX4pXv+ZzM
 GRE1IwM7Issi1Niv8S8LVA14FTmh3KcyPg5IUAT4fQzloSli9NoEzV2WfvxJz2Ws
 cPWumPa7aUwaloQHjZOB1ea5bgkhd9MPfDRbIEU2LA7TvNrffOVgvv9XOCdBzAYO
 qH7FRcEZIXJCZUg2ieezoqV/RSTJ7YVgMlzcyS0um466I7hxUCmjO8l5JzKuX5w9
 M/IGOP7VO/e8jFZbRdVgjPu85jSrKFEDCa6oTtXPGpOXR/L1GcrGGerNFhvxZOx+
 j4DcSsK6Ssy9670KJwyMwkLRw32WxjUCluA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hktmp98k9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:24:38 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1383723dfddso3113969c88.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 23:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793255078; x=1793859878;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=u4lQYhmClA+0cn6CDbpXmSI6aFJnH7eOS7ySqu8ycRE=;
 b=dWXK4bhnL7wAw+cBnSzsiPfe1T8LM1ypCWSRrwf0/JLsCyTQ6tHaOKGj+swuDcnxqb
 BnUIY4bv1F4jjUZwKYOS/zRIxJS7pKHDUM5v9dBMQ9l+M/51LfEGG+4Mj3YbeauYNgFF
 d7OAi4RJuq4BOOqqd7X/429W0+IVu8cGqYf86yi2guIHOrrrPVasqrctgtO2pgcUtKf+
 1mwgYuKzoYXSzK1YNPSfDDL6Rx0tBpjQW0HlhCNcum0A9bszm5MGExA6pGYLG3bLw1o3
 k2N7i6+mtywCpPrTaGe4QrrA7pWWWyUTHNa3WEGNacpaLLATvIf4GXbqXWZb6pagFkDj
 F7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793255078; x=1793859878;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=u4lQYhmClA+0cn6CDbpXmSI6aFJnH7eOS7ySqu8ycRE=;
 b=MBW2BPp3i6s3kpXAKXmcsNv3pTxhjt66xJ/+iZ30MmgZa2r/BX8cg8bRoK5kPUBwOd
 a/UlTVzOCi5B1g83c6hrprWdoS3g4nN1cklCo2MCRoo/EAgr7RMXOFmkB2YsYBdsKIXl
 /yUUj1uYkv4FvH7IxKfcmgkUK+O81lIAKOd+oJNWL8biVtg0QURxRIOPfgw5QjPHfj9M
 XIiqLfcspE0ZVCAwi412Y8kArh45037Qk3DjTnL4+NNOqDv+FeLkiK88OrF6JDHVY6KS
 Ff+P3F02/LVZuRFFg2/VzT80SdBWU7kaZebCXVOyJPQr1W6JxtBHQnbItHNZcd75MAbd
 tVcA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwuO/ecVwoEDVgPCX0HD0CDi+1BBvlj1vncYDRrEXyxuthUW+K6gim9NKtpOT1ssTk9SkVOPK8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJKSwwPuqsxHCdEXulJjLLBFGPOPGLBcoJJHlaxwhRDhS+i8RPH
 RzpcSlLtiH3RB3/rwv7Jo7T+iTSsSrSbe5CcWFwa+/FfvNdtkB37NK9qMlpig3nuvmTj5zVBD0s
 N1nvEfsW24ZVurmgjGC5U2OJke50hZj47YYhNhBX68QBQl+Hg78XbnZK4BSeKGQbY+7JeEwE=
X-Gm-Gg: AYBFou2S3oulkSELnMuF8f4Hs9XeqRUqI7CIoeLxgi2ohV9v4fPOY+nAcgIhyZj3XZ3
 Umnl/zOf57I51HbSeKBrA2AiBE/Lf2fmTUbfPFX34jHQzMavZiFDi1pafMiXSrAZTCy4QZiOwhZ
 YfE+R0rKXGG3jLUWB+73hGTRNX90tVULqZYQzTQ2JslK9qwANJOk+En3u9XtgdPgcEG1L80qV/O
 Jz1Qh+e+UjeLSb4TtxCkY3AvESjODwO1r1X2XVJyHN8vrNm3oWZX2P/+Sa+8vFNoubg0jsy48Z9
 KOHtDCnq8O2ZuzQM+WX/NafUwtczYtvR4pD7bK2p9080S2Ti0GzMcIpuDODQaXw9qHG4hZ2t69y
 YMsUFYQlAVUSiJQgrjk1YSmX4wjMzppZsX0fM7kRbJcP1DlWb3Rk+11qRu9tEI3EkahBVcxnk4M
 PqbQm1M2Kp4IqFNFx7a5HFZQ==
X-Received: by 2002:a05:701b:4641:b0:144:fd7c:84fe with SMTP id
 a92af1059eb24-1a6cf72ac18mr5530748c88.35.1793255077575; 
 Wed, 28 Oct 2026 23:24:37 -0700 (PDT)
X-Received: by 2002:a05:701b:4641:b0:144:fd7c:84fe with SMTP id
 a92af1059eb24-1a6cf72ac18mr5530702c88.35.1793255076829; 
 Wed, 28 Oct 2026 23:24:36 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75a5594efsm16125714c88.2.2026.10.28.23.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 23:24:36 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 kr.sowmiya@oss.qualcomm.com, sjg@chromium.org,
 varadarajan.narayanan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v3 0/1] qcom: spl: enable CDT for shikra
Date: Wed, 28 Oct 2026 23:24:30 -0700
Message-Id: <20261029062431.3117727-1-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAyNCBTYWx0ZWRfX5EGX/+hJkPRw
 F8eJSeGCY5TlUYEjRDjYgjN4N84HxUKr+86L661zCiALVCHktOQAI1BmfcWaI+cJzUVJDu4dCYk
 NG71ZposjL6djdbKjNhh9A3UTTERbQhzHCJN/JiOUQGwYVxIkAc9Q5uCCkDUL3kp5H45/cF2nUL
 X/ny3+xPhVxVIgoUpU8WQaF0PS18c/iw5BXBIR0XpJUOe2i9vEDh5b2DFSO5XWDoB8xDH8QHetr
 UL4FnwgY6tXtQpDaP3Fwi3HPs7807Sie9/GotlC1MVUGxPWYU/lfnIm7mT2UyupkQViALf5uDFP
 ojHzpuoYcM2ouomwJEVVtJx/zFQ9ZeWODEV1jS71jcPSSmWzP/dubXtqYvMixUl6ByDElC+Zf+e
 IhBNQdhOpTxtXeujETVoZQUks6moP/KFAtW3cq7+BVJeTiqr28giMYzrgMdZl/0XKh3C+M7BIIK
 fPuvHPyNgPFTeu5MpwQ==
X-Authority-Analysis: v=2.4 cv=crYOAF4i c=1 sm=1 tr=0 ts=6ae2e6a6 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=egoGQyna8TZyodxhhL4A:9
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAyNCBTYWx0ZWRfXzVxId5KwPGeX
 wRjQ0mbpAXH4wNqJi9LM1i2hG0ytanOf0VG2Mq5PRhs/KG5X5hIScfXgYV12JAUtB05rkg/nsIA
 LpwWVy/RgEMfKdMJSSF7Vx5MkU0XQIY=
X-Proofpoint-GUID: 2ExyZEM3spw9lfLvK5XGKq6MmBaOg25C
X-Proofpoint-ORIG-GUID: 2ExyZEM3spw9lfLvK5XGKq6MmBaOg25C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290024
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,KHOP_DYNAMIC,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for loading the Config/Chip Data Table (CDT) from eMMC
during the Shikra SPL boot flow and registering it with QCLIB via
the interface table.

Changes in v3
- Address Tom's review comment 

Changes in v2
- Address Varadarajan's review comment






KR Sowmiya (1):
  cdt: enable CDT for Shikra SPL

 arch/arm/mach-snapdragon/Kconfig            | 73 ++++++++++++++++
 arch/arm/mach-snapdragon/board_spl.c        | 96 +++++++++++++++++++++
 arch/arm/mach-snapdragon/include/mach/spl.h |  1 +
 arch/arm/mach-snapdragon/qclib.c            |  8 ++
 board/qualcomm/shikra/spl-shikra.c          | 10 +++
 5 files changed, 188 insertions(+)

-- 
2.34.1

