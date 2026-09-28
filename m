Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B041C9833E
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 10:28:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B054480C95;
	Mon, 28 Sep 2026 10:28:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WgaUJmzt9xiu; Mon, 28 Sep 2026 10:28:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9382080C16
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790591310;
	b=DLVn9/xhvJmK3aWTibgQ0xC/K0q/fS81y2riaj/GS4nHZ08fuELBd5WOrhUB2V/yNLCU
	 XmWip2+wWdCzNg2n2ldp3xvmd5JzWH3qaNZDuvFl88GPNs4iOFSspILpR48wcOSFuvk93
	 KMhyYkTkoZrYYJgaSp3pbFNpqYBEYHNINva55FHxpk5qHxvrqoNXirQp7Z07frZMzXv6E
	 gnJyeSEC4ZwrjkND6PsA85ygme6ER6LooUksgwr1ywKP75YCT2YcW3tm3B7ZFYL6CIygn
	 EOEhkQ07fVVfsC0DP+GvXvCpON3Xwn2TbKXWtUHd+at4JGd6eovEO1TTF+186mlDlxA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790591310;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=E2zrW6CbY47fJMu/iBkgTEy17Ebyz0A+mCf5E6Zob2Y=;
	b=kEKvcXuQjUC1Gh2KIa894KWzs5//XKkFlqAEl8JwKhgNu+LoItnWkRWD91FLy9Dhxfua
	 iDskYY/xmTUQlqiBrmdLpxEWqYVD8WA6wwgsPVP3kFLsmtj8WM+XcYoUWnL9W179PxCxy
	 RaPBCPufNodo8sfK33mDduMrH+oIqmU34f0x4nV1cjiwvsVF/Z1jjr9bUIlE7hMzaiz4P
	 nX1HRSmhN8VVe2OgST8FUrz2l1DV+vbAe99u86qnPMOMYMVKyW2qNGFZDAkDKVqHjgLeY
	 CxKn3Ahvgy5zyXXrs0S5VLsBGjL2F2ieYzLAtBctWq32Eo0/MpJmunixSBddXZikq4Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790591310;
	bh=E2zrW6CbY47fJMu/iBkgTEy17Ebyz0A+mCf5E6Zob2Y=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xeDwm8rqcjfSo5n2RaP8Xo6BWm/a7ccg4dAjEyvWjSPdmmGlbTnFP8PEHy/O2H8Al
	 e/wUCXJXwfofxXuLkvHA2WMwxU2e6vhJ5mRMLSVf0WE2Kclhs2h7CZE8g42e/XSKxE
	 3Mqqlzxs8dwFHtWrlsMkExuCC7rxIexcsOpiM+p++MNkIYLQt6SZ6EcoZAJy8PYEgq
	 eWaCWaizd8ZjLFooLIRk5dCSIZoJ75bxb5z/jKBPhgVh+qIlQgg+IyIDXeHx7cMr0P
	 y4ILZADiDCHb27dSbd/8+qO7b6aJ77PfK6Fcw+EGqV8nomJeNwXFC7KoYYzgQcvyLT
	 iMtL39o5sbaHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9382080C16;
	Mon, 28 Sep 2026 10:28:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8762D3D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:28:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 79269401AE
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:28:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sR9NNxYFY8Ze for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 10:28:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5C3784019A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790591308;
 b=p/PDML0MlBOUXA/d+dD/bLGSZnj3mnNFoinIGuSFXwiEQx0p7Wan4wu3yhIZdV2UiTcD
 Kro8vMtDdxkmFSIDYUtLynIaUOjCMMGeQAE5rgmRRmRynoSBMFY1W1rUeIWQ9u42og/Yn
 v7DWj4UVmlZwUXYYVsas2Iy5ZXvmk04p8Ahsy6ceV0Ha0knngr+vLhqhcKuYRua8Er7y+
 nw+zy8NmoB0dJ5jUg2ChDN053lWn51GgcgdvEdK4fuRw/pF5ykfptCxAkF5et+57BjIWJ
 F8a7vdJdKZzmO0LoKRlM8y80bcb2GRc7zrr0lf4i8U7/Vrbe9DW6Sm/n0zCGaivY08A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790591308;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=E2zrW6CbY47fJMu/iBkgTEy17Ebyz0A+mCf5E6Zob2Y=;
 b=CxbS+zVPBJzTxGrc2EoNjqrhimRqsqlYzHyMAD6h+siGP9lao8mdZS7JXGYOp/MZXhlU
 VmcWMsh6fG9j5gfEiMUQHB8+GlRQYhoPRO6Llunx6N6vRdiiJOPQYDeJhg5gCj68FvyHb
 Vm9tMlW0+4efMNXr0DqMqPsVSfZtZ7yIJcMUTyNAsXKo9c/6r+45uPqSoCUvaMxUNhomN
 ZuzDKfJgph10hak+sfnB7rbWJCn5Tbke8yBOz4amqS+3SSoI6E0LlnIB+i0hSEP6FoUFM
 le2B3VKFp5GHefsu9cfUou0ydfluxGsa/gV6Za/2Yb9sQJnQMLe4tpPqt/WMH8MMySQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=hqlBPWJp; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="TyB8+Z/e"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=hqlBPWJp; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TyB8+Z/e
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5C3784019A
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:28:28 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9M8De954231
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=E2zrW6CbY47fJMu/iBkgTE
 y17Ebyz0A+mCf5E6Zob2Y=; b=hqlBPWJpUIMKzghdvYwdgwqRcAtpstq5FgPjRv
 FhykBbJjQgQ2lH2MSru7FDDfqTTyuZKISw8a+OzmCwXJ0ozQxz9RVtxNQGWRUuHK
 csIGTggwJKBHSSkkMoeFZsDGe4BpCqB1KR4Fa6L0AzbQJAzebCl5qlvaD1Wnl1PG
 AJeBT0P3A6BlYV53kd8bY1gMYv6eNLyeMT8e5ugbdt1/QIhesZcCUUstMRKI3KgB
 FEq/2rRCQ7r5Ljl5fD6jM8vIGBfLHf6FJtoSaj657jNMGsTPHToPk/IxtaKw2Ih6
 ifcfiBCFbeDYQslms5YbCAe7mPh55e3aw26Xp+FZpImdw5rA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynbc09mu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:28:26 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1438719cc1eso3207943c88.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 03:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790591306; x=1791196106;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=E2zrW6CbY47fJMu/iBkgTEy17Ebyz0A+mCf5E6Zob2Y=;
 b=TyB8+Z/epvOFf0OIqWQ5V2h9Xgeur7lu7yHblgMyI8sI8TCL1qE1OFj2spx4Tmo5bj
 TEIVEzZuSu25UU4IOMVeNUmM5Dd/pJkzDjMvaf7Tt0u1VSqz16Rpxmv9Et3jWJPsKugs
 x601/9bf/5GRo/bCX1/XLcnP9OsJrPGeAH9CAF4AI3egRDmpdlLLjEBq6irAFt6Rav9w
 /6PBmTppVPUyfcSHfUdjOnj6aiHc6RkM9H+L0vBQaHn9Y9OtqOEhggM4i8EJm8enTgQ7
 sQkWwqtYtuqNNKBApu35AygsRC9iAJpqYwV9Lvrha0S3b7FJPV/ZYjbao80bvpSg/AVf
 +3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790591306; x=1791196106;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=E2zrW6CbY47fJMu/iBkgTEy17Ebyz0A+mCf5E6Zob2Y=;
 b=CzmQ6T0S+/q5oBBU4T3/CNdMbUVhG6j1qPbWm1uz8D9sPaQRe9JGRv7+3QPjP2kE6n
 1BqpTF2j8aQSXbvivrRRlnyzXDWZhEqgGza6kOdjfcz7tEItzMr81KIs6Owya1Kzvd7W
 gPW9jjG+R7rGA7f8sFNUCR9bD3Y6Ak1RRxF+vcAappbgGNwYPxKXuIJyAJErpYRRtGwp
 3ex09qLhb3e2IEHk484c3YdwldlqJPwVXYy/Fm+NKIZd/5KP+BYR44VND4qRZlBZny+s
 5/mMqFFc+phKbpzol35XR/EBx8EXrcgqEAHscgGfQdo6RNYKM/QjTx2nRJxWpPmz7Ywr
 UqhA==
