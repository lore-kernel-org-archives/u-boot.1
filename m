Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8290A606A321
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 05:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=q7dyzd4q;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M2a3K/EE;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FVywb8MV
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 35C7180F29;
	Tue, 24 Nov 2026 05:58:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Tjdrhjf7EDD; Tue, 24 Nov 2026 05:58:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8171E80D82
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795499935;
	b=LwAaTOUvlG8X6bri4wItt1U70daYCfgG00GnDYfnhzl8ORgEsSvCaf2a2cnGIN3ce/1x
	 gylnDjWzBXmfkNFqYAMLz+tN+n1KKU2Zr8UH9JtTnqlG5RkSioB1k+6jKg3kXZkHQacIu
	 Adcf1aL29utRAXDyGplBZCCWhrY8W5nVrzCTX+Ot9s5Kgf/pY5XrhMLEZ+KvIsfZY+wmZ
	 g6sfiz4rYDPgkKtc8hI1A9NRvgIrY5zjw41w+IjGOyNHJJau2PZUy5CTYy1/ZKG6z8281
	 dxFTjkpmZF773tdLxzvRJqMQsJxPItyyWNMqIOMay6DbizsrwU0FgtgfxKhfbhu6XIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795499935;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=g/CxMe3FLd1MlIv2hiMrf+2/PYB4/69CCihs/sm2Jsk=;
	b=PYKRQwB0NMnW1sblH/Rlb8P5n7fPYtYg5CngZo+rJqMzgvl+oanLeF8uTsjJVlTvdQYi
	 pWnyk261uRCdlm8p2rGd7k4hxWomDMi01E/90J0QOMkMn3dSDhFNkIqDAxe7R1Io3K2jM
	 Tnk3tH+iiOrS3o4QtoC/7kCst/BejAq52kiFOwkHMnh5obpmmmeklI4jEQZtgRjasxSKf
	 wF+KS+SLNM5prygqEkR1+nQxGyEdPyHzS9cIrTRzfbbvdKBZJoVgu6enOAbTich5DCJg6
	 oTN7hIOhVgPDTf+76lHfs2/6EjutML46At/bUxr2aJ531awe9pD6ZRdbf6rY22adE/A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795499935;
	bh=g/CxMe3FLd1MlIv2hiMrf+2/PYB4/69CCihs/sm2Jsk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q7dyzd4qqrQyCIowMhSXLEn4LCEkc0X1bJ7aPdt1c8mnOxfSZy4ar+I0swcD6PDxK
	 kj2y0L/6CKGSHDSNhJbeKKLTUOBroE3V/XHgGlVnu7kEbC+vAF4WWPesL+fl/HIut9
	 9CL5DwKvQ7LbACgIZMIVZJ7eRtmyjPmX6k9hEl96vYjcj17e0jcE2deyGtKj0RfBo8
	 v/5OxYYqh9an0zHlvV7RkdOU81uXxq/YCxc6g6KuhIx/k9pCSpRdnr6dedTcaYxR8z
	 zqj35tBCosyhCwy9htSH6W0g6Y5GLQQB36bT7VkGZQjrbkgtmhYC9SZ0slOlR+85zo
	 ZkLhvwtSYwzLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8171E80D82;
	Tue, 24 Nov 2026 05:58:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BF9103A8
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 05:58:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B01F9400AB
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 05:58:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 20DIvWSX2myK for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 05:58:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EB1C340068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=M2a3K/EE; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FVywb8MV
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EB1C340068
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 05:58:53 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO2k68W901979
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 05:58:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 g/CxMe3FLd1MlIv2hiMrf+2/PYB4/69CCihs/sm2Jsk=; b=M2a3K/EEjapKVykJ
 ZldMJHxw0XHRvlyo0IgFjXI1vaz4iyQchIUwAHIFYIgH1eZHBHxqNri6llL5Hf9X
 BqnmfqdZHUzEZUsP2h9yfQPntFacERkESJB4HJFlHyzNTgrZ7SXoKVrBX8ISQKzn
 ZCBob+xdLCogCPB/3pYP3lF4V+tana3DvKWd4IY7cfdgOcULpGIiSD9wFHjVymgX
 TGah6zX1c+WPT4VFnbKRAPKgThgxGchQyKwVpMuFyVl8HKH+igny6tC2/jdhGa+9
 gdlG1SxNQ+Q+TYxcbF2FI6iU0VML6zVD3d1qOWBEtZmdZapTXHEOgVC9BKBhxNk8
 H016pw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4w6ssnfs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 05:58:53 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1b3ae17c536so4093166c88.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 21:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795499933; x=1796104733;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g/CxMe3FLd1MlIv2hiMrf+2/PYB4/69CCihs/sm2Jsk=;
 b=FVywb8MVjd8Xu21BwCrRX/lZ4UgLaVcHkCYmId3IZyW0TD/aN+E5YNpXQfm02EVQOV
 6AohH0s2lGu5ukPwa7TkpvQBeCmgbJy0XN5vxokMt+ifUkh7++YrBCsGt3wl0rskWDqr
 YwwcNf7QDkT2EsMZnkcGmXXh168RZlS3+DdC4ddCYg8gEOS6QCUpb8DTCOezLGcUjPRp
 QpfpdGts8EdoIKgSvNKxskIwDFwLNDDU2uWgvcuOGkAQ+t/2LGj7oUtPtN/F2d7yWD/l
 G5O+eW/Csb2jJyYa7wEOkCzxIsw8vMj0apshX4g5Pq7HptFgduxeSs7EGh2IiTVDygsS
 ACOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795499933; x=1796104733;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g/CxMe3FLd1MlIv2hiMrf+2/PYB4/69CCihs/sm2Jsk=;
 b=p7ZQ3qOxLG1EMmRTBK/ajv+NfjaqN1LH+uV2sKuGkKGI/P36sYPw5Wvoa7bpPSf7SI
 BQoxDGmE6JKDAKY8LJXRRzfnMRrQ9GhWQHlKXU5qAd8dNU0sL5rT7IP/ct+7qYQugPEv
 ckz5ybebIzQjIn0yqDkUvcf5fHPfXWz+DzNHjU8uifmwMCgKPcUZW0oiwiz/uU8AVqzt
 1eJqqrhr1wc2YtroDqxPV4cJQtQJJCIFJySi+QHhgQGGJzfRy0YzhbXqLuLAGlU7g2Vk
 gWZz+O8NBiUaMl8V5r97BUikSw1Fg34baLSlF31vPrVktCoT0nS9b9nZc8pI4CCsWi3t
 7tVw==
