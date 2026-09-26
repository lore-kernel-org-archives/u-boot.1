Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E56FC98328
	for <u-boot@archiver.kernel.org>; Sat, 26 Sep 2026 07:27:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D292C40A71;
	Sat, 26 Sep 2026 07:27:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7XUm6pdKDlFn; Sat, 26 Sep 2026 07:27:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5491E40A1F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790407669;
	b=AWyMkH6k9yAND5x/c8ic7MGXpJiV+lJphQCKw5wYkKjJye6BpzjXRprlNPNOJML8CGyJ
	 4tDm4fmvZ7TT2s89m6u9/NkvH58HMUZe6Wy/y3xe2hqma4YZX7zJre4KNZEXsjoNRJptZ
	 6+ylsj6Cw/EQJNvQ9MyhBOfqI6eqVyEHWLQ8rF15YSSnrYh4JkgZugv3vWSBZmnnZygjT
	 /BoGtVwjkkL67rwqJn93ETEL1K0cv4fCm/jtMhh15ogd2LR8Q2x5EG5W/oJ+/Fj1GR23c
	 2yC6UZfTJXZyzlYcR+KA/jSX64TZj6zOac/rp0/vxFRZCdlPRfW/SuXtBdncJiBrOjA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790407669;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mc0sBFkZwjkYyvU/qFN9iJZjr/Zd6ujD+u5O8LYQCeY=;
	b=sBvSZoE/mQuq0HL2GvYCHgZ0LFyBHKm0EYfNCsROS0m5TgeZuXd0gFdBu6TEL5j1o5C6
	 sp1wJsNirRj35s4xDQipwM7Pf8xlsmclTIyuZLMlnFVpjZeVBjSnfZ1Njp+3uMOewNyGI
	 QbjQpRCZSffaHWUiEWRfYD83DlBjMbEOuQZBGGiYCKBQqZJgxxpzRxiXjZ18XbqqBagO7
	 ciPhqY2ZcyJ69Nf1atxuUxsI2MOqmnv/k2pJ/6ujYOIlI+eP3F8Uz5U5OCZc2/mXcndgP
	 FE7LX6vc2FGth9+E3USceSgvMV01Omw59e3uZTtJAPEQBM2JIZ9hGjezQRFkXKbBsYw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790407669;
	bh=mc0sBFkZwjkYyvU/qFN9iJZjr/Zd6ujD+u5O8LYQCeY=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jFMeB3+vmv47wjyY0jboUThmiQMOKbvoA0ymL4qHPD/Lv54hrZd6xRCc68NpaCa/8
	 8EW2O5USAUDZqBnkpx+fCxjiddEdYtcpsOzIAKQia37XUPRl+lNJGTC/sfNZQlzx3A
	 zAGbsDiinCZrETMNys81z9r5M3UUNsiqwBKAngNUz6opLLdI9zzaOguORI38RDlaJp
	 WsmCO3tknLGizdvcR32WIsoK976AwmncW2/Tmfk3Du4ZIwOGrN6CE2oOZ0bCUdPRd3
	 TUi2rDZI/iTGt350kCj2r8r9qetIItNxCxYH1GvZiLIztlnwOO5Wfu7fJ0d60Zqf4k
	 LlggJyGV205uQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5491E40A1F;
	Sat, 26 Sep 2026 07:27:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 677AE4B8
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 07:27:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4A5094009C
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 07:27:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w6yaHESnk6cf for <u-boot@lists.u-boot-project.org>;
 Sat, 26 Sep 2026 07:27:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4600640062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790407667;
 b=ryqQt2ZZfVhV/VovkMCr5C1c8G5C96zdl5IkpwFjDRi/xfuVIW0HTbmGCtRzWcJ5dkA4
 2KVUndpz/9F0zsPItRF93lTcDp5LWvu/Co/GQ0NIC810Y+XcaT2Rx4BG7AZ0AVIkvLt4z
 LSz52x9FuTfBtMnUrMEuzyR8z7S3h3msuYVMjBsHCGADUoqsOp2ja0u0+D7CnBtiscdv6
 ofrexnOXX5z5dOpDcS4TErPV/0JVCiLOZxtYLkDUuNtSmvVovkHKTJzWpUDtdumqaBxtg
 +l7zRaEGvO9vyRVbYmBT1wqh1338+FIlVtY9x5jWjpBsc42qkrofAxAnVjgXB0dfRhw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790407667;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=mc0sBFkZwjkYyvU/qFN9iJZjr/Zd6ujD+u5O8LYQCeY=;
 b=iOXEvqAx8cg2gEI80LRaLIPaLTkNgf3oMwqeq9vJJEJrmfFuVrz25SqMwRjral9iLu4B
 vmJwsDSaMSUb70UH4cA+ny24DmMuczzAY+tnsODxsM/wGz2DMS9+EQqQTpHkC2sMvu1lp
 vH8dGB14l9D4tibvq//RiRUsprZVxI94FHQRttYGZb0OP2kEXV4cFyEb0bwqpzgSlD5Rt
 UqIYxrjbRQoZPr236GOOIiNN9/vfl6kLHn2lixxO/OrjrYt3Sito9BG8yf49iQxjqqf/S
 mPoR3Q24LuGI9nawBfMAPUndOwvgYYWx28Uv1icGaaoxIHJiR2yUbTjs9Y1iFGI91sQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=B6FkFxI2; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=GcPLQiqz; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=sumit.dhami@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=B6FkFxI2; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=GcPLQiqz
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4600640062
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 07:27:46 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68Q6OcFp2790399
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 07:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=mc0sBFkZwjkYyvU/qFN9iJZjr/Zd6ujD+u5
 O8LYQCeY=; b=B6FkFxI2musItfdmz/ZRI5aYQno/rtbjqnKQiz5qjeKbo/84+Cj
 P3uBzBoFX+Pq6ET9JBA3S9gwYGgcYvvG93wRpOkvQaBg6bNPStnIzAlZ2RKypeJ3
 YCjogz4wcftEB2IuCk8u4/nL9OHI4l9geFKC9GBcknE0N7wR3JV/rKTb92Tn+Nej
 J37+KMVQa4KRzTcAvfE77yqr0Z1fT+Kf0EPyk00mgjMM655iiWyR8vLNbLrBtEyl
 +W4OXuzfru6f650mSZ/YcrSMvlIr7qZtp5/HDzpoeF6l3znhI8rkiH0sDPTUAuX/
 69VtK4SCxd6BLtzRCLrpGex57LDOQlp25JQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx6tegak1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 07:27:45 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33baaba6371so3538663eec.1
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 00:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790407665; x=1791012465;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mc0sBFkZwjkYyvU/qFN9iJZjr/Zd6ujD+u5O8LYQCeY=;
 b=GcPLQiqz6TAh9m5O+EADpfeZdAjGr68NJEqx574ZhjFV26MXjlZaO9ClI1v3Efne3c
 97oo3Ov4uJE+0aGzEy8EyprjvDNkn3A0bDDCjgCrgu8HpDt8sin+pur5Qh6BkcJGmQNT
 5kwnVB7w8kDKXxbFyO0IUgu69Q6Y4QJHt+MEJ1i0rQVmYfKJj401ekdBIRGZRXi8FlV/
 3cUzyxfuXidAaigltNlz4YOqTCWURE/iXsVJpG2sam1Qbed2emCRHdxFkgKPf18zPfcU
 F4dDgemNsJhTIrnnLWkeRioI1AEG10aW163q/A/bQQrBBjOJJ9OxDHoQvkCaHLKg+idh
 qj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790407665; x=1791012465;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mc0sBFkZwjkYyvU/qFN9iJZjr/Zd6ujD+u5O8LYQCeY=;
 b=HkwOgZz9TzJzJYyMt+U2l1W8TlJvgkBEPZquvhKR29BC19P7A3yVvhdRk5EFGnw0vS
 bQylx7lrt7GP/6BbF63EyFmR6BPWNm3bUBTtd828JrLYpBdq3IrIsYbr0J3fg/MUNLdd
 57zHERhHWGUmJ6zNNk/jv7CSgbQRhZwakfci8Rd3SKGLVoyN1VBfQ19zx22R30JvvOSR
 UjmTxCEqJOqSbW2IsTfrr2yMN+zTcz8p8fh6wpLf3l4W5FlKQhqWKuZa0eVaMbGQgmOI
 675ct/Qgr/Q3truGIlm80hxzjIhnvyuEPh1F7u368xxZFXEvwYlqzRr8mWRmNugHiAy9
 bwsQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxtd+L3qquY+bD6Pi4xJz1JrlVRtZUcRHzu67Il551GS/0RvlRyjpy0qNUROYFd+PWJB3DP3NU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mbrXhRl7tPaNmJMoayRJ61oHJhFrl/kE0SXp3tWhQXlHW5z0YB
 0j0TcvnMTAshk14dFcjVs/LGzdyCkVwWMogpUeJuAyuJ9S0Nk/ibTJWlmGkD3Gj0Mb2gaNfJLlg
 UqRA7In95Ub4jk1W2LKgwI+BUjTkMj8zMP+zi3v1Bz/GOAVBdYT9gXvLiErwIYzbGN39ufrOfED
 Xpg48=
