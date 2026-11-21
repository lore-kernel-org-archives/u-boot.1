Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F68606A33B
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 06:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ziZ37nuQ;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X7CLW1wy;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K1NKg3n8
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27F1A40DEF;
	Sat, 21 Nov 2026 06:40:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9tWU1xLJaSat; Sat, 21 Nov 2026 06:40:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 10D9040DD1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795243210;
	b=Un3K9G1ntCjT562A+tCffG/Ja/N0fJVTAvcBbE88GRoQtwW5+Rjax5qZGoq7AMxBYb4Y
	 UEqiFZ9EZWq18rtKgaEFtruYX1UMt32kwgTCVqd/tO/yEtUI2P7NFycQ6UewigUo0/WN9
	 eF3Pbc7JU9WfzcfTeZV4kh48SoRQ1qQDRZpc1lXBgwR+TJ8Lkt3M3u4xl0SKvVeqDXnn0
	 icWOe6iE+zT6TPiNAqNovvuRh5108vxqmHBnqu0uFfL8Z298j3q0wLVjMuJHutP0i1wCj
	 370X/6V/n2CnLseAQf6MZPfQo0OnXoHGf5Vbj3gP09o5b4EVP7JdIo/SijWtO+7sS5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795243210;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:X-Google-Original-From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=x+LQ7AGKuVLmz5AdJz1hvzJ6YdaHcWNddnsNhsvHit4=;
	b=ZJEYQnjyXKm5bOTIrUUzHzsCH4U09WXRkajuRSXiNVhdis8kjXDSg6pFxdrh3yiMs5Ua
	 fuCCjcDOQAqEW3d8e5bwxIJKgYxpSIAMrUPlCSPjaEkKeaAOjl4oq1D5j0TQnVOMoVspY
	 SZ0OAn+i9OmIb1SIqyxkshv/ucCR94V0Dlkk0o0Tj9DHq0tpAobWQwB2NwYb47ElNa2bB
	 dXkdzImI5rrUVS4PR7kGFkuMpSxBM5udvUTbF2i5Iqqrb7kMFmq8TPeKbIHOzpSspT9rQ
	 ueWhIrPoBMFA8fR7yNhHdTDctMthjx1H0815gQapnnsnljLuneg+SogbjsY2Gp0h6dw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795243210;
	bh=x+LQ7AGKuVLmz5AdJz1hvzJ6YdaHcWNddnsNhsvHit4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ziZ37nuQf8zKihO6DoZvSMMgmf8F0J+SxqK7TzYeyM9MLkSRUzVQVn5dUDupk1xj/
	 6XYv6C5lyVotjnn1weOI95nMCFW3rzVjAyql0ho9qNVBQOXanjZFDOxIRJ0zOyfwNa
	 kT8RSGmnlGuxxaTRwLvo0z2DCbEFL2yvrOwpCAJuz4mL2pkUfNUX6aq04+3vFIe57A
	 0OgetBRFyuNeDXs/GJQw4xdKsXhPd1TOZ1K5mSmhvw8+f4Inyu649rsloFKMPHOpe1
	 6pjzNNJTj1OTe1HAd6iUWUvZ4eXpzM9tifb8+LqCyYuJ33rxGONR10yHLQtuC/sThc
	 TsiMSexVn/ogg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10D9040DD1;
	Sat, 21 Nov 2026 06:40:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E3141AB
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 06:40:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 108E2814D6
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 06:40:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k_m2puO4Ku8l for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 06:40:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BD83C815FA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=manikanta.mylavarapu@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=X7CLW1wy; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=K1NKg3n8
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BD83C815FA
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 06:40:07 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AL4CbFY3256902
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 06:40:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=x+LQ7AGKuVL
 mz5AdJz1hvzJ6YdaHcWNddnsNhsvHit4=; b=X7CLW1wyYWiScW8iKhXPA+QxXze
 dw5zU4FvfGbxi5/qS5a3QTHrhRGnL9Xwl5mex660ZNRErnKD5DIG5fAY/idkkyh8
 arUz500NRo2KNz5z4turu1mDAboDlAYq0QVR0Ov7W+Ya9M9MtTZl4HaU+1i1nfHn
 m4xn4RyB0uMqOF3eIqsmwSvKc4a3yYVz/lWOho61zFepO5Z9c+rDyq3WveDk1DUL
 5894ubSME/Xryw5TzZmUK1MU9/HggcykIO3Wevg5NPIvg75npELEKIPGgzQuWKYX
 jeLHg177B3am7Xyz/YaD/HRZXo2Hi/D4b/9U9TuaY/KP512qt3nKdoQ/7Qw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j342gg85b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 06:40:07 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-383165e9b0fso1828725eec.0
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795243206; x=1795848006;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x+LQ7AGKuVLmz5AdJz1hvzJ6YdaHcWNddnsNhsvHit4=;
 b=K1NKg3n8bqKcNByWLujBSqgah64o+81XECd7UxB/Jp82IgUidmE4aYncjXTYC7H9x/
 qVXrWSPEIgMQP+o/tQRRsXF3eHYE5pfvOonR4jyPXcEWq5Vg4FXTtCsqbv+DczNZsGCO
 ZRV/JIE+avhtdB/eee/MDo09iKuymK4qBfVsMm6O7fTAM6QxUW0KxrQ/AVC3FDkx5YxJ
 UyCvlKTOaLA8ShrqVgBcVSkiSgbvFaFuRlC7hLR3efFvjk2RR5ON85GZrIOaGCVGymOR
 QAbKnX/M3Fw1Mobm9KlGZZvdWtXdKu9AcP3E08HsCNh3/bfQUx3OtyXkrL89/ka8Rd+4
 rJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795243206; x=1795848006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=x+LQ7AGKuVLmz5AdJz1hvzJ6YdaHcWNddnsNhsvHit4=;
 b=rWEHt87NW2mjM13rb8/TfQB04pRuZ09d0WVwFI7S7DL4DpmS2SsPXqErZdjn4x2xCE
 w4zG2bBdSlIC8ofwF0pwcyRUemggaDT/01O4+A+nVOAJKw8gVC2EXYABzNkL+cJj53fC
 pLbjnHps6HjsIZTkrzM0dLAYTXkEgDu0NePP6vfdRRq0FV4dUJaURSKjkPfggSV7UBZ2
 sp1yN0VFU/8l6vizLVh9NrXm/sb9yfZRXOh/7FaYcVmwSiG2GS8c4NoBT+SgEY9yYSjO
 GQGbPlRWvRTMvwqmwbEO9ErQezJVxh4T94sbCf4Dlv1iyPD70tFKcSkgffia1Fd3q9Kw
 pVhA==
