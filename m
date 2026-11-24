Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F927606A323
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 16:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tx4jehH/;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dkSl2aZf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RMGYj4Ft
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5FC4E80DD1;
	Tue, 24 Nov 2026 16:47:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UWfed8Vx1ON3; Tue, 24 Nov 2026 16:47:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E9D5680D6F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795538847;
	b=rIO59stzA0sKI1dZYxJX/D8Ky4pCTcIgr8P8pq9rdA6p3+pJLZi76Z5wexRJvqmVPJ10
	 fg477uQcHjISO0+i6AToMBP57Bkk6nVV2Pv7CbPIiIoXko4pTj9jEJtU0AOksm1XPyVh6
	 d9yimUYYdbDztxLNhcHT0HYKLiK3kGf5nNvgkGJJPxZkbtna6a6GUUxA+OvJN7pMAfuUC
	 Udf8zsvjXv+ofOm7bwAZ2t6lPRTADKifRyyjhZqxSxBl1rRaBl/a+rBFNJqsWad9AvAjd
	 mBps0ic2KM6rdqxviUr7+YgX0V3LsNr/1eKzQZ7Vk/eNVMJ0y2pzvq+SQVrj8fX9k4w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795538847;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Z9szmJ5yPLDTyQO8gjw7y4QwOIN4aq+TyI+vcS1EV3Y=;
	b=lrAD5pPtiHTCBUYL/eiAnmWi8RiluxmK2s2dkPVQ6vzKv7yHsX42BfyTcwdocD9Q/ZF9
	 5riW2z+41MZhYQhdE8khkq8IKe/T6BEYpfy12eLPakjWESJkPvG4eha1ygMdXff6aEoaW
	 2qYJFyQl3ltryse7PnY2AoI4Fujc9vFO2wdjmTMmbyNWSRgM0eyjONQgVquGmHlP9Ffz6
	 rTQ36ZyPH6d5HMhRp/vajM2MtEvnNJjUvadg0Ier54xA5HjB9HWvBWv3Nh8C95ZktAoJh
	 5O5vCibGcOOGjhj89symK9y35QpyrtgF8WlB9Kzn2Vn9sY+bUUORqPe0SJkQZsAWNAg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795538847;
	bh=Z9szmJ5yPLDTyQO8gjw7y4QwOIN4aq+TyI+vcS1EV3Y=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tx4jehH/gfKr3/2QYdHsd4QVcN943J+IhKn/E9qVCBVYFYmZv8RYXueLpT0QUep5s
	 gRFeMyzmS/9qVdnNhgkcK9AQHDPSn519KLe3IhIyvl7+STN2DziPp5CuTbirXJMA9J
	 g35v8s3P06eJA2rL4kq68Cs0H49kokpQYGmCssYhQBDwEvzc5KD+A0iKZsVxcvXVZc
	 cwPPtTEHV/Yi8fkh2nXeIX4hGOgdgKfIzr70SZciGElUojP7cQHX3/DwM0YWsV07Lg
	 0chvGVNWH1dYNCeJzuZMnsHVzPSgAERHbcZ8T2x6SGZeriABYSMeslcoZOKhterqu7
	 JiOvSR969Ub9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E9D5680D6F;
	Tue, 24 Nov 2026 16:47:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C8321715
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B38D16080E
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M0MbdfF7K0pr for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 16:47:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C73C4607B8
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=dkSl2aZf; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RMGYj4Ft
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C73C4607B8
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:23 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOFL7N02569770
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Z9szmJ5yPLD
 TyQO8gjw7y4QwOIN4aq+TyI+vcS1EV3Y=; b=dkSl2aZfZTxA2htuCGCBh9HjWwf
 PEUidQn5GEkF8lCvSNGKPT8GMm4w3EHXdel5BfzRVG4IJjQz93E8Cva3EHmXWAKO
 sarC9L8ybzVjSl3r01xbvPoIDO1BofABH7qHNoP2gHkHTvJRrPkPuKx4jk982ggL
 B8U3cmirwCaYjExi8eJ8Iy7EHSxx+zS/QvgnDrf6UsNZYfPZj+EdjdXdDBgnuHKB
 BRad2wvmPA4EFVmQbu5o3aE/l3xtZyaSx1gpW9nmN4Us0TqYO2+2G5x4c6Cl2Zr6
 gIwNNRGiNWKhU3GiI8d+vDhBLr270ypdNqMLyK2P/OWt6TTL3TD9Ph9x/IA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4w6svf3u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:47:22 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-139b62317d0so5092348c88.0
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795538842; x=1796143642;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Z9szmJ5yPLDTyQO8gjw7y4QwOIN4aq+TyI+vcS1EV3Y=;
 b=RMGYj4FttXjBYSxuJDLH5eM2JrvTWVafrMNeJ9RK5HaMjBckUc0kglIRMjxqdQr/k2
 /c5tKNoXXLTEJhe2oCEAWfzuvv7Cj7J9BCb05U0uooaYhqkAsAhLD2YXr1STcfLVBmma
 z7YdF72s6V78sVE5NNJfmiA6gOtzQNB40G1d8FxVZ9tzjiN2zbKtkx9bqptGqh/D6T+E
 jkmiqfD1uGb+ZaLtiLKWtRmk4uQgo2kd4yszqpnKSD6GXIgtpfuEC2vaTOFoJW3Qq+kA
 fKg1MC3K19DOOJJLZIeXKWEpbYm4bkPg4NAo9S8wfWtf+xu00modds+VZde6LwK388w/
 AX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795538842; x=1796143642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Z9szmJ5yPLDTyQO8gjw7y4QwOIN4aq+TyI+vcS1EV3Y=;
 b=YPwUOGadJ/kS9dQTkwvBpZxHREAspQuEwpJV6XiydY1IzjYZzxKZIYLr3jVZWJcJ/g
 k1yM4NpxDMLiYf24UAFnk/PHl/oAm6JHuciPGOPYJSUW6axDoxl5JfE07ahcCcD22ex+
 WsU2mPYpyE+00P/aVNaeCkJ6w/O2mPdXICzNfcce9uCc5R27vIU/mhg5+HxYkGIgjEUf
 EtqAR9wKOx31KI0Q2O0E/kyddIEyR7uNob/u0gGoBeSTlJyZ2jrLgX6HA1oKeA+ppbDd
 5NrdaM4jWaD1IGRKNMsx+01go2ONVn7tzky1wU6lduaxB39Yi1uRQOhhIkVpH5FSzpUq
 h/3Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFFP1plRrvRVa/8ZOP2lT2fofBCIJedlSySK+yVZ0b/3rTYdAXpWnxvw2hupFe4+Fxonvkukzk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9bmmJbkSoBFKgEx/syH8740HX+gHwE9LUK7XXWAlzXu0n2evVu
 C2qkTopTfZeziNpnan1wXrucMASVGFxvauf/HYRRBEUcopv00MgQKWl85VgfZTN+hZT/bYCGN01
 LHy+4bv7f1LHIwYO2uZBjJj9tRPH33a+4zFyJMx5hVn815yim7HNMPyFwDrq6GS+gy5d03EA=