X-Gm-Gg: AYBFou0V5fpKmR4diZxn1qOupKSA7OYbVW2PJjECc0ybGsZykOtRsZSBxZ43TLRMleu
 w0uFmaIMnawInFFNL90KPTg39QNv1HGkpunLEI8TS8DKdpamQAkdO8e7FPfcWN6LuUDgSKt2bBu
 /m8P/OFcmJIw1eU6ZRd/3xIAdFNbkFC8Ww8kjAvUJbe0mxda/a+9AEB0aBI08JPBRjCqT/64+EY
 j/BQ0qoRSuMAFyN2ZBzVuT6qVMnLdD3ZzUnzylCt0UO0v4pU/cSTEWdjZCQ8lXQp1I8HToNZFNh
 thHYFQrByE+iiMaP4R8j79h5XYGA9VmUmzJA9rgkp5WFgloQug5wrZ9UwfRAqG//sZk1zQneCRu
 hOkCv54rHDH6DL7uZMz+//qr9X+49sUZ29tn68gGihq5SjhcMT1h1LzB//8/UJl3BRVMPBAHZo5
 ymSCGMYcq/tdstmfA=
X-Received: by 2002:a05:7300:ff42:b0:33e:bbcc:eb99 with SMTP id
 5a478bee46e88-34270ab2d32mr2513465eec.18.1790407664920; 
 Sat, 26 Sep 2026 00:27:44 -0700 (PDT)
