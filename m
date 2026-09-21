Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73132C982E1
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 04:34:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 74E5E80DE4;
	Mon, 21 Sep 2026 04:34:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cY1L5ObRQHVg; Mon, 21 Sep 2026 04:34:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AC26380DCB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789965272;
	b=RSg220y7J+wUtWEKi7whhAHq4Z6P4OPFoH2XR60uNzRnKAHbH7fZTt0uIHg1tcodgLJF
	 oozx/YtRS5brc/jAYN3bu1xZXKy0zhJgxcgG4ut7KVSnUThqvANoMVxES216cYDTFKgQN
	 XN+2jfghpEphdS9n0rPr1Gu6jM/BQB4zau73WArmuTAHcgeOY+MUXVLCLtZXwg0HeVvUS
	 tb89JvEHMww3kLchn5NmNhaRUlz8dVXSZlYIAkDEECoV/dWGnhexF7CP6UrVnU9AUESCe
	 ZkygwkcNwpCtVbkQQNJnpteu/EYBnMiT+g2Z7p8i942KXVEFRMKYDa2Jd/7AgYRkOaw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789965272;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZQhZIYPazQab+L0r861xUwUNwWHExRc+VpGqEklsUD0=;
	b=fjAM1GWaV5wOe0OhCiLazBg/vJPG+Y71C22z4+jqvFFDzZYez0XsGrH9CD6/TMtxF4PA
	 wBBhhWEMM9lnysbx+6WK4rrWU83brza2+7Dm5VHS/ATCjfAa0tE/2mV5l0dthnUh7Xprc
	 QJu52Ijr8JFI25PEd5hSo6vLyVn50r31HYE3j7G2Xs7/sdrSpjyCaLkdyq8DFpqM5NhbX
	 NR3YCgJB8VCt8ezDacLS6s1ndRCa4CVI3/kyxPDUkjtyUcDWlF+Z6dyigouP35iZYB4JW
	 VoemZMXhJrwN0YSlKNoo94v+s/rGZn+WwfpNOJ6XHhne4XcztgxG3Ry3etxS2ibZ/Uw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789965272;
	bh=ZQhZIYPazQab+L0r861xUwUNwWHExRc+VpGqEklsUD0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kDur02erxyJrJv3+MuSlUSL2Rt15HnFhJSF5/4NJh287DaIDTIAWKv2e5xtruDwYS
	 t6OIHEG6IE8osJ0y4nsHfpBAPAY7WWuSEBYb6enroM70W+0USMqNJbxNK0vQqQU89e
	 v/vFbBKV8ihZVWwWKqpHOpJi0fzJ+xYL6O8TFGeUnPNfMgrqpwPvW1iZzhXHfPLpVq
	 zy0CL57E+avSprH2oLG6Wp0+gCnzWxXBgu6eMQXllZaBPP7jLhieF0gvQEgO2hfHDh
	 XMqeoSlimfdO7HOPyXKGaUpnJFFtc7jGSJpmWxh+AaqzujBM/L1eMwmos4T1KskxJE
	 JzEuPbeDoMFyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC26380DCB;
	Mon, 21 Sep 2026 04:34:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A03BC28C
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 04:34:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 925514008C
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 04:34:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mXhRQFIRP2hR for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 04:34:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7352440080
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789965271;
 b=h5AqBMnA24hxcOZso3pLSgEWFX1JEX6FFDGJlCX7rwtOhWBWLN2nVTSh6dzNLPgoz8FN
 auLf5xEh2GLksHZo1ESvbUJEJogL9XyigHbW+ALJNasxzbmqxGxmvi1gXbs4Xy59cvkga
 8hjG9XMvuMH6gvNmdx6pZeVnJVABh6Be8dHm6MLOSuNXw9xZyzEXEWhN0ze7QbuN5bhH9
 aIWHZOcUlaVswZKlCx8yNIxjGMsHoeweCsQE6I3X8OKFPWKg8CprQfxzAnxtbxNmT63/e
 WL9huRgyJ3cVZqcYFhjpHrI8fV928GcHaPeY4U00+0b76IvJ8cVRVP0VshWXE1LF52Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789965271;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=ZQhZIYPazQab+L0r861xUwUNwWHExRc+VpGqEklsUD0=;
 b=smP/ANjBfzxQA5ngFLiVBpQM0x3BZdIT/dHbarQz6333OgmYVZQiWxdTszlGaIEF081W
 ZU1X3lZUbr/7Vlq37W2JM1nqPKW7Cwsj+f4X2vQVU8lmijroHmqUNVBzkpVfF6FFcWpB2
 EQEhcJEhz9+uDQunyA531c55cTJBrqZc83AtzmOpU7k3wtFxDVaJx+Po1csPF+d2la5BJ
 BFPXeWo8MSCVUM+uf1ujm2qdVWnaHeCYMRU6xDwluYlqtp2UB6hYZZLAMCYX/gksnpkOy
 lZUr2XasX4yXHSQZSnuNpGP7AX/9JhZj+hFnysvHalBeosVq2yzPKQUd9jS69MIztJQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=FSrKa5xA; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=S97JY15t; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=FSrKa5xA; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=S97JY15t
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7352440080
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 04:34:29 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68L3ZbiX635556
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 04:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZQhZIYPazQab+L0r861xUwUNwWHExRc+VpGqEklsUD0=; b=FSrKa5xAAIXWOHw4
 2uN43Cggo7/kL9LL80DmmnaWNWeUJUWSIVRW5FVzig75qU2z37yeFi628zyWXJlf
 Enku4ig1qcFuBSbUxtx31wL5ispG/WZDHH2wlLPkxsqj8q6/0yzTCbZkJI6cjg9V
 tfp2T2SjjqvubuaAlkQIH0MNxjKtjVLQGwMc7OoZOUb9w2vrY8VLFBiNQbrHTKHu
 XGa2SJA/MR+A7ESUjWVO3nVTP+cUA02KfYVEH2P0qRvvFdLVf69KGo1uSOcl/ej9
 RcmFhheZY79dCKWkNrYRN3R6iaxJJpldBCfFmpBSyHkz12d2uGsFV/xGhbyLsgsS
 ZBqsxA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gshyxvq7r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 04:34:28 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-862a0aa7d2aso4230670b3a.1
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 21:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789965268; x=1790570068;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZQhZIYPazQab+L0r861xUwUNwWHExRc+VpGqEklsUD0=;
 b=S97JY15tKU4J67YtdWhtKoOIHSK6C3di6CiRXCmchEfusIy4yBtazXhIJQyd0QoVwY
 +FesT3ZoRtloBKTU1gscfHKqo9kfg4aNS74+41C4LPqCKtnBl+qZu6LCFrUgysuDKMBM
 3igxqN+CqYztB4R19SAEqnAN6lLi7TXncrAkWBOfZFuW43g34+miosXO08LL+tKPXBHi
 r26oQItyU1WxCnbmGOyug+oX/R8cTEuLSDPMQUkJPpc8swAGYAP1mfnMBmt0bab5CDhj
 4UeqT6GDTOwPEV0DAoVXLd+hxQHsCzJjhWSBcKAhsd57H7e3dYN5/SiVdPFkfQyVtqpz
 KvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789965268; x=1790570068;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZQhZIYPazQab+L0r861xUwUNwWHExRc+VpGqEklsUD0=;
 b=Ao0THwbN8NVgGpFz1TERJQmCngeDtdpZIeBsUmAfEkcm3DJdNoF4gsRK8H6Xim/g24
 uhJ4TmI59WGw9Iog0jMwZRMiZn0x6O3MXMVugCDiKsqlmSUFMytDAmK/zeRSYZltT/Bl
 cblbUfawv3DRrhgvEk6NG8BC8c+qhutYCUTGneb3W+RyXvJiY23vyD+pg8r56zslbt8H
 U+X/ZDTuyTDuSxu9+V+psFj7Hova0G5Fvh+aBscy1OPeiciTT3qd0skmoj/IyocWPfz9
 3KkhjAZaI6wn7Za40LzUwhMyoNHXiIyjTnxWtn8+Jw/OiuzICezwyUCmUIApFW+M5ZcT
 A1Mw==
