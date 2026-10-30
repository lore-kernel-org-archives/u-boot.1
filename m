Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C9C606A31F
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 06:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qUXsOG2w;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GlOh+LcR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T+KOsgs8
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE2C8605CC;
	Fri, 30 Oct 2026 06:15:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zWmvQqa2NxMQ; Fri, 30 Oct 2026 06:15:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A53D960690
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793340957;
	b=LURqWYmuk3TmEG3f54q5Yd4dqU090ScNU3wIzE2UA9f2E0Gbv2pJff51W7X1pJpybEn2
	 eO+BNoqRsZCAeEu3W919Ot74OAGh9rK2xFjKLXvQRG5zdCleGATJeql0b3j42F+rSqS5/
	 9oFQ1HIv1PmV6LcqyI1dWJgYwTFxOsz+VnzpcFiV74ng35A1JOyNMR61CnkhWZLkYCcyJ
	 g4VIlkFJnm9mTAdgnjo805IxQHzCCkdKhfb6eBy0HcW1FWD6x/ATRjnf+WrKvovEx8ddk
	 cZrb6bfer53CNrW5zucAKMU7nTyvQjmvrkA3U59iNFKBWgXNlc641Dil5QphG25gAHQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793340957;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bLsWGTlwJ9Ep8Voxo4gkngRdn+IwqAgBud8oktXJrKs=;
	b=S3nRRF1hL6eTzp4ymjM0gwLIxwBUi+nEINfskUi3E+FhmnwoSNuFLPH1eot22xuix8MO
	 YAK65CKErjAxQJuarBw5U072oWaRfVJnvLRVdfqFOOI8MoA7xly3jmo/20onSqatFsw4H
	 HOgn5GKjzw4CjHpgCj0o9ZYOdZ+H0TX3N6J1TB/wkDxD6OcBQmik4DLqYEB72fsrd5es5
	 fNdmWcnl6K8Y1YsUrZ6BTglKyWBbymi/cITA0gYLuBj9nfG5t9yZyeavhQ//d5J6lbex/
	 GhFm6IvzKxjGo4rM28NKe8o1y4QBAyR5DbU2q7tn3nIhUGaU9+Z2gFd34uINA8DqcEA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793340957;
	bh=bLsWGTlwJ9Ep8Voxo4gkngRdn+IwqAgBud8oktXJrKs=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qUXsOG2wW4eu0GehZ8RlH0aaJCxE3Do6gXBSxc3y7Oc/xnN+qrObUhYO67W5XQmGp
	 s05OdSiNN/xKm7mF5sfQbYTgBQ91gfVO7uXcH1yKq8H4RCXLfN0z5aIFvxE87HPZiP
	 JkH0Iz3uXPQi8DIK02wZic2amSRZbfecw4JpWVmUhZxHQU3faEoicvC/p55dCxdEp2
	 KjBzkeJjbGzrelzLljPRbP00FtRCyaz/hNKR/nxstnsKkVnYYWDtghdhImTcPI0TiR
	 OoX0HYveu7rb1g7bOH9JnzAUCNTqwfT5f0YqmiIlsbJrxdATbwHrCmITDC7CYMhjza
	 rRqMJgmULe9oQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A53D960690;
	Fri, 30 Oct 2026 06:15:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D58A1362
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:15:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BBC9B810C2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:15:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5i5m35S3bYaK for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 06:15:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9382680BE6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793340955;
 b=SigsAEUDaU2rAzHnWw/SzhlDwnxgdB52CzFWWtLhHqlkEKzw8rFxsXydpJWlkS+iJd7t
 Y1DVJSrX6xc+hFvM25qiAdvzVMWSc+l96USBNeVfA5mxzv82vAjbNAj4wtGEDSLOHiSAD
 B7oAxejDonWGcXKtyqHBkeBftdBAdf/0QdI1np1ucFJWdurGqi3rRVoZ5L9M+yNwP2/Dp
 cEsiAoJtqVqwTKTNuDGqHy7mCgssFo55kwWw9dQT/egk2sKWKyl+tvQmcDLZfsnpgBNva
 SMWCvcHCn+LKllneu+167CvDvc5NX9qgzU3IRj+0xTp3W7eW+xrQLBFkNsc+IK9OTWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793340955;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=bLsWGTlwJ9Ep8Voxo4gkngRdn+IwqAgBud8oktXJrKs=;
 b=AP7hhhwJRcu08CSQkIw24bk/FaSdSNdDEqAz6beuOB2lcFbxUjI5CaRlyj5EQRT6o0Vr
 n5WKtasZfrNAx8zk2iAVtEOE7w2A3upHV5IKUl8jVN/edKi0SK9zGPWzN2oLXjdrjhDE/
 JtG73MCSpyqg8DZNMyKNpQCccLHWtBi79rPydCPfWH8bsSJzGhkXlCSCgz/Y3kGkM3UVw
 Fl5aJ5QJ1Up4lIVWFc7G/Kj9tTiR+vUj5YjEbseMrzpGaRVHV+D84IdTZauBmeaV7RTJj
 dXsv9cwVrqN3rF/FKEFYybzsnz852DXXbzPrc+d78ZaSBSihJX5cP6NkanpnLNPBauA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=GlOh+LcR; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=T+KOsgs8; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=sumit.dhami@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=GlOh+LcR; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=T+KOsgs8
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9382680BE6
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:15:55 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U5F9ht2913268
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=bLsWGTlwJ9Ep8Voxo4gkngRdn+IwqAgBud8
 oktXJrKs=; b=GlOh+LcRr9+nyis37Fk9V9x5mtok64lH2JqPd0+vQ3Lezc5TEBk
 t7K/CPpmeXJGYJeyp0MxejY1mJwoVOuAPvHBCqCumpMaQwWWw04W2r+eIFBGvTCJ
 ygYbA/y8JpsDfTP97EPmbvXRDAS8N6hPu/Ky25cCrAkltepO9ZSxum1sjeI5cLCe
 2e2ljyKpTKtXe0L2irgqLAk/ka45vcgWxo0g9wlvRkPHf7G2I47J0QPqgYu+o6/k
 7Ejp8F5HJMIaBgTCJSLdiuvHHgYWSUaRkYarFTi8Ra7r9OshMO4eF/e2NGEl0ZmI
 8s9NsTWCHnOi8F+gRkNpjj4mR4jieMVdWxQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qsg9s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:15:53 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3698bd5392cso416364eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 23:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793340953; x=1793945753;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bLsWGTlwJ9Ep8Voxo4gkngRdn+IwqAgBud8oktXJrKs=;
 b=T+KOsgs8QefNOMT3l9wjqiqYwdNo98HI2MZQKhf4ZpmmN+7vzEtk9miKkCa/9giBit
 +fmCbLmjf5GSl4H7XJDUfh+f6EaUaumz0XHNTG3DH9CBbp1fxTAph5ijQugZrTA+irv3
 BPH8R4juNFke9Tzj5gW0a0EiRqg2mwNVvHa051qRZhfyAbRFj2dvK8NBu+M5N6oykFJg
 7eiQT/wNsK2wttiAXZYPwgfi6uV1X2LuB1YgEgjMadudQ+61PxYYX+b/lLOWj0/2T9Yg
 pBKYOtJIRmXaJJi9UuD7cTJIZW93cGu0rOjrj5VSuD4UHooPo2L71yM6jNU2Ox2P9VdI
 1vTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793340953; x=1793945753;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bLsWGTlwJ9Ep8Voxo4gkngRdn+IwqAgBud8oktXJrKs=;
 b=BDE9h63N56y0iYyq9SZyo+DggeVtSaP9pDKGKFmhuA72W2P8hTyqihMDCrrA9C6dZj
 ilKu5aN6ZmUcvabWskDz5UTGk7/TYaGzbd6JtJZ+l5+zQA26Wowy7IsrhirB71TdHojD
 tM2VlGOU0hwCDpo06oPBi+1WDlR0lj7rlagz2t+bfvdrLXIVWw062gHwvJhUQxbf6b+r
 q/cVWfqYeCnwDeZKT5h8qkcRCntgUXA6UkX0UdgF7ag3hzMy/UWnk9x5/REqaw4klY2R
 cn/cKrKxF7V/We24/laNIbJk42a2w4BCpPQLKqT5Rowu/En2fTobZMn+opZ/HekY0Uab
 zQeA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzjsytjFFMWKIAQKDOUFo05kj06Y0ggnZCBp+AXwGnIomu+K/vDC//1hrppMN7Z1F3ifKIQl6s=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLn3kkDuzJVIUJlkybqcM/9zPVd26IL6iueQzPvFPhm4RXn7YDG
 XnlA7sZIvz2Uy0qet4XGOSV/dvgVQN2m7vKQZd8m+t0l8XMmJAkA4zhzksVjBNxZFmw2M8QI9WL
 /ZAC4zdVtU4fyI+PbHjFYA1cSKVtGA0qZyBnH55U0Yx8myWiAKffIGMGNOTEdPQZmASwDTsJF3G
 veTkE=
