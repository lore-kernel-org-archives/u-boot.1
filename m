Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21057606A32A
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 11:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Fm3i7+iB;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W5vkx6Oo;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MaSnCCNg
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DCBD240430;
	Mon, 16 Nov 2026 11:39:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1WEVKpYYq6IF; Mon, 16 Nov 2026 11:39:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3059240450
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794829167;
	b=QrHko8ZYHwp0JJgcnybLXBrO7wtsfW3Fryjtx3wfGfHRsT5nk0gnDUtKBykzZNHnwnDO
	 3JYhAGbo2f/db1ltLJNYjqWCbZWMLFHdRguoTWsJtTO/PIQph9ivP7mtCtQlMgmWHmCUi
	 2WZeV+/tM/mBGA6R4lyCRD6xAowGB77K5Ans7zAIkZfqrFO/6WqkwUV/PIs/z0TT54DZD
	 ysVA3bLwPZXzvnnCt7k7CylXHQxNax4fMYGkMtGw/aX+Fk+OmNSR5/4wJ9jIobsm3kJPH
	 22tYvzzLno5hj1aIieBKsK2gXXk6Yjd1rkkZqtxTL0kwlnLOofa/u+4rD2t2FK6dnVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794829167;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bQrhVz1X7UiOGb0tJjGvNMbrkKJbWxrN5BNVYI0NbsM=;
	b=h7Z2BbNkwvAs3S+enUbKKjT+nWSSGyth0h9DQFGKNNTG8qaza1zJaRlbq88imofYSEQe
	 mbNJUhUh0g3zC02aFKimp797mf2pWanJgGba0UWBaDugzAeqBQZC/HOg7i87uzOu4EzxN
	 XDQl5CZVpKHrWlxYWBX/WsESCogcgOCZZ9zjdTYk2w8yyfCQQCeqoP3L1Qlp/2ctIBQ/t
	 P+t1iFSGT5P3YXMdkDFATBTKSJjLNNthW3/2VB+r+rHdl2YgWCKbPwaisNOgN1limc7E3
	 Qil/Y5wxP2Kci4MOMCX4wJNv15KlHczbVoCWdoMiSZsEyKDjZLhtjquVeSlmXXor90w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794829167;
	bh=bQrhVz1X7UiOGb0tJjGvNMbrkKJbWxrN5BNVYI0NbsM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fm3i7+iB53ztv2JmCztqhsDpFwbYBq1/lGQyibcHAy1DMKrjuwIK729KAUlb+6WmM
	 +9w0y2MVm6YSAUKsrtxbHbZO6wiMjmr7nsMm/U/Y/vz2vsLTAVDSn/OeclqWVXg1Gn
	 fCPlSPcfqaEpbLislHoh8fGHLmsOfi7M00s/hK0k0NKG4xafQc93XDCGm1U76//l5v
	 B73IrZRn6C+YVVtLeiCoowbKQ8CokwclinhBNNo39Z0WnfpEOZLuUKb/7I1QaZX6Hf
	 cmoEmPQDo3tCsRIqNb5kGszowCehhBYE/k7kBNRBef3gEQbppbbJ+2gXsMLOc+plqq
	 H4t3V6mzPosrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3059240450;
	Mon, 16 Nov 2026 11:39:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EA46C28C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:39:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DBB0C80E29
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:39:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Fjr9oQcOG07 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 11:39:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D6E0880DC7
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=W5vkx6Oo; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=MaSnCCNg
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D6E0880DC7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:39:23 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGBLZp81465811
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bQrhVz1X7UiOGb0tJjGvNMbrkKJbWxrN5BNVYI0NbsM=; b=W5vkx6OoY1+shP5t
 eOJ3KQfvZ8qDz9jAp2Ddf4PvXh/CJbDsElQzWdBdsRp23kv2btzIkMuJ2Rt2Pbi1
 DQpV9nwX1Rr5d1ts8OAz9mBlSlwKIKmGrX9V/MCKFJcCzA2qQOjDmK9v/agY8KGE
 pqowRNqT2Od2V7UTC+D/j530YSJkkeSbUdcBASrfpRO/Sj7vc7Os3lHLXhxRZScM
 FZvXTKfzCJEcP/h5BD2Yxl6VzWQIKwAdY061OZdlwEBPYWSt5cQHWSXvBjRsA79M
 DUtZ07/2UN74l0aQI9G+f8YUdC3pG3SYHtKuSKNEQVMIaGaAlcAYFKh3D5dfEl+5
 6nXoNQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyxx2gj5j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:39:22 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36efb506f29so2774492eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 03:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794829162; x=1795433962;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bQrhVz1X7UiOGb0tJjGvNMbrkKJbWxrN5BNVYI0NbsM=;
 b=MaSnCCNgNs63Sz4RqZMz53FGJdLEj8LYssIQjwfKy4VGNPPr3pdWznVmXZmq9VnYOb
 c7eLE5H9t88kozQJ8116ktUMGUET7hT4uJ1bDGIa2J3hNHaVSQE5sf7nLeFjIJi1kylv
 MXBxfDcpQFENhuM+R18RGHpIlWEJ3N6TU9GvIVGdMX3kSdNkPeXve/rxFAGG6ilmDweu
 XwIgUHPsAoU9YkhvUdGUKTXkfdPEFGnO7PHjS8ImXsMnLO+VOvAhEWQoQrx9eKp96/od
 ydR2mMCmUVWdWeJ4YKxPKdnPHSUDA+FsWCYcoLqQkUrF7Sf3js9cfz2hSxIrABwxrgzd
 iU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794829162; x=1795433962;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bQrhVz1X7UiOGb0tJjGvNMbrkKJbWxrN5BNVYI0NbsM=;
 b=hecmJbuSb9QojeENm4XBvutlRfcGbww+YaFWS0OgwIcxAzWBlxxVY+DNkzZ3HJJt0w
 4braAgCpCARxKqvJzhtH07BK8VWMwyr+C2W1fvfMh77/LXHVedeclMdDc1+IIVHp0UQA
 6PcPSinFkdbEAZnUQKoPVvtT3Omutw3XdH3EfHw5R4jf+7cH3sDI3nUym/bZbJQ7R2Qr
 T1hrA39TRlChhhOxL11M15jZfbKAC8XscHP7na6QNvgtUZt/+H56bi18MN0mh5k0J0qF
 ocbwUBEE+7zbjvrNOPO52fUQ/AEgTSfBaKwwH0ZGQXtPdkhTq/XYtDjHoNavJqoF361O
 MG1A==
