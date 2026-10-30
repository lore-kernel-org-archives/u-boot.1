Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE19606A31D
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 13:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ct1DSzwk;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Au+REVpo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZwL/qZHc
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 755848111E;
	Fri, 30 Oct 2026 13:42:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nHD5GNUkW-IV; Fri, 30 Oct 2026 13:42:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BD27181127
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793367737;
	b=svST/+49tbN/vTFjQrZihkGF/Ztem7gf+/k4Gi+jban9MBbIrWeMPVgH9fUwEAzDjjTy
	 2I3rbxdA0hJwTiZL9/o710B6x+mH0IKIwIOvYhId0g4ue6TiGEvXCUgXvAIM/k+zS9qgn
	 RsPjJ6FODBFwrRYPgixLWAUtqM5q+z+EMUGbdCu05bG5fSkBoVGzz5xxusiMvdg0Ktn8W
	 KIPgof/zmKVBulkQlIlYw46uQhBb8Ndhs8AdGEEaxSXmjuyx0/4VAEYivpEPUeVNlNyiQ
	 1S9R19045sK2n4vA1/S5z2+2Q5cxhOtcQN9qrsezqI2vRwuYdvtvZqkSHk5cfex5Lzw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793367737;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RJnV1XhhnK1+X8pCbaf3X2C1sEmIOp/I+rMxTzZN1xM=;
	b=BxoRvZpg2c5s1y3JFiIy8itchgR74fIXWV/npjXQ4iMETZsFtbMoNtdrJaLzdGUHlz1r
	 4iH+c73YHiGEuxmAmmDnvU/hzPtBbH5VdbtX1mEGwgADDgC0q14lH52RIc744QqSSolxq
	 MGETVIaA7um7lURcj12Y14+BlrNPFU1493XWiln8JdhHWogiNrgEdzsmKCZvCb+kG/Ozk
	 aGQBnCftGTL9SBvQ7w8WAxlPHKojSTkePa6tIx28rN0ISgYYmgB0P5IxEsl9tzrKXUJJm
	 z5J6jHvsLViCVxCn1rmzkxrOErxqmO8X57V+yoveOK/rUA8+SA3qyzxmfobCpyCPQHg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Au+REVpo;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="ZwL/qZHc";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793367737;
	bh=RJnV1XhhnK1+X8pCbaf3X2C1sEmIOp/I+rMxTzZN1xM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ct1DSzwkTPlIqgNX3CcJtDJ1RNLVXb1ncLBMDrtjy001LLDN/iYBdBm2rJ8kGZEQv
	 fcfv0mzeZWRt5kLwU/HUnPYAwnEPBRxAUh+DWolWHBqGp5bwegLgXqMeMPjFZLe3XZ
	 gXk9lzWzv6krZhqgI9FS8FgKPO+EsLvohy6vWHyYp6y8CLU+uz/OfKv/0KNn6bhAsx
	 DlhZ3bxtPTqlhPsHhtYrXbEjAXigJHI6r+EDE8938idxfjYWJSkPwm9AlbozFJUZqq
	 CtWzCC/FJRL9wdDMbV46e/DF/vQfWzgNsbrYzVp8+tm6MyNPESXJTceSoAzDr97LRH
	 tiHiyXGhoGb+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD27181127;
	Fri, 30 Oct 2026 13:42:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CCED1529
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 13:42:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C9CB08112A
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 13:42:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iAInROu8X0Xr for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 13:42:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4573C81127
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793367734;
 b=mgotAe3KG2HBz6tqylZoeESYIVdRi1Y9k+UgQr46XFLThmThgwgRUbswrqcUHgmDHzEm
 DJ2XKBRBuE73Ev1v6Hgbr46qV7jrIRTFvHMgEeWZBHmIJ9QJxeLTBbHA3inqfKtyzAhOd
 KE5n3BaEhBP1YuiM7BFEwisVbO9lYGs+WIH5feDqNXhO0MCmExiE5pn9s+0pJWomi1bQd
 n5HYDW4xw2EiC93wvVfX8gjLQYtDTRHp5o1SMGmDDJE9H1PJZ/BNmrozLNYZVcc20sHER
 Ya/dOknCSfvoRWsJgm0Go7Ty6sF1/j9aTBPN/3NrKPqnlpYgpSYEBfnwn/EBN8UftKw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793367734;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=RJnV1XhhnK1+X8pCbaf3X2C1sEmIOp/I+rMxTzZN1xM=;
 b=WGhWG/wlvdOhlyELy6ZeeMnAWxV7PuOCMLMsx71dRFEHdZnrIC6/j+8yFx/ke70zr8em
 vmpdt4L8gmNR29tRWz85p6Twu26yZjFeQ7YzHcyGCxneBjW1Rq8UNDkYdBnye1yT8gTp0
 sDTayz/IBFbDRzeJBaeUzGQo4N5j6hUN5HWWZm4Jkc0ZLK5GSgR8I9BKa4bQiQkAcCwad
 AOR5fcsdjrgXh4t/nbljpCDgfe6wy7aDw1fI0ZCYuVNO/w6H98k8mtIHwjqYOxWunzS9O
 TB/p61PPQWyv90abb75qXhND2+dNpidj0m2aAdBN97jh5WvLQLppoM6YnfzqnB0Ug9g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Au+REVpo; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="ZwL/qZHc"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Au+REVpo; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ZwL/qZHc
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4573C81127
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 13:42:12 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBGE122784155
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 13:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=RJnV1XhhnK1
 +X8pCbaf3X2C1sEmIOp/I+rMxTzZN1xM=; b=Au+REVpoVujr2yjUNwIXClEGLwY
 j/GiStAObiJQEB0wOnVBhWA/lIFzzukY6xHOe/dI3yMMLZKY6SsxzV2fFC1C6uiu
 uNCB2OU7/aGiBQYZy7uE0CLEgWGYW56ufBJB+ofACnZ/NmdSB08xL+TiVs8dcnnP
 Y1s8yzalvElxh7kwoo+pH/C6U+npRCMmBIprlJg0N71nFVmBiPAyq8eHcw8HhPEP
 8uv3LojYwA9sSmZfOBdtdY6FUz7Zw5xxptbQpD2t+PhfaDoJ2LG/ShGMEjNHnAyz
 vQxUxrrgHdOmEAFjmA+xEVSdHgW60T7RTbm32IGp28sRYK7InPx1HpAUk2g==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qk93k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 13:42:11 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-18eb2616974so2290256c88.1
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793367731; x=1793972531;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RJnV1XhhnK1+X8pCbaf3X2C1sEmIOp/I+rMxTzZN1xM=;
 b=ZwL/qZHcM21g58nsn2xdT4p4CTbcmN3yP3zF5EjzSKuHZr5iniC/IRgu5K20b14AgX
 7Vd+bmYkwhx5zGG42MHJkGHCCO2n29M9qCUMWSgARPiVrzYMPgxI1JINVrCee6di9iFB
 Ohh6D+bglbuQrkygWRnODO1kiPmS5UDwPAkKbiEzO0XOSDCQZ2vj67iXZbjAkOka+yDn
 f+ZaTMvsOr3hMCmULUOC4SSPz2Kcxuk/tWnr/mzd46FHE84H+r5s1wsgdP6U2/phX4cn
 Bxlp8ccTIicp6TFFy0RejzeikYZE1QxaqaDRyw3UmnFS8HB2v4sm0fuonMp22pXScTJV
 JaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793367731; x=1793972531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RJnV1XhhnK1+X8pCbaf3X2C1sEmIOp/I+rMxTzZN1xM=;
 b=01NR8RO/7O+9/9I4t+8iQdS7zMwvJltgCAn/ervrNQB49g+X2Eoe+GwrUeDWOYtB5T
 ZwJSHOmhkTqj1JjjNk/zxLeckjZwk82wP0gtZgSs4pHKLtXjjrFcDK7tSLcqH/gomzua
 lhq3JGEelUPjLl+45a/FDymVSFv/GOdhr1GhNmVH1XSF7ciQuMXF85Ze9E65U0frRZ/e
 d0tE2902rWzFXYQSXBiP93tpzpD1EO4MykJrm8QHtd0TiZcTkboffDq+i14117Zjs+V6
 4WQU5yEGWVb53WC78A7xsq96V/9Y8eoluk6vQ94+5c9b9AkQlhzZa/xl2vg9YTV7oQ+K
 6mlw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwgAZNRxgjRssNzbXPUKCgiygC1vf+mpkRHTEmWL0lWIG4I8bB4OwaXb/LNIgtR6JkC14hSyoY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJu/CGR7aDFVDLcX7bM5X9TjDpE3nyoQ/1Rd+s5SXAMzGALt8VB
 Fnm7mwjgKtxqws8TStR+Dob6SumcprbpoIuDGeOki7gDwwYtOCg7TPG7rT5K6inAi/TKCec1D7O
 ZTuT38ps4j6URV+rdVFpgHF9CrZyhW3jwXC5wVxVMKtLsERMYzPSRijkeJXEIkGJwf3QlRa4=
