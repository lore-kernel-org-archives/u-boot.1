Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDBD606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 12:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=r8s96XpH;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=osBkPclG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VOIUHz3O
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 357A2607B4;
	Fri, 30 Oct 2026 12:00:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MpVlAmJRn-eZ; Fri, 30 Oct 2026 12:00:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3DAE760AB3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793361623;
	b=mKCGnyA1KYEl/6jxiE3vi47QVCZRjT9dCP/fY3Y/oA/MTffv4tYUN0ilRwg0riZbg6E2
	 6sROSBhddEG4LwRIKdwxN67AwUiPktElrU+XvhChjIU3DGmoIi6M3WTx+/UsexhGinamV
	 vuCtiBLk/jQVxs9lF+/MaPKUj7rDjHYeeNYEED5A6jC7+MVaS4zl4Zc5rl1/qPeiIAvPJ
	 E1o4ziIEkprnC9TSo5wXnezOzYN+NZfU/Z40UTcFcghuD6teaJea3krDpZmUfqsNxz+a8
	 yXar3r2UhRvN1fILSe3d0HgQ+krUVfyPiTFvjkD7W3t6CzJKAJy7sPdtvRtcMpMN80w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793361623;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+U5wLsiKEhukhvsvW+ZMr5joHXabdTcVYSyq8Mo+RIM=;
	b=ceGNL9UWS2QNaQ2916/+DUCo2T2vnLg7tJ1icv1woC35Ln4uSzCyzTobf6vRW0TJr6np
	 H4WpHKOVKfx88nOfJdqn4L+GLJuusgmI6pFRWNAwrHGmiFxsraKPpMZZes+A4AGzdEzAR
	 dYCoqW5OKw9/eMsAt0h6TNeF6lgA7W+Y++IFi1x9cPew11pv37VcFIzY8FwKTaIoZacbs
	 k+PCF5RcGe6Sv4zug1OnOyQprLitg576r2m584TZz+tr43SNPtKH9Eb3j36YdGtnGraFm
	 qJeLDdHRLTZ+m/ZO6j2XxIaR+yovGVdetAMqg8OnN8uhnoQzSeNgbRJ9Vu1EbL4eAwA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793361623;
	bh=+U5wLsiKEhukhvsvW+ZMr5joHXabdTcVYSyq8Mo+RIM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r8s96XpHLWEsVeiWC/iv9+3Rx1pKmmVa60iRaFSYorn7Kt9wgm7ut5wtawyTS0k1O
	 Dg++mVsJObuIPpTRX4fAcejQMe7OEKzTD1fC4vVtJufViBh+diDC6/6ugUX5G49/yn
	 fzfWfD5TSJiMLn1Ii5b1fyI4Ll7HQ8uGcpzZAKOKjVcSZew3JHF003JN9e5y3vymUL
	 tv6RpM4y53S/jKty1wJL/SC4Q4O48KJA4d91mQB+lnFbECaxD9Tb33Qf8Uh3gs9Wdu
	 A1HLOtYSGGmNhCRVWunz3Rglrg1rwJztMBW2eQ5VwqiT8dihqj7Fv3S4ZhxzFY94Y2
	 yDIWkfuAzhhIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3DAE760AB3;
	Fri, 30 Oct 2026 12:00:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A95B1362
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:00:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8F01940A90
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:00:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vr7yUVHaVOKg for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 12:00:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E4E2E40A5B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793361620;
 b=Gkzeer2nXv03B3FoKD/F5y5USF1WsFG720lOGow/wGXZEgj+XyGumYeMds/oiYBC7Grc
 pLtXtkAHFC34QUTOE3Gjca1EL5L6Aml0PcBMQgcGaXFwzhe1dWW18wOouvtBzL8o4UGF8
 e5ymFzzTkJdsDQEBGHR1+VFT5NnvpW2y0/xiuFvSl0avUVzJtaZxEpFA0w9rHa49UW15u
 JVF3Aac7mgwKXZl9Lsv/7Onlg4N02n0Hl0CIaek3CCpcE1Pxjt8PXy7FpsXh4HdLK+tFu
 XCjBTd8e8xNW+ALHIFpPOn38n36l6WseuKfdna9GUzC0ozBVUb13izh5H3zXwA7QR6g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793361620;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=+U5wLsiKEhukhvsvW+ZMr5joHXabdTcVYSyq8Mo+RIM=;
 b=hlqHD32A371X6jbl9Ppfk+mVRiKSQn5XfVv/WN9fRCjas+/Cmj+U4Qhg3BTj4kAAd8Rb
 PNsQuLTyvLYW937BLN1DsbU1bxIjZQ+W/Dl6YKooMMCO89EmJZJkIzJ6RRuAin7OPrq09
 ZizHutjU5Yaho8AqwYCQENlYhfAmUQQ89X772aiao9enH9N8VdCPSqZ7TFPkGPEVPCD/J
 TFLGsyEt/UBSk27CelaPUfXnAM5UOx5fZunQbQN2NNMyy7RhS42Q8L7CRlH5xFaH+rFE7
 SVrkpJqbBvIZOl5snyLx73OvryaGBQhDBtB4MkUusPM0bq5+9nd9Fu9fSyEpYxce7Wg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=osBkPclG; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VOIUHz3O; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=osBkPclG; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VOIUHz3O
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E4E2E40A5B
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:00:18 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBG8H44144767
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +U5wLsiKEhukhvsvW+ZMr5joHXabdTcVYSyq8Mo+RIM=; b=osBkPclGvAAN97bz
 M58psfQml/F6nfMqjNE6CARABFR+h3HsL0Xkgjb2bYRpYZ20SCim9+V1gEcKxtmK
 JSDO5g0OT+RigsmUkIeq2oEErro9pe2k0B4uCJ0hxvUtCztLzk5t37mxU2/lSV+e
 qTSHwM7SCBFRaVVYkJFZJ4V841Pay8UJvOyhJKuCfGO/Gq5aBkRECL1JaASGEW6W
 ucq6F44E/+G9Pa84nxMY1DZppL3qCog2lpjME4DS7WtqugmcUIjrvKE7E0sMMyJa
 nfX97lydBUdYfn7jn7fd1AdZOuauL5uoxBIuPEa6NyrYgXg7P1jEYIzzZ7s7A5n9
 9rH6pQ==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme752v3y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:00:17 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-67686ccd1b6so881700d50.2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793361617; cv=none;
 d=google.com; s=arc-20260327;
 b=E4HHcd4oHn+SMvFb89Uljzo8/QTIedQXcBO44Aa4iFL1gS5CAcGslQWTjeWtSDhY0G
 CocIG1f2cs5zHME2D+ZhRFgBRozDsVA2xNoE9NVByFn9cXpmh02kVXmUEGFSoxEskyig
 lPIJbfhSAXq4UU62tEPfkpTHp4GwoxT5WaW+NGuxVsg9c7mQEyayfO+5S+22mMXnFEcA
 WSrZp4tofHvNZyD2iNUBHPDIUaEmbDI8MrHpbINY3qabx1mM/fJcpcxlwcJr2Ljo7Y4t
 8o5ox+Q6X/KOPJVHshcIISSxwvYzANywkS2OwmkSW48mW95sBF2St7R12klmJ0Kv6Nbr
 fyAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+U5wLsiKEhukhvsvW+ZMr5joHXabdTcVYSyq8Mo+RIM=;
 fh=mWuTgIrLpLrZUttAhX2qxyrfyx/IOjbS3niidjxKZ+o=;
 b=TgZqanK7R0dZclI5Vd6uSDdfqrOe9tl5jtSRvyXIuW6DkQ4PaZlzoBXnge6h47VDd8
 Xq4V+8aX1rzex4h2ErRExXVS0iAdR2YpBnVGfxZf4TDkZZa+2r1G/uGMT6bMbFJRmvLc
 9UVXZLVfEDbPq8QDa+gaRHa8PDEdn9udOU42Lp3O046XbvJpJ2zv0lY5V+VxfX1CA2+7
 xNTWa+7P3zznuA0vb2cRuscEkCkCKiBssVWKwDwAm87o/OTWsdp79h3X9VkLEqY1p4n0
 41IJ/xzVV/NohLz3RNmr6pDRrTI88n7Cv/lCOqfbqFqA/VnNHeJRPp4jsuJpfkzmj/Vk
 4n1w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793361617; x=1793966417;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+U5wLsiKEhukhvsvW+ZMr5joHXabdTcVYSyq8Mo+RIM=;
 b=VOIUHz3OOn0cYca4xM0WtcBJeozdl2/D8qFHhpfmn91nbSZZKVx+i6vw0Y2iiDo1iw
 C4X0jUeY9LgxvwzAdr2oFCrq+wuMkHcyVrkXqSGz0itGK2OJzgZa41Qf4xqX6+4UmBhC
 ApCS06GassvukHwebjFyfgszF3QpjpJXfa8ddsvr0AOUjmlYM9h0/5vxYNulBB9Ust84
 9LJPgOuQbUE8Gw03usRcucnIR8JKDMgyJHd8W5b+6IbnftdXjBtEJRyt2859jl3iF7Wc
 2tAnOszVoeBoZr9sYTAYElehJoD+XG9JwpJjZZxmuxg2cMZ8uf5hOmo/se/s85Mh3yfd
 MGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793361617; x=1793966417;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+U5wLsiKEhukhvsvW+ZMr5joHXabdTcVYSyq8Mo+RIM=;
 b=d9/oCnGRla+1txIbWjiNO7JQseGMeMbOt0CtV4RygGdgXFvi6mrn0975HMpxuOZ3wr
 eTN7OjknM4JAnNCFPRLh71qFSZlGRkhBG7JNAEdA0kWQfjIznay1GdDZRQe5mD+9+XxQ
 g4KkXeQcABzdXS5ecEkt2AcXnnlcWcwnnZuRfIm84tAY2lmue3KG9qKOSAIAIKS1W3K4
 qYYEQsQ/rKg9HjionZmG/miy4efN5v5WLwpH8kBhgCcRa2NeUxATTl+fnJ+3VXfFvRup
 lroWpzKIBOOHxcDPGKP3SbVok7zSLCzJULcqoBGapMkWbUHwK30ZeCmly9+ppio4Pxwi
 mhxA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwh8P18Kt3v/KntyuNMmCZPpW4QiaZ3vK6WQsuwN+ShqGQMFksDsy6JL3KdiAwOGqQRvbwuhBs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLsPEyUXZEhpQfdixX5Ldvg0XYIGc1ZsgZ3hxIqBMv17oNuZAZ4
 NHhZCMwXb+c8ytYv8c+1F3NkEFCrLNY0f8aFTzPavNpBamoT7fvw86fAQHMtwsLYHkWZ5EaG91D
 y/D1j+qTqXdHgNDLlIyxDEi/Wvi5tn67WqHLqzCBgvUDScWlsgqXvvKqWD7vVWxnAQj6jtylve3
 c0WqPthvtRAE5nDC2SRQFaqD/v5kO84uqJSaL6+/JI99B04g==