X-Gm-Message-State: APuU4Z//3dUj5YuSuFLLKLgoqW33a3+q+yHVUf6sTW1xleiJSYHLwl51
 QTfPH9CpSRC0KWfRmbnX9lE+unTNru4UwUi0tlrC/NP85svgqMnLV6xW2lYJaeMZ1Vga7yrd/2b
 KQCAs9EpyIxrSVqvzc2C0VzcAeIbF/pyOCj/6esWx22lh3AuUl46xs10ZuXs1FofDWtZxECo=
X-Gm-Gg: AZFdTZezaqqk4Pr+Njw23YdQOf59CWOw6tXUnQPf7ubQXwxyn/o171LWqQaAZH2FV2V
 ooYNRha8Cv3FPnaLYUaOi/kv/Si9i4o94d7CTpbwaC4AwWHyLnGSHK6VJ8zdc1WGWL10nkcaRKG
 JYU11DqYfmOUABSBQPO5ozNNNtLVVzH1dpHx92z73cFg3hjrPqmcRiFc1BQ+ZCTO3Xz3AMg02FQ
 Smg9qnVTEViPcez+P8ZeKNQL/o68yGzeKNYraQr7B6hV+sKr0ZK9RfgjEuf1Qfhq7Oghh5DqEqu
 8AVxE8Wc+sfh2UcWs2KSLX90qKdnBWdKaAIFpUOmAGniC51MJtpbfEeUW12Am+TKDfEreXSdBi2
 s9tEf9i12UOiaAeAUs9NtcPiMLsYhM8qB89/nqT8ml/wfOiadxyMkto3lfmEA2cafV1W8UxG0qu
 xxLhD+TXHlct07baw+D4b38kXLdJQzfPN8G1q2y8O5OIKvx5NbaGEFlp0FEYgJo99JCzghvDdm7
 pkUWg==
X-Received: by 2002:a05:693c:88d7:10b0:36c:bf78:967e with SMTP id
 5a478bee46e88-379656c93cbmr9660431eec.10.1794829161628; 
 Mon, 16 Nov 2026 03:39:21 -0800 (PST)