X-Gm-Gg: AYBFou2sUP63JXP5WuMq9KLBw+OaG1axp1+DYnWw0uUYlVHM2awoiwEz3xcVLcNQE2l
 dYEX2PI5GwPbGEt6oblIgfJegvulz4c+ExKEzceih/dN5A5fRmYxGM0mDmKlgy9BHqm9oACGoU8
 0+v1G3p8RhCHkAH5JNkyMezcZzQefCB99dvtBTnLzXKzQs0Hv4bvaBJGL5U79H7WeBTzsTFUAE/
 Zc/BaYt0u/jB3X0eEq242Ra/S1U8vIEG8XZ6IfpCgP1oUsvaJqqeq4xyS86yZ7Am6MHT+EWe7wF
 2H1oXcIV6SBcGCZ3mawg1DUg3nKnRpV+U9TeREceNsP6Oo7GI0KDGzE9aeTHf2i+6HCyysBi4xx
 TZxm3tsYYaMg2umd5lMVpZlJKpqrop3noDeWNKI6xNtMB69igZ51tliNaJL2fpgTCSgPxG37Bv2
 j58oGu/ppEPmjYuv75zaPU7Aw7kDSrDTJIjpyCr+XcbgOFi9ELnYAd6dRZ2gdFd7nuTw==