X-Received: by 2002:a05:7300:ff42:b0:33e:bbcc:eb99 with SMTP id
 5a478bee46e88-34270ab2d32mr2513439eec.18.1790407664341; 
 Sat, 26 Sep 2026 00:27:44 -0700 (PDT)
Received: from hu-sdhami-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144757747sm13370186eec.13.2026.09.26.00.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 00:27:43 -0700 (PDT)
From: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 sumit.dhami@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v2 0/2] sysreset: qcom-pshold: configure PON reset-type for
 reset via PS_HOLD
Date: Sat, 26 Sep 2026 12:57:34 +0530
Message-ID: <20260926072736.3351143-1-sumit.dhami@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDAyOSBTYWx0ZWRfXykXqdeeR1ajO
 wQLi8cb/ujrthBEiEuy6Xe3g8qMtG/WBPBztbkd8m4YLeDPs0WrxuaRGGX3qx9uMklwUXrE7NQC
 acIFdffxofa7TwbpVm2KerpfGhWYL00C3z+pk5Wc9hlBrnD5oKgYx6ngRs781HP8Lkdxi7wKT8W
 U7Ju7i6S46e8ohsD+0g8ymHfqXkNiWnAQEk3a7sezxLMMTPvMRlici5j0jX7Wh38Fj5mOOxBYZP
 hBfKYVX9vVbK1FW5eFLOR3oCivCQ41/85lD092cR2UCYFuQxyMIerAkFraFClGQdh854PLAGPV+
 IekFOBTMDOe1Zgvd1SKopeIBlXRqsIGNiDppP/5JOKfRN+9Tb501JfPrywrxkRnFugddw/sxGQ6
 /2kgktzfGR1QUPtkktlTIRUz7abMS1Fsg4pCiGOSc/91Gtwn2K3WMvCeiLJ8jAOapkZlzHItA1J
 7gJ3YDRGNfljREpKY8A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDAyOSBTYWx0ZWRfX14ctu1uNbR6l
 GbyothtTWwbstEiyDtUH5rLTO6NUZQwdl7YOrt7jNtHHZgBwlZaODTTAK0p9nDxtpwgEvPDx2UC
 aQ7Iz4XmOGUC7EMJWAeUiGeSjJUUqcc=
X-Proofpoint-ORIG-GUID: MRe7ztnfBa2zDzC9O0aqoS6eysvxbS4Y
X-Authority-Analysis: v=2.4 cv=X9LHu2Te c=1 sm=1 tr=0 ts=6ab773f1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=zx4mUbIIilgWQ7_tW8sA:9
 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: MRe7ztnfBa2zDzC9O0aqoS6eysvxbS4Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260029
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

