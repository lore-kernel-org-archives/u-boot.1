Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDA8CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:28:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA91A406BE;
	Mon, 19 Oct 2026 10:28:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qU7UC2JHyXXM; Mon, 19 Oct 2026 10:28:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3D6B9406BF
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792405704;
	b=JJtu5qNfo5qph4gH2Wvg5fxXAQqMdITCa7vXUuOgaZJ37DiA33ls/prMM9g7Kzyzw+D1
	 z1eC7AIYshRHEPLgDvIyR0g43OxjrOa1jP2ZPPAAR7A2KL9HXDZFK1BgoHhfx5/8J2RFG
	 ynvTkvK1HMM53lA6OgnavxYVw+WhA/ZefHgDvBqpbBGPoihh36vXk7/THcPrxsZNMXm2o
	 KMrIlAPQWLmojKTBh9zODRqSZl1OISwAq+XQu3XGlnkEkdFj8FUdxjNY6PV8b8/FBTqBK
	 rrwCCSJcq0SLHR/Lkzx+livUNzKC9AsCzk4M1B+PkGmYO/ESo3zx2x7rl7Paxsyk7rw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792405704;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Ep6jt0Bun87v9aEDqV/zt65mKAH2/SAenWvsFRd7JfY=;
	b=FBnsEYeMp/JTIoykcRFCXTKFOsDu9gCbunkqUzIlCjxpgXK/yaavM/Tq69Z7d5jo+zmQ
	 W0IBSAhWEg5FvZGZUziQWb5uOQO++rDXgNl6Zk1c793aa2ymlKWTCC/p8oAry9/u2/+rA
	 J+KMCIYQVkNOOaawVw1v6XbSk3F6UPFcpOZV1eEQLw6Q6leyRtHQay2mGN4tTRyKRWlqQ
	 incuFQa/lTvgDA5Yb+9LztlV+stGY6EYUi+bUVM2heM3huiOY+OeslX5eq1yz1Q9dgnoV
	 cQYDDZXjXhy+X4d/DU86ScoXrbZypltDbFaXxeUCDIPKlOuB+FJI0UFtFJuIfKWuVJg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792405704;
	bh=Ep6jt0Bun87v9aEDqV/zt65mKAH2/SAenWvsFRd7JfY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HrPDV5YLbi9zGeF364umRvATUTTwZY8pht3BuQ62gW/OLOwqBT/TvRSGhG9RYX7gV
	 14jUTqt7ix0o3Bev+RWsx5qpqYxdcVjww5BdQMMNsyqJZsvLkZnKc3JPVaKKeeG/Yb
	 kgWF5iS5KPxy9JDqaHA16xHwOuX+5oLIuVHNk59vlnQz5rsMa3HsEeliFTwzVbYkTH
	 hj1pmTLNdYHpNsiRTWCN/F1dqvfTBC9naAdyfGPnAwTlqgZwt71BrZXP6Egxf27L2g
	 dlrJMblrfOQ3faePUKGp4WnRAvbMFGCVxhF/1o94GKFBsjAfEN/vAu+XcDcy2nULFQ
	 TJoundJSFbABw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D6B9406BF;
	Mon, 19 Oct 2026 10:28:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 33D1D279
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:28:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 19F0740080
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:28:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JFag0Wy_VjOF for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:28:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5515F40079
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792405702;
 b=gqEa5iVvmTsp6b/MQOA3zIiiadLBUC2vw3FP/Y7aFV2avC/yzz9VyTOd9b8rjZC4J9Zq
 RShYDDaprK4hVcd+QF0gw9r7CqKEIGNisPf690B1fBgM8mTrYHwhN9eB/GshavantZDPx
 cFRGW+QFLCaexIDBo0hjRWHnDdI2mTRkCuf0851yiT8m1XCRmfitGrm9x1vRqt9ooCXBZ
 TfFr1XmaIhUGPoHBpdF2ftMHaBnuWHI1d0zAo2QBotu916/f/EdaNbm2WXRvPom1gFAh0
 VU8EOkFvsMRXdPw5EjYZIFGilYKZxsylRCTZn3aQsQUhENfMKQ9a5E4PjJg0Q80dX4g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792405702;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=Ep6jt0Bun87v9aEDqV/zt65mKAH2/SAenWvsFRd7JfY=;
 b=BEEAoIfT2m50APL6+AlvSvA8cPaxF9BRyMuBzkoCe2tDL61vsXdT9WARvsRnwCXh9Cgq
 kYU7M4rscyEF7UhSZRl0bQmBJkXf/v//hExlIyPQ64pvPWjYvtwnGOZBTJHYTnhwcfykv
 7zXY6ET7vrICfDPeLoO4paKguu72SYZEdTwKs2YLtsz24MFo3rt0bDw9L9VZOGwZ2mz9+
 +MBwlV4LiK0CyExKi8bZXAiaIUMyLmKDdDoAXCajjJDr+Pvyr5RjdLhHXzmbJhTBNHDA8
 JprqWnUiO1iGpjiC5hQ7ExncxLBkp3LcrLwWdm4VAn8kbbLe/tCjao2GOpqOVhaKquA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=eGpuJUMA; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gDQhhNzY; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=eGpuJUMA; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gDQhhNzY
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5515F40079
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:28:21 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OsXS1168031
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ep6jt0Bun87v9aEDqV/zt65mKAH2/SAenWvsFRd7JfY=; b=eGpuJUMATY4SbV0a
 rrxRYOK+JLcm21oddawAa5/zMpKExL872vlJAkycV6+amTsnKQmqYQkx/txSN3jX
 q35c8q2e1ZfqpG2RWAsP3IZAuvv3gpykQoEuAHgECkB1RyaDxyuT0teNXBzH4pV/
 eYioeuGHUe7Gs3YdxK0OvE3RHIxtNUkpATSh8VdM24hYl+oZ4RjT20K08EKBk2+d
 ft8eyIN40qXW7s/rKifMP+BdHormmj23aEwyil3vcmqRsETf5iwx03sWNNdPtARo
 K61RUi2+ZxhG6LoqAvhFQzTzj1RAMwzvdv4ifqwEAIrLp9n3275zQo8SLo52Lhhn
 25LSxQ==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf5c8kng-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:28:20 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-6755fef4f96so2735341d50.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 03:28:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792405700; cv=none;
 d=google.com; s=arc-20260327;
 b=lBmCTltdiox/4c2AXBowXISF6URXq71PfY5d1sGxbmDqSF4zqmnmkiQBSEN6VQLZno
 cemnadvRnoRrb745wFuApgynop78P9+TJGmqXvNicWFZqRuP02EWZ12RwKzCkh+A9cHt
 Fa6ZnG0q+vksp8Cguh8KV0SxgEFIA7d7Fho+mpqj1SX4WQhz8zEXNOJ18YJCsvJg3Y6O
 lIVQT1165F163ZpO4osMs33TZGrm3sN/R+SGNwnUSoWjtGte0/hgHcHnBbiNFFAlvVEu
 Pq0U9DZjFVrEnjDsbEijFhwHZlJJs1S4BQbcxZj7lmJIhA1zPp35XWu0jx+AIvaSgOwB
 Sxjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ep6jt0Bun87v9aEDqV/zt65mKAH2/SAenWvsFRd7JfY=;
 fh=ZeJZ3O5Fl7aBSQWzmPkTGeglCoNqjYR+vSc/fcHm1tk=;
 b=qVT2MZnxRRYllBrdx9CAC8kSzR44FtAb+IPyz9RWOnnRIlOxnRLQkpfiW72COwiYgl
 kqq3hxHyRzwxLIUG7YJm8YxKXC5RfXNWwr0xIjpA/XrprnYTC3QdPIJigLVW1AXGlo13
 fGIxo1iwrjcFshI4tA5LRTV8bLjMwFyqJ1lUWkvSZPabSGttFWV/V2KgsoYtFTaZwwkf
 39KIWNyQrIgWIilFIcQidHdurDWBDV71zLQWqf9UrF2SB0ULr6qawsfCgPBDCUcxwixf
 jewKhJrEkUWa9lUbiznHdCy+DL9muzDFEjc2H2hciljO+nQqyXrnCaT6M0BucqryGxS6
 LD1Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792405700; x=1793010500;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ep6jt0Bun87v9aEDqV/zt65mKAH2/SAenWvsFRd7JfY=;
 b=gDQhhNzYRuN9M7iS6nAZW1cSHvp7xgvREqbxgYefG9cZWeBdCFsSKzFpMrOqLog5Mu
 k4XG7MM+2+mRtoNsYEUOMaSZ/sgEPG9GZ6e1yJOMuuUllPABozWx6Wj2GN+x/YoKbyO4
 Jzn1VAn0ucoyMusxODdpwaX9q0pjQeD6ruRjGI2U00nOvwAbJRO2q4W9phk/FL0LmFRG
 cLujKLL34QLQAKvIc4REYhPySBD4NEXX9B8xQ5rmY5o9bys78alS/A6OyiJHUJ4JOGxV
 uwfZhxtgfo2MEKrxzyp8WajYom/AY85cph9mUxsmHGl52sPiKJAfGNFT3BVE1aMk3deR
 n4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792405700; x=1793010500;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ep6jt0Bun87v9aEDqV/zt65mKAH2/SAenWvsFRd7JfY=;
 b=sWZw3WRpeegraJYKoss7YnT4tb8eBvfFu3/2/LN2VfW/WgKy1o1/89OkgnMFRZMfgQ
 RMyQA6otlkdYVfzzW3W+SYrxDjlg6af6E+ws+Xu3sNWIaN4D1nWAeHUbAmYUu7POBQ1N
 oB0pGYmo4fwgRXdjdinSperr/5yVomjThk+5rpEWjfwL7C69vSBZZC8cLy93v89LxY9C
 gFfYmKmjPjn3IcPH9qLPVsK3HajDVO1HfA3VxNFkgF8hHMHSiE7NG89Xn4VCRjUMmvN/
 +xM2R9M28nshKu8bhFQBsRSF81dqzvcwVkwZqTEWz4jtSNDmt3gnRqF8sFydfmzfPYOX
 +WSQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbsULPrcwtBQaCwqQjNY1mvbZDZKCohSuBbEBDRS0YSrp5bst/+aBQFZgSrvgTmKP0R+N3/Nw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIbm6BHvKpXqn7PDdf+ASrcanBJwGdEwS8TLGyPyIeMgQmiydFt
 RdXmU0M/YuMicOtfooweNbqmY6irB7WF3t0lJB5TAV0Q/HjCH9Os7Q7uUIae6YaaaGqzGEQr513
 DpOePFCnoNazD/rZjXd8WYIHZbZqGuRqeX7T0UTpzlHXuh6IkkoStUVtVBJ+zO5EngvKULwW/wc
 EqeyI8jtLIXGqIcfz5w3kb3dAkJEJ5TkYgTviB8GVLbFsHCg==
