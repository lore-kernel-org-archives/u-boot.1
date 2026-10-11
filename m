Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A72CA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 14:42:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98D0E8089E;
	Sun, 11 Oct 2026 14:42:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DzxB2uq4YDtq; Sun, 11 Oct 2026 14:42:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D41298098A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791729738;
	b=cGYg2RCz6YiZWuhWA96UxbAfBKYRCdTBPUGdmzi0EVNLDRh/jIplBiJdJlozqtGvz0eN
	 FiMSSQxHJjOwaAHAUyZZAU/aSeM5TgBu5JECj5rg6ji2lgACbxT1eIsA7GDiOcHwWEgpc
	 UJ0LZR6f7AjWkE/CpIi7AxzfsjxaFh6VGuWz8NkJr0AAEezuviMjHfiKGNRwktpbYQNTl
	 esu1HjMTaMExtKtgSE0hNgMJsdmfpoqmERhfNRQ5HRsRR35VZEM9WoYk6OgaSpunkwkMp
	 ZPM0dWv054NkOU5NBkKm5rsj3k7T2cZhexlEl22ZLjAKEaeswyohU66+NoMmgSnJRyw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791729738;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mUcPalVovv3svEUVIHDe+IxNEw1BR0L888bZgNFgvqQ=;
	b=tNC1bC4IA+M7OTzsbCMUaUNLQMATJC8KuS9O/56JUIvfsqUTuqocSpMoYbGNLEmVBfg9
	 pXqH/LfVuKsaWu3cBNVMF0lPn57tukCXOKdBI2TuU+ze1smy7kXsaNLHC4Y7j40swodbq
	 PT1z5fooIPSfQIhKWn8hFuksqDAPkqvHnykGH14PhzVJxJ23plXTyga1JLkUdcRV/+iG9
	 JNaCawKjF2PzU3mFmzTZR7gqYwd5mVF7NKcvmLkj5GPPejyZ7GQd50dSWMDXDmVRF3Ny8
	 bnTXt7C3JTAUKpPJAZ6H/XIyHodzM/1/8+h+zhuOfWFIC53ADkidYzf6cCM5oDZh/jg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eVqzDdZ4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fHi95SQg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791729738;
	bh=mUcPalVovv3svEUVIHDe+IxNEw1BR0L888bZgNFgvqQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=blY/qeib2CsnxFOgJS4vkkkL3cgDZtnHLGg6W7qnbtlUlUUSh1xw2YZQtgIMrxU4J
	 Q8cdcsBOJJGA0KuD4vRl5nQR3QnrgiNz5SgPUj5aZCGgGLXSzhCnH+GBAuWvpsBGsK
	 NwKs5+ZbpWu62pv1GDn6BvV1o2eYqb46YUsXznbNnJEg40+KkGZV2iUdWiBaTVbvit
	 VB46dZIFw1gYbfXXCQ6dbelVz7YIMYcqlYHUnDt60Rzax3VkJLy4gx7JKHisZ5F+9U
	 s/OxFkxdVzofeM1unjWfsg4yZf9UbGs5Mh8nVpwYOmZNvgFnW/gbfm/KFEREgTuK2C
	 o+28PyhSMVp4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D41298098A;
	Sun, 11 Oct 2026 14:42:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3033E111
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 14:42:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2DBC080898
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 14:42:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dFCF0sbjQrZt for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 14:42:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6A27680713
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791729735;
 b=qESRlGmQ6fOLsgid4mHAZZMtzwjkDRf8YHHON2W9aH1gAIllC3o7lPwEkcVJ/bOMLLy2
 xcq9H0hzjrf2ywvP7+y+ldFrWp2MIZysRVzqrt8UxfmfP/sEiNpZ3TaFw2pk7L8LSy9YF
 ewlDVFG1SyyyYdkyUVCWkFeKPufYp93CvNH7epir/xHFigTLPREHqYjASYN0qyFJlvy2d
 A7lJfynKPnzcGWmEbdRt6TXl+ET+dh7Bt0psWi/OQHJ7EGmpdS1pTEkHWFK2e8CeNVyAE
 kcvwpOhat7SbeJyglGL9muhrkoShBgt+KqDwvnSKA5sdUoDbtn6XsiL8grMRglaqjnQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791729735;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=mUcPalVovv3svEUVIHDe+IxNEw1BR0L888bZgNFgvqQ=;
 b=OHTF4EaIKqeDNFHzgJ9vL2FnChD2gmri/xNAf/qpkD+3PnENw2sf9GPTIs/T+zLgOfZb
 1InPSbmojouct6sosMDuXB+8yA0GNsAnDVqjs1Vgmba4IT+GnOrNuzcqktm2po/lGVNo4
 +85doYizyT8ViFYW1hh/5mRAxY2+oAArRYu5nbg+C9Ugf4lecLygIxyOpjqV1E8fF0sbt
 Z3s+QgXrApRkiOWHqV0JvFmgahiNff7a4mMLdrRYt4G2W4ZIwagKfdrL8O/ZHnS2gFqPe
 YLNbZNNb1ZfZBq56S/ZwY6SIWs+h7YQO4oQq29M2cH8bTOvtaC/kPS0aXt48MJSoWXw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=eVqzDdZ4; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fHi95SQg; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=eVqzDdZ4; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fHi95SQg
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6A27680713
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 14:42:14 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69B85Wdb2112857
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 14:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mUcPalVovv3svEUVIHDe+IxNEw1BR0L888bZgNFgvqQ=; b=eVqzDdZ4kVWtysco
 sqdb2iIG6EvwpBHZvbgK32v/cR0r1gcUwvND+WE46wpdSuN3/iGYUVtPB6h1pXnK
 4JHaNPDMNPeXVfQiEKIkLgln8AvQIRjKIRwIc6RsBptfBKKDo6bY5s40CsgCA29P
 4cKAigL1RqLRQYDekd+VqL3EwxTDWTMTVJE5V7/48EmzB/bnBM0JiYLaTlUMY5/1
 UI/8sQjLVze+AxahtRtAvM9kD0aRj6HA7FmYDJgifk6jOdTfd8vhSVF8omZ2IJNa
 ST+fLr70r60UrW5VGTG0AMfxTmzhZkyA2ViqweTmd8yd2G13Mvl2Y2i3p2UsWxb5
 jirVsg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7en9u14u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 14:42:14 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-917bab67568so45336846d6.1
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 07:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791729733; x=1792334533;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mUcPalVovv3svEUVIHDe+IxNEw1BR0L888bZgNFgvqQ=;
 b=fHi95SQgVDMTkdv1a327ELwA4YaBhZRrFagwV94DN6VLxcNq+f9j3xPAClMJilCd5J
 XQbggzCJ9AHrQ4BHz2DdjdJJ6cU29Eg3EBbZOWd1+SOaMb9tASgn3kzX76f4QnifXoKz
 KW1atnjpAqOrPH2Gbg6Gex2JhIONCiT0mEpkkJUBGQbtv952rysY65gFmzrgW80ZR6pz
 Zg7ZicveJKU5Gs0ITAwgCG0zouhZkrQ3HwGVsYq/pD0alt+1aaXIz94nVvZHkDTMT7gk
 YjdMRK3yi9Lp0beF89LBad7dfsM4hAiD/j/wk3IhZvk2+v5RgYtBTHR3qAbnTrc7XAG0
 IAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791729733; x=1792334533;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mUcPalVovv3svEUVIHDe+IxNEw1BR0L888bZgNFgvqQ=;
 b=w9yXEuR2NNMtPNVdL/V2tHo3oHaBxD67j/rNIVnENtCp3rNbZlHTXXVqFhfhJWo4KK
 LZj+9jyHxI3nuYSk/TnT5mMZ/4XstftmWsP1KQovCIabVS40SsQ0c5Lm6/zvXOkJHRp3
 AEteLOUdTLd4LJo0Krscl+pZFch/cB6qHIkYnX1v4qMudIrGT4uxOq23DNLBNJHv188Y
 r0MwgLffd0wN6Hv1PqwlE0SASDmHiWFkXXCTB33TOl8sbPMTS+ChSN0l5dfYMP6QrIsk
 Qt50KiY86fyGSju5AG6J+duYiJ9n6Ve7gUg0i6JpKuXXPv/Umt/TTD5/rsKFr4P1bllW
 Cwuw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJiSIPXkU/Ao0IqFuPfGWSPAafkxX+zTKzsyytvfsFsqUDYPR6kihhyYl4V6UGcESI7QCuzyo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKKD4NjD/vUUncDapEC66MD7jfJ5n8OwIT15oR/MQ5ydK8BB7dB
 IuGzvZYK2424bOCobdtTX/kTkAf4dz10YKwmtCh1FjMxa0RprlhNEdroeL4NBxeuggOw44d1SVt
 /m7yQpnwrbYPI+xoFIwRfbOrqckr78y7vj6t3XXNGTRNqafeN+0Y/AvS590dsnwbL+hDhqVs=