X-Gm-Gg: AYBFou28sThJ4f8n3NzZQ/D5DirPXiRuOp8eMUyCVOX/vAcI985aEAaxgmlRfQpQ4TS
 W2X6YHWSHfroStZVt0KHEmG7skPZeLvzP0z5rSM/BWV7nJW6COISrKKyxOmR2FgNHf2Y4AnATqz
 Ym6PgFhwBvrPetfv/m9p8MG02sMUguNhP7QDeOq/pBZv5GqdL6BnkYKPg=
X-Received: by 2002:a05:690e:4397:b0:671:5b28:13aa with SMTP id
 956f58d0204a3-67ba506e741mr943231d50.70.1793361616342; 
 Fri, 30 Oct 2026 05:00:16 -0700 (PDT)
X-Received: by 2002:a05:690e:4397:b0:671:5b28:13aa with SMTP id
 956f58d0204a3-67ba506e741mr943214d50.70.1793361615616; Fri, 30 Oct 2026
 05:00:15 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
 <20261021160916.3894471-6-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20261021160916.3894471-6-aswin.murugan@oss.qualcomm.com>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 13:00:04 +0100
X-Gm-Features: AclHuK8pMmIU0yr1peAPbRJtE-5yJE4caG5t1Pl1MRt-Aon3nqc3-I3cUWNEChM
Message-ID: <CAPzfCAaQ9Z1MWKBCFp-s67PY1M0cZJF-HPW779KCXKpSKmuziA@mail.gmail.com>
Subject: Re: [PATCH v4 05/12] phy: qcom: add QMP USB3 PHY driver for Shikra
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, Michael.Srba@seznam.cz,
 william.bright@imd-tec.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, nathbappai@gmail.com, macpaul.lin@mediatek.com,
 jbx6244@gmail.com, dlechner@baylibre.com,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 90bmEwfAi4P3lomJ-X-Uyzhydoil7YKV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0NyBTYWx0ZWRfX2vdhY6JRs1bw
 ITc3qTwyAFsQrL/vi9RkkH3qWThJ2Q8Y0MDX32fOq+EeruFcdwgF3CzhWXhPQ+pCahnDH5LbBrY
 z3n7wATVnvIw0tzTCcb9BM/PS1VUApOvoX3UK/43ACoo6kKeeTlfhy3AFXsJtOq3dWyJBIlhTHv
 p4r5w7JXUJTrQx1QY5RibTxG3Ep0Qt51Vo3wDJfQmf11q9xKNfQZmm1Npqz38tagi1X3pS7O9oY
 w4ygJgXL/nahB+dyQV9+UUka5mAc+P3wvQ76KIXGO0JXXenK2juFm39W5v1chBAEomkd9EdJngB
 N85avpeUkY0uQdBvqGtVQ7d7kUMZHls8f4rGfmNStfJvl5lMbm1xl7+Q2lq7d04rUSgT3ZkPQeS
 cyrmpNlde70bTuAdmKG1BxuZq4M+QxZYwLL+FiI4VKx//WG7wtxmSUp5GQ/nAct7OQpoL9xx6uN
 Wg2XyqMLddg74kDAb8w==
