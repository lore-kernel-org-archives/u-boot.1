Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D42606EE99
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=l4+tI1sl;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RJRRxiku;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BTWu92Af
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 522CC40882;
	Wed,  4 Nov 2026 16:37:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8fTvlPcky1Jc; Wed,  4 Nov 2026 16:37:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7A60040819
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793810250;
	b=ekgxG4Jk5u2+Zn5Wvg4vQ/LYjKbTi57Oeqq70Z8Y5UBlNzV78bHNNHwLjdhrrwnRVALK
	 btJiykTW+OuwpH4ZACVL5xYjdRX6cGMpspJMAdV6TrX/uGp3M559mhQb1IR/Nt4m7W3vl
	 Z6HTAlWJaeQYPJvQmcd3XrOCeo3EsvnmBIjy1Jqntiw8q2gLUnftvVdpBjUzz13FbkJeZ
	 JGZwGXNsexWeGDHdWjVokVQu8O9/qo1r7mucATQnRjSN319gxKOIhvhKadPGa37n41cDb
	 +HD6Zv//3mPXWageoZA6kTCC7BgeF3QPKvqbzXOTmzMIuYeAruQpVyvgZwEqZf76sFg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793810250;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ejinpk7+V9uYlA+4LerAAnh3d7IqmM9Mevzf1FKxZQo=;
	b=Z3iz+I2ofQK0l0N1t7HydqibUB9xIHTQSAzA5y11NQyXoK2fyCzAbj3Yy0VGTLUYAG0u
	 vNgcnf8L/uO4+Oh0oLdrdcMt5/gwsg+ra+GHXhW4FC0eyLQ6OtxhDyB+l7AAPZH6L7Ye4
	 PVoQKxEd722/p4Yc32vOF+svKw6eSuDUUAHTaupEU9sCK6dtyYKJ7OEiU3unejpYhm7Qr
	 3kxpR9fLVYF+jFQbHtq930NYeuZZTPI4wDl4OYkiLA6NNYa8MrZl/qsdfPQAcutUIUe//
	 H3TiVTzLJ1w2/ao3c536KpzShfsPqNGGanSguudAyyxBp1DfByHITC03T/Mk+XjZ+9g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793810250;
	bh=ejinpk7+V9uYlA+4LerAAnh3d7IqmM9Mevzf1FKxZQo=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l4+tI1slQlm6LVATVyFzwIYNeBFF1SazjvoHGE5ICTRmshauQiJJJEFeoeVN6cXBt
	 ycgMK+CMo+osq4m5tHlbJ0UfHYUtriKt27xSGvWWAlIKW7Me1xUuAPyIK/WrEkrXNK
	 GMJOlev31naHUwvwDbD1fgvRgyyJ7WcoGYcQSI52JROMSSW7RKmf7UgTLljkIKQiXv
	 v62XUWXcqAWVy5ssGu0WEkbF6vS53bvtCFA0UMWX7ySpHT9JYtOiHzQ2KoKQiAKw6X
	 8OwmRMRQcVCHy2KM5X5HIOF2GvvS7PkCznUABwapHrkjQ3wc+Lf227Fp7lSljBJUTq
	 tfkfswGInCTBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A60040819;
	Wed,  4 Nov 2026 16:37:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E8B30341
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:04:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA7C840243
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:04:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8FKpTgRJ6PQq for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 16:04:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 42F9440176
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793808292;
 b=q2vHEI6or8UTkxLY+MNNt/x2MbfizbGp2szs5GuP4cbKCa4elJ63fWCRGpJxAPwyHqyi
 DGNXE9BxL4Bw//ZjH9AAt/ftTwZdwgU6EWRZUgpWStFzjGy5EndTTSseDiBCqFVabkQiJ
 W/1sawHB4KOQ00cujmhhTaf/DoVcNTe4eJ8ySwXZIZf8knpwEmy4ilaAb9dtkjp0LTfcG
 BJ6tsdaT8gU/TNHLjifBuFPDGrdJqTHXrtNXj57xZoI0T/y4TIFnzLSJTtUQXpx3eZF+E
 h9Jsd+W5SFKM0AyI5xemBVv7gjhmkloIaxZjgGNDsFXOsORljSSRqzCzSbF9DM/6ZOQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793808292;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=ejinpk7+V9uYlA+4LerAAnh3d7IqmM9Mevzf1FKxZQo=;
 b=i5ljtcqUOvRBi02tM/5cE1ORjvLMbg/y3+Buvg9k/hvCwGmFWPvbMo2Q9NsQN/ZY0LQX
 Nr1C28ygZDn4SpFYmmbJd5G8FtYCBGKEUjExFn8IQF7hT0P0OmyFoKHTLbXPHGtLTIZqe
 W6i6LC5+T+gp7Asb+0ZdjhLyub4hMAUZy1RkWiNEJ09NKsh4W70njS7YJXQO0ovkfEFi0
 +7HhrJSG2L1l8HUkTIGxU3PQt72ifINEKs56RoD3I7SntQ6sR1tX1/1i2Uj6s8QKktN0t
 xC4ihsoaliZp/SiJust9eDcEr6o83GSPEhO9mrrnnnfYZcx/Nmtw/BtehTN5UrKnrrg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=RJRRxiku; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=BTWu92Af; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=kr.sowmiya@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=RJRRxiku; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=BTWu92Af
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 42F9440176
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:04:51 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4Finm53272803
 for <u-boot@lists.u-boot-project.org>; Wed, 4 Nov 2026 16:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ejinpk7+V9u
 YlA+4LerAAnh3d7IqmM9Mevzf1FKxZQo=; b=RJRRxikuTZ3fnGPI/tbwMr0//ly
 Jc//pCX+P5yRweRZFhqTtxho7jSxCKKavfgm/SKlgEfoVVKbHp50QmlAbWYiTSaR
 KYBIjDbQE0BWc03sE7SSD5DBIcECQBnJC6PwUWzTMPtsiFHaridAi1w7U2ZmYw/b
 SbEvelnMT4FglitZAv/tSbiOqodabfgtnlk8WRvWZOOqM6pv9dVr2Lz5ayD/x9Kb
 qCItub1FQxhc7SNx1IvH1lTWWWBS22ooSZw4dOcfUOcUt0oq6GvG7T01uIbQOaUJ
 MTNUFIowPryc+8SJMwpXc7BHOjTeYT5/1POt9YMGiMsQHQGe8NqYTr3NJnA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6bngdk7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 16:04:51 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso1575675eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 08:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793808290; x=1794413090;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ejinpk7+V9uYlA+4LerAAnh3d7IqmM9Mevzf1FKxZQo=;
 b=BTWu92AfGLOyxjf+i4SpzA6ByzKg3yHUFlN3JNUPQHDwlr3MVay5955ZN9sm7MfZ3D
 wSDuy1/JvhJSbWtzr6riD9bivdBKaJhalu7Atc847yF6gz0nHjqivBIT+OAxS/snq0aC
 Q5aiB2AQKQFjDji/pFzE9WuynUDhZEcqav0Uwg+XW1nIMHyi1DKEUXF04H9R9zS+c8XQ
 XuGxTjgBWkhUEOvpNqlTbyG+BoMgrvIkX963KgRPumQPB2Kr6VWK0XYi+3li0BTXUq2u
 mst77LWidfSONaBGugbEhpfo2ECqhcinH7D7qQF+UbRrNp5n+ojo+QnaOGV8yOW5imzj
 QQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793808290; x=1794413090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ejinpk7+V9uYlA+4LerAAnh3d7IqmM9Mevzf1FKxZQo=;
 b=q3UJdvCATZPU61BZbmModF/KiK6HlNHsRw5pXSi+yH7LvM+x7TzU1K8JuUZwzGrukq
 RBwZa0tA8gT4Xb1gwpVWauVqou+rOB6eRBmdl9T7f+3Y/yQSXtmV3+2Z/ei90ALwj94q
 sL0d9WGo16SYKThTLHTVt8EbfTkouGVA8cPl5va+nfQ9zaWvUb7rtewzYz/xVeY6stNK
 NToAglC0OzTVdr/jGRn0TeC6dzp8TXearPS85DfHxfkmoDe1dby6o4161thxfb+6oIrh
 V6qDqrF6tLBMZ5wRzrx1Mroe5pETh64YG6xD4dSo8TpcuD62H7AncAize2VX9cyHgQsG
 zROQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwT6BbNA1nl6dV7C4hZnWgDb+GngEXwIAu5Ymfw/jdhbQW5Z3KUZBfC1rFxSFAIL1Z0o+/K8Og=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/0S6HIRlFSHhYsXGh5R1p01xwAISwXG+Rmot82S1Nz6gYC0CsB
 GR8btfiz2nHIkI79Z+3n07spSThXKbE/JytJTa/WJdSMCU3OKfvZmK4f16GIMAO6XbfZ2eIefZI
 P6uxP6kpMOxGt6s+6N9RGh5sK+IPy97fMvnoGLGiYHGHCR/EY3rlIFbM0+F6T+kVJUxYxbSY=
