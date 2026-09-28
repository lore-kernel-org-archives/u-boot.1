Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF80AC9833E
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 10:28:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 166596068D;
	Mon, 28 Sep 2026 10:28:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id plzVQgnlL-TL; Mon, 28 Sep 2026 10:28:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2D0C260672
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790591321;
	b=Dl/JTazPds8650bsDNZ678w85rXJMxUcoC1YQYZXz5r3epS9kpNvDsxq2DQyHfJaN4WG
	 5iiv9CJGWE5IF0y8X/zrevDbbIjjGBPlmLS4VuXLroM6xuVTMJWpMCaw3iwMZLsdLTK1T
	 vN0CwJaWCywffUyn2Ws1Z2IbweOaLB9pO4iXbE11xqmRdGk67OjjD2dyg69bcWbclVKt4
	 1B8E6K9fGkBf+iB63R2sq3wqJX4hKJYOQrpgEA2SKryftpqMN0FoJMsS3OCgeVy7l59U+
	 O2iXfPw0OT9Bdmi/nTvPddFnSSqqe704KLNrG+EML/50IbLx2YHvZ7q/GIrOdRiHZWg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790591321;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nh+peGbYd28wbiMGAqTMRPsn1LC5beTwKNy/03XxZ6c=;
	b=qQuOaYeww8yVIU0DvvkrHXc0VZ+ciQa77uQs7ATUXcHloDX7IO7FSNdiINxeSXJaFOxM
	 0UInqB3DSv7b8xX/r6gp2MrATNJrqriySWU40jPEBLoFgWLbL1sx7jeAYHyWaIeBFmMbs
	 ryXeNgutRAUyHlhtruf8NxeYZLOslk1RAqtG9aH7GmFVGTlIUS+1IjgVd+nTM6OrRv6wh
	 20EaVIfjD3eT4mYtaNhoU1HF1N0YMhwT/qYBc7jnVFwZ4QAoZ6NAMBaSuZaz2NLO/YxrQ
	 cEDrusKY5Ka4v1MTYDqS4idKDNnMJlPqoi9A0lwBlJN0LVou/3MXKh3tCLarN+1to2w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790591321;
	bh=nh+peGbYd28wbiMGAqTMRPsn1LC5beTwKNy/03XxZ6c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k+4BZi5W9x08c6ghnbc2sFWYzEinDpMQuJZZDWWTJwRp9Q6T8V7UwUuhArK0JwuXw
	 dOy7N7NJw4qr9c5dCc846nW+sMMFiztsyWL7wx6lmw2ZwrkQyY6cFU1uEugnFI3x1i
	 FLVxQqfZeSBKO0cwkec2JKARFU1JI5e4hWoTbrtzYBlFm4MXJu7nPRzmLCjczhSxyO
	 z0bqyK0vWyH2pkZTnYMTqztDCeLBy2nA3I+rwdQYzuov/U9ffSipUEhH4gU8SrFA23
	 QoYVSoS3v3M4k8yBpikKbrzuAR+1ekhU27AaiYfVC4FmIOHSYsQTLyUExxPdnp75L9
	 rmB39PfguNyvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D0C260672;
	Mon, 28 Sep 2026 10:28:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 88B26361
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:28:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A94480D89
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:28:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yXcEMIE8FIjY for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 10:28:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8F52E80D3F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790591318;
 b=s3ni3Ujo6NguYvF8M2W6oJdDMj84d4U/Kol71jzw5qzb42SjPFmge3YmCbQ6y3UGD6xd
 zh1ukSf7LspOlF5ADCIKFQPisE6sOhJLnCzCUDo32El9+Lql8hgYmY/hrt6Mat3K0RaXW
 86sooWliUmTSrKuVebJShKaCLNuFKhlu1CdIAiaV/NR24HXV41wI3Ca4HO8uZBdQSn0jj
 /ITR/Nd9iarGtKklxu8lVG8MoyknvllDmskEbtuD6Sdl9bgqU14Q+6QdC3HZL8hM3KkFW
 PokqHD0fnRAVXbCUvedDVuj8k8HbGP9MscCTXt5cKSm77sHKqPtfdDTGSPy37JrMd+w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790591318;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=nh+peGbYd28wbiMGAqTMRPsn1LC5beTwKNy/03XxZ6c=;
 b=gy9jx4IQlLP0Nxx4rjvtbQJBEWHzBHt1fMxdCHVKKvL2hIu1hTwE8Ox6OVhDyBwcfpTR
 QO3ic0aRdwkOf6WH0RK8AWUHCkhTOIeswBhxvzwVL3zIavS2L9OgDnY8tn7LZ6vlvxtCe
 bcXJmiUwv6UVqmavSERfZDpNJ/rnP88Ep1emUztHnHwm6t9K5sISquHaShF0NKbv/JPZE
 GdxgZOJpTPo2gjO5ASTFVp8qbwFnMfZXx0UCRCS1fGC2g3uBM/4BVc1r+Yx83D/lh7dy2
 9o03QUpNFqK6j8hKNMOsT9plMRbwIhG6ER2Eul10Iss88jjphLkHOtWYKMn4eMuOEtQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=JJr4CSI+; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=SlvyTBov; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=JJr4CSI+; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=SlvyTBov
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8F52E80D3F
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:28:38 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9M7pB1212450
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nh+peGbYd28wbiMGAqTMRPsn1LC5beTwKNy/03XxZ6c=; b=JJr4CSI+OCTCWZ9v
 Nu/S8Swy+cTwGjhQhu34xHzy5wsRbP/sQzm3wQR4ZAZD9xHu18XBsV3CIpzuPiQQ
 nQGA+N13fLlZ8oiYfayLRnijXPTro5sGpJOhQ0zXfZLa3yHp7MDUeqpGO4tBX0+d
 w4RS9a4VGnYFgs1r/ZGvinYYTrZ02TwPkx7o3eZ1s8+1ovRgcmuVcAgYOHcJjfEB
 M71GBHuAIq4Th1iGlAUTEh2YqenSmxEUZj4OOraO8XZGPHyeAtv9mFWiy4Djfnam
 PUeFQFy5+xluTJdlRr6UMdYn3A3ofmEeVsVe8YNNXPM0aIXKl1aPEw6UXhuEruWu
 gWJh3w==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyjkxh03s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:28:36 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-14318be7d79so2946446c88.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 03:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790591316; x=1791196116;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nh+peGbYd28wbiMGAqTMRPsn1LC5beTwKNy/03XxZ6c=;
 b=SlvyTBovvfT6H5Lvolo3gcelueJ8mBtYJCCpT/oJLPQouVV6RX887ek0jf2fERXY08
 WaHzffvAGjI6DYjaZwzotc0N4/NTIh/HHqOkRbA5gl33zAbKkekJO+w/xksujTJV85af
 t6RlklXDXrHbUdQLKF/2GJsbNA9pM1vl8d+Q3wcXtjHpYlBJ3ifm4Pk0PxQllWI+eg5V
 p4/Xjn+ZweG80AkgfsqcqdTh9vHuVz9SueDDoxESetTX8u05LjmsiG0unjScvkFv3h75
 BEy3vvOAHSDaxabs/JB1W/XkxUc3lNjhXKFE8eYdqjtmwvF+gC+KekISzxozp26kqEl/
 Jk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790591316; x=1791196116;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nh+peGbYd28wbiMGAqTMRPsn1LC5beTwKNy/03XxZ6c=;
 b=A1XebSoIwYmooFJQV7sjhjPUKPtZ0kq/s7g75AKKDx6JTD1cFkOWREMbsl1zAGBlOZ
 +dg6lXoyAfRTzQCjSlzwgwn7Xn6HaXlwGCm8IXkWtqGym9EBv2OPs0YVyY2EIZ4OAQ2X
 vg3ao7mQqI9RxphxqxnvBzXwV/KfzgSuz8bJ7qP/9YVeRvICdE2M1s4PaLMwqxGw3MxR
 3iLkxQfzj7l+AyxJ1rYy9Q39FTP8yIgdg6hWr01Aj1syknM5dI5ukbuwy79MX1J6Hf8t
 0Hyc3ZqzbUGSEfN2+nOffA3VDON+dZCkgjGtqYdoOwQY8ZrgC3QWO5U7alutPou42jP1
 iOUQ==