X-Gm-Gg: AYBFou1NCJ6gMB1uz1O2jx1LZoqKr8NU2/PdOxSEMKpJNyrbYF81SOA4yhYKmEWMA77
 R1UVVl9v/4S5iIdOmOhn1LUBzO5nvwG+SCC6JVlLTuK0UE6ShmGKJEENxmLnVCWQeEhz8k9IbaK
 DE5hb0RAIl3ZbKXVXDDmGpKdxLfYvbBT7fzOBASZ3rRqkv51tflq0odUMunGhhN4WpJx8uMfC8S
 1KNCUplCS3kEu8vKAf+5yJCr3dIhSWR+m6GOBltq6eYFxGWw4nbCxRbLL7deRpGBQwURF7BEZaE
 rNzRBLKLEpmnyzJg71dM89fG4z5EIg0XNdSexMw36aVSDbOaBaCKt2BzEWzkgKzEnjLmc+p4Zpt
 vlEc3iS43c+f9nBnESgl010Zrr3B9xgjkgAfm7y9QeWEi
X-Received: by 2002:a05:620a:46a0:b0:93e:c12c:f141 with SMTP id
 af79cd13be357-93ec12d0721mr1167645785a.75.1791729733219; 
 Sun, 11 Oct 2026 07:42:13 -0700 (PDT)
