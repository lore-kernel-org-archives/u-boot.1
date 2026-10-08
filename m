Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C45CA600E
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 09:49:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A5BE81248;
	Thu,  8 Oct 2026 09:49:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eDMQO4hONHO3; Thu,  8 Oct 2026 09:49:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7437B81246
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791452979;
	b=C2kYwZ4+2+Utcjqju9i9zGOoxalujxlYpOE+E+Tf/HKbYgj7UBkrn8Ayls298l3DaCCm
	 fsoTq2wjeGboFMcdoH+n4A30jEgdzbSmt6JbjRxP1PP1uIKnkqyggHJHpXjuVUGoKv/uT
	 v760CcWTd/7Zhwod/j+8dTNckkbxBipZmSc0ISzpEI0simwwNpIEgClaoQZZD2tFAGltn
	 dPBaPqiRt6uZC3ywTTgcQ8uImNSzadUoRg437tZbmQzTFSnXGn5OI62y81HotUofbTWwK
	 s7YskbPBDlWk8FZy5tU3W3qq3WPDYUkTbg18NZ0rQULaKUt2fVFTDk1EgozPMJIJsXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791452979;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Y/O0iBQUnQdJzxPA4iMFW05mgIziEGcyI1nAoofJ5UU=;
	b=Vx66ALu/v4vFUlhIwroWg/B6aEtRWLtwSWMBWoWAMbcas61U1AMu9+0JXoagGDEzUckY
	 c9vyN3YU3Oamy6o9FY8dw/NT2zS5tGbqFAXAr5a7qc+SHHoO32iFaiWJDK/nW397Cxk3w
	 NXEG7mJEFOi5ddwKo6iYGgJXMqjRWmUKZs6ilKTIB2KbOI/DKHx47GcPULpWf3/Hv2ipd
	 oJ/ZLg2WRYwOeAkCCYwnu9+EYcOOYMDdjlrIUQH2fxMNogRN6sx8t/eUvqdvhTGaho+AP
	 C8oQhD9L6XpcCXKjDazO60r+baqgmComXQgUKZteddFB6z6g6w2MmefH+T0Aa8bRSDg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791452979;
	bh=Y/O0iBQUnQdJzxPA4iMFW05mgIziEGcyI1nAoofJ5UU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=knBk417jMQ/JrwD/E1yct1s8I+lTF/zKenRhaYdohZBzYjcYMkVxdWPR1Zu0sMaxg
	 CKpWD4onYqYb9cNkerU/9Fa1EdRyDIoRSRk+9iFsnWYXQ9W2zNA8Xrp+PUHRDqhCuu
	 1ST4otHVO5EcNCykvE2b7zHFtC7vYDreLTcceBjy3KHsdwphpb+O6IUFIXpptwBvQI
	 xAgeol88TD+k2J8sIwpM29/xNEe5nwVR4mBO7QMA5t2xZBcazVcEvPOHNfkPCcmJcV
	 yCRrvAi0hoUv/kp4ATUbdfII9Oztacm8vmCxi4my4r9p1i9xtA4eZFQWUhTA8YiVTy
	 pJK/WFbikQAhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7437B81246;
	Thu,  8 Oct 2026 09:49:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8AA2B1D2
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7D21F400C5
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VacTZ6sKU9fD for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 09:49:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 563D940050
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791452970;
 b=gV9R2whLIm39tX/I7T4SGj/c+Nyz9OXDxRlRvsq+JaND6CFs66lxCafIooqyTReoDaPz
 /d/+jTH6UlUNMswoyyAzRK0u861v+rbsUdRZzJ7Lx1+bGnLjqN3gdZrYeu8D82QJbmFEp
 a8TcUzvlGFcidjX6ywN/56qFVD1G0f/Pr5fccsUTCqm2Mpwxd7hNzJrsPNEaJ9OlScuR+
 /MBo1HW9ZXFSpb8oztHTZsMEi4JngXDcSO5SnkpNIlp83avBWwRTWUPAG4EN0dOY8H2uE
 IJ6IjNz7Ibrl0t7loFc5UM5CM5LdrnM5LJlyW/C7rWK2RrRqM2ScBl6zt6vHjgLGraw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791452970;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=Y/O0iBQUnQdJzxPA4iMFW05mgIziEGcyI1nAoofJ5UU=;
 b=eArm0jQIQdFlg2DBr9xTn5QG3XCFDp6FJZ1aqZXrm4k8LCA/iC3kUWTdycckiSI1k+U6
 CM9uNWtGWRFHx3r7PIgCLZTS9zs5ODJPspF7pUmq0pwxMtIX7OYeXrdGsOAeeEvs0rY5/
 31xKn1sNIPUcb4pq8G7/7HKWZslb5ZLdvxMmt917Eip/zBYmY29ZCeb2SixZT2UNBJOQ4
 rkzzRTWvsxxYpO8rWLQF11a7reeK9/ErhXUaUHTRqo/nMoljWi9bjpXtDYiwjM5F28qcK
 JoLDHmzRKpeINLoopgdmbKVchBLAjxVpyssP9vZf2N57g6mHt/yWSNVtT2tbaZx10WA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=pYp0V12O; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dW3apeC8; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=pYp0V12O; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dW3apeC8
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 563D940050
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:30 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6987KbFh730863
 for <u-boot@lists.u-boot-project.org>; Thu, 8 Oct 2026 09:49:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Y/O0iBQUnQd
 JzxPA4iMFW05mgIziEGcyI1nAoofJ5UU=; b=pYp0V12OUhdOARqTZUwKc9jXCf9
 j4yeLiRfm3mDEtchMORwlHw/r9+D80Ge/OCZRVLuzBbM43PAXI575MADgFPEyOls
 sJS1G5uTkNELiS67gg+PuODMwfl9SYHqDpny/fiZzY3CfIAwecwBbMS8f4J8u8G3
 bwVaPiRXSnq5tLACnJ/1XIVoE/Cpc7mpOFkroZfuoNuU8EmHr0CQkWSDDAqxm6T4
 EOG0aV2X8wOJU1YbRPyANJUyhy1mi1oX73SHRMP0VgVPG03YFdcYrST/RTVo+kjQ
 snHGh7mhNnE/6x0ZnzQCCmuy1yjTG5vyX592n9fZj0zaXy3bsm3vpjMRraA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe327re-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 09:49:29 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-34d62bb27a1so21311020eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 02:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791452969; x=1792057769;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Y/O0iBQUnQdJzxPA4iMFW05mgIziEGcyI1nAoofJ5UU=;
 b=dW3apeC8/GMTbvOrH84bp21WyeUNBE/43r8ud9qXeG4XEvmL77NBrg2CCABB1BmEiR
 0CtPhZCDiJDZ098WIqmnu8TYk4YE4jbplwEi/ukrDWSupbUaXJ+ndJpd9vsGUsIrwyA8
 RnKc0pUuTUNjm/OGRPz0PCPLGU07Kv8bNUsvDTa2m54aXrxEI7QogCg1ZgFUCHmK2Ilh
 x1rQy8kyfy5oPhTe2Lgur69H5K0RIx+1tHZ9JuCAlisZlggftnumJ6C4hGzKGVnpaGlR
 +hjOQ4DFgWvwMxVbksrJ1KZ1hBOGjyxpW+LxkhXXkq3BSqlv6CGCAayti9TwoM2zNg1b
 GCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791452969; x=1792057769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Y/O0iBQUnQdJzxPA4iMFW05mgIziEGcyI1nAoofJ5UU=;
 b=yTJnbiPgo16dHkQ/1xc+v7kkm2oVXjb9QAwlDPEgEQCk8raOU+td3tL8rzzD6qYx4H
 Wx9p0Ot719AFhrzNw/U3fqyc3OVsKQZh2XxeSo3J/XSei+HexbEsskDMejZgEEyzQqrG
 JgsXZM5TQULaVbTnsBTctnt8CILlnzhA0J4ITvDTcKye9b9oqINeBMMvn0/A6b+ZK0Cd
 7f/QVRXIsRAvse1oJmKhNNO2Q6avi1/ZJlIx/TJB7+12E0TJ7eY0G2HGKC27LTQ5qJkP
 5S5ftmYw2sGuhhyV8NnGO/2wCkyHSwWIzpSb18yM2a6JQ43xztJbI1LKW/sG2nHqk1eu
 6gyQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwCpxL5u9BhTZj5X6upTXwwgHpcA/TA/VMsJzOLbr/ytAJ1h0+mHEMoWCbBQw52opk0mYX7mlQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kWxhubesS/94a8z0Oh+TydpQXv/ZxpP3VgFEWNutrBcB5fPj5w
 FH9xhdQTjoDD34oVGtdMxMOq099LLUzJCfa37wT+h9PdHUlJ5JDQbQm5ht9aTGTIVgoJDM03m0F
 ybvQUle/l/Xsjd2WYNLOvvTvbvsYjqrXxTew+bUiuib0mye/ZuQ8Fwfp3jjfHF8T7biTDRPM=