X-Gm-Message-State: AFuF++kPwUwDY2h/sQ4aaHFlUVimlRDZ9U9vZ1BWkVWhVYXAsiKhai+4
 uhwfleYISoSXJbXSnjV2k0UxVkUQF2aoWtLdXCj5Fd6HAUGP6dhKI6tE37vxHBA/wnR4rXcD3b2
 qzgmY61CGx5BMe3xWmKoQZTJv/qoGRaxihObhSQWl41HixVWcKos/RFAze4eYAuWt2EHl9vo=
X-Gm-Gg: AYBFou1jZLexetV7S7lsAMqZGSv2plqvQ354zBSIOG5Q9BNWgmGO0ZS+Vf0nKZUXezP
 bnE9volFYvt2++krYGy87iVPqovpoavT/3EGcnGa5iszovRvzEInBIHLiAXmsIUnJ9Icfajrx8+
 l1tuy0obYzQCLF7iHdEdNS7jllZHBTrv6/EjYqrUYcAw6yaw3inyVV3UKUjCgskVzCelBdwn5v4
 GB1nZkuPxJsTkHHUkKB3HV8wO0Lr2X+0YD+PQYKOjh+nigBLdDB8Js5DHZW6NC06MU0GOsyJcnv
 5MJll3NsVWiBV684yOoV/TWOYllKL2JFvSYx5848f1o4Y+o3B1E42NvekXm8ko6MwdhkMNxti1v
 lQ+qTAPQlhBp/kM2gyQn56fqngF07+DIzVtSb22EWHCXcYQsfj6sEBr80Bg+mkoxtfQDdcR3gv4
 5L+vD+gMt9VWqEiY9mMImK0lKJqevw
