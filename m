Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B049606CD4D
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=b6bjC82m;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Oy81gKjN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NVXUy/ts
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3AA0C60892;
	Wed, 21 Oct 2026 16:18:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P8sM9NjICz28; Wed, 21 Oct 2026 16:18:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6F6BB60A35
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599532;
	b=GyhLXEZ2HkWldMsp2IwWI8iBEpNneTvyvFybOBbrt65dE227NhvGe6r+7hJlqE/eERAJ
	 AWF49SqgDrV0XMjoBKG+p43AQ6x+9GBbDHpHGFkAqul9GFrYXN/MBDCOIBfLfzDvrkzPL
	 9SZXn+oriIlQf2SCh6yqYQ2HiRhRPA5JueH/uYhfiLiVvNWnPoQGt4//k+rzk+wkz4+NB
	 Ta/aA/I+CwZmYyTeBpPm7uXuM5Zxi23eUxg3TjwK5mIIEHUGrNHv6aEL/4FO4K1YbbNIa
	 ppCKo+2/nmFu7D0VXko12qB4rzemwMfgU+95eKXEUwmGQO0/8AYdp1TndY7QQ5Wueqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599532;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FOlyG+70lIsSpdoc4NwQ6Bmb0m87HPK0wcxeuCCQz1c=;
	b=M0JIshJvijI4iySrqt8Sg8K6JxBWq0l/08jUS9sbK++1APDOgxRwioZvc5Xh2bvID44L
	 NMLMjiwIwLcwxNHKfcqVDCvK8+9BPF97pM+TNN2onu0ArKiZ5tLI04SPRbwzyVkYjn4y/
	 uMX5U/dEFL4pX/e123BGwplw5U+zk1iFWP98nLgbmh0MDOtvbuYIAIv7INYrDCyfnjp/B
	 Ptfibc+QFa94yGnXwHbX6BNy1f7mfPtcgqXWzLhPm+MRRE22JT1abJQzwK+wcSqIlFHgY
	 FL0fBGpbHFP0de+Paovv7FX/jyKaiDCc3Eh85QYYCXGVS8Kf7l4+LKAY3Df+tLuWZsQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Oy81gKjN;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="NVXUy/ts";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599532;
	bh=FOlyG+70lIsSpdoc4NwQ6Bmb0m87HPK0wcxeuCCQz1c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b6bjC82mzM/9NMcmRv1xv2tgj5twM+53L3bjDEswD6uFybkf1psL2gPkfjEFIuqqe
	 nWnyMUI0aNhIwPTFolnI//EoqAoNCKAlRdyGJYYn8C2HCoPk23iuivfW+UyCAl2z3o
	 Lj+KPrRp+S1Y0tJoUqlOaFwv0nCW1T3v+9sLw3Q5lAm3w3+Yq42KRu2sYEMYqAepUU
	 9FzLBYHlDd+yPoqKqf/SdnmHK0LAVEnDq4ogoj7iHBEchmwT6vGTKNbILJbtuLR057
	 gLWHSLFU6DTld9C7AQ+GNy2JMM4QLZT/qBEVaBdLQrN84TereLWgjE7TTZt4lFybxV
	 1F4xJnzKvTDaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F6BB60A35;
	Wed, 21 Oct 2026 16:18:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 64A6B356
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:18:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4A4F460A35
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:18:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r_v76cae6buW for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:18:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 89CD360892
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792599529;
 b=SUC3cUidwKZ89BXJIaODRtDZ5LaZyeHXyCEuNfCBiA8xO1OURl/LHa56sI24r8MjGyr6
 bul7AKfTC7/ui/kXsymDj3IctBZIj9KesOsuJLxkIoBiNdUm2O7IdC2zfeT+aImG8Ez+X
 A5sdIQtsKJxG05MldH65eVSe1bmKYS0j9PTKOJA4KD7NGoiGbyWsSoZ1gcR0/I9Lh8YsO
 4NXEwK5gX0MBvxhKQva0wKJGd2c6oWGldTmARXAMEqjLcDQBYGA7TtOEu5z5gcNrAlu/X
 3eBLsXXnBUzS8ee1chq0UQqypwcSXxgpvkqrHwVJGFGqJso0RtoArcvf+3lbdT8ROuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792599529;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=FOlyG+70lIsSpdoc4NwQ6Bmb0m87HPK0wcxeuCCQz1c=;
 b=pLNuXjzXF5Pf5ul9kSAtAZ2neKKwd4qw2jShFTHB8Q/AMHnRHONzIZMwpXyX5WsHcnQa
 wn+0aPV/6bYdf61pDKAJTS4otTtVa05dqEAXC+La4YXFpexWLf08jtatTJA/EVo5oifNZ
 Y8WSKBbjRCrvBMx7V/JmK8Bpf2qQk6VV7sYoBh/rx73jc4pssdjMvAmPBvJuHx0rZwOCn
 2WsROYHgvDjrvLIPwUgnp2a8K886nKnks3yXUCfj+lnrmPhmXjrobQOERR2O4fAowI4EQ
 hQOYxMCRos45TPtPgUpMtixZHTYtzFPJio/tCqb8M0QFIJ8ZwDckusaeLMRwsDCVIug==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Oy81gKjN; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="NVXUy/ts"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Oy81gKjN; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NVXUy/ts
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 89CD360892
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:18:49 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFU6B2141642
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FOlyG+70lIsSpdoc4NwQ6Bmb0m87HPK0wcxeuCCQz1c=; b=Oy81gKjN5VK9tVBR
 DrQ8+KU9XW/rP8E8dkJFf9JYTcp/cf6oXAHI6ebJ9O6s4zOWkw0FAg2+oXxF3p7N
 6Xr/PqXdIsrQIimE0/5bRf0DRc6TG9/JUYUF9QLcwhf2Iz0pie6UuDkm+rpN15UU
 JNYWG2i+beLZnD1/+4SZ9a9xJHza7ALaVtBPcmmW7PRzVJ9+tF+aoCHnF16AXrJ4
 cNdPmEmKulxBfuosevU9MHt1HcfY0/C0WinHvdKxCdZBTokCrETo4TaoqSoEvMyl
 rGCGwto0PBh0xFFEX48EWwf/O+1qUwKI4t6NF9FYUFL9eMKlgBrrZH0AQ++TEIJE
 353Hjw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex588te0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:18:48 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-351788121cfso3332053eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792599528; x=1793204328;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FOlyG+70lIsSpdoc4NwQ6Bmb0m87HPK0wcxeuCCQz1c=;
 b=NVXUy/tsm6d0oV4ku0BMXKNBhrA/BZLCRgxpHuVyeTeWBGMYdP/Q3eG8sdlEjjjHZU
 fOVAU/Ju0IzBgu3a/FJO2DlVBUq47Z2YZkQiy9DpGtQtJZXrpGlZs0cqqAaxKWhE1HYC
 mZaWDmaG/CB3KryYhkvcO6p3k1rf+A9dtEbftaKNSB0odBfgkTJJuVbsq6ptKaK+9pEU
 FA5+RTqeeUZGPFZJiY0lHczrUjSdAqx3b2g1bAUXonh1iJPFLb7yFIVxuvEgQxxVh+uq
 cvTOlP+4osk9JEmNCxPpxAhAvAYoTV+8jSZVuQNHrrE2TCcRMhqE1/VdjGvTagXiOZK/
 nclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792599528; x=1793204328;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FOlyG+70lIsSpdoc4NwQ6Bmb0m87HPK0wcxeuCCQz1c=;
 b=hajWaQQNp9/wR+P5MO1dVBy55ccCGqAUo1bQ1lGmJBhbmYBtrBjxSSrqy0GucQO1Wn
 F8Zv2Vz5MF6wg0lars42PyEyEGjynN2/AMIdHkvbVoWOnSWYEfHOF61yCtBozxcY3370
 c9AqVyWNsQ7yGnPMlxPefBEgJO8tIrsXknREV6q/3GhapinrlXPhrBoovolsA7JoRYnL
 ImiNvo6hDreqoju8FPLCR5K/EnbTfemxcO2bRVYCU5sYN3/to1Fgm7rl9qYvIC19qVln
 BPzqRQbDUoT+wA0M7T9IBtVUAKrsEte9Xn/P+gtL78xykJ0bM7EiW9TZILgBz7gYBPsI
 rMzA==
