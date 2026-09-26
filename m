Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E56EC9832A
	for <u-boot@archiver.kernel.org>; Sat, 26 Sep 2026 21:09:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD3B280F4F;
	Sat, 26 Sep 2026 21:09:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WBkv_40LRbhw; Sat, 26 Sep 2026 21:09:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DBB1480E0F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790456948;
	b=gIXMZ9wM38qWCdAwn0JZ0wu2kChuxaUxX1n0EsKo6eiGT2Rz/+JJCuMlnKvX7YtXYfcn
	 qdDOl1rGN75s7hRuIv40beUa91K9aPj+46qtO+Zx4iwIOXBZm05HkJ+V/MUELA0HMO8JQ
	 BCTZS+WuQU3MkRBDHa5MQou1fnUrTh1kKjNYdGIur5s4TvRt0Cspg+5ztDw2DaMoDSMJk
	 ZhFkf5X/nQfRJOkAwhoRtM1VNag4vBeIrv9cELGVJTstvItVHNSkKD1Kgwd5eyb/5bSQW
	 Lqno24/7fO/Ev+VzAay+kbwSgtOgKH0wQbLPWx8tqcg/dPsdCp8MC+IyXagMZ26aQdg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790456948;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:X-Google-Original-From:
	 Date:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=o8Yhe9RFkKUAgapnO9Xr+CiMGMr5zSmDybwDrCGnTK0=;
	b=CaIuLJNAd5ytTgRuWGoHjw43dHrrUMBuGfylouGM6PhgXFYlZEsSk1DZ3xj0rptRuDEs
	 W5o/jQMbd3lHlrG6i0ayjODz2digIwAjnOn9KmLlIn42b+OhnMM7RDvvYgi0Phfb6BSMD
	 bcobe71C4VsMpF6++5VYjsKYxZCmzWxUEgSWjN5eI5/msM4S95X6fBHZmHQSmYg5ddEb2
	 WTbpVLhCqOZTJZokU+0qNE/obwVXoNKEQiXFRqQkZrDP5/yCUPUZYuNln0hbBHmcR3Sxt
	 UVKxiS3W4RupZ0JB83zVx7sVMkwz0PleGXoAujza50G9xOS7mwaMkO4PMXGje1baIpQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790456948;
	bh=o8Yhe9RFkKUAgapnO9Xr+CiMGMr5zSmDybwDrCGnTK0=;
	h=From:Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TcHULP0oJ+1uU9PQjZzgK2aLJgmkYBBE6dGtciIp+c/9nPor/Zh89BLveLXwEDjFH
	 7z2uftob2bfjlkBr3dfJn1E68Y2TKftiiYye8FttAmv97i5mZOr+eb0LnhgKByA2wB
	 Rb8TeS5tofic8+tQRTD3keIRDJW+qMQp7Sev1BW3mmWPEFkb9fhaZazKUQJ6BYPoIz
	 zr+2klGbF3UbCxt39Sp1tlBwiBhN9f1Jt+2JfUUqkKLxsodAbFND1ZdjmimGvOh18M
	 LieKI/NUcP38My6ZQGtHVrRtC9G+1VRn6uXNT4ag7nrwjHuY7mo/1+8ddecybsf9CZ
	 o9h7A69BnsLNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DBB1480E0F;
	Sat, 26 Sep 2026 21:09:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E4A42B6
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 21:09:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1FC28407B7
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 21:09:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id goko6l-tKuPo for <u-boot@lists.u-boot-project.org>;
 Sat, 26 Sep 2026 21:09:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C5C3340783
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790456946;
 b=izw/WWb8xQuwvV5m4rz8FrUBhxiNCY80ai0YlT+ZBWeMAytsI4hilgwZSoEjdroIKg2/
 7Q2dH5XZY4wq744vertJskryX/Iktuxxwb1l0r5JOjZCl8HDuFaiOzZRjC6hU/kBzY7yc
 GXV/UWYbhcR63Hrs31hExRIGpzOdsWH6KodUwgEiGidT+lWb2TUYEmKEqC/0WCf43dYss
 XtZzQ75f0bSZzYAG/jirsYJGTEaxAOTr5bQcSO1kirNAbGVusfV4yY1M0HK5ZItGwdtP6
 X5b/U+T2gUDt+pGp4ZJKynr3EnUr0WbiqtHLrX6ozKThhrI3gwc1i10XHGqfC+dW7cQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790456946;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
 X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=o8Yhe9RFkKUAgapnO9Xr+CiMGMr5zSmDybwDrCGnTK0=;
 b=RUU8NUzgZX/o/Wl9LXB/Huc5c0swXPJGT5TcLMyMJFa8Y8IqO98rX+W0TNBTYU19e0hp
 JqfB76BpNcRNctcK5Az2UfbvATW4KlIaoCeyDujKBCQpjw9qbKsHhDNFnwS5fjjAADPvS
 bt+n1WE1tvhM6UXM+OcrtzzJ2KxBCw3zNvM/JLIt71o7896HjYxq6Wgs5QRJ2i64HnA37
 KKu3RVhqJU9UkSvTb0RZCCOCu2FGkm+8xkrqzRjAavUUdSFkWX2bwm3ZVzW9VDqPXs5ZB
 SMtll4aM5+Mvhgr5OE17ab4ypN+2JAxh7+lKyrYpQtofMcS3T9NYeY3ym1WgEClZINQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Ks+gybjc; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=iD1uodgN; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Ks+gybjc; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=iD1uodgN
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C5C3340783
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 21:09:05 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QH01qj245998
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 21:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=o8Yhe9RFkKUAgapnO9Xr+CiM
 GMr5zSmDybwDrCGnTK0=; b=Ks+gybjcWeFvuyqggMqwfRDwk7cDFcdzD+tWatJR
 4aSe2C6PTghSRpA7qHREjI9UKy+pPDLc6ye3vwHs9mLvuEAUFWGqGK6Y6r9Y8Nc3
 nejrJDtONVHFKGtAYxTuNSpfXDa+0n9RTw0b/V3LNQZJdfJ9M2k70wA9GjQC9nQX
 Q0l+z3nFZAkpyIn8JwljbXhHOO8tpr8pbCZ35ZOIKcnYiLKnqaW7XtNynT0UQAuU
 JcOQLq5PoZuM72wIH0QgrEyBPSGGAC0JCEkbCJLePadSEDx9eUOnhhdUbTEFnJL4
 HDIOVaU0/Dqn0ONm3Y8mK61OWpvFYSd3kKQh5R2ddmrQcw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx3dp230a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 21:09:03 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a0312937eso261193885a.1
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 14:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790456943; x=1791061743;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=o8Yhe9RFkKUAgapnO9Xr+CiMGMr5zSmDybwDrCGnTK0=;
 b=iD1uodgNkSM03Ay1qnPC5VGE0t6D75LVV+qNBgYTOG/a4MyY4GUd1X9ziJ7tAH7K3I
 PmXgsrQB+NwFm0BuXlaRPSZI5D9BMi0/r2gH/OnkTJalDTTeAdhINxM06glG122GuhBJ
 2VPW2HtxMgDmyy1UdYp8XKIkHE0M97uCMOapTaT94m6wlJfA8wkby6LP+NLuO1GVQrF9
 +9oMkNH8LFvJRqzoLzK8ylAf72GEo7jGqgJEe0jKXi7jheH6Gg2yRO9HngnsBn/5+zfl
 Gh5N7mH+agrLIkNRv/zq7FX/fpIc/mRVn7sTmAO6gZPHZ27f34X8PHRg67lMHIaZcd14
 sSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790456943; x=1791061743;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o8Yhe9RFkKUAgapnO9Xr+CiMGMr5zSmDybwDrCGnTK0=;
 b=BX8UiGAaSGj24qfJZEPCkjL+4KEVSYiVaf1LGVIPBkpZVZLCfFIozmXGU85foEPcuG
 DdEFbyeo2BTgxCI0GQblnosVlxjlqEBEbv2Ci1mHi3N7kkW+fKdd4HCq5Oi9mbCXaseU
 maYeAO6GAiFO9+uZ6DTokd0OW/mfVd1sMsDskGfEqhy9Tn1oDGJNPPWd8qvgriWQ2i8W
 5JjsuEjJSHV1wsK+EW/y1iWVmfgs2VbuOBQPPza4yeWNgcVxWmyb3GuK4UxZjuJeWRSO
 ef0i7zxokdunFJbrVoFie7Hyiw2dDl628TJ+P4woXFRzK3yaqmhon6ZsgHVRRWgfPa9F
 GAAQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy++TW9KtzMSgoWov9O/vMWbuCagimeoFRgkM7ShSJAwLsqbY9NCe+GH14ThH+80GDBHESlW4o=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lijoZ01U6RSdvgkeRVKdwotUdKUXnxB9vlfjcdgeE7TMSGA1QO
 mFtP0HjH9th7zo1iVfxGFjz9QSoXyXxwJtYjGaggFeZNRmYcM4epVtUTLIx5voflzBrlI1qCriQ
 bqEIWRhD4KS0d2hEwVN9IiOOMagXZpKAF9l/cxRr4k9r2/BcdVb0i74OEJKFH4AelEi2eDow=