X-Forwarded-Encrypted: i=1;
 AL+hErEBxhVAPIPiR1k9U6RLadKDy4YziIN+64KkfQdqcgN7yeWl7UWCayR6Sr4X9H5Hc6DO51cZTpc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+30xJJAerOtZDMd6r0R+e6d/ikO4ENwvmThuGG5/V398WiOCQG
 8Ccp5LdeTTiiyuz5hniwDfrPD54Mb/VSt/nYpYdde9fmyV0J6/WFT8bJO44YsT+9O2lfO/7rMid
 wRotwjQydTCSwFcgu5xL7UOYEBc3ftLgIVk+9He/WFgTMjqQeqRRaQ5l6WK+wOsuST5gMQQE=
X-Gm-Gg: AZFdTZfekbdEkrYwIOxRrwL2qYJlMUSvI05KOd36h91q0dTc0YqvGw2mTFiV41B0XGO
 AHn3jg5FGqONRAZVytq6ecNpqpLHSG5S0jpHGg7O0xgSxBWAax2IlX1X4pKN3HavFtqbE4VwJM6
 bsRNvR0WjB0Q7069xwiiOWM9H2HIYgcNc4p+xT5tLNhp0GZebHahr9xTgX9eF3FSy1wUOVjWQ+S
 L7yDqSzcwCFBWO3RAP7vdgRXFSRul4k4TYQfbKgb1rMub8qghwSjskebonH/aSmMru2waxGj/vD
 SZtmMVjr0cCo7Epzbu+4Yb9tjSaM5KWcqTDIcpzff9Gj1UL5NcOLYiPBoB9MQwAwfuGuFYKBDYn
 kXnylwst2gXO2q0EyLD3R4Vv2QdT0Q37D/DH5fxJ8ZJVk0eHGmhM8/Se4wGUTSGZUdwz+kVTG0H
 in