X-Gm-Gg: AYBFou1JBkomuBxoedQn4lsHH0mgmoYCF8uJxFT1v1QR3fIHL+O5tXSOQ99eu6JinTV
 nx77eiRtuP7SRhNpGVyJsFD9ECMpYL5uQfKlBBTreW4b1rC6Bp4v7szigjxnhtUCgQCS0bsXTGX
 5Ag8nQWI4yQYCB+vaJX+YzWMFDSFx6VDwXaeJsFmvhiPMLAkGhrWNibzKwxK5eRKoJGWXoerzlG
 yy1d0+XcwMjksqGCSsn1zln7qr//IPpqk04PgRibFbF9c6KpRrkEIsXIl0ZDl0CHRmCAVu0QA5o
 kGPfp9dm30qoBuPLl8TvWqxxFhXepBv983k/ngFcFzIacehV4wik65TcUTzk+q00HzubvC3PBFy
 heXT4Fp/OBlFU2IWcfXV3vpyYSAVggvGW8oUHGzJAz6NQs5U=
X-Received: by 2002:a05:7022:7f0f:b0:14c:be8e:69fe with SMTP id
 a92af1059eb24-161fd710eacmr6202573c88.5.1791452968593; 
 Thu, 08 Oct 2026 02:49:28 -0700 (PDT)
