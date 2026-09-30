Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE9ACA5FB1
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 06:35:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C01740A40;
	Wed, 30 Sep 2026 06:35:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qCWX0R63h2bV; Wed, 30 Sep 2026 06:35:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6806240A2B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790750120;
	b=JQgF1Pn8FsN9Xidj0g0+k2Q6zjKvkJ43Mpfv49UGp+ChcWnvTPgsFlFm2APamhVlTgZu
	 MFEzNWvToMrzXEUpyWdTfa01LuijmJe2NnHf70NlntWiuxoU+5GIQmnQckz9l0dx+QfdP
	 Oir3hCLhBNWRDqiUFCZo6nenWM+DJobsgWBtuNoNT/nxSa7rWqPXYIlaPICMxGsTBdMO9
	 IhrNqJzyw2NxgYpLXotqf2x58AnCgRK8XLfC6g/7dLwJRs4k3v4WX6DTzyYquEvAJND8x
	 58qokFdlt88nyHSTUbVYoBtn5Ya2b8mtRMS444h8ZviByaghTKChyAXOHHigNoFbnLg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790750120;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Lhufn/dtDMeeWdyQoJcjkORA5aT+zNTteoNftLQev2M=;
	b=WB3JUFojhpk4GVCwDRVTBQey5+q9e4Eh0c4rbHxqi2xTNrJS3Y1wIjp25Q2MXCuwiiIh
	 3Iqa2slgdgUv0bNLEf+pkP0fGt2Xj2qZuk4pKCUEHzWLDIlVIPullrDmPP7eFNeSODTwR
	 eW5ylNKcfBG/GgshFg+gE3LNfK2xhKPZR33gHgrTxtpcJTVF1gPavkp5i1ZxsuUTj4v8z
	 ZQRWu/7roiUnOpjLvqIYM73nBd0JcvMe1svDRicx39iHevvjGXXZAlJ8B8H+urOFplVNr
	 bJhdFMkpg46u7bjdp0DJR6KJ0GWnZC5wX35w2hQlH35x7KSUAfjnj9vLGxevbnHTJjA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790750120;
	bh=Lhufn/dtDMeeWdyQoJcjkORA5aT+zNTteoNftLQev2M=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p2DdLwTJeF6enoO9nv2S58b0AK/Si5NaLDbQ06RTbez+zDlJdWdA+XmYS9h2ZcBzP
	 qtg14RJInMq4qMWIguuTAdJBjoTs0+FhDJbgTB5mC3l//I6Msw0+sOXjK78xxvHgPu
	 y8Kr4ejag7hx0qAY2ZajdUqdg/mtoA68xpt6D02qi4gheGBOczaLZftJLTx8idDF6Y
	 rtUr22edrSr7Z91iTpvssNFbVlUTzd9EvVwtoECWm/g4/Ca1jI2ft6daq3Ws7z1ul6
	 xNC61GuWVFbq2j6yQB6lox71sHkViIZqLxoUXQw5OJELWDHP6eM7XQkHirpBEqD60e
	 HCY5twhXuHqFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6806240A2B;
	Wed, 30 Sep 2026 06:35:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D33233B
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7AF4780FDE
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3bpZtQBYqy8Z for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 06:35:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8092A80C4E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790750108;
 b=k5WmLuJJLJ94j4dBTaGbnMAOu72lywyd6VGliuIW+Qr14/D9y693MRUz8sYvJc8S51jE
 rqpTC9yXvlxheojd+Ga2lwnGwDqQUftj3nCmRedXoThXDFis/Efqdwwre//zsKJPtwEGH
 Degyxc5MMjNKcZRjqyT59JEhmVjmPmSapkHJ7wBrqI8wKBQceUOj9IbY0AMVa2AVOIqWb
 B9441PV/URiKM1seeq/FNMdb9BEJeb26AqIuKp/J8Sjv0/6ix2rF8kGdcYOrOOPv1VJdD
 xveCuUTmLmtXqkFW6GWySiTe7e2loC3BLtGEMUyrit3IsI/u7pek2ansHbKGvuHOQ1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790750108;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=Lhufn/dtDMeeWdyQoJcjkORA5aT+zNTteoNftLQev2M=;
 b=lxKh4/+Iy3px1lL7Y/ASEVThEC0FH3WSo0DunbIxIoNdoc5xmA4QjmApo8YfLmuVufpE
 ZcKT01Kau+G8wQwvBl4hwn6VXmc/gbYrfEQpswPBFGc17sr/XOQjl+TfrrCyjgoc6MNfe
 vps4wQAHrMfnKIoolO2HAtdogzbsazcqQ0IEkOJNqEalK9vDdGm722mLk6qD8N/0VwFvB
 f77OT2i+Sl7uPJ5DGoEE8xpNEMjGxa1V2HLplxx08oyS3zjCsQf78xUHptbhueOU4S2OG
 CrIgLVr4PAodmHnPAdFtB0IHw7iCfRuCP/8Fl97jjeaZ1kEIKgLfQQxm3UEgwB7UNmg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=DSfjnMYm; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NIGbkztZ; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=DSfjnMYm; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NIGbkztZ
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8092A80C4E
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:08 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U6Gs8R2899513
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Lhufn/dtDMe
 eWdyQoJcjkORA5aT+zNTteoNftLQev2M=; b=DSfjnMYmS+qxFXPzPIXCcw2NpvH
 eDu6A6rESNoo39Q0pHRPrpfIAGTQ5m3EEc6be6MJ4Nujx9RT6Xhw7bTYru1kBRJt
 1jEQxI3TW8dYU8yRmo7xYyiFk31C4XCDC4QkEi/jkNaIL0/qC70w9zOb1TzfNKkg
 KEh4bF1yI4P1XPwFlA6IZyt7nT5jUjj6YLEVHp/gcp5DwVSSRSQfJzTK5tXa2Bae
 snl5A2epvJNABEyhEqBkn0dfGpMpPthRC/zjxQUl7ZxMkGoINzK+zdO4Ud2x5AfQ
 QNfJrgNBWJC95LbuVP/yQAzQ+VO3QR5Go70XZwDQirIoHoK4a5fQOyH+poQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0w14029f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:07 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-34bbf2e3c5cso4368930eec.0
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 23:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790750107; x=1791354907;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Lhufn/dtDMeeWdyQoJcjkORA5aT+zNTteoNftLQev2M=;
 b=NIGbkztZg2SJH5hDdDw3DZZe0BdhZaomN4HFsaeZ50BiEOGq5roYR5RcB7oi7zVO6u
 S4MxPtd1Wng3UX22fNvvbaAq5w/J3G14csgcR8O41aAqFkgK9E39YZBc80d09DBvT2Xx
 roLO2LDQyF8ZTEJaKbxQ2hE+2dtD5AU5UgnM2qi7Xnz+LZjDy+1vpobG6dsDDQRn2Uys
 cCjT08hTC4ObDvgN1qOMYQRmp2YLj5qJ1MkbH/yoKV++DF+xZnHPgySGGwqbZnUU+8vo
 llal8Hg5khLIKNT54viGACS/Pn0AsStfWKFTofYDLs7VDZxcNskA89ZBiWfungw5lSbO
 PzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790750107; x=1791354907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Lhufn/dtDMeeWdyQoJcjkORA5aT+zNTteoNftLQev2M=;
 b=ny7d49n9JDbG0eMPPSrXNbW1dK76NgC7cghipYNymt0EM+aHbtY0nUWMZ7lRydJ2Wz
 LSdEQ2MOUappi8c/H/rnh3r05g6GFzRy5S8bx/HGwfSIi2PurhN15UvBK+ypNmWMmzhi
 +HvA7IT6GAvuEG58Wd6Uf3dSuF9TwsL5TqtiaMCAGrbeMSvjHBxlkq8xGeNWw8OXu7x/
 d2QMNPbNYxQn64AVL+Jbs1cBQv4railjlFhfKOCRUttVwqgKzZwX7u9l7bV+4ouwOlve
 BPI31EWucPilzBEvnCnc+QsDWUF5y6m7HhGCjPzhGEAPvthU5u1mgzxVEQRK+sZ6GFrQ
 Kpmg==
