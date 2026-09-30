Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70212CA5FB1
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 06:35:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2FADE81098;
	Wed, 30 Sep 2026 06:35:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tIiN5gdYPmm5; Wed, 30 Sep 2026 06:35:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3CDCC8101D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790750134;
	b=kY36E4IHO+qZYaqkiKRkOZSE+k+2rPalHhxYnfIF/Jg1Lr464ruqbOYQIwu/Bz6OPorc
	 ZHNexUesDc6qCN7Y75xWGK2r/M+hg+vDjaEyJ5E3KTo5x6N3bc7MvLLPauXBwvePOKkHY
	 rcC/XZmjZg3B1VAZnncG8eRSInos41ch6hNnf0mRH9R2Iu8QdtSc3R2+kg4oDMfxmf7nE
	 QNoc5XmMdltAm86wCf4eUl4S/5FOnxis1lUHNBKhQ7Fn+BdLpebVmc40tIg+leN39a6Rp
	 Jwk1fPOtOR5C7eA2BEPPr2UBJG1y2LHaQSm9XRcu1BFuaDj666V8zjwYZnZDZmJ0RfA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790750134;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=G5VyBcsD3RAZeW+KkCg+MIyFoce+YaZovaE9BkXk/8c=;
	b=gTtCGIXDs/xaaGPGkin3v/m6MBJWxHUVv8fCASSW+p3gotLEJ47kXpV36gS4g62Bp8XY
	 kaqj5ik/pA3ER16JChkZSpRvdiq+KfZK6a0kAcjCBuG5kGvG6bbc2SahnZ/Hex5I0RCy1
	 4phZtjGX2n7/y8t91A8pYa853VzAW2CQjUJeXnJKwZdNMILqQKZoMUJErxAddYjgEAxgU
	 au/4g1ws4ffBo5Zc55tEsGdQwadmoD8Zag5fjJA3XAzK119EOF1TZ9DErHHsg8WzpQ9DX
	 f3MevaAm5P7Bgjf+wW6yAO7k95swh0ENiLN5ISqQMTbgpnV6WhdzhXM5ixLqGuSfEQA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bhNS6YRU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Wr60qTJQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790750134;
	bh=G5VyBcsD3RAZeW+KkCg+MIyFoce+YaZovaE9BkXk/8c=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LnHWvsoBCNTwDRHN+nCyWwCLgBY6M5SD24YG015HmdddxcQoayyMOdWdtMYnH4RY1
	 2yLgLmv+q5rEzSkjN5ltBRo2RwUS0wfjbREriQLXXA7AqWt0WPtEtLtG/klMMMuxkN
	 BEWzxTqI8y4sTVg7Ly1Lok1FR4kd5SPjUF/MV8xvcZ2PAvfScuLwUZUlqqn6B5RonC
	 Ak+HfPQKJ+5/FLg6q6VBl01wZe+3uCfXOLdFoTtXiEALzwAkOnRxi+1Y1NJ5NmToTn
	 twUVLLL/SzMX6yCss5Ab/FC6E7PH11YAa1s4t777B7SS4S/U+k6tFOF2ore1b3MJyL
	 71IhlmO0f+80g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CDCC8101D;
	Wed, 30 Sep 2026 06:35:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A51ED33B
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 89A1A81046
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nIIB30fdJujW for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 06:35:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BF86981007
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790750120;
 b=cqQfAGUXCqitu6kRJekVxszCNN0tExIctX/WmKrsBzt22oXIMtwQ3jd7lSFTc37txY2Y
 9Uan88zAg+0CF+acGUC/C47vDusTnZUtLKQaX2fovBlpdzx+oH/ihdEa14upr5EHoaDjy
 3dqRI6Ck253Zylo6uAXrxUkPqxgArU19Pgo2i/emnaj47uitqkzI/DOZz0NJ0IGhl5SDu
 xnfzvwQPThKq58cI2KIkovTimeLXJOcno+AaGaRJlpA5aWE0Q0WDMnDkCjIXfiIp91F0X
 O5X64mSiYGwYImGPB2JuJaHhfzL0irWZ4Wr2ixjlqRs6xZ2HdlruoJpvgONGoS7yHXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790750120;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=G5VyBcsD3RAZeW+KkCg+MIyFoce+YaZovaE9BkXk/8c=;
 b=GyJr3CqT0xa11a9fxH2tHBjcCOrE6iEUIW9hTbEeVCBTFFqtt+aFyR1l9y0LfYOufOml
 KjY0nXf+pmKjikfbxKf9k3MW8uOwh0usd/H4WijGF9jFxglF9HKIoNJ6XN2uv2ylGEw4y
 0T7QfHkOtYFFOIsb6ZKkSmecXmce7yN7U46+VgDv6U3kHZoolivmne/ULw2d8Pn2RQMzu
 8Fn/qqkw25Ar6PKqWf3Px2nVniYvk51EY6J76daYar8ksJKAUH/JaeuL4u+ePyp7GYInT
 GOYixGbiSZnpsFysQbJga7V1tUkNOQooKr7fvVMdAUZhZt408GEUwy1OLcC7H5Gah5w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=bhNS6YRU; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Wr60qTJQ; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=bhNS6YRU; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Wr60qTJQ
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BF86981007
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:20 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U2PHDJ1522393
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=G5VyBcsD3RA
 ZeW+KkCg+MIyFoce+YaZovaE9BkXk/8c=; b=bhNS6YRUzsly1sJwqo7Df+hGQKH
 /1WxijKK6TNsDuWyaX+YvPrRw0gZvGKTMIBF7k/PwNrStkFhdIcIw62OL7PxF62u
 Q8YDIytMpbDbE3y4EQWn6+GYzA+TaAoHgiQoQ5n0fQkKp3k+HEuhFioiElw3f+Q/
 kWdO4iY42CqPXKfT8Jqjknkwb+mMYE9r3j24xa7AJcVfEIU9dHV441VwsqOqh6ps
 76oWOd7ksdgVegVLYX26olzpFnYjIBX/Xv9We25qqfJg1jifCac478Idi526sTcr
 AzP1NcRf+FXw17d321bq5BzVBSRvB0yBBNNORzUXTeP3NfMP/PmI7C3Hdgw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0smjgxj7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:19 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-313d1015161so1801123eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 23:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790750119; x=1791354919;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=G5VyBcsD3RAZeW+KkCg+MIyFoce+YaZovaE9BkXk/8c=;
 b=Wr60qTJQbGrv5dogp8N/Q7BFqOuL6oS6HOrQKxlxWpOjgHyL3Xl2sqU55g2A8X0rXt
 cDwhAJUZkDoyXwSwnuOkuvn6DCm8RPqE5ie/dI3YWKEMRB9Gk7JO7FbdgGvgZuIWOCS/
 Om/eIN+O3+WF+3S9NRe/YCyV9EE5DVCFEqAEtXkroAmIo5KcaKcs7r8iopu2kDZI7Jb1
 n/X3N29oQ0q69WEEUOT169i/7Vmc/w2lXE3g9yz4NlGSxZk3n0BwLdxIbXHnI04q+BjU
 kxePJtIPiNJMvEvLweTzX5497R+2qJS0UzW4MEjRjuFWbjDFE2BfZSCZ8eHts9wew0LD
 l5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790750119; x=1791354919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=G5VyBcsD3RAZeW+KkCg+MIyFoce+YaZovaE9BkXk/8c=;
 b=1kF3VEdEiiMjWhBichNNT6NNYGLHtEjRW4ai991RGXOMqvJfbpxu/SYxIXSwX4eZGi
 WLyeVFK63rwBH4Qhcdap1raoIxSNrqyXQa68DGxFo0XKNsFLYJIXGCpW8+MK+5SrVwLp
 rh4lXjpCyAjBdOb9npVmlMXmrlawHRgv/ooGTk/Oa/ReXw4Aq+b5reeeIKwI9lQPSY31
 o1kBnM/Q3hG5o0UfeWsQZ7m1vJxUAWvGB+aTd5Fbw6vsS2/ezlW/6QQLvYBWRS+PvRrP
 LFD5yh/mtxM2vFJri9BnCE598kcgPI0cdEl8zBlEwzWDcMWHfW9oYerhKix7DkgKE82l
 jxIA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVeFszwEmi9t4zCqoRuE7edT5e3rZNMe3XRf4VKe0L1M6PYW0iNp7R2ePL94K+JE1Sc+7Vbio=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIeM2f93qm1h5/US+88Z/wtxrezS2GX0BnW/wJhm/NV3C07KUWx
 SINsd5sOrO1N3z/94AtboCr6ekkBCPz6gc//Mwj1slHb+vDSNHSqO9MVI3jerqx+zLc3S/HNDwf
 WAkrle+BjwQZd4wn4M7M9xobqTFQH4UJKnElf0+HedIaEnJqfaVDRrqUVErQTyDZlemjfYms=
