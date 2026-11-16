Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6C9606A323
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 11:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NIQJp0xL;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nTA4tlIt;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dA1XJcAN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D005A406CA;
	Mon, 16 Nov 2026 11:49:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vt3oevFrTjYs; Mon, 16 Nov 2026 11:49:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 15635406AC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794829756;
	b=owkRzBnsN/ZUxuf2UWDt7boGk7YF32N8n/5YXJg88ZFXoYc6tDfGdTQzQx8BYkhV2qyl
	 4IN3r7TpyBi7z9VnmiiFK2JGzkr/MhgJmtlPmLnp+ZrBP/foUpT0ZisNMMXgdz5bpEXWy
	 ASoEOlPSMgdSw72eicm0tnKz64IxlSLRALrUXMGssZQKkc4D51QPtqKEURPfmnPGG6Mzk
	 1FVTHuiWk8J67N8QUC4fhM9ymyAiBM/huyn9S6F21djir4pm+YYAyYcnlbfq09ggsIS5H
	 AfCQF7aqEdffFANIgDPu0cadkvTMwbMYcSXel2MNv8fhboCb2kD+2BrnIlbSXHGy1Ig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794829756;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EVDA9AAUYq2LzcC7kyfQ7uowoL/OYMw/+ZfMlAEH4NI=;
	b=Gu0pl7GaM9szKd/VmvcYz9FUvbZdlrqCCDTFW+oivOZ8MsXojsxnceyRFhx+sRTfWsH3
	 f+2NT9wdGrjo4Yj+narcON8up8u6l7C7qnzPJpZT3bGMXxwn2EV0vwF1lb84FE5L8/D3S
	 0hQ09RRyRnWc88LrTCSh2OpnXdQgguCjk9E45JPN18obR7kxnSGTHlxQxpgUn2XO7TYU1
	 gfE2alQntt/16Z++zrOhRMQIN5ZSCHWDjwwdX8J4VizlQyeboSSTlCKrpl97ufSxL8cfw
	 rVSs6U5J0biDRTJuCXF6P6ZMSPeiHLibQ4C3w6+RWsX2afDEof7vbiBsqjFHKPGpkUQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794829756;
	bh=EVDA9AAUYq2LzcC7kyfQ7uowoL/OYMw/+ZfMlAEH4NI=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NIQJp0xLxqurvgc+DSq+5n2z3tP5GBWYuIUT+oQV41Yt+Wu46ZOg11/7Davh1qmLK
	 l0xvhURRmPJbu8qYGnFhMPuAj0EGXZBH16cZogGPb081Gcks9IOm6sn9tpuoMjO/5D
	 6wjvnEII95R98J2/g3/K6yGXBs4H4vG9CRMpCxQIBVke7gQXjKMAUf4MZmQfTAp+0/
	 KJYazVuI+Ano8i0RGZVvynigwwNr6b9ixuY2AFq6o1kOQQyH5yEtiatNouwexh+ZeJ
	 HGVy+LiqeCfpl0dE0XyQcdJY+wW9QRBXUbmfQpnVtz3Ssq4EW7iCazbuptAGBcnQhJ
	 iEsUI+p9b4Hzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 15635406AC;
	Mon, 16 Nov 2026 11:49:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CC00D1A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:49:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B82AA40259
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:49:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Oi8WaBCrLs98 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 11:49:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1606040068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=nTA4tlIt; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dA1XJcAN
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1606040068
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:49:12 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGBM0KR3982736
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:49:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=EVDA9AAUYq2LzcC7kyfQ7u
 owoL/OYMw/+ZfMlAEH4NI=; b=nTA4tlItRp7+CPKPCURrbz0dkk6O/ZZWev9VfF
 XFyBav/1K5zinIXcA5dsc86ujGE1/C3UOi5XTlGpyRVOnX1RKeSLevCSHYKULVYc
 M9A3HSXMavVhClWW73jHCiMEyXf94LJ1kSRh2rhe+UzNq+pE3x/o3oLU0NO2s7hi
 R1y6nIn+fR1SCrA4l9bDAWAdhfQxIyGLpM4Xvszz2uzLI4SKj9KgdZ4i+gSksP1Z
 whZBJ+sN09LrJ8KdvsWA+n9mpqFh9F42IfcJHyDoBSYq/5NDXfH9kx8uYTF4HASs
 jc8XBJhsXle0Zo7fZ9DKM6Eb0klgjvGBf7sYIytSOQlMg7aA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmce7ut-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:49:11 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341eff9e381so5308832eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 03:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794829751; x=1795434551;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EVDA9AAUYq2LzcC7kyfQ7uowoL/OYMw/+ZfMlAEH4NI=;
 b=dA1XJcANy7acwYqPIPEc81xYA4w4bHBq4SGLxBPLCv3Y2pewH/8MpjP4lDzHaKA8tN
 JB0aLZbleuOVrqY/3VRknoALsgwRYdQv4E/PA0VxZskp7bthevyRqyM8dc7IsijH4cTe
 LTJ/IZkrp/6Mu7cOLjw7WYRYRI//plGnELaYBCqVT6W8+RZULXXUkOX3E5+ab9Zwj+vv
 HtrzcZEU89KWLuQ+Q4Ig7ZpL+oF5GJS3GuqwB33XHltEesympks6pWtTyX0I7dLB7jqG
 WuDtdCjN29rb1A8crrWzNpYY+US3isSfVexobHweGOOS3P7i4n6XNr5bg7LIDWxjAtWB
 +uMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794829751; x=1795434551;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EVDA9AAUYq2LzcC7kyfQ7uowoL/OYMw/+ZfMlAEH4NI=;
 b=aJQx0i+EyJzNuY9DtugnOpZC368uZRx/ViIY31jad+ydV2DX2SolX2bY6kxMoZD4rb
 /pClHLUISfHQPN18RaiugRHoNo0ew0piFliQaOIg9oUhAB34jPoC8aTfY4v5he53s3Ft
 B+uJxjAwtAvc7w5n6Q0SM6VENN8rEWMhgDMtJfnmDOtW6rIC15iqgurd/fRk9GMVQjz4
 DZtnfsxgjai6T7n7ribrUmI7sWNNELabm5HRa+VZ8DFOWmS+1eQSp6FPcc7KlbbN49cS
 n2xztFueY7J0+Gdj+oXMwFpFxkYVdaVWs3wRna9mCSZUXo9TaOES4zqoWmBqpGdadiN7
 Ffgg==
