Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C55C9833E
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 10:28:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E49D80D7F;
	Mon, 28 Sep 2026 10:28:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0D-oVl5TX1rz; Mon, 28 Sep 2026 10:28:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B50DB80D3F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790591314;
	b=FUpMv5PvvYph4uMyVMESFw9AgBaaOOjSptatZUDg75bA1Ec01+ovWQLb31rsFQiqcWBS
	 bTIX0gNm5vHWUg1KF+gci6ThivD3yW4EipmrPh4E2ZIvLQtbaTozg6/f+lEX1QCRqcJQ+
	 4lpME+dViEw6X4aTqDH5dTaqdzzM245qc8PyQHyBozfOGSlw5Yq3Lpw5lH/sxJ56F+9A1
	 49XovT7WxWwkQGvy/le6ielGsUvflaLBDPrlUX+lSzNmb75hPVucaigLiJ4I02+E4onDe
	 ZOpsNZTL82vPR8UtaIkO6p8nYSZN4Z1OmkqgRwkZivJxGmWWgD1/HxzQfv296TDnDcw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790591314;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8i12S3H3D9sd1BYCqCNX42KKHOiWumzvD2aqRW8IRMY=;
	b=n64PlQM8jI/yOoNhjq+JLiSnSAK9N90d9GjViDrU0iW61oZRxaL+DBUL+v7Wgwdr+mJ7
	 YBy6YuJPNyqZHaBl8NiZ+Ic5r5B3kc7Ia/+IPTkxiimax7h3UrIawpPL2KSnpJgbXTGHg
	 NrEEKhnQP6Lc6X4sfxuWA6pkfBviLB9OUWO9b40uW6mq0z1RY5q+B+RuMs96NYYA+pcUF
	 q3OvZcrvt9qPY+KQKEYdg0ToxXPRoMEzGJ0T8v+WD5/DcU6UI7/9uP8KGPH3WEC7je9VW
	 huV10qRhCdXmcHnIxwD0sMI44po1csaCiZxXofCKqpBN+/vkmRBWWzO6XxCp1KDY6Uw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790591314;
	bh=8i12S3H3D9sd1BYCqCNX42KKHOiWumzvD2aqRW8IRMY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q3qszj4J6/xTC77ceMGHgBxIjIgCi5FqhDlp/A0g0IG05QRwBNYhrHdD/KwUnjocj
	 oNoWlCOtI2JAee66JD/WVOt6ImP1BjI1qJ0+FLCNtG6yfGGZxnkNjK66lzBTGDl4Dq
	 G9k+nQB/tua4s2LOly+GA0YHdAy5l+X+n/M3thWJrMKfVnEwNrYDtbyQhsue+THwNp
	 0O7VYDiRXKb6hNuE7o8U0nDkx1l0u9Z+AZOwlOlLcgA9Hm322IVi+Dn1i8LvoUAUwM
	 QcTSYqNw7G7+ETMbMC6WDtC56bpY2Qx5P9+pNDjP8TQUZOaEJVZiYV/zU49emh3Lmq
	 HV8jmOp3+UYzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B50DB80D3F;
	Mon, 28 Sep 2026 10:28:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 932A9361
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:28:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 84DB540674
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:28:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2dbnxsgXTr6W for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 10:28:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BC0A440664
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790591312;
 b=cfvU0JyCPcnCNzTX1EgY9I/R/N6GGw6jxQu7LD+ub/X5UQHNcpwV2ywNUSa6+qnS9EFE
 gjdqu5Tsuv+CRXvjEkR4yCzCCB/Nr6FKu85jYPxBvGrVY8wPImppI+N8OZ0B2OdHT0kZq
 kEPuoM4u0Y6w+eMsDYQNlVe01wXSFjJmAPdR49VN9CW1p5ZQ5CSKFyQNhLeqj6scXqxg2
 upPRgEMRbEWZNzn/eB5eBtyLnIycjLmTlU0fUa/0CM+gMec5Vg9SFn+wIVLFpqSdYam47
 M6vK7cwcDUMyc+pISIwKjadh8EhA44etaYltZLD0RSO1vlDhh//31Nf5u0BGMfiux+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790591312;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=8i12S3H3D9sd1BYCqCNX42KKHOiWumzvD2aqRW8IRMY=;
 b=lcP0OHfn+tjORKWHKgaLCdapu7eXiKUpVaDFwI8nf/dWgDFsbszqQwIxy5Ws1yz8IPrZ
 Ek6JKQ20syn6Y2bJmB06fZep1Z+CWzIc31x/W/Lb/BRKUBlwwlGCseIkF/537btde9szr
 dhDzoGuYhHajqMHRt/RxkKFfbYdluXU85eYicWdbe9tMkk8SDuvv+/MfL16MjjwfJOV+E
 LwHh4436i0s2k0eZ+6O9htwsAv6/x+HxjoJfV/Yz0WxsuoiiZsOjhwAwpRxs552rMTVh/
 W/4r6UKacfjTnIUXv2BFOETJatZacm6rXvvmN8liKDe+REErkff0ImhdgMpKiIuHZ5Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=nDPq5s3N; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ENljVdh8; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=nDPq5s3N; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ENljVdh8
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BC0A440664
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:28:32 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9M9D62057314
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8i12S3H3D9sd1BYCqCNX42KKHOiWumzvD2aqRW8IRMY=; b=nDPq5s3NJcEMZIKI
 fA+ML64iqUMW881dzC9pyWTj9EBMo6PF/CWqTmv6Tn+0YKkh6vwFZuwEzNxviStx
 YM/Q6gFEvVjizRRpQowqQsOJ+xNr9GJj1aiexuV+caV3IS2n678NgbUtSji9i8IU
 87GAyeKKHFzJb8fgKBq012VgbfWf/854TLazHPnwveocqrXsW51p8yxwBqbjThWr
 ZMIAFnHt8WV067pN1qpc9qFFtg5DZExZQU+StyIgXhxasRqNLuHaOK3OV2ANkn87
 g5+XQqGYpPKesSftOXCJM752qAOmXFEEIXwqW1C348ghq7DSAaBWnXRfni5CE+HY
 kYP1Ww==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyhubh4bb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:28:31 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30f1b904861so4253773eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 03:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790591311; x=1791196111;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8i12S3H3D9sd1BYCqCNX42KKHOiWumzvD2aqRW8IRMY=;
 b=ENljVdh8nLyo8KK005L7hGnU0jZbwoh/ot5W0YCYm2ehgDKOCKz7m+UNsxUoyVFDzS
 oZ3/eC24ubFSbxubkIGZv0LJk5yGsVZXb+7wbk6gWQV9pDASNcEGrjhw/biFjfdlbtRo
 AdXLcv9yxj5hK96hV/4R0a6q7oZQIIPujcqbIVjvMKdL6NqrobGSEAIYgFIMOdoh79gu
 fx+bsYbo02QZhT6lGilZcMm+jKsU1aXnwKCJ8zuQMi9YBuuI7sWsMIDRlztVN3SbTi9Z
 mB88uxu2YBED7GBuGnwoYEe+1nU2v16ma6Aedh/1q44zrhE/2qPQAgA6T2BuN4QpSzfD
 UDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790591311; x=1791196111;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8i12S3H3D9sd1BYCqCNX42KKHOiWumzvD2aqRW8IRMY=;
 b=BX5iTd49Ta8NMJh7v4Ve5plrh7vlErjsPt9mmX9rvIdf+4eabhkZL2Ya4kzpJAikh2
 54u3091pwLi1vgKh9hGb6E3GFyLJaCWd/LHl8wzakWV3PVFCgzQyitjQD1tjBI5t+sD5
 7CvI4u71yNXz6tP3OYa5eVuGy3P8k3sD4SVk5RtTApIVQ0lKCfiYqSjcB6GEQQ+d1DeZ
 A2jVFBd2NvyxkaX5vXOpz9ooeV0MUWBHh72P1UU1tmqYua8i4iMn6jAd5v5o7vbFltZF
 K546JG3SLohn1ernBu/iuRJERJ7NJoj1kCkkQq38gOvFoSHtmV8NVRXKbgrhw61DyP13
 aD3w==