X-Received: by 2002:a05:7300:de44:b0:375:c5e1:931d with SMTP id
 5a478bee46e88-3857073ebabmr5193843eec.25.1795243206272; 
 Fri, 20 Nov 2026 22:40:06 -0800 (PST)
X-Received: by 2002:a05:7300:de44:b0:375:c5e1:931d with SMTP id
 5a478bee46e88-3857073ebabmr5193817eec.25.1795243205745; 
 Fri, 20 Nov 2026 22:40:05 -0800 (PST)
Received: from hu-mmanikan-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566cd46c5sm16970487eec.11.2026.11.20.22.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 22:40:05 -0800 (PST)
From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
X-Google-Original-From: Manikanta Mylavarapu <mmanikan@qti.qualcomm.com>
To: trini@konsulko.com, lukma@nabladev.com, jerome.forissier@arm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com,
 manikanta.mylavarapu@oss.qualcomm.com, deepak.g10@oss.qualcomm.com,
 dlechner@baylibre.com, 3305708832@qq.com, jstephan@baylibre.com,
 jbx6244@gmail.com, dlan@kernel.org, anshuld@ti.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Cc: kelam@qti.qualcomm.com, gpotnuru@qti.qualcomm.com
Subject: [PATCH v2 1/5] net: dwc_eth_qos: allow platform-specific DMA channel
 and MTL offsets
Date: Sat, 21 Nov 2026 12:09:15 +0530
Message-Id: <20261121063919.3313168-2-mmanikan@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261121063919.3313168-1-mmanikan@qti.qualcomm.com>
References: <20261121063919.3313168-1-mmanikan@qti.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H+5OUOYi c=1 sm=1 tr=0 ts=6b013cc7 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=2-k0SVyLfpYsC9YwG1AA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: 8uMQcz1WWdNTx45mZjviHSNUlHDJkcVr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIxMDAyNiBTYWx0ZWRfX2kivkKMtRSL5
 nF3JCmhcl91BdX8BBVfMEolLGcYaYFaWPsDxtjwhIWJ5kxv+t5H0rhCY8ol7uNt8Auu5qlmj+XF
 5LVdXGdEPoF75jzW/7m1XkMpHahgpaM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIxMDAyNiBTYWx0ZWRfX+A0lYA2lqfOk
 iEyhzbWYubbC6u674AX+/BOTG5+UPTbmKP9IgKlYtV4U9jcsv1CIiC3UoYN8i7+YyLu9bXMe7Mz
 XdH9s/uciThlUVuJNFucqBAtU+lVw+SXyNgV6BLrpQK+BvOVYl/TQlI+os8dL0s+xUCMxYyEWLh
 1KarROTWBJwnfHgm0U2T7l9QYrkH5jnYuMomxLOBU4b8R9GX2/6U14RhBGiT4yZ3Lv3c3LIG6x8
 pvf/RR7YC0FmnvxTCPmL/pInuX6x2HmXTWkyuZrP3KbDtvkdakzhzQIpDPmBoMa6J8ngSSCv1CK
 2Dlfq/w/AP9hhyFV30PK02uLoRWN/4qN4AtbzmJtBnHTG/ch+QXOvtXemehbNFp6C7S6c1Z4hwH
 nu0Z8qDbsfL45D5gMMyLoyqTX3sQGTo11LIdhPnFa1LqeXimjNJA088zqMg4J4iCStvXib9gd+4
 nPFx1m805rg6EH4mTKA==
X-Proofpoint-GUID: 8uMQcz1WWdNTx45mZjviHSNUlHDJkcVr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-21_01,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611210026
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

From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>

The EQOS driver currently assumes that the global DMA registers start at
offset 0x1000, the channel-0 DMA registers start at 0x1100 and the MTL
queue registers start at 0x0d00.

This layout is not shared by all EQOS revisions. On SA8775P, the global
DMA registers remain at 0x1000, while the MTL queue and channel-0 DMA
register blocks are located at 0x8000 and 0x8100 respectively.

Split the global DMA and channel DMA register structures and add optional
platform-data offsets for the channel DMA and MTL register blocks.

Keep 0x1100 and 0x0d00 as the defaults when a platform does not provide
the new offsets. Existing platforms, including QCS404, therefore retain
their current register layout.