X-Gm-Message-State: AFq9FYKNG7klVnuSAiHj8ayduhpOLz9kF2XhWt7BGTMJZ7Lb6XMYD9eN
 LYgUe8t9A9X5voya9utrztQLTILT6qmE2nXL8TqsVd/Q9gOUbvaOssJECys2wNHEkFeJ64skcmp
 g4RoAKGE6pLfUWtryudBdw1BEqLNbBp0FChYnlUJqc0/WH+vKFV+KqoaulN1BYzUC5LAPJT8=
X-Gm-Gg: AYBFou39880Mht20H/Myn2dm7K2PjTRN4MOfvLgaFBpblNx8UXegoVENP6wBdlBiZDf
 4RsZ7O2QyDVqOaNOXnCFpi/8eQj3/9hCzoPF7a+kuIbQ2wNoWqVZKNemzQl4pDwTbqgjm0QF7JD
 FkWdoAISLplmttFnVs8qp5B4Q75z1Kwmf4Tu/oKvOizW/oUlF/TROkh0ozBg3enrTKnAJejCpOs
 X60i33JpI8Brp7QvQyUQtiQ7jcZ2IZAtQBjbJy5ryVZ0pN3Wdv+mm+UACrRrNLHdgFxhu3gMF3f
 REKI9cWd+wWzo3wafCMpqbTcmMPv3UkXnENZlvXC6iXT4W52zsx3FDQzOotZee3q+CWABXj8OxW
 QUB9VfRfIhk0T/ZKdsdsJ3w8/Y98NIHCR1iXiKHRmzQOlfxTtp5JixjLqQ2HDw4h+Iun8YT6sfe
 2Rn6g8WAbDPb46DJKQ/6JZ9Mzdb+k=