X-Gm-Gg: AYBFou2LawAXBqb+BzAUcQwPL6noQuZI3pPnRGeXtzMVHChk99om2vlv/9GsH79j3GG
 sKjqTpOAuTLyfPMowm4vhUV7rJ4vBZnj6Mv4tPSSHXPAZFnQdK7U7Isn2p8Yt/lJjOPDwEdFs1N
 DFPD7aLO2qzDAfNVIKL7rxjHKC1CIwjVZSRut6gG0KzGkzsk40BKLvKZSeDmpAIzs7/I6ZWRR99
 K6y4DNdBKoAHRXa9cDpdgO/BtwiQBQ8aRFy3rj6Jj4jR4xCf3eKb8w5+Gw9WiHrAs0Fis7K5Sx9
 05PtNDnDWGL6ORu+jqNQBNuBKUpx6SrqWc8Jr/nPcsNAbH22CQSfLxXkpHMpHZ9nuH8cbjMBN5T
 +5XJml83fkAIeWvpYDP81xmGO4IHdgiLOdD/Wi40Xy+x6MA768eYRcoMJDvT3RGYR30xUn8haNR
 zgmAtS6r37aLIGuUdESl6ssqu0sJ5jVBgMKGlx6cM72/lMIwANx8TkyIKXH9cmuzN6zmki
X-Received: by 2002:a05:701a:c905:b0:143:2984:6517 with SMTP id
 a92af1059eb24-1ac5cb187e8mr2908922c88.38.1793367730059; 
 Fri, 30 Oct 2026 06:42:10 -0700 (PDT)
X-Received: by 2002:a05:701a:c905:b0:143:2984:6517 with SMTP id
 a92af1059eb24-1ac5cb187e8mr2908837c88.38.1793367728797; 
 Fri, 30 Oct 2026 06:42:08 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac192c2e9dsm9610667c88.9.2026.10.30.06.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 06:42:08 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 balaji.selvanathan@oss.qualcomm.com, nathbappai@gmail.com,
 Michael.Srba@seznam.cz, aswin.murugan@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Cc: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: [PATCH v3 1/2] mmc: msm_sdhci: add HS200/HS400 support