X-Gm-Gg: AYBFou29I3TKK1fjjv9bUN7wUudFbrQGCHjizmgU8+YWTsXd8pDFOnpNOXNUJk6+eMa
 HXABuYDdjFxtO0CiaRUhMraX13PgT5XM9aTHLXi7QL22PTrz7ht3CjWbSMGQp/VpMivfk9/xgH8
 apf7xsWKN7iullxhRnVSdI5Oadov583s7I0mCPXETwhtXEKK0/sryC1c0d0K/KhGtvXnA1oqum+
 Auz4K2zWivEVTo8O3D+efqU8hJis2wD2L6zjJPLwhQhZvO4ueLSXCyg2BDgT+eO/6PdtwKueBFi
 QVFkQHejzsJl4jQz4wrwgR5XvB+/r7lJdCh/tgOVgufPaZ93O+g6mbeIu8TJT4KJZv2rplVFLZd
 mJWWGn9ts/Hx5j9yHpcI2dz8MgTc6Apa8FjB0LRVaav/q+8NZ
X-Received: by 2002:a05:693c:2807:b0:344:33c7:54a8 with SMTP id
 5a478bee46e88-34cdbfc9d65mr617406eec.24.1790750118996; 
 Tue, 29 Sep 2026 23:35:18 -0700 (PDT)
