Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC483C982DD
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 20:07:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8032E60EDC;
	Fri, 18 Sep 2026 20:07:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NODrcKoLCjY6; Fri, 18 Sep 2026 20:07:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 87ED260ED7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789762021;
	b=iypIU6iFheV2RKgeDK+N2UtK/P+pv2a4rUw5EhlyZoZAyYBPbgpPiL6pDuSJCXC55B2f
	 y6DvV9FXmpvZz+rHT6VRv5hknEoYOwc9xA3ChflQpLXcI02VMma5qaKH7R35jFsS2B4eL
	 IfixvibxqXj+xFWvZFcT/s7scdxviBAR4bmdzmQsvEdn/kEwv24vUnUkmfZdh3hfgYrip
	 qFksVWttd/q6Vz5FBft/owbgw3ylzJGwJH4bCjICkIZK3lGet6qWwm2MrtcWDtKB5snE4
	 Hn+VbSlWYwa7N/VLo7PK5g56lpBSsMc6n+gZJifEsWT33WcFPCdyrfkmfq0LFi2kh4g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789762021;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TfB65bvjaY3DEHRSJrK0FfVlGwiSfS9I9+mqbEC3bTw=;
	b=VeC2iEYxX4YeWEF0xr4v+E+/0O16laoGWN8SuNZdmB0fT6Pexg759JdzkxjvOu9QDSBc
	 UCBeRx7RUgKBb8IPHp8vUkzV6Rpd5JbizvZhNBMeNEmAAqC6HdhTZoKSxK4YGmZmk9pLl
	 Mom3kQTsP5C9WgrqzzlapE1KNA59dUee3UDqt0u0J2EfEG6xDNeuq9DS/jCmmJFNoSo0v
	 h5ioUHkkaOAGbxh9ZXnBpSLgY1gtXWzYOmJNQH02GrZabZaTOPzHYxgdTTBbQSumEpNJR
	 mLrwMqXZgvMQZ7e35bBCdZb/Xge+4xxHKgCix0cKmVbFGoAY2Yw6m+a2qpGBKGaAKFA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789762021;
	bh=TfB65bvjaY3DEHRSJrK0FfVlGwiSfS9I9+mqbEC3bTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BHgLefRHYq5nMjBOjsTt5Z2qdL0Qj6kgCtK3sfTLYvlTzhu3jwRVXNkHK3oFZFpdd
	 zbsE+kskgt7geyY0XoTs+pmAAq5TUzJlPEv9qQR8Y3zM6CFqMXRPaL0ds2PHLNEFO4
	 AEU7ikvdhMuHvcIp/f7UrOUBsfTi7Mdh5peifw24hcCjDsM4plsCs4H+d+Gbbh7t+f
	 RsQeNcp9Ls6A0hwzMbk5fKXZlv0EnP+I/Yo8uFb/2+0dPxTe8486KsRy/hKwNMt76e
	 XLRlbLKxIC/ua2pLwC6dxARIUcysbTu1+ceDD+EdZ0fCa/OoMiJelxoNCXo3yuqRJ0
	 ErN9sQb4E/UAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 87ED260ED7;
	Fri, 18 Sep 2026 20:07:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A861942D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:06:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E9FE7400F8
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:06:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VbXgKeWi2U9v for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 20:06:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 28C5E4006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789762017;
 b=N46sSimQ+8gl7ZZyp7aMtt3/96Rten1wRmP+e+Z4Y+p8znq+6H7v8/KTOPdLX7hZgviz
 vw3U13OEPXITTb8JMw5yrtkz6/CmmP2Cx/aDvcOvJg3M7i/YPP7vIqxmhnHhce4Ek9aLe
 L3uhhLsUDp8L2VM+005uFLxy0uuH6H7XwxXLNOgwSwQDi4cqnQ/fEwumIy+te0WtW5fIT
 HZVwK2zJIw1HyXgtl3zNCEGgBEvDE/EDlT5b6pXRuA1F7xUaEtMRKSVRvL6hJP5H4II3l
 P+y7mN1nHXLEQC9IHb/1GxYiN9hfB/09ECcmGXvkKpsdYCNIOgf9XbgV3RjQTiOGBMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789762017;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
 X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=TfB65bvjaY3DEHRSJrK0FfVlGwiSfS9I9+mqbEC3bTw=;
 b=AYdr+QNP6aw2Flw+OSb9xUbTzF2Xe51B9S6xma7feUvzY+EuWcrOQlefZitSS+rwp8Vc
 lyeMY0zzBoD1kna5jhx3tGC0Jtfuihas6WfiCL+hLTF4BCXX3HlxwBix9LnLPd2bD1AVo
 u6qPJ/UmAC8R+XFweug7v4MttNrw1952a/Ejtgal88cB4P/D7va6oSyOJDcKRkhdB7v5G
 EwWbwcGtC5S1IDGGh99mVe0OB7jlk+9kOX/2OzM2JLqF+I5dNM3GWzsVp9z9k/ipQEecb
 kXo8lNfGsXZx2rD7ftpYMUdyeSu4zGJT8wgTLSe6oZw1bUYhVMsaJV4s0jF7HtILv+Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="ajWsws/N"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Fjdaa4t9; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ajWsws/N; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Fjdaa4t9
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 28C5E4006F
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:06:56 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68IGojB71101802
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=TfB65bvjaY3
 DEHRSJrK0FfVlGwiSfS9I9+mqbEC3bTw=; b=ajWsws/N96imwCHW5ZVFPwx0UCH
 9nCbRA7JUUYwFImdjCh7U6LtgZi63+2VanBpj3/DbVkVIZExFCeSECF2QOs2/ON+
 AE84n7SzPnMUzO93d0zNuDKEb/dNWTzbAW/60kCbwFLaopsrpnRt0V7NMsRsh3Qn
 siuWkFfs34PkEEg4HntLloechQ2RrFrFy9RYGOX2K7sJKJLgvgrCZG+ewtVRas3i
 S2xxrosNEGcgStvPtiZdyPrA4Bxf4I90oLKctJbv8yzc5Lme2qlxACLHLvawC0gq
 P66hz689Y+VHpZxbHsd44zJH94cPPGLl1C8gPPQUbPoFSkupvHC4DMrmwBQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gry2bukg1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:06:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93918756165so225613985a.0
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 13:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789762014; x=1790366814;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TfB65bvjaY3DEHRSJrK0FfVlGwiSfS9I9+mqbEC3bTw=;
 b=Fjdaa4t9nMR4rUGoIgy5fq9e8imHxI+GikGThg/XOnCP6K8U7i2y3mO7i68e6KMnsx
 AdrMDYIC3UqNyVCrSRlOi9PHWtS6gKPUYHQeYLr4qJ7bOKVYMutaVyGJgVA2r44jHyjS
 2U9I7RysfapQtJBultj6PupAsK0xBHe+5oVXFNw+YwF2IWnlLUL8UuaNWUuxc4MFsq8y
 DFdLVyz5sz6jYEgeklxH7YWK2RZL6o1GHvErERS6E9qWuNr20k9YQpCskqk4kunSx9Yl
 M6R9sa8F+x8pqmefmWM7tH8lLSh6acewoDD2J8Cmec7lwKclw+taDZ838G+LLW1letvM
 mFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789762014; x=1790366814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TfB65bvjaY3DEHRSJrK0FfVlGwiSfS9I9+mqbEC3bTw=;
 b=xSEPkDPGreakHGM3pR9xEwfhwE57ZXy1rDsetgH1+LZA6ntjn0B7gNE3chuCZDVIMT
 YJiX6xNjGrHSQdaoVHQdJPHFBmAfx0gmCUOyxId49x9KR5eI7oRQTfPz4q6mQJO6qvwD
 5YBPrTOTrLbM3599Dnz3n2SdNDd4Ryonv5GdiXdTydUp1ViVA5oKQR7WbsRAOGOylLMC
 O8snnpz5mBvWLbDKEG3P6+F+MUMRJ9d5TWLpzEL4QvKUyhXXP9xBcILhV8YlipMeSlCv
 FdC6RCKESxQWwiXhBvBczZTsTiXImzZz3J6GYLBIF1UWPlcxxXSHhA3AVLtl3rXXydQh
 IQSw==
