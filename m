Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B85606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FlIyXa2D;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NFgBAven;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BcXR28Nd
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2E4560844;
	Wed, 21 Oct 2026 16:10:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eOe6hW5TbszW; Wed, 21 Oct 2026 16:10:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5ADAA60848
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599009;
	b=dWWCjgsUqW05kVTUFWMEj4YIZZTzb0lxfNWYu+OFs5teNzvMl4LAp4udzdc7lPF8Ybdj
	 afgMyuhOEQC3lgIQpPpwFMFsBO7lFMAQyPg/+ik4/wfKHEOaTAOGcNBzEOUXV3OfyPnu5
	 wkNdKKP6vWYtQnRUEfGN9l+AgFDrMsc71xKDxdWQ1PRkFxPjeH0f6aAVtfnpkqNqaD6Ya
	 qdptKT1rY3I9GSjqjoC6DNAuuaYzq90nCblJHEgQDkEq1WlBTgjNRmOJ6y8zu7tZEft34
	 WgZupuGEQCvHtDyjebQbX0VO2UTsOeHg4rGWPdjuIKq6p2QHrmho3fYimWIaYQW2TVw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599009;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7Z46m7LIO/tmInUL6NKQivHfhmeJziXBTlox1j0Yqug=;
	b=RNBgAE98e0pfyLaK5HWFZUnYlHmo8UKl3LsrthebvBR5iCtWTtkISfmN+b5a+3oJHpgK
	 dQgatvHAUw/K8uToCMkI6XZJgn3rM9HuGlO4JnDrGIy1Q/H8gncMomBaBtwPGwWcI642f
	 JZ4xGtBiDGP6lM8pfLSJO8wZ7T0pc2abStZJhi36xpNVOPKnkNlSbyZVDVJqSZhLhph49
	 rSL1/sUyUjglvIAckg0XC0H4cfV9TfNLeDcBxBR5SOMv02+4End/lGyU2kfcKKwn2G/+U
	 F15AW1fIev8tx4cIsOzRCFodOH/ajcINArsBHJJ3XxHPvYqgaFq4UKS/hK0a8Bb7yQA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NFgBAven;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BcXR28Nd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599009;
	bh=7Z46m7LIO/tmInUL6NKQivHfhmeJziXBTlox1j0Yqug=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FlIyXa2DHneu6faeUqpvzaPRv9P8PFhLm9BMLd67PzOuk1HWFAAGcyrMWQityNV0b
	 MrcWq+jGzr0MPlVK/5bFQNY8ohK21sI3n5DTUCt49QyKzIoXYIR+EGIG0AzcBuEi61
	 yDCb6pFu8ofrqCKoLx38KIywoLkXL9FQmCy07OPEqPnl5l9QB2eZCeKSFuK97aEdpB
	 rbos/1Q33/ZonDqMNnux0JfzR5Z//P4Ue2barqbJ+XG00vHxCaBI7LhjkaxO8IyIsc
	 KHTW8e52u4T7m7J8ZkJO9okzLT024biAejZYojEAvDdHOkC6092pYvetjmw4ajrGSA
	 MVuvnFLUst6DQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5ADAA60848;
	Wed, 21 Oct 2026 16:10:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8DB2B356
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8AFA260852
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sKXr7Rxz9mlb for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:10:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 211D360844
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792599007;
 b=KV1c3qixcMTMA0lZb94MSUwOL5kp1p4uCEE+/tnP9Hxp7MtQKfpYK5S0cObmCpItq2TR
 j0GP2NSLd6mswN8s4GQT+YP1cluHwlReI8L9abnRPa6DJqINc5XRPee7RmPwSb9ImPecY
 vUUdDTYh3YxpLzdWfmkClMZPNN4stY44kFg8tG3Z8sIm3ugLq21yX6lySFklWzPp1gC+v
 wry1D3lxz00/9VxCdf4v3ANJ2CIQ9Xx8xZYRLcA2YZuLczils0HZJX0p7ppAVYZ0AGSL9
 WCC7mI7YLffS9eyN7DOOLMgWSTgjAM54/j8wK7mdK3tqOjv4qpBnvsnNeqdEr8gSIZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792599007;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=7Z46m7LIO/tmInUL6NKQivHfhmeJziXBTlox1j0Yqug=;
 b=JL+1+z3tnGsKNfpjrilGtKkE/QckU52ZlDJncnNUDMxl+orKo1aLZ19WIXCO3RAztsd/
 nxRrJzkGN9dKOuT2w5EvemmSXFnsRfJVgzFYOWManL/fh85kQ9Yx8B9/CJhtblqE8YZjv
 9w1plcVHLp9XeU8WfQ2YzzU95dySp3roIPE7ib2mWKsMF+wVjqjlvcHkklVkKKTNEedB8
 y4mmJYSNaZZvxdVUr6UXFSjWUd0mKYhekUug0+GiPEQ+c3+d2K3n/yUfJKzWSOYpsFA7C
 YvNLIYJlCHUrPo7pbme5wR6afuDDL6UGqHt077/8UCy/YLZrxQ+kB9WLkyuPT9tU0FA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=NFgBAven; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=BcXR28Nd; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=NFgBAven; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=BcXR28Nd
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 211D360844
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:06 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFUM9i685610
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7Z46m7LIO/t
 mInUL6NKQivHfhmeJziXBTlox1j0Yqug=; b=NFgBAveneep1Zi5As1Scf7AW8r4
 BlN51RE2FQ+9loXOzQwA6IgDIlF2DqX76ult/kOwLa8z1EwBSX1HPb1VCIjTQLDJ
 jw93wqq+Q4cniIPEksDQDmWb8QSszNwbhtHMJQ4XTPC+gIA+eVw4OknjfoN5m3G5
 /4lGYeCSkhIFMhYQsizmrLt6k4iu/blziNmXEBANz9rXhiv/wOpEtDKfTEPNJULO
 9Ve/vqaaTPR99qDDRGwbY6DIVDU063Aq1g90OFQV0ff1IiOIUJPu05Iigpi9UNOJ
 c2A9RIvUA/j5H27X4F9yINcoSmGSVPZz9fRSlVPExmK4Ih0A9IuLFCmK8ww==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex7vrrtk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:04 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3552883bd19so3235234eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792599003; x=1793203803;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7Z46m7LIO/tmInUL6NKQivHfhmeJziXBTlox1j0Yqug=;
 b=BcXR28NdVN4O6bXaTiWx6D+EO9GIAkijp9tWZHpX0/n3RZ0gND+vTrPRZhUdInMw9b
 6jUhZZLsZbmHdWqeUn+g3POs42HsIVg7pE08oRrr4E+nek3XlAvxPyju5nD9ZQfLv+Jf
 0+gREXOPr6zV/K6QNkQ9qfizc2CiKFVfVlkv1/fAQ0C/8VaWpi5H0CX6zVNQXmaQTta0
 70m8av/3V22mKrliq/KATifH0vwAGtN+9eXtYVFmEXXlkd/Nlja3Fj5GqCoLQJxmJ3nU
 0ej0rqK+bNeHtu5+Z+EPaPgcXGydbejD9McaVEFF4Hib23FXoW7ZsyiVOv1XKcl+RR2r
 QL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792599003; x=1793203803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7Z46m7LIO/tmInUL6NKQivHfhmeJziXBTlox1j0Yqug=;
 b=tVOBVuh4yH+/4oAq6DTbMw1LzcIdoncxB54+bWFVj4AIsI9pscjU69dDHXy46C6zDR
 L2E9xUYrcT1zuAgkh7mdJ899r2EZdSZyxeO7H+xyHSCEmVNtSVZQHYDio5kvlTrrg8I1
 iAEdbwugg+zUNdOAqC3RQv5AMSKxXTSQM8e8CblvSaoIvCh/XofoUVnbzLfntN3mELzm
 MxjbQavbh2Vashrq1BMjSfNEBSh/DiCt6AhTSUnisD+/t9aLPSiYWF90Stlm6Kew3XDg
 URulBLilorIKKWcN+J6aJJ/bxoXBnzw9B+tsFZQ9LqnEF5y8SPE86d6uIpyjb7YdOjkD
 Fz6Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByhG+xKMMNJryy5fh+y3tFjbYil3Pxic1mqvkr36McZCeZMj+hxKqo+9IewA6Y0BN2qlmgoZ1A=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKUnWtVyJ6hGQJwv6QERRv8aWonZd8GNUI3+i8oo0FPO0HFNNii
 rLMYKKY3ZRISJ8FCVn4/03iqdmkp92YQuDrnI/Jctsfwh1Eh3vCRMcEuq4HCOM8gCAhdSblINLS
 E+lbUzFKyLTWCx1VoUHh54fc6h2m7HlqICW+LD1qU5WCT4K47U8vzxjm8Az80NZKRTfrEdiM=