Signed-off-by: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
---
Changes in v2:
- Shortened the DMA register comment.
- Removed verbose comments from the new config fields.

 drivers/net/dwc_eth_qos.c | 43 +++++++++++++++++++++------------------
 drivers/net/dwc_eth_qos.h | 35 ++++++++++++++++++-------------
 2 files changed, 44 insertions(+), 34 deletions(-)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 565bda088b0..6f158202124 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -936,11 +936,11 @@ static int eqos_start(struct udevice *dev)
 	/* Configure DMA */
 
 	/* Enable OSP mode */
-	setbits_le32(&eqos->dma_regs->ch0_tx_control,
+	setbits_le32(&eqos->dma_ch_regs->ch0_tx_control,
 		     EQOS_DMA_CH0_TX_CONTROL_OSP);
 
 	/* RX buffer size. Must be a multiple of bus width */
-	clrsetbits_le32(&eqos->dma_regs->ch0_rx_control,
+	clrsetbits_le32(&eqos->dma_ch_regs->ch0_rx_control,
 			EQOS_DMA_CH0_RX_CONTROL_RBSZ_MASK <<
 			EQOS_DMA_CH0_RX_CONTROL_RBSZ_SHIFT,
 			EQOS_MAX_PACKET_SIZE <<
@@ -949,7 +949,7 @@ static int eqos_start(struct udevice *dev)
 	desc_pad = (eqos->desc_size - sizeof(struct eqos_desc)) /
 		   eqos->config->axi_bus_width;
 
-	setbits_le32(&eqos->dma_regs->ch0_control,
+	setbits_le32(&eqos->dma_ch_regs->ch0_control,
 		     EQOS_DMA_CH0_CONTROL_PBLX8 |
 		     (desc_pad << EQOS_DMA_CH0_CONTROL_DSL_SHIFT));
 
@@ -962,12 +962,12 @@ static int eqos_start(struct udevice *dev)
 	pbl = tqs + 1;
 	if (pbl > 32)
 		pbl = 32;
-	clrsetbits_le32(&eqos->dma_regs->ch0_tx_control,
+	clrsetbits_le32(&eqos->dma_ch_regs->ch0_tx_control,
 			EQOS_DMA_CH0_TX_CONTROL_TXPBL_MASK <<
 			EQOS_DMA_CH0_TX_CONTROL_TXPBL_SHIFT,
 			pbl << EQOS_DMA_CH0_TX_CONTROL_TXPBL_SHIFT);
 
-	clrsetbits_le32(&eqos->dma_regs->ch0_rx_control,
+	clrsetbits_le32(&eqos->dma_ch_regs->ch0_rx_control,
 			EQOS_DMA_CH0_RX_CONTROL_RXPBL_MASK <<
 			EQOS_DMA_CH0_RX_CONTROL_RXPBL_SHIFT,
 			8 << EQOS_DMA_CH0_RX_CONTROL_RXPBL_SHIFT);
@@ -1001,16 +1001,16 @@ static int eqos_start(struct udevice *dev)
 	}
 
 	addr64 = (ulong)eqos_get_desc(eqos, 0, false);
-	writel(upper_32_bits(addr64), &eqos->dma_regs->ch0_txdesc_list_haddress);
-	writel(lower_32_bits(addr64), &eqos->dma_regs->ch0_txdesc_list_address);
+	writel(upper_32_bits(addr64), &eqos->dma_ch_regs->ch0_txdesc_list_haddress);
+	writel(lower_32_bits(addr64), &eqos->dma_ch_regs->ch0_txdesc_list_address);
 	writel(EQOS_DESCRIPTORS_TX - 1,
-	       &eqos->dma_regs->ch0_txdesc_ring_length);
+	       &eqos->dma_ch_regs->ch0_txdesc_ring_length);
 
 	addr64 = (ulong)eqos_get_desc(eqos, 0, true);
-	writel(upper_32_bits(addr64), &eqos->dma_regs->ch0_rxdesc_list_haddress);
-	writel(lower_32_bits(addr64), &eqos->dma_regs->ch0_rxdesc_list_address);
+	writel(upper_32_bits(addr64), &eqos->dma_ch_regs->ch0_rxdesc_list_haddress);
+	writel(lower_32_bits(addr64), &eqos->dma_ch_regs->ch0_rxdesc_list_address);
 	writel(EQOS_DESCRIPTORS_RX - 1,
-	       &eqos->dma_regs->ch0_rxdesc_ring_length);
+	       &eqos->dma_ch_regs->ch0_rxdesc_ring_length);
 
 	/*
 	 * Point TX tail pointer at the first descriptor, implying no descriptor
@@ -1018,19 +1018,19 @@ static int eqos_start(struct udevice *dev)
 	 * a packet in eqos_send().
 	 */
 	addr64 = (ulong)eqos_get_desc(eqos, 0, false);
-	writel(lower_32_bits(addr64), &eqos->dma_regs->ch0_txdesc_tail_pointer);
+	writel(lower_32_bits(addr64), &eqos->dma_ch_regs->ch0_txdesc_tail_pointer);
 
 	/*
 	 * Point RX tail pointer at the last descriptor, implying all
 	 * descriptors are owned by the DMA.
 	 */
 	addr64 = (ulong)eqos_get_desc(eqos, EQOS_DESCRIPTORS_RX - 1, true);
-	writel(lower_32_bits(addr64), &eqos->dma_regs->ch0_rxdesc_tail_pointer);
+	writel(lower_32_bits(addr64), &eqos->dma_ch_regs->ch0_rxdesc_tail_pointer);
 
 	/* Enable everything */
-	setbits_le32(&eqos->dma_regs->ch0_tx_control,
+	setbits_le32(&eqos->dma_ch_regs->ch0_tx_control,
 		     EQOS_DMA_CH0_TX_CONTROL_ST);
-	setbits_le32(&eqos->dma_regs->ch0_rx_control,
+	setbits_le32(&eqos->dma_ch_regs->ch0_rx_control,
 		     EQOS_DMA_CH0_RX_CONTROL_SR);
 	setbits_le32(&eqos->mac_regs->configuration,
 		     EQOS_MAC_CONFIGURATION_TE | EQOS_MAC_CONFIGURATION_RE);
@@ -1062,7 +1062,7 @@ static void eqos_stop(struct udevice *dev)
 	eqos->reg_access_ok = false;
 
 	/* Disable TX DMA */
-	clrbits_le32(&eqos->dma_regs->ch0_tx_control,
+	clrbits_le32(&eqos->dma_ch_regs->ch0_tx_control,
 		     EQOS_DMA_CH0_TX_CONTROL_ST);
 
 	/* Wait for TX all packets to drain out of MTL */
@@ -1091,7 +1091,7 @@ static void eqos_stop(struct udevice *dev)
 	}
 
 	/* Turn off RX DMA */
-	clrbits_le32(&eqos->dma_regs->ch0_rx_control,
+	clrbits_le32(&eqos->dma_ch_regs->ch0_rx_control,
 		     EQOS_DMA_CH0_RX_CONTROL_SR);
 
 	if (eqos->phy) {
@@ -1130,7 +1130,7 @@ static int eqos_send(struct udevice *dev, void *packet, int length)
 	eqos->config->ops->eqos_flush_desc(tx_desc);
 
 	writel(lower_32_bits((ulong)eqos_get_desc(eqos, eqos->tx_desc_idx, false)),
-	       &eqos->dma_regs->ch0_txdesc_tail_pointer);
+	       &eqos->dma_ch_regs->ch0_txdesc_tail_pointer);
 
 	for (i = 0; i < 1000000; i++) {
 		eqos->config->ops->eqos_inval_desc(tx_desc);
@@ -1212,7 +1212,7 @@ static int eqos_free_pkt(struct udevice *dev, uchar *packet, int length)
 			eqos->config->ops->eqos_flush_desc(rx_desc);
 		}
 		writel(lower_32_bits((ulong)rx_desc),
-		       &eqos->dma_regs->ch0_rxdesc_tail_pointer);
+		       &eqos->dma_ch_regs->ch0_rxdesc_tail_pointer);
 	}
 
 	eqos->rx_desc_idx++;
@@ -1435,8 +1435,11 @@ static fdt_addr_t eqos_get_base_addr_common(struct udevice *dev, fdt_addr_t addr
 
 	eqos->regs = addr;
 	eqos->mac_regs = (void *)(addr + EQOS_MAC_REGS_BASE);
-	eqos->mtl_regs = (void *)(addr + EQOS_MTL_REGS_BASE);
+	eqos->mtl_regs = (void *)(addr + (eqos->config->mtl_regs_base ?:
+					   EQOS_MTL_REGS_BASE));
 	eqos->dma_regs = (void *)(addr + EQOS_DMA_REGS_BASE);
+	eqos->dma_ch_regs = (void *)(addr + (eqos->config->dma_ch_regs_base ?:
+					      EQOS_DMA_CH_REGS_BASE));
 
 	return 0;
 }
diff --git a/drivers/net/dwc_eth_qos.h b/drivers/net/dwc_eth_qos.h
index ef07660a765..b2e35c72423 100644
--- a/drivers/net/dwc_eth_qos.h
+++ b/drivers/net/dwc_eth_qos.h
@@ -151,24 +151,28 @@ struct eqos_mtl_regs {
 #define EQOS_MTL_RXQ0_DEBUG_RXQSTS_SHIFT		4
 #define EQOS_MTL_RXQ0_DEBUG_RXQSTS_MASK			3
 
+/* Keep global DMA registers separate from per-channel registers. */
 #define EQOS_DMA_REGS_BASE 0x1000
 struct eqos_dma_regs {
 	u32 mode;					/* 0x1000 */
 	u32 sysbus_mode;				/* 0x1004 */
-	u32 unused_1008[(0x1100 - 0x1008) / 4];	/* 0x1008 */
-	u32 ch0_control;				/* 0x1100 */
-	u32 ch0_tx_control;			/* 0x1104 */
-	u32 ch0_rx_control;			/* 0x1108 */
-	u32 unused_110c;				/* 0x110c */
-	u32 ch0_txdesc_list_haddress;		/* 0x1110 */
-	u32 ch0_txdesc_list_address;		/* 0x1114 */
-	u32 ch0_rxdesc_list_haddress;		/* 0x1118 */
-	u32 ch0_rxdesc_list_address;		/* 0x111c */
-	u32 ch0_txdesc_tail_pointer;		/* 0x1120 */
-	u32 unused_1124;				/* 0x1124 */
-	u32 ch0_rxdesc_tail_pointer;		/* 0x1128 */
-	u32 ch0_txdesc_ring_length;		/* 0x112c */
-	u32 ch0_rxdesc_ring_length;		/* 0x1130 */
+};
+
+#define EQOS_DMA_CH_REGS_BASE 0x1100
+struct eqos_dma_ch_regs {
+	u32 ch0_control;				/* +0x00 */
+	u32 ch0_tx_control;			/* +0x04 */
+	u32 ch0_rx_control;			/* +0x08 */
+	u32 unused_0c;				/* +0x0c */
+	u32 ch0_txdesc_list_haddress;		/* +0x10 */
+	u32 ch0_txdesc_list_address;		/* +0x14 */
+	u32 ch0_rxdesc_list_haddress;		/* +0x18 */
+	u32 ch0_rxdesc_list_address;		/* +0x1c */
+	u32 ch0_txdesc_tail_pointer;		/* +0x20 */
+	u32 unused_24;				/* +0x24 */
+	u32 ch0_rxdesc_tail_pointer;		/* +0x28 */
+	u32 ch0_txdesc_ring_length;		/* +0x2c */
+	u32 ch0_rxdesc_ring_length;		/* +0x30 */
 };
 
 #define EQOS_DMA_MODE_SWR				BIT(0)
@@ -242,6 +246,8 @@ struct eqos_config {
 	int config_mac;
 	int config_mac_mdio;
 	unsigned int axi_bus_width;
+	fdt_addr_t dma_ch_regs_base;
+	fdt_addr_t mtl_regs_base;
 	phy_interface_t (*interface)(const struct udevice *dev);
 	struct eqos_ops *ops;
 };
@@ -272,6 +278,7 @@ struct eqos_priv {
 	struct eqos_mac_regs *mac_regs;
 	struct eqos_mtl_regs *mtl_regs;
 	struct eqos_dma_regs *dma_regs;
+	struct eqos_dma_ch_regs *dma_ch_regs;
 	struct eqos_tegra186_regs *tegra186_regs;
 	void *eqos_qcom_rgmii_regs;
 	struct reset_ctl reset_ctl;
-- 
2.34.1