Date: Fri, 30 Oct 2026 19:11:44 +0530
Message-Id: <20261030134145.2349821-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030134145.2349821-1-aswin.murugan@oss.qualcomm.com>
References: <20261030134145.2349821-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KsrYSmWN c=1 sm=1 tr=0 ts=6ae49eb3 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=oOT5koXK0pyM7OHz8pcA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: DiBZ3KcaARsHRuLq695hbyUW5lgsfx-I
X-Proofpoint-GUID: DiBZ3KcaARsHRuLq695hbyUW5lgsfx-I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1NCBTYWx0ZWRfX2oxvRJGJ+0N6
 f8Ufg0wVtC/QpKW5M/kD0E2l0TEIA85363VJPWxw8tk6crNS/L0f5qyk1wtmifEAt8Q6iQ0droo
 kaziN/bjyy5XKlthPoViE0Bt4vU/YlbMfMuIGUpnaa0udRD01CD3oSzRGsFraBLBcZLGvkYOMON
 kro9TZ8SNRElVQ7ga5lHrh2Mtab/kqYYgfUzRnuic408anRPqLeuktiDT1N/0QeYYjiaKF96kPp
 JvdSFKDAt4BMcOvn6l1s2SXKa01CrF5k139v5au8qZWsXgM5H6iLuDgylhvsfs2nUSih4UYRuOA
 6+/1/ZO/V7CcJDHvectp/vIkTi3JtLScu2irKLESHCv//YFYHVVIvcT1pdS6s+ITr96W9nSLx3f
 jmv8CfngPTjsL6fg+9yF0SRR6jd2GFRKxlFTGuJ9En3ge5Oz5RzoSbydweqtPOVDx8orwrjTaDl
 McU9VQvf7gsnN857NyQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1NCBTYWx0ZWRfX41oChC7MF6Av
 eoPPg0Lkmajc0iv2keBJPk4qCaCN3+fckViuDhLAi3iLoZz9yUw5hWcvu9vGXsl9kbx70mdiRco
 IuYf8xT/EI9r+oOe3C33pUB0SzLqdYE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300054
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

The Qualcomm SDHCI driver lacked DLL init/calibration and tuning
support, so it never negotiated above high-speed/DDR52. Add the
CM_DLL init/phase-tuning sequence for HS200 and the SDC4 DLL
calibration for HS400, matching the SDCC core generation variants
already distinguished in this driver.

Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Change in v3:
- guard execute_tuning under CONFIG_MMC_SUPPORTS_TUNING to fix
  undefined reference to mmc_send_tuning when tuning is disabled	
---
 drivers/mmc/msm_sdhci.c | 749 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 748 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 9cc11a5e269..6842512b6ed 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -15,7 +15,9 @@
 #include <wait_bit.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
+#include <linux/iopoll.h>
 #include <power/regulator.h>
+#include <memalign.h>
 
 /* Non-standard registers needed for SDHCI startup */
 #define SDCC_MCI_POWER   0x0
@@ -38,6 +40,52 @@
 #define CORE_DLL_PDN		BIT(29)
 #define CORE_DLL_RST		BIT(30)
 