X-Gm-Message-State: AFuF++k8M5gL757EijaPW15XKVg0LwzQa3jGHJf/J6TVjI61Dac7J8+X
 iomTWw9uLhMMgSkFK346rcMUjxQWnLxAU2SQnNzIU5Be41WdpqTx4C7AU8RdoPzNzqh8oti7GId
 VQwOTh1muta0XV0AewCnp/5//ACUd0R8wbNlHqTWdJBli07xdhg1v7DQ6cBzRijDTVKNhzQc=
X-Gm-Gg: AYBFou2LJ4uhhpUrSIOGQgFJ9LHux+Vs/moBpGB1nilfvZzlXn60wYyDMfiR/iImny7
 IfFC8i3cFxIYjJf8IRaNJVT4CTlpSPKvzuisx824vDZJwhCVQXvEoQeB1bnsYBBtFdgjfIdjb5P
 BwFhJBNUrYtUUY7/VkMZPPiPlnuCROCkS0KsDuWGg2gZBTtrhT/0wccuhBwp/QTuXXXz3mU7Hyd
 E5NNWjnfE3oSYBKzFe422ie9yJnui8KL9Qvn5QguUqQnaON29iRY3+rN3m0hvuo6IhzWTcgCHfP
 /QvYh5LXqDLtAf+HCCjK5EscKnhqWZ+E0EJ5qRVhAWM8ldj92uxIt3M90K0yH4N4yZNPKTlYEDi
 jxetWJMCIej2PWs8RxS9mWjtQmgxy6IloRQaapBKgjhmvj2EDhLl9rjXky7wCJUvrbRfbORbi1+
 JO0Hhd7W1fFejAffhhKfkO8e2xKb4N