X-Gm-Message-State: AFuF++nkLx37219UAQtqYmZzLYhtn9Ja9+055EQgrx6YUzfegaEBgv7o
 FzeOEOX08r196/BQFub3wU4wzGnKhDZk4q4xX5UV0mzPFWlLRF6Gfj/VyGbnkDP1dbLZ45qL40K
 jFQBmvFdy8TstH9659jg1TOcWac36QDet74LTFzatdwfsjzrb+44CvgX6g0TdQQ+JNF3PDx4=
X-Gm-Gg: AYBFou1oEK3ImcXk2a9Osu+YEmbEBdR0knSVYNu8I6m7sEWV57vLfB37TZFz+OoQDRl
 2S5uV7sDoegUDa/V53VOaM1zdIeKGqoaAQFe8KevEtBJfM4BB9lXf+9rESLZOsg6cmJEHKZsfS0
 7iNecPwtou4eulUanM5SZid5qZ3knTCCJaua9tQNyFnH50a1Q2F6ihRj89Ng5A3/ngrPhQk4cf2
 z9CqRvFU5B/fNMBL3fCneOL41RoaKCYe9NI495io64JSamrZPPo8OyZPdxV+KJBTVY00ppa7FrW
 X/wgoAENv7b1t9zSzItdMwWWF9oTFMHnK6fYBYts5mUm4LOyVf0yfM2khUGe7F0VhFPrRUFTdor
 6lcMpSA8IHrziVLyXygOMjWtQLgeY4OCacC11nrUciR8bSvkGqU4ce22KusYKCzzVVfGhFRwWtr
 7G4q8xXhN0ewbvJZqDoWI1W3zFw6yF