X-Gm-Gg: AYBFou3WOYm3U8YbzmAmlnp/vkaeIOOIiTV2thxFlm2RNCJrBCAjiGet77c9SjAp1kc
 DEAwOp0uCjfzHD1C+5OMX555pd1jm1Zn97kWSz4as6GLm+irT/AjObufUTx/GdJlckKTflfHgYx
 Imn5R1nx8SZCWypLAKg56mD0HtFaM9D2cNNSQZjtVi8fKWDCzzSC7Mkzv3husH/FfQ9p9GszzV1
 fpbTenhCK6qhMdcbddYPwquaz00NLzdWpq5haOxP8iJNcFo+PbU98X9YGKwvefanhpHmoB1xnyA
 kuiT6BnUH7FMP5vS6mwCKdh2Xu01GUNhZPPxkh391RjvrEqzkPI1M2NOpDob+P1LSg==
X-Received: by 2002:a05:620a:1a0c:b0:939:6df7:73f1 with SMTP id
 af79cd13be357-93c43cf888emr1232824685a.51.1790456943206; 
 Sat, 26 Sep 2026 14:09:03 -0700 (PDT)
X-Received: by 2002:a05:620a:1a0c:b0:939:6df7:73f1 with SMTP id
 af79cd13be357-93c43cf888emr1232818585a.51.1790456942619; 
 Sat, 26 Sep 2026 14:09:02 -0700 (PDT)