X-Gm-Gg: AZFdTZc9i05DChDmsW3Mm2IBADaQ0qg3RZ/7J+eXSXXKOiuRD1CUzRUf3hlh1n4QyX1
 TZUJgql8OU9rE8O7279z8dZPDRKzUVzJPtM7wD1oPGy1n5UOKB07AVQi6bgf8yg3Wdu2IBi0s9X
 S4yIcVVFoEqhGQ3Pa2pZo3GMfPMTpjckAX+BKglUArEj02RH1wa8RWp2AHWaRLj2QYJH+livTki
 20k6KcwRcdOMAgENfiq5kurmlu933+ZDuz+JQRc3VtuIPzXTHG7IfrX4Jqr7JGMP/I1kBYJ7sY0
 it8rr7h6I/6UeiiIeabWaxioz40kcl3waZ1Wx+szv1hFF/GJJvN3aa7T3LpXoNj4mnHh3lGXskW
 bVEihYdYBwNDoNpKZ3egpYFN3IAM+ZzczEdYPi4iIpzfTrKaPqVDPMOcpmr96Hb0rXQhYi9HLfG
 M4pYGGI7MqTTJJfNOyMFDyl8AyrYl3L1bXDF9qTIRlHASnjO8amrs8fIBem2BVsBt2QR8b
X-Received: by 2002:a05:7300:c3aa:b0:385:c28b:a4d5 with SMTP id
 5a478bee46e88-385c28baffbmr15913538eec.17.1795538841465; 
 Tue, 24 Nov 2026 08:47:21 -0800 (PST)
X-Received: by 2002:a05:7300:c3aa:b0:385:c28b:a4d5 with SMTP id
 5a478bee46e88-385c28baffbmr15913506eec.17.1795538840690; 
 Tue, 24 Nov 2026 08:47:20 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566cd40c5sm55365072eec.10.2026.11.24.08.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 08:47:20 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, balaji.selvanathan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, quentin.schulz@cherry.de,
 william.bright@imd-tec.com, nikroks@mainlining.org,
 macpaul.lin@mediatek.com, dlechner@baylibre.com, xerikasxx@gmail.com,
 jbx6244@gmail.com, u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v6 2/9] pinctrl: qcom: add driver for shikra SoC
Date: Tue, 24 Nov 2026 22:16:53 +0530
Message-Id: <20261124164700.1606518-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124164700.1606518-1-aswin.murugan@oss.qualcomm.com>
References: <20261124164700.1606518-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: thfTiKSHhK6yENFCVZJfSBP6-o8G7sSB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2NSBTYWx0ZWRfX0Kt0ixn9kjQS
 aJN4TD2trez0idziZqX+RPpMegyfAAmZdSlmmGET5RnFeKuNc+IGZtXuekdX6n08C2lu3WgRO44
 VNcgzAifbgourNvKhSOJWo9zQj1uiCw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2NSBTYWx0ZWRfX11obb331dDzY
 nIQQ7dD4UbesgQVJn1S1WWRqgHehQUISQxSunXKl6Lxww09yN3YMv0bWAB9nMiojj4zbUMj4Jd4
 Nh8eqhi5LaC2GTpG7RoipTY85ddDDOYnp3ms+atZZ/0LhgLyvahlfki0r1rNMuUiI9BBC33g0ty
 XxmTym5km+l1PdU3N+RUPCyajc7TgZzyA55o53EtiGh+YZAyiZKjsNFtqn5p1LgDL1CMOg9nv+X
 q+Np+SqEZ1D6z24xeUM1xCByNgyK5zz5LF+1zhZAaGRlREFJs+L4D/BLbFpF652dypICnlzthLC
 zlcBrwnQo6vkxiEF6nhoGZ/2eSb/qHERRGr/mTZtXXSc1AuXAKIKElYrHUKcKFh+YaT9b9sDsI+
 AYiILUwgfnNLdqq4JGInmaQfYKk1MOLVLg4d4pFJtELDr9cIijd83xn3SZUenZ+K2eeAFOLo+7q
 6NTmSCaS7Vw1RmHIu4Q==
X-Proofpoint-ORIG-GUID: thfTiKSHhK6yENFCVZJfSBP6-o8G7sSB
X-Authority-Analysis: v=2.4 cv=V8DoQuni c=1 sm=1 tr=0 ts=6b05bf9a cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=KKGPLXHPwZnGMUVmMDUA:9 a=O8hF6Hzn-FEA:10
 a=Fk4IpSoW4aLDllm1B1p-:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240065
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

Add a Qualcomm TLMM pinctrl driver for the Shikra SoC. This driver
provides pin configuration support required for enabling peripherals
on the platform.

