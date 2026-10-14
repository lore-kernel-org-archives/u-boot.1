Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F319ACC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 16:52:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B6386407CA;
	Wed, 14 Oct 2026 16:52:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ox6OmxA9JjVF; Wed, 14 Oct 2026 16:52:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A4C0040755
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791996730;
	b=qPFcBjqLQw33YQGZDmEIPbFWCBIvMmD502I1g/afh1QKOogl6FqKtv4h7l6A9NmZ1PZP
	 U5kcIQx09wuqgyNA04XLyIWuC5Kn9AmHMaHX4m+CTfmlWYH7pd+76JIKidu+L4sdhN+A5
	 1Y47wihv/UE6A/xraZgF/+kZVBu7kWn0pyfr7W1x57FeJozLXOoyMkzQXCajKtZqtyse1
	 6V5g3bsRVf26JZPyfGiyKtRP3Ks/8DSFqvMJMEFmF7dIYjk3yOyW2jte++Kwi8vdM095f
	 +XhWlPyY3XIZ4ekG0ZkcRG/UApCaQftY0gvvsXIbWIkdmeRMnHkqN7g6lbPnQhax7mg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791996730;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cTfx7+kLekXMDgnlwiQ2nxLFk3tAKA59oj0N1yvcSIQ=;
	b=LvVZkUkZckVXb2xFu2A10j/AKmt/Aq6GSVWA0ruH/06ZoFBdYUT8EXFfkZdDpBflX+0Y
	 ORaYeg22Q/RzuV9bPPF8BuoyG4hLhQshexe5uowHqLqa/Zwg5+mb4e3cP2cFYQX2wg46p
	 lVjVjladI8s8nnAtGvXLKp0WdzPbWNN7eAF5qMzuqa3Scfc6gPEff2eEQsEBG9zkpjymR
	 LhAHhokcfsFUlta0XuUoIvIuz8NYK5NBUj4mwOAcoxFfVys4jT3S3eCB1HKhlTwt1d7Xk
	 up4C5BpR3taIO9qh/wy9uTAJi59/a5CGP2LDgDit/I1KxBaohZx6T2r2PS/0LpdZjkg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791996730;
	bh=cTfx7+kLekXMDgnlwiQ2nxLFk3tAKA59oj0N1yvcSIQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e+ei38bQuUO9MlapsmGeO6DdYfK7aCE5ovLZehnJpeBWNAPL9JfT5mp/a28JOI7XR
	 KXLnXsS3t1ChMgs5RSY7oQbztopcTDWw0MRjPlju8lXchCQxjo2lzw2AA709GhEjJa
	 E+Bn2jD8+jpw/0v6EpNNqWkKqDgxWqMNf9ROMoRc2bmGCmg3aOaQZPhvhhguiplDNg
	 yNfI+RI+V+Ayzd7kF4eBVrT7F3i7u4wb15ley6bNtf4GG9Fr0u1sgM48uxRs78LfX4
	 NMGJcMpsF6vGjQa5Go+/t0qLhRKZcqA3UK2t63wT9tG1D5ShMBxydN8B7nRkleragW
	 dWp2kdBZ/xA4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4C0040755;
	Wed, 14 Oct 2026 16:52:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CE3D3A58
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:52:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B4ECC40363
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:52:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4o3KneKiYcDp for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 16:52:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B2E8B401A3
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791996728;
 b=WJP5z3Q8C8sdoxwHoUWXc7WFlBxytHNXGJ7nKrZ74X+oZa97UTnxk41zo/RJNX99EeSh
 gj4e+kIjU33k47GBSLfQXnKm2QQfwMadrghB7XsUL4N8SjH64F+SxGqlMVuDSIGfzeuwf
 E3/tC+mTABq49OJyGNBykjDI4OZ2Fnn/TmbHV0SJKS1Uopo6mSz3aFGgMEIdXr4+rNFDS
 /VbzImgFQCmMWWe2J3JLnXgAXb9lcuEeftbY3T/wNovU0xo8EKl5nMfyVP8ZPKVj8dlRD
 /8jgj9teLWakcGFre+hwYMfAlQhwRoqVHuRB1USQ2WmeqnxMdgVldHQnko2WpsO/gFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791996728;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=cTfx7+kLekXMDgnlwiQ2nxLFk3tAKA59oj0N1yvcSIQ=;
 b=jBLRKnL3jVrkvAjJoZQj9Wrd8Lfb8s/h+FVzz6wqcQpMBqUthc8unaktVpk2XO01gZNc
 xOZj6OzNoeXLH308aekAhqiuDb/WtN1EyKMTvEtVCUMrvLnGUyp6gLDqRQTJ+54zwN9i4
 u/Q5UFp7LeDzLS971lR2NFrPQiQ1qmW37ZCln2yP8TpeaZVNLVzhQ0/6xFVzfDeCM2slY
 rUHRIw2/2bqcocs6Aucu7yrOhUjCjLM0FOA8pvseXZhUE4GfG0QDd1pDzmbmxRBguHCZt
 0GSYNSkY9BbPXppsXdU5CW/Gc4gT5hp/0kHIHYpRhQjRtRKy+5zwU3xT+0i1tGMT9fg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=dp3g8v53; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TcZFBnKu; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=dp3g8v53; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TcZFBnKu
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B2E8B401A3
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:52:07 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbNKF152729
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cTfx7+kLekXMDgnlwiQ2nxLFk3tAKA59oj0N1yvcSIQ=; b=dp3g8v53cl6apCAI
 arGdnSmY5tpeCFoOik2m4IY32wlnPb90qbg9lb7AsbrCxvSJrzI8jtID20XylaBS
 HNojlYLxCzdxFPyT1hHp08+Zn1GD9tHOIkma2uRvbahUSuJnPu2SHJ63Yf9nNClk
 KlvgfThJHe5BUYRCVQLRWGxtyfRceYgi9pWDI50+okbCQeId7md4MBztgskU/bxX
 5/4TPqxdZu70OtUsgzeHQrt3iN0vlhkbRpD+u7ACJPDOnwcUqLfwjzIzMImT+3pb
 LBwITGfTi3CiL4ccgjyzZkBD+PS13sKuXA6+hPP9JGV4L/5OCROkQh7n+/HuZpXb
 +NFoGg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha7aehqa9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:52:06 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35c3c370b17so4087876eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 09:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791996725; x=1792601525;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cTfx7+kLekXMDgnlwiQ2nxLFk3tAKA59oj0N1yvcSIQ=;
 b=TcZFBnKuma/SwypBtC04pe+9KDe9RWIjSAlFBtpFg9oqhr7hB4tjGIAIUBKlhRyAUZ
 iFAYdHPy/FpbuG25Irg7TycWDIglXRsZGQ8PCBXjllzLXvRHmVoeNAcSh4rKSGO4llNs
 loc9QpRYQo51sgMWAEAyjdjecHc9cJ6bRwqorFw2TFJAgMTv3hOpB5gwGF0o7ptcucqn
 ryKNw86h2mfhP3DhlP+BXcHqlipse/v8OlhVSdKmM+raGYvAvWTuBX6gfrt6oMCD1Sgz
 3N2IzZ78jH/ftGl2eyH4dBTLmyvwqy9ddsmwHYUDeIQpVFmnWRDhF6NYfQP9cUO965Rv
 Wumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791996725; x=1792601525;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cTfx7+kLekXMDgnlwiQ2nxLFk3tAKA59oj0N1yvcSIQ=;
 b=heWzSdvnLjDbqG6YNYAEK7izoVCbLiY/AyZmQIf66Rg/vpgfnCKvWlxjq7yugGbtYJ
 j+Fo4QCoHMozPw8ptE73mDDx1mZJ5TwJ/aM9x++TvH8mk+L8JNDVeoH69w7mMZnWi73c
 7zgMVNR2EP5arE/0FOnreOwbA1qcglLnzXHtx4NA6qG+UUTAZ5Ena6BMrY2Ou1kOdoeW
 mCeXKWMqN64DyqOh85fzLo9jmC9KV/sjpo/+gUOhop/oZoTTtd/tZPPYUChYwMbeAS8o
 LvlfeLNQx4Kuiq/oCAr9wPRtyKo33DMcE3PDB1PIHPkiCgH8RsVUS+fsRkUwDIJHX1Pz
 fEBA==
