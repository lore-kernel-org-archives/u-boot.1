Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95E6606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 09:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zt8TriYi;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ftqgifgY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MTLvDP/r
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 86D5A4091D;
	Fri, 23 Oct 2026 09:47:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zwvrdu9-JeBC; Fri, 23 Oct 2026 09:47:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C6B6F40943
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792748863;
	b=SrSbYa7/C9+akMDdAQoqyINpENb0XZ+/02vLQXfflYwTyw05i7cJkvg4I42AOnsjwK5Z
	 Rfwu01koEE2Ine+dWt6evVi9QGA96v60nL4mmusne1Br68LS28uVbHcGFEY5UNKkC3Xtk
	 Mne2E/yZWY3MynBw+2A6J7VQAEnoVGdpGRqMrReuQmMijhrA7nUU3ebGjVCvrKofVokjX
	 6QKMjy5Apx05pgF1IM0kizDz0XIHfOVei93efCD/mBtKYGZPS5rY/94gCflcVbikDEu2W
	 rEWZGOkZQZiMlAqVHufsq5xhSFgttxBmUCvVromtBIDcDgnaXMniGXUz/9pifvnDqdQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792748863;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZDm+wr+h4eTEFntVApZiEURZ16Ij4xBeb8eI1wFdpBs=;
	b=neMNb50HD+dLfenYbgF4THqW4o+hu4LqNB8FGRt1f5e2TAUrMQes2nsKrq8B7Yg1svCQ
	 6jf/5nAuW8j6cp6TxJTAyc5tvITsKxz+VtZm/qp5nB0VJEc+n7kKj7SpD7fqTg1lirFzM
	 b6YciytM/QBObBkD1AzZB2TsE4Ky7km4K6XivZAdjDXfKYmbL99eMnaIIhojqCGhSFlEd
	 jg1ZzpIOInphnKiLN/H1Tjp3DVsZZkt8oA4ynpdAD+eJafmfJG4gUeTgR/I+5AaULM/2b
	 2HsuLVVv9jmGKkXtxIiN2Sz8ryZ2zPEjLmVOlJUsRAP1+fKhGXvmfm2nqWbIOecYrSQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792748862;
	bh=ZDm+wr+h4eTEFntVApZiEURZ16Ij4xBeb8eI1wFdpBs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zt8TriYiIlH+RQAK9jt6Y9CCSxMrWU5JIUQPN45FIP3gxRZCewQKneUQkH3fT60Jc
	 m6RrzOXLg6laC4PcYUFhYQXXxCp3lWxCfLSK0kWzDjcEsj/Sn6iQtTburtB6dex4eB
	 qowH9iBMh6tP/ZlpJiHDnDRObM3lGLgZALWzhmarYMehCIx4VGhCAbaF7e8dUYPXba
	 4833+7rMLyOYe1fhZT2RilyA2KLontmbT7GOGnSKYNawT8Iqt3odh4ctCotCPnYMHn
	 d346H17zwJYk0eMrtacVtXiWGy9xaRTP4HxhzVSdgOpo2Eigw0XmvHPQ3cASU88emm
	 Ml01h+1tu8hAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6B6F40943;
	Fri, 23 Oct 2026 09:47:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 52F8012C
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:47:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 50BA840099
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:47:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sYGYvmbEUQaI for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 09:47:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 84A2E4008A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792748860;
 b=YflcVVFPfPu+9yLXLXcN7z25Du+q3x5FmTxvO591KNyz2X1kW7Jn42sq/YgFOz6cF6Ja
 hX3HEL7hssligeSbNR4QDwMRJYnCIaCU8/BC0gteMcIZBOzBS+ZV+H3REvpbjmJNKyu4T
 9IzhvbggsUj+8DQcAHNbAfW3I/7gU1xsx9Ne1U/wYJj7OkapqlfHJj6+Y7BFz06YkHmUI
 84J4KQqU4UtpiLBM756JjYNzKqPImv7Rz5qm6941VRI83hhxGm/l6h84PkH8/kjONL1Fx
 jgxYeJyKE4coxa9NWUNoGzNUpGGkzlJw20uHJMoASALPO75lzHlZ/Xzy1d3mv5Hxc3A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792748860;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=ZDm+wr+h4eTEFntVApZiEURZ16Ij4xBeb8eI1wFdpBs=;
 b=hg+pHS9sIWmmbT/dAhMNRzOj5E4+mOU3NPNmx+310+6xvt/3a3rmwt6AMYLodUy5odpX
 uWCVUCiaEeSnYSvbk7alvmqkG0NZF7V+q7lESLwrCU+ccMEVRUhQSe6HJWFQziIQb0Xvm
 Qdn14FIeRxuhzk2of5/TB2UifojGkkHWhlQY2zr8+QllzQk40SV0itWeyVc8P9irRfYJ0
 xephKOowz4mwd0z70DTnlb1g3qjFbU3wZepwcO/A7WMhyUohJqI3+fKR16TrU1A7yRkzS
 3V5v/xW4s8lPnQt/+38qjOB9dqFi5eKOBXcGd4tPsj5jmXcoiMyAUogmZQ0VTdaW0Bw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ftqgifgY; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="MTLvDP/r"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=ftqgifgY; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=MTLvDP/r
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 84A2E4008A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:47:39 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N7FAKW2092783
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:47:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZDm+wr+h4eTEFntVApZiEURZ16Ij4xBeb8eI1wFdpBs=; b=ftqgifgYyya2yr9D
 z4mZz2yrmcHbzjCF//zPDMOAmxdCo6A8nHeP0gg7JEvAuSgoKJz93mWcCwDtiQhl
 CUdiB5lZbfVd4Nr57/jhBEHVLTi4PeVof06uVmFT4zlqlgUNHEshcMjQCqZRsCAX
 WA8nv+oecNnbtuqBAi+losv8v4Fc+SmkLw7OyWozdlnL72urUJ54v5kHlHAzGLzk
 9VvezZ7TQ4bPZpd9LDkyYFJYuTE9Jn/qAdc58WPalToy0NzkVGbua5BTYm8H8X3o
 XRRtlF+j3jBaAuChJz/n5ArccX3b68d03XUI2ftVBeSt0U1RVNOYVbKjDra6QnYf
 8PQh+A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hftyga8vd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:47:38 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3698bd5392cso563817eec.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 02:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792748858; x=1793353658;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZDm+wr+h4eTEFntVApZiEURZ16Ij4xBeb8eI1wFdpBs=;
 b=MTLvDP/rz+TISlql4FX8NsSi8nd4YX7iu+gIeQ+b7Ioc7sgkwWc0veT9Ag87tg2TMP
 32Vu5vzxLCe1EpS6mkFsf7f3MmbYxpLgtRwSbf8UGe7nArVZGkfs5Kgp4lXb1OfXYw5E
 RhfK9gTAR+LXUYkmGolvbIRNvjSe+Q5IicznnHMPtvWeUX6PHNLckjTPpmJWXdDstm8t
 Mk+otWczskLU6SuSFgNZVlV7YnUQsIjuYctCXQSnL3sqecQchz67BSQmTgRUcY9qSkBr
 h15SWajq7Huzi46ck5x2kxVk48yzKduJt2L3NQJ1W3L3s9JkIZcdEr7wbtX8Gx/VfffG
 I77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792748858; x=1793353658;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZDm+wr+h4eTEFntVApZiEURZ16Ij4xBeb8eI1wFdpBs=;
 b=jUIzf/K4hr8BOiB8qvHk7e/brVrFbRYX7pUv49pjrqYXtBuYKKXpAP0N1GzmJaruiW
 FsrapsxoRPoI0hygROr7bVmn2BczLkFRql3b4Dhapawg4jQxNl/IaHfuBi6xy6XQjk9J
 CktdQBqJVA8Dhii1DdLhKHqUB74z2RA6Xdjj51HKcfDc7Y+QA17mUFT7cK3a7XA5gElh
 R6pKj3bJwUuEExkXE0Wg7m5abN+88NTt/+aYx8BUjd2IfRBfgsha4uuVcAb0ez+PFAxB
 FkZr4YctOUuw8Tf/+ssioe4Z5BJWdWGqGKfokG7TMWv3QgGPTIRkoja/AANhhc+oncQi
 L/XQ==