This is v2 of the PS_HOLD reset-type series, addressing review of v1
[1][2][3].

This series depends on the Snagboot support series for Lemans-EVK [4]
(qcom-snagboot.config, qcom_lemans_snagboot_defconfig,
CONFIG_QCOM_SNAGBOOT_MODE), since patch 2/2 modifies
configs/qcom-snagboot.config.

Background
----------
In Snagboot mode, qcom_lemans_snagboot_defconfig disables CONFIG_PSCI_RESET
(PSCI services are unavailable in this mode), so sysreset_walk() falls
through to the qcom-pshold driver as the reset path.

On PMICs where the PS_HOLD reset sequence is implemented in the PON PBS
(Programmable Boot Sequencer) block rather than directly dropping PS_HOLD a
reset type needs to be configured. Otherwise, the board hangs on performing
reset such as hard reset.

Reset types defines the behavior of the PMIC during a reset or shutdown event
(e.g., warm reset or hard  reset event). The type of reset event is determined
by configuration register PON_PBS_PS_HOLD_SW_CTL in the PON module. Another
register, PON_PBS_PS_HOLD_RESET_CTL2 contains the field S2_RESET_EN that
enables reset. To configure PON_PBS_PS_HOLD_SW_CTL, the register
PON_PBS_PS_HOLD_RESET_CTL2.S2_RESET_EN needs to be disabled before re-enabling
it again.

Per the PMIC specification, a warm reset sequence additionally
requires further software configuration and if that configuration is
not performed, the PMIC's default behaviour for a warm reset request
is to shut down instead. This series does not implement that
configuration, so warm reset (SYSRESET_WARM) is not supported here.

Changes since v1
-----------------
- Patch 1: dropped the "qcom,pon", "qcom,pbs-pshold-sw-ctl" and
  "qcom,pbs-pshold-reset-ctl2" DT properties entirely. The PMIC PON node is 
  now located via its "compatible" property, and an in-driver table maps that
  compatible node to the PON_PBS base and register offsets. No new DT properties
  or bindings are introduced. Warm reset support was dropped: per the PMIC
  specification an unconfigured warm reset defaults to a shutdown, which this
  driver does not want to trigger unexpectedly. Only hard reset and power-off 
  are implemented. Reverted the unrelated U_BOOT_DRIVER() whitespace reformatting
  flagged in review.
- Patch 2 (was 3/3 in v1): implement SYSRESET_POWER_OFF
  (RESET_TYPE=SHUTDOWN) in the driver, and enable CONFIG_SYSRESET_CMD_POWEROFF
  in qcom-snagboot.config (rather than disabling CONFIG_CMD_POWEROFF as in v1),
  so "poweroff" works in Snagboot recovery mode where PSCI is unavailable.
- The v1 DT patch (2/3, "arm: dts: qcom: Configure Lemans PS_HOLD
  reset") is dropped from this series. Adding a qcom,pshold node
  requires it to also be added to the corresponding Linux devicetree. That patch
  is being prepared and will be posted separately for Linux DT review. Once
  accepted,the U-Boot DT enablement patch for Lemans IQ9075 will follow as v3 of
  this series (or a follow-up), referencing the accepted Linux patch.

[1] https://lore.kernel.org/u-boot/9665575e-f7aa-4870-a88b-7412643dc571@linaro.org/
[2] https://lore.kernel.org/u-boot/16d8ac69-b8e6-4d4c-b2fa-6538246d63fc@linaro.org/
[3] https://lore.kernel.org/u-boot/6a241ac2-5726-4f0f-894c-d75cbdcd0fe6@linaro.org/
[4] https://lore.kernel.org/u-boot/20260803-snagboot-v6-0-e8bf7a6fc0a4@oss.qualcomm.com/

Sumit Singh Dhami (2):
  sysreset: qcom-pshold: configure PON reset type before deasserting
    PS_HOLD
  configs: qcom-snagboot: enable poweroff via sysreset uclass

 configs/qcom-snagboot.config            |   3 +
 drivers/sysreset/sysreset_qcom-pshold.c | 122 +++++++++++++++++++++++-
 2 files changed, 124 insertions(+), 1 deletion(-)

-- 
Best regards,
Sumit Singh Dhami