The implementation is based on existing Qualcomm pinctrl drivers in
U-Boot and the Linux kernel, with adaptations for the Shikra pin
layout, functions, and groups.

This enables proper pin configuration during early boot on Shikra-based
boards.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/Kconfig          |   8 +
 drivers/pinctrl/qcom/Makefile         |   1 +
 drivers/pinctrl/qcom/pinctrl-shikra.c | 478 ++++++++++++++++++++++++++
 3 files changed, 487 insertions(+)
 create mode 100644 drivers/pinctrl/qcom/pinctrl-shikra.c

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index fa0385f159a..f399b4503c1 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -140,6 +140,14 @@ config PINCTRL_QCOM_SDM845
 	  Say Y here to enable support for pinctrl on the Snapdragon 845 SoC,
 	  as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_SHIKRA
+	bool "Qualcomm Shikra Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the Snapdragon Shikra SoC,
+	  as well as the associated GPIO driver.
+
 config PINCTRL_QCOM_SM6115
 	bool "Qualcomm SM6115 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 97d59f5eac0..d19e3509b1b 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_PINCTRL_QCOM_SC7280) += pinctrl-sc7280.o
 obj-$(CONFIG_PINCTRL_QCOM_SDM660) += pinctrl-sdm660.o
 obj-$(CONFIG_PINCTRL_QCOM_SDM670) += pinctrl-sdm670.o
 obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
+obj-$(CONFIG_PINCTRL_QCOM_SHIKRA) += pinctrl-shikra.o
 obj-$(CONFIG_PINCTRL_QCOM_SM6115) += pinctrl-sm6115.o
 obj-$(CONFIG_PINCTRL_QCOM_SM6125) += pinctrl-sm6125.o
 obj-$(CONFIG_PINCTRL_QCOM_SM6350) += pinctrl-sm6350.o