+/* DLL configuration */
+#define CORE_DLL_EN		BIT(16)
+#define CORE_CDR_EN		BIT(17)
+#define CORE_CK_OUT_EN		BIT(18)
+#define CORE_CDR_EXT_EN		BIT(19)
+#define CORE_DLL_LOCK		BIT(7)
+#define CORE_CMD_DAT_TRACK_SEL	BIT(0)
+
+#define CDR_SELEXT_SHIFT	20
+#define CDR_SELEXT_MASK		(0xf << CDR_SELEXT_SHIFT)
+
+/* MCLK frequency selection (CMUX_SHIFT_PHASE) - required for the DLL to lock */
+#define CMUX_SHIFT_PHASE_SHIFT	24
+#define CMUX_SHIFT_PHASE_MASK	(7 << CMUX_SHIFT_PHASE_SHIFT)
+
+/* 14LPP DLL reset / Tassadar DLL extras, for SDCC minor >= 0x42 / 0x71 */
+#define CORE_DLL_CLOCK_DISABLE	BIT(21)
+
+#define DLL_USR_CTL_POR_VAL	0x10800
+#define ENABLE_DLL_LOCK_STATUS	BIT(26)
+#define FINE_TUNE_MODE_EN	BIT(27)
+#define BIAS_OK_SIGNAL		BIT(29)
+
+#define DLL_CONFIG_3_LOW_FREQ_VAL	0x08
+#define DLL_CONFIG_3_HIGH_FREQ_VAL	0x10
+
+#define CORE_CLK_PWRSAVE	BIT(1)
+
+/* Timing mode selection */
+#define CORE_HC_MCLK_SEL_DFLT	(2 << 8)
+#define CORE_HC_MCLK_SEL_HS400	(3 << 8)
+#define CORE_HC_MCLK_SEL_MASK	(3 << 8)
+#define CORE_HC_SELECT_IN_EN	BIT(18)
+#define CORE_HC_SELECT_IN_HS400	(6 << 19)
+#define CORE_HC_SELECT_IN_MASK	(7 << 19)
+
+/* HS400 DDR/SDC4 DLL calibration, needed alongside the SDR CM_DLL above */
+#define CORE_DDR_CAL_EN		BIT(0)
+#define CORE_DDR_DLL_LOCK	BIT(11)
+#define CORE_PWRSAVE_DLL	BIT(3)
+#define CORE_CMDIN_RCLK_EN	BIT(1)
+#define DDR_CONFIG_POR_VAL	0x80040873
+
+#define CORE_FREQ_100MHZ	(100 * 1000000)
+#define MAX_PHASES		16
+
 #define MHZ(X) ((X) * 1000000UL)
 
 struct msm_sdhc_plat {
@@ -50,14 +98,39 @@ struct msm_sdhc {
 	void *base;
 	struct clk_bulk clks;
 	struct udevice *vqmmc;
+
+	/* HS200/HS400 tuning and calibration state */
+	bool tuning_done;
+	bool calibration_done;
+	u8 saved_tuning_phase;
+
+	/* DLL init sequence variant selection, from the SDCC core version */
+	u32 dll_config;		/* qcom,dll-config DT override, 0 if absent */
+	bool use_14lpp_dll_reset;	/* core_minor >= 0x42 */
+	bool uses_tassadar_dll;		/* core_minor >= 0x71 */
+
+	/* HS400 support */
+	bool use_cdclp533;		/* core_minor < 0x34, legacy calibration path */
+	bool updated_ddr_cfg;		/* core_minor >= 0x49 */
+	u32 ddr_config;			/* qcom,ddr-config DT override, else POR value */
 };
 
 struct msm_sdhc_variant_info {
 	bool mci_removed;
 
 	u32 core_dll_config;
+	u32 core_dll_status;
+	u32 core_dll_config_2;
+	u32 core_dll_config_3;
+	u32 core_dll_usr_ctl; /* Present on SDCC5.1 onwards */
 	u32 core_vendor_spec;
 	u32 core_vendor_spec_capabilities0;
+
+	/* HS400 DDR/SDC4 calibration registers */
+	u32 core_ddr_200_cfg;
+	u32 core_vendor_spec3;
+	u32 core_ddr_config_old; /* Applicable to sdcc minor ver < 0x49; 0 if N/A */
+	u32 core_ddr_config;
 };
 
 static int msm_sdc_clk_init(struct udevice *dev)
@@ -149,12 +222,626 @@ static int msm_sdc_mci_init(struct msm_sdhc *prv)
 	return 0;
 }
 