X-Forwarded-Encrypted: i=1;
 AL+hErEv88veOebR5k4Qmvz0IXf+tkHr1MlbOANC7e66Hlghrx45EH3zsdoI2SM35RI9X0BNyzAz4UQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/eLpn7GH7lpKTGHwSn6XaW1JQEqrXPIEKVRZ7+aLNrK2dZkPnX
 Uo4bz8dP3Jm1aVPN1MKlYYloVIlcpQHQkxTCElfKtBQ3AswrgjHjyLNOLEr38InluwUKrZRAZ7V
 NqrXancFNVGkWjQVAMVzjoFrpC6AGMxaAbVqtRLf4pguYpe1/k0sB56TyaB4UUYaRzw5GFHI=
X-Gm-Gg: AZFdTZd17b8B1zVyfuAe25M9ztrRQq8gF1e4Bkj0t6SAM39fEnYPKBSV2e7EeFNLmik
 LJuO2iYfOjl+NtSAgyNfKz6z41xSXH05HSt/tKocEdINOfsRgCaI5mgriz+2gOyk9W3Uh1IVnbU
 V+Y6+XMHzK/vX2PwM5WXrSQGw0qV3ziLlpVwrn8B9AvwuyhOi5muS7ttOL9DyN8NcFTekVu+J+d
 /jydabIpd/erNKDnHs+8gTxQVy5sy2zQyg67RY40pLS3tZsCt6uV3kAwJ/O56CKL/G0cwB6y05v
 ZjTFQGKCpsBLHG7y1IbE22WA97rZodjG9bcA2358BbbCrcDstScLPaG959zl7weBoDrnIYX50u6
 kpD15eMMSV6b8O+Mp7/9vba8zKuKnpU1LQoofbD99YQpdkM0Od8tTL99gpr4IsAAjELH9uHQMJu
 6mYNzE/s9AkH8WuYFODR4w1WarWyk+OVNqbkXe/m9Mgk72QW+eR5+3aiAD9HhoEQgG5EOn8oWRj
 s4d