X-Received: by 2002:a05:701b:2704:b0:148:4d6c:201e with SMTP id
 a92af1059eb24-1484d6c27d7mr6788452c88.23.1790591305754; 
 Mon, 28 Sep 2026 03:28:25 -0700 (PDT)
X-Received: by 2002:a05:701b:2704:b0:148:4d6c:201e with SMTP id
 a92af1059eb24-1484d6c27d7mr6788419c88.23.1790591305193; 
 Mon, 28 Sep 2026 03:28:25 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145acd3d8eesm23015091c88.8.2026.09.28.03.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 03:28:24 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH v4 0/3] Enable U-Boot SPL support for Lemans EVK
Date: Mon, 28 Sep 2026 15:58:13 +0530
Message-Id: <20260928-spl-lemans-v4-0-007635cc4667@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD1BumoC/2WPy27DIBBFf8ViXSJgMDZe9T+qLMCMGyQ/EsaxW
 kX+92LcRaVukO6V5nDuixGmiMS66sUSbpHiMueg3yrW39z8iTyGnJkSygirBKf7yEec3EzcYa2
 9lcZJMCwf3BMO8avAPq5nTvh4ZuZ6lmxCIleYXXUSZVOImxRccMAWQh8U2EG8L0SXx9ON/TJNl
 /wcP3hHyI8irl1lpQ5BDXWQrQPXWszRmyCDbbxqNJjcY43IDpdbpHVJ32XnBkXmd5L8O2mDrBF
 Q+1qDEn0j/2tc933/AcO4rbY3AQAA
X-Change-ID: 20260920-spl-lemans-ae54b916a136
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790591300; l=3869;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=2B+mH2I7S8Mv/YlQmAp9uvuLIATKMQXmJ63IB5bzffM=;
 b=YkICNz700JDj0qVvPpY/ZN2R0tL9QanUKhv+PPge7dyCVmihFfWWRacFsWOQqc72+PXXH8/5/
 PrNvrKU15cIDMgd5tvgutGRSpUTmFQEqsqqO4YxI2ewFaLvvgjNOt3c
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=Sq4Fe/O0 c=1 sm=1 tr=0 ts=6aba414a cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9XLSUFgA6YLrDrtVgY8A:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: XFfty6x1gCzCMzpyEMQoFk5YkhI6Cqp5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0MSBTYWx0ZWRfX9BiqNs6clZxo
 gkzPHSSk3c4WVHw3KadaXm4ScVxL1AcRvZwgd1vGwy01qzSd/bZx7LN5XDwENonWBmJiGVk2qkY
 cTQSwzFyfVpNSWaOrlnCp7JrcyJU4Wj/8KBbzNZls8xnO6HnzMhk+wAoRDsDK40QVA1fni4Uuj2
 fqUB1zuM4saZTuyM6lO0szLvsN3+TCGf7AH5kj3qL7c+rLrWJGM0QpvH7omKiC9MSbPHSeUEHnb
 jfXfTIq1jSFSImwohlMbnjY+cRmyOjopWkRwcYliFPq56CZFY0atcGkdR26G7xNRvjUaXfKmKen
 Etey5wbUsFpEOLpJMROImxTqw3xL9WoJfP1R0H/CppPj6Q5g37sncwPMD9byDG13yq87jNpUUSO
 tYBakPUKznpwkhx3GvQ8LLZ1/pGtBVbfv1xhT7ULsZwOimz7KwKn8fzAl+zW0hpKB/jZz9IEZzh
 6roG0ktEdfT5/rMMTAA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0MSBTYWx0ZWRfX8Vj0bWoa/UKZ
 OBGSCyzSeNOKcMMhKJqBxYL1S3tBPxM9anEXjjLEHt7DQlbMWqcPTMHgmT5Up9pV779xOsE4vPD
 OwhTqAh/hXD9AhHe/5WEhNCECiI0NWI=
X-Proofpoint-ORIG-GUID: XFfty6x1gCzCMzpyEMQoFk5YkhI6Cqp5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
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

This series adds U-Boot SPL support for the Lemans EVK.