X-Gm-Message-State: AFuF++l+p/yespnm77ErPRKjUfIWL4H7npfILMP8dNAzymozuhhEgReZ
 9+yNMezqMSRA2TigL8L/UDEkDUKUivmJYPZ/XQfcCya83cjXzyOxiTIBnn1zia/yASiOn0GQHmF
 kV6GHpInYU6JmRnZnLLQ8hi1IBn6LVe2VDA5OaJIEFGn7YFJzFq7l1PYAJJr+MrQpQMhULAk=
X-Gm-Gg: AYBFou3GOB7RgfI+ijfklqMxpFSKDLQI3J63dBd50q6bHvBxBYMXZxVCqQ9Vx0YGArK
 9Rq0toKC5wetNK3ZjACFZ02k/00vbKzYJ1RyR2wNO7q3B8/4rrnHWT5IYZ8iZa+BLcakfy0h1qT
 2691Fm+WReV1pK2D4aaT1NmFt1zUlxOvSiWrJaqO6TYCDhNJVBPR//dCBfBaDN6+4iKejpSXsTy
 /nNIhq57HimOghmgobREM/HySOomyAHG3XGM3p5ApGrLCFVgV/Z6nipBvkqzrppH75nHpy+0VdN
 vb1aHUZBOX3VPFS8fgp06unIDriU4Dg+HfaUDadLDOe5wXVxGqXlQ2peeHSawTX+kNGWTKQ1bN/
 56Eb8i9d+Trnnu1I6+6Zs8i6piPMYMuVKQ1x8tCX183pgeJ4=