X-Gm-Message-State: AFuF++kpncjgoqiiYm7fq5uH6pqQLp9HsVAjGxDSLDRoM4qc9tGMjBHi
 WbWdCKaPM6Uu2slBxgqh3p2wDC3348QoPvKjit2IGjU4E1lcmw5eh4LBeb+LH2ev8U82TJpmFoo
 UuBtkG9PEeho8utVP8RPod3CfjtBcbtcZ+rW0FJH1Srec7/swoFmnUdYsjLfUjbdN2kDH89I=
X-Gm-Gg: AYBFou0H4Uec/+8l5Gf454i1H7eZunQzeqbeepkiufyIkB1swdItA9yLd7t8+16/e96
 5ZLOK0rBuuCtrlA0f1WHxCUGHmySPrWpIuujasJwAnHnO6SZUFsAOky9O3tEcHTwzWcFIAX2eAa
 5aCTidcurXY36dS+ABW/GjG32wEcBPqmzBtQZeXzJmooRlf9KyurZFBTmFyuLQa3b2dlqRYq7m8
 S9JMSrhncymTL5Z/MNOPEkLTK5uwxp5eZ8AGDLloEJruIfCR2y7joxINnwqVlj88Vluauyqh68z
 +Bw5bYNsAGLbI40yAT1ie6vl1bB1TUAxOKXi3APl0MJsuVsMqgnMc9+hrKJwE5vSCdOPwugRh3T
 SWwrP+x871IT32bYMZBkd276UuohiaYPzgCW6eUS3w1s62OISo1CA/AY/MHATZQjPwe9VAFpZNy
 yCzElchxuiVTZ34wqKUt13e8I27/9J