X-Received: by 2002:a05:701b:2713:b0:149:c766:3629 with SMTP id
 a92af1059eb24-149c76636a6mr2581424c88.23.1790591315702; 
 Mon, 28 Sep 2026 03:28:35 -0700 (PDT)
X-Received: by 2002:a05:701b:2713:b0:149:c766:3629 with SMTP id
 a92af1059eb24-149c76636a6mr2581402c88.23.1790591315076; 
 Mon, 28 Sep 2026 03:28:35 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145acd3d8eesm23015091c88.8.2026.09.28.03.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 03:28:34 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 15:58:15 +0530
Subject: [PATCH v4 2/3] board: qualcomm: lemans: add SPL support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-spl-lemans-v4-2-007635cc4667@oss.qualcomm.com>
References: <20260928-spl-lemans-v4-0-007635cc4667@oss.qualcomm.com>
In-Reply-To: <20260928-spl-lemans-v4-0-007635cc4667@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790591300; l=3706;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=uL9829iu1Sowg7vKPlObXA1MGhxM7+CD9a7R3Dy0m+g=;
 b=XOrptPy3gPqMPnpNemcMxvax6P3uif/8b43BmqMWVYw5i7kI3MDHLHwabg97MknfC5Ol7YTV3
 q2PWJQH4TSRDelAFa34bAdRUZa6iuVxHiJQ7Jd5RoAGysdKY1LtlZ9Y
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: hcX1-TQpS1P6jDkyxUi8F45ASuFVfGv-
X-Proofpoint-ORIG-GUID: hcX1-TQpS1P6jDkyxUi8F45ASuFVfGv-
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0MSBTYWx0ZWRfX25j5C8rQYXVq
 igHsWeMlHehUgHyVaRNEuNVp2mz71RPOgkvggqMzzBCOtVbXfkkTl8VjThUq5U6x0U1xcIzm4uo
 /5DBhBChRqq8iI9iDA01pqOdDfKLO48=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0MSBTYWx0ZWRfXxbRebK9pbhgV
 cpXNYIOYA/IVCYmR/x5Co49xdD5XMggy3T5SJuCEFb43VDlXPOganR1PvUTQf4+hLdEO/zrAhkN
 D3gsyOTEczKozj+u8lBDPix/C2laMPfhqfi347D8VlkxoxLyK3IbACkxXF2fR47O87t5roijFkC
 /4iVuJ9ZT506Bx6FOABZ1Udgku5uEqf4uUimLe5WSwWhPla++5NlDA13l84rONCSFx6TVHwW+Q8
 aaOLr/S+XCfG1CJU2TAHwWiQI1FzGOzmjH+8eDtkVCPZZ7aCCFpwGnDz6Tv8tFeTQGz/WcV0zgG
 8CmEnQ5bUkV8xEhX3uWH3DhU/hTMv9JTIg1c/hJnWEUqZAM5K7uAaq0dyFc7pRCQrsFffADa1w+
 aiWYFOJqhJurd+Tmjj6X0Vsl7f89v48sgqdsKWiSyPlFphr5pa7ILqDA8Brrth0V0kLYMGblhc/
 BRtZODHtULWJW/gHnBA==