X-Forwarded-Encrypted: i=1;
 AKwUvByhR8YaVeBZeoNSjWG2udbtCNN6lfOU/Pu04nYsUmZAd7VEBzQiFoajZ7YyeXDyYgAo4UnB3Ps=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL//MawQxzFm68HEbvD141juT203o74mAYdyy1lBJNEZCyDPwJ2
 HNn0GDAcAFGQUlPBpepRvaXUC1Kj6C2vFMhPf6UflPnzXewtJQ1WspBqM+D428IaHqkDcomDkWH
 UK7jrwfnmnBYT3fJNQM0jf+lAIR4COmb1i0HX4JcfrVTMusnjnU3iqlw3NR8iyMXNAs9eYK0=
X-Gm-Gg: AYBFou2UZ7GPGVXtVI0x9/QEf5PhKqoyUPGS60qQAJoKhL85e5KCLhXxMkufowHu6I9
 yibGeH88oKzTJNavp3aMVFCBcA6cQVRc8LUlexW5isgGCQkuJqfEr7UIPcDedE5g4rxswIRm3C0
 eNeSTW2vqiPGxCFXRZZoZT+2SsOcLxtkF89/qdddKIMa1/afPD6K/nZ/FDkYUUDy5oUVyG1E5Ob
 y49B2FUQo1AHphInN7l+ue+h1gN2X7HUXQY8CNT/LRGN50F6L4piKejwFcqrYD+nLKyIsBfwnuB
 XfhXLLCNkjH71K4RGhdSfw25oYvRS4KIxoQ9qx0h0OHTcc41DCViTeKqY+nMsENESiDsxtGgovj
 hFpP8mpbl7NxBD1e/e8hRqOD6IyqjXenFIR8eZ5/SgVbJzvZ2