X-Received: by 2002:a05:620a:46a0:b0:93e:c12c:f141 with SMTP id
 af79cd13be357-93ec12d0721mr1167643385a.75.1791729732742; 
 Sun, 11 Oct 2026 07:42:12 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b179dc0c8asm3854326a12.13.2026.10.11.07.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 07:42:11 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Sun, 11 Oct 2026 16:41:56 +0200
Subject: [PATCH 1/5] cmd: avb: add read_pvalue_hex/write_pvalue_hex
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-upstream-avb_lock_unlock_b4-v1-1-a45aeca54016@oss.qualcomm.com>
References: <20261011-upstream-avb_lock_unlock_b4-v1-0-a45aeca54016@oss.qualcomm.com>
In-Reply-To: <20261011-upstream-avb_lock_unlock_b4-v1-0-a45aeca54016@oss.qualcomm.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=Woe+otfv c=1 sm=1 tr=0 ts=6acba046 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=CZvO8b3GW2mycMafNwoA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: 1-tOoU7jaMOAlXxPD3LF97e-DflNPGQj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA1OCBTYWx0ZWRfX3duUvKZoE3h2
 ZLXGvQYNMODfcwVUbLM+1pWtLZx+DmtfXIdgSQkxz1+aN58fYNEn82BW7wrHVNtT1Vqd/Ev2PTG
 7QBSjb19JPJ6JoWvxaDJ9dn5vMXlcv+Y7JPS7LS6rHdVBURn3fnteAODIjwgAL+02Hoxnx6lJhV
 KF+/LdCn7jwzt4Me0+W4XnDwz1/60K8mpx4dN7uiqP4qOmyThTspCmKb4Z9r5QKsUxrswtz6WcV
 DUkXkNwsu3GZY2DjU3oMf9Hk8NevOiKjcn5KjwH1o8C7ToIVh2ku9KHIGs4hndH5kuWsOp5iMTs
 ia6cTuI7uUJmIGbsBiTH77LcI4HOvBJsZLP3GzpJGcBW0x4+Xbckj1zDSb2EDYJGYjycRbcm0C+
 tgPdY1myACMspG8rH98exABxRluX0NeT5mcJdM/ES5iUd4nQ1dIVCPLWBwM5aiG0L0XGGPyGjgM
 lVPvURA24t07bn38+ig==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA1OCBTYWx0ZWRfX86ajN6G3r2//
 r2Ekyv7nDuqqE8hG3IjZFydLl1hfyYV2gbxSIe2hylCWoS4h9Yj+oHEJonh/Dzef0NTLI0VFSzn
 O/cXWTm+YIjLB8T1ekNvIcITYBDZwr8=
X-Proofpoint-ORIG-GUID: 1-tOoU7jaMOAlXxPD3LF97e-DflNPGQj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610110058
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

write_pvalue stores its argument as a NUL-terminated string, which cannot
carry binary data such as the 32-byte SHA-256 root key digest consumed by
CONFIG_AVB_ROOT_KEY_TEE (persistent value avb.root_pub_digest). Add
hex-string variants to provision and dump raw persistent values from the
U-Boot shell.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 cmd/avb.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/cmd/avb.c b/cmd/avb.c
index 8fbd48ee5a2..6f8df7ecb6d 100644
--- a/cmd/avb.c
+++ b/cmd/avb.c
@@ -6,6 +6,7 @@
 #include <avb_verify.h>
 #include <command.h>
 #include <env.h>