X-Received: by 2002:a05:693c:88d6:20b0:366:e24d:a0f6 with SMTP id
 5a478bee46e88-3674e93db10mr3709211eec.29.1792599527859; 
 Wed, 21 Oct 2026 09:18:47 -0700 (PDT)
X-Received: by 2002:a05:693c:88d6:20b0:366:e24d:a0f6 with SMTP id
 5a478bee46e88-3674e93db10mr3709177eec.29.1792599527302; 
 Wed, 21 Oct 2026 09:18:47 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36740cc88b5sm8764143eec.10.2026.10.21.09.18.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:18:46 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 21:48:22 +0530
Subject: [PATCH v9 3/8] arm: snapdragon: Disable MMU early before U-Boot
 reset vector
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-snagboot-v9-3-18ce3e431320@oss.qualcomm.com>
References: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
In-Reply-To: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599504; l=2642;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=kMXybNKBvme0kpiWoN1dRGVfV37kdSGtEZM3Wklaoi8=;
 b=976hB9YvDKSRNVAeuhf2YYy2w1u98c07d8PuiXTWIOsY0Kk3UUMlpUtr5GznwI2Mf4374nDhJ
 AOHi93K+xzCD4DVoJNFgc5FAWS5CwuiVLU/wftKBjW0g+WCaI5p9QzI
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX6uBEnObBAEkr
 4O64nKWKANVlzzhhtsTn6CBqM2Wa4iaoL4fb78aSxvYPK9/piBkP6ZZkt+h6R7FfXklv++2JhiK
 FhHcnfYv07/ySsT+QjnEnDZf451TYyI=