X-Forwarded-Encrypted: i=1;
 AL+hErGM0eBeapPrQcp1xlUqphpXp6aawxicHXi9Nc1m4JKOGwtLD2BvHhtoShoeTxItl/TCPC0SACA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z827MAYxK8bpNctAa7b7xIoCLrzotf3Bn4S8LtF8QGq+xF75an9
 eBY9NjKhlTMORwiQkLdHIBt2FVYVwFNt84lroLJB2q1F7YCTGnIlELduTHFUkY5mKGkVliCDMLU
 P7KCI3+OX8zu1TAINL6KDg2iijHMXpEAlZ4UAq9hDAI7V7hzE21ecGlol7TufMkDxQ0KZCe5KC8
 zQx3g=
X-Gm-Gg: AZFdTZcUvFTQN2tUjIxrM46cZyLI6aqrMPNYGH0LX29Z/vuu9lwneGTZ7qlMk4kZyud
 KHNEhkMjdLqdwqFfT80EdY6XEi1hCMkIJRKWHcCDT1mumIOQ1Ky401U7g7GW3V53XU0FDXEKOmX
 dkZNIcpwY8hcelD4R8qDZ9iF5DTq8UpAxe7lU2jkyswGXxrecYS55PklnpeuuWFTPCMK3926kQR
 2+JILII2MGdkhN80JuRWxhWzljYqh6LCSqfPe3Tx8LSkAzWmAtcOuo5GJW9EIGfVy/jJ84E8k2v
 GzMXPRDeaPI/debLlVKs0dHztWNkL936WLF4l1eJulD5MXzjpiDJsMnVd4CBmRfugNbTxyWt/4w
 JMUqiNphNqbQSAOQ1fEu6ogu2WqesRlGmgsOetdc+n632Zu6j/7CsVVYA9nmJ9dpxWn7ffhBPDq
 XuM/KHWnONX3RNW3qKxfPBtmpNX/5vpjMBz+Qk9edLx0hE1Z0rT2HwC96WgZaEs76N7pIxoqsfa
 7SjXg==