X-Received: by 2002:a05:701b:21c7:b0:144:fd7c:84fe with SMTP id
 a92af1059eb24-146d0495501mr8745543c88.35.1790591310849; 
 Mon, 28 Sep 2026 03:28:30 -0700 (PDT)
X-Received: by 2002:a05:701b:21c7:b0:144:fd7c:84fe with SMTP id
 a92af1059eb24-146d0495501mr8745502c88.35.1790591310290; 
 Mon, 28 Sep 2026 03:28:30 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145acd3d8eesm23015091c88.8.2026.09.28.03.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 03:28:29 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 15:58:14 +0530
Subject: [PATCH v4 1/3] arm: dts: lemans-evk: enable SPL support for UFS
 and dependencies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-spl-lemans-v4-1-007635cc4667@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790591300; l=1949;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=kQESp0v8LDMShrCpPhpBujQHe6jJTkqoluN+H83d+Qc=;
 b=Dns3K6kMve9sQFbyLdvm3P1cDeaMpGHCts/9DKErEDCQrYRvPNHOtirruu8BAlHFspsE25+wA
 EjRrBR5fCrAB6CnOcaE45vaMJuRp/vO4rxmvcjvxxvXyBywBxvJzJH5
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: EFCs2ZgRKQ1NyANGGbcxZ7KFdV593i23
X-Authority-Analysis: v=2.4 cv=C7F8WgP+ c=1 sm=1 tr=0 ts=6aba414f cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=nQCtNUuqFeM5Ofb-tqoA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: EFCs2ZgRKQ1NyANGGbcxZ7KFdV593i23
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0MSBTYWx0ZWRfX7PejGC0F0vea
 rDLkQUllHrK9fHlDiokQLcxgBqeVaZTXbc5fvxKI9Cg6cpCM4qfdH3zScyfCtaxNDLqs4LGKMim
 p/WpLiR7a6r2k1TgFMzwc2CtsG9q5ybdeiphz+1dVr6CWyj2Eyq0yM1bDx0ga3BslAjwY0ZJLe5
 2wJ2sqsxXn9g3DYIAb710SgzCnoHc+2yFkqYPtlZYYpVRIPNUAOt1hrur7VLPqKMEeLHiAhmrGM
 ZWkESkorzmABv2iVJlVs7ceiqmZqbOAhY8cwRV/mq98BiTTFABlwxKl/+9p6CFtqlyx7pE9r+JZ
 QMXPJqZlToEiKp+poYvcqLgdxoQI0t1FniQUKya1ZSdyohQTn+txz/OneoZsEv1TlaeFOdPUtKW
 fSfli5gpPKOxaNAMwB0N3ouwOSvZkWJdD51R5usmk0Tvk92VIQYiwAdxUg6Ss6aOVN3GqqWp/hj
 FcTYwsJ+jRmZJpIC0+A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0MSBTYWx0ZWRfXwBdUDbv2cfVn
 3bVa5CtuTVRuv/1ZRVZksUje1dVB2dqeKliO3QBekd1GrSAEmWcsWTh5c/1iXh6gMk/P7z0gUmj
 CBxyjxfkI65PotTKpFgD7SlrPkGKyG0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280041
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