Received: from trux ([2a02:8109:d902:e200:2717:b11b:a255:915])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a6450a3sm14959646f8f.25.2026.09.26.14.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 14:09:01 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Sat, 26 Sep 2026 23:08:59 +0200
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Macpaul Lin =?utf-8?B?KOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
 Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>,
 Carlo Caione <ccaione@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>,
 "stanleyjhu@google.com" <stanleyjhu@google.com>,
 "Beanhuo@micron.com" <Beanhuo@micron.com>,
 Zhaoxuan Zhai <zhai.zhaoxuan@canonical.com>,
 Ethan Hsieh <ethan.hsieh@canonical.com>,
 Jian Hui Lee <jianhui.lee@canonical.com>,
 "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "tanmay.kathpalia@altera.com" <tanmay.kathpalia@altera.com>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>,
 "n-francis@ti.com" <n-francis@ti.com>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>,
 "michal.simek@amd.com" <michal.simek@amd.com>,
 "jbx6244@gmail.com" <jbx6244@gmail.com>,
 Bear Wang =?utf-8?B?KOiQqeWOn+aDn+W+tyk=?= <bear.wang@mediatek.com>,
 Ht Lin =?utf-8?B?KOael+eAmuWulyk=?= <Ht.Lin@mediatek.com>,
 Pablo Sun =?utf-8?B?KOWtq+avk+e/lCk=?= <pablo.sun@mediatek.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "sumit.garg@oss.qualcomm.com" <sumit.garg@oss.qualcomm.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH v5 0/6] ufs: rpmb: route OP-TEE RPMB secure storage over
 UFS