X-Gm-Gg: AYBFou0bnEbnYWDl8EikXTqj0Xo5O/+JqIAObi5XGExzSn4La3zOhDbw7Bx/YwmTaZ8
 2mBvtzzwbMUuQwnAJCHc2WuzvaSf4LSho/7cC99Lz4NJdCUkpugPZUb+bIo9AaDqR9A0PmRy5d4
 Wl8SVZAB7/qbod0gQCKynD2EgGU55iRFj19cpW7rqbJSqZEzoRDTf02UTZKmM+CteakzT1lkujS
 ZEemD+sv/W3rNXd3x3G3CSotVS1LOFENVfQmNef/CO0WIM3PkBwwtEkxJqEcP5w4HzFrYfd7qXP
 +RFmJ3/jSVn0WIOvPdyTwz6r775bVHjUXzEXFeyflINlgkxaWOretzudtQAQjRe/Jrs0xrKCbxC
 GbPT3Xx8jSBwrBikHSrqyPzR4txEx2/iKHm9cboBeJS6Ypdm4EVynGYsMCDHp8cyfH60h+H2vz8
 ki5lQfNqFFOH6qx8HnZPghIjUZbqzcj7QU8YuEDTC4fIa8sB6giOH685oe36IYGFwOVg==
X-Received: by 2002:a05:7022:eb53:20b0:168:6ad8:e8c6 with SMTP id
 a92af1059eb24-1ac5d88c9c9mr25478916c88.15.1793808290160; 
 Wed, 04 Nov 2026 08:04:50 -0800 (PST)