X-Proofpoint-GUID: qYtNQ3wiZ8nqXmJYbWNBU8axXgs75jA0
X-Proofpoint-ORIG-GUID: qYtNQ3wiZ8nqXmJYbWNBU8axXgs75jA0
X-Authority-Analysis: v=2.4 cv=Ku7YSmWN c=1 sm=1 tr=0 ts=6ad8e5e8 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=Q-CY8eKHVbgcYtpEucYA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX4SmrXD6x3EvM
 DT8domIXhRGQtOXROjYc2ILp5PK0kKurGighhvaNdQA4JUfSUMPcw2cE8V8Bvfi15CP5mTH0PhD
 tlajPF+y6nJfj0hSGt+3l8+Q5ntuuoPhe8f4d77LEdubrDj5vBZ5kdTZOkCXkxOyLTD4gLvNNN+
 wcuHjZiN8A7bk+/i+vI/4uy8d6K5z8JdKyJONS+5ORAA+FutbsG0PKez+gtDKp9GLHbvWp5ZCFM
 VwDWNwb5xpkXMfzwhHJ69h4Riy2Szvvx7fp5FEbmVvMz9CfIkyhknlDHgyy8r2cCTsUYomqB4OZ
 NIMXNkPueExXo7xaC0Z55eaWIOwIQJFxANFf3F7CGiAVf/ydYr8VxzLwfznMnEAaut0NAF3BDcM
 62Rsi2xSWD4pM79oGAg7zQFIxbekOyFHIvZEFsxUACxjIhoDUp0ukRA/c2nH2l4NRcBs0aiyM1v
 vtZ4c+KD7Y3hHFDZ6EA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
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

When U-Boot is loaded by XBL in Snagboot mode, XBL leaves the MMU
enabled with its own page tables. This causes stale TLB entries and
incorrect memory mappings when U-Boot initializes its own MMU.

Disable the MMU and invalidate TLBs before branching to the
reset vector. This ensures a clean MMU state for U-Boot initialization
in Snagboot mode.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v7:
- No changes

Changes iv v5:
- Clear C bit (Dcache enable) also during MMU disable

Changes iv v4:
- Remove handling for EL1 or EL2 entry as for Snagboot we would
  only enter U-Boot in EL3 from previous bootloader

Changes in v3:
- Brought the MMU disable logic under CONFIG_QCOM_SNAGBOOT_SUPPORT
  ifdef condition
- Moved the MMU disable codes to a new seperate file

Changes in v2:
- Newly introduced in v2
---
 arch/arm/mach-snapdragon/include/mach/boot0.h      |  2 ++
 .../mach-snapdragon/include/mach/snagboot_boot0.h  | 27 ++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm/mach-snapdragon/include/mach/boot0.h b/arch/arm/mach-snapdragon/include/mach/boot0.h
index b71aab37f44..ecef094629b 100644
--- a/arch/arm/mach-snapdragon/include/mach/boot0.h
+++ b/arch/arm/mach-snapdragon/include/mach/boot0.h
@@ -8,6 +8,8 @@
 #else
 #if defined(CONFIG_BOOT0_MSM8916_PSCI_WORKAROUND)
 #include "msm8916_boot0.h"
+#elif defined(CONFIG_QCOM_BOOT0_SNAGBOOT_MODE)
+#include "snagboot_boot0.h"
 #else
 	b	reset
 #endif
diff --git a/arch/arm/mach-snapdragon/include/mach/snagboot_boot0.h b/arch/arm/mach-snapdragon/include/mach/snagboot_boot0.h
new file mode 100644
index 00000000000..f82ee87c9b9
--- /dev/null
+++ b/arch/arm/mach-snapdragon/include/mach/snagboot_boot0.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Early MMU Disable for Snagboot Mode
+ *
+ * Disable MMU at the earliest possible point for EL3 entry.
+ * Snagboot mode always enters U-Boot at EL3.
+ *
+ * After disabling MMU, invalidate TLB to clear any stale entries that might
+ * cause issues when MMU is re-enabled later.
+ */
+
+	mrs	x0, CurrentEL
+	cmp	x0, #(3 << 2)	/* Verify EL3 entry */
+	b.ne	reset		/* Unexpected: not at EL3 */
+
+	/* Disable MMU at EL3 */
+	mrs	x0, sctlr_el3
+	bic	x0, x0, #1	/* Clear M bit (MMU enable) */
+	bic	x0, x0, #(1 << 2)   /* Clear C bit (Dcache enable) */
+	bic	x0, x0, #(1 << 19)  /* Clear WXN bit (Write XOR Execute) */
+	msr	sctlr_el3, x0
+	isb
+	/* Invalidate entire TLB for all ELs */
+	tlbi	alle3
+	dsb	sy
+	isb
+	b	reset
\ No newline at end of file

-- 
2.34.1