X-Received: by 2002:a05:693c:61dc:b0:36a:1a7b:d1bb with SMTP id
 5a478bee46e88-36a300756bcmr8103213eec.22.1793340952591; 
 Thu, 29 Oct 2026 23:15:52 -0700 (PDT)
X-Received: by 2002:a05:693c:61dc:b0:36a:1a7b:d1bb with SMTP id
 5a478bee46e88-36a300756bcmr8103173eec.22.1793340951920; 
 Thu, 29 Oct 2026 23:15:51 -0700 (PDT)
Received: from hu-sdhami-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428c17bdsm4263309eec.6.2026.10.29.23.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 23:15:51 -0700 (PDT)
From: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 Michael.Srba@seznam.cz, aswin.murugan@oss.qualcomm.com,
 sumit.dhami@oss.qualcomm.com, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Subject: [PATCH v1] mach-snapdragon: Add EFI fallback for reading FIT overlay
 identifiers
Date: Fri, 30 Oct 2026 11:45:42 +0530
Message-ID: <20261030061542.2727273-1-sumit.dhami@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: f6M5AOJypqVe4uwOcQOYQ7NNbFuUK6_N
X-Proofpoint-ORIG-GUID: f6M5AOJypqVe4uwOcQOYQ7NNbFuUK6_N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAyNCBTYWx0ZWRfX6692MnNoCJi1
 n4s3mtipi1HHsf46NuPCWhZSSnjcXNlqGt9ZLaKFGhnFuK6u6znBbWQu4hExEvNprtXQZuGFYZx
 4Q4MPYM24lGhGMnERdtWCtAg/B1N7bowtZc2u63eDxyI4OjLswJ/tvehBW6quIeYnbs9dx9v/bP
 zTHKn1yQVv66CywTA8ClO4yjuXvHzoVeOCmJsJrSq+3rGPjA+O8n/EDI+46y0riHIkXUAgXr8FH
 IXdePCmTuppCVIDceqB1NczhFOWdk6ld8gJfoDCQNyJXyH8w13DJvCoT99y2pf/5GwfcsPBeI51
 oqLEXD9CKQHJiTY4wRLKM1Xfen2g4mIrB68f6QsVwQHGZXCEW9qGaCgxL7rKb13XJgJmduFI9jS
 Wn618mmW9JwNNqSlrdM9s4zbNKFlIKvQiXYvwpRmUWe7aVl146A3Ldto0gg8PawZx7ZjTahkMND
 2xF8TzoiSocyXbWMO+g==