diff --git a/drivers/pinctrl/qcom/pinctrl-shikra.c b/drivers/pinctrl/qcom/pinctrl-shikra.c
new file mode 100644
index 00000000000..13c3768d84e
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-shikra.c
@@ -0,0 +1,478 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <dm.h>
+
+#include "pinctrl-qcom.h"
+
+#define MAX_PIN_NAME_LEN 32
+static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
+
+typedef unsigned int msm_pin_function[12];
+
+#define PINGROUP(id, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11)\
+	{						\
+		msm_mux_gpio, /* gpio mode */		\
+		msm_mux_##f1,				\
+		msm_mux_##f2,				\
+		msm_mux_##f3,				\
+		msm_mux_##f4,				\
+		msm_mux_##f5,				\
+		msm_mux_##f6,				\
+		msm_mux_##f7,				\
+		msm_mux_##f8,				\
+		msm_mux_##f9,				\
+		msm_mux_##f10,				\
+		msm_mux_##f11				\
+	}
+
+#define SDC_QDSD_PINGROUP(pg_name, ctl, pull, drv)	\
+	{						\
+		.name = pg_name,			\
+		.ctl_reg = ctl,				\
+		.io_reg = 0,				\
+		.pull_bit = pull,			\
+		.drv_bit = drv,				\
+		.oe_bit = -1,				\
+		.in_bit = -1,				\
+		.out_bit = -1,				\
+	}
+
+enum shikra_functions {
+	msm_mux_gpio,
+	msm_mux_agera_pll,
+	msm_mux_atest_bbrx,
+	msm_mux_atest_char,
+	msm_mux_atest_gpsadc,
+	msm_mux_atest_tsens,
+	msm_mux_atest_usb,
+	msm_mux_cam_mclk,
+	msm_mux_cci_async,
+	msm_mux_cci_i2c0,
+	msm_mux_cci_i2c1,
+	msm_mux_cci_timer,
+	msm_mux_char_exec,
+	msm_mux_cri_trng,
+	msm_mux_dac_calib,
+	msm_mux_dbg_out_clk,
+	msm_mux_ddr_bist,
+	msm_mux_ddr_pxi,
+	msm_mux_dmic,
+	msm_mux_emac_dll,
+	msm_mux_emac_mcg,
+	msm_mux_emac_phy,
+	msm_mux_emac0_ptp_aux,
+	msm_mux_emac0_ptp_pps,
+	msm_mux_emac1_ptp_aux,
+	msm_mux_emac1_ptp_pps,
+	msm_mux_ext_mclk,
+	msm_mux_gcc_gp,
+	msm_mux_gsm0_tx,
+	msm_mux_i2s0,
+	msm_mux_i2s1,
+	msm_mux_i2s2,
+	msm_mux_i2s3,
+	msm_mux_jitter_bist,
+	msm_mux_m_voc,
+	msm_mux_mdp_vsync_e,
+	msm_mux_mdp_vsync_out0,
+	msm_mux_mdp_vsync_out1,
+	msm_mux_mdp_vsync_p,
+	msm_mux_mdp_vsync_s,
+	msm_mux_mpm_pwr,
+	msm_mux_mss_lte,
+	msm_mux_nav_gpio,
+	msm_mux_pa_indicator_or,
+	msm_mux_pbs_in,
+	msm_mux_pbs_out,
+	msm_mux_pcie0_clk_req_n,
+	msm_mux_phase_flag,
+	msm_mux_pll,
+	msm_mux_prng_rosc,
+	msm_mux_pwm,
+	msm_mux_qdss_cti,
+	msm_mux_qup0_se0,
+	msm_mux_qup0_se1,
+	msm_mux_qup0_se1_01,
+	msm_mux_qup0_se1_23,
+	msm_mux_qup0_se2,
+	msm_mux_qup0_se3_01,
+	msm_mux_qup0_se3_23,
+	msm_mux_qup0_se4_01,
+	msm_mux_qup0_se4_23,
+	msm_mux_qup0_se5,
+	msm_mux_qup0_se6,
+	msm_mux_qup0_se7_01,
+	msm_mux_qup0_se7_23,
+	msm_mux_qup0_se8,
+	msm_mux_qup0_se9,
+	msm_mux_qup0_se9_01,
+	msm_mux_qup0_se9_23,
+	msm_mux_rgmii,
+	msm_mux_sd_write_protect,
+	msm_mux_sdc_cdc,
+	msm_mux_sdc_tb_trig,
+	msm_mux_ssbi_wtr,
+	msm_mux_swr0_rx,
+	msm_mux_swr0_tx,
+	msm_mux_tgu_ch_trigout,
+	msm_mux_tsc_async,
+	msm_mux_tsense_pwm,
+	msm_mux_uim1,
+	msm_mux_uim2,
+	msm_mux_unused_adsp,
+	msm_mux_unused_gsm1,
+	msm_mux_usb0_phy_ps,
+	msm_mux_vfr,
+	msm_mux_vsense_trigger_mirnat,
+	msm_mux_wlan,
+	msm_mux__,
+};
+
+#define MSM_PIN_FUNCTION(fname)                         \
+	[msm_mux_##fname] = {#fname, msm_mux_##fname}
+
+static const struct pinctrl_function msm_pinctrl_functions[] = {
+	MSM_PIN_FUNCTION(gpio),
+	MSM_PIN_FUNCTION(agera_pll),
+	MSM_PIN_FUNCTION(atest_bbrx),
+	MSM_PIN_FUNCTION(atest_char),
+	MSM_PIN_FUNCTION(atest_gpsadc),
+	MSM_PIN_FUNCTION(atest_tsens),
+	MSM_PIN_FUNCTION(atest_usb),
+	MSM_PIN_FUNCTION(cam_mclk),
+	MSM_PIN_FUNCTION(cci_async),
+	MSM_PIN_FUNCTION(cci_i2c0),
+	MSM_PIN_FUNCTION(cci_i2c1),
+	MSM_PIN_FUNCTION(cci_timer),
+	MSM_PIN_FUNCTION(char_exec),
+	MSM_PIN_FUNCTION(cri_trng),
+	MSM_PIN_FUNCTION(dac_calib),
+	MSM_PIN_FUNCTION(dbg_out_clk),
+	MSM_PIN_FUNCTION(ddr_bist),
+	MSM_PIN_FUNCTION(ddr_pxi),
+	MSM_PIN_FUNCTION(dmic),
+	MSM_PIN_FUNCTION(emac_dll),
+	MSM_PIN_FUNCTION(emac_mcg),
+	MSM_PIN_FUNCTION(emac_phy),
+	MSM_PIN_FUNCTION(emac0_ptp_aux),
+	MSM_PIN_FUNCTION(emac0_ptp_pps),
+	MSM_PIN_FUNCTION(emac1_ptp_aux),
+	MSM_PIN_FUNCTION(emac1_ptp_pps),
+	MSM_PIN_FUNCTION(ext_mclk),
+	MSM_PIN_FUNCTION(gcc_gp),
+	MSM_PIN_FUNCTION(gsm0_tx),
+	MSM_PIN_FUNCTION(i2s0),
+	MSM_PIN_FUNCTION(i2s1),
+	MSM_PIN_FUNCTION(i2s2),
+	MSM_PIN_FUNCTION(i2s3),
+	MSM_PIN_FUNCTION(jitter_bist),
+	MSM_PIN_FUNCTION(m_voc),
+	MSM_PIN_FUNCTION(mdp_vsync_e),
+	MSM_PIN_FUNCTION(mdp_vsync_out0),
+	MSM_PIN_FUNCTION(mdp_vsync_out1),
+	MSM_PIN_FUNCTION(mdp_vsync_p),
+	MSM_PIN_FUNCTION(mdp_vsync_s),
+	MSM_PIN_FUNCTION(mpm_pwr),
+	MSM_PIN_FUNCTION(mss_lte),
+	MSM_PIN_FUNCTION(nav_gpio),
+	MSM_PIN_FUNCTION(pa_indicator_or),
+	MSM_PIN_FUNCTION(pbs_in),
+	MSM_PIN_FUNCTION(pbs_out),
+	MSM_PIN_FUNCTION(pcie0_clk_req_n),
+	MSM_PIN_FUNCTION(phase_flag),
+	MSM_PIN_FUNCTION(pll),
+	MSM_PIN_FUNCTION(prng_rosc),
+	MSM_PIN_FUNCTION(pwm),
+	MSM_PIN_FUNCTION(qdss_cti),
+	MSM_PIN_FUNCTION(qup0_se0),
+	MSM_PIN_FUNCTION(qup0_se1),
+	MSM_PIN_FUNCTION(qup0_se1_01),
+	MSM_PIN_FUNCTION(qup0_se1_23),
+	MSM_PIN_FUNCTION(qup0_se2),
+	MSM_PIN_FUNCTION(qup0_se3_01),
+	MSM_PIN_FUNCTION(qup0_se3_23),
+	MSM_PIN_FUNCTION(qup0_se4_01),
+	MSM_PIN_FUNCTION(qup0_se4_23),
+	MSM_PIN_FUNCTION(qup0_se5),
+	MSM_PIN_FUNCTION(qup0_se6),
+	MSM_PIN_FUNCTION(qup0_se7_01),
+	MSM_PIN_FUNCTION(qup0_se7_23),
+	MSM_PIN_FUNCTION(qup0_se8),
+	MSM_PIN_FUNCTION(qup0_se9),
+	MSM_PIN_FUNCTION(qup0_se9_01),
+	MSM_PIN_FUNCTION(qup0_se9_23),
+	MSM_PIN_FUNCTION(rgmii),
+	MSM_PIN_FUNCTION(sd_write_protect),
+	MSM_PIN_FUNCTION(sdc_cdc),
+	MSM_PIN_FUNCTION(sdc_tb_trig),
+	MSM_PIN_FUNCTION(ssbi_wtr),
+	MSM_PIN_FUNCTION(swr0_rx),
+	MSM_PIN_FUNCTION(swr0_tx),
+	MSM_PIN_FUNCTION(tgu_ch_trigout),
+	MSM_PIN_FUNCTION(tsc_async),
+	MSM_PIN_FUNCTION(tsense_pwm),
+	MSM_PIN_FUNCTION(uim1),
+	MSM_PIN_FUNCTION(uim2),
+	MSM_PIN_FUNCTION(unused_adsp),
+	MSM_PIN_FUNCTION(unused_gsm1),
+	MSM_PIN_FUNCTION(usb0_phy_ps),
+	MSM_PIN_FUNCTION(vfr),
+	MSM_PIN_FUNCTION(vsense_trigger_mirnat),
+	MSM_PIN_FUNCTION(wlan),
+};
+
+static const msm_pin_function shikra_pin_functions[] = {
+	[0] = PINGROUP(0, qup0_se0, m_voc, _, phase_flag, _, _, _, _, _, _, _),
+	[1] = PINGROUP(1, qup0_se0, mpm_pwr, ddr_bist, _, phase_flag, atest_tsens, _, _, _, _,
+			_),
+	[2] = PINGROUP(2, qup0_se0, ddr_bist, _, phase_flag, atest_tsens, _, _, _, _, _, _),
+	[3] = PINGROUP(3, qup0_se0, ddr_bist, _, phase_flag, dac_calib, _, _, _, _, _, _),
+	[4] = PINGROUP(4, qup0_se1_23, qup0_se1_01, ddr_bist, _, phase_flag, dac_calib, _, _, _,
+			_, _),
+	[5] = PINGROUP(5, qup0_se1_23, qup0_se1_01, _, phase_flag, dac_calib, _, _, _, _, _, _),
+	[6] = PINGROUP(6, qup0_se2, cri_trng, _, phase_flag, dac_calib, _, _, _, _, _, _),
+	[7] = PINGROUP(7, qup0_se2, cri_trng, _, phase_flag, dac_calib, _, _, _, _, _, _),
+	[8] = PINGROUP(8, qup0_se2, _, phase_flag, dac_calib, _, _, _, _, _, _, _),
+	[9] = PINGROUP(9, qup0_se2, _, phase_flag, dac_calib, _, _, _, _, _, _, _),
+	[10] = PINGROUP(10, qup0_se3_01, qup0_se3_23, _, _, _, _, _, _, _, _, _),
+	[11] = PINGROUP(11, qup0_se3_01, qup0_se3_23, _, phase_flag, _, _, _, _, _, _, _),
+	[12] = PINGROUP(12, qup0_se4_01, qup0_se4_23, char_exec, _, _, _, _, _, _, _, _),
+	[13] = PINGROUP(13, qup0_se4_01, qup0_se4_23, char_exec, _, _, _, _, _, _, _, _),
+	[14] = PINGROUP(14, qup0_se5, pll, tgu_ch_trigout, dac_calib, wlan, _, _, _, _, _, _),
+	[15] = PINGROUP(15, qup0_se5, tgu_ch_trigout, _, dac_calib, wlan, _, _, _, _, _, _),
+	[16] = PINGROUP(16, qup0_se5, tgu_ch_trigout, _, phase_flag, dac_calib, _, _, _, _, _,
+			_),
+	[17] = PINGROUP(17, qup0_se5, tgu_ch_trigout, _, phase_flag, dac_calib, _, _, _, _, _,
+			_),
+	[18] = PINGROUP(18, qup0_se6, dac_calib, _, _, _, _, _, _, _, _, _),
+	[19] = PINGROUP(19, qup0_se6, dac_calib, _, _, _, _, _, _, _, _, _),
+	[20] = PINGROUP(20, qup0_se7_01, qup0_se7_23, cri_trng, _, _, _, _, _, _, _, _),
+	[21] = PINGROUP(21, qup0_se7_01, qup0_se7_23, tsense_pwm, _, _, _, _, _, _, _, _),
+	[22] = PINGROUP(22, qup0_se8, pll, agera_pll, pbs_out, _, _, _, _, _, _, _),
+	[23] = PINGROUP(23, qup0_se8, agera_pll, pbs_out, _, _, _, _, _, _, _, _),
+	[24] = PINGROUP(24, qup0_se8, pbs_out, _, _, _, _, _, _, _, _, _),
+	[25] = PINGROUP(25, qup0_se8, _, _, _, _, _, _, _, _, _, _),
+	[26] = PINGROUP(26, qup0_se9_23, qup0_se9_01, _, _, _, _, _, _, _, _, _),
+	[27] = PINGROUP(27, qup0_se9_23, qup0_se9_01, prng_rosc, _, _, _, _, _, _, _, _),
+	[28] = PINGROUP(28, qup0_se1, qup0_se6, emac_mcg, prng_rosc, _, phase_flag, qdss_cti, _,
+			_, _, _),
+	[29] = PINGROUP(29, qup0_se1, qup0_se6, emac_mcg, _, phase_flag, qdss_cti, _, _, _, _,
+			_),
+	[30] = PINGROUP(30, qup0_se2, qup0_se6, _, phase_flag, qdss_cti, _, _, _, _, _, _),
+	[31] = PINGROUP(31, qup0_se2, qup0_se6, emac1_ptp_aux, emac1_ptp_pps, _, phase_flag,
+			qdss_cti, _, _, _, _),
+	[32] = PINGROUP(32, pwm, sdc_tb_trig, _, _, _, _, _, _, _, _, _),
+	[33] = PINGROUP(33, emac1_ptp_aux, emac1_ptp_pps, sdc_tb_trig, _, _, _, _, _, _, _, _),
+	[34] = PINGROUP(34, cam_mclk, _, _, _, _, _, _, _, _, _, _),
+	[35] = PINGROUP(35, cam_mclk, unused_adsp, _, _, _, _, _, _, _, _, _),
+	[36] = PINGROUP(36, cci_i2c0, _, _, _, _, _, _, _, _, _, _),
+	[37] = PINGROUP(37, cci_i2c0, _, _, _, _, _, _, _, _, _, _),
+	[38] = PINGROUP(38, cci_timer, _, _, _, _, _, _, _, _, _, _),
+	[39] = PINGROUP(39, cci_async, _, _, _, _, _, _, _, _, _, _),
+	[40] = PINGROUP(40, cci_timer, emac_mcg, pwm, _, _, _, _, _, _, _, _),
+	[41] = PINGROUP(41, cci_i2c1, _, _, _, _, _, _, _, _, _, _),
+	[42] = PINGROUP(42, cci_i2c1, _, _, _, _, _, _, _, _, _, _),
+	[43] = PINGROUP(43, cci_timer, emac_mcg, pll, _, _, _, _, _, _, _, _),
+	[44] = PINGROUP(44, emac_mcg, pll, _, _, _, _, _, _, _, _, _),
+	[45] = PINGROUP(45, tsc_async, emac_mcg, pwm, gcc_gp, _, _, _, _, _, _, _),
+	[46] = PINGROUP(46, tsc_async, emac_mcg, _, _, _, _, _, _, _, _, _),
+	[47] = PINGROUP(47, cci_timer, emac_mcg, _, _, _, _, _, _, _, _, _),
+	[48] = PINGROUP(48, _, qup0_se9, _, _, pbs_in, phase_flag, _, _, _, _, _),
+	[49] = PINGROUP(49, _, qup0_se9, _, _, pbs_in, phase_flag, _, _, _, _, _),
+	[50] = PINGROUP(50, _, qup0_se9, _, _, pbs_in, phase_flag, _, _, _, _, _),
+	[51] = PINGROUP(51, _, qup0_se9, pbs_in, _, _, _, _, _, _, _, _),
+	[52] = PINGROUP(52, _, _, _, _, _, _, _, _, _, _, _),
+	[53] = PINGROUP(53, _, nav_gpio, gcc_gp, pwm, _, pbs_in, atest_usb, _, _, _, _),
+	[54] = PINGROUP(54, _, pwm, _, pbs_in, phase_flag, atest_char, _, _, _, _, _),
+	[55] = PINGROUP(55, _, pwm, _, pbs_in, phase_flag, atest_char, _, _, _, _, _),
+	[56] = PINGROUP(56, _, pwm, _, pbs_in, phase_flag, atest_char, _, _, _, _, _),
+	[57] = PINGROUP(57, _, pwm, _, pbs_in, phase_flag, atest_char, _, _, _, _, _),
+	[58] = PINGROUP(58, _, nav_gpio, pwm, _, pbs_in, atest_bbrx, atest_usb,
+			vsense_trigger_mirnat, emac_dll, _, _),
+	[59] = PINGROUP(59, _, vfr, _, pbs_in, atest_bbrx, atest_usb, emac_dll, _, _, _, _),
+	[60] = PINGROUP(60, _, emac1_ptp_aux, emac1_ptp_pps, emac0_ptp_aux, emac0_ptp_pps, _,
+			pbs_in, atest_gpsadc, atest_usb, emac_dll, _),
+	[61] = PINGROUP(61, _, pwm, gcc_gp, pa_indicator_or, dbg_out_clk, pbs_in, atest_usb,
+			emac_dll, _, _, _),
+	[62] = PINGROUP(62, _, pwm, _, pbs_in, phase_flag, atest_char, _, _, _, _, _),
+	[63] = PINGROUP(63, _, nav_gpio, emac0_ptp_aux, emac0_ptp_pps, _, pbs_in, phase_flag,
+			dac_calib, _, _, _),
+	[64] = PINGROUP(64, _, unused_gsm1, dac_calib, _, _, _, _, _, _, _, _),
+	[65] = PINGROUP(65, _, _, _, _, _, _, _, _, _, _, _),
+	[66] = PINGROUP(66, _, dac_calib, _, _, _, _, _, _, _, _, _),
+	[67] = PINGROUP(67, _, _, _, _, _, _, _, _, _, _, _),
+	[68] = PINGROUP(68, _, ssbi_wtr, emac1_ptp_aux, emac1_ptp_pps, pwm, dac_calib, _, _, _,
+			_, _),
+	[69] = PINGROUP(69, _, ssbi_wtr, emac0_ptp_aux, emac0_ptp_pps, _, phase_flag, dac_calib,
+			_, _, _, _),
+	[70] = PINGROUP(70, _, ssbi_wtr, _, phase_flag, dac_calib, _, _, _, _, _, _),
+	[71] = PINGROUP(71, _, ssbi_wtr, nav_gpio, _, phase_flag, _, _, _, _, _, _),
+	[72] = PINGROUP(72, _, _, phase_flag, _, _, _, _, _, _, _, _),
+	[73] = PINGROUP(73, _, _, _, _, _, _, _, _, _, _, _),
+	[74] = PINGROUP(74, pll, _, pbs_in, phase_flag, _, _, _, _, _, _, _),
+	[75] = PINGROUP(75, gsm0_tx, _, _, _, _, _, _, _, _, _, _),
+	[76] = PINGROUP(76, pll, _, _, _, _, _, _, _, _, _, _),
+	[77] = PINGROUP(77, uim2, pwm, _, _, _, _, _, _, _, _, _),
+	[78] = PINGROUP(78, uim2, _, _, _, _, _, _, _, _, _, _),
+	[79] = PINGROUP(79, uim2, pwm, _, _, _, _, _, _, _, _, _),
+	[80] = PINGROUP(80, uim2, pwm, _, _, _, _, _, _, _, _, _),
+	[81] = PINGROUP(81, uim1, _, _, _, _, _, _, _, _, _, _),
+	[82] = PINGROUP(82, uim1, _, _, _, _, _, _, _, _, _, _),
+	[83] = PINGROUP(83, uim1, _, _, _, _, _, _, _, _, _, _),
+	[84] = PINGROUP(84, uim1, _, _, _, _, _, _, _, _, _, _),
+	[85] = PINGROUP(85, emac0_ptp_aux, emac0_ptp_pps, _, _, _, _, _, _, _, _, _),
+	[86] = PINGROUP(86, mdp_vsync_p, mdp_vsync_out0, mdp_vsync_out1, _, _, _, _, _, _, _, _),
+	[87] = PINGROUP(87, _, pwm, _, _, _, _, _, _, _, _, _),
+	[88] = PINGROUP(88, gcc_gp, _, dac_calib, _, _, _, _, _, _, _, _),
+	[89] = PINGROUP(89, gcc_gp, _, dac_calib, _, _, _, _, _, _, _, _),
+	[90] = PINGROUP(90, usb0_phy_ps, _, dac_calib, _, _, _, _, _, _, _, _),
+	[91] = PINGROUP(91, nav_gpio, _, _, _, _, _, _, _, _, _, _),
+	[92] = PINGROUP(92, nav_gpio, _, _, _, _, _, _, _, _, _, _),
+	[93] = PINGROUP(93, _, _, _, _, _, _, _, _, _, _, _),
+	[94] = PINGROUP(94, mdp_vsync_e, qdss_cti, qdss_cti, _, _, _, _, _, _, _, _),
+	[95] = PINGROUP(95, nav_gpio, mdp_vsync_s, qdss_cti, qdss_cti, _, _, _, _, _, _, _),
+	[96] = PINGROUP(96, dmic, cam_mclk, i2s1, jitter_bist, atest_gpsadc, atest_usb, _, _, _,
+			_, _),
+	[97] = PINGROUP(97, dmic, i2s1, dac_calib, _, _, _, _, _, _, _, _),
+	[98] = PINGROUP(98, dmic, cam_mclk, i2s1, _, sdc_cdc, atest_usb, ddr_pxi, _, _, _, _),
+	[99] = PINGROUP(99, dmic, i2s1, jitter_bist, sdc_cdc, atest_usb, ddr_pxi, _, _, _, _, _),
+	[100] = PINGROUP(100, i2s2, nav_gpio, _, sdc_cdc, atest_usb, ddr_pxi, _, _, _, _, _),
+	[101] = PINGROUP(101, i2s2, nav_gpio, _, sdc_cdc, atest_usb, ddr_pxi, _, _, _, _, _),
+	[102] = PINGROUP(102, i2s2, pwm, _, phase_flag, _, _, _, _, _, _, _),
+	[103] = PINGROUP(103, ext_mclk, i2s2, _, _, _, _, _, _, _, _, _),
+	[104] = PINGROUP(104, ext_mclk, nav_gpio, _, _, _, _, _, _, _, _, _),
+	[105] = PINGROUP(105, swr0_tx, i2s0, _, _, _, _, _, _, _, _, _),
+	[106] = PINGROUP(106, swr0_tx, i2s0, _, _, _, _, _, _, _, _, _),
+	[107] = PINGROUP(107, swr0_rx, i2s0, _, _, _, _, _, _, _, _, _),
+	[108] = PINGROUP(108, swr0_rx, i2s0, _, _, _, _, _, _, _, _, _),
+	[109] = PINGROUP(109, swr0_rx, i2s0, sd_write_protect, _, _, _, _, _, _, _, _),
+	[110] = PINGROUP(110, ext_mclk, i2s0, _, gcc_gp, _, _, _, _, _, _, _),
+	[111] = PINGROUP(111, i2s3, _, _, _, _, _, _, _, _, _, _),
+	[112] = PINGROUP(112, i2s3, _, _, _, _, _, _, _, _, _, _),
+	[113] = PINGROUP(113, i2s3, _, _, _, _, _, _, _, _, _, _),
+	[114] = PINGROUP(114, ext_mclk, i2s3, _, _, _, _, _, _, _, _, _),
+	[115] = PINGROUP(115, mss_lte, _, _, _, _, _, _, _, _, _, _),
+	[116] = PINGROUP(116, mss_lte, _, dac_calib, _, _, _, _, _, _, _, _),
+	[117] = PINGROUP(117, pcie0_clk_req_n, _, dac_calib, _, _, _, _, _, _, _, _),
+	[118] = PINGROUP(118, _, dac_calib, _, _, _, _, _, _, _, _, _),
+	[119] = PINGROUP(119, _, _, _, _, _, _, _, _, _, _, _),
+	[120] = PINGROUP(120, emac_phy, _, _, _, _, _, _, _, _, _, _),
+	[121] = PINGROUP(121, rgmii, _, _, _, _, _, _, _, _, _, _),
+	[122] = PINGROUP(122, rgmii, _, _, _, _, _, _, _, _, _, _),
+	[123] = PINGROUP(123, rgmii, _, _, _, _, _, _, _, _, _, _),
+	[124] = PINGROUP(124, rgmii, _, _, _, _, _, _, _, _, _, _),
+	[125] = PINGROUP(125, rgmii, _, _, _, _, _, _, _, _, _, _),
+	[126] = PINGROUP(126, rgmii, _, _, _, _, _, _, _, _, _, _),
+	[127] = PINGROUP(127, rgmii, _, _, _, _, _, _, _, _, _, _),
+	[128] = PINGROUP(128, rgmii, _, _, _, _, _, _, _, _, _, _),
+	[129] = PINGROUP(129, rgmii, _, _, _, _, _, _, _, _, _, _),
+	[130] = PINGROUP(130, rgmii, _, _, _, _, _, _, _, _, _, _),
+	[131] = PINGROUP(131, rgmii, _, _, _, _, _, _, _, _, _, _),
+	[132] = PINGROUP(132, rgmii, _, _, _, _, _, _, _, _, _, _),
+	[133] = PINGROUP(133, rgmii, _, _, _, _, _, _, _, _, _, _),
+	[134] = PINGROUP(134, rgmii, _, _, _, _, _, _, _, _, _, _),
+	[135] = PINGROUP(135, _, _, _, _, _, _, _, _, _, _, _),
+	[136] = PINGROUP(136, emac_phy, _, _, _, _, _, _, _, _, _, _),
+	[137] = PINGROUP(137, rgmii, _, _, _, _, _, _, _, _, _, _),
+	[138] = PINGROUP(138, rgmii, _, _, _, _, _, _, _, _, _, _),
+	[139] = PINGROUP(139, rgmii, _, _, _, _, _, _, _, _, _, _),
+	[140] = PINGROUP(140, rgmii, _, _, _, _, _, _, _, _, _, _),
+	[141] = PINGROUP(141, rgmii, _, _, _, _, _, _, _, _, _, _),
+	[142] = PINGROUP(142, rgmii, _, _, _, _, _, _, _, _, _, _),
+	[143] = PINGROUP(143, rgmii, _, _, _, _, _, _, _, _, _, _),
+	[144] = PINGROUP(144, rgmii, _, _, _, _, _, _, _, _, _, _),
+	[145] = PINGROUP(145, rgmii, _, _, _, _, _, _, _, _, _, _),
+	[146] = PINGROUP(146, rgmii, _, _, _, _, _, _, _, _, _, _),
+	[147] = PINGROUP(147, rgmii, _, _, _, _, _, _, _, _, _, _),
+	[148] = PINGROUP(148, rgmii, _, _, _, _, _, _, _, _, _, _),
+	[149] = PINGROUP(149, rgmii, _, _, _, _, _, _, _, _, _, _),
+	[150] = PINGROUP(150, rgmii, _, _, _, _, _, _, _, _, _, _),
+	[151] = PINGROUP(151, _, _, _, _, _, _, _, _, _, _, _),
+	[152] = PINGROUP(152, _, _, _, _, _, _, _, _, _, _, _),
+	[153] = PINGROUP(153, _, _, _, _, _, _, _, _, _, _, _),
+	[154] = PINGROUP(154, _, _, _, _, _, _, _, _, _, _, _),
+	[155] = PINGROUP(155, _, _, _, _, _, _, _, _, _, _, _),
+	[156] = PINGROUP(156, _, _, _, _, _, _, _, _, _, _, _),
+	[157] = PINGROUP(157, _, _, _, _, _, _, _, _, _, _, _),
+	[158] = PINGROUP(158, _, _, _, _, _, _, _, _, _, _, _),
+	[159] = PINGROUP(159, _, _, _, _, _, _, _, _, _, _, _),
+	[160] = PINGROUP(160, _, _, _, _, _, _, _, _, _, _, _),
+	[161] = PINGROUP(161, _, _, _, _, _, _, _, _, _, _, _),
+	[162] = PINGROUP(162, _, _, _, _, _, _, _, _, _, _, _),
+	[163] = PINGROUP(163, _, _, _, _, _, _, _, _, _, _, _),
+	[164] = PINGROUP(164, _, _, _, _, _, _, _, _, _, _, _),
+	[165] = PINGROUP(165, _, _, _, _, _, _, _, _, _, _, _),
+};
+
+static const struct msm_special_pin_data shikra_special_pins_data[] = {
+	[0] = SDC_QDSD_PINGROUP("sdc1_rclk", 0xac004, 0, 0),
+	[1] = SDC_QDSD_PINGROUP("sdc1_clk", 0xac000, 13, 6),
+	[2] = SDC_QDSD_PINGROUP("sdc1_cmd", 0xac000, 11, 3),
+	[3] = SDC_QDSD_PINGROUP("sdc1_data", 0xac000, 9, 0),
+	[4] = SDC_QDSD_PINGROUP("sdc2_clk", 0xaa000, 14, 6),
+	[5] = SDC_QDSD_PINGROUP("sdc2_cmd", 0xaa000, 11, 3),
+	[6] = SDC_QDSD_PINGROUP("sdc2_data", 0xaa000, 9, 0),
+};
+
+static const char *shikra_get_function_name(struct udevice *dev, unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *shikra_get_pin_name(struct udevice *dev, unsigned int selector)
+{
+	if (selector >= 166 && selector <= 172)
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "%s",
+			 shikra_special_pins_data[selector - 166].name);
+	else
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+
+	return pin_name;
+}
+
+static int shikra_get_function_mux(__maybe_unused unsigned int pin, unsigned int selector)
+{
+	unsigned int i;
+	const msm_pin_function *func = NULL;
+
+	if (pin >= ARRAY_SIZE(shikra_pin_functions))
+		return -EINVAL;
+
+	func = shikra_pin_functions + pin;
+	for (i = 0; i < 12; i++)
+		if ((*func)[i] == selector)
+			return i;
+
+	pr_err("Can't find requested function for pin %u pin\n", pin);
+
+	return -EINVAL;
+}
+
+static const struct msm_pinctrl_data shikra_data = {
+	.pin_data = {
+		.pin_count = 173,
+		.special_pins_start = 166,
+		.special_pins_data = shikra_special_pins_data,
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = shikra_get_function_name,
+	.get_function_mux = shikra_get_function_mux,
+	.get_pin_name = shikra_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{ .compatible = "qcom,shikra-tlmm", .data = (ulong)&shikra_data },
+	{ }
+};
+
+U_BOOT_DRIVER(pinctrl_shikra) = {
+	.name		= "pinctrl_shikra",
+	.id		= UCLASS_NOP,
+	.of_match	= msm_pinctrl_ids,
+	.ops		= &msm_pinctrl_ops,
+	.bind		= msm_pinctrl_bind,
+	.flags		= DM_FLAG_PRE_RELOC,
+};
-- 
2.34.1