X-Gm-Message-State: AFq9FYIcTMNru5NVvWuXDxe/955IXgweybO3kO8RGiEnDcogygnzGnKY
 sjng9rrHVUYUQ7PIhxH6O7nT7msftlbgcLh/VBHtBWU7EPPt94oue1Pt2kjulFbqfWgd2VhGHTV
 CphGryQpWq7qjKrQihOweWZsZ6dYMnhb82PmAPkIN7FzXW65KsAU1lk2SIK0zVl1p8f3HZA8=
X-Gm-Gg: AYBFou1pTzJj6Ank7o3IiAvpnqx++kNdvRvsw69czUrcscY4JanIOq06sSIvLWm9FYW
 I3RIPAv51HV2uY6bIA4GQpr32gKb0NzaR1ckZHnZz0Z2J5D/FkF9eUUuN2pialPbKqT7IWp7GcO
 RaEhM4c6zniLQVzKUOByg6v9R0HLWUb1gKrB1VbA0MtaptF7kE1ToOJIrB6N2YF/gi8BEBDTdh5
 krmxp7QM+RCV4gnusrDuCDNLvlhrAKVNrD4AZVHRipl68lryMZhBaGapH5c7za1Ra/gcAZ6NeoU
 NHg7NB5bkjX7qVOFhF/kEenSRFgSa1fsW303lqfgfhJthlRb3zq3yxFdAYvFg2CChdCZfUym81u
 d5kFgQWYeKgn45FnT2xgO6RWBFhrotwFtfcB1jNATjTDm9y42p3e62k2/oVJZiNx930EI3c5ZnW
 HytaqdOLO7nH7K+KNupr9cEWTwOAsG103et12AWOg=
X-Received: by 2002:a05:7301:7e17:b0:366:6c79:212b with SMTP id
 5a478bee46e88-368b122ff22mr5689914eec.25.1792748857477; 
 Fri, 23 Oct 2026 02:47:37 -0700 (PDT)