+static int msm_dll_poll_ck_out_en(struct sdhci_host *host, u8 poll)
+{
+	u32 ck_out_en;
+	struct udevice *dev = host->mmc->dev;
+	const struct msm_sdhc_variant_info *var_info =
+		(void *)dev_get_driver_data(dev);
+	int ret;
+
+	ret = read_poll_timeout(readl, ck_out_en,
+				(!!(ck_out_en & CORE_CK_OUT_EN) == poll),
+				1, 50,
+				host->ioaddr + var_info->core_dll_config);
+	if (ret) {
+		printf("%s: CK_OUT_EN bit is not %d\n",
+		       host->name, poll);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int msm_config_cm_dll_phase(struct sdhci_host *host, u8 phase)
+{
+	int rc;
+	static const u8 grey_coded_phase_table[] = {
+		0x0, 0x1, 0x3, 0x2, 0x6, 0x7, 0x5, 0x4,
+		0xc, 0xd, 0xf, 0xe, 0xa, 0xb, 0x9, 0x8
+	};
+	u32 config;
+	struct udevice *dev = host->mmc->dev;
+	const struct msm_sdhc_variant_info *var_info =
+		(void *)dev_get_driver_data(dev);
+
+	if (phase > 0xf)
+		return -EINVAL;
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config &= ~(CORE_CDR_EN | CORE_CK_OUT_EN);
+	config |= (CORE_CDR_EXT_EN | CORE_DLL_EN);
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	rc = msm_dll_poll_ck_out_en(host, 0);
+	if (rc)
+		return rc;
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config &= ~CDR_SELEXT_MASK;
+	config |= grey_coded_phase_table[phase] << CDR_SELEXT_SHIFT;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config |= CORE_CK_OUT_EN;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	rc = msm_dll_poll_ck_out_en(host, 1);
+	if (rc)
+		return rc;
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config |= CORE_CDR_EN;
+	config &= ~CORE_CDR_EXT_EN;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	return 0;
+}
+
+/*
+ * Programs the MCLK_FREQ (CMUX_SHIFT_PHASE) field. Must be set before
+ * enabling CORE_DLL_EN/CORE_CK_OUT_EN, otherwise the DLL will not lock.
+ *
+ * host->clock is not updated by the generic sdhci.c, so mmc->clock is
+ * used instead.
+ */
+static void msm_cm_dll_set_freq(struct sdhci_host *host)
+{
+	struct udevice *dev = host->mmc->dev;
+	struct mmc *mmc = host->mmc;
+	const struct msm_sdhc_variant_info *var_info =
+		(void *)dev_get_driver_data(dev);
+	u32 mclk_freq = 0, config;
+	unsigned int clock = mmc->clock;
+
+	if (clock <= 112000000)
+		mclk_freq = 0;
+	else if (clock <= 125000000)
+		mclk_freq = 1;
+	else if (clock <= 137000000)
+		mclk_freq = 2;
+	else if (clock <= 150000000)
+		mclk_freq = 3;
+	else if (clock <= 162000000)
+		mclk_freq = 4;
+	else if (clock <= 175000000)
+		mclk_freq = 5;
+	else if (clock <= 187000000)
+		mclk_freq = 6;
+	else if (clock <= 200000000)
+		mclk_freq = 7;
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config &= ~CMUX_SHIFT_PHASE_MASK;
+	config |= mclk_freq << CMUX_SHIFT_PHASE_SHIFT;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+}
+
+static int msm_dll_poll_lock_status(struct sdhci_host *host)
+{
+	u32 dll_status;
+	struct udevice *dev = host->mmc->dev;
+	const struct msm_sdhc_variant_info *var_info =
+		(void *)dev_get_driver_data(dev);
+	int ret;
+
+	ret = read_poll_timeout(readl, dll_status,
+				(dll_status & CORE_DLL_LOCK),
+				1, 50,
+				host->ioaddr + var_info->core_dll_status);
+	if (ret) {
+		printf("%s: DLL failed to LOCK (DLL_STATUS=0x%08x)\n",
+		       host->name,
+		       readl(host->ioaddr + var_info->core_dll_status));
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+/* CM_DLL initialization sequence */
+static int msm_init_cm_dll(struct sdhci_host *host)
+{
+	struct udevice *dev = host->mmc->dev;
+	struct msm_sdhc *priv = dev_get_priv(dev);
+	const struct msm_sdhc_variant_info *var_info =
+		(void *)dev_get_driver_data(dev);
+	u32 config;
+	int ret;
+
+	/*
+	 * Keep the clock enabled while DLL tuning is in progress; PWRSAVE
+	 * may otherwise turn it off.
+	 */
+	config = readl(host->ioaddr + var_info->core_vendor_spec);
+	config &= ~CORE_CLK_PWRSAVE;
+	writel(config, host->ioaddr + var_info->core_vendor_spec);
+
+	if (priv->dll_config)
+		writel(priv->dll_config, host->ioaddr + var_info->core_dll_config);
+
+	if (priv->use_14lpp_dll_reset) {
+		config = readl(host->ioaddr + var_info->core_dll_config);
+		config &= ~CORE_CK_OUT_EN;
+		writel(config, host->ioaddr + var_info->core_dll_config);
+
+		if (var_info->core_dll_config_2) {
+			config = readl(host->ioaddr + var_info->core_dll_config_2);
+			config |= CORE_DLL_CLOCK_DISABLE;
+			writel(config, host->ioaddr + var_info->core_dll_config_2);
+		}
+	}
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config |= CORE_DLL_RST;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config |= CORE_DLL_PDN;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	/*
+	 * MCLK_FREQ must be programmed while the DLL is reset and powered
+	 * down, unless a DT dll-config override is in effect.
+	 */
+	if (!priv->dll_config)
+		msm_cm_dll_set_freq(host);
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config &= ~CORE_DLL_RST;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config &= ~CORE_DLL_PDN;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	if (priv->use_14lpp_dll_reset) {
+		if (!priv->dll_config)
+			msm_cm_dll_set_freq(host);
+
+		if (var_info->core_dll_config_2) {
+			config = readl(host->ioaddr + var_info->core_dll_config_2);
+			config &= ~CORE_DLL_CLOCK_DISABLE;
+			writel(config, host->ioaddr + var_info->core_dll_config_2);
+		}
+	}
+
+	/* Applicable to SDCC v5.1 onwards only */
+	if (priv->uses_tassadar_dll && var_info->core_dll_usr_ctl) {
+		config = DLL_USR_CTL_POR_VAL | FINE_TUNE_MODE_EN |
+			 ENABLE_DLL_LOCK_STATUS | BIAS_OK_SIGNAL;
+		writel(config, host->ioaddr + var_info->core_dll_usr_ctl);
+
+		if (var_info->core_dll_config_3) {
+			config = readl(host->ioaddr + var_info->core_dll_config_3);
+			config &= ~0xFF;
+			if (host->mmc->clock < 150000000)
+				config |= DLL_CONFIG_3_LOW_FREQ_VAL;
+			else
+				config |= DLL_CONFIG_3_HIGH_FREQ_VAL;
+			writel(config, host->ioaddr + var_info->core_dll_config_3);
+		}
+	}
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config |= CORE_DLL_EN;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config |= CORE_CK_OUT_EN;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	ret = msm_dll_poll_lock_status(host);
+	if (ret)
+		return ret;
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config |= CORE_CDR_EN;
+	config &= ~CORE_CDR_EXT_EN;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	priv->calibration_done = false;
+
+	return 0;
+}
+
+/*
+ * HS400 DDR calibration via SDC4 CM_DLL, used when use_cdclp533 is false
+ * (core_minor >= 0x34).
+ */
+static int sdhci_msm_cm_dll_sdc4_calibration(struct sdhci_host *host)
+{
+	struct udevice *dev = host->mmc->dev;
+	struct msm_sdhc *priv = dev_get_priv(dev);
+	const struct msm_sdhc_variant_info *var_info =
+		(void *)dev_get_driver_data(dev);
+	u32 config, ddr_cfg_offset, wait_cnt;
+	int ret;
+
+	/*
+	 * core_ddr_config defaults to the desired configuration on reset;
+	 * reprogram the POR value in case an earlier bootloader stage
+	 * modified it.
+	 */
+	if (priv->updated_ddr_cfg)
+		ddr_cfg_offset = var_info->core_ddr_config;
+	else
+		ddr_cfg_offset = var_info->core_ddr_config_old;
+	writel(priv->ddr_config, host->ioaddr + ddr_cfg_offset);
+
+	config = readl(host->ioaddr + var_info->core_ddr_200_cfg);
+	config &= ~CORE_CMDIN_RCLK_EN;
+	writel(config, host->ioaddr + var_info->core_ddr_200_cfg);
+
+	config = readl(host->ioaddr + var_info->core_dll_config_2);
+	config |= CORE_DDR_CAL_EN;
+	writel(config, host->ioaddr + var_info->core_dll_config_2);
+
+	ret = -ETIMEDOUT;
+	wait_cnt = 100;
+	while (wait_cnt--) {
+		if (readl(host->ioaddr + var_info->core_dll_status) &
+		    CORE_DDR_DLL_LOCK) {
+			ret = 0;
+			break;
+		}
+		udelay(10);
+	}
+
+	if (ret) {
+		printf("%s: CM_DLL_SDC4 calibration was not completed\n",
+		       host->name);
+		return ret;
+	}
+
+	/*
+	 * Skip CORE_PWRSAVE_DLL for the 14lpp DLL reset variant: it cannot
+	 * guarantee the MCLK-gating timing PWRSAVE_DLL depends on.
+	 */
+	if (!priv->use_14lpp_dll_reset) {
+		config = readl(host->ioaddr + var_info->core_vendor_spec3);
+		config |= CORE_PWRSAVE_DLL;
+		writel(config, host->ioaddr + var_info->core_vendor_spec3);
+	}
+
+	return 0;
+}
+
+/*
+ * HS400 DLL calibration, performed once when transitioning into HS400 at
+ * clock > 100MHz.
+ */
+static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
+{
+	struct udevice *dev = host->mmc->dev;
+	struct msm_sdhc *priv = dev_get_priv(dev);
+	const struct msm_sdhc_variant_info *var_info =
+		(void *)dev_get_driver_data(dev);
+	u32 config;
+	int ret;
+
+	ret = msm_init_cm_dll(host);
+	if (ret)
+		return ret;
+
+	/* Restore the phase found during HS200 tuning */
+	ret = msm_config_cm_dll_phase(host, priv->saved_tuning_phase);
+	if (ret)
+		return ret;
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config |= CORE_CMD_DAT_TRACK_SEL;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	/*
+	 * use_cdclp533 only applies to legacy SDCC (core_minor < 0x34); our
+	 * supported targets always use the SDC4 calibration path.
+	 */
+	if (priv->use_cdclp533) {
+		printf("%s: CDCLP533 HS400 calibration path is not implemented\n",
+		       host->name);
+		return -EOPNOTSUPP;
+	}
+
+	return sdhci_msm_cm_dll_sdc4_calibration(host);
+}
+
+static int msm_find_most_appropriate_phase(struct sdhci_host *host,
+					   u8 *phase_table,
+					   u8 total_phases)
+{
+	int ret;
+	u8 ranges[MAX_PHASES][MAX_PHASES] = { {0}, {0} };
+	u8 phases_per_row[MAX_PHASES] = { 0 };
+	int row_index = 0, col_index = 0, selected_row_index = 0;
+	int i, longest_range_len = 0;
+	bool found = false;
+
+	if (!total_phases || total_phases > MAX_PHASES) {
+		printf("%s: Invalid argument: total_phases=%d\n",
+		       host->name, total_phases);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < total_phases; i++) {
+		ranges[row_index][col_index] = phase_table[i];
+		phases_per_row[row_index] += 1;
+		col_index++;
+
+		if ((i + 1) == total_phases)
+			continue;
+
+		if (phase_table[i] + 1 != phase_table[i + 1]) {
+			row_index++;
+			col_index = 0;
+		}
+	}
+
+	if (row_index == 0) {
+		ret = phase_table[total_phases / 2];
+		goto exit;
+	}
+
+	for (i = 0; i <= row_index; i++) {
+		if (phases_per_row[i] > longest_range_len) {
+			longest_range_len = phases_per_row[i];
+			selected_row_index = i;
+			found = true;
+		}
+	}
+
+	if (found) {
+		ret = ranges[selected_row_index][longest_range_len / 2];
+	} else {
+		ret = -EIO;
+		printf("%s: Failed to find a valid phase\n", host->name);
+	}
+
+exit:
+	return ret;
+}
+
+static bool sdhci_msm_is_tuning_needed(struct sdhci_host *host)
+{
+	struct mmc *mmc = host->mmc;
+
+	return mmc->selected_mode == MMC_HS_200;
+}
+
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
+static int sdhci_msm_execute_tuning(struct mmc *mmc, u8 opcode)
+{
+	struct sdhci_host *host = mmc->priv;
+	int tuning_seq_cnt = 10;
+	u8 phase, tuned_phases[MAX_PHASES], tuned_phase_cnt = 0;
+	int rc;
+	struct udevice *dev = mmc->dev;
+	struct msm_sdhc *priv = dev_get_priv(dev);
+
+	if (!sdhci_msm_is_tuning_needed(host))
+		return 0;
+
+	/*
+	 * The SDHCI core may call execute_tuning before host->clock is
+	 * updated to match mmc->clock.
+	 */
+	if (host->clock != mmc->clock) {
+		rc = sdhci_set_clock(mmc, mmc->clock);
+		if (rc) {
+			printf("%s: Failed to set clock for tuning\n", host->name);
+			return rc;
+		}
+	}
+
+	priv->tuning_done = false;
+
+retry:
+	rc = msm_init_cm_dll(host);
+	if (rc) {
+		printf("%s: Failed to init DLL\n", host->name);
+		return rc;
+	}
+
+	phase = 0;
+	tuned_phase_cnt = 0;
+
+	do {
+		rc = msm_config_cm_dll_phase(host, phase);
+		if (rc) {
+			printf("%s: Failed to set DLL phase %d\n",
+			       host->name, phase);
+			return rc;
+		}
+
+		rc = mmc_send_tuning(mmc, opcode);
+		if (!rc)
+			tuned_phases[tuned_phase_cnt++] = phase;
+	} while (++phase < MAX_PHASES);
+
+	if (tuned_phase_cnt) {
+		if (tuned_phase_cnt == MAX_PHASES) {
+			/*
+			 * All phases valid is close to as bad as none valid:
+			 * likely no phase is really reliable. Retry a few
+			 * times rather than guessing.
+			 */
+			if (--tuning_seq_cnt) {
+				tuned_phase_cnt = 0;
+				goto retry;
+			}
+		}
+
+		rc = msm_find_most_appropriate_phase(host, tuned_phases,
+						     tuned_phase_cnt);
+		if (rc < 0) {
+			printf("%s: Failed to find appropriate phase\n",
+			       host->name);
+			return rc;
+		}
+		phase = rc;
+
+		rc = msm_config_cm_dll_phase(host, phase);
+		if (rc) {
+			printf("%s: Failed to set final phase %d\n",
+			       host->name, phase);
+			return rc;
+		}
+
+		priv->saved_tuning_phase = phase;
+	} else {
+		if (--tuning_seq_cnt)
+			goto retry;
+		printf("%s: No tuning point found\n", host->name);
+		rc = -EIO;
+	}
+
+	if (!rc)
+		priv->tuning_done = true;
+
+	return rc;
+}
+#endif
+
+/*
+ * Configure HC mode selection. On the first HS400 transition,
+ * calibration_done is still false, so the HS400 mux-select bits are
+ * deferred until calibration completes in msm_sdhci_config_dll(); see
+ * sdhci_msm_hs400_select_in().
+ */
+static void sdhci_msm_hc_select_mode(struct sdhci_host *host)
+{
+	struct mmc *mmc = host->mmc;
+	struct udevice *dev = mmc->dev;
+	struct msm_sdhc *priv = dev_get_priv(dev);
+	const struct msm_sdhc_variant_info *var_info =
+		(void *)dev_get_driver_data(dev);
+	bool is_hs400 = mmc->selected_mode == MMC_HS_400;
+	u32 config;
+
+	config = readl(host->ioaddr + var_info->core_vendor_spec);
+	config &= ~CORE_HC_MCLK_SEL_MASK;
+
+	if (mmc->selected_mode == MMC_HS_200)
+		config |= CORE_HC_MCLK_SEL_DFLT;
+	else if (is_hs400)
+		config |= CORE_HC_MCLK_SEL_HS400;
+	else
+		config |= CORE_HC_MCLK_SEL_DFLT;
+
+	writel(config, host->ioaddr + var_info->core_vendor_spec);
+
+	if (is_hs400) {
+		if (priv->calibration_done) {
+			config = readl(host->ioaddr + var_info->core_vendor_spec);
+			config |= CORE_HC_SELECT_IN_HS400;
+			config |= CORE_HC_SELECT_IN_EN;
+			writel(config, host->ioaddr + var_info->core_vendor_spec);
+		}
+	} else {
+		/*
+		 * Clear these bits for every non-HS400 mode so a previous
+		 * HS400 attempt never leaves them stuck set.
+		 */
+		if (!priv->use_cdclp533) {
+			config = readl(host->ioaddr + var_info->core_vendor_spec3);
+			config &= ~CORE_PWRSAVE_DLL;
+			writel(config, host->ioaddr + var_info->core_vendor_spec3);
+		}
+
+		config = readl(host->ioaddr + var_info->core_vendor_spec);
+		config &= ~CORE_HC_SELECT_IN_EN;
+		config &= ~CORE_HC_SELECT_IN_MASK;
+		writel(config, host->ioaddr + var_info->core_vendor_spec);
+	}
+}
+
+/*
+ * Selects HS400 in the HC_SELECT_IN mux. Must only be called after
+ * sdhci_msm_hs400_dll_calibration() succeeds.
+ */
+static void sdhci_msm_hs400_select_in(struct sdhci_host *host)
+{
+	struct udevice *dev = host->mmc->dev;
+	const struct msm_sdhc_variant_info *var_info =
+		(void *)dev_get_driver_data(dev);
+	u32 config;
+
+	config = readl(host->ioaddr + var_info->core_vendor_spec);
+	config |= CORE_HC_SELECT_IN_HS400;
+	config |= CORE_HC_SELECT_IN_EN;
+	writel(config, host->ioaddr + var_info->core_vendor_spec);
+}
+
+static void sdhci_msm_set_control_reg(struct sdhci_host *host)
+{
+	struct mmc *mmc = host->mmc;
+	struct udevice *dev = mmc->dev;
+	struct msm_sdhc *priv = dev_get_priv(dev);
+	const struct msm_sdhc_variant_info *var_info =
+		(void *)dev_get_driver_data(dev);
+	u32 config;
+
+	/*
+	 * This controller has no HOST_CONTROL2 encoding for HS400. Keep the
+	 * UHS field at SDR104 (same as HS200) for HS400 too; the data path
+	 * is switched to HS400 timing via the vendor-specific
+	 * CORE_HC_MCLK_SEL/CORE_HC_SELECT_IN bits instead.
+	 */
+	sdhci_set_voltage(host);
+	if (mmc->selected_mode == MMC_HS_400) {
+		u32 ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+
+		ctrl2 &= ~SDHCI_CTRL_UHS_MASK;
+		ctrl2 |= SDHCI_CTRL_UHS_SDR104;
+		sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
+	} else {
+		sdhci_set_uhs_timing(host);
+	}
+
+	sdhci_msm_hc_select_mode(host);
+
+	/*
+	 * Below 100MHz the feedback clock must be provided without the DLL,
+	 * so tuning can be skipped.
+	 */
+	if (mmc->clock && mmc->clock <= CORE_FREQ_100MHZ) {
+		if (mmc->selected_mode == MMC_HS_200 ||
+		    mmc->selected_mode == MMC_HS_400) {
+			config = readl(host->ioaddr + var_info->core_dll_config);
+			config |= CORE_DLL_RST;
+			writel(config, host->ioaddr + var_info->core_dll_config);
+
+			config = readl(host->ioaddr + var_info->core_dll_config);
+			config |= CORE_DLL_PDN;
+			writel(config, host->ioaddr + var_info->core_dll_config);
+
+			/* Calibration must be redone once the clock returns to HS400 speed. */
+			priv->calibration_done = false;
+		}
+	}
+}
+
 static int msm_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enable)
 {
 	struct udevice *dev = mmc_to_dev(host->mmc);
+	struct mmc *mmc = host->mmc;
+	struct msm_sdhc *priv = dev_get_priv(dev);
 	const struct msm_sdhc_variant_info *var_info = (void *)dev_get_driver_data(dev);
 	u32 config;
 
+	if (clock == 0)
+		return 0;
+
 	if (enable && clock < MHZ(100)) {
 		/*
 		 * DLL is not required for clock <= 100MHz
@@ -169,12 +856,35 @@ static int msm_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enable)
 		writel(config, host->ioaddr + var_info->core_dll_config);
 	}
 
+	/*
+	 * HS400 requires a dedicated DDR/SDC4 DLL calibration step, performed
+	 * once per calibration cycle once the clock is running above 100MHz.
+	 */
+	if (enable && clock > MHZ(100) &&
+	    mmc->selected_mode == MMC_HS_400 && priv->tuning_done &&
+	    !priv->calibration_done) {
+		int ret = sdhci_msm_hs400_dll_calibration(host);
+
+		if (!ret) {
+			priv->calibration_done = true;
+			/* Safe to switch the data-path mux into HS400 timing now. */
+			sdhci_msm_hs400_select_in(host);
+		} else {
+			printf("%s: Failed to calibrate DLL for HS400 mode (%d)\n",
+			       host->name, ret);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
 struct sdhci_ops msm_sdhci_ops = {
 	.config_dll = &msm_sdhci_config_dll,
-	.set_control_reg = &sdhci_set_control_reg,
+	.set_control_reg = &sdhci_msm_set_control_reg,
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
+	.platform_execute_tuning = &sdhci_msm_execute_tuning,
+#endif
 };
 
 static int msm_sdc_probe(struct udevice *dev)
@@ -236,6 +946,24 @@ static int msm_sdc_probe(struct udevice *dev)
 
 	log_debug("SDCC version %d.%d\n", core_major, core_minor);
 
+	/* Feature support depends on the SDCC core version. */
+	if (core_major == 1 && core_minor >= 0x42)
+		prv->use_14lpp_dll_reset = true;
+
+	if (core_major == 1 && core_minor >= 0x71)
+		prv->uses_tassadar_dll = true;
+
+	if (core_major == 1 && core_minor < 0x34)
+		prv->use_cdclp533 = true;
+
+	if (core_major == 1 && core_minor >= 0x49)
+		prv->updated_ddr_cfg = true;
+
+	dev_read_u32(dev, "qcom,dll-config", &prv->dll_config);
+
+	if (dev_read_u32(dev, "qcom,ddr-config", &prv->ddr_config))
+		prv->ddr_config = DDR_CONFIG_POR_VAL;
+
 	/*
 	 * Support for some capabilities is not advertised by newer
 	 * controller versions and must be explicitly enabled.
@@ -326,16 +1054,35 @@ static const struct msm_sdhc_variant_info msm_sdhc_mci_var = {
 	.mci_removed = false,
 
 	.core_dll_config = 0x100,
+	.core_dll_status = 0x108,
+	.core_dll_config_2 = 0x1b4,
 	.core_vendor_spec = 0x10c,
 	.core_vendor_spec_capabilities0 = 0x11c,
+
+	.core_ddr_200_cfg = 0x184,
+	.core_vendor_spec3 = 0x1b0,
+	.core_ddr_config_old = 0x1b8,
+	.core_ddr_config = 0x1bc,
 };
 
 static const struct msm_sdhc_variant_info msm_sdhc_v5_var = {
 	.mci_removed = true,
 
 	.core_dll_config = 0x200,
+	.core_dll_status = 0x208,
+	.core_dll_config_2 = 0x254,
+	.core_dll_config_3 = 0x258,
+	.core_dll_usr_ctl = 0x388,
 	.core_vendor_spec = 0x20c,
 	.core_vendor_spec_capabilities0 = 0x21c,
+
+	.core_ddr_200_cfg = 0x224,
+	.core_vendor_spec3 = 0x250,
+	.core_ddr_config = 0x25c,
+	/*
+	 * core_ddr_config_old not present on V5 - updated_ddr_cfg is
+	 * effectively always true here since V5 implies core_minor >= 0x49
+	 */
 };
 
 static const struct udevice_id msm_mmc_ids[] = {
-- 
2.34.1