X-Received: by 2002:a05:7301:182d:b0:376:a6d7:8f60 with SMTP id
 5a478bee46e88-37967ae21dcmr10905401eec.40.1794829751010; 
 Mon, 16 Nov 2026 03:49:11 -0800 (PST)
X-Received: by 2002:a05:7301:182d:b0:376:a6d7:8f60 with SMTP id
 5a478bee46e88-37967ae21dcmr10905385eec.40.1794829750509; 
 Mon, 16 Nov 2026 03:49:10 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955822d58sm33802527eec.10.2026.11.16.03.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:49:10 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 17:19:03 +0530
Subject: [PATCH] clk: qcom: qcs615: add USB2 secondary controller clocks
 and GDSC
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-qcs615-usb2-clocks-v1-1-ad6256a70eb3@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAK7t+moC/x3MPQqAMAxA4atIZgOmYgevIg6aRg2KPw2KIN7d4
 vgN7z1gElUM6uyBKJeabmsC5Rnw1K2joIZkcIXzROTxYPNU4Wm9Q142ng2FqRTPoWDuIYV7lEH
 vf9q07/sBpq7ncWQAAAA=
X-Change-ID: 20261116-qcs615-usb2-clocks-ec13e6cd0ccb
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@nabladev.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794829747; l=2898;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=H1chcJFpqqbpqZ881Tw+2t1cdlfUlz7yGdaEdOz2Vm4=;
 b=0C7WlYsX1PArSdxjqUgCZAb/nt+X8fLJepvODQ3FsLIQNug7RW+kGmb9Ry7Q/5PudrfyqcYrg
 4QJspbU8DEJBJq2yQWAeez98ykNoan24l6j/C+ZoxikcUIqgBsMLot/
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA0NiBTYWx0ZWRfX735QOdlDvpul
 qK1vrqQHU5KPUI/TYz3tAX7hVx7fh11fhPiTt5iSPUp0Z9JqFxTXRxoI45Layqap9l0zvP70irl
 BskdJDl7xUvwbmTLkYZryyvGvk7kfN4=
X-Proofpoint-ORIG-GUID: RQm71xuO-_ZP4yoKACmrOZGoAyCpeB5b
X-Proofpoint-GUID: RQm71xuO-_ZP4yoKACmrOZGoAyCpeB5b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA0NiBTYWx0ZWRfX9UmoyVLBrzuA
 bP6mw2xaAPP2NaX3zk1UHijJOZ8zBD7vf24vfqe4ad+x1a03Rvot4HybeLFF+k59jLhtKSzZVfd
 6898sxC/grQWVUJAiQ8o7Kkv881wqcGAoGHdRh6gKgQ9xKXVgSXKoUHMMpvgfY2mqRoL52azfZN
 H0G1MrPpnomGqC1QAOaxQ8hV4TtAYKB9O/oY5iqbg/5su01oB/VtbcvnMmxNJW7gcSe8M45lZoM
 gNUhAenKaCLm7F0Wi6pYFVlxCGA8glF5woTl5SOoqtZu3ZMiedGvjS9dt0visrETs56LtU32Ged
 xxGix88uc7RLbXPZWHGCTse69As61W/UqUk+6YSKjLWm37rfCNhrdj940fqfYM502AbJnZSqJyU
 fiDQd+H24OPnJ59qHRmZqiB1zfSyUtwTPe1qxHOuHXOeX4ky92SMN/gaeCnVuiG/0gHndCNJUY8
 bzbp6H576rv/nSQwJgg==