Message-ID: <arg0a8HqaRxVif9L@trux>
References: <20260918200641.2286077-1-jorge.ramirez@oss.qualcomm.com>
 <aq2b2AspOcySKRvl@trex>
 <SEZPR03MB78102F7A1B91EBAA72743B2189812@SEZPR03MB7810.apcprd03.prod.outlook.com>
 <CAC_iWjJmZFsxBn_R4z6N5RVewjDL3GzBWY0t6MTiLk5tSCN7vg@mail.gmail.com>
 <argt3LwLjENr5vZF@trux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <argt3LwLjENr5vZF@trux>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA4NCBTYWx0ZWRfX7LgMAhKNB39t
 zNH1NtzmNF8IHTAMIhGbyQXpF8T1abwfP+MdFEHp1LbugoDoqgAmHR1kC7xqBKAocmrsP2mOv5f
 +fe7/2SeaYYRzX+XNxZvAsV0ThwP73MiEHhMCF1RIUWLqJ6hPyyAdgQar0B2MfIl+wjuc1mV6eR
 tiePhnPzPO6XAOX9WKHc2r8RMyJPvXgSjYuEjIuRDboCT469mT8gPSv6fq/wn/jGvy6c6ctxAj4
 PoUhs5G5y03OgepVXNgCQ383WosChnXzOAhMrRzLCZedS3fdtEBaRz2p33nBNvkCWkJuki8BBB0
 YSJX+fgat0h8htRSBz7rx3tTKUKzCkjl4MfxeIUdX7+Zcu7KsDzlgUgE2p/qkkkd5AVx70oQ4w+
 zsNHdCWpHYNMQs93sa8oGnttgFsVU/7QekLctkR4NYg4iQMB9UHC8K89dFUzJcuDmfL+eqkC+uo
 Wfp2XlgKGBO1XCMOEGQ==
X-Authority-Analysis: v=2.4 cv=QsXLTlyd c=1 sm=1 tr=0 ts=6ab8346f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=jmec9B5xnA1R0dc8j_AA:9
 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: bBSAUaBTSr3Yk8xmMrJTIiyu1Tg7Ur-2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA4NCBTYWx0ZWRfXyY1wSfoxoAEx
 rBgSIP9MFbxv4o7fdm/QvWmFnfw1vBLSPAVfpJQIhSRbyuCcu795ybWY+fWWdUFxaNSh0/zjJ3Z
 iT7FvrdpAY2oCR7BtA3CvZiFHV4Omwc=
X-Proofpoint-ORIG-GUID: bBSAUaBTSr3Yk8xmMrJTIiyu1Tg7Ur-2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260084
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

On 26/09/26 22:41:00, Jorge Ramirez wrote:
> On 25/09/26 12:59:28, Ilias Apalodimas wrote:
> > Thanks for the detailed analysis.
> >
> > I am pulling in Jens for OP-TEE and I'll have a closer look next week as well.
>
> the concernt I read - please correct me if I am wrong - is that this code affects
> downstream projects.
>
> This is just not acceptable to me - downstream implementations should have been
> posted to prevent exactly these kind issues.
>
> We spent  time and effort doing an implementation and sharing it with the
> community - it wouldnt be fair to us to block this merge on the basis of
> downstream projects being impacted.
>
>

in summary and to be very clear

1- the upstream CID derivation is the u-boot/op-tee contract that
matches mainline linux's ufshcd_create_device_id(). The contract is an
OP-TEE-defined ABI, not a Global Platform spec.

2. Moreover CID-key is OP-TEE's own HUK-based derivation, not GP, not JEDEC.

3- Nothing here blocks anyone from overriding the static ufs_rpmb_build_cid()
downstream.

3- if downstream scheme differs, that's the cost of having kept it out of tree,
not a reason to hold this series for speculative plug-in infrastructure with a
single backend.