X-Gm-Message-State: AFq9FYKJF8BKcqyjPz8f/Tu1XMzFBsXL9T/ekIRJL9F/ghuK4574Oy8y
 Dc7wIgAmrvhSRcGTGPNKjI9iG0gAzpcOUPDEklM8XhAnSr9MGQ0aF8TlEuJAD7uRZ9B5L5c80Yt
 rxQRbSa/nzjIc7qwEtRZGXcz0pklV2TZhv8X+vVn1fkeVNe+jzopwgVNF/J4J9jZTCEb2h0Q=
X-Gm-Gg: AYBFou3BL4GtKG5GCGcmsUhZjAbN1OcOyyK24ho2rE2pdh9XCRWPbOSPUbVikRj68Cl
 vtziwZYm2XMzU2hD39Z7xGXStdgWlE5INgvclKLCHEAQRAENunmAv3g+Qel3eIhdSRZzPlsTtLJ
 o+9bedhD1Tyg2VTHIPHmiIETbUX0oY54BGETemLFFHM/dhecn4BZ9BbYccdqdaXLI4ZTbyXSBMR
 urKMZGxUApxaByty3Db5mjvEKUcX3e3KTgNq6yyECfWTEyUzJVhpsjTJxn+vb2/hGIUMRNzSjUm
 wloMGLdx5icEbzbNtkKqhmrH4h2XfQu/AtC5AstOjVFcxoqqnXIi2R1ebMwnJcY6XSj7/drAinL
 UAGCSrbDmmHw0E+6TKvooFrp2eo2J0vxPbPeQoVqgiT4PDcJj9rv7Ugakgz2DQzCMCYUxOOS0JR
 D7/OMivcXRCcOOu/Eyr3sw8AAAWVE=