X-Received: by 2002:a05:6a21:e8b:b0:3d3:ae40:51e3 with SMTP id
 adf61e73a8af0-3dd8c53b507mr13790732637.23.1789965267726; 
 Sun, 20 Sep 2026 21:34:27 -0700 (PDT)
X-Received: by 2002:a05:6a21:e8b:b0:3d3:ae40:51e3 with SMTP id
 adf61e73a8af0-3dd8c53b507mr13790716637.23.1789965267296; 
 Sun, 20 Sep 2026 21:34:27 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c331d55cfsm19427279eec.30.2026.09.20.21.34.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 21:34:26 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 10:04:07 +0530
Subject: [PATCH v3 3/3] configs: qcom: Add qcom_lemans_spl_defconfig for
 Lemans EVK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-spl-lemans-v3-3-de4b54320c71@oss.qualcomm.com>
References: <20260921-spl-lemans-v3-0-de4b54320c71@oss.qualcomm.com>
In-Reply-To: <20260921-spl-lemans-v3-0-de4b54320c71@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789965248; l=3944;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=AGjEUFTquEAtZh4P5Qf2CFAW9nS90+Eq0G/oJ3PnSwc=;
 b=tF8QqNuXHCalrFff8b44NJvkReAGlFgx5O9X34qL/f9eFU/s5g07Fws7otLIhqSp03F9tt7E7
 ntro4SJNk2UBOo00pyDD3IqXp2B5XvqF5x23gA9s7vkN2OSODdJccDC
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=PaRqFShd c=1 sm=1 tr=0 ts=6ab0b3d4 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=MIDpp_XfdsXPtEUIc0cA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDA2MyBTYWx0ZWRfX6r8L3SsmwwJU
 fIBCNY9Grbn73yAMuKSX4ZOpggNsPQde9H+upS34U74hllBsfiTweA0iuW0b5psOyZRkZBjXb98
 nZlsL6O2XudrM+mr9RB81nhDwMy6C3Q=
X-Proofpoint-GUID: NIMdfpVLiGh1Hv3bIfvvASiPuvYkY88P
X-Proofpoint-ORIG-GUID: NIMdfpVLiGh1Hv3bIfvvASiPuvYkY88P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDA2MyBTYWx0ZWRfX6sT3OLjONsOM
 rWyuvRHJQdkxaRD542fXwFuL4YSOhHF/qKOf2CWYIm9FebT2bQyHXC5ti3SIOL1QInpqDTMJJVy
 0Hjkm7I1E43kPnJcZtCM76MCyWrnJ1zj7VVG9FD0rb2hWmUYwy4nwGHzj2AhyM1xtEF+sKzEYr0
 EPFXdWIixxmrTqaKRfyftO6d/eixiiPZtZFTICEmMzYeVINYJxEpjC3iJZ6bOebGD77rO/j8LCc
 +9QsUXQrMkqO2sucNsdM+5MckBphdD9UJiKobvwgUi3woIuGOv9LqZnOyMaCuxR5nz1sTpElAWK
 j1cqM8pYYFLb0bBKdte3ZcpLH2J1Q26ggMito0jtKfOgaw0+FegUPVJPbPjuV+aWwypVVmSFHbn
 MD9mX7oaKhgVmZUQxVTCwvQtGTVvOE/GU345QKEslQ2ctAwTPMTThyLkgNrpiytC7g30wnSuVju
 5tcNOn8FE5bsIX6B0xQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 clxscore=1015 spamscore=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210063
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

Add SPL defconfig for the Lemans EVK board. The SPL loads a FIT image
containing TF-A, OP-TEE and U-Boot proper from the "uefi_a" UFS
partition and hands off to TF-A.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- Drop CONFIG_SPL_FRAMEWORK_BOARD_INIT_F, since board/qualcomm/lemans
  now provides board_init_f() directly as a strong override.