In the Lemans SPL boot flow, the sequence is as follows:

PBL -> XBL -> U-Boot SPL

XBL initializes DDR and then hands control over to SPL. SPL loads the
TFA-OPTEE-U-Boot proper FIT image from a UFS partition.

This differs from the generic flow assumed by the new Qualcomm SPL
architecture, where PBL loads SPL directly. SPL initializes DDR using
QCLIB and then loads the TFA-OPTEE-U-Boot proper FIT image.

This work is part of enabling SPL support on Qualcomm platforms,
specifically targeting the Lemans EVK board.

This series depends on Varadarajan Narayanan's "Qualcomm ipq5210 SoC
bringup" series, which introduces the mach-snapdragon SPL architecture
used here:
https://lore.kernel.org/u-boot/20260917-spl-v10-0-3e83dcd239f0@oss.qualcomm.com/

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- Remove memory node as now the available RAM regions are taken
  from SMEM
- Link to v3: https://lore.kernel.org/r/20260921-spl-lemans-v3-0-de4b54320c71@oss.qualcomm.com

Changes in v3:
- Rework the series on the new mach-snapdragon SPL architecture
  (board_spl.c, fit-handler.c, qclib.c, pbl-shared-data.c), replacing
  the monolithic arch/arm/mach-snapdragon/spl.c and the
  SPL_QCOM_BOOT_FROM_PBL Kconfig option this series previously used.
  Lemans SPL support is now a board file with strong overrides of the
  new architecture's __weak extension points. 
- Add board/qualcomm/lemans/spl-lemans.c and include/configs/lemans.h,
  replacing the earlier SPL_QCOM_BOOT_FROM_PBL-gated code path.
- Drop CONFIG_SPL_FRAMEWORK_BOARD_INIT_F from the defconfig as now the
  framework board_init_f support is removed.
- Link to v2: https://lore.kernel.org/u-boot/20260615-spl_lemans-v2-0-d15746f4a64c@oss.qualcomm.com/

Changes in v2:
- Rebase changes on top of already added arch/arm/dts/lemans-evk-u-boot.dtsi
- Link to v1: https://lore.kernel.org/u-boot/20260606-lemans_spl-v1-0-ead97dd5b515@oss.qualcomm.com/

---
Balaji Selvanathan (3):
      arm: dts: lemans-evk: enable SPL support for UFS and dependencies
      board: qualcomm: lemans: add SPL support
      configs: qcom: Add qcom_lemans_spl_defconfig for Lemans EVK

 arch/arm/dts/lemans-evk-u-boot.dtsi |  51 +++++++++++++----
 board/qualcomm/lemans/Makefile      |   2 +
 board/qualcomm/lemans/spl-lemans.c  |  64 +++++++++++++++++++++
 configs/qcom_lemans_spl_defconfig   | 109 ++++++++++++++++++++++++++++++++++++
 include/configs/lemans.h            |  11 ++++
 5 files changed, 226 insertions(+), 11 deletions(-)
---
base-commit: 914dd2f5d18a3a89e4ddb6d1d97b2743618ae5ee
change-id: 20260920-spl-lemans-ae54b916a136
prerequisite-message-id: 20260917-spl-v10-0-3e83dcd239f0@oss.qualcomm.com
prerequisite-patch-id: e06f4f15b24c0a2b5999530d2bd810e8d5d25bc4
prerequisite-patch-id: e44b5daee156032f7c09082f5fa518ac2005dd9b
prerequisite-patch-id: 9da742167a0d265cc05d7d27bade9449856c0c89
prerequisite-patch-id: 61167bf309ffdf04460e71ead424508841ebd67d
prerequisite-patch-id: fd4a66734fcabb946480e13f2cef6e0a3d70516c
prerequisite-patch-id: a638b4c9d1805ff7ee27c5e18779ffc8717f7e5b
prerequisite-patch-id: d99a300fe20ef118d03f410ec7eb443b8945a118
prerequisite-patch-id: 863cfb8a300848c0277db5ac41532eaa5450f140
prerequisite-patch-id: 9fda09462a103a1406ae09d07e5f35fb4567f9bd
prerequisite-patch-id: 0c9aed41b91dbced80e5263545f1be091f496b48
prerequisite-patch-id: a91c3133fc4e3ae5662224be4eb0741fbd9ab1ef
prerequisite-patch-id: 928d89375bc60946614fa929c3bd26c0c3a68658
prerequisite-patch-id: c734691ae9518d1d628ee1f50ab94e2bca8d510d
prerequisite-patch-id: e1dc400a4a02effd9adb3d2c28fb44c52615d5b2
prerequisite-patch-id: 8db09fe5d3a46be90ebdf67d57ceae0779c5a8cc

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