X-Received: by 2002:a05:620a:90ce:10b0:93b:e6d3:b33b with SMTP id
 af79cd13be357-93be6d3f4d0mr262320485a.59.1789762014045; 
 Fri, 18 Sep 2026 13:06:54 -0700 (PDT)
X-Received: by 2002:a05:620a:90ce:10b0:93b:e6d3:b33b with SMTP id
 af79cd13be357-93be6d3f4d0mr262280685a.59.1789762008836; 
 Fri, 18 Sep 2026 13:06:48 -0700 (PDT)
Received: from trex (250.red-81-38-139.dynamicip.rima-tde.net. [81.38.139.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724596604sm1136798f8f.30.2026.09.18.13.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 13:06:48 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, dlechner@baylibre.com, trini@konsulko.com, 
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 neil.armstrong@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com,
 xypron.glpk@gmx.de, s-vadapalli@ti.com, michal.simek@amd.com,
 jbx6244@gmail.com, marek.vasut+renesas@mailbox.org,
 sumit.garg@oss.qualcomm.com, jens.wiklander@oss.qualcomm.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v5 1/6] ufs: decode string descriptors as UTF-16 big-endian
Date: Fri, 18 Sep 2026 22:06:33 +0200
Message-ID: <20260918200641.2286077-2-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260918200641.2286077-1-jorge.ramirez@oss.qualcomm.com>
References: <20260918200641.2286077-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDI5MCBTYWx0ZWRfX8FRQGHqXPBoC
 toRTXH2nHuVBb8RKJglxh7acMbobjBjs62tJrwzk5zh2qIVZgXoeXL8c7tysYtAnnHHaVVOM6Xg
 yqoL0KMnjYNWh0ocYTufjxJ8zkq9wbxKFC75MHhUXK35wgbn1xA1Pnjpdwn8KHD8hP9MdYfs2eX
 IOf9li+gJEI69R+p4Y4WCLgHLMNBgtdZPGysEfHEpzY72kw/mqfse0kPaHsFpbLsoWkOLdyyKw+
 pEkGOvoNuAavmEJrpauTlyLExP/g7bmtgUoNZtO9zv/YeoQQ/krh9Y+WVD1ykBFw2WvoisGddTl
 gH/bBVmVMQolpv67NK7F7ctHQuRaqKAicE84MbyqGgGLmP++F60I19p3c98uOVyAnULTRRL3cSK
 ff4vF8ITJGcdiDqvCAblKBbYJwiDe44SZg/zgenJlFeTc57c/5Ah9WKCBpmWzoXKxJkaVOSqVFC
 0tkDnSh9Xb5kHw8ZwIg==
X-Proofpoint-GUID: AOyJLIi-PnnBQxZ6D1dLjByd29kEOpgl
X-Authority-Analysis: v=2.4 cv=bYP+w+PB c=1 sm=1 tr=0 ts=6aad99de cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=N2KLPU99T7rsMuN2xAoQUA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=aGQo9Yp8QdT963r2dccA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDI5MCBTYWx0ZWRfXxLWRS78OaZsg
 HFOXlJyssn98PcaSREk1s1oTAQPMXvy3ePj2iVQ8U0sugguoD8VGmHqge09QgYJP+Y+PivrPdum
 zO0Yyx7PFJqgWrRr5YeORBXqFARF/IU=
X-Proofpoint-ORIG-GUID: AOyJLIi-PnnBQxZ6D1dLjByd29kEOpgl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180290
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

UFS string descriptors are UTF-16 big-endian (JESD220), but
ufshcd_read_string_desc() decoded them as host-endian and so left
dev_desc->model blank.

Give utf16_to_utf8() the source byte order and decode UFS descriptors as
big-endian, matching the kernel's utf16s_to_utf8s(). The EFI file-path
callers consume little-endian UEFI strings and are marked accordingly.

Fixes: 067c1b033282 ("ufs: Call ufs_scsi_bind() from uclass .post_bind")
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/ufs/ufs-uclass.c  |  7 ++++---
 include/charset.h         | 17 ++++++++++++++++-
 lib/charset.c             | 15 ++++++++++++++-
 lib/efi_loader/efi_file.c |  4 ++--
 4 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 6ef01f8e4aa..21aed9f97bd 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -1767,11 +1767,12 @@ static int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
 		}
 
 		/*
-		 * the descriptor contains string in UTF16 format
-		 * we need to convert to utf-8 so it can be displayed
+		 * the descriptor contains a big-endian UTF-16 string, convert
+		 * it to utf-8 so it can be displayed
 		 */
 		utf16_to_utf8(buff_ascii,
-			      (uint16_t *)&buf[QUERY_DESC_HDR_SIZE], ascii_len);
+			      (uint16_t *)&buf[QUERY_DESC_HDR_SIZE], ascii_len,
+			      UTF16_BIG_ENDIAN);
 
 		/* replace non-printable or non-ASCII characters with spaces */
 		for (i = 0; i < ascii_len; i++)