X-Proofpoint-ORIG-GUID: 90bmEwfAi4P3lomJ-X-Uyzhydoil7YKV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0NyBTYWx0ZWRfXz6jm8pGVNQmw
 HSe9oSAqScOo7XhqNKD8dmcjB63JrVIipwf1X983od7We3c9iDyaYyf0KPx+CvWoLK/1NMQ3q2Z
 mkpbv7rnIweSnkoMc6FtSgmmihIGsAQ=
X-Authority-Analysis: v=2.4 cv=KdtHIgYD c=1 sm=1 tr=0 ts=6ae486d1 cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=ctUv7CzhD7QUSdI4vLUA:9
 a=QEXdDO2ut3YA:10 a=Epx66wHExT0cjJnnR-oj:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300047
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Aswin,

On Wed, Oct 21, 2026 at 6:10=E2=80=AFPM Aswin Murugan
<aswin.murugan@oss.qualcomm.com> wrote:
>
> Shikra USB3 QMP PHY uses a single-PHY DT binding (#phy-cells =3D <0>),
> which is not supported by the existing QMP combo PHY driver.
>
> Add a dedicated USB3-only QMP PHY driver for Shikra, porting the PHY
> initialization sequence and configuration tables from Linux
> drivers/phy/qualcomm/phy-qcom-qmp-usbc.c. The driver is selected
> through PHY_QCOM_QMP_USB3_LEGACY and enables USB3 PHY bring-up on
> Shikra platforms.
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
I don't have Shikra board, but tested this on Agatti (Uno Q), which is
same SoC family (Bruin):

Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> ---
>  drivers/phy/qcom/Kconfig                    |   7 +
>  drivers/phy/qcom/Makefile                   |   1 +
>  drivers/phy/qcom/phy-qcom-qmp-usb3-legacy.c | 534 ++++++++++++++++++++
>  3 files changed, 542 insertions(+)
>  create mode 100644 drivers/phy/qcom/phy-qcom-qmp-usb3-legacy.c
>
> diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
> index 1fdadaccb12..ffb523fffbb 100644
> --- a/drivers/phy/qcom/Kconfig
> +++ b/drivers/phy/qcom/Kconfig
> @@ -32,6 +32,13 @@ config PHY_QCOM_QMP_UFS
>         help
>           Enable this to support the UFS QMP PHY on various Qualcomm chip=
sets.
>
> +config PHY_QCOM_QMP_USB3_LEGACY
> +       bool "Qualcomm QMP USB3-only legacy PHY driver"
> +       depends on PHY && ARCH_SNAPDRAGON
> +       help
> +         Enable this to support the legacy USB3-only QMP PHY (v3) found =
on
> +         older Qualcomm chipsets such as QCM2290/QCS615 and derivatives.
> +
>  config PHY_QCOM_QUSB2
>         bool "Qualcomm USB QUSB2 PHY driver"
>         depends on PHY && ARCH_SNAPDRAGON
> diff --git a/drivers/phy/qcom/Makefile b/drivers/phy/qcom/Makefile
> index 714013dc572..dfad1f1e56a 100644
> --- a/drivers/phy/qcom/Makefile
> +++ b/drivers/phy/qcom/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_MSM8916_USB_PHY) +=3D msm8916-usbh-phy.o
>  obj-$(CONFIG_PHY_QCOM_QMP_COMBO) +=3D phy-qcom-qmp-combo.o
>  obj-$(CONFIG_PHY_QCOM_QMP_PCIE) +=3D phy-qcom-qmp-pcie.o
>  obj-$(CONFIG_PHY_QCOM_QMP_UFS) +=3D phy-qcom-qmp-ufs.o
> +obj-$(CONFIG_PHY_QCOM_QMP_USB3_LEGACY) +=3D phy-qcom-qmp-usb3-legacy.o
>  obj-$(CONFIG_PHY_QCOM_QUSB2) +=3D phy-qcom-qusb2.o
>  obj-$(CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2) +=3D phy-qcom-snps-femto-v2.o
>  obj-$(CONFIG_PHY_QCOM_SNPS_EUSB2) +=3D phy-qcom-snps-eusb2.o
> diff --git a/drivers/phy/qcom/phy-qcom-qmp-usb3-legacy.c b/drivers/phy/qc=
om/phy-qcom-qmp-usb3-legacy.c
> new file mode 100644
> index 00000000000..d1aad6e7952
> --- /dev/null
> +++ b/drivers/phy/qcom/phy-qcom-qmp-usb3-legacy.c
> @@ -0,0 +1,534 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <clk.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <dm/devres.h>
> +#include <dm/uclass.h>
> +#include <generic-phy.h>
> +#include <reset.h>
> +#include <power/regulator.h>
> +#include <usb/tcpm.h>
> +#include <asm/io.h>
> +#include <linux/bitops.h>
> +#include <linux/compat.h>
> +#include <linux/delay.h>
> +#include <linux/iopoll.h>
> +#include <linux/err.h>
> +
> +#include "phy-qcom-qmp-common.h"
> +
> +#include "phy-qcom-qmp.h"
> +#include "phy-qcom-qmp-pcs-misc-v3.h"
> +
> +/* QPHY_V3_PCS_MISC_TYPEC_CTRL-equivalent bit, legacy USB3-only PHY */
> +#define SW_PORTSELECT_MUX                      BIT(1)
> +#define SW_PORTSELECT_VAL                      BIT(0)
> +
> +#define PHY_INIT_COMPLETE_TIMEOUT              10000
> +
> +#define RESET_SETTLE_DELAY_US                  10
> +
> +struct qmp_usb3_legacy_offsets {
> +       u16 serdes;
> +       u16 tx;
> +       u16 rx;
> +       u16 tx2;
> +       u16 rx2;
> +       u16 pcs;
> +       u16 pcs_misc;
> +};
> +
> +static const struct qmp_usb3_legacy_offsets qmp_usb3_legacy_offsets_qcm2=
290 =3D {
> +       .serdes         =3D 0x000,
> +       .tx             =3D 0x200,
> +       .rx             =3D 0x400,
> +       .tx2            =3D 0x600,
> +       .rx2            =3D 0x800,
> +       .pcs_misc       =3D 0xa00,
> +       .pcs            =3D 0xc00,
> +};
> +
> +static const struct qmp_phy_init_tbl qcm2290_usb3_serdes_tbl[] =3D {
> +       QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0x14),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CLKBUFLR_EN, 0x08),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_CLK_SELECT, 0x30),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_SYS_CLK_CTRL, 0x06),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_RESETSM_CNTRL, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_RESETSM_CNTRL2, 0x08),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_BG_TRIM, 0x0f),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_SVS_MODE_CLK_SEL, 0x01),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_HSCLK_SEL, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_DEC_START_MODE0, 0x82),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START1_MODE0, 0x55),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START2_MODE0, 0x55),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START3_MODE0, 0x03),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_CP_CTRL_MODE0, 0x0b),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_PLL_RCTRL_MODE0, 0x16),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_PLL_CCTRL_MODE0, 0x28),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN0_MODE0, 0x80),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN1_MODE0, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_CORECLK_DIV, 0x0a),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP1_MODE0, 0x15),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP2_MODE0, 0x34),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE0, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP_EN, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_CORE_CLK_EN, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP_CFG, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_MAP, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_BG_TIMER, 0x0a),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_SSC_EN_CENTER, 0x01),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_SSC_PER1, 0x31),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_SSC_PER2, 0x01),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER1, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER2, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_SSC_STEP_SIZE1, 0xde),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_SSC_STEP_SIZE2, 0x07),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_PLL_IVCO, 0x0f),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_CMN_CONFIG, 0x06),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_INITVAL, 0x80),
> +       QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CTRL_BY_PSM, 0x01),
> +};
> +
> +static const struct qmp_phy_init_tbl qcm2290_usb3_tx_tbl[] =3D {
> +       QMP_PHY_INIT_CFG(QSERDES_V3_TX_HIGHZ_DRVR_EN, 0x10),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_TX_RCV_DETECT_LVL_2, 0x12),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_TX_LANE_MODE_1, 0xc6),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_TX, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_RX, 0x00),
> +};
> +
> +static const struct qmp_phy_init_tbl qcm2290_usb3_rx_tbl[] =3D {
> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_FO_GAIN, 0x0b),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_PI_CONTROLS, 0x80),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_COUNT_LOW, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FO_GAIN, 0x0a),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SO_GAIN, 0x06),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x7=
5),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL2, 0x02),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4e),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL4, 0x18),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x77)=
,
> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_VGA_CAL_CNTRL2, 0x0a),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_CNTRL, 0x03),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_DEGLITCH_CNTRL, 0x16),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_ENABLES, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_MODE_00, 0x00),
> +};
> +
> +static const struct qmp_phy_init_tbl qcm2290_usb3_pcs_tbl[] =3D {
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXMGN_V0, 0x9f),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V0, 0x17),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V0, 0x0f),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL2, 0x83),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL1, 0x02),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_L, 0x09),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_H_TOL, 0xa2),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_MAN_CODE, 0x85),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG1, 0xd1),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG2, 0x1f),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG3, 0x47),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_WAIT_TIME, 0x75),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_RUN_TIME, 0x13),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_LFPS_TX_ECSTART_EQTLOCK, 0x86),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_PWRUP_RESET_DLY_TIME_AUXCLK, 0x04),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_TSYNC_RSYNC_TIME, 0x44),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_L, 0x40),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_H, 0x00),
> +       QMP_PHY_INIT_CFG(QPHY_V3_PCS_RX_SIGDET_LVL, 0x88),
> +};
> +
> +/* Per-compatible config; add a new instance here to support another SoC=
 */