X-Gm-Gg: AYBFou3/r2VpiL0X71NYvTm3svwYfzRkTQzL2Pzm6HJGtnNiBHAlOXV/gh1kWHSdBGg
 NSGspFMR7wXOt8DKFcdQfhUtqnbAbThVFS7Bkzx6/3lKKlzIW+a0Vo9dmLnOFFbsHueGZXBhLZ3
 B/vPDly7NcKBQSLWTFr/vLWg1Wi5gMIOWvuliw0EN4TAIxtjbCVh3IM7kjJA==
X-Received: by 2002:a53:bd45:0:b0:679:a2c3:b2dc with SMTP id
 956f58d0204a3-679ca8db9a8mr1313420d50.92.1792405699686; 
 Mon, 19 Oct 2026 03:28:19 -0700 (PDT)
X-Received: by 2002:a53:bd45:0:b0:679:a2c3:b2dc with SMTP id
 956f58d0204a3-679ca8db9a8mr1313414d50.92.1792405699200; Mon, 19 Oct 2026
 03:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
 <20261015-test-avb-fixes-v1-6-9e5b82644359@kernel.org>
In-Reply-To: <20261015-test-avb-fixes-v1-6-9e5b82644359@kernel.org>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 12:28:06 +0200
X-Gm-Features: AclHuK_NpfRSGUYQwzpqrG4hPg1fw50zTDlpFnxnYtqC_LKFEEb_gFLFkEozasA
Message-ID: <CAPzfCAZfcB9TL9Y=6J8_iRu_4g-dTcv5OYoejo8K33fBtoRegQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] test/py: android: Add setup_android_v{4,
 2}_image subfunctions
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org,
 Jan Kehren <jan.kehren@emteria.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MSBTYWx0ZWRfX6dWnJ4SQXjua
 L80kqttwS6gdBJwS9Xi++976degD4dPsdSxc/eF+8qmmQ2HNbiCt0wk1FRrcK8jOQ+zM4p6fyK/
 7J5J/MLk17mnwbTVFJjozTkJxJJy0ZQ=
