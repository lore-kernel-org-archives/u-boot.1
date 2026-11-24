Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E42F606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DAgagyoy;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=elJoKzj7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DIGPzgIR
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0BE2605ED;
	Tue, 24 Nov 2026 09:02:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K_uz6fRWZYY8; Tue, 24 Nov 2026 09:02:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 40F84605F7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795510965;
	b=OHGyGElqTTegeB/Ej+iuN4hbRWZ5QSuwwVqqSjoayJWrUVQ2DbKUKd8PdDos872LUJ6z
	 wSEjypW/3tUXlHSaDgJdq8BdGadiSaBcSl9glGyE2cAjTzc0evj+FQDbIiDiplZsJc4TU
	 5ciD5mnlSOWgTO2ZoRFCIXjJwff5tKNiKDXj5godl1EkXixphbsmeLFM3k6h/QOscskgZ
	 cKQZ/VoZUMjcDOMudkA/OjplFWm1eZIAMUxv25CmuzzwqPBACBFofxdckVY3HUw1bOvPG
	 p+Y0334oi0shy1HWmxbvsBibx4kOvP/SgieMoeVYCwIpxIsGpc7254NZzi0PuR6YycQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795510965;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:X-Google-Original-From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=I5lhZgtYMPem6FCv7EgNtbWNP5Sebfg7Rmre7CpcOI0=;
	b=Rx/ghULv/rK0VV492ZD4+9btnxSuTBWhMLE5FaCznTbOo5Rtxs3gVRzp1zL3N5wn5EA9
	 c9DITBKVkY75EzUM4Ce4NcTFyn0MpJOATOxGItS8Fq9XUhoWRIAcSjxaJAuPtnMhGzbC4
	 q7/lklOQpi8hAnOEATmHP6FW+nQL51+eEVEp98OLpU0WOedoizijq0NUd+IXD+oNtHXJF
	 r84vuOkvLh3swkOlwjkbNvUOj35AzVoFWaEu288m4zLPC9Qo98eN/fMowzC9kn8UdHXgk
	 Cth6R5onXpaoT7T7HN7Z54iMwIURLNwyPQJHqfKPj7mtLqSBemRWldennrbW067B93w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795510965;
	bh=I5lhZgtYMPem6FCv7EgNtbWNP5Sebfg7Rmre7CpcOI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DAgagyoyEylGQ+b7gI3vdyo5tCm+y4MCxqecYKMloZgAk4Dv338wujcfnJ63c8Mnr
	 ytLmRfU+ArKHfyHOnBFwpbPNHK5bgSn025KbIYn2dHcZB35Ev9KDaI5M7iKvlzFQII
	 dH4XOn/KNr5ruNE+HH4lwEsI70I6UQv1e+nNUihw+fCl/ioCpbD76F+/BElacZ6+GZ
	 jTsk6wVMqYdTO6CXHJV2/qvvIxtHAzIQRCkDCTvtPCPEXoIORa/AmC4a7H7oGtY6pv
	 /BFRHsNDRr7l6yQ9P8dfXOmht8MTn0c7FEXh/3amq1QrWpfm1TqoiLkNgmDRWIlCRl
	 43MT3CSQMpfAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 40F84605F7;
	Tue, 24 Nov 2026 09:02:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D7BE1AB
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:02:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 53EF1400AE
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:02:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KvOAWrDmSOM8 for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 09:02:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C867440068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=manikanta.mylavarapu@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=elJoKzj7; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=DIGPzgIR
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C867440068
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:02:42 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO86Enp3701099
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=I5lhZgtYMPe
 m6FCv7EgNtbWNP5Sebfg7Rmre7CpcOI0=; b=elJoKzj7Qaj+5ekVChJI0+Z182D
 aAl7MW+4v4GJgs4LDq1KmdRLfu1xCNlwDkSYgnddJE6AcpKThIxb2aUoJ6Rn51fl
 FXhR20CE+kYc91kx8Fg1TpHTser+BopP5w8dirYezuI3vdR3xeO2ctOCtrLpxSiG
 wWMV+lMOSCPP5fo2R9QDZpkaP8jI6cjKrm8ayEOrSrlMRdx+8A3vWPDOQB6uErQk
 JgETtMm71lhGiEd/+bY/6GE3GrfyCdKtjuQmTH9yZzNuYKuiyzmbZpw029lYsVkc
 gKx2AIHB+wgk02RXu0jMbs9LutDd4NNidBq47acB5+UR/v7Ck1OLlEnd6hQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j50ky1nfr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:02:42 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-386ad819860so1659903eec.0
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 01:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795510961; x=1796115761;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I5lhZgtYMPem6FCv7EgNtbWNP5Sebfg7Rmre7CpcOI0=;
 b=DIGPzgIRGT5gtro6g3/FO4SXhRPNK/o5KKX5GrbPJ8qlZcLT4UuJeVLZ9JXLEeRE1B
 /8ja7IY/gnNs0MsgqFTFug8no/8TnEI8MZEtCF5D50yjjcVJ2628L0AnmNNmo/uqA5Cc
 GRPegOqS/qYyJQdl4/BzMCkso0QisbhHeyYbfh1eN8BJXSExAmZpxeuCLFoeZaqYxJck
 WBHb6diX14GY25ckcUN000sy9NwEcye3pUvoUOlKOygMw0NL+btsH4nO0dn3v7SxmLJk
 CffAEN2U+huO1hn71K/v5LYpqIEH+otp+i9dbomcivVqSf6vvr+981p3lGAIeTU9A6j3
 fQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795510961; x=1796115761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=I5lhZgtYMPem6FCv7EgNtbWNP5Sebfg7Rmre7CpcOI0=;
 b=ARbLQnfXhMsu4PP9bMI1S23TbHJ/oQAga+bHRGpt56VdY/jYBB3JHA4hBTFEKCmzPc
 ZG+Tc7xWw5uO1S5ciyLtpwPgTpHpJdvzBaltsq4THyTC6MLwlP16A2gpVcz5t9J59oRL
 xX3s2CdZbV3UdW1fTvrc8GYgm/8R2IIWULOCOV9uYx4wPUM6mz8ILnj90KvJdnuibpgY
 n6wYhu3mmjLxIDkTmpEQd3CBfVi3A+EthObSKNcqtxXJrEwnkKoF9q3g2LM95BOLHbXs
 q6kXAQgs4cudIWd2k6afbAjIgrJ0Ka/QQC2Sk1/p4BV4rKh0iOX4K2wj20eUMLS6sJai
 lsfA==