X-Gm-Gg: AYBFou3XMT63fBs5mx6K/K1j9WjIWNnqAsBCVjEs5xlNmiQ7fDOUPq/kM1m9DWh3QCD
 lj5e7jnGeGmWm6HLcXNwuLeG7xXvvrlNe2VrsOCai4sAw7y6yu0B6JZvv8EfMsvCd9JoZ3QFUHD
 KEsMIjCdqqs4NWQ7jzf4WDtoNVjLtZc9RxpS5lZbFbezpiNYmOorExbcvExJiPor7tCR6W604dT
 q2JPQx+UH8G2zB2Kpf4dXoIGe78UJ4qecObuFt0yCb/3mornKZ43bQVrEsS1cunwJTskF6QQ3e0
 uctQa9L6YvN3AkYVH7clKp7uyENIm1/4Pl0alePFfOV9gqsXoi2+NreJorTNEXcALz70CYyHyjx
 ULSNUTSiA4alwPk7KnK4XYLElJ8S0ips6SSG+qk53DTgo3yFrb5k4NumdQU33RIISFgQYaC89c0
 gJ6dwue/bvNOEUMJ2Ht2Q=
X-Received: by 2002:a05:7022:eb42:20b0:144:c12b:4e35 with SMTP id
 a92af1059eb24-190a7f02775mr3075799c88.42.1792599002605; 
 Wed, 21 Oct 2026 09:10:02 -0700 (PDT)