X-Authority-Analysis: v=2.4 cv=Vpy2kO2n c=1 sm=1 tr=0 ts=6afaedb7 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=pZq29nfMic-kAinx-0wA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0
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
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the GCC clocks and power domain needed to bring up the secondary
USB2 (HS only) controller.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-qcs615.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/clk/qcom/clock-qcs615.c b/drivers/clk/qcom/clock-qcs615.c
index d7fb6abfd25..21a4bbb415c 100644
--- a/drivers/clk/qcom/clock-qcs615.c
+++ b/drivers/clk/qcom/clock-qcs615.c
@@ -18,6 +18,8 @@
 #define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0xf034
 #define USB30_PRIM_MASTER_CLK_CMD_RCGR		0xf01c
 #define USB3_PRIM_PHY_AUX_CMD_RCGR		0xf060
+#define USB20_SEC_MASTER_CLK_CMD_RCGR		0xa601c
+#define USB20_SEC_MOCK_UTMI_CLK_CMD_RCGR	0xa6034
 
 #define UFS_PHY_AXI_CLK_CMD_RCGR		0x77020
 #define UFS_PHY_ICE_CORE_CLK_CMD_RCGR		0x77048
@@ -113,6 +115,14 @@ static ulong qcs615_set_rate(struct clk *clk, ulong rate)
 				     5, 0, 0, CFG_CLK_SRC_GPLL0, 8);
 		clk_rcg_set_rate(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR, 0, 0);
 		return rate;
+	case GCC_USB20_SEC_MOCK_UTMI_CLK:
+		WARN(rate != 19200000, "Unexpected rate for USB20_SEC_MOCK_UTMI_CLK: %lu\n", rate);
+		clk_rcg_set_rate(priv->base, USB20_SEC_MOCK_UTMI_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
+		return rate;
+	case GCC_USB20_SEC_MASTER_CLK:
+		WARN(rate != 120000000, "Unexpected rate for USB20_SEC_MASTER_CLK: %lu\n", rate);
+		clk_rcg_set_rate(priv->base, USB20_SEC_MASTER_CLK_CMD_RCGR, 5, CFG_CLK_SRC_GPLL0);
+		return 120000000;
 
 	case GCC_UFS_PHY_AXI_CLK:
 		freq = qcom_find_freq(ftbl_gcc_ufs_phy_axi_clk_src, rate);
@@ -158,6 +168,12 @@ static const struct gate_clk qcs615_clks[] = {
 	GATE_CLK_POLLED(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf054, BIT(0), 0xf054),
 	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0xf058, BIT(0)),
 	GATE_CLK_POLLED(GCC_USB3_PRIM_CLKREF_CLK, 0x8c014, BIT(0), 0x8c014),
+	GATE_CLK_POLLED(GCC_CFG_NOC_USB2_SEC_AXI_CLK, 0xa609c, BIT(0), 0xa609c),
+	GATE_CLK_POLLED(GCC_USB20_SEC_MASTER_CLK, 0xa6010, BIT(0), 0xa6010),
+	GATE_CLK_POLLED(GCC_AGGRE_USB2_SEC_AXI_CLK, 0xa6084, BIT(0), 0xa6084),
+	GATE_CLK_POLLED(GCC_USB20_SEC_SLEEP_CLK, 0xa6014, BIT(0), 0xa6014),
+	GATE_CLK_POLLED(GCC_USB20_SEC_MOCK_UTMI_CLK, 0xa6018, BIT(0), 0xa6018),
+	GATE_CLK_POLLED(GCC_USB2_PRIM_CLKREF_CLK, 0x8c028, BIT(0), 0x8c028),
 	GATE_CLK_POLLED(GCC_AHB2PHY_WEST_CLK, 0x6a004, BIT(0), 0x6a004),
 
 	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x5200c, GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT),
@@ -241,6 +257,7 @@ static const struct qcom_reset_map qcs615_gcc_resets[] = {
 
 static const struct qcom_power_map qcs615_gdscs[] = {
 	[UFS_PHY_GDSC] = { 0x77004 },
+	[USB20_SEC_GDSC] = { 0xa6004 },
 	[USB30_PRIM_GDSC] = { 0xf004 },
 };
 

---
base-commit: 6487c50b8a40f2668ab98a892b9300ad5c181f38
change-id: 20261116-qcs615-usb2-clocks-ec13e6cd0ccb

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