X-Received: by 2002:a05:693c:88d7:10b0:36c:bf78:967e with SMTP id
 5a478bee46e88-379656c93cbmr9660389eec.10.1794829160713; 
 Mon, 16 Nov 2026 03:39:20 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3795533170csm34412685eec.7.2026.11.16.03.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:39:20 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 17:09:11 +0530
Subject: [PATCH 1/2] gpio: pca953x: add ti,tca9538 compatible
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-pca953x-tca9538-v1-1-1cc09ccffcf7@oss.qualcomm.com>
References: <20261116-pca953x-tca9538-v1-0-1cc09ccffcf7@oss.qualcomm.com>
In-Reply-To: <20261116-pca953x-tca9538-v1-0-1cc09ccffcf7@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Francois Berder <fberder@outlook.fr>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794829153; l=879;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=BWI/JU4akJc9+eKAmCAE72/ye7Y+nwlzEKJh5qum0us=;
 b=rew1Jw75iFPlnGTY8T93m+BxtvnUVPSHR+mpBQWuuZhB4vzOFNzxFGxH72vOHRvAAt3uCTe+L
 PO7ZN+X2ghzBevm/GvmmxZ2n9oxQqbPjXKf1Ijxnbf9CQJPzOb6mkw7
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=R7WWitRX c=1 sm=1 tr=0 ts=6afaeb6a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=wTN2EcDjPmUuB1RCRKYA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA0NiBTYWx0ZWRfX5+fAeIUMkzug
 erbZmdc7lzuutETjPmU/YByE7Gt9ZSicl7pnEQ4c3w93cYUmFrsiKsTPHN/baeJO5mz/icD1HPV
 d6KlW3MB2nlfPsv/gh1PYm6XFt+mO4I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA0NiBTYWx0ZWRfX8KQWPvbFCU7m
 DJ4gOZjlQcCbFFssWyxJMAV0k97vD7jrprHv2ZE5gpwfwDAeHuCsU44LP9y+7QDZpMeeXyP2/dT
 pa0EwOY9KUJa97Pyb4L2lPlBrujjHVi6Gj1gHhGHgnf263jdO4avBhmLfIIXR9svaM3tricjPIS
 Pi5WlUIDEdCN7yzhX2yP32glkfkjaAIQVLDGOIjbDSWTxOBJN8oroknmD+UFvamGO74hSThRwXo
 IhYURr/x7qoEG5agF0+T3QSfYoaK/BOvg4Kqp04dSM7ZZV6UFNj2Xnm30p7jarYFdxSqLxuRMe0
 6EG2JHR1nJSjxWGbfYqdBztyWGC1fRpi6geSkZbK+2lC7xesE488ITlyZ/6dscbweKnvDgj/Gyk
 q7NqDiIXudkT3j9QO3D1lUCR22FDH/udB2ALta8cYY1j80WK0pXeSRm51aCYb/6fWk1MLxC6/da
 6HFo2nu4EKN3xdHmFgg==
X-Proofpoint-GUID: 5RBa49AhTpcboiBXmcuerPgdGcdNI1eU
X-Proofpoint-ORIG-GUID: 5RBa49AhTpcboiBXmcuerPgdGcdNI1eU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160046
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

Add ti,tca9538 compatible for TCA9538 I2C GPIO expander support.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/gpio/pca953x_gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/pca953x_gpio.c b/drivers/gpio/pca953x_gpio.c
index 965a5fcf30b..7088a49e27e 100644
--- a/drivers/gpio/pca953x_gpio.c
+++ b/drivers/gpio/pca953x_gpio.c
@@ -406,6 +406,7 @@ static const struct udevice_id pca953x_ids[] = {
 	{ .compatible = "ti,tca6408", .data = OF_953X(8, PCA_INT), },
 	{ .compatible = "ti,tca6416", .data = OF_953X(16, PCA_INT), },
 	{ .compatible = "ti,tca6424", .data = OF_953X(24, PCA_INT), },
+	{ .compatible = "ti,tca9538", .data = OF_953X(8, PCA_INT), },
 	{ .compatible = "ti,tca9539", .data = OF_953X(16, PCA_INT), },
 	{ .compatible = "ti,tca9554", .data = OF_953X(8, PCA_INT), },
 

-- 
2.34.1