+#include <hexdump.h>
 #include <image.h>
 #include <malloc.h>
 #include <mmc.h>
@@ -427,6 +428,100 @@ int do_avb_write_pvalue(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_FAILURE;
 }
 
+int do_avb_read_pvalue_hex(struct cmd_tbl *cmdtp, int flag, int argc,
+			   char *const argv[])
+{
+	const char *name;
+	size_t bytes;
+	size_t bytes_read;
+	size_t i;
+	u8 *buffer;
+	char *endp;
+	int ret;
+
+	if (!avb_ops) {
+		printf("AVB is not initialized, please run 'avb init <id>'\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (argc != 3)
+		return CMD_RET_USAGE;
+
+	name = argv[1];
+	bytes = dectoul(argv[2], &endp);
+	if (*endp && *endp != '\n')
+		return CMD_RET_USAGE;
+
+	buffer = malloc(bytes);
+	if (!buffer)
+		return CMD_RET_FAILURE;
+
+	ret = avb_ops->read_persistent_value(avb_ops, name, bytes,
+					     buffer, &bytes_read);
+	if (ret == AVB_IO_RESULT_OK) {
+		printf("Read %zu bytes, value = ", bytes_read);
+		for (i = 0; i < bytes_read; i++)
+			printf("%02x", buffer[i]);
+		printf("\n");
+		free(buffer);
+		return CMD_RET_SUCCESS;
+	}
+
+	printf("Failed to read persistent value, err = %d\n", ret);
+
+	free(buffer);
+
+	return CMD_RET_FAILURE;
+}
+
+int do_avb_write_pvalue_hex(struct cmd_tbl *cmdtp, int flag, int argc,
+			    char *const argv[])
+{
+	const char *name;
+	const char *hex;
+	size_t len, bytes;
+	u8 *buffer;
+	int ret;
+
+	if (!avb_ops) {
+		printf("AVB is not initialized, please run 'avb init <id>'\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (argc != 3)
+		return CMD_RET_USAGE;
+
+	name = argv[1];
+	hex = argv[2];
+	len = strlen(hex);
+	if (!len || len % 2) {
+		printf("Value must be an even number of hex digits\n");
+		return CMD_RET_USAGE;
+	}
+	bytes = len / 2;
+
+	buffer = malloc(bytes);
+	if (!buffer)
+		return CMD_RET_FAILURE;
+
+	if (hex2bin(buffer, hex, bytes)) {
+		printf("Value is not a valid hex string\n");
+		free(buffer);
+		return CMD_RET_USAGE;
+	}
+
+	ret = avb_ops->write_persistent_value(avb_ops, name, bytes, buffer);
+	free(buffer);
+	if (ret == AVB_IO_RESULT_OK) {
+		printf("Wrote %zu bytes\n", bytes);
+		return CMD_RET_SUCCESS;
+	}
+
+	printf("Failed to write persistent value `%s`, err = %d\n", name, ret);
+
+	return CMD_RET_FAILURE;
+}
+
 static struct cmd_tbl cmd_avb[] = {
 	U_BOOT_CMD_MKENT(init, 2, 0, do_avb_init, "", ""),
 	U_BOOT_CMD_MKENT(read_rb, 2, 0, do_avb_read_rb, "", ""),
@@ -440,6 +535,8 @@ static struct cmd_tbl cmd_avb[] = {
 #ifdef CONFIG_OPTEE_TA_AVB
 	U_BOOT_CMD_MKENT(read_pvalue, 3, 0, do_avb_read_pvalue, "", ""),
 	U_BOOT_CMD_MKENT(write_pvalue, 3, 0, do_avb_write_pvalue, "", ""),
+	U_BOOT_CMD_MKENT(read_pvalue_hex, 3, 0, do_avb_read_pvalue_hex, "", ""),
+	U_BOOT_CMD_MKENT(write_pvalue_hex, 3, 0, do_avb_write_pvalue_hex, "", ""),
 #endif
 };
 
@@ -478,6 +575,10 @@ U_BOOT_CMD(
 #ifdef CONFIG_OPTEE_TA_AVB
 	"avb read_pvalue <name> <bytes> - read a persistent value <name>\n"
 	"avb write_pvalue <name> <value> - write a persistent value <name>\n"
+	"avb read_pvalue_hex <name> <bytes> - read a persistent value <name>\n"
+	"    and print it as hex\n"
+	"avb write_pvalue_hex <name> <hex> - write the bytes given as a hex\n"
+	"    string to persistent value <name>\n"
 #endif
 	"avb verify [slot_suffix] - run verification process using hash data\n"
 	"    from vbmeta structure\n"

-- 
2.53.0