Add bootph-all properties to device tree nodes required for SPL
boot on Lemans EVK.

Remove the memory node as now the available RAM regions are taken
from SMEM.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- Remove memory node as now the available RAM regions are taken
  from SMEM

Changes in v3:
- No changes

Changes in v2:
- Rebase changes on top of already added arch/arm/dts/lemans-evk-u-boot.dtsi
---
 arch/arm/dts/lemans-evk-u-boot.dtsi | 51 +++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/arch/arm/dts/lemans-evk-u-boot.dtsi b/arch/arm/dts/lemans-evk-u-boot.dtsi
index cdd3d32f61a..ce5aad31bec 100644
--- a/arch/arm/dts/lemans-evk-u-boot.dtsi
+++ b/arch/arm/dts/lemans-evk-u-boot.dtsi
@@ -4,16 +4,45 @@
  */
 
 / {
-	/* Will be removed when bootloader updates later */
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x0 0x80000000 0x0 0x3ee00000>,
-		      <0x0 0xc0000000 0x0 0x0fd00000>,
-		      <0xD 0x00000000 0x2 0x54100000>,
-		      <0xA 0x80000000 0x1 0x80000000>,
-		      <0x9 0x00000000 0x1 0x80000000>,
-		      <0x1 0x00000000 0x3 0x00000000>,
-		      <0x0 0xd0000000 0x0 0x01900000>,
-		      <0x0 0xd3500000 0x0 0x2cb00000>;
+	clocks {
+		/* Fixed clocks needed by GCC */
+		xo_board_clk {
+			bootph-all;
+		};
+
+		sleep_clk {
+			bootph-all;
+		};
 	};
 };
+
+&ufs_mem_hc {
+	bootph-all; /* Enable UFS for SPL */
+};
+
+&ufs_mem_phy {
+	bootph-all;
+};
+
+&gcc {
+	bootph-all; /* Enable GCC for SPL */
+};
+
+/* RPMH clock controller - required by GCC */
+&rpmhcc {
+	bootph-all;
+};
+
+/* Apps RSC - parent of rpmhcc and rpmhpd */
+&apps_rsc {
+	bootph-all;
+};
+
+/* UART10 - console serial port */
+&uart10 {
+	bootph-all;
+};
+
+&tlmm {
+	bootph-all;   /* Make TLMM GPIO controller available in SPL */
+};

-- 
2.34.1