X-Received: by 2002:a05:693c:2807:b0:344:33c7:54a8 with SMTP id
 5a478bee46e88-34cdbfc9d65mr617333eec.24.1790750117327; 
 Tue, 29 Sep 2026 23:35:17 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34cf22f85b7sm1287502eec.3.2026.09.29.23.35.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 23:35:17 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com,
 balaji.selvanathan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 Michael.Srba@seznam.cz, sjg@chromium.org,
 varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v3 12/12] board: qualcomm: shikra: embed XBL-sec in SPL ELF
Date: Tue, 29 Sep 2026 23:34:49 -0700
Message-Id: <20260930063449.3251317-13-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930063449.3251317-1-abhilash.v@oss.qualcomm.com>
References: <20260930063449.3251317-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfX8Ihp+RNJd6tJ
 ok4DmiNYEQ7jbNDQyDOxYCy3FXOfENBfUnX5zLl/3d1Y+vlBMt6KwHVQ83dDfEEsji8Q9gcZkTR
 CPWX0Dtd6XV3l/+c9EgsOfrWb0ac07k=
X-Proofpoint-GUID: Cjw5_s1ZrXn3KLfjkxVOmQ-rqTR754Pz
X-Proofpoint-ORIG-GUID: Cjw5_s1ZrXn3KLfjkxVOmQ-rqTR754Pz
X-Authority-Analysis: v=2.4 cv=KfxHIgYD c=1 sm=1 tr=0 ts=6abcada7 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=l66fMvErkfCIGnPQoeAA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfX1iAZOoA2MCcn
 HwCd1+q6gho3SyXYo0VAMQj2d3TdxRdGoxc/1lcLVu+N58Ubui5uuT90iSPFPOq39+W7miYZppN
 pjIMUm4VYlNBdBISAEhavPwtFu4E/QuwGmm3M16hZi2Bjt2CSgeh0KNbiNMoUncJdUnZMfXA1Xk
 5DSks1plMxjxcRXNlgypQnT2uBS7LQShOvBlAAm56RFNwuUw1hnJ940FZuvudkkGX33KhSiYYdQ
 jagei/VmMzrGXMht7jfnab7KE2glGtlbiEwtn7acHSN/rfp5s9ejUaaJUKpTQl3K+CzSJexERG9
 o9B4r1Ek2EFgh3lJH1iVWqfi/rhfleJluPq2GMGV+NffSJuoT/w0FCcuxnf2o+hCxzV5klnwY12
 AxOB6sYRKhhWUJIqBFuPFgIXDIsVbclww9mk9qspwJYg9M1Ge/Hbn93fNK+Lwe5rHzd55cqnm/J
 IagUlCe+mVnOuNRPJGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300026
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

Stage the configured XBL-sec ELF and embed it as a type-5
PT_LOAD segment in the remade SPL ELF. The linker script
places its complete ELF image at the configured Shikra
address, alongside the U-Boot SPL load segment.

The resulting u-boot-spl.elf is unsigned; external tooling
performs signing after the normal build.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig              | 10 +++++
 board/qualcomm/shikra/config.mk               | 24 +++++++++++
 board/qualcomm/shikra/shikra-spl-wrap-elf.lds | 42 ++++++++++++++-----
 configs/qcom_shikra_spl_defconfig             |  1 +
 4 files changed, 67 insertions(+), 10 deletions(-)
 create mode 100644 board/qualcomm/shikra/config.mk

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index b9c0362117a..ceebd679651 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -135,6 +135,16 @@ config QCOM_TMEL_ELF
 	  Path of the TME Elf file to be concatenated to u-boot.mbn to create
 	  boot rom expected multi-elf image
 