X-Received: by 2002:a05:7023:882:b0:15a:4155:3d9d with SMTP id
 a92af1059eb24-16a6034685dmr27170520c88.31.1791996724725; 
 Wed, 14 Oct 2026 09:52:04 -0700 (PDT)
X-Received: by 2002:a05:7023:882:b0:15a:4155:3d9d with SMTP id
 a92af1059eb24-16a6034685dmr27170430c88.31.1791996723740; 
 Wed, 14 Oct 2026 09:52:03 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a1dd57d0sm48975894c88.8.2026.10.14.09.51.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:52:03 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 22:21:02 +0530
Subject: [PATCH v8 8/8] doc: qualcomm: Add snagboot mode documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-snagboot-v8-8-7caef86562b7@oss.qualcomm.com>
References: <20261014-snagboot-v8-0-7caef86562b7@oss.qualcomm.com>
In-Reply-To: <20261014-snagboot-v8-0-7caef86562b7@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791996669; l=4408;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=NSFKMTa3RgbxoHyOYasPS7O1VEhmTRChjKRoMhsGyzk=;
 b=k4uYyyNdFn7i4vMfymxyex6xfhomnGbB+7S36N0kCYkaJjlP50eVDHghpY+oF9kU5P4XdWzd3
 qPG3mCLgljUCdL5yEmVFioUA5SMt+qKOdRfcKjHTpTDOvXeFBo0H0GS
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: SQuwzOtrCLQlfIdL2EOTdbNoRfwBJnx3
X-Proofpoint-GUID: SQuwzOtrCLQlfIdL2EOTdbNoRfwBJnx3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX+PWcgmLFE+gx
 SDjNT/kRphHqW/iP5jy/OucZSCXNsPfRF0Hief6CgKeO3ZI5lnaAl9QQVlZYtLtJ9ghg5cUxhcA
 Pq+RIY+XblT+azHddW8ngC/4Askz6ME=
X-Authority-Analysis: v=2.4 cv=NctzRGD4 c=1 sm=1 tr=0 ts=6acfb336 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=-mjFUTYrJJ_n1noAqFUA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfXyuwQRCp+yy5+
 R0EvNjo9XdTG7bx2ELYeIQYvMYjlunZkkVx8OVyyRHDiT2MpjZq1al+sk+XJa8uP7zb5eNStFy7
 p+KsX6dRucIgnXHwKgHxK141xTS34VwvC5VTcF5CGmetz18I1IEad1UvxcL+Dgx3W1y/hR+gNWs
 TVBSajK5TNN8qrgva50IkP0Gf7EUzIGqX7LGUvoU5OGze84WPZa66xkq1gSK6oWt80KNh7YfDvu
 4Z1MNRLgJPChJGcNo1bZol9syziAD+jmOc+xyQ01CLwDpBoL/iYQC/3W9cN+g1oE+3uCrIu2JA8
 c1hbsE+Th3vt5lJitTjP/gERrQSzjcduTKc1lEHWtu+gMyBAvRcSEuCDePOYLd/U615PWg3tKQP
 cFKudLzKPUv8xOBQ4Ra4CG1x1mCIUTWIhCTxcEX1HPRP56ZtXJO5EeY+vUguVMsFffXtYS7a34I
 gj+G4K8ACCXkZSgaqsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140067
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

Document how to build and sign U-Boot for snagboot mode on Qualcomm
platforms, using Lemans-EVK as the example, and how to add a snagboot
defconfig for another board using the qcom-snagboot.config fragment.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v8:
- Point to the upstream Snagboot docs instead of describing the tool
- Drop the "Why Snagboot?", architecture and EDL+Firehose comparison
  sections