X-Received: by 2002:a05:701b:42c9:20b0:183:7d42:cfb5 with SMTP id
 a92af1059eb24-1b5568c513fmr14428957c88.19.1795499932310; 
 Mon, 23 Nov 2026 21:58:52 -0800 (PST)
X-Received: by 2002:a05:701b:42c9:20b0:183:7d42:cfb5 with SMTP id
 a92af1059eb24-1b5568c513fmr14428936c88.19.1795499931658; 
 Mon, 23 Nov 2026 21:58:51 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38567abb870sm34742351eec.25.2026.11.23.21.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 21:58:51 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 11:28:36 +0530
Subject: [PATCH v5 2/4] configs: add qcom_sm8550_defconfig and debug fragment
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-ipq5210-v5-2-b509d2b05180@oss.qualcomm.com>
References: <20261124-ipq5210-v5-0-b509d2b05180@oss.qualcomm.com>
In-Reply-To: <20261124-ipq5210-v5-0-b509d2b05180@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: xpQ_fAneWCmRpX6uMmg_wJ9_t9r8wWe6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAyMyBTYWx0ZWRfXwkdDeUW/9ksb
 KIAgzfLSSamjsDAj/ZTPFaPWeC5o22ztksWOA9YIJ6t0k9glD+mAqDew7jFkGTtfTeekswOgvEU
 7GgHMZLvWs0P2QgFY5YxBQ6xcZo0YA8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAyMyBTYWx0ZWRfX3MNuf424BwkM
 U3LGKwYPC/+1P8v3smy0tAWt8UD1Ws8EnkIBpmEOcfHPv/NRmxcdTorYe+VPN013qjckw213WWP
 YUWZiK/jwQlS2TEzrMR5uERh2cDsssgRW1nnl2pTkXajg8HkFiPoqx1WjU8B9aHMENbDuJPYT71
 Ev1b5Sx0NUmTegn8jRRthYdp+2t6XKM17SSTrYqNvXq66eLLV/Mzm8IT+s8ozIVd0jdxOVV6z28
 osUYcew3SdfzwHDbvx0k3lQKiqN5QbZILc6u3fAq3nFi1zFLEKkMzFXqlplS47L2yvp3t6u9IRg
 3E6OCT5P9Ud4K/YThyuNA3OCXG4CwXnKEi1Wn6atkGyE8spLYATjPWz7dM/cr7fp+8XIGG1aZe0
 6nwGBkrJL5uQN6HKSKoIMZLePuztK9BK9qc/4Yao2CoGI59Wo/LiZ7Kor6hrDp/XCaGBNLO0+9K
 2WWkL4ZbvvaATkW+k6A==
X-Proofpoint-ORIG-GUID: xpQ_fAneWCmRpX6uMmg_wJ9_t9r8wWe6
X-Authority-Analysis: v=2.4 cv=V8DoQuni c=1 sm=1 tr=0 ts=6b05279d cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=unZPNS3TcTlehdJ43tMA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240023
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

Add a defconfig for running on sm8550 as the first stage bootloader and
associated debug config fragment.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 configs/qcom_sm8550_defconfig | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/configs/qcom_sm8550_defconfig b/configs/qcom_sm8550_defconfig
new file mode 100644
index 00000000000..40f7c857007
--- /dev/null
+++ b/configs/qcom_sm8550_defconfig
@@ -0,0 +1,16 @@
+# Configuration for building U-Boot to be flashed
+# to the uefi partition of QCM6490 dev boards with
+# the "Linux Embedded" partition layout (which have
+# a dedicated "uefi" partition for edk2/U-Boot)
+
+#include "qcom_defconfig"
+
+# Otherwise buildman thinks this isn't an ARM platform
+CONFIG_ARM=y
+
+# Address where U-Boot will be loaded
+CONFIG_TEXT_BASE=0xa7000000
+CONFIG_REMAKE_ELF=y
+
+CONFIG_DEFAULT_DEVICE_TREE="qcom/sm8550-hdk"
+CONFIG_QCOM_GENERATE_MBN=y

-- 
2.34.1