X-Authority-Analysis: v=2.4 cv=QZfzLcbv c=1 sm=1 tr=0 ts=6aba4154 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=dbnLsFstSkEHw6BWF9QA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280041
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

In Lemans EVK's SPL based boot flow, it boots PBL -> XBL -> U-Boot SPL.
XBL brings up DDR before handing control to SPL which loads the
TFA-OPTEE-U-Boot proper FIT image and hands control to TFA.

Add board/qualcomm/lemans/spl-lemans.c with strong overrides for
board_init_f() and spl_boot_device():

- board_init_f() mirrors the generic mach-snapdragon flow but skips
  the pre-DDR image load and QCLIB invocation, since DDR is already
  initialised by XBL.
- spl_boot_device() always returns BOOT_DEVICE_UFS, since XBL loads
  U-Boot SPL from the UFS "uefi_a" partition and leaves no PBL shared
  data to parse.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- Rework SPL support on top of the new mach-snapdragon SPL architecture
  (board_spl.c, fit-handler.c, qclib.c, pbl-shared-data.c), which
  replaced the single monolithic arch/arm/mach-snapdragon/spl.c and its
  SPL_QCOM_BOOT_FROM_PBL Kconfig option this series previously used.
  Lemans now provides board_init_f() and spl_boot_device() as strong
  overrides of the __weak extension points the new architecture
  exposes.
---
 board/qualcomm/lemans/Makefile     |  2 ++
 board/qualcomm/lemans/spl-lemans.c | 64 ++++++++++++++++++++++++++++++++++++++
 include/configs/lemans.h           | 11 +++++++
 3 files changed, 77 insertions(+)

diff --git a/board/qualcomm/lemans/Makefile b/board/qualcomm/lemans/Makefile
new file mode 100644
index 00000000000..2a908f948ee
--- /dev/null
+++ b/board/qualcomm/lemans/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_SPL) := spl-lemans.o
diff --git a/board/qualcomm/lemans/spl-lemans.c b/board/qualcomm/lemans/spl-lemans.c
new file mode 100644
index 00000000000..0556028248b
--- /dev/null
+++ b/board/qualcomm/lemans/spl-lemans.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SPL support for the Qualcomm Lemans EVK.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <asm/sections.h>
+#include <cpu_func.h>
+#include <hang.h>
+#include <init.h>
+#include <spl.h>
+#include <mach/spl.h>
+
+#if defined(CONFIG_SPL_BUILD)
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/**
+ * board_init_f() - SPL entry point for Lemans EVK.
+ * @dummy:	Unused.
+ *
+ * DDR is already initialised by XBL, so unlike the generic mach-snapdragon
+ * board_init_f() this skips qcom_spl_loader_pre_ddr() and
+ * qcom_spl_invoke_qclib() and proceeds straight to board_init_r().
+ */
+void board_init_f(ulong dummy)
+{
+	int ret;
+
+	memset(__bss_start, 0, __bss_end - __bss_start);
+
+	qcom_spl_malloc_init_f();
+
+	ret = spl_early_init();
+	if (ret) {
+		pr_debug("spl_early_init() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	preloader_console_init();
+
+	board_init_r(NULL, 0);
+
+	return;
+
+fail:
+	reset_cpu();
+}
+
+/**
+ * spl_boot_device() - Determine the SPL boot device for Lemans EVK.
+ *
+ * XBL loads U-Boot SPL from the UFS "uefi_a" partition and leaves no valid PBL
+ * shared data in r0, so the boot device is always UFS.
+ *
+ * Return: BOOT_DEVICE_UFS.
+ */
+u32 spl_boot_device(void)
+{
+	return BOOT_DEVICE_UFS;
+}
+
+#endif /* CONFIG_SPL_BUILD */
diff --git a/include/configs/lemans.h b/include/configs/lemans.h
new file mode 100644
index 00000000000..b9e81fa26ac
--- /dev/null
+++ b/include/configs/lemans.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __CONFIGS_LEMANS_H
+#define __CONFIGS_LEMANS_H
+
+#include <linux/sizes.h>
+
+#endif

-- 
2.34.1