diff --git a/include/charset.h b/include/charset.h
index 348bad5883a..79d0ae1ef49 100644
--- a/include/charset.h
+++ b/include/charset.h
@@ -13,6 +13,19 @@
 
 #define MAX_UTF8_PER_UTF16 3
 
+/**
+ * enum utf16_endian - byte order of a UTF-16 string
+ *
+ * @UTF16_HOST_ENDIAN:	code units are in host byte order
+ * @UTF16_LITTLE_ENDIAN:	code units are little-endian
+ * @UTF16_BIG_ENDIAN:	code units are big-endian
+ */
+enum utf16_endian {
+	UTF16_HOST_ENDIAN,
+	UTF16_LITTLE_ENDIAN,
+	UTF16_BIG_ENDIAN,
+};
+
 /*
  * codepage_437 - Unicode to codepage 437 translation table
  */
@@ -299,9 +312,11 @@ size_t u16_strlcat(u16 *dest, const u16 *src, size_t count);
  * @dest:	the destination buffer to write the utf8 characters
  * @src:	the source utf16 string
  * @size:	the number of utf16 characters to convert
+ * @endian:	byte order of the code units in 'src'
  * Return:	the pointer to the first unwritten byte in 'dest'
  */
-uint8_t *utf16_to_utf8(uint8_t *dest, const uint16_t *src, size_t size);
+u8 *utf16_to_utf8(u8 *dest, const u16 *src, size_t size,
+		  enum utf16_endian endian);
 
 /**
  * utf_to_cp() - translate Unicode code point to 8bit codepage
diff --git a/lib/charset.c b/lib/charset.c
index 182c92a50c4..8ccac4048c0 100644
--- a/lib/charset.c
+++ b/lib/charset.c
@@ -5,6 +5,7 @@
  *  Copyright (c) 2017 Rob Clark
  */
 
+#include <asm/byteorder.h>
 #include <charset.h>
 #include <capitalization.h>
 #include <cp437.h>
@@ -458,13 +459,25 @@ size_t u16_strlcat(u16 *dest, const u16 *src, size_t count)
 }
 
 /* Convert UTF-16 to UTF-8.  */
-uint8_t *utf16_to_utf8(uint8_t *dest, const uint16_t *src, size_t size)
+u8 *utf16_to_utf8(u8 *dest, const u16 *src, size_t size,
+		  enum utf16_endian endian)
 {
 	uint32_t code_high = 0;
 
 	while (size--) {
 		uint32_t code = *src++;
 
+		switch (endian) {
+		case UTF16_LITTLE_ENDIAN:
+			code = le16_to_cpu(code);
+			break;
+		case UTF16_BIG_ENDIAN:
+			code = be16_to_cpu(code);
+			break;
+		case UTF16_HOST_ENDIAN:
+			break;
+		}
+
 		if (code_high) {
 			if (code >= 0xDC00 && code <= 0xDFFF) {
 				/* Surrogate pair.  */
diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
index 19b43c4a625..7dee57d594a 100644
--- a/lib/efi_loader/efi_file.c
+++ b/lib/efi_loader/efi_file.c
@@ -184,7 +184,7 @@ static struct efi_file_handle *file_open(struct file_system *fs,
 	int flen = 0;
 
 	if (file_name) {
-		utf16_to_utf8((u8 *)f0, file_name, 1);
+		utf16_to_utf8((u8 *)f0, file_name, 1, UTF16_LITTLE_ENDIAN);
 		flen = u16_strlen(file_name);
 	}
 
@@ -216,7 +216,7 @@ static struct efi_file_handle *file_open(struct file_system *fs,
 			*p++ = '/';
 		}
 
-		utf16_to_utf8((u8 *)p, file_name, flen);
+		utf16_to_utf8((u8 *)p, file_name, flen, UTF16_LITTLE_ENDIAN);
 
 		if (sanitize_path(fh->path))
 			goto error;

base-commit: b8e0086b585791a771416ce51b58ce0097bc0b28
-- 
2.54.0