X-Authority-Analysis: v=2.4 cv=dPgzC+Zb c=1 sm=1 tr=0 ts=6ae4361a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=wnU9-HwmyokoMoL3S60A:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAyNCBTYWx0ZWRfXzudHwpw3vRYE
 07OqQ0RtjYytS8dPPJSHkNtdOTyRDV6K+mgomWFVfxsdjX+4bbyNtqqr2YOxANpoZya8caRfwfk
 +Hgtu0D9jRVV29brgYwe6cM+96r2arY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300024
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,KHOP_DYNAMIC,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Read the VendorDtbOverlays EFI variable when the vendor_dtbo environment
variable is unavailable. Use the EFI-provided overlay identifiers during
FIT multi-DTB configuration matching.

Move QCOM FIT multi-DTB selection to EVT_POST_PREBOOT so EFI variables
can be initialized successfully before they are read.

Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
---
This patch extends the FIT multi-DTB support introduced by Aswin Murugan's
series: https://lore.kernel.org/u-boot/20261012170754.1606314-1-aswin.murugan@oss.qualcomm.com/
---
 arch/arm/mach-snapdragon/board.c             |   6 -
 arch/arm/mach-snapdragon/qcom_fit_multidtb.c | 175 +++++++++++++++++--
 arch/arm/mach-snapdragon/qcom_fit_multidtb.h |  18 --
 3 files changed, 161 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 9bfb7183241..055ef6b8221 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -453,11 +453,5 @@ int board_late_init(void)
 	/* Configure the dfu_string for capsule updates */
 	qcom_configure_capsule_updates();
 
-	/* Try FIT multi-DTB selection if enabled */
-	if (IS_ENABLED(CONFIG_QCOM_FIT_MULTIDTB)) {
-		if (qcom_fit_multidtb_setup())
-			log_debug("FIT multi-DTB selection not available or failed\n");
-	}
-
 	return 0;
 }
diff --git a/arch/arm/mach-snapdragon/qcom_fit_multidtb.c b/arch/arm/mach-snapdragon/qcom_fit_multidtb.c
index 45423910d34..40f660b453b 100644
--- a/arch/arm/mach-snapdragon/qcom_fit_multidtb.c
+++ b/arch/arm/mach-snapdragon/qcom_fit_multidtb.c
@@ -27,6 +27,11 @@
 #include "qcom_fit_multidtb.h"
 #include "qcom_hwdetect.h"
 
+#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
+#include <efi_loader.h>
+#include <efi_variable.h>
+#endif
+
 /* GPT partition name containing the FIT image */
 #define QCOM_FIT_PARTNAME	"dtb_a"
 
@@ -60,6 +65,10 @@
 #define PROP_FDT               "fdt"
 #define PROP_DATA              "data"
 