X-Received: by 2002:a05:7301:7e17:b0:366:6c79:212b with SMTP id
 5a478bee46e88-368b122ff22mr5689877eec.25.1792748856737; 
 Fri, 23 Oct 2026 02:47:36 -0700 (PDT)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9d892b1sm6071291eec.10.2026.10.23.02.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 02:47:36 -0700 (PDT)
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 15:17:18 +0530
Subject: [PATCH v2 4/4] disk: part_efi: force partition re-detection after
 GPT write
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-series1-spinor-mtd-gpt-v2-4-5d29d32c1289@oss.qualcomm.com>
References: <20261023-series1-spinor-mtd-gpt-v2-0-5d29d32c1289@oss.qualcomm.com>
In-Reply-To: <20261023-series1-spinor-mtd-gpt-v2-0-5d29d32c1289@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>
Cc: Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Anurag Dutta <a-dutta@ti.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Udit Kumar <u-kumar1@ti.com>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792748836; l=1523;
 i=vandhiadevan.karunamoorthy@oss.qualcomm.com; s=20260817;
 h=from:subject:message-id; bh=a6CAWCQFYd5GXP+OPAcafEUH4Dt74g6uFYfDNAW4qck=;
 b=04jIc7GKJAOBC4d1UX4S6dl5e5anVDQLZ/ElxMnfvGnmxDOZbwQ4hp6Ey6hQktPvwN9vvj5Ln
 iSTr2mvmTgwBK4oi2OXyCyaGjcUbPi7PmOCA7ytYJxC1jqEA8sWS63d
X-Developer-Key: i=vandhiadevan.karunamoorthy@oss.qualcomm.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Authority-Analysis: v=2.4 cv=cZpHPXDM c=1 sm=1 tr=0 ts=6adb2d3a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=tgo4uRLMpLsbOBuB3zEA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzOCBTYWx0ZWRfX9mRa7LZCe3Ij
 kWDKLNLDDa9GtFmeUxmIUr/JWcuDzdvQifiKNL0ZLjVVS8EbzsuUQYLFIxmDeOXlERtDL5Xfa0V
 DBpWVnMEt9pzhwuQ4qqaB4ZUiZEzOmI=
X-Proofpoint-GUID: wmAgv8GkEJVAVLzE01e9oM5VnRMpKnAC
X-Proofpoint-ORIG-GUID: wmAgv8GkEJVAVLzE01e9oM5VnRMpKnAC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzOCBTYWx0ZWRfXw/a4oRBhTwtp
 WcCxGvp9L0uo2w2pYC0PoHRaHd6tgZYwhXPK7+3mGPO0dtFqLq7tBvYd3D3/DhbfSWG1xgnmJy6
 /nSyckMrUxpMlFdLXxCG44p8r088rn1uMB5LkLq8gwBLWrC2ERPw3KmAerA4DQPT/WY6tWWaIHG
 cG5bM2CpgVmDaGOrS5vfcjSh58BeoW6a53h8pEVq+/dFpm1G1pP5H42fgjcQ5xSDfGyrUHeQtAb
 DM4Tn4nPqFMx+0CNYr2LMmtG/6ZOkR51cWFXC7g9c8jAAeurKl91jlhPNtWSKMnCkUEbkC3Ckkz
 KGk4V6Xsw+/VFKaUy8i4wG6b5WeYKfcngrKfq4UwAyMhliCWh2nbk8eUy2lS1ATK+fepg8y3Vh1
 eO2Xbozqv8cGSOMBjqMTWcLyPBdcCU47jvgRg/3fOCdSTxozgaRpnU8+9FzaSnzNYTqroabJMbs
 i1idCxm07Ie0pUml1ig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230038
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

write_mbr_and_gpt_partitions() calls part_init() after writing the
GPT to re-detect the partition table, but part_init() takes a fast
path when desc->part_type is already cached: it only re-validates the
existing driver's test() instead of re-scanning all partition
drivers.

On SPI-NOR/MTD block devices, part_type is cached as PART_TYPE_MTD
from the initial probe, since the MTD partition driver's test()
unconditionally matches. When fastboot subsequently writes a GPT to
SPI-NOR (e.g. via 'gpt write'), the post-write part_init() call keeps
reusing the stale MTD type instead of detecting EFI, so
'part list mtd 0' reports "Partition Type: MTD" with no partitions
until an unrelated full reprobe (e.g. 'sf probe') resets part_type
and forces a re-scan.

Reset part_type to PART_TYPE_UNKNOWN before the post-write
part_init() call only when it was cached as PART_TYPE_MTD, so other
block devices' cached partition type is left untouched.

Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
---
 disk/part_efi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/disk/part_efi.c b/disk/part_efi.c
index d8751297fbe..3934faaa6d6 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -1003,6 +1003,8 @@ int write_mbr_and_gpt_partitions(struct blk_desc *desc, void *buf)
 	}
 
 	/* Update the partition table entries*/
+	if (desc->part_type == PART_TYPE_MTD)
+		desc->part_type = PART_TYPE_UNKNOWN;
 	part_init(desc);
 
 	return 0;

-- 
2.34.1