X-Forwarded-Encrypted: i=1;
 AL+hErEgxkFni7vydEd3wl39rnSZsUBZYIggIkWdix8bQAYDAkXvRWKycImoYIhBF8rhUoSAbYLanKA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+ErzD+N2tuKbQNivneq8YsAfGj01Xw8L2SWzlenlQKX686iYwY
 d0upzUZ6YhSsQci6Nwr4Uleh23OU7SxC55dqblsBs+Hez4JnpWiJzQA6woz8BZ6/PLIAuTfgsYf
 /Z0dzBS9qQeiZ4HDyC/SmDOQtVApGpvfKDlkteAX3AVTHpBMQAHdVzKxG8nRgg8lVGh2xPrM=
X-Gm-Gg: AZFdTZfUV0clTibG9w6vcukGCRCgxLkv6L6DElz/+sO0SuUWkrmGyfkM5ZpTIIW9/4v
 vScKGg3IWh+kFT7gIrlSCcHGffZxUIiX5Em0lUbUBJhpoZZiLISpKe1wG5xqRqhhO5VoKtL78Z2
 g9GKwN4Kq7fx2irG6O1toow/4AJQnOcb4cJw/PZgxwt4IzkjUaNtvsytWeA2x0LSAykdZmIoCVj
 hbPeQIwWo0rAF8nm36Cj3K2f4yzAXHODytpTNZU8HJOIywavnzurj3sdxJ80danO4qG1+QqFiyE
 zeVowna7qgVZSPouZibkxAHu/zumtsyNS5WIewBh5zqiQ3sD/Q5LzwNIa6/He1PQD2YLTdwmTBf
 /xVEyeTeCRyQAOH1nM2piJzyVEkBoYgDmHOQ91+VY04AwKFIOotcNKMmdj/DS6iDtNMYdTKrlLH
 6E