+#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
+#define QCOM_VENDOR_DTBO_EFIVAR_MAX_LEN	256
+#endif
+
 /**
  * struct overlay_entry - Gathered overlay FDT image info
  * @name: Overlay image name in the FIT
@@ -72,6 +81,122 @@ struct overlay_entry {
 	size_t size;
 };
 
+#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
+
+/* Qualcomm VendorDtbOverlays UEFI variable. */
+static const u16 qcom_vendor_dtbo_efivar_name[] = u"VendorDtbOverlays";
+
+static const efi_guid_t qcom_vendor_dtbo_efivar_guid =
+	EFI_GUID(0x882f8c2b, 0x9646, 0x435f,
+		 0x8d, 0xe5, 0xf2, 0x08, 0xff, 0x80, 0xc1, 0xbd);
+
+/**
+ * qcom_efivar_payload_to_str() - Convert a efi variable payload to a C string
+ * @data: Payload bytes, ASCII or UTF-16LE restricted to ASCII characters
+ * @len: Payload length in bytes
+ * @out: Returns a malloc()'d NUL-terminated string
+ *
+ * The payload is detected as UTF-16LE when its length is even and every odd
+ * byte is zero. A single trailing NUL (character) is tolerated in both forms.
+ *
+ * Return: 0 on success, -ENOENT if empty, -EINVAL if it contains an
+ *	   embedded NUL, -ENOMEM on allocation failure
+ */
+static int qcom_efivar_payload_to_str(const u8 *data, size_t len, char **out)
+{
+	bool utf16 = false;
+	size_t i, n;
+	char *str;
+
+	if (len >= 2 && !(len & 1)) {
+		utf16 = true;
+		for (i = 1; i < len; i += 2) {
+			if (data[i]) {
+				utf16 = false;
+				break;
+			}
+		}
+	}
+
+	/* Number of characters */
+	n = utf16 ? (len >> 1) : len;
+
+	/* Tolerate a single trailing NUL */
+	if (n && !data[utf16 ? 2 * (n - 1) : n - 1])
+		n--;
+
+	if (!n)
+		return -ENOENT;
+
+	str = malloc(n + 1);
+	if (!str)
+		return -ENOMEM;
+
+	if (utf16) {
+		for (i = 0; i < n; ++i)
+			str[i] = data[i << 1];
+	} else {
+		for (i = 0; i < n; ++i)
+			str[i] = data[i];
+	}
+
+	str[n] = '\0';
+
+	/* An embedded NUL would silently truncate the token list */
+	if (strlen(str) != n) {
+		free(str);
+		return -EINVAL;
+	}
+
+	*out = str;
+
+	return 0;
+}
+
+/**
+ * qcom_get_vendor_dtbo_from_efivar() - Reads VendorDtbOverlays efi variable
+ * @out: Returns a malloc()'d NUL-terminated token string
+ *
+ * Return: 0 on success, error code on failure
+ */
+static int qcom_get_vendor_dtbo_from_efivar(char **out)
+{
+	u8 data[QCOM_VENDOR_DTBO_EFIVAR_MAX_LEN];
+	efi_uintn_t data_size = sizeof(data);
+	u32 attributes;
+	u64 timep;
+	int ret = -ENOENT;
+	efi_status_t status;
+
+	status = efi_init_obj_list();
+	if (status) {
+		log_err("Failed to initialize EFI variables: %lx\n", status);
+		return -EIO;
+	}
+	status = efi_get_variable_int(qcom_vendor_dtbo_efivar_name,
+				      &qcom_vendor_dtbo_efivar_guid,
+				      &attributes,
+				      &data_size,
+				      data,
+				      &timep);
+	if (status) {
+		log_err("Failed to read EFI VendorDtbOverlays: %lx\n", status);
+		if (status == EFI_NOT_FOUND)
+			return -ENOENT;
+		else if (status == EFI_BUFFER_TOO_SMALL)
+			return -E2BIG;
+		else
+			return -EINVAL;
+	}
+	ret = qcom_efivar_payload_to_str(data,
+					 data_size,
+					 out);
+	if (ret)
+		log_err("EFI variable VendorDtbOverlays contains invalid data\n");
+	return ret;
+}
+#endif
+
 /**
  * add_to_bucket() - Add a node name to the bucket list
  * @name: Node name to add
@@ -348,26 +473,40 @@ static int qcom_add_dtbo_tokens(const char *str, struct list_head *bucket_head)
 }
 
 /**
- * qcom_parse_vendor_dtbo() - Parse vendor_dtbo environment variable
+ * qcom_parse_vendor_dtbo() - Parse the vendor DTBO overlay identifiers
  * @bucket_head: Bucket list to add overlay tokens to
  *
- * Reads the "vendor_dtbo" environment variable and parses its comma-separated
- * overlay identifiers, adding them to the bucket list for FIT configuration
- * matching. This influences which FIT configuration is selected.
+ * Reads the comma-separated overlay identifiers from the "vendor_dtbo"
+ * environment variable falling back to the "VendorDtbOverlays" EFI variable.
+ * Adds the identifiers read to the bucket list for FIT configuration matching.
+ * This influences which FIT configuration is selected.
  *
- * Return: 0 on success, negative error code on failure or if unset
+ * Return: 0 on success, negative error code on failure
  */
 static int qcom_parse_vendor_dtbo(struct list_head *bucket_head)
 {
-	const char *vendor_dtbo;
+	const char *vendor_dtbo_env;
+	int ret = -ENOENT;
 
-	vendor_dtbo = env_get("vendor_dtbo");
-	if (!vendor_dtbo || !*vendor_dtbo)
-		return -ENOENT;
+	vendor_dtbo_env = env_get("vendor_dtbo");
+	if (vendor_dtbo_env && *vendor_dtbo_env) {
+		log_info("ENV vendor_dtbo data: %s\n", vendor_dtbo_env);
+		return qcom_add_dtbo_tokens(vendor_dtbo_env, bucket_head);
+	}
 
-	log_info("vendor_dtbo: %s\n", vendor_dtbo);
+#if (CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE))
+	{
+		char *vendor_dtbo_overlay_efi = NULL;
 
-	return qcom_add_dtbo_tokens(vendor_dtbo, bucket_head);
+		ret = qcom_get_vendor_dtbo_from_efivar(&vendor_dtbo_overlay_efi);
+		if (!ret) {
+			log_info("EFI vendor_dtbo data: %s\n", vendor_dtbo_overlay_efi);
+			ret = qcom_add_dtbo_tokens(vendor_dtbo_overlay_efi, bucket_head);
+			free(vendor_dtbo_overlay_efi);
+		}
+	}
+#endif
+	return ret;
 }
 
 /**
@@ -917,9 +1056,9 @@ free_overlays:
  * 6. Load DTB and apply overlays
  * 7. Install FDT for EFI
  *
- * Return: 0 on success, negative error code on failure
+ * Return: 0 always, to prevent boot failure
  */