X-Received: by 2002:a05:7022:eb53:20b0:168:6ad8:e8c6 with SMTP id
 a92af1059eb24-1ac5d88c9c9mr25478859c88.15.1793808289454; 
 Wed, 04 Nov 2026 08:04:49 -0800 (PST)
Received: from hu-ksowmiya-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245c4706bsm10882667c88.15.2026.11.04.08.04.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:04:49 -0800 (PST)
From: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, sjg@chromium.org,
 msp@baylibre.com, kr.sowmiya@oss.qualcomm.com,
 abhilash.v@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 vincent.stehle@arm.com, daniel@makrotopia.org, francesco@valla.it,
 anton@binarly.io, aristo.chen@canonical.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 6/6] Nord: enable MBN generation
Date: Wed,  4 Nov 2026 21:33:58 +0530
Message-ID: <20261104160358.1131694-7-kr.sowmiya@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104160358.1131694-1-kr.sowmiya@oss.qualcomm.com>
References: <20261104160358.1131694-1-kr.sowmiya@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NCBTYWx0ZWRfX/eJxqNn2NYAb
 vb2UN8tmkcHNCsUb8jr415pDID5jeBKWr4miJMoo0UWLG3N2w1Y/wORk2vk1gILe42Bo0t2h8vW
 4Y1Di6H9QpxbkfwtiLo0HWeSnV1z4AqFxBK0U/FDxDnr2Zpmb0QEQKH8OVek0fBz7Sq5hs7iYsl
 /LLNvS3VptNHnD38Iq/0Xi6bCEIT/ZzXHpLQbA9gKbDzEhID/lc6ix2nDvgrWZRQ15WNxuFcjgl
 n14WmH4IxriPEiVPGKqkJl3gX0BTs3Fdk1mJY1BvznfKP1CJeqBAnp3tztZc9fIV1h73stqbTNp
 nppFyCpPmdC5208OCDDGVOAFttr9OmHWcBcrx8r8oK/Ul9a19iCTLuSo82X9XG116YSeHm56CHe
 jPLd/H/r8PezrQNDWLztLSgoXH0hsXxUiY0Mu/PTz7j2gW3RmxCJPS4TrbdYyP13Poo/+dNYOxD
 1nGTMPQ25aJYqGcHlEw==
X-Authority-Analysis: v=2.4 cv=KLLPn1Fo c=1 sm=1 tr=0 ts=6aeb57a3 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=NGLv4p976p_-5zti-BAA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: SCXF78MuA03FoEf-7C6qTi7nh6uqe5SO
X-Proofpoint-GUID: SCXF78MuA03FoEf-7C6qTi7nh6uqe5SO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NCBTYWx0ZWRfX4oK0ompOZfyq
 BdwVaDURFo37KtpkpqkuCq2IHwTajt1iQdVnNOSzXgDbDAEIPnySfwyLayKiMqkdG7fia9/WXHr
 UkrTfUvA7p0M7ONc+AV/D5i5fwX07iI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040064
X-Mailman-Approved-At: Wed, 04 Nov 2026 16:37:17 +0000
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

MBN generation is enabled for Nord SPL, so wrap lds file
is not required.

Signed-off-by: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
---
 board/qualcomm/nord/nord-spl-wrap-elf.lds | 19 -------------------
 1 file changed, 19 deletions(-)
 delete mode 100644 board/qualcomm/nord/nord-spl-wrap-elf.lds

diff --git a/board/qualcomm/nord/nord-spl-wrap-elf.lds b/board/qualcomm/nord/nord-spl-wrap-elf.lds
deleted file mode 100644
index 74cc9e482b6..00000000000
--- a/board/qualcomm/nord/nord-spl-wrap-elf.lds
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * SPDX-License-Identifier: GPL-2.0
- * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
- */
-
-OUTPUT_FORMAT("default")
-ENTRY(CONFIG_PLATFORM_ELFENTRY)
-
-PHDRS {
-	ptype PT_LOAD FLAGS(0x7);
-}
-
-SECTIONS {
-	. = CONFIG_PLATFORM_ELFENTRY;
-	.data : {
-		*(.data*)
-		. = ALIGN(0x1000);
-	} :ptype
-}
\ No newline at end of file
-- 
2.43.0