X-Received: by 2002:a05:7022:7f0f:b0:14c:be8e:69fe with SMTP id
 a92af1059eb24-161fd710eacmr6202536c88.5.1791452967949; 
 Thu, 08 Oct 2026 02:49:27 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-16375a1f898sm9977818c88.0.2026.10.08.02.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 02:49:27 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, balaji.selvanathan@oss.qualcomm.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v4 06/13] clk: qcom: configure Shikra GPLL6 for SDCC1
Date: Thu,  8 Oct 2026 02:49:05 -0700
Message-Id: <20261008094912.419090-7-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008094912.419090-1-abhilash.v@oss.qualcomm.com>
References: <20261008094912.419090-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfX2ijULTadNHSd
 4fN/f/fFtlOrsDH1Oc0AkOdYde49Pm5jk/Ms7rTWrvqB9m6fjjBwlGV7Y1F6LaubgN7OdjOPozP
 QRNoZv5pFp9oCf3NWKgFU+7uTRvL8bqmaiOafYb4LF7sBU0+ihsCz2GmWaYvEFzL8kUxazRDFmD
 ulFiQNX26wltbOfvrWw1sLxHNHwxImQdP7MlajAKkeGLDwudvIuXEYs0BBA0r28HHe3pzSPZ6gF
 chH/IWP2fZ+8pZHNe2wMA/L6+N9bTbV/W/wc0sreDLJqDSH3xo5iHFgfuAKa3u79Xm6eVy/x1k0
 +/yWre9VxnJi9TMJj/Zj+bvwbwB49SJNcU+I5eYm/VsVM2TxLriayXAvCBMLTvAKU0IBy41TNsZ
 obR0Fod1Se9raSCZdguKJoY+nVmfaMlp/vMrb2dMHayqeTU3cINDJ2fAVvVjK08U8/AZFVxlqsU
 +Jn7cwQhrD9kwoSd7Xg==
X-Proofpoint-ORIG-GUID: vMJ0oldwnO5C6HD89kxNSXuNXV-ZKkX3
X-Proofpoint-GUID: vMJ0oldwnO5C6HD89kxNSXuNXV-ZKkX3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfX4qfBU3DMuWis
 aNJgV26A6JI0+2tcWHCXvHxWsBvmwAlavaZtmcpLWbWqq3lOrcCqiwwYc3r6EZFBOHGxGJt2+7Q
 /upzA8vi9isMY598Xw2xAZNOvYLByf8=
X-Authority-Analysis: v=2.4 cv=KcdHIgYD c=1 sm=1 tr=0 ts=6ac76729 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=OZbkP5GewEWn0qpCw8wA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080038
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

Configure GPLL6 through the common FSM-voted PLL helper
when SDCC1 selects a GPLL6 clock source. This provides the
192 MHz and 384 MHz eMMC source clocks required by Shikra.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-shikra.c | 61 ++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/qcom/clock-shikra.c b/drivers/clk/qcom/clock-shikra.c
index 2c3c5c9b4d8..94501b838fc 100644
--- a/drivers/clk/qcom/clock-shikra.c
+++ b/drivers/clk/qcom/clock-shikra.c
@@ -20,11 +20,35 @@
 #define GCC_USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0x1a034
 #define GCC_USB3_PRIM_PHY_AUX_CLK_CMD_RCGR	0x1a060
 