X-Proofpoint-ORIG-GUID: ksCREgRdw38c13zxWuRhQINPDIdwlQFa
X-Proofpoint-GUID: ksCREgRdw38c13zxWuRhQINPDIdwlQFa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MSBTYWx0ZWRfX2hcze7f9sZHT
 SWaqkznZYpm5t8gwTeZuQF2Gi9m3rjUhhzl+3njJH8QdGCzC3M5z+DunB61382Dt3Vy6Kvp/9og
 zOZVeBDc3T2paRrA0QzQRqEzhqi6w+bDL6QHwHX9BmcGYzHYZO0Uge6rUavlWlqxz/aa/+sFRxO
 z0SPoxpS0qR/GWOLhZnBjQommSHlQWtd7/mVKDJEGS/xwqB6jKjbavopOtZO8ALpkSwjJVhgp9P
 w/MkoU8l4CVt20HYvZGuYC0zMrwxZ7fDYZ2O6AZG4PQVXzmM0tZCnLPxkBgoYsOe68vjWIn5eE6
 yQJF+PJJU9IOqqC3h8F0swKT4xg9hIFXSJrPSYm6+23Qy1w+Vl2/lNi1VhlZuFcMD+z0J/nYPFu
 QFNZuE1NMEWU7hwWyDMqzpnx2fSF0Za6b3RcYA0AEAX3vlBHR2V8pAzeUtNvRwN2NTNvBvRfvCc
 dzxk8U++T3qySZkipdw==