X-Received: by 2002:a05:7301:a23:b0:386:9ad5:6641 with SMTP id
 5a478bee46e88-3869ad56b0emr11308649eec.32.1795510961139; 
 Tue, 24 Nov 2026 01:02:41 -0800 (PST)
X-Received: by 2002:a05:7301:a23:b0:386:9ad5:6641 with SMTP id
 5a478bee46e88-3869ad56b0emr11308627eec.32.1795510960663; 
 Tue, 24 Nov 2026 01:02:40 -0800 (PST)
Received: from hu-mmanikan-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566fdce48sm46429154eec.14.2026.11.24.01.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 01:02:40 -0800 (PST)
From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
X-Google-Original-From: Manikanta Mylavarapu <mmanikan@qti.qualcomm.com>
To: trini@konsulko.com, lukma@nabladev.com, jerome.forissier@arm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 manikanta.mylavarapu@oss.qualcomm.com, royzah@gmail.com,
 deepak.g10@oss.qualcomm.com, dlechner@baylibre.com, 3305708832@qq.com,
 macpaul.lin@mediatek.com, jstephan@baylibre.com, jbx6244@gmail.com,
 dlan@kernel.org, anshuld@ti.com, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: kelam@qti.qualcomm.com, gpotnuru@qti.qualcomm.com
Subject: [PATCH v3 2/5] net: dwc_eth_qos: support 2.5Gbps link speed
Date: Tue, 24 Nov 2026 14:32:07 +0530
Message-Id: <20261124090210.2560500-3-mmanikan@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124090210.2560500-1-mmanikan@qti.qualcomm.com>
References: <20261124090210.2560500-1-mmanikan@qti.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Y+ptIReN c=1 sm=1 tr=0 ts=6b0552b2 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=9u_b7VjEs_DDEDrxvuoA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: lk5Xv8I5_xkG7w5E_8-Ucd32wTQ5kGLL
X-Proofpoint-ORIG-GUID: lk5Xv8I5_xkG7w5E_8-Ucd32wTQ5kGLL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzNCBTYWx0ZWRfX8b539T3KHzZG
 BBj9gKZg6wf5nN7QyeZ1mpraUulY0FzSjTxxAWOdIba1of2y33Hua4Peo4m7dnpNOMl/TCcfD2t
 g5otsOsEWrGdhAoNtybMLt0Bcf+6kEQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzNCBTYWx0ZWRfX+m3XzPo6Z4tV
 ceCh1dDw0iIFv+kLNiVIPDauhOl02d3qOi9whcSXOkxdf8GVsPD0sVms+sKPrLJOuVD2S+cmSFG
 1Hm14KNBl2iSfB9gFI97tIbwaNiodVUshtOEB9Kb3zLk3nJf51ZH3GwywkRCxj+tkP6GX28Sq0S
 7DT29bFnWLILB1pnYtLIivu/XQArnYlmJx6mbiT6ix6+vX1npmvUvIihUnVHKF00G2QFaL6LgaC
 1JOyFO54lkQ0y8vTcdF20UFDJ7dINl4wDIpRmWaqeJmjh1qH18u+QAQgEWouYd115w/TbDo9svh
 MMtNB15dMKJXONiwzMPS81/xFt4KMK5P0xT7iM+rzSNRrEgUx3GMSyhYB0cBQN8u8nToccbuTzh
 VDvAjGK3Oj4a66CNhesKe8RjjYIAMH1/ddCqy2yVlLP3NB23+1sW+AByE5TIxPZcpgvaiIG7dfx
 cwFhd63Iem/UYgiQ+vw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240034
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

From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>

The MAC port-select and fast-Ethernet speed bits use the GMII encoding
for both 1Gbps and 2.5Gbps operation.

Handle SPEED_2500 in the generic link-adjustment path and leave the
platform callback responsible for configuring its clocks, wrapper and
SerDes.

Signed-off-by: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
---
Changes in v3:
- Let SPEED_2500 fall through to the SPEED_1000 GMII handling.

 drivers/net/dwc_eth_qos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 6f158202124..09c6c2e30e5 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -557,6 +557,7 @@ static int eqos_adjust_link(struct udevice *dev)
 	}
 
 	switch (eqos->phy->speed) {
+	case SPEED_2500:
 	case SPEED_1000:
 		en_calibration = true;
 		ret = eqos_set_gmii_speed(dev);
-- 
2.34.1