> +struct qmp_usb3_legacy_cfg {
> +       const struct qmp_usb3_legacy_offsets *offsets;
> +
> +       const struct qmp_phy_init_tbl *serdes_tbl;
> +       int serdes_tbl_num;
> +       const struct qmp_phy_init_tbl *tx_tbl;
> +       int tx_tbl_num;
> +       const struct qmp_phy_init_tbl *rx_tbl;
> +       int rx_tbl_num;
> +       const struct qmp_phy_init_tbl *pcs_tbl;
> +       int pcs_tbl_num;
> +
> +       /* clock names fetched by clk_get_by_name(); "pipe" is fetched se=
parately */
> +       const char * const *clk_list;
> +       int num_clks;
> +
> +       const char * const *vreg_list;
> +       int num_vregs;
> +};
> +
> +static const char * const shikra_usb3_clk_l[] =3D {
> +       "cfg_ahb", "ref", "com_aux",
> +};
> +
> +static const struct qmp_usb3_legacy_cfg shikra_usb3phy_cfg =3D {
> +       .offsets        =3D &qmp_usb3_legacy_offsets_qcm2290,
> +       .serdes_tbl     =3D qcm2290_usb3_serdes_tbl,
> +       .serdes_tbl_num =3D ARRAY_SIZE(qcm2290_usb3_serdes_tbl),
> +       .tx_tbl         =3D qcm2290_usb3_tx_tbl,
> +       .tx_tbl_num     =3D ARRAY_SIZE(qcm2290_usb3_tx_tbl),
> +       .rx_tbl         =3D qcm2290_usb3_rx_tbl,
> +       .rx_tbl_num     =3D ARRAY_SIZE(qcm2290_usb3_rx_tbl),
> +       .pcs_tbl        =3D qcm2290_usb3_pcs_tbl,
> +       .pcs_tbl_num    =3D ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
> +       .clk_list       =3D shikra_usb3_clk_l,
> +       .num_clks       =3D ARRAY_SIZE(shikra_usb3_clk_l),
> +       .vreg_list      =3D NULL,
> +       .num_vregs      =3D 0,
> +};
> +
> +static const char * const talos_usb3_clk_l[] =3D {
> +       "aux", "ref", "cfg_ahb",
> +};
> +
> +static const char * const talos_usb3_vreg_l[] =3D {
> +       "vdda-phy-supply", "vdda-pll-supply",
> +};
> +
> +static const struct qmp_usb3_legacy_cfg talos_usb3phy_cfg =3D {
> +       .offsets        =3D &qmp_usb3_legacy_offsets_qcm2290,
> +       .serdes_tbl     =3D qcm2290_usb3_serdes_tbl,
> +       .serdes_tbl_num =3D ARRAY_SIZE(qcm2290_usb3_serdes_tbl),
> +       .tx_tbl         =3D qcm2290_usb3_tx_tbl,
> +       .tx_tbl_num     =3D ARRAY_SIZE(qcm2290_usb3_tx_tbl),
> +       .rx_tbl         =3D qcm2290_usb3_rx_tbl,
> +       .rx_tbl_num     =3D ARRAY_SIZE(qcm2290_usb3_rx_tbl),
> +       .pcs_tbl        =3D qcm2290_usb3_pcs_tbl,
> +       .pcs_tbl_num    =3D ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
> +       .clk_list       =3D talos_usb3_clk_l,
> +       .num_clks       =3D ARRAY_SIZE(talos_usb3_clk_l),
> +       .vreg_list      =3D talos_usb3_vreg_l,
> +       .num_vregs      =3D ARRAY_SIZE(talos_usb3_vreg_l),
> +};
> +
> +struct qmp_usb3_legacy {
> +       struct udevice *dev;
> +       void __iomem *serdes;
> +       void __iomem *tx;
> +       void __iomem *rx;
> +       void __iomem *tx2;
> +       void __iomem *rx2;
> +       void __iomem *pcs;
> +       void __iomem *pcs_misc;
> +       struct clk *clks;
> +       struct clk pipe_clk;
> +       int num_clks;
> +       struct reset_ctl_bulk resets;
> +       struct udevice **vregs;
> +       int num_vregs;
> +       const struct qmp_usb3_legacy_cfg *cfg;
> +};
> +
> +static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
> +{
> +       u32 reg;
> +
> +       reg =3D readl(base + offset);
> +       reg |=3D val;
> +       writel(reg, base + offset);
> +       readl(base + offset);
> +}
> +
> +static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
> +{
> +       u32 reg;
> +
> +       reg =3D readl(base + offset);
> +       reg &=3D ~val;
> +       writel(reg, base + offset);
> +       readl(base + offset);
> +}
> +
> +/* Quiesce the PHY; shared by power_off() and power_on()'s error path */
> +static void qmp_usb3_legacy_quiesce(struct qmp_usb3_legacy *qmp)
> +{
> +       qphy_clrbits(qmp->pcs, QPHY_V3_PCS_START_CONTROL, SERDES_START | =
PCS_START);
> +       qphy_setbits(qmp->pcs, QPHY_V3_PCS_SW_RESET, SW_RESET);
> +       qphy_clrbits(qmp->pcs, QPHY_V3_PCS_POWER_DOWN_CONTROL, SW_PWRDN);
> +}
> +
> +/* Fixed orientation by default; use TCPM orientation if available */
> +static u32 qmp_usb3_legacy_get_portselect(struct qmp_usb3_legacy *qmp)
> +{
> +       u32 val =3D SW_PORTSELECT_MUX;
> +
> +       if (IS_ENABLED(CONFIG_TYPEC_TCPM)) {
> +               struct udevice *tcpm_dev;
> +               enum typec_orientation orientation;
> +               int ret;
> +
> +               ret =3D uclass_first_device_check(UCLASS_TCPM, &tcpm_dev)=
;
> +               if (!ret && tcpm_dev) {
> +                       orientation =3D tcpm_get_orientation(tcpm_dev);
> +                       if (orientation =3D=3D TYPEC_ORIENTATION_REVERSE)
> +                               val |=3D SW_PORTSELECT_VAL;
> +               }
> +       }
> +
> +       return val;
> +}
> +
> +static int qmp_usb3_legacy_power_on(struct phy *phy)
> +{
> +       struct qmp_usb3_legacy *qmp =3D dev_get_priv(phy->dev);
> +       const struct qmp_usb3_legacy_cfg *cfg =3D qmp->cfg;
> +       void __iomem *status;
> +       u32 val;
> +       int ret;
> +
> +       qphy_setbits(qmp->pcs, QPHY_V3_PCS_POWER_DOWN_CONTROL, SW_PWRDN);
> +
> +       writel(qmp_usb3_legacy_get_portselect(qmp), qmp->pcs_misc);
> +
> +       qmp_configure(qmp->dev, qmp->serdes, cfg->serdes_tbl, cfg->serdes=
_tbl_num);
> +
> +       ret =3D clk_enable(&qmp->pipe_clk);
> +       if (ret) {
> +               dev_err(qmp->dev, "pipe_clk enable failed err=3D%d\n", re=
t);
> +               return ret;
> +       }
> +
> +       qmp_configure_lane(qmp->dev, qmp->tx, cfg->tx_tbl, cfg->tx_tbl_nu=
m, 1);
> +       qmp_configure_lane(qmp->dev, qmp->rx, cfg->rx_tbl, cfg->rx_tbl_nu=
m, 1);
> +
> +       qmp_configure_lane(qmp->dev, qmp->tx2, cfg->tx_tbl, cfg->tx_tbl_n=
um, 2);
> +       qmp_configure_lane(qmp->dev, qmp->rx2, cfg->rx_tbl, cfg->rx_tbl_n=
um, 2);
> +
> +       qmp_configure(qmp->dev, qmp->pcs, cfg->pcs_tbl, cfg->pcs_tbl_num)=
;
> +
> +       qphy_clrbits(qmp->pcs, QPHY_V3_PCS_SW_RESET, SW_RESET);
> +
> +       qphy_setbits(qmp->pcs, QPHY_V3_PCS_START_CONTROL, SERDES_START | =
PCS_START);
> +
> +       status =3D qmp->pcs + QPHY_V3_PCS_PCS_STATUS;
> +       ret =3D readl_poll_timeout(status, val, !(val & PHYSTATUS),
> +                                PHY_INIT_COMPLETE_TIMEOUT);
> +       if (ret) {
> +               dev_err(qmp->dev, "phy initialization timed-out\n");
> +               clk_disable(&qmp->pipe_clk);
> +               qmp_usb3_legacy_quiesce(qmp);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int qmp_usb3_legacy_power_off(struct phy *phy)
> +{
> +       struct qmp_usb3_legacy *qmp =3D dev_get_priv(phy->dev);
> +
> +       clk_disable(&qmp->pipe_clk);
> +       qmp_usb3_legacy_quiesce(qmp);
> +
> +       return 0;
> +}
> +
> +static void qmp_usb3_legacy_clk_disable_upto(struct qmp_usb3_legacy *qmp=
, int upto)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < upto; i++)
> +               clk_disable(&qmp->clks[i]);
> +}
> +
> +static int qmp_usb3_legacy_clk_init(struct qmp_usb3_legacy *qmp)
> +{
> +       const struct qmp_usb3_legacy_cfg *cfg =3D qmp->cfg;
> +       struct udevice *dev =3D qmp->dev;
> +       int num =3D cfg->num_clks;
> +       int i, ret;
> +
> +       qmp->clks =3D devm_kcalloc(dev, num, sizeof(*qmp->clks), GFP_KERN=
EL);
> +       if (!qmp->clks)
> +               return -ENOMEM;
> +
> +       qmp->num_clks =3D 0;
> +
> +       for (i =3D 0; i < num; i++) {
> +               ret =3D clk_get_by_name(dev, cfg->clk_list[i], &qmp->clks=
[i]);
> +               if (ret) {
> +                       dev_err(dev, "failed to get %s clock: %d\n",
> +                               cfg->clk_list[i], ret);
> +                       qmp_usb3_legacy_clk_disable_upto(qmp, i);
> +                       return ret;
> +               }
> +
> +               ret =3D clk_enable(&qmp->clks[i]);
> +               if (ret) {
> +                       dev_err(dev, "failed to enable %s clock: %d\n",
> +                               cfg->clk_list[i], ret);
> +                       qmp_usb3_legacy_clk_disable_upto(qmp, i);
> +                       return ret;
> +               }
> +       }
> +       qmp->num_clks =3D num;
> +
> +       ret =3D clk_get_by_name(dev, "pipe", &qmp->pipe_clk);
> +       if (ret) {
> +               dev_err(dev, "failed to get pipe clock: %d\n", ret);
> +               qmp_usb3_legacy_clk_disable_upto(qmp, qmp->num_clks);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int qmp_usb3_legacy_vreg_init(struct qmp_usb3_legacy *qmp)
> +{
> +       const struct qmp_usb3_legacy_cfg *cfg =3D qmp->cfg;
> +       struct udevice *dev =3D qmp->dev;
> +       int i, ret;
> +
> +       qmp->num_vregs =3D 0;
> +
> +       if (!cfg->num_vregs)
> +               return 0;
> +
> +       qmp->vregs =3D devm_kcalloc(dev, cfg->num_vregs, sizeof(*qmp->vre=
gs), GFP_KERNEL);
> +       if (!qmp->vregs)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < cfg->num_vregs; i++) {
> +               ret =3D device_get_supply_regulator(dev, cfg->vreg_list[i=
], &qmp->vregs[i]);
> +               if (ret) {
> +                       dev_err(dev, "failed to get regulator %s: %d\n",
> +                               cfg->vreg_list[i], ret);
> +                       return ret;
> +               }
> +       }
> +
> +       qmp->num_vregs =3D cfg->num_vregs;
> +       return 0;
> +}
> +
> +static int qmp_usb3_legacy_vreg_enable(struct qmp_usb3_legacy *qmp)
> +{
> +       int i, ret;
> +
> +       for (i =3D 0; i < qmp->num_vregs; i++) {
> +               ret =3D regulator_set_enable(qmp->vregs[i], true);
> +               if (ret) {
> +                       dev_err(qmp->dev, "failed to enable regulator %d:=
 %d\n", i, ret);
> +                       while (--i >=3D 0)
> +                               regulator_set_enable(qmp->vregs[i], false=
);
> +                       return ret;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static void qmp_usb3_legacy_vreg_disable(struct qmp_usb3_legacy *qmp)
> +{
> +       int i;
> +
> +       for (i =3D qmp->num_vregs - 1; i >=3D 0; i--)
> +               regulator_set_enable(qmp->vregs[i], false);
> +}
> +
> +static int qmp_usb3_legacy_parse_dt(struct qmp_usb3_legacy *qmp)
> +{
> +       const struct qmp_usb3_legacy_cfg *cfg =3D qmp->cfg;
> +       const struct qmp_usb3_legacy_offsets *offs =3D cfg->offsets;
> +       struct udevice *dev =3D qmp->dev;
> +       void __iomem *base;
> +       int ret;
> +
> +       base =3D (void __iomem *)dev_read_addr(dev);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       qmp->serdes =3D base + offs->serdes;
> +       qmp->tx =3D base + offs->tx;
> +       qmp->rx =3D base + offs->rx;
> +       qmp->tx2 =3D base + offs->tx2;
> +       qmp->rx2 =3D base + offs->rx2;
> +       qmp->pcs =3D base + offs->pcs;
> +       qmp->pcs_misc =3D base + offs->pcs_misc;
> +
> +       ret =3D qmp_usb3_legacy_vreg_init(qmp);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D qmp_usb3_legacy_vreg_enable(qmp);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D reset_get_bulk(dev, &qmp->resets);
> +       if (ret) {
> +               dev_err(dev, "failed to get resets: %d\n", ret);
> +               goto err_disable_vregs;
> +       }
> +
> +       ret =3D reset_assert_bulk(&qmp->resets);
> +       if (ret) {
> +               dev_err(dev, "failed to assert resets: %d\n", ret);
> +               goto err_disable_vregs;
> +       }
> +
> +       udelay(RESET_SETTLE_DELAY_US);
> +
> +       ret =3D reset_deassert_bulk(&qmp->resets);
> +       if (ret) {
> +               dev_err(dev, "failed to deassert resets: %d\n", ret);
> +               goto err_assert_resets;
> +       }
> +
> +       ret =3D qmp_usb3_legacy_clk_init(qmp);
> +       if (ret)
> +               goto err_assert_resets;
> +
> +       return 0;
> +
> +err_assert_resets:
> +       reset_assert_bulk(&qmp->resets);
> +err_disable_vregs:
> +       qmp_usb3_legacy_vreg_disable(qmp);
> +
> +       return ret;
> +}
> +
> +static int qmp_usb3_legacy_probe(struct udevice *dev)
> +{
> +       struct qmp_usb3_legacy *qmp =3D dev_get_priv(dev);
> +
> +       qmp->dev =3D dev;
> +       qmp->cfg =3D (const struct qmp_usb3_legacy_cfg *)dev_get_driver_d=
ata(dev);
> +       if (!qmp->cfg) {
> +               dev_err(dev, "failed to get PHY configuration\n");
> +               return -EINVAL;
> +       }
> +
> +       return qmp_usb3_legacy_parse_dt(qmp);
> +}
> +
> +static struct phy_ops qmp_usb3_legacy_ops =3D {
> +       .power_on =3D qmp_usb3_legacy_power_on,
> +       .power_off =3D qmp_usb3_legacy_power_off,
> +};
> +
> +static const struct udevice_id qmp_usb3_legacy_ids[] =3D {
> +       {
> +               .compatible =3D "qcom,shikra-qmp-usb3-phy",
> +               .data =3D (ulong)&shikra_usb3phy_cfg,
> +       },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(qcom_qmp_usb3_legacy_phy) =3D {
> +       .name =3D "qcom-qmp-usb3-legacy-phy",
> +       .id =3D UCLASS_PHY,
> +       .of_match =3D qmp_usb3_legacy_ids,
> +       .ops =3D &qmp_usb3_legacy_ops,
> +       .probe =3D qmp_usb3_legacy_probe,
> +       .priv_auto =3D sizeof(struct qmp_usb3_legacy),
> +};
> --
> 2.34.1
>