+config QCOM_XBL_SEC_ELF
+	string "XBL-sec ELF image"
+	depends on SPL && SPL_REMAKE_ELF
+	help
+	  Name of the XBL-sec ELF image in the U-Boot source-tree root to
+	  embed in the SPL ELF.
+
+	  The image is copied to the build output as xbl_sec.elf and embedded
+	  by the platform SPL linker script as a Qualcomm XBL-sec segment.
+
 choice
 	prompt "Qualcomm boot0.h workaround"
 	optional
diff --git a/board/qualcomm/shikra/config.mk b/board/qualcomm/shikra/config.mk
new file mode 100644
index 00000000000..51480059410
--- /dev/null
+++ b/board/qualcomm/shikra/config.mk
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Shikra secure SPL image generation.
+#
+# The XBL-sec image is provided to the SPL linker script as xbl_sec.elf.
+# The generated spl/u-boot-spl.elf contains the XBL-sec type-5 PT_LOAD
+# segment.
+
+# The input name is selected by CONFIG_QCOM_XBL_SEC_ELF and is resolved in
+# the source-tree root. Signing is intentionally performed outside the
+# U-Boot build.
+QCOM_SHIKRA_XBL_SEC_INPUT := $(srctree)/$(CONFIG_QCOM_XBL_SEC_ELF:"%"=%)
+
+QCOM_SHIKRA_XBL_SEC_ELF := xbl_sec.elf
+
+quiet_cmd_shikra_xbl_sec = XBLSEC   $@
+      cmd_shikra_xbl_sec = cp $< $@
+
+# Stage the configured XBL-sec image in the output directory before linking
+# the SPL ELF.
+$(QCOM_SHIKRA_XBL_SEC_ELF): $(QCOM_SHIKRA_XBL_SEC_INPUT) FORCE
+	$(call if_changed,shikra_xbl_sec)
+
+spl/u-boot-spl.elf: $(QCOM_SHIKRA_XBL_SEC_ELF)
diff --git a/board/qualcomm/shikra/shikra-spl-wrap-elf.lds b/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
index b2922cd2c2c..387b83ae6dc 100644
--- a/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
+++ b/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
@@ -1,18 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. */
+
+/* The boot ROM identifies XBL-sec by the segment type in p_flags. */
+#define PF_SEGMENT_TYPE_XBL_SEC 5
+
 /*
- * SPDX-License-Identifier: GPL-2.0-only
- * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * The XBL-sec segment address must match the address encoded by the supplied
+ * XBL-sec image:
+ *
+ *   entry address  0x0c350000
+ *   LOAD offset    0x00002000
+ *   base address   0x0c34e000
  */
+#define XBL_SEC_SEGMENT_ADDR 0x000000000c34e000
+
+/* xbl_sec.elf is staged in the output directory by the board build rules. */
+TARGET("binary")
+INPUT("./xbl_sec.elf")
+
+OUTPUT_FORMAT("default")
+
+ENTRY(CONFIG_PLATFORM_ELFENTRY)
+
 PHDRS {
-	ptype PT_LOAD FLAGS(0x7);
+	data PT_LOAD FLAGS(7);
+	xbl_sec PT_LOAD FLAGS(5 | (PF_SEGMENT_TYPE_XBL_SEC << 24));
 }
 
-ENTRY(_entry)
-
 SECTIONS {
+	. = XBL_SEC_SEGMENT_ADDR;
+	.xbl_sec : {
+		"./xbl_sec.elf"
+	} :xbl_sec
+
 	. = CONFIG_PLATFORM_ELFENTRY;
-	_entry = . ;
-	data : {
-		*(.data)
-		. = ALIGN(4);
-	} :ptype
+	.data : {
+		*(.data*)
+	} :data
 }
diff --git a/configs/qcom_shikra_spl_defconfig b/configs/qcom_shikra_spl_defconfig
index 7bcb3e21a15..1d997510c77 100644
--- a/configs/qcom_shikra_spl_defconfig
+++ b/configs/qcom_shikra_spl_defconfig
@@ -104,6 +104,7 @@ CONFIG_SPL_STACK=0x0C294800
 # CONFIG_SAVE_PREV_BL_FDT_ADDR is not set
 CONFIG_SPL_REMAKE_ELF=y
 CONFIG_SPL_REMAKE_ELF_LDSCRIPT="board/qualcomm/shikra/shikra-spl-wrap-elf.lds"
+CONFIG_QCOM_XBL_SEC_ELF="qc_sec_local_signed.mbn"
 CONFIG_QCOM_SPL_BOOTIMEM_FLUSH_BASE=0x0C219000
 CONFIG_QCOM_SPL_BOOTIMEM_FLUSH_SIZE=0x134000
 CONFIG_SYS_BOARD="shikra"
-- 
2.34.1