- Move the build and signing steps ahead of board enablement
- Drop the list of Kconfig options selected/forbidden by
  QCOM_SNAGBOOT_MODE and the Lemans-EVK example section
- Replace the signing prerequisites list with commands to fetch
  swiv_build_utility.py and qtestsign
- Drop the "Expected result" and "Output" blocks

Changes in v7:
- Rebased on top of latest file

Changes in v5:
- Added build steps for U-Boot in Snagboot mode

Changes in v4:
- Newly added in v4
---
 doc/board/qualcomm/index.rst    |  1 +
 doc/board/qualcomm/snagboot.rst | 80 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
index 56b8d894c2a..b8bc37bb384 100644
--- a/doc/board/qualcomm/index.rst
+++ b/doc/board/qualcomm/index.rst
@@ -17,3 +17,4 @@ Qualcomm
    rdp
    signing
    spl
+   snagboot
diff --git a/doc/board/qualcomm/snagboot.rst b/doc/board/qualcomm/snagboot.rst
new file mode 100644
index 00000000000..716d88b2ba2
--- /dev/null
+++ b/doc/board/qualcomm/snagboot.rst
@@ -0,0 +1,80 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Snagboot Mode for Qualcomm Platforms
+=====================================
+
+`Snagboot`_ is a recovery and reflashing tool that can download a
+bootloader to a device in its boot ROM recovery mode and then flash
+images to it. On Qualcomm SoCs, snagrecover uses the Sahara protocol in
+EDL mode to load XBL, which initializes DDR, and then loads U-Boot into
+DDR. U-Boot enters fastboot mode and snagflash uses fastboot to flash
+the system images. See the `Snagboot documentation`_ for how to use
+the host tools.
+
+U-Boot built in snagboot mode runs directly from the address XBL loads
+it to. It must cope with the MMU left enabled by XBL, and it cannot
+rely on PSCI firmware or Command DB being set up.
+
+Currently supported platforms:
+
+* Lemans-EVK (``qcom_lemans_snagboot_defconfig``)
+
+.. _Snagboot: https://github.com/bootlin/snagboot
+.. _Snagboot documentation: https://github.com/bootlin/snagboot/tree/main/docs
+
+Building
+--------
+
+First, setup ``CROSS_COMPILE`` for aarch64. Then, configure and build U-Boot for
+the Lemans EVK platform::
+
+    $ export CROSS_COMPILE=<aarch64 toolchain prefix>
+    $ make O=.output qcom_lemans_snagboot_defconfig
+    $ make -j8 O=.output
+
+Additional tooling
+^^^^^^^^^^^^^^^^^^
+
+In order to generate a working image, ``swiv_build_utility.py`` and
+``qtestsign`` are needed::
+
+    $ git clone https://github.com/qualcomm-linux/boot-firmware-ci
+    $ export SWIV_BUILD="$PWD/boot-firmware-ci/tools/swiv_build_utility.py"
+    $ git clone https://github.com/msm8916-mainline/qtestsign
+    $ export QTESTSIGN="$PWD/qtestsign/qtestsign.py"
+
+``qtestsign`` requires Python 3.7+ and the ``cryptography`` module, which
+can be installed with ``pip install ./qtestsign``.
+
+Signing
+^^^^^^^
+
+Add the SWIV segment required for TZ-based signing::
+
+    $ python3 "$SWIV_BUILD" .output/u-boot-swiv.elf .output/u-boot.elf lemans
+
+Then sign the resulting ELF with test keys::
+
+    $ python3 "$QTESTSIGN" -v 6 -o .output/u-boot.mbn tz .output/u-boot-swiv.elf
+
+This generates the final ``.output/u-boot.mbn`` binary, that can then be
+used with snagboot.
+
+Board Enablement
+----------------
+
+Common snagboot settings live in the ``configs/qcom-snagboot.config``
+fragment. A platform-specific snagboot defconfig includes it on top of
+``qcom_defconfig`` and sets the platform values::
+
+    #include "qcom_defconfig"
+    #include "qcom-snagboot.config"
+
+    # Address where XBL loads U-Boot
+    CONFIG_TEXT_BASE=0x1c100000
+    CONFIG_REMAKE_ELF=y
+    CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
+    CONFIG_DEFAULT_DEVICE_TREE="qcom/<your-board>"
+
+    # Timer frequency for your platform
+    CONFIG_COUNTER_FREQUENCY=19200000

-- 
2.34.1