X-Received: by 2002:a05:7022:eb42:20b0:144:c12b:4e35 with SMTP id
 a92af1059eb24-190a7f02775mr3075747c88.42.1792599001720; 
 Wed, 21 Oct 2026 09:10:01 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367405ee5e3sm8216884eec.4.2026.10.21.09.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:10:01 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, Michael.Srba@seznam.cz,
 william.bright@imd-tec.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, nathbappai@gmail.com, macpaul.lin@mediatek.com,
 jbx6244@gmail.com, dlechner@baylibre.com,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v4 05/12] phy: qcom: add QMP USB3 PHY driver for Shikra
Date: Wed, 21 Oct 2026 21:39:09 +0530
Message-Id: <20261021160916.3894471-6-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
References: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pk1barYjSKDDHiqQ95IdfemeODo1Nom_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX80BEYTxVVu/U
 D3xlcdUNuDe1QpWkca30lWjAFvxgr+Un6VFpx8uIuX5PyowuG9uF3zOp6G0579Bl3qajQyIOrPc
 pnKzr07vuLEvTDQL9IgC89ly7tq00oE=
X-Proofpoint-GUID: pk1barYjSKDDHiqQ95IdfemeODo1Nom_
X-Authority-Analysis: v=2.4 cv=e4uT2qp/ c=1 sm=1 tr=0 ts=6ad8e3dd cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=E7ACQvf2dqk3oRFqq0AA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfXzNJJ/4cdyU9M
 8dQiN8GwiKA89jnQtWWOMKnrh9pUKtqch4lGnEgnFPVvGiSpf2TawqX3P03YjEmPkW6U3UZQnYZ
 2BL9G5q1bPPAjHTjX8c/kx69fR8jiR30STxFUgWSJxtQz4/4VUH8vwbh7/E08DGweRPeZKZYYoR
 cO3uYIqiD/1GzSYVk3KJgAIsBzRl5rJZ7j0G+x7UdZevrb8Gyjv/po20X4m4J/rwnugv2f9ROFp
 fA0cQRrMzutN7PlKF18CVWyw8PlGl2Y2FHtIre7c/2RWQXau00pZgXo9G/YY4jQBX5kcHQh8FQD
 YkWltH/gl1T4QzNWHs/xUB5AIc76HLWeY20h2k+tBJJ1eqOUK7yiU55l/lgvlvAKjcff9+4/O5R
 rZJBrx6g5Ql8CigPUuJfLAtPtK0ACI0L+9j4oZcSoqEf6AusRRtc6oNGM+3XMI/EVXX3UEmlupF
 sZOqGmpIXy3NjTFmYIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210064
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Shikra USB3 QMP PHY uses a single-PHY DT binding (#phy-cells = <0>),
which is not supported by the existing QMP combo PHY driver.

Add a dedicated USB3-only QMP PHY driver for Shikra, porting the PHY
initialization sequence and configuration tables from Linux
drivers/phy/qualcomm/phy-qcom-qmp-usbc.c. The driver is selected
through PHY_QCOM_QMP_USB3_LEGACY and enables USB3 PHY bring-up on
Shikra platforms.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/phy/qcom/Kconfig                    |   7 +
 drivers/phy/qcom/Makefile                   |   1 +
 drivers/phy/qcom/phy-qcom-qmp-usb3-legacy.c | 534 ++++++++++++++++++++
 3 files changed, 542 insertions(+)
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-usb3-legacy.c

diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
index 1fdadaccb12..ffb523fffbb 100644
--- a/drivers/phy/qcom/Kconfig
+++ b/drivers/phy/qcom/Kconfig
@@ -32,6 +32,13 @@ config PHY_QCOM_QMP_UFS
 	help
 	  Enable this to support the UFS QMP PHY on various Qualcomm chipsets.
 
+config PHY_QCOM_QMP_USB3_LEGACY
+	bool "Qualcomm QMP USB3-only legacy PHY driver"
+	depends on PHY && ARCH_SNAPDRAGON
+	help
+	  Enable this to support the legacy USB3-only QMP PHY (v3) found on
+	  older Qualcomm chipsets such as QCM2290/QCS615 and derivatives.
+
 config PHY_QCOM_QUSB2
 	bool "Qualcomm USB QUSB2 PHY driver"
 	depends on PHY && ARCH_SNAPDRAGON
diff --git a/drivers/phy/qcom/Makefile b/drivers/phy/qcom/Makefile
index 714013dc572..dfad1f1e56a 100644
--- a/drivers/phy/qcom/Makefile
+++ b/drivers/phy/qcom/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_MSM8916_USB_PHY) += msm8916-usbh-phy.o
 obj-$(CONFIG_PHY_QCOM_QMP_COMBO) += phy-qcom-qmp-combo.o
 obj-$(CONFIG_PHY_QCOM_QMP_PCIE) += phy-qcom-qmp-pcie.o
 obj-$(CONFIG_PHY_QCOM_QMP_UFS) += phy-qcom-qmp-ufs.o