+#define SHIKRA_GPLL6_MODE_REG			0x6000
+#define SHIKRA_GPLL6_ENA_VOTE_REG		0x79000
+#define SHIKRA_GPLL6_VOTE_BIT			BIT(6)
+#define SHIKRA_GPLL6_L_VAL			40
+#define SHIKRA_GPLL6_USER_CTL			0x01200109
+#define SHIKRA_GPLL6_USER_CTL_U		0x00000004
+#define SHIKRA_GPLL6_CONFIG_CTL		0x4001055b
+
+#define SHIKRA_PLL_MODE_ACTIVE_FLAG		BIT(30)
+#define SHIKRA_PLL_MODE_BIAS_COUNT		GENMASK(19, 14)
+#define SHIKRA_PLL_MODE_LOCK_COUNT		GENMASK(13, 8)
+#define SHIKRA_PLL_MODE_VOTE_FSM_ENA		BIT(20)
+#define SHIKRA_PLL_MODE_BIAS_COUNT_VAL	(0x6 << 14)
+
+#define SHIKRA_PLL_L_VAL_OFFSET		0x4
+#define SHIKRA_PLL_ALPHA_VAL_OFFSET		0x8
+#define SHIKRA_PLL_ALPHA_VAL_U_OFFSET		0xc
+#define SHIKRA_PLL_TEST_CTL_OFFSET		0x10
+#define SHIKRA_PLL_TEST_CTL_U_OFFSET		0x14
+#define SHIKRA_PLL_USER_CTL_OFFSET		0x18
+#define SHIKRA_PLL_USER_CTL_U_OFFSET		0x1c
+#define SHIKRA_PLL_CONFIG_CTL_OFFSET		0x20
+#define SHIKRA_PLL_LOCK_TIMEOUT_US		200
+
 static const struct pll_vote_clk gpll6_vote_clk = {
 	.status = 0x6024,
 	.status_bit = BIT(31),
-	.ena_vote = 0x79000,
-	.vote_bit = BIT(6),
+	.ena_vote = SHIKRA_GPLL6_ENA_VOTE_REG,
+	.vote_bit = SHIKRA_GPLL6_VOTE_BIT,
 };
 
 static const struct pll_vote_clk gpll7_vote_clk = {
@@ -84,6 +108,29 @@ static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
 	{ }
 };
 
+/* GPLL6 configuration required by the SDCC1 clock in SPL. */
+static const struct pll_config gpll6_config = {
+	.mode_reg = SHIKRA_GPLL6_MODE_REG,
+	.ena_vote = SHIKRA_GPLL6_ENA_VOTE_REG,
+	.vote_bit = SHIKRA_GPLL6_VOTE_BIT,
+	.l_val = SHIKRA_GPLL6_L_VAL,
+	.alpha_val = 0x00000000,
+	.alpha_val_u = 0x00000000,
+	.user_ctl = SHIKRA_GPLL6_USER_CTL,
+	.user_ctl_u = SHIKRA_GPLL6_USER_CTL_U,
+	.config_ctl = SHIKRA_GPLL6_CONFIG_CTL,
+	.test_ctl = 0x00000000,
+	.test_ctl_u = 0x00000000,
+	.l_val_offset = SHIKRA_PLL_L_VAL_OFFSET,
+	.alpha_val_offset = SHIKRA_PLL_ALPHA_VAL_OFFSET,
+	.alpha_val_u_offset = SHIKRA_PLL_ALPHA_VAL_U_OFFSET,
+	.test_ctl_offset = SHIKRA_PLL_TEST_CTL_OFFSET,
+	.test_ctl_u_offset = SHIKRA_PLL_TEST_CTL_U_OFFSET,
+	.user_ctl_offset = SHIKRA_PLL_USER_CTL_OFFSET,
+	.user_ctl_u_offset = SHIKRA_PLL_USER_CTL_U_OFFSET,
+	.config_ctl_offset = SHIKRA_PLL_CONFIG_CTL_OFFSET,
+};
+
 static ulong shikra_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
@@ -91,20 +138,16 @@ static ulong shikra_set_rate(struct clk *clk, ulong rate)
 
 	switch (clk->id) {
 	case GCC_QUPV3_WRAP0_S0_CLK:
-		/*
-		 * ftbl_gcc_qupv3_wrap0_s0_clk_src[]'s last entry is
-		 * GPLL6-sourced; vote defensively even though this port's
-		 * only requested rate (debug_uart_clock, 14745600) resolves
-		 * to the GPLL0-sourced entry.
-		 */
+		/* The QUP clock table includes a GPLL6 source. */
 		clk_enable_gpll0(priv->base, &gpll6_vote_clk);
 		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
 		clk_rcg_set_rate_mnd(priv->base, GCC_QUPV3_WRAP0_S0_CLK_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 16);
 		return freq->freq;
 	case GCC_SDCC1_APPS_CLK:
-		clk_enable_gpll0(priv->base, &gpll6_vote_clk);
 		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
+		if (freq->src == CFG_CLK_SRC_GPLL6)
+			clk_configure_enable_pll(priv->base, &gpll6_config);
 		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC1_APPS_CLK_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 8);
 		return freq->freq;
-- 
2.34.1