- Drop CONFIG_TEXT_BASE and CONFIG_REMAKE_ELF (U-Boot proper build),
  matching the qcom_ipq5210_mmc_defconfig on the new architecture.
- Add CONFIG_SYS_BOARD="lemans" to point the build at
  board/qualcomm/lemans.
- Explicitly disable CONFIG_SPL_MMC and CONFIG_SPL_DM_MMC.

Changes in v2:
- No changes
---
 configs/qcom_lemans_spl_defconfig | 109 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/configs/qcom_lemans_spl_defconfig b/configs/qcom_lemans_spl_defconfig
new file mode 100644
index 00000000000..4f556c916c3
--- /dev/null
+++ b/configs/qcom_lemans_spl_defconfig
@@ -0,0 +1,109 @@
+# Configuration for building U-Boot to be flashed
+# to the uefi partition of Lemans-EVK dev boards with
+# the "Linux Embedded" partition layout (which have
+# a dedicated "uefi" partition for edk2/U-Boot)
+
+#include "qcom_defconfig"
+
+CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
+CONFIG_DEFAULT_DEVICE_TREE="qcom/lemans-evk"
+CONFIG_ENV_IS_IN_SCSI=y
+CONFIG_ENV_SCSI_PART_USE_TYPE_GUID=y
+# SCSI partition type GUID for logfs partition
+CONFIG_ENV_SCSI_PART_TYPE_GUID="bc0330eb-3410-4951-a617-03898dbe3372"
+# CONFIG_ENV_IS_DEFAULT is not set
+# CONFIG_ENV_IS_NOWHERE is not set
+
+# SPL configurations for Lemans-EVK
+# Purpose: Load FIT image (containing TFA, OPTEE and U-Boot proper)
+# from UFS storage and jump to next image (TFA)
+
+CONFIG_SYS_BOARD="lemans"
+
+CONFIG_SPL=y
+CONFIG_SPL_BUILD=y
+CONFIG_SPL_FRAMEWORK=y
+
+CONFIG_SPL_TEXT_BASE=0x1c100000
+CONFIG_SPL_MAX_SIZE=0x60000
+CONFIG_SPL_BSS_LIMIT=y
+CONFIG_SPL_BSS_MAX_SIZE=0x10000
+# CONFIG_SPL_SEPARATE_BSS is not set
+
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_STACK=0xD7300000
+
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xdb300000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
+
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+
+CONFIG_SPL_DM=y
+CONFIG_SPL_OF_LIBFDT=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_SPL_OF_REAL=y
+CONFIG_SPL_SIMPLE_BUS=y
+
+CONFIG_SPL_DM_RESET=y
+
+CONFIG_SPL_CLK=y
+
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_DM_GPIO=y
+
+# Lemans boots from UFS only; disable the SPL MMC path
+# CONFIG_SPL_MMC is not set
+# CONFIG_SPL_DM_MMC is not set
+
+CONFIG_SPL_UFS=y
+CONFIG_SPL_UFS_QCOM=y
+
+CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM=4
+CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR=0x0
+CONFIG_SPL_UFS_RAW_U_BOOT_USE_PARTITION=y
+CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME="uefi_a"
+CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM=1
+
+CONFIG_SPL_PARTITIONS=y
+CONFIG_SPL_DOS_PARTITION=y
+CONFIG_SPL_CHARSET=y
+
+CONFIG_SPL_PHY=y
+CONFIG_SPL_PHY_QCOM_QMP_UFS=y
+
+CONFIG_SPL_POWER=y
+CONFIG_SPL_POWER_DOMAIN=y
+
+CONFIG_SPL_LOAD_FIT=y
+
+CONFIG_SPL_ATF=y
+
+CONFIG_SPL_REMAKE_ELF=y
+
+CONFIG_COUNTER_FREQUENCY=19200000
+
+# CONFIG_SAVE_PREV_BL_FDT_ADDR is not set
+# CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR is not set
+CONFIG_SPL_ATF_LOAD_IMAGE_V2=y
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0xB0800000
+
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_MISC=y
+CONFIG_SPL_QCOM_GENI=y
+CONFIG_SPL_MSM_GENI_SERIAL=y
+
+CONFIG_SPL_BANNER_PRINT=y
+CONFIG_SPL_CLK_STUB=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_SPL_PINCTRL_QCOM_SA8775P=y
+CONFIG_SPL_QCOM_SMEM=y
+
+CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent interrupts reset-gpios"

-- 
2.34.1