+obj-$(CONFIG_PHY_QCOM_QMP_USB3_LEGACY) += phy-qcom-qmp-usb3-legacy.o
 obj-$(CONFIG_PHY_QCOM_QUSB2) += phy-qcom-qusb2.o
 obj-$(CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2) += phy-qcom-snps-femto-v2.o
 obj-$(CONFIG_PHY_QCOM_SNPS_EUSB2) += phy-qcom-snps-eusb2.o
diff --git a/drivers/phy/qcom/phy-qcom-qmp-usb3-legacy.c b/drivers/phy/qcom/phy-qcom-qmp-usb3-legacy.c
new file mode 100644
index 00000000000..d1aad6e7952
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-usb3-legacy.c
@@ -0,0 +1,534 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <dm/uclass.h>
+#include <generic-phy.h>
+#include <reset.h>
+#include <power/regulator.h>
+#include <usb/tcpm.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <linux/compat.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include <linux/err.h>
+
+#include "phy-qcom-qmp-common.h"
+
+#include "phy-qcom-qmp.h"
+#include "phy-qcom-qmp-pcs-misc-v3.h"
+
+/* QPHY_V3_PCS_MISC_TYPEC_CTRL-equivalent bit, legacy USB3-only PHY */
+#define SW_PORTSELECT_MUX			BIT(1)
+#define SW_PORTSELECT_VAL			BIT(0)
+
+#define PHY_INIT_COMPLETE_TIMEOUT		10000
+
+#define RESET_SETTLE_DELAY_US			10
+
+struct qmp_usb3_legacy_offsets {
+	u16 serdes;
+	u16 tx;
+	u16 rx;
+	u16 tx2;
+	u16 rx2;
+	u16 pcs;
+	u16 pcs_misc;
+};
+
+static const struct qmp_usb3_legacy_offsets qmp_usb3_legacy_offsets_qcm2290 = {
+	.serdes		= 0x000,
+	.tx		= 0x200,
+	.rx		= 0x400,
+	.tx2		= 0x600,
+	.rx2		= 0x800,
+	.pcs_misc	= 0xa00,
+	.pcs		= 0xc00,
+};
+
+static const struct qmp_phy_init_tbl qcm2290_usb3_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CLKBUFLR_EN, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CLK_SELECT, 0x30),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SYS_CLK_CTRL, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_COM_RESETSM_CNTRL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_RESETSM_CNTRL2, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_COM_BG_TRIM, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SVS_MODE_CLK_SEL, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_COM_HSCLK_SEL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DEC_START_MODE0, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START1_MODE0, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START2_MODE0, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START3_MODE0, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CP_CTRL_MODE0, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_CCTRL_MODE0, 0x28),
+	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN0_MODE0, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN1_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CORECLK_DIV, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP1_MODE0, 0x15),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP2_MODE0, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP_EN, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CORE_CLK_EN, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP_CFG, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_MAP, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_BG_TIMER, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_EN_CENTER, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_PER1, 0x31),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_PER2, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_STEP_SIZE1, 0xde),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_STEP_SIZE2, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_IVCO, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CMN_CONFIG, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_INITVAL, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CTRL_BY_PSM, 0x01),
+};
+
+static const struct qmp_phy_init_tbl qcm2290_usb3_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_HIGHZ_DRVR_EN, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RCV_DETECT_LVL_2, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_LANE_MODE_1, 0xc6),
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_TX, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_RX, 0x00),
+};
+
+static const struct qmp_phy_init_tbl qcm2290_usb3_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_FO_GAIN, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_PI_CONTROLS, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_COUNT_LOW, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FO_GAIN, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SO_GAIN, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x75),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL2, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4e),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL4, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x77),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_VGA_CAL_CNTRL2, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_CNTRL, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_DEGLITCH_CNTRL, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_ENABLES, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_MODE_00, 0x00),
+};
+
+static const struct qmp_phy_init_tbl qcm2290_usb3_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXMGN_V0, 0x9f),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V0, 0x17),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V0, 0x0f),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL2, 0x83),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL1, 0x02),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_L, 0x09),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_H_TOL, 0xa2),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_MAN_CODE, 0x85),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG1, 0xd1),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG2, 0x1f),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG3, 0x47),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_WAIT_TIME, 0x75),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_RUN_TIME, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LFPS_TX_ECSTART_EQTLOCK, 0x86),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_PWRUP_RESET_DLY_TIME_AUXCLK, 0x04),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TSYNC_RSYNC_TIME, 0x44),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_L, 0x40),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_H, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RX_SIGDET_LVL, 0x88),
+};
+
+/* Per-compatible config; add a new instance here to support another SoC */
+struct qmp_usb3_legacy_cfg {
+	const struct qmp_usb3_legacy_offsets *offsets;
+
+	const struct qmp_phy_init_tbl *serdes_tbl;
+	int serdes_tbl_num;
+	const struct qmp_phy_init_tbl *tx_tbl;
+	int tx_tbl_num;
+	const struct qmp_phy_init_tbl *rx_tbl;
+	int rx_tbl_num;
+	const struct qmp_phy_init_tbl *pcs_tbl;
+	int pcs_tbl_num;
+
+	/* clock names fetched by clk_get_by_name(); "pipe" is fetched separately */
+	const char * const *clk_list;
+	int num_clks;
+
+	const char * const *vreg_list;
+	int num_vregs;
+};
+
+static const char * const shikra_usb3_clk_l[] = {
+	"cfg_ahb", "ref", "com_aux",
+};
+
+static const struct qmp_usb3_legacy_cfg shikra_usb3phy_cfg = {
+	.offsets	= &qmp_usb3_legacy_offsets_qcm2290,
+	.serdes_tbl	= qcm2290_usb3_serdes_tbl,
+	.serdes_tbl_num	= ARRAY_SIZE(qcm2290_usb3_serdes_tbl),
+	.tx_tbl		= qcm2290_usb3_tx_tbl,
+	.tx_tbl_num	= ARRAY_SIZE(qcm2290_usb3_tx_tbl),
+	.rx_tbl		= qcm2290_usb3_rx_tbl,
+	.rx_tbl_num	= ARRAY_SIZE(qcm2290_usb3_rx_tbl),
+	.pcs_tbl	= qcm2290_usb3_pcs_tbl,
+	.pcs_tbl_num	= ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
+	.clk_list	= shikra_usb3_clk_l,
+	.num_clks	= ARRAY_SIZE(shikra_usb3_clk_l),
+	.vreg_list	= NULL,
+	.num_vregs	= 0,
+};
+
+static const char * const talos_usb3_clk_l[] = {
+	"aux", "ref", "cfg_ahb",
+};
+
+static const char * const talos_usb3_vreg_l[] = {
+	"vdda-phy-supply", "vdda-pll-supply",
+};
+
+static const struct qmp_usb3_legacy_cfg talos_usb3phy_cfg = {
+	.offsets	= &qmp_usb3_legacy_offsets_qcm2290,
+	.serdes_tbl	= qcm2290_usb3_serdes_tbl,
+	.serdes_tbl_num	= ARRAY_SIZE(qcm2290_usb3_serdes_tbl),
+	.tx_tbl		= qcm2290_usb3_tx_tbl,
+	.tx_tbl_num	= ARRAY_SIZE(qcm2290_usb3_tx_tbl),
+	.rx_tbl		= qcm2290_usb3_rx_tbl,
+	.rx_tbl_num	= ARRAY_SIZE(qcm2290_usb3_rx_tbl),
+	.pcs_tbl	= qcm2290_usb3_pcs_tbl,
+	.pcs_tbl_num	= ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
+	.clk_list	= talos_usb3_clk_l,
+	.num_clks	= ARRAY_SIZE(talos_usb3_clk_l),
+	.vreg_list	= talos_usb3_vreg_l,
+	.num_vregs	= ARRAY_SIZE(talos_usb3_vreg_l),
+};
+
+struct qmp_usb3_legacy {
+	struct udevice *dev;
+	void __iomem *serdes;
+	void __iomem *tx;
+	void __iomem *rx;
+	void __iomem *tx2;
+	void __iomem *rx2;
+	void __iomem *pcs;
+	void __iomem *pcs_misc;
+	struct clk *clks;
+	struct clk pipe_clk;
+	int num_clks;
+	struct reset_ctl_bulk resets;
+	struct udevice **vregs;
+	int num_vregs;
+	const struct qmp_usb3_legacy_cfg *cfg;
+};
+
+static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
+{
+	u32 reg;
+
+	reg = readl(base + offset);
+	reg |= val;
+	writel(reg, base + offset);
+	readl(base + offset);
+}
+
+static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
+{
+	u32 reg;
+
+	reg = readl(base + offset);
+	reg &= ~val;
+	writel(reg, base + offset);
+	readl(base + offset);
+}
+
+/* Quiesce the PHY; shared by power_off() and power_on()'s error path */
+static void qmp_usb3_legacy_quiesce(struct qmp_usb3_legacy *qmp)
+{
+	qphy_clrbits(qmp->pcs, QPHY_V3_PCS_START_CONTROL, SERDES_START | PCS_START);
+	qphy_setbits(qmp->pcs, QPHY_V3_PCS_SW_RESET, SW_RESET);
+	qphy_clrbits(qmp->pcs, QPHY_V3_PCS_POWER_DOWN_CONTROL, SW_PWRDN);
+}
+
+/* Fixed orientation by default; use TCPM orientation if available */
+static u32 qmp_usb3_legacy_get_portselect(struct qmp_usb3_legacy *qmp)
+{
+	u32 val = SW_PORTSELECT_MUX;
+
+	if (IS_ENABLED(CONFIG_TYPEC_TCPM)) {
+		struct udevice *tcpm_dev;
+		enum typec_orientation orientation;
+		int ret;
+
+		ret = uclass_first_device_check(UCLASS_TCPM, &tcpm_dev);
+		if (!ret && tcpm_dev) {
+			orientation = tcpm_get_orientation(tcpm_dev);
+			if (orientation == TYPEC_ORIENTATION_REVERSE)
+				val |= SW_PORTSELECT_VAL;
+		}
+	}
+
+	return val;
+}
+
+static int qmp_usb3_legacy_power_on(struct phy *phy)
+{
+	struct qmp_usb3_legacy *qmp = dev_get_priv(phy->dev);
+	const struct qmp_usb3_legacy_cfg *cfg = qmp->cfg;
+	void __iomem *status;
+	u32 val;
+	int ret;
+
+	qphy_setbits(qmp->pcs, QPHY_V3_PCS_POWER_DOWN_CONTROL, SW_PWRDN);
+
+	writel(qmp_usb3_legacy_get_portselect(qmp), qmp->pcs_misc);
+
+	qmp_configure(qmp->dev, qmp->serdes, cfg->serdes_tbl, cfg->serdes_tbl_num);
+
+	ret = clk_enable(&qmp->pipe_clk);
+	if (ret) {
+		dev_err(qmp->dev, "pipe_clk enable failed err=%d\n", ret);
+		return ret;
+	}
+
+	qmp_configure_lane(qmp->dev, qmp->tx, cfg->tx_tbl, cfg->tx_tbl_num, 1);
+	qmp_configure_lane(qmp->dev, qmp->rx, cfg->rx_tbl, cfg->rx_tbl_num, 1);
+
+	qmp_configure_lane(qmp->dev, qmp->tx2, cfg->tx_tbl, cfg->tx_tbl_num, 2);
+	qmp_configure_lane(qmp->dev, qmp->rx2, cfg->rx_tbl, cfg->rx_tbl_num, 2);
+
+	qmp_configure(qmp->dev, qmp->pcs, cfg->pcs_tbl, cfg->pcs_tbl_num);
+
+	qphy_clrbits(qmp->pcs, QPHY_V3_PCS_SW_RESET, SW_RESET);
+
+	qphy_setbits(qmp->pcs, QPHY_V3_PCS_START_CONTROL, SERDES_START | PCS_START);
+
+	status = qmp->pcs + QPHY_V3_PCS_PCS_STATUS;
+	ret = readl_poll_timeout(status, val, !(val & PHYSTATUS),
+				 PHY_INIT_COMPLETE_TIMEOUT);
+	if (ret) {
+		dev_err(qmp->dev, "phy initialization timed-out\n");
+		clk_disable(&qmp->pipe_clk);
+		qmp_usb3_legacy_quiesce(qmp);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int qmp_usb3_legacy_power_off(struct phy *phy)
+{
+	struct qmp_usb3_legacy *qmp = dev_get_priv(phy->dev);
+
+	clk_disable(&qmp->pipe_clk);
+	qmp_usb3_legacy_quiesce(qmp);
+
+	return 0;
+}
+
+static void qmp_usb3_legacy_clk_disable_upto(struct qmp_usb3_legacy *qmp, int upto)
+{
+	int i;
+
+	for (i = 0; i < upto; i++)
+		clk_disable(&qmp->clks[i]);
+}
+
+static int qmp_usb3_legacy_clk_init(struct qmp_usb3_legacy *qmp)
+{
+	const struct qmp_usb3_legacy_cfg *cfg = qmp->cfg;
+	struct udevice *dev = qmp->dev;
+	int num = cfg->num_clks;
+	int i, ret;
+
+	qmp->clks = devm_kcalloc(dev, num, sizeof(*qmp->clks), GFP_KERNEL);
+	if (!qmp->clks)
+		return -ENOMEM;
+
+	qmp->num_clks = 0;
+
+	for (i = 0; i < num; i++) {
+		ret = clk_get_by_name(dev, cfg->clk_list[i], &qmp->clks[i]);
+		if (ret) {
+			dev_err(dev, "failed to get %s clock: %d\n",
+				cfg->clk_list[i], ret);
+			qmp_usb3_legacy_clk_disable_upto(qmp, i);
+			return ret;
+		}
+
+		ret = clk_enable(&qmp->clks[i]);
+		if (ret) {
+			dev_err(dev, "failed to enable %s clock: %d\n",
+				cfg->clk_list[i], ret);
+			qmp_usb3_legacy_clk_disable_upto(qmp, i);
+			return ret;
+		}
+	}
+	qmp->num_clks = num;
+
+	ret = clk_get_by_name(dev, "pipe", &qmp->pipe_clk);
+	if (ret) {
+		dev_err(dev, "failed to get pipe clock: %d\n", ret);
+		qmp_usb3_legacy_clk_disable_upto(qmp, qmp->num_clks);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int qmp_usb3_legacy_vreg_init(struct qmp_usb3_legacy *qmp)
+{
+	const struct qmp_usb3_legacy_cfg *cfg = qmp->cfg;
+	struct udevice *dev = qmp->dev;
+	int i, ret;
+
+	qmp->num_vregs = 0;
+
+	if (!cfg->num_vregs)
+		return 0;
+
+	qmp->vregs = devm_kcalloc(dev, cfg->num_vregs, sizeof(*qmp->vregs), GFP_KERNEL);
+	if (!qmp->vregs)
+		return -ENOMEM;
+
+	for (i = 0; i < cfg->num_vregs; i++) {
+		ret = device_get_supply_regulator(dev, cfg->vreg_list[i], &qmp->vregs[i]);
+		if (ret) {
+			dev_err(dev, "failed to get regulator %s: %d\n",
+				cfg->vreg_list[i], ret);
+			return ret;
+		}
+	}
+
+	qmp->num_vregs = cfg->num_vregs;
+	return 0;
+}
+
+static int qmp_usb3_legacy_vreg_enable(struct qmp_usb3_legacy *qmp)
+{
+	int i, ret;
+
+	for (i = 0; i < qmp->num_vregs; i++) {
+		ret = regulator_set_enable(qmp->vregs[i], true);
+		if (ret) {
+			dev_err(qmp->dev, "failed to enable regulator %d: %d\n", i, ret);
+			while (--i >= 0)
+				regulator_set_enable(qmp->vregs[i], false);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void qmp_usb3_legacy_vreg_disable(struct qmp_usb3_legacy *qmp)
+{
+	int i;
+
+	for (i = qmp->num_vregs - 1; i >= 0; i--)
+		regulator_set_enable(qmp->vregs[i], false);
+}
+
+static int qmp_usb3_legacy_parse_dt(struct qmp_usb3_legacy *qmp)
+{
+	const struct qmp_usb3_legacy_cfg *cfg = qmp->cfg;
+	const struct qmp_usb3_legacy_offsets *offs = cfg->offsets;
+	struct udevice *dev = qmp->dev;
+	void __iomem *base;
+	int ret;
+
+	base = (void __iomem *)dev_read_addr(dev);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	qmp->serdes = base + offs->serdes;
+	qmp->tx = base + offs->tx;
+	qmp->rx = base + offs->rx;
+	qmp->tx2 = base + offs->tx2;
+	qmp->rx2 = base + offs->rx2;
+	qmp->pcs = base + offs->pcs;
+	qmp->pcs_misc = base + offs->pcs_misc;
+
+	ret = qmp_usb3_legacy_vreg_init(qmp);
+	if (ret)
+		return ret;
+
+	ret = qmp_usb3_legacy_vreg_enable(qmp);
+	if (ret)
+		return ret;
+
+	ret = reset_get_bulk(dev, &qmp->resets);
+	if (ret) {
+		dev_err(dev, "failed to get resets: %d\n", ret);
+		goto err_disable_vregs;
+	}
+
+	ret = reset_assert_bulk(&qmp->resets);
+	if (ret) {
+		dev_err(dev, "failed to assert resets: %d\n", ret);
+		goto err_disable_vregs;
+	}
+
+	udelay(RESET_SETTLE_DELAY_US);
+
+	ret = reset_deassert_bulk(&qmp->resets);
+	if (ret) {
+		dev_err(dev, "failed to deassert resets: %d\n", ret);
+		goto err_assert_resets;
+	}
+
+	ret = qmp_usb3_legacy_clk_init(qmp);
+	if (ret)
+		goto err_assert_resets;
+
+	return 0;
+
+err_assert_resets:
+	reset_assert_bulk(&qmp->resets);
+err_disable_vregs:
+	qmp_usb3_legacy_vreg_disable(qmp);
+
+	return ret;
+}
+
+static int qmp_usb3_legacy_probe(struct udevice *dev)
+{
+	struct qmp_usb3_legacy *qmp = dev_get_priv(dev);
+
+	qmp->dev = dev;
+	qmp->cfg = (const struct qmp_usb3_legacy_cfg *)dev_get_driver_data(dev);
+	if (!qmp->cfg) {
+		dev_err(dev, "failed to get PHY configuration\n");
+		return -EINVAL;
+	}
+
+	return qmp_usb3_legacy_parse_dt(qmp);
+}
+
+static struct phy_ops qmp_usb3_legacy_ops = {
+	.power_on = qmp_usb3_legacy_power_on,
+	.power_off = qmp_usb3_legacy_power_off,
+};
+
+static const struct udevice_id qmp_usb3_legacy_ids[] = {
+	{
+		.compatible = "qcom,shikra-qmp-usb3-phy",
+		.data = (ulong)&shikra_usb3phy_cfg,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(qcom_qmp_usb3_legacy_phy) = {
+	.name = "qcom-qmp-usb3-legacy-phy",
+	.id = UCLASS_PHY,
+	.of_match = qmp_usb3_legacy_ids,
+	.ops = &qmp_usb3_legacy_ops,
+	.probe = qmp_usb3_legacy_probe,
+	.priv_auto = sizeof(struct qmp_usb3_legacy),
+};
-- 
2.34.1