-int qcom_fit_multidtb_setup(void)
+static int qcom_fit_multidtb_setup(void)
 {
 	void *fit = NULL;
 	size_t fit_size = 0;
@@ -1029,5 +1168,13 @@ cleanup_fit:
 	if (fit)
 		free(fit);
 
-	return ret;
+	if (ret)
+		log_err("FIT multi-DTB selection not available or failed\n");
+
+	return 0;
 }
+
+/* Try FIT multi-DTB selection if enabled */
+#if CONFIG_IS_ENABLED(QCOM_FIT_MULTIDTB)
+EVENT_SPY_SIMPLE(EVT_POST_PREBOOT, qcom_fit_multidtb_setup);
+#endif
diff --git a/arch/arm/mach-snapdragon/qcom_fit_multidtb.h b/arch/arm/mach-snapdragon/qcom_fit_multidtb.h
index 00b6d935a4a..4929930e060 100644
--- a/arch/arm/mach-snapdragon/qcom_fit_multidtb.h
+++ b/arch/arm/mach-snapdragon/qcom_fit_multidtb.h
@@ -40,22 +40,4 @@ enum node_process_type {
 	NODE_TYPE_SOFTSKU,
 };
 
-/* Function prototypes */
-
-/**
- * qcom_fit_multidtb_setup() - Main entry point for FIT multi-DTB selection
- *
- * This function:
- * 1. Loads qclinux_fit.img from EFI partition
- * 2. Extracts metadata DTB
- * 3. Detects hardware parameters from SMEM
- * 4. Builds bucket list from metadata
- * 5. Finds matching FIT configuration
- * 6. Loads DTB and applies overlays
- * 7. Sets FDT for EFI
- *
- * Return: 0 on success, negative error code on failure
- */
-int qcom_fit_multidtb_setup(void);
-
 #endif /* __QCOM_FIT_MULTIDTB_H__ */
---
base-commit: dfcfc4c9f78d1743f490a497082a4ec8e058aae8
prerequisite-patch-id: 288b5e1177317e5684aa37b877adaae1ecb87611
prerequisite-patch-id: 52c8de1a3d51dcb7487bc8252603fe89e731000f
prerequisite-patch-id: a9eaa119a8d0fc81394544f5cdbfb125726e9f57
prerequisite-patch-id: 48ad0bec210dfc2dfae8e1e69c831cc96073c1e3
prerequisite-patch-id: feacdbb3eb20691078dca1928afe7359f5eb181e
-- 
Best regards,
Sumit Singh Dhami