X-Authority-Analysis: v=2.4 cv=K6O3jCWI c=1 sm=1 tr=0 ts=6ad5f0c4 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=iWoT85yGU-CYxeiliQAA:9 a=QEXdDO2ut3YA:10 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190041
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

Hi Mattijs,

On Thu, Oct 15, 2026 at 3:55=E2=80=AFPM Mattijs Korpershoek
<mkorpershoek@kernel.org> wrote:
>
> To split out the logic even further, do each image creation in a
> separate function.
>
> This will make it cleaner to add future images as well.
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> ---
>  test/py/tests/test_android/android_image.py | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/test/py/tests/test_android/android_image.py b/test/py/tests/=
test_android/android_image.py
> index b5fede8ebf0b..abdc6cd28744 100644
> --- a/test/py/tests/test_android/android_image.py
> +++ b/test/py/tests/test_android/android_image.py
> @@ -56,8 +56,8 @@ def create_gpt_image(ubman, mmc_dev, required_parts, im=
ages):
>      with open(fname, 'wb') as outf:
>          outf.write(disk_data)
>
> -def setup_android_image(ubman):
> -    mmc_dev =3D 7
> +def setup_android_v4_image(ubman):
> +    """Create mmc7.img: boot image v4 with vendor_boot partitions."""
>      required_parts =3D [
>          {'num': 1, 'label':'misc', 'size': '1M'},
>          {'num': 2, 'label':'boot_a', 'size': '4M'},
> @@ -69,9 +69,10 @@ def setup_android_image(ubman):
>          (2, 'bootv4.img', test_abootimg.boot_img_hex),
>          (4, 'vendor_boot.img', test_abootimg.vboot_img_hex),
>      ]
> -    create_gpt_image(ubman, mmc_dev, required_parts, images)
> +    create_gpt_image(ubman, 7, required_parts, images)
>
> -    mmc_dev =3D 8
> +def setup_android_v2_image(ubman):
> +    """Create mmc8.img: boot image v2 without vendor_boot."""
>      required_parts =3D [
>          {'num': 1, 'label':'misc', 'size': '1M'},
>          {'num': 2, 'label':'boot_a', 'size': '4M'},
> @@ -80,4 +81,9 @@ def setup_android_image(ubman):
>      images =3D [
>          (2, 'boot.img', test_abootimg.img_hex),
>      ]
> -    create_gpt_image(ubman, mmc_dev, required_parts, images)
> +    create_gpt_image(ubman, 8, required_parts, images)
> +
> +def setup_android_image(ubman):
> +    """Create disk images with Android partitions."""
> +    setup_android_v4_image(ubman)
> +    setup_android_v2_image(ubman)
>
> --
> 2.56.0
>

Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