X-Received: by 2002:a05:7301:f2f:b0:34c:853b:fe76 with SMTP id
 5a478bee46e88-34ce0f1cbfemr622157eec.32.1790750106876; 
 Tue, 29 Sep 2026 23:35:06 -0700 (PDT)
X-Received: by 2002:a05:7301:f2f:b0:34c:853b:fe76 with SMTP id
 5a478bee46e88-34ce0f1cbfemr622130eec.32.1790750106194; 
 Tue, 29 Sep 2026 23:35:06 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34cf22f85b7sm1287502eec.3.2026.09.29.23.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 23:35:05 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com,
 balaji.selvanathan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 Michael.Srba@seznam.cz, sjg@chromium.org,
 varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v3 05/12] arm: dts: shikra: retain QUP SPL dependencies
Date: Tue, 29 Sep 2026 23:34:42 -0700
Message-Id: <20260930063449.3251317-6-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930063449.3251317-1-abhilash.v@oss.qualcomm.com>
References: <20260930063449.3251317-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfX2jFdBs7oe81F
 Fe8CS3C1ZFVMHzCqbmMfoyX2xFKF3MWevueZtQLm5h4s5fAdpe2XyzSsUC2i0bE9/xRVw/v1DeF
 fevFt3kbTBidZAFbuv8ILcY9bj32I9Y=
X-Proofpoint-GUID: p2h_XaTGovigq8W2avEntdadCIounfs-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfX/Cq0oiH7qgpE
 GZN9keC+JtlFV8sJHsdJYifUlqV+sciD5mBRNY7g8WKPuY10+ZVe+6YsOcPCrT0UEu2y1J2xIx1
 d1mhaSAd8f/qwwDWLhlLNa6nozFVYbo58WmB08CysfmXzBVwfWYO6EGF4jjq/158NFDrGWLpZhd
 Sq4D555RrD6N5t5jwwVTW/DCOTyHT253Pc2YZYbblPpen+xd9CRAT03NLgeQiuA6PZauTia675S
 25BE3M1D8eCIqJaOAO/ek7LTzCrWLuKI7Az+/orbF5crGYAltGmgBN/3n9N0TJnkY5zlNaatIJo
 lxOY/pkV4EBCeoA/UPKOrguyAp2HQeUOPgL/gexipXhGy1mOnthzYVFR3TBTqwocgDDcSjuPTYN
 eUX4XJJ8RCDl5YTb2O9NCKqApguHOFS8zraC+Fqh4Em65uZkO6EP6Rek+r1Gw+xz/0aedjieemJ
 taR/08RQEfarxvvDzYA==
X-Authority-Analysis: v=2.4 cv=J8Q/fwnS c=1 sm=1 tr=0 ts=6abcad9b cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=mHJ2qds8thx7DnZp6SoA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: p2h_XaTGovigq8W2avEntdadCIounfs-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300026
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

Retain QUP, console, pinctrl, clock, power-domain, RPM,
and MMC dependencies in the SPL device tree so the firmware
loader can use the boot medium once probed in SPL.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/dts/shikra-cqs-evk-u-boot.dtsi | 44 +++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi b/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
index 056268a009d..81aad7289d6 100644
--- a/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
+++ b/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
@@ -25,3 +25,47 @@
 &{/soc@0/sram@c11e000} {
 	compatible = "qcom,shikra-imem", "syscon", "simple-mfd";
 };
+
+/*
+ * Keep SPL console and QUP dependencies.
+ */
+&gcc {
+	bootph-all;
+};
+
+&tlmm {
+	bootph-all;
+};
+
+&qup_uart0_default {
+	bootph-all;
+};
+
+&sdc1_state_on {
+	bootph-all;
+};
+
+&sdc1_state_off {
+	bootph-all;
+};
+
+&sdhc_1 {
+	bootph-all;
+};
+
+&qupv3_0 {
+	bootph-all;
+};
+
+&uart0 {
+	bootph-all;
+};
+
+/* Retain the RPM clock and power-domain providers for boot consumers. */
+&rpmcc {
+	bootph-all;
+};
+
+&rpmpd {
+	bootph-all;
+};
-- 
2.34.1

